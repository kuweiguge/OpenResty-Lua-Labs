--[[
    lesson7:协程
    Lua 中的协程是通过 coroutine 库来实现的。
    一个协程可以处于以下几种状态：挂起（suspended）、运行（running）、死亡（dead）或正常（normal）。
    创建协程非常简单，你只需使用 coroutine.create(function) 函数，并传递一个function作为参数，当和 resume 配合使用的时候就唤醒函数调用。
    使用 coroutine.status(co) 获取协程的状态。
    使用 coroutine.resume(co) 唤醒一个挂起的协程,协程都会从上次调用 coroutine.yield() 的位置恢复执行。
    使用 coroutine.yield() 挂起一个协程。
    使用 coroutine.running() 获取当前正在运行的协程。
    使用 coroutine.isyieldable() 判断当前协程是否可以被挂起。
    使用 coroutine.resume(co, value) 函数来唤醒一个挂起的协程，并传递一个参数给它。
]]

ngx.say("----------------------------------------示例1----------------------------------------")
-- 这个示例展示了如何创建协程、启动和恢复协程，以及检查协程的状态。

local function simpleCoroutine()
    ngx.say("协程开始")
    coroutine.yield() -- 每次调用 coroutine.resume() 时，都会从这里恢复执行
    ngx.say("协程恢复")
end

local co = coroutine.create(simpleCoroutine)
ngx.say("协程状态: " .. coroutine.status(co))
coroutine.resume(co)
ngx.say("协程状态: " .. coroutine.status(co))
coroutine.resume(co)

ngx.say("-----------------------------------------示例2---------------------------------------")
-- 这个示例演示如何使用协程作为自定义迭代器。

local function counter(max)
    for i = 1, max do
        coroutine.yield(i) -- 每次调用 coroutine.resume() 时，都会从这里恢复执行
    end
end
  
local co = coroutine.create(counter)
while true do
    local success, value = coroutine.resume(co, 5)
    if not success then break end
    ngx.say(value)
end
ngx.say("-----------------------------------------示例3---------------------------------------")
-- 使用协程来模拟异步操作，例如等待网络响应。这个示例虽然简化了异步操作的过程，但它说明了如何在等待异步事件时让出控制权。

local function fetchData()
    ngx.say("1 开始获取数据")
    coroutine.yield("等待数据") -- 模拟异步操作
    ngx.say("2 数据获取完成")
end

local co = coroutine.create(fetchData)
coroutine.resume(co)
ngx.say("3 做一些其他操作")
coroutine.resume(co)
ngx.say("-----------------------------------------示例4---------------------------------------")
-- 在协程中处理错误是非常重要的。这个示例展示了如何在协程中捕获和处理错误。
local function riskyFunction()
    ngx.say("执行危险操作")
    error("出现错误")
end
  
local co = coroutine.create(function()
    local status, err = pcall(riskyFunction)
    if not status then
        ngx.say("捕获到错误: " .. err)
    end
end)
coroutine.resume(co)
ngx.say("-----------------------------------------示例5---------------------------------------")
-- 这个示例演示了如何使用协程来实现生产者-消费者模式。这个示例中，producer 函数生成一系列的物品，而 consumer 函数消费这些物品。
local function producer()
    local items = {"苹果", "香蕉", "橙子"}
    for _, item in ipairs(items) do
        coroutine.yield(item)
    end
end

local function consumer(producer_co)
    while coroutine.status(producer_co) ~= 'dead' do
        local success, item = coroutine.resume(producer_co)
        if success and item ~= nil then
            ngx.say("消费了: " .. item)
        end
    end
end

consumer(coroutine.create(producer))
ngx.say("-----------------------------------------示例6---------------------------------------")
-- 这个示例展示了如何在协程间传递消息。

local function sender()
    ngx.say("发送消息:" .. "Hello")
    coroutine.yield("Hello")
    ngx.say("发送消息:" .. "World")
    coroutine.yield("World")
end

local function receiver(co)
    while coroutine.status(co) ~= 'dead' do
        local success,message = coroutine.resume(co)
        if success and message ~= nil then
            ngx.say("收到消息: " .. message)
        end
    end
end

receiver(coroutine.create(sender))
ngx.say("-----------------------------------------示例7---------------------------------------")
-- 示例 8: 协程和网络请求
-- 协程非常适合处理异步网络请求，例如，你可以使用协程等待网络响应而不阻塞主线程。
local function fetchUrl(url)
    ngx.say("开始请求 URL: " .. url)
    -- 这里可以是异步网络请求的代码
    coroutine.yield("请求发送，等待响应") -- 模拟异步请求
    ngx.say("收到来自 " .. url .. " 的响应")
end

local co = coroutine.create(function()
    fetchUrl("http://baidu.com")
end)

coroutine.resume(co)
ngx.say("主线程其他操作")
coroutine.resume(co)
ngx.say("-----------------------------------------示例7---------------------------------------")
-- 示例 9: 协程用于游戏开发
-- 在游戏开发中，协程可以用于管理游戏状态或动画。
local function gameLoop()
    local state = "开始"
    repeat
        ngx.say("游戏状态: " .. state)
        state = (state == "开始") and "进行中" or "结束"
        coroutine.yield()
    until state == "结束"
    ngx.say("游戏结束")
end

local co = coroutine.create(gameLoop)
repeat
    coroutine.resume(co)
until coroutine.status(co) == 'dead'
