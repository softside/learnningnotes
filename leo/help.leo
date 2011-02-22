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
<v t="newlife.20110222161135.1268"><vh>doc</vh></v>
<v t="newlife.20110222161135.1267" a="E"><vh>cache.py</vh>
<v t="newlife.20110222161135.1269"><vh>@file /home/newlife/ddl_server/ddl_server/sns_ddl/apps/help/constants.py</vh></v>
<v t="newlife.20110222161135.1271" a="O"><vh>@file /home/newlife/ddl_server/ddl_server/sns_ddl/apps/help/helper.py</vh></v>
<v t="newlife.20110222161135.1272" a="O"><vh>@file /home/newlife/ddl_server/ddl_server/sns_ddl/apps/help/models.py</vh>
<v t="newlife.20110222161135.1273"><vh>models declarations</vh></v>
<v t="newlife.20110222161135.1274"><vh>class MyHelpedRecord</vh>
<v t="newlife.20110222161135.1275"><vh>save</vh></v>
<v t="newlife.20110222161135.1276"><vh>delete</vh></v>
<v t="newlife.20110222161135.1277"><vh>class Meta</vh></v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110222161135.1267"># -*- coding: utf-8 -*-

from datetime import datetime, timedelta
from django.core.cache import cache
from apps.system.helper import choose_a_db
from apps.help.constants import *
from apps.help.models import *
CACHE_MY_HELPED_MEMBERS 帮助过我的人，，

#帮助一下我，
def new_my_helper_info(member, helper, help_type, help_id=0):
    #member是个人，helper也是个人，
    mhr = MyHelpedRecord(member_id=member.id, helper_member_id=helper.id,helper_nickname=helper.nickname, help_type=help_type, help_id=help_id)
    mhr.save()
    
    #更新cache
    count = 1
    cur_day = datetime.now().day
    key = CACHE_MY_HELPED_MEMBERS % (member.id, cur_day)#这个key是谁，那天，对应的value是个字典，{helper.id:[helper.nickname,1]}
    helpers = cache.get(key, None)
    if helpers:
        h = helpers.get(helper.id, None)#判断是否这个人帮助过，
        if h:
            count = h[1]+1
            helpers[helper.id] = [helper.nickname, count]#如果帮助了，计数+1
            
        else:
            helpers[helper.id] = [helper.nickname, 1]
    else:#如果没有缓存，
        helpers = {helper.id:[helper.nickname, 1]}
    cache.set(key, helpers, 172800)    
    return count
      
#取帮助my的用户信息
def get_my_helpers_info(member_id, is_today):#这个就是标准的对应需求，今天就是True，昨天就是False
    if is_today:
        cur_day = datetime.now().day
    else:
        cur_date = datetime.now()-timedelta(1,0)
        cur_day = cur_date.day
        
    key = CACHE_MY_HELPED_MEMBERS % (member_id, cur_day)
    helpers = cache.get(key, None)
    
    if helpers == None:
        try:
            chosen_db = choose_a_db(member_id)
            hrs = MyHelpedRecord.objects.using(chosen_db).filter(member_id=member_id, create_time__day=cur_day).order_by('helper_member_id')
            helpers = {}
            for rec in hrs:
                h = helpers.get(rec.helper_member_id, None)
                if h:
                    helpers[rec.helper_member_id] = [h[0], h[1]+1]
                else:
                    helpers[rec.helper_member_id] = [rec.helper_nickname, 1]
        except:
            helpers = {}
        
        cache.set(key, helpers, 172800)
    return helpers


</t>
<t tx="newlife.20110222161135.1268">对象	           每点【爱心值】效果	             最多点击人数	     创建点
派遣	           该派遣中的龙返回时间减少总时间的4%	5	          龙派遣出去后
任务	            该任务目标进度增加1点	   根据任务条件定	          任务接受后
请求【痛扁】	      请求进度增加1点	           10                    闯关失败面板上的【求助】按钮
请求【强力扫帚】	请求进度增加1点	           3	                点击【强力扫帚】道具不够时信息面板上【求助】按钮
请求【战斗号角】	请求进度增加1点	           5	                点击【战斗号角】道具不够时信息面板上【求助】按钮
</t>
<t tx="newlife.20110222161135.1271">@language python
@tabwidth -4
@others
# -*- coding: utf-8 -*-

</t>
<t tx="newlife.20110222161135.1272">@language python
@tabwidth -4
@others
</t>
<t tx="newlife.20110222161135.1273"># -*- coding: utf-8 -*-

from datetime import datetime
from django.db import models
from django.core.cache import cache
from apps.system.models import MultiDB
from apps.help.constants import *

</t>
<t tx="newlife.20110222161135.1274">#注意：这一块的 cache 维护，通过 cache.py 里的相应代码处理
#帮助的类型
#('G1', u'派遣'),
#('G2', u'痛扁'),
#('M1', u'战斗号角'),
#('P1', u'强力扫帚'),
#('T1', u'任务'),
class MyHelpedRecord(MultiDB):
    #member_id = models.IntegerField()
    helper_member_id = models.IntegerField() #帮助者的 member_id
    helper_nickname = models.CharField(max_length=128)
    help_type = models.CharField(max_length=3) #帮助的类型
    help_id = models.IntegerField(default=0) #根据 help_type 不同，对应不同的数据记录id
    create_time = models.DateTimeField(auto_now_add=True, default=datetime.now)

    @others
</t>
<t tx="newlife.20110222161135.1275">def save(self):
    super(MyHelpedRecord, self).save()

</t>
<t tx="newlife.20110222161135.1276">def delete(self):
    super(MyHelpedRecord, self).delete()

</t>
<t tx="newlife.20110222161135.1277">class Meta:
    db_table = 'ppy_myhelpedrecord'


</t>
</tnodes>
</leo_file>
