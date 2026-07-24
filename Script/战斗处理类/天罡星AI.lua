local 天罡星AI = class()

function 天罡星AI:初始化()

end

function 天罡星AI:智能战斗(this,编号)
	local 战斗类型 = this.战斗类型
	local 攻击方 = this.参战单位[编号]
	攻击方.指令.恢复气血比例 = nil
	攻击方.指令.封印必中= nil
	攻击方.指令.伤害系数 = nil
	攻击方.指令.回合 = nil
	攻击方.指令.附加状态=nil
	攻击方.指令.固定伤害数额= nil
	local 名称 = 分割文本(攻击方.名称,"·")
	if this.战斗类型 == 120025 then
		self:取对应位置队员(this,编号)
	end
	if self[名称[1]] then
		self[名称[1]](self,this,编号)
	else
		if this.参战单位[编号].队伍 == 0 then
		    self:小怪处理(this,编号)
		end

	end
end

function 天罡星AI:取对应位置队员(this,编号)
	local 攻击方 = this.参战单位[编号]
	local 位置 = this.参战单位[编号].位置
	if this.正反位置 == 1 and 位置 <= 5 then --后排加强，如果前排对应位置死亡
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 攻击方.队伍 and  this.参战单位[i].位置 == 位置 + 5 and  not this:取目标状态(编号, i, 类型) and 攻击方.增强 == nil then
				攻击方.增强 =  true
				攻击方.伤害 = 攻击方.伤害 * 1.5
				攻击方.法伤 = 攻击方.法伤 * 1.5
				攻击方.法防 = 攻击方.法防 * 1.5
				攻击方.防御 = 攻击方.防御 * 1.5
				攻击方.速度 = 攻击方.速度 * 1.5
			end
		end
	elseif this.正反位置 == 2 and 位置 >= 6 then --后排加强，如果前排对应位置死亡
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 攻击方.队伍 and  this.参战单位[i].位置 == 位置 - 5 and  not this:取目标状态(编号, i, 类型) and 攻击方.增强 == nil then
				攻击方.增强 =  true
				攻击方.伤害 = 攻击方.伤害 * 1.5
				攻击方.法伤 = 攻击方.法伤 * 1.5
				攻击方.法防 = 攻击方.法防 * 1.5
				攻击方.防御 = 攻击方.防御 * 1.5
				攻击方.速度 = 攻击方.速度 * 1.5
			end
		end
	end
end

function 天罡星AI:法阵处理(this,编号)
	local 攻击方 = this.参战单位[编号]
	local 战斗类型 = this.战斗类型
	local 技能名称 = 攻击方.指令.参数
	if 战斗类型 == 120010 and 攻击方.队伍 ~= 0 then
		if 技能名称 == "龙卷雨击" or 技能名称 == "判官令" or 技能名称 == "阎罗令" or 技能名称 == "尸腐毒" or 技能名称 == "靛沧海" or 技能名称 == "森罗万象" or 技能名称 == "浪涌" or 技能名称 == "惊涛怒" or 技能名称 == "翻江搅海"  or 技能名称 == "落叶萧萧"  or 技能名称 == "推气过宫"  or 技能名称 == "明光宝烛" or 技能名称 == "活血" then
			self:增减法阵能量(this,2,10)
		end
	elseif 战斗类型 == 120012 and 攻击方.队伍 ~= 0 then
		if 技能名称 == "横扫千军" or 技能名称 == "尘土刃" or 技能名称 == "针锋相对" or 技能名称 == "锋芒毕露" or 技能名称 == "日月乾坤" or 技能名称 == "烟雨剑法" or 技能名称 == "地裂火" or 技能名称 == "当头一棒" or 技能名称 == "神针撼海"  or 技能名称 == "三昧真火"  or 技能名称 == "狮搏"  or 技能名称 == "象形" or 技能名称 == "鹰击" or 技能名称 == "含情脉脉" or 技能名称 == "盘丝阵" then
			self:增减法阵能量(this,2,10)
		end
	elseif 战斗类型 == 120013 and  攻击方.队伍 ~= 0 then
		if 技能名称 == "晶清诀" or 技能名称 == "冰清诀" or  skill:取技能类型(技能名称)  == "恢复技能" or skill:取技能类型(技能名称)  == "增益技能"  then
			self:增减法阵能量(this,1,10)
		end
	elseif 战斗类型 == 120014 and  攻击方.队伍 ~= 0 then
		if 攻击方.副战斗类型 == 120013 then
			if 技能名称 == "晶清诀" or 技能名称 == "冰清诀" or  skill:取技能类型(技能名称)  == "恢复技能" or skill:取技能类型(技能名称)  == "增益技能"  then
				self:增减法阵能量(this,1,10)
			end
		elseif 攻击方.副战斗类型 == 120012 then
			if 技能名称 == "横扫千军" or 技能名称 == "尘土刃" or 技能名称 == "针锋相对" or 技能名称 == "锋芒毕露" or 技能名称 == "日月乾坤" or 技能名称 == "烟雨剑法" or 技能名称 == "地裂火" or 技能名称 == "当头一棒" or 技能名称 == "神针撼海"  or 技能名称 == "三昧真火"  or 技能名称 == "狮搏"  or 技能名称 == "象形" or 技能名称 == "鹰击" or 技能名称 == "含情脉脉" or 技能名称 == "盘丝阵" then
				self:增减法阵能量(this,2,10)
			end
		elseif 攻击方.副战斗类型 == 120010 then
			if 技能名称 == "龙卷雨击" or 技能名称 == "判官令" or 技能名称 == "阎罗令" or 技能名称 == "尸腐毒" or 技能名称 == "靛沧海" or 技能名称 == "森罗万象" or 技能名称 == "浪涌" or 技能名称 == "惊涛怒" or 技能名称 == "翻江搅海"  or 技能名称 == "落叶萧萧"  or 技能名称 == "推气过宫"  or 技能名称 == "明光宝烛" or 技能名称 == "活血" then
				self:增减法阵能量(this,2,10)
			end
		end
	elseif 战斗类型 == 120016 and 攻击方.队伍 ~= 0 then
		if 技能名称 == "龙卷雨击" or 技能名称 == "判官令" or 技能名称 == "阎罗令" or 技能名称 == "尸腐毒" or 技能名称 == "靛沧海" or 技能名称 == "森罗万象" or 技能名称 == "浪涌" or 技能名称 == "惊涛怒" or 技能名称 == "翻江搅海"  or 技能名称 == "落叶萧萧"  or 技能名称 == "推气过宫"  or 技能名称 == "明光宝烛" or 技能名称 == "活血" then
			self:增减法阵能量(this,2,10)
		end
	elseif 战斗类型 == 120019 and 攻击方.队伍 ~= 0 then
		if 技能名称 == "横扫千军" or 技能名称 == "尘土刃" or 技能名称 == "针锋相对" or 技能名称 == "锋芒毕露" or 技能名称 == "日月乾坤" or 技能名称 == "烟雨剑法" or 技能名称 == "地裂火" or 技能名称 == "当头一棒" or 技能名称 == "神针撼海"  or 技能名称 == "三昧真火"  or 技能名称 == "狮搏"  or 技能名称 == "象形" or 技能名称 == "鹰击" or 技能名称 == "含情脉脉" or 技能名称 == "盘丝阵" then
			self:增减法阵能量(this,2,10)
		end
	elseif 战斗类型 == 120032 and 攻击方.队伍 ~= 0 then
		if 技能名称 == "龙卷雨击" or 技能名称 == "判官令" or 技能名称 == "阎罗令" or 技能名称 == "尸腐毒" or 技能名称 == "靛沧海" or 技能名称 == "森罗万象" or 技能名称 == "浪涌" or 技能名称 == "惊涛怒" or 技能名称 == "翻江搅海"  or 技能名称 == "落叶萧萧"  or 技能名称 == "推气过宫"  or 技能名称 == "明光宝烛" or 技能名称 == "活血" then
			self:增减法阵能量(this,2,10)
		end
	elseif 战斗类型 == 120034 and 攻击方.队伍 ~= 0 then
		if 技能名称 == "横扫千军" or 技能名称 == "尘土刃" or 技能名称 == "针锋相对" or 技能名称 == "锋芒毕露" or 技能名称 == "日月乾坤" or 技能名称 == "烟雨剑法" or 技能名称 == "地裂火" or 技能名称 == "当头一棒" or 技能名称 == "神针撼海"  or 技能名称 == "三昧真火"  or 技能名称 == "狮搏"  or 技能名称 == "象形" or 技能名称 == "鹰击" or 技能名称 == "含情脉脉" or 技能名称 == "盘丝阵" then
			self:增减法阵能量(this,2,10)
		end
	end
end

天罡星AI.心魔 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if num<6 and 攻击方.召唤次数 == nil then
		攻击方.召唤次数 = (攻击方.召唤次数 or 0) + 1
		if 攻击方.召唤次数 == 1 then
			this:执行怪物召唤(编号,18,0,1)
		elseif 攻击方.召唤次数 == 2 then
			this:执行怪物召唤(编号,19,0,10-num)
		elseif 攻击方.召唤次数 == 3 then
			this:执行怪物召唤(编号,20,0,10-num)
		elseif 攻击方.召唤次数 == 4 then
			this:执行怪物召唤(编号,21,0,1)
		elseif 攻击方.召唤次数 == 5 then
			this:执行怪物召唤(编号,21,0,2)
		else
			this:执行怪物召唤(编号,21,0,3)
		end
		攻击方.指令.类型 = "法术"
		攻击方.指令.参数="云暗天昏"
		攻击方.指令.目标数 = 10
		攻击方.指令.伤害系数 = 10
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.高衍 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if 回合 == 30 then
		攻击方.指令.类型="逃跑"
		攻击方.指令.参数=""
		攻击方.指令.目标= 编号
		return
	end
	if 回合 == 1 or this.失去能力 == nil then
		local 能力 = {"物理","法术","召唤兽","物理","法术","召唤兽","全部"}
		this.失去能力 = 能力[取随机数(1,#能力)]
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "下一回合你将失去"..this.失去能力.."能力！"})
		end
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	else
		local 目标  =self:取未被封印人物单位(this,攻击方.队伍,1,编号)
		if this.失去能力 == "召唤兽" then
			攻击方.指令.参数="威慑"
			目标  =this:取单个敌方bb目标(编号)
		end
		if 目标 then
			攻击方.指令.类型="法术"
			攻击方.指令.目标= 目标
			if this.失去能力 == "物理" then
				攻击方.指令.参数="定身符"
			elseif this.失去能力 == "法术" then
				攻击方.指令.参数="追魂符"
			elseif this.失去能力 == "全部" then
				攻击方.指令.参数="日月乾坤"
			elseif this.失去能力 == "召唤兽" then
				攻击方.指令.参数="威慑"
			end
			攻击方.必中=true
			攻击方.指令.封印必中=true
			攻击方.额外目标数 = 4
			攻击方.指令.回合 = 2
		else
			攻击方.指令.类型="防御"
			攻击方.指令.参数=""
			攻击方.指令.目标= 0
		end
		this.失去能力= nil
	end
end

天罡星AI.陈坎 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 15 then
		攻击方.指令.类型="逃跑"
		攻击方.指令.参数=""
		攻击方.指令.目标= 编号
		return
	end
	攻击方.指令.类型="法术"
	攻击方.指令.参数="夺命咒"
	攻击方.指令.伤害系数 = 8
	攻击方.指令.目标数 = 10
	攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
end

天罡星AI.邓玉 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 10 then
		攻击方.指令.类型="逃跑"
		攻击方.指令.参数=""
		攻击方.指令.目标= 编号
		return
	end
	攻击方.指令.类型="法术"
	攻击方.指令.参数="舍生取义"
	攻击方.指令.目标= self:取气血比例最低目标(this,攻击方.队伍,2,编号)
end

天罡星AI.黄真 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 25 then
		攻击方.指令.类型="逃跑"
		攻击方.指令.参数=""
		攻击方.指令.目标= 编号
		return
	end
	if 攻击方.点名 == nil then--"#Y
		攻击方.点名 = this:取单个敌方角色目标(编号)
		攻击方.指令.类型="防御"
		攻击方.指令.目标= this:取单个敌方目标(编号)
		攻击方.指令.参数=""
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = this.参战单位[攻击方.点名].名称.."你准备好了吗？"})
		end
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="天崩地裂"
		攻击方.指令.伤害系数 =1.5
		攻击方.指令.目标= 攻击方.点名
		攻击方.点名 = nil
	end
end

天罡星AI.天捷星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if 攻击方.气血/攻击方.最大气血 > 0.8 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="飘渺式"
		攻击方.指令.目标数=2
		攻击方.指令.伤害系数 = 2 + (1-攻击方.气血/攻击方.最大气血)*2
		攻击方.指令.目标= this:取单个敌方目标(编号)
	elseif 攻击方.召唤次数 == nil then--"#Y
		攻击方.召唤次数=1
		this:执行怪物召唤(编号,16,0,5)
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="飘渺式"
		if 攻击方.气血/攻击方.最大气血 > 0.7 then
			攻击方.指令.目标数 = 4
		elseif 攻击方.气血/攻击方.最大气血 > 0.5 then
			攻击方.指令.目标数 = 6
		else
			攻击方.指令.目标数 = 8
		end
		攻击方.指令.伤害系数 = 2 + (1-攻击方.气血/攻击方.最大气血)*3
		攻击方.指令.目标= this:取单个敌方目标(编号)
	end
end


天罡星AI.天贵星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if num < 6 then--"#Y
		攻击方.召唤次数=1
		this:执行怪物召唤(编号,16,0,10-num)
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天魁星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if 回合 == 1 or this.失去能力 == nil then
		local 能力 = {"物理","法术","召唤兽","物理","法术","召唤兽","全部"}
		this.失去能力 = 能力[取随机数(1,#能力)]
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "下一回合你将失去"..this.失去能力.."能力！"})
		end
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	else
		local 目标  =self:取未被封印人物单位(this,攻击方.队伍,1,编号)
		if this.失去能力 == "召唤兽" then
			攻击方.指令.参数="威慑"
			目标  =this:取单个敌方bb目标(编号)
		end
		if 目标 then
			攻击方.指令.类型="法术"
			攻击方.指令.目标= 目标
			if this.失去能力 == "物理" then
				攻击方.指令.参数="定身符"
			elseif this.失去能力 == "法术" then
				攻击方.指令.参数="追魂符"
			elseif this.失去能力 == "全部" then
				攻击方.指令.参数="日月乾坤"
			elseif this.失去能力 == "召唤兽" then
				攻击方.指令.参数="威慑"
			end
			攻击方.必中=true
			攻击方.指令.封印必中=true
			攻击方.额外目标数 = 4
			攻击方.指令.回合 = 2
		else
			攻击方.指令.类型="防御"
			攻击方.指令.参数=""
			攻击方.指令.目标= 0
		end
		this.失去能力= nil
	end
end


天罡星AI.天威星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if 攻击方.点名 then
		攻击方.指令.类型="法术"
		攻击方.指令.目标= this:取单个敌方目标(编号)
		攻击方.指令.参数="龙卷雨击"
		攻击方.指令.伤害系数 = 1.5 +self:取阵营存活数量(this,攻击方.队伍)/5
		攻击方.指令.目标数 = 10
		攻击方.点名=nil
	else
		if 取随机数() <= 50 then
			攻击方.指令.类型="地涌金莲"
			攻击方.指令.参数="地涌金莲"
			攻击方.指令.目标= self:取气血比例最低目标(this,攻击方.队伍,2,编号)
		else
			攻击方.指令.类型="法术"
			攻击方.指令.参数="夺魄令"
			攻击方.指令.目标= this:取单个敌方目标(编号)
		end
		if 取随机数() <= 20 then
			攻击方.点名=1
			for n = 1, #this.参战玩家 do
				发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "天威之下，寸草不生，你们准备好了吗？"})
			end
		end
	end
end

天罡星AI.天猛星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	local 目标  =self:取未被封印人物单位(this,攻击方.队伍,1,编号)
	if 目标 and 回合 == 1 then
		攻击方.指令.类型="法术"
		攻击方.指令.目标= 目标
		攻击方.指令.参数="日月乾坤"
		攻击方.指令.封印必中=true
		攻击方.额外目标数 = 4
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天杀星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local 目标  =self:取未被封印人物单位(this,攻击方.队伍,1,编号)
	if 回合==1 then
		攻击方.指令.类型="法术"
		攻击方.指令.目标= this:取单个敌方目标(编号)
		攻击方.指令.参数="长驱直入"
		攻击方.指令.伤害系数 = 1.5
		local 法术组 = {"失心符","追魂符","定身符"}
		攻击方.指令.附加状态 = 法术组[取随机数(1,3)]
		攻击方.点名 = this:取单个敌方角色目标(编号)
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = this.参战单位[攻击方.点名].名称.."你准备好了吗？"})
		end
	else
		if 攻击方.点名 == nil then--"#Y
			攻击方.点名 = this:取单个敌方角色目标(编号)
			攻击方.指令.类型="法术"
			攻击方.指令.目标= this:取单个敌方目标(编号)
			攻击方.指令.参数="长驱直入"
			local 法术组 = {"失心符","追魂符","定身符"}
			攻击方.指令.附加状态 = 法术组[取随机数(1,3)]
			for n = 1, #this.参战玩家 do
				发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = this.参战单位[攻击方.点名].名称.."你准备好了吗？"})
			end
		else
			攻击方.指令.类型="法术"
			攻击方.指令.参数="天崩地裂"
			攻击方.指令.伤害系数 =1.5
			攻击方.指令.目标= 攻击方.点名
			攻击方.指令.连击次数 = 3
			攻击方.点名 = nil
		end
	end
end

天罡星AI.天牢星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local 目标  =self:取未被封印人物单位(this,攻击方.队伍,1,编号)
	if 目标 then
		攻击方.指令.类型="法术"
		攻击方.指令.目标= 目标
		攻击方.指令.参数="日月乾坤"
		攻击方.指令.回合=2
		攻击方.指令.封印必中=true
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天哭星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	攻击方.指令.类型="法术"
	攻击方.指令.参数="威慑"
	攻击方.必中=true
	攻击方.额外目标数 = 4
	攻击方.指令.目标= this:取单个敌方bb目标(编号)
end



天罡星AI.天退星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 11 then
		攻击方.指令.类型="逃跑"
		攻击方.指令.参数=""
		攻击方.指令.目标= 编号
		self:增减法阵能量(this,1,100)
	elseif 回合 <= 7 then
	    	攻击方.指令.类型="法术"
		攻击方.指令.参数="龙吟"
	elseif 回合 == 6 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="笑里藏刀"
		攻击方.指令.目标数 = 5
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
	end
end


天罡星AI.天闲星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="瘴气"
		攻击方.指令.目标数 = 10
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
		self:增减法阵能量(this,1,100)
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "瘴气弥漫！"})
		end
	elseif this.法阵能量 > 0 then
    	self:增减法阵能量(this,2,10)
    	攻击方.指令.类型="法术"
		攻击方.指令.参数="含情脉脉"
		攻击方.指令.封印必中=true
		攻击方.额外目标数 = 1
		攻击方.指令.目标= this:取单个敌方目标(编号)
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="天罗地网"
		攻击方.指令.目标数 = 3
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
	end
end

天罡星AI.天损星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		local 法术组 = {"浪涌","裂石"}
		if 攻击方.战意 > 3 then
			法术组 = {"翻江搅海","天崩地裂"}
		end
		攻击方.指令.类型="法术"
		攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
		攻击方.指令.目标=self:取防御最低目标(this,攻击方.队伍,1,编号)
		攻击方.天损星存活 = self:取阵营存活数量(this,攻击方.队伍)
		攻击方.点名 = this:取单个敌方角色目标(编号)
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = this.参战单位[攻击方.点名].名称 .. "如果这回合我失去同伴，下回合我将对你发起挑战！"})
		end
	elseif 攻击方.天损星存活 and 攻击方.天损星存活 >  self:取阵营存活数量(this,2,攻击方.队伍) and 攻击方.点名 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="力劈华山"
		攻击方.指令.伤害系数 = 3
		攻击方.指令.目标= 攻击方.点名
		攻击方.点名 = nil
	else
		local 法术组 = {"浪涌","裂石"}
		if 攻击方.战意 > 3 then
			法术组 = {"翻江搅海","天崩地裂"}
		end
		攻击方.指令.类型="法术"
		攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
		攻击方.指令.目标=self:取防御最低目标(this,攻击方.队伍,1,编号)
		攻击方.天损星存活 = self:取阵营存活数量(this,2,攻击方.队伍)
		攻击方.点名 = this:取单个敌方角色目标(编号)
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = this.参战单位[攻击方.点名].名称 .. "如果这回合我失去同伴，下回合我将对你发起挑战！"})
		end
	end
end

天罡星AI.祈雨使者 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if this.法阵能量 < 100 then
	    self:增减法阵能量(this,1,5)
	end
	攻击方.指令.类型="防御"
	攻击方.指令.参数=""
	攻击方.指令.目标= 0
end

天罡星AI.天慧星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="龙卷雨击"
		攻击方.指令.伤害系数 = 1.5
		攻击方.指令.目标数 = 5
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "倾盆大雨之时，你们将遭受毁灭打击！"})
		end
	elseif this.法阵能量 < 100 then
    	self:增减法阵能量(this,1,10)
    	攻击方.指令.类型="法术"
		攻击方.指令.参数="龙卷雨击"
		攻击方.指令.伤害系数 = 1.5
		攻击方.指令.目标数 = 5
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="龙卷雨击"
		攻击方.指令.伤害系数 = 5
		攻击方.指令.目标数 = 10
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
	end
end

天罡星AI.天立星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local 法术组 = {"龙卷雨击"}
	if math.floor(回合/3) == 回合/3 and 攻击方.位置 == 1 then
		攻击方.指令.目标数 = 10
		攻击方.指令.类型="法术"
		攻击方.指令.参数= "龙卷雨击"
		攻击方.指令.伤害系数 = 2
		攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
	elseif math.floor(回合/6) == 回合/6 and 攻击方.位置 == 2 then
		攻击方.指令.目标数 = 10
		攻击方.指令.类型="法术"
		攻击方.指令.参数= "飞砂走石"
		攻击方.指令.伤害系数 = 2
		攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
	elseif math.floor(回合/9) == 回合/9 and 攻击方.位置 == 3 then
		攻击方.指令.目标数 = 10
		攻击方.指令.类型="法术"
		攻击方.指令.参数= "落叶萧萧"
		攻击方.指令.伤害系数 = 2
		攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end

end

天罡星AI.天剑星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if 攻击方.气血/攻击方.最大气血 > 0.8 then
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	elseif 攻击方.召唤次数 == nil then--"#Y
		攻击方.召唤次数=1
		this:执行怪物召唤(编号,15,0,10-num)
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="长驱直入"
		攻击方.指令.目标= self:取气血最高目标(this,攻击方.队伍,1,编号)
		攻击方.指令.固定伤害数额 = this.参战单位[攻击方.指令.目标].最大气血*0.9
	end
end

天罡星AI.天罪星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if 回合 == 1 then
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	elseif this.累计击杀 and this.累计击杀 >= 25 then
		攻击方.指令.类型 = "逃跑"
		攻击方.指令.目标 = 编号
		攻击方.指令.参数 = ""
	elseif num == 1 then
		攻击方.召唤次数 = (攻击方.召唤次数 or 0) + 1
		this:执行怪物召唤(编号,14,0,10-num)
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
		攻击方.召唤回合 = 回合
	elseif 攻击方.召唤回合 == nil or 攻击方.召唤回合 +2 < 回合 then
		攻击方.指令.类型 = "法术"
		攻击方.必中=true
		攻击方.指令.目标数 = 10
		攻击方.指令.目标 = this:取单个友方目标(编号)
		攻击方.指令.参数 = "勾魂"
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天勇星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if 攻击方.气血/攻击方.最大气血 < 0.8 then
		攻击方.指令.类型 = "法术"
		攻击方.必中=true
		攻击方.指令.目标 = this:取单个友方目标(编号)
		攻击方.指令.参数 = "勾魂"
		攻击方.吸收数量 = (攻击方.吸收数量 or 0) + 1
		攻击方.防御 = 攻击方.防御 * 1.2
		攻击方.法防 = 攻击方.法防 * 1.2
		攻击方.伤害 = 攻击方.伤害 * 1.2
		攻击方.法伤 = 攻击方.法伤 * 1.2
		攻击方.速度 = 攻击方.速度 * 1.2
	elseif 攻击方.吸收数量 ==nil or 攻击方.吸收数量<=2 then
		local 目标  =self:取未被封印人物单位(this,攻击方.队伍,1,编号)
		if 目标 then
			攻击方.指令.类型="法术"
			攻击方.指令.目标= 目标
			攻击方.指令.参数="催眠符"
			攻击方.指令.封印必中=true
			攻击方.额外目标数 = 4
		else
			攻击方.指令.类型="防御"
			攻击方.指令.参数=""
			攻击方.指令.目标= 0
		end
	elseif 攻击方.吸收数量<=4 then
		if 攻击方.点名 == nil then--"#Y
			攻击方.点名 = this:取单个敌方角色目标(编号)
			攻击方.指令.类型="防御"
			攻击方.指令.参数=""
			攻击方.指令.目标= 0
			for n = 1, #this.参战玩家 do
				发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = this.参战单位[攻击方.点名].名称.."你准备好了吗？"})
			end
		else
			攻击方.指令.类型="法术"
			攻击方.指令.参数="天崩地裂"
			攻击方.指令.目标= 攻击方.点名
			攻击方.指令.伤害系数 = 3
			攻击方.点名 = nil
		end
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="雷霆汹涌"
		攻击方.指令.目标= 攻击方.点名
		攻击方.指令.伤害系数 = 2
		攻击方.指令.目标数 = 10
		攻击方.点名 = nil
	end
end

天罡星AI.天寿星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local 法术组 = {"浪涌","裂石"}
	if 攻击方.战意 > 3 then
		法术组 = {"翻江搅海","天崩地裂"}
	end
	攻击方.指令.类型="法术"
	攻击方.指令.伤害系数 = 2
	攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
	攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
end

天罡星AI.天福星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local 法术组 = {"摄魄","龙卷雨击"}
	攻击方.指令.目标数 = 10
	攻击方.指令.类型="法术"
	攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
	攻击方.指令.伤害系数 = 2
	攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
end


天罡星AI.天败星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	攻击方.指令.类型="法术"
	攻击方.指令.参数="雷霆汹涌"
	攻击方.指令.伤害系数 = 2
	攻击方.指令.目标= this:取单个敌方目标(编号)
end


天罡星AI.天伤星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if this.首杀小怪 then--"#Y
		self:小怪处理(this,this.首杀小怪)
		攻击方.指令= table.loadstring(table.tostring(this.参战单位[this.首杀小怪].指令))
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end


天罡星AI.天究星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "你们有没有想过，失去特技后你们会怎么样？"})
		end
		攻击方.指令.类型="法术"
		攻击方.指令.参数="失忆符"
		攻击方.指令.封印必中=true
		攻击方.额外目标数 = 4
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天微星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		攻击方.指令.类型="法术"
		攻击方.指令.参数="摄魄"
		攻击方.指令.目标数 = 10
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天佑星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 攻击方.点名 == nil then--"#Y
		攻击方.点名 = this:取单个敌方角色目标(编号)
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "人不能只期待上天的眷顾，面对意外情况,"..this.参战单位[攻击方.点名].名称.."你准备好了吗？"})
		end
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="善恶有报"
		攻击方.指令.伤害系数 = 2
		攻击方.指令.目标= 攻击方.点名
		攻击方.点名 = nil
	end
end

天罡星AI.天满星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "水满则溢，生命值最高的侠士将接受我的挑战！"})
		end
		攻击方.指令.类型="法术"
		攻击方.指令.参数="长驱直入"
		攻击方.指令.目标= self:取气血最高目标(this,攻击方.队伍,1,编号)
		攻击方.指令.固定伤害数额 = this.参战单位[攻击方.指令.目标].最大气血*0.6
	else
	    	攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天空星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if num<6 and this.法阵能量 > 0 then
		this:执行怪物召唤(编号,13,0,10-num)
		攻击方.指令.类型 = "法术"
		攻击方.指令.目标 = self:取速度最高目标(this,攻击方.队伍,1,编号)
		攻击方.指令.参数 = "龙卷雨击"
		攻击方.指令.伤害系数 = 1.5
		self:增减法阵能量(this,2,10)
	else
		攻击方.指令.类型 = "法术"
		攻击方.指令.目标 = self:取速度最高目标(this,攻击方.队伍,1,编号)
		攻击方.指令.参数 = "龙卷雨击"
		攻击方.指令.伤害系数 = 2
	end
end


天罡星AI.天巧星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		local 法术 = {"定身符","失心符","失忆符"}
		local 目标  =self:取未被封印人物单位(this,攻击方.队伍,1,编号)
		if 目标 then
			攻击方.指令.类型="法术"
			攻击方.指令.目标= 目标
			攻击方.指令.参数=法术[取随机数(1,#法术)]
			攻击方.指令.封印必中=true
			this.临时目标封印数量=(this.临时目标封印数量 or 0) + 1
		else
			攻击方.指令.类型="防御"
			攻击方.指令.参数=""
			攻击方.指令.目标= 0
		end
	else
		local 目标封印数量 = this:NPC_AI取敌方被封印数量(编号)
		if this.临时目标封印数量 -1 > 目标封印数量 then
			攻击方.指令.类型="法术"
			攻击方.指令.参数="风雷韵动"
			攻击方.指令.目标= self:取气血比例最低目标(this,攻击方.队伍,1,编号)
			攻击方.指令.目标数 = 3
			攻击方.指令.伤害系数 = 5
		else
			攻击方.指令.类型="防御"
			攻击方.指令.参数=""
			攻击方.指令.目标= 0
			his.临时目标封印数量 = 目标封印数量
		end
	end
end

天罡星AI.天暴星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "哈哈哈！熊熊烈火听我召唤！"})
		end
	end
	if this.法阵能量 > 0 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="魔火焚世"
		攻击方.指令.目标= self:取气血比例最低目标(this,攻击方.队伍,1,编号)
		攻击方.指令.目标数 = 10
		攻击方.指令.伤害系数 = 2
	else
	    	攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天富星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	local num=this:取阵营数量(0)
	if num<2 then
		攻击方.召唤次数 = (攻击方.召唤次数 or 0) + 1
		if 攻击方.召唤次数 == 5 then
			this:执行怪物召唤(编号,12,0,3-num)
		else
			this:执行怪物召唤(编号,12,0,10-num)
		end
		if 攻击方.召唤次数 >= 5 then
			攻击方.指令.类型 = "逃跑"
			攻击方.指令.目标 = 编号
			攻击方.指令.参数 = ""
		else
			攻击方.指令.类型 = "法术"
			攻击方.指令.目标 = 编号
			攻击方.指令.参数 = "分身术"
		end
	else
		攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天孤星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "每减少一个伙伴，便少一个人分担孤独的侵袭！"})
		end
	end
	if 取随机数() <= 25 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="天神怒斩"
		攻击方.指令.目标= self:取气血比例最低目标(this,攻击方.队伍,1,编号)
		攻击方.指令.目标数 = 10
		攻击方.指令.伤害系数 = self:取阵营数量(this,攻击方.队伍) / self:取阵营存活数量(this,1,攻击方.队伍)
	else
	    	攻击方.指令.类型="防御"
		攻击方.指令.参数=""
		攻击方.指令.目标= 0
	end
end

天罡星AI.天雄星= function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	if 攻击方.副战斗类型 == 120013 then
		self.天英星(self,this,编号)
	elseif 攻击方.副战斗类型 == 120012 then
		self.天机星(self,this,编号)
	elseif 攻击方.副战斗类型 == 120010 then
		self.天暗星(self,this,编号)
	end
end

天罡星AI.天英星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "你的每次增益技能都会增加长生之力，而长生之力会对所有人进行治疗！"})
		end
	end
	if this.法阵能量 >= 10 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="推气过宫"
		攻击方.指令.目标= self:取气血比例最低目标(this,攻击方.队伍,2,编号)
		攻击方.指令.目标数 = 10
		攻击方.指令.恢复气血比例 = 0.1
		self:增减法阵能量(this,2,10)
	else
	    	攻击方.指令.类型="法术"
		攻击方.指令.参数="枯木逢春"
		攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,2,编号)
		self:增减法阵能量(this,1,10)
	end
end

天罡星AI.天机星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if this.法阵能量 >= 0 then
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "若不能在这场电闪雷鸣之前(雷电之力:"..(攻击方.雷电之力 or 0)..")止住这场暴雨，等待你们的将只有失败！"})
		end
	end
	攻击方.指令.类型="法术"
	攻击方.指令.参数="雷霆万钧"
	攻击方.指令.目标= this:取单个敌方目标(编号)
	攻击方.指令.目标数 = 3
	攻击方.雷电之力 = 攻击方.雷电之力 or 0
	if 攻击方.雷电之力 >= 100 and this.法阵能量 >= 0 then
		攻击方.指令.目标数 = 10
		攻击方.指令.伤害系数 = 2
	elseif 攻击方.雷电之力 == 50 and this.法阵能量 >= 0 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 0 and this.参战单位[i].位置 > 5 then
				this.参战单位[i].共生 = true
			end
		end
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "雷电之力，让我们生命相连，这对你们来说也许是个机会！"})
		end
	end
	攻击方.雷电之力 = (攻击方.雷电之力 or 0) + 25
end

天罡星AI.天平星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if 回合 == 1 then--"#Y
		for n = 1, #this.参战玩家 do
			发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "你们所有的集火将徒劳无功！"})
		end
	end
	攻击方.指令.类型="法术"
	攻击方.指令.参数="舍生取义"
	攻击方.指令.目标= self:取气血比例最低目标(this,攻击方.队伍,2,编号)
end

天罡星AI.天暗星 = function (self,this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合 = this.回合数
	if this.法阵能量 >= 50 then
		if 回合 == 1 then
			for n = 1, #this.参战玩家 do
				发送数据(this.参战玩家[n].连接id, 5512, {id = 编号, 文本 = "飞砂之阵中，没有人能够承受住我的究极法术！"})
			end
		end
		攻击方.指令.类型="法术"
		攻击方.指令.参数="飞砂走石"
		攻击方.指令.目标= this:取单个敌方目标(编号)
		攻击方.指令.目标数 = 10  --秒10 伤害增加+100%
		攻击方.指令.伤害系数 = 2
	elseif this.法阵能量 >= 0 then
		攻击方.指令.类型="法术"
		攻击方.指令.参数="飞砂走石"
		攻击方.指令.目标= this:取单个敌方目标(编号)
		攻击方.指令.目标数 = 7    --秒7   伤害增加+100%
		攻击方.指令.伤害系数 = 1.5
	else
		攻击方.指令.类型="法术"
		攻击方.指令.参数="飞砂走石"
		攻击方.指令.目标= this:取单个敌方目标(编号)
		攻击方.指令.目标数 = 4   --秒7   伤害增加+0%
	end
end

function 天罡星AI:增减法阵能量(this,类型,数额)
	if 类型==1 then
		this.法阵能量 = this.法阵能量 + 数额
		if this.法阵能量 > 100 then this.法阵能量 = 100 end
	else
	   	this.法阵能量 = this.法阵能量 - 数额
	   	if this.法阵能量 < 0 then this.法阵能量 = 0 end
	end
	self:更新法阵能量(this)
end

function 天罡星AI:更新法阵能量(this)
	for n = 1, #this.参战玩家 do
		发送数据(this.参战玩家[n].连接id, 5527,{法阵能量=this.法阵能量})
	end
end

function 天罡星AI:小怪处理(this,编号)
	local 攻击方 = this.参战单位[编号]
	local 回合=this.回合数
	if this.战斗类型 == 120035 and 回合 >= 11 then
		攻击方.指令.类型 = "逃跑"
		攻击方.指令.目标 = 编号
		攻击方.指令.参数 = ""
		return
	end
	if  攻击方.门派 == "狮驼岭" or 攻击方.门派 == "阴曹地府" or 攻击方.门派 == "大唐官府" or 攻击方.门派 == "凌波城" then
		local 集火目标 = self:取气血比例最低20(this,攻击方.队伍,1,编号)
		if  攻击方.门派 == "狮驼岭" then
			if not 攻击方.法术状态.变身 then--"#Y
				攻击方.指令.类型="法术"
				攻击方.指令.参数="变身"
				攻击方.指令.目标= 编号
			else
				local 法术组 = {"鹰击"}
				if 集火目标 then 法术组 = {"连环击"} end
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
			end
			return
		elseif 攻击方.门派 == "阴曹地府" then
			if 回合 == 1 then
				攻击方.指令.类型="法术"
				攻击方.指令.参数="破血狂攻"
				攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
			else
				local 法术组 = {"百爪狂杀","破血狂攻"}
				if 回合/2 == math.floor(回合/2) then
					法术组 = {"判官令","尸腐毒"}
				end
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
			end
			return
		elseif 攻击方.门派 == "大唐官府" then
			if 回合 == 1 then
				攻击方.指令.类型="法术"
				攻击方.指令.参数="破血狂攻"
				攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
			else
				local 法术组 = {"横扫千军"}
				if 集火目标 then 法术组 = {"横扫千军"} end
				if 攻击方.气血 < 攻击方.最大气血*0.5 then
					法术组 = {"破血狂攻","弱点击破","后发制人"}
				end
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
			end
			return
		elseif 攻击方.门派 == "凌波城" then
			if 回合 == 1 then
				攻击方.指令.类型="法术"
				攻击方.指令.参数="破血狂攻"
				攻击方.指令.目标= self:取防御最低目标(this,攻击方.队伍,1,编号)
			else
				local 法术组 = {"浪涌"}
				if 攻击方.战意 > 3 then
					法术组 = {"翻江搅海"}
				end
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标 or self:取防御最低目标(this,攻击方.队伍,1,编号)
			end
			return
		end
	end
	if  攻击方.门派 == "魔王寨" or 攻击方.门派 == "天宫" or 攻击方.门派 == "龙宫" or 攻击方.门派 == "神木林" then
		local 集火目标 = self:取气血比例最低20(this,攻击方.队伍,1,编号)
		if  攻击方.门派 == "魔王寨" then
			if 回合 == 1 then
				攻击方.指令.类型="法术"
				攻击方.指令.参数="牛劲"
				攻击方.指令.目标= 编号
			else
				local 法术组 = {"三昧真火","飞砂走石","飞砂走石","飞砂走石"}
				if 集火目标 then 法术组 = {"三昧真火"} end
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标 or self:取法伤最低目标(this,攻击方.队伍,1,编号)
			end
			return
		elseif 攻击方.门派 == "天宫" then
			if 回合 <= 10 then
				local 法术组 = {"雷霆万钧","雷霆汹涌"}
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标 or self:取法伤最低目标(this,攻击方.队伍,1,编号)
			else
				local 法术组 = {"雷霆万钧","雷霆万钧","雷霆汹涌","错乱"}
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标 or self:取法伤最低目标(this,攻击方.队伍,1,编号)
			end
			return
		elseif 攻击方.门派 == "龙宫" then
			local 法术组 = {"龙卷雨击","龙卷雨击","龙腾","二龙戏珠"}
			if 集火目标 then 法术组 = {"龙腾","龙腾","二龙戏珠"} end
			攻击方.指令.类型="法术"
			攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
			攻击方.指令.目标= 集火目标 or self:取法伤最低目标(this,攻击方.队伍,1,编号)
			return
		elseif 攻击方.门派 == "神木林" then
			local 法术组 = {"落叶萧萧","落叶萧萧","尘土刃","荆棘舞"}
			if 集火目标 then 法术组 = {"落叶萧萧","尘土刃","荆棘舞"} end
			攻击方.指令.类型="法术"
			攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
			攻击方.指令.目标= 集火目标 or self:取法伤最低目标(this,攻击方.队伍,1,编号)
			return
		end
	end
	if  攻击方.门派 == "化生寺" or 攻击方.门派 == "普陀山" or 攻击方.门派 == "无底洞" then
		if 取随机数() <= 50 and self:取法系门派数量(this,攻击方.队伍,1,编号) >= 2 and not 攻击方.法术状态.罗汉金钟 then
			攻击方.指令.类型="法术"
			攻击方.指令.参数="罗汉金钟"
			攻击方.指令.目标= self:取伤害最高目标(this,攻击方.队伍,2,编号)
			return
		end
		if 取随机数() <= 50 and self:取物理门派数量(this,攻击方.队伍,1,编号) >= 2 and not 攻击方.法术状态.圣灵之甲 then
			攻击方.指令.类型="法术"
			攻击方.指令.参数="圣灵之甲"
			攻击方.指令.目标= self:取伤害最高目标(this,攻击方.队伍,2,编号)
			return
		end
		local 集火目标 = self:取气血比例最低20(this,攻击方.队伍,2,编号)
		if  攻击方.门派 == "化生寺" then
			if 回合 == 1 then
				攻击方.指令.类型="法术"
				攻击方.指令.参数="金刚护法"
				攻击方.指令.目标= self:取伤害最高目标(this,攻击方.队伍,2,编号)
			else
				local 法术组 = {"推气过宫","活血","推气过宫","活血","唧唧歪歪","金刚护体","金刚护法"}
				local 法术 = 法术组[取随机数(1,#法术组)]
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术
				if 法术 == "唧唧歪歪" then
					攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
				elseif 法术 == "金刚护法" then
					攻击方.指令.目标=  self:取伤害最高目标(this,攻击方.队伍,2,编号)
				else
					攻击方.指令.目标= 集火目标 or self:取气血比例最低目标(this,攻击方.队伍,2,编号)
					攻击方.指令.恢复气血比例 = 0.1
					if 法术 == "活血" then 攻击方.指令.恢复气血比例 = 0.2 end
				end
			end
			if this.战斗类型 == 120035 then--"#Y
				攻击方.指令.参数="舍生取义"
				攻击方.指令.目标= self:取气血最低目标(this,攻击方.队伍,2,编号)
			end
			return
		elseif 攻击方.门派 == "普陀山" then
			if 回合 == 1 then
				local 法术组 = {"灵动九天"}
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标=  self:取法伤最高目标(this,攻击方.队伍,2,编号)
			else
				local 法术组 = {"普渡众生","普渡众生","普渡众生","日光华","灵动九天"}
				攻击方.指令.类型="法术"
				local 法术 = 法术组[取随机数(1,#法术组)]
				攻击方.指令.参数= 法术
				if 法术 == "日光华" then
					攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
				elseif 法术 == "灵动九天" then
					攻击方.指令.目标=  self:取法伤最高目标(this,攻击方.队伍,2,编号)
				else
					攻击方.指令.目标= 集火目标 or self:取气血比例最低目标(this,攻击方.队伍,2,编号)
					攻击方.指令.恢复气血比例 = 0.05
				end
			end
			return
		elseif 攻击方.门派 == "无底洞" then
			if 回合 == 1 then
				local 法术组 = {"明光宝烛"}
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标=  self:取防御最低目标(this,攻击方.队伍,2,编号)
			else
				local 法术组 = {"地涌金莲","地涌金莲","地涌金莲","夺命咒","明光宝烛"}
				if 回合 >= 10 then
					法术组[#法术组+1] = "夺魄令"
				end
				local 法术 = 法术组[取随机数(1,#法术组)]
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术
				if 法术== "夺命咒" or 法术 == "夺魄令" then
					攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
				else
					攻击方.指令.目标= 集火目标 or self:取气血比例最低目标(this,攻击方.队伍,2,编号)
				end
				攻击方.指令.恢复气血比例 = 0.05
			end
			return
		end
	end
	if  攻击方.门派 == "方寸山" or 攻击方.门派 == "五庄观" or 攻击方.门派 == "盘丝洞" then
		if 初始技能计算:取是否被封印(this,编号) and not 攻击方.法术状态.催眠符 and not 攻击方.法术状态.镇妖 and not 攻击方.法术状态.日月乾坤 then    --自己被封印会水清或起纸人
			攻击方.指令.类型="法术"
			if 取随机数() <= 50 then
				攻击方.指令.参数= "水清诀"
			else
			    	攻击方.指令.参数= "苍白纸人"
			end
			攻击方.指令.目标=  编号
			return
		end
		local 集火目标 = self:取愤怒大于90(this,攻击方.队伍,1,编号)  --对方愤怒达到90会被笑里 11
		if 集火目标 then
		    	攻击方.指令.类型="法术"
			攻击方.指令.参数="笑里藏刀"
			攻击方.指令.目标= 集火目标
			return
		end
		local 目标封印数量 = this:NPC_AI取敌方被封印数量(编号)
		local 集火目标 = self:取未被封印人物单位(this,攻击方.队伍,1,编号)
		if not 集火目标 or 目标封印数量 >= 4 then
			集火目标 = self:取未被封印单位(this,攻击方.队伍,1,编号)
			if 集火目标 and 取随机数() <= 30 then
				local 法术组 = {"似玉生香","如花解语"}
				if  攻击方.门派 == "方寸山" then
					法术组 = {"催眠符","失心符","追魂符","定身符"}
				elseif 攻击方.门派 == "五庄观" then
					法术组 = {"日月乾坤"}
				elseif 攻击方.门派 == "盘丝洞" then
					法术组 = {"含情脉脉","魔音摄魂"}
				end
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= 集火目标
			else
				local 法术组 = {"雨落寒沙"}
				if  攻击方.门派 == "方寸山" then
					法术组 = {"五雷咒"}
				elseif 攻击方.门派 == "五庄观" then
					法术组 = {"烟雨剑法"}
				elseif 攻击方.门派 == "盘丝洞" then
					法术组 = {"天罗地网","勾魂","摄魄"}
				end
				攻击方.指令.类型="法术"
				攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
				攻击方.指令.目标= self:取速度最高目标(this,攻击方.队伍,1,编号)
			end
			if this.战斗类型 == 120035 then--"#Y
				攻击方.指令.参数="催眠符"
				攻击方.指令.封印必中=true
			end
			return
		else
			local 法术组 = {"似玉生香","如花解语"}
			if  攻击方.门派 == "方寸山" then
				法术组 = {"催眠符","失心符","追魂符","定身符"}
			elseif 攻击方.门派 == "五庄观" then
				法术组 = {"日月乾坤"}
			elseif 攻击方.门派 == "盘丝洞" then
				法术组 = {"含情脉脉","魔音摄魂"}
			end
			攻击方.指令.类型="法术"
			攻击方.指令.参数= 法术组[取随机数(1,#法术组)]
			攻击方.指令.目标= 集火目标
			if this.战斗类型 == 120035 then--"#Y
				攻击方.指令.参数="催眠符"
				攻击方.指令.封印必中=true
			end
			return
		end
	end
end

function 天罡星AI:取阵营数量(this,类型,队伍)
	local 数量 = 0
	if 类型==1 then
		for n = 1, #this.参战单位 do
			if this.参战单位[n].队伍 ~= 队伍 and this.参战单位[n].捕捉 == nil and this.参战单位[n].逃跑 == nil then
				数量 = 数量 + 1
			end
		end
	elseif 类型==2 then--"#Y
		for n = 1, #this.参战单位 do
			if this.参战单位[n].队伍 == 队伍 and this.参战单位[n].捕捉 == nil and this.参战单位[n].逃跑 == nil then
				数量 = 数量 + 1
			end
		end
	end
	return 数量
end

function 天罡星AI:取阵营存活数量(this,类型,队伍)
	local 数量 = 0
	if 类型==1 then
		for n = 1, #this.参战单位 do
			if this.参战单位[n].队伍 ~= 队伍 and this.参战单位[n].气血 >= 1 and this.参战单位[n].捕捉 == nil and this.参战单位[n].逃跑 == nil then
				数量 = 数量 + 1
			end
		end
	elseif 类型==2 then--"#Y
		for n = 1, #this.参战单位 do
			if this.参战单位[n].队伍 == 队伍 and this.参战单位[n].气血 >= 1 and this.参战单位[n].捕捉 == nil and this.参战单位[n].逃跑 == nil then
				数量 = 数量 + 1
			end
		end
	end
	return 数量
end

function 天罡星AI:取未被封印单位(this,队伍,类型,编号)  --气血比例低于20%
	local 目标
	if 类型 == 1 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and not 初始技能计算:取是否被封印(this,i) and (目标 == nil or  this.参战单位[i].速度 > 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		if 目标 and 目标[2] >= 90 then
			return 目标[1]
		else
			return
		end
	elseif 类型 == 2 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and not 初始技能计算:取是否被封印(this,i) and (目标 == nil or  this.参战单位[i].速度 > 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		if 目标 and 目标[2] >= 90 then
			return 目标[1]
		else
			return
		end

	end
end

function 天罡星AI:取未被封印人物单位(this,队伍,类型,编号)  --气血比例低于20%
	local 目标
	if 类型 == 1 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this.参战单位[i].类型=="角色" and this:取目标状态(编号, i, 类型) and not 初始技能计算:取是否被封印(this,i) and (目标 == nil or  this.参战单位[i].速度 > 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		if 目标 then
			return 目标[1]
		else
			return
		end
	elseif 类型 == 2 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this.参战单位[i].类型=="角色" and this:取目标状态(编号, i, 类型) and not 初始技能计算:取是否被封印(this,i) and (目标 == nil or  this.参战单位[i].速度 > 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		if 目标 then
			return 目标[1]
		else
			return
		end

	end
end

function 天罡星AI:取愤怒大于90(this,队伍,类型,编号)  --气血比例低于20%
	local 目标
	if 类型 == 1 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and this.参战单位[i].愤怒 and (目标 == nil or  this.参战单位[i].愤怒 > 目标[2])then
				目标 = {i,this.参战单位[i].愤怒}
			end
		end
		if 目标 and 目标[2] >= 90 then
			return 目标[1]
		else
			return
		end
	elseif 类型 == 2 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and this.参战单位[i].愤怒 and (目标 == nil or  this.参战单位[i].愤怒 > 目标[2])then
				目标 = {i,this.参战单位[i].愤怒}
			end
		end
		if 目标 and 目标[2] >= 90 then
			return 目标[1]
		else
			return
		end

	end
end

function 天罡星AI:取物理门派数量(this,队伍,类型,编号)  --气血比例低于20%
	local 目标 = 0
	if 类型 == 1 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and (this.参战单位[i].门派 == "大唐官府" or this.参战单位[i].门派 == "狮驼岭" or this.参战单位[i].门派 == "凌波城") then
				目标 = 目标 + 1
			end
		end
		return 目标
	elseif 类型 == 2 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and (this.参战单位[i].门派 == "大唐官府" or this.参战单位[i].门派 == "狮驼岭" or this.参战单位[i].门派 == "凌波城") then
				目标 = 目标 + 1
			end
		end
		return 目标
	end
end

function 天罡星AI:取法系门派数量(this,队伍,类型,编号)  --气血比例低于20%
	local 目标 = 0
	if 类型 == 1 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and (this.参战单位[i].门派 == "龙宫" or this.参战单位[i].门派 == "魔王寨" or this.参战单位[i].门派 == "神木林") then
				目标 = 目标 + 1
			end
		end
		return 目标
	elseif 类型 == 2 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and (this.参战单位[i].门派 == "龙宫" or this.参战单位[i].门派 == "魔王寨" or this.参战单位[i].门派 == "神木林") then
				目标 = 目标 + 1
			end
		end
		return 目标
	end
end

function 天罡星AI:取气血比例最低20(this,队伍,类型,编号)  --气血比例低于20%
	local 目标
	if 类型 == 1 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血/this.参战单位[i].最大气血 < 目标[2])then
				目标 = {i,this.参战单位[i].气血/this.参战单位[i].最大气血}
			end
		end
		if 目标 and 目标[2] < 0.2 then
			return 目标[1]
		else
			return
		end
	elseif 类型 == 2 then
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血/this.参战单位[i].最大气血 < 目标[2])then
				目标 = {i,this.参战单位[i].气血/this.参战单位[i].最大气血}
			end
		end
		if 目标 and 目标[2] < 0.2 then
			return 目标[1]
		else
			return
		end

	end
end

function 天罡星AI:取气血比例最高目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血/this.参战单位[i].最大气血 > 目标[2])then
				目标 = {i,this.参战单位[i].气血/this.参战单位[i].最大气血}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血/this.参战单位[i].最大气血 > 目标[2])then
				目标 = {i,this.参战单位[i].气血/this.参战单位[i].最大气血}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取气血比例最低目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血/this.参战单位[i].最大气血 < 目标[2])then
				目标 = {i,this.参战单位[i].气血/this.参战单位[i].最大气血}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and 编号 ~= i and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血/this.参战单位[i].最大气血 < 目标[2])then
				目标 = {i,this.参战单位[i].气血/this.参战单位[i].最大气血}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取气血最高目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血 > 目标[2])then
				目标 = {i,this.参战单位[i].气血}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血 > 目标[2])then
				目标 = {i,this.参战单位[i].气血}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取气血最低目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血 < 目标[2])then
				目标 = {i,this.参战单位[i].气血}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].气血 < 目标[2])then
				目标 = {i,this.参战单位[i].气血}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取法防最高目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法防 > 目标[2])then
				目标 = {i,this.参战单位[i].法防}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法防 > 目标[2])then
				目标 = {i,this.参战单位[i].法防}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取法防最低目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法防 < 目标[2])then
				目标 = {i,this.参战单位[i].法防}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法防 < 目标[2])then
				目标 = {i,this.参战单位[i].法防}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取法伤最高目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法伤 > 目标[2])then
				目标 = {i,this.参战单位[i].法伤}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法伤 > 目标[2])then
				目标 = {i,this.参战单位[i].法伤}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取法伤最低目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法伤 < 目标[2])then
				目标 = {i,this.参战单位[i].法伤}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].法伤 < 目标[2])then
				目标 = {i,this.参战单位[i].法伤}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取伤害最高目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].伤害 > 目标[2])then
				目标 = {i,this.参战单位[i].伤害}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].伤害 > 目标[2])then
				目标 = {i,this.参战单位[i].伤害}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取伤害最低目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].伤害 < 目标[2])then
				目标 = {i,this.参战单位[i].伤害}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].伤害 < 目标[2])then
				目标 = {i,this.参战单位[i].伤害}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取速度最高目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].速度 > 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].速度 > 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取速度最低目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].速度 < 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].速度 < 目标[2])then
				目标 = {i,this.参战单位[i].速度}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:取防御最高目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].防御 > 目标[2])then
				目标 = {i,this.参战单位[i].防御}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].防御 > 目标[2])then
				目标 = {i,this.参战单位[i].防御}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	end
end

function 天罡星AI:取防御最低目标(this,队伍,类型,编号)
	local 目标
	if 类型 == 1 then --敌方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 ~= 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].防御 < 目标[2])then
				目标 = {i,this.参战单位[i].防御}
			end
		end
		return (目标 or  {})[1] or this:取单个敌方目标(编号)
	elseif 类型 == 2 then --我方
		for i=1,#this.参战单位 do
			if this.参战单位[i].队伍 == 队伍 and this:取目标状态(编号, i, 类型) and (目标 == nil or  this.参战单位[i].防御 < 目标[2])then
				目标 = {i,this.参战单位[i].防御}
			end
		end
		return (目标 or  {})[1] or this:取单个友方目标(编号)
	end
end

function 天罡星AI:更新(dt)
end

function 天罡星AI:显示()
end

return 天罡星AI