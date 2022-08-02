### skew（倾斜函数）
- `transform:skew(angle);`代表在水平方向上倾斜变换，相当于`transform:skewx(angle);`
- `transform:skew(x-angle,y-angle);`表示沿着x轴和y轴倾斜转换,相当于设置 `transform:skewx(角度);`h和 `transform:skewy(角度);`。

### scale（缩放函数）
**默认是以中心点为基点缩放，可以用`transform-origin:`属性更改缩放基点。该属性的属性值可以是具体的像素值，也可以是方位名词——top,center,bottom,left,right等。**
例如：
	`transform-origin:left top;`
	`transform-origin:20px 30px;`
- `transform:scale(x-angle,y-angle);`宽度和高度的缩放
	- `transform:scale(2);`表示宽度和高度都变为原来的两倍。
	- `transform:scale(2,1);`表示宽度变为原来的两倍，高度不变。
	- `transform:scale(0);`会实现隐藏的效果
	- `transform:scale(-1);`会实现水平和垂直反转，宽度和高度不改变。
- `transform:scale3d(x-angle,y-angle,z-angle);` 复合写法
	- `transform:scalex(angle);`单独设置x轴的缩放，即宽度。
		- `transform:scalex(-1);`水平方向反转
	-  `transform:scaley(angle);`单独设置y轴的缩放，即高度。
		- `transform:scaley(-1);`垂直方向反转
	- `transform:scalez(angle);`单独设置z轴的缩放，即厚度。
  
### rotate（旋转函数）
**默认是二维平面以中心点为基点旋转，可以认为是该二维平面沿着三维空间的z轴进行旋转，可以用`transform-origin:`属性更改旋转基点。**
- `transform:rotate(angle);`只支持写一个值，正值会顺时针旋转，负值会逆时针旋转。
	- `transform:rotatex(angle);`视角在正上方，盒子沿着二维平面的x轴旋转。
	- `transform:rotatey(angle);`视角在正上方。盒子沿着二维平面的y轴旋转。
- `transform:rotate3d(x,y,z,angle);`x，y，z的取值只能为0或1或-1，0代表不旋转，1代表旋转，-1代表反方向旋转。
	-  `transform:rotate3d(1,0,0,30deg);`表示沿着x轴旋转30°。

### translate（偏移函数）
`transform:translate(value1,value1);`
在原来的位置上进行偏移，一个值代表x水平方向偏移，两个值时，第一个代表x，第二个代表y，值可以使具体的数值，也可以是百分比。
- `transform:translate(0px,0px);`
- `transform:translate(50%);`是自身高度的百分比
- `transform:translate3d(x,y,z);
	- `transform:translatex();`正值向右 负值向左
	- `transform:translatey();`正值向下 负值向上
	- `transform:translatez();`正值向前 负值向后
- `transform-style: preserve-3d;`3d空间的透视效果
==`transform`的四个功能函数注意顺序不同值相同最终效果不同==
先缩放再偏移和先偏移再缩放所达到的效果不同，因为先缩放，会以中心点为缩放基点，而先偏移，则以偏移后的中心点为缩放基点。
### perspective（透视）
- 两种写法
	- `perspective:;`写给父元素
	- `transform：perspective();`写给元素本身
- **可通过`transform-origin:`属性更改透视基点，属性值可选择像素或方位名词——top,center,bottom,left,right等。**



