[webpack中resolve.alias的使用 - 掘金](https://juejin.cn/post/6844903886147305480)
在项目中我们会使用一些公共的组件或者方法，但是如果项目层级比较深并且组件比较多的话，写起来就比较麻烦.

```arduino
client
├── components   
│          └── layout                    
│          │     └── index.jsx         
│          │     └── inex.scss
│          └── header
│                └──index.jsx
│                └──index.scss
│            
├── utils
├── constants
├── pages
|      └── 2019                    
│           └── dome
|                ├── container
|                      └──home
|                          └──index.jsx
|                          └──index.scss
|-                  




```

比如我在配置resolve.alias之前我需要在home组件中引用`components`下了的header组件我需要这样写

```css
import header from '../../../../components/header';
复制代码
```

感觉写起来好痛苦啊,并且如果你想要将某个文件移动到不同的文件夹时，手动更改路径就会更加痛苦。

我们在`webpack.config.js`中

```csharp
resolve: {
    extensions: [
      '.jsx', '.js',
      '.web.ts', '.web.tsx', '.web.js', '.web.jsx',
      '.ts', '.tsx',
      '.json',
    ],
    alias: {
      // 添加目录便于引用
      '@components': path.resolve(__dirname, '../components'),
      '@utils': path.resolve(__dirname, '../utils'),
    },
  },

```

我们就可以这样引用了,你根本不用担心路径的问题。

```javascript
import Layout from '@components/layout'

```

但是光这样还是不行，如果你的项目中引入eslint代码检测，eslint就会报路径错误，这个时候就需要安装一个插件：

```arduino
npm install eslint-plugin-import eslint-import-resolver-alias --save-dev

```

然后在你的.eslintrc.js中增加如下代码:

```css
"settings": {
    "import/resolver": {
      "alias": {
        "map": [
          ["@components", path.resolve(__dirname, './components')],
          ["@utils", path.resolve(__dirname, './utils')]
        ]
      }
    }
  }

```

现在eslint 不报错了，但是在`VScode`中使用`ctrl+`鼠标左键无法识别别名路径，这就给我们调试代码代码了麻烦。

接下来我们就要新建一个文件`jsconfig.json`让编辑器能识别到我们的别名.

```perl
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@components/*": ["components/*"],
      "@utils/*":["utils/*"]
    }
  }
}

```

参考链接：

[www.npmjs.com/package/esl…](https://link.juejin.cn?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Feslint-import-resolver-alias "https://www.npmjs.com/package/eslint-import-resolver-alias") ，

[webpack.docschina.org/configurati…](https://link.juejin.cn?target=https%3A%2F%2Fwebpack.docschina.org%2Fconfiguration%2Fresolve "https://webpack.docschina.org/configuration/resolve")

  
作者：代码写着写着就懂了  
链接：https://juejin.cn/post/6844903886147305480  
来源：稀土掘金  
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。