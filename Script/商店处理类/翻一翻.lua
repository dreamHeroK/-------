--======================================================================--
--======================================================================--
local 翻一翻 = class()
local 物品表={}
物品表["2倍"]=8
物品表["3倍"]=5
物品表["4倍"]=3
物品表["5倍"]=1
-- 物品表["6倍"]=1
-- 物品表["7倍"]=1
-- 物品表["8倍"]=1
-- 物品表["9倍"]=1
-- 物品表["10倍"]=1
-----------------
物品表["星辉石"]=3
物品表["舍利子"]=3
物品表["红玛瑙"]=3
物品表["黑宝石"]=3
物品表["光芒石"]=3
物品表["月亮石"]=3
物品表["太阳石"]=3
物品表["精魄灵石"]=3
------------
物品表["灵饰洗练石"]=3
物品表["灵饰属性石"]=3
物品表["装备属性石"]=3
物品表["数值洗练石"]=3
物品表["属性洗练石"]=3
物品表["装备词条石"]=3
物品表["词条洗练石"]=3
物品表["词条属性石"]=3
物品表["灵兜兜"]=1
物品表["内丹开孔丸"]=3
物品表["武器专属石"]=3
物品表["技能书"]=2
物品表["五彩神石"]=5
物品表["本命法宝礼包"]=2
物品表["不磨符"]=1
物品表["大金砖"]=1
物品表["神兜兜"]=10
物品表["仙露丸子"]=10
物品表["玉刚卯"]=10
物品表["神兜兜礼包"]=1
物品表["奖池抽奖"]=3

物品表["特效宝珠"]=5
物品表["愤怒符"]=1
物品表["特技书"]=5
物品表["特殊清灵仙露"]=2
物品表["特殊兽诀·碎片"]=10
---------------
物品表["高级藏宝图"]=10
----------------
物品表["修炼果"]=5
----------------
物品表["高级召唤兽内丹"]=5
----------------
物品表["玉灵果"]=4
----------------
物品表["经验"]=5
----------------

if RpbARGB==1 then
	物品表["灵饰洗练石"]=0
	物品表["特效宝珠"]=1
end


function shuffleTable(tbl)
    for i = #tbl, 2, -1 do
        local j =  math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

-- 调用函数打乱物品表的顺序

local function 按概率选择物品(物品表, 数量)
  local 选择的物品 = {}
  -- 计算概率总和
  local 总概率 = 0
  for _, 概率 in pairs(物品表) do
    总概率 = 总概率 + 概率
  end
  -- 按照概率选择物品
  for i = 1, 数量 do
    local 随机数 = math.random(1, 总概率)
    local 累计概率 = 0
    for 物品, 概率 in pairs(物品表) do
      累计概率 = 累计概率 + 概率
      if 随机数 <= 累计概率 then
        table.insert(选择的物品, 物品)
        break
      end
    end
  end
  return 选择的物品
end


function 翻一翻:初始化()
	self.数据 = {}
	--self:请求开始()
end


function 翻一翻:数据处理(连接id,数字id,序号,数据) --序号>6600 and 序号<=6620
	数字id = 数字id+0
	if 序号 == 6601 then
		self:打开翻一番(数字id)
	elseif 序号 == 6602 then
		self:游戏开始(数字id)
	elseif 序号 == 6603 then
		self:翻牌请求(数字id,数据)
	elseif 序号 == 6604 then
		self:领取奖励(数字id)
	end
end
function 翻一翻:游戏开始(数字id)
	local goo
	if 玩家数据[数字id].角色:消耗翻一番(1) then
		goo=true
	else
		if 玩家数据[数字id].角色:扣除仙玉(120,"翻一翻") then
			goo=true
		end
	end
	if goo then
		local wprs=按概率选择物品(物品表, 9)
		self.数据[数字id]={翻倍倍数=1,进行次数=0,开始游戏=false,道具=wprs,奖励数据={}}
		--table.print(self.数据[数字id])
		发送数据(玩家数据[数字id].连接id,6602,{shuffleTable(table.copy(wprs))})
	end
end

function 翻一翻:打开翻一番(数字id)
	if not 玩家数据[数字id].角色.翻一番 then
		玩家数据[数字id].角色.翻一番=0
	end
	发送数据(玩家数据[数字id].连接id,6601,{进行次数=0,剩余次数=玩家数据[数字id].角色.翻一番})
end


local function 递增函数(n)
	if n==0 then
	    return 0
	end
	return 120 * 2^(n-1)
end
-- local f=0
-- for i=0,8 do
-- 	print(递增函数(i))
-- 	f=f+递增函数(i)
-- end --6375
-- print(f)

local beilv={}
beilv["2倍"]=2
beilv["3倍"]=3
beilv["4倍"]=4
beilv["5倍"]=5
beilv["6倍"]=6
beilv["7倍"]=7
beilv["8倍"]=8
beilv["9倍"]=9
beilv["10倍"]=10
function 翻一翻:翻牌请求(数字id,数据)
	local 物品编号=数据.bh
	if self.数据[数字id] and self.数据[数字id].道具 and self.数据[数字id].道具[物品编号]  then
		local 消耗仙玉=递增函数(self.数据[数字id].进行次数)
		if 玩家数据[数字id].角色:扣除仙玉(消耗仙玉,"翻一翻") then
			local wp=self.数据[数字id].道具[物品编号]
			if beilv[wp] then
				self.数据[数字id].翻倍倍数=beilv[wp]
			end
			self.数据[数字id].奖励数据[#self.数据[数字id].奖励数据+1]=wp
			self.数据[数字id].进行次数=self.数据[数字id].进行次数+1
			发送数据(玩家数据[数字id].连接id,6603,{倍率=self.数据[数字id].翻倍倍数,进行次数=self.数据[数字id].进行次数,剩余次数=玩家数据[数字id].角色.翻一番,物品=wp,物品编号=物品编号})
		end
	end
end


local __Funfa={}
__Funfa["高级摄灵珠"]=function(玩家等级)
	return "高级摄灵珠",1,取随机数(10,30)
end
__Funfa["九转金丹"]=function(玩家等级)
	return "九转金丹",取随机数(200,300)
end
__Funfa["怪物卡片"]=function(玩家等级)
	return "怪物卡片",取随机数(2,8)
end
__Funfa["星辉石"]=function(玩家等级)
	return "星辉石",取随机数(5,12)
end
__Funfa["黑宝石"]=function(玩家等级)
	return "黑宝石",取随机数(5,12)
end
__Funfa["红玛瑙"]=function(玩家等级)
	return "红玛瑙",取随机数(5,12)
end
__Funfa["舍利子"]=function(玩家等级)
	return "舍利子",取随机数(5,12)
end
__Funfa["光芒石"]=function(玩家等级)
	return "光芒石",取随机数(5,12)
end
__Funfa["月亮石"]=function(玩家等级)
	return "月亮石",取随机数(5,12)
end
__Funfa["太阳石"]=function(玩家等级)
	return "太阳石",取随机数(5,12)
end
__Funfa["精魄灵石"]=function(玩家等级)
	return "精魄灵石",取随机数(5,8)
end


__Funfa["钨金"]=function(玩家等级)
	if RpbARGB==1 then
		return "钨金",1,150
	end
	return "钨金",1,取随机数(qz(玩家等级/10),qz((玩家等级+30)/10))*10
end
__Funfa["附魔宝珠"]=function(玩家等级)
	if RpbARGB==1 then
		return  "附魔宝珠",150
	end
	return "附魔宝珠",取随机数(qz(玩家等级/10),qz((玩家等级+30)/10))*10
end
__Funfa["灵饰洗练石"]=function(玩家等级)
	return "灵饰洗练石",1,1
end
__Funfa["珍珠"]=function(玩家等级)
	if RpbARGB==1 then
		return  "珍珠",150
	end
	return "珍珠",取随机数(qz(玩家等级/10),qz((玩家等级+30)/10))*10
end
__Funfa["百炼精铁"]=function(玩家等级)
	local mc="百炼精铁"
	local 书铁等级=取随机数(qz(玩家等级/10),qz((玩家等级+30)/10))*10 --{150,150} 书铁
	书铁等级=math.floor(书铁等级/10)*10
	if RpbARGB==1 then
		书铁等级=150
	end
	return mc,书铁等级,书铁种类
end

__Funfa["指南书"]=function(玩家等级,数字id)
	local mc="制造指南书"
	local 书铁等级=150-- 书铁
	local tx=角色武器类型[玩家数据[数字id].角色.模型][取随机数(1,#角色武器类型[玩家数据[数字id].角色.模型])]
	-- print(tx)
	-- print("=======")
	if 取随机数()<=60 then
		local jggr={19,21,23,24,25}
		if 玩家数据[数字id].角色.性别=="女" then
			jggr={20,21,22,24,25}
		end
		tx=jggr[取随机数(1,#jggr)]
	end
	书铁等级=math.floor(书铁等级/10)*10
	if RpbARGB==1 then
		书铁等级=150
	end
	return mc,书铁等级,tx
end

__Funfa["灵饰指南书"]=function(玩家等级) --等级无需自己设置
	  return "灵饰指南书"
end
__Funfa["元灵晶石"]=function(玩家等级) --等级无需自己设置
	  return "元灵晶石"
end
__Funfa["炼妖石"]=function(玩家等级) --等级无需自己设置
	 return "炼妖石"
end
__Funfa["上古锻造图策"]=function(玩家等级) --等级无需自己设置
	return "上古锻造图策"
end


local 特殊奖励={}
特殊奖励["经验"]=2
特殊奖励["储备"]=3
特殊奖励["仙丹"]=4
特殊奖励["金砖"]=5
特殊奖励["金块"]=5
特殊奖励["新春飞行符"]=99

local 公告奖励={}
公告奖励["奖池抽奖"]=1
公告奖励["大金砖"]=1
公告奖励["仙玉"]=1
公告奖励["不磨符"]=1
公告奖励["愤怒符"]=1
公告奖励["特技书"]=1
公告奖励["特殊清灵仙露"]=1
公告奖励["灵兜兜"]=1
公告奖励["神兜兜礼包"]=1
function 翻一翻:领取奖励(数字id)
	if self.数据[数字id] then
		--print(11111111)
		local 数量=self.数据[数字id].翻倍倍数
		--table.print(self.数据[数字id].奖励数据)
	              for i=1,#self.数据[数字id].奖励数据 do
	              	local name=self.数据[数字id].奖励数据[i]
	              	if not beilv[name] then --银子=
	              		local 链接
	              		if 公告奖励[name] then
					链接 = {提示=format("#S(翻一番)#Y/天降鸿运#G%s#Y受天人庇护，竟然抽到了",玩家数据[数字id].角色.名称),频道="xt",结尾="#Y一时间激动的说不出话来！"}
              			end
	              		if __Funfa[name] then
	              			local 名称,shuliang,参数=__Funfa[name](玩家数据[数字id].角色.等级,数字id)
	              			for n=1,数量 do
	              				玩家数据[数字id].道具:给予超链接道具(数字id,名称,shuliang,参数,链接,"翻一翻")
	              			end
	              		elseif 特殊奖励[name] then
	              			if name=="经验" then
	              				local shue=数量*100000
	              				玩家数据[数字id].角色:添加经验(shue,"翻一翻")
	              			elseif name=="10W储备金" then
	              				local shue=数量*100000
	              				玩家数据[数字id].角色:添加银子(shue,"翻一翻",1)
	              			elseif name=="20W储备金" then
	              				local shue=数量*200000
	              				玩家数据[数字id].角色:添加银子(shue,"翻一翻",1)
	              			elseif name=="仙丹" then
	              				local shue=数量*150000
	              				玩家数据[数字id].角色:添加经验(shue,"翻一翻")
					elseif name=="金砖" or name=="金块" then
						local shue=数量*500000
						玩家数据[数字id].角色:添加银子(shue,"翻一翻",1)
					elseif name=="新春飞行符" then
						for n=1,数量 do
							玩家数据[数字id].道具:给予道具(数字id,"新春飞行符",99,nil,"翻一翻")
						end
	              			end
				else
					for n=1,数量 do
						玩家数据[数字id].道具:给予超链接道具(数字id,name,1,参数,链接,"翻一翻")
		              		end
				end
	              	end
	              end
		self.数据[数字id]={翻倍倍数=1,进行次数=0,开始游戏=false,道具={},奖励数据={}}
		-- 发送数据(玩家数据[数字id].连接id,6604)
		常规提示(数字id,"游戏结束#23")
	end
end


return 翻一翻
