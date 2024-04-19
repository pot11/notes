 

2020年2月20日

9:40

 

单链集合 collection 顶层接口 子接口 list set 方法： add

双链集合 map 方法：put(key,values)

 

 

泛型只能存储引用数据类型

基本数据类型

引用数据类型 类 接口 数组

list集合用的泛型必须用基本数据类型的包装类

 

 

遍历方法:

Collection

List 有索引 普通for 增强for 迭代器

Set 无索引 增强for 迭代器

 

Map

键找值 get(key)

根据entryset对象，取键，值 entryset \--\>getkey() getvalue

 

 

 

HashCode 和equals 重写 保证元素唯一性

 

hashset集合中 为了保证元素唯一性

add底层调用hashmap中put方法

put方法用用hashcode和equals判断新增元素是否与原有元素相等

 

哈希表：

Jdk1.8前 数组+链表

Jdk1.8以后 数组+ 链表/红黑树

 

数组是把hash值相同的分组 链表是把哈希值相同的元素挂在下面

挂的超过8个时 会用红黑树 提高效率

 

 

 

 
