-- @Author: baidwwy
-- @Date:   2023-11-28 09:34:45
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-09-02 18:48:07
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:45:47
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type

__NPCdh111[2514]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1 or 编号==2 or 编号==3 or 编号==4  then
		wb[1] = "尊贵的会员，你想对我做什么！#R(每天限30次)"
                         local   xx = {"我要挑战你","我点错了"}
    	            return {"进阶超级神柚","超级神柚",wb[取随机数(1,#wb)],xx}
	end
	return
end
__NPCdh222[2514]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="超级神柚" then
	      if 事件=="我要挑战你" then
	      	if __副本每日.会员地图[数字id]==nil  then--"#Y
                		__副本每日.会员地图[数字id]={神柚=0}
                		end
	       	if __副本每日.会员地图[数字id].神柚<30 then
  	                    战斗准备类:创建战斗(数字id,199903,0)
  	                  else
                         添加最后对话(数字id,"每天只能挑战30次。")
                   end
	end
	end
end

function 胜利MOB_199903(胜利id,战斗数据,id组)
for i=1,#id组 do
      local id = id组[i]
      local 等级 = 玩家数据[id].角色.等级
      local 经验
      local 银子
      local 储备
      local 等级=玩家数据[id].角色.等级
    local 经验=等级*取随机数(1000,1505)
    local 银子=等级*取随机数(900*3,1200*3)+4000
	if __副本每日.会员地图[id]==nil  then--"#Y
	     __副本每日.会员地图[id]={神柚=0}
	end
         __副本每日.会员地图[id].神柚=  __副本每日.会员地图[id].神柚+1
          if __副本每日.会员地图[id].神柚>30 then
    	常规提示(id,"今日挑战已达上限")
		return
	end
        玩家数据[id].角色:添加经验(经验*HDPZ["会员地图"].经验,"会员地图",1)
        玩家数据[id].角色:添加银子(qz(银子*HDPZ["会员地图"].银子),"会员地图",1)
        添加活跃(id,1)
        if 取随机数()<=HDPZ["会员地图"].爆率 then
            local 链接={提示=format("#S(会员地图)#R/%s#Y/#Y/打败了超级神柚，#Y/表现卓越，额外获得了#G",玩家数据[id].角色.名称),频道="xt",结尾="#Y。"}
            local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["会员地图"].ITEM),"会员地图")
            if 数量== 9999 then --环
                玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
            else
                玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
            end
        end
    end
    	战斗数据.连续战斗 = 199903
end