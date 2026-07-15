-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-02-01 22:52:07
-- @最后修改来自: baidwwy
-- @Last Modified time: 2026-04-26 13:39:32
function 设置任务15(id) --回梦丹（单人）
	local 任务id=id.."_15_"..os.time()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=7200,
		销毁=true,
		是存档=true,
		玩家id=id,
		队伍组={},
		类型=15
	}
	玩家数据[id].角色:添加任务(任务id)
end

function 设置队伍回梦丹(id) --回梦丹（全队）
	设置任务15(id)
	常规提示(id,"#Y/你使用了回梦丹")
	local 队伍id = 玩家数据[id].队伍
	if 队伍id ~= 0 and 队伍数据[队伍id] then
		for n = 1, #队伍数据[队伍id].成员数据 do
			local 队员id = 队伍数据[队伍id].成员数据[n]
			if 队员id ~= id and 玩家数据[队员id] and 玩家数据[队员id].角色:取任务(15) == 0 then
				设置任务15(队员id)
				常规提示(队员id,"#Y/你的队友"..玩家数据[id].角色.名称.."使用了回梦丹，你也获得了经验加成效果！")
			end
		end
	end
end

function 延长队伍回梦丹(id) --延长回梦丹（全队）
	local 队伍id = 玩家数据[id].队伍
	local 任务id = 玩家数据[id].角色:取任务(15)
	if 任务id ~= 0 and 任务数据[任务id] and 任务数据[任务id].结束 then
		任务数据[任务id].结束 = 任务数据[任务id].结束 + 7200
		玩家数据[id].角色:刷新任务跟踪()
	else
		设置队伍回梦丹(id)
		return
	end
	-- 同步延长队友
	if 队伍id ~= 0 and 队伍数据[队伍id] then
		for n = 1, #队伍数据[队伍id].成员数据 do
			local 队员id = 队伍数据[队伍id].成员数据[n]
			if 队员id ~= id and 玩家数据[队员id] then
				local 队员任务id = 玩家数据[队员id].角色:取任务(15)
				if 队员任务id ~= 0 and 任务数据[队员任务id] and 任务数据[队员任务id].结束 then
					任务数据[队员任务id].结束 = 任务数据[队员任务id].结束 + 7200
					玩家数据[队员id].角色:刷新任务跟踪()
				else
					设置任务15(队员id)
				end
			end
		end
	end
end

function rwgx15(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 then -- 任务时间到期
		local 使用玩家id = 任务数据[任务id].玩家id
		if 玩家数据[使用玩家id]~=nil then
			玩家数据[使用玩家id].角色:取消任务(任务id)
			发送数据(玩家数据[使用玩家id].连接id,39)
			-- 通知全队队员回梦丹到期
			local 队伍id = 玩家数据[使用玩家id].队伍
			if 队伍id ~= 0 and 队伍数据[队伍id] then
				for n = 1, #队伍数据[队伍id].成员数据 do
					local 队员id = 队伍数据[队伍id].成员数据[n]
					if 玩家数据[队员id] and 队员id ~= 使用玩家id then
						常规提示(队员id,"#Y/你的队友"..玩家数据[使用玩家id].角色.名称.."的回梦丹效果到期了！")
					end
				end
			end
			常规提示(使用玩家id,"你的回梦丹效果到期了！")
		end
		任务数据[任务id]=nil
	end
end

function 任务说明15(玩家id,任务id)
	return {"回梦丹","#W你的回梦丹效果还可持续#G/"..取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))).."#W/分钟。"}
end
