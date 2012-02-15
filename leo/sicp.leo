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
<v t="newlife.20111129230956.1175" a="E"><vh>asdf</vh>
<v t="newlife.20111130230003.1177"><vh>asdf intro</vh></v>
<v t="newlife.20111130230003.1178"><vh>load-system</vh></v>
<v t="newlife.20111204034558.1181"><vh>quicklisp</vh></v>
</v>
<v t="newlife.20111017184953.1164" a="E"><vh>ext-blog</vh>
<v t="newlife.20111103185120.1173"><vh>routers</vh>
<v t="newlife.20111124223215.1179"><vh>流程</vh></v>
<v t="newlife.20111124223215.1178"><vh>@file /Users/newlife/commonlisp/my-ext/ext-blog/theme/isimple/drawer.lisp</vh></v>
<v t="newlife.20111208221053.1185"><vh>src</vh></v>
</v>
<v t="newlife.20111219151241.1196"><vh>templates</vh></v>
<v t="newlife.20111208221053.1186" a="E"><vh>TODO</vh>
<v t="newlife.20111208221053.1187"><vh>分类</vh></v>
<v t="newlife.20111219151241.1195"><vh>tag</vh></v>
</v>
</v>
<v t="newlife.20111012233931.1135" a="E"><vh>sicp</vh>
<v t="newlife.20101021104626.1287"><vh>Building Abstractions with Procedures</vh></v>
</v>
<v t="newlife.20111208221053.1183" a="E"><vh>onlisp</vh>
<v t="newlife.20111208221053.1184"><vh>chap06</vh></v>
</v>
<v t="newlife.20111017184953.1163" a="E"><vh>web framework</vh>
<v t="newlife.20111017184953.1161" a="E"><vh>restas</vh>
<v t="newlife.20111015012314.1157" a="E"><vh>lisp入门教程</vh>
<v t="newlife.20111013160723.1149" a="E"><vh>common lisp hints</vh>
<v t="newlife.20111013160723.1150"><vh>符号</vh></v>
</v>
<v t="newlife.20111015012314.1155" a="E"><vh>land of lisp</vh>
<v t="newlife.20111015012314.1156"><vh>基础语法学习</vh></v>
</v>
<v t="newlife.20111012233931.1136" a="E"><vh>practical common lisp</vh>
<v t="newlife.20111028223935.1169"><vh>符号学习</vh></v>
<v t="newlife.20111013160723.1148"><vh>函数学习</vh></v>
<v t="newlife.20111101232018.1171"><vh>宏学习</vh></v>
</v>
<v t="newlife.20111012233931.1137"><vh>onlisp</vh></v>
</v>
<v t="newlife.20111106084942.1175"><vh>documation</vh></v>
<v t="newlife.20111017184953.1162"><vh>introduction</vh></v>
<v t="newlife.20111124223215.1177"><vh>think</vh></v>
</v>
</v>
<v t="newlife.20111215103224.1193"><vh>python-lisp</vh></v>
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


思维的行动，

</t>
<t tx="newlife.20101021104626.1288">关于lisp------我的小众语言之路

其实我一直想学一种函数式的编程语言，以前学习的语言，不管是最开始的java还是最爱的python，都是比较传统的语言。追求特立独行是我内心深处的需求，之前学python是这样，现在学lisp也是这样。

有人总结lisp不流行的原因，一个是自信，该社区的人普遍认为lisp一定会是最后胜利的语言，这种自信是有道理的，还有就是新人入门的学习曲线实在是太高了，要不我换到mac下，单就开发环境那也是相当的纠结啊，还不说各种option的选择。其实对于大部分人来说，不要给用户太多选择(我是天平座，有轻微选择恐惧症)。其实我还纠结过haskell，甚至买了全英文的realworld haskell，但是毅力不够，方法不对等等诸多问题，也就搁下了，以后有机会在实践吧。

刚才提到方法不对，我对比自己学习python/django的学习历程，因为以前做过j2ee的开发，对mvc熟悉，直接上手写django，不会的看文档(这里赞一下django的文档，真详细啊)，进而学习python，django就是python，这就是一个很便利的地方，学习起来事半功倍。

因此，这次学习common lisp，我对学习的路线做了调整。
    1，买书是必须的，最先看的是practical common lisp,预计会在十月底之前看完(在当当上定了中文版，估计是赶不上了，以后复习的时候用吧)。之后看 on lisp（paul graham)写的，预期十一，十二月看完，排期这么久是因为要回头看practical common lisp,温故而知新。
    2，weblocks。经过我几天的折腾，这个东西已经搭起来了。因为我相对熟悉web开发，期望这东西就是带我前进的lisp里面的django吧。其实我是一个django fan，=|=。

</t>
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
<t tx="newlife.20111013160723.1148">(ash 11 1)
这是一个处理位操作的函数，
第一个参数的二进制形式，接受第二个参数的个数。
这两个参数必须是整数，
比如11的二进制形式：1011
第二个参数为正数，则想左移1位(2就左移2位咯)，左移后面的位数补0，即10110，就是22，

若为负数，比如（ash 11 -1）则右移一位，右移直接抹去最后一位，就是101，就是5，</t>
<t tx="newlife.20111013160723.1149">Common LISP Hints --Lisp 入门教程(刘鑫最新翻译)，

该书是1993年写的，，，

这本书很简单啊，只有55页，熟悉common lisp基本的语法，

功能基本相当与python中的 a byte of python


</t>
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
<t tx="newlife.20111015012314.1155">其实这本才是最好的lisp入门教程</t>
<t tx="newlife.20111015012314.1156"></t>
<t tx="newlife.20111015012314.1157">Lisp本身是有大量的函数组成，其语言标准有超过四分之三的名字用于定义函数。所有的内置数据类型纯粹是由操作他们的函数定义的。
尽管宏对于lisp风格有着重要的作用，但是最终所有实际的功能还是由函数来提供的，宏运行在编译期，因此他们生成的代码，即当所有宏被展开后将实际构成程序的那些代码，将完全由对函数和特殊操作符的调用搜构成，


好的程序员都是写出来的，不是看出来的，但是要先看，认真的看。

common lisp是我第一个认真学习的语言，当初学python的时候都没有这么认真的看过哪本书。

现在静心想想，cl的神奇的地方有哪些，clos，macro,还是它诡异的语法，
</t>
<t tx="newlife.20111017184953.1161">其实很多时候，我们的选择就是简单的那个。



这个框架</t>
<t tx="newlife.20111017184953.1162">RESTAS

RESTAS is a web framework, used to develop the site lisper.ru
Homepage: RESTAS

Documentation: http://restas.lisper.ru/en/

Source code: http://github.com/archimag/restas

Features

Based on Hunchentoot
Uses cl-routes for mapping URL (without MVC)
Supports the reuse of web applications as plug-ins
Pure lisp daemonization with SBCL on GNU/Linux without of GNU Screen or detachtty (tested on Gentoo and Debian)


其实不管从哪个角度分析，这个2个应用都不是什么复杂的东西，毕竟原型简单，处理的逻辑相对比较容易，

现在为缺乏的就是多写，毕竟看这些代码都没有那么的陌生了，
</t>
<t tx="newlife.20111017184953.1163"></t>
<t tx="newlife.20111017184953.1164">http://codemacro.com/index
这是一个基于restas的基于common lisp的，写的相对完善的blog程序，通过这个程序熟悉最基础的cl语法，和restas框架。最好的地方是这个blog安装容易。

</t>
<t tx="newlife.20111028223935.1169">common lisp 中有很有多的符号，很神奇啊：

关键字符号：
    关键字符号是任何以冒号(:)开始的名字，下面是一个使用了关键字符号:a :b :c 作为属性名的示例plist:
        (list :a 1 :b 2 :c 3)
    获取该属性的方法：
        (getf (list :a 1:b 2 :c 3) :a) 输出的结果是1
formate函数：
    (formate t "~{~a:~10t~a~%}~%"  cd )
    formate至少接受两个实参，第一个是它原来发送输出的流，就是t；第二个是一个字符串，内容既包括字面文本，也包括告诉formate如何                   
    插入其余参数等信息的指令，格式指令以~开始，~a是美化指令，它的意图是消耗一个实参，然后将其输出成人类可读的形式，
    ~t指令用于制表。
    当formate看到~{的时候，下一个被使用的参数必须一个列表，foramte在列表上循环操作，处理位于~{和}~之间的指令，同时每次需要时
    ，从列表上使用尽可能多的元素，
    ~%不消耗任何实参，就是换行。

#‘  
    获取函数，其名如下的意思，就是这个符号的意思获取一个函数。    
    
当lisp看到一个诸如field或value这样的简单名字不作为列表的第一个元素出现时，他会假设这是一个变量的名字并去查找它的值(否则是函数啊)，这对于field和value来说是正确的，但是对于诸如 equal,getf,等就是不对的了，这个时候我们需要quote，，可以简写为’，就是单引号，

位于表达式之前的反引号可以像引号那样阻止表达式被求值，不同的是，在一个反引用表达式里，任何以逗号开始的子表达式都是被求值的，</t>
<t tx="newlife.20111101232018.1171">   (defun primep (number)           
     (when (&gt; number 1)                                                                                              
             (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))
;;这个是判断一个数是否是素数

(defun next-prime (number)                                                                                                                        
          (loop for n from number when (primep n) return n)  )
;;求当前数下一个素数,从这里可以看到loop可以没有to，因为后面有return可以结束循环。

(do                                                                                                                                               
          ((p (next-prime 0) (next-prime (1+ p)))) ((&gt; p 19))                                                                                              
          (format t "~d~%" p))  
;;这是不用宏的情况

由于传递给宏的实参是代表宏调用源代码的lisp对象，因此任何宏的第一步工作就是提取出哪些对象中用于计算展开式的部分。对于哪些简单的直接降实参直接插入到模板的宏而言，这一步很简单，</t>
<t tx="newlife.20111103185120.1173">/Users/newlife/commonlisp/klprj/ext-blog/src/routers.lisp

这个是处理url的文件，这是所有程序的入口，以后就看它了，



(restas:define-route index ("index")
    (format-args :normal))
#这是定义了一个叫index的url，对应处理的逻辑就是(format-args :normal)
(defun format-args (type &amp;rest args)
   (list :blog *blog* :args args :type type))
#这个函数的实际意义就是返回如下所以的list，
109EXT-BLOG&gt; (format-args :normal)
110(:BLOG #&lt;BLOG {100297DCC3}&gt; :ARGS NIL :TYPE :NORMAL)
看这个意思，应该是有哪个函数处理这个问题，但是问题是那个函数呢？、这个问题ms要看文档了，可是那个发指的文档那个也没看见啊
纠结啊

这个文档从来没有认真看过一遍，真是快的那条路就是我们当初认为最慢的




ext-blog里的每个route都返回的是一些数据，不是单纯的字符串。因为我要把ext-blog核心模块与具体的渲染隔离开（因为具体的渲染涉及到博客页面在浏览器端怎样显示），所以我把渲染工作交给所谓的theme去做。

总之，大概的流程就是：

[http client]   --http request--&gt;   [restas]  ----&gt; [your route function result] ---&gt; [drawer]  --http response --&gt; [http client]

</t>
<t tx="newlife.20111106084942.1175">定义了route后，route的返回值将被返回给浏览器。但这些结果需要经过一点加工。这个加工者就是http://restas.lisper.ru/en/manual/view.html#view这篇文档里描述的drawer。默认的drawer可以处理字符串、静态文件之类。如果需要进行更复杂的渲染，可以通过设置restas:*default-render-method*来重写这个规则，例如ext-blog里：

;; drawer-dispatch.lisp

(defmethod restas:render-object ((drawer drawer-dispatcher) (data list))
  (let* ((blog (getf data :blog))
         (theme (get-theme blog data)))
    (if theme
      (render-page blog theme (restas:route-symbol restas:*route*) (getf data :args))
      (car (getf data :args)))))

(setf *default-render-method* (make-instance 'drawer-dispatcher))

@doc
从这里可以看出，restas的意图很明显，router返回的数据是交给*default-render-method*处理的，但是我们可以重写这个东西，
这里有一个疑问，就是我们重写了这个函数会不会影响其他的处理比如路径名，状态码等等的东西。

(defgeneric restas:render-object (drawer object)
  (:documentation "Render object via drawer"))


It is always called for processing the data returned by route handlers (defined with restas:define-route). 
route返回的数据都是由这个广义函数处理的，
As you see here, two objects are used for content generation: a drawer and a data object, so one can speak about full-fledged logic and view separation, and CL multimethods make this approach quite powerful. 

The drawer to use is specified in module variable *default-render-method* and is set to nil by default.
这个drawer有moduel变量*default-render-method*设定，默认被设为nil
RESTAS defines specialized restas:render-object methods, which can accept the following types:</t>
<t tx="newlife.20111124223215.1177">关于这个框架，我要学习到什么程度呢，
可以用它熟练的写出一个blog，还是更多？
其实目前这个框架于我而言，最多的是体会更多的书上描述的哪些，对整个语法和函数库的熟悉，目前就是这个功能</t>
<t tx="newlife.20111124223215.1178">@ignore
@doc
##because leo will show cl code using python syntax

@language common lisp
;;;;
;;;; iSimple theme, ported by Kevin Lynx for ext-blog.
;;;; 6.12.2011
;;;; drawer.lisp
;;;;
;;;; in django`s properstive,it is the view part 
(in-package #:ext-blog.theme.isimple)

(defconstant +page-cnt+ 3)

(defgeneric render-content (blog route args)
  (:documentation "Generic function to render page content."))

(defun get-post-by-args (blog args)
  "Get a post object by args"
  (let ((id (car args)))
   (if id 
     (or (get-nth-post blog id)
         (get-1st-post blog))
     (get-1st-post blog))))

(defun get-post-title-by-args (blog args)
  (let ((id (car args))
        (post))
    (when id
      (setf post (get-nth-post blog id)))
    (if post
      (concatenate 'string (post-title post) " - " (blog-title blog))
      (blog-title blog))))

(defun render-comment (blog route args)
 (if (has-post-p blog)
   (if (and (not (eql route 'index))
            (not (eql route 'view)))
     nil
     (isimple.view:comment
       (let ((post (get-post-by-args blog args)))
         (list :comment_cnt (get-post-comments-cnt blog post)
               :comments (get-post-comments-data blog post)
               :postid (post-id post)))))
   nil))

(defun render-sidebar (blog route args)
  (declare (ignore route args))
  (isimple.view:sidebar 
    (list :posts (get-recent-posts-brief blog 5)
          :comments (get-recent-comments-brief blog 5)
          :feedurl (ext-blog:make-full-feed-url))))

(defmethod ext-blog:render-page (blog (theme theme) route args)
  (let ((content (render-content blog route args))
        (sidebar (render-sidebar blog route args))
        (header (isimple.view:header (get-head-data blog)))
        (footer (isimple.view:footer (get-footer-data blog))))
    (isimple.view:finalize-page 
      (list :title (blog-title blog)
            :header header
            :sidebar sidebar
            :content content
            :footer footer))))

(defmethod ext-blog:render-page (blog (theme theme) (route (eql 'view)) args)
  (let ((content (render-content blog route args))
        (comment (render-comment blog route args))
        (sidebar (render-sidebar blog route args))
        (header (isimple.view:header (get-head-data blog)))
        (footer (isimple.view:footer (get-footer-data blog))))
    (isimple.view:finalize-page 
      (list :title (get-post-title-by-args blog args)
            :header header
            :sidebar sidebar
            :comment comment
            :content content
            :footer footer))))

(defmethod render-content (blog (route (eql 'index)) args)
  (declare (ignore args))
  (isimple.view:page
    (get-page-data blog +page-cnt+ 0)))

(defmethod render-content (blog (route (eql 'page)) args)
  (isimple.view:page
    (get-page-data blog +page-cnt+ (car args))))

(defmethod render-content (blog (route (eql 'view)) args)
  (let* ((post (get-post-by-args blog args)))
     (isimple.view:single
       (if post
         (get-post-data blog post)
         (list :title "None" :content "No entry")))))

</t>
<t tx="newlife.20111124223215.1179">由route handler返回的数据总是由restas:render-object这个广义函数来处理：
    (defgeneric restas:render-object (drawer object)
        (:documentation "Render object via drawer"))
我们可以看到有2个对象哟个俩生成内容，一个drawer和一个data对象，

这个drawer是有module变量*default-render-method*指定的，并且默认被设置为nil，
默认的处理很多情况，restas定义了特殊的render-object方法，可以接受string ,array,pathname,interger，
我们可以指定*default-render-method*

If you follow a small agreement and give templates the same names as routes have, then you can specify as *default-render-method* the package containing template functions, and RESTAS for processing a data generated by a route handler will automatically call a template function with the same name as the route, but from package with templates. 

如果你遵循templates和route名称一致的原则，你可以制定一个*defaulte-render-method*包含模板函数的包，然后，restas就会自动调用和route含有相同名字的模板函数来处理route handler返回的数据。</t>
<t tx="newlife.20111129230956.1175">@doc
Introduction

Purpose of this document
文档的目的
The aim of this document is to give a brief introduction to the use of ASDF, Another System Definition Facility. It is not about the arcane tricks and tips, and is not about the design of ASDF itself nor about system definition tools in general.

这篇文章的目的是简要介绍asdf的用法。不是关于她神秘的技巧和用法，也不是asdf的设计或者系统定义工具。

A system definition file is nothing else than a description of dependencies between files of source code in such a way that they can be compiled and loaded in the right order. A file A.lisp depends on a file B.lisp if the latter contains definitions and/or code that is used by A.lisp1.
系统定义文件就是关于源文件之间的依赖的描述，通过这个文件他们可以以正确的顺序加载并编译

Solving this problem is in the vast majority of cases fairly trivial, so hacking up some minimal script will usually work. Learning the right tool, however, will save you a lot of time down the road. In this minitutorial we will concentrate on the simple cases and on the general usage of a fairly well known tool, ASDF. We leave the more advanced features of this tool to the ASDF manual2.
学习正确的工具会节省你大量的时间，这个迷你的教程里，我们会说明一些简单的案例，关于一些简单的使用，关于一个众所周知的工具asdf，我们留下更高级的特性介绍到asdf的手册里。

What problem does ASDF solve?
asdf解决了什么问题？

When you download the source code of some software from the Internet, or get it from some other source, you usually do not get an amorphous bunch of files, but instead get a system of components that depend on each other in some particular way. The consequence of this is that, if you want to build the software (be it a library, or be it an application), you will probably have to build these components, and the components of these components in order, perhaps giving some special treatment to some of them. You would, of course, be very grateful if the developer had prepared everything, and you could trigger the build process by a single command.

当你通过internet下载了某些软件的源码，一般不是一堆混乱的文件，而是一个组件的系统，这些组建用某些方式相互依赖。


If you are a developer working in a project with a few components, you will probably want some mechanism that keeps track of the dependencies between these components, so that if you change one component, triggering a rebuild only recompiles and reloads the components which are affected.

如果你是一个工作在有几个组件的项目的开发者，你或许会想要一些机制来记录组件之间的的依赖。这样，当你改变一个组件，重新生成使只要重新编译和加载他影响的组件，

Finally, you probably want a consistent way of dealing with the dependencies between components and of building and loading software systems, simply because it saves everyone time when installing software and using software.

ASDF is, roughly speaking, an extensible facility for defining the dependencies between software components, and specifying eventual details of the build process. It is also in fairly wide use, so that you can assume that your system definition will be understood by many others.

The same can be said about mk:defsystem, which has fans as well as detractors. We will only concentrate here on ASDF, since we have to start somewhere. In any case, the actual differences between these two only become apparent for the power user.


How to use system definition files
如何使用系统定义文件(就是.asd文件)

System definition files live in the directory where the corresponding piece of software lives. However, you do not need to have that directory as your working directory to be able to build and load said software. You only need to put a symbolic link to the system definition file in a directory where ASDF searches.
系统定义文件就在对应的软件的根目录下。当然，你不用用那个目录作为你的工作目录来编译或者加载这个软件，你只要放一个符号链接到asdf搜寻的的目录就可以了，

The usual setup is as follows. To begin with, you need to have ASDF loaded. In some implementations ASDF is already loadad. In others, it is just a matter of writing

  (require 'asdf)
whereas in others you might need to install it yourself first. You can get it, in a single file, from here, and put it somewhere reasonable. For instance, if your login name was foo, in the directory /home/foo/lisp/utils/. You may also want to compile that file.
一般安装是这样的，
就是安装，，

Now, somewhere in the init file of your Common Lisp implementation (for CMUCL it would be .cmucl-init.lisp in your home directory) a 
variation of the following passage should appear.

(load "/home/foo/lisp/utils/asdf")

(setf asdf:*central-registry*
   ;; Default directories, usually just the ``current directory''
  '(*default-pathname-defaults*

    ;; Additional places where ASDF can find
    ;; system definition files
    #p"/home/foo/lisp/systems/"
    #p"/usr/share/common-lisp/systems/"))
The command to build and load system cow is

(asdf:operate 'asdf:load-op 'cow)
然后就是这个命令了
If the file cow.asd happens to be in the current working directory, the build and load process will start there. If not, ASDF will search through the directories in the central registry, and look for a system definition file named cow.asd, or for a symbolic link to one. If it finds the latter, it will follow the link to the original file, and run the build process in the corresponding directory. If it finds the file, it will run the build process in the directory where it finds it.

如果cow.asd正好在这个目录下，编译和加载的过程就开始了，没有的话，asdf就去*central-registry*这个地方去找去了，或者文件，或者符号链接，


So, if you make a symbolic link in /home/foo/lisp/systems/ to the cow system definition file, by executing (for example)

$ cd &lt;where-your-system-defs-are&gt;
$ ln -s /home/foo/code/cow/cow.asd
Then you can build and load the cow software without having to be in the directory where this software lives simply by issuing the command

(asdf:operate 'asdf:load-op 'cow)</t>
<t tx="newlife.20111130230003.1177">@doc

What it is
asdf是神马
ASDF is a tool for describing how source files are organized: what depends on which and when.
asdf一个藐视源文件如何组织的工具：谁，何时依赖什么
It is roughly what Common Lisp hackers use to build software where C hackers would use say GNU Make.
它大致就是cl用户原来创建软件，c用户称之为GNU make

ASDF stands for Another System Definition Facility, in the continuity of the Lisp DEFSYSTEM of yore.
asdf是Another System Definition Facility的缩写。

What it is not
asdf不是神马
ASDF will not download missing software components for you. For that, you want Quicklisp, that builds upon ASDF, and is great for pulling and installing tarballs of packages you may depend upon; 
asdf不会为你下载缺少的软件包。对于这个需求，你需要quicklisp,它基于asdf，是一个强大的下载安装工具，
we also recommend clbuild, that now builds upon Quicklisp, as a great tool for pulling from version control packages you need to modify or want to contribute to. 
##这个还不用
We recommend you should not use ASDF-Install anymore, as it is an older similar piece of software that is both unmaintained and obsolete.
我们建议你不再使用asdf-install，这个东西已经废弃，不被维护了，

If you're unsatisfied with ASDF, other actively maintained build systems for Common-Lisp that may or may not satisfy you include: François-René Rideau's XCVB (trying to build object and image files deterministically and in parallel), or its polar opposite, Drew McDermott's YTools (trying maintain coherence of the current Lisp image at a fine grain). Older systems that are not maintained anymore include Mark Kantrowitz's mk-defsystem (free software successor of the old proprietary DEFSYSTEM's and predecessor of ASDF), Sean Ross's mudballs (aborted attempt at making things cleaner than in ASDF), Peter Jetter's faslpath (a much simpler system integrating mapping packages to files), Alexander Kahl's evol (a reimplementation of the GNU autotools stack in Lisp), and probably more. However, none of these systems seems to ever have had the traction of ASDF.</t>
<t tx="newlife.20111130230003.1178">@doc
4.1 Loading a system

The system foo is loaded (and compiled, if necessary) by evaluating the following Lisp form:

     (asdf:load-system :foo)
On some implementations (namely recent versions of ABCL, Clozure CL, CLISP, CMUCL, ECL, SBCL and SCL), ASDF hooks into the CL:REQUIRE facility and you can just use:
     (require :foo)
软件foo被加载（如果需要就编译）通过下面的语句：
   (asdf:load-system :foo)
在一些lisp实现（）上，asdf被cl：require实现，直接用(require :foo)就可以了

In older versions of ASDF, you needed to use (asdf:oos 'asdf:load-op :foo). If your ASDF is too old to provide asdf:load-system though we recommend that you upgrade to ASDF 2. See Loading an otherwise installed ASDF.

在一些老的版本，你需要使用(asdf:oos 'asdf:load-op :foo)，如果你的asdf太老不提供asdf:load-system，我们建议你升级到asdf2，

Note the name of a system is specified as a string or a symbol, typically a keyword. If a symbol (including a keyword), its name is taken and lowercased. The name must be a suitable value for the :name initarg to make-pathname in whatever filesystem the system is to be found. The lower-casing-symbols behaviour is unconventional, but was selected after some consideration. Observations suggest that the type of systems we want to support either have lowercase as customary case (unix, mac, windows) or silently convert lowercase to uppercase (lpns), so this makes more sense than attempting to use :case :common, which is reported not to work on some implementations</t>
<t tx="newlife.20111204034558.1181">quicklisp是commonlisp的包管理工具，类似aptget或者pip的一个东西。

在我所运行的环境上，所有的lisp文件都会被编译成为fasl文件存放在用户目录下的.cache目录下，
当每次作(ql:update-all-dists)这个操作以后，都要删除这个目录，重新编译生成，</t>
<t tx="newlife.20111208221053.1183">on lisp绝对是一本相当值得一读的书，这个坑的意义就在于认真的看完这本书。
我相信，看完这本的时候，我对lisp的宏的理解会到达一个新的高度，lisp的本质就是宏，不是末？
</t>
<t tx="newlife.20111208221053.1184">通常来说，数据结构被原来描述事物。可以用数组来描述坐标变换，用树结构表示命令的层次结构，而用图来表示铁路网。


</t>
<t tx="newlife.20111208221053.1185">auth.lisp      
drawer-dispatch.lisp 
model                
routes.lisp          
rss.tmpl             
themes.lisp          
verify-code.lisp
defmodule.lisp       
ext-blog.lisp        
params.lisp          
rss.lisp             
rsstmpl.lisp         
utils.lisp           
xmlrpc.lisp
</t>
<t tx="newlife.20111208221053.1186">要想熟悉一个语言，一个项目，首先就是要做些什么东西，
我改进ext-blog对post
    增加分类的支持，
    然后tag的支持
    对数据库的支持</t>
<t tx="newlife.20111208221053.1187">分类作为一个首要的支持在于简单，

这个东西耦合的ms很严重啊。
比如我要增加一个category的东西，我要修改的地方很多啊，这玩意和django比起来，那差的可不是一点半点啊，这也就充分说明了我还由很大的发挥的空间，今天fp有个讨论很合我的心意</t>
<t tx="newlife.20111215103224.1193">http://norvig.com/python-lisp.html
这篇文章写的是相当的神奇啊，有时间翻译一下

这是一篇给lisp程序员的python的简单介绍（虽然这不是我的初衷，但是python程序员告诉我这个页面帮助他们学习了lisp,囧）
简单的说，python可以看做是一个有着传统语法(就是中缀表达式吧)的lisp方言，comp.lang.python有句话，我从来没有发现lisp的好，知道我开始玩python。python支持lisp的所有的核心特性，除了宏，并且你不会错过太多，因为python有eval，运算符重载，正则，，，，

我研究python是因为我在考虑lisp code翻译成java，一些学生想要java的因为：
    1，他们在别的课程里学过java
    2，他们希望有图形应用
    3，少数人希望浏览器里的applet
    4，有一些在他们有限的时间内不能熟悉lisp
    
但是，我们第一次尝试用java写是非常的不成功。（开始了，）java太繁琐了，而且书中的伪码和java代码之间的差异很大，
我寻找一种看起来想书中的伪码的语言，发现python是最接近的，更进一步，还有jython。。

结论
    </t>
<t tx="newlife.20111219151241.1195">关于标签的定义部分已经结束，现在的问题是如何处理模板的继承问题，</t>
<t tx="newlife.20111219151241.1196">就是cl-closure-template

这个东西的继承是如何实现的？？

我们先分析/manage/new


先看drawer.lisp这个东西是怎么写的，，

先有一个广义函数：manage-render-content,,,


还有一个函数  render-manage-page,在这个函数里，调用了manage-render-content这个函数，

然后处理的是post参数的问题，
这个ms没有什么需要特别注意的，看demo就是了</t>
</tnodes>
</leo_file>
