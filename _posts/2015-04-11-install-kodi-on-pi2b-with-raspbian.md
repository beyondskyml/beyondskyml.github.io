---
layout: post
title: "树梅派2 Raspbian 系统安装 Kodi/XBMC"
author: beyondsky
data: 2015-4-11 23:00:00
categories:
- linux
tags:
- raspberry
- pi
- xbmc
- linux

---

手头有一个树莓派，为了简单直接使用 raspbmc 系统，用作下载机加视频播放系统，外加 git 仓库等等，后来入手树莓派2B（pi2b，注意这里2b指的是2代B版，即4核芯、1GB内存版本），感觉性能强大不少，所以决定使用更完善的 raspbian 系统，但是在安装 Kodi（原名 XBMC，多媒体软件）时遇到麻烦（比如依赖冲突、视频驱动等问题），找了很久，在 Kodi 的维基百科上找到安装教程，并还算顺利的安装上，故拿来分享。（英语渣，表介意 :D）
原文地址：[XBMC for Raspberry Pi][1]

-----------

这个页面介绍如何在运行 Raspbian 系统的树梅派上安装 XBMC。你既可以选择在已有设备上安装软件包，也可以下载一个预生成镜像文件来烧写到一张 SD 卡上。

-----------

#在已有设备上安装
我已经释出了一个归档文件（archive），里面包含有 Kodi/XBMC 的软件包和一些必要的依赖环境。你可以在已有的 Raspbian 系统设备（包括[官方镜像(foundation image)][2]）上安装它。

##安装
1. 最简单的安装方法是在你的系统中添加我的归档文件。首先在 **/etc/apt/sources.list.d/mene.list** 文件中添加并保存如下内容：

    deb http://archive.mene.za.net/raspbian wheezy contrib

2. 导入存档签名密钥：

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 5243CDED
    
*注：这里我（译者）没有成功，但是不添加密钥也能正常安装，只是会有警告而已。*

3. 更新软件包列表：

    sudo apt-get update

4. 接下来你就可以像平时安装软件那样，来安装它了。例如，使用 **apt-get** 命令：

    sudo apt-get install kodi

5. 运行 Kodi 的用户（user）需要是以下用户组（groups）的成员：

    audio video input dialout plugdev tty

*注：这里按原意理解，指该用户需要是上述所有用户组的一员，而不是其中某一个用户组的一员。*

6. 如果没有 **input** 用户组，你需要者创建它：

    addgroup --system input

7. 然后设置一些 udev 规则以保证它有输入设备的使用权（否则在 Kodi 下键盘将无法工作）。方法是将如下内容添加到 **/etc/udev/rules.d/99-input.rules** 文件中：

    SUBSYSTEM=="input", GROUP="input", MODE="0660"
    KERNEL=="tty[0-9]*", GROUP="tty", MODE="0660"

8. 为了运行 XBMC，GPU（图形处理器）至少需要 96MB 的内存。进行此项配置需要在 **/boot/config.txt** 文件中添加或者修改以下内容：

    gpu_mem=128

9. 如果改变了这个值，你需要重启设备：

    sudo reboot
或：

    sudo shutdown -r now

##运行
要运行 XBMC，可以从一个虚拟终端（VT）（例如，不在 X 下*，X 是 linux 的图形系统*）上运行 **kodi-standalone**。XBMC 之间进行显示输出，而不是通过图形系统（Xorg）。

如果你想让系统启动时自动运行 Kodi，编辑 **/etc/default/kodi** 文件，将 **ENABLED** 的值改为**1**：

    ENABLED=1

*注：最好在确定键盘能够在 Kodi 下使用后再设置开启自启动，否则...*

运行 `sudo service kodi start` 来进行测试。*如果该测试启动了 Kodi，说明配置正确。*

##发布记录
 - 14.1-1: Helix 14.1 release
 - 14.0-1: Helix 14.0 release.
 - 13.1-2: Link to libshairplay for better AirPlay support.
 - 13.1-1: Gotham 13.1 release.
 - 12.3-1: Frodo 12.3 release.
 - 12.2-1: Frodo 12.2 release.
 - 12.1-1: Frodo 12.1 release. Requires newer libcec (also in my archive).
 - 12.0-1: Frodo 12.0 release. ~This build requires newer firmware than the raspberrypi.org archive or image contains. Either install the packages from the raspberrypi.org untested archive, the twolife archive or use rpi-update.~ (Not necessary as of 2013/02/11.)

-----------

#使用预生成镜像烧写一张SD卡
我已经构建了一个镜像，它包括了一个装有 XBMC 软件包的 Raspbian 系统，你可以直接下载并烧写到一张 SD 卡上。你需要一张 1GB 容量的 SD 卡*（当然更大也是可以的）*（这张卡将被完全擦除）。

##烧写
1. 使用 **unx** 命令解压缩镜像：

    % unxz raspbian-xbmc-20121029.img.xz

2. 复制镜像到 SD 卡设备（**确保你选择的是正确的设备名称！**）。

    % sudo cp xbmc-20121029-1.img /dev/sdb

*注：这里 **sdb** 指的是你的 SD 卡设备，如果你不清楚上述命令究竟做了什么，建议先去查查资料，否则这个操作有可能把你的硬盘擦除！*

##定制
这个镜像使用与官方镜像（foundation image）相同的凭证，用户名：`pi`，密码：`raspberry`。你可以使用 **raspi-config** 工具扩展根文件系统，开启超频以及其他各种配置工作。

##更新
Raspbian 和 Kodi 都可以使用普通的 Debian 机制来进行更新，比如 **apt-get** 命令：

    # sudo apt-get update
    # sudo apt-get dist-upgrade

##发布记录

 - 20150208: torrent magnet Contains 14.1-1, and should work on
   Raspberry Pi 2.
 - 20150112: torrent magnet Contains 14.0-1.
 - 20140614: torrent magnet Contains 13.1-2.
 - 20131228: torrent magnet Contains 12.3-1.
 - 20130708: torrent magnet Fixes alphanumeric keyboard input.
 - 20130528: torrent magnet Contains 12.2-1.
 - 20130212: torrent magnet Contains 12.0-1.
 - 20130106: torrent magnet Contains 12.0~git20130102.7a6cb7f-1, and wireless support.
 - 20130101: torrent magnet Contains 12.0~git20121219.74b907c-1: Frodo RC2.
 - 20121121: torrent magnet Contains 11.0~git20121114.25bb46a-1: Frodo Beta 1.
 - 20121029: torrent magnet
 - 20121021: torrent magnet

##不稳定版
我已经为即将到来的一系列（Helix）发布开始构建软件包。它们在归档文件中的新的 **unstable** 区域。要安装这些软件包，按如下内容更新你的源列表（source list）：

    deb http://archive.mene.za.net/raspbian wheezy contrib unstable

##发布记录
 - 14.0-1: Helix 14.0 release.
 - 14.0~git20141203.35b4f38-1: Helix 14.0 RC 2
 - 14.0~git20141130.ea20b83-1: Helix 14.0 RC 1
 - 14.0~git20141125.4465fbf-1: Helix 14.0 Beta 5
 - 14.0~git20141124.ec361ca-1: Helix 14.0 Beta 4
 - 14.0~git20141116.88a9a44-1: Helix 14.0 Beta 3
 - 14.0~git20141103.d6947be-1: Helix 14.0 Beta 1. This requires firmware as of 2014/10/06 and libcec 2.2.0 (both included in the archive). There are also builds for Jessie but I haven't tested them. PVR addons are also updated.
 - 14.0~git20141002.d2a4ee9-1: Helix 14.0 Alpha 4


----------

如果遇到什么问题，可以访问原文，原文网页下方有评论，可以看看自己设备上出现的问题是否在内。顺便一提，这篇文章是在树梅派2上翻译的，二代小派的性能确实强悍。：D


  [1]: http://michael.gorven.za.net/raspberrypi/xbmc
  [2]: https://www.raspberrypi.org/downloads/