-- @Author: baidwwy
-- @Date:   2023-12-02 14:12:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-01-07 13:40:00
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1526]=function(ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		local 任务id = 玩家数据[数字id].角色:取任务(307)
		if 玩家数据[数字id].角色:取任务(307)~=0 then
			if 任务数据[任务id].分类==12 then
	    	    wb[1] = "马儿？什么马儿，我没看见过什么马儿啊。"
	    	    xx = {"看来不给你点颜色看看是不会交代的","路过"}
	    	    return {"男人_兰虎","周猎户",wb[1],xx}
			end
		end
		wb[1] = "最近都打不到什么猎物，日子还怎么过啊，老婆说再这样下去，就得考虑让我进京城打工了。"
		wb[2] = "城外的野兽倒不少，可都是凶猛无比，真是恐怖啊！"
		wb[3] = "如今外出打猎要带一包袱的草药，都搞不清是谁打谁了。"
		wb[4] = "进山不怕虎伤人，下海不怕龙卷身。没有胆量是做不得猎人的。"
		wb[5] = "自从建邺城开了新城门，经由我家门口去东海确实方便了许多。"
		return{"男人_兰虎","周猎户",wb[取随机数(1,#wb)]}
	end
	return
end

__NPCdh222[1526]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="周猎户" then
		if 事件=="看来不给你点颜色看看是不会交代的" then
          	local 任务id=玩家数据[数字id].角色:取任务(307)
          	战斗准备类:创建战斗(数字id,191003,任务id)
      	end
	end
end