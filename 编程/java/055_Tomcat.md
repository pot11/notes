Tomcat

2019年9月4日

16:08

 

Tomcat用java写的，跨平台

startup.bat windows中

startup.sh mac linux中

 

在浏览器中输入地址后，点击enter一瞬间，浏览器自动帮我们创建了socket。

并且提交了请求行、请求头、请求体的内容（原本需要用os.write(\"内容\")）

 

Tomcat作用：在服务端把serversocket的创建，以及逻辑输入输出操作封装起来，自动完成

> 各种操作，方便程序员

 

注意事项：

-   如果tomcat部署（deployement)的时候，application context写的是什么，

> 地址栏8080后面就要跟上什么，再加上html文件名；

-   若只填**/**(根目录)，地址栏可不写项目名，直接写html文件名

![](055_Tomcat_000.png)

 

![](055_Tomcat_001.png)

-   Tomcat默认访问index.html，地址栏可省略不写

-   idea发布web工程时候，并不是复制项目到webapps下，而是复制一份tomcat的配置信息（conf),修改了配置文件，把默认发布的工程从webapps改到idea 的out下，告诉tomcat来找我，如下图:

>  
>
> ![](055_Tomcat_002.png)

 

> ![](055_Tomcat_003.png)

 

> ![](055_Tomcat_004.png)
>
>  
>
>  
>
>  
>
>  

-   Tomcat自带的conf文件夹下server.xml的配置信息如下：

>  
>
> ![](055_Tomcat_005.png)
>
>  
>
>  
>
> web项目删除war包和war.expload包后，重新生成war包
>
> ![](055_Tomcat_006.png)
>
>  
>
> ![](055_Tomcat_007.png)
>
>  
>
> ![](055_Tomcat_008.png)
>
>  
>
> 点ok就好了
>
> ![](055_Tomcat_009.png)
>
>  
>
>  
>
>  
>
> 手动往Tomcat的webapps下发布项目时候，一般要要有项目名，如helloweb ，
>
> helloweb 文件夹下又web-inf jsp html等，访问时候要带上项目名helloweb
>
> 若不想带上项目名，要放在ROOT下
