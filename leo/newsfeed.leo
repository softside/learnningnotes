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
<v t="newlife.20110211142831.1267"><vh>新鲜事平台</vh></v>
<v t="newlife.20110211142831.1268" a="E"><vh>前期准备</vh>
<v t="newlife.20110211142831.1269"><vh>需要处理的平台信息</vh></v>
<v t="newlife.20110211142831.1271" a="E"><vh>当前流程</vh>
<v t="newlife.20110211142831.1270"><vh>sina微博</vh>
<v t="newlife.20110211142831.1274"><vh>get_member_bindblog_info</vh></v>
<v t="newlife.20110211142831.1278" a="M"><vh>is_send_feed</vh></v>
</v>
<v t="newlife.20110211142831.1285"><vh>baidu</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110211142831.1267">这个东西是啥目前还不清楚：
</t>
<t tx="newlife.20110211142831.1268"></t>
<t tx="newlife.20110211142831.1269">所有新鲜事的平台：
sina微博、

baidu

sohu、

4399、

sdo、

163、

renren


注册开发者帐号查看说明文档</t>
<t tx="newlife.20110211142831.1270">发布新鲜事的形式

新鲜事接口：

sina微博:
    这个仅在官网有，用户通过sina微博登录，记录是否将信息同步到微博，
    具体的字段就是BindBlog这个model中的allowed字段，
    当然还有blog_type判断是否是sina用户因为还有开心用户和本地注册的用户
</t>
<t tx="newlife.20110211142831.1271"></t>
<t tx="newlife.20110211142831.1274">def get_member_bindblog_info(sns_id):
    key = CACHE_SINA_USER_INFO % (sns_id)
    bb = cache.get(key)

    if bb is None:
        bbs = BindBlog.objects.filter(user_id=sns_id)
        if bbs:
            bb = bbs[0]
            cache.set(key, bb)
        else:
            return None

    return bb

@doc
不得不说，这都是谁写的啊，就为了这么东西，写这么函数，类不累啊。，。
一个值得注意的地方，就是解除对各个表之间的外键约束。将所有的ForeignkeyField转化为IntegerField</t>
<t tx="newlife.20110211142831.1278">def is_send_feed(sns_id):
    bbinfo = get_member_bindblog_info(sns_id)

    if not bbinfo:
        return False
    if bbinfo.blog_type != 'sina':
        return False
    if bbinfo.allowed:
        return True
    else:
        return False

##############################################################
虽然我不是一个有代码洁癖的人，但是看到这种我还是忍不住

def is_send_feed(sns_id):
    bbinfo = get_member_bindblog_info(sns_id)
    
    if bbinfo.blog_type == 'sina' and bbinfo.allowed:
        return True
    else:
        return False
</t>
<t tx="newlife.20110211142831.1285"></t>
</tnodes>
</leo_file>
