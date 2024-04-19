ajax

2019年9月26日

18:07

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td>用封装好的HM jQuery文件时候，因为封装时候结果返回要求datatype<br />
是json类型，所以即使为客户端不关心返回的数据，也要有数据（空也行）</td>
</tr>
</tbody>
</table>

 

**问题：1.jquery ajax()请求成功，在控制台可以看到返回的数据，但是回调函数中却取不到数据？**

 

 

JQuery Ajax： 客户端发起请求，得到服务器端的相应是200，正确拿到服务器响应的数据.此时在判断进入success

对应的回调函数还是进入到**error对应的回调函数**之前，可能会校验一些东西：

 

**1.** 返回的每条数据是否是dataType中定义的数据类型。如果有部分数据不是或者哪怕一条数据没有严格的按照dataType定义的类型，程序就会进入到error:function(){\*\*\*\*}

**2.** 请求的域和当前域是否是同一域，如果不是同一域也十分有可能进入error:function(){\*\*\*} "

------------------------------------------------

 

 

**哪些情况会执行error的回调函数**

 

 

 

首先在说ajax之前要说的是关于button标签的属性问题。

 

button标签的默认type是submit，如果在一个表单中使用了button却没有规定type='button'，那么这个button的默认属性是submit.

 

我首次遇到这个问题是在一个表单中，没有指定action和method，希望给button绑定一个点击事件，通过ajax给表单中添加内容，但是每次点击按钮的时候都会出现页面刷新的情况，后在action中加一个"#"，发现点击按钮后，地址栏的地址多了一个"#"，分析后觉得是因为提交表单的缘故。但是我没有给button设定type="submit"，在ajax 中加了error的回调函数，但是并没有执行，最终查询资料发现是button的默认属性导致的原因。

 

在此次调试中还遇到的问题就是ajax会执行error的回调，之前很少遇到error的情况，在网上找半天发现error的作用挺大的，可以帮助我们很好的排查错误的原因。

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>$.ajax({</p>
<p>url : "/service/compute.do",</p>
<p>data : {</p>
<p>data: data</p>
<p>},</p>
<p>async: false,</p>
<p>dataType:"text",</p>
<p>success: function(data){</p>
<p>alert(data);</p>
<p>},</p>
<p>error: function(XMLHttpRequest, textStatus, errorThrown){</p>
<p>alert(XMLHttpRequest.readyState + XMLHttpRequest.status + XMLHttpRequest.responseText);</p>
<p>}</p>
<p>});</p></td>
</tr>
</tbody>
</table>

首先ajax会执行error的可能原因有：

1\. dataType错误（dataType用来指定后台返回参数的类型）

 

类型错误：后台返回的dataType类型和前台写的不一致会跳入error。

 

格式错误：jquery1.4之后对json的格式要求非常严格，json格式错误也会跳入error.{"test":1} 注意格式

 

有时，在不需要返回值的情况下，扔按模板格式，设置了dataType:"json",参数；这时候，ajax传值正确时，出现200返回成功状态下报错的特殊情况。

 

如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断，比如 XML MIME 类型就被识别为 XML。在 1.4 中，JSON 就会生成一个 JavaScript 对象，而 script 则会执行这个脚本。随后服务器端返回的数据会根据这个值解析后，传递给回调函数。可用值:

"xml": 返回 XML 文档，可用 jQuery 处理。

"html": 返回纯文本 HTML 信息；包含的 script 标签会在插入 dom 时执行。

"script": 返回纯文本 JavaScript 代码。不会自动缓存结果。除非设置了 "cache" 参数。注意：在远程请求时(不在同一个域下)，所有 POST 请求都将转为 GET 请求。（因为将使用 DOM 的 script标签来加载）

"json": 返回 JSON 数据 。

"jsonp": JSONP 格式。使用 JSONP 形式调用函数时，如 "myurl?callback=?" jQuery 将自动替换 ? 为正确的函数名，以执行回调函数。

"text": 返回纯文本字符串

 

async请求同步异步问题

 

async默认是true(异步请求),如果想一个Ajax执行完后再执行另一个Ajax, 需要把async=false

 

例如，你用post请求传值到另一个页面后台，但是页面一加载你的ajax就已经执行过了，传值接收是在后台才完成的，这时候就请求不到数据，所以可以考虑把ajax请求改为同步试试。

 

data不能不写

 

data为空也一定要传"{}"；不然返回的是xml格式的。并提示parsererror. data:"{}"

 

parsererror的异常和Header 类型也有关系。及编码header('Content-type: text/html; charset=utf8');

 

传递的参数

 

必须是ajax支持的编码格式

 

URL路径问题

 

路径不能有中文

 

一般我们可以通过分析error中的一些参数进行错误原因的判断：

 

XMLHttpRequest.readyState: 状态码

 

0 － （未初始化）还没有调用send()方法

1 － （载入）已调用send()方法，正在发送请求

2 － （载入完成）send()方法执行完成，已经接收到全部响应内容

3 － （交互）正在解析响应内容

4 － （完成）响应内容解析完成，可以在客户端调用了

 

XMLHttpRequest.status：调用http请求状态

请求状态有很多，具体遇到错误状态代码可以自行百度查询。

 

XMLHttpRequest.responseText：返回的错误信息

如果发生了错误，错误信息（第二个参数）除了得到null之外，还可能是"timeout", "error", "notmodified" 和 "parsererror"。

------------------------------------------------

 

原文链接：https://blog.csdn.net/nb7474/article/details/79046619

 
