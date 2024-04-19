string和stringBuffer、stringBuilder

2020年2月29日

14:39

1.  区别

    1.  可变性

        -   string类使用final关键字字符数组保存字符串，所以string对象不可变

        -   stringBuffer、stringBuilder继承abstract stringBuilder，此类未用final修饰，对象可变

>  

1.  可变性

    1.  string类使用final关键字字符数组保存字符串，所以string对象不可变

>  

1.  线程安全性

    1.  string中对象不可变，可视为常量，线程安全。

    2.  abstractstringBuilder类中定义了对字符串的基本操作，即一些公有方法

        -   stringBuilder未对方法加同步锁,线程不安全,效率快

        -   stringBuffer加了同步锁，线程安全，效率慢

```{=html}
<!-- -->
```
1.  性能

    1.  string类型改变时候，都会产生新的string对像，然后指针指向新的对象

    2.  stringBuffer、stringBuilder直接在原有对像本身进行操作，

```{=html}
<!-- -->
```
1.  总结

    1.  操作少量数据，string

    2.  单线程操作字符串缓冲区下操作大量数据，stringBuilder

    3.  多线程操作字符串缓冲区下操作大量数据，stringBuffer

>  

1.  原理：

> 查阅java.lang.StringBuilder的API，StringBuilder又称为可变字符序列，它是一个类似于 String 的字符串缓冲区，通过某些方法调用可以改变该序列的长度和内容。
>
> 原来StringBuilder是个字符串的缓冲区，即它是一个容器，容器中可以装很多字符串。并且能够对其中的字符串进行各种操作。
>
> 它的内部拥有一个数组用来存放字符串内容，进行字符串拼接时，直接在数组中加入新内容。StringBuilder会自动维护数组的扩容。
>
>  
>
> ![](004_string和stringBuffer、stringBuilder_000.png)
>
>  
>
>  
>
>  
