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
<v t="newlife.20111116002843.1123" a="E"><vh>js</vh>
<v t="newlife.20111116002843.1124" a="E"><vh>book</vh>
<v t="newlife.20111116002843.1125" a="E"><vh>javascript ninja</vh>
<v t="newlife.20120204002815.1138"><vh>function</vh></v>
<v t="newlife.20120204002815.1139"><vh>newHeadline</vh></v>
</v>
<v t="newlife.20120203110815.1131"><vh>@shadow /Users/newlife/html/bootstrap/js/bootstrap-popover.js</vh></v>
<v t="newlife.20120203110815.1136"><vh>@shadow /Users/newlife/html/bootstrap/js/bootstrap-tooltip.js</vh>
<v t="newlife.20120204002815.1137"><vh>function</vh></v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20111116002843.1123">作为一个web攻城师，不会js或者js太弱是多么可耻的事情啊，
为了做一个合格的web程序猿，学会js是多么的有必要啊～～</t>
<t tx="newlife.20111116002843.1124">读书要读好书，
最近有幸知道了jquery的作者写过2本关于js的书，
secrects of the  javascript ninja,
pro javascript techniques,
先认真看完这两本书吧</t>
<t tx="newlife.20111116002843.1125">体验下高级的键盘。。
</t>
<t tx="newlife.20120203110815.1136">@language javascript
@tabwidth -4
@others
( window.jQuery )
@ignore</t>
<t tx="newlife.20120204002815.1137">!function( $ ) {

  "use strict"

 /* TOOLTIP PUBLIC CLASS DEFINITION
  * =============================== */

  var Tooltip = function ( element, options ) {
    this.init('tooltip', element, options)
  }

  Tooltip.prototype = {

    constructor: Tooltip

  , init: function ( type, element, options ) {
      var eventIn
        , eventOut

      this.type = type
      this.$element = $(element)
      this.options = this.getOptions(options)
      this.enabled = true

      if (this.options.trigger != 'manual') {
        eventIn  = this.options.trigger == 'hover' ? 'mouseenter' : 'focus'
        eventOut = this.options.trigger == 'hover' ? 'mouseleave' : 'blur'
        this.$element.on(eventIn, this.options.selector, $.proxy(this.enter, this))
        this.$element.on(eventOut, this.options.selector, $.proxy(this.leave, this))
      }

      this.options.selector ?
        (this._options = $.extend({}, this.options, { trigger: 'manual', selector: '' })) :
        this.fixTitle()
    }

  , getOptions: function ( options ) {
      options = $.extend({}, $.fn[this.type].defaults, options, this.$element.data())

      if (options.delay &amp;&amp; typeof options.delay == 'number') {
        options.delay = {
          show: options.delay
        , hide: options.delay
        }
      }

      return options
    }

  , enter: function ( e ) {
      var self = $(e.currentTarget)[this.type](this._options).data(this.type)

      if (!self.options.delay || !self.options.delay.show) {
        self.show()
      } else {
        self.hoverState = 'in'
        setTimeout(function() {
          if (self.hoverState == 'in') {
            self.show()
          }
        }, self.options.delay.show)
      }
    }

  , leave: function ( e ) {
      var self = $(e.currentTarget)[this.type](this._options).data(this.type)

      if (!self.options.delay || !self.options.delay.hide) {
        self.hide()
      } else {
        self.hoverState = 'out'
        setTimeout(function() {
          if (self.hoverState == 'out') {
            self.hide()
          }
        }, self.options.delay.hide)
      }
    }

  , show: function () {
      var $tip
        , inside
        , pos
        , actualWidth
        , actualHeight
        , placement
        , tp

      if (this.hasContent() &amp;&amp; this.enabled) {
        $tip = this.tip()
        this.setContent()

        if (this.options.animation) {
          $tip.addClass('fade')
        }

        placement = typeof this.options.placement == 'function' ?
          this.options.placement.call(this, $tip[0], this.$element[0]) :
          this.options.placement

        inside = /in/.test(placement)

        $tip
          .remove()
          .css({ top: 0, left: 0, display: 'block' })
          .appendTo(inside ? this.$element : document.body)

        pos = this.getPosition(inside)

        actualWidth = $tip[0].offsetWidth
        actualHeight = $tip[0].offsetHeight

        switch (inside ? placement.split(' ')[1] : placement) {
          case 'bottom':
            tp = {top: pos.top + pos.height, left: pos.left + pos.width / 2 - actualWidth / 2}
            break
          case 'top':
            tp = {top: pos.top - actualHeight, left: pos.left + pos.width / 2 - actualWidth / 2}
            break
          case 'left':
            tp = {top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left - actualWidth}
            break
          case 'right':
            tp = {top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left + pos.width}
            break
        }

        $tip
          .css(tp)
          .addClass(placement)
          .addClass('in')
      }
    }

  , setContent: function () {
      var $tip = this.tip()
      $tip.find('.tooltip-inner').html(this.getTitle())
      $tip.removeClass('fade in top bottom left right')
    }

  , hide: function () {
      var that = this
        , $tip = this.tip()

      $tip.removeClass('in')

      function removeWithAnimation() {
        var timeout = setTimeout(function () {
          $tip.off($.support.transition.end).remove()
        }, 500)

        $tip.one($.support.transition.end, function () {
          clearTimeout(timeout)
          $tip.remove()
        })
      }

      $.support.transition &amp;&amp; this.$tip.hasClass('fade') ?
        removeWithAnimation() :
        $tip.remove()
    }

  , fixTitle: function () {
      var $e = this.$element
      if ($e.attr('title') || typeof($e.attr('data-original-title')) != 'string') {
        $e.attr('data-original-title', $e.attr('title') || '').removeAttr('title')
      }
    }

  , hasContent: function () {
      return this.getTitle()
    }

  , getPosition: function (inside) {
      return $.extend({}, (inside ? {top: 0, left: 0} : this.$element.offset()), {
        width: this.$element[0].offsetWidth
      , height: this.$element[0].offsetHeight
      })
    }

  , getTitle: function () {
      var title
        , $e = this.$element
        , o = this.options

      title = $e.attr('data-original-title')
        || (typeof o.title == 'function' ? o.title.call($e[0]) :  o.title)

      title = title.toString().replace(/(^\s*|\s*$)/, "")

      return title
    }

  , tip: function () {
      return this.$tip = this.$tip || $(this.options.template)
    }

  , validate: function () {
      if (!this.$element[0].parentNode) {
        this.hide()
        this.$element = null
        this.options = null
      }
    }

  , enable: function () {
      this.enabled = true
    }

  , disable: function () {
      this.enabled = false
    }

  , toggleEnabled: function () {
      this.enabled = !this.enabled
    }

  , toggle: function () {
      this[this.tip().hasClass('in') ? 'hide' : 'show']()
    }

  }


 /* TOOLTIP PLUGIN DEFINITION
  * ========================= */

  $.fn.tooltip = function ( option ) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data('tooltip')
        , options = typeof option == 'object' &amp;&amp; option
      if (!data) $this.data('tooltip', (data = new Tooltip(this, options)))
      if (typeof option == 'string') data[option]()
    })
  }

  $.fn.tooltip.Constructor = Tooltip

  $.fn.tooltip.defaults = {
    animation: true
  , delay: 0
  , selector: false
  , placement: 'top'
  , trigger: 'hover'
  , title: ''
  , template: '&lt;div class="tooltip"&gt;&lt;div class="tooltip-arrow"&gt;&lt;/div&gt;&lt;div class="tooltip-inner"&gt;&lt;/div&gt;&lt;/div&gt;'
  }

}</t>
<t tx="newlife.20120204002815.1138">&lt;script&gt;
function assert(pass, msg){
  var type = pass ? "PASS" : "FAIL";
  jQuery("#results").append("&lt;li class='" + type + "'&gt;&lt;b&gt;" + type + "&lt;/b&gt; " + msg + "&lt;/li&gt;");
}
function error(msg){
  jQuery("#results").append("&lt;li class='ERROR'&gt;&lt;b&gt;ERROR&lt;/b&gt; " + msg + "&lt;/li&gt;");
}
function log(){
  var msg = "";
  for ( var i = 0; i &lt; arguments.length; i++ ) {
    msg += " " + arguments[i];
  }
  jQuery("#results").append("&lt;li class='LOG'&gt;&lt;b&gt;LOG&lt;/b&gt; " + msg + "&lt;/li&gt;");
}
&lt;/script&gt;
@doc
这里定义了三个函数，
这个arguments是内置的参数的列表

统一的命名空间

var ninja = function myNinja(){
  assert( ninja == myNinja, "This function is named two things - at once!" );
};
ninja();
assert( typeof myNinja == "undefined", "But myNinja isn't defined outside of the function." );

函数是一等公民

function add(a, b){ 
  return a + b; 
} 
assert( add.call(this, 1, 2) == 3, ".call() takes individual arguments" ); 
assert( add.apply(this, [1, 2]) == 3, ".apply() takes an array of arguments" );</t>
<t tx="newlife.20120204002815.1139">@doc
In this chapter:
•Function
The quality of all code that you'll ever write, in JavaScript, relies upon the realization that JavaScript is a functional language. All functions, in JavaScript, are first-class: They can coexist with, and can be treated like, any other JavaScript object.
你写的js代码的质量依赖于你对js是一个函数式语言的认识程度。所有的js函数,都是一等公民，可以和对象一样对待。
One of the most important features of the JavaScript language is that you can create anonymous functions at any time. These functions can be passed as values to other functions and be used as the fundamental building blocks for reusable code libraries. Understanding how functions, and by extension anonymous functions, work at their most fundamental level will drastically affect your ability to write clear, reusable, code.
js的一个最重要的特色是可以随时创建匿名函数。这些函数可以作为参数传递到其他函数，可以当做基础的代码片段作为可重用的库，理解函数是如何工作的可以很大的影响你写出干净可重用的代码的能力。
In this chapter we'll explore the various ways in which functions work, all the way from the absolute basics (defining functions) to understanding the complex nature of function context and arguments.
这章里面我们查看函数工作的各种方法。
• Closures 
Closures are one of the defining features of JavaScript. Without them, JavaScript would likely be another hum-drum scripting experience, but since that's not the case, the landscape of the language is forever shaped by their inclusion.
闭包
Traditionally, closures have been a feature of purely functional programming languages and having them cross over into mainstream development has been particularly encouraging, and enlightening. It's not uncommon to find closures permeating JavaScript libraries, and other advanced code bases, due to their ability to drastically simplify complex operations.

/*
* When a function is defined in another function and it
*    has access to the outer function's context even after
*    the outer function returns
* An important concept to learn in Javascript
*当一个函数在另一个函数内部定义的时候，这个函数可以访问外部函数的上下文，即使在外部函数返回以后，学习js的时候一个重要的概念
*/

function outerFunction(someNum) {
  var someString = 'Hai!';
  var content = document.getElementById('content');
  function innerFunction() {
    content.innerHTML = someNum + ': ' + someString;
    content = null; // IE memory leak for DOM reference
  }
  innerFunction();
}

outerFunction(1);​</t>
</tnodes>
</leo_file>
