 

2018年9月27日

20:34

 

> **支持Windows操作系统(VL),Office软件(VL).**
>
> **已支持到最新的Windows和Office!**
>
> **支持激活 Windows10 和 Office2016.**

-    

```{=html}
<!-- -->
```
-   **Windows:**

> 以管理员身份打开命令提示符,然执行下列命令：

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
<p>4</p></td>
<td><p>::cd /d "%SystemRoot%\system32"</p>
<p>slmgr /skms kms.moeclub.orgs</p>
<p>slmgr /ato</p>
<p>slmgr /xpr</p></td>
</tr>
</tbody>
</table>

>  
>
>  

-   **Office:**

> 以管理员身份打开命令提示符,进入软件安装目录,然后执行下列命令:
>
> \# 这里以Office 2013为例:
>
> \# 进入32位版本安装目录：

|     |                                                           |
|-----|-----------------------------------------------------------|
| 1   | cd /d \"%ProgramFiles(x86)%\\Microsoft Office\\Office15\" |

> \# 进入64位版本安装目录:

|     |                                                      |
|-----|------------------------------------------------------|
| 1   | cd /d \"%ProgramFiles%\\Microsoft Office\\Office15\" |

> \# 然后执行下列命令:

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 79%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p></td>
<td><p>cscript ospp.vbs /sethst:kms.moeclub.org</p>
<p>cscript ospp.vbs /act</p>
<p>cscript ospp.vbs /dstatus</p></td>
</tr>
</tbody>
</table>

> **通过以上步骤就可以免费激活你的Windows系统和Office软件.**
>
> 如果激活失败或输入过其他密钥,请先替换为微软官方密钥.([*点击查看*](https://technet.microsoft.com/en-us/library/jj612867.aspx))
>
> 以安装政府版密钥为例(Ent G 400 Years):
>
>  

|     |                                          |
|-----|------------------------------------------|
| 1   | slmgr /ipk YYVX9-NTFWV-6MDM3-9PT4T-4M68B |

>  
>
> **注意:**

-   **KMS方式激活的有效期只有180天.**

-   **每隔一段时间系统会自动KMS服务器请求续期.**

-   **只要本博客能够访问,这些都是自动的.无需人为干预.**

>  
>
>  
>
> 来自 \<<https://moeclub.org/kms/>\>
