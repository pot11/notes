# spring事务传播

## 场景

### 方法A调用方法B  

1. 如果A和B方法在同一个类中：  
如果A加@Transactional注解，B加不加@Transactional注解，事务是有效的，则AB在同一事务中。  
如果A不加@Transactional注解，B加不加@Transactional注解，事务都是无效的。  

2. 如果A和B不在同一个类中：  
如果A加@Transactional注解，B加不加@Transactional注解，事务是有效的。  
如果A不加@Transactional注解，B加了@Transactional注解，只有B是有事务的；  
如果A不加@Transactional注解，B不加@Transactional注解，A、B都是没有事务的。

总结：
1、如果A加@Transactional注解，不管是不是在一个类中，不管B加不加注解，AB都是在同一事务中；  
2、如果A不加@Transactional注解，只有B加@Transactional注解，AB方法为同一类，事务失效；AB不同类，只有B有事务；  
3、如果A不加@Transactional注解，B不加@Transactional注解，则没有事务；

原因：A方法上有@Transactional注解，spring在管理的时候，会生成一个代理类，真正调用到A方法时，实际执行的是代理类里面的方法，该代理类里面的方法已经包括了B方法的调用，已经成为了一个方法。所以事务是有效的