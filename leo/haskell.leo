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
<v t="newlife.20101230182444.1268"><vh>haskell趣学指南</vh></v>
<v t="newlife.20101230182444.1269"><vh>about</vh></v>
<v t="newlife.20110107114607.1271" a="E"><vh>类型和类型类</vh>
<v t="newlife.20110107114607.1273"><vh>相信类型</vh></v>
<v t="newlife.20110107114607.1274"><vh>类型变量</vh></v>
<v t="newlife.20110107114607.1272"><vh>类型类</vh></v>
</v>
<v t="newlife.20110107114607.1275" a="E"><vh>函数的语法</vh>
<v t="newlife.20110107114607.1276"><vh>类型匹配</vh></v>
</v>
<v t="newlife.20110107114607.1270"><vh>递归</vh></v>
</vnodes>
<tnodes>
<t tx="newlife.20101230182444.1268">http://fleurer-lee.com/lyah/chapters.htm：中文版地址
http://learnyouahaskell.com/chapters：英文办地址</t>
<t tx="newlife.20101230182444.1269"></t>
<t tx="newlife.20110107114607.1270">@haskell

maximum' :: (Ord a) =&gt; [a] -&gt; a   
maximum' [] = error "maximum of empty list"   
maximum' [x] = x   
maximum' (x:xs)    
    | x &gt; maxTail = x           #最后才执行，因为maxTail不确定
    | otherwise = maxTail       #这个也是，下面是确定maxTail
    where maxTail = maximum' xs  
    
Ord类型类是什么东西？？

递归的实现：
处理单个元素的List的时候，返回改元素，
如果List的头部大于尾部的最大值，我们就可以假定较长的List的最大值就是他的头部，
而尾部若存在比他更大的元素，他就是尾部的最大值。

@hakell

maximum' :: (Ord a) =&gt; [a] -&gt; a   
maximum' [] = error "maximum of empty list"   
maximum' [x] = x   
maximum' (x:xs) = max x (maximum' xs)</t>
<t tx="newlife.20110107114607.1271"></t>
<t tx="newlife.20110107114607.1272">类型定义行为的接口，如果一个类型属于某类型类，那他必实现了该类型类所描述的行为。

ghci&gt; :t (==)   
(==) :: (Eq a) =&gt; a -&gt; a -&gt; Bool

在这里，我们见到一个新东西：=&gt;符号，他左边的部分叫类型约束。
上面的类型说明：相等函数取2个相同的类型的值作为参数并返回一个布尔值，而这两个参数的类型同在Eq类中。

Eq

包含可判断相等的类型。提供实现的函数是 ==和/=，除函数以外所有的类型都属于Eq，所以他们都可以判断相等性。

Ord

包含可比较大小的类型，除了函数以外，我们目前谈到的所有类型都属于Ord类。

Show

包含可用字符串表示的类型。除函数外所有类型。  最常用函数show

Read

和Show相反的类型类。read函数可以将一个字串转为Read的某成员类型

Enum

这个类型的成员都是连续的类型--也就是可枚举。我们可以再Range中用到他的成语类型：每个值都后继子和前置子，可通过succ函数和pred函数。

Bounded

每个成员都一个上线和下限

Num

表示数字的类型类，他的成员都具有数字的特征，


Integral

同样表示数字的类型类，Num包含所有的数字：实数和整数。而Intgral仅包含整数，其中的成员类型有Int和Integer.

Floating
包含浮点类型：Float和Double</t>
<t tx="newlife.20110107114607.1273">Haskell是静态类型的，在编译是每个表达式的类型都已确定，这就提高了代码的安全性。
Haskell中，万物皆有类型，因此再执行编译时编译器可以大有可为。
@Haskell
ghci&gt; :t 'a'   
'a' :: Char   
ghci&gt; :t True   
True :: Bool   
ghci&gt; :t "HELLO!"   
"HELLO!" :: [Char]   
ghci&gt; :t (True, 'a')   
(True, 'a') :: (Bool, Char)   
ghci&gt; :t 4 == 5   
4 == 5 :: Bool

:t命令处理一个表达式的输出结果为表达式后跟：：及其类型。::读作他的类型为。
凡是明确的类型，其首字母必须为大写。

同时，函数也有类型，编写函数时，给他一个明确的函数声名是个好习惯，比较短的函数就用多次一举了，

removeNoUppercase::[char] -&gt; [char]
removeNoUppercase st = [c|c&lt;-st,c`elem`['A'..'Z']]

addThree :: Int-&gt; Int-&gt;Int-&gt;Int
addThree x y z = x+y+z

参数之间由 -&gt;分隔，而与返回值之间并无特殊差异。返回值是最后一项，参数就是前三项。


Int 

表示整数 上限是2的31次方，下限是-2**31
Integer  也是整数，不过其是无界的。

Float
单精度浮点数

Double
双精度浮点数

Bool

True 和False

Char

一个字符，由单引号括起，一组字符的List即为字符串。
Tuple的类型取决于他的长度和其中项的类型，
空Tuple也是Char型。




</t>
<t tx="newlife.20110107114607.1274">你认为head函数的类型是啥，他可以取任意类型的List首项，
ghci&gt; :t head
head::[a] -&gt; a

a是啥？？不是类型，凡是类型其首字母必大写，他是个类型变量，意味这a可以是任意的类型</t>
<t tx="newlife.20110107114607.1275"></t>
<t tx="newlife.20110107114607.1276">模式匹配从过检查数据的特定结构来检查其是否匹配，并按模式从中取得数据。
定义函数的时候，我们可以为不同的模式分别定义函数体，让代码更加简洁易读，可以匹配一切数据类型

lucky::(Integral a ) =&gt; a -&gt;String
lucky 7="lucky number seven"
lucky x="sorry,out 0f luck"

sayMe :: (Integral a) =&gt; a -&gt; String   
sayMe 1 = "One!"   
sayMe 2 = "Two!"   
sayMe 3 = "Three!"   
sayMe 4 = "Four!"   
sayMe 5 = "Five!"   
sayMe x = "Not between 1 and 5"

factorial::(Integral)=&gt;a-&gt;a
factorial 0=1
factorial n = n*factorial(n-1)

这是说明模式的</t>
</tnodes>
</leo_file>
