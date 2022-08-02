# 属性
| 属性           | 属性值                                             |
| -------------- | -------------------------------------------------- |
| `color`        | rgb或#000000或英文单词(如pink)                     |
| `font-size`    | px像素 em rem pt磅 1em=1rem=16px                   |
| `font-family`  | 英文单词组成，尽量别写汉字  （如"Times New Roman") |
| `font-weight`  | 100-900九个等级或单词 bold lighter normal          |
| `font-style`   | italic 倾斜 oblique 倾斜（大） normal 正常         |
| `font-variant` | 小写英文字母变成小型的大写字母 small-caps          |
| `line-height`  | 使行间距等于行高可达到垂直居中的效果                   |

### 复合写法
`font:font-weight font-style font-variant font-size/line-height`
前三个值可改变顺序，后三个不可以改变顺序，且缺一不可。

| 属性              | 属性值                                                                |
| ----------------- | --------------------------------------------------------------------- |
| `text-align`      | left 默认 center 居中 right 居右 justify 两端对齐（针对英文单词生效） |
| `word-spacing`    | 像素 可以设置负值                                                     |
| `letter-spacing`  | 像素 可以设置负值                                                     |
| `text-decoration` | none underline overline line-throught 三条线可同时出现                |
| `text-indent`     | 首行缩进 如两字符 2em 单位：px em                                     |
| `vertical-align`  | 目前只有img支持 top middle bottom baseline(默认)                      |
| `text-transform`  | uppercase大写 lowercase小写 capitalize首字母大写                      |
| `overflow`        | hidden scroll auto inherit visible默认值                              |
| `text-overflow`   | clip裁切  ellipsis省略号                                                                      |
overflow
		hidden 溢出裁切隐藏 溢出的内容不可见
		scroll 以滚动条的形式去显示我们溢出的内容  无论内容是否存在溢出都会显示滚动条的区域
		 auto  自动 如果内容存在溢出，那个方向有溢出就显示那个方向的滚动条 如果内容没有溢出就不显示滚动条
		inherit 继承父元素的overflow属性值
		visible 默认值 

white-space
		 pre 将所有的回车换行空格缩进全部都解析 内容遇到边界不会换行 遇到br会换行
        pre-line 将所有的回车换行解析 内容遇到边界会换行  遇到br会换行
        pre-wrap 将所有的回车换行空格缩进全部都解析 内容遇到边界会换行 遇到br会换行
        nowrap 忽略所有的回车换行 遇到边界不会换行 遇到br会换行   强制在一排显示
        normal 默认值
        inherit 继承父元素的white-space的属性值 （兼容性问题）


### 截字
- 截字的必要条件
	- 单行文本溢出
        - `width:value;` 有一定的宽度 
        - `overflow:hidden;` 溢出裁切
        - `white-space:nowrap;` 强制在一排显示
        - `text-overflow:ellipsis;` 省略号 
	- 多行文本溢出
		- `overflow:hidden;` 溢出裁切
		- `text-overflow:ellipsis;`省略号
		- `display:-webkit-box;`弹性盒模型显示
		- `-webkit-line-clamp:number;`限制在盒子内文本的行数
		- `-webkit-box-orient:vertical;`盒子里子元素的排列方式

