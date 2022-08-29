# React 第三天

## 一、React

### 1.1 换肤

发送请求使用axios，不需要安装，直接使用。

- axios的使用方式与jquery类似，提供了一些简便方法：

  ​	 get(url, config) 发送get请求

   			url表示请求地址，config表示配置项（我们可以定义params，headers等）

  ​	 post(url, data, config)  发送post请求

  ​			 url表示请求地址，data：表示携带的数据，config：表示配置项（我们可以定义params，headers等）

  ​	注意：不论是get请求还是post请求，都可以携带query数据，query数据可以在两个位置添加

  ​		 1 在url上添加query数据。

   		2 在config配置中的params属性中传递。



- axios实现了promise规范，因此，通过then方法监听结果

   第一个参数表示成功时候的回调函数:参数表示请求对象，其中data属性表示返回的数据

  ​	 当多次使用then方法的时候，前一个then方法的返回值，将作为后一个then方法的参数。

   第二个参数表示失败时候的回调函数，也可以通过catch方法监听失败

  

  axios提交的数据，默认使用的是json格式。

   我们可以通过修改headers中的Content-Type字段，来模拟表单提交。

   模拟表单： application/x-www-form-urlencoded

![](./images/16.png)







```jsx
// 导入核心库
import React, { Component } from 'react';
// 导入渲染库
import { render } from 'react-dom';

// 引入axios
import axios from 'axios';

// react不建议安装axios 这样会污染所有的实例 
// Component.prototype.axios = axios;

// 导入样式文件
import './skin.less';


// 定义组件类
class Skin extends Component {

    // 定义构造函数
    constructor(props) {
        super(props);
        this.state = {
            data: []
        }
    }
    

    // 获取数据的方法
    async getData() {
        let { data } = await axios.get('/data/skin.json');
        // console.log(data);
        // 存储数据
        this.setState({ data });
    }

    // 组件创建完成之后执行一些方法
    componentDidMount() {
        this.getData();
    }

    // 改变图片的方法
    changeImage(id, e) {
        // console.log(e.target, 222, e.currentTarget);

        // 获取对应的id
        // console.log(e.currentTarget.getAttribute('data-id'));

        // console.log(id);

        // 设置body背景图片
        document.body.style.backgroundImage = `url(./img/skin/big_${id}.jpg)`;

    }

    // 创建列表
    createList() {
        // 遍历数组
        return this.state.data.map(item => {
            return (
                // 自定义数据的方式
                <li key={item.id} data-id={item.id} onClick={ e => this.changeImage(item.id, e)}> 
                    <img src={'./img/skin/' + item.src} alt="" />
                    <p className="title">{item.title}</p>
                </li>
            )
        })
    }

    render() {
        return (
            <div className="skin">
                {/* 创建一个列表 */}
                <ul>{this.createList()}</ul>
            </div>
        );
    }
}

// 渲染
render(<Skin />, app);
```



### 1.2 上下文数据-context

组件之间可以通信，但是如果组件之间的嵌套层级很深，此时通信成本很高。所以react就提供了一个上下文数据对象：Context。

​	 工作中一些全局的配置数据可以放在上下文数据对象中，例如：网站的主题配置，语言包配置

使用数据：使用上下文数据分成两步

​	 第一步 创建上下文数据对象，核心库react提供了createContext方法，可以创建上下文数据对象

​			 参数对象就是默认的数据，创建的结果：提供了两个组件：Provider和Consumer

​	 第二步 让组件获取上下文数据对象中的数据。

​			 类组件：通过静态属性contextType来接收，属性值就是上下文数据对象。

​					 组件中，通过this.context属性获取上下文数据。

​			 函数组件：通过Consumer传递，内容是一个方法，参数是上下文数据，返回值就是创建的虚拟DOM

### 1.3 修改上下文数据

上下文数据对象提供了Provider组件，可以修改上下文中的数据，

​	 通过value属性修改。

注意：Provider组件修改数据后：

​	 Provider组件的子组件将接收新的数据

​	 Provider组件的父组件以及兄弟组件不受影响。

当多次使用Provider组件的时候，子组件会根据就近原则，从最近的Provider组件中获取数据。

```jsx
// 导入核心库
import React, { Component, createContext } from 'react';
// 导入渲染库
import { render } from 'react-dom';

// 创建上下文数据
let DataContext = createContext({
    // 主题
    theme: 'red',
    // 语言包
    lang: '中文'
    
})

// 解构方法
let { Provider, Consumer } = DataContext;

// 定义组件类
class App extends Component {
    render() {
        // console.log('app', this, this.context);
        // 解构
        let { theme, lang } = this.context;
        return (
            <div>
                <h1 style={{ color: theme }}>app part--{lang}</h1>
                <hr />
                <Provider value={{ theme: 'green', lang: '韩语' }}>
                    <Demo></Demo>
                </Provider>
                <hr />
                <Other></Other>
            </div>
        );
    }
}

// 为App添加上下文数据
    // 通过静态属性contextType来接收，属性值就是上下文数据对象。
App.contextType = DataContext;

// Demo组件
class Demo extends Component {
    render() {
        // console.log('Demo', this, this.context);
        // 解构
        let { theme, lang } = this.context;
        return (
            <div>
                <h1 style={{ color: theme }}>Demo part -- {lang}</h1>
                <hr />
                {/* 子组件 */}
                <Child></Child>
            </div>
        );
    }
}

// 添加上下问数据
Demo.contextType = DataContext;

class Child extends Component {
    render() {
        // console.log('Child', this, this.context);
        // 解构
        let { theme, lang } = this.context;
        return (
            <div>
                <h1 style={{ color: theme }}>Child part -- {lang}</h1>
            </div>
        );
    }
}
// 添加上下问数据
Child.contextType = DataContext;



// 函数组件
// let Other = props => {
//     console.log(props);
//     return (
//         <div>
//             <h1>other part</h1>
//         </div>
//     )
// }


// 添加上下问数据 (不支持)
// Other.contextType = DataContext;


// 利用Consumer接收数据
let Other = props => {
    return <Consumer>{({ theme, lang }) => {
        // console.log(222, args);
        return (
            <div>
                <h1 style={{ color: theme }}>other part -- {lang}</h1>
            </div>
        )
    }}</Consumer>
}




// 渲染
render(
    <DataContext.Provider value={{ theme: 'orange', lang: '英文' }}>
        <App />
    </DataContext.Provider>    
, app);
```



### 1.4 生命周期

为了描述组件创建，存在，销毁的过程，react也为组件提供了生命周期技术。

​	 共分三大周期：

​			 创建期，

​			 存在期，

​			 销毁期。

### 1.5 创建期

创建期共分五个阶段，描述组件创建的过程。

​	 在ES5开发中：getDefaultProps, getInitialState, componentWillMount, render, componentDidMount

​	 在ES6开发中，创建期的前两个阶段方法有所改变。

（ 1 ）定义组件默认属性数据： defaultProps静态属性

​		此时组件尚未创建。属性值就是默认的属性数据。

​		 没有为组件传递属性数据，组件就会使用该默认属性数据

（ 2 ）构造函数（初始化状态数据）：constructor

​		 构造函数有个参数：属性数据，上下文数据。

​		 构造函数中，要使用super方法实现构造函数式继承。我们要向super方法传递属性数据和上下文数据

​				如果没有传递属性数据和上下文数据：此时参数props与this.props不同，并且参数context与this.context不同

​				如果传递了属性数据和上下文数据：此时参数props与this.props全等，并且参数context与this.context全等。

​		 				所以工作中建议我们传递属性数据和上下文数据。

​				但是由于工作中，上下文数据不会经常使用。所以通常我们只传递属性数据就可以了。在构造函数中，我们为this.state赋值，实现状态数据的初始化。

​		 我们可以用属性数据和上下文数据为状态数据赋值，实现数据由外部流入内部。

​				 这么做的原因是：可以在组件内部维护（修改）属性数据和上下文数据（不会影响其它组件）。

（ 3 ）组件即将构建： componentWillMount

​		此时已经有了属性数据，状态数据和上下文数据，但是还不能获取虚拟DOM。

​		工作中，我们可以在该阶段发送请求，初始化插件等

（ 4 ）渲染输出虚拟DOM： render

​		这个方法主要用来渲染虚拟DOM。返回值就是渲染的虚拟DOM，有且只有一个根元素。

​		注意：render方法主要负责渲染，所以不要在该方法中实现业务逻辑（如发送请求等）。

​	   不要在该方法中，尝试修改数据（如状态数据）。虚拟DOM是在返回值中创建的，因此在render方法中，无法获取虚拟DOM对应的真实DOM。

 （ 5 ）组件构建完毕：componentDidMount

​		此时组件就创建出来了，已经有了属性数据，状态数据，上下文数据以及虚拟DOM。

​		该方法执行完毕，标志着创建期的结束，存在期的开始。我们可以在该方法中，绑定事件（全局），发送请求，使用插件等等。

注：创建期的方法在组件一生中，只能执行一次。后面四个方法中this都指向组件，后三个方法没有参数。

### 1.6 获取元素

渲染库react-dom提供了findDOMNode方法，可以获取虚拟DOM对应的真实DOM元素。

​		获取的是源生DOM，因此要用源生的DOM API去操作。

注意：工作中尽量不要这样去操作虚拟DOM，因为对源生DOM的操作是会被React忽视掉的。

```jsx
// 导入核心库
import React, { Component, createContext } from 'react';
// 导入渲染库
import { render, findDOMNode } from 'react-dom';

// 创建上下文数据
let ColorContext = createContext({
    color: 'green'
})

// 定义组件类
class App extends Component {
    // 2 定义构造函数
    constructor(props, context) {
        // 但是由于工作中，上下文数据不会经常使用。所以通常我们只传递属性数据就可以了
        super(props, context);
        console.log(222, 'constructor', 'props:', props, this.props, props === this.props,  'context:', context, this.context);
    }

    // 3 组件即将构建
    componentWillMount() {
        console.log(333, 'componentWillMount', this.props, this.context, findDOMNode(this));
    } 
    
    // 5 构建完成
    componentDidMount() {
        console.log(555, 'componentDidMount',  this.props, this.context, findDOMNode(this));
    } 

    // 4
    render() {
        // 在return之后 才可以访问虚拟DOM 在此之前无法访问
        // console.log(444, 'render', this.props, this.context, findDOMNode(this));
        console.log(444, 'render', this.props, this.context);
        return (
            <div>
                <h1>hello app</h1>
            </div>
        );
    }
}

// 定义上下文数据
App.contextType = ColorContext;

// 1 
// 定义默认数据
App.defaultProps = {
    msg: 'hello msg'
}

console.log(111, 'defaultProps');

// 除了第一个阶段  后面四个方法中this都指向组件，后三个方法没有参数。


// 渲染
render(<App title="nihao"></App>, app);
```



### 1.7 存在期

存在期跟创建期一样，也分五个阶段，来描述组件数据更新的过程。

​	一旦组件的属性数据，状态数据或者上下文数据改变，组件就会进入存在期。五个阶段：

（ 1 ）组件即将接收新的属性数据： componentWillReceiveProps

​		只有属性数据改变，才会执行该阶段方法，状态数据改变不会执行。

​		第一个参数表示新的属性数据。this上的还是旧的属性数据和旧的状态数据。

​		我们可以用属性数据更新状态，实现外部的数据存储到内部。将外部数据存储到组件内部是该阶段的唯一作用。

​		此时新的属性数据和新的状态数据一同进入第二个阶段方法。

（ 2 ）组件是否应该更新: shouldComponentUpdate

​		第一个参数表示新的属性数据。第二个参数表示新的状态数据。

​		this上的还是旧的属性数据和旧的状态数据。

​		必须有返回值，表示是否更新：

​				true，表示更新、

​				false，表示不更新。

​	  工作中，通常比较属性数据是否改变或者状态数据是否改变来决定是否更新

​	  作用：起到更新优化的作用（如：在高频事件中应用）。

（ 3 ）组件即将更新: componentWillUpdate

​		第一个参数表示新的属性数据。第二个参数表示新的状态数据。

​		this上的还是旧的属性数据和旧的状态数据。数据在该阶段还没有更新，该阶段执行完毕，数据才会更新，我们可以在该阶段调整插件等等。

（ 4 ）组件渲染虚拟DOM: render

​		没有参数，数据已经更新了，与创假期render是同一个方法。

​		this上的已经是新的属性数据和新的状态数据了。

​		所以渲染虚拟DOM的时候，就可以使用这些新的数据了，

（ 5 ）组件更新完毕: componentDidUpdate

​		第一个参数表示旧的属性数据。

​		第二个参数表示旧的状态数据。

​		this上的已经是新的属性数据和新的状态数据了。

​		虚拟DOM也可以更新了，所以在该阶段新数据，旧的数据都可以访问到，

​		我们可以在该阶段，继续请求数据，处理插件，调整事件等等。

​		组件已经更新完毕，只是一次更新结束，存在期仍然继续。

​		注：这些方法中的this都指向组件

```jsx
// 引入核心库
import React, { Component } from 'react';
// 引入渲染库
import { render, findDOMNode} from 'react-dom';

// 定义组件
class App extends Component {

    constructor(props) {
        super(props);
        this.state = {
            isShow2: false
        }
    }

    // 监听页面滚动
    componentDidMount() {
        window.addEventListener('scroll', () => {
            if (scrollY > 300) {
                this.setState({ isShow2: true })
            } else {
                this.setState({ isShow2: false })
            }
        })
    }
    

    render() {
        return (
            <div>
                <h1>app part </h1>
                <hr />
                <GoBack num="100" isShow={this.state.isShow2}></GoBack>
            </div>
        );
    }
}

class GoBack extends Component {

    // 定义状态
    constructor(props) {
        super(props);
        this.state = {
            // isShow: false

            // 实现从外部流向内部
            ishow: props.isShow
        }
    }

    // // 监听页面滚动
    // componentDidMount() {
    //     window.addEventListener('scroll', () => {
    //         if (scrollY > 300) {
    //             this.setState({ isShow: true })
    //         } else {
    //             this.setState({ isShow: false })
    //         }
    //     })
    // }

    // 1 组件即将接收属性数据
    componentWillReceiveProps(props) {
        console.log(111, 'componentWillReceiveProps','props:', props, 'this.props:', this.props );

        // 将外部数据存储到组件内部是该阶段的唯一作用。此时新的属性数据和新的状态数据一同进入第二个阶段方法。
        this.setState({ isShow: props.isShow })
    }

    // 2 组件是否更新  在该阶段可以对操作进行优化
    shouldComponentUpdate(props, state) {
        console.log(222, 'shouldComponentUpdate', 'props:', props, 'this.props:', this.props, 'state:', state, 'this.state:', this.state);

        // return true;

        // 判断属性和状态是否不同
        return props.isShow !== this.props.isShow || state.isShow !== this.state.isShow

    }

    // 3 组件即将更新
    componentWillUpdate(props, state) {
        console.log(333, 'componentWillUpdate', 'props:', props, 'this.props:', this.props, 'state:', state, 'this.state:', this.state, findDOMNode(this).style.display);
    }
    
    // 5 组件更新完毕
    componentDidUpdate(props, state) {
        console.log(555, 'componentDidUpdate', 'props:', props, 'this.props:', this.props, 'state:', state, 'this.state:', this.state, findDOMNode(this).style.display);
    }


    render() {
        // render方法中没有参数的
        console.log(444, 'render',  'this.props:', this.props, 'this.state:', this.state);
        return (
            <div style={{
                position: 'fixed',
                right: 100,
                bottom: 60,
                width: 100,
                height: 100,
                backgroundColor: 'green',
                textAlign: 'center',
                lineHeight: '100px',
                color: '#fff',
                fontSize: 20,
                // 通过状态数据控制元素的显隐
                // display: this.state.isShow ? '' : 'none'
                
                // 通过属性数据控制元素的显隐
                // display: this.props.isShow ? '' : 'none'
                
                // 把属性作为状态 更新元素的显隐
                display: this.state.isShow ? '' : 'none'

            }}>返回顶部</div>
        );
    }
}

// 渲染
render(<App msg="hello msg"></App>, app);


/**
 * 存在期:
 *  
 *  状态数据:
 *      1 不会执行第一个阶段 componentWillReceiveProps方法
 *      2 shouldComponentUpdate和componentWillUpdate 参数是新的 this身上时旧的 说明在这两个阶段数据还没有更新
 *      3 在render阶段就更新了数据
 *      4 componentDidUpdate第五个阶段  参数是旧的 this身上是新的
 * 
 * 
 * 属性数据:
 *      1 从第一个阶段 componentWillReceiveProps方法 开始执行
 *      2 其余的跟状态都的改变都一致
 *      优化:  当属性数据和状态数据一起改变的时候  合并执行了生命周期方法
 * 
 * 
 * 
 * 
 ***/

```



### 1.8 存在期与上下文数据

上下文数据改变组件也会执行存在期，但是有一些不同

 	1 上下文数据不会执行shouldComponentUpdate方法。

​			上下文数据改变，组件更新不能被优化。

​	 2 上下文数据与属性数据一样，都是从外部传递的， 

​			 因此也会执行第一个周期方法： compoenntWillReceiveProps。并且追加一个参数：新的上下文数据

​			 与之类似的方法是第三个周期方法：componentWillUpdate，也会追加一个参数：新的上下文数据

​			 componentDidUpdate方法没有影响。

​	 3 上下文数据与属性数据，状态数据一样，

 			也是在componentWillUpdate方法执行完毕之后，render方法执行之前更新的。

### 1.9 存在期与非更新数据

属性数据，状态数据以及上下文数据改变，组件会更新，

如果希望在组件中，维护的数据改变的时候，组件不更新，定义这类数据，有两种方式：

​	 1 将数据存储在组件的实例上（构造函数定义）

​	 2 将数据存储在组件的原型上（特性方法定义）

​	 这两类数据改变，组件不会更新。

工作中，我们可以将定时器句柄，节流开关等数据放在这里。这样，我们改变数据，组件就不会更新了。

```jsx
// 引入核心库
import React, { Component, createContext } from 'react';
// 引入渲染库
import { render, findDOMNode} from 'react-dom';

// 定义上下文数据
let ColorContext = createContext({
    color: 'green'
})

// 解构数据
let { Provider } = ColorContext;

// 定义组件
class App extends Component {

    constructor(props) {
        super(props);
        this.state = {
            color: 'green'
        }
    }

    // 监听页面滚动
    componentDidMount() {
        window.addEventListener('scroll', () => {
            if (scrollY > 300) {
                this.setState({ color: 'orange' })
            } else {
                this.setState({ color: 'green' })
            }
        })
    }
    

    render() {
        return (
            <div>
                <h1>app part </h1>
                <hr />
                <Provider value={{ color: this.state.color }}>
                    <GoBack></GoBack>
                </Provider>
            </div>
        );
    }
}

class GoBack extends Component {

    // 1 组件即将接收属性数据
    componentWillReceiveProps(props, context) {
        console.log(111, 'componentWillReceiveProps', 'context:', context, 'this.context:', this.context );

        // 将外部数据存储到组件内部是该阶段的唯一作用。此时新的属性数据和新的状态数据一同进入第二个阶段方法。
        this.setState({ isShow: props.isShow })
    }

    // 2 组件是否更新  在该阶段可以对操作进行优化  (上下文改变不会执行二阶段的方法) （意味着组件也无法更新优化了）
    // shouldComponentUpdate(props, state) {
    //     console.log(222, 'shouldComponentUpdate', arguments);

    //     // 判断属性和状态是否不同
    //     return props.isShow !== this.props.isShow || state.isShow !== this.state.isShow

    // }

    // 3 组件即将更新
    componentWillUpdate(props, state, context) {
        console.log(333, 'componentWillUpdate', 'context:', context, 'this.context:', this.context,  findDOMNode(this).style.display);
    }
    
    // 5 组件更新完毕
    componentDidUpdate(props, state) {
        console.log(555, 'componentDidUpdate', arguments,  findDOMNode(this).style.display);
    }


    render() {
        // render方法中没有参数的
        console.log(444, 'render', 'this.context:', this.context);
        return (
            <div style={{
                position: 'fixed',
                right: 100,
                bottom: 60,
                width: 100,
                height: 100,
                textAlign: 'center',
                lineHeight: '100px',
                color: '#fff',
                fontSize: 20,
                // 使用上下文数据改变元素
                backgroundColor: this.context.color

            }}>返回顶部</div>
        );
    }
}

// 设置上下问数据
GoBack.contextType = ColorContext;

// 渲染
render(<App msg="hello msg"></App>, app);


/**
 * 存在期:
 *  
 *  状态数据:
 *      1 不会执行第一个阶段 componentWillReceiveProps方法
 *      2 shouldComponentUpdate和componentWillUpdate 参数是新的 this身上时旧的 说明在这两个阶段数据还没有更新
 *      3 在render阶段就更新了数据
 *      4 componentDidUpdate第五个阶段  参数是旧的 this身上是新的
 * 
 * 
 * 属性数据:
 *      1 从第一个阶段 componentWillReceiveProps方法 开始执行
 *      2 其余的跟状态都的改变都一致
 *      优化:  当属性数据和状态数据一起改变的时候  合并执行了生命周期方法
 * 
 * 
 * 上下文数据:
 *      1 shouldComponentUpdate第二阶段方法不会执行 因此组件也无法更新优化
 *      2 第一个生命周期componentWillReceiveProps 和 第三个阶段componentWillUpdate   追加了一个上下文参数'
 *      3 在render阶段就更新了数据
 *      注意: 由于上下文数据的改变 不会让组件得到优化 所以工作中尽量不要将上下文数据传递给组件
 * 
 ***/

```



### 1.10 销毁期

组件从页面中删除，组件将进入销毁期，执行销毁期的方法：componentWillUnmount

​	 没有参数，this指向组件

这是我们最后一次访问组件了，该方法执行完毕，就再也无法访问组件了

```jsx
// 引入核心库
import React, { Component } from 'react';
// 引入渲染库
import { render, unmountComponentAtNode} from 'react-dom';



// 定义组件
class App extends Component {

    // 组件销毁期的方法
    componentWillUnmount() {
        console.log('组件要销毁了', this, arguments);
    }
 
    render() {
        return (
            <div>
                <h1>app part </h1>
                <hr />
                <GoBack></GoBack>
            </div>
        );
    }
}

// 定义非更新数据:

class GoBack extends Component {
    constructor(props) {
        super(props);
        // 1 定义实例数据
        this.num = 10;

        // 赋值
        this.getNum = 20;
    }
    
    // 2 放在原型中
    set getNum(val) {
        this._num = val;
    }

    get getNum() {
        return this._num;
    }


    // 监听页面滚动
    componentDidMount() {
        window.addEventListener('scroll', () => {
           this.num++;
           this.getNum = this.getNum + 1;

           console.log(this.num, this.getNum);
        })
    }
        

    // 1 组件即将接收属性数据
    componentWillReceiveProps(props, context) {
        console.log(111, 'componentWillReceiveProps',  );
    }

    // 2 组件是否更新  在该阶段可以对操作进行优化  (上下文改变不会执行二阶段的方法) （意味着组件也无法更新优化了）
    shouldComponentUpdate(props, state) {
        console.log(222, 'shouldComponentUpdate');

        // 判断属性和状态是否不同
        return props.isShow !== this.props.isShow || state.isShow !== this.state.isShow

    }

    // 3 组件即将更新
    componentWillUpdate(props, state, context) {
        console.log(333, 'componentWillUpdate',);
    }
    
    // 5 组件更新完毕
    componentDidUpdate(props, state) {
        console.log(555, 'componentDidUpdate');
    }


    render() {
        // render方法中没有参数的
        console.log(444, 'render');
        return (
            <div style={{
                position: 'fixed',
                right: 100,
                bottom: 60,
                width: 100,
                height: 100,
                backgroundColor: 'pink',
                textAlign: 'center',
                lineHeight: '100px',
                color: '#fff',
                fontSize: 20,
            }}>返回顶部</div>
        );
    }
}
// 渲染
render(<App msg="hello msg"></App>, app);


// 卸载APP
setTimeout(() => {
    unmountComponentAtNode(app);
}, 3000);


/**
 * 非更新数据的定义方式：
 *      1 将数据存储在组件的实例上（构造函数定义）
 *      2 将数据存储在组件的原型上（特性方法定义）
 * 
 * 
 * 
 * 创建期: defaultProps  constructor  componentWillMount   render   componentDidMount
 * 存在期: componentWillReceiveProps  shouldComponentUpdate  componentWillUpdate  render  componentDidUpdate
 * 销毁期: componentWillUnMount
 ***/

```



### 1.11 非 React 类库

我们在react中，使用一些非react类库（第三方插件等，不是react家族的插件）的时候，一定要注意组件生命周期。

```jsx
// 引入核心库
import React, { Component } from 'react';
// 引入渲染库
import { render } from 'react-dom';
// 引入库文件
import ImageZoom from '../image-zoom.jsx';

// 使用方法
// new ImageZoom(app2, 'demo.jpg', 200)


// 定义组件
class App extends Component {
    // 在即将构建阶段无法获取真实的元素
    // componentWillMount() {
    // 组件构建完成
    componentDidMount() {
        new ImageZoom(this.refs.contain, 'demo.jpg', 200);
    }

    render() {
        return (
            <div>
                <h1>hello app</h1>
                <hr />
                <div className="container" ref="contain"></div>
            </div>
        );
    }
}

// 渲染
render(<App></App>, app);
```



### 1.12 使用侵入式类库

当我们使用非react类库的时候，我们可能会操作虚拟DOM，根据是否操作了虚拟DOM对应的真实DOM元素，可以将非react类库分成两类：

​		 非侵入式类库：没有操作虚拟DOM对应的真实DOM元素

​		 侵入式类库：直接操作了虚拟DOM对应的真实DOM元素

​				一个类库是否是侵入式的是相对的，

​		例如 使用jQuery：

​				如果使用jQuery只是发送请求等等，没有操作虚拟DOM对应的真实DOM元素，此时jQuery就是非侵入式的。

​				如果使用jQuery修改了元素样式，内容，属性等，操作了虚拟DOM对应的真实DOM元素，此时jQuery就是侵入式类库。

​		使用侵入式类库的时候，对真实DOM的操作，不会被react获知，因此一定要注意组件的生命周期。

​		在ES6中，使用jQuery，要安装jQuery：npm install jquery

工作中，能用react实现的效果，尽量使用react，不要使用侵入式类库实现。

```jsx
// 引入核心库
import React, { Component } from 'react';
// 引入渲染库
import { render } from 'react-dom';

// 引入jquery
// import $ from 'jquery';


// 定义组件
class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            arr: ['中国排协就女排戴口罩比赛致歉', '加拿大直接向俄罗斯交还涡轮机', '全军统一制发军士警士证件']
        }
    }

    // 组件构建完成
    // componentDidMount() {
    //     $('li').css('color', 'green');
    // }

    // // 存在期
    // componentDidUpdate() {
    //     $('li').css('color', 'green');
    // }

    // 渲染列表
    createList() {
        // 工作中，能用react实现的效果，尽量使用react，不要使用侵入式类库实现。
        return this.state.arr.map((item, index) => <li style={{ color: 'green' }} key={index}>{item}</li>)
    }
    

    render() {
        return (
            <div>
                <h1>hello app</h1>
                <span>热搜</span>  <span onClick={ e => this.setState({ arr: ['官方：出入境人员无需再申报核检信息', '普京签令俄武装力量扩军', '美人鱼原型在中国灭绝', '重庆人等的雨终于来了', '找人代做核酸 上海3人被行政处罚'] }) }>社会</span>
                <ul>{this.createList()}</ul>
            </div>
        );
    }
}

// 渲染
render(<App></App>, app);
```

