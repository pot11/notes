\@requestbody注解

2020年5月5日

9:41

 

> **Json格式数据实现Ajax交互**
>
> json数据是咱们企业级开发数据交互经常使用的一种方式，它比较轻量级，格式比较清晰
>
> 交互：前端和后端的互动

-   前端传递json字符串到后台，后台如何能够自动转换为pojo对象

-   后台return 对象，能否前端直接接收到json格式的字符串

-   \@RequestBody注解，[将JSON 字符串转换为POJO对象]{.mark}

-   作用：用于获取请求体（按照http协议进行一个完整的z封装，往往都是由请求头+请求体等组成）内容，[不适用于Get请求方式，也不适用表单元素]{.mark}

-   [\@requestparameter可以处理表单 或 get请求，key=value形式的数据]{.mark}

-   \@ResponseBody注解

-   作用：该注解用于将Controller的方法返回的对象转换为json字符串返回给客户端

> 注意：
>
> 1\. 引入jquery
>
> 2\. 对静态资源放行(前端控制器配置的是： /   )
>
> \<mvc:resources mapping=\"/js/\*\*\" location=\"/js/\" \>\</mvc:resources\>
>
> ​
>
> \<dependency\>
>
>    \<groupId\>com.fasterxml.jackson.core\</groupId\>
>
>    \<artifactId\>jackson-core\</artifactId\>
>
>    \<version\>2.9.0\</version\>
>
>    \</dependency\>
>
> \<dependency\>
>
>    \<groupId\>com.fasterxml.jackson.core\</groupId\>
>
>    \<artifactId\>jackson-databind\</artifactId\>
>
>    \<version\>2.9.0\</version\>
>
> \</dependency\>
>
> \<dependency\>
>
>    \<groupId\>com.fasterxml.jackson.core\</groupId\>
>
>    \<artifactId\>jackson-annotations\</artifactId\>
>
>    \<version\>2.9.0\</version\>
>
> \</dependency\>
>
> ​
>
> ​
>
> \<%@ page contentType=\"text/html;charset=UTF-8\" language=\"java\" %\>
>
> \<html\>
>
> \<head\>
>
>    \<title\>首页\</title\>
>
>    \<script type=\"text/javascript\" src=\"\${pageContext.request.contextPath}/js/jquery-1.12.4.min.js\"\>\</script\>
>
> \</head\>
>
> \<body\>
>
>    \<input type=\"button\" onclick=\"clickMe()\" value=\"点我\"\>
>
> \</body\>
>
> \<script type=\"text/javascript\"\>
>
>    function clickMe(){
>
>        /\*
>
>         \$.ajax({
>
>             url:\"请求路径\",
>
>             type: \"请求方式\",
>
>             data:\"请求参数\",
>
>             dataType:\"返回值参数类型\",
>
>             contentType:\"application/json;charset=utf-8\",
>
>             success:function(data){
>
>                 //成功的回调函数
>
>             },
>
>             error:function(data){
>
>                 //失败的回调函数
>
>             }
>
>         });
>
>         \*/
>
>        
>
>        /\*\*
>
>         \* 如果页面的参数是json对象， 直接对象接收即可
>
>         \* 如果页面参数是json字符串，\'{\"username\": \"zhangsan\",\"id\":1}\',
>
>         \*     1. 指定参数类型：contentType:\"application/json;charset=utf-8\",
>
>         \*     2. 引入jackson依赖
>
>         \*     3. 处理器参数上，添加注解： \@RequestBody
>
>         \*
>
>         \*/
>
>        \$.ajax({
>
>            url:\"\${pageContext.request.contextPath}/testAjax\",
>
>            type: \"post\",
>
>            data: \'{\"id\":1,\"username\":\"你好\",\"sex\":\"nan\"}\',
>
>            dataType:\"json\",
>
>            contentType:\"application/json;charset=utf-8\",
>
>            success:function(data){
>
>                //成功的回调函数
>
>                console.log(data);
>
>                //成功的回调函数
>
>                for(var i = 0; i \< data.length; i ++){
>
>                    alert(data\[i\].id );
>
>                    alert(data\[i\].username);
>
>                    alert(data\[i\].sex );
>
>               }
>
>           }
>
>       });
>
>   }
>
> \</script\>
>
> \</html\>
>
> ​
>
> package com.itheima.controller;
>
> ​
>
> \@RestController
>
> public class AjaxController {
>
>    /\*\*
>
>     \* \@RestController: 相当于在类上标记了Controller
>
>     \*                 相当于在每一个处理器方法上标记了@ResponseBody
>
>     \*
>
>     \* \@RestController比@Controller 多了 \@ResponseBody
>
>     \*
>
>     \* \@ResponseBody: 作用是可以把返回值以流的形式返回ajax
>
>     \*               可以把对象转换为json串
>
>     \* \@RequestBody: 把请求体（json字符串）转换对象， 需要引入json需要的依赖
>
>     \*/
>
> \@Controller()
>
> public class AjaxController {
>
> ​
>
>    @RequestMapping(\"testAjax\")
>
>    @ResponseBody()
>
>    public List\<User\> testAjax(@RequestBody User user){
>
>        //打印 浏览器发送过来的数据 json\--\> User
>
>        System.out.println(\"user = \" + user);
>
> ​
>
>        //模拟一些数据, 用于给客户端浏览器返回
>
>        User user1 = new User();
>
>        user1.setId(1);
>
>        user1.setUsername(\"王五\");
>
>        user1.setSex(\"nan\");
>
> ​
>
>        User user2 = new User();
>
>        user2.setId(2);
>
>        user2.setUsername(\"赵六\");
>
>        user2.setSex(\"nv\");
>
> ​
>
>        ArrayList\<User\> userList = new ArrayList\<User\>();
>
>        userList.add(user1);
>
>        userList.add(user2);
>
> ​
>
>        return userList;
>
>   }
>
> }
>
> ​
