## GFC（网格布局格式化上下文）

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
		- `grid-template-rows:repeat(number,width);`指可以分为几行，和每行的高度。
		- `grid-template-rows:1 / 3;`是指从盒子的上边的起始边线开始，指跨越了几条横向边线。
			- `grid-row-start:`指盒子的边从第几条横线开始计算，
				- `number;`可以为负值。
				- `span number;`也可以写跨越了几行。
			- `grid-row-end:`指盒子的边从第几条横线结束计算。
				- `number;`可以为负值。
				- `span number;`也可以写跨越了几行。
		- `grid-template-rows：40px;`指每列的宽度为40px。
		- `grid-template-rows:40px 1fr;`指第一行的宽度为40px，其余每列占除去40px之外的空间，每行占据1份。
	-   `grid-template-columns`定义容器的列属性
	- `grid-template-columns:repeat(number,width);`指可以分为几列，和每列的宽度。
		- `grid-template-columns:1 / 3;`是指从盒子的左边的起始边线开始，指跨越了几条纵向边线。
			- `grid-column-start:`指从盒子的边从第几条纵线开始计算。
				- `number;`可以为负值。
				- `span number;`也可以写跨越了几列。
			-  `grid-column-end:`指从盒子的边从第几条纵线结束计算。
				- `number;`可以为负值。
				- `span number;`也可以写跨越了几列。
	-  `grid-template-areas` 给建立的二维空间划分区域，
- `grid-areas:`是给子元素添加的属性，使得区域可以一一对应。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<style>
    .container {
        display: grid;
        width: calc(5 * 60px);
        height: calc(5 * 60px);
        padding: 60px;
        grid-template-rows: repeat(5, 60px);
        grid-template-columns: repeat(5, 60px);
        grid-template-areas: 
        ".  red  red  red  . "
		"yellow .  .  .  . "
		"green  .  black  black  . "
		"green  .  .  .  blue "
		".  pink pink pink . ";
    }
    .red {
        grid-area: red;
        background: red;
    }
    .yellow {
        grid-area: yellow;
        background: yellow;
    }
    .green {
        grid-area: green;
        background: green;
    }
    .pink {
        grid-area: pink;
        background: pink;
    }
    .blue {
        grid-area: blue;
        background: blue;
    }
    .black {
        grid-area: black;
        background: black;
    }
</style>
<body>
    <div class="container">
        <div class="red"></div>
        <div class="yellow"></div>
        <div class="green"></div>
        <div class="pink"></div>
        <div class="blue"></div>
        <div class="black"></div>
    </div>
</body>
</html>
```
#### 效果
![[grid.png]]
