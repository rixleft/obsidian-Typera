# vue第1天

# 一、Vue

### 1.1 MVVM

MVVM模式包含三个部分：

​		 M  模型model

​		 V  视图 view

​		 VM  视图模型 view-model

特点：实现了数据双向绑定

​		 数据由模型进入视图，通过数据绑定实现的

​		 数据由视图进入模型，通过事件监听实现的

vue就是基于MVVM模式实现的。

### 1.2 MVVM模式的由来

 早期js被设计的很简单，主要解决一些简单的交互问题。主要的问题就是浏览器兼容性，所以jQuery就出现了，解决了兼容性问题，简化了开发。

 随着技术的发展，富客户端应用，单页面应用程序的出现，前端逻辑更加的复杂，因此如何维护好前端的代码，成了主要的问题。所以MVC一类的框架就出现

了，让我们将逻辑分成模型，视图和控制器，变得更容易开发和维护。

 但是在MVC模式中，开发项目非常的慢，因此MVVM模式就出现了，提供了数据双向绑定技术，极大的提高了开发效率。

Vue就是基于MVVM模式实现的。

### 1.3 获取 vue

官网： https://cn.vuejs.org/

GitHub：https://github.com/vuejs/vue

获取Vue

​	 在ES5开发中，我们要获取vue.js文件，可以通过bower工具

​			 bower install vue 

​			 我们可以通过npm来安装bower指令

​						 npm install -g bower

​	 在ES6开发中，我们要获取vue模块

​			 npm install vue

### 1.4 体验 vue

vue是基于MVVM模式实现的，因此也包含三个部分

​		 模型：js中的数据对象

​		 视图：页面中的模板视图

​		 视图模型：就是vue实例化对象

实例化vue类的时候，要传递参数对象

​		 通过el属性与页面中的模板绑定上

​		 通过data属性与模型数据绑定上。

### 1.5 vue 实例化对象

$el 代表视图中的容器元素。

模型中的数据会添加给实例化对象自身，并设置了特性。

并且在_data以及$data属性中，对模型数据做了备份。

当模型中的数据改变，视图会同步更新，这个过程就是vue实例化对象实现的（数据的绑定技术）。

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
    <!-- 2 模板视图 -->
    <div id="app">
        <!-- 实现数据双向绑定 -->
        <input type="text" v-model="msg">
        <h1>{{msg}}</h1>
    </div>
    <!-- 引入Vue -->
    <script src="./vue.js"></script>
    <script>
    // 关闭生产提示
    Vue.config.productionTip = false;


    // 1 定义模型数据
    let data = {
        msg: 'hello msg',
        num: 100
    }

    // 3 视图模型 
    let vm = new Vue({
        // el属性 绑定视图的
        // data属性 绑定模型数据的
        el: '#app',
        data
    })

    console.log(vm);

    </script>
</body>
</html>
```



### 1.6 数据绑定的实现

vue中，模型中的数据被设置了特性，因此ES5中属性的特性是vue数据绑定技术实现的关键。

 vue中数据的绑定是通过ES5中属性的特性实现的。

 因此不支持ES5中特性技术的浏览器，是不能使用vue的。

 vue是一个运行在高级浏览器下的框架。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <!-- 视图 -->
    <div id="app">
        <h1>{{msg}}</h1>
    </div>
    <script>
    // 模型
    let data = {
        msg: 'hello',
        // 备份对象
        _data: {}
    }



    // 通过设置特性的方式实现的
    Reflect.defineProperty(data, 'msg', {
        // 取值器方法
        get() {
            return data._data.msg;
        },
        // 赋值器方法
        set(val) {
            data._data.msg = val;
            // 更新视图
            updateView(this._data);
        }
    })


    // 获取模板
    let html = document.getElementById('app').innerHTML;
    // console.log(html);
    // 定义更新视图的方法
    function updateView(data) {
        // 如果将该条语句放入到内部 无法匹配插值语法 
        // let html = document.getElementById('app').innerHTML;
        // console.log(html);
        // 替换模板内容
        let tpl = html.replace(/{{(\w+)}}/g, (match, $1 = '') => {
            return data[$1];
        })

        // 更新视图 
        document.getElementById('app').innerHTML = tpl;
    }

    // 更新数据
    data.msg = 'hello';

   

    </script>
</body>
</html>
```



### 1.7 webpack编译

我们基于ES6语法开发，因此需要通过webpack将ES6编译成ES5或者ES3.1的版本。让更多的浏览器支持。

​		 在nodejs中，我们使用commonjs规范

​		 在ES6中，我们使用ES Module规范

ES6文件拓展名可以是.es,也可以是.js等。但是在工作中到底使用哪种方式，要看使用的编辑器。

resolve配置

​		 我们在resolve配置中，通过alias配置模块入口文件

​		 alias配置有两点作用：1 可以更改入口文件。 2 简化路径的书写

​		 在resolve我们还可以通过extensions配置文件的默认拓展名

​				 是一个数组，每一个成员代表一个默认拓展名。

```js
// 使用commonjs规范，定义配置
module.exports = {
    // 开发环境
    mode: 'development',
    // 解决问题
    resolve: {
        // vue入口文件
        alias: {
            // 以vue结尾
            'vue$': 'vue/dist/vue.esm.js'
        },
        // 默认拓展名
        // 工作中，样式文件一般不会设置默认拓展名，是为了区分脚本文件和样式文件
        extensions: ['.js', '.css']
    },
    // 入口文件
    entry: {
        '00': './modules/00.js',
        '01': './modules/01.js',
        '02': './modules/02.js',
        '03': './modules/03.js',
        '04': './modules/04.js',
        '05': './modules/05.js',
        '06': './modules/06.js',
        '07': './modules/07.js',
        '08': './modules/08.js',
        '09': './modules/09.js',
        '10': './modules/10.js'
    },
    // 发布
    output: {
        filename: '[name].js'
    },
    // 模块
    module: {
        // 加载机
        rules: [
            // css
            {
                test: /\.css$/,
                loader: 'style-loader!css-loader'
            },
            // sass
            {
                test: /\.scss$/,
                loader: 'style-loader!css-loader!sass-loader'
            },
        ]
    }
}
```



### 1.8 数据丢失

vue实现了MVVM模式，因此实现了对数据的绑定（当我们修改模型中的数据的时候，视图会同步更新）

​		 当我们修改数据的时候，如果视图没有更新，那么我们就说数据丢失了。

注意：数据丢失不是什么好的特性，是框架的bug。

数据绑定的实现原理：基于ES5中属性的特性实现的， 因此设置了特性的数据是不会丢失的。

所以没有设置特性的数据就丢失了。工作中常见的数据丢失有四类

​		 第一类：数组中的值类型：用新数组替换原来的数组

​		 第二类：数组中的新成员：用新数组替换原来的数组

​		 第三类：对象中的新属性：用新对象替换原来的对象

​		 第四类：未初始化的：将数据初始化。

**$set**

作者为了解决数据丢失的问题，提供了一个更加保险的方法：$set.

​		 第一个参数表示数据对象

​				 可以是vue实例化对象，也可以是其它对象

​		 第二个参数表示属性名称

​		 第三个参数表示属性值

```js
// 基于Es module规范导入模块
import Vue from 'vue';

// 关闭生产提示
Vue.config.productionTip = false;

// 实例化对象
let vm = new Vue({
    // 绑定视图
    el: '#app',
    // 绑定数据
    data: {
        msg: 'hello msg',
        // 定义数组
        colors: ['red', 'green', 'blue', { a: 1 }],
        obj: {
            width: 100,
            height: 200
        },
        // 只需要初始化即可
        hello: 111
    }
})

// 注意: 如果vue在更新带有特性的数据的时候 会连同没有特性的数据一起更新

// Vue 将被侦听的数组的变更方法进行了包裹，所以它们也将会触发视图更新。这些被包裹过的方法包括：
// push()
// pop()
// shift()
// unshift()
// splice()
// sort()
// reverse()




// 第一类：数组中的值类型：用新数组替换原来的数组
// vm.colors[0] = 'pink';
// vm.colors = ['pink', 'green', 'blue'];

// 使用$set修改器
// vm.$set(vm.colors, 0, 'pink');



// 第二类：数组中的新成员：用新数组替换原来的数组
// vm.colors[3] = 'orange';
// 在第五项添加成员
// vm.colors = ['pink', 'green', 'blue', '', 'orange'];


// 插入数据 (该方法是经过vue处理过的 所以可以触发更新)
// vm.colors.push('orange');


// 第三类：对象中的新属性：用新对象替换原来的对象'
// vm.obj.abc = 'hello abc';

// 使用$set
vm.$set(vm.obj, 'abc', 'hello abc');

// vm.obj = {
//     width: 100,
//     height: 200,
//     abc: 'hello abc'
// }

// 第四类：未初始化的：将数据初始化。
// 这种类型的数据 可以抛出错误信息



// 3s之后更新数据
setTimeout(() => {
    // vm.msg = 'hello123';

    // vm.colors[3].a = 100;
}, 3000);


console.log(vm);
```



### 1.9 计算属性数据

我们定义在data中定义的模型数据是固定不变的，我们想在获取数据的时候，动态改变数据，可以使用计算属性数据技术。

​		 静态的数据定义在data属性中：定义的是什么数据，获取的就是什么数据

​		 计算属性数据定义在comptued属性中：定义的是方法，获取的时候，会将执行的结果返回（是计算的）

computed与data的用法是一样的，添加给vue实例化对象自身，并设置了特性，定义的时候都是一个对象

​		 key表示数据名称 

​		 value是一个函数

​		 	 参数和this都指向vue实例化对象，

​					因此通过参数或者this可以获取vue中的其它数据。

​			  必须有返回值，就是获取的数据。

注意：当多次使用计算属性数据的时候，该方法只会执行一次。只有当内部使用的数据发生改变的时候，计算数据数据的方法才会执行一次。

不论是data中定义的数据还是computed中定义的数据都会添加给vue实例化对象自身并设置特性。

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
    <!-- 视图 -->
    <div id="app">
        <input type="text" v-model="msg">
        <h1>{{msg}}</h1>


        <!-- 使用计算属性数据 -->
        <hr>
        <h1>{{dealMsg}}</h1>


        <!-- 小案例 -->
        <hr>
        姓: <input type="text" v-model="firstName">
        名: <input type="text" v-model="lastName">
        <!-- 展示数据 -->
        <!-- <h1>全名: {{ firstName + '-' + lastName}} </h1> -->
        <!-- <h1>全名: {{ firstName }} - {{lastName}}</h1> -->

        <!-- 通过计算属性数据展示 -->
        <h1>全名: {{fullName}}</h1>

        <!-- 注意：当多次使用计算属性数据的时候，该方法只会执行一次。只有当内部使用的数据发生改变的时候，计算数据的方法才会执行一次。 -->
        <h1>全名: {{fullName}}</h1>
        <h1>全名: {{fullName}}</h1>
        <h1>全名: {{fullName}}</h1>
        <h1>全名: {{fullName}}</h1>

    </div>
    <!-- 引入发布之后的文件 -->
    <script src="./dist/05.js"></script>
</body>
</html>
```



### 1.10 插值

为了在模板中，使用模型中的数据，我们可以使用插值语法：{{}}

插值语法提供了一个真正的js环境，我们可以直接书写js表达式。

注意：插值语法中的js表达式无法复用，想复用可以放在计算属性数据中（多定义监听器，性能）。

​		 如果逻辑复杂：建议计算属性数据

​		 如果逻辑简单：建议js表达式。

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
    <!-- 定义视图 -->
    <div id="app">
        <!-- 插值符号中是真正的js环境 -->
        <h1>app {{msg + '!!!'}}</h1>

        <!-- 可以在插值符号中 书写js表达式 -->
        <h1>app part -- {{msg.toUpperCase()}}</h1>

        <!-- 
            如果逻辑复杂：建议计算属性数据
	        如果逻辑简单：建议js表达式 
        -->
        <hr>
    </div>
    <!-- 引入发布之后的文件 -->
    <script src="./dist/07.js"></script>
</body>
</html>
```



### 1.11 属性绑定

我们不能在元素的属性中使用插值语法。想动态设置属性，要使用属性绑定的技术。

​		 vue提供了v-bind指令，

​		 指令：指令就是对DOM元素的拓展，使其具有一定的行为特征（功能）。

​				 指令的属性值都是js环境，我们可以直接使用js表达式，

​		 属性绑定的语法：v-bind:key=”value”

​		 语法糖：语法糖就是对某个操作的简化，来提高我们的开发效率。

​				 v-bind指令的语法糖是冒号语法糖

​				 v-bind:key=”value” 可以写成 :key=”value”

​		 后面我们还会学习更多的语法糖。

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
    <!-- 定义视图 -->
    <div id="app">
        <h1 title="hello tile">{{msg}}</h1>
        <hr>
        <!-- 希望提示文字是msg变量的值  默认是msg字符串 -->
        <h1 title="msg">{{msg}}</h1>
        <!-- 可以使用动态绑定的方式 v-bind指令 此时指令的属性值是js环境 -->
        <h1 v-bind:title="msg + '!!!'">{{msg}}</h1>
        <!-- 提供了语法糖:  -->
        <h1 :title="msg + '!!!'">{{msg}}</h1>
    </div>
    <!-- 引入发布之后的文件 -->
    <script src="./dist/08.js"></script>
</body>
</html>
```



### 1.12 插值指令

v-text：该指令用来设置元素的内容，

​		与插值语法相比：

​				1 避免插值符号闪烁。

​				2 只能渲染元素的全部内容，我们还可以用字符串拼接形式来解决这个问题。

​		注：v-text指令与插值语法一样，都不能渲染标签。

v-html：该指令用来渲染带有html标签的文本。

​		与插值符号相比：

​				1 避免插值符号闪烁。

​				2 只能渲染元素的全部内容，我们还可以用字符串拼接形式来解决这个问题。

​				3 可以渲染标签。

​		注：渲染的内容一定要确保是安全的。否则会导致xss注入的问题。

v-once：该指令用来让内容单次渲染。

​		该指令不需要设置属性值。

​		该指令会让其所在的元素及其所有子元素上的所有插值与指令只执行一次。

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
    <!-- 定义视图 -->
    <div id="app">
        <h1>app part</h1>
        <hr>
        <!-- 默认渲染的是标签字符串 -->
        <h1>{{a}}</h1>
        <!-- 使用v-text 设置的是全部内容  无法渲染标签 -->
        <h1 v-text="a + 'abc'"></h1>
        <hr>

        <!-- v-html 可以渲染标签 -->
        <h1 v-html="a"></h1>

        <hr>
        <!-- v-once指令 单次渲染 -->

        <h1 v-once>{{a}}</h1>
        
        <!-- 还可以放在外层的容器中管理内部的子元素 -->
        <div v-once>
            <h1>{{a}}</h1>
        </div>

        

    </div>
    <!-- 引入发布之后的文件 -->
    <script src="./dist/09.js"></script>
</body>
</html>
```



### 1.13 插值过滤器

我们想对插值语法中的数据进行修改，可以使用js表达式，但是如果逻辑很复杂，会导致模板很臃肿。

为了解决臃肿的问题，vue提供了插值过滤器技术。

插值过滤器技术有三个优势：

​		 1 避免模板臃肿的问题。

​		 2 可以复用。

​		 3 可以跨组件使用。

在2.0中，作者弱化了过滤器，移除了内置的过滤器。

注意：在2.0中，作者建议用插值表达式以及计算属性数据的形式代替插值过滤器。

**使用过滤器**

我们可以在插值语法以及指令中使用插值过滤器。

 	语法 {{data | 过滤器(参数1, 参数2) | 过滤器2}}

​			 前一个过滤器的输出将作为后一个过滤器的输入。

**自定义过滤器**

在vue中自定义过滤器有两种方式

​		第一种：全局定义：

​			 	全局定义的过滤器可以在任何实例化对象（组件）中使用。

​				 通过Vue.filter(name, fn)

​		第二种：局部定义：

​				 局部定义的过滤器只能在当前实例化对象（组件）中使用。

​				 在vue实例化对象（组件）中，通过filters属性定义。

​				 filters: { name: fn }

​						 name表示过滤器名称：建议驼峰式命名

​						 fn(data, ...args)表示过滤函数：

​								data表示处理的数据。

​								args表示使用过滤器时候传递的参数。

​							    必须有返回值，就是处理的结果，

​		全局定义过滤器的时候，要注意：1 filter方法不能解构。2 要在vue实例化对象之前定义。

```js
// 基于Es module规范导入模块
import Vue from 'vue';

// 关闭生产提示
Vue.config.productionTip = false;

// 全局过滤器
    // 过滤函数中的第一个参数表示数据值 从第二个参数开始表示传递的数据
Vue.filter('dealMsg', (value, ...args) => {

    // 需求: 去掉- _ 并且让紧邻的字符大写
    return value.replace(/[_-]([a-z])?/g, (match, $1 = '') => {
        // console.log(111, $1);
        return $1.toUpperCase()
    })
})

// 实例化对象
new Vue({
    // 绑定视图
    el: '#app',
    // 绑定数据
    data: {
        msg: 'border_top-Left'
    },
    // 定义局部顾虑器
    filters: {
        uppercase(msg) {
            // console.log(this, arguments);

            return msg.toUpperCase();
        },
        slice(uppercaseMsg, ...args) {
            // console.log('slice', this, arguments);
            return uppercaseMsg.slice(...args);

        }
    }
})




```



### 1.14 数据双向绑定

vue实现了数据双向绑定，vue为了简化双向绑定，提供了v-model指令。

​		 属性值就是绑定的数据

​		注意： 

​				1 只能绑定数据，不能使用表达式 

​				 2 绑定的数据必须在模型中定义。如；data等。

​		例如：表单元素可以与用户交互，因此可以使用v-model指令。

​		数据双向绑定有两个方向：

 				数据由模型进入视图：通过数据绑定实现的。为value绑定模型数据

​				 数据由视图进入模型：通过事件监听实现的。监听input事件，更新数据

​	v-model指令简化了这两个过程，因此也可以看成是语法糖。

```js
// 基于Es module规范导入模块
import Vue from 'vue';

// 关闭生产提示
Vue.config.productionTip = false;

// 实例化对象
new Vue({
    // 绑定视图
    el: '#app',
    // 绑定数据
    data: {
        msg: 'hello msg',
        demo: 'hello title'
    },
    computed: {
        // 值是函数的形式 只是提供了一个get取值器
        // title() {
        //     return 'hello title'
        // }

        // 还可以是对象的形式
        title: {
            // 取值器
            get() {
                return this.demo;
            },
            // 赋值器
            set(val) {
                this.demo = val;
            }
        }
    }
})
```



### 1.15 v-cloak

用来解决插值符号闪烁的问题。

只需要两步：

​		 第一步 为容器元素设置v-cloak指令（属性）

​		 第二步 在style标签内（style标签要定义在容器元素的前面），通过v-cloak属性选择器，设置display: none样式，将元素隐藏。

注意：

​		 1 style标签要定义在容器元素的前面

​		 2 v-cloak只能给容器元素内部的元素使用（包括容器元素）。






