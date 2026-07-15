-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:15:06
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-03-20 21:29:25
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__GWdh111[210]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		if 任务数据[标识].zhandou==nil then
			对话数据.对话="看本大王敲破你们的脑袋#24#R（本活动需要五人组队参加且人物等级必须达到60级）"
			对话数据.选项={"知了还这么嚣张？讨打！","大王好厉害哟"}
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	return 对话数据
end

__GWdh222[210]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="知了还这么嚣张？讨打！" then
		if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
		if 取队伍人数(数字id)<5  then 常规提示(数字id,"#Y挑战知了王最少必须由五人进行") return  end
		if 取等级要求(数字id,69)==false then 常规提示(数字id,"#Y/挑战知了王需要69级") return  end
		战斗准备类:创建战斗(数字id+0,100027,玩家数据[数字id].地图单位.标识)
		任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
		玩家数据[数字id].地图单位=nil
		return
	end
end

function 设置任务210()
	local 地图范围={1193,1506,1091,1110,1514}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	local 提示名称=""
	--xy={x=25,y=18}
	local 结束时间=3500
	local 数量=取随机数(8,15)
	local 地图=地图范围[取随机数(1,#地图范围)]
	local x待发送数据={}
	x待发送数据[地图]={}
	for i=1,数量 do
		local 任务id="_"..i.."_"..取随机数(11,88).."_105_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
		随机序列=随机序列+1
		local xy=地图处理类.地图坐标[地图]:取随机点()
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=结束时间,
			玩家id=0,
			队伍组={},
			名称="知了王",
			模型="知了王",
			x=xy.x,
			y=xy.y,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=210
		}
		table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))--修改
	end
	for n, v in pairs(地图处理类.地图玩家[地图]) do
		if n~=id and 地图处理类:取同一地图(地图,id,n,1)  then
			发送数据(玩家数据[n].连接id,1021,x待发送数据[地图])
		end
	end
	x待发送数据={}
	广播消息({内容=format("#W/一批知了王出现在了#G/%s#W/处捣乱，还请各位英雄侠士赶紧去降服它们。",取地图名称(地图)),频道="xt"})
end

function rwgx210(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
		if 任务数据[任务id].zhandou==nil  then
			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
			任务数据[任务id]=nil
		end
	end
end