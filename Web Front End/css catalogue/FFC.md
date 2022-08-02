## FFC（弹性格式化上下文）
- 弹性盒子由弹性容器和弹性子元素组成，弹性容器通过设置display属性的值为flex或者inline-flex将其定义为弹性容器，设置为 flex 的容器被渲染为一个块级元素，而设置为 inline-flex 的容器则渲染为一个行内元素。弹性容器中包含了一个或者多个弹性子元素。

- 采用 Flex 布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"。

- 容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做`main start`，结束位置叫做`main end`；交叉轴的开始位置叫做`cross start`，结束位置叫做`cross end`。项目默认沿主轴排列。单个项目占据的主轴空间叫做`main size`，占据的交叉轴空间叫做`cross size`。
#### 该属性是给父元素设置的
- `flex-direction`该属性决定主轴的方向（即项目的排列方向，它有四个值：
	- `row`（默认值）：主轴（X轴）为水平方向，起点在左端。
	- `row-reverse`：主轴（Y轴）为水平方向，起点在右端。
	- `column`：主轴（Y轴）为垂直方向，起点在上方。
	- `column-reverse`：主轴（Y轴）为垂直方向，起点在下方。
- `flex-wrap`默认情况下，项目都排在一条线（又称"轴线"）上。该属性定义，如果一条轴线排不下时如何换行。
	- `nowrap`（默认），不换行，当不能再收缩时，内容会溢出。
	- `wrap`：换行，第一行在上方，该属性会将盒子划分为n等份，n是父盒子宽高和子盒子排列行数共同作用的结果，例如当父盒子为100像素宽高，子盒子为25像素宽高时，子盒子有7个，则第一排放四个，并且将高分为两份，上下同为50像素，剩余三个子盒子会在下面左对齐显示。
	- `wrap-reverse`：换行，第一行在下方。
- `flex-flow`该属性为`flex-direction`和`flex-wrap`的复合属性，默认值为`row nowrap`。
- `justify-content`该属性定义了弹性盒子在主轴的对齐方式。
	-  `flex-start`（默认值）：与主轴的起点对齐
	-  `flex-end`：与主轴的终点对齐
	-  `center`： 居中
	-  `space-between`：两端对齐，项目之间的间隔都相等。
	- `space-around`：每个子盒子两侧的间隔相等。所以，子盒子之间的间隔是边框间隔的两倍。
	- `space-evenly`：每个子盒子之间的间隔相等，子盒子与边界之间也有间隔，同样是一倍间距。
	- ![[justify-content.png]]
- `align-items`属性定义项目在侧轴（交叉轴）上如何对齐。
	-  `flex-start`：侧轴的起点对齐，侧轴如果是Y轴则是从上方对齐，侧轴如果是X轴则是从左侧对齐。
	-  `flex-end`：侧轴的终点对齐。侧轴如果是Y轴则是从下方对齐，侧轴如果是X轴则是从右侧对齐。
	-  `center`：侧轴的中点对齐。
	-  `baseline`: 项目的第一行文字的基线对齐。
	-  `stretch`（默认值）：如果父元素未设置高度或设为auto，将子元素占满整个容器的高度。
- `align-content`属性定义了主轴方向有多行或多列的情况下，侧轴的对齐方式。
	-  `flex-start`：与侧轴的起点对齐。
	-  `flex-end`：与侧轴的终点对齐。
	-  `center`：与侧轴的中点对齐。
	-  `space-between`：如果主轴是X轴，则将每行的子元素平均间隔，两端对齐无间隔。
	- `space-around`：如果主轴是X轴，则将每行的子元素平均两倍间隔，两端有单倍间隔，相当于`padding`的效果。
	- `space-evenly`：如果主轴是X轴，则将每行的子元素平均间隔，两端同样有相等的间隔。

==注意：FFC布局中，float、clear、vertical-align属性不会生效。==

#### 该属性是给子元素设置的
-   `order:`属性定义项目的排列顺序。数值越小，排列越靠前，默认为**0**。
-   `flex-grow:`属性定义项目的放大比例，默认为**0**，即如果存在剩余空间，也不放大。
	- 如果所有项目的`flex-grow`属性都为1，则它们将等分剩余空间（如果有的话）。如果一个项目的`flex-grow`属性为2，其他项目都为1，则前者占据的剩余空间将比其他项多一倍。
-   `flex-shrink:`属性定义了项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。
	- 如果所有项目的`flex-shrink`属性都为1，当空间不足时，都将等比例缩小。如果一个项目的`flex-shrink`属性为0，其他项目都为1，则空间不足时，前者不缩小。
-   `flex-basis:`属性定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为`auto`，即项目的本来大小。
	- 它可以设为跟`width`或`height`属性一样的值（比如350px），则项目将占据固定空间。
-   `flex:`属性是`flex-grow`, `flex-shrink` 和 `flex-basis`的简写，默认值为`0 1 auto`。后两个属性可选。
	- 大多数情况下可以用预定义的简写形式。在这个教程中你可能经常会看到这种写法，许多情况下你都可以这么使用。下面是几种预定义的值：
	-   `flex: initial`
		- `flex: initial` 是把 flex 元素重置为 Flexbox 的初始值，它相当于 `flex: 0 1 auto`。在这里 `flex-grow` 的值为 0，所以 flex 元素不会超过它们 `flex-basis` 的尺寸。`flex-shrink` 的值为 1, 所以可以缩小 flex 元素来防止它们溢出。`flex-basis` 的值为 `auto`. Flex 元素尺寸可以是在主维度上设置的，也可以是根据内容自动得到的。
	-   `flex: auto`
		- `flex: auto` 等同于 `flex: 1 1 auto`；和上面的 `flex:initial` 基本相同，但是这种情况下，flex 元素在需要的时候既可以拉伸也可以收缩。
	-   `flex: none`
		- `flex: none` 可以把 flex 元素设置为不可伸缩。它和设置为 `flex: 0 0 auto` 是一样的。元素既不能拉伸或者收缩，但是元素会按具有 `flex-basis: auto` 属性的 flexbox 进行布局。
	-   `flex: <positive-number>`(正数)
		- `flex: 1` 或者 `flex: 2` 等等。它相当于`flex: 1 1 1`，`flex: 1 1 2`。改变的是`flex-basis`的值。
	- ==建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。==
-   `align-self:`属性允许单个项目有与其他项目不一样的对齐方式，可覆盖`align-items`属性。默认值为`auto`，表示继承父元素的`align-items`属性，如果没有父元素，则等同于`stretch`。
	-  `flex-start`：侧轴的起点对齐，侧轴如果是Y轴则是从上方对齐，侧轴如果是X轴则是从左侧对齐。
	-  `flex-end`：侧轴的终点对齐。侧轴如果是Y轴则是从下方对齐，侧轴如果是X轴则是从右侧对齐。
	-  `center`：侧轴的中点对齐。
	-  `baseline`: 项目的第一行文字的基线对齐。
	-  `stretch`（默认值）：如果父元素未设置高度或设为auto，将子元素占满整个容器的高度。


==不懂可到该网址查询
http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html
https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#%E8%B5%B7%E5%A7%8B%E7%BA%BF%E5%92%8C%E7%BB%88%E6%AD%A2%E7%BA%BF