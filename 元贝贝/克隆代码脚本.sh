# 创建一个临时脚本并直接运行
cat > /tmp/clone_repos.sh << 'EOF'
#!/bin/bash
repos=(
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-message.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-user.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-gateway.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-common.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-specpkg.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-inquiry.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-platform.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-physician.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/yl-common.git"
    "https://codeup.aliyun.com/67e242bc8571f8159f9a9d0e/ybb-backend/ybb-uc.git"
)
for repo in "${repos[@]}"; do
    echo "克隆: $(basename $repo .git)"
    git clone $repo || echo "克隆失败: $repo"
done
echo "完成!"
EOF

chmod +x /tmp/clone_repos.sh
cd /Users/zen/develop/IdeaProjects/ybb/yl-backend  # 切换到桌面或其他你想要的目录
/tmp/clone_repos.sh