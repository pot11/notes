
# 小米路由器开启ipv6防火墙

```shell
ssh -oKexAlgorithms=diffie-hellman-group1-sha1 root@192.168.31.1
```

通过配置文件开启ipv6

vi /etc/config/ipv6
内容修改如下

```shell
config ipv6 'settings'
        list if_on 'wan'
        list if_on 'ipv6'
        option ipv6_show '1'
        option enabled '1'
        option mode 'native'
config dns 'dns'
        option peerdns '1'
```
		
下一步关闭防火墙，这是关闭ipv6防火墙，测试的时候用，排除防火墙问题的时候用

```shell
vi /etc/config/firewall
```

添加如下内容

```shell
config rule
        option enabled '1'
        option target 'ACCEPT'
        option src 'wan'
        option name 'Allow-v6-Forward'
        option family 'ipv6'
        option dest 'lan'
```

正式用的时候的规则，也是推荐的规则设置方式，开放22和8000端口，这个根据自己需要修改，22是我的树莓派的ssh服务，8000是树莓派上的一个web服务，用于人工智能控制的，平时用的blinker程序，万一程序挂了，用web服务应急

```shell
config rule
        option name 'Allow-v6-Forward'
        option family 'ipv6'
        option src 'wan'
        option dest 'lan'
        option target 'ACCEPT'
        option dest_port '22 8000'
        option proto 'tcp udp'
```

再就是域名，国内域名都收费还要备案，用的是 Free dynamic DNS for IPv6 (dynv6.com)，通过http api通过树莓派做的定时任务进行更新。

附上路由器防火墙的几个命令

```shell
/etc/init.d/ipv6wall enable
/etc/init.d/ipv6wall disable
/etc/init.d/firewall reload
/etc/init.d/firewall restart
```
