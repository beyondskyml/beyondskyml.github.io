---
layout: post
title: "problems and solutions during the synopsys softwares installation"
title: "Synopsys 软件安装中的问题及解决方法"
author: beyondsky
data: 2016-03-17 16:23:49
categories:
- linux
tags:
- synopsys
- eda
- 问题

---

这篇是在 Ubuntu 系统上安装 synopsys 的 VCS / DC / PT 软件中遇到的问题及解决办法的汇总。  
**参考的安装教程、安装平台见本文最后。**

---

## source ~/.bashrc 错误

问题:  
安装完成 Synopsys 相关的程序后需要添加环境变量，
如果使用的是 zsh 而不是 bash，出现如下错误。

错误提示:  
{% highlight sh %}
/home/user/.bashrc:17: command not found: shopt
/home/user/.bashrc:25: command not found: shopt
/home/user/.bashrc:109: command not found: shopt
/usr/share/bash-completion/bash_completion:35: parse error near]]'
{% endhighlight %}

解决:  
正确的方法是在 `~/.zshrc` 中添加环境变量，
添加完成后执行命令 `source ~/.zshrc` 即可。

参考:  
[shopt command not found in .bashrc after shell updation](http://stackoverflow.com/questions/26616003/shopt-command-not-found-in-bashrc-after-shell-updation)

---

## 找不到 libXft.so.2

问题:  
忘记了是运行 `lmstat` 还是 `lmgrd` 命令时出现了以下错误，
缺什么装什么就好了。:-D

错误提示:  
{% highlight sh %}
error while loading shared libraries: libXft.so.2: cannot open shared object file: No such file or directory Error.
{% endhighlight %}

解决:  
Ubuntu 系统下运行以下命令安装即可
{% highlight sh %}
$ sudo apt-get install libxft2 libxft2:i386 lib32ncurses5
{% endhighlight %}

参考:  
[ModelSim-Altera error](http://stackoverflow.com/questions/31908525/modelsim-altera-error)

---

## 不能创建 flexlm 文件

问题:  
这个错误是运行 `lmgrd` 命令时出现的，
找不到 `/usr/tmp/` 目录下的日志文件 `.flexlm`

错误提示:  
{% highlight sh %}
8:20:41 (lmgrd) Can't make directory /usr/tmp/.flexlm, errno: 2(No such file or directory)
8:20:41 (lmgrd) Can't make directory /usr/tmp/.flexlm, errno: 2(No such file or directory)
8:20:41 (lmgrd) Can't open /usr/tmp/.flexlm/lmgrdl.17205, errno: 2 
license manager: can't initialize
8:20:41 (lmgrd) Can't remove statfile /usr/tmp/.flexlm/lmgrdl.17205: errno No such file or directory 
{% endhighlight %}

解决:  
网上搜到的答案里说这个错误不应该影响 license 的检查，
为了解决该问题可以创建缺失的目录或者向下面这样的符号链接
{% highlight sh %}
$ sudo ln -s /tmp /usr/tmp
{% endhighlight %}

参考:  
[Can't make directory error in FLEXlm log file on Linux](http://www.maplesoft.com/support/faqs/detail.aspx?sid=89076)

---

## 不能连接证书服务器

问题:  
还是 `lmstat` 或者 `lmgrd` 命令时，会出现找不到证书服务器的错误，
错误代码是 SEC-12

错误提示:  
{% highlight sh %}
Unable to obtain feature 'Design-Vision ' because:
Error: Can't communicate with the license server. (SEC-12)
Please contact  at root@(none), who is
your local Synopsys license administrator for Synopsys site 000.
Unable to obtain feature 'Design-Analyzer ' because:
Error: Can't communicate with the license server. (SEC-12)
Please contact  at root@(none), who is
your local Synopsys license administrator for Synopsys site 000.
Fatal: At least one of the following must be enabled : Design-Vision, Design-Analyzer. (DCSH-10)

# lmgrd-c /usr/synopsys/license/synopsys.dat -l ~/syn_lic.log 
# 运行命令后的日志中有如下提示
23:40:17 (lmgrd) The license server manager has found no vendor daemons to start
23:40:17 (lmgrd)  (There are no VENDOR (or DAEMON) lines in the license file),
{% endhighlight %}

解决:  
这个问题是由于 license 中 VENDOR 设置不正确，
也可能是创建 license 时没有选择 `use Deamon` 选项，
那么就不会生成有关 VENDOR 的内容，
修改 license 文件增加如下内容。
{% highlight sh %}
# PATH_TO_SCL 指 scl 安装路径
VENDOR snpslmd PATH_TO_SCL/linux/bin/snpslmd
{% endhighlight %}

参考:  
[装DC有点问题请教一下大神](http://bbs.eetop.cn/viewthread.php?tid=363335)

---

## 参考
[Ubuntu 系统下 Synopsys VCS DC PT 安装文件下载及安装破解方法](http://bbs.eetop.cn/thread-412008-1-1.html)  
我是参考上面这个教程安装的，安装那块写的不是很清楚。
DC VCS PT 的安装方法是一样的，注意先安装 common 包，
再装 linux，最后 amd64 （这个不装一般也没问题，就是 64 位程序）。

破解这块教程中说不要勾选 `use Daemon`，结果生成的 license 里没有 VENDOR，
大家可以试试勾选后是否正确，反正我自行添加也能用了。。。

最后有一点特别注意的是，我参考这个教程给的 PTS_2011 安装后启动时崩溃，
后来下载了 PTS_2009 安装成功，不知道是因为 installer 版本低还是我系统的缘故。
我的系统是 ubuntu 14.04 LTS (64-bit) 内核 3.13.0-80-generic

祝顺利 O(∩_∩)O
