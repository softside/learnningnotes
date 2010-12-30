# vim: fileencoding=utf8
from __init__ import AMFMessage, AMFMessageBody, RESPONSE_STATUS, write, read
import urllib2

class RPCServiceInvocationError(Exception):

    def __init__(self, result, faultString='', faultDetail='', faultCode=''):
        self.result = result
        self.faultString = faultString
        self.faultDetail = faultDetail
        self.faultCode = faultCode

    def __str__(self):
        return repr(self.faultString)


class RPCMethodCall(object):

    def __init__(self, func, methodName, requestCount=1):
        self.func = func
        self.methodName = methodName
        self.requestCount = requestCount

    def __call__(self, *args):
        return self.func(self.methodName, self.requestCount, args)
        

class RemotingService(object):

    def __init__(self, gatewayUrl, serviceName, version=3):
        self.serviceName = serviceName
        self.gatewayUrl = gatewayUrl
        if not version == 3 and not version == 0:
            raise ValueError, 'Version must be 0 or 3.'
        self.__version__ = version
        self.username = None
        self.password = None
        self.requestCount = 0

    def __repr__(self):
        return 'amf.RemotingService(%r, %r, %r)' % (self.gatewayUrl, self.serviceName, self.__version__)

    def setCredentials(self, username, password):
        self.username = username
        self.password = password

    def __getattr__(self, name):
        self.requestCount += 1
        return RPCMethodCall(self._invoke_amf_rpc, name, self.requestCount)

    def _post_amf_request(self, postdata):
        """
        Send the serialized AMF request message to the gateway url,
        and return the response data from the server.
        The returned value is not deserialized.
        """
        req = urllib2.Request(url=self.gatewayUrl, data=postdata)
        req.add_header('Content-type', 'application/x-amf')
        f = urllib2.urlopen(req)
        rawData = f.read()
        f.close()
        return rawData

    def _invoke_amf_rpc(self, methodName, requestCount, args):
        requestAMFMessage = self.__build_amf_message(methodName, requestCount, args)
        postdata = write(requestAMFMessage)
        responseRawData = self._post_amf_request(postdata)
        responseMessage = read(responseRawData)
        result = responseMessage.bodies[0].data # The response message has only one message body in this case.
        if responseMessage.bodies[0].target.endswith(RESPONSE_STATUS):
            # False. Convert the response AMFMessage into an exception and throw it.
            if not isinstance(result, dict):
                result = {}
            raise RPCServiceInvocationError(
                    result=result,
                    faultString=result.get('description', ''),
                    faultDetail=result.get('details', ''),
                    faultCode=result.get('code', '')
                    )
        else:
            return result

    def __build_amf_message(self, methodName, requestCount, args):
        message = AMFMessage()
        message.version = self.__version__
        # header 
        if self.username and self.password:
            self.__set_credentials(message)
        # body
        target = self.serviceName + '.' + methodName
        response = '/' + str(requestCount)
        body = AMFMessageBody(target, response, args)
        message.add_body(body)
        return message

    def __set_credentials(self, message):
        if message.version == 3:
            usernameHeader = {'name': 'credentialsUsername', 'value': self.username}
            passwordHeader = {'name': 'credentialsPassword', 'value': self.password}
            message.add_header(usernameHeader)
            message.add_header(passwordHeader)
        else:
            header = {'name': 'Credentials', 'value': {'userid' : self.username, 'password' : self.password}}
            message.add_header(header)
    
