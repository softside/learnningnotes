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
<v t="zhanglei.20100902183546.1245"><vh>@chapters</vh></v>
<v t="zhanglei.20100902183546.1247" a="E"><vh>custom_admin</vh>
<v t="zhanglei.20100902183546.1248"><vh>@file /home/zhanglei/project/project/game_platform/src/custom_admin.py</vh>
<v t="zhanglei.20100902183546.1249"><vh>custom_admin declarations</vh></v>
<v t="zhanglei.20100902183546.1250"><vh>class HjAdminSite</vh>
<v t="zhanglei.20100902183546.1251"><vh>login</vh></v>
<v t="zhanglei.20100902183546.1252"><vh>register</vh></v>
</v>
<v t="zhanglei.20100902183546.1253"><vh>class Hj8ModelAdmin</vh>
<v t="zhanglei.20100902183546.1254"><vh>formfield_for_dbfield</vh></v>
</v>
</v>
<v t="zhanglei.20100902183546.1255"><vh>介绍：</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="zhanglei.20100902183546.1245"></t>
<t tx="zhanglei.20100902183546.1247"></t>
<t tx="zhanglei.20100902183546.1248">@language python
@tabwidth -4
@others
@ignore

ModelAdmin = Hj8ModelAdmin
site = HjAdminSite()
autodiscover = admin.autodiscover




</t>
<t tx="zhanglei.20100902183546.1249">from django.contrib import admin
from django import http
from django.contrib.auth.models import User
from django.views.decorators.cache import never_cache
from django.contrib.auth import authenticate, login
from django.db.models.fields.related import ForeignKey
from django.utils.translation import ugettext_lazy, ugettext as _
from django.forms.widgets import TextInput

ERROR_MESSAGE = ugettext_lazy("Please enter a correct username/email and password. Note that both fields are case-sensitive.")

</t>
<t tx="zhanglei.20100902183546.1250">class HjAdminSite(admin.AdminSite):
    @others
</t>
<t tx="zhanglei.20100902183546.1251">def login(self, request):
    """
    Displays the login form for the given HttpRequest.
    """
    from django.contrib.auth.models import User

    # If this isn't already the login page, display it.
    if not request.POST.has_key(admin.sites.LOGIN_FORM_KEY):
        if request.POST:
            message = _("Please log in again, because your session has expired.")
        else:
            message = ""
        return self.display_login_form(request, message)

    # Check that the user accepts cookies.
    if not request.session.test_cookie_worked():
        message = _("Looks like your browser isn't configured to accept cookies. Please enable cookies, reload this page, and try again.")
        return self.display_login_form(request, message)
    else:
        request.session.delete_test_cookie()

    # Check the password.
    username = request.POST.get('username', None)
    password = request.POST.get('password', None)
    user = authenticate(username=username, password=password)
    if user is None:
        if username is not None and u'@' in username:
            user = authenticate(email=username, password=password)
    if user:
        # The user data is correct; log in the user in and continue.
        if user.is_active and user.is_staff:
            login(request, user)
            return http.HttpResponseRedirect(request.get_full_path())
        else:
            return self.display_login_form(request, ERROR_MESSAGE)
    else:
        message = ERROR_MESSAGE
        return self.display_login_form(request, message)

</t>
<t tx="zhanglei.20100902183546.1252">login = never_cache(login)

def register(self, model_or_iterable, admin_class=None, **options):
    if admin_class is None:
        admin_class = Hj8ModelAdmin
    return super(HjAdminSite, self).register(model_or_iterable,
                                             admin_class=admin_class,
                                             **options)
</t>
<t tx="zhanglei.20100902183546.1253">class Hj8ModelAdmin(admin.ModelAdmin):
    @others
</t>
<t tx="zhanglei.20100902183546.1254">def formfield_for_dbfield(self, db_field, **kwargs):
    if isinstance(db_field, ForeignKey) and db_field.rel.to == User:
        kwargs['widget'] = TextInput() #UserSelectWidget()
    return super(Hj8ModelAdmin, self).formfield_for_dbfield(db_field, **kwargs)

</t>
<t tx="zhanglei.20100902183546.1255">这个是研究django的admin的一部分，具体的功能是显示某个model的某条数据时，
如果显示的项是ForeignKey,并且这个ForeignKey链接的是User这个modle，
可以显示一个文本框UserSelectWidget()，而不是一个下拉列表AdminRadioSelect</t>
</tnodes>
</leo_file>
