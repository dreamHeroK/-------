
local 副本_五行斗法 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 副本_五行斗法:初始化()
	地图处理类.地图数据[8556]={npc={},单位={},传送圈={}}
	地图处理类.地图玩家[8556]={}
	地图处理类.地图坐标[8556]=地图处理类.地图坐标[1223]
	地图处理类.地图单位[8556]={}
	地图处理类.单位编号[8556]=1000
end

function 副本_五行斗法:开启副本(id)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<5 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	elseif  取等级要求(id,50)==false then
		常规提示(id,"#Y此副本要求角色等级不能低于50级")
		return
	end
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 副本数据.五行斗法.完成[临时id]~=nil then
		常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
		return
		elseif 玩家数据[临时id].角色:取任务(420)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行副本任务，无法领取新的副本")
			return
		end
	end
	副本数据.五行斗法.进行[id]={进程=1}
	local 任务id,ZU=取唯一任务(420,id)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=7200,
		玩家id=0,
		DWZ=ZU,
		销毁=true,
		副本重置=true,
		队伍组=ZU,
		副本id=id,
		类型=420
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了五行斗法副本")
	刷新任务420(id)
end

function 刷新任务420(id)
	local id = 任务处理类:取副本id(id,420)
	if 副本数据.五行斗法.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.五行斗法.进行[id].进程==1 then
		local 地图=8556 --长安城
		local 任务id=id.."_441_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="燃金石",
			模型="钻石",
			x=58,
			y=16,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=441
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,8556,114,80) --跳转到动画地图
		-- local text1={{"你可难不倒我哦","暮雨声残响","你快放手放手","五行斗法副本开启"}}
		-- for n=1,#队伍数据[队伍id].成员数据 do
		-- 	local 临时id=队伍数据[队伍id].成员数据[n]
		-- 	发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="五行斗法序",字体=nil,音乐=nil,背景=nil,横排显示=nil,动画调用=nil})
		-- end
	elseif 副本数据.五行斗法.进行[id].进程==2 then
		任务处理类:删除副本单位(id,420,441)
		local 地图=8556 --长安城
		local 任务id=id.."_442_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="睿木石",
			模型="钻石",
			x=17,
			y=39,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=442
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.五行斗法.进行[id].进程==3 then
		任务处理类:删除副本单位(id,420,442)
		local 地图=8556 --长安城
		local 任务id=id.."_443_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="素水石",
			模型="钻石",
			x=40,
			y=72,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=443
		}
		地图处理类:添加单位(任务id)
		-- local text1={"此副本收益颇高!","每日必刷!"}
		-- for n=1,#队伍数据[队伍id].成员数据 do
		-- 	local 临时id=队伍数据[队伍id].成员数据[n]
		-- 	发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="五行斗法1",字体=nil,音乐=nil,背景=nil,横排显示=true,动画调用=nil})
		-- end
	elseif 副本数据.五行斗法.进行[id].进程==4 then
			任务处理类:删除副本单位(id,420,443)
			local 任务id=id.."_444_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8556 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="燧火石",
				模型="钻石",
				销毁=true,
				副本重置=true,
				x=101,
				y=68,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=444
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.五行斗法.进行[id].进程==5 then
		任务处理类:删除副本单位(id,420,444)
			local 地图=8556 --长安城
			local 任务id=id.."_445_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="香土石",
				模型="钻石",
				销毁=true,
				副本重置=true,
				x=109,
				y=29,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=445
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.五行斗法.进行[id].进程==6 then
		任务处理类:删除副本单位(id,420,449)
		local 任务id=玩家数据[id].角色:取任务(420)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","五行斗法副本（完）"}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			local 地图=8556
			玩家数据[临时id].角色:取消任务(任务id)
			副本数据.五行斗法.完成[临时id]=true
			地图处理类:跳转地图(id,1001,224,118)
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="五行斗法结束",字体=nil,音乐=nil,背景=nil,横排显示=true,动画=nil})
		end
	end
end

function 副本_五行斗法:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,420)
	-- print(副本id)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.五行斗法.进行[副本id].进程==1 then
		if 对话数据.名称=="燃金石" then
			对话数据.对话 = "欢迎来到五行斗法"
			对话数据.选项 = {"破阵","我准备一下"}
		end
	elseif 副本数据.五行斗法.进行[副本id].进程==2 then
		if 对话数据.名称=="睿木石" then
			对话数据.对话 = "我勒个去打不过！来帮忙#4。"
			对话数据.选项 = {"破阵","我准备一下"}
		end
	elseif 副本数据.五行斗法.进行[副本id].进程==3 then
			if 对话数据.名称=="素水石" then
				对话数据.对话 = "小趴菜"
				对话数据.选项 = {"破阵","我准备一下"}
			end
	elseif 副本数据.五行斗法.进行[副本id].进程==4 then
			if 对话数据.名称=="燧火石" then
				对话数据.对话 = "少侠你可来了#52"
				对话数据.选项 = {"破阵","我准备一下"}
			end
	elseif 副本数据.五行斗法.进行[副本id].进程==5 then
			if 对话数据.名称=="香土石" then
				对话数据.对话 = "你小子想干嘛？#24不要妨碍我！"
				对话数据.选项 = {"破阵","我准备一下"}
			end
	end
	return 对话数据
end

function 副本_五行斗法:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,420)
	if 类型 == 441 and 名称=="燃金石" and  事件=="破阵" then
		if 副本数据.五行斗法.进行[副本id].进程==1 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102040,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 442 and 名称=="睿木石" and  事件=="破阵" then
		if 副本数据.五行斗法.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102041,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 443 and 名称=="素水石" and  事件=="破阵" then
		if 副本数据.五行斗法.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102042,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 444 and 名称=="燧火石" and  事件=="破阵" then
		if 副本数据.五行斗法.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102043,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 445 and 名称=="香土石" and  事件=="破阵" then
		if 副本数据.五行斗法.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102044,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_五行斗法:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,420)
	if 副本id == 0 then return end
	if 战斗类型 == 102040 then
		副本数据.五行斗法.进行[副本id]={进程=2}
		任务数据[任务id].zhandou = nil
		刷新任务420(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102041 then
		副本数据.五行斗法.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务420(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102042 then
		副本数据.五行斗法.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务420(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102043 then
		副本数据.五行斗法.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务420(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102044 then
		副本数据.五行斗法.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务420(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_五行斗法:完成奖励(id组,战斗类型,倍率)
	local 倍率=倍率 or 1
	if 战斗类型 == 102040 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4200)
			local 银子=等级*取随机数(110,120)+9000
			玩家数据[cyid].角色:添加经验(经验*倍率,"五行斗法")
			玩家数据[cyid].角色:添加银子(银子*倍率,"五行斗法",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(五行斗法)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在五行斗法中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="超级金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="召唤兽内丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="魔兽要诀"
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
	elseif 战斗类型 == 102041 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4200)
			local 银子=等级*取随机数(110,120)+8000
			玩家数据[cyid].角色:添加经验(经验*倍率,"五行斗法")
			玩家数据[cyid].角色:添加银子(银子*倍率,"五行斗法",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(五行斗法)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在五行斗法中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
       					if 奖励参数<=10 then
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="超级金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="召唤兽内丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
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
		end--兰虎
	elseif 战斗类型 == 102042 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4200)
			local 银子=等级*取随机数(110,120)+8000
			玩家数据[cyid].角色:添加经验(经验*倍率,"五行斗法")
			玩家数据[cyid].角色:添加银子(银子*倍率,"五行斗法",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(五行斗法)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在五行斗法中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="超级金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="召唤兽内丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="魔兽要诀"
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
	elseif 战斗类型 == 102043 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4200)
			local 银子=等级*取随机数(120,130)+10000
			玩家数据[cyid].角色:添加经验(经验*倍率,"五行斗法")
			玩家数据[cyid].角色:添加银子(银子*倍率,"五行斗法",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(五行斗法)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在五行斗法中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="超级金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="召唤兽内丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="魔兽要诀"
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
		end
	elseif 战斗类型 == 102044 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2650,4200)
			local 银子=等级*取随机数(110,120)+10000
			玩家数据[cyid].角色:添加经验(经验*倍率,"五行斗法")
			玩家数据[cyid].角色:添加银子(银子*倍率,"五行斗法",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(五行斗法)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在五行斗法中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="超级金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="召唤兽内丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=26 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="神兽涎"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="魔兽要诀"
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
		end
	end
end

function 副本_五行斗法:任务说明(玩家id,任务id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.五行斗法.进行[副本id]==nil then
		说明={"五行斗法","#L您的副本已经完成"}
	else
		local 进程=副本数据.五行斗法.进行[副本id].进程
		       if 进程==1 then
			说明={"五行斗法",format("#L前往".."#Y/qqq|燃金石*8556*临时npc*58*16/燃金石".."#L冲破五行大阵。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==2 then
			说明={"五行斗法",format("#L前往".."#Y/qqq|睿木石*8556*临时npc*17*39/睿木石".."#L冲破五行大阵。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==3 then
			说明={"五行斗法",format("#L前往".."#Y/qqq|素水石*8556*临时npc*40*72/素水石".."#L冲破五行大阵。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==4 then
			说明={"五行斗法",format("#L前往".."#Y/qqq|燧火石*8556*临时npc*101*68/燧火石".."#L冲破五行大阵。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==5 then
			说明={"五行斗法",format("#L前往".."#Y/qqq|香土石*8556*临时npc*109*29/香土石".."#L冲破五行大阵。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		end
	end
	return 说明
end


function 副本_五行斗法:扫荡(队长id)
     if not 玩家数据[队长id].道具:判定背包道具(队长id,"扫荡卡",1) then
       	常规提示(队长id,"#Y/扫荡副本需消耗1个扫荡卡")
    	return
    end
    玩家数据[队长id].道具:消耗背包道具(玩家数据[队长id].连接id,队长id,"扫荡卡",1)

    local 队伍id = 玩家数据[队长id].队伍
    local 倍率 = 0.8
    local 副本等级要求 = 50 -- 副本原等级要求
    local 任务类型 = 420 -- 五行斗法副本任务类型
    local 所有战斗类型 = {102040, 102041, 102042, 102043, 102044} -- 五行斗法5场战斗类型

    -- 1. 基础合规性校验（复用原副本开启逻辑，确保成员状态合法）
    if not 队伍id or 队伍id == 0 then
        常规提示(队长id, "#Y请先组建队伍后再操作！")
        return
    end
    local 队伍成员列表 = 队伍数据[队伍id].成员数据
    local 副本标识id = 队长id -- 沿用原逻辑：以队长id作为副本唯一标识

    -- 逐个校验成员状态：等级、是否已完成、是否在其他副本、组队人数（非调试模式）
    if 取队伍人数(队长id) < 5 and 调试模式 == false then
        常规提示(队长id, "#Y非调试模式下，队伍人数需不低于5人才能完成副本！")
        return
    end
    for _, 临时id in ipairs(队伍成员列表) do
        -- 校验等级
        if 取等级要求(临时id, 副本等级要求) == false then
            常规提示(队长id, "#Y"..玩家数据[临时id].角色.名称.."等级低于"..副本等级要求.."级，无法参与！")
            return
        end
        -- 校验是否已完成当日副本
        if 副本数据.五行斗法.完成[临时id] then
            常规提示(队长id, "#Y"..玩家数据[临时id].角色.名称.."本日已完成五行斗法，无法重复参与！")
            return
        end
        -- 校验是否在其他副本中
        if 玩家数据[临时id].角色:取任务(任务类型) ~= 0 then
            常规提示(队长id, "#Y"..玩家数据[临时id].角色.名称.."正在进行其他副本任务，无法加入！")
            return
        end
    end
    for _, 战斗类型 in ipairs(所有战斗类型) do
        self:完成奖励(队伍成员列表, 战斗类型, 倍率)
    end
    for _, 临时id in ipairs(队伍成员列表) do
        副本数据.五行斗法.完成[临时id] = true
        if 玩家数据[临时id] and 玩家数据[临时id].连接id then
            发送数据(玩家数据[临时id].连接id, 550.3,{五行斗法=true})
        end
    end
    常规提示(队长id, "#Y所有成员已完成五行斗法副本，奖励发放完毕！")
end


return 副本_五行斗法
