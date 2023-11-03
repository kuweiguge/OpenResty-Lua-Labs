--[[
    lesson6:错误处理
    pcall函数: 可以调用一个函数并捕获该函数中的任何错误。
        基本结构: local status, result = pcall(function_to_call, arg1, arg2, ...)
        function_to_call是要调用的函数，arg1, arg2, ...是传递给该函数的参数。
        pcall会返回两个值：一个布尔值status和一个结果result。
        如果函数成功执行，status将为true，result将包含函数的返回值。
        如果函数执行过程中发生错误，status将为false，result将包含错误信息。
    xpcall函数: xpcall和pcall非常相似，但是它可以指定一个错误处理函数。这个错误处理函数将在发生错误时被调用，并接收错误信息作为参数。
        基本结构: local status, result = xpcall(function_to_call, error_handler, arg1, arg2, ...)
]]

local function divide(a, b)
    if b == 0 then
        error("Cannot divide by zero") -- error函数是抛出一个错误
    end
    return a / b
end


local status, result = pcall(divide, 10, 0) -- 调用divide函数，传递参数10和0，即10/0，会发生错误
if status then
    ngx.say("Result: " .. result)
else
    ngx.say("Error: " .. result)
end

local function myErrorHandler(err)
    return "Error: " .. err
end

local status, result = xpcall(divide, myErrorHandler, 10, 0)
if status then
    ngx.say("Result: " .. result)
else
    ngx.say(result)
end

--[[
    在OpenResty中，你可以使用pcall和xpcall来处理异步操作中的错误。
    这在使用 ngx.timer.at 创建定时器或者使用 ngx.thread.spawn 创建新的Nginx线程时特别有用。
]]

local function handler(premature, name)
    if premature then
        return
    end
    local status, result = pcall(function()
        error("Some error occurs1") -- 模拟这里可能会抛出一个错误，使用pcall 类似java的try catch捕获,否则程序会中断
        print("Hello, " .. name) 
    end)
    if not status then
        ngx.log(ngx.ERR, "Error in timer function: ", result) -- 在error.log中记录错误
    end
end

local ok, err = ngx.timer.at(0, handler, "world")

if not ok then
    ngx.log(ngx.ERR, "failed to create timer: ", err)
    return
end


-- ngx.thread.spawn 创建新的Nginx线程的例子：
local function thread_func()
    -- 这里可能会抛出一个错误
    -- print("Hello, world")
    error("Some error occurs2")
end

local function error_handler(err)
    ngx.log(ngx.ERR, "thread error: ", err)
end

local ok, err = xpcall(function() ngx.thread.spawn(thread_func) end, error_handler)

if not ok then
    ngx.log(ngx.ERR, "failed to spawn thread: ", err)
    return
end