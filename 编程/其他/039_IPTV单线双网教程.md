IPTV单线双网教程

Tuesday, December 19, 2017

11:59 AM

 

**\[k3\] IPTV单线双网教程【已取消主题售价】** [只看楼主](http://www.right.com.cn/forum/forum.php?mod=viewthread&tid=264963&page=1&authorid=319617&mobile=2)\
没弄明白主题售价和隐藏的关系，现在主题售价已取消，回复即可查看！\
\
应坛友的要求，现在把方案3详细设置写出来，顺便把最新的方案也写出来。[原帖地址\
](http://www.right.com.cn/forum/forum.php?mod=viewthread&tid=257664&page=1#pid2162730)\
我的设备：光猫华为SA1456C，路由器K3，机顶盒：华为EC6108 9V（好像A还是E版）\
\
\
方案一：单线双网（iptv盒子拨号获取的是iptv内网，dhcp获取的是正常的Internet上网）\
说明：懂脚本的话，可以通过脚本自动识别当前桌面是iptv还是第三方桌面（当贝桌面），从而自动切换有线网络的上网方式（dhcp、拨号），还有更高级的。不过有关盒子方面的都不在本帖的讨论范围之内。\
1.光猫把Internet和iptv绑在光猫同一个口\
说明：陕西电信Internet的vlanid是空的，iptv的是43。网口1默认是Internet，如图在vlan绑定中把iptv也绑定在网口1\
\
\
 

[![](039_IPTV单线双网教程_000.png)](http://www.right.com.cn/forum/forum.php?mod=viewthread&tid=264963&aid=192302&from=album&page=1&mobile=2)

2.路由器K3刷stons的LEDE（利用其交换机功能来vlan划分），设置好vlan划分\
说明：最好按我建议的设置关，已关联，未关联。

[![](039_IPTV单线双网教程_001.png)](http://www.right.com.cn/forum/forum.php?mod=viewthread&tid=264963&aid=192303&from=album&page=1&mobile=2)

3.新建LAN（建议新命名为IPTV，方便分辨），设置和原有LAN基本完全相同（DHCP的IP改成和原来不一样的，比如原来192.168.1.1，IPTV的改为192.168.2.1），硬件那里的话，LAN保持原来不变（好像是ech.1和无线），IPTV只勾选VLAN43那个（好像是ech.43），路由重启！\
说明：新建vlan是为了避免手机上网的时候获取到的是iptv内网。因为我目前用了另一方案（本帖的方案二），加上我的k3现在是梅林，不是lede，无法截图，不过说的应该也很清楚。\
4.所有设备重启，连接好网线。\
说明：猫网口1------路由wan口\
         路由lan1------iptv\
以上就是方案一的全部内容（从弱电箱到客厅。一条网线，iptv和上网都实现）\
方案二：单线双网（iptv盒子拨号获取的是iptv内网，dhcp获取的是正常的Internet上网）\
说明：1.宽带必须支持双拨   2.此方案不经过路由，只在猫里设置就可以实现   3.弊端就是光猫无法安装去广告插件，要说什么自然你懂得  4.我目前正在用的方案，有视频会员的话，3忽略

游客，如果您要查看本帖隐藏内容请[回复](http://www.right.com.cn/forum/forum.php?mod=post&action=reply&fid=158&tid=264963&mobile=2)

最后的最后，方案一的3和4缺少插图，有k3正在用lede的，截图让我补充完整，尤其是3的配图。\
 
