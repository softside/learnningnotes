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
<v t="zhanglei.20101007173309.1365"><vh>@chapters</vh></v>
<v t="zhanglei.20101007173309.1364"><vh>preface</vh></v>
<v t="zhanglei.20101007173309.1366" a="E"><vh>前期准备</vh>
<v t="zhanglei.20101007192124.1248"><vh>列表显示</vh></v>
<v t="zhanglei.20101009103655.1259"><vh>url匹配</vh></v>
<v t="zhanglei.20101007192124.1247"><vh>评论</vh></v>
<v t="zhanglei.20101007192124.1249"><vh>分享</vh></v>
<v t="zhanglei.20101007192124.1250"><vh>标签选择</vh></v>
<v t="zhanglei.20101007192124.1251"><vh>反馈</vh></v>
<v t="zhanglei.20101008180349.1257"><vh>前台</vh></v>
<v t="zhanglei.20101009103655.1260"><vh>初始化数据</vh></v>
<v t="zhanglei.20101011103751.1263"><vh>关于migration</vh></v>
</v>
<v t="zhanglei.20101011103751.1264" a="E"><vh>项目实施</vh>
<v t="zhanglei.20101012112959.1274"><vh>记录</vh></v>
<v t="zhanglei.20101011103751.1266"><vh>urls.py</vh></v>
<v t="zhanglei.20101011103751.1265" a="E"><vh>views.py</vh>
<v t="zhanglei.20101011103751.1267"><vh>1011view.py</vh></v>
</v>
<v t="newlife.20101013195522.1283" a="E"><vh>TODO 1015</vh>
<v t="newlife.20101013195522.1284"><vh>列表页</vh></v>
<v t="newlife.20101013195522.1285"><vh>标签页</vh></v>
</v>
<v t="newlife.20101017122831.1281"><vh>migration</vh></v>
</v>
<v t="newlife.20101021104626.1283" a="E"><vh>重构</vh>
<v t="newlife.20101021104626.1284"><vh>源码</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20101013195522.1283">1，列表页： 分页view，

            </t>
<t tx="newlife.20101013195522.1284">1，分页//这个还是重点，。。ms有点难阿
  简单说，根据当前页数，生成类似5，6，7，8，9这样的数列。    
    接受的参数有2个，当前的page，总的页数page_，num_pages,
def generate_pagelist:
    if num_pages&lt;10;
        return xrange[num_pages]
    if page &lt; num_pages:
        return [ i for in xrange[1,num_pages+1]][:10]
    else:
        start_page = page-5 
        if start_page&lt;1:
            start_page=1
        end_page = page+5
        if end_page &gt; num_pages:
            end_page=num_pages    
        return [xrange(start_page,end_page)
TODO 目前的问题，当page&lt;5的时候，显示的页码少于10条
               num_pages-page&lt;5的时候,显示的页码小于10条 
一个函数只处理一个问题，
显示...{{end_page}}的时候用 end_page in generate_pagelist(page,num_pages)来判断。
最后的问题是,如何组建分页的url，最恶心的办法，取阿
“/ere/ere/rr/45/” 

'/'.join(x.split('/',2)[0])

ss.rsplit('/', ss[-1]=='/' and 2 or 1)[0]

and 和 or的使用。。

ss[-1]=='/' and 2 or 1
这个最后返回的不是2就是1

2，显示方式切换。//简单。</t>
<t tx="newlife.20101013195522.1285">有2个tag，
底部tag，和右侧tag，
底部是大分类下的随机游戏


右侧如图所示；
“/ere/ere/rr/45/” 

'/'.join(x.split('/',2)[0])

ss.rsplit('/', ss[-1]=='/' and 2 or 1)[0]

and 和 or的使用。。

ss[-1]=='/' and 2 or 1
这个最后返回的不是2就是1
</t>
<t tx="newlife.20101017122831.1281">增加num_installed这个字段，到game表, 写相应的统计脚本。
</t>
<t tx="newlife.20101021104626.1283"></t>
<t tx="newlife.20101021104626.1284">#减少不必要的查询；
def list_by_tags(request, **kwargs):
    tags_ids_show = kwargs.get('tagids')#前台输出；
    tag_ids = kwargs.get('tagids').split('-')
    tag_dict = _get_tagdict(tag_ids, id=True)
    show_dict = _get_tagdict(tag_ids, id=False)

    category_tag = show_dict.get('gamekind')
    random_game = get_random_game(category_tag, 4)

    tags = Tag.objects.filter(slug__in = tag_ids)
    tag_names = [tag.name for tag in tags]
    page = int(kwargs.get('page', 1))
    if not kwargs.get('page'):
        url_without_page = request.path
    else:
        _path = request.path
        url_without_page = _path.rsplit('/',_path[-1]=='/' and 2 or 1)[0]
        url_without_page = url_without_page+"/"
    order = kwargs.get('order', 'new')
    game_list = TaggedItem.objects.get_by_model(Game, tag_names)
    game_list = qs_order(game_list, order)
    pagin_list =Paginator(game_list, 30)
    obj_list = pagin_list.page(int(page))
    num_pages = pagin_list.num_pages

    num_page_list = generate_pagelist(page, num_pages)
    current_page =  Page(game_list, 30, pagin_list)
    last_page = num_pages in num_page_list
    order_to_show = [
        ("new", u"最新发布"),
        ("hot", u"最多人玩"),
        ("rating", u"最高评分"),
        ("share", u"最多分享"),
        ("comment", u"最多评论"),
        ("favorites", u"最多收藏"),
    ]


    tag_cap = Tag.objects.get_cap().order_by('id')
    for one in tag_cap:
        cap_dict = tag_dict.copy()
        cap_dict['caption'] = one.slug
        if one.name == '_':
            one.name = u'其他'
        one.url = '-'.join(map(str, cap_dict.values()))

    tag_lang = Tag.objects.get_lang().order_by('id')
    for one in tag_lang:
        lang_dict = tag_dict.copy()
        lang_dict['lang'] = one.slug
        one.url = '-'.join(map(str, lang_dict.values()))

    tag_mood = Tag.objects.get_mood().order_by('id')
    for one in tag_mood:
        mood_dict = tag_dict.copy()
        mood_dict['lang'] = one.slug
        one.url = '-'.join(map(str, mood_dict.values()))

    mood_all = tag_dict.copy()
    if mood_all.get('mood',None):
        del mood_all['mood']
    mood_all = '-'.join(map(str, mood_all.values()))

    cap_all = tag_dict.copy()
    if cap_all.get('caption',None):
        del cap_all['caption']
    cap_all = '-'.join(map(str, cap_all.values()))

    lang_all = tag_dict.copy()
    if lang_all.get('lang',None):
        del lang_all['lang']
    lang_all = '-'.join(map(str, lang_all.values()))

    list_style = request.GET.get('list', 'w')
    style = '?list=%s'%list_style
    if list_style == 'w':
        return render_to_response('game/list_w.html',
                                          RequestContext(request, locals()))
    else:
        return render_to_response('game/list_p.html',
                                                  RequestContext(request, locals()))
</t>
<t tx="zhanglei.20101007173309.1364">这个东西就是扯阿，瞎tm折腾。太阳！！
</t>
<t tx="zhanglei.20101007173309.1365"></t>
<t tx="zhanglei.20101007173309.1366"></t>
<t tx="zhanglei.20101007192124.1247">关于评论：
首先，需求要求作成类似开心，要求对评论进行分级（一级）。
其实很简单，就是对游戏的评论model加一个foreignkey

parent=models.ForeignKey('self',null=True,blank=True,verbose_name="回复哪个评论")</t>
<t tx="zhanglei.20101007192124.1248">需要考虑的问题：
1，最多人玩，根据game的num_played字段排序；
2，最高评分，根据game的point（具体名称待定）排序,grade；
3，最多分享，number_shared
4，最多评论，number_comment
5，最多收藏，根据game的installerd字段count出来的,写入game表，生成字段。

def qs_order(query_set,order):
    order_to_field = {
        "new":"id",
        "hot":"num_played",
        "share":"num_shared",
        "favorites":"num_installed",
        "rating":"grade"
        "comment":"num_comment",
    }
    order = order_to_field.get(order,"id")
    return query_set.order_by(order)



关于多个tag选取的实现；
我的思路，单个选取，求交集；

    def get_by_model(self, queryset_or_model, tags):
        """
        Create a ``QuerySet`` containing instances of the specified
        model associated with a given tag or list of tags.
        """
        tags = get_tag_list(tags)
        tag_count = len(tags)
        if tag_count == 0:
            # No existing tags were given
            queryset, model = get_queryset_and_model(queryset_or_model)
            return model._default_manager.none()
        elif tag_count == 1:
            # Optimisation for single tag - fall through to the simpler
            # query below.
            tag = tags[0]
        else:
            return self.get_intersection_by_model(queryset_or_model, tags)
        #以上处理没有或者只有一个tag的情况。
        queryset, model = get_queryset_and_model(queryset_or_model)
        content_type = ContentType.objects.get_for_model(model)
        opts = self.model._meta
        tagged_item_table = qn(opts.db_table)
        return queryset.extra(
            tables=[opts.db_table],
            where=[
                '%s.content_type_id = %%s' % tagged_item_table,
                '%s.tag_id = %%s' % tagged_item_table,
                '%s.%s = %s.object_id' % (qn(model._meta.db_table),
                                          qn(model._meta.pk.column),
                                          tagged_item_table)
            ],
            params=[content_type.pk, tag.pk],
        )</t>
<t tx="zhanglei.20101007192124.1249">关于分享的实现：

就是给用户发信，记录发信的动作，
数据库字段：
   game(游戏id)
   user(用户id)
   date(分享时间)</t>
<t tx="zhanglei.20101007192124.1250">选择标签：
根据url指定,

这里还有一个问题，就是tag去重，作301转发；
如果只有4个的话，去重的意义就不是很大了，，

这个需要预先保存上一个tag，

def game_select(request,)
    
    tags = parseint(tags)
    TaggedItem.objects.get_by_model(Game, '动作 开心')
    #还要写一个对应的处理id的方法来用，这个方法不合适。
     

首先要解决的一个是：
对应首页的一堆tag，
和列表搜索页的tag
    </t>
<t tx="zhanglei.20101007192124.1251">是说在列表页面：
最多只出现3个tag的选择？？
即便从/tag/[0-9]+/也只有4个tag可选阿。
最后还有一个参数。
看来就是这个意思了。

更改显示方式的效果实现；</t>
<t tx="zhanglei.20101008180349.1257">line 157  &lt;ul class="im-list inner"&gt;  显示图片列表


line 157  &lt;ul class="l-list inner"&gt;  显示图文列表


http://unite.codante.org/game.huanju8.com/index.php?load=archive-image</t>
<t tx="zhanglei.20101009103655.1259">我涉及到的url：
http://game.huanju8.com/tag/{tag_name}/

http://game.huanju8.com/tag/1-2-3-4-5/


http://game.huanju8.com/tag/1-2-3-4-5/{suffix}/
        suffix = [ new, hot, share, favorites, rating, comment ] 
后面还有一个分页的，或许有变化。        

选一个最长的：

http://game.huanju8.com/tag/1-2-3-4-5/hot/

urlpatterns = patterns('',
    #url(r'^(\d+)(?:-(\d+))*$', list_with_tags, name='play_list_with_tags'),
    url(r'^(\d+)/$', list_with_tags, name='play_list_with_1tag'),
    url(r'^(\d+)-(\d+)/$', list_with_tags, name='play_list_with_2tag'),
    url(r'^(\d+)-(\d+)-(\d+)/$', list_with_tags, name='play_list_with_3tag'),
    url(r'^(\d+)-(\d+)-(\d+)-(\d+)/（？order）/$', list_with_tags, name='play_list_with_4tag'),
)

如果使用注释的部分：    
#url(r'^(\d+)(?:-(\d+))*$', list_with_tags, name='play_list_with_tags'),
可直接解析请求的路径：

tags = (request.path.split("/")[2]).split("-")
返回是tags的id的list，还要转为int型，然后查询名称
然后用那个方法。

    url(r'^tag/(?P&lt;id&gt;\d+)/$', list_with_tags, name='game_by_tag'),
    url(r'^tag/(?P&lt;id&gt;\d+)/(?P&lt;order&gt;\w+)/$', list_with_tags, name='play_list_with_1tag'),
    url(r'^tag/(?P&lt;id&gt;\d+)/(?P&lt;order&gt;\w+)/(?P&lt;pageno&gt;\d+)/$', list_with_tags, name='play_list_with_1tag'),

    url(r'^(?P&lt;tagids&gt;[\d-]+)/$', list_with_tags, name='play_list_with_1tag'),
    url(r'^(?P&lt;tagids&gt;[\d-]+)/(?P&lt;order&gt;\w+)/$', list_with_tags, name='play_list_with_1tag'),
    url(r'^(?P&lt;tagids&gt;[\d-]+)/(?P&lt;order&gt;\w+)/(?P&lt;pageno&gt;\d+)/$', list_with_tags, name='play_list_with_1tag'),
</t>
<t tx="zhanglei.20101009103655.1260">#! /usr/bin/env python
#coding=utf-8
from gametag.models import TagCategory, Tag
import string

category_tag =[(1, u"益智"),
(2, u"动作"),
(3, u"射击"),
(4, u"冒险"),
(5, u"搞笑"),
(6, u"体育"),
(7, u"策略"),
(8, u"棋牌"),
(9, u"敏捷"),
(10, u"休闲"),
(11, u"装扮"),
(12, u"儿童"),
(13, u"经营"),
]

cap_charctor = string.uppercase

mood_tag =[ u"开心", u"寂寞", u"郁闷", u"无聊", u"愤怒", u"思念",u"疲惫"]

language_tag =[u"简体中文",u"繁体中文",u"英文",u"韩文",u"日文"]
category_data = ["category","mood","cap","language"]


def create_category_tag():
    category = TagCategory.objects.get(name=u"游戏大类")
    for i in category_tag:
        _,tag = Tag.objects.get_or_create(name=i[1],category=category)
    print "cap_tag is create ok"


def create_mood_tag():
    category = TagCategory.objects.get(name=u"游戏心情")
    for i in mood_tag:
        _,tag = Tag.objects.get_or_create(name=i,category=category)
    print "mood_tag is create ok"

def create_language_tag():
    category = TagCategory.objects.get(name=u"游戏语言")
    for i in language_tag:
        _,tag = Tag.objects.get_or_create(name=i,category=category)
    print "language_tag is create ok"

def create_cap_tag():
    category = TagCategory.objects.get(name=u"拼音首字母")
    for i in cap_charctor:
        _,tag = Tag.objects.get_or_create(name=i,category=category)
    print "cap_tag is create ok"

if __name__ == '__main__':
    #source setup-env.sh
    #manage loaddata gametag/fixtures/tagcategory_init.json
    create_category_tag()
    create_mood_tag()
    create_language_tag()
    create_cap_tag()
    
    
#################################################
初始化实际数据
用于生成结果
from game.models import Game
from gametag.models import Tag
from random import randint

def create_taggeditem():
    for i in xrange(10000):
        game = Game.objects.get(id = randint(1,len(Game.objects.all())))
        tag = Tag.objects.get(id=randint(1,len(Tag.objects.all())))
        Tag.objects.add_tag(game,tag)




#NOTE:这个ipython似乎对数据库有缓存。。






















    </t>
<t tx="zhanglei.20101011103751.1263">新项目，自己生成migration文件，但是不提交，merge到master后生成单一的migration文件。</t>
<t tx="zhanglei.20101011103751.1264"></t>
<t tx="zhanglei.20101011103751.1265">def qs_order(query_set,order):

    order_to_field = {
        "new":"id",
        "hot":"num_played",
        "share":"num_shared",
        "favorites":"num_installed",
        "rating":"grade",
        "comment":"num_comment",
    }
    order = order_to_field.get(order,"id")
    return query_set.order_by(order)


def list_by_tag(request, name_or_id="",order="new"):
    """
    匹配的url
    url(r'^tag/(?P&lt;name_or_id&gt;\w+)/$', list_with_tags, name='game_by_tag'),

    """
    print name_or_id
    if name_or_id.isdigit():
        tag = Tag.objects.get(id=name_or_id)
    else:
        tag = Tag.objects.get(name=name_or_id)
    if not tag:
        return Http404
    else:
        game_list = TaggedItem.objects.get_by_model(Game, tag)
        game_list = qs_order(game_list,order)
        last_tags = tag.id#same name with list_by_tags function ,to create the url in the middle of list_w.html
    
        tag_kind = Tag.objects.get_kind()
        tag_cap = Tag.objects.get_cap().order_by('id')
        tag_lang = Tag.objects.get_lang().order_by('-id')
        tag_mood = Tag.objects.get_mood().order_by('-id')
        return render_to_response('game/list_w.html',
                                          RequestContext(request, locals()))

def list_by_tags(request,**args):
    tags = (request.path.split("/")[2]).split("-")
    tags = [tag.strip() for tag in tags ]
    tags = set(tags)
    tags = [tag for tag in tags if tag is not False]
    last_tags = "-".join(map(str,tags))
    tag_ids = [int(tag) for tag in tags]

    tags = Tag.objects.filter(id__in = tag_ids)
    tag_names = [tag.name for tag in tags]

    game_list = TaggedItem.objects.get_by_model(Game,tag_names).order_by("id")
    order = args.get('order','')
    if order:
        game_list = qs_order(game_list,order)
    tag_kind = Tag.objects.get_kind()
    tag_cap = Tag.objects.get_cap().order_by('-id')
    tag_lang = Tag.objects.get_lang().order_by('-id')
    tag_mood = Tag.objects.get_mood().order_by('-id')
    return render_to_response('game/list_w.html',
                                          RequestContext(request, locals()))


    
    
    
        </t>
<t tx="zhanglei.20101011103751.1266">    url(r'^tag/(?P&lt;id&gt;\w+)/$', list_with_tags, name='game_by_tag'),
    url(r'^tag/(?P&lt;id&gt;\w+)/(?P&lt;order&gt;\w+)/$', list_with_tags, name='play_list_with_1tag'),
    url(r'^tag/(?P&lt;id&gt;\w+)/(?P&lt;order&gt;\w+)/(?P&lt;pageno&gt;\d+)/$', list_with_tags, name='play_list_with_1tag'),

    url(r'^(?P&lt;tagids&gt;[\d-]+)/$', list_with_tags, name='play_list_with_1tag'),
    url(r'^(?P&lt;tagids&gt;[\d-]+)/(?P&lt;order&gt;\w+)/$', list_with_tags, name='play_list_with_1tag'),
    url(r'^(?P&lt;tagids&gt;[\d-]+)/(?P&lt;order&gt;\w+)/(?P&lt;pageno&gt;\d+)/$', list_with_tags, name='play_list_with_1tag'),
######################################################
    url(r'^tag/(?P&lt;name_or_id&gt;\w+)/$', list_by_tag, name='game_by_tag'),
    url(r'^tag/(?P&lt;name_or_id&gt;\w+)/(?P&lt;page&gt;\d+)/$', list_by_tag, name='game_by_tag_page'),

    url(r'^tag/(?P&lt;name_or_id&gt;\w+)/(?P&lt;order&gt;\w+)/$', list_by_tag, name='list_with_tag'),
    url(r'^tag/(?P&lt;name_or_id&gt;\w+)/(?P&lt;order&gt;\w+)/(?P&lt;page&gt;)\d+/$', list_by_tag, name='list_with_tag_page'),

    url(r'^[\d-]+/$', list_by_tags, name='game_by_tags'),
    url(r'^[\d-]+/(?P&lt;page&gt;)\d+/$', list_by_tags, name='game_by_tags_page'),

    url(r'^[\d-]+/(?P&lt;order&gt;\w+)/$', list_by_tags, name='list_with_tags'),
    url(r'^[\d-]+/(?P&lt;order&gt;\w+)/(?P&lt;page&gt;)\d+/$', list_by_tags, name='list_with_tags_page'),</t>
<t tx="zhanglei.20101011103751.1267">def qs_order(query_set,order):

    order_to_field = {
        "new":"id",
        "hot":"num_played",
        "share":"num_shared",
        "favorites":"num_installed",
        "rating":"grade",
        "comment":"num_comment",
    }
    order = order_to_field.get(order,"id")
    return query_set.order_by(order)


def list_by_tag(request, name_or_id="",order="new"):
    """
    匹配的url
    url(r'^tag/(?P&lt;name_or_id&gt;\w+)/$', list_with_tags, name='game_by_tag'),

    """
    print name_or_id
    if name_or_id.isdigit():
        tag = Tag.objects.get(id=name_or_id)
    else:
        tag = Tag.objects.get(name=name_or_id)
    if not tag:
        return Http404
    else:
        game_list = TaggedItem.objects.get_by_model(Game, tag)
        game_list = qs_order(game_list,order)
        print game_list
        tag_kind = Tag.objects.get_kind()
        tag_cap = Tag.objects.get_cap()
        tag_language = Tag.objects.get_lang()
        tag_mood = Tag.objects.get_mood()
        return render_to_response('game/list_w.html',
                                          RequestContext(request, locals()))

def list_by_tags(request,**args):
    tags = (request.path.split("/")[2]).split("-")
    tags = [tag.strip() for tag in tags ]
    tags = set(tags)
    tags = [tag for tag in tags if tag is not False]
    tag_ids = [int(tag) for tag in tags]
    tags = Tag.objects.filter(id__in = tags)
    tag_names = [tag.name for tag in tags]

    game_list = TaggedItem.objects.get_by_model(Game,tag_names)
    #game_list = qs_order(game_list,order)
    print game_list
    tag_kind = Tag.objects.get_kind()
    tag_cap = Tag.objects.get_cap()
    tag_language = Tag.objects.get_lang()
    tag_mood = Tag.objects.get_mood()
    return render_to_response('game/list_w.html',
                                          RequestContext(request, locals()))
</t>
<t tx="zhanglei.20101012112959.1274">考虑下做一个项目的时间：
激情是有限的，要在一个有激情的时间内迅速做完。
最多是一周。。

keyword = 'sdfsdf'
where_clause = Q(name__icontains=keyword) | Q(desc__icontains=keyword) | Q(tags__icontains=keyword)
games = Game.objects.filter(wherr_clause).distinct()
</t>
</tnodes>
</leo_file>
