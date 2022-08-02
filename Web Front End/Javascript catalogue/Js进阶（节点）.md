# JavaScript进阶 第一天


## ECharts使用

ECharts是百度公司开源的一个使用 JavaScript 实现的开源可视化库，兼容性强，提供直观，交互丰富，可高度个性化定制的数据可视化图表。

**下载：** [https://www.jsdelivr.com/package/npm/echarts?path=dist](https://www.jsdelivr.com/package/npm/echarts?path=dist)

**引入：** `<script src="echarts.js"></script>`

**配置：**
```js
<script type="text/javascript">  
   var myChart = echarts.init( element );   // 基于准备好的dom，初始化echarts实例  
​  
   var option = {    // 指定图表的配置项和数据  
     title: {},  
     legend: {},  
     xAxis: {},  
     yAxis: {},  
     series: []  
   };  
​  
   myChart.setOption(option);    // 使用刚指定的配置项和数据显示图表。  
</script> 
```

**常用配置项：**

**title：** 图表标题，可配置标题和副标题，设置标题位置和颜色等。

**xAxis：** x轴配置

**yAxis：** y轴配置

**series：** 数据列。图表上一个或多个数据系列

**tooltip：** 数据提示框，以悬浮层的形式提示该点的数据

**legend：** 数据图例，点击图例按钮可显示隐藏指定数据。

**toolbox：**工具栏，内置有导出图片，数据视图，动态类型切换，数据区域缩放，重置五个工具。

**更多配置项：** [https://echarts.apache.org/zh/option.html#title](https://echarts.apache.org/zh/option.html)

## DOM 进阶

### 节点介绍

由于 HTML 是根据 XML 扩展出来的简化版本，在文档规范上与 XML 基本一致，因此，HTML 与 XML 使用的是同一套 DOM 标准规范。

DOM 是 HTML 和 XML 文档的通用编程接口。它提供了对文档的结构化的表述，并定义了如何通过 JavaScript 来访问 HTML 和 XML ，并改变文档的结构，样式和内容的相关属性和方法。

DOM对象是根据 HTML 或 XML 文档结构生成的 JavaScript 对象。

节点是DOM对象中的最小组成单位，根据功能不同，节点被划分为了12种类型。

### 节点类型

| 节点类型常量                | 节点类型值 | 描述                                          |
| --------------------------- | ---------- | --------------------------------------------- |
| ELEMENT_NODE                | 1          | HTML 或 XML 标签，例如 `<div>` 和`<img>` 。      |
| ATTRIBUTE_NODE              | 2          | 标签上的属性 （ DOM4 移除）|  
| TEXT_NODE                   | 3          | 标签中实际的文字（包括回车，换行等空白字符）  |
| CDATA_SECTION_NODE          | 4          | 元数据字符串，例如 `<!CDATA[[ … ]]>`。          |
| ENTITY_REFERENCE_NODE       | 5          | XML 实体引用节点。 （ DOM4 移除）             |
| ENTITY_NODE                 | 6          | XML `<!ENTITY ...>` 节点。 （DOM4 移除）        |
| PROCESSING_INSTRUCTION_NODE | 7          | 处理指令，例如 `<?xml-stylesheet ... ?>` 声明。 |
| COMMENT_NODE                | 8          | HTML 或 XML 文档中的注释。                    |
| DOCUMENT_NODE               | 9          | 特指 document 对象                            |
| DOCUMENT_TYPE_NODE          | 10         | 文档声明，例如 `<!DOCTYPE html>`                |
| DOCUMENT_FRAGMENT_NODE      | 11         | DocumentFragment 节点 （通过 JS 创建）        |
| NOTATION_NODE               | 12         | XML `<!NOTATION ...>` 节点。 （DOM4 移除）      |


### HTML 文档中的节点类型

HTML 中常用的节点类型包括：

1 元素类型

2 属性类型(DOM4中被废弃)

3 文本类型

8 注释类型

9 文档类型 （document对象）

获取指定元素的所有类型子节点： childNodes

查看节点类型： nodeType

### 节点属性

所有类型的节点，都有三个标准属性：

**nodeType :** 表示节点类型的数字值

**nodeName:** 表示节点名称的字符串（默认大写）

**nodeValue:** 节点名称（nodeName）对应的值

| 节点类型 | nodeType | nodeName     | nodeValue |
| -------- | -------- | ------------ | --------- |
| 元素节点 | 1        | 大写的标签名 | null      |
| 属性节点 | 2        | 属性的名称   | 属性的值  |
| 文本节点 | 3        | `#text`        | 文本内容  |
| 注释节点 | 8        | `#comment`     | 注释内容  |
| 文档节点 | 9        | `#document`    | null      |

### 以节点的方式获取元素

**childNodes** 获取指定元素的所有子节点（第一级后代标签）

childNodes 包含所有html中存在的节点类型

**firstChild** 获取指定元素的第一个子节点 （包括文本节点和注释节点）

**lastChild** 获取指定元素的最后一个子节点 （包括文本节点和注释节点）

**parentNode** 获取指定元素的直接父级元素标签

**nextSibling** 获取指定元素的下一个兄弟节点 （包括文本节点和注释节点）

**previousSibling** 获取指定元素的上一个兄弟节点 （包括文本节点和注释节点）
```js
<!DOCTYPE html>  
<html lang="zh-CN">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <link rel="icon" href="data:image/ico;base64,=">  
  <title>Document</title>  
</head>  
<body>  
    
  <ul id="list">  
    <!-- 这是一个注释节点 -->  
    <li>列表01</li>  
    <li>列表02</li><!--注释节点--><li>列表03</li><li>列表04</li>  
    <li>列表05</li>  
  </ul>  
​  
  <script>  
​  
    var list = document.getElementById('list');  
​  
    // console.log(list);  
    // 获取 list 元素的所有子节点  
    console.log(list.childNodes);  
    // 查看节点数量  
    // console.log(list.childNodes.length);  
​  
    // 查看具体节点  
    // 标签之间的换行符  
    console.log(list.childNodes[0]); // #text  
    // HTML中的注释  
    console.log(list.childNodes[1]); // <!-- 这是一个注释节点 -->  
    // 标签之间的换行符  
    console.log(list.childNodes[2]); //  #text  
    // li 标签  
    console.log(list.childNodes[3]); // <li>...</li>  
​  
    // 查看节点类型  
    console.log(list.childNodes[0].nodeType); // 3  
    console.log(list.childNodes[1].nodeType); // 8  
    console.log(list.childNodes[2].nodeType); // 3  
    console.log(list.childNodes[3].nodeType); // 1  
    // 所有属性都被自动存储在 attributes 属性中，查看属性节点要通过 attributes 属性  
    console.log(list.attributes[0].nodeType); // 2  
    console.log(document.nodeType); // 9  
​  
    // 查看节点名称  
    // 文本节点的名称固定为 #text  
    console.log(list.childNodes[0].nodeName); // #text  
    // 注释节点的名称固定为 #comment  
    console.log(list.childNodes[1].nodeName); // #comment  
    console.log(list.childNodes[2].nodeName); // #text  
    // 元素节点的名称为 大写的标签名  
    console.log(list.childNodes[3].nodeName); // LI  
    // 属性节点的名称为属性名称  
    console.log(list.attributes[0].nodeName); // id  
    // document 节点的名称固定为 #document  
    console.log(document.nodeName); // #document  
​  
    // 查看节点的值  
    // 文本节点的 nodeValue 就是文本内容  
    console.log(list.childNodes[0].nodeValue); //   
    // 注释节点的 nodeValue 就是注释内容   
    console.log(list.childNodes[1].nodeValue); // 这是一个注释节点   
    console.log(list.childNodes[2].nodeValue); //       
    // 元素节点的 nodeValue 为 null  
    console.log(list.childNodes[3].nodeValue); // null  
    // 属性节点的 nodeValue 为 属性的值  
    console.log(list.attributes[0].nodeValue); // list  
    // document节点的 nodeValue 为 null  
    console.log(document.nodeValue); // null  
​  
​  
    // list 节点的第一个子节点   
    // （有换行为文本节点，去掉换行，为注释节点，如果没有换行和注释，则为第一个li标签）  
    console.log( list.firstChild );  
    // list 节点的最后一个子节点  
    console.log( list.lastChild );  
    // list 节点的直接父级元素标签  
    console.log( list.parentNode);  
​  
    var li = document.getElementsByTagName('li');  
​  
    // 下一个兄弟节点 （包括文本节点和注释节点）  
    console.log( li[1].nextSibling ); // <!--注释节点-->  
    console.log( li[2].nextSibling ); // <li>...</li>  
    console.log( li[3].nextSibling ); // #text  
​  
    // 上一个兄弟节点 （包括文本节点和注释节点）  
    console.log( li[1].previousSibling ); // #text  
    console.log( li[2].previousSibling ); // <!--注释节点-->  
    console.log( li[3].previousSibling ); // <li>...</li>  
​  
    // 获取子节点 （ie678中还会获取到注释节点）  
    // console.log( list.children );  
      
  </script>  
​  
</body>  
</html>
```


### 创建新的节点

**createElement()** 创建元素节点

**参数：** 字符串类型的 html 标签名

**createTextNode()** 创建文本节点

**参数：** 字符串类型的文本内容

**createComment()** 创建注释节点

**参数：** 字符串类型的注释内容

**说明：** 所有方法都只能通过 document 对象调用

```js
<!DOCTYPE html>  
<html lang="zh-CN">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <link rel="icon" href="data:image/ico;base64,=">  
  <title>Document</title>  
</head>  
<body>  
​  
  <div id="box"></div>  
​  
  <script>  
    var box = document.getElementById('box');  
​  
    // 创建ul标签  
    var ul = document.createElement('ul');  
    // 创建注释节点  
    var comment = document.createComment("这是通过JS创建的注释节点");  
​  
    ul.appendChild(comment);  
​  
    for (var i=0; i<5; i++) {  
      // 创建文本节点  
      var text = document.createTextNode("这是通过JS创建的文本节点" + i);        
      // 创建li标签  
      var li = document.createElement('li');  
      // 创建换行符  
      var rn = document.createTextNode("\n");  
      li.appendChild(text);  
      ul.appendChild(li);  
      ul.appendChild(rn);  
    }  
​  
    box.appendChild(ul);  
    console.log(ul.childNodes);  
​  
  </script>  
</body>  
</html>
```

### 节点的添加和删除

**appendChild(node)** 将元素添加到指定元素的最后 （追加子节点）

**参数：** 要追加的节点

**返回值：** 追加的节点

**insertBefore(node1, node2)** 将一个元素插入到另一个元素的前面

**参数：** node1 为要插入的元素 node2 为插入位置

（将node1插入到node2前面）

**返回值：** 插入的节点

**removeChild(node)** 从指定元素中移除子元素节点

**参数：** 要删除的节点

**返回值：** 被删除的节点

**说明：** 所有方法都是通过父级节点调用

```js
<!DOCTYPE html>  
<html lang="zh-CN">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <link rel="icon" href="data:image/ico;base64,=">  
  <title>Document</title>  
</head>  
<body>  
    
  <ul id="list">  
    <li>列表01</li>  
    <li>列表02</li>  
    <li>列表03</li>  
    <li>列表04</li>  
  </ul>  
​  
  <script>  
    var list = document.getElementById('list');  
    var lis = list.getElementsByTagName('li');  
​  
    // 创建新的li标签  
    var li1 = document.createElement('li');  
    li1.innerHTML = "创建的li标签1111";  
​  
    // 将创建的li标签添加到id为list的标签的最后面（追加新标签）  
    // 返回值为 新创建的 li 标签  
    console.log( list.appendChild(li1) );  
​  
    // 如果添加的元素是已经在页面中的元素，则是移动元素  
    // 将第二个li移动到ul标签的最后，返回值为被移动的标签  
    console.log( list.appendChild(lis[1]) );  
​  
    // 创建新的li标签  
    var li2 = document.createElement('li');  
    li2.innerHTML = "创建的li标签2222";  
​  
    // 将创建的li标签插入到已有的第一个li标签的前面  
    // 第一个参数： 指定要插入的元素  
    // 第二个参数： 指定要插入到哪个元素的前面  
    console.log( list.insertBefore(li2, lis[0]) );  
​  
    // 如果插入的是页面中已有的元素，则是移动元素  
    // 将第三个li移动到第一个li的前面，返回值为移动的标签  
    console.log( list.insertBefore(lis[2], lis[0]) );  
​  
    // 创建新的li标签  
    var li3 = document.createElement('li');  
    li3.innerHTML = "创建的li标签3333";  
​  
    // 如果第二个参数为null，则为 appendChild() 效果。  
    console.log( list.insertBefore(li3,null) );  
​  
    // 从父级元素中删除指定元素  
    // 删除第三个li元素，返回值为被删除的节点  
    console.log( list.removeChild(lis[2]) );  
​  
    // 被删除的元素可以再次添加回到页面中  
    var li4 = list.removeChild(lis[3]);  
    list.appendChild(li4);  
​  
  </script>  
</body>  
</html>
```

### 节点的替换和克隆

**replaceChild(newChild, oldChild)** 用 newChild 替换掉 oldChild

**参数：** newChild 新节点 oldChild 被替换的节点

**返回值：** 被替换的节点 （即 oldChild 节点）

通过父级节点调用

**cloneNode(deep)** 克隆指定节点

**参数：** deep 布尔值 true 表示克隆所有后代节点 false 只克隆当前节点

**返回值：** 克隆得到的新节点

在被克隆的节点上调用

```js
<!DOCTYPE html>  
<html lang="zh-CN">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <link rel="icon" href="data:image/ico;base64,=">  
  <title>Document</title>  
  <style>  
    #box1,#box2 {  
      border: 5px solid #333;  
      width: 300px;  
      height: 200px;  
    }  
    #box1 div, #box2 div {  
      width: 100px;  
      height: 100px;  
    }  
    #div1 {  
      background: red;  
    }  
    #div2 {  
      background: blue;  
    }  
  </style>  
</head>  
<body>  
    
  <div id="box1">  
    <div id="div1"></div>  
  </div>  
​  
  <div id="box2">  
    <div id="div2"></div>  
  </div>  
​  
  <h2 id="title">  
    <!-- 这是一个注释节点 -->  
    这是一个标题  
    <span>这是副标题</span>  
  </h2>  
​  
  <script>  
    var box1 = document.getElementById('box1');  
    var box2 = document.getElementById('box2');  
    var div1 = document.getElementById('div1');  
    var div2 = document.getElementById('div2');  
​  
    // 创建新节点  
    var div3 = document.createElement('div');  
    div3.style.backgroundColor = "green";  
​  
    box2.onclick = function() {  
​  
      // 使用 div3 替换 div2  
      // box2.replaceChild(div3, div2);  
​  
      // 如果用来替换的节点是页面中已有的节点，会先将节点从原来位置删除  
      // 需要注释掉上一行 replaceChild 方法，这行才能正常执行  
      // box2.replaceChild(div1, div2);  
​  
    };  
​  
    var title = document.getElementById('title');  
​  
    var newEl1 = title.cloneNode();  
​  
    // 不设置参数，默认为false ，只会克隆标签本身  
    console.log(newEl1);  
    document.body.appendChild(newEl1);  
​  
    var newEl2 = title.cloneNode(true);  
​  
    // 设置参数 true ，会克隆所有后代节点，包括空白文本节点和注释节点  
    console.log(newEl2);  
    document.body.appendChild(newEl2);  
  </script>  
</body>  
</html>
```


### jQuery中的节点操作

**$(元素字符串)** 创建元素： 如 \$('\<div>\')

**ele1.append(ele2)** 将ele2添加到ele1的子节点的最后面，相当于原生的 appendChild() 方法

**appendTo()** 与 append 方法相同，只是将书写顺序颠倒过来

**ele1.prepend(ele2)** 将ele2添加到ele1子节点的最前面，原生没有类似方法

**prependTo()** 与 prepend 方法相同，只是将书写顺序颠倒过来

**after()** 在所有选中的 jq对象后面添加指定元素

**before()** 在所有选中的 jq对象前面添加指定元素

**insertBefore()** 与 before 方法相同，只是将书写顺序颠倒过来

**insertAfter()** 与 after 方法相同，只是将书写顺序颠倒过来



```js
<!DOCTYPE html>  
<html lang="zh-CN">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <link rel="icon" href="data:image/ico;base64,=">  
  <title>Document</title>  
  <style>  
    hr {height: 10px; background-color: blueviolet;}  
  </style>  
</head>  
<body>  
​  
​  
  <ul id="list">  
    <li>列表001</li>  
    <li>列表002</li>  
    <li>列表003</li>  
    <li>列表004</li>  
    <li>列表005</li>  
  </ul>  
​  
  <hr>  
​  
  <h2>hello world<em> subTitle</em></h2>  
  <h3>前端开发<em> 副标题</em></h3>  
​  
  <hr>  
​  
  <ol id="order">  
    <li>有序列表01</li>  
    <li>有序列表02</li>  
    <li>有序列表03</li>  
    <li>有序列表04</li>  
    <li>有序列表05</li>  
  </ol>  
​  
  <hr>  
​  
  <ul id="todo">  
    <li>列表01</li>  
    <li>列表02</li>  
    <li>列表03</li>  
    <li>列表04</li>  
    <li>列表05</li>  
  </ul>  
​  
  <hr>  
​  
  <ul id="insert">  
    <li>列表01</li>  
    <li>列表02</li>  
    <li>列表03</li>  
    <li>列表04</li>  
    <li>列表05</li>  
  </ul>  
    
  <script src="../js/jquery/jquery-1.12.4.js"></script>  
  <script>  
      
    // 创建新标签  
    var newLi = $('<li>新创建的li标签111</li>');  
​  
    // 将创建的标签 newLi 添加到 #list 元素的子节点的最后面   
    // 与原生的 appendChild() 方法功能相同  
    $('#list').append(newLi);  
    // 如果参数是页面中已有的元素，则是移动元素。  
    $('#list').append($('#list li:eq(1)'));  
​  
    // 创建新标签  
    var newLi2 = $('<li>新创建的li标签222</li>');  
​  
    // 将创建的标签 newLi 添加到 #list 元素的子节点的最前面   
    // 原生没有类似方法  
    $('#list').prepend(newLi2);  
    // 如果参数是页面中已有的元素，则是移动元素。  
    $('#list').prepend($('#list li:eq(1)'));  
​  
    // 与 append 方法相同，只是将书写顺序颠倒过来  
    $('<li>新li标签333</li>').appendTo('#list');  
    // 与 prepend 方法相同，只是将书写顺序颠倒过来  
    $('<li>新li标签444</li>').prependTo('#list');  
​  
    // 在所有选中的 jq对象后面添加指定元素  
    $('#order li').after("<li>new li tags 111</li>");  
    // 如果是已有元素，会移动并克隆已有元素  
    $('#order li').after($('h2'));  
​  
    // 在所有选中的 jq对象前面添加指定元素  
    $('#todo li').before("<li>new li tags aaa</li>");  
    // 如果是已有元素，会移动并克隆已有元素  
    $('#todo li').before($('h3'));  
​  
    // 与 after 方法相同，只是将书写顺序颠倒过来   
    $('<li>新的li标签ccc</li>').insertAfter('#insert li')  
    // 与 before 方法相同，只是将书写顺序颠倒过来  
    $('<li>新的li标签ddd</li>').insertBefore('#insert li')  
​  
  </script>  
</body>  
</html>
```

**wrap()** 将所有匹配的节点每个单独用指定的元素节点包裹起来

**wrapAll()** 将所有匹配的节点整体用一个指定的元素节点包裹起来

**unwrap()** 将每个元素的父级删除（是wrap的反向操作）

**replaceWith()** 将所有匹配到的元素替换成另一组元素

（可以是DOM对象，也可以是html字符串）

**replaceAll()** replaceWith的反向操作

**empty()** 清空所有选中元素的内容（只保留标签本身），没有参数

**remove()** 删除元素，删除的元素可以再次添加回来，但事件不会保留

**detach()** 删除元素，删除的元素可以再次添加回来，并且事件还在

**clone()** 克隆指定节点，参数是布尔值，表示是否克隆事件。
