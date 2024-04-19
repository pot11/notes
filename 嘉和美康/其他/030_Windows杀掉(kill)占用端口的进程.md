 

2023年2月2日

9:16

 

Windows杀掉(kill)占用端口的进程

 

(.\*)释然

 

已于 2022-06-23 15:46:09 修改

 

6568

收藏 8

文章标签： Windows

版权

1、Windows+r进入DOS窗口

2、查看占用端口号的进程id

 

netstat -ano \|findstr \"端口号\"

TCP 0.0.0.0:8888 0.0.0.0:0 LISTENING 21272

TCP \[::\]:8888 \[::\]:0 LISTENING 21272

1

2

3

拿到进程id后可以通过以下命令查看占用端口的程序

 

tasklist \|findstr \"进程id号\"

1

例如上面的21272

 

3、kill掉占用端口的进程

 

taskkill /f /t /im \"21272\"

1

也可以直接使用脚本：

 

\@echo off

setlocal enabledelayedexpansion

set /p port=请输入端口号：

for /f \"tokens=1-5\" %%a in (\'netstat -ano \^\| find \":%port%\"\') do (

if \"%%e%\" == \"\" (

set pid=%%d

) else (

set pid=%%e

)

echo !pid!

taskkill /f /pid !pid!

)

pause

1

2

3

4

5

6

7

8

9

10

11

12

13

也可以直接指定需要杀掉的exe：

 

taskkill /F /IM helloWorld.exe

1
