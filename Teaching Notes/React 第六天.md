# React 第六天

## 一、React

### 1.1 高阶组件

在React中，为了保证组件基类的完整性，我们对组件拓展功能的时候，React是不予许我们修改组件基类的。例如：使用axios，直接使用，不能安装。

如果对组件拓展功能，React提供了高阶组件的技术：类似装饰者模式，不用直接修改原来的组件，而是定义一个新组件，对原来组件做包装。

​	 使用高阶组件技术，需要定义一个高阶函数（方法）

​			 参数是原组件，以及给高阶组件传递的数据。在函数中，我们创建一个新组件，

​					 在render方法中，我们渲染原来的组件并传递相应的属性数据

​				 	我们对新组件进行包装（拓展），以此来实现对原来组件的拓展（没有被修改）。

​			 返回新组件，使用的时候，使用的是新组件

高阶组件技术中，返回的新组件被称之为高阶组件，这个方法被称之为高阶函数（方法）

注意：在高阶函数中，绝对不能直接对原来的组件进行拓展（修改）。

高阶组件跟混合很相似，它们的区别是： 

​		 混合是对原组件的继承，因此可以访问原组件的属性和方法，所以就有机会覆盖或者修改它们

​				 是为了复用原组件的属性和方法

​		 高阶组件是对原组件的包装，因此访问不到原组件的属性和方法，这样就无法修改它们了，起到了保护的作用，建议使用

​				 是为了对组件拓展，但是又不影响原来组件的使用。

```jsx
// 引入核心库
import React, { Component } from 'react';

// 渲染库
import { render } from 'react-dom';


// 定义组件类
class App extends Component {
    // 定义构造函数
    constructor(props) {
        super(props);
        this.state = {
            msg: ''
        }
    }
    
    render() {
        return (
            <div>
                <input type="text" value={this.state.msg} onChange={ e => this.setState({ msg: e.target.value }) } />
                <hr />
                <Demo msg={this.state.msg}></Demo>
                <Demo msg={this.state.msg}></Demo>
                {/* 希望以下的Demo在使用数据的时候 不要影响其它组件 */}
                {/* <Demo msg={this.state.msg}></Demo> */}
                <DealDemo msg={this.state.msg} title="nihao"></DealDemo>
            </div>
        );
    }
}

// 定义组件
class Demo extends Component {
    // 存在期第一个阶段方法
    componentWillReceiveProps(props) {
        console.log('demo', props);
    }
    render() {
        return (
            <div>
                <h1>hello demo -- {this.props.msg}</h1>
            </div>
        );
    }
}

// 所谓高阶组件（函数） 就是一个方法
// function deal(Demo) {
//     // 对原来的组件拓展 （仍然影响了其它组件）
//     Demo.prototype.componentWillReceiveProps = function() {
//         console.log('demo', arguments);
//     }

//     // 返回原组件
//     return Demo;
// }


// 重写高阶方法
function deal(Demo) {
    // 定义包装类
    class Pack extends Component {
        componentWillReceiveProps(props) {
            console.log('Pack', props);
        }


        // 执行渲染方法
        render() {
            // console.log(333, this.props);
            return <Demo {...this.props}></Demo>
        }
    }

    // 返回包装类
    return Pack;
}

// 使用高阶方法
let DealDemo = deal(Demo);


// 使用混合
// class DealDemo extends Demo {
//     componentWillReceiveProps(props) {
//         console.log('Pack', props);
//     }
// }



// 渲染
render(<App></App>, app);
```



### 1.2 ref 转发

ref转发就是让我们在组件的外部访问组件内部的元素。

我们使用ref有两种方式

​	 第一种 使用ref字符串。

​			 在组件内部通过this.refs获取对应的元素（组件内部获取）

​	 第二种 通过createRef创建ref对象

​			 通过ref对象的current属性获取对应的元素（允许在组件外部获取）

注： ref属性既可以添加给虚拟DOM，也可以添加给组件。

### 1.3 使用 ref

ref既可以指向虚拟DOM，也可以指向组件，但是只能指向一个，不成重复指向

​	 如果ref指向虚拟DOM，此时获取的将是真实DOM元素。

​	 如果ref指向组件，此时获取的将是组件实例化对象。

此时ref属性对组件就有了意义（不仅仅是传递数据）。因此ref属性可以看成是组件的非元素属性，与之类似的还有key属性。使用ref转发技术，分成三步

​	 第一步 通过createRef方法创建一个ref对象

​	 第二步 将ref对象传递给组件。

​			 注，传递的时候不要用ref属性传递ref对象，可以是任何其它的属性，如 icktRef。

​	 第三步 在组件中，将ref对象指向内部的虚拟DOM。这样我们就可以在组件外部，通过ref对象，获取组件内部的元素了。 注：ref对象只能指向类组件，不能指

向函数组件。

### 1.4 forwardRef

取消ref对象对组件（包括函数组件也包括类组件）的指向。

​	 是一个方法，参数是回调函数

​			 第一个参数表示属性对象

​			 第二个参数表示被取消指向的ref对象

​			 返回值表示渲染的组件

forwardRef在高阶组件中有很多应用。

```jsx
// 引入核心库
import React, { Component, createRef, forwardRef } from 'react';

// 渲染库
import { render } from 'react-dom';


// 定义组件类
class App extends Component {
    // 定义构造函数
    constructor(props) {
        super(props);
        this.state = {
            msg: ''
        }

        // 定义ref对象
        this.element = createRef();
    }

    // 组件构建完成
    componentDidMount() {
        console.log(this.element);
        this.element.current.style.color = 'orange';
    }

    
    render() {
        return (
            <div>
                <input type="text" value={this.state.msg} onChange={ e => this.setState({ msg: e.target.value }) } />
                <hr />
                <DealDemo ref={this.element} msg={this.state.msg}></DealDemo>
            </div>
        );
    }
}

// 定义组件
class Demo extends Component {
    render() {
        console.log('demo', this.props);
        return (
            <div>
                <h1 ref={this.props.aref}>hello demo -- {this.props.msg}</h1>
            </div>
        );
    }
}

// 重写高阶方法
function deal(Demo) {
    // 定义包装类
    class Pack extends Component {
        componentWillReceiveProps(props) {
            console.log('Pack', props);
        }


        // 执行渲染方法
        render() {
            // console.log(333, this.props);
            return <Demo {...this.props}></Demo>
        }
    }

    // 返回包装类
    // return Pack;
    // 取消对pack的指向
    return forwardRef((props, ref) => <Pack {...props} aref={ref}></Pack>)
}

// 使用高阶方法
let DealDemo = deal(Demo);




// 渲染
render(<App></App>, app);
```



### 1.5 hook

hook是React新版本中提供一项技术，用来为函数组件拓展功能的。

函数组件是一个十分简单的组件，是对类组件的简化，因此没有继承组件基类，不具有组件的行为。例如：状态数据，生命周期等等。所以为了让函数组件具有这

些行为，我们可以用hook方法对函数组件做拓展。

**使用状态数据** 

​	语法： let [ 数据，修改数据的方法 ] = useState(默认数据值);

​			 “修改数据的方法”的参数就是新的状态数据。

​			 在函数组件中，用“修改数据的方法”去修改“数据”，此时函数组件将进入存在期，更新虚拟DOM。

**使用生命周期方法** 

​	语法: useEffect(fn)

​			 fn代表componentDidMount以及componentDidUpdate方法。

 ... hook为函数组件拓展了大量的功能。

```jsx
// 引入核心库
import React, { Component, useState, useEffect } from 'react';

// 渲染库
import { render, unmountComponentAtNode } from 'react-dom';


// 定义组件类
class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            num: 100
        }
    }

    // 组件构建完毕之后
    componentDidMount() {
        this.timer = setInterval(() => {
            this.setState({ num: this.state.num + 1 });
        }, 1000);
    }

    // 即将销毁的时候 关闭定时器
    componentWillUnmount() {
        clearInterval(this.timer);
    }

    unMount() {
        unmountComponentAtNode(app);
    }
    

    render() {
        return (
            <div>
                <h1>hello app -- {this.state.num}</h1>
                <button onClick={ e => this.unMount() }>点我卸载</button>
                <hr />
            </div>
        );
    }
}

// // 函数组件
// let Demo = props => {
//     // 定义状态
//         // count 表示初始值
//         // setCount 修改初始值的方法 （类似于setState）
//     let [ count, setCount ] = useState(0);
//     let [ name, setName ] = useState('tom');

//     function changeCount() {
//         // 修改数据
//         // setCount(count + 1);

//         // 还可以是函数的形式
//         setCount(count => count + 1);
//     }

//     return (
//         <div>
//             <h1>hello demo -- {count} -- {name}</h1>
//             <hr />
//             <button onClick={ e => changeCount() }>点我count++ </button>
//             <button onClick={ e => setName('jerry') }>点我改变名字</button>
//         </div>
//     )
// }



// 使用函数组件实现类组件中的功能:
let Demo = props => {
    // 定义状态
        // count 表示初始值
        // setCount 修改初始值的方法 （类似于setState）
    let [ count, setCount ] = useState(0);
    let [ name, setName ] = useState('tom');

    function changeCount() {
        // 修改数据
        // setCount(count + 1);

        // 还可以是函数的形式
        setCount(count => count + 1);
    }

    // 使用useEffect
        // 此时回调函数 分别代替了 componentDidMount 和 componentDidUpdate
    // useEffect((...args) => {
    //     // console.log('useEffect', args);
    //     setInterval(() => {
    //         setCount(count => count + 1);
    //     }, 1000);
    // })


    // 可以接收第二个参数: 
        // 如果是空数组 任何数据都不监听   
        // 如果没有传递第二个参数 可以监听任何数据的变化
        // 中括号 还可以指定监听某一个数据 [count] || [count, name]
    useEffect((...args) => {
        // console.log('useEffect');
        let timer = setInterval(() => {
            // 这种方式 是基于当次的值的基础之上做改变
            setCount(count => count + 1);

            // 在挂载之前锁死了 无法改变了
            // setCount(count + 1);
        }, 1000);

        // 返回值 是一个函数
            // 在组件销毁之前执行 代替了componentWillUnMount
        return function() {
            // console.log('willUnmount');
            clearInterval(timer);
        }
    }, [])

    return (
        <div>
            <h1>hello demo -- {count} -- {name}</h1>
            <hr />
            <button onClick={ e => changeCount() }>点我count++ </button>
            <button onClick={ e => setName('jerry') }>点我改变名字</button>
            <button onClick={ e => unmountComponentAtNode(app2) }>点我卸载</button>
        </div>
    )
}




// 渲染
render(<App></App>, app);
render(<Demo></Demo>, app2);
```



## 二、服务器端渲染

### 2.1 服务器端渲染

前端渲染的问题：

​	 1 白屏时间长，影响用户体验

​	 2 不利于SEO优化

​	 ... ...

所以我们要使用服务器端渲染，来解决这些问题。

React实现了多端适配，为不同的端提供了不同的渲染库，React核心库只负责创建虚拟DOM和组件。

​	 在web端渲染，使用react-dom渲染库

​	 在服务器端渲染，使用react-dom/server.js渲染库

### 2.2 服务器端渲染库

react-dom/server.js提供了在服务器端渲染的方法

​		 renderToString 将应用程序渲染成模板字符串

​		 renderToStaticMarkup 将应用程序渲染成模板字符串，并且会删除不必要的属性

​				 例如：data-reactroot等属性

​				 该方法减少了文件大小，因此常常用在渲染静态页中。

服务器端渲染的问题是：无法绑定交互。

###  2.3 渲染优化

在渲染过程中，renderToString以及renderToStaticMarkup方法会将整个应用程序渲染出来，再返回到页面中。如果应用程序非常复杂，假设需要渲染1000ms，那么用户就要等到1000ms之后，才能看到页面。

React为了提高渲染的性能，让用户可以更快速的看到页面，提供了与浏览器渲染页面相似的功能。

​	 浏览器渲染页面优化：每加载8kb渲染一次。

​	 React也是这样的，允许我们渲染一部分组件就返回一些数据。

​			 例如，第一次渲染用了10ms，并返回到浏览器端，这样用户就可以提前990ms看到内容。

### 2.4 渲染优化方法

服务器端渲染库提供了两个方法：

​	 renderToNodeStream 将应用程序渲染成字符串

​	 renderToStaticNodeStream  将应用程序渲染成模板字符串，并且会删除不必要的属性

所以这两个方法的区别与renderToString以及renderToStaticMarkup方法是一样的。

这两个方法都返回一个Strea流，提供了pipe方法

​		 第一个参数表示res对象 

​		第二个参数表示传递的配置对象

​				 end: false  渲染完成不执行end方法，我们可以继续写入。

提供了on方法，用来监听事件

​		 data事件：表示每次渲染完成执行的方法。 

​		 end事件：表示已经渲染完成

```js
// 引入express
const express = require('express');
// 引入React
const React = require('react');

// 引入服务器端的渲染库
const { renderToNodeStream, renderToStaticNodeStream } = require('react-dom/server.js');

// 获取应用程序
const app = express();

// 更新渲染引擎
app.engine('html', require('ejs').__express);


// 定义组件
class App extends React.Component {
    // 定义状态
    constructor(props) {
        super(props);
        this.state = {
            num: 10
        }
    }

    // 定义方法
    addNum() {
        this.setstate({ num: this.state.num + 1 })
    }

    // 使用js语法
    render() {
        return React.createElement('div',
            null,
            React.createElement('h1', null, 'app part'),
            React.createElement('button', { 
                style: { fontSize: 23  },
                onClick: e => this.addNum(e)
            }, 
                '点我改变num:',
                this.state.num 
            )
        )
    }
}



// 渲染一个页面
app.get('/', (req, res) => {
    // res.render('index.html', {
    //     title: '服务器端渲染',
    //     seo: '<meta name="keywords" content="北京、前端、IT、爱创 />',
    //     content: renderToString(React.createElement(App))
    // });

    // 定义数据对象
    let data = {
        title: '服务器端渲染',
        seo: '<meta name="keywords" content="北京、前端、IT、爱创 />',
        // content: renderToString(React.createElement(App))
    }

    // 使用js语法
    res.write(`<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        ${data.seo}
        <title>`)
    res.write(data.title)
    res.write(`</title>
    </head>
    <body>
        <div id="app">`)

    // 开始渲染
    let stream = renderToStaticNodeStream(React.createElement(App));

    // 监听pipe方法
        // 注意: pipe方法的执行天生调用end方法断开连接
    stream.pipe(res, {
        // 渲染完成不执行end方法，我们可以继续写入。
        end: false 	
    })

    // data事件：表示每次渲染完成执行的方法
    stream.on('data', () => console.log('正在渲染内容'));

    // 监听data
    stream.on('end', () => {
        console.log('渲染完成了');
        res.write(`</div>
        </body>
        </html>`);
        res.end();
    })

  
})

// 监听端口
app.listen(3000, () => console.log(3000));
```



### 2.5 前后端同步渲染

前端渲染的问题：

​	 1 白屏时间长，

​	 2 无法做SEO优化

​	  ... ...

服务器端渲染的问题：

​	  无法绑定交互 ...

为了解决上述问题，我们要前后端同步渲染。

### 2.6 webpack 配置

开发的应用程序使用的是ES Module规范，我们要分别为前后端发布应用程序。

服务器端渲染不同点：

​	 1 是给node环境使用的。

​	 2 node中不需要编译模板，不需要处理样式，不需要压缩，打包等等

​	 3 将ES Module规范编译成CommonJS规范

​	 4 将default接口暴露出来

​	 5 入口文件不同，

​		 浏览器端：渲染应用程序

​		 服务器端：返回应用程序

### 2.7 hydrate

使用前后端渲染的技术，服务器端已经将页面渲染完成了，前端只需要添加交互就可以了，

所以第一次创建页面的时候，不需要渲染虚拟DOM，因此React渲染库提供了hydrate方法。

该方法会判断页面是否被服务器端渲染过，如果渲染过，将直接绑定交互，第一次创建不会渲染虚拟DOM。

​	 该方法的用法与render是一样的。

注意：使用前后端渲染的技术，一定要保证前后端给组件传递的属性是一致的。

使用hydrate方法的时候，不要使用带有static名字的渲染方法，否则会将服务器端渲染的标志删除，而无法优化。

```jsx
import React from "react";
import { render, hydrate } from 'react-dom';
import App from "./App";
import './base.less';

// render(<App color="green"></App>, document.getElementById('app'))
// hydrate用法与render一样，区别是：hydrate是专门为前端后端同步渲染设计的，语义化更强，优化
hydrate(<App color="green"></App>, document.getElementById('app'))
```

