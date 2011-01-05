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
<v t="newlife.20110105104941.1271"><vh>关于remote_user</vh></v>
<v t="newlife.20110105104941.1270" a="E"><vh>备选方案</vh>
<v t="newlife.20110105104941.1273"><vh>先决条件</vh></v>
<v t="newlife.20110105104941.1274"><vh>custom_backend</vh></v>
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
<t tx="newlife.20110105104941.1271">    登录----》django验证------- ppy
               |           N 
               | Y
               |
              login </t>
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
</tnodes>
</leo_file>
