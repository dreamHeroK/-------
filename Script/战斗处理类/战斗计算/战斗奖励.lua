-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:41
-- @Last Modified by:   tangguo
-- @Last Modified time: 2026-05-26 21:09:37

local 战斗奖励 = class()
local jhf = string.format
local random = math.random
local floor=math.floor
local sj = 取随机数
function 战斗奖励:初始化()
end



function 战斗奖励:奖励事件(id组,RWID,类型,战斗数据)
	local 奖励数据 = 战斗物品奖励[tostring(类型)]
	if 奖励数据 then
		local 基础经验 = tonumber(奖励数据.初始经验) or 0
		local 基础金钱 = tonumber(奖励数据.初始银子) or 0
		local 基础储备 = tonumber(奖励数据.初始储备) or 0
		local 基础仙玉 = tonumber(奖励数据.初始仙玉) or 0
		local 基础点卡 = tonumber(奖励数据.初始点卡) or 0
		local 基础活跃 = tonumber(奖励数据.初始活跃) or 0
		local 基础限制 = tonumber(奖励数据.限制次数) or 0

		local 天罡积分 = tonumber(奖励数据.天罡积分) or 0
		local 地煞积分 = tonumber(奖励数据.地煞积分) or 0
		local 神器积分 = tonumber(奖励数据.神器积分) or 0
		local 基础帮贡 = tonumber(奖励数据.帮贡) or 0
		local 基础官职点 = tonumber(奖励数据.官职点) or 0
		local 基础副本积分 = tonumber(奖励数据.副本积分) or 0
		local 保卫战积分 = tonumber(奖励数据.保卫战积分) or 0
		local 等级影响 = tonumber(奖励数据.等级影响) or 1
		local 次数影响 = tonumber(奖励数据.次数影响)
		local 任务等级 = tonumber(奖励数据.任务等级) or 玩家数据[id组[1]].角色.等级
		local 最大奖励 = tonumber(奖励数据.最大奖励个数) or 1
		local 爆率上限 = tonumber(奖励数据.爆率) or 1000
		local 是否广播 = tonumber(奖励数据.是否广播) == 1
		local 广播内容 = 奖励数据.广播内容
		local 物品奖励 = {}
		for n=1,15 do
		    if 奖励数据["物品"..n] then
		    	local mc = 奖励数据["物品"..n].名称
		    	local sl = tonumber(奖励数据["物品"..n].数量)
		    	local qz = tonumber(奖励数据["物品"..n].权重) or 0
		    	if #物品奖励 >= 1 then
		    		qz = qz + 物品奖励[#物品奖励][2]
		    	end
		    	local zy = 奖励数据["物品"..n].专用
		    	local ew = 奖励数据["物品"..n].额外参数
		    	if ItemData[mc] or mc == "元宵" or mc == "环装" or mc == "灵饰书铁" or mc == "装备书铁" then
		    		物品奖励[#物品奖励+1] = {mc,qz,sl,zy,取随机数(1,10000),ew}
		    		-- table.print(物品奖励)
		    	end
		    end
		end
		for i,v in ipairs(id组) do
			local id = v
			local dj = 玩家数据[id].角色.等级
			local 次数
			if 次数影响 and 次数影响 ~= 0 then
				if 类型==100008 then --抓鬼
					次数 = 玩家数据[id].角色.捉鬼数据.次数
				elseif 类型==101000 then --鬼王
					次数 = 玩家数据[id].角色.鬼王数据.次数
				elseif 类型==140000 then --雁塔地宫
					次数 = ((雁塔地宫.数据[id] or {}).层数) or 0
				-- elseif 类型==111108 then --雁塔地宫
				-- 	次数 = ((通天塔数据[id] or {}).层数) or 0
				end
			end
			local 等级差 = dj - 任务等级
			if 等级差 <= 1 then 等级差 = 1 end
			local 系数 = 等级差*等级影响
			local 系数经验 = 基础经验*系数
			local 次数经验 = 0
			local 次数系数 = 1
			if 次数 then
				次数经验 = 基础经验*次数*次数影响
			end
			local jy = floor(基础经验)+系数经验+次数经验
			if jy > 0 then
				玩家数据[id].角色:添加经验(jy,类型,1)
				if 玩家数据[id].角色.参战信息~=nil then
			      玩家数据[id].召唤兽:获得经验(玩家数据[id].角色.参战宝宝.认证码,math.floor(jy*0.8),id,类型)
			    end
			end
			local 系数金钱 = 基础金钱*系数
			local 次数金钱 = 0
			local 次数系数 = 1
			if 次数 then
				次数金钱 = 基础金钱*次数*次数影响
			end
			local jq = floor(基础金钱)+系数金钱+次数金钱
			if jq > 0 then
				玩家数据[id].角色:添加银子(jq,类型,1)
			end
			local 系数储备 = 基础储备*系数
			local 次数储备 = 0
			local 次数系数 = 1
			if 次数 then
				次数储备 = 基础储备*次数*次数影响
			end
			local jq = floor(基础储备)+系数储备+次数储备
			if jq > 0 then
				玩家数据[id].角色:添加储备(jq,类型,1)
			end
			if 基础仙玉 > 0 then
				local xy = floor(基础仙玉)
				添加仙玉(id,玩家数据[id].账号, xy, 类型)
			end
			if 基础点卡 > 0 then
				local dk = floor(基础点卡)
				添加点卡(id,玩家数据[id].账号, dk, 类型)
			end
			if 基础活跃 > 0 then
				local hy = floor(基础活跃)
				添加活跃(id,hy)

			end

			-- if 基础限制 > 0 then
			-- 	local 活动

			-- 	if 类型==155559 then
			-- 		活动="下凡的灵猴"
			-- 	elseif 类型==155560 then
			-- 		活动="三界财神爷"
			-- 	elseif 类型==155562 then
			-- 		活动="远古妖魔头目"
			-- 	elseif 类型==155563 then
			-- 		活动="远古妖魔领主"
			-- 	elseif 类型==155564 then
			-- 		活动="远古妖魔尊主"
			-- 	elseif 类型==160001 then
			-- 		活动="夏日炎炎"
			-- 	elseif 类型==160002 then
			-- 		活动="魂殿使者"
			-- 	elseif 类型==160003 then
			-- 		活动="魂殿殿主"
			-- 	elseif 类型==160016 then
			-- 		活动="琴声悠悠"
			-- 	elseif 类型==160017 then
			-- 		活动="新春快乐"
			-- 	elseif 类型==160019 then
			-- 		活动="龙神"
			-- 	elseif 类型==160020 then
			-- 		活动="仙气十足"
			-- 	elseif 类型==160021 then
			-- 		活动="武神坛服战8强"
			-- 	elseif 类型==160022 then
			-- 		活动="武神坛服战4强"
			-- 	elseif 类型==160023 then
			-- 		活动="武神坛服战季军"
			-- 	elseif 类型==160024 then
			-- 		活动="武神坛服战亚军"
			-- 	elseif 类型==160025 then
			-- 		活动="武神坛服战冠军"
			-- 	elseif 类型==160026 then
			-- 		活动="客服小二"
			-- 	end
			-- 	添加完成次数(id,活动)  -----限制刷怪

			-- end

			if 基础帮贡 > 0 then
				local bg = floor(基础帮贡)
				添加帮贡(id,bg)
			end
			if 基础副本积分 > 0 then
				local jf = floor(基础副本积分)
				玩家数据[id].角色:添加副本积分(jf)
			end
			if 神器积分 > 0 then
				local jf = floor(神器积分)
				玩家数据[id].角色:添加神器积分(jf)
			end
			if 天罡积分 > 0 then
				local jf = floor(天罡积分)
				玩家数据[id].角色:添加天罡积分(jf)
			end
			if 地煞积分 > 0 then
				local jf = floor(地煞积分)
				玩家数据[id].角色:添加地煞积分(jf)
			end
			if 基础官职点 > 0 then
				local jf = floor(基础官职点)
				玩家数据[id].角色.官职点=玩家数据[id].角色.官职点+jf
			end
			if 保卫战积分 > 0 then
				local jf = floor(保卫战积分)
				长安保卫战:增加积分(id,jf)
			end
			if #物品奖励>0 then
				for x=1,最大奖励 do
					local sj = 取随机数(1,爆率上限)
					for n,_ in ipairs(物品奖励) do
					    if sj < _[2] then
					    	local 名称,数量,参数=生成产出(_[1],_[6],id)
					    	if 名称 then
					    		local sl = 数量 or _[3]
						    	if 是否广播 and 广播内容 then
						    		local 内容组 = 分割文本(广播内容,"item")
						    		local str = 内容组[1]:gsub("name", 玩家数据[id].角色.名称) --:gsub("item", _[1]
						    		if 类型==140000 then --雁塔地宫
						    			local 层数=雁塔地宫:取地宫最低层数(队伍数据[玩家数据[id].队伍].成员数据)
										local gw=雁塔地宫.取怪物[层数]
										str = str:gsub("guaiwu", gw[1].名称 or "")
									else
										str = str:gsub("guaiwu", (任务数据[RWID] or {}).名称 or "")
									end
						    		local 链接 = {提示=str,频道="hd",结尾=内容组[2] or ""}
						    		玩家数据[id].道具:给予超链接道具(id,名称,sl,参数,链接,_[4])
						   		else
						   			玩家数据[id].道具:给予道具(id,名称,sl,参数,nil,_[4],nil,nil,nil,nil)
						    	end
						    	常规提示(id,"#Y/你获得了一个#G/"..名称)
						    	break
					    	end
					    end
					end
				end
			end
			if 玩家数据[id].角色.自动回收 and 玩家数据[id].角色.自动回收.自动回收 and 玩家数据[id].角色:取空道具格子数量() <= 5 then
				系统处理类:一键回收(id)
			end
		end
	end
end


function 战斗奖励:其他奖励(id,类型)
	local 奖励数据 = 战斗物品奖励[类型]
	if 奖励数据 then
		local 基础经验 = tonumber(奖励数据.初始经验) or 0
		local 基础金钱 = tonumber(奖励数据.初始银子) or 0
		local 基础储备 = tonumber(奖励数据.初始储备) or 0
		local 基础仙玉 = tonumber(奖励数据.初始仙玉) or 0
		local 基础点卡 = tonumber(奖励数据.初始点卡) or 0
		local 基础活跃 = tonumber(奖励数据.初始活跃) or 0
		local 基础限制 = tonumber(奖励数据.限制次数) or 0

		local 天罡积分 = tonumber(奖励数据.天罡积分) or 0
		local 地煞积分 = tonumber(奖励数据.地煞积分) or 0
		local 神器积分 = tonumber(奖励数据.神器积分) or 0
		local 基础帮贡 = tonumber(奖励数据.帮贡) or 0
		local 基础官职点 = tonumber(奖励数据.官职点) or 0
		local 基础副本积分 = tonumber(奖励数据.副本积分) or 0
		local 保卫战积分 = tonumber(奖励数据.保卫战积分) or 0
		local 等级影响 = tonumber(奖励数据.等级影响) or 0
		local 任务等级 = tonumber(奖励数据.任务等级) or 玩家数据[id].角色.等级
		local 最大奖励 = tonumber(奖励数据.最大奖励个数) or 1
		local 爆率上限 = tonumber(奖励数据.爆率) or 1000
		local 是否广播 = tonumber(奖励数据.是否广播) == 1
		local 广播内容 = 奖励数据.广播内容
		local 物品奖励 = {}
		for n=1,15 do
		    if 奖励数据["物品"..n] then
		    	local mc = 奖励数据["物品"..n].名称
		    	local sl = tonumber(奖励数据["物品"..n].数量)
		    	local qz = tonumber(奖励数据["物品"..n].权重) or 0
		    	if #物品奖励 >= 1 then
		    		qz = qz + 物品奖励[#物品奖励][2]
		    	end
		    	local zy = 奖励数据["物品"..n].专用
		    	local ew = 奖励数据["物品"..n].额外参数
		    	if ItemData[mc] or mc == "元宵" or mc == "环装" or mc == "灵饰书铁" or mc == "装备书铁" then
		    		物品奖励[#物品奖励+1] = {mc,qz,sl,zy,取随机数(1,10000),ew}
		    	end
		    end
		end

		local dj = 玩家数据[id].角色.等级
		local 次数
		if 次数影响 then
			if string.find(类型,"地宫") then --雁塔地宫
				次数 = ((雁塔地宫.数据[id] or {}).层数) or 0
			end
		end
		local 系数 = (dj-任务等级)*等级影响
		local 系数经验 = 基础经验*系数
		local 次数经验 = 0
		local 次数系数 = 1
		if 次数 then
			次数经验 = 基础经验*次数*次数影响
		end
		local jy = floor(基础经验+系数经验+次数经验)
		if jy > 0 then
			玩家数据[id].角色:添加经验(jy,类型,1)
			if 玩家数据[id].角色.参战信息~=nil then
		      玩家数据[id].召唤兽:获得经验(玩家数据[id].角色.参战宝宝.认证码,math.floor(jy*0.8),id,类型)
		    end
		end
		local 系数金钱 = 基础金钱*系数
		local 次数金钱 = 0
		local 次数系数 = 1
		if 次数 then
			次数金钱 = 基础金钱*次数*次数影响
		end
		local jq = floor(基础金钱+系数金钱+次数金钱)
		if jq > 0 then
			玩家数据[id].角色:添加银子(jq,类型,1)
		end


		local 系数储备 = 基础储备*系数
		local 次数储备 = 0
		local 次数系数 = 1
		if 次数 then
			次数储备 = 基础储备*次数*次数影响
		end
		local jq = floor(基础储备+系数储备+次数储备)
		if jq > 0 then
			玩家数据[id].角色:添加储备(jq,类型,1)
		end
		if 基础仙玉 > 0 then
			local xy = floor(基础仙玉)
			添加仙玉(id,玩家数据[id].账号, xy, 类型)
		end
		if 基础点卡 > 0 then
			local dk = floor(基础点卡)
			添加点卡(id,玩家数据[id].账号, dk, 类型)
		end

		if 基础活跃 > 0 then
			local hy = floor(基础活跃)
			添加活跃(id,hy)

		end

		-- if 基础限制 > 0 then
		-- 		local 活动

		-- 		if 类型==155559 then
		-- 			活动="下凡的灵猴"
		-- 		elseif 类型==155560 then
		-- 			活动="三界财神爷"
		-- 		elseif 类型==155562 then
		-- 			活动="远古妖魔头目"
		-- 		elseif 类型==155563 then
		-- 			活动="远古妖魔领主"
		-- 		elseif 类型==155564 then
		-- 			活动="远古妖魔尊主"
		-- 		elseif 类型==160001 then
		-- 			活动="夏日炎炎"
		-- 		elseif 类型==160002 then
		-- 			活动="魂殿使者"
		-- 		elseif 类型==160003 then
		-- 			活动="魂殿殿主"
		-- 		elseif 类型==160016 then
		-- 			活动="琴声悠悠"
		-- 		elseif 类型==160017 then
		-- 			活动="新春快乐"
		-- 		elseif 类型==160019 then
		-- 			活动="龙神"
		-- 		elseif 类型==160020 then
		-- 			活动="仙气十足"
		-- 		elseif 类型==160021 then
		-- 			活动="武神坛服战8强"
		-- 		elseif 类型==160022 then
		-- 			活动="武神坛服战4强"
		-- 		elseif 类型==160023 then
		-- 			活动="武神坛服战季军"
		-- 		elseif 类型==160024 then
		-- 			活动="武神坛服战亚军"
		-- 		elseif 类型==160025 then
		-- 			活动="武神坛服战冠军"
		-- 		elseif 类型==160026 then
		-- 			活动="客服小二"
		-- 		end
		-- 		添加完成次数(id,活动)  -----限制刷怪

		-- 	end

		if 基础帮贡 > 0 then
			local bg = floor(基础帮贡)
			添加帮贡(id,bg)
		end
		if 基础副本积分 > 0 then
			local jf = floor(基础副本积分)
			玩家数据[id].角色:添加副本积分(jf)
		end
		if 基础官职点 > 0 then
			local jf = floor(基础官职点)
			玩家数据[id].角色.官职点=玩家数据[id].角色.官职点+jf
		end
		if 保卫战积分 > 0 then
			local jf = floor(保卫战积分)
			长安保卫战:增加积分(id,jf)
		end
		    if 神器积分 > 0 then
				local jf = floor(神器积分)
				玩家数据[id].角色:添加神器积分(jf)
			end
			if 天罡积分 > 0 then
				local jf = floor(天罡积分)
				玩家数据[id].角色:添加天罡积分(jf)
			end
			if 地煞积分 > 0 then
				local jf = floor(地煞积分)
				玩家数据[id].角色:添加地煞积分(jf)
			end
		if #物品奖励>0 then
			for x=1,最大奖励 do
				local sj = 取随机数(1,爆率上限)
				for n,_ in ipairs(物品奖励) do
				    if sj < _[2] then
				    	local 名称,数量,参数=生成产出(_[1],_[6])
						local sl = 数量 or _[3]
				    	if 是否广播 and 广播内容 then
				    		local 内容组 = 分割文本(广播内容,"item")
				    		local str = 内容组[1]:gsub("name", 玩家数据[id].角色.名称) --:gsub("item", _[1]
				    		local 链接 = {提示=str,频道="hd",结尾=内容组[2] or ""}
				    		玩家数据[id].道具:给予超链接道具(id,名称,sl,参数,链接,_[4])
				   		else
				   			玩家数据[id].道具:给予道具(id,名称,sl,参数,nil,_[4],nil,nil,nil,nil)
				    	end
				    	常规提示(id,"#Y/你获得了一个#G/".._[1])
				    	break
				    end
				end
			end
		end
		if 玩家数据[id].角色.自动回收 and 玩家数据[id].角色.自动回收.自动回收 and 玩家数据[id].角色:取空道具格子数量() <= 5 then
			系统处理类:一键回收(id)
		end
	end
end

return 战斗奖励