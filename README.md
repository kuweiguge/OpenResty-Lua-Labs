![GitHub Repo stars](https://img.shields.io/github/stars/kuweiguge/OpenResty-Lua-Labs)
![GitHub forks](https://img.shields.io/github/forks/kuweiguge/OpenResty-Lua-Labs)

# OpenResty-Lua-Labs

[OpenResty-Lua-Labs](https://github.com/kuweiguge/OpenResty-Lua-Labs) 是一个学习和探索 [OpenResty](https://openresty.org/en/) / [ngx_lua](https://github.com/openresty/lua-nginx-module) 编程的开源实验室。

**仓库描述:** 该存储库包含一系列Lua文件，演示了与OpenResty和Lua编程相关的各种概念。

## 环境设置

在开始学习 [OpenResty](https://openresty.org/en/) / [ngx_lua](https://github.com/openresty/lua-nginx-module) 之前，请确保您已完成以下环境设置：
- **安装 [OpenResty](https://openresty.org/en/)**: 按照 [官方文档](http://openresty.org/cn/installation.html) 安装，并为OpenResty和luajit配置环境变量。

- **编辑器和开发工具**: 选择一个你喜欢的文本编辑器或集成开发环境（IDE）来编写Lua代码。`vscode`/`idea`等IDE都有lua语言插件。

- **克隆仓库**: 使用 [git](https://git-scm.com/) 将该存储库克隆到您的本地环境。

## 仓库结构

```txt
.
├── README.md
├── conf
│   └── nginx.conf      nginx配置文件目录
├── logs                nginx日志文件目录
│   ├── access.log
│   ├── error.log
│   └── nginx.pid
├── lualib              lua代码目录
│   └── myapp1          应用主目录
│       ├── controller  控制器目录
│       ├── init.lua    负责初始化应用，例如加载配置文件、连接到数据库等
│       ├── model       目录包含所有的模型代码。模型负责处理数据和业务逻辑。
│       ├── utils       工具包
│       └── view        目录包含所有的视图代码。视图负责生成用户界面。
└── temp                nginx临时文件目录       
```

## 目录

1. **lua的基本语法**
    - ✅ [示例 1: 变量和类型](lualib/myapp1/controller/lesson1.lua)
    - ✅ [示例 2: 控制结构](lualib/myapp1/controller/lesson2.lua)
    - ✅ [示例 3: 模块](lualib/myapp1/controller/lesson3.lua)
    - ✅ [示例 4: 元表和元方法](lualib/myapp1/controller/lesson4.lua)
    - ✅ [示例 5: setmetatable函数](lualib/myapp1/controller/lesson5.lua)
    - [示例 6: 错误处理](lualib/myapp1/controller/lesson6.lua)
2. **lua的进阶语法**
    - [示例 7: 协程](lualib/myapp1/controller/lesson7.lua)
    - [示例 8: 文件I/O](lualib/myapp1/controller/lesson8.lua)
    - [示例 9: 和C交互](lualib/myapp1/controller/lesson9.lua)
    - [示例 10: 垃圾回收](lualib/myapp1/controller/lesson10.lua)
    - [示例 11: Lua的面向对象编程](lualib/myapp1/controller/lesson11.lua)
    - [示例 12: Lua的函数式编程](lualib/myapp1/controller/lesson12.lua)
3. **OpenResty的HTTP服务器**
    - [示例 13: 处理HTTP请求](lualib/myapp1/controller/lesson13.lua)
    - [示例 14: 发送HTTP响应](lualib/myapp1/controller/lesson14.lua)
    - [示例 15: 使用共享内存](lualib/myapp1/controller/lesson17.lua)
    - [示例 16: 使用子请求](lualib/myapp1/controller/lesson18.lua)
    - [示例 17: 使用TCP/UDP套接字](lualib/myapp1/controller/lesson19.lua)
    - [示例 18: 使用定时器](lualib/myapp1/controller/lesson20.lua)
    - [示例 19: 使用日志功能](lualib/myapp1/controller/lesson21.lua)
    - [示例 20: 负载均衡和反向代理](lualib/myapp1/controller/lesson22.lua)
    - [示例 21: 流量控制](lualib/myapp1/controller/lesson24.lua)
    - ...
4. **模块和库**
    - [示例 22: 访问Redis数据库](lualib/myapp1/controller/lesson16.lua)
    - [示例 23: 访问MySQL数据库](lualib/myapp1/controller/lesson15.lua)
    - [示例 24: HTTP客户端](lualib/myapp1/controller/lesson23.lua)
    - [示例 25: 使用WebSocket](lualib/myapp1/controller/lesson25.lua)
    - [示例 26: JWT客户端](lualib/myapp1/controller/lesson26.lua)
    - [示例 27: Kafka客户端](lualib/myapp1/controller/lesson27.lua)
    - [示例 28: HTML模版引擎](lualib/myapp1/controller/lesson28.lua)
    - ...
4. **实践项目**
    - [高并发首页]()
    - ...
## 快速开始

> 该存储库中的每个Lua文件都是一个特定概念的自包含示例。您可以逐个探索它们或尝试修改他们，查看不同的结果。

在项目根目录执行下面命令，

1. 验证`nginx.conf`配置是否正确
```shell
openresty -p $PWD/ -t
```
2. 启动OpenResty服务
```shell
openresty -p $PWD/
```
3. 访问对应的章节
```shell
# 例如：访问 示例1 对应的是 lualib/myapp1/controller/lesson1.lua的内容
curl http://localhost:8088/myapp1/lesson1
```
4. 返回数据
```txt
【数据类型】
nil
boolean
number
string
userdata
function
thread
table
【变量】
10
20
【Number类型】
3.14
3.14
【String类型】
hello
world
Hello,
World!

helloworld
【Table类型】
value
value
1
【Function类型】
3
【Thread类型】
Hello
World
【Nil类型】
nil
3
【Userdata类型】
dog not found.
```

---

> -p 参数是用来指定 OpenResty 运行的工作目录的，$PWD/ 则是一个环境变量，代表当前的工作目录。
这个命令的意思是在当前目录下启动 OpenResty。OpenResty 启动后，会在这个目录下查找 nginx.conf 配置文件，并根据这个配置文件来运行。

其他命令：

3. 重启OpenResty服务
```shell
openresty -p $PWD/ -s reload
```
4. 停止OpenResty服务
```shell
openresty -p $PWD/ -s stop
```
## 声明
一起逐步完善

啥时候突破 0 star