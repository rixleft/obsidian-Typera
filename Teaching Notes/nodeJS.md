# Ajax与Nodejs第1天



## 一、服务器

### 1.1 服务器模型

根据架构可以分成B/S 和 C/S

​	B/S 就是 Browser-Server 也就是浏览器 对应 服务器

​	C/S 就是 Client-Server 也就是客户端对应服务器

​	其实Browser也是一个客户端。但是与C/S的客户端的不同在于：qq的客户端只能够去连接qq的服务器，微信的客户端只能够去连接微信的服

务器。游戏的客户端只能连接对应的游戏（LPL只能连接LPL的服务器、 梦幻西游只能连接梦幻西游的服务器）而Browser并没有限制连接的是

哪个服务器 你既可以访问百度的服务器，又可以访问网易的服务器，还可以访问其它任何拥有域名或IP地址的服务器。

​	服务器（Server）简单来说是可以提供服务（响应）的机器。是在网络环境下运行的应用程序， 为网上的用户提供共享信息和各种服务的一种

高性能计算机。浏览器作用: 是为了给用户渲染页面的

## 二、HTTP

### 2.1 HTTP 协议

HyperText Transfter Protocal 超文本传输协议

里面规定了前端如何发送请求，后端又如何接收数据的一些列相关规定

在很久以前，浏览器的目的只是为了渲染一个静态页面，此时，面临一个问题，当前端发送一个请求到后端的时候，后端如何接收，后端返回数

据前端又如何解析，于是HTTP协议就出现了

例如：当前端发送一个请求到后端，请求一张图片的时候，此时，前端就必须按照HTTP协议里面的规定发送一个请求， 后端接收并返回数据的

时候也必须按照HTTP协议中的规定，以正确的格式返回内容

还有一个问题，服务器的承载数量（连接数量）是有限的，比如当一个服务器的连接数量是10，此时，前端发送一个请求过来，并且还是有状态

的（持久连接），就占用了一个连接，但是，在当时浏览器只是为了渲染静态页面而已，没有必要是持久连接，所以还特意为HTTP协议设置为

无状态（没有持久连接）

### 2.2 URL

url：统一定位资源符

​	作用：定位网络中的资源和访问方式的一种简洁的表示， 俗称：网址。例如：

​		https://www.baidu.com/ 百度的URL

​		https://www.163.com/   网易的URL

一个完整的URL包括：http://localhost:3000/flappy/index.html?a=1&b=2#ccc

> ​	协议(protocal): 协议包含 http、https		
>
> ​	域名(domain): 指向访问的域名（主机）
>
> ​	端口(port): 共65535个					
>
> ​	路径(path): 具体的资源定位
>
> ​	文件(file):打开的文件名称	
>
> ​    搜索词(query): 提供给服务器上的值（静态资源在一般情况下是不需要query字符串的）
>
> ​	哈希(hash): 提供给前端的值
>
> ​	

### 2.3 域名

浏览器之间相互识别是通过ip地址，也就是说当我们输入一个网址的时候，浏览器是不认识我们输入的一堆字符串，而真正识别的是：转为对应

的ip地址（数字）

域名的来历：

​	人类对于数字来说记忆里并没有那么强， 但是对于英文字符来说却比较容易接受，所以需要域名解析系统（DNS）, 它的作用：将输入的网址

转为对应的ip地址，这个就是域名解析系统的价值所在

### 2.4 缓存

缓存：暂时存储的意思

浏览器的缓存机制

​	当用户访问一个页面的时候，浏览器会将一部分的信息保存到本地，之后再次发送同样请求的时候，则直接使用本地中的资源，这样做的好处

是避免了带宽的浪费，提供了页面加载的速度

缓存也是分为两种：

- 强制缓存：如果命中强制缓存，则不会发送新的请求到服务器，直接使用本地中的资源

- 协商缓存：一旦命中协商缓存，会照样发送请求到服务器，询问“服务器中有没有数据更新”，如果数据更新了，则带回更新之后的内容，重

  新设置新的缓存，替代原来的缓存，如果没有更新内容，则不会带回新的数据，而是通过浏览器直接使用本地中的资源

### 2.5 链接过程

当用户输入网址并按下回车之后的过程：

​	1 在地址栏中输入网址

​	2 经过域名解析系统将输入的网址解析为对应的ip地址

​		尝试从本地浏览器缓存中寻找

​		尝试从本系统缓存中寻找

​		尝试从路由器缓存中寻找

​		尝试从域名服务器中寻找

​	3 尝试发送请求，建立TCP连接

​		TCP是传输层的协议，里面规定了数据传递和连接方式的规范

​		而HTTP协议是应用层的协议，定义传输内容的规范

​		就好比网络是一条路，TCP就是在路上跑的车，HTTP是在车里的人，每一个网站都有不同的内容，就好像车里的人都有不同的经历和故事

​	4 发送HTTP请求到服务器

​	5 服务器要接收响应，按照HTTP协议中的规定，返回数据，之后要断开连接

​	6 浏览器接收到数据之后，开始解析第一个HTML页面

​		解析DOM树、样式树。遇到link标签、script标签，img标签又会重新发送一次请求

​	7 渲染页面给用户

### 2.6 HTTP 请求

HTTP协议： 规定了前后端传递数据的规范

HTTP请求： 是按照协议的规定发送一次请求

​	从浏览器发送请求到服务器，这个行为我们称为请求

​	从服务器返回数据到浏览器，这行行为我们称为响应

HTTP请求的组成

​	http请求的组成：

​		1 请求首行  

​		2 请求头 

​		3 请求空行 

​		4 请求正文

**请求空行**：请求空行就是一个空白行，为了区分请求头与请求正文的
**请求正文**：所有的数据都应当放入请求正文。get请求没有请求正文

### 2.7 请求类型

请求就是浏览器到服务器请求数据的过程

按照目的通常分为两种方式：

​	可以从服务器带回内容到浏览器， 称为get请求

​	可以从浏览器协带数据到服务器， 称为post请求

### 2.8 GET 请求

可以从服务器带回内容到浏览器

特点：

​	get请求没有请求正文

​	数据是携带在URL中，长度受到限制，不能携带大量的数据

​	通常只能携带一些非机密性的信息

​	触发方式多种多样的

​	方便分享

### 2.9 POST 请求

可以从浏览器协带数据到服务器

特点：	

​	数据都在请求正文（请求体）中

​    		通常携带一些机密性的数据， 数量不受限制

​	触发方式只有两种：

   		 1 通过表单发送

​    		2 通过AJAX发送

### 2.10 HTTP 的无状态

HTTP是一个无状态的协议，也就是说当发送一次请求之后，服务器返回数据之后就会断开连接

在HTTP1.0版本中，在请求头中的一个connection字段中对应的值是close

在HTTP1.1版本中，在请求头中的一个connection字段中对应的值是keep-alive

​	当值是close的时候，浏览器发送请求到服务器，服务器接收响应并返回数据之后，立即断开连接

​	当值是keep-alive的时候，浏览器发送请求到服务器，服务器接收响应并返回数据之后，此时不会立即断开连接，而是保持一段时间的连接，

如果在这段时间之内，发送同样请求的时候，直接使用之前已经建立的链接通道，如果在一定的时间之内，没有发送请求就会自动断开连接

## 三、NodeJS

### 3.1 介绍

我们知道js这门语言是需要依赖于宿主环境，而最受欢迎的宿主环境是浏览器

但是，它并不是唯一的选择，完全可以脱离浏览器在后端运行，nodejs就是运行在服务器端的一门语言。

官网

​	https://nodejs.org/en/

NodeJS有三大特点：

​	单线程，

​	非堵塞IO，

​	事件驱动

### 3.2 NodeJS 特点

**单线程**

​	整个程序只有一条线程执行（同一时间只能做一件事）

**非阻塞I/O**

​	I/O： input/output 输入/输出

​		input:  从磁盘中输入内容到内存中		output: 从内存中读取内容到磁盘中

​	非阻塞I/O： 当线程执行的时候，如果遇到了I/O操作，只是开启一个任务，线程不会等待，去执行下一条任务

​	阻塞I/O： 当线程执行的时候，如果遇到了I/O操作，开启一个任务并等待任务执行完毕之后，才去执行下一个任务

**事件驱动**

​	由于nodejs是非阻塞的，线程不会等待，但是后续的任务如何执行呢？此时会触发一个事件，由该事件将后续的任务重新放入执行队列中

（nodejs循环队列）

适用场景

​	使用nodejs搭建的服务器，特别适用异步多，高并发

​	不适合计算，因为计算是同步的，会造成阻塞

举例：比如火车站的售票窗口，所有人都要去售票窗口买票，如果每一个人都争抢着去买票，这样的话，什么也做不了，所以要引入排队机制

再比如我们都要坐公交车，有些时候司机时候只会打开前门，此时每一个人都抢着上车的话，可想而知，

什么也做不了，所以也要引入排队机制

现实生活中如此，程序也是如此，如果不引入排队机制将会一直阻塞

回到nodejs中，既然它是单线程，就不能造成阻塞，就好比一个人在售票窗口买票的时候，发现自己没有带钱，于是打电话叫朋友过来送钱，此

时这个人依然站在售票窗口前，坚决不肯让出自己的位置，这样的话就势必会造成阻塞

现实中，最好的解决方式是：这个人应该始终与后面这个人交换位置。

所谓事件驱动就是，一旦你造成阻塞了，你就靠边站，当等到什么时候不再阻塞，你再通知我，我再把你加入排队当中，再次等待被处理

### 3.3 运行 NodeJs

cd 目录 		用于打开目录

执行命令：	node 文件名称

盘符命令：	想要从C盘切换到D盘：在控制台输入D冒号按下回车即可。

​			想要从D盘切换到E盘：在控制台输入E冒号按下回车即可

退回上一级目录：	cd .. 或者是 cd ../ 即可退回上一级目录

补全文件名称：	点击tab键， 用于补全文件名称  还可以切换文件

命令历史记录：	在使用命令的时候，我们可能要使用之前的命令，此时在键盘上按下上下箭头，即可找回之间的使用的命令

清屏命令：	输入 cls 指令即可清屏

### 3.4 模块化

nodejs也是模块化的。模块化的代表框架：

​	RequireJS：遵循的是AMD规范（异步规范），一个文件就是一个模块

​		引入文件通过：通过require方法引入。

​		暴露接口：exports，module.exports，也可以使用return这种方式

​	Seajs：遵循的是CMD规范（异步规范），一个文件就是一个模块。

​		引入文件通过require方法。		暴露接口：exports，module.exports

​	Nodejs是遵循CommonJS规范（同步规范）：一个文件就是一个模块

​		引入文件通过require方法

​		暴露接口：exports，module.exports

### 3.5 模块分类

在nodejs中模块分为三类：

​	1 内置模块 	 （核心模块）

​		例如：HTTP、HTTPS、Path、FS、QueryString……

​		内置的模块可以直接引入并使用，通过require方法直接引入模块名称

​	2 第三方模块 	（自定义的模块）

​		例如：babel-core、typescript

​		第三方模块需要通过npm安装后才能使用，通过require方法直接引入模块的名称

​	3 文件模块	（一个文件就是一个模块）

​		引入文件模块要使用相对路径（相对于当前文件所在的位置，如：./	../）

### 3.6 node_modules

该文件夹用于存储所有的第三方模块，当把文件存储在该文件夹中，我们就可以像引入内置模块那样来引入模块文件了

​	注意：该文件夹的名称必须是node_modules 只有这样nodejs才认识它

特点：

​	该文件所处的位置可以是在引入文件的同级也可以是上级目录或者是上上级目录（祖先目录，直到硬盘的根路径），当我们引入模块的时候，

就可以根据就近原则，找到node_modules文件夹中对应的模块

```js
// 通过require可以引入模块
// 1 内置模块
// let path = require('path')
// console.log(path);

// 2 第三方模块
// 需要安装： npm install 模块名称
// Error: Cannot find module '@popperjs/core'
// 使用模块，错误信息：XX模块没有找到，就安装该模块
// let color = require('color')
// console.log(color);
// 引入第三方模块，会从当前目录下的node_modules里面查找模块，没有就向上层目录查找，一直到根目录
// 直到硬盘的根目录有vue模块就找到了
// let vue = require('vue');
// console.log(vue);
// 到硬盘根目录下，没有改文件，就会报错
// let ickt = require('ickt')
// 引入第三方模块，可以携带路径分隔符
// let vue = require('vue/dist/vue')


// 3 自定义模块(要使用相对路径)
// ./ 代表当前位置， ../代表上层目录，  绝对不能省略
// let msg = require('./ickt/msg.js')
// .js拓展名可以省略
// let msg = require('./ickt/msg')
// 相对路径不能省略，否则会当作第三方模块查找
// let msg = require('ickt/msg')

// 引入父级目录下的模块
let c = require('../a/b/c')

// 目录文件内index.js是默认文件，可以省略
// let index = require('./ickt/index.js')
// let index = require('./ickt/index')
// let index = require('./ickt')

// 引入文件
// 文件和文件夹同名，优先引入文件，其次是文件夹下的index.js文件
// let demo = require('./demo')
// 带有相对路径一定是node_modules外面的文件
// let demo = require('demo')

// 将自定义模块变成第三方模块（将文件放在node_modules目录下）
// 自定义模块
// require('./ickt/msg')
// 第三方模块
// require('ickt/msg')

// 第三方模块变成自定义模块
var color = require('./color')
console.log(color);
```



## 四、内置模块

### 4.1 HTTP

HTTP模块用于搭建服务器的

**创建服务器**

​	createServer(handle)	该方法用于搭建HTTP服务器

​		handle: 处理函数，函数中有”两个”参数：

​			第一个参数：req对象： 全称request  请求对象，常用的属性：

​				url（本次请求的路径）

​				method（本次请求的方式) 

​				headers（请求头对象相关信息）				

​			第二个参数：res对象：  全称response 响应对象，常用的属性：

​				write（返回数据 不会断开连接 必须与end方法一起使用）

​				end（返回数据 会断开连接，该方法只接受字符串类型的参数以及Buffer数据类型） 

​				setHeader（用于设置响应头）返回值是服务器对象

**监听方法**

​	listen(port, ip, handle)

​		port:    	监听的端口号 不要使用1000以内的（可能被占用）

​		ip:     		指定的ip地址，可以省略

​		handle:  	监听成功之后执行的方法

```js
// 内置模块可以直接引入
let http = require('http')

// 创建服务器
let app = http.createServer((req, res) => {
    // http://localhost:3000/a/b/c/index.js?color=red&num=100#demo
    // console.log(req, 1111, res);
    // 获取数据 (请求)
    // url只能获取path和file以及query， 看不到hash
    // console.log(req.url);
    // console.log(req.method);
    // console.log(req.headers);

    // 返回数据 （响应）
    // 修改响应头
    res.setHeader('Content-Type', 'text/html; charset=utf-8')
    res.setHeader('tel', '12345678901')
    // 返回数据
    res.write('<h1>hello ickt !!!</h1>')
    res.write('100')
    // 结束
    res.end('200');
    // 安装nodemon指令，可以再保存的时候，自动重启
    // 全局安装 npm i -g nodemon 
})

// 设置端口号
app.listen(3000, () => {
    console.log('http server listen at 3000');
})
```



### 4.2 FS

FS模块全称: file System  文件系统。作用是用于操作文件夹以及文件的，使用的时候要引入fs模块。操作文件是异步的，因此fs模块为每一个操作提供了两个方法：同步方法（sync），异步方法（回调函数监听）

**创建文件**

​	fs.appendFile(fileName, content,  callback)

​		fileName:  	创建的文件名称（合法的路径）

​		content:		追加的内容

​		callback：	回调函数

​			参数表示错误异常

​			如果创建成功 则返回null，如果创建失败 则返回一个错误对象

**创建文件夹**

​	fs.mkdir(pathName, callback)		该方法用于创建文件夹

​		pathName: 	文件夹名称

​		callback:		回调函数

​			参数表示错误异常

​			如果创建成功 则返回null，

​			如果创建失败 则返回一个错误对象

**删除文件**：

​	fs.unlink(fileName, callback)	该方法用于删除文件

​		fileName: 	要删除的文件

​		callback:		回调函数

​			参数表示错误异常

​			如果删除成功 则返回null

​			如果删除失败 则返回一个错误对象

**删除文件夹**

​	fs.rmdir(dirName, callback)	该方法用于删除文件夹

​		注意： 该方法只能删除空文件夹

​		dirName：	要删除的文件夹名称

​		callback:		回调函数

​			参数表示错误异常

​			如果删除成功 则返回null

​			如果删除失败 则返回一个错误对象

**修改文件名称**

​	fs.rename(oldName, newName, callback)	该方法用于修改文件名称

​		oldName：	被修改的文件名称

​		newName:	被替换的文件名称

​		callback:		回调函数

​			参数表示错误异常

​			如果修改成功 则返回null

​			如果修改失败 则返回一个错误对象

**读取文件**

​	fs.readFile(fileName, callback)	该方法用于读取文件

​		fileName:		要读取的文件名称

​		callback:		回调函数，有两个参数：

​			第一个参数：错误异常

​				如果创建成功 则返回null，

​				如果创建失败 则返回一个错误对象

​			第二个参数  读取成功时候的数据

​				默认是Buffer数据 我们可以调用toString方法转为字符串之后查看

**判断文件的状态**

​	fs.stat(targetName, callback)		该方法用于判断文件的状态

​		targetName：	 要判断的文件名称

​		callback:		 回调函数，有两个参数：

​			第一个参数是错误异常

​			第二个 是状态对象

​				我们可以通过状态对象调用isDirectory

​					如果为真 则表示是文件夹

​					如果为假 则表示文件

**读取文件夹**

​	fs.readdir(dirName, callback)		该方法用于读取文件夹

​		dirName:		读取的文件夹的名称

​		callback:		回调函数，有两个参数

​			第一个参数表示错误异常

​			第一个参数是一个数组，数组中的每一项都是读取到的每一个文件

注意：在fs模块中，方法后面加上Sync就是同步的

```js
let fs = require('fs');

console.log('start');

// 读取文件
// 同步
// let data = fs.readFileSync('demo.js')
// // buffer
// console.log(data);
// // buffer转成字符串
// console.log(data.toString());
// 读取内容，设置编码，会自动转成字符串
// let data = fs.readFileSync('demo.js', 'utf-8')
// console.log(data);

// 异步
// fs.readFile('demo.js', 'utf-8', (e, data) => console.log(e, data))

// 不能读取文件夹
// fs.readFile('a', 'utf-8', (e, data) => console.log(e, data))
// let data = fs.readFileSync('a', 'utf-8')
// console.log(data);

// 获取文件信息
// 同步
// let data = fs.statSync('a')
// let data = fs.statSync('demo.js')
// // isDirectory 判断是否是目录
// console.log(data, 11, data.isDirectory());
// 异步
// fs.stat('a', (e, data) => console.log(e, data, 222, data.isDirectory()))
// fs.stat('demo.js', (e, data) => console.log(e, data, 222, data.isDirectory()))

// 多层文件
// fs.stat('a/b.txt', (e, data) => console.log(e, data, 222, data.isDirectory()))
// let data = fs.statSync('a/b.txt')
// console.log(data, 11, data.isDirectory());

// 文件不存在(不能读取信息)
// fs.stat('a/haha.txt', (e, data) => console.log(e, data, 222, data.isDirectory()))
let data = fs.statSync('a/haha.txt')
console.log(data, 11, data.isDirectory());


console.log('end');
```


