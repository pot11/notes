ajax和json笔记

2024年3月11日

13:47

 

1.  ajax：异步的javascript和xml

2.  作用：通过在后台异步与服务器交换少量数据，在不重写加载整个页面情况下，对网页部分进行更新

3.  ![](014_ajax和json笔记_000.png)

4.  开发步骤：

    1.  创建xmlHttpRequest对象

    2.  像服务器发送请求，并绑定地址和参数open()或send()方法

    3.  设置onreadstatechange事件，用ajax引擎对象绑定监听（监听服务器已将数据相应给ajax引擎）

    4.  获取服务器响应给引擎对象的数据

    5.  例子：

> var xmlhttp = new XMLHttpRequest();
>
> var cname = document.getElementById(\"cname\").value;
>
> xmlhttp.open(\"GET\", \"/day38_ajax/ajaxServlet?cname=\"+cname, true);
>
> xmlhttp.send();
>
>  
>
> Xmlhttprequst.onreadstatchange = function(){
>
>  
>
> If(xmlhttp.status = 200 && xmlhttp.readstat == 4)
>
> }
>
> }
>
>  
>
> 元素。Innerhtml = Xmlhttp.resoponsetxt();
>
>  
>
>  
