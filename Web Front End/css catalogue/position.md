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

### 如何响应式水平垂直居中

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
```js
<!DOCTYPE html>
<html>
 
	<head>
		<meta charset="UTF-8">
		<!-- 引入ElementUI  CDN -->
		<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
		<title>水平垂直居中展示</title>
	</head>
	<style type="text/css">
		#app{
			 width: 100%;
			 margin: 50px auto;
			 /* 设置栅格布局 ， auto-fill 关键字，表示每列宽度300px,然后自动填充,直到容器不能放置更多的列*/
			 display: grid;
			 grid-template-columns: repeat(auto-fill, 300px);
		}
		.section{
			margin-left: 20px;
			margin-right: 20px;
			margin-top: 50px;
			height: 300px;
			border: 1px solid;
		}
	
		.items{
			background-color: coral;
			border-radius: 5px;
			width: 100px;
			height: 100px;
			overflow: hidden;
			text-align: center;
			font-size: 20px;
			font-weight: bold;
		}
		
		/* 	方法一:
			绝对定位方法：不确定当前div的宽度和高度，采用 transform: translate(-50%,-50%); 
			当前div的父级添加相对定位（position: relative;） */
		.section-one{
			position: relative;
		}
		.items-one{
			position: absolute;
			top: 50%;
			left: 50%;
			/* translate()函数是css3的新特性.在不知道自身宽高的情况下，可以利用它来进行水平垂直居中 */
			transform: translate(-50%,-50%);
			background-color: red;
		}
		
		/* 方法二:
			绝对定位方法:确定当前div的宽度和高度,采用margin值为当前div宽度高度一半的负值 */
		.section-two{
			position: relative;
		}
		.items-two{
			position: absolute;
			top: 50%;
			left: 50%;
			margin-left: -50px;
			margin-top: -50px;
			background-color: coral;
		}
		
		/* 方法三:
			绝对定位方法:绝对定位下top left right bottom 都设置0 ,magin:auto;*/
		.section-three{
			position: relative;
		}
		.items-three{
			width: 100px;
			height: 100px;
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			margin: auto;
			background-color: yellow;
		}
		
		/* 方法四: 
			flex布局:父元素添加flex样式 ,父元素的宽高要设置*/
		.section-four{
			display: flex;
			justify-content: center;	/* 弹性布局的左右居中对齐 */
			align-items: center;		/*弹性布局的垂直居中对齐*/
		}
		.items-four{
			background-color: greenyellow;
		}
		
		/* 方法五:
			　table-cell实现文字内容水平垂直居中 , 设置好之后margin属性失效 */
		.section-five{
			position: relative;
		}
		.items-five{
			background-color: #6495ED;
			/* 文字居中展示 */
			display: table-cell;
			vertical-align: middle;
			text-align: center;
			position: relative;
			top: 100px;
			left: 75px;
		}
		
		/* 	方法六 ：
			父元素设置:grid栅格布局,子元素  align-self: center; justify-self: center;  居中展示 */
		.section-six{
			 display: grid;
		}
		.items-six{
			align-self: center;
			justify-self: center;
		}
		
		/* 方法七
			父元素设置:grid栅格布局,align-content: center;justify-content: center; 居中展示*/
		.section-seven{
			 display: grid;
			 align-content: center;
			 justify-content: center;
		}
		.items-seven{
			background-color: powderblue;
		}
		
		/* 方法八：
			父元素设置:flex布局,子元素上使用：margin:auto; 居中展示*/
		.section-eight{
			 display: flex;
		}
		.items-eight{
			background-color: crimson;
			margin: auto;
		}
		/* 方法九：
			父元素设置:flex布局,子元素上使用：margin:auto; 居中展示*/
		.section-nine{
			 display: table;
		}
		.items-nine{
			display:table-cell;
			vertical-align: middle;
			background-color:darkcyan;
		}
		
		/* 栅格布局小方块 */
		.section-ten{
			display: grid;
			    grid-template-rows: 1fr 1fr 1fr;
			        grid-template-columns: 1fr 1fr 1fr;
		}
		.grid-item{
			text-align: center;
			line-height: 100px;
			background-color: #15231F;
			font-weight: bold;
			color: #FFFFFF;
		}
		.grid-item:nth-child(2n){
			background-color: #FFFFFF;
			color: #15231F;
		}
	</style>
 
	<body>
		<div id="app">
			<div class="section section-one">
				<div class="items items-one">1</div>
			</div>
			<div class="section section-two">
				<div class="items items-two">2</div>
			</div>
			<div class="section section-three">
				<div class="items items-three">3</div>
			</div>
			<div class="section section-four">
				<div class="items items-four">4</div>
			</div>
			<div class="section section-five">
				<div class="items items-five">
					<p>123456</p>
				</div>
			</div>
			<div class="section section-six">
				<div class="items items-six">6</div>
			</div>
			<div class="section section-seven">
				<div class="items items-seven">7</div>
			</div>
			<div class="section section-eight">
				<div class="items items-eight">8</div>
			</div>
			<div class="section section-nine">
				<div class="items items-nine">9</div>
			</div>
			<div class="section section-ten">
				<div class="grid-item">1</div>
				<div class="grid-item">2</div>
				<div class="grid-item">3</div>
				<div class="grid-item">4</div>
				<div class="grid-item">5</div>
				<div class="grid-item">6</div>
				<div class="grid-item">7</div>
				<div class="grid-item">8</div>
				<div class="grid-item">9</div>
			</div>
		</div>
 
	</body>
	<!-- 引入vue组件库 -->
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
	<!-- 引入ElementUI组件库 -->
	<script src="https://unpkg.com/element-ui/lib/index.js"></script>
	<script>
		//注册使用vue
		var Vue = window.Vue;
		var app = new Vue({
			el: '#app',
			data() {
				return {
					
				}
			},
			methods: {
			
			}
 
		})
	</script>
 
</html>
```