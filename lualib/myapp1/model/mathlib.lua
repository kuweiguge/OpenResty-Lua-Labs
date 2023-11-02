-- file: mathlib.lua
local _M = {} -- 创建一个新的table，这个table就是这个模块

function _M.add(a, b)
    return a + b
end

function _M.subtract(a, b)
    return a - b
end

function _M.multiply(a, b)
    return a * b
end

function _M.divide(a, b)
    if b ~= 0 then
        return a / b
    else
        error("division by zero")
    end
end

local function privateFunction() -- 私有函数，只在这个模块中可见
    ngx.say("this is a private function")
end

function _M.publicFunction() -- 公有函数，可以在其他地方访问
    ngx.say("This is a public function.")
    privateFunction()
end

return _M -- 返回这个模块