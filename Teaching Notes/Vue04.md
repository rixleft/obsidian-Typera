# Vue 	第四天

## 一、Vue

### 1.1 组件

html：  组件就是一段可以被复用的结构代码

css：  组件就是一段可以被复用的样式代码

js:  组件就是一段可以被复用的功能代码

vue：  组件是一个包含独立的结构，样式和脚本的代码。我们可以复用。

使用组件分成三步

​	第一步 在模板中使用组件

​		 	组件名称字母小写，横线分割单词。注意：首字母不区分大小写。

​	第二步 在脚本中，定义组件类：Vue.extend({})

​			 参数对象跟new Vue时候传递的参数对象是一样的 。

​			 例如：可以传递data, compted, methods, watch 等属性。

​			 这些属性的功能都是一样的 ，但是有些属性的写法是特殊的。

​					 data属性：

​							 是一个函数，返回值是绑定的数据。

​							 this指向组件实例（由于该方法执行完毕，才能绑定数据，因此当前的this无法访问模型数据）

​					 template 定义模板的，有两种用法

​							 第一种：属性值是模板字符串（将组件的模板写在脚本中了）

​							 第二种：属性值是css选择器，此时会将页面中对应元素的内容作为组件的模板。

​							 html定义模板有两种方式：

​									1 通过script模板标签定义 

​									2 通过template标签定义（vue建议）

​							 注意：模板中最外层有且只有一个根元素。

​	第三步 注册组件，有两种方式

​			 1 全局注册

​					Vue.component(name, Comp)：全局注册的组件可以在任何组件中使用。

​			 2 局部注册

​					components: { name: Comp }：局部注册的组件只能在当前组件中使用

​			 name表示组件名称，要使用驼峰式命名（首字母不区分大小写）

​			 Comp表示组件类。

​	注意：组件是完成独立的，彼此之间数据，方法等不会共享。

**父子组件**

由于组件类继承了Vue类，因此组件实例化对象可以看成是vue实例化对象，反之vue实例化对象也可以看成是组件实例化对象。

​	 在vue实例中使用组件，我们就可以将

​			 vue实例看成是父组件

​			 将自定义的组件看成是子组件。

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
        <h1 @click="clickParent">app part -- {{msg}}</h1>
        <hr>
        
        <!-- 1 使用组件 -->
        <Demo></Demo>
        <!-- 首字母不区分大小写 -->
        <!-- <demo></demo> -->
        <!-- 横线分割单词 -->
        <!-- <de-mo></de-mo> -->
    </div>

    <!-- 定义模板的方式有两种:  -->
    <!-- 1 通过script标签定义 -->
    <!-- <script type="text/template" id="tpl">
        <h1 @click="childClick">demo part -- {{msg}}</h1>
    </script> -->

    <!-- 2 通过template标签定义 -->
    <template id="tpl">
       <div>
            <input type="text" v-model="msg">
            <h1 @click="childClick">demo part -- {{msg}}</h1>
       </div>
    </template>


    <!-- 注意：组件是完全独立的，彼此之间数据，方法等不会共享。-->

    <!-- 引入文件 -->
    <script src="./dist/01.js"></script>
</body>
</html>
```



### 1.2 动态组件

我们目前使用的组件都是静态的：一个元素对应一个组件类。

想使用动态组件（一个元素可以对应多个组件类），可以通过component组件实现。

​		 通过is属性定义渲染哪个组件类，

​				 默认是属性值是字符串

​				 我们可以通过v-bind指令动态绑定。

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
        <h1>app part</h1>
        <hr>
        
        <!-- 定义组件渲染的位置 -->
        <!-- <Home></Home> -->

        <!-- <List></List> -->

        <!-- 使用动态组件 实现一对多的关系 -->
        <!-- 默认是一个字符串 is的属性值是注册时候的组件名称 -->
        <!-- <component is="list"></component> -->


        <button @click="page = 'home'">点我切换home</button>
        <button @click="page = 'list'">点我切换list</button>

        <!-- 动态设置 -->
        <component :is="page"></component>

    </div>

   

    <!-- 引入文件 -->
    <script src="./dist/02.js"></script>
</body>
</html>
```



### 1.3 生命周期

对于一个组件来说，存在三个过程：创建，存在和销毁。因此vue为组件定义生命周期来说明这三个过程。

**创建期**

 当我们创建组件的时候（如在页面中使用），组件将执行创建期的方法，

​		 beforeCreate  组件创建前，此时数据，事件等还没有初始化

​		 created  组件创建后，此时组件已经绑定了数据，事件等

​		 beforeMount  组件构建前，此时确定了组件的模板，以及渲染的容器元素等。

​		 mounted  组件构建后，此时组件上树了

 一个组件在一生中只能创建一次，因此创建期的方法只能执行一次。

 一旦组件的模型数据发生改变，组件将会执行存在期的方法

**存在期**

当组件创建完成，将进入存在期，共分两个阶段：

​		 beforeUpdate 组件更新前，此时数据改变了，视图尚未更新

​		 updated  组件更新后，此时数据和视图都更新了

 在一个组件中，我们可以不停的改变模型数据，因此存在期的方法会不停的执行。

 存在期的方法执行完毕，只是说一次更新的结束，存在期仍然继续。

**销毁期**

当组件从页面中删除（执行了$destroy方法）,组件将进入销毁期，执行销毁期的方法，共分两个阶段：

​		 beforeDestroy 组件销毁期，此时组件中的数据等还有监听器。

​		 destroyed  组件销毁后，此时组件的数据所具有的监听器以及子组件等被销毁了。

 一旦组件被销毁，我们就再也无法使用组件了，想使用只能创建新的组件了。

以上周期方法this都指向组件实例，没有参数，



### 1.4 keep-alive

当组件从页面中删除，组件将执行销毁期的方法，如果从页面中移除的时候，不想将组件销毁，可以使用keep-alive组件。

​		 该组件会将从页面中移除的组件暂存到内存中，没有被销毁，再次显示的时候，直接从内存中读取。

​		 由于组件没有被销毁，因此不会执行销毁期的方法。为了表示显示和隐藏的过程，keep-alive组件为内部的组件拓展了两个方法：

 				activated 组件被激活，可以在页面中看到

​				 deactivated 组件被禁用，从也页面中移除了

 注意：由于组件被缓存到内存中，因此没有被销毁，保留最后一个状态，因此当组件再次显示的时候，会显示被保留的最后一个状态。

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
        <h1>app part</h1>
        <hr>
        
        <!-- 定义组件渲染的位置 -->
        <!-- <Home></Home> -->

        <!-- <List></List> -->

        <!-- 使用动态组件 实现一对多的关系 -->
        <!-- 默认是一个字符串 is的属性值是注册时候的组件名称 -->
        <!-- <component is="list"></component> -->


        <button @click="page = 'home'">点我切换home</button>
        <button @click="page = 'list'">点我切换list</button>

        <!-- 动态设置 -->
        <component :is="page"></component>

    </div>

   

    <!-- 引入文件 -->
    <script src="./dist/02.js"></script>
</body>
</html>
```



### 1.5 组件通信

组件是一个完整独立的个体，彼此之间的数据，方法等不会共享，想在组件之间共享数据，我们可以使用组件通信的技术。

通常有三个方向：

​		 父组件向子组件通信

​		 子组件向父组件通信

​		 兄弟组件间通信。

### 1.6 父组件向子组件通信

父组件向子组件通信就是将父组件的数据，方法传递给子组件。

需要两步

​		 第一步 在父组件模板中，为子组件元素传递数据。

​				 属性值默认是字符串，想传递变量或者方法，要使用v-bind指令动态传递。

​				 命名规范：字母小写，横线分割单词

​		 第二步 在子组件中，接收数据或者方法。

​				 在props属性中接收，有两种接收方式

​				 第一种 属性值是数组，每一个成员代表一个接收的属性名称。

​				 第二种 属性值是对象

​						  key  表示接收的属性名称

​						 value 有三种方式

​								 可以是类型的构造函数：Number, String等

 								可以是数组，每一个成员代表一种类型（定义多种类型）

 								可以是对象：

​								 		type：表示类型的构造函数，

​								 		required：是否是必须的，

​								 		default：默认值，属性值可以是数据，属性值还可以是方法，返回值就是默认的数据。

​								 		validator：校验方法，在方法中，校验数据是否合法。

​		 注意：接收属性的时候，属性命名规范：驼峰式命名。

props中接收的数据与模型中的数据一样，都添加给实例化对象自身，并设置了特性。

因此我们既可以在JS中使用，也可以在模板中使用。

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
        <h1>app part--- {{msg}}</h1>
        <hr>

        <!-- 子组件 -->
            <!-- 直接传递属性数据即可 默认都是字符串 -->
            <!-- 想要动态传递要使用v-bind指令 -->
        <!-- <Demo title="nihao" :num="100" :msg="msg" :parent-method="parentMethod"></Demo> -->
        <Demo title="nihao" :msg="msg"  :parent-method="parentMethod"></Demo>
        <!-- <Demo></Demo> -->
    </div>

    <!-- 引入文件 -->
    <script src="./dist/04.js"></script>
</body>
</html>
```



### 1.7 $parent

子组件中还可以通过$parent属性访问父组件，因此就可以间接的获取父组件中的数据。

 		但是工作中，不建议这么使用，因为这种方式与父组件耦合并且无法校验数据，

​		 所以我们要使用父组件向子组件传递属性的方式实现通信。

### 1.8 自定义事件

vue也实现了观察者模式，提供了订阅消息，发布消息，注销消息等方法。

​	 $on(type, fn)  订阅消息方法

​			 type：消息名称，

​			 fn：消息回调函数，参数是由$emit方法传递的。

​	 $emit(type, ...args)  发布消息方法

​			 type：消息名称，

​			 ...args：从第二个参数开始，表示传递的数据

​	 $off(type, fn) 注销消息方法

​			 type：消息名称

​			 fn：消息回调函数

 组件是一个完整独立的个体，因此彼此之间数据不会共享，所以发布消息与订阅消息必须是同一个组件。

```js
// 引入Vue
import Vue from 'vue';


// 2 定义组件类
let Demo = Vue.extend({
    // 定义模板 
    template: `
        <div>
            <h1>demo part </h1>
        </div>
    `,
    // 组件创建完成之后
    created() {
        // // 发布父组件中的消息
        // this.$emit('sendMsg', 100, true, 'abc');

        // console.log('demo', this);
        this.$msg.$emit('hello', 100, 200, false);
    }
})


// 实例化
new Vue({
    // 简写
    components: { Demo },
    // 绑定视图
    el: '#app',
    // 绑定数据
    data: {
        msg: 'parent msg'
    },
    // 定义方法
    methods: {
        parentMethod() {
            console.log('parent method');
        }
    },

    // 创建之前
    beforeCreate() {
        // 事件总线
        Vue.prototype.$msg = this;
    },

    // 组件创建完毕之后
    created() {
        // 监听消息
        // this.$on('sendMsg', (...args) => {
        //     console.log(111, args);
        // })

        // 发布父组件中的消息
        // this.$emit('sendMsg', 100, true, 'abc');


        // 此时可以通过事件总线的方式 监听消息
        this.$msg.$on('hello', (...args) => {
            console.log(111, args);
        })
    }
})


// 组件是一个完整独立的个体，因此彼此之间数据不会共享，所以发布消息与订阅消息必须是同一个组件。
```



### 1.9 子组件向父组件通信

子组件向父组件通信的实现

​		 在父组件中，订阅消息，

​		 在子组件中，通过this.$parent访问父组件，发布消息并传递数据

​		 在父组件中，接收并存储数据

在通信过程中，我们访问了$parent，因此产生了耦合，所以在工作中，这种方式不常用。

子组件向父组件通信有两种常用方式：

​		 第一种：**模拟DOM事件**

​		 第二种：**传递属性方法**

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
    <div id="app">
        <input type="text" v-model="msg">
        <h1 @click="clickH1">{{msg}}</h1>
        <hr>
        <child></child>
    </div>
    <script src="./dist/06.js"></script>
</body>
</html>
```



### 1.10 模拟DOM事件

绑定DOM事件：v-on:click=”fn”

模拟DOM事件：v-on:demo=”fn” demo事件名称就是自定义事件名称

子组件向父组件通信

​		 1在父组件模板中，为子组件元素绑定自定义事件。

​				 消息名称：字母小写横线分割单词。注意：绑定事件的时候，不要添加参数集合

​						 如果没有添加参数集合，可以接收所有的数据

​						 如果添加了参数集合，不能接收数据，即使传递了$event也只能接收一条数据

​		 2 在子组件中，通过$emit发布消息，并传递子组件中的数据。

​				 消息名称：字母小写横线分割单词。注意：这是唯一一个不需要做驼峰式命名转换的地方。

​		 3 在父组件事件回调函数中，接收数据并存储数据。

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
        <h1>app part--- {{msg}}</h1>
        <hr>
        <!-- 使用组件 没有添加参数集合 -->
        <!-- <Demo @demo-mesage="parentMethod"></Demo> -->
        <!-- 添加了参数集合 默认接收不到任何数据  即使传递$event也只能接收一个数据 -->
        <!-- <Demo @demo-mesage="parentMethod($event)"></Demo> -->
        <!-- 总结: 不要添加参数集合 -->
        <!-- <Demo @demo-mesage="parentMethod"></Demo> -->

        <!-- 传递的源生的click -->
        <Demo @click="parentMethod"></Demo>

        <!-- 想要作为源生的方法使用 使用native修饰符 -->
        <!-- <Demo @click.native="parentMethod"></Demo> -->
    </div>

    <!-- 引入文件 -->
    <script src="./dist/06.js"></script>
</body>
</html>
```



### 1.11 传递属性方法

我们可以向子组件传递父组件方法，让子组件执行父组件方法并传递数据的形式，来实现通信。

​		 第一步 在父组件模板中，为子组件传递父组件中的方法。

​		 第二步 在子组件中，接收方法，执行方法并传递数据，

​		 第三步 在父组件的方法中，接收数据，并存储数据。

```html
// 引入Vue
import Vue from 'vue';


// 2 定义组件类
let Demo = Vue.extend({
    // 通过props属性接收
    // props: ['sendMethod'],
    // 对象的形式
    props: {
        sendMethod: Function
    },
    // 定义模板 
    template: `
        <div>
            <input type="text" v-model="msg" />
            <h1>demo part -- {{msg}} </h1>
        </div>
    `,
    // 定义数据
    data() {
        return {
            msg: 'child msg'
        }
    },
    // 创建完成之后发布消息
    created() { 
       this.sendMethod(this.msg);
    },
    watch: {
       msg(newValue) {
            this.sendMethod(newValue);
       }
    }
})


// 实例化
new Vue({
    // 简写
    components: { Demo },
    // 绑定视图
    el: '#app',
    // 绑定数据
    data: {
        msg: ''
    },
    // 定义方法
    methods: {
        parentMethod(msg) {
            console.log('parent', arguments);

            // 接收并存储
            this.msg = msg;
        }
    }
})


```



### 1.12 兄弟组件间通信

两个兄弟组件之间没有必然的联系，但是它们都与父组件有联系，因此要实现兄弟组件间通信就是综合使用以上两种通信方式。

 		父组件向子组件通信

 		子组件向父组件通信

流程：

​		 1 将一个子组件的数据传递给父组件。

​		 2 父组件存储数据，再将新的数据传递给另一个子组件。

对于不相干的两个组件之间的通信，后面会学习VueX来解决。

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
        <h1>app part--- {{msg}}</h1>
        <hr>

        <!-- 兄弟组件 -->
        <!-- 模拟DOM事件 -->
        <!-- <First @hello="parentMethod"></First> -->
        <!-- 传递属性方法 -->
        <First :send-message="parentMethod"></First>

        <!-- 传递属性数据 -->
        <Second :msg="msg"></Second>
    </div>

    <!-- 引入文件 -->
    <script src="./dist/08.js"></script>
</body>
</html>
```




