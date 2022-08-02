## 盒子阴影
`box-shadow: h-shadow v-shadow blur spread color inset;
- `h-shadow` 水平偏移值  正值向右  负值向左
- `v-shadow` 垂直偏移值  正值向下  负值向上
- `blur` 阴影的模糊半径  不能为负值
- `spread` 阴影的缩放  正值放大  负值缩小
- `color` 阴影的颜色  RBG或者十六进制颜色或英文
- 阴影的位置  默认是`outset`(外阴影) `inset`是内阴影
	- 但必须注意：写`box-shadow:h-shadow v-shadow blur spread color outset`会报错，默认值是该值，但是它不是属性值，不可以写。

- **阴影不会占据空间，一个盒子可以设置多个阴影，中间用逗号隔开，若阴影重叠，则采取就近原则，谁后写谁生效。**
- **盒子的边框可以使用阴影制作，只需要将缩放属性值扩大就可以了，这样还不会占据空间。**

## 文字阴影
`text-shadow:h-shadow v-shadow blur spread color`
- `h-shadow` 水平偏移值 正值向右  负值向左
- `v-shadow` 垂直偏移值 正值向下  负值向上
- `blur` 阴影的模糊半径 不能为负值
- `color` 阴影的颜色 RBG或者十六进制颜色或英文

**文字的阴影同样不会占空间，也可以设置多个阴影，但和盒子阴影不同的是，文字阴影没有缩放属性。**


# 倒影
- `box-reflect:`
	- `box-reflect:below`
	- `box-reflect:above`
	- `box-reflect:left`
	- `box-reflect:right`
- 倒影并不影响布局，也不会占有标准流的位置。
- 为了使浏览器兼容，需要加兼容前缀。
	-  -webkit-  谷歌浏览器 苹果浏览器
	- -moz-   火狐浏览器
	- -ms-  ie浏览器
	- -o-   欧朋浏览器
下面一段代码表示给`<h1>`标题添加倒影，倒影从左上到
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
        h1 {
            text-align: center;
            margin-top: 50px;
            font-size: 50px;
            line-height: 1;
            -webkit-box-reflect:below 10px -webkit-gradient(linear,left top,left bottom,from(transparent),to(rgba(0,0,255,0.5)));
        }
    </style>
</head>
<body>
    <h1>文字的倒影</h1>
</body>
</html>
```
