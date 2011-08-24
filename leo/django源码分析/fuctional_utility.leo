<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet ekr_test?>
<leo_file>
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="wjl.20101110224825.1243"><vh>@chapters</vh></v>
<v t="wjl.20101110224825.1242"><vh>preface</vh></v>
<v t="wjl.20101110224825.1244"><vh>django.utils.fuctional.curry</vh>
<v t="wjl.20101110224825.1245"><vh>source code</vh></v>
<v t="wjl.20101110224825.1246"><vh>analysis</vh></v>
</v>
<v t="wjl.20101110224825.1247"><vh>django.utils.fuctional.memoize</vh>
<v t="wjl.20101110224825.1248"><vh>source 1</vh></v>
<v t="wjl.20101114033543.1257"><vh>source--wraps</vh></v>
<v t="wjl.20101110224825.1249"><vh>analysis</vh></v>
</v>
<v t="wjl.20101114033543.1258"><vh>当wget不好使的时候，</vh></v>
</vnodes>
<tnodes>
<t tx="wjl.20101110224825.1242">Python treats fuctions as first-class objects.They have certain attributes and methods associated with them that are obviously different from other objects ,but the core language treats them just as other object.This handling allows for some very interesting uses of functions ,such as setting attributes at runtime and assembling functions in a list, to be executed in order.

Python把函数作为一等对象。函数有某些属性和方法，使他们不同于其他对象，但是语言看待他们和其他对象一样。这种处理允许函数一些有意思的用法，比如运行时设定属性， 把函数放到list里面，按顺序执行，</t>
<t tx="wjl.20101110224825.1243"></t>
<t tx="wjl.20101110224825.1244"></t>
<t tx="wjl.20101110224825.1245">def curry(_curried_func, *args, **kwargs):
    def _curried(*moreargs, **morekwargs):
        return _curried_func(*(args+moreargs), **dict(kwargs, **morekwargs))
    return _curried</t>
<t tx="wjl.20101110224825.1246">it`s often necessary to take a function with a complex set of arguments and simplify it so that code can calls it doesnot always need to supply all the arguments.the most obvious way to do this is by providing default values wherever possible,as descriped in the chapter2
In many situations ,though,there isn`t a sensible default at the time the function is written or the default value might not suitable to the needs of the situations .Normaly,you can just call the function with whatever argument values you need ,which works just fine for most needs.

我们经常有这样的需求，一个函数需要大量复杂的参数，我们调用这个函数的时候不希望提供所有的参数。最明显的做法就是提供默认值，就像在第二章里提到过的。
很多时候，在我们创建函数的时候么有一个有意义的默认值，或者默认值不适用情况的需要，正常情况下，我们可以直接提供所有需要的参数，在大部分的需求，这样是可以工作的。

Sometimes, though, the function`s arguments are determined at a different time than when it actually needs to be called .For instance,it`s quite common to pass a function around so it can be used later, whether as an instance method or a callback, or even a moudule-level function.When using a function that accepts more arguments that will be provided later,the remaining arguments must be specifiede in advance.

有时候，函数的参数并不是在他执行的时候确定的。例如，我们经常需要传一个函数作为参数准备一会使用，或者作为对象方法，或者回调函数，甚至一个moudule级别的函数，当我们使用一个函数接收更多的稍后提供的参数，这些参数必须实现指定。

Since Python2.5,this fuctionality is provided in the standard library,by the way of the functools.partial function.while being bundled with python is convenient ,it`s only useful for subsequent installation,while Django supports versions of Python that have been around far longer .Instead , Django provides its own implementation at django.utils.functional.curry.

从Python2.5以后，这个功能已经在标准库里提供了，在functools.partial这个函数，虽然放在标准库里是很方便，但是需要安装2.5以后的版本。然而Django支持各种版本的python，他提供了自己的实现，在django.utils.functional.curry.

The first argument to curry is always a callable,which won`t be called right away,but will be tucked away to be used later .Beyond that,all positional and keyword arguments are saved as well,and will be applied to the supplied callable when time comes.The return value is then a new fucntion that,when called ,will execute the original callable with both the orignal arguments and any arguments that were provided in the call that came later.

传递给curry的第一个参数一定是可以调用的，但是不会马上就执行。不仅如此，其他参数和占位符也会被保存，并且会传递给这个函数，返回值是一个带了参数的函数，执行这个函数的时候会带上curry的参数和新传递的参数一起执行。注：简单说，就是一个带了部分参数的中间函数对象。 

django.utils.functional.curry
functools.partial
</t>
<t tx="wjl.20101110224825.1247"></t>
<t tx="wjl.20101110224825.1248">WRAPPER_ASSIGNMENTS = ('__module__', '__name__', '__doc__')
WRAPPER_UPDATES = ('__dict__',)
def update_wrapper(wrapper,
                   wrapped,
                   assigned = WRAPPER_ASSIGNMENTS,
                   updated = WRAPPER_UPDATES):
    """Update a wrapper function to look like the wrapped function

       wrapper is the function to be updated
       wrapped is the original function
       assigned is a tuple naming the attributes assigned directly
       from the wrapped function to the wrapper function (defaults to
       functools.WRAPPER_ASSIGNMENTS)
       updated is a tuple naming the attributes off the wrapper that
       are updated with the corresponding attribute from the wrapped
       function (defaults to functools.WRAPPER_UPDATES)
    """
    for attr in assigned:
        setattr(wrapper, attr, getattr(wrapped, attr))
    for attr in updated:
        getattr(wrapper, attr).update(getattr(wrapped, attr))
    # Return the wrapper so this can be used as a decorator via curry()
    return wrapper

def wraps(wrapped,
          assigned = WRAPPER_ASSIGNMENTS,
          updated = WRAPPER_UPDATES):
    """Decorator factory to apply update_wrapper() to a wrapper function

       Returns a decorator that invokes update_wrapper() with the decorated
       function as the wrapper argument and the arguments to wraps() as the
       remaining arguments. Default arguments are as for update_wrapper().
       This is a convenience function to simplify applying curry() to
       update_wrapper().
    """
    return curry(update_wrapper, wrapped=wrapped,
                 assigned=assigned, updated=updated)

### End from Python 2.5 functools.py ##########################################

def memoize(func, cache, num_args):
    """
    Wrap a function so that results for any argument tuple are stored in
    'cache'. Note that the args to the function must be usable as dictionary
    keys.

    Only the first num_args are considered when creating the key.
    """
    def wrapper(*args):
        mem_args = args[:num_args]
        if mem_args in cache:
            return cache[mem_args]
        result = func(*args)
        cache[mem_args] = result
        return result
    return wraps(func)(wrapper)</t>
<t tx="wjl.20101110224825.1249">Chapter 2 described decorators in detail, but there’s one aspect of them that can cause problems
in some situations, because decorators often return a wrapper around the original function. This
wrapper is, in fact, an entirely different function than what was written in the source file, so it
has different attributes as well. When introspecting functions, this can cause confusion if several
functions are passed through the same decorator, because they would all share similar proper-
ties, including their names.
第二章里我们详细介绍了装饰器，但是有些时候装饰器会导致问题。因为装饰器经常返回一个原有函数的包装器。
这个包装器实际上是一个完全不同于原来卸载源文件里的函数，所以他们有不同的属性，当自省函数，这会导致混淆如果几个函数
通过一个装饰器来传递，因为他们会共有想死的属性，包括他们的名字。


这是python源码库中关于partial的源码。。

def partial(func, *args, **keywords):

    def newfunc(*fargs, **fkeywords):
        newkeywords = keywords.copy()
        newkeywords.update(fkeywords)
        return func(*(args + fargs), **newkeywords)
    newfunc.func = func
    newfunc.args = args
    newfunc.keywords = keywords

    return newfunc
我们看标准文档库提供的pattial代码，需要注意的是一旦我们使用了命名参数，就必须考虑对原函数的参数调用顺序。
</t>
<t tx="wjl.20101114033543.1257">WRAPPER_ASSIGNMENTS = ('__module__', '__name__', '__doc__')
WRAPPER_UPDATES = ('__dict__',)
def update_wrapper(wrapper,
                   wrapped,
                   assigned = WRAPPER_ASSIGNMENTS,
                   updated = WRAPPER_UPDATES):
    """Update a wrapper function to look like the wrapped function

       wrapper is the function to be updated
       wrapped is the original function
       assigned is a tuple naming the attributes assigned directly
       from the wrapped function to the wrapper function (defaults to
       functools.WRAPPER_ASSIGNMENTS)
       updated is a tuple naming the attributes off the wrapper that
       are updated with the corresponding attribute from the wrapped
       function (defaults to functools.WRAPPER_UPDATES)
    """
    for attr in assigned:
        setattr(wrapper, attr, getattr(wrapped, attr))
    for attr in updated:
        getattr(wrapper, attr).update(getattr(wrapped, attr))
    # Return the wrapper so this can be used as a decorator via curry()
    return wrapper

def wraps(wrapped,
          assigned = WRAPPER_ASSIGNMENTS,
          updated = WRAPPER_UPDATES):
    """Decorator factory to apply update_wrapper() to a wrapper function

       Returns a decorator that invokes update_wrapper() with the decorated
       function as the wrapper argument and the arguments to wraps() as the
       remaining arguments. Default arguments are as for update_wrapper().
       This is a convenience function to simplify applying curry() to
       update_wrapper().
    """
    return curry(update_wrapper, wrapped=wrapped,
                 assigned=assigned, updated=updated)</t>
<t tx="wjl.20101114033543.1258">1065-1057
1048-1046
1043
1022-1008
1004-997
993
921
335

import urllib2
req = urllib2.Request("http://221.122.78.12/index2/") 
res = urllib2.urlopen(req) 
html = res.read() 
www=open("/home/mumen/myapp/mumen/templates/index_bak.html",'wr')
www.write(html)
www.close()
res.close() </t>
</tnodes>
</leo_file>
