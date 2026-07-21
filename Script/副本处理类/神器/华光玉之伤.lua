
local 副本_华光玉之伤 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 副本_华光玉之伤:初始化()
	地图处理类.地图数据[9504]={npc={},单位={},传送圈={}} --大唐国境
	地图处理类.地图玩家[9504]={}
	地图处理类.地图坐标[9504]=地图处理类.地图坐标[1110]
	地图处理类.地图单位[9504]={}
	地图处理类.单位编号[9504]=1000

	地图处理类.地图数据[9505]={npc={},单位={},传送圈={}} --普陀山
	地图处理类.地图玩家[9505]={}
	地图处理类.地图坐标[9505]=地图处理类.地图坐标[1140]
	地图处理类.地图单位[9505]={}
	地图处理类.单位编号[9505]=1000

	地图处理类.地图数据[9506]={npc={},单位={},传送圈={}} --潮音洞
	地图处理类.地图玩家[9506]={}
	地图处理类.地图坐标[9506]=地图处理类.地图坐标[1141]
	地图处理类.地图单位[9506]={}
	地图处理类.单位编号[9506]=1000

	地图处理类.地图数据[9507]={npc={},单位={},传送圈={}} --豪宅华木地板
	地图处理类.地图玩家[9507]={}
	地图处理类.地图坐标[9507]=地图处理类.地图坐标[1323]
	地图处理类.地图单位[9507]={}
	地图处理类.单位编号[9507]=1000

	地图处理类.地图数据[9508]={npc={},单位={},传送圈={}} --大雁塔五层
	地图处理类.地图玩家[9508]={}
	地图处理类.地图坐标[9508]=地图处理类.地图坐标[1008]
	地图处理类.地图单位[9508]={}
	地图处理类.单位编号[9508]=1000

	地图处理类.地图数据[9509]={npc={},单位={},传送圈={}} --傲来国
	地图处理类.地图玩家[9509]={}
	地图处理类.地图坐标[9509]=地图处理类.地图坐标[1092]
	地图处理类.地图单位[9509]={}
	地图处理类.单位编号[9509]=1000
end

function 副本_华光玉之伤:开启副本(id,nandu)
	local DJ = 69

	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<5 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	elseif  取等级要求(id,DJ)==false then
		常规提示(id,"#Y此副本要求角色等级不能低于"..DJ.."级")
		return
	end
	local 队伍id=玩家数据[id].队伍
	local 难度 = 玩家数据[id].角色.神器难度
	 玩家数据[id].角色.神器难度 = 难度
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 副本数据.神器任务.完成[临时id]~=nil then
		常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过神器任务了")
		return
		elseif 玩家数据[临时id].角色:取任务(1560)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行神器任务，无法领取新的神器任务")
			return
		end
	end
	if 副本数据.华光玉之伤.进行[id] == nil then
	副本数据.华光玉之伤.进行[id]={进程=1}
	end


	local 任务id,ZU=取唯一任务(1560,id)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		玩家id=0,
		DWZ=ZU,
		销毁=true,
		副本重置=true,
		队伍组=ZU,
		副本id=id,
		PlayerGroup = table.copy(队伍数据[队伍id].成员数据),
		类型=1560
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了神器·华光玉之伤")
	刷新任务1560(id)
end

function 刷新任务1560(id)
	local id = 任务处理类:取副本id(id,1560)
	if 副本数据.华光玉之伤.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.华光玉之伤.进行[id].进程==1 then
		local 地图=9504 --长安城
		local 任务id=id.."_1561_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="燕晓",
			模型="飞燕女",
			锦衣="浮生绡·点黛",
			武器="浮犀",
			x=258,
			y=301,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1561
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9504,238,269) --跳转到动画地图
	elseif 副本数据.华光玉之伤.进行[id].进程==2 then
		任务处理类:删除副本单位(id,1560,1561)
		local 地图=9505 --长安城
		local 任务id=id.."_1562_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="神秘人影",
			模型="飞燕女",
			锦衣="浮生绡·点黛",
			武器="浮犀",
			x=31,
			y=50,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1562
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9505,85,64) --跳转到动画地图
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.华光玉之伤.进行[id].进程==3 then
			任务处理类:删除副本单位(id,1560,1562)
			local 任务id=id.."_1563_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9505 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="水涟漪",
				模型="舞天姬",
				锦衣="萌龙咆哮",
				武器="朝夕",
				销毁=true,
				副本重置=true,
				x=8,
				y=8,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1563
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.华光玉之伤.进行[id].进程==4 then
			任务处理类:删除副本单位(id,1560,1563)
			local 任务id=id.."_1564_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9506 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="陆丝",
				模型="飞燕女",
				锦衣="萌龙咆哮",
				武器="朝夕",
				销毁=true,
				副本重置=true,
				x=39,
				y=10,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1564
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9506,48,37) --跳转到动画地图
	elseif 副本数据.华光玉之伤.进行[id].进程==5 then
			任务处理类:删除副本单位(id,1560,1564)
			local 任务id=id.."_1565_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9505 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="蛇王",
				模型="巴蛇",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=58,
				y=9,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1565
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9505,85,64) --跳转到动画地图
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.华光玉之伤.进行[id].进程==6 then
			任务处理类:删除副本单位(id,1560,1565)
			local 任务id=id.."_1566_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9504 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="燕晓",
				模型="飞燕女",
				锦衣="浮生绡·点黛",
				武器="浮犀",
				销毁=true,
				副本重置=true,
				x=304,
				y=317,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1566
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9504,238,269) --跳转到动画地图
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.华光玉之伤.进行[id].进程==7 then
		任务处理类:删除副本单位(id,1560,1567)
		local 任务id=玩家数据[id].角色:取任务(1560)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","神器·华光玉之伤（完）"}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			玩家数据[临时id].角色:取消任务(任务id)
			副本数据.神器任务.完成[临时id]=true
			地图处理类:跳转地图(id,1001,224,118)
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,false)--夜间关闭
		end
			抽奖处理:大转盘抽奖(id)
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="归墟副本结束",字体=nil,音乐=nil,背景=nil,横排显示=true,动画=nil})
		end
	end
end

function 副本_华光玉之伤:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,1560)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.华光玉之伤.进行[副本id].进程==1 then
		if 对话数据.名称=="燕晓" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.华光玉之伤.进行[副本id].进程==2 then
		if 对话数据.名称=="神秘人影" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.华光玉之伤.进行[副本id].进程==3 then
			if 对话数据.名称=="水涟漪" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.华光玉之伤.进行[副本id].进程==4 then
			if 对话数据.名称=="陆丝" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.华光玉之伤.进行[副本id].进程==5 then
			if 对话数据.名称=="蛇王" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.华光玉之伤.进行[副本id].进程==6 then
			if 对话数据.名称=="燕晓" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	end
	return 对话数据
end

function 副本_华光玉之伤:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,1560)
	if 类型 == 1561 and 名称=="燕晓" and  事件=="我来了" then
		if 副本数据.华光玉之伤.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170010,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1562 and 名称=="神秘人影" and  事件=="挑战你" then
		if 副本数据.华光玉之伤.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170011,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1563 and 名称=="水涟漪" and  事件=="挑战你" then
		if 副本数据.华光玉之伤.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170012,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1564 and 名称=="陆丝" and  事件=="挑战你" then
		if 副本数据.华光玉之伤.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170013,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1565 and 名称=="蛇王" and  事件=="挑战你" then
		if 副本数据.华光玉之伤.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170014,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1566 and 名称=="燕晓" and  事件=="挑战你" then
		if 副本数据.华光玉之伤.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170015,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_华光玉之伤:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,1560)
	if 副本id == 0 then return end
	if 战斗类型 == 170010 then
		副本数据.华光玉之伤.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务1560(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170011 then
		副本数据.华光玉之伤.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务1560(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170012 then
		副本数据.华光玉之伤.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务1560(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170013 then
		副本数据.华光玉之伤.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务1560(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170014 then
		副本数据.华光玉之伤.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务1560(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170015 then
		副本数据.华光玉之伤.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务1560(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_华光玉之伤:完成奖励(id组,战斗类型)
	if 战斗类型 == 170010 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local jlxs
			      if 玩家数据[cyid].角色.神器难度 == 1 then jlxs = 1
			elseif 玩家数据[cyid].角色.神器难度 == 2 then jlxs = 1.5
			elseif 玩家数据[cyid].角色.神器难度 == 3 then jlxs = 2
			elseif 玩家数据[cyid].角色.神器难度 == 4 then jlxs = 2.5
			elseif 玩家数据[cyid].角色.神器难度 == 5 then jlxs = 3
			end
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"华光玉之伤")
			玩家数据[cyid].角色:添加银子(银子,"华光玉之伤",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(华光玉之伤)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在华光玉之伤中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--百晓星君
	elseif 战斗类型 == 170011 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local jlxs
			      if 玩家数据[cyid].角色.神器难度 == 1 then jlxs = 1
			elseif 玩家数据[cyid].角色.神器难度 == 2 then jlxs = 1.5
			elseif 玩家数据[cyid].角色.神器难度 == 3 then jlxs = 2
			elseif 玩家数据[cyid].角色.神器难度 == 4 then jlxs = 2.5
			elseif 玩家数据[cyid].角色.神器难度 == 5 then jlxs = 3
			end
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"华光玉之伤")
			玩家数据[cyid].角色:添加银子(银子,"华光玉之伤",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(华光玉之伤)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在华光玉之伤中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--兰虎
	elseif 战斗类型 == 170012 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local jlxs
			    if 玩家数据[cyid].角色.神器难度 == 1 then jlxs = 1
			elseif 玩家数据[cyid].角色.神器难度 == 2 then jlxs = 1.5
			elseif 玩家数据[cyid].角色.神器难度 == 3 then jlxs = 2
			elseif 玩家数据[cyid].角色.神器难度 == 4 then jlxs = 2.5
			elseif 玩家数据[cyid].角色.神器难度 == 5 then jlxs = 3
			end
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"华光玉之伤")
			玩家数据[cyid].角色:添加银子(银子,"华光玉之伤",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(华光玉之伤)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在华光玉之伤中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170013 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local jlxs
			    if 玩家数据[cyid].角色.神器难度 == 1 then jlxs = 1
			elseif 玩家数据[cyid].角色.神器难度 == 2 then jlxs = 1.5
			elseif 玩家数据[cyid].角色.神器难度 == 3 then jlxs = 2
			elseif 玩家数据[cyid].角色.神器难度 == 4 then jlxs = 2.5
			elseif 玩家数据[cyid].角色.神器难度 == 5 then jlxs = 3
			end
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"华光玉之伤")
			玩家数据[cyid].角色:添加银子(银子,"华光玉之伤",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(华光玉之伤)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在华光玉之伤中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170014 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local jlxs
			    if 玩家数据[cyid].角色.神器难度 == 1 then jlxs = 1
			elseif 玩家数据[cyid].角色.神器难度 == 2 then jlxs = 1.5
			elseif 玩家数据[cyid].角色.神器难度 == 3 then jlxs = 2
			elseif 玩家数据[cyid].角色.神器难度 == 4 then jlxs = 2.5
			elseif 玩家数据[cyid].角色.神器难度 == 5 then jlxs = 3
			end
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"华光玉之伤")
			玩家数据[cyid].角色:添加银子(银子,"华光玉之伤",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(华光玉之伤)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在华光玉之伤中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170015 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local jlxs
			    if 玩家数据[cyid].角色.神器难度 == 1 then jlxs = 1
			elseif 玩家数据[cyid].角色.神器难度 == 2 then jlxs = 1.5
			elseif 玩家数据[cyid].角色.神器难度 == 3 then jlxs = 2
			elseif 玩家数据[cyid].角色.神器难度 == 4 then jlxs = 2.5
			elseif 玩家数据[cyid].角色.神器难度 == 5 then jlxs = 3
			end
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"华光玉之伤")
			玩家数据[cyid].角色:添加银子(银子,"华光玉之伤",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(华光玉之伤)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在华光玉之伤中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	end
end

function 副本_华光玉之伤:任务说明(玩家id,任务id,id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.华光玉之伤.进行[副本id]==nil then
		说明={"华光玉之伤","#L您的副本已经完成"}
	else
		local 进程=副本数据.华光玉之伤.进行[副本id].进程
		       if 进程==1 then
			说明={"神器·华光玉之伤",format("与".."#Y/qqq|燕晓*9504*临时npc*258*301/燕晓".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==2 then
			说明={"神器·华光玉之伤",format("与".."#Y/qqq|神秘人影*9505*临时npc*31*50/神秘人影".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==3 then
			说明={"神器·华光玉之伤",format("与".."#Y/qqq|水涟漪*9505*临时npc*8*8/水涟漪".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==4 then
			说明={"神器·华光玉之伤",format("与".."#Y/qqq|陆丝*9506*临时npc*39*10/陆丝".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==5 then
			说明={"神器·华光玉之伤",format("与".."#Y/qqq|蛇王*9505*临时npc*58*9/蛇王".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==6 then
			说明={"神器·华光玉之伤",format("与".."#Y/qqq|燕晓*9504*临时npc*304*317/燕晓".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}

		end
	end
	return 说明
end

return 副本_华光玉之伤
