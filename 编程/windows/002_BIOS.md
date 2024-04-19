BIOS

2018年11月16日

11:10

 

<table>
<colgroup>
<col style="width: 54%" />
<col style="width: 45%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>存储位置</strong></td>
<td><p><a href="https://zh.wikipedia.org/wiki/PROM">PROM</a></p>
<p><a href="https://zh.wikipedia.org/wiki/EPROM">EPROM</a></p>
<p><a href="https://zh.wikipedia.org/wiki/%E5%BF%AB%E9%96%83%E8%A8%98%E6%86%B6%E9%AB%94">闪存</a></p></td>
</tr>
</tbody>
</table>

**BIOS**

**BIOS**（**B**asic **I**nput/**O**utput **S**ystem的缩写、中文：**基本输入输出系统**），在[IBM PC兼容系统](https://zh.wikipedia.org/w/index.php?title=IBM_PC%E7%9B%B8%E5%AE%B9%E7%B3%BB%E7%B5%B1&action=edit&redlink=1)上，是一种业界标准的[固件](https://zh.wikipedia.org/wiki/%E9%9F%8C%E9%AB%94)[接口](https://zh.wikipedia.org/wiki/%E4%BB%8B%E9%9D%A2_(%E8%B3%87%E8%A8%8A%E7%A7%91%E6%8A%80))。[^\[1\]^](https://zh.wikipedia.org/wiki/BIOS#cite_note-pcguidedefinition-1)。BIOS这个字眼是在1975年第一次由[CP/M](https://zh.wikipedia.org/wiki/CP/M)操作系统中出现。BIOS是[个人计算机](https://zh.wikipedia.org/wiki/%E4%B8%AA%E4%BA%BA%E7%94%B5%E8%84%91)启动时加载的第一个软件（实际上自Intel Haswell平台以后，UEFI BIOS并不是系统引导时第一个被加载的软件）。

BIOS用于计算机引导时运行系统各部分的自我检测（Power On Self Test），并加载[引导程序（IPL）](https://zh.wikipedia.org/w/index.php?title=%E5%BC%95%E5%AF%BC%E7%A8%8B%E5%BA%8F%EF%BC%88IPL%EF%BC%89&action=edit&redlink=1)或存储在主存的[操作系统](https://zh.wikipedia.org/wiki/%E4%BD%9C%E6%A5%AD%E7%B3%BB%E7%B5%B1)。此外，BIOS还向操作系统提供一些系统参数。系统硬件的变化是由BIOS隐藏，程序使用BIOS功能而不是直接控制硬件。现代操作系统会忽略BIOS提供的抽象层并直接控制硬件组件。

 

来自 \<<https://zh.wikipedia.org/wiki/BIOS>\>

 

 

**启动计算机原理**

当计算机的电源打开，BIOS就会由[主板](https://zh.wikipedia.org/wiki/%E4%B8%BB%E6%A9%9F%E6%9D%BF)上的[闪存](https://zh.wikipedia.org/wiki/%E5%BF%AB%E9%96%83%E8%A8%98%E6%86%B6%E9%AB%94)（flash memory）运行，并将芯片组和存储器子系统初始化。BIOS会把自己从闪存中，解压缩到系统的主存；并且从那边开始运行。PC的BIOS代码也包含诊断功能，以保证某些重要硬件组件，像是[键盘](https://zh.wikipedia.org/wiki/%E9%8D%B5%E7%9B%A4)、[磁盘](https://zh.wikipedia.org/wiki/%E7%A3%81%E7%A2%9F)（BIOS在引导时会侦测硬盘的[S.M.A.R.T.](https://zh.wikipedia.org/wiki/S.M.A.R.T.)状态）、输出输入端口等等，可以正常运作且正确地初始化。几乎所有的BIOS都包含设置程序（BIOS Setup），可以进行BIOS的设置，如设置系统时间，设置引导设备顺序，激活/禁用计算机的某些周边设备。主板的CMOS芯片（[UEFI](https://zh.wikipedia.org/wiki/UEFI)多使用[NVRAM](https://zh.wikipedia.org/wiki/NVRAM)存储UEFI设置值/硬件侦测信息）用于存储BIOS设置值及硬件侦测信息。主板上的钮扣电池用于让CMOS芯片存储BIOS设置值，以及计算机在断电时依然可以让系统时钟运作。CMOS在没有电力供应（CMOS所需电力由主板上的钮扣电池提供）的情况下会丢失存储的数据，而NVRAM则不会。

[IBM](https://zh.wikipedia.org/wiki/IBM)技术参考手册中曾经包含早期PC和AT BIOS的[80x86](https://zh.wikipedia.org/wiki/80x86)源代码。

现代的BIOS可以让用户选择由哪个设备启动计算机，如[光盘驱动器](https://zh.wikipedia.org/wiki/%E5%85%89%E7%A2%9F%E6%A9%9F)、[硬盘](https://zh.wikipedia.org/wiki/%E7%A1%AC%E7%A2%9F)、[软盘](https://zh.wikipedia.org/wiki/%E8%BB%9F%E7%A2%9F)、USB [U盘](https://zh.wikipedia.org/wiki/%E9%9A%A8%E8%BA%AB%E7%A2%9F)等等。这项功能对于安装[操作系统](https://zh.wikipedia.org/wiki/%E4%BD%9C%E6%A5%AD%E7%B3%BB%E7%B5%B1)、以[LiveCD](https://zh.wikipedia.org/wiki/LiveCD)启动计算机、以及改变计算机找寻引导媒体的顺序特别有用。

有些BIOS系统允许用户可以选择要加载哪个[操作系统](https://zh.wikipedia.org/wiki/%E4%BD%9C%E6%A5%AD%E7%B3%BB%E7%B5%B1)（例如从第二颗硬盘加载其他操作系统），虽然这项功能通常是由第二阶段的[引导程序](https://zh.wikipedia.org/wiki/%E5%BC%95%E5%AF%BC%E7%A8%8B%E5%BA%8F)（boot loader）来处理。

许多OEM个人计算机亦包含可在加载操作系统前运行的硬件诊断程序/系统还原程序，可在引导时按特定的按键运行硬件诊断程序/系统还原程序，或者在BIOS的引导菜单中运行。对于早期的OEM个人计算机，诊断程序可能内置于BIOS程序，也可能内置于一个隐藏的OEM磁盘分割中；对于基于UEFI固件的OEM个人计算机而言，诊断程序可能内置于UEFI固件中，也可能内置于EFI系统盘分割（ESP）/OEM磁盘分割中。

 

**BIOS固件**

由于BIOS与硬件系统集成在一起（将BIOS程序指令刻录在IC中），所以有时候也被称为[固件](https://zh.wikipedia.org/wiki/%E9%9F%8C%E9%AB%94)。在大约1990年BIOS是保存在[ROM](https://zh.wikipedia.org/wiki/ROM)（[只读存储器](https://zh.wikipedia.org/wiki/%E5%94%AF%E8%AE%80%E8%A8%98%E6%86%B6%E9%AB%94)）中而无法被修改。因为BIOS的大小和复杂程度随时间不断增加，而且硬件的更新速度加快，令BIOS也必须不断更新以支持新硬件，于是BIOS就改为存储在[EEPROM](https://zh.wikipedia.org/wiki/EEPROM)或者[闪存](https://zh.wikipedia.org/wiki/%E5%BF%AB%E9%96%83%E8%A8%98%E6%86%B6%E9%AB%94)中，让用户可以轻易更新BIOS。然而，不适当的运行或是终止BIOS更新可能导致计算机或是设备无法使用。为了避免BIOS损坏，有些新的[主板](https://zh.wikipedia.org/wiki/%E4%B8%BB%E6%A9%9F%E6%9D%BF)有备份的BIOS（"双BIOS"主板）。有些BIOS有"启动区块"（Boot Block），属于只读存储器的一部分，一开始就会被运行且无法被更新。这个程序会在运行BIOS前，验证BIOS其他部分是否正确无误（经由检查码，凑杂码等等）。如果启动区块侦测到主要的BIOS已损坏，则可自动读取U盘/光盘中的特定BIOS文件并更新BIOS。硬件制造厂商经常发出BIOS升级来更新他们的产品和修正已知的问题。现在的BIOS多内置BIOS更新程序，且在更新BIOS时会校验BIOS文件。

 

 

**BIOS简介：**

BIOS是英文\"Basic Input Output System\"的 缩略词，直译过来后中文名称就是\"基本输入输出系统\"。 其实它是一组固化到计算机内主板 上一个ROM  芯片上的程序 ，它保存着计算机 最重要的基本输入输出的程序 、开机后自检程序和系统自启动程序，它可从CMOS中读写系统设置的具体信息。 其主要功能是为计算机提供最底层的、最直接的硬件设置和控制。 

当今，此系统已成为一些病毒木马的目标。一旦此系统被破坏，其后果不堪设想

来自 \<<https://zh.wikipedia.org/wiki/BIOS>\>
