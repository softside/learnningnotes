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
<v t="newlife.20120214021616.1126"><vh>introduce</vh></v>
<v t="newlife.20120214021616.1127"><vh>install&amp;&amp;config</vh></v>
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

http://readthedocs.org/docs/salt/en/latest/ref/configuration/examples/
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
</tnodes>
</leo_file>
