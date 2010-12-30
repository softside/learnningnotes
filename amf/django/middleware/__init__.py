# vim: fileencoding=utf8

import logging
import re
import types
import hashlib
import amf, amf.utils, amf.django
from django.conf import settings
from django.http import HttpResponse, HttpResponseForbidden
from django.db.models.query import QuerySet
from django.core import exceptions, urlresolvers

class AMFMiddleware(object):

    CONTENT_TYPE = 'application/x-amf'
    AUTO_MAPPING_VIEW_NAME = 'amf.django.views'

    def __init__(self):
        """Initialize AMFMiddleware."""
        self.init_logger()
        self.init_class_mapper()
        self.init_timezone()
        self.init_read_options()

        self.gateway_path = getattr(settings, 'AMF_GATEWAY_PATH', '/gateway/')
        if not self.gateway_path:
            msg = "'AMF_GATEWAY_PATH' is not set in 'settings.py'"
            amt.utils.logger().fatal(msg)
            raise AttributeError, msg
        self.matcher = re.compile(r"^%s.+" % (self.gateway_path))
        amf.utils.logger().debug("AMFMiddleware was initialized.") 

    def init_timezone(self):
        amf.utils.timeoffset = getattr(settings, 'AMF_TIME_OFFSET', None)

    def init_class_mapper(self):
        mapper_name = getattr(settings, 'AMF_CLASS_MAPPER', None)
        if mapper_name:
            amf.utils.logger().debug("Init AMF class mappings.")
            try:
                mapper = amf.utils.get_module(mapper_name)
            except ImportError:
                msg = "AMF_CLASS_MAPPER module is not found. [module='%s']" % (mapper_name,)
                amf.utils.logger().fatal(msg)
                raise ImportError(msg)

            if mapper and getattr(mapper, 'amf_class_mappings', False):
                mappings = mapper.amf_class_mappings()
                if isinstance(mappings, dict):
                    amf.utils.class_mappings.update(mappings)
                else:
                    msg = "The return value of amf_class_mappings() is not a dictionary type. [type='%s']" % (type(mappings),)
                    amf.utils.logger().fatal(msg)
                    raise TypeError(msg)
            else:
                msg = "'amf_class_mappings' function is not defined in AMF_CLASS_MAPPER module. [module='%s']" % (mapper_name,)
                amf.utils.logger().fatal(msg)
                raise AttributeError(msg)

    def init_logger(self):
        """Build custom logger instance for AMF handling."""
        # TODO: Logging time is not a local time
        file = getattr(settings, 'AMF_LOG_FILE', None)
        mode = getattr(settings, 'AMF_LOG_FILE_MODE', 'a')
        encoding = getattr(settings, 'AMF_LOG_FILE_ENCODING', 'utf8')
        loglevel = getattr(settings, 'AMF_LOG_LEVEL', 'INFO')

        logger = logging.getLogger('AMF')
        logger.setLevel(logging.__dict__[str(loglevel).upper()])
        if file:
            handler = logging.FileHandler(filename=file, mode=mode, encoding=encoding)
            formatter = logging.Formatter('%(asctime)s - %(name)s %(filename)s(%(lineno)d) [%(levelname)s] %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
        amf.utils.set_logger(logger)

    def init_read_options(self):
        self.read_options = {}
        if getattr(settings, 'AMF_NUMBER_TO_INT', False):
            self.read_options['number_to_int'] = True

    def process_request(self, request):
        if self.matcher.match(request.path): # Invalid access
            return HttpResponseForbidden()
        elif request.method == 'POST' and \
                request.path == self.gateway_path and \
                (request.META.get('HTTP_CONTENT_TYPE') == AMFMiddleware.CONTENT_TYPE or request.META.get('CONTENT_TYPE') == AMFMiddleware.CONTENT_TYPE):
            # Deserialize AMF message
            request_message = amf.read(request.raw_post_data, self.read_options)

            #if request_message.use_cache: # Get cached data
            #    key = request_message._get_cache_key()
            #    if key:
            #        from django.core.cache import cache
            #        cached_response = cache.get(key)
            #        if cached_response: # If cached data found, return it
            #            return cached_response

            self.set_credentials(request_message, request)

            # Build AMF response message
            response_message = amf.AMFMessage()
            response_message.version = request_message.version
            for request_body in request_message.bodies:
                res_body = self.process_request_message_body(request, request_body)
                response_message.add_body(res_body)
            self._add_response_headers(response_message)
            # Serialize AMF message
            response_data = amf.write(response_message)
            response = HttpResponse(response_data, AMFMiddleware.CONTENT_TYPE)
            response['Content-Length'] = str(len(response_data))

            #if request_message.use_cache: # Cache response data
            #    key = request_message._get_cache_key()
            #    if key:
            #        from django.core.cache import cache
            #        cache.set(key, response, request_message.cache_timeout)

            return response

    def __find_callback_method_by_path(self, path):
        resolver = urlresolvers.RegexURLResolver(r'^/', settings.ROOT_URLCONF)
        callback, callback_args, callback_kwargs = resolver.resolve(path)
        # Find callback method for auto method mapping.
        if callback.__module__ + '.' + callback.__name__ == self.AUTO_MAPPING_VIEW_NAME:
            callback = self.find_callback_method(callback_args, callback_kwargs)
        return callback

    def need_check_sig(self, fpath, fname):
        return False
        if fname in ('catchFishCompleteLevelAMF',
            'catchFishGiveUpLevelAMF',
            'harvestAMF',
            ):
            return False
        if fpath.startswith('/gateway/amfService') or fpath.startswith('gateway/amfService'):
            return True
        else:
            return False
            
    def verify_sig(self, args, sig):
        args_tmp = args[:]
        args_tmp.reverse()
        vals = []
        for val in args_tmp:
            if isinstance(val, float):
                val = str(int(val))
            elif isinstance(val, unicode):
                val = val.encode('utf-8')
            elif isinstance(val, bool):
                val = str(val).lower()
            elif not isinstance(val, str):
                val = str(val)
            vals.append(val)
        vals.append(sig[10:18])
        keystr = ''.join(vals)
        my_sig = hashlib.md5(keystr).hexdigest()
        my_sig = '%s%s%s' % (my_sig[:10], sig[10:18], my_sig[10:])
        
        return my_sig[:-8]==sig
        
    def __invoke(self, path, request, request_body, args=None):
        """Invoke the given callback function.
        'request_body.args' are passed as function parameters.

        """
        try:
            callback = self.__find_callback_method_by_path(path)
            fname = callback.func_name
            if args is not None:
                if self.need_check_sig(path, fname):
                    sig = request_body.args[0]
                    args = request_body.args[1:]
                    #print '1: sig=%s, args=%s' % (sig, args)
                    
                    if self.verify_sig(args, sig):
                        result = callback(request, *args)
                    else:
                        result = {'error':'sig code error'}
                else:
                    result = callback(request, *args)
            else:
                if self.need_check_sig(path, fname):
                    sig = request_body.args[0]
                    args = request_body.args[1:]
                    #print '2: sig=%s, args=%s' % (sig, args)
                    
                    if self.verify_sig(args, sig):
                        result = callback(request, *args)
                    else:
                        result = {'error':'sig code error'}
                else:
                    result = callback(request, *request_body.args)
        except AttributeError, e:
            msg = "Cannot find a view for the path ['%s'], %s" % (path, e)
            raise amf.AMFProcessingError(
                    response_num=request_body.response,
                    type=e.__class__.__name__,
                    description=msg,
                    details=msg,
                    code=500
                    )
        except amf.AMFAuthenticationError, e:
            msg = "Exception was thrown when executing remoting method.(%s) [method=%s, args=%s]" % (e, callback.__module__ + "." + callback.__name__, repr(request_body.args))
            raise amf.AMFProcessingError(
                    response_num=request_body.response,
                    type=e.__class__.__name__,
                    description=str(e),
                    details=msg,
                    code=401
                    )
        except Exception, e:
            msg = "Exception was thrown when executing remoting method.(%s) [method=%s, args=%s]" % (e, callback.__module__ + "." + callback.__name__, repr(request_body.args))
            self._send_error_mail(request, msg)
            raise amf.AMFProcessingError(
                    response_num=request_body.response,
                    type='AMFRuntimeException',
                    description=str(e),
                    details=msg,
                    code=500
                    )
        # Convert django's QuerySet object into an array of it's containing objects.
        if isinstance(result, QuerySet):
            result = list(result)
        return result

    def process_request_message_body(self, request, request_body):
        service_method_path = request_body.service_method_path

        if service_method_path == 'null/null': # RemoteObject Message
            from amf.messaging import *
            msg = request_body.args[0]
            if isinstance(msg, CommandMessage):
                if msg.operation == CommandMessage.CLIENT_PING_OPERATION:
                    resMsg = AcknowledgeMessage(correlationId=msg.messageId)
                    res_target = request_body.response + amf.RESPONSE_RESULT
                    return amf.AMFMessageBody(res_target, 'null', resMsg)
            elif isinstance(msg, RemotingMessage):
                service_method_path = msg.destination + '/' + msg.operation
                args = msg.body
                path = request.path + service_method_path
                try:
                    ret = self.__invoke(path, request, request_body, args)
                    resMsg = AcknowledgeMessage(correlationId=msg.messageId, body=ret)
                    res_target = request_body.response + amf.RESPONSE_RESULT
                    return amf.AMFMessageBody(res_target, 'null', resMsg)
                except amf.AMFProcessingError, e:
                    errorMsg = ErrorMessage(correlationId=msg.messageId, 
                            faultString=e.description,
                            faultDetail=e.details
                            )
                    res_target = request_body.response + amf.RESPONSE_STATUS
                    return amf.AMFMessageBody(res_target, 'null', errorMsg)
            else:
                amf.utils.logger().error("Unsupported remoting message. [type='%s']", type(msg))
                errorMsg = ErrorMessage(correlationId=msg.messageId, 
                        faultString='Unsupported message.',
                        faultDetail='Unsupported message.'
                        )
                res_target = request_body.response + amf.RESPONSE_STATUS
                return amf.AMFMessageBody(res_target, 'null', errorMsg)
        else:
            path = request.path + service_method_path
            try:
                result = self.__invoke(path, request, request_body)
                res_target = request_body.response + amf.RESPONSE_RESULT
                return amf.AMFMessageBody(res_target, 'null', result)
            except amf.AMFProcessingError, e:
                return e.getAMFMessageBody()


    def _get_traceback(self, exc_info=None):
        """Helper function to return the traceback as a string"""
        import traceback
        return '\n'.join(traceback.format_exception(*(exc_info or sys.exc_info())))

    def find_callback_method(self, callback_args, callback_kwargs):
        mod = callback_kwargs['views']
        if isinstance(mod, types.StringTypes):
            mod_name = mod
            mod = amf.utils.get_module(mod_name)
        elif isinstance(mod, types.ModuleType):
            mod_name = mod.__name__
        else:
            amf.utils.logger().error("The type of 'views' value for amf.django.views is invalid.")
            raise TypeError
        method_name = callback_args[0]
        amf.utils.logger().debug("Using auto method mapping. [module='%s', method='%s']", mod_name, method_name)
        callback = getattr(mod, method_name)
        return callback

    def set_credentials(self, request_message, request):
        """
        If the request amf message has headers for credentials, set them to
        the given request object.

        The request object has an attribute named 'amfcredentials' which is a
        dict holding two keys, 'username' and 'password'.

        request.amfcredentials.get('username')
        request.amfcredentials.get('password')
        """
        username = request_message.get_header("credentialsUsername")
        password = request_message.get_header("credentialsPassword")
        if username is not None and password is not None:
            request.amfcredentials = {'username':username, 'password':password}

    def _add_response_headers(self, message):
        for h in amf.django.get_response_headers():
            message.add_header(h)

    def _send_error_mail(self, request, msg):
        """Send error mail to admins.
        """
        if not settings.DEBUG:
            from django.core.mail import mail_admins
            import sys
            exc_info = sys.exc_info()
            subject = 'Error (%s IP): %s' % ((request.META.get('REMOTE_ADDR') in settings.INTERNAL_IPS and 'internal' or 'EXTERNAL'), "<AMF gateway> " + request.path)
            try:
                request_repr = repr(request)
            except:
                request_repr = "Request repr() unavailable"
            message = """%s

----------------------------------------------------------------------------
Traceback
----------------------------------------------------------------------------
%s

----------------------------------------------------------------------------
Request
----------------------------------------------------------------------------
%s
""" % (msg, self._get_traceback(exc_info), request_repr)
            mail_admins(subject, message, fail_silently=True)
