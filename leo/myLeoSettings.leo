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
<v t="newlife.20110904032316.1351"><vh>@settings</vh>
<v t="newlife.20110904032316.1352"><vh>@enabled-plugins</vh></v>
<v t="newlife.20110904032316.1353"><vh>@@string initial_split_orientation = horizontal</vh></v>
<v t="newlife.20110904032316.1354" a="E"><vh>suggested style sheets</vh>
<v t="newlife.20110904032316.1355"><vh>default look (Linux)</vh>
<v t="newlife.20110904032316.1356"><vh>@@data qt-gui-plugin-style-sheet</vh></v>
</v>
<v t="newlife.20110904032316.1357" a="E"><vh>A mac look</vh>
<v t="newlife.20110904032316.1358"><vh>@@data qt-gui-plugin-style-sheet</vh></v>
</v>
</v>
<v t="newlife.20110904032316.1359"><vh>@int qt_max_colorized_chars = 200000</vh></v>
<v t="newlife.20110904032316.1360"><vh>@data contextmenu_commands</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110904032316.1351"></t>
<t tx="newlife.20110904032316.1352"># Leo loads plugins in the order they appear here.
# File names may be indented as desired.

# Standard plugins enabled in official distributions....

plugins_menu.py
leo_to_html.py
mod_scripting.py
quicksearch.py
UNL.py
contextmenu.py
nav_qt.py

# The plugins manager plugin does not
# understand @enabled-plugins nodes.
# plugin_manager.py

# The rst3 plugin is no longer needed.
# It's code has been moved to Leo's core
# rst3.py

# These plugins used to be enabled when using the tk plugin.
# cleo.py
# hoist.py
# image.py
# nav_buttons.py
# threading_colorizer.py

# All other plugins.
# Order is important for enabled plugins that
# add items to the icon area.

# ConceptualSort.py
# EditAttributes.py
# FileActions.py
# Library.py
# nodeActions.py
# UASearch.py
# URLloader.py
# UniversalScrolling.py

# add_directives.py
# arrows.py
# at_folder.py
# at_view.py
# autotrees.py
# base64Packager.py
# bibtex.py
# chapter_hoist.py
# cleo.py
# color_markup.py
# datenodes.py
# detect_urls.py
# dyna_menu.py
# fastGotoNode.py
# footprints.py
# groupOperations.py
# hoist.py
# image.py
# import_cisco_config.py
# ipython.py
# keybindings.py
# leoOPML.py
# leo_to_html.py
# leo_to_rtf.py
# leoupdate.py
# macros.py
# mod_autosave.py
# mod_http.py
# mod_labels.py
# mod_read_dir_outline.py
# mod_shadow.py
# multifile.py
# nav_buttons.py
# newButtons.py
# niceNosent.py
# nodebar.py
# nodenavigator.py
# open_shell.py
# open_with.py
# paste_as_headlines.py
# pie_menus.py
# pretty_print.py
# print_cp.py
# quickMove.py
# rClick.py
# read_only_nodes.py
# rowcol.py
# run_nodes.py
# s_menu.py
# scheduler.py
# searchbox.py
# shortcut_button.py
# slideshow.py
# table.py
# templates.py
# trace_tags.py
# vim.py
# word_count.py
# word_export.py
# xcc_nodes.py
# xemacs.py
# xsltWithNodes.py
# zodb.py
# quicksearch.py
# tomboy_import.py
# ctagscompleter.py
# colorize_headlines.py</t>
<t tx="newlife.20110904032316.1353">horizontal: body pane to the left
vertical: body pane on the botton

vertical is the default; you may prefer horizontal for small but wide screens (e.g. on laptops)</t>
<t tx="newlife.20110904032316.1354">This tree containt some suggested "looks" for Leo.

To experiment, you may want to use a @button that applies
the stylesheet in current node; look for "@button set-style-sheet" 
in scripts.leo.

For information on stylesheets, see

http://doc.trolltech.com/stylesheet.html

Style contributions are welcome.</t>
<t tx="newlife.20110904032316.1355">Classic Leo colors. This should look good on Linux.</t>
<t tx="newlife.20110904032316.1356">/* Documentation of Qt stylesheets at http://doc.trolltech.com/stylesheet.html 

To experiment, you may want to use a @button that applies
the current stylesheet; look for "@button set-style-sheet" in
scripts.leo.

*/

/* Valid color names: http://www.w3.org/TR/SVG/types.html#ColorKeywords */

/* A QWidget: supports only background attributes.*/

QSplitter::handle {
    background-color: #CAE1FF; /* lightSteelBlue1 */
}

QStackedWidget {
    /* background-color:lightpink; */
    border-color: red;
    padding: 0px;
    /* border-width: 0px; */
    /* background-color: yellow; */
}

QSplitter {
    border-color: white;
    background-color: white;
    border-style: solid;
}

QTreeWidget {
    /* These apply to the selected item, but not to editing items.*/
    background-color: #ffffec; /* Leo's traditional tree color */
    selection-color: black; /* was white */
    selection-background-color: lightgrey;
    /* font-family: SansSerif; */
    font-family: DejaVu Sans Mono;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
 }

/* Headline edit widgets */
QTreeWidget QLineEdit {
    background-color: cornsilk;
    selection-color: white;
    selection-background-color: blue;
    font-family: DejaVu Sans Mono;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The log panes */
QTextEdit {
    background-color: #f2fdff;
    selection-color: white;
    selection-background-color: blue;
    /* font-family: Courier New; */
    font-family: DejaVu Sans Mono;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The body pane */
QTextEdit#richTextEdit {
    background-color: #fdf5f5; /* A kind of pink. */
    selection-color: white;
    selection-background-color: lightgrey;
    font-family: DejaVu Sans Mono;
    /* font-family: Courier New; */
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLabel {
    font-family: DejaVu Sans Mono;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

/* Editor labels */
QLineEdit#editorLabel {
    background-color: #ffffec;
    font-family: DejaVu Sans Mono;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
    border: 2px;
    margin: 2px;
}

/* The mini-buffer */
QLineEdit#lineEdit {
    selection-color: white;
    selection-background-color: lightgrey;
    font-family: DejaVu Sans Mono;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLineEdit#status1 {
    background-color: lightgrey;
    border-width: 1px;
    border-style: solid;
    border-color: darkgrey;
}

QLineEdit#status2 {
    background-color: lightgrey;
    border-width: 1px;
    border-style: solid;
    border-color: darkgrey;
}

XXQPushButton {
    background-color: #fdf5f5; /* A kind of pink. */
    margin: 2px;
    padding; 4px;
    border-width: 2px;
    border-style: solid;
    border-color: darkgrey;
}

/* QMenuBar works, but not QMenu... */
XXQMenuBar {
    font-family: DejaVu Sans Mono;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}
</t>
<t tx="newlife.20110904032316.1357">This is the classic Leo look, but with fonts that
allegedly look better on Mac.</t>
<t tx="newlife.20110904032316.1358">/* Documentation of Qt stylesheets at http://doc.trolltech.com/4.2/stylesheet.html */

/* Valid color names: http://www.w3.org/TR/SVG/types.html#ColorKeywords */

/* A QWidget: supports only background attributes.*/

QSplitter::handle {
    background-color: #CAE1FF; /* lightSteelBlue1 */
}

QStackedWidget {
    /* background-color:lightpink; */
    border-color: red;
    padding: 0px;
    /* border-width: 0px; */
    /* background-color: yellow; */
}

QSplitter {
    border-color: white;
    background-color: white;
    border-style: solid;
}

QTreeWidget {
    /* These apply to the selected item, but not to editing items.*/
    background-color: #ffffec; /* Leo's traditional tree color */
    selection-color: black; /* was white */
    selection-background-color: lightgrey;
    /* font-family: SansSerif; */
    font-family: Lucida Grande;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
 }

/* Headline edit widgets */
QTreeWidget QLineEdit {
    background-color: cornsilk;
    selection-color: white;
    selection-background-color: blue;
    font-family: Lucida Grande;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The log panes */
QTextEdit {
    background-color: #f2fdff;
    selection-color: white;
    selection-background-color: blue;
    font-family: Monaco;
    font-size: 10px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The body pane */
QTextEdit#richTextEdit {
    background-color: #fdf5f5; /* A kind of pink. */
    selection-color: white;
    selection-background-color: lightgrey;
    font-family: Monaco;
    /* font-family: Courier New; */
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLabel {
    font-family: Lucida Grande;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

/* Editor labels */
QLineEdit#editorLabel {
    background-color: #ffffec;
    font-family: Lucida Grande;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
    border: 2px;
    margin: 2px;
}

/* The mini-buffer */
QLineEdit#lineEdit {
    selection-color: white;
    selection-background-color: lightgrey;
    font-family: Monaco;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLineEdit#status1 {
    background-color: lightgrey;
    border-width: 1px;
    border-style: solid;
    border-color: darkgrey;
}

QLineEdit#status2 {
    background-color: lightgrey;
    border-width: 1px;
    border-style: solid;
    border-color: darkgrey;
}

XXQPushButton {
    background-color: #fdf5f5; /* A kind of pink. */
    margin: 2px;
    padding; 4px;
    border-width: 2px;
    border-style: solid;
    border-color: darkgrey;
}

/* QMenuBar works, but not QMenu... */
XXQMenuBar {
    font-family: Lucida Grande;
    font-size: 12px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}</t>
<t tx="newlife.20110904032316.1359">If zero, all nodes are colorized, regardless of length of body text.
If &gt; 0, only nodes whose body text are smaller than this limit are colorized.</t>
<t tx="newlife.20110904032316.1360"># Add commands to contextmenu
# The format is &lt;command&gt; SPACE &lt;description&gt;

# stickynote Create a sticky note
# read-at-file-nodes Read file node</t>
</tnodes>
</leo_file>
