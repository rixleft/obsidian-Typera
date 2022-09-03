# React 第八天

## 一、、Redux拓展

### 3.1  action 拓展

在redux中，action共分两大类：

​		 第一类：同步action，

​				 包括：静态action，动态action

​		 第二类：异步action

#### 同步action

##### 静态action

​		 静态action就是一个对象：type 定义类型，其它属性定义数据

​		 我们目前定义的action都是静态action

​		 由于静态action中数据是不变的，因此使用的时候不够灵活。适用性不强。

##### 动态action

​		 动态action是一个方法，使用的时候要执行，并传递数据

​		 在方法中，返回action对象，action对象中，存储参数数据

​		 这样action中的数据是灵活可变的，适用性强，工作中常用。动态action与拓展属性方法的区别是：

​		 拓展属性方法可以灵活传递数据，但是会污染组件的属性对象

​		 动态action可以灵活传递的数据，并且不会污染组件的属性对象，工作中常用。

#### 异步action

在一个组件中发送请求，获取的数据要在其它的组件中使用。此时可以使用异步action

异步action跟动态action类似，

​		 是一个方法，参数是传递的数据

​		 返回值是一个方法

​				 第一个参数是dispatch（常用）

​				 第二个参数是getState

 				在方法中，做异步事情。异步结束之后，再发布同步消息。

#### 中间件

redux默认不支持异步aciton，想使用异步action要为redux安装中间件插件。

redux模块提供了applyMiddleware方法

 		参数是中间件

​		 返回时是一个方法，用来拓展createStore方法

​				 返回值是一个新的createStore方法。

​				 用该方法创建的store就支持异步action了。

异步action中间件插件：redux-thunk。

```jsx
// 引入核心库
import React, { Component } from 'react';
// 引入渲染库
import { render } from 'react-dom';
// 引入redux
import { createStore, applyMiddleware } from 'redux';
// 引入react-redux
import { connect, Provider } from 'react-redux';
// 引入中间件
import reduxThunk from 'redux-thunk';
// 引入axios
import axios from 'axios';



// 消息常量
const ADD_NUM = 'ADD_NUM';
const SAVE_DATA = 'SAVE_DATA';
// 定义消息对象
let addNum5 = { type: ADD_NUM, data: 5 };

// 动态action
let addNum = data => ({ type: ADD_NUM, data });

let saveData = data => ({ type: SAVE_DATA, data });

// 定义异步action
// let getData = (...args) => {
//     console.log('getData', args);
//     return function(dispatch) {
//         console.log(222, arguments)
//     }
// }

// 使用箭头函数简化
let getData = (...args) => dispatch => {
    // 发送异步消息
    axios.get('/data/demo.json').then(({ data }) => {
        // 发布同步action
        dispatch(saveData(data.data))
    });
}

// 定义默认数据对象
let defaultState = { num: 0 };
// 定义reducer
function reducer(state = defaultState, action ) {
    // 定义结果对象
    let result = Object.assign({}, state);


    console.log(111, action);
    // 处理类型
    switch (action.type) {
        case ADD_NUM:
            result.num += action.data;            
            break;
        case SAVE_DATA:
            result.data = action.data;
        default:
            break;
    }

    // 返回结果
    return result;
}

// 定义store
// let store = createStore(reducer);

// 创建新的store
    // pplyMiddleware(reduxThunk)返回值是一个方法 用该方法继续拓展新的store
let store = applyMiddleware(reduxThunk)(createStore)(reducer);




// 定义组件类
class App extends Component {
    render() {
        console.log(this.props);
        return (
            <div>
                <h1>hello app --- {this.props.state.num}  --- {this.props.state.data}</h1>
                <button onClick={ e => this.props.dispatch(addNum5) }>点我增加5</button>
                
                {/* 使用拓展的属性数据 */}
                {/* <button onClick={ e => this.props.addNum(10) }>点我增加10</button> */}

                {/* 使用动态action */}
                <button onClick={ e => this.props.dispatch(addNum(10)) }>点我增加10</button>
                <button onClick={ e => this.props.dispatch(addNum(20)) }>点我增加20</button>

                {/* 发布一个异步action */}
                <button onClick={ e => this.props.dispatch(getData(100, 200, true)) }>点我发布异步消息</button>

                <hr />
                <Demo {...this.props}></Demo>
            </div>
        );
    }
}


class Demo extends Component {
    render() {
        console.log('demo', this.props);
        return (
            <div>
                <h1>demo part</h1>
            </div>
        );
    }
}

// 使用高阶组件
let deal = connect(
    state => ({ state }),
    dispatch => ({ 
        dispatch,
        // 如果拓展属性的方式 将污染所有的组件
        // addNum(num) {
        //     dispatch({ type: ADD_NUM, data: num })
        // }
 })
)


let DealApp = deal(App);


// 渲染
render(
    <Provider store={store}>
       <DealApp></DealApp> 
    </Provider>    
, app);
```

## 二、UI

### 2.1 富文本编辑器

react中富文本编辑器：react-quill，依赖quill。

​		 安装 npm i quill react-quill

​		安装完成，直接使用，

依赖quill模块中的三个样式文件

​		 quill.core.css，

​		 quill.snow.css，

​		 quill.bubble.css

可以实现数据双向绑定

​		 通过value绑定状态数据

​		 在onChnage事件中更新状态

 				参数就是内容。

### 2.2 antd-mobile

ant-design UI框架是由阿里金服团队维护的。

​		 官网：https://ant.design/index-cn

​		 包含：pc端，移动端，native端等UI框架。

antd-mobile是其在移动端的一个ui框架

​		 官网：https://mobile.ant.design/docs/react/introduce-cn

​		 我们学习的就是移动端的UI框架，移动端开发要设置mete标签

组件默认没有样式，我们要手动的引入样式

​		 antd-mobile/dist/antd-mobile.css|less

组件命名规范：首字母大写

```jsx
import React, { Component } from 'react';
import { render } from 'react-dom';
import ReactQuill from 'react-quill';
// 引入样式文件
import 'quill/dist/quill.core.css';
import 'quill/dist/quill.snow.css';
import 'quill/dist/quill.bubble.css';

class App extends Component {
    // 构造函数
    constructor(props) {
        super(props);
        this.state = {
            msg: 'hello'
        }
    }
    render() {
        return (
            <div>
                <h1>app part</h1>
                {/* 数据双向绑定 */}
                <ReactQuill value={this.state.msg} onChange={msg => this.setState({ msg })}></ReactQuill>
                {/* <div>{this.state.msg}</div> */}
                <div dangerouslySetInnerHTML={{ __html: this.state.msg }}></div>
            </div>
        )
    }
}

render(<App></App>, app)
```



### 2.3 按需打包

在vue中，使用组件之前，建议全部安装，这样使用更方便。

在react中，为了优化，建议我们使用什么组件，引入什么组件。

所以react提供了一个按需打包的技术，与按需加载类似，都是为了性能优化。

**按需加载**

​		 在浏览器端，需要什么资源，加载什么资源（如：require.js, sea.js）.

**按需打包**

​		 在编译阶段，需要什么资源，打包什么资源

react提供了一个按需打包插件：babel-plugin-import插件

​		 在babel的配置options.plugins中配置该插件。是一个数组，每一个成员代表一个插件。

​				 成员可以是字符串，直接引入

​				 成员还可以是数组：

​						 第一个成员代表插件名称，

​						 第二个成员代表插件配置

​								 libraryName  按需打包的模块

​								 style 按需打包的样式文件类型

​		 注意：一旦使用按需打包的技术，样式就不需要手动引入了，会自动打包进来。

```jsx
import React, { Component } from 'react';
import { render } from 'react-dom';
import { Button, WingBlank, WhiteSpace, Calendar } from 'antd-mobile';
// 按需打包，不需要引入样式
// import 'antd-mobile/dist/antd-mobile.less';

class App extends Component {
    // 构造函数
    constructor(props) {
        super(props);
    }
    render() {
        return (
            <div>
                <h1>app part</h1>
                <Button>hello</Button>
                <WingBlank>
                    <Button type="primary">hello</Button>
                </WingBlank>
                <WhiteSpace></WhiteSpace>
                <WhiteSpace></WhiteSpace>
                <Button type="warning">hello</Button>
                <Calendar visible={true}></Calendar>
            </div>
        )
    }
}

render(<App></App>, app)
```



### 2.4 element-react

与element-ui一样，是由同一个团队开发并维护的。

​		 官网：https://elemefe.github.io/element-react/#/zh-CN/quick-start

该模块默认没有样式，使用样式要安装。

​		 npm i element-react element-theme-default

样式文件中，默认引入了字体图标，我们要使用url-loader加载机处理这些文件。

命名规范：组件首字母大写。

### 1.5 表单校验

对用户在表单中输入的内容做校验。

三个组件 vue中 react中

​		 el-form Form

​		 el-form-item From.Item (通常解构后，再使用Item)

​		 el-input Input

设置内容分成三步

​		 1 设置Input组件的placeholder属性

​		 2 设置Form.Item组件的label属性，代表该控件的字段名称。

​		 3 设置Form组件的labelWidth属性，设置label显示的宽度。

对输入的内容做校验共分四步：

​		 1 Input组件，实现数据双向绑定

​				 注意：如果字段很多，修改数据的时候，不要相互覆盖。

​		 2 Form组件，设置model属性

​		 3 Item组件，设置prop属性

​		 4 Form组件，设置rules属性。校验规则是一个对象，

​				 key表示校验字段的名称。 

​				 value是一个数组，表示多条规则，每一个成员是对象，代表一条规则。

​						 required  是否是必填的

​						 message  出现错误的时候，提示的内容

​						 validator 校验方法

​						 trigger  什么时候触发校验（默认是一边输入，一边校验）

表单提交的校验共分三步：

​		 1 绑定提交事件

​		 2 为Form组件设置ref。

​		 3 通过ref获取组件，调用validate方法校验表单。

```jsx
// 引入核心库
import React, { Component, createRef } from "react";
// 引入渲染库
import { render } from 'react-dom';
// 引入ui库
import { Button, Form, Input } from 'element-react';
// 导入样式文件
import 'element-theme-default';

// 解构Item
// let { Item } = Form;


// 定义组件
class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            form: {
                username: '',
                password: ''
            }     ,
            rules: {
                username: [
                    { required: true, message: '请输入用户名', trigger: 'blur' },
                    /* 自定义校验规则 */
                    { validator(field, value, cb) {
                        // console.log(11, args);
                        if (!/^\w{4,6}$/.test(value)) {
                            cb(new Error('请检查用户名'))
                        }  else {
                            cb()
                        }
                    } }
                ]
            }       
        }

        // 定义ref
        this.submit = createRef();
    }

    // 提交检验
    subMit() {
        this.submit.current.validate(valid => {
            console.log(111, valid);
        })
    }
    
    render() {
        // 解构数据对象
        let { form } = this.state;
        return (
            <div>
                <h1>hello app</h1>
                <hr />
                {/* <Button>按钮</Button>
                <Button type="primary">按钮</Button>
                <Button type="success">按钮</Button>
                <Button type="danger">按钮</Button>
                <Button type="warning">按钮</Button>
                <Button type="warning" plain={true}>按钮</Button> */}

                {/* 表单 */}
                {/* 
                    设置样式:
                        1 为input设置placeholder
                        2 为Item设置label字段
                        3 为了Form 设置labelWith

                    设置校验:
                        1 为input实现数据双向绑定
                        2 为Item设置prop属性（检验哪一个字段）
                        3 为Form设置model
                        4 为Form设置rules
                
                    提交验证:
                        1 绑定提交事件
                        2 为Form组件设置ref。
                        3 通过ref获取组件，调用validate方法校验表单
                                        
                
                */}

                <Form labelWidth="100" model={this.state.form} rules={this.state.rules} ref={this.submit}>
                    <Form.Item label="用户名" prop="username">
                        <Input placeholder="请输入用户名" value={this.state.form.username} onChange={ username => {
                            // form.username = username;
                            // this.setState({ form: form })

                            // 使用Object.assgin合并对象
                            this.setState({ form: { ...form, username } })


                        } }></Input>
                        </Form.Item>
                    <Form.Item label="密码" prop="password">
                        <Input placeholder="请输入密码" value={this.state.form.password} onChange={ password => this.setState({ form: { ...form, password }  }) }></Input>
                        </Form.Item>
                    <Form.Item>
                        <Button onClick={ e => this.subMit()}>提交</Button>
                    </Form.Item>
                </Form>

            </div>
        );
    }
}

// 渲染
render(<App></App>, app);
```





## 三、create-react-app

### 3.1 create-react-app

与vue-cli一样，create-react-app是react的一款脚手架。

 		内置很多功能，让我们可以直接进入开发。

安装指令

​		 npm i -g creact-react-app

​		 安装完毕，提供了create-react-app指令

创建项目

​		 create-react-app 项目名称

​		 此时链接网络就可以下载项目了。

create-react-app创建的项目也是通过yarn来管理和维护的，安装模块用yarn安装。

​		 例如：yarn add react-router react-router-dom redux react-redux

 yarn add指令功能与npm install指令是一样的。

### 3.2 目录部署

node_modules 依赖模块

public 静态目录

​			 favicon.ico：logo

​			 index.html：模板入口文件 

​			 manifest.json：离线缓存配置

src  开发目录

​		 App.css：应用程序样式

​		 App.js：应用程序脚本 

​		 App.test.js：应用程序单元测试

​		 index.css：全局样式 

​		 logo.svg：eact的logo

​		 registreServiceWorker.js：web workers

.gitignore  git 配置

package.json npm 包配置

README.md 介绍文件

yarn.lock yarn锁文件

![](D:/class_49/40 react_08/example/assets/1.png)

### 3.3 指令

create-react-app创建的项目提供了一些指令：

​		 start 启动项目，默认端口号是3000

​		 build  发布项目，默认发布到build目录下

​		 test  单元测试

​		 eject  输入webpack配置

任务：

​		 将静态资源发布到外面的dist目录下

​		 将模板资源发布到外面的views目录下

 这些指令既可以使用yarn来启动，也可以使用npm来启动。

### 3.4 PWA 应用

PWA应用是一个渐进式的web应用，介于源生app与网站页面之间的一个应用。

其中

​		 manifest.json就是离线缓存的文件

​		 registreServiceWorker.js也是为pwa应用提供的web worker文件。

在浏览器中，点击“创建快捷方式”就可以在桌面上，创建一个离线应用。

## 四、单元测试

### 4.1 单元测试

为了确保代码质量，我们要对代码做测试，基于文件或者模块的测试我们称之为单元测试。

react也是使用ject框架进行测试的。

默认的测试文件：.test. 为后缀的

测试结果

​		 测试通过： 所有的测试单元都通过

​		 测试失败： 有一个测试单元失败了

### 4.2 测试方法

describe 整体描述

​		 第一个参数表示整体描述

​		 第二个参数表示测试内容

it  定义每一次测试

​		 第一个参数表示本次测试的描述

​		 第二个参数表示本次测试的实现

expect  测试的断言方法

​		 参数是运行的语句

​		 我们可以对返回值执行断言方法，判断结果

### 4.3 断言方法

toBe    

 		 类似于`===`。例如：expect(true).toBe(true);

toEqual

​		  比较变量字面量的值。例如： expect({ foo: 'foo'}).toEqual( {foo: 'foo'} );

toMatch

​		是否匹配正则表达式。例如： expect('foo').toMatch(/foo/);

toBeDefined

​	    检验变量是否定义。例如： var foo = { bar: 'foo'}; expect(foo.bar).toBeDefined();

toBeNull

​	    检验变量是否为`null` 。例如： var foo = null; expect(foo).toBeNull(); 

toBeTruthy

​	    检查变量值是否能转换成布尔型`真`值。例如： expect({}).toBeTruthy();

toBeFalsy

​	    检查变量值是否能转换成布尔型`假`值。例如： expect('').toBeFalsy();

toContain

​	    检查在数组中是否包含某个元素。例如： expect([1,2,4]).toContain(1);

toBeLessThan

​	    检查变量是否小于某个数字。例如： expect(2).toBeLessThan(10);

toBeGreaterThan

​	    检查变量是否大于某个数字或者变量。例如： expect(2).toBeGreaterThan(1);

toBeCloseTo

​		 比较两个数在保留几位小数位之后，是否相等,用于数字的精确比较。

​		 例如： expect(3.1).toBeCloseTo(3, 0);

toThrow

​		 检查一个函数是否会throw异常。例如： expect(function(){ return a + 1;}).toThrow(); // true

​		 expect(function(){ return a + 1;}).not.toThrow(); // false

toHaveBeenCalled

​		 检查一个监听函数是否被调用过

toHaveBeenCalledWith

​		 检查监听函数调用时的参数匹配信息

### 4.4 周期方法

beforeEach 每一个it语句执行前

afterEach · 每一个it语句执行后

beforeAll 所有的it语句执行前

afterAll 所有的it语句执行后

```js
// 引入接口文件
import demo, { msg, num } from './demo';

// 整体的测试
describe('测试Demo文件', () => {

    // 不会跨文件
    // beforeEach		每一个it语句执行前
    beforeEach(function() {
        console.log(111, 'beforeEach');
    })
    // // afterEach		每一个it语句执行后
    afterEach(function() {
        console.log(222,'afterEach');
    })
    // beforeAll		所有的it语句执行前
    beforeAll(function() {
        console.log(333,'beforeAll');
    })
    // afterAll			所有的it语句执行后
    afterAll(function() {
        console.log(444, 'afterAll');
    })


    // it表示测试每一条语句
    it('测试msg', () => {
        // 实现测试
        // 测试的断言方法
        expect(num)
            // 是否全等
            .toBe(100)
    })

    // it('测试msg', () => {
    //     expect(msg)
    //         // 正则是否匹配
    //         .toMatch(/hello msg/)

    // })
})
```



