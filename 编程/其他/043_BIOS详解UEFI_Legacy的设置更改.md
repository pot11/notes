BIOS详解UEFI/Legacy的设置更改

Monday, May 15, 2017

10:25 AM

 

BIOS详解UEFI/Legacy的设置更改2016-11-01 03:49[Legacy](https://m.sanwen8.cn/tag/15719.html)

 

 

**制汇科技**

      旗下针对戴尔、联想、惠普、宏基等品牌或兼容机进行线下软硬件售后技术支持，拥有各技术支持平台与技术交流群。制汇科技给您更专业的服务，希望您的加入并支持！

 

**详解UEFI/Legacy的设置更改：**

UEFI/Legacy介绍

-   UEFI 全名"统一的可扩展固件接口"，相对于"Legacy BIOS"（传统BIOS ）有着更多的优势：模块化设计、图形化的界面、更强的兼容性和拓展性

-   Legacy BIOS模式：  支持所有32位WINDOWS 8系统的安装，支持在MBR硬盘分区结构下64位WINDOWS 8的安装，不支持硬盘的GPT的分区 结构。

-   UEFI BIOS模式：  支持GPT分区结构下的64位WINDOWS 8系统的安装

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

gg\
 

分区表介绍

-   MBR分区表：Master Boot Record，即硬盘主引导记录分区表，只支持容量在 2.1TB 以下的硬盘，超过2.1TB的硬盘只能管理2.1TB，最多只支持4个主分区或三个主分区和一个扩展分区，扩展分区下可以有多个逻辑分区。

-   GPT分区表：GPT，全局唯一标识分区表(GUID Partition Table)，与MBR最大4个分区表项的限制相比，GPT对分区数量没有限制，但Windows最大仅支持128个GPT分区，GPT可管理硬盘大小达到了18EB。只有基于UEFI平台的主板才支持GPT分区引导启动。

-   ESP分区：EFI system partition，该分区用于采用了EFI BIOS的电脑系统，用来启动操作系统。分区内存放引导管理程序、驱动程序、系统维护工具等。如果电脑采用了EFI系统，或当前磁盘用于在EFI平台上启动操作系统，则应建议ESP分区。MSR分区：即微软保留分区，是GPT磁盘上用于保留空间以备用的分区。

SECURE BOOT功能

-   SECURE BOOT功能:Secure Boot只是UEFI的一个部分。两者的关系是局部与整体的关系。

-   首先明确Windows 8.1，在不打开Secure Boot的情况下，Windows 8可以安装。这与安装以前版本的Windows没有差别。但是，微软规定，所有预装Windows 8的厂商（即OEM厂商）都必须打开Secure Boot。因此，消费者购买一台预装Windows 8的台式机或笔记本，想要在上面再安装其他操作系统（包括以前版本的Windows）是不可能的，除非关闭Secure Boot，或者其他操作系统能够通过Windows 8公钥的认证。如果选择关闭Secure boot后，可能导致预装的Windows 8无法使用，需要重新安装。

Legacy BIOS模式

-   并不是所有Windows 8.1都可以安装在UEFI模式下，即使你的BIOS是UEFI BIOS，有时也会无法安装，这是因为它与硬盘的分区结构、Windows 8.1是32位还是64位有关。在UEFI BIOS中，为了兼容以前的操作系统，还提供了Legacy BIOS模式支持所有32位Windows 8.1系统的安装，支持在MBR硬盘分区结构下64位Windows 8.1的安装，不支持硬盘的GPT的分区结构。

-   Legcy BIOS即我们老式BIOS与UEFU BIOS区别在于引导方式不同，换一句话说就相当于两种接口，所以要用UEFI启动必须要支持UEFI的U盘、光盘、PE等。

-    

 

-   Windows7不支持UEFI启动，在Legacy下且分区格式为MBR

-   Windows8.1双模式支持，多数在UEFI下且分区格式为GPT

Legacy BIOS 模式

Legacy模式下 Secure Boot为关闭状态（Disabled）(bios及F12对应图)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

UEFI BIOS模式

UEFI BIOS模式：支持GPT分区结构下的64位WINDOWS 8系统的安装，此时BIOS设置如下：Secure Boot为开启状态（Enabled）

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

UEFI模式下关闭了Secure Boot的这种情况

出现在UEFI模式下关闭了Secure Boot的这种情况，此时BIOS设置如下：所有3个选项均为蓝色（可选）且Secure Boot为关闭状态（Disabled））扩展阅读：如果需要在UEFI模式使用光盘来安装系统的话，如果光驱中没有光盘的话，在F12界面也是看不到光驱选项的，必须先\*\*光盘或U盘。

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

商用机型如何更改bios\
 

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

家用机型bios更改(方法1)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

家用机型bios更改(方法2)

目前DELL机器在F12 BOOT MENU 中都是带有 Change Boot Mode Setting选项，我们选中双击 就可以启用 Legacy或UEFI模式。

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

UEFI & Legacy BOOT

-   **UEFI boot\
    支持Sercure boot /GPT分区表 /win7 & win8 8.1\
    必须有支持UEFI启动的设备才会在启动菜单显示\
    兼容模式(load legacy opt rom)**

-   **Legacy boot\
    支持MBR分区表/xp.win7.win8**

-    

-   由于Win7/8.1的BIOS模式，分区表不同安装版系统在磁盘安装时会无法进行，接下来我们来尝试更改分区表

磁盘分区格式转换(方法1：命令行转化)

-   Shift + F10

-   Diskpart 回车

-   list disk 回车

-   select disk 0 回车

-   clean 回车

-   convert mbr / convert gpt 回车

1.使用Win7/8.1光盘或者U盘引导，进入系统安装分区界面后报错不能安装无法下一步：

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

 

2.按Shift + F10打开命令提示符 / 按Shift +Fn+ F10 打开命令提示符 进行磁盘分区转换

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

3.输入"Diskpart"(不用输入引号，下同)，并按回车，进入操作界面\
 

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

4.输入："list disk"，查看磁盘信息。注意看磁盘容量来选择。图中465G的Disk 0是硬盘，3852M的Disk 1是测试安装的U盘。

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

 

5.输入："select disk 0"，选择disk 0为当前操作的磁盘

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

 

6.输入"clean"清空当前磁盘分区

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

 

7.输入转换分区命令\
-(1 输入"convert mbr"转换MBR分区用于安装Windows7操作系统\
-(2 输入"convert gpt"转换GPT分区用于安装Windows8.1操作系统

磁盘分区格式转换(方法2：GD分区工具)

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

 

![](043_BIOS详解UEFI_Legacy的设置更改_000.png)

 
