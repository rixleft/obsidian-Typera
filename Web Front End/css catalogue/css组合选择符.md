# 组合选择符
## 后代选择器（以空格分隔）
后代选择器用于选取某元素的后代元素。以实现选取所有`<div>`标签里的 `<p>`元素。

```css
	div p {
	backgroun-color:pink;
	}
```
## 子元素选择器（以大于号分隔）
和后代选择器相比，子元素选择器只选择自己的下一级元素，即“亲儿子“，并不会选择所有后代中的`<p>。
```css
	div>p {
	background-color:pink;
	} 
```

## 相邻兄弟选择器（以加号分隔）
有相同的父元素，并且一个元素紧跟在另一元素后面且相邻，可以使用相邻兄弟选择器，以实现选取了所有的位于`<div>`元素后面的第一个`<p>`元素。
比如一个`<div>`后跟了两个`<p>`标签，则只会向后选择第一个。
```css
	div+p {
	background-color:pink;
	}
```

### 例子
[[伪类选择器]]和相邻兄弟选择器一起实现下列效果。
```html
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        input {
            outline: none;
            float: left;
            height: 50px;
            box-sizing: border-box;
            border: 1px solid rgb(255, 230, 2);
        }
        .btn {
            border-left: none;
        }
        input:focus {
            border: 1px solid red;
        }
        input:focus+input {
            border-color: red;
        }
    </style>
</head>
<body>
    <input type="text">
    <input type="button" value="搜索" class="btn">
</body>
</html>
```


## 普通兄弟选择器（以波浪号分隔）
会选取指定元素之后的兄弟元素，即使自身的子元素有兄弟元素，也并不会选择自身的子元素。
比如`<div>`标签有子元素`<p>`标签并且也有兄弟元素`<p>`标签，只会选择自己的兄弟元素，不选择自己的子元素。
```css
	div~p {
	background-color:pink;
	}
```