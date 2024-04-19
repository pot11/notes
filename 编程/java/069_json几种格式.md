json几种格式

2019年9月30日

15:42

 

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>&lt;!DOCTYPE html&gt;</p>
<p>&lt;html lang="en"&gt;</p>
<p>&lt;head&gt;</p>
<p>&lt;meta charset="UTF-8"&gt;</p>
<p>&lt;title&gt;json&lt;/title&gt;</p>
<p>&lt;script&gt;</p>
<p>//对象形式</p>
<p>var json1="{'username':'xiaoming','password':'123','age':18}";</p>
<p>var json1obj=eval("("+json1+")");</p>
<p>// alert(json1obj.username);</p>
<p> </p>
<p>//数组形式</p>
<p>var json2="['抽烟','喝酒','烫头']";</p>
<p>var json2obj=eval("("+json2+")");</p>
<p>// alert(json2obj[0]);</p>
<p> </p>
<p>//js中提供了如下特有 书写方式</p>
<p>var jsonobj3={</p>
<p>username:'小亮',</p>
<p>password:'789',</p>
<p>age:30</p>
<p>}</p>
<p>// alert(jsonobj3.username);</p>
<p>var jsonobj4=['抽烟','喝酒','烫头'];</p>
<p>// alert(jsonobj4[1]);</p>
<p> </p>
<p> </p>
<p>//对象套数组</p>
<p>var jsonobj5={</p>
<p>username:'小亮',</p>
<p>password:'789',</p>
<p>age:30,</p>
<p>habbies:['抽烟','喝酒','烫头']</p>
<p>}</p>
<p>// alert(jsonobj5.habbies[1]);</p>
<p> </p>
<p><mark>//数组套对象</mark></p>
<p><strong>var jsonobj6=[</strong></p>
<p><strong>{</strong></p>
<p><strong>username:'小亮',</strong></p>
<p><strong>password:'789',</strong></p>
<p><strong>age:30,</strong></p>
<p><strong>habbies:['抽烟','喝酒','烫头']</strong></p>
<p><strong>},</strong></p>
<p><strong>{</strong></p>
<p><strong>username:'小红',</strong></p>
<p><strong>password:'789',</strong></p>
<p><strong>age:30,</strong></p>
<p><strong>habbies:['抽烟','喝酒','看电影']</strong></p>
<p><strong>},</strong></p>
<p><strong>]</strong></p>
<p>alert(jsonobj6[1].habbies[2]);</p>
<p> </p>
<p>&lt;/script&gt;</p>
<p>&lt;/head&gt;</p>
<p>&lt;body&gt;</p>
<p> </p>
<p>&lt;/body&gt;</p>
<p>&lt;/html&gt;</p></td>
</tr>
</tbody>
</table>
