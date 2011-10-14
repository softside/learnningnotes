<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo (http://webpages.charter.net/edreamleo/front.html) -->
<?xml-stylesheet ekr_test?>
<leo_file xmlns:leo="http://www.leo-editor.org/2011/leo" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="newlife.20101021104626.1288"><vh>@chapters</vh>
<v t="newlife.20101021104626.1290"><vh>django认证机制</vh>
<v t="newlife.20101021104626.1289"><vh>django的密码机制</vh>
<v t="newlife.20101027175540.1249"><vh>密码生成</vh></v>
</v>
</v>
</v>
<v t="newlife.20111012233931.1135"><vh>sicp</vh>
<v t="newlife.20101021104626.1287"><vh>Building Abstractions with Procedures</vh></v>
</v>
<v t="newlife.20111013160723.1149" a="E"><vh>lisp入门教程</vh>
<v t="newlife.20111013160723.1150"><vh>符号</vh></v>
</v>
<v t="newlife.20111012233931.1136"><vh>practical common lisp</vh>
<v t="newlife.20111013160723.1148"><vh>函数学习</vh></v>
</v>
<v t="newlife.20111012233931.1137"><vh>onlisp</vh></v>
<v t="newlife.20111012233931.1138" a="E"><vh>weblocks</vh>
<v t="newlife.20111012233931.1139" a="E"><vh>doc</vh>
<v t="newlife.20111013160723.1147"><vh>文档的更新</vh></v>
</v>
<v t="newlife.20111012233931.1140"><vh>how to run a weblocks project</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20101021104626.1287">The acts of the mind, wherein it exerts its power over simple ideas, are chiefly
these three: 
1. Combining several simple ideas into one compound one, and
thus all complex ideas are made. 
组合几个简单的想法到一个，这样一个复杂的想法产生了。

2. The second is bringing two ideas, whethersimple or complex, together, and setting them by one another so as to take a view of them at once, without uniting them into one, by which it gets all its ideas of  relations. 

把2个想法放在一起，

3. The third is separating them from all other ideas that accompany them in their real existence: this is called abstraction, and thus all its general ideas are made.


思维的行动，</t>
<t tx="newlife.20101021104626.1288">关于lisp------我的小众语言之路

其实我一直想学一种函数式的编程语言，以前学习的语言，不管是最开始的java还是最爱的python，都是比较传统的语言。追求特立独行是我内心深处的需求，之前学python是这样，现在学lisp也是这样。

有人总结lisp不流行的原因，一个是自信，该社区的人普遍认为lisp一定会是最后胜利的语言，这种自信是有道理的，还有就是新人入门的学习曲线实在是太高了，要不我换到mac下，单就开发环境那也是相当的纠结啊，还不说各种option的选择。其实对于大部分人来说，不要给用户太多选择(我是天平座，有轻微选择恐惧症)。其实我还纠结过haskell，甚至买了全英文的realworld haskell，但是毅力不够，方法不对等等诸多问题，也就搁下了，以后有机会在实践吧。

刚才提到方法不对，我对比自己学习python/django的学习历程，因为以前做过j2ee的开发，对mvc熟悉，直接上手写django，不会的看文档(这里赞一下django的文档，真详细啊)，进而学习python，django就是python，这就是一个很便利的地方，学习起来事半功倍。

因此，这次学习common lisp，我对学习的路线做了调整。
    1，买书是必须的，最先看的是practical common lisp,预计会在十月底之前看完(在当当上定了中文版，估计是赶不上了，以后复习的时候用吧)。之后看 on lisp（paul graham)写的，预期十一，十二月看完，排期这么久是因为要回头看practical common lisp,温故而知新。
    2，weblocks。经过我几天的折腾，这个东西已经搭起来了。因为我相对熟悉web开发，期望这东西就是带我前进的lisp里面的django吧。其实我是一个django fan，=|=。</t>
<t tx="newlife.20101021104626.1289">    def set_password(self, raw_password):
        import random
        algo = 'sha1'
        salt = get_hexdigest(algo, str(random.random()), str(random.random()))[:5]
        hsh = get_hexdigest(algo, salt, raw_password)
        self.password = '%s$%s$%s' % (algo, salt, hsh)
        
        
def get_hexdigest(algorithm, salt, raw_password):
    """
    Returns a string of the hexdigest of the given plaintext password and salt
    using the given algorithm ('md5', 'sha1' or 'crypt').
    """
    raw_password, salt = smart_str(raw_password), smart_str(salt)
    if algorithm == 'crypt':
        try:
            import crypt
        except ImportError:
            raise ValueError('"crypt" password algorithm not supported in this environment')
        return crypt.crypt(raw_password, salt)

    if algorithm == 'md5':
        return md5_constructor(salt + raw_password).hexdigest()
    elif algorithm == 'sha1':
        return sha_constructor(salt + raw_password).hexdigest()
    raise ValueError("Got unknown password algorithm type in password.")        </t>
<t tx="newlife.20101021104626.1290">def authenticate(self, username=None, password=None):
    try:
        user = User.objects.get(username=username)
        if user.check_password(password):#check_password()就在下面
            return user
    except User.DoesNotExist:
        return None
        
def check_password(self, raw_password):
    """
    Returns a boolean of whether the raw_password was correct. Handles
    encryption formats behind the scenes.
    """
    # Backwards-compatibility check. Older passwords won't include the
    # algorithm or salt.这个函数的作用就是兼容以前的版本，不对认证作处理
    if '$' not in self.password:#以前版本的密码中没有'$',并且是按md5加密处理的
        is_correct = (self.password == get_hexdigest('md5', '', raw_password)) #这个显然不等阿。。
        if is_correct:
            # Convert the password to the new, more secure format.
            self.set_password(raw_password)
            self.save()
        return is_correct
    return check_password(raw_password, self.password)

def check_password(raw_password, enc_password):
    """
    Returns a boolean of whether the raw_password was correct. Handles
    encryption formats behind the scenes.
    """
    algo, salt, hsh = enc_password.split('$')
    return hsh == get_hexdigest(algo, salt, raw_password)
#看上面的两个函数，注释都是一样的，orz。。虽然用户生成的密码有algo（算法），salt（盐），但是这些东西都是从现有用户的密码种取出的，没啥作用。
    
def get_hexdigest(algorithm, salt, raw_password):
    """
    Returns a string of the hexdigest of the given plaintext password and salt
    using the given algorithm ('md5', 'sha1' or 'crypt').
    """
    raw_password, salt = smart_str(raw_password), smart_str(salt)
    if algorithm == 'crypt':
        try:
            import crypt
        except ImportError:
            raise ValueError('"crypt" password algorithm not supported in this environment')
        return crypt.crypt(raw_password, salt)

    if algorithm == 'md5':
        return md5_constructor(salt + raw_password).hexdigest()
    elif algorithm == 'sha1':
        return sha_constructor(salt + raw_password).hexdigest()#现在的版本都是用的sha1加密的。
    raise ValueError("Got unknown password algorithm type in password.")
    
    
    现在，，描述下整个流程，用户已注册：
    首先，处理的函数是authenticate()————&gt;user.check_password()——————&gt;check_password()——————&gt;get_hexdigest()
    
    
    
    
    
    
    
    
    
    </t>
<t tx="newlife.20101027175540.1249">#/django/contrib/auth

from django.utils.hashcompat import md5_constructor, sha_constructor

def get_hexdigest(algorithm, salt, raw_password):
    """
    Returns a string of the hexdigest of the given plaintext password and salt
    using the given algorithm ('md5', 'sha1' or 'crypt').
    """
    raw_password, salt = smart_str(raw_password), smart_str(salt)
    if algorithm == 'crypt':
        try:
            import crypt
        except ImportError:
            raise ValueError('"crypt" password algorithm not supported in this environment')
        return crypt.crypt(raw_password, salt)

    if algorithm == 'md5':
        return md5_constructor(salt + raw_password).hexdigest()
    elif algorithm == 'sha1':
        return sha_constructor(salt + raw_password).hexdigest()
    raise ValueError("Got unknown password algorithm type in password.")
    最近的都是基于sha1的，所以我们要分析的就是sha_constructor(salt + raw_password).hexdigest()
    
    这个sha_constructor就是接收一个string参数，生成一段密码。   
 
这个就是django.utils.hashcompat的全部内容，只是简单的导入。
try:
    import hashlib
    md5_constructor = hashlib.md5
    md5_hmac = md5_constructor
    sha_constructor = hashlib.sha1
    sha_hmac = sha_constructor
except ImportError:
    import md5
    md5_constructor = md5.new
    md5_hmac = md5
    import sha
    sha_constructor = sha.new
    sha_hmac = sha
</t>
<t tx="newlife.20111012233931.1135"></t>
<t tx="newlife.20111012233931.1136"></t>
<t tx="newlife.20111012233931.1137"></t>
<t tx="newlife.20111012233931.1138">这个是目前可以看到的相对比较完善的，并且还有人维护，持续更新的一个基于common lisp的web框架。

https://bitbucket.org/S11001001/weblocks-dev

这个框架是谁写的：
    Weblocks was created by Slava Akhmechet. It is now maintained by Stephen Compall and Leslie Polzer, and developed by volunteers around the globe.

框架的期望：lisp中的django。

通过使用这个框架做些简单的东西，进而熟悉这个框架，然后是cl，对照看书所得，</t>
<t tx="newlife.20111012233931.1139">Introduction
##介绍
There is nothing special about Weblocks. It is merely one possible logical solution to a subset of problems faced in web application development. To get familiar with Weblocks and its approach let us start with breaking the ice.

##Weblocks没有什么特殊的，他只是一个旨在解决web开发中的一些问题。为了熟悉Weblocks和他的流程，来，开始我们的破冰之旅。

Breaking the Ice
##破冰之旅
To learn how to obtain and install Weblocks see ObtainingAndInstalling.
##
Once Weblocks has been installed it can be loaded into the Lisp image like this:

&gt; (push #p"/usr/lib/sbcl/site/cl-weblocks/" asdf:*central-registry*)
&gt; (asdf:operate 'asdf:load-op 'weblocks)

Replace /usr/lib/sbcl/site/cl-weblocks/ with the path to your weblocks installation.

We can then start the webserver (Weblocks uses Hunchentoot) and the framework on the default port (8080) like this:

&gt; (weblocks:start-weblocks)

Point the web browser to  http://localhost:8080/weblocks-demo/. If all went well we should see a welcome page. We are now running Weblocks!
##

Our First Weblocks Application
When weblocks starts up it sets up a hook that processes all client requests. The hook looks for two things - a web application definition, and a callback function named 'init-user-session' that initializes the application every time a new session is created (sessions are managed by Weblocks automatically). If these are not provided, Weblocks uses default values that point to the welcome page.

To create our own Weblocks application we need to override the defaults. We can do it by typing the following code snippet into the REPL:

&gt; (weblocks:defwebapp our-application :prefix "/")
&gt; (defun init-user-session (comp)
    (setf (weblocks:composite-widgets comp)
          (list "Hello!")))
Now let  tell Weblocks to reset all sessions so it picks up the new application:

&gt; (weblocks:reset-sessions)
Refresh the browser. Instead of the welcome page you should now see the word "Hello!" printed on the screen.

What did we do? We told Weblocks that our application is named 'our-application'. Weblocks will look for 'init-user-session' in the same package where the symbol 'our-application' is interned. Before we can figure out how 'init-user-session' works we need to explain the concept of 'widgets' - this will be done in the next section.
##我们做啥了？我们告诉Weblocks我们的应用叫“our-application”,Weblocks会在同一个包寻找“init-user-session”，在我们描述“init-user-session”之前，我们要先介绍“widgets”这个东西，"init-user-session"下面的章节会解释这个。

Widgets
Weblocks applications are not organized into pages. They are organized into 'widgets'. A widget can potentially be anything that is rendered to the browser. Widgets can be very simple or very complex.

##Weblocks应用不是由页面组织的，他是由widgets组织的。widget可以是任何传递到浏览器的东西，他可以是简单的也可以是复杂的。
Weblocks defines a generic function 'render-widget-body' along with a number of methods that accept different objects. Any object that can be passed to 'render-widget-body' can be called a widget. New widgets can be created by adding methods to this generic function.
##

There is a method added to 'render-widget-body' that accepts a vector of characters. That means the simplest possible widget is a string:

&gt; (weblocks:render-widget-body "Hello World!")
When 'render-widget-body' is called on a string, the string is simply outputted as an HTML paragraph.

Functions can also be treated as widgets. When 'render-widget-body' is called with a function an appropriate method is invoked that simply calls the function:

&gt; (weblocks:render-widget-body (lambda (&amp;rest args)
                                 (weblocks:with-html
			           (:p "test"))))
The macro 'with-html' is a wrapper that weblocks provides for CL-WHO macro 'with-html-output'. For each client request Weblocks sets up a stream available via a special variable *weblocks-output-stream*. By writing to this stream the application can send HTML to the client. However, using 'with-html' is preferred - it automatically redirects output to *weblocks-output-stream* and takes full advantage of CL-WHO which alleviates the need to format HTML strings or to use template engines. (Many people argue that template engines are a good thing since they enforce MVC. Weblocks takes a different approach by using 'views' - pieces of code that generically serialize data structures into different types of HTML.)

One of the widgets that Weblocks defines is a 'composite' widget. A composite is a CLOS object that contains a list of other widgets. A composite provides a simple and convenient way to group widgets. Rendering a composite renders each widget in the list, one by one:

(setf my-composite
      (make-instance 'weblocks:composite
                     :widgets (list "a" "b")))
(weblocks:render-widget-body my-composite)

*Please note*, all code snippets that aren't prepended with &gt; (including the one above) will singal an error when evaluated in the REPL. These snippets need a dynamic session environment set up in order to work properly. When they are called as part of the HTTP request, the session environment is present. When they are called from the REPL, the session environment is missing. If you would like to experiment with these snippets in the REPL, see macro 'with-request' defined in 'weblocks-test'. The macro sets up a dummy environment for testing, debugging, and experimenting purposes.

In this case two paragraphs will be rendered. The first one will say "a" and the second one will say "b". Composites can be recursive - they can contain other composites.

Most widgets defined by Weblocks are CLOS objects. The fact that strings and functions are widgets are an exception made for convenience, rather than the rule. The base class for widgets is 'widget'. It contains a number of slots that are common to all widgets. One of these slots is 'name'. If the name of the widget isn't given during the instantiation, a unique name is generated automatically.

Widgets map to HTML really well. The way widgets are normally rendered is via a function 'render-widget', not via 'render-widget-body'. The function 'render-widget' wraps the widget body in a 'div' element. The id of the div is set to the widget name and the classes of the div are set to the CLOS hierarchy class names. For example, the header for the composite widget will be rendered something like this:

&lt;div id="g2345" class="widget composite"&gt; ... &lt;/div&gt;
This works very well for CSS styling too.

Widgets that don't derive from CLOS class 'widget' like strings and functions are handled in a similar manner, except they lack the "id" attribute.

The magic behind 'init-user-session'
We're now ready to understand how 'init-user-session' works.

When weblocks sees an HTTP request that does not yet have a session associated with it, a session is created. A new composite widget is instantiated and is associated with this session. This composite widget is called a 'root' - all other widgets of the application will be stored in it.

The root composite is then passed to 'init-user-session'. It's up to 'init-user-session' to add other widgets to the root composite. When it's time for Weblocks to render HTML to the client it simply calls 'render-widget' on the root composite, which ends up rendering all widgets that were added to the root in 'init-user-session'.

Recall our 'init-user-session' code:

&gt; (defun init-user-session (comp)
    (setf (weblocks:composite-widgets comp)
          (list "Hello!")))
The argument 'comp' is the root composite that Weblocks will pass to 'init-user-session'. The accessor 'composite-widgets' gives access to the slot of the root composite that contains a list of widgets. We simply set the slot to a new list of one element - a string "Hello!". We can get away with this because strings are also widgets.

We can add other widgets to this list, including other strings, functions, composites, etc (Be sure to reset the session or redefining 'init-user-session' will have no effect. You can do this by restarting the browser or by calling 'weblocks::reset-sessions').

Views
A major criticism of the above approach is that it steers away from the MVC model since HTML (or the CL-WHO alternative) is mixed with the code. This does not have to be true. In principle, nothing stops you from writing widgets that invoke a template engine. However, Weblocks does not go down this path.

Weblocks treats HTML as a serialization format. Weblocks' philosophy is that neither the programmer nor the designer should have to write HTML - most of the time HTML should be generated automatically. The programmer's job is to define the data structures, the high level UI components, and the business logic. The designer's job is to create appropriate stylesheets. The actual HTML markup generation is the job of the framework.

In practice this isn't always possible because of CSS quirks and limitations, but Weblocks tries to stay true to this approach whenever the current state of W3C affairs permits. In order to make this possible Weblocks defines a set of 'views' - pieces of code that serialize data structures to different types of HTML.

Let's illustrate this approach by defining a data structure for a person:

&gt; (defclass person ()
    ((weblocks:id)
     (first-name :accessor first-name
   	         :initarg :first-name
	         :initform nil)
     (last-name :accessor last-name
   	        :initarg :last-name
	        :initform nil)
     (age :accessor age
          :initarg :age
	  :initform nil)))
&gt; (setf joe (make-instance 'person
                           :first-name "Joe"
	                   :last-name "Average"
			   :age 31))
Normally, to render information about the person to the screen we'd create a number of templates that we'd use throughout the application. We would probably create a template for rendering the data, a template for rendering the form, and perhaps a template for rendering a table of people. This wouldn't be too difficult except we have to do this again and again for every new data structure we come up with. We end up generating nearly the same HTML manually - all that's changing is a list of fields. Weblocks automates this work:

&gt; (weblocks:render-object-view joe '(data person))
&gt; (weblocks:render-object-view (list joe) '(table person))
The first line renders our data structure into a list of fields. The second line renders a table of one row. In similar manner weblocks provides a view for serializing data structures into forms. We specify the class of the object (person) to allow the scaffolding infrastructure to generate an appropriate view. Other views can be added if the need arises.

Views are designed to output high quality, validating HTML. Special care is taken to ensure the generated HTML follows accessibility guidelines. Due to CSS limitations views generate somewhat heavy HTML - extra tags and classes are put in place to allow for sufficient freedom in styling. Much of this markup will disappear when CSS3 is supported by all mainstream browsers (much of the extra markup would disappear if CSS2 was supported by IE6).

Views try to respect the rules of the language. For example, if a slot has no reader, by default this slot will be omitted from rendering.

Views provide an extremely flexible customization mechanism to easily rename, rearrange, hide/show, and custom render slots (see example code for details). Most widgets that deal with rendering data structures (dataform widget, grid widget, etc.) use views to render data. Weblocks tries to provide views that satisfy commonly used customization cases. The programmer should resort to custom HTML only in rare special cases when there is no way to configure the view to generate sufficient HTML.

Actions
Everything we've discussed above has been about rendering data to the client. So far we haven't discussed interactivity - the user's ability to change the state of the UI and to modify the data.

Weblocks allows the programmer to deal with client interaction without having to worry about the limitations of HTTP protocol. In Weblocks the programmer can 'render' a function, a generic function, or a closure into a link (or a button in a form). When the user clicks on the appropriate link (or button), Weblocks maps the click back to the callback. If the callback is a lexical closure, the programmer will have the full context in which the closure was created despite the fact that it was created during a completely different HTTP request:

(weblocks:render-link (lambda (&amp;rest args)
                        (do-something))
                      "Modify")
In this case the action is rendered into a link named 'Modify' via 'render-link'. When the user clicks 'Modify', the lambda function is called (in the appropriate lexical context, if there is one), and 'do-something' is evaluated. A similar mechanism can be invoked for rendering form buttons.

Note, 'render-link' renders an AJAX-friendly link. The callback will be made via an AJAX request if JavaScript is available. Otherwise, Weblocks will fall back to a regular request. Because Weblocks applications aren't organized by pages, links change the state of widgets, rather than move between pages. This is why rendering a non-AJAX link doesn't make sense in the context of Weblocks.

Weblocks does have a mechanism to allow for friendly URLs. This mechanism is exposed to the programmer via the 'navigation' widget. The navigation widget takes very special care to hide the fact that Weblocks applications aren't organized into pages from the user. This way the user can enjoy the rich UI that follows established conventions, while the programmer can code the application using the widget paradigm. See reference documentation for the navigation widget for more details.

Stores
Many of the built in widgets operate on data peristed to a backend store. Weblocks supports a number of stores including SQL databases (via CLSQL) and XML files (via cl-prevalence). New stores can easily be added by implementing a simple API.

In this tutorial we will use a memory store for simplicity (in this case the data does not get persisted after the application quits). Before we can go on to use advanced widgets we need to define out store:

&gt; (weblocks:defstore *scratch-store* :memory)
This line will create a memory store, bind it to *scratch-store*, and make it a default store for the application to use. A similar command can be used to define a SQL store in a production system. Defined stores will be opened automatically when the server is started and closed when the sever is stopped.

*Please note*, once you define a new store you should stop and start Weblocks to ensure the store is opened and ready to operate.

More on Widgets
So far we've only seen stateless widgets - string, function, and composite. However, we've hinted that widgets can have state. The simplest example of a stateful widget is a closure that increments a counter every time it's evaluated.

Some of the more complex Weblocks widgets have state associated with them. One such widget is 'dataform'. We'll talk about it here to put together everything we've discussed so far.

Dataform widget models a fairly common behavior of web applications. It renders a datastructure to HTML so the user can see some data. Below the data it renders a "Modify" link. If the user clicks on the link, the widget changes its state from 'data' to 'form' and renders a form for the user to modify the data along with a 'Submit' and 'Cancel' buttons. If the user clicks 'Submit', any changes are submitted and the state is changed back to 'data'. If the user clicks 'Cancel', the changes are discarded and the state is changed to 'data' as well.

Dataform widget is composed of everything we've discussed so far. It uses a data view to render the data, and a form view to render the form. It also uses actions to render the 'Modify' link and the buttons. Since dataform is a CLOS object, it stores its current state (whether it's displaying the structure as data or form) inside a slot. When the actions are invoked by the user this state is changed appropriately. We can change 'init-user-session' to take advantage of the dataform widget, and to finally add some interactivity to our application:

&gt; (defun init-user-session (comp)
    (setf (weblocks:composite-widgets comp)
          (list (make-instance 'weblocks:dataform :data joe))))
If we reset the session and refresh the page, we will see information about Joe displayed in the browser. We can click on 'Modify', change some of the data in the form, and click submit or cancel.

Since each dataform widget encapsulates and manages its own state, we can add as many dataform widgets to our page as we like. We can play with their states and they will all behave correctly. This is an enormous benefit about componetized approach - once we've created a widget, we can reuse it to our heart's content.

AJAX
Because actions are rendered to be AJAX-friendly, the dataform widget also ends up being updated in an AJAX request. How does this work? Why does the dataform widget redraw if 'Modify' is called asynchronously?

Weblocks uses the power of Lisp to fully automate this behavior. Every time a value of any slot of the widget changes, Weblocks detects the change using a hook in MOP and marks the widget as dirty (it is of course possible to turn this behavior off for some slots). Once the action is fully evaluated, Weblocks sends a list of dirty widgets back to the client, and each dirty widget is updated on the browser via JavaScript. Since the 'Modify' action changes the state of the dataform widget, the dataform is marked by Weblocks as dirty and the newly rendered version is sent to the client.

Note that this behavior scales back very well if the user has JavaScript turned off. Instead of sending a list of dirty widgets to the client, the entire page is redrawn. Most of the time the web programmer, and even the widget designer, need not care about AJAX at all - everything is managed by Weblocks (Some widgets take care to specifically turn off AJAX. For example, the navigation widget renders non-AJAX links to allow for friendly URLs).

Useful Hints
Troubleshooting

If anything goes wrong during this tutorial (or during development), the 'Internal Server Error' message does not give great insight into why an error has occurred. Fortunately, it is very simple to turn on debug mode, so that the exact error, along with the stack trace, are displayed in the browser. Instead of

&gt; (weblocks:start-weblocks)
run

&gt; (weblocks:start-weblocks :debug t)
Note, if Weblocks is running you need to stop it first with 'stop-weblocks'.

Creating a New Project

When you are ready to do more than just play around in the REPL, Weblocks provides a script to help you get started. The ASDF operation 'make-app-op' located in the 'wop' package allows you to quickly create an asdf-based project with necessary files, default stylesheets, etc. that you can start modifying.

First, load weblocks:

(asdf:operate 'asdf:load-op :weblocks)
You can then create a new project like this:

(asdf:operate 'wop:make-app-op :weblocks :name 'myapp :target "/home/coffeemug/projects/")
Or, if you don't like ASDF syntax, you can use the 'make-app' shortcut:

(wop:make-app 'myapp "/home/coffeemug/projects/")
This will create a directory '/home/coffeemug/projects/my-app/' and add necessary weblocks files to it. Note, some Lisp implementations don not understand shell-based shortcuts (like tilde for home directory), so you might have to type the directory in full. Alternatively you can change into the directory where you want to create the new project in your implementation (in slime, switch to REPL and type ,cd RET), and omit the target argument to the operation.

Now, all you have left to do is add your project source directory to ASDF central registry. You can do it by adding the following line to your implementation init file:

(push #p"/home/coffeemug/projects/my-app/" asdf:*central-registry*)
That is it! You can now load the newly created application and enjoy the ride:

(asdf:operate 'asdf:load-op :my-app)
(my-app:start-my-app)                 ; an alias for 'start-weblocks'</t>
<t tx="newlife.20111012233931.1140">如何启动一个weblocks项目

(asdf:operate 'asdf:load-op :weblocks)
    引入weblcoks包

(wop:make-app 'myapp "/Users/newlife/commonlisp/newlife/")
    
    执行这句会在该目录下穿一个一个myapp的文件，该项目所有的文件都在这里面，然后操作这个目录下的文件
    
(push #p"/Users/newlife/commonlisp/newlife/myapp/" asdf:*central-registry*)
    注册项目，
    
(asdf:operate 'asdf:load-op :myapp)
    引入项目


(myapp:start-myapp)
    启动项目</t>
<t tx="newlife.20111013160723.1147">可以看出，这个软件的更新还是很频繁的，对应的文档的更新就是个问题，我看的还是一个相对较新的文档，但是依然落后了许多。

尤其是像我这样，对框架和语言都不是很熟悉的新手，一个可靠的文档是多么的有必要啊</t>
<t tx="newlife.20111013160723.1148"></t>
<t tx="newlife.20111013160723.1149">Lisp 入门教程(刘鑫最新翻译)，
该书是1993年写的，，，
这本书很简单啊，只有55页，熟悉common lisp基本的语法，
功能基本相当与python中的 a byte of python</t>
<t tx="newlife.20111013160723.1150">符号仅仅是字符串。你可以在符号中包含字母、数字、连接符等等,唯一的限制 就是要以字母开头。(如果你只输入数字,最多再以一个连接符开头的话,LISP 会认为你输入了一个整数而不是符号。)

(setq a 5)
(setq a "333")
setq,用于赋值， 
(let ((a 6)) a)
暂时赋值，语句结束，赋值失效
(+ a  6)

t nil 就是True 和False,这个和python的概念是一致的

cons

cons 就是一个包含两个字段的记录。出于历史原因,两个字段分别被称为 "car"和"cdr"。(在第一台实现 LISP 的机器上,用 CAR 和 CDR 代表"地址寄 存器的内容"和"指令寄存器的内容"。Conses 的实现主要依靠这两个寄存E器。)

简单解释就是这是一个构造双元素的tuple，
取第一项的时候用car
取第二项的时候用cdr


(list 1 2 3 )
list操作用pop和push

函数：
(defun foo (x y) (+ x y 5))

关键字 函数名 参数列表 函数体    



</t>
</tnodes>
</leo_file>
