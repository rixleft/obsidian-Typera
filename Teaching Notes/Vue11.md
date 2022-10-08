# Vue3 第十一天

## 一、Vue3

### 1.1 ref 函数

作用：定义响应式的数据

语法：let demo = ref(value)

 		创建一个包含响应式数据的引用对象（reference对象，简称ref对象)

​		 响应式：视图更新模型亦更新，模型更新视图亦更新

 注：只能通过ref的value属性更新数据

```vue
<template>
<div>
    <input type="text" v-model="msg">
    <h1>msg: {{msg}}</h1>
    <hr>
    <input type="text" v-model="person.name">
    <h1>person.name: {{person.name}}</h1>
    <hr>
    <input type="text" v-model="person.job.salary">
    <h1>person.job.salary: {{person.job.salary}}</h1>
    <button @click="change">修改数据</button>
</div>
</template>
<script setup>
// 组合式API：需要什么。就引入什么
import { ref } from 'vue';

// 普通的数据，不具有响应式，可以在视图中使用，想具有响应式，要使用ref方法
var msg = ref('hello');
var person = ref({
    name: 'zhangsan',
    age: 20,
    job: {
        salary: 100
    }
})

// 定义方法
function change() {
    console.log(person);
    // msg = 'abc';
    // ref对象，要通过value属性修改
    msg.value = 'abc';
    // 对象想访问数据，要借助value
    person.value.name = 'lisi';
    // 后代属性直接写（原因是value获取的数据是代理）
    person.value.job.salary = 500;
}
</script>
```



### 1.2 reactive 函数

作用：定义对象类型的响应式数据

 	注：基本类型不要用它，要用ref函数

语法：let 代理对象= reactive(源对象)

​		 参数：对象或者数组等

​		 返回值：代理对象（proxy实例）

​		 reactive定义的响应式数据是“深层次的”

内部基于 ES6 的 Proxy 实现，通过代理对象，对源对象内部数据进行操作

```vue
<template>
<div>
    <input type="text" v-model="msg">
    <h1>msg: {{msg}}</h1>
    <hr>
    <input type="text" v-model="person.name">
    <h1>person.name: {{person.name}}</h1>
    <hr>
    <input type="text" v-model="person.job.salary">
    <h1>person.job.salary: {{person.job.salary}}</h1>
    <hr>
    <h1>数据丢失问题： {{arr[0]}}--{{arr[3]}}--{{person.num}}</h1>
    <button @click="change">修改数据</button>
</div>
</template>
<script setup>
// 组合式API：需要什么。就引入什么
import { ref, reactive } from 'vue';
// 值类型的数据，不能被reactive包装，只能使用ref
var msg = ref('hello');
// 引入类型的数据，可以使用reactive包装
var person = reactive({
    name: 'zhangsan',
    age: 20,
    job: {
        salary: 100
    }
})
// 数据丢失问题：1 未初始化，2 数组值类型，3 数组新成员，4 对象新属性
var arr = reactive(['red', 'green'])

// 定义方法
function change() {
    console.log(msg, 111, person);
    // ref包装成ref对象，因此要借助value属性操作
    // msg.value = 'abc';
    // reactive包装成代理对象，因此可以直接操作
    // person.name = 'lisi';
    // person.job.salary = 500;
    // 工作中，建议将引用类型的数据，用reactive处理，原因是操作更方便
    // 修改数据，查看数据丢失问题
    // vue3解决了数据丢失的问题
    arr[0] = 'pink';
    arr[3] = 'purple';
    person.num = 123;
}
</script>
```



### 1.3 响应式实现

Vue 2.0

 		通过ES5提供的特性实现的

Vue 3.0

​		 ref  通过特性实现响应式

​		 reactive  通过代理实现响应式

```vue
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
        <h1>{{name}}--{{name}}--{{age}}--{{msg}}</h1>
    </div>
    <script>
    // vue2的实现
    // var data = { _data: {} }
    // // 通过特性实现
    // Reflect.defineProperty(data, 'name', {
    //     get() {
    //         return this._data.name
    //     },
    //     set(value) {
    //         this._data.name = value;
    //         // 更新视图
    //         render(this._data)
    //     }
    // })
    // Reflect.defineProperty(data, 'age', {
    //     get() {
    //         return this._data.age;
    //     },
    //     set(value) {
    //         this._data.age = value;
    //         // 更新视图
    //         render(this._data)
    //     }
    // })

    // vue3中，通过代理实现，解决了数据丢失问题（reactive实现）
    // var person = {};
    // // 用data代理person，以后操作data相当于操作person
    // var data = new Proxy(person, {
    //     get(target, key) {
    //         return Reflect.get(target, key)
    //     },
    //     set(target, key, value) {
    //         // console.log(arguments);
    //         // target[key] = value;
    //         // es6中reflect提供了修改数据的方法
    //         Reflect.set(target, key, value)
    //         // console.log(person);
    //         // 更新视图
    //         render(target)
    //     }
    // })

    // // 获取容器元素
    // let app = document.getElementById('app');
    // // 获取模板
    // let tpl = app.innerHTML
    // // 定义渲染视图的方法
    // function render(data) {
    //     let html = tpl.replace(/{{(\w+)}}/g, (match, $1) => {
    //         // console.log($1);
    //         return data[$1] || ''
    //     })
    //     // 更新视图
    //     app.innerHTML = html;
    // }

    // data.name = 'zhangsan'
    // data.age = 20
    // // 添加新属性
    // data.msg = 'hello'


    // ref实现
    // ref是一个工厂， 返回RefImpl实例
    function ref(value) {
        return new RefImpl(value)
    }
    // 实现ref类
    class RefImpl {
        constructor(value) {
            // 数据存储在_value中
            this._value = value;
        }
        // 取值器
        get value() {
            return this._value;
        }
        // 赋值器
        set value(value) {
            this._value = value;
            // 更新视图
            render();
        }
    }

    // 定义数据
    var data = {
        name: ref(),
        age: ref(),
        msg: ref()
    }
    // 获取容器元素
    let app = document.getElementById('app');
    // 获取模板
    let tpl = app.innerHTML
    function render() {
        var html = tpl.replace(/{{(\w+)}}/g, (match, $1) => {
            return data[$1].value || ''
        })
        app.innerHTML = html;
    }
    data.name.value = 'zhangsan';
    data.age.value = 20;
    data.msg.value = 'hello'
    // console.log(data.name, data.age, data);
    </script>
</body>
</html>
```



### 1.4 响应式 API

**toRef**  

​		将proxy对象（reactive）的属性转化成ref对象

**toRefs** 

​		将proxy对象转成ref对象

**shallowRef** 

​		能让值类型响应式，对象不可以

​		注：ref参数可以是对象，此时一级属性是ref对象，后代属性是代理

**shallowReactive**  

​		浅层响应式，后代属性无法响应式

**toRaw**  

​		将proxy对象转成普通对象（取消代理）

**markRaw** 

​		处理的对象无法再被代理（代理后设置，无效）

**readonly** 

​		响应数据是只读的（不能修改）

**shallowReadonly** 

​		值类型的响应数据是只读的，对象类型的响应数据是可操作的

```vue
<template>
<div>
    <input type="text" v-model="person.name"> <span>person.name: {{person.name}}</span> <hr>
    <input type="text" v-model="person.job.salary"> <span>person.job.salary: {{person.job.salary}}</span> <hr>
</div>
</template>
<script setup>
import { ref, reactive, toRef, toRefs, shallowRef, shallowReactive, toRaw, markRaw, readonly, shallowReadonly } from 'vue';
var person = {
    name: 'zhangsan',
    age: 20,
    job: {
        salary: 100
    }
}
// 响应式
// person = reactive(person)
// 只读的，无法修改
// person = readonly(person)
// 一级属性是只读的，后代属性是可以操作的
person = shallowReadonly(person)

console.log(person);

</script>
```



### 1.5 判断响应式数据

**isRef**(data) 

​		判断data是否是ref对象

**isReactive**(data) 

​		判断data是否是reactive创建的proxy对象

**isReadonly**(data) 

​		判断data是否是readonly创建的proxy对象

**isProxy**(data) 

​		判断data是否是由reactive或readonly创建的proxy对象

```vue
<template>
<div>
    <input type="text" v-model="person.name"> <span>person.name: {{person.name}}</span> <hr>
    <input type="text" v-model="person.job.salary"> <span>person.job.salary: {{person.job.salary}}</span> <hr>
</div>
</template>
<script setup>
import { ref, reactive, toRef, toRefs, shallowRef, shallowReactive, toRaw, markRaw, readonly, shallowReadonly, isRef, isReactive, isReadonly, isProxy } from 'vue';
let msg = ref('hello');
let person = reactive({
    name: 'zhangsan',
    age: 20,
    job: {
        salary: 100
    }
})
let colors = readonly(['red', 'green']);
console.log(msg, person, colors);
// 是否是ref对象
// console.log(isRef(msg));
// console.log(isRef(person));
// console.log(isRef(colors));
// 是否是reactive创建的代理对象
// console.log(isReactive(msg));
// console.log(isReactive(person));
// console.log(isReactive(colors));
// 判断是否是readonly创建的代理对象
// console.log(isReadonly(msg));
// console.log(isReadonly(person));
// console.log(isReadonly(colors));
// 是否是代理对象
console.log(isProxy(msg));
console.log(isProxy(person));
console.log(isProxy(colors));
</script>
```



### 1.6 自定义 ref

customRef：创建一个自定义的 ref

​	 参数工厂函数

​	 参数

​			  track  通知vue，value是有用的，要追踪变化

​			  trigger 广播消息更新视图

​	 返回值

​			 get  取值器方法

​			 set  赋值器方法

```vue
<template>
<div>
    <input type="text" v-model="msg"> <span>person.name: {{msg}}</span> <hr>
</div>
</template>
<script setup>
import { ref, customRef } from 'vue';
// let msg = ref('hello');

// 自定义ref
function icktRef(value, time = 1000) {
    let timebar = null;
    /**
     * trace    追踪数据的变化
     * trigger  广播消息更新视图
     * */ 
    return customRef((trace, trigger) => ({
        // 取值器
        get() {
            // 追踪value的变化
            trace();
            return value
        },
        // 赋值器
        set(val) {
            // 利用防抖，优化
            clearTimeout(timebar);
            
            timebar = setTimeout(() => {
                value = val;
                // 更新视图
                trigger();
            }, time)
        }
    }))
}

// 输入完成，再更新
let msg = icktRef('hello')
</script>
```



### 1.7 setup 参数

props 包含显示声明的属性数据对象

context  组件相关数据

​	 attrs  未显示声明的属性数据对象（同$attrs）

​	 slots 存储组件的插槽（同$slots）

​	 emit  发布消息方法（同$emit）

​	 expose  向外暴露数据的方法

​			 通过父组件的ref访问组件expose暴露的数据

```vue
<template>
<div>
    <h1>demo part -- {{msg}}</h1>
</div>
</template>
<script setup>
import { defineProps, defineExpose, defineEmits } from 'vue';
// 接收属性
defineProps(['msg'])
// 暴露接口
defineExpose({ num: 123 })
// 发布消息
var emit = defineEmits()
emit('send', 100)

</script>
<!--<script>
export default {
    props: ['msg'],
    // 向外暴露属性
    // 定义了expose，则暴露expose中的数据，没有定义，则暴露全部的数据
    expose: ['num'],
    data() {
        return {
            num: 100
        }
    },
    setup(props, context) {
        /***
         *  props    传递的属性，被子组件接收的
         *  context包含四个属性
         *      atrrs   存储子组件中，未被接收的属性
         *      emit    发布消息
         *      expose  向外部暴露的数据
         *      slots   存储组件的插槽
         * **/ 
        console.log(props, context);
        context.emit('send', 100, 200, true)
        let demo = 'hello';
        // 向外暴露数据
        context.expose({ demo })
        // console.log(context.slots.header);
        // return context.slots.header
    }
}
</script>-->
```



### 1.8 计算属性数据

computed方法定义计算属性数据

​	 参数

​			 函数 只定义取值器方法

​	 对象

​			 get  定义取值器方法

​			 set  定义赋值器方法

```vue
<template>
<div>
    <input type="text" v-model="msg"> <span>person.name: {{msg}} -- {{dealMsg}}</span> <hr>
    <input type="text" v-model="dealMsg">
</div>
</template>
<script setup>
import { ref, computed } from 'vue';
let msg = ref('hello')
// 定义数据
// let dealMsg = computed(function() {
//     // 函数式编程不要出现this
//     return msg.value.toUpperCase();
// })
// 定义取值器和赋值器
// let dealMsg = computed({
//     // 取值器
//     get() {
//         return msg.value.toUpperCase();
//     },
//     // 赋值器
//     set(val) {
//         msg.value = val.toLowerCase();
//     }
// })

/****
 *  响应式
 *      ref                 处理值类型，应用类型也能处理
 *          问题；js中处处使用value
 *      reactive            处理引用类型
 *          直接修改数据
 *      toRef               转换一个属性
 *      toRefs              转换多个属性
 *      shallowRef          只能处理值类型
 *      shallowReactive     一级属性有效
 *      toRaw               还原响应式（失去响应式）
 *      markRaw             不能再响应式
 *          再响应式之前
 *      readonly            只能读取不能修改
 *      shallowReadonly     只针对一级属性只读，后代可以修改
 *      isRef               判断ref对象
 *      isReactive          判断reactive创建的代理对象
 *      isReadonly          判断readonly创建的代理对象
 *      isProxy             判断是否未代理对象
 *      customRef           自定义ref对象
 * ****/ 
</script>
```

