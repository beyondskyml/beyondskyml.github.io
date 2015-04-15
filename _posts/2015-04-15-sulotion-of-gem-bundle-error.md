---
layout: post
title: "安装 rails 时 gem install 失败的解决办法"
author: beyondsky
data: 2015-04-15 21:38:00
categories:
- 杂七杂八
tags:
- ruby
- rails
- gem
- linux

---

由于我们处于一个大的“局域网”中，使用 gem 安装 rails 时经常会连接不到源，导致安装失败。这时候要么找梯子，要么就换个源吧。

By the way, 如果安装软件时经常遇到依赖错误，并且更换过 linux 系统的更新源，建议重新找一个更新源，比如 sohu 的，也许就解决了 ^_^ 。

下文综合了几个网页的内容，总结了由于源错误造成 gem install 以及 bundle install 失败的解决办法。

---

## 错误示例

比如安装时出现如下错误提示:

 > 	ERROR:  Could not find a valid gem 'bundler' (>= 0), here is why:  

 > 	Unable to download data from https://rubygems.org/ - Errno::ETIMEDOUT: Operation timed out - connect(2) (https://rubygems.org/latest_specs.4.8.gz)  

 >	ERROR:  Possible alternatives: bundler  


## 更换源

这里在 linux 命令行中跟换淘宝提供的源:  
	
	$ gem sources --remove https://rubygems.org/
	$ gem sources -a https://ruby.taobao.org/
	$ gem sources -l
	*** CURRENT SOURCES ***
	
	https://ruby.taobao.org
	# 请确保只有 ruby.taobao.org
	$ gem install rails

如果你是用 Bundle (Rails 项目)
	
	source 'https://ruby.taobao.org/'
	gem 'rails', '4.1.0'
	...

*注: 这个操作我没有成功，采用下述方法修改成功（原因不深究了，比较懒，能用就好，不是吗 ^_< ）。*

这里需要做额外修改，是因为使用 `rails new` 生成新的项目时，生成的 Gemfile 中的源地址是 `rubygems.org` 官方源，而且总会自动运行 `bundle install`，所以需要修改 rails 库中的 application generator 中的 Gemfile 模板，将其中的 source 选项的值改为： `http://ruby.taobao.org`

 找到 applocation generator 中的 Gemfile模板的位置:

	cd "$(gem environ | gawk '/INSTALLATION DIR/{print $4}')"
	cd ./gems/railties-*/lib/rails/generators/rails/app/templates
	vim ./Gemfile

 分别把 Gemfile 的 source 改为 'http://ruby.taobao.org' :

 这里参考如下三个 Gemfile 的目录，最好找到另外两个 Gemfile 目录，并将 source 进行修改:

	 ~/.rvm/gems/ruby-2.0.0-p247/gems/bundler-1.3.5/lib/bundler/templates/Gemfile
	 ~/.rvm/gems/ruby-2.0.0-p247/gems/railties-4.0.1/lib/rails/generators/rails/app/templates/Gemfile
	 ~/.rvm/gems/ruby-2.0.0-p247/gems/railties-4.0.1/lib/rails/generators/rails/plugin_new/templates/Gemfile

我使用的是 rails 是 4.1.2 版本，没有找到上述第一个目录，第二个和第三个目录中的 Gemfile 都修改后，执行 'bundle install' 正常。

---

## 更多内容
更多内容，包括 ruby 源码镜像等，请参考引用网页:

[RubyGems 镜像 - 淘宝网][1]  
[设置 Rails 生成的 Gemfile 中的 gem 源默认为 ruby.taobao.org][2]  
[修改默认的 Gemfile][3]  
[如何解决国内安装gem的问题][4]   


  [1]: http://ruby.taobao.org/ "RubyGems 镜像 - 淘宝网"
  [2]: http://liuxiang.logdown.com/posts/161475-sets-the-default-gem-source-ruby-in-the-gemfile-generated-at-rubytaobaoorg "设置 Rails 生成的 Gemfile 中的 gem 源默认为 ruby.taobao.org"
  [3]: https://ruby-china.org/topics/15534 "修改默认的 Gemfile"
  [4]: http://github.kimziv.com/2013/07/19/how-to-install-ruby-gems-in-china/ "如何解决国内安装gem的问题"
