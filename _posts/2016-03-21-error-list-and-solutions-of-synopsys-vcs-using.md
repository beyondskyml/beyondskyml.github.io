---
layout: post
title: "使用 synopsys vcs 的问题列表及解决方法"
author: beyondsky
data: 2016-03-21 14:55:49
categories:
- linux
tags:
- synopsys
- eda
- 问题

---

前几天将 synopsys 的 VCS / DC / PT 等软件成功安装到 Ubuntu 14.04 LTS 系统中，并总结了安装中的问题，但是在使用 VCS 时暴露出新的问题，主要集中在编译/运行环境，总结一下。

---

## 段错误

### 问题:
该问题出现在成功编译之后，运行生成的 simv 文件时。虽然这个问题是解决编译时的错误之后才会出现的，但是还是放在开始来说吧（因为差点因为这个问题放弃在 Ubuntu 上折腾，打算换 REHL 系）。。。

### 错误提示:
{% highlight sh %}
# 忘记保存原来的错误记录了，类似下面这句话的提示
segment fault (core dump)
{% endhighlight %}

### 解决:
尝试了很多办法，甚至将 VCS2009 换成 VCS2014 还是老样子，最后使用 64 位编译通过。首先系统是 64 位，然后要有安装 VCS 相应版本的 amd64 包，最后使用如下命令进行编译即可。

{% highlight sh %}
# 编译
# -full64 开启 64 位
$ vcs -full64 +v2k FILENAME.V [FILENAME2.V]

# 运行
$ ./simv
{% endhighlight %}

---

## 证书错误

### 问题:
严格来说这个问题应该放在上一篇博文中，不过，，，就放在这里吧，顺便提醒大家先运行了 license 服务器再 vcs。。。（我经常忘了 ⊙﹏⊙）加个开启自动运行也行。当然，这里这个问题可不是因为没有运行导致的，具体情况和解决如下。


### 错误提示:
{% highlight sh %}
$ ./lmgrd -c PATH_TO_LICENSE/license.dat
{% endhighlight %}

> ./lmgrd: Command not found.  
> FLEXnet Licensing version v11.8.0.0 build 81116 i86_lsb MLM: can't initialize: Invalid license file syntax.

### 解决:
缺少了一个软件，安装上就行。

{% highlight sh %}
$sudo apt-get install lsb lsb-core
{% endhighlight %}

### 参考:
[Why am I unable to start the FlexNet license manager v11.8 or higher on Debian based Linux distributions?](http://cn.mathworks.com/matlabcentral/answers/97361-why-am-i-unable-to-start-the-flexnet-license-manager-v11-8-or-higher-on-debian-based-linux-distribut)

---

## 系统/内核版本

### 问题:
如果在 ubuntu 系统下，编译时会提示 linux 版本及 kernel 版本不受支持的提示，这个不管也没事，不影响使用。

### 错误提示:
> Warning-[LNX_OS_VERUN] Unsupported Linux version  
Linux version '' is not supported on 'i686' officially, assuming linux  
compatibility by default. Set VCS_ARCH_OVERRIDE to linux or suse32 to override.  
Please refer to release notes for information on supported platforms.  

> Warning-[LINX_KRNL] Unsupported Linux kernel  
Linux kernel '3.0.0-23-generic' is not supported.  
Supported versions are 2.4* or 2.6*.  

### 解决:
安装错误提示的内容添加一个变量即可。需要根据具体使用的 shell 编辑 .bashrc 或者 .zshrc 文件。

{% highlight sh %}
$ vi ~/.zshrc    # 我使用的是 zsh 所以编辑 .zshrc 文件

# 添加如下内容
export VCS_ARCH_OVERRIDE=linux

# 保存文件后更新
$ source ~/.zshrc
{% endhighlight %}

---

## 链接错误

### 问题:
编译链接时提示许多未定义的引用，并且链接错误。
如果使用的是 32 位 VCS 编译，则可能会提示不能识别编译选项 `-melf_i386`。

### 错误提示:
> 64 位（这里简单列出部分提示）  
PATH_TO_VCS/vcs201403/amd64/lib/libvcsnew.so: undefined reference to `snpsCurrentGroup'  
collect2: error: ld returned 1 exit status  
make: *** [product_timestamp] Error 1  
Make exited with status 2  

> 32 位  
g++: error: unrecognized command line option ‘-melf_i386’

### 解决:
1. 首先如果使用的是 32 位进行编译，则改用 64 位。
2. 然后下载 VG_GNU_PACKAGE 包，解压后根据其中的 REAMDE 文件配置 64 位 gcc 环境即可，很简单。
3. 最后修改环境变量设置，在 .bashrc 或者 .zshrc 文件中添加如下内容。

**注意**  
一定要保证顺序，最好直接添加在文件末尾。
否则，可能会出现无法识别选项 `-ldl`，找不到静态库 crt1.o，找不到动态库版本等错误。

> 例如如下错误  
> libstdc++.so.6: version `GLIBCXX_3.4.11' not found

{% highlight sh %}
# 执行命令搜索库文件位置
$ sudo find /usr -name 'crt1.o'

# 可能会有多个该文件，选择 64 位，GNU 版本所在位置
# 根据 shell 编辑 .zshrc 或者 .bashrc 文件
$ vi ~/.zshrc

# 添加内容如下
# 注意一定要在 VG_GUN_PACKAGE 该环境变量后面配置，否则可能出现其他问题。
export LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}"

# 保存并应用修改
$ source ~/.zshrc
{% endhighlight %}

### 参考:
[求助，VCS 在 ubuntu 64 位的问题](http://bbs.eetop.cn/viewthread.php?tid=379366)  
[g++ error when simulating with VCS](https://www.reddit.com/r/Verilog/comments/332dct/g_error_when_simulating_with_vcs/)  
[cannot find crti.o: No such file or directory](http://askubuntu.com/questions/251978/cannot-find-crti-o-no-such-file-or-directory)  
[Finding Dynamic or Shared Libraries](https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dynamic_or_shared.html#manual.intro.using.linkage.dynamic)  
[Synopsys 和 Cadence 最新软件网盘分享](http://www.61icbbs.com/forum.php?mod=viewthread&tid=62844)  

---

## 更多内容

点击 **“上一篇” ↓** 查看安装 synopsys 程序中的问题与解决办法。
