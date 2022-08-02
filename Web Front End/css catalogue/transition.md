### 过渡 transition
过渡是一个复合属性，它包括持续时间，哪个属性存在过渡，延迟时间，运动曲线方式等。

例如：以下表示，当鼠标经过时，`<p>`标签的宽度会变成200像素，背景颜色会变成粉红色，两种方式实现的效果是一样的。
```html
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
		    /*第一种方式*/
         p {
            width: 100px;
            height: 50px;
            background: red;
            transition: 1s width 1s ease;
        } 
	        /*第二种方式*/
        p {
            width: 100px;
            height: 50px;
            background: red;
            transition-duration: 1s;
            transition-property: width;
            transition-delay: 1s;
            transition-timing-function: ease;
        }
        p:hover {
            width: 200px;
            background: pink;
        }
    </style>
</head>
<body>
    <p></p>
</body>
</html>
```

- transition-duration
	- 表示持续时间
- transition-property
	- 表示对某个属性执行过渡属性，复合写法可以这样写
	- `transition: 1s width,1s background 1s;`，表示对盒子的宽度属性执行过渡，时间为一秒，对背景属性执行过渡，延迟一秒进行，时间为一秒。
- transition-delay
	- 表示延迟时间

- transition-timing-function:
	- `transition-timing-function:steps(number-of-steps,direction);`
		- 这个函数叫做阶梯函数，这个函数能够起到定格动画的效果。阶梯函数不像其他定时函数那样，平滑的过渡，而是以帧的方式过渡。
		- 他有两个参数
			- `number-of-steps` ：阶梯数（必须是一个正整数），他将动画的总时长按照阶梯数等距划分。
			- `direction` ：可选值为start或end，默认end，也可以不写；start表示动画的第一帧会被立即执行,直接从第二帧开始，然后以第一帧结束；end则表示动画从第一帧开始到正常结束。
	- `transition-timing-function:linear;`
		- 规定以相同速度开始至结束的过渡效果（等于 cubic-bezier(0,0,1,1)）。
	- `transition-timing-function:ease;`
		- 规定慢速开始，然后变快，然后慢速结束的过渡效果（cubic-bezier(0.25,0.1,0.25,1)）。
	- `transition-timing-function:ease-in`
		- 规定以慢速开始的过渡效果（等于 cubic-bezier(0.42,0,1,1)）。
	- `transition-timing-function:ease-out`
		- 规定以慢速结束的过渡效果（等于 cubic-bezier(0,0,0.58,1)）。
	- `transition-timing-function:ease-in-out;`
		- 规定以慢速开始和结束的过渡效果（等于 cubic-bezier(0.42,0,0.58,1)）。
	- **指定速度曲线==立方贝塞尔曲线==函数**
		- `transition-timing-function:cubic-bezier(n,n,n,n);`
		- 在 cubic-bezier 函数中定义自己的值。可能的值是 0 至 1 之间的数值。


## 逐帧动画
```html
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        #pic {
            margin: 100px auto;
            height: 90px;
            width: 65px;
            background-position: -40px -44px;
            background-image: url("https://static.runoob.com/images/mix/space-to-top.png");
            animation: .6s go steps(7) infinite;
        }
        @keyframes go {
            0% {
                background-position-x: -40px;
            }
            100% {
                background-position-x: -1040px;
            }
        }
    </style>
</head>
<body>
    <div id="pic"></div>
</body>
</html>
```