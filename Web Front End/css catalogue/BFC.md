## BFC（块级格式化上下文）
BFC（Block Formatting Context）叫做“块级格式化上下文”。BFC的布局规则例如以下：

1.内部的盒子会在垂直方向，一个个地放置；

2.盒子垂直方向的距离由margin决定，**属于同一个BFC的两个相邻Box的上下margin会发生重叠**；

3.每一个元素的左边，与包括的盒子的左边相接触，即使存在浮动也是如此；

4.BFC的区域不会与float重叠；

5.BFC就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素。反之也如此；

6.计算BFC的高度时，浮动元素也參与计算。

```html
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        .main {
            background: deepskyblue;
        }
        .main div {
            height: 100px;
            width: 100px;
            float: left;
        }
    </style>
</head>
<body>
    <div class="main">
        <div></div>
        <div></div>
    </div>
</body>
</html>
```
当盒子内嵌套盒子时，子盒子浮动导致父盒子无法撑开，渲染结果为页面一片空白，而让`class=main`的父盒子div形成BFC后（给.main添加绝对定位）。
```html
	<style>
		.main {
			  background: deepskyblue;
			  position: absolute;  /* 触发BFC */
		}
	</style>
```
父元素就被撑开了。并且position设置为absolute的块级元素的width是不会占满整行，如果不设置宽度并且没有子元素，其宽度为0，如果有子元素，其宽度由子元素撑开。

==**触发BFC的条件。**==

1.根元素。

2.float的属性为left right；

3.position为absolute或fixed；

4.display为inline-block。table-cell，table-caption，table-caption，flex；

5.overflow为hidden scroll auto。

6.匿名表格单元格元素（ HTML 中的 table、row、thead、tbody、tfoot 或者 display 为table、table-row、table-row-group、table-header-group、table-footer-group）。

7.网格元素（display 为 grid 或者 inline-grid 元素的直接子元素）

8.多列容器（元素的 column 或者 column-width 不为 auto，包括 column-count 为 1）
