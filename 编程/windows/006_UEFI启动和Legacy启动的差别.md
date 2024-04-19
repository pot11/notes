**UEFI启动和Legacy启动的差别**

2018年11月16日

12:04

 

1.   

> ![](006_UEFI启动和Legacy启动的差别_000.png)
>
>  
>
> **Legacy BIOS Boot 是如何启动或引导的**
>
>  
>
> 当系统首次引导时，或系统被重置时，处理器会执行一个位于已知位置处的代码。这个位置在基本输入 / 输出系统（BIOS） 中。CPU 会调用这个重置 向量来启动一个位于闪存/ROM 中的已知地址处的程序。通常，它执行一个启动自测（POST）来检查机器。最后，它从引导驱动器上的主引导记录 （MBR）加载第一个扇区。
>
>  
>
> 引导程序就位于 MBR 第一个扇区里面。此时引导程序就被装入 RAM 并执行。这个引导加载程序在大小上小于 512 字节（一个扇区）。 BIOS 自检完成之后，将 MBR 的代码读入内存，管理权交给 MBR ， MBR 再读取 DPT ， 从 DPT （Disk Partition Table，硬盘分区表占据 MBR 扇区的64个字节(偏移01BEH\--偏移01FDH)）找出硬盘的 所有分区哪一个是激活的主分区。到这里为止，所以系统都是一样的。下面就有区别了。 DPT读完找到主分区之后然后找到这个主分区 的 PBR （Partition Boot Record 分区引导记录），PBR位于激活主分区的第一个扇区。安装不同操作系统的时候 PBR 是会 被改变的， XP 的 PBR 写死的代码是去找 NTLDR 。而 Vista 和 7 的 PBR 里写进的就是去找 Bootmgr 。
>
>  
>
> 这个时候显示器上还没有显示引导管理器的界面。 Bootmgr 被找到之后管理权就交到了 Bootmgr。 Boot Manager 首先 从 BCD 中读取 Boot Manager 菜单的语言版本信息，然后再调用 BOOTMGR 与相应语言的 BOOTMGR.EXE.MUI 组成 相应语言的启动菜单，之后才会在显示器上显示引导管理器，也就是选择多操作系统的那个文字界面。最后，当你选择了相应的操作系统，这里 是 Win7 或 8 （如果选择 XP, 会转入 XP 的启动流程，找到 XP 的NTLDR 然后启动）， Bootmgr 就去寻找系统分区（系 统分区和主分区的概念不是一样的哦）Windows/System32 下的 Winload.exe 加载操作系统内核。
>
> ![](006_UEFI启动和Legacy启动的差别_001.png)
>
>  
>
> **EFI Boot 介绍**
>
>  
>
> EFI 的全称是可扩展固件接口 (Extensible Firmware Interface)，它是 Intel 公司为全新类型的固件体系结构、 接口和服务提出的建议性标准。该标准有两个主要用途：向操作系统的引导程序和某些在计算机初始化时运行的应用程序提供一套标准的运行环境；为操作系统提供 一套与固件通讯的交互协议。
>
>  
>
> 简单说，EFI 是 BIOS 的替代者。它为操作系统和固件提供了更加强大、安全、方便的交互途径。EFI 规范定义的接口，包括数据表包含平台的信息，可在 OS Loader 和 OS 的启动和运行时服务。 
>
> EFI 固件提供了几种技术优势：

1.  引导能力支持大容量磁盘（超过 2 TIB ）；

2.  更快的启动；

3.  独立 CPU 的体系结构；

4.  CPU 的独立的驱动程序；

5.  灵活的预操作系统环境，包括网络功能；

6.  模块化设计；

> EFI 启动还需要一个特殊的分区表，该分区表指向一个特殊的文件。通常情况下该文件位于EFI 路径，EFI 启动涉及到一个写入 到 firmware 中的 boot loader, EFI 并不把启动程序放置在 MBR 中，firmware 知道如何读取分区表以 及 FAT 的文件格式。EFI 系统分区是用 FAT 格式格式化的特定分区，其中包 含 boot loader, 该 boot loader 是 EFI 可执行程序，可被 EFI boot manager 载入和运行。
>
> Boot loader 被设置为一个可以通过固件访问的文件。Boot loader 允许用户选择并加载操作系统。所有的 boot manager 都包含一个 EFI 变量，该变量被用来定义固件配置参数。
>
>  
>
> **MBR 与 GPT**
>
>  
>
> MBR：主引导记录（Master Boot Record，缩写：MBR），又叫做主引导扇区，是计算机开机后访问硬盘时所必须要读取的首个扇区，它在硬盘上的三维地址为（柱面，磁头，扇区）＝（0，0，1）。
>
>  
>
> 主引导扇区记录着硬盘本身的相关信息以及硬盘各个分区的大小及位置信息，是数据信息的重要入口。如果它受到破坏，硬盘上的基本数据结构信息将会丢失，需要 用繁琐的方式试探性的重建数据结构信息后才可能重新访问原先的数据。主引导扇区内的信息是通过分区程序写入的，它是低级格式化的产物，和操作系统没有任何 关系（操作系统是创建在高级格式化的硬盘分区之上，是和一定的文件系统相联系的）。
>
>  
>
> 对于硬盘而言，一个扇区可能的字节数为 128×2n (n=0,1,2,3)。大多情况下，取 n=2，即一个扇区（sector）的大小为 512 字节。
>
>  
>
> MBR 的限制：

1.  在 MBR 分区表中最多 4 个主分区或者 3 个主分区＋1 个扩展分区：从主引导记录的结构可以知道，它仅仅包含一个 64 个字节的硬盘分区表。 由于每个分区信息需要 16 个字节，所以对于采用 MBR 型分区结构的硬盘，最多只能识别 4 个主要分区（Primary partition）。

2.  MBR 分区方案无法支持超过 2TB 容量的磁盘。因为这一方案用 4 个字节存储分区的总扇区数，最大能表示 2 的 32 次方的扇区个数，按每扇 区 512 字节计算，每个分区最大不能超过 2TB 。磁盘容量超过 2TB 以后，分区的起始位置也就无法表示了。

> GPT：全局唯一标识分区表（GUID Partition Table，缩写：GPT）是一个实体硬盘的分区结构。GUID 分区表 (GPT) 是作 为 Extensible Firmware Interface (EFI) 计划的一部分引入的。相对于 PC 常用的较旧的主引导记 录 (MBR) 分区方案，GPT 提供了更加灵活的磁盘分区机制。
>
> GPT 使用 GUID 分区表 (GPT) 磁盘分区系统。GPT 磁盘提供了以下好处：

1.  最多允许 128 个分区；主引导记录 (MBR) 磁盘可以支持 4 个主分区和扩展分区内的 124 个附加分区。

2.  允许大于 2 TB 的卷容量，而 2 TB 是 MBR 磁盘的极限。

3.  由于分区表提供了复制和循环冗余校检 (CRC) 保护，所以更加可靠。

4.  能在所有基于 x64 平台上用作存储卷，包括运行 Windows XP Professional x64 Edition 的平台。 从 Windows Server 2003 SP1 开始，GPT 磁盘也可用作基于 x86 的Windows 平台上的存储卷。

5.  可用作基于 x64 的 Windows 7、Windows Vista 和 Windows Server 2008 版本上的引导卷。从 Windows Server 2003 SP1 开始，GPT 磁盘也可用作基于 Itanium 的系统上的引导卷。

> 注意：Windows 仅支持从包含 Unified Extensible Firmware Interface (UEFI) 引导固件的系统上的 GPT 磁盘引导。
>
>  
>
> **GOP 与 VBIOS 的区别**
>
>  
>
> VBIOS 是计算机图形卡或集成图形控制器的 BIOS，类似系统 BIOS 提供了一组软件所使用的程序函数来访问系统硬件一样，VBIOS 也是提 供了一组视频相关的程序使用的函数访问视频硬件。通常由显卡厂商提供一个二进制 Bin 文件给 ODM 厂商，将其包在系统 BIOS 中。
>
>  
>
> 而 GOP (Graphic Output Protocol) driver 是 EFI 架构下取代传统 VBIOS 黑箱的 EFI driver，它被设计成在操作系统启动之前支持基本需求的图形输出功能。
>
>  
>
> VBT: Video bios table。 VBT 是一个特别制作的客制化过得特殊 binary 数据块。靠 BMP utility 来编辑。VBT 同样如同 legacy vbios 一 样记录了 detail timing、GPIO Pins、Clock 等显示方面的参数信息。
>
>  
>
> 两者的不同点：Pre-OS boot 时期，EFI 是通过标准的 GOP protocol 来实现显示 output。而 lagacy vbios需要通过 INT10 interrupter 来实现。
