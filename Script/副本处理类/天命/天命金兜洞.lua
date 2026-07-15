
local 副本_天命金兜洞 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数


function 副本_天命金兜洞:初始化()
	地图处理类.地图数据[8515]={npc={},单位={},传送圈={}} --太岁府
	地图处理类.地图玩家[8515]={}
	地图处理类.地图坐标[8515]=地图处理类.地图坐标[1211]
	地图处理类.地图单位[8515]={}
	地图处理类.单位编号[8515]=1000

	地图处理类.地图数据[8516]={npc={},单位={},传送圈={}} --雷音寺
	地图处理类.地图玩家[8516]={}
	地图处理类.地图坐标[8516]=地图处理类.地图坐标[1204]
	地图处理类.地图单位[8516]={}
	地图处理类.单位编号[8516]=1000

	地图处理类.地图数据[8517]={npc={},单位={},传送圈={}} --凌霄宝殿
	地图处理类.地图玩家[8517]={}
	地图处理类.地图坐标[8517]=地图处理类.地图坐标[1112]
	地图处理类.地图单位[8517]={}
	地图处理类.单位编号[8517]=1000

end

function 副本_天命金兜洞:开启副本(id)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<5 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	elseif 取等级要求(id,50)==false then
		常规提示(id,"#Y此副本要求角色等级不能低于50级")
		return
	end
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 副本数据.天命金兜洞.完成[临时id]~=nil then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
			return
		elseif 玩家数据[临时id].角色:取任务(3030)~=0 then
		local 副本id=任务数据[玩家数据[id].角色:取任务(3030)].副本id
		local 进程=副本数据.天命金兜洞.进行[副本id].进程
		local 地图=8515
		local x=0
		local y=0
		if 进程<4 then
			x,y=50,91
		elseif 进程== 4 or 进程== 5 then
			地图=8516
			x,y=164,126
		elseif 进程== 6 or 进程== 7 or 进程== 8  then
			地图=8517
			x,y=164,126
		elseif 进程>= 9  then
			地图=8515
			x,y=50,91

		end
		地图处理类:跳转地图(id,地图,x,y)
			--常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行副本任务，无法领取新的副本")
			return
		end
	end
	副本数据.天命金兜洞.进行[id]={进程=1,数量=0}
	local 任务id,ZU=取唯一任务(3030,id)
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
		类型=3030
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了天命金兜洞副本")
	刷新任务3030(id)
end

function 刷新任务3030(id)
	local id = 任务处理类:取副本id(id,3030)
	if 副本数据.天命金兜洞.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.天命金兜洞.进行[id].进程==1 then
		local 地图=8515 --长安城
		local 任务id=id.."_3031_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="金兜洞杂妖",
			模型="巨蛙",
			x=22,
			y=66,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3031
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.天命金兜洞.进行[id].进程==2 then
		任务处理类:删除副本单位(id,3030,3031)
		local 地图=8515 --长安城
		local 任务id=id.."_3032_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="金兜洞喽啰",
			模型="花妖",
			显示饰品=true,
			x=7,
			y=20,
			方向=4,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3032
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.天命金兜洞.进行[id].进程==3 then
			任务处理类:删除副本单位(id,3030,3032)
			local 任务id=id.."_3033_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8515 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="兕大王",
				模型="牛魔王",
				销毁=true,
				副本重置=true,
				显示饰品=true,
				x=40,
				y=24,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3033
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命金兜洞.进行[id].进程==4 then
			任务处理类:删除副本单位(id,3030,3033)
			local 任务id=id.."_3034_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8516 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="貂鼠",
				模型="锦毛貂精",
				销毁=true,
				副本重置=true,
				x=128,
				y=92,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3034
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8516,164,126) --跳转到动画地图
	elseif 副本数据.天命金兜洞.进行[id].进程==5 then
			任务处理类:删除副本单位(id,3030,3034)
			local 任务id=id.."_3035_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8516 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="天命貂鼠",
				模型="进阶锦毛貂精",
				销毁=true,
				副本重置=true,
				x=81,
				y=35,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3035
			}
			地图处理类:添加单位(任务id)
			--地图处理类:跳转地图(id,8502,29,56) --跳转到动画地图
	elseif 副本数据.天命金兜洞.进行[id].进程==6 then
			任务处理类:删除副本单位(id,3030,3035)
			local 任务id=id.."_3036_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8517 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="哪吒",
				模型="男人_哪吒",
				销毁=true,
				副本重置=true,
				x=67,
				y=48,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3036
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8517,76,58) --跳转到动画地图
	elseif 副本数据.天命金兜洞.进行[id].进程==7 then
			任务处理类:删除副本单位(id,3030,3036)
			local 任务id=id.."_3037_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8517 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="玉皇大帝",
				模型="男人_玉帝",
				销毁=true,
				副本重置=true,
				x=31,
				y=32,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3037
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命金兜洞.进行[id].进程==8 then
			任务处理类:删除副本单位(id,3030,3037)
			local 任务id=id.."_3038_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8515 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="金兜洞强妖",
				模型="白熊",
				销毁=true,
				副本重置=true,
				x=36,
				y=67,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3038
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8515,49,90)
	elseif 副本数据.天命金兜洞.进行[id].进程==9 then
			任务处理类:删除副本单位(id,3030,3038)
			local 任务id=id.."_3039_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8515 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="金兜洞头目",
				模型="炎魔神",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=31,
				y=53,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3039
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命金兜洞.进行[id].进程==10 then
			任务处理类:删除副本单位(id,3030,3039)
			local 任务id=id.."_3040_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8515 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="假兕大王",
				模型="牛妖",
				销毁=true,
				副本重置=true,
				x=36,
				y=21,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3040
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命金兜洞.进行[id].进程==11 then
			任务处理类:删除副本单位(id,3030,3040)
			local 任务id=id.."_3041_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8515 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="天命兕大王",
				模型="牛魔王",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=39,
				y=24,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3041
			}
			地图处理类:添加单位(任务id)


	elseif 副本数据.天命金兜洞.进行[id].进程==12 then
		任务处理类:删除副本单位(id,3030,3041)
		local 任务id=玩家数据[id].角色:取任务(3030)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","天命金兜洞副本（完）"}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			玩家数据[临时id].角色:取消任务(任务id)
			副本数据.天命金兜洞.完成[临时id]=true
			抽奖处理:转盘抽奖(id)
			地图处理类:跳转地图(id,1001,224,118)
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="归墟副本结束",字体=nil,音乐=nil,背景=nil,横排显示=true,动画=nil})
		end
	end
end

function 副本_天命金兜洞:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,3030)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.天命金兜洞.进行[副本id].进程==1 then
		if 对话数据.名称=="金兜洞杂妖" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==2 then
		if 对话数据.名称=="金兜洞喽啰" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==3 then
			if 对话数据.名称=="兕大王" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==4 then
			if 对话数据.名称=="貂鼠" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==5 then
			if 对话数据.名称=="天命貂鼠" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==6 then
			if 对话数据.名称=="哪吒" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==7 then
			if 对话数据.名称=="玉皇大帝" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==8 then
			if 对话数据.名称=="金兜洞强妖" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==9 then
			if 对话数据.名称=="金兜洞头目" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==10 then
			if 对话数据.名称=="假兕大王" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命金兜洞.进行[副本id].进程==11 then
			if 对话数据.名称=="天命兕大王" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	end
	return 对话数据
end

function 副本_天命金兜洞:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,3030)
	if 类型 == 3031 and 名称=="金兜洞杂妖" and  事件=="我来了" then
		if 副本数据.天命金兜洞.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105051,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3032 and 名称=="金兜洞喽啰" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105052,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3033 and 名称=="兕大王" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105053,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3034 and 名称=="貂鼠" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105054,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3035 and 名称=="天命貂鼠" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105055,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3036 and 名称=="哪吒" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105056,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3037 and 名称=="玉皇大帝" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==7 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105057,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3038 and 名称=="金兜洞强妖" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==8 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105058,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3039 and 名称=="金兜洞头目" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==9 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105059,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3040 and 名称=="假兕大王" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==10 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105060,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3041 and 名称=="天命兕大王" and  事件=="挑战你" then
		if 副本数据.天命金兜洞.进行[副本id].进程==11 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105061,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_天命金兜洞:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,3030)
	if 副本id == 0 then return end
	if 战斗类型 == 105051 then
		副本数据.天命金兜洞.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105052 then
		副本数据.天命金兜洞.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105053 then
		副本数据.天命金兜洞.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105054 then
		副本数据.天命金兜洞.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105055 then
		副本数据.天命金兜洞.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105056 then
		副本数据.天命金兜洞.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105057 then
		副本数据.天命金兜洞.进行[副本id]={进程=8}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105058 then
		副本数据.天命金兜洞.进行[副本id]={进程=9}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105059 then
		副本数据.天命金兜洞.进行[副本id]={进程=10}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105060 then
		副本数据.天命金兜洞.进行[副本id]={进程=11}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105061 then
		副本数据.天命金兜洞.进行[副本id]={进程=12}
		任务数据[任务id].zhandou = nil
		刷新任务3030(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_天命金兜洞:完成奖励(id组,战斗类型)
	if 战斗类型 == 105051 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--百晓星君
	elseif 战斗类型 == 105052 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
       				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
       				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--兰虎
	elseif 战斗类型 == 105053 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105054 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105055 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105056 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105057 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105058 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105059 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105060 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	elseif 战斗类型 == 105061 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			玩家数据[cyid].角色:添加经验(经验,"天命金兜洞")
			玩家数据[cyid].角色:添加银子(银子,"天命金兜洞",1)
			玩家数据[cyid].角色:添加副本积分(200)
			添加活跃(cyid,10)
			更新玩家每日(cyid,"副本任务","天命金兜洞")
			if 取随机数()<=45 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命金兜洞)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命金兜洞中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特殊魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=8 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				end
			end
		end--郑镖头
	end
end

function 副本_天命金兜洞:任务说明(玩家id,任务id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.天命金兜洞.进行[副本id]==nil then
		说明={"天命金兜洞","#W您的副本已经完成"}
	else
		local 进程=副本数据.天命金兜洞.进行[副本id].进程
		       if 进程==1 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|金兜洞杂妖*8515*临时npc*22*66/金兜洞杂妖".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==2 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|金兜洞喽啰*8515*临时npc*7*20/金兜洞喽啰".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==3 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|兕大王*8515*临时npc*40*24/兕大王".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==4 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|貂鼠*8516*临时npc*128*92/貂鼠".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==5 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命貂鼠*8516*临时npc*81*35/天命貂鼠".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==6 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|哪吒*8517*临时npc*67*48/哪吒".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==7 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|玉皇大帝*8517*临时npc*31*32/玉皇大帝".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==8 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|金兜洞强妖*8515*临时npc*36*67/金兜洞强妖".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==9 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|金兜洞头目*8515*临时npc*31*53/金兜洞头目".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==10 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|假兕大王*8515*临时npc*36*21/假兕大王".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==11 then
			说明={"副本·天命金兜洞",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命兕大王*8515*临时npc*39*24/天命兕大王".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		end
	end
	return 说明
end

return 副本_天命金兜洞
