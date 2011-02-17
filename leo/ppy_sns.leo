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
<v t="newlife.20110216164544.1268" a="E"><vh>描述ppy平台</vh>
<v t="newlife.20110216164544.1270" a="E"><vh>@file /home/newlife/bubblefish/paopaoyu/apps/webservice/login_renren.py</vh>
<v t="newlife.20110216164544.1271"><vh>login_renren declarations</vh></v>
<v t="newlife.20110216164544.1272"><vh>paopaoyu_ifframe</vh></v>
<v t="newlife.20110216164544.1273"><vh>paopaoyu</vh></v>
<v t="newlife.20110216164544.1274"><vh>login_from_web</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110216164544.1268"></t>
<t tx="newlife.20110216164544.1270">@language python
@tabwidth -4
@others
@ignore</t>
<t tx="newlife.20110216164544.1271"># -*- coding: utf-8 -*-
from apps.messages.helper import *
from apps.members.helper import *
from apps.sns.helper import sendMyRewardGift
from apps.sns.sns_api import *
from apps.sns.sns_msg import *
from datetime import datetime, date
from apps.webservice.almanac import *
from apps.webservice.catchfish import *
from apps.webservice.member import *
from apps.webservice.myspace import *
from apps.webservice.pubsea import *
from apps.webservice.shopping import *
from apps.webservice.synthesis import *
from apps.webservice.score import *
from django.conf import settings
from urllib import urlencode
from django.shortcuts import render_to_response
from django.template import RequestContext
from apps.wap.views import login_from_wap
from apps.system.helper import generate_renren_sig
from invite_renren.models import *
from invite_renren.helper import *
from apps.freegift.helper import get_fans_gifts

</t>
<t tx="newlife.20110216164544.1272">def paopaoyu_ifframe(request):
    is_wap = request.GET.get('xn_sig_mobile', None) or request.POST.get('xn_sig_mobile', None)
    if is_wap:
        return login_from_wap(request)
    else:
        app_url = settings.APP_CANVAS_CALLBACK_URL
        sns_id = request.GET.get('sns_id', '') or request.POST.get('sns_id', '')
        fans_gift_snsid = request.GET.get('s', '') or request.POST.get('s', '')
        fans_gift_id = request.GET.get('i', '') or request.POST.get('i', '')
        invite_sender_snsid = request.GET.get('ii', '') or request.POST.get('ii', '')

        data = {'app_url':app_url,
            'sns_id':sns_id,
            'f_sns_id':fans_gift_snsid,
            'gift_id':fans_gift_id,
            'ii': invite_sender_snsid,
        }

        r = render_to_response('sns/index.html', data, context_instance=RequestContext(request))
        r["P3P"] = "CP=CURa ADMa DEVa PSAo PSDo OUR BUS UNI PUR INT DEM STA PRE COM NAV OTC NOI DSP COR"
        r["x-ua-compatible"] = "IE=EmulateIE7"

        return r

</t>
<t tx="newlife.20110216164544.1273">def paopaoyu(request):
    return login_from_web(request)

</t>
<t tx="newlife.20110216164544.1274">def login_from_web(request):
    session_key = request.GET.get('xn_sig_session_key', None)
    to_sns_id = request.GET.get('sns_id', '') or request.POST.get('sns_id', '')
    fans_gift_snsid = request.GET.get('s', '') or request.POST.get('s', '')
    fans_gift_id = request.GET.get('i', '') or request.POST.get('i', '')
    if session_key is None:
        api_key = settings.SNS_API_KEY
        if request.GET.has_key('ii'):
            xiaonei_url = '%s?ii=%s' % (settings.SNS_URL, request.GET.get('ii'))
        else:
            xiaonei_url = settings.SNS_URL
        from_renren = True
        if request.GET.get('xn_sig_domain', None) == 'kaixin.com':
            from_renren = False
        return render_to_response('sns/auth_sns.html',
                                  {'api_key':api_key,
                                'xiaonei_url':xiaonei_url,
                                'from_renren':from_renren},
                                context_instance=RequestContext(request))    
    # Validate params from renren
    params = request.GET.copy()
    sig = params.pop('xn_sig')[0]
    for key in filter(lambda x:not x.startswith('xn_sig_'), params.keys()):
        del params[key]
    if sig == generate_renren_sig(params):
        sns_id = request.GET.get('xn_sig_user')
        member = get_member_by_sns_id(sns_id)
        if member is None:
            member = register_member(request, session_key, sns_id)
            # 邀请赠送
            if request.GET.has_key('ii'):
                sender_sns_id = request.GET.get('ii')
                is_vip = check_vip_user(session_key, sns_id)
                try:
                    invitation = InSiteInvitation.objects.get(sender_sns_id=sender_sns_id, invitee_sns_id=sns_id)
                    if not invitation.invite_result:
                        invitation.invite_result = True
                        invitation.is_vip = is_vip
                        invitation.save()
                        if not is_vip:
                            update_isinvite_reward(sender_sns_id)
                        else:
                            update_vip_isinvite_reward(sender_sns_id)
                except:
                    pass

    # varify the disabled user
    if is_disabled_member(member.sns_id):
        return render_to_response('sns/disabled.html')
    # 更新头像和用户名信息
    try:
        sns_user_name, sns_user_avatar = get_sns_user(session_key, member.sns_id)
        if member.nickname != sns_user_name or member.avatar != sns_user_avatar:
            member.nickname = sns_user_name
            member.avatar = sns_user_avatar
            member.save()
    except:
        pass

    #收取 fans 朋友送的礼物
    if fans_gift_snsid and fans_gift_id:
        try:
            fans_gift_id = int(fans_gift_id)
            host = get_member_by_sns_id(fans_gift_snsid)
            if host:
                get_fans_gifts(member,host, fans_gift_id)
        except:
            import sys
            print sys.exc_info()

    # 当天第一次登录
    if not member.last_gift or member.last_gift.date() &lt; date.today():
        is_fan = check_is_fan(member.sns_id)
        if is_fan:
            reward_food = RENREN_FAN_LOGIN_REWARD_FOOD
        else:
            reward_food = LOGIN_REWARD_FOOD
        member.fish_food += reward_food
        member.remain_shock_times = REMAIN_SHOCK_TIMES
        member.last_gift = datetime.now()
        member.carnival_times = 0
        member.save()
        send_login_reward_food_msg(member, reward_food)

        #检查蒙牛积分情况，大于5000积分送奖励
        user_score = check_user_score(session_key, member.sns_id)
        nscore = 0
        try:
            nscore = int(user_score)
        except:
            pass

        if nscore&gt;5000:
            sendMyRewardGift(member.sns_id, ('mn5000',))
        #重算经验
        recal_exp(member.sns_id)

    media_url = settings.MEDIA_URL
    sns_url = settings.SNS_URL
    data = {'media_url':media_url, 'sns_url':sns_url, 'skey':session_key, 'sns_id':to_sns_id}

    r = render_to_response('sns/renren.html',data, context_instance=RequestContext(request))
    r["P3P"] = "CP=CURa ADMa DEVa PSAo PSDo OUR BUS UNI PUR INT DEM STA PRE COM NAV OTC NOI DSP COR"
    r["x-ua-compatible"] = "IE=EmulateIE7"

    return r


</t>
</tnodes>
</leo_file>
