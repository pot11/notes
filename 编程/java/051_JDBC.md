JDBC

2019年8月21日

11:25

 

1.  resultset为一个接口，ResultSet rs = stmt.executeQuery(\"select \* from category\");获取接口实现类对象

 

-   JDBCUtils工具类，只是一个类，里面封装了用于获取注册驱动的静态代码快；获取连接，关闭资源 的方法。没有主方法

 

-   static静态代码块也可以"看做"方法，里面声明的变量为局部变量

-   设置全局静态变量url、username、password后。静态代码块从配置文件中读取的url username password尽量不要用代码补全，因为它会重新定义一边，把全局变量覆盖了

 

 

-   注解类引用静态类中方法

-   C3p0中的combodatasoure怎么实现datasource的?

|                                                                                                                                                                                                           |
|------------------------------------------------------------------------|
| 原因：Combodatasoure extend AbstractComboPooledDataSource，而AbstractComboPooledDataSource实现了PooledDataSource接口，PooledDataSource接口继承datasource接口，所以Combodatasoure implement datasource接口 |

>  

-   idea中sql语句可以小写

>  

|                                                                                                             |
|------------------------------------------------------------------------|
| [JDBCutil或c3p0util工具类，jdbc涉及读取src下properties文件的，统统用下：]{.mark}                            |
| [InputStream fis = JDBCUtils02.class.getClassLoader().getResourceAsStream(\"./jdbc01.properties\");]{.mark} |

 

 

 

静态代码块中只能运行一次，所以可以把连接池对象放进去，不能把connection放进去，

因为要创建多个连接

 

一个类调用另一个类的静态方法，为什么要写在方法中，写在成员变量位置为啥不行？

![](051_JDBC_000.png)

 

 

 

 

 

ThreadLocal中关于变量作用域和集合创建 多次调用getconnetion是否创建多个对象，是否是同一对象

 

![](051_JDBC_001.png)
