# Vue	第十天

## 一、SSR

### 1.1 ssr

全称：server side render（服务器端渲染），让我们可以在服务器端渲染应用程序。

前端渲染问题：

​	 1 白屏时间长，影响用户体验。

​	 2 不利于搜索引擎优化（ SEO ）

所以我们要在服务器端渲染应用程序

服务器端渲染：vue为服务器端渲染提供了模块 -- vue-server-renderer

​	 该模块提供了createRenderer方法，来创建渲染器

​			 渲染器提供了renderToString方法，渲染应用程序组件

​			 渲染器实现了promise规范，因此：可以通过then方法监听成功，可以通过cache方法监听失败

```js
let express = require('express');
// 引入服务器端渲染模块
let { createRenderer } = require('vue-server-renderer');
let Vue = require('vue');

// console.log(VueServerRenderer);

let IcktApp = new Vue({
    template: `
        <div>
            <h1 @click="clickH1">app part -- {{msg}}</h1>
            <input type="text" v-model="msg" />
        </div>
    `,
    // template: `
    //     <div>haha</div>
    //     <div>
    //         <h1 @click="clickH1">app part -- {{msg}}</h1>
    //         <input type="text" v-model="msg" />
    //     </div>
    // `,
    data: {
        msg: 'hello'
    },
    methods: {
        clickH1() {
            console.log('click h1');
        }
    }
})

// 创建渲染器
let renderer = createRenderer();
// console.log(renderer);
renderer.renderToString(IcktApp)
    .then(
        // 渲染成功
        html => console.log(html),
        // 渲染失败
        err => console.log('err', err)
    )

let app = express();

app.get('/', (req, res) => {
    res.json({ msg: 'success' })
})

app.listen(3000)
```





### 1.2 渲染模板

渲染模板：想在模板中渲染应用程序分成两步：

​	 第一步 在createRenderer方法中，通过template引入模板文件

​	 第二步 在模板文件中,通过<!--vue-ssr-outlet-->定义应用程序渲染的位置。

前后端同步渲染

​	 浏览器端渲染（前端）：

​			 1 白屏时间长，影响用户体验，

​			 2 不利于SEO优化

​	 服务器端渲染（后端）：

​			 无法绑定交互，

为了解决浏览器端与服务器端渲染的问题，我们要使用前后端同步渲染技术。

```js
let express = require('express');
let ejs = require('ejs');
let fs = require('fs');
// 引入服务器端渲染模块
let { createRenderer } = require('vue-server-renderer');
let IcktApp = require('./ickt');


// 创建渲染器
let renderer = createRenderer({
    // （1）引入模板
    template: fs.readFileSync('./views/index.html', 'utf-8')
});

let app = express();
// 拓展名
app.engine('.html', ejs.__express);

app.get('/', (req, res) => {
    // res.json({ msg: 'success' })
    // res.render('index.html')
    // 服务器端渲染，无法绑定交互
    renderer.renderToString(IcktApp)
        .then(
            // 渲染成功
            html => res.end(html),
            // 渲染失败
            err => console.log('err', err)
        )
})

app.listen(3000)
```



### 1.3 前后端渲染环境

前端渲染

​	 是为了给用户使用，因此希望资源加载的快（压缩，打包，添加指纹等等）

 	为了更好的效果，我们要加载样式；为了看到页面，我们要处理模板等，......

但是服务器端渲染不需要考虑这些问题，只需要一个应用程序组件，并最终将其渲染成字符串。

因此前后端渲染有不同的入口文件，有不同的webpack配置

 	有不同的入口文件

​			 前端入口文件，要让应用程序组件上树；

​			 后端入口文件，只需要一个应用程序组件

​	 不同的webpack配置

​			 前端要考虑样式，模板，性能优化（压缩，打包，添加指纹等）等

​			 后端只要将ES Module规范，编译成CommonJS规范即可。

```js
let path = require('path');
let { VueLoaderPlugin } = require('vue-loader');
let VueServerRenderer = require('vue-server-renderer/server-plugin');

const root = process.cwd();
module.exports = {
    mode: 'development',
    // mode: 'production',
    // ~~~~~~ 给ndoe使用
    target: 'node',
    // ~~~~~~ 入口文件
    entry: './home/src/entry.server.js',
    // 发布
    output: {
        filename: '[name].js',
        // 发布位置
        path: path.join(root, './server/static/'),
        // 静态资源相对位置
        publicPath: '/static/',
        // ~~~~~~ 规范
        libraryTarget: 'commonjs2'
    },
    // 解决问题
    resolve: {
        alias: {
            vue$: 'vue/dist/vue.js',
            '@': path.join(root, './home/src')
        },
        // 拓展名
        extensions: ['.js', '.vue']
    },
    // 模块
    module: {
        rules: [
            // es6
            // css
            {
                test: /\.css$/,
                use: ['css-loader']
            },
            // sass
            {
                test: /\.scss$/,
                use: ['css-loader', 'sass-loader']
            },
            // vue
            {
                test: /\.vue$/,
                loader:'vue-loader'
            }
        ]
    },
    // 插件
    plugins: [
        new VueLoaderPlugin(),
        new VueServerRenderer({
            filename: '../build/ickt.json'
        })
    ],
}
```



### 1.4 目录部署

config  存储配置文件

home  前端开发的项目

views  模板目录

static  静态资源

app.js  服务器入口文件

### 1.5 npm 指令

由于webpack配置存储到特定位置，因此启动webpack指令很长

​	 webpack --config 文件位置

为了简化webpack的运行，我们可以配置一些npm指令，像vue cli一样运行：

​	 npm run client  运行前端配置

​	 npm run server  运行服务器端配置

​	 npm run start  同时运行前后端配置

​	 npm run start:client 监听并运行前端配置

​	 npm run start:server 监听并运行后端配置

我们要在package.json中，配置scripts项，来定义指令。

### 1.6 服务器端渲染

1 不需要模板，不用写html插件

2 不需要样式，不用写style-laoder，不需要拆分样式

3 不需要性能优化、拆分模块，添加指纹，服务器端本地引入文件，因此打包在一起就可以了等

4 通过target: node配置，说明给node使用。

5 在output.libraryTarget: commonjs2, 将ES Module规范转成commonjs规范

6 使用vue-server-renderer插件，发布json文件。

​	 在参数对象中，通过filename属性，可以自定义json文件的发布位置。

......

### 1.7 服务器端渲染

为了使用发布的json文件，vue-server-renderer提供了createBundleRenderer方法。

​	 第一个参数表示json文件

​	 第二个参数表示配置对象

​			 template定义模板文件的位置

插值语法：vue服务器端渲染允许我们在渲染页面的时候，向页面中，插入一些数据。

​	 在renderToString方法中传递数据。

​	 在模板中，通过插值语法插入数据

​			 {{}}  渲染文本插值

​			 {{{}}} 渲染标签插值

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 三对大括号代表渲染标签插值语法，相当于v-html指令 -->
    {{{meta}}}
    <!-- 通过插值语法显示 -->
    <title>{{title}}</title>
</head>
<body>
    <!-- 模拟百度实现: 转成json存储 -->
    <textarea id="data_ickt" style="display: none;">{{{JSON.stringify(data)}}}</textarea>
    <!-- 模拟淘宝实现 -->
    <script>
        window.clientData = {{{JSON.stringify(data)}}}
    </script>
    <!-- <div id="app"></div> -->
    <!--vue-ssr-outlet-->
</body>
</html>
```



### 1.8 同步数据

​	同步数据就是与页面一起返回的数据。

​	 由于是与页面一起返回的，因此我们可以在页面中直接使用这些数据，不必发送请求了。

​	 一些重要的，需要首屏渲染的内容，我们可以放在同步数据中。

1.9 **路由同步**

 路由同步就是说 -- 前后端渲染的页面是一致的。

 如果使用hash路由，改变hash，不会向服务器端发送请求，因此服务器端不会更新页面，并且服务器端无法获取hash数据，无法解析hash数据。

 所以在前后端同步渲染的时候，只能使用history路由测试（多页面应用程序了）。

 当使用history策略的时候，不同页面应该请求同一个路径下的静态文件，所以静态文件的路径应该是绝对路径。注意：使用history策略，服务器端要做重定向。

### 1.9 前后端解析

前端解析：前端有路由模块，是专门用来解析前端路由的。

后端解析：后端要在渲染页面的时候解析，

​		 所以要通过请求对象获取url地址

​		 在将url地址提交给vue-router模块创建的路由实例化对象去解析。

为了将url信息传递给后端入口文件，我们分成两步：

​		 第一步 在renderToString方法中，传递数据

​		 第二步 将后端入口文件改成一个返回promise对象的方法。

​				 方法的参数就是renderToString方法传递的数据。

​				 在方法中，我们解析路由，并最终使用promise对象的resovle或者reject方法，返回处理结果。

### 1.10 解析路由

我们可以使用路由模块解析路由，路由实例化对象提供了一些方法

​	 push  将一个新的地址加入到路由序列中。

​	 onReady 监听路由解析完毕

​	 getMatchedComponents  当前路由规则下，匹配的组件。

```js
// 服务器端入口文件
import app from './main';
import router from './router';

// export default app;
// 暴露方法，可以接收renderToString传递过来的数据
export default data => new Promise((resolve, reject) => {
    // console.log(data, 111);
    // 利用路由对象，处理地址
    router.onReady(() => {
        // console.log(router.getMatchedComponents(), 22222222);
        if (router.getMatchedComponents().length) {
            resolve(app)
        } else {
            reject({
                status: 404,
                msg: 'not found'
            })
        }
    })
    router.push(data.url)
})
```



## 二、Vue3

### 2.1 vue3

2020年9月18日，Vue.js发布3.0版本，代号：One Piece（海贼王）

​		 耗时2年多、2600+次提交 、30+个RFC、600+次PR 、99位贡献者

​		 github上的tags地址：[https://github.com/vuejs/vue-next/releases/tag](https://github.com/vuejs/vue-next/releases/tag/v3.0.0)[/v3.0.0](https://github.com/vuejs/vue-next/releases/tag/v3.0.0)

vue3带来了：

 	1.性能的提升

​	 2.源码的升级

​	 3.拥抱TypeScript- Vue3可以更好的支持TypeScript

​	 4.新的特性

### 2.2 vue-cli

使用 vue-cli 创建:

​		 查看@vue/cli版本，确保@vue/cli版本在4.5.0以上

​		 vue –version

 安装或者升级你的@vue/cli

​		 npm install -g @vue/cli

 创建

​		 vue create vue_test

 启动

​		 cd vue_test  npm run serve

### 2.3 vite

官网：[https://](https://vitejs.cn/)[vitejs.](https://vitejs.cn/) 

​		 一个轻量级的vue cli，运行更快，体验更好（ vite需要 Node.js 版本 >= 12.0 ）

创建vite项目

​		 npm init vite  npm init@latest

 		输入项目名称，选择框架以及语法规范

进入工程目录： 

​		cd \<project-name>

安装依赖： 

​		npm install

运行： 

​		npm run dev

指令

​		dev 			运行开发环境

​		build 		 发布项目

​		preview 	预览发布的项目 

### 2.4 创建应用

import App from './App.vue’

​	Vue 2.0 创建项目

​			 import Vue from 'vue'

​			 new Vue({ render: h => h(App) }).$mount('#app')

​	Vue 3.0 创建项目（函数式编程）

​			 import { createApp } from 'vue’

​			 createApp(App).mount('#app')

```js
// vue2 
// import Vue from 'vue';
// import App from './App';

// new Vue({
//     render: h => h(App)
// }).$mount('#app')
// // 全局添加指令，组件等
// // Vue.directive, Vue.component 
// // 这会影响所有的组件实例化对象以及应用程序

// vue3
import { createApp } from "vue";
import App from './App.vue';

var app = createApp(App)
    // 上树
    .mount('#app')
// 再添加组件，指令等，通过app
// app.directive, app.component
// 只影响当前应用程序，不影响其它应用程序
```



