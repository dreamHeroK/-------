-- @Author: ASUS
-- @Date:   2020-11-26 19:03:42
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-04-23 09:41:30
function 保存系统数据(类型)
	if 类型 == 1 then
		lastKey = {}
		for n, v in pairs(玩家数据) do
			if 玩家数据[n] and 玩家数据[n].角色 then
				lastKey[n] = 1
			end
		end
	end
	for n, v in pairs(玩家数据) do
		if 玩家数据[n] and 玩家数据[n].角色 then
			if 类型 == 1 then
				玩家数据[n].角色:存档()
			elseif 类型 == 2 then
				玩家数据[n].角色:存档1()
				print(玩家数据[n].角色.名称,"存档成功")
			end
		end
	end
	__S服务:输出("保存玩家数据成功……")
    	保存帮派数据()
	当前时间=os.time()
	当前年份=os.date("%Y",当前时间)
	当前月份=os.date("%m",当前时间)
	当前日份=os.date("%d",当前时间)
	保存时间=os.date("%H",当前时间).."时"..os.date("%M",当前时间).."分"..os.date("%S",当前时间).."秒 "
	if f函数.文件是否存在([[log\]]..当前年份)==false then
		lfs.mkdir([[log\]]..当前年份)
	end
	if f函数.文件是否存在([[log\]]..当前年份..[[\]]..当前月份)==false then
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份)
	end
	if f函数.文件是否存在([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份)==false then
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份)
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."登录日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."在线日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."备份日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."藏宝阁日志")
	end
	if #错误日志<500 then
		local 保存语句=""
		for n=1,#错误日志 do
			保存语句=保存语句..时间转换(错误日志[n].时间)..'：#换行符'..错误日志[n].记录..'#换行符'..'#换行符'
		end
		写出文件([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志"..[[\]]..保存时间..".txt",保存语句)
	else
		local 文件名称=保存时间
		local 计次数量=0
		local 保存语句=""
		for n=1,#错误日志 do
			保存语句=保存语句..时间转换(错误日志[n].时间)..'：#换行符'..错误日志[n].记录..'#换行符'..'#换行符'
			计次数量=计次数量+1
			if 计次数量>=500 then
				写出文件([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志"..[[\]]..文件名称.."_"..n..".txt",保存语句)
				计次数量=0
				保存语句=""
			end
		end
	end
	日志统计={}
	错误日志={}
	写出文件([[sql/魔1次数.txt]],table.tostring(魔1次数))
	写出文件([[sql/魔2次数.txt]],table.tostring(魔2次数))
	写出文件([[sql/魔3次数.txt]],table.tostring(魔3次数))
	写出文件([[sql/魔4次数.txt]],table.tostring(魔4次数))
	写出文件([[sql/魔5次数.txt]],table.tostring(魔5次数))
	写出文件([[sql/精锐六九次数.txt]],table.tostring(精锐六九次数))
	写出文件([[sql/勇武八九次数.txt]],table.tostring(勇武八九次数))
	写出文件([[sql/神威一零九次数.txt]],table.tostring(神威一零九次数))
	写出文件([[sql/天科一二九次数.txt]],table.tostring(天科一二九次数))
	写出文件([[sql/天启一五五次数.txt]],table.tostring(天启一五五次数))
	写出文件([[sql/天元一七五次数.txt]],table.tostring(天元一七五次数))
	写出文件([[sql/妖魔尊主次数.txt]],table.tostring(妖魔尊主次数))
	写出文件([[sql/葫芦娃次数.txt]],table.tostring(葫芦娃次数))
	写出文件([[sql/挑战师傅次数.txt]],table.tostring(挑战师傅次数))
	写出文件([[sql/童子之力次数.txt]],table.tostring(童子之力次数))
	写出文件([[sql/罗刹鬼将次数.txt]],table.tostring(罗刹鬼将次数))
	写出文件([[sql/十八路妖王.txt]],table.tostring(十八路妖王))
	写出文件([[sql/全局签到数据.txt]],table.tostring(全局签到数据))
	写出文件([[sql/藏宝阁数据.txt]],table.tostring(藏宝阁数据))
	写出文件([[sql/蚩尤次数.txt]],table.tostring(蚩尤次数))
	写出文件([[sql/寄存数据.txt]],table.tostring(寄存数据))
	写出文件([[sql/采矿活动.txt]],table.tostring(采矿活动))
	写出文件([[sql/每日充值.txt]],table.tostring(每日充值))
	写出文件([[sql/红包记录.txt]],table.tostring(红包记录))
	写出文件([[sql/剑会天下.txt]],table.tostring(剑会天下))
	写出文件([[sql/世界挑战.txt]],table.tostring(世界挑战))
	写出文件([[sql/世界排行.txt]],table.tostring(世界排行))
	写出文件([[sql/代理系统.txt]],table.tostring(代理系统))
    	写出文件([[sql/活跃数据.txt]],table.tostring(活跃数据))
	写出文件([[sql/副本每日.txt]],table.tostring(__副本每日))
	写出文件([[sql/副本数据.txt]],table.tostring(副本数据))
	写出文件([[sql/仙玉数据.txt]],table.tostring(仙玉数据))
	写出文件([[sql/时空之钥.txt]],table.tostring(时空之钥))--------------佬伍修改（增加种族秘境时空之钥）
	写出文件([[sql/双龙之战.txt]],table.tostring(双龙之战))------------------------C改双龙
	写出文件([[sql/代理充值.txt]],table.tostring(代理充值))------------------------C改
	写出文件([[sql/玉魄洗练次数.txt]],table.tostring(玉魄洗练次数))
	雁塔地宫:保存数据()
	商会处理类:保存数据()
	游戏活动类:保存科举排行榜()
	保存玩家刷怪次数数据()
	-- if 充值7日排行 then
	-- 写出文件([[sql/充值7日排行.txt]],table.tostring(充值7日排行))
	-- end
	写出文件([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."藏宝阁日志"..[[\]]..保存时间..".txt",藏宝阁记录)
    藏宝阁记录 = ""
    __S服务:输出("藏宝阁记录保存成功……")
	__S服务:输出("错误日志保存成功……")
end

function 保存玩家数据()
	for n, v in pairs(玩家数据) do
		if 玩家数据[n] and 玩家数据[n].角色 then
			print("存档开始 id="..n)
			玩家数据[n].角色:存档()
		end
	end
	__S服务:输出("保存玩家数据成功……")
end

function 保存师徒数据()
写出文件([[sql/师徒数据.txt]],table.tostring(师徒数据))
end

function 保存帮派数据()
	local llsj={}
	local 数量=0
	for n, v in pairs(任务数据) do --罗庚  回梦丹  打造
		if v.是存档 then
			数量=数量+1
			llsj[数量]=table.loadstring(table.tostring(任务数据[n]))
			llsj[数量].存储id=n
		end
	end
	写出文件([[sql/任务数据.txt]],table.tostring(llsj))
	llsj=nil
	__S服务:输出("保存任务数据成功……")

	for k,v in pairs(取所有帮派) do
		if v.已解散 then
	    	local sdfew="bpsj/帮派数据"..k..".txt"
			写出文件(sdfew,table.tostring({}))
		else
		    local sdfew="bpsj/帮派数据"..k..".txt"
			写出文件(sdfew,table.tostring(帮派数据[k]))
		end
	end
	__S服务:输出("保存帮派数据成功……")
end

function 写出封禁记录(账号,数字id,ip)
	封禁记录[账号]={id=数字id,ip=ip}
	写出文件([[WPE/封禁记录.txt]],table.tostring(封禁记录))
	__S服务:输出("写出封禁记录成功")
end


function 强制下线()
	for n, v in pairs(战斗准备类.战斗盒子) do
		if 战斗准备类.战斗盒子[n]~=nil  then
			战斗准备类.战斗盒子[n]:结束战斗(0,0,1,1)
		end
	end
	for n, v in pairs(玩家数据) do
		if 玩家数据[n]~=nil and 玩家数据[n].连接id ~= "假人" then
			玩家数据[n].角色:存档()
			系统处理类:断开游戏(n)
		end
	end
end

function 取剧情是否追踪(主线,等级)

	local JQsj={0,0,25,55,75,80,85,135,155}
	-- local JQsj={0,0,25,9999}
	if JQsj[主线] and 等级>=JQsj[主线] then
	    return true
	end
	return false
end

function 打印在线时间()
	local 语句=""
	for n, v in pairs(在线时间) do
		语句=语句..string.format("角色id：%s，本日累积在线：%s秒#换行符",n,在线时间[n])
	end
	写出文件("在线时间.txt",语句)
end

function 异常账号(数字id,信息)
	 __S服务:输出(信息)
end

function 查看在线列表()
	local 列表=""
	for n, v in pairs(玩家数据) do
		列表=列表..format("账号%s,角色id%s",玩家数据[n].账号,n)..'#换行符'..'#换行符'
	end
	写出文件("在线列表.txt",列表)
end