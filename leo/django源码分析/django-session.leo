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
<v t="newlife.20110329110737.1267" a="E"><vh>django-seesion的实现</vh>
<v t="newlife.20110329110737.1268"><vh>起因</vh></v>
<v t="newlife.20110329110737.1269"><vh>文档描述</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110329110737.1267"></t>
<t tx="newlife.20110329110737.1268">起因很简单，我不会。还有很重要。</t>
<t tx="newlife.20110329110737.1269">http://docs.djangoproject.com/en/1.2//topics/http/sessions/
Django全面支持匿名session，session框架允许你基于每个访问者来存储和获取数据。他吧数据存储在服务器端，分离了发送和接受cookies，Cookies包含一个 session Id,不是session本身。

允许session:
    middleware:django.contrib.sessions.middleware.SessionMiddleware,,默认已经激活这个中间件
    不用就去除中间件和installapp里的相关行
配置session引擎：
    django默认把session放在db里，虽然很方便，但是有时候放到其他地方会更快，所以可以配置保存session再缓存或者文件系统里。
    基于数据库的session：
        写入'django.contrib.sessions'到你的 'INSTALLED_APPS'  
    基于缓存的session：
        </t>
</tnodes>
</leo_file>
