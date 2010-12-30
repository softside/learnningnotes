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
<v t="zhanglei.20101005134757.1365"><vh>@chapters</vh></v>
<v t="zhanglei.20101005134757.1364"><vh>总体描述</vh></v>
<v t="zhanglei.20101005134757.1366"><vh>1，游戏介绍页</vh>
<v t="zhanglei.20101005134757.1367"><vh>反馈</vh></v>
</v>
<v t="zhanglei.20101005134757.1368"><vh>2，游戏列表页</vh>
<v t="zhanglei.20101005134757.1369"><vh>反馈</vh></v>
</v>
<v t="zhanglei.20101005134757.1370"><vh>model</vh>
<v t="zhanglei.20101005134757.1371"><vh>描述</vh></v>
</v>
<v t="zhanglei.20101005134757.1372"><vh>super</vh></v>
</vnodes>
<tnodes>
<t tx="zhanglei.20101005134757.1364"></t>
<t tx="zhanglei.20101005134757.1365"></t>
<t tx="zhanglei.20101005134757.1366">在用户选定固定标签（“策略”）的情况下，
提取≤35个父级标签=所选固定标签（“策略”）的自由标签，
且可以对提取的标签进行自定义排序；
每个标签都提取链接；</t>
<t tx="zhanglei.20101005134757.1367">：// 且可以对提取的标签进行自定义排序；

这是啥意思？？排序，规则是啥？？</t>
<t tx="zhanglei.20101005134757.1368"></t>
<t tx="zhanglei.20101005134757.1369">这个为啥要确定后在选择，明显没有必要，具体可参考京东，，</t>
<t tx="zhanglei.20101005134757.1370">class ModelBase(type):
    """
    Metaclass for all models.
    """
    def __new__(cls, name, bases, attrs):
        #这个name就是类的名字了，后面的两个一个是父类的tuple，一个是临时字典？》
        #这个cls是啥阿？？
        super_new = super(ModelBase, cls).__new__
        #这里把
        parents = [b for b in bases if isinstance(b, ModelBase)]//bases中所有是ModelBase的实例的类，
        
        if not parents:
            # If this isn't a subclass of Model, don't do anything special.
            return super_new(cls, name, bases, attrs)

        # Create the class.
        module = attrs.pop('__module__')
        new_class = super_new(cls, name, bases, {'__module__': module})
        attr_meta = attrs.pop('Meta', None)
        abstract = getattr(attr_meta, 'abstract', False)
        if not attr_meta:
            meta = getattr(new_class, 'Meta', None)
        else:
            meta = attr_meta
        base_meta = getattr(new_class, '_meta', None)

        if getattr(meta, 'app_label', None) is None:
            # Figure out the app_label by looking one level up.
            # For 'django.contrib.sites.models', this would be 'sites'.
            model_module = sys.modules[new_class.__module__]
            kwargs = {"app_label": model_module.__name__.split('.')[-2]}
        else:
            kwargs = {}
        #这个是从某个model的class：Meta中取的配置值        
        new_class.add_to_class('_meta', Options(meta, **kwargs))
        if not abstract:
            new_class.add_to_class('DoesNotExist', subclass_exception('DoesNotExist',
                    tuple(x.DoesNotExist
                            for x in parents if hasattr(x, '_meta') and not x._meta.abstract)
                                    or (ObjectDoesNotExist,), module))
            new_class.add_to_class('MultipleObjectsReturned', subclass_exception('MultipleObjectsReturned',
                    tuple(x.MultipleObjectsReturned
                            for x in parents if hasattr(x, '_meta') and not x._meta.abstract)
                                    or (MultipleObjectsReturned,), module))
            if base_meta and not base_meta.abstract:
                # Non-abstract child classes inherit some attributes from their
                # non-abstract parent (unless an ABC comes before it in the
                # method resolution order).
                if not hasattr(meta, 'ordering'):
                    new_class._meta.ordering = base_meta.ordering
                if not hasattr(meta, 'get_latest_by'):
                    new_class._meta.get_latest_by = base_meta.get_latest_by

        is_proxy = new_class._meta.proxy

        if getattr(new_class, '_default_manager', None):
            if not is_proxy:
                # Multi-table inheritance doesn't inherit default manager from
                # parents.
                new_class._default_manager = None
                new_class._base_manager = None
            else:
                # Proxy classes do inherit parent's default manager, if none is
                # set explicitly.
                new_class._default_manager = new_class._default_manager._copy_to_model(new_class)
                new_class._base_manager = new_class._base_manager._copy_to_model(new_class)

        # Bail out early if we have already created this class.
        m = get_model(new_class._meta.app_label, name, False)
        if m is not None:
            return m

        # Add all attributes to the class.
        for obj_name, obj in attrs.items():
            new_class.add_to_class(obj_name, obj)

        # All the fields of any type declared on this model
        new_fields = new_class._meta.local_fields + \
                     new_class._meta.local_many_to_many + \
                     new_class._meta.virtual_fields
        field_names = set([f.name for f in new_fields])

        # Basic setup for proxy models.
        if is_proxy:
            base = None
            for parent in [cls for cls in parents if hasattr(cls, '_meta')]:
                if parent._meta.abstract:
                    if parent._meta.fields:
                        raise TypeError("Abstract base class containing model fields not permitted for proxy model '%s'." % name)
                    else:
                        continue
                if base is not None:
                    raise TypeError("Proxy model '%s' has more than one non-abstract model base class." % name)
                else:
                    base = parent
            if base is None:
                    raise TypeError("Proxy model '%s' has no non-abstract model base class." % name)
            if (new_class._meta.local_fields or
                    new_class._meta.local_many_to_many):
                raise FieldError("Proxy model '%s' contains model fields." % name)
            while base._meta.proxy:
                base = base._meta.proxy_for_model
            new_class._meta.setup_proxy(base)

        # Do the appropriate setup for any model parents.
        o2o_map = dict([(f.rel.to, f) for f in new_class._meta.local_fields
                if isinstance(f, OneToOneField)])

        for base in parents:
            original_base = base
            if not hasattr(base, '_meta'):
                # Things without _meta aren't functional models, so they're
                # uninteresting parents.
                continue

            parent_fields = base._meta.local_fields + base._meta.local_many_to_many
            # Check for clashes between locally declared fields and those
            # on the base classes (we cannot handle shadowed fields at the
            # moment).
            for field in parent_fields:
                if field.name in field_names:
                    raise FieldError('Local field %r in class %r clashes '
                                     'with field of similar name from '
                                     'base class %r' %
                                        (field.name, name, base.__name__))
            if not base._meta.abstract:
                # Concrete classes...
                while base._meta.proxy:
                    # Skip over a proxy class to the "real" base it proxies.
                    base = base._meta.proxy_for_model
                if base in o2o_map:
                    field = o2o_map[base]
                elif not is_proxy:
                    attr_name = '%s_ptr' % base._meta.module_name
                    field = OneToOneField(base, name=attr_name,
                            auto_created=True, parent_link=True)
                    new_class.(attr_name, field)
                else:
                    field = None
                new_class._meta.parents[base] = field
            else:
                # .. and abstract ones.
                for field in parent_fields:
                    new_class.add_to_class(field.name, copy.deepcopy(field))

                # Pass any non-abstract parent classes onto child.
                new_class._meta.parents.update(base._meta.parents)

            # Inherit managers from the abstract base classes.
            new_class.copy_managers(base._meta.abstract_managers)

            # Proxy models inherit the non-abstract managers from their base,
            # unless they have redefined any of them.
            if is_proxy:
                new_class.copy_managers(original_base._meta.concrete_managers)

            # Inherit virtual fields (like GenericForeignKey) from the parent
            # class
            for field in base._meta.virtual_fields:
                if base._meta.abstract and field.name in field_names:
                    raise FieldError('Local field %r in class %r clashes '\
                                     'with field of similar name from '\
                                     'abstract base class %r' % \
                                        (field.name, name, base.__name__))
                new_class.add_to_class(field.name, copy.deepcopy(field))

        if abstract:
            # Abstract base models can't be instantiated and don't appear in
            # the list of models for an app. We do the final setup for them a
            # little differently from normal models.
            attr_meta.abstract = False
            new_class.Meta = attr_meta
            return new_class

        new_class._prepare()
        register_models(new_class._meta.app_label, new_class)

        # Because of the way imports happen (recursively), we may or may not be
        # the first time this model tries to register with the framework. There
        # should only be one class for each model, so we always return the
        # registered version.
        return get_model(new_class._meta.app_label, name, False)

    def copy_managers(cls, base_managers):
        # This is in-place sorting of an Options attribute, but that's fine.
        base_managers.sort()
        for _, mgr_name, manager in base_managers:
            val = getattr(cls, mgr_name, None)
            if not val or val is manager:
                new_manager = manager._copy_to_model(cls)
                cls.add_to_class(mgr_name, new_manager)

    def add_to_class(cls, name, value):
        if hasattr(value, 'contribute_to_class'):
            value.contribute_to_class(cls, name)
        else:
            setattr(cls, name, value)

    def _prepare(cls):
        """
        Creates some methods once self._meta has been populated.
        """
        opts = cls._meta
        opts._prepare(cls)

        if opts.order_with_respect_to:
            cls.get_next_in_order = curry(cls._get_next_or_previous_in_order, is_next=True)
            cls.get_previous_in_order = curry(cls._get_next_or_previous_in_order, is_next=False)
            setattr(opts.order_with_respect_to.rel.to, 'get_%s_order' % cls.__name__.lower(), curry(method_get_order, cls))
            setattr(opts.order_with_respect_to.rel.to, 'set_%s_order' % cls.__name__.lower(), curry(method_set_order, cls))

        # Give the class a docstring -- its definition.
        if cls.__doc__ is None:
            cls.__doc__ = "%s(%s)" % (cls.__name__, ", ".join([f.attname for f in opts.fields]))

        if hasattr(cls, 'get_absolute_url'):
            cls.get_absolute_url = update_wrapper(curry(get_absolute_url, opts, cls.get_absolute_url),
                                                  cls.get_absolute_url)

        signals.class_prepared.send(sender=cls)</t>
<t tx="zhanglei.20101005134757.1371"></t>
<t tx="zhanglei.20101005134757.1372">#! /usr/bin/env python
#coding=utf-8
class A(object):
    def hello(self):
        print "A"

class B(A):
    def hello(self):
        print "B"

class C(B):
    def hello(self):
        print "C"

b=C()
#a = super(C)
#print dir(a)
#a.__thisclass__().hello()
#super(C,B).hello()
super(B,b).hello()
super(C,b).hello()

一直被python的super所折磨：

super(type[, object-or-type])

Return a proxy object that delegates method calls to a parent or sibling class of type. This is useful for accessing inherited methods that have been overridden in a class. The search order is same as that used by getattr() except that the type itself is skipped.

返回一个“不知道怎么描述”，其实他返回的东西或者是一个&lt;super: &lt;class 'C'&gt;, NULL&gt; 或者是一个类。。这是用来访问在一个类中被重写的继承的方法。
查找顺序和getattr()一样，只是type被忽略了

The __mro__ attribute of the type lists the method resolution search order used by both getattr() and super(). The attribute is dynamic and can change whenever the inheritance hierarchy is updated.


If the second argument is omitted, the super object returned is unbound. If the second argument is an object, isinstance(obj, type) must be true. If the second argument is a type, issubclass(type2, type) must be true (this is useful for classmethods).
注意：如果第二个参数被忽略，super（）返回的对象是没有绑定的，就是&lt;super: &lt;class 'C'&gt;, NULL&gt;，这个值是不可以被使用的要使用的话

Note super() only works for new-style classes.
super()仅适用于新式类

There are two typical use cases for super. In a class hierarchy with single inheritance, super can be used to refer to parent classes without naming them explicitly, thus making the code more maintainable. This use closely parallels the use of super in other programming languages.
super()有2种用法，在单重继承的类中super可以找到某个类的父类而不用明确的指出这个类的名字。这个和其他编程语言的super意义差别不大

The second use case is to support cooperative multiple inheritance in a dynamic execution environment. This use case is unique to Python and is not found in statically compiled languages or languages that only support single inheritance. This makes it possible to implement “diamond diagrams” where multiple base classes implement the same method. Good design dictates that this method have the same calling signature in every case (because the order of calls is determined at runtime, because that order adapts to changes in the class hierarchy, and because that order can include sibling classes that are unknown prior to runtime).

这个就不知道是啥意思了。。



For both use cases, a typical superclass call looks like this:
上面2种应用，一个标准的父类调用就是下面这样：
class C(B):
    def method(self, arg):
        super(C, self).method(arg)

Note that super() is implemented as part of the binding process for explicit dotted attribute lookups such as super().__getitem__(name). It does so by implementing its own __getattribute__() method for searching classes in a predictable order that supports cooperative multiple inheritance. Accordingly, super() is undefined for implicit lookups using statements or operators such as super()[name].


Also note that super() is not limited to use inside methods. The two argument form specifies the arguments exactly and makes the appropriate references.



</t>
</tnodes>
</leo_file>
