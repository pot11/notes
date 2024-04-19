Nginx

2020年1月4日

14:36

 

随笔 - 385  文章 - 0  评论 - 9 

[**170217、nginx 安装时候报错：make: \*\*\* No rule to make target \`build\', needed by \`default\'. Stop.**](https://www.cnblogs.com/zrbfree/p/6419043.html)

出现此种情况，是linux系统没有安装先决条件

**1、GCC------GNU编译器集合（GCC可以使用默认包管理器的仓库（repositories）来安装，包管理器的选择依赖于你使用的Linux发布版本，包管理器有不同的实现：yum是基于Red Hat的发布版本；apt用于Debian和Ubuntu；yast用于SuSE Linux等等。）**

**RedHat中安装GCC：**

yum install gcc

**Ubuntu中安装GCC：**

apt-get install gcc

**2、PCRE库（Nginx编译需要PCRE（Perl Compatible Regular Expression），因为Nginx的Rewrite模块和HTTP核心模块会使用到PCRE正则表达式语法。这里需要安装两个安装包pcre和pcre-devel。第一个安装包提供编译版本的库，而第二个提供开发阶段的头文件和编译项目的源代码，这正是我们需要的理由。）**

**RedHat中安装PCRE：**

yum install pcre pcre-devel

**Ubuntu中安装PCRE：**

apt-get install libpcre3 libpcre3-dev

**3、zlib库（zlib库提供了开发人员的压缩算法，在Nginx的各种模块中需要使用gzip压缩。如同安装PCRE一样，同样需要安装库和它的源代码：zlib和zlib-devel。）**

**RedHat中安装zlib：**

yum install zlib zlib-devel

**Ubuntu中安装zlib：**

apt-get install zlib1g zlib1g-dev

**4、OpenSSL库（在Nginx中，如果服务器提供安全网页时则会用到OpenSSL库，我们需要安装库文件和它的开发安装包（openssl和openssl-devel）。）**

**RedHat中安装OpenSSL：**

yum install openssl openssl-devel

**Ubuntu中安装OpenSSL：（注：Ubuntu14.04的仓库中没有发现openssl-dev）：**

apt-get install openssl openssl-dev

 注意：要不关闭防火墙，要不然放不了nginx页面

 

1、开放端口

**firewall-cmd \--zone=public \--add-port=5672/tcp \--permanent **  # 开放5672端口

**firewall-cmd \--zone=public \--remove-port=5672/tcp \--permanent ** #关闭5672端口

**firewall-cmd \--reload**   # 配置立即生效

 

2、查看防火墙所有开放的端口

**firewall-cmd \--zone=public \--list-ports**

 

3.、关闭防火墙

如果要开放的端口太多，嫌麻烦，可以关闭防火墙，安全性自行评估

**systemctl stop firewalld.service**

 

4、查看防火墙状态

** firewall-cmd \--state**

 

5、查看监听的端口

**netstat -lnpt**

![](105_Nginx_000.png)

*PS:centos7默认没有 netstat 命令，需要安装 net-tools 工具，yum install -y net-tools*

 

 

6、检查端口被哪个进程占用

**netstat -lnpt \|grep 5672**

![](105_Nginx_001.png)

 

7、查看进程的详细信息

**ps 6832**

![](105_Nginx_002.png)

 

8、中止进程

**kill -9 6832**

 

来自 \<<https://www.cnblogs.com/heqiuyong/p/10460150.html>\>

 

 
