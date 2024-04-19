WebSecutityconfig

2019年12月18日

21:07

![](101_WebSecutityconfig_000.png)

"？？？？？？？？？？？？？"

 

 

1.前端表单页面传参数时候，后端controller接受的参数名一定要一致，

不然一定接受不到，显示未401鉴权。

然后，你眼瞎，看不见useraname写错了，还sb的一样还以为后端没有放行，

结果检查了N遍，发现都放行了，tm的居然是controller接受参数名不对

 

2.controller中login方法接受参数username、password，postman测试时候一定不能省略参数，只写方法名，不传参也会报错401未鉴权

 

 

这二者错误，都可以在console控制台中显示，虽然不是以很多异常打印出来，只有短短的一行，但是也可以反应错误原因，要记得看

![](101_WebSecutityconfig_001.png)

 
