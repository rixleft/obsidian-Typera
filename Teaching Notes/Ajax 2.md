# Ajax与Nodejs第6天

## 一、ajax 基础

### 1.1 历史记录

在H5中提供了history对象用于操作历史记录的，分别提供了两个方法：

 history.pushState(any, title, url)

 history.replaceState(any, title, url)

 以上两个方法都是改变历史记录列表的

​		 any: 表示数据

​		 title: 新的网页标题 一般省略

​		 url： 新的网页的url

与之配套的还有一个事件：window.onpopstate事件

​	 该事件会在历史记录发生变化的时候执行

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        html,
        body {
            background-color: #efefef;
        }
        .container {
            width: 1100px;
            margin: 50px auto;
            background-color: #fff;
            padding: 10px;
        }

        /* 定义公共类 */
        .row {
            display: flex;
        }
        .title {
            height: 50px;
            line-height: 50px;
            font-size: 16px;
            font-weight: 600;
        }

        .warp {
            font-size: 13px;
        }

        .jobName {
            flex: 4;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .jobType {
            flex: 3;
        }
                
        .jobAddress,
        .jobNum,
        .jobTime {
            flex: 2;
        }

        .item {
            height: 35px;
            line-height: 35px;
            margin-bottom: 10px;
            border-bottom: 1px dashed #ccc;
            padding-bottom: 10px;
        }

        .btns {
            text-align: center;
        }
        button {
            width: 100px;
            height: 40px;
            background-color: #fff;
        }
    </style>
</head>
<body>

    
    <div class="container">
        <div class="title row">
            <div class="jobName">职位名称</div>
            <div class="jobType">职位类别</div>
            <div class="jobAddress">工作地点</div>
            <div class="jobNum">招聘人数</div>
            <div class="jobTime">更新时间</div>
        </div>
        <div class="warp">
            <!-- <div class="item row">
                <div class="jobName"> 昆仑芯-芯片研发部_Codec设计高级工程师(J12025)</div>
                <div class="jobType">技术</div>
                <div class="jobAddress">北京市</div>
                <div class="jobNum">1人</div>
                <div class="jobTime">2022-06-22</div>
            </div> -->
        </div>
    </div>

    <div class="btns">
        <button id="prev">上一页</button>
        <strong>第<span id="num">1</span>页</strong>
        <button id="next">下一页</button>
    </div>
    <!-- 引入jq -->
    <script src="./js/jquery.js"></script>
    <script>

    // 定义信号量
    let idx = 1;

    // 定义一个数据池对象
    let database = {};

    // 定义发送请求的方法
    async function sendAjax() {
        let { data: res } = await new Promise(resolve => $.get(`/data/baidu_0${idx}.json`, res => resolve(res)));

        // 添加新的历史记录
        history.pushState({ idx }, null, '#' + idx);

        // 每发送一次请求 就存储一次数据
        database[idx] = res;

        // 执行渲染视图的方法
        renderView(res);
    }

    // 定义视图方法
    function renderView(res) {
        // 定义模板变量
        let html = '';
        // 遍历数组
        res?.list?.forEach(item => {
            html += `
                <div class="item row">
                    <div class="jobName">${item.name}</div>
                    <div class="jobType">${item.postType}</div>
                    <div class="jobAddress">${item.workPlace}</div>
                    <div class="jobNum">${item.recruitNum}</div>
                    <div class="jobTime">${item.publishDate}</div>
                </div>
            `
        });

        // 上树
        $(".warp").html(html);
    }

    // 天生执行一次
    sendAjax();


    // 下一页
    $('#next').click(function() {
        idx++;
        // 边界判断
        if (idx > 5) {
            idx = 5;
            return alert('已经是最后一条数据了')
        }

        // 改变页码
        $('#num').html(idx);

        // 判断数据池里面是否有数据
        if (database[idx]) {
            // 传递数据渲染视图
            renderView(database[idx])
            
            // 添加新的历史记录
            history.pushState({ idx }, null, '#' + idx);
        } else {
            // 发送请求
            sendAjax();
        }
    })
    
    // 上一页
    $('#prev').click(function() {
        idx--;
        // 边界判断
        if (idx < 1) {
            idx = 1;
            return alert('已经是第一条数据了')
        }

        // 改变页码
        $('#num').html(idx);

        // 发送请求
        // sendAjax();

        // 改变历史记录
        history.back();
    })
   
    
    // 与之配套的还有一个事件：window.onpopstate事件
    window.onpopstate = function(e) {
        // 具体的数据在e.state中
        // 执行渲染方法
        renderView(database[e.state.idx]);
    }

   </script>
</body>
</html>
```

