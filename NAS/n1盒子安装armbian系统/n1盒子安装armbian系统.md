# n1盒子安装armbian系统

## 安装系统到emmc

```shell
sudo armbian-install
```  

## 更换 Armbian 源

登录 Armbian 系统 → 输入命令：

```shell
armbian-apt
```  

根据你所在的国家或地区选择合适的软件源，可以提高软件的下载速度。更多说明详见 帮助文档

## 安装常用软件  

登录 Armbian 系统 → 输入命令：

```shell
armbian-software
```  

使用 armbian-software -u 命令可以更新本地的软件中心列表。根据用户在 Issue 中的需求反馈，逐步整合常用软件，实现一键安装/更新/卸载等快捷操作。包括 docker 镜像、桌面软件、应用服务 等。详见更多说明。

## 修改 Armbian 配置

登录 Armbian 系统 → 输入命令：  

```shell
armbian-config
```

## 挂载新硬盘

### 步骤 1: 查看系统识别的硬盘

```shell
sudo fdisk -l
或
lsblk
```

### **步骤 2: 使用 `fdisk` 分区**

假设新硬盘是 `/dev/sda`，我们可以用 `fdisk` 工具来创建分区。

1. 进入 `fdisk` 工具：

```shell
   sudo fdisk /dev/sda
```

2. 查看硬盘的当前分区状态：

   输入 `p` 查看当前分区表。

3. 删除分区：按d
4. 创建新分区：

   输入 `n` 创建新分区：

   - 输入分区类型：选择 `p` 代表主分区。
   - 输入分区号（如果是第一个分区，选择 `1`）。
   - 设置起始扇区（可以按 `Enter`，使用默认值）。
   - 设置结束扇区（可以按 `Enter`，选择使用整个硬盘）。

5. 查看分区：

   输入 `p` 确认新分区已经创建。

6. 保存并退出：

   输入 `w` 保存分区并退出 `fdisk`。

### **步骤 3: 格式化新分区**

创建完分区后，需要将新分区格式化为一个文件系统，通常使用 `ext4` 文件系统。

```shell
sudo mkfs.ext4 /dev/sda1
```

> **注意**：`/dev/sda1` 是新分区的设备名称，根据实际情况更换设备名称。

### **步骤 4: 创建挂载点**

挂载分区前，您需要为分区创建一个挂载点，通常是一个空目录。

```shell
sudo mkdir /mnt/disk
```

### **步骤 5: 挂载新分区**

将新创建并格式化的分区挂载到指定的目录（例如 `/mnt/disk`）：

```shell
sudo mount /dev/sda1 /mnt/disk
```

### **步骤 6: 设置开机自动挂载**

为了确保每次系统启动时自动挂载该硬盘，您需要将分区信息添加到 `/etc/fstab` 文件中。

1. 获取新分区的 UUID：

```shell
sudo blkid /dev/sda1
```

   输出类似于：

```shell
/dev/sda1: UUID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" TYPE="ext4"
```

   复制上面输出中的 `UUID` 值。

2. 编辑 `/etc/fstab` 文件：

```shell
   sudo nano /etc/fstab
```

3. 在文件中添加一行，确保新分区能够在每次启动时自动挂载：

```shell
UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  /mnt/disk  ext4  defaults  0  2
```

   将 `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` 替换为实际的 UUID

4. 永久挂载（开机自动挂载） 编辑 /etc/fstab 文件：

```shell
sudo nano /etc/fstab
/dev/sda1 /mnt/mydisk ext4 defaults 0 0
```

5. 保存并退出编辑器（按 `Ctrl + X`，然后按 `Y` 确认保存）。
   
### **步骤 7: 验证挂载**

您可以使用以下命令来验证硬盘是否已经成功挂载：

```shell
df -h
```

这会显示当前挂载的文件系统及其使用情况。

如果您想立即测试是否能正确挂载新硬盘，可以重启系统，确保硬盘按预期挂载：

```shell
sudo reboot
```

然后再次运行 `df -h` 来确认新硬盘是否已挂载。
