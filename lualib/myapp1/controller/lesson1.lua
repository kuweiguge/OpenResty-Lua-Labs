--[[
    lesson1:变量和类型
    Lua有8种基本的数据类型：nil、boolean、number、string、userdata、function、thread和table
    Lua是动态类型的语言，这意味着你不需要声明变量的类型，Lua会自动推断

    type()函数可以返回变量的类型
    ngx.say()函数用于输出内容到页面
]]

local null = nil            
local is_open_source = true
local version = 1.15      
local name = "OpenResty"    
local userdata = ngx.null   
local func = function() end 
local thread = coroutine.create(function() end)
local table = {}     
ngx.say('【数据类型】')
ngx.say(type(null))             -- nil       
ngx.say(type(is_open_source))   -- boolean
ngx.say(type(version))          -- number
ngx.say(type(name))             -- string
ngx.say(type(userdata))         -- userdata  
ngx.say(type(func))             -- function
ngx.say(type(thread))           -- thread    
ngx.say(type(table))            -- table


--[[
    使用local关键字来声明一个局部变量,或者直接赋值来声明一个全局变量,
    在Lua中，全局变量和局部变量的主要区别在于它们的作用域。局部变量只在它被声明的块或其子块中可见，而全局变量在整个程序中都可见。
]]
ngx.say('【变量】')
local a = 10 -- 这是一个局部变量
b = 20 -- 这是一个全局变量
ngx.say(a)
ngx.say(b)


-- 【Number类型】所有的数字都是双精度浮点数。Lua也支持科学记数法。例如：
local a = 3.14
local b = 314e-2
ngx.say('【Number类型】')
ngx.say(a)
ngx.say(b)


-- 【String类型】使用单引号或双引号来创建字符串。也支持多行字符串和转义序列。例如：
local a = 'hello'
local b = "world"
local c = [[
Hello,
World!
]]
-- 字符串连接使用的是 ..
local d = a .. b
ngx.say('【String类型】')
ngx.say(a)
ngx.say(b)
ngx.say(c)
ngx.say(d)


-- 【Table类型】是一种可以存储任意类型值的数据结构。你可以把表想象成一个关联数组，它的索引可以是任意类型的值，除了nil。例如：
local a = {} -- 创建一个空表
a['key'] = 'value' -- 使用字符串作为索引
a[1] = 'value' -- 使用数字作为索引
ngx.say('【Table类型】')
ngx.say(a['key'])
ngx.say(a[1])
ngx.say(#a) -- #操作符返回表的长度(值的个数而不是索引的个数)


-- 【Function类型】在Lua中，函数可以存储在变量中，作为参数传递，从其他函数返回等。Lua支持匿名函数和高阶函数。例如：
local function add(a, b) -- 定义一个函数
    return a + b
end
local f = add   -- 将函数赋值给变量
ngx.say('【Function类型】')
ngx.say(f(1, 2))  -- 调用函数

-- 【Thread类型】Lua中的线程并不是操作系统级别的线程，而是协同程序（协程）。协程是一种可以被挂起和恢复执行的函数。例如：
local co = coroutine.create(function () -- 创建一个协同程序
    ngx.say('Hello')
    coroutine.yield()
    ngx.say('World')
end)
ngx.say('【Thread类型】')
coroutine.resume(co) -- resume(co)恢复执行 -> 输出：Hello -> 然后yield()挂起
coroutine.resume(co) -- resume(co)恢复执行 -> 输出：World

-- 【Nil类型】nil类型表示一种没有任何有效值（类似于java中的null，javascript中的undefined）。例如：
local a -- 默认值是nil
local t = {1, 2, 3, nil}
ngx.say('【Nil类型】')
ngx.say(a) -- 输出：nil
ngx.say(#t) -- 输出：3

-- 【Userdata类型】Userdata类型用于表示任何由C语言代码存储的数据。Userdata在Lua中主要用于表示一些不能用标准Lua类型表示的值，例如文件句柄、窗口句柄等。
--  例如通过lua获取redis的值时，对应的key不存在，返回的就是 ngx.null 而不是 nil，这个userdata类型的值
ngx.say('【Userdata类型】')
local redis = require "resty.redis"
local red = redis:new()
red:set_timeout(1000)  -- 1 sec
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end
local res, err = red:get("dog")
if not res then
    ngx.say("failed to get dog: ", err)
    return
end
if res == ngx.null then
    ngx.say("dog not found.")
    return
end
ngx.say("dog: ", res)
red:set_keepalive(10000, 100)
