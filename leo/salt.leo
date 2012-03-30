<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo (http://webpages.charter.net/edreamleo/front.html) -->
<?xml-stylesheet ekr_test?>
<leo_file xmlns:leo="http://www.leo-editor.org/2011/leo" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="newlife.20120222162657.1136"><vh>1288</vh></v>
<v t="newlife.20120214021616.1126" a="E"><vh>introduce</vh>
<v t="newlife.20120214021616.1127"><vh>install&amp;&amp;config</vh></v>
<v t="newlife.20120219231843.1129"><vh>sample master config file</vh></v>
<v t="newlife.20120219231843.1130"><vh>sample minon config file</vh></v>
<v t="newlife.20120222162657.1135"><vh>结论</vh></v>
</v>
<v t="newlife.20120222162657.1133" a="E"><vh>status management</vh>
<v t="newlife.20120222162657.1134"><vh> begin</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20120214021616.1126">https://github.com/saltstack/salt  项目地址

http://saltstack.org/  官方网站（放在github）

这个东西ms是进行配置文件管理的，放狗半天，没有搜到任何有意义的信息，加入group，粗略浏览http://groups.google.com/group/salt-users也没看见什么令人兴奋的东西。


http://readthedocs.org/docs/salt/en/latest/ref/configuration/examples/</t>
<t tx="newlife.20120214021616.1127">install
现在mac上装0.95的版本，其实已经有0.96，这两个版本的差异还没仔细看，但是最近的更新都是一个月以前的，看来都有维护，而且官方文档是基于0.95的，

安装么有任何问题，没有发现依赖事情

依赖如下：
Python 2.6
ZeroMQ &gt;= 2.1.9
pyzmq &gt;= 2.1.9 — ZeroMQ Python bindings
M2Crypto — Python OpenSSL wrapper
PyCrypto — The Python cryptography toolkit
YAML — Python YAML bindings
Optional Dependencies:
    

Jinja2 — parsing Salt States (other renderers can be used via the renderer setting).
gcc — dynamic Cython module compiling

这个ZeroMQ（http://www.zeromq.org/）是c++写的，ms有点远啊，，简单看一下吧，

安装这个东西，，各种坑爹啊，，

</t>
<t tx="newlife.20120219231843.1129">/etc/init.d/nginx -s reloadhttp://readthedocs.org/docs/salt/en/latest/ref/configuration/examples/
Example master configuration file

# DO NOT MODIFY THIS FILE.  Copy it to: /etc/salt/master
##### Primary configuration settings #####
##########################################
# The address of the interface to bind to
#interface: 0.0.0.0

# The port used by the publisher
#publish_port: 4505

# The user to run salt
#user: root

# The number of worker threads to start, these threads are used to manage
# return calls made from minions to the master, if the master seems to be
# running slowly, increase the number of threads
#worker_threads: 5

# The port used by the communication interface
#ret_port: 4506

# The root directory prepended to these options: pki_dir, cachedir,
# sock_dir, log_file.
#root_dir: /

# Directory used to store public key data
#pki_dir: /etc/salt/pki

# Directory to store job and cache data
#cachedir: /var/cache/salt

# Set the number of hours to keep old job information
#keep_jobs: 24

# Set the default timeout for the salt command and api, the default is 5
# seconds
#timeout: 5

# Set the directory used to hold unix sockets
#sock_dir: /tmp/salt-unix

# Set the acceptance level for serialization of messages. This should only be
# set if the master is newer than 0.9.5 and the minion are older. This option
# allows a 0.9.5 and newer master to communicate with minions 0.9.4 and
# earlier. It is not recommended to keep this setting on if the minions are
# all 0.9.5 or higher, as leaving pickle as the serialization medium is slow
# and opens up security risks
#
#serial: msgpack

#####        Security settings       #####
##########################################
# Enable "open mode", this mode still maintains encryption, but turns off
# authentication, this is only intended for highly secure environments or for
# the situation where your keys end up in a bad state. If you run in open mode
# you do so at your own risk!
#open_mode: False

# Enable auto_accept, this setting will automatically accept all incoming
# public keys from the minions. Note that this is insecure.
#auto_accept: False

#####      State System settings     #####
##########################################
# The state system uses a "top" file to tell the minions what environment to
# use and what modules to use. The state_top file is defined relative to the
# root of the base environment.
#state_top: top.sls
#
# The external_nodes option allows Salt to gather data that would normally be
# placed in a top file. The external_nodes option is the executable that will
# return the ENC data. Remember that Salt will look for external nodes AND top
# files and combine the results if both are enabled!
#external_nodes: None
#
# The renderer to use on the minions to render the state data
#renderer: yaml_jinja
#
# The failhard option tells the minions to stop immediately after the first
# failure detected in the state execution, defaults to False
#failhard: False

#####      File Server settings      #####
##########################################
# Salt runs a lightweight file server written in zeromq to deliver files to
# minions. This file server is built into the master daemon and does not
# require a dedicated port.

# The file server works on environments passed to the master, each environment
# can have multiple root directories, the subdirectories in the multiple file
# roots cannot match, otherwise the downloaded files will not be able to be
# reliably ensured. A base environment is required to house the top file.
# Example:
# file_roots:
#   base:
#     - /srv/salt/
#   dev:
#     - /srv/salt/dev/services
#     - /srv/salt/dev/states
#   prod:
#     - /srv/salt/prod/services
#     - /srv/salt/prod/states
#
# Default:
#file_roots:
#  base:
#    - /srv/salt

# The hash_type is the hash to use when discovering the hash of a file on
# the master server, the default is md5, but sha1, sha224, sha256, sha384
# and sha512 are also supported.
#hash_type: md5

# The buffer size in the file server can be adjusted here:
#file_buffer_size: 1048576

#####          Syndic settings       #####
##########################################
# The Salt syndic is used to pass commands through a master from a higher
# master. Using the syndic is simple, if this is a master that will have
# syndic servers(s) below it set the "order_masters" setting to True, if this
# is a master that will be running a syndic daemon for passthrough the
# "syndic_master" setting needs to be set to the location of the master server
# to recieve commands from.
#
# Set the order_masters setting to True if this master will command lower
# masters' syndic interfaces.
#order_masters: False
#
# If this master will be running a salt syndic daemon, syndic_master tells
# this master where to recieve commands from.
#syndic_master: masterofmaster

#####      Peer Publish settings     #####
##########################################
# Salt minions can send commands to other minions, but only if the minion is
# allowed to. By default "Peer Publication" is disabled, and when enabled it
# is enabled for specific minions and specific commands. This allows secure
# compartmentalization of commands based on individual minions.
#
# The configuration uses regular expressions to match minions and then a list
# of regular expressions to match functions. The following will allow the
# minion authenticated as foo.example.com to execute functions from the test
# and pkg modules.
# peer:
#   foo.example.com:
#       - test.*
#       - pkg.*
#
# This will allow all minions to execute all commands:
# peer:
#   .*:
#       - .*
# This is not recomanded, since it would allow anyone who gets root on any
# single minion to instantly have root on all of the minions!
#

#####         Cluster settings       #####
##########################################
# Salt supports automatic clustering, salt creates a single ip address which
# is shared among the individual salt components using ucarp. The private key
# and all of the minion keys are maintained across the defined cluster masters.
# The failover service is automatically managed via these settings

# List the identifiers for the other cluster masters in this manner:
# [saltmaster-01.foo.com,saltmaster-02.foo.com,saltmaster-03.foo.com]
# The members of this master array must be running as salt minions to
# facilitate the distribution of cluster information
#cluster_masters: []

# The cluster modes are "paranoid" and "full"
# paranoid will only distribute the accepted minion public keys.
# full will also distribute the master private key.
#cluster_mode: paranoid


#####         Logging settings       #####
##########################################
# The location of the master log file
#log_file: /var/log/salt/master
#
# The level of messages to send to the log file.
# One of 'info', 'quiet', 'critical', 'error', 'debug', 'warning'.
# Default: 'warning'
#log_level: warning
#
# Logger levels can be used to tweak specific loggers logging levels.
# For example, if you want to have the salt library at the 'warning' level,
# but you still wish to have 'salt.modules' at the 'debug' level:
#   log_granular_levels:
#     'salt': 'warning',
#     'salt.modules': 'debug'
#
#log_granular_levels: {}


#####         Node Groups           #####
##########################################
# Node groups allow for logical groupings of minion nodes.
# A group consists of a group name and a compound target.
#
# nodegroups:
#   group1: 'L@foo.domain.com,bar.domain.com,baz.domain.com and bl*.domain.com',
#   group2: 'G@os:Debian and foo.domain.com',
</t>
<t tx="newlife.20120219231843.1130"># DO NOT MODIFY THIS FILE.  Copy it to: /etc/salt/minion
##### Primary configuration settings #####
##########################################
# Set the location of the salt master server, if the master server cannot be
# resolved, then the minion will fail to start.
#master: salt

# Set the port used by the master reply and authentication server
#master_port: 4506

# The user to run salt
#user: root

# The root directory prepended to these options: pki_dir, cachedir, log_file.
#root_dir: /

# The directory to store the pki information in
#pki_dir: /etc/salt/pki

# Explicitly declare the id for this minion to use, if left commented the id
# will be the hostname as returned by the python call: socket.getfqdn()
# Since salt uses detached ids it is possible to run multiple minions on the
# same machine but with different ids, this can be useful for salt compute
# clusters.
#id:

# If the the connection to the server is interrupted, the minion will
# attempt to reconnect. sub_timeout allows you to control the rate
# of reconnection attempts (in seconds). To disable reconnects, set
# this value to 0.
#sub_timeout: 60

# Where cache data goes
#cachedir: /var/cache/salt

# The minion can locally cache the return data from jobs sent to it, this
# can be a good way to keep track of jobs the minion has executed
# (on the minion side). By default this feature is disabled, to enable
# set cache_jobs to True
#cache_jobs: False

# When waiting for a master to accept the minion's public key, salt will
# continuously attempt to reconnect until successful. This is the time, in
# seconds, between those reconnection attempts.
#acceptance_wait_time = 10



#####   Minion module management     #####
##########################################
# Disable specific modules. This allows the admin to limit the level of
# access the master has to the minion
#disable_modules: [cmd,test]
#disable_returners: []
#
# Modules can be loaded from arbitrary paths. This enables the easy deployment
# of third party modules. Modules for returners and minions can be loaded.
# Specify a list of extra directories to search for minion modules and
# returners. These paths must be fully qualified!
#module_dirs: []
#returner_dirs: []
#states_dirs: []
#render_dirs: []
#
# Enable Cython modules searching and loading. (Default: False)
#cython_enable: False

#####    State Management Settings    #####
###########################################
# The state management system executes all of the state templates on the minion
# to enable more granular control of system state management. The type of
# template and serialization used for state management needs to be configured
# on the minion, the default renderer is yaml_jinja. This is a yaml file
# rendered from a jinja template, the available options are:
# yaml_jinja
# yaml_mako
# json_jinja
# json_mako
#
#renderer: yaml_jinja
#
# state_verbose allows for the data returned from the minion to be more
# verbose. Normaly only states that fail or states that have changes are
# returned, but setting state_verbose to True will return all states that
# were checked
#state_verbose: False
#
# autoload_dynamic_modules Turns on automatic loading of modules found in the
# environments on the master. This is turned on by default, to turn of
# autoloading modules when states run set this value to False
#autoload_dynamic_modules: True
#
# clean_dynamic_modules keeps the dynamic modules on the minion in sync with
# the dynamic modules on the master, this means that if a dynamic module is
# not on the master it will be deleted from the minion. By default this is
# enabled and can be disabled by changing this value to False
#clean_dynamic_modules: True
#
# Normally the minion is not isolated to any single environment on the master
# when running states, but the environment can be isolated on the minion side
# by statically setting it. Remember that the recommended way to manage
# environments is to issolate via the top file.
#environment: None

######        Security settings       #####
###########################################
# Enable "open mode", this mode still maintains encryption, but turns off
# authentication, this is only intended for highly secure environments or for
# the situation where your keys end up in a bad state. If you run in open mode
# you do so at your own risk!
#open_mode: False


######         Thread settings        #####
###########################################
# Disable multiprocessing support, by default when a minion receives a
# publication a new process is spawned and the command is executed therein.
#multiprocessing: True

######         Logging settings       #####
###########################################
# The location of the minion log file
#log_file: /var/log/salt/minion
#
# The level of messages to send to the log file.
# One of 'info', 'quiet', 'critical', 'error', 'debug', 'warning'.
# Default: 'warning'
#log_level: warning
#
# Logger levels can be used to tweak specific loggers logging levels.
# For example, if you want to have the salt library at the 'warning' level,
# but you still wish to have 'salt.modules' at the 'debug' level:
#   log_granular_levels: {
#     'salt': 'warning',
#     'salt.modules': 'debug'
#   }
#
#log_granular_levels: {}

######      Module configuration      #####
###########################################
# Salt allows for modules to be passed arbitrary configuration data, any data
# passed here in valid yaml format will be passed on to the salt minion modules
# for use. It is STRONGLY recommended that a naming convention be used in which
# the module name is followed by a . and then the value. Also, all top level
# data must be applied via the yaml dict construct, some examples:
#
# A simple value for the test module:
#test.foo: foo
#
# A list for the test module:
#test.bar: [baz,quo]
#
# A dict for the test module:
#test.baz: {spam: sausage, cheese: bread}</t>
<t tx="newlife.20120222162657.1133"></t>
<t tx="newlife.20120222162657.1134">

States

这篇教程的目的就是向你演示可以多么迅速的用salt来配置一个系统.更详细的关于state系统的信息请查阅文档.

下面将演示如何用salt来配置一个minion来运行apache并且确认这个服务器在运行.

Setting up the Salt State Tree

设置salt state树,

states是以文本的方式存储在master上,然后通过master的file server来分发给minions的.这个状态文件的集合就是 state tree.

要想使用salt的state system,需要先配置文件服务器,在master的配置文件里设置(file_roots)就是取消以下各行的注释,
    file_roots:
      base:
          - /srv/salt
          
修改配置文件,需要重启服务;
    % pkill salt-master
    % salt-master -d
    
准备topfile
在我们前面指定的目录下(/srv/salt),创建一个新的文件,命名top.sls,加入以下几行:
        base:
            '*':
               - webserver

这个top.sls被分割为不同的环境(一会详细讨论,)默认的环境是base,在base下面,一组被匹配的minion被定义了,现在简单的指定所有的主机
    目标minion:
            这个表达式可以用salt的各种匹配机制,glob,pcre regular expressions, or by grains 
            base:
                  'os:Fedora':
                      - match: grain
                      - webserver
                      
创建sls module

在top file的同级目录下创建空文件,命名为webserver.sls,输入以下内容:
        apache:                 # ID declaration
           pkg:                  # state declaration
                - installed         # function declaration           
  第一行,称为id声明,是手工指定的,这里,定义了要被安装的package的名字 .注意:apache在不同的os或者分发版本上有不同的名字,举个栗子,fedora是httpd,debain/ubuntu上是apche2  .

另外,id声明不应该包含dot (.),因为在被state.highstate调用的时候会产生不可预测的输出,       

第二行,称为state声明,定义了那个states我们在使用.在这个例子里,我们使用的是pkg state来确定指定的package被安装了
第三行,称为函数声明,定义了pkg state这个module调用哪个fuction
 
  这个sls文件可以用多种格式编写,salt需要的这是简单的数据结果,并且不关系这个数据结构是如何构建的,
  
  创建需要的数据结构是salt renderers的任务,这个写起来是相当的简单啊(怎么简单,还没看见怎么写呢,,)
  这个教程里我们使用的yaml和jinja作为默认的格式,这个可以在master的配置文件              
       
                      
安装包

 接下来,执行我们创建的state,打开终端,执行;
    % salt '*' state.highstate
                      
master通知所有的目标minion执行state.highstate命令.当一个minion执行highstate的时候,首先从master上下载topfile,然后试图匹配表达式,确认匹配上后,列出的modules会被下载,编译,执行

结束后,这个minnion会报告一个所有执行的操作和所作变更的总结.

    打开日志
        salt-minion -l debug  
                      
    salt '*' state.highstate -t 60  # On the master
    增加执行salt命令的超时时间.                  
                      
    
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      </t>
<t tx="newlife.20120222162657.1135">正如sample文件所描述的:生成的默认的master的配置文件并不需要做过多的配置,大部分的设置是在minion端的,
http://readthedocs.org/docs/salt/en/latest/topics/configuration.html
翻译:
配置salt
    salt的配置是十分简单的.master的默认配置在大部分的安装会很好的工作,而minion的配置只需要在minion的配置文件设置master的位置(ip或者hostname)

master
    salt的master是所有的minion连接的中心server.你通过master在minions上执行命令,mionon返回数据给master(除非你指定了returner),master用salt-master命令来启动

minion
    minion是你通过master查询或者控制的几百或者几千台服务器    

配置文件会安装在/etc/salt目录下,对应的/etc/salt/master 和/etc/salt/minion.

让一个minion连接msater只是简单的设置minion的配置文件的master变量,只想master的dns name或者ip地址

运行salt
    salt-master [-d 后台执行]
    salt-minion  [-d 后台执行]
    
    salt-master --log-level=debug,查看输出,不过这个输出可坑爹了,好歹聊胜于无吧    
     --user可以指定运行的用户,或者在配置文件声明

管理salt的公共key
  salt用rsa公共key来处理认证的问题.这些key是通过master上的salt-key命令来管理的,一旦一个minion入住master. master会保存这个key的副本(pki目录).如果master要想这个minion发送命令,这个key首先要被接受.
  
  salt-key -L 列出所有的key包括已接受的和未接受的
  salt-key -a &lt;minion id&gt; 这个minion id就是minion配置文件指定的那个,也就是上面的命令列出的
  salt-key -A 接受所有的key,
  
注:当我们启动master,修改minion配置文件指定master的name后者ip后,启动minion后.就可以在master上执行salt-key这个命令了.

Remote execution

salt '&lt;target&gt;' &lt;function&gt; [arguments]

salt '*' test.ping
salt '*.example.org' test.ping
Targets can be based on minion system information using the grains system:

salt -G 'os:Ubuntu' test.ping
Targets can be filtered by regular expression:

salt -E 'virtmach[0-9]' test.ping
Finally, targets can be explicitly specified in a list:

salt -L foo,bar,baz,quo test.ping

salt '*' sys.doc


salt '*' test.ping


salt '*' cmd.run 'uname -a'
以上命令在master执行,配置结束后即可








































</t>
<t tx="newlife.20120222162657.1136">修改文件后重启服务
    

修改创建文件的所有者
    salt-master --user
    salt-minion --user

对minion分组执行命令
    这个通过对minion设置id进行glob匹配实现</t>
</tnodes>
</leo_file>
