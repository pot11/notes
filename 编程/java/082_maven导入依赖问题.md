maven导入依赖问题

2019年10月30日

11:56

 

-   ![](082_maven导入依赖问题_000.png)

>  

-   若一次性复制pox文件中的依赖，导入太多而报红？

> 1.全部注释掉，然后一个个放开，一个个导入
>
> 2.遇到红的，到本地仓库删除，让maven重新从网上下载即可
>
> 使用cmd，到项目根目录下，运行命令：
>
> mvn clean install -Dmaven.test.skip=true
>
> 使用cmd，到项目根目录下，运行命令：
>
> mvn -U idea:idea
>
>  

 

>  
