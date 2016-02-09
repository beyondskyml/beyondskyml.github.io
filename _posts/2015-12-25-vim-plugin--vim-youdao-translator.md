---
layout: post
title: "vim plugin -- vim-youdao-translator"
author: besky
data: 2015-12-25 19:03:22
categories:
- tool
tags:
- vim
- plugin
- dict

---

## 准备工作

最近浏览器的标签页越来越多了，是时候总结一下，关几个页面了。。。>\_<  

coding 时要的是顺畅啊，不知道变量名的英文怎么拼去查字典也太逊了。还好，万能的 youdaodict 来了，感谢插件作者 ianva。  

Github: [ianva / vim-youdao-translator](https://github.com/ianva/vim-youdao-translater)  

安装十分简单，Github 的教程言简意赅。下面说说用 Vundle 的安装方法。 

- 如果还没有使用 Vundle，参见这里：  
[VundleVim / Vundle.vim](https://github.com/VundleVim/Vundle.vim)  
[使用vundle进行插件管理](http://www.jianshu.com/p/mHUR4e)

---

## 安装  
  
1.编辑 `.vimrc` 配置文件  
{% highlight vim %}
" youdao dict
Plugin 'ianva/vim-youdao-translater'
let mapleader=','
vnoremap <silent>t <Esc>:Ydv<CR>
nnoremap <silent>T <Esc>:Ydc<CR>
noremap  <leader>t :Yde<CR>
{% endhighlight %}
简单解释一下：  
首先告诉 Vundle 要安装 Github 上的插件，用户名是 ianva，仓库是 vim-youdao-translator。  
然后将 leader 键映射为 `,`    
视图模式下使用 `t` 查找当前选用的词  
普通模式下使用 `T` 查找光标所在的词  
非编辑模式时可以用 `<leader>t` 输入要查找的单词，这里就是用 `,t` 了  

2.打开一个新的 vim 窗口，然后输入 `:BundleInstall`，安装插件  

3.没有第三步了，安心 coding 吧 :-)   

---

## 相关资料

这里还有些关于 vim 配置的介绍，可以看看 ～  
[foocoder - 各种 vim 资料](http://foocoder.com)  
[vim configure guide](https://www.gitbook.com/book/huangong/vim-configure-guide/details)  
[Vim 常用插件和键位映射配置 ](http://zihua.li/2013/11/my-vim-configuration-plugin/)  
[VIM :map - 很全的 vim 知识](http://www.douban.com/group/topic/10866937/)  
