Static

2019年8月4日

21:39

 

> 1.类进入到方法区，要先把自己的静态属性或静态方法放进静态区 以作为共享数据
>
> 2.静态的内存生命周期早于非静态的在
>
>  

-   **被static修饰的成员变量属于类，不属于这个类的某个对象。属于对象的共享数据**（也就是说，多个对象在访问或修改static修饰的成员变量时，其中一个对象将static成员变量值进行了修改，其他对象中的static成员变量值跟着改变，即多个对象共享同一个static成员变量BDX）

-   作用：对象共享数据

>  
>
> 缺点：生命周期长，浪费资源，随类消失消失
>
>  
>
>  
>
> 多态调用中,编译看谁,运行看谁
>
> \* 编译都看 = 左边的父类, 父类有编译成功,父类没有编译失败
>
> \* 运行,静态方法, 运行父类中的静态方法
>
> \* 运行,非静态方法,运行子类的重写方法
>
> \* 成员变量,编译运行全是父类
>
> 原因: 静态属于类,不属于对象
>
> 对象的多态性,静态和对象无关,父类的引用.静态方法
>
>  
>
>  
>
>  
>
>  

 

![](039_Static_000.png)
