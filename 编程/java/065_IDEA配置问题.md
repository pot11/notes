IDEA配置问题

2019年9月19日

11:33

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><ol class="incremental" type="1">
<li><p>前言：</p></li>
</ol>
<blockquote>
<p>每次接手老项目，都得从git或svn下载下来，但是如果之前的项目不是用idea写的怎么办，可是你又习惯啦idea,那你必须把项目在idea上跑起来，那是用import还是用open呢?</p>
<p> </p>
<p>解决：</p>
<p>导入（import）：如果原来的项目本来不是idea开发的项目(你没有把svn或git集成idea,直接下来的项目，那么此时你想用idea来运行这个项目，就需要进行导入。（主要是缺少.idea文件）</p>
<p> </p>
<p>打开（open）：如果原来的项目本来就是idea开发，那么就直接打开。（已存在.idea文件）</p>
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
<td><p>2.IDEA中的.iml文件和.idea文件夹作用和意义</p>
<blockquote>
<p>使用IDEA创建一个maven工程，目录结构中会产生了两个不一样的东西——分别是 .iml文件和.idea文件夹</p>
<p> </p>
<p><strong>.iml文件：</strong>idea 对module 配置信息之意， infomation of module</p>
<p>iml文件IDEA自动创建的模块文件，用于Java应用开发，存储一些模块开发相关的 信息比如一个Java组件，届件组件，Maven组件等等还可能会存储一些模块路径信 息，依赖信息以及别的一些设置。</p>
<p> </p>
<p> </p>
<p><strong>.idea文件夹</strong>：.Idea存放项目(project）的配置信息，包括历史记录，版本控制信息等，可以不理会。</p>
<p> </p>
<p>可以点击file-&gt;Settings-&gt;File types,在右下角的Ignore files and folders中可以输入.idea;和*.iml;将其隐藏。</p>
<p><img src="065_IDEA配置问题_000.png" /></p>
<p>不建议隐藏iml，因为项目名出现中括号是因为iml文件名和项目文件名不一样，需要更改iml文件名</p>
<p><img src="065_IDEA配置问题_001.png" /></p>
<p> </p>
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
<td><p>3.<strong>为避免把module导入到projetct下出错，导入时尽量用project structure,直观不容易出错</strong></p>
<p><img src="065_IDEA配置问题_002.png" /></p>
<ul class="incremental">
<li><p>导入普通web 模块(根据maven创建)步骤（原本moudule是用idea写的）</p></li>
</ul>
<blockquote>
<p><img src="065_IDEA配置问题_003.png" /></p>
<p> </p>
<p><img src="065_IDEA配置问题_004.png" /></p>
<p> </p>
<p><img src="065_IDEA配置问题_005.png" /></p>
<p> </p>
<p><img src="065_IDEA配置问题_006.png" /></p>
<p> </p>
<p><img src="065_IDEA配置问题_007.png" /></p>
<p> </p>
<p><img src="065_IDEA配置问题_008.png" /></p>
<p>点apply后ok即可,系统会自动把war包和war.exmploded包建好</p>
</blockquote></td>
</tr>
</tbody>
</table>
