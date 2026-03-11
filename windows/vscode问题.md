# vscode问题

- 问题  
VS Code 的终端中使用 PowerShell 运行 npm run dev 时遇到了执行策略错误，但在系统自带的 CMD（命令提示符）中可以正常运行。这是因为 PowerShell 默认禁止执行脚本文件（如 npm.ps1），而 npm 在 PowerShell 中可能会尝试调用这个脚本，从而触发安全策略限制。

- 解决：  
修改 PowerShell 执行策略（一劳永逸，允许运行本地脚本）
以管理员身份打开 PowerShell（右键点击开始菜单，选择“Windows PowerShell (管理员)”或“终端(管理员)”）。
执行以下命令，将执行策略改为 RemoteSigned（允许运行本地脚本，远程脚本需签名）：

```Set-ExecutionPolicy RemoteSigned ```
