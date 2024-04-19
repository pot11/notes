This super

2019年7月28日

19:30

 

this表示本类的对象空间的引用

super应用在子父类中

子类中的构造方法为什么会有一句隐式的super()呢？

原因：子类会继承父类中的内容，所以子类在初始化时，必须先到父类中去执行父类的初始化动作。这样，才可以使用父类中的内容。

当父类中没有空参数构造方法时，子类的构造方法必须有显示的super语句，指定要访问的父类有参数构造方法。

代码：

public class Test {

> public static void main(String\[\] args) {
>
> new Zi();
>
> }
>
>  

}

class Fu{

> int num ;
>
> Fu(){
>
> System.out.println(\"Fu构造方法\"+num);
>
> num = 4;
>
> }

}

class Zi extends Fu{

> Zi(){

//super(); 调用父类空参数构造方法

> System.out.println(\"Zi构造方法\"+num);
>
> }

}

 
