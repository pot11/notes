springMVC

2019年11月29日

9:38

 

1.@RequestParm注解只能接受

> get路径上的请求
>
> Post的表单请求 （接受的是表单中某个中具体某一个值，要想接受全部需要用转成map） 例：(@RequestParm MultipartFile file)这里接受的是file对象这一个值
>
> （@RequestParm Map\<String,String\> map）可以接受全部表单中的值

2.@RequestBody注解只能接受

> Content-Type：Application/json 类型的数据
>
> 处理body中json类型的数据
>
> Content-Type代表发送端（客户端\|服务器）发送的实体数据的数据类

 

3.http对下载文件名有要求，要用iso8859-1格式

 

4.根据分布式id，即spuid查商品时候，controller中接受参数类型为string spuid

 

Runwith spring

工具类为什么不用加入spring容器中 \@componet

Json formdata

springMVC json=\>对象 json字符串中key value 的个数，与后端对象的属性个数

 

\@GetMapping 只能用来查询

\@PostMappeing 增加 删除 修改都可以

JWT生成签名为什么需要密钥,SHA256是哈希算法,为什么会需要密钥?

JWT生成签名为什么需要密钥,SHA256是哈希算法,又不是可以解密的算法,为什么会需要密钥呢? 难道是把密钥当盐和前两部分一起sha256?

网上很多md5,sha-x的解密网站,都穷举过了,岂不是很容易知道密钥?

 

不是JAVA程序员，hash加key应该是类似hmac的加密方式，试着答一下，hmac加密常应用于身份验证，如果是在"质疑/应答"的通讯中使用hmac(服务器先发送一个随机key，客户端对密码hmac后发送给服务器，服务器对数据库中密码hmac后比对)，如果有第三方截获了双方通讯信息，只能得知一个随机数和一个哈希值，无法仿造或者破解密码(一说SSL握手就是使用的HMAC-MD5，俗称challenge协议)。

以下引用廖雪峰老师博客和其他网站的部分相关内容：

实际上，把salt看做一个"口令"，加salt的哈希就是：计算一段message的哈希时，根据不通口令计算出不同的哈希。要验证哈希值，必须同时提供正确的口令。

这实际上就是Hmac算法：Keyed-Hashing for Message Authentication。它通过一个标准算法，在计算哈希的过程中，把key混入计算过程中。

和我们自定义的加salt算法不同，Hmac算法针对所有哈希算法都通用，无论是MD5还是SHA-1。采用Hmac替代我们自己的salt算法，可以使程序算法更标准化，也更安全。

为什么需要一些特别的算法比如HMAC，而不是直接把密码和加密key拼接在一起

hash函数，比如MD5,SHA1,SHA2使用了Merkle--Damgård construction，这导致算法可能长度扩展攻击(length extension attacks)。意思就是说给定一个hash H(X)，攻击者可以在不知道X的情况下，可以找到一个H(pad(X)+Y)的值，Y是个其他的字符串。pad(X)是hash函数使用的填充函数(padding function)。

这就意味者，对于hash H(key + message)，攻击者可以计算 H(pad(key + message) + extension)，并不需要知道加密key。如果这个hash是用在消息认证过程中，使用key为了避免消息被修改。这样的话这个系统就可能失效了，因为攻击者掌握了一个有效的基于 message+extension的hash。

这种攻击对于如何快速破解hash还不是很清楚。但是，基于一些风险的考虑，不建议使用单纯的hash函数进行加密key的hash。也许一个聪明的密码学家一天就可以找到使用这种攻击快速破解hash的方法。所以记得使用HMAC。

 

{

> \"loginName\":\"demo\",
>
> \"password\":\"\$10\$nqdcvIUQl1maXTjbz0/hLu7eEU2yWR.8bkeKQ2xzO5sMrlV99Wdki\"

}
