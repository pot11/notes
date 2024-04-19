python程序执行原理

2018年9月6日

11:06

 

**1. 过程概述**

Python先把代码（.py文件）编译成字节码，交给字节码虚拟机，然后虚拟机一条一条执行字节码指令，从而完成程序的执行。

**2. 字节码**

字节码在Python虚拟机程序里对应的是PyCodeObject对象。

.pyc文件是字节码在磁盘上的表现形式。

**3. pyc文件**

PyCodeObject对象的创建时机是模块加载的时候，即import。

Python test.py会对test.py进行编译成字节码并解释执行，但是不会生成test.pyc。

如果test.py加载了其他模块，如import util，Python会对util.py进行编译成字节码，生成util.pyc，然后对字节码解释执行。

如果想生成test.pyc，我们可以使用Python内置模块py_compile来编译。

加载模块时，如果同时存在.py和.pyc，Python会尝试使用.pyc，如果.pyc的编译时间早于.py的修改时间，则重新编译.py并更新.pyc。

**4. PyCodeObject**

Python代码的编译结果就是PyCodeObject对象。

 

 

<table>
<colgroup>
<col style="width: 10%" />
<col style="width: 89%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p>
<p>11</p>
<p>12</p>
<p>13</p>
<p>14</p>
<p>15</p>
<p>16</p>
<p>17</p>
<p>18</p>
<p>19</p>
<p>20</p></td>
<td><p>typedef struct {</p>
<p>    PyObject_HEAD</p>
<p>    int co_argcount;        /* 位置参数个数 */</p>
<p>    int co_nlocals;         /* 局部变量个数 */</p>
<p>    int co_stacksize;       /* 栈大小 */</p>
<p>    int co_flags;  </p>
<p>    PyObject *co_code;      /* 字节码指令序列 */</p>
<p>    PyObject *co_consts;    /* 所有常量集合 */</p>
<p>    PyObject *co_names;     /* 所有符号名称集合 */</p>
<p>    PyObject *co_varnames;  /* 局部变量名称集合 */</p>
<p>    PyObject *co_freevars;  /* 闭包用的的变量名集合 */</p>
<p>    PyObject *co_cellvars;  /* 内部嵌套函数引用的变量名集合 */</p>
<p>    /* The rest doesn’t count for hash/cmp */</p>
<p>    PyObject *co_filename;  /* 代码所在文件名 */</p>
<p>    PyObject *co_name;      /* 模块名|函数名|类名 */</p>
<p>    int co_firstlineno;     /* 代码块在文件中的起始行号 */</p>
<p>    PyObject *co_lnotab;    /* 字节码指令和行号的对应关系 */</p>
<p>    void *co_zombieframe;   /* for optimization only (see frameobject.c) */</p>
<p>} PyCodeObject;</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

 

 

**5. pyc文件格式**

加载模块时，模块对应的PyCodeObject对象被写入.pyc文件，格式如下：

 

**6. 分析字节码**

**6.1 解析PyCodeObject**

Python提供了内置函数compile可以编译Python代码和查看PyCodeObject对象，如下：

**Python代码\[test.py\]**

 

 

<table>
<colgroup>
<col style="width: 37%" />
<col style="width: 62%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p></td>
<td><p>s = ”hello”</p>
<p> </p>
<p>def func():</p>
<p>    print s</p>
<p> </p>
<p>func()</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

在Python交互式shell里编译代码得到PyCodeObject对象:

dir(co)已经列出co的各个域，想查看某个域直接在终端输出即可：

**test.py的PyCodeObject**

 

 

<table>
<colgroup>
<col style="width: 2%" />
<col style="width: 97%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p></td>
<td><p>co.co_argcount    0</p>
<p>co.co_nlocals     0</p>
<p>co.co_names       (‘s’, ’func’)</p>
<p>co.co_varnames    (‘s’, ’func’)</p>
<p>co.co_consts      (‘hello’, &lt;code object func at 0x2aaeeec57110, file ”test.py”, line 3&gt;, None)</p>
<p>co.co_code        ’d\x00\x00Z\x00\x00d\x01\x00\x84\x00\x00Z\x01\x00e\x01\x00\x83\x00\x00\x01d\x02\x00S’</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

Python解释器会为函数也生成的字节码PyCodeObject对象，见上面的co_consts\[1\]

**func的PyCodeObject**

 

 

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 83%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p></td>
<td><p>func.co_argcount   0</p>
<p>func.co_nlocals    0</p>
<p>func.co_names      (‘s’,)</p>
<p>func.co_varnames   ()</p>
<p>func.co_consts     (None,)</p>
<p>func.co_code       ‘t\x00\x00GHd\x00\x00S’</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

co_code是指令序列，是一串二进制流，它的格式和解析方法见6.2。

**6.2 解析指令序列**

**指令序列co_code的格式**

|            |           |            |            |           |         |
|------------|-----------|------------|------------|-----------|---------|
| **opcode** | **oparg** | **opcode** | **opcode** | **oparg** | **...** |
| 1 byte     | 2 bytes   | 1 byte     | 1 byte     | 2 bytes   |         |

Python内置的dis模块可以解析co_code，如下图：

**test.py的指令序列**

**func函数的指令序列**

第一列表示以下几个指令在py文件中的行号;

第二列是该指令在指令序列co_code里的偏移量;

第三列是指令opcode的名称，分为有操作数和无操作数两种，opcode在指令序列中是一个字节的整数;

第四列是操作数oparg，在指令序列中占两个字节，基本都是co_consts或者co_names的下标;

第五列带括号的是操作数说明。

 

**7. 执行字节码**

Python虚拟机的原理就是模拟可执行程序再X86机器上的运行，X86的运行时栈帧如下图：

假如test.py用C语言来实现，会是下面这个样子：

 

 

<table>
<colgroup>
<col style="width: 24%" />
<col style="width: 75%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p>
<p>11</p></td>
<td><p>const char *s = “hello”;</p>
<p> </p>
<p>void func() {</p>
<p>    printf(“%s\n”, s);</p>
<p>}</p>
<p> </p>
<p>int main() {</p>
<p>    func();</p>
<p>    return 0;</p>
<p>}</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

Python虚拟机的原理就是模拟上述行为。当发生函数调用时，创建新的栈帧，对应Python的实现就是PyFrameObject对象。

**7.1 PyFrameObject**

 

 

<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 85%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p>
<p>11</p>
<p>12</p></td>
<td><p>typedef struct _frame {</p>
<p>    PyObject_VAR_HEAD</p>
<p>    struct _frame *f_back;    /* 调用者的帧 */</p>
<p>    PyCodeObject *f_code;     /* 帧对应的字节码对象 */</p>
<p>    PyObject *f_builtins;     /* 内置名字空间 */</p>
<p>    PyObject *f_globals;      /* 全局名字空间 */</p>
<p>    PyObject *f_locals;       /* 本地名字空间 */</p>
<p>    PyObject **f_valuestack;  /* 运行时栈底 */</p>
<p>    PyObject **f_stacktop;    /* 运行时栈顶 */</p>
<p>    …….</p>
<p>}</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

那么对应Python的运行时栈就是这样子：

**7.2 执行指令**

执行test.py的字节码时，会先创建一个栈帧，以下用f表示当前栈帧，执行过程注释如下：

**test.py的符号名集合和常量集合**

 

 

<table>
<colgroup>
<col style="width: 2%" />
<col style="width: 97%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p></td>
<td><p>co.co_names   (‘s’, ’func’)</p>
<p>co.co_consts  (‘hello’, &lt;code object func at 0x2aaeeec57110, file ”test.py”, line 3&gt;, None)</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

**test.py的指令序列**

上面的CALL_FUNCTION指令执行时，会创建新的栈帧，并执行func的字节码指令，以下用f表示当前栈帧，func的字节码执行过程如下：

**func函数的符号名集合和常量集合**

 

 

<table>
<colgroup>
<col style="width: 24%" />
<col style="width: 75%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p></td>
<td><p>func.co_names       (‘s’,)</p>
<p>func.co_consts      (None,)</p>
<p> </p></td>
</tr>
</tbody>
</table>

 

**func函数的指令序列**

**7.3 查看栈帧**

如果你想查看当前栈帧，Python提供了sys.\_getframe()方法可以获取当前栈帧，你只需要在代码里加入代码如下：

 

 

<table>
<colgroup>
<col style="width: 22%" />
<col style="width: 77%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p></td>
<td><p>def func():</p>
<p>    import sys</p>
<p>    frame = sys._getframe()</p>
<p>    print frame.f_locals</p>
<p>    print frame.f_globals</p>
<p>    print frame.f_back.f_locals</p>
<p>    #你可以打印frame的各个域</p>
<p>    print s  </p>
<p> </p></td>
</tr>
</tbody>
</table>

 

来自 \<<https://www.cnblogs.com/xiaolongxia/articles/4039135.html>\>
