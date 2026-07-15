-- @Author: baidwwy
-- @Date:   2024-11-06 18:18:58
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-12-18 15:45:35
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 12:52:26
-- @最后修改来自: baidwwy
-- @Last Modified time: 2024-11-02 21:29:24
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1209]=function (ID,编号,页数,已经在任务中,数字id)
   local wb = {}
   local xx = {}
   if 编号 == 3 then
            if 武神山数据==nil then
                  武神山数据={}
                  写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
            end
            if 武神山数据. 全服祈神值==nil then
                  武神山数据. 全服祈神值=0
                  写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
            end
            wb[1] = "尔等蝼蚁妄图封印我简直是痴心妄想\n#G".."全服祈神进度：#R"..武神山数据.全服祈神值.."#W"
             xx = {"我要挑战蚩尤降临","不敢惹不敢惹"}
            return{"蚩尤","蚩尤元神",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 4 then
            wb[1] = "少侠来此所为何事？"
            xx = {"奉上上古之符","我来帮战神创造储备箱（组队任务）","相关帮助","随便看看"}
            return{"巫师","巫师",wb[取随机数(1,#wb)],xx}
            end
   return
end

__NPCdh222[1209]=function  (id,数字id,序号,内容)
    local 事件=内容[1]
    local 名称=内容[3]
     if 名称=="蚩尤元神" then
           if 事件 == "我要挑战蚩尤降临" then
                 if 武神山数据==nil then
                      武神山数据={}
                      写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
                 end
                 if 武神山数据.全服祈神值==nil then
                      武神山数据.全服祈神值=0
                      写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
                end
                local 祈神值 = 武神山数据.全服祈神值+0
                if  祈神值 ~=nil and 祈神值 < 蚩尤祈福值  then
                      添加最后对话(数字id,"你还没有达到挑战我的资格，想要挑战我去做任务刷祈神值吧！")
                      return
                elseif 玩家数据[数字id].队伍 == 0 then
                      常规提示(数字id,"#Y/请组队进入战斗！")
                      return
                else
                        战斗准备类:创建战斗(数字id,155720)
                end
           end
    elseif 名称=="巫师" then
     if 武神山数据==nil then
         武神山数据={}
         写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
     end
     if 武神山数据.全服祈神值==nil then
         武神山数据.全服祈神值=0
         写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
     end
     local 祈神值 = 武神山数据.全服祈神值+0
     if 事件 == "奉上上古之符" then
         if 祈神值<蚩尤祈福值 then
             -- 玩家数据[数字id].给予道具={类型=1,id=0,事件="上交灵符"}
             玩家数据[数字id].给予数据={类型=1,id=0,事件="上交灵符"}
             发送数据(玩家数据[数字id].连接id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称=名称,类型="NPC",等级="无"})
         else
             添加最后对话(数字id,"蚩尤已经降临，蚩尤降临期间无法接取本任务")
         end
     elseif 事件 == "我来帮战神创造储备箱（组队任务）" then
         if 祈神值<蚩尤祈福值 then
             if 玩家数据[数字id].队伍 == 0 then
                 常规提示(数字id,"#Y/请组队再来找我！")
                 return

             else
                 -- if 取活动限制(数字id,'战神任务组队')>=20 then  --关闭限制
                 --     发送数据(玩家数据[数字id].连接id, 7, "#y/活动已上限！")
                 --     return
                 -- end
                 local 队伍id=玩家数据[数字id].队伍
                 local 通过 = false
                 for n=1,#队伍数据[队伍id].成员数据 do
                     local 临时id=队伍数据[队伍id].成员数据[n]
                     local 队长任务id = 玩家数据[数字id].角色:取任务(8931)
                     if 玩家数据[数字id].队长==false  then
                         常规提示(id,"#Y/该任务必须由队长领取")
                         return
                     end
                     if 玩家数据[临时id].角色:取任务(8931)~=0 then
                         local 队员任务id = 玩家数据[临时id].角色:取任务(8931)
                         if 队员任务id~=队长任务id then
                             通过 = false
                             常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."已经接取过此类任务")
                             return
                         else
                             通过 = true
                         end
                     else
                         通过 = true
                     end
                 end
                 if 通过 then
                     设置任务8931(数字id)
                     return
                 end
             end
         else
             添加最后对话(数字id,"蚩尤已经降临，蚩尤降临期间无法接取本任务")
         end
     elseif 事件 == "相关帮助" then
         添加最后对话(数字id,"#Y上古灵符#W：上交上古灵符增加全服祈神值\n#Y战神储备箱#W：5人组队完成的环任务（#R完成后增加全服祈神值#W）\n\n#G祈神值足够时蚩尤降临挑战开放")
     end
 end
end
