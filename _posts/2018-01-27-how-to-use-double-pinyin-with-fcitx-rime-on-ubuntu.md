---
layout: post
slug: "how to use double pinyin with fcitx rime on ubuntu"
title: "如何在 ubuntu 14.04 上安装 fcitx-rime 并使用小鹤双拼"
author: 
data: 2018-01-27 11:33:04
categories:
- linux
- tool
tags:
- fcitx
- rime
- ubuntu
---

18 年的第 3 场大雪了，本来想着今天能收到新键盘，写写博客，结果被大雪挡在了路上。  
17 年一篇也没有更，不是没有，只是写不下去，也就拖到了今天，今年就多写一些，弥补上。

无意间在网上发现了双拼输入法，比五笔简单，较全拼更快（还是靠多练...）。  
程序员自然是要折腾的，果断学习，推荐大家在微信上搜索“双拼练习”小程序，支持多种双拼模式，还有网页版。  
推荐“小鹤双拼”，此外微软和自然码也不错，支持广泛。  
如果使用搜狗输入法，可以直接在设置里选择双拼，新版（≥ 7.4）内置了很多双拼模式，  
旧版没有的，可以直接拷贝新版的模式文件到搜狗拼音的安装路径下 doublepinyin 之类的文件夹里。  
这里说一下如何在 ubuntu 14.04 下安装 fcitx-rime 输入法，并挂载“小鹤双拼”。  

## 安装 fcitx-rime

{% highlight sh %}
# 安装 fcitx-rime， 是 fcitx 社区维护的
$ sudo apt-get install fcitx-rime

# 或者安装 ibus-rime
$ sudo apt-get install ibus-rime

# 安装双拼方案
$ sudo apt-get insatll librime-data-double-pinyin

# 配置 fcitx 为默认输入法，然后重新部署或者重启
$ im-config
$ sudo reboot # (如果已经装过 fcitx 就不需要重启啦，系统托盘 fcitx 图标右键重新启动即可)

# 添加输入法
$ fcitx-config-gtk3 # (一般安装好就有了，最好确认一下)

{% endhighlight %}

## 添加小鹤双拼方案

添加配置文件： `~/.config/fcitx/rime/default.custom.yaml`

{% highlight yaml %}
patch:
  schema_list:
    - schema: luna_pinyin          # 朙月拼音
    - schema: luna_pinyin_simp     # 朙月拼音 简化字模式
    - schema: luna_pinyin_tw       # 朙月拼音 臺灣正體模式
    - schema: terra_pinyin         # 地球拼音 dì qiú pīn yīn
    - schema: bopomofo             # 注音
    - schema: jyutping             # 粵拼
    - schema: cangjie5             # 倉頡五代
    - schema: cangjie5_express     # 倉頡 快打模式
    - schema: quick5               # 速成
    - schema: wubi86               # 五笔 86
    - schema: wubi_pinyin          # 五笔拼音混合輸入
    - schema: double_pinyin        # 自然碼雙拼
    - schema: double_pinyin_mspy   # 微軟雙拼
    - schema: double_pinyin_abc    # 智能 ABC 雙拼
    - schema: double_pinyin_flypy  # 小鶴雙拼
    - schema: wugniu               # 吳語上海話（新派）
    - schema: wugniu_lopha         # 吳語上海話（老派）
    - schema: sampheng             # 中古漢語三拼
    - schema: zyenpheng            # 中古漢語全拼
    - schema: ipa_xsampa           # X-SAMPA 國際音標
    - schema: emoji                # emoji 表情
{% endhighlight %}

这里按需添加，注意缩进。然后重新部署输入法。
然后随便找个可以打字的地方，比如浏览器地址栏（fei hua。。。），
`Ctrl+空格` `Ctrl+`\` 选择小鹤双拼就好了，注意这里还可以选择简体、繁体，全角、半角等等。

## Q&A

- Q: 选择小鹤之后无法打字？
- A: 这个应该是 fcitx-rime 特有的问题，不确定 ibus 有没有，解决方法很简单：
- A: (其实，如果在选择时显示的不是“小鹤”而是“xiaohe”这样的字母，基本就是这个问题了)
- A: 执行如下命令：

{% highlight sh %}
$ cd ~/.config/fcitx/rime
$ ln -sf /usr/share/rime-data/double_pinyin_flypy.prism.bin .
$ ln -sf /usr/share/rime-data/double_pinyin_flypy.schema.yaml .
{% endhighlight %}

- A: 然后重新部署输入法，再按照前面的步骤选择一下“小鹤双拼”就可以了，如果还不行，嗯，，，留言大家讨论讨论 XD

**最后，祝大家新年码字愉快 :D**

## Reference

- [如何在RIME输入法中使用小鹤双拼（linux）](http://raawaa.github.io/2016/04/04/how-to-enable-flypy-in-rime-on-linux/)
- [Ubuntu 14.04 下 fcitx Rime 输入法配置笔记](https://github.com/Chunlin-Li/Chunlin-Li.github.io/blob/master/blogs/linux/ubuntu-fcitx-rime.md)
- [小狼毫输入法如何设置成简体？](https://www.zhihu.com/question/41021597)
