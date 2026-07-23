
local 副本_玲珑结之愿 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 副本_玲珑结之愿:初始化()
	地图处理类.地图数据[9548]={npc={},单位={},传送圈={}} --长安城
	地图处理类.地图玩家[9548]={}
	地图处理类.地图坐标[9548]=地图处理类.地图坐标[1001]
	地图处理类.地图单位[9548]={}
	地图处理类.单位编号[9548]=1000

	地图处理类.地图数据[9549]={npc={},单位={},传送圈={}} --官府地牢
	地图处理类.地图玩家[9549]={}
	地图处理类.地图坐标[9549]=地图处理类.地图坐标[1051]
	地图处理类.地图单位[9549]={}
	地图处理类.单位编号[9549]=1000

	地图处理类.地图数据[9550]={npc={},单位={},传送圈={}} --巢穴深处
	地图处理类.地图玩家[9550]={}
	地图处理类.地图坐标[9550]=地图处理类.地图坐标[1213]
	地图处理类.地图单位[9550]={}
	地图处理类.单位编号[9550]=1000

end

function 副本_玲珑结之愿:开启副本(id,nandu)
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
		常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过神器任务了")
		return
		elseif 玩家数据[临时id].角色:取任务(1640)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行神器任务，无法领取新的神器任务")
			return
		end
		玩家数据[临时id].角色.神器难度 = 难度
	end
	if 副本数据.玲珑结之愿.进行[id] == nil then
	副本数据.玲珑结之愿.进行[id]={进程=1}
	end


	local 任务id,ZU=取唯一任务(1640,id)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=72000,
		玩家id=0,
		DWZ=ZU,
		销毁=true,
		副本重置=true,
		队伍组=ZU,
		副本id=id,
		PlayerGroup = table.copy(队伍数据[队伍id].成员数据),
		类型=1640
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了神器·玲珑结之愿")
	刷新任务1640(id)
end

function 刷新任务1640(id)
	local id = 任务处理类:取副本id(id,1640)
	if 副本数据.玲珑结之愿.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.玲珑结之愿.进行[id].进程==1 then
		local 地图=9548 --蟠桃园
		local 任务id=id.."_1641_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="怨灵",
			模型="野鬼",
			x=414,
			y=78,
			方向=1,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1641
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9548,383,54) --跳转到动画地图
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.玲珑结之愿.进行[id].进程==2 then
		任务处理类:删除副本单位(id,1640,1641)
		local 地图=9548 --海底迷宫5
		local 任务id=id.."_1642_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="怨灵",
			模型="牛头",
			x=374,
			y=101,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1642
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.玲珑结之愿.进行[id].进程==3 then
			任务处理类:删除副本单位(id,1640,1642)
			local 任务id=id.."_1643_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9548 --比武场
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="怨灵",
				模型="夜罗刹",
				销毁=true,
				副本重置=true,
				x=306,
				y=134,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1643
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.玲珑结之愿.进行[id].进程==4 then
			任务处理类:删除副本单位(id,1640,1643)
			local 任务id=id.."_1644_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9548 --国境
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="怨灵",
				模型="画魂",
				销毁=true,
				副本重置=true,
				x=212,
				y=180,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1644
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.玲珑结之愿.进行[id].进程==5 then
			任务处理类:删除副本单位(id,1640,1644)
			local 任务id=id.."_1645_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9548 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="虚弱的怨灵",
				模型="画魂",
				销毁=true,
				副本重置=true,
				x=150,
				y=213,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1645
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.玲珑结之愿.进行[id].进程==6 then
			任务处理类:删除副本单位(id,1640,1645)
			local 任务id=id.."_1646_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9549 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="侍卫统领",
				模型="巡游天神",
				销毁=true,
				副本重置=true,
				x=264,
				y=193,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1646
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9549,327,195) --跳转到动画地图
		 for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 end
	elseif 副本数据.玲珑结之愿.进行[id].进程==7 then
			任务处理类:删除副本单位(id,1640,1646)
			local 任务id=id.."_1647_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9549 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="柳妃",
				模型="雨师妾",
				销毁=true,
				副本重置=true,
				x=213,
				y=100,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1647
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.玲珑结之愿.进行[id].进程==8 then
			任务处理类:删除副本单位(id,1640,1647)
			local 任务id=id.."_1648_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9550 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="杨歧",
				模型="地狱战神",
				销毁=true,
				副本重置=true,
				x=29,
				y=137,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1648
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9550,71,184) --跳转到动画地图
			for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 end
	elseif 副本数据.玲珑结之愿.进行[id].进程==9 then
			任务处理类:删除副本单位(id,1640,1648)
			local 任务id=id.."_1649_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9550 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="柳妃",
				模型="雨师妾",
				销毁=true,
				副本重置=true,
				x=84,
				y=63,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1649
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.玲珑结之愿.进行[id].进程==10 then
		任务处理类:删除副本单位(id,1640,1649)
		local 任务id=玩家数据[id].角色:取任务(1640)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","神器·玲珑结之愿（完）"}
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

function 副本_玲珑结之愿:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,1640)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.玲珑结之愿.进行[副本id].进程==1 then
		if 对话数据.名称=="怨灵" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==2 then
		if 对话数据.名称=="怨灵" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==3 then
			if 对话数据.名称=="怨灵" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
				end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==4 then
			if 对话数据.名称=="怨灵" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
				end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==5 then
			if 对话数据.名称=="虚弱的怨灵" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
				end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==6 then
			if 对话数据.名称=="侍卫统领" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
				end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==7 then
			if 对话数据.名称=="柳妃" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
				end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==8 then
			if 对话数据.名称=="杨歧" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
				end
	elseif 副本数据.玲珑结之愿.进行[副本id].进程==9 then
			if 对话数据.名称=="柳妃" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
				end
	end
	return 对话数据
end

function 副本_玲珑结之愿:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,1640)
	if 类型 == 1641 and 名称=="怨灵" and  事件=="我来了" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170090,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1642 and 名称=="怨灵" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170091,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1643 and 名称=="怨灵" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170092,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1644 and 名称=="怨灵" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170093,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1645 and 名称=="虚弱的怨灵" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170094,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1646 and 名称=="侍卫统领" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170095,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1647 and 名称=="柳妃" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==7 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170096,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1648 and 名称=="杨歧" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==8 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170097,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1649 and 名称=="柳妃" and  事件=="挑战你" then
		if 副本数据.玲珑结之愿.进行[副本id].进程==9 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			if 玩家数据[id].zhandou~=0 then 常规提示(id,"#Y/你当前战斗状态异常，请稍后再试") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170098,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_玲珑结之愿:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,1640)
	if 副本id == 0 then return end
	if 战斗类型 == 170090 then
		副本数据.玲珑结之愿.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170091 then
		副本数据.玲珑结之愿.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170092 then
		副本数据.玲珑结之愿.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170093 then
		副本数据.玲珑结之愿.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170094 then
		副本数据.玲珑结之愿.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170095 then
		副本数据.玲珑结之愿.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170096 then
		副本数据.玲珑结之愿.进行[副本id]={进程=8}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170097 then
		副本数据.玲珑结之愿.进行[副本id]={进程=9}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170098 then
		副本数据.玲珑结之愿.进行[副本id]={进程=10}
		任务数据[任务id].zhandou = nil
		刷新任务1640(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_玲珑结之愿:完成奖励(id组,战斗类型)
	if 战斗类型 == 170090 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170091 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170092 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170093 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170094 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170095 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170096 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170097 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170098 then
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
			local BL = 玩家数据[cyid].角色.神器难度 * 5 + 20
			local 经验=等级*取随机数(2650,4100)+500000*jlxs
			local 银子=等级*取随机数(110,120)+50000*jlxs
			local 积分=10*jlxs
			玩家数据[cyid].角色:添加经验(经验,"玲珑结之愿")
			玩家数据[cyid].角色:添加银子(银子,"玲珑结之愿",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(玲珑结之愿)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在玲珑结之愿中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	end
end

function 副本_玲珑结之愿:任务说明(玩家id,任务id,id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.玲珑结之愿.进行[副本id]==nil then
		说明={"玲珑结之愿","#L您的副本已经完成"}
	else
		local 进程=副本数据.玲珑结之愿.进行[副本id].进程
		       if 进程==1 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|怨灵*9548*临时npc*414*78/怨灵".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==2 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|怨灵*9548*临时npc*374*101/怨灵".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==3 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|怨灵*9548*临时npc*306*134/怨灵".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==4 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|怨灵*9548*临时npc*212*180/怨灵".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==5 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|虚弱的怨灵*9548*临时npc*150*213/虚弱的怨灵".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==6 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|侍卫统领*9549*临时npc*264*193/侍卫统领".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==7 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|柳妃*9549*临时npc*213*100/柳妃".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==8 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|杨歧*9550*临时npc*29*137/杨歧".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==9 then
			说明={"神器·玲珑结之愿",format("与".."#Y/qqq|柳妃*9550*临时npc*84*63/柳妃".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}

		end
	end
	return 说明
end

return 副本_玲珑结之愿
