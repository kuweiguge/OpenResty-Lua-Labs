--[[
    lesson2:控制结构
    Lua提供了一套丰富的控制结构，包括条件语句、循环语句和异常处理等。
]]

-- 【条件语句】Lua中的条件语句有if、else和elseif
ngx.say('【条件语句】')
local a = 10
if a > 0 then
    ngx.say("a is positive")
elseif a < 0 then
    ngx.say("a is negative")
else
    ngx.say("a is zero")
end

-- 【循环语句】Lua中的循环语句有while、repeat和for
ngx.say('【循环语句】')
-- while loop
ngx.say('while loop')

local a = 10
while a > 0 do
    ngx.say(a)
    a = a - 1
end

-- repeat loop
ngx.say('repeat loop')
local b = 10
repeat
    ngx.say(b)
    b = b - 1
until b == 0

-- for loop
ngx.say('for loop')
for i = 1, 10 do
    ngx.say(i)
end

-- 【异常处理】Lua中的异常处理使用pcall或xpcall函数来捕获异常，使用error函数来抛出异常。
ngx.say('【异常处理】')

local function divide(x, y) -- 除法函数
    if y == 0 then
        error("division by zero")  -- 抛出错误
    else
        return x / y
    end
end

local status, result = pcall(divide, 10, 0)  -- 捕获错误
if status then
    ngx.say(result)
else
    ngx.say("Error: " .. result) -- Error: .../OpenResty-Lua-Labs/lualib/myapp1/controller/lesson2.lua:47: division by zero
end