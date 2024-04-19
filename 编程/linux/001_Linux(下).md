Linux(下)

2020年1月30日

12:13

> **Linux部署**
>
> 教学目标

1.  Linux系统软件管理

2.  能够完成Linux系统中jdk的安装

3.  能够完成linux系统中tomcat的安装

4.  能够完成linux系统中mysql的安装

5.  能够完成Linux系统中Redis的安装

6.  能够完成Linux系统中Nginx的安装

7.  部署后端项目

8.  部署前端项目

9.  部署优化 Shell脚步

> **Linux软件管理**
>
> rpm是由[红帽公司](https://www.baidu.com/s?wd=%E7%BA%A2%E5%B8%BD%E5%85%AC%E5%8F%B8&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)开发的软件包管理方式，使用rpm我们可以方便的进行软件的安装、查询、卸载、升级等工作。但是rpm软件包之间的依赖性问题往往会很繁琐,尤其是软件由多个rpm包组成时。
>
> yum（全称为 Yellow dog Updater, Modified）是一个在Fedora和RedHat以及CentOS中的**Shell前端软件包管理器**。基于RPM包管理，能够从指定的服务器自动下载RPM包并且安装，**可以自动处理依赖性关系**，并且一次安装所有依赖的软件包，无须繁琐地一次次下载、安装。

1.  参数：install 安装软件包

2.  参数：list 查看可以安装的软件包

3.  查找可以安装的软件包

4.  yum list \| grep java

5.  **安装gcc编译器**

6.  yum install gcc\
    linux操作系统下的redis数据库，是C语言源码形式出现的，因此需要C语言编译器编译为可执行文件。\
    远程下载需要的安装包，下载到/var/cache/yum/i386/6/base/packages目录下，安装完毕后自动删除

>  

1.  查看软件的安装位置

2.  rpm -ql gcc\
    rpm（Red Hat Package Manager）类似于window中的软件安装包

> **查看已经安装的软件包(rpm)**

1.  参数：-a 查询所有软件包

2.  参数：-q 表示查询

3.  示例：查询已经安装的java

4.  rpm -qa \| grep java

> **卸载已经安装的软件包**

1.  参数：-e 卸载 （erase）

2.  参数：\--nodeps 不检查依赖性

3.  **卸载已经安装的Java**

4.  rpm -e \--nodeps java-1.6.0-openjdk-1.6.0.0-1.66.1.13.0.el6.i686

5.  rpm -e \--nodeps java-1.7.0-openjdk-1.7.0.45-2.4.3.3.el6.i686

6.  rpm -e \--nodeps tzdata-java-2013g-1.el6.noarch

> **安装软件包**

1.  参数：-i install 安装

2.  参数：-v verbose 安装详细信息

3.  参数：-h hash 显示进度\
    rpm -ivh xxxx.rpm

> **软件安装与配置**
>
> **软件及资源上传**

1.  把软件及部署文件，默认上传到root下，可以创建一个soft目录。

>  

1.  把部署项目，上传到root用户下

>  
>
> **安装与配置JDK**

1.  tar -xvf 解开压缩包

2.  tar -xvf jdk-8u181-linux-i586.tar.gz -C /usr/local

3.  配置环境变量=\
    全局配置文件: /etc/profile\
    用户配置文件 \~/.bash_profile

4.  以下代码复制到profile文件中的最后部分，编辑加入文件。\
    #set java environment\
    JAVA_HOME=/usr/local/jdk1.8.0_181/\
    CLASSPATH=.:\$JAVA_HOME/lib.tools.jar\
    PATH=\$JAVA_HOME/bin:\$PATH\
    export JAVA_HOME CLASSPATH PATH\
    ​

5.  保存并退出

6.  从新加载环境变量

7.  source .bash_profile

8.  source /etc/profile\
    测试：任意目录下输入 javac

> **安装Tomcat**

1.  tar -xvf解开压缩包

2.  tar -xvf apache-tomcat-8.5.33.tar.gz -C /usr/local

3.  启动和停止tomcat服务

4.  tomcat解压目录/bin下 ./startup.sh

5.  tomcat解压目录/bin下 ./shutdown.sh

6.  开放Linux8080端口对外访问

7.  sudo 提升权限到 root用户权限

8.  /sbin/iptables -I INPUT -p tcp \--dport 8080 -j ACCEPT

9.  /etc/rc.d/init.d/iptables save

10. 查看在线日志

11. tail -f logs/catalina.xxxx.log

12. 修改端口号\
    修改conf/server.xml，端口号，重启tomcat服务器​

13. 备注【关于iptables】

> 删除iptables中放行的规则
>
> #查看iptables列表，显示列表编号
>
> iptables -L -n \--line-number
>
> Chain INPUT (policy ACCEPT)
>
> num target     prot opt source               destination        
>
> 1   ACCEPT     tcp  \--  0.0.0.0/0            0.0.0.0/0           tcp dpt:8080
>
> 2   ACCEPT     tcp  \--  0.0.0.0/0            0.0.0.0/0           tcp dpt:3306
>
> 3   ACCEPT     tcp  \--  0.0.0.0/0            0.0.0.0/0           tcp dpt:80
>
> 4   ACCEPT     all  \--  0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED
>
> #删除iptables列表中 编号为1的规则
>
> iptables -D INPUT 1
>
> ​
>
> **安装Mysql**

1.  linux版本MySQL上传到linux系统中的/usr/local下

2.  卸载系统中自带的MySQL

3.  查询系统中是否已经安装了MySQL rpm -qa \| grep mysql

4.  **卸载MySQL rpm -e \--nodeps mysql-libs-5.1.71-1.el6.i686**

5.  解压MySQL压缩包

6.  mkdir /usr/local/mysql 创建mysql子目录\
    可以选创建目录mysql，将所有的文件解压缩到该目录下

7.  tar -xvf MySQL-5.6.22-1.el6.i686.rpm-bundle.tar -C /usr/local/mysql

8.  rpm命令安装

9.  安装MySQL数据库服务器\
    rpm -ivh ./MySQL-server-5.6.22-1.el6.i686.rpm

10. 安装MySQL数据库客户端\
    rpm -ivh MySQL-client-5.6.22-1.el6.i686.rpm

11. ==启动MySQL服务 service mysql start==\
    启动失败，如下解决：

12. ps -A \| grep mysql 查看进程

13. kill -9 XXX 进程ID，杀死与之相关的进程，然后重启mysql

14. 设置root密码

15. MySQL首次安装的随机密码：/root/.mysql_secret 保存在此文件中

16. 登录MySQL，设置密码： set password = password(\'root\');\
    mysql -u root -p\
    设置完毕后，使用新密码重新登录

17. 授权远程连接

18. 默认情况下mysql为安全起见，不支持远程登录mysql，所以需要设置开启 远程登录mysql的权限\
    grant all privileges on \*.\* to \'root\' @\'%\' identified by \'root\';\
    flush privileges;

19. 开放3306端口

20. /sbin/iptables -I INPUT -p tcp \--dport 3306 -j ACCEPT

21. /etc/rc.d/init.d/iptables save

> **安装redis数据库**

1.  解压缩redis

2.  tar -xvf redis-3.2.9.tar.gz -C /usr/local

3.  make命令编译redis的C语言源码

4.  进入解压后的redis目录下的src目录

5.  输入==make==命令即可

> ./redis-server 服务器\
> ./redis-cli 客户端\
> 注意：可以把编译后的可执行程序可移动到自定义目录

1.  在redis 目录下创建bin目录，把编译后的服务器、客户端、配置文件copy到此目录下

2.  cd /usr/local/redis-3.2.9

3.  mkdir bin

4.  cp ./src/redis-server ./bin

5.  cp ./src/redis-cli ./bin

6.  cp ./redis.conf ./bin

7.  启动redis服务器

8.  cd bin

9.  ./redis-server

10. 后台启动

11. 使用vi编辑，打开redis.conf文件，原有的daemonize no修改为daemonize ==yes==\
    redis.conf配置文件中daemonize守护线程，默认是NO。\
    daemonize是用来指定redis是否要用守护线程的方式启动

12. 启动redis ./redis-server redis.conf

13. 启动redis客户端 ./redis-cli

14. 关闭redis服务器

15. ./redis-cli shutdown

> **安装Nginx**
>
> #安装Nginx依赖环境，-y表示所有提示默认选择y
>
> #nginx的http模块使用pcre来解析正则表达式，所以需要在linux上安装pcre库：
>
> yum -y install pcre pcre-devel  
>
> #nginx使用zlib对http包的内容进行gzip，所以需要在linux上安装zlib库：
>
> yum -y install zlib zlib-devel  
>
> #nginx不仅支持http协议，还支持https，所以需要在linux安装openssl库：
>
> yum -y install openssl openssl-devel
>
> ​
>
> #解压，并进入解压文件夹
>
> tar -xvf nginx-1.14.2.tar.gz -C /usr/local
>
> cd /usr/local/nginx-1.14.2
>
> ​
>
> #编译并安装
>
> ./configure 配置
>
> make 编译
>
> make install 安装
>
> 安装成功之后,就会在/usr/local下多出了一个nginx目录.
>
> 启动Nginx
>
> 进入nginx的sbin目录
>
> cd /usr/local/nginx/sbin
>
> ​
>
> 在sbin目录下启动
>
> ./nginx
>
> ​
>
> 在sbin目录下停止
>
> ./nginx -s stop
>
> ​
>
> 在sbin目录下重写加载
>
> ./nginx -s reload
>
> ​
>
> 修改端口
>
> vim /usr/local/nginx/conf/nginx.conf 配置文件
>
> ​
>
> 开放8848端口
>
> /sbin/iptables -I INPUT -p tcp \--dport 8848 -j ACCEPT
>
> /etc/rc.d/init.d/iptables save
>
> ​
>
> 查看是否有nginx的线程是否存在
>
> ps -ef \| grep nginx
>
> netstat -an -t -u \| grep 8848
>
> **部署后端项目**
>
> **初始化数据库**

1.  msyql客户端工具连接VM中的mysql

2.  在客户端工具中初始化数据库脚本

> **部署war包**

1.  使用IDEA打包web程序为.war文件,按如图所示：

>  

1.  把war包copy到tomcat目录的webapps目录下

> cp shop_web.war /usr/local/apache-tomcat-8.5.33/webapps/

1.  修改conf/server.xml 文件，设置项目为默认访问路径，即为从根开始菜单\
    在server.xml中找到\
    \<Host name=\"localhost\" appBase=\"webapps\"\
    unpackWARs=\"true\" autoDeploy=\"true\"\
    xmlValidation=\"false\" xmlNamespaceAware=\"false\"\>\
    \</Host\>\
    在标签中间插入：\
    \<Context path=\"\" docBase=\"shop_web\" debug=\"0\" reloadable=\"true\"/\>

> 其中docBase=\"shop_web\" shop_web是show_web.war解压缩后的项目目录名。
>
> 注意：修改配置文件后，必须重启服务器

1.  在bin(/usr/local/apache-tomcat-8.5.40/bin)目录下,先关闭服务器

> ./shutdown.sh

1.  在bin(/usr/local/apache-tomcat-8.5.40/bin)目录下，在启动服务器

> ./startup.sh
>
> **修改web配置文件并测试**
>
> shop_web/WEB-INF/classes 目录下

1.  数据库配置 c3p0-config.xml

2.  redis配置 redisdb.properties

3.  上传目录配置 upload.properties

4.  支付配置 alipay.properties

5.  测试web项目访问\
    [http://ip:port/admin?method=findAllCategory](http://ip:port/admin?method=findAllCategory)

> 比如：
>
> <http://192.168.23.131:8080/admin?method=findAllCategory>
>
>  
>
> **部署前端项目**
>
> **初始化前端工程**

1.  上传web目录到nginx目录\
    在nginx下创建www目录，把web工程上传到此目录

```{=html}
<!-- -->
```
1.  cd /usr/local/nginx

2.  mkdir www

3.  cp \~/web.zip ./www

```{=html}
<!-- -->
```
1.  解压缩web.zip到当前itheima_shop子目录中

```{=html}
<!-- -->
```
1.  cd /usr/local/nginx

2.  cd www

3.  **unzip ./web.zip -d itheima_shop**

> **修改配置文件**

1.  修改conf/nginx.conf文件

```{=html}
<!-- -->
```
1.  cd /usr/local/nginx

2.  vi conf/nginx.conf\
    location / {\
      root   www/itheima_shop;\
      index index.html index.htm;\
    }

```{=html}
<!-- -->
```
1.  修改后要重启nginx服务器

```{=html}
<!-- -->
```
1.  cd /usr/local/nginx

2.  ./sbin/nginx -s reload

> **配置host文件的域名映射**
>
> 设置windows的hosts文件指向虚拟主机的IP地址
>
> 修改C:\\Windows\\System32\\drivers\\etc\\hosts文件
>
> 192.168.23.131 [www.itheimashop.com](http://www.itheimashop.com)
>
> 192.168.23.131 api.itheimashop.com
>
> **测试整个项目**

1.  修改上传文件目录\
    修改文件上传目录，到web目录下

2.  修改上传文件的访问权限\
    修改用户默认创建文件和目录的权限\
    修改tomcat中bin目录catalina.sh,中的umask属性，把0027更改为0022。\
    修改后，重启tomcat。

> **部署优化**
>
> 编写启动或关闭服务shell脚本。
>
> **关于shell脚本**
>
> Shell的作用是解释执行用户的命令，用户输入一条命令，Shell就解释执行一条，这种方式称为交互式 Shell还有一种执行命令的方式称为批处理（Batch），用户事先写一个Shell脚本（Script），其中有很多条命令，让Shell一次把这些命令执行完，而不必一条一条地敲命令。Shell脚本和编程语言很相似，也有变量和流程控制语句，但Shell脚本是解释执行的，不需要编译，Shell程序从脚本中一行一行读取并执行这些命令，相当于一个用户把脚本中的命令一行一行敲到Shell提示符下执行。
>
> 一般shell的后缀名为.sh文件
>
> **启动服务脚本**
>
> 在root用户目录下，创建启动脚本
>
> vi start.sh，输入mysql、redis、tomcat、nginx的启动
>
> #启动mysql\
> service mysql start\
> #启动redis\
> cd /usr/local/redis-3.2.9/bin\
> ./redis-server redis.conf\
> #启动tomcat\
> /usr/local/apache-tomcat-8.5.33/bin/startup.sh\
> #启动nginx\
> /usr/local/nginx/sbin/nginx\
> #回到home\
> cd \~\
> #等待3秒，显示监听状态\
> sleep 3\
> netstat -an -t \| grep -E \'3306\|6379\|8848\|80\'
>
> 设置权限并测试
>
> chmod 750 start.sh
>
> **关闭服务脚本**
>
> vim shutdown.sh
>
> #关闭mysql\
> service mysql stop\
> #关闭redis\
> cd /usr/local/redis-3.2.9/bin\
> ./redis-cli shutdown\
> #关闭tomcat\
> /usr/local/apache-tomcat-8.5.33/bin/shutdown.sh\
> #关闭nginx\
> /usr/local/nginx/sbin/nginx -s stop\
> #回到home\
> cd \~\
> #等待3秒，查看状态\
> sleep 3\
> netstat -an -t \| grep -E \'3306\|6379\|8848\|8080\'
>
> 设置权限并测试
>
> chmod 750 shutdown.sh
