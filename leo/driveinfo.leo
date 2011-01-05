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
<v t="newlife.20101202163036.1285"><vh>@chapters</vh></v>
<v t="newlife.20101202163036.1286" a="E"><vh>aboutthisfile</vh>
<v t="newlife.20101202163036.1287"><vh>1</vh></v>
</v>
<v t="T1.None" a="E"><vh>Drive Info - Read Me First</vh>
<v t="T2.None"><vh>Instructions for installing and running this script</vh></v>
<v t="T7.None"><vh>&lt;&lt;Docs: Installing modules necessary for running this script &gt;&gt;</vh></v>
<v t="T4.None"><vh>Sample ini file</vh></v>
<v t="T5.None" a="E"><vh>Driveinfo Script</vh>
<v t="T6.None" a="E"><vh>&lt;&lt; Include Perl modules for reading drive space and sending email (and a couple of others) &gt;&gt;</vh>
<v t="T7.None"></v>
</v>
<v t="T8.None" a="E"><vh>&lt;&lt; Read in the info from the ini file &gt;&gt;</vh>
<v t="T16.None"><vh>&lt;&lt; Get the filename of the ini file and put in the $ini_file variable &gt;&gt;</vh></v>
</v>
<v t="T9.None"><vh>&lt;&lt; Get the drive free space for each drive &gt;&gt;</vh></v>
<v t="T10.None"><vh>&lt;&lt; Send the drive space info to a list of people &gt;&gt;</vh></v>
<v t="T11.None"><vh>&lt;&lt; Functions &gt;&gt;</vh>
<v t="T12.None"><vh>&lt;&lt; Notify function - for sending an email message &gt;&gt;</vh></v>
</v>
</v>
<v t="T14.None" a="E"><vh>MiscUtil Module</vh>
<v t="T15.None" a="E"><vh>&lt;&lt; Functions &gt;&gt;</vh>
<v t="T17.None"><vh>&lt;&lt; English Date &gt;&gt;</vh></v>
<v t="T18.None"><vh>&lt;&lt; English Time &gt;&gt;</vh></v>
<v t="T19.None"><vh>&lt;&lt; Get total size of a list of files &gt;&gt;</vh></v>
<v t="T20.None"><vh>&lt;&lt; Load a text file into a scalar variable &gt;&gt;</vh></v>
<v t="T21.None"><vh>&lt;&lt; Strip spaces off beginning and end of a string variable &gt;&gt;</vh></v>
<v t="T22.None"><vh>&lt;&lt; Join together two hashes &gt;&gt;</vh></v>
<v t="T23.None"><vh>&lt;&lt; Add commas to a number &gt;&gt;</vh></v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="T1.None">@doc

This LEO document contains a script for checking free drive space on all drives on a Win32 machine and optionally emailing this info to a list of addresses.

Extensive documentation for how to use the script, and how the script works is also contained in this document.

The script and this document are copyright 2000 by Joe Orr under the Perl Artistic License. This file and the script it contains may be freely copied and modified as long as this copyright noticed is maintained.

To generate the script, select File-&gt;Tangle (with this node selected). This will create the following files:

1. driveinfo.pl (the main script)
2. MiscUtil.pm  (set of utility functions, some of which are used in driveinfo.pl)
3. driveinfo_sample.ini (a sample ini file - you must edit this if you want to run the email option)

To run the script, see the "Instructions for installing and running this script".



</t>
<t tx="T10.None">@code

my $name;
foreach $name (keys %notify_flags) {
   &amp;notify($name, $msg)
}
</t>
<t tx="T11.None">@code

&lt;&lt; Notify function - for sending an email message &gt;&gt;
</t>
<t tx="T12.None">@docs

This function takes an address and a message as parameters,
and sends the message to the address. 

The following global variables must already be defined with 
meaningful values:
$smtp_server = smtp server name through which the email is to be sent 
$smtp_user = user name for the smtp server

You can see that the Net::SMTP module makes sending email very easy. We just create an smtp object and then call some of the object's methods.

@code

sub notify () {

  my ($address, $msg) = @_;
  unless ($smtp_user and $address and $smtp_server) {return 0}

  print "\n";

  my $smtp = Net::SMTP-&gt;new($smtp_server,
                          Hello =&gt; $domain,
                          Timeout =&gt; 30,
                          Debug   =&gt; 1,
                        );
  
  $msg = "subject: Drive Information - message from DriveInfo\n$msg";
  $smtp-&gt;mail($reply_to);
  $smtp-&gt;recipient($address);

  $smtp-&gt;data($msg);
  $smtp-&gt;quit();
}
</t>
<t tx="T14.None">@docs

This module is a package with some miscellaneous functions.
Only a few of these functions are actually used by the driveinfo.pl script.


@root "MiscUtil.pm"

&lt;&lt; Functions &gt;&gt;

</t>
<t tx="T15.None">@code

package MiscUtil;

use strict;
use Time::localtime;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

 @ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
 @EXPORT = qw(
  grab_file	
  trim
  join_hashes
  english_date
  english_time
  total_size
  commify
);
$VERSION = '0.03';

# Preloaded methods go here.

&lt;&lt; English Date &gt;&gt;
&lt;&lt; English Time &gt;&gt;
&lt;&lt; Get total size of a list of files &gt;&gt;
&lt;&lt; Load a text file into a scalar variable &gt;&gt;
&lt;&lt; Strip spaces off beginning and end of a string variable &gt;&gt;
&lt;&lt; Join together two hashes &gt;&gt;
&lt;&lt; Add commas to a number &gt;&gt;

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

misc - Perl extension for misc utilities, used by JSL

=head1 SYNOPSIS

  use misc;

=head1 DESCRIPTION

Misc utilities

=head1 AUTHOR

Joe Orr JSL http://www.jserv.com

=head1 SEE ALSO

perl(1).

=cut
</t>
<t tx="T16.None">@code

my $ini_file = $PROGRAM_NAME;
$ini_file =~ s|.*\\||g; #remove path (everything up to last \)

#remove file extension
$ini_file =~ s/\..*//;

#add ini file extension
$ini_file .= ".ini";
</t>
<t tx="T17.None">@code

sub english_date () {

  my $year = localtime()-&gt;year;
  no strict;
  my $month = (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec)[localtime-&gt;mon()];
  my $wday = (Mon, Tue, Wed, Thur, Fri, Sat, Sun)[localtime-&gt;wday()];
  my $mday = localtime-&gt;mday();
  
  $year = 1900 + $year;
  return "$wday, $month $mday $year";

}
</t>
<t tx="T18.None">@code

sub english_time () {

  my $post;
  my $hour = localtime-&gt;hour;
  my $min = localtime-&gt;min;
  ($min &lt; 10) and $min = "0$min";

  my $now_time = "$hour:$min";

}
</t>
<t tx="T19.None">@code

#get total size of comma delimited list of files
sub total_size () {

  my ($files, $pre, $post) = @_;
  
  $files =~ s/ //g;
  my @files = map {$pre.$_.$post} split /,/, $files;
  my $total;
  foreach (@files) {
    unless (-e $_) {next}
    $total += (-s $_);  
  }
  return $total;
 
}
</t>
<t tx="T2.None">@docs

This LEO document contains a script named "driveinfo.pl" for checking free drive space on all drives on your Win32 machine and emailing this information to any number of addresses. The LEO document also contains all the information you need to put this script to use. It also contains a description of how the script works.

The driveinfo.pl script is for Win32 systems only (Window 95/98/2000).

This script is written in the Perl programming language. A script is a set of instructions in a text file that execute when run with a program called an "interpreter". A perl interpreter for Win32 is freely available from
http://www.ActiveState.com.

To run this script, first download and install the ActiveState Perl interpreter. Then, "Tangle" the script. "Tangle" means to put together the actual script from the sections in this LEO document where it is embedded. To Tangle the script, click on the "Driveinfo Script" node and choose "Tangle" from the "File" menu. This will create a file named driveinfo.pl in the same folder as this LEO document.

This script requires some extra components which are also freely available. These components are called "modules". To install the modules needed for this script, see the information in the "Installing the modules needed for this script" subsection.

If you have installed Perl and the extra modules, you can now run this script by opening a Command Prompt, using the CD command to change to the directory that this LEO file is in, and typing "perl -w driveinfo.pl".


</t>
<t tx="T20.None">@code

#next sub grabs everything in a file and puts it in a scalar variable
sub grab_file {

  my $fh = shift;

  local $/;
  open (FH, $fh) || die "can't open $fh!&lt;p&gt;";
  my $l = &lt;FH&gt;;
  close (FH);
  $l;

}
</t>
<t tx="T21.None">@code

#cut the spaces off of both sides of a string
sub trim {

 my ($l) = shift;

 $l =~ s/^\s+//; #ltrim
 $l =~ s/\s+$//; #rtrim

 return $l

}</t>
<t tx="T22.None">@code

#next sub appends multiple hashes
sub join_hashes {

  my ($out_hash, @in_hash) = @_;
  my ($in_hash, $key);

  foreach $in_hash (@in_hash) {
    foreach $key (keys %$in_hash) {
       $$out_hash{$key} = $$in_hash{$key}
     }
  }
}
</t>
<t tx="T23.None">@docs 

Insert commas into a number (string). Printf or sprint f could also be used here.

@code

sub commify {

 local $_  = shift;

 1 while s/^(-?\d+)(\d{3})/$1,$2/;

 #$num =~ s/^(\d+)(\d{3})/$1,$2/;

 return $_;

}
</t>
<t tx="T4.None">@docs

driveinfo.pl uses an "ini" file to store some information for use with the email option.

The ini file has two types of information:
1. Information about your smtp server, so that you can send an email.
2. Email addresses of users who should be notified.

Here is a sample ini file (starting from after the "@root"). 

@root "driveinfo_sample.ini"

#==================================
#
# ini file for driveinfo.pl
#  
#==================================

smtp_server: smtp.a001.sprintmail.com
domain: a001.sprintmail.com
smtp_user: username
reply_to: george@jserv.com
notify: george@sprintmail.com
#notify: someone@inconnect.com</t>
<t tx="T5.None">@docs
This is a list of the sections in the program. To generate the program ready to run, choose File-&gt;Tangle.
For documentation of the code, see the beginning of each section. All of the code for the script is contained in subsections of this section.

@root "driveinfo.pl"

&lt;&lt; Include Perl modules for reading drive space and sending email (and a couple of others) &gt;&gt;
&lt;&lt; Read in the info from the ini file &gt;&gt;
&lt;&lt; Get the drive free space for each drive &gt;&gt;
&lt;&lt; Send the drive space info to a list of people &gt;&gt;
&lt;&lt; Functions &gt;&gt;





</t>
<t tx="T6.None">@docs
Here we specify a couple of directives, and load a few modules. 

This script is for Win32 machines, so we're assuming that you are going to use the perl distribution from http://www.ActiveState.com.

You may need to install the SMTP, AdminMisc and NetAdmin modules. See the subsection "Installing modules necessary for running this script".

@code

&lt;&lt; Docs: Installing modules necessary for running this script &gt;&gt;
use strict;   # variables must be declared 
use English;  # use English names for Perl special variables (like '$_')

use Net::SMTP;         # this module allows you to send email
use Win32::AdminMisc;  # this module allows you get drive space and other info
use MiscUtil;          # a small package containing miscellaneous functions
use FileHandle;        # this module allows you to use object-oriented syntax for file functions
</t>
<t tx="T7.None">@docs

Here is how you can install the necessary modules for this script that using the PPM module manager that is installed by default with the ActiveState distribution:
 
To install the Net::SMTP module: open a command prompt and type "PPM". This will start PPM. At the PPM prompt, type "install libnet". (Net:: modules are in libnet). The program may ask you some questions. If you don't know the answer to the questions, enter a single space and carriage return. 

That's all there is to installing the SMTP module. The AdminMisc module is in the Roth Consulting archive, not in the
ActiveState archive, however. You'll need to tell PPM about the location of this archive. Type the following at the PPM prompt:

set repository RothConsulting http://www.roth.net/perl/packages
set

Now you can type:
install Win32-AdminMisc

and NetAdmin and AdminMisc will be installed on your system.


</t>
<t tx="T8.None">@doc
Here we read the ini file. The ini file contains info needed for sending an email (like smtp server) and a list of email addresses
for people we will notify about drive space on this machine.


@code
# declare a list of the variable names that will be read in from the ini file
use vars qw($server $ini_file $log_file $smtp_server $smtp_user $reply_to $domain );

&lt;&lt; Get the filename of the ini file and put in the $ini_file variable &gt;&gt;
 
# now we have the filename, open the file
my $fh;
($fh = new FileHandle $ini_file) or die "can't open $ini_file"; 

no strict 'refs'; #because we are pulling vars directly from ini file

#go thru the ini file processing one line at a time.
my %notify_flags;
while ($_ = $fh-&gt;getline){
  
  chomp;
  
  #skip lines with no letters
  unless (/\w/) {next}
  #skip comments
  next if (/^#/);

  #split the line into the variable name and its value
  my ($name, $value) = split (/: /);
  $$name = &amp;trim($value);

  #keep a hash of addresses to send notification email to
  if ($name eq 'notify') {
    $notify_flags{$$name} = '1';
  }

}
</t>
<t tx="T9.None">@docs

This part of the program gets a list of drives, and
then gets the free space for each drive.

@code

my $hostname;
$hostname = Win32::AdminMisc::GetComputerName;

my (@Drives, $Drive, $Total, $Free);
 @Drives = Win32::AdminMisc::GetDrives(DRIVE_FIXED);
my ($msg, $Time);

$msg .= "\nDrive info for $hostname ";
$msg .= &amp;english_date . "  " . &amp;english_time . "\n\n";

foreach $Drive (sort(@Drives)){
    ($Total, $Free) = Win32::AdminMisc::GetDriveSpace($Drive);
    $Total = commify($Total);
    $Free = commify($Free);
    $msg .= "Drive $Drive $Total bytes with $Free bytes available.\n";
}
print "$msg\n";

exit;</t>
<t tx="newlife.20101202163036.1285"></t>
<t tx="newlife.20101202163036.1286">@doc

this file is not wriiten by myself.

it is just for practising the use of leo.

and this scripts is about perl</t>
<t tx="newlife.20101202163036.1287">@doc

Perl is a great language for many things, but one thing it really shines at is in making small programs for system administration. There is a huge library of components for system administration that you can use from Perl, and it is easy to do a lot with a small script.

对于很多事情来说Perl都是一个伟大的语言。但是一件确实值得夸耀的事情就是可以为系统管理写很多小程序。他有大量的库，可以使你写一些用于系统管理的小脚本变得非常容易。


Scripts that are dashed off quickly to take care of small tasks tend not to be terribly readable and well documented, particularly in a language like Perl that has so many ways to pack a lot of functionality into a few statements. Such scripts also tend to proliferate, since often it can be faster to write a new script than find out whether a script already exists that can do the job.
迅速丢弃的用来处理小任务的脚本一般可读性都不会太好(#1)，尤其是用perl写的程序，因为他有这么多方法可以把很多函数写到几行程序里(#2)，这种脚本都是比较“”，
因为重新写一个并不比看是否存在一个更节约时间。

This tutorial provides an example of how using Leo can solve both of these problems. One sample script is presented, but it is easy to see how adding more scripts to this example outline could result in a package that is very well documented. Addind a new script to this outline would not take much more effort than dashing off a script in a standard text editor.

这个教程提供了一个例子来演示leo是如何解决这些问题的，这里提供了一个实例脚本，但是很容易可以看出增加脚本到这个实例并组成一个文档良好的包是多么的容易，

给这个提纲增加一个新的脚本不比匆忙写一个花费多少精力。

 
 
 
 
 
 
 #1：这个时候，你需要python。
 #2：这就是所谓的”一行流“呗。
 
 
 dash off 匆忙写出。</t>
</tnodes>
</leo_file>
