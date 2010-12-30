# vim: fileencoding=utf8
from django.conf import settings
from django.core.cache import cache
import amf.utils
import md5


def amf_cache(timeout=300):
    def func_wrapper(func):
        def wrapper(request, *args):
            cache_key = _generate_cache_key(func, args)

            cached_response = cache.get(cache_key)
            if cached_response is None:
                result = func(request, *args)
                _cache_response(cache_key) 
                amf.utils.logger().debug("No cache")
                return result
            else:
                _return_cache()
                amf.utils.logger().debug("Hit cache")
                return cached_response
        return wrapper
    return func_wrapper

def _generate_cache_key(func, args):
    ctx = md5.new()
    for arg in args:
        ctx.update(str(arg))
    cache_key = 'amf.cache.%s.%s' % (func.__name__, ctx.hexdigest())
    return cache_key

def _cache_response(cache_key):
    thread_local = amf.utils.get_thread_local()
    thread_local.amf_cache_response = cache_key

def _return_cache():
    thread_local = amf.utils.get_thread_local()
    thread_local.amf_return_cache = True
