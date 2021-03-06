---
layout: post
title: "计算机组成原理(2)"
author: beyondsky
date: 2014-03-08 17:59:00
categories: 
- 组织与结构
tags: 
- 前情提要
- 总线系统



---

## 1.总线主设备与总线从设备
要完成一次总线操作，必须有设备提出使用总线的申请，以获得总线的使用权。在众多连接到总线上的所有设备中，能够申请并获得总线使用权的设备，被称为总线主设备(master device)。不具有申请总线使用权的设备，被称为总线从设备(slave device)。

---

## 2.总线源设备与总线目标设备
从总线数据传输的方向，可以把总线设备分为源设备和目标设备。设备使用总线是用来传送数据信息的，数据的传送具有方向性特点，即是数据从一个设备转移到另一个设备的过程。在这个过程中，有些设备能够发送数据，有些设备能够接收数据。将发送数据的设备称为总线源设备(source device，数据的源头)。而将接收数据的设备称为总线目标设备(target device，数据的落脚点)。  
**注意：总线源设备、目标设备与总线主设备、从设备之间没有必然联系。总线主设备可以是总线源设备，也可以是总线目标设备，还可以是既不是总线源设备也不是总线目标设备。**

---

##3.存储器设备与I/O设备
以访问总线设备的方法来区分总线设备，使用访问存储器的方法进行访问的设备称为存储器设备(memory device)，这种设备需要使用访存型总线命令来访问；另一种就是使用访问I/O的方法进行访问的设备，这种设备被称为I/O设备(I/O device)。I/O设备是需要使用I/O型总线命令来访问的。比如，主存就是存储器设备，而磁盘就是I/O设备。

---

##4.总线设备接口
- 作用：能够接收并且识别总线控制信号，并根据设备的特性产生控制设备的信号。  
- 接口所涉及到的两个控制信号：一个是控制信号是由总线发出的，一个控制信号是由接口产生用来控制设备的。  
- 总线设备接口对总线设备应该具备的功能信号处理能力.

---

##5.总线控制器
- 总线控制器的任务是管理总线的使用，包括总线上设备的管理和设备使用总线的过程管理。在实现总线控制器时，并不一定需要一个专用的总线控制器(专门的硬件机构)，它的功能可能分布到总线的各个部件或者各个设备上。所以，是“逻辑概念上的总线控制器”。  
- 功能：总线系统资源的管理、总线系统的定时、总线的仲裁、总线的连接。