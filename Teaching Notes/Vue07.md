## Vue 	第七天

## 一、单文件组件

### 1.1 使用单文件组件

在vue中，组件包含模板，样式和脚本，但是我们定义组件的时候

​	 我们将模板写在了html文件中

​	 我们将样式写在了css | less | scss文件中

​	 我们将脚本写在js | es文件中

vue为了简化维护组件的成本，建议我们将这三个部分放在同一个文件中。

​	 通过template元素定义模板，最外层根元素只能有且只有一个

​	 通过style元素定义样式

​	 通过script元素定义脚本，我们要使用ES Module规范。只定义组件对象即可（Vue.extend参数对象）

​	 将文件的拓展名定义成.vue，这就是单文件组件。规范：将组件文件名称的首字母大写。

### 1.2 编译

浏览器不识别.vue文件，因此我们要将vue文件编译成js文件。

​	 我们通过/\.vue$/匹配vue文件

​	 通过vue-loader加载机编译vue文件

```js
let { VueLoaderPlugin } = require('vue-loader');
module.exports = {
    // 模式
    mode: 'development',
    entry: './modules/main.js',
    output: {
        filename: '[name].js'
    },
    // 解决问题
    resolve: {
        alias: {
            vue$: 'vue/dist/vue.js'
        },
        // 拓展名
        extensions: ['.js', '.vue']
    },
    // 模块
    module: {
        rules: [
            // js
            {
                test: /\.js$/,
                loader: 'babel-loader',
                options: {
                    presets: ['@babel/env']
                },
                exclude: /node_modules/,
            },
            // css
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            },
            // less
            {
                test: /\.less$/,
                use: ['style-loader', 'css-loader', 'less-loader']
            },
            // sass
            {
                test: /\.scss$/,
                use: ['style-loader', 'css-loader', 'sass-loader']
            },
            // vue单文件组件
            {
                test: /\.vue$/,
                loader: 'vue-loader'
            }
        ]
    },
    // 插件
    plugins: [
        new VueLoaderPlugin()
    ]
}
```



### 1.3 ShadowDOM

在组件中，我们定义的样式会污染其它的组件，我们可以通过shadowDOM技术来解决。

为style标签设置scoped属性，

​	 此时当前组件内部的元素会添加属性选择器，

​	 添加的样式也会设置属性选择器

shadowDOM样式：只对当前组件生效，对其它的组件无效。

注意：子组件只在容器元素上设置属性选择器，内部的元素没有被添加、

### 1.4 CSS 预编译

vue单文件组件内置了css预编译语言的解析器，我们可以直接使用这些语言。

​	 通过lang属性来设置

​			 lang=”less” 使用less

​			 lang=”scss” 使用scss

​	 注意：在4.0中配置中，要定义less|sass加载机。

```vue
<!-- 模板 -->
<template>
    <div class="home">
        <h1>home page -- {{msg}}</h1>
        <hr>
        <demo></demo>
    </div>
</template>
<!-- 脚本 -->
<script>
import Demo from './Demo';
export default { 
    // 注册组件
    components: { Demo },
    data() {
        return {
            msg: 'hello home'
        }
    }
}
</script>
<!-- 样式 -->
<style lang="scss" scoped>
$color: orange;
h1 {
    color: $color;
}
</style>
<!-- scss -->
<!-- less
<style lang="less" scoped>
@color: green;
h1 {
    color: @color;
}
</style> -->
<!-- css
<style scoped>
/* 
    shadow样式： 
        只针对当前组件内的元素生效，其它组件内的元素无效 
        原理：给选择器以及属性添加属性限制
*/
h1 {
    color: red;
}
</style> -->
```



### 1.5 函数组件

我们在子组件中，为了接收父组件的数据，要使用props属性接收，

vue为了简化这一过程，提供了函数组件：

​	 在模板中，设置functional属性即使一个函数组件

​	 此时我们就可以直接通过“props.属性”语法获取数据。

```vue
<!-- <template>
<div class="demo">
    <h1>demo part -- {{num}} -- {{parentMsg}}</h1>
</div>
</template>
<script>
export default {
    // 接收数据
    props: ['num', 'parentMsg']
}
</script> -->

<!--
    函数组件
        让组件使用属性数据更直接，更方便
        它只是一个模板片段，不是一个独立的组件，因此样式受影响
-->
<template functional>
<div class="demo">
    {{props}}
    <h1>demo part -- {{props.num}} -- {{props.parentMsg}}</h1>
</div> 
</template>
```



### 1.6 异步组件

我们将所有的资源都打包在一起会导致文件很大，浏览器加载很慢，影响用户体验。

​	 vue为了减小文件体积，可以使用异步组件的技术。我们需要什么组件，加载什么组件，

首次不需要加载的组件就不需要打包在一起了。有两种异步组件的形式

​	 第一种：在函数的返回值中，返回Promise对象 （异步创建）

​			 在Promise方法中，执行异步操作，操作结束之后返回组件

​	 第二种：在函数的返回值中，返回通过import方法异步引入组件（异步加载）

​			 为了使用import方法。我们要使用:babel-plugin-syntax-dynamic-import，babel的插件在plugins中配置

注意：4.0改动：默认支持异步引入（import方法）4.0默认向dist目录下发布，因此要设置publicPath：表示引入静态资源相对位置。

```js
import Vue from 'vue';
// import Home from './Home';

// home组件单独打包
// 方式一：异步操作中加载
// let Home = () => new Promise(resolve => {
//     // 点击页面的时候，再加载
//     document.addEventListener('click', () => {
//         resolve(import('./Home'))
//     })
// })
// 方式二，拆分打包
let Home = () => import('./Home');

new Vue({
    el: '#app',
    // 注册组件
    components: { Home },
    data: {
        msg: 'hello app'
    }
})
```



### 1.7 拆分应用程序组件

我们目前定义的vue实例化对象既包含模板，样式，脚本，也包含注册store, router等功能。因此vue实例化对象做了很多的事情。为了让vue实例化对象职责更加的单一，我们要将实例化对象中的模板，样式，脚本单独拆分出来，作为应用程序组件。这样实例化对象中，就只剩下注册store，router等功能了

​	 1 我们将应用程序组件定义成App.vue，在内部，通过template定义模板，通过style定义样式，通过script定义脚本。

​	 2 为了在实例化对象中渲染应用程序组件，vue提供了一个render方法，参数是一个渲染方法，可以用来渲染应用程序。

 	3 为了让应用程序上树（渲染到页面中），vue提供了$mount方法，用来上树。参数表示css选择器。会将该选择器对应的元素作为容器元素。

 	以后只需要在vue实例化对象中，注册路由，注册store等，实现一些功能即可。

注意：拆分的应用程序组件App.vue要注意：模板的根元素要设置id属性，与模板的id同值、

```js
import Vue from 'vue';
import App from './App';

new Vue({
    // 渲染
    // render(h) {
    //     return h(App)
    // }
    // 简写成箭头函数
    render: h => h(App)
// 上树
}).$mount('#app')
```



### 1.8 混合

混合就是对组件的模板，样式，数据，方法等相关功能的复用。

vue支持两种混合：全局混合，局部混合

**全局混合**

​		全局混合会对所有的组件生效。通过Vue.mixin方法定义，参数就是继承的数据和方法等

**局部混合**

​		局部混合只能对当前组件生效。

​		在组件中通过mixins属性，实现对组件，数据，方法的继承

​				是一个数组，每一个成员表示一个继承的对象，可以组件，可以是对象等。

注意：

​	如果多个数据之间出现同名的属性数据

​			如果是模型中的数据和方法，后面的覆盖前面的。

​		   如果是生命周期方法，会暴露多个。并按照先后顺序依次执行。

​	我们继承之后，还可以重写被继承的数据，使用的时候，会优先使用重写的数据。

​	与组件不相关的数据和方法不会被组件继承。

```js
import Vue from 'vue';
// 应用程序组件
import App from './App'

// 全局混合
Vue.mixin({
    // 数据
    data() {
        return {
            msg: '全局混合'
        }
    },
    color: 'red',
    // 计算属性数据
    computed: {
        dealMsg() {
            return this.msg.toUpperCase();
        }
    },
    created() {
        console.log('全局混合created');
    }
})

new Vue({
    // 渲染
    render: h => h(App),
    created() {
        console.log('实例化对象created');
    }
// 上树
}).$mount('#app')

/***
 *  混合
 *      全局混合：被所有组件共享
 *      局部混合：只有当前组件使用
 *  组件相关数据和方法：组件可以获取
 *      自己定义会覆盖混合中的
 *  组件不想管的数据和方法，组件不能获取
 *  生命周期方法不会覆盖
 * 
 *  混合还可以复用模板，样式和脚本
 *  局部混合
 *      生命周期方法：全局 再执行 局部的，再执行 自身的
 *      多次使用局部混合，后面的覆盖前面的，自身的覆盖混合的数据和方法
 * 
 * 
 * **/ 
```



### 1.9 插件

vue允许我们自定义插件，实现对vue拓展的功能的复用。

我们封装好插件，就可以在不同的项目中，复用这些功能了。

**定义插件**

​	 插件就是一个函数或者包含install方法的对象

​			 第一个参数表示Vue类

​			 从第二个参数开始表示使用插件的时候，传递给插件的数据。

**使用插件**

 	我们通过Vue.use方法来安装插件。

 		第一个参数表示插件

 		从第二个参数开始表示传递给插件的数据

```js
// export default function() {
//     console.log(arguments, 111);
// }
import axios from 'axios';

// 包含install方法的对象
export default {
    install(Vue, num, ...args) {
        // console.log(222, arguments);
        // 所有的数据都可以拓展
        Vue.mixin({
            created() {
                console.log('插件定义的生命周期方法');
            }
        })
        // 组件
        Vue.component('ickt', Vue.extend({
            template: '<h1>ickt 组件</h1>'
        }))
        // 全局指令
        Vue.directive('icktDemo', {
            bind(dom) {
                dom.style.backgroundColor = 'green';
                dom.style.fontSize = num + 'px'
            }
        })
        // 使用axios
        Vue.prototype.$http = axios;
        // 版本号
        Vue.ickt_version = '1.0'
    }
}
```



## 二、UI 库

vue是一个框架，却是一个半成品，提供了大量的工具方法，我们还要自己去实现，因此开发成本还是很高。

我们使用组件开发的意义：让我们可以复用已经写好的组件。

​	 UI库就是一个Vue的插件，提供了大量的UI组件，可以直接使用，提高开发效率。

我们首先讲解一个富文本编辑器UI库，并且根据pc端和移动端介绍两个UI库，

​	  vue-quill-editor 富文本编辑器

​	 mint-ui  给移动端使用的

​	 element-ui 给pc端使用的

### 2.1 富文本编辑器

就是一个超级textarea，包含大量的功能，类似word工具。

​	 我们介绍：vue-quill-editor，该插件依赖于quill插件。

​		 npm i vue-quill-editor quill

​	 注意：我们要引入quill模块的样式：

​		 quill/dist/qull.core.css

​		 quill/dist/qull.snow.css

​		 quill/dist/qull.bubble.css

该插件在全局注册了quill-editor组件，我们可以直接使用

​	 并且可以通过v-model绑定数据。渲染数据的时候，要使用v-html指令渲染标签。

```vue
<template>
<div id="app">
    <h1>app part</h1>
    <!-- 富文本编辑器 -->
    <quill-editor :options="{ placeholder: '请输入内容' }" v-model="msg"></quill-editor>
    <!-- <div>{{msg}}</div> -->
    <!-- 渲染内容 -->
    <div v-html="msg"></div>
</div>
</template>
<script>
export default {
    data() {
        return {
            msg: 'hello'
        }
    }
}
</script>
<style>

</style>
```



### 2.2 Vant

官网：[https://youzan.github.io/vant/#/zh-CN/](https://youzan.github.io/vant/)

 	安装：npm install vant

​			 vue2版本 npm install vant@latest-v2

​			 Vant也是vue家族的插件，因此用use方法安装：Vue.use(Vant)

​	组件的特点：都是以vant为前缀的。

​	我们要导入样式：

​			 import 'vant/lib/index.css’;

**基础组件**

​	van-button  按钮

​	van-cell   单元格

​	van-popup 弹出框

​	van-icon  字体图标，name属性定义图标名称

​	van-row  栅格布局

​	 van-col  单元格所占列数（共24列）

**表单组件**

​	van-form 表单组件

​	van-field 输入框，rules 属性定义校验规则

​	van-calendar 日历组件

​	van-search 搜索框

​	van-slider 滑块

​	van-rate  评分组件 

​		 表单组件通过v-model绑定数据

功能组件

​	van-swipe-cell 滑动单元格 

​			#left左侧模板， 

​			#right右侧模板

​	van-nav-bar 导航条

​	van-tabs 分页栏

​	 van-tab 分页栏页面

​	van-tabbar 标签栏

​	 van-tabbar-item 标签项

​	van-count-down  倒计时

​	van-index-bar 滚动视图

​	 van-index-anchor 滚动标签

```vue
<template>
<div id="app">
    <h1>app part</h1>
    <van-button type="success">按钮</van-button>
    <van-button type="danger">按钮</van-button>
    <van-button type="warning">按钮</van-button>
    <van-button type="primary">按钮</van-button>
    <!-- 图标 -->
    <!-- 字体图标 -->
    <van-icon name="star" style="font-size: 100px"></van-icon>
    <!-- 显示单元格 -->
    <van-cell title="名称" value="爱创乐育" @click="show = !show"></van-cell>
    <!-- 弹出框 -->
    <!-- <van-popup v-model="show">hello</van-popup> -->
    <!-- 日历 -->
    <van-calendar v-model="show"></van-calendar>
    <!-- 滑动单元格 -->
    <van-swipe-cell>
        <van-cell title="商品名称" value="电脑"></van-cell>
        <template #right>
            <van-button type="danger">删除</van-button>
        </template>
    </van-swipe-cell>
    <!-- 轮播图 -->
    <van-swipe :autoplay="3000" duration="1000" :vertical="true">
        <van-swipe-item>
            <div class="item1">1</div>    
        </van-swipe-item>
        <van-swipe-item>
            <div class="item2">2</div>    
        </van-swipe-item>
        <van-swipe-item>
            <div class="item3">3</div>    
        </van-swipe-item>
        <van-swipe-item>
            <div class="item4">4</div>    
        </van-swipe-item>
    </van-swipe>
</div>
</template>
<script>
export default {
    data() {
        return {
            show: false
        }
    }
}
</script>
<style>
body {
    background: #efefef;
}
.item1 {
    height: 200px;
    background: green;
    color: #fff;
    font-size: 50px;
}
.item2 {
    height: 200px;
    background: purple;
    color: #fff;
    font-size: 50px;
}
.item3 {
    height: 200px;
    background: skyblue;
    color: #fff;
    font-size: 50px;
}
.item4 {
    height: 200px;
    background: orange;
    color: #fff;
    font-size: 50px;
}
</style>
```



### 2.3 ElementUI

element-ui是基于vue实现的一套在pc端的UI框架，内置了大量的组件，我们可以直接使用。

​	官网：https://element.eleme.cn/#/zh-CN/component/button

使用element-ui

​	 element-ui中的组件默认都是以el-为前缀的。

​	 默认组件没有样式，我们要引入：element-ui/lib/theme-chalk/index.css

​	 内置了大量的字体图标，我们可以直接使用：

​			 https://element.eleme.cn/#/zh-CN/component/icon

​			 字体图标：跟字体一样，通过font-size属性来设置其大小。

​			 我们使用字体图标，要定义加载机： url-loader

### 2.4 表单校验

就是在表单输入的时候，对表单的内容做校验。

 	定义表单: el-form

​	 每一行：el-form-item

​	 表单控件：el-input

设置样式：

​	 1 el-input设置placeholder

​	 2 el-form-item设置label

​	 3 el-form设置label-width

输入校验

​	 1 el-input组件，设置v-model指令，实现数据双向绑定，为了数据访问方便，通常放在同一个命名空间下

​	 2 el-form设置model属性，表示校验哪一组数据

​	 3 el-form-item设置prop属性，表示校验哪一个数据

​	 4 el-form设置rulus属性，定义校验规则

​		 校验规则是一个对象

​			 key表示校验的字段名称，

​			 value是一个数组，每一个成员代表一条规则，是一个对象

​					 required：是否是必填的

​					 message：提示信息

​					 validator：校验的方法

​					 trigger：什么时候触发校验，默认是一边输入一边校验

提交校验

​	 1 为按钮绑定事件

​	 2 在事件回调函数中，获取表单组件（通过ref属性获取）

​	 3 执行表单组件的validate方法，校验内容。

```vue
<template>
<div id="app">
    <h1>app part</h1>
    <!-- 登录 -->
    <!-- 设置内容： 1 placeholder， 2 label， 3 label-width -->
    <!-- 
        输入校验： 
            1 v-model 实现数据双向绑定
            2 el-form设置model
            3 el-form-item设置prop
            4 el-form设置rules定义校验规则
                message     提示文案
                required    是否必填
                trigger     何时校验
                validator   校验方法
    -->
    <!-- 
        提交校验
            1 绑定事件
            2 el-form设置ref
            3 通过validate方法校验
     -->
    <el-form label-width="200px" :model="data" :rules="rules" ref="login">
        <!-- 选项 -->
        <el-form-item label="用户名" prop="username">
            <el-input placeholder="请输入用户名" v-model="data.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
            <el-input placeholder="请输入密码" v-model="data.password" type="password"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="success" @click="submitData">登录</el-button>
        </el-form-item>
    </el-form>
</div>
</template>
<script>
export default {
    data() {
        // 添加在this上
        this.rules = {
            username: [
                { message: '请输入用户名', required: true },
                // 失去焦点时候校验
                { trigger: 'blur', validator(field, value, cb) {
                    // console.log(args);
                    // 校验数据
                    if (!/^\w{4,8}$/.test(value)) {
                        // 提示错误
                        return cb(new Error('用户名是4到8位的字母数字下划线'))
                    }
                    // 没有问题要执行cb
                    cb();
                } }
            ],
            password: [ { message: '请输入密码', required: true } ]
        }
        // console.log(this);
        return {
            data: {},
            // rules: {}
        }
    },
    // 方法
    methods: {
        submitData() {
            // console.log(this.$refs.login);
            this.$refs.login.validate(valid => {
                // console.log(valid);
                // 没有问题，可以提交数据
                if (valid) {
                    console.log(this.data);
                }
            })
        }
    }
}
</script>
<style>

</style>
```

