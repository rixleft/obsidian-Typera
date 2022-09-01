# React 第五天

## 一、React

### 1.1 Diffing 算法

>   **算法复杂度**

​	 在某一时间节点调用 React 的 render() 方法，会创建一棵由 React 元素组成的树。在下一次 state 或 props 更新时，相同的 render() 方法会返回一棵不同的

树。React 需要基于这两棵树之间的差别来判断，如何有效率的更新 UI，以保证当前 UI 与最新的树保持同步。

​	 生成将一棵树转换成另一棵树的最小操作数的算法。 即使在最前沿的算法中，该算法的复杂程度为 O(n 3 )，其中 n 是树中元素的数量

​	 如果在 React 中使用了该算法，那么展示 1000 个元素所需要执行的计算量将在十亿的量级范围。这个开销实在是太过高昂

>   **React** **算法复杂度**

React 在以下两个假设的基础之上提出了一套 O(n) 的启发式算法：

​		 **两个不同类型的元素会产生出不同的树；**

​		 **开发者可以通过 key prop 来暗示哪些子元素在不同的渲染下能保持稳定；**

在实践中，我们发现以上假设在几乎所有实用的场景下都成立。

当对比两颗树时，React 首先比较两棵树的根节点。不同类型的根节点元素会有不同的形态。

>   **对比不同类型的元素**

当根节点为不同类型的元素时，React 会拆卸原有的树并且建立起新的树。举个例子，

​		 当一个元素从 \<a> 变成 \<img>，

​		 从\<Article> 变成 \<Comment>，

​		 或从 \<Button> 变成 \<div> 都会触发一个完整的重建流程。

 当拆卸一颗树时，对应的 DOM 节点也会被销毁。组件实例将执行 componentWillUnmount() 方法。当建立一颗新的树时，对应的 DOM 节点会被创建以及插入

到 DOM 中。组件实例将执行 componentWillMount() 方法，紧接着 componentDidMount() 方法。所有跟之前的树所关联的 state 也会被销毁。

 在根节点以下的组件也会被卸载，它们的状态会被销毁。

>   **变更举例**

如，当比对以下更变时：

```html
	<div>
		<Counter />
	</div>
	<span>
		<Counter />
	</div>

```

React 会销毁 Counter 组件并且重新装载一个新的组件。

>   **对比同类型的元素**

当比对两个相同类型的 React 元素时，React 会保留 DOM 节点，仅比对及更新有改变的属性。比如：	<div className="before" title="stuff" />

```html
	<div className="after" title="stuff" />
```

通过比对这两个元素，React 知道只需要修改 DOM 元素上的 className 属性。
当更新 style 属性时，React 仅更新有所更变的属性。比如：

```html
	<div style={{color: 'red', fontWeight: 'bold'}} />
	<div style={{color: 'green', fontWeight: 'bold'}} />
```

通过比对这两个元素，React 知道只需要修改 DOM 元素上的 color 样式，无需修改 fontWeight。在处理完当前节点之后，React 继续对子节点进行递归

>   **对比同类型的组件元素**

当一个组件更新时，组件实例保持不变，这样 state 在跨越不同的渲染时保持一致。React 将更新该组件实例的 props 以跟最新的元素保持一致，并且调用该实例的 componentWillReceiveProps() 和 componentWillUpdate() 方法。

下一步，调用 render() 方法，diff 算法将在之前的结果以及新的结果中进行递归。

>   **对子节点进行递归**

在默认条件下，当递归 DOM 节点的子元素时，React 会同时遍历两个子元素的列表；当产生差异时，生成一个 mutation。在子元素列表末尾新增元素时，更变

开销比较小。比如：

```html
	<ul>									
  		<li>first</li>								
 		<li>second</li>							
	</ul>										
变更成：									
	<ul>
        <li>first</li>
        <li>second</li>
        <li>third</li>
    </ul>
```

React 会先匹配两个 \<li>first \< /li> 对应的树，然后匹配第二个元素 < li>second < /li> 对应的树，最后插入第三个元素的 < li>third < /li> 树。

>   **效率低下的变更**

在列表头部插入会很影响性能，并且更变开销会比较大。比如：

```html
	<ul>									
  		<li>first</li>								
 		<li>second</li>							
	</ul>										
变更成：									
	<ul>
        <li>third</li>
        <li>first</li>
        <li>second</li>
    </ul>
```

React 会针对每个子元素 mutate 而不是保持相同<li>first</li> 和 <li>second</li> 子树完成。这种情况下的变更低效并且可能会带来性能问题。

>   **keys**

为了解决以上问题，React 支持 key 属性。当子元素拥有 key 时，React 使用 key 来匹配原有树上的子元素以及最新树上的子元素。以下例子在新增 key 之后使得之前的低效转换变得高效：

```html
	<ul>									
  		<li key="2015">first</li>								
 		<li key="2016">second</li>							
	</ul>										
变更成：									
	<ul>
        <li key="2014">third</li>
        <li key="2015">first</li>
        <li key="2016">second</li>
    </ul>
```

现在 React 知道只有带着 '2014' key 的元素是新元素，带着 '2015' 以及 '2016' key 的元素仅仅移动了。

>   **设置****keys**

现实场景中，产生一个 key 并不困难。你要展现的元素可能已经有了一个唯一 ID，于是 key 可以直接从你的数据中提取：

​	 <li key={item.id}>{item.name}</li>

当以上情况不成立时，你可以新增一个 ID 字段到你的模型中，或者利用一部分内容作为哈希值来生成一个 key。这个 key 不需要全局唯一，但在列表中需要保持

唯一。

>   **使用keys注意事项**

你也可以使用元素在数组中的下标作为 key。这个策略在元素不进行重新排序时比较合适，但一旦有顺序修改，diff 就会变得慢。

当基于下标的组件进行重新排序时，组件 state 可能会遇到一些问题。由于组件实例是基于它们的 key 来决定是否更新以及复用，如果 key 是一个下标，那么修改

顺序时会修改当前的 key，导致非受控组件的 state（比如输入框）可能相互篡改导致无法预期的变动。

>   **注意事项**

协调算法是一个实现细节。React 可以在每个 action 之后对整个应用进行重新渲染，得到的最终结果也会是一样的。在 context 下，重新渲染要在所有组件内调用 

render 方法，这不代表 React 会卸载或装载它们。React 只会基于以上提到的规则来决定如何进行差异的合并。React团队定期探索优化算法，让常见用例更高效

地执行。在当前的实现中，可以理解为一棵子树能在其兄弟之间移动，但不能移动到其他位置。在这种情况下，算法会重新渲染整棵子树。由于 React 依赖探索的

算法，因此当以下假设没有得到满足，性能会有所损耗。

​		 该算法不会尝试匹配不同组件类型的子树。如果你发现你在两种不同类型的组件中切换，但输出非常相似的内容，建议把它们改成同一类型。在实践中，我

们没有遇到这类问题。

​		 Key 应该具有稳定，可预测，以及列表内唯一的特质。不稳定的 key（比如通过 Math.random() 生成的）会导致许多组件实例和 DOM 节点被不必要地重新

创建，这可能导致性能下降和子组件中的状态丢失。

>   **Diffing 算法总结**

前提：

​		 1 类型相同的两个元素（组件），我们认为是同一个。

​		 2 通过判断key，props来决定虚拟DOM或者组件是否应该更新

​		 根据以上两个前提，可以得到一个O（n）算法

比较顺序

​	 	1 比较根元素类型

​		 2 比较元素属性

​		 3 比较元素样式

​		 4 比较组件属性

​		 5 比较列表

​				 ①没有设置key，按照顺序比较，涉及排序，会有性能问题，

​				 ②设置了key，按照key字段比较，涉及排序，不会有性能问题

注意：

​		1 如果组件DOM树结构相似，建议成抽象成同一个组件。

​		2 key要稳定，可预测，列表唯一

### 1.2 **PureComponent**

该组件主要是为了对类组件做性能优化的。

​		 功能类似shouldComponentUpdate方法

使用方式与Component一样：

​		 class 组件类 extends PureComponent {}

​				 此时当组件的数据改变的时候，组件才会更新

注意：

​	 1 只对类组件生效，对函数组件无效

​	 2 只对数据（属性，状态）做浅层的比较，如果是引用类型的数据，不会深比较。

​			此时还得用 Component 的 shouldComponentUpdate 方法

```jsx
// 引入核心库
import React, { Component, PureComponent } from 'react';
// 渲染库
import { render } from 'react-dom';

// // 定义组件类
// class App extends Component {
//     // 定义构造函数
//     constructor(props) {
//         super(props);
//         this.state = {
//             isShow: false
//         }
//     }
    

//     // 组件构建完成之后
//     componentDidMount() {
//         // 监听页面卷动
//         document.addEventListener('scroll', () => {
//             if (scrollY > 300) {
//                 this.setState({ isShow: true })
//             } else {
//                 this.setState({ isShow: false })
//             }
//         })
//     }


//     render() {
//         return (
//             <div>
//                 <h1>app part</h1>
//                 <hr />
//                 <Demo isShow={this.state.isShow}></Demo>
//             </div>
//         );
//     }
// }

// // 定义组件类
// class Demo extends Component {

//     // 更新优化
//     shouldComponentUpdate(props) {
//         // 如果两次数据不相等 则更新
//         return props.isShow !== this.props.isShow;
//     }

//     render() {
//         console.log('demo render');
//         return (
//             <div style={{
//                 position: 'fixed',
//                 right: 100,
//                 bottom: 100,
//                 fontSize: 20,
//                 color: 'green',
//                 backgroundColor: 'pink',
//                 // 通过属性控制显隐
//                 display: this.props.isShow ? '' : 'none'
//             }}>返回顶部</div>
//         );
//     }
// }






/******************************************************定义生层次的数据结构**********************************************************/
//  定义组件类
class App extends Component {
    // 定义构造函数
    constructor(props) {
        super(props);
        this.state = {
            data: {
                isShow: false
            }
        }
    }
    

    // 组件构建完成之后
    componentDidMount() {
        // 监听页面卷动
        document.addEventListener('scroll', () => {
            if (scrollY > 300) {
                this.setState({ data: { isShow: true } })
            } else {
                this.setState({ data: { isShow: false} })
            }
        })
    }


    render() {
        return (
            <div>
                <h1>app part</h1>
                <hr />
                <Demo data={this.state.data}></Demo>
            </div>
        );
    }
}


// 定义组件类
// class Demo extends PureComponent {
class Demo extends Component {

    shouldComponentUpdate(props) {
        // console.log(props);
        return props.data.isShow !== this.props.data.isShow;
    }

    render() {
        console.log('demo render', this.props);
        return (
            <div style={{
                position: 'fixed',
                right: 100,
                bottom: 100,
                fontSize: 20,
                color: 'green',
                backgroundColor: 'pink',
                // 通过属性控制显隐
                // display: this.props.isShow ? '' : 'none'
                display: this.props.data.isShow ? '' : 'none'
            }}>返回顶部</div>
        );
    }
}


// 总结:
    // PureComponent 只针对于类组件生效 并且 只能够处理浅层次的数据结构
    // 对于深层次的数据结构 使用shouldComponentUpdate实现优化更新


// 渲染
render(<App></App>, app); 
```



### 1.3 memo 方法

react提供了memo方法，可以对函数组件做优化。

用法：memo(Comp, (currentProps, nextProps) => {

​		 currentProps：表示当前的属性数据

​		 nextProps：表示新的属性数据

​		 必须有返回值，表示是否不更新：true 表示不更新、 false 表示更新

 		与shouldComponentUpdate返回值正好相反，true表示更新 }) 

注意：

​		 memo方法只能处理函数组件。

​		 memo方法返回值是一个新组件，原来的组件不受影响，返回的新组件才能被优化。

用一个函数处理组件，并返回一个新组件，这个新组件就是高阶组件，这个方法（函数）叫高阶方法。

```jsx
// 引入核心库
import React, { Component, PureComponent, memo } from 'react';
// 渲染库
import { render } from 'react-dom';

// 定义组件类
class App extends Component {
    // 定义构造函数
    constructor(props) {
        super(props);
        this.state = {
            isShow: false
        }
    }
    

    // 组件构建完成之后
    componentDidMount() {
        // 监听页面卷动
        document.addEventListener('scroll', () => {
            if (scrollY > 300) {
                this.setState({ isShow: true })
            } else {
                this.setState({ isShow: false })
            }
        })
    }


    render() {
        return (
            <div>
                <h1>app part</h1>
                <hr />
                {/* <Demo isShow={this.state.isShow}></Demo> */}
                {/* 使用高阶组件 */}
                <DealMemo isShow={this.state.isShow}></DealMemo>
            </div>
        );
    }
}

// // 定义函数组件
// let Demo = props => {
//     console.log('render demo');
//     return <div style={{
//         position: 'fixed',
//         right: 100,
//         bottom: 100,
//         fontSize: 20,
//         color: 'green',
//         backgroundColor: 'pink',
//         // 通过属性控制显隐
//         display: props.isShow ? '' : 'none'
//     }}>返回顶部</div>
// }



// 定义类组件
class Demo extends Component {
   render() {
       console.log('render demo');
        return (
            <div style={{
                position: 'fixed',
                right: 100,
                bottom: 100,
                fontSize: 20,
                color: 'green',
                backgroundColor: 'pink',
                // 通过属性控制显隐
                display: this.props.isShow ? '' : 'none'
            }}>返回顶部</div>
        )
   }
}



// 使用memo方法优化Demo
let DealMemo = memo(Demo, (props, newProps) => {
    // console.log(args);
    // 第一个参数表示当前的属性
    // 第二个参数表示新的属性
    // 返回值 true表示不更新 false 表示更新
    return props.isShow === newProps.isShow;
})


// 总结:
    // memo方法可以处理函数组件
    // 又可以处理 类组件 但是只能处理属性数据 无法处理状态数据
    // 函数组件还是建议使用PureComponent 和 shouldComponentUpdate方法使用




// 渲染
render(<App></App>, app); 
```



### 1.4 cloneElement

有时候想复制一个虚拟DOM，可以使用cloneElemnet方法

用法与createElement方法类似

​	 cloneElement(vdom, props, ...children)

​			 第一个参数表示虚拟DOM

​			 第二个参数表示属性对象

​			 从第三个参数开始表示传递给新的虚拟DOM的子内容。

cloneElement与createElenent方法一样，也有jsx语法的等价语法。

​		 <vdom.type key={value} {...props} ></vdom.type>

```jsx
// 引入核心库
import React, { Component, cloneElement } from 'react';
// 渲染库
import { render } from 'react-dom';

// 定义虚拟DOM
let title = <h1 title="hello world" className="nihao" style={{ fontSize: 30 }}>hello world</h1>;

// 定义数据对象
let data = {
    title: 'nihao123',
    className: 'box2',
    style: {
        fontSize: 40,
        color: 'pink'
    }
}

// 定义组件类
class App extends Component {
    render() {
        return (
            <div>
                <h1>app part</h1>
                <hr />
                {title}
                <hr />
                {/* 使用cloneElement方法 */}
                {cloneElement(title, null, '你好明天')}
                {cloneElement(title, { title: 'hello123', className: 'box', style: { color: 'red' } }, '你好明天')}
                <hr />

                {/* 有jsx语法的等价语法。 */}
                <title.type title="nihao222">hello 333</title.type>
                {/* 使用扩展运算符 添加数据 */}
                <title.type {...data} title="nihao"  >hello 333</title.type>
            </div>
        );
    }
}




// 渲染
render(<App></App>, app); 
```



### 1.5 Fragment

作用类似vue中的template元素。

是用来定义一个模板的组件，

​	 该组件可以作为根节点，但是不会渲染到页面中。

工作中:

​	 1 用来渲染多个兄弟根元素

​	 2 避免在特定元素之间，引入新元素。

```jsx
// 引入核心库
import React, { Component, Fragment } from 'react';
// 渲染库
import { render } from 'react-dom';


// 定义组件
class Tds extends Component {
    render() {
        return (
            <Fragment>
                <td>111</td>
                <td>222</td>
                <td>333</td>
            </Fragment>
        );
    }
}

// 定义组件类
class App extends Component {

    // 创建列表方法
    // createList() {
    //     return this.props.arr.map(item => {
    //         return (
    //             <div>
    //                 <li key={item}>{item}</li>
    //                 <hr />
    //             </div>
    //         )
    //     })
    // }

    createList() {
        return this.props.arr.map(item => {
            return (
                // 使用Fragment
                <Fragment  key={item}>
                    <li>{item}</li>
                    <hr />
                </Fragment>
            )
        })
    }


    render() {
        return (
            <div>
                <h1>app part</h1>
                <hr />
                {/* 创建列表 */}
                <ul>{this.createList()}</ul>
                {/* 制作表格 */}
                <table>
                    <tbody>
                        <tr>
                           <Tds></Tds>
                        </tr>
                        <tr>
                            <Tds></Tds>
                        </tr>
                        <tr>
                            <Tds></Tds>
                        </tr>
                    </tbody>
                </table>
            </div>
        );
    }
}




// 渲染
render(<App arr={['携程旅行网', '好看视频', '淘宝网']}></App>, app); 
```



### 1.6 错误边界组件

在一个组件中，如果某个子组件出现了错误，整个页面都无法渲染了。

​	 子组件中的错误冒泡到父组件中，影响了父组件的渲染。

​	 所以react提供了错误边界技术，让错误冒泡到错误边界组件中，这样就不会影响父组件的渲染了

错误边界组件

​	 只需要定义componentDidCatch方法，就可以捕获错误，避免错误冒泡。

​			 第一个参数表示错误信息

​			 第二个参数表示错误描述信息

在错误边界组件中，可以定义静态方法getDerivedStateFromError。

​	 该方法的返回值表示错误产生的时候，修改的状态数据。

### 1.7 children

不论是虚拟DOM还是组件，其props属性中，都有一个children属性，代表子内容

​	 可以是文本，对象，数组。

我们可以直接通过children属性获取内容。

```jsx
// 引入核心库
import React, { Component, Fragment } from 'react';
// 渲染库
import { render } from 'react-dom';

// 定义组件类
class App extends Component {
    render() {
        return (
            <div>
                <h1>app part</h1>
                <hr />
                <Error>
                    <Demo></Demo>
                </Error>
                <hr />
                <Error>
                    <h1 style="color: 'red'">hello world</h1>
                </Error>
                <h1>helll123</h1>
            </div>
        );
    }
}

// 定义错误边界组件
class Error extends Component {
    // 定义状态
    constructor(props) {
        super(props);
        this.state = {
            hasError: false
        }
    }

       
    // 捕获异常信息
    // componentDidCatch() {
    //     console.log('error');
    // }

    // 定义静态方法
    static getDerivedStateFromError() {
        // 必须有返回值
        return {
            hasError: true
        }
    }
 
    render() {
        // console.log(111, this.state.hasError);
        if (this.state.hasError) {
            return <h1>error</h1>
        } else {
            return this.props.children;
        }
    }
}

// 定义组件类
class Demo extends Component {
    // // 捕获异常信息
    // componentDidCatch(...args) {
    //     console.log(args);
    // }

    render() {
        return (
            <div>
                {/* <h1>demo part</h1>  */}
                {/* 错误的写法 */}
                <h1 style="color: 'red'">demo part</h1>
            </div>
        );
    }
}





// 渲染
render(<App></App>, app); 
```



### 1.8 异步组件

将所有的组件都打包在一起，会导致文件很大，加载很慢，影响用户体验。

​	 所以我们要使用异步组件，让我们可以异步的加载组件。

 我们要使用import方法来异步加载，需要安装插件：

​		 babel-plugin-syntax-dynamic-import

 注：webpack 4.0的babel插件已经支持异步加载了。

### 1.9 lazy

 该方法可以异步加载组件

​	 参数回调函数

 回调函数的返回值表示加载的组件，有两种情况

​	 1 是promise对象，

​			 在promise对象中，做异步操作，再异步加载组件

​	 2 是import方法，

​			 在import中，直接异步加载组件

lazy方法加载的组件无法直接渲染，必须通过Suspense组件渲染。

### 1.10 Suspense

该组件就是用来负责渲染lazy方法加载的组件。

通过fallback属性，定义组件加载完成之前的提示内容。

```jsx
// 引入核心库
import React, { Component, Fragment, lazy, Suspense } from 'react';
// 渲染库
import { render } from 'react-dom';
// 直接导入
// import Demo from './Demo.js';

// 异步加载
// let Demo = lazy(() => new Promise(resolve => {
//     document.addEventListener('click', () => {
//         // 通过import方法
//         import('./Demo.js');
//     }) 
// }))


// 直接导入
let Demo = lazy(() => import('./Demo.js'));

// 定义组件类
class App extends Component {
    render() {
        return (
            <div>
                <h1>app part</h1>
                <hr />

                {/* 必须通过Suspense组件渲染。 */}
                <Suspense fallback={<h1>loding...</h1>}>
                    <Demo></Demo>
                </Suspense>                
            </div>
        );
    }
}


// 渲染
render(<App></App>, app); 
```



### 1.11 组件的约束性

用户可以与组件中的表单元素交互，这样就产生了数据，这些数据存储在哪里决定了组件的约束性。

​	 如果交互产生的数据存储在元素自身，该组件就是非约束性组件。

​	 如果交互产生的数据存储在组件状态中，该组件就是约束性组件。

### 1.12 非约束性组件

交互产生的数据存储在元素自身，该组件就是一个非约束性组件。获取数据，存储数据都要通过该元素。

默认值

​	 	我们通过defaultValue或者defaultChecked属性定义默认值。都是非元素属性。

获取数据

​		 1 为元素设置ref属性

​		 2 通过this.refs获取元素，再通过元素获取数据

修改数据

​		 1 为元素设置ref属性

​		 2 通过this.refs获取元素，再修改元素的数据，

### 1.13 ref

react提供了一种新的创建ref对象的方式。

​	 通过createRef可以创建一个ref对象

目的：代替ref字符串方式

优势：允许我们在组件外部获取组件内部的元素。

使用ref对象分成三步

​	 第一步 在构造函数中，创建ref对象，并存储在组件自身

​	 第二步 让ref对象指向元素。

​	 第三步 通过ref对象的current属性获取元素。

```jsx
// 引入核心库
import React, { Component, createRef } from 'react';
// 渲染库
import { render } from 'react-dom';


// 定义组件类
class App extends Component {

    constructor(props) {
        super(props);
        
        // 定义ref
        this.username = createRef();
        this.password = createRef();
    }
    


    // 获取数据
    getData() {
        // 2 通过this.refs获取元素，再通过元素获取数据
        // console.log(this.refs.username.value);

        // 获取对应的元素的值
        console.log(this.username.current.value);

    }

    // 修改数据
    updateData() {
        // 修改元素值即可
        this.username.current.value = 'wanglaowu';
        this.password.current.checked = false;

    }

    render() {
        return (
            <div>
                
                {/* 我们通过defaultValue或者defaultChecked属性定义默认值。都是非元素属性。 */}
                <p>
                    <label>用户名:</label>
                    {/* 1 为元素设置ref属性 */}
                    {/* <input type="text"  defaultValue="admin"  ref="username" /> */}
                    <input type="text"  defaultValue="admin"  ref={this.username} />
                </p>

                <p>
                    <label>密&emsp;码:</label>
                    <input type="checkbox" defaultChecked  ref={this.password} />
                </p>
                
                <div className="btns">
                    <button onClick={ e => this.getData(e) }>获取数据</button>  
                    &emsp;  
                    <button onClick={ e => this.updateData(e) }>修改数据</button>    
                </div>  

            </div>
        );
    }
}


// 渲染
render(<App></App>, app); 
```



### 1.14 约束性组件

交互产生的数据存储在组件的状态中，该组件就是一个约束性组件。获取数据，修改数据都通过组件的状态。

默认值

​		 为value属性和checked属性绑定组件的状态数据。

​		 在onChange方法中，监听数据的改变，并更新状态

​				 如果是输入框，我们还可以做表单校验。判断内容是否合法：

​						合法则更新状态、

​						不合法则不更新状态

获取数据

​	 就是获取组件的状态数据。

修改数据

​	 就是修改组件的状态数据。

### 1.15 MVVM 模式

react也可以看成是MVVM模式的框架。

数据双向绑定有两个方向：

​		 数据由模型进入视图： 插值语法

​		 数据由视图进入模型： 事件监听

react中数据双向绑定是手动实现的，vue中通过v-model指令实现。

```jsx
// 引入核心库
import React, { Component, createRef } from 'react';
// 渲染库
import { render } from 'react-dom';


// 定义组件类
class App extends Component {

    constructor(props) {
        super(props);
       
        // 定义状态
        this.state = {
            username: 'admin',
            password: true
        }
    }
    


    // 修改用户名
    changeUsername(e) {
        // console.log(e.target.value);
        // 定义修改的状态值
        let username = e.target.value;

        // 如果是输入框，我们还可以做表单校验。
        if (/^\w{4,6}$/.test(username)) {
            // 修改
            this.setState({ username })
        }
    } 

    // 获取数据
    getData() {
        // 就是获取状态
        console.log(this.state);
    }

    // 修改数据
    updateData() {
        // 就是修改状态数据
        this.setState({
            username: 'zhangsan',
            password: false
        })
    }

    render() {
        return (
            <div>
                
                <p>
                    <label>用户名:</label>
                    {/* 通过value定义默认值 */}
                    <input type="text"  value={this.state.username} onChange={ e => this.changeUsername(e) } />
                </p>

                <p>
                    <label>密&emsp;码:</label>
                    {/* 通过cheked定义默认值 */}
                    <input type="checkbox" checked={this.state.password} onChange={ e => this.setState({ password: e.target.checked }) }  />
                </p>
                
                <div className="btns">
                    <button onClick={ e => this.getData(e) }>获取数据</button>  
                    &emsp;  
                    <button onClick={ e => this.updateData(e) }>修改数据</button>    
                </div>  

            </div>
        );
    }
}


// 渲染
render(<App></App>, app); 
```



### 1.16 下拉框的约束性

通过select元素定义下拉框，通过option元素定义选项。

​	 选项的值默认是内容值，设置了value就是value值。

​	 下拉框分成单选下拉框和多选下拉框，通过multiple属性切换。

### 1.17 单选下拉框

非约束性

​		 默认值：通过defaultValue来定义。

​		 获取数据：获取元素再获取数据

​		 修改数据；获取元素再修改数据

约束性

​		 默认值：为select元素的value属性绑定状态，在onChange事件中，更新状态。

​		 获取数据：获取状态数据

​		 修改数据：修改状态数据。

```jsx
// 引入核心库
import React, { Component, createRef } from 'react';
// 渲染库
import { render } from 'react-dom';


// // 单选下拉框的非约束性:
// // 定义组件类
// class App extends Component {
//     constructor(props) {
//         super(props);
        
//         // 定义ref
//         this.color = createRef();
//     }



//     // 获取数据
//     getData() {
//         // 获取元素 再获取数据
//         console.log(this.color.current.value);
//     }

//     // 修改数据
//     updateData() {
//         // 获取元素 再修改数据
//         this.color.current.value = 'isBlue';
//     }

//     render() {
//         return (
//             <div>
//                 <p>
//                     {/* 默认是内容值 当设置了value就是value值 */}
//                    <select defaultValue="isGreen" ref={this.color}>
//                        <option value="isRed">red</option>
//                        <option value="isGreen">green</option>
//                        <option value="isBlue">blue</option>
//                    </select>
//                 </p>
                
//                 <div className="btns">
//                     <button onClick={ e => this.getData(e) }>获取数据</button>  
//                     &emsp;  
//                     <button onClick={ e => this.updateData(e) }>修改数据</button>    
//                 </div>  

//             </div>
//         );
//     }
// }


// // 单选下拉框的约束性:
// class App extends Component {
//     constructor(props) {
//         super(props);
        

//         // 定义状态
//         this.state = {
//             color: 'isGreen'
//         }
//     }

//     // 获取数据
//     getData() {
//         // 获取状态数据即可
//         console.log(this.state.color);
//     }
    
//     // 修改数据
//     updateData() {
//         // 修改状态数据即可
//         this.setState({ color: 'isBlue' })
//     }

//     render() {
//         return (
//             <div>
//                 <p>
//                    <select value={this.state.color} onChange={ e => this.setState({ color: e.target.value }) }>
//                        <option value="isRed">red</option>
//                        <option value="isGreen">green</option>
//                        <option value="isBlue">blue</option>
//                    </select>
//                 </p>
                
//                 <div className="btns">
//                     <button onClick={ e => this.getData(e) }>获取数据</button>  
//                     &emsp;  
//                     <button onClick={ e => this.updateData(e) }>修改数据</button>    
//                 </div>  

//             </div>
//         );
//     }
// }




// // 多选下拉框的非约束性:
// class App extends Component {
//     constructor(props) {
//         super(props);

//         // 定义ref
//         this.color = createRef();
//     }

//     // 获取数据
//     getData(e) {
//         // console.log(this.color.current.options);

//         // 定义空数组
//         let colors = [];

//         // 缓存变量
//         let options = this.color.current.options;

//         // 遍历集合
//         for (let i = 0; i < options.length; i++) {
//             if (options[i].selected) {
//                 colors.push(options[i].value)
//             }
//         }
//     }
    
//     // 修改数据
//     updateData() {
//         // 定义修改之后的数据
//         let choose = ['isGreen', 'isBlue'];

//         // 缓存变量
//         let options = this.color.current.options;

      

//         // 遍历options和choose 从options中找到被选中的哪一项 并修改
//         // aaa: for (let i = 0; i < options.length; i++) {
//         //     for (let j = 0; j < choose.length; j++) {
//         //         // 从choose里面匹配options被选中的那一项
//         //         if (options[i].value === choose[j]) {
//         //             // 更新数据
//         //            options[i].selected = true;
//         //             // 终止外层循环
//         //            continue aaa;
//         //         }
//         //     }
//         //     // 不在choose中的那一项 取消选中态
//         //     options[i].selected = false;
//         // }

//         // 排它思想: 先清空 再选中
//         // for (let i = 0; i < options.length; i++) {
//         //     // 排它 取消选中态
//         //     options[i].selected = false;

//         //     for (let j = 0; j < choose.length; j++) {
//         //         // 从choose里面匹配options被选中的那一项
//         //         if (options[i].value === choose[j]) {
//         //             // 更新数据
//         //            options[i].selected = true;
//         //         }
//         //     }
//         // }


//         // Es5中: indexOf lastIndex findIndex find  Es6+ includes
//         // for (let i = 0; i < options.length; i++) {
//         //     if (choose.indexOf(options[i].value) >= 0) {
//         //         options[i].selected = true;
//         //     } else {
//         //         options[i].selected = false;
//         //     }
//         // }


//         // Array.from(options, item => {
//         //     if (choose.indexOf(item.value) >= 0) {
//         //         item.selected = true;
//         //     } else {
//         //         item.selected = false;
//         //     }
//         // })


//         // 简化:
//         Array.from(options, item => item.selected = choose.indexOf(item.value) >= 0);

//     }

//     render() {
//         return (
//             <div>
//                 <p>
//                    <select multiple defaultValue={['isRed', 'isGreen']} ref={this.color}>
//                        <option value="isRed">red</option>
//                        <option value="isGreen">green</option>
//                        <option value="isBlue">blue</option>
//                    </select>
//                 </p>
                
//                 <div className="btns">
//                     <button onClick={ e => this.getData(e) }>获取数据</button>  
//                     &emsp;  
//                     <button onClick={ e => this.updateData(e) }>修改数据</button>    
//                 </div>  

//             </div>
//         );
//     }
// }



// 多选下拉框的约束性:
class App extends Component {
    constructor(props) {
        super(props);

        // 定义状态
        this.state = {
            colors: ['isRed', 'isGreen']
        }
    }


    // 修改数据的方法
    changeColors(e) {
        // console.log(e.target.options)
        // 定义空数组
        let arr = [];

        // 变量类数组
        Array.from(e.target.options, item => {
            if (item.selected) {
                arr.push(item.value)
            }
        })

        // 修改
        this.setState({ colors: arr })

    }

    // 获取数据
    getData(e) {
        console.log(this.state.colors);
    }
    
    // 修改数据
    updateData() {
        this.setState({
            colors: ['isGreen', 'isBlue']
        })
    }

    render() {
        return (
            <div>
                <p>
                   <select multiple value={this.state.colors} onChange={ e => this.changeColors(e) }>
                       <option value="isRed">red</option>
                       <option value="isGreen">green</option>
                       <option value="isBlue">blue</option>
                   </select>
                </p>
                
                <div className="btns">
                    <button onClick={ e => this.getData(e) }>获取数据</button>  
                    &emsp;  
                    <button onClick={ e => this.updateData(e) }>修改数据</button>    
                </div>  

            </div>
        );
    }
}


// 渲染
render(<App></App>, app); 
```
