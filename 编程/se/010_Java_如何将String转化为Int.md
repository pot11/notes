 

2021年3月9日

14:49

 

[**Java 如何将String转化为Int**](https://www.cnblogs.com/JonaLin/p/11199745.html)

在 Java 中要将 String 类型转化为 int 类型时,需要使用 Integer 类中的 parseInt() 方法或者 valueOf() 方法进行转换.

 

String str = \"123\";

try {

    int a = Integer.parseInt(str);

} catch (NumberFormatException e) {

    e.printStackTrace();

}

方法二

 

String str = \"123\";

try {

    int b = Integer.valueOf(str).intValue()

} catch (NumberFormatException e) {

    e.printStackTrace();

}

在转换过程中需要注意,因为字符串中可能会出现非数字的情况,所以在转换的时候需要捕捉处理异常

 

来自 \<<https://www.cnblogs.com/JonaLin/p/11199745.html>\>
