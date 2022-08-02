## visibility

visibility属性是指定义一个元素是否可见，隐藏时，它会占有页面上的空间，它的属性值有：

`visible`默认值，元素是可见的。
`hidden`隐藏，元素是不可见的。
`collapse`，当在表格元素中使用时，此值可以删除一行或一列，但是它不会影响表格的布局，被行或者列占据的空间会留给其他内容使用，如果此值被用在其他的元素上，会呈现为`hidden`。
`inherit`规定应该从父元素继承visibility属性的值。
       
## display
display也可以实现隐藏的效果，使用none和block属性值。
| 属性值             | 描述                                                    |
| ------------------ | ------------------------------------------------------- |
| none               | 此元素不会被显示                                        |
| block              | 此元素将会显示为块元素，此元素前后会带有换行符          |
| Inline             | 默认值，此元素会被显示为内联元素，元素前后没有换行符    |
| inline-block       | 行内块元素                                              |
| list-item          | 此元素会作为列表显示                                    |
| run-in             | 此元素会根据上下文作为块级元素或内联元素显示            |
| table              | 此元素会做为块级表格来显示，表格前后带有换行符          |
| inline-table       | 此元素会作为内联元素来显示，表格前后没有换行符          |
| table-row-group    | 此元素会作为一个或多个行的分组来显示（类似`<tbody>`）   |
| table-header-group | 此元素会作为一个或多个行的分组来显示（类似`<thead>`）   |
| table-footer-group | 此元素会作为一个或多个行的分组来显示（类似`<tfoot>`）   |
| table-row          | 此元素会作为一个表格行显示（类似`<tr>`）                |
| table-column-group | 此元素会作为一个或多个列的分组来显示（类似`<colgroup>`) |
| table-column       | 此元素会作为一个单元格列显示（类似`<col>`）                                                         |
| table-cell         | 此元素会作为一个表格单元格显示（类似`<tr>`和`<th>`）                                                         |
| table-caption      | 此元素会作为一个表格标题显示（类似`<caption>`）                                                         |
| inherit            | 规定应该从父元素继承display属性的值                                                        |
### 注意点
display：none 可以隐藏某个元素，而且不占用原有的位置，也就是说原本占用的空间也会从页面布局中消失。
visibility：hidden 会隐藏元素但但是同时保留原有的位置，也就是说，虽然元素被隐藏了，但是仍会影响布局。
```html
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        body {
            background: #999;
        }
        .nav {
            height: 50px;
        }
        .nav ul {
            width: 1000px;
            height: 50px;
            background: pink url(./shu.png) no-repeat right center;
            margin: 0 auto;
            position: relative;
        }
        .nav ul li {
            float: left;
            list-style: none;
            width: 142px;
            text-align: center;
            line-height: 50px;
            background: url(./shu.png) no-repeat left center;
            color: #fff;
        }
        .nav ul li:hover {
            background: orange url(./shu.png) no-repeat left center;
        }
        .nav ul li div {
            position: absolute;
            display: none;
            background: blue;
        }
        .nav ul li:hover div {
            display: block;
            transition: 1s;
        }
    </style>
</head>
<body>
    <div class="nav">
        <ul>
            <li>
                账户服务
                <div>1111</div>
            </li>
            <li>
                账户服务
                <div>2222</div>
            </li>
            <li>
                账户服务
                <div>3333</div>
            </li>
            <li>
                账户服务
                <div>444</div>
            </li>
            <li>
                账户服务
                <div>555</div>
            </li>
            <li>
                账户服务
                <div>6666</div>
            </li>
            <li>
                金融市场
                <div>777</div>
            </li>
        </ul>
    </div>
</body>
</html>
```

## opacity
opacity：透明度  值为0-1之间。  1为不透明 0为透明，当元素设置透明度设置为0时，可以实现隐藏的效果，同时会保留位置。
注意：opacity ie的低版本不支持  
解决办法  filter:alpha(opacity=值) 值0-100
```css
	<!--第一种方式-->
	div {
        width: 100px;
        height: 100px;
        background: firebrick;
        opacity: 0;
	}
	<!--低版本浏览器支持此种方式-->
    div {
        width: 100px;
        height: 100px;
        background: firebrick;
        filter: alpha(opacity=0);
    }   
```
但使用opacity时，盒子里面的内容也会跟着透明，而rgba设置背景透明不会对里面的内容产生影响。

## backface-visibility
隐藏元素的背面

