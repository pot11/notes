#### 【Linux】~、/home与/root的区别
1. ~ 是用户的主目录, root用户的主目录是/root，普通用户的主目录是“/home/普通用户名”  
在root用户下，~等同于/root  
![](./image.png)  
![](.//image-1.png)
2. 在普通用户下，~ 等同于  /home/当前的普通用户名  
   ![Alt text](./image-2.png)  
   ![Alt text](./image-3.png)  
   如果我们建立一个用户，用户名是"xx",那么在/home目录下就有一个对应的/home/xx路径，用来存放用户的主目录。
root是管理员账号，root文件夹是管理员的主目录，它的配置文件还有root的一些别的东西放在这里。而home是给普通用户的，在home下面有用户名对应的文件夹，这些个文件夹就相当于root文件夹，用来存放对应用户的一些资料，配置。 
#### Linux 软件安装到 /usr，/usr/local/ 还是 /opt 目录？
1. /usr：系统级的目录，可以理解为C:/Windows/，/usr/lib理解为C:/Windows/System32
2. /usr/local：用户级的程序目录，可以理解为C:/Progrem Files/。用户自己编译的软件默认会安装到这个目录下。
3. /opt：用户级的程序目录，可以理解为D:/Software，opt有可选的意思，这里可以用于放置第三方大型软件（或游戏），当你不需要时，直接rm -rf掉即可。在硬盘容量不够时，也可将/opt单独挂载到其他磁盘上使用。

4. 源码放哪里？
/usr/src：系统级的源码目录。
/usr/local/src：用户级的源码目录。  
5. /opt  
>Here’s where optional stuff is put. Trying out the latest Firefox beta? Install it to /opt where you can delete it without affecting other settings.  Programs in here usually live inside a single folder whick contains all of their data, libraries, etc.  
>这里主要存放那些可选的程序。你想尝试最新的firefox测试版吗?那就装到/opt目录下吧， 这样，当你尝试完，想删掉firefox的时候，你就可 以直接删除它，而不影响系统其他任何设置。 安装到/opt目录下的程序，它所有的数据、库文件等等都是放在同个目录下面。举个例子：刚才装的测试版firefox，就可以装到/opt/firefox_beta目录下，/opt/firefox_beta目录下面就包含了运 行firefox所需要的所有文件、库、数据等等。要删除firefox的时候，你只需删除/opt/firefox_beta目录即可，非常简单
6. /usr/local
>This is where most manually installed(ie. outside of your package manager) software goes. It has the same structure as /usr. It is a good idea to leave /usr to your package manager and put any custom scripts and things into /usr/local, since nothing important normally lives in /usr/local.  
>这里主要存放那些手动安装的软件， 即不是通过“新立得”或apt-get安装的软件。它和/usr目录具有相类似的目录结构。 让软件包管理器来管理/usr目录，而把自定义的脚本(scripts)放到/usr/local目录下面，我想这应该是个不错的主意



