local _M = {}

local mt = {}  -- 空的元表

-- 定义元方法（计算两个集合的并集）
-- 遍历集合 a 和 b，将集合中的每个元素添加到result集合中。由于result集合是以集合元素为键的表，所以重复的元素会被覆盖，从而实现了并集的效果。
function mt.__add(a, b)
	local result = {}
	for _, v in pairs(a) do result[v] = true end
	for _, v in pairs(b) do result[v] = true end
	return result
end

function _M.union(set1, set2)
    -- 使用 setmetatable 函数将元表 mt 设置为 set1 和 set2 的元表。
    -- 这样，当对这两个集合执行加法操作时，Lua 会调用元表中的 __add 方法。
    setmetatable(set1, mt)
    setmetatable(set2, mt)
    return set1 + set2
end

return _M