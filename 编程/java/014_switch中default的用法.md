**switch中default的用法**

2019年7月16日

15:00

default什么时候会执行？default的位置对执行结果有影响吗？

 

default只有在case匹配失败的时候才会执行

 

        int a=4;

switch (a){

case 1:

System.out.println(\"1\");

break;

case 2:

System.out.println(\"2\");

break;

|         |     |
|---------|-----|
| case 3: |     |

System.out.println(\"3\");

break;

default:

System.out.println(\"default\");

break;

}

打印结果：default

 

当然也有特殊情况，就是case匹配成功了，但缺少了break语句

 

int a=3;

switch (a){

case 1:

System.out.println(\"1\");

break;

case 2:

System.out.println(\"2\");

break;

case 3:

System.out.println(\"3\");

default:

System.out.println(\"default\");

break;

}

打印结果：

 

3

 

default

 

default的位置对执行结果有没有影响，关键看default有没有使用break，先看有break的情况下是什么结果

 

int a=4;

switch (a){

default:

System.out.println(\"default\");

break;

case 1:

System.out.println(\"1\");

break;

case 2:

System.out.println(\"2\");

break;

case 3:

System.out.println(\"3\");

break;

}

打印结果：default

 

接下来看看不加break是什么结果

 

int a=4;

switch (a){

default:

System.out.println(\"default\");

case 1:

System.out.println(\"1\");

case 2:

System.out.println(\"2\");

break;

case 3:

System.out.println(\"3\");

break;

}

打印结果：

 

default

1

 

2

 

可以看到不加break的话会继续向下执行，直到遇到break或return或switch结束为止
