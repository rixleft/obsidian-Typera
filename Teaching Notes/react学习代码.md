```js
// import React from 'react';
// import ReactDOM from 'react-dom/client';
// import './index.css';
// import App from './App';
// import reportWebVitals from './reportWebVitals';

// const root = ReactDOM.createRoot(document.getElementById('root'));
// root.render(
//   <React.StrictMode>
//     <App />
//   </React.StrictMode>
// );

// // If you want to start measuring performance in your app, pass a function
// // to log results (for example: reportWebVitals(console.log))
// // or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
// reportWebVitals();


// npm start 启动项目

// 1 导入react 不再通过 script 标签导入，而是使用ES6中的模块化语法导入
// import React from 'react'
// 2 做 web 应用才导入 react-dom ，做手机应用导入 react-native 对应的渲染模块，实际上 react 可以使用在很多方面，但 react-dom 只能渲染 web 应用。
// import ReactDOM from 'react-dom'  //该写法已被弃用了，控制台有报错
// 3 创建react元素,参数为，元素，元素的属性，元素内的值，举例：<h1 id=''>Hello React</h1>，该方法了解即可，因为它写起来繁琐不优雅，无法直观的看出所描述的内容。推荐使用 JSX
// const title = React.createElement('h1', null, 'Hello React !!!')
// 4 渲染react元素, root 元素在 public 文件夹的 index.html 页面中
// ReactDOM.render(title, document.getElementById('root'))

//使用JSX创建react元素,更加简洁和优雅，可以直观的看出框架
// const title = <h1>Hello JSX <span>这是span标签</span></h1>
//渲染react元素
// ReactDOM.render(title, document.getElementById('root'))





/*
JSX中使用Javascript表达式的注意点:
*/
//函数调用表达式
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);
// const sayHi = () => 'Hi~'
// const dv = <div>我是一个div</div>
// const title = (
//   <h1>
//     Hello Jsx
//     <p>{1}</p>
//     <p>{'a'}</p>
//     <p>{1 + 7}</p>
//     <p>{3 > 5 ? '大于' : '小于等于'}</p>
//     <p>{sayHi()}</p>
//     {dv}
//     {/* 一般不能使用对象，错误演示,会报错*/}
//     {/* <p>{ {a: '6'}}</p> */}
//     {/* { if (true){}} */}
//     {/* { for (var i = 0; i < 10;i++){}} */}

//   </h1>)
// //渲染react元素
// root.render(title)



/*
  列表渲染: 必须有一个唯一指定的 key 值：
  ERROR：Each child in a list should have a unique "key" prop.
  注意：
    如果要渲染一组数据，应该使用数组的 map() 方法
    注意：渲染列表时应该添加 key 属性，key 属性的值要保证唯一
    原则：map() 遍历谁，就给谁添加 key 属性
    注意：尽量避免使用索引号作为 key
*/
//歌曲列表:
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);
// const songs = [
//   { id: 1, name: '痴心绝对' },
//   { id: 2, name: '像我这样的人' },
//   { id: 3, name: '南山南' },
// ]
// const list = (
//   <ul>
//     {songs.map(item => <li key={item.id}>{item.name}</li>)}</ul>
// )
// // 渲染react元素
// root.render(list)






/*
  JSX的样式处理
  不建议使用行内 style 添加样式，html 和 css 样式耦合，不利于修改。
  建议使用类名添加样式，但别忘记引入 css 文件,当前的 css 文件中的内容是自己添加的。
*/
// import './css/01.css'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);
// const list = (
//   <h1 className='title' style={{ color: 'red', backgroundcolor: "skyblue" }}>
//     JSX的样式处理
//   </h1 >
// )
// //渲染react元素
// root.render(list)




/*
函数组件:
  函数组件：使用 JS 的函数（或箭头函数）创建的组件
  约定1：函数名称必须以大写字母开头， React 据此区分 组件 和 普通的React 元素
  约定2：函数组件必须有返回值，表示该组件的结构
  如果返回值为 null，表示不渲染任何内容
  只需要在标签内写函数名即可调用
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);
// function Hello() {
//   return (
//     <div>这是我的第一个函数组件</div>)
// }
// // 箭头函数
// // const Hello =  ()=> <div>这是我的第一个函数组件</div>

// //渲染组件,单标签和双标签都可以，单标签<Hello/> 双标签<Hello></Hello>
// root.render(<Hello />)


/*
类组件:
 类组件：使用 ES6 的 class 创建的组件
 约定1：类名称也必须以大写字母开头
 约定2：类组件应该继承 React.Component 父类，从而可以使用父类中提供的方法或属性
 约定3：类组件必须提供 render() 方法
 约定4：render() 方法必须有返回值，表示该组件的结构
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);
// //创建类组件
// class Hello extends React.Component {
//   render() {
//     return (
//       <div>这是我的第一个类组件</div>)
//   }
// }
// //渲染组件
// root.render(<Hello />)



/*
抽离组件到独立的JS文件中
*/
// import React from 'react'
// // 导入Hello组件
// import Hello from './01.Hello'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);

// // 导入Hello组件,放在这里会报错，报错为Import in body of module; reorder to top  import /first，意思是应该将该行放在定义之前，向上提。
// // import Hello from './01.Hello'
// // //渲染组件
// root.render(<Hello />)



/*
React事件处理
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);
// class App extends React.Component {
//事件处理程序
//   handleClick() {
//     console.log('单击事件触发了')
//   }
//   render() {
//     return (
//       <button onClick={this.handleClick}>点我，点我</ button>)
//   }
// }

// //通过函数组件绑定事件:
// function App() {
//   //事件处理程序
//   function handleClick() {
//     console.log('函数组件中的事件绑定，事件触发了')
//   }
//   return (
//     <button onClick={handleClick}>点我</button>
//   )
// }
// //渲染组件
// root.render(<App />)



/*
  React事件对象
   可以通过事件处理程序的参数获取到事件对象
   React 中的事件对象叫做：合成事件（对象）
   合成事件：兼容所有浏览器，无需担心跨浏览器兼容性问题

*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container);
// class App extends React.Component {
//   handleClick(e) {
//     //阻止浏览器的默认行为(跳转页面)
//     e.preventDefault()
//     console.log('a标签的单击事件触发了')
//   }
//   I
//   render() {
//     return (
//       <a href="https://www.baidu.com/" onClick={this.handleClick}>百度</a>)
//   }
// }
// //渲染组件
// root.render(<App />)



/*
state的基本使用
  函数组件又叫做无状态组件，类组件又叫做有状态组件
  状态（state）即数据
  函数组件没有自己的状态，只负责数据展示（静）
  类组件有自己的状态，负责更新 UI，让页面“动” 起来
  状态（state）即数据，是组件内部的私有数据，只能在组件内部使用
  state 的值是对象，表示一个组件中可以有多个数据
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 类组件又叫做有状态组件
// class App extends React.Component {
//   // constructor() {
//   //   super()
//   //   // 初始化状态
//   //   this.state = {
//   //     count: 0
//   //   } 
//   // }
//   // 简化语法初始化 state (推荐)
//   state = {
//     count: 0
//   }

//   render() {
//     return (
//       <div>
//         <h1>计数器:{this.state.count}</h1>
//       </div >
//     )
//   }
// }
// //渲染组件
// root.render(<App />)


/*
 state的基本使用
  状态是可变的
  语法：this.setState({ 要修改的数据 }),这里的参数是一个对象，在对象中把要修改的数据放进去就可以了
  注意：不要直接修改 state 中的值，这是错误的！！！
  setState() 作用：1. 修改 state 2. 更新 UI
  思想：数据驱动视图,数据先发生改变，驱动视图发生更新。
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 类组件又叫做有状态组件
// class App extends React.Component {
//   // 可以设置多个状态，要修改哪一个就在 setState 方法中传入哪一个
//   state = {
//     count: 0,
//     test: 'a'
//   }
//   render() {
//     return (
//       <div>
//         <h1>计数器:{this.state.count}</h1>
//         {/* 给按钮添加点击事件，将要修改的参数放在setState方法中，内容为一个对象，在对象中修改参数 */}
//         <button onClick={() => {
//           this.setState({
//             count: this.state.count + 1
//           })
//           //  错误演示！！！
//           //  this.state.count += 1
//         }}>+1</button>
//       </div >
//     )
//   }
// }
// //渲染组件
// root.render(<App />)



// https://www.bilibili.com/video/BV1gh411U7JD?p=32&spm_id_from=pageDriver&vd_source=2cf2d8c4ef52f3ed35a7b03c55495cdf
// 网课地址
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 类组件又叫做有状态组件
// class App extends React.Component {
//   constructor() {
//     super()
//     console.log(this);
//     // 可以设置多个状态，要修改哪一个就在 setState 方法中传入哪一个
//     this.state = {
//       count: 0,
//     }
//     // // 方法二，修改 this.onIncrement 中 this 的指向问题，在 constructor 中的 this 指向该实例化对象
//     // this.onIncrement = this.onIncrement.bind(this)
//   }
//   // //事件处理程序
//   // onIncrement() {
//   //   console.log('事件处理程序中的this:', this) // 如果下面的 button 用第一种方式绑定，则此处的 this 为 undefined，因为下面的点击事件中的 this 不为 App 实例对象
//   //   this.setState({
//   //     count: this.state.count + 1
//   //   })
//   // }

//   // 方法三 使用 class 的实例方法
//   onIncrement = () => {
//     console.log('事件处理程序中的this:', this) //指向 App 的实例对象
//     this.setState({
//       count: this.state.count + 1
//     })
//   }

//   render() {
//     return (
//       <div>
//         <h1>计数器:{this.state.count}</h1>
//         {/* 给按钮添加点击事件，将要修改的参数放在setState方法中，内容为一个对象，在对象中修改参数 */}
//         <button onClick={this.onIncrement}>+1</button>
//         {/* 方法一，使用箭头函数绑定事件，因为箭头函数没有 this，所以此处的 this 会和 render 方法的this一致，也就是 App 的实例对象  */}
//         {/* <button onClick={() => { this.onIncrement() }}>+1</button> */}
//       </div >
//     )
//   }
// }
// //渲染组件
// root.render(<App />)



/*
受控组件: 其值受到React控制的表单元素
操作文本框的值:
1. 在 state 中添加一个状态，作为表单元素的value值（控制表单元素值的来源）
2. 给表单元素绑定 change 事件，将 表单元素的值 设置为 state 的值（控制表单元素值的变化）

*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   state = {
//     txt: ''
//   }
//   handleChange = (e) => {
//     console.log(e);
//     this.setState({
//       txt: e.target.value
//     })
//   }
//   render() {
//     return (
//       <div>
//         <input type="text" value={this.state.txt} onChange={this.handleChange} />
//       </ div>
//     )
//   }
// }
// //渲染组件
// root.render(<App />)





/*
  受控组件示例
  1. 文本框、富文本框、下拉框 操作value属性
  2. 复选框 操作checked属性

*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   state = {
//     txt: '',
//     content: '',
//     city: 'bj',
//     isChecked: false
//   }

//   handleChange = e => {
//     console.log(e);
//     this.setState({
//       txt: e.target.value
//     })
//   }

//   // 处理富文本框的变化
//   handleContent = e => {
//     console.log(e);
//     this.setState({
//       content: e.target.value
//     })
//   }

//   // 处理下拉框的变化
//   handleCity = e => {
//     console.log(e);
//     this.setState({
//       city: e.target.value
//     })
//   }

//   // 处理复选框的变化
//   handleChecked = e => {
//     console.log(e);
//     this.setState({
//       isChecked: e.target.checked
//     })
//   }

//   render() {
//     return (
//       <div>
//         {/* 文本框 */}
//         <input type="text" value={this.state.txt} onChange={this.handleChange} />
//         <br />

//         {/* 富文本框 */}
//         <textarea value={this.state.content} onChange={this.handleContent}></textarea>
//         <br />

//         {/* 下拉框 */}
//         <select value={this.state.city} onChange={this.handleCity}>
//           <option value="sh">上海</option>
//           <option value="bj">北京</option>
//           <option value="gz">广州</option>
//         </select>
//         <br />

//         {/* 复选框 */}
//         <input type="checkbox" checked={this.state.isChecked} onChange={this.handleChecked} />
//       </div>
//     )
//   }
// }

// // 渲染组件
// root.render(<App />)



/*
  受控组件优化示例
  1. 给表单元素添加name属性，名称与 state 相同
  2. 根据表单元素类型获取对应值
  3. 在 change 事件处理程序中通过 [name] 来修改对应的state
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   state = {
//     txt: '',
//     content: '',
//     city: 'bj',
//     isChecked: false
//   }

//   handleForm = e => {
//     console.log(e);
//     // 获取当前DOM对象
//     const target = e.target

//     // 根据类型获取值
//     const value = target.type === 'checkbox'
//       ? target.checked
//       : target.value

//     // 获取name
//     const name = target.name

//     this.setState({
//       [name]: value
//     })
//   }

//   render() {
//     return (
//       <div>
//         {/* 文本框 */}
//         <input type="text" name="txt" value={this.state.txt} onChange={this.handleForm} />
//         <br />

//         {/* 富文本框 */}
//         <textarea name="content" value={this.state.content} onChange={this.handleForm}>hhh</textarea>
//         <br />

//         {/* 下拉框 */}
//         <select name="city" value={this.state.city} onChange={this.handleForm}>
//           <option value="sh">上海</option>
//           <option value="bj">北京</option>
//           <option value="gz">广州</option>
//         </select>
//         <br />

//         {/* 复选框 */}
//         <input type="checkbox" name="isChecked" checked={this.state.isChecked} onChange={this.handleForm} />
//       </div>
//     )
//   }
// }

// // 渲染组件
// root.render(<App />)



/*
  非受控组件：
   说明：借助于 ref，使用原生 DOM 方式来获取表单元素值
   ref 的作用：获取 DOM 或组件
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   constructor() {
//     super()
//     // 创建ref
//     this.txtRef = React.createRef()
//   }
//   // 获取文本框的值
//   getTxt = () => {
//     console.log('文本框值为：', this.txtRef.current.value, this.txtRef);
//   }
//   render() {
//     return (
//       <div>
//         <input type="text" ref={this.txtRef} />
//         <button onClick={this.getTxt}>获取文本框的值</button>
//       </div>
//     )
//   }
// }
// // 渲染组件
// root.render(<App />)



/*
  评论列表案例
  comments: [
    { id: 1, name: 'jack', content: '沙发！！！' },
    { id: 2, name: 'rose', content: '板凳~' },
    { id: 3, name: 'tom', content: '楼主好人' }
  ]
*/

// import './index.css'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   state = {
//     comments: [
//       { id: 1, name: 'jack', content: '沙发！！！' },
//       { id: 2, name: 'rose', content: '板凳~' },
//       { id: 3, name: 'tom', content: '楼主好人' }
//     ],
//     userName: '',
//     userContent: ''
//   }
//   renderList() {
//     // 写成 if else 语句也可以，加上解构语法。
//     const { comments } = this.state
//     if (comments.length === 0) {
//       return (<div className="no-comment">暂无评论，快去评论吧~</div>)
//     }
//     return (<ul>
//       {comments.map(item => (
//         <li key={item.id}>
//           <h3>评论人：{item.name}</h3>
//           <p>评论内容：{item.content}</p>
//         </li>
//       ))}
//     </ul>
//     )
//     // return (
//     //   this.state.comments.length === 0
//     //     ? (<div className="no-comment">暂无评论，快去评论吧~</div>)
//     //     : (
//     //       <ul>
//     //         {this.state.comments.map(item => (
//     //           <li key={item.id}>
//     //             <h3>评论人：{item.name}</h3>
//     //             <p>评论内容：{item.content}</p>
//     //           </li>
//     //         ))}
//     //       </ul>
//     //     )
//     // )
//   }
//   // 用箭头函数，可以不用考虑 this 的指向问题
//   handleForm = (e) => {
//     // console.log(e);
//     const { name, value } = e.target
//     this.setState({
//       [name]: value
//     })
//   }
//   addComment = (e) => {
//     console.log(e);
//     const { comments, userContent, userName } = this.state
//     //非空校验
//     if (userName.trim() === "" || userContent.trim() === "") {
//       alert('请输入评论人和评论内容')
//       return
//     }

//     const newComments = [
//       // 插入到原本 comments 的数组最前面
//       {
//         id: Math.random(),
//         name: userName,
//         content: userContent
//       },
//       // 原本的 comments 内容，三个点语法展开
//       ...comments
//     ]
//     this.setState({
//       comments: newComments,
//       // 输入后清空文本框只需要将对应的 state 设置为空就可以了
//       userName: '',
//       userContent: ''
//     })
//   }
//   render() {
//     // 解构语法
//     const { userName, userContent } = this.state
//     return (
//       <div className="app">
//         <div>
//           <input
//             className="user"
//             type="text"
//             placeholder="请输入评论人"
//             value={userName}
//             name="userName"
//             onChange={this.handleForm} />
//           <br />
//           <textarea
//             className="content"
//             cols="30"
//             rows="10"
//             placeholder="请输入评论内容"
//             value={userContent}
//             name="userContent"
//             onChange={this.handleForm}
//           />
//           <br />
//           <button onClick={this.addComment}>发表评论</button>
//         </div>
//         {/* 通过条件判断决定渲染什么内容，没有评论则渲染暂无评论，有评论则渲染出来 */}
//         {/* {
//           this.state.comments.length === 0
//             ? (<div className="no-comment">暂无评论，快去评论吧~</div>)
//             : (
//               <ul>
//                 {this.state.comments.map(item => (
//                   <li key={item.id}>
//                     <h3>评论人：{item.name}</h3>
//                     <p>评论内容：{item.content}</p>
//                   </li>
//                 ))}
//               </ul>
//             )
//         } */}
//         {/* 将代码直接放在JSX中导致结构混乱，可以将代码写在函数中，从结构中抽离出来 */}
//         {this.renderList()}

//       </div>
//     )
//   }
// }

// // 渲染组件
// root.render(<App />)





/*
props
 组件是封闭的，要接收外部数据应该通过 props 来实现
 props的作用：接收传递给组件的数据
 传递数据：给组件标签添加属性
 接收数据：函数组件通过参数props接收数据，类组件通过 this.props 接收数据
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 2 组件通过 this.props 接收数据
// class Hello extends React.Component {
//   render() {
//     console.log(this.props)
//     return (
//       <div>
//         <h1>props: {this.props.age}</h1>
//       </div>
//     )
//   }
// }

// // 1 传递数据
// root.render(<Hello name="rose" age={19} />)


// // 2 函数通过 props 接收数据
// const Hello = props => {
//   // props是一个对象
//   console.log(props)
//   return (
//     <div>
//       <h1>props：{props.name}</h1>
//     </div>
//   )
// }

// // 1 传递数据
// root.render(<Hello name="jack" age={19} />)





/*
  props
    <Hello 属性值可以添加字符串，数字和方法，但是除了字符串之外的属性值要使用大括号添加内容 />
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 类组件：
// class Hello extends React.Component {
//   // 推荐使用props作为constructor的参数！！
//   constructor(props) {
//     super(props)
//     // console.log(this.props)
//     console.log(props)
//   }
//   render() {
//     console.log('render：', this.props)
//     return (
//       <div>
//         <h1>props：</h1>
//       </div>
//     )
//   }
// }
// /* 
// const Hello = props => {
//   console.log('props：', props)
//   props.fn()

//   // 修改props的值：错误演示！！！
//   // props.name = 'tom'

//   return (
//     <div>
//       <h1>props：</h1>
//       {props.tag}
//     </div>
//   )
// }
//  */
// root.render(
//   <Hello
//     name="rose"
//     age={19}
//     colors={['red', 'green', 'blue']}
//     fn={() => console.log('这是一个函数')}
//     tag={<p>这是一个p标签</p>}
//   />
// )







/*
props
  父组件向子组件传递信息
  1. 父组件提供要传递的state数据
  2. 给子组件标签添加属性，值为 state 中的数据
  3. 子组件中通过 props 接收父组件中传递的数据

*/
// import './css/02.css'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 父组件
// class Parent extends React.Component {
//   state = {
//     lastName: '王'
//   }
//   render() {
//     return (
//       <div className="parent">
//         父组件：
//         <Child name={this.state.lastName} />
//       </div>
//     )
//   }
// }

// // 子组件
// const Child = props => {
//   console.log('子组件：', props)
//   return (
//     <div className="child">
//       <p>子组件，接收到父组件的数据：{props.name}</p>
//     </div>
//   )
// }

// root.render(<Parent />)




/*
props
思路：利用回调函数，父组件提供回调，子组件调用，将要传递的数据作为回调函数的参数。
  1. 父组件提供一个回调函数（用于接收数据）
  2. 将该函数作为属性的值，传递给子组件
  3. 子组件通过 props 调用回调函数
  4. 将子组件的数据作为参数传递给回调函数

*/
// import './css/02.css'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 父组件
// class Parent extends React.Component {
//   state = {
//     parentMsg: ''
//   }
//   // 提供回调函数，用来接收数据
//   getChildMsg = data => {
//     console.log('接收到子组件中传递过来的数据：', data)
//     this.setState({
//       parentMsg: data
//     })
//   }
//   render() {
//     return (
//       <div className="parent">
//         父组件：{this.state.parentMsg}
//         <Child getMsg={this.getChildMsg} />
//       </div>
//     )
//   }
// }

// // 子组件
// class Child extends React.Component {
//   state = {
//     msg: '刷抖音'
//   }

//   handleClick = () => {
//     console.log(this);
//     // 子组件调用父组件中传递过来的回调函数
//     this.props.getMsg(this.state.msg)
//   }

//   render() {
//     return (
//       <div className="child">
//         子组件：{' '}
//         <button onClick={this.handleClick}>点我，给父组件传递数据</button>
//       </div>
//     )
//   }
// }

// root.render(<Parent />)




/*
  兄弟组件通讯
    将共享状态提升到最近的公共父组件中，由公共父组件管理这个状态
    思想：状态提升
    公共父组件职责：1. 提供共享状态 2. 提供操作共享状态的方法
    要通讯的子组件只需通过 props 接收状态或操作状态的方法

    一个子组件将数据传递给父组件，再由父组件将数据传递给另一个组件。
        1 在父组件中，为一个子组件传递方法，并绑定父组件
        2 在子组件中，执行方法，并传递子组件中的数据
        3 在父组件中，接收数据，并更新状态
        4 在父组件中，将新的状态数据，传递给另一个子组件。
*/

// import './css/02.css'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 父组件
// class Counter extends React.Component {
//   // 提供共享状态
//   state = {
//     count: 0
//   }

//   // 提供修改状态的方法
//   onIncrement = () => {
//     this.setState({
//       count: this.state.count + 1
//     })
//   }

//   render() {
//     return (
//       <div>
//         <Child1 count={this.state.count} />
//         <Child2 onIncrement={this.onIncrement} />
//       </div>
//     )
//   }
// }

// const Child1 = props => {
//   return <h1>计数器：{props.count}</h1>
// }

// const Child2 = props => {
//   return <button onClick={() => props.onIncrement()}>+1</button>
//   // return <button onClick={props.onIncrement}>+1</button>
// }

// root.render(<Counter />)




/*
多个组件嵌套，如何将爷爷的爷组件传递给孙子的孙组件？
使用Context，Context提供了两个组件：Provider 和 Consumer
    Provider组件：用来提供数据
    Consumer组件：用来消费数据
  作用：跨组件传递数据（比如：主题、语言等）
做法：
  1.调用 React. createContext() 创建 Provider（提供数据） 和 Consumer（消费数据） 两个组件。
  2.使用 Provider 组件作为父节点。
  3.设置 value 属性，表示要传递的数据。
  4.调用 Consumer 组件接收数据。
*/

// import './css/03.css'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 创建context得到两个组件
// const { Provider, Consumer } = React.createContext()

// class App extends React.Component {
//   render() {
//     return (
//       <Provider value="pink">
//         <div className="app">
//           <Node />
//         </div>
//       </Provider>
//     )
//   }
// }

// const Node = props => {
//   return (
//     <div className="node">
//       <SubNode />
//     </div>
//   )
// }

// const SubNode = props => {
//   return (
//     <div className="subnode">
//       <Child />
//     </div>
//   )
// }

// const Child = props => {
//   return (
//     <div className="child">
//       <Consumer>{data => <span>我是子节点 -- {data}</span>}</Consumer>
//     </div>
//   )
// }

// root.render(<App />)




/*
  children 属性
   children 属性：表示组件标签的子节点。当组件标签有子节点时，props 就会有该属性
   children 属性与普通的props一样，值可以是任意值（文本、React元素、组件，甚至是函数）

*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 组件标签内的子节点可以是任意类型，下面是子节点为函数的示例
// const App = props => {
//   console.log(props)
//   props.children()
//   return (
//     <div>
//       <h1>组件标签的子节点：</h1>
//     </div>
//   )
// }
// root.render(<App>{() => console.log('这是一个函数子节点')}</App>)

// // 组件标签内的子节点可以是任意类型，下面是子节点为组件的示例
// // children为：jsx或组件
// const Test = () => <button>我是button组件</button>
// const App = props => {
//   console.log(props)
//   return (
//     <div>
//       <h1>组件标签的子节点：</h1>
//       {props.children}
//     </div>
//   )
// }
// root.render(<App><Test /></App>)

// // 组件标签内的子节点可以是任意类型，下面是子节点为文本的示例
// // children为：文本节点
// const App = props => {
//   console.log(props)
//   return (
//     <div>
//       <h1>组件标签的子节点：</h1>
//       {props.children}
//     </div>
//   )
// }

// root.render(<App>我是子节点</App>)




/*
  props校验
    对于组件来说，props 是外来的，无法保证组件使用者传入什么格式的数据
    如果传入的数据格式不对，可能会导致组件内部报错
    关键问题：组件的使用者不知道明确的错误原因
    props 校验：允许在创建组件的时候，就指定 props 的类型、格式等
    作用：捕获使用组件时因为props导致的错误，给出明确的错误提示，增加组件的健壮性
  使用步骤
    1. 安装包 prop-types （yarn add prop-types / npm i props-types）
    2. 导入 prop-types 包
    3. 使用组件名.propTypes = {} 来给组件的props添加校验规则
    4. 校验规则通过 PropTypes 对象来指定

*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// // 引入校验模块
// import PropTypes from 'prop-types'
// const container = document.getElementById('root')
// const root = createRoot(container)
// const App = props => {
//   const arr = props.colors
//   // 这里的 Index 是否有值？ 
//   const lis = arr.map((item, index) => <li key={index}>{item}</li>)

//   return <ul>{lis}</ul>
// }

// // 添加props校验
// App.propTypes = {
//   // 设置校验属性，colors 的属性值必须为数组格式
//   // 如果类型不对，则报出明确错误，便于分析错误原因
//   colors: PropTypes.array
// }

// root.render(<App colors={['red', 'blue']} />)




/*
  props校验
  约束规则
    1. 常见类型：array、bool、func、number、object、string
    2. React元素类型：element
    3. 必填项：isRequired
    4. 特定结构的对象：shape({ })
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// import PropTypes from 'prop-types'
// const container = document.getElementById('root')
// const root = createRoot(container)
// const App = props => {
//   return (
//     <div>
//       <h1>props校验：</h1>
//     </div>
//   )
// }

// // 添加props校验
// App.propTypes = {
//   // 属性 a 的类型：      数值（number）
//   a: PropTypes.number,
//   // 属性 fn 的类型：     函数（func）并且为必填项
//   fn: PropTypes.func.isRequired,
//   // 属性 tag 的类型：    React元素（element）
//   tag: PropTypes.element,
//   // 属性 filter 的类型： 对象（{area: '上海', price: 1999}）
//   filter: PropTypes.shape({
//     area: PropTypes.string,
//     price: PropTypes.number
//   })
// }

// root.render(<App fn={() => { }} />)



/*
  props的默认值
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// const App = props => {
//   console.log(props)
//   return (
//     <div>
//       <h1>此处展示props的默认值:{props.pagesize}</h1></div>
//   )
// }
// // 添加 props 默认值,当组件内不添加属性时，则使用默认值，当传入属性时，则使用传入的值
// App.defaultProps = {
//   pagesize: 10
// }
// // 这里传入 pagesize 的值为 20 ，则会使用传入的值
// root.render(<App pagesize={20} />)





/*
  组件生命周期
   意义：组件的生命周期有助于理解组件的运行方式、完成更复杂的组件功能、分析组件错误原因等
   组件的生命周期：组件从被创建到挂载到页面中运行，再到组件不用时卸载的过程
   生命周期的每个阶段总是伴随着一些方法调用，这些方法就是生命周期的钩子函数。
   钩子函数的作用：为开发人员在不同阶段操作组件提供了时机。
   只有 类组件 才有生命周期。

   创建期的三个钩子函数执行的顺序
    1.constructor
    2.render
    3.componentDidMount

*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   constructor(props) {
//     super(props)
//     // 初始化state
//     this.state = {
//       count: 0
//     }
//     // constructor 内可以处理this指向问题
//     console.warn('生命周期钩子函数： constructor')
//   }

//   componentDidMount() {
//     // 作用
//     // 1 进行DOM操作
//     // 2 发送ajax请求，获取远程数据
//     // axios.get('http://api.....')
//     // 下面的输出可以拿到 title 的值，其他阶段不行
//     // const title = document.getElementById('title')
//     // console.log(title)
//     console.warn('生命周期钩子函数： componentDidMount')
//   }

//   render() {
//     // 错误演示！！！ 不要在render中调用setState()，否则会导致递归
//     // this.setState({
//     //   count: 1
//     // })
//     console.warn('生命周期钩子函数： render')

//     return (
//       <div>
//         <h1 id="title">统计豆豆被打的次数：</h1>
//         <button id="btn">打豆豆</button>
//       </div>
//     )
//   }
// }

// root.render(<App />)




/*
  组件生命周期
  更新期会导致页面重新渲染的三种方式，即导致执行render方法的三种方式
    1.传入新的 props 值
    2.执行 setState 方法
    3.使用 forceUpdate 方法强制
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   constructor(props) {
//     super(props)
//     // 初始化state
//     this.state = {
//       count: 0
//     }
//   }

//   // 打豆豆
//   handleClick = () => {
//     this.setState({
//       count: this.state.count + 1
//     })

//     // 上面的 setState 注释掉再演示强制更新：
//     // this.forceUpdate()
//   }

//   render() {
//     console.warn('生命周期钩子函数： render')
//     return (
//       <div>
//         <Counter count={this.state.count} />
//         <button onClick={this.handleClick}>打豆豆</button>
//       </div>
//     )
//   }
// }

// class Counter extends React.Component {
//   render() {
//     console.warn('--子组件--生命周期钩子函数： render')
//     return <h1>统计豆豆被打的次数：{this.props.count}</h1>
//   }
// }

// root.render(<App />)





/*
  组件生命周期
  更新期（存在期）的执行顺序
    1. render
    2. componentDidMount
     componentDidMount的作用
      1 发送网络请求
      2 DOM操作
      注意：如果要setState() 必须放在一个if条件中
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   constructor(props) {
//     super(props)
//     // 初始化state
//     this.state = {
//       count: 0
//     }
//   }
//   // 打豆豆
//   handleClick = () => {
//     this.setState({
//       count: this.state.count + 1
//     })
//   }

//   render() {
//     console.warn('生命周期钩子函数： render')
//     return (
//       <div>
//         <Counter count={this.state.count} />
//         <button onClick={this.handleClick}>打豆豆</button>
//       </div>
//     )
//   }
// }

// class Counter extends React.Component {
//   render() {
//     console.warn('--子组件--生命周期钩子函数： render')
//     return <h1>统计豆豆被打的次数：{this.props.count}</h1>
//   }
//   // 注意：如果要调用 setState() 更新状态，必须要放在一个 if 条件中
//   // 因为：如果直接调用 setState() 更新状态，也会导致递归更新！！！
//   componentDidUpdate(prevProps) {
//     console.warn('--子组件--生命周期钩子函数： componentDidUpdate')

//     // 正确做法：
//     // 做法：比较更新前后的props是否相同，来决定是否重新渲染组件
//     console.log('上一次的props：', prevProps, ', 当前的props：', this.props)
//     if (prevProps.count !== this.props.count) {
//       // this.setState({})
//       // 作用1.发送ajax请求的代码
//     }

//     // 错误演示！！！
//     // this.setState({})

//     // 作用2.获取DOM，可以获得已经修改并渲染到页面的元素，证明 render 在 componentDidMount 之前
//     // const title = document.getElementById('title')
//     // console.log(title.innerHTML)
//   }
// }
// root.render(<App />)




/*
  组件生命周期
  销毁期
  执行顺序
    1.render
    2.componentWillUnmount
      钩子函数：componentWillUnmount
      触发时机：组件卸载（从页面中消失）
      作用：执行清理工作（比如：清理定时器等）
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   constructor(props) {
//     super(props)

//     // 初始化state
//     this.state = {
//       count: 0
//     }
//   }

//   // 打豆豆
//   handleClick = () => {
//     this.setState({
//       count: this.state.count + 1
//     })
//   }

//   render() {
//     return (
//       <div>
//         {/* 判断次数，超过3次则销毁该组件，销毁后会触发 componentWillUnmount() 方法*/}
//         {this.state.count > 3 ? (
//           <p>豆豆被打死了~</p>
//         ) : (
//           <Counter count={this.state.count} />
//         )}
//         <button onClick={this.handleClick}>打豆豆</button>
//       </div>
//     )
//   }
// }

// class Counter extends React.Component {
//   componentDidMount() {
//     // 在组件创建期时开启了定时器，组件销毁后定时器也应该被清理掉，否则会导致内存泄漏
//     this.timerId = setInterval(() => {
//       console.log('定时器正在执行~')
//     }, 500)
//   }

//   render() {
//     return <h1>统计豆豆被打的次数：{this.props.count}</h1>
//   }

//   componentWillUnmount() {
//     console.warn('生命周期钩子函数： componentWillUnmount')

//     // 清理定时器，组件销毁后会自动触发该钩子函数，所以在此将定时器清理掉
//     clearInterval(this.timerId)
//   }
// }

// root.render(<App />)




/*
处理方式：复用相似的功能（联想函数封装）
复用什么？1. state 2. 操作state的方法 （组件状态逻辑 ）
两种方式：1. render props模式 2. 高阶组件（HOC）
注意：这两种方式不是新的API，而是利用React自身特点的编码技巧，演化而成的固定模式（写法）

render props 模式
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 创建Mouse组件
// class Mouse extends React.Component {
//   // 鼠标位置state
//   state = {
//     x: 0,
//     y: 0
//   }

//   // 鼠标移动事件的事件处理程序
//   handleMouseMove = e => {
//     this.setState({
//       x: e.clientX,
//       y: e.clientY
//     })
//   }

//   // 监听鼠标移动事件
//   componentDidMount() {
//     window.addEventListener('mousemove', this.handleMouseMove)
//   }

//   render() {
//     // return null
//     // 接到 App 组件传过来的 fnRender 函数，在 this.props 上，将自己的状态当成参数传到函数里。
//     return this.props.fnRender(this.state)
//   }
// }

// class App extends React.Component {
//   render() {
//     return (
//       <div>
//         <h1>render props 模式</h1>
//         <Mouse
//           fnRender={mouse => {
//             return (
//               <p>
//                 鼠标位置：X {mouse.x}，Y {mouse.y}
//               </p>
//             )
//           }}
//         />
//       </div>
//     )
//   }
// }

// root.render(<App />)






/*
  render props 模式
  1. 创建Mouse组件，在组件中提供复用的状态逻辑代码（1. 状态 2. 操作状态的方法）
  2. 将要复用的状态作为 props.render(state) 方法的参数，暴露到组件外部
  3. 使用 props.fnRender() 的返回值作为要渲染的内容

  Mouse组件的复用
    Mouse组件负责：封装复用的状态逻辑代码（1. 状态 2. 操作状态的方法）
    状态：鼠标坐标（x, y）
    操作状态的方法：鼠标移动事件
    传入的render prop负责：使用复用的状态来渲染UI结构

  实际上就是将函数的功能写在单独的组件中，而把 UI 渲染的功能写在 App 组件中，实现功能的复用。
*/

// // 导入图片资源
// import img from './images/cat.png'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)

// // 作用：鼠标位置复用
// class Mouse extends React.Component {
//   // 鼠标位置state
//   state = {
//     x: 0,
//     y: 0
//   }

//   // 鼠标移动事件的事件处理程序
//   handleMouseMove = e => {
//     this.setState({
//       x: e.clientX,
//       y: e.clientY
//     })
//   }

//   // 监听鼠标移动事件
//   componentDidMount() {
//     window.addEventListener('mousemove', this.handleMouseMove)
//   }

//   render() {
//     return this.props.render(this.state)
//   }
// }

// class App extends React.Component {
//   render() {
//     return (
//       <div>
//         <h1>render props 模式</h1>
//         <Mouse
//           render={mouse => {
//             return (
//               <p>
//                 鼠标位置：{mouse.x} {mouse.y}
//               </p>
//             )
//           }}
//         />

//         {/* 猫捉老鼠 */}
//         <Mouse
//           render={mouse => {
//             return (
//               <img
//                 src={img}
//                 alt="猫"
//                 style={{
//                   position: 'absolute',
//                   top: mouse.y - 64,
//                   left: mouse.x - 64
//                 }}
//               />
//             )
//           }}
//         />
//       </div>
//     )
//   }
// }

// root.render(<App />)



/*
render props 模式
推荐：使用 children 代替 render 属性
效果相同，但更容易理解，将结构当做组件的子节点挂载在 props.children 上
*/
// 导入图片资源
// import img from './images/cat.png'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)

// // 作用：鼠标位置复用
// class Mouse extends React.Component {
//   // 鼠标位置state
//   state = {
//     x: 0,
//     y: 0
//   }

//   // 鼠标移动事件的事件处理程序
//   handleMouseMove = e => {
//     this.setState({
//       x: e.clientX,
//       y: e.clientY
//     })
//   }

//   // 监听鼠标移动事件
//   componentDidMount() {
//     window.addEventListener('mousemove', this.handleMouseMove)
//   }

//   render() {
//     return this.props.children(this.state)
//   }
// }

// class App extends React.Component {
//   render() {
//     return (
//       <div>
//         <h1>render props 模式</h1>
//         <Mouse>
//           {mouse => {
//             return (
//               <p>
//                 鼠标位置：X {mouse.x}， Y {mouse.y}
//               </p>
//             )
//           }}
//         </Mouse>

//         <Mouse>
//           {mouse => (
//             <img
//               src={img}
//               alt="猫"
//               style={{
//                 position: 'absolute',
//                 top: mouse.y - 64,
//                 left: mouse.x - 64
//               }}
//             />
//           )}
//         </Mouse>
//       </div>
//     )
//   }
// }

// root.render(<App />)




/*
代码优化
1. 推荐：给 render props 模式添加 props校验
2. 应该在组件卸载时解除 mousemove 事件绑定
*/

// import img from './images/cat.png'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// import PropTypes from 'prop-types'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 作用：鼠标位置复用
// class Mouse extends React.Component {
//   // 鼠标位置state
//   state = {
//     x: 0,
//     y: 0
//   }

//   // 鼠标移动事件的事件处理程序
//   handleMouseMove = e => {
//     this.setState({
//       x: e.clientX,
//       y: e.clientY
//     })
//   }

//   // 监听鼠标移动事件
//   componentDidMount() {
//     window.addEventListener('mousemove', this.handleMouseMove)
//   }
//   // 推荐：在组件卸载时移除事件绑定
//   componentWillUnmount() {
//     window.removeEventListener('mousemove', this.handleMouseMove)
//   }
//   render() {
//     return this.props.children(this.state)
//   }
// }
// // 添加props校验
// Mouse.propTypes = {
//   children: PropTypes.func.isRequired
// }

// class App extends React.Component {
//   render() {
//     return (
//       <div>
//         <h1>render props 模式</h1>
//         <Mouse>
//           {mouse => {
//             return (
//               <p>
//                 鼠标位置：X {mouse.x}， Y {mouse.y}
//               </p>
//             )
//           }}
//         </Mouse>

//         <Mouse>
//           {mouse => (
//             <img
//               src={img}
//               alt="猫"
//               style={{
//                 position: 'absolute',
//                 top: mouse.y - 64,
//                 left: mouse.x - 64
//               }}
//             />
//           )}
//         </Mouse>
//       </div>
//     )
//   }
// }

// root.render(<App />)





/*
  高阶组件
    高阶组件就相当于手机壳，通过包装组件，增强组件功能
    高阶组件（HOC，Higher-Order Component）是一个函数，接收要包装的组件，返回增强后的组件
    高阶组件内部创建一个类组件，在这个类组件中提供复用的状态逻辑代码，通过prop将复用的状态传递给被包装组件 WrappedComponent
  目的：实现状态逻辑复用
    采用 包装（装饰）模式 ，比如说：手机壳
    手机：获取保护功能
    手机壳 ：提供保护功能
  使用步骤
    1. 创建一个函数，名称约定以 with 开头
    2. 指定函数参数，参数应该以大写字母开头（因为要作为要渲染的组件）
    3. 在函数内部创建一个类组件，提供复用的状态逻辑代码，并返回
    4. 在该组件中，渲染参数组件，同时将状态通过prop传递给参数组件
    5. 调用该高阶组件，传入要增强的组件，通过返回值拿到增强后的组件，并将其渲染到页面中

*/
// import img from './images/cat.png'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 创建高阶组件,约定命名以 with 开头
// function withMouse(WrappedComponent) {
//   // 该组件提供复用的状态逻辑
//   class Mouse extends React.Component {
//     // 鼠标状态
//     state = {
//       x: 0,
//       y: 0
//     }
//     handleMouseMove = e => {
//       this.setState({
//         x: e.clientX,
//         y: e.clientY
//       })
//     }

//     // 控制鼠标状态的逻辑
//     componentDidMount() {
//       window.addEventListener('mousemove', this.handleMouseMove)
//     }

//     componentWillUnmount() {
//       window.removeEventListener('mousemove', this.handleMouseMove)
//     }

//     render() {
//       return <WrappedComponent {...this.state} />
//     }
//   }

//   return Mouse
// }

// // 这是一个函数组件，这里的 props 接收的是上面 {...this.state} 中的值
// const Position = props => (
//   <p>
//     鼠标当前位置：(x: {props.x}, y: {props.y})
//   </p>
// )
// // 获取增强后的组件,MousePosition 得到的是调用高阶组件的返回值，也就是 Mouse
// const MousePosition = withMouse(Position)

// // 猫捉老鼠的组件，这里的 props 接收的是上面 {...this.state} 中的值
// const Cat = props => (
//   <img
//     src={img}
//     alt=""
//     style={{
//       position: 'absolute',
//       top: props.y - 64,
//       left: props.x - 64
//     }}
//   />
// )
// // 调用高阶组件来增强猫捉老鼠的组件，MouseCat 得到的是调用高阶组件的返回值，也就是 Mouse
// const MouseCat = withMouse(Cat)

// class App extends React.Component {
//   render() {
//     return (
//       <div>
//         <h1>高阶组件</h1>
//         {/* 渲染增强后的组件 */}
//         <MousePosition />
//         <MouseCat />
//       </div>
//     )
//   }
// }
// root.render(<App />)



/*
设置displayName
   使用高阶组件存在的问题：得到的两个组件名称相同
   原因：默认情况下，React使用组件名称作为 displayName
   解决方式：为 高阶组件 设置 displayName 便于调试时区分不同的组件
   displayName的作用：用于设置调试信息（React Developer Tools信息）
*/
// import img from './images/cat.png'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 创建高阶组件,约定命名以 with 开头
// function withMouse(WrappedComponent) {
//   // 该组件提供复用的状态逻辑
//   class Mouse extends React.Component {
//     // 鼠标状态
//     state = {
//       x: 0,
//       y: 0
//     }
//     handleMouseMove = e => {
//       this.setState({
//         x: e.clientX,
//         y: e.clientY
//       })
//     }

//     // 控制鼠标状态的逻辑
//     componentDidMount() {
//       window.addEventListener('mousemove', this.handleMouseMove)
//     }

//     componentWillUnmount() {
//       window.removeEventListener('mousemove', this.handleMouseMove)
//     }

//     render() {
//       return <WrappedComponent {...this.state} />
//     }
//   }
//   // 设置displayName，如果不设置，则调用该高阶组件的函数组件在 React Developer Tools 中都名为 Mouse
//   Mouse.displayName = `WithMouse${getDisplayName(WrappedComponent)}`

//   return Mouse
// }

// function getDisplayName(WrappedComponent) {
//   return WrappedComponent.displayName || WrappedComponent.name || 'Component'
// }

// // 这是一个函数组件，这里的 props 接收的是上面 {...this.state} 中的值
// const Position = props => (
//   <p>
//     鼠标当前位置：(x: {props.x}, y: {props.y})
//   </p>
// )
// // 获取增强后的组件,MousePosition 得到的是调用高阶组件的返回值，也就是 Mouse
// const MousePosition = withMouse(Position)

// // 猫捉老鼠的组件，这里的 props 接收的是上面 {...this.state} 中的值
// const Cat = props => (
//   <img
//     src={img}
//     alt=""
//     style={{
//       position: 'absolute',
//       top: props.y - 64,
//       left: props.x - 64
//     }}
//   />
// )
// // 调用高阶组件来增强猫捉老鼠的组件，MouseCat 得到的是调用高阶组件的返回值，也就是 Mouse
// const MouseCat = withMouse(Cat)

// class App extends React.Component {
//   render() {
//     return (
//       <div>
//         <h1>高阶组件</h1>
//         {/* 渲染增强后的组件 */}
//         <MousePosition />
//         <MouseCat />
//       </div>
//     )
//   }
// }
// root.render(<App />)



/*
  高阶组件
    问题：App中组件传入内容，但经过高阶组件返回后的组件上 props 丢失
    原因：高阶组件并没有往下传递props
    解决方式：渲染 WrappedComponent 时，将 state 和 this.props 一起传递给组件
*/
// import img from './images/cat.png'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 创建高阶组件,约定命名以 with 开头
// function withMouse(WrappedComponent) {
//   // 该组件提供复用的状态逻辑
//   class Mouse extends React.Component {
//     // 鼠标状态
//     state = {
//       x: 0,
//       y: 0
//     }
//     handleMouseMove = e => {
//       this.setState({
//         x: e.clientX,
//         y: e.clientY
//       })
//     }

//     // 控制鼠标状态的逻辑
//     componentDidMount() {
//       window.addEventListener('mousemove', this.handleMouseMove)
//     }

//     componentWillUnmount() {
//       window.removeEventListener('mousemove', this.handleMouseMove)
//     }

//     render() {
//       console.log('Mouse:', this.props)
//       // 将组件中传入的属性数据经过高阶组件之后，继续传给调用该高阶组件的函数组件，这些属性数据会挂载在函数组件的 props 属性上。
//       return <WrappedComponent {...this.state} {...this.props} />
//     }
//   }
//   // 设置displayName，如果不设置，则调用该高阶组件的函数组件在 React Developer Tools 中都名为 Mouse
//   Mouse.displayName = `WithMouse${getDisplayName(WrappedComponent)}`

//   return Mouse
// }

// function getDisplayName(WrappedComponent) {
//   return WrappedComponent.displayName || WrappedComponent.name || 'Component'
// }

// // 这是一个函数组件，这里的 props 接收的是上面 {...this.state} {...this.props} 中的值
// const Position = props => {
//   console.log('Position:', props)
//   return (
//     <p>
//       鼠标当前位置：(x: {props.x}, y: {props.y})
//     </p>
//   )
// }
// // 获取增强后的组件,MousePosition 得到的是调用高阶组件的返回值，也就是 Mouse
// const MousePosition = withMouse(Position)

// // 猫捉老鼠的组件，这里的 props 接收的是上面 {...this.state} {...this.props} 中的值
// const Cat = props => {
//   console.log('Cat:', props)
//   return (
//     <img
//       src={img}
//       alt=""
//       style={{
//         position: 'absolute',
//         top: props.y - 64,
//         left: props.x - 64
//       }}
//     />
//   )
// }
// // 调用高阶组件来增强猫捉老鼠的组件，MouseCat 得到的是调用高阶组件的返回值，也就是 Mouse
// const MouseCat = withMouse(Cat)

// class App extends React.Component {
//   render() {
//     return (
//       <div>
//         <h1>高阶组件</h1>
//         {/* 渲染增强后的组件 */}
//         <MousePosition a="1" />
//         <MouseCat b="2" />
//       </div>
//     )
//   }
// }
// root.render(<App />)







/*
  setState() 是异步更新数据
  注意：使用该语法时，后面的 setState() 不要依赖于前面的 setState()
  可以多次调用 setState() ，只会触发一次重新渲染

*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   state = {
//     count: 1
//   }
//   // React 官方文档这部分说明的地址： https://reactjs.org/docs/faq-state.html#what-does-setstate-do
//   handleClick = () => {
//     // 此处，更新state
//     // 注意：异步更新数据的！！！ 传对象的形式拿不到上一次的 state ，官方文档中如此定义的。
//     // this.setState({
//     //   count: this.state.count + 1 // 1 + 1
//     // })
//     // console.log('count：', this.state.count) // 1
//     // this.setState({
//     //   count: this.state.count + 1 // 1 + 1
//     // })
//     // console.log('count：', this.state.count) // 1

//     // 推荐语法：
//     // 注意：这种语法也是异步更新state的！传函数的形式可以拿到上一次的 state ，官方文档中如此定义的。
//     this.setState((state, props) => {
//       return {
//         count: state.count + 1 // 1 + 1
//       }
//     })
//     this.setState((state, props) => {
//       console.log('第二次调用：', state)
//       return {
//         count: state.count + 1 // 2 + 1
//       }
//     })
//     console.log('count：', this.state.count) // 1
//   }

//   render() {
//     console.log('render')
//     return (
//       <div>
//         <h1>计数器：{this.state.count}</h1>
//         <button onClick={this.handleClick}>+1</button>
//       </div>
//     )
//   }
// }

// root.render(<App />)





/*
  setState() callback
    场景：会在状态更新（页面完成重新渲染）后立即执行某个操作
    语法： setState(updater[, callback])
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// class App extends React.Component {
//   state = {
//     count: 1
//   }

//   handleClick = () => {
//     // setState 有第二个参数，它为一个回调函数，回调函数会在状态更新后立即执行，类似于 componentDidUpdate
//     this.setState(
//       (state, props) => {
//         return {
//           count: state.count + 1
//         }
//       },
//       // 状态更新后并且重新渲染后，立即执行：
//       () => {
//         console.log('状态更新完成：', this.state.count) // 2
//         console.log(document.getElementById('title').innerText)
//         // 修改文档的标题
//         document.title = '更新后的count为：' + this.state.count
//       }
//     )
//     console.log(this.state.count) // 1
//   }

//   render() {
//     return (
//       <div>
//         <h1 id="title">计数器：{this.state.count}</h1>
//         <button onClick={this.handleClick}>+1</button>
//       </div>
//     )
//   }
// }

// root.render(<App />)




/*
  JSX 语法的转化过程
    JSX 仅仅是 createElement() 方法的语法糖（简化语法）
    JSX 语法被 @babel/preset-react 插件编译为 createElement() 方法
    React 元素：是一个对象，用来描述你希望在屏幕上看到的内容
*/
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // JSX 写法
// // const element = <h1 className="greeting">Hello JSX!</h1>

// // 经过 @babel/preset-react 编译后的写法
// const element = React.createElement(
//   'h1',
//   {
//     className: 'greeting'
//   },
//   'Hello JSX！'
// )
// // 实际输出到控制台的写法
// // 注意：这是简化过的结构
// console.log(element)
// // const element = {
// //   type: 'h1',
// //   props: {
// //     className: 'greeting',
// //     children: 'Hello JSX!'
// //   }
// // };
// root.render(element)






/*
  组件更新机制
    setState() 的两个作用： 1. 修改 state 2. 更新组件（UI）
    过程：父组件重新渲染时，也会重新渲染子组件。但只会渲染当前组件子树（当前组件及其所有子组件）
*/
// import './css/04.css'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)

// // 根组件
// class App extends React.Component {
//   state = {
//     color: '#369'
//   }

//   getColor() {
//     return Math.floor(Math.random() * 256)
//   }

//   changeBG = () => {
//     this.setState(() => {
//       return {
//         color: `rgb(${this.getColor()}, ${this.getColor()}, ${this.getColor()})`
//       }
//     })
//   }

//   render() {
//     console.log('根组件')
//     return (
//       <div className="app" style={{ backgroundColor: this.state.color }}>
//         <button onClick={this.changeBG}>根组件 - 切换颜色状态</button>
//         <div className="app-wrapper">
//           <Parent1 />
//           <Parent2 />
//         </div>
//       </div>
//     )
//   }
// }

// // ------------------------左侧---------------------------

// class Parent1 extends React.Component {
//   state = {
//     count: 0
//   }

//   handleClick = () => {
//     this.setState(state => ({ count: state.count + 1 }))
//   }
//   render() {
//     console.log('左侧父组件')
//     return (
//       <div className="parent">
//         <h2>
//           左侧 - 父组件1
//           <button onClick={this.handleClick}>点我（{this.state.count}）</button>
//         </h2>
//         <div className="parent-wrapper">
//           <Child1 />
//           <Child2 />
//         </div>
//       </div>
//     )
//   }
// }

// class Child1 extends React.Component {
//   render() {
//     console.log('左侧子组件 - 1')
//     return <div className="child">子组件1-1</div>
//   }
// }
// class Child2 extends React.Component {
//   render() {
//     console.log('左侧子组件 - 2')
//     return <div className="child">子组件1-2</div>
//   }
// }

// // ------------------------右侧---------------------------

// class Parent2 extends React.Component {
//   state = {
//     count: 0
//   }

//   handleClick = () => {
//     this.setState(state => ({ count: state.count + 1 }))
//   }

//   render() {
//     console.log('右侧父组件')
//     return (
//       <div className="parent">
//         <h2>
//           右侧 - 父组件2
//           <button onClick={this.handleClick}>点我（{this.state.count}）</button>
//         </h2>
//         <div className="parent-wrapper">
//           <Child3 />
//           <Child4 />
//         </div>
//       </div>
//     )
//   }
// }

// class Child3 extends React.Component {
//   render() {
//     console.log('右侧子组件 - 1')
//     return <div className="child">子组件2-1</div>
//   }
// }
// class Child4 extends React.Component {
//   render() {
//     console.log('右侧子组件 - 2')
//     return <div className="child">子组件2-2 </div>
//   }
// }

// root.render(<App />)





/*
组件性能优化：
  1. 减轻 state：
    只存储跟组件渲染相关的数据（比如：count / 列表数据 / loading 等）
    注意：不用做渲染的数据不要放在 state 中，比如定时器 id等
    对于这种需要在多个方法中用到的数据，应该放在 this 中
  2.避免不必要的重新渲染
      组件更新机制：父组件更新会引起子组件也被更新，这种思路很清晰
      问题：子组件没有任何变化时也会被重新渲染
      如何避免不必要的重新渲染呢？
      解决方式：使用钩子函数 shouldComponentUpdate(nextProps, nextState)
      作用：通过返回值决定该组件是否重新渲染，返回 true 表示重新渲染，false 表示不重新渲染
      触发时机：更新阶段的钩子函数，组件重新渲染前执行 （shouldComponentUpdate  render）
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 根组件
// class App extends React.Component {
//   state = {
//     count: 0
//   }

//   handleClick = () => {
//     this.setState(state => {
//       return {
//         count: state.count + 1
//       }
//     })
//   }

//   // 钩子函数
//   shouldComponentUpdate(nextProps, nextState) {
//     // 返回false，阻止组件重新渲染
//     // return false

//     // 最新的状态：
//     console.log('最新的state：', nextState)
//     // 更新前的状态：
//     console.log('this.state:', this.state)

//     return true
//   }

//   render() {
//     console.log('组件更新了')
//     return (
//       <div>
//         <h1>计数器：{this.state.count}</h1>
//         <button onClick={this.handleClick}>+1</button>
//       </div>
//     )
//   }
// }

// root.render(<App />)



/*
  组件性能优化：
  比较 state 前后两次的值并决定是否渲染视图
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 生成随机数
// class App extends React.Component {
//   state = {
//     number: 0
//   }

//   handleClick = () => {
//     this.setState(() => {
//       return {
//         number: Math.floor(Math.random() * 3)
//       }
//     })
//   }

//   // 因为两次生成的随机数可能相同，如果相同，此时，不需要重新渲染
//   shouldComponentUpdate(nextProps, nextState) {
//     console.log('最新状态：', nextState, ', 当前状态：', this.state)

//     // 结果相同则不需要重新渲染视图
//     // if (nextState.number === this.state.number) {
//     //   return false
//     // }
//     // return true

//     // 结果相同则不需要重新渲染视图
//     // if (nextState.number !== this.state.number) {
//     //   return true
//     // }
//     // return false

//     // 优化后
//     return nextState.number !== this.state.number
//   }

//   render() {
//     console.log('render')
//     return (
//       <div>
//         <h1>随机数：{this.state.number}</h1>
//         <button onClick={this.handleClick}>重新生成</button>
//       </div>
//     )
//   }
// }

// root.render(<App />)




/*
  组件性能优化：
  比较 props 前后两次的值并决定是否渲染视图
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 生成随机数
// class App extends React.Component {
//   state = {
//     number: 0
//   }

//   handleClick = () => {
//     this.setState(() => {
//       return {
//         number: Math.floor(Math.random() * 3)
//       }
//     })
//   }
//   render() {
//     // console.log('render')
//     return (
//       <div>
//         <NumberBox number={this.state.number} />
//         <button onClick={this.handleClick}>重新生成</button>
//       </div>
//     )
//   }
// }

// class NumberBox extends React.Component {
//   shouldComponentUpdate(nextProps) {
//     console.log('最新props：', nextProps, ', 当前props：', this.props)
//     // 如果前后两次的number值相同，就返回false，不更新组件
//     return nextProps.number !== this.props.number

//     // if (nextProps.number === this.props.number) {
//     //   return false
//     // }
//     // return true
//   }
//   render() {
//     console.log('子组件中的render')
//     return <h1>随机数：{this.props.number}</h1>
//   }
// }

// root.render(<App />)




/*
  组件性能优化：
   纯组件：PureComponent 与 React.Component 功能相似
   区别：PureComponent 内部自动实现了 shouldComponentUpdate 钩子，不需要手动比较
   原理：纯组件内部通过分别 对比 前后两次 props 和 state 的值，来决定是否重新渲染组件
*/

// import React, { Component } from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 生成随机数
// class App extends React.PureComponent {
//   state = {
//     number: 0
//   }

//   handleClick = () => {
//     this.setState(() => {
//       return {
//         number: Math.floor(Math.random() * 3)
//       }
//     })
//   }

//   render() {
//     console.log('不拆分组件使用 this.state 时的render')
//     return (
//       <div>
//         {/* <h1>随机数：{this.state.number}</h1> */}
//         <NumberBox number={this.state.number} />
//         <button onClick={this.handleClick}>重新生成</button>
//         <h1>你好</h1>
//       </div>

//     )
//   }
// }

// class NumberBox extends React.PureComponent {
//   render() {
//     console.log('子组件中的render')
//     return <h1>随机数：{this.props.number}</h1>
//   }
// }

// root.render(<App />)





/*
  组件性能优化：
   说明：纯组件内部的对比是 shallow compare（浅层对比）
   对于值类型来说：比较两个值是否相同（直接赋值即可，没有坑）
   对于引用类型来说：只比较对象的引用（地址）是否相同
   也就是说是新对象等于原对象，会使得地址是相同的，修改任何一个另外一个都会改变，纯组件比较的就是两个对象是否相同，相同则不会渲染页面，所以也就导致了，实际上的 state 是改变的，但是并不会去渲染页面，所以不应该使用这种方法，应该新建立一个对象，将原对象的值复制过去，使得两个对象指向的是不同的地址，此时使用纯组件才会生效。
   注意：state 或 props 中属性值为引用类型时，应该创建新数据，不要直接修改原数据！
*/

// 引用类型：
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)

// const obj = { number: 0 }
// const newObj = obj
// newObj.number = 2
// console.log(newObj === obj) // true

// // 生成随机数
// class App extends React.PureComponent {
//   state = {
//     obj: {
//       number: 0
//     }
//   }

//   handleClick = () => {
//     // 正确做法：创建新对象，扩展语法展开后重新赋值
//     const newObj = { ...this.state.obj, number: Math.floor(Math.random() * 3) }
//     this.setState(() => {
//       return {
//         obj: newObj
//       }
//     })

//     // 错误演示：直接修改原始对象中属性的值
//     //   const newObj = this.state.obj
//     //   newObj.number = Math.floor(Math.random() * 3)

//     //   this.setState(() => {
//     //     return {
//     //       obj: newObj
//     //     }
//     //   })

//   }

//   render() {
//     console.log('父组件重新render')
//     return (
//       <div>
//         <h1>随机数：{this.state.obj.number}</h1>
//         <button onClick={this.handleClick}>重新生成</button>
//       </div>
//     )
//   }
// }

// root.render(<App />)





/*
  虚拟DOM 和 Diff算法
  1. 初次渲染时，React 会根据初始state（Model），创建一个虚拟 DOM 对象（树）。
  2. 根据虚拟 DOM 生成真正的 DOM，渲染到页面中。
  3. 当数据变化后（setState()），重新根据新的数据，创建新的虚拟DOM对象（树）。
  4. 与上一次得到的虚拟 DOM 对象，使用 Diff 算法 对比（找不同），得到需要更新的内容。
  5. 最终，React 只将变化的内容更新（patch）到 DOM 中，重新渲染到页面。
*/

// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// // 生成随机数
// class App extends React.PureComponent {
//   state = {
//     number: 0
//   }

//   handleClick = () => {
//     this.setState(() => {
//       return {
//         number: Math.floor(Math.random() * 2)
//       }
//     })
//   }

//   // render方法调用并不意味着浏览器中的重新渲染！！！
//   // render方法调用仅仅说明要进行diff
//   render() {
//     const el = (
//       <div>
//         <h1>随机数：</h1>
//         <p>{this.state.number}</p>
//         <button onClick={this.handleClick}>重新生成</button>
//       </div>
//     )
//     console.log(el)

//     return el
//   }
// }

// root.render(<App />)




/*
  react-router-dom 的基本使用：
  1. 安装： yarn add react-router-dom
  2. 导入路由的三个核心组件：Router / Route / Link
  3. 使用 Router 组件包裹整个应用（重要）
  4. 使用 Link 组件作为导航菜单（路由入口）
  5. 使用 Route 组件配置路由规则和要展示的组件（路由出口）

  现代的前端应用大多都是 SPA（单页应用程序），也就是只有一个 HTML 页面的应用程序。因为它的用户体
  验更好、对服务器的压力更小，所以更受欢迎。为了有效的使用单个页面来管理原来多页面的功能，前端路由
  应运而生。
    前端路由的功能：让用户从一个视图（页面）导航到另一个视图（页面）
    前端路由是一套映射规则，在React中，是 URL路径 与 组件 的对应关系
    使用React路由简单来说，就是配置 路径和组件（配对）
  常用组件说明：

     Router 组件：包裹整个应用，一个 React 应用只需要使用一次
     两种常用 Router：HashRouter 和 BrowserRouter
     HashRouter：使用 URL 的哈希值实现（localhost:3000/#/first）
   （推荐）BrowserRouter：使用 H5 的 history API 实现（localhost:3000/first）

    Link 组件：用于指定导航链接（实际在页面上会渲染为 a 标签，to 代表 href）

    Route 组件：指定路由展示组件相关信息
      // path属性：路由规则
      // component属性：展示的组件
      // Route组件写在哪，渲染出来的组件就展示在哪

    注意：以上所有语法规则是在 react-router-dom@5.2版本中适用的，现在的react-router-dom@6版本语法规则有所改变
*/

// 2 导入组件：
// import { BrowserRouter as Router, Route, Link } from 'react-router-dom'
// // HashRouter 写法会在页面的 url 地址栏中多个 # ，较为丑陋，所以一般用第一种
// // import { HashRouter as Router, Route, Link } from 'react-router-dom'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)

// const First = () => <p>页面一的内容</p>

// // 3 使用Router组件包裹整个应用
// const App = () => (
//   <Router>
//     <div>
//       <h1>React路由基础</h1>
//       {/* 4 指定路由入口，在页面上相当于<a href="first">页面一</a>*/}
//       <Link to="/first">页面一</Link>

//       {/* 5 指定路由出口，路径要一致*/}
//       <Route path="/first" component={First} />
//     </div>
//   </Router>
// )

// root.render(< App />)





/*
  路由的执行过程
  1. 点击 Link 组件（a标签），修改了浏览器地址栏中的 url 。
  2. React 路由监听到地址栏 url 的变化。
  3. React 路由内部遍历所有 Route 组件，使用路由规则（ path ）与 pathname 进行匹配。
  4. 当路由规则（path）能够匹配地址栏中的 pathname(也就是link 组件中中 to 属性的值) 时，就展示该 Route 组件的内容。
  */

// import { BrowserRouter as Router, Route, Link } from 'react-router-dom'
// import React from 'react'
// import { createRoot } from 'react-dom/client'
// const container = document.getElementById('root')
// const root = createRoot(container)
// const First = () => <p>页面一的内容</p>
// const Home = () => <h2>这是Home组件的内容</h2>

// // 使用Router组件包裹整个应用
// const App = () => (
//   <Router>
//     <div>
//       <h1>React路由基础</h1>
//       {/* 指定路由入口 */}
//       <Link to="/first">页面一</Link>
//       <br />
//       <Link to="/home">首页</Link>
//       <div>
//         {/* 指定路由出口 */}
//         <Route path="/first" component={First} />
//         <Route path="/home" component={Home} />
//       </div>
//     </div>
//   </Router>
// )

// root.render(<App />)




/* 
  编程式导航
    场景：点击登录按钮，登录成功后，通过代码跳转到后台首页，如何实现？
    编程式导航：通过 JS 代码来实现页面跳转
    history 是 React 路由提供的，用于获取浏览器历史记录的相关信息
    push(path)：跳转到某个页面，参数 path 表示要跳转的路径
    go(n)： 前进或后退到某个页面，参数 n 表示前进或后退页面数量（比如：-1 表示后退到上一页）

    
  模糊匹配模式
    问题：当 Link组件的 to 属性值为 “/login”时，为什么 默认路由 也被匹配成功？
    默认情况下，React 路由是模糊匹配模式
    模糊匹配规则：只要 pathname(也就是link 组件中中 to 属性的值) 以 path 开头就会匹配成功

  精确匹配模式
    问题：默认路由任何情况下都会展示，如何避免这种问题？
    给 Route 组件添加 exact 属性，让其变为精确匹配模式
    精确匹配：只有当 path 和 pathname 完全匹配时才会展示该路由

*/

import { BrowserRouter as Router, Route, Link } from 'react-router-dom'
import React from 'react'
import { createRoot } from 'react-dom/client'
const container = document.getElementById('root')
const root = createRoot(container)
// 类组件
class Login extends React.Component {
  handleLogin = () => {
    // 使用编程式导航实现路由跳转
    // ...省略其他功能代码
    this.props.history.push('/home')
  }
  render() {
    return (
      <div>
        <p>登录页面：</p>
        <button onClick={this.handleLogin}>登录</button>
      </div>
    )
  }
}
// 函数组件
const Home = props => {
  const handleBack = () => {
    // go(-1) 表示返回上一个页面
    props.history.go(-1)
  }
  return (
    <div>
      <h2>我是后台首页</h2>
      <button onClick={handleBack}>返回登录页面按钮</button>
    </div>
  )
}
const defaultRoute = () => <p>进入页面的时候，不需要点击任何链接，就默认显示在页面上的路由，你能看到我吗？</p>
const App = () => (
  <Router>
    <div>
      <h1>编程式导航：</h1>
      {/* link组件中的 to 可以匹配 Route 组件中 path 开头的地址，如<Link to="/login/abc">去登录页面</Link>可以匹配 Route 路由 path 为 / ,/login, /login/abc 开头的地址*/}
      <Link to="/login">去登录页面</Link>
      <Route path="/login" component={Login} />
      <Route path="/home" component={Home} />
      {/* <Route path="/" component={defaultRoute} /> */}
      {/* 下面的写法为精确匹配模式，只有 pathname 和 path 完全一致时才会调用该路由 */}
      <Route exact path="/" component={defaultRoute} />
    </div>
  </Router>
)

root.render(<App />)

```