# Video
支持的格式 mp4 ogg webm

| 属性     | 描述               |
| -------- | ------------------ |
| autoplay | 自动播放           |
| coltrols | coltrols           |
| width    | 单位：像素         |
| height   | 单位：像素         |
| poster   | 封面图片地址       |
| muted    | 静音               |
| loop     | 循环播放           |
| preload  | 是否等加载完再播放 |
| src      | 视频地址           |
```html
		<!--方法一-->
	<video src="地址"  width="" poster="" controls autoplay muted loop>
         由于您的浏览器版本比较低，不支持视频标签 请<a href="地址" download>点击下载</a>
     </video>
	     <!-- 方法二，此方法要求必须有type-->
     <video controls>
         <source src="地址" type="video/mp4">
     </video>
```

# Audio
支持的格式 mp3 mp4 ogg
| 属性     | 描述     |
| -------- | -------- |
| controls | 控制台   |
| autoplay | 自动播放 |
| muted    | 静音     |
| loop     | 循环播放 | 

```html
		<!--方法一-->
	<audio src="地址"  width="" controls muted loop autoplay></audio>
		<!--方法二,此方法要求必须有type-->
     <audio controls>
         <source src="地址" type="audio/mp3">
     </audio>
```
**注：谷歌不支持在非静音的情况下自动播放。**