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
<v t="newlife.20101021104626.1288"><vh>@chapters</vh></v>
<v t="newlife.20101021104626.1287"><vh>Building Abstractions with Procedures</vh></v>
<v t="newlife.20101021104626.1289" a="E"><vh>django的密码机制</vh>
<v t="newlife.20101027175540.1249"><vh>密码生成</vh></v>
</v>
<v t="newlife.20101021104626.1290"><vh>django认证机制</vh></v>
</vnodes>
<tnodes>
<t tx="newlife.20101021104626.1287">The acts of the mind, wherein it exerts its power over simple ideas, are chiefly
these three: 
1. Combining several simple ideas into one compound one, and
thus all complex ideas are made. 
组合几个简单的想法到一个，这样一个复杂的想法产生了。

2. The second is bringing two ideas, whethersimple or complex, together, and setting them by one another so as to take a view of them at once, without uniting them into one, by which it gets all its ideas of  relations. 

把2个想法放在一起，

3. The third is separating them from all other ideas that accompany them in their real existence: this is called abstraction, and thus all its general ideas are made.


思维的行动，</t>
<t tx="newlife.20101021104626.1288"></t>
<t tx="newlife.20101021104626.1289">    def set_password(self, raw_password):
        import random
        algo = 'sha1'
        salt = get_hexdigest(algo, str(random.random()), str(random.random()))[:5]
        hsh = get_hexdigest(algo, salt, raw_password)
        self.password = '%s$%s$%s' % (algo, salt, hsh)
        
        
def get_hexdigest(algorithm, salt, raw_password):
    """
    Returns a string of the hexdigest of the given plaintext password and salt
    using the given algorithm ('md5', 'sha1' or 'crypt').
    """
    raw_password, salt = smart_str(raw_password), smart_str(salt)
    if algorithm == 'crypt':
        try:
            import crypt
        except ImportError:
            raise ValueError('"crypt" password algorithm not supported in this environment')
        return crypt.crypt(raw_password, salt)

    if algorithm == 'md5':
        return md5_constructor(salt + raw_password).hexdigest()
    elif algorithm == 'sha1':
        return sha_constructor(salt + raw_password).hexdigest()
    raise ValueError("Got unknown password algorithm type in password.")        </t>
<t tx="newlife.20101021104626.1290">def authenticate(self, username=None, password=None):
    try:
        user = User.objects.get(username=username)
        if user.check_password(password):#check_password()就在下面
            return user
    except User.DoesNotExist:
        return None
        
def check_password(self, raw_password):
    """
    Returns a boolean of whether the raw_password was correct. Handles
    encryption formats behind the scenes.
    """
    # Backwards-compatibility check. Older passwords won't include the
    # algorithm or salt.这个函数的作用就是兼容以前的版本，不对认证作处理
    if '$' not in self.password:#以前版本的密码中没有'$',并且是按md5加密处理的
        is_correct = (self.password == get_hexdigest('md5', '', raw_password)) #这个显然不等阿。。
        if is_correct:
            # Convert the password to the new, more secure format.
            self.set_password(raw_password)
            self.save()
        return is_correct
    return check_password(raw_password, self.password)

def check_password(raw_password, enc_password):
    """
    Returns a boolean of whether the raw_password was correct. Handles
    encryption formats behind the scenes.
    """
    algo, salt, hsh = enc_password.split('$')
    return hsh == get_hexdigest(algo, salt, raw_password)
#看上面的两个函数，注释都是一样的，orz。。虽然用户生成的密码有algo（算法），salt（盐），但是这些东西都是从现有用户的密码种取出的，没啥作用。
    
def get_hexdigest(algorithm, salt, raw_password):
    """
    Returns a string of the hexdigest of the given plaintext password and salt
    using the given algorithm ('md5', 'sha1' or 'crypt').
    """
    raw_password, salt = smart_str(raw_password), smart_str(salt)
    if algorithm == 'crypt':
        try:
            import crypt
        except ImportError:
            raise ValueError('"crypt" password algorithm not supported in this environment')
        return crypt.crypt(raw_password, salt)

    if algorithm == 'md5':
        return md5_constructor(salt + raw_password).hexdigest()
    elif algorithm == 'sha1':
        return sha_constructor(salt + raw_password).hexdigest()#现在的版本都是用的sha1加密的。
    raise ValueError("Got unknown password algorithm type in password.")
    
    
    现在，，描述下整个流程，用户已注册：
    首先，处理的函数是authenticate()————&gt;user.check_password()——————&gt;check_password()——————&gt;get_hexdigest()
    
    
    
    
    
    
    
    
    
    </t>
<t tx="newlife.20101027175540.1249">#/django/contrib/auth

from django.utils.hashcompat import md5_constructor, sha_constructor

def get_hexdigest(algorithm, salt, raw_password):
    """
    Returns a string of the hexdigest of the given plaintext password and salt
    using the given algorithm ('md5', 'sha1' or 'crypt').
    """
    raw_password, salt = smart_str(raw_password), smart_str(salt)
    if algorithm == 'crypt':
        try:
            import crypt
        except ImportError:
            raise ValueError('"crypt" password algorithm not supported in this environment')
        return crypt.crypt(raw_password, salt)

    if algorithm == 'md5':
        return md5_constructor(salt + raw_password).hexdigest()
    elif algorithm == 'sha1':
        return sha_constructor(salt + raw_password).hexdigest()
    raise ValueError("Got unknown password algorithm type in password.")
    最近的都是基于sha1的，所以我们要分析的就是sha_constructor(salt + raw_password).hexdigest()
    
    这个sha_constructor就是接收一个string参数，生成一段密码。   
 
这个就是django.utils.hashcompat的全部内容，只是简单的导入。
try:
    import hashlib
    md5_constructor = hashlib.md5
    md5_hmac = md5_constructor
    sha_constructor = hashlib.sha1
    sha_hmac = sha_constructor
except ImportError:
    import md5
    md5_constructor = md5.new
    md5_hmac = md5
    import sha
    sha_constructor = sha.new
    sha_hmac = sha
</t>
</tnodes>
</leo_file>
