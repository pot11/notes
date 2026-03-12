# windows上初始化

```shell
git config --global user.name "zhengqiang"
git config --global user.email "prettycoder@163.com"
git config --global http.proxy http://127.0.0.1:7890 
git config --global https.proxy http://127.0.0.1:7890
```




提交历史中的“署名”
每次你用 git commit 创建一次提交，Git 都会把当前配置的 user.name 和 user.email 写入这个提交的元数据中。在查看日志（git log）或浏览 GitHub 上的提交记录时，这些信息会显示出来，让别人知道是谁做了这次修改。

这个信息可以随便填，比如 name="test"、email="fake@example.com"，Git 本身不会验证真假。

但在协作中，正确的身份有助于团队沟通，也能让 GitHub 等平台把你的提交关联到你的账号（如果邮箱与 GitHub 账号已验证的邮箱匹配，提交就会显示你的头像和用户名）。

2. 它们与远程仓库认证无关
当你执行 git push 向 GitHub 推送代码时，Git 会要求你提供访问权限的凭证：

如果用 HTTPS 协议：需要输入 GitHub 用户名和个人访问令牌（Personal Access Token）（现在 GitHub 已禁止直接用密码）。

如果用 SSH 协议：需要配置 SSH 密钥，Git 会用密钥进行身份验证。