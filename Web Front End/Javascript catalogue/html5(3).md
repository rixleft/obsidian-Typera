# HTML5第3天

## 一、html5

### 1.1 坐标系变换

canvas中允许我们对坐标系做变换，类似css中的transorm

translate(x, y) 移动坐标系

x 表示水平移动

y 表示垂直方向移动

rotate(deg) 渲染坐标系

deg 表示旋转角度 单位是弧度（PI）

scale(x, y) 缩放坐标系

x 表示水平方向缩放

y 表示垂直方向缩放

大于1表示放大，小于1表示缩小。
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
// 获取2d绘制上下文  
var ctx = canvas.getContext('2d');  
​  
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
​  
function drawXY() {  
    // 绘制x轴  
    drawLine(0, 10, 780, 10)  
    drawLine(780, 10, 760, 0)  
    drawLine(780, 10, 760, 20)  
    ctx.font = '30px 楷体'  
    ctx.fillText('x轴', 720, 50)  
    // 绘制y轴  
    drawLine(10, 0, 10, 580)  
    drawLine(10, 580, 0, 560)  
    drawLine(10, 580, 20, 560)  
    ctx.fillText('y轴', 40, 550)  
}  
​  
// 移动画布  
ctx.translate(400, 300)  
// 旋转画布  
ctx.rotate(Math.PI / 4);  
// 缩小  
ctx.scale(0.5, 0.5);  
// 绘制坐标系  
drawXY();  
​  
// 绘制正方形  
// 画布一旦旋转，再绘制的时候，就参考新的画布位置了，  
ctx.fillRect(100, 100, 100, 100)  
​  
</script>  
</body>  
</html>
```

### 1.2 状态的存储与恢复

在canvas中很多时候要用到之前的状态，所以提供了相应的API用于保存cnavas上的状态

save 存储状态

restore 恢复状态

save方法可以使用多次，每save一次就好比装了一颗子弹

每restore一次，就好比扣了一次扳机
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
        /* 设置宽高是盒子的大小 */  
        /* width: 1000px;  
        height: 600px; */  
    }  
    </style>  
</head>  
<body>  
    <canvas class="canvas" width="800" height="600"></canvas>  
<script>  
// 获取画布  
var canvas = document.querySelector('.canvas');  
// 获取2d绘制上下文  
var ctx = canvas.getContext('2d');  
​  
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
​  
function drawXY() {  
    // 绘制x轴  
    drawLine(0, 10, 780, 10)  
    drawLine(780, 10, 760, 0)  
    drawLine(780, 10, 760, 20)  
    ctx.font = '30px 楷体'  
    ctx.fillText('x轴', 720, 50)  
    // 绘制y轴  
    drawLine(10, 0, 10, 580)  
    drawLine(10, 580, 0, 560)  
    drawLine(10, 580, 20, 560)  
    ctx.fillText('y轴', 40, 550)  
}  
​  
// 存储变换之前的状态  
ctx.save();  
// 移动画布  
ctx.translate(400, 300)  
// 第二次存储  
ctx.save();  
// 旋转画布  
ctx.rotate(Math.PI / 4);  
// 第三次存储  
ctx.save();  
// 缩小  
ctx.scale(0.5, 0.5);  
// 绘制坐标系  
drawXY();  
​  
// 恢复原来的状态  
ctx.restore();  
// 多次save，要多次restore恢复  
ctx.restore();  
ctx.restore();  
// 绘制正方形  
ctx.fillRect(100, 100, 100, 100)  
​  
</script>  
</body>  
</html>
```

### 1.3 像素信息

getImageData 该方法用于获取canvas上的像素信息 返回的是一个像素信息对象，该对象中有三个属性 第一个 是一个data是一个数组 第二个 是height 表示获取图像的高度 第三个 是width表示获取图像的宽度 putImageData 该方法用于将修正之后的像素信息对象重新放回canvas，三个参数分别是： 第一个参数：像素数据 第二个参数：绘制横坐标 第三个参数：绘制纵坐标
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
    <button id="btn1">去除红色通道</button>  
    <button id="btn2">去除绿色通道</button>  
    <button id="btn3">去除蓝色通道</button>  
    <button id="btn4">反色</button>  
    <button id="btn5">灰色</button>  
    <button id="btn6">透明度</button>  
    <br>  
    <canvas id="canvas"></canvas>  
<script>  
var ctx = canvas.getContext('2d');  
​  
// 加载图片  
var img = new Image();  
img.src = './img/a.png';  
img.onload = function() {  
    var width = img.width;  
    var height = img.height;  
    // 修改宽高  
    canvas.width = width * 2;  
    canvas.height = height;  
    // 绘制图片  
    ctx.drawImage(img, 0, 0)  
    // 右侧绘制  
    // ctx.drawImage(img, width, 0)  
​  
    // 去除红色通道  
    btn1.onclick = function() {  
        // 获取像素点  
        // 注意：获取图像数据要在服务器下进行  
        var result = ctx.getImageData(0, 0, width, height);  
        // 获取数据  
        var data = result.data;  
        // 每个像素点作为rgba形式存储的，红色，绿色，蓝色，透明度  
        // console.log(data);  
        // 遍历像素点  
        for (var i = 0; i < data.length; i += 4) {  
            // 四个像素点  
            // 红色 data[i]  
            // 绿色 data[i + 1]  
            // 蓝色 data[i + 2]  
            // 透明度 data[i + 3]  
            // 去除红色通道  
            data[i] = 0;  
        }  
        // 绘制到画布上  
        ctx.putImageData(result, width, 0);  
    }  
    // 去除绿色  
    btn2.onclick = function() {  
        // 获取图像数据  
        var result = ctx.getImageData(0, 0, width, height);  
        var data = result.data;  
        // 遍历  
        for (var i = 0; i < data.length; i += 4) {  
            // 去除绿色通道  
            data[i + 1] = 0;  
        }  
        // 绘制到页面中  
        ctx.putImageData(result, width, 0)  
    }  
    // 去除蓝色  
    btn3.onclick = function() {  
        // 获取图像数据  
        var result = ctx.getImageData(0, 0, width, height);  
        var data = result.data;  
        // 遍历  
        for (var i = 0; i < data.length; i += 4) {  
            // 去除绿色通道  
            data[i + 2] = 0;  
        }  
        // 绘制到页面中  
        ctx.putImageData(result, width, 0)  
    }  
    // 反色  
    btn4.onclick = function() {  
        // 获取图像数据  
        var result = ctx.getImageData(0, 0, width, height);  
        var data = result.data;  
        // 遍历  
        for (var i = 0; i < data.length; i += 4) {  
            // 反色就是每个通道值取反  
            data[i] = 255 - data[i];  
            data[i + 1] = 255 - data[i + 1];  
            data[i + 2] = 255 - data[i + 2];  
        }  
        // 绘制到页面中  
        ctx.putImageData(result, width, 0)  
    }  
    // 灰色  
    btn5.onclick = function() {  
        // 获取图像数据  
        var result = ctx.getImageData(0, 0, width, height);  
        var data = result.data;  
        // 遍历  
        for (var i = 0; i < data.length; i += 4) {  
            // 反色就是每个通道值取反  
            // data[i + 1] = data[i + 2] = data[i]  
            // 平均灰色  
            var args = (data[i] + data[i + 1] + data[i + 2]) / 3;  
            // 设置灰度  
            data[i] = data[i + 1] = data[i + 2] = args;  
        }  
        // 绘制到页面中  
        ctx.putImageData(result, width, 0)  
    }  
    // 透明度  
    btn6.onclick = function() {  
        var result = ctx.getImageData(100, 100, 200, 200);  
        var data = result.data;  
        // 半透明度  
        for (var i = 0; i < data.length; i += 4) {  
            // 透明度  
            data[i + 3] /= 2;  
        }  
        ctx.putImageData(result, width, 0);  
    }  
}  
​  
</script>  
</body>  
</html>
```

### 1.4 融合

所谓的融合，就是在canvas中新图形和原有图形之间的覆盖方式。 默认情况下，新图形覆盖原有图片 通过ctx.globalCompositeOperation属性设置 source-over 默认。在目标图像上显示源图像。 source-top 在目标图像顶部显示源图像。源图像位于目标图像之外的部分是不可见的。 source-in 在目标图像中显示源图像。只有目标图像内的源图像部分会显示，目标图像是透明的。 source-out 在目标图像之外显示源图像。只会显示目标图像之外源图像部分，目标图像是透明的。

destination-over 在源图像上方显示目标图像。 ​ destination-atop 在源图像顶部显示目标图像。源图像之外的目标图像部分不会被显示。 ​ destination-in 在源图像中显示目标图像。只有源图像内的目标图像部分会被显示，源图像是透明的。 ​ destination-out 在源图像外显示目标图像。只有源图像外的目标图像部分会被显示，源图像是透明的。 ​ lighter 显示源图像 + 目标图像。 ​ copy 显示源图像。忽略目标图像。 ​ xor 使用异或操作对源图像与目标图像进行组合。
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
    <canvas id="canvas" width="800" height="600"></canvas>  
<script>  
var ctx = canvas.getContext('2d');  
// 画布宽高  
var width = canvas.width;  
var height = canvas.height;  
​  
ctx.beginPath();  
ctx.arc(300, 300, 100, 0, Math.PI * 2);  
ctx.closePath();  
ctx.fillStyle = 'green';  
ctx.fill();  
​  
// 融合  
// 目标图像在原图像上面  
ctx.globalCompositeOperation = 'sourse-over'  
// 保留叠加部分  
ctx.globalCompositeOperation = 'source-in'  
ctx.globalCompositeOperation = 'source-top'  
// 源图像之外的部分显示  
ctx.globalCompositeOperation = 'source-out'  
// 源图像在上面  
ctx.globalCompositeOperation = 'destination-over'  
// 显示叠加区域  
ctx.globalCompositeOperation = 'destination-in'  
// 目标图像外面显示了  
ctx.globalCompositeOperation = 'destination-out'  
// 颜色叠加  
ctx.globalCompositeOperation = 'lighter'  
ctx.globalCompositeOperation = 'xor'  
​  
// 第二个圆  
ctx.beginPath();  
ctx.arc(400, 300, 100, 0, Math.PI * 2);  
ctx.closePath();  
ctx.fillStyle = 'orange';  
ctx.fill();  
​  
​  
</script>  
</body>  
</html>
```
