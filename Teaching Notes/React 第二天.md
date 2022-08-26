# React 第二天

## 一、React

### 1.1 属性数据

为了增强组件的适用性，我们要为组件定义属性。

属性分类：

​		 虚拟DOM有四类属性：自定义数据属性，元素属性，特殊元素属性，非元素属性。

​		 组件只有一类属性数据，就是自定义数据属性

传递属性：组件是对虚拟DOM的封装，因此为组件传递属性数据跟虚拟DOM传递属性数据的语法是一样的。

​		 虚拟DOM传递属性数据 <div title="hello"></div>

​		 组件传递属性数据 <Demo title="hello"></Demo>

使用属性：在组件中，通过this.props获取属性数据。

​		 注意：属性数据是组件外部维护的数据，只能在组件外部修改，不能在组件内部修改，

### 1.2 默认属性数据

当组件使用属性数据的时候，如果没有传递属性数据，有可能报错。我们可以通过为组件定义默认属性数据的方式来解决。为组件定义默认属性数据，通过静态属性defaultProps实现。

​	 类的属性共分三类：

​			实例属性，

​			原型属性，

​			静态属性。

​	 静态属性：只能通过类来访问的属性，不能通过实例对象访问。例如： Array.from, Array.of ...

​	 在ES6中，定义静态属性有两种方式：

​		 第一种：在类的外面，通过点语法定义静态属性。

​		 第二种：在类的内部，通过static定义静态属性方法

​			 	方法：直接在方法前面添加staitc。

​				属性：直接在get以及set特性方法前，添加static关键字。

​		 这两种方式区别：第一种没有设置特性，第二种设置了特性。react建议我们使用第一种方式。

为组件定义默认属性数据，就是为类的静态属性defaultProps定义属性数据。

此时如果组件传递了属性数据，将使用传递的属性数据。此时如果组件没有传递属性数据，将使用默认属性数据，

### 1.3 属性数据的约束性

如果属性传递的不合法，此时还会抛出错误。

我们可以为组件的属性定义属性约束条件。

​	 通过静态属性：propTypes来定义。

我们要安装prop-types： npm install prop-types

​	 该模块提供了大量的类型，我们可以直接使用

​	 类型中，提供了isRequired方法，表示该属性是必须传递的。

​	 注意：

​		 设置isRequired属性的时候，不能设置默认属性数据，否则无法校验。

​		 只是校验属性，并没有解决问题。

```jsx
// 引入核心库
import React, { Component, createElement } from 'react';
// 引入渲染库
import { render } from 'react-dom';
// 引入属性约束模块
import PropTypes from 'prop-types';
console.log(PropTypes);

// 引入样式文件
// import './demo.css';
// import './demo.less';

// 定义组件类
class App extends Component {

    // 1 定义静态数据
    static get title() {
        return 'hello title';
    }

    // 定义渲染列表的方法
    createList() {
        return this.props.arr.map(item => <li key={item}>{item}</li>)
    }

    render() {
        // 传递的属性数据 是只读的 不能在内部修改
        // this.props.arr = [];
        // 实例化对象是无法访问静态数据的
        console.log(111, this, this.title, this.msg);
        return (
            <div>
                <h1>hello app</h1>
                <hr />
                {/* 执行一个渲染列表的方法 */}
                <ul>{this.createList()}</ul>
            </div>
        )
    }
}

// 2 类的外部定义静态数据
App.msg = 'hello msg';

// 只能通过类来访问
// console.log(App.title);
// console.log(App.msg);




// 为组件定义默认属性数据，通过静态属性defaultProps实现
App.defaultProps = {
    arr: ['默认的']
}


// 通过静态属性：propTypes来定义。
App.propTypes = {
    // arr属性是必须传递的
    // 只是校验属性，并没有解决问题。 通常要配合默认属性数据一起使用
    arr: PropTypes.array.isRequired
}





// 定义数据
// let arr = ['好看视频', '天猫国际', '哔哩哔哩'];


// 渲染虚拟DOM
// 传递属性数据
// render(<App arr={arr}></App>, app);

// 如果没有传递属性 就会抛出错误
// render(<App></App>, app);

// 此时如果传递了数据 将使用传递的数据 没有传递将使用默认的数据
render(<App arr={['知乎', '凤凰网', '12306']}></App>, app);

// 传递一个字符串
// render(<App arr='hello'></App>, app);
// render(<App></App>, app);

```



### 1.4 DOM事件

react中，为虚拟DOM绑定事件与真实的DOM绑定事件的语法是类似的。

​	 真实DOM绑定事件 <div onclick="fn"></div>

​	 虚拟DOM绑定事件 <div onClick={this.fn}></div>

注意：

​	 1 事件名称首字母要大写。

​	 2 事件回调函数要定义在组件中

​	 3 事件回调函数不要执行 (后面不要添加参数集合())

​	 4 默认参数就是事件对象

​	 5 this指向undefined

### 1.5 事件参数

默认参数表示事件对象（是React封装后的）

​	 因为react实现了事件委托：1 减少事件数量，2 预言未来元素，3 避免内存外泄

react框架时时刻刻想的都是优化。

注意：

​	 1 为了让虚拟DOM与真实的DOM元素相对应，react为虚拟DOM和真实DOM设置相同的 data-reactid属性。在之前的版本中，添加在标签中，在当前版本中，

添加在dom元素上。

​	 2 使用插值语法时候，我们建议将表达式写在插值语法内部，这样会少创建元素。

### 1.6 this 指向

this默认指向undefined。为了更改this指向，react提供了三种方式：

​	 第一种，在构造函数中，重写原型方法，添加到实例对象自身，并绑定this。此时可以传递数据，传递的数据在事件对象之前。

​			 注：由于使用了继承，在构造函数中，要使用super关键字实现继承。

​	 第二种，使用事件回调函数的时候直接通过bind方法绑定。此时可以传递数据，传递的数据在事件对象之前

​			 与第一种方式相比：

​				 	第一种添加在实例上，第二种添加在原型上。

​					 第一种传递的参数是固定的，第二种可以自由的传递数据

​	 第三种， 可以通过箭头函数实现对this指向的更改。this指向render方法中的this，参数可以在任何位置传递（包括事件对象）。

​			由于箭头函数可以简写，非常方便，工作中常用。

​	 注：第二种方式原则上讲，可以绑定任何对象，但是react不建议，只建议绑定组件实例对象。

```jsx
// 引入核心库
import React, { Component, createElement } from 'react';
// 引入渲染库
import { render } from 'react-dom';




// 定义组件类
class App extends Component {
    // 定义构造函数
    constructor() {
        // 使用super关键字继承
        super();
        
        // 解决this是undefined的方式1
            // 定义给实例化对象  通过改变this传递参数
        this.clickBtn1 = this.clickBtn1.bind(this, 100, 200);


    }

    // 定义事件回调函数
    clickBtn1(e) {
        // e表示事件对象 是react封装之后
        // console.log(e.target);
        // console.log(e.currentTarget);

        // react中对于事件实现了事件委托技术

        console.log('clickBtn1', this, arguments);
    }
    clickBtn2() {
        console.log('clickBtn2', this, arguments);
    }
    clickBtn3() {
        console.log('clickBtn3', this, arguments);
    }
    clickBtn4() {
        console.log('clickBtn4', this, arguments);
    }
    clickBtn5() {
        console.log('clickBtn5', this, arguments);
    }

    // 渲染方法
    render() {
        let msg = 'word';
        // console.log(this);

        let obj = { a: 1, b: 2 } 

        return (
            <div>
                <h1>hello app</h1>
                <hr />
                {/* 1 */}
                <button onClick={this.clickBtn1}>clickBtn1</button>
                
                
                {/* 2 执行时候直接绑定this 传递参数 */}
                <button onClick={this.clickBtn2.bind(this, 200, 300, 400, 500, true)}>clickBtn2</button>
                {/* 还可以绑定其它数据对象  但是没有意义*/}
                <button onClick={this.clickBtn2.bind(obj, 200, 300, 400, 500, true)}>clickBtn2-obj</button>

                {/* 3 利用箭头函数 */}
                <button onClick={ e => {
                    return this.clickBtn3(e, 100, 'abc', true);
                }}>clickBtn3</button>

                {/* 简写: */}
                {/* 由于箭头函数可以简写，非常方便，工作中常用。 */}
                <button onClick={e => this.clickBtn4(200, false, 'ccc', e)}>clickBtn4</button>
                <button onClick={this.clickBtn5}>clickBtn5</button>
                
                <hr />
                <h1>hello {msg}</h1>
                {/* react建议将字符串写入到插值符号的内部 为了减少创建多余的节点 */}
                <h1>{'hello ' + msg}</h1>
            </div>
        )
    }
}


// // 演示this的变化：
// function fn() {
//     console.log('fn', this);
// }


// let obj = {
//     demo: fn   
// }
// // 缓存数据
// let newFn = obj.demo;
// newFn(); 




// 渲染
render(<App></App>, app);

/* 
    优化:
        事件对象: 使用了事件委托技术 并且事件对象也是封装之后的
        新版本react 设置元素的id 是以打点的形式添加给元素的
        将表达式写在插值语法内部，这样会少创建元素。
*/

```



### 1.7 状态数据

状态与属性一样，都是为组件存储数据的。

​	 属性是从组件外部传递进来的，是组件外部的数据，从组件外部维护。

​	 状态是从组件内部定义出来的，是组件内部的数据，从组件内部维护。

我们在组件的内部维护（定义，获取和修改）状态数据

根据组件是否有状态数据，我们将组件分成两类：无状态组件，有状态组件。

### 1.8 无状态组件

组件创建后，不会因为交互而产生数组，不会发送异步请求获取数据等等，组件从创建到销毁是一成不变的，这类组件就是无状态组件，我们目前定义的组件都是

无状态组件。

由于无状态组件中没有状态数据，因此可以将无状态组件简写成函数组件

### 1.9 函数组件

​	 通过函数定义的组件

​		 	第一个参数表示属性数据

 			返回值表示渲染的虚拟DOM

​	 注：函数组件可以用箭头函数来简写，因此函数组件简化了组件的定义。

​	 类组件：通过类定义的组件

```jsx
// 引入核心库
import React, { Component, createElement } from 'react';
// 引入渲染库
import { render } from 'react-dom';


// 定义类组件 (无状态组件)
// class Demo extends Component {
//     // 定义渲染列表的方法
//     createList() {
//         return this.props.arr.map(item => <li key={item}>{item}</li>)
//     }

//     render() {
//         return (
//             <div>
//                 <h1>hello demo</h1>
//                 <hr />
//                 <ul>{this.createList()}</ul>
//             </div>
//         );
//     }
// }

// 将无状态组件改为函数组件
// let Demo = props => {
//     // 定义方法
//     function createList() {
//         return props.arr.map(item => <li key={item}>{item}</li>)
//     }

//     return (
//         <div>
//             <h1>hello demo</h1>
//             <hr />
//             <ul>{createList()}</ul>
//         </div>
//     )
// }

// 进一步简写:
// let Demo = props => {
//     return <ul>{props.arr.map(item => <li key={item}>{item}</li>)}</ul>
// }

// 在进行简写:
let Demo = props => <ul>{props.arr.map(item => <li key={item}>{item}</li>)}</ul>


// 渲染
render(<Demo arr={['好看视频', '淘宝网', '携程网']}></Demo>, app);
```



### 1.10 有状态组件

组件创建后，会因为交互而产生数据，会发送异步请求获取数据，这些在组件内部产生的数据就要放在状态中去存储。

获取状态

​	 获取属性：在组件中，通过this.props获取属性数据

​	 获取状态：在组件中，通过this.state获取状态数据

修改状态

​	 在组件内部修改状态通过this.setState方法.

​	 参数是一个对象，表示修改的数据集合

 			key：表示修改的状态数据名称 

​			value：表示修改的状态数据值

### 1.11 初始化状态

我们在构造函数（constructor）中，初始化状态数据: this.state = {}

​	 由于继承了组件基类，所以在构造函数中，要使用super关键字实现构造函数继承。

构造函数的第一个参数表示传递给组件的属性数据（props）。我们可以传递给super方法。

 	如果没有传递，此时this.props是undefined与参数props不同

​	 如果传递了，此时this.props与参数props就是相同的了。

​	 注：工作中，建议传递props，这样使用参数props或者this.props就没有区别了。

在构造函数中，我们可以访问到属性数据，因此可以用属性数据为状态数据赋值，实现数据由外部（属性数据）流入内部（状态数据）。在工作中，之所以这么

做，是因为属性数据只能在外部维护，将属性数据存储到状态中，我们可以在组件内部维护这些数据了。

注：工作中，开发组件的时候，一定要分析出哪些是属性数据，哪些是状态数据。

```jsx
// 引入核心库
import React, { Component, createElement } from 'react';
// 引入渲染库
import { render } from 'react-dom';

// 定义组件类
class App extends Component {
    // 在构造函数中定义状态数据
    constructor(props) {
        // 必须传递super
            // 注意: 在super中要传递props 否则无法在this中获取数据 传递之后 参数和this.props就相同了
        super(props);
        // console.log(111, props, this.props, props === this.props);  
        
        // 通过this.state定义状态数据
        this.state = {
            num: 100,
            // 将属性数据赋值到状态中
            // msg: props.msg,
            // title: props.title

            // 使用扩展运算符
            ...props
        }        

        // 直接修改状态数据
       setTimeout(() => {
            // 如果直接修改状态数据 视图不会同步更新 此时称为数据丢失
            // this.state.num = 1000;

            // 为了避免数据丢失 提供了setState方法
            this.setState({
                num: 1000,
                msg: 'hello msg333',
                title: 'nihao333'
            })

            console.log(this.state);
       }, 3000);



        // 修改属性数据 （是只读的）
        // props.msg = 'hello msg333';

    }
    
    render() {
        // 解构数据
        // let { msg, title } = this.props;
        // 解构状态数据
        let { num, msg, title } = this.state;
        return (
            <div>
                <h1>hello app</h1>
                <hr />
                {/* <h1>属性数据: msg: {this.props.msg} -- title: {this.props.title}</h1> */}
                {/* <h1>状态数据: num: {this.state.num}</h1> */}

                {/* 简化访问: */}
                <h1>msg: {msg} --- title: {title} --- num: {num}</h1>
            </div>
        );
    }
}

// 定义默认数据
App.defaultProps = {
    title: 'nihao'
}

// 渲染
render(<App msg="hello msg"></App>, app);
```



### 1.12 组件通信

虚拟DOM中可以子虚拟DOM，组件是对虚拟DOM的模拟，因此在组件中也可以定义子组件。

 在Parent组件中定义的Child组件称之为Parent组件的子组件，Parent组件就是父组件。

​	 <Parent>

​			 <Child />

​	 </Parent>

组件间通信：组件之间的通信通常分成三类

​	 父组件向子组件通信

​	 子组件向父组件通信

​	 兄弟组件之间通信

### 1.13 父组件向子组件通信

父组件向子组件通信很简单：直接为子组件传递属性数据或者方法

传递的是属性：可以是变量，属性数据，状态数据等等。

​	 这些传递的数据改变，子组件接收的数据也将同步改变。

传递的是方法：有两种使用方式

​	 **作为子组件的事件回调函数**

​			默认参数是事件对象，this默认指向undefined，我们可以更改this指向：

​			可以让this指向子组件，可以让this指向父组件。一旦指向父组件就永远指向父组件，

​			更改this指向的时候，还可以传递数据，顺序：父组件， 子组件， 事件对象

​	 **在子组件方法中执行**

​			默认没有参数，this指向子组件的属性对象。我们可以绑定父组件，此时将永远指向父组件。

​			更改this指向的时候，还可以传递数据，顺序：父组件， 子组件

注：工作中，为了简化绑定父组件过程，可以直接使用箭头函数，

```jsx
// 引入核心库
import React, { Component, createElement } from 'react';
// 引入渲染库
import { render } from 'react-dom';


// 定义组件类
class App extends Component {
    constructor(props) {
        super(props);
        // 定义状态数据
        this.state = {
            num: 100
        }

        // setTimeout(() => {
        //     this.setState({ num: 1000 })
        // }, 3000);
    }

    // 定义方法
    parentMethod() {
        console.log('parent', this, arguments);
    }
    

    render() {
        // 定义变量
        let msg = 'parrent msg';
        // 解构属性数据
        let { title } = this.props;
        // 解构状态数据
        let { num } = this.state;
        return (
            <div>
                <h1>hello app</h1>
                <hr />
                {/* 直接使用子组件：组件的首字母都是大写 */}
                {/* <Child msg={msg} title={title} num={num} method={this.parentMethod}></Child> */}
                {/* 传递方法的时候可以该变this指向 */}
                {/* <Child msg={msg} title={title} num={num} method={this.parentMethod.bind(this, 200, 300)}></Child> */}
                {/* 简写: */}
                <Child msg={msg} title={title} num={num} method={(...args) => this.parentMethod(...args, 200, 300)}></Child>
            </div>
        );
    }
}

class Child extends Component {


    // 定义方法
    childMethod() {
        // 执行父组件的方法 默认没有参数 父组件方法中的this指向的是this.props属性对象
        this.props.method(100, true, 'abc');
    }

    render() {
        // 解构属性数据
        let { msg, title, num } = this.props;
        return (
            <div>
                <h1>child part-- {msg} -- {title} -- {num}</h1>
                <hr />
                {/* 
                    作为子组件的事件回调函数使用：
                        默认this是undefined 参数是子组件的事件对象
                        可以改变this为子组件
                        当父组件传递方法的时候已经改变了this指向  此时将永远指向父组件
                        在方法执行的时候可以传递参数 参数顺序: 父组件 子组件 事件对象
                */}
                {/* <input type="text" onChange={ this.props.method.bind(this,  500, 600) } /> */}

                {/* 

                    作为子组件中的方法执行:
                        默认没有参数 父组件方法中的this指向的是this.props属性对象
                        当父组件传递方法的时候已经改变了this指向  此时将永远指向父组件
                        在方法执行的时候可以传递参数 参数顺序: 父组件 子组件 事件对象
                
                */}
                <input type="text" onChange={ e => this.childMethod() } />
            </div>
        );
    }
}


// 渲染
render(<App title="nihao"></App>, app);
```



### 1.14 子组件向父组件通信

父组件可以向子组件传递属性和方法，传递的方法绑定了父组件，就永远指向父组件了，此时在方法中，修改状态数据，修改的是谁的状态数据呢？

​	 修改的是父组件的状态数据，这就是子组件向父组件通信的原理。

分成三步

​	 第一步 在父组件中，为子组件传递方法，并绑定父组件

​	 第二步 在子组件中，执行方法，并传递子组件中的数据

​	 第三步 在父组件中，接收数据，并更新状态

```jsx
// 引入核心库
import React, { Component, createElement } from 'react';
// 引入渲染库
import { render } from 'react-dom';


// 定义组件类
class App extends Component {
    constructor(props) {
        super(props);
        // 定义状态数据
        this.state = {
            msg: 'parent msg'
        }
    }

    // parentMethod(e) {
    //     // console.log('parentMethod', this, arguments);

    //     // console.log(e.target.value);

    //     // 修改状态数据
    //     this.setState({ msg: e.target.value })
    // }

    render() {
        // 解构状态数据
        let { msg } = this.state;
        return (
            <div>
                <h1>hello app -- {msg}</h1>
                <hr />
                {/* 定义子组件 */}
                {/* 1 为子组件传递方法并绑定this */}
                {/* <Child method={ e => this.parentMethod(e) }></Child> */}
                {/* 在方法中只有一句话的时候 可以简写 */}
                <Child method={ msg => this.setState({ msg }) }></Child>
            </div>
        );
    }
}

class Child extends Component {


    render() {
        return (
            <div>
                <h1>child part</h1>
                <hr />
                {/* <input type="text" onChange={ e => this.props.method(e) } /> */}
                {/* 直接把子组件的输入内容传递过去 */}
                <input type="text" onChange={ e => this.props.method(e.target.value) } />
            </div>
        );
    }
}


// 渲染
render(<App title="nihao"></App>, app);
```



### 1.15 兄弟组件之间的通信

父组件向子组件通信：为子组件传递属性数据或者方法

子组件向父组件通信：为子组件传递方法并绑定父组件,子组件执行方法并传递数据,父组件接收数据并更新状态

如果这两个子组件互为兄弟组件，就可以实现兄弟组件之间的通信了。

​	 兄弟组件之间通信：

​				一个子组件将数据传递给父组件，再由父组件将数据传递给另一个组件。

​	 流程分成四步：

​			 1 在父组件中，为一个子组件传递方法，并绑定父组件 

​			 2 在子组件中，执行方法，并传递子组件中的数据

​			 3 在父组件中，接收数据，并更新状态 

​			 4 在父组件中，将新的状态数据，传递给另一个子组件。

 兄弟组件之间的通信的核心是：有一个相同的父组件，相当于媒婆、

对于不相干的两个组件是无法通信的，后面会学习上下文数据对象（context）以及通信框架flux, reflux, redux等

```jsx
// 引入核心库
import React, { Component, createElement } from 'react';
// 引入渲染库
import { render } from 'react-dom';


// 定义组件类
class App extends Component {
    constructor(props) {
        super(props);
        // 定义状态数据
        this.state = {
            msg: ''
        }
    }

    render() {
        return (
            <div>
               <h1>app part -- {this.state.msg}</h1>
               <hr />

               {/* 第一个子组件 */}
               <First method={ msg => this.setState({ msg }) }></First>
               {/* 第二个子组件 */}
               <Second msg={this.state.msg}></Second>
            </div>
        );
    }
}


// 定义组件类
class First extends Component {
    render() {
        return (
            <div>
                <input type="text"  onChange={ e => this.props.method(e.target.value) } />
            </div>
        );
    }
}


// 定义组件类
class Second extends Component {
    render() {
        return (
            <div>
                <h1>展示结果: {this.props.msg}</h1>
            </div>
        );
    }
}

// 渲染
render(<App></App>, app);
```



