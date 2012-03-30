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
<v t="zhanglei.20100912175613.1257"><vh>@chapters</vh></v>
<v t="sps.20080311150235" a="E"><vh>@button Write Ajax</vh>
<v t="sps.20080311150235.1"><vh>&lt;&lt;one time setup&gt;&gt;</vh></v>
<v t="sps.20080311150235.2"><vh>&lt;&lt;write the frameset&gt;&gt;</vh></v>
<v t="sps.20080311150235.3"><vh>&lt;&lt;write the outline top&gt;&gt;</vh></v>
<v t="sps.20080311150235.4"><vh>&lt;&lt;write the display seed&gt;&gt;</vh></v>
<v t="sps.20080311150235.5"><vh>&lt;&lt;write the vnodes&gt;&gt;</vh>
<v t="sps.20080311150235.6"><vh>&lt;&lt;write the body&gt;&gt;</vh></v>
<v t="sps.20080311150235.7"><vh>&lt;&lt;write the children&gt;&gt;</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="sps.20080311150235">@language python
import os
import xml.sax
import xml.sax.saxutils

&lt;&lt;one time setup&gt;&gt;

leoHtmlDir = os.path.join(leoHtmlDir, c.frame.shortFileName() or "untitled")
if leoHtmlDir[-4:]==".leo":
    leoHtmlDir=leoHtmlDir[0:-4]

g.es(leoHtmlDir)

os.spawnlp(os.P_WAIT,"/bin/rm","rm","-rf",leoHtmlDir)
os.mkdir(leoHtmlDir)

&lt;&lt;write the frameset&gt;&gt;
&lt;&lt;write the outline top&gt;&gt;
&lt;&lt;write the display seed&gt;&gt;
&lt;&lt;write the vnodes&gt;&gt;

g.es("Created %s" % leoHtmlDir)

</t>
<t tx="sps.20080311150235.1">leoHtmlDir=os.path.join(os.environ['HOME'],'public_html')
if not os.path.isdir(leoHtmlDir):
    os.mkdir(leoHtmlDir)
leoHtmlDir=os.path.join(leoHtmlDir,'leo')
if not os.path.isdir(leoHtmlDir):
    os.mkdir(leoHtmlDir)
    javaScript=os.path.join(leoHtmlDir,"leoScript.js")
    javaScriptFile=open(javaScript,'wb')
    javaScriptFile.write("""var xmlHttp

function bodyPart(node)
  {
  for (var i = 0; i &lt; node.childNodes.length; i++)
    {
    var child = node.childNodes[i];
    if (!child || !child.attributes)
      continue;
    if (child.hasAttribute('nodeBody'))
      return child.innerHTML;
    }
  }

function updateBodyDisplay(node)
  {
  top.contentFrame.document.getElementById('bodydisplay').innerHTML=
    bodyPart(node);
  }

function expandNode(idStr)
  {
  xmlHttp=GetXmlHttpObject();
  if (xmlHttp==null)
    {
    alert ("Your browser does not support AJAX!");
    return;
    } 
  var nodeUrl=idStr;
  xmlHttp.onreadystatechange=function()
    {
    if(xmlHttp.readyState==4)
      {
      var updateNode=document.getElementById(idStr);
      updateNode.innerHTML=xmlHttp.responseText;
      updateBodyDisplay(updateNode);
      }
    }
  xmlHttp.open("GET",nodeUrl,true);
  xmlHttp.send(null);
  }

function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
return xmlHttp;
}

function removeHidden(node)
  {
  var i, curList, newList=[];
  if (node.className == null) return;
  curList = node.className.split(" ");
  for (i = 0; i &lt; curList.length; i++)
    if (curList[i] != "hide")
      newList.push(curList[i]);
  node.className = newList.join(" ");
  }

function classHidden(node)
  {
  var i, list;
  list = node.className.split(" ");
  for (i = 0; i &lt; list.length; i++)
    if (list[i] == "hide") return true;
  return false;
  }

function addHidden(node)
  {
  if (classHidden(node)) return;
  node.className += ' ' + "hide";
  }

function toggleHidden(node)
  {
  if (classHidden(node))
     return removeHidden(node);
  addHidden(node);
  }

function changeDisplay(idStr)
  {
  var node=document.getElementById(idStr);
  if (node.innerHTML=="")
    {
    expandNode(idStr);
    removeHidden(node);
    }
  else
    {
    toggleHidden(node);
    updateBodyDisplay(node);
    }
  }
""")
    javaScriptFile.close()
</t>
<t tx="sps.20080311150235.2">fileName=os.path.join(leoHtmlDir,"index.html")
nodeFile=open(fileName,'wb')
nodeFile.write("""&lt;html&gt;
  &lt;head&gt;
      &lt;title&gt;""")
nodeFile.write(c.frame.shortFileName())
nodeFile.write("""&lt;/title&gt;\n  &lt;/head&gt;
  &lt;frameset cols="30%,70%"&gt;
    &lt;frame name="outlineFrame" src="outlinetop.html"&gt;
    &lt;frame name="contentFrame" src="display.html"&gt;
  &lt;/frameset&gt;
&lt;/html&gt;
""")
nodeFile.close()
</t>
<t tx="sps.20080311150235.3">fileName=os.path.join(leoHtmlDir,"outlinetop.html")
nodeFile=open(fileName,'wb')
nodeFile.write("""&lt;html&gt;
&lt;head&gt;
&lt;script src="../leoScript.js"&gt;&lt;/script&gt;
&lt;style type="text/css"&gt;
  .hide {
    display: none;
  }
  .hl {
    border: 1px solid;
  }
  .bodycontent {
    display: none;
  }
&lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
""")

for childNode in c.rootPosition().children_iter():
    nodeFile.write("&lt;div&gt;\n&lt;span onclick=changeDisplay('")
    if not childNode.v.t.fileIndex:
        childNode.v.t.fileIndex = g.app.nodeIndices.getNewIndex()
    gnx = g.app.nodeIndices.toString(childNode.v.t.fileIndex)
    nodeFile.write(gnx)
    nodeFile.write("') class='hl'&gt;")
    nodeFile.write(
        xml.sax.saxutils.escape(childNode.headString()))
    nodeFile.write("&lt;/span&gt;\n&lt;/div&gt;\n&lt;div id='")
    nodeFile.write(gnx)
    nodeFile.write("' style='margin-left:2em' class='hide'&gt;&lt;/div&gt;\n")

nodeFile.write("&lt;/body&gt;\n&lt;/html&gt;\n")
nodeFile.close()

</t>
<t tx="sps.20080311150235.4">fileName=os.path.join(leoHtmlDir,"display.html")
nodeFile=open(fileName,'wb')
nodeFile.write("""&lt;html&gt;
  &lt;body class='bodystring'&gt;&lt;div id='bodydisplay'&gt;&amp;nbsp;&lt;/div&gt;&lt;/body&gt;
&lt;/html&gt;
""")
nodeFile.close()
</t>
<t tx="sps.20080311150235.5">for outNode in c.all_unique_vnodes_iter():
    if not outNode.t.fileIndex:
        outNode.t.fileIndex = g.app.nodeIndices.getNewIndex()
    gnx = g.app.nodeIndices.toString(outNode.t.fileIndex)
    fileName=os.path.join(leoHtmlDir,gnx)
    nodeFile=open(fileName,'wb')
    &lt;&lt;write the body&gt;&gt;
    &lt;&lt;write the children&gt;&gt;
    nodeFile.close()</t>
<t tx="sps.20080311150235.6">nodeFile.write("&lt;span nodeBody='y' class='hide'&gt;\n&lt;pre&gt;")
nodeFile.write(outNode.t.getBody())
nodeFile.write("&lt;/pre&gt;\n&lt;/span&gt;\n")
</t>
<t tx="sps.20080311150235.7">childNode = outNode.firstChild()
while childNode:
    nodeFile.write("&lt;div&gt;\n&lt;span onclick=changeDisplay('")
    if not childNode.t.fileIndex:
        childNode.t.fileIndex = g.app.nodeIndices.getNewIndex()
    gnx = g.app.nodeIndices.toString(childNode.t.fileIndex)
    nodeFile.write(gnx)
    nodeFile.write("') class='hl'&gt;")
    nodeFile.write(
        xml.sax.saxutils.escape(childNode.headString()or''))
    nodeFile.write("&lt;/div&gt;\n&lt;div id='")
    nodeFile.write(gnx)
    nodeFile.write("' style='margin-left:2em' class='hide'&gt;&lt;/div&gt;\n")
    childNode = childNode.next()
</t>
<t tx="zhanglei.20100912175613.1257"></t>
</tnodes>
</leo_file>
