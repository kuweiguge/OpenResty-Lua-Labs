--[[
    lesson12:Lua的函数式编程
]]

ngx.say("----------------------------------------示例1----------------------------------------")
-- 1. 高阶函数
-- 在函数式编程中，函数可以作为参数传递给其他函数，这些被传递的函数称为高阶函数。

local function applyFunction(func, value)
    return func(value)
end

local function double(x)
    return x * 2
end

ngx.say(applyFunction(double, 5))  -- 输出 10
ngx.say("----------------------------------------示例2----------------------------------------")
-- 2. 匿名函数和闭包
-- Lua 支持匿名函数和闭包。匿名函数是没有名字的函数，通常用于一次性操作。

local numbers = {1, 2, 3, 4}
table.sort(numbers, function(a, b) return a > b end)  -- 降序排序
for _, v in ipairs(numbers) do
    ngx.say(tostring(v))
end
ngx.say("----------------------------------------示例3----------------------------------------")
-- 3. 递归函数
-- 递归是函数式编程的一个重要特性。在 Lua 中，函数可以调用自身。

local function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end
ngx.say(tostring(factorial(5)))  -- 输出 120
