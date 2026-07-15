-- local ffi = require("ffi")
-- local lfs = require("lfs")  -- 引入 Lua File System 库
-- local 数据数量 = ffi.new("int[1]")
-- local 线程发送数据 = {}
-- local 定时时间 = os.time()
-- local fenzhong = 1
-- local 定时器 = class()
-- local 人民币比例 = 100
-- local 是否有新的充值 = false

-- -- 定义文件是否存在函数
-- function 文件是否存在(路径)
--     local 文件 = io.open(路径, "r")
--     if 文件 then
--         文件:close()
--         return true
--     else
--         return false
--     end
-- end

-- function 定时器:初始化(v, 循环文件)
--     self.线程 = require("ggethread")(循环文件)
--     self.线程.消息返回 = function(self, ...)
--         if ... == "取数量指针" then
--             return tonumber(ffi.cast("intptr_t", 数据数量))
--         elseif ... == "取数据" then
--             return unpack(r)
--         elseif ... == "循环更新" then
--             local 当前时间 = os.time()
--             if (当前时间 - 定时时间) >= 10 then  -- 每10秒触发一次
--                 定时时间 = 当前时间

--                 -- 检查并创建支付互交.txt文件
--                 local 文件路径 = 程序目录 .. [[dlxt\chongzhi\pay\]] .. "zhifu.txt"

--                 if not 文件是否存在(文件路径) then
--                     -- 文件不存在，创建文件
--                     local 文件 = io.open(文件路径, "w")
--                     if 文件 then
--                         文件:close()
--                         --print("已创建文件:", 文件路径)
--                     else
--                         --print("无法创建文件:", 文件路径)
--                     end
--                 else
--                     --print("文件已存在:", 文件路径)

--                     local 文件 = io.open(文件路径, "r")
--                     if 文件 then
--                         -- 读取文件内容
--                         local 内容 = 文件:read("*a")
--                         文件:close()

--                         充值信息列表 = 分割文本(内容, ";")
--                         --print("单条充值信息:", 充值信息列表)
--                         local ii = 0
--                         for i = 1, #充值信息列表 do
--                             ii = i
--                             local 充值信息 = 分割文本(充值信息列表[i], ",")
--                             if #充值信息 >= 5 then
--                                 -- 检查充值信息[5]是否在 pay.txt 文件中
--                                 local payFilePath = 程序目录 .. [[dlxt\chongzhi\pay\]] .. "pay.txt"
--                                 local payFileContent = ""
--                                 if 文件是否存在(payFilePath) then
--                                     local payFile = io.open(payFilePath, "r")
--                                     if payFile then
--                                         payFileContent = payFile:read("*a")
--                                         payFile:close()
--                                     end
--                                 end

--                                 if string.find(payFileContent, 充值信息[5]) then
--                                     --print("充值信息[5]已存在于 pay.txt 文件中，跳过处理")
--                                 else
--                                     if 充值信息[4] == "0" then
--                                         if 充值信息[3] == "xy" then
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2] * 人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id] == nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 添加仙玉(id,nil, RMBNUM * 人民币比例, "DL充值")
--                                                 添加累充(id, RMBNUM, "DL充值",1)
--                                                 print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了", RMBNUM * 人民币比例, "仙玉")
--                                                 广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R" .. RMBNUM * 人民币比例 .. "#Y仙玉和大量奖励！！"), 频道 = "xt"})

--                                                 充值信息[4] = "1"
--                                                 充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                         elseif 充值信息[3] == "cj12" then
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             玩家数据[id].道具:给予道具(id,"奖池抽奖",12)
--                                             print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了十二个奖池抽奖")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R十二#Y个奖池抽奖！！"), 频道 = "xt"})

--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                             -- 奖池抽奖处理逻辑
--                                         elseif 充值信息[3] == "cj70" then
--                                             -- 奖池抽奖处理逻辑
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             玩家数据[id].道具:给予道具(id,"奖池抽奖",70)
--                                             print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了七十个奖池抽奖")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R七十#Y个奖池抽奖！！"), 频道 = "xt"})

--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                         elseif 充值信息[3] == "cj150" then
--                                             -- 奖池抽奖处理逻辑
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             玩家数据[id].道具:给予道具(id,"奖池抽奖",150)
--                                             print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了一百五十个奖池抽奖")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R一百五十#Y个奖池抽奖！！"), 频道 = "xt"})

--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                         elseif 充值信息[3] == "dj1" then
--                                             -- 奖池抽奖处理逻辑
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             玩家数据[id].道具:给予道具(id,"优惠礼包6",1)
--                                             print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了一个优惠礼包")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R一#Y个优惠礼包！！"), 频道 = "xt"})

--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                         elseif 充值信息[3] == "yk" then
--                                             -- 月卡处理逻辑
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             if 玩家数据[id].角色.月卡 == nil then
--                                                   玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+2592000}
--                                                 elseif os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 then
--                                                   玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+2592000}
--                                                 else
--                                                   玩家数据[id].角色.月卡 = {生效=true,到期时间=玩家数据[id].角色.月卡.到期时间+2592000}
--                                                 end
--                                                 local 领取物品 = {}
--                                                         for n = 1, 10 do
--                                                             if 全局礼包数据.月卡激活[1]["物品"..n] ~= nil then
--                                                                 领取物品[#领取物品 + 1] = table.copy(全局礼包数据.月卡激活[1]["物品"..n])
--                                                             end
--                                                         end
--                                                         礼包奖励类:领取定义礼包(id, 领取物品)
--                                                 常规提示(id,"#Y你使用CDK激活月卡成功,月卡到期日前,每日可领取相应奖励！")
--                                                 玩家数据[id].角色.月卡.激活奖励=true
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,开通了月卡")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,开通了#R月卡#Y！！"), 频道 = "xt"})

--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                         elseif 充值信息[3] == "he10" then--恩典钥匙10把
--                                             -- 奖池抽奖处理逻辑
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             添加仙玉(id,RMBNUM*人民币比例*2, "DL充值")
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             玩家数据[id].道具:给予道具(id,"恩典钥匙",10)
--                                             print("玩家:", 充值信息[1], "参加皇恩活动", 充值信息[2], "次,准备单车变摩托。(本活动的赞助翻倍。。。)")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y参加皇恩活动:#R" .. 充值信息[2] .. "#Y次,准备单车变摩托。(本活动的赞助翻倍。。。)"), 频道 = "xt"})
--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                         elseif 充值信息[3] == "he100" then--恩典钥匙100把
--                                             -- 奖池抽奖处理逻辑
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             添加仙玉(id,RMBNUM*人民币比例*2, "DL充值")
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             玩家数据[id].道具:给予道具(id,"恩典钥匙",100)
--                                             print("玩家:", 充值信息[1], "参加皇恩活动", 充值信息[2], "次,准备单车变摩托。(本活动的赞助翻倍。。。)")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y参加皇恩活动:#R" .. 充值信息[2] .. "#Y次,准备单车变摩托。(本活动的赞助翻倍。。。)"), 频道 = "xt"})
--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                         elseif 充值信息[3] == "he500" then--恩典钥匙500把
--                                             -- 奖池抽奖处理逻辑
--                                             是否有新的充值 = true
--                                             --print("比例:", 充值信息[2]*人民币比例)
--                                             --print("充值信息:", 充值信息[1])
--                                             local id = tonumber(充值信息[1])
--                                             local RMBNUM = tonumber(充值信息[2])

--                                             if 玩家数据[id]==nil then
--                                                 --print("玩家不在线:", 充值信息[1])
--                                             else
--                                                 --do
--                                             添加仙玉(id,RMBNUM*人民币比例*2, "DL充值")
--                                             添加累充(id,RMBNUM,"DL充值",1)
--                                             玩家数据[id].道具:给予道具(id,"恩典钥匙",500)
--                                             print("玩家:", 充值信息[1], "参加皇恩活动", 充值信息[2], "次,准备单车变摩托。(本活动的赞助翻倍。。。)")
--                                             广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y参加皇恩活动:#R" .. 充值信息[2] .. "#Y次,准备单车变摩托。(本活动的赞助翻倍。。。)"), 频道 = "xt"})
--                                             充值信息[4] = "1"
--                                             充值信息列表[i] = table.concat(充值信息, ",")
--                                             end
--                                     end
--                                 end

--                                     -- 检查玩家是否在线，如果在线则将订单号写入 pay.txt 文件
--                                     if 玩家数据[tonumber(充值信息[1])] ~= nil then
--                                         local payFile = io.open(payFilePath, "a")
--                                         if payFile then
--                                             payFile:write(充值信息[5] .. "\n")
--                                             payFile:close()
--                                             --print("订单号已同步至pay文件")
--                                         else
--                                             --print("无法打开 pay.txt 文件")
--                                         end
--                                     end
--                                 end
--                             end
--                         end
--                         --print("条数：", ii)
--                         if 是否有新的充值 == true then
--                             -- 将修改后的充值信息写回文件
--                             local 新内容 = table.concat(充值信息列表, ";")
--                             文件 = io.open(文件路径, "w")
--                             if 文件 then
--                                 文件:write(新内容)
--                                 文件:close()
--                                 --print("充值信息已成功修改并写入文件:", 文件路径)
--                                 是否有新的充值 = false
--                             else
--                                 --print("无法写入文件:", 文件路径)
--                             end
--                         else
--                             --print("当前无新充值！")
--                         end
--                     else
--                         --print("无法打开文件:", 文件路径)
--                     end
--                 end
--             end
--         else
--             print("线程返回", ...)
--         end
--     end
--     self:启动(v)
-- end

-- function 定时器:启动(v)
--     self.线程:启动(v)
--     self.线程:置延迟(v)
-- end

-- function 定时器:发送(...) -- 这里是不定数据, 如果是固定的, 可以参考客户的多线程 纹理
--     数据数量[0] = 数据数量[0] + 1
--     table.insert(线程发送数据, {...})
-- end

-- return 定时器


local ffi = require("ffi")
local lfs = require("lfs")  -- 引入 Lua File System 库
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local 定时时间 = os.time()
local fenzhong = 1
local 定时器 = class()
local 人民币比例 = 100
local 是否有新的充值 = false

-- 定义文件是否存在函数
function 文件是否存在(路径)
    local 文件 = io.open(路径, "r")
    if 文件 then
        文件:close()
        return true
    else
        return false
    end
end

function 定时器:初始化(v, 循环文件)
    self.线程 = require("ggethread")(循环文件)
    self.线程.消息返回 = function(self, ...)
        if ... == "取数量指针" then
            return tonumber(ffi.cast("intptr_t", 数据数量))
        elseif ... == "取数据" then
            return unpack(r)
        elseif ... == "循环更新" then
            local 当前时间 = os.time()
            if (当前时间 - 定时时间) >= 10 then  -- 每10秒触发一次
                定时时间 = 当前时间

                -- 检查并创建支付互交.txt文件
                local 文件路径 = 程序目录 .. [[dlxt\chongzhi\pay\]] .. "zhifu.txt"

                if not 文件是否存在(文件路径) then
                    -- 文件不存在，创建文件
                    local 文件 = io.open(文件路径, "w")
                    if 文件 then
                        文件:close()
                        --print("已创建文件:", 文件路径)
                    else
                        --print("无法创建文件:", 文件路径)
                    end
                else
                    --print("文件已存在:", 文件路径)

                    local 文件 = io.open(文件路径, "r")
                    if 文件 then
                        -- 读取文件内容
                        local 内容 = 文件:read("*a")
                        文件:close()

                        充值信息列表 = 分割文本(内容, ";")
                        --print("单条充值信息:", 充值信息列表)
                        local ii = 0
                        for i = 1, #充值信息列表 do
                            ii = i
                            local 充值信息 = 分割文本(充值信息列表[i], ",")
                            if #充值信息 >= 5 then
                                -- 检查充值信息[5]是否在 pay.txt 文件中
                                local payFilePath = 程序目录 .. [[dlxt\chongzhi\pay\]] .. "pay.txt"
                                local payFileContent = ""
                                if 文件是否存在(payFilePath) then
                                    local payFile = io.open(payFilePath, "r")
                                    if payFile then
                                        payFileContent = payFile:read("*a")
                                        payFile:close()
                                    end
                                end

                                if string.find(payFileContent, 充值信息[5]) then
                                    --print("充值信息[5]已存在于 pay.txt 文件中，跳过处理")
                                else
                                    if 充值信息[4] == "0" then
                                        if 充值信息[3] == "xy1" then
                                            是否有新的充值 = true
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])
                                            local 获得仙玉=20000
                                            if 玩家数据[id] == nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                添加仙玉(id,nil, 获得仙玉, "DL充值")
                                                添加累充(id, RMBNUM, "DL充值",1)
                                                print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了", 获得仙玉, "仙玉")
                                                广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R" .. 获得仙玉 .. "#Y仙玉和大量奖励！！"), 频道 = "xt"})
                                                充值信息[4] = "1"
                                                充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                         elseif 充值信息[3] == "xy2" then
                                            是否有新的充值 = true
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])
                                            local 获得仙玉=150000
                                            if 玩家数据[id] == nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                添加仙玉(id,nil, 获得仙玉, "DL充值")
                                                添加累充(id, RMBNUM, "DL充值",1)
                                                print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了", 获得仙玉, "仙玉")
                                                广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R" .. 获得仙玉 .. "#Y仙玉和大量奖励！！"), 频道 = "xt"})
                                                充值信息[4] = "1"
                                                充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                        elseif 充值信息[3] == "xy3" then
                                            是否有新的充值 = true
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])
                                            local 获得仙玉=500000

                                            if 玩家数据[id] == nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                添加仙玉(id,nil, 获得仙玉, "DL充值")
                                                添加累充(id, RMBNUM, "DL充值",1)
                                                print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了", 获得仙玉, "仙玉")
                                                广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R" .. 获得仙玉 .. "#Y仙玉和大量奖励！！"), 频道 = "xt"})
                                                充值信息[4] = "1"
                                                充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                        elseif 充值信息[3] == "cj12" then
                                            是否有新的充值 = true
                                            --print("比例:", 充值信息[2]*人民币比例)
                                            --print("充值信息:", 充值信息[1])
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])

                                            if 玩家数据[id]==nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                --do
                                            --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
                                            添加累充(id,RMBNUM,"DL充值",1)
                                            玩家数据[id].道具:给予道具(id,"奖池抽奖",12)
                                            print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了十二个奖池抽奖")
                                            广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R十二#Y个奖池抽奖！！"), 频道 = "xt"})

                                            充值信息[4] = "1"
                                            充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                            -- 奖池抽奖处理逻辑
                                        elseif 充值信息[3] == "cj70" then
                                            -- 奖池抽奖处理逻辑
                                            是否有新的充值 = true
                                            --print("比例:", 充值信息[2]*人民币比例)
                                            --print("充值信息:", 充值信息[1])
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])

                                            if 玩家数据[id]==nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                --do
                                            --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
                                            添加累充(id,RMBNUM,"DL充值",1)
                                            玩家数据[id].道具:给予道具(id,"奖池抽奖",70)
                                            print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了七十个奖池抽奖")
                                            广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R七十#Y个奖池抽奖！！"), 频道 = "xt"})

                                            充值信息[4] = "1"
                                            充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                        elseif 充值信息[3] == "cj150" then
                                            -- 奖池抽奖处理逻辑
                                            是否有新的充值 = true
                                            --print("比例:", 充值信息[2]*人民币比例)
                                            --print("充值信息:", 充值信息[1])
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])

                                            if 玩家数据[id]==nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                --do
                                            --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
                                            添加累充(id,RMBNUM,"DL充值",1)
                                            玩家数据[id].道具:给予道具(id,"奖池抽奖",150)
                                            print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了一百五个奖池抽奖")
                                            广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R一百五#Y个奖池抽奖！！"), 频道 = "xt"})

                                            充值信息[4] = "1"
                                            充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                        elseif 充值信息[3] == "dj1" then
                                            -- 奖池抽奖处理逻辑
                                            是否有新的充值 = true
                                            --print("比例:", 充值信息[2]*人民币比例)
                                            --print("充值信息:", 充值信息[1])
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])

                                            if 玩家数据[id]==nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                --do
                                            --添加仙玉(id,RMBNUM*人民币比例, "DL充值")
                                            添加累充(id,RMBNUM,"DL充值",1)
                                            玩家数据[id].道具:给予道具(id,"五福鲲鹏礼包",1,nil,"不存共享")
                                            print("玩家:", 充值信息[1], "赞助了", 充值信息[2], "元,获得了一个五福鲲鹏礼包")
                                            广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y赞助了:#R" .. 充值信息[2] .. "#Y元,获得了#R一#Y个五福鲲鹏礼包！！"), 频道 = "xt"})

                                            充值信息[4] = "1"
                                            充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                        elseif 充值信息[3] == "hyk" then
                                                是否有新的充值 = true
                                                local id = tonumber(充值信息[1])
                                                local RMBNUM = tonumber(充值信息[2])
                                                   if  玩家数据[id].角色.月卡 == nil then
                                                        玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+60*60*24*365}
                                                    elseif os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 then
                                                        玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+60*60*24*365}
                                                  else
                                                        玩家数据[id].角色.月卡 = {生效=true,到期时间=玩家数据[id].角色.月卡.到期时间+60*60*24*365}
                                                  end
                                                  local 经验=30000000
                                                  local 银子=100000000
                                                  玩家数据[id].角色:添加经验(经验,"月卡",1)
                                                  玩家数据[id].角色:添加银子(银子,"月卡",1)
                                                  玩家数据[id].道具:给予道具(id,"奖池抽奖",5,nil,"赞助")
                                                  玩家数据[id].道具:给予道具(id,"修炼果",20,nil,"赞助")
                                                  玩家数据[id].道具:给予道具(id,"神兜兜",20,nil,"赞助")
                                                  玩家数据[id].道具:给予道具(id,"扫荡卡",30,nil,"赞助")
                                                  玩家数据[id].道具:给予道具(id,"九转金丹礼包",5,nil,"赞助")
                                                  玩家数据[id].道具:给予道具(id,"自动抓鬼年卡",1,nil,"赞助")
                                                  发送数据(玩家数据[id].连接id,6573.1,{月卡=玩家数据[id].角色.月卡})
                                                  添加累充(id,RMBNUM,"DL充值",1)
                                                  常规提示(id,"#Y激活会员成功,会员到期日前,每日可领取奖励物品！")
                                                  广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y激活会员成功,会员到期日前,每日可领取奖励物品！"), 频道 = "xt"})

                                                   充值信息[4] = "1"
                                                充值信息列表[i] = table.concat(充值信息, ",")

                                        elseif 充值信息[3] == "he10" then--恩典钥匙10把
                                            -- 奖池抽奖处理逻辑
                                            是否有新的充值 = true
                                            --print("比例:", 充值信息[2]*人民币比例)
                                            --print("充值信息:", 充值信息[1])
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])

                                            if 玩家数据[id]==nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                --do
                                            添加仙玉(id,RMBNUM*人民币比例*2, "DL充值")
                                            添加累充(id,RMBNUM,"DL充值",1)
                                            玩家数据[id].道具:给予道具(id,"恩典钥匙",10)
                                            print("玩家:", 充值信息[1], "参加皇恩活动", 充值信息[2], "次,准备单车变摩托。(本活动的赞助翻倍。。。)")
                                            广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y参加皇恩活动:#R" .. 充值信息[2] .. "#Y次,准备单车变摩托。(本活动的赞助翻倍。。。)"), 频道 = "xt"})
                                            充值信息[4] = "1"
                                            充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                        elseif 充值信息[3] == "he100" then--恩典钥匙100把
                                            -- 奖池抽奖处理逻辑
                                            是否有新的充值 = true
                                            --print("比例:", 充值信息[2]*人民币比例)
                                            --print("充值信息:", 充值信息[1])
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])

                                            if 玩家数据[id]==nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                --do
                                            添加仙玉(id,RMBNUM*人民币比例*2, "DL充值")
                                            添加累充(id,RMBNUM,"DL充值",1)
                                            玩家数据[id].道具:给予道具(id,"恩典钥匙",100)
                                            print("玩家:", 充值信息[1], "参加皇恩活动", 充值信息[2], "次,准备单车变摩托。(本活动的赞助翻倍。。。)")
                                            广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y参加皇恩活动:#R" .. 充值信息[2] .. "#Y次,准备单车变摩托。(本活动的赞助翻倍。。。)"), 频道 = "xt"})
                                            充值信息[4] = "1"
                                            充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                        elseif 充值信息[3] == "he500" then--恩典钥匙500把
                                            -- 奖池抽奖处理逻辑
                                            是否有新的充值 = true
                                            --print("比例:", 充值信息[2]*人民币比例)
                                            --print("充值信息:", 充值信息[1])
                                            local id = tonumber(充值信息[1])
                                            local RMBNUM = tonumber(充值信息[2])

                                            if 玩家数据[id]==nil then
                                                --print("玩家不在线:", 充值信息[1])
                                            else
                                                --do
                                            添加仙玉(id,RMBNUM*人民币比例*2, "DL充值")
                                            添加累充(id,RMBNUM,"DL充值",1)
                                            玩家数据[id].道具:给予道具(id,"恩典钥匙",500)
                                            print("玩家:", 充值信息[1], "参加皇恩活动", 充值信息[2], "次,准备单车变摩托。(本活动的赞助翻倍。。。)")
                                            广播消息({内容 = format("#Y神豪玩家#G" .. 充值信息[1] .. "#Y参加皇恩活动:#R" .. 充值信息[2] .. "#Y次,准备单车变摩托。(本活动的赞助翻倍。。。)"), 频道 = "xt"})
                                            充值信息[4] = "1"
                                            充值信息列表[i] = table.concat(充值信息, ",")
                                            end
                                    end
                                end

                                    -- 检查玩家是否在线，如果在线则将订单号写入 pay.txt 文件
                                    if 玩家数据[tonumber(充值信息[1])] ~= nil then
                                        local payFile = io.open(payFilePath, "a")
                                        if payFile then
                                            payFile:write(充值信息[5] .. "\n")
                                            payFile:close()
                                            --print("订单号已同步至pay文件")
                                        else
                                            --print("无法打开 pay.txt 文件")
                                        end
                                    end
                                end
                            end
                        end
                        --print("条数：", ii)
                        if 是否有新的充值 == true then
                            -- 将修改后的充值信息写回文件
                            local 新内容 = table.concat(充值信息列表, ";")
                            文件 = io.open(文件路径, "w")
                            if 文件 then
                                文件:write(新内容)
                                文件:close()
                                --print("充值信息已成功修改并写入文件:", 文件路径)
                                是否有新的充值 = false
                            else
                                --print("无法写入文件:", 文件路径)
                            end
                        else
                            --print("当前无新充值！")
                        end
                    else
                        --print("无法打开文件:", 文件路径)
                    end
                end
            end
        else
            print("线程返回", ...)
        end
    end
    self:启动(v)
end

function 定时器:启动(v)
    self.线程:启动(v)
    self.线程:置延迟(v)
end

function 定时器:发送(...) -- 这里是不定数据, 如果是固定的, 可以参考客户的多线程 纹理
    数据数量[0] = 数据数量[0] + 1
    table.insert(线程发送数据, {...})
end

return 定时器