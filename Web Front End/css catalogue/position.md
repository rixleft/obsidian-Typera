# position
position属性指定了元素的定位类型。
当添加定位属性时，必须和`top,bottom left right`属性一起使用.
| 属性值   | 描述                                  |
| -------- | ------------------------------------- |
| static   | 静态定位 默认值                       |
| relative | 相对定位 不会破坏正常的文档流         |
| absolute | 绝对定位 会脱离正常的文档流，         |
| fixed    | 固定定位 会脱离正常的文档流，         |
| sticky   | 粘性定位 css3.0新增属性，低版本不支持 | 
常用子相父绝来布局，因为相对定位不占有位置，但又不能打乱布局，所以给父盒子添加绝对定位属性，

### relative
相对定位，是在原来位置上偏移，但仍然占有原本的位置，移动后的盒子相对于文档流会漂浮在空中，不会挤开其他盒子的位置。

### absolute
绝对定位，在父元素没有设置相对定位或绝对定位的情况下，根据离其最近的有定位的父元素进行定位(父元素的定位属性值不能为默认值 static)。如果父元素都没有定位则根据浏览器窗口的第一屏定位。

==元素在没有定义宽度的情况下，宽度由元素里面的内容决定，效果和用float方法一样==。

### fixed
固定定位，会脱离正常的文档流，导致后面的上来，根据浏览器窗口进行定位，无论是否出现滚动条都会处在给定位置不动。

### sticky
粘性定位，当达到特定条件时在给定位置不动，如一开始盒子距离顶部100px，设置`top=0`时，向下滚动，盒子距离顶部越来越近，当盒子距离页面最上方变为0时，则会固定在顶部。

演示如下：
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
        div {
            height: 300px;
            background: rebeccapurple;
            width: 1000px;
            margin: 0 auto 5px;
        }
        .top3 {
            height: 50px;
            width: 100%;
            background: red;
            position: sticky;
            top: 0;
        }
    </style>
</head>
<body>
    <div>0001</div>
    <div>0002</div>
    <div class="top3">0003</div>
    <div>0004</div>
    <div>0005</div>
    <div>0006</div>
    <div>0007</div>
    <div>0008</div>
    <div>0009</div>
    <div>0010</div>
</body>
</html>
```

## 层叠
定位会造成层叠
默认情况下 谁在后边谁在上边显示
可以通过z-index更改定位元素的显示顺序
值越大越靠上显示，值可以无穷大也可以无穷小，必须是整数   可以为负数。
注意：z-index必须与定位属性连用才能生效。
定位的元素如果设置了fixed或者absolute 之后，元素没有设置宽度高度就是内容的宽高，如果设置了就是我们设置的宽高。

### 如何响应式水平居中

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
        /*第一种方法*/
        div {
            width: 300px;
            height: 200px;
            background: red;
            position: absolute;
            left: 50%;
            top: 50%;
            margin-top: -100px;
            margin-left: -150px;
        }
         /*第二种方法*/
        div {
            width: 300px;
            height: 200px;
            background: red;
            /*下面六行代码必须都写才能居中*/
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            margin: auto;
        }
         /*第三种方法，低版本不支持，运算符前后必须存在空格，任何长度值都可以使用该函数进行计算。它支持加减乘除*/
        div {
            width: 300px;
            height: 200px;
            background: red;
            position: absolute;
            left: calc(50% - 150px);
            top: calc(50% - 100px);
        }
    </style>
</head>
<body>
        
    <div>内容</div>
</body>
</html>
	
```