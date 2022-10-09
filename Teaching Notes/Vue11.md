# Vue 第十二天

## 一、Vue3

### 1.1 数据监听

watchEffect 立即执行回调函数，并监听内部响应式数据的变更

watch 监听数据变化（同watch）

​		 监听ref数据  watch(num, callback)

​		 监听多个ref数据 watch([num1, num2], callback)

​		 监听reactive数据 watch(obj.key, callback) 问题：1 无法获取前一个值， 2 无法深度监听

​				 正确写法 watch(() => obj.key, callback) 

​				 watch([() => obj.key1, () => obj.key2], callback)

​				 深度监听 watch(() => obj.data => callback, { deep: true }) 问题：无法获取前一个值 

​		 配置项 immediate：立即执行 deep：深度监听

```vue
<template>
<div>
    <input type="text" v-model="msg"> msg: {{msg}} <hr>
    <input type="text" v-model="num"> num: {{num}} <hr>
    <input type="text" v-model="person.name"> person.name: {{person.name}} <hr>
    <input type="text" v-model="person.age"> person.age: {{person.age}} <hr>
    <input type="text" v-model="person.job.salary"> person.job.salary: {{person.job.salary}} <hr>
    
</div>
</template>
<!-- 混合有两种： （1）分别写在各自标签下，（2）vue语法中，通过setup方法定义 -->
<script setup>
import { ref, reactive, watch } from 'vue';

let num = ref(100)
let msg = ref('hello')
let person = reactive({
    name: 'zhangsan',
    age: 20,
    job: {
        salary: 100
    }
})
// js中监听数据
// 值类型
// watch(msg, (next, prev) => {
//     console.log('msg', next, prev);
// })
// watch(num, (next, prev) => {
//     console.log('num', next, prev);
// })
// 通知监听多个值类型
// watch([msg, num], (next, prev) => {
//     console.log('all', next, prev);
// })
// 引用类型
// 引用类型不能直接监听，要写在方法中返回
// watch(person.name, (next, prev) => {
//     console.log('name', next, prev);
// })
// watch(() => person.name, (next, prev) => {
//     console.log('name', next, prev);
// })
// watch(() => person.age, (next, prev) => {
//     console.log('age', next, prev);
// })
// 一起监听，要写在数组中
// watch([() => person.name, () => person.age], (next, prev) => {
//     console.log('all', next, prev);
// })
// 监听后代属性
// watch(() => person.job.salary, (next, prev) => {
//     console.log('salary', next, prev);
// })
// 无法监听后代属性
// watch(() => person.job, (next, prev) => {
//     console.log('salary', next, prev);
// })
// 设置deep配置，可以监听后代属性，但问题是：无法正确获取前一个值（prev与next是一样的）
// watch(() => person.job, (next, prev) => {
//     console.log('salary', next.salary, prev.salary);
// }, { deep: true })

// 立即监听
watch(msg, (next, prev) => {
    console.log('msg', next, prev);
    // 立即执行，prev的值是undefined
}, { immediate: true })
</script>
<script>
// export default {
//     data() {
//         return {
//             msg: 'hello'
//         }
//     },
//     watch: {
//         // msg(val) {
//         //     console.log(val);
//         // }
//         msg: {
//             handler(value) {
//                 console.log(value);
//             },
//             immediate: true
//         }
//     }
// }
</script>
```



### 1.2 生命周期

beforeCreate 组件创建之前 setup方法模拟

created 组件创建完成  setup方法模拟

beforeMount 组件构建之前 onBeforeMount

mounted 组件构建完成 onMounted

beforeUpdate 组件更新之前 onBeforeUpdate

updated 组件更新完成 onUpdated

activated 组件被激活 onActivated

deactivated 组件被禁用 onDeactivated

beforeUnmount 组件销毁之前 onBeforeUnmount

unmounted  组件销毁完成 onUnmounted

```vue
<template>
<div>
    <h1>demo part -- {{msg}}</h1>
    <input type="text" v-model="num"> {{num}}
</div>
</template>
<script setup>
import { defineProps, ref, onBeforeMount, onBeforeUpdate, onBeforeUnmount, onMounted, onUpdated, onUnmounted, onActivated, onDeactivated } from 'vue';

defineProps(['msg']);
let num = ref(100)

// vue3中定义生命周期
// 创建期
onBeforeMount(() => {
    console.log('onBeforeMount');
})
onMounted(() => {
    console.log('onMounted');
})
// 存在期
onBeforeUpdate(() => {
    console.log('onBeforeUpdate');
})
onUpdated(() => {
    console.log('onUpdated');
})
// 销毁期
onBeforeUnmount(() => {
    console.log('onBeforeUnmount');
})
onUnmounted(() => {
    console.log('onUnmounted');
})
// keep-alive
onActivated(() => {
    console.log('onActivated');
})
onDeactivated(() => {
    console.log('onDeactivated');
})

// 最外层就是setup
console.log('setup');


</script>
<script>
// import { defineProps, ref } from 'vue';
// // 选项式，配置式
// export default {
//     props: ['msg'],
//     beforeCreate() {
//         console.log('beforeCreate');
//     },
//     created() {
//         console.log('created');
//     },
//     // setup再beforecreate之前执行
//     setup() {
//         let num = ref(100)
//         console.log('setup');
//         return { num }
//     },
//     beforeMount() {
//         console.log('beforeMount');
//     },
//     mounted() {
//         console.log('mounted');
//     },
//     beforeUpdate() {
//         console.log('beforeUpdate');
//     },
//     updated() {
//         console.log('updated');
//     },
//     beforeUnmount() {
//         console.log('beforeUnmount');
//     },
//     unmounted() {
//         console.log('unmounted');
//     },
//     activated() {
//         console.log('activated');
//     },
//     deactivated() {
//         console.log('deactivated');
//     }
// }
</script>
```



### 1.3 错误冒泡

解决子组件出现错误，冒泡到父级组件，导致整个页面无法渲染的问题

组件内部阻止冒泡

 		import { onErrorCaptured } from 'vue’;

​		 onErrorCaptured(() => { return false })

全局捕获错误

​		 app.config.errorHandler = () => {}

```vue
<template>
<div>
    <h1>parent part</h1>
    <hr>
    <child></child>
</div>
</template>
<script setup>
import { onErrorCaptured } from 'vue';
import Child from './Child.vue';

// 捕获错误
// onErrorCaptured(err => {
//     console.log('parent', err);
//     // 阻止向上层传播
//     return false;
// })
</script>
```



### 1.4 hooks

组件间数据，方法复用的一种方式

​	 hooks是一个工厂函数

​			 内部定义数据，方法，生命周期等

​			 返回值：对外提供的数据

​	 使用：执行工厂函数获取数据

```vue
<template>
<div>
    <h1 @click="add">app part  {{point.x}} -- {{point.y}}</h1>
    <hr>
    <parent></parent>
</div>
</template>
<script setup>
import Parent from './Parent.vue';
// 引入hook
import hook from './hooks';
// 解构数据
let { point, add } = hook();
</script>
```



### 1.5 依赖注入

provide和inject实现组件间的依赖注入

​		 功能类似父组件向子组件通信，但更直接

​		 provide(key, value)  向后代组件提供数据

​		 inject(key) 后代组件获取数据

注：只能由父组件向后代组件注入，后代组件不能向父组件注入

```vue
<template>
<div>
    <h1>child part -- {{msg}}</h1>
</div>
</template>
<script setup>
import { inject, provide } from 'vue';
let msg = inject('msg');
console.log(msg);

// console.log(inject('title'), inject('$http'));
let $http = inject('$http');

$http.get('/data?color=red')

// provide('num', 100)

// 父组件向子组件通信； 传递属性，$parent, vuex, provide/inject
</script>
```



### 1.6 组件挂载

内置组件：teleport

​		 定义组件模板在页面中渲染的位置

​		 属性：to CSS选择器

​		 内部的模板将渲染到CSS选择器指定的位置

```vue
<template>
<div class="demo">
    <h1>app part</h1>
    <button @click="isShow = true">打开弹框</button>
    <hr>
    <!-- 更改元素渲染的位置 -->
    <teleport to="body">
        <div v-if="isShow" class="layer">
            <h1>hello 换肤</h1>
            <button @click="isShow = false">关闭</button>
        </div>
    </teleport>
</div>
</template>
<script setup>
import { ref } from 'vue';

let isShow = ref(false)

</script>
```



### 1.7 异步组件

新增组件：Suspense

​	 用于加载异步组件，常用插槽： 

​			 \#default  渲染异步组件

​			 \#fallback 组件加载完，提示的内容

定义异步组件：defineAsyncComponent

​	 参数是回调函数，回调函数的返回值

​			 import(url) 直接异步加载组件

​			 new Promise(() => import(url)) 异步操作中（延迟）加载组件

```vue
<template>
<div class="demo">
    <h1>app part</h1>
    <hr>
    <!-- <demo></demo> -->
    <Suspense>
        <!-- <demo></demo> -->
        <!-- 默认插槽叫default -->
        <template #default>
            <demo></demo>
        </template>
        <!-- 加载完成前提示内容 -->
        <template #fallback>
            <h1>loading...</h1>
        </template>
    </Suspense>
    
</div>
</template>
<script setup>
import { defineAsyncComponent } from 'vue';
// 同步打包
// import Demo from './Demo.vue'
// 异步载入（拆分模块）
// 直接加载
// let Demo = defineAsyncComponent(() => import('./Demo.vue'))
// 延迟加载
let Demo = defineAsyncComponent(() => new Promise(resolve => {
    window.addEventListener('click', () => {
        resolve(import('./Demo.vue'))
    })
}))

</script>
```




### 2.2 目录部署

项目主要包含两个部分：移动端项目，服务器端项目，所以分别用两个文件夹表示：

​		 project移动端项目

​		 server  服务器与数据库



