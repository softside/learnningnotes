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
<v t="newlife.20111007011829.1216" a="E"><vh>preface</vh>
<v t="newlife.20120209162149.1177"><vh>闲言碎语</vh></v>
</v>
<v t="newlife.20111007011829.1215"><vh>preface</vh></v>
<v t="newlife.20111031121831.1129"><vh>mail的逻辑</vh></v>
<v t="newlife.20120104153340.1804"><vh>微薄登陆</vh>
<v t="newlife.20120104153340.1805"><vh>ee</vh>
<v t="newlife.20120104153340.1806"><vh>@file /Users/newlife/work/petsns/pet/core/sinaapi.py</vh>
<v t="newlife.20120104153340.1807"><vh>sinaapi declarations</vh></v>
<v t="newlife.20120104153340.1808"><vh>class OAuth</vh>
<v t="newlife.20120104153340.1809"><vh>__init__</vh></v>
<v t="newlife.20120104153340.1810"><vh>getAtt</vh></v>
<v t="newlife.20120104153340.1811"><vh>get_auth_url</vh></v>
<v t="newlife.20120104153340.1812"><vh>oauth</vh></v>
<v t="newlife.20120104153340.1813"><vh>setAccessToken</vh></v>
<v t="newlife.20120104153340.1814"><vh>update</vh></v>
<v t="newlife.20120104153340.1815"><vh>get_user</vh></v>
<v t="newlife.20120104153340.1816"><vh>destroy_status</vh></v>
</v>
<v t="newlife.20120104153340.1817"><vh>update_message</vh></v>
</v>
<v t="newlife.20120104153340.1830" a="E"><vh>@file /Users/newlife/work/petsns/pet/core/sinaweibo_views.py</vh>
<v t="newlife.20120104153340.1835"><vh>callback</vh></v>
<v t="newlife.20120104153340.1832"><vh>initial_user_info_data</vh></v>
<v t="newlife.20120104153340.1834"><vh>sina_auth_redirect</vh></v>
<v t="newlife.20120104153340.1838"><vh>sina_msg</vh></v>
<v t="newlife.20120104153340.1836"><vh>sina_signin</vh></v>
<v t="newlife.20120104153340.1837"><vh>sina_signup</vh></v>
<v t="newlife.20120104153340.1831"><vh>sinaweibo_views declarations</vh></v>
<v t="newlife.20120104153340.1833"><vh>unbind_sina</vh></v>
</v>
</v>
</v>
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
<t tx="newlife.20120104153340.1804">虽然这个东西以前做过一次，这次还是再抄一遍吧，，</t>
<t tx="newlife.20120104153340.1805"></t>
<t tx="newlife.20120104153340.1806">@language python
@tabwidth -4
@others
@ignore</t>
<t tx="newlife.20120104153340.1807">#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
Created on 2011-6-24

@author: leona
'''
from django.conf import settings
from weibopy.api import API
from weibopy.auth import OAuthHandler
from weibopy.error import WeibopError
from weibopy.oauth import OAuthToken

CALLBACK_URL = getattr(settings, 'SINA_OAUTH_CALLBACK_URL', 'http://www.beitaichufang.com/sinacallback/')

</t>
<t tx="newlife.20120104153340.1808">class OAuth(object):

    consumer_key='1813723982'
    consumer_secret='c550f56780c3d9be5e0ff87ac445a5ae'

    @others
</t>
<t tx="newlife.20120104153340.1809">def __init__(self):
    callback = CALLBACK_URL # set settings.SINA_OAUTH_CALLBACK_URL to 'http://localhost/sinacallback/' if need
    self.auth = OAuthHandler(self.consumer_key, self.consumer_secret, callback=callback)

</t>
<t tx="newlife.20120104153340.1810">def getAtt(self, key):
    try:
        return self.obj.__getattribute__(key)
    except Exception, e:
        print(e)
        return ''

</t>
<t tx="newlife.20120104153340.1811">def get_auth_url(self):

    auth_url = self.auth.get_authorization_url()
    return auth_url

</t>
<t tx="newlife.20120104153340.1812">def oauth(self, verifier):

    self.auth.get_access_token(verifier)
    self.api = API(self.auth)

</t>
<t tx="newlife.20120104153340.1813">def setAccessToken(self, access):

    self.auth.access_token = OAuthToken.from_string(access)
    self.api = API(self.auth)

</t>
<t tx="newlife.20120104153340.1814">def update(self, message):
    status = self.api.update_status(message)
    self.obj = status
    id = self.getAtt("id")
    text = self.getAtt("text")

</t>
<t tx="newlife.20120104153340.1815">def get_user(self):

    user = self.api.me()
    self.obj = user
    city = self.getAtt('city')
    description = self.getAtt('description')
    domain = self.getAtt('domain')
    gender = self.getAtt('gender')
    id = self.getAtt('id')
    location = self.getAtt('location')
    realname = self.getAtt('name')
    image_url = self.getAtt('profile_image_url')
    province = self.getAtt('province')
    screen_name = self.getAtt('screen_name')
    website = self.getAtt('url')
    return locals()

</t>
<t tx="newlife.20120104153340.1816">def destroy_status(self, id):
    status = self.api.destroy_status(id)
    self.obj = status
    id = self.getAtt("id")
    text = self.getAtt("text")

</t>
<t tx="newlife.20120104153340.1817">def update_message(accesstoken, message, url):
        sina = OAuth()
        sina.setAccessToken(accesstoken)
        try:
            sina.update(message + "http://www.beitaichufang.com" + url)
        except WeibopError:
            pass


</t>
<t tx="newlife.20120104153340.1830">@language python
@tabwidth -4
@others
@ignore
@doc
sina_auth_redirect


</t>
<t tx="newlife.20120104153340.1831">#!/usr/bin/python
# -*- coding: utf-8 -*-

import time

from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render_to_response
from django.template import RequestContext as Context
from weibopy.error import WeibopError



from app.common.views import CloseWindowResponse
#from app.utils.decorators import sina_access_required
from core.sinaapi import OAuth, update_message
from app.account.forms import SinaSignupForm, SigninForm

FORGOT_URL = "/account/password/forgot/"

SUCCESS_MSG = u'我刚刚在 @贝太厨房 网站用新浪微博账户登陆成功了！\
         这里有上万道好吃易做的家常菜谱，学做菜，写评论，参加美食有奖活动，\
         和最爱美食厨房的达人们一起分享美食乐趣。还能和微博好友实时互动，你也来看看吧！'
</t>
<t tx="newlife.20120104153340.1832">#SUCCESS_MSG = u'我刚刚绑定了#贝太厨房#，这里有上万道好吃易做的家常菜谱，\
#         学做菜，写评论，参加美食有奖活动，和最爱美食厨房的达人们一起分享美食乐趣。还能和微博好友实时互动，\
#         你也来看看吧！'

def initial_user_info_data(user_info, sinauseraccess):
    flatten_data = {}
    for field in ('username', 'email', 'password1', 'password2'):
        flatten_data[field] = ''
    flatten_data['gender'] = GENDER_MAPPING[user_info['gender']]
    flatten_data['website'] = user_info['website']
    flatten_data['nickname'] = user_info['realname']
    flatten_data['user_avatar'] = user_info['image_url']
#    flatten_data['nickname'] = user_info['screen_name']
    flatten_data['sinauseraccess'] = sinauseraccess

    if 'province' in user_info:
        province = PROVINCE_MAPPING[user_info['province']]
        p = Province.objects.get(title_zh=province)
        flatten_data['province'] = p.id
        flatten_data['country'] = p.country.id
    else:
        flatten_data['province'] = Province.objects.get(slug='beijing').id
        flatten_data['country'] = Country.objects.get(slug='china').id

    return flatten_data
#初始用户数据，
</t>
<t tx="newlife.20120104153340.1833">@login_required
def unbind_sina(request):
    phpbb_user = request.user.get_profile()
    phpbb_user.sinauseraccess = ""
    phpbb_user.save()
    return HttpResponseRedirect(phpbb_user.get_absolute_url())

</t>
<t tx="newlife.20120104153340.1834">def sina_auth_redirect(request):
    " 最开始登陆的地方"
    if request.REQUEST.get('next', None):
        request.session['next'] = request.REQUEST.get('next')
    sina = OAuth()
    request.session['sina_api'] = sina
    redirect = sina.get_auth_url()
    return HttpResponseRedirect(redirect)

</t>
<t tx="newlife.20120104153340.1835">def callback(request):
    next = request.session.get('next', None)
    if not request.session.__contains__('sina_api'):
        return HttpResponseRedirect(next and "/sina/?next=%s" % next or "/sina/")

    sina = request.session.get('sina_api')
    oauth_verifier = request.GET['oauth_verifier']
    try:
        sina.oauth(oauth_verifier)
    except WeibopError:
        return HttpResponseRedirect(next and "/sina/?next=%s" % next or "/sina/")
    request.session['sina_access_token'] = sina.auth.access_token.key
    request.session['sina_access_secret'] = sina.auth.access_token.secret
    del request.session['sina_api']
        
    sinauser = PhpbbUser.objects.filter(sinauseraccess=sina.auth.access_token.to_string())
    if request.user.is_authenticated() and len(sinauser) &gt; 0 and sinauser[0].user != request.user:
        if next:
            return HttpResponse("&lt;p&gt;错误！每个微博帐号只能绑定一个贝太厨房帐号！&lt;/p&gt;&lt;p&gt;&lt;a href='%s' title='返回之前的页面' &gt;返回之前的页面&lt;/a&gt;&lt;/p&gt;" % next)
        return HttpResponse("错误！每个微博帐号只能绑定一个贝太厨房帐号！")

    if len(sinauser) &gt; 0:
        login_user = sinauser[0]
        login_user.user.backend='django.contrib.auth.backends.ModelBackend'
        login(request, login_user.user)
        now = int(time.time())
        login_user.lastvisit = login_user.session_time or now
        login_user.session_time = now
        login_user.save()
        msg = u"新浪微博登录成功！"
        messages.info(request, msg)
        if next:
            return HttpResponseRedirect(next)
        return CloseWindowResponse(request, custom_js="parent.BK3.mlogin_load();", close=True, template="utils/close_colorbox.html")

    if request.user.is_authenticated():
        phpbb_user = request.user.get_profile()
        phpbb_user.sinauseraccess = sina.auth.access_token.to_string()
        phpbb_user.save()
        if next:
            msg = u"新浪微博绑定成功！&lt;a href='/sina_msg/?next=%s'&gt;将此消息同步到新浪微博客！&lt;/a&gt;或者&lt;a href='%s'&gt;直接返回&lt;/a&gt;" % (next, next)
        else:
            msg = u"新浪微博绑定成功！&lt;a href='/sina_msg/'&gt;将此消息同步到新浪微博客！&lt;/a&gt;"

        return HttpResponse(msg)

    request.session.set_test_cookie()
    # prepare signin form
    signin_form = SigninForm(request, initial={'sinauseraccess': sina.auth.access_token.to_string()})

    # prepare signup form
    signup_data = initial_user_info_data(sina.get_user(), sina.auth.access_token.to_string())
    signup_form = SinaSignupForm(initial=signup_data)
    if PhpbbUser.objects.filter(nickname = signup_data['nickname']).count() &gt; 0:
        signup_form.errors['nickname'] = signup_form.error_class([u"该昵称用户已经存在，请尝试换个昵称。"])

    context = {'forgot_url': FORGOT_URL, 'signin_form': signin_form, 'signup_form': signup_form, 'nickname': signup_data['nickname'] }
    if next:
        context.update({'next': next})
    return render_to_response('colorbox/sina_connect_page.html', Context(request, context))


</t>
<t tx="newlife.20120104153340.1836">@sina_access_required
def sina_signin(request):
    next = request.REQUEST.get('next', None)
    if not request.POST.has_key('sinauseraccess'):
        return HttpResponseRedirect(next and '/sina/?next=%s' % next or '/sina/')

    if request.method == 'POST':
        signin_form = SigninForm(request, data=request.POST)

        if signin_form.is_valid():
            login(request, signin_form.get_user())
            user = request.user
            phpbb_user = user.get_profile()
            phpbb_user.sinauseraccess = request.POST['sinauseraccess']
            now = int(time.time())
            phpbb_user.lastvisit = phpbb_user.session_time or now
            phpbb_user.session_time = now
            phpbb_user.save()

            msg = u"新浪微博绑定成功！"
            messages.info(request, msg)

            if request.POST.get('sendmsg'):
                update_message(phpbb_user.sinauseraccess, SUCCESS_MSG, '/')

            if request.session.test_cookie_worked():
                request.session.delete_test_cookie()
            if next:
                return HttpResponseRedirect(next)
            return CloseWindowResponse(request, custom_js="parent.BK3.mlogin_load();", close=True, template="utils/close_colorbox.html")
        else:
            sina = OAuth()
            sina.setAccessToken(request.POST['sinauseraccess'])
            signup_data = initial_user_info_data(sina.get_user(), sina.auth.access_token.to_string())
            signup_form = SinaSignupForm(initial=signup_data)
            context = { 'forgot_url': FORGOT_URL, 'signin_form': signin_form, 'signup_form': signup_form, 'signin_error': True, 'nickname': signup_data['nickname'] }
            return render_to_response('colorbox/sina_connect_page.html', Context(request, context))

</t>
<t tx="newlife.20120104153340.1837">@sina_access_required
def sina_signup(request):
    next = request.REQUEST.get('next', None)
    if not request.POST.has_key('sinauseraccess'):
        return HttpResponseRedirect(next and '/sina/?next=%s' % next or '/sina/')

    if request.method == "POST":
        signup_form = SinaSignupForm(request.POST)
        if signup_form.is_valid():
            phpbb_user = signup_form.save()
            # register success, auto login
            phpbb_user.user.backend='django.contrib.auth.backends.ModelBackend'
            login(request, phpbb_user.user)
            msg = u"新浪微博绑定成功！"
            messages.info(request, msg)
            if request.POST.get('sendmsg'):
                update_message(phpbb_user.sinauseraccess, SUCCESS_MSG, '/')
            if next:
                return HttpResponseRedirect(next)
            return CloseWindowResponse(request, custom_js="parent.BK3.mlogin_load();", close=True, template="utils/close_colorbox.html")
        else:
            signin_form = SigninForm(request, initial={'sinauseraccess': request.POST['sinauseraccess']})
            context = { 'forgot_url': FORGOT_URL, 'signin_form': signin_form, 'signup_form': signup_form, 'signup_error': True, 'nickname': request.POST['nickname'] }
        return render_to_response('colorbox/sina_connect_page.html', Context(request, context))
    

</t>
<t tx="newlife.20120104153340.1838">
@sina_access_required
def sina_msg(request):
    next = request.REQUEST.get('next', None)
    update_message(request.user.get_profile().sinauseraccess, SUCCESS_MSG, '/')
    if next:
        return HttpResponseRedirect(next)
    return CloseWindowResponse(request, custom_js="parent.BK3.mlogin_load();", close=True, template="utils/close_colorbox.html")
</t>
<t tx="newlife.20120209162149.1177">发自内心的深爱这个项目，多好玩啊，只有对这个东西保持极大的热情才能有无限的激情去把这个项目做好。
这个项目核心的地方就是哪个微薄了啊，可是现在看着那叫一个烂啊</t>
</tnodes>
</leo_file>
