# JavaScript进阶 第六天

## 构造函数中创建的实例方法

通过构造函数创建的对象，称为实例对象

构造函数每调用一次，就会创建一个新的实例对象

实例对象中的方法称为实例方法

同一个构造函数创建的所有实例，即使它们的实例方法功能完全相同，但每个实例方法都是一个单独的函数。

多个功能相同的实例方法会造成不必要的内存空间浪费，实例越多，浪费的空间越多。
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
  // 通过构造函数创建人物  
  // function Person(name, age) {  
  //   this.name = name;  
  //   this.age = age;  
  //   this.say = function() {  
  //     console.log("我是" + this.name + ", 今年" + this.age + "岁");  
  //   };  
  // }  
​  
  // var xiaoming = new Person('小明', 18);  
  // var xiaohong = new Person('小红', 16);  
​  
  // xiaoming.say();  
  // xiaohong.say();  
​  
  // 将函数赋值给两个不同变量，其实是将函数在内存中的地址赋值给了两个变量  
  var f1 = fn1;  
  var f2 = fn1;  
​  
  f1();  
  f2();  
​  
  // 两个变量保存的是同一个函数    
  console.log(f1 === f2);  
​  
  function fn1() {  
    console.log(1111);  
  }  
​  
  // 构造函数创建动物模型  
  function Animal(type, food) {  
    this.type = type;  
    this.food = food;  
    // 使用全局的函数来代替内部的方法，实现多个实例引用同一个函数，达到优化内存的目的  
    this.info = info;  
    // this.info = function() {  
    //   console.log("动物：" + this.type + '， 食物：' + this.food);  
    // };  
  }  
​  
  // 虽然可以使用全局函数来优化内存占用，但不是正确的面向对象写法  
  // 因为全局函数随时有可能被修改或者注销  
  // var info = 123;  
​  
  // 实例就是由构造函数创建的对象  
  var dog = new Animal('小狗', '骨头');  
  var cat = new Animal('小猫1', '老鼠');  
  var cat = new Animal('小猫2', '老鼠');  
​  
  dog.info();  
  cat.info();  
​  
  // 每 new 一次都会产生新的函数，有多少个实例对象，就会产生多少个相同功能的函数，造成内存占用，浪费内存资源  
  console.log(dog.info === cat.info);  
​  
  // 使用全局函数来代替实例方法  
  function info() {  
    console.log("动物：" + this.type + '， 食物：' + this.food);  
  }  
</script>  
</body>  
</html>
```


## 构造函数原型

每个函数都有一个内置的属性 prototype ，该属性的值为一个对象，称为 原型对象。

prototype 默认自带一个属性 constructor，该属性的值为构造函数自身。

当函数以构造函数形式被调用（即使用 new 关键字调用函数）时，构造函数所创建的实例对象会自动与构造函数的 prototype 属性关联，所有构造函数的实例都可以访问 prototype 中的属性和方法。

constructor 属性用来指示创建实例对象的构造函数。

可以将功能相同的实例方法添加在构造函数的原型对象 prototype 中，实现内存占用的优化。
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
  // var obj = {};  
  // 给对象添加新属性  
  // obj.a = 123;  
  // console.log(obj);  
​  
  // 创建一个任意函数     
  // 函数名称使用abc 只是为了说明名称可以是任意合法的字符组合，实际开发中应该使用符合函数功能的名称  
  function abc() {  
​  
  }  
​  
  // console.log( abc );  
  // 所有函数都自带一个默认属性 prototype，它是一个对象类型的属性，称为原型对象  
  console.log( abc.prototype );  
  // 可以在原型对象上添加任意属性或方法  
  abc.prototype.efg = '123456';  
  abc.prototype.fn = function() {  
    console.log('自定义方法');  
  };  
​  
  // 查看原型对象上的属性和方法   
  // console.log( abc.prototype );  
  // abc.prototype.fn();  
​  
  // 作为普通函数调用  
  // abc();  
​  
  // 作为构造函数来调用  
  var obj = new abc();  
  // console.log(obj);  
​  
  // 当使用 new 关键字调用函数，这个函数就是一个构造函数  
  // 由构造函数创建的实例，可以访问构造函数的原型对象上的属性和方法  
  // console.log(obj.efg);  
  // obj.fn();  
​  
  // 原型对象默认自带一个 constructor 属性，这个属性的值指向构造函数自身。  
  // 实例可以也访问到 constructor 属性，并通过 constructor 可以知道对象是由哪一个构造函数创建出来的。  
  // console.log( obj.constructor );  
</script>  
​  
</body>  
</html>
```


在原型对象上添加属性和方法来优化内存占用
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
​  
<script>  
/*   
  // 在实例中添加方法，会造成内存资源浪费  
  function Animal(type, food) {  
    this.type = type;  
    this.food = food;  
    this.info = function() {  
      console.log("动物：" + this.type + '， 食物：' + this.food);  
    };  
  }  
​  
  var dog = new Animal('小狗', '骨头');  
  var cat = new Animal('小猫', '老鼠');  
​  
  dog.info();  
  cat.info();  
​  
  // 指向的是不同的两个函数。  
  console.log(dog.info === cat.info); */  
​  
  // 在构造函数原型对象上添加属性和方法，可以让所有实例共享  
  // 这样所有实例共享一个属性和方法，实现内存资源占用的优化  
  function Animal(type, food) {  
    this.type = type;  
    this.food = food;  
    // this.info = function() {  
    //   console.log("动物：" + this.type + '， 食物：' + this.food);  
    // };  
  }  
​  
  // 将公共的方法添加在原型上，可以优化代码的内存占用。  
  Animal.prototype.info = function() {  
    console.log("动物：" + this.type + '， 食物：' + this.food);  
  };  
  // 公共的属性同样也可以添加到原型上。  
  Animal.prototype.live = '陆地';  
​  
  var dog = new Animal('小狗', '骨头');  
  var cat = new Animal('小猫', '老鼠');  
​  
  dog.info();  
  cat.info();  
  console.log(dog.live,  cat.live);  
​  
  // 所有实例都使用的是原型对象上的同一个方法  
  console.log(dog.info === cat.info);  
</script>  
</body>  
</html>
```

## 原型链

与作用域链类似，查找对象有没有指定的属性或方法，是通过原型链

**原型链：**

当访问一个对象的属性或方法时，会优先在这个对象自身查找有没有这个属性或方法，如果有，则采用自身的属性或方法；如果没有，则通过原型链在创建这个对象的构造函数的原型对象中查找，如果还没有查找到，则继续在创建原型对象的构造函数的原型对象中查找，一直查找到顶层对象 Object 的原型对象 prototype 中，如果还找不到，则返回 undefined。

对象通过特殊属性 `__proto__` 来关联创建自身的构造函数的原型对象 prototype
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
    // 原型链  
​  
    function Foo() {  
      // console.log(a);  
      this.abc = '123';  
    }  
    // 访问一个对象的属性，如果对象自身没有，会往上一层，到创建对象的构造函数的原型对象上查找  
    Foo.prototype.abc = 100;  
    // 如果 Foo.prototype 中还找不到 abc 属性，则再往上一层，在 Object.prototype 上查找  
    // 如果还找不到，则返回 undefined ，因为 Object.prototype 是最顶层的原型对象。  
    Object.prototype.abc = '456';  
​  
    // 内置的专门用来创建对象的构造函数  
    // Object()  
    // 构造函数的原型对象  
    // Object.prototype  
​  
    var o = new Foo();  
    // console.log( o );  
    // 访问实例的 abc 属性  
    // console.log( o.abc );  
​  
    // __proto__ 是浏览器提供的，用来查看当前对象的构造函数的原型对象的属性。  
    // console.log( o.__proto__ );  
    // __proto__ 属性指的就是构造函数的原型对象  
    // console.log( o.__proto__ === Foo.prototype ); // true  
​  
    // Foo.prototype 也是一个对象，它的原型链的上一层是 Object.prototype （即如果属性在Foo.prototype 上找不到，就会去Object.prototype 上查找 ）  
    // console.log( Foo.prototype.__proto__ == Object.prototype );  
​  
    // Object.prototype 是最顶层的原型对象，再往上已经没有了， 返回 null  
    // console.log( Object.prototype.__proto__ );  
​  
​  
    // 所有函数都由 内置的 Function() 构造函数创建  
    function fn1() {  
    }  
    // 如果属性在元素自身找不到，就会在 Function.prototype 上查找  
    // Function.prototype.aaa = 999;  
    // 如果 Function.prototype 上也找不到，就再往上一层，在Object.prototype上查找  
    // Object.prototype.aaa = 998;  
​  
    // 给函数添加属性  
    // fn1.aaa = 200;  
​  
    // 在fn1上找不到 aaa, 就需要去 创建fn1函数的构造函数的原型对象上查找。  
    console.log(fn1.aaa);  
    // console.log(fn1);  
    // 查看函数 fn1 的构造函数  
    // console.log( fn1.constructor )  
​  
    // Function()  是最顶层的构造函数，由 JS引擎创建。  
    // function Function() {}  
    // 因为 Function() 由JS引擎创建，没有构造函数，为了防止出错，constructor 属性指向 Function() 自身  
    // console.log( Function.constructor );  
​  
    /*   
      访问一个对象的属性：  
        优先在对象自身查找有没有这个属性，如果有，使用自身的属性值;  
        如果没有，就去创建这个对象的构造函数的原型对象上查找，如果有，就使用构造函数的原型对象上的属性值；  
        如果还没有找到，再往上一层，即创建构造函数的原型对象的构造函数的原型对象上查找，依此类推，一直查找到最顶层的原型对象，如果还没有找到，就返回 null;  
    
      对象一定是由构造函数创建出来的。  
​  
      所有的函数都由  Function() 构造函数创建。  
      所有的对象都由  Object() 构造函数创建。  
    */  
  </script>  
</body>  
</html>
```

**instanceof**

运算符用来检测 某个构造函数的原型对象在不在指定对象的原型链中

如 a instanceof b 检测构造函数b的原型对象是否在对象a的原型链中（如果在，说明a是原型链中的某个构造函数的实例）

**in**

运算符，判断对象有没有指定属性或方法 ，有返回true ，没有返回 false

'name' in window // 检测 window 对象中有没有name属性

**hasOwnProperty()**

对象方法， 检测一个属性或方法是不是对象自身的， 是返回 true ， 不是 返回 false .
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
// 构造函数 Abc  
function Abc() {  
​  
}  
​  
// 构造函数 Def  
function Def() {  
​  
}  
// 构造函数实例  
var d = new Abc();  
​  
// instanceof 运算符用来检测 右边的构造函数的原型对象是不是在左边实例的原型链上  
// console.log(d instanceof Abc); // true  在原型链上  d 是由 Abc 创建的实例   
// console.log(d instanceof Def); // false 不在原型链上  
​  
// Object 在 d 的原型链上 （在查找a对象的属性时，如果a自身没有，会去Abc.prototype和 Object.prototype上查找）  
// console.log(d instanceof Object); // true  
​  
​  
// in  运算符： 查看对象上有没有指定属性  
var obj = {name: "小明", age: 18};  
​  
Object.prototype.abc = 100;  
​  
// 查看 obj 上有没有 name 属性  
// console.log("name" in obj); // true  
// 查看 obj 上有没有 sex 属性  
// console.log("sex" in obj); // false  
// 查看 obj 上有没有 abc 属性， 自身没有，在原型链上查找  
// console.log("abc" in obj); // true  
​  
// 使用 for..in 循环，也会遍历 原型链上的属性和方法  
// for(var i in obj) {  
//   // console.log(i, obj[i]);  
// }  
​  
​  
// hasOwnProperty()  检测属性是不是对象自身的属性  
​  
// 查看 obj 自身有没有 name 属性  
// console.log( obj.hasOwnProperty('name') ); // true  
// 查看 obj 自身有没有 abc 属性  
// console.log( obj.hasOwnProperty('abc') ); // false  
​  
// 使用 hasOwnProperty() 来过滤 for..in 循环的结果  
for(var i in obj) {  
  if ( obj.hasOwnProperty(i) ) {  
    console.log(i, obj[i]);  
  }  
}  
</script>  
</body>  
</html>
```

## 原型链关系

查看一个对象由哪个构造函数创建，使用 constructor 属性。

对象的所有非自身属性和方法继承自创建对象的构造函数的原型对象。

所有函数都由构造函数 Function() 创建，函数非自身属性和方法继承自 Function.prototype

Function 构造函数由JS引擎生成，它的 constructor 属性指向自身，它的 **proto** 指向 Object.prototype 对象；

原型链的最顶层为 Object.prototype 对象，Object.prototype 由JS引擎生成，Object.prototype 的 **proto** 为 null；
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
/*   
  所有的对象都由 Object() 构造函数创建  
  所有的函数都由 Function() 构造函数创建  
*/  
​  
// 原型链对应关系分析  
​  
// 对象  
var obj = {  
  a: 123  
};  
// 查看对象属性  
// console.log(obj.a);  
​  
// 访问 对象 obj 的属性 z 的查找过程  
// 1，先在自身查找z，发现没有，去创建obj对象的构造函数的原型对象 Object.prototype 上查找。  
// 2，在 Object.prototype 上找到了 z ，返回 z 的值  
// 3，如果 Object.prototype 上也没有 z ，会返回 undefined ，因为 Object.prototype 是最顶层原型链了  
// Object.prototype.z = 100;  
// console.log(obj.z);  
​  
​  
// 函数  
function def() {  
  console.log('hahaha');  
}  
// def.y = 333;  
// console.log(obj, def);  
​  
// 查找函数属性 y 的过程：  
// 1，先在函数 def 自身查找有没有 y， 发现没有，去创建def函数的构造函数的原型对象 Function.prototype 上查找，  
// 2，如果在 Function.prototype 发现了 y ，返回 y 的值  
// Function.prototype.y = 666;  
// 3，如果在 Function.prototype 也没有发现，会去创建 Function.prototype 的构造函数的原型对象 Object.prototype 上查找  
// 4，如果在 Object.prototype 上找到了y ，返回y的值，如果没有 返回 undefined (到顶层原型链了)  
// Object.prototype.y = 888;  
// console.log(def.y);  
​  
// 对象的方法上的属性查找过程  
var  bb = {};  
// 给对象bb添加 ff 方法  
bb.ff = function() {};  
// 查找 bb.ff 上的 abc 属性的过程  
// 1，先在 bb.ff 上查找，如果有 abc，直接返回 abc的值  
// bb.ff.abc = 123;  
// 2，如果 bb.ff 自身没有，就去 Function.prototype 上查找 abc，  
// Function.prototype.abc = 123;  
// 3，如果 Function.prototype 上找到了 abc，返回abc的值，如果还找不到， 去 Object.prototype 上查找  
// 4，如果Object.prototype上有 abc，返回abc的值，如果还没有，返回 undefined （到原型链顶层了）  
// Object.prototype.abc = 888;  
// console.log(bb.ff.abc );  
</script>  
</body>  
</html>
```


## 安全类

安全类是指在自定义构造函数时，为防止用户漏写 new 关键字导致构造函数调用出错的写法
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
​  
<script>  
​  
  // 创建学生信息的构造函数   
  // function Student(name, room) {  
  //   this.name = name;  
  //   this.room = room;  
  // }  
​  
  // 正确的使用方式  
  // // var xiaoming = new Student("小明", '301');  
  // // console.log(xiaoming.room);  
​  
  // 错误的使用方式，  忘记写 new 关键字，会导致代码出错。  
  // var xiaohong = Student("小红", '302');  
  // console.log(xiaohong.room);  
​  
​  
  // 做一个安全处理，保证始终使用new 关键字调用构造函数   
  // 安全类 就是在构造函数内部做一次安全检查，如果发现调用时没有使用new关键字，则补上new关键字  
  function Student(name, room) {  
    // 判断如果没有使用 new 关键字调用构造函数，就使用new 递归调用一次。  
    if (this === window) {  
      return new Student(name, room);  
    }  
    this.name = name;  
    this.room = room;  
    // 保证 this 始终指向由new关键字创建的对象  
    // console.log(this);  
  }  
​  
  // 正确的用法  
  var xiaoming = new Student("小明", '301');  
  // console.log(xiaoming.room);  
  // 就算用法错误， 构造函数也是安全的，不会出错。  
  var xiaohong = Student("小红", '302');  
  console.log(xiaohong.room);  
</script>  
</body>  
</html>
```


## 内置构造函数

ECMAScript 内置的构造函数：

Object() Array() Function() String() Number()

Boolean() RegExp() Error() Date()

所有内置构造函数都应该使用 new 关键字调用，如果不使用 new 关键字调用 ，则作为普通函数使用，有些构造函数如果作为普通函数使用，功能上与作为构造函数使用有所不同，这是内置函数有特别处理的关系。

简单类型的构造函数使用 new 与 不使用 new 的区别：

**String() :** 使用new 创建字符串对象 / 不使用new 其它类型转字符串类型

**Number :** 使用 new 创建数字对象 / 不使用new 其它类型转数字

**Boolean :** 使用 new 创建布尔对象 / 不使用new 其它类型转布尔
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
// 数组构造函数  
// var arr = [1,2,3,4];  
// arr.length = 3  
// var arr = new Array(1,2,3,4);  
// 构造函数的方式创建数组，如果参数只有一个值，并且是number类型，这个数字表示数组的length，而不是存入数组中的数据。  
// var arr = new Array(3);  
// 如果要以构造函数方式创建一个只有一个类型为number的值，只能先创建空数组，再通过下标赋值。  
// var arr = new Array();  
// arr[0] = 3;  
// console.log(arr);  
// console.log(arr[0]);  
​  
// 对象  
// var obj = {a: 123, b: true};  
// var obj = new Object();  
// obj.a = 123;  
// obj.b = true;  
// console.log(obj);  
​  
​  
// 函数  
// function fn1(a) {  
//   console.log(a);  
// }  
// 最后一个参数是函数体，前面的所有参数都是形参  
// var fn1 = new Function('b','c', 'console.log(b)');  
// fn1(123);  
​  
// 通过构造函数方式创建的数字为 object 类型  
// var num = new Number(123);  
// console.log(typeof num);  
// console.log(num * 100);  
​  
​  
// 通过构造函数方式创建的字符串为 object 类型  
// var str = new String('abcd');  
// console.log(typeof str);  
// console.log(str + 'efg');  
​  
// 通过构造函数方式创建的布尔值为 object 类型  
// var bool = new Boolean('');  
// console.log(typeof bool);  
// console.log(bool);  
​  
// String() / Number() / Boolean() : 如果不使用 new 关键字调用，为类型转换功能函数。 （内置构造函数，有特殊处理，我们自己定义的构造函数不能这么做）    
​  
// String()  
var abc = 123;  
// console.log(abc);  
// 将其它类型值转换成字符串值  
// console.log(typeof String(abc));  
​  
// Boolean()  
// 将其它类型值转换成布尔值  
// console.log(typeof Boolean(abc));  
​  
// Number()  的转换特点  
var a = '123';  
var b = '123.45';  
var c = '12.34.56';  
var d = '120px';  
​  
// Number() 只能转换纯数字的字符串值，如果字符串中有非数字值，直接返回NaN  
// console.log(Number(a));  
// console.log(Number(b));  
// console.log(Number(c));  
// console.log(Number(d));  
// 开头和结束的空格会忽略  
// console.log(Number('   123  '));  
// 中间空格不会忽略  
// console.log(Number('   12 3  '));  
// 空字符串和纯空白字符的字符串，转换成0  
// console.log(Number('    '));  
​  
​  
// 除了 String() / Number() / Boolean() 三个可以用来转换类型的构造函数之外  
// 内置的构造函数使用时，应该都使用 new 关键字调用  
</script>  
</body>  
</html>
```


## 正则 与 错误提示 构造函数

**new RegExp(regStr, letter);**

以构造函数方式创建正则表达式

第一个参数是字符串格式的正则 表达式， \ 需要转义，比如 \w 要写成 '\w'

第二个参数是字符串格式的修饰符，i、g、m

**说明：** 构造函数方式创建正则，支持使用变量表示正则规则。
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

  var str = 'afsdf123jfl44543lupf';
  var sClass = 'active focus color';

  // 字面量方式定义正则
  // var re = /\d+/g;
  var str = 'focus';
  // 字面量形式不支持变量
  // var re = /str/g;
  // console.log(sClass.match(re));

  // 构造函数形式，正则的所有带 \ 的特殊字符或元字符，\要写成 \\
  // var re = new RegExp('\\d+', 'g');

  // getStr函数作用： 从str字符串中提取出 s子字符串
  function getStr(str, s) {
    // 构造函数方式定义正则，可以使用变量
    var re = new RegExp(s, 'g');
    return str.match(re);
  }

  // console.log(getStr(sClass, 'focus'));
  console.log(getStr(sClass, 'active'));

  // console.log(str.match(re));
</script>
</body>
</html>
```


**new Error()** 自定义错误信息

throw new Error('这是一条错误信息')；

**说明：** Error() 会中断代码执行，可以使用 try{} catch() {} 代替，优化体验。
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

  // 访问未定义的变量会报错
  // console.log(a);

  // 定义一条错误语句
  // var err = new Error('这是一条错误信息');

  // 使用 throw 关键字来抛出 err 的错误信息到控制台。
  // 如果使用 throw 来抛出错误，后面的语句不会再执行了，所以不建议直接使用 Error() 构造函数。
  // throw err;

  // console.log(err);
  // console.log(a);

  // try ... catch() 语句： 错误捕获 ，将错误信息控制在 try...catch 语句内部，不影响外部代码的正常执行。
  try {

    // 如果代码不能成功执行，就将错误信息保存，并作为参数传入 catch 分支，然后执行 catch 分支语句
    console.log(a);

    // 如果没有错误，正常执行 try 分支的语句，不会执行catch分支。
    // console.log(1123321);

  } catch (err) {

    // 以日志形式输出错误信息到控制台
    // console.log(err);
    // 以抛出错误的形式在控制台显示信息
    console.error(err);

  }

  // try...catch 语句内部即使有错误，也不会影响外部代码正常执行。
  console.log('123lfdsaf');
</script>

</body>
</html>
```


## 日期构造函数

**new Date()**

设置或返回本地系统时间

**四种格式：**

1， 没有参数： new Date() 获取当前本地系统时间

2，时间戳参数： new Date(123342355) 返回时间戳对应的具体时间

时间戳是从 1970年1月1日作为起点的毫秒数时间跨度值

3，字符串参数： new Date('2022-7-14 12:30:45')

日期中间的间隔可以是 - / , 和空格等常用的分隔符

时间中间的间隔符只能是冒号

4，单一参数： new Date(2022, 6, 14, 10, 21, 32);

按 年 月 日 时 分 秒 毫秒 的顺序设置指定时间
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

  // 不设置参数，表示获取当前的本地系统时间
  // var date = new Date();

  // 设置参数为0，可以获取到本地计算机计时的起始时间点
  // var date = new Date(0);


  // 时间戳作为参数，返回从 1970年1月1日 加上时间戳之后的日期
  // var date = new Date(1233245543564);

  // 以字符串格式的时间作为参数
  // 日期中间的分隔符可以是 - / , 空格 等常用分隔符， 时间中间只能是冒号
  // var date = new Date('2022-9-10 12:30:45');

  // 年 月 日时 分 秒 毫秒 作为单独参数来设置。
  // var date = new Date(2022, 6, 14);

  // 注意： 后面两种设置方式，都不能设置星期日期，因为知道了日期，就能自动计算出星期

  // console.log(date)

  // 倒计时计算原理
  // 获取当前时间 （倒计时的开始时间）
  var currentTime = new Date();
  // 获取未来时间  （倒计时的结束时间）
  var zhongQiu = new Date('2022-9-10');

  // 计算两个时间点的差值
  var time = zhongQiu - currentTime;

  // 两个时间相差的毫秒数。   4965255402
  console.log(time);  

  // 拿到差值，就可以根据需求转换成具体的倒计时天数或小时分钟数
</script>
</body>
</html>
```
