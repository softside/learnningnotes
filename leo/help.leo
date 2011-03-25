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
<v t="newlife.20110222161135.1267"><vh>cache.py</vh></v>
<v t="newlife.20110222161135.1271" a="O"><vh>sns_ddl/apps/help/helper.py</vh></v>
<v t="newlife.20110222161135.1272" a="O"><vh>sns_ddl/apps/help/models.py</vh>
<v t="newlife.20110222161135.1273"><vh>models declarations</vh></v>
<v t="newlife.20110222161135.1274"><vh>class MyHelpedRecord</vh>
<v t="newlife.20110222161135.1275"><vh>save</vh></v>
<v t="newlife.20110222161135.1276"><vh>delete</vh></v>
<v t="newlife.20110222161135.1277"><vh>class Meta</vh></v>
</v>
</v>
<v t="newlife.20110222161135.1269" a="O"><vh>sns_ddl/apps/help/constants.py</vh></v>
<v t="newlife.20110223101524.1286" a="E"><vh>help_category</vh>
<v t="newlife.20110223101524.1287"><vh>派遣</vh></v>
<v t="newlife.20110223101524.1290" a="E"><vh>/sns_ddl/apps/webservice/assist.py</vh>
<v t="newlife.20110223101524.1291"><vh>assist declarations</vh></v>
<v t="newlife.20110223101524.1292"><vh>getDispatchedDragonsAMF</vh></v>
<v t="newlife.20110223101524.1293"><vh>getComingSoonDragonAMF</vh></v>
<v t="newlife.20110223101524.1294"><vh>dispatchDragonAMF</vh></v>
<v t="newlife.20110223101524.1295"><vh>harvestDragonAMF</vh></v>
<v t="newlife.20110223101524.1296"><vh>buyAssistPositionAMF</vh></v>
<v t="newlife.20110223101524.1297"><vh>getShortPhysicInfoAMF</vh></v>
<v t="newlife.20110223101524.1298"><vh>shortPhysicAMF</vh></v>
</v>
</v>
<v t="newlife.20110223101524.1288"><vh>base_fuction</vh></v>
<v t="newlife.20110223101524.1299"><vh>数据库处理</vh></v>
<v t="newlife.20110223101524.1300"><vh>这是啥</vh></v>
<v t="newlife.20110225112453.1314"><vh>/sns_ddl/apps/webservice/help.py</vh>
<v t="newlife.20110225112453.1315"><vh>help declarations</vh></v>
<v t="newlife.20110225112453.1316"><vh>getHelpLogAMF</vh></v>
<v t="newlife.20110225112453.1317"><vh>getHelpItemListAMF</vh></v>
<v t="newlife.20110225112453.1318"><vh>doHelpAMF</vh></v>
</v>
<v t="newlife.20110225112453.1319"><vh>new_cache</vh></v>
<v t="newlife.20110228142419.1326"><vh>函数啊，，</vh></v>
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
<t tx="newlife.20110222161135.1269"></t>
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
<t tx="newlife.20110223101524.1286">    is_today = to_day!=0 and True or False
#      to_day = 0
      False and True or False --&gt;False
      True and True or False ---&gt; True</t>
<t tx="newlife.20110223101524.1287"># -*- coding: utf-8 -*-

import math
from datetime import datetime, timedelta
from global_constants import *
from apps.system.helper import *
from apps.members.constants import LEVEL_UP_EXP
from apps.members.cache import *
from apps.members.helper import *
from apps.games.cache import *
from apps.tasks.helper import check_done_task, update_my_normal_task
from apps.products.cache import *
from apps.shops.cache import get_shop_product

#获取所有派遣龙的状态,这个是点击那个触发的,?
def getDispatchedDragonsAMF(request, skey, host_id):
    member = login_member(request, skey)
    host_id = int(host_id)
    host = get_member(host_id)#2人？
    
    dispatch_list = []
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(host.id)#获取别人的派遣龙。
    for my_dispatch_pet_id in my_dispatch_pet_ids:
        dispatch_pet_info = get_my_dispatch_pet_info(host.id, my_dispatch_pet_id)
        my_dispatch_pet = get_my_fish(host.id, my_dispatch_pet_id)
        top_level = can_send_to_level(my_dispatch_pet, dispatch_pet_info.stage)
        if dispatch_pet_info.status == 'c':
            if datetime.now() &gt;= dispatch_pet_info.end_time:
                dispatch_pet_info.status = 'b'
                dispatch_pet_info.end_time = None
                # 计算蛋蛋龙能刷到第几大关的蛋
                dispatch_pet_info.caught_fish = refresh_fish_to_level(dispatch_pet_info.stage, top_level)
                dispatch_pet_info.save()
        # 计算剩余时间
        if dispatch_pet_info.end_time is not None:
            rest_time = dispatch_pet_info.end_time - datetime.now()
            rest_seconds = rest_time.days*24*3600 + rest_time.seconds
        else:
            rest_seconds = 0
        caught_fish_styles = dispatch_pet_info.get_caught_fish_styles()
        fish_list = []
        for fish_style in caught_fish_styles:
            fish = get_fish_with_stylecolor(fish_style)
            fish_list.append({'style':fish_style, 'star':fish.star, 'name':fish.name})
        result = {'status':dispatch_pet_info.status,
                  'rest_time':rest_seconds,
                  'dragon_list':fish_list,
                  'stage':dispatch_pet_info.stage,
                  'id':my_dispatch_pet_id,
                  'style':my_dispatch_pet.get_display_style(),
                  'is_protected':dispatch_pet_info.is_protected,
                  'top_level':top_level
                  }
        dispatch_list.append(result)

    dispatch_list.sort(lambda x,y: cmp(x['rest_time'], y['rest_time']) )
    task_list = ''
    rewards = ''
    return {'shell_positions':host.shell_dispatch,
            'pearl_positions':host.pearl_dispatch,
            'dispatch_list':dispatch_list,
            'task_list':task_list,
            'rewards':rewards,}
    

#获取最近回来的龙的信息
def getComingSoonDragonAMF(request, skey, host_id):
    member = login_member(request, skey)
    host_id = int(host_id)
    host = get_member(host_id)

    my_dispatch_pet_ids = get_my_dispatch_pet_ids(host.id)
    dispatch_count = host.shell_dispatch + host.pearl_dispatch
    can_dispatch_count = len(my_dispatch_pet_ids)
    # 无派遣龙
    if can_dispatch_count &lt;= 0 or can_dispatch_count &lt; dispatch_count:
        return {'status':'no dispatched pet', 'rewards':'', 'task_list':''}
    my_dispatch_pet_infos = get_my_dispatch_pet_infos(host.id, my_dispatch_pet_ids)
    # 按时间排序取得最近的一条
    dpis = filter(lambda x: not x.end_time, my_dispatch_pet_infos)
    if dpis:
        dispatch_pet_info = dpis[0]
    else:
        my_dispatch_pet_infos.sort(lambda x,y: cmp(x.end_time, y.end_time))
        dispatch_pet_info = my_dispatch_pet_infos[0]

    my_dispatch_pet = get_my_fish(host.id, dispatch_pet_info.my_fish_id)
    top_level = can_send_to_level(my_dispatch_pet, dispatch_pet_info.stage)
    if dispatch_pet_info.status == 'c':
        if datetime.now() &gt;= dispatch_pet_info.end_time:
            dispatch_pet_info.status = 'b'
            dispatch_pet_info.end_time = None
            # 计算蛋蛋龙能刷到第几大关的蛋
            dispatch_pet_info.caught_fish = refresh_fish_to_level(dispatch_pet_info.stage, top_level)
            dispatch_pet_info.save()
    # 计算剩余时间
    if dispatch_pet_info.end_time is not None:
        rest_time = dispatch_pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds
    else:
        rest_seconds = 0
        
    task_list = ''
    rewards = ''
    result = {'status':dispatch_pet_info.status,
              'rest_time':rest_seconds,
              'task_list':task_list,
              'rewards':rewards,}
    
    return result


#派遣龙
def dispatchDragonAMF(request, skey, my_dispatch_pet_id, stage):
    member = login_member(request, skey)
    my_dispatch_pet_id = int(my_dispatch_pet_id)
    stage = int(stage)
    
    my_dispatch_pet = get_my_fish(member.id, my_dispatch_pet_id)
    #Fish的一个实例。    
    if not my_dispatch_pet:
        return {'error':'Fish does not exist', 'rewards':'', 'task_list':''}
    if my_dispatch_pet.my_fish_tank_id != 0:
        return {'error':'Not in bag', 'rewards':'', 'task_list':''}
    if stage &gt; member.tempo:
        return {'error':'Wrong stage', 'rewards':'', 'task_list':''}
    if my_dispatch_pet.level &lt; 2:
        return {'error':'Level not enough', 'rewards':'', 'task_list':''}
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(member.id)
    if len(my_dispatch_pet_ids) &gt;= member.shell_dispatch + member.pearl_dispatch:
        return {'error':'No position', 'rewards':'', 'task_list':''}
    # 判断是否休息状态的蛋蛋龙
    if my_dispatch_pet.get_power() != DRAGON_MAX_POWER:
        return {'error':'cold down', 'rewards':'', 'task_list':''}

    # 设置蛋蛋龙为派遣状态
    my_dispatch_pet.my_fish_tank_id = -1
    my_dispatch_pet.save()
    # 更新背包缓存
    my_fish_ids_in_bag = get_my_fish_ids_in_bag(member.id)
    if my_dispatch_pet_id in my_fish_ids_in_bag:
        my_fish_ids_in_bag.remove(my_dispatch_pet_id)
    update_my_fish_ids_in_bag(member.id, my_fish_ids_in_bag)
    # 创建并初始化派遣模型
    top_level = can_send_to_level(my_dispatch_pet, stage)
    pet_time = 3600
    if top_level &gt; 0 and top_level &lt; 3:
        pet_time = 3600
    elif top_level &gt; 2 and top_level &lt; 5:
        pet_time = 2 * 3600
    else:
        pet_time = 6 * 3600
    my_dispatch_pet_info = PetTempInfo(member_id = member.id,
                                        my_fish_id=my_dispatch_pet_id, 
                                        stage=stage,
                                        end_time=datetime.now()+timedelta(0, pet_time))
    my_dispatch_pet_info.save()
    # 更新派遣列表缓存
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(member.id)
    if my_dispatch_pet_info.my_fish_id not in my_dispatch_pet_ids:
        my_dispatch_pet_ids.append(my_dispatch_pet_info.my_fish_id)
    update_my_dispatch_pet_ids(member.id, my_dispatch_pet_ids)

    #do task
    rewards, my_task = check_done_task(member,'t001',my_dispatch_pet.style,1,my_dispatch_pet.family,my_dispatch_pet.p_type,my_dispatch_pet.star)
    if rewards:
        task_list = update_my_normal_task(member.id, my_task)
    else:
        task_list = ''
    result = {'status':my_dispatch_pet_info.status,
              'rest_time':pet_time,
              'stage':my_dispatch_pet_info.stage,
              'style':my_dispatch_pet.get_display_style(),
              'task_list':task_list,
              'rewards':rewards,
              }
    return result


#收取龙
def harvestDragonAMF(request, skey, my_dispatch_pet_id):
    member = login_member(request, skey)
    my_dispatch_pet_id = int(my_dispatch_pet_id)
    
    my_dispatch_pet = get_my_fish(member.id, my_dispatch_pet_id)
    if not my_dispatch_pet:
        return {'error':'Fish does not exist', 'rewards':'', 'task_list':''}
    if my_dispatch_pet.my_fish_tank_id != -1:
        return {'error':'Not dispatched.', 'rewards':'', 'task_list':''}
    my_dispatch_pet_info = get_my_dispatch_pet_info(member.id, my_dispatch_pet_id)
    caught_fish_styles = my_dispatch_pet_info.get_caught_fish_styles()
    # 判断背包位是否够放下龙和蛋
    if len(get_my_fish_ids_in_bag(member.id)) + len(caught_fish_styles) + 1 &gt; member.current_bags():
        return {'error':'Bag is not enough', 'rewards':'', 'task_list':''}
    
    # 保存龙蛋
    almanac_fish = []
    reward_almanac = ''
    task_almanac = ''
    reward_dragon = ''
    task_dragon = ''
    reward_all_almanac = ''
    task_all_almanac = ''
    for fish_style in caught_fish_styles:
        fish = get_fish_with_stylecolor(fish_style)
        # 打开新图鉴
        my_fish = new_a_member_fish(member, fish)
        opened = isopen_new_almanac(member, my_fish)
        reward, task = check_done_task(member, 't003', my_fish.style, 1, my_fish.family, my_fish.p_type, my_fish.star)
        if reward:
            reward_dragon = reward
            task_dragon = task
        
        if opened:
            rewards, my_task = check_done_task(member, 't019', my_fish.style, 1,
                    my_fish.family, my_fish.p_type, my_fish.star)
            if rewards:
                reward_almanac = rewards
                task_almanac = my_task
            
            get_fish_exp, get_exp, open_all = update_member_almanac_exp(member, my_fish)
            temp = {
                'style':my_fish.style,
                'name':fish.name,
                'star':my_fish.star,
                'bonus':get_exp,
                'level':my_fish.level,
                'open_all':open_all,
            }
            almanac_fish.append(temp)
            
            if open_all:
                reward, task = check_done_task(member, 't020', my_fish.base_style, 1)
                if reward:
                    reward_all_almanac = reward
                    task_all_almanac = task
    # 蛋蛋龙回到背包，并按每小时10点增加成长值
    top_level = can_send_to_level(my_dispatch_pet, my_dispatch_pet_info.stage)
    pet_time = 3600
    if top_level &gt; 0 and top_level &lt; 3:
        pet_time = 3600
    elif top_level &gt; 2 and top_level &lt; 5:
        pet_time = 2 * 3600
    else:
        pet_time = 6 * 3600
        
    my_dispatch_pet.my_fish_tank_id = 0
    #my_dispatch_pet.exp = min(LEVEL_UP_EXP, int(pet_time/3600*10 + my_dispatch_pet.exp))
    my_dispatch_pet.last_dispatched = datetime.now()
    #体力消耗
    my_dispatch_pet.last_power_time = datetime.now()
    my_dispatch_pet.save()
    # 更新背包缓存
    my_fish_ids_in_bag = get_my_fish_ids_in_bag(member.id)
    if my_dispatch_pet_id not in my_fish_ids_in_bag:
        my_fish_ids_in_bag.append(my_dispatch_pet_id)
    update_my_fish_ids_in_bag(member.id, my_fish_ids_in_bag)
    # 删除派遣的蛋蛋龙模型
    my_dispatch_pet_info.delete()
    # 更新派遣列表缓存
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(member.id)
    if my_dispatch_pet_info.my_fish_id in my_dispatch_pet_ids:
        my_dispatch_pet_ids.remove(my_dispatch_pet_info.my_fish_id)
    update_my_dispatch_pet_ids(member.id, my_dispatch_pet_ids)
    
    level,remain_exp,next_level_exp = get_almanac_level_info(member.id)
    
    #do task
    task_list = ''
    if reward_almanac:
        rewards = reward_almanac
        task_list = update_my_normal_task(member.id, task_almanac)
    elif reward_dragon:
        rewards = reward_dragon
        task_list = update_my_normal_task(member.id, task_dragon)
    elif reward_all_almanac:
        rewards = reward_all_almanac
        task_list = update_my_normal_task(member.id, task_all_almanac)
    else:
        rewards, my_task = check_done_task(member,'t003','',1)
        if rewards:
            task_list = update_my_normal_task(member.id, my_task)
    
    result = {'level':level,
              'remain_exp':remain_exp,
              'next_level_exp':next_level_exp,
              'shells':member.shells,
              'pearls':member.pearls,
              'almanac_fish':almanac_fish,
              'rewards':rewards,
              'task_list':task_list,
              }
    return result


#购买派遣龙位
def buyAssistPositionAMF(request, skey, type):
    member = login_member(request, skey)
    
    level,remain_exp,next_level_exp = get_almanac_level_info(member.id)
    task_list = ''
    if type == 's':
        if member.shell_dispatch &gt;= 6:
            return {'error':'no more position can be open', 'rewards':'', 'task_list':''}
        if level &lt; BUY_SHELL_POSITION_EXP[member.shell_dispatch][0]:
            return {'error':'exp not enough', 'rewards':'', 'task_list':''}
        sell_shells = BUY_SHELL_POSITION_EXP[member.shell_dispatch][1]
        if member.shells &lt; sell_shells:
            return {'error':'shells not enough', 'rewards':'', 'task_list':''}
        member.shells -= sell_shells
        member.shell_dispatch += 1
        member.save()
        
        #do task
        rewards, my_task = check_done_task(member, 't014', '', 1)
        if my_task:
            task_list = update_my_normal_task(member.id, my_task)
    elif type == 'p':
        if member.pearl_dispatch &gt;= 6:
            return {'error':'no more position can be open', 'rewards':'', 'task_list':''}
        if level &lt; BUY_PEARL_POSITION_EXP[member.pearl_dispatch]:
            return {'error':'exp not enough', 'rewards':'', 'task_list':''}
        if member.pearls &lt; 2000:
            return {'error':'pearls not enough', 'rewards':'', 'task_list':''}
        member.pearls -= 2000
        member.pearl_dispatch += 1
        member.save()
        
        #do task
        rewards, my_task = check_done_task(member, 't014', '', 1)
        if rewards:
            task_list = update_my_normal_task(member.id, my_task)
    
    return {'shells':member.shells,
            'pearls':member.pearls,
            'rewards':rewards,
            'task_list':task_list,}

#取得快速收鱼道具数量
def getShortPhysicInfoAMF(request, skey, pet_id):
    member = login_member(request, skey)
    pet_id = int(pet_id)
    pet_info = get_my_dispatch_pet_info(member.id, pet_id)
    # 捕鱼状态不对
    if pet_info.status != 'c':
        return {'error':'status error', 'rewards':'', 'task_list':''}
    # 计算剩余时间
    rest_seconds = 0
    if pet_info.end_time is not None:
        rest_time = pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds
        
    if rest_seconds&lt;=0:
        return {'error':'already return', 'rewards':'', 'task_list':''}
        
    my_item = get_or_create_my_item(member.id, 'p2')
    need_item_count = math.ceil(float(rest_seconds)/(my_item.shorten_time*3600.0))
    shop_product = get_shop_product('p2')
    if not shop_product:
        return {'error': 'server data error(-10000)', 'rewards':'', 'task_list':''}
    
    task_list = ''
    rewards = ''
    return {'need_num':need_item_count,
            'total_num':my_item.total_num,
            'name':my_item.name,
            'price':shop_product.price,
            'sale_type':shop_product.sale_type,
            'task_list':task_list,
            'rewards':rewards,}

#使用快速收鱼道具
def shortPhysicAMF(request, skey, pet_id, useone=True):
    member = login_member(request, skey)
    
    pet_id = int(pet_id)
    pet_info = get_my_dispatch_pet_info(member.id, pet_id)
    # 捕鱼状态不对
    if pet_info.status != 'c':
        return {'error':'status error', 'rewards':'', 'task_list':''}
    # 此次捕鱼已经用过药丸
    #if pet_info.can_be_used_physic():
    #    return {'error':'already used'}
    my_item = get_or_create_my_item(member.id, 'p2')
    if not (my_item and pet_info):
        return {'error': 'data error(-10000)', 'rewards':'', 'task_list':''}
    # 道具类型错误
    if my_item.item_type != 'SST':
        return {'error':'data error(-10001)', 'rewards':'', 'task_list':''}
    
    # 计算剩余时间
    rest_seconds = 0
    if pet_info.end_time is not None:
        rest_time = pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds
        
    if rest_seconds&lt;=0:
        return {'error':'already return', 'rewards':'', 'task_list':''}
        
    need_item_count = 1
    if not useone:
        need_item_count = math.ceil(float(rest_seconds)/(my_item.shorten_time*3600.0))
    # 药丸不够
    if my_item.total_num &lt; need_item_count:
        return {'error':'not enough physic', 'rewards':'', 'task_list':''}
    # 药丸冷却中
    #if get_my_item_cooldown_precent(member.id, my_item) != 100:
    #    return {'error':'item is cooldown'}

    # 减道具
    my_item.total_num -= need_item_count
    my_item.last_used = datetime.now()
    my_item.save()
    
    pet_info = use_physic_for_pet(pet_info, my_item, need_item_count)
    # 计算剩余时间
    if pet_info.end_time is not None:
        rest_time = pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds
    else:
        rest_seconds = 0

    caught_fish_styles = pet_info.get_caught_fish_styles()
    fishes = get_fishes(caught_fish_styles)
    fish_list = [{'style':fish.style} for fish in fishes]
    
    #do task
    rewards, my_task = check_done_task(member, 't002', 'p2', 1)
    if rewards:
        task_list = update_my_normal_task(member.id, my_task)
    else:
        task_list = ''
    result = {'status':pet_info.status,
              'rest_time':rest_seconds,
              'is_stolen':pet_info.is_stolen,
              'is_protected':pet_info.is_protected,
              'dragon_list':fish_list,
              'task_list':task_list,
              'rewards':rewards,
              }

    return result
</t>
<t tx="newlife.20110223101524.1288">        
        chosen_db = choose_a_db(member_id)#根据用户id选择所在的数据库，返回字符串：default,second.third
        chosen_model = choose_a_fish_model(member_id)#返回字符串“MyFishInstance(one..Ten)”
        my_fish = globals()[chosen_model].objects.using(chosen_db).get(id=my_fish_id, member_id=member_id)
        
        以上语句根据用户id，鱼的id取得该鱼。

    
    

get_fish_with_stylecolor()


返回值 d3_l1_3，对d3表示style,l1表示color，
我考，这个也缓存，nb啊。。

所有函数的拆分都是有意义的。

取到龙，然后，获取其剩余时间。



必须适应一种习惯，一个表，2个缓存的项目，

key，生成的时候是new这个地方

处理增加，

习惯了处理简单的逻辑，遇到复杂的逻辑习惯啊。。</t>
<t tx="newlife.20110223101524.1290">@language python
@tabwidth -4
@others
</t>
<t tx="newlife.20110223101524.1291"># -*- coding: utf-8 -*-

import math
from datetime import datetime, timedelta
from global_constants import *
from apps.system.helper import *
from apps.members.constants import LEVEL_UP_EXP
from apps.members.cache import *
from apps.members.helper import *
from apps.games.cache import *
from apps.tasks.helper import check_done_task, update_my_normal_task
from apps.products.cache import *
from apps.shops.cache import get_shop_product

</t>
<t tx="newlife.20110223101524.1292">#获取所有派遣龙的状态
def getDispatchedDragonsAMF(request, skey, host_id):
    member = login_member(request, skey)#当前用户
    host_id = int(host_id)
    host = get_member(host_id)#目标用户
    
    dispatch_list = []
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(host.id)#获取派遣龙的id
    for my_dispatch_pet_id in my_dispatch_pet_ids:
        dispatch_pet_info = get_my_dispatch_pet_info(host.id, my_dispatch_pet_id)
        my_dispatch_pet = get_my_fish(host.id, my_dispatch_pet_id)
        top_level = can_send_to_level(my_dispatch_pet, dispatch_pet_info.stage)
        if dispatch_pet_info.status == 'c':
            if datetime.now() &gt;= dispatch_pet_info.end_time:#如果派遣时间结束，修改状态，修改时间，
                dispatch_pet_info.status = 'b'
                dispatch_pet_info.end_time = None
                #就是这里了，
                # 计算蛋蛋龙能刷到第几大关的蛋
                dispatch_pet_info.caught_fish = refresh_fish_to_level(dispatch_pet_info.stage, top_level)
                dispatch_pet_info.save()
        # 计算剩余时间
        if dispatch_pet_info.end_time is not None:
            rest_time = dispatch_pet_info.end_time - datetime.now()
            rest_seconds = rest_time.days*24*3600 + rest_time.seconds
        else:
            rest_seconds = 0
        caught_fish_styles = dispatch_pet_info.get_caught_fish_styles()
        fish_list = []
        for fish_style in caught_fish_styles:
            fish = get_fish_with_stylecolor(fish_style)
            fish_list.append({'style':fish_style, 'star':fish.star, 'name':fish.name})
        result = {'status':dispatch_pet_info.status,
                  'rest_time':rest_seconds,
                  'dragon_list':fish_list,
                  'stage':dispatch_pet_info.stage,
                  'id':my_dispatch_pet_id,
                  'style':my_dispatch_pet.get_display_style(),
                  'is_protected':dispatch_pet_info.is_protected,
                  'top_level':top_level
                  }
        dispatch_list.append(result)

    dispatch_list.sort(lambda x,y: cmp(x['rest_time'], y['rest_time']) )
    task_list = ''
    rewards = ''
    return {'shell_positions':host.shell_dispatch,
            'pearl_positions':host.pearl_dispatch,
            'dispatch_list':dispatch_list,
            'task_list':task_list,
            'rewards':rewards,}


</t>
<t tx="newlife.20110223101524.1293">#获取最近回来的龙的信息
def getComingSoonDragonAMF(request, skey, host_id):
    member = login_member(request, skey)
    host_id = int(host_id)
    host = get_member(host_id)

    my_dispatch_pet_ids = get_my_dispatch_pet_ids(host.id)
    dispatch_count = host.shell_dispatch + host.pearl_dispatch
    can_dispatch_count = len(my_dispatch_pet_ids)
    # 无派遣龙
    if can_dispatch_count &lt;= 0 or can_dispatch_count &lt; dispatch_count:
        return {'status':'no dispatched pet', 'rewards':'', 'task_list':''}
    my_dispatch_pet_infos = get_my_dispatch_pet_infos(host.id, my_dispatch_pet_ids)
    # 按时间排序取得最近的一条
    dpis = filter(lambda x: not x.end_time, my_dispatch_pet_infos)
    if dpis:
        dispatch_pet_info = dpis[0]
    else:
        my_dispatch_pet_infos.sort(lambda x,y: cmp(x.end_time, y.end_time))
        dispatch_pet_info = my_dispatch_pet_infos[0]

    my_dispatch_pet = get_my_fish(host.id, dispatch_pet_info.my_fish_id)
    top_level = can_send_to_level(my_dispatch_pet, dispatch_pet_info.stage)
    if dispatch_pet_info.status == 'c':
        if datetime.now() &gt;= dispatch_pet_info.end_time:
            dispatch_pet_info.status = 'b'
            dispatch_pet_info.end_time = None
            # 计算蛋蛋龙能刷到第几大关的蛋
            dispatch_pet_info.caught_fish = refresh_fish_to_level(dispatch_pet_info.stage, top_level)
            dispatch_pet_info.save()
    # 计算剩余时间
    if dispatch_pet_info.end_time is not None:
        rest_time = dispatch_pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds
    else:
        rest_seconds = 0

    task_list = ''
    rewards = ''
    result = {'status':dispatch_pet_info.status,
              'rest_time':rest_seconds,
              'task_list':task_list,
              'rewards':rewards,}

    return result


</t>
<t tx="newlife.20110223101524.1294">#派遣龙
def dispatchDragonAMF(request, skey, my_dispatch_pet_id, stage):
    member = login_member(request, skey)
    my_dispatch_pet_id = int(my_dispatch_pet_id)
    stage = int(stage)

    my_dispatch_pet = get_my_fish(member.id, my_dispatch_pet_id)
    if not my_dispatch_pet:
        return {'error':'Fish does not exist', 'rewards':'', 'task_list':''}
    if my_dispatch_pet.my_fish_tank_id != 0:
        return {'error':'Not in bag', 'rewards':'', 'task_list':''}
    if stage &gt; member.tempo:
        return {'error':'Wrong stage', 'rewards':'', 'task_list':''}
    if my_dispatch_pet.level &lt; 2:
        return {'error':'Level not enough', 'rewards':'', 'task_list':''}
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(member.id)
    if len(my_dispatch_pet_ids) &gt;= member.shell_dispatch + member.pearl_dispatch:
        return {'error':'No position', 'rewards':'', 'task_list':''}
    # 判断是否休息状态的蛋蛋龙
    if my_dispatch_pet.get_power() != DRAGON_MAX_POWER:
        return {'error':'cold down', 'rewards':'', 'task_list':''}

    # 设置蛋蛋龙为派遣状态
    my_dispatch_pet.my_fish_tank_id = -1
    my_dispatch_pet.save()
    # 更新背包缓存
    my_fish_ids_in_bag = get_my_fish_ids_in_bag(member.id)
    if my_dispatch_pet_id in my_fish_ids_in_bag:
        my_fish_ids_in_bag.remove(my_dispatch_pet_id)
    update_my_fish_ids_in_bag(member.id, my_fish_ids_in_bag)
    # 创建并初始化派遣模型
    top_level = can_send_to_level(my_dispatch_pet, stage)
    pet_time = 3600
    if top_level &gt; 0 and top_level &lt; 3:
        pet_time = 3600
    elif top_level &gt; 2 and top_level &lt; 5:
        pet_time = 2 * 3600
    else:
        pet_time = 6 * 3600
    my_dispatch_pet_info = PetTempInfo(member_id = member.id,
                                        my_fish_id=my_dispatch_pet_id, 
                                        stage=stage,
                                        end_time=datetime.now()+timedelta(0, pet_time))
    my_dispatch_pet_info.save()
    # 更新派遣列表缓存
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(member.id)
    if my_dispatch_pet_info.my_fish_id not in my_dispatch_pet_ids:
        my_dispatch_pet_ids.append(my_dispatch_pet_info.my_fish_id)
    update_my_dispatch_pet_ids(member.id, my_dispatch_pet_ids)

    #do task
    rewards, my_task = check_done_task(member,'t001',my_dispatch_pet.style,1,my_dispatch_pet.family,my_dispatch_pet.p_type,my_dispatch_pet.star)
    if rewards:
        task_list = update_my_normal_task(member.id, my_task)
    else:
        task_list = ''
    result = {'status':my_dispatch_pet_info.status,
              'rest_time':pet_time,
              'stage':my_dispatch_pet_info.stage,
              'style':my_dispatch_pet.get_display_style(),
              'task_list':task_list,
              'rewards':rewards,
              }
    return result


</t>
<t tx="newlife.20110223101524.1295">#收取龙
def harvestDragonAMF(request, skey, my_dispatch_pet_id):
    member = login_member(request, skey)
    my_dispatch_pet_id = int(my_dispatch_pet_id)

    my_dispatch_pet = get_my_fish(member.id, my_dispatch_pet_id)
    if not my_dispatch_pet:
        return {'error':'Fish does not exist', 'rewards':'', 'task_list':''}
    if my_dispatch_pet.my_fish_tank_id != -1:
        return {'error':'Not dispatched.', 'rewards':'', 'task_list':''}
    my_dispatch_pet_info = get_my_dispatch_pet_info(member.id, my_dispatch_pet_id)
    caught_fish_styles = my_dispatch_pet_info.get_caught_fish_styles()
    # 判断背包位是否够放下龙和蛋
    if len(get_my_fish_ids_in_bag(member.id)) + len(caught_fish_styles) + 1 &gt; member.current_bags():
        return {'error':'Bag is not enough', 'rewards':'', 'task_list':''}

    # 保存龙蛋
    almanac_fish = []
    reward_almanac = ''
    task_almanac = ''
    reward_dragon = ''
    task_dragon = ''
    reward_all_almanac = ''
    task_all_almanac = ''
    for fish_style in caught_fish_styles:
        fish = get_fish_with_stylecolor(fish_style)
        # 打开新图鉴
        my_fish = new_a_member_fish(member, fish)
        opened = isopen_new_almanac(member, my_fish)
        reward, task = check_done_task(member, 't003', my_fish.style, 1, my_fish.family, my_fish.p_type, my_fish.star)
        if reward:
            reward_dragon = reward
            task_dragon = task

        if opened:
            rewards, my_task = check_done_task(member, 't019', my_fish.style, 1,
                    my_fish.family, my_fish.p_type, my_fish.star)
            if rewards:
                reward_almanac = rewards
                task_almanac = my_task

            get_fish_exp, get_exp, open_all = update_member_almanac_exp(member, my_fish)
            temp = {
                'style':my_fish.style,
                'name':fish.name,
                'star':my_fish.star,
                'bonus':get_exp,
                'level':my_fish.level,
                'open_all':open_all,
            }
            almanac_fish.append(temp)

            if open_all:
                reward, task = check_done_task(member, 't020', my_fish.base_style, 1)
                if reward:
                    reward_all_almanac = reward
                    task_all_almanac = task
    # 蛋蛋龙回到背包，并按每小时10点增加成长值
    top_level = can_send_to_level(my_dispatch_pet, my_dispatch_pet_info.stage)
    pet_time = 3600
    if top_level &gt; 0 and top_level &lt; 3:
        pet_time = 3600
    elif top_level &gt; 2 and top_level &lt; 5:
        pet_time = 2 * 3600
    else:
        pet_time = 6 * 3600

    my_dispatch_pet.my_fish_tank_id = 0
    #my_dispatch_pet.exp = min(LEVEL_UP_EXP, int(pet_time/3600*10 + my_dispatch_pet.exp))
    my_dispatch_pet.last_dispatched = datetime.now()
    #体力消耗
    my_dispatch_pet.last_power_time = datetime.now()
    my_dispatch_pet.save()
    # 更新背包缓存
    my_fish_ids_in_bag = get_my_fish_ids_in_bag(member.id)
    if my_dispatch_pet_id not in my_fish_ids_in_bag:
        my_fish_ids_in_bag.append(my_dispatch_pet_id)
    update_my_fish_ids_in_bag(member.id, my_fish_ids_in_bag)
    # 删除派遣的蛋蛋龙模型
    my_dispatch_pet_info.delete()
    # 更新派遣列表缓存
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(member.id)
    if my_dispatch_pet_info.my_fish_id in my_dispatch_pet_ids:
        my_dispatch_pet_ids.remove(my_dispatch_pet_info.my_fish_id)
    update_my_dispatch_pet_ids(member.id, my_dispatch_pet_ids)

    level,remain_exp,next_level_exp = get_almanac_level_info(member.id)

    #do task
    task_list = ''
    if reward_almanac:
        rewards = reward_almanac
        task_list = update_my_normal_task(member.id, task_almanac)
    elif reward_dragon:
        rewards = reward_dragon
        task_list = update_my_normal_task(member.id, task_dragon)
    elif reward_all_almanac:
        rewards = reward_all_almanac
        task_list = update_my_normal_task(member.id, task_all_almanac)
    else:
        rewards, my_task = check_done_task(member,'t003','',1)
        if rewards:
            task_list = update_my_normal_task(member.id, my_task)

    result = {'level':level,
              'remain_exp':remain_exp,
              'next_level_exp':next_level_exp,
              'shells':member.shells,
              'pearls':member.pearls,
              'almanac_fish':almanac_fish,
              'rewards':rewards,
              'task_list':task_list,
              }
    return result


</t>
<t tx="newlife.20110223101524.1296">#购买派遣龙位
def buyAssistPositionAMF(request, skey, type):
    member = login_member(request, skey)

    level,remain_exp,next_level_exp = get_almanac_level_info(member.id)
    task_list = ''
    if type == 's':
        if member.shell_dispatch &gt;= 6:
            return {'error':'no more position can be open', 'rewards':'', 'task_list':''}
        if level &lt; BUY_SHELL_POSITION_EXP[member.shell_dispatch][0]:
            return {'error':'exp not enough', 'rewards':'', 'task_list':''}
        sell_shells = BUY_SHELL_POSITION_EXP[member.shell_dispatch][1]
        if member.shells &lt; sell_shells:
            return {'error':'shells not enough', 'rewards':'', 'task_list':''}
        member.shells -= sell_shells
        member.shell_dispatch += 1
        member.save()

        #do task
        rewards, my_task = check_done_task(member, 't014', '', 1)
        if my_task:
            task_list = update_my_normal_task(member.id, my_task)
    elif type == 'p':
        if member.pearl_dispatch &gt;= 6:
            return {'error':'no more position can be open', 'rewards':'', 'task_list':''}
        if level &lt; BUY_PEARL_POSITION_EXP[member.pearl_dispatch]:
            return {'error':'exp not enough', 'rewards':'', 'task_list':''}
        if member.pearls &lt; 2000:
            return {'error':'pearls not enough', 'rewards':'', 'task_list':''}
        member.pearls -= 2000
        member.pearl_dispatch += 1
        member.save()

        #do task
        rewards, my_task = check_done_task(member, 't014', '', 1)
        if rewards:
            task_list = update_my_normal_task(member.id, my_task)

    return {'shells':member.shells,
            'pearls':member.pearls,
            'rewards':rewards,
            'task_list':task_list,}

</t>
<t tx="newlife.20110223101524.1297">#取得快速收鱼道具数量
def getShortPhysicInfoAMF(request, skey, pet_id):
    member = login_member(request, skey)
    pet_id = int(pet_id)
    pet_info = get_my_dispatch_pet_info(member.id, pet_id)
    # 捕鱼状态不对
    if pet_info.status != 'c':
        return {'error':'status error', 'rewards':'', 'task_list':''}
    # 计算剩余时间
    rest_seconds = 0
    if pet_info.end_time is not None:
        rest_time = pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds

    if rest_seconds&lt;=0:
        return {'error':'already return', 'rewards':'', 'task_list':''}

    my_item = get_or_create_my_item(member.id, 'p2')
    need_item_count = math.ceil(float(rest_seconds)/(my_item.shorten_time*3600.0))
    shop_product = get_shop_product('p2')
    if not shop_product:
        return {'error': 'server data error(-10000)', 'rewards':'', 'task_list':''}

    task_list = ''
    rewards = ''
    return {'need_num':need_item_count,
            'total_num':my_item.total_num,
            'name':my_item.name,
            'price':shop_product.price,
            'sale_type':shop_product.sale_type,
            'task_list':task_list,
            'rewards':rewards,}

</t>
<t tx="newlife.20110223101524.1298">#使用快速收鱼道具
def shortPhysicAMF(request, skey, pet_id, useone=True):
    member = login_member(request, skey)

    pet_id = int(pet_id)
    pet_info = get_my_dispatch_pet_info(member.id, pet_id)
    # 捕鱼状态不对
    if pet_info.status != 'c':
        return {'error':'status error', 'rewards':'', 'task_list':''}
    # 此次捕鱼已经用过药丸
    #if pet_info.can_be_used_physic():
    #    return {'error':'already used'}
    my_item = get_or_create_my_item(member.id, 'p2')
    if not (my_item and pet_info):
        return {'error': 'data error(-10000)', 'rewards':'', 'task_list':''}
    # 道具类型错误
    if my_item.item_type != 'SST':
        return {'error':'data error(-10001)', 'rewards':'', 'task_list':''}

    # 计算剩余时间
    rest_seconds = 0
    if pet_info.end_time is not None:
        rest_time = pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds

    if rest_seconds&lt;=0:
        return {'error':'already return', 'rewards':'', 'task_list':''}

    need_item_count = 1
    if not useone:
        need_item_count = math.ceil(float(rest_seconds)/(my_item.shorten_time*3600.0))
    # 药丸不够
    if my_item.total_num &lt; need_item_count:
        return {'error':'not enough physic', 'rewards':'', 'task_list':''}
    # 药丸冷却中
    #if get_my_item_cooldown_precent(member.id, my_item) != 100:
    #    return {'error':'item is cooldown'}

    # 减道具
    my_item.total_num -= need_item_count
    my_item.last_used = datetime.now()
    my_item.save()

    pet_info = use_physic_for_pet(pet_info, my_item, need_item_count)
    # 计算剩余时间
    if pet_info.end_time is not None:
        rest_time = pet_info.end_time - datetime.now()
        rest_seconds = rest_time.days*24*3600 + rest_time.seconds
    else:
        rest_seconds = 0

    caught_fish_styles = pet_info.get_caught_fish_styles()
    fishes = get_fishes(caught_fish_styles)
    fish_list = [{'style':fish.style} for fish in fishes]

    #do task
    rewards, my_task = check_done_task(member, 't002', 'p2', 1)
    if rewards:
        task_list = update_my_normal_task(member.id, my_task)
    else:
        task_list = ''
    result = {'status':pet_info.status,
              'rest_time':rest_seconds,
              'is_stolen':pet_info.is_stolen,
              'is_protected':pet_info.is_protected,
              'dragon_list':fish_list,
              'task_list':task_list,
              'rewards':rewards,
              }

    return result
</t>
<t tx="newlife.20110223101524.1299">增加字段：
在PetTempInfo增加字段

class PetTempInfo(MultiDB):
    #member_id = models.IntegerField() # 用户id
    my_fish_id = models.IntegerField(default=0) #我的鱼ID，0--表示没有派遣鱼
    stage = models.IntegerField(default=0) # 所在场景
    status = models.CharField(max_length=1, default='c') # 状态
    caught_fish = models.CharField(max_length=20, default='') # 捉的鱼
    end_time = models.DateTimeField(blank=True, null=True) # 收获时间
    is_stolen = models.BooleanField(default=False) # 是否已被偷
    last_physic_used = models.DateTimeField(blank=True,null=True) #上一次收鱼药剂使用时间
    is_protected = models.BooleanField(default=False) # 是否被潜艇鱼保护器保护
    help_time = models.IntegerField(default=0)
    
    def update_cache(self):
        key = CACHE_KEY_MY_DISPATCH_PET_INFO % (self.member_id, self.my_fish_id)
        cache.set(key, self)
                
    def delete_cache(self):
        key = CACHE_KEY_MY_DISPATCH_PET_INFO % (self.member_id, self.my_fish_id)
        cache.delete(key)
        
    def save(self):
        super(PetTempInfo, self).save()
        self.update_cache()
        
    def delete(self):
        self.delete_cache()
        super(PetTempInfo, self).delete()
        
    def get_caught_fish_styles(self):
        if self.caught_fish:
            return self.caught_fish.split(',')
        else:
            return []
    
    def can_be_used_physic(self):
        if self.last_physic_used is None:
            return False
        else:
            return True
    
    class Meta:
        db_table = 'ppy_pettempinfo'
        </t>
<t tx="newlife.20110223101524.1300">#帮助一下我，这个是帮助的时候保存日志，然后更新那个帮助列表
def new_my_helper_info(member, helper, help_type, help_id=0):
    mhr = MyHelpedRecord(member_id=member.id, helper_member_id=helper.id, \
        helper_nickname=helper.nickname, help_type=help_type, help_id=help_id)
    mhr.save()
    
    #更新cache，这里加上谁帮助了我的信息，就是更新，然后就是判断有么有，
    count = 1
    cur_day = datetime.now().day#几号int    
    key = CACHE_MY_HELPED_MEMBERS % (member.id, cur_day)
    helpers = cache.get(key, None)
    if helpers:
        h = helpers.get(helper.id, None)
        if h:
            count = h[1]+1
            helpers[helper.id] = [helper.nickname, count]
            
        else:
            helpers[helper.id] = [helper.nickname, 1]
    else:
        helpers = {helper.id:[helper.nickname, 1]}
    
    cache.set(key, helpers, 172800)
    
    return count

缓存里保存的信息是：helpers,这是一个dict，key是帮助的人的id，value是二元list，[帮助者的昵称，帮助的次数]

#取帮助my的用户信息，
def get_my_helpers_info(member_id, is_today):
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
   说，这里完成的是啥，保存记录，就是谁帮助了我，帮助了多少次
    先看，如果缓存没有，伊保存的是，{helper.id:[nickname,1]}
    对应第一个面板
    

#key = CACHE_MY_HELPED_MEMBERS % (member.id, cur_day)
key = CACHE_HELP-TIME%(member.id,dispath_id)
考虑的问题，初始这个key，派遣的时候做的。
维护这个key，点击的时候做的，

写一个计算派遣时间的函数

参数有：









































    
    </t>
<t tx="newlife.20110225112453.1314">@language python
@tabwidth -4
@others
</t>
<t tx="newlife.20110225112453.1315"># -*- coding: utf-8 -*-

from apps.system.helper import *
from apps.members.cache import *
from apps.games.cache import *
from apps.members.helper import *


from apps.help.cache import *
from apps.help import *

</t>
<t tx="newlife.20110225112453.1316">#取得TA人对我的帮助日志
def getHelpLogAMF(request, skey, to_day):
    member = login_member(request, skey)    
    helpers = get_my_helpers_info(member.id, to_day)
    helper_list = []
    for key, value in helpers.items():
        helper_list.append({'sns_id':key, 'nick_name':value[0], 'times':value[1]})
    task_list=''
    rewards = ''
    return {'helper_list':helper_list,'task_list':task_list,'rewards':rewards,}


</t>
<t tx="newlife.20110225112453.1317">#取得TA的需要帮助列表信息
def getHelpItemListAMF(request, skey, host_id):
    member = login_member(request, skey)
    host_id = int(host_id)
    host = get_member(host_id)
    my_dispatch_pet_ids = get_my_dispatch_pet_ids(host.id)
    item_list = []
    for my_dispatch_pet_id in my_dispatch_pet_ids:
        help_type = 'G1'
        help_id = my_dispatch_pet_id
        dispatch_pet_info = get_my_dispatch_pet_info(host.id, my_dispatch_pet_id)
        helped_num = dispatch_pet_info.help_num
        sum_num = 5       
        item_list.append({'help_type':help_type,
                          'help_id':help_id,
                          'helped_num':helped_num,
                          'sum_num':sum_num}) 
    #其他类型的帮助依次写入item_list
    task_list=''
    rewards = ''
    return {'item_list':item_list,'task_list':task_list,'rewards':rewards,}

</t>
<t tx="newlife.20110225112453.1318">#帮助TA一下
#('G1', u'派遣'),
#('G2', u'痛扁'),
#('M1', u'战斗号角'),
#('P1', u'强力扫帚'),
#('T1', u'任务'),
def doHelpAMF(request, skey, host_id, help_type, dragon_id):
    member = login_member(request, skey)
    host_id = int(host_id)
    host = get_member(host_id)

    help_id = int(dragon_id)
    task_list = ''
    rewards = ''
    if help_type not in ('G1', 'G2', 'M1', 'P1', 'T1'):
        return {'error': -10001}

    if help_type=='G1':
        my_dispatch_pet = get_my_fish(host.id, dragon_id)
        dispatch_pet_info = get_my_dispatch_pet_info(host.id, dragon_id)
        #判断用户是否已经帮助过
        is_helped = MyHelpedRecord.objects.filter(member_id =host_id,
                                                  helper_member_id = member.id,
                                                  help_type = help_type,
                                                  help_id = dispatch_pet_info.id)
        
        #这里倒是可以再弄一个cache
        if is_helped:
            return {'error':'helped'}
        if dispatch_pet_info.help_num &lt; 5:
            #写日志
            help_log = new_my_helper_info(host,member,help_type,help_id=dispatch_pet_info.id)
            #算时间,
            top_level = can_send_to_level(my_dispatch_pet, dispatch_pet_info.stage)
            pet_time = 3600
            if top_level &gt; 0 and top_level &lt; 3:
                pet_time = 3600
            elif top_level &gt; 2 and top_level &lt; 5:
                pet_time = 2 * 3600
            else:
                pet_time = 6 * 3600
            remove_time = int(pet_time * 0.04)
            end_time = dispatch_pet_info.end_time - timedelta(0,remove_time)
            dispatch_pet_info.end_time = end_time
            #改帮助次数
            dispatch_pet_info.help_num = dispatch_pet_info.help_num+1
            dispatch_pet_info.save()
            print dispatch_pet_info.end_time
            item_count = {"helped_num":dispatch_pet_info.help_num,"sum_num":5}
            return {'item_count':item_count,'task_list':task_list,'rewards':rewards,}
        else:
            item_count = {"helped_num":dispatch_pet_info.help_num,"sum_num":5}
            return {'item_count':item_count,'task_list':task_list,'rewards':rewards,} 

    elif help_type=='G2':
        pass
    elif help_type=='M1':
        pass
    elif help_type=='P1':
        pass
    elif help_type=='T1':
        pass

    count = new_my_helper_info(member, host, help_type, help_id)

    return {'count':count}




</t>
<t tx="newlife.20110225112453.1319">CACHE_MY_HELPER_TYPE_MEMBERS = 'my_help_type_%s_%s_%s' #1%s is member_id, 2%s is help_type, 3%s is help_id






</t>
<t tx="newlife.20110228142419.1326">好东西

</t>
</tnodes>
</leo_file>
