# Ajax与Nodejs第3天

## 一、数据存储

### 1.1 Cookie

cookie是HTTP协议请求头中的一个字段

 用于验证用户是否登录

 由服务器设置，由浏览器保存

登录原理

 当用户通过AJAX或者是表单填写数据完毕之后，浏览器会发送一个HTTP请求到服务器，服务器接收响应并按照HTTP协议里面的规定，给响应头中的set-cookie字段设置，之后返回给前端，前端就按照HTTP协议里面的规定开始解析，检测到set-cookie字段之后，生成cookie文件夹，之后向同一个服务器发送任何请求的时候，都会携带cookie字段，服务器就可以验证用户是否登录

**设置cookie**

 使用方式：res.cookie(key, value, options)

​		 key:  数据名称

​		 value: 设置的数据

​		 options: 配置项

**获取cookie**

 想要获取cookie中的内容 必须借助cookie-parser

 通过req.cookies对象获取，之后要进行设置

浏览器端获去cookie数据，通过document.cookie属性获取

```js
let express = require('express')
let cookieParser = require('cookie-parser');

// 应用
let app = express();

// 静态化
app.use(express.static('./web/'))
// 添加中间件
app.use(express.urlencoded({ extended: true }))
// 使用cookie
app.use(cookieParser())


// post请求
app.post('/login', (req, res) => {
    console.log(req.body);
    // 将数据放在cookie中
    // console.log(res.cookie);
    // 设置cookie
    res.cookie('username', req.body.username, {
        // 存在期 (一个月)
        maxAge: 60 * 60 * 24 * 30 * 1000
    })
    res.cookie('password', req.body.password, {
        // 存在期 (一个月)
        maxAge: 60 * 60 * 24 * 30 * 1000
    })
    // 返回结果
    res.json({
        msg: 'success'
    })
})
// get请求
app.get('/check', (req, res) => {
    // 查看cookie
    console.log(req.cookies);
    // 返回数据
    res.json({ msg: 'check sucdess' })
})

// 端口号
app.listen(3000, () => console.log('http server listen at 3000'))
```



### 1.2 session

在Express中可以通过req.session用于设置以及获取session

当想要获取session中的内容的时候，需要借助中间件 express-session

我们也要进行配置：

 		app.use(expressSession({

​				 secret: 配置密钥

​				 resave: 每一次访问session的时候，是否重置

​				 saveUninitialized: 在初始化的时候是否设置session

​		 }))

```js
let express = require('express')
let cookieParser = require('cookie-parser');
let expressSession = require('express-session');

// 应用
let app = express();

// 静态化
app.use(express.static('./web/'))
// 添加中间件
app.use(express.urlencoded({ extended: true }))
// 使用cookie
app.use(cookieParser())
// 使用session
app.use(expressSession({
    // 加密字段
    secret: 'aichuangleyu',
    // 存储是否不初始化
    saveUninitialized: true,
    // 是否重新存储
    resave: false
}))


// post请求
app.post('/login', (req, res) => {
    console.log(req.body);
    // 工作中，无关紧要的数据放在cookie内（有大小限制）优势：前后端都能访问，劣势：不安全
    // 重要的数据放在session中（少量）优势：安全，劣势：占用服务器端的内容空间
    // 设置cookie
    res.cookie('username', req.body.username, {
        // 存在期 (一个月)
        maxAge: 60 * 60 * 24 * 30 * 1000
    })
    // 密码不能放到cookie里
    req.session.password = req.body.password;
    // 返回结果
    res.json({
        msg: 'success'
    })
})
// get请求
app.get('/check', (req, res) => {
    // 查看cookie
    console.log(req.cookies);
    // 查看session
    console.log(req.session);
    // 返回数据
    res.json({ msg: 'check sucdess' })
})

// 端口号
app.listen(3000, () => console.log('http server listen at 3000'))
```



### 1.3 token

含义：凭证、令牌 生成：由后端生成 存储：存储在前端的cookie中或者本地存储中

格式：头部，数据，签名 作用：验证用户身份

流程机制：客户端使用用户名跟密码发送登录请求。服务端收到请求，去验证用户名与密码

 验证成功后，服务端会生成一个 Token字符串，再把这个 Token字符串发送给客户端，服务器端不会保留该Token字符串。

 客户端收到 Token字符串，可以把它存储起来，比如放在 Cookie 里或者 Local Storage 里。客户端每次向服务端请求资源的时候需要带着服务端签发的 Token字

符串

 服务端收到请求，然后去验证客户端请求里面带着的 Token，如果验证成功，响应本次请求，如果验证失败则服务器可以拒绝

**token 特点：**

 服务器无状态：因为服务器只负责解密而不负责存储

 把所有状态信息都附加在 Token 上，服务器就可以不保存。但是服务端仍然需要认证 Token 有效。

只要服务端能确认是自己签发的 Token，而且其信息未被改动过，那就可以认为 Token 有效。“签名”就是做这个的。

 Token 是在服务端产生的，如果前端使用用户名/密码向服务端请求认证，服务端认证成功，那么在服务端会返回 Token 给前端。

 前端可以在每次请求的时候带上 Token 证明自己的合法地位。如果这个 Token 在服务端持久化（比如存入数据库），那它就是一个永久的身份令牌。

**JWT标准：**

 因为这个过程的验证并不是HTTP协议中规定的方式，而是自定义的。所以很可能一个公司就有一个公司的使用方式。（程序员们从一个公司到了另一个公司，还要再学习另一套使用方式）。所以，就出现了标准。

标准的 Token 有三个部分：

​	 header（头部）

​	 payload（数据）：iss：Issuer，发行者，sub：Subject，主题，aud：Audience，观众，exp：Expiration time，过期时间，nbf：Not before，iat：Issued at，发行时间，jti：JWT ID

​	 signature（签名）：header，payload，secret

**使用步骤**：

 1 引入jwt(jsonwebtoken)模块

 2 定义指定加密字符串

 3 当用户登录成功之后 通过jwt提供了sign方法。可以将用户的信息以及加密字符串捆绑到一起生成token字符串

 4 将用户的信息返回给前端。前端可以将token字符串保存在本地存储中

 5 当前端再次发送请求的时候，将token字符串携带到服务器中

 6 经过jwt提供的verify方法进行解密。之后返回给前端

```js
let express = require('express')
let cookieParser = require('cookie-parser');
let expressSession = require('express-session');
let jwt = require('jsonwebtoken');

// 应用
let app = express();

// 加密字符串
const token = 'aichuangleyu'

// 静态化
app.use(express.static('./web/'))
// 添加中间件
app.use(express.urlencoded({ extended: true }))
// 使用cookie
app.use(cookieParser())
// 使用session
app.use(expressSession({
    // 加密字段
    secret: 'aichuangleyu',
    // 存储是否不初始化
    saveUninitialized: true,
    // 是否重新存储
    resave: false
}))


// post请求
app.post('/login', (req, res) => {
    console.log(req.body);
    // 工作中，无关紧要的数据放在cookie内（有大小限制）优势：前后端都能访问，劣势：不安全
    // 重要的数据放在session中（少量）优势：安全，劣势：占用服务器端的内容空间
    // 设置cookie
    // res.cookie('username', req.body.username, {
    //     // 存在期 (一个月)
    //     maxAge: 60 * 60 * 24 * 30 * 1000
    // })
    // // 密码不能放到cookie里
    // req.session.password = req.body.password;
    // 通过token实现加密
    jwt.sign(req.body, token, (e, data) => {
        console.log(e, 111, data);
        // 方案2：放在cookie里存储
        res.cookie('token', data, {
            // maxAge: 1000 * 60 * 60 * 24 * 30
        })
        res.json({
            msg: 'success',
            // 方案1：响应中返回token数据，存储到本地存储
            data
        })
    })
    // 返回结果
   
})
// get请求
app.get('/check', (req, res) => {
    // 查看cookie
    // console.log(req.cookies);
    // // 查看session
    // console.log(req.session);
    // 解析token数据
    // 所以token解决了前端存储不安全的问题，以及后端存储占用内存空间的问题
    jwt.verify(req.cookies.token, token, (e, data) => {
        console.log(e, 222, data);
    })
    // 返回数据
    res.json({ msg: 'check sucdess' })
})

// 端口号
app.listen(3000, () => console.log('http server listen at 3000'))
```



## 二、模板引擎

### 2.1 EJS

EJS是后台服务器模板，天生可以与Express搭配使用，无需引入，但是需要下载：npm install ejs

可以通过res.render方法渲染一个模板，在该页面中提供了<%=%>插值语法

在<%=%>是真正的js环境，因此可以表达式。使用步骤：

 1 下载ejs 

 2 创建一个views文件夹

 3 在views文件中创建以.ejs后缀名称的文件

 4 可以通过res.render(path, data)渲染一个模板

 5 在<%=%>书写要被替换的内容

```js
var express = require('express');
var ejs = require('ejs');

let app = express();
// 配置模板拓展名
app.engine('.html', ejs.__express)

let num = 0;
// 请求
app.get('/', (req, res) => {
    var data = {
        title: '爱创乐育',
        intro: {
            content: '爱创乐育是爱创课堂旗下的IT教育品牌',
        },
        doms: '<a href="https://www.icketang.com">官网</a>',
        num: ++num
    }
    // res.json({ msg: 'success' })
    // express默认会去views目录下找文件
    // res.render('../index.ejs')
    // res.render('./index.ejs')
    // 当前目录可以省略./
    // res.render('index.ejs', data)
    // 使用html文件
    res.render('index.html', data)
})

// 监听端口号
app.listen(3000)
```



## 三、文件上传

### 3.1 单文件上传

如果想要上传文件，我们必须借助formidable模块

该模块引入之后，除了可以处理普通的post请求之外的数据，还可以处理上传的图片文件等数据……

 注意：此时，必须要给form表单设置enctype属性，才能够让formidable解析req对象

使用步骤：

 1 浏览器端，修改enctype类型为multipart/form-data

 2 服务器端，引入 formidable 模块并实例化

 3 服务器端，修改文件存储位置

 4 服务器端，解析请求对象，获取上传的文件信息

 5 服务器端，通过 fs 模块，存储上传的文件。

```js
let express = require('express')
let Formidable = require('formidable');
let path = require('path');
let fs = require('fs');

// 应用
let app = express();

// 静态化
app.use(express.static('./web/'))
// app.use(express.static('./upload/'))
// 静态化第二种写法
app.use('/upload/', express.static('./upload/'))

// 接收post请求数据
// app.use(express.urlencoded({ extended: true }))

// 接收post请求数据
app.post('/upload', (req, res) => {
    // console.log(req.body);
    // 创建接收post请求数据的对象
    var fd = new Formidable();
    // 修改存储文件的路径
    fd.uploadDir = path.join(process.cwd(), './upload')
    // console.log(fd);
    // 接收数据
    fd.parse(req, (e, fields, files) => {
        // console.log(e, 111, fields, 222, files);
        if (e) {
            // 有错误
            return res.json({ msg: '上传解析失败' })
        }
        // 定义存储文件的名称
        let filepath = '/upload/' + path.parse(files.icktfile.path).name + 
            path.extname(files.icktfile.name);
        // console.log(filepath);
        // 重命名
        fs.rename(files.icktfile.path, path.join(process.cwd(), filepath), e => {
            if (e) {
                // 有错误
                return res.json({ msg: '重命名出现错误' })
            }
            // 返回结果
            res.json({ data: filepath })
        })
    })
})

// console.log(path.parse('E:\\ickt_50\\13 nodejs\\example\\07 文件上传\\upload\\upload_562caacc9ba79b597f9981f759b006b7'));

// 端口号
app.listen(3000, () => console.log('http server listen at 3000'))
```



### 3.2 多文件上传

如果想要选中多个文件，必须给input元素添加multiple属性

此时，就可以按下ctrl同时选中多张图片

但是如果还是使用单文件上传的方式接收文件就不行了

此时要再服务器端监听一个事件: file事件

该事件会在每一次上传的时候都会执行一次

```js
let express = require('express')
let Formidable = require('formidable');
let path = require('path');
let fs = require('fs');

// 应用
let app = express();

// 静态化
app.use(express.static('./web/'))
// 静态化第二种写法
app.use('/upload/', express.static('./upload/'))

// 接收post请求数据
app.post('/upload', (req, res) => {
    // res.json({ msg: 'success' })
    // 创建fd对象
    let fd = new Formidable();
    // 修改缓存位置
    fd.uploadDir = './upload';
    // 文件数组
    let arr = []
    // 监听接收文件的事件
    fd.on('file', (key, file) => arr.push(file))
    // 接收文件
    fd.parse(req, (e, fields, files) => {
        // console.log(e, 111, fields, 222, files);
        // 都接收完毕
        // console.log(1111, arr);
        if (e) {
            return res.json({ msg: '解析错误' })
        }
        // 没有错误，重命名
        arr = arr.map(file => new Promise((resolve, reject) => {
            // 定义文件的名字
            let filepath = './upload/' + path.parse(file.path).name + 
                path.extname(file.name);
            // 重命名
            fs.rename(file.path, filepath, e => {
                if (e) {
                    // 操作失败
                    reject(e)
                } else {
                    resolve(filepath)
                }
            })
        }))
        // 并行执行
        Promise.allSettled(arr)
            .then(e => res.json(e))
    })
    // console.log(fd);
})


// 端口号
app.listen(3000, () => console.log('http server listen at 3000'))
```



## 四、MongoDB

### 4.1 mongodb

数据库：简单理解为存储数据的仓库。世界上有各种各样的数据库应用程序。大致可分为两类：

 SQL数据库（关系型数据库）： mySql、oracle、sqlserver等

 NoSql数据库（非关系型数据库）：Mongodb数据库等

SQL数据库：

 结构化查询语言：structure query language 

 它的结构组成：应用程序 => 数据库 => 表 => 数据。使用SQL数据库要学习SQL语言。

NoSql数据库

 它的结构组成：应用程序 => 数据库 => 集合 => 文档。

 SQL与NOSQL的最大区别在于NoSQL的集合中的文档，它的结构可以不固定。

### 4.2 安装 mongodb

官网：https://www.mongodb.com/

配置环境变量

作用： 是为了扩大调用命令的范围

具体步骤：

我的电脑点右键-属性-高级系统设置-环境变量-系统变量-path

将C:\Program Files\MongoDB\Server\3.2\bin目录粘贴到path路径的最后面（不要忘记在前面加上;）

最后点击确定按钮 我们就可以在任何盘符下使用命令

### 4.3 开启数据库

我们可以通过提供的mongod指令开启

 默认开启的是：c:/data/db

 默认端口号： 27017

此时会报错, 没有找到该目录：我们可以在c盘创建data目录以及db文件夹

开启指定的数据库

 我们可以输入 mongod --dbpath 目标数据库

 例如： mongod --dbpath c:/ickt

### 4.4 数据库操作

连接数据库

 可以使用mongo指令即可，连接一个已经开启的数据库

开启多个数据库

 当我们需要开启多个数据库的时候。此时，需要指定新的端口号

 例如：mongod --dbpath c:/ickt26 --port 27018

连接指定的数据库

 当我们需要连接指定的数据库的时候。此时， 需要输入其它指令：

 例如： mongo --port 27018

### 4.5 常用指令

查看数据库：show dbs

创建/切换数据库：use dbName

查看集合：show collections

添加数据：db[collectionName].insert({})

 以上一个指令，做了两件事件：1 创建了一个use集合 2 插入了一条数据

查看集合中数据：db[collectionName].find()

查看所在数据库：db

删除数据：db[collectionName].deleteOne()

清空数据：db[collectionName].remove()

修改数据：db[collectionName].update(query, updated, options)

 query： 查询条件

 uptated: 修改成为的数据

 options： 是配置项 决定是否修改多项数据

当我们修改之后，发现数据丢失了，如果只是想要修改数据中的某一个字段的时候

 提供了$set修改器，允许我们只对其中的某一个字段修改

删除指定的集合：db[collectionName].drop()

删除指定的数据库：db.dropDatabase()

### 4.6 NodeJS 中操作数据库

nodejs与Mongodb都是单独的应用程序

 如何通过nodejs操作mongodb数据库呢

 需要借助模块： mongodb

总结

 服务器，浏览器，数据库的关系，可以将服务器看成是搬运工：

  数据库中的数据，通过服务器端传递给浏览器端，去渲染视图。

 浏览器端交互产生的数据，通过服务器端存储在数据库中。

​	



​	











