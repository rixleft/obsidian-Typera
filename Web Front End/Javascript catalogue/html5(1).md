# HTML5第一天

## 二、HTML5

### 2.1 本地存储

HTML5是html的第五个版本，里面规定了一些废弃标签，同时新增了一些标签，和一些功能

存储：前端仓库的意思

每一个网站分配一个“仓库”，只要浏览器不卸载，电脑不崩溃，它将一直存在（生命周期永久）

本地存储对象：localStorage，里面是没有任何数据， 既然是一个对象

我们可以使用对象的点语法，去添加数据

注意：在存储之前先转为字符串，在读取的时候再转为原类型（JSON.stringify）

本地存储也提供了相应的API，所以建议我们使用原型中的方法

存储数据：localStorage.setItem(key, value)

key： 表示要存储的数据名称， 是一个字符串

value: 要存储的数据 （默认转为字符串）

读取数据：localStorage.getItem(key)

key: 要读取的数据名称

删除某一项数据：localStorage.removeItem(key)

key: 要删除的数据名称

删除全部数据：localStorage.clear()

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
// console.log(localStorage);  
// 存储数据  
// localStorage.color = 'red';  
// 查看数据  
// console.log(localStorage.color);  
​  
// 可以存储任何类型的数据，但是都会作为字符串形式存储  
// localStorage.arr = [1, 2, 3]  
// console.log(localStorage.arr);  
// console.log(typeof localStorage.arr);  
​  
// 为了读取和存储时候数据类型一致，可以将数据作为json字符串存储  
// localStorage.arr = JSON.stringify([1, 2, 3]);  
// console.log(localStorage.arr);  
// console.log(typeof localStorage.arr);  
// var arr = JSON.parse(localStorage.arr);  
// console.log(arr, typeof arr);  
​  
// 简单类型的字符串，可以直接存储，复杂类型的对象要转成json字符串存储，使用的时候再解析  
​  
// json不能存储函数  
// function demo() {  
//     console.log('demo');  
// }  
// // console.log(JSON.stringify(demo));  
// // 函数可以直接存储  
// localStorage.fn = demo;  
// console.log(localStorage.fn);  
// console.log(typeof localStorage.fn);  
// 函数读取的时候是字符串，不能执行了，  
// 为了让字符串执行，可以通过构造函数式以及工厂式执行函数  
// var fn = new Function('return ' + localStorage.fn);  
// var fn2 = Function('return ' + localStorage.fn);  
// // console.log(fn(), fn2());  
// fn()()  
// fn2()()  
// 可以让字符串作为语句执行；eval  
// eval(localStorage.fn);  
// demo();  
// eval和Function都可以让字符串作为语句执行，区别式eval让语句再全局中执行，Function在函数内部执行  
// eval('console.log(11)')  
// console.log(new Function('console.log(11)'));  
// new Function('console.log(11)')()  
​  
// API方法  
// 存储数据  
// localStorage.setItem('num', 100)  
// 不论是点语法存储，还是setItem存储，都建议将数据转成json字符串  
// localStorage.setItem('arr2', [4, 5, 6])  
// // 删除数据  
// localStorage.removeItem('num')  
// 清空数据  
// localStorage.clear();  
// // 读取数据  
// // 数据删除后，访问不到，所以返回null  
// console.log(localStorage.getItem('num'));  
// console.log(localStorage.num);  
// console.log(localStorage.getItem('color'));  
// console.log(localStorage.getItem('arr2'));  
​  
// 任何数据作为字符串存储，都是调用其自身的toSting方法  
// var arr = [1, 2, 3];  
// console.log(arr.toString());  
// function test() {  
//     console.log('test');  
// }  
// console.log(test.toString());  
例题：console.log(({}+{}).length)的结果？
两个空对象相加，是字符串连接，字符串在连接时默认会调用相应的toString()方法，
({}).toString() 得到"[object Object]" 长度为15，那么两个相加为30，
相当于 ({}.toString()+{}.toString()).length。
也就是 "[object Object][object Object]"，求得这个字符串长度为30。
</script>  
</body>  
</html>
```

### 2.2 会话存储

除了本地存储之外还有一个存储对象叫做: sessionStorage

它与本地存储之间的区别就是生命周期的区别

本地存储的生命周期是永久的。

会话存储的生命周期是从页面打开到页面关闭。

与全局变量的区别是

会话存储可以刷新页面

全局变量不能刷新页面

生命周期长度：本地存储 > 会话存储 > 全局变量
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
// 会话存储，与本地存储一样  
// sessionStorage.num = 100;  
// sessionStorage.arr = [1, 2, 3];  
// console.log(sessionStorage.num);  
// console.log(sessionStorage.arr);  
// // 复杂的数据建议用json转换  
// sessionStorage.arr2 = JSON.stringify([4, 5, 6]);  
// console.log(JSON.parse(sessionStorage.arr2));  
​  
​  
// API方法  
// 存储数据  
// sessionStorage.setItem('color', 'red');  
// // 删除数据  
// // sessionStorage.removeItem('color')  
// // 清空数据  
// sessionStorage.clear();  
// // 读取数据  
// console.log(sessionStorage.getItem('color'));  
// console.log(sessionStorage.color);  
​  
// 会话存储与本地存储的区别  
// 生命周期    
//      会话存储：丛打开页面到关闭页面，可以刷新  
//      本地存储：永久  
// 会话存储与全局变量的区别  
//      会话存储：可以刷新页面  
//      全局变量：不能刷新页面  
// sessionStorage.msg = 'hello';  
// var test = 'test';  
​  
console.log(sessionStorage.msg);  
console.log(test);  
</script>  
</body>  
</html>
```

### 2.3 历史记录

history.forward

该方法用于加载历史记录列表中的下一个URL（显示下一个页面）

调用该方法等价于点击了前进按钮或者是调用了history.go(1)

history.back

该方法用于加载历史记录列表中的上一个URL（显示上一个页面）

调用该方法等价于点击了后进按钮或者是调用了history.go(-1)

pushState：该方法用于向历史记录中添加新的历史记录。（注：状态改变不需要刷新页面）

使用方式：history.pushState(obj, title, url)

obj: 添加的数据 是一个对象

title: 新的网页标题 一般省略

url: 新的网页的url

replaceState：该方法用于替换当前的历史记录

使用方式：history.pushState(obj, title, url)

obj: 添加的数据 是一个对象

title: 新的网页标题 一般省略

url: 新的网页的url

window.onpopstate事件：该事件可以监听replaceState方法的执行以及页面的切换。

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
    <a href="./first.html">进入first页面</a>  
    <button id="btn1">添加第一条记录</button>  
    <button id="btn2">添加第二条记录</button>  
    <button id="btn3">替换记录</button>  
<script>  
btn1.onclick = function() {  
    // 添加记录  
    history.pushState({ num: 100 }, '第一个页面', '#demo1')  
}  
btn2.onclick = function() {  
    // 添加记录  
    history.pushState({ num: 200 }, '第二个页面', '#demo2')  
}  
btn3.onclick = function() {  
    // 替换记录  
    history.replaceState({ num: 300 }, '第三个页面', '#demo3')  
}  
// 监听页面切换  
window.onpopstate = function(e) {  
    console.log(111, e, e.state);  
}  
</script>  
</body>  
</html>
```
