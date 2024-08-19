# 在Node.js环境下运行Vue项目

>Vue.js是一个流行的前端框架，它允许我们构建复杂的单页应用程序。而Node.js则是一个强大的JavaScript运行环境，它提供了丰富的库和工具，可以帮助我们更高效地开发和管理Vue项目。下面，我们将详细介绍在Node.js环境下如何运行Vue项目。

## 安装nodejs和npm（Node.js的包管理器）  
下载安装包（选择macOS 安装包 (.pkg)：下载 ```https://nodejs.cn/download```
直接点击下载包一直无脑点下一步安装,查看版本号，检测是否安装成功：node -v npm -v

- 安装cnpm：  

```script
npm install -g cnpm --registry=https://registry.npmmirror.com
```

同样是通过查看版本号查看安装状态：cnpm -v  

## 安装vue-cli 脚手架：
  >Vue CLI是Vue.js的官方命令行工具，它可以帮助我们快速搭建Vue项目。在命令行中输入以下命令安装Vue CLI：

```script
sudo npm install -g @vue/cli
```

这个过程比较慢，一直enter键下一步，直到安装成功，查看版本号 ：vue -version  

## 创建项目  

使用Vue CLI创建一个新的Vue项目。在命令行中进入你想要创建项目的目录，然后输入以下命令：  

```vue create my_test```  

这里的my-project是你的项目名称，你可以根据实际需求修改。执行上述命令后，Vue CLI会提示你选择预设的配置或手动选择特性。这里我们选择默认配置以便快速开始。等待项目创建完成后，进入项目目录：  
```cd my-project```

## 运行vue项目

在项目目录下，使用以下命令安装项目所需的依赖：

```npm install```  
安装完成后，使用以下命令启动开发服务器：  
```npm run serve```  
这将启动一个本地开发服务器，并在浏览器中打开应用程序。默认情况下，应用程序将在http://localhost:8080上运行。你可以在浏览器中查看你的Vue应用程序，并且当你修改源代码时，浏览器会自动刷新以显示更改  

## 构建生产版本

当你的Vue应用程序开发完成后，你需要构建一个生产版本以便部署到服务器上。在项目目录下，使用以下命令构建生产版本

```npm run build```  
这将创建一个dist目录，其中包含用于生产环境的优化过的静态文件。你可以将这些文件部署到任何支持静态文件的服务器上  
