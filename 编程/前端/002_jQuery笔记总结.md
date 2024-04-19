[**jQuery笔记总结**](https://www.cnblogs.com/xuxiuyu/p/5989278.html)

2018年11月4日

8:58

 

[**jQuery笔记总结**](https://www.cnblogs.com/xuxiuyu/p/5989278.html)

**第一节 jQuery初步认知**

jQuery概述

-   **JQuery概念**

    -   javascript概念

        -   基于Js语言的API和语法组织逻辑，通过内置window和document对象，来操作内存中的DOM元素

    -   JQuery概念

        -   基于javascript的，同上，提高了代码的效率

-   **jQuery是什么:**

    -   是一个javascript代码仓库，我们称之为javascript框架。

    -   是一个快速的简洁的javascript框架，可以简化查询DOM对象、处理事件、制作动画、处理Ajax交互过程。

    -   **它可以帮我们做什么(有什么优势)**

        -   轻量级、体积小，使用灵巧(只需引入一个js文件)

        -   强大的选择器

        -   出色的DOM操作的封装

        -   出色的浏览器兼容性

        -   可靠的事件处理机制

        -   完善的Ajax

        -   链式操作、隐式迭代

        -   方便的选择页面元素(模仿CSS选择器更精确、灵活)

        -   动态更改页面样式/页面内容(操作DOM，动态添加、移除样式)

        -   控制响应事件(动态添加响应事件)

        -   提供基本网页特效(提供已封装的网页特效方法)

        -   快速实现通信(ajax)

        -   易扩展、插件丰富

-   **如何引入JQuery包**

    -   引入本地的JQuery

    -   引入Google在线提供的库文件（稳定可靠高速）

    -   使用Google提供的API导入 \<script type="text/javascript" src="jquery.js"\>\</script\>

    -   写第一个JQUery案例

        -   解释:在JQuery库中，\$是JQuery的别名，\$()等效于就jQuery()

\<script type="text/javascript" src=""\>\</script\>\
\<script type="text/javascript"\>\
\$(function(){\
alert("jQuery 你好!");\
});\
\</script\>

-   **讲解\$(function(){});**

    -   \$是jQuery别名。如\$()也可jQuery()这样写,相当于页面初始化函数，当页面加载完毕，会执行jQuery()。

    -   希望在做所有事情之前，JQuery操作DOM文档。必须确保在DOM载入完毕后开始执行，应该用ready事件做处理HTML文档的开始

    -   \$(document).ready(function(){});

        -   类似于js的window.onload事件函数，但是ready事件要先于onload事件执行

        -   window.onload = function(){};

    -   为方便开发，jQuery简化这样的方法，直接用\$()表示

    -   JQuery的ready事件不等于Js的load：

        -   执行时机不同：load需要等外部图片和视频等全部加载才执行。ready是DOM绘制完毕后执行，先与外部文件

        -   用法不同：load只可写一次，ready可以多次

-   **window.onload与\$(document).ready()对比**

<table>
<colgroup>
<col style="width: 23%" />
<col style="width: 17%" />
<col style="width: 59%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>window.onload</strong></td>
<td> </td>
<td><strong>$(document).ready()</strong></td>
</tr>
<tr class="even">
<td>执行时机</td>
<td>必须等网页中所有内容加载完后(图片)才执行</td>
<td>网页中的DOM结构绘制完后就执行,可能DOM元素相关的东西并没有加载完</td>
</tr>
<tr class="odd">
<td>编写个数</td>
<td>不能同时执行多个</td>
<td>能同时执行多个</td>
</tr>
<tr class="even">
<td>简化写法</td>
<td>无</td>
<td><p>$(document).ready(function(){ //.. });</p>
<p> </p>
<p>推荐写法：$(function(){ });</p></td>
</tr>
</tbody>
</table>

-   **jQuery有哪些功能(API)**：

    -   选择器

    -   过滤器

    -   事件

    -   效果

    -   ajax

-   **简单的JQuery选择器**：

    -   JQuery基本选择器（ID选择器，标签选择器，类选择器，通配选择器和组选择器5种）

    -   ID选择器：document.getElementById(id)与\$(\"#id\")对比(改变文字大小)\-\--id唯一，返回单个元素

    -   标签选择器：document.getElementsByTagName(tagName)与\$(\"tagname\")对比\-\--多个标签，返回数组

    -   类选择器:\$(\".className\")\--多个classname（改变背景图片）

    -   通配选择器：document.getElementsByTagName(\"\*\")与\$(\"\*\")对比\-\--指范围内的所有标签元素

    -   组选择器：\$(\"seletor1,seletor2,seletor3\")\-\-\--无数量限制，用逗号分割

初步了解JQuery

-   **JQuery是什么**

    -   javascript用来干什么的：

        -   操作DOM对象

        -   动态操作样式css

        -   数据访问

        -   控制响应事件等

    -   jQuery作用一样，只是更加快速简洁

-   **如何引用JQuery**

\<script type=\"text/javascript\"\>\</script\>\
写第一个JQUery案例\
\<script type="text/javascript" src=""\>\</script\>\
\<script type="text/javascript"\>\
\$(function(){\
alert("jQuery 你好!");\
});\
\</script\>

-   **\$()讲解**

    -   \$在JQuery库中，\$是JQuery的别名，\$()等效于就jQuery().

    -   \$()是JQuery方法,赞可看作是JQuery的选择器，与css选择器相似（可做对比）

    -   var jQuery==\$ =function(){} \$()本质就是一个函数也就是 jQuery的核心函数

    -   只要是jQuery的对象都这样变量加上一个符号\$ 方便识别：var \$div = \$(\"#\")

function　\$(id){\
return document.getElementById(id);\
}

-   **\$()和document是相等的吗**

\<div id=\"a\" class=\"aa\"\>\</div\>\
\<div id=\"b\" class=\"aa\"\>\</div\>\
\<div id=\"c\" class=\"aa\"\>\</div\>\
alert(document.getElementById(\"id\") == \$(\"#aa\"));//返回结果为false\
alert(document.getElementById(\"id\") == \$(\"#aa\").get(0));//返回true

-   **代理对象\$()**

    -   jQuery中返回的是代理对象本身

    -   jQuery的核心原理是通过选择器找到对应的代理对象

    -   jQuery全都是通过方法操作

    -   样式选择器\$(\".className\")

        -   \$(\".aa\").css(\"color\",\"green\");

    -   id选择器(\"\")

        -   \$(\"#a\").css(\"background-color\",\"#ff0066\");

    -   标签选择器

        -   \$(\"p\").css(\"color\",\"#cc3366\");

    -   组选择器

        -   \$(\"#b ul li\").size();

-   **对象转换(\$(element))**

    -   原生dom对象和jquery代理对象的相互转换

\$(传入的原生对象);\
//原生对象转化成jQuery对象\
var nav = document.getElementById(\"nav\");\
var \$nav = \$(nav);\
alert(\$nav.get(0) == nav);//true

-   **检索范围的限制（\$(\'字符串\',element)）**

    -   **总结：三种写法对比：**

        -   方式一：不推荐 搜索速度最慢

            -   \$(\"#nav\").css();

            -   \$(\"#nav li\").css();

        -   方式二：搜索速度最快 链式操作

            -   \$(\"#nav\").css().children().css();

        -   方式三：也常用 速度第二快

            -   var \$nav = \$(\"#nav\").css();

            -   \$(\"li\",\$nav).css(); \$nav 限制了搜索范围 速度快

-   **总结： \$() jquery核心方法的作用和使用场景**

    -   如果是一个字符串参数并且没有标签对（选择器） \$(ul.nav\")

    -   如果是一个字符串参数并且有标签对（创建html标签）\$(\"\<img\>\") \--最终加到DOM树中 \$xx.append(\"\<img\>\");

    -   如果是传入一个element dom对象，直接包装为proxy对象返回 \$(DOM对象)

    -   如果第一个参数是字符串，第二个是element dom对象的话，那么就是在element这个dom对象里面寻找选择器对应的元素并且代理 \$(\"li\",\$DOM对象)

-   **代理模式以及代理内存结构**

 

 

**第二节 选择器**

-   **来回顾一下CSS常用的选择器**

|            |                      |                          |
|------------|----------------------|--------------------------|
| **选择器** | **语法**             | **描述**                 |
| 标签选择器 | E{css规则}           | 以文档元素作为选择符     |
| ID选择器   | #ID{css规则}         | ID作为选择符             |
| 类选择器   | E.className{css规则} | class作为选择符          |
| 群组选择器 | E1,E2,E3{css规则}    | 多个选择符应用同样的样式 |
| 后代选择器 | E F{css规则}         | 元素E的任意后代元素F     |

-   **选择器引擎规则(\$(\'字符串\'))**

    -   css选择器的规则

        -   标签选择器

        -   id选择器

        -   类选择器

        -   混合选择器

    -   css3的选择器规则

    -   状态和伪类（:even :odd :first :last :eq(index)）

    -   属性（\[attr=value\]）

-   **层级选择器:通过DOM的嵌套关系匹配元素**

    -   jQuery层级选择器\-\-\--包含选择器、子选择器、相邻选择器、兄弟选择器4种

    -   a.包含选择器：\$(\"a b\")在给定的祖先元素下匹配所有后代元素。(不受层级限制)

    -   b.子选择器：\$(\"parent \> child\") 在给定的父元素下匹配所有子元素。

    -   c.相邻选择器：\$(\"prev + next\") 匹配所有紧接在prev元素后的next元素。

    -   d.兄弟选择器：\$(\"prev \~ siblings\") 匹配prev元素之后的所有sibling元素。

过滤选择器

-   **基本过滤选择**

|            |                                |          |
|------------|--------------------------------|----------|
| **选择器** | **说明**                       | **返回** |
| :first     | 匹配找到的第1个元素            | 单个元素 |
| :last      | 匹配找到的最后一个元素         | 单个元素 |
| :eq        | 匹配一个给定索引值的元素       | 单个元素 |
| :even      | 匹配所有索引值为偶数的元素     | 集合元素 |
| : odd      | 匹配所有索引值为奇数的元素     | 集合元素 |
| :gt(index) | 匹配所有大于给定索引值的元素   | 集合元素 |
| :lt(index) | 匹配所有小于给定索引值的元素   | 集合元素 |
| :not       | 去除所有与给定选择器匹配的元素 | 集合元素 |
| :animated  | 选取当前正在执行动画的所有元素 | 集合元素 |
| focus      | 选取当前正在获取焦点的元素     | 集合元素 |

-   **内容过滤选择器**

|                 |                                  |          |
|-----------------|----------------------------------|----------|
| **选择器**      | **描述**                         | **返回** |
| :contains(text) | 选取含有文本内容为text的元素     | 集合元素 |
| :empty          | 选取不包含子元素获取文本的空元素 | 集合元素 |
| :has(selector)  | 选择含有选择器所匹配的元素的元素 | 集合元素 |
| :parent         | 选取含有子元素或者文本的元素     | 集合元素 |

-   **可见过滤选择器**

|            |                      |          |
|------------|----------------------|----------|
| **选择器** | **描述**             | **返回** |
| :hidden    | 选择所有不可见的元素 | 集合元素 |
| :visible   | 选取所有可见的元素   | 集合元素 |

-   **属性过滤选择器**

|                      |                               |          |
|----------------------|-------------------------------|----------|
| **选择器**           | **说明**                      | **返回** |
| \[attribute\]        | 选取拥有此属性的元素          | 集合元素 |
| \[attribute=value\]  | 选取属性值为value值的元素     | 集合元素 |
| \[attribue\^=value\] | 选取属性的值以value开始的元素 | 集合元素 |
| \[attribue\$=value\] | 选取属性的值以value结束的元素 | 集合元素 |

-   **子元素过滤选择器**

|                            |                                                               |          |
|--------------------|--------------------------------------------|--------|
| **选择器**                 | **说明**                                                      | **返回** |
| :nth-child(index/even/odd) | 选取每个父元素下的第index个子元素或者奇偶元素（index从1算起） | 集合元素 |
| :first-child               | 选取每个元素的第一个子元素                                    | 集合元素 |
| :last-child                | 选取每个元素的最后一个子元素                                  | 集合元素 |

-   :nth-child()选择器是很常用的子元素过滤选择器，如下

    -   :nth-child(even)选择每个父元素下的索引值是偶数的元素

    -   :nth-child(odd)选择每个父元素下的索引值是奇数的元素

    -   :nth-child(2)选择每个父元素下的索引值是2的元素

    -   :nth-child(3n)选择每个父元素下的索引值是3的倍数的元素 (n从1开始)

-   **表单对象属性过滤选择器**

|            |                                        |          |
|------------|----------------------------------------|----------|
| **选择器** | **说明**                               | **返回** |
| :enabled   | 选取所有可用元素                       | 集合元素 |
| :disabled  | 选取所有不可用元素                     | 集合元素 |
| :checked   | 选取所有被选中的元素（单选框、复选框） | 集合元素 |
| :selected  | 选取所有被选中的元素（下拉列表）       | 集合元素 |

-   **表单选择器**

|            |                                          |
|------------|------------------------------------------|
| **选择器** | **说明**                                 |
| :input     | 选取所有input textarea select button元素 |
| :text      | 选取所有单行文本框                       |
| :password  | 选取所有密码框                           |
| :radio     | 选取所有单选框                           |
| :checkbox  | 选取所有多选框                           |
| :submit    | 选取所有的提交按钮                       |
| :image     | 选取所有的图像按钮                       |
| :reset     | 选取所有的重置按钮                       |
| :button    | 选取所有的按钮                           |
| :file      | 选取所有的上传域                         |
| :hidden    | 选取所有的不可见元素                     |

-   **特定位置选择器**

    -   :first

    -   :last

    -   :eq(index)

-   **指定范围选择器**

    -   :even

    -   :odd

    -   :gt(index)

    -   :lt(index)

-   **排除选择器**

    -   :not 非

**第三节 选择器优化**

-   使用合适的选择器表达式可以提高性能、增强语义并简化逻辑。常用的选择器中，ID选择器速度最快，其次是类型选择器。

    -   多用ID选择器

    -   少直接使用class选择器

    -   多用父子关系，少用嵌套关系

    -   缓存jQuery对象

-   **使用过滤器**

    -   jQuery提供了2种选择文档元素的方式：选择器和过滤器

    -   类过虑器：根据元素的类属性来进行过滤操作。

        -   hasClass(className)：判断当前jQuery对象中的某个元素是否包含指定类名，包含返回true，不包含返回false

    -   下标过滤器：精确选出指定下标元素

        -   eq(index)：获取第N个元素。index是整数值，下标从0开始

    -   表达式过滤器

        -   filter(expr)/(fn)：筛选出与指定表达式/函数匹配的元素集合。

        -   功能最强大的表达式过滤器，可接收函数参数，也可以是简单的选择器表达式

    -   映射 map(callback)：将一组元素转换成其他数组

    -   清洗 not(expr)：删除与指定表达式匹配的元素

    -   截取 slice(start,end)：选取一个匹配的子集

-   **查找**

    -   向下查找后代元素

        -   children():取得所有元素的所有子元素集合（子元素）

        -   find():搜索所有与指定表达式匹配的元素(所有后代元素中查找)

    -   查找兄弟元素 siblings()查找当前元素的兄弟

**第四节 代理对象属性和样式操作**

-   **代理对象属性和样式操作**

    -   attr

    -   prop(一般属性值是boolean的值或者不用设置属性值，一般使用)

    -   css(最好不用，一般我用来做测试)

    -   addClass / removeClass

-   操作原生DOM的时候用的方式：一次只能操作一个

    -   操作属性：setAttribute / getAttribute

    -   操作样式：style.xx = value

    -   操作类样式：className=\'\'

    -   获取DOM的子元素children属性

    -   DOM里面添加一个子元素appendChild()

-   操作jQuery代理对象的时候：批量操作DOM对象(全都是通过方法操作)

-   操作属性：attr()、prop()

    -   attr和prop区别：如果属性的值是布尔类型的值 用prop操作 反之attr

-   操作样式：css()

-   操作类样式：addClass() removeClass()

-   操作DOM子元素：children()

-   添加子元素：append()

**第五节 jQuery中DOM操作**

-   DOM是一种与浏览器、平台\|语言无关的接口，使用该接口可以轻松的访问 页面中的所有的标准组件

-   **DOM操作的分类**

    -   **DOM Core**

        -   DOM core并不专属于JavaScript，任何支持DOM的程序都可以使用

        -   JavaScript 中的getElementByID() getElementsByTagName() getAttribute() setAttribute()等方法都是DOM Core的组成部分

    -   **HTML-DOM**

        -   HTML -DOM的出现比DOM-Core还要早，它提供一些更简明的标志来描述HTML元素的属性

        -   比如：使用HTML-DOM来获取某元素的src属性的方法

            -   element.src

-   **CSS-DOM**

    -   针对CSS的操作。在JavaScript中，主要用于获取和设置style对象的各种属性，通过改变style对象的属性，使网页呈现不同的效果

-   **查找节点**

    -   查找属性节点 attr() 可以获取各属性的值

-   **创建节点**

    -   \$(html)：根据传递的标记字符串，创建DOM对象

-   **插入节点**

|                |                                  |
|----------------|----------------------------------|
| **方法**       | **说明**                         |
| append()       | 向每个匹配元素内部追加内容       |
| appendTo()     | 颠倒append()的操作               |
| prepend()      | 向每个匹配元素的内容内部前置内容 |
| prependTo()    | 颠倒prepend()的操作              |
| after()        | 向每个匹配元素之后插入内容       |
| insertAfter()  | 颠倒after()的操作                |
| before()       | 在每个匹配元素之前插入内容       |
| insertBefore() | 颠倒before()的操作               |

-   **删除节点**

    -   jQuery提供了三种删除节点的方法 remove() detach() empty()

    -   **remove()方法**

        -   当某个节点用此方法删除后，该节点所包含的所有后代节点将同时被删除，用remove()方法删除后，还是可以继续使用删除后的引用

    -   **detach()**

        -   和remove()方法一样，也是从DOM中去掉所有匹配的元素，与remove()不同的是，所有绑定的事件、附加的数据等，都会被保留下来

    -   **empty()**

        -   empty()方法并不是删除节点，而是清空节点，它能清空元素中所有后代节点

-   **复制节点**

    -   使用clone()方法来完成

    -   在clone()方法中传递一个参数true，同时复制元素中所绑定的事件

-   **替换节点**

    -   jQuery提供相应的方法 replaceWidth()

-   **样式操作**

    -   获取样式和设置样式 attr()

    -   追加样式 addClass()

    -   移除样式 removeClass()

    -   切换样式

        -   toggle()方法只要是控制行为上的重复切换（如果元素是显示的，则隐藏；如果元素原来是隐藏的，则显示）

        -   toggleClass()方法控制样式上的重复切换（如何类名存在，则删除它，如果类名不存在，则添加它）

    -   判断是否含有某个样式

        -   hasClass()可以用来判断元素是否含有某个class,如有返回true 该方法等价于is()

-   **设置和获取HTML、文本和值**

    -   **html()**

        -   此方法类似JavaScript中innerHTML属性，可以用来读取和设置某个元素中的HTML内容

    -   **text()**方法

        -   此方法类型JavaScript中innerHTML，用来读取和设置某个元素中的文本内容

    -   **val()**方法

        -   此方法类似JavaScript中的value属性，用来设置获取元素的值。无论是文本框、下拉列表还是单选框，都可以返回元素的值，如果元素多选，返回一个包含所有选择的值的数组

-   **遍历节点**

    -   **children()**方法

        -   该方法用来取得匹配元素的子元素集合

        -   childre()方法只考虑子元素而不考虑其他后代元素

    -   **next()**方法

        -   该方法用于取得匹配元素后面紧邻的同辈元素

    -   **prev()**方法

        -   用于匹配元素前面紧邻的同辈元素

    -   **siblings()**方法

        -   用于匹配元素前后所有的同辈元素

    -   **parent()**方法

        -   获得集合中每个 元素的父级元素

    -   **parents()**方法

        -   获得集合中每个元素的祖先元素

CSS DOM操作

-   CSS DOM技术简单的来说就是读取和设置style对象的各种属性

-   用css()方法获取元素的样式属性，可以同时设置多个样式属性

-   **CSS DOM中关于元素定位有几个常用的方法**

    -   **offset()**方法

        -   它的作用是获取元素在当前视窗的相对偏移其中返回的对象包含两个属性，即top和left，他只对可见元素有效

    -   **position()**方法

        -   获取相对于最近的一个position()样式属性设置为relative或者absolute的祖父节点的相对偏移，与offset()一样，他返回的对象也包括两个属性，即top和left

    -   **scrollTop()**方法和**scrollLeft**方法

        -   这两个方法的作用分别是获取元素的滚动条距顶端的距离和距左侧的距离

        -   **一张图总结以上的位置关系(项目中很常用-必须要弄清楚)**

 

**第六节 jQuery动画**

回顾上节

-   操作DOM

    -   a.什么是DOM：Document Object Model缩写，文档对象模型

    -   b.理解页面的树形结构

    -   c.什么是节点：是DOM结构中最小单元，包括元素、属性、文本、文档等。

一、创建节点

-   1.创建元素

    -   语法：document.createElement(name);

var div = document.createElement(\"div\");\
document.body.appendChild(div);

-   \$(html)：根据传递的标记字符串，创建DOM对象

-   2.创建文本

var div = document.createElement(\"div\");\
var txt = document.createTextNode(\"DOM\");\
div.appendChild(txt);\
document.body.appendChild(div);

var \$div = = \$(\"\<div\>DOM\</div\>\");\
\$(body).append(\$div);

-   3.设置属性

    -   语法：e.setAttrbute(name,value)

var div = document.createElement(\"div\");\
var txt = document.createTextNode(\"DOM\");\
div.appendChild(txt);\
document.body.appendChild(div);\
div.setAttribute(\"title\",\"盒子\");

var \$div = = \$(\"\<div title=\'盒子\'\>DOM\</div\>\");\
\$(body).append(\$div);

二、插入内容

-   内部插入

    -   向元素最后面插入节点：

        -   append():向每个匹配的元素内部追加内容

        -   appendTo():把所有匹配的元素追加到指定元素集合中，\$(\"A\").append(\"B\") 等效 \$(\"B\").appendTo(\"A\")

    -   向元素最前面插入节点：

        -   prepend（）：把每个匹配的元素内部前置内容

        -   prependTo（）：把所有匹配的元素前置到另一个指定的元素集合中,\$(\"A\").prepend(\"B\") 等效 \$(\"B\").prependTo(\"A\")

-   外部插入

    -   after():在每个匹配的元素之后插入内容

    -   before()：在每个匹配想元素之前插入内容

    -   insertAfter()：将所有匹配的元素插入到另一个指定的元素集合后面，\$A.insert(\$B) 等效 \$B.insertAfter(\$A);

    -   insertBefore()：将所有匹配的元素插入到另一个指定的元素集合前面 \$A.before(\$B) 等效 \$B.insertBefore(\$A);

三、删除内容

-   移除

    -   remove():从DOM中删除所有匹配元素

-   清空

    -   empty():删除匹配的元素集合中所有子节点内容

四、克隆内容：创建指定节点副本

-   clone()

    -   注意：若clone（true）则是包括克隆元素的属性，事件等

五、替换内容

-   replaceWith():将所有匹配的元素替换成指定的元素

-   replaceAll():用匹配的元素替换掉指定元素

```{=html}
<!-- -->
```
-   注意：两者效果一致，只是语法不同 \$A.replaceAll(\$B) 等效于 \$B.replaceWhith(\$A);

本节新知识

-   JavaScript语言本身不支持动画设计，必须通过改变CSS来实现动画效果

**显隐动画**

-   show():显示 hide():隐藏

    -   原理：hide()通过改变元素的高度宽度和不透明度，直到这三个属性值到0

    -   show()从上到下增加元素的高度，从左到右增加元素宽度，从0到1增加透明度，直至内容完全可见

    -   参数：

        -   show(speed,callback)

            -   speed: 字符串或数字，表示动画将运行多久（slow=0.6/normal=0.4/fast=0.2）

            -   callback: 动画完成时执行的方法

-   显示和隐藏式一对密不可分的动画形式

-   **显隐切换**

    -   toggle():切换元素的可见状态

        -   原理：匹配元素的宽度、高度以及不透明度，同时进行动画，隐藏动画后将display设置为none

        -   参数：

            -   toggle(speed)

            -   toggle(speed,callback)

            -   toggle(boolean)

                -   speed: 字符串或数字，表示动画将运行多久（slow=0.6/normal=0.4/fast=0.2）

                -   easing： 使用哪个缓冲函数来过渡的字符串(linear/swing)

                -   callback： 动画完成时执行的方法

                -   boolean:true为显示 false为隐藏

**滑动**

-   **显隐滑动效果**

    -   slideDown():滑动隐藏

    -   slidUp():滑动显示

    -   参数:

        -   slideDown(speed,callback)

        -   slidUp(speed,callback)

-   **显隐切换滑动**

    -   slideToggle():显隐滑动切换

    -   参数:

        -   slidUp(speed,callback)

**渐变：通过改变不透明度**

-   **淡入淡出**

    -   fadeIn()

    -   fadeOut()

    -   参数：

        -   fadeIn(speed,callback)

        -   fadeOut(speed,callback)

-   **设置淡出透明效果**

    -   fadeTo()⁭：以渐进的方式调整到指定透明度

    -   参数：

        -   fadeTo(speed,opacity,callback)

-   **渐变切换:结合fadeIn和fadeOut**

    -   fadeToggle()

    -   参数:

        -   fadeOut(speed,callback)

-   **自定义动画：animate()**

    -   注意：在使用animate方法之前，为了影响该元素的top left bottom right样式属性，必须先把元素的position样式设置为relative或者absolute

    -   **停止元素的动画**

        -   很多时候需要停止匹配正在进行的动画，需要使用stop()

        -   stop()语法结构：stop(\[clearQueue\],\[gotoEnd\]);

            -   都是可选参数，为布尔值

            -   如果直接使用stop()方法，会立即停止当前正在进行的动画

    -   **判断元素是否处于动画状态**

        -   如果不处于动画状态，则为元素添加新的动画，否则不添加\
            if(!\$(element).is(\":animated\")){ //判断元素是否处于动画状态}

        -   这个方法在animate动画中经常被用到，需要注意

    -   **延迟动画**

        -   在动画执行过程中，如果你想对动画进行延迟操作，那么使用delay()

-   用animate模拟show():

    -   show: 表示由透明到不透明

    -   toggle: 切换

    -   hide:表示由显示到隐藏

-   **动画方法总结**

|                        |                                                                                                                                           |
|--------------|----------------------------------------------------------|
| **方法名**             | **说明**                                                                                                                                  |
| hide()和show()         | 同时修改多个样式属性即高度和宽度和不透明度                                                                                                |
| fadeIn()和fadeOut()    | 只改变不透明度                                                                                                                            |
| slideUp()和slideDown() | 只改变高度                                                                                                                                |
| fadeTo()               | 只改变不透明度                                                                                                                            |
| toggle()               | 用来代替show()和hide()方法，所以会同时修改多个属性即高度、宽度和不透明度                                                                  |
| slideToggle()          | 用来代替slideUp和slideDown()方法，所以只能改变高度                                                                                        |
| fadeToggle()           | 用来代替fadeIn()和fadeOut方法，只能改变不透明度                                                                                           |
| animate()              | 属于自定义动画，以上各种动画方法都是调用了animate方法。此外，用animate方法还能自定义其他的样式属性，例如：left marginLeft \`scrollTop\`等 |

**第七节 jQuery中的事件**

-   **事件对象的属性**

    -   event.type：获取事件的类型

    -   event.target:获取到触发事件的元素

    -   event.preventDefault方法 阻止默认事件行为

    -   event.stopPropagation()阻止事件的冒泡

    -   keyCode：只针对于keypress事件，获取键盘键数字 按下回车，13

    -   event.pageX / event.pageY 获取到光标相对于页面的x坐标和y坐标

        -   如果没有jQuery，在IE浏览器中用event.x / event.y;在Firefox浏览器中用event.pageX / event.pageY。如果页面上有滚动条还要加上滚动条的宽度和高度

    -   event.clientX：光标对于浏览器窗口的水平坐标 浏览器

    -   event.clientY：光标对于浏览器窗口的垂直坐标

    -   event.screenX：光标对于电脑屏幕的水平坐标 电脑屏幕

    -   event.screenY：光标对于电脑屏幕的水平坐标

    -   event.which 该方法的作用是在鼠标单击事件中获取到鼠标的左、中、右键，在键盘事件中的按键 1代表左键 2代表中键 3代表右键

-   **事件冒泡**

    -   什么是冒泡

        -   在页面上可以有多个事件，也可以多个元素影响同一个元素

        -   从里到外

        -   嵌套关系

        -   相同事件

        -   其中的某一父类没有相同事件时,继续向上查找

    -   **停止事件冒泡**

        -   停止事件冒泡可以阻止事件中其他对象的事件处理函数被执行

        -   在jQuery中提供了**stopPropagation()**方法

    -   **阻止默认行为**

        -   网页中元素有自己的默认行为，例如：单击超链接后会跳转、单击提交后表单会提交，有时需要阻止元素的默认行为

        -   在jQuery中提供了 preventDefault()方法来阻止元素的默认行为

    -   **事件捕获**

        -   事件捕获和冒泡是相反的过程，事件捕获是从最顶端往下开始触发

        -   并非所有的浏览器都支持事件捕获，并且这个缺陷无法通过JavaScript来修复。jQuery不支持事件捕获，如需要用事件捕获，要用原生的JavaScript

-   **bind();绑定**

    -   为匹配元素绑定处理方法

    -   需要给一个元素添加多个事件 ，事件执行一样时候

    -   one()：只执行一次

-   **绑定特定事件类型方法**：\
    \|分类\|方法名称\|说明\|

|          |                                           |                                              |
|---------|-----------------------------|----------------------------------|
| 页面载入 | ready(fn)                                 | 当DOM载入就绪可以绑定一个要执行的函数        |
| 事件绑定 | blind(type,\[data\],fn)                   | 为每个匹配元素的特定事件绑定一个事件处理函数 |
| 事件绑定 | unblind()                                 | 解除绑定                                     |
| 事件绑定 | on(events,\[,selector\[,\]data\],handler) | 在选择元素上绑定一个或者多个事件处理函数     |
| 事件绑定 | off()                                     | 移除on绑定的事件                             |
| 事件绑定 | delegate(selector,eventType,handler)      | 为所有选择匹配元素附加一个或多个事件处理函数 |
| 事件绑定 | undelegate()                              | 移除绑定                                     |
| 事件动态 | live(type,fn)                             | 对动态生成的元素进行事件绑定                 |
| 事件动态 | die(type,fn)                              | 移除live()绑定的事件                         |
| 交互事件 | hover()                                   | 鼠标移入移出                                 |
| 交互事件 | toggle(fn1,fn2,\[fn3\],\[fn4\])           | 每单击后依次调用函数                         |
| 交互事件 | blur(fn)                                  | 触发每一个匹配元素的blur事件                 |
| 交互事件 | change()                                  | 触发每一个匹配元素的change事件               |
| 交互事件 | click()                                   | 触发每一个匹配元素的click事件                |
| 交互事件 | focus()                                   | 触发每一个匹配元素的focus事件                |
| 交互事件 | submit()                                  | 触发每一个匹配元素的submit事件               |
| 键盘事件 | keydown()                                 | 触发每一个匹配元素的keydown事件              |
| 键盘事件 | keypress()                                | 触发每一个匹配元素的keypress事件             |
| 键盘事件 | keyup()                                   | 触发每一个匹配元素的keyup事件                |
| 鼠标事件 | mousedown(fn)                             | 绑定一个处理函数                             |
| 鼠标事件 | mouseenter(fn)                            | 绑定一个处理函数                             |
| 键盘事件 | mouseleave(fn)                            | 绑定一个处理函数                             |
| 键盘事件 | mouseout(fn)                              | 绑定一个处理函数                             |
| 键盘事件 | mouseover(fn)                             | 绑定一个处理函数                             |
| 窗口操作 | resize(fn)                                | 绑定一个处理函数                             |
| 窗口操作 | scroll(fn)                                | 绑定一个处理函数                             |

**第八节 jQuery与Ajax**

-   **Ajax**简介 :

    -   Asynchronous Javascript And XML （异步的\
        JavaScript和XML）

    -   它并不是一种单一的技术，而是有机利用一系列交互式网页应用相关的技术所形成的结合体

-   **Ajax优势与不足**

    -   **Ajax优势**

        -   优秀的用户体验

            -   这是Ajax下最大的有点，能在不刷新整个页面前提下更新数据

        -   提高web程序的性能

            -   与传统模式相比，Ajax模式在性能上最大的区别在于传输数据的方式，在传统模式中，数据的提交时通过表单来实现的。Ajax模式只是通过XMLHttpRequest对象向服务器提交希望提交的数据，即按需发送

        -   减轻服务器和带宽的负担

            -   Ajax的工作原理相当于在用户和服务器之间加了一个中间层，似用户操作与服务器响应异步化。它在客户端创建Ajax引擎，把传统方式下的一些服务器负担的工作转移到客户端，便于客户端资源来处理，减轻服务器和带宽的负担

    -   **Ajax的不足**

        -   浏览器对XMLHttpRequest对象的支持度不足

        -   破坏浏览器前进、后退按钮的正常功能

        -   对搜索引擎的支持的不足

        -   开发和调试工具的缺乏

创建一个Ajax请求

-   Ajax的核心是XMLHttpRequest对象，它是Ajax实现的关键，发送异步请求、接受响应以及执行回调都是通过它来完成

-   **创建ajax对象 var xhr = new XMLHttpRequest();**

-   **准备发送请求**

    -   **get / post**

        -   **get**

            -   传递的数据放在URL后面

            -   中文编码 encodeURI( \'\' );

            -   缓存 在数据后面加上随机数或者日期对象或者......

        -   **post**

            -   传递的数据放在send()里面，并且一定要规定数据格式

            -   没有缓存问题

        -   form表单中:

            -   action:

                -   method: (默认是 get)

                -   get: 会在url里面以 name=value , 两个数据之间用 & 连接

        -   post:

    -   enctype: \"application/x-www-form-urlencoded\"

-   url

-   是否异步

    -   同步(false)：阻塞

    -   异步(true)：非阻塞

-   **正式发送请求**

-   **ajax请求处理过程**

xhr.onreadystatechange = function(){\
if (xhr.readyState == 4)\
{\
alert( xhr.responseText );\
}\
};

-   onreadystatechange ：当处理过程发生变化的时候执行下面的函数

-   readyState ：ajax处理过程

    -   0：请求未初始化（还没有调用 open()）。

    -   1：请求已经建立，但是还没有发送（还没有调用 send()）。

    -   2：请求已发送，正在处理中（通常现在可以从响应中获取内容头）。

    -   3：请求在处理中；通常响应中已有部分数据可用了，但是服务器还没有完成响应的生成。

    -   4：响应已完成；您可以获取并使用服务器的响应了。

-   responseText ：请求服务器返回的数据存在该属性里面

-   status : http状态码

 

-   案例：ajax封装案例

//ajax请求后台数据\
var btn = document.getElementsByTagName(\"input\")\[0\];\
btn.onclick = function(){\
\
ajax({//json格式\
type:\"post\",\
url:\"post.php\",\
data:\"username=poetries&pwd=123456\",\
asyn:true,\
success:function(data){\
document.write(data);\
}\
});\
}\
//封装ajax\
function ajax(aJson){\
var ajx = null;\
var type = aJson.type \|\| \"get\";\
var asyn = aJson.asyn \|\| true;\
var url = aJson.url; // url 接收 传输位置\
var success = aJson.success;// success 接收 传输完成后的回调函数\
var data = aJson.data \|\| \'\';// data 接收需要附带传输的数据\
\
if(window.XMLHttpRequest){//兼容处理\
ajx = new XMLHttpRequest();//一般浏览器\
}else\
{\
ajx = new ActiveXObject(\"Microsoft.XMLHTTP\");//IE6+\
}\
if (type == \"get\" && data)\
{\
url +=\"/?\"+data+\"&\"+Math.random();\
}\
\
//初始化ajax请求\
ajx.open( type , url , asyn );\
//规定传输数据的格式\
ajx.setRequestHeader(\'content-type\',\'application/x-www-form-urlencoded\');\
//发送ajax请求（包括post数据的传输）\
type == \"get\" ?ajx.send():ajx.send(aJson.data);\
\
//处理请求\
ajx.onreadystatechange = function(aJson){\
\
if(ajx.readState == 4){\
\
if (ajx.status == 200 && ajx.status\<300)//200是HTTP 请求成功的状态码\
{\
//请求成功处理数据\
success && success(ajx.responseText);\
}else{\
alert(\"请求出错\"+ajx.status);\
\
}\
}\
\
};

jQuery中的Ajax \[补充部分\--来自锋利的jQuery\]

jquery对Ajax操作进行了封装，在jquery中的\$.ajax()方法属于最底层的方法，第2层是load()、\$.get()、\$.post();第3层是\$.getScript()、\$.getJSON()，第2层使用频率很高

load()方法

-   load()方法是jquery中最简单和常用的ajax方法，能载入远程HTML代码并插入DOM中 结构为：load(url,\[data\],\[callback\])

    -   使用url参数指定选择符可以加载页面内的某些元素 load方法中url语法：url selector 注意：url和选择器之间有一个空格

-   传递方式

    -   load()方法的传递方式根据参数data来自动指定，如果没有参数传递，则采用GET方式传递，反之，采用POST

-   回调参数

    -   必须在加载完成后才执行的操作，该函数有三个参数 分别代表请求返回的内容、请求状态、XMLHttpRequest对象

    -   只要请求完成，回调函数就会被触发

\$(\"#testTest\").load(\"test.html\",function(responseText,textStatus,XMLHttpRequest){\
//respnoseText 请求返回的内容\
//textStatus 请求状态 ：sucess、error、notmodified、timeout\
//XMLHttpRequest\
})

-   **load方法参数**

|                |          |                                              |
|----------------|----------|----------------------------------------------|
| **参数名称**   | **类型** | **说明**                                     |
| url            | String   | 请求HTML页面的URL地址                        |
| data(可选)     | Object   | 发送至服务器的key / value数据                |
| callback(可选) | Function | 请求完成时的回调函数，无论是请求成功还是失败 |

\$.get()和\$.post()方法

load()方法通常用来从web服务器上获取静态的数据文件。在项目中需要传递一些参数给服务器中的页面，那么可以使用\$.get()和\$.post()或\$.ajax()方法

-   注意：\$.get()和\$.post()方法是jquery中的全局函数

-   **\$.get()方法**

    -   \$.get()方法使用GET方式来进行异步请求

    -   结构为：\$.get(url,\[data\],callback,type)

        -   如果服务器返回的内容格式是xml文档，需要在服务器端设置Content-Type类型 代码如下：header(\"Content-Type:text/xml:charset=utf-8\") //php

-   **\$.get()方法参数解析**

|                |          |                                                                     |
|-------------|----------|--------------------------------------------------|
| **参数**       | **类型** | **说明**                                                            |
| url            | String   | 请求HTML页的地址                                                    |
| data(可选)     | Object   | 发送至服务器的key/ value 数据会作为QueryString附加到请求URL中       |
| callback(可选) | Function | 载入成功的回调函数（只有当Response的返回状态是success才调用该方法） |
| type(可选)     | String   | 服务器返回内容的格式，包括xml、html、script、json、text和_default   |

-   **\$.post()方法**

    -   它与\$.get()方法的结构和使用方式相同，有如下区别

        -   GET请求会将参数跟张乃URL后进行传递，而POST请求则是作为Http消息的实体内容发送给web服务器，在ajax请求中，这种区别对用户不可见

        -   GET方式对传输数据有大小限制（通常不能大于2KB），而使用POST方式传递的数据量要比GET方式大得多（理论不受限制）

        -   GET方式请求的数据会被浏览器缓存起来，因此其他人可以从浏览器的历史纪录中读取这些数据，如：账号、密码。在某种情况下，GET方式会带来严重的安全问题，而POST相对来说可以避免这些问题

        -   GET和POST方式传递的数据在服务端的获取也不相同。在PHP中，GET方式用\$\_GET\[\]获取；POST方式用\$\_POST\[\]获取;两种方式都可用\$\_REQUEST\[\]来获取

-   **总结**

    -   使用load()、\$.get()和\$.post()方法完成了一些常规的Ajax程序，如果还需要复杂的Ajax程序，就需要用到\$.ajax()方式

\$.ajax()方法

-   \$.ajax()方法是jquery最底层的Ajax实现，它的结构为\$.ajax(options)

-   该方法只有一个参数，但在这个对象里包含了\$.ajax()方式所需要的请求设置以及回调函等信息，参数以key / value存在，所有参数都是可选的

-   **\$.ajax()方式常用参数解析**

<table>
<colgroup>
<col style="width: 11%" />
<col style="width: 10%" />
<col style="width: 77%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>参数</strong></td>
<td><strong>类型</strong></td>
<td><strong>说明</strong></td>
</tr>
<tr class="even">
<td>url</td>
<td>String</td>
<td>(默认为当前页地址)发送请求的地址</td>
</tr>
<tr class="odd">
<td>type</td>
<td>String</td>
<td>请求方式（POST或GET）默认为GET</td>
</tr>
<tr class="even">
<td>timeout</td>
<td>Number</td>
<td>设置请求超时时间（毫秒）</td>
</tr>
<tr class="odd">
<td>dataType</td>
<td>String</td>
<td><p>预期服务器返回的类型。可用的类型如下</p>
<p> </p>
<p><strong>xml</strong>:返回XML文档，可用jquery处理</p>
<p><strong>html</strong>:返回纯文本的HTML信息，包含的script标签也会在插入DOM时执行</p>
<p><strong>script</strong>：返回纯文本的javascript代码。不会自动缓存结果，除非设置cache参数。注意：在远程请求时，所有的POST请求都将转为GET请求</p>
<p><strong>json</strong>:返回JSON数据</p>
<p><strong>jsonp</strong>:JSONP格式，使用jsonp形式调用函数时，例如：myurl?call back=?,jquery将自动替换后一个？为正确的函数名，以执行回调函数</p>
<p><strong>text</strong>:返回纯文本字符串</p></td>
</tr>
<tr class="even">
<td>beforeSend</td>
<td>Function</td>
<td><p>发送请求前可以修改XMLHttpRequest对象的函数，例如添加自定义HTTP头。在beforeSend中如果返回false可以取消本次Ajax请求。XMLHttpRequest对象是唯一的参数</p>
<p>function(XMLHttpRequest){</p>
<p>         this;//调用本次Ajax请求时传递的options参数</p>
<p>}</p></td>
</tr>
<tr class="odd">
<td>complete</td>
<td>Function</td>
<td><p>请求完成后的回调函数（请求成功或失败时都调用）</p>
<p>参数：XMLHttpRequest对象和一个描述成功请求类型的字符串</p>
<p>function(XMLHttpRequest,textStatus){</p>
<p>         this;//调用本次Ajax请求时传递的options参数</p>
<p>}</p></td>
</tr>
<tr class="even">
<td>success</td>
<td>Function</td>
<td><p>请求成功后调用的回调函数，有两个参数</p>
<p>(1)由服务器返回，并根据dataTyppe参数进行处理后的数据</p>
<p>(2)描述状态的字符串</p>
<p>function(data,textStatus){</p>
<p>         //data可能是xmlDoc、`jsonObj、html、text等&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;this;//调用本次Ajax请求时传递的options`参数</p>
<p>}</p></td>
</tr>
<tr class="odd">
<td>error</td>
<td>Function</td>
<td>请求失败时被调用的函数</td>
</tr>
<tr class="even">
<td>global</td>
<td>Boolean</td>
<td>默认为true。表示是否触发全局Ajax事件，设置为false将不会触发。AjaxStart或AjaxStop可用于控制各种Ajax事件</td>
</tr>
</tbody>
</table>

**第九节 插件**

-   **什么是插件**

    -   插件(Plugin)也称为jQuery的扩展。以jQuery核心代码为基础编写的符合一定规范的应用程序。通过js文件的方式引用。

-   **插件分为哪几类**

    -   UI类、表单及验证类、输入类、特效类、Ajax类、滑动类、图形图像类、导航类、综合工具类、动画类等等

-   **引入插件的步骤**

    -   引入jquery.js文件，而且在所以插件之前引入

    -   引入插件

    -   引入插件相关文件，比如皮肤、中文包

-   **如何自定义插件**：

    -   插件形式分为3类：

        -   封装对象方法插件

        -   封装全局函数插件

        -   选择器插件(类似于.find())

-   **自定义插件的规范**（解决各种插件的冲突和错误，增加成功率）

    -   命名：jquery.插件名.js

    -   所有的新方法附加在jquery.fn对象上面，所有新功能附加在jquery上

    -   所有的方法或插件必须用分号结尾，避免出问题

    -   插件必须返回jQuery对象，便于链式连缀

    -   避免插件内部使用\$，如果要使用，请传递jQuery(\$并不是总等于jQuery，另外其他js框架也可能使用\$)

    -   插件中的this应该指向jQuery对象

    -   使用this.each()迭代元素

-   **自定义插件案例**

    -   为了方便用户创建插件，jQuery提供了 jQuery.extend() 和 jQuery.fn.extend()

    -   jQuery.extend()：创建工具函数或者是选择器

    -   jQuery.fn.extend()：创建jQuery对象命令 （fn相当于prototype的别名）

-   **jQuery官方提供的插件开发模板**

;(function(\$){\
\$.fn.plugin=function(options){\
var defaults = {\
//各种参数 各种属性\
}\
var options = \$.extend(defaults,options);

this.each(function(){\
//实现功能的代码\
});

return this;\
}\
})(jQuery);

**自定义jQuery函数**：

(function(\$){\
\$.extend({\
test: function(){\
alert(\"hello plugin\");\
}\
})\
})(jQuery);

**自定义jQuery命令**：

-   形式1：

(function(\$){\
\$.fn.extend({\
say : function(){\
alert(\"hello plugin\");\
}\
})\
})(jQuery);

-   形式2：

(function(\$){\
\$.fn.say = function(){\
alert(\"hello plugin\");\
};\
\
})(jQuery);

**附录一 jQuery各个版本新增的一些常用的方法**

-   jQuery1.3新增常用的方法

|            |                                                              |
|------------|------------------------------------------------------------|
| **方法**   | **说明**                                                     |
| .closest() | 从元素本身开始，逐级向上级元素匹配，并返回最先匹配的祖先元素 |
| die()      | 从元素中删除先前用live()方法绑定的所有的事件                 |
| live()     | 附加一个事件处理器到符合目前选择器的所有元素匹配             |

-   jQuery1.4新增常用的方法

|               |                                                                                                                                                                     |
|----------|--------------------------------------------------------------|
| **方法**      | **说明**                                                                                                                                                            |
| .first()      | 获取集合中第一个元素                                                                                                                                                |
| last()        | 获取集合中最后一个元素                                                                                                                                              |
| has(selector) | 保留包含特定后代的元素，去掉那些不含有指定后代的元素                                                                                                                |
| detach()      | 从DOM中去掉所有匹配的元素。detach()和remov()一样，除了detach()保存了所有jquery数据和被移走的元素相关联。当需要移走一个元素，不久又将该元素插入DOM时，这种方法很有用 |
| delegate()    | 为所有选择器匹配的元素附加一个处理一个或多个事件                                                                                                                    |
| undelegate()  | 为所有选择器匹配的元素删除一个处理一个或多个事件                                                                                                                    |

-   jQuery1.6新增常用的方法

|                              |                                          |
|------------------------------|------------------------------------------|
| **方法**                     | **说明**                                 |
| prop(proptyName)             | 获取在匹配元素集合中的第一个元素的属性值 |
| removeProp(proptyName,value) | 为匹配的元素删除设置的属性               |
| :focus                       | 选择当前获取焦点的元素                   |

**附录二 jQuery性能优化**

-   **性能优化**

    -   使用最新版的jQuery类库

    -   **使用合适的选择器**

        -   \$(#id)

            -   使用id来定位DOM元素是最佳的方式，为了提高性能，建议从最近的ID元素开始往下搜索

        -   \$(\"p\") , \$(\"div\") , \$(\"input\")

            -   标签选择器性能也不错，它是性能优化的第二选择。因为jQuery将直接调用本地方法document.getElementsByTagName()来定位DOM元素

        -   \$(\".class\")

            -   建议有选择性的使用

        -   \$(\"\[attribute=value\]\")

            -   对这个利用属性定位DOM元素，本地JavaScript并没有直接实现。这种方式性能并不是很理想。建议避免使用。

        -   \$(\":hidden\")

            -   和上面利用属性定位DOM方式类似，建议尽量不要使用

        -   **注意的地方**

            -   尽量使用ID选择器

            -   尽量给选择器指定上下文

    -   **缓存对象**

        -   如果你需要在其他函数中使用jQuery对象，你可以把他们缓存在全局环境中

    -   **数组方式使用jQuery对象**

        -   使用jQuery选择器获取的结果是一个jQuery对象。在性能方面，建议使用for或while循环来处理，而不是\$.each()

    -   **事件代理**

        -   每一个JavaScript事件（如：click、mouseover）都会冒泡到父级节点。当我们需要给多个元素调用同个函数时这点很有用。比如，我们要为一个表单绑定这样的行为：点击td后，把背景颜色设置为红色

            -   \$(\"#myTable td\").click(function(){\$(this).css(\"background\",\"red\");});

            -   假设有100个td元素，在使用以上的方式时，绑定了100个事件，将带来性能影响

            -   代替这种多元素的事件监听方法是，你只需向他们的父节点绑定一次事件，然后通过event.target获取到点击的当前元素

                -   \$(\"#myTable td\").click(function({\$(e.target).css(\"background\",\"red\")});

                -   e.target捕捉到触发的目标

            -   在jQuery1.7中提供了一个新的方法on()，来帮助你将整个事件监听封装到一个便利的方法中

                -   \$(\"#myTable td\").on(\"click\",\'td\',function(){\$(this).css(\"background\",\"red\");});

    -   **将你的代码转化成jQuery插件**

        -   它能够使你的代码有更好的重用性，并且能够有效的帮助你组织代码

-   **使用join()方法来拼接字符串**

    -   也许你之前使用+来拼接字符串，现在可以改了。它确实有助于性能优化，尤其是长字符串处理的时候

-   **合理使用HTML5和Data属性**

    -   HTML5的data属性可以帮助我们插入数据，特别是后端的数据交换。jQuery的Data()方法有效利用HTML5的属性

        -   例如：\<div id=\"dl\" data-role=\"page\" data-list-value=\"43\" data-options=\'{\"name:\"\"John\"}\'\>

        -   为了读取数据，你需要使用如下代码

            -   \$(\"#dl\').data(\"role\';//page)

            -   \$(\"#dl\').data(\"lastValue\';//43)

            -   \$(\"#dl\').data(\"options\';//john)

    -   **尽量使用原生的JavaScript方法**

    -   **压缩JavaScript代码**

        -   一方面使用Gzip；另一方面去除JavaScript文件里面的注释、空白

附录三 常用的jQuery代码片段

**附录四 常见CND加速服务**

-   Bootstrap中文网开源项目免费 CDN 服务

-   百度静态资源公共库

-   360网站卫士常用前端公共库CDN服务\--已停止服务

-   开放静态文件 CDN

-   微软CDN服务

-   阿里云

-   百度开放云平台

-   jQuery CDN

-   jQuery cdn加速

-   新浪CDN

**附录五 jQuery的一些资源**

-   速查手册

    -   jQuery API 中文文档\--css88

    -   jQuery-overapi

    -   在线桌面版API

    -   更多详情\-\--一份实用的API参考手册集合

-   jQuery插件

    -   基础常用

        -   滚动固定在某个位置

        -   jQuery图片滚动插件全能版

        -   jQuery Wookmark Load 瀑布流布局

        -   jQuery Jcrop 图像裁剪

        -   jQuery kxbdMarquee 无缝滚动

        -   jQuery lightBox 灯箱效果

        -   Lazy Load Plugin for jQuery

    -   更多插件-动效库整理

        -   插件动效库

        -   常用组件

**扩展阅读**

-   jQuery源码分析系列

参考

-   锋利的jQuery

-   本文md源文件

分类: [jquery](https://www.cnblogs.com/xuxiuyu/category/898902.html)
