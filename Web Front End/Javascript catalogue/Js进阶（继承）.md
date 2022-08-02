# JavaScript进阶 第七天


## Date() 获取具体的时间信息
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <link rel='icon' href='data:image/x-ico;base64,='>  
  <title>Document</title>  
</head>  
<body>  
    
<script>  
​  
  // 构造函数的返回一定是一个对象  
  var date = new Date();  
​  
  // console.log(typeof date);  
  // console.log( date.getFullYear() );  
    
  // 月份从0开始计算，实际月份要 +1  
  // console.log( date.getMonth() );  
  // 获取日期 （具体哪一天）  
  // console.log( date.getDate() );  
  // 获取星期  0 表示星期日  
  // console.log( date.getDay() );  
  // 获取小时  
  // console.log( date.getHours() );  
  // 获取分钟  
  // console.log( date.getMinutes() );  
  // 获取秒钟  
  // console.log( date.getSeconds() );  
​  
  // console.log("今天是： 2022年7月15日 15时16分17秒");  
​  
  // 获取时间戳  
  // console.log( date.getTime() );  
  // console.log( new Date() );  
  // console.log( date.toDateString())  
  // console.log( date.toString() )  
  // 直接输出 new Date() 会输出字符串格式的时间， 参与运算时，会自动转换成时间戳  
  // console.log( +new Date() );  
​  
  // 设置日期  
  var date = new Date('2022-7-15');  
​  
  // date.setMonth(7);  
​  
  // 如果设置的日期超出合法的日期范围，会自动进位。  
  // 2023年1月  
  // date.setMonth(12); // 12- 11  
  // 2023年4月  
  // date.setMonth(15); // 15- 11  
  // 8月1日  
  // date.setDate(32); // 12- 11  
​  
  // 没有设置星期的方法，因为星期不能设置，（通过设置日期就可以实现设置星期）  
  console.log(date);  
​  
​  
  /*   
  解答有些同学问上节练习中 关于时间差的计算中   
   zhongQiu - currentTime     
  为什么可以得到时间差的问题  
​  
  Date() 构造函数 的实例对象在运算和直接输出时，JS的引擎处理方式是不一样的。  
​  
  当 console.log( new Date() ) 时， JS 引擎是调用 实例对象的 toString() 方法，将 toString() 方法的返回值输出。  
  而当  console.log( new Date() - new Date() ); 时， 因为存在运算，JS引擎会先 分别在两个 new Date() 的实例对象上调用  valueOf() 方法，然后将 valueOf() 的值进行计算。  
​  
    时间对象的 toString() 方法返回的是字符串值： Fri Jul 15 2022 12:30:45 GMT+0800 (中国标准时间)  
    时间对象的 valueOf() 方法返回的是 时间戳。  
​  
  这是 JS 本身的语法特性。  
​  
​  
  扩展知识：  
    JS 的 valueOf() 方法 和 toString() 方法：  
      JS 中的所有对象都有两个内置的方法， valueOf() 和 toString() 方法，在不同对象上调用 这两个方法，返回不同的值，具体由浏览器根据 ECMAScript 规范来实现。  
​  
      valueOf()  : 返回对象的原始值  
        原始值是JS根据语法规则内部自动计算出来的值，  
        简单数据类型的原始值是自身，比如 123 的原始值为123， 'abc' 的原始值 为 'abc'  
        复杂数据类型的原始值并不固定，由具体的值通过语法规则计算而来（具体需要参考 ECMAScript 的规范文档）。  
        
      toString() : 返回对象的字符串值  
        toString() 方法是按JS解释器预定义好的规则返回对象的字符串值  
​  
    这两个方法不需要开发者主动调用，而是在代码执行过程中，根据需要由JS引擎自动调用。  
      
    JS 引擎会根据代码执行需要选择 valueOf() 方法或 toString() 方法。  
      
    通常输出和字符串操作，会调用 toString() 方法，运算操作会调用 valueOf() 方法  
    但也并不总是如此，具体还是需要根据 ECMAScript 标准规范来。  
      比如： [10] - [5]     
      JS 引擎检测到这是在做减法运算，会调用 valueOf() 方法将两个数组都转换成原始值相减， [10] 的原始值为 '10' , [5] 为 '5' , 减号会做隐式类型转换 最终是 10 - 5    
      若是 [10,2] - [5]   则不能正确计算，因为 [10,2] 的原始值为 '10,2' 无法被减号转换为数字。  
​  
      再比如：   null - 1     
      正常 null 不是一个数字，并不能做减法运算，但 ECMAScript 规定 null 转成数字的值固定为 0，所以 null - 1  实际运算的是 0 - 1 ， 但这里 null 是直接用 0 来运算，而不是调用 valueOf() 或 toString() 方法转换而来，因为 ECMAScript 规定 null 没有 valueOf() 和 toString() 方法。    
  */  
</script>  
</body>  
</html>
```


## instanceof

检测运算符右边的值的原型对象 在不在左边的值的原型链中。
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <title>Document</title>  
</head>  
<body>  
    
<script>  
​  
function A() {  
}  
​  
function Bc() {  
}  
​  
var aa = new A();  
​  
// 检测 A.prototyoe 在不在 aa 的原型链中  
// console.log(aa instanceof A); // true  
// console.log(aa.b);  
// 检测 Object.prototyoe 在不在 aa 的原型链中  
// console.log(aa instanceof Object); // true  
​  
// 检测 Bc.prototype 在不在 aa 的原型链中  
console.log(aa instanceof Bc);  // false  
console.log(aa);  
​  
// 要判断一个构造函数在不在某个对象的原型链中，就是看在查找这个对象的属性时，会不会去这个构造函数的 prototyoe 中查找。  
</script>  
</body>  
</html>
```


## in 运算符

in 运算符的功能是用来检测指定对象中有没有某个属性。

in 运算符如果在对象自身找不到要找的属性，会在原型链中一层层查找，直到查到最顶层原型链。
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <title>Document</title>  
</head>  
<body>  
    
<script>  
  var obj = {a: 123, b: true};  
​  
  Object.prototype.c = 100;  
  // 检测 obj 有没有 a 属性  
  // console.log("a" in obj); // true  
​  
  // 检测 obj 有没有 c 属性   
  // obj 自身虽然没有 c 属性，但通过原型链查找到 Object.prototype 上时，可以查找到 c 属性。  
  // console.log("c" in obj); // true  
​  
  /*   
    in 如果在对象自身找不到属性，会在原型链查找。  
  */  
</script>  
​  
</body>  
</html>
```


## hasOwnProperty

检测对象自身是否有指定的属性 ， 不会查找原型链

与 in 的功能相同，但不会查找原型链
```js
<!DOCTYPE html>  
<html lang="en">  
<head>  
  <meta charset="UTF-8">  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <title>Document</title>  
</head>  
<body>  
    
<script>  
​  
var obj = {name: '小明', age: 18};  
​  
Object.prototype.sex = '男';  
// console.log('name' in obj);  
// console.log('sex' in obj);  
​  
// console.log( obj.hasOwnProperty('name') );  
// console.log( obj.hasOwnProperty('sex') );  
​  
/*   
hasOwnProperty() 检测对象自身是否有指定的属性 ， 不会查找原型链  
*/  
</script>  
</body>  
</html>
```


## 构造函数式继承

构造函数式继承是指通过 call() 或 apply() 方法，将父类的属性复制到子类中。

  function Animal(name, sex) {  
    this.name = name;  
    this.sex = sex;  
  }  
  Animal.prototype.eat = function() {  
    console.log("吃饭");  
  };  
​  
  function Dog(name, sex) {  
    // 构造函数式继承     只能继承属性，不能继承原型对象上的方法  
    // 子类中不需要再重复写属性设置的代码了。  
    Animal.call(this, name, sex);  
  }  
  // Dog 的实例没有继承到 Animal 的 prototype 中的 eat 方法  
  Dog.prototype.action = function() {  
    console.log("拆家");  
  };

构造函数式继承可以从父类中继承实例属性，但无法继承父构造函数的 prototype 中的方法。

## 类式继承

类式继承 又称为 原型继承

  function Animal(name, sex) {  
    this.name = name;  
    this.sex = sex;  
  }  
  Animal.prototype.eat = function() {  
    console.log("吃饭");  
  };  
  function Dog(name, sex) {  
    // Dog 类中没有继承实例属性，还得重复写一次  
    this.name = name;  
    this.sex = sex;  
  }  
  // 类式继承只会继承原型对象上的属性和方法，无法继承父构造函数的实例属性。  
  Dog.prototype = Animal.prototype;  
  Dog.prototype.action = function() {  
    console.log("拆家");  
  };

类式继承只会继承原型对象上的属性和方法，无法继承父构造函数的实例属性。

## 组合式继承

组合式继承，是结合构造函数式继承和类式继承，让子类同时可以继承父类中的实例属性和 prototype 中的公共方法。

  function Animal(name, sex) {  
    this.name = name;  
    this.sex = sex;  
  }  
  Animal.prototype.eat = function() {  
    console.log("吃饭");  
  };  
  function Dog(name, sex) {  
    // Dog 中不需要再写实现实例属性的代码了  
    Animal.call(this, name, sex);  
  }  
  // 直接将 Dog.prototype 指向 Animal.prototype 会导致 原型污染  
  // 即 当给 Dog.prototype 添加方法时，也会添加到 Animal.prototype 上，因为它们其实是同一个对象  
  // 这样如果 Animal 还有其它子类，也会受到影响  
  // Dog.prototype = Animal.prototype;  
​  
  // 通过 new Animal() 将父级的实例对象作为原型对象覆盖 Dog.prototype 的原型对象  
  // 这样既可以实现继承父类的原型对象的公共方法，又不会在添加新方法时污染父类的 prototype  
  // 这里是为了继承 Animal.prototype 上的方法，不需要传参数  
  Dog.prototype = new Animal();  
  // 修复 constructor 的指向错误  
  Dog.prototype.constructor = Dog;  
  Dog.prototype.action = function() {  
    console.log("拆家");  
  };

组合式继承从功能角度来说，本身就是完整的继承方案了，已经完整实现了从父类继承。但从内存占用角度来说，会在子类的原型对象中额外添加不必要的属性，造成资源浪费。

## 寄生式继承

利用一个空的构造函数作为过渡桥梁，将子类通过空的构造函数间接继承父类的 prototype 中的公共方法。

  function Animal(name, sex) {  
    this.name = name;  
    this.sex = sex;  
  }  
  Animal.prototype.eat = function() {  
    console.log("吃饭");  
  };  
​  
  function Dog(name, sex) {  
    // 寄生式继承是专门用来继承原型对象的属性的，实例属性还得手动编写代码  
    this.name = name;  
    this.sex = sex;  
  }  
  // 创建空的构造函数  构造函数的目的是通过实例来访问 Animal 的 prototype 中的方法  
  // 空构造函数本身不需要任何实例属性  
  function F() {}  
  // 将空构造函数的 prototype 指向父类，这样 Dog 类就可以通过 F() 的实例对象访问到 Animal 的原型对象中的公共方法  
  F.prototype = parent.prototype;  
  Dog.prototype = new F();  
  // 修复 constructor 的指向错误  
  Dog.prototype.constructor = Dog;  
  Dog.prototype.action = function() {  
    console.log("拆家");  
  };

## 组合式寄生继承

通过构造函数式和寄生式相结合，实现完整的组合式寄生继承。

  function Animal(name, sex) {
    this.name = name;
    this.sex = sex;
  }
  Animal.prototype.eat = function() {
    console.log("吃饭");
  };

  function Dog(name, sex) {
    // 使用 构造函数式继承 来继承实例属性
    Animal.call(this, name, sex);
  }
  // 使用 寄生式继承来 继承原型对象 prototype 上的方法
  inherit(Dog, Animal);
  Dog.prototype.action = function() {
    console.log("拆家");
  };

  // 将组合式继承封装成通用的继承封装函数
  function inherit(child, parent) {
    function F() {}
    F.prototype = parent.prototype;
    child.prototype = new F();
    // 修复 constructor 的指向错误
    child.prototype.constructor = child;
    return child;
  }

组合式寄生继承是在 ES6的类新特性之前的主流继承写法。

## 项目实例： 贪吃蛇

项目结构：

**主构造函数（主类）： game.js**

// 主类  管理所有子类
function Game() {
  // 将子类 Snake 的实例对象 添加到主类 Game 的实例对象中
  this.snake = new Snake();
  // 将子类 Stone 的实例对象添加到主类 Game 的实例对象中
  this.stone = new Stone();
  // 将子类 Food 的实例对象添加到主类 Game 的实例对象中
  this.food = new Food();
  // 将子类 Map 的实例对象添加到主类 Game 的实例对象中
  this.map = new Map(20, 20, 30, 30);
}

// 主类原型对象中的初始化方法，实例通过调用该方法来初始化整个游戏
Game.prototype.init = function() {
  // 调用map类实例对象的初始化方法来生成游戏地图
  this.map.init();  
  // 调用snake类实例对象的初始化方法来生成蛇
  this.snake.init(this.map.mapArr);
  // 调用food类实例对象的初始化方法来生成食物
  this.food.init(this.map.mapArr);
  // 调用stone类实例对象的初始化方法来生成障碍物
  this.stone.init(this.map.mapArr);

  // 查看map实例对象中保存的地图元素（跟html标签对应的 DOM元素）
  // console.log(this.map.mapArr);
}

// 初始化游戏
new Game().init();

**地图类（子类）： map.js**

/* 
  地图类
  @Map
    row         地图的行
    col         地图的列
    width       每个格子的宽度
    height      每个格子的高度
    container   地图容器元素
*/

function Map(row, col, width, height) {
  // 实例属性
  this.row = row;
  this.col = col;
  this.width = width;
  this.height = height;

  // 地图容器元素 
  this.container = document.createElement('div');
  // 存放地图格子标签对应的DOM元素的数组
  this.mapArr = [];
}

// 地图初始化方法
Map.prototype.init = function() {
  // console.log('Map init');

  // 容器的宽度 （地图的宽度）
  var mapW = this.col * this.width;
  // 容器的高度 （地图的高度）
  var mapH = this.row * this.height;

  // 给容器添加className
  this.container.className = 'container';

  // 地图数组格式
  /* 
    通过二维数组，来创建一个 M * N 的地图坐标模型数据
    这样就可以通过 [列坐标,行坐标] 的方式来定位每一个元素
    [
      [0,1,2,3,4,5,6,7]
      [0,1,2,3,4,5,6,7]
      [0,1,2,3,4,5,6,7]
      [0,1,2,3,4,5,6,7]
    ]

    this.row 决定了二维数组有多少行
    [
      [div]
      []
      []
      []
    ]
  */

  // 根据行数来生成二维数组的第二层
  for (var i=0; i<this.row; i++) {
    this.mapArr.push([]);
  }
  // console.log(this.mapArr);

  // 创建地图小格子, 并分组存入二维数组中。
  for (var i=0; i<this.row * this.col; i++) {
    var cell = document.createElement('div');
    // this.mapArr.push(cell);
    // this.mapArr[0].push(cell);
    this.mapArr[Math.floor(i/this.col)].push(cell);
    this.container.appendChild( cell );
  }

  // console.log(this.mapArr);

  // 创建样式标签 
  // 使用 style 标签是为了在js中写样式更方便
  var styleTag = document.createElement('style');

  // 通过 style 标签设置样式
  styleTag.innerHTML = `
    .container {
      width: ${mapW}px;
      height: ${mapH}px;
    }
    .container div {
      width: ${this.width}px;
      height: ${this.height}px;
      border: 1px solid #999;
      box-sizing: border-box;
      float: left;
      background-size: cover;
    }
  `;
  // 将样式标签添加到HTML页面的head标签中
  document.head.appendChild(styleTag);
  // 将地图容器添加到页面中
  document.body.appendChild(this.container);
}

**食物类（子类）： food.js**

function Food() {

}
Food.prototype.init = function(mapArr) {
  console.log('Food init');

  // 绘制食物     这里是初始化时的第一个食物，后期食物需要随机创建更多食物
  mapArr[9][12].style.backgroundImage = "url(img/food.jpg)";
}

**障碍物类（子类）： stone.js**

function Stone() {

}
Stone.prototype.init = function(mapArr) {
  console.log('Stone init');
  // console.log('mapArr', mapArr);

  // 绘制障碍物
  // 障碍物都是设计好的形状， 可以以关卡的形式创建各种不同情景的障碍效果
  mapArr[6][5].style.backgroundImage = "url(img/block.png)";
  mapArr[7][5].style.backgroundImage = "url(img/block.png)";
  mapArr[8][5].style.backgroundImage = "url(img/block.png)";
  mapArr[9][5].style.backgroundImage = "url(img/block.png)";
}

**蛇类（子类）： snake.js**

function Snake() {
  // 蛇的身体会通过进食发生变化，所以不能写成固定数据
  // 使用数组来动态存储身体数据
  this.body = [
    {col: 5, row: 8},
    {col: 4, row: 8},
    {col: 4, row: 7},
    {col: 4, row: 6},
    {col: 4, row: 5}
  ]
}
Snake.prototype.init = function(mapArr) {

  // 绘制固定的蛇    先写固定的位置，方便改写成数组
  // mapArr[4][8].style.backgroundImage = "url(img/3.png)";
  // mapArr[4][7].style.backgroundImage = "url(img/5.png)";
  // mapArr[4][6].style.backgroundImage = "url(img/5.png)";
  // mapArr[4][5].style.backgroundImage = "url(img/6.png)";

  var len = this.body.length, lastIndex = len - 1 ;

  // 渲染蛇的头部
  mapArr[this.body[0].col][this.body[0].row].style.backgroundImage = "url(img/3.png)";

  // 渲染蛇的身体
  for (var i=1; i<lastIndex; i++) {
    mapArr[this.body[i].col][this.body[i].row].style.backgroundImage = "url(img/5.png)";
  }

  // 渲染蛇的尾巴
  mapArr[this.body[lastIndex].col][this.body[lastIndex].row].style.backgroundImage = "url(img/6.png)";
}