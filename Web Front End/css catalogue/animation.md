给页面添加动画效果时，需要使用`@keyframes`规则，在css中创建动画样式，并且，可以实现n次改变动画过程中的属性值变化。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        div {
            width: 400px;
            height: 50px;
            background: red;
            margin: 100px auto;
        }
        section {
            width: 50px;
            height: 50px;
            background: red;
            margin: 200px auto;
        }
        div:hover {
            animation: 1s play linear alternate infinite;
        }
        section:hover {
            animation: 8s move 3 linear alternate;
        }
        @keyframes play {
            from {
                width: 400px;
                background: red;
            }
            to {
                width: 600px;
                background: #000;
            }
        }
        @keyframes move {
            10% {
                width: 600px;
                background: rgb(4, 246, 16);
            }
            20% {
                width: 100px;
                background: rgb(224, 244, 8);
            }
            30% {
                width: 500px;
                background: rgb(244, 8, 177);
            }
            40% {
                width: 200px;
                background: rgb(201, 8, 244);
            }
            50% {
                width: 400px;
                background: rgb(24, 8, 244);
            }
            60% {
                width: 300px;
                background: rgb(8, 213, 244);
            }
            70% {
                width: 350px;
                background: rgb(8, 244, 217);
            }
            100% {
                width: 350px;
                background: rgb(253, 5, 21);
            }
        }
    </style>
</head>
<body>
    <div></div>
    <section></section>
</body>
</html>
```



| 属性                         | 描述                             |
| ---------------------------- | -------------------------------- |
| `animation:`                 | 复合属性                         |
| `animation-name:`            | 指定要绑定的选择器的关键帧的名称 |
| `animation-duration:`        | 动画的持续时间                   |
| `animation-delay:`           | 设置动画在启动前的延迟间隔时间   |
| `animation-timing-function:` | 设置动画将何如完成一个周期       |
| `animation-iteration-count:`  | 设置动画的播放次数               |
| `animation-play-state:`      | 指定动画是否正在运行或已停止     |
| `animation-fill-mode:`       | 规定到动画不播放或已完成时的状态 |
| `animation-direction:`       | 指定是否应该轮流反向播放动画     |


- `animation:`
	- 复合写法对上述属性不都要求有顺序，但持续时间和延迟时间，总是持续时间在前，延迟时间在后，其余并无顺序。
- `animation-name:`  
	- 指定了要绑定到选择器的关键帧的名称
- `animation-duration:`
	- 指定了动画的持续时间，默认值为0，意味着无动画效果。
- `animation-delay:` 
	- 定义了动画从多长时间内后开始执行，表示动画的延迟时间，它的值在复合属性写法下，默认是在持续时间之后。
- `animation-timing-function:`
	- `linear`  动画从头到尾的速度都是相同的
	- `ease` 默认值， 动画以低速开始，然后加快，在结束前变慢。
	- `ease-in` 动画以低速开始。
	- `ease-out` 动画以低速结束
	- `ease-in-out` 动画以低速开始和结束。
	- `steps(number,start|end)`  指定了时间函数中的间隔数量（步长）。有两个参数；
		- 第一个参数指定函数的间隔数，也可以认为是步长，该参数是一个正整数（大于 0）。 
		- 第二个参数是可选的，表示动画是从时间段的开头连续还是末尾连续。含义分别如下：
			-   start：表示动画的第一帧会被立即执行,直接从第二帧开始，然后以第一帧结束。
			-   end：默认值，end则表示动画从第一帧开始到正常结束。
- `animation-iteration-count:` 
	- 表示动画执行的次数，如果写具体数字，则表示需要执行几次，可以写`infinite`，表示无限次执行。
-  `animation-play-state:`  
	- `paused` 指定暂停动画。
	- `running`指定正在运行的动画（默认）。
- `animation-fill-mode:` 
	- 规定当动画不播放或者执行完成后的状态。
	- `none` 默认值，动画在执行之前和之后不会应用。
	- `forwards` 在动画结束后，停止在最后的状态。
	- `backwards`  ==动画将应用在 animation-delay 定义期间启动动画的第一次迭代的关键帧中定义的属性值。这些都是 from 关键帧中的值（当 animation-direction 为 "normal" 或 "alternate" 时）或 to 关键帧中的值（当 animation-direction 为 "reverse" 或 "alternate-reverse" 时）。==？？？？？？？
	- `both` 动画遵循 forwards 和 backwards 的规则。也就是说，动画会在两个方向上扩展动画属性。
	- `initial`设置该属性为它的默认值
	- `inherit` 从父元素继承该属性
- `animation-direction:` 定义是否循环交替反向播放动画。
	- `normal`默认值，动画按正常播放。
	- `reverse`动画反向播放
	- `alternate`动画在奇数次正向播放，在偶数次反向播放，实现有来有回的效果。
	- `alternate-reverse`动画在奇数次反向播放，在偶数次正向播放。
	- `initial`设置该属性为它的默认值
	- `inherit`从父元素继承该属性