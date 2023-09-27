centos7防火墙相关命令：
- 查看防火墙状态:  
  - `systemctl status firewalld.service`  
  执行后可以看到绿色字样标注的“active（running）”，说明防火墙是开启状态
使用命令：
- 关闭运行的防火墙：  
  - `systemctl stop firewalld.service`  
- 查看防火墙是否关闭：  
  - `systemctl status firewalld.service `  
可以看到，disavtive（dead）的字样，说明防火墙已经关闭
如果觉得 每次开机都要关闭防火墙 麻烦那就把防火墙禁用
systemctl disable firewalld.service