# redis面试

## 使用场景

### 缓存

1. 缓存穿透：查询一个不存在数据，mysql查询不到数据也不会直接写入缓存，导致每次请求都查数据库。
   1. 解决一：缓存空数据，查询返回数据为空，将空结果缓存（缺点：内存大，缓存和数据库不一致问题）
   2. 解决二：布隆过滤器 （缓存预热）
      1. bitmap（位图），相当于一个以bit位为单位的数组，数组中每个单元只能存储二进制数0或1，
      2. 作用：用于检索一个元素是否做一个集合中
      3. 原理：
         1. 存储数据：id为1的数据，通过多个hash函数获取hash值，根据hash计算数组对应位置改为1
         2. 查询数据：使用相同hash函数获取hash值，判断对应位置是否都为1
         3. 好处只存01对内存压力小
      4. 实现方案reidssion或guava
      5. 问题：存在误判，多个id可能hash位置一样，数组越大误判率小，可以做代码中设置误判率，一般是5%
2. 缓存击穿：
   1. 给某个热点key设置了过期时间，当key过期时候，恰好有大量此key的请求过来，并发的请求可能把db压垮
   2. 解决一：互斥锁 强一致 性能差
   3. 解决二：逻辑过期，高可用，性能优，不能保证数据绝对一致性
   4. 原理图：![alt text](image.png)
3. 缓存雪崩：
   1. 概念：同一时间段大量的缓存同时失效或redis宕机，导致大量请求到db，巨大压力
   2. 解决：
      1. 给不同key到ttl（过期时间）添加随机值
      2. redis集群保证高可用（哨兵、集群）
      3. 缓存业务提阿杰降级限流策略（nginx、gateway）
      4. 业务添加多级缓存（guava或caffeine做一级缓存，redis作二级缓存）
4. redis缓存，mysql的数据如何reidis进行同步（如何保证双写一致性问题）？
   1. 设置业务背景
   2. 双写一致性：修改db后同时更新缓存数据，保持缓存与db一致
   3. 读操作：缓存命中，直接返回，未命中查数据库写入缓存，设置超时时间
   4. 写操作：延迟双删（删除缓存---修改数据库---删除数据库）
      1. 为什么要延时：
         1. 答：主从结构 读写分离 节点数据同步完成后  延时一会删除
      2. 为什么要删除两次：
         1. 多线程同时请求下会有脏数据
      3. 先删除缓存，还是先修改数据库？
         1. 都一样，无法保证强一致性
      4. ![alt text](image-2.png)
      5. 解决方案：强一致
         1. ![alt text](image-3.png)
         2. ![alt text](image-4.png)
         3. ![alt text](image-5.png)
   5. 总结；![alt text](image-6.png)
5. redis持久化
   1. rdb（redis database backup）数据备份文件，数据快照，把内存中数据记录到磁盘。故障重启，磁盘读取快照，恢复数据  
      1. save 主进程执行rdb，会阻塞所有命令
      2. bgsave开启子进程执行rdb，避免主进程受影响
   2. aof append only file（追加文件），命令日志文件
      1. redis.conf配置文件开启
      2. erverysec每秒刷盘模式 常用
      3. brewriteaof命令
      4. 总结：![alt text](image-7.png)
6. redis数据过期策略
   1. ![alt text](image-8.png)
7. reids淘汰策略
   1. ![alt text](image-9.png)
   2. ![alt text](image-10.png)
   3. 总结：
      1. ![alt text](image-11.png)
      2. ![alt text](image-12.png)

### 分布式锁

1. synchronized是jvm线程锁，单体服务情况下没问题
   1. ![alt text](image-13.png)
2. 多服务节点（多台服务器同一套代码）
   1. ![alt text](image-14.png)
   2. ![alt text](image-15.png)
3. redis实现分布式锁利用的锁redis的setnx命令。setnx锁set if not exist（如果不存在，则set）简写
4. ![alt text](image-16.png)
5. ![alt text](image-17.png)
6. ![啊](image-18.png)
7. lua脚本保证多条命令执行的原子性
8. redisson实现的分布式锁-可重入
   1. ![alt text](image-19.png)
9. redis实现分布式锁--主从一致性
   1. ![alt text](image-20.png)
   2. ![alt text](image-21.png)
   3. ![alt text](image-22.png)
   4. ![alt text](image-23.png)
   5. ![alt text](image-24.png)
10. redis集群方案有哪些？
    1. 主从模式
       1. ![alt text](image-25.png)
       2. ![alt text](image-26.png)
       3. ![alt text](image-27.png)
       4. ![alt text](image-28.png)
       5. ![alt text](image-29.png)
    2. 哨兵模式
       1. ![哨兵模式介绍](image-30.png)
       2. ![服务状态监控](image-31.png)
       3. ![哨兵模式脑裂问题](image-32.png)
       4. ![总结](image-33.png)
       5. 写8万并发 读10万并发
       6. ![面试回答](image-34.png)
    3. 分片集群
       1. ![分片集群结构](image-35.png)
       2. ![数据读写](image-36.png)
       3. ![总结](image-37.png)
       4. ![面试回答](image-38.png)

## 其他方面

1. ![alt text](image-39.png)
2. ![alt text](image-40.png)
3. ![alt text](image-41.png)
4. ![alt text](image-42.png)
5. ![alt text](image-44.png)
6. ![alt text](image-45.png)
7. ![redis网络模型](image-46.png)
8. ![alt text](image-47.png)
9. ![面试回答](image-48.png)