servlet

2019年9月5日

20:55

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>servlet执行流程：<br />
浏览器相当于一个Socket客户端，Tomcat相当于Socket服务端<br />
1.当用户在浏览器地址栏内输入地址的时候，相当于new Socket(地址，端口号）去连接服务器<br />
2.连上后服务器根据地址找到对应servlet</p>
<p>3.服务器new 出来request，response<br />
4.调用servlet中的service方法，把requset，respone传入</p>
<p>5.在service方法中处理业务，request把请求行、请求头、请求体发送给服务器<br />
服务器再把要响应的html页面让respone带回给浏览器</p>
<p> </p>
<p> </p>
<p>request=输入流</p>
<p>response=输出流</p>
<p><img src="059_servlet_000.png" /></p>
<p> </p></td>
</tr>
</tbody>
</table>

xml配置文件方式:

 

> 1.编写一个servlet
>
> 1.1实现javax.servlet.Servlet接口
>
> 1.2实现接口中的service方法

 

> 2.配置servlet
>
> 2.1注册servlet
>
> 2.2绑定虚拟路径

 

> 注解方式:

 

> 1.编写一个servlet
>
> 1.1实现javax.servlet.Servlet接口
>
> 1.2实现接口中的service方法
>
> 2.配置servlet
>
> 在servlet类上加注解
>
>  
>
> 注解中：@WebServlet(urlPatterns = \"**/**aa\")
>
> 等同与@WebServlet(value = \"**/**aa\")
>
> 而注解中当value属性只有一个值时，可省略不写
>
> 最终写法：@WebServlet( \"/aa\")
>
>  
>
> 注意：

-   **[/]{.mark}不能忘记**

-   一个sevelet只能处理一个事件
