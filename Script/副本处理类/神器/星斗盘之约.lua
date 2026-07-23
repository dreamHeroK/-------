
local 副本_星斗盘之约 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 副本_星斗盘之约:初始化()
	地图处理类.地图数据[9510]={npc={},单位={},传送圈={}} --蟠桃园
	地图处理类.地图玩家[9510]={}
	地图处理类.地图坐标[9510]=地图处理类.地图坐标[1231]
	地图处理类.地图单位[9510]={}
	地图处理类.单位编号[9510]=1000

	地图处理类.地图数据[9511]={npc={},单位={},传送圈={}} --海底迷宫5
	地图处理类.地图玩家[9511]={}
	地图处理类.地图坐标[9511]=地图处理类.地图坐标[1532]
	地图处理类.地图单位[9511]={}
	地图处理类.单位编号[9511]=1000

	地图处理类.地图数据[9512]={npc={},单位={},传送圈={}} --大雁塔3
	地图处理类.地图玩家[9512]={}
	地图处理类.地图坐标[9512]=地图处理类.地图坐标[1006]
	地图处理类.地图单位[9512]={}
	地图处理类.单位编号[9512]=1000

	地图处理类.地图数据[9513]={npc={},单位={},传送圈={}} --凤巢7
	地图处理类.地图玩家[9513]={}
	地图处理类.地图坐标[9513]=地图处理类.地图坐标[1192]
	地图处理类.地图单位[9513]={}
	地图处理类.单位编号[9513]=1000

	地图处理类.地图数据[9514]={npc={},单位={},传送圈={}} --墨家村
	地图处理类.地图玩家[9514]={}
	地图处理类.地图坐标[9514]=地图处理类.地图坐标[1218]
	地图处理类.地图单位[9514]={}
	地图处理类.单位编号[9514]=1000

	地图处理类.地图数据[9515]={npc={},单位={},传送圈={}} --地狱迷宫3
	地图处理类.地图玩家[9515]={}
	地图处理类.地图坐标[9515]=地图处理类.地图坐标[1129]
	地图处理类.地图单位[9515]={}
	地图处理类.单位编号[9515]=1000

	地图处理类.地图数据[9516]={npc={},单位={},传送圈={}} --大雁塔7
	地图处理类.地图玩家[9516]={}
	地图处理类.地图坐标[9516]=地图处理类.地图坐标[1009]
	地图处理类.地图单位[9516]={}
	地图处理类.单位编号[9516]=1000
end

function 副本_星斗盘之约:开启副本(id,nandu)
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
	local 难度 = nandu or 玩家数据[id].角色.神器难度 or 1
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 副本数据.神器任务.完成[临时id]~=nil then
		常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此神器任务了")
		return
		elseif 玩家数据[临时id].角色:取任务(1570)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行神器任务，无法领取新的神器任务")
			return
		end
		玩家数据[临时id].角色.神器难度 = 难度
	end
	if 副本数据.星斗盘之约.进行[id] == nil then
	副本数据.星斗盘之约.进行[id]={进程=1}
	end


	local 任务id,ZU=取唯一任务(1570,id)
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
		类型=1570
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了神器·星斗盘之约")
	刷新任务1570(id)
end

function 刷新任务1570(id)
	local id = 任务处理类:取副本id(id,1570)
	if 副本数据.星斗盘之约.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.星斗盘之约.进行[id].进程==1 then
		local 地图=9510 --蟠桃园
		local 任务id=id.."_1571_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="幻境守卫",
			模型="薛礼",
			x=135,
			y=27,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1571
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9510,98,47) --跳转到动画地图
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.星斗盘之约.进行[id].进程==2 then
		任务处理类:删除副本单位(id,1570,1571)
		local 地图=9511 --海底迷宫5
		local 任务id=id.."_1572_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="箕水豹",
			模型="狂豹兽形",
			x=40,
			y=12,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1572
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9511,24,39) --跳转到动画地图
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.星斗盘之约.进行[id].进程==3 then
			任务处理类:删除副本单位(id,1570,1572)
			local 任务id=id.."_1573_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9512 --大雁塔3
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="亢金龙",
				模型="蛟龙",
				销毁=true,
				副本重置=true,
				x=65,
				y=42,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1573
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9512,63,64) --跳转到动画地图
		 	for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 	end
	elseif 副本数据.星斗盘之约.进行[id].进程==4 then
			任务处理类:删除副本单位(id,1570,1573)
			local 任务id=id.."_1574_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9513 --凤巢7
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="机关核心",
				模型="机关人车形",
				销毁=true,
				副本重置=true,
				x=67,
				y=24,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1574
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9513,55,60) --跳转到动画地图
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 	end
	elseif 副本数据.星斗盘之约.进行[id].进程==5 then
			任务处理类:删除副本单位(id,1570,1574)
			local 任务id=id.."_1575_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9514 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="斗木獬",
				模型="大力金刚",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=14,
				y=45,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1575
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9514,42,13) --跳转到动画地图
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 	end
	elseif 副本数据.星斗盘之约.进行[id].进程==6 then
			任务处理类:删除副本单位(id,1570,1575)
			local 任务id=id.."_1576_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9515 --地狱迷宫3
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="氐士貂",
				模型="锦毛貂精",
				销毁=true,
				副本重置=true,
				x=49,
				y=66,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1576
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9515,15,25) --跳转到动画地图
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 	end
	elseif 副本数据.星斗盘之约.进行[id].进程==7 then
			任务处理类:删除副本单位(id,1570,1576)
			local 任务id=id.."_1577_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9516 --大雁塔7
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="白衣剑客",
				模型="剑侠客",
				染色方案=1,
				染色组={3,3,3},
				武器="霜冷九州",
				销毁=true,
				副本重置=true,
				x=42,
				y=44,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1577
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9516,21,42) --跳转到动画地图
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 	end
	elseif 副本数据.星斗盘之约.进行[id].进程==8 then
			任务处理类:删除副本单位(id,1570,1577)
			local 任务id=id.."_1578_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9516 --大雁塔7
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="阵眼",
				模型="蜃气妖",
				销毁=true,
				副本重置=true,
				x=61,
				y=31,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1578
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.星斗盘之约.进行[id].进程==9 then
			任务处理类:删除副本单位(id,1570,1578)
			local 任务id=id.."_1579_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9516 --大雁塔7
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="阴阳仙人",
				模型="进阶修罗傀儡妖",
				销毁=true,
				副本重置=true,
				x=36,
				y=22,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1579
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.星斗盘之约.进行[id].进程==10 then
		任务处理类:删除副本单位(id,1570,1579)
		local 任务id=玩家数据[id].角色:取任务(1570)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","神器·星斗盘之约（完）"}
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

function 副本_星斗盘之约:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,1570)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.星斗盘之约.进行[副本id].进程==1 then
		if 对话数据.名称=="幻境守卫" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==2 then
		if 对话数据.名称=="箕水豹" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==3 then
			if 对话数据.名称=="亢金龙" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==4 then
			if 对话数据.名称=="机关核心" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==5 then
			if 对话数据.名称=="斗木獬" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==6 then
			if 对话数据.名称=="氐士貂" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==7 then
			if 对话数据.名称=="白衣剑客" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==8 then
			if 对话数据.名称=="阵眼" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.星斗盘之约.进行[副本id].进程==9 then
			if 对话数据.名称=="阴阳仙人" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	end
	return 对话数据
end

function 副本_星斗盘之约:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,1570)
	if 类型 == 1571 and 名称=="幻境守卫" and  事件=="我来了" then
		if 副本数据.星斗盘之约.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170020,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1572 and 名称=="箕水豹" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170021,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1573 and 名称=="亢金龙" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170022,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1574 and 名称=="机关核心" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170023,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1575 and 名称=="斗木獬" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170024,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1576 and 名称=="氐士貂" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170025,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1577 and 名称=="白衣剑客" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==7 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170026,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1578 and 名称=="阵眼" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==8 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170027,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1579 and 名称=="阴阳仙人" and  事件=="挑战你" then
		if 副本数据.星斗盘之约.进行[副本id].进程==9 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170028,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_星斗盘之约:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,1570)
	if 副本id == 0 then return end
	if 战斗类型 == 170020 then
		副本数据.星斗盘之约.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170021 then
		副本数据.星斗盘之约.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170022 then
		副本数据.星斗盘之约.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170023 then
		副本数据.星斗盘之约.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170024 then
		副本数据.星斗盘之约.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170025 then
		副本数据.星斗盘之约.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170026 then
		副本数据.星斗盘之约.进行[副本id]={进程=8}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170027 then
		副本数据.星斗盘之约.进行[副本id]={进程=9}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170028 then
		副本数据.星斗盘之约.进行[副本id]={进程=10}
		任务数据[任务id].zhandou = nil
		刷新任务1570(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_星斗盘之约:完成奖励(id组,战斗类型)
	if 战斗类型 == 170020 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--百晓星君
	elseif 战斗类型 == 170021 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--兰虎
	elseif 战斗类型 == 170022 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170023 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170024 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170025 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170026 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170027 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 170028 then
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
			玩家数据[cyid].角色:添加经验(经验,"星斗盘之约")
			玩家数据[cyid].角色:添加银子(银子,"星斗盘之约",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(星斗盘之约)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在星斗盘之约中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="6级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="7级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--郑镖头
	end
end

function 副本_星斗盘之约:任务说明(玩家id,任务id,id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.星斗盘之约.进行[副本id]==nil then
		说明={"星斗盘之约","#L您的副本已经完成"}
	else
		local 进程=副本数据.星斗盘之约.进行[副本id].进程
		       if 进程==1 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|幻境守卫*9510*临时npc*135*27/幻境守卫".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==2 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|箕水豹*9511*临时npc*40*12/箕水豹".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==3 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|亢金龙*9512*临时npc*65*42/亢金龙".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==4 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|机关核心*9513*临时npc*67*24/机关核心".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==5 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|斗木獬*9514*临时npc*14*45/斗木獬".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==6 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|氐士貂*9515*临时npc*49*66/氐士貂".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==7 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|白衣剑客*9516*临时npc*42*44/白衣剑客".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==8 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|阵眼*9516*临时npc*61*31/阵眼".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==9 then
			说明={"神器·星斗盘之约",format("与".."#Y/qqq|阴阳仙人*9516*临时npc*36*22/阴阳仙人".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}


		end
	end
	return 说明
end

return 副本_星斗盘之约
