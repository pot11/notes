[LinkedList底层是链表，为什么会有索引？这个索引和数组的索引有什么区别？](http://bbs.itheima.com/thread-116176-1-1.html)

2020年4月20日

8:50

 

|                                                                                                                       |
|------------------------------------------------------------------------|
| 1.纠结好久了，比如LinkedList里面的方法get(int index),功能是返回列表中指定位置的元素，这个位置指的是什么，谢谢大家了。 |

 

 

答：

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p> </p>
<p>LinkList有索引，有序可重复。跟数组一样有头有尾，不过它底层的数据结构是链表，链表只能一环一环的查询，所以查询很慢。</p>
<p>        你依次存进去一些元素，LinkList就把你存的数据按顺序形成一条链表（这个顺序是由你指定的），get(int index)：就是从你所指定的那个顺序的第一个元素开始数，你要取出第n个元素，就get（n-1）。这个index跟数组一样，从0开始</p>
<p> </p>
<p> </p>
<p> </p>
<p>2.在LinkedList中为什么迭代比索引访问List更快</p>
<p>在linked list中，所有的元素都指向下一个元素</p>
<p> </p>
<p><img src="003_LinkedList底层是链表，为什么会有索引？这个索引和数组的索引有什么区别？_000.png" /></p>
<p> </p>
<p>如果要访问item3,你要从head开始直到item3，因为你不能直接指向item3</p>
<p> </p>
<p>所以，如果我们打印所有元素的值，如果我们这样写</p>
<p><strong>Java代码  </strong></p>
<p><a href="javascript:void()"><img src="003_LinkedList底层是链表，为什么会有索引？这个索引和数组的索引有什么区别？_001.png" /></a></p>
<ol class="incremental" type="1">
<li><p><strong>for</strong>(<strong>int</strong> i = 0; i &lt;= 3; i++) {  </p></li>
</ol>
<ol class="incremental" type="1">
<li><p>   System.out.println(i);  </p></li>
<li><p>}  </p></li>
</ol>
<p>会发生什么呢</p>
<p> </p>
<p><img src="003_LinkedList底层是链表，为什么会有索引？这个索引和数组的索引有什么区别？_002.png" /></p>
<p> </p>
<p>这样性能就非常差，因为每次都要重头开始</p>
<p> </p>
<p>如果使用</p>
<p><strong>Java代码  </strong></p>
<p><a href="javascript:void()"><img src="003_LinkedList底层是链表，为什么会有索引？这个索引和数组的索引有什么区别？_001.png" /></a></p>
<ol class="incremental" type="1">
<li><p><strong>for</strong>(String s:list){  </p></li>
</ol>
<ol class="incremental" type="1">
<li><p>   System.out.println(s);  </p></li>
<li><p>}  </p></li>
</ol>
<p> </p>
<p><img src="003_LinkedList底层是链表，为什么会有索引？这个索引和数组的索引有什么区别？_003.png" /></p>
<p> </p>
<p>这样性能就提升了很多</p>
<p> </p>
<p>如果换做<strong>ArrayList</strong>就不会出现这种问题，因为它是以array实现的</p>
<p> </p></td>
</tr>
</tbody>
</table>
