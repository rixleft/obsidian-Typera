# HTML5第一天

# 一、Git

### 1.1 介绍

很多人都知道，Linus在1991年创建了开源的Linux，从此，Linux系统不断发展，已经成为最大的服务器系统软件了。

Linus虽然创建了Linux，但Linux的壮大是靠全世界热心的志愿者参与的，这么多人在世界各地为Linux编写代码，那Linux的代码是如何管理的呢？事实是，在

2002年以前，世界各地的志愿者把源代码文件通过diff的方式发给Linus，然后由Linus本人通过手工方式合并代码！

因为很多开发者不断的贡献代码，这样代码越来越多了，就有了管理代码的问题了，所以Linus花了两周时间自己用C写了一个分布式版本控制系统，这就是Git！

一个月之内，Linux系统的源码已经由Git管理了！Git迅速成为最流行的分布式版本控制系统，尤其是2008年，GitHub网站上线了，它为开源项目免费提供Git存

储，无数开源项目开始迁移至GitHub，后来项目越来越多了，其它系统也就开始支持git了

windows， mac等系统都已经支持了Git

我们要使用git就要安装客户端

​	 双击进行下一步安装

​	 安装完成，提供了控制台

 		Git Bash 为linux家族（unix，mac等）使用的

​		 Git CMD 为window使用的

​	 由于git是为linux提供的，所以建议我们使用linux指令 

### 1.2 linux 指令

cd 目录 打开目录

ls 查看当前目录文件的

pwd 查看当前目录所在的系统文件路径

mkdir 文件名名称 创建文件夹

touch 文件名 创建文件的

echo 内容 >> 文件

cat 文件 查看文件内容

小案例：在D:\class目录下创建一个demo文件夹，并创建一个file.txt文件，并写入 你好明天

### 1.3 git 文件

在git中有三类文件的

 第一类文件未纳入缓存的文件

​		 这类文件，一旦删除就再也无法找到

 第二类文件是纳入缓存的文件

​		 这类文件，可以通过git找到

 第三类文件纳入版本库的文件

​		 这类文件，可以在计算机的各个位置找到

### 1.4 使用 git

通过git init 来初始化一个git仓库

​	 当执行该命令之后，会出现一个隐藏的.git文件

​			 objects目录用于存储纳入缓存的文件

​			 refs目录用于存储纳入版本库的文件 

我们可以通过git执令实现三类文件的切换

git add 文件名称

 		实现将未纳入缓存的文件变为第二类文件（纳入缓存），可以通过*将所有文件纳入缓存

git status 查看文件的状态

​		 一旦纳入缓存，就有机会纳入版本库

git rm 文件名

​		 从版本库中移除文件。

​		 如果添加了--cache，说明是从缓存中移除。

git commit -m “说明”

 		注意：这个说明一定要有意义

​		 将缓存中的文件，纳入版本库

此时，一旦修改了文件，要通过git status查看一下被修改的是哪个文件

如果想要查看修改的内容，git diff 文件

当查看完毕代码没有问题，继续git add，然后 git commit -m ‘说明’

回退版本：

​		 我们可以通过 git reset --hard HEAD^ 回退到上一个版本，如果想要恢复到上上一个版本 HEAD^^, 如果想要回到前100个， 如果书写100个^^比较容易数不

清楚，HEAD~100

回到未来：

 		我们可以通过 git reset --hard HEAD commit id实现

​		一旦将文件纳入版本库，我们可以通过计算机的各个位置去找到文件，但是一旦计算机换掉了，文件就再也找不到了，所以我们要将文件上传到云端（服务

器），这样的话，即使电脑换掉了也可以找到我们想要的文件

### 1.5 建立信任关系

一旦将文件提交到版本库将有机会上传到云端（服务器）

由于你的本地Git仓库和远程仓库之间的传输时通过SSH加密的，所以需要一点设置：

 执行指令 ssh-keygen -t rsa -C 邮箱 然后一路回车使用默认值就好

之后进入用户主目录可以找到.ssh目录

 打开id_rsa.pub文件，复制里面的内容

 将内容粘贴到gitHub或者gitlab上

 setting => SSH and GPG keys => add new => 输入标题并粘贴内容 

### 1.6 全局配置

创建项目完成之后要进行全局配置：

 git config --global user.name ‘注册时候的账户名称’

 git config --global user.email ‘注册时候的邮箱’

### 1.7 上传代码

建立连接：

​		 git remote add origin git@github.com:YYQH/demo.git

上传代码：

​		 git push -u origin master

预览项目

​		 http://htmlpreview.github.io/

​		 我们在输入框中输入项目的首页地址，即可预览项目

克隆项目

​		 git clone 项目地址 即可下载别人的项目

### 1.8 多人开发

多人开发的时候，要提交代码要做两件事：拉取代码，合并代码

​		 拉取代码 git fetch origin master

​				 从远程主机的master分支拉取最新内容 

​		 合并代码 git merge FETCH_HEAD  

​				 将拉取下来的最新内容合并到当前所在的分支中

这两个操作可以通过pull来简化：

​		 git pull <远程主机名> <本地分支名>

### 2.9 分支与主干

分支：不会影响整个项目里面的主线文件：

git分支与主干合并操作

在主干上合并分支：branch （master）git merge branch --squash

在分支上合并主干：（branch）git merge master --squash

创建功能分支：(master) git checkout -b feature

合并最新主干代码

​	 1 (feature) git checkout master 

​	 2 (master) git pull

​	 3 (master) git checkout feature 

​	 4 (feature) git merge master

​	 5 解冲突 6 (feature) git commit #

查看分支：git branch

创建分支：git branch <name>

切换分支：git checkout <name>

创建+切换分支：git checkout -b <name>

合并某分支到当前分支：git merge <name>

删除分支：git branch -d <name>

Git pull 将远程主机的最新内容拉下来后直接合并 可能会出现冲突



## 二、HTML5

### 2.1 本地存储

HTML5是html的第五个版本，里面规定了一些废弃标签，同时新增了一些标签，和一些功能

存储：前端仓库的意思

​	 每一个网站分配一个“仓库”，只要浏览器不卸载，电脑不崩溃，它将一直存在（生命周期永久）

本地存储对象：localStorage，里面是没有任何数据， 既然是一个对象

​	 我们可以使用对象的点语法，去添加数据

​	 注意：在存储之前先转为字符串，在读取的时候再转为原类型（JSON.stringify）

本地存储也提供了相应的API，所以建议我们使用原型中的方法

​	存储数据：localStorage.setItem(key, value)

​			 key： 表示要存储的数据名称， 是一个字符串

​			 value: 要存储的数据 （默认转为字符串）

​	读取数据：localStorage.getItem(key)

​			 key: 要读取的数据名称

​	删除某一项数据：localStorage.removeItem(key)

​			 key: 要删除的数据名称

​	删除全部数据：localStorage.clear()

```html
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
// console.log(localStorage);
// 存储数据
// localStorage.color = 'red';
// 查看数据
// console.log(localStorage.color);

// 可以存储任何类型的数据，但是都会作为字符串形式存储
// localStorage.arr = [1, 2, 3]
// console.log(localStorage.arr);
// console.log(typeof localStorage.arr);

// 为了读取和存储时候数据类型一致，可以将数据作为json字符串存储
// localStorage.arr = JSON.stringify([1, 2, 3]);
// console.log(localStorage.arr);
// console.log(typeof localStorage.arr);
// var arr = JSON.parse(localStorage.arr);
// console.log(arr, typeof arr);

// 简单类型的字符串，可以直接存储，复杂类型的对象要转成json字符串存储，使用的时候再解析

// json不能存储函数
// function demo() {
//     console.log('demo');
// }
// // console.log(JSON.stringify(demo));
// // 函数可以直接存储
// localStorage.fn = demo;
// console.log(localStorage.fn);
// console.log(typeof localStorage.fn);
// 函数读取的时候是字符串，不能执行了，
// 为了让字符串执行，可以通过构造函数式以及工厂式执行函数
// var fn = new Function('return ' + localStorage.fn);
// var fn2 = Function('return ' + localStorage.fn);
// // console.log(fn(), fn2());
// fn()()
// fn2()()
// 可以让字符串作为语句执行；eval
// eval(localStorage.fn);
// demo();
// eval和Function都可以让字符串作为语句执行，区别式eval让语句再全局中执行，Function在函数内部执行
// eval('console.log(11)')
// console.log(new Function('console.log(11)'));
// new Function('console.log(11)')()

// API方法
// 存储数据
// localStorage.setItem('num', 100)
// 不论是点语法存储，还是setItem存储，都建议将数据转成json字符串
// localStorage.setItem('arr2', [4, 5, 6])
// // 删除数据
// localStorage.removeItem('num')
// 清空数据
// localStorage.clear();
// // 读取数据
// // 数据删除后，访问不到，所以返回null
// console.log(localStorage.getItem('num'));
// console.log(localStorage.num);
// console.log(localStorage.getItem('color'));
// console.log(localStorage.getItem('arr2'));

// 任何数据作为字符串存储，都是调用其自身的toSting方法
// var arr = [1, 2, 3];
// console.log(arr.toString());
// function test() {
//     console.log('test');
// }
// console.log(test.toString());
</script>
</body>
</html>
```





### 2.2 会话存储

除了本地存储之外还有一个存储对象叫做: sessionStorage

​	 它与本地存储之间的区别就是生命周期的区别

​			 本地存储的生命周期是永久的。

​			 会话存储的生命周期是从页面打开到页面关闭。

​	 与全局变量的区别是

​			 会话存储可以刷新页面

​			 全局变量不能刷新页面

​	生命周期长度：本地存储 > 会话存储 > 全局变量

```html
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
// 会话存储，与本地存储一样
// sessionStorage.num = 100;
// sessionStorage.arr = [1, 2, 3];
// console.log(sessionStorage.num);
// console.log(sessionStorage.arr);
// // 复杂的数据建议用json转换
// sessionStorage.arr2 = JSON.stringify([4, 5, 6]);
// console.log(JSON.parse(sessionStorage.arr2));


// API方法
// 存储数据
// sessionStorage.setItem('color', 'red');
// // 删除数据
// // sessionStorage.removeItem('color')
// // 清空数据
// sessionStorage.clear();
// // 读取数据
// console.log(sessionStorage.getItem('color'));
// console.log(sessionStorage.color);

// 会话存储与本地存储的区别
// 生命周期  
//      会话存储：丛打开页面到关闭页面，可以刷新
//      本地存储：永久
// 会话存储与全局变量的区别
//      会话存储：可以刷新页面
//      全局变量：不能刷新页面
// sessionStorage.msg = 'hello';
// var test = 'test';

console.log(sessionStorage.msg);
console.log(test);
</script>
</body>
</html>
```

### 2.3 历史记录

history.forward

​		 该方法用于加载历史记录列表中的下一个URL（显示下一个页面）

 		调用该方法等价于点击了前进按钮或者是调用了history.go(1)

history.back

​		 该方法用于加载历史记录列表中的上一个URL（显示上一个页面）

​		 调用该方法等价于点击了后进按钮或者是调用了history.go(-1)

pushState：该方法用于向历史记录中添加新的历史记录。（注：状态改变不需要刷新页面）

​		 使用方式：history.pushState(obj, title, url)

​				 obj: 添加的数据 是一个对象 

​				 title: 新的网页标题 一般省略 

​				url: 新的网页的url

replaceState：该方法用于替换当前的历史记录

​		使用方式：history.pushState(obj, title, url)

​				 obj: 添加的数据 是一个对象

​				 title: 新的网页标题 一般省略 

​				url: 新的网页的url

window.onpopstate事件：该事件可以监听replaceState方法的执行以及页面的切换。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <a href="./first.html">进入first页面</a>
    <button id="btn1">添加第一条记录</button>
    <button id="btn2">添加第二条记录</button>
    <button id="btn3">替换记录</button>
<script>
btn1.onclick = function() {
    // 添加记录
    history.pushState({ num: 100 }, '第一个页面', '#demo1')
}
btn2.onclick = function() {
    // 添加记录
    history.pushState({ num: 200 }, '第二个页面', '#demo2')
}
btn3.onclick = function() {
    // 替换记录
    history.replaceState({ num: 300 }, '第三个页面', '#demo3')
}
// 监听页面切换
window.onpopstate = function(e) {
    console.log(111, e, e.state);
}
</script>
</body>
</html>
```



 

