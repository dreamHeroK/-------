
local 副本_清泽谱之惠 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 副本_清泽谱之惠:初始化()
	地图处理类.地图数据[9500]={npc={},单位={},传送圈={}} --龙宫
	地图处理类.地图玩家[9500]={}
	地图处理类.地图坐标[9500]=地图处理类.地图坐标[1116]
	地图处理类.地图单位[9500]={}
	地图处理类.单位编号[9500]=1000

	地图处理类.地图数据[9501]={npc={},单位={},传送圈={}} --天宫
	地图处理类.地图玩家[9501]={}
	地图处理类.地图坐标[9501]=地图处理类.地图坐标[1111]
	地图处理类.地图单位[9501]={}
	地图处理类.单位编号[9501]=1000

	地图处理类.地图数据[9502]={npc={},单位={},传送圈={}} --小西天
	地图处理类.地图玩家[9502]={}
	地图处理类.地图坐标[9502]=地图处理类.地图坐标[1203]
	地图处理类.地图单位[9502]={}
	地图处理类.单位编号[9502]=1000

	地图处理类.地图数据[9503]={npc={},单位={},传送圈={}} --水帘洞
	地图处理类.地图玩家[9503]={}
	地图处理类.地图坐标[9503]=地图处理类.地图坐标[1103]
	地图处理类.地图单位[9503]={}
	地图处理类.单位编号[9503]=1000
end

function 副本_清泽谱之惠:开启副本(id,nandu)
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
		elseif 玩家数据[临时id].角色:取任务(1550)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行神器任务，无法领取新的神器任务")
			return
		end
	end
	if 副本数据.清泽谱之惠.进行[id] == nil then
	副本数据.清泽谱之惠.进行[id]={进程=1}
	end


	local 任务id,ZU=取唯一任务(1550,id)
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
		类型=1550,
		PlayerGroup = table.copy(队伍数据[队伍id].成员数据)
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了神器·清泽谱之惠")
	刷新任务1550(id)
end

function 刷新任务1550(id)
	local id = 任务处理类:取副本id(id,1550)
	if 副本数据.清泽谱之惠.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.清泽谱之惠.进行[id].进程==1 then
		local 地图=9500 --长安城
		local 任务id=id.."_1551_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="吕小娘",
			模型="小精灵",
			显示饰品=true,
			x=26,
			y=103,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1551
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9500,31,102) --跳转到动画地图
	elseif 副本数据.清泽谱之惠.进行[id].进程==2 then
		任务处理类:删除副本单位(id,1550,1551)
		local 地图=9500 --长安城
		local 任务id=id.."_1552_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="龟千岁",
			模型="龟丞相",
			显示饰品=true,
			x=99,
			y=57,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1552
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.清泽谱之惠.进行[id].进程==3 then
			任务处理类:删除副本单位(id,1550,1552)
			local 任务id=id.."_1553_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9501 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="龙超",
				模型="男人_小白龙",
				销毁=true,
				副本重置=true,
				x=144,
				y=37,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1553
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9501,160,114) --跳转到动画地图
	elseif 副本数据.清泽谱之惠.进行[id].进程==4 then
			任务处理类:删除副本单位(id,1550,1553)
			local 任务id=id.."_1554_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9501 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="玉帝",
				模型="男人_玉帝",
				销毁=true,
				副本重置=true,
				x=151,
				y=108,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1554
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.清泽谱之惠.进行[id].进程==5 then
			任务处理类:删除副本单位(id,1550,1554)
			local 任务id=id.."_1555_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9502 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="吕小娘",
				模型="小精灵",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=114,
				y=185,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1555
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9502,76,214) --跳转到动画地图
	elseif 副本数据.清泽谱之惠.进行[id].进程==6 then
			任务处理类:删除副本单位(id,1550,1555)
			local 任务id=id.."_1556_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9502 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="龙超",
				模型="男人_小白龙",
				销毁=true,
				副本重置=true,
				x=135,
				y=9,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1556
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.清泽谱之惠.进行[id].进程==7 then
			任务处理类:删除副本单位(id,1550,1556)
			local 任务id=id.."_1557_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9503 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="神秘男子",
				模型="剑侠客",
				武器="四法青云",
				染色方案=2,
				染色组={3,3,3},
				销毁=true,
				副本重置=true,
				x=63,
				y=20,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1557
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9503,10,48) --跳转到动画地图
	elseif 副本数据.清泽谱之惠.进行[id].进程==8 then
		任务处理类:删除副本单位(id,1550,1557)
		local 任务id=玩家数据[id].角色:取任务(1550)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","神器·清泽谱之惠（完）"}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			玩家数据[临时id].角色:取消任务(任务id)
			副本数据.神器任务.完成[临时id]=true
			地图处理类:跳转地图(id,1001,224,118)
			抽奖处理:大转盘抽奖(id)
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="归墟副本结束",字体=nil,音乐=nil,背景=nil,横排显示=true,动画=nil})
		end
	end
end

function 副本_清泽谱之惠:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,1550)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.清泽谱之惠.进行[副本id].进程==1 then
		if 对话数据.名称=="吕小娘" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.清泽谱之惠.进行[副本id].进程==2 then
		if 对话数据.名称=="龟千岁" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.清泽谱之惠.进行[副本id].进程==3 then
			if 对话数据.名称=="龙超" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.清泽谱之惠.进行[副本id].进程==4 then
			if 对话数据.名称=="玉帝" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.清泽谱之惠.进行[副本id].进程==5 then
			if 对话数据.名称=="吕小娘" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.清泽谱之惠.进行[副本id].进程==6 then
			if 对话数据.名称=="龙超" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	elseif 副本数据.清泽谱之惠.进行[副本id].进程==7 then
			if 对话数据.名称=="神秘男子" then
				对话数据.对话 = "欢迎来到梦幻西游"
				对话数据.选项 = {"挑战你","我准备一下"}
			end
	end
	return 对话数据
end

function 副本_清泽谱之惠:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,1550)
	if 类型 == 1551 and 名称=="吕小娘" and  事件=="我来了" then
		if 副本数据.清泽谱之惠.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170000,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1552 and 名称=="龟千岁" and  事件=="挑战你" then
		if 副本数据.清泽谱之惠.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170001,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1553 and 名称=="龙超" and  事件=="挑战你" then
		if 副本数据.清泽谱之惠.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170002,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1554 and 名称=="玉帝" and  事件=="挑战你" then
		if 副本数据.清泽谱之惠.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170003,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1555 and 名称=="吕小娘" and  事件=="挑战你" then
		if 副本数据.清泽谱之惠.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170004,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1556 and 名称=="龙超" and  事件=="挑战你" then
		if 副本数据.清泽谱之惠.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170005,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1557 and 名称=="神秘男子" and  事件=="挑战你" then
		if 副本数据.清泽谱之惠.进行[副本id].进程==7 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170006,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_清泽谱之惠:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,1550)
	if 副本id == 0 then return end
	if 战斗类型 == 170000 then
		副本数据.清泽谱之惠.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务1550(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170001 then
		副本数据.清泽谱之惠.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务1550(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170002 then
		副本数据.清泽谱之惠.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务1550(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170003 then
		副本数据.清泽谱之惠.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务1550(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170004 then
		副本数据.清泽谱之惠.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务1550(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170005 then
		副本数据.清泽谱之惠.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务1550(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170006 then
		副本数据.清泽谱之惠.进行[副本id]={进程=8}
		任务数据[任务id].zhandou = nil
		刷新任务1550(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_清泽谱之惠:完成奖励(id组,战斗类型)
	if 战斗类型 == 170000 then
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
			玩家数据[cyid].角色:添加经验(经验,"清泽谱之惠")
			玩家数据[cyid].角色:添加银子(银子,"清泽谱之惠",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(清泽谱之惠)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在清泽谱之惠中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170001 then
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
			玩家数据[cyid].角色:添加经验(经验,"清泽谱之惠")
			玩家数据[cyid].角色:添加银子(银子,"清泽谱之惠",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(清泽谱之惠)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在清泽谱之惠中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170002 then
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
			玩家数据[cyid].角色:添加经验(经验,"清泽谱之惠")
			玩家数据[cyid].角色:添加银子(银子,"清泽谱之惠",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(清泽谱之惠)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在清泽谱之惠中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170003 then
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
			玩家数据[cyid].角色:添加经验(经验,"清泽谱之惠")
			玩家数据[cyid].角色:添加银子(银子,"清泽谱之惠",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(清泽谱之惠)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在清泽谱之惠中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170004 then
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
			玩家数据[cyid].角色:添加经验(经验,"清泽谱之惠")
			玩家数据[cyid].角色:添加银子(银子,"清泽谱之惠",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(清泽谱之惠)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在清泽谱之惠中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170005 then
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
			玩家数据[cyid].角色:添加经验(经验,"清泽谱之惠")
			玩家数据[cyid].角色:添加银子(银子,"清泽谱之惠",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(清泽谱之惠)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在清泽谱之惠中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
	elseif 战斗类型 == 170006 then
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
			玩家数据[cyid].角色:添加经验(经验,"清泽谱之惠")
			玩家数据[cyid].角色:添加银子(银子,"清泽谱之惠",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(清泽谱之惠)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在清泽谱之惠中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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

function 副本_清泽谱之惠:任务说明(玩家id,任务id,id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.清泽谱之惠.进行[副本id]==nil then
		说明={"清泽谱之惠","#L您的副本已经完成"}
	else
		local 进程=副本数据.清泽谱之惠.进行[副本id].进程
		       if 进程==1 then
			说明={"神器·清泽谱之惠",format("与".."#Y/qqq|吕小娘*9500*临时npc*26*103/吕小娘".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==2 then
			说明={"神器·清泽谱之惠",format("与".."#Y/qqq|龟千岁*9500*临时npc*99*57/龟千岁".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==3 then
			说明={"神器·清泽谱之惠",format("与".."#Y/qqq|龙超*9501*临时npc*144*37/龙超".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==4 then
			说明={"神器·清泽谱之惠",format("与".."#Y/qqq|玉帝*9501*临时npc*151*108/玉帝".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==5 then
			说明={"神器·清泽谱之惠",format("与".."#Y/qqq|吕小娘*9502*临时npc*114*185/吕小娘".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==6 then
			说明={"神器·清泽谱之惠",format("与".."#Y/qqq|龙超*9502*临时npc*135*9/龙超".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==7 then
			说明={"神器·清泽谱之惠",format("与".."#Y/qqq|神秘男子*9503*临时npc*63*20/神秘男子".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}

		end
	end
	return 说明
end

return 副本_清泽谱之惠
