JavaScript笔记

2024年3月11日

9:41

 

1.  组成部分：

    1.  ECMAScript： JS相关语法和基本对象

    2.  DOM: 处理页面内容方法和接口

    3.  BOM：处理浏览器交互和方法和接口

2.  JS引入：

    1.  内嵌式：

        1.  \<script type=\"text/javascript\"\>xxxxx代码\</script\>

    2.  外联式：

        1.  \<script src=\'\'/1.js\"\>\</script\>

        2.  注意外联式内部代码作废

3.  基本语法：

    1.  变量：

        1.  弱类型（类型可不定义）

        2.  var 变量名 = 值；

    2.  数据类型：

        1.  数字number

        2.  布尔boolean: true/false

        3.  字符串string:

        4.  引用类型object:

            1.  值null

            2.  值undifined是值null的一种 二者相等

        5.  undifined: 变量未初始化，变量值默认为undifined

    3.  输出方式：

        1.  Windows.alert("文本内容")，window可省略

        2.  Consle.log()/warn()/error()输出日志控制台

        3.  Document.write（\"文本内容\"）

4.  运算符：

    1.  算术：

    2.  赋值：

    3.  比较：

        1.  ==：比较的是值是否相等

        2.  ===：比较的是值和数据类型是否都相等

    4.  逻辑：

5.  布尔类型：

    1.  数字类型：非0就是true

    2.  字符串类型：非""就是true;长度》0就是true

6.  函数：

    1.  定义方式：

        1.  普通函数：

            1.  Function 函数名（参数列表）{

> return
>
> }

1.  函数调用：函数名（参数）

```{=html}
<!-- -->
```
1.  匿名函数：

    1.  没法直接调用，要结合事件调用

    2.  var fn= Function（参数列表）{

> return
>
> }

1.  事件：

    1.  常用事件：

        1.  Onload

        2.  Onsubmit

        3.  Onclick

        4.  Onfocus

    2.  概念：

        1.  事件源：具体元素

        2.  事件：触发的事件

        3.  监听器：事件上绑定的函数

2.  DOM对象：

    1.  DOM文档对象模型，定义了访问与处理html文档的标准方法

    2.  树结构（节点树）：

        1.  元素:\<head\>

        2.  属性:\<href\> \<backcolor\>为元素的属性

        3.  文本

    3.  要改变某个元素，要先获取html文档入口，通过dom对象获取，DOM提供了 HTML 元素进行添加、移动、改变或移除的方法和属性

    4.  Api:

        1.  流程：

            1.  通过document.getElementById(id属性值)/ByTagName/ByclassName获取到元素

            2.  获取元素对象后，通过对象修改属性值或元素内文本的值

        2.  元素的操作：document.getElementById(id属性值)/ByTagName/ByclassName

        3.  属性的操作：元素.属性名getAtrribute

        4.  文本的操作:

            1.  识别html:innerHTML

            2.  纯文本：innerText

    5.  练习：

        1.  隔行换色

            1.  获取所有tr元素的行，document.bytagname

            2.  除以2取余改默认背景属性

            3.  onmouseover鼠标移动事件改属性，onmouseover移除

    6.  表单用户登录验证：

        1.  表单添加提交事件\<from action=\"#\" methon=\"get\" onsubmit=\"return fn()\"\>

        2.  js代码：

            1.  函数体内获取元素对象，取元素值

            2.  判断是否为空，是空就返回true，false就将提升内容输出到文本域内（请填写用户名密码）

3.  JS内置对象

    1.  全局/顶层函数Functions

        1.  包含全局属性和函数

        2.  使用方法：直接调用函数名

        3.  parseint（string）字符串返回为浮点型

        4.  parseInt（String）

    2.  String对象：

        1.  属性：lenth（）

        2.  方法：

            1.  charat（index）、

            2.  indexof（string）第一次出现的索引

            3.  substring（startindex，endindex）截取开始，不包含结束索引

            4.  substr（startinx,count）包含开始索引和之后几个字符

    3.  date对象：

    4.  math对象

    5.  array对象：和java一样

4.  RegExp正则表达式

5.  BOM对象：

    1.  浏览器对象，操作bom对象模拟浏览器功能

    2.  windows对象：表示浏览器打开的窗口

        1.  消息框：

            1.  Alert:指定消息和ok按钮警告框

            2.  confirm返回带有指定内容消息和ok及取消对话框，选择后返回true或fasle

            3.  prompt提示输入内容对话框，输入后返回输入内容，取消返回null

        2.  定时器：

            1.  setTimeout(定时函数，毫秒值)定时执行一次

            2.  setinterval（定时函数，毫秒值）反复执行

            3.  clearInterval

    3.  location对象：操作浏览器地址栏

        1.  Location.href="xxx.com"

6.  练习：

    1.  定时广告：

        1.  获取元素

        2.  元素。style。Display=\'block\'显示

        3.  元素。style。Display=\'none不显示

        4.  定时器

    2.  轮播图：

        1.  获取元素

        2.  函数循环i++，元素.src='i.img\"

        3.  定时器

>  
>
>  
