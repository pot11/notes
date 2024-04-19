Runtime类

2019年10月18日

11:58

 

作用：运行程序的

类中方法：exec（String）可以执行程序，如main方法

junit运行的时候底层使用了Runner对象，有一个默认使用的Runner对象，所以可以独立与main方法运行。

Spring对junit的支持，其实是自己实现了一个Runner对象（按照junit runner的要求实现）
