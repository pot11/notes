MySQL死锁的本质是两个或多个事务在同一资源上相互占用并请求对方锁定的资源，从而导致无限等待的阻塞状态。死锁通常发生在 **InnoDB 引擎**的行级锁中，以下是最常见的几种触发原因： [[1](https://developer.huawei.com/consumer/cn/forum/topic/0201391735341150097), [2](https://zhuanlan.zhihu.com/p/1923372599213290775), [3](https://qianfan.cloud.baidu.com/qianfandev/topic/685315), [4](https://www.cnblogs.com/yizhiamumu/p/16794900.html), [5](https://www.fangzhipeng.com/interview/mysql/2024-04-01-mysql-dead-lock.html)]

### 1. 事务加锁顺序不一致（最常见）

当多个事务同时操作多条数据时，如果以不同的顺序请求资源，极易形成相互等待的闭环。 [[1](https://cloud.tencent.com/developer/article/2615459), [2](https://github.com/0voice/qt_interview_reference/blob/main/147、MySQL死锁问题产生原因及如何解决？.md), [3](https://www.fangzhipeng.com/interview/mysql/2024-04-01-mysql-dead-lock.html)]

- **场景**：事务 A 先更新 1 号数据再更新 2 号数据；同时，事务 B 先更新 2 号数据再更新 1 号数据。
- **结果**：事务 A 持有 1 号锁等 2 号锁，事务 B 持有 2 号锁等 1 号锁，形成死锁。 [[1](https://zhuanlan.zhihu.com/p/701129492)]

## 2. 间隙锁（Gap Lock）的竞争

在可重复读（`REPEATABLE READ`）隔离级别下，为了解决幻读问题，InnoDB 会使用[间隙锁](https://www.xiaolincoding.com/mysql/lock/deadlock.html)。 [[1](https://golangguide.top/中间件/mysql/核心知识点/为什么mysql插入不存在的数据会产生死锁？.html), [2](https://www.xiaolincoding.com/mysql/lock/deadlock.html)]

- **场景**：事务 A 和事务 B 同时对不存在的同一区间进行插入或修改，事务 A 的间隙锁会阻塞事务 B 的插入，若此时双方又需要获取对方已占有的其它锁，就会发生死锁。 [[1](https://www.seven97.top/database/mysql/02-lock3-deadlock-mysql.html)]

### 3. 索引设计不当导致锁表

如果 SQL 没有使用索引，或者索引失效导致全表扫描，InnoDB 会退化为**表级锁**。

- **场景**：当多个事务并发执行无索引条件的修改（如 `WHERE 非索引列 = 'value'`）时，会锁住全表数据，造成极大的并发冲突和死锁。 [[1](https://cloud.tencent.com/developer/article/2051342)]

### 4. 长事务并发

长事务意味着持有锁的时间较长，事务之间交叉修改相同数据的概率大幅上升，极易导致锁冲突升级为死锁。 [[1](https://cloud.tencent.com/developer/article/2615459), [2](https://github.com/0voice/qt_interview_reference/blob/main/147、MySQL死锁问题产生原因及如何解决？.md)]

如何排查与解决？

- **查看死锁日志**：通过执行 `SHOW ENGINE INNODB STATUS;` 命令可以查看最后一次发生的死锁详细日志，找出导致死锁的 SQL 语句和持有锁的索引。
- **统一加锁顺序**：在应用层编写代码时，保证不同事务更新多张表或多行数据时，操作顺序保持一致。
- **优化索引**：通过合理的索引设计让查询走精确的行锁（Record Lock），避免全表扫描或锁范围过大。
- **合理拆分与重试**：将长事务拆解为多个小事务，并在代码层面对死锁异常（错误码 1213）进行**自动重试**。 [[1](https://cloud.tencent.com/developer/article/2615459), [2](https://cloud.tencent.com/developer/article/2051342)]

如果遇到具体的死锁报错，可以提供以下信息以便我协助分析：

1. **死锁日志详情**（通过 `SHOW ENGINE INNODB STATUS` 获取）
2. **具体的 SQL 语句**
3. 表的 **索引结构** 和当前的 **事务隔离级别**


## 千万级别mysql表锁表了怎么办，如何处理
要回答这道面试题，首先要搞清楚mysql有哪些存储引擎呢？平常我们用的最多的就是InnoDB和MyISAM，它们在使用锁的方式上是不一样的，mysql常见的有三种锁：表锁、行锁、页面锁下面分别介绍：

### MyISAM

只支持表级锁，无论是insert、update、delete都会对整表加锁，该存储引擎不支持事务，性能比较好，但由于整表锁，所以tps不太高，不适合高并发操作，选型时要慎重。

### Innodb

支持表锁和行锁，该存储引擎支持事务，由于支持细粒度的行锁，所以比较适合高并发操作，那到底什么时候使用表锁呢？根据我多年的经验，主要有以下几种场景：

1）sql未使用索引，更新或删除单表中的数据

2）sql使用索引，但不是唯一索引，这个时候如果更新表中的大量数据或全量数据，此时如果使用行锁，会造成事务长时间等待、 锁冲突，因此mysql会升级为锁表.sql操作了几张表，即传说中的大事务，比较复杂，这个时候mysql为了防止死锁和事务回滚，会同时锁相关的表

3）使用类似select * from user for update的sql语句显式锁表

4）对线上大数据量并且活跃时间的表直接进行DDL操作或加索引操作，这也会造成锁表

### 假如当线上环境遇到锁表后怎么办？

1）线上如果发现大量sql语句导致长时间锁表，可以通过show processlist命令找出锁表的进程号，然后执行kill 进程号命令，快速结束锁表语句

2）根据上一步的锁表sql快速从程序中找出是哪个业务导致的，解决bug后紧急发版，如果是非核心业务导致，为了保证系统不被拖挂，可以将接口作降级处理

3）可以写一个检查锁表的运维脚本，每隔几分钟检查一次，出现长时间锁表的sql发出告警提醒

### 既然知道了锁表以后，我们有一些事后的补救措施，那我们是不是在刚开始设计的时候就可以尽可能规避这些坑呢，有没有一些比较好的实践？答案是有的，如下所示：

1）对于大表的操作，查询条件一定要保证命中索引，如果能命中唯一索引就更好了

2）我们在程序开发的时候，尽可能将大事务拆分为小事务，减少锁表或回滚，比如：抽离部分业务逻辑异步发送消息队列处理

3）更新很频繁的业务，尽量转为批量处理，另外尽可能减少单次处理的数据量，大数据量可以分批次处理

4）不要通过select * from user for update显示锁表，特别是高并发的时候，这种操作会很骚，严重影响tps，我们可以通过乐观锁加版本号实现或者先写到缓存然后异步写表等方案解决

5）业务高峰期，不要随便直接加字段或索引，尽量用户不活跃时执行，但是如果一定要在高峰期操作，可以复制旧表结构创建一个新表，然后在新表上加字段或索引，接着将原来旧表的数据copy到新表，再rename两个表，最后将rename期间旧表的增量数据迁移到新表

6）采用读写分离架构