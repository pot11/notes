 

2020年4月20日

8:53

 

（2）美团试题：ArrayList和linkedlist有什么区别，如何遍历，使用for循环遍历linkedlist为什么效率低，linkedlist能使用索引访问么，使用迭代器呢

原创依本多情 最后发布于2018-09-09 00:57:43 阅读数 3618 收藏

展开

（一）ArrayList和linkedlist有什么区别？

简单的区别：

1.ArrayList是实现了基于动态数组的数据结构，LinkedList基于链表的数据结构。 （LinkedList是双向链表，有next也有previous）

2.对于随机访问get和set，ArrayList觉得优于LinkedList，因为LinkedList要移动指针。

3.对于新增和删除操作add和remove，LinedList比较占优势，因为ArrayList要移动数据。

 

深度的区别：

1．对ArrayList和LinkedList而言，在列表末尾增加一个元素所花的开销都是固定的。对ArrayList而言，主要是在内部数组中增加一项，指向所添加的元素，偶尔可能会导致对数组重新进行分配；而对LinkedList而言，这个开销是统一的，分配一个内部Entry对象。

 

2．在ArrayList的中间插入或删除一个元素意味着这个列表中剩余的元素都会被移动；而在LinkedList的中间插入或删除一个元素的开销是固定的。

 

3．LinkedList不支持高效的随机元素访问。

 

4．ArrayList的空间浪费主要体现在在list列表的结尾预留一定的容量空间，而LinkedList的空间花费则体现在它的每一个元素都需要消耗相当的空间

 

（二）为什么ArrayList基本都用for循环，不用Iterator迭代器遍历（其实也可以使用Iterator，但是效率相对来说没有for循环效率高），而LinkedList都用Iterator遍历，极少用for循环去遍历？

首先看一下ArrayList的继承和实现类的图

 

 

2.下面这个是LinkedList的继承和实现类的图

 

 

分析原因：

 

其实原因就在于两者的不同就在于这个RandomAccess（意思为随机访问）这个接口是不是存在的原因，虽然说这个RandomAccess是个空的接口，但是他的存在却又很大的意义，因为他是一个标志接口（Marker）【你可以理解为是用for循环效率高还是用Iterator遍历效率高就取决于ArrayList、LinkedList是不是实现了RandomAccess这个接口来进行选择合适的遍历方式】

通过查看Collections类中的binarySearch（）方法，源码如下

 

上图标注的时候，做了一个判断，instanceof其作用是用来判断某对象是否为某个类或接口类型，如果是实现了RandomAccess的接口的话，就用for循环比较好

 

否则的话就调用Collections的IteratorBinarySearch（）方法，也就是使用迭代器Iterator的遍历方式

 

##总结： 至于linkedList能不能使用索引访问，答案是不能的，因为ArrayList集合中的索引是标示出来的，而LinkedList集合中的索引是隐式的 \##
