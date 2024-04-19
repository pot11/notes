 

2018年10月29日

19:32

 

手把手教你搭建shadowsocks科学上网 搭建ss教程

[![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_000.png)](http://blog.51cto.com/13756513)

[vpsceping](http://blog.51cto.com/13756513)关注91人评论[1158878人阅读2018-05-18 22:44:54](javascript:;)

本文从零开始，手把手教你搭建自己的shadowsocks代理服务器实现科学上网。可用×××方法，史上最全的小白搭建ss教程。内容包括VPS购买，连接VPS，一键搭建shadowsocks，开启bbr加速，客户端配置shaodowsocks。

**购买VPS**

VPS（Virtual private server，虚拟专用服务器），个人用来搭建一些博客，跑跑脚本足够了。今天的教程就用VPS来搭建属于自己的shaodowsocks，一个人独占一条线路。

**Vultr**是美国的一个VPS服务商，全球有15个数据中心，可以一键部署服务器。采用**小时计费策略**，可以在任何时间新建或者摧毁VPS。价格低廉，最便宜的只要2.5一个月，**支持支付宝**。

**新用户注册**

优惠注册链接：[www.vultr.com](https://yhgo.wang/vultr)

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_001.png)

填写邮箱、密码（至少10个字符，并且有**一个大写字母&一个小写字母&一个数字**），最后点击后面的Create Account即可。注册完会收到一封验证邮件，验证即可\~

**充值**

Vultr实际上是折算成小时来计费的，比如服务器是5美元1个月，那么每小时收费为5/30/24=0.0069美元 会自动从账号中扣费，只要保证账号有钱即可\~而费用计算是从你开通时开始计算的，不管你有没有使用都会扣费，即使你处于关机状态，唯一停止计费的方法是Destroy掉这个服务器！Vultr提供的服务器配置包括：

2.5美元/月的服务器配置信息：单核 512M内存 20G SSD硬盘 100M带宽 500G流量/月

5美元/月的服务器配置信息：单核 1G内存 25G SSD硬盘 100M带宽 1000G流量/月

10美元/月的服务器配置信息：单核 2G内存 40G SSD硬盘 100M带宽 2000G流量/月

20美元/月的服务器配置信息：2cpu 4G内存 60G SSD硬盘 100M带宽 3000G流量/月

40美元/月的服务器配置信息：4cpu 8G内存 100G SSD硬盘 100M带宽 4000G流量/月

验证并登录后我们会跳转到充值界面，或者从**Billing**-\>**Make Patment**进入：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_002.png)

支持支付宝，充值10刀，按小时扣费，只要保证账户有余额，你的服务器就会一直运行。

**新机器创建**

选择右上角的蓝色+号按钮，进入**Deploy**页面，选择服务器配置：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_003.png)

目前2.5的还有**迈尔密**和**纽约**的没有售罄，对于ping值和速度要求不是特别高的可以选择这里的（毕竟美国东海岸城市，离国内有点远）\~

推荐服务器使用**洛杉矶**的\~

之后在**Additional Features**中勾选**Enable IPv6**:

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_004.png)

其他都直接默认即可，最后点击右下角的**Deploy Now**开始新建。

**获取VPS登录信息**

选择Deploy后，过个几分钟，就可以看到自己的服务器信息了，具体位置在**Servers**-\>**Instances**，点击选择你新建的实例：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_005.png)

其中，红框选中的部分从上到下依次是IP，用户名和密码\~

**连接VPS**

**Windows连接VPS**

1.下载Xsehll

直接在[百度软件中心](http://rj.baidu.com/soft/detail/15201.html?ald)下载，下载后正常安装即可\~

2.连接linux

选择**文件**-\>**新建**：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_006.png)

在主机位置输入你的VPS IP：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_007.png)

确定后会让你输入你的Linux用户名：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_008.png)

之后是Linux用户密码：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_009.png)

如果显示如下图所示就表示连接成功了（如果是Vultr，那么连接成功标志应该是root@vultr）：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_010.png)

**Mac OS连接VPS**

直接打开Terminal终端，输入：ssh root@43.45.43.21，之后输入你的密码就可以登录了（输入密码的时候屏幕上不会有显示）

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_011.png)

**一键搭建shaodowsocks/shadowsocksR**

注意，shadowsocks/shadowsocksR这两个**只需要搭建一个**就可以了！！！！SS与×××之间的比较一直是各有各的说法，王婆卖瓜自卖自夸。我用的是SS，因为SS的iOS版本比较容易下载，并且被没有觉得ss容易被探查到\~

**一键搭建shadowsocks**

1.下载一键搭建ss脚本文件（直接复制这段代码运行即可）

git **clone** [https:*//github.com/flyzy2005/ss-fly*](https://github.com/flyzy2005/ss-fly)

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_012.png)

2.运行搭建ss脚本代码

ss-fly/ss-fly.sh -i flyzy2005.com 1024

其中**flyzy2005.com**换成你要设置的shadowsocks的密码即可（这个**flyzy2005.com**就是你ss的密码了，是需要填在客户端的密码那一栏的），密码随便设置，最好**只包含字母+数字**，一些特殊字符可能会导致冲突。而第二个参数1024是**端口号**，也可以不加，不加默认是1024\~（**举个例子**，脚本命令可以是ss-fly/ss-fly.sh -i qwerasd，也可以是ss-fly/ss-fly.sh -i qwerasd 8585，后者指定了服务器端口为8585，前者则是默认的端口号1024，两个命令设置的ss密码都是qwerasd）：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_013.png)

出现如下界面就说明搭建好了：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_014.png)

**注**：如果需要改密码或者改端口，只需要重新再执行一次**搭建ss脚本代码**就可以了，或者是修改/etc/shadowsocks.json这个配置文件，之后重启ss服务。

3.相关ss操作

修改配置文件：vim /etc/shadowsocks.json\
停止ss服务：ssserver -c /etc/shadowsocks.json -d stop\
启动ss服务：ssserver -c /etc/shadowsocks.json -d start\
重启ss服务：ssserver -c /etc/shadowsocks.json -d restart

4.卸载ss服务

ss-fly/ss-fly.sh -uninstall

**一键搭建shadowsocksR**

**再次提醒**，如果安装了SS，就不需要再安装×××了，如果要改装×××，请按照上一部分内容的教程先卸载SS！！！

1.下载一键搭建***脚本（只需要执行一次，卸载***后也不需要重新执行）

git clone <https://github.com/flyzy2005/ss-fly>

2.运行搭建\*\*\*脚本代码

ss-fly/ss-fly.sh -*\*\*\**

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_015.png)

3.输入对应的参数

执行完上述的脚本代码后，会进入到输入参数的界面，包括服务器端口，密码，加密方式，协议，混淆。可以直接输入回车选择默认值，也可以输入相应的值选择对应的选项：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_016.png)

全部选择结束后，会看到如下界面，就说明搭建\*\*\*成功了：

Congratulations, ShadowsocksR server **install** completed!\
Your **Server** IP :你的服务器ip\
Your **Server** Port :你的端口\
Your **Password** :你的密码\
Your Protocol :你的协议\
Your obfs :你的混淆\
Your Encryption Method:your_encryption_method

Welcome **to** visit:https://shadowsocks.be/9.html\
Enjoy it!

4.相关操作\*\*\*命令

启动：/etc/init.d/shadowsocks **start**\
停止：/etc/init.d/shadowsocks **stop**\
重启：/etc/init.d/shadowsocks restart\
状态：/etc/init.d/shadowsocks **status**

配置文件路径：/etc/shadowsocks.json\
日志文件路径：/**var**/**log**/shadowsocks.log\
代码安装目录：/usr/**local**/shadowsocks

5.卸载\*\*\*服务

./shadowsocksR.sh uninstall

**一键开启BBR加速**

BBR是Google开源的一套内核加速算法，可以让你搭建的shadowsocks/shadowsocksR速度上一个台阶，本一键搭建ss/\*\*\*脚本支持一键升级最新版本的内核并开启BBR加速。

BBR支持4.9以上的，如果低于这个版本则会自动下载最新内容版本的内核后开启BBR加速并重启，如果高于4.9以上则自动开启BBR加速，执行如下脚本命令即可自动开启BBR加速：

ss-fly/ss-fly.sh -bbr

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_017.png)

装完后需要重启系统，输入y即可立即重启，或者之后输入reboot命令重启。

判断BBR加速有没有开启成功。输入以下命令：

sysctl net.ipv4.tcp_available_congestion_control

如果返回值为：

net.ipv4.tcp_available_congestion_control = bbr cubic reno

后面有bbr，则说明已经开启成功了。

**本机配置shadowsocks**

各版本的shadowsocks客户端下载地址可以参考：[Android/Windows/iOS/Mac/Linux shadowsocks客户端下载地址](https://www.flyzy2005.win/fan-qiang/shadowsocks/ss-clients-download/)

**WIndows客户端配置**

双击运行shadowsocks.exe，之后会在任务栏有一个小飞机图标，右击小飞机图标，选择**服务器**-\>**编辑服务器**：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_018.png)

在shadowsocks的windows客户端中，**服务器IP**指你购买的VPS的IP，**服务器端口**指你服务器的配置文件中的端口，**密码**指你服务器的配置文件中的密码，**加密**指你服务器的配置文件中的加密方式，**代理端口**默认为1080不需要改动。**其他都可以默认**。设置好后，点击添加按钮即可。

**MAC OS客户端配置**

双击运行shadowsocksX-NG.app，之后会在任务栏有一个小飞机图标，右击小飞机图标，选择**服务器**-\>**服务器设置**：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_019.png)

在shadowsocks的Mac OS客户端中，**地址**指你购买的VPS的IP，冒号后面跟上配置文件中的**端口**，**密码**指你服务器的配置文件中的密码，**加密**指你服务器的配置文件中的加密方式。**其他都可以默认**。设置好后，点击确认即可。

**安卓客户端配置**

下载apk安装好后，打开影梭客户端，点击主界面左上角的**编辑按钮**（铅笔形状）：

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_020.png)

在shadowsocks安卓客户端的配置中填入相应配置信息，其中，**功能设置**中，**路由**改成如上图所示，其他都可以默认。

**苹果客户端配置**

shadowsocks苹果客户端经常会被App Store下架，可以在App Store搜索关键字**shadowsock**或者**wingy**，找到一个软件截图中包括填写ip，加密方式，密码的软件一般就是对的了（目前可以用的是FirstWingy）。当然，你也可以下载PP助手，之后在PP助手上下载Wingy（Wingy支持***）或者shadowrocket（shadowrocket支持***）。

![](005_手把手教你搭建shadowsocks科学上网_搭建ss教程_021.png)

**总结**

如上就是手把手教你搭建shadowsocks的全部内容。在国内，\*\*\*是不允许的了，所以还不如自己搭建ss，可以独享一个线路。

 

来自 \<<http://blog.51cto.com/13756513/2118075>\>

 
