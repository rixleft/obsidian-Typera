# JavaScript进阶 第二天

## 更改 this 指向

通常情况下，函数是由谁调用的，函数中的 this 指向的就是谁。

但 this 指向不是固定不变的，通过以下两个方法，可以改变函数内部的this 指向。

**call(thisObj, arg1, arg2, arg3, …, argN)** 将函数中的 this 指向 thisObj

使用： 函数名称.call(新this值, 参数2, 参数3, 参数4, …, 参数N)

第一个参数： 指定新的 this 值。

第二个参数~第N个参数： 传递给使用 call() 方法的函数的实参。

call() 应用实例： 将类数组转换成普通数组 [].slice.call(类数组对象);

**apply(thisObj, arr)** 将函数中的 this 指向 thisObj

使用： 函数名称. apply(新this值, 参数数组)

第一个参数： 指定新的 this 值。

第二个参数： 会将参数数组中的值作为实参依次传递给调用函数。

apply() 应用实例：

函数内部使用，将 fn 函数中的 this 更改为 obj, 并且将函数的实参传递给 fn 函数：

fn.apply(obj, arguments);
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
    
<script>  
​  
// this 回顾  
​  
// 全局 this 的值为 window  
// console.log(this);  
​  
// 直接调用函数， this 为 window  
// fn1();  
​  
// 通过事件调用， 事件被谁触发，this 的值就是谁  
document.onclick = fn1;  
​  
// 定时器的执行函数中的 this 为 window  
// setTimeout(function() {  
//   console.log(this);  
// },100)  
​  
function fn1() {  
  console.log(this);  
}  
​  
</script>  
​  
<script>  
​  
// 更改 this 指向  
​  
// 直接调用， this 默认为 window  
// fn2();  
​  
// 使用 call() 方法将 this 的值修改为 document  
// fn2.call(document);  
​  
// 使用 apply() 方法将 this 的值修改为 document  
// fn2.apply(document);  
​  
function fn2() {  
  console.log(this);  
}  
​  
// call() 与 apply() 的相同点： 都是用来修改函数内部的 this 指向。  
​  
​  
// call() 与 apply() 的区别： 参数数量 和 参数类型不同  
  // call() 参数有任意多个  
  // 第一个参数为指定调用 call() 方法的函数中的 this 的新值  
  // 从第二个参数到最后一个参数，都是传入调用 call() 方法的函数的实参  
  function fn3(a, b, c) {  
    console.log(this, a, b, c)     
  }  
  // this 为 dcument, a 的值为 10， b 的值为 20 , c 没有第三个实参对应，为默认值 undefined  
  fn3.call(document, 10, 20);  
  // this 为 数组 [1,2]， a 的值为'abc'， b 的值为 'hello', c 的值为 true  
  fn3.call([1,2], 'abc', 'hello', true);  
  // 数组参数直接作为一个值传入函数，并不会像 apply() 那样自动提取里面的值  
  fn3.call([1,2], [200, 300], 400);  
​  
  // apply() 只有两个参数  
  // 第一个参数为指定调用 apply() 方法的函数中的 this 的新值  
  // 第二个参数必须为数组或类数组，apply() 方法会提取数组中的值，作为函数的实参传入函数。  
  function fn4(a, b, c) {  
    console.log(this, a, b, c)     
  }  
  // 第二个参数不是数组，报错  
  // fn4.apply(document, 10, 20);  
  // 只接受两个参数，第三个参数会被忽略  
  // fn4.apply(document, [100, 300], 20);  
​  
​  
  // call() 与 apply() 实例  
​  
  var obj1 = {  
    name: "小明",  
    age: 18  
  };  
​  
  var obj2 = {  
    name: "小红",  
    age: 16,  
    say: function() {  
      console.log("我叫" + this.name + ', 今年' + this.age + '岁了。')  
    }  
  };  
​  
  // 正常调用 this.name 等同于 obj2.name  
  obj2.say();  
​  
  // 调用say()方法是，使用call() 将 say() 方法中的 this 设置为 obj1， this.name 等同于 obj1.name  
  obj2.say.call(obj1);  
​  
  var arr = [10,4,32,65,232,21];  
​  
  // 数学对象 Math 的 max() 方法，用来求多个数字中的最大数字， 参数必须是单一的数字值  
  console.log(Math.max(23,124,645,32));  
  // max() 方法默认不接受数组作为参数，会得到 NaN。  
  // console.log(Math.max(arr));  
  // 使用apply() 方法将数组拆分成单一的数字参数 （这里调用apply()方法的目的是把数组拆开，所以第一个参数可以是任何值）  
  console.log(Math.max.apply(null, arr));  
​  
      
  // 扩展知识 -- 实用函数封装 (提高练习,如果不理解,可以先略过)  
  // 测试 toArray() 函数  
  console.log(toArray({'0': 123, '1': 'abc', '2': true, 'length': 3}));  
  var arr1 = [1,2,3,4];  
  var arr2 = [5,6,7,8];  
  // 测试 mergeArray() 函数  
  console.log(mergeArray(arr1, arr2));  
      
  // 将类数组转换成数组  
  function toArray(args) {  
    // 如果传入的参数不是对象，或者没有length属性，则不是类数组  
    if ( typeof args !== 'object' || typeof args.length !== 'number') {  
      // 如果不是数组或类数组参数,则原值返回.  
      return args;  
    }  
    return [].slice.call(args);  
  }  
​  
  // 数组的 concat() 方法合并数组会产生新数组，封装 mergeArray() 方法, 将第二个数组合并到第一个数组中。  
  function mergeArray(arr1, arr2) {  
    // 如果 arr1 或 arr2 不是数组,直接返回空数组  
    if (!arr1.slice || !arr2.slice) {  
      return [];  
    }  
    return [].push.apply(arr1, arr2) && arr1;  
  }  
​  
</script>  
​  
</body>  
</html>
```


## DOM版本

DOM 历史版本变化： （了解）

1998年10月，发布 DOM1， 对应 DOM 事件0级 。

2000年11月，发布 DOM2，2003 年 1 月 更新。

2004年04月，发布 DOM3，对应 DOM 事件 2级。

2015年11月，发布 DOM4 。

DOM 事件 1级 并没有实际版本发布。

DOM 0 级事件中，给元素绑定事件只能通过 on + 事件名称的方式。

DOM 2 级事件中，新增了 addEventListener() 和 removeEventListener() 方法。

## 事件流

事件流即事件的执行流程。

事件执行一共分三个阶段：

1，捕获阶段： 事件触发时，从最顶层节点往下查找触发事件的节点。

2，执行阶段： 找到触发事件元素，执行绑定的事件处理函数

3，冒泡阶段： 执行完触发事件的元素自身的事件处理函数之后，事件会由触发事件的元素开始，一层层往上传递，直到顶层节点。

DOM 2级 可以分别在捕获和冒泡阶段绑定事件处理函数，IE6~8 和 DOM 0级 只能在冒泡阶段绑定事件处理函数。

onclick 和attachEvent 只能得到冒泡阶段。

addEventListener(type,function(),useCapture)，第三个参数如果是true，表示在事件捕获阶段调用事件处理程序，如果是false（不写默认是false），表示在事件冒泡阶段调用事件处理程序。

实际开发中我们很少使用事件捕获，我们更关注事件冒泡。

有些事件是没有冒泡的，比如onbur,onfocus,onmouseenter,onmouseleave。

## 绑定事件处理函数

**DOM 0级 方式绑定：**

元素.on + 事件名称 = 事件处理函数;

**DOM 2级 方式绑定:**

元素.addEventListener(事件名称, 事件处理函数, 事件阶段);

**IE6~8 中不支持标准的 DOM 2级方法，需要使用IE浏览器特有方法：**

元素.attachEvent(事件名称, 事件处理函数)
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
  <input type="button" value="按钮1">  
  <input type="button" value="按钮2">  
  <input type="button" value="按钮3">  
​  
  <script>  
    var btns = document.getElementsByTagName('input');  
​  
    // DOM 0级 绑定事件处理函数  
    btns[0].onclick = fn1;  
​  
    // DOM 2级 绑定事件处理函数   注意：事件名称不需要 on 前缀  
    btns[1].addEventListener('click', fn2);  
​  
    // IE6~8浏览器不支持 DOM 2级事件，但提供了IE浏览器专有的方法：  
    btns[2].attachEvent('onclick', fn3);  
      
    function fn1() {  
      console.log('fn1');  
    }  
​  
    function fn2() {  
      console.log('fn2');  
    }  
​  
    function fn3() {  
      console.log('fn3');  
    }  
  </script>  
</body>  
</html>
```

## 不同绑定方式的区别

**事件处理函数数量：**

DOM 0 级事件一个元素同时只能绑定一个事件处理函数，绑定多个事件处理函数，后面绑定的函数会覆盖前面绑定的函数； DOM 2级 与 IE 特有方法一个元素可以同时绑定多个事件处理函数

**绑定阶段：**

DOM 2级可以在同一事件的不同阶段绑定事件处理函数，DOM0级 与 IE方法只能在冒泡阶段绑定事件处理函数。

**执行顺序：**

DOM 2级的捕获阶段的事件处理函数总是最先执行；冒泡阶段如果绑定多个事件处理函数，IE9以上浏览器 2 级事件按绑定顺序执行，IE 6~8 中 0级 方式的事件处理函数最先执行，attachEvent() 方法按绑定的相反顺序执行事件处理函数。

**this** **指向：**

DOM 2 级 与 DOM 0 级 方式绑定的事件处理函数中，this 都指向触发事件的对象； IE 6~8 特有方法中指向 window 对象。
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
  <input type="button" value="按钮1">  
  <input type="button" value="按钮2">  
  <input type="button" value="按钮3">  
​  
  <script>  
    var btns = document.getElementsByTagName('input');  
​  
    // DOM 0级 同一个事件，只能绑定一个事件处理函数  
    btns[0].onclick = fn1;  
    // 绑定多个事件处理函数，后面绑定的会覆盖前面的  
    btns[0].onclick = fn2;  
​  
    // DOM 2级 同一个事件，可以绑定多个事件处理函数  
    btns[1].addEventListener('click', fn1);  
    btns[1].addEventListener('click', fn2);  
    // addEventListener() 方法的第三个参数表示在哪个阶段绑定事件处理函数：   
    //  false(默认值)  冒泡阶段        true   捕获阶段  
    btns[1].addEventListener('click', fn3, true);  
​  
    // IE浏览器专有的方法也可以同时绑定多个事件处理函数, 注意事件前面需要加 'on'  
    // IE 专有方法 和 DOM 0级方法都只能在冒泡阶段绑定函数，不支持捕获阶段绑定  
    // btns[2].attachEvent('onclick', fn1);  
    // btns[2].attachEvent('onclick', fn2);  
    // btns[2].attachEvent('onclick', fn3);  
​  
    /*   
      不同绑定方式的执行顺序  
​  
      标准浏览器中：  
        使用 DOM 2级 事件方法在捕获阶段绑定的函数一定是最先执行的  
        冒泡阶段 DOM 2级 与 DOM 0级 按函数绑定顺序执行   
      
      IE 6~8 浏览器中：  
        DOM 0级 绑定的函数始终最先执行  
        attachEvent() 方法绑定的函数，按绑定的相反顺序执行  
    */  
      
    function fn1() {  
      console.log('fn1');  
    }  
​  
    function fn2() {  
      console.log('fn2');  
      // DOM 0级 和 DOM 2级的事件处理函数中的 this 为触发事件的对象  
      // IE 专有方法绑定的事件处理函数中的 this 为 window  
      console.log(this);  
    }  
​  
    function fn3() {  
      console.log('fn3');  
    }  
  </script>  
</body>  
</html>
```

## 注销事件处理函数

**DOM 0级方式注销事件处理函数：**

元素.on + 事件名称 = null; (直接使用null值覆盖事件处理函数)

**DOM 2级方式注销事件处理函数：**

元素.removeEventListener(事件名称, 事件处理函数, 事件阶段)

DOM 2级 方法注销事件时，事件阶段要与绑定时的阶段相同（在捕获阶段绑定的函数，只能在绑定阶段注销）。

**IE 6 ~ 8 方法注销事件处理函数：**

元素.detachEvent(事件名称, 事件处理函数)

**注意：** 匿名函数无法注销，DOM 2 中同名事件函数多次绑定后面会覆盖前面，IE 6~8 中同名函数可以多次绑定，注销时也需要多次注销。
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
  <input type="button" value="按钮1">  
  <input type="button" value="按钮2">  
  <input type="button" value="按钮3">  
​  
  <script>  
    var btns = document.getElementsByTagName('input');  
​  
    btns[0].onclick = fn1;  
    // DOM 0级 方式绑定的注销方式，直接使用 null 覆盖原来的函数  
    btns[0].onclick = null;  
      
    // 冒泡阶段绑定函数  false 默认可以省略  
    btns[1].addEventListener('click', fn2, false);  
    // 捕获阶段绑定函数  
    btns[1].addEventListener('click', fn3, true);  
​  
    // 注销 DOM 2级 绑定的事件  
    btns[1].removeEventListener('click', fn2);  
    // 在哪个阶段绑定的，就需要在哪个阶段注销  
    btns[1].removeEventListener('click', fn3, true);  
​  
    // IE 6~8 绑定函数  
    // 同一个函数可以多次绑定  
    btns[1].attachEvent('onclick', fn3);  
    btns[1].attachEvent('onclick', fn3);  
​  
    // 同一个函数，绑定了几次就要注销几次  
    btns[1].detachEvent('onclick', fn3);  
    btns[1].detachEvent('onclick', fn3);  
​  
    function fn1() {  
      console.log('fn1');  
    }  
​  
    function fn2() {  
      console.log('fn2');  
    }  
​  
    function fn3() {  
      console.log('fn3');  
    }  
  </script>  
</body>  
</html>
```


## 事件对象

事件触发时，DOM 会自动将与事件有关的详细信息保存到事件对象中。

DOM 0级方式绑定的事件函数中：

在 IE9 以上及其他浏览器中，事件对象会作为第一个实参传入事件处理函数中。

在 IE8及以下IE版本浏览器中，事件对象是全局对象 event 。

DOM 2级方式 和 attachEvent() 方法中：

事件对象是第一个传入事件处理函数的实参。

事件对象只有在事件触发时才会有值。

## 事件对象常用属性

**offsetX、offsetY:** 鼠标距离元素边框内侧边缘的坐标距离 （padding 值的起始边界）

![](file://D:/%E8%AF%BE%E7%A8%8B%E6%96%87%E4%BB%B6/js15/%E8%BF%9B%E9%98%B6%E7%AC%AC2%E8%AF%BE%E7%AC%94%E8%AE%B0/images/1.png?lastModify=1657429254)

**clientX、 clientY:** 鼠标距离可视区窗口左上角的坐标距离 （支持x , y 属性浏览器取相同值）

![](file://D:/%E8%AF%BE%E7%A8%8B%E6%96%87%E4%BB%B6/js15/%E8%BF%9B%E9%98%B6%E7%AC%AC2%E8%AF%BE%E7%AC%94%E8%AE%B0/images/2.png?lastModify=1657429254)

**pageX、pageY:** 鼠标距离文档左上角的坐标距离 （支持 layerX, layerY 属性浏览器取相同值）

![](file://D:/%E8%AF%BE%E7%A8%8B%E6%96%87%E4%BB%B6/js15/%E8%BF%9B%E9%98%B6%E7%AC%AC2%E8%AF%BE%E7%AC%94%E8%AE%B0/images/3.png?lastModify=1657429254)

**screenX、screenY:** 鼠标距离屏幕左上角的坐标距离

![](file://D:/%E8%AF%BE%E7%A8%8B%E6%96%87%E4%BB%B6/js15/%E8%BF%9B%E9%98%B6%E7%AC%AC2%E8%AF%BE%E7%AC%94%E8%AE%B0/images/4.png?lastModify=1657429254)

**type:** 事件类型名称，不区分大小写

**target:** 标准浏览器（IE9以上及其它浏览器）中，触发事件的元素（IE8以下为 srcElement）

**currentTarget:** 只有高版本浏览器支持， 表示绑定事件函数的元素（代码中写绑定事件的元素）

**timestamp:** 页面加载成功之后，从注册事件开始持续的毫秒数（注册事件是指浏览器加载完事件管理器）

## 取消事件冒泡

如果不希望事件冒泡，可以取消：

高版本浏览器中：

事件对象.stopPropagation();

IE6~8 浏览器中：

事件对象.cancelBubble = true;
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
  <div id="div1">  
    <input type="button" value="按钮" id="btn">  
  </div>  
​  
  <script>  
​  
    // 事件冒泡： 事件在执行完成之后，会依次往上传递，直到传递到最顶层的 document 对象身上。  
    // 事件冒泡过程中，如果碰到祖先元素的同类型事件中也绑定也事件处理函数，会执行这个事件处理函数。  
​  
    var div1 = document.getElementById('div1');  
    var btn = document.getElementById('btn');  
​  
    // btn , div1, body 标签的点击事件中都绑定了事件处理函数  
    // 当点击 btn 按钮，执行完 fn1 之后，事件给传递给 div1 ，执行 div1 的事件处理函数 fn2  
    // fn2 执行完成之后，事件会再传递给 body 标签，执行 body 的事件处理函数。  
    // body 的事件处理函数执行完之后，还会一层层往上传递，直到 document 对象，  
    // 但因为上面的元素都没有绑定事件处理函数，因此看不到效果。  
    btn.onclick = fn1;  
    div1.onclick = fn2;  
    document.body.onclick = fn3;  
​  
​  
    function fn1(ev) {  
      console.log('fn1');  
​  
      // 高版本浏览器中， DOM 0级 和 DOM2 级方式 绑定的事件处理函数中，都通过stopPropagation() 方法阻止事件冒泡  
      ev.stopPropagation();  
​  
      // IE6~8 中使用 cancelBubble 属性阻止事件冒泡  
      ev.cancelBubble = true;  
    }  
​  
    function fn2() {  
      console.log('fn2');  
    }  
​  
    function fn3() {  
      console.log('fn3');  
    }  
  </script>  
​  
</body>  
</html>
```

## 阻止事件默认行为

事件默认行为就是事件发生时，默认触发执行的效果。

比如：点击鼠标右键，默认会显示上下文菜单；点击a链接，默认会跳转页面。

阻止事件执行默认行为：

在高级浏览器中阻止默认事件的方式：

事件对象.preventDefault()

在 IE6~8 中阻止默认事件的方式：

事件对象.returnValue = false;

DOM 0级方式 和 IE6~8 的 attachEvent() 方法绑定事件处理函数，还可以在代码最后使用return false阻止默认行为;

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
  <div id="div1">  
    <input type="button" value="按钮" id="btn">  
  </div>  
​  
  <a href="http://www.baidu.com/" target="_blank">百度一下</a>  
​  
  <script>  
​  
    //  事件默认行为： 是指事件触发时，默认会执行的行为。  
    //  比如： 1， 点击 A链接，会跳转页面   2， 右键会出菜单。  
​  
    var div1 = document.getElementById('div1');  
    var btn = document.getElementById('btn');  
    var aBtn = document.getElementsByTagName('a')[0]  
​  
    // aBtn.onclick = function(ev) {  
    //   var ev = ev || event;  
    //   // 标准浏览器中阻止默认行为  
    //   ev.preventDefault();  
    // };  
​  
    // DOM 0级 和  DOM 2级都使用 ev.preventDefault(); 取消默认行为  
    // aBtn.addEventListener('click', function(ev) {  
    //   ev.preventDefault();  
    // });  
​  
      
    aBtn.onclick = function(ev) {  
      // 在 DOM 0级事件中还可以在函数内部的最后执行 return false;   
      return false;  
    };  
    // IE(IE6~8)浏览器专有的方法中，使用 ev.returnValue = false;  
    aBtn.attachEvent('click', function(ev) {  
      ev.returnValue = false;  
    });  
​  
  </script>  
​  
</body>  
</html>
```


