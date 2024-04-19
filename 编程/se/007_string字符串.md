string字符串

2020年2月29日

15:17

 

1.  一切皆对象, \"\"也也是对象(不需要new)

2.  字符串是常量，一旦创建，不能更改

3.  1.字符串也是对象,且是一个常量,不可改变

4.  2.字符串本质, 是一个字符数组.char\[\] 且用final修饰不可变

5.  3.字符串,String类有很多方法,str.length()

>  
>
> String s=\"hello\";
>
> 为什么sout可以直接打印s ? s不是hello 的地址吗？
>
>  
>
> 答：String类重写过object类中的tostring（）方法
>
>  
>
> **虚拟机先从常量池中查找有没有已经存在的值和创建的值相同的对象，如果有就把它赋给当前引用。如果没有就在常量池中重新创建一个string对象**
>
>  

1.  string字符串创建方式

    1.  直接赋值

> string a=\"hello\" string b=\"hello\" 则a 和 b的地址值相同

1.  new对象

>  
>
>  
>
> public class test1 {
>
>    public static void main(String\[\] args) {
>
>        String a = new String(\"ab\"); // a 为一个引用
>
>        String b = new String(\"ab\"); // b为另一个引用,对象的内容一样
>
>        String aa = \"ab\"; // 放在常量池中
>
>        String bb = \"ab\"; // 从常量池中查找
>
>        if (aa == bb) // true
>
>            System.out.println(\"aa==bb\");
>
>        if (a == b) // false，非同一对象
>
>            System.out.println(\"a==b\");
>
>        if (a.equals(b)) // true
>
>            System.out.println(\"aEQb\");
>
>        if (42 == 42.0) { // true
>
>            System.out.println(\"true\");
>
>       }
>
>   }
>
> }
>
>  
>
>  
>
> List 接口的大小可变数组的实现，Arraylist和数组类似，但是只能存储引用数据类型，且是可变数组，可创建对象，调用方法
>
>  
>
>  
