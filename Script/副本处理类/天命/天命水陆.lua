
local 副本_天命水陆 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数


function 副本_天命水陆:初始化()
	地图处理类.地图数据[8518]={npc={},单位={},传送圈={}} --太岁府
	地图处理类.地图玩家[8518]={}
	地图处理类.地图坐标[8518]=地图处理类.地图坐标[1002]
	地图处理类.地图单位[8518]={}
	地图处理类.单位编号[8518]=1000

	地图处理类.地图数据[8519]={npc={},单位={},传送圈={}} --雷音寺
	地图处理类.地图玩家[8519]={}
	地图处理类.地图坐标[8519]=地图处理类.地图坐标[1001]
	地图处理类.地图单位[8519]={}
	地图处理类.单位编号[8519]=1000

	地图处理类.地图数据[8520]={npc={},单位={},传送圈={}} --凌霄宝殿
	地图处理类.地图玩家[8520]={}
	地图处理类.地图坐标[8520]=地图处理类.地图坐标[1211]
	地图处理类.地图单位[8520]={}
	地图处理类.单位编号[8520]=1000

end

function 副本_天命水陆:开启副本(id)
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
		if 副本数据.天命水陆.完成[临时id]~=nil then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
			return
		elseif 玩家数据[临时id].角色:取任务(3050)~=0 then
		local 副本id=任务数据[玩家数据[id].角色:取任务(3050)].副本id
		local 进程=副本数据.天命水陆.进行[副本id].进程
		local 地图=8518
		local x=0
		local y=0
		if 进程== 1 or 进程== 2 then
			x,y=13,85
		elseif 进程== 3 or 进程== 4 then
			地图=8519
			x,y=379,208
		elseif 进程== 5 or 进程== 6 then
			地图=8518
			x,y=13,85
		elseif 进程>= 7  then
			地图=8520
			x,y=50,91
		end
		地图处理类:跳转地图(id,地图,x,y)
			--常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行副本任务，无法领取新的副本")
			return
		end
	end
	副本数据.天命水陆.进行[id]={进程=1,数量=0}
	local 任务id,ZU=取唯一任务(3050,id)
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
		类型=3050
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了天命水陆副本")
	刷新任务3050(id)
end

function 刷新任务3050(id)
	local id = 任务处理类:取副本id(id,3050)
	if 副本数据.天命水陆.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.天命水陆.进行[id].进程==1 then
		local 地图=8518 --长安城
		local 任务id=id.."_3055_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="桃树",
			模型="桃树",
			x=93,
			y=17,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3055
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.天命水陆.进行[id].进程==2 then
		任务处理类:删除副本单位(id,3050,3055)
		local 地图=8518 --长安城
		local 任务id=id.."_3056_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="蟠桃树",
			模型="桃树",
			x=121,
			y=28,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3056
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.天命水陆.进行[id].进程==3 then
			任务处理类:删除副本单位(id,3050,3056)
			local 任务id=id.."_3057_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8519 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="九环锡杖",
				模型="空度禅师",
				销毁=true,
				副本重置=true,
				x=433,
				y=222,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3057
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8519,379,208) --跳转到动画地图
	elseif 副本数据.天命水陆.进行[id].进程==4 then
			任务处理类:删除副本单位(id,3050,3057)
			local 任务id=id.."_3058_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8519 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="袈裟",
				模型="空度禅师",
				销毁=true,
				副本重置=true,
				x=472,
				y=241,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3058
			}
			地图处理类:添加单位(任务id)
			--地图处理类:跳转地图(id,8516,164,126) --跳转到动画地图
	elseif 副本数据.天命水陆.进行[id].进程==5 then
			任务处理类:删除副本单位(id,3050,3058)
			local 任务id=id.."_3059_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8518 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="虎将军",
				模型="噬天虎",
				销毁=true,
				副本重置=true,
				x=113,
				y=11,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3059
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8518,10,88) --跳转到动画地图
	elseif 副本数据.天命水陆.进行[id].进程==6 then
			任务处理类:删除副本单位(id,3050,3059)
			local 任务id=id.."_3060_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8518 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="翼将军",
				模型="律法女娲",
				销毁=true,
				副本重置=true,
				x=121,
				y=14,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3060
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命水陆.进行[id].进程==7 then
			任务处理类:删除副本单位(id,3050,3060)
			local 任务id=id.."_3061_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8520 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="巡山小妖",
				模型="鼠先锋",
				销毁=true,
				副本重置=true,
				x=34,
				y=85,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3061
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8520,52,90) --跳转到动画地图
	elseif 副本数据.天命水陆.进行[id].进程==8 then
			任务处理类:删除副本单位(id,3050,3061)
			local 任务id=id.."_3062_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8520 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="上古妖兽头领",
				模型="地狱战神",
				销毁=true,
				副本重置=true,
				x=32,
				y=66,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3062
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命水陆.进行[id].进程==9 then
			任务处理类:删除副本单位(id,3050,3062)
			local 任务id=id.."_3063_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8520 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="天命妖王",
				模型="炎魔神",
				销毁=true,
				副本重置=true,
				x=10,
				y=20,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3063
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命水陆.进行[id].进程==10 then
			任务处理类:删除副本单位(id,3050,3063)
			local 任务id=id.."_3064_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8520 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="魑魅",
				模型="帮派妖兽",
				销毁=true,
				副本重置=true,
				x=40,
				y=16,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3064
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.天命水陆.进行[id].进程==11 then
			任务处理类:删除副本单位(id,3050,3064)
			local 任务id=id.."_3065_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8520 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="魍魉",
				模型="帮派妖兽",
				销毁=true,
				副本重置=true,
				x=49,
				y=20,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3065
			}
			地图处理类:添加单位(任务id)


	elseif 副本数据.天命水陆.进行[id].进程==12 then
		任务处理类:删除副本单位(id,3050,3065)
		local 任务id=玩家数据[id].角色:取任务(3050)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","天命水陆副本（完）"}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			玩家数据[临时id].角色:取消任务(任务id)
			副本数据.天命水陆.完成[临时id]=true
			抽奖处理:转盘抽奖(id)
			地图处理类:跳转地图(id,1001,224,118)
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="归墟副本结束",字体=nil,音乐=nil,背景=nil,横排显示=true,动画=nil})
		end
	end
end

function 副本_天命水陆:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,3050)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.天命水陆.进行[副本id].进程==1 then
		if 对话数据.名称=="桃树" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.天命水陆.进行[副本id].进程==2 then
		if 对话数据.名称=="蟠桃树" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.天命水陆.进行[副本id].进程==3 then
			if 对话数据.名称=="九环锡杖" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==4 then
			if 对话数据.名称=="袈裟" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==5 then
			if 对话数据.名称=="虎将军" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==6 then
			if 对话数据.名称=="翼将军" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==7 then
			if 对话数据.名称=="巡山小妖" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==8 then
			if 对话数据.名称=="上古妖兽头领" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==9 then
			if 对话数据.名称=="天命妖王" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==10 then
			if 对话数据.名称=="魑魅" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命水陆.进行[副本id].进程==11 then
			if 对话数据.名称=="魍魉" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	end
	return 对话数据
end

function 副本_天命水陆:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,3050)
	if 类型 == 3055 and 名称=="桃树" and  事件=="我来了" then
		if 副本数据.天命水陆.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105071,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3056 and 名称=="蟠桃树" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105072,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3057 and 名称=="九环锡杖" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105073,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3058 and 名称=="袈裟" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105074,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3059 and 名称=="虎将军" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105075,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3060 and 名称=="翼将军" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105076,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3061 and 名称=="巡山小妖" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==7 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105077,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3062 and 名称=="上古妖兽头领" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==8 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105078,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3063 and 名称=="天命妖王" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==9 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105079,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3064 and 名称=="魑魅" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==10 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105080,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3065 and 名称=="魍魉" and  事件=="挑战你" then
		if 副本数据.天命水陆.进行[副本id].进程==11 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105081,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_天命水陆:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,3050)
	if 副本id == 0 then return end
	if 战斗类型 == 105071 then
		副本数据.天命水陆.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105072 then
		副本数据.天命水陆.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105073 then
		副本数据.天命水陆.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105074 then
		副本数据.天命水陆.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105075 then
		副本数据.天命水陆.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105076 then
		副本数据.天命水陆.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105077 then
		副本数据.天命水陆.进行[副本id]={进程=8}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105078 then
		副本数据.天命水陆.进行[副本id]={进程=9}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105079 then
		副本数据.天命水陆.进行[副本id]={进程=10}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105080 then
		副本数据.天命水陆.进行[副本id]={进程=11}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105081 then
		副本数据.天命水陆.进行[副本id]={进程=12}
		任务数据[任务id].zhandou = nil
		刷新任务3050(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_天命水陆:完成奖励(id组,战斗类型)
	if 战斗类型 == 105071 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=3 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
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
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105072 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="神兜兜"
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
	elseif 战斗类型 == 105073 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105074 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105075 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105076 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105077 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=33 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="易经丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105078 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=33 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
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
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105079 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=20 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105080 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
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
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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
	elseif 战斗类型 == 105081 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命水陆",1)
			玩家数据[cyid].角色:添加经验(经验,"天命水陆")
			玩家数据[cyid].角色:添加银子(银子,"天命水陆",1)
			玩家数据[cyid].角色:添加副本积分(200)
			添加活跃(cyid,10)
			更新玩家每日(cyid,"副本任务","天命水陆")

			if 取随机数()<=50 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命水陆)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命水陆中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=5 then
					local 名称="特殊魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=8 then
					local 名称="特效宝珠"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
        				elseif 奖励参数<=10 then
					local 名称="星辉石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=18 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
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
					local 名称="符石卷轴"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="符石卷轴"
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

function 副本_天命水陆:任务说明(玩家id,任务id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.天命水陆.进行[副本id]==nil then
		说明={"天命水陆","#W您的副本已经完成"}
	else
		local 进程=副本数据.天命水陆.进行[副本id].进程
		       if 进程==1 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|桃树*8518*临时npc*93*17/桃树".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==2 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|蟠桃树*8518*临时npc*121*28/蟠桃树".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==3 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|九环锡杖*8519*临时npc*433*222/九环锡杖".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==4 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|袈裟*8519*临时npc*472*241/袈裟".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==5 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|虎将军*8518*临时npc*113*11/虎将军".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==6 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|翼将军*8518*临时npc*121*14/翼将军".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==7 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|巡山小妖*8520*临时npc*34*85/巡山小妖".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==8 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|上古妖兽头领*8520*临时npc*32*66/上古妖兽头领".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==9 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命妖王*8520*临时npc*10*20/天命妖王".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==10 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|魑魅*8520*临时npc*40*16/魑魅".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==11 then
			说明={"副本·天命水陆",format("#W战斗特性：#Y天命\n与".."#Y/qqq|魍魉*8520*临时npc*49*20/魍魉".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		end
	end
	return 说明
end

return 副本_天命水陆
