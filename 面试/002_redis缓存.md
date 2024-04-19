redis缓存

2023年2月13日

11:19

 

1.  修改开关操作：

    1.  客户端更新保存后，服务端修改数据库

    2.  将参数编码key，开关对象value存入redis中（单独设置前缀）

    3.  将LocalCacheSwitchImpl中atomicInteger号加一（为后续比较版本号做准备）

    4.  向客户端推送mq消息，让客户端查询的时候更新，第一次还是原来的值，第二次才是更新后的值（异步线程导致）

2.  增量更新：

    1.  judgeCanche（）中用atomicInteger号和首次客户端启动时候的localVersion做比较

        1.  相同：返回

        2.  不相同：根据数据库开关表最后更新时间（客户端首次登录会存timeStamp），查出新修改的几条数据

        3.  将新数据put如本地cacheMap中

        4.  服务端更新后

3.  查询：

    1.  查询同2,从cacheMap中取数据
