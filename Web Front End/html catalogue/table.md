# 语法
### 属性
`rules`，可以给表格添加一些线条，
		all 横向与竖向
         cols 竖向
         rows 横向
         none 没有
表格的边框 `border`
表格的宽度 `width`
表格的高度 `height`
内容和边框之间的距离 `cellpadding`
单元格与单元格的间隙 `cellspacing`
设置表格的背景颜色 `bgcolor`
设置表格边框的颜色 `bordercolor`
设置表格的水平对齐方式 `align="left(默认) center right"`
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>表格</title>
</head>
<body>
    <table border="1" cellspacing="1">
        <caption>耕地保有量表格</caption>
        <tr>
            <th rowspan="3">地区</th>
            <th rowspan="2" colspan="2">2005年耕地面积</th>
            <th colspan="4">耕地保有量</th>
            <th rowspan="2" colspan="2">基本农田保护面积</th>
            <!-- <th></th> -->
            <!-- <th></th> -->
            <!-- <th></th> -->
            <!-- <th></th> -->
            <!-- <th></th> -->
        </tr>
        <tr>
            <!-- <th></th> -->
            <!-- <th></th> -->
            <!-- <th></th> -->
            <th colspan="2">2010年</th>
            <!-- <th></th> -->
            <th colspan="2">2020年</th>
            <!-- <th></th> -->
            <!-- <th></th> -->
            <!-- <th></th> -->
        </tr>
        <tr>
            <!-- <th></th> -->
            <th>万公顷</th>
            <th>万亩</th>
            <th>万公顷</th>
            <th>万亩</th>
            <th>万公顷</th>
            <th>万亩</th>
            <th>万公顷</th>
            <th>万亩</th>
        </tr>
        <tr>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
        </tr>
        <tr>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
        </tr>
        <tr>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
        </tr>
        <tr>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
            <td>123</td>
        </tr>
 </table>
</body>
</html>
```
# 效果
![[表格标签.png]]