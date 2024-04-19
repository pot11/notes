Secure Boot

2018年11月16日

11:57

**Secure Boot什么意思？BIOS中Secure Boot灰色无法更改解决方法详解**

2018年08月04日 22:07:18 

Secure Boot：即安全启动

在主板Bios设置中，Secure Boot是UEFI BIOS的一个子规则，位于传统(Legacy)BIOS的BOOT选项下，微软规定所有预装Win8操作系统的厂商(即OEM厂商)都必须打开Secure Boot(在主板里面内置Win8的公钥)。部分主板该选项是Secure Boot Contrl，位于Security选项下。预装Win8系统电脑，一旦关闭这个功能(将其设置为"Disabled\")，将导致无法进入系统。

![](004_Secure_Boot_000.png)

Secure BOOT设计之初作用是防止恶意软件侵入。事实上它能够做到的仅仅是，当电脑引导器被病毒修改之后，它会给出提醒并拒绝启动，避免可能带来的进一步损失。

微软设计Secure Boot的原本用意可能是出于保证系统安全，但结果似乎成了PC厂商保护市场垄断、阻碍竞争的一种手段。似乎也有为了防止安装Windows操作系统的电脑改装[linux](https://www.linuxprobe.com/)的目的。

**BIOS中Secure Boot无法更改解决办法**

在Win8系统中，需要开启Secure Boot才行，而一些预装的win8、win10电脑bios默认开启的是Secure Boot，但如果打算降级win7系统的话则需要将关闭Secure Boot。

对于Secure Boot无法更改，可以通过以下方法解决。

**方法一：**

1、按电脑启动快捷键F2/Del等按键进入BIOS设置，各品牌电脑进入BIOS设置方法；

2、找到OS Optimized Defaults，设置成Disabled或Other OS；

![](004_Secure_Boot_001.png)

3、如果依然显示灰色，则Load Default Settings恢复默认设置。

**方法二：**

1、部分品牌电脑需设置BIOS密码才能修改BIOS选项;

2、在Security中选择Set Supervisor Password，按回车键设置密码。

![](004_Secure_Boot_002.png)

总之，BIOS下Secure Boot灰色无法更改时，你会发现选项修改的位置有所不同，这是跟主板的设置有关系，大家可以查看自己的主板，有选项就设置，没有则略过。
