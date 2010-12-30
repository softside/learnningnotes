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
<v t="newlife.20101123145721.1243"><vh>@chapters</vh></v>
<v t="newlife.20101129143845.1247" a="E"><vh>year</vh>
<v t="newlife.20101201170601.1249"><vh>&lt;&lt;2001&gt;&gt;</vh></v>
<v t="newlife.20101201170601.1250" a="M"><vh>&lt;&lt;2002&gt;&gt;</vh></v>
<v t="newlife.20101201170601.1250" a="M"></v>
<v t="newlife.20101201170601.1251"><vh>2003</vh></v>
</v>
<v t="newlife.20101123145721.1242" a="E"><vh>Diary @root</vh>
<v t="newlife.20101202114620.1254"><vh>&lt;&lt;hhh&gt;&gt;</vh></v>
<v t="newlife.20101201170601.1250" a="M"></v>
<v t="newlife.20101202114620.1255"><vh>@file /home/newlife/桌面/到 leo 的链接/hello</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20101123145721.1242">@silent
@root  "hello"

&lt;&lt; hhh &gt;&gt;
&lt;&lt; 2002 &gt;&gt;</t>
<t tx="newlife.20101123145721.1243">@doc
This file is just for practising the use of leo

In this section ,we learn from http://www.3dtree.com/ev/e/sbooks/leo/sbframetoc_ie.htm.

I just try the @file and @root ,this two directives,and the outline,

next, I will try other examples, the perl utilities

</t>
<t tx="newlife.20101129143845.1247">@silent
@root year.txt






this is my diary

hahahha 
&lt;&lt; 2001 &gt;&gt;</t>
<t tx="newlife.20101201170601.1249">This text here will be skipped,

@c

you will see me in the year.txt file</t>
<t tx="newlife.20101201170601.1250">@code

This tutorial has given you a brief introduction of Leo:

Outlining capacity
提纲功能

Ability to create derived files.
创建衍生文件
fdfsd
These two things are the main features of Leo. However, there is much more to say about both of them:
这2个功能是Leo的主要特性，还有很多要说的：（你倒是说阿。。）

Outlining - see the Outlining tutorial in this series to see how Leo can be used to create outlines with multiple paths or views, making it a powerful tool for project planning or any kind of tree-based analysis.

Derived files - we have seen the simple case of deriving a text file from a set of nodes. This gives  you the ability to collect a number of text files in one Leo outline.
It also allows you to  associate an outline with a separate text file. But Leo can not only extract a text file from an outline, it can embed an outline in a text file and read it back. 
For more about this feature, see the next tutorial in this series: What is Leo - Continued. In addition, in the following tutorials you will see much more complex examples of derived files.


Literate Programming - the ability to associate an outline and extra text with a text document means that you can write a program outline in English at any level of detail, 
then add your code to the outline, and then tangle the code into a separate program file. 
The English documentation of the program becomes a primary structural component. 
For more about Leo and Literate Programming, read on in this set of tutorials, particularly the Examples section.


这是我在文本编辑器加的哦 </t>
<t tx="newlife.20101201170601.1251">A note for programmers: 
this tutorial, in addition to being an illustration of more file derivation operations, is an introduction to how Leo can facilitate a new kind of Literate Programming . 
程序员注意，这个教程除了证明leo对衍生文件的操作，还是一个对文学式编程的一个介绍。

Rather than further clarify what this means now, 
不解释！
we will just show an example. More information about Literate Programming is available in the documentation that comes with Leo. 
我们将给出一些例子，

But keep in mind that the problem to be solved by literate programming is to provide an easy-to-understand road map to a complex programming project. 

文学式编程解决的问题是如何容易的理解复杂的软件项目。

Using Leo, you plan your code, explain it, and write it all in the same document. 
用Leo，组织你的代码，解释你的代码，然后写在一个文件里。

You use English, not a new language like UML, and you can explain and describe all levels of structure in as many ways as you want - not just classes and methods.

你用英文（nb你用中文!!）,不是像uml的新语言，你可以解释和描述各个level的结构，不仅仅是类或者方法。</t>
<t tx="newlife.20101202114620.1254">fgdjklgjdflkgjkldfjgdsfgsefsdf</t>
<t tx="newlife.20101202114620.1255">@ignore
@language unknown_language

This tutorial has given you a brief introduction of Leo:

Outlining capacity
提纲功能

Ability to create derived files.
创建衍生文件
fdfsd
These two things are the main features of Leo. However, there is much more to say about both of them:
这2个功能是Leo的主要特性，还有很多要说的：（你倒是说阿。。）

Outlining - see the Outlining tutorial in this series to see how Leo can be used to create outlines with multiple paths or views, making it a powerful tool for project planning or any kind of tree-based analysis.

Derived files - we have seen the simple case of deriving a text file from a set of nodes. This gives  you the ability to collect a number of text files in one Leo outline.
It also allows you to  associate an outline with a separate text file. But Leo can not only extract a text file from an outline, it can embed an outline in a text file and read it back. 
For more about this feature, see the next tutorial in this series: What is Leo - Continued. In addition, in the following tutorials you will see much more complex examples of derived files.


Literate Programming - the ability to associate an outline and extra text with a text document means that you can write a program outline in English at any level of detail, 
then add your code to the outline, and then tangle the code into a separate program file. 
The English documentation of the program becomes a primary structural component. 
For more about Leo and Literate Programming, read on in this set of tutorials, particularly the Examples section.


这是我在文本编辑器加的哦 

这个是在leo的 @file 加的。
</t>
</tnodes>
</leo_file>
