 

2018年11月16日

13:54

 

**计算机到底如何启动？(UEFI boot)**

**引言**

为了把BIOS和UEFI的区别弄清楚，我查了一些关于计算机启动的资料，其中看到一篇翻译自国外技术论坛的文章，[（译）UEFI启动：实际工作原理](http://www.tuicool.com/articles/NNf26jB)纠正了我之前许多错误的认识，我重新整理、添加了一些东西，把这篇文章分享给大家，能够有一个更清晰的认识。

 

**概念**

如果想真正了解有关 UEFI 的权威知识，可以查看 UEFI 规范（[可以访问官方UEFI网站](http://www.uefi.org/specs/download)）。

 

![](010_计算机到底如何启动？(UEFI_boot)_000.png)

 

 

那么先来了解一些概念：

**UEFI（**

> **Unified Extensible Firmware Interface，**
>
> **统一的可扩展固件接口）**

BIOS 和 UEFI 都是计算机的固件类型。BIOS 固件（主要）用于 IBM PC 兼容机 。UEFI 的通用性更强，可用在非"IBM PC 兼容"系列的计算机上。

不存在"UEFI BIOS"。没有任何一台计算机会有"UEFI BIOS"。请不要再说"UEFI BIOS"。BIOS 不是所有 PC 固件的通用术语，它只是 PC 固件的一种特定类型。计算机中包含固件。如果你有一台 IBM PC 兼容计算机，那么固件几乎肯定就是 BIOS 或 UEFI。当然也有例外，如Coreboot（

> LinuxBIOS）。

还有一个重点要了解：为了向UEFI转换，以适应UEFI，有许多 UEFI 固件实现了某种 BIOS 兼容模式（有时候称为 CSM）。

许多 UEFI 固件可以像 BIOS 固件一样启动系统，它们可以查找磁盘上的 MBR，然后从 MBR 中执行启动装载程序，接着将后续工作完全交给启动装载程序。有时候，人们会误将此功能称为"禁用 UEFI"，从语言的严谨角度来说，这种说法是不正确的。系统固件是无法"禁用"的。在其他人这么说的时候，应该了解他们真正想表达什么。他们讨论的是通过 UEFI 固件的一项功能，以"BIOS 风格"启动系统，而不是采用原生 UEFI 方式启动系统。

 

 

**Secure Boot（安全启动）**

和UEFI不是同一个概念。请不要混淆使用。Secure Boot)实际上是 UEFI 规范的一项可选功能，于 UEFI 规范版本 2.2 引入。我们首先讨论 UEFI，然后我们将把Secure Boot 作为 UEFI 的一项"扩展"来进行讨论，因为这就是Secure Boot 的本质。

 

**GPT（**

> **GUID Partition Table，**
>
> **全局唯一标识磁盘分区表）**
>
>  
>
> [![](010_计算机到底如何启动？(UEFI_boot)_001.png)](http://www.iruanmi.com/what-is-gpt-and-what-is-uefi/)

 

在GTP磁盘的第一个数据块中同样有一个与MBR（主引导记录）类似的标记，叫做PMBR（保护性MBR，为了保持兼容）。

> PMBR保护GPT磁盘不受以前发布的MBR磁盘工具（比如
>
> FDISK
>
> 或WindowsNT磁盘管理器）的危害。PMBR的作用是，当使用那些不支持GPT的分区工具时，整个硬盘将显示为一个受保护的分区，以防止分区表及硬盘数据遭到破坏。

 

UEFI并不从PMBR中获取GPT磁盘的分区信息，它有自己的分区表，即GPT分区表。

需要注意的是因为BIOS无法识别GPT分区，所以BIOS下GPT磁盘不能用于启动操作系统，在操作系统提供支持的情况下可用于数据存储。

UEFI可以识别MBR分区和GPT分区，因此UEFI下，MBR磁盘和GPT磁盘都可用于启动操作系统和数据存储。不过微软限制，UEFI下使用Windows安装程序安装操作系统是只能将系统安装在GPT磁盘中。

 

**EFI可执行文件**

 

UEFI 规范定义了一种可执行文件格式，并要求所有 UEFI 固件能够执行此格式的代码。当开发人员为原生 UEFI 编写启动装载程序时，就必须按照这种格式编写。

 

**EFI系统分区（EFI System Partition）**

 

它是当我们首次为GPT磁盘分区时会提示建立的，对于UEFI启动来说，ESP分区不是必需的，但是一个FAT分区确是必须的。

 

EFI系统分区的本质是一个FAT分区，只不过分区程序在给GPT磁盘分区的时候会提醒你建立EFI系统分区，并且你同意了，那么程序将建立一个指定大小的FAT分区，并且命名为\"ESP\"，我们可以看出 ESP分区可以用任意位置的任意大小的任意FAT分区代替。

 

 

**启动**

**开机**

假设现在是UEFI启动，而不是采用BIOS 兼容模式来启动计算机。

**启动顺序**

启动模块根据启动项顺序（和BIOS启动类似，可参考我另一篇文章：[计算机到底是如何启动的？（传统BIOS）](http://blog.csdn.net/u013201439/article/details/50273113)）依次查找所有（FAT分区）："\\efi\\boot\\bootia32.efi"（IA32构架的启动文件）或者（FAT分区）："\\efi\\boot\\bootx64.efi"（X64构架的启动文件）找到我们上文提到的EFI文件。

 

由于这里的以启动windows操作系统为例，.efi中的内容下一步会指向" \\efi\\microsoft\\BCD"

加载BCD 启动菜单文件

 

按照BCD里面的内容进一步启动

 

[BIOS](https://en.wikipedia.org/wiki/BIOS)

[UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)

[coreboot](http://www.coreboot.org/Welcome_to_coreboot)

[UEFI+GPT](http://www.iruanmi.com/what-is-gpt-and-what-is-uefi/)

[UEFI启动解析：由原理到实例](http://www.szchehang.com/news/7159.html)

 

 

 

 

来自 \<<https://blog.csdn.net/u013201439/article/details/50195743>\>

 
