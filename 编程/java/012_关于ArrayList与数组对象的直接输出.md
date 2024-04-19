 

2018年9月27日

9:50

 

**关于ArrayList与数组对象的直接输出**

2014年10月09日 20:43:29 [zchub](https://me.csdn.net/qq_17786039) 阅读数：2272 标签： [arraylist](http://so.csdn.net/so/search/s.do?q=arraylist&t=blog)[array](http://so.csdn.net/so/search/s.do?q=array&t=blog) 更多

个人分类： [java](https://blog.csdn.net/qq_17786039/article/category/2622195)

     今个没得事，试了哈arraylist与数组对象的直接输入。但是数组的输出确实这样的形式"\[Ljava.lang.String;@1db9742"，而arraylist则是直接输出每个内容。

    import java.util.ArrayList;

   import java.util.List;

 

public class Test {

    public static void main(String\[\] args) {

        List\<String\> list = new ArrayList\<String\>();

        list.add(\"a\");

        list.add(\"b\");

        String \[\] a = new String\[2\];

        a\[0\]=\"hh\";

        a\[1\]=\"bb\";

        String\[\] b = new String\[\]{\"a\",\"b\"};

        System.out.println(a);

        System.out.println(list);

    }

}

  原来是数组没有重写object的toString()方法，而arraylist虽然表面上没有重写Object的toString()方法，但是别忘了ArrayList继承了 AbstractList ；AbstractList 继承 AbstractCollection； AbstractCollection中重写了toString()方法，所以可以直接打印咯。

 

来自 \<<https://blog.csdn.net/qq_17786039/article/details/39938155>\>
