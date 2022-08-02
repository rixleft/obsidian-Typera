### width
- `width` 宽度是固定值，如果浏览器窗口比宽度的给定值小会出现左右的滚动条。
- `max-width` 最大宽度，如果浏览器的窗口比该给定值小，也不会出现滚动条。
- `min-width` 最小宽度，默认整行显示，如果浏览器窗口小于该给定值时会出现左右的滚动条。
- 事实上，并不会出现同时写的情况。
	- 如果`width`和`max-width`同时出现时，谁的值小显示谁。
	- 如果`width`和`min-width`同时出现时，谁的值大显示谁。
	- 如果`min-width`和`max-width`同时出现时
		- 当`min-width`比`max-width`小时，浏览器窗口比`max-width`大时，显示`max-width`，浏览器窗口在二者宽度之间时，显示浏览器窗口大小，但没有滚动条，当浏览器窗口小于`min-width`，显示滚动条，宽度为`min-width`。



### height
- `height`是固定值，如果浏览器窗口比高度的给定值小则会出现上下的滚动条。
- `max-height`最大高度，如果浏览器的窗口比该给定值小，也不会出现滚动条。
- `min-height` 最小宽度，默认整行显示，如果浏览器窗口小于该给定值时会出现上下的滚动条。
- 事实上，并不会出现同时写的情况。
	- 如果`height`和`max-height`同时出现时，谁的值小显示谁。
	- 如果`height`和`min-height`同时出现时，谁的值大显示谁。
	- 如果`min-height`和`max-height`同时出现时
		- 当`min-height`比`max-height`小时，浏览器窗口比`max-height`大时，显示`max-height`，浏览器窗口在二者宽度之间时，显示浏览器窗口大小，但没有滚动条，当浏览器窗口小于`min-height`，显示滚动条，宽度为`min-height`。