 

2020年5月10日

8:54

 

[**线程让步yield**](https://www.cnblogs.com/myitnews/p/11422598.html)

**一、yield()的作用**

yield()的作用是让步。它能让当前线程由"运行状态"进入到"就绪状态"，从而让其它具有相同优先级的等待线程获取执行权；但是，并不能保证在当前线程调用yield()之后，其它具有相同优先级的线程就一定能获得执行权；也有可能是当前线程又进入到"运行状态"继续运行！

yield()是Thread的静态方法。

**二、yield() 与 wait()的比较**

wait()的作用是让当前线程由"运行状态"进入"等待(阻塞)状态"的同时，也会释放同步锁。而yield()的作用是让步，它也会让当前线程离开"运行状态"。它们的区别是：

\(1\) wait()是让线程由"运行状态"进入到"等待(阻塞)状态"，而yield()是让线程由"运行状态"进入到"就绪状态"。

\(2\) wait()是会线程释放它所持有对象的同步锁，而yield()方法不会释放锁。

// YieldLockTest.java 的源码\
public class YieldLockTest{

private static Object obj = new Object();

public static void main(String\[\] args){\
ThreadA t1 = new ThreadA(\"t1\");\
ThreadA t2 = new ThreadA(\"t2\");\
t1.start();\
t2.start();\
}

static class ThreadA extends Thread{\
public ThreadA(String name){\
super(name);\
}\
public void run(){\
// 获取obj对象的同步锁\
synchronized (obj) {\
for(int i=0; i \<10; i++){\
System.out.printf(\"%s \[%d\]:%d\\n\", this.getName(), this.getPriority(), i);\
// i整除4时，调用yield\
if (i%4 == 0)\
Thread.yield();\
}\
}\
}\
}\
}

 

来自 \<<https://www.cnblogs.com/myitnews/p/11422598.html>\>

 

 

来自 \<<https://www.cnblogs.com/myitnews/p/11422598.html>\>
