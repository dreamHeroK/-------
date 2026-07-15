
local 副本_青丘迷雾 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 副本_青丘迷雾:初始化()
	地图处理类.地图数据[8555]={npc={},单位={},传送圈={}}
	地图处理类.地图玩家[8555]={}
	地图处理类.地图坐标[8555]=地图处理类.地图坐标[1259]
	地图处理类.地图单位[8555]={}
	地图处理类.单位编号[8555]=1000
end

function 副本_青丘迷雾:开启副本(id)
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
		if 副本数据.青丘迷雾.完成[临时id]~=nil then
		常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
		return
		elseif 玩家数据[临时id].角色:取任务(410)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行副本任务，无法领取新的副本")
			return
		end
	end
	副本数据.青丘迷雾.进行[id]={进程=1}
	local 任务id,ZU=取唯一任务(410,id)
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
		类型=410
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了青丘迷雾副本")
	刷新任务410(id)
end

function 刷新任务410(id)
	local id = 任务处理类:取副本id(id,410)
	if 副本数据.青丘迷雾.进行[id]==nil then
		return
	end
	玩家数据[id].zhandou=0
	local 队伍id=玩家数据[id].队伍
	if 副本数据.青丘迷雾.进行[id].进程==1 then
		local 地图=8555 --长安城
		local 任务id=id.."_421_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="花铃",
			模型="进阶花铃",
			显示饰品=true,
			x=125,
			y=68,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=421
		}
		地图处理类:添加单位(任务id)
		地图处理类:跳转地图(id,8555,155,88) --跳转到动画地图
		local text1={{"你可难不倒我哦","暮雨声残响","你快放手放手","青丘迷雾副本开启"}}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="青丘迷雾序",字体=nil,音乐=nil,背景=nil,横排显示=nil,动画调用=nil})
		end
	elseif 副本数据.青丘迷雾.进行[id].进程==2 then
		任务处理类:删除副本单位(id,410,421)
		local 地图=8555 --长安城
		local 任务id=id.."_422_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="花铃",
			模型="进阶花铃",
			显示饰品=true,
			x=125,
			y=68,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=422
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.青丘迷雾.进行[id].进程==3 then
		任务处理类:删除副本单位(id,410,422)
		local 地图=8555 --长安城
		local 任务id=id.."_423_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本重置=true,
			玩家id=0,
			队伍组={},
			名称="入侵妖魔",
			模型="进阶犀牛将军人形",
			显示饰品=true,
			x=130,
			y=48,
			方向=0,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=423
		}
		地图处理类:添加单位(任务id)
		-- local text1={"此副本收益颇高!","每日必刷!"}
		-- for n=1,#队伍数据[队伍id].成员数据 do
		-- 	local 临时id=队伍数据[队伍id].成员数据[n]
		-- 	发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="青丘迷雾1",字体=nil,音乐=nil,背景=nil,横排显示=true,动画调用=nil})
		-- end
	elseif 副本数据.青丘迷雾.进行[id].进程==4 then
			任务处理类:删除副本单位(id,410,423)
			local 任务id=id.."_424_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			local 地图=8555 --长安城
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="裂缝",
				模型="裂缝",
				销毁=true,
				副本重置=true,
				x=73,
				y=61,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=424
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.青丘迷雾.进行[id].进程==5 then
		任务处理类:删除副本单位(id,410,424)
			local 地图=8555 --长安城
			local 任务id=id.."_425_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="裂缝",
				模型="裂缝",
				销毁=true,
				副本重置=true,
				x=81,
				y=82,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=425
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.青丘迷雾.进行[id].进程==6 then
		任务处理类:删除副本单位(id,410,425)
			local 地图=8555
			local 任务id=id.."_426_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="阿宝",
				模型="进阶阿宝",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=18,
				y=82,
				方向=4,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=426
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.青丘迷雾.进行[id].进程==7 then
		任务处理类:删除副本单位(id,410,426)
			local 地图=8555
			local 任务id=id.."_427_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="涂山瞳",
				模型="进阶涂山瞳",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=26,
				y=52,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=427
			}
			地图处理类:添加单位(任务id)
			-- local text1 = {"号外号外！梦幻西游真好玩！","我还要充钱。"}
			-- for n=1,#队伍数据[队伍id].成员数据 do
			-- 	local 临时id=队伍数据[队伍id].成员数据[n]
			-- 	发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="青丘迷雾2",字体=nil,音乐=nil,背景=nil,横排显示=true,动画调用=nil})
			-- end
	elseif 副本数据.青丘迷雾.进行[id].进程==8 then
		任务处理类:删除副本单位(id,410,427)
			local 地图=8555
			local 任务id=id.."_428_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="有苏鸩",
				模型="有苏鸩",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=68,
				y=63,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=428
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.青丘迷雾.进行[id].进程==9 then
			任务处理类:删除副本单位(id,410,428)
			local 地图=8555
			local 任务id=id.."_429_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="月魅",
				模型="月魅",
				显示饰品=true,
				销毁=true,
				副本重置=true,
				x=33,
				y=19,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=429
			}
			地图处理类:添加单位(任务id)
			--地图处理类:跳转地图(id,8555,71,27)
			-- local text1 = {"号外号外！梦幻西游真好玩！","我还要充钱。"}
			-- for n=1,#队伍数据[队伍id].成员数据 do
			-- 	local 临时id=队伍数据[队伍id].成员数据[n]
			-- 	发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="青丘迷雾2",字体=nil,音乐=nil,背景=nil,横排显示=true,动画调用=nil})
			-- end
	elseif 副本数据.青丘迷雾.进行[id].进程==10 then
			任务处理类:删除副本单位(id,410,429)
			local 地图=8555
			local 任务id=id.."_428_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				队伍组={},
				名称="涂山雪",
				模型="魔化涂山瞳",
				销毁=true,
				副本重置=true,
				显示饰品=true,
				x=101,
				y=20,
				方向=0,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=430
			}
			地图处理类:添加单位(任务id)
	elseif 副本数据.青丘迷雾.进行[id].进程==11 then
		任务处理类:删除副本单位(id,410,430)
		local 任务id=玩家数据[id].角色:取任务(410)
		local text1 = {"梦幻西游真好玩！","我还要充钱。","青丘迷雾副本（完）"}
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			local 地图=8555
			玩家数据[临时id].角色:取消任务(任务id)
			副本数据.青丘迷雾.完成[临时id]=true
			地图处理类:跳转地图(id,1001,224,118)
			发送数据(玩家数据[临时id].连接id,6557,{文本=text1,类型="青丘迷雾结束",字体=nil,音乐=nil,背景=nil,横排显示=true,动画=nil})
		end
	end
end

function 副本_青丘迷雾:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 副本id = 任务处理类:取副本id(id,410)
	-- print(副本id)
	if 副本id == 0 or 副本id ~= id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 副本数据.青丘迷雾.进行[副本id].进程==1 then
		if 对话数据.名称=="花铃" then
			对话数据.对话 = "欢迎来到青丘迷雾"
			对话数据.选项 = {"我来了","有些尴尬。。"}
		end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==2 then
		if 对话数据.名称=="花铃" then
			对话数据.对话 = "我勒个去打不过！来帮忙#4。"
			对话数据.选项 = {"帮我除了这些烦人的小妖","有些尴尬。。"}
		end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==3 then
			if 对话数据.名称=="入侵妖魔" then
				对话数据.对话 = "小趴菜"
				对话数据.选项 = {"小子来切磋一下","这....好尴尬啊"}
			end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==4 then
			if 对话数据.名称=="裂缝" then
				对话数据.对话 = "少侠你可来了#52"
				对话数据.选项 = {"你是何人，为何闯入青丘！","活该抓你"}
			end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==5 then
			if 对话数据.名称=="裂缝" then
				对话数据.对话 = "你小子想干嘛？#24不要妨碍我！"
				对话数据.选项 = {"你是何人，为何闯入青丘！","没事大爷，我就看看"}
			end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==6 then
			if 对话数据.名称=="阿宝" then
				对话数据.对话 = "呜呜呜被抓了。"
				对话数据.选项 = {"解救阿宝","先撤"}
			end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==7 then
			if 对话数据.名称=="涂山瞳" then
				对话数据.对话 = "什么青丘迷雾啊，不过是一些水底的凡物被施了一些小手段，短时间内会让人感觉精神百倍，长久下来，身体会慢慢中毒，腐烂！意识也会模糊，所以服用之人才会看谁都像妖怪！#99应该是那有苏鸩搞的鬼，方才看到他鬼鬼祟祟的在不远处，你去问问他吧。"
				对话数据.选项 = {"我看你有问题"}
			end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==8 then
			if 对话数据.名称=="有苏鸩" then
				对话数据.对话 = "如今怕是你也知道青丘迷雾的事情了，那便不能留你了！#4"
				对话数据.选项 = {"先将他擒下再说","看起来功夫很高的样子,我先溜了"}
			end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==9 then
			if 对话数据.名称=="月魅" then
				对话数据.对话 = "你是何人，为何闯入青丘迷雾！"
				对话数据.选项 = {"只能先击败他了","没事，我就闲逛逛"}
			end
	elseif 副本数据.青丘迷雾.进行[副本id].进程==10 then
			if 对话数据.名称=="涂山雪" then
				对话数据.对话 = "你是何人，为何闯入青丘迷雾！"
				对话数据.选项 = {"只能先击败他了","没事，我就闲逛逛"}
			end
	end
	return 对话数据
end

function 副本_青丘迷雾:对话事件处理(id,名称,事件,类型)
	local 副本id = 任务处理类:取副本id(id,410)
	if 类型 == 421 and 名称=="花铃" and  事件=="我来了" then
		副本数据.青丘迷雾.进行[副本id] = {进程=2}
		刷新队伍任务追踪(id)
		刷新任务410(副本id)
	elseif 类型 == 422 and 名称=="花铃" and  事件=="帮我除了这些烦人的小妖" then
		if 副本数据.青丘迷雾.进行[副本id].进程==2 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102020,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 423 and 名称=="入侵妖魔" and  事件=="小子来切磋一下" then
		if 副本数据.青丘迷雾.进行[副本id].进程==3 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102021,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 424 and 名称=="裂缝" and  事件=="你是何人，为何闯入青丘！" then
		if 副本数据.青丘迷雾.进行[副本id].进程==4 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102022,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 425 and 名称=="裂缝" and  事件=="你是何人，为何闯入青丘！" then
		if 副本数据.青丘迷雾.进行[副本id].进程==5 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102023,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 426 and 名称=="阿宝" and  事件=="解救阿宝" then
		if 副本数据.青丘迷雾.进行[副本id].进程==6 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102024,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 427 and 名称=="涂山瞳" and  事件=="我看你有问题" then
		if 副本数据.青丘迷雾.进行[副本id].进程==7 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102025,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 428 and 名称=="有苏鸩" and  事件=="先将他擒下再说" then
		if 副本数据.青丘迷雾.进行[副本id].进程==8 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102026,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 429 and 名称=="月魅" and  事件=="只能先击败他了" then
		if 副本数据.青丘迷雾.进行[副本id].进程==9 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102027,玩家数据[id].地图单位.标识)
		end
	elseif 类型 == 430 and 名称=="涂山雪" and  事件=="只能先击败他了" then
		if 副本数据.青丘迷雾.进行[副本id].进程==10 then
			if 任务数据[玩家数据[id].地图单位.标识].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			if 取队伍人数(id)<1  and 调试模式==false then 常规提示(id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(id+0,102028,玩家数据[id].地图单位.标识)
		end
	end
end

function 副本_青丘迷雾:战斗胜利处理(id组,战斗类型,任务id)
	local id = id组[1]
	local 副本id = 任务处理类:取副本id(id,410)
	if 副本id == 0 then return end
	if 战斗类型 == 102020 then
		副本数据.青丘迷雾.进行[副本id]={进程=3}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102021 then
		副本数据.青丘迷雾.进行[副本id]={进程=4}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102022 then
		副本数据.青丘迷雾.进行[副本id]={进程=5}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102023 then
		副本数据.青丘迷雾.进行[副本id]={进程=6}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102024 then
		副本数据.青丘迷雾.进行[副本id]={进程=7}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102025 then
		副本数据.青丘迷雾.进行[副本id]={进程=8}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102026 then
		副本数据.青丘迷雾.进行[副本id]={进程=9}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102027 then
		副本数据.青丘迷雾.进行[副本id]={进程=10}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	elseif 战斗类型 == 102028 then
		副本数据.青丘迷雾.进行[副本id]={进程=11}
		任务数据[任务id].zhandou = nil
		刷新任务410(副本id)
		刷新队伍任务追踪(id)
		self:完成奖励(id组,战斗类型)
	end
end

function 副本_青丘迷雾:完成奖励(id组,战斗类型,倍率)
	local  倍率 =倍率 or 1
	if 战斗类型 == 102020 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="4级宝石礼包"
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
	elseif 战斗类型 == 102021 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
       					if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露小丸子"
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
	elseif 战斗类型 == 102022 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="4级宝石礼包"
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
	elseif 战斗类型 == 102023 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="4级宝石礼包"
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
	elseif 战斗类型 == 102024 then
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=26 then
				local 奖励参数=取随机数(1,100)
				local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				-- elseif 奖励参数<=26 then
				-- 	local 名称="高级魔兽要诀"
				-- 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="4级宝石礼包"
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
	elseif 战斗类型 == 102025 then
		local stid=取随机数(1,#id组)
		stid=id组[stid]
		 --    local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[stid].角色.名称),频道="xt",结尾="#Y！"}
			-- 玩家数据[stid].道具:给予超链接书铁(stid,{10,10},nil,链接)
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
    			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=50 then
				local 奖励参数=取随机数(1,100)
				 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="未激活的星石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				end
			end
		end
	elseif 战斗类型 == 102026 then
		local stid=取随机数(1,#id组)
		stid=id组[stid]
		 --    local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[stid].角色.名称),频道="xt",结尾="#Y！"}
			-- 玩家数据[stid].道具:给予超链接书铁(stid,{10,10},nil,链接)
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
    			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=50 then
				local 奖励参数=取随机数(1,100)
				链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=28 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=55 then
					local 名称="九转金丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,100,链接)
				elseif 奖励参数<=60 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="未激活的星石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				end
			end
		end
	elseif 战斗类型 == 102027 then
		local stid=取随机数(1,#id组)
		stid=id组[stid]
		 --    local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[stid].角色.名称),频道="xt",结尾="#Y！"}
			-- 玩家数据[stid].道具:给予超链接书铁(stid,{10,10},nil,链接)
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+500000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
    			玩家数据[cyid].角色:添加副本积分(20)
			if 取随机数()<=50 then
				local 奖励参数=取随机数(1,100)
				链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="4级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="未激活的星石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				end
			end
		end
	elseif 战斗类型 == 102028 then
		local stid=取随机数(1,#id组)
		stid=id组[stid]
		 --    local 链接={提示=format("#S(青丘迷雾)#Y梦幻西游为新手玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[stid].角色.名称),频道="xt",结尾="#Y！"}
			-- 玩家数据[stid].道具:给予超链接书铁(stid,{10,10},nil,链接)
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(15000,16000)
			local 银子=等级*取随机数(110,120)+2000000
			玩家数据[cyid].角色:添加经验(经验*倍率,"青丘迷雾")
			玩家数据[cyid].角色:添加银子(银子*倍率,"青丘迷雾",1)
    			玩家数据[cyid].角色:添加副本积分(200)
			if 取随机数()<=50 then
				local 奖励参数=取随机数(1,100)
				链接={提示=format("#S(青丘迷雾)#Y梦幻西游为玩家打造的副本，#G/%s#Y少侠在青丘迷雾中跌跌撞撞，竟然得到了珍贵的",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
        				if 奖励参数<=10 then
					local 名称="仙露丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=15 then
					local 名称="四神石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=20 then
					local 名称="高级魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="摇钱树苗"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="特技书"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="修炼果"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称="仙露小丸子"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)

				elseif 奖励参数<=60 then
					local 名称="4级宝石礼包"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=80 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=81 then
					local 名称="神兜兜"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				else
					local 名称="未激活的星石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				end
			end
		end
	end
end

function 副本_青丘迷雾:任务说明(玩家id,任务id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.青丘迷雾.进行[副本id]==nil then
		说明={"青丘迷雾","#L您的副本已经完成"}
	else
		local 进程=副本数据.青丘迷雾.进行[副本id].进程
		       if 进程==1 then
			说明={"青丘迷雾",format("#L和".."#Y/qqq|花铃*8555*临时npc*125*68/花铃".."#L打声招呼吧。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==2 then
			说明={"青丘迷雾",format("#L好像".."#Y/qqq|花铃*8555*临时npc*125*68/花铃".."#L有什么需要帮助的，去看看。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==3 then
			说明={"青丘迷雾",format("#L另一侧，".."#Y/qqq|入侵妖魔*8555*临时npc*130*48/入侵妖魔".."#L开始进攻青丘迷雾了。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==4 then
			说明={"青丘迷雾",format("#L突然出现了一条恐怖的".."#Y/qqq|裂缝*8555*临时npc*73*61/裂缝".."#L到底怎么回事。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==5 then
			说明={"青丘迷雾",format("#L那边那边还有一条".."#Y/qqq|裂缝*8555*临时npc*81*82/裂缝".."#L到底怎么回事。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==6 then
			说明={"青丘迷雾",format("#L好像".."#Y/qqq|阿宝*8555*临时npc*18*82/阿宝".."#L被绑架了，救出#G阿宝。#L(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==7 then
			说明={"青丘迷雾",format("#L去问问一旁的".."#Y/qqq|涂山瞳*8555*临时npc*26*52/涂山瞳".."#L好像知道些什么。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==8 then
			说明={"青丘迷雾",format("#L去问问一旁的".."#Y/qqq|有苏鸩*8555*临时npc*68*63/有苏鸩".."#L好像知道些什么。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==9 then
			说明={"青丘迷雾",format("#L去找".."#Y/qqq|月魅*8555*临时npc*33*19/月魅".."#L,问问怎么回事。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==10 then
			说明={"青丘迷雾",format("#L原来".."#Y/qqq|涂山雪*8555*临时npc*101*20/涂山雪".."#L就在前面，快去抓住他。(剩余时间%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		end
	end
	return 说明
end



function 副本_青丘迷雾:扫荡(队长id)
    if not 玩家数据[队长id].道具:判定背包道具(队长id,"扫荡卡",1) then
       	常规提示(队长id,"#Y/扫荡副本需消耗1个扫荡卡")
    	return
    end
    玩家数据[队长id].道具:消耗背包道具(玩家数据[队长id].连接id,队长id,"扫荡卡",1)

    local 副本等级 = 50
    local 人数 = 5
    if 调试模式 then 人数 = 1 end -- 调试模式支持1人
    local 队伍id = 玩家数据[队长id].队伍

    -- 校验队长身份
    if 玩家数据[队长id].队伍 == 0 or 玩家数据[队长id].队长 == false then
        常规提示(队长id, "#Y该任务必须组队完成且由队长操作")
        return
    end
    -- 校验队伍人数
    if 取队伍人数(队长id) < 人数 and not 调试模式 then
        常规提示(队长id, "#Y此副本要求队伍人数不低于"..人数.."人")
        return
    end
    -- 校验等级（最低50级）
    if 取等级要求(队长id, 副本等级) == false then
        常规提示(队长id, "#Y此副本要求角色等级不能低于"..副本等级.."级")
        return
    end
    -- 校验队员状态（未完成+无其他副本任务）
    for n=1,#队伍数据[队伍id].成员数据 do
        local 临时id = 队伍数据[队伍id].成员数据[n]
        if 副本数据.青丘迷雾.完成[临时id] ~= nil then
            常规提示(队长id, "#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
            return
        end
    end

    -- 2. 初始化副本数据（模拟正常开启，支撑奖励发放）
    local 队伍成员列表 = 队伍数据[队伍id].成员数据
    local 副本id = 队长id
    local 主任务id, ZU = 取唯一任务(410, 副本id) -- 复用原任务ID生成逻辑

    -- 初始化副本进程（直接设为最终进程11，跳过中间环节）
    副本数据.青丘迷雾.进行[副本id] = {
        进程 = 11
    }
    -- 初始化主任务数据（符合原数据结构）
    任务数据[主任务id] = {
        id = 主任务id,
        起始 = os.time(),
        结束 = 7200,
        玩家id = 0,
        DWZ = ZU,
        销毁 = true,
        副本重置 = true,
        队伍组 = ZU,
        副本id = 副本id,
        类型 = 410
    }

    -- 3. 核心：发放所有战斗奖励（遍历原副本9种战斗类型）
    local 所有战斗类型 = {
        102020, -- 花铃求助（20积分）
        102021, -- 入侵妖魔（20积分）
        102022, -- 裂缝1（20积分）
        102023, -- 裂缝2（20积分）
        102024, -- 解救阿宝（20积分）
        102025, -- 涂山瞳（20积分）
        102026, -- 有苏鸩（20积分）
        102027, -- 月魅（20积分）
        102028  -- 涂山雪（200积分，高额银子）
    }
    -- 遍历战斗类型，调用原奖励函数发放奖励
    local 倍率=0.8
    for _, 战斗类型 in ipairs(所有战斗类型) do
        self:完成奖励(队伍成员列表, 战斗类型,倍率)
    end
    -- 5. 副本完成：标记状态+清理数据
    for _, 临时id in ipairs(队伍成员列表) do
        -- 标记副本完成，更新每日任务
        副本数据.青丘迷雾.完成[临时id] = true
        -- 更新玩家每日(临时id, "副本任务", "青丘迷雾")
        -- 取消主任务，刷新任务追踪
        常规提示(临时id, "#Y恭喜！已直接完成青丘迷雾副本，所有奖励已发放！")
        if 玩家数据[临时id] and 玩家数据[临时id].连接id then
            发送数据(玩家数据[临时id].连接id, 550.3,{青丘迷雾=true})
        end
    end
end

return 副本_青丘迷雾
