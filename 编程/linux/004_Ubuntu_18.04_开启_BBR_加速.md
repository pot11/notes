 

2018年10月29日

19:30

 

Ubuntu 18.04 开启 BBR 加速

2018-05-19 in [Linux](https://sycin.cn/category/linux/) 文章转载请注明来源！

    很多人喜欢在 Ubuntu 服务器开启 BBR 加速，目前 Ubuntu 的长期支持发行版已经更新到了 Ubuntu 18.04 LTS，该版本 Linux 默认使用的内核是 GNU/Linux 4.15.0-20-generic x86_64，可以直接通过几个命令开启 BBR 加速。

    通过 SSH 登录服务器，使用 root 权限输入以下几行代码。

 

> echo \"net.core.default_qdisc=fq\" \>\> /etc/sysctl.conf
>
> echo \"net.ipv4.tcp_congestion_control=bbr\" \>\> /etc/sysctl.conf
>
> sysctl -p

    正常情况下，经过上面的代码后，会出现如下代码：

 

> net.ipv4.neigh.default.base_reachable_time_ms = 600000
>
> net.ipv4.neigh.default.mcast_solicit = 20
>
> net.ipv4.neigh.default.retrans_time_ms = 250
>
> net.core.default_qdisc = fq
>
> net.ipv4.tcp_congestion_control = bbr

    出现了上面的代码，那么 BBR 基本已经确定开启成功了，当然你也可以输入下面的代码来验证是否真的开启成功。

 

> sysctl net.ipv4.tcp_available_congestion_control

    如果输入上述代码后显示

 

> net.ipv4.tcp_available_congestion_control = reno cubic bbr

表示 BBR 已经成功开启。

 

来自 \<<https://sycin.cn/linux/3.html>\>
