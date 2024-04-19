Java bean问题

2019年9月26日

16:19

ajax中type如果不设置为json，则收到是字符串，

eval黑魔法

BeanUtils.populate

 

分页查询

 

pagebean

 

jsp

 

cook session域

 

result结果格式

 

requestThreadLocal

 

 

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><mark>json转换的时候 如果发现目标为单列集合list 则转换（序列化）为数组</mark></p>
<blockquote>
<p><mark>map集合 则转换（序列化）为对象</mark></p>
<p><mark>（项目第三天 视频4 购物车的展示 ）</mark></p>
</blockquote>
<p><mark>json序列化： 把对象转化为json格式的字符串</mark></p>
<p><mark>json反序列化： 把json格式字符串变成对像</mark></p>
<p> </p>
<p><mark>object流</mark></p>
<p> </p>
<p><mark>序列化过程中 不关心字段 序列化出来的属性名为getxxx的xxx，值为返回值类型的类型的 类型</mark></p>
<p> </p>
<p> </p>
<p> </p>
<p>购物车页面服务器返回的数据结果格式：</p>
<blockquote>
<p>1.result中，data段为cart对象</p>
<p><img src="068_Java_bean问题_000.png" /></p>
<p>2.cart对象中，是items段，total段</p>
<p>情况一：item为数组</p>
<p><img src="068_Java_bean问题_001.png" /></p>
</blockquote>
<p> </p>
<blockquote>
<p>3.item段中为product段，count段，subtotal段</p>
<p>情况一：item为数组</p>
<p><img src="068_Java_bean问题_002.png" /></p>
<p> </p>
<p>代码：</p>
<p><img src="068_Java_bean问题_003.png" /></p>
<p> </p>
<p> </p>
<p> </p>
<p>序列化到cart的item属性时候，根据返回值类型确定item段的值类型</p>
<p>根据getxxx确定属性名</p>
</blockquote></td>
</tr>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>vue data中数据的格式[] {} 序列化 javaBean jackson objectmapper</p>
<p>vue支持遍历map集合</p>
<p> </p>
<p>car数据 vue循环数据的格式</p></td>
</tr>
</tbody>
</table>

 

 

 

 

 

购物车session，从session中去除cart，往cart中存cartitem，session会随之修改吗？

 

 

当一个A页面跳转 下一个B页面

他们之间交互的媒介，就是地址A页面a标签中目标地址（B）后面加的参数（pid,cid）...

因为B页面在加载的时候，需要向服务器发请求要页面内容显示的数据，发请求的ajax数据参数

就是A页面要跳转地址栏后面的参数

情况二：item为对象

![](068_Java_bean问题_004.png)

 

 

 

情况二：item为对象

![](068_Java_bean问题_005.png)

代码：

![](068_Java_bean问题_006.png)

 

 

后端pojo 中实体类中getxxx

前端jsp 中el表达式\${user.id}这里获得的值是通过getXXX（）方法名有关，跟属性名无关，

因为方法是public，属性是private的，只要方法内赋值的属性名与成员属性名相同即可
