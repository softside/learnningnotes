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
<v t="newlife.20120330145629.1126"><vh>backbone</vh>
<v t="newlife.20120330145649.1127"><vh>stumbling</vh></v>
</v>
<v t="newlife.20120406223133.1415"><vh>backbone-fundamentals</vh>
<v t="newlife.20120406223133.1416"><vh>model</vh></v>
</v>
<v t="newlife.20120330230358.1353"><vh>example</vh>
<v t="newlife.20120330232629.1355"><vh>examples/todos/index.html</vh>
<v t="newlife.20120330232629.1356" a="E"><vh>head</vh>
<v t="newlife.20120330232629.1357"><vh>title</vh></v>
<v t="newlife.20120330232629.1358"><vh>link</vh></v>
</v>
<v t="newlife.20120330232629.1359" a="E"><vh>div</vh>
<v t="newlife.20120330232629.1360"><vh>h1</vh></v>
<v t="newlife.20120330232629.1361"><vh>label</vh></v>
<v t="newlife.20120330232629.1362"><vh>ul</vh></v>
<v t="newlife.20120330232629.1363"><vh>a</vh></v>
<v t="newlife.20120330232629.1364"><vh>div</vh></v>
</v>
<v t="newlife.20120330232629.1365"><vh>div</vh></v>
<v t="newlife.20120330232629.1366"><vh>div</vh>
<v t="newlife.20120330232629.1367"><vh>br</vh></v>
<v t="newlife.20120330232629.1368"><vh>a</vh></v>
<v t="newlife.20120330232629.1369"><vh>br</vh></v>
<v t="newlife.20120330232629.1370"><vh>a</vh></v>
</v>
<v t="newlife.20120330232629.1371"><vh>script</vh></v>
<v t="newlife.20120330232629.1372"><vh>script</vh></v>
<v t="newlife.20120330232629.1373"><vh>script</vh></v>
<v t="newlife.20120330232629.1374"><vh>script</vh></v>
<v t="newlife.20120330232629.1375"><vh>script</vh></v>
<v t="newlife.20120330232629.1376"><vh>script</vh></v>
<v t="newlife.20120330232629.1388"><vh>script #item-template</vh></v>
<v t="newlife.20120330232629.1389"><vh>script #status-template</vh></v>
</v>
<v t="newlife.20120330232629.1385" a="E"><vh>examples/todos/todos.js</vh>
<v t="newlife.20120330232629.1386"><vh>todos declarations</vh></v>
<v t="newlife.20120330232629.1387"><vh>function</vh></v>
</v>
<v t="newlife.20120330232629.1390" a="E"><vh>note</vh>
<v t="newlife.20120330232629.1391"><vh>django-backbones</vh></v>
</v>
</v>
<v t="newlife.20120410205638.1424"><vh>js语法基础</vh></v>
<v t="newlife.20120330232629.1392"><vh>实现思路</vh></v>
<v t="newlife.20120406223133.1417"><vh>悟透</vh>
<v t="newlife.20120406223133.1418" a="E"><vh>note</vh>
<v t="newlife.20120410205638.1423"><vh>code</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20120330145629.1126">backbone是一个很强大的东西,目前看来大有横扫前端的趋势啊</t>
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
<t tx="newlife.20120330230358.1353" annotate="7d71002855087072696f7269747971014d0f27550870726f6772657373710255007103550874696d655f726571710468035507637265617465647105636461746574696d650a6461746574696d650a710628550a07dc031e171835043c937107747108527109752e" lineYOffset="4b002e">@doc

在backbone的项目中只有一个例子,就是todo,下面我们着重学习下这个例子,体会下先进的前段开发工具

就是这么个简单的todo也不简单啊</t>
<t tx="newlife.20120330232629.1355">@language xml
@tabwidth -4
@others
&lt;/body&gt;
&lt;/html&gt;
</t>
<t tx="newlife.20120330232629.1356">&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;

&lt;head&gt;
@others
&lt;/head&gt;

</t>
<t tx="newlife.20120330232629.1357">
&lt;meta charset="utf-8"&gt;
&lt;title&gt;Backbone.js Todos&lt;/title&gt;
</t>
<t tx="newlife.20120330232629.1358">&lt;link rel="stylesheet" href="todos.css"/&gt;
</t>
<t tx="newlife.20120330232629.1359">&lt;body&gt;
  
  &lt;div id="todoapp"&gt;
@others
&lt;/div&gt;
  
  </t>
<t tx="newlife.20120330232629.1360">

&lt;header&gt;
  &lt;h1&gt;Todos&lt;/h1&gt;
  </t>
<t tx="newlife.20120330232629.1361">&lt;input id="new-todo" type="text" placeholder="What needs to be done?"&gt;
    &lt;/header&gt;

    &lt;section id="main"&gt;
      &lt;input id="toggle-all" type="checkbox"&gt;
      &lt;label for="toggle-all"&gt;Mark all as complete&lt;/label&gt;
      </t>
<t tx="newlife.20120330232629.1362">&lt;ul id="todo-list"&gt;&lt;/ul&gt;
    &lt;/section&gt;

    &lt;footer&gt;
      </t>
<t tx="newlife.20120330232629.1363">&lt;a id="clear-completed"&gt;Clear completed&lt;/a&gt;
      </t>
<t tx="newlife.20120330232629.1364">&lt;div id="todo-count"&gt;&lt;/div&gt;
    &lt;/footer&gt;
    
  </t>
<t tx="newlife.20120330232629.1365">&lt;div id="instructions"&gt;
    Double-click to edit a todo.
  &lt;/div&gt;
  
  </t>
<t tx="newlife.20120330232629.1366">&lt;div id="credits"&gt;
@others
&lt;/div&gt;

  </t>
<t tx="newlife.20120330232629.1367">
Created by
&lt;br /&gt;
</t>
<t tx="newlife.20120330232629.1368">&lt;a href="http://jgn.me/"&gt;J&amp;eacute;r&amp;ocirc;me Gravel-Niquet&lt;/a&gt;.
    </t>
<t tx="newlife.20120330232629.1369">&lt;br /&gt;Rewritten by: </t>
<t tx="newlife.20120330232629.1370">&lt;a href="http://addyosmani.github.com/todomvc"&gt;TodoMVC&lt;/a&gt;.
  </t>
<t tx="newlife.20120330232629.1371">&lt;script src="../../test/vendor/json2.js"&gt;&lt;/script&gt;
  </t>
<t tx="newlife.20120330232629.1372">&lt;script src="../../test/vendor/jquery-1.7.1.js"&gt;&lt;/script&gt;
  </t>
<t tx="newlife.20120330232629.1373">&lt;script src="../../test/vendor/underscore-1.3.1.js"&gt;&lt;/script&gt;
  </t>
<t tx="newlife.20120330232629.1374">&lt;script src="../../backbone.js"&gt;&lt;/script&gt;
  </t>
<t tx="newlife.20120330232629.1375">&lt;script src="../backbone-localstorage.js"&gt;&lt;/script&gt;
  </t>
<t tx="newlife.20120330232629.1376">&lt;script src="todos.js"&gt;&lt;/script&gt;

  &lt;!-- Templates --&gt;

  </t>
<t tx="newlife.20120330232629.1385">@language javascript
@tabwidth -4
@others
@ignore</t>
<t tx="newlife.20120330232629.1386">// An example Backbone application contributed by
// [Jérôme Gravel-Niquet](http://jgn.me/). This demo uses a simple
// [LocalStorage adapter](backbone-localstorage.html)
// to persist Backbone models within your browser.

// Load the application once the DOM is ready, using `jQuery.ready`:
@doc
</t>
<t tx="newlife.20120330232629.1387">$(function(){

  // Todo Model
  // ----------

  // Our basic **Todo** model has `title`, `order`, and `done` attributes.
  var Todo = Backbone.Model.extend({

    // Default attributes for the todo item.
    defaults: function() {
      return {
        title: "empty todo...",
        order: Todos.nextOrder(),
        done: false
      };
    },

    // Ensure that each todo created has `title`.
    initialize: function() {
      if (!this.get("title")) {
        this.set({"title": this.defaults.title});
      }
    },

    // Toggle the `done` state of this todo item.
    toggle: function() {
      this.save({done: !this.get("done")});
    },

    // Remove this Todo from *localStorage* and delete its view.
    clear: function() {
      this.destroy();
    }

  });
  //定义基本的model

  // Todo Collection
  // ---------------

  // The collection of todos is backed by *localStorage* instead of a remote
  // server.
  var TodoList = Backbone.Collection.extend({

    // Reference to this collection's model.
    model: Todo,

    // Save all of the todo items under the `"todos"` namespace.
    localStorage: new Store("todos-backbone"),

    // Filter down the list of all todo items that are finished.
    done: function() {
      return this.filter(function(todo){ return todo.get('done'); });
    },

    // Filter down the list to only todo items that are still not finished.
    remaining: function() {
      return this.without.apply(this, this.done());
    },

    // We keep the Todos in sequential order, despite being saved by unordered
    // GUID in the database. This generates the next order number for new items.
    nextOrder: function() {
      if (!this.length) return 1;
      return this.last().get('order') + 1;
    },

    // Todos are sorted by their original insertion order.
    comparator: function(todo) {
      return todo.get('order');
    }

  });
  
  

  // Create our global collection of **Todos**.
  var Todos = new TodoList;

  // Todo Item View
  // --------------

  // The DOM element for a todo item...
  var TodoView = Backbone.View.extend({

    //... is a list tag.
    tagName:  "li",

    // Cache the template function for a single item.
    template: _.template($('#item-template').html()),

    // The DOM events specific to an item.
    events: {
      "click .toggle"   : "toggleDone",
      "dblclick .view"  : "edit",
      "click a.destroy" : "clear",
      "keypress .edit"  : "updateOnEnter",
      "blur .edit"      : "close"
    },

    // The TodoView listens for changes to its model, re-rendering. Since there's
    // a one-to-one correspondence between a **Todo** and a **TodoView** in this
    // app, we set a direct reference on the model for convenience.
    initialize: function() {
      this.model.bind('change', this.render, this);
      this.model.bind('destroy', this.remove, this);
    },

    // Re-render the titles of the todo item.
    render: function() {
      this.$el.html(this.template(this.model.toJSON()));
      //在这个位置this.$el就是创建了一个&lt;li&gt;&lt;/li&gt;的标签,然后就是把template生成的东西放到这个&lt;li&gt;里面
      this.$el.toggleClass('done', this.model.get('done'));
      this.input = this.$('.edit');
      return this;
    },

    // Toggle the `"done"` state of the model.
    toggleDone: function() {
      this.model.toggle();
    },

    // Switch this view into `"editing"` mode, displaying the input field.
    edit: function() {
      this.$el.addClass("editing");
      this.input.focus();
    },

    // Close the `"editing"` mode, saving changes to the todo.
    close: function() {
      var value = this.input.val();
      if (!value) this.clear();
      this.model.save({title: value});
      this.$el.removeClass("editing");
    },

    // If you hit `enter`, we're through editing the item.
    updateOnEnter: function(e) {
      if (e.keyCode == 13) this.close();
    },

    // Remove the item, destroy the model.
    clear: function() {
      this.model.clear();
    }

  });

  // The Application
  // ---------------

  // Our overall **AppView** is the top-level piece of UI.
  var AppView = Backbone.View.extend({

    // Instead of generating a new element, bind to the existing skeleton of
    // the App already present in the HTML.
    el: $("#todoapp"),

    // Our template for the line of statistics at the bottom of the app.
    statsTemplate: _.template($('#stats-template').html()),

    // Delegated events for creating new items, and clearing completed ones.
    events: {
      "keypress #new-todo":  "createOnEnter",
      "click #clear-completed": "clearCompleted",
      "click #toggle-all": "toggleAllComplete"
    },

    // At initialization we bind to the relevant events on the `Todos`
    // collection, when items are added or changed. Kick things off by
    // loading any preexisting todos that might be saved in *localStorage*.
    initialize: function() {

      this.input = this.$("#new-todo");
      this.allCheckbox = this.$("#toggle-all")[0];

      Todos.bind('add', this.addOne, this);
      Todos.bind('reset', this.addAll, this);
      Todos.bind('all', this.render, this);

      this.footer = this.$('footer');
      this.main = $('#main');

      Todos.fetch();
    },

    // Re-rendering the App just means refreshing the statistics -- the rest
    // of the app doesn't change.
    render: function() {
      var done = Todos.done().length;
      var remaining = Todos.remaining().length;

      if (Todos.length) {
        this.main.show();
        this.footer.show();
        this.footer.html(this.statsTemplate({done: done, remaining: remaining}));
      } else {
        this.main.hide();
        this.footer.hide();
      }

      this.allCheckbox.checked = !remaining;
    },

    // Add a single todo item to the list by creating a view for it, and
    // appending its element to the `&lt;ul&gt;`.
    addOne: function(todo) {
      var view = new TodoView({model: todo});
      this.$("#todo-list").append(view.render().el);
    },

    // Add all items in the **Todos** collection at once.
    addAll: function() {
      Todos.each(this.addOne);
    },

    // If you hit return in the main input field, create new **Todo** model,
    // persisting it to *localStorage*.
    createOnEnter: function(e) {
      if (e.keyCode != 13) return;
      if (!this.input.val()) return;

      Todos.create({title: this.input.val()});
      this.input.val('');
    },

    // Clear all done todo items, destroying their models.
    clearCompleted: function() {
      _.each(Todos.done(), function(todo){ todo.clear(); });
      return false;
    },

    toggleAllComplete: function () {
      var done = this.allCheckbox.checked;
      Todos.each(function (todo) { todo.save({'done': done}); });
    }

  });

  // Finally, we kick things off by creating the **App**.
  var App = new AppView;

}</t>
<t tx="newlife.20120330232629.1388">&lt;script type="text/template" id="item-template"&gt;
      &lt;div class="todo &lt;%= done ? 'done' : '' %&gt;"&gt;
        &lt;div class="display"&gt;
          &lt;input class="check" type="checkbox" &lt;%= done ? 'checked="checked"' : '' %&gt; /&gt;
          &lt;div class="todo-text"&gt;&lt;/div&gt;
          &lt;span class="todo-destroy"&gt;&lt;/span&gt;
        &lt;/div&gt;
        &lt;div class="edit"&gt;
          &lt;input class="todo-input" type="text" value="" /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/script&gt;</t>
<t tx="newlife.20120330232629.1389">&lt;script type="text/template" id="stats-template"&gt;
      &lt;% if (total) { %&gt;
        &lt;span class="todo-count"&gt;
          &lt;span class="number"&gt;&lt;%= remaining %&gt;&lt;/span&gt;
          &lt;span class="word"&gt;&lt;%= remaining == 1 ? 'item' : 'items' %&gt;&lt;/span&gt; left.
        &lt;/span&gt;
      &lt;% } %&gt;
      &lt;% if (done) { %&gt;
        &lt;span class="todo-clear"&gt;
          &lt;a href="#"&gt;
            Clear &lt;span class="number-done"&gt;&lt;%= done %&gt;&lt;/span&gt;
            completed &lt;span class="word-done"&gt;&lt;%= done == 1 ? 'item' : 'items' %&gt;&lt;/span&gt;
          &lt;/a&gt;
        &lt;/span&gt;
      &lt;% } %&gt;
    &lt;/script&gt;</t>
<t tx="newlife.20120330232629.1390">backbone.model

backbone.collection

backbone.view
    最先调用的是backbone的view</t>
<t tx="newlife.20120330232629.1391"></t>
<t tx="newlife.20120330232629.1392">想在宠四方項目中使用backbone這個東西,

为什么要使用这个东西

目前的想法是在微博的部分使用这个东西,首先要查看微博部分的实现流程,

    
    
    
总而言之,难度是有的,但是丰厚的回报也是可以看见的,</t>
<t tx="newlife.20120406223133.1415">https://github.com/addyosmani/backbone-fundamentals</t>
<t tx="newlife.20120406223133.1416">@doc

The initialize() method is called when a new instance of a model is created, its use is optional,however you will see why it is good practise to use it below.



it is best practise to use Model.set() or direct instantiation to set the values of a model`s attributes.

Accxessing Model.attributes directly is generally discourages .instead ,should you need to read or clone data, Model.toJSON() is recommended for this purpose. if you would like to access or copy a model`s attributes for purpose such as </t>
<t tx="newlife.20120406223133.1417">这里记录的是阅读&lt;悟透js&gt;的阅读笔记</t>
<t tx="newlife.20120406223133.1418">@doc
javascript执行引擎并非一行一行的分析和执行程序,而是一段一段的分析执行的,
而且在同一短程序的分析执行中,定义式的函数语句会被提取出来优先执行.
函数定义执行完之后,才会按顺序执行其他语句代码.

p13
    从上面的代码可以看出,同一个函数可以从不同的角度来调用.this并不一定是函本身所属的对象.this只是在任意对象和function元素结合是的一个概念,这种概念比起一般对象语言的默认结合更加灵活,显得更加超脱和自然.
    在javascript函数中,你只能把this看成当前要服务的"这个"对象.this是一个特殊的内置参数.根据this参数,您可以访问到"这个"对象的属性和方法,但是不能给this参数赋值.在一般对象语言中,方法体代码中的this是可以省略的,成员默认都是自己的.但是javascript却不同,由于不存在"自我",当访问这个对象时,this不可省略


p17</t>
<t tx="newlife.20120410205638.1423">function SayHello()
{
    alert("Hello,I am "+this.name );
};

function Person(name)
{
    this.name = name;
    this.SayHello = Sayhelllo;
};

var BillGates = new Person("Bill Gates"); 

var SteveJobs = new Person("Steve Jobs"); 

alert(BillGates.SayHello == SteveJobs.SayHello); 

其中,最后一行的输出结果表明两个对象确实共享了一个函数对象,虽然这段程序达到了共享一份方法代码的目的,但是却不怎么优雅.因为定义SayHello方法是反映不出其与Person类的关系.

这个时候,prototype出现了,

Javascript的所有的function类型的对象都有一个prototype属性.这个property属性本身又是一个object类型的对象,因此我们也可以给这个prototype对象添加任意的属性和方法.既然prototype是对象的原型,那么由该函数构造出来的对象应该都会具有这个原型的属性.事实上,在构造函数的prototype上定义的所有属性和方法,都是可以通过其构造的对象直接访问和调用的,也可以这么说,prototype提供了一群同类对象共享属性和方法的机制.

这个和父类继承有差莫???就是这个东西的主体是function呗,搞毛啊搞..</t>
<t tx="newlife.20120410205638.1424">@doc 

关于js的slice:
    
    这个东西ms就和python的差不多.涉及到的参数有区别.

The Array.slice() method return a slice,or subarray, of the specified array. Its two arguments specify the start and end of the slice to be returned . The returned array contains the element specified by the first argument and all subsequent elements up to,but not including,the element specified by the second argument.

if only one argument is specified,the returned array contains all elements from the start position to the end of the array.

if either argument is negative, it specifies an array element relative to the last element in the array.

An argument of -1 ,for example,specified the last element in the array ,and argument of -3 specifies the third from last element of the array,

Here are some examples:
    var a = [1,2,3,4,5];
    a.slice(3)        //[4,5]
    a.slice(0,3)     //[0,1,2]
    a.slice(1,-1)    //[2,3,4]
    a.slice(-3)       //[3,4,5] </t>
</tnodes>
</leo_file>
