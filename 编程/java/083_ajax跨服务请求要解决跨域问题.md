 

2019年11月1日

9:45

 

ajax跨服务请求要解决跨域问题

例子：前端页面在一个单独的tomcat内，页面发送ajax，请求路径为后端controller，

> 后端放在另一个tomcat内。
>
> 请求路径url，就要写上后端全路径名；不写全，则访问本服务内。
>
>  
>
> 跨域要在后端spring-mvc.xml中配置
>
> \<!\--支持跨域\--\>
>
> \<mvc:cors\>
>
> \<mvc:mapping path=\"/\*\*\"/\>
>
> \</mvc:cors\>
>
>  
