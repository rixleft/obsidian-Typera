# JavaScript进阶 第一天


## 实例： 图片裁切效果

**原理：**

1，限制范围的拖拽

2，背景定位属性 background-attachment: fixed；

**用到的已学知识：**

1， getPos() 函数使用

2，getStyle() 函数使用

3，创建和添加 dom 节点

4，拖拽
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <title>Document</title>  
  <style>  
    #box {  
      width: 450px;  
      height: 450px;  
      border: 5px solid #333;  
      background-image: url(../images/thumb.jpg.avif);  
      position: relative;  
      margin: 100px;  
    }  
    .mask {  
      position: absolute;  
      width: 100%;  
      height: 100%;  
      background-color: #333;  
      opacity: .8;  
    }  
    #div1 {  
      width: 100px;  
      height: 100px;  
      position: absolute;  
      background-color: red;  
      z-index: 1;  
      background-image: url(../images/thumb.jpg.avif);  
      background-attachment: fixed;  
    }  
  </style>  
</head>  
<body>  
  <div id="box">  
    <div id="div1"></div>  
    <div class="mask"></div>  
  </div>  
​  
  <script>  
    var div1 = document.getElementById('div1');  
    var dot = document.createElement('div');  
    // 获取拖拽小方块的定位父级，即 box 元素  
    var parent = div1.offsetParent;  
    // 获取 parent 的边框到文档左上角的坐标  
    var pos = getPos(parent);  
    // 计算背景图片的定位位置   
    var x = pos.left + parent.clientLeft;  
    var y = pos.top + parent.clientTop;  
    // 保存小方块的原始尺寸  
    var originWidth = getStyle(div1, 'width');  
    var originHeight = getStyle(div1, 'height');  
​  
    // console.log(originWidth, originHeight);  
​  
    // 设置背景图片的定位位置   
    div1.style.backgroundPositionX = x + 'px';  
    div1.style.backgroundPositionY = y + 'px';  
​  
    // 给小方块右下角小红点设置样式  
    dot.style.cssText = "width: 10px; height: 10px; border-radius: 50%; background: red; position: absolute; bottom: -4px; right: -4px;";  
    div1.appendChild(dot);  
​  
    // 小红点拖拽改变小方块尺寸  
    dot.onmousedown = function(ev) {  
      var clientX = ev.clientX;  
      var clientY = ev.clientY;  
​  
      var w, h;  
​  
      // 取消事件默认行为 （目的是解决有时拖拽变成选中文字的BUG）  
      ev.stopPropagation();  
​  
      document.onmousemove = function(ev) {  
        var x = ev.clientX - clientX;  
        var y = ev.clientY - clientY;  
          
        // 拖拽移动小红点时，计算 小方块的宽高尺寸  
        w = originWidth + x;  
        h = originHeight + y;  
​  
        if (w < 20) {  
          w = 20;  
        }  
​  
        if (w > parent.clientWidth  - div1.offsetLeft) {  
          w = parent.clientWidth  - div1.offsetLeft;  
        }  
​  
        if (h < 20) {  
          h = 20;  
        }  
​  
        if (h > parent.clientHeight  - div1.offsetTop) {  
          h = parent.clientHeight  - div1.offsetTop;  
        }  
          
​  
        div1.style.width = w + 'px';  
        div1.style.height = h + 'px';  
​  
      };  
​  
      document.onmouseup = function() {  
        document.onmousemove = null;  
        document.onmouseup = null;  
        originWidth = w;  
        originHeight = h;  
      };  
​  
    };  
​  
    // 小方块的拖拽事件  
    div1.onmousedown = function(ev) {  
    
      var offsetX = ev.offsetX + parent.clientLeft + pos.left;  
      var offsetY = ev.offsetY + parent.clientTop + pos.top;  
        
      document.onmousemove = function(ev) {  
        var left = ev.clientX - offsetX;  
        var top = ev.clientY - offsetY;  
​  
        if (left < 0 || left > parent.clientWidth - div1.offsetWidth) {  
          left = left < 0 ? 0 : parent.clientWidth - div1.offsetWidth;  
        }  
​  
        if (top < 0 || top > parent.clientHeight - div1.offsetHeight) {  
          top = top < 0 ? 0 : parent.clientHeight - div1.offsetHeight;  
        }  
​  
        div1.style.left = left + 'px';  
        div1.style.top = top + 'px';  
      }  
​  
      document.onmouseup = function() {  
        document.onmousemove = null;  
        document.onmouseup = null;  
      }  
​  
    }  
      document.onmouseup = function() {  
        document.onmousemove = null;  
        document.onmouseup = null;  
      }  
​  
    }  
      
    function getPos(obj) {  
        var pos = {top: 0, left: 0};  
​  
        if ( !obj || obj.nodeType !== 1 ) return null;  
​  
        while (obj.offsetParent) {  
            pos.left += obj.offsetLeft;  
            pos.top += obj.offsetTop;  
​  
            obj = obj.offsetParent;  
            pos.left += obj.clientLeft;  
            pos.top += obj.clientTop;  
        }  
        return pos;  
    }  
​  
    function getStyle(obj, attr) {  
        return parseFloat( (window.getComputedStyle ? getComputedStyle(obj) : obj.currentStyle)[attr] );  
    }  
  </script>  
</body>  
</html>
```


## 高级选择器

**querySelector()** 获取匹配元素中的第一个元素，返回一个dom对象。

不论匹配的元素有多少个，都只会获取第一个

**querySelectorAll()** 获取匹配的所有元素，返回一个类数组对象

即使是只获取到一个元素，也始终返回一个类数组，必须使用下标来访问获取到的元素。

两个方法都支持所有 css2.1 和 css3 的选择器。
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
    
  <div id="div1">这是div1 <span id="txt">span标签</span></div>  
​  
  <ul>  
    <li>列表01</li>  
    <li>列表02</li>  
    <li>列表03</li>  
    <li>列表04</li>  
    <li>列表05</li>  
  </ul>  
​  
  <input type="button" value="按钮一">  
  <input type="button" value="按钮二">  
  <input type="checkbox">  
  <input type="checkbox">  
​  
  <script>  
    // querySelector() 获取第一个匹配的元素, 不论使用什么类型的选择器，都只会获取第一个选中的元素  
    var div1 = document.querySelector('#div1');  
    // 不需要使用下标访问，因为只会获取第一个li  
    var li = document.querySelector('li');  
​  
    // console.log(div1);  
    // console.log(li);  
​  
    // querySelectorAll()  获取所有匹配的元素，并始终返回一个类数组对象  
    var div = document.querySelectorAll('#div1');  
    var lis = document.querySelectorAll('ul li');  
​  
    // 即使是通过 id 方式获取到的元素，也需要使用下标，因为返回的是类数组对象  
    // console.log(div[0]);  
    // console.log(div.length);  
    // console.log(lis);  
    // console.log(lis.length);  
​  
    // 可以在任意一个DOM对象上调用该方法  
    var span = div1.querySelector('#txt');  
    // console.log(span);  
​  
    // 支持 css2.1 和 css3 的所有选择器。  
    var btn = document.querySelectorAll('[type=button]');  
    console.log(btn);  
  </script>  
​  
</body>  
</html>
```

## 鼠标滚轮事件

有兼容问题，不同浏览器事件类型不同：

**firefox 浏览器：** （目前已经被 firefox 废弃）

DOMMouseScroll 只能使用 DOM 2级 方式绑定

事件对象属性： ev.detail

**非 firefox 浏览器：**

mousewheel

事件对象属性： ev.wheelDelta

**新增标准属性：**

wheel IE9 以上浏览器才支持，并且在IE中只能使用 addEventListener() 方法绑定
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <title>Document</title>  
  <link rel='icon' href='data:image/x-icon;base64,='>  
  <style>  
    body {  
      height: 3000px;  
    }  
  </style>  
</head>  
<body>  
    
  <script>  
​  
    // 最新的标准化事件 ： wheel   
​  
    // 目前版本的 webkit 内核 和  firefox 内核浏览器都支持该方法  
    document.onwheel = function(ev) {  
      // console.log(ev);  
      // deltaY  正值表示向下滚动   负值表示向上滚动  
      console.log(ev.deltaY);  
    };  
​  
    // IE9 及以上版本IE才支持 wheel 事件，并且只能使用 addEventListener() 方式绑定  
    // document.addEventListener('wheel', function(ev) {  
    //   console.log('ie只能使用这种方式绑定', ev.deltaY);  
    // });  
​  
​  
    // 只有 firefox 浏览器支持的 非标准事件  名称必须为 DOMMouseScroll 大小写不能写错  
    // document.addEventListener('DOMMouseScroll', function(ev) {  
    //   // detail()  正值表示向下滚动,  负值表示向上滚动  
    //   console.log('firefox', ev.detail);  
    // });  
​  
​  
    // IE webkit 内核支持的 非标准事件  
​  
    //  IE 浏览器中需要将事件绑定在 document 对象上  
    // document.onmousewheel = function(ev) {  
    //   var ev = ev || event;  
    //  // wheelDelta   正值表示向上滚动   负值表示向下滚动  
    //   console.log('ie & chrome', ev.wheelDelta);  
    // };  
​  
    // chrome 浏览器中，需要将事件绑定是 window 对象上  
    // window.onmousewheel = function(ev) {  
    //   var ev = ev || event;  
    //   console.log('ie & chrome', ev.wheelDelta);  
    // };  
​  
    // document.addEventListener('mousewheel', function(ev) {  
    //   console.log(ev.wheelDelta);  
    // });  
​  
  </script>  
</body>  
</html>
```

## 键盘事件

**onkeydown** 键盘按键按下时触发

**onkeypress** 键盘按键按下后触发

**onkeyup** 键盘按键释放后触发

触发顺序 ： keydown>keypress >keyup

**onkeypress** 只能被输入型按键触发，比如 数字键，字母键；无法被功能型按钮触发，比如 ctrl , shift , alt 等。

**keycode** 按键编码，键盘的每一个按键都对应一个唯一的编码。

该编码为 Unicode 编码。

**常用功能键：** ctrlKey , shiftKey , altKey 还有对应的布尔值，按下为true, 抬起为false

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
    
<input type="text" id="text">  
​  
<script>  
​  
  var text = document.getElementById('text');  
​  
  // document.onkeydown = function(ev) {  
    // // console.log(ev);  
    // console.log(ev.keyCode);  
    // console.log( ev.ctrlKey, ev.shiftKey, ev.altKey );  
  // };  
​  
  // 只有输入型按键才会触发 onkeypress 事件  
  // document.onkeypress = function(ev) {  
  //   console.log(ev.keyCode);  
  // }  
​  
  // document.onkeyup = function(ev) {  
  //   console.log(ev);  
  // }  
​  
  // 如果阻止 onkeydown 的事件默认行为，按键并不会有内容输出。  
  text.onkeydown = function(ev) {  
    ev.preventDefault();  
    // console.log(123);  
  }  
</script>  
​  
</body>  
</html>
```

## tabindex 属性

tabindex 属性 为键盘的 tab 键设置导航顺序。

当按下 tab 键时， 会根据 tabindex 值的大小顺序从小到大依次导航。

tabindex 的值没有具体的初始值要求，也不需要一定是连续数字。

在 HTML 4.01 版本中，只有表单元素支持设置 tabindex 属性

在 HTML5 版本中，所有标签元素都可以设置 tabindex 属性。
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
​  
  <input type="text" tabindex="0">  
    
  <ul>  
    <li tabindex="7">列表01</li>  
    <li tabindex="6">列表02</li>  
    <li tabindex="1">列表03</li>  
    <li tabindex="3">列表04</li>  
    <li tabindex="2">列表05</li>  
    <li tabindex="5">列表06</li>  
    <li tabindex="4">列表07</li>  
  </ul>  
​  
  <input type="text" tabindex="100">  
​  
  <!-- 负数值是不被允许的 -->  
  <input type="text" tabindex="-10">  
​  
</body>  
</html>
```

## 实例： 钢琴效果

**原理：**

利用事件对象中， 数字的 key 值为字符串类型的 数字本身，将数字 key 值作为按键标签的下标 和 音频文件的 文件名。

按下数字 1 ~ 7 时，找到对应的 标签 添加状态，并播放对应的钢琴音频。
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <link rel='icon' href='data:image/x-icon;base64,='>  
  <title>Document</title>  
  <style>  
    #piano {  
      margin: 100px auto 0;  
      padding: 0;  
      width: 364px;  
    }  
    #piano li {  
      list-style: none;  
      width: 50px;  
      height: 300px;  
      border: 1px solid #333;  
      float: left;  
    }  
    #piano li.active {  
      background: pink;  
    }  
  </style>  
</head>  
<body>  
    
  <ul id="piano">  
    <li>1</li>  
    <li>2</li>  
    <li>3</li>  
    <li>4</li>  
    <li>5</li>  
    <li>6</li>  
    <li>7</li>  
  </ul>  
​  
  <audio src="" autoplay></audio>  
​  
  <script>  
    // 获取所有 li 标签  
    var keys = document.querySelectorAll('#piano li');  
    // 获取 audio 标签  
    var audio = document.querySelector('audio');  
​  
    document.onkeydown = function(ev) {  
​  
      // console.log(ev.key);  
​  
      // 如果按下的是数字 1 ~ 7 ， 就播放对应的音频  
      if (+ev.key > 0 && +ev.key < 8) {  
        audio.src = 'audio/' + ev.key + '.mp3';  
        keys[ev.key - 1].className = 'active';  
      }  
​  
      // console.log( ev );  
​  
    };  
​  
    // 抬起时清空状态  
    document.onkeyup = function(ev) {  
      // 判断是否有li 的下标 与 ev.key - 1 对应，如果有，就清除这个li的className  
      if (keys[ev.key - 1]) {  
        keys[ev.key - 1].className = '';  
      }  
    };  
      
  </script>  
​  
</body>  
</html>
```