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
<v t="newlife.20101018112051.1244"><vh>@chapters</vh></v>
<v t="newlife.20101018112051.1243" a="E"><vh>git分支</vh>
<v t="newlife.20101018112051.1245"><vh>何谓分支</vh></v>
<v t="newlife.20101018112051.1246"><vh>分支操作</vh></v>
<v t="newlife.20101018112051.1247"><vh>分支管理</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20101018112051.1243"></t>
<t tx="newlife.20101018112051.1244"></t>
<t tx="newlife.20101018112051.1245">git存储的不是文件差异或者变化量，而只是一系列的文件快照。
git提交的时候，会保存一个提交(commit)对象，包含一个指向暂存内容快照的指针，作者和相关附属信息，以及一定数量(也许没有)指向该提交对象直接祖先的指针，第一次提交是没有的，普通提交有一个祖先，由两个或多个分支合并并产生的提交则有多个祖先。
</t>
<t tx="newlife.20101018112051.1246">Git 并不同任何特定的问题追踪系统打交道。
要新建并切换到该分支，运行 git checkout -b newbranch
相当于git branch newbranch
     git checkout newbranch
     
留心你的暂存区或者工作目录里，那些还没有提交的修改，它会和你即将检出的分支产生冲突从而阻止 Git 为你转换分支。
转换分支的时候最好保持一个清洁的工作区域,即commit所有的修改。

切换到master:git checkout master
Git 会把工作目录的内容恢复为检出某分支时它所指向的那个 commit 的快照。
它会自动添加、删除和修改文件以确保目录的内容和你上次提交时完全一样。

删除分支：git branch -d newbranch

任何包含未解决冲突的文件都会以未合并（unmerged）状态列出。Git 会在有冲突的文件里加入标准的冲突解决标记，
可以通过它们来手工定位并解决这些冲突。可以看到此文件包含类似下面这样的部分：
&lt;&lt;&lt;&lt;&lt;&lt;&lt; HEAD:index.html
&lt;div id="footer"&gt;contact : email.support@github.com&lt;/div&gt;
=======
&lt;div id="footer"&gt;
  please contact us at support@github.com
&lt;/div&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt; iss53:index.html
解决的办法无非2种，二者选一或者亲自整合，
然后需要的是git add，标记为已解决。
然后就是commit了，，
然后的操作就是切换到master，
这时都是commit的状态
直接push就可以了

push。。</t>
<t tx="newlife.20101018112051.1247"></t>
</tnodes>
</leo_file>
