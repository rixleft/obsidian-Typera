# vue第2天

# 一、Vue

### 1.1 单选框

我们将input元素的type属性设置为radio就可以得到单选框，通过checked属性设置其选中状态。

对单选框实现数据双向绑定，也是用v-model指令。

特点：

​		 1 一组单选框绑定同一份数据。

​		 2 选框的值通过value属性定义。

​		 3 此时checked属性失效了。

​		 4 一组单选框的默认值就是绑定数据的值。

### 1.2 多选框

我们将input元素的type属性设置为checkbox就可以得到多选框，通过checked属性设置其选中状态。

对多选框实现数据双向绑定，也是用v-model指令。

特点：

​		 1 一组多选框绑定不同的数据，为了访问方便，我们将其放在同一个命名空间下。

​		 2 选框的值默认是布尔值，通过v-bind:true-value以及v-bind:false-value可以自定义其值：

​				 :true-value：定义选中时候的值 :false-value：定义未选中时候的值。

​		 3 checked属性失效了

​		 4 一组多选框的默认值就是绑定数据的值，如果自定义了:true-value以及:false-value属性，就是自定义数据值。

### 1.3 下拉框

我们通过select元素定义下拉框，通过option元素定义选项，

​		 选项的值默认是内容值，设置了value就是value值。

我们通过为select元素添加v-model指令实现数据双向绑定。

​		 单选下拉框绑定的是字符串。

​		 多（复）选下拉框绑定的是数组。

我们通过为select元素设置multiple属性，实现单选下拉框与多选下拉框的切换。

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
    <!-- 定义视图容器 -->
    <div id="app">
        <h1>app part</h1>
        <hr>

        <!-- 
            单选框特点：
                1 一组单选框绑定同一份数据。
                2 选框的值通过value属性定义。
                3 此时checked属性失效了。
                4 一组单选框的默认值就是绑定数据的值。
         -->

        <p>
            <label for="">请选择性别:</label>
            <input type="radio" v-model="sex" value="male">男
            <input type="radio" v-model="sex" value="female">女
        </p>
        <hr>



        <!-- 
            多选框的特点：
                1 一组多选框绑定不同的数据，为了访问方便，我们将其放在同一个命名空间下。
                2 选框的值默认是布尔值，通过v-bind:true-value以及v-bind:false-value可以自定义其值：
                     :true-value：定义选中时候的值			:false-value：定义未选中时候的值。
                3 绑定数据后， 属性失效了
                4 一组多选框的默认值就是绑定数据的值，如果自定义了:true-value以及:false-value属性，就是自定义数据值。
         -->

        <p>
            <label>请选择兴趣爱好:</label>
            <input type="checkbox" v-model="intrest.baseketball" value="baseketball">篮球
            <input type="checkbox" v-model="intrest.football" :true-value="'选中了'" :false-value="'未选中'" value="football">足球
            <input type="checkbox" v-model="intrest.pingpang" value="pingpang">乒乓球
        </p>
        <h1>{{intrest}}</h1>

        <hr>



        <!-- 

            下拉框:
                我们通过select元素定义下拉框，通过option元素定义选项，
                选项的值默认是内容值，设置了value就是value值。
                我们通过为select元素添加v-model指令实现数据双向绑定。

            多选下拉框:
                我们通过为select元素设置multiple属性，实现单选下拉框与多选下拉框的切换。

         -->
        <p>
            <select v-model="color">
                <option value="isRed" >red</option>
                <option value="isGreen" >green</option>
                <option value="isBlue" >blue</option>
            </select>
        </p>

        <!-- 多选下拉框  此时数据值是一个数组 -->
        <p> 
            <select  multiple v-model="color2">
                <option value="isRed" >red</option>
                <option value="isGreen" >green</option>
                <option value="isBlue" >blue</option>
            </select>
        </p>


    </div>
    <!-- 引入发布的文件 -->
    <script src="./dist/01.js"></script>
</body>
</html>
```

### 1.4 数据监听器

vue实现了数据双向绑定，当模型中的数据改变，会被视图监听到。进而同步到视图中。

如果想在js中，监听模型中数据的改变，可以使用监听器技术

​	 我们在实例化对象中的watch属性中，定义监听器，是一个对象

​			 key   被监听的数据名称

​			 value  当数据改变的时候，执行的回调函数。

​				 第一个参数表示新的值， 

​				 第二个参数表示旧的值。

​				  this指向vue实例

 注意：watch不仅仅可以监听模型中的数据，实例化对象中，设置了特性的数据都可以监听，例如：路由数据等。

### 1.5 状态监听

状态监听就是当数据改变的时候，我们平滑的将其过渡到某个值。

​	 我们在监听器中，监听数据的变化。

​	 我们再启动循环定时器，改变数据。

```js
// 引入vue
import Vue from 'vue';

// 定义句柄
let timer = null;

// 实例化
new Vue({
    // 绑定视图
    el: '#app',
    // 绑定数据
    data: {
       msg: 'hello msg',
       num: 0,
       total: 0
    },
    // 定义监听器
    watch: {
        msg(newValue, oldValue) {
            console.log(this, arguments);
        },
        // 监听num的变化
        num(newValue) {
            // 最简单的方式就是直接改变total的值 但是无法动态改变
            // this.total = this.num;

            // 在之前要不断清楚开启的定时器
            clearInterval(timer);

            // 开启定时器
            timer = setInterval(() => {
                // 判断num和total的值是否相等
                    // 注意: 当改变了数据之后 类型就是string 所以要使用==等号族做判断
                if (this.total == this.num) {
                    return clearInterval(timer);
                }

                // 改变数据
                this.total += this.num > this.total ? 1 : -1;
            }, 50);
        }
    }
})
```



### 1.6 DOM 事件

事件绑定：vue为了绑定DOM事件，提供了v-on指令。

​		 语法：v-on:click=”fn()”

v-on指令的语法糖是@

​		 也可以写成 @click=”fn()”

​			fn代表事件回调函数，定义在vue实例的methods属性中。

​				 methods中定义的方法跟data中的定义的数据一样，添加实例化对象自身了。

​						 methods中定义的方法，内部的this指向vue实例化对象。

​				 methods中定义的方法不仅仅可以在事件中使用，所有可以获取实例化对象的地方，都可以通过实例化对象来使用该方法。

**参数集合**

​	()表示参数集合，可有可无。

​			 如果没有定义参数集合，

​					 默认有一个参数，就是事件对象

​			 如果添加了参数集合，

​					 默认没有参数，此时使用什么数据可以在参数集合中传递。

​					 想使用事件对象，要传递$event。

vue中事件绑定技术，没有使用事件委托技术，是直接绑定给元素的。

​		 因此事件对象是源生的事件对象。

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
    <!-- 定义视图容器 -->
    <div id="app">
        <h1>app part</h1>
        <hr>

        <!-- 定义按钮 -->
        <!-- 绑定事件通过 v-on指令绑定   没有传递参数集合默认有一个源生的事件对象  -->
        <button v-on:click="clickBtn">点我执行---没有参数集合</button>
        <!-- 如果传递了参数集合 默认是没有参数的 -->
        <button v-on:click="clickBtn(100, true, 'abc', $event)">点我执行---有参数集合</button>
        <!-- v-on指令提供了语法糖 @ -->
        <button @click="clickBtn2">clickBtn2</button>


    </div>
    <!-- 引入发布的文件 -->
    <script src="./dist/03.js"></script>
</body>
</html>
```



### 1.7 事件修饰符

我们使用jQuery的时候，想判断事件绑定的元素与事件触发的元素是同一个元素的功能，要获取事件对象，再通过判断事件对象的e.target是否等于

e.currentTarget，来确定结果，很麻烦。

​		 vue简化了这些流程，让我们在绑定事件的时候就实现这些功能。通过事件修饰符实现。

​		 语法： v-on:click.修饰符=”fn”

​				 “.修饰符”就表示事件修饰符，我们可以通过多个“.”来同时应用多个修饰符。

**通用修饰符**

​		 stop：实现阻止冒泡的修饰符。 

​		 prevent：实现阻止默认行为的修饰符。

​		 once：表示单次触发的修饰符。 

​		 self：表示绑定事件的元素与触发事件的元素是同一个元素。

​		 这些修饰符还可以混合使用。

**鼠标键修饰符**

​		 left：点击鼠标左键

​		 right：点击鼠标右键

​		 middle：点击鼠标中间件

**辅助键修饰符**

​		 ctrl：点击ctrl辅助键

​		 shift：点击shift辅助键

​		 alt：点击alt辅助键

​		 meta：点击window|command辅助键

**键盘事件修饰符**

​		键盘事件：keydown，keyup，keypress（输入有效键）

​		 当我们绑定键盘事件的时候，可以使用键盘事件修饰符。

​		 有效修饰符：esc， tab， space， enter， delete（delete|backspace），up, down, left, right, 以及所有字母键。

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
    <!-- 定义视图容器 -->
    <div id="app">
        <div class="parent" @click.self="parentClick">
        <!-- <div class="parent" @click="parentClick"> -->
            parent

            <!-- 
                通用修饰符
                    stop：实现阻止冒泡的修饰符。		prevent：实现阻止默认行为的修饰符。
                    once：表示单次触发的修饰符。		self：表示绑定事件的元素与触发事件的元素是同一个元素。
             -->
            <button @click="childClick">btn-1</button>
            <button @click.stop="childClick">阻止冒泡</button>
            <hr>

            <a href="https://www.baidu.com" @click="childClick">跳转页面</a>
            <a href="https://www.baidu.com" @click.prevent="childClick">阻止跳转页面</a>
            <!-- 修饰符可以混合使用 -->
            <a href="https://www.baidu.com" @click.prevent.stop="childClick">阻止默认行为和阻止冒泡</a>
            <hr>

            <!-- 单次触发 -->
            <button @click="childClick">多次触发</button>
            <button @click.once="childClick">单次触发</button>
            <!-- 当单次触发之后 该事件又是作为普通的事件执行了 -->
            <button @click.once.stop="childClick">单次触发和阻止冒泡</button>
            <hr>



            <!-- 
                鼠标键修饰符
                	left：点击鼠标左键				right：点击鼠标右键			middle：点击鼠标中间件
             -->

            <button @click.left="childClick">点击鼠标左键</button>
            <button @click.right="childClick">点击鼠标右键</button>
            <button @click.middle="childClick">点击鼠标中间件</button>
            <hr>


            <!-- 
                辅助键修饰符
                    ctrl：点击ctrl辅助键			shift：点击shift辅助键
                    alt：点击alt辅助键				meta：点击window|command辅助键
             -->
            <button @click.ctrl="childClick">点击ctrl辅助键</button>
            <button @click.shift="childClick">点击shift辅助键</button>
            <button @click.alt="childClick">点击alt辅助键</button>
            <button @click.meta="childClick">点击window|command辅助键</button>

            <hr>


            <!-- 
                键盘事件修饰符（键盘事件：keydown，keyup，keypress（输入有效键））
                    当我们绑定键盘事件的时候，可以使用键盘事件修饰符。
                    有效修饰符：esc， tab， space， enter， delete（delete|backspace），up, down, left, right, 以及所有字母键。
             -->

            <input type="text" @keydown.down="childClick">
            <input type="text" @keyup.up="childClick">
            <input type="text" @keypress.enter="childClick">
            <!-- 以及所有的字母键 -->
            <input type="text" @keypress.a="childClick">


            <hr>
            <hr>
            <hr>
            <hr>
            
            
            
            <!-- lazy修饰符: 可以让用户在按下回车或者是失去焦点的时候实现数据同步 起到了优化的作用 -->
            <!-- <input type="text" v-model="msg"> -->
            <input type="text" v-model.lazy="msg">
            <h1>{{msg}}</h1>

            <hr>
            <!-- <input type="text" v-model="num"> -->
            <!-- number修饰符: 保证获取的数据都是数字 （默认会将数据转为字符串） -->
            <input type="text" v-model.number="num">
            <h1>{{num}}-- {{typeof num}}</h1>
            <hr>


            <!-- trim修饰符: 可以删掉字符左右的多余空格 -->
            <!-- <input type="text" v-model="msg"> -->
            <input type="text" v-model.trim="msg">
            <h1>{{msg}}</h1>

            
        </div>

    </div>
    <!-- 引入发布的文件 -->
    <script src="./dist/04.js"></script>
</body>
</html>
```



### 1.8 类的绑定

在vue中，为元素绑定类有三种方式

​		 :class=”{}”

​				 key   表示一组类的名称（可以包含空格，切割成多个类）

​				 value 表示是否保留这组类

​		 :class=”[]”

​				 每一个成员代表一组类（可以包含空格，切割成多个类）

​		 :class=”str”

​				 类名之间用空格隔开。

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
    <!-- 定义视图容器 -->
    <div id="app">


        <!-- 新浪网小案例 -->

        <!-- :class="{
            choose: cls
        }" -->

        <!-- :class="[cls]" -->
        <div 
            class="sina"
            :class="cls"
            @mouseenter="showSina"
            @mouseleave="hideSina"
        >
            <span>博客</span>
            <ul>
                <li>微博评论</li>
                <li>未读提醒</li>
            </ul>
        </div>
        


        <!-- 1 对象的形式  -->
        <!-- <h1 :class="{
            red: true,
            // 如果横线分割的央视名称要使用引号包围
           'fz-30': true
        }">hello app</h1> -->

        <!-- <h1 :class="classObj">hello app</h1> -->

        <!-- 2 数组的形式 -->
        <!-- <h1 :class="[
            { 'red fz-30': true },
            { 'bg-pink': true } 
        ]">hello app</h1> -->

        <!-- 还可以是字符串的形式 -->
        <!-- <h1 :class="['red', 'bg-pink']">hello app</h1> -->

        <!-- 还可以是变量的形式 -->
        <!-- <h1 :class="classArr">hello app</h1> -->

        <!-- <h1 :class="cls + ' fz-30'">hello app</h1> -->
    </div>
    <!-- 引入发布的文件 -->
    <script src="./dist/07.js"></script>
</body>
</html>
```



### 1.9 样式的绑定

与绑定类一样，绑定样式也有三种方式

​		 :style=”{}” 绑定样式对象

​				 key   表示样式名称，建议使用驼峰式命名

​				 value  表示样式属性值

​		 :style=”[]” 绑定多组样式对象

​				 每一个成员是一个对象，代表一组样式

​				 key   表示样式名称，建议使用驼峰式命名

​				 value  表示样式属性值

​		 :style=”str” 做样式字符串拼接。

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
    <!-- 定义视图容器 -->
    <div id="app">

        <!-- shop -->
        <div class="shop">
            <p>
                <label>颜色:</label>
                <img  :style="{ borderColor: imgs[0] }" src="./img/01.jpg" @click="changeStyle(41)" alt="">
                <img  :style="{ borderColor: imgs[1] }" src="./img/02.jpg" @click="changeStyle(42)" alt="">
                <img  :style="{ borderColor: imgs[2] }" src="./img/03.jpg" @click="changeStyle(43)" alt="">
            </p>
            <p>
                <label>尺码:</label>
                <span :class="spans[0]">41</span>
                <span :class="spans[1]">42</span>
                <span :class="spans[2]">43</span>
            </p>
        </div>        


        <!-- 1 对象的形式  -->
        <!-- <h1 :style="{ 
            color: 'red',
            // 'font-size': '50px',
            //建议使用驼峰式命名
            fontSize: '50px'
        }">hello app</h1> -->

        <!-- 2 数组的形式 -->
        <!-- <h1 :style="[
            { color: 'orange' },
            { backgroundColor: 'pink' }
        ]">hello app</h1> -->

        <!-- 3 字符串拼接 -->
        <!-- <h1 :style="'color: ' + cls ">hello app</h1> -->
    </div>
    <!-- 引入发布的文件 -->
    <script src="./dist/08.js"></script>
</body>
</html>
```



### 1.10 条件模板指令

模板指令就是控制元素创建和删除的指令。

条件模板指令

​		vue模拟了js中的if条件语句，提供了条件模板指令v-if

​				 if条件语句：if () {} else if () {} else {}

​		所以vue也为v-if指令提供了组合指令：v-if，v-else-if， v-else。

​				 v-if指令的属性值是布尔值

​						 true  表示创建这个元素

​						 false  表示删除这个元素

​				 是真正的创建和删除，不是显示和隐藏。





### 1.11 v-show

用来显示或者隐藏元素的指令，属性值是布尔值

​		 true  显示元素

​		 false  隐藏元素

 通过控制样式“display: none”实现的。

与v-if相比，有两点不同

​	  1 原理不同

​			 v-if是真正的创建和删除。 v-show是通过样式实现的显示和隐藏。

​	 2 组合指令

​			 v-if有组合指令（v-else-if，v-else）。v-show没有组合指令

​	由于v-show是通过修改样式实现的，因此性能更高。

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
    <!-- 定义视图容器 -->
    <div id="app">
        <!-- 使用v-if指令 -->
        <h1 v-if="true">hello app</h1>
        <!-- 是真正的创建和删除，不是显示和隐藏。 -->
        <h1 v-if="false">hello app222</h1>

        <!-- 组合指令 -->
        <button @click="n++">点我n++</button>
        <h1 v-if="n === 1">Angular</h1>
        <h1 v-else-if="n === 2">React</h1>
        <h1 v-else-if="n === 3">Vue</h1>
        <h1 v-else>呵呵哒</h1>
        <!-- ------------------------------------ v-show --------------------------------- -->
        
        <!-- 通过样式的改变切换显隐 -->
        <h1 v-show="true">v-show</h1>
        <h1 v-show="false">v-show 222</h1>
        <hr>

        <!-- 没有组合指令 -->
        <!-- <h1 v-show="false">你好</h1>
        <h1 v-else>hello</h1> -->
       
    </div>
    <!-- 引入发布的文件 -->
    <script src="./dist/09.js"></script>
</body>
</html>
```



### 1.12 循环模板指令

vue模拟js中的for in循环语句实现了v-for循环模板指令：

有两种用法：

​		 第一种：v-for=”item in data”

​		 第二种：v-for=”(item, index) in data”

​				 v-for和in都是关键字

​				 data表示循环的数据，可以是数字，对象和数组

​						 如果是数字：item 表示数值（从1计数）。 index 表示索引值（从0计数）

​						 如果是对象：item 表示value（属性值）。 index 表示key（属性名称）

​						 如果是数组：item 表示成员值。 index 表示索引值

使用v-for指令的时候，我们要设置key属性，要求属性值时候唯一的。

​		 我们可以设置成员值item中的唯一属性，如id等

​		 我们还可以设置索引值index。

​				 建议用成员中的唯一属性。

注意：

​		 1 在vue cli中，必须设置key属性

​		 2 循环中的变量item和index只在循环中生效，循环结束后被销毁。

### 1.13 模板元素

当我们想渲染多个兄弟元素的时候，那么我们就要将指令放在父元素上，这样会导致引入其它的元素。

为了避免引入其它的元素，vue建议我们使用模板元素。

​		 在html中定义模板元素有两种语法：

​				 第一种：通过script模板标签定义

​				 第二种：html5提供了tempalte模板元素。

​		 vue建议我们使用template模板元素。

模板元素跟普通的元素一样，可以包含子元素，可以添加属性，可以设置指令等等，但就是不会渲染到页面中，我们将循环指令添加给模板元素，就不会引入其它的元素了。

​		 注意：使用模板元素template，不能设置key属性。

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
    <!-- 定义视图容器 -->
    <div id="app">
        <!-- 使用循环指令 -->
        <ul>
            <!-- 遍历数字 -->
            <!-- <li v-for="item in num">{{item}}</li> -->
            <!-- 查看索引值 -->
            <!-- <li v-for="(item, index) in num">{{item}} -- {{index}}</li> -->

            <!-- 遍历对象 -->
            <!-- <li v-for="(value, key) of size">{{key}} -- {{value}}</li> -->

            <!-- 遍历数组 -->
            <!-- 每一个遍历的数据都要条件key属性  默认没有写就是index -->
            <!-- <li v-for="(item, index) of colors" :key="index">{{item}} -- {{index}}</li> -->
            
            <!-- 希望在每一个li的下面添加一个分割线 -->
            <!-- <li v-for="(item, index) of colors" :key="index">{{item}} -- {{index}}</li>
            <hr> -->

            <!-- 实现斑马线 -->
            <li v-for="(item, index) of colors" :style="{
                backgroundColor: index % 2 ? 'skyblue' : 'pink'

            }" :key="index">{{item}} -- {{index}}</li>
            <hr>
                
            <!-- <div v-for="(item, index) of colors" :key="index">
                <li>{{item}} -- {{index}}</li>
                <hr>
            </div> -->

            <!-- 为了避免引入div 要使用template模板标签 -->
            <template v-for="(item, index) of colors">
                <li>{{item}} -- {{index}}</li>
                <hr>
            </template>
        </ul>
       
    </div>
    <!-- 引入发布的文件 -->
    <script src="./dist/10.js"></script>
</body>
</html>
```







