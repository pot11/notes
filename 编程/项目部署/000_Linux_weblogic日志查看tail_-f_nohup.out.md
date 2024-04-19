Linux weblogic日志查看tail -f nohup.out

2020年4月30日

10:33

 

之前用Tomcat时，查看后台日志，都是使用tail -f catalina.out命令来查看的，不要太顺手；

 

今天登陆到公司另外一个Team 的服务器上，发现装的是weblogic，手痒想看看weblogic怎么看日志，找了老半天，才发现有一个nohup.out文件，还有一些.log文件；

 

so,查看后台日志（像eclipse的后台一样，动态显示）：

 

tail -f nohup.out

 

想看历史的N行log信息（1000行）：

 

tail -1000 nohup.out

 

(同样适用于.log文件的查询)
