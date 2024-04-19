 

2018年11月18日

19:20

 

window系统iso解压后为

![](016_window系统iso解压后为_000.png)

 

 

wim是微软自Vista开始采用的一种全新的Windows映像格式（Windows Imaging Format）。如果你现在手里有一个微软原版ISO镜像的话，打开镜像中的sources目录你会发现有两个wim格式的文件：install.wim和boot.wim。在镜像中最重要的也就是这两个文件，看看他们的大小就知道。

 

其中的install.wim文件包含我们要安装的操作系统的所有文件，也就是说我们只需要install.wim这个文件，再配合相关的工具就可以完成系统的安装。那么另外一个boot.wim是干什么的呢？不知道你是否意识到，我们从U盘或光盘启动安装操作系统时首先进入的是一个叫做Windows预安装环境的微型操作系统（就是WinPE，微软官方的PE）。而与之相关的系统文件就包含在boot.wim中。

 

[\[技术\]](http://bbs.pcbeta.com/forum.php?mod=forumdisplay&fid=548&filter=typeid&typeid=1210)** **[最为纯净的Windows10 U盘启动盘制作方法(支持install.wim大于4G)](http://bbs.pcbeta.com/viewthread-1761555-1-1.html)

之前一直用UltraISO制作启动盘毫无问题直到微软放出了单个文件大于4G的1703 June版本以后一切都变了

网上各种方法层出不穷，对比试验了所有的方法后最终总结出了一套最最最干净的方法同时也兼顾了最最最兼容的模式特别适合有强迫症的人群。

废话少说直接上方法最后再对比其它方式的优劣

 

以目前最新的[win10](http://bbs.pcbeta.com/forum-548-1.html)版本为例:cn_windows_10_multiple_editions_version_1703_updated_july_2017_x64_dvd_10925382.iso

1\. 先加载微软原版ISO文件，然后用win+x打开管理员模式的Windows PowerShell,输入Dism /Split-Image /ImageFile:\\E:\\sources\\install.wim /SWMFile:D:\\install.swm /FileSize:4000

(其中E:\\sources是ISO加载后的盘符，D:\\是保存文件分割后的目标盘符，4000是单个文件不超过4G)

 

2\. 弹出之前加载的ISO文件，放入U盘，启动UltraISO，打开微软原版ISO，找到sources目录下的那个install.wim直接删除

然后从启动菜单选择写入硬盘镜像，所有参数保持默认直接点写入，因为最大的文件没有了，写入非常快

 

3\. 完成后退出UltraISO，不必保存之前的改动，打开资源管理器，找到之前分割完成的install.swm和install2.swm文件，复制到U盘的sources目录下就完成了所有步骤。

 

接下来这个步骤是可选的，是教你如何彻底清除U盘(因为之前可能用了Rufus产生了2个分区和FAT32分区上的MBR引导记录)

1\. 打开Windows PowerShell，输入diskpart

2\. list disk(记住U盘的磁盘号)

3\. select disk 1(假设U盘的磁盘号是1)

4\. clean

5\. exit

打开windows磁盘管理器，右键单击U盘选择创建新的卷，至此你的U盘相当于做了磁盘初始化，彻底清除了所有东西

 

 

为什么说这是最纯净最兼容的方法，因为用了微软自带的工具DISM完成了文件分割，UltraISO默认写入方式不会添加任何多余文件，也不会产生额外分区，文件系统仍旧保持FAT32以满足最大的兼容性，U盘的通用性和易用性都得到保障

对比其它常用方式

1\. WinPE启动安装

首先找一个纯净的WinPE就是一个麻烦的事，那些自带UI的国人定制版里面垃圾遍地碰都不想碰。微软的ADK可以产生纯净的PE但只有命令行方式没有图形界面，而且需要额外下载手动复制出来生产ISO再刻录，启动后还需要找到原版Windows10ISO已经释放好的目录来执行，一般是提前释放在了硬盘上，费事费力，而且WinPE也是每出一个安装盘版本需要相应一起更新。

步骤如下：先从https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit下载对应的ADK，安装界面里必须选择部署工具和Windows预安装环境这2项，安装完成后启动部署和映像环境工具，输入copype amd64 D:\\amd64，再输入MakeWinPEMedia /ISO D:\\amd64 D:\\amd64.iso，这样就得到了官方的最纯净PE。

 

2\. Rufus

因为这个工具有个选项是可以直接制作"用于UEFI计算机和GPT分区方案"的U盘启动盘所以备受推崇

这个原理就是因为EFI的引导方式目前只支持Fat/Fat32的文件格式系统，如果是Fat32的话，那大于4G的文件是无法写入的

这就会强迫你用NTFS的文件格式，但这样的话EFI又无法识别，所以Rufus就会生成2个分区，一个是FAT32的用于EFI引导，然后引导的同时加载了ntfs_x64.efi来识别NTFS文件格式，这样另一个NTFS的分区上的大于4G的文件可以被读取

 

3\. UltraISO

其实UltraISO也可以实现和Rufus一样的效果，但需要手动操作，不像Rufus可以一键完成而已，具体步骤我也不写了，大致意思就是在写入硬盘镜像的隐藏启动分区里选高级隐藏，U盘如果已经格式化成NTFS的话便捷启动里要选便捷写入，否则要写完后从Fat32用命令转成NTFS，等生成2个分区后要往Fat分区里拷贝NTFS分区上面的boot目录等文件，确实比Rufus麻烦不少，但原理是一模一样的

 

最后总结一下，说到底其实就是微软自己太懒给大家带来这么多麻烦，既然你的安装程序已经可以直接识别.swm的文件了，你丫发布新的安装镜像的时候就不能自己先把install.wim分割成小于4G的若干.swm文件放在ISO里面吗，这样的话哪来这么多麻烦事啊\...\...

 

|     |
|-----|
|     |

 

 
