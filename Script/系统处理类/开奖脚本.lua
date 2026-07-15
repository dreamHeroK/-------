local 开奖系统 = class()
--定义几个全局变量
local 参与表 = {}
local 参与ID = {}
local 参剩={}
local 领取物品 = {}
local 充值信息列表
local 参与次数 = 4000
local 报名信息路径 = 程序目录..[[sql\]].."报名信息.txt"
local 记录表 = 程序目录..[[sql\]].."抽奖历史记录.txt"

function 开奖系统:数据处理(id,序号,内容)
    local 序号 = 内容.序号1
    if 序号 == 322699 then
        local 类型=内容.类型
        if 类型 and 全局礼包数据[类型] then
            for i = 1, #全局礼包数据.中奖界面 do
                for n = 1, 10 do
                    if 全局礼包数据.中奖界面[i]["物品"..n] ~= nil then
                        领取物品[#领取物品 + 1] = table.copy(全局礼包数据.中奖界面[i]["物品"..n])
                    end
                end
            end
            self:加载检查参加信息()
            发送数据(玩家数据[id].连接id,3524.2,{类型=内容.类型,道具=领取物品,参与数=参剩.参与,剩余数=参剩.剩余})
        else
            常规提示(id,"#Y/该类功能未开放")
        end
    end
end


--读取参加信息
function 开奖系统:加载检查参加信息()
    --获取参加次数
    --读取文件
    local 文件 = io.open(报名信息路径, "r")
    if 文件 then
        -- 读取文件内容
      local 内容 = 文件:read("*a")
      文件:close()
      充值信息列表 = 分割文本(内容, ";")
      local ii = 0
      for i = 1, #充值信息列表 do
        ii=i-1
      end
      local 剩余 = 参与次数-ii
      参剩.参与=ii
      参剩.剩余=剩余
    end
    return 参剩
end
--参加表随机一名中奖，其他给予安慰奖
function 开奖系统:开奖()

    self:加载检查参加信息()
    if 参剩.参与>= 参与次数 then
    --判断参与次是否达到
    local 中奖者 = 取随机数(1,#充值信息列表)
    local 中奖者id=充值信息列表[中奖者]
    for id, entries in pairs(充值信息列表) do
        --找到中奖者序号 循环中的ID对比
        if id > 1 then
            if id == 中奖者 then
                local 中奖了=充值信息列表[id]+0
                    self:中奖信息(中奖了)
                    礼包奖励类:领取定义礼包(中奖了, 领取物品)
                    发送公告("玩家#G"..玩家数据[中奖了].角色.名称.."#奇迹般的得到此次恩典大量道具“#R特殊魔兽要诀#”")
                    广播消息({内容=format("玩家#G"..玩家数据[中奖了].角色.名称.."#奇迹般的得到此次恩典大量道具“#R特殊魔兽要诀#”"),频道="xt"})
                    self:清空报名信息()
                    初始期数=初始期数+1
                    f函数.写配置(程序目录.."配置文件.ini","主要配置","id",初始期数)
            end
        end
    end
else
       return
end
    -- self:清空报名信息()
end

function 开奖系统:中奖信息(id)
    local winFile = io.open(记录表, "a")
    if winFile then
        winFile:write("期数: " .. 初始期数 .. ", 中奖者ID: " .. id .. "\n")
        winFile:close()
    else
        error("无法打开中奖记录文件")
    end
end

function 开奖系统:清空报名信息()
    local file = io.open(报名信息路径, "w")
    if file then
     file:write("") -- 写入空字符串以清空文件
     file:close()
     print("文件已清空")
    else
     error("无法打开文件: " .. 报名信息路径)
    end
end


    




return 开奖系统