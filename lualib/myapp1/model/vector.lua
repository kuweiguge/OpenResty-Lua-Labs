--[[
    在这个例子中，我们首先定义了一个_M表，这个表将作为我们的向量模块。
    然后，我们定义了一个mt表，这个表将作为我们的元表。
    我们使用setmetatable函数创建了一个新的向量对象，并设置了这个对象的元表为mt。
    mt表中定义了一个__index元方法，这个元方法用于改变表的索引行为。
    当我们试图访问一个表中不存在的字段时，Lua会在_M表中查找这个字段。
    这个例子展示了setmetatable和元表的强大之处：它们可以让我们自定义对象的行为。
    在这个例子中，我们自定义了向量对象的索引行为，使得我们可以在_M表中定义一些公共的方法，然后在每个对象中存储一些特定的属性。
    如果我们不使用setmetatable和元表，那么我们需要在每个对象中都定义一些公共的方法，这会使得代码变得冗余且难以维护。
    通过使用setmetatable和元表，我们可以将这些公共的方法定义在_M表中，然后在每个对象中只存储一些特定的属性，这使得代码更加简洁和易于维护。
]]

local _M = {}               --定义_M表，作为向量模块。
local mt = { __index = _M } --mt表中定义了__index元方法，这个元方法用于改变表的索引行为。当我们试图访问一个mt表中不存在的字段时，Lua会在_M表中查找这个字段。

function _M.new(x, y)
    return setmetatable({x = x, y = y}, mt) --使用setmetatable函数创建了一个新的向量对象，并设置了这个对象的元表为mt。
end
-- new(1,2) returned setmetatable({x = 1, y = 2}, mt)
-- new(3,4) returned setmetatable({x = 3, y = 4}, mt)

function mt.__add(a, b)
    return _M.new(a.x + b.x, a.y + b.y)
end

function _M:print()
    ngx.say("(" .. self.x .. ", " .. self.y .. ")")
end

return _M