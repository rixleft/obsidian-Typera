# FC
FC是Formatting Context的简写，直译过来是格式化上下文，FC就是html页面中的某个元素内的一套渲染规则，决定了其子元素如何布局，以及和其他元素在html页面中的位置。

**如何触发XFC（X为B，I，G，F之一）？**
通过设置某个元素的某些属性值来使得该元素应用某种渲染规则。例如将一个div的display属性设置为grid，那么就称触发了GFC，该元素内就形成了一个GFC,该元素内的渲染规则就要使用GFC规则。

## BFC（块级格式化上下文）
BFC（Block Formatting Context）叫做“块级格式化上下文”。BFC的布局规则例如以下：
display:block;
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

## IFC（内联格式化上下文）
IFC（Inline Formatting Contexts）直译为"内联格式化上下文"，IFC 的 line box（框）高度由其包含行内元素中最高的实际高度计算而来（不受到竖直方向的 padding/margin 影响)。

符合以下条件即会生成一个IFC

- 块级元素中仅包含内联级别元素

形成条件非常简单，需要注意的是当IFC中有块级元素插入时，会产生两个未命名的块元素将父元素分割开来，产生两个IFC。

## FFC（弹性格式化上下文）
- 直译为"**弹性格式化上下文**"，`display`值为`flex`或者`inline-flex`的元素将会生成自适应容器`（flex container）`，`display:flex`将容器渲染为一个块级元素，`display:inline-flex`将容器渲染为一个行内元素，弹性容器中包含了一个或者多个弹性子元素。

- 采用 Flex 布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"。

- 容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做`main start`，结束位置叫做`main end`；交叉轴的开始位置叫做`cross start`，结束位置叫做`cross end`。项目默认沿主轴排列。单个项目占据的主轴空间叫做`main size`，占据的交叉轴空间叫做`cross size`。
#### 该属性是给父元素设置的
- `flex-direction`该属性决定主轴的方向（即项目的排列方向，它有四个值：
	- `row`（默认值）：主轴（X轴）为水平方向，起点在左端。
	- `row-reverse`：主轴（Y轴）为水平方向，起点在右端。
	- `column`：主轴（Y轴）为垂直方向，起点在上方。
	- `column-reverse`：主轴（Y轴）为垂直方向，起点在下方。
- `flex-wrap`默认情况下，项目都排在一条线（又称"轴线"）上。该属性定义，如果一条轴线排不下时如何换行。
	- `nowrap`（默认），不换行，当不能再收缩时，内容会溢出。
	- `wrap`：换行，第一行在上方，该属性会将盒子划分为n等份，n是父盒子宽高和子盒子排列行数共同作用的结果，例如当父盒子为100像素宽高，子盒子为25像素宽高时，子盒子有7个，则第一排放四个，并且将高分为两份，上下同为50像素，剩余三个子盒子会在下面左对齐显示。
	- `wrap-reverse`：换行，第一行在下方。
- `flex-flow`该属性为`flex-direction`和`flex-wrap`的复合属性，默认值为`row nowrap`。
- `justify-content`该属性定义了弹性盒子在主轴的对齐方式。
	-  `flex-start`（默认值）：左对齐
	-  `flex-end`：右对齐
	-  `center`： 居中
	-  `space-between`：两端对齐，项目之间的间隔都相等。
	-  `space-around`：每个子盒子两侧的间隔相等。所以，子盒子之间的间隔是边框间隔的两倍。
	- ![[justify-content.png]]
- `align-items`属性定义项目在侧轴上如何对齐。
	-  `flex-start`：侧轴的起点对齐，侧轴如果是Y轴则是从上方对齐，侧轴如果是X轴则是从左侧对齐。
	-  `flex-end`：侧轴的终点对齐。侧轴如果是Y轴则是从下方对齐，侧轴如果是X轴则是从右侧对齐。
	-  `center`：侧轴的中点对齐。
	-  `baseline`: 项目的第一行文字的基线对齐。
	-  `stretch`（默认值）：如果父元素未设置高度或设为auto，将子元素占满整个容器的高度。
- `align-content`属性定义了多根轴线的对齐方式。
	-  `flex-start`：与侧轴的起点对齐。
	-  `flex-end`：与侧轴的终点对齐。
	-  `center`：与侧轴的中点对齐。
	-  `space-between`：如果主轴是X轴，则将每行的子元素平均间隔，两端对齐无间隔。
	-  `space-around`：如果主轴是X轴，则将每行的子元素平均两倍间隔，两端有单倍间隔，相当于`padding`的效果。
	- `space-evenly`：如果主轴是X轴，则将每行的子元素平均间隔，两端同样有相等的间隔。

==注意：FFC布局中，float、clear、vertical-align属性不会生效。==

#### 该属性是给子元素设置的
-   `order:`属性定义项目的排列顺序。数值越小，排列越靠前，默认为**0**。
-   `flex-grow:`属性定义项目的放大比例，默认为**0**，即如果存在剩余空间，也不放大。
	- 如果所有项目的`flex-grow`属性都为1，则它们将等分剩余空间（如果有的话）。如果一个项目的`flex-grow`属性为2，其他项目都为1，则前者占据的剩余空间将比其他项多一倍。
-   `flex-shrink:`属性定义了项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。
	- 如果所有项目的`flex-shrink`属性都为1，当空间不足时，都将等比例缩小。如果一个项目的`flex-shrink`属性为0，其他项目都为1，则空间不足时，前者不缩小。
-   `flex-basis:`属性定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为`auto`，即项目的本来大小。
	- 它可以设为跟`width`或`height`属性一样的值（比如350px），则项目将占据固定空间。
-   `flex:`属性是`flex-grow`, `flex-shrink` 和 `flex-basis`的简写，默认值为`0 1 auto`。后两个属性可选。
	- 该属性有两个快捷值：`auto` (`1 1 auto`) 和 none (`0 0 auto`)。
	- 建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。
-   `align-self:`属性允许单个项目有与其他项目不一样的对齐方式，可覆盖`align-items`属性。默认值为`auto`，表示继承父元素的`align-items`属性，如果没有父元素，则等同于`stretch`。
	-  `flex-start`：侧轴的起点对齐，侧轴如果是Y轴则是从上方对齐，侧轴如果是X轴则是从左侧对齐。
	-  `flex-end`：侧轴的终点对齐。侧轴如果是Y轴则是从下方对齐，侧轴如果是X轴则是从右侧对齐。
	-  `center`：侧轴的中点对齐。
	-  `baseline`: 项目的第一行文字的基线对齐。
	-  `stretch`（默认值）：如果父元素未设置高度或设为auto，将子元素占满整个容器的高度。

==不懂可到该网址查询
http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html

## GFC （网格布局格式化上下文）
- `GFC(GridLayout Formatting Contexts)`直译为"**网格布局格式化上下文**"（是CSS3.0的新增布局：所以该属性的兼容性问题较大），当为一个元素设置`display`为`grid`的时候，此元素将会获得一个独立的渲染区域，即块级元素，当为一个元素设置`display`为`inline-grid`的时候，此元素将会获得一个行内块元素的渲染区域。

| 属性                    | 描述                                                           |
| ----------------------- | -------------------------------------------------------------- |
| `grid-template`         | 是复合写法                                       |
| `grid-auto-rows`        | 指定行的自动尺寸                                               |
| `grid-template-rows`    | 定义网格布局中的行的数量                                       |
| `grid-auto-columns`     | 指定列的自动尺寸                                               |
| `grid-template-columns` | 定义网格布局中的列的数量                                       |
| `grid-template-areas`   | 用于设置网格布局                                               |
| `grid-auto-flow`        | 指定自动布局怎么运作，精准指定在网格中被自动布局的元素怎么运作 |
| `grid-gap`              | 设置网格单元格之间的间隙，是行和列的复合写法，                                                               |
| `grid-row-gap`          | 设置网格列之间的间隙                                           |
| `grid-column-gap`       | 设置网格行之间的间隙                                           |

- `grid-template`是一种复合写法
	-   `grid-template-rows`定义容器的行属性
		- 
	-   `grid-template-columns`
	-  `grid-template-areas`