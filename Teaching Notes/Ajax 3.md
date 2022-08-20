#  Ajax与Nodejs第8天

## 一、Ajax 2.0

### 2.1 FromData

在AJAX2.0中新增了FormData构造函数

 作用：用户快速进行表单序列化，来代替表单。

使用方式：

​		 let fd = new FormData(form)

 				form: 原生的form表单元素

​			 	参数是可有可无的

​						 如果传递了参数，得到一个fd的实例化对象，我们可以通过其原型中的方法查看内部结构

​					 如果没有传递参数，得到的是一个空的对象，我们可以调用原型中的方法添加数据

**forEach**

使用方式： fd.forEach(fn)

​		 fn: 处理函数

​		 有三个参数 

​		 		第一个参数：  输入的内容

​				 第二个参数： 输入框name值

​				 第三个参数： FormData对象

 				 this指向全局作用域

**append**

append：该方法用于添加数据的

​		 使用方式：fd.append(key, value)

​				 key:  name值

​				 value: 是数据

**delete**

delete：该方法用于删除数据中的某一项

​		 使用方式：fd.delete(key)

​				 key: 数据名称

**get**

get：该方法用于获取某一项数据

​		 使用方式：fd.get(key)

​				 key： 对应的name值

​				 返回值就是获取到数据

**getAll**

getAll：该方法用于获取某个name字段的所有数据

​		 使用方式：fd.getAll(key)

​				 key: 对应的name属性值

​				 返回值是一个数组

**has**

has：该方法用于判断是否包含某个属性

​	 使用方式：fd.has(key)

​				 key: 对应的name值

​				 返回值是布尔值

​						 如果存在   返回true

​						 如果不存在  返回false

**set**

set：该方法用于设置内容的，与append方法不同的是，set方法会覆盖掉之前已经添加的数据

​		 使用方式：fd.set(key, value)

​				 key: 对应的name值 value:  数据

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
    <form action="">
        <p>
            <label>用户名: <input type="text" name="username" id="username"></label>
        </p>
        <p>
            <label>密&emsp;码: <input type="text" name="password" id="password"></label>
        </p>
        <button type="button" id="submit">提交</button>
    </form>
    <script>
    // 点击的时候进行表单序列化
    submit.onclick = function() {
        // 获取表单
        let form = document.forms[0];
        // 使用ajax2.0提供的FormData构造函数 
        let fd = new FormData(form);
        // 参数可有可无
        // let fd = new FormData();


        // append 添加数据 
        // fd.append('intrest', 'basketball');
        // fd.append('intrest', 'football');
        // fd.append('username', 'wanglaowu');

        // delete 移除数据
        // fd.delete('intrest');

        // 获取单个数据
        // console.log(fd.get('intrest'));
        
        // 获取name对应的多个数据
        // console.log(fd.getAll('intrest'));

        // has 判断数据是否存在
        // console.log(fd.has('username'));
        // console.log(fd.has('password'));

        // set 设置数据的 但是会覆盖之前的数据
        // fd.set('intrest', 'pingpang');



        // 遍历内部结构
        // fd.forEach((value, name) => {
        //     // console.log(111, args);
        //     console.log(111, name, value);
        // })


        // 创建xhr
        let xhr = new XMLHttpRequest();

        // 建立TCP
        xhr.open('post', '/aaa', true);

        // 发送 携带fd数据
        xhr.send(fd);

    }

  
    </script>
</body>
</html>
```



### 2.2 图片预览

一般图片的src属性指向服务器上资源

所谓图片预览，指的是在图片没有上传到服务器之前，就要预览图片

在H5中提供了一个FileReader构造函数用于图片预览的

在H5之前，在URL对象上提供了createObjectURL方法用于图片预览

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
    <input type="file" id="inp">
    <img src="" alt="" id="img">
    <script>
    // 监听上传图片的行为
    inp.onchange = function() {
        // 获取上传的文件
        let file = this.files[0];

        // 实例化
        let fr = new FileReader();
        // console.log(fr);

        // 通过原型方式读取上传的文件 是一个异步的
        fr.readAsDataURL(file);

        // 当读取完毕之后执行的方法
        fr.onload = function(e) {
            console.log(e, this);

            // 设置图片的路径
            img.src = this.result;
        }
       
    }
    </script>
</body>
</html>
```



### 2.3 createObjectURL

window.URL.createObjectURL

 该方法也是用于图片预览的，是在H5之前提供的

 使用方式：window.URL.createObjectURL(file)

​		 file： 上传的文件

​		 返回值是blob数据

​		 blob 是一个大的二进制文件

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
    <input type="file" id="inp">
    <img src="" alt="" id="img">
    <script>
    // 监听上传图片的行为
    inp.onchange = function() {
        // 获取上传的文件
        let file = this.files[0];
        console.log(file);
        

        // console.log(123);
        // 在H5之前提供了 window.URL.createObjectURL方法用于图片预览

        // 返回值是blob数据  blob 是一个大的二进制文件
        let blob = window.URL.createObjectURL(file);
        // console.log(blob);

        // 设置图片的src
        img.src = blob;
    }
    </script>
</body>
</html>
```

## 二、跨域

### 2.1 域

域: 指的是域名

​		域名对应的是一个ip地址

​		域名与ip地址的关系存储在域名解析系统中（DNS）

跨域

​		例如： 有一个服务器A，有一个服务器B，当浏览器从服务器A上面请求资源并渲染完毕之后，再操作该页面的时候发送了另一个请求到服务器B，这个行为就称为跨域请求资源

### 2.2 跨域鉴定

当前域是http://localhost:3000，当请求回来的页面中，又发送请求到其它服务器中请求资源：

 		不跨域	url: 'http://localhost:3000/regist?username=ickt',

​		 

 	     跨域	url: 'http://localhost:3001/regist?username=ickt',

比较协议、域名、端口号三者有任意不同的地方，就可以判定为跨域

### 2.3 同源策略

浏览器有一个同源策略不允许跨域请求资源

但是静态资源是不受同源策略的影响

### 2.4 JSONP

jsonp: Json with padding

jsonp是一种跨域请求资源的解决方案，JSONP可以绕过AJAX遵循的同源策略。

我们可以利用script标签无视同源策略的特点，将该标签上的src指向目标服务器上的接口

 		向目标服务器发送一个方法名称以及数据，
 	
 		服务器接收数据，并返回数据（要放在方法中）
 	
 		客户端定义好该方法，让方法去执行，即可解决跨域

主要：需要跨域的服务器配合（将数据放在方法中执行）

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <h1>hello index</h1>
    <!-- 引入jq -->
    <script src="./js/jquery.js"></script>
    <script>
    // jquery中的jsonp
    // $.ajax({
    //     url: 'http://localhost:3001/testB',
    //     method: 'get',
    //     data: {
    //         a: 1,
    //         b: 2
    //     },
    //     // 解决跨域
    //     dataType: 'jsonp',
    //     // 指定回调函数的名称
    //     jsonpCallback: 'demo123',
    //     success(res) {
    //         console.log(111, res);
    //     }
    // })
    </script>

    <script>

    // < src="http://localhost:3001/testB?fn=demo">
    // 封装ajax中的jsonp
    function jsonp(url, data, callback) {
        // 创建一个script标签
        let script = document.createElement('script');

        // 定义结果变量
        let str = '';
        // 将data转为query数据
        // 遍历data
        for (let key in data) {
            // 拼接
            str += `&${key}=${data[key]}`;
        }
        // 处理str
        str = str.slice(1);
        // 让script的src指向目标服务器
        script.src = url + '?' + str;
        // 提前在全局定义好一个方法
        window[data.fn] = callback;
        // 上树
        document.body.appendChild(script);

        // 当获取数据之后要移除script 并且移除demo方法
        script.onload = function() {
            // 下树
            document.body.removeChild(this);
            // 释放变量
            window[data.fn] = null;
        }
    }

    // 执行方法
    jsonp('http://localhost:3001/testB', { width: 100, height: 200, fn: 'demo' }, res => {
        console.log(111, res);
    })
    </script>
</body>
</html>
```



### 2.5 jQuery 中的 JSONP

使用方式：

​		$.ajax({

​				 url:    请求的路径

​				 type：  请求的方式

​				 dataType:  jsonp’

​				 jsonpCallback:  指定回调函数的名称

​				 success:  成功时候执行的回调函数

​		})

```js
$.ajax({
    // 请求的路径
    url: 'http://localhost:3001/demo',
    // 请求的方式
    method: 'GET',
    // 请求类型
    dataType: 'jsonp',
    // 指定回调函数的名称
    jsonpCallback: 'demo',
    // 成功时候执行的方法
    success(res) {
        console.log(111, res);
    }
})
```



### 2.6 代理模板

在html中，通过iframe定义框架，可以引入其它页面（有跨域问题，不能访问其它域上一层框架）。

 		在A域中，通过iframe引入B域的页面

​		 在B域中，将请求重定向到A域的页面（代理模板）中

​		 在A域中，通过代理模板解析数据，并执行A域的方法，实现跨域请求数据的获取

注意：需要B域服务器端的配合：重定向配合。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>demo html</h1>
    <script>
    // self属性 表示对自己的引用
    // console.log(self);

    // console.log(window);

    // 访问顶层框架
    // console.log(111, top.fn);

    // 访问父框架
    // console.log(222, parent.fn);

    // 既然可以访问父框架中的方法 就可以执行并传递数据
    // parent.demo({ color: 'red', msg: 'hello msg' })
    </script>

    <script>
    let arr = decodeURIComponent(location.search.slice(1)).split('&').map(item => item.split('=')); 
    console.log(arr);

    // 使用Object.fromEntries 将二维数组转为对象
    let obj = Object.fromEntries(arr);

    // 执行方法传递数据
    parent[obj.fnName](obj.data);
    </script>

</body>
</html>
```



### 2.7 html5 跨域

服务器允许跨域要设置请求头

 res.setHeader('Access-Control-Allow-Origin', '*');

 res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');

 res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

 res.setHeader('Access-Control-Allow-Credentials', 'true');

```js
// 引入http
let { createServer } = require('http');

// 创建服务器
createServer((req, res) => {
    // 修改请求头
    res.setHeader('Access-Control-Allow-Origin', '*');
	res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
	res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
	res.setHeader('Access-Control-Allow-Credentials', 'true');
}

```



## 三、服务器

### 3.1 搭建https服务器

HTTP是一个无状态的协议，在请求的过程中，不会进行安全校验，可以会注入广告或者被拦截，因此HTTPS协议

就出现了，HTTPS协议在请求过程中会进行安全校验，所以更安全可靠

如果要搭建HTTPS服务器需要证书（工作中需要购买，学习中通过openssl创建即可）：

http协议默认的端口号  80

https协议默认的端口号  443

```js
// 引入express
const express = require('express');
// 引入http
const http = require('http');
// 引入https
const https = require('https');
// 引入fs
const fs = require('fs');

// 获取应用程序
const app = express();

// 开放权限
app.use(express.static('./web/'));

// 定义端口号
// let httpPort = 3000;
// let httpsPort = 3001;

// http协议默认的端口号 80
// https协议默认的端口号 443

let httpPort = 80;
let httpsPort = 443;


// 创建http应用
http.createServer(app)
    // 监听端口号
    .listen(httpPort, () => console.log('监听在'+ httpPort +'端口号'));



// 定义key
let key = fs.readFileSync('./ssl//private.pem');
let cert = fs.readFileSync('./ssl/file.crt');

// 创建https应用
https.createServer({ key, cert }, app)
    .listen(httpsPort, () => console.log('监听在'+ httpsPort +'端口'))




```



