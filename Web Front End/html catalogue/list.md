# 语法
## 1.无序列表
无序列表的属性值有四个，disc 默认的实心圆，circle 空心圆， square 实心方块， none 没有。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>无序列表</title>
</head>
<body>
	<ul type="disc">
        <li>无序列表</li>
        <li>无序列表</li>
        <li>无序列表</li>
	</ul>
	<ul type="circle">
        <li>无序列表</li>
        <li>无序列表</li>
        <li>无序列表</li>
	</ul>
	<ul type="square">
        <li>无序列表</li>
        <li>无序列表</li>
        <li>无序列表</li>
	</ul>
	<ul type="none">
        <li>无序列表</li>
        <li>无序列表</li>
        <li>无序列表</li>
	</ul>
	<!--在无序列表的<li>标签里填写有序列表的type属性，可改变单个<li>标签的序号-->
	<ul>
        <li type="a">无序列表</li>
        <li type="A">无序列表</li>
        <li type="1">无序列表</li>
        <li type="i">无序列表</li>
        <li type="I">无序列表</li>
	</ul>
</body>
</html>
```
## 2.有序列表
有序列表的属性值有五种，1 ， A ，a ， I ， i 。 
start属性可以决定列表符号从第几个开始，值只能是数字。reversed 倒序。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>有序列表</title>

</head>
<body>
	<ol type="A">
        <li>有序列表</li>
        <li>有序列表</li>
        <li>有序列表</li>
    </ol>
    <ol type="a">
        <li>有序列表</li>
        <li>有序列表</li>
        <li>有序列表</li>
    </ol>
    <ol type="I">
        <li>有序列表</li>
        <li>有序列表</li>
        <li>有序列表</li>
    </ol>
    <ol type="i">
        <li>有序列表</li>
        <li>有序列表</li>
        <li>有序列表</li>
    </ol>
    <ol type="1">
        <li>有序列表</li>
        <li>有序列表</li>
        <li>有序列表</li>
    </ol>
    <ol type="1" start="3">
        <li>有序列表</li>
        <li>有序列表</li>
        <li>有序列表</li>
    </ol>
    <ol type="1" start="1" reversed>
        <li>有序列表</li>
        <li>有序列表</li>
        <li>有序列表</li>
    </ol>
</body>
</html>
```
## 3.自定义列表
注意：一个自定义列表里有一个dt 可以同时存在多个dd， 默认情况下dd是存在一定的缩进效果。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>自定义列表</title>
</head>
<body>
	<dl>
         <dt>问题</dt>
         <dd>答案</dd>
         <dd>答案</dd>
	</dl>
</body>
</html>


```
# 效果
### 1.无序列表
![[无序列表.png]]

## 2.有序列表
![[有序列表.png]]

## 3.自定义列表
![[自定义列表.png]]


==注意：ul只能使用ul的type值，ol只能使用ol的type值，li可以使用任何一个type值。==