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
<v t="zhanglei.20100902183546.1241"><vh>@chapters</vh></v>
<v t="zhanglei.20100830103303.1243" a="E"><vh>tagging</vh>
<v t="zhanglei.20100904114554.1242" a="E"><vh>tagging/fields.py</vh>
<v t="zhanglei.20100904114554.1243"><vh>fields declarations</vh></v>
<v t="zhanglei.20100904114554.1244" a="E"><vh>class TagField</vh>
<v t="zhanglei.20100904114554.1245"><vh>__init__</vh></v>
<v t="zhanglei.20100904114554.1246"><vh>contribute_to_class</vh></v>
<v t="zhanglei.20100904114554.1247"><vh>__get__</vh></v>
<v t="zhanglei.20100904114554.1248"><vh>__set__</vh></v>
<v t="zhanglei.20100904114554.1249"><vh>_save</vh></v>
<v t="zhanglei.20100904114554.1250"><vh>_update</vh></v>
<v t="zhanglei.20100904114554.1251"><vh>__delete__</vh></v>
<v t="zhanglei.20100904114554.1252"><vh>_get_instance_tag_cache</vh></v>
<v t="zhanglei.20100904114554.1253"><vh>_set_instance_tag_cache</vh></v>
<v t="zhanglei.20100904114554.1254"><vh>_update_instance_tag_cache</vh></v>
<v t="zhanglei.20100904114554.1255"><vh>get_internal_type</vh></v>
<v t="zhanglei.20100904114554.1256"><vh>formfield</vh></v>
</v>
</v>
<v t="zhanglei.20100905105221.1297" a="E"><vh>tagging/models.py</vh>
<v t="zhanglei.20100905105221.1298"><vh>models declarations</vh></v>
<v t="zhanglei.20100905105221.1299" a="E"><vh>class TagManager</vh>
<v t="zhanglei.20100905105221.1300"><vh>update_tags</vh></v>
<v t="zhanglei.20100905105221.1301"><vh>add_tag</vh></v>
<v t="zhanglei.20100905105221.1302"><vh>add_tags</vh></v>
<v t="zhanglei.20100905105221.1303"><vh>get_for_object</vh></v>
<v t="zhanglei.20100905105221.1304"><vh>_get_usage</vh></v>
<v t="zhanglei.20100905105221.1305"><vh>usage_for_model</vh></v>
<v t="zhanglei.20100905105221.1306"><vh>usage_for_queryset</vh></v>
<v t="zhanglei.20100905105221.1307"><vh>related_for_model</vh></v>
<v t="zhanglei.20100905105221.1308"><vh>cloud_for_model</vh></v>
</v>
<v t="zhanglei.20100905105221.1309"><vh>class TaggedItemManager</vh>
<v t="zhanglei.20100905105221.1310"><vh>get_by_model</vh></v>
<v t="zhanglei.20100905105221.1311"><vh>get_intersection_by_model</vh></v>
<v t="zhanglei.20100905105221.1312"><vh>get_union_by_model</vh></v>
<v t="zhanglei.20100905105221.1313"><vh>get_related</vh></v>
</v>
<v t="zhanglei.20100905105221.1314"><vh>class Tag</vh>
<v t="zhanglei.20100905105221.1315"><vh>class Meta</vh></v>
<v t="zhanglei.20100905105221.1316"><vh>__unicode__</vh></v>
</v>
<v t="zhanglei.20100905105221.1317"><vh>class TaggedItem</vh>
<v t="zhanglei.20100905105221.1318"><vh>class Meta</vh></v>
<v t="zhanglei.20100905105221.1319"><vh>__unicode__</vh></v>
</v>
</v>
<v t="zhanglei.20100904114554.1272" a="E"><vh>tagging/utils.py</vh>
<v t="zhanglei.20100904114554.1273"><vh>utils declarations</vh></v>
<v t="zhanglei.20100904114554.1274"><vh>parse_tag_input</vh></v>
<v t="zhanglei.20100904114554.1275"><vh>split_strip</vh></v>
<v t="zhanglei.20100904114554.1276"><vh>edit_string_for_tags</vh></v>
<v t="zhanglei.20100904114554.1277"><vh>get_queryset_and_model</vh></v>
<v t="zhanglei.20100904114554.1278"><vh>get_tag_list</vh></v>
<v t="zhanglei.20100904114554.1279"><vh>get_tag</vh></v>
<v t="zhanglei.20100904114554.1280"><vh>_calculate_thresholds</vh></v>
<v t="zhanglei.20100904114554.1281"><vh>_calculate_tag_weight</vh></v>
<v t="zhanglei.20100904114554.1282"><vh>calculate_cloud</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="zhanglei.20100830103303.1243"></t>
<t tx="zhanglei.20100902183546.1241"></t>
<t tx="zhanglei.20100904114554.1242">@language python
@tabwidth -4
@others
@ignore
</t>
<t tx="zhanglei.20100904114554.1243">"""
A custom Model Field for tagging.
"""
from django.db.models import signals
from django.db.models.fields import CharField
from django.utils.translation import ugettext_lazy as _

from tagging import settings
from tagging.models import Tag
from tagging.utils import edit_string_for_tags

</t>
<t tx="zhanglei.20100904114554.1244">class TagField(CharField):
    """
    A "special" character field that actually works as a relationship to tags
    "under the hood". This exposes a space-separated string of tags, but does
    the splitting/reordering/etc. under the hood.
    """
    @others
</t>
<t tx="zhanglei.20100904114554.1245">def __init__(self, *args, **kwargs):
    kwargs['max_length'] = kwargs.get('max_length', 255)
    kwargs['blank'] = kwargs.get('blank', True)
    kwargs['default'] = kwargs.get('default', '')
    super(TagField, self).__init__(*args, **kwargs)

</t>
<t tx="zhanglei.20100904114554.1246">def contribute_to_class(self, cls, name):
    super(TagField, self).contribute_to_class(cls, name)

    # Make this object the descriptor for field access.
    setattr(cls, self.name, self)

    # Save tags back to the database post-save
    signals.post_save.connect(self._save, cls, True)

    # Update tags from Tag objects post-init
    signals.post_init.connect(self._update, cls, True)

</t>
<t tx="zhanglei.20100904114554.1247">def __get__(self, instance, owner=None):
    """
    Tag getter. Returns an instance's tags if accessed on an instance, and
    all of a model's tags if called on a class. That is, this model::

       class Link(models.Model):
           ...
           tags = TagField()

    Lets you do both of these::

       &gt;&gt;&gt; l = Link.objects.get(...)
       &gt;&gt;&gt; l.tags
       'tag1 tag2 tag3'

       &gt;&gt;&gt; Link.tags
       'tag1 tag2 tag3 tag4'

    """
    # Handle access on the model (i.e. Link.tags)
    if instance is None:
        return edit_string_for_tags(Tag.objects.usage_for_model(owner))

    return self._get_instance_tag_cache(instance)

</t>
<t tx="zhanglei.20100904114554.1248">def __set__(self, instance, value):
    """
    Set an object's tags.
    """
    if instance is None:
        raise AttributeError(_('%s can only be set on instances.') % self.name)
    if settings.FORCE_LOWERCASE_TAGS and value is not None:
        value = value.lower()
    self._set_instance_tag_cache(instance, value)

</t>
<t tx="zhanglei.20100904114554.1249">def _save(self, **kwargs): #signal, sender, instance):
    """
    Save tags back to the database
    """
    tags = self._get_instance_tag_cache(kwargs['instance'])
    Tag.objects.update_tags(kwargs['instance'], tags)

</t>
<t tx="zhanglei.20100904114554.1250">def _update(self, **kwargs): #signal, sender, instance):
    """
    Update tag cache from TaggedItem objects.
    """
    instance = kwargs['instance']
    self._update_instance_tag_cache(instance)

</t>
<t tx="zhanglei.20100904114554.1251">def __delete__(self, instance):
    """
    Clear all of an object's tags.
    """
    self._set_instance_tag_cache(instance, '')

</t>
<t tx="zhanglei.20100904114554.1252">def _get_instance_tag_cache(self, instance):
    """
    Helper: get an instance's tag cache.
    """
    print instance,self.attname
    return getattr(instance, '_%s_cache' % self.attname, None)
    """
    重点来了，这个函数的作用就是当获取一个实例的tag的时候，就是在admin里显示一个属性的值的时候重新定义其__get__()方法即可。
    这个函数就是显示的时候调用的实际工作的函数，即在__get__()函数中作的处理。这里实际工作的就一句话，
    充分熟悉getattr()函数，具体就是返回instance的第二个参数的属性，若无，返回None。
    具体到这个函数就是instance._tags_cache,这个属性在_set_instance_tag_cache()里设定的。    
    """
    

</t>
<t tx="zhanglei.20100904114554.1253">def _set_instance_tag_cache(self, instance, tags):
    """
    Helper: set an instance's tag cache.
    """
    setattr(instance, '_%s_cache' % self.attname, tags)
    """
    @simple,参照getattr，给instance赋值，然后要找是谁调用这个函数。
    共有2个方法用到了这个函数：
    __set__()和_update_instance_tag_cache()
    """

</t>
<t tx="zhanglei.20100904114554.1254">def _update_instance_tag_cache(self, instance):
    """
    Helper: update an instance's tag cache from actual Tags.
    """
    # for an unsaved object, leave the default value alone
    if instance.pk is not None:
        tags = edit_string_for_tags(Tag.objects.get_for_object(instance))
        self._set_instance_tag_cache(instance, tags)
    """
    好玩的来了，观察第一句，tags = edit_string_for_tags(Tag.objects.get_for_object(instance))
    这句返回的就是一个长字符串，接收的参数，Tag.objects.get_for_object(instance)，这个不用说就是
    找contenttype了。经分析发现，没有。就是简单的读取
    """
</t>
<t tx="zhanglei.20100904114554.1255">def get_internal_type(self):
    return 'CharField'

</t>
<t tx="zhanglei.20100904114554.1256">def formfield(self, **kwargs):
    from tagging import forms
    defaults = {'form_class': forms.TagField}
    defaults.update(kwargs)
    return super(TagField, self).formfield(**defaults)
</t>
<t tx="zhanglei.20100904114554.1272">@language python
@tabwidth -4
@others
@ignore</t>
<t tx="zhanglei.20100904114554.1273">"""
Tagging utilities - from user tag input parsing to tag cloud
calculation.
"""
import math
import types

from django.db.models.query import QuerySet
from django.utils.encoding import force_unicode
from django.utils.translation import ugettext as _

# Python 2.3 compatibility
try:
    set
except NameError:
    from sets import Set as set

</t>
<t tx="zhanglei.20100904114554.1274">def parse_tag_input(input):
    """
    Parses tag input, with multiple word input being activated and
    delineated by commas and double quotes. Quotes take precedence, so
    they may contain commas.

    Returns a sorted list of unique tag names.
    """
    if not input:
        return []

    input = force_unicode(input)

    # Special case - if there are no commas or double quotes in the
    # input, we don't *do* a recall... I mean, we know we only need to
    # split on spaces.
    if u',' not in input and u'"' not in input:
        words = list(set(split_strip(input, u' ')))
        words.sort()
        return words

    words = []
    buffer = []
    # Defer splitting of non-quoted sections until we know if there are
    # any unquoted commas.
    to_be_split = []
    saw_loose_comma = False
    open_quote = False
    i = iter(input)
    try:
        while 1:
            c = i.next()
            if c == u'"':
                if buffer:
                    to_be_split.append(u''.join(buffer))
                    buffer = []
                # Find the matching quote
                open_quote = True
                c = i.next()
                while c != u'"':
                    buffer.append(c)
                    c = i.next()
                if buffer:
                    word = u''.join(buffer).strip()
                    if word:
                        words.append(word)
                    buffer = []
                open_quote = False
            else:
                if not saw_loose_comma and c == u',':
                    saw_loose_comma = True
                buffer.append(c)
    except StopIteration:
        # If we were parsing an open quote which was never closed treat
        # the buffer as unquoted.
        if buffer:
            if open_quote and u',' in buffer:
                saw_loose_comma = True
            to_be_split.append(u''.join(buffer))
    if to_be_split:
        if saw_loose_comma:
            delimiter = u','
        else:
            delimiter = u' '
        for chunk in to_be_split:
            words.extend(split_strip(chunk, delimiter))
    words = list(set(words))
    words.sort()
    return words

</t>
<t tx="zhanglei.20100904114554.1275">def split_strip(input, delimiter=u','):
    """
    Splits ``input`` on ``delimiter``, stripping each resulting string
    and returning a list of non-empty strings.
    """
    if not input:
        return []

    words = [w.strip() for w in input.split(delimiter)]
    return [w for w in words if w]

</t>
<t tx="zhanglei.20100904114554.1276">def edit_string_for_tags(tags):
    """
    Given list of ``Tag`` instances, creates a string representation of
    the list suitable for editing by the user, such that submitting the
    given string representation back without changing it will give the
    same list of tags.
    
    Tag names which contain commas will be double quoted.
    If any tag name which isn't being quoted contains whitespace, the
    resulting string of tag names will be comma-delimited, otherwise
    it will be space-delimited.
    """
    names = []
    use_commas = False
    for tag in tags:
        name = tag.name
        if u',' in name:
            names.append('"%s"' % name)
            continue
        elif u' ' in name:
            if not use_commas:
                use_commas = True
        names.append(name)
    if use_commas:
        glue = u', '
    else:
        glue = u' '
    return glue.join(names)

</t>
<t tx="zhanglei.20100904114554.1277">def get_queryset_and_model(queryset_or_model):
    """
    Given a ``QuerySet`` or a ``Model``, returns a two-tuple of
    (queryset, model).

    If a ``Model`` is given, the ``QuerySet`` returned will be created
    using its default manager.
    """
    try:
        return queryset_or_model, queryset_or_model.model
    except AttributeError:
        return queryset_or_model._default_manager.all(), queryset_or_model

</t>
<t tx="zhanglei.20100904114554.1278">def get_tag_list(tags):
    """
    Utility function for accepting tag input in a flexible manner.

    If a ``Tag`` object is given, it will be returned in a list as
    its single occupant.

    If given, the tag names in the following will be used to create a
    ``Tag`` ``QuerySet``:

       * A string, which may contain multiple tag names.
       * A list or tuple of strings corresponding to tag names.
       * A list or tuple of integers corresponding to tag ids.

    If given, the following will be returned as-is:

       * A list or tuple of ``Tag`` objects.
       * A ``Tag`` ``QuerySet``.

    """
    from tagging.models import Tag
    if isinstance(tags, Tag):
        return [tags]
    elif isinstance(tags, QuerySet) and tags.model is Tag:
        return tags
    elif isinstance(tags, types.StringTypes):
        return Tag.objects.filter(name__in=parse_tag_input(tags))
    elif isinstance(tags, (types.ListType, types.TupleType)):
        if len(tags) == 0:
            return tags
        contents = set()
        for item in tags:
            if isinstance(item, types.StringTypes):
                contents.add('string')
            elif isinstance(item, Tag):
                contents.add('tag')
            elif isinstance(item, (types.IntType, types.LongType)):
                contents.add('int')
        if len(contents) == 1:
            if 'string' in contents:
                return Tag.objects.filter(name__in=[force_unicode(tag) \
                                                    for tag in tags])
            elif 'tag' in contents:
                return tags
            elif 'int' in contents:
                return Tag.objects.filter(id__in=tags)
        else:
            raise ValueError(_('If a list or tuple of tags is provided, they must all be tag names, Tag objects or Tag ids.'))
    else:
        raise ValueError(_('The tag input given was invalid.'))

</t>
<t tx="zhanglei.20100904114554.1279">def get_tag(tag):
    """
    Utility function for accepting single tag input in a flexible
    manner.

    If a ``Tag`` object is given it will be returned as-is; if a
    string or integer are given, they will be used to lookup the
    appropriate ``Tag``.

    If no matching tag can be found, ``None`` will be returned.
    """
    from tagging.models import Tag
    if isinstance(tag, Tag):
        return tag

    try:
        if isinstance(tag, types.StringTypes):
            return Tag.objects.get(name=tag)
        elif isinstance(tag, (types.IntType, types.LongType)):
            return Tag.objects.get(id=tag)
    except Tag.DoesNotExist:
        pass

    return None

</t>
<t tx="zhanglei.20100904114554.1280"># Font size distribution algorithms
LOGARITHMIC, LINEAR = 1, 2

def _calculate_thresholds(min_weight, max_weight, steps):
    delta = (max_weight - min_weight) / float(steps)
    return [min_weight + i * delta for i in range(1, steps + 1)]

</t>
<t tx="zhanglei.20100904114554.1281">def _calculate_tag_weight(weight, max_weight, distribution):
    """
    Logarithmic tag weight calculation is based on code from the
    `Tag Cloud`_ plugin for Mephisto, by Sven Fuchs.

    .. _`Tag Cloud`: http://www.artweb-design.de/projects/mephisto-plugin-tag-cloud
    """
    if distribution == LINEAR or max_weight == 1:
        return weight
    elif distribution == LOGARITHMIC:
        return math.log(weight) * max_weight / math.log(max_weight)
    raise ValueError(_('Invalid distribution algorithm specified: %s.') % distribution)

</t>
<t tx="zhanglei.20100904114554.1282">def calculate_cloud(tags, steps=4, distribution=LOGARITHMIC):
    """
    Add a ``font_size`` attribute to each tag according to the
    frequency of its use, as indicated by its ``count``
    attribute.

    ``steps`` defines the range of font sizes - ``font_size`` will
    be an integer between 1 and ``steps`` (inclusive).

    ``distribution`` defines the type of font size distribution
    algorithm which will be used - logarithmic or linear. It must be
    one of ``tagging.utils.LOGARITHMIC`` or ``tagging.utils.LINEAR``.
    """
    if len(tags) &gt; 0:
        counts = [tag.count for tag in tags]
        min_weight = float(min(counts))
        max_weight = float(max(counts))
        thresholds = _calculate_thresholds(min_weight, max_weight, steps)
        for tag in tags:
            font_set = False
            tag_weight = _calculate_tag_weight(tag.count, max_weight, distribution)
            for i in range(steps):
                if not font_set and tag_weight &lt;= thresholds[i]:
                    tag.font_size = i + 1
                    font_set = True
    return tags
</t>
<t tx="zhanglei.20100905105221.1297">@language python
@tabwidth -4
@others
@ignore</t>
<t tx="zhanglei.20100905105221.1298">"""
Models and managers for generic tagging.
"""
# Python 2.3 compatibility
try:
    set
except NameError:
    from sets import Set as set

from django.contrib.contenttypes import generic
from django.contrib.contenttypes.models import ContentType
from django.db import connection, models
from django.db.models.query import QuerySet
from django.utils.translation import ugettext_lazy as _

from tagging import settings
from tagging.utils import calculate_cloud, get_tag_list, get_queryset_and_model, parse_tag_input
from tagging.utils import LOGARITHMIC

qn = connection.ops.quote_name

</t>
<t tx="zhanglei.20100905105221.1299">############
# Managers #
############

class TagManager(models.Manager):
    @others
</t>
<t tx="zhanglei.20100905105221.1300">def update_tags(self, obj, tag_names):
    """
    Update tags associated with an object.
    """
    ctype = ContentType.objects.get_for_model(obj)
    current_tags = list(self.filter(items__content_type__pk=ctype.pk,
                                    items__object_id=obj.pk))
    updated_tag_names = parse_tag_input(tag_names)
    if settings.FORCE_LOWERCASE_TAGS:
        updated_tag_names = [t.lower() for t in updated_tag_names]

    # Remove tags which no longer apply
    tags_for_removal = [tag for tag in current_tags \
                        if tag.name not in updated_tag_names]
    if len(tags_for_removal):
        TaggedItem._default_manager.filter(content_type__pk=ctype.pk,
                                           object_id=obj.pk,
                                           tag__in=tags_for_removal).delete()
    # Add new tags
    current_tag_names = [tag.name for tag in current_tags]
    for tag_name in updated_tag_names:
        if tag_name not in current_tag_names:
            tag, created = self.get_or_create(name=tag_name)
            TaggedItem._default_manager.create(tag=tag, object=obj, count=1)
    """
    这个是save的函数，接收的参数有，一个对象和这个对象的tags，
    首先根据对象取得他的model，
    """  
</t>
<t tx="zhanglei.20100905105221.1301">def add_tag(self, obj, tag_name):
    """
    Associates the given object with a tag.
    """
    tag_names = parse_tag_input(tag_name)
    if not len(tag_names):
        raise AttributeError(_('No tags were given: "%s".') % tag_name)
    if len(tag_names) &gt; 1:
        raise AttributeError(_('Multiple tags were given: "%s".') % tag_name)
    tag_name = tag_names[0]
    if settings.FORCE_LOWERCASE_TAGS:
        tag_name = tag_name.lower()
    tag, created = self.get_or_create(name=tag_name)
    ctype = ContentType.objects.get_for_model(obj)
    TaggedItem._default_manager.get_or_create(
        tag=tag, content_type=ctype, object_id=obj.pk)

</t>
<t tx="zhanglei.20100905105221.1302">def add_tags(self, obj, tag_name):
    """
    Associates the given object with a tag.
    """
    tag_names = parse_tag_input(tag_name)
    if not len(tag_names):
        raise AttributeError(_('No tags were given: "%s".') % tag_name)
    for tag_name in tag_names:
        if settings.FORCE_LOWERCASE_TAGS:
            tag_name = tag_name.lower()
        tag, created = self.get_or_create(name=tag_name)
        ctype = ContentType.objects.get_for_model(obj)
        TaggedItem._default_manager.get_or_create(
            tag=tag, content_type=ctype, object_id=obj.pk)

</t>
<t tx="zhanglei.20100905105221.1303">def get_for_object(self, obj):
    """
    Create a queryset matching all tags associated with the given
    object.
    """
    ctype = ContentType.objects.get_for_model(obj)
    return self.filter(items__content_type__pk=ctype.pk,
                       items__object_id=obj.pk)

</t>
<t tx="zhanglei.20100905105221.1304">def _get_usage(self, model, counts=False, min_count=None, extra_joins=None, extra_criteria=None, params=None):
    """
    Perform the custom SQL query for ``usage_for_model`` and
    ``usage_for_queryset``.
    """
    if min_count is not None: counts = True

    model_table = qn(model._meta.db_table)
    model_pk = '%s.%s' % (model_table, qn(model._meta.pk.column))
    query = """
    SELECT DISTINCT %(tag)s.id, %(tag)s.name%(count_sql)s
    FROM
        %(tag)s
        INNER JOIN %(tagged_item)s
            ON %(tag)s.id = %(tagged_item)s.tag_id
        INNER JOIN %(model)s
            ON %(tagged_item)s.object_id = %(model_pk)s
        %%s
    WHERE %(tagged_item)s.content_type_id = %(content_type_id)s
        %%s
    GROUP BY %(tag)s.id, %(tag)s.name
    %%s
    ORDER BY %(tag)s.name ASC""" % {
        'tag': qn(self.model._meta.db_table),
        'count_sql': counts and (', COUNT(%s)' % model_pk) or '',
        'tagged_item': qn(TaggedItem._meta.db_table),
        'model': model_table,
        'model_pk': model_pk,
        'content_type_id': ContentType.objects.get_for_model(model).pk,
    }

    min_count_sql = ''
    if min_count is not None:
        min_count_sql = 'HAVING COUNT(%s) &gt;= %%s' % model_pk
        params.append(min_count)

    cursor = connection.cursor()
    cursor.execute(query % (extra_joins, extra_criteria, min_count_sql), params)
    tags = []
    for row in cursor.fetchall():
        t = self.model(*row[:2])
        if counts:
            t.count = row[2]
        tags.append(t)
    return tags

</t>
<t tx="zhanglei.20100905105221.1305">def usage_for_model(self, model, counts=False, min_count=None, filters=None):
    """
    Obtain a list of tags associated with instances of the given
    Model class.

    If ``counts`` is True, a ``count`` attribute will be added to
    each tag, indicating how many times it has been used against
    the Model class in question.

    If ``min_count`` is given, only tags which have a ``count``
    greater than or equal to ``min_count`` will be returned.
    Passing a value for ``min_count`` implies ``counts=True``.

    To limit the tags (and counts, if specified) returned to those
    used by a subset of the Model's instances, pass a dictionary
    of field lookups to be applied to the given Model as the
    ``filters`` argument.
    """
    if filters is None: filters = {}

    queryset = model._default_manager.filter()
    for f in filters.items():
        queryset.query.add_filter(f)
    usage = self.usage_for_queryset(queryset, counts, min_count)

    return usage

</t>
<t tx="zhanglei.20100905105221.1306">def usage_for_queryset(self, queryset, counts=False, min_count=None):
    """
    Obtain a list of tags associated with instances of a model
    contained in the given queryset.

    If ``counts`` is True, a ``count`` attribute will be added to
    each tag, indicating how many times it has been used against
    the Model class in question.

    If ``min_count`` is given, only tags which have a ``count``
    greater than or equal to ``min_count`` will be returned.
    Passing a value for ``min_count`` implies ``counts=True``.
    """

    extra_joins = ' '.join(queryset.query.get_from_clause()[0][1:])
    where, params = queryset.query.where.as_sql()
    if where:
        extra_criteria = 'AND %s' % where
    else:
        extra_criteria = ''
    return self._get_usage(queryset.model, counts, min_count, extra_joins, extra_criteria, params)

</t>
<t tx="zhanglei.20100905105221.1307">def related_for_model(self, tags, model, counts=False, min_count=None):
    """
    Obtain a list of tags related to a given list of tags - that
    is, other tags used by items which have all the given tags.

    If ``counts`` is True, a ``count`` attribute will be added to
    each tag, indicating the number of items which have it in
    addition to the given list of tags.

    If ``min_count`` is given, only tags which have a ``count``
    greater than or equal to ``min_count`` will be returned.
    Passing a value for ``min_count`` implies ``counts=True``.
    """
    if min_count is not None: counts = True
    tags = get_tag_list(tags)
    tag_count = len(tags)
    tagged_item_table = qn(TaggedItem._meta.db_table)
    query = """
    SELECT %(tag)s.id, %(tag)s.name%(count_sql)s
    FROM %(tagged_item)s INNER JOIN %(tag)s ON %(tagged_item)s.tag_id = %(tag)s.id
    WHERE %(tagged_item)s.content_type_id = %(content_type_id)s
      AND %(tagged_item)s.object_id IN
      (
          SELECT %(tagged_item)s.object_id
          FROM %(tagged_item)s, %(tag)s
          WHERE %(tagged_item)s.content_type_id = %(content_type_id)s
            AND %(tag)s.id = %(tagged_item)s.tag_id
            AND %(tag)s.id IN (%(tag_id_placeholders)s)
          GROUP BY %(tagged_item)s.object_id
          HAVING COUNT(%(tagged_item)s.object_id) = %(tag_count)s
      )
      AND %(tag)s.id NOT IN (%(tag_id_placeholders)s)
    GROUP BY %(tag)s.id, %(tag)s.name
    %(min_count_sql)s
    ORDER BY %(tag)s.name ASC""" % {
        'tag': qn(self.model._meta.db_table),
        'count_sql': counts and ', COUNT(%s.object_id)' % tagged_item_table or '',
        'tagged_item': tagged_item_table,
        'content_type_id': ContentType.objects.get_for_model(model).pk,
        'tag_id_placeholders': ','.join(['%s'] * tag_count),
        'tag_count': tag_count,
        'min_count_sql': min_count is not None and ('HAVING COUNT(%s.object_id) &gt;= %%s' % tagged_item_table) or '',
    }

    params = [tag.pk for tag in tags] * 2
    if min_count is not None:
        params.append(min_count)

    cursor = connection.cursor()
    cursor.execute(query, params)
    related = []
    for row in cursor.fetchall():
        tag = self.model(*row[:2])
        if counts is True:
            tag.count = row[2]
        related.append(tag)
    return related

</t>
<t tx="zhanglei.20100905105221.1308">def cloud_for_model(self, model, steps=4, distribution=LOGARITHMIC,
                    filters=None, min_count=None):
    """
    Obtain a list of tags associated with instances of the given
    Model, giving each tag a ``count`` attribute indicating how
    many times it has been used and a ``font_size`` attribute for
    use in displaying a tag cloud.

    ``steps`` defines the range of font sizes - ``font_size`` will
    be an integer between 1 and ``steps`` (inclusive).

    ``distribution`` defines the type of font size distribution
    algorithm which will be used - logarithmic or linear. It must
    be either ``tagging.utils.LOGARITHMIC`` or
    ``tagging.utils.LINEAR``.

    To limit the tags displayed in the cloud to those associated
    with a subset of the Model's instances, pass a dictionary of
    field lookups to be applied to the given Model as the
    ``filters`` argument.

    To limit the tags displayed in the cloud to those with a
    ``count`` greater than or equal to ``min_count``, pass a value
    for the ``min_count`` argument.
    """
    tags = list(self.usage_for_model(model, counts=True, filters=filters,
                                     min_count=min_count))
    return calculate_cloud(tags, steps, distribution)

</t>
<t tx="zhanglei.20100905105221.1309">class TaggedItemManager(models.Manager):
    """
    FIXME There's currently no way to get the ``GROUP BY`` and ``HAVING``
          SQL clauses required by many of this manager's methods into
          Django's ORM.

          For now, we manually execute a query to retrieve the PKs of
          objects we're interested in, then use the ORM's ``__in``
          lookup to return a ``QuerySet``.

          Now that the queryset-refactor branch is in the trunk, this can be
          tidied up significantly.
    """
    @others
</t>
<t tx="zhanglei.20100905105221.1310">def get_by_model(self, queryset_or_model, tags):
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
    )

</t>
<t tx="zhanglei.20100905105221.1311">def get_intersection_by_model(self, queryset_or_model, tags):
    """
    Create a ``QuerySet`` containing instances of the specified
    model associated with *all* of the given list of tags.
    """
    tags = get_tag_list(tags)
    tag_count = len(tags)
    queryset, model = get_queryset_and_model(queryset_or_model)

    if not tag_count:
        return model._default_manager.none()

    model_table = qn(model._meta.db_table)
    # This query selects the ids of all objects which have all the
    # given tags.
    query = """
    SELECT %(model_pk)s
    FROM %(model)s, %(tagged_item)s
    WHERE %(tagged_item)s.content_type_id = %(content_type_id)s
      AND %(tagged_item)s.tag_id IN (%(tag_id_placeholders)s)
      AND %(model_pk)s = %(tagged_item)s.object_id
    GROUP BY %(model_pk)s
    HAVING COUNT(%(model_pk)s) = %(tag_count)s""" % {
        'model_pk': '%s.%s' % (model_table, qn(model._meta.pk.column)),
        'model': model_table,
        'tagged_item': qn(self.model._meta.db_table),
        'content_type_id': ContentType.objects.get_for_model(model).pk,
        'tag_id_placeholders': ','.join(['%s'] * tag_count),
        'tag_count': tag_count,
    }

    cursor = connection.cursor()
    cursor.execute(query, [tag.pk for tag in tags])
    object_ids = [row[0] for row in cursor.fetchall()]
    if len(object_ids) &gt; 0:
        return queryset.filter(pk__in=object_ids)
    else:
        return model._default_manager.none()

</t>
<t tx="zhanglei.20100905105221.1312">def get_union_by_model(self, queryset_or_model, tags):
    """
    Create a ``QuerySet`` containing instances of the specified
    model associated with *any* of the given list of tags.
    """
    tags = get_tag_list(tags)
    tag_count = len(tags)
    queryset, model = get_queryset_and_model(queryset_or_model)

    if not tag_count:
        return model._default_manager.none()

    model_table = qn(model._meta.db_table)
    # This query selects the ids of all objects which have any of
    # the given tags.
    query = """
    SELECT %(model_pk)s
    FROM %(model)s, %(tagged_item)s
    WHERE %(tagged_item)s.content_type_id = %(content_type_id)s
      AND %(tagged_item)s.tag_id IN (%(tag_id_placeholders)s)
      AND %(model_pk)s = %(tagged_item)s.object_id
    GROUP BY %(model_pk)s""" % {
        'model_pk': '%s.%s' % (model_table, qn(model._meta.pk.column)),
        'model': model_table,
        'tagged_item': qn(self.model._meta.db_table),
        'content_type_id': ContentType.objects.get_for_model(model).pk,
        'tag_id_placeholders': ','.join(['%s'] * tag_count),
    }

    cursor = connection.cursor()
    cursor.execute(query, [tag.pk for tag in tags])
    object_ids = [row[0] for row in cursor.fetchall()]
    if len(object_ids) &gt; 0:
        return queryset.filter(pk__in=object_ids)
    else:
        return model._default_manager.none()

</t>
<t tx="zhanglei.20100905105221.1313">def get_related(self, obj, queryset_or_model, num=None):
    """
    Retrieve a list of instances of the specified model which share
    tags with the model instance ``obj``, ordered by the number of
    shared tags in descending order.

    If ``num`` is given, a maximum of ``num`` instances will be
    returned.
    """
    queryset, model = get_queryset_and_model(queryset_or_model)
    model_table = qn(model._meta.db_table)
    content_type = ContentType.objects.get_for_model(obj)
    related_content_type = ContentType.objects.get_for_model(model)
    query = """
    SELECT %(model_pk)s, COUNT(related_tagged_item.object_id) AS %(count)s
    FROM %(model)s, %(tagged_item)s, %(tag)s, %(tagged_item)s related_tagged_item
    WHERE %(tagged_item)s.object_id = %%s
      AND %(tagged_item)s.content_type_id = %(content_type_id)s
      AND %(tag)s.id = %(tagged_item)s.tag_id
      AND related_tagged_item.content_type_id = %(related_content_type_id)s
      AND related_tagged_item.tag_id = %(tagged_item)s.tag_id
      AND %(model_pk)s = related_tagged_item.object_id"""
    if content_type.pk == related_content_type.pk:
        # Exclude the given instance itself if determining related
        # instances for the same model.
        query += """
      AND related_tagged_item.object_id != %(tagged_item)s.object_id"""
    query += """
    GROUP BY %(model_pk)s
    ORDER BY %(count)s DESC
    %(limit_offset)s"""
    query = query % {
        'model_pk': '%s.%s' % (model_table, qn(model._meta.pk.column)),
        'count': qn('count'),
        'model': model_table,
        'tagged_item': qn(self.model._meta.db_table),
        'tag': qn(self.model._meta.get_field('tag').rel.to._meta.db_table),
        'content_type_id': content_type.pk,
        'related_content_type_id': related_content_type.pk,
        # Hardcoding this for now just to get tests working again - this
        # should now be handled by the query object.
        'limit_offset': num is not None and 'LIMIT %s' or '',
    }

    cursor = connection.cursor()
    params = [obj.pk]
    if num is not None:
        params.append(num)
    cursor.execute(query, params)
    object_ids = [row[0] for row in cursor.fetchall()]
    if len(object_ids) &gt; 0:
        # Use in_bulk here instead of an id__in lookup, because id__in would
        # clobber the ordering.
        object_dict = queryset.in_bulk(object_ids)
        return [object_dict[object_id] for object_id in object_ids \
                if object_id in object_dict]
    else:
        return []

</t>
<t tx="zhanglei.20100905105221.1314">##########
# Models #
##########

class Tag(models.Model):
    """
    A tag.
    """
    name = models.CharField(_('name'), max_length=50, unique=True, db_index=True)

    objects = TagManager()

    @others
</t>
<t tx="zhanglei.20100905105221.1315">class Meta:
    ordering = ('name',)
    verbose_name = _('tag')
    verbose_name_plural = _('tags')

</t>
<t tx="zhanglei.20100905105221.1316">def __unicode__(self):
    return self.name

</t>
<t tx="zhanglei.20100905105221.1317">class TaggedItem(models.Model):
    """
    Holds the relationship between a tag and the item being tagged.
    """
    tag          = models.ForeignKey(Tag, verbose_name=_('tag'), related_name='items')
    content_type = models.ForeignKey(ContentType, verbose_name=_('content type'))
    object_id    = models.PositiveIntegerField(_('object id'), db_index=True)
    count        = models.PositiveIntegerField(default=1)
    object       = generic.GenericForeignKey('content_type', 'object_id')

    objects = TaggedItemManager()

    @others
</t>
<t tx="zhanglei.20100905105221.1318">class Meta:
    # Enforce unique tag association per object
    unique_together = (('tag', 'content_type', 'object_id'),)
    verbose_name = _('tagged item')
    verbose_name_plural = _('tagged items')

</t>
<t tx="zhanglei.20100905105221.1319">def __unicode__(self):
    return u'%s [%s]' % (self.object, self.tag)
</t>
</tnodes>
</leo_file>
