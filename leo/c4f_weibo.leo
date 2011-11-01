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
<v t="newlife.20111007011829.1216"><vh>preface</vh></v>
<v t="newlife.20111007011829.1215"><vh>preface</vh></v>
<v t="newlife.20111031121831.1129"><vh>mail的逻辑</vh></v>
</vnodes>
<tnodes>
<t tx="newlife.20111007011829.1215">1.宠物个人页面
 1.1. 宠物主人发信息、看到自己和朋友的信息
 1.2. 其他人访问宠物个人页面，看到该宠物发的信息，评论和转发
 1.3 宠物朋友列表页
 1.4 宠物上传的视频列表页（如果时间不够就回来再做）
2.首页
3.宠宠有约页面</t>
<t tx="newlife.20111007011829.1216">这个东西不再用是因为ctrl+u这个键一直没有找到对应的快捷键是哪个，太纠结了，，</t>
<t tx="newlife.20111031121831.1129">时间长了，我自己都不记得了，，，
记录下，做文档。

CACHED_MAIL_LIST = "pet:%d:mail"#user_id
#这里存储的当前用户的信件列表的用户id的列表，完全针对那个页面做的，
CACHED_MAIL_DETAIL = "pet:%d:%d:mail"#user_id,user_id
#这个存的是mail_id,,
def get_mail_list(user_id):
    mail_list = []
    key = CACHED_MAIL_LIST % user_id
    user_ids = conn.zrevrange(key, 0, -1)
    for one in user_ids:
        one = int(one)
        mail = get_mail_by_user(user_id, one)[0]
        mail.count = len(get_mail_by_user(user_id,one))
        mail_list.append(mail)

    return mail_list

def save_mail(key_id, user_id):
   key = CACHED_MAIL_LIST % key_id
   conn.zrem(key,user_id)
   conn.zadd(key, user_id, time.time())

def get_mail_by_user(s_id, b_id):
    s_id,b_id = (s_id &lt; b_id) and (s_id, b_id) or (b_id, s_id)
    mail_list = []
    key = CACHED_MAIL_DETAIL%( s_id, b_id)
    mail_ids = conn.zrevrange(key, 0, -1)
    mail_list = Message.objects.filter(id__in = mail_ids).order_by("-id")
    return mail_list

def save_mail_by_user(s_id, b_id, mail):
    s_id,b_id = (s_id &lt; b_id) and (s_id, b_id) or (b_id, s_id)
    key = CACHED_MAIL_DETAIL%( s_id, b_id)
    conn.zadd(key, mail_id, time.time()) </t>
</tnodes>
</leo_file>
