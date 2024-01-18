--[[
    lesson11:Lua的面向对象编程
]]

-- 基础角色类(使用table来模拟对象)
local Character = {}
Character.__index = Character

function Character.new(name, health)
    local self = setmetatable({}, Character)
    self.name = name
    self.health = health
    return self
end

function Character:takeDamage(amount)
    self.health = self.health - amount
    ngx.say(self.name .. " 受到了 " .. amount .. " 点伤害，剩余生命：" .. self.health)
end

-- 玩家类 (原型继承 了角色类)
local Player = setmetatable({}, {__index = Character})
Player.__index = Player

function Player.new(name, health, level)
    local self = Character.new(name, health)
    setmetatable(self, Player)
    self.level = level
    return self
end

function Player:levelUp()
    self.level = self.level + 1
    ngx.say(self.name .. " 升级了！当前等级：" .. self.level)
end

-- 创建一个玩家对象
local player1 = Player.new("勇者", 100, 1)
-- 调用类方法
player1:takeDamage(20)
player1:takeDamage(10)
player1:levelUp()
-- 访问类字段
ngx.say(player1.name .. " 的生命值" .. player1.health .. ",等级" .. player1.level)
ngx.say("----------")
-- 创建一个玩家对象
local player2 = Player.new("男刀", 200, 4)
-- 调用类方法
player2:takeDamage(20)
player2:takeDamage(10)
player2:levelUp()
-- 访问类字段
ngx.say(player2.name .. " 的生命值" .. player2.health .. ",等级" .. player2.level)
