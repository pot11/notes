# mysql7.35安装

在 Windows 系统上安装 MySQL 5.7，可以通过以下步骤进行：

1. **下载 MySQL 5.7 安装包**：

   - 访问 MySQL 官方下载页面：
   - 选择适合 Windows 的 MySQL 5.7 版本进行下载。

2. **解压安装包**：

   - 将下载的压缩包解压到指定目录，例如 `D:\MySQL\mysql-5.7.35-winx64`。

3. **创建配置文件和数据目录**：

   - 在解压目录下创建 `my.ini` 配置文件，内容如下：

     ```ini
     [mysqld]
     port=3306
     character_set_server=utf8
     basedir=D:\MySQL\mysql-5.7.35-winx64
     datadir=D:\MySQL\mysql-5.7.35-winx64\data
     server-id=1
     sql_mode=NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
     lower_case_table_names=1
     innodb_file_per_table=1
     log_timestamps=SYSTEM
     log-error=error.log
     slow_query_log=1
     slow_query_log_file=slow.log
     long_query_time=5
     log-bin=binlog
     binlog_format=row
     expire_logs_days=15
     log_bin_trust_function_creators=1
     
     [client]
     default-character-set=utf8
     ```

   - 在解压目录下创建 `data` 子目录，用于存放数据库数据文件。

4. **配置环境变量**：

   - 右键点击“此电脑”或“我的电脑”，选择“属性” > “高级系统设置” > “环境变量”。
   - 在“系统变量”中，点击“新建”，变量名填写 `MYSQL_HOME`，变量值填写 MySQL 安装目录路径，例如 `D:\MySQL\mysql-5.7.35-winx64`。
   - 在“系统变量”中，找到 `Path` 变量，点击“编辑”，在末尾添加 `;%MYSQL_HOME%\bin`。

5. **初始化数据库**：

   - 以管理员身份打开命令提示符（CMD）。

   - 切换到 MySQL 的 `bin` 目录，例如：

     ```shell

     cd D:\MySQL\mysql-5.7.35-winx64\bin
     ```

   - 执行以下命令初始化数据库：

     ```shell
     
     mysqld --initialize-insecure
     ```

     该命令会在 `data` 目录下生成数据库文件。

6. **安装并启动 MySQL 服务**：

   - 在 `bin` 目录下，执行以下命令安装 MySQL 服务：

     ```shell
     
     mysqld --install
     ```

   - 启动 MySQL 服务：

     ```shell
     
     net start mysql
     ```

7. **设置 root 用户密码**：

   - 在命令提示符中，登录 MySQL：

     ```shell
     
     mysql -u root
     ```

   - 设置 root 用户密码，例如设置为 `123456`：

     ```sql
     
     ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
     ```

   - 刷新权限：

     ```shell
     
     FLUSH PRIVILEGES;
     ```

8. **验证安装**：

   - 在命令提示符中，使用新设置的密码登录 MySQL：

     ```shell
     
     mysql -u root -p
     ```

     输入密码后，成功登录即表示安装成功  