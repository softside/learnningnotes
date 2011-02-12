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
<v t="newlife.20110211142831.1268"><vh>前期准备</vh>
<v t="newlife.20110211142831.1269"><vh>需要处理的平台信息</vh></v>
<v t="newlife.20110211142831.1271"><vh>当前流程</vh>
<v t="newlife.20110211142831.1285"><vh>baidu</vh></v>
<v t="newlife.20110212113018.1282"><vh>sohu</vh></v>
</v>
</v>
<v t="newlife.20110212113018.1285" a="E"><vh>优先</vh>
<v t="newlife.20110211142831.1270" a="E"><vh>sina微博</vh>
<v t="newlife.20110211142831.1274"><vh>get_member_bindblog_info</vh></v>
<v t="newlife.20110211142831.1278" a="M"><vh>is_send_feed</vh></v>
</v>
<v t="newlife.20110212113018.1284"><vh>kaixin</vh></v>
<v t="newlife.20110212113018.1283" a="E"><vh>renren</vh>
<v t="newlife.20110212113018.1286" a="O"><vh>/bubblefish/paopaoyu/apps/sns/sns_api_renren.py</vh>
<v t="newlife.20110212113018.1287"><vh>sns_api_renren declarations</vh></v>
<v t="newlife.20110212113018.1288"><vh>_generate_base_params</vh></v>
<v t="newlife.20110212113018.1289"><vh>_generate_sig</vh></v>
<v t="newlife.20110212113018.1290"><vh>_post_api_request</vh></v>
<v t="newlife.20110212113018.1291"><vh>get_sns_id</vh></v>
<v t="newlife.20110212113018.1292"><vh>get_sns_user</vh></v>
<v t="newlife.20110212113018.1293"><vh>get_app_friends</vh></v>
<v t="newlife.20110212113018.1294"><vh>get_are_friends</vh></v>
<v t="newlife.20110212113018.1295"><vh>send_app_feed</vh></v>
<v t="newlife.20110212113018.1296"><vh>send_app_notif</vh></v>
<v t="newlife.20110212113018.1297"><vh>pay_reg_order</vh></v>
<v t="newlife.20110212113018.1298"><vh>pay_is_complete</vh></v>
<v t="newlife.20110212113018.1299"><vh>check_vip_user</vh></v>
<v t="newlife.20110212113018.1300"><vh>check_user_score</vh></v>
<v t="newlife.20110212113018.1301"><vh>check_is_fan</vh></v>
</v>
<v t="newlife.20110212113018.1302" a="EO"><vh>/bubblefish/paopaoyu/apps/sns/sns_msg_renren.py</vh>
<v t="newlife.20110212113018.1303"><vh>sns_msg_renren declarations</vh></v>
<v t="newlife.20110212113018.1304"><vh>send_rank_feed</vh></v>
<v t="newlife.20110212113018.1305"><vh>send_troll_feed</vh></v>
<v t="newlife.20110212113018.1306"><vh>send_submarine_feed</vh></v>
<v t="newlife.20110212113018.1307"><vh>send_catchfish_feed</vh></v>
<v t="newlife.20110212113018.1308"><vh>send_steal_notif</vh></v>
<v t="newlife.20110212113018.1309"><vh>send_shock_notif</vh></v>
<v t="newlife.20110212113018.1310"><vh>send_openStage_feed</vh></v>
<v t="newlife.20110212113018.1311"><vh>send_feed_auto</vh></v>
</v>
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
<t tx="newlife.20110211142831.1285">百度没有。</t>
<t tx="newlife.20110212113018.1282">搜狐这个新鲜啊，</t>
<t tx="newlife.20110212113018.1283">方针：尽量使用以前的方式，减少工作量/

这个流程ms是这样的：
   调用的接口位于paopaoyu/apps/sns/sns_api_renren.py中的send_app_feed()，然后正常的时候返回一个_post_api_request()这个函数返回的结果。
   这个东西是各个平台不同的，各个单独处理的，而且是单独放各个平台的，
   现在要做一个新鲜事系统，现在的问题是这个系统要放到什么地方来做这个事情。
   其实新浪和人人的都再官网，这个其实问题不大，
   所以新鲜事要处理的可以分为2类，一类是官网
   
需求：
    要求发布的新鲜内容可以增删查改，所以要建表存储这些新鲜事的内容。
    然后就是如何建立接口传递数据，
    首先，官网，就是新浪，
        这个是通过js调用写的，这个其实是可以的，就是变量放到js里
    然后，就是各个应用平台，就是人人呗，
        构建新鲜事的源，     
         </t>
<t tx="newlife.20110212113018.1284">没有</t>
<t tx="newlife.20110212113018.1285"></t>
<t tx="newlife.20110212113018.1286">@language python
@tabwidth -4
@others
@ignore</t>
<t tx="newlife.20110212113018.1287"># -*- coding: utf-8 -*-
from datetime import datetime
from django.utils import simplejson
from django.conf import settings
import urllib, urllib2
import hashlib


</t>
<t tx="newlife.20110212113018.1288">def _generate_base_params():
    params = {}
    params['api_key'] = settings.SNS_API_KEY
    params['call_id'] = datetime.now().microsecond
    params['v'] = 1.0
    params['format'] = 'JSON'

    return params


</t>
<t tx="newlife.20110212113018.1289">def _generate_sig(params, secret_key=settings.SNS_SECRET_KEY):
    hasher = hashlib.md5(''.join(['%s=%s' % (x, params[x]) for x in sorted(params.keys())]))
    hasher.update(secret_key)
    return hasher.hexdigest()


</t>
<t tx="newlife.20110212113018.1290">def _post_api_request(params):
    data = urllib.urlencode(params)
    req = urllib2.Request(settings.SNS_API_REST_SERVER)
    response = urllib2.urlopen(req, data)
    result = response.read()
    result = simplejson.loads(result)

    return result


</t>
<t tx="newlife.20110212113018.1291">def get_sns_id(session_key):
    """
    Return sns id of user from the session key.
    See http://wiki.dev.renren.com/wiki/Users.getLoggedInUser
    Example:
    &gt;&gt;&gt; get_sns_id('2.d05591750139050e06ac76eeaf802302.3600.1264568400-288243096')
    288243096
    """
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.users.getLoggedInUser'
        params['session_key'] = session_key
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        return result['uid']
    except:
        return 'SNS_API_ERROR'


</t>
<t tx="newlife.20110212113018.1292">def get_sns_user(session_key, sns_id, fields='name,headurl'):
    """
    Return a dictionary, the keys are all the elements of fields parameter.
    See http://wiki.dev.renren.com/wiki/Users.getInfo
    Example:
    &gt;&gt;&gt; get_sns_user('288243096')
    {u'uid': 288243096, u'headurl': u'http://hdn.xnimg.cn/photos/hdn511/20090827/1340/head_r82j_7787k204234.jpg', u'name': u'李响'}
    """
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.users.getInfo'
        params['uids'] = sns_id
        params['session_key'] = session_key
        params['fields'] = fields
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        # The result is a list
        return result[0]['name'], result[0]['headurl']
    except:
        return 'SNS_API_ERROR'


</t>
<t tx="newlife.20110212113018.1293">def get_app_friends(session_key):
    """
    Return friends list of current user.
    See http://wiki.dev.renren.com/wiki/Friends.getFriends
    Example:
    &gt;&gt;&gt; get_app_friends('2.d05591750139050e06ac76eeaf802302.3600.1264568400-288243096')
    [{u'id': 247592008, u'headurl': u'http://hdn.xnimg.cn/photos/hdn201/20081223/08/15/head_w6YQ_29630m198107.jpg', u'name': u'金辉KinWii'}, ... , ]
    """
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.friends.getAppFriends'
        params['session_key'] = session_key
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        # The result is a friend list
        return result
    except:
        return 'SNS_API_ERROR'


</t>
<t tx="newlife.20110212113018.1294">def get_are_friends(session_key, uids1, uids2):
    """
    Return 1 when given uids1 and uids2 are friends, else return 0.
    See http://wiki.dev.renren.com/wiki/Friends.areFriends
    Example:
    &gt;&gt;&gt; get_are_friends('2.f97e3a1e5a8700d7e85c760953a4976f.3600.1264575600-288243096', '288243096', '55258592')
    1
    &gt;&gt;&gt; get_are_friends('2.f97e3a1e5a8700d7e85c760953a4976f.3600.1264575600-288243096', '288243096', '256500065')
    0
    """
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.friends.areFriends'
        params['session_key'] = session_key
        params['uids1'] = uids1
        params['uids2'] = uids2
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        if result[0]['uid1'] and result[0]['uid2'] and result[0].has_key('are_friends'):
            return result[0]['are_friends']
    except:
        return 'SNS_API_ERROR'

</t>
<t tx="newlife.20110212113018.1295">def send_app_feed(session_key, template_id, title_data, body_data):
    """
    Return 1 if successful send.
    See http://wiki.dev.renren.com/wiki/Feed.publishTemplatizedAction
    Example:
    &gt;&gt;&gt; send_app_feed('2.f97e3a1e5a8700d7e85c760953a4976f.3600.1264575600-288243096', '1', '{"feedtype":"&lt;a href=\'http://apps.renren.com/paopaoyu\'&gt;神秘海域&lt;/a&gt;"}', '{"content":"&lt;a href=\'http://apps.renren.com/paopaoyu\'&gt;也来吐个泡泡!&lt;/a&gt;"}')
    1
    """
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.feed.publishTemplatizedAction'
        params['session_key'] = session_key
        params['template_id'] = template_id
        params['title_data'] = title_data
        params['body_data'] = body_data
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        if result.has_key('result'):
            return result['result']
        else:
            return 'SNS_API_ERROR'
    except:
        return 'SNS_API_ERROR'


</t>
<t tx="newlife.20110212113018.1296">def send_app_notif(session_key, to_ids, notification):
    """
    Return 1 if successful send.
    See http://wiki.dev.renren.com/wiki/Notifications.send
    Example:
    &gt;&gt;&gt; send_app_notif('2.f97e3a1e5a8700d7e85c760953a4976f.3600.1264575600-288243096', '288243096', '你的朋友&lt;xn:name uid="288243096" linked="true"/&gt;趁你不在悄悄捞走了你的鱼，坏笑着溜走了。&lt;a href="http://apps.renren.com/paopaoyu"&gt;去TA家收鱼！&lt;/a&gt;')
    1
    """
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.notifications.send'
        params['session_key'] = session_key
        params['to_ids'] = to_ids
        params['notification'] = notification
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        if result.has_key('result'):
            return result['result']
        else:
            return 'SNS_API_ERROR'
    except:
        return 'SNS_API_ERROR'


</t>
<t tx="newlife.20110212113018.1297">def pay_reg_order(session_key, order_id, amount, desc):
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.pay.regOrder'
        params['session_key'] = session_key
        params['order_id'] = order_id
        params['amount'] = amount
        params['desc'] = desc
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        if result['token']:
            return result['token']
    except:
        return 'SNS_API_ERROR'


</t>
<t tx="newlife.20110212113018.1298">def pay_is_complete(order_id):
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.pay.isCompleted'
        params['order_id'] = order_id
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        if result['result'] == 1:
            return result
    except:
        return ''


</t>
<t tx="newlife.20110212113018.1299">def check_vip_user(session_key, sns_id):
    try:
        params = _generate_base_params()
        params['method'] = 'xiaonei.users.getInfo'
        params['uids'] = sns_id
        params['session_key'] = session_key
        params['fields'] = 'zidou'
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        # The result is a list
        if result[0]['zidou']:
            return True
        else:
            return False
    except:
        return False
</t>
<t tx="newlife.20110212113018.1300"># comment:
#       -1 : 参数错误 
#       其它 : 积分值
def check_user_score(session_key, sns_id):
    try:
        security_key = 'rrmntelunsupopofish'
        pwdpp = '%s%s' % (security_key, sns_id)
        hasher = hashlib.md5(pwdpp)
        pwdpp_security = hasher.hexdigest()

        params = {}
        params['userid'] = sns_id
        params['pwdpp'] =  pwdpp_security

        data = urllib.urlencode(params)
        req = urllib2.Request(settings.SNS_SCORE_CALLURL)
        response = urllib2.urlopen(req, data)
        result = response.read()
        result = simplejson.loads(result)

        return result
    except:
        return 0

</t>
<t tx="newlife.20110212113018.1301">def check_is_fan(sns_id):
    try:
        params = _generate_base_params()
        params['method'] = 'pages.isFan'
        params['uid'] = sns_id
        params['sig'] = _generate_sig(params)
        result = _post_api_request(params)
        # The result is a list
        if result['result']:
            return True
        else:
            return False
    except:
        return 0
</t>
<t tx="newlife.20110212113018.1302">@language python
@tabwidth -4
@others
@ignore</t>
<t tx="newlife.20110212113018.1303"># -*- coding: utf-8 -*-
from sns_api import send_app_feed, send_app_notif
import random

</t>
<t tx="newlife.20110212113018.1304">def send_rank_feed(session_key, rank):
    try:
        template_id = '2'
        title_data = ''
        body_data = '{"rank":"%s"}' % rank

        return send_app_feed(session_key, template_id, title_data, body_data)
    except:
        pass


</t>
<t tx="newlife.20110212113018.1305">def send_troll_feed(session_key, owner_id, price, fishname):
    try:
        fishname = fishname.encode('utf8')
        template_id = '3'
        title_data = '{"price":"%s","owner":"&lt;xn:name uid=\'%s\' linked=\'true\'/&gt;","fishname":"%s"}' % (int(price), owner_id, fishname)
        body_data = ''

        return send_app_feed(session_key, template_id, title_data, body_data)
    except:
        pass


</t>
<t tx="newlife.20110212113018.1306">def send_submarine_feed(session_key, fishname):
    try:
        fishname = fishname.encode('utf8')
        template_id = '4'
        title_data = ''
        body_data = '{"fishname":"%s"}' % fishname

        return send_app_feed(session_key, template_id, title_data, body_data)
    except:
        pass


</t>
<t tx="newlife.20110212113018.1307">def send_catchfish_feed(session_key, fishname):
    try:
        fishname = fishname.encode('utf8')
        template_id = '5'
        title_data = '{"fishname":"%s"}' % fishname
        body_data = ''

        return send_app_feed(session_key, template_id, title_data, body_data)
    except:
        pass


</t>
<t tx="newlife.20110212113018.1308">def send_steal_notif(session_key, thief_id, owner_id, sns_url):
    try:
        notification = '你的朋友&lt;xn:name uid="%s" linked="true"/&gt;趁你不在悄悄捞走了你的鱼，坏笑着溜走了。&lt;a href="%s"&gt;去TA家收鱼！&lt;/a&gt;' % (thief_id, sns_url)
        to_ids = '%s' % owner_id
        return send_app_notif(session_key, to_ids, notification)
    except:
        pass


</t>
<t tx="newlife.20110212113018.1309">def send_shock_notif(session_key, thief_id, owner_id, sns_url):
    try:
        notification = '&lt;xn:name uid="%s" linked="true"/&gt;不怀好意地“电”了你精心饲养的鱼，心满意足地拿着贝壳跑了。&lt;a href="%s"&gt;登门报复！&lt;/a&gt;' % (thief_id, sns_url)
        to_ids = '%s' % owner_id
        return send_app_notif(session_key, to_ids, notification)
    except:
        pass


</t>
<t tx="newlife.20110212113018.1310">def send_openStage_feed(session_key, stage=5):
    try:
        template_id = '10'
        title_data = ''
        body_data = ''

        return send_app_feed(session_key, template_id, title_data, body_data)
    except:
        pass

</t>
<t tx="newlife.20110212113018.1311">def send_feed_auto(session_key, type, val='1'):
    pass


</t>
</tnodes>
</leo_file>
