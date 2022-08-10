# Ajax与Nodejs第2天

## 一、内置模块

### 1.1 url模块

该模块的作用可以实现将url字符串与url对象互相转换。使用的时候需要引入url模块

parse：该方法可以将url字符串解析为url对象

​	使用方式：url.parse(url_str, bool)

​		url_str:  url字符串

​		bool: 	是一个布尔值

​			默认是false, 当传递true的时候，会将url对象中的query部分变为对象

format：该方法用于实现将url对象再次解析为url字符串

```js
let url = require('url');

let str = ' https://www.baidu.com:443/home/xman/data/tipspluslist.json?indextype=manht&_req_seqid=0xf65aa9f1000e3366&asyn=1#demo'

// 解析url字符串
// let obj = url.parse(str)
let obj = url.parse(str, true)
console.log(obj);

// 转成url字符串
let data = url.format(obj);
console.log(data);
```

### 1.2 PATH

该模块的作用用于处理请求的路径的。使用的时候，需要引入path模块

parse：该方法可以实现将路径字符串转为对象

​	使用方式：path.parse(path_str)join：该方法用于拼接路径

​	使用方式：path.join(path1, path2 ...)

​		path1 	第一个路径

​		path2 	第二个路径

​		可以传递多个路径，返回值就是拼接后的路径。

```js
let path = require('path');

let str1 = 'E:/ickt_50/12 nodejs/example/06 url.js';
let str2 = 'https://www.baidu.com:443/home/xman/data/tipspluslist.json?indextype=manht&_req_seqid=0xf65aa9f1000e3366&asyn=1#demo'

let p1 = path.parse(str1);
let p2 = path.parse(str2);
// 工作中，处理本地路径用path模块，处理网站路径用url模块
console.log(p1);
console.log(p2);

// 对象转字符串
// console.log(path.format(p1));

// 拼接路径
console.log('./web' + '/demo.html');
// join再window下用\拼接，再linux，unix，mac下用/拼接
console.log(path.join('./web', '/demo.html'));
```

### 1.3 querystring

该模块的作用是用于处理query字符串或者是类似query的字符串。使用的时候要引入querystring模块

​	 例如：

​			 query字符串:   ‘a=1&b=2’

​			 类似query的字符串:  ‘a:1$b:2’

parse：该方法用于将query字符串解析为对象

​	 使用方式：qs.parse(query_str, bigSplit, smallSplit)

​			 query_str: 要处理的字符串（query字符串或者是类似于query字符串）

​			 bigSplit: 大的分隔符 默认是 &

​			 smallSplit: 小的分隔符 默认是 =

```js
let qs = require('querystring');

// 解析路径
var search = 'indextype=manht&_req_seqid=0xf65aa9f1000e3366&asyn=1';
var search2 = 'indextype***manht@_req_seqid***0xf65aa9f1000e3366@asyn***1';

// 将search字符串解析成对象
// 注意：解析的时候，不能包含前面的？
var obj = qs.parse(search);
console.log(obj);

var obj2 = qs.parse(search2, '@', '***');
console.log(obj2);

// 转成对象
console.log(qs.stringify(obj, '@@@', '*****'));
```



## 二、静态服务器

### 2.1 静态服务器

通过从浏览器发送请求到服务器，请求的资源类型有两种：

​	1 静态资源

​		例如： html、css、js、图片等... 这些称为静态资源

​	2 动态资源

​		例如: 实现登录、注册等发送的请求，这些称为动态资源

### 2.2 MIME TYPE

Mime Type： 是互联网中每一种资源类型的定义

​	例如：

> ​		‘html’:  ‘text/html’,
>
> ​		‘css’:  ‘text/css’,
>
> ​		‘js’:  ‘application/x-javascript’
>
> ​		‘jpg’: ‘image/jpg’,
>
> ​		‘jpeg’: ‘image/jpeg’

```js
let http = require('http');
let url = require('url');
let path = require('path');
let fs = require('fs');

// 文档类型
let MINE_TYPES = {
	'html': 	'text/html',
	'xml': 		'text/xml',
	'txt': 		'text/plain',
	'css': 		'text/css',
	'js': 		'text/javascript',
	'json': 	'application/json',
	'pdf': 		'application/pdf',
	'swf': 		'application/x-shockwave-flash',
	'svg': 		'image/svg+xml',
	'tiff': 	'image/tiff',
	'png': 		'image/png',
	'gif': 		'image/gif',
	'ico': 		'image/x-icon',
	'jpg': 		'image/jpeg',
	'jpeg': 	'image/jpeg',
	'wav': 		'audio/x-wav',
	'wma': 		'audio/x-ms-wma',
	'wmv': 		'video/x-ms-wmv',
	'woff2': 	'application/font-woff2'
};

// 创建服务器
let app = http.createServer(async (req, res) => {
    // 解析url
    let obj = url.parse(req.url);
    // 获取拓展名
    let ext = path.extname(obj.pathname);
    // 拼接默认文件名
    if (!ext) {
        obj.pathname = path.join(obj.pathname, '/index.html')
        ext = '.html'
    }
    // 去web目录下查找文件
    obj.pathname = path.join('./web/', obj.pathname)
    // console.log(111, obj.pathname);
    // 根据路径查找文件
    // 路径存在，并且不是文件夹
    let state = await new Promise(resolve => fs.stat(obj.pathname, (e, data) => resolve(data && !data.isDirectory())))
    // console.log(obj.pathname, state);
    if (state) {
        // 如果文件存在，读取文件，返回到浏览器端
        let data = await new Promise(resolve => fs.readFile(obj.pathname, (e, data) => resolve(data)))
        // console.log(data);
        if (data) {
            res.writeHead(200, {
                'Content-Type': MINE_TYPES[ext.slice(1)] + '; charset=utf-8'
            });
            res.end(data)
        } else {
            // 没有读取到文件，返回404
            res.writeHead(404, {
                'Content-Type': MINE_TYPES.txt + '; charset=utf-8'
            })
            // 如果地址不存在，返回404
            res.end('not found')
        }
    } else {
        // 设置响应头和状态码
        res.writeHead(404, {
            'Content-Type': MINE_TYPES.txt + '; charset=utf-8'
        })
        // 如果地址不存在，返回404
        res.end('not found')
    }
})

// 监听端口号
app.listen(3000);
```



## 三、nodejs中 变量

问题：当我们书写代码的时候，明明没有定义require、module、exports这些变量，但是为什么可以使用呢

原因：当我们书写代码的时候，不是直接执行了，而是先对nodejs中的模块文件进行打包了

例如：let http = require(‘http’)

打包结果：define(function(require, exports, module, __dirname, __filename) {})

 __dirname:  指向是当前文件所在的目录

 __filename: 指向当前文件所在的完整的绝对路径

```js
// console.log(111, require);
// console.log(222, module);
// console.log(333, exports);
// // 定义的变量外界无法访问，暴露接口才能访问
// var color = 'red';

// 编译成一个模块
// define(function(require, module, exports, __filename, __dirname) {
//     console.log(111, require);
//     console.log(222, module);
//     console.log(333, exports);
//     var color = 'red';
// })

// 文件所在的位置
console.log(__filename);
// 文件所在的目录
console.log(__dirname);

// 全局变量
console.log(global);
// 全局变量中的方法，可以直接访问
console.log(setTimeout);

// 全局对象
// console.log(process);
// 指令执行时候的位置
// __filename是文件所在位置， procwss.cwd()是指令执行的位置
console.log(process.cwd());
// 获取指令参数
console.log(process.argv);
```





## 四、NPM

### 4.1 npm 介绍

NPM： Node Package Manager （node的第三方包管理器）

 官网：https://www.npmjs.com/

在nodejs中的文件分为三类：

 1 核心模块  这类文件可以直接引入

 2 第三方模块文件  这类模块要安装之后才能使用

 3 文件模块 我们写的js文件就是一个模块

node_modules文件夹：

 该文件夹中用于存储所有的第三方文件，当我们需要引入内部文件的时候，就可以像引入内置模块那样直接引入了

### 4.2 npm 指令

npm install ModuleName 

 该指令可以实现将ModuleName 下载到本地

 注意： install 可以简写为i

npm install ModuleName1 ModuleName2

 该指令可以实现将ModuleName1以及ModuleName2共同下载到本地

 注1：在下载模块的时候，如果在同级目录中存在node_modules文件，则直接下载到该文件中，如果当前层级没有node_modules文件夹，则往上级或者是上上级目录开始查找，如果找到了，直接下载到文件中，如果直到根目录下还没有找到node_modules文件夹，则返回到指令执行的目录，创建一个node_modules文件夹并下载

注2：如果在当前目录下，存在一个package.json文件的话，则直接创建node_modules文件并下载

注3：在下载模块文件的时候，如果使用指令 npm install ModuleName --save 

 此时会下载package.json文件的dependencies配置依赖的模块，表示“运行的时候的模块”

 在下载模块文件的时候，如果使用指令 npm install ModuleName --save-dev  

 此时会下载package.json文件的Devdependencies配置依赖的模块，表示“开发的时候的模块”

当我们需要去下载别人的项目的时候，可以npm install 即可将dependencies以及Devdependencies相关的文件全部下载到本地

如果模块存在指令文件，需要向全局安装：npm install ModuleName -g

### 4.3 package.json

每一个项目的根目录中，都有一个package.json文件，用于定义了这个项目所需要的各种模块,以及项目的配置信息

生成package.json

 我们可以通过npm init 即可生成该文件

 但是在创建的时候会出现一些列的询问：

 一路按下回车即可





## 五、Express

### 5.1 Express

Express是基于Nodejs平台的一个快速、开放、极简的web应用框架

可以帮助我们快速的搭建后台服务器，快速的处理get请求、post请求......

官网：http://www.expressjs.com.cn/

下载：npm install express

### 5.2 搭建服务器

引入express

 		let express = require('express');

创建应用程序

​		 let app = express();

监听端口号

​		 app.listen(3000);

当我们需要访问某一个目录的时候，此时就要对该目录进行静态化

我们可以使用Express中唯一的一个中间件 -- static 方法实现目录的静态化

 中间件：处理请求的方法， 使用中间件用use方法。

```js
// 引入模块
let express = require('express');

// 创建应用程序
let app = express();

// 静态化
app.use(express.static('./web/'))

// 设置端口号
// app.listen(3000, () => console.log('server listen at 3000'))
app.listen(3000)
```



### 5.3 处理 GET 请求

在Express中处理请求的方式有两种： 1 通过app.get  2 通过Router路由对象

第一种：使用方式：app.get(path, callback)

 path:  请求的路径接口

 callback: 回调函数，有三个参数：

 第一个参数： req 请求对象

 第二个参数： res 响应对象

 第三个参数： next放行函数
    在Express中允许对一个接口，添加多个处理函数

    在接口函数中的第三个参数就是next放行函数
    
    该函数不执行，后面的回调函数就不会执行。

获取query数据：可以通过req.query直接获取上串的数据

 req.query是Express对请求对象封装后的

```js
// 引入模块
let express = require('express');

// 创建应用程序
let app = express();

// 静态化
app.use(express.static('./web/'))


// 接收数据
app.get('/login', (req, res) => {
    // req和res是express处理过的，因此拓展了更多的方法
    // 从浏览器端向服务器端传递叫请求
    // 从服务器端向前端传递叫响应
    // console.log(req.url);
    // console.log(req.query);
    // 源生的方式
    // res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' })
    // res.end('收到数据了')
    // 传递对象
    // res.end({ color: 'red', num: 100 })
    // 源生方式有很多局限性
    // express拓展了一些方法（解决了编码的问题）
    res.json({
        color: 'res',
        num: '100',
        msg: '成功！'
    })
})

// 接收get请求
app.get('/test', (req, res, next) => {
    // console.log(111);
    // // 源生方式
    // res.write('111')
    // res.write('222')
    // res.end('333')
    // end方法只能执行1次，并且end之后，不能再写入了
    // res.end('444')
    // res.write('555')
    // express封装json的时候，再内部执行了end方法
    res.json({ msg: 'success111' })
    // next方法表示放行函数
    next();
})
app.get('/test', (req, res, next) => {
    // res.json({ msg: 'success222' })
    // next方法表示放行函数
    console.log(222);
    // 前面已经end了，后面不能继续返回了
    // res.write('666')
    // res.write('777')
    // res.end('888')
})

// 设置端口号
// app.listen(3000, () => console.log('server listen at 3000'))
app.listen(3000)
```



### 5.4 处理 POST 请求

在Express中处理post请求,同get请求使用方式一致

 app.post(path, callback)

获取post请求的数据

 如果想要获取post请求传递的数据，则需要借助中间件body-parse之后还要进行配置

 app.use(bodyParser.urlencoded({ extended: false }));

 然后我们就可以通过req.body来获取浏览器端提交的数据

```js
// 引入模块
let express = require('express');

// 创建应用程序
let app = express();

// 静态化
app.use(express.static('./web/'))
// 给应用程序添加功能
app.use(express.urlencoded({
    extended: true
}))


// 接收数据
// post请求用post方法接收，get请求用get方法接收
app.post('/login', (req, res) => {
    // req和res是express处理过的，因此拓展了更多的方法
    // 从浏览器端向服务器端传递叫请求
    // 从服务器端向前端传递叫响应
    // console.log(req.url);
    // console.log(req.query);
    // console.log(req.body);
    // 返回结果
    res.json({ msg: 'success' })
})


// 设置端口号
// app.listen(3000, () => console.log('server listen at 3000'))
app.listen(3000)
```



### 5.5 路由对象

在Express中也可以通过路由对象处理各种请求

使用方式：

 1通过Express获取路由模块，

 2 创建路由实例化对象，并配置路由

 3 安装路由对象



​	
