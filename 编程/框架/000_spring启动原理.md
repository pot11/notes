spring启动原理

2020年11月7日

15:42

 

![](000_spring启动原理_000.png)

自定义类实现BeanFactoryPostProcessor接口

![](000_spring启动原理_001.png)

 

====================================================================================================================================

二。像dao接口这种不能通过反射直接创建对象的，需要实现FactoryBean接口，然后再通过通过beanfactorypostprocesser注bean定义

 

![](000_spring启动原理_002.png)

 

自定义类实现BeanFactoryPostProcessor接口

![](000_spring启动原理_003.png)

启动类

![](000_spring启动原理_004.png)

 
