 

2018年11月16日

13:39

 

**UEFI**，全称Unified Extensible Firmware Interface，即"统一的可扩展固件接口"，是一种详细描述全新类型接口的标准，是适用于电脑的标准固件接口，旨在代替BIOS（基本输入/输出系统）。此标准由UEFI联盟中的140多个技术公司共同创建，其中包括微软公司。UEFI旨在提高软件互操作性和解决BIOS的局限性。

要详细了解UEFI，还得从BIOS讲起。我们都知道，每一台普通的电脑都会有一个BIOS，用于加载电脑最基本的程式码，担负着初始化硬件，检测硬件功能以及引导操作系统的任务。UEFI就是与BIOS相对的概念，这种接口用于操作系统自动从预启动的操作环境，加载到一种操作系统上，从而达到开机程序化繁为简节省时间的目的。传统BIOS技术正在逐步被UEFI取而代之，在最近新出厂的电脑中，很多已经使用UEFI，使用UEFI模式安装操作系统是趋势所在。

 

**UEFI和BIOS有什么不同？优点优势是什么？**

作为传统BIOS（Basic Input/Output System）的继任者，UEFI拥有前辈所不具备的诸多功能，比如图形化界面、多种多样的操作方式、允许植入硬件驱动等等。这些特性让UEFI相比于传统BIOS更加易用、更加多功能、更加方便。而[Windows 8](http://www.ihacksoft.com/windows8/)在发布之初就对外宣布全面支持UEFI，这也促使了众多主板厂商纷纷转投UEFI，并将此作为主板的标准配置之一。

UEFI抛去了传统BIOS需要长时间自检的问题，让硬件初始化以及引导系统变得简洁快速。换种方式说，UEFI已经把电脑的BIOS变得不像是BIOS，而是一个小型固化在主板上的操作系统一样，加上UEFI本身的开发语言已经从汇编转变成C语言，高级语言的加入让厂商深度开发UEFI变为可能。

以下关于 **UEFI的特点** 来自微软官网：

1、通过保护预启动或预引导进程，抵御bootkit攻击，从而提高安全性。

2、缩短了启动时间和从休眠状态恢复的时间。

3、支持容量超过2.2 TB的驱动器。

4、支持64位的现代固件设备驱动程序，系统在启动过程中可以使用它们来对超过172亿GB的内存进行寻址。

5、UEFI硬件可与BIOS结合使用。

以下关于 **BIOS和UEFI的区别** 来自网络：

UEFI是BIOS的一种升级替代方案。关于BIOS和UEFI二者的比较，如果仅从系统启动原理方面来做比较，UEFI之所以比BIOS强大，是因为UEFI本身已经相当于一个微型操作系统，其带来的便利之处在于：

首先，UEFI已具备文件系统的支持，它能够直接读取FAT分区中的文件。什么是文件系统？简单说，文件系统是操作系统组织管理文件的一种方法，直白点说就是把硬盘上的数据以文件的形式呈现给用户。Fat32、NTFS都是常见的文件系统类型。

其次，可开发出直接在UEFI下运行的应用程序，这类程序文件通常以efi结尾。既然UEFI可以直接识别FAT分区中的文件，又有可直接在其中运行的应用程序。那么完全可以将Windows安装程序做成efi类型应用程序，然后把它放到任意fat分区中直接运行即可，如此一来安装Windows操作系统这件过去看上去稍微有点复杂的事情突然就变非常简单了，就像在Windows下打开[QQ](http://www.ihacksoft.com/qq/)一样简单。而事实上，也就是这么一回事。

最后，要知道这些都是BIOS做不到的。因为BIOS下启动操作系统之前，必须从硬盘上指定扇区读取系统启动代码（包含在主引导记录中），然后从活动分区中引导启动操作系统。对扇区的操作远比不上对分区中文件的操作更直观更简单，所以在BIOS下引导安装Windows操作系统，我们不得不使用一些工具对设备进行配置以达到启动要求。而在UEFI下，这些统统都不需要，不再需要主引导记录，不再需要活动分区，不需要任何工具，只要复制安装文件到一个FAT32（主）分区/U盘中，然后从这个分区/U盘启动，安装Windows就是这么简单。
