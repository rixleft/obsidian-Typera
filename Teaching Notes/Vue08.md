# Vue 	第八天

## 一、Vue cli

### 1.1 vue cli

​	 我们使用vue开发项目，我们要书写webpack配置，创建项目，创建文件等需要时间，为了做性能优化，需要大量的配置等等，在开发项目前，要准备大量的工作内容。

​	 vue为了简化这一开发方式，提供了vue-cli脚手架。

安装

​	 通过npm安装vue-cli： npm install -g @vue/cli

​	 此时提供了vue指令，输入vue -v可以查看

创建项目

​	 执行‘vue create 项目名称’指令就可以创建项目

​	 创建过程中，可以输入一些选项。

### 1.2 目录部署

node_modules 依赖的模块

public 静态资源

​	 index.html 入口文件

​	 manifest.json 离线缓存配置

​	 favicon.ico 网页logo

​	 robots.txt 爬虫配置

​	 img 图片资源目录

src  开发目录

​	 assets 静态资源

​	 components 页面间共享的组件

​	 views  页面组件

​	 App.vue 应用程序组件

​	 router.js 路由文件

​	 store.js  vuex文件

​	 main.js 入口文件

​	 registerServiceWorker.js web workers文件

test 单元测试目录

 .browserslistrc 浏览器配置

.eslintrc es语法校验

 .gitnore 提交配置

babel.config.js babel配置

 jest.config.js 单元测试配置

package.json npm包配置

 postcss.config.js css配置

readme.rd 项目介绍文件

 yarn.lock yarn锁文件

### 1.3 指令

ts开发

​	 我们创建项目的时候，可以选择ts语法或者es6语法，

​	 选择ES6会使用.js文件

​	 选择ts会使用.ts文件

指令

​	 serve 启动项目，默认端口号是8080

​	 build  发布项目，默认向dist目录下发布

​	 test:unit 启动单元测试

我们既可以使用yarn指令运行，也可以使用npm run指令运行。

### 1.4 配置

插件webpack配置，用inspect指令：vue inspect > 文件路径

我们可在vue.config.js中。自定义配置

​	 在配置文件中，有两个环境，

​			 一个是开发环境，执行yarn serve时候的环境

​			 一个是发布环境，执行yarn build时候的环境

​	 我们通过process.env.NODE_ENV来识别环境：

​			 development表示开发环境 

​			 production表示发布环境

在vue.config.js文件中。我们要分别为开发环境和发布环境定义配置

 我们可以定义两类配置

​	 一类是webpack语法配置

 			在configureWebpack中配置

​	 一类是vue cli自身的语法配置

​			 outputDir 静态资源发布位置

​			 indexPath 模板发布位置

​			 publicPath  模板中引入的静态资源相对位置 

```js
// 判断环境
if (process.env.NODE_ENV === 'production') {
    // 发布的环境
    module.exports = {
        // 外部发布
        outputDir: '../ickt/static/',
        // 模板发布位置
        indexPath: '../views/index.html',
        // 静态文件相对位置
        publicPath: '../static/'
    }
} else {
    // 开发环境
    module.exports = {
        // 定义webpack配置
        // configureWebpack: {
        //     entry: './src/demo.js'
        // }
    }
}
```



### 1.5 PWA

是一个渐进式的web应用，介于web应用与源生应用之间的一类应用、

​	 可以像web应用一样开发。

​	 可以具有源生应用的一些功能，

其中以下文件就是为了实现这些功能的。

 	manifest.json 离线缓存配置

​	 registerServiceWorker.js web workers文件



## 二、单元测试

测试就是描述一段话，判断是否正确（断言）。基于文件或者模块（组件）的测试，我们称之为单元测试。

### 2.1 单元测试

在vue cli中，我们使用的是jest框架。测试结果有两种

​	 一种是测试成功，所有的单元测试都成功。

​	 一种是测试失败，有一个测试是失败的。

 启动测试：yarn test:unit  npm run test:unit

测试文件：在单元测试中，有三类文件可以被测试

​	 1 放在__test__目录中的文件

​	 2 文件的名添加.test.后缀的文件

​	 3 文件的名添加.spec.后缀的文件

命名规范：通常与被测试的文件同名。

### 2.2 测试方法

describe 测试整体描述

​	 第一个参数表示描述

​	 第二个参数是函数，表示测试内容

it  一次测试的描述

​	 第一个参数表示描述

​	 第二个参数是函数，表示本次测试的内容

expect 断言方法

​	 参数就是描述

​	 我们要对返回值做判断（断言）

### 2.3 断言方法

常见的断言方法有：

​	 toBe  表示===

​	 toEqual   字面量形式是否相等

​	 toMatch   是否正则匹配

​	 toContain 是否包含

​	 toBeTruthy 是否为真

​	 toBefalsy  是否为假

​	 ......

### 2.4 周期方法

beforeEach 每一个it语句执行前

afterEach 每一个it语句执行后

beforeAll 所有的it语句执行前

afterAll 所有的it语句执行后

只对当前文件的it语句生效，其它文件无效。

```js
import { arr, obj, add } from '@/demo';

// 整体描述
describe('测试demo.js文件', () => {

    // // 周期方法（只针对当前文件生效）
    // // 每一个it语句执行之前
    // beforeEach(() => console.log(111, 'beforeEach'))
    // // 每一个it语句执行之后
    // afterEach(() => console.log(222, 'afterEach'))
    // // 所有的it语句执行之前
    // beforeAll(() => console.log(333, 'beforeAll'))
    // // 所有的it语句执行之后
    // afterAll(() => console.log(444, 'afterAll'))

    // 每一条测试
    it('测试arr', () => {
        expect(arr)
            .toContain(2)
            // .toContain('2')
    })
    it('测试obj对象', () => {
        expect(obj.color)
            // .toBe('green')
            .toBe('red')
    })
    it('测试add方法', () => {
        expect(add(2, 3))
            // .toBe(6)
            .toBe(5)
    })
})
```



### 2.5 测试 store

 由于store中有包含修改数据的逻辑（mutations以及action中），因此要对它们进行测试。

 此时store的这些组成部分要单独定义出来，这样才能测试。

### 2.6 测试组件

我们在vue文件中，定义的组件只是Vue.extend方法的参数对象。因此我们不能直接使用，要转成实例化对象再使用，有两种方式

​	 第一种：new Vue(obj)，返回的是vue实例化对象

​	 第二种: 通过组件类的方式，第一步 let Comp = Vue.extend(obj); 第二步 实例化 new Comp()

不论是哪一种方式，都可以得到组件，但是组件没有上树，无法获取$el容器元素。

为了获取\$el容器元素，我们要使用$mount方法。

**$nextTick**

​	会检测视图的更新，更新完毕，执行回调函数。

​	 该方法实现了Promise规范。

​	 所以我们可以通过then方法监听结果。

**shallowMount**

​	vue cli为了方便我们测试组件，提供了一个 shallowMount 方法。

​	 该方法可以将组件实例化，并且执行$mount方法上树。

​	 我们通过该方法，我们就可以得到一个组件实例化对象。

​			 第一个参数是组件对象 

​			第二个参数是配置对象（propsData： 传递给组件的属性数据）

​	 提供了text方法，可以获取其视图中的内容。

注意：使用单元测试，去测试视图等很麻烦，效率低，因此工作中慎用。我们用单元测试，去测试一些业务逻辑收益还是很大的。

```js
import Message from '@/Message';
import { shallowMount } from '@vue/test-utils';
import Vue from 'vue';

describe('测试Message.vue组件', () => {
    let wrapper;

    // it语句执行之前，实例化
    beforeEach(() => {
        // 创建组件组件
        let MsgClass = Vue.extend(Message);
        // 实例化
        wrapper = new MsgClass();
        // 上树
        wrapper.$mount();
    })
    // it语句执行之后，将组件销毁
    afterEach(() => {
        wrapper.$destroy();
    })

    it('测试数据渲染', () => {
        // console.log(Message)
        // 将组件类变成组件实例化对象
        // let wrapper = new Vue(Message);
        // 当作组件类来处理
        // let MsgClass = Vue.extend(Message);
        // // 实例化
        // let wrapper = new MsgClass();
        // // 上树之后，才有$el
        // wrapper.$mount();
        // console.log(wrapper, wrapper.$el.innerHTML);
        expect(wrapper.$el.innerHTML)
        // .toContain('hello1')
            .toContain('hello')
    })
    it('测试数据绑定', () => {
        // 获取
        // console.log(wrapper.$el.innerHTML);
        // console.log(wrapper.$el.textContent);
        expect(wrapper.$el.textContent)
            .toMatch('hello')
        // 数据改变，视图更新
        wrapper.msg = 'ickt';
        // expect(wrapper.$el.textContent)
        //     .toMatch('ickt')
        // 组件数据改变，视图要更新（异步）
        wrapper.$nextTick()
            .then(
                () => {
                    expect(wrapper.$el.textContent)
                        .toMatch('ickt')
                }
            )
    })
    // 测试属性数据
    it('测试属性数据', () => {
        let instance = shallowMount(Message, {
            propsData: {
                title: 'demo'
            }
        })
        // 测试
        // console.log(instance.text());
        expect(instance.text())
            .toMatch('demo')
    })
})
```



## 三、实现 Vue Cli

我们基于webpack来实现一个vue cli的功能

实现vue cli的目录部署

实现一些性能优化的功能。

​	 静态资源压缩，打包，添加指纹等等。

**资源发布**

 将静态资源发布到外面的ickt/static目录中

 将模板资源发布到外面的ickt/views/index.html文件中

**发布模板**

​	 发布html文件用html-webpack-plugin插件

​			 template  定义模板文件位置

​			 filename 模板文件发布位置

​			 hash  是否添加指纹（添加在query上）

​			 inject 是否注入静态资源（默认是注入的）

 **压缩资源**

​	压缩js，压缩html，压缩css

**拆分文件**

将模块文件打包在一起：main.js

将样式文件打包在一起: style.css

​	 我们使用mini-css-extract-plugin插件

​			 vue组件中样式拆分： extractCSS: true

​			 css和scss|less样式拆分，使用该插件加载机

​			 我们通过插件的filename属性定义文件发布位置。

对资源添加指纹：css资源，js资源等

​		 压缩css使用optimize-css-assets-webpack-plugin插件

​		 压缩js： mode: ‘production’

**拆分库文件**

将库文件打包在一起：lib.js

​	 optimization: {

​		 splitChunks: { 拆分文件

​				 cacheGroup: { 公用缓存分组

​						 lib: {

​								 name： 库文件名称

​								 chunks  ‘initial’,

​								 test: 库文件特征

​						 }

​				 }

​		 }

​	 }

```js
let path = require('path');
let { VueLoaderPlugin } = require('vue-loader');
let HtmlWebpackPlugin = require('html-webpack-plugin');
// 拆分css
let MiniCssExtract = require('mini-css-extract-plugin')
// 压缩css
let OptimizeCssAssets = require('optimize-css-assets-webpack-plugin')

const root = process.cwd();

module.exports = {
    // 模式
    mode: 'development',
    // 发布
    // mode: 'production',
    // 入口
    entry: './src/main.js',
    // 发布
    output: {
        // filename: '[name].[hash:8].js',
        filename: '[name].js',
        // 发布位置
        path: path.join(root, '../server/static/'),
        // 静态资源相对位置
        publicPath: '/static/'
    },
    // 解决问题
    resolve: {
        alias: {
            vue$: 'vue/dist/vue.js',
            '@': path.join(root, './src/')
        },
        // 拓展名
        extensions: ['.js', '.vue']
    },
    // 模块
    module: {
        // 加载机
        rules: [
            // es6
            // {
            //     test: /\.js$/,
            //     loader: 'babel-loader',
            //     exclude: /node_modules/,
            //     options: {
            //         presets: ['@babel/env'],
            //     }
            // },
            // css
            {
                test: /\.css$/,
                // 添加拆分css的加载机
                use: ['style-loader', MiniCssExtract.loader, 'css-loader']
            },
            // scss
            {
                test: /\.scss$/,
                use: ['style-loader', MiniCssExtract.loader, 'css-loader', 'sass-loader']
            },
            // vue
            {
                test: /\.vue$/,
                loader: 'vue-loader'
            }
        ]
    },
    // 插件
    plugins: [
        new VueLoaderPlugin(),
        // html插件
        new HtmlWebpackPlugin({
            // 模板位置
            template: './public/index.html',
            // 发布位置
            filename: '../views/index.html',
            // 设置hash
            hash: true
        }),
        // css文件输出位置
        new MiniCssExtract({
            // filename: '[name].[hash:8].css'
            filename: '[name].css'
        }),
        // 压缩css
        new OptimizeCssAssets()

    ],
    // 优化
    optimization: {
        // 拆分库文件
        splitChunks: {
            // 缓存分组
            cacheGroups: {
                lib: {
                    name: 'lib',
                    test: /node_modules/,
                    chunks: 'initial'
                }
            }
        }
    }
}
```

