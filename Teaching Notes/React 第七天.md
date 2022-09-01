# React 第七天

## 一、Redux

### 11 flux

react为了解决组件之间通信问题（共享数据），提供了flux框架，实现了单一数据源，数据单向流动等特征。

​		 在传统的MVC框架中，模型可以访问视图，视图可以访问模型，这样多个模块交织在一起就形成了一个网状结构，此时新增一个模块，或者是删除一个模块

成本是很高的。

​		 flux即使在此基础之上，提出的一个新的通信模型，数据始终朝着一个方向流动，形成了一个闭合的环，系统中即使有再多的这样的环，也可以看成是一个。

所以新增一个环或者删除一个环是不影响其它的环。

![](./assets/1.png)

![](./assets/2.png)

>   flux 通信

在flux中，由四部分组成：

​		 action 用户或者组件发布的消息

​		 dispatcher  用来捕获消息的模块

​		 store  存储数据的模块

​		 view  组件视图

通信流程

​		 一个组件发布了一个action， 

​		 action被dispatcher捕获到

​		 dispatcher处理消息，并将数据存储在store中

​		 store数据更新了，并将新的数据传递给另一个组件

>   reflux 和 redux

早期react团队只是提出了flux思想，并没有实现，所以很多开发者就基于flux思想，实现了自己的框架。

​	 reflux 基于状态通信的，

​			 主要在ES5开发中使用，

​	 redux 基于属性通信

​			 主要在ES6开发中使用。

### 1.2 reflux

基于flux思想实现的一个框架，简化了flux，也有数据单向流动等特征。

reflux有三步组成

​		 views  组件视图

​		 actions  消息对象

​		 stores  存储数据

通信流程

​		 一个组件发布了action，

​		 action被store捕获

​		 store根据消息类型处理数据，

​		 store将处理的结果传递给另一个组件

![](./assets/3.png)

### 1.3 redux

react也是基于flux思想实现的框架，实现了单一数据源，数据单向流动等特征。

​	redux由四部分组成

​			 components 组件视图

​			 actions 组件或者用户发布的消息

​			 store  存储数据

​			 reduers  捕获消息，处理消息

通信流程

​	 一个组件发布了一个action

​	 action通过store被reducer捕获到

​	 reducer根据消息类型处理数据。

​	 reducer将处理的结果传递给store存储

​	store数据更新了将新的数据传递给另一个组件

### 1.4 redux	特点

redux有三个特点

​	 1 单一数据源

​			 在一个应用程序中，有且只有一个store对象。

​	 2 state是只读的

​			 在store中，数据作为state来存储。

​			  state是只读的，不能修改，只能读取，即使在reducers中，也不能修改数据

​	 3 函数式编程

​			 redux为了简化我们开发，让我们使用函数式编程。

​			 在redux中，reduer就是函数，定义reducer就是定义一个函数。

### 1.5 redux 架构图

![](./assets/4.png)

### 1.6 使用redux

redux跟axios一样，是一个公用的模块，作者希望可以在所有的框架中去使用，

在不同的框架中要使用不同的插件，例如：react中使用react-redux插件

redux模块

​	 createStore  用来创建store对象的方法

​			 参数是reducer，返回值就是store对象

​	 combineReducers 合并多个reducer

​	 applyMiddleware 拓展插件

![](./assets/5.png)

### 1.7 action

action即使一个消息对象

​	 type 定义消息名称

​	 其它的属性定义数据，例如： data

消息名称通常是不变的，因此工作中，常常将消息名称字母大写，横线分割单词，放在常量中。

### 1.8 reducer

reducer是用来捕获消息对象的方法

​	 第一个参数表示状态数据对象（state），我们可以为其定义默认值，该默认值就是state初始的数据

​			 原因是：创建store的时候，默认会执行一次reducer方法，

​					 此时默认值就是初始化的状态数据，消息类型是@@redux/INTI

​	 第二个参数表示接收的action对象，在函数中，根据action类型，处理state数据

​			 注意：state是只读的，因此不能修改。否则会造成数据丢失的问题。

​			 但是如果数据是值类型，可以直接赋值修改，

​					 值类型的数据，赋值相当于复制。 引用类型的数据，赋值相当于引用。

​	 在reducer方法中，要返回新的state数据，表示更新的数据。

### 1.9 store 对象

store对象提供了一些方法

​	 dispatch 用来发布消息的方法，类似vuex中的commit和dispatch

​			 参数就是action对象

​	 subscribe 用来监听store变化的（state变化）。

​			 监听的时候，一定要在发布消息之前监听。

​	 getState 获取state数据

​	 replaceReducer 替换原有的reducer

![](./assets/6.png)

```js
// 引入redux
import { createStore } from 'redux';

// 消息名称使用常量保存
const ADD_NUM = 'ADD_NUM';
const DEL_NUM = 'DEL_NUM';

// 定义action 就是一个对象
let addNum5 = { type: ADD_NUM, data: 5 };
let delNum3 = { type: DEL_NUM, data: 3 };

// 定义reducer
    // 通常state会给到一个默认值
function reducer(state = 0, action) {
    // console.log(state, 222, action);

    // 捕获消息类型
    switch (action.type) {
        case ADD_NUM:
            state += action.data;
            break;
        case DEL_NUM: 
            state -= action.data;
        default:
            break;
    }

    // 返回结果
    return state;
}

// 创建store
let store = createStore(reducer);


// subscribe 用来监听store变化的（state变化）。监听的时候，一定要在发布消息之前监听。
store.subscribe(() => console.log(store.getState()));



// 发布消息
store.dispatch(addNum5);
store.dispatch(addNum5);
store.dispatch(addNum5);
store.dispatch(delNum3);

```



### 1.10 观察者模式解决组件间通信

我们可以基于观察者模式来解决组件之间的通信：

​		 一个组件订阅消息

​		 一个组件发布消息

在组件中订阅消息，消息的回调函数可以接收数据，可以访问组件实例对象。

​		 所以可以用接收的数据更新组件的状态来实现通信。

​		 这种基于状态实现通信的方案就是reflux的实现。

观察者模式只是用来发布消息的框架，因此不负责数据的存储。所以在订阅之前发布的消息就丢失了。

```jsx
// 引入核心库
import React, { Component } from 'react';
// 渲染库
import { render } from 'react-dom';


// 定义观察者模式
let Observer = (function() {
    // 定义数据列
    let _data = {};

    // 定义返回接口对象
    return {
        // 存储数据
        on(name, callback) {
            // 判断是否已经存储消息
            if (_data[name]) {
                _data[name].push(callback)
            } else {
                // 没有存在就创建一个新的数据数组
                _data[name] = [callback];
            }
        },
        // 触发消息
        trigger(name, ...args) {
            // 判断
            _data[name] && _data[name].forEach(fn => fn(...args));
        }
    }
})();

// 测试:
// Observer.on('abc', (...args) => console.log(111, args));

// Observer.trigger('abc', 100, true, 'abc');


// 定义组件
class App extends Component {

    // 定义
    delNum(num) {
        Observer.trigger('delNum', num);
    }

    render() {
        return (
            <div>
                <button onClick={ e => this.delNum(2) }>减少2</button>                
                <hr />
                <AddNum></AddNum>
                <hr />
                <ShowNum></ShowNum>
            </div>
        );
    }
}

class AddNum extends Component {
    render() {
        return (
            <div>
                <button onClick={ e => Observer.trigger('addNum', 5) }>增加5</button>                
            </div>
        );
    }
}

class ShowNum extends Component {
    // 定义构造函数
    constructor(props) {
        super(props);
        this.state = {
            num: 0
        }
    }

    // 组件构建完毕之后 监听消息
    componentDidMount() {
        Observer.on('delNum', num => {
            // console.log(111, num);
            // 更新状态
            this.setState({ num: this.state.num - num })
        })


        // 监听消息
        Observer.on('addNum', num => this.setState({ num: this.state.num + num }))
    }
    
    render() {
        return (
            <div>
                <h1>num: {this.state.num}</h1>
            </div>
        );
    }
}

// 观察者模式只是用来发布消息的框架，因此不负责数据的存储。所以在订阅之前发布的消息就丢失了。
Observer.trigger('addNum', 10);

// 渲染
render(<App></App>, app);
```



### 1.11 redux 解决组件间通信

redux是一个通用的框架，因此在不同的框架中使用，要安装相应的插件。

​		 在react中使用，要安装react-redux。

vuex之所以能够解决组件之间的通信，是因为vuex为每一个组件都拓展了

​		 发布消息的方法：commit和dispatch

​		 获取store的数据：state和getters

因此想在react中，使用redux解决通信，就要让每一个组件获取store中的state数据，以及发布消息的方法（dispatch）

​		 react-redux提供了connect方法以及Provider组件，可以解决上述问题。

​				 redux是通过属性传递数据实现的。

### 1.12 connect

该方法是用来为组件提供了state数据以及dispatch方法的。

​	 两个参数都是函数

​			 第一个参数函数表示：如何为组件的属性拓展state数据

​					 参数是state数据，返回值是为组件的属性拓展的state数据（还可以拓展更多的数据）

​			 第二个参数函数表示：如何为组件的属性拓展dispatch方法

​					  参数表示dispatch方法，返回值是为组件的属性拓展的dispatch方法（还可以拓展更多的方法）

connect方法返回一个函数（高阶函数）

​		 该函数创建的组件（高阶组件）可以接收state数据和dispatch方法。

​		 没有通过该函数处理的组件（包括原组件）是不会接收state数据和dispatch方法的。

### 1.13 Provider

该组件是为组件提供store数据源的。

​		 通过store属性提供数据源。属性值就是store对象

​		 我们可以将组件放在该组件内部，就可以接收数据了。

在react中使用redux共分两步

​		 第一步 通过connect方法拓展组件，接收state数据和dispatch方法

​		 第二步 通过Provider组件提供store数据源。

让其它的组件接收state数据和dispatch方法有两种方式：

​		 第一种：可以通过父子组件通信的方法，传递数据和方法

​		 第二种：继续使用connet方法得到的高阶函数拓展组件。

```jsx
// 引入核心库
import React, { Component } from 'react';
// 渲染库
import { render } from 'react-dom';
// 引入redux
import { createStore } from 'redux';
// 引入react-redux
import { connect, Provider } from 'react-redux';
 

// 定义数据
const ADD_NUM = 'ADD_NUM';
const DEL_NUM = 'DEL_NUM';
// 定义action
let addNum5 = { type: ADD_NUM, data: 5 };
let addNum10 = { type: ADD_NUM, data: 10 };
let delNum2 = { type: DEL_NUM, data: 2 };

// 定义reducer
function reducer(state = 0, action) {
    // 捕获消息
    switch (action.type) {
        case ADD_NUM:
            state += action.data;
            break;
        case DEL_NUM:
            state -= action.data;
            break;
        default:
            break;
    }

    // 返回结果
    return state;
}

// 创建
let store = createStore(reducer);


// 定义组件
class App extends Component {
 
    render() {
        console.log('app', this.props);
        return (
            <div>
                <button onClick={ e => this.props.dispatch(delNum2) }>减少2</button>                
                <hr />

                {/* 1 传递数据的方式 让其它组件也可以拥有state数据 */}
                {/* <AddNum dispatch={this.props.dispatch}></AddNum> */}
                <AddNum {...this.props}></AddNum>
                <hr />
                {/* <ShowNum></ShowNum> */}
                <DealShowNum></DealShowNum>
            </div>
        );
    }
}

class AddNum extends Component {
    render() {
        console.log('AddNum', this.props);

        return (
            <div>
                <button onClick={ e => this.props.dispatch(addNum5) }>增加5</button>                
                <button onClick={ e => this.props.dispatch(addNum10) }>增加10</button>                
                <button onClick={ e => this.props.addNum(20) }>增加20</button>                
                <button onClick={ e => this.props.addNum(30) }>增加30</button>                
            </div>
        );
    }
}

class ShowNum extends Component {
    
    render() {
        console.log('ShowNum', this.props);

        return (
            <div>
                <h1>num: {this.props.state}--- double: {this.props.double}</h1>
            </div>
        );
    }
}


// 定义高阶函数
let deal = connect(
    // 第一个参数是回调  回调中有一个state数据
    state => ({ state, double: state * 2 }),
    
    // 第二个参数是回调  回调中有一个dispatch方法
    dispatch => ({ 
        dispatch,  
        // 拓展一个增加数字的方法
        addNum(data) {
            dispatch({ type: ADD_NUM, data })
        }
    })
)

// 将需要数据的组件放入到deal方法中
let DealApp = deal(App);

// 2 还可以继续使用高阶函数为其它的组件拓展state数据
let DealShowNum = deal(ShowNum);


// store.dispatch(addNum5);

// 渲染
render(
    <Provider store={store}>
        <DealApp></DealApp>    
    </Provider>
, app);
```



## 二、路由

### 2.1 react 路由

react有三个特点：虚拟DOM，组件化开发，多端适配

​	 所以react路由为了适配多端，为不同的端提供了不同的路由模块

​			 在web端，使用 react-router-dom 模块

​			 在native端，使用 react-router-native 模块

​	 它们都依赖react-router模块

​			 所以要安装两个模块： react-router, react-router-dom

 注意：不同的react版本使用路由的方式不同。

### 2.2 使用路由

使用路由只需要两步，

​	 第一步 通过Switch组件定义路由渲染位置，通过Route组件定义路由规则

​			 path 定义规则（与vue规则是一样）

​			 name 定义名称

​			 component 定义组件

​			 exact 是否精确匹配

​			 注意：可以不使用Switch组件，此时就不能保证同时只显示一个页面了

​	 第二步 确定路由渲染策略

​			 BrowserRouter 基于path策略实现的，类似vue中的history策略

​					 需要服务器端配合：做重定向。实现的是多页面应用

​			 HashRouter 基于hash策略实现的。

​					 实现的是单页面应用

​			用路由策略组件渲染应用程序组件。

![](./assets/7.png)

### 2.3 路由拓展

**路由重定向**

​	在React路由中，通过Redirect组件实现路由重定向

​			 from  定义匹配的地址

​			 to 定义重定向的地址

**默认路由**

​	在React路由中，我们将path属性匹配*，既可以定义默认路由。

​			 由于默认路由匹配的很广，因此常常写在最后面。

**路由导航**

​	为了切换页面，React路由提供了路由导航组件：Link组件

​			 通过to属性定义切换的地址，即使是hash策略，不要以#开头。

​			 Link组件只能渲染成a标签。

 			与a标签相比，Link组件可以适配不同的路由策略。

### 2.4 路由数据

通过Route组件渲染页面组件可以通过属性获取路由数据

​		 match：包含对路由规则解析的数据，

​					如：path，url，isExact，params（动态路由数据）

​		 location：包含当前真实地址的信息（类似全局的location），

​					如：pathName，search， hash等

​		 history：包含对路由操作的方法，（类似全局的history），

​					如：push， replace，go， goBack，goForward等

没有通过Route组件渲染组件不具有路由数据，想获取路由数据，有三种方式：

​		 1 父子组件通信的方式传递数据可以传递部分数据

​		 2 继续使用Route组件渲染该组件

​		 3 使用withRouter方法拓展高阶组件。

![](./assets/8.png)

![](./assets/9.png)

![](./assets/10.png)

```jsx
// 引入核心库
import React, { Component } from 'react';
// 渲染库
import { render } from 'react-dom';
// 引入web端的路由模块
import { Switch, Route, HashRouter, BrowserRouter, Redirect, Link, withRouter } from 'react-router-dom';



// 定义组件
class App extends Component {
    render() {
        console.log('app', this.props);
        return (
            <div>
                {/* 2 父向子传递数据 */}
                <Header match={this.props.match}></Header>
                <hr />
                {/* 路由 */}
                {/* /home 称为固定的页面路由 */}
                {/* exact 是否精确匹配 */}
                {/* <Route path="/home" component={Home} name="home" exact></Route> */}
                {/* :page 称为动态路由  page可以匹配任何值 */}
                {/* <Route path="/list/:page" component={List} name="list"></Route> */}
                {/* <Route path="/detail/:id" component={Detail} name="detail"></Route> */}


                {/* 只能渲染一个页面 */}
                <Switch>
                    {/* :page 称为动态路由  page可以匹配任何值 */}
                    <Route path="/list/:page" component={List} name="list"></Route>
                    <Route path="/detail/:id" component={Detail} name="detail"></Route>

                    {/* 重定向 */}
                    <Redirect from="/abc" to="/detail/1"></Redirect>

                    {/* 默认路由 使用 * 常常放在最下面使用 */}
                    <Route path="*" component={Home} name="home"></Route>
                </Switch>


            </div>
        );
    }
}
class Header extends Component {
    render() {
        console.log('header', this.props);
        return (
            <div>
                <h1>header port</h1> 
                <a href="#/home">home</a> &emsp;
                <a href="#/list/1">list</a> &emsp;
                <a href="#/detail/2">detail</a>
                <hr />
                {/* 即使是hash策略 也不要以#开头 */}
                {/* 使用Link组件 可以适配不同的策略 */}
                <Link to="/">home</Link> &emsp;
                <Link to="/list/1">list</Link> &emsp;
                <Link to="/detail/1">detail</Link>
            </div>
        );
    }
}



// 定义Home
class Home extends Component {
    render() {
        return (
            <div>
                <h1>home page</h1>
            </div>
        );
    }
}

// 定义List
class List extends Component {
    render() {
        return (
            <div>
                <h1>List page</h1>
            </div>
        );
    }
}

// 定义Detail
class Detail extends Component {
    render() {
        console.log('detail', this.props);
        return (
            <div>
                <h1>Detail page</h1>
            </div>
        );
    }
}

// 没有通过Route组件渲染组件不具有路由数据，想获取路由数据，有三种方式：
    // 继续使用Route组件渲染该组件
    // 父子组件通信的方式传递数据可以传递部分数据
    // 使用withRouter方法拓展高阶组件

// 3 使用withRouter方法拓展高阶组件

let DealRouterApp = withRouter(App);


// 渲染
render(
    <HashRouter>
        {/* <App></App> */}

        {/* 1 使用 Route组件拓展数据 */}
        {/* <Route component={App}></Route> */}

        <DealRouterApp></DealRouterApp>
    </HashRouter>
, app);


// render(
//     <BrowserRouter>
//         <App></App>
//     </BrowserRouter>
// , app);
```

### 2.5 路由中使用 redux

在路由中使用redux就是让所有的组件都可以获取路由数据以及store数据。

​		 1 通过dealFn拓展高阶组件，接收store中所有的数据

​		 2 通过withRouter拓展高阶组件，接收路由中所有的数据

​		 3 通过Route组件渲染页面组件，传递路由中所有的数据

​		 4 通过父子组件通信的方式，传递所有或者部分路由以及store中的数据。

注意：在App组件中，通过Route组件渲染了页面组件，那么：

​		 App组件与页面组件不是直接的父子关系，不能直接传递属性数据

​		 App组件与Route组件是直接的父子关系，可以传递数据，但是Route组件内部是不会接收。

 我们在Provier中使用路由策略组件，去渲染应用程序组件。理论上Provider和路由策略组件没有先后顺序。

```jsx
// 引入核心库
import React, { Component } from 'react';
// 渲染库
import { render } from 'react-dom';
// 引入web端的路由模块
import { Switch, Route, HashRouter, BrowserRouter, Redirect, Link, withRouter } from 'react-router-dom';

// 引入redux
import { createStore } from 'redux';
// 引入react-redux
import { connect, Provider } from 'react-redux';
 

// 定义数据
const ADD_NUM = 'ADD_NUM';
const DEL_NUM = 'DEL_NUM';
// 定义action
let addNum5 = { type: ADD_NUM, data: 5 };
let addNum10 = { type: ADD_NUM, data: 10 };
let delNum2 = { type: DEL_NUM, data: 2 };

// 定义reducer
function reducer(state = 0, action) {
    // 捕获消息
    switch (action.type) {
        case ADD_NUM:
            state += action.data;
            break;
        case DEL_NUM:
            state -= action.data;
            break;
        default:
            break;
    }

    // 返回结果
    return state;
}

// 创建
let store = createStore(reducer);



// 定义组件
class App extends Component {
    render() {
        console.log('app', this.props);
        return (
            <div>
                {/* 2 父向子传递数据 */}
                {/* <Header dispatch={this.props.dispatch} ></Header> */}
                <Header {...this.props} ></Header>
                <hr />
                {/* 只能渲染一个页面 */}
                <Switch>
                    {/* :page 称为动态路由  page可以匹配任何值 */}
                    <Route path="/list/:page" component={List} name="list"></Route>
                    <Route path="/detail/:id" component={DealDetail} name="detail"></Route>

                    {/* 重定向 */}
                    <Redirect from="/abc" to="/detail/1"></Redirect>

                    {/* 默认路由 使用 * 常常放在最下面使用 */}
                    <Route path="*" component={Home} name="home"></Route>
                </Switch>


            </div>
        );
    }
}
class Header extends Component {
    render() {
        console.log('header', this.props);
        return (
            <div>
                <h1>header port--{this.props.state}</h1> 
                <hr />
                {/* 即使是hash策略 也不要以#开头 */}
                {/* 使用Link组件 可以适配不同的策略 */}
                <Link to="/">home</Link> &emsp;
                <Link to="/list/1">list</Link> &emsp;
                <Link to="/detail/1">detail</Link>
            </div>
        );
    }
}



// 定义Home
class Home extends Component {
    render() {
        return (
            <div>
                <h1>home page</h1>
            </div>
        );
    }
}

// 定义List
class List extends Component {
    render() {
        return (
            <div>
                <h1>List page</h1>
            </div>
        );
    }
}

// 定义Detail
class Detail extends Component {
    render() {
        console.log('detail', this.props);
        return (
            <div>
                <h1 onClick={ e => this.props.dispatch(delNum2) }>Detail page</h1>
                <hr />
                <Demo dispatch={this.props.dispatch}></Demo>
            </div>
        );
    }
}


class Demo extends Component {
    render() {
        console.log('demo', this.props);
        return (
            <div>
                <h1 onClick={ e => this.props.dispatch(addNum5) }>demo part</h1>
            </div>
        );
    }
}



// 使用connect高阶函数
let deal = connect(
    state => ({ state }),
    dispatch => ({ dispatch })
)

let DealApp = deal(App);
// 继续为其它组件拓展数据
let DealDetail = deal(Detail);


// 使用withRoute
let DealRouteApp = withRouter(DealApp);


// 渲染
render(
    // <HashRouter>
    //     <DealRouteApp></DealRouteApp>
    // </HashRouter>
    
    // Provider和HashRouter互相包裹都可以
    <Provider store={store}>
        <HashRouter>    
            <DealRouteApp></DealRouteApp>
        </HashRouter>
    </Provider>
, app);


```



## 三、Redux拓展

### 3.1 reducer 拓展

路由模块也提供了reducer，所以整个应用程序中就有了两个reducer：

 		一个是路由reducer

​		 一个是自定义的reducer

为了使用多个reduer，redux提供了combineReducers方法，可以合并多个reducer。

​		 参数是对象：key 表示命名空间，value 表示reducer方法

​		 combineReducers功能类似vuex中的modules属性：store切割的。

​		 store中数据存储在state中，因此对store的切割本质上就是对state的切割。

​				 所以只有state需要添加命名空间、

工作中，如果应用程序非常复杂，将所有的数据放在一起可能会产生冲突，我们可以拆分reduer。

### 3.2 state拓展

在redux中，state是不能修改的，只能读取，

在reducer中，state之所以被直接修改，是因为state是值类型的

​		 值类型的数据赋值相当于复制

​		 引用类型的数据赋值相当于引用

如果state是引用类型的，此时操作state分成三步

​		 第一步 定义结果对象

​		 第二步 用state和action去修改结果对象

​		 第三步 将结果对象和state合并到新对象中，并返回新对象

注：

​		 1 先合并state，再合并结果对象，这样就可以让result中的新的属性数据覆盖state数据

 		2 ES6提供了Object.assign方法，可以用来合并多个对象。

工作中，我们还常常在第一步将state合并到结果对象中，这样最后一步就可以直接返回结果对象。

