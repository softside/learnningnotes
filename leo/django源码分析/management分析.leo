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
<v t="newlife.20110825014822.1279" a="E"><vh>__init__.py</vh>
<v t="newlife.20110825014822.1280"><vh>management_init declarations</vh></v>
<v t="newlife.20110825014822.1281"><vh>find_commands</vh></v>
<v t="newlife.20110825014822.1282"><vh>find_management_module</vh></v>
<v t="newlife.20110825014822.1283"><vh>load_command_class</vh></v>
<v t="newlife.20110825014822.1284"><vh>get_commands</vh></v>
<v t="newlife.20110825014822.1285"><vh>call_command</vh></v>
<v t="newlife.20110825014822.1286"><vh>class LaxOptionParser</vh>
<v t="newlife.20110825014822.1287"><vh>error</vh></v>
<v t="newlife.20110825014822.1288"><vh>print_help</vh></v>
<v t="newlife.20110825014822.1289"><vh>print_lax_help</vh></v>
<v t="newlife.20110825014822.1290"><vh>_process_args</vh></v>
</v>
<v t="newlife.20110825014822.1291" a="E"><vh>class ManagementUtility</vh>
<v t="newlife.20110825014822.1292"><vh>__init__</vh></v>
<v t="newlife.20110825014822.1293"><vh>main_help_text</vh></v>
<v t="newlife.20110825014822.1294"><vh>fetch_command</vh></v>
<v t="newlife.20110825014822.1295"><vh>autocomplete</vh></v>
<v t="newlife.20110825014822.1296"><vh>execute</vh></v>
</v>
<v t="newlife.20110825014822.1297"><vh>setup_environ</vh></v>
<v t="newlife.20110825014822.1298"><vh>execute_from_command_line</vh></v>
<v t="newlife.20110825014822.1299"><vh>execute_manager</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="newlife.20110825014822.1279">我们学习django的时候，第一步要执行一个命令django-admin.py startproject mysite，用这个命令来创建我们的项目。
下面就是对这个命令是如何执行所做的跟踪分析。
#!/usr/bin/python
from django.core import management

if __name__ == "__main__":
    management.execute_from_command_line()

django-admin.py这个文件很简单就是执行上面的这一句，我们来看下management是个什么东西。

我们观察这个文件引用的函数库，除了django自身的这些东西，还用到了optparse这个东西（注：这个东西在2.7的时候就不建议使用乐，The"argparse"
 module was added to Python 2.7 as a replacement for "optparse" ）.另外还有imp这个包，
 
 纵观整个执行过程，这是一个单独的命令，我们可以看到为了获得良好的扩展性，django都做些什么，
 
　self.fetch_command(subcommand).run_from_argv(self.argv)

我们排除一些类似"help", "version"等，其实真正工作的就是上面这句。

这个subcommand就是前面的LaxOptionParser这个类做的事情，这个东西就是接受参数的，无论其如何强大也就是一个接收参数的东西，最后得出我们要的这个值，就是我们输入的django-admin.py后面的东西。

fetch_command是ManagementUtility的一个函数，在这个函数中，调用了get_commands()这个函数，
    try:
        app_name = get_commands()[subcommand]
    except KeyError:
        sys.stderr.write("Unknown command: %r\nType '%s help' for usage.\n" % \
            (subcommand, self.prog_name))
        sys.exit(1)
    if isinstance(app_name, BaseCommand):
        # If the command is already loaded, use it directly.
        klass = app_name
    else:
        klass = load_command_class(app_name, subcommand)
    return klass


下面介绍get_commands这个函数，

    _commands = dict([(name, 'django.core') for name in find_commands(__path__[0])])
    这行是处理的django自带的那写命令，我们app中自己定制的不在此列
    
    这里说下__path__这个变量，这个变量只可以在package的__init__.py中使用，得出的值是当前包的路径，在我的机器上就是['/Users/newlife/basic_bbs/django/core/management']，这个值是一个list，取它的第一项，就是django的management包的路径。

然后继续看find_commands这个函数，
def find_commands(management_dir):
    """
    Given a path to a management directory, returns a list of all the command
    names that are available.
    Returns an empty list if no commands are defined.
  
    """
    command_dir = os.path.join(management_dir, 'commands')
    try:
        return [f[:-3] for f in os.listdir(command_dir)
                if not f.startswith('_') and f.endswith('.py')]
    except OSError:
        return []
        
这个相对就简单的多乐，就是找到某个目录下所又可用的command,
找到management下的commands目录，列出其中所有的不以"_"开头的　".py"文件名，然后去掉末尾的".py"，得出所有可用的命令。回到get_commands，返回的是一个dict，key是命令名，对应的值都一样都是'django.core'

现在回到fetch_command函数，
得到的app_name就是'django.core',这行我提交一个ticket（16695）。
然后就是klass = load_command_class(app_name, subcommand)，得到具体的函数对象，这个对象一定是BaseCommand的子类，执行这个类的run_from_argv()方法。

关于BaseCommand的子类如何实现各种命令是下一步的事情。

    
    
    
    
    
    
    
    
    
    
    
    
    </t>
<t tx="newlife.20110825014822.1280">import os
import sys
from optparse import OptionParser, NO_DEFAULT
import imp

import django
from django.core.management.base import BaseCommand, CommandError, handle_default_options
from django.utils.importlib import import_module

# For backwards compatibility: get_version() used to be in this module.
get_version = django.get_version

# A cache of loaded commands, so that call_command
# doesn't have to reload every time it's called.
_commands = None

</t>
<t tx="newlife.20110825014822.1281">def find_commands(management_dir):
    """
    Given a path to a management directory, returns a list of all the command
    names that are available.

    Returns an empty list if no commands are defined.
    这个相对就简单的多乐，就是找到某个目录下所又可用的command,这就可以明显看出，正常的时候
    这个management_dir就是系统的和我们的某个app目录的manangement目录
    """
    command_dir = os.path.join(management_dir, 'commands')
    try:
        return [f[:-3] for f in os.listdir(command_dir)
                if not f.startswith('_') and f.endswith('.py')]
    except OSError:
        return []

</t>
<t tx="newlife.20110825014822.1282">def find_management_module(app_name):
    """
    Determines the path to the management module for the given app_name,
    without actually importing the application or the management module.

    Raises ImportError if the management module cannot be found for any reason.
    """
    parts = app_name.split('.')
    parts.append('management')
    parts.reverse()
    part = parts.pop()
    path = None

    # When using manage.py, the project module is added to the path,
    # loaded, then removed from the path. This means that
    # testproject.testapp.models can be loaded in future, even if
    # testproject isn't in the path. When looking for the management
    # module, we need look for the case where the project name is part
    # of the app_name but the project directory itself isn't on the path.
    try:
        f, path, descr = imp.find_module(part,path)
    except ImportError,e:
        if os.path.basename(os.getcwd()) != part:
            raise e

    while parts:
        part = parts.pop()
        f, path, descr = imp.find_module(part, path and [path] or None)
    return path

</t>
<t tx="newlife.20110825014822.1283">def load_command_class(app_name, name):
    """
    Given a command name and an application name, returns the Command
    class instance. All errors raised by the import process
    (ImportError, AttributeError) are allowed to propagate.
    """
    module = import_module('%s.management.commands.%s' % (app_name, name))
    return module.Command()

</t>
<t tx="newlife.20110825014822.1284">def get_commands():
    """
    Returns a dictionary mapping command names to their callback applications.
    返回一个字典，对应命令的名字和它的回调应用
    This works by looking for a management.commands package in django.core, and
    in each installed application -- if a commands package exists, all commands
    in that package are registered.他通过寻找management.commands这个包和其他在installed的apps

    Core commands are always included. If a settings module has been
    specified, user-defined commands will also be included, the
    startproject command will be disabled, and the startapp command
    will be modified to use the directory in which the settings module appears.

    The dictionary is in the format {command_name: app_name}. Key-value
    pairs from this dictionary can then be used in calls to
    load_command_class(app_name, command_name)

    If a specific version of a command must be loaded (e.g., with the
    startapp command), the instantiated module can be placed in the
    dictionary in place of the application name.

    The dictionary is cached on the first call and reused on subsequent
    calls.缓存在哪？？
    
    """
    global _commands
    if _commands is None:
        #这就是找到所有management包下的command,其他的都是枝节
        _commands = dict([(name, 'django.core') for name in find_commands(__path__[0])])
        
        # Find the installed apps找到所有的app
        try:
            from django.conf import settings
            apps = settings.INSTALLED_APPS
        except (AttributeError, EnvironmentError, ImportError):
            apps = []

        # Find the project directory
        try:
            from django.conf import settings
            module = import_module(settings.SETTINGS_MODULE)
            project_directory = setup_environ(module, settings.SETTINGS_MODULE)
        except (AttributeError, EnvironmentError, ImportError, KeyError):
            project_directory = None

        # Find and load the management module for each installed app.
        for app_name in apps:
            try:
                path = find_management_module(app_name)
                _commands.update(dict([(name, app_name)
                                       for name in find_commands(path)]))
            except ImportError:
                pass # No management module - ignore this app

        if project_directory:
            # Remove the "startproject" command from self.commands, because
            # that's a django-admin.py command, not a manage.py command.
            del _commands['startproject']

            # Override the startapp command so that it always uses the
            # project_directory, not the current working directory
            # (which is default).
            from django.core.management.commands.startapp import ProjectCommand
            _commands['startapp'] = ProjectCommand(project_directory)

    return _commands

</t>
<t tx="newlife.20110825014822.1285">def call_command(name, *args, **options):
    """
    Calls the given command, with the given options and args/kwargs.

    This is the primary API you should use for calling specific commands.

    Some examples:
        call_command('syncdb')
        call_command('shell', plain=True)
        call_command('sqlall', 'myapp')
    """
    # Load the command object.
    try:
        app_name = get_commands()[name]
        if isinstance(app_name, BaseCommand):
            # If the command is already loaded, use it directly.
            klass = app_name
        else:
            klass = load_command_class(app_name, name)
    except KeyError:
        raise CommandError("Unknown command: %r" % name)

    # Grab out a list of defaults from the options. optparse does this for us
    # when the script runs from the command line, but since call_command can
    # be called programatically, we need to simulate the loading and handling
    # of defaults (see #10080 for details).
    defaults = dict([(o.dest, o.default)
                     for o in klass.option_list
                     if o.default is not NO_DEFAULT])
    defaults.update(options)

    return klass.execute(*args, **defaults)

</t>
<t tx="newlife.20110825014822.1286">class LaxOptionParser(OptionParser):
    """
    An option parser that doesn't raise any errors on unknown options.
    这个东西就是接受参数的，无论其如何强大也就是一个接收参数的东西

    This is needed because the --settings and --pythonpath options affect
    the commands (and thus the options) that are available to the user.
    """
    @others
</t>
<t tx="newlife.20110825014822.1287">def error(self, msg):
    pass

</t>
<t tx="newlife.20110825014822.1288">def print_help(self):
    """Output nothing.

    The lax options are included in the normal option parser, so under
    normal usage, we don't need to print the lax options.
    """
    pass

</t>
<t tx="newlife.20110825014822.1289">def print_lax_help(self):
    """Output the basic options available to every command.

    This just redirects to the default print_help() behaviour.
    """
    OptionParser.print_help(self)

</t>
<t tx="newlife.20110825014822.1290">def _process_args(self, largs, rargs, values):
    """
    Overrides OptionParser._process_args to exclusively handle default
    options and ignore args and other options.

    This overrides the behavior of the super class, which stop parsing
    at the first unrecognized option.
    """
    while rargs:
        arg = rargs[0]
        try:
            if arg[0:2] == "--" and len(arg) &gt; 2:
                # process a single long option (possibly with value(s))
                # the superclass code pops the arg off rargs
                self._process_long_opt(rargs, values)
            elif arg[:1] == "-" and len(arg) &gt; 1:
                # process a cluster of short options (possibly with
                # value(s) for the last one only)
                # the superclass code pops the arg off rargs
                self._process_short_opts(rargs, values)
            else:
                # it's either a non-default option or an arg
                # either way, add it to the args list so we can keep
                # dealing with options
                del rargs[0]
                raise Exception
        except:
            largs.append(arg)

</t>
<t tx="newlife.20110825014822.1291">class ManagementUtility(object):
    """
    Encapsulates the logic of the django-admin.py and manage.py utilities.

    A ManagementUtility has a number of commands, which can be manipulated
    by editing the self.commands dictionary.
    """
    @others
</t>
<t tx="newlife.20110825014822.1292">
def __init__(self, argv=None):
    self.argv = argv or sys.argv[:]
    self.prog_name = os.path.basename(self.argv[0])

</t>
<t tx="newlife.20110825014822.1293">def main_help_text(self):
    """
    Returns the script's main help text, as a string.
    """
    usage = ['',"Type '%s help &lt;subcommand&gt;' for help on a specific subcommand." % self.prog_name,'']
    usage.append('Available subcommands:')
    commands = get_commands().keys()
    commands.sort()
    for cmd in commands:
        usage.append('  %s' % cmd)
    return '\n'.join(usage)

</t>
<t tx="newlife.20110825014822.1294">def fetch_command(self, subcommand):
    """
    Tries to fetch the given subcommand, printing a message with the
    appropriate command called from the command line (usually
    "django-admin.py" or "manage.py") if it can't be found.
    """
    try:
        app_name = get_commands()[subcommand]
    except KeyError:
        sys.stderr.write("Unknown command: %r\nType '%s help' for usage.\n" % \
            (subcommand, self.prog_name))
        sys.exit(1)
    if isinstance(app_name, BaseCommand):
        # If the command is already loaded, use it directly.
        klass = app_name
    else:
        klass = load_command_class(app_name, subcommand)
    return klass

</t>
<t tx="newlife.20110825014822.1295">def autocomplete(self):
    """
    Output completion suggestions for BASH.

    The output of this function is passed to BASH's `COMREPLY` variable and
    treated as completion suggestions. `COMREPLY` expects a space
    separated string as the result.

    The `COMP_WORDS` and `COMP_CWORD` BASH environment variables are used
    to get information about the cli input. Please refer to the BASH
    man-page for more information about this variables.

    Subcommand options are saved as pairs. A pair consists of
    the long option string (e.g. '--exclude') and a boolean
    value indicating if the option requires arguments. When printing to
    stdout, a equal sign is appended to options which require arguments.

    Note: If debugging this function, it is recommended to write the debug
    output in a separate file. Otherwise the debug output will be treated
    and formatted as potential completion suggestions.
    """
    # Don't complete if user hasn't sourced bash_completion file.
    if not os.environ.has_key('DJANGO_AUTO_COMPLETE'):
        return

    cwords = os.environ['COMP_WORDS'].split()[1:]
    cword = int(os.environ['COMP_CWORD'])

    try:
        curr = cwords[cword-1]
    except IndexError:
        curr = ''

    subcommands = get_commands().keys() + ['help']
    options = [('--help', None)]

    # subcommand
    if cword == 1:
        print ' '.join(sorted(filter(lambda x: x.startswith(curr), subcommands)))
    # subcommand options
    # special case: the 'help' subcommand has no options
    elif cwords[0] in subcommands and cwords[0] != 'help':
        subcommand_cls = self.fetch_command(cwords[0])
        # special case: 'runfcgi' stores additional options as
        # 'key=value' pairs
        if cwords[0] == 'runfcgi':
            from django.core.servers.fastcgi import FASTCGI_OPTIONS
            options += [(k, 1) for k in FASTCGI_OPTIONS]
        # special case: add the names of installed apps to options
        elif cwords[0] in ('dumpdata', 'reset', 'sql', 'sqlall',
                           'sqlclear', 'sqlcustom', 'sqlindexes',
                           'sqlreset', 'sqlsequencereset', 'test'):
            try:
                from django.conf import settings
                # Get the last part of the dotted path as the app name.
                options += [(a.split('.')[-1], 0) for a in settings.INSTALLED_APPS]
            except ImportError:
                # Fail silently if DJANGO_SETTINGS_MODULE isn't set. The
                # user will find out once they execute the command.
                pass
        options += [(s_opt.get_opt_string(), s_opt.nargs) for s_opt in
                    subcommand_cls.option_list]
        # filter out previously specified options from available options
        prev_opts = [x.split('=')[0] for x in cwords[1:cword-1]]
        options = filter(lambda (x, v): x not in prev_opts, options)

        # filter options by current input
        options = sorted([(k, v) for k, v in options if k.startswith(curr)])
        for option in options:
            opt_label = option[0]
            # append '=' to options which require args
            if option[1]:
                opt_label += '='
            print opt_label
    sys.exit(1)

</t>
<t tx="newlife.20110825014822.1296">def execute(self):
    """
    Given the command-line arguments, this figures out which subcommand is
    being run, creates a parser appropriate to that command, and runs it.
    """
    # Preprocess options to extract --settings and --pythonpath.
    # These options could affect the commands that are available, so they
    # must be processed early.
    parser = LaxOptionParser(usage="%prog subcommand [options] [args]",
                             version=get_version(),
                             option_list=BaseCommand.option_list)
    self.autocomplete()
    try:
        options, args = parser.parse_args(self.argv)
        handle_default_options(options)
    except:
        pass # Ignore any option errors at this point.

    try:
        subcommand = self.argv[1]
    except IndexError:
        subcommand = 'help' # Display help if no arguments were given.
    #取到确切的执行函数，赋值给变量subcommand

    if subcommand == 'help':
        #处理python manage.py help [command_name]的情况
        if len(args) &gt; 2:
            self.fetch_command(args[2]).print_help(self.prog_name, args[2])
        else:
            parser.print_lax_help()
            sys.stderr.write(self.main_help_text() + '\n')
            sys.exit(1)
    # Special-cases: We want 'django-admin.py --version' and
    # 'django-admin.py --help' to work, for backwards compatibility.
    elif self.argv[1:] == ['--version']:
        #处理"--version"的情况
        # LaxOptionParser already takes care of printing the version.
        pass
    elif self.argv[1:] in (['--help'], ['-h']):
        parser.print_lax_help()
        sys.stderr.write(self.main_help_text() + '\n')
    else:
        self.fetch_command(subcommand).run_from_argv(self.argv)
        #这是实际处理的大部分情况，

</t>
<t tx="newlife.20110825014822.1297">def setup_environ(settings_mod, original_settings_path=None):
    """
    Configures the runtime environment. This can also be used by external
    scripts wanting to set up a similar environment to manage.py.
    Returns the project directory (assuming the passed settings module is
    directly in the project directory).

    The "original_settings_path" parameter is optional, but recommended, since
    trying to work out the original path from the module can be problematic.
    """
    # Add this project to sys.path so that it's importable in the conventional
    # way. For example, if this file (manage.py) lives in a directory
    # "myproject", this code would add "/path/to/myproject" to sys.path.
    if '__init__.py' in settings_mod.__file__:
        p = os.path.dirname(settings_mod.__file__)
    else:
        p = settings_mod.__file__
    project_directory, settings_filename = os.path.split(p)
    if project_directory == os.curdir or not project_directory:
        project_directory = os.getcwd()
    project_name = os.path.basename(project_directory)

    # Strip filename suffix to get the module name.
    settings_name = os.path.splitext(settings_filename)[0]

    # Strip $py for Jython compiled files (like settings$py.class)
    if settings_name.endswith("$py"):
        settings_name = settings_name[:-3]

    # Set DJANGO_SETTINGS_MODULE appropriately.
    if original_settings_path:
        os.environ['DJANGO_SETTINGS_MODULE'] = original_settings_path
    else:
        os.environ['DJANGO_SETTINGS_MODULE'] = '%s.%s' % (project_name, settings_name)

    # Import the project module. We add the parent directory to PYTHONPATH to
    # avoid some of the path errors new users can have.
    sys.path.append(os.path.join(project_directory, os.pardir))
    project_module = import_module(project_name)
    sys.path.pop()

    return project_directory

</t>
<t tx="newlife.20110825014822.1298">def execute_from_command_line(argv=None):
    """
    A simple method that runs a ManagementUtility.
    """
    utility = ManagementUtility(argv)
    utility.execute()

</t>
<t tx="newlife.20110825014822.1299">def execute_manager(settings_mod, argv=None):
    """
    Like execute_from_command_line(), but for use by manage.py, a
    project-specific django-admin.py utility.
    """
    setup_environ(settings_mod)
    utility = ManagementUtility(argv)
    utility.execute()
</t>
</tnodes>
</leo_file>
