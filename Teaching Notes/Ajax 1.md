# Ajax与Nodejs第5天

## 一、 jquery中的ajax

### 1.1 发送get请求

​	使用方式：$.get(url, data, callback, dataType)

​		url:		 	本次请求的路径 （可以携带query数据）

​		data:		本次请求携带的数据 可以是字符串 可以是对象

​		callback:	回调函数

​		dataType:	数据类型 默认是字符串 当我们传递json的时候，将数据转为json格式



### 1.2 发送post请求

​	使用方式：$.post(url, data, callback, dataType)

​		url:		 	本次请求的路径 （可以携带query数据）

​		data:		本次请求携带的数据 可以是字符串 可以是对象

​		callback:	回调函数

​		dataType:	数据类型 默认是字符串 当我们传递json的时候，将数据转为json格式

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
    <button onclick="sendGet()">点我发送get请求</button>
    <button onclick="sendPost()">点我发送post请求</button>
    <h1 id="result"></h1>
    <!-- 引入jq -->
    <script src="./js/jquery.js"></script>
    <script>
    // 封装sendGet方法
    function sendGet() {
        // 发送get请求
            // 第一个参数表示请求的接口 (可以携带query数据)
            // 第二个参数表示数据 （可以是对象 还可以是query串）
            // 第三个参数表示回调函数  函数中的第一个参数就是返回数据
        // $.get('/sendGet?title=nihao', { color: 'red', num: 500 }, res => {
        
        // 第二个参数还可以是query字符串
        $.get('/sendGet?title=nihao', 'a=1&b=2', res => {
            console.log(res);
            // 渲染视图
            $('#result')
                .html(res.msg)
                .css('color', res.color)
        })

        // 还可以通过then方法监听
        // $.get('/sendGet?title=nihao', 'a=1&b=2')
        //     .then(res => console.log(111, res))
    }


    // 封装sendPost方法
    function sendPost() {
        // 发送请求
            // 第二个参数表示请求正文数据
            // 最后一个参数可以传递数据类型
        // $.post('/sendPost?msg=hello', { color: 'red'  },  res => {
        //     console.log(111, res);
        // }, 'json')

        // $.post('/sendPost?msg=hello', { color: 'red'  })

        // 第二个参数也可以是字符串
        $.post('/sendPost?msg=hello', 'a=1&b=2')
            .then(res => console.log(111, JSON.parse(res)))
    }



    // 统一方式
    $.ajax({
        // url 本次请求的接口路径
        // url: '/sendGet?title=nihao',
        
        url: '/sendPost?title=nihao',
        // method 本次请求的方式 (默认是get请求)
        // method: 'get',
        method: 'POST',
        // 本次请求携带的数据
        data: { num: 100, msg: 'hello' },
        // 本次请求的数据类型
        dataType: 'json',
        // 成功时候的回调函数
        success(res) {
            console.log(111, res);
        },
        // 失败时候的回调
        error(err) {
            console.log(222, err);
        }
    })
    </script>
</body>
</html>
```



## 二、 转为 JSON 对象

JSON内置对象	中提供了两个方法： parse、stringify （必须严格满足JSON语法）

​	parse: 		用于将json字符串解析为json对象

​	stringify: 		用于将json对象转为json字符串

eval函数可以将字符串作为代码执行

​	使用方式：eval(‘(’ + str +‘)’)

Function内置构造函数可以实现将字符串转为对象

​	传参规则：除了最后一个参数是函数体之外，其它都是形参

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
    <script>
    // 定义json串
    let json = '{ "username": "laowang", "age": 40 }';

    // 将json串转为对象
    // console.log(JSON.parse(json));


    // eval方法 可以实现将json转为对象
        // 注意: 要转为表达式使用
    // console.log(eval( '(' +  json + ')'));


    // 利用Function构造函数
        // 传参规则：除了最后一个参数是函数体之外，其它都是形参
    let result = new Function('return ' + json)();
    console.log(result);
    </script>
</body>
</html>
```



## 三、 转码与解码

在URL中本身是不允许出现中文字符以及特殊字符的，但是有些时候还必须要用到中文字符以及特殊字符，此时就需要对URL进行转码

转码的使用方式：encodeURIComponent(code)

​	code: 要转码的中文字符

​	返回值就是转码之后的字符

解码的使用方式：decodeURIComponent(code)

​	code: 被转码之后的字符

​	返回值解码之后的中文字符

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
    <script>
    // 定义字符串
    let str = '你好 明天';

    // 转码
    let result = encodeURIComponent(str);

    // 解码
    console.log(decodeURIComponent(result));

    // 注意：多次转码后，要多次解码。
    </script>
</body>
</html>
```



## 四、 表单序列化

我们都知道但我们填写完表单数据的时候，点击提交按钮之后，会进行页面跳转，如果填写正确还好，但是一旦填写失败，就不得不重新书写

所以，我们使用ajax发送请求, 但我们填写完表单数据的时候，点击提交按钮之后，我们可以自定义要跳转的页面，如果失败，也只是停留在当前页面中

但是使用ajax发送表单数据也是有缺点，如果表单中的数据结构比较复杂，这样的话，我们书写起来比较麻烦，需要手工去拼写所有的数据，并且与页面结构是强耦合，所以我们要使用表单序列化

jquery中的表单序列化

​	使用方式：$(form).serialize()

​	该方法获取指定的form表单中的所有数据

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
    <form action="">
        <p>
            <label for="">用户名:</label>
            <input type="text" name="username" id="username">
        </p>
        <p>
            <label for="">密&emsp;码:</label>
            <input type="password" name="password" id="password">
        </p>
        <p>
            <label for="">兴趣:</label>
            <input type="checkbox" name="intrest" value="chouyan">抽烟
            <input type="checkbox" name="intrest" value="hejiu">喝酒
            <input type="checkbox" name="intrest" value="tangtou">烫头
        </p>
        <button type="button" onclick="receiveData()">提交</button>
    </form>
    <!-- 引入jq -->
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
    <script>

    // 定义serialize方法
    function serialize() {
        // 定义数据对象
        let obj = {
            username: $('#username').val(),
            password: $('#password').val(),   
            intrest: []  
        }

        // 选中的元素做一个遍历
        $('input[type="checkbox"]:checked').each((index, item) => {
            // console.log(111, args);
            obj.intrest.push(item);
        })

        // 定义str
        let str = '';
        // 遍历obj拼接所有的数据
        for (let key in obj) {
            if (Array.isArray(obj[key])) {
                // 遍历数组
                obj[key].forEach(item => {
                    str += `&${item.name}=${item.value}`
                })
            } else {
                str += `&${key}=${obj[key]}`
            }
        }

        // console.log(str);

        // 返回并处理
        return str.slice(1);
    }

    // 定义方法
    function receiveData() {
        // 自己实现的表单序列化
        console.log(serialize());

        // jq中的表单序列化
        console.log($('form').serialize());
    }
    </script>
</body>
</html>
```

## 五、渲染模板的方式

### 	5.1 其它方式

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
    <!-- <div class="container">
        <p>
            <span>名称: xxx</span>
            <span>地址: xxx</span>
        </p>
    </div> -->

    <h1 id="result"></h1>
    <button onclick="getData()">点我发送请求</button>
    <!-- 引入jq -->
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
    <script>
    // 定义方法
    async function getData() {
        // 发送请求获取数据
            // 解构并重命名
        let { school: res } = await new Promise(resolve =>  $.get('/data/demo.json', res => resolve(res) ));

        //  渲染模板的方式1:  创建元素 互相组合 

        // // 定义结果变量
        // let str = '';
        // // 渲染模板的方式2 :  字符串拼接
        // for (let key in res) {
        //     str += '<p><span>'+ key +':</span><span>'+ res[key] +'</span></p>'
        // } 
        // // 渲染上树
        // document.getElementById('result').innerHTML = str;




        // 渲染模板的方式3:   多行字符串 使结构更清晰
        // 定义结果变量
        // let str = '';
        // for (let key in res) {
        //     str += `
        //         <p>
        //             <span>${key}:</span>    
        //             <span>${res[key]}</span>    
        //         </p>
        //     `
        // } 
        // // 渲染上树
        // document.getElementById('result').innerHTML = str;


        // 渲染模板的方式4 :  模板渲染

    }
    </script>
</body>
</html>
```



### 5.2 模板渲染引擎

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
    <!-- <div class="container">
        <p>
            <span>名称: xxx</span>
            <span>地址: xxx</span>
        </p>
    </div> -->


    <!-- 定义模板的方式有两种:  -->

    <!-- 1 通过script标签的形式 -->
        <!-- 在内部的{{}}是自定义的内容 就是为了替换里面的变量 -->
    <!-- <script type="text/template" id="tpl">
        <div class="container">
            <p>
                <span>名称: {{name}}</span>
                <span>地址: {{address}}</span>
            </p>
        </div>
    </script> -->


    <!-- 2 通过template标签的形式 -->
    <template id="tpl">
        <div class="container">
            <p>
                <span>名称: {{name}}</span>
            </p>
            <p>
                <span>地址: {{address}}</span>
            </p>
        </div>
    </template>


    <!-- <template id="tpl">
        <div class="container">
            <p>
                <span>名称: {{school.data.name}}</span>
            </p>
            <p>
                <span>地址: {{school.data.address}}</span>
            </p>
        </div>
    </template> -->

    <h1 id="result"></h1>
    <button onclick="getData()">点我发送请求</button>
    <!-- 引入jq -->
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
    <script>
    // 获取模板内容
    let tpl = document.getElementById('tpl').innerHTML;
    console.log(tpl);

    // 定义方法
    async function getData() {
        // 发送请求获取数据
            // 解构并重命名
        let { school: res } = await new Promise(resolve =>  $.get('/data/demo.json', res => resolve(res) ));

        // 渲染模板的方式4 :  模板渲染
        // 替换模板内容
        let html = tpl.replace(/{{(\w+)}}/g, (match, $1) => {
            return res[$1];
        })

        // 渲染上树
        document.getElementById('result').innerHTML = html;
    }
    </script>
</body>
</html>
```

