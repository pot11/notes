 

2019年10月19日

12:16

 

Unmapped Spring configuration files found.

![](079_Unmapped_Spring_configuration_files_found._000.png)

 

项目中有xml文件，但没有被用IntelliJ 导入现有工程时，如果原来的工程中有spring，每次打开工程就会提示：Spring Configuration Check

开始不知道怎么回事，但工程不影响。

工程结构（Project Structure）有一个 Facets 选项，可以设置各种框架。

Facets中则可以设置当前项目所用的框架，如Hibernate和Spring，如果是Web项目，也需要添加Web的Facets，这个界面中的显示和Modules中的很类似。如果想要通过idea做Hibernate的映射文件（.hbm）生成或jpa注解配置代码生成，则需要添加Hibernate配置，如果添加了Spring，则在Spring的xml中properties文件的占位符可以被自动替换为properties中已配置的值。

偶然发现这个提示是把spring的配置文件由IntelliJ来管理，打Project

Structure－\>Facets 配置。添加spring配置文件的模块。

 

**Facets和Artifacts的区别：**

Facets 表示这个module有什么特征，比如 Web，Spring和Hibernate等；

Artifact 是maven中的一个概念，表示某个module要如何打包，例如war exploded、war、jar、ear等等这种打包形式；

一个module有了 Artifacts 就可以部署到应用服务器中了！

在给项目配置Artifacts的时候有好多个type的选项，exploed是什么意思：

explode 在这里你可以理解为展开，不压缩的意思。也就是war、jar等产出物没压缩前的目录结构。建议在开发的时候使用这种模式，便于修改了文件的效果立刻显现出来。

默认情况下，IDEA的 Modules 和 Artifacts 的 output目录 已经设置好了，不需要更改，打成 war包 的时候会自动在 WEB-INF目录 下生产 classes目录，然后把编译后的文件放进去。

Java artifact是什么意思，maven一直用，但是不明白中文意思？

 

Now you'll want to install the artifact you've generated (the JAR file) in your local repository (\~/.m2/repository is the default location). For more information on repositories you can refer to our Introduction to Repositories but let's move on to installing our artifact! To do so execute the following command:

 

artifact你把它理解成"生成的东西"就差不多了。这个词强调的是这是你软件生产过程中某一步的产生物，不像程序本身，或者是配置文件这些，是你手写出来的。

 

 

maven的主要概念

Goal: 类似于ant中的target，指完成一定功能的一个任务

Artifact：项目产生物，主要有jar, war, maven插件

Plug-in：插件，可复用的功能模块比如，middlegen，statcvs

POM：项目对象模型(Project Object Model)，是项目的一些关键元信息的集合。主要包含项目管理信息、具体的项目描述、开发小组的构 成、源代码库(如CVS)和邮件列表、项目依赖的库文件(开发时刻依赖和运行时刻依赖)、源代码、单元测试代码和资源文件的位置、项目报告
