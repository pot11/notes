Centos7虚拟机配置网络

2020年6月26日

17:01

 

进入文件夹 cd /etc/sysconfig/network-scripts/

Vim ipcfg-ens33

配置为静态ip，设置好ip地址，子网掩码，网关，dns，onboot

ifcfg-ens33文件参数解释

![](011_Centos7虚拟机配置网络_000.png)

然后重启网卡服务

Systemctl restart network.service

 

 

配合虚拟机网络配置为桥接模式

 

 

 

在/etc/sysconfig/network-scripts/ifcfg-eth0(确认baiONBOOT=yes),其中eth0是设备名；

 

ONBOOT是指明在系统启动时是否激活网卡，只有在激活状态的网卡才能dao去连接网络，进行网络通讯。

DEVICE：网卡名称

 

ONBOOT=yes相当于启动这个网卡的开关

BOOTPROTO=none（这个是表示你使用什么样的路由协议，有三种不同写法，如果是none和static表示你用的是静态路由，那么你在接下来的项目里就必须填写IPADDR、NETMASK、GATEWAY这三个选项。如果是dhcp表示你使用动态路由协议，那IPADDR、NETMASK、GATEWAY这些选项就可以不必填写。如果填写了，就以你填写的值为准）

 

HWADDR：你网卡的物理地址（可以不用写，系统自动会生成）

 

IPADDR：ip地址  

 

NETMASK：子网掩码    

 

GATEWAY：网关

 

 
