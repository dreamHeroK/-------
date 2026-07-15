-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:56:07
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-11-28 14:42:12
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[2574]=function (ID,编号,页数,已经在任务中,数字id)
    local  镇妖关积分=玩家数据[数字id].角色.镇妖关积分
    local wb = {}
    local xx = {}
    if 编号 == 1 then
        wb[1] = "我有一些事情需要人帮忙,你愿意帮助我吗?"
        local xx={"好啊,我正闲着呢","镇妖积分消费","我只是路过"}
        return{"怒蛟","怒蛟",wb[取随机数(1,#wb)],xx}
    end
    return
end

__NPCdh222[2574 ]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
  local 名称=内容[3]
    if 名称 == "怒蛟" then --BOSS
        if 事件=="好啊,我正闲着呢" then
            if   玩家数据[数字id].角色.镇妖关分类== nil  then
                玩家数据[数字id].角色.镇妖关分类=1
            end
            if 玩家数据[数字id].角色.镇妖关积分A < 1 then   玩家数据[数字id].角色:添加镇妖关积分A(1,"镇妖关",1) end
            if 玩家数据[数字id].角色.镇妖关积分B < 1 then   玩家数据[数字id].角色:添加镇妖关积分B(1,"镇妖关",1) end
            if 玩家数据[数字id].角色.镇妖关积分C < 1 then   玩家数据[数字id].角色:添加镇妖关积分C(1,"镇妖关",1) end
            if 玩家数据[数字id].角色.镇妖关积分D < 1 then   玩家数据[数字id].角色:添加镇妖关积分D(1,"镇妖关",1) end
            if 玩家数据[数字id].角色.镇妖关积分E < 1 then   玩家数据[数字id].角色:添加镇妖关积分E(1,"镇妖关",1) end
            if 玩家数据[数字id].角色.镇妖关积分F < 1 then   玩家数据[数字id].角色:添加镇妖关积分F(1,"镇妖关",1) end
            发送数据(id,420,{
                镇妖关积分=玩家数据[数字id].角色.镇妖关积分,
                镇妖关积分A=玩家数据[数字id].角色.镇妖关积分A,
                镇妖关积分B=玩家数据[数字id].角色.镇妖关积分B,
                镇妖关积分C=玩家数据[数字id].角色.镇妖关积分C,
                镇妖关积分D=玩家数据[数字id].角色.镇妖关积分D,
                镇妖关积分E=玩家数据[数字id].角色.镇妖关积分E,
                镇妖关积分F=玩家数据[数字id].角色.镇妖关积分F,
                镇妖关分类=玩家数据[数字id].角色.镇妖关分类,
            })
        elseif 事件=="镇妖积分消费" then
            玩家数据[数字id].商品列表=商店处理类.商品列表[64]
            发送数据(玩家数据[数字id].连接id, 9, {商品 = 商店处理类.商品列表[64], 银子 = 玩家数据[数字id].角色.镇妖关积分, 类型 = "镇妖关"})

        end
    end
end