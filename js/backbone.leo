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
<v t="newlife.20120330145629.1126" a="E"><vh>backbone</vh>
<v t="newlife.20120330145649.1127"><vh>stumbling</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20120330145629.1126"></t>
<t tx="newlife.20120330145649.1127">@doc

Question:

    I just stumbled upon something I've never seen before. In the source of Backbone.js's example TODO application (Backbone TODO Example) They had their templates inside a &lt;script type = "text/template"&gt;&lt;/script&gt;, which contained code that looks like something out of PHP but with javascript tags
    
    Can someone explain this to me? Is this legit?
    我被一个从没遇见过的事情困住了.在backbone的todo应用,templates放在&lt;script type = "text/template"&gt;&lt;/script&gt;里面,里面放着一些代码看起来像php但是有js tag
    
Answer:
Those script tags are a common way to implement templating functionality (like in PHP) but on the client side.

这些标签是在客户端实现模板功能的常用做法,

By setting the type to "text/template", it's not a script that the browser can understand, and so the browser will simply ignore it. This allows you to put anything in there, which can then be extracted later and used by a templating library to generate HTML snippets.

通过设置type为"text/template",这段脚本就成为不被浏览器理解的脚本,然后浏览器就无视它了,这就允许你放任何东西到这里.这样可以一会提取出来,用于模板库来生成html代码片段


Backbone doesn't force you to use any particular templating library - there are quite a few out there: Mustache, Haml, Eco, and so on (the one used in the example you linked to is underscore.js). These will use their own syntax for you to write within those script tags.

backbone不强制使用特定的模板库,有很多,比如Mustache, Haml, Eco等等</t>
</tnodes>
</leo_file>
