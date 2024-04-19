String

2019年7月21日

14:21

 

-   一切皆对象, \"\"也也是对象(不需要new)

-   字符串是常量，一旦创建，不能更改

-   1.字符串也是对象,且是一个常量,不可改变

-   2.字符串本质, 是一个字符数组.char\[\]

-   3.字符串,String类有很多方法,str.length()

>  
>
>  
>
>  
>
>  
>
> String s=\"hello\";
>
> 为什么sout可以直接打印s ? s不是hello 的地址吗？
>
>  
>
> 答：String类重写过object类中的tostring（）方法
