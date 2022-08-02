# 语法
## form的相关属性
一个表单，如果没有`form`，不影响最终的显示效果，但是会影响表单的按钮功能，
`name`  表单名称
`action` 表单的提交地址
`method` 表单的提交方式和方法
    `method="get"`  默认是get  从服务器上获取 get会将一些信息放到地址栏中 因此安全性低 效率高  做查询数据时使用
    `method="post"`  向服务器上传  安全性高  效率低  一些密码安全等级比较高的用post
`target` 表单的提交方式  默认是在当前窗口 _self 可以在新的窗口提交 _blank
```html
<form name="" action="" method="post" target="_blank">
         <input type="text" name="use">
         <input type="password" name="pwd">
         <input type="submit" value="提交">
</form>
```

### input可以设置的属性
- `type` input的类型  决定显示成什么样子
- `name` input的名称  需要就写不需要可以不用 但是radio这个标签必须要有name 一组保持一致，必然不能实现单选
- `checked` 默认选中状态 常用于`radio`  `checkbox`
- `disabled` 禁用
- `multiple` 实现选择多个
- `value`  默认值  是值这个input的值 他是数据 是可以提交
- `placeholder` 提示信息  这个只能对用户起到提示的效果， 不是input的值 不可以提交（注意：html5新增属性，低版本浏览器不支持）
- `maxlength` 最多可以输入的字符
- `minlength` 最少可以输入的字符
- `size` 文本框input的长度 （了解）
- `autofocus` 规定当页面加载时 `<input>`元素应该自动获得焦点。
- `disabled`  规定应该禁用的 `<input>`元素
- `pattern`  规定用于验证 `<input>`元素的值的正则表达式。
	- `<input type="text" pattern="\d{3}"> <input type="submit" value="提交">`验证输入的字符数为3时成立并可以成功提交。
- `required`  规定必需在提交表单之前填写输入字段。
- `nocalidate`  表单不进行验证直接提交
- `autocomplete` 可以记录控件历史提交的数据
	- `autocomplete="on"`
	- `autocomplete="off"`

### input的Type类型的属性值
- `text`  文本框  输入什么就显示什么
- `password`  密码框  不管输入的是什么都显示点点点
- `radio`  单选按钮    单选题使用
- `checkbox`  复选框   可以当做用户协议的那个同意框
- `file`    文件域  可以上传文件 图片文件
- `image`   图片域  可以当做提交按钮使用
- `button`  普通按钮 没啥效果
- `reset`   重置按钮  相当于恢复出厂设置
- `submit`  提交按钮  可以起到条件的效果
- `hidden`  隐藏按钮  可以在提交的地址栏中添加一些数据
- `seaech` 定义用于输入搜索字符串的文本字段。
	- ```
```html
	!<--可以记录搜索历史-->
	<input type="search" list="history">
    <datalist id="history">
        <option value="123"></option>
        <option value="456"></option>
        <option value="789"></option>
     </datalist>
```
- `range`  定义用于精确值不重要的输入数字的控件（比如 slider 控件）。
- `number` 定义用于输入数字的字段。
- `color`  定义拾色器。
- `url`  定义用于输入 URL 的字段
- `email`  定义用于 e-mail 地址的字段。
- `time`  定义用于输入时间的控件（不带时区）。
- `date`  定义 date 控件（包括年、月、日，不包括时间）。
- `week` 定义 week 和 year 控件（不带时区）。
- `month` 定义 month 和 year 控件（不带时区）
- `datetime-local` 定义 date 和 time 控件（包括年、月、日、时、分、秒、几分之一秒，不带时区）。




```html
<form>
     <!--文本框最大长度为15个字-->
        用户名：<input type="text" maxlength="15">
        密码框：<input type="password">
        单选按钮：<input type="radio">
        复选框：<input type="checkbox">
        <!--multiple可选择多个文件一起上传-->
        文件域：<input type="file" multiple>
        图像域：<input type="image" src="./bg.png">
        普通按钮：<input type="button" value="按钮">
        <!--提交，重置等控件写在表单标签里才生效-->
        重置按钮：<input type="reset" value="重置">
        <!--disable为禁用-->
        提交按钮：<input type="submit" value="提交" disabled>
        隐藏按钮: <input type="hidden" value="隐藏" name="qwe">
        隐藏按钮: <input type="hidden" value="vvv" name="abc">
        搜索：<input type="search"><br>
        滑块：<input type="range"><br>
        数字：<input type="number"><br>
        颜色：<input type="color"><br>
        网址：<input type="url"><br>
        邮箱：<input type="email"><br>
        时间：<input type="time"><br>
        日期：<input type="date"><br>
        周期：<input type="week"><br>
        月份：<input type="month"><br>
        日期和时间<input type="datetime-local"><br>
        <input type="submit" value="提交"> 
</form>
```
==value  默认值，是指这个input的值，它也是数据，是可以提交的。
placeholder 提示信息 ，这个只能对用户起到提示的效果，不是input的值，不可以提交。==

html5支持不用将所有的表单控件都写在form里面，表单控件可以有两种写法。

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
    <!-- html5支持不用将所有的表单控件都写在form里面 -->
    <form>
        <input type="text">
        <input type="submit">
    </form>
    <!-- 给form写一个id名称 只要是属于这个form的表单控件都添加 form="id名称" -->
    <form id="login"></form>
    <input type="text" form="login">
    <input type="submit" form="login">
</body>
</html>
```


### 注册页面
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>项目实践</title>
</head>
<body>
<form action="">
	<table width="500">
	    <tr>
		   <td><label for="name">姓名：</label></td>
			<td><input type="text" name="username" value="请输入姓名" maxlength="10" id="name"></td>
        </tr>
        <tr>
            <td> 性别：</td>
		    <td> <label for="nan">男</label> <input type="radio" name="sex" id="nan">
                 <label for="nv">女</label> <input type="radio" name="sex" id="nv"> </td>
        </tr>
         <tr>
		<td><label for="birth">生日：</label></td>
		<td> 年
			<select name="" id="">
                        <option>--请选择年--</option>
                        <option>1997</option>
                        <option>1998</option>
                        <option>1999</option>
                        <option>2000</option>
                        <option>2001</option>
                        <option>2002</option>
                        <option>2003</option>
                        <option>2004</option>
                        <option>2005</option>
                        <option>2006</option>
                        <option>2007</option>
                        <option>2008</option>
                        <option>2009</option>
                        <option>2010</option>
                        <option>2011</option>
                        <option>2012</option>
                        <option>2013</option>
                        <option>2014</option>
                    </select>
                    月
                    <select name="" id="">
                        <option value="">--请选择月--</option>
                        <option value="">1月</option>
                        <option value="">2月</option>
                        <option value="">3月</option>
                        <option value="">4月</option>
                        <option value="">5月</option>
                        <option value="">6月</option>
                        <option value="">7月</option>
                        <option value="">8月</option>
                        <option value="">9月</option>
                        <option value="">10月</option>
                        <option value="">11月</option>
                        <option value="">12月</option>
                    </select>
                    日
                    <select name="" id="">
                        <option value="">--请选择日--</option>
                        <option value="">1</option>
                        <option value="">2</option>
                        <option value="">3</option>
                        <option value="">4</option>
                        <option value="">5</option>
                        <option value="">6</option>
                        <option value="">7</option>
                        <option value="">8</option>
                        <option value="">9</option>
                        <option value="">10</option>
                        <option value="">11</option>
                        <option value="">12</option>
                        <option value="">13</option>
                        <option value="">14</option>
                        <option value="">15</option>
                        <option value="">16</option>
                        <option value="">17</option>
                        <option value="">18</option>
                        <option value="">19</option>
                        <option value="">20</option>
                        <option value="">21</option>
                        <option value="">22</option>
                        <option value="">23</option>
                        <option value="">24</option>
                        <option value="">25</option>
                        <option value="">26</option>
                        <option value="">27</option>
                        <option value="">28</option>
                        <option value="">29</option>
                        <option value="">30</option>
                        <option value="">31</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="local">所在地区</label>
                </td>
                <td>
                    <input type="text" value="请输入地区" id="local">
                </td>
            </tr>
            <tr>
                <td>
                    <label for="degree">学历：</label>
                </td>
                <td>
                    <input type="text" id="degree">
                </td>
            </tr>
            <tr>
                <td>
                    <label for="like"></label>
                </td>
                <td>
                    可爱的<input type="checkbox" id="like">
                    妩媚的<input type="checkbox" id="like">
                    妖娆的<input type="checkbox" id="like">
                </td>
            </tr>
            <tr>
                <td>
                    <label for="introduce">自我介绍：</label>
                </td>
                <td>
                    <textarea name="introduce" id="" cols="30" rows="10">简单介绍一下自己吧</textarea>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input type="submit" value="免费注册">
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input type="checkbox" id="rule" checked="checked"> <label for="rule">我同意注册条款和会员标准</label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <a href="#">我是会员，立即登录</a>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <h1>我承诺</h1>
                    <ul>
                        <li>年满十八，单身</li>
                        <li>抱着严肃的态度</li>
                        <li>真诚寻找另一半</li>
                    </ul>
                </td>
      </tr>
</table>
</form>
```
# 效果
![[表单标签1.png]]

### select 下拉菜单
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>标题</title>
</head>
<body>
   <form>
         <input type="text">
         <select>
             <option >第一条</option>
             <!--selected打开时默认选择此选项-->
             <option selected>第2条</option>
             <option >第3条</option>
         </select>
         <!--文本框，五行十列-->
         <textarea cols="10" rows="5"></textarea>
     </form>

</body>
</html>
```

`label`提示信息
将前面的文字与input文本框之间建立联系，点击文字可将光标跳转到文本框。
```html
<form>
    用户名：<input type="text"><br>


         <!-- 第一种使用方式 -->
         <label>用户名：<input type="text"></label><br>
         <!-- 第二种使用方式 -->
    <label for="use">用户名：</label>
    <input type="text" id="use"> <br>
    <label for="tel">电话：</label>
    <input type="text" id="tel"> <br>
</form>
```

`button`当做标签使用也可以
```html
<form>
		<!--第一种方法-->
    <input type="button" value="按钮">
    <input type="button" value="<a href='http://www.baidu.com'>百多</a>">
	    <!--第二种方法-->
    <button>标签</button>
    <button><a href="http://www.baidu.com">百多</a></button>
    
    </form>
```