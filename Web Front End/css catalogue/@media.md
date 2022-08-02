## 媒体查询
- 使用@media查询，可以针对不同的媒体类型定义不同的样式，@media可以针对不同的屏幕尺寸设置不同的样式，特别是如果你需要设置设计响应式的页面，@media 是非常有用的。当重置浏览器大小的过程中，页面也会根据浏览器的宽度和高度重新渲染页面。
- 可以通过以下两种方式来定义媒体查询：  
	-  使用 @media 或 @import 规则在样式表中指定对应的设备类型；
	-  用 media 属性在 `<style>、<link>、<source>` 或其他HTML元素中指定特定的设备类型。

@media
```css
	/* 在小于或等于 992 像素的屏幕上，将背景色设置为蓝色 */
@media screen and (max-width: 992px) {
	body {
		background-color: blue;
	}
}

/* 在 600 像素或更小的屏幕上，将背景色设置为橄榄色 */
@media screen and (max-width: 600px) {
	body {
	    background-color: olive;
	}
}
```

@import
```css
	@import url("css/screen.css") screen;   
	/* 引入外部样式，该样式仅会应用于电脑显示器 */
	@import url("css/print.css") print;     
	/* 引入外部样式，该样式仅会应用于打印设备 */
body {
    background: #f5f5f5;
    line-height: 1.2;
}
```

**注意：所有 @import 语句都必须出现在样式表的开头，而且在样式表中定义的样式会覆盖导入的外部样式表中冲突的样式。**

| 媒体类型     | 描述                                     |
| ------------ | ---------------------------------------- |
| `all`        | 表示所有的媒体设备                       |
| `aural`      | 已废弃，表示语音和音频合成器（听觉设备）         |
| `braille`    | 已废弃，表示盲人用点字法触觉回馈设备             |
| `embossed`   | 已废弃，表示盲人用点字法打印机                   |
| `handheld`   | 已废弃，表示小型手持设备，手机，平板             |
| `print`      | 表示打印机                               |
| `projection` | 已废弃，表示投影设备                             |
| `screen`     | 表示电脑显示器                           |
| `tty`        | 已废弃，表示使用固定密度字母栅格的媒体，如打字机 |
| `tv`         | 已废弃，表示电视机类型的设备                                         |

- @media 设备（all screen speech print）（范围）{对应的css}
- @media 设备 （所有 电脑手机等 阅读器 打印）and（范围）and（范围）and（范围）......{对应的css}
- `@media not|only mediatype and (mediafeature and|or|not mediafeature) {CSS-Code;}`
- 下列css代码表示宽度为500像素到700像素之间时，`<body>`的背景色为蓝色。
```css
	@media (min-width:500px) and (max-width:700px) {
            body {
                background: blue;
            }
```

在媒体查询功能里显示`display:none`和隐藏`display:block`比较常用   
注意：如果使用了弹性盒还存在显示和隐藏  那么此时显示的时候只需要写`dispaly:flex`。



```html
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css文件1" media="(min-width:300px)">
    <link rel="stylesheet" href="./css文件2" media="(min-width:400px)">
    <link rel="stylesheet" href="./css文件3" media="(min-width:500px) and (max-width:700px)">
</head>
<body>
    
    <!-- 
        注意：媒体查询时，一定要添加样式表，防止溜掉某个尺寸的样式没写，要注意它的使用顺序，书写时元素的属性值要从小向大写。
     -->
</body>
</html>
```


## 媒体特性
除了具体的类型外，还可以通过一些属性来描述设备的具体特征，例如宽度、高度、分辨率等，如下表所示：
| 值                        | 描述                                                                                |
| ------------------------- | ----------------------------------------------------------------------------------- |
| `aspect-ratio`            | 输出设备页面可见区域的宽高比                                                        |
| `color`                   | 输出设备每个像素的比特值，常见的有 8、16、32 位。如果设备不支持输出彩色，则该值为 0 |
| `color-index`             | 输出设备的颜色查询表中的条目数量。如果没有使用颜色查询表，则该值等于 0              |
| `device-aspect-ratio`     | 输出设备的宽高比                                                                    |
| `device-height`           | 输出设备屏幕的可见高度                                                              |
| `device-width`            | 输出设备屏幕的可见宽度                                                              |
| `grid`                    | 查询输出设备使用的是网格屏幕还是点阵屏幕                                            |
| `height`                  | 页面可见区域的高度                                                                  |
| `max-aspect-ratio`        | 输出设备屏幕可见区域宽度与高度的最大比率                                            |
| `max-color`               | 输出设备每个像素比特值的最大值                                                      |
| `max-color-index`         | 输出设备的颜色查询表中的最大条目数                                                  |
| `max-device-aspect-ratio` | 输出设备屏幕可见区域宽度与高度的最大比率                                            |
| `ma-device-height`        | 输出设备屏幕可见区域的最大高度                                                      |
| `max-device-width`        | 输出设备屏幕的最大可见宽度                                                          |
| `max-height`              | 页面可见区域的最大高度                                                              |
| `max-monochrome`          | 输出设备单色帧缓冲区中每个像素的最大位深度。如果设备并非黑白屏幕，则该值为 0        |
| `max-resolution`          | 设备的最大分辨率                                                                    |
| `max-width`               | 页面可见区域的最大宽度                                                              |
| `min-aspect-ratio`        | 输出设备屏幕可见区域宽度与高度的最小比率                                            |
| `min-color`               | 输出设备每个像素比特值的最小值                                                      |
| `min-color-index`         | 输出设备的颜色查询表中的最小条目数                                                  |
| `min-device-aspect-ratio` | 输出设备的屏幕可见区域宽度与高度的最小比率                                          |
| `min-device-width`        | 输出设备的屏幕的最小可见宽度                                                        |
| `min-device-height`       | 输出设备的屏幕的最小可见高度                                                        |
| `min-height`              | 页面可见区域的最小高度                                                              |
| `min-monochrome`          | 输出设备单色帧缓冲区中每个像素的最小位深度。如果设备并非黑白屏幕，则该值为 0        |
| `min-resolution`          | 设备的最小分辨率                                                                    |
| `min-width`               | 页面可见区域的最小宽度                                                              |
| `monochrome`              | 输出设备单色帧缓冲区中每个像素的位深度。如果设备并非黑白屏幕，则该值为 0            |
| `orientation`             | 页面可见区域的旋转方向                                                              |
| `resolution`              | 设备的分辨率。如：96dpi、300dpi、118dpcm                                            |
| `scan`                    | 电视类设备的扫描工序                                                                |
| `width`                   | 页面可见区域的宽度                                                                  |


## 逻辑操作符
逻辑操作符包含 not、and 和 only 三个，通过逻辑操作符可以构建复杂的媒体查询，可以通过逗号来分隔多个媒体查询，将它们组合为一个规则。  

-  and：用于将多个媒体查询组合成一条媒体查询，当每个查询规则都为真时则该条媒体查询为真，另外通过 and 操作符还可以将媒体特性与媒体类型结合在一起；
```css
	@media (min-width:800px) and (max-width:1200px) and (orientation:portrait) {
	 /*仅在宽度为 800 到 1200 像素且方向是纵向时才能激活*/
	 }
```

-  not：用于否定媒体查询，当查询规则不为真时则返回 true，否则返回 false。如果使用 not 操作符，则还必须指定媒体类型；
```css
	@media (min-width:800px) or (orientation:portrait) {
		/*宽度至少是 800 像素或方向是纵向的，则会应用该规则。*/
	}
```
	
-  only：仅在整个查询匹配时才会生效，当不使用 only 时，旧版的浏览器会将 screen and (max-width: 500px) 简单地解释为 screen，忽略查询的其余部分，并将样式应用于所有屏幕。 如果使用 only 运算符，则还必须指定媒体类型。
```css
	@media screen , (min-width : 768px) {
    /*匹配电脑屏幕或者宽度大于 768 像素的设备*/
 }
```

`