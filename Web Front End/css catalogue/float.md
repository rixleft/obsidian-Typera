# 浮动
`float=left right none(默认)`

浮动会让盒子脱离正常的标准文档流，也叫标准流，文档流。

左浮动不会造成顺序颠倒，但右浮动会。
	解决办法：将所有需要右浮动盒子先左浮动并且加父级盒子，并让父级盒子有浮动。
	
浮动只会影响后面的元素，并不会对前面的盒子造成影响。并且浮动会盖住这个区域，并不影响盒子中的文字，文字会环绕显示。

添加了浮动元素后，如果盒子没有设置宽度，则盒子的宽度是是内容的宽度。

### 利用浮动和外边距使页面先加载中间再加载两端，同时保证左中右的布局。

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
        .main {
            width: 600px;
            height: 200px;
            margin: 50px auto;
            background: gray;
        }
        .main1 {
            width: 200px;
            height: 100px;
            background: red;
            float: left;
            margin-left: -500px;
        }
        .main2 {
            width: 300px;
            height: 200px;
            background: orange;
            float: left;
            margin-left: 200px;
        }
        .main3 {
            width: 100px;
            height: 100px;
            background: blue;
            float: left;
        }
    </style>
</head>
<body>
    <!--用css的margin可以设置负值去实现,如果给2设置margin-left负值可以实现2和1调换位置，那么此时3的贴边元素就变成了1
    2向前走多少才能实现外置的互换：走2和1宽度的和
	2和1 互换位置之后，2跑到了父元素的外部，要想保证不变1需要向后走，走2的宽度-->
    <div class="main">
        <div class="main2">中间</div>
        <div class="main1">左边</div>
        <div class="main3">右边</div>
    </div>
</body>
</html>
```