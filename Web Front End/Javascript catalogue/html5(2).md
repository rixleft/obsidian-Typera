# HTML5第2天

## 一、HTML5

### 1.1 音频

音频常用API

play 播放

pause 暂停

duration 总时长

currentTime 当前时长

volume 音量（0-1之间的数）

muted 静音

### 1.2 视频

视频常用API

play 播放

pause 暂停

duration 总时长

currentTime 当前时长

volume 音量（0-1之间的数）

muted 静音
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>Document</title>  
    <style>  
    /* body {  
        background-color: #efefef;  
    } */  
    .range {  
        width: 400px;  
        margin: 30px;  
        height: 10px;  
        background-color: grey;  
        position: relative;  
    }  
    .inner {  
        height: 100%;  
        width: 0;  
        background-color: #ddd;  
    }  
    .btn {  
        width: 20px;  
        height: 20px;  
        border-radius: 50%;  
        background-color: green;  
        position: absolute;  
        top: -5px;  
        left: 0;  
    }  
    </style>  
</head>  
<body>  
    <!-- <video src="./video/1.mp4" controls></video> -->  
    <video src="../../40 git/movie/01 git.mp4" controls width="1000"></video>  
    <button class="btn1">播放</button>  
    <button class="btn2">暂停</button>  
    <button class="btn3">静音</button>  
    <button class="btn4">调高音量</button>  
    <button class="btn5">调低音量</button>  
    <div class="range">  
        <div class="inner"></div>  
        <div class="btn"></div>  
    </div>  
<script>  
var video = document.querySelector('video');  
var btn = document.querySelector('.btn')  
var inner = document.querySelector('.inner')  
var range = document.querySelector('.range')  
var btn1 = document.querySelector('.btn1')  
var btn2 = document.querySelector('.btn2')  
var btn3 = document.querySelector('.btn3')  
var btn4 = document.querySelector('.btn4')  
var btn5 = document.querySelector('.btn5')  
​  
// console.log(audio.muted);  
btn.onmousedown = function(e) {  
    // 获取点击的位置  
    var startX = e.clientX;  
    // 当前偏移量  
    var left = btn.offsetLeft;  
    // 获取容器宽度  
    var width = range.clientWidth;  
    // 移动  
    document.onmousemove = function(e) {  
        // 获取最终的位置  
        // 移动的距离（当前位置 - 起始位置） + 起始的偏移量  
        var end = e.clientX - startX + left;  
        // 判断边界值  
        if (end < 0) {  
            end = 0;  
        } else if (end > width) {  
            end = width;  
        }  
        // 设置样式  
        btn.style.left = end + 'px';  
        inner.style.width = end + 'px';  
        // 百分比  
        var persent = end / width;  
        // 设置进度  
        video.currentTime = video.duration * persent;  
    }  
}  
document.onmouseup = function() {  
    // 取消移动  
    document.onmousemove = null;  
}  
// 播放  
btn1.onclick = function() {  
    video.play();  
}  
// 暂停  
btn2.onclick = function() {  
    video.pause();  
}  
// 静音  
btn3.onclick = function() {  
    // 切换静音  
    video.muted = !video.muted;  
}  
// 调高音量  
btn4.onclick = function() {  
    // console.log(video.volume);  
    // 获取音量  
    var volume = video.volume * 10;  
    // 调高  
    volume++;  
    // 还原  
    volume /= 10;  
    // 判断边界  
    if (volume > 1) {  
        volume = 1;  
    }  
    // 设置音量  
    video.volume = volume;  
}  
// 调低音量  
btn5.onclick = function() {  
    // 获取音量  
    var volume = video.volume * 10;  
    // 调低音量  
    volume--;  
    // 还原  
    volume /= 10;  
    // 最小值  
    if (volume < 0) {  
        volume = 0;  
    }  
    // 设置音量  
    video.volume = volume;  
}  
</script>  
</body>  
</html>
```


### 1.3 拖拽

ondrag: 拖拽

当拖拽图片的虚影移动的时候加快该事件的触发频率（是一个高频事件）

ondragenter: 拖拽进入（原位置）

ondragleave: 拖拽离开（原位置）

ondragstart: 拖拽开始

ondragend: 拖拽结束

ondragover：悬浮

ondrop: 丢弃事件。

注：dargover事件中的默认行为阻止了ondrop事件，ondrop事件默认不能够执行，

所以要给一个元素添加该事件，必须要给该元素添加ondragover事件并阻止默认事件
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>Document</title>  
</head>  
<body>  
    <img src="./img/1.png" alt="" class="item1">  
    <img src="./img/trash.png" alt="" class="item2">  
<script>  
// 获取图片  
var img = document.querySelector('.item1');  
var trash = document.querySelector('.item2');  
/*****  
 *  拖拽图片  
 *      按下鼠标开始拖拽：  dragstart  
 *      鼠标引入当前图片所在位置：  dragenter  
 *      鼠标离开当前图片所在位置：  dragleave  
 *      按下鼠标移动图片：  drag  
 *      松开鼠标放弃拖拽：  dragend  
 *   
 *      元素悬浮再一个元素上：  dragover  
 *      再改元素行松开图片：    drop  
 *  传递数据  
 *      拖拽开始，可以通过dataTransfer.setData方法存储数据  
 *      丢失时候，可以通过dataTransfer.getData方法读取数据  
 * ******/   
// img绑定拖拽事件  
img.ondrag = function(e) {  
    console.log(111, 'drag', e);  
      
}  
// 拖拽开始  
img.ondragstart = function(e) {  
    console.log(222, 'ondragstart', e);  
    // 传递数据  
    e.dataTransfer.setData('color', 100)  
}  
// // 拖拽结束  
img.ondragend = function(e) {  
    console.log(333, 'ondragend', e);  
}  
// // 拖拽进入  
// img.ondragenter = function(e) {  
//     console.log(444, 'ondragenter', e);  
// }  
// // 拖拽离开  
// img.ondragleave = function(e) {  
//     console.log(555, 'ondragleave', e);  
// }  
// 拖拽悬浮  
trash.ondragover = function(e) {  
    // console.log(666, 'ondragover', e);  
    // 想触发drop事件，必须定义悬浮事件并且阻止的默认行为  
    e.preventDefault();  
    // 阻止冒泡不行  
    // e.stopPropagation();  
}  
// 丢弃  
trash.ondrop = function(e) {  
    console.log(777, 'ondrop', e);  
    console.log(e.dataTransfer.getData('color'));  
      
}  
</script>  
</body>  
</html>
```


### 1.4 服务器

简单来说就是可提供服务的机器（响应）

这个服务器可以租、可以买、可以下载一些模拟软件

我们选择自己搭建的Nodejs。如果想要使用Nodejs,需要下载应用程序

平时我们查看的地址栏： file:// ……

有了服务器之后的地址栏：http:// ……

nodejs运行服务器：node app.js

服务器根路径：启动node时候，所在的路径。查找文件，直接在该路径下寻找

本地服务器：localhost 相当于baidu.com

http协议服务器默认端口号：80，https协议服务器默认端口号：443，地址栏中可以省略

### 1.5 http

HTTP：超文本传输协议，里面规定了前端如何向后端发送请求，后端如何返回数据，前端如何接收数据

当有了服务器之后，我们可以发送http请求，来请求服务器中的资源

在很久之前，浏览器的目的只是为了渲染静态页面，此时面临一个问题：前端发送请求，后端如何接收，后端返回数据，前端如何解析。于是为了解决这些问

题，HTTP就出现了

例如：前端想要请求一张图片到服务器端，此时，要按照HTTP协议中的规定，去发送请求，后端接收请求，并在返回数据的时候，要按照HTTP协议中规定按照正

确的格式返回数据

另外，服务器可连接的数量是有限的，比如一个服务器的连接数量是10， 此时，前端发送过来一个请求，并且还是有状态的（持久连接），服务器的连接数量最

多只有10个，但是在当时浏览器只是为了渲染静态页面，所以没有必要是有状态的（持久连接），所以特意给HTTP设置为无状态（没有持久连接）

连接过程：

浏览器端发送HTTP请求，请求服务器中的资源，服务器得到响应，返回数据，断开连接

由于断开了连接，所以服务器可连接的数量远大于有状态的连接

浏览器接收数据，并渲染页面

服务器最大的作用是可以提供服务器环境

在前端很多时候要用到服务器环境

比如：事件推送，多线程，ajax、canvas相关功能都需要使用 服务器环境

### 1.6 多线程

js是单线程，意味着在同一时间只能做一件事情

当js在执行的时候，页面是停止渲染的状态

我们希望在js大量计算的时候阻塞当前线程

于是H5中提供了一个叫做 Worker函数，用于开辟一个额外的线程

### 1.7 worker

该方法用于开辟一个额外的线程。其使用方式：

1 将要大量计算的代码提取到一个js文件中

2 要初始化Worker函数

var worker = new Worker(path)

path: 要提取出来的js文件

特点： 需要服务器环境支持

当页面打开的时候直接可以看到，在额外的线程执行完毕之后，其它语句已经执行
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>Document</title>  
</head>  
<body>  
    <h1>hello</h1>  
<!-- 直接引入外部文件，也会堵塞程序 -->  
<!-- <script src="./test.js"></script> -->  
<script>  
// 程序堵塞  
console.log('start');  
// 创建线程来解决 (一步)  
var work = new Worker('./test.js');  
​  
setInterval(function() {  
    console.log('111');  
}, 1000);  
setTimeout(function() {  
    // alert会中断线程  
    alert(100)  
}, 3000)  
console.log('end');  
</script>  
</body>  
</html>
```


### 1.8 **传递消息**

postMessage

该方法用于将额外线程中的数据推送到主线程中

onmessage

该方法用于主线程接收额外的线程推送过来的信息 只能传递一个参数，多个参数可以放在数组或者对象中。 具体的数据在事件对象中的data属性中
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>Document</title>  
</head>  
<body>  
    <h1>hello</h1>  
<!-- 直接引入外部文件，也会堵塞程序 -->  
<!-- <script src="./test.js"></script> -->  
<script>  
// 程序堵塞  
console.log('start');  
// 创建线程来解决 (一步)  
var work = new Worker('./test.js');  
​  
// 订阅消息  
work.onmessage = function(e) {  
    console.log(111, e.data, e, arguments);  
}  
console.log('end');  
</script>  
</body>  
</html>
```


### 1.9 事件推送

正常情况下只能够从浏览器端主动向服务器端发送请求，服务器端接收响应，返回数据之后，断开连接

想要从服务器端主动将信息推送到浏览器端，是无法实现的，于是H5中提供了EventSource的函数

来解决向浏览器端推送信息问题。

EventSource：该方法用于服务器端主动向浏览器端推送信息，并接收数据。

使用方式：var es = new EventSource(path)

path: 接口（向服务器端发送请求的地址）

特点：与Worker函数一样都需要服务器环境

我们通过es的onmessage事件监听服务器端返回的数据。
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>Document</title>  
</head>  
<body>  
    <ul></ul>  
<script>  
var ul = document.querySelector('ul');  
// 事件推送  
var es = new EventSource('/hello');  
// 监听数据返回  
es.onmessage = function(e) {  
    // console.log(e);  
    var li = document.createElement('li');  
    // 存储数据  
    li.innerHTML = e.data;  
    // 上树  
    ul.appendChild(li);  
}  
</script>  
</body>  
</html>
```


## 二、Canvas

### 2.1 canvas

canvas是HTML5新增的标签，用于提供画布

它的标准属性有width和height，例如（class、id这些都是通用标准属性）

width：表示canvas的宽

height: 表示canvas的高

在Javascript中，可以通过canvas.getContext(‘2d‘)方法获取画布上下文。

画布上下文为我们提供了大量的绘图方法。

canvas是用于显示图形的，自带了一个坐标系，默认与元素的定位坐标系是一致的位于左上角，是一个倒置的数学坐标系（与浏览器一样）

### 2.2 canvas API

在canvas中大部分都是在操作路径，所以在操作之前要开启路径

beginPath(): 用于开启路径

closePath(): 用于闭合路径。在闭合时候的点，和最开始时候的点之间会形成一条线段

fillRect(x, y, w, h)：填充矩形

x: 当前坐标系的x点 y：当前坐标系的y点

w: 矩形的宽 h：矩形的高

strokeRect(x, y, w, h)：描边矩形

x: 当前坐标系的x点 y: 当前坐标系的y点

w: 矩形的宽 h: 矩形的高

clearRect(x, y, w, h): 清除canvas上的一块区域

x: 当前坐标系的x点

y: 当前坐标系的y点

w：要清除的区域的宽

h: 要清除的区域的高

arc(x, y, r, star, end, bool)：绘制弧

x: 圆心所在的圆弧的x点

y: 圆心所在的圆弧的y点

r：表示圆弧的半径

star: 起始位置

end：终点位置

bool: 是一个布尔值，默认是false表示顺时针绘制，反之则是逆时针绘制

fill: 用于填充

stroke: 用于描边

fillStyle: 用于改变填充色

strokeStyle: 用于改变描边色

fillText: 用于绘制文字

font: 用于改变文字样式

lineWidth: 用于改变线宽

lineTo 绘制线

moveTo 移动绘制的起点
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>Document</title>  
    <style>  
    body {  
        text-align: center;  
    }  
    canvas {  
        border: 1px solid #000;  
    }  
    </style>  
</head>  
<body>  
    <canvas class="canvas" width="800" height="600"></canvas>  
<script>  
// 获取画布  
var canvas = document.querySelector('.canvas');  
// console.log(canvas);  
// 获取2d绘制上下文  
var ctx = canvas.getContext('2d');  
// console.log(ctx);  
// 绘制矩形  
// ctx.fillRect(100, 50, 200, 200);  
// ctx.strokeRect(100, 50, 200, 200);  
​  
// 绘制折线  
// ctx.beginPath();  
// // 移动到开始点  
// ctx.moveTo(100, 100);  
// // 绘制第一条线  
// ctx.lineTo(200, 100);  
// // 继续绘制线  
// // ctx.lineTo(200, 200);  
// // 结束  
// ctx.closePath();  
// // 描边  
// ctx.stroke();  
​  
// // 一条线，一条线的画  
// ctx.beginPath();  
// ctx.moveTo(200, 100);  
// ctx.lineTo(200, 200);  
// ctx.closePath();  
// // 改变颜色  
// ctx.strokeStyle = '#f00';  
// ctx.stroke();  
// 封装一个方法  
function drawLine(startX, startY, endX, endY, color) {  
    // 开始绘制  
    ctx.beginPath();  
    ctx.moveTo(startX, startY);  
    // 绘制  
    ctx.lineTo(endX, endY);  
    // 关闭绘制  
    ctx.closePath();  
    // 设置颜色  
    if (color) {  
        ctx.strokeStyle = color;  
    }  
    // 描边  
    ctx.stroke();  
}  
// 绘制折线  
// drawLine(100, 100, 200, 100);  
// drawLine(200, 100, 200, 200);  
// drawLine(500, 200, 600, 300, 'red');  
​  
// 绘制圆  
// 角度： 0~360  
// 弧度： 0~2Pi  
// ctx.arc(200, 200, 50, 0, Math.PI);  
// ctx.arc(200, 200, 50, 0, Math.PI / 2);  
// 逆时针绘制  
// ctx.arc(200, 200, 50, 0, Math.PI, true);  
// ctx.arc(200, 200, 50, 0, Math.PI / 2, true);  
// ctx.stroke();  
// 填充  
// ctx.fill();  
​  
// 绘制1/4圆  
ctx.beginPath();  
ctx.moveTo(200, 200);  
ctx.lineTo(300, 200);  
ctx.arc(200, 200, 100, 0, Math.PI / 2);  
ctx.lineTo(200, 200);  
ctx.closePath();  
// 设置线宽  
ctx.lineWidth = 10;  
// 描边  
ctx.stroke();  
// 改变填充颜色  
// ctx.fillStyle = 'green';  
// 填充  
// ctx.fill();  
​  
// 设置字体  
// ctx.font = '20px 楷体';  
ctx.font = '30px 黑体';  
// 设置字体  
ctx.fillText('hello', 100, 100)  
​  
</script>  
</body>  
</html>
```

### 2.3 绘制图片

drawImage 该方法用于绘制图片，使用方式有三种：

第一种使用方式：可以以原尺寸来绘制图片

ctx.drawImage(img, x, y)

img: 要绘制的图片

x: 以原尺寸将图片放在canvas中的x点

y: 以原尺寸将图片放在canvas中的y点

第二种使用方式： 可以缩放图片

ctx.drawImage(img, x, y, w, h)

img: 要绘制的图片

x: 将缩放后的图片放在canvas中的x点

y：将缩放后的图片放在canvas中的y点

w: 缩放后的图片的宽 h: 缩放后的图片的高

第三种方式: 截取图片中的某一部分

ctx.drawImage(img, img_x, img_y, img_w, img_h, canvas_x, canvas_y, canvas_w, canvas_h)

img: 要绘制的图片

img_x: 要截取的图片的x点 i

mg_y: 要截取的图片的y点

img_w: 要截取的图片的宽

img_h: 要截取的图片的高

canvas_x: 将截取后的图片放在canvas中的x点

canvas_y: 将截取后的图片放在canvas中的y点

canvas_w: 将截取后的图片放在canvas中的宽

canvas_h: 将截取后的图片放在canvas中的高
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>Document</title>  
    <style>  
    body {  
        text-align: center;  
    }  
    canvas {  
        border: 1px solid #000;  
    }  
    </style>  
</head>  
<body>  
    <canvas class="canvas" width="800" height="600"></canvas>  
<script>  
// 获取画布  
var canvas = document.querySelector('.canvas');  
// console.log(canvas);  
// 获取2d绘制上下文  
var ctx = canvas.getContext('2d');  
​  
// 创建图片  
var img = new Image();  
img.src = './img/byqpai2.jpg';  
​  
// 将img绘制到canvas中  
img.onload = function() {  
    // 图片，画布x，画布y  
    // ctx.drawImage(img, 100, 100)  
    // 设置图片大小(压缩或者拉伸图片)  
    // 图片，画布x，画布y，画布width， 画布height  
    // ctx.drawImage(img, 100, 100, 200, 200)  
    // 截取图片一部分绘制  
    // 图片，图片x，图片y，图片width，图片height，画布x，画布y，画布width，画布height  
    ctx.drawImage(img, 50, 50, 100, 100, 200, 200, 50, 50)  
}  
​  
</script>  
</body>  
</html>
```
