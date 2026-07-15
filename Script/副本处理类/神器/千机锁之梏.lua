
local 副本_千机锁之梏 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 副本_千机锁之梏:初始化()
	地图处理类.地图数据[9559]={npc={},单位={},传送圈={}} --傲来国
	地图处理类.地图玩家[9559]={}
	地图处理类.地图坐标[9559]=地图处理类.地图坐标[1218]
	地图处理类.地图单位[9559]={}
	地图处理类.单位编号[9559]=1000

	地图处理类.地图数据[9560]={npc={},单位={},传送圈={}} --花果山
	地图处理类.地图玩家[9560]={}
	地图处理类.地图坐标[9560]=地图处理类.地图坐标[1221]
	地图处理类.地图单位[9560]={}
	地图处理类.单位编号[9560]=1000
end

function 副本_千机锁之梏:开启副本(id,nandu)
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
		elseif 玩家数据[临时id].角色:取任务(1680)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行神器任务，无法领取新的神器任务")
			return
		end
	end
	if 副本数据.千机锁之梏.进行[id] == nil then
	    副本数据.千机锁之梏.进行[id]={进程=1}
	end

	local 任务id,ZU=取唯一任务(1680,id)
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
		类型=1680
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了神器·千机锁之梏")
	刷新任务1680(id)
end

function 刷新任务1680(id)
	local id = 任务处理类:取副本id(id,1680)
	if 副本数据.千机锁之梏.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.千机锁之梏.进行[id].进程==1 then
		local 地图=9559 --蟠桃园
		local 任务id=id.."_1681_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="禁地机关",
			模型="连弩车",
			-- 武器="雷神",
			-- 染色方案=9,
			-- 染色组={[1]=5,[2]=4,[3]=4},
			x=43,
			y=13,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1681
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9559,20,35) --跳转到动画地图
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.千机锁之梏.进行[id].进程==2 then
		任务处理类:删除副本单位(id,1680,1681)
		local 地图=9560 --海底迷宫5
		local 任务id=id.."_1682_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="核心中枢",
			模型="混沌兽",
			x=22,
			y=36,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=1682
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,9560,19,16) --跳转到动画地图
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		end
	elseif 副本数据.千机锁之梏.进行[id].进程==3 then
			任务处理类:删除副本单位(id,1680,1682)
			local 任务id=id.."_1683_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9559 --比武场
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="核心中枢",
				模型="连弩车",
				销毁=true,
				副本重置=true,
				x=43,
				y=13,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1683
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9559,20,35) --跳转到动画地图
		 for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 end
	elseif 副本数据.千机锁之梏.进行[id].进程==4 then
			任务处理类:删除副本单位(id,1680,1683)
			local 任务id=id.."_1684_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9560 --国境
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="千机蕊",
				模型="进阶凤凰",
				-- 染色方案=63,
				-- 染色组={[1]=1,[2]=0},
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=30,
				y=45,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1684
			}
			地图处理类:添加单位(任务id)
			地图处理类:跳转地图(id,9560,19,16) --跳转到动画地图
		 for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6560,true)--夜间显示
		 end
	elseif 副本数据.千机锁之梏.进行[id].进程==5 then
			任务处理类:删除副本单位(id,1680,1684)
			local 任务id=id.."_1685_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9560 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="千机蕊",
				模型="进阶凤凰",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=136,
				y=54,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1685
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.千机锁之梏.进行[id].进程==6 then
			任务处理类:删除副本单位(id,1680,1685)
			local 任务id=id.."_1686_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=9560 --墨家村
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="墨玄",
				模型="偃无师",
				武器="昆吾",
				染色方案=205,
				染色组={[1]=1,[2]=0},
				销毁=true,
				副本重置=true,
				x=154,
				y=97,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=1686
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.千机锁之梏.进行[id].进程==7 then
		任务处理类:删除副本单位(id,1680,1686)
		local 任务id=玩家数据[id].角色:取任务(1680)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","神器·千机锁之梏（完）"}
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

function 副本_千机锁之梏:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,1680)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.千机锁之梏.进行[副本id].进程==1 then
		if 对话数据.名称=="禁地机关" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"我来了","我准备一下"}
		end
	elseif 副本数据.千机锁之梏.进行[副本id].进程==2 then
		if 对话数据.名称=="核心中枢" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.千机锁之梏.进行[副本id].进程==3 then
		if 对话数据.名称=="核心中枢" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.千机锁之梏.进行[副本id].进程==4 then
		if 对话数据.名称=="千机蕊" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.千机锁之梏.进行[副本id].进程==5 then
		if 对话数据.名称=="千机蕊" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	elseif 副本数据.千机锁之梏.进行[副本id].进程==6 then
		if 对话数据.名称=="墨玄" then
			对话数据.对话 = "欢迎来到梦幻西游"
			对话数据.选项 = {"挑战你","我准备一下"}
		end
	end
	return 对话数据
end

function 副本_千机锁之梏:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,1680)
	if 类型 == 1681 and 名称=="禁地机关" and  事件=="我来了" then
		if 副本数据.千机锁之梏.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170130,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1682 and 名称=="核心中枢" and  事件=="挑战你" then
		if 副本数据.千机锁之梏.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170131,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1683 and 名称=="核心中枢" and  事件=="挑战你" then
		if 副本数据.千机锁之梏.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170132,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1684 and 名称=="千机蕊" and  事件=="挑战你" then
		if 副本数据.千机锁之梏.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170133,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1685 and 名称=="千机蕊" and  事件=="挑战你" then
		if 副本数据.千机锁之梏.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170134,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 1686 and 名称=="墨玄" and  事件=="挑战你" then
		if 副本数据.千机锁之梏.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,170135,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_千机锁之梏:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,1680)
	if 副本id == 0 then return end
	if 战斗类型 == 170130 then
		副本数据.千机锁之梏.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务1680(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170131 then
		副本数据.千机锁之梏.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务1680(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170132 then
		副本数据.千机锁之梏.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务1680(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170133 then
		副本数据.千机锁之梏.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务1680(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170134 then
		副本数据.千机锁之梏.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务1680(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 170135 then
		副本数据.千机锁之梏.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务1680(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_千机锁之梏:完成奖励(id组,战斗类型)
	if 战斗类型 == 170130 then
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
			玩家数据[cyid].角色:添加经验(经验,"千机锁之梏")
			玩家数据[cyid].角色:添加银子(银子,"千机锁之梏",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(千机锁之梏)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在千机锁之梏中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--百晓星君
	elseif 战斗类型 == 170131 then
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
			玩家数据[cyid].角色:添加经验(经验,"千机锁之梏")
			玩家数据[cyid].角色:添加银子(银子,"千机锁之梏",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(千机锁之梏)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在千机锁之梏中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--兰虎
	elseif 战斗类型 == 170132 then
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
			玩家数据[cyid].角色:添加经验(经验,"千机锁之梏")
			玩家数据[cyid].角色:添加银子(银子,"千机锁之梏",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(千机锁之梏)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在千机锁之梏中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--兰虎
	elseif 战斗类型 == 170133 then
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
			玩家数据[cyid].角色:添加经验(经验,"千机锁之梏")
			玩家数据[cyid].角色:添加银子(银子,"千机锁之梏",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(千机锁之梏)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在千机锁之梏中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--兰虎
	elseif 战斗类型 == 170134 then
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
			玩家数据[cyid].角色:添加经验(经验,"千机锁之梏")
			玩家数据[cyid].角色:添加银子(银子,"千机锁之梏",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(千机锁之梏)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在千机锁之梏中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--兰虎
	elseif 战斗类型 == 170135 then
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
			玩家数据[cyid].角色:添加经验(经验,"千机锁之梏")
			玩家数据[cyid].角色:添加银子(银子,"千机锁之梏",1)
			玩家数据[cyid].角色:添加神器积分(积分)
			if 取随机数()<=BL then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(千机锁之梏)#Y梦幻西游为高手玩家打造的副本，#G/%s#Y少侠在千机锁之梏中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
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
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,3),nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="特殊兽诀·碎片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="灵犀之屑"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,3,nil,链接)
				end
			end
		end--兰虎
	end
end

function 副本_千机锁之梏:任务说明(玩家id,任务id,id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.千机锁之梏.进行[副本id]==nil then
		说明={"千机锁之梏","#L您的副本已经完成"}
	else
		local 进程=副本数据.千机锁之梏.进行[副本id].进程
		       if 进程==1 then
			说明={"神器·千机锁之梏",format("与".."#Y/qqq|禁地机关*9559*临时npc*43*13/禁地机关".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==2 then
			说明={"神器·千机锁之梏",format("与".."#Y/qqq|核心中枢*9560*临时npc*22*36/核心中枢".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==3 then
			说明={"神器·千机锁之梏",format("与".."#Y/qqq|核心中枢*9559*临时npc*43*13/核心中枢".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==4 then
			说明={"神器·千机锁之梏",format("与".."#Y/qqq|千机蕊*9560*临时npc*30*45/千机蕊".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==5 then
			说明={"神器·千机锁之梏",format("与".."#Y/qqq|千机蕊*9560*临时npc*136*54/千机蕊".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}
		elseif 进程==6 then
			说明={"神器·千机锁之梏",format("与".."#Y/qqq|墨玄*9560*临时npc*154*97/墨玄".."#L战斗。剩余时间%s分钟。)（可在#Y传令天兵#L处取消任务，或重新返回神器任务）\n【难度%s★】",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))),玩家数据[玩家id].角色.神器难度)}


		end
	end
	return 说明
end

return 副本_千机锁之梏
