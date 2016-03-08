---
layout: post
title: "Docker 入门教程学习笔记"
author: beyondsky
data: 2016-03-08 10:30:27
categories:
- 读书笔记
tags:
- docker


---

本文是学习 _docker 入门教程_ 的笔记，是对于原有教程的学习过程的总结记录，  
并对于学习中遇到的问题进行了解决，更具有实践性，但是解释偏少（可以看原文）。  
这个笔记只是非常基础的部分，而且 docker 发展迅速，  
故还有很大的整理、扩充空间，目前只是适合初学者简单了解之用途。  

---

## 简介

Docker - 轻量级容器，可以轻易实现生产环境部署。  

应用场景:  

- web 应用自动化打包、发布  
- 自动化测试和持续集成、发布  
- 在服务型环境中部署和调整数据库或者其他的后台应用  
- 搭建自己的 PaaS 环境  

Docker 组成:

- 服务端: 服务进程，管理所有容器  
- 客户端: 服务端的远程控制器  

一般服务端和客户端在同一台机器上运行。  

查看 docker 版本:

{% highlight sh %}
$sudo docker version
{% endhighlight %}

---

## 使用 shadowsocks

请注意该部分的前提是已经有可用的 shadowsocks 代理，  
如果尚不具备请先谷歌了解，已有很多教程。  
或者可以采用其他方式提供 socks5 代理，即可按照如下步骤进行配置；  
或者可以采用其他方式提供 http 代理，则只需要从第 4 步开始配置。  

1.安装 privoxy 将 socks5 代理转换为 http

{% highlight sh %}
$sudo apt-get install privoxy
{% endhighlight %}

2.配置代理

{% highlight sh %}
$sudo vi /etc/privoxy/config

# 找到并修改如下内容
1314            forward-socks5   /    127.0.0.1:1080 .  # socks5 代理地址
761             listen-address  localhost:8118          # http 代理地址
761             listen-address  0.0.0.0:8118            # 局域网共享
{% endhighlight %}

3.重启 privoxy 服务

{% highlight sh %}
$sudo service privoxy restart
{% endhighlight %}

4.配置 docker 代理

{% highlight sh %}
$sudo vi /etc/default/docker

# 找到并修改如下内容
10               export http_proxy="http://127.0.0.1:8118"
{% endhighlight %}

5.重启 docker
{% highlight sh %}
$sudo service docker restart
{% endhighlight %}

Reference:  
[shadowsocks Privoxy 实现 socks5 代理转 http 代理](http://www.wllog.net/2014/10/16/1042.html)  
[docker 创建私有仓库](http://www.cnblogs.com/fengzheng/p/5168951.html)  

---

## 获取镜像

### 1.检索镜像
两种方式:

- [官方网站](https://hub.docker.com/)
- 命令行工具检索: 

{% highlight shell %}
$sudo docker search MIRRORNAME
{% endhighlight %}

**注意:**  

- 镜像名称可以是名称的部分内容，不一定是全称。  
- 错误   

> Error response from daemon: Get https://index.docker.io/... TLS handshake timeout

这是因为 docker 服务器连接不稳定导致超时，可以尝试重复运行指令。  
如果已经按照上一节配置好代理，则一般不会出现此问题，除非代理非常不稳定。  

### 2.下载镜像

镜像名称:

- 一般镜像: *用户名/镜像名*
- 基础镜像: *镜像名*

基础镜像是指经过官方验证，值得信任的镜像，比如 Ubuntu。

下载命令:

{% highlight sh %}
$sudo docker pull learn/tutorial
# 或者
$sudo docker pull ubuntu
{% endhighlight %}

---

## 使用容器

### 1.在容器中运行 Hello, world!

Docker 容器可以视为沙盒，包括的资源有文件系统/系统类库/shell环境等。  
沙盒默认不允许程序，在沙盒中运行一个进程以启动一个容器，该进程是容器的唯一进程。  

运行容器的命令:

{% highlight sh %}
$sudo docker run learn/tutorial echo "Hello, world!"
{% endhighlight %}

### 2.在容器中安装程序

learn/tutorial 镜像基于 ubuntu，所以可以运行 `apt-get` 命令来安装程序。  
容器停止后，对于容器的修改不会丢失  

{% highlight sh %}
#docker run learn/tutorial apt-get install -y ping
{% endhighlight %}

默认情况下容器无法和命令行交互，因此需要使用 `-y` 参数确认安装程序。  
否则容器会一直等待用户确认是否进行安装，而无法结束。  

**注意:**   
学习到这里发现描述与实践不相符，不使用 `-y` 参数也可以安装 ping，  
而且容器停止后并没有保持安装结果，再次运行无法使用 `ping` 命令。  
**下一节说明了如何解决该问题**  

---

## 生成与发布镜像

### 1.保存镜像

在容器中运行命令，发生了对其的修改之后，需要使用 `commit` 命令建立新的镜像版本。  
直接使用原有的镜像名是无法看到对容器的修改的。  

{% highlight sh %}
#docker ps -l                       # 查看已有的容器 ID
#docker commit 123abc learn/ping    # 指定 ID 号和新的名称即可
#docker run learn/ping ping         # 查看运行效果
{% endhighlight %}

**注意:**   
`commit` 可以指定与原有镜像相同的名称来替换掉原有的镜像，  
指定不同的名称来生成新的镜像或者实现重命名。  

### 2.检测镜像状态

使用 `ps` 参数查看当前运行中的镜像，或者使用 `ps -l` 查看所有镜像，  
然后使用 `inspect` 查看容器的详细信息。  

{% highlight sh %}
#docker ps
#docker inspect 123abc
{% endhighlight %}

### 3.发布镜像

发布镜像方便自己和他人使用。  
**注意:**  
只能将镜像发布到自己的账号名称之下，也就是镜像名中包含的用户名部分要与自己的一致。  

{% highlight sh %}
#docker images                       # 查看所有安装的镜像
#docker commit 123abc besky/ping     # 利用 commit 重命名镜像
#docker rmi IMAGEID                  # 删除已有镜像
#docker rm  123abc                   # 如果删除镜像时显示被容器占用，可以先删除容器。

#docker login                        # 登陆远程仓库
#docker push besky/ping              # 推送指定镜像
{% endhighlight %}

---

## 总结

镜像是以及准备好的环境，可以是操作系统，也可以是一个小程序。  
容器是运行镜像的环境，容器与镜像的关系类似于进程之于程序。  
每当镜像运行时，启动一个容器，使用 `commit` 可以保存容器的状态到一个镜像。  
学习到的命令有: （默认省略 `docker`）  

| 命令    | 参数          | 解释                                      |
|---------|---------------|-------------------------------------------|
| version |               | 查看 docker 的版本等信息(client + server) |
| search  | image         | 搜索含有参数指定镜像名的镜像              |
| pull    | user/image    | 从仓库获取镜像                            |
| run     | user/image    | 运行镜像                                  |
| ps      | -l            | 查看运行中的容器，`-l`查看所有容器        |
| inspect | id            | 查看指定容器的状态                        |
| commit  | id user/image | 将指定容器保存成指定镜像                  |
| images  |               | 查看所有安装的镜像                        |
| rmi     | user/image    | 删除指定镜像                              |
| rm      | id            | 删除指定容器                              |
| login   |               | 登陆镜像仓库                              |
| push    | user/image    | 推送镜像到远程仓库，注意用户名是否一致    |

**注意:**  
上表中 `id` 均指容器的 ID，`user/image` 指镜像名称，对于一些镜像可能只有 `image`。  
更多的功能可以使用 `docker` 或者 `man docker` 命令查看。  

---

## Reference
[Docker 入门教程](http://www.docker.org.cn/book/docker.html)
