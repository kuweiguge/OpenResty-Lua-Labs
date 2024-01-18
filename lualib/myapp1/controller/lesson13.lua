--[[
    13. OpenResty的HTTP服务器 - 处理HTTP请求
]]

ngx.say("----------------------------------------示例1----------------------------------------")
-- 获取查询参数
-- curl "http://localhost:8088/myapp1/lesson13?username=aaa&test=123"
local args = ngx.req.get_uri_args()
for key, val in pairs(args) do
    ngx.say("查询参数:" .. key .. ": " .. val)
end

ngx.say("----------------------------------------示例2----------------------------------------")
-- 响应json数据
local cjson = require "cjson"
ngx.header.content_type = 'application/json'
ngx.say(cjson.encode({message = "Hello, JSON!"}))

-- 响应动态数据
local time = ngx.now()
ngx.say("当前时间: " .. os.date("%Y-%m-%d %H:%M:%S", time))

ngx.say("----------------------------------------示例3----------------------------------------")
-- 读取和解析 POST 请求体 `curl -X POST -d "Hello" http://localhost:8088/myapp1/lesson13`
ngx.req.read_body()  -- 显式读取请求体
local body = ngx.req.get_body_data()
ngx.say("请求体: ", body)