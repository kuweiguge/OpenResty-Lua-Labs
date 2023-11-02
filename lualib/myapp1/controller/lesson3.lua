--[[
    lesson3:模块
    在Lua中，模块类似于一个库，可以包含函数和变量。
        模块的主要目的是帮助你组织代码，并提供重用代码的方式。
        你可以将一些相关的函数和变量放在一个模块中，然后在其他地方使用这个模块。
        使用require函数来加载一个模块。
        当加载一个模块时，Lua会执行这个模块的所有代码，并将这个模块的返回值作为模块的值。
]]

-- 因为在nginx.conf中配置的lua_package_path，包含 `$prefix/lualib/?.lua;` 所以require的时候，会从这个目录下找
-- $prefix代表当前nginx的工作目录。即/path/to/OpenResty-Lua-Labs/
local mathlib = require("myapp1.model.mathlib") -- 加载模块
ngx.say(mathlib.add(1, 2)) -- 调用模块中的函数
-- 在Lua中，`local function`和`function`的主要区别在于作用域。
-- `local function`定义的函数只在定义它的块（或者说作用域）中可见，而function定义的函数则是全局的，可以在任何地方访问。

mathlib.publicFunction() -- 调用公有函数，输出："This is a public function." "This is a private function."
ngx.flush() -- 刷新缓冲区，将输出打印到页面上,否则下面的函数报错会导致页面不输出。或者使用print()函数代替ngx.say()函数，要在error.log中查看输出
mathlib.privateFunction() -- 尝试调用私有函数，error.log中会报错：attempt to call field 'privateFunction' (a nil value)