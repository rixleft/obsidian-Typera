# css
使用css可以弥补html标签本身的不足，可以减少代码冗余，可以减小网页体积，可以减少网络带宽占用，可以提高用户体验，有利于SEO，对网页的重构改版有很好的支持。

## 样式表
### 1.行内样式表
写在html标签内部，`style="属性:属性值;" 如 <h1 style="color:red"></h1>`
但工作中不常用，代码冗余比较高（耦合性高），代码重复利用率比较低，不利于后期维护。

### 2.内部样式表
写在html标签的`<head>`标签内部，使用`<style>`标签包裹，相对于行内样式表这种写法利用率高，有利于后期的维护，但是这个样式表仅限于当前的这个页面，其他的页面就无法使用。

### 3.外部样式表
写在html文件外部，文件名为`xxx.css`，哪个页面需要就引入到该html页面中，代码冗余度低，复用性高，有利用后期维护。

#### 优先级
1.行内样式表的优先级最高 内部和外部样式表与书写顺序有关 采用就近原则
2.一个页面可以同时引入多个外部样式表,当发生冲突时采用就近原则

#### 外部样式表引入方式
```html
	<!--第一种引入方式：外链式，必须有rel="stylesheet" 作用是建立文档关联性，否则会引入失败-->
	 <link rel="stylesheet" href="xxx.css">
	 <!--第二种引入方式：导入式，必须是style的第一句话，否则不生效-->
	 <style>
        @import url(xxx.css);
    </style>
    
```
##### 区别：
1.老祖宗不同：link是html提供的一种引入方式，不光可以引入css文件还可以引入其他文件。@import是css提供的一种引入方式，只能引入css文件
2.加载顺序不同：link与html同时被加载 @import是当所有的html加载完成之后再加载对应的css
3.兼容性不同：link没有版本要求 @import必须在ie6以上才能支持
4.控制dom：link支持 @import不支持

## 选择器
| 选择器           | 权重    |
| ---------------- | ------- |
| 通配符选择器     | 0.0.0.0 |
| 标签选择器       | 0.0.0.1 |
| 类选择器         | 0.0.1.0 |
| ID选择器         | 0.1.0.0 |
| 伪元素选择器     | 0.0.0.0 |
| 属性选择器       | 0.0.1.0 |
| 伪类选择器       | 0.0.1.0 |
| 行内样式style="" | 1.0.0.0 |
| !important       | 无穷大  | 
