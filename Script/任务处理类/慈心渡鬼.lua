local sj = 取随机数
local format = string["format"]
local insert = table["insert"]
local ceil = math["ceil"]
local floor = math["floor"]
local wps = 取物品数据
local typ = type
local random = 取随机数
local 慈心渡鬼 = class()

-- if f函数.文件是否存在([[活动时间/慈心渡鬼.txt]])==false then
--  慈心渡鬼活动时间={日期="周6",时=21,分=0,秒=0,结束=60*90} -- 设置时间
--   写出文件([[活动时间/慈心渡鬼.txt]],table.tostring(慈心渡鬼活动时间))
--  else
--   慈心渡鬼活动时间=table.loadstring(读入文件([[活动时间/慈心渡鬼.txt]]))
-- end

function 慈心渡鬼:初始化()
	self.活动开关 = false
	self.活动时间 = QJHDSJ["慈心渡鬼"]
end

function 慈心渡鬼:定时器()
    	if self.活动开关 then
		if self.开启Time-os.time()<0 then
			self:关闭活动()
		end
   	else
      		local zhouji=tonumber(os.date("%w", os.time()))
      		if zhouji == self.活动时间.日期 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
          		elseif self.活动时间.日期=="每天"  then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
      		elseif self.活动时间.日期=="周1" and zhouji==1 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
          		elseif self.活动时间.日期=="周2" and zhouji==2 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
          		elseif self.活动时间.日期=="周3" and zhouji==3 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
          		elseif self.活动时间.日期=="周4" and zhouji==4 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
      		elseif self.活动时间.日期=="周5" and zhouji==5 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
      		elseif self.活动时间.日期=="周6" and zhouji==6 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
          		elseif self.活动时间.日期=="周日" and zhouji==0 then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
      		elseif self.活动时间.日期=="周135" and (zhouji==1 or zhouji==3 or zhouji==5) then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
      		elseif self.活动时间.日期=="周1350" and (zhouji==1 or zhouji==3 or zhouji==5 or zhouji==0 ) then
         			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
      		elseif self.活动时间.日期=="周246" and (zhouji==2 or zhouji==4 or zhouji==6) then
          			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
              			self:开启活动()
          			end
      		end
    	end
end


function 慈心渡鬼:开启活动()
	self.开启Time=os.time()+5400
	self["活动开关"] = true
	发送公告("#P(慈心渡鬼)#Y普天盛会，慈心渡鬼已开启！大家可以到宝象国#P叶法善（91.17）#Y领取慈心渡鬼任务了！")
	广播消息({
		["频道"] = "hd",
		["内容"] = format("#P(慈心渡鬼)#Y普天盛会，慈心渡鬼已开启！大家可以到宝象国#P叶法善（91.17）#Y领取慈心渡鬼任务了！")
	})
end

function 慈心渡鬼:关闭活动()
	self["数据"] = {}
	self["活动开关"] = false
	self["开启Time"] = nil

	发送公告("#R(慈心渡鬼)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！")
	广播消息({
		["频道"] = "hd",
		["内容"] = format("#R(慈心渡鬼)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！")
	})
end

__GWdh111[8930] = function (连接id, 数字id, 序列, 标识, 地图)
	local 对话数据 = {
		["模型"] = 任务数据[标识]["模型"],
		["名称"] = 任务数据[标识]["名称"]
	}

	if 任务数据[标识]["zhandou"] == nil then
		if 玩家数据[数字id]["角色"]:取任务(8930) == 标识 then
			对话数据["对话"] = "要想收集此地的祥和之气，必须通过我的考验！你可准备好了？"
			对话数据["选项"] = {
				"仙人请赐教",
				"等我做做准备工作"
			}
		else
			对话数据["对话"] = "我好像不认识你吧？？？"
		end
	else
		对话数据["对话"] = "我正在战斗中，请勿打扰。"
	end

	return 对话数据
end

__GWdh222[8930] = function (连接id, 数字id, 序号, 内容)
	local 事件 = 内容[1]
	local 名称 = 内容[3]

	if 事件 == "仙人请赐教" then
		if 任务数据[玩家数据[数字id]["地图单位"]["标识"]]["zhandou"] ~= nil then
			常规提示(数字id, "#Y/对方正在战斗中")

			return
		end

		if 玩家数据[数字id]["队伍"] == nil then
			常规提示(数字id, "#Y/请先组队！")

			return
		end

		local 符合 = false

		for n = 1, #任务数据[玩家数据[数字id]["地图单位"]["标识"]]["队伍组"] do
			if 任务数据[玩家数据[数字id]["地图单位"]["标识"]]["队伍组"][n] == 数字id then
				符合 = true
			end
		end

		if 符合 then
			战斗准备类:创建战斗(数字id + 0, 155700, 玩家数据[数字id]["地图单位"]["标识"])

			任务数据[玩家数据[数字id]["地图单位"]["标识"]]["zhandou"] = true
			玩家数据[数字id]["地图单位"] = nil
		else
			发送数据(玩家数据[数字id]["连接id"], 1501, {
				["内容"] = "你是谁？我们认识吗#55",
				["模型"] = 任务数据[玩家数据[数字id]["地图单位"]["标识"]]["模型"],
				["名称"] = 任务数据[玩家数据[数字id]["地图单位"]["标识"]]["名称"]
			})
		end

		return
	end
end

function 设置任务8930(id)
	if 玩家数据[id]["队伍"] == 0 or 玩家数据[id]["队长"] == false then
		添加最后对话(id, "#Y/该任务必须组队完成且由队长领取")

		return
	elseif 取队伍最低等级(玩家数据[id]["队伍"], 20) then
		添加最后对话(id, "#Y/等级小于20级的玩家无法领取此任务")

		return
	elseif 取队伍任务(玩家数据[id]["队伍"], 8930) then
		添加最后对话(id, "#Y/队伍中已有队员领取过此任务了")

		return
	elseif 玩家数据[id]["角色"]:取任务(8930) ~= 0 then
		添加最后对话(id, "#Y/你已经有个赌鬼任务在进行了")

		return
	elseif 取队伍人数(id) < 5 and 调试模式 == false then
		常规提示(id, "#Y此任务要求队伍人数不低于5人")

		return
	end

	local 任务id = id .. "_8930_" .. os["time"]() .. "_" .. 随机序列 .. "_" .. 取随机数(88, 99999999)
	local 地图范围 = {
		1501,
		1092,
		1070,
		1193,
		1173,
		1146,
		1140,
		1208,
		1040,
		1226,
		1142
	}
	local 地图 = 地图范围[取随机数(1, #地图范围)]
	local 随机参数 = 取随机数()
	local 模型 = "夜罗刹"

	if 随机参数 <= 10 then
		模型 = "炎魔神"
	elseif 随机参数 <= 20 then
		模型 = "噬天虎"
	elseif 随机参数 <= 30 then
		模型 = "吸血鬼"
	elseif 随机参数 <= 40 then
		模型 = "龙龟"
	elseif 随机参数 <= 50 then
		模型 = "踏云兽"
	elseif 随机参数 <= 60 then
		模型 = "灵鹤"
	elseif 随机参数 <= 70 then
		模型 = "雾中仙"
	elseif 随机参数 <= 80 then
		模型 = "大力金刚"
	elseif 随机参数 <= 90 then
		模型 = "踏云兽"
	elseif 随机参数 <= 90 then
		模型 = "鬼将"
	end

	local 名称库 = {
		"天乾",
		"地坤",
		"雷震",
		"风巽",
		"水坎",
		"山艮",
		"火离",
		"木兑"
	}
	local 种类库 = {
		"鬼",
		"仙",
		"魔",
		"魂",
		"妖",
		"灵"
	}
	local 名称 = 名称库[取随机数(1, #名称库)] .. 种类库[取随机数(1, #种类库)]
	local xy = 地图处理类["地图坐标"][地图]:取随机点()
	local x临时人物队伍 = {}

	if 玩家数据[id]["队伍"] ~= nil and 玩家数据[id]["队伍"] ~= 0 then
		for i = 1, #队伍数据[玩家数据[id]["队伍"]]["成员数据"] do
			if 队伍数据[玩家数据[id]["队伍"]]["成员数据"][i] ~= nil then
				x临时人物队伍[#x临时人物队伍 + 1] = 队伍数据[玩家数据[id]["队伍"]]["成员数据"][i]
			end
		end
	end

	任务数据[任务id] = {
		["玩家id"] = 0,
		["结束"] = 10800,
		["类型"] = 8930,
		["领取人id"] = x临时人物队伍,
		id = 任务id,
		["起始"] = os["time"](),
		["队伍组"] = table["loadstring"](table["tostring"](队伍数据[玩家数据[id]["队伍"]]["成员数据"])),
		["名称"] = 名称,
		["模型"] = 模型,
		x = xy["x"],
		y = xy["y"],
		["地图编号"] = 地图,
		["地图名称"] = 取地图名称(地图)
	}

	地图处理类:添加单位(任务id)

	local 队伍id = 玩家数据[id]["队伍"]

	for n = 1, #队伍数据[队伍id]["成员数据"] do
		local 临时id = 队伍数据[队伍id]["成员数据"][n]
		玩家数据[临时id]["角色"]["捉鬼数据"]["次数"] = 玩家数据[临时id]["角色"]["捉鬼数据"]["次数"] + 1

		玩家数据[临时id]["角色"]:添加任务(任务id)
		发送数据(玩家数据[临时id]["连接id"], 1501, {
			["名称"] = "叶法善",
			["模型"] = "刘老爹",
			["对话"] = format("据这善恶棋盘现实，少侠需去寻找#Y/%s#W/接受其考验，他就在#G/%s(%s,%s)", 任务数据[任务id]["名称"], 任务数据[任务id]["地图名称"], 任务数据[任务id]["x"], 任务数据[任务id]["y"])
		})
	end

	return {
		["坐标"] = xy,
		["地图编号"] = 地图
	}
end

function 胜利MOB_155700(胜利id, 战斗数据, id组)
	for i = 1, #id组 do
		local id = id组[i]
		local 等级1 = 玩家数据[id]["角色"]["等级"]
		local 等级 = 取队伍平均等级(玩家数据[id]["队伍"], id)
		local 经验 = qz(等级 * 等级 + 58000)
		local 银子 = 等级 * 80 + 51460
		玩家数据[id]["角色"]:添加经验(经验 * HDPZ["慈心渡鬼"]["经验"], "慈心渡鬼")
		玩家数据[id]["角色"]:添加银子(银子 * HDPZ["慈心渡鬼"]["银子"], "慈心渡鬼", 1)
		玩家数据[id]["角色"]:取消任务(战斗数据["任务id"])
		玩家数据[id].角色:添加除妖军功(1)

		if 取随机数()<=HDPZ["慈心渡鬼"].爆率 then
		local 链接 = {提示=format("#P(慈心渡鬼)#W玩家#Y%s#W从尸体里搜索出一个",玩家数据[id].角色.名称),频道="hd",结尾="#W以资鼓励！"}
		local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["慈心渡鬼"].ITEM),"慈心渡鬼")
			if 数量== 9999 then --环
				玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
			else
				玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
			end
		end
	end

	地图处理类:删除单位(任务数据[战斗数据["任务id"]]["地图编号"], 任务数据[战斗数据["任务id"]]["单位编号"])

	任务数据[战斗数据["任务id"]] = nil
end

function rwgx8930(任务id)
	if 任务数据[任务id]["结束"] <= os["time"]() - 任务数据[任务id]["起始"] and 任务数据[任务id]["zhandou"] == nil then
		地图处理类:删除单位(任务数据[任务id]["地图编号"], 任务数据[任务id]["单位编号"])

		任务数据[任务id] = nil
	end
end

function 任务说明8930(玩家id, 任务id)
	local 说明 = {}
	说明 = {
		"慈心渡鬼",
		format("去#G/%s#W/的#Y/(%s,%s) #W/找到#R/qqq|%s*%s*临时npc*%s*%s/%s#W/并接受其挑战！剩下时间" .. 取分(任务数据[任务id]["结束"] - (os["time"]() - 任务数据[任务id]["起始"])) .. "#W/分钟。", 任务数据[任务id]["地图名称"], 任务数据[任务id]["x"], 任务数据[任务id]["y"], 任务数据[任务id]["名称"], 任务数据[任务id]["地图编号"], 任务数据[任务id]["x"], 任务数据[任务id]["y"], 任务数据[任务id]["名称"])
	}

	return 说明
end

return 慈心渡鬼
