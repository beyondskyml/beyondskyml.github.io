---
layout: post
title: "Markdown添加表格"
author: 
data: 2014-12-10 20:00:00
categories:
- 杂七杂八
tags:
- MarkDown
- 语法

---

今天想在博文中添加表格，才发现MarkDown对表格的支持很不友好。
搜罗来以下几种办法，如果以后发现新方法再补充。(不一定管用)

-----------

先介绍一种简单但支持不一定好的方法(在我这里不行 \>_<)
## 方法一

代码

    || *Year* || *Temperature (low)* || *Temperature (high)* ||
    || 1900 || -10 || 25 ||
    || 1910 || -15 || 30 ||
    || 1920 || -10 || 32 ||
   
效果(我这里出不来，应该是要添加wiki-tables额外支持，还要翻越GFW，，，懒得弄了，下面有连接，大家去看吧)

|| *Year* || *Temperature (low)* || *Temperature (high)* ||
|| 1900 || -10 || 25 ||
|| 1910 || -15 || 30 ||
|| 1920 || -10 || 32 ||

这个方法来自<a href="https://github.com/trentm/python-markdown2/wiki/wiki-tables" target="_blank">*这里*</a>


-----------


## 方法二

代码

	|  |BorderLayout|  |
	|:------:|:------:|:--------:|
	|  |North|  |
	|West | Center |East |
	|   | South |   |

效果

|  |BorderLayout|  |
|:------:|:------:|:--------:|
|  |North|  |
|West | Center |East |
|   | South |   |

说明
> | 表示单元格  
> :---: 表示居中  
> :---- 表示居左  
> ----: 表示居右  


-----------


## 方法三
使用HTML语法直接写表格。MarkDown支持HTML语法，因此你可以直接写一个表格，不过不论怎样都出不来边框。。。

代码

    <table border="1", width="260", align="center">
       <tr>
          <th colspan="3">BorderLayout</th>
       </tr>
       <tr>
          <td colspan="3" align="center">North</td>
       </tr>
       <tr>
          <td align="center">West</td>
          <td align="center">Center</td>
          <td align="center">East</td>
       </tr>
       <tr>
          <td colspan="3" align="center">South</td>
          </tr>
    </table>
    
效果

<table border="1", width="260", align="center">
   <tr>
      <th colspan="3">BorderLayout</th>
   </tr>
   <tr>
      <td colspan="3" align="center">North</td>
   </tr>
   <tr>
      <td align="center">West</td>
      <td align="center">Center</td>
      <td align="center">East</td>
   </tr>
   <tr>
      <td colspan="3" align="center">South</td>
      </tr>
</table>

说明: 

    <th>表头内容</th>
    <br>换行
    <code>代码</code>
    <I>斜体内容</I>
    <td colspan="跨列数">跨列</th>
    <td rowspan="跨行数">跨行</th>
    <th width="宽度值或百分比">表头内容</th>
