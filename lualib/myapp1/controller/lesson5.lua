--[[
    lesson5:setmetatable()函数 官方文档：http://lua-users.org/wiki/MetatableEvents
    setmetatable函数用于设置一个表的元表
]]

--[[
    通过一个简单的例子来理解setmetatable和元表的作用。
    假设我们有一个需求，需要创建一个表，这个表的所有键都是小写的，但是我们希望能够通过大写的键来访问这个表。
    例如，我们有一个表t，它有一个键"key"，我们希望通过"KEY"也能访问到这个键的值。
    我们可以通过setmetatable和元表来实现这个需求：
]]

--定义一个表t
local t = {         
    key = "value"
}

--设置t的元表为一个匿名表，这个匿名表重写了__index元方法，这样当我们访问t表中不存在的键时，就会调用元表的__index函数进行查找。
setmetatable(t, {   
    __index = function(t, k)
        return rawget(t, string.lower(k)) -- rawset/rawget：对“原始的”表进行直接的赋值/取值操作。这里的rawget是为了避免死循环。
    end
})

ngx.say(t["KEY"]) -- 输出："value"

--[[
    假设我们正在编写一个向量模块，这个模块需要支持向量的加法运算。
    在Lua中，我们可以使用setmetatable和元表来实现这个需求：
]]

local vector = require("myapp1.model.vector") -- 引入向量模块
local v1 = vector.new(1, 2) -- 创建向量v1 = setmetatable({x = 1, y = 2}, mt)
local v2 = vector.new(3, 4) -- 创建向量v2 = setmetatable({x = 3, y = 4}, mt)
-- 计算这两个向量的和
local v3 = v1 + v2          -- v3 = mt.__add(v1, v2)
-- 打印结果
v3:print()  -- 输出：(4, 6)