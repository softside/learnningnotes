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
<v t="newlife.20120322103449.1137"><vh>json </vh>
<v t="newlife.20120322103449.1138"><vh>about json</vh></v>
<v t="newlife.20120322103449.1139"><vh>function</vh></v>
</v>
<v t="newlife.20120322103449.1140" a="E"><vh>文件操作</vh>
<v t="newlife.20120322103449.1142"><vh>mode</vh></v>
<v t="newlife.20120322103449.1141"><vh>basic synacture</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20120322103449.1137">@doc

json (http://docs.python.org/library/json.html) The standard library documentationfor this module. 

JavaScript Object Notation (http://json.org/) JSON home, with documentation and implementations in other languages. 

simplejson (http://code.google.com/p/simplejson/) simplejson, from Bob Ippolitoet al. is the externally maintained development version of the json library in- cluded with Python 2.6 and later. It maintains backwards compatibility with Python 2.4 and Python 2.5.

jsonpickle (http://code.google.com/p/jsonpickle/) jsonpickle Python object to be serialized into JSON.

以前我们在django中使用json的时候,
    </t>
<t tx="newlife.20120322103449.1138"></t>
<t tx="newlife.20120322103449.1139">dump,dumps,load,loads 带s跟不带s的区别是 带s的是对 字符串的处理，而不带 s的是对文件对像的处理。</t>
<t tx="newlife.20120322103449.1140">关于文件操作,总有一些诡异的需求,</t>
<t tx="newlife.20120322103449.1141"></t>
<t tx="newlife.20120322103449.1142">@doc

The most commonly-used values of mode are 'r' for reading, 'w' for writing (truncating the file if it already exists), and 'a' for appending (which on some Unix systems means that all writes append to the end of the file regardless of the current seek position). If mode is omitted, it defaults to 'r'. The default is to use text mode, which may convert '\n' characters to a platform-specific representation on writing and back on reading. Thus, when opening a binary file, you should append 'b' to the mode value to open the file in binary mode, which will improve portability. (Appending 'b' is useful even on systems that don’t treat binary and text files differently, where it serves as documentation.) See below for more possible values of mode.

The optional buffering argument specifies the file’s desired buffer size: 0 means unbuffered, 1 means line buffered, any other positive value means use a buffer of (approximately) that size. A negative buffering means to use the system default, which is usually line buffered for tty devices and fully buffered for other files. If omitted, the system default is used. [2]

Modes 'r+', 'w+' and 'a+' open the file for updating (note that 'w+' truncates the file). Append 'b' to the mode to open the file in binary mode, on systems that differentiate between binary and text files; on systems that don’t have this distinction, adding the 'b' has no effect.

In addition to the standard fopen() values mode may be 'U' or 'rU'. Python is usually built with universal newline support; supplying 'U' opens the file as a text file, but lines may be terminated by any of the following: the Unix end-of-line convention '\n', the Macintosh convention '\r', or the Windows convention '\r\n'. All of these external representations are seen as '\n' by the Python program. If Python is built without universal newline support a mode with 'U' is the same as normal text mode. Note that file objects so opened also have an attribute called newlines which has a value of None (if no newlines have yet been seen), '\n', '\r', '\r\n', or a tuple containing all the newline types seen.

Python enforces that the mode, after stripping 'U', begins with 'r', 'w' or 'a'</t>
</tnodes>
</leo_file>
