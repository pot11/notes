[Python学习之set集合方法总结](https://www.cnblogs.com/Ronaldo2011/p/9417612.html)

2018年11月11日

10:57

> **一、定义**
>
> set是一个无序且不重复的元素集合。
>
> 集合对象是一组无序排列的可哈希的值，集合成员可以做字典中的键。集合支持用in和not in操作符检查成员，由len()内建函数得到集合的基数(大小)， 用 for 循环迭代集合的成员。但是因为集合本身是无序的，不可以为集合创建索引或执行切片(slice)操作，也没有键(keys)可用来获取集合中元素的值。
>
> set和dict一样，只是没有value，相当于dict的key集合，由于dict的key是不重复的，且key是不可变对象因此set也有如下特性：

1.  不重复

2.  元素为不可变对象

> **二、创建**
>
> s = set()\
> s = {11,22,33,44} #注意在创建空集合的时候只能使用s=set()，因为s={}创建的是空字典
>
> a=set(\'boy\')\
> b=set(\[\'y\', \'b\', \'o\',\'o\'\])\
> c=set({\"k1\":\'v1\',\'k2\':\'v2\'})\
> d={\'k1\',\'k2\',\'k2\'}\
> e={(\'k1\', \'k2\',\'k2\')}\
> print(a,type(a))\
> print(b,type(b))\
> print(c,type(c))\
> print(d,type(d))\
> print(e,type(e))
>
> OUTPUT:\
> {\'o\', \'b\', \'y\'} \<class \'set\'\>\
> {\'o\', \'b\', \'y\'} \<class \'set\'\>\
> {\'k1\', \'k2\'} \<class \'set\'\>\
> {\'k1\', \'k2\'} \<class \'set\'\>\
> {(\'k1\', \'k2\', \'k2\')} \<class \'set\'\>
>
> **三、基本操作**
>
> **比较**
>
> se = {11, 22, 33}\
> be = {22, 55}\
> temp1 = se.difference(be) #找到se中存在，be中不存在的集合，返回新值\
> print(temp1) #{33, 11}\
> print(se) #{33, 11, 22}
>
> temp2 = se.difference_update(be) #找到se中存在，be中不存在的集合，覆盖掉se\
> print(temp2) #None\
> print(se) #{33, 11},
>
> **删除**
>
> discard()、remove()、pop()
>
> se = {11, 22, 33}\
> se.discard(11)\
> se.discard(44) \# 移除不存的元素不会报错\
> print(se)
>
> se = {11, 22, 33}\
> se.remove(11)\
> se.remove(44) \# 移除不存的元素会报错\
> print(se)
>
> se = {11, 22, 33} \# 移除末尾元素并把移除的元素赋给新值\
> temp = se.pop()\
> print(temp) \# 33\
> print(se) \# {11, 22}
>
> **取交集**
>
> se = {11, 22, 33}\
> be = {22, 55}
>
> temp1 = se.intersection(be) #取交集，赋给新值\
> print(temp1) \# 22\
> print(se) \# {11, 22, 33}
>
> temp2 = se.intersection_update(be) #取交集并更新自己\
> print(temp2) \# None\
> print(se) \# 22
>
> **判断**
>
> se = {11, 22, 33}\
> be = {22}
>
> print(se.isdisjoint(be)) #False，判断是否不存在交集（有交集False，无交集True）\
> print(se.issubset(be)) #False，判断se是否是be的子集合\
> print(se.issuperset(be)) #True，判断se是否是be的父集合
>
> **合并**
>
> se = {11, 22, 33}\
> be = {22}
>
> temp1 = se.symmetric_difference(be) \# 合并不同项，并赋新值\
> print(temp1) #{33, 11}\
> print(se) #{33, 11, 22}
>
> temp2 = se.symmetric_difference_update(be) \# 合并不同项，并更新自己\
> print(temp2) #None\
> print(se) #{33, 11}
>
> **取并集**
>
> se = {11, 22, 33}\
> be = {22,44,55}
>
> temp=se.union(be) #取并集，并赋新值\
> print(se) #{33, 11, 22}\
> print(temp) #{33, 22, 55, 11, 44}
>
> **更新**
>
> se = {11, 22, 33}\
> be = {22,44,55}
>
> se.update(be) \# 把se和be合并，得出的值覆盖se\
> print(se)\
> se.update(\[66, 77\]) \# 可增加迭代项\
> print(se)
>
> **集合的转换**
>
> se = set(range(4))\
> li = list(se)\
> tu = tuple(se)\
> st = str(se)\
> print(li,type(li))\
> print(tu,type(tu))\
> print(st,type(st))
>
> OUTPUT:\
> \[0, 1, 2, 3\] \<class \'list\'\>\
> (0, 1, 2, 3) \<class \'tuple\'\>\
> {0, 1, 2, 3} \<class \'str\'\>
>
> **四、源码**
>
> class set(object):\
> \"\"\"\
> set() -\> new empty set object\
> set(iterable) -\> new set object\
> \
> Build an unordered collection of unique elements.\
> \"\"\"\
> def add(self, \*args, \*\*kwargs):\
> \"\"\"添加\"\"\"\
> \"\"\"\
> Add an element to a set.\
> \
> This has no effect if the element is already present.\
> \"\"\"\
> pass
>
> def clear(self, \*args, \*\*kwargs):\
> \"\"\"清除\"\"\"\
> \"\"\" Remove all elements from this set. \"\"\"\
> pass
>
> def copy(self, \*args, \*\*kwargs):\
> \"\"\"浅拷贝\"\"\"\
> \"\"\" Return a shallow copy of a set. \"\"\"\
> pass
>
> def difference(self, \*args, \*\*kwargs):\
> \"\"\"比较\"\"\"\
> \"\"\"\
> Return the difference of two or more sets as a new set.\
> \
> (i.e. all elements that are in this set but not the others.)\
> \"\"\"\
> pass
>
> def difference_update(self, \*args, \*\*kwargs):\
> \"\"\" Remove all elements of another set from this set. \"\"\"\
> pass
>
> def discard(self, \*args, \*\*kwargs):\
> \"\"\"删除\"\"\"\
> \"\"\"\
> Remove an element from a set if it is a member.\
> \
> If the element is not a member, do nothing.\
> \"\"\"\
> pass
>
> def intersection(self, \*args, \*\*kwargs):\
> \"\"\"\
> Return the intersection of two sets as a new set.\
> \
> (i.e. all elements that are in both sets.)\
> \"\"\"\
> pass
>
> def intersection_update(self, \*args, \*\*kwargs):\
> \"\"\" Update a set with the intersection of itself and another. \"\"\"\
> pass
>
> def isdisjoint(self, \*args, \*\*kwargs):\
> \"\"\" Return True if two sets have a null intersection. \"\"\"\
> pass
>
> def issubset(self, \*args, \*\*kwargs):\
> \"\"\" Report whether another set contains this set. \"\"\"\
> pass
>
> def issuperset(self, \*args, \*\*kwargs):\
> \"\"\" Report whether this set contains another set. \"\"\"\
> pass
>
> def pop(self, \*args, \*\*kwargs):\
> \"\"\"\
> Remove and return an arbitrary set element.\
> Raises KeyError if the set is empty.\
> \"\"\"\
> pass
>
> def remove(self, \*args, \*\*kwargs):\
> \"\"\"\
> Remove an element from a set; it must be a member.\
> \
> If the element is not a member, raise a KeyError.\
> \"\"\"\
> pass
>
> def symmetric_difference(self, \*args, \*\*kwargs):\
> \"\"\"\
> Return the symmetric difference of two sets as a new set.\
> \
> (i.e. all elements that are in exactly one of the sets.)\
> \"\"\"\
> pass
>
> def symmetric_difference_update(self, \*args, \*\*kwargs):\
> \"\"\" Update a set with the symmetric difference of itself and another. \"\"\"\
> pass
>
> def union(self, \*args, \*\*kwargs):\
> \"\"\"\
> Return the union of sets as a new set.\
> \
> (i.e. all elements that are in either set.)\
> \"\"\"\
> pass
>
> def update(self, \*args, \*\*kwargs):\
> \"\"\" Update a set with the union of itself and others. \"\"\"\
> pass
>
> def \_\_and\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self&value. \"\"\"\
> pass
>
> def \_\_contains\_\_(self, y):\
> \"\"\" x.\_\_contains\_\_(y) \<==\> y in x. \"\"\"\
> pass
>
> def \_\_eq\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self==value. \"\"\"\
> pass
>
> def \_\_getattribute\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return getattr(self, name). \"\"\"\
> pass
>
> def \_\_ge\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\>=value. \"\"\"\
> pass
>
> def \_\_gt\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\>value. \"\"\"\
> pass
>
> def \_\_iand\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self&=value. \"\"\"\
> pass
>
> def \_\_init\_\_(self, seq=()): \# known special case of set.\_\_init\_\_\
> \"\"\"\
> set() -\> new empty set object\
> set(iterable) -\> new set object\
> \
> Build an unordered collection of unique elements.\
> \# (copied from class doc)\
> \"\"\"\
> pass
>
> def \_\_ior\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\|=value. \"\"\"\
> pass
>
> def \_\_isub\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self-=value. \"\"\"\
> pass
>
> def \_\_iter\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Implement iter(self). \"\"\"\
> pass
>
> def \_\_ixor\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\^=value. \"\"\"\
> pass
>
> def \_\_len\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return len(self). \"\"\"\
> pass
>
> def \_\_le\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\<=value. \"\"\"\
> pass
>
> def \_\_lt\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\<value. \"\"\"\
> pass
>
> \@staticmethod\
> def \_\_new\_\_(\*args, \*\*kwargs):\
> \"\"\" Create and return a new object. See help(type) for accurate signature. \"\"\"\
> pass
>
> def \_\_ne\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self!=value. \"\"\"\
> pass
>
> def \_\_or\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\|value. \"\"\"\
> pass
>
> def \_\_rand\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return value&self. \"\"\"\
> pass
>
> def \_\_reduce\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return state information for pickling. \"\"\"\
> pass
>
> def \_\_repr\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return repr(self). \"\"\"\
> pass
>
> def \_\_ror\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return value\|self. \"\"\"\
> pass
>
> def \_\_rsub\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return value-self. \"\"\"\
> pass
>
> def \_\_rxor\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return value\^self. \"\"\"\
> pass
>
> def \_\_sizeof\_\_(self):\
> \"\"\" S.\_\_sizeof\_\_() -\> size of S in memory, in bytes \"\"\"\
> pass
>
> def \_\_sub\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self-value. \"\"\"\
> pass
>
> def \_\_xor\_\_(self, \*args, \*\*kwargs):\
> \"\"\" Return self\^value. \"\"\"\
> pass
>
> \_\_hash\_\_ = None
>
>  
>
> 来自 \<<https://www.cnblogs.com/Ronaldo2011/p/9417612.html>\>
>
>  
