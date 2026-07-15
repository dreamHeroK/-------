local vip = class()
local hswpjg={
10000,80000,100000,30000,
30000,30000,30000,40000,
100000,100000,20000,60000,
300000,10000,30000,80000,
10000,50000,40000,100000,
50000,30000,50000,50000,---附魔宝珠
100000,50000,60000,50000,
100000,10000,70000,50000,--珍珠
10000,20000,80000,20000,
15000,10000,80000,10000,
100,10000,50000,20000,
20000,50000,50000,50000,
50000,80000,10000,50000
}
function vip:初始化()end

function vip:数据处理(id, 数据序列, 内容, 参数,编号)
	 if 玩家数据[id].角色.vip == nil then
	 	玩家数据[id].角色.vip={等级=0,当前经验=0,升级经验=100}
	 end
	 if 数据序列==1 then
	      self:获取VIP数据(id)

	elseif  数据序列==7 then
	      self:获取签到数据(id)
	elseif  数据序列==10 then
		 if 玩家数据[id].角色.回收 == nil then
		 	玩家数据[id].角色.回收={}
		 	for i = 1, 52 do
		 	 玩家数据[id].角色.回收[i]=false
		 	end
		 end
		 if 玩家数据[id].角色.回收[52] == nil then
		 	玩家数据[id].角色.回收[52]=false
		 end
		  if 玩家数据[id].角色.回收.开启==nil then
		  	玩家数据[id].角色.回收.开启=false
		  end
	      	self:获取自动回收数据(id)

	elseif  数据序列==11 then
	      self:自动回收设置(id,参数)
	elseif  数据序列==12 then
	      self:自动回收处理(id)
	elseif  数据序列==13 then
		 if 玩家数据[id].角色.回收 == nil then
		 	玩家数据[id].角色.回收={}
		 	for i = 1, 52 do
		 	 玩家数据[id].角色.回收[i]=false
		 	end
		 end
	 	for i = 1, 52 do
	 	 	玩家数据[id].角色.回收[i]=true
	 	end
		发送数据(玩家数据[id].连接id, 430001,玩家数据[id].角色.回收)
	elseif  数据序列==14 then
		if 玩家数据[id].角色.回收 == nil then
		 	玩家数据[id].角色.回收={}
		 	for i = 1, 52 do
		 	 玩家数据[id].角色.回收[i]=false
		 	end
		 end
	 	for i = 1, 52 do
	 	 玩家数据[id].角色.回收[i]=false
	 	end
		发送数据(玩家数据[id].连接id, 430001,玩家数据[id].角色.回收)

	elseif 数据序列 == 15 then
		if not 玩家数据[id] or not 玩家数据 [id].角色 then
			print (string.format ("数据序列 15：玩家数据无效，id=% s", tostring (id)))
			return
		end
		if 玩家数据 [id]. 角色.账号仓库回收 == nil then
			玩家数据 [id].角色.账号仓库回收 = {}
			for i = 1, 52 do
				玩家数据 [id]. 角色.账号仓库回收[i] = false
			end
		end
		if 玩家数据 [id]. 角色.账号仓库回收 [52] == nil then
			玩家数据 [id]. 角色.账号仓库回收 [52] = false
		end
		if 玩家数据 [id]. 角色.账号仓库回收.开启 == nil then
			玩家数据 [id]. 角色.账号仓库回收.开启 = false
		end
		self: 获取仓库自动回收数据 (id)

	elseif  数据序列==16 then
	      self:账号仓库自动回收设置(id,参数)
	elseif 数据序列 == 17 then
		if not 玩家数据[id] or not 玩家数据[id].角色 then
			return
		end-- 初始化账号仓库回收配置（若不存在）
		if 玩家数据[id].角色.账号仓库回收 == nil then
			玩家数据[id].角色.账号仓库回收 = {}-- 初始化 1-52 项为默认关闭（与基础逻辑一致）
			for i = 1, 52 do
				玩家数据[id].角色.账号仓库回收[i] = false
			end
		end-- 将 1-52 项回收开关全部设为 true
			for i = 1, 52 do
				玩家数据 [id].角色.账号仓库回收[i] = true
		end-- 发送更新后的账号仓库回收配置（使用账号仓库对应的协议号 430003）
		发送数据 (玩家数据[id].连接id, 430003, 玩家数据[id].角色.账号仓库回收)
	elseif 数据序列 == 18 then
		if not 玩家数据[id] or not 玩家数据[id].角色 then
			return
		end-- 初始化账号仓库回收配置（若不存在）
		if 玩家数据 [id].角色.账号仓库回收 == nil then
			玩家数据 [id].角色.账号仓库回收 = {}-- 初始化 1-52 项为默认关闭
			for i = 1, 52 do
				玩家数据[id].角色.账号仓库回收 [i] = false
			end
		end-- 将 1-52 项回收开关全部设为 false
			for i = 1, 52 do
				玩家数据 [id].角色.账号仓库回收[i] = false
			end-- 发送更新后的账号仓库回收配置（使用账号仓库对应的协议号 430003）
			发送数据 (玩家数据[id].连接id, 430003, 玩家数据[id].角色.账号仓库回收)
	elseif  数据序列==19 then
	      self:账号仓库自动回收处理(id)




	 end
end

function vip:获取VIP数据(id)
	 if 玩家数据[id].角色.vip == nil then
	 	玩家数据[id].角色.vip={等级=0,当前经验=0,升级经验=100}
	 end
	发送数据(玩家数据[id].连接id, 420000,{vip=玩家数据[id].角色.vip,白嫖=玩家数据[id].角色.白嫖赞助})
end

function vip:自动回收设置(id,参数)
	if 参数== nil then
		return
	end
	玩家数据[id].角色.回收[参数]=not 玩家数据[id].角色.回收[参数]
	发送数据(玩家数据[id].连接id, 430001,玩家数据[id].角色.回收)
end

function vip:账号仓库自动回收设置 (id, 参数)
	if 参数 == nil then
		return
	end-- 初始化账号仓库设置字段（若不存在）
	if 玩家数据 [id].角色.账号仓库回收 == nil then
		玩家数据[id].角色.账号仓库回收 = {}
	end-- 切换对应参数的开关状态（true/false 反转）
	玩家数据[id].角色.账号仓库回收[参数] = not 玩家数据 [id].角色.账号仓库回收[参数]-- 向客户端发送更新后的账号仓库设置
	发送数据(玩家数据[id].连接id, 430003, 玩家数据[id].角色.账号仓库回收)
end
function vip:账号仓库自动回收处理(id)
	local ts = ""
	if 玩家数据[id].角色.账号仓库回收 == nil then
		玩家数据[id].角色.账号仓库回收 = {}
		for i = 1, 52 do
			玩家数据[id].角色.账号仓库回收[i] = false
		end
	end
	if 玩家数据[id].角色.账号仓库回收[52] == nil then
		玩家数据[id].角色.账号仓库回收[52] = false
	end
	local 玩家账号 = 玩家数据[id].角色.账号
	local 仓库实例 = 账号仓库数据[玩家账号]
	if not 仓库实例 then
		常规提示(id, "#Y未找到账号仓库数据，无法进行仓库自动回收！")
		return
	end
	local 仓库类型列表 = {"宝石", "内丹", "书铁", "兽决", "装备", "炼妖", "其他", "卡片"}
	for i = 1, #玩家数据[id].角色.账号仓库回收 do
		if 玩家数据[id].角色.账号仓库回收[i] == true then
			for _, 仓库类型 in ipairs(仓库类型列表) do
				if 仓库实例.数据[仓库类型] then
					local 仓库 = 仓库实例.数据[仓库类型]
					local 页数 = 1  -- 仓库默认处理第1页（与原仓库逻辑一致）
					for 格子 = 1, 仓库.总数 do
						local prop = 仓库[页数][格子]
						if prop then  -- 仓库格子有道具才处理
							if prop.数量==nil then
								prop.数量=1
							end
							玩家数据[id].回收时间 = os.time() + 5  -- 保留原防频繁回收逻辑
							if i == 1 then
								if prop.名称 == "青龙石" or prop.名称 == "白虎石" or prop.名称 == "朱雀石" or prop.名称 == "玄武石" then
									仓库[页数][格子] = nil  -- 关键：从仓库删除道具
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 2 or i == 41 then
								if prop.总类 == 2 and not prop.专用 and not prop.灵饰 and not prop.召唤兽装备 and prop.等级 then
									if prop.等级 > 60 and prop.等级 <= 120 and i == 2 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 <= 60 and i == 41 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									end
								end
							elseif i == 45 then
								if prop.名称 == "摇钱树苗" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 49 then
								if prop.名称 == "灵犀玉" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 3 then
								if prop.名称 == "高级召唤兽内丹" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 50 then
								if prop.名称 == "召唤兽内丹" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 51 then
								if prop.名称 == "怪物卡片" or prop.名称 == "雪人炫卡" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 43 then
								if prop.名称 == "制造指南书" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 47 then
								if prop.名称 == "灵饰指南书" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 52 then
								if prop.名称 == "元灵晶石" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 4 or i == 8 or i == 12 or i == 16 or i == 20 then
								if prop.名称 == "上古锻造图策" then
									if prop.等级 <= 105 and i == 4 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 115 and i == 8 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 125 and i == 12 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 135 and i == 16 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 145 and i == 20 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									end
								end
							elseif i == 11 or i == 15 or i == 19 or i == 23 or i == 27 or i == 31 or i == 35 or i == 39 or i == 42 then
								if prop.名称 == "炼妖石" then
									if prop.等级 <= 65 and i == 42 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 75 and i == 11 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 85 and i == 15 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 95 and i == 19 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 105 and i == 23 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 115 and i == 27 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 125 and i == 31 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 135 and i == 35 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.等级 == 145 and i == 39 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									end
								end
							elseif i == 5 or i == 9 or i == 13 then
								if prop.总类 == 889 then
									if prop.子类 == 1 and i == 5 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.子类 == 2 and i == 9 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.子类 == 3 and i == 13 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									elseif prop.分类 == 90 and i == 13 then
										仓库[页数][格子] = nil
										玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
										ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
									end
								end
							elseif i == 7 then
								if prop.名称 == "金刚石" or prop.名称 == "定魂珠" or prop.名称 == "避水珠" or prop.名称 == "夜光珠" or prop.名称 == "龙鳞" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 28 then
								if prop.名称 == "桂花酒酿元宵" or prop.名称 == "芝麻沁香元宵" or prop.名称 == "细磨豆沙元宵" or prop.名称 == "蜜糖腰果元宵" or prop.名称 == "山楂拔丝元宵" or prop.名称 == "滑玉莲蓉元宵" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 30 then
								if prop.名称 == "玄天残卷·上卷" or prop.名称 == "玄天残卷·中卷" or prop.名称 == "玄天残卷·下卷" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 33 then
								if (prop.总类 == 5 and prop.分类 == 6 and prop.名称 ~= "战魄" and prop.名称 ~= "精致碎石锤" and prop.名称 ~= "珍珠" and prop.名称 ~= "星辉石" and prop.名称 ~= "陨铁" and prop.名称 ~= "钨金" and prop.名称 ~= "附魔宝珠") or prop.名称 == "精魄灵石" then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.等级, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							elseif i == 48 then
								if prop.名称 == "本命法宝门派秘籍" then
									仓库[页数][格子] = nil
									玩家数据[id].道具:给予道具(id, "法宝精华", 1,nil,"不存共享")  -- 保留原给予逻辑
									ts = ts .. "#G" .. prop.名称 .. "#Y，"
								end
							elseif i == 6 or i == 10 or i == 14 or i == 17 or i == 18 or i == 21 or i == 22 or i == 24 or i == 25 or i == 26 or i == 29 or i == 32 or i == 34 or i == 37 or i == 38 or i == 42 or i == 46 or i == 36 or i == 40 or i == 44 then
								if prop.名称 == "魔兽要诀" and i == 6 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "符石卷轴" and i == 36 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif (prop.名称 == "藏宝图" or prop.名称 == "高级藏宝图" or prop.名称 == "玲珑宝图" or prop.名称 == "雪人炫卡") and i == 40 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "天赋符" and i == 44 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "高级魔兽要诀" and i == 10 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "金柳露" and i == 14 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "月华露" and i == 17 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "超级金柳露" and i == 18 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "如意丹" and i == 21 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "净瓶玉露" and i == 22 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "附魔宝珠" and i == 24 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "易经丹" and i == 25 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "超级净瓶玉露" and i == 26 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "玉葫灵髓" and i == 29 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "珍珠" and i == 32 then
									仓库[页数][格子] = nil

									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.总类 == 141 and i == 34 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "星辉石" and i == 37 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.等级, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "彩果" and i == 38 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i] * prop.数量, "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								elseif prop.名称 == "百炼精铁" and i == 46 then
									仓库[页数][格子] = nil
									玩家数据[id].角色:添加银子(hswpjg[i], "仓库回收出售", 1)
									ts = ts .. "#G" .. prop.名称 .. "=" .. hswpjg[i] .. "#Y，"
								end
							end
						end
					end
					-- 仓库回收后整理对应类型仓库（复用仓库类整理方法）
					-- 仓库实例:内部仓库整理(仓库类型, 页数)
				end
			end
		end
	end
	if 仓库实例 then
    -- 1. 记录用户回收时正在查看的仓库类型（核心：保存当前页面类型）
    local 当前仓库类型 = 仓库实例.仓库类型  -- 从仓库实例获取当前活跃类型（如"宝石"/"兽决"等）
    -- 2. 保存回收后的数据
    仓库实例:账号仓库存档()
    -- 3. 获取当前玩家连接ID
    local 连接id = 玩家数据[id].连接id
    if not 连接id then
        print(string.format("仓库回收刷新失败：玩家[id=%s]连接无效", tostring(id)))
        return
    end

    -- 4. 刷新当前玩家的背包/道具（对齐存放逻辑）
    道具刷新(id)
    发送数据(连接id, 3513, 玩家数据[id].道具:索要道具2(id))
    -- 发送数据(连接id, 414, {类型 = "道具", 数据 = 玩家数据[id].道具:索要道具2(id)})
    -- 发送数据(连接id, 414, {类型 = "行囊", 数据 = 玩家数据[id].道具:索要行囊2(id)})

    -- 5. 遍历所有仓库类型刷新数据（确保全量数据同步）
    for _, 仓库类型 in ipairs(仓库类型列表) do
        local 类型仓库 = 仓库实例.数据[仓库类型]
        if 类型仓库 then
            发送数据(连接id, 413, {
                类型 = 仓库类型,
                道具 = 仓库实例:索要仓库道具(id, 1, 仓库类型),
                页数 = 1,
                界面 = "道具",
                道具仓库总数 = 类型仓库.总数 / 56
            })
        end
    end

    -- 6. 关键：单独发送一次当前类型的刷新，强制客户端保持在该页面
    -- （客户端会以最后收到的"类型"作为当前显示页面）
    local 当前类型仓库 = 仓库实例.数据[当前仓库类型]
    if 当前类型仓库 then
        发送数据(连接id, 413, {
            类型 = 当前仓库类型,  -- 强制使用回收前的类型
            道具 = 仓库实例:索要仓库道具(id, 1, 当前仓库类型),
            页数 = 1,
            界面 = "道具",
            道具仓库总数 = 当前类型仓库.总数 / 56
        })
    end

    -- 7. 通知账号内其他在线成员（同样保持他们的当前类型，或同步当前用户的类型）
    if type(仓库实例.帐号id组) == "table" then
        for _, 成员id in ipairs(仓库实例.帐号id组) do
            local 成员连接id = 玩家数据[成员id] and 玩家数据[成员id].连接id
            if 成员连接id and 成员id ~= id then
                -- 同步所有类型数据
                for _, 仓库类型 in ipairs(仓库类型列表) do
                    local 类型仓库 = 仓库实例.数据[仓库类型]
                    if 类型仓库 then
                        发送数据(成员连接id, 413, {
                            类型 = 仓库类型,
                            道具 = 仓库实例:索要仓库道具(成员id, 1, 仓库类型),
                            页数 = 1,
                            界面 = "道具",
                            道具仓库总数 = 类型仓库.总数 / 56
                        })
                    end
                end
                -- 若需要让其他成员也同步到当前类型（可选，根据需求）
                -- if 当前类型仓库 then
                --     发送数据(成员连接id, 413, {
                --         类型 = 当前仓库类型,
                --         道具 = 仓库实例:索要仓库道具(成员id, 1, 当前仓库类型),
                --         页数 = 1,
                --         界面 = "道具",
                --         道具仓库总数 = 当前类型仓库.总数 / 56
                --     })
                -- end
                发送数据(成员连接id, 3513, 玩家数据[成员id].道具:索要道具2(成员id))
            end
        end
    end
end

-- 8. 回收结果提示
	if ts ~= "" then
	    常规提示(id, "仓库回收#G" .. ts .. "成功！")
	else
	    常规提示(id, "你共享仓库中没有可回收的物品！")
	end
end
function vip:自动回收处理(id)
	local ts=""
	 if 玩家数据[id].角色.回收 == nil then
	 	玩家数据[id].角色.回收={}
	 	for i = 1, 52 do
	 	 玩家数据[id].角色.回收[i]=false
	 	end
	 end
	 if 玩家数据[id].角色.回收[52] == nil then
	 	玩家数据[id].角色.回收[52]= false
	 end
	for i=1,#玩家数据[id].角色.回收 do
		 if 玩家数据[id].角色.回收[i]==true  then
		for n=1,80 do
		    	if 玩家数据[id].角色.道具[n] and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]] then
			玩家数据[id].回收时间=os.time()+5
			local prop=玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]
			local user=玩家数据[id].角色.道具[n]
				if prop.数量==nil then
					prop.数量=1
				end
				 if i==1  then
				   	if prop.名称=="青龙石" or prop.名称=="白虎石" or prop.名称=="朱雀石" or prop.名称=="玄武石" then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif   i==2  or i==41  then
				   	if   prop.总类==2 and not prop.专用 and not prop.灵饰 and not prop.召唤兽装备  and prop.等级 then
				   	    if      prop.等级>60 and   prop.等级<=120 and i == 2 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					    elseif  prop.等级<=60 and i == 41 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					    end
				   	end
				   elseif   i==45 then
				   	if prop.名称=="摇钱树苗"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end

				   elseif   i==49 then
				   	if prop.名称=="灵犀玉"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end

				   elseif   i==3  then
				   	if prop.名称=="高级召唤兽内丹"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif   i==50  then
				   	if prop.名称=="召唤兽内丹"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif  i==51  then
				   	if prop.名称=="怪物卡片"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif  prop.名称=="雪人炫卡"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif  i==43  then

				   	if prop.名称=="制造指南书"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif  i==47  then
				   	if prop.名称=="灵饰指南书"  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif  i==52  then
				   	if prop.名称=="元灵晶石"   then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif   i==4 or  i==8  or  i==12  or  i==16  or  i==20   then
				   	if prop.名称=="上古锻造图策"then
				   		if    prop.等级<=105  and i==4 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==115  and i==8 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==125  and i==12 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==135  and i==16 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==145  and i==20 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						end
				   	end
				   elseif   i==11 or  i==15  or  i==19  or  i==23  or  i==27  or  i==31 or  i==35   or  i==39   or  i==42 then
				   	if prop.名称=="炼妖石"then
				   		if    prop.等级<=65  and i==42 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   		elseif  prop.等级==75  and i==11 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==85  and i==15 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==95  and i==19 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==105  and i==23 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==115  and i==27 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==125  and i==31 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==135  and i==35 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						elseif    prop.等级==145 and i==39 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						end
				   	end

				   elseif   i==5 or    i==9   or    i==13   then
				   	if prop.总类 == 889  then
				   	    if prop.子类==1 and i==5 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	    elseif  prop.子类==2 and i==9 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	    elseif  prop.子类==3 and i==13 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	    elseif  prop.分类==90 and i==13 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	     end
				   	 end
				   elseif   i==7  then
				   	if prop.名称 == "金刚石" or  prop.名称 == "定魂珠" or  prop.名称 == "避水珠" or  prop.名称 == "夜光珠" or  prop.名称 == "龙鳞" then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif   i==28  then
				   	if prop.名称 == "桂花酒酿元宵" or  prop.名称 == "芝麻沁香元宵" or  prop.名称 == "细磨豆沙元宵" or  prop.名称 == "蜜糖腰果元宵" or  prop.名称 == "山楂拔丝元宵" or  prop.名称 == "滑玉莲蓉元宵" then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif   i==30  then
				   	if prop.名称 == "玄天残卷·上卷" or  prop.名称 == "玄天残卷·中卷" or  prop.名称 == "玄天残卷·下卷" then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif   i==33  then
				   	if prop.总类==5 and  prop.分类==6 and   prop.名称~="战魄"  and   prop.名称~="精致碎石锤"  and   prop.名称~="珍珠" and   prop.名称~="星辉石" and   prop.名称~="陨铁" and   prop.名称~="钨金"  and   prop.名称~="附魔宝珠"    then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.等级,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   	if    prop.名称=="精魄灵石" then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.等级,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
				   	end
				   elseif       i==48  then
				   	if prop.名称 == "本命法宝门派秘籍" then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].道具:给予道具(id,"法宝精华",1,nil,"不存共享")

						ts=ts.."#G"..prop.名称.."#Y，"
				   	end

				   	if ts ~= "" then
	常规提示(id,"回收#G"..ts.."成功！")
	道具刷新(id)
else
	常规提示(id,"你没有可以回收的物品！")
end
				   elseif   i==6 or    i==10   or    i==14  or    i==17   or    i==18    or    i==21
				   or    i==22    or    i==24    or    i==25      or    i==26      or    i==29     or    i==32
				   or    i==34  or    i==37  or    i==38  or    i==42  or    i==46  or    i==36  or    i==40  or    i==44  then
				   	if prop.名称 == "魔兽要诀" and  i==6 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "符石卷轴" and  i==36 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "藏宝图" and  i==40 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
				   		ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "高级藏宝图" and  i==40 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "玲珑宝图" and  i==40 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "雪人炫卡" and  i==40 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "天赋符" and  i==44 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "高级魔兽要诀" and  i==10 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "金柳露" and  i==14 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "月华露" and  i==17 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "超级金柳露" and  i==18 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "如意丹" and  i==21 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "净瓶玉露" and  i==22 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "附魔宝珠" and  i==24  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "易经丹" and  i==25 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "超级净瓶玉露" and  i==26 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "玉葫灵髓" and  i==29 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "珍珠" and  i==32 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.总类 == 141 and  i==34 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "星辉石" and  i==37 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.等级,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif  prop.名称 == "彩果" and  i==38 then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i]*prop.数量,"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"
					elseif    prop.名称 == "百炼精铁" and  i==46  then
				   		玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]=nil
						玩家数据[id].角色.道具[n]=nil
						玩家数据[id].角色:添加银子(hswpjg[i],"回收出售",1)
						ts=ts.."#G"..prop.名称.."="..hswpjg[i].."#Y，"


						 --   i==32
				   -- or    i==34  or    i==37  or    i==38  or    i==42  or    i==46  or    i==50     then
				   	end

				   end

			end
		end
	end

	end
	if ts ~= "" then
	常规提示(id,"回收#G"..ts.."成功！")
	道具刷新(id)
else
	常规提示(id,"你没有可以回收的物品！")
end
end
function vip:获取自动回收数据(id)
	 if 玩家数据[id].角色.回收 == nil then
	 	玩家数据[id].角色.回收={}
	 	for i = 1, 52 do
	 	 玩家数据[id].角色.回收[i]=false
	 	end
	 end
	 if 玩家数据[id].角色.回收[52] == nil then
	 玩家数据[id].角色.回收[52]=false
	 end
	  if 玩家数据[id].角色.回收.开启==nil then
	  	玩家数据[id].角色.回收.开启=false
	  end
	发送数据(玩家数据[id].连接id, 430000,玩家数据[id].角色.回收)
end
function vip:获取仓库自动回收数据(id)
	 if 玩家数据[id].角色.账号仓库回收 == nil then
	 	玩家数据[id].角色.账号仓库回收={}
	 	for i = 1, 52 do
	 	 玩家数据[id].角色.账号仓库回收[i]=false
	 	end
	 end
	 if 玩家数据[id].角色.账号仓库回收[52] == nil then
	 玩家数据[id].角色.账号仓库回收[52]=false
	 end
	  if 玩家数据[id].角色.账号仓库回收.开启==nil then
	  	玩家数据[id].角色.账号仓库回收.开启=false
	  end
	发送数据(玩家数据[id].连接id, 430002,玩家数据[id].角色.账号仓库回收)
end

return vip