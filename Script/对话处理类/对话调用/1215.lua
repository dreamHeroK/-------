-- @Author: baidwwy
-- @Date:   2024-01-07 12:12:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-01-07 13:29:35
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:56:08
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1215]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
		wb[1] = "看什么看，再看小心我吃了你。"
  		xx = {}
  		local 任务id = 玩家数据[数字id].角色:取任务(307)
  		if 玩家数据[数字id].角色:取任务(307)~=0 then
    		if 任务数据[任务id].分类==8 then
        	    wb[1] = "好不容易抓到只天马，想要拿走，没门！"
        	    xx = {"妖孽，速速放了天马","路过"}
    		end
    	end
  		return {"炎魔神","蜃妖元神",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1215]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
	if 名称=="蜃妖元神" then
      	if 事件=="妖孽，速速放了天马" then
          	local 任务id=玩家数据[数字id].角色:取任务(307)
          	战斗准备类:创建战斗(数字id,191002,任务id)
      	end
  end
end