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
<v t="newlife.20110323151501.1267" a="E"><vh>交易系统</vh>
<v t="newlife.20110323151501.1268"><vh>需求分析</vh></v>
<v t="newlife.20110323151501.1269"><vh>现有系统</vh></v>
<v t="newlife.20110323151501.1270" a="E"><vh>具体实现</vh>
<v t="newlife.20110325111629.1276"><vh>买龙__AMF</vh></v>
<v t="newlife.20110325111629.1277"><vh>卖龙__AMF</vh></v>
<v t="newlife.20110325111629.1278"><vh></vh></v>
</v>
<v t="newlife.20110323151501.1271"><vh>scipt</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110323151501.1267"></t>
<t tx="newlife.20110323151501.1268">对象：求购的对象，

增删查，

最多一个人有10个求购，
交易，次数限制，每天20次，这个要单独建表限制
        

告诉朋友们。
        
</t>
<t tx="newlife.20110323151501.1269">class WantToBuyRecord(MultiDB):
    #member_id = models.IntegerField() # 用户id
    to_member_id = models.IntegerField()
    style = models.CharField(max_length=20) #求购鱼的 style
    price = models.IntegerField(default=0) #出价
    create_time = models.DateTimeField(auto_now_add=True)

    def save(self):
        super(WantToBuyRecord, self).save()

    def delete(self):
        super(WantToBuyRecord, self).delete()

    class Meta:
        db_table = 'ppy_wanttobublog'
        </t>
<t tx="newlife.20110323151501.1270">新增求购：
涉及到的缓存：更新用户缓存，就是用户有的求购，之所以不用fish_style是因为还有价格这个因素，是每次变化的。


进行交易：
涉及的缓存，更新用户交易数目缓存（就是不小于10次的那个限制）。删除

今天要做的2件事，交易次数限制，然后是买卖的具体实现

def doBuyAMF(request,skey,host_id,sale_id):
    #买谁的，买什么，
    member = login_member(request, skey)
    member.level &gt;= 11
    sale_id = int(sale_id)
    
    #交钱
    member.shells -= sale.price
    member.save()
    seller.shells += sale.price
    seller.save()
    #给龙，这个给龙咋实现？？
    卖家删除
    买家增加
    #删除host_id的want_to_sell实例,更新小卖部的缓存.
    return {'status':status}
    

def doSellAMF(request,skey,host_id,buy_id):
    #删除host_id的want_to_buy实例
    
    
</t>
<t tx="newlife.20110323151501.1271">from apps.games.helper import *

stage= 1001
level= 1 2 3
fishes={}
old_fish=0
max=0
_max=1
fish_id=0
for i in range(0,10000):
    f=refresh_a_fish(stage,level)
    if f.id==old_fish:
        _max+=1
    else:
        if _max &gt; max:
            max=_max
            fish_id=f.id
        _max=1  
    if fishes.has_key(f.name):
        fishes[f.name]+=1
    else:
        fishes[f.name]=1
    old_fish=f.id

ft=sorted(fishes.items(), key=lambda fishes:fishes[1])
for name, value in ft:
   print "%s: %s" %(name.encode('utf8'), value)</t>
<t tx="newlife.20110325111629.1276">#　花钱买龙
def doBuyAMF(request, skey, host_id, want2sale_id, my_dragon_id):
    member = login_member(request, skey)

    my_dragon_id = int(my_dragon_id)
    want2sale_id = int(want2sale_id)
    host = get_member(int(host_id))
    m_trade_times = get_today_trade_times(member.id)
    
    if m_trade_times &gt;= 20: # 获得龙者交易到达上限
        return {'error':'member trade times limited', 'task_list':'', 'rewards':''}
    h_trade_times = get_today_trade_times(host.id)
    if h_trade_times &gt;= 20: # 卖出者交易到达上限
        return {'error':'host trade times limited', 'task_list':'', 'rewards':''}
    want2sale = get_my_want2sale(host.id, want2sale_id)
    if want2sale is None:
        return {'error':'not exist', 'task_list':'', 'rewards':''}
    my_dragon = get_my_fish(host.id, my_dragon_id)
    if not my_dragon:
        return {'error':'not exist',task_list:'','rewards':''}


    trade_shells = int(want2sale.price *1.05)# 5%的税
    if member.shells &lt; trade_shells:
        return {'error':'shell limited', 'task_list':'', 'rewards':''}
    # 删除龙，加贝壳，更新缓存
    
    
    #买家流程,
    #付钱
    m_before_shells = member.shells    
    member.shells -= want2buy.price
    member.save()
    m_after_shells = member.shells
    #给龙
    new_my_temp_bag_info(member.id, host.id, BUY_BILLS_GIFTS_ID, my_dragon.style, my_dragon.name,
                        DEFAULT_GIFTS_EXPIRE_DICT[BUY_BILLS_GIFTS_ID], 1, True)
    
    #卖家流程 
    #收钱,这个钱要放到礼物包里，。。
    h_before_shells = host.shells
    host.shells += trade_shells
    host.save()
    h_after_shells = host.shells
    #去龙
    my_dragon = calculate_my_fishes_in_bag([my_dragon])[0]
    my_dragon.delete()
    
    
    want2sale.delete()
    want2sale_ids = get_my_want2sale_ids(member.id)
    if want2sale_id in want2sale_ids:
        want2sale_ids.remove(want2sale_id)
        update_my_want2sale_ids(member.id, want2sale_ids)
    # 增加交易次数
    add_today_trade_times(host.id)
    add_today_trade_times(member.id)
    # 增加交易记录
    add_want2save_log(member.id, host.id, h_before_shells, h_after_shells, m_before_shells, m_after_shells, my_dragon.style, want2buy.price)
    return {'m_shells':member.shells, 'h_shells':member.shells, 'task_list':'', 'rewards':''}
</t>
<t tx="newlife.20110325111629.1277">#就是卖龙
def tradeWantToBuyAMF(request, skey, host_id, want2buy_id, my_dragon_id):
    member = login_member(request, skey)

    my_dragon_id = int(my_dragon_id)
    want2buy_id = int(want2buy_id)
    host = get_member(int(host_id))
    m_trade_times = get_today_trade_times(member.id)
    if m_trade_times &gt;= 20: # 卖出者交易到达上限
        return {'error':'owner trade times limited', 'task_list':'', 'rewards':''}
    h_trade_times = get_today_trade_times(host.id)
    if h_trade_times &gt;= 20: # 获得龙者交易到达上限
        return {'error':'host trade times limited', 'task_list':'', 'rewards':''}
    want2buy = get_my_want2buy(host.id, want2buy_id)
    if want2buy is None:
        return {'error':'not exist', 'task_list':'', 'rewards':''}

    my_dragon = get_my_fish(member.id, my_dragon_id)
    if my_dragon.style != want2buy.style: # 卖出的龙和求购的龙style不匹配
        return {'error':'style not match', 'task_list':'', 'rewards':''}
    if my_dragon.my_fish_tank_id != 0: # 龙不在背包中
        return {'error':'not in bag', 'task_list':'', 'rewards':''}
    trade_shells = int(want2buy.price *1.05)# 5%的税
    if host.shells &lt; trade_shells:
        return {'error':'shell limited', 'task_list':'', 'rewards':''}
    #卖家流程
    #删除龙，加贝壳，更新缓存
    m_before_shells = member.shells
    member.shells += want2buy.price
    member.save()
    m_after_shells = member.shells
    #去龙
    my_dragon = calculate_my_fishes_in_bag([my_dragon])[0]
    my_dragon.delete()
    
    my_fish_ids_in_bag = get_my_fish_ids_in_bag(member.id)
    if my_dragon_id in my_fish_ids_in_bag:
        my_fish_ids_in_bag.remove(my_dragon_id)
        update_my_fish_ids_in_bag(member.id, my_fish_ids_in_bag)
    
    # 龙放入礼物包，减贝壳，删除求购单，更新缓存
    #买家流程
    h_before_shells = host.shells
    host.shells -= trade_shells
    host.save()
    h_after_shells = host.shells
    new_my_temp_bag_info(host.id, member.id, BUY_BILLS_GIFTS_ID, my_dragon.style, my_dragon.name,
                        DEFAULT_GIFTS_EXPIRE_DICT[BUY_BILLS_GIFTS_ID], 1, True)
    
    want2buy.delete()
    want2buy_ids = get_my_want2buy_ids(member.id)
    if want2buy_id in want2buy_ids:
        want2buy_ids.remove(want2buy_id)
        update_my_want2buy_ids(member.id, want2buy_ids)
    # 增加交易次数
    add_today_trade_times(host.id)
    add_today_trade_times(member.id)
    # 增加交易记录
    add_want2buy_log(host.id, member.id, h_before_shells, h_after_shells, m_before_shells, m_after_shells, my_dragon.style, want2buy.price)
    return {'m_shells':member.shells, 'h_shells':member.shells, 'task_list':'', 'rewards':''}
</t>
<t tx="newlife.20110325111629.1278">level,remain_exp,next_level_exp = get_almanac_level_info(member.id)
if level &lt; 11:
    return {'error':'level not match', 'rewards':'', 'task_list':''}
    


这个钱要放礼物包里。。</t>
</tnodes>
</leo_file>
