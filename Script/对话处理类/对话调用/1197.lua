local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1197]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		local dh="请等待比赛开始(会有提示)"
		local xx = {"好的","我需要买点药品"}
		if 比武大会数据.进程 == 3 then
			 dh="现在可以正式比武了，要现在传送去比武吗？"
			 xx = {"开打开打","我需要买点药品","先让别人战一会"}
		end
    wb[1] = dh
		return{"男人_将军","比武大会传送人",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1197]=function (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="比武大会传送人" then
        if 事件=="开打开打" then
        	比武大会:比武大会对话入场事件(数字id)
        elseif 事件=="我需要买点药品" then
        	玩家数据[数字id].商品列表=商店处理类.商品列表[52]
            发送数据(id,9,{商品=商店处理类.商品列表[52],银子=玩家数据[数字id].角色.银子})
        end
    end
end

----------------------
__NPCdh111[5136]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		local dh="瞧一瞧看一看喽，这有梦幻最贵最黑的药"
		local xx = {"我需要买点药品"}
                         wb[1] = dh
		return{"男人_将军","比武大会传送人",wb[sj(1,#wb)],xx}
	end
	return
end
__NPCdh222[5136]=function (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
        if 事件=="我需要买点药品" then
        	玩家数据[数字id].商品列表=商店处理类.商品列表[53]
            发送数据(id,9,{商品=商店处理类.商品列表[53],银子=玩家数据[数字id].角色.银子})
        end
end
----------------------
__NPCdh111[5137]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		local dh="瞧一瞧看一看喽，这有梦幻最贵最黑的药"
		local xx = {"我需要买点药品"}
                         wb[1] = dh
		return{"男人_将军","比武大会传送人",wb[sj(1,#wb)],xx}
	end
	return
end
__NPCdh222[5137]=function (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
        if 事件=="我需要买点药品" then
        	玩家数据[数字id].商品列表=商店处理类.商品列表[53]
            发送数据(id,9,{商品=商店处理类.商品列表[53],银子=玩家数据[数字id].角色.银子})
        end
end
----------------------
__NPCdh111[5138]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		local dh="瞧一瞧看一看喽，这有梦幻最贵最黑的药"
		local xx = {"我需要买点药品"}
                         wb[1] = dh
		return{"男人_将军","比武大会传送人",wb[sj(1,#wb)],xx}
	end
	return
end
__NPCdh222[5138]=function (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
        if 事件=="我需要买点药品" then
        	玩家数据[数字id].商品列表=商店处理类.商品列表[53]
            发送数据(id,9,{商品=商店处理类.商品列表[53],银子=玩家数据[数字id].角色.银子})
        end
end
----------------------
__NPCdh111[5139]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		local dh="瞧一瞧看一看喽，这有梦幻最贵最黑的药"
		local xx = {"我需要买点药品"}
                         wb[1] = dh
		return{"男人_将军","比武大会传送人",wb[sj(1,#wb)],xx}
	end
	return
end
__NPCdh222[5139]=function (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
        if 事件=="我需要买点药品" then
        	玩家数据[数字id].商品列表=商店处理类.商品列表[53]
          发送数据(id,9,{商品=商店处理类.商品列表[53],银子=玩家数据[数字id].角色.银子})
        end
end