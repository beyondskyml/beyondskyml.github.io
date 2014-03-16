---
layout: post
title: "Win7 + Ubuntu硬盘安装方法"
author: beyondsky
date: 2014-03-08 23:16:00 + 00:00
categories:
- 杂七杂八
tags: 
- linux
- ubuntu
- 系统安装

---

多年前就玩过Linux，不过当时年幼无知，不懂她的好。。。呵呵  

寒假折腾blog，体验了wordpress，用过了octopress，到头来还是发现用github jekyll本身就很好了，省了域名、省了主机、省了编译。。。简直就是-born for blog...  

扯远了。。搭建博客，一开始在win下用github，折腾半天没成功，看网友推荐linux，于是装上Ubuntu，分分钟搞定git呀！瞬间各种BS微软 （^_<）  

因此，写写怎么安装ubuntu，免得忘了。。  

***

##下载

* ubuntu系统:http://www.ubuntu.com/download/desktop
* EasyBCD (MBR引导功能，实现Windows7下安装Linux，引导启动双系统)
* 压缩解压软件（这个都有吧！没有的蹲墙角画圈圈去。。。）

***

##安装

1. 把系统镜像文件直接放到硬盘分区根目录下 如 D:\ubuntu.iso  
2. 用压缩解压软件打开deepin.iso，把casper目录下的initrd.lz，vmlinuz文件（**可能有扩展名，也可能没有**）解压到C盘根目录  
3. 打开EasyBCD，依次选择 Add New Entry | NeoGrub | install，再点Config，在弹出的文本文件最后加入：  
> title Install Linux  
> root (hd0,0)  
> kernel (hd0,0)/vmlinuz boot=casper iso-scan/filename=/ubuntu.iso ro quiet splash locale=zh_CN.UTF-8  
> initrd (hd0,0)/initrd.lz  

	__注意__  
	* （hd0,0）中，hd0代表第1个磁盘，第二个0代表第1个分区，如果你的C盘不是硬盘的第一个分区，需做修改  
	* vmlinuz和initrd两个文件的扩展名必须和复制到C盘下的一致  
	* filename=/ubuntu.iso 中的ubuntu.iso必须和你放到分区跟目录下的系统文件名一致  

4. 保存文本文档后，重启  
5. 启动时选择新增的NeoGrub引导项，回车进入安装系统环境。  
6. 开始安装前使用组合键“CTRL+ALT+T”进入命令行模式，输入命令：  
> sudo umount -l /isodevice  

	回车  

7. 点击桌面上第一个图表安装  
8. 安装方式推荐其他方式，分区推荐如下:  
> / 20GB  
> 交换分区 与内存等容量  
> /home 大于20GB  

	具体方案可依上述酌情修改  

	__注意__  
	* 分区界面下方，安装启动引导器的位置最好选择/挂载点（可视为/分区），方便以后删除更换Linux  
9. 安装完成后重启，直接进入Win7。打开EasyBCD，将“NeoGrub”删除，之后点击 Add New Entry | Linux/BSD”，Type选GRUB2，Name随意，再点“Add Entry”，关闭软件。  
10. 把C盘下的initrd.lz, vmlinuz两个文件删除，重启即可看到Ubuntu系统启动项。  
