# rpc异常处理

## 格式一

1. 服务超时或挂了，系统内500空指针错误等都会进入降级方法中
2. 服务报业务异常serviceexcption，不会进入降级方法，直接抛出异常到给调用者 例如：
![alt text](image.png)

## 格式二

1. 服务报业务异常serviceexcption，不会进入降级方法，直接抛出异常到给调用者 例如：
   1. ![alt text](image-1.png)