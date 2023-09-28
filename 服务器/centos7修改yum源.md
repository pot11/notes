1. 进入yum源设置文件夹里: 
   1. `/etc/yum.repos.d/`
2. 查看yum源信息：
   1. `yum repolist`
3. 安装base reop源：
   1. `cd /etc/yum.repos.d`
4. 备份旧的配置文件：
   1. `sudo mv CentOS-Base.repo CentOS-Base.repo.bak`
5. 下载载阿里源的文件：
   1. `sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo `
6. 清理缓存:
   1. `yum clean all`
7. 重新生成缓存:  
   1. `yum makecache`
8. 再次查看yum源信息
   1. `yum repolist`
9. 安装
   1. `yum -y update` 