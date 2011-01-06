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
<v t="newlife.20110105104941.1267"><vh>about</vh></v>
<v t="newlife.20110105104941.1268" a="E"><vh>登录流程</vh>
<v t="newlife.20110105104941.1269"><vh>login</vh></v>
</v>
<v t="newlife.20110105104941.1270" a="E"><vh>备选方案</vh>
<v t="newlife.20110105104941.1273"><vh>先决条件</vh></v>
<v t="newlife.20110105104941.1274"><vh>custom_backend</vh></v>
</v>
<v t="newlife.20110106110632.1280" a="E"><vh>实施方案</vh>
<v t="newlife.20110106110632.1281"><vh>backend</vh></v>
<v t="newlife.20110106110632.1282"><vh>seetings</vh></v>
<v t="newlife.20110106110632.1283"><vh>register</vh>
<v t="newlife.20110106110632.1285"><vh>@file /home/newlife/ddl_server/ddl_server/sns_ddl/users/views.py</vh>
<v t="newlife.20110106110632.1287"><vh>index</vh></v>
<v t="newlife.20110106110632.1288" a="M"><vh>register</vh></v>
<v t="newlife.20110106110632.1289"><vh>ajax_register</vh></v>
<v t="newlife.20110106110632.1290" a="M"><vh>active_account</vh></v>
<v t="newlife.20110106110632.1291"><vh>user_login</vh></v>
<v t="newlife.20110106110632.1292"><vh>user_logout</vh></v>
<v t="newlife.20110106110632.1293" a="M"><vh>basic_settings</vh></v>
<v t="newlife.20110106110632.1294" a="M"><vh>account_settings</vh></v>
<v t="newlife.20110106110632.1295" a="M"><vh>justforfun_settings</vh></v>
<v t="newlife.20110106110632.1296"><vh>forgot_password</vh></v>
<v t="newlife.20110106110632.1297" a="M"><vh>reset_password</vh></v>
<v t="newlife.20110106110632.1298"><vh>users_invite</vh></v>
<v t="newlife.20110106110632.1299" a="M"><vh>disableUserAMF</vh></v>
</v>
</v>
<v t="newlife.20110106110632.1300" a="E"><vh>问题</vh>
<v t="newlife.20110106110632.1301"><vh>ppy_userprofile</vh></v>
</v>
<v t="newlife.20110106110632.1302"><vh>TODO</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110105104941.1267">需要处理的事:
    首先，分析清楚需要处理的哪里模块，就是和auth_user相关联的表
    
    ppy_userprofile</t>
<t tx="newlife.20110105104941.1268"></t>
<t tx="newlife.20110105104941.1269">@code
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            login(request, form.get_user())
            if request.session.test_cookie_worked():
                request.session.delete_test_cookie()
            request.session.set_expiry(3600*12)
            return HttpResponseRedirect('/play/')

class AuthenticationForm(forms.Form):
    """
    Base class for authenticating users. Extend this to get a form that accepts
    username/password logins.
    """
    username = forms.CharField(label=_("Username"), max_length=30)
    password = forms.CharField(label=_("Password"), widget=forms.PasswordInput)

    def __init__(self, request=None, *args, **kwargs):
        """
        If request is passed in, the form will validate that cookies are
        enabled. Note that the request (a HttpRequest object) must have set a
        cookie with the key TEST_COOKIE_NAME and value TEST_COOKIE_VALUE before
        running this validation.
        """
        self.request = request
        self.user_cache = None
        super(AuthenticationForm, self).__init__(*args, **kwargs)

    def clean(self):
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password')

        if username and password:
            self.user_cache = authenticate(username=username, password=password)
            if self.user_cache is None:
                raise forms.ValidationError(_("Please enter a correct username and password. Note that both fields are case-sensitive."))
            elif not self.user_cache.is_active:
                raise forms.ValidationError(_("This account is inactive."))

        # TODO: determine whether this should move to its own method.
        if self.request:
            if not self.request.session.test_cookie_worked():
                raise forms.ValidationError(_("Your Web browser doesn't appear to have cookies enabled. Cookies are required for logging in."))

        return self.cleaned_data

    def get_user_id(self):
        if self.user_cache:
            return self.user_cache.id
        return None

    def get_user(self):
        return self.user_cache

@doc
            self.user_cache = authenticate(username=username, password=password)
          这行已经验证过了。。
@code          
    # 更新头像和用户名信息
    try:
        sns_user_name, sns_user_avatar = get_sns_user(session_key, member.sns_id)
        if member.nickname != sns_user_name or member.avatar != sns_user_avatar:
            member.nickname = sns_user_name
            member.avatar = sns_user_avatar
            member.save()
    except:
        pass
</t>
<t tx="newlife.20110105104941.1270">我们现在要做的是ppy的用户可以登录ddl，



然后ddl还可以注册。（如何保证用户不会冲突，）



还有就是ddl注册的时候，要先去ppy检查有无这个用户名称。



这个仅适用于官网的游戏，对各个平台没有这个问题，因为都是独自的用户。






最省的方式就是只用一个auth_user表,但是这个里面有很多不确定的事情，比如说：多表互用。还有就是auth_user这个表是系统自己建立的，有很多事情，倒是可以考虑自己写一个用户登录的系统，估计也是不合适的，





我们using的时候，他是怎么知道这个数据库中有这个表的？？他知道。，。，

需要再ddl这个项目中所有处理user的地方加上 using("second")这一项，处理，

每一个登录过的用户都会建立一个创建一个


ms最后的方案就是这个了，

这个必须用，因为ddl中还有很多和user表相关联的表（django不能跨表关联，），

所以最合适的流程是这样的，remote_user登录，

这里还要处理一个事情，就是ddl表和ppy表的username重复的问题，简单的说，不允许有重复的，因为

首先</t>
<t tx="newlife.20110105104941.1273">首先：在ppy中必须有auth_user这个表，显然已经有了，
所以django还是很强大的，

Configuration
首先是配置：
@doc
First, you must add the django.contrib.auth.middleware.RemoteUserMiddleware to the MIDDLEWARE_CLASSES setting after the django.contrib.auth.middleware.AuthenticationMiddleware:

@code
MIDDLEWARE_CLASSES = (
    ...
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.RemoteUserMiddleware',
    ...
    )
@doc
Next, you must replace the ModelBackend with RemoteUserBackend in the AUTHENTICATION_BACKENDS setting:

@code
AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.RemoteUserBackend',
)

With this setup, RemoteUserMiddleware will detect the username in request.META['REMOTE_USER'] and will authenticate and auto-login that user using the RemoteUserBackend.

@doc
Note
Since the RemoteUserBackend inherits from ModelBackend, you will still have all of the same permissions checking that is implemented in ModelBackend.
If your authentication mechanism uses a custom HTTP header and not REMOTE_USER, you can subclass RemoteUserMiddleware and set the header attribute to the desired request.META key. For example:
@code
from django.contrib.auth.middleware import RemoteUserMiddleware

class CustomHeaderMiddleware(RemoteUserMiddleware):
    header = 'HTTP_AUTHUSER'
    
    
    
RemoteUserBackend
class django.contrib.auth.backends.RemoteUserBackend
If you need more control, you can create your own authentication backend that inherits from RemoteUserBackend and overrides certain parts:

Attributes
RemoteUserBackend.create_unknown_user
True or False. Determines whether or not a User object is created if not already in the database. Defaults to True.

Methods
RemoteUserBackend.clean_username(username)
Performs any cleaning on the username (e.g. stripping LDAP DN information) prior to using it to get or create a User object. Returns the cleaned username.

RemoteUserBackend.configure_user(user)
Configures a newly created user. This method is called immediately after a new user is created, and can be used to perform custom setup actions, such as setting the user`s groups based on attributes in an LDAP directory. Returns the user object.

</t>
<t tx="newlife.20110105104941.1274">class RemoteUserBackend(ModelBackend):
    """
    This backend is to be used in conjunction with the ``RemoteUserMiddleware``
    found in the middleware module of this package, and is used when the server
    is handling authentication outside of Django.

    By default, the ``authenticate`` method creates ``User`` objects for
    usernames that don't already exist in the database.  Subclasses can disable
    this behavior by setting the ``create_unknown_user`` attribute to
    ``False``.
    """

    # Create a User object if not already in the database?
    create_unknown_user = True

    def authenticate(self, username=None, password=None):
        try:
            user = User.objects.using("second").get(username=username)
            if user.check_password(password):
                return user
        except User.DoesNotExist:
            return None
    
    def clean_username(self, username):
        """
        Performs any cleaning on the "username" prior to using it to get or
        create the user object.  Returns the cleaned username.

        By default, returns the username unchanged.
        """
        return username

    def configure_user(self, user):
        """
        Configures a user after creation and returns the updated user.

        By default, returns the user unmodified.
        """
        return user</t>
<t tx="newlife.20110106110632.1280">最后决定只用一个库，

需要处理的就是登录和注册相关的问题


现在要做的是统计工作量的问题。

目前的系统中有哪些东西是和系统用户相关的，

</t>
<t tx="newlife.20110106110632.1281">#! /usr/bin/env python
#coding=utf-8
from django.contrib.auth.models import User, Permission

class ModelBackend(object):
    """
    Authenticates against django.contrib.auth.models.User.
    """
    supports_object_permissions = False
    supports_anonymous_user = True

    # TODO: Model, login attribute name and password attribute name should be
    # configurable.
    def authenticate(self, username=None, password=None):
        try:
            user = User.objects.using('second').get(username=username)
            if user.check_password(password):
                return user
        except User.DoesNotExist:
            return None

    def get_group_permissions(self, user_obj):
        """
        Returns a set of permission strings that this user has through his/her
        groups.
        """
        if not hasattr(user_obj, '_group_perm_cache'):
            if user_obj.is_superuser:
                perms = Permission.objects.all()
            else:
                perms = Permission.objects.using('second').filter(group__user=user_obj)
            perms = perms.values_list('content_type__app_label', 'codename').order_by()
            user_obj._group_perm_cache = set(["%s.%s" % (ct, name) for ct, name in perms])
        return user_obj._group_perm_cache

    def get_all_permissions(self, user_obj):
        if user_obj.is_anonymous():
            return set()
        if not hasattr(user_obj, '_perm_cache'):
            user_obj._perm_cache = set([u"%s.%s" % (p.content_type.app_label, p.codename) for p in user_obj.user_permissions.select_related()])
            user_obj._perm_cache.update(self.get_group_permissions(user_obj))
        return user_obj._perm_cache

    def has_perm(self, user_obj, perm):
        return perm in self.get_all_permissions(user_obj)

    def has_module_perms(self, user_obj, app_label):
        """
        Returns True if user_obj has any permissions in the given app_label.
        """
        for perm in self.get_all_permissions(user_obj):
            if perm[:perm.index('.')] == app_label:
                return True
        return False

    def get_user(self, user_id):
        try:
            return User.objects.using('second').get(pk=user_id)
        except User.DoesNotExist:
            return None
            
@doc
注意需要操作数据库的地方的[Model].objects.using('second')..
</t>
<t tx="newlife.20110106110632.1282">AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',
    'user.ppy_auth_backend.ModelBackend'
)
@doc

其实第一行的部分可以省略，因为不走ddl的认证部分。

my_object.save(using='legacy_users')</t>
<t tx="newlife.20110106110632.1283">注册的部分，
注册的用户直接写入ppy数据库，
</t>
<t tx="newlife.20110106110632.1285">@language python
@tabwidth -4
@others
@ignore


@doc

这个文件中需要处理的函数有，主要是有关注册的方法，修改使之将完成的数据写如ppy数据库。
$问题1，注册时填写的user_profile里的数据保存再哪里。
       最好还是保存在ppy数据库，因为从ppy来的用户，你不可能让用户再填写一次吧
       
@register

#line 46  user.save(using='second')
#line 51  profile.save(using='second')
@ajax_register

这个函数ms已经不用了。

@active_account

        user = User.objects.get(username=mail)
        user.save()


@basic_settings

            up.save()
</t>
<t tx="newlife.20110106110632.1287">def index(request):
    user_login(request)
    if request.user.is_authenticated():
        return HttpResponseRedirect('/play/')
    else:
        return render_to_response('users/index.html',{'media_url':settings.MEDIA_URL},
                                  context_instance=RequestContext(request))


</t>
<t tx="newlife.20110106110632.1288">def register(request):
    if request.method == 'GET':
        form = RegForm(initial={'inviter_email':request.GET.get('i')})
        data = {'form':form, 'media_url':settings.MEDIA_URL}
        return render_to_response('users/register.html',data,
                                  context_instance=RequestContext(request))
    else:
        form = RegForm(request.POST)
        data = {'form':form, 'media_url':settings.MEDIA_URL}

        if form.is_valid():
            if settings.DEBUG:
                user = User(username=form.cleaned_data['username'], is_active=True)
            else:
                user = User(username=form.cleaned_data['username'], is_active=False)
            user.set_password(form.cleaned_data['password1'])
            user.save()

            profile = UserProfile(user_id=user.id, nickname=form.cleaned_data['nickname'],
                                  true_name=form.cleaned_data['true_name'],
                                  identity_card_code=form.cleaned_data['identity_card_code'])
            profile.save()

            # 发送激活邮件
            if not settings.DEBUG:
                send_active_mail(user)
                common_mail = ['126.com', '163.com', 'sina.com', 'sohu.com', 'yahoo.com', 'qq.com']
                if user.username.split('@')[1].lower() in common_mail:
                    data['mail_login_url'] = 'mail.' + user.username.split('@')[1].lower()
                elif user.username.split('@')[1].lower() == 'hotmail.com':
                    data['mail_login_url'] = 'login.live.com'
                elif user.username.split('@')[1].lower() == 'gmail.com':
                    data['mail_login_url'] = 'mail.google.com'
                else:
                    data['mail_login_url'] = None
            return render_to_response('users/register_success.html', data,
                                      context_instance=RequestContext(request))
        else:
            return render_to_response('users/register.html', data,
                                      context_instance=RequestContext(request))


</t>
<t tx="newlife.20110106110632.1289">def ajax_register(request):
    if request.method == "POST":
        form = RegForm(request.POST)
        resp = {}
        if not form.is_valid():
            resp['status'] = 'error'
            for k,v in form.errors.items():
                resp[k] = v.as_text()
            return HttpResponse(simplejson.dumps(resp))
        resp['status'] = "success"
        return HttpResponse(simplejson.dumps(resp))




</t>
<t tx="newlife.20110106110632.1290">def active_account(request):
    mail = request.GET.get('mail', None)
    sig = request.GET.get('sig', None)
    try:
        user = User.objects.get(username=mail)
    except:
        raise Http404
    m = md5.new()
    u_sig = user.username.split('@')
    u_sig.insert(1, str(user.id))
    m.update(''.join(u_sig))
    confirm_sig = m.hexdigest()
    if sig == confirm_sig:
        user.is_active = True
        user.save()
        data = {'media_url':settings.MEDIA_URL}
        return render_to_response('users/active_account_success.html', data,
                                      context_instance=RequestContext(request))
    else:
        raise Http404


</t>
<t tx="newlife.20110106110632.1291">def user_login(request):
    data = {'media_url':settings.MEDIA_URL}
    if request.method == 'GET':
        form = AuthenticationForm()
        data['form'] = form
        return render_to_response('users/index.html',data, 
                                  context_instance=RequestContext(request))
    else:
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            login(request, form.get_user())
            if request.session.test_cookie_worked():
                request.session.delete_test_cookie()
            request.session.set_expiry(3600*12)
            return HttpResponseRedirect('/play/')
        else:
            user = form.get_user()
            if user and not user.is_active:
                # 重新发送激活邮件
                try:
                    send_active_mail(user)
                    common_mail = ['126.com', '163.com', 'sina.com', 'sohu.com', 'yahoo.com', 'qq.com']
                    if user.username.split('@')[1].lower() in common_mail:
                        data['mail_login_url'] = 'mail.' + user.username.split('@')[1].lower()
                    elif user.username.split('@')[1].lower() == 'hotmail.com':
                        data['mail_login_url'] = 'login.live.com'
                    elif user.username.split('@')[1].lower() == 'gmail.com':
                        data['mail_login_url'] = 'mail.google.com'
                    else:
                        data['mail_login_url'] = None
                except:
                    pass
                login(request, user)
                return render_to_response('users/account_not_active_failed.html',data, 
                                          context_instance=RequestContext(request))
            else:
                return render_to_response('users/login_failed.html',data, 
                                  context_instance=RequestContext(request))


</t>
<t tx="newlife.20110106110632.1292">def user_logout(request):
    if request.user.is_authenticated():
        logout(request)
    hr = HttpResponseRedirect('/')
    hr.delete_cookie('kx_connect_session_key', path='/', domain='.raytoon.cn')

    return hr


</t>
<t tx="newlife.20110106110632.1293">@login_required
def basic_settings(request):
    up = get_up(request.user.id)
    if request.method == 'GET':
        data = {'city':up.city, 
                'address':up.address, 
                'msn':up.msn, 
                'qq':up.qq, 
                'gtalk':up.gtalk, 
                'mobile':up.mobile, 
                'description':up.description
                }
        form = BasicForm(data)
        data = {'form':form,'media_url':settings.MEDIA_URL}
        return render_to_response('users/settings.html', data,
                                  context_instance=RequestContext(request))
    else:
        form = BasicForm(request.POST)
        if form.is_valid():
            up.city = request.POST['city']
            up.address = request.POST['address']
            up.msn = request.POST['msn']
            up.qq = request.POST['qq']
            up.gtalk = request.POST['gtalk']
            up.mobile = request.POST['mobile']
            up.description = request.POST['description']
            up.save()
            return HttpResponseRedirect('/users/basic_settings/')

</t>
<t tx="newlife.20110106110632.1294">@login_required
def account_settings(request):
    if request.method == 'GET':
        form = PasswordChangeForm(request.user)
        data = {'form':form, 'media_url':settings.MEDIA_URL}
        return render_to_response('users/change_password.html', data,
                                  context_instance=RequestContext(request))
    else:
        form = PasswordChangeForm(request.user,request.POST)
        if form.is_valid():
            form.save()
            data = {'info':'密码修改成功！', 'form':form, 'media_url':settings.MEDIA_URL}
            return render_to_response('users/change_password.html',data,
                                  context_instance=RequestContext(request))
        else:
            data = {'info':'密码修改失败！', 'form':form, 'media_url':settings.MEDIA_URL}
            return render_to_response('users/change_password.html',data,
                                  context_instance=RequestContext(request))

</t>
<t tx="newlife.20110106110632.1295">@login_required
def justforfun_settings(request):
    up = get_up(request.user.id)
    if request.method == 'GET':
        data = {'true_name':up.true_name, 
                'identity_card_code':up.identity_card_code, 
                }
        form = JustForFunForm(data)
        data = {'form':form, 'media_url':settings.MEDIA_URL}
        return render_to_response('users/just_for_fun.html', data,
                                  context_instance=RequestContext(request))
    else:
        form = JustForFunForm(request.POST)
        if form.is_valid():
            up.true_name = request.POST['true_name']
            up.identity_card_code = request.POST['identity_card_code']
            up.save()
            data = {'info':'防沉迷信息修改成功！', 'form':form, 'media_url':settings.MEDIA_URL}
            return render_to_response('users/just_for_fun.html',data,
                                  context_instance=RequestContext(request))
        else:
            data = {'info':'防沉迷信息修改失败！', 'form':form, 'media_url':settings.MEDIA_URL}
            return render_to_response('users/just_for_fun.html',data,
                                  context_instance=RequestContext(request))

</t>
<t tx="newlife.20110106110632.1296">def forgot_password(request):
    if request.method == 'GET':
        form = ForgotPasswordForm()
        data = {'form':form, 'media_url':settings.MEDIA_URL}
        return render_to_response('users/forgot_password.html', data,
                                  context_instance=RequestContext(request))
    else:
        form = ForgotPasswordForm(request.POST)
        data = {'form':form, 'media_url':settings.MEDIA_URL}
        if form.is_valid():
            user = User.objects.get(username=form.cleaned_data['username'])
            m = md5.new()
            u_sig = user.username.split('@')
            u_sig.insert(0, str(user.id))
            m.update(''.join(u_sig))
            sig = m.hexdigest()
            reset_url = "%s/users/reset_password/?mail=%s&amp;sig=%s" %(settings.SITE_URL, user.username, sig)
            # 发送重置密码邮件
            subject = "《泡泡鱼》游戏密码重置链接"
            t = loader.get_template('users/forgot_password_email.html')
            c = Context({
                    'nickname': get_up(user.id).nickname,
                    'reset_url':reset_url,
                })
            send_mail(subject, t.render(c), 'non-reply@mail.paopaoyu.cn', [user.username,])
            common_mail = ['126.com', '163.com', 'sina.com', 'sohu.com', 'yahoo.com', 'qq.com']
            if user.username.split('@')[1].lower() in common_mail:
                data['mail_login_url'] = 'mail.' + user.username.split('@')[1].lower()
            elif user.username.split('@')[1].lower() == 'hotmail.com':
                data['mail_login_url'] = 'login.live.com'
            elif user.username.split('@')[1].lower() == 'gmail.com':
                data['mail_login_url'] = 'mail.google.com'
            else:
                data['mail_login_url'] = None
            return render_to_response('users/reset_password.html', data,
                                      context_instance=RequestContext(request))
        else:
            return render_to_response('users/forgot_password.html', data,
                                      context_instance=RequestContext(request))


</t>
<t tx="newlife.20110106110632.1297">def reset_password(request):
    mail = request.GET.get('mail', None)
    sig = request.GET.get('sig', None)
    try:
        user = User.objects.get(username=mail)
    except:
        raise Http404
    m = md5.new()
    u_sig = user.username.split('@')
    u_sig.insert(0, str(user.id))
    m.update(''.join(u_sig))
    confirm_sig = m.hexdigest()
    if sig == confirm_sig:
        new_password = User.objects.make_random_password(8)
        user.set_password(new_password)
        user.save()
        # 发送重置密码邮件
        subject = "《蛋蛋龙》游戏密码重置"
        t = loader.get_template('users/reset_password_email.html')
        c = Context({
                'nickname': get_up(user.id).nickname,
                'username': user.username,
                'new_password': new_password
            })
        send_mail(subject, t.render(c), 'non-reply@raytoon.com', [user.username,])
        common_mail = ['126.com', '163.com', 'sina.com', 'sohu.com', 'yahoo.com', 'qq.com']
        data = {'media_url':settings.MEDIA_URL}
        if user.username.split('@')[1].lower() in common_mail:
            data['mail_login_url'] = 'mail.' + user.username.split('@')[1].lower()
        elif user.username.split('@')[1].lower() == 'hotmail.com':
            data['mail_login_url'] = 'login.live.com'
        elif user.username.split('@')[1].lower() == 'gmail.com':
            data['mail_login_url'] = 'mail.google.com'
        else:
            data['mail_login_url'] = None
        return render_to_response('users/reset_password_success.html', data,
                                  context_instance=RequestContext(request))
    else:
        raise Http404

</t>
<t tx="newlife.20110106110632.1298">@login_required
def users_invite(request):
    invite_url = '%s/users/register/?i=%s' % (settings.SITE_URL, request.user.username)
    return render_to_response('users/invite.html', {'media_url':settings.MEDIA_URL, 'invite_url':invite_url},
                                  context_instance=RequestContext(request))


</t>
<t tx="newlife.20110106110632.1299">def disableUserAMF(request, mem_id):
    member = get_member(int(mem_id))
    up = get_up(member.sns_id)
    up.disabled_time = datetime.now()
    up.save()
</t>
<t tx="newlife.20110106110632.1300"></t>
<t tx="newlife.20110106110632.1301">关于ddl的user模块的user_profile这个model，
class Meta:
    db_table = 'ppy_userprofile'
    
但是再ppy这个项目中是没有这一项的

造成的后果就是

同是这个表，在不同的数据库里名字是不一样的，

做法就是。ddl中这行去了！
</t>
<t tx="newlife.20110106110632.1302">关于ddl的user模块的user_profile这个model，
class Meta:
    db_table = 'ppy_userprofile'
    
但是再ppy这个项目中是没有这一项的

造成的后果就是

同是这个表，在不同的数据库里名字是不一样的，

做法就是。ddl中这行去了！
</t>
</tnodes>
</leo_file>
