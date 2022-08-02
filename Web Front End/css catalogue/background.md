| 属性                    | 属性值                                                                        |
| ----------------------- | ----------------------------------------------------------------------------- |
| `background`            | 简写属性，作用是将背景属性设置在一个声明中。                                      |
| `background-color`      | 设置元素的背景颜色.                                                      |
| `background-image`      | 把图像设置为背景。                                                                    |
| `background-repeat`     | 设置背景图像是否及如何重复。                                    |
| `background-attachment` | 背景图像是否固定或者随着页面的其余部分滚动。                                                            |
| `background-position`   | 设置背景图像的起始位置。                                         |
| `background-size`       | contain 当高度和宽度都不能缩放时停止， cover 当高度或宽度有一个不能缩放时停止 |
| `background-origin`     | 背景图片的起点，与背景裁切同时使用，border-box padding-box content-box        | 
| `background-clip`       | border-box padding-box content-box                                            |

## background
是背景的复合属性，包括{color image repeat position attachment} 
支持一个元素同时设置多张背景图片，中间用逗号隔开。
`background:url(地址),url(地址);`
如果同时存在背景颜色，背景颜色一定要放在最后，可以是最后一个背景图片的前面（逗号之后），也可以是所有属性的最后。
`background:url(地址),#f00 url(地址);`
`background:url(地址),url(地址) #f00;`

## background-color
- 可以使用十六进制数或者RGB或者英文单词。


## background-image
- `background-image:url(地址)`
- 默认情况下，`background-image`放置在元素的左上角，并在垂直和水平方向重复平铺。

### 线性渐变
- **用该属性可以实现背景颜色渐变的效果，也可以用复合属性`background`**
	- 为了使该属性能够正常使用，会在属性前加上兼容前缀
		- -webkit-  谷歌浏览器 苹果浏览器
		- -moz-   火狐浏览器
		- -ms-  ie浏览器
		- -o-   欧朋浏览器
	- `background-image: gradient(linear, left top, right bottom,from(red),to(yellow));`
		- 表示线性渐变，从左上角到右下角，红色到黄色的渐变效果。
		- **注意，该写法并不是所有浏览器都支持，建议写以下这种写法。**
	- `background-image: linear-gradient(起点, 终点,from(颜色1),to(颜色2));`
	
	- **注意：这两种写法都不支持写具体的像素值，只支持英文方位词。但可以支持百分比写法。**
	- `background-image:-webkit-gradient(linear, 40% 10%, 60% 50%, from(red), to(yellow));`
	- `background-image:-webkit-linear-gradient(red 40% 10%, yellow 60% 50%);`
	- **注意：沿着该百分比划线后，渐变效果是以该线段的垂直方向为界的，并不是沿着该线段渐变**
	- **注意：渐变的颜色属性值可以设置n个。
- 线性渐变重复
	- `repeating-linear-gredient(90deg,red 0px,red 10px,yellow 10px,yellow 20px)`
```html
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
	    div {
		   background-image:-webkit-linear-gradient(red, yellow, blue);
		   /* 从上到下，蓝色渐变到红色 */ 
		   background-image:-webkit-linear-gradient(blue, red); 
		   /* 渐变轴为45度，从蓝色渐变到红色 */ 
		   background-image:-webkit-linear-gradient(45deg, blue, red);
		   /* 从右下到左上、从蓝色渐变到红色 */ 
		   background-image:-webkit-linear-gradient(left top, blue, red); 
		   /* 从下到上，从蓝色开始渐变、到高度40%位置是绿色渐变开始、最后以红色结束 */ 
		   background-image:-webkit-linear-gradient(0deg, blue, green 40%, red);
		    /* 从宽度的40%到60%，高度的10%到50%渐变 */
						    /*第一种写法*/
           background-image: -webkit-gradient(linear, 40% 10%, 60% 50%, from(red), to(yellow));
				           /*第二种写法*/
           background-image: -webkit-linear-gradient(red 40% 10%, yellow 60% 50%);
			           /*红色黄色以10像素的间隔垂直方向交替出现*/
           repeating-linear-gredient(90deg,red 0px,red 10px,yellow 10px,yellow 20px);
	    }
    </style>
</head>
<body>
	<div>盒子</div>
</body>

</html>
```

### 径向渐变
- 径向渐变可以制作椭圆和圆形的渐变效果
	- 在盒子==宽高==不同的情况下，可使用以下代码做出椭圆渐变的效果，在盒子宽高相同的情况下，效果为圆形。
		- `background: radial-gradient(red,yellow,blue);`
		- 可设置多个颜色
	- 而想要在任何情况下都为圆形，可以使用以下代码
		- `background: radial-gradient(circle,red,yellow,blue);`
	- 同时，想要改变渐变的起点，可以给径向渐变设置方位。
		- `background: radial-gradient(circle at 30px 10px,red,yellow,blue);`
	- 也可以使径向渐变重复，椭圆和圆形都可以。
		- 盒子为长方形时，该效果为椭圆重复。
			- `background: repeating-radial-gradient(red 0px,red 10px, yellow 10px,yellow 20px)`
		- 不论盒子是什么形状，该效果为圆形重复。
			- `background: repeating-radial-gradient(circle, red 0px,red 10px, yellow 10px,yellow 20px)`



## background-attachment

## background-position
- `background-position-x`调整背景图片的X轴坐标，向右为正方向，向左为负方向。
- `background-position-y`调整背景图片的X轴坐标，向下为正方向，向上为负方向。

## background-size

- `background-size:100px;`一个值是设置图片的宽度，将图片等比例缩放。
- `background-size:100px 200px;`两个值 第一个代表图片的宽度，第二个代表图片的高度。
- `background-size:contain;`等比例缩放，当高度宽度都不能缩放时停止。
- `background-size:cover;`等比例缩放，当宽度高度有一个不能缩放时停止。

## background-origin
**默认情况下，背景颜色从border区域加载 ，背景图片从padding区域加载，但盒子左边框和上边框的图片是背景图片平铺的效果，当取消背景图片平铺后，左边框和上边框的背景区域不显示图片，想要使得边框区域显示背景图片，必须设置该属性。**

背景图片的显示起点
 - border-box 边框区域
 - padding-box内填充区域
 - content-box 内容区域
 
## background-cilp
背景图片的裁切区域
 - border-box 边框区域
 - padding-box内填充区域
 - content-box 内容区域


==注意：background-clip 与backgorund-origin 要用就一起使用，要么就都不用，值必须是相同的==


\[sdgsg ]