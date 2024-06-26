linux命令提示符

2019年10月7日

16:31

 

linux_命令格式和命令提示符

\# linux 中一切皆文件

 

命令格式：

 

命令 \[功能选项\] \[文件路径\]

 

cmd \[options\] \[path\]

 

\# 多个功能选项，要放在一起，如

 

rsync -avz /backup backup_rsync@10.0.0.22::backup \--password-file=/etc/rsync.password

 

命令窗口中 \[root@study shell\]# 表示什么意思？

 

\# 名称： 命令行提示符，由环境变量PS1控制

 

root 当前登录终端的用户

 

study 主机名(/etc/sysconfig/network)

 

\~ 当前用户的家目录

 

\# 表示root用户的终端

 

\$ 普通用户的终端

 

命令提示符修改：

 

\# 本质修改环境变量PS1

 

　　1. 查看环境变量PS1的值

 

1

echo \$PS1

　　2. 相关参数

 

　　　　\\u 当前终端用户

 

　　　　\\h 当前主机名

 

　　　　\\W 当前工作路径属于哪个父目录

 

　　　　\\w 显示当前工作路径的全路径

 

　　　　\\d 显示日期，格式：周几 几月 第几天

 

　　　　\\t 24格式显示时间

 

　　　　\\T 12格式显示时间

 

　　　　\\# 下达的第几个命令

 

　　　　\\\$ 用户身份提示符，# 表示root用户，\$表示普通用户

 

　　3. 修改命令提示符

 

　　　　当前终端临时显示：

 

1

PS1=\'\[\\u@\\h \\t \\W\]\\\$ \'　　

　　　　永久显示：

 

1

2

echo \"export PS1= \'\[\\u@\\h \\t \\W\]\\\$ \'\" \>\> /etc/profile

. /etc/profile

 

 

启动 Linux 桌面环境自带的终端模拟包，或者从 Linux 控制台登录后，便可以看到 Shell 命令提示符。看见命令提示符就意味着可以输入命令了。命令提示符不是命令的一部分，它只是起到一个提示作用。

 

不同的 Linux 发行版使用的提示符格式大同小异，例如在 CentOS 中，默认的提示符类似下面这样：

\[mozhiyan@localhost \~\]\$

 

各个部分的含义如下：

\[\]是提示符的分隔符号，没有特殊含义。

mozhiyan表示当前登录的用户，我现在使用的是 mozhiyan 用户登录。

\@是分隔符号，没有特殊含义。

localhost表示当前系统的简写主机名（完整主机名是 localhost.localdomain）。

\~代表用户当前所在的目录为主目录（home 目录）。如果用户当前位于主目录下的 bin 目录中，那么这里显示的就是bin。

\$是命令提示符。Linux 用这个符号标识登录的用户权限等级：如果是超级用户（root 用户），提示符就是#；如果是普通用户，提示符就是\$。

 

总结起来，Linux Shell 默认的命令提示符的格式为：

\[username@host directory\]\$

 

或者

\[username@host directory\]#

 

什么是主目录？

Linux 系统是纯字符界面，用户登录后，要有一个初始登录的位置，这个初始登录位置就称为用户的主目录（home 目录）。超级用户的主目录为/root/，普通用户的主目录为/home/用户名/。

有的资料也称为"家目录"，"家"是 home 的直译，它们都是一个意思。

 

用户在自己的主目录中拥有完整权限，所以我们也建议操作实验可以放在主目录中进行。

 

我们使用 cd 命令切换一下用户所在目录，看看有什么效果。

\[mozhiyan@localhost \~\]\$ cd demo

\[mozhiyan@localhost demo\]\$ cd /usr/local

\[mozhiyan@localhost local\]\$

仔细看，如果切换用户所在目录，那么命令提示符中会变成用户当前所在目录的最后一个目录（不显示完整的所在目录 /usr/ local/，只显示最后一个目录 local）。

第二层命令提示符

有些命令不能在一行内输入完成，需要换行，这个时候就会看到第二层命令提示符。第二层命令提示符默认为\>，请看下面的例子：

\[mozhiyan@localhost \~\]\$ echo \"Shell教程\"

Shell教程

\[mozhiyan@localhost \~\]\$ echo \"

\> http://

\> c.biancheng.net

\> \"

 

http://

c.biancheng.net

 

第一个 echo 命令在一行内输入完成，不会出现第二层提示符。第二个 echo 命令需要多行才能输入完成，提示符\>用来告诉用户命令还没输入完成，请继续输入。

 

echo 命令用来输出一个字符串。字符串是一组由\" \"包围起来的字符序列，echo 将第一个\"作为字符串的开端，将第二个\"作为字符串的结尾。对于第二个 echo 命令，我们将字符串分成多行，echo 遇到第一个\"认为是不完整的字符串，所以会继续等待用户输入，直到遇见第二个\"。
