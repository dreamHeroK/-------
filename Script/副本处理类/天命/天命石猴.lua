-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2023-01-03 09:00:53
-- @最后修改来自: baidwwy
-- @Last Modified time: 2026-05-18 20:35:06
local 副本_天命石猴 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
-- local npc={1="1",2="2",3="3",4="4"} --模型,名字

function 副本_天命石猴:初始化()
	地图处理类.地图数据[8503]={npc={},单位={},传送圈={}} --朱紫
	地图处理类.地图玩家[8503]={}
	地图处理类.地图坐标[8503]=地图处理类.地图坐标[1208]
	地图处理类.地图单位[8503]={}
	地图处理类.单位编号[8503]=1000

	地图处理类.地图数据[8504]={npc={},单位={},传送圈={}} --小雷音
	地图处理类.地图玩家[8504]={}
	地图处理类.地图坐标[8504]=地图处理类.地图坐标[1203]
	地图处理类.地图单位[8504]={}
	地图处理类.单位编号[8504]=1000

	地图处理类.地图数据[8505]={npc={},单位={},传送圈={}} --神兽乐园
	地图处理类.地图玩家[8505]={}
	地图处理类.地图坐标[8505]=地图处理类.地图坐标[1231]
	地图处理类.地图单位[8505]={}
	地图处理类.单位编号[8505]=1000

	地图处理类.地图数据[8506]={npc={},单位={},传送圈={}} --粉色紫豪
	地图处理类.地图玩家[8506]={}
	地图处理类.地图坐标[8506]=地图处理类.地图坐标[1325]
	地图处理类.地图单位[8506]={}
	地图处理类.单位编号[8506]=1000

end

function 副本_天命石猴:开启副本(id)
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
		if 副本数据.天命石猴.完成[临时id]~=nil then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
			return
		elseif 玩家数据[临时id].角色:取任务(3010)~=0 then
		local 副本id=任务数据[玩家数据[id].角色:取任务(3010)].副本id
		local 进程=副本数据.天命石猴.进行[副本id].进程
		local 地图=8503
		local x=0
		local y=0
		if 进程==1 or 进程==2 or 进程==3  then
			地图=8503
			x,y=126,36
		elseif 进程==4 or 进程==5 or 进程==6  then
			地图=8504
			x,y=32,27
		elseif 进程==7 then
			地图=8506
			x,y=32,27
		elseif 进程==8 then
			地图=8503
			x,y=126,36
		end
		地图处理类:跳转地图(id,地图,x,y)
			return
		end
	end
	副本数据.天命石猴.进行[id]={进程=1,数量=0}
	local 任务id,ZU=取唯一任务(3010,id)
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
		类型=3010
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了天命石猴副本")
	刷新任务3010(id)
end

function 刷新任务3010(id)
	local id = 任务处理类:取副本id(id,3010)
	if 副本数据.天命石猴.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.天命石猴.进行[id].进程==1 then
		local 地图=8503 --长安城
		local 任务id=id.."_3011_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="天命大王子",
			模型="神天兵",
			x=117,
			y=69,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3011
		}
		地图处理类:添加单位(任务id)
		local 地图=8503 --长安城
		local 任务id=id.."_3012_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="天命二王子",
			模型="龙太子",
			x=110,
			y=73,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3012
		}
		地图处理类:添加单位(任务id)
		local 地图=8503 --长安城
		local 任务id=id.."_3013_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="天命三王子",
			模型="羽灵神",
			x=101,
			y=78,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3013
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.天命石猴.进行[id].进程==2 then
	elseif 副本数据.天命石猴.进行[id].进程==3 then
	elseif 副本数据.天命石猴.进行[id].进程==4 then
		任务处理类:删除副本单位(id,3010,3011)
		任务处理类:删除副本单位(id,3010,3012)
		任务处理类:删除副本单位(id,3010,3013)
		local 地图=8504 --长安城
		local xy=地图处理类.地图坐标[地图]:取随机点()
		local 任务id=id.."_3014_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="天命葡萄",
			模型="葡萄树",
			x=68,
			y=51,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3014
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,8504,12,42) --跳转到动画地图
		local 地图=8504 --长安城
		local 任务id=id.."_3015_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="天命香蕉",
			模型="香蕉树",
			x=50,
			y=165,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3015
		}
		地图处理类:添加单位(任务id)
		local 地图=8504 --长安城
		local 任务id=id.."_3016_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="天命荷花",
			模型="荷花盆栽",
			x=140,
			y=173,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=3016
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.天命石猴.进行[id].进程==5 then
	elseif 副本数据.天命石猴.进行[id].进程==6 then
	elseif 副本数据.天命石猴.进行[id].进程==7 then
			任务处理类:删除副本单位(id,3010,3014)
			任务处理类:删除副本单位(id,3010,3015)
			任务处理类:删除副本单位(id,3010,3016)
			local 任务id=id.."_3017_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8506 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="天命穿山甲",
				模型="修罗傀儡鬼",
				销毁=true,
				副本重置=true,
				x=50,
				y=27,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3017
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8506,91,50) --跳转到动画地图
	elseif 副本数据.天命石猴.进行[id].进程==8 then
			任务处理类:删除副本单位(id,3010,3017)
			local 任务id=id.."_3018_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8503 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="神器之灵",
				模型="物件_打铁炉",
				销毁=true,
				副本重置=true,
				x=51,
				y=85,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3018
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,8503,126,36) --跳转到动画地图
	elseif 副本数据.天命石猴.进行[id].进程==9 then
			任务处理类:删除副本单位(id,3010,3018)
			local 任务id=id.."_3019_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8503 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="天命石猴",
				模型="龙柱",
				销毁=true,
				副本重置=true,
				x=92,
				y=63,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=3019
			}
			地图处理类:添加单位(任务id)
			--地图处理类:跳转地图(id,8502,29,56) --跳转到动画地图
	elseif 副本数据.天命石猴.进行[id].进程==10 then
		任务处理类:删除副本单位(id,3010,3017)
		local 任务id=玩家数据[id].角色:取任务(3010)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","天命石猴副本（完）"}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			玩家数据[临时id].角色:取消任务(任务id)
			副本数据.天命石猴.完成[临时id]=true
			抽奖处理:转盘抽奖(id)
			地图处理类:跳转地图(id,1001,224,118)
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="归墟副本结束",字体=nil,音乐=nil,背景=nil,横排显示=true,动画=nil})
		end
	end
end

function 副本_天命石猴:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,3010)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.天命石猴.进行[副本id].进程==1 then
		if 对话数据.名称=="天命大王子" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.天命石猴.进行[副本id].进程==2 then
		if 对话数据.名称=="天命二王子" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.天命石猴.进行[副本id].进程==3 then
			if 对话数据.名称=="天命三王子" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命石猴.进行[副本id].进程==4 then
			if 对话数据.名称=="天命葡萄" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命石猴.进行[副本id].进程==5 then
			if 对话数据.名称=="天命香蕉" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命石猴.进行[副本id].进程==6 then
			if 对话数据.名称=="天命荷花" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命石猴.进行[副本id].进程==7 then
			if 对话数据.名称=="天命穿山甲" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命石猴.进行[副本id].进程==8 then
			if 对话数据.名称=="神器之灵" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.天命石猴.进行[副本id].进程==9 then
			if 对话数据.名称=="天命石猴" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	end
	return 对话数据
end

function 副本_天命石猴:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,3010)
	if 类型 == 3011 and 名称=="天命大王子" and  事件=="我来了" then
		if 副本数据.天命石猴.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105011,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3012 and 名称=="天命二王子" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105012,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3013 and 名称=="天命三王子" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105013,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3014 and 名称=="天命葡萄" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105014,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3015 and 名称=="天命香蕉" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105015,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3016 and 名称=="天命荷花" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105016,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3017 and 名称=="天命穿山甲" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==7 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105017,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3018 and 名称=="神器之灵" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==8 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105018,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 3019 and 名称=="天命石猴" and  事件=="挑战你" then
		if 副本数据.天命石猴.进行[副本id].进程==9 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,105019,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_天命石猴:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,3010)
	if 副本id == 0 then return end
	if 战斗类型 == 105011 then
		副本数据.天命石猴.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105012 then
		副本数据.天命石猴.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105013 then
		副本数据.天命石猴.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105014 then
		副本数据.天命石猴.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105015 then
		副本数据.天命石猴.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105016 then
		副本数据.天命石猴.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105017 then
		副本数据.天命石猴.进行[副本id]={进程=8}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105018 then
		副本数据.天命石猴.进行[副本id]={进程=9}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 105019 then
		副本数据.天命石猴.进行[副本id]={进程=10}
		任务数据[任务id].zhandou = nil
		刷新任务3010(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_天命石猴:完成奖励(id组,战斗类型)
	if 战斗类型 == 105011 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
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
	elseif 战斗类型 == 105012 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="九转金丹"
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
	elseif 战斗类型 == 105013 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
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
	elseif 战斗类型 == 105014 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="特殊兽诀·碎片"
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
	elseif 战斗类型 == 105015 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
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
	elseif 战斗类型 == 105016 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="特殊兽诀·碎片"
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
	elseif 战斗类型 == 105017 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
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
	elseif 战斗类型 == 105018 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=35 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="特殊兽诀·碎片"
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
	elseif 战斗类型 == 105019 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4100)+200000
			local 银子=等级*取随机数(110,120)+80000
			local 储备=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加储备(储备,"天命石猴",1)
			玩家数据[cyid].角色:添加经验(经验,"天命石猴")
			玩家数据[cyid].角色:添加银子(银子,"天命石猴",1)
			玩家数据[cyid].角色:添加副本积分(200)
			添加活跃(cyid,10)
			更新玩家每日(cyid,"副本任务","天命石猴")

			if 取随机数()<=28 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(天命石猴)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在天命石猴中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="神兜兜"
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
					local 名称="特殊兽诀·碎片"
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

function 副本_天命石猴:任务说明(玩家id,任务id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.天命石猴.进行[副本id]==nil then
		说明={"天命石猴","#W您的副本已经完成"}
	else
		local 进程=副本数据.天命石猴.进行[副本id].进程
		       if 进程==1 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命大王子*8503*临时npc*117*69/天命大王子".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==2 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命二王子*8503*临时npc*110*73/天命二王子".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==3 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命三王子*8503*临时npc*101*78/天命三王子".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==4 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命葡萄*8504*临时npc*68*51/天命葡萄".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==5 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命香蕉*8504*临时npc*50*165/天命香蕉".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==6 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命荷花*8504*临时npc*140*173/天命荷花".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==7 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命穿山甲*8506*临时npc*50*27/天命穿山甲".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==8 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|神器之灵*8503*临时npc*51*85/神器之灵".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==9 then
			说明={"副本·天命石猴",format("#W战斗特性：#Y天命\n与".."#Y/qqq|天命石猴*8503*临时npc*92*63/天命石猴".."#W战斗。剩余时间%s分钟。)（可在#Y副本官员#W处重新返回副本）\n【难度★★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		end
	end
	return 说明
end

return 副本_天命石猴
