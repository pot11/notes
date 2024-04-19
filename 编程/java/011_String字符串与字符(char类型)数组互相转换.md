**String字符串与字符(char类型)数组互相转换**

2018年9月27日

9:06

 

主要是两个方法： 

**1.String类的toCharArray()方法，将字符串转为字符(char)数组** 

String ss="abc"; 

char\[\] cc; 

cc=ss.toCharArray(); 

这时cc={'a','b','c'}；

**2.String类的valueOf()方法，将字符(char)数组转换为字符串** 

char\[\] cc={'a','b','c'}; 

ss=String.valueOf(cc); 

这时ss="abc"；

 

 
