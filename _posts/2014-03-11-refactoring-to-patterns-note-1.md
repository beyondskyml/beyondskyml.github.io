---
layout: post
title: "重构与模式笔记(1)"
author: beyondsky
date: 2014-03-11 16:16:00
categories:
- 读书笔记
tags: 
- 重构
- 模式



---

# Refactoring to Patterns
像写作那样写代码,像写文章那样写程序,因为我们是程序员,是Author.


----------


程序员要写的,不仅是代码,写代码的那叫码农...Refactoring to Patterns--重构与模式,出于对高质量代码的追求,开始阅读.
PS: 关于本书,大家可以到一下网站获取更多信息

 1. [重构与模式(豆瓣)][1]
 2. [重构与模式：改善代码三部曲中的第三部][2]

----------

## 进度 ##
读这本数大约两周了,从第一章到第五章都是写介绍性的内容,介绍什么是重构,什么是模式,什么是Refactoring to , towards and away from pattern -- 这句话是这本书的核心思想.
接下来把自己的读书笔记再提炼一下,与君共享.

----------

## 概念 ##
一些需要了解的相关概念,一些书中不会讲到的概念:

- 设计 
 - 紧耦合
 - 松耦合
- 面向对象
 - 继承
 - 多态
 - 封装
 - 组合
 - 接口
 - 抽象类
 - 具体类
 - 抽象方法
 - 静态方法
- UML 2.0
- 推荐书籍
 - << UML精髓 >>  [Fowler,UD]
 - << 设计模式 >>  [DP]
 - << 重构 >>          [F]
- Junit 单元测试工具

----------

## 重构 ##
 1. 何为重构?
    - 在不增加系统特性或不改变其外部行为的情况下改变系统的设计.
    - 是对软件内部的结构的改善,不改变软件的可视行为,使其易懂/易改.
 2. 重构目的
    - 使增加功能更加容易
    - 改善既有设计
    - 加深对代码的理解
    - just for fun  (^_^)
 3. 重构措施
    1. 去除重复
    2. 简化逻辑
    3. 澄清代码
 4. 重构要求
    - 自动测试
    - 循序渐进
    - 持续进行
 5. 一些建议
    - 可读性
        注重代码可读性, 使之读起来就像是与人交谈; 分清主次, 将分散注意力的代码尽可能分离出来.
    - 循序渐进
        重构代码切不可大刀阔斧, 即使大部分代码都很糟糕, 都需要重构, 也最好遵循分治策略, 大而化小, 分而治之, 通过小巧又安全的重构不断提高代码的质量. 怎样才算安全? -- 当然是不断测试, 每次小规模重构之后不要急于开始下一部分的重构, 而要先进行代码测试, 确保已经重构的部分随时可以完成工作, 保质保量的完成工作.
    - 广纳谏言
        如果你身边有Coder, 不妨把你的代码让他们看看, 或者把思路说给他们听听, 三个臭皮匠赛过诸葛亮, 你会发现编程将变得更容易/有趣, 如果没有这样的条件, 也可以把你的成果展示给朋友, 了解别人的想法.
    - 切忌
        切忌因为一时的着急而放弃坚持那些一路坚守的信条, 比如不断的去除重复/简化逻辑/澄清代码, 不断的与他人交流沟通, 不断的听取客户的意见, 还有更重要的, 不断的思考, 追寻更好.
> 南美丛林里一朵蝴蝶轻轻扇动翅膀......
 6. 复合重构 ( composite refactoring )
    复合重构是指由多个低层次重构组成的高层次重构, 如何小巧而安全的重构? -- 复合重构就是最好的选择, 通过多个低层次重构, 完成更大范围的代码的优化. 何谓低层次重构? 其实不过是代码迁移罢了, 当然了, 主要是这样.

    低重构--->测试--->低重构--->测试--->低重构..
    |<---------------------复合重构--------------------->|

 7. 测试驱动开发 ( TDD )
    TDD要求我们像对话那样编程:
    - 问: 编写一个测试, 向系统提问
    - 答: 编写代码通过测试, 即回答
    - 提炼: 合并概念, 去除冗余, 消除歧义
 8. 示例
    当有个项目噬需需要重构时, 怎么办呢?
    一种办法: 从公共代码中提炼出框架, 然后通过框架层为应用程序提供服务.
    另一种方法: 根据应用需求来开发框架, 然后通过重构改进应用程序和框架.
    虽然二者看上去相似, 但是第二种方法是书中推荐的, 因为可以只需要一个团队, 沟通方便, 不会导致重构时代码混乱. 个人觉得第二种方法可以尽可能保证项目的正常运行, 也同时兼顾了新需求实现时的质量更高, 降低工作量.

----------

## 模式 ##

 1. 何谓模式?
    - 对常见问题的经典解决方案
 2. 几句话
    - 重构之目的始终是为了得到更好的设计
    - 重构实现模式之后, 必须评估设计是否真的得到改善
    - 实现模式应有助于:
        - 简化逻辑
        - 说明意图
        - 提高灵活度
    - 少且谨慎地运用模式进行预先设计, 如果项目较小并且需求稳定时, 可以考虑运用模式进行预先设计.

----------

## 坏味 ##
Bad Smell
代码坏味是指代码中潜在的不良设计, 如果你有 the sixth sense, 那就是你感觉到的 -- 不爽的地方.让我们具体来看看:

- 常见设计问题: 重复/ 不清晰/ 复杂
- 过度设计: 
    - 指代码的灵活性和复杂性超出所需, 在设计时对未来需求考虑过多, 导致设计太复杂, 无用代码一堆, 维护太困难..
    - Big Ball of Mud ( 代码神腿瞪眼丸 @^_<@ ) : 
        - 数据结构 设计得太随意
        - 状态数据全局化, 传递混乱不堪
        - 变量/函数命名不标准, 怎么也看不懂..
        - 函数冗长, 完成许多不相干或可分离的任务

----------

## 总结 ##
这些基本就是前四章的读书笔记, 当然经过了相当多的总结( 精简 + 再加工 ), 加入了许多我自己的见解, 看看就行, 不必较真, 如果想靠谱点, 强烈建议看原著, E文水平高的直接看E文版更好, 总感觉中文翻译的.. 同时, 欢迎和我讨论, 指正我的不足之处. 第五章是关于该书后面几章重构讲解之结构的介绍, 在此忽略.
最后, 送给大家一句书中引用的话:
> 那些父辈们传下来的东西, 如果你能拥有它, 你就能重新得到他们. -- 歌德

 

  [1]: http://book.douban.com/subject/1917706/
  [2]: http://blog.csdn.net/hguisu/article/details/7658644

