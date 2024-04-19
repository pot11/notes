 

2022年7月28日

13:28

 

> for循环内list添加对象 如何节省内存
>
>  
>
>  
>
>  
>
>  
>
> 关于 List 在for 循环中 添加对象的问题
>
> [天珩](https://blog.csdn.net/weixin_41705396)
>
> 于 2019-11-23 10:03:58 发布
>
> 2651
>
>  收藏 5
>
> 分类专栏： [java基础知识](https://blog.csdn.net/weixin_41705396/category_9523678.html)
>
> 版权
>
> [java基础知识专栏收录该内容](https://blog.csdn.net/weixin_41705396/category_9523678.html)
>
> 12 篇文章0 订阅
>
> 订阅专栏
>
> 一、问题引出
>
> publicstaticvoidmain(String\[\]args){List\<User\>list=newArrayList\<User\>();*/\*\
> 创建对象在 循环之外，只有一个对象\
> \*/*User user=newUser();for(inti=0;i\<10;i++){user.setName(\"第\"+i+\"个User\");user.setId(i);list.add(user);}Iterator\<User\>iterator=list.iterator();while(iterator.hasNext()){System.out.println(iterator.next().myToString());}}

-   1

-   2

-   3

-   4

-   5

-   6

-   7

-   8

-   9

-   10

-   11

-   12

-   13

-   14

-   15

-   16

-   17

> 二、输出结果
>
>  
>
> 从结果可以看出，输出的User对象中的值 是最后一次改变的值
>
> 三、原因
>
> 因为 创建 User对象的语句在 for循环之外，所以，只创建了一个User对象，只开辟了一个User 的内存空间， list 的 add（）方法，增加的 是 对象的引用，而每次循环只是简单 的set 对象的属性，set新的属性值，而add进list中的对象还是同一个对象id，也就是同一个对象；
>
> 四、图解
>
> ![](008_for循环内list添加对象_如何节省内存_000.png)
>
> 上图可以看出，以上的代码，只创建了一个 User对象，List中存放的是对 user对象的引用，引用的始终是同一个，所以三个 user指向的是同一个内存地址，所以，当内存上面的内容最后一次变化的时候，所有的List中的User指向的User也变化成了最后一次的内容
>
> 五、结论：
>
> 向list中增加 对象时候，需要将 创建对象的过程放在 循环里面，每一个都开辟一块内存，保存独立的值
>
> 六、注意：
>
> 这种情形容易出现在从数据库中 拿出数据或者存储数据的时候，注意创建对象的位置。
>
>  
>
> 来自 \<<https://blog.csdn.net/weixin_41705396/article/details/103210723?ydreferer=aHR0cHM6Ly93d3cuYmluZy5jb20v>\>
