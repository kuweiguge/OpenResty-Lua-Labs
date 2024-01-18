--[[
    lesson8:文件I/O
]]

ngx.say("----------------------------------------示例1----------------------------------------")
-- 1. 打开和关闭文件
-- 在 Lua 中，使用 io.open 函数打开文件。这个函数返回一个文件句柄和一个错误消息。

local file, err = io.open("example.txt", "r") -- 以读取模式打开文件
if file then
    ngx.say("文件打开成功")
    -- 文件操作
    file:close() -- 关闭文件
else
    ngx.say("文件打开错误: " .. err)
end

ngx.say("----------------------------------------示例2----------------------------------------")
-- 2. 读取文件
-- 读取文件内容可以使用不同的方法，例如按行读取或整个文件。

local file, err = io.open("/Users/zhengwei/Documents/GitHub/OpenResty-Lua-Labs/lualib/myapp1/controller/lesson7.lua", "r")
if file then
    for line in file:lines() do
        ngx.say(line)
    end
    file:close()
else
    ngx.say("文件打开错误: " .. err)
end
ngx.say("----------------------------------------示例3----------------------------------------")
-- 3. 写入文件
-- 向文件写入内容使用 write 方法。
local file, err = io.open("output.txt", "w")
if file then
    file:write("Hello, Lua!\n")
    file:write("再见, Lua!\n")
    file:close()
    ngx.say("文件写入成功")
else
    ngx.say("文件打开错误: " .. err)
end
ngx.say("----------------------------------------示例4----------------------------------------")
-- 4. 追加到文件
-- 使用 "a" 模式打开文件进行追加。
local file, err = io.open("output.txt", "a")
if file then
    file:write("这是追加的一行。\n")
    file:close()
    ngx.say("文件追加写入成功")
else
    ngx.say("文件打开错误: " .. err)
end
ngx.say("----------------------------------------示例5----------------------------------------")
-- 5. 读取大文件
-- 处理大文件时，应该分块读取，以避免内存问题。
local file, err = io.open("bigfile.txt", "r")
local size = 2^10 -- 1024字节
if file then
    while true do
        local block = file:read(size)
        if not block then break end
        ngx.say(block)
    end
    file:close()
else
    ngx.say("文件打开错误: " .. err)
end
ngx.say("----------------------------------------示例6----------------------------------------")
-- 6. 文件的其他操作
-- Lua 还提供了其他文件操作，例如 seek（定位）、flush（刷新缓冲区）等。
local file, err = io.open("output.txt", "r+")
if file then
    file:seek("end", -10) -- 向后移动10个字节
    file:write("-- END --")
    file:flush()
    file:close()
else
    ngx.say("文件打开错误: " .. err)
end
ngx.say("----------------------------------------示例7----------------------------------------")
-- 示例 7: 处理 CSV 文件
-- 处理 CSV（逗号分隔值）文件是文件 I/O 的一个常见任务。以下示例展示了如何读取和解析 CSV 文件。

local function parseCSVLine(line, sep)
    sep = sep or ','
    local fields = {}
    local pattern = string.format("([^%s]+)", sep)
    line:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

local file, err = io.open("resources/data.csv", "r")
if file then
    for line in file:lines() do
        local fields = parseCSVLine(line)
        for _, field in ipairs(fields) do
            ngx.say(field)
        end
    end
    file:close()
else
    ngx.say("文件打开错误: " .. err)
end
ngx.say("----------------------------------------示例8----------------------------------------")
-- 示例 9: 使用 io.tmpfile
-- io.tmpfile 创建一个临时文件，这在需要临时存储数据时非常有用。
local tmp = io.tmpfile()
tmp:write("这是一些临时数据。\n")
-- 使用临时文件
tmp:seek("set")
ngx.say(tmp:read("*a"))
tmp:close()
ngx.say("----------------------------------------示例9----------------------------------------")
-- 示例 10: 文件属性
-- 使用 lfs（Lua文件系统）库可以访问文件的更多属性。
local lfs = require("lfs")
local file = "resources/data.csv"
ngx.say("大小: " .. lfs.attributes(file, "size"))
ngx.say("修改时间: " .. os.date("%Y-%m-%d %H:%M:%S", lfs.attributes(file, "modification")))
ngx.say("访问时间: " .. os.date("%Y-%m-%d %H:%M:%S", lfs.attributes(file, "access")))
-- lfs 库还可以用来处理目录。
ngx.say("当前目录下的文件有: ")
for file in lfs.dir(".") do
    if lfs.attributes(file, "mode") == "file" then
        ngx.say("文件: " .. file)
    end
end