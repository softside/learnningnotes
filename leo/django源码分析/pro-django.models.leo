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
<v t="wjl.20100906023207.1322"><vh>@chapters</vh></v>
<v t="wjl.20100906023207.1321"><vh>preface</vh></v>
<v t="newlife.20110210151240.1276" a="E"><vh>models</vh>
<v t="wjl.20100906023207.1323"><vh>how Django Process Model Classes </vh></v>
<v t="wjl.20100906234257.1249"><vh>Setting Attributes on MOdels</vh></v>
<v t="wjl.20100906023207.1324"><vh>Common Field Methods</vh></v>
</v>
<v t="newlife.20110210151240.1277" a="E"><vh>forms</vh>
<v t="wjl.20110210202653.1257"><vh>intro</vh></v>
<v t="newlife.20110210151240.1278"><vh>about</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110210151240.1276">from django.db import models

class Entry(models.Model):
    title = models.CharField(max_length=225)
    pub_date = models.DateTimeField()
    body = models.TextField()
    
    def __unicode__(self):
        return self.title
        
&gt;&gt;&gt;from blog.models import Entry
&gt;&gt;&gt;Entry.objects.all()

select *from blog_entry;

上面是一个标准的django　orm的工作流程，更详细的流程是下面这个：
Model
   ||
Manager
   ||
Query
   ||
SQLCompiler
  ||
Datebase backend
  


</t>
<t tx="newlife.20110210151240.1277"></t>
<t tx="newlife.20110210151240.1278">关于django的forms：
先说程序结构：
class Form(BaseForm):
    "A collection of Fields, plus their associated data."
    # This is a separate class from BaseForm in order to abstract the way                                                                                                        
    # self.fields is specified. This class (Form) is the one that does the                                                                                                       
    # fancy metaclass stuff purely for the semantic sugar -- it allows one                                                                                                       
    # to define a form using declarative syntax.                                                                                                                                 
    # BaseForm itself has no way of designating self.fields.                                                                                                                     
    __metaclass__ = DeclarativeFieldsMetaclass
父类BaseForm,元类DeclarativeFieldsMetaclass，够简单吧。

DeclarativeFieldsMetaclass
这个类中只是定义了一个__new__的方法，我们知道__new__是在创建对象前就执行的，返回的是当前对象的一个实例；而相对__init__则是在对象创建以后才执行的，没有返回值。

下面这是BaseForm的注释：
    # This is the main implementation of all the Form logic. Note that this               
    # class is different than Form. See the comments by the Form class for more           
    # information. Any improvements to the form API should be made to *this*              
    # class, not to the Form class. 
BaseForm是Form的所有的逻辑的只要实现，这个类和Form不一样，所有关于form API的改进都应该从这个类中实现而不是Form这个类。
看BaseForm都是怎么实现Form的功能的，

Form的元类中定义的__new__的方法，这个方法的主要作用就是把form的字段（Filed）转换到一个字典中。


关于通过两种方式获得的field
In [15]: form.fields.get('username')
Out[15]: &lt;django.forms.fields.RegexField object at 0x9fb72cc&gt;


In [16]: form['username']
Out[16]: &lt;django.forms.forms.BoundField object at 0x9fb778c&gt;

这个东西为啥要这么设计。

In [17]: print form['username']
&lt;input id="id_username" type="text" name="username" maxlength="30" /&gt;

这里出现了2个field类，
django.forms.forms.BoundField和django.forms.fields.RegexField从这两个类所处的位置就可以看出他们不同的地位，
#TODO 因为forms和models都用到了



</t>
<t tx="wjl.20100906023207.1321">数据是大部分 web 应用的核心， django 提供各种数据结构和持久化选择的支持。 models 是传统 mvc 的主要方面， django 支持的很好。 Models 是所有需要通过 request, session, 甚至服务端来保存数据的应用的核心部分。

django 的 models 被定义为标准的 python 类，还有自动支持的丰富的特性。暗地里，一个 orm 支持这些类以及这些类的实例去访问数据库。没有这个 orm ，开发者需要直接处理数据库，用 sql 语句，标准的访问数据库内容的方式。

sql 语句的主要作用是描述和访问存储在关系数据库中的关系。 sql 语句通常不给应用提供高级的关系，所以大部分应用需要手写 sql 语句来进行数据访问。这个当然是可以的，但是会导致大量的重复工作，这个就和 dry 原则冲突了。

这些充斥整个应用的 sql 语句会变的不可管理，尤其是处理的这些程序的 coder 对关系数据库不擅长。这个同时也意味着这些数据库任意产生 bugs ，这些 bug 通常都是难以追踪和改正的。

这些还没有说到最重要的问题，安全。 sql 注入攻击是恶毒的黑客去访问和修改他们本来不应被访问的数据的惯用手法，这个产生在手写的 sql 语句没有对进入数据库的数据合适的考虑。手写的 sql 语句越多，被攻击的可能性就越大。

所有的这些问题在 web 开发中都是很普遍的，不管什么语言，对于框架来说 orm 是一个通用的方法来减轻这些问题。当然还有其他的方法来避开这些问题，比如说 sql 注入，但是 django 的 orm 在写的时候就考虑了这些问题，并且暗地里处理了很多，通过标准 python 对象来访问数据， sql 语句的数量被减少，产生问题的可能性也减少，</t>
<t tx="wjl.20100906023207.1322">走了这么久，终于回到 pro- django 来了，这次分析的 model 这个类

绕这么一大圈，注定这个东西是要在这里处理的，这个是东西的意义是非常重大的，以后对于调优和分析其他的orm都是又很大的帮助的。</t>
<t tx="wjl.20100906023207.1323">第二章已经描述了， Django 辨识度最高的一个特性是他的对 model 的声明式语法。有了这个， model 定义就非常简单并且精确，用 metaclasses 来实现声明式语法已经在第二章描述过了，但是处理 models 还有更具体的步骤，这些更值得关注。

负责处理 model 定义的元类是 ModelBase. 提供了一些关键的特性，按照动作发生的顺序列在下面。

1,
</t>
<t tx="wjl.20100906023207.1324">CONTRIHBUTE_TO_CLASS():
    描述了绑定到这个类的 FIELD ， FIELD 类中最重要的方法，当 MODELBASE 处理被声明到 MODEL 的属性的时候被调用, 被调用的时候是 FIELD.CONTRIBUTE_TO_CLASS(CLS,NAME), CLS 是绑定方法的 MODEL, NAME 是给这个 FIELD 的名字.这个方法给了 FIELD 执行任何设定的机会.一般这个方法不直接被调用, 但是是一个有用的方法来对需要提前处理的 MODEL 的 FIELD.</t>
<t tx="wjl.20100906234257.1249">PYTHON 对于在不知道对象名字的情况下给对象赋值和取值提供了有用的工具。但是 getattr()和 setattr()代表了标准的访问对象数据的方法， django 的一个处理 model 属性的钩子需要一些额外的处理， Django 提供了一个类方法， add_to_class(), 对于所有的 model ，这个应该是 setattr()的替代品。

add_to_class()的语法和语义和传统的函数有些差别，他确实是一个类方法，不是 built- in 或者 moudule- levelde, 这就意味着第一个参数不是被明确指定的而是模糊的，这个方法检查了提供给 contribute_to_class()方法的值。，并且当他存在的时候调用他。另外，标准的 setattr()函数用来给 model 增加 value 。这2个方法是互斥的。当 add_to_class 被调用的时候只有一个会被调用。还有一点非常重要的是，这个不仅在 django 内部适用。当应用需要给 model 怎加一个对象作为属性的时候，他必须调用 add_to_class.这样， django 开发者就可以传递任何对象给 model ，并且确定这个对象就像 model 定义的一样直接赋给 model 。</t>
<t tx="wjl.20110210202653.1257">  /home/wjl/Django-1.2/django/forms:
  总用量 172
  drwxr-xr-x  3 wjl wjl  4096 2010-05-18 02:02 .
  drwxr-xr-x 17 wjl wjl  4096 2011-01-09 01:07 ..
  drwxr-xr-x  2 wjl wjl  4096 2010-05-18 02:02 extras
  -rw-r--r--  1 wjl wjl 34827 2010-03-28 00:43 fields.py
  -rw-r--r--  1 wjl wjl 14277 2010-03-28 07:03 formsets.py
  -rw-r--r--  1 wjl wjl 21198 2010-03-28 00:43 forms.py
  -rw-r--r--  1 wjl wjl   414 2010-01-05 11:56 __init__.py
  -rw-r--r--  1 wjl wjl 43157 2010-05-04 22:00 models.py
  -rw-r--r--  1 wjl wjl  1983 2010-01-05 11:56 util.py
  -rw-r--r--  1 wjl wjl 29401 2010-04-28 11:02 widgets.py
观察forms包的分类，具体就是上面几个类了，现在具体的说说每个类都是干啥用的，

__init__.py：啥都没干，就是导入一些需要用到的类，方便我们用的时候。直接导入froms，不用逐个导入需要的类。

froms.py :这个文件中最重要的了就是Form这个类，其他的就是辅助这个类，
          就是我们平常创建自己的form的时候：
          class ForgotPasswordForm(forms.Form):
          这个类是所有自定义form的父类。

models.py:这个是处理ModelForm的，基本的结构和Form这个类是相似的，都是继承实现逻辑的父类，指定元类。
          class articleForm(forms.ModelForm):

fields.py:这个就是我们处理form是的各种类型，这个类型和Model的类型有点像，但是数量要少，</t>
</tnodes>
</leo_file>
