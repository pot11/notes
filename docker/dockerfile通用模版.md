# dockerfile模版

```shell
# 定义构建参数，并设置默认值（你的阿里云仓库地址）
ARG REGISTRY_ADDR=crpi-v1n4esosl3b1xvpt.cn-hangzhou.personal.cr.aliyuncs.com
ARG NAMESPACE=aliyun_image_20251211
# ARG REPO_NAME=your-repo

# 创建极小的运行时镜像（使用Alpine Linux的JRE）
FROM crpi-v1n4esosl3b1xvpt.cn-hangzhou.personal.cr.aliyuncs.com/aliyun_image_20251211/linux_arm64_openjdk:17.0.1-jdk-slim
# FROM ${REGISTRY_ADDR}/${NAMESPACE}/linux_arm64_openjdk:17.0.1-jdk-slim

# 设置工作目录
WORKDIR /app

# 关键步骤：将本地IDEA打好的JAR包复制到镜像中
# 注意：<你的JAR包名称> 要替换成真实的文件名，例如 ybb-message-biz-6.0.2.jar
COPY target/ybb-message-biz.jar app.jar

# 暴露Spring Boot应用默认端口
EXPOSE 9114

# 设置容器启动命令
ENTRYPOINT ["java", "-jar", "app.jar"]

# 构建镜像
# docker build -t my-springboot-app .
# 运行容器
# docker run -d -p 8080:8080 --name myapp my-springboot-app
```