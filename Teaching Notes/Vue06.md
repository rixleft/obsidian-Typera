# Vue	第六天

##  一、Vue Router

### 1.1 URL 组成部分

路由就是根据一个地址找到对应的页面。

url组成部分：一个完整的URL由几部分组成？

https://www.icketang.com:443/static/img/banner_news.jpg?color=red&num=100#title

​	 协议 https://

​	 域名 www.icketang.com

​	 端口号 :443

​	 路径 /static/img/

​	 文件名 banner_news.jpg

​	 搜索词 ?color=red&num=100

​	 哈希 #title 

 一个url由七部分组成，前三个部分的改变会导致跨域文件。前六个部分的改变会导致浏览器端向服务器端发送新的请求。只有hash的改变不会向服务器端发送新

的请求，因此前端路由就是基于hash实现的。

### 1.2 前端路由的实现

由于hash的改变不会向服务器端发送新的请求，因此我们可以监听hash的变化（通过hashchange事件），根据不同的hash渲染不同的页面（通过location.hash

获取当前的hash值）。

​	 这种不向服务器端发送请求，而实现切换页面的功能，就是单页面应用程序（SPA：single page application）。

​			 单页面应用程序就是基于前端的hash路由实现的。特点就是：快。

```js
import Vue from 'vue';

// 定义组件
let Home = Vue.extend({ template: '<h1>home page</h1>' })
let List = Vue.extend({ template: '<h1>list page</h1>' })
let Detail = Vue.extend({ template: '<h1>detail page</h1>' })
// 注册页面
Vue.component('home', Home)
Vue.component('list', List)
Vue.component('detail', Detail)

let app = new Vue({
    // 视图
    el: '#app',
    // 模型
    data: {
        page: ''
    }
})

// 前端路由：不用重新打开新的页面，实现页面的切换（局部视图），通过hash实现
// 路由方法
function router() {
    // console.log(location.hash);
    // 获取页面的名字
    app.page = location.hash.slice(2);
}

// 监听hash的变化
window.addEventListener('hashchange', router)

// 页面渲染完毕，执行一次方法
router();
```



### 1.3 Vue 路由

vue为了让我们更方便的使用路由，提供了路由模块：vue-router

使用路由分成六步

​	 第一步 安装路由：Vue.use方法安装

​	 第二步 创建组件对象：定义Vue.extend的参数对象（简化了对组件的定义）

​	 第三步 定义路由规则：是一个数组，每一个成员代表一条规则

​			 name：代表名称，

​			 component：代表渲染的组件，

​			 path：匹配规则（与express类似）

​					 静态路由：一个规则对应一个页面地址，

​							 如：/home/search，

 									匹配：/home/search，

​							 		不匹配：/home, /home/search/1, /list/search  

​					 动态路由：一个规则对应多个页面地址

​							 如：/list/:page

 							 		匹配：/list/1, /list/100, /list/demo， 

​							 		不匹配：/list, /list/1/2, /home/1

​	 第四步 实例化路由，new Router({ routes })。通过routes属性传递路由规则

​	 第五步 在vue实例化对象中，注册路由，通过router属性注册。

​	 第六步 在模板中，通过router-view组件，定义路由的渲染位置。

```js
import Vue from 'vue';
import VueRouter from 'vue-router';
// 1 安装插件
Vue.use(VueRouter);

// 2 定义组件
let Home = { template: '<h1>home page</h1>' };
let List = { template: '<h1>list page</h1>' };
let Detail = { template: '<h1>detail page</h1>' };

// 3 定义规则
let routes = [
    // 每个成员代表一条规则
    { path: '/home', component: Home, name: 'home' },
    { path: '/list/:page', component: List, name: 'list' },
    { path: '/detail/:id', component: Detail, name: 'detail' }
]

// 4 实例化
let router = new VueRouter({ routes })

let app = new Vue({
    // 5 注册路由
    router,
    el: '#app', 
    data: {}
})
```



### 1.4 路由数据

当我们在vue中注册了路由之后，每一个组件都会具有两个属性：$route, $router

​	 $router 表示路由实例，包含一些切换路由的方法

​			 push 进入一个新页面

​			 replace  替换当前的页面

​			 back 返回上一个页面

​			 forward  进入下一个页面

​			 go  返回第一个页面

​	 $route 存储了路由相关数据

​			 路径，名称，query，动态路由数据（params）等等

​					 注意：在hash策略下，hash属性代表的是第二个#后面的内容，

 由于这些数据都设置了特性，因此既可以在模板中使用，也可以在js中使用。

### 1.5 props

我们在定义路由规则的时候，可以传递props属性，属性值有两种情况

​	 第一种：属性值是true

​			 会将动态路由数据传递给组件

​	 第二种：属性值是函数

​			 参数是$route数据对象

​			 返回值表示给组件传递的数据

我们在组件中，通过props属性去接收这些数据（类似父组件向子组件通信）

### 1.6 默认路由

我们让path匹配*。既可以定义默认路由

注意：由于*匹配的很广，因此通常定义在最后面。

默认路由：当前地址没有匹配的规则，就会渲染默认路由定义的组件。

### 1.7 路由重定向

我们通过path定义匹配的规则

我们通过redirect属性定义重定向的路径

当有与path匹配的路径就会重定向到新的路径。

bug：当重定向的时候，携带query，hash等数据，会导致路由对象解析错误。

注意：工作中，做路由重定向的时候，不要携带query等其它数据。

```js
import Vue from 'vue';
import VueRouter from 'vue-router';
// 1 安装插件
Vue.use(VueRouter);

// 2 定义组件
let Home = { template: '<h1>home page</h1>' };
let List = { template: '<h1>list page</h1>' };
let Detail = { template: '<h1>detail page</h1>', mounted() { console.log(this) } };

// 3 定义规则
let routes = [
    // 每个成员代表一条规则
    { path: '/home', component: Home, name: 'home' },
    { path: '/list/:page', component: List, name: 'list' },
    { path: '/detail/:id', component: Detail, name: 'detail' },
    // 默认路由 (输入没有匹配的地址，可以看到的页面)
    // 工作中，建议将默认路由放在最后面
    // { path: '*', component: Home }
    // 还可以在*的前面添加范围
    // { path: '/home/*', component: Home }

    // 重定向： 输入一个地址，进入另外一个地址对应的页面
    // { path: '/ickt', redirect: '/detail/ickt' }
    // 问题 当前版本下，重定向添加了query和hash，被错误的解析到path上了
    { path: '/ickt', redirect: '/detail/ickt?color=red#demo' }
]

// 4 实例化
let router = new VueRouter({ routes })

// 动态添加路由
let Demo = { template: '<h1>demo page</h1>' }
router.addRoutes([{ path: '/demo', component: Demo, name: 'demo' }])

let app = new Vue({
    // 5 注册路由
    router,
    el: '#app', 
    data: {}
})
```



### 1.8 子路由

子路由允许我们在页面的局部切换视图。

使用子路由分成两步

​		 第一步 在父路由模板中，通过router-view组件定义子路由渲染位置。

​		 第二步 在父路由规则中，通过children属性定义子路由规则。

​				 是一个数组，每一个成员代表一条规则：path, name, component, redirect, children ...

定义规则的要注意：

​		 如果是绝对路径：子路由的路径就是子路由的绝对路径（子）

​		 如果是相对路径：子路由的路径就是父路由路径+子路由的相对路径（父 + 子）

### 1.9 路由策略

vue中默认使用的是hash策略（根据hash的变化，切换页面，实现SPA）

我们想使用path策略，可以通过设置路由实例化对象的mode属性实现

​		 mode: ‘history‘ 此时就是path策略。需要服务器端的配合（重定向）。

​		 由于切换路径会向服务器端发送请求，因此这是一个多页面应用程序

​		 使用多页面应用，要配置服务器。

### 1.10 路由导航

为了方便我们切换路由，vue路由为我们提供了路由导航组件：router-link组件

​	 tag  定义渲染的标签（默认是a标签）

​			 渲染成a标签，通过a标签的href属性实现切换

​			 渲染成其它标签，通过js实现切换。

​	 to  定义目标地址，必须要定义的，

​			 即使是hash路由，也不要以#开始。

router-link组件与a标签相比，router-link组件会适配不同的策略

### 1.11 路由过渡

我们切换页面的时候，可以添加过度动画。

​	 在router-view组件的外面，定义transition组件，添加过渡动画。

​			 mode属性定义切换方式

​			 appear属性定义是否在加载的时候引入动画。

### 1.12 监听滚动

vue的路由允许我们在切换页面的时候，改变滚动条的位置。

我们在路由实例化对象中，通过scrollBehavior方法监听页面切换

​	 第一个参数表示当前路由对象

​	 第二个参数表示上一个路由对象

​	 第三个参数表示当前滚动条位置

​			 x表示横向滚动条位置

​			 y表示纵向滚动条位置

​	 返回值表示新的滚动条位置。

### 1.13 路由守卫

路由守卫就是监听路由的切换（改变）。

在vue中有三种方式可以监听路由的改变：

​	 第一种 全局路由守卫

​			 可以监听所有的页面的切换

​			 通过对路由实例化对象定义beforeEach，afterEch等方法，来监听

​					 第一个参数表示当前路由对象

​					 第二个参数表示上一个路由对象

​					 如果是beforeEach有第三个参数，表示next方法，必须要执行，否则看不到新的页面。

​	第二种 局部路由守卫

​			 可以监听当前页面的路由的切换。

​			 在组件实例化对象中，定义beforeRouteEnter，beforeRouteLeave，beforeRouteUpdate等方法监听。

​					 第一个参数表示当前路由对象，

​					 第二个参数表示上一个路由对象，

​					 第三个参数表示next方法，必须执行，

​	 第三种 在watch监听器中，监听$route数据的改变。

​			 第一个参数表示当前的路由对象，

​			 第二个参数表示上一个路由对象

注意： 

​	 为了页面载入的时候可以被监听，可以配合局部路由守卫一起使用。

 	为了让页面消失的时候也可以监听路由，可以配置keep-alive组件使用。

```js
import Vue from 'vue';
import VueRouter from 'vue-router';
// 1 安装插件
Vue.use(VueRouter);

// 2 定义组件
let Home = { template: '<h1>home page</h1>' };
let List = { 
    template: '<h1>list page -- {{$route.params.page}}</h1>',
    // （2）局部路由守卫
    beforeRouteEnter(to, from, next) {
        console.log(arguments, 111);
        next();
    },
    // watch监听路由的数据变化，可以弥补局部路由守卫不能监听路由数据变化的问题
    // （3）监听路由数据的变化
    watch: {
        $route(to, from) {
            console.log(to, 222, from);
        }
    }
};
let Detail = { template: '<h1>detail page</h1>' };

// 3 定义规则
let routes = [
    // 每个成员代表一条规则
    { path: '/home', component: Home, name: 'home' },
    { path: '/list/:page', component: List, name: 'list' },
    { path: '/detail/:id', component: Detail, name: 'detail' }
]

// 4 实例化
let router = new VueRouter({ routes })

// 添加demo页面
router.addRoutes([{ path: '/demo', component: { template: '<h1>demo part</h1>' }, name: 'demo' }])

//（1）全局路由守卫
// 页面切换后
// router.afterEach(function() {
//     console.log(arguments);
// })
// 页面切换前
// router.beforeEach(function(to, from, next) {
//     console.log(arguments);
//     // 路由拦截
//     if (to.name === 'detail') {
//         // return;
//         // 重定向到其他页面
//         return next('/demo')
//     }
//     // 必须执行放行函数
//     next();
// })

let app = new Vue({
    // 5 注册路由
    router,
    el: '#app', 
    data: {}
})
```



## 二、axios

### 2.1 使用 axios

vue为了开发方便，为我们提供了vue全家桶：vue, vuex, vue-router, vue-resource.

在ES5开发中，我们使用vue-resource发送异步请求，但是在ES6中，作者不再维护vue-resource，而是建议我们使用axios框架发送异步请求。

注意：axios不是vue家族的插件，因此不能用vue.use方法来安装。

axios的使用方式与jquery类似，提供了一些简便方法：

​	 get(url, config) 发送get请求

​			 url表示请求地址，

​			 config表示配置项（我们可以定义parmas，headers等）

​	 post(url, data, config)  发送post请求

​			 url表示请求地址，

​			 data：表示携带的数据，

​			 config：表示配置项（我们可以定义parmas，headers等）

注意：不论是get请求还是post请求，都可以携带query数据，query数据可以在两个位置添加

​	 1 在url上添加query数据。

​	 2 在config配置中的params属性中传递。

axios实现了promise规范，因此，通过then方法监听结果

​	 第一个参数表示成功时候的回调函数:参数表示请求对象，其中data属性表示返回的数据

​		 当多次使用then方法的时候，前一个then方法的返回值，将作为后一个then方法的参数。

​	 第二个参数表示失败时候的回调函数，也可以通过catch方法监听失败

axios提交的数据，默认使用的是json格式。

​	 我们可以通过修改headers中的Content-Type字段，来模拟表单提交。

​	 模拟表单： application/x-www-form-urlencoded

### 2.2 安装 axios

axios不是vue家族的插件，因此不能通过Vue.use方法来安装

所谓的安装就是让每一个组件可以获取，使用更方便。

​	 所有的组件都继承了Vue类，如果Vue的原型具有axios对象，那么每一个组件（包括vue实例）都可以获取axios了。

​	 所以对于非vue家族的插件我们可以通过拓展其原型的方式来安装。

​	 工作中，为了语义化，我们常常将其命名为$http.

```js
import Vue from 'vue';
import Home from './Home';
import axios from 'axios'

// 安装axios
// vue中有两类插件：vue家族插件（Vue.use），非vue家族插件 (拓展原型)
// Vue.prototype.$ickt = axios;
// 为了语义化
Vue.prototype.$http = axios;


new Vue({
    el: '#app',
    // 局部注册组件
    components: { Home },
    data: {},
    created() {
        console.log('app', this.$http);
    }
})
```



### 2.3 请求拦截器与响应拦截器

请求拦截器

​		 axios.interceptors.request.use(callback)

​		 回调函数中，对请求做统一处理

响应拦截器

​		 axios.interceptors.response.use (callback)

​		 回调函数中，对响应做统一处理

注意：通常利用axios.create方法复制一个Axios,设置拦截器,这样就不会影响全局的axios了

```js
import Vue from 'vue';
import axios from 'axios'

let $http = axios.create();
// let $http = axios;

// 请求拦截器
$http.interceptors.request.use(
    config => {
        // console.log('拦截请求', config);
        // 修改请求头
        config.headers.icktToken = 200;
        // config.url += '?token=100'
        return config;
    }
)
// 响应拦截器
$http.interceptors.response.use(
    config => {
        console.log('拦截响应', config);
        // return config;
        // 拓展其它数据
        config.data.status = config.status;
        return config.data;
    }
)

// 安装
Vue.prototype.$http = $http;

new Vue({
    el: '#app',
    data: {
        msg: ''
    },
    created() {
        this.$http.get('/data/get')
            .then(data => {
                console.log(data);
            })
        this.$http.post('/data/post')
            .then(data => {
                console.log(data);
            })
        
        // 通过原来的axios发送请求
        axios.get('/data/demo').then(data => console.log(111, data))
    }
})
```



### 2.4 跨域请求代理

让我们在本地开发中可以使用线上的数据。webpack-dev-server支持跨域请求代理技术：

我们通过devServer配置项，定义webpack-dev-server的配置

​	 port定义端口，

​	 host定义域名，

​	 open是否自动打开浏览器

​	 proxy定义跨域请求代理

​			 key   表示代理的请求

​			 value  表示代理的配置对象

​					 target  表示目标地址

​					 pathRewrite 表示是否重写路径

​					 secure  是否对https协议校验。

```js
module.exports = {
    // 配置服务器
    devServer: {
        proxy: {
            '/data/demo': {
                target: 'https://c.y.qq.com/splcloud/fcgi-bin/gethotkey.fcg',
                pathRewrite: {
                    '^/data/demo': ''
                },
                // 不校验https
                secure: false
            },
            '/data/get': {
                target: 'http://localhost:3000'
            },
            '/data/post': {
                target: 'http://localhost:3000'
            }
        }
    }
}
```
