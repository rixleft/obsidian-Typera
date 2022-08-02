# for
- for(初始值;条件判断;循环变量的改变){循环语句}
	- 循环语句的条件  
        - 1：循环初始值
        - 2：循环条件判断
        - 3：循环语句
        - 4：循环变量的改变
==初始值可以拿到外部定义，但括号内的分号不能丢。==
循环嵌套时，外层循环控制行，内层循环控制列，内外循环的变量不要使用同一个。


```js
	<script>
	//九九乘法表
	for (var i = 1; i <= 9; i++) {
	    for (var j = 1; j <= i; j++) {
	        document.write(i + "*" + j + "=" + (i * j) + '&nbsp;&nbsp;');
        }
            document.write("<br/>")
    }
	</script>
```

穷举法：依次列出所有的可能性，然后根据条件进行判断。

```js
	<script>
	// 输出100以内所有的质数
	//方法一
        for(var z=2;z<=100;z++) {
            // console.log(z)
             var t = true
            for (var i = 2; i < z; i++) {
                if (z % i == 0) {
                    t = false
                }
            }
            if (t) {
                console.log(z)
            }
            // } else {
            //     console.log("不是质数")
            // }
        }
	// 方法二
		for (var i = 1; i < 100; i++) {
		var count = 0;
			for (var j = 1; j <= i; j++) {
				if (i % j == 0) {
					count++;
				}
			}
			if (count == 2) {
				console.log(i);
			}
		}
	// 方法三
		for (var i = 2; i < 100; i++) {
		var count = 0;
		for (var j = 1; j <= Math.sqrt(i); j++) {    //如果这个数不是质数，那么必定有约数小于等于它的平方根。
			if (i % j == 0) {
				count++;
			}
		}
			if (count == 1) {
				console.log(i);
			}
		}     
    	</script>
```
# while
- while循环
	- 语法：
	 - 1. 循环的初始值
	 - 2. while(条件判断) {
     - 3. 循环语句
     - 4. 循环变量的改变
        }

# do while
- 语法：
	- 1. 循环的初始值
    - 2. do {
    - 3. 循环语句
	- 4. 循环变量的改变 
    - 5. }while(条件判断)

do while的方式不管条件是否成立都会执行一次，for和while只要一开就不成立那就不执行，do while 与 while循环如果循环语句和循环变量改变，他们的顺序不一样最终执行的结果不一样。
# for/in


# 关键字
- break 立马结束，结束当前自身的循环。
- continue 直接跳过当前这次程序进行下一次，跳过当前这次循环。
- 如果存在，循环的嵌套，只能结束或跳过自身的这次循环 想要结束或跳过其他循环，可以给你想要结束或跳过的循环起一个名字，使用关键字。