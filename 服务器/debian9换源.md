# debian9换源

从2023年4月23日起，debian9 停止维护，源包地址更换至新地址目前可用的软件源如下:

- 官方源
  
```script
deb http://archive.debian.org/debian/ stretch main contrib non-free
deb-src http://archive.debian.org/debian/ stretch main contrib non-free
deb http://archive.debian.org/debian-security/ stretch/updates main contrib non-free
deb-src http://archive.debian.org/debian-security/ stretch/updates main contrib non-free
deb http://archive.debian.org/debian/ stretch-backports main contrib non-free
```

- 国内源
  
```script
deb https://mirror.nju.edu.cn/debian-archive/debian/ stretch main contrib non-free
deb-src https://mirror.nju.edu.cn/debian-archive/debian/ stretch main contrib non-free
```

1. 设置软件源： ```cat >/etc/apt/sources.list<```
2. 更新软件源： ```apt update -y```
3. 提示gpg证书错误处理  
   报错信息：

    ```script
    W: GPG error: http://archive.debian.org/debian stretch-backports InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY 0E98404D386FA1D9
    ```

    安装需要的依赖和软件：

    ```script
    apt-get install software-properties-common dirmngr -y
    添加gpg证书验证：

    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys  

    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 0E98404D386FA1D9  
    ```  
