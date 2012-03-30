Usage

For a route creation RESTAS uses macro restas:define-route e.g.:

(restas:define-route article ("articles/:author/:item"
                              :method :get
                              :content-type "text/plain")
  (format nil "Author: ~A~Article: ~A" author item))


In other words, we define an URL template and its handler, meanwhile the handler body have immediate access to the variables defined in the URL template. Embedded handler by default may return string or "octets array", or integer number (which will be interpreted as a code of request status), or pathname (in this case hunchentoot:handle-static-file is called, which, contrary to Ruby- and Python-based systems, works fast enough and usually there is no need for additional servers for static content, such as the nginx server.

;;换句话说，我们定义了一个url模板和他的处理器，同时处理器直接访问了定义在url模板里的变量。内置的处理器默认返回string或者位组数组，或者整数（这个会被解释为请求状态码，比如404），或是路径名

When you define a route with restas:define-route you need to specify symbol (in cited example it is 'article), which will became the route name. Firstly, it gives you the possibility to redefine the route (including the URL template, just keep the same name for it) at any moment you want, just send the code to REPL (for example, with M-C-x in SLIME). Secondly, it lets you use this symbol for URL generation:
;;
