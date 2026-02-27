# docker相关

Docker 镜像的名称由 仓库地址 + 命名空间 + 镜像名:标签 组成。如果不写仓库地址，Docker 会默认从官方 Docker Hub 拉取。

你的镜像存放在阿里云的个人私有仓库中，所以必须指定完整的仓库域名 crpi-v1n4esosl3b1xvpt.cn-hangzhou.personal.cr.aliyuncs.com，这样才能找到正确的服务器。

aliyun_image_20251211/linux_arm64_jellyfin 是在这个仓库下的命名空间和镜像名，latest-rockchip 是标签。

“公网地址”必须全部写上。如果只写后半部分，Docker 会去 Docker Hub 搜索 aliyun_image_20251211/linux_arm64_jellyfin，而这个镜像在 Docker Hub 上并不存在，自然就会拉取失败。