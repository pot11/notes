**简单UEFI与legacy设置**

2018年11月16日

12:07

BIOS指定从U盘UEFI安装系统：

1.  切换到Boot，选择UEFI Boot回车设置为Enabled

2.  笔记本则在Startup下，把UEFI/Legacy Boot设置为UEFI Only

3.  把Boot Type设置为UEFI Boot Type

4.  有uefi选项，Launch CSM默认是Disabled，并开启Secure Boot，开启Secure boot就不能识别启动盘，包括uefi启动盘，所以要禁用Secure Boot，CSM开启时表示Legacy模式，关闭时表示UEFI模式
