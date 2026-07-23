
local 战斗处理类 = class()
local jhf = string.format
local random = math.random
local qz = math.floor
local sj = 取随机数
local 五行_ = {"金","木","水","火","土"}

function 战斗处理类:初始化(时间)
	self.创建时间 = 时间
	self.上次命令时间 = 0
	self.全场属性 ={}
	self.已判断目标名称 = {} ------------佬伍修改（增加种族秘境时空之钥）

end

function 战斗处理类:设置断线玩家(id)
	for n = 1, #self.参战玩家 do
		if self.参战玩家[n].id == id then
			self.参战玩家[n].断线 = true
			break
		end
	end
	for n = 1, #self.观战玩家 do
		if self.观战玩家[n].id == id then
			table.remove(self.观战玩家, n)
			break
		end
	end
end

function 战斗处理类:设置重连玩家(id)
	local 编号 = 0
	for n = 1, #self.参战玩家 do
		if self.参战玩家[n].id == id then
			self.参战玩家[n].断线 = false
			self.参战玩家[n].断线等待 = true
			self.参战玩家[n].连接id = 玩家数据[id].连接id
			编号 = n
		end
	end
	if 编号 == 0 then
		玩家数据[id].zhandou = 0
		return
	end
	发送数据(self.参战玩家[编号].连接id, 5501, {id = self.参战玩家[编号].队伍, 音乐 = self.战斗音乐, 总数 = #self.参战单位}) --单挑模式
	local x待发送数据 = {}
	for i = 1, #self.参战单位 do
		x待发送数据[i] = self:取加载信息(i)
		x待发送数据[i].回合数 = self.回合数
	end
	发送数据(self.参战玩家[编号].连接id, 5515, x待发送数据)--5502
	x待发送数据 = {}
	self.参战玩家[编号].重连加载 = true
	if self.回合进程 == "执行" then
		if #self.参战玩家 == 1 then
			-- self.执行等待=os.time()+10
		end
	end
	local 重新时间 = 0



	if self.回合进程 == "命令回合" then
		if self.参战单位[编号].指令到达 == self.回合数 then
			发送数据(self.参战玩家[编号].连接id, 38, {内容 = format("#G你已经重新加入战斗，请等待其他玩家操作。"), 频道 = "xt"})
		else
			发送数据(self.参战玩家[编号].连接id, 38, {内容 = format("#G你已经重新加入战斗，预计将在#Y%s#G秒后同步战斗操作。", 48 - (os.time() - self.等待起始)), 频道 = "xt"})
		end
	elseif self.回合进程=="执行回合"  or self.回合进程=="计算回合" then
    	发送数据(self.参战玩家[编号].连接id,5504,self.战斗流程)
    	发送数据(self.参战玩家[编号].连接id, 38, {内容 = format("#G你已经重新加入战斗，即将同步战斗操作。"), 频道 = "xt"})
	end
	-- if self.执行等待 == 0 then
	-- 	self.执行等待 = os.time() + 5
	-- 	重新时间 = self.执行等待 - os.time()
	-- 	if 重新时间 < 0 then
	-- 		重新时间 = 0
	-- 	end
	-- 	发送数据(self.参战玩家[编号].连接id, 38, {内容 = format("#G你已经重新加入战斗，预计将在#Y%s#G秒后同步战斗操作。", 重新时间), 频道 = "xt"})
	-- else
	-- 	重新时间 = self.执行等待 - os.time()
	-- 	if 重新时间 < 0 then
	-- 		重新时间 = 0
	-- 	end
	-- 	发送数据(self.参战玩家[编号].连接id, 38, {内容 = format("#G你已经重新加入战斗，预计将在#Y%s#G秒后可以下达战斗指令。当其他玩家进入下达命令回合时，您将提前结束等待。", 重新时间), 频道 = "xt"})
	-- end
end

-- function 战斗处理类:进入战斗(玩家id, 序号, 任务id, 地图,玩家战斗, 挑战战斗,单挑模式)
-- 	self.战斗id = os.time()..玩家数据[玩家id].zhandou
-- 	self.战斗类型 = 序号
-- 	self.任务id = 任务id or 0
-- 	self.玩家胜利 = true
-- 	self.战斗发言数据 = {}
-- 	self.战斗失败 = false
-- 	self.中断计算 = false
-- 	self.参战单位 = {}
-- 	self.参战玩家 = {}
-- 	self.观战玩家 = {}
-- 	self.进入战斗玩家id = 玩家id
-- 	self.飞升序号 = 0
-- 	self.战斗计时 = os.time()
-- 	self.加载等待 = 7
-- 	self.回合进程 = "加载回合"
-- 	self.等待时间 = {初始 = 60, 延迟 = 5}
-- 	self.队伍数量 = {[1] = 0, [2] = 0}
-- 	self.观战方 = 玩家id
-- 	-- self.防卡战斗 = {回合 = 0, 时间 = os.time(), 执行 = false}
-- 	self.阵法使用 = true
-- 	self.结束等待 = 0
-- 	self.战斗地图 = 玩家数据[玩家id].角色.地图数据.编号
-- 	self.加载数量 = 0
-- 	self.等待起始 = 0
-- 	self.计算等待 = 0
-- 	self.执行等待 = 0
-- 	self.累计BUG = 0
-- 	self.回合数 = 0
-- 	self.助战数量 = 0
-- 	self.全场状态 = {}
-- 	self.友方经脉统计 = {}
-- 	self.血债偿统计 = {}
-- 	self.同门增伤 = {}
-- 	if 玩家战斗 then
-- 		self.对战方 = 任务id
-- 	else
-- 		self.对战方 =  0
-- 	end
-- 	self.下场战斗序号 = 0
-- 	self.全场属性 ={}
-- 	self.全场属性[self.进入战斗玩家id] ={抗物=0,抗法=0}
-- 	self.全场属性[self.对战方] ={抗物=0,抗法=0}
-- 	self.参战信息 = {}
-- 	self.PK战斗 = 玩家战斗
-- 	self.挑战战斗 = 挑战战斗
-- 	self.单挑模式 = 单挑模式
-- 	self.战斗音乐 = 取随机数(1, 5)
-- 	if 单挑模式 or 玩家战斗 then
-- 		self.战斗音乐 = 取随机数(5, 11)
-- 	elseif self.战斗类型==111126 then --天罡地煞
-- 		local yiny=取随机数(5, 11)
-- 		if yiny==6 or yiny==10 then
-- 			yiny=8
-- 		end
-- 		self.战斗音乐 = yiny
-- 	end
-- 	self.附加流程 = {}

-- 	self.额外数据 = {} --记录战斗额外信息
-- 	if 序号 == 100135 then --梦魇夜叉
-- 		if 地图[1].类型 == "画魂" then
-- 			self.额外数据 = {类型=地图[1].类型,特殊奖励=false}
-- 		elseif 地图[1].类型=="厉鬼" then
-- 			self.额外数据 = {类型=地图[1].类型,变异模型={}}
-- 		elseif 地图[1].类型=="龙龟" then
-- 			self.额外数据 = {类型=地图[1].类型,召唤次数=0,变异数量=0}
-- 		end
-- 	end
-- 	-- if 序号 >= 110100 and 序号 <= 110108 then
-- 	--  self.武神坛模式 = true
-- 	-- else
-- 	--  self.武神坛模式 = false
-- 	-- end
-- 	if 玩家数据[玩家id].队伍 == 0 then
-- 		self.发起id = 玩家id
-- 	else
-- 		self.发起id = 玩家数据[玩家id].队伍
-- 	end
-- 	self.队伍区分 = {[1] = self.发起id, [2] = 0}
-- 	--加载队伍数量
-- 	self.玩家数据 = {}
-- 	self.敌方数据 = {}
-- 	--发起方
-- 	if 玩家数据[玩家id].队伍 == 0 then
-- 		self.玩家数据[1] = {id = 玩家id, 队伍 = 玩家id}
-- 	else
-- 		local 临时队伍 = 玩家数据[玩家id].队伍
-- 		for n = 1, #队伍数据[临时队伍].成员数据 do
-- 			self.玩家数据[n] = {id = 队伍数据[临时队伍].成员数据[n], 队伍 = 临时队伍}
-- 			local 我的id = 队伍数据[临时队伍].成员数据[n]
-- 			if 玩家数据[我的id].队长 then
-- 				self.玩家数据[n].队长=true
-- 			end
-- 			if 玩家数据[我的id].助战 then
-- 				self.玩家数据[n].助战=true
-- 				self.助战数量=self.助战数量+1
-- 			end
-- 			for i = n, #队伍数据[临时队伍].成员数据 do
-- 				local 你的id = 队伍数据[临时队伍].成员数据[i]
-- 				if 我的id ~= 你的id then
-- 					for a = 1, #玩家数据[我的id].角色.好友数据.好友 do
-- 						if 玩家数据[我的id].角色.好友数据.好友[a].id == 你的id then
-- 							for w = 1, #玩家数据[你的id].角色.好友数据.好友 do
-- 								if 玩家数据[你的id].角色.好友数据.好友[w].id == 我的id then
-- 									if 玩家数据[你的id].角色.好友数据.好友[w].好友度 == nil then
-- 										玩家数据[你的id].角色.好友数据.好友[w].好友度 = 1
-- 									else
-- 										玩家数据[你的id].角色.好友数据.好友[w].好友度 = 玩家数据[你的id].角色.好友数据.好友[w].好友度 + 1
-- 									end
-- 									if 玩家数据[我的id].角色.好友数据.好友[a].好友度 == nil then
-- 										玩家数据[我的id].角色.好友数据.好友[a].好友度 = 1
-- 									else
-- 										玩家数据[我的id].角色.好友数据.好友[a].好友度 = 玩家数据[我的id].角色.好友数据.好友[a].好友度 + 1
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	if 序号 >= 200000 then --PK
-- 		self.挑战id = 任务id--4000130
-- 		self.队伍区分[2] = self.挑战id
-- 		if 玩家数据[self.挑战id].队伍 == 0 then
-- 			self.敌方数据[1] = {id = self.挑战id, 队伍 = self.挑战id}
-- 		else
-- 			临时队伍 = 玩家数据[self.挑战id].队伍
-- 			local x第2队位置开始 = 0
-- 			for n = 1, #队伍数据[临时队伍].成员数据 do
-- 				self.敌方数据[n] = {id = 队伍数据[临时队伍].成员数据[n], 队伍 = self.挑战id}
-- 				local 我的id = 队伍数据[临时队伍].成员数据[n]
-- 				if 玩家数据[我的id].队长 then
-- 					self.敌方数据[n].队长=true
-- 				end
-- 				if 玩家数据[我的id].助战 then
-- 					self.敌方数据[n].助战=true
-- 					self.助战数量=self.助战数量+1
-- 				end
-- 				for i = n, #队伍数据[临时队伍].成员数据 do
-- 					local 你的id = 队伍数据[临时队伍].成员数据[i]
-- 					if 我的id ~= 你的id then
-- 						for a = 1, #玩家数据[我的id].角色.好友数据.好友 do
-- 							if 玩家数据[我的id].角色.好友数据.好友[a].id == 你的id then
-- 								for w = 1, #玩家数据[你的id].角色.好友数据.好友 do
-- 									if 玩家数据[你的id].角色.好友数据.好友[w].id == 我的id then
-- 										if 玩家数据[你的id].角色.好友数据.好友[w].好友度 == nil then
-- 											玩家数据[你的id].角色.好友数据.好友[w].好友度 = 1
-- 										else
-- 											玩家数据[你的id].角色.好友数据.好友[w].好友度 = 玩家数据[你的id].角色.好友数据.好友[w].好友度 + 1
-- 										end
-- 										if 玩家数据[我的id].角色.好友数据.好友[a].好友度 == nil then
-- 											玩家数据[我的id].角色.好友数据.好友[a].好友度 = 1
-- 										else
-- 											玩家数据[我的id].角色.好友数据.好友[a].好友度 = 玩家数据[我的id].角色.好友数据.好友[a].好友度 + 1
-- 										end
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	--设定发起方单位
-- 	self.加载数量 = #self.玩家数据 + #self.敌方数据
-- 	for n = 1, #self.玩家数据 do --我方
-- 		self.参战玩家[#self.参战玩家 + 1] = {队伍 = self.玩家数据[n].队伍,助战=self.玩家数据[n].助战, id = self.玩家数据[n].id, 连接id = 玩家数据[self.玩家数据[n].id].连接id, 断线 = false, 退出 = false}
-- 		-- if 队伍数据[self.玩家数据[n].队伍] and 队伍数据[self.玩家数据[n].队伍].队长控制 then
-- 		--  self.参战玩家[#self.参战玩家].队长控制 = 队伍数据[self.玩家数据[n].队伍].队长控制
-- 		-- end
-- 		if self.玩家数据[n].队长 then
-- 		    队长=#self.参战单位+1
-- 		end
-- 		if self.玩家数据[n].助战 then
-- 			if self.参战单位[队长].助战表==nil then
-- 				self.参战单位[队长].助战表={}
-- 			end
-- 			self.参战单位[队长].助战表[#self.参战单位[队长].助战表+1]=#self.参战单位+1
-- 			if self.单挑模式 then
-- 				self:加载单挑玩家(self.玩家数据[n].id, n,self.参战单位[队长].玩家id,队长)
-- 			else
-- 				self:加载单个玩家(self.玩家数据[n].id, n,self.参战单位[队长].玩家id,队长)
-- 			end
-- 		else
-- 		 	if self.单挑模式 then
-- 				self:加载单挑玩家(self.玩家数据[n].id, n,self.玩家数据[n].助战)
-- 			else
-- 				self:加载单个玩家(self.玩家数据[n].id, n,self.玩家数据[n].助战)
-- 			end
-- 		end
-- 	end
-- 	-- if 序号 < 110000 and 序号 ~= 100066 and 序号 ~= 100067 and 序号 ~= 100068 and 序号 ~= 100069 and 序号 ~= 100070 and 序号 ~= 100071 and 序号 ~= 100072 and 序号 ~= 100073 and 序号 ~= 100074 then
-- 	--  self:加载助战单位(self.进入战斗玩家id, 战斗怪物助战单位(玩家id), #self.玩家数据)
-- 	-- end
-- 	--设置对方单位
-- 	local 队长
-- 	if 序号 < 200000 then
-- 		if 序号 == 100001 then --野外单位
-- 			self:加载野外单位()
-- 		elseif 序号 == 100007 then --大雁塔明雷
-- 			self:加载野外单位1()
-- 		-- elseif self.武神坛模式 then
-- 		--  self:加载武神坛单位(地图)
-- 	             elseif 序号 == 154000 then
-- 		  self:加载系统PK单位(地图)
-- 	             elseif 序号 == 154001 then
-- 		  self:加载系统PK单位(地图)
-- 		else
-- 			self:加载指定单位(地图)
-- 		end
-- 	else --玩家战斗
-- 		for n = 1, #self.敌方数据 do --敌方
-- 			self.参战玩家[#self.参战玩家 + 1] = {队伍 = self.敌方数据[n].队伍,助战=self.敌方数据[n].助战, id = self.敌方数据[n].id, 连接id = 玩家数据[self.敌方数据[n].id].连接id, 断线 = false, 退出 = false}
-- 			-- self:加载单个玩家(self.敌方数据[n].id, n)
-- 			if self.敌方数据[n].队长 then
-- 			    队长=#self.参战单位+1
-- 			end
-- 			if self.敌方数据[n].助战 then
-- 				if self.参战单位[队长].助战表==nil then
-- 					self.参战单位[队长].助战表={}
-- 				end
-- 				self.参战单位[队长].助战表[#self.参战单位[队长].助战表+1]=#self.参战单位+1
-- 				if self.单挑模式 then
-- 					self:加载单挑玩家(self.敌方数据[n].id, n,self.参战单位[队长].玩家id,队长)
-- 				else
-- 					self:加载单个玩家(self.敌方数据[n].id, n,self.参战单位[队长].玩家id,队长)
-- 				end
-- 			else
-- 				if self.单挑模式 then
-- 					self:加载单挑玩家(self.敌方数据[n].id, n)
-- 				else
-- 					self:加载单个玩家(self.敌方数据[n].id, n)
-- 				end
-- 			end
-- 		end
-- 	end
-- 	self:重置单位属性()

-- 	local x待发送数据 = {}
-- 	for n = 1, #self.参战玩家 do
-- 		if not self.参战玩家[n].助战 then
-- 			发送数据(self.参战玩家[n].连接id, 5501, {id = self.参战玩家[n].队伍, 音乐 = self.战斗音乐, 单挑模式 = self.单挑模式, PK战斗 = self.PK战斗, 总数 = #self.参战单位})
-- 			for i = 1, #self.参战单位 do
-- 				x待发送数据[i] = self:取加载信息(i)
-- 				x待发送数据[i].回合数 = self.回合数
-- 			end
-- 			发送数据(self.参战玩家[n].连接id, 5515, x待发送数据)--5502
-- 		end
-- 	end

-- 	x待发送数据 = {}

-- end
------------------以上原始进入战斗
function 战斗处理类:进入战斗(玩家id, 序号, 任务id, 地图,玩家战斗, 挑战战斗,单挑模式)
	if 调试模式 == false then
	if 玩家数据[玩家id].队伍==0 then
	         if 玩家数据[玩家id].角色.伤害>  20000         or
		玩家数据[玩家id].角色.气血上限> 69999  or
		玩家数据[玩家id].角色.法伤> 9999            or
		玩家数据[玩家id].角色.防御> 9999            or
		玩家数据[玩家id].角色.速度> 5000            or
		玩家数据[玩家id].角色.法防> 9999            or
		玩家数据[玩家id].角色.灵力 > 9999   or
		玩家数据[玩家id].角色.法术伤害结果 > 9999   or
		玩家数据[玩家id].角色.法术伤害 > 9999       or
		玩家数据[玩家id].角色.法术防御 > 9999      or
		玩家数据[玩家id].角色.固定伤害 > 3000       or
		玩家数据[玩家id].角色.气血回复效果 > 3000   or
		玩家数据[玩家id].角色.物伤结果 > 9999       or
		玩家数据[玩家id].角色.法伤结果 > 9999      then
		--以上有一项超标  战斗属性全清空
		玩家数据[玩家id].角色.气血上限 = 1
		玩家数据[玩家id].角色.最大气血 = 1
		玩家数据[玩家id].角色.气血 = 1
		玩家数据[玩家id].角色.伤害 = 1
		玩家数据[玩家id].角色.法伤 = 1
		玩家数据[玩家id].角色.防御 = 1
		玩家数据[玩家id].角色.速度 = 1
		玩家数据[玩家id].角色.法防 = 1
		玩家数据[玩家id].角色.灵力 = 1
		玩家数据[玩家id].角色.法术伤害结果 = 1
		玩家数据[玩家id].角色.法术伤害 = 1
		玩家数据[玩家id].角色.法术防御 = 1
		玩家数据[玩家id].角色.固定伤害 = 1
		玩家数据[玩家id].角色.气血回复效果 = 1
		玩家数据[玩家id].角色.物伤结果 = 1
		玩家数据[玩家id].角色.法伤结果 = 1
		玩家数据[玩家id].角色.物伤结果 = 1
		玩家数据[玩家id].角色.法伤结果 = 1
		常规提示(玩家id, "检测到你的属性异常。去天台袁天罡洗个点！")
		end
	elseif 玩家数据[玩家id].队伍 ~=0 then
		local 队伍id=玩家数据[玩家id].队伍
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]

		         if 玩家数据[临时id].角色.伤害>  20000         or
			玩家数据[临时id].角色.气血上限> 69999  or
			玩家数据[临时id].角色.法伤> 9999            or
			玩家数据[临时id].角色.防御> 9999            or
			玩家数据[临时id].角色.速度> 3000            or
			玩家数据[临时id].角色.法防> 9999            or
			玩家数据[临时id].角色.灵力 > 9999   or
			玩家数据[临时id].角色.法术伤害结果 > 9999   or
			玩家数据[临时id].角色.法术伤害 > 9999       or
			玩家数据[临时id].角色.法术防御 > 9999       or
			玩家数据[临时id].角色.固定伤害 > 9999       or
			玩家数据[临时id].角色.气血回复效果 > 9999   or
			玩家数据[临时id].角色.物伤结果 > 9999       or
			-- 玩家数据[临时id].角色.洗点积分 < 100       or
			玩家数据[临时id].角色.法伤结果 > 9999      then
		            --以上有一项超标  战斗属性全清空
			玩家数据[临时id].角色.气血上限 = 1
			玩家数据[临时id].角色.最大气血 = 1
			玩家数据[玩家id].角色.气血 = 1
			玩家数据[临时id].角色.伤害 = 1
			玩家数据[临时id].角色.法伤 = 1
			玩家数据[临时id].角色.防御 = 1
			玩家数据[临时id].角色.速度 = 1
			玩家数据[临时id].角色.法防 = 1
			玩家数据[临时id].角色.灵力 = 1
			玩家数据[临时id].角色.法术伤害结果 = 1
			玩家数据[临时id].角色.法术伤害 = 1
			玩家数据[临时id].角色.法术防御 = 1
			玩家数据[临时id].角色.固定伤害 = 1
			玩家数据[临时id].角色.气血回复效果 = 1
			玩家数据[临时id].角色.物伤结果 = 1
			玩家数据[临时id].角色.法伤结果 = 1
			玩家数据[临时id].角色.物伤结果 = 1
			玩家数据[临时id].角色.法伤结果 = 1
			常规提示(临时id, "检测到你的属性异常。去天台袁天罡洗个点！")
				end
			end
		end
	end

    	self.战斗id = os.time()..玩家数据[玩家id].zhandou
    	self.战斗类型 = 序号
    	self.任务id = 任务id or 0
    	self.玩家胜利 = true
    	self.战斗发言数据 = {}
    	self.战斗失败 = false
    	self.中断计算 = false
    	self.参战单位 = {}
    	self.参战玩家 = {}
    	self.观战玩家 = {}
    	self.进入战斗玩家id = 玩家id
    	self.飞升序号 = 0
    	self.战斗计时 = os.time()  -- 记录战斗开始时间
    	self.快速战斗计时 = os.time()  -- 新增：用于快速战斗检测的计时器
    	self.快速战斗限制 = 3  -- 新增：10秒内结束战斗视为快速战斗(可根据需要调整)
    	self.加载等待 = 7
    	self.回合进程 = "加载回合"
    	self.等待时间 = {初始 = 99, 延迟 = 5}
    	self.队伍数量 = {[1] = 0, [2] = 0}
    	self.观战方 = 玩家id
	-- self.防卡战斗 = {回合 = 0, 时间 = os.time(), 执行 = false}
	self.阵法使用 = true
	self.结束等待 = 0
	self.战斗地图 = 玩家数据[玩家id].角色.地图数据.编号
	self.加载数量 = 0
	self.等待起始 = 0
	self.计算等待 = 0
	self.执行等待 = 0
	self.累计BUG = 0
	self.回合数 = 0
	self.助战数量 = 0
	self.全场状态 = {}
	self.友方经脉统计 = {}
	self.血债偿统计 = {}
	-- self.同门增伤 = {}
	if 玩家战斗 then
		self.对战方 = 任务id
	else
		self.对战方 =  0
	end
	self.下场战斗序号 = 0
	self.全场属性 ={}
	self.全场属性[self.进入战斗玩家id] ={抗物=0,抗法=0}
	self.全场属性[self.对战方] ={抗物=0,抗法=0}
	self.参战信息 = {}
	self.已判断目标名称 = {}  ------------佬伍修改（增加种族秘境时空之钥）

	self.PK战斗 = 玩家战斗
	self.挑战战斗 = 挑战战斗
	self.单挑模式 = 单挑模式
	self.战斗音乐 = 取随机数(1, 4)
	if 单挑模式 or 玩家战斗 then
		self.战斗音乐 = 取随机数(6, 10)
	elseif self.战斗类型==111126 or self.战斗类型==111125.1 then --天罡地煞
		local yiny=取随机数(6, 10)
		if yiny==6 or yiny==10 then
			yiny=8
		end
		self.战斗音乐 = yiny
	elseif self.战斗类型==100136 then
		self.战斗音乐 = 11
	----新增
	elseif self.战斗类型==185568
	     or self.战斗类型==185569
	     or self.战斗类型==185570
	     or self.战斗类型==185571
	     or self.战斗类型==185572
	     or self.战斗类型==185573
	     or self.战斗类型==160071
	     or self.战斗类型==160071.1
	     or self.战斗类型==160071.2
	     or self.战斗类型==160071.3
	     or self.战斗类型==160071.4
	     or self.战斗类型==199901
	     or self.战斗类型==199902
	     then
	         self.战斗音乐 = 8--比武

	elseif self.战斗类型==145568
	     or self.战斗类型==145569
	     or self.战斗类型==145570
	     or self.战斗类型==185555
	     or self.战斗类型==185562
	     or self.战斗类型==185563
	     or self.战斗类型==185564
	     or self.战斗类型==185565
	     or self.战斗类型==185566
	     or self.战斗类型==185567
	     or self.战斗类型==160055
	     or self.战斗类型==160056
	     or self.战斗类型==160057
	     or self.战斗类型==160058
	     or self.战斗类型==160059
	     or self.战斗类型==160060
	     then
	         local yiny=取随机数(6, 10)
		if yiny==8 or yiny==10 then
			yiny=6
		end
		self.战斗音乐 = yiny
	end
	self.附加流程 = {}

	self.额外数据 = {} --记录战斗额外信息
	if 序号 == 100135 then --梦魇夜叉
		if 地图[1].类型 == "画魂" then
			self.额外数据 = {类型=地图[1].类型,特殊奖励=false}
		elseif 地图[1].类型=="厉鬼" then
			self.额外数据 = {类型=地图[1].类型,变异模型={}}
		elseif 地图[1].类型=="龙龟" then
			self.额外数据 = {类型=地图[1].类型,召唤次数=0,变异数量=0}
		end
	end
	-- if 序号 >= 110100 and 序号 <= 110108 then
	--  self.武神坛模式 = true
	-- else
	--  self.武神坛模式 = false
	-- end
	if 玩家数据[玩家id].队伍 == 0 then
		self.发起id = 玩家id
	else
		self.发起id = 玩家数据[玩家id].队伍
	end
	self.队伍区分 = {[1] = self.发起id, [2] = 0}
	--加载队伍数量
	self.玩家数据 = {}
	self.敌方数据 = {}
	--发起方
	if 玩家数据[玩家id].队伍 == 0 then
		self.玩家数据[1] = {id = 玩家id, 队伍 = 玩家id}
	else
		local 临时队伍 = 玩家数据[玩家id].队伍
		for n = 1, #队伍数据[临时队伍].成员数据 do
			self.玩家数据[n] = {id = 队伍数据[临时队伍].成员数据[n], 队伍 = 临时队伍}
			local 我的id = 队伍数据[临时队伍].成员数据[n]
			if 玩家数据[我的id].队长 then
				self.玩家数据[n].队长=true
			end
			if 玩家数据[我的id].助战 then
				self.玩家数据[n].助战=true
				self.助战数量=self.助战数量+1
			end
			for i = n, #队伍数据[临时队伍].成员数据 do
				local 你的id = 队伍数据[临时队伍].成员数据[i]
				if 我的id ~= 你的id then
					for a = 1, #玩家数据[我的id].角色.好友数据.好友 do
						if 玩家数据[我的id].角色.好友数据.好友[a].id == 你的id then
							for w = 1, #玩家数据[你的id].角色.好友数据.好友 do
								if 玩家数据[你的id].角色.好友数据.好友[w].id == 我的id then
									if 玩家数据[你的id].角色.好友数据.好友[w].好友度 == nil then
										玩家数据[你的id].角色.好友数据.好友[w].好友度 = 1
									else
										玩家数据[你的id].角色.好友数据.好友[w].好友度 = 玩家数据[你的id].角色.好友数据.好友[w].好友度 + 1
									end
									if 玩家数据[我的id].角色.好友数据.好友[a].好友度 == nil then
										玩家数据[我的id].角色.好友数据.好友[a].好友度 = 1
									else
										玩家数据[我的id].角色.好友数据.好友[a].好友度 = 玩家数据[我的id].角色.好友数据.好友[a].好友度 + 1
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if 序号 >= 200000 then --PK
		self.挑战id = 任务id--4000130
		self.队伍区分[2] = self.挑战id
		if 玩家数据[self.挑战id].队伍 == 0 then
			self.敌方数据[1] = {id = self.挑战id, 队伍 = self.挑战id}
		else
			临时队伍 = 玩家数据[self.挑战id].队伍
			local x第2队位置开始 = 0
			for n = 1, #队伍数据[临时队伍].成员数据 do
				self.敌方数据[n] = {id = 队伍数据[临时队伍].成员数据[n], 队伍 = self.挑战id}
				local 我的id = 队伍数据[临时队伍].成员数据[n]
				if 玩家数据[我的id].队长 then
					self.敌方数据[n].队长=true
				end
				if 玩家数据[我的id].助战 then
					self.敌方数据[n].助战=true
					self.助战数量=self.助战数量+1
				end
				for i = n, #队伍数据[临时队伍].成员数据 do
					local 你的id = 队伍数据[临时队伍].成员数据[i]
					if 我的id ~= 你的id then
						for a = 1, #玩家数据[我的id].角色.好友数据.好友 do
							if 玩家数据[我的id].角色.好友数据.好友[a].id == 你的id then
								for w = 1, #玩家数据[你的id].角色.好友数据.好友 do
									if 玩家数据[你的id].角色.好友数据.好友[w].id == 我的id then
										if 玩家数据[你的id].角色.好友数据.好友[w].好友度 == nil then
											玩家数据[你的id].角色.好友数据.好友[w].好友度 = 1
										else
											玩家数据[你的id].角色.好友数据.好友[w].好友度 = 玩家数据[你的id].角色.好友数据.好友[w].好友度 + 1
										end
										if 玩家数据[我的id].角色.好友数据.好友[a].好友度 == nil then
											玩家数据[我的id].角色.好友数据.好友[a].好友度 = 1
										else
											玩家数据[我的id].角色.好友数据.好友[a].好友度 = 玩家数据[我的id].角色.好友数据.好友[a].好友度 + 1
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	--设定发起方单位
	self.加载数量 = #self.玩家数据 + #self.敌方数据
	for n = 1, #self.玩家数据 do --我方
		self.参战玩家[#self.参战玩家 + 1] = {队伍 = self.玩家数据[n].队伍,助战=self.玩家数据[n].助战, id = self.玩家数据[n].id, 连接id = 玩家数据[self.玩家数据[n].id].连接id, 断线 = false, 退出 = false}
		-- if 队伍数据[self.玩家数据[n].队伍] and 队伍数据[self.玩家数据[n].队伍].队长控制 then
		--  self.参战玩家[#self.参战玩家].队长控制 = 队伍数据[self.玩家数据[n].队伍].队长控制
		-- end
		if self.玩家数据[n].队长 then
		    队长=#self.参战单位+1
		end
		if self.玩家数据[n].助战 then
			if self.参战单位[队长].助战表==nil then
				self.参战单位[队长].助战表={}
			end
			self.参战单位[队长].助战表[#self.参战单位[队长].助战表+1]=#self.参战单位+1
			if self.单挑模式 then
				self:加载单挑玩家(self.玩家数据[n].id, n,self.参战单位[队长].玩家id,队长)
			else
				self:加载单个玩家(self.玩家数据[n].id, n,self.参战单位[队长].玩家id,队长)
			end
		else
		 	if self.单挑模式 then
				self:加载单挑玩家(self.玩家数据[n].id, n,self.玩家数据[n].助战)
			else
				self:加载单个玩家(self.玩家数据[n].id, n,self.玩家数据[n].助战)
			end
		end
	end
	-- if 序号 < 110000 and 序号 ~= 100066 and 序号 ~= 100067 and 序号 ~= 100068 and 序号 ~= 100069 and 序号 ~= 100070 and 序号 ~= 100071 and 序号 ~= 100072 and 序号 ~= 100073 and 序号 ~= 100074 then
	--  self:加载助战单位(self.进入战斗玩家id, 战斗怪物助战单位(玩家id), #self.玩家数据)
	-- end
	--设置对方单位
	local 队长
	if 序号 < 200000 then
		if 序号 == 100001 then --野外单位
			self:加载野外单位()
		elseif 序号 == 100007 then --大雁塔明雷
			self:加载野外单位1()
		-- elseif self.武神坛模式 then
		--  self:加载武神坛单位(地图)
	             elseif 序号 == 154000 then
		  self:加载系统PK单位(地图)
	             elseif 序号 == 154001 then
		  self:加载系统PK单位(地图)
		else
			self:加载指定单位(地图)
		end
	else --玩家战斗
		for n = 1, #self.敌方数据 do --敌方
			self.参战玩家[#self.参战玩家 + 1] = {队伍 = self.敌方数据[n].队伍,助战=self.敌方数据[n].助战, id = self.敌方数据[n].id, 连接id = 玩家数据[self.敌方数据[n].id].连接id, 断线 = false, 退出 = false}
			-- self:加载单个玩家(self.敌方数据[n].id, n)
			if self.敌方数据[n].队长 then
			    队长=#self.参战单位+1
			end
			if self.敌方数据[n].助战 then
				if self.参战单位[队长].助战表==nil then
					self.参战单位[队长].助战表={}
				end
				self.参战单位[队长].助战表[#self.参战单位[队长].助战表+1]=#self.参战单位+1
				if self.单挑模式 then
					self:加载单挑玩家(self.敌方数据[n].id, n,self.参战单位[队长].玩家id,队长)
				else
					self:加载单个玩家(self.敌方数据[n].id, n,self.参战单位[队长].玩家id,队长)
				end
			else
				if self.单挑模式 then
					self:加载单挑玩家(self.敌方数据[n].id, n)
				else
					self:加载单个玩家(self.敌方数据[n].id, n)
				end
			end
		end
	end
	self:重置单位属性()

	local x待发送数据 = {}
	for n = 1, #self.参战玩家 do
		if not self.参战玩家[n].助战 then
			发送数据(self.参战玩家[n].连接id, 5501, {id = self.参战玩家[n].队伍, 音乐 = self.战斗音乐, 单挑模式 = self.单挑模式,战斗类型=self.战斗类型, PK战斗 = self.PK战斗, 总数 = #self.参战单位})---C改

			-- 发送数据(self.参战玩家[n].连接id, 5501, {id = self.参战玩家[n].队伍, 音乐 = self.战斗音乐, 单挑模式 = self.单挑模式, PK战斗 = self.PK战斗, 总数 = #self.参战单位})
			for i = 1, #self.参战单位 do
				x待发送数据[i] = self:取加载信息(i)
				x待发送数据[i].回合数 = self.回合数
			end
			发送数据(self.参战玩家[n].连接id, 5515, x待发送数据)--5502
		end
	end

	x待发送数据 = {}

	for n = 1, #self.参战单位 do
		if self.参战单位[n].自动集火 then
			self:刷新自动集火目标(n)
			break
		end
	end

end
function 战斗处理类:进入观战(玩家id, 任务id)
	self.观战玩家[#self.观战玩家 + 1] = {队伍 = 玩家数据[任务id].队伍, id = 玩家id, 连接id = 玩家数据[玩家id].连接id, 断线 = false, 退出 = false}
	local x待发送数据 = {}
	for n = 1, #self.参战玩家 do
		for i = 1, #self.参战单位 do
			x待发送数据[i] = self:取加载信息(i)
			x待发送数据[i].回合数 = self.回合数
		end--5502
	end
	local 观战队伍 = 玩家数据[任务id].队伍
	if 观战队伍 == 0 then
		观战队伍 = 任务id
	end
	if 玩家数据[任务id].guanzhan ~= 0 then
		观战队伍 = 玩家数据[任务id].guanzhan
		玩家数据[玩家id].guanzhan = 玩家数据[任务id].guanzhan
	else
		玩家数据[玩家id].guanzhan = 观战队伍
	end
	发送数据(玩家数据[玩家id].连接id, 5501, {id = 观战队伍, 音乐 = self.战斗音乐, 总数 = #self.参战单位, 观战 = true})
	发送数据(玩家数据[玩家id].连接id, 5515, x待发送数据)
	x待发送数据 = {}
end


function 战斗处理类:加载系统PK单位(单位组,位置)
	local zf = "普通"
	if 单位组[1].附加阵法~=nil then
		zf=单位组[1].附加阵法
	end
	for n = 1, #单位组 do
		self.参战单位[#self.参战单位 + 1] = {}
		self.参战单位[#self.参战单位].名称 = 单位组[n].名称
		self.参战单位[#self.参战单位].模型 = 单位组[n].模型
		self.参战单位[#self.参战单位].等级 = 单位组[n].等级
		self.参战单位[#self.参战单位].队伍 = 0
		self.参战单位[#self.参战单位].位置 = 单位组[n].位置
		self.参战单位[#self.参战单位].类型 = "bb"
		if 单位组[n].角色 and 单位组[n].角色 == true then
		 self.参战单位[#self.参战单位].类型 = "角色"
		end
		self.参战单位[#self.参战单位].武器 = 单位组[n].武器
		self.参战单位[#self.参战单位].玩家id = 0
		self.参战单位[#self.参战单位].分类 = "野怪"
		self.参战单位[#self.参战单位].可捕捉 = 单位组[n].可捕捉
		self.参战单位[#self.参战单位].附加阵法 = zf
		self.参战单位[#self.参战单位].魔法 = 500--单位组[n].魔法
		self.参战单位[#self.参战单位].最大魔法 = 500--单位组[n].魔法
		self.参战单位[#self.参战单位].技能 = 单位组[n].技能 or nil
		-- self.参战单位[#self.参战单位].符石技能 = {}
		self.参战单位[#self.参战单位].灵力 = 0--单位组[n].灵力 or 0
		self.参战单位[#self.参战单位].伤害 = qz(单位组[n].伤害)
		self.参战单位[#self.参战单位].防御 = qz(单位组[n].防御 or 0)
		self.参战单位[#self.参战单位].法防 = qz(单位组[n].法防 or 0)
		self.参战单位[#self.参战单位].法伤 = qz(单位组[n].法伤 or 0)
		self.参战单位[#self.参战单位].速度 = qz(单位组[n].速度)

		self.参战单位[#self.参战单位].基础伤害 = self.参战单位[#self.参战单位].伤害
		self.参战单位[#self.参战单位].基础法伤 = self.参战单位[#self.参战单位].法伤
		self.参战单位[#self.参战单位].基础速度 = self.参战单位[#self.参战单位].速度

		self.参战单位[#self.参战单位].气血 = qz(单位组[n].气血)
		self.参战单位[#self.参战单位].最大气血 = qz(单位组[n].气血)
		self.参战单位[#self.参战单位].魔力 = qz(单位组[n].魔力 or 0)
		self.参战单位[#self.参战单位].力量 = qz(单位组[n].力量 or 0)
		self.参战单位[#self.参战单位].命中 = qz(单位组[n].力量 or 0)
		self.参战单位[#self.参战单位].耐力 = qz(单位组[n].耐力 or 0)
		self.参战单位[#self.参战单位].敏捷 = qz(单位组[n].敏捷 or 0)
		self.参战单位[#self.参战单位].躲避 = qz(单位组[n].躲避 or 0)
		self.参战单位[#self.参战单位].治疗能力 = qz(单位组[n].治疗能力 or 0)
		self.参战单位[#self.参战单位].固定伤害 = qz(单位组[n].固定伤害 or 0)
		self.参战单位[#self.参战单位].封印命中等级 = qz(单位组[n].封印命中等级 or 0)
		self.参战单位[#self.参战单位].抵抗封印等级 = qz(单位组[n].抵抗封印等级 or 0)
		self.参战单位[#self.参战单位].饰品显示 = 单位组[n].饰品显示
		self.参战单位[#self.参战单位].饰品颜色 = 单位组[n].饰品颜色
		self.参战单位[#self.参战单位].招式特效 = 单位组[n].招式特效 or {}
		self.参战单位[#self.参战单位].变异 = 单位组[n].变异
		self.参战单位[#self.参战单位].法宝佩戴原 = 单位组[n].法宝 or {}
		self.参战单位[#self.参战单位].门派 = 单位组[n].门派
		self.参战单位[#self.参战单位].AI战斗 = 单位组[n].AI战斗
		self.参战单位[#self.参战单位].开场发言 = 单位组[n].开场发言
		self.参战单位[#self.参战单位].被封发言 = 单位组[n].被封发言
		self.参战单位[#self.参战单位].被封必中 = 单位组[n].被封必中
		self.参战单位[#self.参战单位].不可封印 = 单位组[n].不可封印
		self.参战单位[#self.参战单位].额外目标数 = 单位组[n].额外目标数
		self.参战单位[#self.参战单位].共生 = 单位组[n].共生
		self.参战单位[#self.参战单位].锦衣 = 单位组[n].锦衣
		self.参战单位[#self.参战单位].不可操作 = 单位组[n].不可操作
		self.参战单位[#self.参战单位].星座 = 单位组[n].星座
		self.参战单位[#self.参战单位].染色方案=单位组[n].染色方案
		self.参战单位[#self.参战单位].染色组=单位组[n].染色组
		self.参战单位[#self.参战单位].特殊变异 = 单位组[n].特殊变异
		self.参战单位[#self.参战单位].物伤减少=单位组[n].物伤减少
		self.参战单位[#self.参战单位].法伤减少=单位组[n].法伤减少
		self.参战单位[#self.参战单位].躲避减少=单位组[n].躲避减少
		--------
		self.参战单位[#self.参战单位].受伤百分比=单位组[n].受伤百分比
		self.参战单位[#self.参战单位].增伤百分比=单位组[n].增伤百分比
		self.参战单位[#self.参战单位].递增伤害=单位组[n].递增伤害
		self.参战单位[#self.参战单位].前缀=单位组[n].前缀
		self.参战单位[#self.参战单位].后缀=单位组[n].后缀
		-- self.参战单位[#self.参战单位].递增伤害=单位组[n].递增伤害
		--------

		-- if 调试模式 then
		--  print(单位组[n].名称,单位组[n].气血)
		-- end
		-- print(HDPZ[Qunandu[self.战斗类型]])
		if Qunandu[self.战斗类型] and HDPZ[Qunandu[self.战斗类型]] then
			 -- print(self.战斗类型)
			self.参战单位[#self.参战单位].伤害 = qz(self.参战单位[#self.参战单位].伤害*HDPZ[Qunandu[self.战斗类型]].难度)
			self.参战单位[#self.参战单位].法伤 = qz(self.参战单位[#self.参战单位].伤害*HDPZ[Qunandu[self.战斗类型]].难度)
		elseif self.战斗类型==140000 then
			local ms=雁塔地宫:取奖励等级(单位组[n].层数 or 1)
			-- print(HDPZ[ms].难度)
			self.参战单位[#self.参战单位].伤害 = qz(self.参战单位[#self.参战单位].伤害*HDPZ[ms].难度)
			self.参战单位[#self.参战单位].法伤 = qz(self.参战单位[#self.参战单位].伤害*HDPZ[ms].难度)
		end

		-- print(单位组[n].名称,单位组[n].啊实打实的,单位组[n].变异)
		if 单位组[n].主怪 then
			self.参战单位[#self.参战单位].主怪=#self.参战单位
		end
		if 单位组[n].炫彩~= nil then
			self.参战单位[#self.参战单位].炫彩 = 单位组[n].炫彩
			self.参战单位[#self.参战单位].炫彩组 =单位组[n].炫彩组
		end
		self.参战单位[#self.参战单位].修炼 = 单位组[n].修炼 or {物抗=0,法抗=0,攻修=0}
		if self.参战单位[#self.参战单位].附加阵法 ~= "普通" then
			self:增加阵法属性(#self.参战单位, self.参战单位[#self.参战单位].附加阵法, 位置)
		end
		if 单位组[n].角色 then
			self.参战单位[#self.参战单位].类型 = "系统角色"
			if self.参战单位[#self.参战单位].锦衣 == nil then
				self.参战单位[#self.参战单位].锦衣 = {}
			end
		end
		if self.战斗类型 == 100005 then --怪物取幼儿园
			-- print(单位组[n].变异)
			if 单位组[n].变异 then
				self.参战单位[#self.参战单位].分类 = "变异"
			else
				self.参战单位[#self.参战单位].分类 = "宝宝"
			end
		elseif self.战斗类型 == 100018 then --门派乾坤袋
			self.参战单位[#self.参战单位].乾坤袋 = true
		elseif self.参战单位[#self.参战单位].特殊变异 then
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "其实我内心是很善良得，你们可千万不要错杀好鬼呀#52"}
		elseif self.参战单位[#self.参战单位].开场发言~=nil then
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = self.参战单位[#self.参战单位].开场发言}
		end

		self.参战单位[#self.参战单位].主动技能 = {}
		self.参战单位[#self.参战单位].法宝技能 = {}
		if 单位组[n].主动技能 then
			for i = 1, #单位组[n].主动技能 do
				self.参战单位[#self.参战单位].主动技能[i] = {名称 = 单位组[n].主动技能[i], 等级 = 单位组[n].等级 + 10}
			end
		end

		if 单位组[n].法宝技能 then
			for i = 1, #单位组[n].法宝技能 do
				self.参战单位[#self.参战单位].法宝技能[i] = {名称 = 单位组[n].法宝技能[i], 等级 = 15}
			end
		end
		self.参战单位[#self.参战单位].已加技能 = {}
		self:设置队伍区分(0)
		-- self.参战单位[#self.参战单位].伤害=1
	end
end



function 战斗处理类:单挑召唤计算(编号,位置)
	if 位置==nil or 位置==0 then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/召唤位置为0返回")
		return
	end
	local id
	local xh=0
	for k,v in pairs(self.参战单位[编号].单挑宝宝统计) do
		if v.位置==位置 then
			id=v.bbid
			xh=k
			break
		end
	end
	local 是否有 = false
	local 遗志 = 0
	if id~=nil and self.参战单位[id] then
		是否有 =true
		if self.参战单位[id].法术状态.遗志 or self.参战单位[id].法术状态.高级遗志 or self.参战单位[id].法术状态.超级遗志 then
			遗志 = 1
		end
	end
	if id ~= nil and self.参战单位[id].法术状态.复活 ~= nil then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你有召唤兽尚在复活中，暂时无法召唤新的召唤兽")
		return false
	elseif #self.参战单位[编号].召唤数量 >= 12 then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你在本次战斗中可召唤的数量已达上限")
		return false
	end
	local 目标 = self.参战单位[编号].指令.目标
	for n = 1, #self.参战单位[编号].召唤数量 do
		if self.参战单位[编号].召唤数量[n] == 目标 then
			self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/这只召唤兽已经出战过了")
			return false
		end
	end
	local 玩家id = self.参战单位[编号].玩家id
	if 玩家数据[玩家id].召唤兽.数据[目标] == nil then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/召唤兽数据错误")
		return false
	end
	if 玩家数据[玩家id].召唤兽.数据[目标].忠诚 <= 40 and 取随机数() >= 50 then
		常规提示(id, "你的召唤兽由于忠诚过低，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].等级 > 玩家数据[玩家id].角色.等级 + 10 then
		常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].参战等级 > 玩家数据[玩家id].角色.等级 then
		常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].种类 ~= "神兽" and 玩家数据[玩家id].召唤兽.数据[目标].寿命 <= 10 then
		常规提示(id, "你的召唤兽由于寿命过低，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].气血 <= 0 then
		常规提示(id, "你的召唤兽由于气血不足,不愿意参战")
		return false
	end
	self.执行等待 = self.执行等待 + 5

	if id == nil then --当前没有召唤兽的时候
		self:设置队伍区分(self.参战单位[编号].队伍)
		id = #self.参战单位 + 1
		self.参战单位[编号].单挑宝宝统计[#self.参战单位[编号].单挑宝宝统计 + 1] = {bbid=id,位置=位置}
	else  --已经有了一直召唤兽了，再召唤进行替换
		-- if self.参战单位[id].抗物 and self.参战单位[id].抗物[1] then
		--  self.全场属性[self.参战单位[id].队伍].抗物 = self.全场属性[self.参战单位[id].队伍].抗物-self.参战单位[id].抗物[1]
		-- elseif self.参战单位[id].抗法 and self.参战单位[id].抗法[1] then
		--  self.全场属性[self.参战单位[id].队伍].抗法 = self.全场属性[self.参战单位[id].队伍].抗法-self.参战单位[id].抗法[1]
		-- end
		self:还原指定召唤兽属性(self.参战单位[id].玩家id)
		self.参战单位[编号].单挑宝宝统计[xh] = {bbid=id,位置=位置}
	end

	self.参战单位[id] = {}
	self.参战单位[id] = table.loadstring(table.tostring(玩家数据[玩家id].召唤兽.数据[目标]))
	self.参战单位[id].队伍 = self.参战单位[编号].队伍
	self.参战单位[id].位置 = 位置
	self.参战单位[id].类型 = "bb"
	self.参战单位[id].玩家id = 玩家id
	self.参战单位[id].主人序号 = self.参战单位[编号].序号
	self.参战单位[id].附加阵法 = self.参战单位[编号].附加阵法
	-- self.参战单位[id].法防 = 0
	-- self.参战单位[id].法伤 = 0
	self.参战单位[id].自动战斗 = self.参战单位[编号].自动战斗
	self.参战单位[id].人参果 = {枚=0,回合=4}
	self.参战单位[id].骤雨 = {层数=0,回合=3}
	self.参战单位[id].超级必杀=0
	self.参战单位[id].超级夜战 = 0
	self.参战单位[id].首次被伤 = {物理=0,法术=0,每回物理=0,每回法术=0}
	self.参战单位[id].超级偷袭 = false
	self.参战单位[id].超级敏捷 = {概率=0,触发=0,执行=false,指令={}}
	self.参战单位[id].召唤回合 = self.回合数

	self.参战单位[id].战意 = 0
	self.参战单位[id].超级战意 = 0
	self.参战单位[id].五行珠 = 0
	self.参战单位[id].已加技能 = {}
	self.参战单位[id].主动技能 = {}
	self.参战单位[id].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}
	self.参战单位[编号].召唤兽 = id --这里怕是要改哦
	self.参战单位[编号].召唤数量[#self.参战单位[编号].召唤数量 + 1] = 目标

	if self.参战单位[id].主人序号~=nil and self.参战单位[self.参战单位[id].主人序号]~=nil and self.参战单位[self.参战单位[id].主人序号].玄灵珠~=nil then --玄灵珠
		local ls玄灵珠 = self.参战单位[self.参战单位[id].主人序号].玄灵珠
		if ls玄灵珠.类型=="回春" and ls玄灵珠.回春 > 0 then
			-- self:增加气血(self.参战单位[id].主人序号,ls玄灵珠.回春*168,"玄灵珠·回春")
			self:动画加血流程(self.参战单位[id].主人序号,ls玄灵珠.回春*168,"玄灵珠·回春")
			self:增加愤怒(self.参战单位[id].主人序号,6)
			self:添加状态("玄灵珠·回春",self.参战单位[self.参战单位[id].主人序号],self.参战单位[self.参战单位[id].主人序号],69)
		elseif ls玄灵珠.类型=="破军" and ls玄灵珠.破军 > 0 then
			self.参战单位[self.参战单位[id].主人序号].玄灵珠破军=ls玄灵珠.破军
			self:添加状态("玄灵珠·破军",self.参战单位[self.参战单位[id].主人序号],self.参战单位[self.参战单位[id].主人序号],69)
		end
	end

	for n = 1, #玩家数据[玩家id].召唤兽.数据 do
		if 玩家数据[玩家id].召唤兽.数据[n].认证码 == 玩家数据[玩家id].角色.参战宝宝.认证码 then
			玩家数据[玩家id].召唤兽.数据[n].参战信息 = nil
		end
	end

	-- 玩家数据[玩家id].角色.参战宝宝 = {}
	-- 玩家数据[玩家id].角色.参战宝宝 = table.loadstring(table.tostring(玩家数据[玩家id].召唤兽.数据[目标]:取存档数据()))
	-- 玩家数据[玩家id].角色.参战信息 = 1
	-- 玩家数据[玩家id].召唤兽.数据[目标].参战信息 = 1
	-- 发送数据(玩家数据[玩家id].连接id, 18, 玩家数据[玩家id].角色.参战宝宝)
	self:刷新丸子技能(id)----------佬伍修改（修改每回合进场触发超级技能）

	self.战斗流程[#self.战斗流程 + 1] = {流程 = 623, 攻击方 = 编号, 挨打方 = {{挨打方 = id, 队伍 = self.参战单位[编号].队伍, 数据 = self:取加载信息(id)}}}

	self:单独重置属性(id) --id=召唤兽的编号
	if self.参战单位[id].神出鬼没 ~= nil then
		self.参战单位[id].指令 = {目标 = id}
		self:增益技能计算(id, "修罗隐身", self.参战单位[id].等级)
	elseif self.参战单位[id].隐身 ~= nil then
		self.参战单位[id].指令 = {目标 = id}
		self:增益技能计算(id, "修罗隐身", self.参战单位[id].等级)
	end

	if self.参战单位[id]["超级否定信仰"] then
		if 超级技能状态名称[self.参战单位[id]["超级否定信仰"]] then
			self:添加状态(超级技能状态名称[self.参战单位[id]["超级否定信仰"]], self.参战单位[id], self.参战单位[id], self.参战单位[id].等级)
			self.战斗流程[#self.战斗流程+1]={流程=902,攻击方=id,挨打方={{挨打方=id,增加状态=超级技能状态名称[self.参战单位[id]["超级否定信仰"]]}}}
		end
	end


	if self.回合数 >= 2 then
		if self.参战单位[id].进击必杀 == 30 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "高级进击必杀", self.参战单位[id].等级)
		elseif self.参战单位[id].进击必杀 == 15 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "进击必杀", self.参战单位[id].等级)
		elseif self.参战单位[id].进击必杀 == 31 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "超级进击必杀", self.参战单位[id].等级)
		end
		if self.参战单位[id].进击法暴 == 21 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "超级进击法暴", self.参战单位[id].等级)
		elseif self.参战单位[id].进击法暴 == 20 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "高级进击法暴", self.参战单位[id].等级)
		elseif self.参战单位[id].进击法暴 == 10 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "进击法暴", self.参战单位[id].等级)
		end
		if self.参战单位[id].盾气==1 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "盾气", self.参战单位[id].等级)
		elseif self.参战单位[id].盾气==2 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "高级盾气", self.参战单位[id].等级)
		elseif self.参战单位[id].盾气==3 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "超级盾气", self.参战单位[id].等级)
			self.参战单位[self.参战单位[id].主人序号].指令 = {目标 = self.参战单位[id].主人序号}
			self:增益技能计算(self.参战单位[id].主人序号, "盾气", self.参战单位[self.参战单位[id].主人序号].等级)
		end
		if self.参战单位[id].遗志~=nil and 是否有 then
			if self.参战单位[id].遗志==1 then
				self.参战单位[id].指令 = {目标 = id}
				self:增益技能计算(id, "遗志", self.参战单位[id].等级)
				if 遗志==1 then
					self.参战单位[id].法术状态.遗志.层数=2
				end
			elseif self.参战单位[id].遗志==2 then
				self.参战单位[id].指令 = {目标 = id}
				self:增益技能计算(id, "高级遗志", self.参战单位[id].等级)
				if 遗志==1 then
					self.参战单位[id].法术状态.高级遗志.层数=2
				end
			elseif self.参战单位[id].遗志==3 then
				self.参战单位[id].指令 = {目标 = id}
				self:增益技能计算(id, "超级遗志", self.参战单位[id].等级)
				if 遗志==1 then
					self.参战单位[id].法术状态.高级遗志.层数=2
				end
			end
		end
		if self.参战单位[id].模型=="超级鲲鹏" or self.参战单位[id].模型=="进阶超级鲲鹏" then
			if self.参战单位[id].逍遥游~=nil and self:取唯一造型(self.参战单位[id].主人序号,"超级鲲鹏") then
				self:恢复技能计算(id,"鲲鹏出场",self.参战单位[id].等级,id)
				self.参战单位[id].唯一鲲鹏=1
			end
			for i,v in ipairs(self.参战单位[id].主动技能) do
			  if v.名称=="水击三千" then
				self.参战单位[id].指令.类型="法术"
				self.参战单位[id].指令.参数=v.名称
				self.参战单位[id].指令.目标=self:取单个敌方气血最低(id)
				self:物攻技能计算(id, v.名称, self.参战单位[id].等级)
				break
			  elseif v.名称=="扶摇万里" then
				self.参战单位[id].指令.类型="法术"
				self.参战单位[id].指令.参数=v.名称
				self.参战单位[id].指令.目标=self:取单个敌方气血最低(id)
				self:法攻技能计算(id,v.名称,self.参战单位[id].等级,3)
				break
			  end
			end
			self.参战单位[id].唯一鲲鹏=nil
		end
			-- if self.参战单位[id].进阶 ~= nil and self.参战单位[id].进阶.开启 and self.参战单位[id].进阶.特性 ~= "无" then --设置开关
			-- 	self:添加特性属性(id, self.参战单位[id].进阶)
			-- end
	end
			if self.参战单位[id].进阶 ~= nil and self.参战单位[id].进阶.开启 and self.参战单位[id].进阶.特性 ~= "无" then --设置开关
				self:添加特性属性(id, self.参战单位[id].进阶)------------C改
			end
	return true
end

function 战斗处理类:召唤计算(编号)
	local id = self.参战单位[编号].召唤兽
	local 是否有 = false
	local 遗志 = 0
	if id~=nil and self.参战单位[id] then
		是否有 =true
		if self.参战单位[id].法术状态.遗志 or self.参战单位[id].法术状态.高级遗志 or self.参战单位[id].法术状态.超级遗志 then
			遗志 = 1
		end
	end
	if id ~= nil and self.参战单位[id].法术状态.复活 ~= nil then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你有召唤兽尚在复活中，暂时无法召唤新的召唤兽")
		return false
	elseif #self.参战单位[编号].召唤数量 >= 12 then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你在本次战斗中可召唤的数量已达上限")
		return false
	end
	local 目标 = self.参战单位[编号].指令.目标
	for n = 1, #self.参战单位[编号].召唤数量 do
		if self.参战单位[编号].召唤数量[n] == 目标 then
			self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/这只召唤兽已经出战过了")
			return false
		end
	end
	local 玩家id = self.参战单位[编号].玩家id
	if 玩家数据[玩家id].召唤兽.数据[目标] == nil then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/召唤兽数据错误")
		return false
	end
	if 玩家数据[玩家id].召唤兽.数据[目标].忠诚 <= 40 and 取随机数() >= 50 then
		常规提示(id, "你的召唤兽由于忠诚过低，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].等级 > 玩家数据[玩家id].角色.等级 + 10 then
		常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].参战等级 > 玩家数据[玩家id].角色.等级 then
		常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].种类 ~= "神兽" and 玩家数据[玩家id].召唤兽.数据[目标].寿命 <= 50 then
		常规提示(id, "你的召唤兽由于寿命过低，不愿意参战")
		return false
	elseif 玩家数据[玩家id].召唤兽.数据[目标].气血 <= 0 then
		常规提示(id, "你的召唤兽由于气血不足,不愿意参战")
		return false
	end
	self.执行等待 = self.执行等待 + 5
	local 重新加载信息 = false
	if id == nil then --当前没有召唤兽的时候
		self:设置队伍区分(self.参战单位[编号].队伍)
		id = #self.参战单位 + 1
		重新加载信息 = true
	else  --已经有了一直召唤兽了，再召唤进行替换
		-- if self.参战单位[id].抗物 and self.参战单位[id].抗物[1] then
		--  self.全场属性[self.参战单位[id].队伍].抗物 = self.全场属性[self.参战单位[id].队伍].抗物-self.参战单位[id].抗物[1]
		-- elseif self.参战单位[id].抗法 and self.参战单位[id].抗法[1] then
		--  self.全场属性[self.参战单位[id].队伍].抗法 = self.全场属性[self.参战单位[id].队伍].抗法-self.参战单位[id].抗法[1]
		-- end
		self:还原指定召唤兽属性(self.参战单位[id].玩家id)
	end
	self.参战单位[id] = {}
	self.参战单位[id] = table.loadstring(table.tostring(玩家数据[玩家id].召唤兽.数据[目标]))
	self.参战单位[id].队伍 = self.参战单位[编号].队伍
	self.参战单位[id].位置 = self.参战单位[编号].位置 + 5 --位置为固定位置
	self.参战单位[id].类型 = "bb"
	self.参战单位[id].玩家id = 玩家id
	self.参战单位[id].主人序号 = self.参战单位[编号].序号
	self.参战单位[id].附加阵法 = self.参战单位[编号].附加阵法
	-- self.参战单位[id].法防 = 0
	-- self.参战单位[id].法伤 = 0
	self.参战单位[id].自动战斗 = self.参战单位[编号].自动战斗
	self.参战单位[编号].召唤兽 = id
	self.参战单位[id].人参果 = {枚=0,回合=4}
	self.参战单位[id].骤雨 = {层数=0,回合=3}

	self.参战单位[id].超级必杀=0
	self.参战单位[id].超级夜战 = 0
	self.参战单位[id].首次被伤 = {物理=0,法术=0,每回物理=0,每回法术=0}
	self.参战单位[id].超级偷袭 = false
	self.参战单位[id].超级敏捷 = {概率=0,触发=0,执行=false,指令={}}
	self.参战单位[id].召唤回合 = self.回合数

	self.参战单位[id].战意 = 0
	self.参战单位[id].超级战意 = 0
	self.参战单位[id].五行珠 = 0
	self.参战单位[id].已加技能 = {}
	self.参战单位[id].主动技能 = {}
	self.参战单位[编号].召唤数量[#self.参战单位[编号].召唤数量 + 1] = 目标
	self.参战单位[id].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}

	if self.参战单位[id].主人序号~=nil and self.参战单位[self.参战单位[id].主人序号]~=nil and self.参战单位[self.参战单位[id].主人序号].玄灵珠~=nil then --玄灵珠
		local ls玄灵珠 = self.参战单位[self.参战单位[id].主人序号].玄灵珠
		if ls玄灵珠.类型=="回春" and ls玄灵珠.回春 > 0 then
			-- self:增加气血(self.参战单位[id].主人序号,ls玄灵珠.回春*168,"玄灵珠·回春")
			self:动画加血流程(self.参战单位[id].主人序号,ls玄灵珠.回春*168,"玄灵珠·回春")
			self:增加愤怒(self.参战单位[id].主人序号,1)
			self:添加状态("玄灵珠·回春",self.参战单位[self.参战单位[id].主人序号],self.参战单位[self.参战单位[id].主人序号],69)
		elseif ls玄灵珠.类型=="破军" and ls玄灵珠.破军 > 0 then
			self.参战单位[self.参战单位[id].主人序号].玄灵珠破军=ls玄灵珠.破军
			self:添加状态("玄灵珠·破军",self.参战单位[self.参战单位[id].主人序号],self.参战单位[self.参战单位[id].主人序号],69)
		end
	end

	for n = 1, #玩家数据[玩家id].召唤兽.数据 do
		if 玩家数据[玩家id].召唤兽.数据[n].认证码 == 玩家数据[玩家id].角色.参战宝宝.认证码 then
			玩家数据[玩家id].召唤兽.数据[n].参战信息 = nil
		end
	end
	玩家数据[玩家id].角色.参战宝宝 = {}
	玩家数据[玩家id].角色.参战宝宝 = table.loadstring(table.tostring(玩家数据[玩家id].召唤兽.数据[目标]:取存档数据()))
	玩家数据[玩家id].角色.参战信息 = 1
	玩家数据[玩家id].召唤兽.数据[目标].参战信息 = 1
	发送数据(玩家数据[玩家id].连接id, 18, 玩家数据[玩家id].角色.参战宝宝)
	self:刷新丸子技能(id)----------佬伍修改（修改每回合进场触发超级技能）
	-- self.战斗流程[#self.战斗流程 + 1] = {流程 = 600, 攻击方 = 编号, 挨打方 = {{挨打方 = id, 队伍 = self.参战单位[编号].队伍, 数据 = self:取加载信息(id)}}}
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 623, 攻击方 = 编号, 挨打方 = {{挨打方 = id, 队伍 = self.参战单位[编号].队伍, 数据 = self:取加载信息(id)}}}

	self:单独重置属性(id)
	if self.参战单位[编号].法术状态.青狮獠牙 then
		self.参战单位[id].最大气血 = qz(self.参战单位[id].最大气血 * self.参战单位[编号].法术状态.青狮獠牙.境界)
		self.参战单位[id].气血 = math.min(self.参战单位[id].气血, self.参战单位[id].最大气血)
	end
	if self.参战单位[id].神出鬼没 ~= nil then
		self.参战单位[id].指令 = {目标 = id}
		self:增益技能计算(id, "修罗隐身", self.参战单位[id].等级)
	elseif self.参战单位[id].隐身 ~= nil then
		self.参战单位[id].指令 = {目标 = id}
		self:增益技能计算(id, "修罗隐身", self.参战单位[id].等级)
	end


	if self.参战单位[id]["超级否定信仰"] then
		if 超级技能状态名称[self.参战单位[id]["超级否定信仰"]] then
			self:添加状态(超级技能状态名称[self.参战单位[id]["超级否定信仰"]], self.参战单位[id], self.参战单位[id], self.参战单位[id].等级)
			self.战斗流程[#self.战斗流程+1]={流程=902,攻击方=id,挨打方={{挨打方=id,增加状态=超级技能状态名称[self.参战单位[id]["超级否定信仰"]]}}}
		end
	end



	if self.回合数 >= 2 then
		if self.参战单位[id].进击必杀 == 30 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "高级进击必杀", self.参战单位[id].等级)
		elseif self.参战单位[id].进击必杀 == 15 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "进击必杀", self.参战单位[id].等级)
		elseif self.参战单位[id].进击必杀 == 31 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "超级进击必杀", self.参战单位[id].等级)
		end
		if self.参战单位[id].进击法暴 == 21 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "超级进击法暴", self.参战单位[id].等级)
		elseif self.参战单位[id].进击法暴 == 20 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "高级进击法暴", self.参战单位[id].等级)
		elseif self.参战单位[id].进击法暴 == 10 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "进击法暴", self.参战单位[id].等级)
		end
		if self.参战单位[id].盾气==1 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "盾气", self.参战单位[id].等级)
		elseif self.参战单位[id].盾气==2 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "高级盾气", self.参战单位[id].等级)
		elseif self.参战单位[id].盾气==3 then
			self.参战单位[id].指令 = {目标 = id}
			self:增益技能计算(id, "超级盾气", self.参战单位[id].等级)
			self.参战单位[self.参战单位[id].主人序号].指令 = {目标 = self.参战单位[id].主人序号}
			self:增益技能计算(self.参战单位[id].主人序号, "盾气", self.参战单位[self.参战单位[id].主人序号].等级)
		end
		if self.参战单位[id].遗志~=nil and 是否有 then
			if self.参战单位[id].遗志==1 then
				self.参战单位[id].指令 = {目标 = id}
				self:增益技能计算(id, "遗志", self.参战单位[id].等级)
				if 遗志==1 then
					self.参战单位[id].法术状态.遗志.层数=2
				end
			elseif self.参战单位[id].遗志==2 then
				self.参战单位[id].指令 = {目标 = id}
				self:增益技能计算(id, "高级遗志", self.参战单位[id].等级)
				if 遗志==1 then
					self.参战单位[id].法术状态.高级遗志.层数=2
				end
			elseif self.参战单位[id].遗志==3 then
				self.参战单位[id].指令 = {目标 = id}
				self:增益技能计算(id, "超级遗志", self.参战单位[id].等级)
				if 遗志==1 then
					self.参战单位[id].法术状态.高级遗志.层数=2
				end
			end
		end
		if self.参战单位[id].模型=="超级鲲鹏" or self.参战单位[id].模型=="进阶超级鲲鹏" then
			if self.参战单位[id].逍遥游~=nil and self:取唯一造型(self.参战单位[id].主人序号,"超级鲲鹏") then
				self:恢复技能计算(id,"鲲鹏出场",self.参战单位[id].等级,id)
				self.参战单位[id].唯一鲲鹏=1
			end
			for i,v in ipairs(self.参战单位[id].主动技能) do
			  if v.名称=="水击三千" then
				self.参战单位[id].指令.类型="法术"
				self.参战单位[id].指令.参数=v.名称
				self.参战单位[id].指令.目标=self:取单个敌方气血最低(id)
				self:物攻技能计算(id, v.名称, self.参战单位[id].等级)
				break
			  elseif v.名称=="扶摇万里" then
				self.参战单位[id].指令.类型="法术"
				self.参战单位[id].指令.参数=v.名称
				self.参战单位[id].指令.目标=self:取单个敌方气血最低(id)
				self:法攻技能计算(id,v.名称,self.参战单位[id].等级,3)
				break
			  end
			end
			self.参战单位[id].唯一鲲鹏=nil
		end
	end

	if self.参战单位[id].进阶 ~= nil and self.参战单位[id].进阶.开启 and self.参战单位[id].进阶.特性 ~= "无" then --设置开关
		self:添加特性属性(id, self.参战单位[id].进阶)
	end
	return true
end

function 战斗处理类:抓取自动数据(玩家id)
	local 更改内容={}
	local 编号
	for n=1,#self.参战单位 do
		if self.参战单位[n].玩家id==玩家id then
			更改内容[#更改内容+1]={id=n,自动开关=self.参战单位[n].自动战斗,智能施法=self.参战单位[n].智能施法,自动指令=self.参战单位[n].自动指令,自动集火=self.参战单位[n].自动集火}
			if self.参战单位[n].类型=="角色" then
				编号=n
			end
		end
	end
	if self.参战单位[编号].助战表 then
		for i=1,#self.参战单位[编号].助战表 do
			local x=self.参战单位[编号].助战表[i]
			for a=1,#self.参战单位 do
				if self.参战单位[a].玩家id == self.参战单位[x].玩家id then
					更改内容[#更改内容+1]={id=a,自动开关=self.参战单位[a].自动战斗,智能施法=self.参战单位[a].智能施法,自动指令=self.参战单位[a].自动指令,自动集火=self.参战单位[a].自动集火}
				end
			end
		end
	end
	发送数据(玩家数据[玩家id].连接id,5526,更改内容)
end

function 战斗处理类:加载指定单位(单位组)
	local zf = "普通"
	if 单位组[1].附加阵法~=nil then
		zf=单位组[1].附加阵法
	end
	-- local 同门增伤系数 = 1
	-- for i,v in pairs(self.同门增伤) do
	--     if v == 5 then
	--     	同门增伤系数 = 1.5
	--     	break
	--     elseif v == 4 then
	--     	同门增伤系数 = 1.4
	--     	break
	--     elseif v == 3 then
	--     	同门增伤系数 = 1.3
	--     	break
	--     end
	-- end
	-- if 调试模式 then 同门增伤系数 = 0.01 end
	for n = 1, #单位组 do
		self.参战单位[#self.参战单位 + 1] = {}
		self.参战单位[#self.参战单位].名称 = 单位组[n].名称
		self.参战单位[#self.参战单位].模型 = 单位组[n].模型
		self.参战单位[#self.参战单位].等级 = 单位组[n].等级
		self.参战单位[#self.参战单位].队伍 = 0
		self.参战单位[#self.参战单位].位置 = n
		self.参战单位[#self.参战单位].类型 = "bb"
		-- if 单位组[n].角色 and 单位组[n].角色 == true then
		--  self.参战单位[#self.参战单位].类型 = "系统角色"
		-- end
		self.参战单位[#self.参战单位].武器 = 单位组[n].武器
		self.参战单位[#self.参战单位].玩家id = 0
		self.参战单位[#self.参战单位].分类 = "野怪"
		self.参战单位[#self.参战单位].可捕捉 = 单位组[n].可捕捉
		self.参战单位[#self.参战单位].附加阵法 = zf
		self.参战单位[#self.参战单位].魔法 = 500--单位组[n].魔法
		self.参战单位[#self.参战单位].最大魔法 = 500--单位组[n].魔法
		self.参战单位[#self.参战单位].技能 = 单位组[n].技能 or nil
		-- self.参战单位[#self.参战单位].符石技能 = {}
		self.参战单位[#self.参战单位].灵力 = qz(单位组[n].灵力 or 1)
		self.参战单位[#self.参战单位].伤害 = qz(单位组[n].伤害 or 1)
		self.参战单位[#self.参战单位].防御 = qz(单位组[n].防御 or 1)
		self.参战单位[#self.参战单位].法防 = qz(单位组[n].法防 or 1)
		self.参战单位[#self.参战单位].法伤 = qz(单位组[n].法伤 or 1)
		self.参战单位[#self.参战单位].速度 = qz(单位组[n].速度 or 1)

		self.参战单位[#self.参战单位].基础伤害 = self.参战单位[#self.参战单位].伤害
		self.参战单位[#self.参战单位].基础法伤 = self.参战单位[#self.参战单位].法伤
		self.参战单位[#self.参战单位].基础速度 = self.参战单位[#self.参战单位].速度

		self.参战单位[#self.参战单位].气血 = qz(单位组[n].气血 or 1)
		self.参战单位[#self.参战单位].最大气血 = qz(单位组[n].气血)
		self.参战单位[#self.参战单位].魔力 = qz(单位组[n].魔力 or 0)
		self.参战单位[#self.参战单位].力量 = qz(单位组[n].力量 or 0)
		self.参战单位[#self.参战单位].命中 = qz(单位组[n].力量 or 0)
		self.参战单位[#self.参战单位].耐力 = qz(单位组[n].耐力 or 0)
		self.参战单位[#self.参战单位].敏捷 = qz(单位组[n].敏捷 or 0)
		self.参战单位[#self.参战单位].躲避 = qz(单位组[n].躲避 or 0)
		self.参战单位[#self.参战单位].治疗能力 = qz(单位组[n].治疗能力 or 0)
		self.参战单位[#self.参战单位].固定伤害 = qz(单位组[n].固定伤害 or 0)
		self.参战单位[#self.参战单位].封印命中等级 = qz(单位组[n].封印命中等级 or 0)
		self.参战单位[#self.参战单位].抵抗封印等级 = qz(单位组[n].抵抗封印等级 or 0)
		self.参战单位[#self.参战单位].饰品显示 = 单位组[n].饰品显示
		self.参战单位[#self.参战单位].饰品颜色 = 单位组[n].饰品颜色
		self.参战单位[#self.参战单位].招式特效 = 单位组[n].招式特效 or {}
		self.参战单位[#self.参战单位].变异 = 单位组[n].变异
		self.参战单位[#self.参战单位].法宝佩戴原 = 单位组[n].法宝 or {}
		self.参战单位[#self.参战单位].门派 = 单位组[n].门派
		self.参战单位[#self.参战单位].AI战斗 = 单位组[n].AI战斗
		self.参战单位[#self.参战单位].开场发言 = 单位组[n].开场发言
		self.参战单位[#self.参战单位].被封发言 = 单位组[n].被封发言
		self.参战单位[#self.参战单位].被封必中 = 单位组[n].被封必中
		self.参战单位[#self.参战单位].不可封印 = 单位组[n].不可封印
		self.参战单位[#self.参战单位].额外目标数 = 单位组[n].额外目标数
		self.参战单位[#self.参战单位].共生 = 单位组[n].共生
		self.参战单位[#self.参战单位].锦衣 = 单位组[n].锦衣

		self.参战单位[#self.参战单位].慈航 = 单位组[n].慈航-----新增状态

		self.参战单位[#self.参战单位].不可操作 = 单位组[n].不可操作
		self.参战单位[#self.参战单位].星座 = 单位组[n].星座
		self.参战单位[#self.参战单位].染色方案=单位组[n].染色方案
		self.参战单位[#self.参战单位].染色组=单位组[n].染色组
		self.参战单位[#self.参战单位].特殊变异 = 单位组[n].特殊变异
		self.参战单位[#self.参战单位].物伤减少=单位组[n].物伤减少
		self.参战单位[#self.参战单位].法伤减少=单位组[n].法伤减少
		self.参战单位[#self.参战单位].躲避减少=单位组[n].躲避减少
		--------
		self.参战单位[#self.参战单位].受伤百分比=单位组[n].受伤百分比
		self.参战单位[#self.参战单位].增伤百分比=单位组[n].增伤百分比
		self.参战单位[#self.参战单位].递增伤害=单位组[n].递增伤害
		self.参战单位[#self.参战单位].前缀=单位组[n].前缀
		self.参战单位[#self.参战单位].后缀=单位组[n].后缀
		self.参战单位[#self.参战单位].法术状态=单位组[n].法术状态 or {}
		-- self.参战单位[#self.参战单位].递增伤害=单位组[n].递增伤害
		--------
		-- if 调试模式 then
		-- 	self.参战单位[#self.参战单位].气血 = 1
		-- 	self.参战单位[#self.参战单位].最大气血 = 1
		-- 	self.参战单位[#self.参战单位].灵力 = 0
		-- 	self.参战单位[#self.参战单位].伤害 = 0
		-- 	self.参战单位[#self.参战单位].防御 = 0
		-- 	self.参战单位[#self.参战单位].法防 = 0
		-- 	self.参战单位[#self.参战单位].法伤 = 0
		-- 	self.参战单位[#self.参战单位].速度 = 0
		-- end

		if 单位组[n].主怪 then
			self.参战单位[#self.参战单位].主怪=#self.参战单位
		end
		if 单位组[n].炫彩~= nil then
			self.参战单位[#self.参战单位].炫彩 = 单位组[n].炫彩
			self.参战单位[#self.参战单位].炫彩组 =单位组[n].炫彩组
		end
		self.参战单位[#self.参战单位].修炼 = 单位组[n].修炼 or {物抗=0,法抗=0,攻修=0}
		if self.参战单位[#self.参战单位].附加阵法 ~= "普通" then
			self:增加阵法属性(#self.参战单位, self.参战单位[#self.参战单位].附加阵法, 位置)
		end
		if 单位组[n].角色 then
			self.参战单位[#self.参战单位].类型 = "系统角色"
			if self.参战单位[#self.参战单位].锦衣 == nil then
				self.参战单位[#self.参战单位].锦衣 = {}
			end
		end
		if self.战斗类型 == 100005 then --怪物取幼儿园

			if 单位组[n].变异 then
				self.参战单位[#self.参战单位].分类 = "变异"
			else
				self.参战单位[#self.参战单位].分类 = "宝宝"
			end
		elseif self.战斗类型 == 100018 then --门派乾坤袋
			self.参战单位[#self.参战单位].乾坤袋 = true
		elseif self.参战单位[#self.参战单位].特殊变异 then
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "其实我内心是很善良得，你们可千万不要错杀好鬼呀#52"}
		elseif self.参战单位[#self.参战单位].开场发言~=nil then
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = self.参战单位[#self.参战单位].开场发言}
		end

		self.参战单位[#self.参战单位].主动技能 = {}
		self.参战单位[#self.参战单位].法宝技能 = {}
		if 单位组[n].主动技能 then
			for i = 1, #单位组[n].主动技能 do
				self.参战单位[#self.参战单位].主动技能[i] = {名称 = 单位组[n].主动技能[i], 等级 = 单位组[n].等级 + 10}
			end
		end
		if 单位组[n].主动技能 then
			for i = 1, #单位组[n].主动技能 do
				self.参战单位[#self.参战单位].主动技能[i] = {名称 = 单位组[n].主动技能[i], 等级 = 单位组[n].等级 + 10}
				if 单位组[n].主动技能[i] == "观照万象" then
					self.参战单位[#self.参战单位].主动技能[i].剩余冷却回合 = 全局基础数据.观照剩余冷却 - self.回合数
					if self.回合数 >= 全局基础数据.观照剩余冷却 then
						self.参战单位[#self.参战单位].主动技能[i].剩余冷却回合 = nil
					end
				end
			end
		end

		if 单位组[n].法宝技能 then
			for i = 1, #单位组[n].法宝技能 do
				self.参战单位[#self.参战单位].法宝技能[i] = {名称 = 单位组[n].法宝技能[i], 等级 = 15}
			end
		end
		-- if self.战斗类型 >= 120010 and self.战斗类型 <= 120045 then
		-- 	天罡星属性:属性纠正(self,#self.参战单位)
		-- end
		self.参战单位[#self.参战单位].已加技能 = {}
		self:设置队伍区分(0)
		-- self.参战单位[#self.参战单位].伤害=1
	end
end

function 战斗处理类:加载单挑玩家(id,位置,助战,队长)
	self.参战单位[#self.参战单位 + 1] = {}
	self.参战单位[#self.参战单位] = table.loadstring(table.tostring(玩家数据[id].角色:取战斗属性()))--table.loadstring(table.tostring(玩家数据[id].角色:取总数据())) --这里可能要改self
	local 队伍id = id
	self.参战单位[#self.参战单位].愤怒=95
	self.参战单位[#self.参战单位].附加阵法 = "普通"
	self.参战单位[#self.参战单位].队伍 = 队伍id
	self.参战单位[#self.参战单位].位置 = 位置
	self.参战单位[#self.参战单位].类型 = "角色"
	self.参战单位[#self.参战单位].连接id = 玩家数据[id].连接id
	self.参战单位[#self.参战单位].玩家id = id
	self.参战单位[#self.参战单位].lsid = 助战
	if 助战 then
		self.参战单位[#self.参战单位].助战=true
		self.参战单位[#self.参战单位].自动战斗= self.参战单位[队长].自动战斗
		玩家数据[id].角色.自动战斗= self.参战单位[队长].自动战斗
		if self.参战单位[#self.参战单位].自动指令 ~= nil then
			self.参战单位[#self.参战单位].自动指令.下达=false
		end
	end
	self.参战单位[#self.参战单位].召唤兽 = nil
	self.参战单位[#self.参战单位].已加技能 = {}
	self.参战单位[#self.参战单位].主动技能 = {}
	self.参战单位[#self.参战单位].召唤数量 = {}
	self.参战单位[#self.参战单位].单挑宝宝统计 = {}
	self.参战单位[#self.参战单位].序号 = #self.参战单位
	----------------------------------------------C改
	if 玩家数据[id] ~= nil then
		self.参战单位[#self.参战单位].固定伤害 = self.参战单位[#self.参战单位].固定伤害 + 玩家数据[id].角色:取强化技能等级("固伤修炼")
	end
	----------------------------------------------C改
	if 玩家数据[id].角色.自动战斗 then
		self.参战单位[#self.参战单位].自动战斗 = true
	end
	if 玩家数据[id].角色.自动集火 then
		self.参战单位[#self.参战单位].自动集火 = true
	end
	self:设置队伍区分(队伍id)

	if self.参战单位[#self.参战单位].参战信息 ~= nil and 玩家数据[id].召唤兽.数据[玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)] ~= nil then
		--计算召唤兽参战条件
		local 临时bb = 玩家数据[id].召唤兽.数据[玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)]
		if 临时bb.忠诚 <= 40 and 取随机数() >= 50 then
			常规提示(id, "你的召唤兽由于忠诚过低，不愿意参战")
			return
		elseif 临时bb.等级 > self.参战单位[#self.参战单位].等级 + 10 then
			常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
			return
		elseif 临时bb.参战等级 > self.参战单位[#self.参战单位].等级 then
			常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
			return
		elseif (临时bb.种类 ~= "神兽" or 临时bb.种类 ~= "特殊神兽") and 临时bb.寿命 <= 50 then
			常规提示(id, "你的召唤兽由于寿命过低，不愿意参战")
			return
		elseif 临时bb.气血 <= 0 then
			常规提示(id, "你的召唤兽由于气血不足,不愿意参战")
			return
		end

		self.参战单位[#self.参战单位 + 1] = {}
		self.参战单位[#self.参战单位] = table.loadstring(table.tostring(玩家数据[id].召唤兽.数据[玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)]))
		self.参战单位[#self.参战单位].队伍 = 队伍id
		self.参战单位[#self.参战单位].位置 = 2--位置 + 5--2 --单挑的时候直接是2
		self.参战单位[#self.参战单位].类型 = "bb"
		self.参战单位[#self.参战单位].玩家id = id
		self.参战单位[#self.参战单位].lsid = 助战
		self.参战单位[#self.参战单位].主人序号 = #self.参战单位 - 1
		self.参战单位[#self.参战单位].附加阵法 = self.参战单位[#self.参战单位 - 1].附加阵法
		-- self.参战单位[#self.参战单位].法防 = self.参战单位[#self.参战单位].灵力
		-- self.参战单位[#self.参战单位].法伤 = qz(self.参战单位[#self.参战单位].灵力*1.28)
		self.参战单位[#self.参战单位].命中 = self.参战单位[#self.参战单位].力量
		self.参战单位[#self.参战单位 - 1].召唤兽 = #self.参战单位
		self.参战单位[#self.参战单位 - 1].单挑宝宝统计[1] = {bbid=#self.参战单位,位置=2}
		self.参战单位[#self.参战单位].自动战斗 = self.参战单位[#self.参战单位 - 1].自动战斗
		self.参战单位[#self.参战单位].已加技能 = {}
		self.参战单位[#self.参战单位].主动技能 = {}
		self.参战单位[#self.参战单位].显示饰品 = self.参战单位[#self.参战单位].饰品
		self.参战单位[#self.参战单位].饰品颜色 = self.参战单位[#self.参战单位].饰品颜色
		self.参战单位[#self.参战单位 - 1].召唤数量[1] = 玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)


		self:设置队伍区分(队伍id)
	end

end

function 战斗处理类:添加自恋发言(宝宝,玩家id,宝宝编号)

	if 玩家id~=0  then
		local bh = 玩家数据[玩家id].召唤兽:取编号(玩家数据[玩家id].角色.参战宝宝.认证码)
		if 玩家数据[玩家id] and 玩家数据[玩家id].召唤兽.数据[bh] ~= nil then
			local 文本 = "#G/qqq|"..宝宝.名称.."*"..玩家数据[玩家id].召唤兽.数据[bh].认证码.."*".."召唤兽".."/["..宝宝.名称.."]#W#28"
			local fs={}
			fs[#fs+1] = 玩家数据[玩家id].召唤兽.数据[bh]
			fs[#fs].索引类型 = "召唤兽"
			if 玩家数据[玩家id].队伍==0 then
				发送数据(玩家数据[玩家id].连接id,113,{内容=文本,频道="dw",超链接=fs})
			else
				广播队伍链接(宝宝.队伍,{内容=文本,频道="dw",超链接=fs})
			end
			for n = 1, #self.参战玩家 do
				if not self.参战玩家[n].助战  then
					发送数据(self.参战玩家[n].连接id,5512,{id=宝宝编号,队伍=true,文本=文本})
				end
			end
		end
	end
end

function 战斗处理类:加载单个玩家(id,位置,助战,队长)
	self.参战单位[#self.参战单位 + 1] = {}
	self.参战单位[#self.参战单位] = table.loadstring(table.tostring(玩家数据[id].角色:取战斗属性())) --table.loadstring(table.tostring(玩家数据[id].角色:取总数据()))

	local 队伍id = 玩家数据[id].队伍
	self.参战单位[#self.参战单位].附加阵法 = "普通"
	if 队伍id == 0 then
		队伍id = id
	else
		if 队伍数据[队伍id] ~= nil and #队伍数据[队伍id].成员数据 == 5 then
			self.参战单位[#self.参战单位].附加阵法 = 队伍数据[队伍id].阵型
		end
	end
	if self.PK战斗 then
		self.参战单位[#self.参战单位].愤怒=95
	-- else
	-- 	self.同门增伤[self.参战单位[#self.参战单位].门派] = (self.同门增伤[self.参战单位[#self.参战单位].门派] or 0) + 1
	end
	self.参战单位[#self.参战单位].队伍 = 队伍id
	self.参战单位[#self.参战单位].位置 = 位置
	self.参战单位[#self.参战单位].类型 = "角色"
	self.参战单位[#self.参战单位].连接id = 玩家数据[id].连接id
	self.参战单位[#self.参战单位].玩家id = id
	self.参战单位[#self.参战单位].lsid = 助战
	----------------------------------------------C改
	if 玩家数据[id] ~= nil then
		self.参战单位[#self.参战单位].固定伤害 = self.参战单位[#self.参战单位].固定伤害 + 玩家数据[id].角色:取强化技能等级("固伤修炼")
	end
	----------------------------------------------C改
	for k,v in pairs(__伤害配置) do
		 if self.参战单位[#self.参战单位][k] then
		 	self.参战单位[#self.参战单位][k] =self.参战单位[#self.参战单位][k] *v
		 	-- print(k..self.参战单位[#self.参战单位][k])
		 end
	end
	if 助战 then
		self.参战单位[#self.参战单位].助战=true
		-- self.参战单位[#self.参战单位].自动战斗= self.参战单位[队长].自动战斗
		-- 玩家数据[id].角色.自动战斗= self.参战单位[队长].自动战斗
	end
	self.参战单位[#self.参战单位].召唤兽 = nil
	self.参战单位[#self.参战单位].已加技能 = {}
	self.参战单位[#self.参战单位].主动技能 = {}
	self.参战单位[#self.参战单位].召唤数量 = {}
	--self.参展单位[#self.参战单位].锦衣 = {}
	-- self.参战单位[#self.参战单位].初速度 = self.参战单位[#self.参战单位].速度
	self.参战单位[#self.参战单位].序号 = #self.参战单位
	if 玩家数据[id].角色.自动战斗 then
		self.参战单位[#self.参战单位].自动战斗 = true
	end
	if 玩家数据[id].角色.自动集火 then
		self.参战单位[#self.参战单位].自动集火 = true
	end
	self:设置队伍区分(队伍id)
	if self.参战单位[#self.参战单位].附加阵法 ~= "普通" then
		if 玩家数据[id].队伍 ~= nil and self:直接取玩家经脉(玩家数据[id].队伍, "扶阵") then
			self:增加阵法属性(#self.参战单位, self.参战单位[#self.参战单位].附加阵法, 位置, 0.03,队伍id)
		else
			self:增加阵法属性(#self.参战单位, self.参战单位[#self.参战单位].附加阵法, 位置,nil,队伍id)
		end
	end
	if self.参战单位[#self.参战单位].自动指令 ~= nil then
		for i = 1,#花果山随机技能 do
			if self.参战单位[#self.参战单位].自动指令.参数 == 花果山随机技能[i] then
				self.参战单位[#self.参战单位].自动指令.参数 = ""
				self.参战单位[#self.参战单位].自动指令.类型 = "攻击"
			end
		end
	end
	if    self.战斗类型>=120043 and   self.战斗类型<=120067  then
		if self.参战单位[#self.参战单位].秘境技能 ~= "无" then
			self:增加秘境技能属性(#self.参战单位, self.参战单位[#self.参战单位].秘境技能,位置)
		end
	end

	if self.参战单位[#self.参战单位].参战信息 ~= nil and 玩家数据[id].召唤兽.数据[玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)] ~= nil then
		--计算召唤兽参战条件
		local 临时bb = 玩家数据[id].召唤兽.数据[玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)]
		if 临时bb.忠诚 <= 40 and 取随机数() >= 50 then
			常规提示(id, "你的召唤兽由于忠诚过低，不愿意参战")
			return
		elseif 临时bb.等级 > self.参战单位[#self.参战单位].等级 + 10 then
			常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
			return
		elseif 临时bb.参战等级 > self.参战单位[#self.参战单位].等级 then
			常规提示(id, "你的召唤兽由于等级过高或参战等级高于您的等级，不愿意参战")
			return
		-- elseif 临时bb.种类 ~= "神兽" and 临时bb.寿命~="★永生★" and 临时bb.寿命 <= 50 then
		elseif (临时bb.种类 ~= "神兽" or 临时bb.种类 ~= "特殊神兽") and 临时bb.寿命 <= 50 then
			常规提示(id, "你的召唤兽由于寿命过低，不愿意参战")
			return
		elseif 临时bb.气血 <= 0 then
			常规提示(id, "你的召唤兽由于气血不足,不愿意参战")
			return
		end

		self.参战单位[#self.参战单位 + 1] = {}
		self.参战单位[#self.参战单位] = table.loadstring(table.tostring(玩家数据[id].召唤兽.数据[玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)]))
		self.参战单位[#self.参战单位].队伍 = 队伍id
		self.参战单位[#self.参战单位].位置 = 位置 + 5
		self.参战单位[#self.参战单位].类型 = "bb"
		self.参战单位[#self.参战单位].玩家id = id
		self.参战单位[#self.参战单位].lsid = 助战
		self.参战单位[#self.参战单位].主人序号 = #self.参战单位 - 1
		-- self.参战单位[#self.参战单位].序号 = #self.参战单位
		self.参战单位[#self.参战单位].附加阵法 = self.参战单位[#self.参战单位 - 1].附加阵法
		-- self.参战单位[#self.参战单位].法防 = self.参战单位[#self.参战单位].灵力
		-- self.参战单位[#self.参战单位].法伤 = qz(self.参战单位[#self.参战单位].灵力*1.28)
		self.参战单位[#self.参战单位].命中 = self.参战单位[#self.参战单位].力量
		self.参战单位[#self.参战单位 - 1].召唤兽 = #self.参战单位
		self.参战单位[#self.参战单位].自动战斗 = self.参战单位[#self.参战单位 - 1].自动战斗
		self.参战单位[#self.参战单位].已加技能 = {}
		self.参战单位[#self.参战单位].主动技能 = {}
		self.参战单位[#self.参战单位].显示饰品 = self.参战单位[#self.参战单位].饰品
		self.参战单位[#self.参战单位].饰品颜色 = self.参战单位[#self.参战单位].饰品颜色
		self.参战单位[#self.参战单位 - 1].召唤数量[1] = 玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)
		if self.参战单位[#self.参战单位 - 1].bb伤害加成 ~= nil then
			self.参战单位[#self.参战单位].伤害 = qz(self.参战单位[#self.参战单位].伤害 * self.参战单位[#self.参战单位 - 1].bb伤害加成)
		end
		if self.参战单位[#self.参战单位 - 1].bb法伤加成 ~= nil then
			self.参战单位[#self.参战单位].法伤 = qz(self.参战单位[#self.参战单位].法伤 * self.参战单位[#self.参战单位 - 1].bb法伤加成)
		end

		if 临时bb.种类~="神兽" then
			local jsss = 2

			if self.参战单位[#self.参战单位].统御属性 and self.参战单位[#self.参战单位].统御属性.忠贯日月 then
				jsss=self.参战单位[#self.参战单位].统御属性.忠贯日月
			end
			--临时bb.忠诚=临时bb.忠诚 - 0.1--GetPreciseDecimal(1/jsss,2)
		end

		-- if self.参战单位[self.参战单位[#self.参战单位].主人序号].速度 >self.参战单位[#self.参战单位].等级*3 then --这啥意思？
		--  self.参战单位[#self.参战单位].速度 = self.参战单位[#self.参战单位].速度+self.参战单位[#self.参战单位].等级*1.6
		-- end

	 if 玩家数据[id].角色.兽魂 ~= nil   then
	      if 玩家数据[id].角色.兽魂.一 == "暴起"  then
	        self.参战单位[#self.参战单位].伤害 =   math.floor(self.参战单位[#self.参战单位].伤害*1.05)
	      end
	      if 玩家数据[id].角色.兽魂.一 == "雷伤"  then
	        self.参战单位[#self.参战单位].法伤 =   math.floor(self.参战单位[#self.参战单位].法伤*1.05)
	      end
	      if 玩家数据[id].角色.兽魂.一 == "灵涌"  then
        self.参战单位[#self.参战单位].最大气血 =   math.floor(self.参战单位[#self.参战单位].最大气血*1.05)
        self.参战单位[#self.参战单位].气血 =   math.floor(self.参战单位[#self.参战单位].气血*1.05)
      end
	      if 玩家数据[id].角色.兽魂.一 == "相胜"  then
	        self.参战单位[#self.参战单位].速度 =   math.floor(self.参战单位[#self.参战单位].速度*1.05)
	      end
	      if 玩家数据[id].角色.兽魂.一 == "祈胜"  then
	        self.参战单位[#self.参战单位].防御 =   math.floor(self.参战单位[#self.参战单位].防御*1.05)
	      end

	      if 玩家数据[id].角色.兽魂.二 == "暴起"  then
	        self.参战单位[#self.参战单位].伤害 =   math.floor(self.参战单位[#self.参战单位].伤害*1.05)
	      end
	      if 玩家数据[id].角色.兽魂.二 == "雷伤"  then
	        self.参战单位[#self.参战单位].法伤 =   math.floor(self.参战单位[#self.参战单位].法伤*1.05)
	      end
	      if 玩家数据[id].角色.兽魂.二 == "灵涌"  then
        self.参战单位[#self.参战单位].最大气血 =   math.floor(self.参战单位[#self.参战单位].最大气血*1.05)
        self.参战单位[#self.参战单位].气血 =   math.floor(self.参战单位[#self.参战单位].气血*1.05)
      end
	      if 玩家数据[id].角色.兽魂.二 == "相胜"  then
	        self.参战单位[#self.参战单位].速度 =  math.floor( self.参战单位[#self.参战单位].速度*1.05)
	      end
	      if 玩家数据[id].角色.兽魂.二 == "祈胜"  then
	        self.参战单位[#self.参战单位].防御 =   math.floor(self.参战单位[#self.参战单位].防御*1.05)
	      end

	      if 玩家数据[id].角色.兽魂.三 == "千手"  then
	        self.参战单位[#self.参战单位].伤害 =   math.floor(self.参战单位[#self.参战单位].伤害*取随机数(80,150)/100)
	      end
	      if 玩家数据[id].角色.兽魂.三 == "疗愈"  then
        local 气血倍数 = 取随机数(120,150)/100
        self.参战单位[#self.参战单位].最大气血 =   math.floor(self.参战单位[#self.参战单位].最大气血*气血倍数)
        self.参战单位[#self.参战单位].气血 =   math.floor(self.参战单位[#self.参战单位].气血*气血倍数)
      end
	      if 玩家数据[id].角色.兽魂.三 == "残忍"  then
	        self.参战单位[#self.参战单位].法伤 =   math.floor(self.参战单位[#self.参战单位].法伤*取随机数(80,150)/100)
	      end
	      if 玩家数据[id].角色.兽魂.三 == "激励"  then
	        self.参战单位[#self.参战单位].速度 =   math.floor(self.参战单位[#self.参战单位].速度*取随机数(120,150)/100)
	      end
	      if 玩家数据[id].角色.兽魂.三 == "附体"  then
	        self.参战单位[#self.参战单位].防御 =   math.floor(self.参战单位[#self.参战单位].防御*取随机数(120,150)/100)
	      end

	      if 玩家数据[id].角色.兽魂.四 == "傀儡" then
	        self.参战单位[#self.参战单位].伤害 =   math.floor(self.参战单位[#self.参战单位].伤害*1.2)
	      end
	      if 玩家数据[id].角色.兽魂.四 == "陷足" then
	        self.参战单位[#self.参战单位].法伤 =   math.floor(self.参战单位[#self.参战单位].法伤*1.2)
	      end
	      if 玩家数据[id].角色.兽魂.四 == "暴戾" then
	        self.参战单位[#self.参战单位].最大气血 =   math.floor(self.参战单位[#self.参战单位].最大气血*1.2)
	        self.参战单位[#self.参战单位].气血 =   math.floor(self.参战单位[#self.参战单位].气血*1.2)
	      end
	      if 玩家数据[id].角色.兽魂.四 == "破体" then
	        self.参战单位[#self.参战单位].速度 =   math.floor(self.参战单位[#self.参战单位].速度*1.2)
	      end
	      if 玩家数据[id].角色.兽魂.四 == "御盾" then
	        self.参战单位[#self.参战单位].防御 =   math.floor(self.参战单位[#self.参战单位].防御*1.2)
	      end

	      if 玩家数据[id].角色.兽魂.五 == "沸血" then
	        self.参战单位[#self.参战单位].最大气血 =   math.floor(self.参战单位[#self.参战单位].最大气血*0.2)
	        self.参战单位[#self.参战单位].气血 =   math.floor(self.参战单位[#self.参战单位].气血*0.2)
	        self.参战单位[#self.参战单位].防御 =   math.floor(self.参战单位[#self.参战单位].防御*0.2)
	        self.参战单位[#self.参战单位].速度 =   math.floor(self.参战单位[#self.参战单位].速度*1.3)
	        self.参战单位[#self.参战单位].法伤 =   math.floor(self.参战单位[#self.参战单位].法伤*1.3)
	        self.参战单位[#self.参战单位].伤害 =   math.floor(self.参战单位[#self.参战单位].伤害*1.3)
	      end
	      if 玩家数据[id].角色.兽魂.五 == "爆裂" then
	        self.参战单位[#self.参战单位].气血 =  math.floor(self.参战单位[#self.参战单位].气血/2)
	        self.战斗发言数据[#self.战斗发言数据+1]={id=#self.参战单位,内容="#G/触发#Y/兽魂:爆裂#G/效果，2回合内当前主人属性额外增加"}
	      end
	      if 玩家数据[id].角色.兽魂.五 == "返照" then
	        self.参战单位[#self.参战单位].返照 =  1
	      end
	      if 玩家数据[id].角色.兽魂.五 == "辉耀" then
	        self.参战单位[#self.参战单位].气血 =  1
	        self.参战单位[#self.参战单位].爆裂触发 =  true
	        self.战斗发言数据[#self.战斗发言数据+1]={id=#self.参战单位,内容="#G/触发#Y/兽魂#R/辉耀#G/效果，当前释放技能，将对目标伤害增加#R/1.5倍"}
	      end
	      if 玩家数据[id].角色.兽魂.五 == "破伤" then
	        self.参战单位[#self.参战单位].最大气血 =   math.floor(self.参战单位[#self.参战单位].最大气血*0.1)
	        self.参战单位[#self.参战单位].气血 =  math.floor(self.参战单位[#self.参战单位].气血*0.1)
	        self.参战单位[#self.参战单位].法伤 =   math.floor(self.参战单位[#self.参战单位].法伤*0.1)
	        self.参战单位[#self.参战单位].伤害 =   math.floor(self.参战单位[#self.参战单位].伤害*0.1)
	        self.参战单位[#self.参战单位].速度 =   math.floor(self.参战单位[#self.参战单位].速度*0.1)
	        self.参战单位[#self.参战单位].防御 =   math.floor(self.参战单位[#self.参战单位].防御*0.1)
	      end
	  end


		local 临时技能 = {}
		self:设置队伍区分(队伍id)
	end
	if self.战斗类型 == 100017 then
		self.参战单位[#self.参战单位 + 1] = {}
		self.参战单位[#self.参战单位].名称 = "苦战中的同门"
		self.参战单位[#self.参战单位].模型 = 任务数据[self.任务id].模型
		self.参战单位[#self.参战单位].等级 = 100
		self.参战单位[#self.参战单位].变异 = false
		self.参战单位[#self.参战单位].队伍 = 队伍id
		self.参战单位[#self.参战单位].位置 = 3
		self.参战单位[#self.参战单位].类型 = "系统角色"
		self.参战单位[#self.参战单位].法伤 = 0
		self.参战单位[#self.参战单位].法防 = 0
		self.参战单位[#self.参战单位].武器 = nil
		self.参战单位[#self.参战单位].玩家id = 0
		self.参战单位[#self.参战单位].分类 = "野怪"
		self.参战单位[#self.参战单位].附加阵法 = "普通"
		self.参战单位[#self.参战单位].伤害 = 100*5
		self.参战单位[#self.参战单位].命中 = 100*5
		self.参战单位[#self.参战单位].防御 = 100
		self.参战单位[#self.参战单位].速度 = 100*1.5
		self.参战单位[#self.参战单位].灵力 = 100*5
		self.参战单位[#self.参战单位].躲避 = 100*1.5
		self.参战单位[#self.参战单位].气血 = 1500
		self.参战单位[#self.参战单位].最大气血 = 1500
		self.参战单位[#self.参战单位].魔法 = 1500
		self.参战单位[#self.参战单位].最大魔法 = 1500
		self.参战单位[#self.参战单位].技能 = {}
		self.参战单位[#self.参战单位].同门单位 = true
		self.参战单位[#self.参战单位].系统队友 = true
		self.参战单位[#self.参战单位].主动技能 = {}
		self.参战单位[#self.参战单位].AI战斗 = {方式 = "普通战斗", 参数 = 0,击飞=true,行动=true,指令="同门飞镖",回合=0}
		self:设置队伍区分(队伍id)
	end
end

function 战斗处理类:取加载信息(id) --这里，先进入战斗加载信息，然后在这里区分
	for k,v in pairs(self.参战单位[id].已加技能) do
	    if v == "超级夜战" then
	    	self.参战单位[id].超级夜战 = 1
	    elseif v == "超级偷袭" then
	    	self.参战单位[id].超级偷袭 = true
	    end
    end
	local 临时数据 = {
		气血 = self.参战单位[id].气血,
		气血上限 = self.参战单位[id].气血上限,
		最大气血 = self.参战单位[id].最大气血,
		魔法 = self.参战单位[id].魔法,
		最大魔法 = self.参战单位[id].最大魔法,
		愤怒 = self.参战单位[id].愤怒,
		名称 = self.参战单位[id].名称,
		模型 = self.参战单位[id].模型,
		队伍 = self.参战单位[id].队伍,
		位置 = self.参战单位[id].位置,
		染色方案 = self.参战单位[id].染色方案,
		染色组 = self.参战单位[id].染色组,
		炫彩 = self.参战单位[id].炫彩,
		炫彩组 = self.参战单位[id].炫彩组,
		变异 = self.参战单位[id].变异,
		变身 = self.参战单位[id].变身造型,
		类型 = self.参战单位[id].类型,
		附加阵法 = self.参战单位[id].附加阵法,
		主动技能 = self.参战单位[id].主动技能,
		特技技能 = self.参战单位[id].特技技能,
		丸子进化 = self.参战单位[id].丸子进化,
		超级夜战 = self.参战单位[id].超级夜战,
		超级偷袭 = self.参战单位[id].超级偷袭,
		超级敏捷 = self.参战单位[id].超级敏捷,
		战意 = self.参战单位[id].战意,
		超级战意 = self.参战单位[id].超级战意,
		如意神通 = self.参战单位[id].如意神通 or nil,
		共生 = self.参战单位[id].共生 or nil,
		五行珠 = self.参战单位[id].五行珠,
		人参果 = self.参战单位[id].人参果,
		骤雨 = self.参战单位[id].骤雨,
		自动指令 = self.参战单位[id].自动指令,
		自动战斗 = self.参战单位[id].自动战斗,
		智能施法=self.参战单位[id].智能施法,
		id = self.参战单位[id].玩家id,
		变身数据 = self.参战单位[id].变身数据,
		显示饰品 = self.参战单位[id].显示饰品,
		死亡击飞 = self.参战单位[id].死亡击飞,
		招式特效 = self.参战单位[id].招式特效,
		不可操作 = self.参战单位[id].不可操作,
    	武器染色方案=self.参战单位[id].武器染色方案 or nil,
    	武器染色组=self.参战单位[id].武器染色组 or nil,
    	门派=self.参战单位[id].门派,
    	法阵能量=self.法阵能量,
    	九黎组合技能 = self.参战单位[id].九黎组合技能,
		-- 奇经八脉 = self.参战单位[id].JM or {},
		锦衣 = self.参战单位[id].锦衣,
		战斗id = self.战斗id,
		奇袭特技 = self.参战单位[id].奇袭特技,
		奇袭三药 = self.参战单位[id].奇袭三药,
		奇袭法术 = self.参战单位[id].奇袭法术,
		是否助战 = self.参战单位[id].助战
	}
    if self.参战单位[id].门派 == "九黎城" then--九黎城
		if self.参战单位[id].黎魂 then
			临时数据.黎魂 = self.参战单位[id].黎魂
		end
		if self.参战单位[id].战鼓 then
			临时数据.战鼓 = self.参战单位[id].战鼓
		end
	end--九黎城
	if self.参战单位[id].类型 == "角色" then
		if self.参战单位[id].队伍 ~= 0 then
			local 玩家id = self.参战单位[id].玩家id
			if self.参战单位[id].装备[3] ~= nil and 玩家数据[玩家id] and 玩家数据[玩家id].角色.装备[3] then
				local 装备id = 玩家数据[玩家id].角色.装备[3]
				临时数据.武器 = {名称 = 玩家数据[玩家id].道具.数据[装备id].名称, 子类 = 玩家数据[玩家id].道具.数据[装备id].子类, 等级 = 玩家数据[玩家id].道具.数据[装备id].等级 or 玩家数据[玩家id].道具.数据[装备id].级别限制}
				if 玩家数据[玩家id].道具.数据[装备id].染色方案 and 玩家数据[玩家id].道具.数据[装备id].染色组 then
					临时数据.武器.染色方案=玩家数据[玩家id].道具.数据[装备id].染色方案
					临时数据.武器.染色组=玩家数据[玩家id].道具.数据[装备id].染色组
				end
				if 玩家数据[玩家id].道具.数据[装备id].武器专属 then
					self.参战单位[id].武器专属 = table.copy(玩家数据[玩家id].道具.数据[装备id].武器专属)
				end
			end
			if self.参战单位[id].装备 and self.参战单位[id].装备[5] ~= nil and self.参战单位[id].装备[5].临时附魔 and self.参战单位[id].装备[5].临时附魔.愤怒 and self.参战单位[id].装备[5].临时附魔.愤怒.数值 then
				self.参战单位[id].愤怒 = self.参战单位[id].愤怒 + self.参战单位[id].装备[5].临时附魔.愤怒.数值
				if self.参战单位[id].愤怒>=150 then
					self.参战单位[id].愤怒=150
				end
			end
			if 玩家数据[玩家id] and 玩家数据[玩家id].角色.系统设置 then----C改锦衣显示
				if not 玩家数据[玩家id].角色.系统设置.显示锦衣光环足迹 then
					临时数据.锦衣[1]=nil
				end
			end
			if self.参战单位[id].装备[4] ~= nil and self.参战单位[id].模型 == "影精灵" and 玩家数据[玩家id] ~= nil and 玩家数据[玩家id].角色 ~= nil and 玩家数据[玩家id].角色.装备 ~= nil and 玩家数据[玩家id].角色.装备[4] ~= nil and 玩家数据[玩家id].道具.数据[玩家数据[玩家id].角色.装备[4]].子类 == 911 then
				local 装备id = 玩家数据[玩家id].角色.装备[4]
				if 玩家数据[玩家id].道具.数据[装备id].耐久 <= 0 then
					临时数据.副武器 = nil
				else
					临时数据.副武器 = {
						光武拓印 = 玩家数据[玩家id].道具.数据[装备id].光武拓印,
						名称 = 玩家数据[玩家id].道具.数据[装备id].名称,
						子类 = 玩家数据[玩家id].道具.数据[装备id].子类,
						级别限制 = 玩家数据[玩家id].道具.数据[装备id].级别限制,
						染色方案 = 玩家数据[玩家id].道具.数据[装备id].染色方案,
						染色组 = 玩家数据[玩家id].道具.数据[装备id].染色组
					}
				end
			end
			if self.参战单位[id].披坚执锐~=nil and #self.参战单位[id].披坚执锐>2 then --进入战斗发送披坚执锐
				临时数据.披坚执锐=self.参战单位[id].披坚执锐
			end
			if self.参战单位[id].法宝佩戴 ~= nil and #self.参战单位[id].法宝佩戴>0 then
				临时数据.法宝 = true
			end
			if 玩家id ~= nil then
			    if 玩家数据[玩家id].角色 ~= nil then
			       if 玩家数据[玩家id].角色.门派 ~= nil then
			          临时数据.门派 = 玩家数据[玩家id].角色.门派
			          临时数据.等级 = 玩家数据[玩家id].角色.等级
			       end
			    end
			end
		end
	elseif self.参战单位[id].类型 == "bb" then

		if self.参战单位[id].分类 == "野怪" and self.参战单位[id].饰品显示 then
			临时数据.显示饰品 = true
			临时数据.饰品颜色 = self.参战单位[id].饰品颜色
		else

			if self.参战单位[id].饰品 ~= nil then
				临时数据.显示饰品 = true
				临时数据.饰品颜色 = self.参战单位[id].饰品颜色
			else
				临时数据.显示饰品 = false
			end
			if self.参战单位[id].技能 ~= nil then
				临时数据.技能 = #self.参战单位[id].技能
			end
		end
	elseif self.参战单位[id].类型 == "系统角色" then --给怪加角色是系统角色
		临时数据.武器 = self.参战单位[id].武器
		临时数据.锦衣 = self.参战单位[id].锦衣
	end

	return 临时数据
end

function 战斗处理类:增加秘境技能属性(编号, 名称,位置)
	if 名称=="佛光" then
		self.参战单位[编号].治疗能力=qz(self.参战单位[编号].治疗能力*1.5)
	elseif  名称=="天书" then
		self.参战单位[编号].抵抗封印等级=qz(self.参战单位[编号].抵抗封印等级*1.6)
	elseif  名称=="牢笼" then
		self.参战单位[编号].固定伤害=qz(self.参战单位[编号].固定伤害*2)
	elseif  名称=="惊雷" then
		self.参战单位[编号].法术伤害结果=qz(self.参战单位[编号].法术伤害结果*2)
	elseif  名称=="坚固" then
		-- print("坚固前防御："..self.参战单位[编号].防御)
		self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.3)
		-- print("坚固后防御："..self.参战单位[编号].防御)
	elseif  名称=="鹰展" then
		-- print("鹰展前速度："..self.参战单位[编号].速度)
		self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.3)
		-- print("鹰展后速度："..self.参战单位[编号].速度)
	elseif  名称=="符与" then
		self.参战单位[编号].封印命中等级=qz(self.参战单位[编号].封印命中等级*1.5)
	elseif  名称=="升华" then
		-- print("升华前伤害："..self.参战单位[编号].伤害)
		self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.15)
		-- print("升华后伤害："..self.参战单位[编号].伤害)
	elseif  名称=="月读" then
		self.参战单位[编号].法术伤害=qz(self.参战单位[编号].法术伤害*1.15)
	elseif  名称=="兵魂" then
		if 位置==1 then
		self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.3)
		end
	elseif  名称=="辗转" then
		if 位置==1 then
		self.参战单位[编号].法术伤害=qz(self.参战单位[编号].法术伤害*1.3)
		end
	elseif  名称=="业炎" then
		self.参战单位[编号].法术防御=qz(self.参战单位[编号].法术防御*1.3)
	elseif  名称=="疾走" then
		if 位置==1 then
		self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.5)
		end
	elseif  名称=="止战" then
		if 位置==1 then
		self.参战单位[编号].封印命中等级=qz(self.参战单位[编号].封印命中等级*2)
		end
	elseif  名称=="逆转" then
		if 位置==1 then
		self.参战单位[编号].治疗能力=qz(self.参战单位[编号].治疗能力*2)
		end
	elseif  名称=="刺杀" then
		if 位置==1 then
		self.参战单位[编号].固定伤害=qz(self.参战单位[编号].固定伤害*2)
		end
	elseif  名称=="龙怒" then
		self.参战单位[编号].法术暴击等级=qz(self.参战单位[编号].法术暴击等级*1.3)
	elseif  名称=="怒躯" then
		self.参战单位[编号].物理暴击等级=qz(self.参战单位[编号].物理暴击等级*1.3)
	elseif  名称=="割腕" then
		if 位置==1 then
		self.参战单位[编号].气血=qz(self.参战单位[编号].气血*0.8)
		self.参战单位[编号].最大气血=qz(self.参战单位[编号].最大气血*0.8)
		else
		self.参战单位[编号].气血=qz(self.参战单位[编号].气血*1.2)
		self.参战单位[编号].最大气血=qz(self.参战单位[编号].最大气血*1.2)
		end
	elseif  名称=="灵风" then
		if not self.参战单位[编号].法连 then self.参战单位[编号].法连=0 end
		self.参战单位[编号].法连=qz(self.参战单位[编号].法连+20)
	elseif  名称=="乾坤" then
		self.参战单位[编号].额外目标数=2
	elseif  名称=="异爆" then
		self.参战单位[编号].爆裂触发=true
	elseif  名称=="移法" then
		self.参战单位[编号].伤害=self.参战单位[编号].伤害+self.参战单位[编号].法术伤害
		self.参战单位[编号].法术伤害=1
	elseif  名称=="转物" then
		self.参战单位[编号].法术伤害=qz(self.参战单位[编号].法术伤害+self.参战单位[编号].伤害*0.5)
		self.参战单位[编号].伤害=1
	end
end

function 战斗处理类:取队伍一速(编号)
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].类型=="角色" and n~=编号 then
			if self.参战单位[n].速度>self.参战单位[编号].速度 then
				return false
			end
		end
	end
	return true
end
function 战斗处理类:取门派是否唯一(编号,门派)
	if self.参战单位[编号].门派 ~= 门派 then
		return false
	end
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and n~=编号 then
			if self.参战单位[n].门派==self.参战单位[编号].门派 then
				return false
			end
		end
	end
	return true
end

function 战斗处理类:取炼魂数量(编号)
	local num = 0
	local wj = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self.参战单位[n].类型=="角色" then
			for k,v in pairs(self.参战单位[n].法术状态) do
				if k=="练魂" then
					num=num+1
				end
			end
			wj = wj + 1
		end
	end
	return {数量=num ,玩家数量=wj}
end


function 战斗处理类:敌方指定状态数量(编号,名称)
	local num = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 then
			for k,v in pairs(self.参战单位[n].法术状态) do
				if k==名称 then
					num=num+1
				end
			end
		end
	end
	return num
end

function 战斗处理类:敌方点对点状态数量(编号,名称)
	local num = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 then
			for k,v in pairs(self.参战单位[n].法术状态) do
				if k==名称 and v.攻击编号==编号 then
					num=num+1
				end
			end
		end
	end
	return num
end

function 战斗处理类:取全场增益数量()
	local num = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].增益~=nil and self.参战单位[n].增益>0 then --有分类就是野怪分类 self.参战单位[编号].分类 == nil and
			num=num+1
		end
	end
	return num
end

function 战斗处理类:取全场护盾数量()
	local num = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].护盾>0 then
			num=num+1
		end
	end
	return num
end

function 战斗处理类:友方指定状态数量(编号,名称)
	local num = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == self.参战单位[编号].队伍 then
			for k,v in pairs(self.参战单位[n].法术状态) do
				if k==名称 then
					num=num+1
				end
			end
		end
	end
	return num
end

function 战斗处理类:取休息状态(单位)
	local jn={"横扫千军","披挂上阵","象形","连环击","鹰击","破釜沉舟","天命剑法","幸运一击"}
	for n = 1, #jn do
		if 单位.法术状态[jn[n]] ~= nil then
			return true
		end
	end
	return false
end

function 战斗处理类:取装备宝石等级(编号,部位)
	if self.参战单位[编号] and self.参战单位[编号].类型=="角色" then
		if 玩家数据[self.参战单位[编号].玩家id] then
			if 玩家数据[self.参战单位[编号].玩家id].角色.装备[部位]
				and 玩家数据[self.参战单位[编号].玩家id].道具.数据[玩家数据[self.参战单位[编号].玩家id].角色.装备[部位]]
				   and 玩家数据[self.参战单位[编号].玩家id].道具.数据[玩家数据[self.参战单位[编号].玩家id].角色.装备[部位]].锻炼等级 then
				return 玩家数据[self.参战单位[编号].玩家id].道具.数据[玩家数据[self.参战单位[编号].玩家id].角色.装备[部位]].锻炼等级 --这里他们不会打其他宝石吧
			end
		end
	end
	return 0
end

function 战斗处理类:取五行相生(五行)
  	local 相生="水"
  	if 五行=="金" then
	 	相生="水"
  	elseif 五行=="水" then
	 	相生="木"
  	elseif 五行=="木" then
	 	相生="水"
  	elseif 五行=="火" then
	 	相生="土"
  	elseif 五行=="土" then
	 	相生="金"
  	end
  	return 相生
end

function 战斗处理类:取五行相克(五行)
  	local 相克="木"
  	if 五行=="金" then
	 	相克="木"
  	elseif 五行=="木" then
	 	相克="土"
  	elseif 五行=="土" then
	 	相克="水"
  	elseif 五行=="水" then
	 	相克="火"
  	elseif 五行=="火" then
	 	相克="金"
  	end
  	return 相克
end

function 战斗处理类:取装备五行(编号,部位)
	if self.参战单位[编号] and self.参战单位[编号].类型=="角色" then
		if 玩家数据[self.参战单位[编号].玩家id] then
			if 玩家数据[self.参战单位[编号].玩家id].角色.装备[部位] and 玩家数据[self.参战单位[编号].玩家id].道具.数据[玩家数据[self.参战单位[编号].玩家id].角色.装备[部位]] then
				return  玩家数据[self.参战单位[编号].玩家id].道具.数据[玩家数据[self.参战单位[编号].玩家id].角色.装备[部位]].五行
			end
		end
	end
	return 0
end

function 战斗处理类:取友方阵亡人数(编号)
	local 数量=0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].类型=="角色" and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[编号].死亡~=nil then
			数量=数量+1
		end
	end
	return 数量
end


function 战斗处理类:取被动(编号,名称)
	if self.参战单位[编号] == nil or self.参战单位[编号].队伍 == 0 or self.参战单位[编号].类型 ~= "角色" then
		return false
	end
	if self.参战单位[编号].被动技能 ~= nil then
		for i=1,#self.参战单位[编号].被动技能 do
			if self.参战单位[编号].被动技能[i] ~= nil and self.参战单位[编号].被动技能[i].名称 == 名称 then
				return true
			end
		end
	end
	return false
end

function 战斗处理类:取经脉(编号,门派,名称)
	if self.参战单位[编号] == nil or self.参战单位[编号].队伍 == 0 or self.参战单位[编号].类型 ~= "角色"  then
		return false
	end
	if self.参战单位[编号].JM ~= nil and self.参战单位[编号].门派 == 门派 and self.参战单位[编号].JM[名称] ~= nil and self.参战单位[编号].JM[名称] ==1 then
		return true
	end
	return false
end

function 战斗处理类:直接取玩家经脉(id, 名称)
	if 玩家数据[id].角色.奇经八脉 ~= nil and 玩家数据[id].角色.奇经八脉[名称] ~= nil and 玩家数据[id].角色.奇经八脉[名称] >= 1 then
		return true
	end
	return false
end

function 战斗处理类:取全场状态(名称)
	for i = 1, #self.全场状态 do
		if self.全场状态[i].名称 == 名称 then
			return i
		end
	end
	return false
end

function 战斗处理类:加载奇经八脉(编号, id)
	if 玩家数据[id].角色.奇经八脉 ~= nil then
		self.参战单位[编号].JM = table.loadstring(table.tostring(玩家数据[id].角色.奇经八脉))
		for k,v in pairs(self.参战单位[编号].JM) do
			if v~=1 and k~="当前流派" then --and k~="当前流派"
			   self.参战单位[编号].JM[k] = nil
			end
		end
	end
end

function 战斗处理类:取法宝五行(编号, id)
	if self.参战单位[编号].类型 == "角色" and 玩家数据[id] then
		for n = 1, 4 do
			if 玩家数据[id].角色.法宝佩戴[n] ~= nil then
				if 取法宝门派(玩家数据[id].道具.数据[玩家数据[id].角色.法宝佩戴[n]].名称) == "无门派" or 取法宝门派(玩家数据[id].道具.数据[玩家数据[id].角色.法宝佩戴[n]].名称) ==  self.参战单位[编号].门派 then
					local 道具id = 玩家数据[id].角色.法宝佩戴[n]
					if 玩家数据[id].道具.数据[道具id] ~= nil then
						return 玩家数据[id].道具.数据[道具id].五行
					end
				end
			end
		end
	end
	return "空"
end


function 战斗处理类:加载法宝(编号, id)
	if self.参战单位[编号].类型 == "角色" then
		for n = 1, 4 do
			local 符合 = false
			if 玩家数据[id].角色.法宝佩戴[n] ~= nil then
				if 取法宝门派(玩家数据[id].道具.数据[玩家数据[id].角色.法宝佩戴[n]].名称) == "无门派" or 取法宝门派(玩家数据[id].道具.数据[玩家数据[id].角色.法宝佩戴[n]].名称) ==  self.参战单位[编号].门派 then
					local 道具id = 玩家数据[id].角色.法宝佩戴[n]
					if 玩家数据[id].道具.数据[道具id] ~= nil then
						local 名称 = 玩家数据[id].道具.数据[道具id].名称
						local 境界 = 玩家数据[id].道具.数据[道具id].气血
						local 灵气 = 玩家数据[id].道具.数据[道具id].魔法
						local 五行 = 玩家数据[id].道具.数据[道具id].五行
						local 附灵 = 玩家数据[id].道具.数据[道具id].附灵
						local 附灵等级 = 玩家数据[id].道具.数据[道具id].附灵等级

						if 名称 == "干将莫邪" then --佩戴即在进入战斗时自动生效，无需再手动使用
							self:添加状态("干将莫邪", self.参战单位[编号], self.参战单位[编号], 0, 境界)
							if self:取经脉(编号, "大唐官府", "破军") then
								self:添加状态("剑意", self.参战单位[编号], self.参战单位[编号])
								self.参战单位[编号].法术状态["剑意"].层数 = 50
							end
						end

						local 临时数据 = 取物品数据(名称)
						if 临时数据[5]+0 == 0 then --被动类法宝
							self.参战单位[编号].法宝佩戴[#self.参战单位[编号].法宝佩戴 + 1] = {附灵等级 = 附灵等级,附灵 = 附灵, 名称 = 名称, 境界 = 境界, 玩家id = id, 序列 = 玩家数据[id].角色.法宝佩戴[n],回合扣除=0}
							local 法宝序列 = #self.参战单位[编号].法宝佩戴
							if 名称 == "飞剑" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].命中 = self.参战单位[编号].命中 + qz(境界 * 5) + 7
							elseif 名称 == "拭剑石" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + (境界 * 3) + 3
								self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + qz(境界 * 1.5)
								self.参战单位[编号].固定伤害 = self.参战单位[编号].固定伤害 + qz(境界 * 3.5)
								if 五行=="水" then
									self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + 5
									self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + 2
									self.参战单位[编号].固定伤害 = self.参战单位[编号].固定伤害 + 4
								end
							elseif 名称 == "驭魔笼" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								    self.参战单位[编号].黎魂加成 = 境界 * 1 + 5
								    if self:取经脉(编号,self.参战单位[编号].门派, "驭魔") then
									self.参战单位[编号].黎魂加成 = self.参战单位[编号].黎魂加成 * 1.25
								end
								if 五行=="水" then
									self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + 5
									self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + 2
									self.参战单位[编号].固定伤害 = self.参战单位[编号].固定伤害 + 4
								end
							elseif 名称 == "附灵玉" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + (境界 * 2) + 6
								self.参战单位[编号].法防 = self.参战单位[编号].法防 + (境界 * 2) + 6
							elseif 名称 == "碧玉葫芦" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力 + (境界 * 取随机数(4,5))
								if 五行=="土" then
									self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力 + 5
								elseif 五行=="木" then
									self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力 - 5
								end
							elseif 名称 == "琉璃灯" and self:扣除法宝灵气(编号, 法宝序列, 1) then --80级 7.5的必杀
								self.参战单位[编号].物理暴击等级 = self.参战单位[编号].物理暴击等级 + (境界 *5)
							elseif 名称 == "宝烛" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].宝烛 = 境界*10 + 10
								if 五行=="土" then
									self.参战单位[编号].宝烛 = self.参战单位[编号].宝烛 + 10
								elseif 五行=="木" then
									self.参战单位[编号].宝烛 = self.参战单位[编号].宝烛 - 10
								end
							elseif 名称 == "金刚杵" then
								self.参战单位[编号].金刚杵=五行
							elseif 名称 == "慈悲" then
								self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力 + (境界 * 10) + 200
							elseif 名称 == "五火神焰印" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								if self.参战单位[编号].神焰==nil then
									self.参战单位[编号].神焰=0
								end
								if self:取经脉(编号,"魔王寨","神焰") then
									self.参战单位[编号].神焰 = 8
								end
								if self:取经脉(编号,"魔王寨","焰星") then
									if self:取装备五行(编号,3)=="火" then --武器
										self.参战单位[编号].神焰 = self.参战单位[编号].神焰 + 5
									end
									if self:取装备五行(编号,4)=="火" then --衣服
										self.参战单位[编号].神焰 = self.参战单位[编号].神焰 + 5
									end
								end
								self.参战单位[编号].神焰 = self.参战单位[编号].神焰 + (境界 / 3)
							elseif (名称 == "天师符" and self:扣除法宝灵气(编号, 法宝序列, 1)) or (名称 == "织女扇" and self:扣除法宝灵气(编号, 法宝序列, 1)) or (名称 == "雷兽" and self:扣除法宝灵气(编号, 法宝序列, 1))
								or (名称 == "迷魂灯" and self:扣除法宝灵气(编号, 法宝序列, 1)) or (名称 == "定风珠" and self:扣除法宝灵气(编号, 法宝序列, 1)) or (名称 == "幽灵珠" and self:扣除法宝灵气(编号, 法宝序列, 1))then
								local jc = 10
								if 境界==3 or 境界==4 then
									jc = 25
								elseif 境界==5 or 境界==6 then
									jc = 30
								elseif 境界==7 or 境界==8 then
									jc = 35
								elseif 境界>=9 then
									jc = 40
								end
								if 五行=="水" then
									self.参战单位[编号].抵抗封印等级 = self.参战单位[编号].抵抗封印等级 + jc + 10
								elseif 五行=="土" then
									self.参战单位[编号].抵抗封印等级 = self.参战单位[编号].抵抗封印等级 + jc - 10
								else
									self.参战单位[编号].抵抗封印等级 = self.参战单位[编号].抵抗封印等级 + jc
								end
							elseif 名称 == "七宝玲珑灯" then
								local qqc = self:取全场状态("七宝玲珑灯")
								if qqc == false then
									local lssj = {名称 = 名称, 队伍1 = {队伍 = self.参战单位[编号].队伍, 编号 = 编号, 境界 = 境界, 回合 = 0}, 队伍2 = {}, 回合 = 999}
									table.insert(self.全场状态, lssj)
								else
									if self.全场状态[qqc].队伍1.队伍 == self.参战单位[编号].队伍 then
										if self.全场状态[qqc].队伍1.境界 < 境界 then
											self.全场状态[qqc].队伍1.境界 = 境界
											self.全场状态[qqc].队伍1.编号 = 编号
										end
									else
										if self.全场状态[qqc].队伍2.队伍 ~= nil and self.全场状态[qqc].队伍2.队伍 == self.参战单位[编号].队伍 then
											if self.全场状态[qqc].队伍2.境界 < 境界 then
												self.全场状态[qqc].队伍2.境界 = 境界
												self.全场状态[qqc].队伍2.编号 = 编号
											end
										else
											self.全场状态[qqc].队伍2 = {队伍 = self.参战单位[编号].队伍, 编号 = 编号, 境界 = 境界, 回合 = 0}
										end
									end
								end
							elseif 名称 == "河图洛书" then
								self.参战单位[编号].封印命中等级 = self.参战单位[编号].封印命中等级 + (境界*4)+28  --10％满层最优五行的效果是8%封印和8%抗封。如果队伍中只有一个人佩戴，则效果会是12%封印和12%抗封，同时队伍中其他人的封印下降12%。而如果队伍中有两个以上的单位佩戴，则佩戴的人都可以获得8%封印和8%抗封(其余人的封
								if self.参战单位[编号].门派~="阴曹地府" then
									self.参战单位[编号].抵抗封印等级 = self.参战单位[编号].抵抗封印等级 + (境界*4)+28  --10％
								end
							elseif 名称 == "归元圣印" and self.参战单位[编号].门派~="阴曹地府" and self:扣除法宝灵气(编号, 法宝序列, 1) then --可同时佩戴慈悲，不可同时佩戴碧玉葫芦★佩戴归元圣印对地府门派加血量没有加成
								self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力 + (境界 * 取随机数(4,5))
								if 五行=="土" then
									self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力 + 5
								end
							elseif 名称 == "落星飞鸿" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + qz(境界 * 3.5) + 7 --70
								if 五行=="水" then
									self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + 5
								end
							elseif 名称 == "流影云笛" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + qz(境界 * 3) + 1 --55  笛子则是55左右 后期调整
								if 五行=="水" then
									self.参战单位[编号].法伤=self.参战单位[编号].法伤 + 3
								end
							elseif 名称 == "斩魔" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								if self:取经脉(编号,"凌波城","斩魔") then
									self.参战单位[编号].物理伤害结果 = self.参战单位[编号].物理伤害结果 + qz(境界 * 18*1.4)
								else
									self.参战单位[编号].物理伤害结果 = self.参战单位[编号].物理伤害结果 + qz(境界 * 18)
								end
							elseif 名称 == "月影" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								if self:取经脉(编号,"神木林","月影") then
									self.参战单位[编号].法连 = self.参战单位[编号].法连 + qz(境界) + 6
								else
									self.参战单位[编号].法连 = self.参战单位[编号].法连 + qz(境界)
								end
							elseif 名称 == "软烟罗锦" and self:扣除法宝灵气(编号, 法宝序列, 1) then
								self.参战单位[编号].软烟罗锦 = qz(境界 * 0.5)
								if 五行=="水" then
									self.参战单位[编号].软烟罗锦 = self.参战单位[编号].软烟罗锦 + 1
								end
							elseif (名称 == "北冥巨鳞" or 名称 == "血魄元幡" or 名称 == "翠碧玉箫" or 名称 == "冷龙石磐" or 名称 == "琉璃云罩") then
								local 队伍id=玩家数据[id].队伍
								if 队伍数据[队伍id]~=nil and #队伍数据[队伍id].成员数据==5 and self:扣除法宝灵气(编号, 法宝序列, 1) then
									local 伤害 = 0
									local 法伤 = 0
									local 抗封 = 0
									local 防御 = 0
									local 法防 = 0
									local 条件 = "伤害"
									if 名称 == "北冥巨鳞" then
										伤害 = qz(境界*1.7) --30
										条件 = "伤害"
									elseif 名称 == "血魄元幡" then
										法伤 = qz(境界*1.7)  --30
										条件 = "法伤"
									elseif 名称 == "翠碧玉箫" then
										抗封 = qz(境界 * 3) + 1 --55
										条件 = "速度"
									elseif 名称 == "冷龙石磐" then
										防御 = 境界 -- 18
										条件 = "防御"
									elseif 名称 == "琉璃云罩" then
										法防 = 境界 -- 18
										条件 = "法防"
									end
									for n = 1, #self.参战单位 do
										if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].类型 == "角色" then
											if n ~= 编号 then
												self.参战单位[n].伤害 = self.参战单位[n].伤害 + 伤害
												self.参战单位[n].防御 = self.参战单位[n].防御 + 防御
												self.参战单位[n].抵抗封印等级 = self.参战单位[n].抵抗封印等级 + 抗封
												self.参战单位[n].法伤 = self.参战单位[n].法伤 + 法伤
												self.参战单位[n].法防 = self.参战单位[n].法防 + 法防
											elseif n == 编号 and self:特殊法宝条件(编号,条件) then
												self.参战单位[n].伤害 = self.参战单位[n].伤害 + 伤害 + 70
												self.参战单位[n].防御 = self.参战单位[n].防御 + 防御 + 40
												self.参战单位[n].抵抗封印等级 = self.参战单位[n].抵抗封印等级 + 抗封 + 50
												self.参战单位[n].法伤 = self.参战单位[n].法伤 + 法伤 + 45
												self.参战单位[n].法防 = self.参战单位[n].法防 + 法防 + 40
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end



function 战斗处理类:特殊法宝条件(编号,条件)
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].类型=="角色" and n~=编号 and self.参战单位[编号].条件 and self.参战单位[n].条件 then
			if 条件=="伤害" or 条件=="法伤" then
				if self.参战单位[编号].条件>self.参战单位[n].条件+600 then
					return true
				end
			else
				if self.参战单位[编号].条件>self.参战单位[n].条件*1.3 then
					return true
				end
			end
		end
	end
	return false
end

function 战斗处理类:添加bb法宝属性(编号)
	local 主人 = self.参战单位[编号].主人序号
	for n = 1, #self.参战单位[主人].法宝佩戴 do
		local 名称 = self.参战单位[主人].法宝佩戴[n].名称
		local 境界 = self.参战单位[主人].法宝佩戴[n].境界
		if 名称 == "九黎战鼓" and self:扣除法宝灵气(主人, n, 1) then
			self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + (境界 * 3) + 3
		elseif 名称 == "盘龙壁" and self:扣除法宝灵气(主人, n, 1) then
			self.参战单位[编号].防御 = self.参战单位[编号].防御 + (境界 * 5) + 3
		elseif 名称 == "神行飞剑" and self:扣除法宝灵气(主人, n, 1) then
			self.参战单位[编号].速度 = qz(self.参战单位[编号].速度 + (境界 * 2.8))
		elseif 名称 == "汇灵盏" and self:扣除法宝灵气(主人, n, 1) then
			self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + (境界 * 3)
		elseif 名称 == "兽王令" and self:扣除法宝灵气(主人, n, 1) then
			self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + qz(境界+取随机数(6,12))
			self.参战单位[编号].防御 = self.参战单位[编号].防御 + qz(境界+取随机数(6,12))
			self.参战单位[编号].速度 = self.参战单位[编号].速度 + qz(境界+取随机数(6,12))
			self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + qz(境界+取随机数(6,12))
			self.参战单位[编号].法防 = self.参战单位[编号].法防 + qz(境界+取随机数(6,12))
		elseif 名称 == "重明战鼓" and self:扣除法宝灵气(主人, n, 1) then --
			if self.参战单位[主人].法宝佩戴[n].五行=="水" then
				self.参战单位[编号].伤害 = qz(self.参战单位[编号].伤害 * (1 + self.参战单位[编号].等级*0.0003))
				self.参战单位[编号].法伤 = qz(self.参战单位[编号].法伤 * (1 + self.参战单位[编号].等级*0.0003))
			end
			self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + (境界 * 4)
			self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + (境界 * 4)
		elseif 名称 == "梦云幻甲" and self:扣除法宝灵气(主人, n, 1) then
			if self.参战单位[主人].法宝佩戴[n].五行=="水" then
				self.参战单位[编号].防御 = qz(self.参战单位[编号].防御 * (1 + self.参战单位[编号].等级*0.0003))
				self.参战单位[编号].法防 = qz(self.参战单位[编号].法防 * (1 + self.参战单位[编号].等级*0.0003))
			end
			self.参战单位[编号].防御 = self.参战单位[编号].防御 + (境界 * 7)
			self.参战单位[编号].法防 = self.参战单位[编号].法防 + (境界 * 7)
		end
	end
end

function 战斗处理类:法宝是否有(编号,法宝)
	if self.参战单位[编号] and (self.参战单位[编号].法术状态.番天印 or self.参战单位[编号].法术状态.无字经 or self.参战单位[编号].法术状态.娉婷袅娜) then
		return false
	end
	if self.参战单位[编号].队伍~=0 and  self.参战单位[编号].法宝佩戴 and self.参战单位[编号].类型 == "角色" then
		local 是否有 = false
		local 是执行 = false
		for n = 1, #self.参战单位[编号].法宝佩戴 do
			if self.参战单位[编号].法宝佩戴[n].名称 == 法宝 and not 是否有 then --是否有，避免重复取值
				if 法宝 == "救命毫毛" then
					是执行 = true
				end
				if 是否有 and 是执行 then
					if self.PK战斗 then
						return true
					end
					if self:扣除法宝灵气(编号, n, 1) then
						return true
					else
						return false
					end
				end
			end
		end
	end
	return false
end
function 战斗处理类:取法宝附灵(编号,xxx)
	if not xxx or type(xxx) ~= "string" then return false end
	if self.参战单位[编号].法宝佩戴 and self.参战单位[编号].类型 == "角色" then
		for n = 1, #self.参战单位[编号].法宝佩戴 do
			if self.参战单位[编号].法宝佩戴[n].附灵 == xxx then
				local sss = tonumber(self.参战单位[编号].法宝佩戴[n].附灵等级) or 1
				return sss
			end
		end
	end
	return false
end

function 战斗处理类:取指定法宝(编号, 法宝 ,重复)
	if self.参战单位[编号] and (self.参战单位[编号].法术状态.番天印 or self.参战单位[编号].法术状态.无字经 or self.参战单位[编号].法术状态.娉婷袅娜) then
		return false
	end

	if self.参战单位[编号].队伍~=0 and  self.参战单位[编号].法宝佩戴 and self.参战单位[编号].类型 == "角色" then
		local 是否有 = false
		local 是执行 = false
		local num = 0
		for n = 1, #self.参战单位[编号].法宝佩戴 do
			if self.参战单位[编号].法宝佩戴[n].名称 == 法宝 then
				num = num + 1
			end
		end
		if num>=2 then
			num = 2
		end
		for n = 1, #self.参战单位[编号].法宝佩戴 do
			if self.参战单位[编号].法宝佩戴[n].名称 == 法宝 and not 是否有 then --是否有，避免重复取值
				是否有 = true
				if 法宝 == "金甲仙衣" then
					if 取随机数() < self.参战单位[编号].法宝佩戴[n].境界 * 2 * num + 9 then --2*9+9=27 --这里就判断是否成功了
						是执行 = true
					end
				elseif 法宝 == "降魔斗篷" then
					if 取随机数() < self.参战单位[编号].法宝佩戴[n].境界 * num + 13 then --2*12+6=25 num 是两件概率 37
						是执行 = true
					end
				elseif 法宝 == "嗜血幡" then
					local js = 1
					if 重复 then --打第三个人的时候
						js = 5
					end
					if 取随机数() < qz((self.参战单位[编号].法宝佩戴[n].境界 * 2 * num + 9)/js) - 4 then  --1个23两个41
						是执行 = true
					end
				elseif 法宝 == "七宝玲珑灯" then
					if 取随机数() < self.参战单位[编号].法宝佩戴[n].境界 * 2 + 9 then
						是执行 = true
					end
				elseif 法宝 == "蟠龙玉璧" then
					if 取随机数() < self.参战单位[编号].法宝佩戴[n].境界 * 1.5 + 3 then --30
						是执行 = true
					end
				elseif 法宝 == "慈悲" then
					if 取随机数() < self.参战单位[编号].法宝佩戴[n].境界 + 5 then
						是执行 = true
					end
				elseif 法宝 == "谷玄星盘" then
					if 取随机数() < self.参战单位[编号].法宝佩戴[n].境界*0.6 + 2 then
						是执行 = true
					end
				elseif 法宝 == "救命毫毛" then
					local gl = self.参战单位[编号].法宝佩戴[n].境界*2+3 --33的概率
					if self.参战单位[n].精炼~=nil then
						gl = gl + self.参战单位[n].精炼.回合*10
					end
					if self:取经脉(n, "方寸山", "不倦") then
						gl = gl +15
					elseif self:取经脉(n, "方寸山", "妙用") then
						gl = gl +15
					end
					if 取随机数() < gl then
						是执行 = true
					end
				else
					是执行 = true
				end
				if 是否有 and 是执行 then
					if self.PK战斗 then
						return true
					end
					if self:扣除法宝灵气(编号, n, 1) then
						return true
					else
						return false
					end
				end
			end
		end
	elseif self.参战单位[编号].队伍==0 and self.参战单位[编号].法宝佩戴 then
		local 是执行 = false
		for n = 1, #self.参战单位[编号].法宝佩戴 do
			if self.参战单位[编号].法宝佩戴[n].名称 == 法宝 then
				if 扣除 ~= nil then
					return true
				else
					if 法宝 == "金甲仙衣" then
						if 取随机数() < 9 * 2 + 9 then
							是执行 = true
						end
					elseif 法宝 == "降魔斗篷" then
						if 取随机数() < 9 * 2 + 9 then
							是执行 = true
						end
					elseif 法宝 == "七宝玲珑灯" then
						if 取随机数() < 9 * 2 + 9 then
							是执行 = true
						end
					elseif 法宝 == "慈悲" then
						if 取随机数() < 12 + 5 then
							是执行 = true
						end
					else
						是执行 = true
					end
					if 是执行 then
						return true
					end
				end
			end
		end
	end
	return false
end

function 战斗处理类:取指定法宝境界(编号, 法宝)
	for n = 1, #self.参战单位[编号].法宝佩戴 do
		if self.参战单位[编号].法宝佩戴[n].名称 == 法宝 then
			return self.参战单位[编号].法宝佩戴[n].境界
		end
	end
	return 0
end

function 战斗处理类:扣除法宝灵气(编号, 序列, 数额, 类型)
	if 正式 or 神话 then return true end
	local 扣除id = self.参战单位[编号].法宝佩戴[序列].序列
	local id = self.参战单位[编号].玩家id
	if not self.PK战斗 then
		if self.战斗类型 ~= 100001 and self.战斗类型 ~= 111111 and self.战斗类型 ~= 100007 then
			if 玩家数据[id].道具.数据[扣除id].魔法 < 数额 then
				return false
			else
				if self.回合数==0 or (self.参战单位[编号].法宝佩戴[序列].回合扣除 ~= self.回合数) then
					self.参战单位[编号].法宝佩戴[序列].回合扣除 = self.回合数
					玩家数据[id].道具.数据[扣除id].魔法 = 玩家数据[id].道具.数据[扣除id].魔法 - 数额
					发送数据(玩家数据[id].连接id, 38, {内容 = "你的法宝["..玩家数据[id].道具.数据[扣除id].名称.."]灵气减少了"..数额.."点"})
				end
				return true
			end
		end
	end
	return true
end

function 战斗处理类:增加法宝灵气(编号)
	local id = self.参战单位[编号].玩家id
	if 玩家数据[id] and 玩家数据[id].角色 then
		for n = 1, #self.参战单位[编号].法宝佩戴 do
			if self.参战单位[编号].法宝佩戴[n].名称 then --是否有，避免重复取值
				local fb = self.参战单位[编号].法宝佩戴[n].序列
				if 玩家数据[id].道具.数据[fb].魔法 < 取灵气上限(玩家数据[id].道具.数据[fb].分类) then
					玩家数据[id].道具.数据[fb].魔法 = 玩家数据[id].道具.数据[fb].魔法 + 1
					发送数据(玩家数据[id].连接id, 38, {内容 = "你的法宝["..玩家数据[id].道具.数据[fb].名称.."]灵气增加了1点"})
				else
					发送数据(玩家数据[id].连接id, 38, {内容 = "你的法宝["..玩家数据[id].道具.数据[fb].名称.."]灵气已经满了，无法再获得灵气"})
				end
			end
		end
	end
end


function 战斗处理类:加载灵宝(编号, id)
	if self.参战单位[编号].类型 == "角色" then
		for n = 1, 2 do
			if 玩家数据[id].角色.灵宝佩戴[n] ~= nil then
				local 道具id = 玩家数据[id].角色.灵宝佩戴[n]
				if 玩家数据[id].道具.数据[道具id] ~= nil then
					self.参战单位[编号].灵宝佩戴[#self.参战单位[编号].灵宝佩戴 + 1] = {名称 = 玩家数据[id].道具.数据[道具id].名称, 境界 = 玩家数据[id].道具.数据[道具id].气血,灵气 = 玩家数据[id].道具.数据[道具id].魔法, 玩家id = id, 序列 = 玩家数据[id].角色.法宝佩戴[n]}
				end
			end
		end
	end
end

function 战斗处理类:加载神器(编号, id)
	if 玩家数据[id].神器.数据.是否佩戴神器 then
		self.参战单位[编号].shenqi=玩家数据[id].神器.数据.神器技能
		if self.参战单位[编号].shenqi.name=="狂战" then
			self.全场属性[self.参战单位[编号].队伍].狂战=编号
		end
	end
end

function 战斗处理类:加载装备特效(编号,sj)
	if sj["愤怒"] then
		self.参战单位[编号].特效愤怒 = 0.8
	end
	if sj["暴怒"] then
		self.参战单位[编号].特效暴怒 = true
	end
	if sj["神佑"] then
		self.参战单位[编号].神佑 = 20
	end
	if sj["必中"] then
		self.参战单位[编号].必中 = true
	end
	if sj["神农"] then
		self.参战单位[编号].神农 = 1.1
	end
	if sj["绝杀"] then
		self.参战单位[编号].绝杀 = self.参战单位[编号].等级*20
	end
	if sj["再生"] then
		self.参战单位[编号].再生 = qz(self.参战单位[编号].等级/3)
	end
end

function 战斗处理类:取灵饰属性(编号,玩家id)
	--  穿刺计算公式为：穿刺等级/人物等级/30，即129级每一穿刺等级=0.0258%。
	-- 实战中攻击2000防的辅助可以忽略0.52点防御，而攻击1500防的输出忽略0.39点 防御。若已破防，则可变相认为分别增加了0.52点伤害和0.39点伤害。
	-- 狂暴等级官方的解释为：将自身防御的一部分转为伤害力。
	-- 狂暴计算公式为：狂暴等级/人物等级/30，即129级每一狂暴等级=0.0258%。
	-- 实战中若耐攻输出2000防，则增加0.52点伤害，而五力输出1500防，则增加0.39 点伤害。
	if 玩家数据[玩家id] and 玩家数据[玩家id].角色 then
		for i = 1, #灵饰战斗属性 do
			self.参战单位[编号][灵饰战斗属性[i]] = 玩家数据[玩家id].角色[灵饰战斗属性[i]]
			if 灵饰战斗属性[i] == "穿刺等级" or 灵饰战斗属性[i] =="狂暴等级" then
				self.参战单位[编号][灵饰战斗属性[i]] = string.format("%.3f", (self.参战单位[编号][灵饰战斗属性[i]]/玩家数据[玩家id].角色.等级/30))
			end
		end
	end
end

function 战斗处理类:计算160属性(编号,特效,数值)
	if 特效 == "物理暴击几率" then
		self.参战单位[编号].必杀 = self.参战单位[编号].必杀+数值
	elseif 特效 == "法术暴击几率" then
		self.参战单位[编号].法暴 = self.参战单位[编号].法暴+数值
	elseif 特效 == "格挡物理伤害" then
		if not self.参战单位[编号].格挡物理伤害 then
			self.参战单位[编号].格挡物理伤害 = 0
		end
		self.参战单位[编号].格挡物理伤害 = self.参战单位[编号].格挡物理伤害+数值
	elseif 特效 == "魔法回复效果" then
		if not self.参战单位[编号].魔法回复效果 then
			self.参战单位[编号].魔法回复效果 = 0
		end
		self.参战单位[编号].魔法回复效果 = self.参战单位[编号].魔法回复效果+数值
	elseif 特效 == "治疗能力" then
		self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力+数值
	elseif 特效 == "穿刺效果" then
		self.参战单位[编号].穿刺等级 = self.参战单位[编号].穿刺等级+数值
	elseif 特效 == "封印命中率" then
		if not self.参战单位[编号].FYMZ then
			self.参战单位[编号].FYMZ = 0
		end
		self.参战单位[编号].FYMZ = self.参战单位[编号].FYMZ+数值
	elseif 特效 == "抵抗封印命中率" then
		if not self.参战单位[编号].DKFY then
			self.参战单位[编号].DKFY = 0
		end
		self.参战单位[编号].DKFY = self.参战单位[编号].DKFY+数值
	elseif 特效 == "法术伤害减免" then
		if not self.参战单位[编号].法术伤害减免 then
			self.参战单位[编号].法术伤害减免 = 0
		end
		self.参战单位[编号].法术伤害减免 = self.参战单位[编号].法术伤害减免 + 数值*0.01
	elseif 特效 == "物理暴击伤害" then
		if not self.参战单位[编号].物理暴击伤害 then
			self.参战单位[编号].物理暴击伤害 = 0
		end
		self.参战单位[编号].物理暴击伤害 = self.参战单位[编号].物理暴击伤害 + 数值
	elseif 特效 == "法术暴击伤害" then
		if not self.参战单位[编号].法术暴击伤害 then
			self.参战单位[编号].法术暴击伤害 = 0
		end
		self.参战单位[编号].法术暴击伤害 = self.参战单位[编号].法术暴击伤害 + 数值
	end
end

function 战斗处理类:取符石组合效果(编号,名称)
	if type(编号)=="table" then
		if 编号.符石技能效果==nil and 编号.符石技能效果[名称]==nil then
			return false
		end
		return 编号.符石技能效果[名称]
	else
		if self.参战单位[编号].符石技能效果==nil and self.参战单位[编号].符石技能效果[名称]==nil then
			return false
		end
		return self.参战单位[编号].符石技能效果[名称]
	end
end

function 战斗处理类:初始化单位属性(bh)
	self.参战单位[bh].序号 = bh
	if self.参战单位[bh].符石技能效果==nil then
		self.参战单位[bh].符石技能效果={}
	end
	self.参战单位[bh].法术状态 = {}
	self.参战单位[bh].JM = {}
	-- self.参战单位[bh].符石技能 = {}
	self.参战单位[bh].追加法术 = {}
	self.参战单位[bh].披坚执锐 = {}
	-- self.参战单位[bh].如意神通 = {}
	self.参战单位[bh].附加状态  = {}
	self.参战单位[bh].shenqi = {name=false,lv=0}
	self.参战单位[bh].法宝佩戴 = {}
	self.参战单位[bh].特技技能 = {}
	if self.参战单位[bh].被动技能 == nil then
		self.参战单位[bh].被动技能 = {}
	end
	if self.参战单位[bh].招式特效 == nil then
		self.参战单位[bh].招式特效 = {}
	end
	if self.参战单位[bh].主动技能 == nil then
		self.参战单位[bh].主动技能 = {}
	end
	self.参战单位[bh].套装追加概率 = 0
	self.参战单位[bh].战意 = 0
	self.参战单位[bh].超级战意 = 0
	self.参战单位[bh].五行珠 = 0
	self.参战单位[bh].人参果 = {枚=0,回合=4}
	self.参战单位[bh].骤雨 = {层数=0,回合=3}
	self.参战单位[bh].法暴 = 0
	self.参战单位[bh].必杀 = 5
	self.参战单位[bh].超级必杀=0
	self.参战单位[bh].超级夜战 = 0
	self.参战单位[bh].首次被伤 = {物理=0,法术=0,每回物理=0,每回法术=0}
	self.参战单位[bh].超级偷袭 = false
	self.参战单位[bh].超级敏捷 = {概率=0,触发=0,执行=false,指令={}}
	self.参战单位[bh].连击 = 0
	self.参战单位[bh].法连 = 0
	self.参战单位[bh].夜战 = 0
	self.参战单位[bh].护盾 = 0
	self.参战单位[bh].攻击修炼 = 0
	self.参战单位[bh].法术修炼 = 0
	self.参战单位[bh].防御修炼 = 0
	self.参战单位[bh].抗法修炼 = 0
	self.参战单位[bh].猎术修炼 = 0
	self.参战单位[bh].附加必杀 = 0
	self.参战单位[bh].装备伤害 = 0
	self.参战单位[bh].装备敏捷 = 0
	self.参战单位[bh].武器命中 = 0
	self.参战单位[bh].耐久计算 = {攻击=0,施法=0,挨打=0}
	self.参战单位[bh].追加概率 = 0
	self.参战单位[bh].附加必杀伤害 = 0
	self.参战单位[bh].显示饰品 = false
	self.参战单位[bh].无心插柳 = false
	self.参战单位[bh].攻击五行 = "无"
	self.参战单位[bh].防御五行 = 五行_[取随机数(1,5)]
	self.参战单位[bh].法伤 = self.参战单位[bh].法伤 or 0
	self.参战单位[bh].法防 = self.参战单位[bh].法防 or 0
	self.参战单位[bh].死亡击飞 = false
	self.参战单位[bh].灵元 = {数值=0,回合=5}
	if self.参战单位[bh].命中 == nil then self.参战单位[bh].命中 = self.参战单位[bh].力量*2 end
	if self.参战单位[bh].躲避 == nil then self.参战单位[bh].躲避 = self.参战单位[bh].速度 end
	if self.参战单位[bh].法宝佩戴原~= nil then
		self.参战单位[bh].法宝佩戴 = self.参战单位[bh].法宝佩戴原
	end
	for i = 1, #灵饰战斗属性 do
		if self.参战单位[bh][灵饰战斗属性[i]] == nil then
			self.参战单位[bh][灵饰战斗属性[i]] = 0
		end
	end

	if self.参战单位[bh].类型 == "角色" then
		local 玩家id = self.参战单位[bh].玩家id
		if 玩家id~=0 and 玩家数据[玩家id]~=nil then
			local x奇袭数据 = 玩家数据[玩家id].道具:取战斗奇袭数据(玩家id)
			if x奇袭数据 then
				-- print("======== 奇袭数据检查 ========")
				-- print("特技数据：",x奇袭数据.特技)
				-- print("三药数据：",x奇袭数据.三药)
				self.参战单位[bh].奇袭特技 = x奇袭数据.特技
				self.参战单位[bh].奇袭三药 = x奇袭数据.三药
				self.参战单位[bh].奇袭法术概率 = x奇袭数据.奇袭法术 or 0
				self.参战单位[bh].奇袭法术 = nil
				-- print(self.参战单位[bh].奇袭法术概率,self.参战单位[bh].名称,"===========奇袭法术概率",玩家id)
				if 取随机数(1,100) <= self.参战单位[bh].奇袭法术概率 then
					self.参战单位[bh].奇袭法术 = true
				end
			end
			--=====================
			if not self.参战单位[bh].格挡物理伤害 then
				self.参战单位[bh].格挡物理伤害 = 0
			end
			self.参战单位[bh].格挡物理伤害 = self.参战单位[bh].格挡物理伤害 + x奇袭数据.物伤化劲
			self.参战单位[bh].法伤化劲 = x奇袭数据.法伤化劲
			self.参战单位[bh].固伤化劲 = x奇袭数据.固伤化劲
			self.参战单位[bh].坚如磐石 = x奇袭数据.坚如磐石
		end
	end

end
function 战斗处理类:刷新自动信息(玩家id,类型)
    for n=1,#self.参战单位 do
        if self.参战单位[n].玩家id==玩家id and self.参战单位[n].类型 == 类型 then
            if self.参战单位[n].类型=="角色" then
                if 玩家数据[玩家id].角色.自动指令~=nil then
                    self.参战单位[n].自动指令=table.loadstring(table.tostring(玩家数据[玩家id].角色.自动指令))
                else
                    self.参战单位[n].自动指令={
                        参数 = "",
                        类型 = "攻击"
                    }
                end
            elseif self.参战单位[n].类型=="bb" then
                local 编号 =  玩家数据[玩家id].召唤兽:取编号(玩家数据[玩家id].角色.参战宝宝.认证码)
                if 玩家数据[玩家id].召唤兽.数据[编号].自动指令 ~= nil and 玩家数据[玩家id].召唤兽.数据[编号].自动指令.类型 == "法术" and 取指定召唤兽技能(玩家数据[玩家id].召唤兽.数据[编号].技能,玩家数据[玩家id].召唤兽.数据[编号].自动指令.参数) == false then
                    玩家数据[玩家id].召唤兽.数据[编号].自动指令 = nil
                end
                if 编号 == 0 or 玩家数据[玩家id].召唤兽.数据[编号].自动指令 == nil then
                    self.参战单位[n].自动指令={
                        参数 = "",
                        类型 = "攻击"
                    }
                else
                    self.参战单位[n].自动指令=table.loadstring(table.tostring(玩家数据[玩家id].召唤兽.数据[编号].自动指令))
                end
            end
        end
    end
end
-- function 战斗处理类:刷新自动信息(玩家id,类型)
-- 	for n=1,#self.参战单位 do
-- 		if self.参战单位[n].玩家id==玩家id and self.参战单位[n].类型 == 类型 then
-- 			if self.参战单位[n].类型=="角色" then
-- 				if 玩家数据[玩家id].角色.自动指令~=nil then
-- 					-- if  玩家数据[玩家id].角色.自动指令.参数 and type(玩家数据[玩家id].角色.自动指令.参数)=="table" then
-- 					-- 玩家数据[玩家id].角色.自动指令.参数=玩家数据[玩家id].角色.自动指令.参数[1][1]
-- 				 --    end
-- 					self.参战单位[n].自动指令=table.loadstring(table.tostring(玩家数据[玩家id].角色.自动指令))
-- 					-- self.参战单位[n].指令=table.loadstring(table.tostring(玩家数据[玩家id].角色.自动指令))---C改
-- 				else
-- 					self.参战单位[n].自动指令={}
-- 					self.参战单位[n].自动指令.参数=""
-- 					self.参战单位[n].自动指令.类型="攻击"
-- 					self.参战单位[n].指令={}
-- 					self.参战单位[n].指令.类型="攻击"
-- 					self.参战单位[n].指令.目标= self:取单个敌方目标(n,"物理")
-- 				end
-- 			elseif self.参战单位[n].类型=="bb" then
-- 				local 编号 =  玩家数据[玩家id].召唤兽:取编号(玩家数据[玩家id].角色.参战宝宝.认证码)
-- 				if 玩家数据[玩家id].召唤兽.数据[编号].自动指令 ~= nil and 玩家数据[玩家id].召唤兽.数据[编号].自动指令.类型 == "法术" and 取指定召唤兽技能(玩家数据[玩家id].召唤兽.数据[编号].技能,玩家数据[玩家id].召唤兽.数据[编号].自动指令.参数) == false then
-- 					玩家数据[玩家id].召唤兽.数据[编号].自动指令 = nil
-- 				end
-- 				if 编号 == 0 or 玩家数据[玩家id].召唤兽.数据[编号].自动指令 == nil then
-- 					self.参战单位[n].自动指令={}
-- 					self.参战单位[n].自动指令.参数=""
-- 					self.参战单位[n].自动指令.类型="攻击"
-- 					self.参战单位[n].指令={}
-- 					self.参战单位[n].指令.类型="攻击"
-- 					self.参战单位[n].指令.目标= self:取单个敌方目标(n,"物理")
-- 				else
-- 					-- if  self.参战单位[n].自动指令.参数 and type(self.参战单位[n].自动指令.参数)=="table" then
-- 					-- self.参战单位[n].自动指令.参数=self.参战单位[n].自动指令.参数[1][1]
-- 				 --    end
-- 					self.参战单位[n].自动指令=table.loadstring(table.tostring(玩家数据[玩家id].召唤兽.数据[编号].自动指令))
-- 					-- self.参战单位[n].指令=table.loadstring(table.tostring(玩家数据[玩家id].召唤兽.数据[编号].自动指令))---C改
-- 				end
-- 			end
-- 		end
-- 	end
-- end

function 战斗处理类:重置单位属性()
	self.战斗流程 = {}
	for n = 1, #self.参战单位 do
		self:初始化单位属性(n)
		if self.参战单位[n].队伍 ~= 0 and self.参战单位[n].类型 ~= "系统角色" then--and self.参战单位[n].系统队友 == nil then
			if self.参战单位[n].玩家id~=nil and self.参战单位[n].类型=="角色"and  not self.PK战斗 and self.参战单位[n].本命法宝 and self.参战单位[n].本命法宝.开启 and self.参战单位[n].本命法宝.耐久>0 then
				if  self.参战单位[n].本命法宝.名称=="沁香花藤" and self.参战单位[n].门派=="女儿村" and  取随机数(1,100) < self.参战单位[n].本命法宝.等级   then
				self.参战单位[n].速度=self.参战单位[n].速度+1000
				end
			elseif self.参战单位[n].玩家id~=nil and self.参战单位[n].类型=="角色"and  self.参战单位[n].本命法宝~=nil and self.参战单位[n].本命法宝.开启  and self.参战单位[n].本命法宝.耐久<=0 then
	           			self.战斗发言数据[#self.战斗发言数据+1]={id=n,内容="#G/此角色#Y/本命法宝#G/耐久度不足，请及时补充！！！"}

			end




			if self.参战单位[n].玩家id~=nil  and not self.PK战斗  and self.参战单位[n].类型=="角色"and  not self.PK战斗 and self.参战单位[n].兽魂 and self.参战单位[n].兽魂.组合~="无" then
				if self.参战单位[n].兽魂.组合 == "陆地王者" then
					self.参战单位[n].伤害=qz(self.参战单位[n].伤害*1.1)
				elseif  self.参战单位[n].兽魂.组合 == "远古蛮妖" then
					self.参战单位[n].法伤=qz(self.参战单位[n].法伤*1.1)
				elseif  self.参战单位[n].兽魂.组合 == "鲲鹏之躯" then
					self.参战单位[n].防御=qz(self.参战单位[n].防御*1.1)
				elseif  self.参战单位[n].兽魂.组合 == "灵狐之附" then
					self.参战单位[n].速度=qz(self.参战单位[n].速度*1.1)
				elseif  self.参战单位[n].兽魂.组合 == "雷云之雀" then
					self.参战单位[n].最大气血=qz(self.参战单位[n].最大气血*1.1)
					self.参战单位[n].气血=qz(self.参战单位[n].气血*1.1)
				end
			end



			if self.参战单位[n].类型 == "角色" then
				self.参战单位[n].攻击修炼 = 玩家数据[self.参战单位[n].玩家id].角色.修炼.攻击修炼[1]
				self.参战单位[n].法术修炼 = 玩家数据[self.参战单位[n].玩家id].角色.修炼.法术修炼[1]
				self.参战单位[n].防御修炼 = 玩家数据[self.参战单位[n].玩家id].角色.修炼.防御修炼[1]
				self.参战单位[n].抗法修炼 = 玩家数据[self.参战单位[n].玩家id].角色.修炼.抗法修炼[1]
				self.参战单位[n].猎术修炼 = 玩家数据[self.参战单位[n].玩家id].角色.修炼.猎术修炼[1]
				self.参战单位[n].暗器 = qz(玩家数据[self.参战单位[n].玩家id].角色:取生活技能等级("暗器技巧")*玩家数据[self.参战单位[n].玩家id].角色:取生活技能等级("暗器技巧")/150+玩家数据[self.参战单位[n].玩家id].角色:取生活技能等级("暗器技巧"))

				local 特技 = 玩家数据[self.参战单位[n].玩家id].角色:取特技()
				for i = 1, #特技 do
					self.参战单位[n].特技技能[i] = {名称 = 特技[i], 等级 = 10}
				end
				self:加载装备特效(n,玩家数据[self.参战单位[n].玩家id].角色:取特效())
				self:取灵饰属性(n,self.参战单位[n].玩家id)
				for i = 1, #玩家数据[self.参战单位[n].玩家id].角色.剧情技能 do
					if 玩家数据[self.参战单位[n].玩家id].角色.剧情技能[i].名称 == "妙手空空" then
						if self.战斗类型 == 100001 or self.战斗类型 == 100007 then
							self.参战单位[n].主动技能[#self.参战单位[n].主动技能 + 1] = {名称 = 玩家数据[self.参战单位[n].玩家id].角色.剧情技能[i].名称, 等级 = 玩家数据[self.参战单位[n].玩家id].角色.剧情技能[i].等级}
							break
						end
					end
				end

				if 玩家数据[self.参战单位[n].玩家id].角色.门派 ~= nil then
					for i = 1, #玩家数据[self.参战单位[n].玩家id].角色.师门技能 do
						local fslv=self.参战单位[n].额外技能等级[self.参战单位[n].师门技能[i].名称] or 0
						if self.参战单位[n].额外法宝等级[self.参战单位[n].师门技能[i].名称]==nil then
							self.参战单位[n].额外法宝等级[self.参战单位[n].师门技能[i].名称]=0
						end
						local lv = self.参战单位[n].师门技能[i].等级 + fslv +  self.参战单位[n].额外法宝等级[self.参战单位[n].师门技能[i].名称]
						for s = 1, #玩家数据[self.参战单位[n].玩家id].角色.师门技能[i].包含技能 do
							self.参战单位[n].师门技能[i]={名称=self.参战单位[n].师门技能[i],等级=lv}
							if 玩家数据[self.参战单位[n].玩家id].角色.师门技能[i].包含技能[s].学会 then
								local 名称 = 玩家数据[self.参战单位[n].玩家id].角色.师门技能[i].包含技能[s].名称
								if self:被动技能(名称) then
									self.参战单位[n].被动技能[#self.参战单位[n].被动技能 + 1] = {名称 = 名称}
								end
								if skill主动技能[名称] then
									self.参战单位[n].主动技能[#self.参战单位[n].主动技能 + 1] = {名称 = 名称, 等级 =lv}
								end
								if 名称 == '黎魂' then
									    self.参战单位[n].黎魂 = 2
								elseif 名称 == "战鼓" then
									self.参战单位[n].战鼓 = 1
								end
							end
						end
					end
					if 玩家数据[self.参战单位[n].玩家id].角色.门派  == "无门派" and 玩家数据[self.参战单位[n].玩家id].角色.等级<10 then
						self.参战单位[n].主动技能[#self.参战单位[n].主动技能 + 1] = {名称 = "牛刀小试", 等级 = 玩家数据[self.参战单位[n].玩家id].角色.等级}
					end
					self:加载奇经八脉(n, self.参战单位[n].玩家id)
				end
				self:检查套装效果(n, self.参战单位[n].玩家id)

				self.参战单位[n].变身数据 = 玩家数据[self.参战单位[n].玩家id].角色.变身数据
				if self.参战单位[n].变身数据 ~= nil and 变身卡数据[self.参战单位[n].变身数据] ~= nil and 变身卡数据[self.参战单位[n].变身数据].技能 ~= "" then
					self:加载变身卡属性(self.参战单位[n], {变身卡数据[self.参战单位[n].变身数据].技能})
				end

				self:加载法宝(n, self.参战单位[n].玩家id)
				self:加载灵宝(n, self.参战单位[n].玩家id)
				self:加载神器(n, self.参战单位[n].玩家id)

				self:添加奇经八脉属性(n, self.参战单位[n].门派)
				if self.参战单位[n].黎魂 then
				            if 取随机数(1, 1000) <= (15 + (self.参战单位[n].黎魂加成 or 0)) * 10 then
						self.参战单位[n].黎魂 = self.参战单位[n].黎魂 + 1
					end
				end
				-- if self.参战单位[n].奇袭法术 then
				-- 	self:添加状态("奇袭术", self.参战单位[n],self.参战单位[n])
				-- end

				-- local user = 玩家数据[self.参战单位[n].玩家id]
				-- if user.角色.灵饰[1] and user.角色.灵饰[1] ~= 0 then
				-- 	if user.道具.数据[user.角色.灵饰[1]] and user.道具.数据[user.角色.灵饰[1]].特性 and user.道具.数据[user.角色.灵饰[1]].特性.套装 then
				-- 	  	if user.道具.数据[user.角色.灵饰[1]].特性.技能 == "心源" and math.random(100) <= 90 then
				-- 		    self.参战单位[n].伤害 = math.floor(self.参战单位[n].伤害 *(PropertyData[user.道具.数据[user.角色.灵饰[1]].特性.技能]["套装" .. user.道具.数据[user.角色.灵饰[1]].特性.套装] / 100 + 1))
				-- 		    self.参战单位[n].灵力 = math.floor(self.参战单位[n].灵力 *(PropertyData[user.道具.数据[user.角色.灵饰[1]].特性.技能]["套装" .. user.道具.数据[user.角色.灵饰[1]].特性.套装] / 100 + 1))
				-- 	  	end
				-- 	end
				-- end
			elseif self.参战单位[n].类型 == "bb" then
				if self.参战单位[n].装备 ~= nil then --召唤兽套装 要检查
					self:检查bb套装(self.参战单位[n])
				end
				self:刷新丸子技能(n)
				self:添加技能属性(self.参战单位[n], self.参战单位[n].技能)
				if self.参战单位[n].内丹 ~= nil and self.参战单位[n].内丹.格子 and #self.参战单位[n].内丹.格子 > 0 then
					self:添加内丹属性(self.参战单位[n])
				end
				if self.参战单位[n].进阶 ~= nil and self.参战单位[n].进阶.开启 and self.参战单位[n].进阶.特性 ~= "无" then
					self:添加特性属性(n, self.参战单位[n].进阶)
				end
				self.参战单位[n].攻击修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.攻击控制力[1]
				self.参战单位[n].法术修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.法术控制力[1]
				self.参战单位[n].防御修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.防御控制力[1]
				self.参战单位[n].抗法修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.抗法控制力[1]
				self:添加召唤兽属性(self.参战单位[n])
				self:添加bb法宝属性(n)
				if self.参战单位[n].统御属性 then
					if self.参战单位[n].统御属性.飞火流星  then
						self.参战单位[n].速度=qz(self.参战单位[n].速度-self.参战单位[n].统御属性.飞火流星)
					end
					if self.参战单位[n].统御属性.开天辟地  then
						self.参战单位[n].伤害=qz(self.参战单位[n].伤害+self.参战单位[n].统御属性.开天辟地)
					end
					if self.参战单位[n].统御属性.破釜沉州  then
						self.参战单位[n].必杀=self.参战单位[n].必杀+self.参战单位[n].统御属性.破釜沉州
						self.参战单位[n].命中=self.参战单位[n].命中+50
					end
				end
			end
		end
		------------怪
		if self.参战单位[n].队伍 == 0 or (self.参战单位[n].队伍 ~= 0 and self.参战单位[n].类型 == "系统角色") then
			self:添加技能属性(self.参战单位[n], self.参战单位[n].技能)
			if self.参战单位[n].前缀 or self.参战单位[n].后缀 then
					self:地宫怪物属性(self.参战单位[n])
			end
			if not self.参战单位[n].修炼 then
				self.参战单位[n].攻击修炼 = 0
				self.参战单位[n].法术修炼 = 0
				self.参战单位[n].防御修炼 = 0
				self.参战单位[n].抗法修炼 = 0
			else
				self.参战单位[n].攻击修炼 = self.参战单位[n].修炼.攻修 or 0
				self.参战单位[n].法术修炼 = self.参战单位[n].修炼.攻修 or 0
				self.参战单位[n].防御修炼 = self.参战单位[n].修炼.物抗 or 0
				self.参战单位[n].抗法修炼 = self.参战单位[n].修炼.法抗 or 0
			end

			if self.参战单位[n].门派~=nil and self.参战单位[n].门派=="凌波城" then
				self.参战单位[n].战意=999--3--这里凌波城的怪 开局9999战意
				self.参战单位[n].愤怒=99999
			else
				self.参战单位[n].愤怒=99999--这里修复怪物攻击失败--C改
				self.参战单位[n].魔法=99999--这里修复怪物攻击失败
			end
		end
		------------怪
	end
	--加载完毕
	for n=1,#self.参战单位 do
	-------------------------------------------------------加载锦衣技能
		if self.参战单位[n].玩家id~=nil and self.参战单位[n].类型=="角色"and self.参战单位[n].锦衣进阶~=nil and self.参战单位[n].锦衣进阶.开启==true then
			if 取随机数(1,100) < 100 +qz(self.参战单位[n].锦衣进阶.等级/15) then
			self:添加锦衣技能属性(n,self.参战单位[n].锦衣进阶.技能)
			self:添加状态(self.参战单位[n].锦衣进阶.技能, self.参战单位[n],self.参战单位[n])
			end
		end

	end
		-------------------------------------------------------加载门派秘籍

	self.战斗流程[#self.战斗流程+1]={流程=953,攻击方=0,挨打方={}}  --,攻击方=n,挨打方={{挨打方=n,增加状态="变身"}}---C改  战斗延迟问题
	for n=1,#self.参战单位 do
		local zx = true
		if self.参战单位[n].类型~="bb" then
			if #self.参战单位[n].附加状态 > 0 then
				for i = 1, #self.参战单位[n].附加状态 do
					self.参战单位[n].指令 = {}
					self.参战单位[n].指令.参数 = self.参战单位[n].附加状态[i].名称
					self.参战单位[n].指令.目标 = n
					if self.参战单位[n].附加状态[i].名称=="变身" then
						zx = false
					end
					-- self:法术计算(n)
					-- self.参战单位[编号].附加状态[1]={名称=临时套装[i][2],等级=lv}

					self.战斗流程[#self.战斗流程].挨打方[#self.战斗流程[#self.战斗流程].挨打方+1] = {挨打方=n,增加状态=self.参战单位[n].附加状态[i].名称}
					self:添加状态(self.参战单位[n].附加状态[i].名称,self.参战单位[n],self.参战单位[n],self.参战单位[n].附加状态[i].等级,nil,nil,"套装状态")
				end
			end
		end
		if self.参战单位[n].类型 == "bb" then
			if self.参战单位[n].超级招架 then
				战斗计算:添加护盾(self,n,12)
				self.战斗流程[#self.战斗流程+1]={流程=953,攻击方=0,挨打方={}} ----------佬伍修改（增加超级招架护盾）

			end
		end
		if zx and not self.PK战斗 then
			if self.参战单位[n].门派=="狮驼岭" then
				if self:取经脉(n,"狮驼岭" ,"迅捷") then
					self:添加状态("变身", self.参战单位[n], self.参战单位[n],self:取技能等级(n,"变身"),nil,"迅捷")
					-- self.战斗流程[#self.战斗流程].挨打方[#self.战斗流程[#self.战斗流程].挨打方+1] = {挨打方=n,增加状态="变身"}
					self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=n,挨打方={{挨打方=n,增加状态="变身"}}}--C改

				elseif (self.参战单位[n].队伍==0) or (self.参战单位[n].队伍~=0 and self.参战单位[n].等级<=60) then
					self:添加状态("变身", self.参战单位[n], self.参战单位[n], self.参战单位[n].等级)
					-- self.战斗流程[#self.战斗流程].挨打方[#self.战斗流程[#self.战斗流程].挨打方+1] = {挨打方=n,增加状态="变身"}
					self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=n,挨打方={{挨打方=n,增加状态="变身"}}}--C改   战斗延迟问题

				end
			end
		end
	----------------------------------------------C改
	end
	if #self.战斗流程[#self.战斗流程].挨打方 == 0 then
		self.战斗流程[#self.战斗流程] = nil
	end

	for n=1,#self.参战单位 do
	----------------------------------------------C改
		if #self.参战单位[n].主动技能 > 0 and self.参战单位[n].队伍~=0 then
			for k,v in pairs(self.参战单位[n].主动技能) do
				local CD = 初始技能计算:取使用前CD(self,self.参战单位[n],v.名称)
				if CD~=nil then
					v.剩余冷却回合=CD
				end
			end
		end

		if self.参战单位[n].神出鬼没 ~= nil then
			self.参战单位[n].指令 = {目标 = n}
			self:增益技能计算(n, "修罗隐身", self.参战单位[n].等级)
		elseif self.参战单位[n].隐身 ~= nil then
			self.参战单位[n].指令 = {目标 = n}
			self:增益技能计算(n, "修罗隐身", self.参战单位[n].等级)
		end
		---------------------
		local fulingyz = self:取法宝附灵(n,"叶障")
		if fulingyz then
			local sdun = self.参战单位[n].最大气血 * (fulingyz/100*4)
			if self.参战单位[n].坚如磐石 then
				sdun = sdun * (1+self.参战单位[n].坚如磐石/100)
			end
			sdun = qz(sdun)
			战斗计算:添加护盾(self, n,sdun)

		end
		----------------------
		local fulingfz = self:取法宝附灵(n,"岚载")
		if fulingfz and fulingfz*2.5 > 取随机数(1,100) then
			self:添加状态("岚载",self.参战单位[n],self.参战单位[n],11,nil,5)
			self.战斗流程[#self.战斗流程+1]={流程=902,攻击方=n,挨打方={[1]={挨打方=n,增加状态="岚载"}}}
		end
		----------------------
		local fulingqy = self:取法宝附灵(n,"泉愈")
		if fulingqy then
			self.参战单位[n].泉愈百分比 = fulingqy*5/100
			self:添加状态("泉愈",self.参战单位[n],self.参战单位[n],11,nil,5)
			self.战斗流程[#self.战斗流程+1]={流程=902,攻击方=n,挨打方={[1]={挨打方=n,增加状态="泉愈"}}}
		end
		----------------------

		if self.参战单位[n].与生俱来 ~= nil then
			self.参战单位[n].护盾=qz(self.参战单位[n].最大气血*0.3)
		end
		if self.参战单位[n].变身数据==nil and self.参战单位[n].动物套属性~=nil and self.参战单位[n].动物套属性.名称~="无" then
			local lgl = 取动物套概率(self.参战单位[n].动物套属性.名称,self.参战单位[n].动物套属性.件数)
			if 取随机数()<=lgl+5 then
				self.执行等待=self.执行等待 + 3
				if 变身卡数据[self.参战单位[n].动物套属性.名称]~=nil and 变身卡数据[self.参战单位[n].动物套属性.名称].技能~="" then
					self:添加技能属性(self.参战单位[n],{变身卡数据[self.参战单位[n].动物套属性.名称].技能})
				end
				self.战斗流程[#self.战斗流程+1]={流程=707,攻击方=n,参数=self.参战单位[n].动物套属性.名称}
			end
		end

		if self.参战单位[n]["超级否定信仰"] then  ----------佬伍修改（增加超级赐福状态特效）
			if 超级技能状态名称[self.参战单位[n]["超级否定信仰"]] then

				self:添加状态(超级技能状态名称[self.参战单位[n]["超级否定信仰"]], self.参战单位[n], self.参战单位[n], self.参战单位[n].等级)
				self.战斗流程[#self.战斗流程+1]={流程=902,攻击方=n,挨打方={{挨打方=n,增加状态=超级技能状态名称[self.参战单位[n]["超级否定信仰"]]}}}
			end
		end  ----

	end
end

function 战斗处理类:超级技能是否已有(jnz,mc)
	local fh=false
    for k,v in pairs(jnz) do
    	if v.名称~=nil and mc == v.名称 then
    		fh=true
    		break
    	end
    	if mc == v then
    		fh=true
    		break
    	end
    end
    return fh
end

function 战斗处理类:刷新丸子技能(bh) --超级技能2.26 大改
	local 取随机 = 取随机数(1,100)
	if self.参战单位[bh]==nil then return end
	local zzjhjn = self.参战单位[bh].丸子进化
	if self.参战单位[bh].丸子技能~=nil then
		for kv, nv in pairs(self.参战单位[bh].丸子技能) do
			local qgjjn=取技能是否有高级(self.参战单位[bh],nv.名称)
			local pdjn = "超级" ..nv.名称
			if nv.名称~="奔雷咒" and nv.名称~="壁垒击破" and nv.名称~="地狱烈火" and nv.名称~="水漫金山" and nv.名称~="泰山压顶" then
				local qjnsfygja = 取技能是否有高级(self.参战单位[bh],nv.名称)
			    if nv.名称 == qjnsfygja then
			    	pdjn = "高级" ..nv.名称
			    end
			end
		end
 	end
local 丸子技能列表 = self.参战单位[bh].丸子技能 ----------佬伍修改（修改每回合进场触发超级技能）
if 丸子技能列表 == nil then
    return
end

-- 筛选出有此技能的技能
local 有此技能的列表 = {}
for _, 技能 in pairs(丸子技能列表) do
    if 技能.有此技能 then
        table.insert(有此技能的列表, 技能)
    end
end

-- 获取有此技能的技能数量
local 有此技能数量 = #有此技能的列表

-- 如果没有有此技能的技能，直接返回
if 有此技能数量 == 0 then
    return
end
local function 进化技能(技能)
    local pdjn = "超级" .. 技能.名称
    local qjnsfygja = 取技能是否有高级(self.参战单位[bh], 技能.名称)
    if 技能.名称 == qjnsfygja and 技能.名称~="泰山压顶" and 技能.名称~="水漫金山"  and 技能.名称~="奔雷咒" and 技能.名称~="地狱烈火"  and 技能.名称~="壁垒击破"   then
        pdjn = "高级" .. 技能.名称
    end

    -- 检查是否可以进化
    if self.参战单位[bh].丸子进化 ~= 技能.名称 and
       self.参战单位[bh].丸子进化 ~= pdjn and
       self:超级技能是否已有(self.参战单位[bh].技能, pdjn) == false and
       self:超级技能是否已有(self.参战单位[bh].主动技能, pdjn) == false then

        -- 进化技能
        self.参战单位[bh].丸子进化 = pdjn
---------------------------------------------------新增
        -- 检查是否有超级否定信仰
        local 是否超否 = false
        if self.参战单位[bh].技能 ~= nil then
            for _, jnmc in pairs(self.参战单位[bh].技能) do
                if jnmc == "超级否定信仰" then
                    是否超否 = true
                    break
                end
            end
        end

        -- 如果有超级否定信仰，赐福超级技能失效但计入数量
        if 是否超否 and pdjn ~= "超级否定信仰" then
            -- 标记该超级技能已失效
            self.参战单位[bh]["超否失效_" .. pdjn] = true
            -- 只记录技能名称，不添加效果
            --table.insert(self.参战单位[bh].已加技能, pdjn)--修复，多传了一遍计数，看着6临变七神
        else
-----------------------------------------------------------------
            -- 正常添加技能效果
            if 丸子主动技能[技能.名称] then
                table.insert(self.参战单位[bh].主动技能, {名称 = pdjn, 等级 = self.参战单位[bh].等级})
            end
            table.insert(self.参战单位[bh].已加技能, pdjn)
        end
    end
end
if 有此技能数量 == 1 then
    -- 1个有此技能的技能，25%几率进化一个
    if 取随机 <= 25 then
        local 随机索引 = 取随机数(1, 有此技能数量)
        进化技能(有此技能的列表[随机索引])
    end
elseif 有此技能数量 == 2 then
    -- 2个有此技能的技能，50%几率进化一个
    if 取随机 <= 50 then
        local 随机索引 = 取随机数(1, 有此技能数量)
        进化技能(有此技能的列表[随机索引])
    end
elseif 有此技能数量 == 3 then
    -- 2个有此技能的技能，75%几率进化一个
    if 取随机 <= 75 then
        local 随机索引 = 取随机数(1, 有此技能数量)
        进化技能(有此技能的列表[随机索引])
    end
elseif 有此技能数量 >= 4 then
    -- 4个或以上有此技能的技能，100%进化一个
    local 随机索引 = 取随机数(1, 有此技能数量)
    进化技能(有此技能的列表[随机索引])
end  ----------佬伍修改（修改每回合进场触发超级技能）

-- -- 根据有此技能的技能数量决定进化逻辑
-- if 有此技能数量 >= 4 then   ----------佬伍修改（这段代码是大于4个技能百分百触发两个赐福）
--     local 已进化数量 = 0
--     local 已进化索引 = {} -- 记录已进化的技能索引，避免重复
--     while 已进化数量 < 1 do
--         local 随机索引 = 取随机数(1, 有此技能数量)
--         -- 如果技能已经进化过，则跳过
--         if not 已进化索引[随机索引] then
--             local 技能 = 有此技能的列表[随机索引]
--             进化技能(技能)
--             已进化索引[随机索引] = true -- 标记为已进化
--             已进化数量 = 已进化数量 + 1
--         end
--     end
-- end ----------佬伍修改（这段代码是大于4个技能百分百触发两个赐福）


	--print(zzjhjn ,self.参战单位[bh].丸子进化 ,"tf===============ghjfgh")
	--print(zzjhjn ,self.参战单位[bh].丸子进化 ,"tf===============ghjfgh")
	if 丸子技能列表~=self.参战单位[bh].丸子进化 then --超级技能2.8 ----------佬伍修改（修复赐福生效的超级技能也可以增加属性）
		 if 丸子技能列表~=nil then
			战斗计算:删除并重置技能属性(self,self.参战单位[bh],丸子技能列表,self.参战单位[bh].丸子进化)
		 end
    end
    丸子技能列表=nil ----------佬伍修改（修复赐福生效的超级技能也可以增加属性）
     if self.参战单位[bh].主人序号 ~= nil and self.参战单位[self.参战单位[bh].主人序号] ~= nil then
	   local 编号 = self:取参战编号(self.参战单位[bh].玩家id, self.参战单位[bh].类型)
      发送数据(self.参战单位[self.参战单位[bh].主人序号].连接id, 382, {id=编号,丸子进化=self.参战单位[bh].丸子进化,超级夜战=self.参战单位[bh].超级夜战,超级偷袭=self.参战单位[bh].超级偷袭,超级敏捷=self.参战单位[bh].超级敏捷})
    end
end

function 战斗处理类:添加超级否定信仰属性(单位) ---------佬伍修改（赐福生效技能也被超否认定）

    -- 检查单位是否存在
    if 单位 == nil then
        return
    end

    -- 统计超级技能数量
    local yycjjn = 0 -- 拥有的超级技能数量
    local 超级技能列表 = {} -- 记录拥有的超级技能--（新增）

    -- 统计普通技能中的超级技能
    if 单位.技能 ~= nil then
        for _, 技能名称 in pairs(单位.技能) do
            if string.find(技能名称, "超级") and 技能名称~="超级神柚复生" and 技能名称~="超级三昧真火"  then
                yycjjn = yycjjn + 1
                超级技能列表[#超级技能列表 + 1] = 技能名称--（新增）
            end
        end
    end

    -- 统计丸子进化技能中的超级技能
    if 单位.丸子进化 ~= nil and string.find(单位.丸子进化, "超级") then
        yycjjn = yycjjn + 1
        超级技能列表[#超级技能列表 + 1] = 单位.丸子进化--（新增）
    end

    -- 如果没有超级技能，直接返回
    if yycjjn == 0 then
        return
    end

    -- 初始化属性记录表
    if 单位.超信增 == nil then
        单位.超信增 = {}
    end

    -- 如果属性已经调整过，直接返回
    if 单位.超信增["最大气血"] ~= nil then
        return
    end

    -- 记录超级技能数量（用于伤害计算）--（新增）
    单位.超信技能数 = yycjjn

    -- 定义属性调整函数
    local function 调整属性(属性名称, 调整比例)
        if 单位[属性名称] ~= nil then
            单位.超信增[属性名称] = 单位[属性名称] -- 记录原始属性
            单位[属性名称] = qz(单位[属性名称] * (1 + 调整比例)) -- 调整属性
        end
    end

    -- 调整单位属性
    调整属性("最大气血", yycjjn * 0.2) -- 每个超级技能增加20%气血
    调整属性("气血", yycjjn * 0.2) -- 每个超级技能增加20%气血
    调整属性("防御", -0.05) -- 固定降低5%防御
    调整属性("法防", -0.05) -- 固定降低5%法防

    -- 清除神佑和鬼魂效果
    单位.神佑 = nil
    单位.鬼魂 = nil
    单位.高鬼魂 = nil
    单位.感知 = nil
    单位.雷吸 = nil
    单位.火吸 = nil
    单位.土吸 = nil
    单位.水吸 = nil

    -- 其他超级技能失效（超级否定信仰本身除外）--（新增）
    for _, 技能名称 in pairs(超级技能列表) do
        if 技能名称 ~= "超级否定信仰" then
            -- 标记该超级技能已失效
            单位["超否失效_" .. 技能名称] = true

            -- 主动清除该超级技能的效果
            -- 根据技能名称清除对应的超级技能效果
            if 技能名称 == "超级遗志" then
                单位.遗志 = 2
            elseif 技能名称 == "超级进击必杀" then
                单位.进击必杀 = 30
            elseif 技能名称 == "超级进击法暴" then
                单位.进击法暴 = 20
            elseif 技能名称 == "超级反击" then
                单位.超级反击 = nil
            elseif 技能名称 == "超级反震" then
                单位.反震 = 0.5
            elseif 技能名称 == "超级吸血" then
                单位.超级吸血 = nil
            elseif 技能名称 == "超级连击" then
                单位.超级连击 = nil
            elseif 技能名称 == "超级飞行" then
                单位.超级飞行 = nil
            elseif 技能名称 == "超级夜战" then
                单位.超级夜战 = 0
            elseif 技能名称 == "超级强力" then
                单位.超强力 = nil
            elseif 技能名称 == "超级防御" then
                单位.超级防御 = nil
            elseif 技能名称 == "超级隐身" then
                单位.超级隐身 = nil
            elseif 技能名称 == "超级感知" then
                单位.感知 = nil
            elseif 技能名称 == "超级再生" then
                单位.超级再生 = nil
            elseif 技能名称 == "超级冥思" then
                单位.冥思 = nil
            elseif 技能名称 == "超级慧根" then
                单位.超级慧根 = nil
            elseif 技能名称 == "超级必杀" then
                单位.超级必杀 = 0
            elseif 技能名称 == "超级合纵" then
                单位.合纵 = qz(self:取合纵加成(单位.主人序号)  * 单位.等级/4)
                单位.超级合纵 = nil
            elseif 技能名称 == "超级幸运" then
                单位.超级幸运 = nil
            elseif 技能名称 == "超级神迹" then
                单位.超级神迹 = nil
            elseif 技能名称 == "超级招架" then
                单位.超级招架=nil
            elseif 技能名称 == "超级敏捷" then
                单位.超级敏捷={概率=0,触发=0,执行=false,指令={}}
            elseif 技能名称 == "超级偷袭" then
                单位.超级偷袭=false
            elseif 技能名称 == "超级毒" then
                单位.超级毒=nil
            elseif 技能名称 == "超级驱鬼" then
                单位.超级驱鬼 = nil
            elseif 技能名称 == "超级魔之心" then
                单位.魔之心 = 1.2
            elseif 技能名称 == "超级精神集中" then
                单位.超级精神集中 = nil
            elseif 技能名称 == "超级法术暴击" then
                单位.法暴 = 15
                单位.超爆 = nil
            elseif 技能名称 == "超级法术波动" then
                单位.法波上 = 150
                单位.法波下 = 50
            elseif 技能名称 == "超级法术抵抗" then
                单位.超法抵抗 = nil
            elseif 技能名称 == "超级盾气" then
                单位.盾气 = 2
            elseif 技能名称 == "超级水属性吸收" then
                单位.超水吸 = nil
            elseif 技能名称 == "超级雷属性吸收" then
                单位.超雷吸 = nil
            elseif 技能名称 == "超级火属性吸收" then
                单位.超火吸 = nil
            elseif 技能名称 == "超级土属性吸收" then
                单位.超土吸 = nil
            elseif 技能名称 == "超级奔雷咒" then
                -- 超级奔雷咒失效
            elseif 技能名称 == "超级壁垒击破" then
                -- 超级壁垒击破失效
            elseif 技能名称 == "超级地狱烈火" then
                -- 超级地狱烈火失效
            elseif 技能名称 == "超级水漫金山" then
                -- 超级水漫金山失效
            elseif 技能名称 == "超级泰山压顶" then
                -- 超级泰山压顶失效
            elseif 技能名称 == "超级永恒" then
                -- 超级永恒失效
            end
        end
    end
end

function 战斗处理类:增删主人技能属性(bh,名称,sj)
	if self.参战单位[bh]==nil then return end
	if 名称 == "超级感知" then
		if tonumber(sj)~=nil then
			self.参战单位[bh].感知 = sj
			self.参战单位[bh].感知回合 = 5
		else
		    self.参战单位[bh].感知 = nil
		    self.参战单位[bh].感知回合=nil
		end
	elseif 名称 == "超级冥思" then
		if tonumber(sj)~=nil then
			self.参战单位[bh].冥思 = qz(self.参战单位[bh].等级/2)
			self.参战单位[bh].冥思回合 = 5
		else
			self.参战单位[bh].冥思=nil
		    self.参战单位[bh].冥思回合=nil
		end
	elseif 名称 == "超级盾气" then
	    if tonumber(sj)~=nil then
			self.参战单位[bh].盾气 = 1
		else
		    self.参战单位[bh].盾气 = nil
		end
	end
end

function 战斗处理类:地宫怪物属性(单位)
	if 单位.前缀 then
		单位[单位.前缀]=true
		-- if 单位.前缀=="汗血的" then
		--  单位.汗血的=true
		-- elseif 单位.前缀=="好战的" then
		--  单位.递增伤害=0.05
		if 单位.前缀=="隐忍的" then-- 隐忍的=偶数回合才会出手，被封印解封当回合直接出手（隐忍狂豹除外）出手伤害+100%。--物法
			单位.不可封印=true

		elseif 单位.前缀=="偏执的" then-- 偏执的=单数回合才会出手，被封印后解封当回合开始出手，出手伤害+100% 。--物法
			单位.不可封印=true

		-- elseif 单位.前缀=="无畏的" then--抗封20%，同时血量越低增加伤害结果。--物法
		-- elseif 单位.前缀=="疯癫的" then-- 疯癫的=会随机攻击双方单位，伤害增加400%，受到伤害降低。    --物  普攻
		end
	end

	if 单位.后缀 then
		单位[单位.后缀]=true
		if 单位.后缀=="刺客" then-- 刺客=输出增加400%，血量减少50%，附带高级隐身，隐身结束前只会平么。
			单位.隐身 = 2
			单位.连击 = 55
		elseif 单位.后缀=="富豪" then
			单位.不可封印=true
		elseif 单位.后缀=="谋士" then
			单位.魔法免疫=true
		elseif 单位.后缀=="武士" then
			单位.物理免疫=true
		-- 士卒=对方场上每被击杀一只怪物，提升10%伤害结果。
		-- elseif 单位.后缀=="富豪" then-- 富豪=每回合会反间一只EB，被封解封。
		-- elseif 单位.后缀=="百姓" then-- 百姓=场上没有满怪会以召唤的方式分身，必须优先击杀。
		-- elseif 单位.后缀=="傀儡" then-- 傀儡=无法选中，主怪被击杀后会逃跑，增加2O%伤害结果。
		-- elseif 单位.后缀=="护卫" then-- 护卫=会自动保护被物理攻击的单位，但是每回合保护同一单位血里是有上限的。
		-- elseif 单位.后缀=="死士" then-- 死士=气血低于30%，会自爆,血量剩的越多，自爆伤害越高。
		-- elseif 单位.后缀=="俳忧" then-- 俳忧=每回合开始前对全队使用死亡之音，随机附加一个FC的封印，可能水封，持续1回合。
		-- elseif 单位.后缀=="谋士" then-- 谋士=魔法免疫，但是受到物理伤害+50%。
		-- elseif 单位.后缀=="武士" then-- 武士=物理免疫，但是受到法术伤害+50%。
		-- elseif 单位.后缀=="酒鬼" then-- 酒鬼=回合开始时进入催眠，被打醒或解封，提升100%伤害结果出手，同时每回合增加10%伤害结果。
		-- elseif 单位.后缀=="更夫" then-- 更夫=每回合自己出手之前解封敌方《回合数/2）个单位的法术封印。
		end
		-- if 单位.后缀=="花魁" then-- 花魁=被击杀时，给敌方所有怪物提升30%伤害结果。

	end
end

function 战斗处理类:检查bb套装(bb)
	local 临时套装 = {}
	for w, v in pairs(bb.装备) do
		if v ~= nil and bb.装备[w] ~= nil and bb.装备[w].套装效果 ~= nil then
			临时套装[#临时套装 + 1] = {bb.装备[w].套装效果[1], bb.装备[w].套装效果[2]}
		end
	end
	if #临时套装==1 then --3--三件套才开始计算
		for i = 1, #临时套装 do
			local 重复 = false
			local 数量 = 1
			for a = 1, #bb[临时套装[i][1]] do
				if bb[临时套装[i][1]][a].名称 == 临时套装[i][2] then
					重复 = true
				end
			end
			if 重复 == false then
				for a = 1, #临时套装 do
					if a ~= i then
						if 临时套装[a][1] == 临时套装[i][1] and 临时套装[a][2] == 临时套装[i][2] then
							数量 = 数量 + 1
						end
					end
				end
				if 数量 >= 1 then--3
					local 等级 = bb.等级
					if 数量 >= 3 then--5
						等级 = 等级 + 10
					end
					bb[临时套装[i][1]][#bb[临时套装[i][1]] + 1] = {名称 = 临时套装[i][2], 等级 = 等级}
				end
			end
		end
		if #bb.附加状态 > 0 then
			self:添加技能属性(bb, {bb.附加状态[1].名称})
		elseif #bb.追加法术 > 0 then
			bb.套装追加概率=30
		end
	end
end

function 战斗处理类:检查套装效果(编号,id)
	local 临时套装 = {}
	for w, v in pairs(玩家数据[id].角色.装备) do
		if  v ~= nil and 玩家数据[id].道具.数据[v] ~= nil then
			if w == 3 then
				self.参战单位[编号].攻击五行 = 玩家数据[id].道具.数据[v].五行
				self.参战单位[编号].武器命中 = 玩家数据[id].道具.数据[v].命中
			elseif w == 4 then
				self.参战单位[编号].防御五行 = 玩家数据[id].道具.数据[v].五行
			end
			if 玩家数据[id].道具.数据[v].伤害 then
				self.参战单位[编号].装备伤害 = self.参战单位[编号].装备伤害 + 玩家数据[id].道具.数据[v].伤害
			end
			if 玩家数据[id].道具.数据[v].敏捷 then
				self.参战单位[编号].装备敏捷 = self.参战单位[编号].装备敏捷 + 玩家数据[id].道具.数据[v].敏捷
			end
			if 玩家数据[id].道具.数据[v].新特效~=nil and 玩家数据[id].道具.数据[v].新特效数值~=nil then
				self:计算160属性(编号,玩家数据[id].道具.数据[v].新特效,玩家数据[id].道具.数据[v].新特效数值)
			end
			if 玩家数据[id].道具.数据[v].武器专属 and 玩家数据[id].道具.数据[v].武器专属.门派 == self.参战单位[编号].门派 and 玩家数据[id].道具.数据[v].武器专属.类型 == "治疗能力" then
				self.参战单位[编号].治疗能力 = self.参战单位[编号].治疗能力 + 玩家数据[id].道具.数据[v].武器专属.数值
			end
		end
		if w~= 3 and v ~= nil and 玩家数据[id].道具.数据[v] ~= nil and 玩家数据[id].道具.数据[v].套装效果 ~= nil then
			if 判断是否为空表(临时套装) then
				临时套装[#临时套装+1]={玩家数据[id].道具.数据[v].套装效果[1],玩家数据[id].道具.数据[v].套装效果[2],数量=1}
			else
				local 新套装效果 = true
				for i=1,#临时套装 do
					if 临时套装[i][2] == 玩家数据[id].道具.数据[v].套装效果[2] then
						临时套装[i].数量=临时套装[i].数量+1
						新套装效果=false
					end
				end
				if 新套装效果 then
					临时套装[#临时套装+1]={玩家数据[id].道具.数据[v].套装效果[1],玩家数据[id].道具.数据[v].套装效果[2],数量=1}
				end
			end
		end
	end

	if 判断是否为空表(临时套装)~=nil then
		local 等级=self.参战单位[编号].等级
		local 数量=0
		if self.参战单位[编号].门派 == "大唐官府"  then
			local k = "披坚执锐"
			if self:取被动(编号, k) then
				slot6, slot7, slot8 = pairs(临时套装)
				for k,v in pairs(临时套装) do
					if v[1] == "追加法术" then
						数量 = 数量 + 1
						self.参战单位[编号].披坚执锐[k] = {}
						local 状态等级 = 等级 + 10

						if v.数量 >= 3 then
							self.参战单位[编号].三件套名称 = v[2]
						end

						self.参战单位[编号].披坚执锐[k] = {
							名称 = v[2],
							等级 = 状态等级,
							追加概率 = 取追加法术概率(v[2], 5)
						}
						self.参战单位[编号].追加法术[#self.参战单位[编号].追加法术 + 1] = {
							名称 = 临时套装[k][2],
							等级 = 状态等级
						}
						self.参战单位[编号].套装追加概率 = 70
					elseif v[1] == "附加状态" and v.数量 >= 3 then
						local 状态等级 = 等级 - 10
						-- 优化冗余判断（外层已确保v.数量>=3）
						if v.数量 == 5 then
							状态等级 = 等级 + 10
						end
						if self.参战单位[编号].附加状态 == nil then
							self.参战单位[编号].附加状态 = {}
						end
						-- 修复1：统一存储到附加状态[1]，与非大唐逻辑一致
						self.参战单位[编号].附加状态[1] = {
							名称 = v[2],
							等级 = 状态等级
						}
					end
				end
			end

			-- 修复2：移除“数量 < 2”的条件限制，确保附加状态始终被处理
			for i = 1, #临时套装 do
				if 临时套装[i].数量 >= 3 and 临时套装[i][1] ~= "变身术之" then
					if 临时套装[i][1] == "附加状态" then
						local lv = 等级 - 10
						if 临时套装[i].数量 == 5 then
							lv = 等级 + 10
						end
						-- 统一存储路径，覆盖可能的重复设置（确保生效）
						self.参战单位[编号].附加状态[1] = {
							名称 = 临时套装[i][2],
							等级 = lv
						}
					elseif 临时套装[i][1] ~= "追加法术" then
						-- 保留其他套装类型的处理逻辑
						self.参战单位[编号].套装追加概率 = 取追加法术概率(临时套装[i][2], 3)
						local 状态等级 = 等级 - 10

						if 临时套装[i].数量 >= 5 then
							self.参战单位[编号].套装追加概率 = 取追加法术概率(临时套装[i][2], 5)
							状态等级 = 等级 + 10
						end

						local 目标字段 = 临时套装[i][1]
						if self.参战单位[编号][目标字段] == nil then
						    self.参战单位[编号][目标字段] = {}
						end
						self.参战单位[编号][目标字段][#self.参战单位[编号][目标字段] + 1] = {
						    名称 = 临时套装[i][2],
						    等级 = 状态等级
						}
					end
				end
			end

			-- 保留披坚执锐随机逻辑（不影响附加状态）
			if self.参战单位[编号].披坚执锐 ~= nil and #self.参战单位[编号].披坚执锐 > 2 then
				local sjb = self.参战单位[编号].披坚执锐
				local 随机1 = 取随机数(1, #sjb)
				local 随机2 = 取随机数(1, #sjb)

				for i = 1, 5 do
					if 随机1 == 随机2 then
						随机2 = 取随机数(1, #sjb)
					else
						break
					end
				end

				if self:取经脉(编号, "大唐官府", "昂扬") then
					self.参战单位[编号].披坚执锐.昂扬 = 1
				end

				self.参战单位[编号].披坚执锐.可用编号 = 随机1
				self.参战单位[编号].披坚执锐.可用编号 = 随机2
			end
		else
			-- 非大唐门派逻辑保持不变
			for i = 1, #临时套装 do
				if 临时套装[i].数量 >= 3 and 临时套装[i][1] ~= "变身术之" then
					if 临时套装[i][1] == "附加状态" then
						local lv = 等级 - 10

						if 临时套装[i].数量 == 5 then
							lv = 等级 + 10
						end

						self.参战单位[编号].附加状态[1] = {
							名称 = 临时套装[i][2],
							等级 = lv
						}
					else
						self.参战单位[编号].套装追加概率 = 取追加法术概率(临时套装[i][2], 3)
						local 状态等级 = 等级 - 10

						if 临时套装[i].数量 >= 5 then
							self.参战单位[编号].套装追加概率 = 取追加法术概率(临时套装[i][2], 5)
							状态等级 = 等级 + 10
						end

						self.参战单位[编号][临时套装[i][1]][#self.参战单位[编号][临时套装[i][1]] + 1] = {
							名称 = 临时套装[i][2],
							等级 = 状态等级
						}
					end
				end
			end
		end
	end
end

function 战斗处理类:取是否有指定状态(编号, 目标, 状态, 来自编号)
	if 编号 == nil or 目标 == nil or 状态 == nil or self.参战单位[编号] == nil or self.参战单位[目标] == nil then
		return
	end

	if self.参战单位[目标].法术状态[状态] == nil then
		return false
	elseif 来自编号 == nil then
		return true
	elseif self.参战单位[目标].法术状态[状态].攻击编号 == 来自编号 then
		return true
	end

	return false
end
function 战斗处理类:增加阵法属性(编号, 名称, 位置, 阵法加成,队伍id)
	local x阵法加成 = 1
	if 阵法加成 ~= nil then
		x阵法加成 = 1 + 阵法加成
	end
	local 阵法系统加成=1
	if 玩家数据[队伍id] and 玩家数据[队伍id].角色 and  玩家数据[队伍id].角色.阵法[名称] then
		local lv=玩家数据[队伍id].角色.阵法[名称]
		阵法系统加成=1+(lv*全局基础数据.阵法系统加成)
	end

	if 名称=="天覆阵" then
		self.参战单位[编号].固伤加成=1.15
		self.参战单位[编号].速度=qz(self.参战单位[编号].速度*0.9*x阵法加成)
		self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成*阵法系统加成)
		self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成*阵法系统加成)
	elseif 名称=="风扬阵" then
		if 位置==1 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成*阵法系统加成)
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.05*x阵法加成*阵法系统加成)
		elseif 位置==2 or 位置==3 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成*阵法系统加成)
		else
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成*阵法系统加成)
		end
	elseif 名称=="虎翼阵" then
		if 位置==1 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.3*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.3*x阵法加成*阵法系统加成)
		elseif 位置==2 or 位置==3 then
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.1*x阵法加成*阵法系统加成)
		else
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成*阵法系统加成)
		end
	elseif 名称=="云垂阵" then
		if 位置==1 then
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.25*x阵法加成*阵法系统加成)
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.25*x阵法加成*阵法系统加成)
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*0.85*x阵法加成)
		elseif 位置==2 then
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.1*x阵法加成*阵法系统加成)
		elseif 位置==3 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成*阵法系统加成)
		else
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成*阵法系统加成)
		end
	elseif 名称=="鸟翔阵" then
		if 位置==1 then
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.2*x阵法加成*阵法系统加成)
		elseif 位置==2 or 位置==3 then
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成*阵法系统加成)
		else
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.15*x阵法加成*阵法系统加成)
		end
	elseif 名称=="地载阵" then
		if 位置==1 or 位置==3 or 位置==4 then
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.15*x阵法加成*阵法系统加成)
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.15*x阵法加成*阵法系统加成)
		elseif 位置==2 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.15*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.15*x阵法加成*阵法系统加成)
		else
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成*阵法系统加成)
		end
	elseif 名称=="龙飞阵" then
		if 位置==1 then
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.1*x阵法加成*阵法系统加成)
		elseif 位置==2 then
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成*阵法系统加成)
		elseif 位置==3 then
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.3*x阵法加成*阵法系统加成)
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*0.8*x阵法加成)
		elseif 位置==4 then
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成*阵法系统加成)
		else
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成*阵法系统加成)
		end
	elseif 名称=="鹰啸阵" then
		if 位置==1 then
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成*阵法系统加成)
		elseif 位置==2 then
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.15*x阵法加成*阵法系统加成)
		elseif 位置==3 then
			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.15*x阵法加成*阵法系统加成)
		elseif 位置==4 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.15*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.15*x阵法加成*阵法系统加成)
		else
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成*阵法系统加成)
		end
	elseif 名称=="蛇蟠阵" then
		if 位置==1 or 位置==2 or 位置==3 or 位置==4 or 位置==5  then
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.5*x阵法加成*阵法系统加成)
		end
	elseif 名称=="雷绝阵" then
		if 位置==1 then
			self.参战单位[编号].固伤加成=1.2*阵法系统加成
			self.参战单位[编号].bb伤害加成=1.1*阵法系统加成
			self.参战单位[编号].bb法伤加成=1.1*阵法系统加成
		elseif 位置==2 then
			self.参战单位[编号].固伤加成=1.2*阵法系统加成
			self.参战单位[编号].bb伤害加成=1.1*阵法系统加成
			self.参战单位[编号].bb法伤加成=1.1*阵法系统加成
		elseif 位置==3 then
			self.参战单位[编号].固伤加成=1.2*阵法系统加成
			self.参战单位[编号].bb伤害加成=1.1*阵法系统加成
			self.参战单位[编号].bb法伤加成=1.1*阵法系统加成
		elseif 位置==4 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].bb伤害加成=1.1*阵法系统加成
			self.参战单位[编号].bb法伤加成=1.1*阵法系统加成
		elseif 位置==5 then
			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成*阵法系统加成)
			self.参战单位[编号].bb伤害加成=1.1*阵法系统加成
			self.参战单位[编号].bb法伤加成=1.1*阵法系统加成
		end
	end
end
-- function 战斗处理类:增加阵法属性(编号, 名称, 位置, 阵法加成)
-- 	local x阵法加成 = 1
-- 	if 阵法加成 ~= nil then
-- 		x阵法加成 = 1 + 阵法加成
-- 	end
-- 	if 名称=="天覆阵" then
-- 		self.参战单位[编号].固伤加成=1.15
-- 		self.参战单位[编号].速度=qz(self.参战单位[编号].速度*0.9*x阵法加成)
-- 		self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成)
-- 		self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成)
-- 	elseif 名称=="风扬阵" then
-- 		if 位置==1 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成)
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.05*x阵法加成)
-- 		elseif 位置==2 or 位置==3 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成)
-- 		else
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成)
-- 		end
-- 	elseif 名称=="虎翼阵" then
-- 		if 位置==1 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.3*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.3*x阵法加成)
-- 		elseif 位置==2 or 位置==3 then
-- 			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成)
-- 			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.1*x阵法加成)
-- 		else
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成)
-- 		end
-- 	elseif 名称=="云垂阵" then
-- 		if 位置==1 then
-- 			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.25*x阵法加成)
-- 			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.25*x阵法加成)
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*0.85*x阵法加成)
-- 		elseif 位置==2 then
-- 			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成)
-- 			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.1*x阵法加成)
-- 		elseif 位置==3 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成)
-- 		else
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成)
-- 		end
-- 	elseif 名称=="鸟翔阵" then
-- 		if 位置==1 then
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.2*x阵法加成)
-- 		elseif 位置==2 or 位置==3 then
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成)
-- 		else
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.15*x阵法加成)
-- 		end
-- 	elseif 名称=="地载阵" then
-- 		if 位置==1 or 位置==3 or 位置==4 then
-- 			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.15*x阵法加成)
-- 			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.15*x阵法加成)
-- 		elseif 位置==2 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.15*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.15*x阵法加成)
-- 		else
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成)
-- 		end
-- 	elseif 名称=="龙飞阵" then
-- 		if 位置==1 then
-- 			self.参战单位[编号].法防=qz(self.参战单位[编号].法防*1.1*x阵法加成)
-- 		elseif 位置==2 then
-- 			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成)
-- 		elseif 位置==3 then
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.3*x阵法加成)
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*0.8*x阵法加成)
-- 		elseif 位置==4 then
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.1*x阵法加成)
-- 		else
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.2*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.2*x阵法加成)
-- 		end
-- 	elseif 名称=="鹰啸阵" then
-- 		if 位置==1 then
-- 			self.参战单位[编号].防御=qz(self.参战单位[编号].防御*1.1*x阵法加成)
-- 		elseif 位置==2 then
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.15*x阵法加成)
-- 		elseif 位置==3 then
-- 			self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.15*x阵法加成)
-- 		elseif 位置==4 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.15*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.15*x阵法加成)
-- 		else
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成)
-- 		end
-- 	elseif 名称=="蛇蟠阵" then
-- 		if 位置==4 or 位置==5 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成)
-- 		end
-- 	elseif 名称=="雷绝阵" then
-- 		if 位置==1 then
-- 			self.参战单位[编号].固伤加成=1.2
-- 			self.参战单位[编号].bb伤害加成=1.1
-- 			self.参战单位[编号].bb法伤加成=1.1
-- 		elseif 位置==2 then
-- 			self.参战单位[编号].固伤加成=1.2
-- 			self.参战单位[编号].bb伤害加成=1.1
-- 			self.参战单位[编号].bb法伤加成=1.1
-- 		elseif 位置==3 then
-- 			self.参战单位[编号].固伤加成=1.2
-- 			self.参战单位[编号].bb伤害加成=1.1
-- 			self.参战单位[编号].bb法伤加成=1.1
-- 		elseif 位置==4 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成)
-- 			self.参战单位[编号].bb伤害加成=1.1
-- 			self.参战单位[编号].bb法伤加成=1.1
-- 		elseif 位置==5 then
-- 			self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害*1.1*x阵法加成)
-- 			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*1.1*x阵法加成)
-- 			self.参战单位[编号].bb伤害加成=1.1
-- 			self.参战单位[编号].bb法伤加成=1.1
-- 		end
-- 	end
-- end



function 战斗处理类:添加召唤兽属性(单位)
	-- if 玩家数据[单位.玩家id].角色:取生活技能等级("御兽术") ~= nil then
	--  local 等级 = 玩家数据[单位.玩家id].角色:取生活技能等级("御兽术") * 0.001
	--  if 等级 ~= 0 and 等级 ~= nil then
	--      单位.气血 = 单位.气血 + qz(单位.气血 * 等级)
	--      单位.最大气血 = 单位.最大气血 + qz(单位.最大气血 * 等级)
	--      单位.伤害 = 单位.伤害 + qz(单位.伤害 * 等级)
	--      单位.防御 = 单位.防御 + qz(单位.防御 * 等级)
	--      单位.速度 = 单位.速度 + qz(单位.速度 * 等级)
	--      单位.灵力 = 单位.灵力 + qz(单位.灵力 * 等级)
	--  end
	-- end
	if self:直接取玩家经脉(单位.玩家id,"国色") and 玩家数据[单位.玩家id].角色.速度>= 单位.等级*5 then
		单位.速度 = qz(单位.速度 *1.12)
	elseif self:直接取玩家经脉(单位.玩家id,"御兽") and 玩家数据[单位.玩家id].角色.速度>= 单位.等级*3 then
		单位.速度 = 单位.速度 + qz(单位.等级 *0.7)
		单位.法防 = 单位.法防 + 单位.等级
	elseif self:直接取玩家经脉(单位.玩家id,"朝拜") and (单位.模型=="巨力神猿" or 单位.模型=="长眉灵猴" or 单位.模型=="超级神猴" or 单位.模型=="超级金猴") then
		单位.伤害 = qz(单位.伤害 *1.1)
		单位.法伤 = qz(单位.法伤 *1.1)
	elseif self:直接取玩家经脉(单位.玩家id,"共鸣") then
		单位.共鸣 = 1
	end
end

function 战斗处理类:加载野外单位()
	local 加载数量 = 0
	if 玩家数据[self.发起id].队伍 == 0 then
		加载数量 = 取随机数(5, 7)
	else
		local 队伍数量 = #队伍数据[玩家数据[self.发起id].队伍].成员数据
		加载数量 = 取随机数(队伍数量 + 1, 队伍数量 * 2 + 1)
		if 加载数量 > 10 then
			加载数量 = 10
		end
	end
	local 临时信息 = 取野怪(self.战斗地图)
	local 队伍id = 0
	local 临时等级 = 0
	local 临时等级1 = 0
	临时等级, 临时等级1 = 取场景等级(self.战斗地图)
	self.等级上限 = 临时等级1
	self.等级下限 = 临时等级
	self.地图等级 = qz((self.等级下限 + self.等级上限) / 2)
	self.精灵数量 = 0
	self.头领数量 = 0
	self.敌人数量 = 加载数量
	--加载数量=10
	for n = 1, 加载数量 do
		local 临时野怪 = 取敌人信息(临时信息[取随机数(1, #临时信息)])
		self.地图等级 = 取随机数(self.等级上限 - 5, self.等级上限)--新加
		self.生成等级 = self.地图等级
		self.临时等级 = 取随机数(self.等级下限, self.等级上限)
		local 变异 = false
		if  RpbARGB.序列==5 then
			if 取随机数(1,150)<=1 then 变异=true end
		else
		   if 取随机数(1,1000)<=1 then 变异=true end
		end

		local 宝宝 = false
		if 取随机数(1, 500) <= 3 then 宝宝 = true end
		if 变异 or 宝宝 then
			self.临时等级 = 0
			self.生成等级 = 1
		end
		local 特殊概率 = 3
		if 正式 then 特殊概率 = 10 end
		if self.战斗地图  == 1242 and 取随机数(1,1000) <= 特殊概率 then
			local 野怪组 = {29998,31042,30042,130025,130029,130030,130031}
			临时野怪 = 取敌人信息(野怪组[取随机数(1,#野怪组)])
		elseif self.战斗地图  == 1235 and 取随机数(1,1000) <= 特殊概率 then
			local 野怪组 = {-29551}
			临时野怪 = 取敌人信息(野怪组[取随机数(1,#野怪组)])
		elseif self.战斗地图  == 1231 and 取随机数(1,1000) <= 特殊概率 then
			local 野怪组 = {31142}
			临时野怪 = 取敌人信息(野怪组[取随机数(1,#野怪组)])
		end
		self.参战单位[#self.参战单位 + 1] = {}
		self.参战单位[#self.参战单位].名称 = 临时野怪[2]
		if 变异 then
			self.参战单位[#self.参战单位].名称 = "变异"..临时野怪[2]
		end
		self.参战单位[#self.参战单位].模型 = 临时野怪[2]
		self.参战单位[#self.参战单位].等级 = self.临时等级
		self.参战单位[#self.参战单位].队伍 = 队伍id
		self.参战单位[#self.参战单位].位置 = n
		self.参战单位[#self.参战单位].变异 = 变异
		self.参战单位[#self.参战单位].类型 = "bb"
		self.参战单位[#self.参战单位].法防 = 0-- 0.5) --调用08伤害数据
		self.参战单位[#self.参战单位].法伤 = math.floor(self.生成等级 * 4.85)
		self.参战单位[#self.参战单位].玩家id = 0
		self.参战单位[#self.参战单位].分类 = "野怪"
		self.参战单位[#self.参战单位].可捕捉 = true
		self.参战单位[#self.参战单位].附加阵法 = "普通"
		self.参战单位[#self.参战单位].伤害 = math.floor(self.生成等级 * 6.8)--4.8)
		self.参战单位[#self.参战单位].命中 = self.生成等级*5
		self.参战单位[#self.参战单位].防御 = math.floor(self.生成等级 * 2.5)
		self.参战单位[#self.参战单位].速度 = math.floor(self.生成等级 * 1.5)
		self.参战单位[#self.参战单位].灵力 = math.floor(self.生成等级 * 4.85)--0.8)
		self.参战单位[#self.参战单位].躲避 = math.floor(self.生成等级 * 1.5)
		self.参战单位[#self.参战单位].气血 = math.floor(self.生成等级 * 17.5) + 10--17.5)--08是12.5
		self.参战单位[#self.参战单位].最大气血 = math.floor(self.生成等级 * 17.5) + 10--17.5)
		self.参战单位[#self.参战单位].魔法 = math.floor(self.生成等级 * 7.5) + 10
		self.参战单位[#self.参战单位].最大魔法 = math.floor(self.生成等级 * 7.5) + 10
		self.参战单位[#self.参战单位].体质 = self.生成等级
		self.参战单位[#self.参战单位].魔力 = self.生成等级
		self.参战单位[#self.参战单位].力量 = self.生成等级
		self.参战单位[#self.参战单位].耐力 = self.生成等级
		self.参战单位[#self.参战单位].敏捷 = self.生成等级
		self.参战单位[#self.参战单位].技能 = {}
		-- self.参战单位[#self.参战单位].符石技能 = {}
		self.参战单位[#self.参战单位].已加技能 = {}
		self.参战单位[#self.参战单位].显示饰品 = false

		if 变异 then
			self.参战单位[#self.参战单位].分类 = "变异"
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "诶啊..我..我..我什么变态了,不对是换色了,你们别抓我呀!#52"}
		elseif 宝宝 then
			self.参战单位[#self.参战单位].分类 = "宝宝"
			self.参战单位[#self.参战单位].名称 = self.参战单位[#self.参战单位].模型.."宝宝"
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "其实我一个小小的宝宝,你们别抓我呀!#52"}
		end
		--   local 测试技能={"弱点雷","弱点火","弱点水","弱点土","高级水属性吸收","高级火属性吸收","高级雷属性吸收","高级土属性吸收"}
		local 临时技能 = 临时野怪[14]
		for n = 1, #临时技能 do
			if 临时技能[n] == "鬼魂术" then
				self.参战单位[#self.参战单位].技能[#self.参战单位[#self.参战单位].技能 + 1] = 临时技能[n]
			else
				if 取随机数() <= 50  then
					self.参战单位[#self.参战单位].技能[#self.参战单位[#self.参战单位].技能 + 1] = 临时技能[n]
				end
			end
		end
		if self.精灵数量 == 0 and 取随机数() <= 2 then
			self.精灵数量 = 1
			self.参战单位[#self.参战单位].精灵 = true
			self.参战单位[#self.参战单位].抵抗封印等级 = 10000
			self.参战单位[#self.参战单位].技能 = {"自爆"}
			self.参战单位[#self.参战单位].气血 = self.参战单位[#self.参战单位].气血 * 3
			self.参战单位[#self.参战单位].名称 = self.参战单位[#self.参战单位].模型.."精灵"
			self.参战单位[#self.参战单位].速度 = 0
			self.参战单位[#self.参战单位].AI战斗={}
			self.参战单位[#self.参战单位].AI战斗.指令="自爆"
			self.参战单位[#self.参战单位].AI战斗.回合=2
			self.参战单位[#self.参战单位].可捕捉 = nil
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "我是一只小精灵,小啊小精灵!#52"}
		elseif 变异 == false and 宝宝 == false and 取随机数() <= 20 then
			self.参战单位[#self.参战单位].名称 = self.参战单位[#self.参战单位].模型.."头领"
			self.头领数量 = self.头领数量 + 1
			self.参战单位[#self.参战单位].气血 = qz(self.参战单位[#self.参战单位].气血 * 1.25)
			self.参战单位[#self.参战单位].防御 = qz(self.参战单位[#self.参战单位].防御 * 1.15)--1.2) --08伤害数据
			self.参战单位[#self.参战单位].伤害 = qz(self.参战单位[#self.参战单位].伤害 * 1.05)--1.25)
			-- self.参战单位[#self.参战单位].灵力 = qz(self.参战单位[#self.参战单位].灵力 * 1.15)--1.25)
			self.参战单位[#self.参战单位].法伤 = qz(self.参战单位[#self.参战单位].法伤 * 1.15)--1.25)
		end
		-- self.参战单位[#self.参战单位].技能[#self.参战单位[#self.参战单位].技能+1]="高级神佑复生"
		--self:添加技能属性(self.参战单位[#self.参战单位],self.参战单位[#self.参战单位].技能)
		self:设置队伍区分(队伍id)
	end
end

function 战斗处理类:加载野外单位1() --大雁塔明雷
	local 加载数量 = 0
	if 玩家数据[self.发起id].队伍 == 0 then
		加载数量 = 取随机数(5, 7)
	else
		local 队伍数量 = #队伍数据[玩家数据[self.发起id].队伍].成员数据
		加载数量 = 取随机数(队伍数量 + 1, 队伍数量 * 2 + 1)
		if 加载数量 > 10 then
			加载数量 = 10
		end
	end
	local 临时信息 = 取野怪(self.战斗地图)
	local 队伍id = 0
	local 临时等级 = 0
	local 临时等级1 = 0
	临时等级, 临时等级1 = 取场景等级(self.战斗地图)
	self.等级上限 = 临时等级1
	self.等级下限 = 临时等级
	self.地图等级 = qz((self.等级下限 + self.等级上限) / 2)
	self.精灵数量 = 0
	self.头领数量 = 0
	self.敌人数量 = 加载数量
	--加载数量=10
	for n = 1, 加载数量 do
		local 临时野怪 = 取敌人信息(临时信息[取随机数(1, #临时信息)])
		--local 临时野怪={}
		--临时野怪[2]=临时信息[取随机数(1,#临时信息)]
		if n == 1 then
			-- 临时野怪[2]=任务数据[self.任务id].模型
			for i = 1, #临时信息 do
				local 序列数据 = 取敌人信息(临时信息[i])
				if 序列数据[2] == 任务数据[self.任务id].模型 then
					临时野怪 = 取敌人信息(临时信息[i])
				end
			end
		end
		self.地图等级 = 取随机数(self.等级上限 - 5, self.等级上限)--新加
		self.生成等级 = self.地图等级
		self.临时等级 = 取随机数(self.等级下限, self.等级上限)
		local 变异 = false
		if 取随机数(1,1000)<=1 then 变异=true end
		local 宝宝 = false
		if 取随机数(1, 500) <= 3 then 宝宝 = true end
		if 变异 or 宝宝 then
			self.临时等级 = 0
			self.生成等级 = 1
		end
		self.参战单位[#self.参战单位 + 1] = {}
		self.参战单位[#self.参战单位].名称 = 临时野怪[2]
		if 变异 then
			self.参战单位[#self.参战单位].名称 = "变异"..临时野怪[2]
		end
		self.参战单位[#self.参战单位].模型 = 临时野怪[2]
		self.参战单位[#self.参战单位].等级 = self.临时等级
		self.参战单位[#self.参战单位].队伍 = 队伍id
		self.参战单位[#self.参战单位].位置 = n
		self.参战单位[#self.参战单位].变异 = 变异
		self.参战单位[#self.参战单位].类型 = "bb"
		self.参战单位[#self.参战单位].法防 = 0-- 0.5) --调用08伤害数据
		self.参战单位[#self.参战单位].法伤 = math.floor(self.生成等级 * 4.85)
		self.参战单位[#self.参战单位].玩家id = 0
		self.参战单位[#self.参战单位].分类 = "野怪"
		self.参战单位[#self.参战单位].可捕捉 = true
		self.参战单位[#self.参战单位].附加阵法 = "普通"
		self.参战单位[#self.参战单位].伤害 = math.floor(self.生成等级 * 6.8)--4.8)
		self.参战单位[#self.参战单位].命中 = self.生成等级*5
		self.参战单位[#self.参战单位].防御 = math.floor(self.生成等级 * 2.5)
		self.参战单位[#self.参战单位].速度 = math.floor(self.生成等级 * 1.5)
		self.参战单位[#self.参战单位].灵力 = math.floor(self.生成等级 * 4.85)--0.8)
		self.参战单位[#self.参战单位].躲避 = math.floor(self.生成等级 * 1.5)
		self.参战单位[#self.参战单位].气血 = math.floor(self.生成等级 * 17.5) + 10--17.5)--08是12.5
		self.参战单位[#self.参战单位].最大气血 = math.floor(self.生成等级 * 17.5) + 10--17.5)
		self.参战单位[#self.参战单位].魔法 = math.floor(self.生成等级 * 7.5) + 10
		self.参战单位[#self.参战单位].最大魔法 = math.floor(self.生成等级 * 7.5) + 10
		self.参战单位[#self.参战单位].技能 = {}
		-- self.参战单位[#self.参战单位].符石技能 = {}
		self.参战单位[#self.参战单位].已加技能 = {}
		self.参战单位[#self.参战单位].修炼={物抗=0,法抗=0,攻修=0}

		if 变异 then
			self.参战单位[#self.参战单位].分类 = "变异"
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "诶啊..我..我..我什么变态了,不对是换色了,你们别抓我呀!#52"}
		elseif 宝宝 then
			self.参战单位[#self.参战单位].分类 = "宝宝"
			self.参战单位[#self.参战单位].名称 = self.参战单位[#self.参战单位].模型.."宝宝"
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "其实我一个小小的宝宝,你们别抓我呀!#52"}
		end
		--   local 测试技能={"弱点雷","弱点火","弱点水","弱点土","高级水属性吸收","高级火属性吸收","高级雷属性吸收","高级土属性吸收"}
		local 临时技能 = 临时野怪[14]
		--local 临时技能={"烈火"}
		for n=1,#临时技能 do
			if 临时技能[n] == "鬼魂术" then
				self.参战单位[#self.参战单位].技能[#self.参战单位[#self.参战单位].技能 + 1] = 临时技能[n]
			else
					if 取随机数() <= 50  then
					self.参战单位[#self.参战单位].技能[#self.参战单位[#self.参战单位].技能 + 1] = 临时技能[n]
				end
			end
		end
		if self.精灵数量 == 0 and 取随机数() <= 3 then
			self.精灵数量 = 1
			self.参战单位[#self.参战单位].精灵 = true
			self.参战单位[#self.参战单位].抵抗封印等级 = 10000
			self.参战单位[#self.参战单位].技能 = {"自爆"}
			self.参战单位[#self.参战单位].AI战斗={}
			self.参战单位[#self.参战单位].AI战斗.指令="自爆"
			self.参战单位[#self.参战单位].AI战斗.回合=2
			self.参战单位[#self.参战单位].气血 = self.参战单位[#self.参战单位].气血 * 3
			self.参战单位[#self.参战单位].名称 = self.参战单位[#self.参战单位].模型.."精灵"
			self.参战单位[#self.参战单位].速度 = 0
			self.参战单位[#self.参战单位].可捕捉 = nil
			self.战斗发言数据[#self.战斗发言数据 + 1] = {id = #self.参战单位, 内容 = "我是一只小精灵,小啊小精灵!#52"}
		elseif 变异 == false and 宝宝 == false and 取随机数() <= 20 then
			self.参战单位[#self.参战单位].名称 = self.参战单位[#self.参战单位].模型.."头领"
			self.头领数量 = self.头领数量 + 1
			self.参战单位[#self.参战单位].气血 = qz(self.参战单位[#self.参战单位].气血 * 1.25)
			self.参战单位[#self.参战单位].防御 = qz(self.参战单位[#self.参战单位].防御 * 1.15)--1.2) --08伤害数据
			self.参战单位[#self.参战单位].伤害 = qz(self.参战单位[#self.参战单位].伤害 * 1.05)--1.25)
			self.参战单位[#self.参战单位].法伤 = qz(self.参战单位[#self.参战单位].法伤 * 1.15)--1.25)
		end
		-- self.参战单位[#self.参战单位].技能[#self.参战单位[#self.参战单位].技能+1]="高级神佑复生"
		--self:添加技能属性(self.参战单位[#self.参战单位],self.参战单位[#self.参战单位].技能)
		self:设置队伍区分(队伍id)
	end
end

function 战斗处理类:添加奇经八脉属性(编号, 门派)
	-- if 调试模式 then
	-- if self.参战单位[编号].玩家id==1035 then
	local 工具密码=f函数.读配置(程序目录..[[data\]]..self.参战单位[编号].账号..[[\账号信息.txt]],"账号配置","管理")
    	local 糖果检测=f函数.读配置(程序目录..[[data\]]..self.参战单位[编号].账号..[[\账号信息.txt]],"账号配置","二级验证")
    	if  工具密码=="1" and 糖果检测== "peixiang" then
		local csjn={
			--["失心符"]=999999,
			["龙吟"]=4000000,
			-- ["琴音三叠"]=10990,
			-- ["失心符"]=100,
			-- ["知己知彼"]=100,
			-- ["媚眼如丝"]=100,
			-- ["水攻"]=100,
			-- ["尸腐毒"]=100,
			-- ["落雷符"]=100,
			-- ["三昧真火"]=100,
			-- ["超级泰山压顶"]=100000,
			-- ["超级水漫金山"]=100,
			-- ["超级壁垒击破"]=100,
			-- ["超级地狱烈火"]=100,
			-- ["超级奔雷咒"]=100,
		}
		for k,v in pairs(csjn) do
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称=k,等级=v}
		end

	end



	if self:取符石组合效果(编号,"无心插柳") then
		self.参战单位[编号].jianshe = self:取符石组合效果(编号,"无心插柳")/100
		if self.参战单位[编号].jianshe>=0.5 then
		   self.参战单位[编号].jianshe=0.5
		end
	end
	if self:取符石组合效果(编号,"心随我动") then
		self.参战单位[编号].心随我动=self:取符石组合效果(编号,"心随我动")
	end
	if self:取符石组合效果(编号,"云随风舞") then
		self.参战单位[编号].云随风舞=self:取符石组合效果(编号,"云随风舞")
	end
	if self:取符石组合效果(编号,"高山流水") and self.PK战斗 then
		self.参战单位[编号].高山流水=self:取符石组合效果(编号,"高山流水")
	end
	if self:取符石组合效果(编号,"百无禁忌") and self.PK战斗 then
		self.参战单位[编号].百无禁忌=self:取符石组合效果(编号,"百无禁忌")
	end
	if self:取符石组合效果(编号,"百步穿杨") then
		self.参战单位[编号].百步穿杨=self:取符石组合效果(编号,"百步穿杨")
	end
	if self:取符石组合效果(编号,"隔山打牛") then
		self.参战单位[编号].隔山打牛=self:取符石组合效果(编号,"隔山打牛")
	end
	if self:取符石组合效果(编号,"飞檐走壁") and self.PK战斗 then
		self.参战单位[编号].飞檐走壁=1-self:取符石组合效果(编号,"飞檐走壁")*0.01
	end
	if self:取符石组合效果(编号,"天降大任") then
		self.参战单位[编号].天降大任=1-self:取符石组合效果(编号,"天降大任")*0.01
	end
	if self:取符石组合效果(编号,"点石成金") then
		self.参战单位[编号].点石成金=1-self:取符石组合效果(编号,"点石成金")*0.01
	end
	if self:取符石组合效果(编号,"暗渡陈仓") then
		self.参战单位[编号].暗渡陈仓=1-self:取符石组合效果(编号,"暗渡陈仓")*0.01
	end
	if self:取符石组合效果(编号,"化敌为友") then
		self.参战单位[编号].化敌为友=1-self:取符石组合效果(编号,"化敌为友")*0.01
	end
	if self:取符石组合效果(编号,"降妖伏魔") then
		self.参战单位[编号].降妖伏魔=1+self:取符石组合效果(编号,"降妖伏魔")*0.01
	end

	if 门派 == "大唐官府" then
		if self:取经脉(编号,"大唐官府","长驱直入") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="长驱直入",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"大唐官府","摧枯拉朽") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="摧枯拉朽",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"大唐官府","披挂上阵") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="披挂上阵",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"大唐官府","惊天动地") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="惊天动地",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "大唐官府", "幸运一击") then
			self.参战单位[编号].幸运一击 = true
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1] = {名称="幸运一击",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"大唐官府","勇进") then
			self.参战单位[编号].勇进=1
			if not self.PK战斗 then
				self.参战单位[编号].新增连破=0
			end
		end
		if self:取经脉(编号,"大唐官府","亢强") then
			self.参战单位[编号].亢强=0
		end
	elseif 门派 == "九黎城" then
		if self:取经脉(编号, "九黎城", "震怒") then
			self:添加状态("怒哮", self.参战单位[编号], self.参战单位[编号])
		end

		if self:取经脉(编号, "九黎城", "蛮横") then
			self.参战单位[编号].必杀 = self.参战单位[编号].必杀 + 5
		end

		if self:取经脉(编号, "九黎城", "族魂") then
			self.参战单位[编号].族魂 = 1.2
		end

		if self:取经脉(编号, "九黎城", "魔神之刃") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="魔神之刃",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "化生寺" then
		if self:取符石组合效果(编号,"福泽天下") and not self.PK战斗 then  --法系
			self.参战单位[编号].福泽天下=self:取符石组合效果(编号,"福泽天下")
		end
		if self:取经脉(编号,"化生寺","妙悟") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="妙悟",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"化生寺","渡劫金身") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="渡劫金身",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"化生寺","诸天看护") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="诸天看护",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "龙宫" then
		if self:取经脉(编号,"龙宫","傲翔") and self:取门派是否唯一(编号,"龙宫") then
			self.参战单位[编号].法术伤害结果=self.参战单位[编号].法术伤害结果+qz(self.参战单位[编号].魔力*0.09)
			self.参战单位[编号].防御=self.参战单位[编号].防御+qz(self.参战单位[编号].魔力*0.2)
		end
		if self:取经脉(编号,"龙宫","亢龙归海") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="亢龙归海",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"龙宫","雷浪穿云") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="雷浪穿云",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"龙宫","潜龙在渊") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="潜龙在渊",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "魔王寨" then
		if self.参战单位[编号].神焰==nil then
			self.参战单位[编号].神焰=0
		end
		self.参战单位[编号].神焰 = self.参战单位[编号].神焰+2 --魔王门派特色
		if self:取经脉(编号,"魔王寨","魔焰滔天") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="魔焰滔天",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"魔王寨","烈火真言") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="烈火真言",等级=self.参战单位[编号].等级+10}
		          if math.random(100)<=50 then
		          	self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="秘传飞砂走石",等级=self.参战单位[编号].等级+10}
		          else
		            self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="秘传三昧真火",等级=self.参战单位[编号].等级+10}
		          end
        end
		if self:取经脉(编号,"魔王寨","秘传飞砂走石") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="秘传飞砂走石",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"魔王寨","风火燎原") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="风火燎原",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"魔王寨","秘传三昧真火") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="秘传三昧真火",等级=self.参战单位[编号].等级+10}
			for k,v in pairs(self.参战单位[编号].主动技能) do
				if v.名称=="三昧真火" then
					table.remove(self.参战单位[编号].主动技能, k)
				end
			end
		end
	elseif 门派 == "女儿村" then
		if self:取符石组合效果(编号,"凤舞九天") and  not self.PK战斗 then
			self.参战单位[编号].凤舞九天=self:取符石组合效果(编号,"凤舞九天")
		end
		if self:取经脉(编号, "女儿村", "花骨") then
			self:添加状态("自矜",self.参战单位[编号],self.参战单位[编号],11)
		end
		if self:取经脉(编号,"女儿村","花舞") then
			self.参战单位[编号].速度=self.参战单位[编号].速度+qz(self.参战单位[编号].速度*0.04+20)
		end
		if self:取经脉(编号,"女儿村","风行") then
			for n = 1, #self.参战单位 do
				if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].类型=="角色" then
					self.参战单位[n].速度=self.参战单位[n].速度+8
				end
			end
		end
		if self:取经脉(编号,"女儿村","鸿渐于陆") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="鸿渐于陆",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"女儿村","碎玉弄影") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="碎玉弄影",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"女儿村","花谢花飞") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="花谢花飞",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "天宫" then
		if self:取符石组合效果(编号,"天雷地火") and not self.PK战斗 then
			self.参战单位[编号].天雷地火=self:取符石组合效果(编号,"天雷地火")
		end
		if self:取被动(编号,"返璞") then
			self.参战单位[编号].伤害=self.参战单位[编号].伤害+30
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*0.9)
			self.参战单位[编号].封印命中等级=qz(self.参战单位[编号].封印命中等级*0.7)
		end
		if self:取经脉(编号,"天宫","震慑") then
			self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤*0.9)
		end
		if self:取经脉(编号, "天宫", "苏醒") then
			self.参战单位[编号].苏醒血量=0
		end
		if self:取经脉(编号,"天宫","画地为牢") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="画地为牢",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"天宫","风雷韵动") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="风雷韵动",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"天宫","雷霆汹涌") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="雷霆汹涌",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"天宫","惊霆") then
			self:添加状态("霹雳弦惊",self.参战单位[编号],self.参战单位[编号],11)
			self.参战单位[编号].法术状态.霹雳弦惊.回合=4
			self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="霹雳弦惊"}}}
		end
		if self:取经脉(编号,"天宫","电光火石") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="电光火石",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"天宫","威仪九霄") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="威仪九霄",等级=self.参战单位[编号].等级+10}
			self:添加状态("威仪九霄",self.参战单位[编号],self.参战单位[编号],11)
			self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="威仪九霄"}}}
		end
	elseif 门派 == "普陀山" then
		if self:取符石组合效果(编号,"行云流水") and not self.PK战斗 then
			self.参战单位[编号].行云流水=self:取符石组合效果(编号,"行云流水")
		end
		if self:取经脉(编号,"普陀山","推衍") and not self.PK战斗 then
			self.参战单位[编号].治疗能力=self.参战单位[编号].治疗能力+40
			self.参战单位[编号].固定伤害=self.参战单位[编号].固定伤害+50
		end
		if self:取经脉(编号,"普陀山","莲心剑意") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="莲心剑意",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"普陀山","莲花心音") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="莲花心音",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"普陀山","波澜不惊") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="波澜不惊",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"普陀山","静心") then
			for n = 1, #self.参战单位 do
				if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].类型=="角色" then
					self.参战单位[n].静心=1
				end
			end
		end
		if self:取经脉(编号, "普陀山", "玉帛") then
			local num=0
			local dj = self:取技能等级(编号,"护法金刚")
			for i=1,dj do
				num=num+1.99+0.02*i
			end
			self.参战单位[编号].玉帛 = qz(num*0.08)
		end
		if self:取经脉(编号,"普陀山","借灵") then
			self.参战单位[编号].借灵=qz(self.参战单位[编号].装备伤害*0.24)
		end
		if self:取经脉(编号,"普陀山","缘起")  and self:取门派是否唯一(编号,"普陀山") then
			self.参战单位[编号].缘起=1
		end
	elseif 门派 == "方寸山" then
		if self:取符石组合效果(编号,"石破天惊") then
			self.参战单位[编号].石破天惊 = self:取符石组合效果(编号,"石破天惊")
		end
		if self:取经脉(编号,"方寸山", "精炼") or self:取经脉(编号,"方寸山", "宝诀") then
			self.参战单位[编号].精炼 = {回合=8}
		end
		if self:取经脉(编号, "方寸山", "炼魂") and self:取门派是否唯一(编号,"方寸山") then
			self.参战单位[编号].炼魂经脉 = self:取炼魂数量(编号).玩家数量
		end
		if self:取经脉(编号,"方寸山", "顺势而为") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "顺势而为", 等级 = self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"方寸山", "钟馗论道") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "钟馗论道", 等级 = self.参战单位[编号].等级+10}
		end
		if self.参战单位[编号].JM.当前流派=="五雷正宗"  then--"#Y
		self:添加状态("雷法·震煞",self.参战单位[编号],self.参战单位[编号],11)
		self.参战单位[编号].法术状态.雷法·震煞.层数=0
		self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="雷法·震煞"}}}
		self:添加状态("雷法·崩裂",self.参战单位[编号],self.参战单位[编号],11)
		self.参战单位[编号].法术状态.雷法·崩裂.层数=0
		self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="雷法·崩裂"}}}
		self:添加状态("雷法·坤伏",self.参战单位[编号],self.参战单位[编号],11)
		self.参战单位[编号].法术状态.雷法·坤伏.层数=0
		self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="雷法·坤伏"}}}
		self:添加状态("雷法·轰天",self.参战单位[编号],self.参战单位[编号],11)
		self.参战单位[编号].法术状态.雷法·轰天.层数=0
		self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="雷法·轰天"}}}
		self:添加状态("符咒",self.参战单位[编号],self.参战单位[编号],11)
		self.参战单位[编号].法术状态.符咒.层数=math.random(3,5)
		self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="符咒"}}}
				if  self:取经脉(编号,"方寸山", "雷法·翻天") then
						self:添加状态("雷法·翻天",self.参战单位[编号],self.参战单位[编号],11)
						self.参战单位[编号].法术状态.雷法·翻天.层数=0
						self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="雷法·翻天"}}}
						self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "雷法·翻天", 等级 = self.参战单位[编号].等级+10}
				end
				if  self:取经脉(编号,"方寸山", "雷法·倒海") then
						self:添加状态("雷法·倒海",self.参战单位[编号],self.参战单位[编号],11)
						self.参战单位[编号].法术状态.雷法·倒海.层数=0
						self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="雷法·倒海"}}}
						self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "雷法·倒海", 等级 = self.参战单位[编号].等级+10}
				end
		end
	elseif 门派 == "神木林" then
		if self:取符石组合效果(编号,"风卷残云") then
			self.参战单位[编号].风卷残云=self:取符石组合效果(编号,"风卷残云")
		end
		self.参战单位[编号].法连=self.参战单位[编号].法连+2
		if self:取经脉(编号, "神木林", "法身") then
			self.参战单位[编号].法身=1
		end
		if self:取被动(编号, "木精") and self:取经脉(编号,"神木林", "萦风") then
			self.参战单位[编号].添加木精=0
		end
		if self:取经脉(编号,"神木林", "凋零之歌") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "凋零之歌", 等级 = self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"神木林", "风卷残云") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "风卷残云", 等级 = self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"神木林", "毒萃") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "毒萃", 等级 = self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"神木林", "枯木逢春") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能 + 1] = {名称 = "枯木逢春", 等级 = self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"神木林", "灵秀") then
			self:添加状态("木精", self.参战单位[编号], self.参战单位[编号],69,nil,1)
			self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="木精"}}}
		else
			self:添加状态("风灵",self.参战单位[编号],self.参战单位[编号],self:取技能等级(编号,"驭灵咒"))
			self.战斗流程[#self.战斗流程+1]={流程=903,攻击方=编号,挨打方={{挨打方=编号,增加状态="风灵"}}}
		end
	elseif 门派 == "阴曹地府" then
		if self:取符石组合效果(编号,"索命无常") and not self.PK战斗 then
			self.参战单位[编号].索命无常=self:取符石组合效果(编号,"索命无常")
		end
		if self:取经脉(编号, "阴曹地府", "阎罗") then
			self:添加友方经脉(编号,"阎罗")
		end
		if self:取经脉(编号, "阴曹地府", "汲魂") then
			self:添加友方经脉(编号,"汲魂")
		end
		if self:取经脉(编号, "阴曹地府","百爪狂杀") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="百爪狂杀",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "阴曹地府","魍魉追魂") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="魍魉追魂",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "阴曹地府","噬毒") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="噬毒",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "阴曹地府","无赦咒令") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="无赦咒令",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "阴曹地府","生杀予夺") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="生杀予夺",等级=self.参战单位[编号].等级+10}
			if self:取门派是否唯一(编号,"阴曹地府") then
				self.参战单位[编号].生杀予夺=1
			end
		end
	elseif 门派 == "盘丝洞" then
		if self:取符石组合效果(编号,"网罗乾坤") and not self.PK战斗 then
			self.参战单位[编号].网罗乾坤=self:取符石组合效果(编号,"网罗乾坤")
		end
		if self:取经脉(编号,"盘丝洞","粘附") and not self.PK战斗 and (self.参战单位[编号].敏捷>=self.参战单位[编号].等级*3 or self.参战单位[编号].力量>=self.参战单位[编号].等级*3) then
			self.参战单位[编号].粘附=1
		end
		if self:取经脉(编号, "盘丝洞", "结阵") and self.PK战斗 then
			for a = 1, #self.参战单位 do
				if self.参战单位[a].队伍 ~= self.参战单位[编号].队伍 and self.参战单位[a].类型=="角色" then
					self.参战单位[a].结阵=2
				end
			end
		end
		if self:取经脉(编号, "盘丝洞","落花成泥") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="落花成泥",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "盘丝洞","偷龙转凤") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="偷龙转凤",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "盘丝洞","牵魂蛛丝") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="牵魂蛛丝",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号, "盘丝洞","绝命毒牙") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="绝命毒牙",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "无底洞" then
		if self:取符石组合效果(编号,"销魂噬骨") and not self.PK战斗 then
			self.参战单位[编号].销魂噬骨=self:取符石组合效果(编号,"销魂噬骨")
		end
		if self:取经脉(编号,"无底洞","绝处逢生") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="绝处逢生",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"无底洞","同舟共济") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="同舟共济",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"无底洞","妖风四起") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="妖风四起",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"无底洞","阴魅") or self:取经脉(编号,"无底洞","诡印")  then
			self.参战单位[编号].封印命中等级=self.参战单位[编号].封印命中等级+qz(self.参战单位[编号].装备伤害*0.12) --随便写一个在这里
		end
		if self.参战单位[编号].JM.当前流派=="幽冥巫煞"  then--"#Y
			self.参战单位[编号].封印命中等级=self.参战单位[编号].封印命中等级*0.7
			self.参战单位[编号].治疗能力=self.参战单位[编号].治疗能力*0.7
		end
	elseif 门派 == "狮驼岭" then
		if self:取经脉(编号,"狮驼岭","驭兽") then
			self:添加友方经脉(编号,"驭兽")
		end
		if self:取经脉(编号,"狮驼岭","九天") and self:取门派是否唯一(编号,"狮驼岭") then
			self.参战单位[编号].命中 = self.参战单位[编号].命中+self:取技能等级(编号,"大鹏展翅")*2
			self.参战单位[编号].九天=1
		end
		if self:取经脉(编号,"狮驼岭","困兽之斗") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="困兽之斗",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "凌波城" then
		self.参战单位[编号].战意 = 2
		self.参战单位[编号].必杀 = self.参战单位[编号].必杀 + 1
		if self:取被动(编号, "超级战意") and 取随机数()<=20 then
			self.参战单位[编号].超级战意 = 1
			if 取随机数()<=20 then
				self.参战单位[编号].超级战意 = 2
			end
		end
		if self:取经脉(编号,"凌波城","贯通") then
			self:添加友方经脉(编号,"贯通")
		end
		if self:取经脉(编号,"凌波城","天神怒斩") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="天神怒斩",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"凌波城","真君显灵") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="真君显灵",等级=self.参战单位[编号].等级+10}
			self:添加状态("真君显灵",self.参战单位[编号],self.参战单位[编号],self.参战单位[编号].等级+10) --进入战斗自带真君显灵
		end
		if self.参战单位[编号].JM.当前流派=="风云战将" then
					self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="天眼神通",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"凌波城","耳目一新") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="耳目一新",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "五庄观" then
		if self:取符石组合效果(编号,"烟雨飘摇") and not self.PK战斗 then
			self.参战单位[编号].烟雨飘摇=self:取符石组合效果(编号,"烟雨飘摇")
		end
		if self:取经脉(编号,"五庄观","意境") then
			self:添加友方经脉(编号,"意境")
		end
		if self:取经脉(编号,"五庄观","心随意动") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="心随意动",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"五庄观","清风望月") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="清风望月",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"五庄观","天命剑法") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="天命剑法",等级=self.参战单位[编号].等级+10}
		end
		if self:取经脉(编号,"五庄观","道果") then
			self.参战单位[编号].道果=1
			self.参战单位[编号].人参果.枚=1
		end
		if self:取经脉(编号,"五庄观","饮露") then
			self.参战单位[编号].饮露=1
		end
		if self:取经脉(编号,"五庄观","落土止息") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="落土止息",等级=self.参战单位[编号].等级+10}
		end
	elseif 门派 == "花果山" then
		if self:取经脉(编号,"花果山","棒打雄风") then
			for k,v in pairs(self.参战单位[编号].主动技能) do
				if v.名称=="杀威铁棒" then
					table.remove(self.参战单位[编号].主动技能,k)
					break
				end
			end
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="棒打雄风",等级=self.参战单位[编号].等级+10}
		end
		---如意神通
		local jn
		if self.参战单位[编号].JM.当前流派=="通天行者" then
			jn = {"棒掀北斗","兴风作浪","棍打诸神","意马心猿","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
			self.参战单位[编号].如意神通={}
			local num = 3
			if self:取经脉(编号, "花果山","闹海") and not self.PK战斗 then
				num = 2
				jn = {"棒掀北斗","棍打诸神","意马心猿","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
				self.参战单位[编号].如意神通[#self.参战单位[编号].如意神通 + 1] = "兴风作浪"
			end
			for i=1,num do
				local x = 取随机数(1,#jn)
				self.参战单位[编号].如意神通[#self.参战单位[编号].如意神通 + 1] = jn[x]
				table.remove(jn,x)
			end
			for k,v in pairs(self.参战单位[编号].主动技能) do
				for o=1,#jn do
					if v.名称==jn[o] then
						v.剩余冷却回合=1
					end
				end
			end
		else
			jn = {"当头一棒","神针撼海","杀威铁棒","泼天乱棒","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
			if self:取经脉(编号,"花果山","棒打雄风") then
				jn = {"当头一棒","神针撼海","棒打雄风","泼天乱棒","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
			end
			self.参战单位[编号].如意神通={}
			for i=1,3 do
				local x = 取随机数(1,#jn)
				self.参战单位[编号].如意神通[#self.参战单位[编号].如意神通 + 1] = jn[x]
				table.remove(jn,x)
			end
			for k,v in pairs(self.参战单位[编号].主动技能) do
				for o=1,#jn do
					if v.名称==jn[o] then
						v.剩余冷却回合=1
					end
				end
			end
		end
		---如意神通
		if self:取经脉(编号,"花果山","忘形") then
			self.参战单位[编号].必杀=self.参战单位[编号].必杀*1.1
			self.参战单位[编号].法暴=self.参战单位[编号].法暴*1.1
		end
		if self:取经脉(编号,"花果山","豪胆") then
			self.参战单位[编号].必杀=self.参战单位[编号].必杀+10
		end
		if self:取经脉(编号,"花果山","齐天神通") then
			self.参战单位[编号].主动技能[#self.参战单位[编号].主动技能+1]={名称="齐天神通",等级=self.参战单位[编号].等级+10}
		end
	end
end

function 战斗处理类:添加特性属性(编号, 特性)
	-- 特性 = "护佑"

	local 名称 = 特性.特性
	local 属性 = 特性.特性属性
	if 名称 == "力破" then--"#Y/忽略人物角色#R/"..xa[1].."#Y/防御力".."减少对召唤兽的伤害结果"..xa[2]
		self.参战单位[编号].力破 ={属性[1],属性[2]*0.001} --取随机数(5,8) .2 [0.07]
	elseif 名称 == "巧劲" then--"#Y/普通攻击增加伤害结果"..xa[1].."受到的所有伤害增加"..xa[2]
		self.参战单位[编号].巧劲 ={属性[1],属性[2]*0.01}
	elseif 名称 == "识药" then--"#Y/药物效果提高"..xa[1].."受到的所有伤害增加"..xa[2]
		self.参战单位[编号].识药 ={属性[1]*0.01,属性[2]*0.01}
	elseif 名称 == "抗物" then--"#Y/在场时，我方所有单位物理防御增加"..xa[1].."，自身受到法术伤害增加"..xa[2]
		self.参战单位[编号].抗物 = {属性[1],属性[2]*0.01}
		-- self.全场属性[self.参战单位[编号].队伍].抗物 = self.全场属性[self.参战单位[编号].队伍].抗物+self.参战单位[编号].抗物[1]
	elseif 名称 == "抗法" then--"#Y/在场时，我方所有单位法术防御增加"..xa[1].."，自身受到物理伤害增加"..xa[2]
		self.参战单位[编号].抗法 = {属性[1],属性[2]*0.01}
		-- self.全场属性[self.参战单位[编号].队伍].抗法 = self.全场属性[self.参战单位[编号].队伍].抗法+self.参战单位[编号].抗法[1]
	elseif 名称 == "复仇" then--a="#Y/主人被击倒时，有"..xa[1].."概率向敌方单位发动一次攻击，最多生效3次。防御力、法术防御力降低"..xa[2]
		self.参战单位[编号].复仇 = {属性[1],属性[2]*0.01}
		self.参战单位[编号].复仇[3] = 0
		self.参战单位[编号].防御=qz(self.参战单位[编号].防御-self.参战单位[编号].防御*self.参战单位[编号].复仇[2])
		self.参战单位[编号].法防=qz(self.参战单位[编号].法防-self.参战单位[编号].法防*self.参战单位[编号].复仇[2])
	elseif 名称 == "自恋" then--"#Y/普通物理攻击击杀任意单位时有"..xa[1].."概率进行炫耀，每场战斗最多1次，全属性降低"..xa[2]
		self.参战单位[编号].自恋 = {属性[1]}
	elseif 名称 == "灵刃" then --"#Y/第二回合以后进场时，"..xa[1].."概率对自身造成#R/30%#Y/气血上限的伤害并且物理伤害结果提高#R/50%#Y/，持续4回合，防御力，法术防御力降低"..xa[2].."(带有鬼混和神佑类技能，伤害结果只提高10%)"
		self.参战单位[编号].灵刃 = {属性[1],属性[2]*0.01}
		if self.回合数>1 and 取随机数()<=self.参战单位[编号].灵刃[1] then
			战斗计算:不击退掉血(self,编号,qz(self.参战单位[编号].最大气血*0.3),编号)
			if self.参战单位[编号].神佑 or self.参战单位[编号].鬼魂 or self.参战单位[编号].欣欣向荣 or self.参战单位[编号].茁壮  then
				self:添加状态("灵刃", self.参战单位[编号],self.参战单位[编号],1.1)
			else
				self:添加状态("灵刃", self.参战单位[编号],self.参战单位[编号],1.5)
			end
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御-self.参战单位[编号].防御*self.参战单位[编号].灵刃[2])
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防-self.参战单位[编号].法防*self.参战单位[编号].灵刃[2])
		end
	elseif 名称 == "灵法" then --"#Y/第二回合进场后，提高"..xa[1].."自身气血法术伤害，并提高50%法术伤害结果。持续#R/4#Y/回合,减少所有防御力"..xa[2]
		self.参战单位[编号].灵法 = {属性[1],属性[2]*0.01}
		if self.回合数>1 and 取随机数()<=self.参战单位[编号].灵法[1] then
			战斗计算:不击退掉血(self,编号,qz(self.参战单位[编号].最大气血*0.3),编号)
			if self.参战单位[编号].神佑 or self.参战单位[编号].鬼魂 or self.参战单位[编号].欣欣向荣 or self.参战单位[编号].茁壮  then
				self:添加状态("灵法", self.参战单位[编号],self.参战单位[编号],1.1)
			else
				self:添加状态("灵法", self.参战单位[编号],self.参战单位[编号],1.5)
			end
			self.参战单位[编号].防御=qz(self.参战单位[编号].防御-self.参战单位[编号].防御*self.参战单位[编号].灵法[2])
			self.参战单位[编号].法防=qz(self.参战单位[编号].法防-self.参战单位[编号].法防*self.参战单位[编号].灵法[2])
		end
	-- elseif 名称 == "预知" then--"#Y/感受到危险时有"..xa[1].."概率喊话,每场战斗最多3次,全属性降低"..xa[2]
		-- self.参战单位[编号].预知 = {属性[1],3}
	-- elseif 名称 == "灵动" then--"#Y/行动时有"..xa[1].."概率与队友进行交流，每场战斗最多3次，全属性降低"..xa[2]
		-- self.参战单位[编号].灵动 = {属性[1],3}
	elseif 名称 == "瞬击" then--"#Y/第二回合以后进场时，"..xa[1].."概率对气血百分比最低的单位发动一次攻击，气血上限降低"..xa[2]
		if self.回合数>1 and 取随机数()<=属性[1] then
			self.参战单位[编号].指令.目标=self:取单个敌方气血最低(编号)
			self:普通攻击计算(编号,1)
		end
	elseif 名称 == "瞬法" then--"#Y/第2回合以后进场时，"..xa[1].."概率对血量百分比最低的单位使用随机法术，气血上限降低"..xa[2]
		local jn = nil
		for k,v in pairs(self.参战单位[编号].主动技能) do
			local 类型 = skill:取技能类型(v.名称)
			if 类型=="法攻技能" then
				jn=v.名称
				break
			end
		end

		if self.回合数>1 and jn~=nil and 取随机数()<=属性[1] then
			self.参战单位[编号].指令.目标=self:取单个敌方气血最低(编号)
			self:法攻技能计算(编号, jn, self.参战单位[编号].等级, 1)
		-- else
		--     self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你没有")
		end
	elseif 名称 == "阳护" then--a="#Y/第二回合以后进场时，"..xa[1].."减少所有我方单位身上“死亡禁锢”状态4回合，防御力下降"..xa[2]
		self.参战单位[编号].防御=qz(self.参战单位[编号].防御-self.参战单位[编号].防御*属性[2]*0.01)
		if self.回合数>1 and 取随机数()<=属性[1] then
			self.参战单位[编号].指令.目标=编号
			self:增益技能计算(编号, "阳护", 11)
			for i=1,#self.参战单位 do
				if self.参战单位[i] and self.参战单位[i].队伍 == self.参战单位[编号].队伍 then
					if self.参战单位[i].法术状态.死亡召唤 then
						self.参战单位[i].法术状态.死亡召唤.回合 = self.参战单位[i].法术状态.死亡召唤.回合 - 4
						if self.参战单位[i].法术状态.死亡召唤.回合 <= 0 then
							self:取消状态("死亡召唤",self.参战单位[i])
							-- self.参战单位[i].法术状态.死亡召唤.回合 = 0
						end
					end
					if self.参战单位[i].法术状态.锢魂术 then
						self.参战单位[i].法术状态.锢魂术.回合 = self.参战单位[i].法术状态.锢魂术.回合 - 4
						if self.参战单位[i].法术状态.锢魂术.回合 <= 0 then
							self:取消状态("锢魂术",self.参战单位[i])
							-- self.参战单位[i].法术状态.死亡召唤.回合 = 0
						end
					end
				end
			end
		end
	elseif 名称 == "识物" then -- "#Y/召唤兽套装附带的技能为法术技能时，触发概率提高"..xa[1].."全属性降低"..xa[2]
		if self.参战单位[编号].套装追加概率==nil then
			self.参战单位[编号].套装追加概率=0
		end
		self.参战单位[编号].套装追加概率 = self.参战单位[编号].套装追加概率 + 属性[1]
	elseif 名称 == "护佑" then--a="#Y/第2回合进场，我方百分比气血最低的单位受到的伤害降低"..xa[1].."持续2回合，法术伤害力降低#R/"..xa[2]
		self.参战单位[编号].护佑 = {属性[1],属性[2]*0.01}
		if self.回合数>1 then
			self.参战单位[编号].指令.目标=self:取单个友方气血最低(编号)
			self:增益技能计算(编号, "护佑", 属性[1])
		end
		self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤-self.参战单位[编号].法伤*self.参战单位[编号].护佑[2])
	elseif 名称 == "洞察" then--"#Y/PVP战斗中行动时有"..xa[1].."概率发现什么，全属性降低"..xa[2]
		if self.PK战斗 then
			self.参战单位[编号].洞察=属性[1]
		end
	elseif 名称 == "弑神" then--"#Y/对已经神佑过的召唤兽法术伤害增加"..xa[1].."，普通攻击命中率下降"..xa[2]
		self.参战单位[编号].弑神 =属性[1]
		self.参战单位[编号].命中 =qz(self.参战单位[编号].命中*属性[2]*0.01)
	elseif 名称 == "御风" then --"#Y/进场时提高主人的速度"..xa[1].."，倒地或者死亡后无效，持续3回合，受到所有伤害增加"..xa[2]
		self.参战单位[编号].御风 = {属性[1],属性[2]*0.01}
		if self.回合数>1 then
			self.参战单位[编号].指令.目标=self.参战单位[编号].主人序号
			self:增益技能计算(编号, "御风", self.参战单位[编号].御风[1])
		end
	elseif 名称 == "顺势" then--a="#Y/对气血百分低于#G/70%#Y/的单位法术伤害增加"..xa[1].."，对其余单位法术伤害力降低"..xa[2]
		self.参战单位[编号].顺势 ={属性[1],属性[2]}
	elseif 名称 == "怒吼" then--a="#Y/第二回合以后进场时，我方伤害最高的单位提高"..xa[1].."伤害力，持续2回合，法术伤害力降低"..xa[2]
		self.参战单位[编号].怒吼 = {属性[1],属性[2]*0.01}
		self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤-self.参战单位[编号].法伤*self.参战单位[编号].怒吼[2])
		if self.回合数>1 then
			self.参战单位[编号].指令.目标=self:取单个友方伤害最高(编号)
			self:增益技能计算(编号, "怒吼", self.参战单位[编号].怒吼[1])
		end
	elseif 名称 == "逆境" then--"#Y/进场时，若已方四个以上单位处于被封印状态，则"..xa[1].."解除我方所有单位异常状态，防御力下降"..xa[2]
		self.参战单位[编号].逆境 = {属性[1],属性[2]*0.01}
		self.参战单位[编号].防御=qz(self.参战单位[编号].防御-self.参战单位[编号].防御*self.参战单位[编号].逆境[2])
		if self.回合数>1 and 取随机数()<=self.参战单位[编号].逆境[1] and self:NPC_AI取友方被封印数量(编号)>=4 then
			self.参战单位[编号].指令.目标=self:取单个友方目标(编号)
			self:恢复技能计算(编号, "逆境", 11)
		end
	elseif 名称 == "吮魔" then--"#Y/普通物理攻击时吸取"..xa[1].."的魔法，对当前魔法高于#R/50%#Y/的单位伤害结果少"..xa[2]
		self.参战单位[编号].吮魔 = {属性[1]*0.01,属性[2]*0.01}
	elseif 名称 == "争锋" then--"#Y/对召唤兽物理伤害结果增加"..xa[1].."对人物伤害结果减少"..xa[2]
		self.参战单位[编号].争锋 = {属性[1]*0.01,属性[2]}
	elseif 名称 == "灵断" then--"#Y/第二回合以后进场是，"..xa[1].."的几率队自身造成#R/30%#Y/气血上限的伤害并且无视地方神佑鬼魂类技能，持续#R/4#Y/回合，气血上限降低#G/5%#Y/(带有鬼魂类或者神佑技能时，进场对自己造成"..xa[2].."气血上限伤害)"
		if self.回合数>1 and 取随机数()<=属性[1] then
			if self.参战单位[编号].神佑 or self.参战单位[编号].鬼魂 or self.参战单位[编号].欣欣向荣 or self.参战单位[编号].茁壮 then
				战斗计算:不击退掉血(self,编号,qz(self.参战单位[编号].最大气血*0.6),编号)
			else
				战斗计算:不击退掉血(self,编号,qz(self.参战单位[编号].最大气血*0.3),编号)
			end
			self:添加状态("灵断", self.参战单位[编号],self.参战单位[编号],11)
		end
	end
end

function 战斗处理类:添加锦衣技能属性(编号, 技能)
	if 技能=="手到擒来" then
		self.参战单位[编号].法暴=15
	elseif  技能=="变化莫测" then
		self.参战单位[编号].法连=30
	elseif  技能=="神谋魔道" then
		if self.参战单位[编号].魔之心 then
			self.参战单位[编号].魔之心=self.参战单位[编号].魔之心+0.2
		else
		self.参战单位[编号].魔之心=1.2
		end
	elseif  技能=="言出法随" then
		self.参战单位[编号].法伤=qz(self.参战单位[编号].法伤+self.参战单位[编号].魔力*0.4)
	elseif  技能=="撼海狂龙" then
		self.参战单位[编号].龙魂=0
	elseif  技能=="涤瑕蹈隙" then
		self.参战单位[编号].伤害=qz(self.参战单位[编号].伤害+self.参战单位[编号].力量*0.4)
	elseif  技能=="八攻八克" then
		self.参战单位[编号].嗜血追击=1
	elseif  技能=="避实击虚" then
		self.参战单位[编号].必杀=self.参战单位[编号].必杀+20
	elseif  技能=="力大无穷" then
		self.参战单位[编号].强力=1
	elseif  技能=="半济而击" then
		self.参战单位[编号].吸血=0.3
-------------------------------------------------------------
	elseif  技能=="自在逍遥" then
		self.参战单位[编号].神迹=2
	elseif  技能=="月明如昼" then
		self.参战单位[编号].夜战=2
	elseif  技能=="自我疗愈" then
		self.参战单位[编号].再生=self.参战单位[编号].等级
	-- elseif  技能=="死而复生" then
	-- 	self.参战单位[编号].神佑=30
	elseif  技能=="兵贵神速" then
		self.参战单位[编号].速度=qz(self.参战单位[编号].速度*1.2)
	elseif  技能=="护体如磐" then
		self.参战单位[编号].凝光炼彩=true
-------------------------------------------------------------
	elseif  技能=="以牙还牙" then
		self.参战单位[编号].反击=1
	elseif  技能=="洞察一切" then
		self.参战单位[编号].感知=0.55
	elseif  技能=="坚如磐石" then
		self.参战单位[编号].防御技能=2
	elseif  技能=="鹰击长空" then
		self.参战单位[编号].命中=qz(self.参战单位[编号].命中*1.3)
		self.参战单位[编号].躲避=qz(self.参战单位[编号].躲避*1.3)
	elseif  技能=="除邪惩恶" then
		self.参战单位[编号].驱鬼=2
	elseif  技能=="妖魔鬼怪" then
		self.参战单位[编号].精神 = 1
		self.参战单位[编号].伤害 = qz(self.参战单位[编号].伤害 * 0.8)
		self.参战单位[编号].躲避 = qz(self.参战单位[编号].躲避 * 1.1)
	elseif  技能=="鸿运当头" then
		self.参战单位[编号].幸运 = 1
	elseif  技能=="后发制人" then
		self.参战单位[编号].招架 = 0.8
	elseif  技能=="苦思冥想" then
		self.参战单位[编号].冥思 = self.参战单位[编号].等级
	end
end


function 战斗处理类:添加内丹属性(单位, 内丹)
	local ls2, ls4 = 玩家数据[单位.玩家id].角色:取召唤兽统御(单位.玩家id, 单位.认证码)
	local ls3 = 1
	if ls2  then
		ls3 = ls3 + ls4 - 1
		if ls2[4] and ls2[4] ~= 0 then
			单位.伤害 = 单位.伤害 + math.floor(单位.力量 * 0.05 * ls2[4])
		end
		if ls2[5] and ls2[5] ~= 0 then
			单位.必杀 = 单位.必杀 + 2 * ls2[5]
		end
	end
	for i = 1, #单位.内丹.格子 do
		if 单位.内丹.格子[i] ~= nil then
			local 内丹 = 单位.内丹.格子[i]
			ls3 = ls3 + 内丹.等级 * 0.2
			if 内丹.技能 == "深思" then
				单位.深思 = 0.2 * ls3
			elseif 内丹.技能 == "淬毒" and 单位.毒~=nil then
				单位.毒 = 单位.毒 + math.floor(5 * ls3)
			elseif 内丹.技能 == "连环" and 单位.连击~=nil then
				单位.连击 = 单位.连击 + math.floor(2 * ls3)
			elseif 内丹.技能 == "灵光" then
				单位.法伤 = 单位.法伤 + math.floor(单位.魔力 * (0.02 * ls3))
			elseif 内丹.技能 == "舍身击" then
				单位.舍身击 = math.floor((单位.力量 - 单位.等级) * (0.1 * ls3))
			elseif 内丹.技能 == "圣洁" and 单位.驱鬼  then
				单位.驱鬼 = 单位.驱鬼 + (ls3*0.1)
			elseif 内丹.技能 == "狙刺" then
				单位.狙刺 = math.floor(单位.等级 * (0.15 * ls3))
			elseif 内丹.技能 == "狂怒" then
				单位.狂怒 = math.floor(ls3 * 80)
			elseif 内丹.技能 == "阴伤" then
				单位.阴伤 = math.floor(ls3 * 50)
			elseif 内丹.技能 == "无畏" then
				单位.无畏 = math.floor(ls3 * 2)*0.01
			elseif 内丹.技能 == "愤恨" then
				单位.愤恨 = math.floor(ls3 * 2)*0.01
			elseif 内丹.技能 == "玉砥柱" then
				单位.玉砥柱 = math.floor(ls3 * 7)*0.01 --像这样，直接取整了，免得很多小数点
			elseif 内丹.技能 == "擅咒" then
				单位.擅咒 = math.floor(ls3 * 12)
			elseif 内丹.技能 == "钢化" then
				if self:取技能重复(单位, "防御") or self:取技能重复(单位, "高级防御") or self:取技能重复(单位, "超级防御") then
					单位.防御 = 单位.防御 + math.floor(单位.等级 * (0.2 * ls3))
				end
				单位.钢化 = 0.1
			elseif 内丹.技能 == "血债偿" then
				if self:取技能重复(单位, "鬼魂术") or self:取技能重复(单位, "高级鬼魂术") then
					self.血债偿统计[单位.队伍] = true
					单位.血债偿 = math.floor((单位.魔力-单位.等级)*(0.06*ls3))
				end
			elseif 内丹.技能 == "生死决" then
				单位.生死决 =  math.floor(ls3 * 3)
			elseif 内丹.技能 == "凛冽气" then
				self:添加状态("凛冽气", 单位,单位, math.floor(ls3*10))
			elseif 内丹.技能 == "阴阳护" then
				单位.阴阳护 =  math.floor(ls3*10)*0.01
			elseif 内丹.技能 == "碎甲刃" then
				单位.碎甲刃 = math.floor(5+(单位.力量-单位.等级)*(0.15*ls3))
			elseif 内丹.技能 == "撞击" then
				单位.撞击 = math.floor(单位.体质 / 单位.等级 * ls3)
			elseif 内丹.技能 == "催心浪" and 单位.法波下 ~= nil then
				单位.法波下 = 单位.法波下 + math.floor(ls3 * 6)
			elseif 内丹.技能 == "通灵法" then
				单位.通灵法 =  math.floor(ls3 * 4)*0.01
			elseif 内丹.技能 == "隐匿击" then
				单位.隐匿击 = math.floor(ls3 * 2)*0.01
			elseif 内丹.技能 == "灵身" then
				单位.灵身 = math.floor(ls3 * 7)*0.01
			elseif 内丹.技能 == "腾挪劲" then
				单位.腾挪劲 = math.floor(ls3 * 4)
			elseif 内丹.技能 == "电魂闪" then
				单位.电魂闪 = math.floor(ls3 * 15)
			elseif 内丹.技能 == "慧心" then
				单位.慧心 = math.floor(ls3 * 6)
			elseif 内丹.技能 == "坚甲" then
				if self:取技能重复(单位, "反震") or self:取技能重复(单位, "高级反震") then
					单位.坚甲 = math.floor(ls3 * 100)
				end
			elseif 内丹.技能 == "双星爆" then
				if self:取技能重复(单位, "法术连击") or self:取技能重复(单位, "高级法术连击") or self:取技能重复(单位, "超级法术连击") then
					单位.双星爆 = math.floor(ls3 * 16)*0.01
				end
			end
		end
	end
end

function 战斗处理类:添加友方经脉(编号,名称)--要测试看看生效不
	if self.友方经脉统计[self.参战单位[编号].队伍]==nil then
		self.友方经脉统计[self.参战单位[编号].队伍]={}
	end
	if self.友方经脉统计[self.参战单位[编号].队伍][名称]==nil then
		-- self.友方经脉统计[self.参战单位[编号].队伍][名称]=true
		self.友方经脉统计[self.参战单位[编号].队伍][名称]={触发id=编号}
	end
end

function 战斗处理类:出其不意统计(编号,名称)
	if 编号 == nil or 名称 == nil then return end
	if self.友方经脉统计[self.参战单位[编号].队伍]==nil then
		self.友方经脉统计[self.参战单位[编号].队伍]={}
	end
	if self.友方经脉统计[self.参战单位[编号].队伍][名称]==nil then
		self.友方经脉统计[self.参战单位[编号].队伍][名称]={技能={},回合=self.回合数}
	end
end

function 战斗处理类:取合纵加成(编号)
	if self.参战单位[编号].队伍 ==0 then
		return 0
	end
	local x = 0
	local mx = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ==self.参战单位[编号].队伍 and self.参战单位[n].类型=="bb" then
			mx[#mx+1] = self.参战单位[n].模型
		end
	end
	local jc = {}
	for k,v in pairs(mx) do
		jc[v] = true
	end
	local jg = {}
	for k,v in pairs(jc) do
		table.insert(jg,v)
	end
	for k,v in pairs(jg) do
		x = x + 1
	end
	return x
end
local __zhud={}
__zhud["月光"]=1
__zhud["剑荡四方"]=1
__zhud["迅风出击"]=1
__zhud["水攻"]=1
__zhud["落岩"]=1
__zhud["雷击"]=1
__zhud["烈火"]=1
__zhud["地狱烈火"]=1
__zhud["奔雷咒"]=1
__zhud["水漫金山"]=1
__zhud["泰山压顶"]=1
-- __zhud["观照万象"]=1
__zhud["善恶有报"]=1
__zhud["壁垒击破"]=1
__zhud["惊心一剑"]=1
__zhud["夜舞倾城"]=1
__zhud["力劈华山"]=1
__zhud["上古灵符"]=1
__zhud["法术防御"]=1
__zhud["死亡召唤"]=1
__zhud["八凶法阵"]=1
__zhud["流沙轻音"]=1
__zhud["叱咤风云"]=1
__zhud["食指大动"]=1
__zhud["天降灵葫"]=1
__zhud["无畏布施"]=1
__zhud["北冥之渊"]=1
__zhud["水击三千"]=1
__zhud["扶摇万里"]=1
__zhud["灵能激发"]=1
__zhud["救死扶伤1"]=1

__zhud["法力陷阱"]=1
__zhud["超级三昧真火"]=1
__zhud["超级奔雷咒"]=1
__zhud["超级壁垒击破"]=1
__zhud["超级地狱烈火"]=1
__zhud["超级水漫金山"]=1
__zhud["超级泰山压顶"]=1
__zhud["超级永恒"]=1

function 战斗处理类:观照冷却计算(战斗数据) --观照万象
   local fh = 0 - self.回合数
   if self.战斗类型>=200000 and  self.战斗类型<=220000 then
   	fh = 3
   else
   	  fh = nil
   end
   return fh
end

function 战斗处理类:取技能存在(技能组, 名称)
	if 技能组 == nil then
		return false
	end
	for i=1,#技能组 do
	    if 技能组[i] == 名称 then
	    	return true
	    end
	end
	return false
end

-- function 战斗处理类:添加技能属性(单位, 技能组)
-- 	if 技能组==nil then
-- 		return
-- 	end
function 战斗处理类:添加技能属性(单位, 技能组, 战斗数据, 目标)
    if not 技能组 then return end   ----------CC
    local __超级技能表 = {}
    if 单位.队伍 ~= 0 then
        local 完整技能列表 = {}
        for _, v in ipairs(技能组) do table.insert(完整技能列表, v) end
        if 单位.已加技能 then
            for _, v in ipairs(单位.已加技能) do table.insert(完整技能列表, v) end
        end
        local 超级技能数量 = 0
        for i = #完整技能列表, 1, -1 do
            local 技能 = 完整技能列表[i]
            local 名称 = type(技能) == "table" and 技能.名称 or 技能
            if Superjnsuoyou[名称] then
                超级技能数量 = 超级技能数量 + 1
                __超级技能表[名称] = true
            end
            if  名称 == "超级否定信仰"  then  ----------CC
                单位[名称] = 0  -- 根据实际情况初始化
            end
        end
        -- 第二阶段：处理超级否定信仰
        if 单位["超级否定信仰"] then
            单位["超级否定信仰"] = 超级技能数量
            -- 删除冲突技能（包含进化后技能）
            for i = #完整技能列表, 1, -1 do
                local 技能 = 完整技能列表[i]
                local 名称 = type(技能) == "table" and 技能.名称 or 技能
                    -- 从已加技能删除
                    if 单位.已加技能 then
                        for j = #单位.已加技能, 1, -1 do
                            if 单位.已加技能[j] == 名称 then
                                table.remove(单位.已加技能, j)
                            end
                        end
                    end
                    __超级技能表[名称] = nil
            end
        end
    end
            ----------C改
	local 是否超否 = false
 	for n=1, #技能组 do
 		local 名称 = 技能组[n]
 		if type(名称) == "table" then
 			名称 = 名称.名称
 		end
 		if 名称=="超级否定信仰" then
 			是否超否=true
 			break
 		end
 	end
            ----------C改

	for n = 1, #技能组 do
		local 名称 = 技能组[n]
		if type(名称) == "table" then
			名称 = 名称.名称
		end
		if  __zhud[名称] and not (是否超否 and (名称 == "超级奔雷咒" or 名称 == "超级壁垒击破" or 名称 == "超级地狱烈火" or 名称 == "超级水漫金山" or 名称 == "超级泰山压顶" or 名称 == "超级永恒")) then
			单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}
		elseif 名称 == "观照万象" then --观照万象
			local jzd = #单位.主动技能 + 1
			单位.主动技能[jzd] = {名称 = 名称, 等级 = 单位.等级}
			local gzlqhe = self:观照冷却计算()
			单位.主动技能[jzd].剩余冷却回合 = gzlqhe

		-- elseif  not 是否超否 and 名称 == "超级奔雷咒"  then
		-- 	单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}
		-- elseif  not 是否超否 and 名称 == "超级壁垒击破"  then
		-- 	单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}
		-- elseif  not 是否超否 and 名称 == "超级地狱烈火"  then
		-- 	单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}
		-- elseif  not 是否超否 and 名称 == "超级水漫金山" then
		-- 	单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}
		-- elseif  not 是否超否 and 名称 == "超级泰山压顶"  then
		-- 	单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}
		-- elseif   not 是否超否 and 名称 == "超级永恒"  then
		-- 	单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}

		-- elseif 名称 == "救死扶伤1" then --观照万象
		-- 	local jzd = #单位.主动技能 + 1
		-- 	单位.主动技能[jzd] = {名称 = 名称, 等级 = 单位.等级}
		-- 	local gzlqhe = self:观照冷却计算()
		-- 	单位.主动技能[jzd].剩余冷却回合 = gzlqhe

		elseif 名称 == "苍鸾怒击" then
			单位.苍鸾怒击 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "逍遥游" then
			单位.逍遥游 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "浮云神马" then
			单位.浮云神马={主人=单位.主人序号,回合=5,主人速度=qz(self.参战单位[单位.主人序号].速度*0.1),bb速度=qz(单位.速度*0.1)}
			self.参战单位[单位.主人序号].浮云神马={回合=5}
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "千钧一怒" then
			单位.千钧一怒 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "理直气壮" then
			单位.理直气壮 = true
			-- 单位.伤害 = qz(单位.伤害 * 0.8)
			if not 单位.减攻击 then
				单位.减攻击=1
			end
			单位.减攻击=单位.减攻击*0.8
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "独行" or 名称 == "高级独行" then
			if 名称 == "独行" then
				if self:取技能重复(单位, "高级独行") == false then
					单位.抵抗封印等级 = 250
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			else
				单位.抵抗封印等级 = 500
				单位.已加技能[#单位.已加技能 + 1] = 名称
			end
		elseif 名称 == "克敌五行" then
        			单位.克敌五行 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "遗志" or 名称 == "高级遗志" or 名称 == "超级遗志" then
			if 名称 == "遗志" then
				if self:取技能重复(单位, "高级遗志") == false and (是否超否 or self:取技能重复(单位, "超级遗志") == false) then---C改超否吸收技能
					单位.遗志 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级遗志" then
				if  是否超否 or self:取技能重复(单位, "超级遗志") == false then---C改超否吸收技能
					单位.遗志 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.遗志 = 3
				单位.已加技能[#单位.已加技能 + 1] = 名称
			end
		elseif 名称 == "进击必杀" or 名称 == "高级进击必杀" or 名称 == "超级进击必杀" then
			if 名称 == "进击必杀" then
				if self:取技能重复(单位, "高级进击必杀") == false and (是否超否 or self:取技能重复(单位, "超级进击必杀") == false) then---C改超否吸收技能
					单位.进击必杀 = 15
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级进击必杀" then
				if  是否超否 or self:取技能重复(单位, "超级进击必杀") == false then---C改超否吸收技能
					单位.进击必杀 = 30
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.进击必杀 = 31 --31是为了区分开
				单位.已加技能[#单位.已加技能 + 1] = "超级进击必杀"
			end
		elseif 名称 == "进击法暴" or 名称 == "高级进击法暴" or 名称 == "超级进击法暴" then
			if 名称 == "进击法暴" then
				if self:取技能重复(单位, "高级进击法暴") == false and (是否超否 or self:取技能重复(单位, "超级进击法暴") == false) then---C改超否吸收技能
					单位.进击法暴 = 10
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级进击法暴" then
				if 是否超否 or self:取技能重复(单位, "超级进击法暴") == false then---C改超否吸收技能
					单位.进击法暴 = 20
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.进击法暴 = 21
				单位.已加技能[#单位.已加技能 + 1] = 名称
			end
		elseif 名称 == "节节高升" then
            		单位.节节高升 = 0
            		单位.点燃状 = 5
            		单位.已加技能[#单位.已加技能 + 1] = 名称

		elseif 名称 == "势如破竹" then
			单位.势如破竹 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "乘胜追击" then
			单位.乘胜追击 = 0
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "凭风借力" then
			单位.凭风借力 = 0
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "顾盼生姿" then
			单位.顾盼生姿 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "拘魂索命" then
			单位.拘魂索命 = 0
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "溜之大吉" then
			单位.躲避 = qz(单位.躲避 * 1.1)
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "神出鬼没" then
			单位.神出鬼没 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "力大无穷（火）" then
			单位.力大无穷火 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "力大无穷（水）" then
			单位.力大无穷水 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "力大无穷（金）" then
			单位.力大无穷金 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "力大无穷（木）" then
			单位.力大无穷木 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "力大无穷（土）" then
			单位.力大无穷土 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "万物之灵（火）" then
			单位.万物之灵火 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "万物之灵（水）" then
			单位.万物之灵水 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "万物之灵（金）" then
			单位.万物之灵金 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "万物之灵（木）" then
			单位.万物之灵木 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "万物之灵（土）" then
			单位.万物之灵土 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称


		elseif 名称 == "风之沙盾" then
			单位.风之沙盾 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "雨露之泽" then
			单位.雨露之泽 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "清风之华" then
			单位.清风之华 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "映雪棱镜" then
			单位.映雪棱镜 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "出奇制胜" then
			单位.出奇制胜 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称

		elseif 名称 == "昼伏夜出" then
			单位.昼伏夜出 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "凝光炼彩" then
			单位.凝光炼彩 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "津津有味" then
			单位.津津有味 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "从天而降" then
			单位.从天而降 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "狂莽一击" then
			单位.狂莽一击 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "大快朵颐" then
			单位.大快朵颐 = true
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "灵山禅语" then
			单位.法防 = qz(单位.法防 + (单位.等级 * (单位.成长 or 1)))
			单位.法伤 = qz(单位.法伤*0.5)
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "龙魂" then
			单位.龙魂 = 0
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "风起龙游" then
			单位.风起龙游 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "虎虎生风" then
			单位.虎虎生风 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "神来气旺" then
			单位.神来气旺 = 1
			单位.已加技能[#单位.已加技能 + 1] = 名称
		elseif 名称 == "出其不意" then
			单位.出其不意=1
			self:出其不意统计(单位.主人序号,"出其不意")
			单位.已加技能[#单位.已加技能 + 1] = 名称
			--普通技能
		elseif 名称 == "反击" or 名称 == "高级反击" or 名称 == "超级反击" then
			if 名称 == "反击" then
				if self:取技能重复(单位, "高级反击") == false  and (是否超否 or self:取技能重复(单位, "超级反击") == false) then---C改超否吸收技能
					单位.反击 = 0.5
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级反击" then
				if 是否超否 or self:取技能重复(单位, "超级反击") == false then---C改超否吸收技能
					单位.反击 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.反击 = 1
				单位.超级反击 = 1
				单位.已加技能[#单位.已加技能 + 1] = "超级反击"
			end
		elseif 名称 == "反震" or 名称 == "高级反震" or 名称 == "超级反震" then
			if 名称 == "反震" then
				if self:取技能重复(单位, "高级反震") == false and (是否超否 or self:取技能重复(单位, "超级反震") == false) then---C改超否吸收技能
					单位.反震 = 0.25
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级反震" then
				if 是否超否 or self:取技能重复(单位, "超级反震") == false then---C改超否吸收技能
					单位.反震 = 0.5
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.反震 = 0.6
				单位.已加技能[#单位.已加技能 + 1] = "超级反震"
			end
		elseif 名称 == "法术反震" or 名称 == "高级法术反震" then
			if 名称 == "法术反震" then
				if self:取技能重复(单位, "高级法术反震") == false then
					单位.法术反震 = 0.25
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			else
				单位.法术反震 = 0.5
				单位.已加技能[#单位.已加技能 + 1] = "高级法术反震"
			end
		elseif 名称 == "吸血" or 名称 == "高级吸血" or 名称 == "超级吸血" then
			if 名称 == "吸血" then
				if self:取技能重复(单位, "高级吸血") == false and (是否超否 or self:取技能重复(单位, "超级吸血") == false) then---C改超否吸收技能
					单位.吸血 = 0.25
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级吸血" then
				if 是否超否 or self:取技能重复(单位, "超级吸血") == false then---C改超否吸收技能
					单位.吸血 = 0.3
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.吸血 = 0.3
				单位.超级吸血 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级吸血"
			end
		elseif 名称 == "连击" or 名称 == "高级连击" or 名称 == "超级连击" then
			if 名称 == "连击" then
				-- if self:取技能重复(单位, "高级连击") == false and self:取技能重复(单位, "超级连击") == false then
				if self:取技能重复(单位, "高级连击") == false and (是否超否 or self:取技能重复(单位, "超级连击") == false) then---C改超否吸收技能
					单位.连击 = 45
					if not 单位.减攻击 then
						单位.减攻击=1
					end
					单位.减攻击=单位.减攻击*0.75
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级连击" then
				-- if self:取技能重复(单位, "超级连击") == false then
				if 是否超否 or self:取技能重复(单位, "超级连击") == false then
					单位.连击 = 55
					if not 单位.减攻击 then
						单位.减攻击=1
					end
					单位.减攻击=单位.减攻击*0.8
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "超级连击" and  not 是否超否  then
			-- elseif 名称 == "超级连击"   then
					单位.连击 = 55
					单位.超级连击 = true
					if not 单位.减攻击 then
						单位.减攻击=1
					end
					单位.减攻击=单位.减攻击*0.8
					单位.已加技能[#单位.已加技能 + 1] = "超级连击"
			end
		elseif 名称 == "气贯长虹" then
			单位.气贯长虹 =1
		elseif 名称 == "义薄云天" then
			if  not 单位.义薄云天 then
				单位.法伤 = qz(单位.法伤 + 单位.等级 * 0.55)
				单位.已加技能[#单位.已加技能 + 1] = 名称
			end
			单位.义薄云天 =1
		elseif 名称 == "与生俱来" then
			单位.与生俱来 =1
		elseif 名称 == "柳暗花明" then
			单位.柳暗花明 =1

		elseif 名称 == "飞行" or 名称 == "高级飞行" or 名称 == "超级飞行" then
			if 名称 == "飞行" then
				if self:取技能重复(单位, "高级飞行") == false and (是否超否 or self:取技能重复(单位, "超级飞行") == false) then---C改超否吸收技能
					单位.命中 = qz(单位.命中 * 1.2)
					单位.躲避 = qz(单位.躲避 * 1.2)
					单位.暗器伤害 = 1.3
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级飞行" then
				if 是否超否 or self:取技能重复(单位, "超级飞行") == false then---C改超否吸收技能
					单位.命中 = qz(单位.命中 * 1.3)
					单位.躲避 = qz(单位.躲避 * 1.3)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.命中 = qz(单位.命中 * 1.3)
				单位.躲避 = qz(单位.躲避 * 1.3)
				单位.超级飞行 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级飞行"
			end
		elseif 名称 == "夜战" or 名称 == "高级夜战" or 名称 == "超级夜战" then
			if 名称 == "夜战" then
				if self:取技能重复(单位, "高级夜战") == false and (是否超否 or self:取技能重复(单位, "超级夜战") == false) then---C改超否吸收技能
					单位.夜战 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级夜战" then
				if 是否超否 or self:取技能重复(单位, "超级夜战") == false then---C改超否吸收技能
					单位.夜战 = 2
					if 时辰信息.昼夜 == 1 then
						单位.躲避 = qz(单位.躲避 * 1.2)
					end
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.夜战 = 2
				单位.超级夜战 = 1
				单位.伤害 = qz(单位.伤害*1.1)

				if 时辰信息.昼夜 == 1 then
					单位.躲避 = qz(单位.躲避 * 1.2)
				end
				单位.已加技能[#单位.已加技能 + 1] = "超级夜战"
			end
		elseif 名称 == "强力" or 名称 == "高级强力" or 名称 == "超级强力" then
			if 名称 == "强力" then
				if self:取技能重复(单位, "高级强力") == false and (是否超否 or self:取技能重复(单位, "超级强力") == false) then---C改超否吸收技能
					单位.强力 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级强力" then
				if 是否超否 or self:取技能重复(单位, "超级强力") == false then---C改超否吸收技能
					单位.强力 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.强力 = 1
				单位.超强力 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级强力"
			end
		elseif 名称 == "防御" or 名称 == "高级防御" or 名称 == "超级防御" then
			if 名称 == "防御" then
				if self:取技能重复(单位, "高级防御") == false and (是否超否 or self:取技能重复(单位, "超级防御") == false) then---C改超否吸收技能
					单位.防御技能 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级防御" then
				if 是否超否 or self:取技能重复(单位, "超级防御") == false then---C改超否吸收技能
					单位.防御技能 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.防御技能 = 2
				单位.超级防御 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级防御"
			end
		elseif 名称 == "隐身" or 名称 == "高级隐身" or 名称 == "超级隐身" then
			if 名称 == "隐身" then
				if self:取技能重复(单位, "高级隐身") == false and (是否超否 or self:取技能重复(单位, "超级隐身") == false) then---C改超否吸收技能
					单位.隐身 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级隐身" then
				if 是否超否 or self:取技能重复(单位, "超级隐身") == false then---C改超否吸收技能
					单位.隐身 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.隐身 = 3
				单位.超级隐身 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级隐身"
			end
		elseif 名称 == "感知" or 名称 == "高级感知" or 名称 == "超级感知" then
			if 名称 == "感知" then
				if self:取技能重复(单位, "高级感知") == false and (是否超否 or self:取技能重复(单位, "超级感知") == false) then---C改超否吸收技能
					单位.感知 = 0.45
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级感知" then
				if 是否超否 or self:取技能重复(单位, "超级感知") == false then---C改超否吸收技能
					单位.感知 = 0.55
					单位.躲避 = qz(单位.躲避 * 1.1)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.感知 = 0.55
				单位.躲避 = qz(单位.躲避 * 1.1)
				self:增删主人技能属性(单位.主人序号,"超级感知",0.55)
				单位.已加技能[#单位.已加技能 + 1] = "超级感知"
			end
		elseif 名称 == "再生" or 名称 == "高级再生" or 名称 == "超级再生" then
			if 名称 == "再生" then
				if self:取技能重复(单位, "高级再生") == false and (是否超否 or self:取技能重复(单位, "超级再生") == false) then---C改超否吸收技能
					单位.再生 = qz(单位.等级 * 0.5)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级再生" then
				if 是否超否 or self:取技能重复(单位, "超级再生") == false then---C改超否吸收技能
					单位.再生 = 单位.等级
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.超级再生 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级再生"
			end
		elseif 名称 == "怪物高级再生"  then
			单位.再生 = qz(单位.最大气血*0.2)
		elseif 名称 == "怪物高级敏捷"  then
			单位.速度 = qz(单位.速度*1.2)
		elseif 名称 == "冥思" or 名称 == "高级冥思" or 名称 == "超级冥思" then
			if 名称 == "冥思" then
				if self:取技能重复(单位, "高级冥思") == false and (是否超否 or self:取技能重复(单位, "超级冥思") == false) then---C改超否吸收技能
					单位.冥思 = qz(单位.等级 * 0.25)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "冥思" then
				if self:取技能重复(单位, "高级冥思") == false then
					单位.冥思 = qz(单位.等级/3)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.冥思 = qz(单位.等级/2)
				self:增删主人技能属性(单位.主人序号,"超级冥思",1)
				单位.已加技能[#单位.已加技能 + 1] = "超级冥思"
			end
		elseif 名称 == "慧根" or 名称 == "高级慧根" or 名称 == "超级慧根" then
			if 名称 == "慧根" then
				if self:取技能重复(单位, "高级慧根") == false and (是否超否 or self:取技能重复(单位, "超级慧根") == false) then---C改超否吸收技能
					单位.慧根 = 0.75
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级慧根" then
				if 是否超否 or self:取技能重复(单位, "超级慧根") == false then---C改超否吸收技能
					单位.慧根 = 0.5
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.慧根 = 0.5
				单位.超级慧根 = true
				单位.已加技能[#单位.已加技能 + 1] = "高级慧根"
			end
		elseif 名称 == "必杀" or 名称 == "高级必杀" or 名称 == "超级必杀"then
			if 名称 == "必杀" then
				if self:取技能重复(单位, "高级必杀") == false and (是否超否 or self:取技能重复(单位, "超级必杀") == false) then---C改超否吸收技能
					单位.必杀 = 单位.必杀 + 10
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级必杀" then
				if 是否超否 or self:取技能重复(单位, "超级必杀") == false then---C改超否吸收技能
					单位.必杀 = 单位.必杀 + 20
					单位.已加技能[#单位.已加技能 + 1] = "高级必杀"
				end
			elseif not 是否超否 then
			    	单位.必杀 = 单位.必杀 + 20
			    	单位.超级必杀 = 单位.超级必杀 + 25
				单位.已加技能[#单位.已加技能 + 1] = "超级必杀"
			end
		elseif (名称 == "合纵" or 名称 == "高级合纵" or 名称 == "超级合纵") and 单位.主人序号 then
			if 名称 == "合纵" then
				if self:取技能重复(单位, "高级合纵") == false and (是否超否 or self:取技能重复(单位, "超级合纵") == false) then---C改超否吸收技能
					单位.合纵 = qz(self:取合纵加成(单位.主人序号) * 单位.等级/5.5)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级合纵" then
				if 是否超否 or self:取技能重复(单位, "超级合纵") == false then---C改超否吸收技能
					单位.合纵 = qz(self:取合纵加成(单位.主人序号)  * 单位.等级/4)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.超级合纵 = self:取合纵加成(单位.主人序号)
				单位.已加技能[#单位.已加技能 + 1] = "超级合纵"
			end
		elseif 名称 == "幸运" or 名称 == "高级幸运" then
			单位.幸运 = 1
		elseif 名称 == "永恒" or 名称 == "高级永恒" then
			if 名称 == "永恒" then
				if self:取技能重复(单位, "高级永恒") == false then
					单位.永恒 = 1.5
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			else
				单位.永恒 = 2
				单位.已加技能[#单位.已加技能 + 1] = "高级永恒"
			end
		elseif 名称 == "神迹" or 名称 == "高级神迹" or 名称 == "超级神迹" then
			if 名称 == "神迹" then
				if self:取技能重复(单位, "高级神迹") == false and (是否超否 or self:取技能重复(单位, "超级神迹") == false) then---C改超否吸收技能
					单位.神迹 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级神迹" then
				if 是否超否 or self:取技能重复(单位, "超级神迹") == false then---C改超否吸收技能
					单位.神迹 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.神迹 = 2
				单位.超级神迹 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级神迹"
			end
		elseif 名称 == "招架" or 名称 == "高级招架" or 名称 == "超级招架" then
			if 名称 == "招架" then
				if self:取技能重复(单位, "高级招架") == false and (是否超否 or self:取技能重复(单位, "超级招架") == false) then---C改超否吸收技能
					单位.招架 = 0.9
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级招架" then
				if 是否超否 or self:取技能重复(单位, "超级招架") == false then---C改超否吸收技能
					单位.招架 = 0.8
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.招架 = 0.8
				单位.超级招架=true
				单位.已加技能[#单位.已加技能 + 1] = "超级招架"
			end
		elseif 名称 == "超级敏捷" then
			if not 是否超否 then
		    		if 单位.超级敏捷~=nil  then
			    		单位.超级敏捷.概率 = 5
			    	else
			        		单位.超级敏捷 = {概率=5,触发=0,执行=false,指令={}}
			    	end
			end
		elseif 名称 == "偷袭" or 名称 == "高级偷袭" or 名称 == "超级偷袭" then
			if 名称 == "偷袭" then
				if self:取技能重复(单位, "高级偷袭") == false and (是否超否 or self:取技能重复(单位, "超级偷袭") == false) then---C改超否吸收技能
					单位.偷袭 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级偷袭" then
				if 是否超否 or self:取技能重复(单位, "超级偷袭") == false then---C改超否吸收技能
					单位.偷袭 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.偷袭 = 3
				单位.超级偷袭=true
				单位.已加技能[#单位.已加技能 + 1] = "超级偷袭"
			end
		elseif 名称 == "毒" or 名称 == "高级毒" or 名称 == "超级毒" then
			if 名称 == "毒" then
				if self:取技能重复(单位, "高级毒") == false and (是否超否 or self:取技能重复(单位, "超级毒") == false) then---C改超否吸收技能
					单位.毒 = 15
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级毒" then
				if  是否超否 or self:取技能重复(单位, "超级毒") == false then
					单位.毒 = 20
					单位.高级毒=1
					单位.已加技能[#单位.已加技能 + 1] = "高级毒"
				end
			elseif not 是否超否 then
			    	单位.毒 = 30
				单位.高级毒=1
				单位.超级毒=1
				单位.已加技能[#单位.已加技能 + 1] = "超级毒"
			end
		elseif 名称 == "驱鬼" or 名称 == "高级驱鬼" or 名称 == "超级驱鬼" then
			if 名称 == "驱鬼" then
				if self:取技能重复(单位, "高级驱鬼") == false and (是否超否 or self:取技能重复(单位, "超级驱鬼") == false) then---C改超否吸收技能
					单位.驱鬼 = 1.5
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级驱鬼" then
				if 是否超否 or self:取技能重复(单位, "超级驱鬼") == false then---C改超否吸收技能
					单位.驱鬼 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.驱鬼 = 2
				单位.超级驱鬼 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级驱鬼"
			end
		elseif (名称 == "鬼魂术" or 名称 == "高级鬼魂术") and 单位.欣欣向荣==nil and not 是否超否 then
			if 名称 == "鬼魂术" then
				if self:取技能重复(单位, "高级鬼魂术") == false then
					单位.鬼魂 = 5
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			else
				单位.鬼魂 = 5
				单位.高鬼魂 =1
				单位.已加技能[#单位.已加技能 + 1] = "高级鬼魂术"
			end
		elseif 名称 == "魔之心" or 名称 == "高级魔之心" or 名称 == "超级魔之心" then
			if 名称 == "魔之心" then
				if self:取技能重复(单位, "高级魔之心") == false and (是否超否 or self:取技能重复(单位, "超级魔之心") == false) then---C改超否吸收技能
					单位.魔之心 = 1.1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级魔之心" then
				if 是否超否 or self:取技能重复(单位, "超级魔之心") == false then---C改超否吸收技能
					单位.魔之心 = 1.2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.魔之心 = 1.25
				单位.已加技能[#单位.已加技能 + 1] = "超级魔之心"
			end
		elseif 名称 == "须弥真言" then
			if self:取技能重复(单位, "须弥真言") == false then
				单位.法伤 = qz(单位.法伤 + 单位.魔力 * 0.4)
				单位.已加技能[#单位.已加技能 + 1] = 名称
			end
			-- elseif 名称 == "出奇制胜" then
			-- if self:取技能重复(单位, "出奇制胜") == false then
			-- 	单位.法伤 = qz(单位.法伤 + 单位.法伤 * 1.3)
			-- 	单位.已加技能[#单位.已加技能 + 1] = 名称
			-- end
			elseif 名称 == "好梦连连" then
			if self:取技能重复(单位, "好梦连连") == false then
				-- 单位.法伤 = qz(单位.法伤 + 单位.法伤 * 1.3)
				单位.法伤 = qz(单位.法伤 + 单位.法伤 * 0.15)
				单位.已加技能[#单位.已加技能 + 1] = 名称
				单位.好梦 = 1

			end
		-- elseif 名称 == "诸天正法" then
		-- 	if self:取技能重复(单位, "诸天正法") == false then
		-- 		单位.伤害 = qz(单位.伤害 + 单位.力量 * 0.4)
		-- 		单位.已加技能[#单位.已加技能 + 1] = 名称
		-- 	end
		elseif (名称 == "神佑复生" or 名称 == "高级神佑复生") and 单位.欣欣向荣==nil and not 是否超否  then
			if self:取技能存在(技能组, "鬼魂术") == false and self:取技能存在(技能组, "高级鬼魂术") == false then
				if 名称 == "神佑复生" then
					if self:取技能重复(单位, "高级神佑复生") == false and self:取技能重复(单位, "神佑复生") == false then
						单位.神佑 = 20
						单位.已加技能[#单位.已加技能 + 1] = 名称
					end
				elseif self:取技能重复(单位, "高级神佑复生") == false and self:取技能重复(单位, "神佑复生") == false then
					单位.神佑 = 30
					单位.已加技能[#单位.已加技能 + 1] = "高级神佑复生"
				end
			end
			if self.战斗类型==111124 and 单位.队伍==0 and 单位.名称=="不死魔灵" then
				单位.神佑=100
			end
			-- 返照：提高神佑几率
			if 单位.返照 == 1 then
			    单位.神佑 = 单位.神佑 + 30  -- 测试用100
			end
		elseif 名称 == "超级神柚复生" and not 是否超否 then
			if self:取技能重复(单位, "鬼魂术") == false and self:取技能重复(单位, "高级鬼魂术") == false then
				单位.神佑 = 40
				单位.已加技能[#单位.已加技能 + 1] = "超级神柚复生"
			end

			if self.战斗类型==111124 and 单位.队伍==0 and 单位.名称=="不死魔灵" then
				单位.神佑=100
			end
			-- 返照：提高神佑几率
			if 单位.返照 == 1 then
			    单位.神佑 = 单位.神佑 + 30  -- 测试用100
			end
		elseif 名称 == "精神集中" or 名称 == "高级精神集中" or 名称 == "超级精神集中" then
			if 名称 == "精神集中" then
				if self:取技能重复(单位, "高级精神集中") == false and (是否超否 or self:取技能重复(单位, "超级精神集中") == false) then---C改超否吸收技能
					单位.精神 = 1
					单位.伤害 = qz(单位.伤害 * 0.8)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级精神集中" then
				if 是否超否 or self:取技能重复(单位, "超级精神集中") == false then---C改超否吸收技能
					单位.精神 = 1
					单位.伤害 = qz(单位.伤害 * 0.8)
					单位.躲避 = qz(单位.躲避 * 1.1)
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.精神 = 1
				单位.伤害 = qz(单位.伤害 * 0.8)
				单位.躲避 = qz(单位.躲避 * 1.1)
				单位.超级精神集中 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级精神集中"
			end
		elseif 名称 == "否定信仰" or 名称 == "高级否定信仰" or 名称 == "超级否定信仰" then
			if 名称 == "否定信仰" then
				if self:取技能重复(单位, "高级否定信仰") == false and self:取技能重复(单位, "超级否定信仰") == false then
					单位.信仰 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级否定信仰" then
				if self:取技能重复(单位, "超级否定信仰") == false then
					单位.信仰 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			else
				单位.信仰 = 1
				单位.超信仰 = true
				单位.超信清 = {} --记录清除敌方信仰类技能
				单位.超信增 = {}
				单位.已加技能[#单位.已加技能 + 1] = "超级否定信仰"
				self:添加超级否定信仰属性(单位)
			end
		elseif 名称 == "法术暴击" or 名称 == "高级法术暴击" or 名称 == "超级法术暴击" then
			if 名称 == "法术暴击" then
				if self:取技能重复(单位, "高级法术暴击") == false and (是否超否 or self:取技能重复(单位, "超级法术暴击") == false) then---C改超否吸收技能
					单位.法暴 = 10
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
		elseif 名称 == "高级法术暴击" then
				if 是否超否 or self:取技能重复(单位, "超级法术暴击") == false then---C改超否吸收技能
					单位.法暴 = 15
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.法暴 = 20
				单位.超爆 = 1
				单位.已加技能[#单位.已加技能 + 1] = "超级法术暴击"
			end
		elseif 名称 == "桀骜自恃" then
			单位.法暴 = 50--
			单位.已加技能[#单位.已加技能 + 1] = "桀骜自恃"
		elseif 名称 == "法术连击" or 名称 == "高级法术连击" or 名称 == "超级法术连击" then
			if 名称 == "法术连击" then
				if self:取技能重复(单位, "高级法术连击") == false and (是否超否 or self:取技能重复(单位, "超级法术连击") == false) then---C改超否吸收技能
					单位.法连 = 20
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
		elseif 名称 == "高级法术连击" then
				if  是否超否 or self:取技能重复(单位, "超级法术连击") == false then---C改超否吸收技能
					单位.法连 = 30
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.法连 = 30
				单位.已加技能[#单位.已加技能 + 1] = "超级法术连击" --官方是30 这TM高级也30！不管了按官方来
			end
		elseif 名称 == "法术波动" or 名称 == "高级法术波动" or 名称 == "超级法术波动" then
			if 名称 == "法术波动" then
				if self:取技能重复(单位, "高级法术波动") == false and (是否超否 or self:取技能重复(单位, "超级法术波动") == false) then---C改超否吸收技能
					单位.法波上 = 120
					单位.法波下 = 80
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级法术波动" then
				if 是否超否 or self:取技能重复(单位, "超级法术波动") == false then---C改超否吸收技能
					单位.法波上 = 150
					单位.法波下 = 50
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.法波上 = 200
				单位.法波下 = 50
				单位.已加技能[#单位.已加技能 + 1] = "超级法术波动"
			end
		elseif 名称 == "法术抵抗" or 名称 == "高级法术抵抗" or 名称 == "超级法术抵抗" then
			if 名称 == "法术抵抗" then
				if self:取技能重复(单位, "高级法术抵抗") == false and (是否超否 or self:取技能重复(单位, "超级法术抵抗") == false) then---C改超否吸收技能
					单位.伤害 = 0.95
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级法术抵抗" then
				if 是否超否 or self:取技能重复(单位, "超级法术抵抗") == false then---C改超否吸收技能
					单位.法术抵抗 = 0.9
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.法术抵抗 = 0.9
				单位.超法抵抗 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级法术抵抗"
			end
			if 名称 ~= "超级法术抵抗" then
				单位.伤害 = qz(单位.伤害*0.9)
			end
		elseif 名称 == "盾气" or 名称 == "高级盾气" or 名称 == "超级盾气" then
			if self:取技能重复(单位, "隐身") == false and self:取技能重复(单位, "高级隐身") == false then
				if 名称 == "盾气" and self:取技能重复(单位, "高级盾气") == false and (是否超否 or self:取技能重复(单位, "超级盾气") == false) then---C改超否吸收技能
					单位.盾气 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				elseif 名称 == "高级盾气" and (是否超否 or self:取技能重复(单位, "超级盾气") == false) then---C改超否吸收技能
					单位.盾气 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				elseif not 是否超否 then
					单位.盾气 = 3
					self:增删主人技能属性(单位.主人序号,"超级盾气",1)
					单位.已加技能[#单位.已加技能 + 1] = "超级盾气"
				end
			end
		elseif 名称 == "水属性吸收" or 名称 == "高级水属性吸收" or 名称 == "超级水属性吸收" then
			if 名称 == "水属性吸收" then
				if self:取技能重复(单位, "高级水属性吸收") == false and (是否超否 or self:取技能重复(单位, "超级水属性吸收") == false) then---C改超否吸收技能
					单位.水吸 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级水属性吸收" then
				if 是否超否 or self:取技能重复(单位, "超级水属性吸收") == false then---C改超否吸收技能
					单位.水吸 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.水吸 = 2 -- =2 和 =1并无区分,只判定 单位.水吸~=nil
				单位.超水吸 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级水属性吸收"
			end
		elseif 名称 == "雷属性吸收" or 名称 == "高级雷属性吸收" or 名称 == "超级雷属性吸收" then
			if 名称 == "雷属性吸收" then
				if self:取技能重复(单位, "高级雷属性吸收") == false and (是否超否 or self:取技能重复(单位, "超级雷属性吸收") == false) then---C改超否吸收技能
					单位.雷吸 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级雷属性吸收" then
				if 是否超否 or self:取技能重复(单位, "超级雷属性吸收") == false then---C改超否吸收技能
					单位.雷吸 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.雷吸 = 2
				单位.超雷吸 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级雷属性吸收"
			end
		elseif 名称 == "火属性吸收" or 名称 == "高级火属性吸收" or 名称 == "超级火属性吸收" then
			if 名称 == "火属性吸收" then
				if self:取技能重复(单位, "高级火属性吸收") == false and (是否超否 or self:取技能重复(单位, "超级火属性吸收") == false) then---C改超否吸收技能
					单位.火吸 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级火属性吸收" then
				if 是否超否 or self:取技能重复(单位, "超级火属性吸收") == false then---C改超否吸收技能
					单位.火吸 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.火吸 = 2
				单位.超火吸 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级火属性吸收"
			end
		elseif 名称 == "土属性吸收" or 名称 == "高级土属性吸收" or 名称 == "超级土属性吸收" then
			if 名称 == "土属性吸收" then
				if self:取技能重复(单位, "高级土属性吸收") == false and (是否超否 or self:取技能重复(单位, "超级土属性吸收") == false) then---C改超否吸收技能
					单位.土吸 = 1
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif 名称 == "高级土属性吸收" then
				if 是否超否 or self:取技能重复(单位, "超级土属性吸收") == false then---C改超否吸收技能
					单位.土吸 = 2
					单位.已加技能[#单位.已加技能 + 1] = 名称
				end
			elseif not 是否超否 then
				单位.土吸 = 2
				单位.超土吸 = true
				单位.已加技能[#单位.已加技能 + 1] = "超级土属性吸收"
			end
		elseif 名称 == "弱点雷" then
			单位.弱点雷 = 1
		elseif 名称 == "弱点火" then
			单位.弱点火 = 1
		elseif 名称 == "弱点水" then
			单位.弱点水 = 1
		elseif 名称 == "弱点土" then
			单位.弱点土 = 1
		elseif 名称 == "嗜血追击" then
			单位.嗜血追击 = 1
		end
	end
end

function 战斗处理类:加载变身卡属性(单位, 技能组)
	for n = 1, #技能组 do
		local 名称 = 技能组[n]
		if type(名称) == "table" then
			名称 = 名称.名称
		end
		if 名称 == "剑荡四方" or 名称 == "壁垒击破" then
			单位.主动技能[#单位.主动技能 + 1] = {名称 = 名称, 等级 = 单位.等级}
		elseif 名称 == "反击" or 名称 == "高级反击" then
			if 名称 == "反击" then
				单位.反击 = 0.5
			else
				单位.反击 = 1
			end
		elseif 名称 == "敏捷" or 名称 == "高级敏捷" then
			-- if 名称 == "敏捷" then
			-- else
			-- end
		elseif 名称 == "强力" or 名称 == "高级强力" then
			单位.强力 = 1
		elseif 名称 == "防御" or 名称 == "高级防御" then
			if 名称 == "夜战" then
				单位.防御技能 = 1
			else
				单位.防御技能 = 2
			end
		elseif 名称 == "法术防御" then
			单位.法术防御 = 0.2
		elseif 名称 == "反震" or 名称 == "高级反震" then
			if 名称 == "反震" then
				单位.反震 = 0.25
			else
				单位.反震 = 0.5
			end
		elseif 名称 == "连击"  then
			单位.连击 = 45
			-- 单位.伤害 = qz(单位.伤害 * 0.75)
			if not 单位.减攻击 then
				单位.减攻击=1
			end
			单位.减攻击=单位.减攻击*0.75
		elseif 名称 == "飞行" or 名称 == "高级飞行" then
			if 名称 == "飞行" then
				单位.命中 = qz(单位.命中 * 1.2)
				单位.躲避 = qz(单位.躲避 * 1.2)
			else
				单位.命中 = qz(单位.命中 * 1.3)
				单位.躲避 = qz(单位.躲避 * 1.3)
			end
		elseif 名称 == "夜战" or 名称 == "高级夜战" then
			if 名称 == "夜战" then
				单位.夜战 = 1
			else
				单位.夜战 = 2
			end
		elseif 名称 == "感知" then
			单位.感知 = 0.45
		elseif 名称 == "再生" or 名称 == "高级再生" then
			if 名称 == "再生" then
				单位.再生 = qz(单位.等级 * 0.5)
			else
				单位.再生 = 单位.等级
			end
		elseif 名称 == "冥思" or 名称 == "高级冥思" then
			if 名称 == "冥思" then
				单位.冥思 = qz(单位.等级 * 0.25)
			else
				单位.冥思 = qz(单位.等级 * 0.5)
			end
		elseif 名称 == "慧根" or 名称 == "高级慧根" then
			if 名称 == "慧根" then
				单位.慧根 = 0.75
			else
				单位.慧根 = 0.5
			end
		elseif 名称 == "必杀" or 名称 == "高级必杀" then
			if 名称 == "必杀" then
				单位.必杀 = 单位.必杀 + 10
			else
				单位.必杀 = 单位.必杀 + 20
			end
		elseif 名称 == "幸运" or 名称 == "高级幸运" then
			if 名称 == "幸运" then
				单位.幸运 = 1
			else
				单位.幸运 = 1
			end
		elseif 名称 == "永恒" or 名称 == "高级永恒" then
			if 名称 == "永恒" then
				单位.永恒 = 2
			else
				单位.永恒 = 4
			end
		elseif 名称 == "招架" then
			单位.招架 = 0.9
		elseif 名称 == "偷袭" then
			单位.偷袭 = 1
		elseif 名称 == "毒" or 名称 == "高级毒" then
			if 名称 == "毒" then
				单位.毒 = 15
			else
				单位.毒 = 20
				单位.高级毒=1
			end
		elseif 名称 == "驱鬼"  then
			单位.驱鬼 = 1.5
		elseif 名称 == "魔之心" or 名称 == "高级魔之心" then
			if 名称 == "魔之心" then
				单位.魔之心 = 1.1
			else
				单位.魔之心 = 1.2
			end
		elseif 名称 == "神佑复生" or 名称 == "高级神佑复生" then
			if 名称 == "神佑复生" then
				单位.神佑 = 20
			else
				单位.神佑 = 30
			end
		elseif 名称 == "超级神柚复生"  then
			单位.神佑 = 40
		elseif 名称 == "法术暴击" then
			单位.法暴 = 15
		elseif 名称 == "弱点雷" then
			单位.弱点雷 = 1
		elseif 名称 == "弱点火" then
			单位.弱点火 = 1
		elseif 名称 == "弱点水" then
			单位.弱点水 = 1
		elseif 名称 == "弱点土" then
			单位.弱点土 = 1
		end
	end
end

function 战斗处理类:取消变身卡属性(单位, 名称)
	if 名称 == "剑荡四方" or 名称 == "壁垒击破" then
	elseif 名称 == "反击" or 名称 == "高级反击" then
		单位.反击 = nil
	elseif 名称 == "敏捷" or 名称 == "高级敏捷" then
		-- if 名称 == "敏捷" then
		-- else
		-- end
	elseif 名称 == "强力" or 名称 == "高级强力" then
		单位.强力 = nil
	elseif 名称 == "防御" or 名称 == "高级防御" then
		单位.防御技能 = nil
	elseif 名称 == "法术防御" then
		单位.法术防御 = 0.2
	elseif 名称 == "反震" or 名称 == "高级反震" then
		单位.反震 = nil
	elseif 名称 == "连击"  then
		单位.连击 = nil
		单位.减攻击=nil
		-- 单位.伤害 = qz(单位.伤害 * 1.25)
	elseif 名称 == "飞行" or 名称 == "高级飞行" then
		if 名称 == "飞行" then
			单位.命中 = qz(单位.命中 * 0.8)
			单位.躲避 = qz(单位.躲避 * 0.8)
		else
			单位.命中 = qz(单位.命中 * 0.7)
			单位.躲避 = qz(单位.躲避 * 0.7)
		end
	elseif 名称 == "夜战" or 名称 == "高级夜战" then
		单位.夜战 = nil
	elseif 名称 == "感知" then
		单位.感知 = nil
	elseif 名称 == "再生" or 名称 == "高级再生" then
		单位.再生 = nil
	elseif 名称 == "冥思" or 名称 == "高级冥思" then
		单位.冥思 = nil
	elseif 名称 == "慧根" or 名称 == "高级慧根" then
		单位.慧根 = nil
	elseif 名称 == "必杀" or 名称 == "高级必杀" then
		if 名称 == "必杀" then
			单位.必杀 = 单位.必杀 - 10
		else
			单位.必杀 = 单位.必杀 - 20
		end
	elseif 名称 == "幸运" or 名称 == "高级幸运" then
		单位.幸运 = nil
	elseif 名称 == "永恒" or 名称 == "高级永恒" then
		单位.永恒 = nil
	elseif 名称 == "招架" then
		单位.招架 = nil
	elseif 名称 == "偷袭" then
		单位.偷袭 = nil
	elseif 名称 == "毒" or 名称 == "高级毒" then
		单位.毒 = nil
		单位.高级毒 = nil
	elseif 名称 == "驱鬼"  then
		单位.驱鬼 = nil
	elseif 名称 == "魔之心" or 名称 == "高级魔之心" then
		单位.魔之心 = nil
	elseif 名称 == "神佑复生" or 名称 == "高级神佑复生" or 名称 == "超级神柚复生" then
		单位.神佑 = nil
	elseif 名称 == "法术暴击" then
		单位.法暴 = 0
	elseif 名称 == "弱点雷" then
		单位.弱点雷 = nil
	elseif 名称 == "弱点火" then
		单位.弱点火 = nil
	elseif 名称 == "弱点水" then
		单位.弱点水 = nil
	elseif 名称 == "弱点土" then
		单位.弱点土 = nil
	end
end

function 战斗处理类:取技能重复(单位, 技能)
	for n = 1, #单位.已加技能 do
		if 单位.已加技能[n] == 技能 then return true end
	end
	return false
end

function 战斗处理类:设置队伍区分(id)
	if self.队伍区分[1] == id then
		self.队伍数量[1] = self.队伍数量[1] + 1
	else
		self.队伍数量[2] = self.队伍数量[2] + 1
		self.队伍区分[2] = id
	end
end

function 战斗处理类:取角色所有技能是否有(编号, 名称)
	local xks = false
	if self.参战单位[编号].主动技能 ~= nil then
		for i = 1, #self.参战单位[编号].主动技能 do
			if self.参战单位[编号].主动技能[i] ~= nil and self.参战单位[编号].主动技能[i].名称 ~= nil and self.参战单位[编号].主动技能[i].名称 == 名称 then
				xks = true
				return xks
			end
		end
	end
	if xks == false and self.参战单位[编号].追加法术 ~= nil then
		for i = 1, #self.参战单位[编号].追加法术 do
			if self.参战单位[编号].追加法术[i] ~= nil and self.参战单位[编号].追加法术[i].名称 ~= nil and self.参战单位[编号].追加法术[i].名称 == 名称 then
				xks = true
				return xks
			end
		end
	end
	if xks == false and self.参战单位[编号].附加状态 ~= nil then
		for i = 1, #self.参战单位[编号].附加状态 do
			if self.参战单位[编号].附加状态[i] ~= nil and self.参战单位[编号].附加状态[i].名称 ~= nil and self.参战单位[编号].附加状态[i].名称 == 名称 then
				xks = true
				return xks
			end
		end
	end
	return xks
end

function 战斗处理类:取敌对门派编号(编号,门派)
	local fhz = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 then
			if self.参战单位[n].门派 == 门派 then
				fhz[#fhz+1] = n
			end
		end
	end
	return fhz
end

function 战斗处理类:取阵营数据(队伍)
	local fhz = {被封印={},可封印={}}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == 队伍 and self.参战单位[n].气血 >= 1 then
			fhz[#fhz+1] ={
			编号=n,
			气血=self.参战单位[n].气血,
			最大气血=self.参战单位[n].最大气血,
			防御=self.参战单位[n].防御,
			法防=self.参战单位[n].法防,
			愤怒=self.参战单位[n].愤怒 or 0 ,
			法术状态=self.参战单位[n].法术状态,
			}
			if 初始技能计算:取是否被封印(self,n) then
				fhz.被封印[#fhz.被封印+1] = n
			else
				fhz.可封印[#fhz.可封印+1] = n
			end
			if self.参战单位[n].类型 == "bb" then
				fhz[#fhz].类型=0
			else
				fhz[#fhz].类型=1
			end
		end
	end
	return fhz
end

function 战斗处理类:取敌对阵营数据(队伍)
	local fhz = {被封印={},可封印={}}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= 队伍 and self.参战单位[n].气血 >= 1 then
			fhz[#fhz+1] ={
			编号=n,
			气血=self.参战单位[n].气血,
			最大气血=self.参战单位[n].最大气血,
			防御=self.参战单位[n].防御,
			法防=self.参战单位[n].法防,
			愤怒=self.参战单位[n].愤怒 or 0 ,
			法术状态=self.参战单位[n].法术状态,
			}
			if self.参战单位[n].类型 == "bb" then
				fhz[#fhz].类型=0
			else
				fhz[#fhz].类型=1
				if 初始技能计算:取是否被封印(self,n) then
					fhz.被封印[#fhz.被封印+1] = n
				else
					fhz.可封印[#fhz.可封印+1] = n
				end
			end
		end
	end
	return fhz
end

function 战斗处理类:取敌方法系数量()
	local 数量=0
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍~=0 and self.参战单位[n].类型=="角色" then
			if self.参战单位[n].门派=="龙宫" or self.参战单位[n].门派=="魔王寨" or self.参战单位[n].门派=="神木林" then
				数量=数量+1
			end
		end
	end
	return  数量
end

function 战斗处理类:NPC_AI取友方被封印数量(编号)
	local 数量=0
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍==0 and self:取目标状态(编号,n,1) then
			if 初始技能计算:取是否被封印(self,n) then
				数量=数量+1
			end
		end
	end
	return  数量
end

function 战斗处理类:NPC_AI取敌方被封印数量(编号)
	local 数量=0
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
			if 初始技能计算:取是否被封印(self,n) then
				数量=数量+1
			end
		end
	end
	return  数量
end

function 战斗处理类:NPC_AI取友方被封印单位(编号)
	local 目标组={}
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍==self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
			if 初始技能计算:取是否被封印(self,n) then
				目标组[#目标组+1]=n
			end
		end
	end
	return 目标组[取随机数(1,#目标组)] or 编号
end

function 战斗处理类:NPC_AI取敌方可封印单位(编号)
	local 目标组={}
	for n=1,#self.参战单位 do
		if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
			if not 初始技能计算:取是否被封印(self,n) then
				目标组[#目标组+1]=n
			end
		end
	end
	return 目标组[取随机数(1,#目标组)] or self:取单个敌方目标(编号)--0
end

function 战斗处理类:NPC_AI取目标队伍无指定增益状态(编号,状态名称,类型)
  local 目标组={}
  if 类型=="友方" then
	for n=1,#self.参战单位 do
	  if  self.参战单位[n].队伍==self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) and self.参战单位[n].法术状态[状态名称]==nil then
		目标组[#目标组+1]=n
	  end
	end
  else
	for n=1,#self.参战单位 do
	  if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) and self.参战单位[n].法术状态[状态名称]==nil then
		目标组[#目标组+1]=n
	  end
	end
  end
  return 目标组[取随机数(1,#目标组)] or 0
end

function 战斗处理类:NPC_AI取队伍指定状态(编号,状态名称,类型)
  local 目标组={}
  if 类型=="友方" then
	for n=1,#self.参战单位 do
	  if  self.参战单位[n].队伍==self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) and self.参战单位[n].法术状态[状态名称]~=nil then
		目标组[#目标组+1]=n
	  end
	end
  else
	for n=1,#self.参战单位 do
	  if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) and self.参战单位[n].法术状态[状态名称]~=nil then
		目标组[#目标组+1]=n
	  end
	end
  end
  return 目标组[取随机数(1,#目标组)] or 0
end

function 战斗处理类:召唤数据设置1(类型, 等级,主怪,变异)------------佬伍修改（增加种族秘境时空之钥）
	print(类型)
	if 类型==1 then
		return 怪物属性:涅槃圣叶死亡召唤(等级)
	elseif 类型==2 then
		return 怪物属性:植命花死亡召唤(等级)
	elseif 类型==3 then
		return 怪物属性:蚩尤魔影召唤(等级)
	elseif 类型==4 then
		return 怪物属性:偃甲毒蛇死亡召唤(等级)
	elseif 类型==5 then
		return 怪物属性:噬天虎召唤(等级)
	elseif 类型==6 then
		return 怪物属性:火山巨兽召唤(等级)
	elseif 类型==7 then
		return 怪物属性:阴森巢穴召唤(等级)
	elseif 类型==8 then
		return 怪物属性:红色母蛛召唤(等级)
	elseif 类型==9 then
		return 怪物属性:蛛卵召唤(等级)
	elseif 类型==10 then
		return 怪物属性:牛魔小妖召唤(等级)
	end
end

function 战斗处理类:流程退场处理(退场单位列表, 退场特效)--------------佬伍修改（增加种族秘境时空之钥）
    for _, 编号 in ipairs(退场单位列表) do
        local 流程项 = {
            流程 = 707.32,
            攻击方 = 编号,
            退场特效 = 退场特效,
            挨打方 = {}
        }
        self.战斗流程[#self.战斗流程 + 1] = 流程项
        if self.参战单位[编号] then
            self.参战单位[编号].气血 = 0
            self.参战单位[编号].鬼魂 = nil
            self.参战单位[编号].死亡 = 1
            self.参战单位[编号].法术状态 = {}
        end
    end
end
function 战斗处理类:流程多名退场处理(退场单位列表, 退场特效)-----------佬伍修改（增加种族秘境时空之钥）
    for _, 编号 in ipairs(退场单位列表) do
        -- 添加退场流程项
        local 流程项 = {
            流程 = 708.32,
            攻击方 = 编号,
            退场特效 = 退场特效,
            挨打方 = {}
        }
        self.战斗流程[#self.战斗流程 + 1] = 流程项

        -- 更新参战单位状态
        if self.参战单位[编号] then
            self.参战单位[编号].气血 = 0
            self.参战单位[编号].鬼魂 = nil
            self.参战单位[编号].死亡 = 1
            self.参战单位[编号].法术状态 = {}
        end
    end
end
function 战斗处理类:取消所有状态(编号)--------------佬伍修改（增加种族秘境时空之钥）
  if self.参战单位[编号]~=nil and self.参战单位[编号].法术状态~=nil then
    for k,v in pairs(self.参战单位[编号].法术状态) do
      self:取消状态(k,self.参战单位[编号])
    end
  end
end

function 战斗处理类:执行怪物召唤1(名称, 类型, 队伍, 次数)--------------佬伍修改（增加种族秘境时空之钥）

    if  类型== 1 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end

    elseif  类型== 2 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 3 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 4 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 5 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 6 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 7 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 8 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 9 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
    elseif  类型== 10 then
    local id组 = self:取阵亡id组(队伍)
    local 索引列表 = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == 名称 then
            索引列表[#索引列表 + 1] = 索引
        end
    end

    local 实际次数 = math.min(次数, #索引列表)
    for n = 1, 实际次数 do
        local 临时id = id组[n]
        if 临时id == nil then
            临时id = #self.参战单位 + 1
        end

        local 编号 = 索引列表[n]
        local 临时数据 = self:召唤数据设置1(类型, self.参战单位[编号].等级)
        self.执行等待 = self.执行等待 + 5
        self:加载召唤单位(临时数据, 临时id, 队伍)
        if id组[n] == nil then
            self:设置队伍区分(队伍)
        end

        -- 添加召唤单位的入场流程项
        self.战斗流程[#self.战斗流程 + 1] = {
            流程 = 614.11,
            攻击方 = 编号,
            挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}
        }
    end
end
end


function 战斗处理类:取阵营数量(队伍)
	local 数量 = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == 队伍 and self.参战单位[n].气血 >= 1 and self.参战单位[n].捕捉 == nil and self.参战单位[n].逃跑 == nil then
			数量 = 数量 + 1
		end
	end
	return 数量
end

function 战斗处理类:执行怪物召唤(编号, 类型, 队伍, 次数)
	local id组 = self:取阵亡id组(队伍)
	if 类型 == 1 then --星宿战斗召唤
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(1, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 2 then --商人鬼魂召唤
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(2, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 6 then --巧智魔
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(6, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 7 or 类型 == 8 or 类型 == 9 then --梦魇夜叉
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据
			if 类型==7 then
				临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			elseif 类型==8 then
				local mx={"吸血鬼","鬼将","吸血鬼","鬼将","吸血鬼","鬼将","炎魔神","夜罗刹","幽灵"}
				if 取随机数()<=15 then
					mx=mx[取随机数(1,9)]
					self.额外数据.变异模型[#self.额外数据.变异模型+1]=mx
					临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号,mx)
				else
					临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
				end
			elseif 类型==9 then --龙龟
				local 龙龟变异=false
				if 取随机数()<=30 then
					龙龟变异=true
					self.额外数据.变异数量 = self.额外数据.变异数量 + 1
				end
				临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号,龙龟变异)
			end
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 10 then --通天河灵灯
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 11 then --百姓
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 12 then --百姓
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 13 then --百姓
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 14 then --百姓
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 15 then --百姓
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 16 then --百姓
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 17 then --百姓
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 18 then --黄真
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 19 then --黄真
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 20 then --黄真
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end
	elseif 类型 == 21 then --黄真
		local 临时id组={}
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			临时id组[#临时id组+1] = 临时id
		end
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 607.1, 攻击方 = 编号, 挨打方 = {}}
		for i=1,#临时id组 do
			self.战斗流程[#self.战斗流程] .挨打方[#self.战斗流程[#self.战斗流程] .挨打方+1] = {挨打方 = 临时id组[i], 队伍 = 队伍, 数据 = self:取加载信息(临时id组[i])}
		end

	elseif 类型 == 22 then --青丘迷雾
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 23 then --青丘迷雾
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 24 then --五行斗法
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 25 then --GM挑战
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 26 then --GM挑战
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级,编号)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 607, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end





	elseif 类型 == 27 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 28 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 29 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 30 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 31 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 32 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 33 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 34 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 35 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 36 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 37 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 38 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 39 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 40 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 41 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 42 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 43 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 44 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 52 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --新增位置
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end

	--新增
	elseif 类型 == 55 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --童子之力
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 56 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --罗刹鬼将
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 57 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --挑战门派师傅
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 58 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --青丘魔主
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 59 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --赤焰焚天
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 60 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --刑天之怒
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 61 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --夜影噬魂
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 62 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --鬼影森森
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 63 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --葫芦娃
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 64 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --妖魔尊主
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 65 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --精锐六九
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 66 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --勇武八九
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 67 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --神威一零九
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 68 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --天科一二九
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 69 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --天启一五五
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end
	elseif 类型 == 70 then
		for n = 1, 次数 do
			local 临时id = id组[n]
			if 临时id == nil then --天元一七五
				临时id = #self.参战单位 + 1
			end
			local 临时数据 = self:召唤数据设置(类型, self.参战单位[编号].等级)
			self.执行等待 = self.执行等待 + 5
			self:加载召唤单位(临时数据, 临时id, 队伍)
			if id组[n] == nil then
				self:设置队伍区分(队伍)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 614, 攻击方 = 编号, 挨打方 = {{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)}}}
		end

	end----------------佬伍修改（增加种族秘境时空之钥）
end

function 战斗处理类:召唤数据设置(类型, 等级,主怪,变异)
	if 类型 == 1 then --星宿的天兵
		return self:取召唤类型1(等级,主怪)
	elseif 类型==2 then
		return 怪物属性:商人鬼魂召唤(等级)
	elseif 类型==6 then
		return 怪物属性:巧智魔召唤(等级)
	elseif 类型==7 then --梦魇夜叉画魂（随机画魂、幽萤娃娃）
		return 怪物属性:画魂夜叉召唤(等级,self.战斗类型)
	elseif 类型==8 then --梦魇夜叉万年厉鬼（随机变异比如变异幽灵、变异吸血鬼、变异鬼将和变异炎魔神等） 主怪喊话：“厉害，今天真是遇到克星了”
		return 怪物属性:万年厉鬼夜叉召唤(等级,self.战斗类型,变异)
	elseif 类型==9 then --梦魇夜叉携宝龙龟（进场对面场上有5只绿龟，主怪一共会召唤15只怪，其中每次召唤的前两只怪必为绿龟
		return 怪物属性:携宝龙龟召唤(等级,self.战斗类型,变异)
	elseif 类型==10 then --梦魇夜叉携宝龙龟（进场对面场上有5只绿龟，主怪一共会召唤15只怪，其中每次召唤的前两只怪必为绿龟
		return self:取召唤类型10(等级,主怪)
	elseif 类型==11 then
		return self:取召唤类型11(等级,主怪)
	elseif 类型==12 then
		return self:取召唤类型12(等级,主怪)
	elseif 类型==13 then
		return self:取召唤类型13(等级,主怪)
	elseif 类型==14 then
		return self:取召唤类型14(等级,主怪)
	elseif 类型==15 then
		return self:取召唤类型15(等级,主怪)
	elseif 类型==16 then
		return self:取召唤类型16(等级,主怪)
	elseif 类型==17 then
		return self:取召唤类型17(等级,主怪)
	elseif 类型==18 then
		return self:取召唤类型18(等级,主怪)
	elseif 类型==19 then
		return self:取召唤类型19(等级,主怪)
	elseif 类型==20 then
		return self:取召唤类型20(等级,主怪)
	elseif 类型==21 then
		return self:取召唤类型20(等级,主怪)
	elseif 类型==22 then
		return self:取召唤类型21(等级,主怪)
	elseif 类型==23 then
		return self:取召唤类型22(等级,主怪)
	elseif 类型==24 then
		return self:取召唤类型23(等级,主怪)

	elseif 类型==25 then
		return self:取召唤类型25(等级,主怪)
	elseif 类型==26 then
		return self:取召唤类型26(等级,主怪)


	elseif 类型==27 then
		return 怪物属性:虎力大仙第一次召唤(等级,主怪)---------------佬伍修改（增加种族秘境时空之钥）
	elseif 类型==28 then
		return 怪物属性:虎力大仙第二次召唤(等级,主怪)
	elseif 类型==29 then
		return 怪物属性:涅槃圣叶死亡召唤(等级)
	elseif 类型==30 then
		return 怪物属性:植命花召唤(等级)
	elseif 类型==31 then
		return 怪物属性:神木图腾召唤(等级)
	elseif 类型==32 then
		return 怪物属性:火石地狱召唤(等级)
	elseif 类型==33 then
		return 怪物属性:抽腑地狱召唤(等级)
	elseif 类型==34 then
		return 怪物属性:刀山地狱召唤(等级)
	elseif 类型==35 then
		return 怪物属性:上古雷神召唤(等级)--秘境
	elseif 类型==36 then
		return 怪物属性:骨鬼僧召唤(等级)--秘境
	elseif 类型==37 then
		return 怪物属性:地涌夫人召唤1(等级)
	elseif 类型==38 then
		return 怪物属性:地涌夫人召唤2(等级)
	elseif 类型==39 then
		return 怪物属性:地涌夫人召唤3(等级)
	elseif 类型==40 then
		return 怪物属性:杨戬执行召唤(等级)
	elseif 类型==41 then
		return 怪物属性:晶石核心召唤1(等级)
	elseif 类型==42 then
		return 怪物属性:晶石核心召唤2(等级)
	elseif 类型==43 then
		return 怪物属性:无尽机关召唤1(等级)
	elseif 类型==44 then
		return 怪物属性:无尽机关召唤2(等级)
	elseif 类型==45 then
		return 怪物属性:幻光水蛇召唤(等级)
	elseif 类型==46 then
		return 怪物属性:五行战车召唤(等级)
    	elseif 类型==47 then
		return 怪物属性:阴森巢穴召唤(等级)
	elseif 类型==48 then
		return 怪物属性:红色母蛛召唤(等级)
	elseif 类型==49 then
		return 怪物属性:蛛卵召唤(等级)
	elseif 类型==50 then
		return 怪物属性:牛魔小妖召唤(等级)
	elseif 类型==51 then
		return 怪物属性:图腾召唤(等级)
	elseif 类型==52 then
		return 怪物属性:雨师执行召唤(等级)-----------佬伍修改（增加种族秘境时空之钥）

	end
end

function 战斗处理类:取召唤类型21(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 ={"大唐官府","狮驼岭","凌波城","阴曹地府","神木林","魔王寨","龙宫","天宫","五庄观","盘丝洞","方寸山","女儿村"}
	local 名称 = "迷茫"
	local 模型 = "蜃气妖"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*3)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.5)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.5)
		, 速度 = qz(self.参战单位[主怪].速度*0.5)
		, 防御 = qz(self.参战单位[主怪].防御*0.5)
		, 法防 = qz(self.参战单位[主怪].法防*0.5)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型20(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 = {"神木林","魔王寨","龙宫","天宫"}
	local 名称 = "痛苦"
	local 模型 = "修罗傀儡妖"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*3)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.5)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.9)
		, 速度 = qz(self.参战单位[主怪].速度*0.5)
		, 防御 = qz(self.参战单位[主怪].防御*0.5)
		, 法防 = qz(self.参战单位[主怪].法防*0.5)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型21(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "人心惶惶"
		, 模型 = "金乌火虫"
		, 气血 = 等级 * 200
		, 伤害 = 等级 * 22
		, 法伤 = 等级 * 15
		, 速度 = 等级 * 5
		, 防御 = 等级*5
		, 法防 = 等级*5
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 99999
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 修炼 = {物抗=5,法抗=5,攻修=5}
		, 主动技能 = 取随机物攻(2)
		, 法宝技能 = {}
	}
	return 召唤单位
end
function 战斗处理类:取召唤类型22(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "小蜜蜂"
		, 模型 = "蝴蝶仙子"
		, 气血 = qz(self.参战单位[主怪].气血*0.2)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.2)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.2)
		, 速度 = qz(self.参战单位[主怪].速度*0.2)
		, 防御 = 等级*5
		, 法防 = 等级*5
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 99999
		, 愤怒 = 99999
		, 战意 = 99999
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 修炼 = {物抗=1,法抗=1,攻修=1}
		, 主动技能 = 取随机物攻(2)
		, 法宝技能 = {}
	}
	return 召唤单位
end
function 战斗处理类:取召唤类型23(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "欲"
		, 模型 = "泡泡"
		, 气血 = qz(self.参战单位[主怪].气血*0.1)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.5)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.5)
		, 速度 = qz(self.参战单位[主怪].速度*0.002)
		, 防御 = 等级*5
		, 法防 = 等级*5
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 99999
		, 愤怒 = 99999
		, 战意 = 99999
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 修炼 = {物抗=1,法抗=1,攻修=1}
		, 主动技能 = 取随机物攻(2)
		, 法宝技能 = {}
	}
	return 召唤单位
end
function 战斗处理类:取召唤类型25(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "分身"
		, 模型 = "飞燕女"
		, 气血 = qz(self.参战单位[主怪].气血)
		, 伤害 = qz(self.参战单位[主怪].伤害)
		, 法伤 = qz(self.参战单位[主怪].法伤)
		, 速度 = 300
		 ,角色=true
		,武器={名称="紫电青霜",等级=150,子类=4}
		,锦衣="浮生绡·点黛"
		, 防御 = 等级*5
		, 法防 = 等级*5
		, 灵力 = 等级*5
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		,技能={"感知"}
		,修炼 = {物抗=9,法抗=9,攻修=9}
		,主动技能={"横扫千军"}

	}
	return 召唤单位
end

function 战斗处理类:取召唤类型26(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "分身"
		, 模型 = "剑侠客"
		, 气血 = qz(self.参战单位[主怪].气血)
		, 伤害 = qz(self.参战单位[主怪].伤害)
		, 法伤 = qz(self.参战单位[主怪].法伤)
		, 速度 = 等级*5
		 ,角色=true
		,武器={名称="鸣鸿",等级=160,子类=12}
		,锦衣="浮生绡·点黛"
		, 防御 = 等级*5
		, 法防 = 等级*5
		, 灵力 = 等级*5
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		,技能={"感知"}
		,修炼 = {物抗=9,法抗=9,攻修=9}
		,主动技能={"横扫千军"}

	}
	return 召唤单位
end

function 战斗处理类:取召唤类型19(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 = {"神木林","魔王寨","龙宫","天宫"}
	local 名称 = "痛苦"
	local 模型 = "修罗傀儡妖"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*2.5)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.5)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.8)
		, 速度 = qz(self.参战单位[主怪].速度*0.5)
		, 防御 = qz(self.参战单位[主怪].防御*0.5)
		, 法防 = qz(self.参战单位[主怪].法防*0.5)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型18(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 =  {"神木林","魔王寨","龙宫","天宫"}
	local 名称 = "愤怒"
	local 模型 = "狂豹人形"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*3)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.5)
		, 法伤 = qz(self.参战单位[主怪].法伤*1)
		, 速度 = qz(self.参战单位[主怪].速度*0.5)
		, 防御 = qz(self.参战单位[主怪].防御*0.5)
		, 法防 = qz(self.参战单位[主怪].法防*0.5)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型17(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 = {"大唐官府","狮驼岭","凌波城","阴曹地府","神木林","魔王寨","龙宫","天宫","五庄观","盘丝洞","方寸山","女儿村"}
	local 名称 = "邓玉"
	local 模型 = "巫蛮儿"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*3)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.8)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.8)
		, 速度 = qz(self.参战单位[主怪].速度*0.8)
		, 防御 = qz(self.参战单位[主怪].防御*0.8)
		, 法防 = qz(self.参战单位[主怪].法防*0.8)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型16(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 模型 = "凤凰"
	local 召唤单位 = {
		名称 = "冰·凤凰"
		, 模型 = 模型
		, 气血 = qz(等级*100*2)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.5)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.5)
		, 速度 = qz(self.参战单位[主怪].速度*0.5)
		, 防御 = qz(self.参战单位[主怪].防御*0.5)
		, 法防 = qz(self.参战单位[主怪].法防*0.5)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	召唤单位.AI战斗={}
	召唤单位.变异=true
 	召唤单位.AI战斗.指令="自爆"
 	召唤单位.AI战斗.回合=self.回合数+3
	return 召唤单位
end


function 战斗处理类:取召唤类型15(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 = {{"大唐官府","狮驼岭","凌波城","阴曹地府"},{"神木林","魔王寨","龙宫","天宫"},{"五庄观","盘丝洞","方寸山","女儿村"}}
	local 名称组 = {"剑意·狂攻","剑意·诡法","剑意·神封"}
	local sj = 取随机数(1,3)
	local 名称 = 名称组[sj]
	local 模型 = "进阶天兵"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*3)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.8)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.8)
		, 速度 = qz(self.参战单位[主怪].速度*0.8)
		, 防御 = qz(self.参战单位[主怪].防御*0.8)
		, 法防 = qz(self.参战单位[主怪].法防*0.8)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[sj]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型14(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 = {"方寸山","女儿村","神木林","化生寺","大唐官府","盘丝洞","阴曹地府","无底洞","魔王寨","狮驼岭","天宫","普陀山","凌波城","五庄观","龙宫"}
	local 名称组 = {"邪银","杀生","偷盗"}
	local 名称 = 名称组[取随机数(1,#名称组)]
	local 模型 = "蝎子精"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*self.参战单位[主怪].召唤次数)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.2*self.参战单位[主怪].召唤次数)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.2*self.参战单位[主怪].召唤次数)
		, 速度 = qz(self.参战单位[主怪].速度*0.2*self.参战单位[主怪].召唤次数)
		, 防御 = qz(self.参战单位[主怪].防御*0.2*self.参战单位[主怪].召唤次数)
		, 法防 = qz(self.参战单位[主怪].法防*0.2*self.参战单位[主怪].召唤次数)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	if 取随机数() <= 10 then
	    	召唤单位.AI战斗={}
	    	召唤单位.变异=true
	     	召唤单位.AI战斗.指令="自爆"
	     	召唤单位.AI战斗.回合=self.回合数+2
	end
	return 召唤单位
end

function 战斗处理类:取召唤类型13(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 = {"方寸山","女儿村","神木林","化生寺","大唐官府","盘丝洞","阴曹地府","无底洞","魔王寨","狮驼岭","天宫","普陀山","凌波城","五庄观","龙宫"}
	local 名称 = "雾灵"
	local 模型 = "雾中仙"
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.2)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.2)
		, 速度 = qz(self.参战单位[主怪].速度*0.2)
		, 防御 = qz(self.参战单位[主怪].防御*0.2)
		, 法防 = qz(self.参战单位[主怪].法防*0.2)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型12(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 门派 = {"方寸山","女儿村","神木林","化生寺","大唐官府","盘丝洞","阴曹地府","无底洞","魔王寨","狮驼岭","天宫","普陀山","凌波城","五庄观","龙宫"}
	local 名称 = "猛士"
	local 模型 = "进阶天兵"
	if self.参战单位[主怪].召唤次数 == 2 then 模型 = "进阶天将" end
	if self.参战单位[主怪].召唤次数 == 3 then 模型 = "进阶蛟龙" end
	if self.参战单位[主怪].召唤次数 == 4 then 模型 = "大力金刚" end
	if self.参战单位[主怪].召唤次数 == 5 then 名称= "精英" 模型 = "狂豹人形" end
	local 召唤单位 = {
		名称 = 名称
		, 模型 = 模型
		, 气血 = qz(等级*100*self.参战单位[主怪].召唤次数)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.2*self.参战单位[主怪].召唤次数)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.2*self.参战单位[主怪].召唤次数)
		, 速度 = qz(self.参战单位[主怪].速度*0.2*self.参战单位[主怪].召唤次数)
		, 防御 = qz(self.参战单位[主怪].防御*0.2*self.参战单位[主怪].召唤次数)
		, 法防 = qz(self.参战单位[主怪].法防*0.2*self.参战单位[主怪].召唤次数)
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 门派 = 门派[取随机数(1,#门派)]
		, 主动技能 ={}
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型11(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "混沌兽"
		, 模型 = "混沌兽"
		, 气血 = qz(self.参战单位[主怪].气血/2)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.9)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.9)
		, 速度 = qz(self.参战单位[主怪].速度*0.85)
		, 防御 = 0
		, 法防 = 0
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 主动技能 = 取大法(1)
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型1(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "护卫兵"
		, 模型 = "天兵"
		, 气血 = qz(self.参战单位[主怪].气血/2)
		, 伤害 = qz(self.参战单位[主怪].伤害*0.9)
		, 法伤 = qz(self.参战单位[主怪].法伤*0.9)
		, 速度 = qz(self.参战单位[主怪].速度*0.85)
		, 防御 = 0
		, 法防 = 0
		, 灵力 = 1
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		, 技能 = {}
		, 主动技能 = 取随机物攻(2)
		, 法宝技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:取召唤类型10(等级,主怪)
	等级 = 等级 - 5
	if 等级 < 1 then 等级 = 1 end
	local 召唤单位 = {
		名称 = "灵感分身"
		, 模型 = "神天兵"
		, 气血 = qz(self.参战单位[主怪].气血)
		, 伤害 = qz(self.参战单位[主怪].伤害)
		, 法伤 = qz(self.参战单位[主怪].法伤)
		, 速度 = 300
		 ,角色=true
		-- ,武器=table.copy(self.参战单位[主怪].武器)
		,武器={名称="狂澜碎岳",等级=150,子类=9}
		,染色方案=Qu角色属性["神天兵"].染色方案
		,染色组={[1]=取随机数(1,6),[2]=取随机数(1,6),[3]=取随机数(1,6)}
		, 防御 = 等级*5
		, 法防 = 等级*5
		, 灵力 = 等级*5
		, 躲避 = 等级 * 2
		, 魔法 = 200
		, 等级 = 等级
		, 魔力 = 等级*5
		, 力量 = 等级*5
		, 耐力 = 等级*5
		, 敏捷 = 等级*3
		,技能={"感知"}
		,修炼 = {物抗=3,法抗=3,攻修=3}
		, 主动技能 = {}
	}
	return 召唤单位
end

function 战斗处理类:执行怪物生成(编号, 队伍)
	local id组 = self:取阵亡id组(队伍)
	local faxx = {}

	local 临时数据 = 活动怪物处理(self.战斗类型,self.任务id,self.进入战斗玩家id)
	for n=1,#临时数据 do
		local 临时id = id组[n]
		if 临时id == nil then --新增位置
			临时id = #self.参战单位 + 1
		end
		self.执行等待 = self.执行等待 + 5
		self:加载召唤单位(临时数据[n], 临时id, 队伍)
		if id组[n] == nil then
			self:设置队伍区分(队伍)
		end
		table.insert(faxx,{挨打方 = 临时id, 队伍 = 队伍, 数据 = self:取加载信息(临时id)})
	end
	for n = 1, #self.参战玩家 do
		if not self.参战玩家[n].助战 then
			发送数据(self.参战玩家[n].连接id, 5517, faxx)
		end
	end
end

function 战斗处理类:加载召唤单位(单位组, id, 队伍)
	local 位置 = 0
	local 起始 = {}
	local 数量 = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == 队伍 then
			起始[#起始 + 1] = n
		end
	end
	for n = 1, #起始 do
		if 起始[n] == id then
			位置 = n
		end
	end
	if 位置 == 0 then
		位置 = #起始 + 1
	end
	self.参战单位[id] = {}
	self.参战单位[id].名称 = 单位组.名称
	self.参战单位[id].模型 = 单位组.模型
	self.参战单位[id].等级 = 单位组.等级
	self.参战单位[id].变异 = 单位组.变异
	self.参战单位[id].队伍 = 队伍
	self.参战单位[id].位置 = 位置
	self.参战单位[id].类型 = "bb"
	if 单位组.角色 and 单位组.角色 == true then
		self.参战单位[id].类型 = "系统角色"
	end
	self.参战单位[id].法防 = 0--单位组.法防 or 0
	self.参战单位[id].法伤 = 单位组.法伤 or 0
	self.参战单位[id].修炼 = 单位组.修炼 or {物抗=0,法抗=0,攻修=0}
	self.参战单位[id].玩家id = 0
	self.参战单位[id].分类 = "野怪"
	self.参战单位[id].可捕捉 = 单位组.可捕捉
	self.参战单位[id].附加阵法 =单位组.附加阵法 or "普通"
	self.参战单位[id].伤害 = 单位组.伤害
	self.参战单位[id].命中 = 单位组.力量 or 0
	self.参战单位[id].防御 = 0--单位组.防御 or 0
	self.参战单位[id].速度 = 单位组.速度
	self.参战单位[id].灵力 = 0--单位组.灵力 or 0
	self.参战单位[id].躲避 = 单位组.躲避 or 0
	self.参战单位[id].气血 = 单位组.气血
	self.参战单位[id].最大气血 = 单位组.气血
	self.参战单位[id].魔法 = 30000000
	self.参战单位[id].最大魔法 = 30000000
	self.参战单位[id].愤怒 = 30000000
	self.参战单位[id].最大愤怒 = 30000000
	self.参战单位[id].战意 = 30000000---C改

	self.参战单位[id].技能 = 单位组.技能 or nil
	self.参战单位[id].饰品显示 = 单位组.饰品显示
	self.参战单位[id].饰品颜色 = 单位组.饰品颜色
	self.参战单位[id].招式特效 = 单位组.招式特效
	-- self.参战单位[id].共生 = 单位组.共生
	-- self.参战单位[id].技能目标数 = 单位组.技能目标数
	self.参战单位[id].固定伤害 = 单位组.固定伤害 or 0
	self.参战单位[id].封印命中等级 = 单位组.封印命中等级 or 0
	self.参战单位[id].抵抗封印等级 = 单位组.抵抗封印等级 or 0
	self.参战单位[id].治疗能力 = 单位组.治疗能力 or 0
	self.参战单位[id].魔力 = 单位组.魔力 or 0
	self.参战单位[id].力量 = 单位组.力量 or 0
	self.参战单位[id].耐力 = 单位组.耐力 or 0
	self.参战单位[id].敏捷 = 单位组.敏捷 or 0
	self.参战单位[id].门派 = 单位组.门派
	self.参战单位[id].AI战斗 = 单位组.AI战斗 or nil
	self.参战单位[id].染色方案=单位组.染色方案
	self.参战单位[id].染色组=单位组.染色组
	self.参战单位[id].武器 = 单位组.武器
	self.参战单位[id].锦衣 = 单位组.锦衣

	if 单位组.炫彩 ~= nil then
		self.参战单位[id].炫彩 = 单位组.炫彩
		self.参战单位[id].炫彩组 =单位组.炫彩组
	end

	self.参战单位[id].主动技能 = {}
	self.参战单位[id].法宝技能 = {}
	if 单位组.主动技能 then
		for i = 1, #单位组.主动技能 do
			self.参战单位[id].主动技能[i] = {名称 = 单位组.主动技能[i], 等级 = 单位组.等级 + 10}
		end
	end
	if 单位组.法宝技能 then
		for i = 1, #单位组.法宝技能 do
			self.参战单位[id].法宝技能[i] = {名称 = 单位组[n].法宝技能[i], 等级 = 15}
		end
	end

	self.参战单位[id].已加技能 = {}
	self:单独重置属性(id)
	self:添加技能属性(self.参战单位[id], self.参战单位[id].技能)
end

function 战斗处理类:取阵亡id组(队伍)
	local 队伍表 = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == 队伍 and self.参战单位[n].法术状态.复活 == nil and (self.参战单位[n].气血 <= 0 or self.参战单位[n].逃跑 ~= nil or self.参战单位[n].捕捉 ~= nil) then
			队伍表[#队伍表 + 1] = n
		end
	end
	return 队伍表
end

function 战斗处理类:法宝计算(编号)
	if not 初始技能计算:取法宝状态(self.参战单位[编号]) then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/当前状态无法使用法宝")
		return
	end
	local 目标 = self.参战单位[编号].指令.目标
	local 道具 = self.参战单位[编号].指令.参数
	local id = self.参战单位[编号].玩家id
	local 道具1 = 玩家数据[id].角色.法宝[道具]
	local 名称 = 玩家数据[id].道具.数据[道具1].名称

	if  取法宝门派(玩家数据[id].道具.数据[道具1].名称) ~=  self.参战单位[编号].门派 and 取法宝门派(玩家数据[id].道具.数据[道具1].名称)~="无门派" then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/当前门派无法使用此法宝")
		return
	end


	if 玩家数据[id].角色.等级 < tonumber(玩家数据[id].道具.数据[道具1].特技) then return self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/您的等级不足以驾驭此法宝") end --测试
	if 玩家数据[id].道具.数据[道具1].魔法 >= 5 then
		玩家数据[id].道具.数据[道具1].魔法 = 玩家数据[id].道具.数据[道具1].魔法 - 5
		发送数据(玩家数据[id].连接id, 38, {内容 = "#Y/你的法宝[#G/"..名称.."#Y/]灵气减少了5点"})
	else
		发送数据(玩家数据[id].连接id, 38, {内容 = "#Y/你的法宝[#G/"..名称.."#Y/]灵气不足无法使用"})
	end
	if 玩家数据[id].道具.数据[道具1].回合 ~= nil then
		if 玩家数据[id].道具.数据[道具1].回合 > self.回合数 then
			self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/该法宝在当前回合无法使用")
			return
		end
	elseif self.参战单位[目标].队伍 == 0 or self.参战单位[目标].气血 < 0 or (名称 == "断线木偶" and self.参战单位[目标].类型 ~= "bb") or
		(名称 == "无魂傀儡" and self.参战单位[目标].类型 ~= "角色")or (名称 == "无尘扇" and self.参战单位[目标].类型 ~= "角色") or
		(名称 == "惊魂铃" and self.参战单位[目标].类型 ~= "bb") or (名称 == "鬼泣" and self.参战单位[目标].类型 ~= "bb")
		or (名称 == "缚妖索" and self.参战单位[目标].类型 ~= "角色") or (名称 == "捆仙绳" and self.参战单位[目标].类型 ~= "角色")
		or (名称 == "缚龙索" and self.参战单位[目标].类型 ~= "角色") or (名称 == "番天印" and self.参战单位[目标].类型 ~= "角色")
		or (名称 == "发瘟匣" and self.参战单位[目标].类型 ~= "角色") or (名称 == "罗汉珠" and self.参战单位[目标].类型 ~= "角色")
		or (名称 == "分水" and self.参战单位[目标].类型 ~= "角色") or (名称 == "赤焰" and 目标 ~= 编号)
		or (名称 == "摄魂" and self.参战单位[目标].类型 ~= "角色") or (名称 == "天煞" and self.参战单位[目标].类型 ~= "角色")
		or (名称 == "神木宝鼎" and self.参战单位[目标].类型 ~= "角色") or (名称 == "缩地尺" and 目标 ~= 编号)
		or (名称 == "九梵清莲" and self.参战单位[目标].类型 ~= "角色") or (名称 == "苍灵雪羽" and self.参战单位[目标].类型 ~= "角色")
		or (名称 == "烽火狼烟" and self.参战单位[目标].类型 ~= "角色") or (名称 == "璞玉灵钵" and self.参战单位[目标].类型 ~= "角色")
		or (名称 == "现形符" and self.参战单位[目标].类型 ~= "角色")then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你无法对这样的目标使用法宝")
		return --测试
	end
	self.执行等待 = self.执行等待 + 10
	玩家数据[id].道具.数据[道具1].回合 = self.回合数 + 玩家数据[id].道具.数据[道具1].角色限制

	if 名称 == "苍白纸人" or 名称 == "五彩娃娃" or 名称 == "罗汉珠" or 名称 == "混元伞" or 名称 == "乾坤玄火塔"
		or 名称 == "分水" or 名称 == "赤焰" or 名称 == "天煞" or 名称 == "神木宝鼎" or 名称 == "九梵清莲" or 名称 == "苍灵雪羽"
		or 名称 == "烽火狼烟" or 名称 == "璞玉灵钵" or 名称 == "金蟾"or 名称 == "月影" then
		self:增益技能计算(编号, 名称, 0, nil, 1, 1, 玩家数据[id].道具.数据[道具1].气血)
	elseif 名称 == "惊魂铃" or 名称 == "鬼泣" or 名称 == "缚妖索" or 名称 == "捆仙绳" or 名称 == "摄魂" or 名称 == "缚龙索"
		or 名称 == "番天印" or 名称 == "发瘟匣" or 名称 == "断线木偶" or 名称 == "无魂傀儡" or 名称 == "无尘扇"
		or 名称 == "无字经" or 名称 == "舞雪冰蝶" or 名称 == "现形符" or 名称 == "照妖镜" or 名称 == "落宝金钱" then
		self:减益技能计算(编号, 名称, 0, 1, 1, 玩家数据[id].道具.数据[道具1].气血)
		if 名称=="摄魂" then
			if self:取经脉(编号,"阴曹地府","拘魄") then
				玩家数据[id].道具.数据[道具1].回合=10
			end
		end
	-- elseif 名称 == "摄魂" then
 --        self:单体封印技能计算(编号,名称, 玩家数据[id].道具.数据[道具1].气血)
	elseif 名称 == "紫火如意" and self:取目标类型(目标) == "召唤兽" then
		self:法攻技能计算(编号, 名称, 玩家数据[id].道具.数据[道具1].气血, 1)
	-- elseif 名称 == "金钱镖" then
	--  if 玩家数据[id].角色:扣除银子(2000,0,0,"金钱镖",1) then
	--      self:固伤技能计算(编号, 名称, 玩家数据[id].道具.数据[道具1].气血,1,1)
	--  end
	elseif 名称=="清心咒" then
		self:恢复技能计算(编号,名称,玩家数据[id].道具.数据[道具1].气血,目标)
	end

	if self:取经脉(编号,"天宫","神念") then
		self:增加愤怒(编号,10)
	end
	if self.参战单位[编号].法术状态.愈勇 then
		self:取消状态("愈勇",self.参战单位[编号])
	end
	if 名称 == "缩地尺" then
		self:法术逃跑(编号,玩家数据[id].道具.数据[道具1].气血+10,名称)
	end

end

function 战斗处理类:法宝计算野怪(编号)
	local 目标 = self.参战单位[编号].指令.目标
	local 名称 = self.参战单位[编号].指令.参数
	self.执行等待 = self.执行等待 + 10
	if 名称 == "干将莫邪" or 名称 == "苍白纸人" or 名称 == "五彩娃娃" or 名称 == "混元伞" or 名称 == "乾坤玄火塔" then
		self:增益技能计算(编号, 名称, 0, nil, 1, 1, 15)
	elseif 名称 == "断线木偶" or 名称 == "无魂傀儡" or 名称 == "无尘扇" then
		self:减益技能计算(编号, 名称, 0, 1, 1, 15)
	end
end

function 战斗处理类:怪物法宝计算(编号,名称)
	local 目标 = self.参战单位[编号].指令.目标
	local 名称 = self.参战单位[编号].指令.参数
	self.执行等待 = self.执行等待 + 10
	if 名称 == "干将莫邪" or 名称 == "苍白纸人" or 名称 == "五彩娃娃" or 名称 == "混元伞" or 名称 == "乾坤玄火塔" then
		self:增益技能计算(编号, 名称, 0, nil, 1, 1, 15)
	elseif 名称 == "断线木偶" or 名称 == "无魂傀儡" or 名称 == "无尘扇" then
		self:减益技能计算(编号, 名称, 0, 1, 1, 15)
	end
end

function 战斗处理类:灵宝计算(编号)
	local 目标 = self.参战单位[编号].指令.目标
	local id = self.参战单位[编号].玩家id
	local 道具id = 玩家数据[id].角色.灵宝佩戴[self.参战单位[编号].指令.参数]
	local 名称 = 玩家数据[id].道具.数据[道具id].名称
	local 境界 = 玩家数据[id].道具.数据[道具id].气血
	local 等级 = self.参战单位[编号].等级
	local 消耗 = 1
	if self.参战单位[编号].灵元.数值 == 0 then
	  	self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/灵元不足无法使用灵宝")
	  	return
	elseif self.参战单位[目标].类型 == "角色" and (名称 == "赤炎战笛" or 名称 == "惊兽云尺") then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/该灵宝无法对玩家使用")
	  	return
	elseif self.参战单位[目标].类型 ~= "角色" and 名称 == "青狮獠牙" then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/该灵宝只能对玩家使用")
	  	return
	end
	if 名称 == "战神宝典" then
		消耗 = self.参战单位[编号].灵元.数值
	elseif 名称 == "乾坤金卷" or 名称 == "乾坤木卷" or 名称 == "乾坤水卷" or 名称 == "乾坤火卷" or 名称 == "乾坤土卷" or 名称 == "定神仙琴"
		or 名称 == "赤炎战笛" or 名称 == "护体灵盾" or 名称 == "惊兽云尺" then
		消耗 =1
	else
		if self.参战单位[编号].灵元.数值 >=7 then
			消耗 = 7
		elseif self.参战单位[编号].灵元.数值 >=3 then
			消耗 = 3
		elseif self.参战单位[编号].灵元.数值 >=1 then
			消耗 = 1
		end
	end
	 self.参战单位[编号].灵元.数值 = self.参战单位[编号].灵元.数值-消耗
	战斗灵宝计算:战斗灵宝计算(编号,名称,境界,消耗,目标,等级,self)
end

function 战斗处理类:药物加成(编号,数额)
	if self.参战单位[编号].识药 then
		数额 = qz(数额+数额*self.参战单位[编号].识药[1])
	end
	return 数额
end

-- function 战斗处理类:道具计算(编号)
function 战斗处理类:道具计算(编号,sss,奇袭指令)
	if self.参战单位[编号].队伍 == 0 and self.参战单位[编号].道具类型 == "法宝" then self:法宝计算野怪(编号) return end
	if self.参战单位[编号].道具类型 == "法宝" then self:法宝计算(编号) return end
	if self.参战单位[编号].道具类型 == "灵宝" then self:灵宝计算(编号) return end
	if self.参战单位[编号].法术状态.日月乾坤 and self.参战单位[编号].法术状态.日月乾坤.陌宝~=nil then self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/行动失败") return end
	local 目标 = self.参战单位[编号].指令.目标
	local 道具 = self.参战单位[编号].指令.参数
	if 奇袭指令 and type(奇袭指令)=="table" then
		目标 = 奇袭指令.目标
		道具 = 奇袭指令.参数
	end

	local id = self.参战单位[编号].玩家id
	local 道具1 = 玩家数据[id].角色.道具[道具]
	if 道具1 == nil or 玩家数据[id].道具.数据[道具1] == nil then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你没有这样的道具")
		return
	end
	if self.参战单位[编号].法术状态.缚仙蛛丝 then
		if 道具1 <= self.参战单位[编号].法术状态.缚仙蛛丝.境界 then
			self:添加提示(self.参战单位[编号].玩家id, 编号, "#R/缚仙蛛丝#Y/状态下，无法使用#R/"..self.参战单位[编号].法术状态.缚仙蛛丝.境界.."#Y/以前的道具")
			return
		end
	end
	local 道具数据 = table.loadstring(table.tostring(玩家数据[id].道具.数据[道具1]))
	local 名称 = 道具数据.名称
	if not self.PK战斗 and (名称=="醉仙果" or 名称=="七珍丸"or 名称=="九转续命丹"or 名称=="十全大补丸"or 名称=="固本培元丹"or 名称=="舒筋活络丸"or 名称=="凝气丸") then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/此类道具只能擂台使用")
		return
	end

	local 使用 = false
	-- local 加血道具 = {"金创药", "小还丹", "千年保心丹", "金香玉", "五龙丹", "天不老", "紫石英", "血色茶花", "熊胆", "鹿茸", "六道轮回", "凤凰尾", "硫磺草", "龙之心屑", "火凤之睛", "四叶花", "天青地白", "七叶莲", "固本培元丹", "十全大补丸", "舒筋活络丸"}
	-- local 加魔道具 = {"翡翠豆腐", "凝气丸", "七珍丸" , "佛跳墙", "蛇蝎美人", "风水混元丹", "定神香", "十香返生丸", "丁香水", "月星子", "仙狐涎", "地狱灵芝", "麝香", "血珊瑚", "餐风饮露", "白露为霜", "天龙水", "孔雀红", "紫丹罗", "佛手", "旋复花", "龙须草", "百色花", "香叶", "白玉骨头", "鬼切草", "灵脂", "曼陀罗花"}
	-- local 复活道具 = {"佛光舍利子", "九转回魂丹", "九转续命丹"}
	-- local 酒类道具 = {"珍露酒", "虎骨酒", "女儿红", "蛇胆酒", "醉生梦死", "梅花酒", "百味酒", "醉仙果"}
	-- 血1，蓝2，复活3，酒4
	local 使用类型 = nil
	if skill战斗道具[名称] then
		使用类型 = skill战斗道具[名称]
	end
	if 道具数据.总类 == 141 then --暗器飞镖
		使用类型 = 6
	end
	if 道具数据.总类 == 139 then
		使用类型 = 7
	end
	if 使用类型 == nil then self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/此类道具无法在战斗中使用") return end

	self.执行等待 = self.执行等待 + 8
	if 使用类型 == 1 then--加血道具 --药品
		if self.参战单位[目标].鬼魂 and self.参战单位[目标].高鬼魂==nil and 名称~="包子" then
			return
		end
		local 临时数值 = 玩家数据[id].道具:取加血道具1(名称, 道具1)
		临时数值 =self:药物加成(编号,临时数值)
		if self.参战单位[目标].法术状态.魔音摄魂 or self.参战单位[目标].气血 <= 0 then
			return
		else
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 60, 攻击方 = 编号, 挨打方 = {{挨打方 = 目标, 解除状态 = {}, 特效 = {"加血"}}}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
			if self.参战单位[目标].法术状态.瘴气 then
				临时数值 = qz(临时数值*self.参战单位[目标].法术状态.瘴气.降疗)
			end
			if self.参战单位[目标].法术状态.重创 then
				临时数值 = qz(临时数值*self.参战单位[目标].法术状态.重创.降疗)
			end
			if self.参战单位[目标].法术状态.含情脉脉 and  self.参战单位[目标].法术状态.含情脉脉.忘情~=nil then
				临时数值 = qz(临时数值*self.参战单位[目标].法术状态.含情脉脉.忘情)
			end
			if self:取经脉(编号,"盘丝洞", "丹香") then --药品我们做完再加 and 三级药
				self:增加愤怒(编号,2)
			end
			if skill三级药[名称] and self.参战单位[编号].shenqi.name=="钟灵" then
				self:添加状态("风灵",self.参战单位[编号],self.参战单位[编号],69)
			end
			local 气血 = self:治疗量计算(编号, 目标, 临时数值)
			self:增加气血(目标,气血,名称)
			self.战斗流程[#self.战斗流程].挨打方[1].恢复气血 = 气血
			使用 = true
			if 名称 == "五龙丹" or 名称 == "舒筋活络丸" then
				if #self:解除状态结果(self.参战单位[目标], 初始技能计算:取异常状态法术(self.参战单位[目标].法术状态)) == 0 then
					self:添加状态("催眠符", self.参战单位[目标],self.参战单位[编号], self.参战单位[编号].等级)
					self.参战单位[目标].法术状态.催眠符.回合 = 2
				else
					if self:取经脉(目标,"狮驼岭", "背水") then
						self:添加状态("背水", self.参战单位[目标],self.参战单位[目标], 11)
					end
				end
			elseif 名称 == "小还丹" or 名称 == "十全大补丸" then
				local 品质=道具数据.阶品 or 1
				local num=qz(品质+80)
				if 名称 == "十全大补丸" then
					num=qz(品质*4+100)
				end
				if self.参战单位[目标].气血上限 then
					self.参战单位[目标].气血上限 = self.参战单位[目标].气血上限 + num
					if self.参战单位[目标].气血上限 > self.参战单位[目标].最大气血 then
						self.参战单位[目标].气血上限 = self.参战单位[目标].最大气血
					end
				end
			end
		end
	elseif 使用类型 == 2 then--加魔道具 --药品
		if self.参战单位[目标].鬼魂 and self.参战单位[目标].高鬼魂==nil and 名称~="包子" then
			return
		end
		local 临时数值 = 玩家数据[id].道具:取加魔道具1(名称, 道具1)
		临时数值 =self:药物加成(编号,临时数值)
		if (self.参战单位[目标].法术状态.魔音摄魂 and self.参战单位[目标].法术状态.魔音摄魂.迷意) or self.参战单位[目标].气血 <= 0 then
			return
		else
			if self.参战单位[目标].法术状态.瘴气 and self.参战单位[目标].法术状态.瘴气.降魔 then
				临时数值 = qz(临时数值*self.参战单位[目标].法术状态.瘴气.降魔)
			end
			if self:取经脉(编号,"盘丝洞", "丹香") then --药品我们做完再加 and 三级药
				self:增加愤怒(编号,2)
			end
			if skill三级药[名称] and self.参战单位[编号].shenqi.name=="钟灵" then
				self:添加状态("风灵",self.参战单位[编号],self.参战单位[编号],69)
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 60, 攻击方 = 编号, 挨打方 = {{挨打方 = 目标, 解除状态 = {}, 特效 = {"加蓝"}}}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
			self.参战单位[目标].魔法 = self.参战单位[目标].魔法 + 临时数值
			if self.参战单位[目标].魔法 > self.参战单位[目标].最大魔法 then self.参战单位[目标].魔法 = self.参战单位[目标].最大魔法 end
			if 名称 == "七珍丸" then
				local zt={"疯狂","催眠符","毒"}
				for i=1,3 do
					if self.参战单位[目标].法术状态 and self.参战单位[目标].法术状态[zt[i]] and self.参战单位[目标].法术状态[zt[i]].酒类 then
						self:取消状态(zt[i],self.参战单位[目标])
						break
					end
				end
			end
			使用 = true
		end
	elseif 使用类型 == 3 then--复活道具 --药品
		local 临时数值 = 玩家数据[id].道具:取加血道具1(名称, 道具1)
		临时数值 =self:药物加成(编号,临时数值)
		if self.参战单位[目标].类型 ~= "角色" or 初始技能计算:不可复活(self.参战单位[目标]) then
			return
		else
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 60, 攻击方 = 编号, 挨打方 = {{挨打方 = 目标, 解除状态 = {}, 特效 = {"加血"}}}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
			if self.参战单位[目标].法术状态.瘴气 then
				临时数值 = qz(临时数值*self.参战单位[目标].法术状态.瘴气.降疗)
			end
			if self.参战单位[目标].法术状态.重创 then
				临时数值 = qz(临时数值*self.参战单位[目标].法术状态.重创.降疗)
			end
			if self.参战单位[目标].法术状态.含情脉脉 and  self.参战单位[目标].法术状态.含情脉脉.忘情~=nil then
				临时数值 = qz(临时数值*self.参战单位[目标].法术状态.含情脉脉.忘情)
			end
			self.参战单位[目标].死亡 = nil
			local 气血 = self:治疗量计算(编号, 目标, 临时数值)
			if 气血<1 then
				气血=1
			end
			self:增加气血(目标,气血,名称)
			if self:取经脉(编号,"盘丝洞", "丹香") then --药品我们做完再加 and 三级药
				self:增加愤怒(编号,2)
			end
			if skill三级药[名称] and self.参战单位[编号].shenqi.name=="钟灵" then
				self:添加状态("风灵",self.参战单位[编号],self.参战单位[编号],69)
			end
			self.战斗流程[#self.战斗流程].挨打方[1].恢复气血 = 气血
			self.战斗流程[#self.战斗流程].挨打方[1].复活 = true
			if self.参战单位[目标].气血上限 then
				if 名称 == "九转续命丹" then
					-- local 品质=道具数据.阶品 or 1
					-- local num=qz(品质*5+100)
					self.参战单位[目标].气血上限 = 气血
				end
				if self.参战单位[目标].气血上限<1 then
					self.参战单位[目标].气血上限=1
				end
			end
			使用 = true
		end
	elseif 使用类型 == 4 then--酒类道具
		local 临时数值 = 玩家数据[id].道具:取加魔道具1(名称, 道具1)
		if (self.参战单位[目标].法术状态.魔音摄魂 and self.参战单位[目标].法术状态.魔音摄魂.迷意) or self.参战单位[目标].气血 <= 0 then
			return
		else
			self.战斗流程[#self.战斗流程+1]={流程=60,攻击方=编号,挨打方={{挨打方=目标,解除状态={},特效={"加蓝"}}},提示={允许=true,类型="法术",名称=self.参战单位[编号].名称.."使用了"..名称}}
			if self.参战单位[目标].愤怒 then
				self.参战单位[目标].愤怒 = qz(self.参战单位[目标].愤怒 + 临时数值)
				if self.参战单位[目标].愤怒 > 150 then self.参战单位[目标].愤怒 = 150 end
			end
			使用 = true
			if 名称 == "女儿红" or 名称 == "梅花酒" then
				self:添加状态("催眠符", self.参战单位[目标], self.参战单位[编号],self.参战单位[编号].等级)
				self.参战单位[目标].法术状态.催眠符.回合 = 取随机数(2, 3)
				self.参战单位[目标].法术状态.催眠符.酒类=true
			elseif 名称 == "蛇胆酒" then
				self.参战单位[目标].防御 = self.参战单位[目标].防御 - qz(临时数值 * 1.5)
			elseif 名称 == "百味酒" then
				if 取随机数() <= 50 then
					self:添加状态("催眠符", self.参战单位[目标], self.参战单位[编号],self.参战单位[编号].等级)
					self.参战单位[目标].法术状态.催眠符.回合 = 取随机数(2, 3)
					self.参战单位[目标].法术状态.催眠符.酒类=true
				else
					if self:取封印成功("毒",self.参战单位[目标].等级,self.参战单位[目标],self.参战单位[目标]) then
						self:添加状态("毒", self.参战单位[目标], self.参战单位[编号],self.参战单位[编号].等级)
						self.参战单位[目标].法术状态.毒.回合 = 5
						self.参战单位[目标].法术状态.毒.酒类=true
					end
				end
			elseif 名称 == "醉生梦死" or 名称 == "虎骨酒" or 名称 == "醉仙果" then
				local hh = 取随机数(2, 3)
				if 名称== "醉仙果" then
					hh = 取随机数(3, 4)
				end
				self:添加状态("疯狂", self.参战单位[目标], self.参战单位[编号],self.参战单位[编号].等级)
				self.参战单位[目标].法术状态.疯狂.回合 = hh
				self.参战单位[目标].法术状态.疯狂.酒类=true
			end
		end
	elseif 使用类型 == 5 then--乾坤袋
		if self.参战单位[目标].乾坤袋 == nil then
			self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你无法对此类目标使用乾坤袋")
			return
		elseif self.参战单位[编号].类型 ~= "角色" then
			self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/只有角色才可以使用此道具")
			return
		else
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 56, 攻击方 = 编号, 挨打方 = {}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
			self.战斗流程[#self.战斗流程].挨打方[1] = {挨打方 = 目标, 特效 = {"水遁"}}
			local 百分比 = qz(100 - self.参战单位[编号].气血 / self.参战单位[编号].最大气血 * 100)
			百分比 = 百分比 + 20
			if 百分比 >= 取随机数() then
				self.战斗流程[#self.战斗流程].挨打方[1].气血 = self.参战单位[目标].气血
				self.战斗流程[#self.战斗流程].挨打方[1].死亡 = self:减少气血(目标, self.参战单位[目标].气血, 编号)
				任务数据[self.任务id].乾坤袋 = true
				玩家数据[self.参战单位[编号].玩家id].角色:刷新任务跟踪()
			end
		end
	elseif 使用类型 == 7 then--烟花
		if self.参战单位[编号].类型 ~= "角色" then
			self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/只有角色才可以使用此道具")
			return
		end
			local 伤害=10

			self.战斗流程[#self.战斗流程 + 1] = {流程 = 611, 攻击方 = 编号, 挨打方 = {}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
			local 剩余单位=0
			if self.战斗类型==150055 then
			 	for i = 1, #self.参战单位 do
			 		if  self.参战单位[i].类型~="角色" and  self.参战单位[i].玩家id==0 and  self:取目标状态(i, i, 2) then
			 		剩余单位=剩余单位+1
			 		end
			 	end
			 	if 剩余单位==1 then
			 		伤害=9999999
			 	end
			end
			伤害=qz(伤害)
			self.战斗流程[#self.战斗流程].挨打方[1]={挨打方=目标,伤害=伤害}
			self.战斗流程[#self.战斗流程].挨打方[1].死亡=self:减少气血(目标,伤害,编号,名称)
			if 剩余单位==1 then
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 53,全屏=true, 攻击方 = 目标, 挨打方 = {}, 提示 = {允许 = false, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
			self.战斗流程[#self.战斗流程].挨打方[1] = {挨打方 = 目标, 特效 = {"驱赶烟花"}}
			end
			使用=true
	elseif 使用类型 == 6 then--暗器飞镖
		if self.参战单位[编号].法术状态.楚楚可怜 or self.参战单位[编号].类型 ~= "角色" then
			return
		end
		local 等级=self:取技能等级(编号,"沉鱼落雁")
		local 人数=math.floor(等级/25)+1
		if self.PK战斗 then
			人数=1
		end
		local 道具等级=道具数据.子类
		local 伤害=道具等级*5 --这个要重写的 --下面还要加固伤啥的乱七八糟的
		local 目标组=self:取多个敌方目标(编号,目标,人数)
		if #目标组>0 then
			local gl = 0
			local 女儿 = false
			if self.参战单位[编号].门派=="女儿村" then
				gl = 10
				女儿 = true
				伤害 = 伤害 + 50 --另外女儿村门派特色：暗器伤害+50，使用暗器攻击时，有10%几率令对方中毒
				if self:取经脉(编号,"女儿村", "独尊") or self:取经脉(编号,"女儿村", "重明") then
					gl = 6
				elseif self:取经脉(编号,"女儿村", "涂毒") then
					gl = 16
				elseif self:取经脉(编号,"女儿村", "杏花") then
					gl = 14
				end
			end
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 611, 攻击方 = 编号, 挨打方 = {}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
			for n=1,#目标组 do
				if 女儿 then
					if self:取经脉(编号,"女儿村", "暗刃") and self.参战单位[目标组[n]].法术状态.毒 then
						伤害 = 伤害 * 1.18
					end
					if self:取经脉(编号,"女儿村", "鸿影") and self:取目标类型(目标组[n]) == "玩家" and #self:解除状态结果(self.参战单位[编号], 初始技能计算:取封印状态法术(), 1)>0 then
						伤害 = 伤害 + self.参战单位[编号].装备伤害*0.6
					end
					if self.参战单位[编号].凤舞九天 then
						伤害=伤害+self.参战单位[编号].凤舞九天
					end
				end

				if sj()<=gl and self:取封印成功("毒",11,self.参战单位[编号],self.参战单位[目标组[n]]) then --毒都要写这个是否中毒
					self:添加状态("毒", self.参战单位[目标组[n]], self.参战单位[编号],等级)
					if 女儿 then
						if self:取经脉(编号,"女儿村", "淬芒") then
							self:添加状态("淬芒",self.参战单位[编号],self.参战单位[编号],69)
						end
						if self:取经脉(编号,"女儿村", "天香") then
							self:增加愤怒(编号,5)
						end
					end
				end
				if self.PK战斗 then
					伤害=伤害*0.3
				end
				伤害=qz(伤害)
				self.战斗流程[#self.战斗流程].挨打方[n]={挨打方=目标组[n],伤害=伤害}
				self.战斗流程[#self.战斗流程].挨打方[n].死亡=self:减少气血(目标组[n],伤害,编号,名称)
			end




			-- 玩家数据[id].道具.数据[道具1].耐久=玩家数据[id].道具.数据[道具1].耐久-1 --暗器还没写耐久呢
			-- if 玩家数据[id].道具.数据[道具1].耐久<=0 then
			--     玩家数据[id].道具.数据[道具1]=nil
			--     玩家数据[id].角色.道具[道具]=nil
			-- end
		end
		return
	end
	if 使用 then
		if 道具数据.数量 ~= nil then
			玩家数据[id].道具.数据[道具1].数量 = 玩家数据[id].道具.数据[道具1].数量 - 1
		end
		if 玩家数据[id].道具.数据[道具1].数量 == nil or 玩家数据[id].道具.数据[道具1].数量 <= 0 then
			玩家数据[id].道具.数据[道具1] = nil
			玩家数据[id].角色.道具[道具] = nil
		end
	end
end

function 战斗处理类:取唯一造型(编号,造型)
	local x = 0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~=0 and self.参战单位[n].类型=="bb" then --or (self.参战单位[n].原造型 and )
			if self.参战单位[n].模型=="超级鲲鹏" or self.参战单位[n].模型=="进阶超级鲲鹏"  then
				x = x + 1
				if x>=2 then
					return false
				end
			elseif self.参战单位[n].原造型 and (self.参战单位[n].原造型=="超级鲲鹏" or self.参战单位[n].原造型=="进阶超级鲲鹏")  then
				x = x + 1
				if x>=2 then
					return false
				end
			end
		end
	end
	-- for n = 1, #self.参战单位 do
	--  if self.参战单位[n].队伍 ~=0 and self.参战单位[n].类型=="bb" then
	--      if self.参战单位[n].模型==造型 then
	--          x = x + 1
	--          if x>=2 then
			 --        return false
			 --    end
	--      end
	--  end
	-- end
	return true
end

function 战斗处理类:单独重置属性(n) --召唤兽、召唤物
	self.参战单位[n].序号 = n
	self.参战单位[n].法术状态 = {}
	self.参战单位[n].JM = {}
	-- self.参战单位[n].符石技能 = {}
	self.参战单位[n].追加法术 = {}
	self.参战单位[n].附加状态 = {}
	self.参战单位[n].shenqi = {name=false,lv=0}

	self.参战单位[n].法宝佩戴 = {}
	self.参战单位[n].特技技能 = {}
	if self.参战单位[n].招式特效 == nil then
		self.参战单位[n].招式特效 = {}
	end
	if self.参战单位[n].主动技能 == nil then
		self.参战单位[n].主动技能 = {}
	end
	self.参战单位[n].战意 = 0
	self.参战单位[n].超级战意 = 0
	self.参战单位[n].五行珠 = 0
	self.参战单位[n].人参果 = {枚=0,回合=4}
	self.参战单位[n].骤雨 = {层数=0,回合=3}
	self.参战单位[n].法暴 = 0
	self.参战单位[n].必杀 = 5
	self.参战单位[n].超级必杀=0
	self.参战单位[n].超级夜战 = 0
	self.参战单位[n].首次被伤 = {物理=0,法术=0,每回物理=0,每回法术=0}
	self.参战单位[n].超级偷袭 = false
	self.参战单位[n].超级敏捷 = {概率=0,触发=0,执行=false,指令={}}
	self.参战单位[n].连击 = 0
	self.参战单位[n].法连 = 0
	self.参战单位[n].夜战 = 0
	self.参战单位[n].护盾 = 0
	self.参战单位[n].攻击修炼 = 0
	self.参战单位[n].法术修炼 = 0
	self.参战单位[n].防御修炼 = 0
	self.参战单位[n].抗法修炼 = 0
	self.参战单位[n].猎术修炼 = 0
	self.参战单位[n].附加必杀 = 0
	self.参战单位[n].附加必杀伤害 = 0
	self.参战单位[n].装备伤害 = 0
	self.参战单位[n].装备敏捷 = 0
	self.参战单位[n].武器命中 = 0
	self.参战单位[n].耐久计算 = {攻击=0,施法=0,挨打=0}
	self.参战单位[n].显示饰品 = false
	self.参战单位[n].无心插柳 = false
	self.参战单位[n].攻击五行 = self.参战单位[n].五行
	self.参战单位[n].防御五行 = self.参战单位[n].五行 or 五行_[取随机数(1,5)]
	self.参战单位[n].法伤 = self.参战单位[n].法伤 or 0
	self.参战单位[n].法防 = self.参战单位[n].法防 or 0
	self.参战单位[n].死亡击飞 = false
	self.参战单位[n].灵元 = {数值=0,回合=5}
	if self.参战单位[n].命中 == nil then self.参战单位[n].命中 = qz(self.参战单位[n].伤害*1.2) end
	if self.参战单位[n].躲避 == nil then self.参战单位[n].躲避 = self.参战单位[n].速度 end
	for i = 1, #灵饰战斗属性 do
		if self.参战单位[n][灵饰战斗属性[i]] == nil then
			self.参战单位[n][灵饰战斗属性[i]] = 0
		end
	end
	if self.参战单位[n].队伍 ~= 0 then
		if self.参战单位[n].类型 ~= "角色" then
			if self.参战单位[n].装备 ~= nil then
				self:检查bb套装(self.参战单位[n])
			end
			self:添加技能属性(self.参战单位[n], self.参战单位[n].技能)
			if self.参战单位[n].内丹 ~= nil and self.参战单位[n].内丹.格子 and #self.参战单位[n].内丹.格子 > 0 then
				self:添加内丹属性(self.参战单位[n])
			end
			-- self:添加状态("灵刃", self.参战单位[n],self.参战单位[n],1.1)
			-- if self.参战单位[n].进阶 ~= nil and self.参战单位[n].进阶.开启 and self.参战单位[n].进阶.特性 ~= "无" then --设置开关
			-- 	self:添加特性属性(n, self.参战单位[n].进阶)
			-- end
			self.参战单位[n].攻击修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.攻击控制力[1]
			self.参战单位[n].法术修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.法术控制力[1]
			self.参战单位[n].防御修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.防御控制力[1]
			self.参战单位[n].抗法修炼 = 玩家数据[self.参战单位[n].玩家id].角色.bb修炼.抗法控制力[1]
			self:添加召唤兽属性(self.参战单位[n])
			self:添加bb法宝属性(n)
			if self.参战单位[n].统御属性 then
				if self.参战单位[n].统御属性.飞火流星  then
					self.参战单位[n].速度=qz(self.参战单位[n].速度-self.参战单位[n].统御属性.飞火流星)
				end
				if self.参战单位[n].统御属性.开天辟地  then
					self.参战单位[n].伤害=qz(self.参战单位[n].伤害+self.参战单位[n].统御属性.开天辟地)
				end
				if self.参战单位[n].统御属性.破釜沉州  then
					self.参战单位[n].必杀=self.参战单位[n].必杀+self.参战单位[n].统御属性.破釜沉州
					self.参战单位[n].命中=self.参战单位[n].命中+50
				end
			end
		end
	else
		if  not self.参战单位[n].修炼 then
			self.参战单位[n].攻击修炼 = 0
			self.参战单位[n].法术修炼 = 0
			self.参战单位[n].防御修炼 = 0
			self.参战单位[n].抗法修炼 = 0
		else
			self.参战单位[n].攻击修炼 = self.参战单位[n].修炼.攻修 or 0
			self.参战单位[n].法术修炼 = self.参战单位[n].修炼.攻修 or 0
			self.参战单位[n].防御修炼 = self.参战单位[n].修炼.物抗 or 0
			self.参战单位[n].抗法修炼 = self.参战单位[n].修炼.法抗 or 0
		end
		-- self:加载法宝(n)
	end
end

function 战斗处理类:捕捉计算(编号)
	local 目标 = self.参战单位[编号].指令.目标
	if self:取目标状态(编号, 目标, 1) == false or not self.参战单位[目标].可捕捉  then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/目标当前无法被捕获")
		return
	end
	if self.参战单位[目标].类型 == "角色" or self.参战单位[目标].类型 == "召唤" then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/非法修改数据已做警告!")
		__S服务:输出("玩家"..self.参战单位[编号].玩家id.." 非法修改数据警告!抓捕召唤兽")
		return
	end
	if self.参战单位[目标].精灵 then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你无法捕获这样的目标")
		return
	end
	if self.参战单位[编号].魔法 < qz(self.参战单位[目标].等级 * 0.5 + 20) then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "你没有足够的魔法")
		return
	end
	if 玩家数据[self.参战单位[编号].玩家id].角色:取新增宝宝数量() == false then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "你无法携带更多的宝宝了")
		return
	end
	local slsj = 取宝宝(self.参战单位[目标].模型)
	if slsj[1] == nil then return self:添加提示(self.参战单位[编号].玩家id, 编号, "该召唤兽目前无法捕捉，请通知管理员更新") end
	-- if slsj[1] == nil or slsj[1] > self.参战单位[编号].等级 then return self:添加提示(self.参战单位[编号].玩家id, 编号, "你目前的等级无法捕捉次召唤兽") end
	self.执行等待 = self.执行等待 + 15
	self:减少魔法(目标,qz(self.参战单位[目标].等级 * 0.5 + 20))
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 300, 攻击方 = 编号, 挨打方 = {{挨打方 = 目标}}}
	local 初始几率 = 45
	初始几率 = 初始几率 + qz(self.参战单位[目标].最大气血 / self.参战单位[目标].气血) * 10 + qz(self.参战单位[目标].猎术修炼 * 3)
	self.战斗流程[#self.战斗流程].宝宝 = 玩家数据[self.参战单位[编号].玩家id].角色.宠物.模型
	self.战斗流程[#self.战斗流程].名称 = 玩家数据[self.参战单位[编号].玩家id].角色.宠物.名称
	local ls = 0
	-- if self:取符石技能(编号, "心灵手巧") then
	--  ls = ls + self.参战单位[编号].符石技能["心灵手巧"]
	-- end
	if 取随机数() <= 初始几率 + ls then
		self.战斗流程[#self.战斗流程].捕捉成功 = true
		if self.战斗类型==110001 then
			礼包奖励类:增加宠物(self.参战单位[编号].玩家id,"狸","攻",10,1)
		else
			玩家数据[self.参战单位[编号].玩家id].召唤兽:添加召唤兽(self.参战单位[目标].模型, self.参战单位[目标].名称, self.参战单位[目标].分类, 属性, 0, 染色方案, self.参战单位[目标].技能, 资质组, 成长, 参战等级, 属性表)
		end

		self.参战单位[目标].气血 = 0
		self.参战单位[目标].捕捉 = true
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/你成功捕获了#R/"..self.参战单位[目标].名称)
	end
end

function 战斗处理类:法术计算(编号)
	-- local 名称 = self.参战单位[编号].指令.参数
	local zhiling
	if self.参战单位[编号].奇袭指令 then
		zhiling = self.参战单位[编号].奇袭指令
	else
		zhiling = self.参战单位[编号].指令
	end
	local 名称 = zhiling.参数
	local 等级 = self:取技能等级(编号, 名称)
	local 类型 = skill:取技能类型(名称)
	if 名称==nil then
		print("没有技能名字")
		return
	end
	if 类型 == "法攻技能" then
		self:法攻技能计算(编号, 名称, 等级, 1)
		if self.参战单位[编号].法术状态.齐天神通~=nil and 取随机数()<=50 and skill如意神通[名称] then
			self:法攻技能计算(编号, 名称, 等级, 1)
			return
		end
		if not self.PK战斗 and self.参战单位[编号].本命法宝 and self.参战单位[编号].本命法宝.开启 and self.参战单位[编号].本命法宝.耐久>0 then
			if 名称=="龙卷雨击" and self.参战单位[编号].本命法宝.名称=="凝海珠" and  取随机数(1,100) < self.参战单位[编号].本命法宝.等级*1.5+1 then
				self:法攻技能计算(编号, 名称, 等级, 0.5)
			end
		end

		if 名称~="风卷残云" and 名称 ~= "叱咤风云" and self.参战单位[编号].法连 ~= nil and self.参战单位[编号].法连 >= 取随机数() then
			-- 法攻技能计算(编号, 名称, 等级, 伤害系数, 消耗)
			local 柳暗花明=1
			if self.参战单位[编号].柳暗花明 and self.参战单位[编号].法术状态.柳暗花明 then
				柳暗花明=self.参战单位[编号].柳暗花明
				self:取消状态("柳暗花明",self.参战单位[编号])
			end

			if self.参战单位[编号].双星爆 ~= nil then
				self:法攻技能计算(编号, 名称, 等级, (0.5*柳暗花明 + self.参战单位[编号].双星爆))
			elseif self.参战单位[编号].门派=="神木林" then --重光 门派特色
				local num = 0.5
				if self:取经脉(编号,"神木林","追击") and self:风灵消耗(self.参战单位[编号],名称,1)==1 then
					num = 0.8
				end
				self:法攻技能计算(编号, 名称, 等级, num*柳暗花明)
			else
				self:法攻技能计算(编号, 名称, 等级, 0.5*柳暗花明)
			end
		else
			if self.参战单位[编号].柳暗花明 then
				self:添加状态("柳暗花明", self.参战单位[编号], self.参战单位[编号],11,nil,1)
			end
		end
		if self.参战单位[编号].法术状态.佛法无边 then
			if self.参战单位[编号].法术状态.佛法无边.法连几率 >= 取随机数() and  skill.数据[名称].佛法加成 then --后续完善
				self:法攻技能计算(编号, 名称, 等级, 1)
			elseif 名称=="唧唧歪歪" and self:取经脉(编号,"化生寺","无量") and self:取门派是否唯一(编号,"化生寺") and 取随机数()<=35 then
				self:法攻技能计算(编号, 名称, 等级, 1)
			end
		end
		if 名称 == "叱咤风云" and self.参战单位[编号].法连 ~= nil then
			for i = 1, 3 do
				if self.参战单位[编号].法连 >= 取随机数() then
					if self.参战单位[编号].双星爆 ~= nil then
						self:法攻技能计算(编号, 名称, 等级, (0.55 + self.参战单位[编号].双星爆))
					else
						self:法攻技能计算(编号, 名称, 等级, 0.55)
					end
				else
					break
				end
			end
		end
		if self.参战单位[编号].拘魂索命 and self.参战单位[编号].拘魂索命>=4 then
			local 临时目标 = self:取单个敌方气血最低(编号)
			self.参战单位[编号].指令.目标=临时目标
			self:法攻技能计算(编号, 名称, 等级, 0.8)
			self.参战单位[编号].拘魂索命 = 0
			self.参战单位[编号].触发拘魂 = 1
		end
		if 名称=="亢龙归海" and self:取目标状态(编号, self.参战单位[编号].指令.目标, 1) then
			self:法攻技能计算(编号, "亢龙归海", 等级, 1)
		-- elseif 名称 == "血雨" and self.参战单位[编号].法术状态.雾痕 then
		--  self:取消状态("雾痕",self.参战单位[编号])
		--  self.参战单位[编号].JM.血雨 = 1
		--  self:法攻技能计算(编号, 名称, 等级, 1)
		elseif 名称 == "摇头摆尾" then
			local jn1={"三昧真火","飞砂走石"}
			jn1=jn1[取随机数(1,2)]
			self.参战单位[编号].指令.参数=jn1
			self:法攻技能计算(编号, jn1, self:取技能等级(编号, jn1), 1)
			if self:取经脉(编号,"魔王寨","连营") then
				for i=1,3 do
					if 30 >= 取随机数() then
						jn1={"三昧真火","飞砂走石"}
						local jn2=jn1[取随机数(1,2)]
						self.参战单位[编号].指令.目标 = self:取单个敌方目标(编号)
						self:法攻技能计算(编号, "摇头摆尾", self:取技能等级(编号, "摇头摆尾"), 0.4)
						self:法攻技能计算(编号, jn2, self:取技能等级(编号, jn2), 0.4)
					else
						break
					end
				end
			end
		elseif 名称 == "谆谆教诲" and self:取经脉(编号,"化生寺","修习") and 取随机数()<=25 then
			self:法攻技能计算(编号, 名称, 等级, 1)
		end
		if 名称 == "谆谆教诲" and 名称 == "唧唧歪歪" and self:取被动(编号,"聚气") then
			self.参战单位[编号].聚气={概率=15,效果=30}
			if self:取经脉(编号,"化生寺","聚念") then
				self.参战单位[编号].聚气={概率=15,效果=75}
			elseif self:取经脉(编号,"化生寺","磅礴") then
				self.参战单位[编号].聚气={概率=60,效果=30}
			end
		end

	elseif 类型 == "物攻技能" then
		local cf
		cf = self:物攻技能计算(编号, 名称, 等级)
		if cf == "重复狮搏" then
			local 临时目标 = self:取单个敌方目标(编号)
			if 临时目标~=0 then
				self.参战单位[编号].指令.目标=临时目标
				self:物攻技能计算(编号,名称,等级)
			end
			return
		elseif 名称 == "六道无量" then
			for a = 1, #self.参战单位 do
				if self.参战单位[a].队伍 ~= self.参战单位[编号].队伍 and a~= self.参战单位[编号].指令.目标 and self:取目标状态(编号,a,1) then
					for k,v in pairs(self.参战单位[a].法术状态) do
						if k=="尸腐毒" then
							self.参战单位[编号].指令.目标=a
							self:物攻技能计算(编号, 名称, 等级)
							return
						end
					end
				end
			end
			return
		elseif self.参战单位[编号].法术状态.齐天神通~=nil and 取随机数()<=50 and (名称=="当头一棒" or 名称=="神针撼海" or 名称=="杀威铁棒" or 名称=="棒打雄风" or 名称=="棒打雄风") then
			self:物攻技能计算(编号, 名称, 等级)
			return
		end
		if self.参战单位[编号].法术状态.佛法无边 and self.参战单位[编号].法术状态.佛法无边.法连几率 >= 取随机数() and  skill.数据[名称].佛法加成 then
			self:物攻技能计算(编号, 名称, 等级)
		end
		if 名称 == "幸运一击" and  cf == "幸运一击" then
			self.战斗流程[#self.战斗流程].幸运一击 = "幸运一击"
			if self.参战单位[编号].法术状态.杀气诀 and self.参战单位[编号].jianshe  then
				local 目标数 = 3
				local 溅射目标=self:取多个溅射目标(编号,目标,目标数+1)
				for i=1,#溅射目标 do
					if 溅射目标[i] ~= 目标 and 目标数~=0 then
						战斗计算:添加掉血(self,溅射目标[i],self.参战单位[编号].伤害* self.参战单位[编号].jianshe,编号)
					end
				end
			end

			if #self.参战单位[编号].追加法术 > 0 then
				for i = 1, #self.参战单位[编号].追加法术 do

					self.参战单位[编号].指令.类型 = "法术"
					self.参战单位[编号].指令.参数 = self.参战单位[编号].追加法术[i].名称
					local 技能类型 = skill.数据[self.参战单位[编号].追加法术[i].名称]
					if 技能类型 and 技能类型.技能类型 then
						技能类型 = 技能类型.技能类型
						local 目标 = self.参战单位[编号].指令.目标
						if 技能类型 == "增益技能" then
							self.参战单位[编号].指令.目标 = 编号
						elseif (技能类型 == "单体封印" or 技能类型 == "群体封印") and self.参战单位[目标] and 初始技能计算:取是否被封印(self, 目标) then
							self.参战单位[编号].指令.目标 = self:NPC_AI取敌方可封印单位(编号)
						end
					end

					self:法术计算(编号, 1)

					self.战斗流程[#self.战斗流程].幸运一击 = self.参战单位[编号].追加法术[i].名称
				end
			end

			self:添加状态("幸运一击", self.参战单位[编号], self.参战单位[编号], 69)
			-- 新增本命法宝
			    if not self.PK战斗 and self.参战单位[编号].本命法宝 and self.参战单位[编号].本命法宝.开启 and self.参战单位[编号].本命法宝.耐久>0 then
			        if self.参战单位[编号].本命法宝.名称=="鸣鸿刀" and self.参战单位[编号].门派=="大唐官府" and 取随机数(1,100) <= self.参战单位[编号].本命法宝.等级*1 then
			            self:取消状态("幸运一击", self.参战单位[编号])
			        end
			    end
		end
	elseif 类型 == "固伤技能" then
		self:固伤技能计算(编号, 名称, 等级)
		if 名称=="尸腐毒" then
			if self:取指定法宝(编号, "九幽") then
				if self:取指定法宝境界(编号, "九幽") >= 取随机数(1, 60) then
					self.参战单位[编号].指令.目标 = self:取单个敌方目标(编号)
					self:固伤技能计算(编号, 名称, 等级)
				end
			end
		end
		if self.参战单位[编号].缘起 then
			if sj()<=self:敌方指定状态数量(编号,"紧箍咒")*0.08 then
				self:固伤技能计算(编号, 名称, 等级)
			end
		end
	elseif 类型 == "增益技能" then
		self:增益技能计算(编号, 名称, 等级)
		if self.参战单位[编号].门派=="化生寺" and self:取被动(编号,"聚气") then
			self.参战单位[编号].聚气={概率=15,效果=30}
			if self:取经脉(编号,"化生寺","聚念") then
				self.参战单位[编号].聚气={概率=15,效果=75}
			elseif self:取经脉(编号,"化生寺","磅礴") then
				self.参战单位[编号].聚气={概率=60,效果=30}
			end
		end
	elseif 类型 == "减益技能" then
		self:减益技能计算(编号, 名称, 等级)
	elseif 类型 == "恢复技能" then
		self:恢复技能计算(编号, 名称, 等级)
	elseif 类型 == "单体封印" then
		if 名称 == "碎玉弄影" then
			self:单体封印技能计算(编号,名称, 等级)
			if self.参战单位[self.参战单位[编号].指令.目标].法术状态.似玉生香 == nil then
				self:单体封印技能计算(编号,"碎玉弄影", 等级)
			end
		elseif self.参战单位[编号].额外目标数~=nil then
			self:群体封印技能计算(编号, 名称, 等级)
		else
			self:单体封印技能计算(编号, 名称, 等级)
		end
		if   名称 == "失心符" then
			if not self.PK战斗 and self.参战单位[编号].本命法宝 and self.参战单位[编号].本命法宝.开启 and self.参战单位[编号].本命法宝.耐久>0 then
				if  self.参战单位[编号].本命法宝.名称=="天师符" and  self.参战单位[编号].门派=="方寸山" and 取随机数(1,100) < self.参战单位[编号].本命法宝.等级  then
					 self.参战单位[编号].指令.目标=self:取单个敌方目标(编号)

					self:单体封印技能计算(编号, 名称, 等级)
				end
			end
		end
	elseif 类型 == "群体封印" then
		self:群体封印技能计算(编号, 名称, 等级)
	elseif 类型 == '九黎技能' then
		if 名称 == '三荒尽灭' then
		    物理技能计算:三荒尽灭处理(编号, 名称, 等级, self)
		 elseif 名称 == '枫魂汲魄' then
		    物理技能计算:枫魂汲魄处理(编号, 名称, 等级, self)
		elseif 名称 == '力辟苍穹' or 名称 == '魔神之刃' then
		    物理技能计算:力辟苍穹处理(编号, 名称, 等级, self)
		end
	elseif 类型 == "特殊技能" then
		if 名称=="琴音三叠" then
			战斗技能:琴音三叠(编号, 名称, 等级, self)
		elseif 名称=="惊天动地" then
			战斗技能:惊天动地一(编号, 名称, 等级, self)
		elseif 名称=="移行换影" then
			战斗技能:移行换影(编号, 名称, 等级, self)
		elseif 名称 == "妙手空空" then
			self:妙手空空计算(编号, 名称, 等级)
		elseif 名称 == "月光" then
			self:法攻技能计算(编号, 名称, 等级, 1)
			local 目标数 = qz(等级/30)
			if 目标数>=3 then
				目标数=3
			end
			if 目标数>0 then
				for i=1,目标数 do
					local 目标 = self:取单个敌方目标(编号)
					if 目标 and self.参战单位[目标] then
						self.战斗流程[#self.战斗流程+1]={流程=311,攻击方=编号,挨打方={},提示={允许=false}}
						战斗法术计算:法攻技能计算1(编号,名称,等级,目标,目标数,1,0.5,self)
					end
				end
			end
		end
	end
end
function 战斗处理类:取多个九黎目标(编号,目标,数量)--九黎
	local 目标组 = {}

	-- 初始目标验证
	if self:取目标状态(编号,目标,1) and not self.参战单位[目标].九黎浮空 then
		if self.参战单位[目标].队伍 ~= self.参战单位[编号].队伍 then
			table.insert(目标组, 目标)
		end
	end

	-- 如果目标组已经满足数量要求，直接返回
	if #目标组 >= 数量 then
		return 目标组
	end

	local 临时目标组 = {}
	local 九黎浮空目标组 = {}

	-- 遍历所有单位
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
			local 添加 = true
			for j = 1, #目标组 do
				if 目标组[j] == n then
					添加 = false
					break
				end
			end
			if 添加 then
				if not self.参战单位[n].九黎浮空 then
					table.insert(临时目标组, {a = n, b = self.参战单位[n].速度})
				else
					table.insert(九黎浮空目标组, {a = n, b = self.参战单位[n].速度})
				end
			end
		end
	end

	-- 按速度排序
	table.sort(临时目标组, function(a, b) return a.b > b.b end)
	table.sort(九黎浮空目标组, function(a, b) return a.b > b.b end)

	-- 从临时目标组中添加目标
	for n = 1, #临时目标组 do
		if #目标组 < 数量 then
			table.insert(目标组, 临时目标组[n].a)
		else
			break
		end
	end

	-- 如果未达到数量要求，从九黎浮空目标组中添加目标
	for n = 1, #九黎浮空目标组 do
		if #目标组 < 数量 then
			table.insert(目标组, 九黎浮空目标组[n].a)
		else
			break
		end
	end

	return 目标组
end
function 战斗处理类:九黎城连击数处理(编号, 次数)
	if not 次数 or type(次数) ~= 'number' then
	    return
	end
	if self.参战单位[编号] then
	    if not self.参战单位[编号].九黎连击次数 then
	        self.参战单位[编号].九黎连击次数 = 0
	    end
	    self.参战单位[编号].九黎连击次数 = self.参战单位[编号].九黎连击次数 + 次数
	end
end--九黎
function 战斗处理类:添加提示(id, 攻击方, 内容)
	if self.参战单位[攻击方].队伍 == 0 then return end
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 900, 攻击方 = 攻击方, id = id, 内容 = 内容}
end

function 战斗处理类:添加提示1(id, 攻击方, 内容)
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 901, 攻击方 = 攻击方, id = id, 内容 = 内容}
	if self.参战单位[攻击方].队伍 == 0 then return end
end

function 战斗处理类:飞镖计算(编号, id组)
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 611, 攻击方 = 编号, 挨打方 = {}}
	self.执行等待 = self.执行等待 + 10
	for n = 1, #id组 do
		if self:取目标状态(编号, id组[n].id, 1) then
			self.战斗流程[#self.战斗流程].挨打方[#self.战斗流程[#self.战斗流程].挨打方 + 1] = {挨打方 = id组[n].id, 伤害 = id组[n].伤害}
			self.战斗流程[#self.战斗流程].挨打方[#self.战斗流程[#self.战斗流程].挨打方].死亡 = self:减少气血(id组[n].id, id组[n].伤害, 编号, 名称)
		end
	end
end

function 战斗处理类:妙手空空计算(编号, 名称, 等级)
	local 目标 = self.参战单位[编号].指令.目标
	if self.参战单位[目标].气血 <= 0 then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/对方已经死了，你忍心从尸体上偷东西？")
		return
	elseif self.战斗类型 ~= 100001 and self.战斗类型 ~= 100007 then
		return
	elseif self.参战单位[目标].偷盗 then
		self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/对方身上已经没有宝物了")
		return
	elseif 初始技能计算:技能消耗(self,self.参战单位[编号], self.参战单位[目标].等级,"魔法", "妙手空空") == false then
		self.战斗流程[#self.战斗流程+1]={流程=6,战斗提示={内容="行动失败",编号=编号}}
		return
	end
	self.执行等待 = self.执行等待 + 1
	local id = self.参战单位[编号].玩家id
	if self.参战单位[目标].精灵 == nil then
		if 等级 * 10 >= 取随机数() then
			local 随机金钱 = 取随机数(10, 100)
			玩家数据[id].角色:添加银子(随机金钱, "[战斗]妙手空空从"..self.参战单位[目标].名称.."、"..self.参战单位[目标].模型.."身上盗取")
			self:添加提示1(self.参战单位[编号].玩家id, 编号, "你得到了"..随机金钱.."金钱")
			self.参战单位[目标].偷盗 = true
			return
		else
			self:添加提示1(self.参战单位[编号].玩家id, 编号, "对方发觉了你这个行为，机灵地躲过去了！")
		end
	elseif self.参战单位[目标].精灵 then
		if 等级 * 10 >= 取随机数() then
			local 奖励参数 = 取随机数(1, 100)
			if 奖励参数 <= 40 then
				local 随机金钱 = 取随机数(500, 10000)
				玩家数据[id].角色:添加银子(随机金钱, "[战斗]妙手空空从"..self.参战单位[目标].名称.."、"..self.参战单位[目标].模型.."身上盗取")
				self:添加提示1(self.参战单位[编号].玩家id, 编号, "你得到了"..随机金钱.."金钱")
			elseif 奖励参数 <= 60 then
				玩家数据[id].道具:给予道具(id, "金柳露")
				self:添加提示1(self.参战单位[编号].玩家id, 编号, "你得到了#R/金柳露")
			elseif 奖励参数 <= 80 then
				local 临时等级 = math.floor(self.参战单位[目标].等级 / 10)
				if 临时等级 > 8 then 临时等级 = 8 end
				if 临时等级 > 2 then
					临时等级 = 取随机数(临时等级 - 1, 临时等级)
				end
				local 临时名称 = 玩家数据[id].道具:取随机装备(id, 临时等级, true)
				self:添加提示1(self.参战单位[编号].玩家id, 编号, "你得到了#R/"..临时名称)
			else
				if 变身卡数据[self.参战单位[目标].模型] ~= nil then
					玩家数据[id].道具:给予道具(id, "怪物卡片", self.参战单位[目标].模型)
					self:添加提示1(self.参战单位[编号].玩家id, 编号, "你得到了#R/怪物卡片")
				else
					local 随机金钱 = 取随机数(500, 10000)
					玩家数据[id].角色:添加银子(随机金钱, "[战斗]妙手空空从"..self.参战单位[目标].名称.."、"..self.参战单位[目标].模型.."身上盗取")
					self:添加提示1(self.参战单位[编号].玩家id, 编号, "你得到了"..随机金钱.."金钱")
				end
			end
			self.参战单位[目标].偷盗 = true
			return
		else
			self:添加提示1(self.参战单位[编号].玩家id, 编号, "对方发觉了你这个行为，机灵地躲过去了！")
		end
	end
end

function 战斗处理类:恢复技能计算(编号, 名称, 等级, lsmb)
	-- local 目标 = lsmb
	-- if lsmb == nil then
	-- 	目标 = self.参战单位[编号].指令.目标
	-- end
	local zhiling
	if self.参战单位[编号].奇袭指令 then
		zhiling = self.参战单位[编号].奇袭指令
	else
		zhiling = self.参战单位[编号].指令
	end
	local 目标 = lsmb
	if lsmb == nil then
		目标 = zhiling.目标
	end
	local 目标数 = 0
	local zza = skill.数据[名称]
	if zza.指定对象~=nil then
		目标 = 编号
	end
	if 名称 == "活血" and 目标==编号 then --不能对自己
		self.参战单位[编号].指令.目标 = self:取单个友方气血最低(编号)
		目标 = self:取单个友方气血最低(编号)
	end

	-- if 名称 == "归元咒" or 名称 == "乾天罡气" or 名称 == "气归术" or 名称 == "命归术" or 名称 == "凝神诀" or 名称 == "凝气诀" or 名称 == "电光火石"or 名称 == "绝处逢生"  then
	--  目标 = 编号
	-- elseif 名称 == "醍醐灌顶" and self.参战单位[目标].类型 ~= "角色" then
	--  return
	-- end
	-- if self.参战单位[目标].法术状态.心如明镜 then
	--  return
	-- end

	if 名称 ~= "我佛慈悲" and 名称 ~= "杨柳甘露" and 名称 ~= "起死回生" and 名称 ~= "回魂咒" and 名称 ~= "还阳术" and 名称 ~= "莲花心音" and 名称~="救死扶伤1"
		and 名称 ~= "魍魉追魂" and 名称 ~="由己渡人" and 名称 ~="金刚怒目" and 名称 ~= "超级神迹复活" then
		目标数 = zza.技能人数(等级,self.参战单位[编号],self.PK战斗)
		if 名称 == "地涌金莲" then
			if self:取被动(编号, "金莲") then
				if 等级>=45 then
					目标数 = 目标数 + 1
				elseif 等级>=105 then
					目标数 = 目标数 + 1
				end
			end
			-- if self.参战单位[编号].法术状态.燃血术 and self.参战单位[编号].法术状态.燃血术.华光~=nil then
			if self:取经脉(编号, "无底洞", "华光") then ----------佬伍修改（修改无底洞华光经脉为直接增加一个加血目标）
				目标数 = 目标数 + 1
			end
			if self.参战单位[编号].法术状态.陷阱 then
				目标数 = 目标数 + 1
			end
		end
		目标  = self:取多个友方目标(编号, 目标, 目标数, 名称)

	else
		if 名称 == "莲花心音" then
			if self.参战单位[目标].类型 == "bb" and self.参战单位[目标].鬼魂 and  self.参战单位[目标].气血 <= 0  then
				目标 = {目标}
			else
				return
			end
		elseif 名称 == "魍魉追魂" then
			if self.参战单位[目标].气血 > 0 or self.参战单位[目标].类型 == "bb" then
				return
			else
				目标 = {目标}
			end
		elseif 名称 == "金刚怒目" then
			if self.参战单位[目标].气血 <= 0 or self.参战单位[目标].类型 == "bb" or 目标 == 编号 then
				return
			else
				目标 = {目标}
			end
		else
			if 初始技能计算:不可复活(self.参战单位[目标])  or self.参战单位[目标].类型 == "bb" or (self.参战单位[目标].气血上限 and self.参战单位[目标].气血上限<=0) then
				return
			else
				目标 = {目标}
			end
		end
	end
	if #目标 == 0 then return end
	目标数 = #目标
	local 消耗1,类型1 = zza.技能消耗(目标数,self.参战单位[编号])
	if 初始技能计算:技能消耗(self,self.参战单位[编号],消耗1,类型1,名称)==false then
		self.战斗流程[#self.战斗流程+1]={流程=6,战斗提示={内容="行动失败",编号=编号}}
		return
	end
	--调试信息(编号.."未到达技能消耗要求")
	if not self.PK战斗 and self:取目标类型(编号) == "玩家" then
		self.参战单位[编号].耐久计算.施法=self.参战单位[编号].耐久计算.施法+1
	end
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 60, 攻击方 = 编号, 挨打方 = {}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
	self.执行等待 = self.执行等待 + 10
	if zza.是否特技~=nil then
		self.战斗流程[#self.战斗流程].特技名称=名称
	end
	local 气血 = 0
	local 复活 = false

	for n = 1, 目标数 do
		if self.参战单位[目标[n]].法术状态 and self.参战单位[目标[n]].法术状态.超级永恒 then
			local zjhu=0
			if self.参战单位[目标[n]].法术状态.超级永恒.可增回合 > 0 then
				zjhu = self.参战单位[目标[n]].法术状态.超级永恒.回合 * 2 --增加100%持续回合数
				if zjhu > self.参战单位[目标[n]].法术状态.超级永恒.可增回合 then
					zjhu = self.参战单位[目标[n]].法术状态.超级永恒.可增回合
				end
			end
			self.参战单位[目标[n]].法术状态.超级永恒.回合 = zjhu
		end
	end
 --    for n = 1, 目标数 do
	--  self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
	-- end

	if 名称 == "地涌金莲" then --最大气血*0.03
		local 系数 = 1
		local 附加
		if self.参战单位[编号].法术状态.陷阱 then
			系数 = 0.7
			if self.参战单位[编号].法术状态.陷阱.层数>1 then
				self.参战单位[编号].法术状态.陷阱.层数 = self.参战单位[编号].法术状态.陷阱.层数 -1
			else
				self:取消状态("陷阱",self.参战单位[编号])
			end
		end
		if self.参战单位[编号].法术状态.燃血术 then
			附加 = 1
			if self.参战单位[编号].法术状态.燃血术.强化~=nil then
				附加 = 2
			end
			if self.参战单位[编号].法术状态.燃血术.层数>1 then
				self.参战单位[编号].法术状态.燃血术.层数=self.参战单位[编号].法术状态.燃血术.层数-1
			else
				self:取消状态("燃血术",self.参战单位[编号])
			end
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:地涌金莲(self,编号,目标[n],目标数,系数,附加)
		end
	elseif 名称 == "推气过宫" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:推气过宫(self,编号,目标[n],系数,1-目标数*0.05)
		end
	elseif 名称 == "推拿" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:推拿(self,编号,目标[n],系数)
		end
	elseif 名称 == "活血" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:活血(self,编号,目标[n],系数)
		end
	elseif 名称 == "六尘不染" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:六尘不染(self,编号,目标[n],系数)
		end
	elseif 名称 == "妙手回春" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复伤势 = 战斗技能:妙手回春(self,编号,目标[n],系数)
		end
	elseif 名称 == "救死扶伤" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:救死扶伤(self,编号,目标[n],系数)
		end
	elseif 名称 == "醍醐灌顶" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:醍醐灌顶(self,编号,目标[n],系数)
		end
	elseif 名称 == "妙悟" then
		local 系数 = 1
		if self:取指定法宝(编号, "慈悲") then
			系数 = 2
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:妙悟(self,编号,目标[n],系数)
		end
	elseif 名称 == "舍生取义" then
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:舍生取义(self,编号,目标[n])
		end
	elseif 名称 == "电光火石" then
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
		end
		self:添加状态("霹雳弦惊", self.参战单位[编号], self.参战单位[编号],11,nil,1)
		self:添加状态("雷怒霆激", self.参战单位[编号], self.参战单位[编号],11,nil,1)
	elseif 名称 == "魍魉追魂" then
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
		end
		self:添加状态("魍魉追魂", self.参战单位[目标[1]], self.参战单位[编号],11,nil,1)
	elseif 名称 == "玉清诀" then
		if self:取经脉(编号, "无底洞", "暗潮") then
			local xh = qz(self.参战单位[编号].气血*0.1)
			self.参战单位[编号].气血 = self.参战单位[编号].气血 - xh
			self.战斗流程[#self.战斗流程].扣除气血 = xh
			for n = 1, 目标数 do
				self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
				self:解除状态结果(self.参战单位[目标[n]], 初始技能计算:取封印状态法术(),nil,"玉清诀")
			end
		else
			for n = 1, 目标数 do
				self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
				self:解除状态结果(self.参战单位[目标[n]], 初始技能计算:取异常状态法术(self.参战单位[目标[n]].法术状态),nil,"玉清诀")
				if self:取经脉(编号, "女儿村", "花护") then
					self:添加状态("花护", self.参战单位[目标[n]], self.参战单位[编号],11)
				end
			end
		end
	elseif 名称 == "慈航普度" then
--=============================================================--新增
    -- 专属分支：6星以上难度怪可复活队友
    if self.参战单位[编号].慈航 then
        for n = 1, 目标数 do
            self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
            if 目标[n] ~= 编号 then
                self.参战单位[目标[n]].死亡 = nil
                self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:慈航普度(self,编号,目标[n])
                self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
            end
        end
        -- 放完消失
        self.参战单位[编号].气血 = 0
        self.战斗流程[#self.战斗流程 + 1] = {流程 = 625, 攻击方 = 编号}
        self.执行等待 = self.执行等待 + 3
        return
    end
--=============================================================
		if self.参战单位[编号].不可操作==nil then
			if self.参战单位[编号].气血>self.参战单位[编号].最大气血*0.1 then
				local dx = qz(self.参战单位[编号].气血-self.参战单位[编号].最大气血*0.1)
				self.参战单位[编号].气血=qz(self.参战单位[编号].最大气血*0.1)
				self.战斗流程[#self.战斗流程].扣除气血 = dx
			end
			if self.参战单位[编号].气血上限 then
				self.参战单位[编号].气血上限=qz(self.参战单位[编号].最大气血*0.1)
			end
			self:减少魔法(编号,self.参战单位[编号].魔法)
		end
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			if 目标[n] ~= 编号 then
				self.参战单位[目标[n]].死亡 = nil
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:慈航普度(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
			end
		end
		if self.参战单位[编号].不可操作 then --地煞
			self.参战单位[编号].气血=0
			self.战斗流程[#self.战斗流程 + 1] = {流程 = 625, 攻击方 = 编号}
			self.执行等待 = self.执行等待 + 3
			for i=1,#self.参战单位 do
				if self.参战单位[i].队伍==self.参战单位[编号].队伍 and i~=编号 then
					self.参战单位[i].共生=true
				end
			end
		end
	elseif 名称 == "还阳术" then
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			self.参战单位[目标[n]].死亡 = nil
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:还阳术(self,编号,目标[n])
			self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
		end
	else
		for n = 1, 目标数 do
			self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
			if 名称 == "凝气诀" then
				战斗技能:凝气诀(self,编号,目标[n])
			elseif 名称 == "凝神诀" then
				战斗技能:凝神诀(self,编号,目标[n])
			elseif 名称 == "金刚怒目" then
				self:增加愤怒(目标[n],80,true)
				self.战斗流程[#self.战斗流程].愤怒 = self.参战单位[目标[n]].愤怒
			elseif 名称 == "心疗术" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:心疗术(self,编号,目标[n])
			elseif 名称 == "命归术" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:命归术(self,编号,目标[n])
			elseif 名称 == "气疗术" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:气疗术(self,编号,目标[n])
			elseif 名称 == "命疗术" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:命疗术(self,编号,目标[n])
			elseif 名称 == "气归术" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:气归术(self,编号,目标[n])
			elseif 名称 == "起死回生" then
				self.参战单位[目标[n]].死亡 = nil
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:起死回生(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
			elseif 名称 == "超级神迹复活" then
				self.参战单位[目标[n]].死亡 = nil
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:超级神迹复活(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
			elseif 名称 == "回魂咒" then
				self.参战单位[目标[n]].死亡 = nil
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:回魂咒(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
			elseif 名称 == "救死扶伤1" then
				self.参战单位[目标[n]].死亡 = nil
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:救死扶伤1(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true

			elseif 名称 == "四海升平" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:四海升平(self,编号,目标[n])
			elseif 名称 == "水清诀" then
				战斗技能:水清诀(self,编号,目标[n])
			elseif 名称 == "冰清诀" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:冰清诀(self,编号,目标[n])
			elseif 名称 == "晶清诀" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:晶清诀(self,编号,目标[n])
			elseif 名称 == "逆境" then
				self:解除状态结果(self.参战单位[目标[n]], 初始技能计算:取异常状态法术(self.参战单位[目标[n]].法术状态),nil,"晶清诀")
			elseif 名称 == "清心咒" and 取随机数()<=70 then
				self:解除状态结果(self.参战单位[目标[1]], 初始技能计算:取法宝封印法术(),nil,"清心咒")
			elseif 名称 == "百毒不侵" then
				战斗技能:百毒不侵(self,编号,目标[n])
			elseif 名称 == "宁心" then
				战斗技能:宁心(self,编号,目标[n])
			elseif 名称 == "复苏" then
				战斗技能:复苏(self,编号,目标[n])
			elseif 名称 == "驱魔" then
				战斗技能:驱魔(self,编号,目标[n])
			elseif 名称 == "寡欲令" then
				战斗技能:寡欲令(self,编号,目标[n])
			elseif 名称 == "绝处逢生" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:绝处逢生(self,编号,目标[n])
			elseif 名称 == "乾天罡气" then
				local xh=20
				if self:取经脉(编号,"方寸山","吐纳") and self.参战单位[编号].气血>self.参战单位[编号].最大气血*0.5 then
					xh=self.参战单位[编号].最大气血-self.参战单位[编号].气血
					战斗技能:乾天罡气(self,编号,编号,xh)
				else
					战斗技能:乾天罡气(self,编号,编号)
				end
				self.参战单位[编号].气血 = self.参战单位[编号].气血 - xh
				self.战斗流程[#self.战斗流程].扣除气血 = xh
			elseif 名称 == "莲花心音" then
				self.参战单位[目标[n]].死亡 = nil
				self:取消状态("复活",self.参战单位[目标[n]])
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:莲花心音(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
			elseif 名称 == "我佛慈悲" then
				self.参战单位[目标[n]].死亡 = nil
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:我佛慈悲(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
				if self.参战单位[目标[n]].类型 == "角色" or self.参战单位[目标[n]].类型 == "系统角色" then
					self.参战单位[目标[n]].我佛慈悲护体 = self.回合数
				end
			elseif 名称 == "杨柳甘露" then
				self.参战单位[目标[n]].死亡 = nil
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:杨柳甘露(self,编号,目标[n])
				self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
			elseif 名称 == "由己渡人" then
				local dx = qz(self.参战单位[编号].气血*0.1)
				if self.参战单位[编号].气血>dx then
					self.参战单位[编号].气血=self.参战单位[编号].气血-dx
					self.战斗流程[#self.战斗流程].扣除气血 = dx
					self.参战单位[目标[n]].死亡 = nil
					复活 = true
					self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:由己渡人(self,编号,目标[n])
					self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
				end
			elseif 名称 == "清风望月" then
				self:解除状态结果(self.参战单位[目标[n]], 初始技能计算:取封印状态法术())
				self:添加状态("疯狂", self.参战单位[编号], self.参战单位[编号],11)
			elseif 名称=="净土灵华" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:净土灵华(self,编号,目标[n])
			elseif 名称 == "自在心法" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:自在心法(self,编号,目标[n])
			elseif 名称 == "星月之惠" then
				-- self.战斗流程[#self.战斗流程].挨打方[n].挨打方 = 编号
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:星月之惠(self,编号,目标[n])
			elseif 名称 == "解封" then
				战斗技能:解封(self,编号,目标[n])
			elseif 名称 == "驱尸" then
				战斗技能:驱尸(self,编号,目标[n])
			elseif 名称 == "解毒" then
				战斗技能:解毒(self,编号,目标[n])
			elseif 名称 == "清心" then
				战斗技能:清心(self,编号,目标[n])
			elseif 名称 == "归元咒" then
				self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:归元咒(self,编号,目标[n],1)
			end
		end
	end

	-- if 复活 then  --复活技能全加上
	--  if self:取经脉(目标[n],"凌波城","神躯") and self.参战单位[编号].战意 <= 1 then
	--      self:增加战意(目标[n],1)
	--  end
	-- end









	-- for n = 1, 目标数 do
	--  local 复活 = false
	--  local 状态名称 = {}
		-- self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
	-- end


	--  elseif 名称 == "无穷妙道" then
	--      战斗技能:无穷妙道(self,编号,目标[n])












	--  elseif 名称 == "重生" then
	--      self.参战单位[目标[n]].死亡 = nil
	--      self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 战斗技能:重生(self,编号,目标[n])
	--      if 目标[n] ~= 编号 then
	--          self.战斗流程[#self.战斗流程].挨打方[n].复活 = true
	--      end




	--  end

	-- end



end

function 战斗处理类:取单个敌方bb目标(编号)
	local 目标组={}
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) and self.参战单位[n].类型=="bb" then
			目标组[#目标组+1]=n
		end
	end
	if #目标组==0 then
		return 0
	else
		return 目标组[取随机数(1,#目标组)]
	end
end

function 战斗处理类:取特定法术状态(单位, 名称)
	if 单位.法术状态 and 单位.法术状态[名称] ~= nil then
		return true
	end
	return false
end

function 战斗处理类:判定气血百分比(编号,数额,类型)
	if self.参战单位[编号].气血 < self.参战单位[编号][类型]*数额 then
		return true
	end
	return false
end

function 战斗处理类:解除状态结果(单位,名称,类型,指定)
	local 解除 = {}
	for n = 1, #名称 do
		if 单位 and 单位.法术状态[名称[n]] ~= nil then
			local 解除判定 = true
			if 单位.法术状态[名称[n]].驱散抵抗 and 单位.法术状态[名称[n]].驱散抵抗 < 取随机数() then
				解除判定 = false
			end
			if 单位.法术状态[名称[n]].驱散抵抗 and 单位.法术状态[名称[n]].驱散抵抗 < 取随机数() then
				解除判定 = false
			end
			if 指定 then
				if 名称[n]=="魔音摄魂" or 名称[n]=="瘴气" then
					if 单位.法术状态[名称[n]].绝殇 and 单位.法术状态[名称[n]].绝殇==self.回合数() then
						解除判定 = false
					end
				elseif 名称[n]=="天罗地网" and 单位.法术状态[名称[n]].附骨~=nil and 30 < 取随机数() then
					解除判定 = false
				end
			end
			local 临时编号 = 单位.法术状态[名称[n]].攻击编号
			if 类型 == nil and 解除判定 then
				if  名称[n] == "毒" and 单位.法术状态[名称[n]].毒引 then
					local 伤害 = 600
					if 单位.气血 <= 600 then
						伤害 = 单位.气血-1
					end
					战斗计算:添加掉血(self,单位.序号,伤害,临时编号)
				elseif 名称[n] == "尸腐毒" and 单位.法术状态[名称[n]].入骨 then
					local 伤害 = qz(单位.气血*单位.法术状态[名称[n]].入骨)
					战斗计算:添加掉血(self,单位.序号,伤害,临时编号)
				elseif 名称[n] == "夺魄令" and 单位.法术状态[名称[n]].陷阱 then
					单位.陷阱={回合=1,减伤=qz(self:取技能等级(临时编号,"阴风绝章")*1.5)}
					-- 战斗数据:添加状态("陷阱", self.参战单位[临时编号], self.参战单位[临时编号],11)
					self:添加状态("陷阱", self.参战单位[临时编号], self.参战单位[临时编号],11)  ----------佬伍修改（修复战斗报错）

				elseif 名称[n]=="普渡众生" and 单位.法术状态[名称[n]].雨润 then
					local fhz = qz((单位.法术状态[名称[n]].等级 * 2 + 150) * 单位.法术状态[名称[n]].回合)
					fhz = qz(self:治疗量计算(临时编号,单位.序号,fhz,"自在心法")*0.8)
					self:动画加血流程(临时编号,fhz,"普渡众生")
				elseif 名称[n]=="蜜润" and 单位.法术状态[名称[n]].滋养 then
					self:动画加血流程(临时编号,self:取技能等级(临时编号,"驭灵咒")*单位.法术状态[名称[n]].回合,"蜜润")
				elseif (名称[n]=="明光宝烛" or 名称[n]=="金身舍利") and 单位.法术状态[名称[n]].救人~=nil then
					战斗计算:添加护盾(self,单位.序号,单位.等级*单位.法术状态[名称[n]].回合)
				end

				self:取消状态(名称[n],单位)
			end
			解除[#解除 + 1] = 名称[n]
		end
	end
	return 解除
end

function 战斗处理类:驱散状态(单位,技能,数量)
	local 解除 = {}
	for n = 1, #技能 do
		if 单位.法术状态[技能[n]] ~= nil then --这里加判断是否可以驱散
			解除[#解除 + 1] = 技能[n]
		end
	end
	if #解除==0 then
		return
	end
	if #解除>数量 then
		-- for n,v in pairs(解除) do
		--  for i=1,数量 do
		--      local k = 取随机数(1, #解除) --随机一个解除的状态编号
		--      if (解除[k]=="明光宝烛" or 解除[k]=="金身舍利") and 单位.法术状态[解除[k]].救人~=nil then
		--          战斗计算:添加护盾(self,单位.序号,单位.等级*单位.法术状态[解除[k]].回合)
		--      end
		--      self:取消状态(解除[k],单位)
		--      解除[k]=nil
		--  end
		-- end
		for i=1,数量 do
			local k = 取随机数(1, #解除) --随机一个解除的状态编号
			if (解除[k]=="明光宝烛" or 解除[k]=="金身舍利") and 单位.法术状态[解除[k]].救人~=nil then
				战斗计算:添加护盾(self,单位.序号,单位.等级*单位.法术状态[解除[k]].回合)
			end
			self:取消状态(解除[k],单位)
			table.remove(解除,k)  --随机后删除这个组里面的编号，以免二次重复取到这个k
		end
	else
		for k=1,#解除 do
			if (解除[k]=="明光宝烛" or 解除[k]=="金身舍利") and 单位.法术状态[解除[k]].救人~=nil then
				战斗计算:添加护盾(self,单位.序号,单位.等级*单位.法术状态[解除[k]].回合)
			end

			self:取消状态(解除[k],单位)
		end
	end
end



function 战斗处理类:取五行克制(攻击, 挨打)
	if 挨打 == "木" and 攻击 == "金" then
		return true
	elseif 挨打 == "土" and 攻击 == "木" then
		return true
	elseif 挨打 == "水" and 攻击 == "土" then
		return true
	elseif 挨打 == "火" and 攻击 == "水" then
		return true
	elseif 挨打 == "金" and 攻击 == "火" then
		return true
	end
	return false
end

function 战斗处理类:增益技能计算(编号, 名称, 等级, 套装状态, 法宝, 指定, 境界)
	-- local 目标 = self.参战单位[编号].指令.目标
	local zhiling
	if self.参战单位[编号].奇袭指令 then
		zhiling = self.参战单位[编号].奇袭指令
	else
		zhiling = self.参战单位[编号].指令
	end
	-- table.print(self.参战单位[编号].指令)
	local 目标 = zhiling.目标
	if 名称 == "佛法无边" and self:取经脉(编号,"化生寺","慧定") then
		目标 = 编号
	elseif 名称 == "蜜润" and self:取经脉(编号,"神木林","滋养") then
		目标 = 编号
	elseif 名称 == "幽冥鬼眼" and self:取经脉(编号,"阴曹地府","通瞑") then
		目标 = 编号
	elseif 名称 == "同舟共济" and 目标 == 编号 then
		目标 = self:取单个友方目标(编号)
	elseif 名称 == "真君显灵" and self.参战单位[编号].战意<1 then
		self.战斗流程[#self.战斗流程+1]={流程=6,战斗提示={内容="行动失败",编号=编号}}
		return
	end

	local zza = skill.数据[名称]
	--------------------修复遗志报错
	if zza == nil then
	    return
	end
	---------------------
	if zza.指定对象~=nil then
		目标 = 编号
	end
	local 目标数 = zza.技能人数(等级,self.参战单位[编号],self.PK战斗)
	if 套装状态 then
		目标 = 编号
		目标数=1
	end
	if 名称=="普渡众生" then
		if self:取指定法宝(编号, "普渡") then
			local gl = self:取指定法宝境界(编号, "普渡")*2 + 4
			if self:取经脉(编号, "普陀山", "普渡") then
				gl = gl + 20
			end
			if gl >= 取随机数() then
				目标数 = 2
				if self:取经脉(编号, "普陀山", "度厄") then
					for n = 1, #self.参战单位 do
						if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].法术状态.普渡众生 then
							return
						end
					end
					目标数 = 3
				end
			end
		end
	elseif 名称=="灵动九天" then
		if self:取经脉(编号, "普陀山", "感念") then
			if self.参战单位[编号].JM.当前流派=="莲台仙子" then
				目标数 = 目标数 + self:友方指定状态数量(编号,"普渡众生")
			elseif self.参战单位[编号].JM.当前流派=="五行咒师" then
				目标数 = 目标数 + self:敌方指定状态数量(编号,"紧箍咒")
			end
		end
	end


	if 名称 == "北冥之渊" then
		目标 = self:取多个友方bb目标(编号, 目标, 5)
	else
		目标 = self:取多个友方目标(编号, 目标, 目标数, 名称)
	end
	--调试信息(编号.."获取到的最终目标数为"..#目标)
	if #目标 == 0 then return end
	目标数 = #目标
	if 法宝== nil then
		local 消耗1,类型1 = zza.技能消耗(目标数,self.参战单位[编号])
		if 初始技能计算:技能消耗(self,self.参战单位[编号],消耗1,类型1,名称)==false then
			self.战斗流程[#self.战斗流程+1]={流程=6,战斗提示={内容="行动失败",编号=编号}}
			return
		end
	end --调试信息(编号.."未到达技能消耗要求")
	if not self.PK战斗 and self:取目标类型(编号) == "玩家" then
		self.参战单位[编号].耐久计算.施法=self.参战单位[编号].耐久计算.施法+1
	end

	self.战斗流程[#self.战斗流程 + 1] = {流程 = 53, 攻击方 = 编号, 挨打方 = {}, 全屏 = false, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
	self.执行等待 = self.执行等待 + 10

	if zza.是否特技~=nil then
		self.战斗流程[#self.战斗流程].特技名称=名称
	end
	-- if self.参战单位[目标].鬼魂~=nil and  self.参战单位[目标].高鬼魂==nil then
	--     return
	-- end

	local 结尾气血 = 0
	if 名称 == "其疾如风" or 名称 == "其徐如林" or 名称 == "侵掠如火" or 名称 == "岿然如山" then
		self.战斗流程[#self.战斗流程].全屏 = true
	elseif 名称 == "无间地狱" then
		local qqc = self:取全场状态("无间地狱")
		if qqc == false then
			self.战斗流程[#self.战斗流程].全屏 = true
			local lssj = {名称 = "无间地狱", 队伍 = nil, 回合 = 4}
			table.insert(self.全场状态, lssj)
		else
			self.全场状态[qqc].回合 = 4
		end
	elseif 名称 == "清静菩提" then
		local qqc = self:取全场状态("清静菩提")
		if qqc == false then
			self.战斗流程[#self.战斗流程].全屏 = true
			local lssj = {名称 = 名称, 队伍 = self.参战单位[编号].队伍, 回合 = 4}
			table.insert(self.全场状态, lssj)
		else
			self.全场状态[qqc].回合 = 4
		end
	elseif 名称 == "媚眼如丝" then
		local qqc = self:取全场状态("媚眼如丝")
		if qqc == false then
			self.战斗流程[#self.战斗流程].全屏 = true
			local lssj = {名称 = 名称, 队伍 = nil, 回合 = 4}
			table.insert(self.全场状态, lssj)
		else
			self.全场状态[qqc].回合 = 4
		end
	elseif 名称 == "天地洞明" then
		self.战斗流程[#self.战斗流程].全屏 = true
	elseif 名称 == "镇魂诀" then
		结尾气血 = qz(self.参战单位[编号].气血 * 0.05)
		self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
		self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
	elseif 名称 == "金蟾" then
		if 目标数 > 1 then --风墙
			结尾气血 = qz(self.参战单位[编号].气血 * 0.5)
			self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
			self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
			结尾气血 = qz(结尾气血 * ((境界 * 4 + 1) * 0.01))
			if 结尾气血 > self.参战单位[编号].等级 * 16 then
				结尾气血 = qz(self.参战单位[编号].等级 * 16)
			end
		end
	elseif 名称 == "移魂化骨" then
		结尾气血 = qz(self.参战单位[编号].最大气血 * 0.1)
		self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
		self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
	elseif 名称 == "钟馗论道" then
		结尾气血 = self.参战单位[编号].气血 - 1
		self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
		self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
	-- elseif 名称 == "北冥之渊" then
	--  self.战斗流程[#self.战斗流程].全屏 = true
	elseif 名称 == "杀气诀" and self:取经脉(编号,"大唐官府","风刃") then
		self:添加状态("风魂", self.参战单位[编号], self.参战单位[编号],11)
	elseif 名称 == "天雷灌注" then
		结尾气血 = qz(self.参战单位[编号].最大气血 *0.25)
		self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
		self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
	elseif 名称 == "天魔解体" then
		结尾气血 = qz(self.参战单位[编号].气血 *0.1)
		self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
		self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
		self:添加状态("变身", self.参战单位[编号], self.参战单位[编号],等级)
	elseif 名称 == "炼气化神" then
		self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 30,编号)
		self.战斗流程[#self.战斗流程].结尾气血 = 30
	elseif 名称 == "燃血术" then
		结尾气血 = qz(self.参战单位[编号].气血 *0.1)
		local qit = qz(self.参战单位[编号].气血上限- self.参战单位[编号].气血上限*0.1)
		if self:取经脉(编号,"无底洞","血潮") then
			结尾气血 = 结尾气血 * 2
			qit = qit * 2
		end
		self.参战单位[编号].气血上限 = qit
		if self.参战单位[编号].气血上限 < 0 then
			self.参战单位[编号].气血上限 = 0
		end
		if self:取经脉(编号, "无底洞", "盛怒") then
		self:增加愤怒(编号,20)
	    end
		self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
		self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
	elseif 名称 == "铜头铁臂" then
		local num = qz(self.参战单位[编号].最大气血/3.3)
		local max = self:取技能等级(编号,"铜头铁臂")*15
		if num>= max then
			num = max
		end
		战斗计算:添加护盾(self,编号,num)
		if self:取经脉(编号, "花果山", "愈勇") then
			self:添加状态("愈勇",self.参战单位[编号],self.参战单位[编号],69)
		end
		if self:取经脉(编号, "花果山", "斗志") then
			self.参战单位[编号].斗志=名称
		end
		if self:取经脉(编号, "花果山", "贪天") then
			self.参战单位[编号].贪天=名称
		end
		if self:取经脉(编号, "花果山", "压邪") and self.参战单位[编号].法术状态.压邪==nil then
			if self.参战单位[编号].压邪==nil then
				self.参战单位[编号].压邪={回合=2,层数=1}
			else
				self.参战单位[编号].压邪={回合=2,层数=self.参战单位[编号].压邪.层数+1}
			end
		elseif self:取经脉(编号, "花果山", "锻炼") then
			if self.参战单位[编号].锻炼==nil then
				self.参战单位[编号].锻炼={回合=2,层数=1}
			else
				self.参战单位[编号].锻炼={回合=2,层数=self.参战单位[编号].锻炼.层数+1}
			end
		end
		if self:取经脉(编号, "花果山", "自在") then
			self.参战单位[编号].自在=1
		end
		if self:取经脉(编号, "花果山", "变通") then
			self.参战单位[编号].贪天=名称
		end
		if self:取经脉(编号, "花果山", "顽性") then
			self.参战单位[编号].顽性=名称
		end
	elseif 名称 == "九幽除名" then
		if self:取经脉(编号, "花果山", "愈勇") then
			self:添加状态("愈勇",self.参战单位[编号],self.参战单位[编号],69)
		end
		if self:取经脉(编号, "花果山", "压邪") and self.参战单位[编号].法术状态.压邪==nil then
			if self.参战单位[编号].压邪==nil then
				self.参战单位[编号].压邪={回合=2,层数=1}
			else
				self.参战单位[编号].压邪={回合=2,层数=self.参战单位[编号].压邪.层数+1}
			end
		elseif self:取经脉(编号, "花果山", "锻炼") then
			if self.参战单位[编号].锻炼==nil then
				self.参战单位[编号].锻炼={回合=2,层数=1}
			else
				self.参战单位[编号].锻炼={回合=2,层数=self.参战单位[编号].锻炼.层数+1}
			end
		end
		if self:取经脉(编号, "花果山", "斗志") then
			self.参战单位[编号].斗志=名称
		end
		if self:取经脉(编号, "花果山", "贪天") then
			self.参战单位[编号].贪天=名称
		end
		if self:取经脉(编号, "花果山", "自在") then
			self.参战单位[编号].自在=1
		end
		if self:取经脉(编号, "花果山", "变通") then
			self.参战单位[编号].贪天=名称
		end
		if self:取经脉(编号, "花果山", "顽性") then
			self.参战单位[编号].顽性=名称
		end
	elseif 名称 == "无所遁形" then
		if self:取经脉(编号, "花果山", "愈勇") then
			self:添加状态("愈勇",self.参战单位[编号],self.参战单位[编号],69)
		end
		if self:取经脉(编号, "花果山", "斗志") then
			self.参战单位[编号].斗志=名称
		end
		if self:取经脉(编号, "花果山", "贪天") then
			self.参战单位[编号].贪天=名称
		end
		if self:取经脉(编号, "花果山", "压邪") and self.参战单位[编号].法术状态.压邪==nil then
			if self.参战单位[编号].压邪==nil then
				self.参战单位[编号].压邪={回合=2,层数=1}
			else
				self.参战单位[编号].压邪={回合=2,层数=self.参战单位[编号].压邪.层数+1}
			end
		elseif self:取经脉(编号, "花果山", "锻炼") then
			if self.参战单位[编号].锻炼==nil then
				self.参战单位[编号].锻炼={回合=2,层数=1}
			else
				self.参战单位[编号].锻炼={回合=2,层数=self.参战单位[编号].锻炼.层数+1}
			end
		end
		if self:取经脉(编号, "花果山", "自在") then
			self.参战单位[编号].自在=1
		end
		if self:取经脉(编号, "花果山", "变通") then
			self.参战单位[编号].贪天=名称
		end
		if self:取经脉(编号, "花果山", "顽性") then
			self.参战单位[编号].顽性=名称
		end
	elseif 名称 == "蜜润" then
		if self:风灵消耗(self.参战单位[编号],"蜜润",1)==1 then
			self.参战单位[编号].蜜润翻倍=1
		end
	end

	--前面的默认自己为目标

	for n = 1, 目标数 do
		if self.参战单位[目标[n]].法术状态 and self.参战单位[目标[n]].法术状态.超级永恒 then
			local zjhu=0
			if self.参战单位[目标[n]].法术状态.超级永恒.可增回合 > 0 then
				zjhu = self.参战单位[目标[n]].法术状态.超级永恒.回合 * 2 --增加100%持续回合数
				if zjhu > self.参战单位[目标[n]].法术状态.超级永恒.可增回合 then
					zjhu = self.参战单位[目标[n]].法术状态.超级永恒.可增回合
				end
			end
			self.参战单位[目标[n]].法术状态.超级永恒.回合 = zjhu
		end
		self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}
		if 名称 == "后发制人" then
			self:添加状态(名称, self.参战单位[编号], self.参战单位[编号],等级)
			self.参战单位[编号].法术状态.后发制人.目标 = self.参战单位[编号].指令.目标
			self.战斗流程[#self.战斗流程].挨打方[n].挨打方 = 编号
		elseif 名称 == "炎护" then
			self:添加状态(名称, self.参战单位[编号], self.参战单位[编号],等级)
			self.战斗流程[#self.战斗流程].挨打方[n].挨打方 = 编号
		elseif 名称 == "金蟾" then
			if 结尾气血 ~= 0 and 目标[n] ~= 编号 then
				self.战斗流程[#self.战斗流程].挨打方[n].特效 = {"无需特效"} --其他玩家不需要添加特效
				战斗计算:添加护盾(self,目标[n],结尾气血)
			elseif 结尾气血 ~= 0 and 目标[n] == 编号 then
				self:添加状态(名称, self.参战单位[编号], self.参战单位[编号], 11, 境界)
			end
		elseif 名称 == "无双战魂" then
			self:增加战意(编号, 取随机数(1, 3))
		elseif 名称 == "金刚不坏" then
			战斗计算:添加护盾(self,目标[n],self.参战单位[目标[n]].等级*11)
		elseif 名称 == "水·遁" then
			if self.战斗类型==180160 then
				战斗计算:添加护盾(self,目标[n],3000)
		    	else
				战斗计算:添加护盾(self,目标[n],5000)
		    	end

		elseif 名称 == "菩提心佑" then
			战斗计算:添加护盾(self,目标[n],self.参战单位[目标[n]].等级*9)
		elseif 名称 == "无畏布施" then
			self:添加状态("无畏布施", self.参战单位[目标[n]],self.参战单位[编号],等级, 境界)
			self:添加状态("无畏布施（减）", self.参战单位[编号],self.参战单位[编号],等级, 境界)
		elseif 名称 == "诸天看护" then --这个其实也可以改成层数
			local zt={"金刚护法","金刚护体","一苇渡江"}
			local sl = 0
			for i=1,#zt do
				if self.参战单位[目标[n]].法术状态[zt[i]] and self.参战单位[目标[n]].法术状态[zt[i]].攻击编号==编号 then
					sl=sl+1
					self:取消状态(zt[i],self.参战单位[目标[n]])
				end
			end
			self:添加状态(名称, self.参战单位[目标[n]],self.参战单位[编号],69,nil,sl)
		elseif 名称 == "潜龙在渊" then
			local zt = {"龙魂","龙骇"}
			local sl = 0
			for i=1,#zt do
				if self.参战单位[编号].法术状态[zt[i]] then
					sl = sl + 1
					self:取消状态(zt[i],self.参战单位[编号])
				end
			end
			self:添加状态("潜龙在渊", self.参战单位[编号],self.参战单位[编号],69,nil,sl)
		elseif 名称 == "狂怒" then
			if self.参战单位[编号].法术状态.变身 then
				if self:取经脉(编号,"狮驼岭","狂化") then
					self.参战单位[编号].法术状态.变身.回合 = self.参战单位[编号].法术状态.变身.回合 + 1
				end
				self:添加状态("狂怒", self.参战单位[编号],self.参战单位[编号],69,nil,self.参战单位[编号].法术状态.变身.回合)
			end
		elseif 名称 == "炼气化神" then
			self:增加魔法(目标[n], qz(等级 / 2))
			self:添加状态(名称, self.参战单位[目标[n]],self.参战单位[编号],等级)
		elseif 名称 == "生命之泉" and not self.参战单位[目标[n]].法术状态["生命之泉"]  then --官方是有这个状态就下跳到下一个目标，如果都有这个状态就不执行
			local 气血 = 等级 + 50--等级 + 15

			气血 = self:治疗量计算(编号, 目标[n], 气血)

			if self:取经脉(编号,"五庄观","体恤") and self.参战单位[目标[n]].气血<=self.参战单位[目标[n]].最大气血*0.3 then
				气血 = 气血 + 150
			end
			self:增加气血(编号,气血,名称)
			-- 挨打方.法术状态[名称].恢复气血 = qz(等级+ 15)
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 气血
			self:添加状态(名称, self.参战单位[目标[n]],self.参战单位[编号],等级,境界,指定,套装状态)
		elseif 名称 == "普渡众生" and not self.参战单位[目标[n]].法术状态["普渡众生"]  then --重写回血流程，不要弄那么繁琐
			-- 点灯技能150，在不带葫芦的情况下加血340点，带了一个9层土葫芦以后，50次平均下来加血为 392.14，取整392。
			local 气血 = 等级 * 4 + 20--等级 * 3 + 20
			if self:取经脉(编号, "普陀山", "劳心") and n == 1 and self.参战单位[编号].最大气血 >= self.参战单位[编号].气血 * 0.3 then
				气血 = 气血 * 2
			end
			气血 = self:治疗量计算(编号, 目标[n], 气血, 名称)
			self:增加气血(编号,气血,名称)
			self.战斗流程[#self.战斗流程].挨打方[n].恢复气血 = 气血
			self:添加状态(名称, self.参战单位[目标[n]],self.参战单位[编号],等级,境界,指定,套装状态)

		elseif 名称 == "化羽为血" then
			self:添加状态("燃血术", self.参战单位[编号],self.参战单位[编号],等级, 11,nil,1)
	    elseif 名称=="烈火真言" then
			for k,v in pairs(self.参战单位[编号].主动技能) do
				if v.名称=="秘传飞砂走石" then
					self.参战单位[编号].主动技能[k]={名称="秘传三昧真火",等级=self.参战单位[编号].等级+10,剩余冷却回合=初始技能计算:取使用后CD(self,self.参战单位[编号],"秘传三昧真火")}
				elseif v.名称=="秘传三昧真火" then
				    self.参战单位[编号].主动技能[k]={名称="秘传飞砂走石",等级=self.参战单位[编号].等级+10,剩余冷却回合=初始技能计算:取使用后CD(self,self.参战单位[编号],"秘传飞砂走石")}
				end
			end
		else
			self:添加状态(名称, self.参战单位[目标[n]],self.参战单位[编号],等级,境界,指定,套装状态) --添加状态在这里
		end

	end
end




function 战斗处理类:减益技能计算(编号, 名称, 等级, 类型, 消耗, 境界)
	-- local 目标   = self.参战单位[编号].指令.目标
	local zhiling
	if self.参战单位[编号].奇袭指令 then
		zhiling = self.参战单位[编号].奇袭指令
	else
		zhiling = self.参战单位[编号].指令
	end
	local 目标   = zhiling.目标
	local zza = skill.数据[名称]
	local 目标数 = zza.技能人数(等级,self.参战单位[编号],self.PK战斗)
	if 名称=="紧箍咒" then
		if self:取经脉(编号, "普陀山", "普渡") and self:取指定法宝(编号, "普渡") then
			local gl = self:取指定法宝境界(编号, "普渡")*2 + 24
			if gl >= 取随机数() then
				目标数 = 2
			end
		elseif self:取经脉(编号, "普陀山", "赐咒") and 54 >= 取随机数() then
			for n = 1, #self.参战单位 do
				if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].法术状态.紧箍咒 then
					return
				end
			end
			目标数 = 2
		end
	end



	--调试信息(编号.."获取到的目标数为"..目标数)
	目标 = self:取多个敌方目标(编号, 目标, 目标数)
	--调试信息(编号.."获取到的最终目标数为"..#目标)
	if #目标 == 0 then return end
	目标数 = #目标
	for n = 1, 目标数 do
		if self.参战单位[目标[n]].法术状态.分身术 ~= nil and self.参战单位[目标[n]].法术状态.分身术.破解 == nil then
			self.参战单位[目标[n]].法术状态.分身术.破解 = 1
			return
		end
	end
	local 消耗1,类型1 = zza.技能消耗(目标数,self.参战单位[编号])
	if 消耗 == nil and 初始技能计算:技能消耗(self,self.参战单位[编号],消耗1,类型1,名称)==false then
		self.战斗流程[#self.战斗流程+1]={流程=6,战斗提示={内容="行动失败",编号=编号}}
		return
	end
	if not self.PK战斗 and self:取目标类型(编号) == "玩家" then
		self.参战单位[编号].耐久计算.施法=self.参战单位[编号].耐久计算.施法+1
	end
	self.执行等待 = self.执行等待 + 10
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 56, 攻击方 = 编号, 挨打方 = {}, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
	if zza.是否特技~=nil then
		self.战斗流程[#self.战斗流程].特技名称=名称
	end
	local 状态名称 = {}
	for n = 1, 目标数 do
		self.战斗流程[#self.战斗流程].挨打方[n] = {挨打方 = 目标[n], 特效 = {名称}}

		---
		if 名称 =="毒" or 名称 == "紧箍咒" then --or 名称 == "魑魅缠身"
			if 名称~="紧箍咒" and self.参战单位[目标[n]].法术状态.百毒不侵 then
				return
			end
			if self.参战单位[目标[n]].法术状态[名称] ~= nil then
				return
			-- elseif self.参战单位[目标[n]].鬼魂 ~= nil or self.参战单位[目标[n]].精神 ~= nil or self.参战单位[目标[n]].信仰 ~= nil then
			--  return
			end
		end
		---

		-- if 名称 == "尸腐毒" then
		--  local 气血 = qz(self.参战单位[目标[n]].气血 * 0.1)
		--  if self.PK战斗 then
		--      if 气血>等级*8 then
		--          气血=等级*8
		--      end
		--  else
		--      if 气血>等级*13 then
		--          气血=等级*13
		--      end
		--  end
		--  战斗计算:添加掉血(self,目标[n],气血,编号)
		--  if self:取指定法宝(编号, "九幽") then
		--      local lsmb = self:取多个友方目标(编号, 编号, 5, "尸腐毒")
		--      local qx = qz((气血-等级+25) * 0.3)
		--      qx = self:治疗量计算(编号, 目标[n], qx, "尸腐毒")
		--      if self:取经脉(编号, "阴曹地府", "幽光") then
		--          qx = qx + 150
		--      end
		--      for i = 1, #lsmb do
		--          self:动画加血流程(lsmb[i],qx, "尸腐毒")
		--      end
		--      self.参战单位[目标[n]].九幽=self:取指定法宝境界(编号, "九幽")
		--  end
		--  self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号],等级)
		if 名称 == "尸腐无常" then
			local 气血 = 取随机数(1700,2000)
			战斗计算:添加掉血(self,目标[n],气血,编号)
			self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号], self.参战单位[编号].等级)
		elseif 名称 == "紧箍咒" and 取随机数()<=95 then
			self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号],等级)
		elseif 名称 == "雾杀" then
			战斗技能:雾杀(self,编号,目标[n],目标数,n)
		elseif 名称 == "凋零之歌" then
			战斗技能:凋零之歌(self,编号,目标[n],目标数,n)
		elseif 名称 == "锢魂术"  then
			local lssj = 0
			if self.参战单位[编号].JM.索魂 then
				lssj= 6+self.回合数*0.1
			end
			if 取随机数() < 65+lssj then
				self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号],等级)
			end
		elseif 名称 == "笑里藏刀" then
			if self.参战单位[目标[n]].愤怒 then
				self.参战单位[目标[n]].愤怒 = self.参战单位[目标[n]].愤怒 - 70
				if self.参战单位[编号].shenqi.name=="泪光盈盈" then
					self.参战单位[目标[n]].愤怒 = self.参战单位[目标[n]].愤怒 - 6*self.参战单位[编号].shenqi.lv
				end
				if self.参战单位[目标[n]].愤怒 < 0 then
					self.参战单位[目标[n]].愤怒 = 0
				end
				self.战斗流程[#self.战斗流程].愤怒 = self.参战单位[目标[n]].愤怒
			end
		elseif 名称 == "月下霓裳" and 取随机数()<=85 then
			self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号],等级)
		elseif 名称 == "否极泰来" then
			self:解除状态结果(self.参战单位[编号], 初始技能计算:取异常状态法术(self.参战单位[编号].法术状态))
			local lssj = self:解除状态结果(self.参战单位[目标[n]], 初始技能计算:取增益状态法术())
			if #lssj > 0 then
				lssj = lssj[取随机数(1, #lssj)]
				self:添加状态(lssj, self.参战单位[目标[n]], self.参战单位[编号],等级)
			end
		elseif 名称 == "惊魂铃" then
			if 取随机数() <= 境界 * 1.5 then  --13
				self:逃跑计算(目标[n], 13)
			end
		elseif 名称 == "鬼泣" then
			if self.参战单位[编号].队伍==0 then
				if self:取目标类型(目标[n]) == "召唤兽" then --捣蛋鬼
					self:逃跑计算(目标[n],100)
				end
			else
				if 取随机数() <= 境界 * 1.4 then --21
					self:逃跑计算(目标[n], 20)
				end
			end
		elseif 名称 == "缚妖索" or 名称 == "捆仙绳" or 名称 == "缚龙索" then
			self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号], 等级,境界)
			self.参战单位[目标[n]].法术状态[名称].几率 = 境界 * 2 + 8
		elseif 名称 == "番天印" then
			if 取随机数() <= 5 + 境界 * 4 then --50
				self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号], 等级,境界)
			end
		elseif 名称 == "无字经" then
			if 取随机数() <= 5 + 境界 * 4 then
				self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号], 等级,境界)
			end
		elseif 名称 == "无尘扇" then
			if self.参战单位[目标[n]].法术状态.乾坤玄火塔 then
				self:减少愤怒(目标[n],境界+1)
			end
			self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号], 等级,境界)
		elseif 名称 == "发瘟匣" then
			if 取随机数() <= 6 + 境界 * 2 then --30
				self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号], 等级,境界)
			end
		elseif 名称 == "无魂傀儡" then
			if 取随机数() <= 10 + 境界 * 2 then --40
				self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号], 等级,境界)
			end
		elseif 名称 == "魂飞魄散" then
			local lszy = self:解除状态结果(self.参战单位[目标[n]],初始技能计算:取可驱散增益状态(), 1)
			if #lszy>0 then
				local jczt = lszy[取随机数(1,#lszy)]
				self:取消状态(jczt, self.参战单位[目标[n]])
			end
			if  #lszy>1 and self:取经脉(编号,"阴曹地府","扼命") and 初始技能计算:取是否被封印(self,目标[n]) then
				local lszy = self:解除状态结果(self.参战单位[目标[n]],初始技能计算:取可驱散增益状态(), 1)
				if #lszy>0 then
					local jczt = lszy[取随机数(1,#lszy)]
					self:取消状态(jczt, self.参战单位[目标[n]])
				end
			end
			if 目标[n]==self.参战单位[编号].指令.目标 and self:取经脉(编号,"阴曹地府","魂飞") then
				self:添加状态("魂飞", self.参战单位[目标[n]], self.参战单位[编号], 11) --首目标
			end
		elseif 名称 == "摄魂" then
			if self.参战单位[编号].队伍==0 then
				境界 = 12
			end
			if 取随机数(1,50) <= 3 + 境界 * 2 then --27
			   self:添加状态("摄魂", self.参战单位[目标[n]], self.参战单位[编号],等级,境界)
			end
		-- elseif 名称 == "魑魅缠身" then
		--  self:添加状态("魑魅缠身", self.参战单位[目标[n]], self.参战单位[编号],等级,境界)
		elseif 名称 == "噬毒" then --不知道为啥会卡一下
			if self.参战单位[目标[n]].法术状态.尸腐毒 then
				self:取消状态("尸腐毒", self.参战单位[目标[n]])
				self:添加状态("噬毒", self.参战单位[编号], self.参战单位[编号],等级,境界)
				战斗计算:添加掉血(self,编号,self.参战单位[编号].等级*10,编号,"噬毒") --(战斗数据,目标,伤害,编号,名称)
			else
				local lszy = self:解除状态结果(self.参战单位[目标[n]],初始技能计算:取可驱散增益状态(), 1)
				if #lszy>0 then
					local jczt = lszy[取随机数(1,#lszy)]
					self:添加状态(jczt, self.参战单位[编号], self.参战单位[编号],self.参战单位[目标[n]].法术状态.jczt.等级)
				end
			end
		elseif 名称=="死亡之音" then
			local jn={"催眠符","失心符","落魄符","失忆符","失魂符","定身符","莲步轻舞","错乱","日月乾坤","含情脉脉"}
			local djc = self.参战单位[编号].等级-self.参战单位[目标[n]].等级
			if 取随机数()<=djc+30 then
				self:添加状态(jn[取随机数(1,#jn)], self.参战单位[目标[n]], self.参战单位[编号], self.参战单位[编号].等级)
			end
		elseif 名称=="知己知彼" then
			local ts="气血"
			local ts1="魔法"
			local ts2="愤怒"
			if self.参战单位[目标[n]][ts2]==nil then self.参战单位[目标[n]][ts2]=0 end
			self:添加提示(self.参战单位[编号].玩家id,编号,"侦查成功，#Y"..self.参战单位[目标[n]].名称.." #W当前剩余的\n气血 :#G"..self.参战单位[目标[n]][ts].."#W\n".."魔法 :#S"..self.参战单位[目标[n]][ts1].."\n".."愤怒 :#Y"..self.参战单位[目标[n]][ts2])
			if self:取经脉(编号,"天宫","洞察") then
			   self:添加状态("知己知彼", self.参战单位[编号], self.参战单位[编号],等级)
			end
		elseif 名称 == "金刚镯" and 取随机数()<=40 then
			self:添加状态("金刚镯", self.参战单位[目标[n]], self.参战单位[编号],等级)
		elseif 名称=="牵魂蛛丝" then
			self:添加状态("天罗地网", self.参战单位[目标[n]], self.参战单位[编号],等级,nil,1)
			for a = 1, #self.参战单位 do
				if self.参战单位[a].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号,a,1) then
					for k,v in pairs(self.参战单位[a].法术状态) do
						if k=="天罗地网" and v.攻击编号==编号 then
							self.参战单位[编号].指令.目标=a
							self:普通攻击计算(编号,1)
						end
					end
				end
			end

		elseif 名称 == "现形符" then
			if self.参战单位[目标[n]].队伍~=0 and self.参战单位[目标[n]].类型=="角色" and self.参战单位[目标[n]].变身数据 ~= nil and 变身卡数据[self.参战单位[目标[n]].变身数据] ~= nil then
				if 取随机数() <= 境界 * 2 + 3 then --27
					self:破变身(编号,目标[n])
				end
			end
		elseif 名称 == "照妖镜" then
			if self.参战单位[目标[n]].队伍~=0 and self.参战单位[目标[n]].类型=="角色" and self.参战单位[目标[n]].变身数据 ~= nil and 变身卡数据[self.参战单位[目标[n]].变身数据] ~= nil then
				if 取随机数() <= 境界 * 2 + 3 then --33
					self:破变身(编号,目标[n])
				end
			end
		elseif 名称 == "落宝金钱" then
			if 取随机数() <= 境界 * 4 + 5 then  --65
				self:解除状态结果(self.参战单位[目标[n]], 初始技能计算:取法宝增益状态())
			end
		else
			self:添加状态(名称, self.参战单位[目标[n]], self.参战单位[编号],等级,境界)
		end
	end
end

function 战斗处理类:更改怪物模型(编号,目标,模型,染色方案,染色组,炫彩,炫彩组,变异,名称)
	self.执行等待 = self.执行等待 + 3
	local 临时数据 = {
		模型 = 模型,
		染色方案 = 染色方案,
		染色组 = 染色组,
		炫彩 = 炫彩,
		炫彩组 = 炫彩组,
		变异 = 变异,
		名称 = 名称,
	}
	if 名称 then
		self.参战单位[目标].名称=名称
	end
	self.战斗流程[#self.战斗流程+1]={ 流程=710,攻击方=编号,挨打方=目标,参数=临时数据}
end

function 战斗处理类:破变身(编号,目标)
	self:取消变身卡属性(self.参战单位[目标], 变身卡数据[self.参战单位[目标].变身数据].技能)
	-- 玩家数据[self.参战单位[目标].玩家id].角色.变身数据=nil
	local 临时数据 = {
		模型 = self.参战单位[目标].模型,
		染色方案 = self.参战单位[目标].染色方案,
		染色组 = self.参战单位[目标].染色组,
		炫彩 = self.参战单位[目标].炫彩,
		炫彩组 = self.参战单位[目标].炫彩组,
		锦衣 = {}
	}
	local 玩家id = self.参战单位[目标].玩家id
	if self.参战单位[目标].装备[3] ~= nil then
		local 装备id = 玩家数据[玩家id].角色.装备[3]
		临时数据.武器 = {名称 = 玩家数据[玩家id].道具.数据[装备id].名称, 子类 = 玩家数据[玩家id].道具.数据[装备id].子类, 等级 = 玩家数据[玩家id].道具.数据[装备id].等级}
	end
	for k, v in pairs(玩家数据[玩家id].角色.锦衣) do
		临时数据.锦衣[k] = 玩家数据[玩家id].道具.数据[玩家数据[玩家id].角色.锦衣[k]].名称
	end
	self.执行等待 = self.执行等待 + 3
	self.战斗流程[#self.战斗流程+1]={ 流程=710,攻击方=编号,挨打方=目标,参数=临时数据}
end

-- function 战斗处理类:还原造型(攻击方,目标)
--  self:取消变身卡属性(self.参战单位[目标], 变身卡数据[self.参战单位[目标].变身数据].技能)
--  -- 玩家数据[self.参战单位[目标].玩家id].角色.变身数据=nil
--  local 临时数据 = {
--      模型 = self.参战单位[目标].模型,
--      染色方案 = self.参战单位[目标].染色方案,
--      染色组 = self.参战单位[目标].染色组,
--      炫彩 = self.参战单位[目标].炫彩,
--      炫彩组 = self.参战单位[目标].炫彩组,
--      锦衣 = {}
--  }

--  local 玩家id = self.参战单位[目标].玩家id
--  if self.参战单位[目标].装备[3] ~= nil then
--      local 装备id = 玩家数据[玩家id].角色.装备[3]
--      临时数据.武器 = {名称 = 玩家数据[玩家id].道具.数据[装备id].名称, 子类 = 玩家数据[玩家id].道具.数据[装备id].子类, 等级 = 玩家数据[玩家id].道具.数据[装备id].等级}
--  end
--  for k, v in pairs(玩家数据[玩家id].角色.锦衣) do
--      临时数据.锦衣[k] = 玩家数据[玩家id].道具.数据[玩家数据[玩家id].角色.锦衣[k]].名称
--  end
--  self.执行等待 = self.执行等待 + 3
--  self.战斗流程[#self.战斗流程+1]={ 流程=710,攻击方=攻击方,挨打方=目标,参数=临时数据 }
-- end

function 战斗处理类:单体封印技能计算(编号, 名称, 等级)
	-- local 目标 = self.参战单位[编号].指令.目标
	local zhiling
	if self.参战单位[编号].奇袭指令 then
		zhiling = self.参战单位[编号].奇袭指令
	else
		zhiling = self.参战单位[编号].指令
	end
	local 目标 = zhiling.目标
	if self:取目标状态(编号, 目标, 1) == false then
		--调试信息(编号.."号目标不可被攻击，重置目标")
		目标 = self:取单个敌方目标(编号)
	end
	if 目标 == 0 then
		return
	end
	if self.参战单位[目标].法术状态.分身术 ~= nil and self.参战单位[目标].法术状态.分身术.破解 == nil then
		self.参战单位[目标].法术状态.分身术.破解 = 1
		return
	end
	local 消耗1,类型1 = skill:取技能消耗(名称,1,self.参战单位[编号],self.PK战斗)
	if 初始技能计算:技能消耗(self,self.参战单位[编号],消耗1,类型1,名称)==false then
		self.战斗流程[#self.战斗流程+1]={流程=6,战斗提示={内容="行动失败",编号=编号}}
		return
	end

	if not self.PK战斗 and self:取目标类型(编号) == "玩家" then
		self.参战单位[编号].耐久计算.施法=self.参战单位[编号].耐久计算.施法+1
	end

	self.战斗流程[#self.战斗流程 + 1] = {流程 = 50, 攻击方 = 编号, 群封 = false, 挨打方 = { [1] = {挨打方 = 目标, 特效 = {名称} }} , 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}

	self.执行等待 = self.执行等待 + 10

	if 名称 == "碎玉弄影" then
		名称 = "似玉生香"
	elseif 名称 == "妖风四起" then
		if self.参战单位[编号].气血>1 then
			local 结尾气血 = qz(self.参战单位[编号].气血 * 0.4)
			self.战斗流程[#self.战斗流程].结尾死亡=self:减少气血(编号, 结尾气血,编号)
			self.战斗流程[#self.战斗流程].结尾气血 = 结尾气血
		end
	end
	if self:取封印成功(名称, 等级, self.参战单位[编号], self.参战单位[目标]) and not 初始技能计算:取是否被封印(self,目标) then
		local mb = self.参战单位[目标]
		if self.参战单位[目标].法术状态.身似菩提 then
			self.战斗流程[#self.战斗流程].反弹=true
			mb = self.参战单位[编号]
		end
		self:添加状态(名称, mb, self.参战单位[编号],等级)
		if 名称 == "错乱" and self:取经脉(编号,"天宫","震慑") then
			self:添加状态("掌心雷",mb,self.参战单位[编号], 11)
		end
	end
end

function 战斗处理类:群体封印技能计算(编号, 名称, 等级)
	-- local 目标 = self.参战单位[编号].指令.目标
	local zhiling
	if self.参战单位[编号].奇袭指令 then
		zhiling = self.参战单位[编号].奇袭指令
	else
		zhiling = self.参战单位[编号].指令
	end
	local 目标 = zhiling.目标

	local zza = skill.数据[名称]
	local 目标数 = zza.技能人数(等级,self.参战单位[编号],self.PK战斗)
	if self.参战单位[编号].额外目标数~=nil then
		目标数=目标数+self.参战单位[编号].额外目标数
	end
	--调试信息(编号.."获取到的目标数为"..目标数)
	local go
	if 名称=="龙鸣虎啸" then
		目标 = self:取多个敌方bb目标(编号, 目标, 目标数)
		go=true
	else
		目标 = self:取多个敌方目标(编号, 目标, 目标数)
	end
	if #目标 == 0 then return end
	目标数 = #目标
	local 消耗1,类型1 = zza.技能消耗(目标数)
	if 初始技能计算:技能消耗(self,self.参战单位[编号],消耗1,类型1,名称)==false then
		self.战斗流程[#self.战斗流程+1]={流程=6,战斗提示={内容="行动失败",编号=编号}}
		return
	end
	if not self.PK战斗 and self:取目标类型(编号) == "玩家" then
		self.参战单位[编号].耐久计算.施法=self.参战单位[编号].耐久计算.施法+1
	end
	self.战斗流程[#self.战斗流程 + 1] = {流程 = 50, 攻击方 = 编号, 挨打方 = {}, 群封 = true, 提示 = {允许 = true, 类型 = "法术", 名称 = self.参战单位[编号].名称.."使用了"..名称}}
	self.战斗流程[#self.战斗流程].全屏 = false
	if 名称 == "毁灭之光" then
		self.战斗流程[#self.战斗流程].全屏 = true
	elseif 名称 == "八戒上身" then
		if self:取经脉(编号,"花果山","圈养") then
			local 目标 = self.参战单位[编号].指令.目标
			目标数 = 5
			目标 = self:取多个敌方角色目标(编号, 目标, 目标数)
		end
	end

	self.执行等待 = self.执行等待 + 10
	for n = 1, 目标数 do
		-- if self.参战单位[目标[n]].法术状态.分身术~=nil and self.参战单位[目标[n]].法术状态.分身术.破解==nil then
		--   self.参战单位[目标[n]].法术状态.分身术.破解=1
		--   return
		-- end
		self.战斗流程[#self.战斗流程].挨打方[#self.战斗流程[#self.战斗流程].挨打方 + 1] = {挨打方 = 目标[n], 特效 = {名称}, 成功 = false}
		if self:取封印成功(名称, 等级, self.参战单位[编号], self.参战单位[目标[n]],go) and not 初始技能计算:取是否被封印(self,目标[n]) then
			local mb = self.参战单位[目标[n]]
			if self.参战单位[目标[n]].法术状态.身似菩提 then
				self.战斗流程[#self.战斗流程].挨打方[n].反弹=true
				mb = self.参战单位[编号]
			end
			if go and mb.类型=="bb" then
				self:添加状态(名称, mb ,self.参战单位[编号],等级)
			else
				self:添加状态(名称, mb ,self.参战单位[编号],等级)
			end
		end
	end
end

-- function 战斗处理类:取不可添加状态(名称,等级,攻击方,挨打方)
--  if 挨打方.鬼魂 and 名称~="象形" and 名称~="冰川怒" then
--      return false
--     elseif 挨打方.信仰
--  end
-- end

function 战斗处理类:取封印成功(名称,等级,攻击方,挨打方,必中)
	if 挨打方.被封发言 ~=nil and 挨打方.被封发言~=1 then
		for n = 1, #self.参战玩家 do
			if not self.参战玩家[n].助战 then
				发送数据(self.参战玩家[n].连接id, 5512, {id = 挨打方.序号, 文本 = 挨打方.被封发言})
			end
		end
		挨打方.被封发言 = 1
		return true
	elseif 挨打方.法术状态 and 挨打方.法术状态.横扫千军 ~= nil then
		return false
	elseif 挨打方.法术状态 and 挨打方.法术状态.幸运一击 ~= nil then
		return false
	elseif 挨打方.被封必中 then
		return true
	elseif 必中 then
		return true
	end
	if 挨打方.门派 == "女儿村" then
		if self:取经脉(挨打方.序号,"女儿村", "轻霜") and 攻击方.法术状态.毒 == nil  and 取随机数() < 30 then
			self:添加状态("毒", 攻击方,挨打方, self:取技能等级(挨打方.序号,"毒经"))
			攻击方.法术状态.毒.回合掉血 = self:取技能等级(挨打方.序号,"毒经") *3
			攻击方.法术状态.毒.回合 = 4
		end
	end

	if (挨打方.鬼魂 and not 挨打方.超级驱鬼 and not self:取经脉(攻击方.序号, "方寸山", "鬼念")) or 挨打方.精神 or 挨打方.信仰 or 挨打方.不可封印 then
		return false
	elseif 名称 ~= "日月乾坤" and 挨打方.神迹 == 2 then
		return false
	elseif 名称 == "威慑" and 挨打方.类型 == "角色" then
		return false
	elseif 名称 == "反间之计" and self.PK战斗 then
		return false
	elseif 名称 == "偷龙转凤" then
		return true
	elseif 名称 == "雾杀" and 挨打方.法术状态.百毒不侵 then
		return false
	------------------------------门派克制
	elseif 名称 == "似玉生香" or 名称 == "莲步轻舞" or 名称 == "如花解语" then
		if 挨打方.法术状态.宁心 then
			return false
		end
	elseif 名称 == "含情脉脉" or 名称 == "魔音摄魂" or 名称 == "瘴气" then
		if 挨打方.法术状态.寡欲令 then
			return false
		end
	elseif 名称 == "催眠符" or 名称 == "失心符" or 名称 == "落魄符" or 名称 == "失忆符" or 名称 == "追魂符" or 名称 == "定身符" then
		if 挨打方.法术状态.驱魔 then
			return false
		end
	elseif 名称 == "错乱" or 名称 == "掌心雷" or 名称 == "镇妖" or 名称 == "百万神兵" then --名称 == "画地为牢" or
		if 挨打方.法术状态.复苏 then
			return false
		end
	elseif 名称 == "夺魄令" or 名称 == "煞气诀" or 名称 == "惊魂掌" or 名称 == "摧心术" or 名称 == "妖风四起" then
		if 挨打方.法术状态.无穷妙道 then
			return false
		end
	end
	return 战斗计算:封印命中计算(self,名称,等级,攻击方,挨打方)
end

function 战斗处理类:道具消耗1(攻击方, 数量, 名称)
  if 玩家数据[攻击方.玩家id].道具:消耗背包道具(玩家数据[攻击方.玩家id].连接id, 攻击方.玩家id, 名称, 数量) then
	return true
  else
	return false
  end
end

function 战斗处理类:取是否有技能(编号,名称)
	if not 花果山随机技能[名称] then return true end
	if self.参战单位[编号].如意神通~=nil and #self.参战单位[编号].如意神通>0 then
		for n = 1, #self.参战单位[编号].如意神通 do
			if self.参战单位[编号].如意神通[n] == 名称 then
				return true
			end
		end
	end
	return false
end

function 战斗处理类:取技能等级(编号,名称)
	if self.参战单位[编号].队伍 == 0 then
		return self.参战单位[编号].等级 + 10
	end
	for n = 1, #self.参战单位[编号].主动技能 do
		if self.参战单位[编号].主动技能[n].名称 == 名称 then
			return self.参战单位[编号].主动技能[n].等级
		end
	end
	for n = 1, #self.参战单位[编号].附加状态 do
		if self.参战单位[编号].附加状态[n].名称 == 名称 then
			return self.参战单位[编号].附加状态[n].等级
		end
	end
	for n = 1, #self.参战单位[编号].追加法术 do
		if self.参战单位[编号].追加法术[n].名称 == 名称 then
			return self.参战单位[编号].追加法术[n].等级
		end
	end
	if self.参战单位[编号].披坚执锐~=nil and #self.参战单位[编号].披坚执锐>0 then
		for n = 1, #self.参战单位[编号].披坚执锐 do
			if self.参战单位[编号].披坚执锐[n].名称 == 名称 then
				return self.参战单位[编号].披坚执锐[n].等级
			end
		end
	end
	if self:取目标类型(编号)== "玩家" and 玩家数据[self.参战单位[编号].玩家id].角色.门派~="无门派" then --这里是取的师门技能主技能的等级
		for n = 1, #玩家数据[self.参战单位[编号].玩家id].角色.师门技能 do
			if 玩家数据[self.参战单位[编号].玩家id].角色.师门技能[n].名称 == 名称 then
				return 玩家数据[self.参战单位[编号].玩家id].角色.师门技能[n].等级
			end
		end
	end
	return 0
end

function 战斗处理类:添加状态(名称,攻击方,挨打方,等级,境界,指定,套装状态) --添加状态搜索
		-- 战斗数据:添加状态("龙骇",战斗数据.参战单位[编号],战斗数据.参战单位[编号],69)
	状态处理:添加状态(self,名称, 攻击方, 挨打方, 等级,境界,指定,套装状态)
end

function 战斗处理类:取消状态(名称, 挨打方)
	状态处理:取消状态(self,名称, 挨打方)
end

-- 超级吸血护盾：物理攻击时，获得对方损失气血的30%；并将获得的溢出气血的50%转化为护盾
-- 攻击有鬼魂术的敌人无法吸血
function 战斗处理类:添加超级吸血护盾(编号, 护盾值)
	if 编号 == nil or 护盾值 == nil or 护盾值 <= 0 then
		return
	end
	if self.参战单位[编号] == nil then
		return
	end
	-- 初始化护盾状态
	if self.参战单位[编号].法术状态 == nil then
		self.参战单位[编号].法术状态 = {}
	end
	-- 添加或叠加超级吸血护盾
	if self.参战单位[编号].法术状态.超级吸血护盾 == nil then
		self.参战单位[编号].法术状态.超级吸血护盾 = {
			护盾值 = math.floor(护盾值),
			回合 = 999  -- 持续回合，可根据需求调整
		}
	else
		-- 叠加护盾值
		self.参战单位[编号].法术状态.超级吸血护盾.护盾值 = self.参战单位[编号].法术状态.超级吸血护盾.护盾值 + math.floor(护盾值)
	end
	-- 注意：不在此处添加战斗流程，由调用方处理，避免干扰战斗流程顺序
end

function 战斗处理类:取目标数量(攻击方, 技能名称, 等级, 编号)
	return 初始技能计算:取目标数量(self,攻击方, 技能名称, 等级, 编号)
end

function 战斗处理类:被动技能(名称)
	return 初始技能计算:被动技能(名称)
end

function 战斗处理类:恢复技能(名称)
	return 初始技能计算:恢复技能(名称)
end

function 战斗处理类:可连法攻技能(名称)
	return 初始技能计算:可连法攻技能(名称)
end

function 战斗处理类:可连物攻技能(名称)
	return 初始技能计算:可连物攻技能(名称)
end

function 战斗处理类:物攻技能(名称)
	return 初始技能计算:物攻技能(名称)
end

function 战斗处理类:法攻技能(名称)
	return 初始技能计算:法攻技能(名称)
end

function 战斗处理类:法攻技能计算(编号, 名称, 等级, 伤害系数, 消耗)
	战斗法术计算:法攻技能计算(编号, 名称, 等级, 伤害系数, 消耗, self)
end

function 战斗处理类:物攻技能计算(编号, 名称, 等级)
	return 物理技能计算:物攻技能计算(编号, 名称, 等级, self)
end

function 战斗处理类:固伤技能(名称)
	return 初始技能计算:固伤技能(名称)
end

function 战斗处理类:固伤技能计算(编号, 名称, 等级, 伤害系数, 消耗)
	战斗固伤计算:固伤技能计算(编号, 名称, 等级, 伤害系数, 消耗, self)
end

function 战斗处理类:取技能所属门派(名称)
	return 初始技能计算:取技能所属门派(名称)
end

function 战斗处理类:封印技能(名称)
	return 初始技能计算:封印技能(名称)
end
function 战斗处理类:群体封印技能(名称)
	return 初始技能计算:群体封印技能(名称)
end
function 战斗处理类:减益技能(名称)
	return 初始技能计算:减益技能(名称)
end

function 战斗处理类:增益技能(名称)
	return 初始技能计算:增益技能(名称)
end

function 战斗处理类:取门派封印法术(门派)
	return 初始技能计算:取门派封印法术(门派)
end

function 战斗处理类:取攻击状态(编号)
	return 初始技能计算:取攻击状态(self,编号)
end

function 战斗处理类:取法术状态(编号)
	return 初始技能计算:取法术状态(self,编号)
end

function 战斗处理类:取特技状态(编号)
	return 初始技能计算:取特技状态(self,编号)
end

function 战斗处理类:取道具状态(编号)
	return 初始技能计算:取道具状态(self,编号)
end

function 战斗处理类:取行动状态(编号)
	return 初始技能计算:取行动状态(self,编号)
end

function 战斗处理类:普通攻击计算(编号, 伤害比, 友伤)
	return  普攻计算:普通攻击计算(编号, 伤害比, 友伤, self)
end

function 战斗处理类:取是否反击(编号, 目标)
	if self.参战单位[目标].法术状态.魔王回首 ~= nil or self.参战单位[目标].法术状态.极度疯狂 ~= nil then
		return 1
	else
		return nil
	end
end

function 战斗处理类:增加魔法(编号, 数额)
	if self.参战单位[编号].法术状态.瘴气 and self.参战单位[编号].法术状态.瘴气.降魔 then
		数额 = qz(数额*self.参战单位[编号].法术状态.瘴气.降魔)
	end
	if self.参战单位[编号].法术状态.腾雷 then
		数额 = qz(数额*0.5)
	end

	if self.参战单位[编号].法术状态.魔音摄魂 and self.参战单位[编号].法术状态.魔音摄魂.迷意 then
		return 0
	end
	if self.参战单位[编号].魔法回复效果 then
		数额=数额+self.参战单位[编号].魔法回复效果
	end
	self.参战单位[编号].魔法 = self.参战单位[编号].魔法 + 数额
	if self.参战单位[编号].魔法 > self.参战单位[编号].最大魔法 then
		self.参战单位[编号].魔法 = self.参战单位[编号].最大魔法
	end
end

function 战斗处理类:减少魔法(编号,数额)
	local fhz = qz(数额)
	if self.参战单位[编号]==nil or self.参战单位[编号].队伍==0 then--or self:取目标状态(编号, 编号, 2) then
		return fhz
	end
	if self.参战单位[编号].魔法 < fhz then
		fhz = self.参战单位[编号].魔法
		self.参战单位[编号].魔法 = 0
	else
		self.参战单位[编号].魔法 = self.参战单位[编号].魔法 - fhz
	end
	战斗计算:同步魔法(self,编号)
	return fhz
end

function 战斗处理类:治疗量计算(攻击编号, 目标, 治疗量, 名称 , 特技)
	local zhiling
	if self.参战单位[攻击编号].奇袭指令 then
		zhiling = self.参战单位[攻击编号].奇袭指令
	else
		zhiling = self.参战单位[攻击编号].指令
	end

	if 名称 == "推拿" then
		目标=攻击编号
	end
	-- if self.参战单位[目标].气血 >= self.参战单位[目标].最大气血 then return 0 end
	if self.参战单位[目标].法术状态.魔音摄魂 then return 0 end

	if self.参战单位[攻击编号].法术状态.佛法无边 and self.参战单位[攻击编号].法术状态.佛法无边.佛法~=nil then
		治疗量 = qz(治疗量 *1.3)
	end

	if self.参战单位[目标].法术状态.瘴气 then
		治疗量 = qz(治疗量*self.参战单位[目标].法术状态.瘴气.降疗)
	end
	if self.参战单位[目标].法术状态.重创 then
		治疗量 = qz(治疗量*self.参战单位[目标].法术状态.重创.降疗)
	end
	if self.参战单位[目标].法术状态.含情脉脉 and  self.参战单位[目标].法术状态.含情脉脉.忘情~=nil then
		治疗量 = qz(治疗量*self.参战单位[目标].法术状态.含情脉脉.忘情)
	end
	if self.参战单位[目标].法术状态.腾雷 then
		治疗量 = qz(治疗量*0.5)
	end
	if self.参战单位[目标].净土灵华 then
		治疗量 = qz(治疗量*(1-self.参战单位[目标].净土灵华))
	end
	if self.参战单位[攻击编号].法术状态.莲心剑意 then
		治疗量 = qz(治疗量*0.9)
	end
	if self.参战单位[攻击编号].门派=="化生寺" then
--新增化生本命法宝属性
		if not self.PK战斗 and self.参战单位[攻击编号].本命法宝 and self.参战单位[攻击编号].本命法宝.开启 and self.参战单位[攻击编号].本命法宝.耐久>0 then
			if 名称=="推气过宫" and self.参战单位[攻击编号].本命法宝.名称=="弥音禅钟" and  取随机数(1,100) < self.参战单位[攻击编号].本命法宝.等级 then
				治疗量 = 治疗量 + qz(治疗量*0.3) + 300
			end
		end

		if self:取经脉(攻击编号,"化生寺", "施他") and self.参战单位[攻击编号].增益 and self.参战单位[攻击编号].增益>0 then
			治疗量 = 治疗量 + 40
		end
		if self.参战单位[攻击编号].shenqi.name=="挥毫" and self.参战单位[目标].增益 then
			治疗量 = 治疗量 + 25*self.参战单位[攻击编号].shenqi.lv*self.参战单位[目标].增益
		end
	elseif self.参战单位[攻击编号].门派=="无底洞" then
		if self:取经脉(攻击编号, "无底洞", "秉幽") then
			治疗量 = 治疗量 + (self.参战单位[攻击编号].装备伤害 * 0.18)
		elseif self:取经脉(攻击编号, "无底洞", "灵照") then
			治疗量 = 治疗量 + (self.参战单位[攻击编号].装备伤害 * 0.03*self:取全场增益数量())
		elseif self:取经脉(攻击编号, "无底洞", "灵照") then
			治疗量 = 治疗量 + (self.参战单位[攻击编号].装备伤害 * 0.04*self:取全场护盾数量())
		end
		-- if self:取经脉(攻击编号, "无底洞", "涌泉") and 目标==self.参战单位[攻击编号].指令.目标 then
		if self:取经脉(攻击编号, "无底洞", "涌泉") and 目标==zhiling.目标 then
			治疗量 = 治疗量 + self:取技能等级(攻击编号,"地冥妙法")*6
		end
	end


	if 特技==nil then --那就持续统一*3，其他*5
		if 名称=="普渡众生" or 名称=="生命之泉" then
			治疗量 = 治疗量 + self.参战单位[攻击编号].法术修炼*3
			if 名称=="普渡众生" then
				if self:取经脉(攻击编号, "普陀山", "化戈") then
					治疗量 = 治疗量 + (self.参战单位[攻击编号].装备伤害 * 0.18)
				end
				if self.参战单位[攻击编号].玉帛 then
					治疗量 = 治疗量 + self.参战单位[攻击编号].玉帛
				end
				if self.参战单位[攻击编号].临时治疗 then
					治疗量 = 治疗量 + self.参战单位[攻击编号].临时治疗
					self.参战单位[攻击编号].临时治疗=nil
				end
			elseif 名称=="生命之泉" then
				if self:取经脉(攻击编号,"五庄观","运转") then
					治疗量 = qz(治疗量*1.3)
				end
			end
		else
			治疗量 = 治疗量 + self.参战单位[攻击编号].法术修炼*5
		end
	end
	治疗量 = 治疗量 + self.参战单位[目标].气血回复效果
	if 名称~="尸腐毒" then
		if self:取被动(编号,"五行珠") then
			治疗量 = qz(治疗量 * 0.5)
		end
		治疗量 = 治疗量 + self.参战单位[攻击编号].治疗能力
	end
	if self.参战单位[目标].气血上限 ~= nil and (Qixuesx[名称] or 特技) then
	-- if (名称 == "推拿" or 名称 == "活血" or 名称 == "妙手回春" or 名称 == "星月之惠" or 名称 == "慈航普度" or 名称 == "由己渡人" or 名称 == "救死扶伤" or 名称 == "普渡众生"or 名称 == "地涌金莲" or 名称 == "杨柳甘露" or 名称 == "我佛慈悲"or 名称 == "自在心法") and self.参战单位[目标].气血上限 ~= nil then
		local 恢复伤势 = 治疗量
		if 名称 == "地涌金莲" then
			恢复伤势 = 恢复伤势*0.1
		elseif 名称 == "由己渡人" then
			恢复伤势 = 恢复伤势*2
		end
		self.参战单位[目标].气血上限 = self.参战单位[目标].气血上限 + qz(恢复伤势)
		if self.参战单位[目标].气血上限 > self.参战单位[目标].最大气血 then
			self.参战单位[目标].气血上限 = self.参战单位[目标].最大气血
		end
	end
	if self.参战单位[目标].共生 then
		治疗量=治疗量*2
	end
	if self.参战单位[目标].shenqi.name=="镜花水月" and 取随机数()<=8*self.参战单位[目标].shenqi.lv then
		战斗计算:添加护盾(self,目标,治疗量)
	end

	return qz(治疗量)
end

function 战斗处理类:增加气血(编号,数额,名称)
	数额 = 数额 + 0
	if self.参战单位[编号].法术状态 and self.参战单位[编号].法术状态.泉愈 then
		local sss = tonumber(self.参战单位[编号].泉愈百分比) or 0
		数额 = 数额 * 1 + sss
	end

	self.参战单位[编号].气血 = self.参战单位[编号].气血 + qz(数额)
	if self.参战单位[编号].气血 > self.参战单位[编号].最大气血 then
		self.参战单位[编号].气血 = self.参战单位[编号].最大气血
	end
end


function 战斗处理类:持续回血处理(攻击编号, 挨打方, 治疗量, 名称)
	if 挨打方.法术状态.魔音摄魂 or 挨打方.气血>=挨打方.最大气血 then return end

	if 挨打方.法术状态.瘴气 then
		治疗量 = qz(治疗量*挨打方.法术状态.瘴气.降疗)
	end
	if 挨打方.法术状态.重创 then
		治疗量 = qz(治疗量*挨打方.法术状态.重创.降疗)
	end
	if 挨打方.法术状态.含情脉脉 and  挨打方.法术状态.含情脉脉.忘情~=nil then
		治疗量 = qz(治疗量*挨打方.法术状态.含情脉脉.忘情)
	end
	if 挨打方.法术状态.腾雷 then
		治疗量 = qz(治疗量*0.5)
	end
	if self.参战单位[攻击编号].法术状态.莲心剑意 then
		治疗量 = qz(治疗量*0.9)
	end
	if 名称 == "生命之泉" then
		治疗量 = qz(治疗量 + self.参战单位[攻击编号].治疗能力 + self.参战单位[攻击编号].法术修炼 * 3 + 挨打方.气血回复效果)
		if 挨打方.法术状态.生命之泉.运转 then
			治疗量 = qz(治疗量*1.3)
		end
		if 挨打方.气血<=挨打方.最大气血*0.3 then
			治疗量 = 治疗量 + 挨打方.法术状态.生命之泉.体恤
		end
	elseif 名称 == "普渡众生" then
		治疗量 = qz(治疗量 + self.参战单位[攻击编号].治疗能力 + self.参战单位[攻击编号].法术修炼 * 3 + 挨打方.气血回复效果)
		if self:取经脉(攻击编号, "普陀山", "化戈") then
			治疗量 = qz(治疗量 + (self.参战单位[攻击编号].装备伤害 * 0.18))
		end
		if self.参战单位[攻击编号].玉帛 then
			治疗量 = qz(治疗量 + self.参战单位[攻击编号].玉帛)
		end
		if 挨打方.气血上限 ~= nil then
			挨打方.气血上限 = 挨打方.气血上限 + 治疗量
			if 挨打方.气血上限 > 挨打方.最大气血 then
				挨打方.气血上限 = 挨打方.最大气血
			end
		end
	end
	--回血流程附加
	挨打方.气血 = qz(挨打方.气血 + 治疗量)
	-- 挨打方.护盾=200
	if 挨打方.气血 > 挨打方.最大气血 then
		挨打方.气血 = 挨打方.最大气血
	end
	if self.战斗流程[#self.战斗流程] == nil then
		self.战斗流程[#self.战斗流程] = {}
	end
	if self.战斗流程[#self.战斗流程].同步气血 == nil then
		self.战斗流程[#self.战斗流程].同步气血 = {}
	end
	table.insert(self.战斗流程[#self.战斗流程].同步气血,{挨打方=挨打方.序号,气血=挨打方.气血,气血上限=挨打方.气血上限})
end


function 战斗处理类:动画加血流程(编号,数额,名称,追加)
	if self.参战单位[编号].气血 >= self.参战单位[编号].最大气血 then
		return
	end
	if 数额 == nil or 数额 < 1 then
		数额 = 1
	end
	数额 = qz(数额 + self.参战单位[编号].气血回复效果)
	if self.战斗流程[#self.战斗流程] == nil then
		self.战斗流程[#self.战斗流程] = {}
	end
	if self.战斗流程[#self.战斗流程].回复气血 == nil then
		self.战斗流程[#self.战斗流程].回复气血 = {}
	end
	self.参战单位[编号].气血 = self.参战单位[编号].气血 + 数额
	if self.参战单位[编号].气血 > self.参战单位[编号].最大气血 then
		self.参战单位[编号].气血 = self.参战单位[编号].最大气血
	end
	table.insert(self.战斗流程[#self.战斗流程].回复气血,{挨打方=编号,气血=数额})
end

function 战斗处理类:消耗气血(编号,数额)
	self.参战单位[编号].气血 = self.参战单位[编号].气血 - 数额
end

function 战斗处理类:减少气血(编号,数额,攻击,名称,友伤)
	return 战斗计算:减少气血(self,编号,数额,攻击,名称,友伤)
end

function 战斗处理类:增加愤怒(编号, 数额 ,固定)
	if self.参战单位[编号].威吓~=nil then
		return
	end
	if self.参战单位[编号].愤怒 > 150 then
	    self.参战单位[编号].愤怒 = 150
	end

	if self.参战单位[编号].愤怒 then
		if self.参战单位[编号].特效暴怒 and 固定==nil then
			数额 = 数额*1.2
		end
		self.参战单位[编号].愤怒 = self.参战单位[编号].愤怒 + qz(数额)
	end
end

function 战斗处理类:减少愤怒(编号, 数额)
	if self.参战单位[编号].愤怒 then
		self.参战单位[编号].愤怒 = self.参战单位[编号].愤怒 - 数额
		if self.参战单位[编号].愤怒 <0 then self.参战单位[编号].愤怒 = 0 end
	end
end

function 战斗处理类:增加战意(编号, 数额)
	if self.参战单位[编号].门派~="凌波城" then return end
	local 上限 = 6
	for i=1,数额 do
		if self.参战单位[编号].战意 < 上限 then
			self.参战单位[编号].战意 = self.参战单位[编号].战意 + 1

			if self:取被动(编号,"超级战意") and 取随机数()<=20 then
				self.参战单位[编号].超级战意 = self.参战单位[编号].超级战意 + 1
			end
		end
	end
	if self.参战单位[编号].战意 > 上限 then self.参战单位[编号].战意 = 上限 end
end

function 战斗处理类:增加超级战意(编号, 数额)
	if self.参战单位[编号].门派~="凌波城" then return end
	local 上限 = 6
	self.参战单位[编号].战意 = self.参战单位[编号].战意 + 数额
	local 原值 = self.参战单位[编号].超级战意
	self.参战单位[编号].超级战意 = self.参战单位[编号].超级战意 + 数额
	if 原值 <= 3 and self.参战单位[编号].超级战意 > 3 then self.参战单位[编号].超级战意 = 3 end --真君显灵赋予的高层数超级战意不受此上限影响
	if self.参战单位[编号].战意 > 上限 then self.参战单位[编号].战意 = 上限 end
end

function 战斗处理类:增加五行珠(编号)
	if self.参战单位[编号].五行珠  and self.参战单位[编号].五行珠 < 6 then
		self.参战单位[编号].五行珠 = self.参战单位[编号].五行珠 + 1
	end
	if self:取经脉(编号,"普陀山","湛然") and self.参战单位[编号].五行珠==5 and not self.参战单位[编号].法术状态.剑意莲心 and sj()<=40 then
		self:添加状态("剑意莲心", self.参战单位[编号], self.参战单位[编号],11)
	end
	if self:取经脉(编号,"普陀山","顿悟") then
		self:增加愤怒(编号,self.参战单位[编号].五行珠)
	end
	if self.参战单位[编号].五行珠 > 6 then self.参战单位[编号].五行珠 = 6 end
end

function 战斗处理类:消耗五行珠(编号, 数额)
	if self.参战单位[编号].五行珠 and self.参战单位[编号].五行珠 >= 1 then
		self.参战单位[编号].五行珠 =  self.参战单位[编号].五行珠 - 1
		if self:取经脉(编号,"普陀山","无尽") then
			self.参战单位[编号].伤害=self.参战单位[编号].伤害+8
		end
		return true
	end
	return false
end

function 战斗处理类:增加人参果(编号)
	if self.参战单位[编号].人参果.枚<3 then
		self.参战单位[编号].人参果.枚=self.参战单位[编号].人参果.枚+1
	end
	self.参战单位[编号].人参果.回合 = 4
end

function 战斗处理类:风灵消耗(攻击方,名称,数量)
	if 攻击方.队伍==0 then
		return 0
	end
	if not 攻击方.法术状态.风灵 then
		return 0
	end
	local gl = 50
	if self:取经脉(攻击方.序号,"神木林", "秀木") then
		gl = 75
	end
	if 攻击方.法术状态.风灵.层数 < 数量 then --数量>1 and
		local num = 攻击方.法术状态.风灵.层数
		self:取消状态("风灵",攻击方)
		if self:取被动(攻击方.序号, "木精") and sj()<=gl then
			self:添加状态("木精", 攻击方, 攻击方,11,nil,num)
		else
			if 攻击方.添加木精 then
				攻击方.添加木精=num
			end
		end
		if self:取经脉(攻击方.序号,"神木林","风魂") then
			战斗计算:添加护盾(self,攻击方.序号,攻击方.等级*2*num)
		end
		return num
	end

	攻击方.法术状态.风灵.层数 = 攻击方.法术状态.风灵.层数 - 数量

	if 攻击方.shenqi.name=="凭虚御风" then
		self:添加状态("凭虚御风",攻击方,攻击方,69)
	end

	if 攻击方.法术状态.风灵.层数<=0 then
		self:取消状态("风灵",攻击方)
	end

	if self:取被动(攻击方.序号, "木精") and sj()<=gl then
		self:添加状态("木精", 攻击方, 攻击方,11,nil,数量)
	else
		if 攻击方.添加木精 then
			攻击方.添加木精=数量
		end
	end
	if self:取经脉(攻击方.序号,"神木林","风魂") then
		战斗计算:添加护盾(self,攻击方.序号,攻击方.等级*2*数量)
	end
	return 数量
end

function 战斗处理类:取可否防御(挨打方)
	if self.参战单位[挨打方].法术状态.横扫千军 ~= nil or self.参战单位[挨打方].法术状态.破釜沉舟 ~= nil or self.参战单位[挨打方].法术状态.催眠符 ~= nil or self.参战单位[挨打方].法术状态.楚楚可怜 ~= nil or self.参战单位[挨打方].法术状态.乾坤妙法 ~= nil then
		return false
	else
		return true
	end
end

function 战斗处理类:取伤害基数(攻击方,挨打方)
	if self:取目标类型(攻击方) == "玩家" and self:取目标类型(挨打方)== "召唤兽" then --人VS宠
		return 0.9
	elseif self:取目标类型(攻击方) == "召唤兽" and self.参战单位[挨打方].队伍==0 then --宠VS怪
		return 1.1
	elseif self.参战单位[攻击方].队伍==0 and self.参战单位[挨打方].类型=="bb" then --宠VS怪
		return 0.75
	end
	return 1 --人VS人 宠VS宠
end



function 战斗处理类:取基础物理伤害(攻击方 ,挨打方 ,技能名称)
	--狂暴等级：将自身防御的一部分转为伤害力
	local 附加防御 = 0
	local 伤害 = self.参战单位[攻击方].伤害
	local kuangbao=self.参战单位[攻击方].狂暴等级
	local chuanci=self.参战单位[攻击方].穿刺等级

	if kuangbao~=0 and self.参战单位[攻击方].shenqi.name=="蛮血" then
		kuangbao = kuangbao * (1+0.08*self.参战单位[攻击方].shenqi.lv*(1-self.参战单位[攻击方].气血/self.参战单位[攻击方].最大气血))
	end
	伤害 = qz(伤害 + (self.参战单位[攻击方].防御 * kuangbao))
	local 防御 = self.参战单位[挨打方].防御
	----------佬伍修改（增加穿刺效果穿刺等级战斗生效
  	if chuanci~=0 then
  	伤害 = qz(伤害 + (self.参战单位[挨打方].防御 * chuanci/600))
  	end
  	----------佬伍修改（增加穿刺效果穿刺等级战斗生效
	if self.参战单位[攻击方].队伍~=0 then --经脉影响的基础防御或伤害
		if self.参战单位[攻击方].门派 == "大唐官府" then
			if self:取经脉(攻击方,"大唐官府", "目空") and (技能名称=="破血狂攻" or 技能名称=="弱点击破" or 技能名称=="破碎无双" or 技能名称=="翩鸿一击") then
				防御 = 防御 * 0.9
			end
			if self:取经脉(攻击方,"大唐官府", "勇念") and 技能名称 == "横扫千军" then
				防御 = 防御 * 0.9
	 			if 时辰信息.天气 == 2 then
	  				伤害 = 伤害*1.15
	  			end
			end
			if self:取经脉(攻击方,"大唐官府", "不惊") then
				local bfb = (self:取装备宝石等级(攻击方,3)*0.5 - 3)*0.01
				if bfb > 0 then
					防御 = 防御 - 防御 * bfb
				end
			end
			if self:取指定法宝(攻击方, "七杀") then
				if self.参战单位[攻击方].七杀==nil then
					self.参战单位[攻击方].七杀 = 0
				end
				伤害 = 伤害 + 10
				防御 = 防御 - 防御 * self.参战单位[攻击方].七杀
			end
			if self.参战单位[攻击方].shenqi.name=="惊锋" then
				self:添加状态("惊锋",self.参战单位[攻击方],self.参战单位[攻击方],69)
				伤害 = 伤害 + 10*self.参战单位[攻击方].法术状态["惊锋"].层数*self.参战单位[攻击方].shenqi.lv
			end
		elseif self.参战单位[攻击方].门派 == "天宫" then
			if self:取经脉(攻击方,"天宫", "啸傲") then
				if self.参战单位[攻击方].法术状态.霹雳弦惊 then
					伤害 = 伤害 + 15 * self.参战单位[攻击方].法术状态.霹雳弦惊.层数
				end
				if self.参战单位[攻击方].法术状态.雷怒霆激 then
					伤害 = 伤害 + 15 * self.参战单位[攻击方].法术状态.雷怒霆激.层数
				end
			end
		elseif self.参战单位[攻击方].门派 == "盘丝洞" then
			if self:取经脉(攻击方,"盘丝洞", "凌弱") and #self:解除状态结果(self.参战单位[挨打方],初始技能计算:取异常状态法术(self.参战单位[挨打方].法术状态),1)>=2 then
				伤害 = 伤害 + 80
			end
		elseif self.参战单位[攻击方].门派 == "阴曹地府" then
			if 时辰信息.昼夜 == 1 then
				伤害 = 伤害 + self.参战单位[攻击方].黑夜伤害
			end
			if self:取经脉(攻击方, "阴曹地府", "夜行")then
				伤害 = 伤害 +40
			end
			if self:取经脉(攻击方, "阴曹地府", "伤魂") and  self.参战单位[挨打方].法术状态.尸腐毒 then
				伤害 = 伤害 +100
			end
			if self.参战单位[攻击方].shenqi.name=="魂魇" then
				self:添加状态("魂魇",self.参战单位[挨打方],self.参战单位[攻击方],self.参战单位[攻击方].shenqi.lv)
			end
		elseif self.参战单位[攻击方].门派 == "狮驼岭" then
			if self.参战单位[攻击方].法术状态.狂袭 then
				伤害 = 伤害 + self.参战单位[攻击方].法术状态.狂袭.伤害力
			end
			if self.参战单位[攻击方].法术状态.狂战 then
				伤害 = 伤害 + 30*self.参战单位[攻击方].法术状态.狂战.层数*self.参战单位[攻击方].shenqi.lv
			end
		elseif self.参战单位[攻击方].门派 == "五庄观" then
			if self:取经脉(攻击方,"五庄观", "无极") and self.参战单位[攻击方].法术状态.生命之泉 and self.参战单位[攻击方].法术状态.炼气化神 and self.参战单位[攻击方].法术状态.真阳令旗 then
				伤害 = 伤害 * 1.09
			end
			if self:取经脉(攻击方,"五庄观", "混元") and self.参战单位[攻击方].气血>=self.参战单位[攻击方].最大气血*0.7 then
				伤害 = 伤害 * 1.05
			end
			if self.参战单位[攻击方].人参果.枚>0 then
				if self:取经脉(攻击方,"五庄观", "凝神") then
					伤害 = 伤害 + 120
				end
				if self:取经脉(攻击方,"五庄观", "气盛") then
					伤害 = 伤害 + self.参战单位[攻击方].人参果.枚*60
				end
			end
		elseif self.参战单位[攻击方].门派 == "凌波城" then
			-- 伤害 = 伤害 + self.参战单位[攻击方].战意*20
			if self:取经脉(攻击方,"凌波城", "不动") and self:取门派是否唯一(攻击方,"凌波城") then
				防御 = 防御 - 防御 * (1-self.参战单位[攻击方].气血/self.参战单位[攻击方].气血上限)*0.1
			end
			if 技能名称 =="天崩地裂" and self:取经脉(攻击方,"凌波城","力战") then
				防御 = 防御 * (1-0.12)
			end
			if 技能名称 =="天神怒斩" then
				防御 = 防御 * (1-0.25)
			end
			if self:取经脉(攻击方,"凌波城", "怒火") then
				伤害 = 伤害 + self.参战单位[攻击方].战意*self.参战单位[攻击方].战意*12
			end
			if self:取被动(攻击方,"饮海") and (技能名称=="浪涌" or 技能名称=="惊涛怒" or 技能名称=="翻江搅海") then
				防御 = 防御 * 0.9
			end
			if self:取经脉(攻击方, "凌波城", "煞气") and (技能名称=="惊涛怒" or 技能名称=="翻江搅海" or 技能名称=="天崩地裂" or 技能名称=="断岳势" or 技能名称=="腾雷") then
				伤害 = 伤害 + 300
			end

		elseif self.参战单位[攻击方].门派 == "花果山" then
			if self.参战单位[攻击方].法术状态.压邪 then
				伤害 = 伤害 + self.参战单位[攻击方].等级*1.5
			end
			if self.参战单位[攻击方].法术状态.无所遁形 then
				防御 = 防御 * (1-self.参战单位[攻击方].法术状态.无所遁形.层数*0.1)
			end
			if self.参战单位[攻击方].法术状态.开辟 then
				伤害 = 伤害 + self.参战单位[攻击方].shenqi.lv*20*self.参战单位[攻击方].法术状态.开辟.层数
			end
		elseif self.参战单位[攻击方].类型 == "bb" then
			if self.参战单位[攻击方].无畏 ~= nil and self.参战单位[挨打方].反震 ~= nil then
				伤害 = 伤害 * (1 + self.参战单位[攻击方].无畏)
			end
			if self.参战单位[攻击方].愤恨 ~= nil and self.参战单位[挨打方].幸运 ~= nil then
				伤害 = 伤害 * (1 + self.参战单位[攻击方].愤恨)
			end
			if self.参战单位[攻击方].生死决~=nil and 取随机数()<=self.参战单位[攻击方].生死决 then
				local  num = qz(self.参战单位[攻击方].防御*0.4)
				self.参战单位[攻击方].生死决减防 = num
				伤害 = 伤害 + num
			end
			if self.参战单位[攻击方].力破 and self:取目标类型(挨打方) == "玩家" then
				防御 = 防御-self.参战单位[攻击方].力破[1]
			end
		end
		if self.参战单位[攻击方].还阳术 then
			伤害 = 伤害 * (1 + self.参战单位[攻击方].还阳术)
		elseif self.参战单位[挨打方].还阳术 then
			防御 = 防御 * (1 - self.参战单位[挨打方].还阳术)
		end
	end

	if self.参战单位[攻击方].法术状态.诸天看护 then
		伤害 = 伤害 + 伤害 * (0.015 *(1+self.参战单位[攻击方].法术状态.诸天看护.层数))
	end
	if self.参战单位[攻击方].法术状态.满天花雨~=nil then
		伤害=伤害*(1+self.参战单位[攻击方].法术状态.满天花雨.层数/10)
	end
	if self.参战单位[攻击方].法术状态.魔音摄魂 and  self.参战单位[攻击方].法术状态.魔音摄魂.魔音~=nil then
		伤害 = 伤害 - (伤害 * 0.18)
	end
	--- 减防御或加防御
	if self.参战单位[挨打方].队伍~=0 then
		if self.参战单位[攻击方].法术状态.天地同寿 and self.参战单位[攻击方].法术状态.天地同寿.同辉~=nil and self:取目标类型(攻击方) == "玩家" then
			防御 = 防御 * (1-0.15)
		end
		if self.参战单位[攻击方].法术状态.剑意莲心 and self:取经脉(挨打方,"普陀山", "莲华") then
			伤害 = 伤害 + 150
		end
		if self.参战单位[挨打方].类型=="bb" then
			if self.参战单位[挨打方].灵身 ~= nil and self.参战单位[攻击方].强力 ~= nil then
				伤害 = 伤害 * 1.1
			end
			if self.参战单位[攻击方].生死决减防~=nil then
				防御 = 防御 - self.参战单位[攻击方].生死决减防
			end
			if self.参战单位[攻击方].天降大任~=nil then
				防御 = 防御 * self.参战单位[攻击方].天降大任
			end
		end
	end
	if 技能名称 == "弱点击破" then
		防御 = 防御 * 0.8

	elseif 技能名称 == "风雷斩·飞霆" or 技能名称 == "风雷斩" or 技能名称 == "风雷斩·霹雳" then
		伤害=伤害*1.3


	elseif 技能名称 == "壁垒击破" then
		伤害=伤害*1.3
		防御 = 防御 * 0.95
		if self.参战单位[挨打方].防御技能 then
			if self.参战单位[挨打方].防御技能==1 then
				防御 = 防御 - qz(self.参战单位[挨打方].等级*0.6)
			else
				防御 = 防御 - qz(self.参战单位[挨打方].等级*0.8)
			end
		end
		if self.参战单位[挨打方].玉砥柱 then
			伤害 = 伤害 * (1-self.参战单位[挨打方].玉砥柱)
		end
	elseif 技能名称 == "超级壁垒击破" then
		防御 = 防御 * 0.88
		if self.参战单位[挨打方].防御技能 then
			if self.参战单位[挨打方].防御技能==1 then
				防御 = 防御 - qz(self.参战单位[挨打方].等级*0.6)
			else
				防御 = 防御 - qz(self.参战单位[挨打方].等级*0.8)
			end
		end
		if self.参战单位[挨打方].玉砥柱 then
			伤害 = 伤害 * (1-self.参战单位[挨打方].玉砥柱)
		end
	end

	if self.参战单位[挨打方].法术状态.碎甲符 and self.参战单位[挨打方].法术状态.碎甲符.减双抗  then
		防御 = 防御 - self.参战单位[挨打方].法术状态.碎甲符.减双抗
	end

	local 攻修 = self.参战单位[攻击方].攻击修炼
	local 防修 = self.参战单位[挨打方].防御修炼
	local 伤害基数 = self:取伤害基数(攻击方,挨打方)
	local 结果 = qz((伤害 * 伤害基数)*(1+攻修*0.02) - 防御*(1+防修*0.02) + (攻修-防修)*5)-----------攻击修炼
	if self.参战单位[攻击方].减攻击 then --连击等等
		结果 = 结果 * self.参战单位[攻击方].减攻击
	end
	if self.参战单位[攻击方].偷袭~=nil then
		if self.参战单位[攻击方].偷袭==1 then
			结果 = 结果 * 1.05
		elseif self.参战单位[攻击方].偷袭==2 then
			结果 = 结果 * 1.1
		elseif self.参战单位[攻击方].偷袭==3 then
			结果 = 结果 * 1.15
		end
	end
	if self.参战单位[挨打方].逍遥游~=nil and self.参战单位[挨打方].逍遥一==nil then
		self.参战单位[挨打方].逍遥一 = 1
		结果 = 结果 * 0.8
	elseif self.参战单位[挨打方].招架~=nil and self.参战单位[挨打方].招架一==nil then
		self.参战单位[挨打方].招架一 = 1
		结果 = 结果 * self.参战单位[挨打方].招架
	end
	if not self.PK战斗 then
		if self.参战单位[攻击方].队伍==0 then
			结果=结果*0.82--*(self.参战单位[攻击方].WLXS or 1)
		else
			结果=结果*1.35
		end
	end
	if self.参战单位[攻击方].队伍~=0 and 时辰信息.昼夜 == 1 then
		if self.参战单位[攻击方].夜战 == 0 and self.参战单位[攻击方].昼伏夜出==nil and self.参战单位[攻击方].门派 ~= "阴曹地府" then
			结果 = 结果 * 0.8
		elseif self.参战单位[攻击方].昼伏夜出 then
			结果 = 结果 * 1.1
		end
	end

	-- if  self.参战单位[攻击方].超级夜战 then
	-- 	结果 = 结果 * 10
	-- end

	if self.PK战斗 then
		if 结果<300 then--待定
			return qz(结果*取随机数(110,115)/100)
		else
			return qz(结果*取随机数(95,115)/100)
		end
	end
	return qz(结果*取随机数(95,105)/100)
end


-- 1.怪物属性搞成固定，不用再去调整
-- 2.给怪物加一个物理伤害系数，用结果*这个系数，这样来调控怪物的伤害差距


function 战斗处理类:物理影响(攻击方, 挨打方,伤害,必杀几率,暴击倍率,技能名称)
	if self.参战单位[攻击方].队伍~=0 then
		if self.参战单位[攻击方].门派 == "大唐官府" then
			if self.参战单位[挨打方].受勇武~=nil and self.参战单位[挨打方].受勇武==攻击方 then
				伤害=伤害*1.1
			end
			if self.参战单位[挨打方].法术状态.重创 and self.参战单位[挨打方].法术状态.重创.攻击编号==攻击方 then
				伤害=伤害*1.1
			end
			if self.参战单位[攻击方].法术状态.傲视 then
				伤害 = 伤害*1.12
			end
			if self:取经脉(攻击方,"大唐官府", "突进") then
				self.参战单位[攻击方].伤害 = self.参战单位[攻击方].伤害+2
			end
			if self.参战单位[攻击方].法术状态["剑意"] and self.参战单位[攻击方].法术状态["剑意"].层数>=5 then
				伤害=伤害*1.05
			end
			if self:取经脉(攻击方, "大唐官府", "念心") and self:取玩家召唤兽(挨打方) == 0  then
				必杀几率 = 必杀几率 + 10
			end
			if self:取经脉(攻击方, "大唐官府", "静岳") and self.参战单位[攻击方].护盾>0 then
				必杀几率 = 必杀几率 + 4
			end
			if self.参战单位[攻击方].法术状态.干将莫邪 and self.参战单位[攻击方].法术状态.干将莫邪.加伤害~=nil and self.参战单位[攻击方].法术状态.干将莫邪.加伤害>1 then
				伤害=伤害*self.参战单位[攻击方].法术状态.干将莫邪.加伤害
			end

		elseif self.参战单位[攻击方].门派 == "天宫" then
			if self.参战单位[攻击方].法术状态.雷怒霆激 then
				local num = 0
				if self:取经脉(攻击方,"天宫", "霆震") then
					num = 伤害*(6-self.参战单位[攻击方].法术状态.雷怒霆激.回合)*0.01
				elseif self.参战单位[攻击方].法术状态.雷怒霆激.激越 then
					num	= 伤害*0.12
				end
				伤害 = 伤害 + num
			elseif self.参战单位[攻击方].法术状态.霹雳弦惊 then
				local num = 0
				if self:取经脉(攻击方,"天宫", "霆震") then
					num = 伤害*(6-self.参战单位[攻击方].法术状态.霹雳弦惊.回合)*0.01
				elseif self:取经脉(攻击方,"天宫", "激越") then
					num	= 伤害*0.12
				end
				伤害 = 伤害 + num
			end
			if 技能名称 == "破碎无双" and self:取经脉(攻击方,"天宫", "慨叹") then
				伤害 = 伤害 * 1.4
			end
			if self:取经脉(攻击方, "天宫", "电掣") and self:取目标类型(挨打方) == "召唤兽" then
				伤害 = 伤害 * 1.15
			end
			if self:取经脉(攻击方, "天宫", "神采") and self.参战单位[攻击方].气血>=self.参战单位[攻击方].最大气血*0.7 then
				伤害 = 伤害 * 1.05
			end

		elseif self.参战单位[攻击方].门派 == "普陀山" then
			if (技能名称 == "破血狂攻" or 技能名称 == "破碎无双") and self:取经脉(攻击方, "普陀山", "怒目") and self.参战单位[攻击方].法术状态.剑意莲心 then
				伤害 = 伤害 * 1.16
			end
			if self:取经脉(攻击方, "普陀山", "业障") and self:取目标类型(挨打方) == "召唤兽" then
				伤害 = 伤害 * 1.2
			end

		elseif self.参战单位[攻击方].门派 == "盘丝洞" then
			if self.参战单位[挨打方].法术状态.天罗地网~=nil then
				if self.参战单位[攻击方].粘附 and self.参战单位[攻击方].JM.当前流派~="百媚魔姝" then
					伤害 = 伤害 * 1.5
				end
				if self:取经脉(攻击方,"盘丝洞","杀戮") then
					伤害 = 伤害 * 1.08
				end
				if self:取经脉(攻击方, "盘丝洞", "罗刹") and self:取指定法宝(攻击方, "忘情")  then
					伤害 = 伤害 * 1.06
				end
			end

		elseif self.参战单位[攻击方].门派 == "阴曹地府" then
			if self:取经脉(攻击方,"阴曹地府", "夜之王者") then
				if 时辰信息.昼夜 == 1 then
					必杀几率 = 必杀几率 + 10
				end
				if 技能名称=="百爪狂杀" then
					伤害 = 伤害 * 1.14
				end
			end
			if self.参战单位[挨打方].法术状态.摄魂~=nil and self.参战单位[挨打方].法术状态.摄魂.攻击编号==攻击方 and self.参战单位[挨打方].法术状态.摄魂.狱火~=nil then
				伤害 = 伤害 * 1.12
			end
			if self.参战单位[挨打方].法术状态.尸腐毒~=nil then
				if self:取经脉(攻击方, "阴曹地府", "毒慑") then
					伤害 = 伤害 * 1.04
				end
				if self:取经脉(攻击方, "阴曹地府", "狂宴") then
					self:增加愤怒(攻击方,2)
				end
			end
			if self:取经脉(攻击方,"阴曹地府","破印") and self:取目标类型(挨打方) == "召唤兽" then
				伤害 = 伤害 * 1.15
			end
			if self:取经脉(攻击方,"阴曹地府", "毒炽") and self.参战单位[挨打方].法术状态.尸腐毒  then
				必杀几率 = 必杀几率 + 12
			end

		elseif self.参战单位[攻击方].门派 == "狮驼岭" then
			if self:取经脉(攻击方, "狮驼岭", "爪印") then
				self:添加状态("爪印", self.参战单位[挨打方], self.参战单位[攻击方],11)
				if self.参战单位[攻击方].爪印触发==nil then
					self.参战单位[攻击方].爪印触发=1
					if self.参战单位[挨打方].法术状态.爪印~=nil then
						if self.参战单位[挨打方].法术状态.爪印.层数~=nil then
					伤害 = 伤害 + self.参战单位[攻击方].等级*self.参战单位[挨打方].法术状态.爪印.层数
					end
					end
				end
			end
			if self:取经脉(攻击方, "狮驼岭", "协战") and self:取玩家召唤兽(攻击方) ~= 0 then
				伤害 = 伤害 * 1.07
			end
			if self.参战单位[攻击方].法术状态.天魔解体 and self:取经脉(攻击方, "狮驼岭", "癫狂") then
				必杀几率 = 必杀几率 + 10
			end
			if self.参战单位[攻击方].法术状态.狩猎 and self:取目标类型(挨打方) == "召唤兽" then
				伤害 = 伤害 * 1.12
			end

		elseif self.参战单位[攻击方].门派 == "五庄观" then
			if 技能名称=="烟雨剑法" then
				if self.参战单位[攻击方].雨杀~=nil then
					必杀几率 = 必杀几率 + 20
					self.参战单位[攻击方].雨杀=nil
				end
			end
			if self.参战单位[攻击方].骤雨.层数>0 then
				if self:取经脉(攻击方, "五庄观", "滂沱") then
					伤害 = 伤害 * (1+self.参战单位[攻击方].骤雨.层数*0.05)
					必杀几率 = 必杀几率 + (self.参战单位[攻击方].骤雨.层数*5)
				else
					伤害 = 伤害 * (1+self.参战单位[攻击方].骤雨.层数*0.02)
					必杀几率 = 必杀几率 + (self.参战单位[攻击方].骤雨.层数*2)
				end
			end
			if self:取经脉(攻击方, "五庄观", "剑势") and self.参战单位[挨打方].气血> self.参战单位[挨打方].最大气血*0.9 then
				伤害 = 伤害*1.09
			end
			if self:取经脉(攻击方, "五庄观", "致命") and self.PK战斗 then
				self.参战单位[挨打方].致命=1
			end
			if self:取经脉(攻击方,"五庄观", "聚力") and (技能名称 == "破碎无双" or 技能名称 == "破血狂攻" or 技能名称 == "弱点击破") then
				伤害 = 伤害 * (1+self.参战单位[攻击方].人参果.枚*0.15)
			end
			if self.参战单位[攻击方].法术状态.还元 then
				必杀几率 = 必杀几率 + self.参战单位[攻击方].法术状态.还元.层数*3
			end
		elseif self.参战单位[攻击方].门派 == "凌波城" then
			if self:取经脉(攻击方,"凌波城", "巧变") and self.参战单位[攻击方].战意<=3 then
				伤害 = 伤害 * 1.06
			end
			if self.参战单位[攻击方].法术状态.强袭 then
				伤害 = 伤害 * 1.16
			end
			if self.参战单位[攻击方].法术状态.真君显灵 then
				伤害 = 伤害 * (1+self.参战单位[攻击方].法术状态.真君显灵.加伤点/100)
			end
			if self:取经脉(攻击方,"凌波城", "威震") and (self.参战单位[攻击方].法术状态.天眼 or self.参战单位[攻击方].法术状态.怒眼 or self.参战单位[攻击方].法术状态.智眼) then
				伤害 = 伤害 * 1.04
			end
			if   self:取经脉(攻击方,"凌波城", "冰爆")  and 时辰信息.天气==3 then--"#Y
				必杀几率 = 必杀几率 + 10
			end
		elseif self.参战单位[攻击方].门派 == "花果山" then --伤害结果那里需要加一个  物法通用的状态
			if self.参战单位[攻击方].法术状态.铜头铁臂 then
				伤害 = 伤害 + self.参战单位[攻击方].护盾*0.1
			end
			if self:取经脉(攻击方,"花果山", "火眼") and 技能名称 == "弱点击破" then
				伤害 = 伤害 * 1.5
			end
			if self:取经脉(攻击方,"花果山", "金睛") and 技能名称 == "弱点击破" then
				伤害 = 伤害 * (1+0.15 * #self.参战单位[攻击方].如意神通)
			end
			if self.参战单位[攻击方].法术状态.压邪 then
				伤害 = 伤害 * 1.1
			end
			if self.参战单位[攻击方].法术状态.无所遁形 then
				必杀几率 = 必杀几率 + self.参战单位[攻击方].法术状态.无所遁形.层数*5
			end
			if self:取经脉(攻击方,"花果山", "威震") and self:取目标类型(挨打方) == "召唤兽" then
				伤害 = 伤害 * (1+ 0.06 * #self.参战单位[攻击方].如意神通)
			end
		elseif self.参战单位[攻击方].门派 == "女儿村" then
			if self:取经脉(攻击方, "女儿村", "花开") and self.参战单位[攻击方].气血>=self.参战单位[攻击方].最大气血*0.9 then
				伤害 = 伤害 * 1.03
			end
			if 技能名称=="葬玉焚花" then
				if self:取经脉(攻击方, "女儿村", "毒芒") and self.参战单位[挨打方].法术状态.毒 and self.参战单位[挨打方].法术状态.门派=="女儿村" then
					伤害 = 伤害 * 1.08
				end
				if self:取经脉(攻击方, "女儿村", "驯宠") and  self:取目标类型(挨打方)== "召唤兽" then
					伤害 = 伤害 * 1.12
				end
			elseif 技能名称=="满天花雨" then
				if self:取经脉(攻击方, "女儿村", "痴念") and self.参战单位[挨打方].神佑复活 and self:取目标类型(挨打方)== "召唤兽" then
					伤害 = 伤害 * 1.2
				end
			end
		end
		if self.参战单位[攻击方].法术状态.烽火狼烟 then
			伤害 = 伤害 * ( 1 + self.参战单位[攻击方].法术状态.烽火狼烟.加伤)
		end
	end

	----------------减少
	if self.参战单位[挨打方].队伍~=0 then
		-- if self.参战单位[挨打方].门派 == "普陀山" and self.参战单位[挨打方].JM.当前流派=="落伽神女" then
		if self.参战单位[挨打方].门派 == "龙宫" then
			if self.参战单位[挨打方].法术状态.神龙摆尾~=nil then
				伤害 = 伤害 * 0.8
			end
		elseif self.参战单位[挨打方].门派 == "花果山" then
			if self.参战单位[挨打方].法术状态.杀威铁棒~=nil and self.参战单位[挨打方].法术状态.杀威铁棒.攻击==挨打方 then
				伤害 = 伤害 * 0.9
			end
		end
		if self.参战单位[挨打方].法术状态.九梵清莲 ~= nil and self.参战单位[攻击方].类型 == "bb" then
			伤害 = qz(伤害 * (1 - self.参战单位[挨打方].法术状态.九梵清莲.境界 * 0.02)) --36
		end
		if self.参战单位[挨打方].抗法 then
			伤害 = 伤害+伤害*self.参战单位[挨打方].抗法[2]
		end
		if self.参战单位[挨打方].格挡物理伤害 then
			伤害 = 伤害-self.参战单位[挨打方].格挡物理伤害
		end
		----------佬伍修改（修复格挡值属性战斗中生效）
		if self.参战单位[挨打方].格挡值 then
			伤害 = 伤害-self.参战单位[挨打方].格挡值
		end
		----------佬伍修改（修复格挡值属性战斗中生效）
	end

   return 伤害,必杀几率

end

function 战斗处理类:状态必杀(单位)
	local fhz = 0
	if 单位.法术状态.镇魂诀 then
		fhz = fhz+单位.法术状态.镇魂诀.加必杀
	elseif 单位.法术状态.超级进击必杀 then
		if 单位.召唤回合==nil then 单位.召唤回合=self.回合数 end
		fhz = fhz+(31-(self.回合数-单位.召唤回合)*6)
	elseif 单位.法术状态.高级进击必杀 then
		fhz = fhz+单位.法术状态.高级进击必杀.加必杀
	elseif 单位.法术状态.进击必杀 then
		fhz = fhz+单位.法术状态.进击必杀.加必杀
	elseif 单位.法术状态.灵彻太虚 then
		fhz = fhz - 5
	end
	return fhz
end

-- function 战斗处理类:取最终物理伤害(攻击方,挨打方,伤害,必杀几率,暴击倍率,技能名称)
-- 	local 特效 = {}
-- 	local 动作 = "挨打"
-- 	--计算防御
-- 	伤害,必杀几率 = self:物理影响(攻击方, 挨打方,伤害,必杀几率,暴击倍率,技能名称)

-- 	--下面这些弄完全部检查一遍
-- 	-- 伤害 = self:物理增加伤害(攻击方, 挨打方,伤害,技能名称)
-- 	-- 伤害 = self:法宝伤害结果(攻击方, 挨打方, 伤害)
-- 	-- 伤害 = self:物理减少伤害(攻击方, 挨打方, 伤害,技能名称)
-- 	-- local min = qz(self.参战单位[攻击方].伤害*0.1)
-- 	if self.参战单位[挨打方].心随我动 and 取随机数() < 25 then
-- 		伤害 = 伤害 - self.参战单位[挨打方].心随我动
-- 	end
-- 	if 伤害 < 1 then
-- 		伤害 = 1
-- 	end
-- 	local 暴击 = false
-- 	if self.参战单位[挨打方].幸运 == nil and 必杀几率~=false then
-- 		local baojidengji=self.参战单位[攻击方].物理暴击等级
-- 		if self.参战单位[攻击方].法术状态.酣战 then
-- 			baojidengji=baojidengji+self.参战单位[攻击方].shenqi.lv*self.参战单位[攻击方].法术状态.酣战.层数*20
-- 		end
-- 		local 必杀转换 = (baojidengji - self.参战单位[挨打方].抗物理暴击等级)*8/self.参战单位[攻击方].等级
-- 		必杀几率 = 必杀几率 + self.参战单位[攻击方].必杀 + 必杀转换 + self.参战单位[攻击方].附加必杀 + (self.参战单位[攻击方].物理暴击几率 or 0)
-- 		必杀几率 = 必杀几率 + self:状态必杀(self.参战单位[攻击方])
-- 		if self:取经脉(攻击方, "凌波城", "破击") then
-- 			必杀几率 = 必杀几率*2
-- 			暴击倍率 = 1.3
-- 		end

-- 		暴击倍率 = 暴击倍率+self.参战单位[攻击方].附加必杀伤害

-- 		if 必杀几率 >= 取随机数()  then
-- 			if self:取经脉(挨打方, "无底洞", "灵身") then
-- 				暴击倍率 = 暴击倍率 - 0.4
-- 			end
-- 			if self:取经脉(挨打方, "凌波城", "神躯") then
-- 				暴击倍率 = 暴击倍率 - 0.2
-- 			end
-- 			if self.参战单位[攻击方].虎虎生风 then
-- 				暴击倍率 = 暴击倍率 + 0.7
-- 			end
-- 			if self.参战单位[挨打方].逍遥游~=nil then
-- 				暴击倍率 = 暴击倍率 - 0.4
-- 			end
-- 			if self.参战单位[攻击方].超级必杀>= 取随机数(1,100) then
-- 			-- 	if 取随机数(1,100)<=100 then
-- 				暴击倍率=暴击倍率+取随机数(1,2) --默认为2
-- 			end
-- 			-- end
-- 			if self.参战单位[挨打方].统御属性 and self.参战单位[挨打方].统御属性.铜墙铁壁 then
-- 				暴击倍率 = 暴击倍率 - self.参战单位[挨打方].统御属性.铜墙铁壁
-- 			end
-- 			if self.参战单位[攻击方].shenqi.name=="威服天下" then
-- 				暴击倍率 = 暴击倍率 + 0.12*self.参战单位[攻击方].shenqi.lv
-- 			end

-- 			伤害 = 伤害*暴击倍率

-- 			if self.参战单位[攻击方].凭风借力~=nil then
-- 				伤害 = 伤害 + (伤害 * self.参战单位[攻击方].凭风借力 * 0.125)
-- 				self.参战单位[攻击方].凭风借力 = 0
-- 			end
-- 			if self.参战单位[攻击方].队伍 ~= 0 and self.参战单位[攻击方].类型 == "bb" and self.参战单位[攻击方].狂怒 ~= nil then
-- 				伤害 = 伤害 + self.参战单位[攻击方].狂怒
-- 			end
-- 			if self:取经脉(攻击方, "大唐官府", "杀意") then
-- 				伤害 = 伤害 * 1.2
-- 			end
-- 			if self:取经脉(挨打方, "无底洞", "踏魄") and self.参战单位[挨打方].法术状态.裂魂 then
-- 				伤害 = 伤害 * 0.94
-- 			end
-- 			if self.参战单位[攻击方].物理暴击伤害 then
-- 				伤害 = 伤害 + qz(伤害 * self.参战单位[攻击方].物理暴击伤害 / 1000)
-- 			end
-- 			暴击 = true
-- 		else
-- 			if self.参战单位[攻击方].凭风借力~=nil and self.参战单位[攻击方].凭风借力<4 then
-- 				self.参战单位[攻击方].凭风借力 = self.参战单位[攻击方].凭风借力 + 1
-- 			end
-- 		end
-- 	end

-- 	if not self.PK战斗 then
-- 		if self:取目标类型(攻击方) == "玩家" then
-- 			if self.参战单位[攻击方].JM.百炼 then
-- 				self.参战单位[攻击方].JM.百炼 = self.参战单位[攻击方].JM.百炼 + 1
-- 				if self.参战单位[攻击方].JM.百炼 == 2 then
-- 					self.参战单位[攻击方].JM.百炼 =1
-- 					self.参战单位[攻击方].耐久计算.攻击=self.参战单位[攻击方].耐久计算.攻击+1
-- 				end
-- 			else
-- 				self.参战单位[攻击方].耐久计算.攻击=self.参战单位[攻击方].耐久计算.攻击+1
-- 			end
-- 		end
-- 		if self:取目标类型(攻击方) == "召唤兽" then
-- 			伤害 = qz(伤害 * 1.5)
-- 		end
-- 		if self:取目标类型(挨打方) == "玩家" or self:取目标类型(挨打方) == "召唤兽" then --召唤兽每受到8下物理攻击掉1点耐久。
-- 			self.参战单位[挨打方].耐久计算.挨打=self.参战单位[挨打方].耐久计算.挨打+1
-- 		end
-- 	end

-- 	if self.参战单位[攻击方].武器专属 and  self.参战单位[攻击方].武器专属.门派 == self.参战单位[攻击方].门派 and self.参战单位[攻击方].武器专属.类型 == "伤害" then
-- 		伤害 = qz(伤害 * ((100 + self.参战单位[攻击方].武器专属.数值) / 100))
-- 	end

-- 	return {伤害 = qz(伤害), 动作 = 动作, 特效 = 特效, 暴击 = 暴击}
-- end
function 战斗处理类:取最终物理伤害(攻击方,挨打方,伤害,必杀几率,暴击倍率,技能名称)
	local 特效 = {}
	local 动作 = "挨打"
	--计算防御
	伤害,必杀几率 = self:物理影响(攻击方, 挨打方,伤害,必杀几率,暴击倍率,技能名称)
	-- 添加攻防比保底机制（核心优化）
	local 攻击力 = self.参战单位[攻击方].伤害 or 0
	local 防御力 = self.参战单位[挨打方].防御 or 0
	local 攻击方等级 = self.参战单位[攻击方].等级 or 1
	local 挨打方等级 = self.参战单位[挨打方].等级 or 1

	-- 计算基础保底伤害
	local function 计算基础保底()
		-- 根据攻击方等级和攻击力计算最小伤害
		local 等级保底 = math.max(攻击方等级 * 0.5, 5)
		local 攻击力保底 = math.max(攻击力 * 0.06, 3)
		local 攻防比 = 攻击力 / (防御力 + 1)

		-- 攻防比修正系数
		local 修正系数 = math.max(0.25, math.min(1.0, 攻防比 * 0.8))

		-- 计算最终保底
		local 最终保底 = math.max(等级保底, 攻击力保底) * 修正系数

		-- 添加随机波动
		local 波动 = 取随机数(95, 105) / 100
		return math.max(1, math.floor(最终保底 * 波动))
	end

	if self.参战单位[挨打方].心随我动 and 取随机数() < 25 then
		伤害 = 伤害 - self.参战单位[挨打方].心随我动
	end

	-- 应用保底机制
	local 基础保底伤害 = 计算基础保底()
	if 伤害 < 基础保底伤害 then
		-- 判断是否破防
		local 等级差 = 攻击方等级 - 挨打方等级
		local 破防几率 = 20 + 等级差  -- 基础20%，等级差影响

		if 取随机数() <= 破防几率 then
			-- 破防成功，使用保底伤害
			伤害 = 基础保底伤害
		else
			-- 未破防，使用随机低伤害
			伤害 = 取随机数(1, 3)
		end
	end

	if 伤害 < 1 then
		伤害 = 1
	end
--幸运效果
	local 暴击 = false
	--if self.参战单位[挨打方].幸运 == nil and 必杀几率~=false then
	if (self.参战单位[挨打方].幸运 == nil or math.random(1,100) > 50) and 必杀几率~=false then----修改
		local baojidengji=self.参战单位[攻击方].物理暴击等级
		if self.参战单位[攻击方].法术状态.酣战 then
			baojidengji=baojidengji+self.参战单位[攻击方].shenqi.lv*self.参战单位[攻击方].法术状态.酣战.层数*20
		end
		local 必杀转换 = (baojidengji - self.参战单位[挨打方].抗物理暴击等级)*8/self.参战单位[攻击方].等级
		必杀几率 = 必杀几率 + self.参战单位[攻击方].必杀 + 必杀转换 + self.参战单位[攻击方].附加必杀 + (self.参战单位[攻击方].物理暴击几率 or 0)
		必杀几率 = 必杀几率 + self:状态必杀(self.参战单位[攻击方])
		if self.参战单位[攻击方].法术状态["剑意"] then
			必杀几率 = 必杀几率 + self.参战单位[攻击方].法术状态["剑意"].层数 --每层剑意增加1%暴击率
		end
		if self:取经脉(攻击方, "凌波城", "破击") then
			必杀几率 = 必杀几率*2
			暴击倍率 = 1.3
		end

		-- ====================== 幸运降暴击倍率 ======================新增
			    local 幸运类型 = self.参战单位[挨打方].幸运
			    if 幸运类型 ~= nil then
			        if 幸运类型 == "超级幸运" then
			            暴击倍率 = 暴击倍率 * 0.6  -- 超级幸运：-- 降低40%
			        elseif 幸运类型 == "高级幸运" then
			            暴击倍率 = 暴击倍率 * 0.6  -- 高级幸运：-- 降低40%
			        else
			            暴击倍率 = 暴击倍率 * 0.8 -- 普通幸运：-- 降低20%
			        end
			    end
    -- ==========================================================================

		暴击倍率 = 暴击倍率+self.参战单位[攻击方].附加必杀伤害
		if self.参战单位[攻击方].法术状态["剑意"] then
			暴击倍率 = 暴击倍率 + self.参战单位[攻击方].法术状态["剑意"].层数*0.01 --每层剑意增加1%暴击伤害
		end

		if 必杀几率 >= 取随机数()  then
			if self:取经脉(挨打方, "无底洞", "灵身") then
				暴击倍率 = 暴击倍率 - 0.4
			end
			if self:取经脉(挨打方, "凌波城", "神躯") then
				暴击倍率 = 暴击倍率 - 0.2
			end
			if self.参战单位[攻击方].虎虎生风 then
				暴击倍率 = 暴击倍率 + 0.7
			end
			if self.参战单位[挨打方].逍遥游~=nil then
				暴击倍率 = 暴击倍率 - 0.4
			end
			if self.参战单位[攻击方].超级必杀>= 取随机数(1,100) then
				暴击倍率=暴击倍率+取随机数(1,2)
			end
			if self.参战单位[挨打方].统御属性 and self.参战单位[挨打方].统御属性.铜墙铁壁 then
				暴击倍率 = 暴击倍率 - self.参战单位[挨打方].统御属性.铜墙铁壁
			end
			if self.参战单位[攻击方].shenqi.name=="威服天下" then
				暴击倍率 = 暴击倍率 + 0.12*self.参战单位[攻击方].shenqi.lv
			end

			伤害 = 伤害*暴击倍率

			if self.参战单位[攻击方].凭风借力~=nil then
				伤害 = 伤害 + (伤害 * self.参战单位[攻击方].凭风借力 * 0.125)
				self.参战单位[攻击方].凭风借力 = 0
			end
			if self.参战单位[攻击方].队伍 ~= 0 and self.参战单位[攻击方].类型 == "bb" and self.参战单位[攻击方].狂怒 ~= nil then
				伤害 = 伤害 + self.参战单位[攻击方].狂怒
			end
			if self:取经脉(攻击方, "大唐官府", "杀意") then
				伤害 = 伤害 * 1.2
			end
			if self:取经脉(挨打方, "无底洞", "踏魄") and self.参战单位[挨打方].法术状态.裂魂 then
				伤害 = 伤害 * 0.94
			end
			if self.参战单位[攻击方].物理暴击伤害 then
				伤害 = 伤害 + qz(伤害 * self.参战单位[攻击方].物理暴击伤害 / 1000)
			end
			暴击 = true
		else
			if self.参战单位[攻击方].凭风借力~=nil and self.参战单位[攻击方].凭风借力<4 then
				self.参战单位[攻击方].凭风借力 = self.参战单位[攻击方].凭风借力 + 1
			end
		end
	end

	if not self.PK战斗 then
		if self:取目标类型(攻击方) == "玩家" then
			if self.参战单位[攻击方].JM.百炼 then
				self.参战单位[攻击方].JM.百炼 = self.参战单位[攻击方].JM.百炼 + 1
				if self.参战单位[攻击方].JM.百炼 == 2 then
					self.参战单位[攻击方].JM.百炼 =1
					self.参战单位[攻击方].耐久计算.攻击=self.参战单位[攻击方].耐久计算.攻击+1
				end
			else
				self.参战单位[攻击方].耐久计算.攻击=self.参战单位[攻击方].耐久计算.攻击+1
			end
		end
		if self:取目标类型(攻击方) == "召唤兽" then--修改--物理召唤兽伤害
			伤害 = qz(伤害 * 1.3)--1.5
		end
		if self:取目标类型(挨打方) == "玩家" or self:取目标类型(挨打方) == "召唤兽" then
			self.参战单位[挨打方].耐久计算.挨打=self.参战单位[挨打方].耐久计算.挨打+1
		end
	end

	if self.参战单位[攻击方].武器专属 and  self.参战单位[攻击方].武器专属.门派 == self.参战单位[攻击方].门派 and self.参战单位[攻击方].武器专属.类型 == "伤害" then
		if self.参战单位[攻击方].武器专属.数值>10 then
			self.参战单位[攻击方].武器专属.数值=10
		end
		伤害 = qz(伤害 * ((100 + self.参战单位[攻击方].武器专属.数值) / 100))
	end
	if 伤害 < 1 then
		伤害 = 1
	end
	if 伤害 <= 5 then
		local 浮动 = 取随机数(98, 105) / 100
		伤害 = 伤害 * 浮动
	end

	return {伤害 = qz(伤害), 动作 = 动作, 特效 = 特效, 暴击 = 暴击}
end
function 战斗处理类:取灵力伤害(攻击方, 挨打方)
	local 伤害 = 攻击方.法伤 * 1.3  -- 基础伤害计算

	-- 处理挨打方为nil的情况
	if 挨打方 == nil then
		-- 添加基础保底伤害
		local 基础保底 = math.max(攻击方.法伤 * 0.1, 攻击方.等级 * 0.5, 10)
		local 最终伤害 = 基础保底 * 取随机数(95, 105) / 100
		return qz(最终伤害)
	end

	local 法防 = 挨打方.法防 or 0
	local 攻击方等级 = 攻击方.等级 or 1
	local 挨打方等级 = 挨打方.等级 or 1

	-- 计算最小保底伤害（解决打1血问题）
	local function 计算最小保底伤害()
		local 等级保底 = math.max(攻击方等级 * 0.5, 5)
		local 法伤保底 = math.max(攻击方.法伤 * 0.06, 3)
		local 等级差保底 = math.max(攻击方等级, 挨打方等级)

		-- 法攻法防比修正
		local 攻防比 = 攻击方.法伤 / (法防 + 1)
		local 修正系数 = math.max(0.25, math.min(1.2, 攻防比 * 0.8))

		local 最终保底 = math.max(等级保底, 法伤保底, 等级差保底) * 修正系数

		-- 添加随机波动
		local 波动 = 取随机数(95, 105) / 100
		return math.max(1, math.floor(最终保底 * 波动))
	end

	-- 踏魄效果
	if self:取经脉(挨打方, "无底洞", "踏魄") and 挨打方.法术状态.裂魂 then
		伤害 = 伤害 * 0.94
	end

	-- 诸天看护效果
	if 挨打方.法术状态 and 挨打方.法术状态.诸天看护 then
		伤害 = 伤害 + 伤害 * (0.015 * (1 + 挨打方.法术状态.诸天看护.层数))
	end

	-- 风灵效果
	if 攻击方.法术状态.风灵 then
		伤害 = 伤害 + 10 * 攻击方.法术状态.风灵.层数
	end

	-- 兽魂效果
	if self.回合数 <= 1 and 攻击方.兽魂 ~= nil and 攻击方.兽魂.五 == "爆裂" and not self.PK战斗 then
		伤害 = 伤害 * 1.3
	end

	if self.回合数 <= 2 and 挨打方.兽魂 and 挨打方.兽魂.五 == "破伤" and not self.PK战斗 then
		伤害 = 伤害 * 0.5
	end

	-- 爆裂触发
	if 攻击方.爆裂触发 and not self.PK战斗 then
		伤害 = 伤害 * 1.5
		攻击方.爆裂触发 = nil
	end

	-- 赤炎战笛
	if 攻击方.法术状态.赤炎战笛 then
		伤害 = qz(伤害 * (1 + 攻击方.法术状态.赤炎战笛.伤害))
	end

	-- 苍灵雪羽
	if 攻击方.法术状态.苍灵雪羽 then
		伤害 = 伤害 * (1 + 攻击方.法术状态.苍灵雪羽.加伤)
	end

	-- 防御技能
	if 攻击方.防御技能 ~= nil and 攻击方.超级防御 == nil then
		伤害 = 伤害 * 0.9
	end

	-- 出奇制胜
	if 攻击方.出奇制胜 then
		if self.回合数 >= 2 then
			伤害 = 伤害 * 1.25
		end
	end

	-- 魔之心
	if 攻击方.魔之心 ~= nil then
		伤害 = 伤害 * 攻击方.魔之心
	end

	-- 隔山打牛
	if 攻击方.隔山打牛 ~= nil and 取随机数() <= 20 then
		伤害 = 伤害 + 攻击方.隔山打牛
	end

	-- 沧浪赋
	if 攻击方.shenqi.name == "沧浪赋" and 挨打方.气血 < 挨打方.最大气血 * 0.3 then
		伤害 = 伤害 + 120 * 攻击方.shenqi.lv
	end

	-- 还阳术
	if 攻击方.还阳术 then
		伤害 = 伤害 * (1 + 攻击方.还阳术)
	elseif 挨打方.还阳术 then
		法防 = 法防 * (1 - 挨打方.还阳术)
	end

	-- 碎甲符
	if 挨打方.法术状态.碎甲符 and 挨打方.法术状态.碎甲符.减双抗 then
		法防 = 法防 - 挨打方.法术状态.碎甲符.减双抗
	end

	-- 弑神和顺势
	if 挨打方.神佑复活 and 攻击方.弑神 then
		伤害 = 伤害 + 攻击方.弑神
	elseif 攻击方.顺势 then
		if 挨打方.气血 < 挨打方.最大气血 * 0.7 then
			伤害 = 伤害 + 攻击方.顺势[1]
		else
			伤害 = 伤害 - 攻击方.顺势[2]
		end
	end

	-- 高山流水
	if 挨打方.类型 == "bb" and 攻击方.高山流水 ~= nil then
		伤害 = 伤害 + 攻击方.高山流水
	end

	-- 钢化
	if 挨打方.钢化 ~= nil then
		伤害 = 伤害 + (伤害 * 挨打方.钢化)
	end

	-- 计算修炼影响的基础伤害
	local 修炼加成 = 伤害 * (1 + 攻击方.法术修炼 * 0.02)
	local 法防减免 = 法防 * (1 + (挨打方.抗法修炼 * 0.02))
	local 修炼差加成 = (攻击方.法术修炼 - (挨打方.抗法修炼 or 0)) * 5

	伤害 = 修炼加成 - 法防减免 + 修炼差加成

	-- 非PK战斗伤害倍数
	if not self.PK战斗 then
		local 伤害倍数 = 1.2
		伤害 = 伤害 * 伤害倍数
	end

	-- 应用保底机制
	local 最小保证伤害 = 计算最小保底伤害()
	if 伤害 < 最小保证伤害 then
		-- 判断是否破防
		local 等级差 = 攻击方等级 - 挨打方等级
		local 破防几率 = 25 + 等级差  -- 基础25%，等级差影响

		if 取随机数() <= 破防几率 then
			-- 破防成功，使用保底伤害
			伤害 = 最小保证伤害
		else
			-- 未破防，使用随机低伤害
			伤害 = 取随机数(1, 3)
		end
	end

	-- 随机波动
	if self.PK战斗 then
		if 伤害 < 200 then
			伤害 = qz(伤害 * 取随机数(96, 104) / 100)
		else
			伤害 = qz(伤害 * 取随机数(88, 98) / 100)
		end
	else
		伤害 = qz(伤害 * 取随机数(96, 104) / 100)
	end

	-- 最终伤害保底
	if 伤害 < 1 then
		伤害 = 1
	end

	-- 低伤害添加随机性
	if 伤害 <= 5 then
		local 浮动 = 取随机数(98, 105) / 100
		伤害 = 伤害 * 浮动
	end

	return qz(伤害)
end
-- function 战斗处理类:取灵力伤害(攻击方, 挨打方)
-- 	local 伤害 = 攻击方.法伤* 1.3---C改
-- 	local 法防 = 挨打方 and 挨打方.法防 or 0
-- 	if self:取经脉(挨打方, "无底洞", "踏魄") and 挨打方.法术状态.裂魂 then
-- 		伤害 = 伤害 * 0.94
-- 	end
-- 	if 挨打方 and 挨打方.法术状态 and 挨打方.法术状态.诸天看护 then --增加基础
-- 		伤害 = 伤害 + 伤害 * (0.015 *(1+挨打方.法术状态.诸天看护.层数))
-- 	end
-- 	if 攻击方.法术状态.风灵 then
-- 		伤害 = 伤害 + 10 * 攻击方.法术状态.风灵.层数
-- 	end

-- 	if self.回合数<=1 and 攻击方.兽魂~=nil and 攻击方.兽魂.五=="爆裂"and  not self.PK战斗  then
-- 	      伤害=伤害*1.3
-- 	   end
-- 	if  self.回合数<=2 and   挨打方.兽魂 and 挨打方.兽魂.五=="破伤" and not self.PK战斗 then
-- 		伤害 = 伤害 * 0.5
-- 	end
-- 	if 攻击方.爆裂触发 and not self.PK战斗 then
-- 		伤害 = 伤害 * 1.5
-- 		攻击方.爆裂触发=nil
-- 	end
-- 	if 攻击方.法术状态.赤炎战笛 then
-- 	        伤害 = qz(伤害 * (1 + 攻击方.法术状态.赤炎战笛.伤害))
-- 	end

-- 	if 攻击方.法术状态.苍灵雪羽 then
-- 		伤害 = 伤害 * ( 1 + 攻击方.法术状态.苍灵雪羽.加伤 )
-- 	end
-- 	if 攻击方.防御技能~=nil and 攻击方.超级防御==nil then
-- 		伤害 = 伤害 * 0.9
-- 	end


-- 	if 攻击方.出奇制胜 then
-- 	       if	self.回合数>=2 then
-- 		伤害 = 伤害 * 1.25
-- 	end
-- 	end

-- 	if 攻击方.魔之心~=nil then
-- 		伤害 = 伤害 * 攻击方.魔之心
-- 	end
-- 	if 攻击方.隔山打牛~=nil and 取随机数()<=20 then
-- 		伤害 = 伤害 + 攻击方.隔山打牛
-- 	end
-- 	if 攻击方.shenqi.name=="沧浪赋" and 挨打方 and 挨打方.气血<挨打方.最大气血*0.3 then
-- 		伤害 = 伤害 + 120*攻击方.shenqi.lv
-- 	end
-- 	if 攻击方.还阳术 then
-- 		伤害 = 伤害 * (1 + 攻击方.还阳术)
-- 	elseif 挨打方 and 挨打方.还阳术 then
-- 		法防 = 法防 * (1 - 挨打方.还阳术)
-- 	end
-- 	if 挨打方 and 挨打方.法术状态.碎甲符 and 挨打方.法术状态.碎甲符.减双抗 then
-- 		法防 = 法防 - 挨打方.法术状态.碎甲符.减双抗
-- 	end
-- 	if 挨打方 and 挨打方.神佑复活 and 攻击方.弑神 then
-- 		伤害 = 伤害 + 攻击方.弑神
-- 	elseif 挨打方 and 攻击方.顺势 then
-- 		if 挨打方.气血<挨打方.最大气血*0.7 then
-- 			伤害 = 伤害 + 攻击方.顺势[1]
-- 		else
-- 			伤害 = 伤害 - 攻击方.顺势[2]
-- 		end
-- 	end
-- 	if 挨打方 and 挨打方.类型=="bb" and 攻击方.高山流水~=nil then
-- 		伤害 = 伤害 + 攻击方.高山流水
-- 	end
-- 	if 挨打方 and 挨打方.钢化 ~= nil then
-- 		伤害 = 伤害 + (伤害 * 挨打方.钢化)
-- 	end

-- 	if not self.PK战斗 then
-- 		local 伤害倍数 = 1.2
-- 		-- if 正式 then 伤害倍数 = 1.8 end
-- 		伤害=伤害*伤害倍数
-- 	end
-- 	if 挨打方 == nil then
-- 		伤害 = 1
-- 	else
-- 		伤害 = 伤害*(1+攻击方.法术修炼*0.02) - 法防*(1 + ((挨打方 and 挨打方.抗法修炼*0.02)) or 0) + (攻击方.法术修炼 - ((挨打方 and 挨打方.抗法修炼)) or 0)*5
-- 	end
-- 	if self.PK战斗 then
-- 		if 伤害<200 then
-- 			return qz(伤害*取随机数(96,104)/100)
-- 		else
-- 			return qz(伤害*取随机数(88,98)/100)
-- 		end
-- 	end
-- 	伤害 = qz(伤害*取随机数(96,104)/100)
-- 	return 伤害
-- end

function 战斗处理类:物法通用伤害(攻击方, 挨打方, 伤害)
	if self.参战单位[挨打方].鬼魂 then
		if self.参战单位[攻击方].驱鬼 and not self.参战单位[挨打方].超级驱鬼 then
			伤害 = 伤害 * self.参战单位[攻击方].驱鬼
		elseif self.参战单位[攻击方].降妖伏魔 then
			伤害 = 伤害 * self.参战单位[攻击方].降妖伏魔
		end
	elseif self.参战单位[攻击方].鬼魂 and not self.参战单位[攻击方].超级驱鬼 and  self.参战单位[挨打方].信仰 then
		伤害 = 伤害 * 1.2
	end
	if self.参战单位[攻击方].门派=="方寸山" then  --门派特色
		if self.参战单位[挨打方].鬼魂 then
			伤害 = 伤害 * 2
		elseif self.参战单位[挨打方].门派=="阴曹地府" then
			伤害 = 伤害 * 1.1
		end
	elseif self.参战单位[攻击方].门派=="女儿村" then
		if self:取经脉(挨打方, "女儿村", "叶护") and self:取队伍一速(挨打方) then
			伤害 = 伤害*(1-0.02)
		end
	elseif self.参战单位[攻击方].门派=="花果山" then
		if self.参战单位[攻击方].法术状态.荡魔 then
			伤害 = 伤害 * 1.12
		end
		if self.参战单位[攻击方].法术状态.愈勇 then
			伤害 = 伤害 * (1+self.参战单位[攻击方].法术状态.愈勇.层数*0.02)
		end
	end
	if self.参战单位[挨打方].门派=="花果山" then
		if self.参战单位[挨打方].法术状态.愈勇 then
			伤害 = 伤害 * (1-self.参战单位[挨打方].法术状态.愈勇.层数*0.02)
		end
	elseif self.参战单位[挨打方].门派=="普陀山" then
		if self:取经脉(挨打方, "普陀山", "安忍") then
			伤害 = 伤害 * (1-self.参战单位[挨打方].五行珠*0.01)
		elseif self:取经脉(挨打方, "普陀山", "低眉") and self.参战单位[挨打方].法术状态.剑意莲心 then
			伤害 = 伤害 * (1-0.05)
		end
	elseif self.参战单位[挨打方].门派=="盘丝洞" then
		if self:取经脉(挨打方, "盘丝洞", "玲珑") and self:取指定法宝(挨打方, "忘情") and sj()<=30 then
			伤害 = 伤害 * (1-0.12)
			self:增加愤怒(挨打方,10)
		end
	elseif self.参战单位[挨打方].门派=="阴曹地府" then
		if self.参战单位[攻击方].法术状态.尸腐毒 and self:取经脉(挨打方, "阴曹地府", "瘴幕") then
			伤害 = 伤害 * (1-0.04)
		end
	elseif self.参战单位[挨打方].门派=="方寸山" then
		if self.参战单位[攻击方].鬼魂  and self:取经脉(挨打方, "方寸山", "鬼念") then
			伤害 = 伤害 * 0.8
		end
		if self.参战单位[挨打方].shenqi.name=="披坚执锐" and 取随机数()<=self.参战单位[挨打方].shenqi.lv*4 then
			伤害 = 伤害 * 0.1
		end
	elseif self.参战单位[挨打方].门派=="狮驼岭" then
		if self:取指定法宝(挨打方, "失心钹") and self:取目标类型(攻击方) == "召唤兽" then
			local jj = self:取指定法宝境界(挨打方, "失心钹")
			伤害 = 伤害 * (1 - jj*0.012) --18％
		end
	elseif self.参战单位[挨打方].门派 == "五庄观" then
		if self:取指定法宝(挨打方, "奇门五行令") then
			local 境界 = self:取指定法宝境界(挨打方, "奇门五行令")
			local 伤害比 = self.参战单位[挨打方].气血 / self.参战单位[挨打方].最大气血
			if 伤害比<=0.75 then
				if 伤害比<=0.35 then
					伤害比=0.35
				end
				伤害比 = 伤害比 + (0.3 - 0.02 * 境界)
				伤害 = qz(伤害 * 伤害比)
			end
		end
	elseif self.参战单位[挨打方].门派 == "女儿村" then
		if self:取经脉(挨打方, "女儿村", "轻霜") and self.参战单位[攻击方].法术状态.毒 == nil  and 取随机数() < 30 then
			self:添加状态("毒", self.参战单位[攻击方],self.参战单位[挨打方], self:取技能等级(挨打方,"毒经"))
			self.参战单位[攻击方].法术状态.毒.回合掉血 = self:取技能等级(挨打方,"毒经") *3
			self.参战单位[攻击方].法术状态.毒.回合 = 4
		end
	elseif self.参战单位[挨打方].门派 == "凌波城" then
		if self.参战单位[挨打方].法术状态.不动如山 then
			伤害 = qz(伤害 * 0.6)
		end
	end

	if self:取目标类型(攻击方) == "召唤兽" then
		if self.友方经脉统计[self.参战单位[攻击方].队伍]~=nil then
			if self.友方经脉统计[self.参战单位[攻击方].队伍].驭兽~=nil then
				伤害 = 伤害 * 1.03
			end
		end
		if self.参战单位[攻击方].风起龙游 and self.参战单位[攻击方].速度>self.参战单位[挨打方].速度 then
			伤害 = 伤害 * 1.1
		end
		if self.参战单位[攻击方].力大无穷火 and self.参战单位[攻击方].五行=="火" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].力大无穷金 and self.参战单位[攻击方].五行=="金" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].力大无穷木 and self.参战单位[攻击方].五行=="木" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].力大无穷水 and self.参战单位[攻击方].五行=="水" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].力大无穷土 and self.参战单位[攻击方].五行=="土" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].万物之灵火 and self.参战单位[攻击方].五行=="火" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].万物之灵金 and self.参战单位[攻击方].五行=="金" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].万物之灵木 and self.参战单位[攻击方].五行=="木" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].万物之灵水 and self.参战单位[攻击方].五行=="水" then
			伤害 = 伤害 * 1.05
		end
		if self.参战单位[攻击方].万物之灵土 and self.参战单位[攻击方].五行=="土" then
			伤害 = 伤害 * 1.05
		end

		if self.参战单位[攻击方].雨露之泽 and 时辰信息.天气==2 then
			伤害 = 伤害 * 1.2
		end
		if self.参战单位[攻击方].清风之华 and 时辰信息.天气==3 then
			-- 单位.法伤 = 法伤 *1.1
			伤害 = 伤害 * 1.1
		end

		if self.参战单位[攻击方].法术状态.北冥之渊 then
			伤害 = 伤害 * 1.3
		end
		if self.参战单位[攻击方].玄武躯~=nil then
			伤害 = 伤害 * 0.5
		end
		if self.参战单位[攻击方].龙胄铠~=nil then
			伤害 = 伤害 * 0.5
		end
		if self.参战单位[攻击方].玉砥柱~=nil then
			伤害 = 伤害 * 0.8
		end
		if self.参战单位[攻击方].法术状态.遗志 then
			伤害 = 伤害 * (1+self.参战单位[攻击方].法术状态.遗志.层数*0.05)
		elseif self.参战单位[攻击方].法术状态.高级遗志 then
			伤害 = 伤害 * (1+self.参战单位[攻击方].法术状态.高级遗志.层数*0.1)
		elseif self.参战单位[攻击方].法术状态.超级遗志 then
			伤害 = 伤害 * (1+self.参战单位[攻击方].法术状态.超级遗志.层数*0.15)
		end
	elseif self:取目标类型(挨打方) == "召唤兽"  then
		if self.参战单位[挨打方].法术状态.普渡众生 and self.参战单位[挨打方].法术状态.普渡众生.慈佑 then
			伤害 = 伤害 * (1-0.12)
		end
		if self.友方经脉统计[self.参战单位[挨打方].队伍]~=nil and self.友方经脉统计[self.参战单位[挨打方].队伍].驭兽~=nil then
			伤害 = 伤害 *(1-0.03)
		end

		-- 特性影响 受到的所有伤害增加
		if self.参战单位[挨打方].巧劲 then
			伤害 = 伤害+伤害*self.参战单位[挨打方].巧劲[2]
		elseif self.参战单位[挨打方].识药 then
			伤害 = 伤害+伤害*self.参战单位[挨打方].识药[2]
		elseif self.参战单位[挨打方].御风 then
			伤害 = 伤害+伤害*self.参战单位[挨打方].御风[2]
		end
		-- 特性影响 受到的所有伤害增加
		if self.参战单位[挨打方].统御属性 and self.参战单位[挨打方].统御属性.偃旗息鼓 then
			伤害 = qz(伤害*(1-self.参战单位[挨打方].统御属性.偃旗息鼓))
		end
	end

	if self.参战单位[攻击方].法术状态.侵掠如火 and self.参战单位[攻击方].法术状态.侵掠如火.回合==1 then
		伤害 = 伤害 * (1+0.3)
	elseif self.参战单位[挨打方].法术状态.岿然如山 and self.参战单位[挨打方].法术状态.岿然如山.回合==1 then
		伤害 = 伤害 * (1-0.3)
	end

	if self.参战单位[挨打方].法术状态.落花成泥 and self.参战单位[挨打方].法术状态.落花成泥.回合==1 then
		伤害 = 伤害 * (1+0.24)
	end

	if self.参战单位[攻击方].法术状态.魍魉追魂 then
		伤害 = 伤害 * (1+self.参战单位[攻击方].法术状态.魍魉追魂.增伤)
	end
	if self.参战单位[攻击方].类型=="角色" and self.友方经脉统计[self.参战单位[攻击方].队伍]~=nil and self.友方经脉统计[self.参战单位[攻击方].队伍].贯通~=nil then
		伤害 = 伤害 *1.04
	end
	if self.参战单位[攻击方].法术状态.怒火 then
		伤害 = 伤害 * (1+0.32)
	end
	if self.参战单位[攻击方].法术状态.噬魂 then
		伤害 = 伤害 * 1.1
	end
	if self.参战单位[攻击方].陷阱~=nil then
		伤害 = 伤害 - self.参战单位[攻击方].陷阱.减伤
	end
	if self.参战单位[挨打方].法术状态.摄魂 then
		伤害 = 伤害 * (1+self.参战单位[挨打方].法术状态.摄魂.值)
	elseif self.参战单位[攻击方].法术状态.摄魂 then
		伤害 = 伤害 * (1-self.参战单位[挨打方].法术状态.摄魂.值)
	end
	if self.参战单位[挨打方].法术状态.五彩娃娃 ~= nil then
		伤害 =伤害 * (1 - self.参战单位[挨打方].法术状态.五彩娃娃.境界 * 0.02)
	elseif self.参战单位[挨打方].法术状态.苍白纸人 ~= nil then
		伤害 = 伤害 * (1 - self.参战单位[挨打方].法术状态.苍白纸人.境界 * 0.02)
	end
	if self.参战单位[挨打方].法术状态.璞玉灵钵 ~= nil then
		伤害 = qz(伤害 * (1 - self.参战单位[挨打方].法术状态.璞玉灵钵.境界 * 0.01 + 0.02)) --20
	elseif self.参战单位[攻击方].法术状态.璞玉灵钵 ~= nil then
		伤害 = qz(伤害 * (1 - self.参战单位[攻击方].法术状态.璞玉灵钵.境界 * 0.01 + 0.02)) --20
	end
	if self.参战单位[挨打方].法术状态.炎护 then
		local 临时伤害 = qz(伤害 * 0.5)
		if 临时伤害 > 1 then
			if self.参战单位[挨打方].魔法 > 临时伤害 then
				self:减少魔法(self.参战单位[挨打方],qz(临时伤害))
				临时伤害 = 0
			else
				临时伤害 = 临时伤害 - self.参战单位[挨打方].魔法
				self:减少魔法(self.参战单位[挨打方],self.参战单位[挨打方].魔法)
			end
			伤害 = qz(伤害 * 0.5) + 临时伤害
		end
	end
	if self.参战单位[挨打方].法术状态.煞气诀 then
		伤害 = qz(伤害 * 0.5)
	end
	if self:取全场状态("媚眼如丝") ~= false then
		伤害 = qz(伤害 * 0.9)
	end
	if self.参战单位[挨打方].风起云墨 then
		伤害 = qz(伤害 * (1-self.参战单位[挨打方].shenqi.lv*0.04))
	end
	if self.参战单位[挨打方].受伤百分比 then
		伤害 = qz(伤害 * self.参战单位[挨打方].受伤百分比)
	elseif self.参战单位[攻击方].增伤百分比 then
		伤害 = qz(伤害 * self.参战单位[攻击方].增伤百分比)
	elseif self.参战单位[攻击方].无畏的 then
		伤害 = qz(伤害+伤害 * (1-self.参战单位[攻击方].气血/self.参战单位[攻击方].最大气血))
	end

	if self.参战单位[挨打方].超级幸运 and 取随机数(1,100) <= 5 then
		伤害 = 1
	elseif self.参战单位[挨打方].超级精神集中 then
		local sjjsh=取随机数(1,10)/100
		伤害 = 伤害 * (1- sjjsh)
	end
	if self.参战单位[挨打方] and self.参战单位[挨打方].法术状态 and self.参战单位[挨打方].法术状态.修罗隐身~=nil and self.参战单位[挨打方].超级隐身 then
		伤害 = 伤害 * 0.9
	end
	------------------
	if self.参战单位[挨打方] and self.参战单位[挨打方].超级招架 then
		self.参战单位[挨打方].超级招架 = nil
		伤害 = 11
	end
	local gjfgh=false
	local aifgh=false
	for nv=1,#self.参战单位 do
		if self.参战单位[nv] ~= nil then
			if self.参战单位[攻击方].队伍 == self.参战单位[nv].队伍 and self.参战单位[nv].超级驱鬼 and self.参战单位[nv].鬼魂 then
				gjfgh=true --攻击方有鬼魂
				break
			end
			if self.参战单位[挨打方].队伍 == self.参战单位[nv].队伍 and self.参战单位[nv].超级驱鬼 and self.参战单位[nv].鬼魂 then
				gjfgh=true --挨打方有鬼魂
				break
			end
		end
	end
	if gjfgh then
		伤害 = 伤害 * 0.8
	end
	if aifgh then
		伤害 = 伤害 * 0.8
	end
	------------------
	if self.参战单位[攻击方].超信仰 then
		local yycjjn=0 --拥有的超级技能
		for k,v in pairs(self.参战单位[攻击方].技能) do
			if string.find(v,"超级")  and v~="超级神柚复生" and v~="超级三昧真火" then
				yycjjn=yycjjn+1
			end
		end
		-- 统计丸子进化技能中的超级技能（超级否定信仰）
		-----------------------------------C改
		if self.参战单位[攻击方].丸子进化 ~= nil and string.find(self.参战单位[攻击方].丸子进化, "超级") then
		        yycjjn = yycjjn + 1
		end
                        --这里重复，下面伤害结果那加，再加就是翻倍二次加成了
		-----------------------------------C改
		-- if yycjjn~=0 then
		-- 	伤害 = 伤害 * (1 + yycjjn*0.15)--C改
		-- end
		local qcjnsx={"信仰","感知","隐身","神佑","鬼魂","驱鬼","水吸","雷吸","火吸","土吸"}
		if self.参战单位[攻击方].超信清[挨打方]==nil then
			self.参战单位[攻击方].超信清[挨打方]={}
		end
		for k,v in pairs(qcjnsx) do
			if self.参战单位[挨打方][v] ~= nil then
				self.参战单位[攻击方].超信清[挨打方][v]=self.参战单位[挨打方][v]
				self.参战单位[挨打方][v]=nil
			end
		end
	end
	------------------
	if self.参战单位[攻击方].克敌五行 and self.参战单位[攻击方].五行~=nil and self.参战单位[挨打方].五行~=nil then
		local gxxk={金="木",木="土",土="水",水="火",火="金"}
		if gxxk[self.参战单位[攻击方].五行] == self.参战单位[挨打方].五行 then
			伤害 = 伤害 * 1.5
		end
	end

	-------------------
	if self.参战单位[攻击方].门派=="九黎城"  and self:取友方同门派人数(攻击方) >= 2 then  --影精灵同角色减伤
		伤害 = qz(伤害/10)
		for n = 1, #self.参战单位 do
			常规提示(self.参战单位[n].玩家id, "#Y同队伍只能拥有一个九黎城。")
		end
	end
	-------------------

	return qz(伤害)
end
function 战斗处理类:取友方同门派人数(编号)
	local 数量=0
	for n = 1, #self.参战单位 do
		if self.参战单位[n].类型=="角色" and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].门派~="无门派" and self.参战单位[n].门派 == self.参战单位[编号].门派 then
			数量=数量+1
		end
	end
	return 数量
end

-- function 战斗处理类:取友方同门派人数(编号)
-- 	local 数量=0
-- 	for n = 1, #self.参战单位 do
-- 		if self.参战单位[n].类型=="角色" and self.参战单位[n].队伍 == self.参战单位[编号].队伍  and self.参战单位[n].模型 == self.参战单位[编号].模型 then
-- 			数量=数量+1
-- 		end
-- 	end
-- 	return 数量
-- end


function 战斗处理类:取伤害结果(攻击方, 挨打方, 伤害, 暴击, 保护, 方式, 技能名称,防御) --如果保护存在 不触发神佑效果
	local zhiling
	if self.参战单位[攻击方].奇袭指令 then
		zhiling = self.参战单位[攻击方].奇袭指令
	else
		zhiling = self.参战单位[攻击方].指令
	end

	local 特效 = {}
	if 伤害 < 1 then
		伤害 = 1
	end
	-- 暴击=true
	local 类型 = 1
	if 方式 ~= 3 then --物理
		if 防御 then
			特效[#特效+1]  = "防御"
		end
		if 技能名称 and 技能名称 ~= "后发制人" then
			特效[#特效 + 1] = 技能名称
		end
		if 暴击 ~= nil and 暴击 ~= false then
			类型 = 3
			特效[#特效+1]  = "暴击"
		end
	else
		if 暴击 ~= nil and 暴击 ~= false then
			类型 = 3.5
			特效[#特效+1]  = "法术暴击"
		end
	end
	if self.参战单位[挨打方].法术状态.同舟共济 and self.参战单位[挨打方].法术状态.同舟共济.次数>0 and self.参战单位[self.参战单位[挨打方].法术状态.同舟共济.攻击编号].气血>0  then
		伤害=qz(伤害*0.25)
		self.参战单位[挨打方].法术状态.同舟共济.次数=self.参战单位[挨打方].法术状态.同舟共济.次数-1
		战斗计算:添加掉血(self,self.参战单位[挨打方].法术状态.同舟共济.攻击编号,伤害,攻击方)
	end
	if not self.PK战斗 and self.参战单位[挨打方].本命法宝 and self.参战单位[挨打方].本命法宝.开启 and self.参战单位[挨打方].本命法宝.耐久>0 then
		if  self.参战单位[挨打方].本命法宝.名称=="崆峒印" and  self.参战单位[挨打方].门派=="五庄观"  and 取随机数(1,100)<self.参战单位[挨打方].本命法宝.等级 then
			类型 = 2
			伤害=1
			return {伤害 =qz(伤害), 类型 = 类型,特效=特效}
		end
	end
	if self.参战单位[挨打方].法术状态.波澜不惊 then
		if self.参战单位[挨打方].法术状态.波澜不惊.次数==nil then  ---------佬伍修改（修复卡战斗情况，还需要测试）
			self.参战单位[挨打方].法术状态.波澜不惊.次数=0
			end
		if self.参战单位[挨打方].法术状态.波澜不惊.次数<4 then
			self.参战单位[挨打方].法术状态.波澜不惊.次数=self.参战单位[挨打方].法术状态.波澜不惊.次数+1
			if 伤害>(self.参战单位[挨打方].法术状态.波澜不惊.等级*2+150)*2 then
				伤害=(self.参战单位[挨打方].法术状态.波澜不惊.等级*2+150)*2
			end
			类型 = 2
			return {伤害 =qz(伤害), 类型 = 类型,特效=特效}
		end
	elseif not 保护 and self.参战单位[攻击方].法术状态.灵断==nil and 伤害 >= self.参战单位[挨打方].气血 and self.参战单位[挨打方].神佑 and self.参战单位[挨打方].神佑 >= 取随机数() then
		伤害 = self.参战单位[挨打方].最大气血
		if self.参战单位[挨打方].神佑<30 then
			伤害 = self.参战单位[挨打方].最大气血*0.6
		end
		类型 = 2
		if self:取目标类型(挨打方) == "召唤兽" then
			for k,v in pairs(self.参战单位[挨打方].技能) do
          		if v== "超级神柚复生" then
          			战斗计算:添加护盾(self,挨打方,self.参战单位[挨打方].最大气血)
          		end
      		end
			self.参战单位[挨打方].神佑复活 = true
		end
		return {伤害 =qz(伤害), 类型 = 类型,特效=特效}



	 elseif   伤害 >= self.参战单位[挨打方].气血  then
                        self.参战单位[挨打方].复活次数=0


		if self.参战单位[挨打方].钟灵石套装 and self.参战单位[挨打方].钟灵石套装.效果=="163"  and 取随机数(1,100) < self.参战单位[挨打方].钟灵石套装.加成 - (self.参战单位[挨打方].复活次数)*20  then

                 -- print("检测到163")
                        local x= self.参战单位[挨打方].气血 - 163
                        if x < 0  then--"#Y
                        x = 0 -x
                         伤害=x
		类型 = 2


	            elseif x> 0 then
	            伤害=x

                         end




			self.参战单位[挨打方].复活次数=self.参战单位[挨打方].复活次数+1
			消息提示(self.参战单位[挨打方].玩家id, "#Y/本次死亡触发163效果,回复气血至163.并提高伤害以及法术伤害,复活概率降低20%")



		end


	elseif 伤害 >= self.参战单位[挨打方].气血 and self.参战单位[挨打方].法术状态.渡劫金身 then
		伤害 = self.参战单位[挨打方].法术状态.渡劫金身.恢复气血
		类型 = 2
		if self:取目标类型(挨打方) == "召唤兽" then
			self.参战单位[挨打方].神佑复活 = true
		end
		self:取消状态("渡劫金身", self.参战单位[挨打方])
		return {伤害 =qz(伤害), 类型 = 类型,特效=特效}
	end

	伤害 = self:物法通用伤害(攻击方, 挨打方, 伤害)

	-- 超级否定信仰：新增每个超级技能增加15%所有伤害
	if self.参战单位[攻击方].超信仰 and self.参战单位[攻击方].超信技能数 then
		伤害 = qz(伤害 * (1 + self.参战单位[攻击方].超信技能数 * 0.15))
	end

	local jszt = {"分身术","敛恨","横扫千军","后发制人","破釜沉舟"} --通用的
	for k,v in pairs(jszt) do
		if self.参战单位[挨打方].法术状态[k] then
			if self.参战单位[挨打方].法术状态[k].减伤 then
				伤害 = 伤害-(伤害*self.参战单位[挨打方].法术状态[k].减伤)
			elseif self.参战单位[挨打方].法术状态[k].减伤点 then
				伤害 = 伤害-self.参战单位[挨打方].法术状态[k].减伤点
			end
		end
	end

	if 方式 ~= 3 then --物理
		if self:取指定法宝(挨打方, "金甲仙衣") then
			伤害 = 伤害 * 0.55
			特效[#特效+1]  = "金甲仙衣"
		elseif self:取指定法宝(挨打方, "蟠龙玉璧") then
			伤害 = 伤害 * 0.8
			if 特效[#特效] ~= "金甲仙衣" then
				特效[#特效+1]  = "金甲仙衣"
			end
		end
		if self.参战单位[挨打方].腾挪劲  and 取随机数() <= self.参战单位[挨打方].腾挪劲 then
			伤害 = 伤害 * 0.5
			特效[#特效+1]  = "腾挪劲"
		end
		if 技能名称=="百爪狂杀" and self.参战单位[攻击方].必中 then
			if self.PK战斗 then
				伤害 = 伤害 *1.1
			else
				伤害 = 伤害 *1.03
			end
		end
		if self:取经脉(攻击方, "五庄观", "陌宝") then
			伤害 = 伤害 * (1-0.15)
		end
		if self.参战单位[攻击方].强力 ~= nil and self.参战单位[挨打方].防御技能 ~= nil then
			伤害 = 伤害 * 0.8
		end

		if self.回合数<=1 and self.参战单位[攻击方].兽魂~=nil and self.参战单位[攻击方].兽魂.五=="爆裂"and  not self.PK战斗  then
		      伤害=伤害*1.3
		   end
		if self.参战单位[攻击方].爆裂触发 and not self.PK战斗 then
			伤害 = 伤害 * 1.5
			self.参战单位[攻击方].爆裂触发=nil
		end

		if  self.回合数<=2 and   self.参战单位[挨打方].兽魂 and self.参战单位[挨打方].兽魂.五=="破伤" and not self.PK战斗 then
			伤害 = 伤害 * 0.5
		end


		--直接是结果了
		if self:取目标类型(攻击方) == "召唤兽" then
			if self.参战单位[攻击方].法术状态.灵刃  then
				伤害=伤害*self.参战单位[攻击方].法术状态.灵刃.等级
			elseif self.参战单位[攻击方].力破 and self:取目标类型(挨打方) == "召唤兽" then
				伤害 = 伤害 - 伤害*self.参战单位[攻击方].力破[2]
			end
			--
			if not 技能名称 or 技能名称=="高级连击" or 技能名称=="超级连击" then
				if self.参战单位[攻击方].巧劲 then
					伤害 = 伤害+self.参战单位[攻击方].巧劲[1]
				elseif self.参战单位[攻击方].吮魔 then
					if self.PK战斗 then
						if self.参战单位[挨打方].魔法>self.参战单位[挨打方].最大魔法*0.5 then
							伤害 = 伤害-伤害*self.参战单位[攻击方].吮魔[2]
						end
						self:减少魔法(挨打方,qz(伤害*self.参战单位[攻击方].吮魔[1]))
					end
				elseif self.参战单位[攻击方].争锋 and self.PK战斗 then
					if self:取目标类型(挨打方) == "召唤兽" then
						伤害 = 伤害+伤害*self.参战单位[攻击方].争锋[1]
					else
						伤害 = 伤害-self.参战单位[攻击方].争锋[2]
					end
				end
			end
			if self.参战单位[攻击方].超级合纵 and self.参战单位[攻击方].超级合纵>0 then
				local ab=self.参战单位[攻击方].超级合纵
				local abc={1,2,8,18,32}
				if abc[ab] then
					伤害 = 伤害 + (伤害* (abc[ab]/100))
				end
			elseif self.参战单位[攻击方].合纵 and self.参战单位[攻击方].合纵>0 then
				伤害 = 伤害 + self.参战单位[攻击方].合纵
			end
			if self.参战单位[攻击方].舍身击 ~= nil then
				伤害 = 伤害 + self.参战单位[攻击方].舍身击
			end
		end
		if self.参战单位[挨打方].物伤减少~=nil then
			伤害=伤害*self.参战单位[挨打方].物伤减少
		end
		if self.参战单位[攻击方].百步穿杨 ~= nil and 取随机数()<=20 then
			伤害 = 伤害 + self.参战单位[攻击方].百步穿杨
		end
		if self.参战单位[挨打方].暗渡陈仓 then
			伤害 = 伤害 * self.参战单位[挨打方].暗渡陈仓
		end
		if self.参战单位[挨打方].法术状态.明光宝烛 then
			伤害 = 伤害 - self.参战单位[挨打方].法术状态.明光宝烛.加防
		end
		if self.参战单位[挨打方].法术状态.护佑 then
			伤害 = 伤害 - self.参战单位[挨打方].法术状态.护佑.等级
		end
		if self:取经脉(挨打方,"凌波城", "巧变")  and self.参战单位[挨打方].战意>=4 then
			伤害 = 伤害 - 150
		end
		if self:取经脉(挨打方, "阴曹地府", "回旋")  then
			伤害 = 伤害 - 65
		end
		if self:取经脉(攻击方, "阴曹地府", "六道") and 技能名称=="六道无量" then
			伤害 = 伤害 + self:取技能等级(攻击方,"六道无量")*4
		end
		--------------------------------破军
		if self.参战单位[攻击方].玄灵珠~=nil and self.参战单位[攻击方].玄灵珠破军~=nil then
			if 取随机数(1,100) <= self.参战单位[攻击方].玄灵珠破军*10 then
				伤害 = 伤害*(1+self.参战单位[攻击方].玄灵珠破军*0.01)
			end
		end

		-------------------
		伤害 = qz(伤害+self.参战单位[攻击方].物理伤害结果+self.参战单位[攻击方].物伤结果)

		if self.参战单位[攻击方].队伍~=0 and self.参战单位[攻击方].类型=="bb" then
			if self.参战单位[攻击方].千钧一怒 and self.参战单位[self.参战单位[攻击方].主人序号] and self.参战单位[self.参战单位[攻击方].主人序号].气血>0 then
				if 伤害>=self.参战单位[挨打方].最大气血*0.1 then
					self:增加愤怒(self.参战单位[攻击方].主人序号,10)
				end
			end
			if self.参战单位[攻击方].乘胜追击 ~= nil and 技能名称 ~= "乘胜追击" then
				self.参战单位[攻击方].乘胜追击 = self.参战单位[攻击方].乘胜追击 + 1
			end
		end

	elseif 方式 == 3 then --法系
		if self:取指定法宝(挨打方, "降魔斗篷") then
			伤害 = qz(伤害 * 0.5)
			特效[#特效+1]  = "金甲仙衣"
		elseif self:取指定法宝(挨打方, "蟠龙玉璧") then
			伤害 = 伤害 * 0.8
			if 特效[#特效] ~= "金甲仙衣" then
				特效[#特效+1]  = "金甲仙衣"
			end
		end
		-- 1.先增加  区分门派
		if self.参战单位[攻击方].门派 == "化生寺" then
			if self:取经脉(攻击方, "化生寺","持戒") and self.参战单位[挨打方].气血>self.参战单位[挨打方].最大气血*0.7 then
				伤害 = 伤害 * 1.05
			end
		end
		if self.参战单位[挨打方].法伤减少~=nil then
			伤害=伤害*self.参战单位[挨打方].法伤减少
		end
		if self:取经脉(挨打方, "五庄观", "守中") then
			伤害 = 伤害*0.94
		end
		if self:取经脉(攻击方, "花果山", "大圣") and self:取目标类型(挨打方) == "召唤兽" then
			伤害 = 伤害 * 1.16
		end
		if self.参战单位[挨打方].法术状态.清吟 or self.参战单位[挨打方].法术状态.龙啸 then
			伤害 = 伤害 *1.15
		end
		if self.参战单位[挨打方].法术状态.凋零之歌 then
			伤害 = 伤害 * 挨打方.法术状态["凋零之歌"].加伤
		end
		if self.参战单位[攻击方].法术状态.破浪 then --龙宫
			伤害 = 伤害 * 1.06
		elseif self.参战单位[挨打方].法术状态.破浪 then
			伤害 = 伤害 * (1 - 0.09)
		end
		if self.参战单位[挨打方].抗物 then
			伤害 = 伤害+伤害*self.参战单位[挨打方].抗物[2]
		end
		if self.参战单位[攻击方].shenqi.name=="流火" and (self.参战单位[攻击方].气血/self.参战单位[攻击方].最大气血)>(self.参战单位[挨打方].气血/self.参战单位[挨打方].最大气血) then
			伤害 = 伤害*(1+0.08*self.参战单位[攻击方].shenqi.lv)
		end



		if  self.参战单位[攻击方].玄灵珠 and self.参战单位[攻击方].玄灵珠.类型=="空灵" then
			伤害 = 伤害*(1+self.参战单位[攻击方].玄灵珠["空灵"]*0.01)
		end


		local 伤害减免 = 0
		if self.参战单位[挨打方].法术状态.法术防御 then
			伤害减免 = 0.65
		elseif self.参战单位[挨打方].法术状态.太极护法 or self.参战单位[挨打方].法术状态.罗汉金钟 then
			伤害减免 = 0.5
		elseif self.参战单位[挨打方].法术状态.安神诀 and self:取经脉(挨打方, "大唐官府", "安神") then
			伤害减免 = 0.5
		end

		伤害减免 = 伤害减免 + (self.参战单位[挨打方].法术伤害减免 or 0)

		if 伤害减免 >= 0.65 then
			伤害减免 = 0.65
		end

		if 伤害减免~=0 then
			if self:取经脉(攻击方, "龙宫", "汹涌") then --减免前 同类型相加减
				伤害减免 = 伤害减免 - 0.08
			elseif  self:取经脉(攻击方, "龙宫", "惊鸿")  and 技能名称 == "龙腾" then
				伤害减免 = 伤害减免 - 0.1
			elseif self.参战单位[挨打方].法术状态.法术防御 and self:取经脉(攻击方, "方寸山", "鬼怮")  and 技能名称 == "五雷咒" then
				-- if 挨打方==self.参战单位[攻击方].指令.目标 then
				if 挨打方==zhiling.目标 then
					伤害减免=0
				else
					伤害减免=0.1
				end
			end
			if self.参战单位[攻击方].通灵法~=nil then
				伤害减免 = 伤害减免 - self.参战单位[攻击方].通灵法
			end
		end
		--减免前

		伤害 = 伤害-qz(伤害 * 伤害减免)

		if self.参战单位[挨打方].法术状态.金身舍利 then
			伤害 = 伤害 - self.参战单位[挨打方].法术状态.金身舍利.加防
		end
		if self.参战单位[挨打方].法术状态.护佑 then
			伤害 = 伤害 - self.参战单位[挨打方].法术状态.护佑.等级
		end

		--减免后

		if 伤害减免~=0 then
			if self:取经脉(攻击方, "龙宫", "逐浪") and 技能名称 == "龙卷雨击" then
				伤害 = 伤害 + self:取技能等级(攻击方,"破浪诀")*0.8
			end
		end

		if self:取经脉(挨打方, "阴曹地府", "回旋")  then
			伤害 = 伤害 - 65
		end
		if self:取经脉(挨打方,"凌波城", "巧变")  and self.参战单位[挨打方].战意>=4 then
			伤害 = 伤害 - 150
		end
		if self.参战单位[挨打方].天照~=nil then
			if self.参战单位[挨打方].天照.名称=="推气" then
				伤害 = 伤害 - 40
			elseif self.参战单位[挨打方].天照.名称=="醍醐" then
				伤害 = 伤害 - 80
			end
		end
		if self.参战单位[挨打方].云随风舞~=nil then
			伤害=伤害-self.参战单位[挨打方].云随风舞
		end
		if self:取目标类型(攻击方) == "召唤兽" then
			if self.参战单位[攻击方].法术状态.灵法  then
				伤害 = 伤害*self.参战单位[攻击方].法术状态.灵法.等级
			end
			if self.参战单位[攻击方].擅咒 ~= nil then
				伤害 = 伤害 + self.参战单位[攻击方].擅咒
			end
			if self.参战单位[攻击方].法术状态.血债偿 then
				伤害 = 伤害 + self.参战单位[攻击方].法术状态.血债偿.层数*self.参战单位[攻击方].血债偿
			end
		end
		if self.参战单位[挨打方].化敌为友 then
			伤害 = 伤害*self.参战单位[挨打方].化敌为友
		end

		伤害 = qz(self:法系固定结果(攻击方, 挨打方, 伤害 , 技能名称) + self.参战单位[攻击方].法术伤害结果)

		if self.参战单位[挨打方].法术状态.九霄龙锥 then
			伤害 = qz(伤害 * self.参战单位[挨打方].法术状态.九霄龙锥.加伤)
		end

		if 技能名称 == "龙腾" and self:取经脉(攻击方, "龙宫", "摧意") and 伤害>=self.参战单位[挨打方].最大气血*0.08 then
			self:减少魔法(挨打方,300)
		end

	end

	if self.参战单位[挨打方].法术状态 then
		if self.参战单位[挨打方].法术状态["毒"] and self.参战单位[挨打方].法术状态["毒"].超级毒 then
			local dbh = self.参战单位[挨打方].法术状态["毒"].超级毒
			if dbh == 2 and 方式 ~= 3 then --降低 1攻击 2防御 3法伤 4法防
				伤害 = qz(伤害*1.1)
			elseif dbh == 4 and 方式 == 3 then
				伤害 = qz(伤害*1.1)
			end
		end
	end
	if self.参战单位[攻击方].法术状态 then
		if self.参战单位[攻击方].法术状态["毒"] and self.参战单位[攻击方].法术状态["毒"].超级毒 then
			local dbh = self.参战单位[攻击方].法术状态["毒"].超级毒
			if dbh == 1 and 方式 ~= 3 then --降低 1攻击 2防御 3法伤 4法防
				伤害 = qz(伤害*0.9)
			elseif dbh == 3 and 方式 == 3 then
				伤害 = qz(伤害*0.9)
			end
		end
		if self.参战单位[攻击方].法术状态["超级强力"] then
			伤害 = qz(伤害*0.9)
	    end
	end
	--结算以后的真实伤害了
	if self:取经脉(挨打方, "龙宫", "飞龙") and 伤害>=self.参战单位[挨打方].最大气血*0.2 and 取随机数()<=75 then
		self:添加状态("神龙摆尾", self.参战单位[挨打方], self.参战单位[挨打方],11)
	end
	if self:取经脉(挨打方, "魔王寨", "蚀天") and 伤害>=self.参战单位[挨打方].最大气血*0.2 then
		self:添加状态("蚀天", self.参战单位[挨打方], self.参战单位[挨打方],69)
	end
	if self:取经脉(挨打方, "魔王寨", "烈焰") and 伤害>=self.参战单位[挨打方].最大气血*0.2 then
		self:添加状态("炙烤", self.参战单位[挨打方], self.参战单位[挨打方],69,nil,3)
	end
	if self:取经脉(挨打方, "神木林", "灵佑") then
		伤害 = 伤害 * 0.98
	end
	if self.参战单位[攻击方].法术状态.雾杀 and self.参战单位[攻击方].法术状态.雾杀.迷缚 and self.参战单位[攻击方].法术状态.雾杀.迷缚==挨打方 then
		伤害 = 伤害 * 0.97
	end

	if self.参战单位[攻击方].法术状态.化怨清莲 then
		伤害 = qz(伤害 * self.参战单位[攻击方].法术状态.化怨清莲.境界)
	end

	if self.参战单位[挨打方].法术状态.化怨清莲 then
		伤害 = qz(伤害 * self.参战单位[挨打方].法术状态.化怨清莲.境界)
	end

	if self.参战单位[攻击方].法术状态.真阳令旗 then
		伤害 = qz(伤害 * self.参战单位[攻击方].法术状态.真阳令旗.境界)
	end

	if self.参战单位[攻击方].法术状态.寒霜盾戟 then
		伤害 = qz(伤害 * (1 + self.参战单位[攻击方].法术状态.寒霜盾戟.境界 * self.参战单位[攻击方].法术状态.寒霜盾戟.层数))
	end

	if self.参战单位[挨打方].法术状态.寒霜盾戟 then
		伤害 = qz(伤害 * (1 - self.参战单位[挨打方].法术状态.寒霜盾戟.境界 * self.参战单位[挨打方].法术状态.寒霜盾戟.层数))
	end

	if self.参战单位[攻击方].法术状态.赤炎战笛 then
		伤害 = qz(伤害 * (1 + self.参战单位[攻击方].法术状态.赤炎战笛.伤害))
	end

	if self.参战单位[挨打方].护体灵盾 and self.参战单位[挨打方].护体灵盾 > 0 then
		伤害 = qz(伤害 * 0.8)
	end

	if self.参战单位[挨打方].法术状态.惊兽云尺  then
		伤害 = qz(伤害 * (1 + self.参战单位[挨打方].法术状态.惊兽云尺.增加伤害))
	end

	if self.参战单位[攻击方].法术状态.惊兽云尺  then
		伤害 = qz(伤害 * (1 - self.参战单位[攻击方].法术状态.惊兽云尺.降低伤害))
	end

	if self.参战单位[攻击方].法术状态.战神宝典  then
		伤害 = qz(伤害 * (1 + self.参战单位[攻击方].法术状态.战神宝典.境界 * self.参战单位[攻击方].法术状态.战神宝典.执行回合))
	end
	if self.参战单位[攻击方].指令.固定伤害数额 then
		伤害 = self.参战单位[攻击方].指令.固定伤害数额
	end
	if self.参战单位[挨打方].JM.磐石 then
		if self.参战单位[挨打方].磐石==nil then --首个攻击自己的先记录下来
			self.参战单位[挨打方].磐石={记录组={}}
			self.参战单位[挨打方].磐石.记录组[攻击方]=攻击方
		else
			if self.参战单位[挨打方].磐石.记录组[攻击方]==nil then --下一个攻击自己的没记录才会减伤害
				self.参战单位[挨打方].磐石.记录组[攻击方]=攻击方
				self.参战单位[挨打方].JM.磐石 = self.参战单位[挨打方].JM.磐石 + 1
				伤害=伤害-(self.参战单位[挨打方].JM.磐石 *55)
			end
		end
	end



	 if self.参战单位[攻击方].钟灵石套装 and self.参战单位[攻击方].钟灵石套装.效果=="心源"  then
            	-- print("检测到心愿")
		if 取随机数(1,200) < 40 then
			self:添加状态("心源",self.参战单位[攻击方],self.参战单位[攻击方],69)
			伤害 = 伤害 +伤害*self.参战单位[攻击方].钟灵石套装.加成/100
            	-- print("伤害输出")

			消息提示(self.参战单位[攻击方].玩家id, "#Y/本次出手触发心源效果，伤害值为：#R/"..伤害)
		end
	    end


            if self.参战单位[攻击方].钟灵石套装 and self.参战单位[攻击方].钟灵石套装.效果=="163"  and self.参战单位[攻击方].气血 ==163 then
			伤害 = 伤害 +伤害*self.参战单位[攻击方].钟灵石套装.加成/100
			消息提示(self.参战单位[攻击方].玩家id, "#Y/本次出手触发163效果，伤害值为：#R/"..伤害)
	end


	if self.参战单位[挨打方].法术状态.混元伞 then
		local 反弹伤害=qz(伤害*(self.参战单位[挨打方].法术状态.混元伞.境界*0.01+0.03))
		if 反弹伤害<1 then
			反弹伤害=1
		end
		伤害 = 伤害 - 反弹伤害
		local 临时目标 = self:取单个敌方目标(挨打方)
		if 临时目标~=0 then
			战斗计算:添加掉血(self,临时目标,反弹伤害,挨打方)
		end
	end

	if 伤害 < 1 then 伤害 = 1 end

	return {伤害 = qz(伤害), 类型 = 类型,特效=特效}
end

function 战斗处理类:法系固定结果(攻击方, 挨打方, 伤害, 技能名称) --结果
	if self.参战单位[攻击方].门派=="龙宫" then
		if self:取经脉(攻击方, "龙宫", "龙慑") and self:取目标类型(挨打方) == "召唤兽" then
			if self:取装备五行(攻击方,3)=="水" then --武器
				伤害 = 伤害 + 120
			end
			if self:取装备五行(攻击方,4)=="水" then --衣服
				伤害 = 伤害 + 120
			end
		end
		if 技能名称=="龙卷雨击" and self:取经脉(攻击方, "龙宫","狂浪") and 取随机数()<=50 then
			伤害 = 伤害 + 80
		end
		if self.参战单位[攻击方].法术状态.龙战于野 then
			伤害 = 伤害 * 1.16
		end
		if self:取指定法宝(攻击方, "镇海珠") then --百分比增加
			local zz = 1 + self:取指定法宝境界(攻击方, "镇海珠") * 0.0067
			if self:取经脉(攻击方, "龙宫", "龙珠") then
				zz = zz + 0.033
			end
			伤害 = 伤害 * zz
		end
	elseif self.参战单位[攻击方].门派=="魔王寨" then
		if self:取经脉(攻击方, "魔王寨", "震怒") and 技能名称 == "飞砂走石" then
			伤害 = 伤害 + 40
		end
	elseif self.参战单位[攻击方].门派=="方寸山" then
		if self:法宝是否有(攻击方,"救命毫毛") then
			if self:取经脉(攻击方, "方寸山", "宝诀") or self:取经脉(攻击方, "方寸山", "妙用") or self:取经脉(攻击方, "方寸山", "不灭") then
				伤害 = 伤害 * (1+self:取指定法宝境界(攻击方,"救命毫毛")/2/100)
			end
		end
	elseif self.参战单位[攻击方].门派=="天宫" then
		if self:取指定法宝(攻击方,"伏魔天书") then
			if self:取经脉(攻击方,"天宫","伏魔") then
				伤害=伤害+qz(self:取指定法宝境界(攻击方,"伏魔天书")*取随机数(20,30)*1.5)
			else
				伤害=伤害+qz(self:取指定法宝境界(攻击方,"伏魔天书")*取随机数(20,30))
			end
		end
	elseif self.参战单位[攻击方].门派=="化生寺" then
		if self:取经脉(攻击方, "化生寺", "诵律") and self:取目标类型(挨打方) == "召唤兽" then
			伤害 = 伤害 + 100
		end
		if self:取经脉(攻击方, "化生寺", "授业") and (技能名称 == "唧唧歪歪" or 技能名称 == "谆谆教诲") then
			伤害 = 伤害 + 30
		end
	elseif self.参战单位[攻击方].门派=="神木林" then
		if self.参战单位[攻击方].法术状态.凭虚御风 then
			伤害 = 伤害 + 40*self.参战单位[攻击方].法术状态.凭虚御风.层数*self.参战单位[攻击方].shenqi.lv
		end
	end
	if self.参战单位[攻击方].法术状态.魂魇 then
		伤害 = 伤害 - 100*self.参战单位[攻击方].法术状态.魂魇.等级
	end
	return qz(伤害)
end

function 战斗处理类:经脉混合伤害结果(攻击方, 挨打方, 伤害, 类型, 伤害类型,技能名称,暴击,保护) --目前是累乘，看情况调整为累加  --这个是混搭的伤害结果也是最后的计算过程了
	if self.参战单位[攻击方].门派 == "大唐官府" then
		if self:取被动(攻击方, "披坚执锐") then
			local xs = 1
			local zhiling
			if self.参战单位[攻击方].奇袭指令 then
				zhiling = self.参战单位[攻击方].奇袭指令
			else
				zhiling = self.参战单位[攻击方].指令
			end

			if self.参战单位[攻击方].触发追加~=nil then
				if self:取经脉(攻击方, "大唐官府", "效法") then
					xs = 1.04
				elseif self:取经脉(攻击方, "大唐官府", "追戮") and self.参战单位[攻击方].三件套名称~=nil and zhiling.参数 ==self.参战单位[攻击方].三件套名称 then
				-- elseif self:取经脉(攻击方, "大唐官府", "追戮") and self.参战单位[攻击方].三件套名称~=nil and self.参战单位[攻击方].指令.参数 ==self.参战单位[攻击方].三件套名称 then
					xs = 1.05
				elseif self:取经脉(攻击方, "大唐官府", "烈光") then --and self.参战单位[攻击方].披坚执锐~=nil and #self.参战单位[攻击方].披坚执锐>0
					xs = #self.参战单位[攻击方].披坚执锐 * 0.015
				end
				if self.PK战斗 and self:取经脉(攻击方, "大唐官府", "奉还")  and self.参战单位[挨打方].类型=="角色" and self.参战单位[挨打方].门派 == self:取技能所属门派(self.参战单位[攻击方].指令.参数) then
					xs = xs * 1.2
				end
				if self.参战单位[攻击方].催迫~=nil then
					self.参战单位[攻击方].催迫=2
					xs = xs * 1.2
				end
				if self:取经脉(攻击方, "大唐官府","诛伤") then
					if self.参战单位[攻击方].披坚执锐[self.参战单位[攻击方].披坚执锐.可用编号].首次触发==nil then
						self.参战单位[攻击方].披坚执锐[self.参战单位[攻击方].披坚执锐.可用编号].首次触发=1
						xs = xs * 1.1
					end
				end
				if self.参战单位[攻击方].灵能~=nil then
					self.参战单位[攻击方].灵能=2
					xs = xs * 1.12
				end
			end
			if self.参战单位[攻击方].法术状态.攻伐 then
				xs = xs * 1.05
			end
			if self:取经脉(攻击方, "大唐官府", "暴突") then
				xs = xs * 1.03
			end
			伤害 = 伤害*xs
		end
	end

	return 伤害
end

-- function 战斗处理类:物理增加伤害(攻击方, 挨打方, 伤害,技能名称)











--  伤害 = 伤害 + (self.参战单位[攻击方].防御 * self.参战单位[攻击方].狂暴等级) --这个是什么意思

--  return 伤害
-- end

function 战斗处理类:法术增加伤害(攻击方, 挨打方, 伤害)

	-- local 挨打方状态加伤 = {"凋零之歌","九霄龙锥"}
	-- for k,v in pairs(挨打方状态加伤) do
	--  if 挨打方.法术状态[k] and 挨打方.法术状态[k].加伤 then
	--      伤害 = 伤害+(伤害*挨打方.法术状态[k].加伤)
	--  end
	-- end
	return 伤害
end

function 战斗处理类:取多个友方bb目标(编号,目标,数量)
	local 目标组 = {目标}
	if self:取目标状态(编号, 目标, 2) == false then
		目标组 = {}
	end
	if #目标组 >= 数量 then
		return 目标组
	end
	for n = 1, #self.参战单位 do
		if #目标组 < 数量 and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].类型=="bb" and self:取目标状态(编号, n, 1) then
			local 添加 = true
			for i = 1, #目标组 do
				if 目标组[i] == n then 添加 = false end
			end
			if 添加 then
				目标组[#目标组 + 1] = n
			end
		end
	end
	return 目标组
end

function 战斗处理类:取多个友方目标(编号,目标,数量,名称)

	if self.参战单位[目标] == nil or self.参战单位[目标].队伍 ~= self.参战单位[编号].队伍 then
		目标 = self:取单个友方目标(编号)
	end
	local 目标组 = {目标} --有可能选中自己了
	if self:取目标状态(编号, 目标, 2) == false then
		目标组 = {}
	elseif not 数量 then
		数量=1
		print(名称.."没有技能数量")
	end

	if #目标组 >= 数量 then
		return 目标组
	end
	if 名称 ~= "推气过宫" and 名称 ~= "妙手回春" and 名称 ~= "救死扶伤" and 名称 ~= "地涌金莲" and 名称 ~= "尸腐毒" and 名称 ~= "尸腐无常" and 名称 ~= "慈航普度" and 名称 ~= "重生"
		and 名称 ~= "其疾如风" and 名称 ~= "其徐如林" and 名称 ~= "侵掠如火" and 名称 ~= "岿然如山" and 名称 ~= "尸腐无常" and 名称 ~= "角色队友" then
		for n = 1, #self.参战单位 do
			if #目标组 < 数量 and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) and self.参战单位[n].法术状态[名称] == nil then
				local 添加 = true
				for i = 1, #目标组 do
					if 目标组[i] == n then 添加 = false end
				end
				if 添加 then
					目标组[#目标组 + 1] = n
				end
			end
		end
		return 目标组
	elseif 名称 == "慈航普度" or 名称 == "重生" then
		for n = 1, #self.参战单位 do
			if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and n~=编号 and not 初始技能计算:不可复活(self.参战单位[n]) and (self.参战单位[n].类型 == "角色" or self.参战单位[n].类型 == "系统角色") then
				local 添加 = true
				for i = 1, #目标组 do
					if 目标组[i] == n then 添加 = false end
				end
				if 添加 then
					目标组[#目标组 + 1] = n
				end
			end
		end
		return 目标组
	elseif 名称 == "其疾如风" or 名称 == "侵掠如火" or 名称 == "岿然如山" or 名称 == "角色队友" then
		for n = 1, #self.参战单位 do
			if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) and self.参战单位[n].法术状态[名称] == nil and self.参战单位[n].类型 == "角色" then
				local 添加 = true
				for i = 1, #目标组 do
					if 目标组[i] == n then 添加 = false end
				end
				if 添加 then
					目标组[#目标组 + 1] = n
				end
			end
		end
		local 排序组 = {}
		for n = 1, #目标组 do
			排序组[n] = {气血 = self.参战单位[目标组[n]].气血 / self.参战单位[目标组[n]].最大气血 * 100, id = 目标组[n]}
		end
		table.sort(排序组, function(a, b) return a.气血 < b.气血 end)
		目标组 = {}
		for n = 1, #排序组 do
			if #目标组 < 数量 then
				目标组[n] = 排序组[n].id
			end
		end
		return 目标组
	elseif 名称 == "尸腐毒" or 名称 == "尸腐无常" then
		for n = 1, #self.参战单位 do
			if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) and self.参战单位[n].法术状态[名称] == nil then --and self.参战单位[编号].类型 == "角色"
				local 添加 = true
				for i = 1, #目标组 do
					if 目标组[i] == n then 添加 = false end
				end
				if 添加 then
					目标组[#目标组 + 1] = n
				end
			end
		end
		local 排序组 = {}
		for n = 1, #目标组 do
			排序组[n] = {气血 = self.参战单位[目标组[n]].气血 / self.参战单位[目标组[n]].最大气血 * 100, id = 目标组[n]}
		end
		table.sort(排序组, function(a, b) return a.气血 > b.气血 end) --气血越多的排前面
		目标组 = {}
		for n = 1, #排序组 do
			if #目标组 < 数量 then
				目标组[n] = 排序组[n].id
			end
		end
		return 目标组
	else
		for n = 1, #self.参战单位 do
			if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) and self.参战单位[n].法术状态[名称] == nil then
				local 添加 = true
				for i = 1, #目标组 do
					if 目标组[i] == n then 添加 = false end
				end
				if 添加 then
					目标组[#目标组 + 1] = n
				end
			end
		end
		local 排序组 = {}
		for n = 1, #目标组 do
			排序组[n] = {气血 = self.参战单位[目标组[n]].气血 / self.参战单位[目标组[n]].最大气血 * 100, id = 目标组[n]}
		end
		table.sort(排序组, function(a, b) return a.气血 < b.气血 end)
		目标组 = {}
		for n = 1, #排序组 do
			if #目标组 < 数量 then
				目标组[n] = 排序组[n].id
			else
				if 名称 == "地涌金莲" and self:取经脉(编号,self.参战单位[编号].门派,"救人") and (self.参战单位[排序组[n].id].法术状态.明光宝烛 or self.参战单位[排序组[n].id].法术状态.金身舍利) then
					目标组[#目标组 + 1] = 排序组[n].id
				end
			end
		end
	end
	return 目标组
end

-- function 战斗处理类:取多个敌方目标(编号, 目标, 数量)
--  local 目标组 = {目标}
--  if self:取目标状态(编号, 目标, 1) == false then
--      目标组 = {}
--  elseif self.参战单位[目标].队伍 == self.参战单位[编号].队伍 then
--      目标组 = {}
--  end
--  local 经脉附加 = false
--  if #目标组 >= 数量 then
--      经脉附加 = true
--  end

--  for n = 1, #self.参战单位 do
--      if not 经脉附加 and  #目标组 < 数量 and self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
--          --目标组[#目标组+1]=n
--          local 添加 = true
--          if self.参战单位[编号].指令.参数 == "笑里藏刀"  then
--              if self.参战单位[n].类型 ~= "角色" then
--                  添加 = false
--              end
--          else
--              for i = 1, #目标组 do
--                  if 目标组[i] == n then 添加 = false end
--              end
--          end
--          if 添加 then
--              目标组[#目标组 + 1] = n
--          end
--      elseif 经脉附加 == true and self.参战单位[n].法术状态.尸腐毒 and self:取经脉(编号, "毒印") and (self.参战单位[编号].指令.参数 == "六道无量" or self.参战单位[编号].指令.参数 == "判官令" )  then
--          经脉附加 = 1
--          目标组[#目标组 + 1] = n
--      end
--  end

--  return 目标组
-- end

function 战斗处理类:取多个敌方目标(编号,目标,数量)
	local 目标组={目标}--初始赋值，将手动选择的攻击目标添加进目标组数组。

	if self:取目标状态(编号,目标,1)==false then--这里判断，如果手动选择的目标死亡，就删除。
		目标组={}
	elseif self.参战单位[目标].队伍==self.参战单位[编号].队伍 then
		目标组={}
	end

	if #目标组>=数量 then--如果数量剩1个就不执行后面操作，直接返回这1个目标。
		return 目标组
	end
	local 临时目标组 = {}

	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
			local 添加=true
			for j=1,#目标组 do
				if 目标组[j]==n then
					添加=false
				end
			end
			if 添加 then
				临时目标组[#临时目标组 + 1] = {a=n,b=self.参战单位[n].速度}   --添加进去的时候直接赋值函数
			end
		end
	end

	table.sort(临时目标组,function(a,b) return a.b > b.b end)  --做个排序
	for n=1,#临时目标组 do
		if #目标组 < 数量 then  --未达到数量 继续添加目标
			目标组[#目标组+1] = 临时目标组[n].a
		end

	end

	return 目标组
end

function 战斗处理类:取多个溅射目标(编号,目标,数量)

	local 目标组={目标}--初始赋值，将手动选择的攻击目标添加进目标组数组。

	if self:取目标状态(编号,目标,1)==false then--这里判断，如果手动选择的目标死亡，就删除。
		目标组={}
	elseif self.参战单位[目标].队伍==self.参战单位[编号].队伍 then
		目标组={}
	end
	if #目标组>=数量 then--如果数量剩1个就不执行后面操作，直接返回这1个目标。
		return 目标组
	end
	local 临时目标组 = {}
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
			local 添加=true
			for j=1,#目标组 do
				if 目标组[j]==n then
					添加=false
				end
			end
			if 添加 then
				临时目标组[#临时目标组 + 1] = {a=n,b=取随机数(1,1000)}   --添加进去的时候直接赋值函数
			end
		end
	end
	table.sort(临时目标组,function(a,b) return a.b > b.b end)  --做个随机排序
	for n=1,#临时目标组 do
		if #目标组 < 数量 then  --未达到数量 继续添加目标
			目标组[#目标组+1] = 临时目标组[n].a
		end

	end

	return 目标组
end


function 战斗处理类:取多个敌方角色目标(编号,目标,数量)
	local 目标组={目标}--初始赋值，将手动选择的攻击目标添加进目标组数组。

	if self:取目标状态(编号,目标,1)==false then--这里判断，如果手动选择的目标死亡，就删除。
		目标组={}
	elseif self.参战单位[目标].队伍==self.参战单位[编号].队伍 then
		目标组={}
	end
	if #目标组>=数量 then--如果数量剩1个就不执行后面操作，直接返回这1个目标。
		return 目标组
	end
	local 临时目标组 = {}
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self.参战单位[n].类型=="角色" and self:取目标状态(编号,n,1) then
			目标组[#目标组 + 1] = n
		end
	end
	return 目标组
end


function 战斗处理类:取多个敌方bb目标(编号,目标,数量)
	local 目标组={目标}--初始赋值，将手动选择的攻击目标添加进目标组数组。

	if self:取目标状态(编号,目标,1)==false then--这里判断，如果手动选择的目标死亡，就删除。
		目标组={}
	elseif self.参战单位[目标].队伍==self.参战单位[编号].队伍 then
		目标组={}
	end
	if #目标组>=数量 then--如果数量剩1个就不执行后面操作，直接返回这1个目标。
		return 目标组
	end
	local 临时目标组 = {}
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self.参战单位[n].类型=="bb" and self:取目标状态(编号,n,1) then
			目标组[#目标组 + 1] = n
		end
	end
	return 目标组
end

function 战斗处理类:取单个敌方目标(编号,类型)
	local 目标组 = {}
	local zhiling
	if self.参战单位[编号].奇袭指令 then
		zhiling = self.参战单位[编号].奇袭指令
	else
		zhiling = self.参战单位[编号].指令
	end

	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
			-- if self.参战单位[编号].指令.参数 == "笑里藏刀" then
			if zhiling.参数 == "笑里藏刀" then
				if self.参战单位[n].类型 == "角色" then
					目标组[#目标组 + 1] = n
				end
			else
				if 类型=="物理" and self.参战单位[n].标记=="物理" then
			        return n
			    elseif 类型=="法术" and self.参战单位[n].标记=="法术" then
			        return n
			    elseif 类型=="封印" and self.参战单位[n].标记=="封印" then
			        return n
			    elseif 类型 and 类型~="封印" and self.参战单位[n].标记=="集火" then
			        return n
			    end
				目标组[#目标组 + 1] = n
			end
		end
	end
	if #目标组 == 0 then
		return 0
	else
		return 目标组[取随机数(1, #目标组)]
	end
end

function 战斗处理类:刷新自动集火目标(参考编号) --自动集火：找一个存活敌方目标标记为"集火"，已有存活集火目标则不重选
	if not self.参战单位[参考编号] then return end
	local 参考队伍 = self.参战单位[参考编号].队伍
	for n = 1, #self.参战单位 do
		if self.参战单位[n].标记=="集火" and self.参战单位[n].队伍~=参考队伍 and self:取目标状态(参考编号,n,1) then
			return
		end
	end
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍~=参考队伍 and self:取目标状态(参考编号,n,1) then
			local 修改 = {}
			for i = 1, #self.参战单位 do
				if self.参战单位[i].标记=="集火" and self.参战单位[i].队伍==self.参战单位[n].队伍 then
					self.参战单位[i].标记 = nil
					修改[#修改+1] = {编号=i,标记=nil}
				end
			end
			self.参战单位[n].标记 = "集火"
			修改[#修改+1] = {编号=n,标记="集火"}
			for i = 1, #self.参战玩家 do
				if not self.参战玩家[i].助战 then
					发送数据(玩家数据[self.参战玩家[i].id].连接id,5520,修改)
				end
			end
			return
		end
	end
end

function 战斗处理类:取如意神通目标(编号,目标)
	local 目标组={}
	for n=1,#self.参战单位 do
		if self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
			目标组[#目标组+1]=n
		end
	end
	if #目标组==0 then
		return 0
	else
		for j=1,#目标组 do
			if 目标组[j]==目标 then
				table.remove(目标组,j)
			end
		end
		if #目标组==0 then return 0 end
		return 目标组[取随机数(1,#目标组)]
	end
end

function 战斗处理类:取单个敌方角色目标(编号)
	local 目标组 = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
			if self.参战单位[n].类型 == "角色" then
				目标组[#目标组 + 1] = n
			end
		end
	end
	if #目标组 == 0 then
		local 目标组2 = {}
		for n = 1, #self.参战单位 do
			if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
				目标组2[#目标组2 + 1] = n
			end
		end
		if #目标组2 == 0 then
			return 0
		else
			return 目标组2[取随机数(1, #目标组2)]
		end
	else
		return 目标组[取随机数(1, #目标组)]
	end
end

function 战斗处理类:取单个敌方召唤兽目标(编号)
	local 目标组 = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
			if self.参战单位[n].类型 ~= "角色" then
				目标组[#目标组 + 1] = n
			end
		end
	end
	if #目标组 == 0 then
		local 目标组2 = {}
		for n = 1, #self.参战单位 do
			if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
				目标组2[#目标组2 + 1] = n
			end
		end
		if #目标组2 == 0 then
			return 0
		else
			return 目标组2[取随机数(1, #目标组2)]
		end
	else
		return 目标组[取随机数(1, #目标组)]
	end
end

function 战斗处理类:取单个友方气血最低(编号)
	local 目标组 = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 2) then
			local 添加 = true
			for i = 1, #目标组 do
				if 目标组[i] == n then 添加 = false end
			end
			if 添加 then
				目标组[#目标组 + 1] = n
			end
		end
	end
	local 排序组 = {}
	for n = 1, #目标组 do
		排序组[n] = {气血 = self.参战单位[目标组[n]].气血 / self.参战单位[目标组[n]].最大气血 * 100, id = 目标组[n]}
	end
	table.sort(排序组, function(a, b) return a.气血 < b.气血 end)
	return 排序组[1].id
end

function 战斗处理类:取单个友方伤害最高(编号)
	local 目标组 = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 2) then
			local 添加 = true
			for i = 1, #目标组 do
				if 目标组[i] == n then 添加 = false end
			end
			if 添加 then
				目标组[#目标组 + 1] = n
			end
		end
	end
	local 排序组 = {}
	for n = 1, #目标组 do
		排序组[n] = {类型 = self.参战单位[目标组[n]].伤害, id = 目标组[n]}
	end
	table.sort(排序组, function(a, b) return a.类型 > b.类型 end)
	return 排序组[1].id
end

function 战斗处理类:取单个敌方气血最低(编号)
	local 目标组 = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
			local 添加 = true
			for i = 1, #目标组 do
				if 目标组[i] == n then 添加 = false end
			end
			if 添加 then
				目标组[#目标组 + 1] = n
			end
		end
	end
	local 排序组 = {}
	for n = 1, #目标组 do
		排序组[n] = {气血 = self.参战单位[目标组[n]].气血 / self.参战单位[目标组[n]].最大气血 * 100, id = 目标组[n]}
	end
	table.sort(排序组, function(a, b) return a.气血 < b.气血 end)
	return (排序组[1] or {}).id or 0
end

function 战斗处理类:取单个友方目标(编号)
	local 目标组 = {}
	for n = 1, #self.参战单位 do
		if n ~= 编号 and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
			目标组[#目标组 + 1] = n
		end
	end
	if #目标组 == 0 then
		return 0
	else
		return 目标组[取随机数(1, #目标组)]
	end
end
function 战斗处理类:取单个友方指定目标(编号, 指定目标名称)
    if self.已判断目标名称[指定目标名称] then
        local 目标组 = {}
        for n = 1, #self.参战单位 do
            if n ~= 编号 and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, n, 1) then
                目标组[#目标组 + 1] = n
            end
        end
        if #目标组 == 0 then
            return 0
        else
            return 目标组[取随机数(1, #目标组)]
        end
    else
        local 目标组 = {}
        local 指定目标编号 = nil
        for n = 1, #self.参战单位 do
            if self.参战单位[n].名称 == 指定目标名称 and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and n ~= 编号 and self:取目标状态(编号, n, 1) then
                指定目标编号 = n
                break
            end
        end
        self.已判断目标名称[指定目标名称] = true
        if 指定目标编号 then
            return 指定目标编号
        else
            if #目标组 == 0 then
                return 0
            else
                return 目标组[取随机数(1, #目标组)]
            end
        end
    end
end
------------佬伍修改（增加种族秘境时空之钥）
function 战斗处理类:取玩家召唤兽(编号)
	if self.参战单位[编号].召唤兽 and self:取目标状态(编号, self.参战单位[编号].召唤兽, 2) then
		return self.参战单位[编号].召唤兽
	end
	return 0
end

function 战斗处理类:取目标类型(编号)
	local fhz = 0
	if self.参战单位[编号] and self.参战单位[编号].类型 == "bb" and self.参战单位[编号].队伍 ~= 0 then
		fhz = "召唤兽"
	elseif self.参战单位[编号] and self.参战单位[编号].类型 == "角色" and self.参战单位[编号].队伍 ~= 0 then
		fhz = "玩家"
	end
	return fhz
end

function 战斗处理类:取目标状态(攻击, 挨打, 类型) --类型 1为可以攻击的敌方单位  2为队友或宝宝  3为可复活的队友
	if 挨打 == nil or self.参战单位[挨打] == nil or self.参战单位[挨打].不可操作 then return false end
	if 类型 == 1 then --这里是可攻击状态
		if self.参战单位[挨打].气血 <= 0 or self.参战单位[挨打].捕捉 or self.参战单位[挨打].逃跑 then
			return false
		elseif self.参战单位[挨打].法术状态 ~= nil and (self.参战单位[挨打].法术状态.楚楚可怜 ~= nil or self.参战单位[挨打].法术状态.修罗隐身 ~= nil ) then
			if self.参战单位[攻击].感知 ~= nil or self.参战单位[攻击].法术状态.幽冥鬼眼 ~= nil or (self.参战单位[攻击].法术状态.牛劲~= nil and self.参战单位[攻击].法术状态.牛劲.充沛 ~= nil) then
				return true
			else
				return false
			end
		elseif self.参战单位[挨打] and self.参战单位[挨打].法术状态 and self.参战单位[挨打].法术状态.乾坤妙法 then--初始技能计算:不可操作状态(self,挨打) then --乾坤妙法
			return false
		end
	elseif 类型 == 2 then -- 最好是全部是2
		if self.参战单位[挨打].气血 <= 0 or self.参战单位[挨打].捕捉 or self.参战单位[挨打].逃跑 or (self.参战单位[挨打].法术状态 and self.参战单位[挨打].法术状态.复活~=nil) then --鬼魂
			return false
		end
	elseif 类型 == 3 then --死亡
		if self.参战单位[挨打].气血 <= 0 then
			return false
		end
	end
	return true
end

function 战斗处理类:取共生目标(编号)
	local 目标组 = {}
	for n = 1, #self.参战单位 do
		if self.参战单位[n] and self.参战单位[n].共生 and self.参战单位[n].共生 == self.参战单位[编号].共生  and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and  self.参战单位[n].气血 >0  then
			目标组[#目标组 + 1] = n
		end
	end
	return 目标组
end

function 战斗处理类:设置命令回合()
	self.回合数 = self.回合数 + 1

	local 发奇袭数据 = {}
	for n = 1, #self.参战玩家 do
		local 编号 = self:取参战编号(self.参战玩家[n].id, "角色")
		--if self.参战单位[编号] and self.参战单位[编号].奇袭法术 then
-- 【修复】死了的单位，不发奇袭身光
		if self.参战单位[编号] and self.参战单位[编号].奇袭法术 and self.参战单位[编号].气血 > 0 then
			发奇袭数据[编号] = true
		end

	end
	for n = 1, #self.参战玩家 do
		if not self.参战玩家[n].助战 then
			for i = 1, #self.战斗发言数据 do
				发送数据(self.参战玩家[n].连接id, 5512, {id = self.战斗发言数据[i].id, 文本 = self.战斗发言数据[i].内容})
			end
			local 编号 = self:取参战编号(self.参战玩家[n].id, "角色")
			local 目标 = {编号}
			if self.单挑模式 then
				-- self.执行等待 = self.执行等待 + 10
				local bbbh = self.参战单位[编号].单挑宝宝统计
				for i=1,#bbbh do
					if self.参战单位[bbbh[i].bbid] and self.参战单位[bbbh[i].bbid].气血 > 0 and not self.参战单位[bbbh[i].bbid].逃跑 then
						目标[#目标+1]=bbbh[i].bbid
					end
				end

				for i = 1, #目标 do
					self.参战单位[目标[i]].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = "", 编号 = 目标[i]}
				end
				if #目标 >1 then --表示有宝宝存在的情况
					if #目标==2 then
						发送数据(self.参战玩家[n].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={self.参战玩家[n].id,self.参战玩家[n].id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令}})
					elseif #目标==3 then
						发送数据(self.参战玩家[n].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={self.参战玩家[n].id,self.参战玩家[n].id,self.参战玩家[n].id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能, zdjn3 = self.参战单位[目标[3]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令,self.参战单位[目标[3]].自动指令}})
					elseif #目标==4 then
						发送数据(self.参战玩家[n].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={self.参战玩家[n].id,self.参战玩家[n].id,self.参战玩家[n].id,self.参战玩家[n].id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能, zdjn3 = self.参战单位[目标[3]].主动技能, zdjn4 = self.参战单位[目标[4]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令,self.参战单位[目标[3]].自动指令,self.参战单位[目标[4]].自动指令}})
					elseif #目标==5 then
						发送数据(self.参战玩家[n].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={self.参战玩家[n].id,self.参战玩家[n].id,self.参战玩家[n].id,self.参战玩家[n].id,self.参战玩家[n].id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能, zdjn3 = self.参战单位[目标[3]].主动技能, zdjn4 = self.参战单位[目标[4]].主动技能, zdjn5 = self.参战单位[目标[5]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令,self.参战单位[目标[3]].自动指令,self.参战单位[目标[4]].自动指令,self.参战单位[目标[5]].自动指令}})
					end
				else
					发送数据(self.参战玩家[n].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={self.参战玩家[n].id}, zdjn1 = self.参战单位[编号].主动技能,zdzl={self.参战单位[编号].自动指令}})

				end
			else
				if self.参战单位[编号].召唤兽 ~= nil and self.参战单位[self.参战单位[编号].召唤兽].气血 > 0 and not self.参战单位[self.参战单位[编号].召唤兽].逃跑 then
					目标[2] = self.参战单位[编号].召唤兽
				end
				if self.参战单位[目标[2]]~=nil and self.参战单位[目标[2]].超级敏捷~=nil and self.参战单位[目标[2]].超级敏捷.概率 ~= 0 and 取随机数(1,100) <= self.参战单位[目标[2]].超级敏捷.概率+0 then --超级敏捷概率，初始5
					self.参战单位[目标[2]].超级敏捷.触发=1
				end
				if self.参战单位[编号].助战表 then
					for i=1,#self.参战单位[编号].助战表 do
						目标[#目标+1] = self.参战单位[编号].助战表[i]
						if self.参战单位[self.参战单位[编号].助战表[i]].召唤兽~=nil then
							目标[#目标+1]=self.参战单位[self.参战单位[编号].助战表[i]].召唤兽
							if self.参战单位[目标[#目标]]~=nil and self.参战单位[目标[#目标]].超级敏捷~=nil and self.参战单位[目标[#目标]].超级敏捷.概率 ~= 0 and 取随机数(1,100) <= self.参战单位[目标[#目标]].超级敏捷.概率+0 then --超级敏捷概率，初始5
								self.参战单位[目标[#目标]].超级敏捷.触发=1
							end

						end
					end
				end
				local 发送信息 = {助战数量 = #self.参战玩家 - self.助战数量,mb = 目标,id={},zdzl={},zccz={},qixi=发奇袭数据}

				for i = 1, #目标 do
					self.参战单位[目标[i]].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = "", 编号 = 目标[i]}
					发送信息["zdjn"..i] = self.参战单位[目标[i]].主动技能
					-- if  self.参战单位[目标[i]].自动指令.参数 and type(self.参战单位[目标[i]].自动指令.参数)=="table" then
					-- self.参战单位[目标[i]].自动指令.参数=self.参战单位[目标[i]].自动指令.参数[1][1]
				 --    end
				   if self.参战单位[目标[i]].门派=="九黎城" then
                        			self.参战单位[目标[i]].指令.类型 = "法术"
				   end
					发送信息.zdzl[i] = self.参战单位[目标[i]].自动指令
					发送信息.id[i] =self.参战单位[目标[i]].玩家id
					if self.参战单位[目标[i]].超级敏捷 and self.参战单位[目标[i]].超级敏捷.触发 == 1 then
						发送信息.zccz[i] = self.参战单位[目标[i]].超级敏捷.触发
						self.参战单位[目标[i]].超级敏捷.触发 = 0
					end
					发送信息.回合数 = self.回合数
				end
				发送数据(self.参战玩家[n].连接id, 5503,发送信息)
			end
		end
	end

	self.战斗发言数据 = {}

	--清空一次怪物单位
	for n = 1, #self.参战单位 do
		if self.参战单位[n].队伍 == 0 then
			self.参战单位[n].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}
		else
			if self.参战单位[n].指令 ~= nil then
				self.参战单位[n].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = "", 编号 = self.参战单位[n].指令.编号}
			else
				self.参战单位[n].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = "", 编号 = n}
			end
		end
	end
	self.加载数量 = #self.参战玩家
	self.等待起始 = os.time()
	self.回合进程 = "命令回合"
end

function 战斗处理类:取参战编号(id, 类型)
	for n = 1, #self.参战单位 do
		if self.参战单位[n].类型 == 类型 and self.参战单位[n].玩家id == id then
			return n
		end
	end
end

function 战斗处理类:取野外等级差(地图等级, 玩家等级)
	local 等级 = math.abs(地图等级 - 玩家等级)
	if 等级 <= 5 then
		return 1
	elseif 等级 <= 10 then
		return 0.8
	elseif 等级 <= 20 then
		return 0.5
	else
		return 0.2
	end
end

function 战斗处理类:逃跑限制(sj,单位)
	local fhz = 0
	local 状态 = {"缚妖索","捆仙绳","缚龙索"}
	for i=1,#状态 do
		if sj[状态[i]] ~= nil then
			fhz = sj[状态[i]].几率
		end
	end
	return fhz
end

function 战斗处理类:逃跑计算(编号, 附加几率)
	local 成功 = false
	local 几率 = 50 - self:逃跑限制(self.参战单位[编号].法术状态,self.参战单位[编号])
	local 说话 = nil
	if 附加几率 ~= nil then 几率 = 几率 + 附加几率 end
	if self.战斗类型 == 110000 then --野猪
		说话 = "没工夫陪你玩，我先闪了！"
	end
	if self.战斗类型 == 155599 then --副本 天火--花妖
		说话 = "多谢少侠解救，小女子先走了#98！"
	end
	if self.战斗类型 == 155600 then --副本 天火--风伯
		说话 = "这里太可怕了，少侠我先溜了#111！"
	end
	if self.参战单位[编号].队伍 == 0 then 几率 = 100 end
	if self.参战单位[编号]. 义薄云天 then
		几率 = 0
	end
	if self:取技能重复(self.参战单位[编号], "桀骜自恃") then
		几率 = 0
	end
	if 取随机数() <= 几率 then
		成功 = true
	end
	self.执行等待 = self.执行等待 + 10
	local 结束 = false
	if 成功 and self.参战单位[编号].类型 == "角色" then
		结束 = true
		if #self.参战玩家 == 1 then self.全局结束 = true end --不再执行动作
	end
	if 成功 then
		-- self.参战单位[编号].气血=0
		self.参战单位[编号].逃跑 = true
	end
	if self.参战单位[编号].队伍 == 0 then
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 601, 攻击方 = 编号, id = 0, 挨打方 = {{挨打方 = 1}}, 成功 = 成功, 结束 = 结束, 喊话 = 说话}
		if self.参战单位[编号].特殊变异 then
			任务数据[self.任务id].变异奖励 = true
		end
		return
	else
		self.战斗流程[#self.战斗流程 + 1] = {流程 = 601, 攻击方 = 编号, id = self.参战单位[编号].玩家id, 挨打方 = {{挨打方 = 1}}, 成功 = 成功, 结束 = 结束, 喊话 = 说话}
	end
	-- if cond then
	--  --do
	-- end
	--计算召唤兽
	if 成功 then
		local id = self.参战单位[编号].玩家id
		local 临时编号 = 0
		if self.参战单位[编号].类型 ~= "角色" then
			for n = 1, #玩家数据[id].召唤兽.数据 do
				if 玩家数据[id].召唤兽.数据[n].认证码 == 玩家数据[id].角色.参战宝宝.认证码 then
					玩家数据[id].召唤兽.数据[n].参战信息 = nil
					临时编号 = n
				end
			end
			玩家数据[id].角色.参战宝宝 = {}
			玩家数据[id].角色.参战信息 = nil
			发送数据(玩家数据[id].连接id, 18, 玩家数据[id].角色.参战宝宝)
		else
			if self.参战单位[编号].召唤兽 ~= nil and self.参战单位[self.参战单位[编号].召唤兽] ~= nil then
				self.战斗流程[#self.战斗流程].追加 = self.参战单位[编号].召唤兽
				self.参战单位[self.参战单位[编号].召唤兽].逃跑 = true
			end
		end
	end
end

function 战斗处理类:法术逃跑(编号, 附加几率,技能)
	local 成功 = false
	local 几率 = 50 - self:逃跑限制(self.参战单位[编号].法术状态)
	if 附加几率 ~= nil then 几率 = 几率 + 附加几率 end
	if 取随机数() <= 几率 then
		成功 = true
	end
	self.执行等待 = self.执行等待 + 10
	local 结束 = false
	if 成功 then
		结束 = true
		if #self.参战玩家 == 1 then self.全局结束 = true end --不再执行动作
		self.参战单位[编号].逃跑 = true
	end

	self.战斗流程[#self.战斗流程 + 1] = {流程 = 601.1, 攻击方 = 编号, id = self.参战单位[编号].玩家id, 挨打方 = {{挨打方 = 1}}, 特效 = 技能, 成功 = 成功, 结束 = 结束}
	if 成功 then
		local id = self.参战单位[编号].玩家id
		local 临时编号 = 0
		if self.参战单位[编号].类型 ~= "角色" then
			for n = 1, #玩家数据[id].召唤兽.数据 do
				if 玩家数据[id].召唤兽.数据[n].认证码 == 玩家数据[id].角色.参战宝宝.认证码 then
					玩家数据[id].召唤兽.数据[n].参战信息 = nil
					-- 临时编号 = n
				end
			end
			玩家数据[id].角色.参战宝宝 = {}
			玩家数据[id].角色.参战信息 = nil
			发送数据(玩家数据[id].连接id, 18, 玩家数据[id].角色.参战宝宝)
			--测试模式 ，要写随机传送安全区地图  水遁回龙宫
		else
			if self.参战单位[编号].召唤兽 ~= nil and self.参战单位[self.参战单位[编号].召唤兽] ~= nil then
				self.战斗流程[#self.战斗流程].追加 = self.参战单位[编号].召唤兽
				self.参战单位[self.参战单位[编号].召唤兽].逃跑 = true
			end
		end
	end

end


function 战斗处理类:逃跑事件处理(id)
	local 编号 = 0
	local 剩余队员 = 0
	local 逃跑方队伍 = 0
	local 对方队伍 = 0
	for n = 1, #self.参战玩家 do
		if self.参战玩家[n].id == id then
			编号 = n
			逃跑方队伍 = self.参战玩家[n].队伍
		end
	end
	for n = 1, #self.参战玩家 do
		if self.参战玩家[n].队伍 == 逃跑方队伍 then
			if self.参战玩家[n].id ~= self.参战玩家[编号].id and  not self.参战玩家[n].助战 then
				剩余队员 = 剩余队员 + 1
			end
		else
			if 对方队伍 == 0 then
				对方队伍 = self.参战玩家[n].队伍
			end
		end
	end
	if 剩余队员 == 0 then --只有一个玩家时直接结束战斗
		self.回合进程 = "结束回合"
		self:还原指定单位属性(id)
		self:结束战斗(对方队伍, 逃跑方队伍, 1)
		self:发送战斗结束数据()
		--self.参战玩家={}
		--self.结束条件=true
		玩家数据[id].角色.战斗开关 = false
		队伍处理类:退出队伍(id)
		地图处理类:设置战斗开关(id, false)
		发送数据(玩家数据[id].连接id, 20.1, {气血=玩家数据[id].角色.参战宝宝.最大气血,魔法=玩家数据[id].角色.参战宝宝.最大魔法}) --
		return
	else
		table.remove(self.参战玩家, 编号)
		self:还原指定单位属性(id)
		发送数据(玩家数据[id].连接id, 5505)
		玩家数据[id].遇怪时间=os.time()+取随机数(10,20)
		玩家数据[id].zhandou = 0
		玩家数据[id].角色.战斗开关 = false
		队伍处理类:退出队伍(id)
		地图处理类:设置战斗开关(id, false)
		--下面我加的

		发送数据(玩家数据[id].连接id,31,玩家数据[id].角色:取总数据1())
		发送数据(玩家数据[id].连接id, 20.1, {气血=玩家数据[id].角色.参战宝宝.最大气血,魔法=玩家数据[id].角色.参战宝宝.最大魔法}) --
		玩家数据[id].道具:重置法宝回合(id)
	end
end


function 战斗处理类:结束战斗(胜利id,失败id,逃跑) --系统为不计算失败惩罚
--  self:还原单位属性()

	if not self.PK战斗 then
		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self)
		elseif 失败id ~= 0 then--and self.武神坛模式 == false then
			战斗失败:失败处理(失败id, 逃跑,self)
		elseif 逃跑 == 1 then --逃跑
			for n=1,#self.参战玩家 do
				if self.参战玩家[n].队伍==self.队伍区分[1] and 玩家数据[self.参战玩家[n].id]~=nil then
					local 编号=self:取参战编号(self.参战玩家[n].id,"角色")
					self:还原单位属性(编号)
				end
			end
			for n=1,#self.参战玩家 do
				if self.参战玩家[n].队伍==self.队伍区分[2] and 玩家数据[self.参战玩家[n].id]~=nil then
					local 编号=self:取参战编号(self.参战玩家[n].id,"角色")
					self:还原单位属性(编号)
				end
			end
			self:发送战斗结束数据()
		end

	elseif self.战斗类型 == 200003 then --比武大会
		-- if 胜利id ~= 0 then
		-- 	-- VictoryMOB200003(胜利id, 失败id,"PK",失败id)
		-- end
		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self, "PK",失败id)
		-- elseif 失败id ~= 0 then--and self.武神坛模式 == false then
		-- 	战斗失败:失败处理(失败id, 系统,self)
		end

	elseif self.战斗类型 == 200007 then
		if 胜利id ~= 0 and 失败id ~= 0  then
			战斗胜利:胜利处理(胜利id, self,"PK",失败id)
		end



	elseif self.战斗类型 == 200001 then --PK台
		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK",失败id)
		end
	elseif self.战斗类型 == 200004 then --剑会
		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK",失败id)
		end

	 elseif self.战斗类型==154000 then --雁塔
		if 胜利id ~= 0 then
			--获取失败id={[1]=0}
			战斗胜利:胜利处理(胜利id, self,"PK",0)
		end
	elseif self.战斗类型 == 154001 then --剑会
		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK",失败id)
		end

	elseif self.战斗类型 == 200005 then --200005 勾魂索

		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK")
		end
		if 失败id ~= 0 then
			战斗失败:失败处理(失败id, 逃跑,self)
		end
	elseif self.战斗类型 == 200006 then --生死
		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK")
		end
		if 失败id ~= 0 then
			战斗失败:失败处理(失败id, 逃跑,self)
		end
	elseif self.战斗类型 == 200002 then --帮战
		if 胜利id ~= 0 and 失败id ~= 0 then
			战斗胜利:胜利处理(胜利id,self,"PK",失败id)
		end
	elseif self.战斗类型==410001 then
  		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK",失败id)
		end
  	elseif self.战斗类型==410003 then
  		if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK",失败id)
		end
	elseif self.战斗类型==410005 then
      	if 胜利id ~= 0 then
			战斗胜利:胜利处理(胜利id, self,"PK",失败id)
		end
	end

	for n = 1, #self.观战玩家 do

		if self.观战玩家[n] and self.观战玩家[n].id and  玩家数据[self.观战玩家[n].id] ~= nil then
			发送数据(self.观战玩家[n].连接id, 5505)
			玩家数据[self.观战玩家[n].id].zhandou = 0
			玩家数据[self.观战玩家[n].id].guanzhan = 0
			玩家数据[self.观战玩家[n].id].角色.战斗开关 = false
			地图处理类:设置战斗开关(self.观战玩家[n].id, false)
			观战记录 = nil

		end
	end
	-- self:发送战斗结束数据()----C改
	-- return true

	-- self:发送战斗结束数据()
end



function 战斗处理类:强制结束战斗()
	if self.PK战斗 or (self.战斗类型 >= 190204 and self.战斗类型 <= 190208) and self.战斗类型~=154000   then
		常规提示(self.参战单位[1].玩家id,"此战斗无法退出")
		return false
	end
	if self.任务id and 任务数据[self.任务id] then
		任务数据[self.任务id].zhandou=nil
	end
    -- =========================================
    -- 新增强制结束=关闭挂机
        辅助内挂类:关闭所有挂机(self.参战单位[1].玩家id)
        发送数据(玩家数据[self.参战单位[1].玩家id].连接id, 551, {变更=false})
        --常规提示(self.参战单位[1].玩家id, "#Y强制结束战斗，已停止自动挂机")
    -- =========================================
	for n = 1, #self.观战玩家 do
		if self.观战玩家[n] and self.观战玩家[n].id and  玩家数据[self.观战玩家[n].id] ~= nil then
			发送数据(self.观战玩家[n].连接id, 5505)
			玩家数据[self.观战玩家[n].id].zhandou = 0
			玩家数据[self.观战玩家[n].id].guanzhan = 0
			玩家数据[self.观战玩家[n].id].角色.战斗开关 = false
			地图处理类:设置战斗开关(self.观战玩家[n].id, false)
		end
	end
	self:发送战斗结束数据()
	return true
end

function 战斗处理类:比武强制结束战斗()
	if self.任务id and 任务数据[self.任务id] then
		任务数据[self.任务id].zhandou=nil
	end
	for n = 1, #self.观战玩家 do
		if self.观战玩家[n] and self.观战玩家[n].id and  玩家数据[self.观战玩家[n].id] ~= nil then
			发送数据(self.观战玩家[n].连接id, 5505)
			玩家数据[self.观战玩家[n].id].zhandou = 0
			玩家数据[self.观战玩家[n].id].guanzhan = 0
			玩家数据[self.观战玩家[n].id].角色.战斗开关 = false
			地图处理类:设置战斗开关(self.观战玩家[n].id, false)
		end
	end
	self:发送战斗结束数据()
	return true
end

function 战斗处理类:气血恢复()
	for n = 1, #self.参战单位 do
		if self.参战单位[n].气血 < 0 then self.参战单位[n].气血 = 0 end
		if self.参战单位[n].魔法 < 0 then self.参战单位[n].魔法 = 0 end
		if self.参战单位[n] ~= nil and 玩家数据[self.参战单位[n].玩家id] ~= nil then
			if self.参战单位[n].类型 == "角色" then
				if 玩家数据[self.参战单位[n].玩家id].角色:取任务(10) ~= 0 then
					local 恢复id = 玩家数据[self.参战单位[n].玩家id].角色:取任务(10)
					if 玩家数据[self.参战单位[n].玩家id].角色.气血 < 玩家数据[self.参战单位[n].玩家id].角色.最大气血 then
						if 任务数据[恢复id].气血 > 0 then
							if 任务数据[恢复id].气血 > 玩家数据[self.参战单位[n].玩家id].角色.最大气血 - 玩家数据[self.参战单位[n].玩家id].角色.气血 then
								任务数据[恢复id].气血 = 任务数据[恢复id].气血 - (玩家数据[self.参战单位[n].玩家id].角色.最大气血 - 玩家数据[self.参战单位[n].玩家id].角色.气血)
								玩家数据[self.参战单位[n].玩家id].角色.气血 = 玩家数据[self.参战单位[n].玩家id].角色.最大气血
							else
								玩家数据[self.参战单位[n].玩家id].角色.气血 = 玩家数据[self.参战单位[n].玩家id].角色.气血 + 任务数据[恢复id].气血
								任务数据[恢复id].气血 = 0
							end
							if 任务数据[恢复id].气血 == 0 and 任务数据[恢复id].魔法 == 0 then
								玩家数据[self.参战单位[n].玩家id].角色:取消任务(恢复id)
							end
							玩家数据[self.参战单位[n].玩家id].角色:刷新任务跟踪()
						end
					end
					if 玩家数据[self.参战单位[n].玩家id].角色.魔法 < 玩家数据[self.参战单位[n].玩家id].角色.最大魔法 then
						if 任务数据[恢复id].魔法 > 0 then
							if 任务数据[恢复id].魔法 > 玩家数据[self.参战单位[n].玩家id].角色.最大魔法 - 玩家数据[self.参战单位[n].玩家id].角色.魔法 then
								任务数据[恢复id].魔法 = 任务数据[恢复id].魔法 - (玩家数据[self.参战单位[n].玩家id].角色.最大魔法 - 玩家数据[self.参战单位[n].玩家id].角色.魔法)
								玩家数据[self.参战单位[n].玩家id].角色.魔法 = 玩家数据[self.参战单位[n].玩家id].角色.最大魔法
							else
								玩家数据[self.参战单位[n].玩家id].角色.魔法 = 玩家数据[self.参战单位[n].玩家id].角色.魔法 + 任务数据[恢复id].魔法
								任务数据[恢复id].魔法 = 0
							end
							if 任务数据[恢复id].气血 == 0 and 任务数据[恢复id].魔法 == 0 then
								玩家数据[self.参战单位[n].玩家id].角色:取消任务(恢复id)
							end
							玩家数据[self.参战单位[n].玩家id].角色:刷新任务跟踪()
						end
					end
				end
				发送数据(玩家数据[self.参战单位[n].玩家id].连接id, 33, 玩家数据[self.参战单位[n].玩家id].角色:取总数据1())
				-- else
				--   if self.参战单位[n].气血<=0 then
				--     玩家数据[self.参战单位[n].玩家id].召唤兽:死亡处理(self.参战单位[n].认证码)
				--     玩家数据[self.参战单位[n].玩家id].召唤兽:刷新信息(self.参战单位[n].认证码,"1")
				--   else
				--     玩家数据[self.参战单位[n].玩家id].召唤兽:刷新信息(self.参战单位[n].认证码)
				--     玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.气血= self.参战单位[n].气血
				--     玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.魔法= self.参战单位[n].魔法
				--   end
			end
		end
	end
end

function 战斗处理类:死亡对话(id)
	if 玩家数据[id].角色.等级 < 10 then
		return
	end
	玩家数据[id].zhandou = 0
	-- if 玩家数据[id].队伍 ~= 0 and not 玩家数据[id].助战 then
	-- 	队伍处理类:退出队伍(id)
	-- end
	local wb = {}
	wb[1] = "生死有命,请珍惜生命？"
	local xx = {}
	self.临时数据 = {"白无常", "白无常", wb[取随机数(1, #wb)], xx}
	self.发送数据 = {}
	self.发送数据.模型 = self.临时数据[1]
	self.发送数据.名称 = self.临时数据[2]
	self.发送数据.对话 = self.临时数据[3]
	self.发送数据.选项 = self.临时数据[4]
	发送数据(玩家数据[id].连接id, 1501, self.发送数据)
	地图处理类:跳转地图(id,1125, 24, 27) --测试模式
end
function 战斗处理类:扣除死亡损失(失败id, 经验倍率, 银子倍率)
    if not 失败id or not 玩家数据[失败id] then
        print("错误：无效的玩家ID或玩家不存在")
        return 0, 0
    end
    local 玩家 = 玩家数据[失败id]
    经验倍率 = 经验倍率 or 0.08
    银子倍率 = 银子倍率 or 0.08

    local 扣除经验 = 0
    local 扣除银子 = 0
    local 提示内容 = {}

    -- 扣除经验部分
    if 玩家.角色.当前经验 and 玩家.角色.当前经验 > 0 then
        扣除经验 = math.floor(玩家.角色.当前经验 * 经验倍率)
        if 玩家.角色.当前经验 >= 扣除经验 and 扣除经验 > 0 then
            玩家.角色.当前经验 = 玩家.角色.当前经验 - 扣除经验
            table.insert(提示内容, "#Y/你因为死亡损失了" .. 扣除经验 .. "点经验")
        end
    end

    -- 扣除银子部分
    if 玩家.角色.银子 and 玩家.角色.银子 > 0 then
        扣除银子 = math.floor(玩家.角色.银子 * 银子倍率)
        if 玩家.角色.银子 >= 扣除银子 and 扣除银子 > 0 then
            local 之前银子 = 玩家.角色.银子
            玩家.角色.银子 = 玩家.角色.银子 - 扣除银子
            玩家.角色:日志记录("死亡扣除", "扣除银子", 扣除银子, 玩家.角色.银子)
            table.insert(提示内容, "#Y/你因为死亡损失了" .. 扣除银子 .. "两银子")
        end
    end
	for _, 内容 in ipairs(提示内容) do
	        发送数据(玩家数据[失败id].连接id, 38, {内容 = 内容, 频道 = "xt"})
	end
	if #提示内容 > 0 then
	        if #提示内容 == 2 then
	            local 合并内容 = 提示内容[1] .. "\n" .. 提示内容[2]
	            闪烁消息(失败id, 合并内容)
	        else
	            闪烁消息(失败id, 提示内容[1])
	        end
	end
    return 扣除经验, 扣除银子
end

-- 保留原有函数用于兼容性（如果需要）
function 战斗处理类:扣除经验(失败id, 倍率)
    local 经验倍率 = 倍率 or 0.08
    local 扣除经验, _ = self:扣除死亡损失(失败id, 经验倍率, 0)
    return 扣除经验
end

function 战斗处理类:扣除银子(失败id, 倍率)
    local 银子倍率 = 倍率 or 0.08
    local _, 扣除银子 = self:扣除死亡损失(失败id, 0, 银子倍率)
    return 扣除银子
end
-- function 战斗处理类:扣除经验(失败id, 倍率)
-- 	local 扣除经验 = 0
-- 	if 倍率 ~= nil then
-- 		扣除经验 = math.floor(玩家数据[失败id].角色.当前经验 * 倍率)
-- 	else
-- 		扣除经验 = math.floor(玩家数据[失败id].角色.当前经验 * 0.08)
-- 	end
-- 	if 玩家数据[失败id].角色.当前经验 >= 扣除经验 then
-- 		玩家数据[失败id].角色.当前经验 = 玩家数据[失败id].角色.当前经验 - 扣除经验
-- 		发送数据(玩家数据[失败id].连接id, 38, {内容 = "#Y/你因为死亡损失了" .. 扣除经验 .. "点经验", 频道 = "xt"})
-- 		闪烁消息(失败id, "#Y/你因为死亡损失了" .. 扣除经验 .. "点经验")
-- 	end
-- end

-- function 战斗处理类:扣除银子(失败id, 倍率)
-- 	local 扣除银子 = 0
-- 	if 倍率 ~= nil then
-- 		扣除银子 = math.floor(玩家数据[失败id].角色.银子 * 倍率)
-- 	else
-- 		扣除银子 = math.floor(玩家数据[失败id].角色.银子 * 0.08)
-- 	end
-- 	if 玩家数据[失败id].角色.银子 >= 扣除银子 then
-- 		local 之前银子 = 玩家数据[失败id].角色.银子
-- 		玩家数据[失败id].角色.银子 = 玩家数据[失败id].角色.银子 - 扣除银子
-- 		玩家数据[失败id].角色:日志记录("死亡扣除", "扣除银子", 扣除银子, 玩家数据[失败id].角色.银子)
-- 		发送数据(玩家数据[失败id].连接id, 38, {内容 = "#Y/你因为死亡损失了" .. 扣除银子 .. "两银子", 频道 = "xt"})
-- 		闪烁消息(失败id, "#Y/你因为死亡损失了" .. 扣除银子 .. "两银子")
-- 	end
-- end

function 战斗处理类:还原指定召唤兽属性(id)
	for n = 1, #self.参战单位 do
		if self.参战单位[n].气血 < 0 then self.参战单位[n].气血 = 0 end
		if self.参战单位[n].魔法 < 0 then self.参战单位[n].魔法 = 0 end
		if self.参战单位[n].队伍 ~= 0 and self.参战单位[n].玩家id == id then
			if self.参战单位[n].类型 ~= "角色" then
				if self.参战单位[n].气血 <= 0 then
					玩家数据[self.参战单位[n].玩家id].召唤兽:死亡处理(self.参战单位[n].认证码)
					玩家数据[self.参战单位[n].玩家id].召唤兽:刷新信息(self.参战单位[n].认证码, "1")
				else
					玩家数据[self.参战单位[n].玩家id].召唤兽:刷新信息(self.参战单位[n].认证码)
					玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.气血 = self.参战单位[n].气血
					玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.魔法 = self.参战单位[n].魔法
					-- if 玩家数据[self.参战单位[n].玩家id].角色.参战宝宝 then
					--     if self.参战单位[n].气血<玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.最大气血 then
					--          玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.气血 = self.参战单位[n].气血
					--      end
					--  if self.参战单位[n].魔法< 玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.最大魔法 then
					--          玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.魔法 = self.参战单位[n].魔法
					--      end
					-- end

				end
			end
		end
	end
end

function 战斗处理类:还原指定单位属性(id)
	for n = 1, #self.参战单位 do
		if self.参战单位[n].气血 < 0 then self.参战单位[n].气血 = 0 end
		if self.参战单位[n].魔法 < 0 then self.参战单位[n].魔法 = 0 end
		if self.参战单位[n].队伍 ~= 0 and self.参战单位[n].玩家id == id then
			if self.参战单位[n].类型 == "角色" then
				if self.参战单位[n].气血 <= 0 then
					玩家数据[self.参战单位[n].玩家id].角色:死亡处理(self.PK战斗)
					玩家数据[self.参战单位[n].玩家id].角色:刷新信息("1")
				else
					玩家数据[self.参战单位[n].玩家id].角色:刷新信息()
					if self.参战单位[n].气血<玩家数据[self.参战单位[n].玩家id].角色.最大气血 then
						玩家数据[self.参战单位[n].玩家id].角色.气血 = self.参战单位[n].气血
					end
					if self.参战单位[n].气血上限< 玩家数据[self.参战单位[n].玩家id].角色.最大气血 then
						玩家数据[self.参战单位[n].玩家id].角色.气血上限 = self.参战单位[n].气血上限
					end
					if self.参战单位[n].魔法< 玩家数据[self.参战单位[n].玩家id].角色.最大魔法 then
						玩家数据[self.参战单位[n].玩家id].角色.魔法 = self.参战单位[n].魔法
					end
					玩家数据[self.参战单位[n].玩家id].角色.愤怒 = self.参战单位[n].愤怒
				end
				发送数据(玩家数据[self.参战单位[n].玩家id].连接id, 33, 玩家数据[self.参战单位[n].玩家id].角色:取总数据1())
			else
				if self.参战单位[n].气血 <= 0 then
					玩家数据[self.参战单位[n].玩家id].召唤兽:死亡处理(self.参战单位[n].认证码)
					玩家数据[self.参战单位[n].玩家id].召唤兽:刷新信息(self.参战单位[n].认证码, "1")
				else
					玩家数据[self.参战单位[n].玩家id].召唤兽:刷新信息(self.参战单位[n].认证码)
					玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.气血 = self.参战单位[n].气血
					玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.魔法 = self.参战单位[n].魔法
					-- if 玩家数据[self.参战单位[n].玩家id].角色.参战宝宝 then
					--     if self.参战单位[n].气血<玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.最大气血 then --测试模式。这里没检测到参战宝宝
					--          玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.气血 = self.参战单位[n].气血
					--      end
					--  if self.参战单位[n].魔法< 玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.最大魔法 then
					--          玩家数据[self.参战单位[n].玩家id].角色.参战宝宝.魔法 = self.参战单位[n].魔法
					--      end
					-- end

				end
			end
		end
	end
end

-- function 战斗处理类:还原单位属性(id)
-- 	if self.参战单位[id] ~= nil and self.参战单位[id].队伍 ~= 0 and self.参战单位[id].逃跑 == nil and self.参战单位[id].系统队友 == nil and 玩家数据[self.参战单位[id].玩家id] ~= nil then
-- 		--线程:发送(1, id, self.进入战斗玩家id, self.参战单位[id].玩家id,self.PK战斗)
-- 		local 参战id = id
-- 		local 战斗id = self.进入战斗玩家id
-- 		local 玩家id = self.参战单位[id].玩家id
-- 		local PK战斗 = self.PK战斗
-- 		local 参战单位 =  self.参战单位[id]
-- 		if 参战单位.气血<0 then 参战单位.气血=0 end
-- 		if 参战单位.魔法<0 then 参战单位.魔法=0 end

-- 		if 参战单位.类型=="角色" and 玩家数据[玩家id]~=nil then
-- 			if 参战单位.气血<=0 then
-- 				玩家数据[玩家id].角色:死亡处理(PK战斗)
-- 			else
-- 				玩家数据[玩家id].角色.愤怒= 参战单位.愤怒
-- 				玩家数据[玩家id].角色:刷新信息()
-- 				if 参战单位.气血<玩家数据[玩家id].角色.最大气血 then
-- 					玩家数据[玩家id].角色.气血= 参战单位.气血
-- 				end
-- 				if 参战单位.气血上限< 玩家数据[玩家id].角色.最大气血 then
-- 					玩家数据[玩家id].角色.气血上限= 参战单位.气血上限
-- 				end
-- 				if 参战单位.魔法< 玩家数据[玩家id].角色.最大魔法 then
-- 					玩家数据[玩家id].角色.魔法= 参战单位.魔法
-- 				end
-- 			end
-- 			local 恢复id=玩家数据[玩家id].角色:取任务(10)
-- 			if 恢复id~=0 then
-- 				if 玩家数据[玩家id].角色.气血<玩家数据[玩家id].角色.最大气血 then
-- 					if 任务数据[恢复id].气血>0 then
-- 						 if 任务数据[恢复id].气血>玩家数据[玩家id].角色.气血上限-玩家数据[玩家id].角色.气血 then
-- 							任务数据[恢复id].气血=任务数据[恢复id].气血-(玩家数据[玩家id].角色.气血上限-玩家数据[玩家id].角色.气血)
-- 							玩家数据[玩家id].角色.气血=玩家数据[玩家id].角色.最大气血
-- 							玩家数据[玩家id].角色.气血上限=玩家数据[玩家id].角色.最大气血
-- 						else
-- 							玩家数据[玩家id].角色.气血=玩家数据[玩家id].角色.气血+任务数据[恢复id].气血
-- 							玩家数据[玩家id].角色.气血上限=玩家数据[玩家id].角色.最大气血
-- 							任务数据[恢复id].气血=0
-- 						end
-- 						if 任务数据[恢复id].气血==0 and 任务数据[恢复id].魔法==0 then
-- 							玩家数据[玩家id].角色:取消任务(恢复id)
-- 						end
-- 					end
-- 				end
-- 				if 玩家数据[玩家id].角色.魔法<玩家数据[玩家id].角色.最大魔法 then
-- 					if 任务数据[恢复id].魔法>0 then
-- 						if 任务数据[恢复id].魔法>玩家数据[玩家id].角色.最大魔法-玩家数据[玩家id].角色.魔法 then
-- 							任务数据[恢复id].魔法=任务数据[恢复id].魔法-(玩家数据[玩家id].角色.最大魔法-玩家数据[玩家id].角色.魔法)
-- 							玩家数据[玩家id].角色.魔法=玩家数据[玩家id].角色.最大魔法
-- 						else
-- 							玩家数据[玩家id].角色.魔法=玩家数据[玩家id].角色.魔法+任务数据[恢复id].魔法
-- 							任务数据[恢复id].魔法=0
-- 						end
-- 						if 任务数据[恢复id].气血==0 and 任务数据[恢复id].魔法==0 then
-- 							玩家数据[玩家id].角色:取消任务(恢复id)
-- 						end
-- 					end
-- 				end
-- 				玩家数据[玩家id].角色:刷新任务跟踪()
-- 			end
-- 		else
-- 			if 玩家数据[玩家id]~=nil then
-- 				if 参战单位.气血<=0 then
-- 					玩家数据[玩家id].召唤兽:死亡处理(参战单位.认证码)
-- 					玩家数据[玩家id].召唤兽:刷新信息(参战单位.认证码,"1")
-- 				else
-- 					local 恢复id=玩家数据[玩家id].角色:取任务(10)
-- 					local 编号=玩家数据[玩家id].角色:取参战宝宝编号()
-- 					if 编号~=0 then
-- 						if 恢复id~=0 then
-- 							玩家数据[玩家id].召唤兽.数据[编号].气血=玩家数据[玩家id].召唤兽.数据[编号].最大气血
-- 							玩家数据[玩家id].召唤兽.数据[编号].魔法=玩家数据[玩家id].召唤兽.数据[编号].最大魔法
-- 						else
-- 							玩家数据[玩家id].召唤兽.数据[编号].气血=qz(参战单位.气血)
-- 							玩家数据[玩家id].召唤兽.数据[编号].魔法=qz(参战单位.魔法)
-- 						end
-- 					end
-- 					玩家数据[玩家id].召唤兽:刷新信息(参战单位.认证码)
-- 				end
-- 			end
-- 		end
-- 	end
-- end
function 战斗处理类:还原单位属性(id)----C改红罗羹
	if self.参战单位[id] ~= nil and self.参战单位[id].队伍 ~= 0 and self.参战单位[id].逃跑 == nil and self.参战单位[id].系统队友 == nil and 玩家数据[self.参战单位[id].玩家id] ~= nil then
		-- 保留原有基础变量定义
		local 参战id = id
		local 战斗id = self.进入战斗玩家id
		local 玩家id = self.参战单位[id].玩家id
		local PK战斗 = self.PK战斗
		local 参战单位 =  self.参战单位[id]
		if 参战单位.气血<0 then 参战单位.气血=0 end
		if 参战单位.魔法<0 then 参战单位.魔法=0 end

		-- 1. 获取当前单位所在队伍的队长（修复单人情况下的逻辑）
		local 队长玩家数据 = nil
		local 当前玩家 = 玩家数据[玩家id]
		local 当前队伍ID = 当前玩家.队伍  -- 非0表示有队伍

		if 当前队伍ID ~= 0 then
			-- 遍历玩家数据找同队伍的队长
			for _, 玩家 in pairs(玩家数据) do
				if 玩家.队伍 == 当前队伍ID and 玩家.队长 then
					队长玩家数据 = 玩家
					break
				end
			end
		else
			-- 单人情况下，当前玩家就是自己的"队长"
			队长玩家数据 = 当前玩家
		end

		if 参战单位.类型=="角色" and 玩家数据[玩家id]~=nil then
			if 参战单位.气血<=0 then
				玩家数据[玩家id].角色:死亡处理(PK战斗)
			else
				-- 还原基础属性（保留原逻辑）
				玩家数据[玩家id].角色.愤怒= 参战单位.愤怒
				玩家数据[玩家id].角色:刷新信息()
				if 参战单位.气血<玩家数据[玩家id].角色.最大气血 then
					玩家数据[玩家id].角色.气血= 参战单位.气血
				end
				if 参战单位.气血上限< 玩家数据[玩家id].角色.最大气血 then
					玩家数据[玩家id].角色.气血上限= 参战单位.气血上限
				end
				if 参战单位.魔法< 玩家数据[玩家id].角色.最大魔法 then
					玩家数据[玩家id].角色.魔法= 参战单位.魔法
				end
			end

			-- 2. 基于队长的任务10恢复（修复单人情况）
			local 恢复id = 0
			if 队长玩家数据 then
				恢复id = 队长玩家数据.角色:取任务(10)  -- 用队长的任务10（单人时就是自己的任务）
			end

			if 恢复id~=0 then
				-- 恢复气血（消耗队长任务资源）
				if 玩家数据[玩家id].角色.气血<玩家数据[玩家id].角色.最大气血 then
					if 任务数据[恢复id].气血>0 then
						 if 任务数据[恢复id].气血>玩家数据[玩家id].角色.气血上限-玩家数据[玩家id].角色.气血 then
							任务数据[恢复id].气血=任务数据[恢复id].气血-(玩家数据[玩家id].角色.气血上限-玩家数据[玩家id].角色.气血)
							玩家数据[玩家id].角色.气血=玩家数据[玩家id].角色.最大气血
							玩家数据[玩家id].角色.气血上限=玩家数据[玩家id].角色.最大气血
						else
							玩家数据[玩家id].角色.气血=玩家数据[玩家id].角色.气血+任务数据[恢复id].气血
							玩家数据[玩家id].角色.气血上限=玩家数据[玩家id].角色.最大气血
							任务数据[恢复id].气血=0
						end
					end
				end

				-- 恢复魔法（消耗队长任务资源）
				if 玩家数据[玩家id].角色.魔法<玩家数据[玩家id].角色.最大魔法 then
					if 任务数据[恢复id].魔法>0 then
						if 任务数据[恢复id].魔法>玩家数据[玩家id].角色.最大魔法-玩家数据[玩家id].角色.魔法 then
							任务数据[恢复id].魔法=任务数据[恢复id].魔法-(玩家数据[玩家id].角色.最大魔法-玩家数据[玩家id].角色.魔法)
							玩家数据[玩家id].角色.魔法=玩家数据[玩家id].角色.最大魔法
						else
							玩家数据[玩家id].角色.魔法=玩家数据[玩家id].角色.魔法+任务数据[恢复id].魔法
							任务数据[恢复id].魔法=0
						end
					end
				end

				-- 队长任务耗尽时，取消队长的任务（单人时就是取消自己的任务）
				if 任务数据[恢复id].气血==0 and 任务数据[恢复id].魔法==0 then
					队长玩家数据.角色:取消任务(恢复id)
					队长玩家数据.角色:刷新任务跟踪()  -- 刷新队长的任务跟踪
				end
			end
			玩家数据[玩家id].角色:刷新任务跟踪()  -- 保留原刷新逻辑
		else
			-- 召唤兽处理（同样基于队长任务10，修复单人情况）
			if 玩家数据[玩家id]~=nil then
				if 参战单位.气血<=0 then
					玩家数据[玩家id].召唤兽:死亡处理(参战单位.认证码)
					玩家数据[玩家id].召唤兽:刷新信息(参战单位.认证码,"1")
				else
					-- 3. 召唤兽恢复：用队长任务10判断是否补满（修复单人情况）
					local 恢复id = 0
					if 队长玩家数据 then
						恢复id = 队长玩家数据.角色:取任务(10)  -- 队长任务10（单人时就是自己的任务）
					end

					local 编号=玩家数据[玩家id].角色:取参战宝宝编号()
					if 编号~=0 then
						if 恢复id~=0 then  -- 队长有任务时补满召唤兽
							玩家数据[玩家id].召唤兽.数据[编号].气血=玩家数据[玩家id].召唤兽.数据[编号].最大气血
							玩家数据[玩家id].召唤兽.数据[编号].魔法=玩家数据[玩家id].召唤兽.数据[编号].最大魔法
						else  -- 无任务时按战斗中数值还原
							玩家数据[玩家id].召唤兽.数据[编号].气血=qz(参战单位.气血)
							玩家数据[玩家id].召唤兽.数据[编号].魔法=qz(参战单位.魔法)
						end
					end
					玩家数据[玩家id].召唤兽:刷新信息(参战单位.认证码)
				end
			end
		end
	end
end
function 战斗处理类:发送战斗结束数据()
	观战记录 = nil

	线程:发送(2, self.进入战斗玩家id)
end

function 战斗处理类:发送BUG退出信息()
	线程:发送(3, self.进入战斗玩家id)
end

function 战斗处理类:取主动技能是否存在(编号, 技能)
	for i = 1, #self.参战单位[编号].主动技能 do
		if self.参战单位[编号].主动技能[i].名称 == 技能 then
			return true
		end
	end
	return false
end

function 战斗处理类:取法宝技能是否存在(编号, 技能)
	for i = 1, #self.参战单位[编号].法宝技能 do
		if self.参战单位[编号].法宝技能[i].名称 == 技能 then
			return true
		end
	end
	return false
end

function 战斗处理类:判定类型(n)
	local 类型 = "无类型"
	if self.参战单位[n].类型 =="角色" then
		if self.参战单位[n].门派 == "大唐官府" or self.参战单位[n].门派 == "狮驼岭" or self.参战单位[n].门派 == "凌波城"  then
			类型 = "物理"
		elseif (self.参战单位[n].门派 == "天宫" or self.参战单位[n].门派 == "五庄观" ) and self.参战单位[n].力量 > self.参战单位[n].等级 * 2.5 then
			类型 = "物理"
		elseif self.参战单位[n].门派 == "天宫"  and self.参战单位[n].魔力 > self.参战单位[n].等级 * 2.5 then
			类型 = "法术"
		elseif (self.参战单位[n].门派 == "天宫" or self.参战单位[n].门派 == "五庄观" )   and self.参战单位[n].敏捷 > self.参战单位[n].等级 * 2.5 then
			类型 = "封系"
		elseif self.参战单位[n].门派 == "化生寺" or self.参战单位[n].门派 == "普陀山" or self.参战单位[n].门派 == "无底洞"or self.参战单位[n].门派 == "阴曹地府" then
			类型 = "辅助"
		elseif self.参战单位[n].门派 == "神木林" or self.参战单位[n].门派 == "魔王寨" or self.参战单位[n].门派 == "龙宫"  then
			类型 = "法术"
		elseif self.参战单位[n].门派 == "方寸山" or self.参战单位[n].门派 == "女儿村" or self.参战单位[n].门派 == "盘丝洞" or self.参战单位[n].门派 == "盘丝洞"  then
			类型 = "封系"
		end
	end
	return 类型
end

function 战斗处理类:更新()
	if self.回合进程 == "命令回合" then
		if os.time() - self.等待起始 >= 3 then
			local  发送内容 = {}
			for n = 1, #self.参战单位 do
				if self.参战单位[n].自动战斗 and self.参战单位[n].指令.下达 == false then
					if self.参战单位[n].自动指令 ~= nil and 玩家数据[self.参战单位[n].玩家id] ~= nil and 玩家数据[self.参战单位[n].玩家id].角色.自动战斗      then  -------花果山自动问题

						if self.参战单位[n].智能施法 and self.参战单位[n].类型 == "角色" then
              				          		智能施法(self,n)
              			                      	else
							self.参战单位[n].指令 = table.loadstring(table.tostring(self.参战单位[n].自动指令))
							--重新计算
							if self.参战单位[n].门派=="九黎城" then
				                                        	self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"法术")
				                                            	self.参战单位[n].指令.类型 = "法术"
							end
							if self.参战单位[n].指令.类型 == "法术" then
								if self.参战单位[n].指令.参数 == "" then
									self.参战单位[n].指令.类型 = "攻击"
									self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
								else
									if self.参战单位[n].队伍 ~= 0  and self.参战单位[n].门派=="花果山" and not self:取是否有技能(n,self.参战单位[n].指令.参数) then
										self.参战单位[n].指令.类型 = "攻击"
										self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
									elseif self:取主动技能是否存在(n, self.参战单位[n].指令.参数) then
										local 临时技能 = 取法术技能(self.参战单位[n].指令.参数)
										if 临时技能[3] == 4 then
											self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"法术")
										else
											self.参战单位[n].指令.目标 = self:取单个友方目标(n)
										end
									else
										self.参战单位[n].指令.类型 = "攻击"
										self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
									end
								end
							elseif self.参战单位[n].指令.类型 == "攻击" then
								self.参战单位[n].指令.类型 = "攻击"
								self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
							elseif self.参战单位[n].指令.类型 == "防御" then
								self.参战单位[n].指令.类型 = "防御"
							else
								self.参战单位[n].指令.类型 = "攻击"
								self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
							end
							if self.参战单位[self.参战单位[n].指令.目标] == nil and self.参战单位[n].指令.类型 ~= "防御" then
								self.参战单位[n].指令.类型 = "攻击"
								self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
							end
						end
					else
						self.参战单位[n].指令.类型 = "攻击"
						self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
					end
					if self.PK战斗 and not self.单挑模式 then --自动时发送的指令
						if self.参战单位[n].指令.类型~="法术" then
							发送内容[self.参战单位[n].位置]=self.参战单位[n].指令.类型
						else
							发送内容[self.参战单位[n].位置]=self.参战单位[n].指令.参数
						end
						for i=1,#self.参战玩家 do
							if self.参战玩家[i].队伍==self.参战单位[n].队伍 and not self.参战玩家[i].助战 then
								发送数据(self.参战玩家[i].连接id,5555,发送内容)
							end
						end
					end
					self.参战单位[n].指令.下达 = true
					self.参战单位[n].指令到达 = self.回合数
					if self.参战单位[n].队伍 ~= 0 and self.参战单位[n].类型 == "角色" then
						self.加载数量 = self.加载数量 - 1
					end
				end
			end
		end
		if self.加载数量 <= 0 then
			self.回合进程 = "计算回合"
			self:设置执行回合()
		end
		if os.time() - self.等待起始 >= 100 then --客户端倒计时 命令数据
			self.回合进程 = "计算回合"
			self:设置执行回合()
		end
	elseif self.回合进程 == "计算回合" then

		if os.time()+1 >= self.计算等待 then
			self.计算等待=os.time()+60
			self:BUG处理()
		end
	elseif self.回合进程 == "执行回合" then
		--检查是否有自动
		-- local 断线数量=0
		-- for n=1,#self.参战玩家 do
		--  if self.参战玩家[n].断线等待 then
		--      断线数量=断线数量+1
		--  end
		-- end
		-- if 断线数量==#self.参战玩家  then
		--  self.执行等待=os.time()+5
		--  for n=1,#self.参战玩家 do
		--      self.参战玩家[n].断线等待=nil
		--  end
		--  return
		-- end
		if os.time() >= self.执行等待 and self.回合进程 ~= "结束回合" then
			self.回合进程 = "结束回合"
			self:回合结束处理()
		end
	end
end

function 战斗处理类:BUG处理()
	self:还原单位属性()
	for n=1,#self.参战玩家 do
		if 玩家数据[self.参战玩家[n].id]~=nil  and not self.参战玩家[n].助战  then
			添加对话(self.参战玩家[n].id,"玉皇大帝","男人_玉帝","本次战斗遇到了不可挽回的错误！请将此问题提交给GM进行修复，战斗类型："..self.战斗类型)
		end
	end
	self:发送BUG退出信息()
end

function 战斗处理类:死亡处理()
	local 死亡计算 = {0, 0}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].气血 <= 0 or self.参战单位[n].捕捉 or self.参战单位[n].逃跑 then

			if self.参战单位[n].队伍 == self.队伍区分[1] then
				死亡计算[1] = 死亡计算[1] + 1
			else
				死亡计算[2] = 死亡计算[2] + 1
			end
		end
	end
	if 死亡计算[1] == self.队伍数量[1] then
		return true
	elseif 死亡计算[2] == self.队伍数量[2] then
		return true
	end
	return false
end

function 战斗处理类:指定状态回合(单位)
	local mc={"潜心","佛眷","天照","精炼","炼魂","摧心","陷阱","压邪","锻炼","浮云神马"}--,"灵断"
	for i=1,#mc do
		if 单位[mc[i]] and type(单位[mc[i]]) == "table" and 单位[mc[i]].回合 then

			单位[mc[i]].回合=单位[mc[i]].回合-1
			if 单位[mc[i]].回合<=0 then
				单位[mc[i]]=nil
			end
		end
	end
	if 单位.骤雨.层数>0 and 单位.骤雨.回合>0 then
		单位.骤雨.回合=单位.骤雨.回合-1
		if 单位.骤雨.回合<=0 then
			单位.骤雨.层数=0
		end
	end
end

function 战斗处理类:回合结束处理()
	local 死亡计算 = {0, 0}
	for n = 1, #self.参战单位 do
		if self.参战单位[n].气血 <= 0 or self.参战单位[n].捕捉 or self.参战单位[n].逃跑 then
			if self.参战单位[n].队伍 == self.队伍区分[1] then
				死亡计算[1] = 死亡计算[1] + 1
			else
				死亡计算[2] = 死亡计算[2] + 1
			end
		end
	end
	if 死亡计算[1] == self.队伍数量[1] then
		self.回合进程 = "结束回合"
		self:结束战斗(self.队伍区分[2], self.队伍区分[1])
		self:发送战斗结束数据()
		--self.结束条件=true
		return
	elseif 死亡计算[2] == self.队伍数量[2] then
		self.回合进程 = "结束回合"
		self:结束战斗(self.队伍区分[1], self.队伍区分[2])
		self:发送战斗结束数据()
		--self.结束条件=true
		return
	end
	--检查状态
	local 结束流程 = {}

	self.战斗流程={} --12.6新增清空战斗流程
	self.附加流程={}

	for n = 1, #self.参战单位 do


		if self.参战单位[n].节节高升 ~=nil then
       			self.参战单位[n].节节高升=self.参战单位[n].节节高升+1
         				if self.参战单位[n].点燃状==nil then
         					self.参战单位[n].点燃状=5
         				end
        			self.参战单位[n].点燃状=self.参战单位[n].点燃状+5
       		end

		战斗计算:回合结束重置(self.参战单位[n])
		-- if self.参战单位[n].类型~="角色" then
		--     self:指定状态回合(self.参战单位[n])
		-- end
		if self.参战单位[n].黎魂 and self.参战单位[n].门派 == "九黎城" then--九黎
			self.参战单位[n].黎魂 = 2
			local gl = 15 + (self.参战单位[n].黎魂加成 or 0)
			if not self.参战单位[n].九黎连击次数 then
			    self.参战单位[n].九黎连击次数 = 0
			end
			gl = gl + self.参战单位[n].九黎连击次数 * 3
			self.参战单位[n].九黎连击次数 = 0
			if self.参战单位[n].凌人概率 then
				gl = gl + self.参战单位[n].凌人概率
				self.参战单位[n].凌人概率 = nil
			end
			if 取随机数(1, 1000) <= gl * 10 or self.参战单位[n].野蛮生效 ~= nil then
				self.参战单位[n].黎魂 = self.参战单位[n].黎魂 + 1
				self.参战单位[n].野蛮生效 = nil
			end
		end--九黎

		-- if self.参战单位[n].奇袭法术 then
		-- 	self:添加状态("奇袭术", self.参战单位[n],self.参战单位[n])
		-- end
		-------------------------------C改
			if not self.PK战斗 and self.参战单位[n].本命法宝 and self.参战单位[n].本命法宝.开启 and self.参战单位[n].本命法宝.耐久>0 then
				if  self.参战单位[n].本命法宝.名称=="万鬼木鱼" and self.参战单位[n].门派=="神木林"    and 取随机数(1,100) < self.参战单位[n].本命法宝.等级 then
					local 额外加成=self.参战单位[n].本命法宝.等级*0.2
					if 额外加成<1 then
						额外加成=1
					end
					self:添加状态("蜜润", self.参战单位[n],self.参战单位[n],self.参战单位[n].等级*额外加成)
				end
				if  self.参战单位[n].本命法宝.名称=="烈焰杖" and self.参战单位[n].门派=="魔王寨"    and 取随机数(1,100) < self.参战单位[n].本命法宝.等级 then
					local 额外加成=self.参战单位[n].本命法宝.等级*0.2
					if 额外加成<1 then
						额外加成=1
					end
					self:添加状态("牛劲", self.参战单位[n],self.参战单位[n],self.参战单位[n].等级*额外加成)
				end
				if  self.参战单位[n].本命法宝.名称=="灵明仙桃" and self.参战单位[n].门派=="天宫"    and 取随机数(1,100) <= self.参战单位[n].本命法宝.等级 then
					local 额外加成=self.参战单位[n].本命法宝.等级*0.2
					if 额外加成<1 then
						额外加成=1
					end
					self:添加状态("天雷灌注", self.参战单位[n],self.参战单位[n],self.参战单位[n].等级*额外加成)
				end
				if  self.参战单位[n].本命法宝.名称=="凝海珠" and self.参战单位[n].门派=="龙宫"    and 取随机数(1,100) <= self.参战单位[n].本命法宝.等级 then
					local 额外加成=self.参战单位[n].本命法宝.等级*0.2
					if 额外加成<1 then
						额外加成=1
					end
					self:添加状态("龙战于野", self.参战单位[n],self.参战单位[n],self.参战单位[n].等级*额外加成)
					-- local 目标 = self.参战单位[n]
					--     if 目标.法术状态 and 目标.法术状态.言出法随 then
					--         目标.法术状态.言出法随.回合 = 3
					--     end
				end
				if  self.参战单位[n].本命法宝.名称=="万兽圣令" and self.参战单位[n].门派=="狮驼岭"    and 取随机数(1,100) <= self.参战单位[n].本命法宝.等级 then
					local 额外加成=self.参战单位[n].本命法宝.等级*0.2
					if 额外加成<1 then
						额外加成=1
					end
					-- 1. 先加变身
					self:添加状态("变身", self.参战单位[n], self.参战单位[n], self.参战单位[n].等级*额外加成)
					-- 2. 新增：触发狂怒前，强制刷新变身回合数
					if self.参战单位[n].法术状态.变身 then
					    -- 把变身的回合数，重置成和变身一样的数值
					    self.参战单位[n].法术状态.变身.回合 = 6
					end
					-- 3. 再加狂怒，这时候拿到的就是刷新后的回合数了
					if self.参战单位[n].法术状态.变身 then
					    self:添加状态("狂怒", self.参战单位[n], self.参战单位[n], 69, nil, self.参战单位[n].法术状态.变身.回合)
					end
				end
				if  self.参战单位[n].本命法宝.名称=="无尘雪" and self.参战单位[n].门派=="凌波城"    and 取随机数(1,100) <= self.参战单位[n].本命法宝.等级 then
					self:增加战意(n, 1) -- 额外+1点战意
				end
				if  self.参战单位[n].本命法宝.名称=="天师符" and self.参战单位[n].门派=="方寸山"    and 取随机数(1,100) <= self.参战单位[n].本命法宝.等级 then
					local 额外加成=self.参战单位[n].本命法宝.等级*0.2
					if 额外加成<1 then
						额外加成=1
					end
					self:添加状态("分身术", self.参战单位[n],self.参战单位[n],self.参战单位[n].等级*额外加成)
				end
				if  self.参战单位[n].本命法宝.名称=="炼妖壶" and self.参战单位[n].门派=="无底洞"    and 取随机数(1,100) <= self.参战单位[n].本命法宝.等级 then
					local 额外加成=self.参战单位[n].本命法宝.等级*0.2
					if 额外加成<1 then
						额外加成=1
					end
					self:添加状态("燃血术", self.参战单位[n],self.参战单位[n],self.参战单位[n].等级*额外加成)
				end

			end
		-------------------------------C改


		self:指定状态回合(self.参战单位[n])
		if self.参战单位[n].护盾>0 then
			self.参战单位[n].护盾=qz(self.参战单位[n].护盾*0.85)
		end

		结束流程[#结束流程+1]={挨打方=n,取消状态={}}

		for k, v in pairs(self.参战单位[n].法术状态) do
			if v.回合 == nil then
				print(k.."     这个状态没有回合")
				v.回合 =1
			end
			v.回合 = v.回合 - 1
			v.当前回合=nil --催眠召唤回合
			if (k == "变身" or k == "狂怒") and self.参战单位[n].气血<=0 and 取随机数() < 70 then
				if v.宁息 then
					v.回合 = v.回合 + 1
				elseif v.屏息 then
					v.回合 = v.回合 + 1
				end
			end
			if v.回合 <= 0 then
				if k == "复活" then
					-- for w = 1, #self.参战玩家 do
					--  发送数据(self.参战玩家[w].连接id, 5508, {id = n, 气血 = self.参战单位[n].最大气血})
					-- end
					self.参战单位[n].死亡 = nil
					self.参战单位[n].气血 = self.参战单位[n].最大气血
					结束流程[#结束流程].复活={气血 = self.参战单位[n].气血}
				else
					-- for w = 1, #self.参战玩家 do
					--  发送数据(self.参战玩家[w].连接id, 5507, {id = n, 名称 = k})
					-- end
					if k == "渡劫金身" and v.渡劫金身 then
						self:动画加血流程(n,v.渡劫金身.恢复气血,k)
					elseif k == "真君显灵" then
						self:增加战意(n,1)
					elseif k == "九幽除名" and 取随机数()<=70 then
						self.参战单位[n].死亡 = nil
						self.参战单位[n].气血 = self.参战单位[n].等级*5
						结束流程[#结束流程].复活={气血 = self.参战单位[n].气血}
					end
				end
				self:取消状态(k, self.参战单位[n])
				结束流程[#结束流程].取消状态[#结束流程[#结束流程].取消状态+1]=k
			else
				if k == "分身术" then
					v.破解 = nil
					if self:取经脉(n, "方寸山", "调息") and self.参战单位[n].气血 >0 then
						local qx =qz(self.参战单位[n].气血上限*0.05+ self.参战单位[n].气血回复效果)
						self.参战单位[n].气血 = self.参战单位[n].气血 + qx
						if self.参战单位[n].气血 > self.参战单位[n].最大气血 then
							self.参战单位[n].气血 = self.参战单位[n].最大气血
						end
						self:增加魔法(n,qz(self.参战单位[n].最大魔法*0.03))
						结束流程[#结束流程].结尾回血={气血 = qx}
					end
				elseif k == "乾坤玄火塔" and self.参战单位[n].气血 >0 then
					local 愤怒 = qz(150 * (qz(v.境界 / 5) * 0.02 + 0.02))
					self:增加愤怒(n,愤怒)
				elseif k == "无尘扇" and self.参战单位[n].气血 >0 then
					self:减少愤怒(n,v.减愤怒) --16
				elseif k == "龙魂" and self:取经脉(n, "龙宫", "睥睨") and self.参战单位[n].气血 >0 then
					self:增加愤怒(n,5)
				-- elseif k == "风灵" and self.回合数>1 and 取偶数(self.回合数) and self.参战单位[n].法身==nil and self.参战单位[n].气血 >0 then
				--  v.层数 = v.层数 + 1
				elseif k == "紧箍咒" and v.默诵 then
					self:减少愤怒(n,6)
				elseif k == "智眼" then
					self:增加战意(n,1)
				elseif k == "钟馗论道" then
					if self.参战单位[n].法术状态.锢魂术 then
						self.参战单位[n].法术状态.锢魂术.回合=self.参战单位[n].法术状态.锢魂术.回合-1
						if self.参战单位[n].法术状态.锢魂术.回合<=0 then
							self.参战单位[n].法术状态.锢魂术=nil
							结束流程[#结束流程].取消状态[#结束流程[#结束流程].取消状态+1]="锢魂术"
						end
					end
					if self.参战单位[n].法术状态.死亡召唤 then
						self.参战单位[n].法术状态.死亡召唤.回合=self.参战单位[n].法术状态.死亡召唤.回合-1
						if self.参战单位[n].法术状态.死亡召唤.回合<=0 then
							self.参战单位[n].法术状态.死亡召唤=nil
							结束流程[#结束流程].取消状态[#结束流程[#结束流程].取消状态+1]="死亡召唤"
						end
					end
				elseif k == "真君显灵" then
					self:增加战意(n,1)
				elseif k == "风火燎原" then
					for k, v in pairs(self.参战单位[n].主动技能) do
						if (v.名称 == "秘传三昧真火" or v.名称 == "秘传飞砂走石") and v.剩余冷却回合~=nil then
							if v.剩余冷却回合==nil then
								v.剩余冷却回合=1
							end
							v.剩余冷却回合=v.剩余冷却回合-1
							if v.剩余冷却回合<0 then
								v.剩余冷却回合=0
							end
							break
						end
					end
				elseif k == "瘴气" then
					if v.绝殇 and self.参战单位[n].气血 >0 then
						self:减少愤怒(n,1)
					end
					if v.降魔 and self.参战单位[n].气血 >0 then --迷意
						self:减少魔法(n,40)
					end
					if self.参战单位[n].法术状态.天罗地网 and sj()<=30 and self.参战单位[n].法术状态.天罗地网.障眼 then
						self.参战单位[n].法术状态.天罗地网.回合 = self.参战单位[n].法术状态.天罗地网.回合 + 1
					end
				end
				if v.递减名称 and v.回合递减 then
					v[v.递减名称]=v[v.递减名称]-v.回合递减
					if v[v.递减名称] <0 then
						v[v.递减名称] =0
					end
				end
			end
		end

		if self.参战单位[n].队伍~=0  then
			if self.友方经脉统计[self.参战单位[n].队伍]~=nil and  self.友方经脉统计[self.参战单位[n].队伍].意境~=nil and  self:取目标状态(n, n, 2) then
				self:增加魔法(n,24)
				if self.参战单位[n].愤怒 ~= nil then
					self:增加愤怒(n,1)
				end
			end
			if self.参战单位[n].类型=="角色" then
				if self.参战单位[n].人参果.枚>0 then
					self.参战单位[n].人参果.回合=self.参战单位[n].人参果.回合-1
					if self.参战单位[n].人参果.回合<=0 then
						self.参战单位[n].人参果 = {枚=0,回合=4}
					end
				end
				if self:取经脉(n, "大唐官府","静岳") and self.参战单位[n].护盾<=0 then
					战斗计算:添加护盾(self,n,self.参战单位[n].等级)
				end

				if self:取经脉(n,"五庄观","养生") and self.参战单位[n].气血<=qz(self.参战单位[n].最大气血*0.7) and self.参战单位[n].法术状态.生命之泉==nil then
					self:添加状态("生命之泉",self.参战单位[n],self.参战单位[n],self:取技能等级(n,"生命之泉"))
				end
				if self:取经脉(n, "化生寺", "慈心") and  self:取目标状态(n, n, 2) then
					local 队友=self:取多个友方目标(n,n,50)
					if #队友~=0 then
						for i=1,#队友 do
							if 队友[i]~=n and self.参战单位[队友[i]].类型=="角色" and self.参战单位[队友[i]].气血<=0 then
								if self.参战单位[队友[i]].法术状态.死亡召唤 and self.参战单位[队友[i]].法术状态.死亡召唤.回合<=2 then
									self:取消状态("死亡召唤",self.参战单位[队友[i]])
									结束流程[#结束流程].取消状态[#结束流程[#结束流程].取消状态+1]="死亡召唤"
									self:添加状态("死亡召唤",self.参战单位[n],self.参战单位[n],69,nil,5)
								end
								if self.参战单位[队友[i]].法术状态.锢魂术 and self.参战单位[队友[i]].法术状态.锢魂术.回合<=2 then
									self:取消状态("锢魂术",self.参战单位[队友[i]])
									结束流程[#结束流程].取消状态[#结束流程[#结束流程].取消状态+1]="锢魂术"
									self:添加状态("锢魂术",self.参战单位[n],self.参战单位[n],69,nil,5)
								end
							end
						end
					end
				end
				if self.参战单位[n].苏醒血量~=nil then
					if self.参战单位[n].苏醒血量>=self.参战单位[n].最大气血*0.3 and self.参战单位[n].气血 > 0 then
						self:解除状态结果(self.参战单位[n], 初始技能计算:取封印状态法术())
					end
					self.参战单位[n].苏醒血量=0
				end

				if self.参战单位[n].气血 <= 0 and self:取指定法宝(n, "救命毫毛") and 初始技能计算:不可复活(self.参战单位[n])==false then
					if self.参战单位[n].毫毛次数 ==nil then
						self.参战单位[n].毫毛次数=0
					end
					local cishu = 3
					if self:取经脉(n, "方寸山", "不灭") then
						cishu = 6
					end
					if self.参战单位[n].毫毛次数 <cishu then
						--发送数据(self.参战玩家[w].连接id, 5508, {id = n, 气血 = qz(self.参战单位[n].最大气血 * 0.2)})
						self.参战单位[n].死亡 = nil
						self.参战单位[n].气血 = qz(self.参战单位[n].最大气血 * 0.2)
						if self.参战单位[n].气血上限<self.参战单位[n].气血 then
							self.参战单位[n].气血上限=self.参战单位[n].气血
						end
						-- self.参战单位[n].法术状态 = {} --为啥要清空状态啊
						self.参战单位[n].毫毛次数 = self.参战单位[n].毫毛次数 + 1
						结束流程[#结束流程].复活={气血 = self.参战单位[n].气血}
						if cishu==6 then
							self.参战单位[n].法伤 = self.参战单位[n].法伤 + 40
						end

					end
				end
				if not self:取经脉(n, "方寸山","咒诀") and  self.参战单位[n].JM.当前流派=="五雷正宗" and  self.参战单位[n].法术状态.符咒 then
              self.参战单位[n].法术状态.符咒.层数=math.random(1,5)
			   end
			   if self.参战单位[n].JM.当前流派=="五雷正宗" and self:取经脉(n, "方寸山","咒诀") and  self.参战单位[n].法术状态.符咒 and self.参战单位[n].法术状态.雷法·坤伏.层数+self.参战单位[n].法术状态.雷法·崩裂.层数+self.参战单位[n].法术状态.雷法·轰天.层数+ self.参战单位[n].法术状态.雷法·震煞.层数>0  then
			      self.参战单位[n].法术状态.符咒.层数=math.random(1,5)
			   end
			   if self.参战单位[n].JM.当前流派=="五雷正宗" and self:取经脉(n, "方寸山","咒诀") and  self.参战单位[n].法术状态.符咒 and self.参战单位[n].法术状态.雷法·坤伏.层数+self.参战单位[n].法术状态.雷法·崩裂.层数+self.参战单位[n].法术状态.雷法·轰天.层数+ self.参战单位[n].法术状态.雷法·震煞.层数==0  then
			      self.参战单位[n].法术状态.符咒.层数=math.random(3,5)
			   end
				--龙宫
				if self:取经脉(n, "龙宫", "破浪") and  self:取目标状态(n, n, 2) and 取随机数()<=33 then
					self:添加状态("破浪",self.参战单位[n],self.参战单位[n],69)
				end
				if self:取经脉(n, "龙宫", "龙息") then
					self.参战单位[n].法术暴击等级 = self.参战单位[n].法术暴击等级 + 2 --这里是0.2％的意思
				end
				--魔王

				if self:取经脉(n, "魔王寨", "激怒") and  self:取目标状态(n, n, 2) and 取随机数()<=10 then
					self:添加状态("蚀天",self.参战单位[n],self.参战单位[n],69,nil,4)
				end
				if self.参战单位[n].门派=="神木林" then
					if self.回合数>1 and 取偶数(self.回合数) and self.参战单位[n].法身==nil and self.参战单位[n].气血 >0 then
						self:添加状态("风灵",self.参战单位[n],self.参战单位[n],69)
					end
					if self:取经脉(n, "神木林", "薪火") then --神木林
						if self:取装备五行(n,3)=="火" then --武器
							self.参战单位[n].法伤 = self.参战单位[n].法伤 + 2
						end
						if self:取装备五行(n,4)=="火" then --衣服
							self.参战单位[n].法伤 = self.参战单位[n].法伤 + 2
						end
					end
				end


				--盘丝
				if self:取经脉(n, "盘丝洞", "安抚") then
					local num = self:敌方点对点状态数量(n,"含情脉脉") +  self:敌方点对点状态数量(n,"魔音摄魂")
					self:增加愤怒(n,num*4)
				end
				if self.参战单位[n].结阵 then
					self.参战单位[n].速度=self.参战单位[n].速度-2
				end
				if self:取经脉(n, "盘丝洞", "利刃") and self.PK战斗 then
					for a = 1, #self.参战单位 do
						if self.参战单位[a].队伍 ~= self.参战单位[n].队伍 and self.参战单位[a].气血>0 then
							self:减少魔法(a,30)
						end
					end
				end
				if self:取经脉(n, "阴曹地府", "轮回") and self:敌方指定状态数量(n,"尸腐毒")==6 then
					self:添加状态("轮回",self.参战单位[n],self.参战单位[n],69)
				end
				if self.参战单位[n].生杀予夺 then
					for k, v in pairs(self.参战单位[n].主动技能) do
						if v.名称 == "生杀予夺" and v.剩余冷却回合~=nil then
							v.剩余冷却回合=v.剩余冷却回合-self:敌方指定状态数量(n,"尸腐毒")
							if v.剩余冷却回合<0 then
								v.剩余冷却回合=0
							end
							break
						end
					end
				end
				--五庄
				if self.参战单位[n].门派=="五庄观" and  self:取目标状态(n, n, 2) then
					if self:取经脉(n, "五庄观", "心浪") and self.参战单位[n].愤怒<50 then
						self:增加愤怒(n,取随机数(1, 15))
					end
					if self:取经脉(n, "五庄观", "蓄志") and self.参战单位[n].法术状态.生命之泉 and self.参战单位[n].法术状态.炼气化神 then
						self:增加愤怒(n,3)
					end
					if self:取经脉(n, "五庄观", "剑气") then
						self.参战单位[n].物理暴击等级=self.参战单位[n].物理暴击等级+4
					end
				end

				if self.回合数 >= 1 and self.参战单位[n].门派 == "花果山" then --如意神通
					if self.参战单位[n].压邪~=nil then
						if self.参战单位[n].压邪.层数>=3 then
							self:添加状态("压邪",self.参战单位[n],self.参战单位[n],11)
							self.参战单位[n].压邪=nil
						end
					elseif self.参战单位[n].锻炼~=nil then
						if self.参战单位[n].锻炼.层数>=3 and 取随机数()<=10 then
							local num = qz(self.参战单位[n].最大气血/3.3)
							local max = self:取技能等级(n,"铜头铁臂")*15
							if num>= max then
								num = max
							end
							战斗计算:添加护盾(self,n,num)
							self:添加状态("铜头铁臂",self.参战单位[n],self.参战单位[n],11)
							self.参战单位[n].锻炼=nil
						end
					end
					if self:取经脉(n, "花果山", "冲霄") then
						self.参战单位[n].法伤=self.参战单位[n].法伤+4
					end
					if self.参战单位[n].法术状态.显圣==nil then
						self:如意神通处理(self.参战单位[n],n)
					end
					for w = 1, #self.参战玩家 do
						if self.参战单位[n].如意神通 then
							发送数据(self.参战玩家[w].连接id, 5525, {id=n, 如意神通=self.参战单位[n].如意神通})
						end
					end
				end
				if self.参战单位[n].气血上限 ~= nil then
					if self.参战单位[n].气血 > self.参战单位[n].气血上限 then
						local 气血 = self.参战单位[n].气血 - self.参战单位[n].气血上限
						self:减少气血(n, 气血)
					end
					self.参战单位[n].灵元.回合=self.参战单位[n].灵元.回合-1
					if self.参战单位[n].灵元.回合 <= 0 then
						self.参战单位[n].灵元.回合=5
						self.参战单位[n].灵元.数值=self.参战单位[n].灵元.数值+1
	  				if self.参战单位[n].等级>=109 then
						常规提示(self.参战单位[n].玩家id, "#Y/增加1点灵元,当前"..self.参战单位[n].灵元.数值.."点灵元")
					end

					end
				end

				if self:取指定法宝(n, "宿幕星河") then
					self.参战单位[n].法暴 = self.参战单位[n].法暴 + 1.3 --增加1%+((回合数-1)/12)%法术暴击率，效果随战斗回合增加而增加
				end
				if self:取指定法宝(n, "千斗金樽") then
					self.参战单位[n].必杀 = self.参战单位[n].必杀 + 1.3 --增加1%+((回合数-1)/12)%法术暴击率，效果随战斗回合增加而增加
				end
				if self.战斗类型 == 100001 or self.战斗类型 == 100007 then
					self:增加法宝灵气(n)
				end
			end
		else
			if self.回合数 >= 1 and self.参战单位[n].门派 == "凌波城" then
				self:增加战意(n,1)
			end
		end


		 if self.战斗类型 == 150055  then
		 	local 剩余单位=0
		 	local 烟花id=0
		 	for i = 1, #self.参战单位 do
		 		if  self.参战单位[i].类型~="角色" and  self.参战单位[i].玩家id==0 and  self:取目标状态(i, i, 2) then
		 		剩余单位=剩余单位+1
		 		end
		 	end
		 	if  剩余单位==1 then
		 		 self.战斗发言数据[#self.战斗发言数据 + 1] = {id = self.参战单位[n].主怪, 内容 = "你可千万不要放驱赶烟花啊#15我最怕那个了#15#Y/（使用驱赶烟花可直接吓跑神兽）"}
		 	end
		 	if  剩余单位==1 and self.参战单位[n].玩家id~=nil and self.参战单位[n].玩家id~=0 and 玩家数据[self.参战单位[n].玩家id].队伍~=0 and 玩家数据[self.参战单位[n].玩家id].队长 then
		 		-- self.参战单位[n].指令.目标= self.参战单位[n].主怪
	 			 local id = self.参战单位[n].玩家id
				 for i = 1,20 do
					 if 玩家数据[id].角色.道具[i]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[i]] then
					 	if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[i]].名称=="驱赶烟花" then
						 	烟花id=i
							找到=true
							break
						 end
					end
				end
				if 烟花id ~=0 and self.参战单位[n].类型=="角色" then --@
					self.参战单位[n].自动指令.目标=self.参战单位[n].主怪
					self.参战单位[n].自动指令.参数=烟花id
					self.参战单位[n].自动指令.类型="道具"
					常规提示(self.参战单位[n].玩家id, "#Y/自动技能已切换为驱赶烟花")
				end
		 	end
		 end
		结束流程[#结束流程].人物状态 ={}
		结束流程[#结束流程].人物状态.气血 = self.参战单位[n].气血
		结束流程[#结束流程].人物状态.最大气血 = self.参战单位[n].最大气血 or nil
		结束流程[#结束流程].人物状态.气血上限 = self.参战单位[n].气血上限 or nil
		结束流程[#结束流程].人物状态.魔法 = self.参战单位[n].魔法 or nil
		结束流程[#结束流程].人物状态.最大魔法 = self.参战单位[n].最大魔法 or nil
		结束流程[#结束流程].人物状态.愤怒 = self.参战单位[n].愤怒 or 0
		结束流程[#结束流程].人物状态.护盾 = self.参战单位[n].护盾 or 0
		结束流程[#结束流程].人物状态.战意 = self.参战单位[n].战意 or 0
		结束流程[#结束流程].人物状态.超级战意 = self.参战单位[n].超级战意 or nil
		结束流程[#结束流程].人物状态.如意神通 = self.参战单位[n].如意神通 or nil
		结束流程[#结束流程].人物状态.五行珠 = self.参战单位[n].五行珠 or 0
		结束流程[#结束流程].人物状态.人参果 = self.参战单位[n].人参果 or {枚=0,回合=4}
		结束流程[#结束流程].人物状态.骤雨 = self.参战单位[n].骤雨 or {层数=0,回合=3}
		结束流程[#结束流程].法术状态 = self.参战单位[n].法术状态
		结束流程[#结束流程].共生 = self.参战单位[n].共生
		结束流程[#结束流程].黎魂 = self.参战单位[n].黎魂
		结束流程[#结束流程].丸子附加 = {}
		结束流程[#结束流程].丸子附加.超级必杀 = self.参战单位[n].超级必杀 or 0
		结束流程[#结束流程].丸子附加.超级夜战 = self.参战单位[n].超级夜战 or 0
		结束流程[#结束流程].丸子附加.首次被伤 = self.参战单位[n].首次被伤 or {物理=0,法术=0,每回物理=0,每回法术=0}
		结束流程[#结束流程].丸子附加.超级偷袭 = self.参战单位[n].超级偷袭 or false
		结束流程[#结束流程].丸子附加.超级敏捷 = self.参战单位[n].超级敏捷 or {概率=0,触发=0,执行=false,指令={}}
	end
	for n = 1, #self.参战玩家 do
		if not self.参战玩家[n].助战  then
			发送数据(self.参战玩家[n].连接id, 5518,结束流程)
			self.参战玩家[n].断线等待 = nil
		end
	end
	for i = 1, #self.观战玩家 do
		发送数据(self.观战玩家[i].连接id, 5518,结束流程)
	end
	self:设置命令回合()
end

function 战斗处理类:如意神通处理(单位,编号)
	if 单位.JM.当前流派=="齐天武圣" then
		local jn = {"当头一棒","神针撼海","杀威铁棒","泼天乱棒","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
		if self:取经脉(编号,"花果山","棒打雄风") then
			jn = {"当头一棒","神针撼海","棒打雄风","泼天乱棒","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
		end
		local x  = 1
		单位.如意神通={}
		if 单位.贪天~=nil and 取随机数()<=50 then
			for i=1,#jn do
				if jn[i]==单位.贪天 then
					单位.如意神通[#单位.如意神通+1]=jn[i]
					table.remove(jn,i)
					break
				end
			end
		else
			x = 取随机数(1,#jn)
			单位.如意神通[#单位.如意神通+1]=jn[x]
			table.remove(jn,x)
		end
		x = 取随机数(1,#jn)
		单位.如意神通[#单位.如意神通+1]=jn[x]
		table.remove(jn,x)
		x = 取随机数(1,#jn)
		单位.如意神通[#单位.如意神通+1]=jn[x]
		table.remove(jn,x)
		if 单位.斗志~=nil then
			local go = true
			for i=1,#jn do
				if jn[i]==单位.斗志 then
					go = false
					break
				end
			end
			if go then
				x = 取随机数(1,#jn)
				单位.如意神通[#单位.如意神通+1]=jn[x]
				table.remove(jn,x)
				jn[#jn+1]=单位.斗志
			end
		end
		for k,v in pairs(单位.主动技能) do --冷却处理
			for i=1,#jn do
				if v.名称==jn[i] then
					v.剩余冷却回合=1
				end
			end
		end
	elseif 单位.JM.当前流派=="斗战真神" then
		local jn = {"当头一棒","神针撼海","杀威铁棒","泼天乱棒","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
		if self:取经脉(编号,"花果山","棒打雄风") then
			jn = {"当头一棒","神针撼海","棒打雄风","泼天乱棒","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
		end
		if 单位.顽心~=nil then
			for k,v in pairs(单位.主动技能) do
				for i=1,#jn do
					if v.名称==jn[i] then
						v.剩余冷却回合=1
						for a=1,#单位.如意神通 do
							if v.名称==单位.如意神通[a] then
								v.剩余冷却回合=nil
								break
							end
						end
					end
				end
			end
			return
		end
		local x  = 1
		单位.如意神通={}
		if 单位.顽性~=nil and 取随机数()<=32 then
			for i=1,#jn do
				if jn[i]==单位.顽性 then
					单位.如意神通[#单位.如意神通+1]=jn[i]
					table.remove(jn,i)
					break
				end
			end
		end
		for i=1,3 do
			x = 取随机数(1,#jn)
			单位.如意神通[#单位.如意神通+1]=jn[x]
			table.remove(jn,x)
		end
		if 单位.自在~=nil and 取随机数()<=32 then
			x = 取随机数(1,#jn)
			单位.如意神通[#单位.如意神通+1]=jn[x]
			table.remove(jn,x)
		elseif 单位.变通~=nil then
			local go = true
			for i=1,#jn do
				if jn[i]==单位.变通 then --变通在冷却处理里面，就不再进行删除
					go = false
					break
				end
			end
			if go then --变通不在了。就再删除一个技能，然后插入变通技能
				x = 取随机数(1,#jn)
				单位.如意神通[#单位.如意神通+1]=jn[x]
				table.remove(jn,x)
				jn[#jn+1]=单位.变通
			end
			if 取随机数()<=50 then
				x = 取随机数(1,#jn)
				单位.如意神通[#单位.如意神通+1]=jn[x]
				table.remove(jn,x)
			end
		end
		if 单位.战神~=nil then
			x = 取随机数(1,#jn)
			单位.如意神通[#单位.如意神通+1]=jn[x]
			table.remove(jn,x)
		end

		for k,v in pairs(单位.主动技能) do --冷却处理
			for i=1,#jn do
				if v.名称==jn[i] then
					v.剩余冷却回合=1
				end
			end
		end
	elseif 单位.JM.当前流派=="通天行者" then
		local jn = {"棒掀北斗","兴风作浪","棍打诸神","意马心猿","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
		local x  = 1
		单位.如意神通={}
		if self:取经脉(编号, "花果山","闹海") and not self.PK战斗 then
			jn = {"棒掀北斗","棍打诸神","意马心猿","九幽除名","铜头铁臂","云暗天昏","无所遁形"}
			单位.如意神通[#单位.如意神通+1] = "兴风作浪"
		else
			x = 取随机数(1,#jn)
			单位.如意神通[#单位.如意神通+1]=jn[x]
			table.remove(jn,x)
		end
		if 单位.顽性~=nil and 取随机数()<=32 then
			for i=1,#jn do
				if jn[i]==单位.顽性 then
					单位.如意神通[#单位.如意神通+1]=jn[i]
					table.remove(jn,i)
					break
				end
			end
		end
		x = 取随机数(1,#jn)
		单位.如意神通[#单位.如意神通+1]=jn[x]
		table.remove(jn,x)
		x = 取随机数(1,#jn)
		单位.如意神通[#单位.如意神通+1]=jn[x]
		table.remove(jn,x)

		if 单位.斗志~=nil then
			local go = true
			for i=1,#jn do
				if jn[i]==单位.斗志 then
					go = false
					break
				end
			end
			if go then
				x = 取随机数(1,#jn)
				单位.如意神通[#单位.如意神通+1]=jn[x]
				table.remove(jn,x)
				jn[#jn+1]=单位.斗志
			end
		end

		for k,v in pairs(单位.主动技能) do --冷却处理
			for i=1,#jn do
				if v.名称==jn[i] then
					v.剩余冷却回合=1
				end
			end
		end
	end
end

function 战斗处理类:更改自动(真实id,玩家id)
	local 更改内容 = {}
	local 指令内容 = {}
	if 玩家数据[真实id].角色.自动战斗 then
		local 指令到达
		for n = 1, #self.参战单位 do
			if self.参战单位[n].玩家id == 真实id then
				self.参战单位[n].自动战斗 = nil
				更改内容[#更改内容 + 1] = {id = n, 自动 = self.参战单位[n].自动战斗}
				if self.参战单位[n].类型=="角色" and 指令到达 == nil then
					指令到达 = self.参战单位[n].指令到达
				end
			end
		end
		常规提示(玩家id, "#Y/你取消了自动战斗")
		玩家数据[真实id].角色.自动战斗 = nil
		发送数据(玩家数据[玩家id].连接id, 5514, 更改内容)
		发送数据(玩家数据[玩家id].连接id,5513.5,{false,编号=更改内容[1].id})
		if self.回合进程 == "命令回合" then
			if 指令到达 ~= self.回合数 then
				local 编号 = self:取参战编号(玩家id, "角色")
				local 目标 = {编号}
				if self.单挑模式 then
					-- self.执行等待 = self.执行等待 + 10
					local bbbh = self.参战单位[编号].单挑宝宝统计
					for i=1,#bbbh do
						if self.参战单位[bbbh[i].bbid] and self.参战单位[bbbh[i].bbid].气血 > 0 and not self.参战单位[bbbh[i].bbid].逃跑 then
							目标[#目标+1]=bbbh[i].bbid
						end
					end

					for i = 1, #目标 do
						self.参战单位[目标[i]].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = "", 编号 = 目标[i]}
					end
					if #目标 >1 then --表示有宝宝存在的情况
						if #目标==2 then
							发送数据(玩家数据[玩家id].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={玩家id,玩家id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令}})
						elseif #目标==3 then
							发送数据(玩家数据[玩家id].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={玩家id,玩家id,玩家id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能, zdjn3 = self.参战单位[目标[3]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令,self.参战单位[目标[3]].自动指令}})
						elseif #目标==4 then
							发送数据(玩家数据[玩家id].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={玩家id,玩家id,玩家id,玩家id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能, zdjn3 = self.参战单位[目标[3]].主动技能, zdjn4 = self.参战单位[目标[4]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令,self.参战单位[目标[3]].自动指令,self.参战单位[目标[4]].自动指令}})
						elseif #目标==5 then
							发送数据(玩家数据[玩家id].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={玩家id,玩家id,玩家id,玩家id,玩家id}, zdjn1 = self.参战单位[编号].主动技能, zdjn2 = self.参战单位[目标[2]].主动技能, zdjn3 = self.参战单位[目标[3]].主动技能, zdjn4 = self.参战单位[目标[4]].主动技能, zdjn5 = self.参战单位[目标[5]].主动技能,zdzl={self.参战单位[编号].自动指令,self.参战单位[目标[2]].自动指令,self.参战单位[目标[3]].自动指令,self.参战单位[目标[4]].自动指令,self.参战单位[目标[5]].自动指令}})
						end
					else
						发送数据(玩家数据[玩家id].连接id, 5503, {助战数量 = #self.参战玩家 - self.助战数量,回合数 = self.回合数, zccz={},mb = 目标,id={玩家id}, zdjn1 = self.参战单位[编号].主动技能,zdzl={self.参战单位[编号].自动指令}})
					end
				else
					if self.参战单位[编号].召唤兽 ~= nil and self.参战单位[self.参战单位[编号].召唤兽].气血 > 0 and not self.参战单位[self.参战单位[编号].召唤兽].逃跑 then
						目标[2] = self.参战单位[编号].召唤兽
					end
					if self.参战单位[目标[2]]~=nil and self.参战单位[目标[2]].超级敏捷~=nil and self.参战单位[目标[2]].超级敏捷.概率 ~= 0 and 取随机数(1,100) <= self.参战单位[目标[2]].超级敏捷.概率+0 then --超级敏捷概率，初始5
						self.参战单位[目标[2]].超级敏捷.触发=1
					end
					if self.参战单位[编号].助战表 then
						for i=1,#self.参战单位[编号].助战表 do
							目标[#目标+1] = self.参战单位[编号].助战表[i]
							if self.参战单位[self.参战单位[编号].助战表[i]].召唤兽~=nil then
								目标[#目标+1]=self.参战单位[self.参战单位[编号].助战表[i]].召唤兽
								if self.参战单位[目标[#目标]]~=nil and self.参战单位[目标[#目标]].超级敏捷~=nil and self.参战单位[目标[#目标]].超级敏捷.概率 ~= 0 and 取随机数(1,100) <= self.参战单位[目标[#目标]].超级敏捷.概率+0 then --超级敏捷概率，初始5
									self.参战单位[目标[#目标]].超级敏捷.触发=1
								end

							end
						end
					end
					local 发送信息 = {助战数量 = #self.参战玩家 - self.助战数量,mb = 目标,id={},zdzl={},zccz={}}

					for i = 1, #目标 do
						self.参战单位[目标[i]].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = "", 编号 = 目标[i]}
						发送信息["zdjn"..i] = self.参战单位[目标[i]].主动技能
						发送信息.zdzl[i] = self.参战单位[目标[i]].自动指令
						发送信息.id[i] =self.参战单位[目标[i]].玩家id
						if self.参战单位[目标[i]].超级敏捷 and self.参战单位[目标[i]].超级敏捷.触发 == 1 then
							发送信息.zccz[i] = self.参战单位[目标[i]].超级敏捷.触发
							self.参战单位[目标[i]].超级敏捷.触发 = 0
						end
						发送信息.回合数 = self.回合数
					end
					发送数据(玩家数据[玩家id].连接id, 5503,发送信息)
				end
			end
		end
	else
		玩家数据[真实id].角色.自动战斗 = true
		local 更改=false
		for n = 1, #self.参战单位 do
			if self.参战单位[n].玩家id == 真实id then
				self.参战单位[n].自动战斗 = true
				更改=true
				if self.参战单位[n].类型=="角色" then
					if 玩家数据[真实id].角色.自动指令~=nil then
						-- if  玩家数据[真实id].角色.自动指令.参数 and type(玩家数据[真实id].角色.自动指令.参数)=="table" then
						-- 	玩家数据[真实id].角色.自动指令.参数=玩家数据[真实id].角色.自动指令.参数[1][1]
						--     end
	                  	self.参战单位[n].自动指令=table.loadstring(table.tostring(玩家数据[真实id].角色.自动指令))
	                  	local 存在 = false
	                  	if self.参战单位[n].如意神通 then
							for i = 1,#self.参战单位[n].如意神通 do
								if self.参战单位[n].如意神通[i] == self.参战单位[n].自动指令.参数 then
									存在 = true
								end
							end
						end
						if 存在 then
							self.参战单位[n].自动指令 = nil
						end
	              	end
				    if self.参战单位[n].自动指令~=nil then
				   --  	if  self.参战单位[n].自动指令.参数 and type(self.参战单位[n].自动指令.参数)=="table" then
							-- self.参战单位[n].自动指令.参数=self.参战单位[n].自动指令.参数[1][1]
						 --    end
						self.参战单位[n].指令=table.loadstring(table.tostring(self.参战单位[n].自动指令))
						local 临时技能 = 取法术技能(self.参战单位[n].指令.参数)
						if 临时技能[3] == 4 then
							local 类型 = skill:取技能类型(self.参战单位[n].指令.参数)
							if 类型 == "法攻技能" then
								self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"法术")
							else
								self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
							end
						elseif self.参战单位[n].指令.类型=="攻击" then
							self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
						else
							self.参战单位[n].指令.目标 = self:取单个友方目标(n)
						end
					else
						self.参战单位[n].自动指令={}
						self.参战单位[n].自动指令.参数=""
						self.参战单位[n].自动指令.类型="攻击"
						self.参战单位[n].指令={}
						self.参战单位[n].指令.类型="攻击"
						self.参战单位[n].指令.目标= self:取单个敌方目标(n,"物理")
					end
					if self.参战单位[n] and self.参战单位[n].智能施法 then
						智能施法(self,n)
					end
				elseif self.参战单位[n].类型=="bb" then
					local 编号 =  玩家数据[真实id].召唤兽:取编号(self.参战单位[n].认证码 or 玩家数据[真实id].角色.参战宝宝.认证码)
					if 玩家数据[真实id].召唤兽.数据[编号] and 玩家数据[真实id].召唤兽.数据[编号].自动指令 ~= nil and 玩家数据[真实id].召唤兽.数据[编号].自动指令.类型 == "法术" and 取指定召唤兽技能(玩家数据[真实id].召唤兽.数据[编号].技能,玩家数据[真实id].召唤兽.数据[编号].自动指令.参数) == false then
						玩家数据[真实id].召唤兽.数据[编号].自动指令 = nil
					end
					if 编号 == 0 or 玩家数据[真实id].召唤兽.数据[编号].自动指令 == nil then
						self.参战单位[n].自动指令={}
						self.参战单位[n].自动指令.参数=""
						self.参战单位[n].自动指令.类型="攻击"
						self.参战单位[n].指令={}
						self.参战单位[n].指令.类型="攻击"
						self.参战单位[n].指令.目标= self:取单个敌方目标(n,"物理")
					else
						self.参战单位[n].自动指令=table.loadstring(table.tostring(玩家数据[真实id].召唤兽.数据[编号].自动指令))
						self.参战单位[n].指令=table.loadstring(table.tostring(玩家数据[真实id].召唤兽.数据[编号].自动指令))
						local 临时技能 = 取法术技能(self.参战单位[n].指令.参数)
						if 临时技能[3] == 4 then
							local 类型 = skill:取技能类型(self.参战单位[n].指令.参数)
							if 类型 == "法攻技能" then
								self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"法术")
							else
								self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
							end
						elseif self.参战单位[n].指令.类型=="攻击" then
							self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"物理")
						else
							self.参战单位[n].指令.目标 = self:取单个友方目标(n)
						end
					end
				end
				self.参战单位[n].指令.下达=true
				更改内容[#更改内容 + 1] = {id = n, 自动 = self.参战单位[n].自动战斗}
				指令内容[#指令内容 + 1] = {id = n, 自动 = self.参战单位[n].自动指令}
			end
		end
		常规提示(玩家id, "#Y/你开启了自动战斗")
		if self.回合进程 == "命令回合" then
			-- 发送数据(玩家数据[玩家id].连接id, 5511,{true})
		end
		发送数据(玩家数据[玩家id].连接id, 5513, 指令内容)
		发送数据(玩家数据[玩家id].连接id, 5514, 更改内容)
		发送数据(玩家数据[玩家id].连接id,5513.5,{true,编号=更改内容[1].id})
		if 更改 and self.回合进程=="命令回合" then
			self.加载数量=self.加载数量-1
			if self.加载数量<=0 then
				self.回合进程="计算回合"
				self:设置执行回合()
			end
		end
	end
end
function 战斗处理类:数据处理(玩家id, 序号, 内容, 参数)
	if 序号 == 5506 then
		self:逃跑事件处理(玩家id)
		return
	end

	if 序号 == 5511 then
		self:抓取自动数据(玩家id)
	elseif 序号 == 5513 then --设置智能施法
		local 编号 = 内容.编号
		if self.参战单位[编号] and self.参战单位[编号].类型 == "角色" then
			local id = self.参战单位[编号].玩家id
			if 玩家数据[id].角色.智能施法 then
				self.参战单位[编号].智能施法 = false
				玩家数据[id].角色.智能施法 = false
				常规提示(玩家id,"#Y/你取消了"..玩家数据[id].角色.名称.."的智能施法")
				if not self.参战单位[编号].助战 then
					发送数据(玩家数据[玩家id].连接id,5513.7,{开关=false})
				end
				发送数据(玩家数据[玩家id].连接id,5513.8,{false,编号=编号})
			else
				self.参战单位[编号].智能施法 = true
				玩家数据[id].角色.智能施法 = true
				常规提示(玩家id,"#Y/你开启了"..玩家数据[id].角色.名称.."的智能施法")
				if not self.参战单位[编号].助战 then
					发送数据(玩家数据[玩家id].连接id,5513.7,{开关=true})
				end
				发送数据(玩家数据[玩家id].连接id,5513.8,{true,编号=编号})
			end
		end
	end

	if 序号 == 5512 then
		local 编号 = 内容.目标
		local 参数 = 内容.参数
		local 重复
		local 修改 = {}
		if self.参战单位[编号] then
			for i=1,#self.参战单位 do
				if self.参战单位[i].标记 == 参数 and self.参战单位[i].队伍 == self.参战单位[编号].队伍 then
					self.参战单位[i].标记 = nil
					self.参战单位[编号].标记 = 参数
					修改[#修改+1] = {编号=i,标记=nil}
					修改[#修改+1] = {编号=编号,标记=参数}
					重复 = true
				end
			end
			if not 重复 then
				self.参战单位[编号].标记 = 参数
				修改[#修改+1] = {编号=编号,标记=参数}
			end
		end
		for n = 1, #self.参战玩家 do
			if not self.参战玩家[n].助战  then
				发送数据(玩家数据[self.参战玩家[n].id].连接id,5520,修改)
			end
		end
	end

	if 序号 == 5601 then --设置自动集火
		local 编号 = 内容.编号
		if self.参战单位[编号] and self.参战单位[编号].类型 == "角色" then
			local id = self.参战单位[编号].玩家id
			if 玩家数据[id].角色.自动集火 then
				self.参战单位[编号].自动集火 = false
				玩家数据[id].角色.自动集火 = false
				常规提示(玩家id,"#Y/你关闭了自动集火")
			else
				self.参战单位[编号].自动集火 = true
				玩家数据[id].角色.自动集火 = true
				常规提示(玩家id,"#Y/你开启了自动集火")
				self:刷新自动集火目标(编号)
			end
			发送数据(玩家数据[玩家id].连接id,5601,{开关=self.参战单位[编号].自动集火,编号=编号})
		end
	end

	if 序号 == 5520 then
		for n = 1, #self.观战玩家 do
			if self.观战玩家[n].id == 玩家id then
				发送数据(self.观战玩家[n].连接id, 5505)
				玩家数据[self.观战玩家[n].id].zhandou = 0
				玩家数据[self.观战玩家[n].id].guanzhan = 0
				玩家数据[self.观战玩家[n].id].角色.战斗开关 = false
				地图处理类:设置战斗开关(self.观战玩家[n].id, false)
				观战记录 = nil

				table.remove(self.观战玩家, n)
				return
			end
		end
	elseif 序号 == 5522 then
		local 更改内容 = {}
		local 指令内容 = {}
		for n = 1, #self.参战单位 do
			if self.参战单位[n].玩家id == 玩家id then
				更改内容[#更改内容 + 1] = {id = n, 自动 = self.参战单位[n].自动战斗}
				指令内容[#指令内容 + 1] = {id = n, 自动 = self.参战单位[n].自动指令}
			end
		end
		发送数据(玩家数据[玩家id].连接id, 5513, 指令内容)
		发送数据(玩家数据[玩家id].连接id, 5514, 更改内容)
		发送数据(玩家数据[玩家id].连接id, 5522)
	end

	if self.回合进程 == "加载回合" then
		if 序号 == 5501 then
			self.加载数量 = self.加载数量 - 1
			if self.战斗流程 ~= nil and #self.战斗流程 == 0 then
				self:设置命令回合()
			else
				self:发送加载流程()
			end
		end
	elseif self.回合进程 == "命令回合" then
		if 序号 == 5502 then
			local 临时id, 目标玩家id = nil, 玩家id
			if #内容 > 0 then
				for i, v in ipairs(内容) do
					if v.id then
						临时id = v.id
						break
					end
				end
			end
			local 原始id信息 = string.format("临时id=%s, 玩家id=%s", tostring(临时id), tostring(目标玩家id))
			local 编号 = self:取参战编号(临时id or 目标玩家id, "角色")
			if not 编号 or not self.参战单位[编号] then
				print(string.format("[错误] 找不到参战单位，%s，编号=%s", 原始id信息, tostring(编号)))
				return
			end

			-- 处理奇袭指令
			if 内容.奇袭指令 then
				for n=1,#内容 do
					if 内容.mb[n] and 内容.奇袭指令[n] and 内容.奇袭指令[n].类型 and self.参战单位[内容.mb[n]] then
						self.参战单位[内容.mb[n]].奇袭指令 = 内容.奇袭指令[n]
					end
				end
			end

			local 目标单位 = self.参战单位[编号]
			if 目标单位.指令到达 == self.回合数 then
				print(string.format("[警告] 单位重复处理指令，%s，单位编号=%d，当前回合=%d", 原始id信息, 编号, self.回合数))
				return
			end

			for n, v in pairs(内容.mb or {}) do
				local 单位编号 = 内容.mb[n]
				local 当前单位 = self.参战单位[单位编号]

				if not 当前单位 then
					print(string.format("[错误] 指令目标单位无效，mb[%d]=%d，%s", n, 单位编号, 原始id信息))
					goto continue
				end

				if 当前单位.自动战斗 or (当前单位.指令 and 当前单位.指令.下达) then
					goto continue
				end

				当前单位.指令到达 = self.回合数
				当前单位.指令 = 内容[n] or 当前单位.指令 or {}

				-- 处理九黎城多次操作
				if 内容[n].多次操作 ~= nil and self.参战单位[单位编号].多次操作 ~= nil then
					for an=1,#内容[n].多次操作 do
						if 内容[n].多次操作[an] ~= nil and self.参战单位[单位编号].多次操作[an] ~= nil then
							local czlx = 内容[n].多次操作[an].命令.类型
							if czlx == "法术" or czlx == "攻击" or self.参战单位[单位编号].多次操作[an].超级敏捷 then
								self.参战单位[单位编号].多次操作[an] = 内容[n].多次操作[an]
								self.参战单位[单位编号].多次操作[an].执行 = true
							end
						end
					end
				end

				当前单位.指令.下达 = true

				if 当前单位.类型 == "角色" then
					self.加载数量 = self.加载数量 - 1
				end

				-- 花果山特殊处理：法术不存在时转为攻击
				if 当前单位.指令.类型 == "法术" and 当前单位.门派 == "花果山" and not self:取是否有技能(单位编号, 当前单位.指令.参数) then
					当前单位.指令.类型 = "攻击"
				end

				-- 自动补全目标（目标为0时）
				if 当前单位.指令.目标 == 0 then
					if 当前单位.指令.类型 == "攻击" then
						当前单位.指令.目标 = self:取单个敌方目标(n, "物理")
					elseif 当前单位.指令.类型 == "法术" then
						当前单位.指令.目标 = self:取单个敌方目标(n, "法术")
						if type(当前单位.指令.参数) == "table" then
							当前单位.指令.参数 = 当前单位.指令.参数[1][1]
						end
						if not self:取角色所有技能是否有(单位编号, 当前单位.指令.参数) then
							当前单位.指令.类型 = "攻击"
						end
					end
				end

				::continue::
			end

			local 断线数量 = 0
			for n = 1, #self.参战玩家 do
				if self.参战玩家[n].断线 then
					断线数量 = 断线数量 + 1
				end
			end

			if self.加载数量 <= 0 or self.加载数量 <= 断线数量 then
				self.回合进程 = "计算回合"
				self:设置执行回合()
			end
		elseif 序号 == 5555 then
			local 发送内容 = {}
			local 编号 = self:取参战编号(玩家id, "角色")
			local bh = 内容.位置

			if 内容.类型 ~= "法术" then
				if 内容.类型 == "道具" then
					local djbh = 内容.参数
					local 名称 = "道具"
					if self.参战单位[编号].道具类型 == "道具" then
						local 道具1 = 玩家数据[玩家id].角色.道具[djbh]
						if 道具1 and 玩家数据[玩家id].道具.数据[道具1] then
							local 道具数据 = table.loadstring(table.tostring(玩家数据[玩家id].道具.数据[道具1]))
							名称 = 道具数据.名称
						end
					elseif self.参战单位[编号].道具类型 == "法宝" then
						local 道具1 = 玩家数据[玩家id].角色.法宝[djbh]
						名称 = 玩家数据[玩家id].道具.数据[道具1].名称
					end
					发送内容[bh] = 名称
				else
					发送内容[bh] = 内容.类型
				end
			else
				发送内容[bh] = 内容.参数
			end

			for i=1,#self.参战玩家 do
				if self.参战玩家[i].队伍 == self.参战单位[编号].队伍 and not self.参战玩家[i].助战  then
					发送数据(self.参战玩家[i].连接id,5555,发送内容)
				end
			end
		elseif 序号 == 5504 then
			local 真实id = 内容.真实id or 内容.玩家id
			local 编号 = self:取参战编号(真实id, "角色")
			self.参战单位[编号].道具类型 = "道具"
			发送数据(玩家数据[玩家id].连接id, 5509, 玩家数据[真实id].道具:索要道具2(真实id))

		elseif 序号 == 5504.5 then
			-- 奇袭道具请求
			if 内容.玩家 then
				local 获取数据 = {}
				local 取编号 = tonumber(内容.玩家)
				if 取编号 and self.参战单位[取编号] then
					获取数据.玩家id = self.参战单位[取编号].玩家id
					获取数据.道具 = 玩家数据[self.参战单位[取编号].玩家id].道具:索要道具2(self.参战单位[取编号].玩家id)
					发送数据(玩家数据[玩家id].连接id, 5509.5, 获取数据)
				end
			end
		-- elseif 序号 == 5504.5 then
		-- 	-- 奇袭道具请求
		-- 	local 获取数据 = {}
		-- 	local 真实id = 内容.真实id
		-- 	if 真实id then
		-- 		local 编号 = self:取参战编号(真实id, "角色")
		-- 		if 编号 and self.参战单位[编号] then
		-- 			获取数据.玩家id = 真实id
		-- 			获取数据.道具 = 玩家数据[真实id].道具:索要道具2(真实id)
		-- 			发送数据(玩家数据[玩家id].连接id, 5509.5, 获取数据)
		-- 			print("奇袭道具请求，真实id:", 真实id)
		-- 		else
		-- 			print("找不到参战单位，真实id:", 真实id)
		-- 		end
		-- 	else
		-- 		print("缺少真实id参数")
		-- 	end


		elseif 序号 == 5505 then
			local 编号 = 0
			local 真实id = 内容.真实id or 内容.玩家id
			for n = 1, #self.参战单位 do
				if self.参战单位[n].类型 == "角色" and self.参战单位[n].玩家id == 真实id then
					编号 = n
					break
				end
			end
			if 编号 == 0 then
				return
			end

			-- 加位置
			local 发送数据表 = {玩家数据[真实id].召唤兽.数据, self.参战单位[编号].召唤数量}
			if 内容.位置 ~= nil then
				发送数据表.位置 = 内容.位置
			end

			if #self.参战单位[编号].召唤数量 > 1 then
				发送数据(玩家数据[玩家id].连接id, 5510, 发送数据表)
			else
				发送数据(玩家数据[玩家id].连接id, 5510, 发送数据表)
			end

		elseif 序号 == 5507 then
			local 编号 = 内容.编号
			local 真实id = 玩家id
			if self.参战单位[编号] and self.参战单位[编号].类型 == "角色" then
				self:更改自动(self.参战单位[编号].玩家id, 真实id)
			end
		elseif 序号 == 5508 then
			local 真实id = 内容.真实id or 内容.玩家id
			local 编号 = self:取参战编号(真实id, "角色")
			self.参战单位[编号].道具类型 = "法宝"
			发送数据(玩家数据[玩家id].连接id, 5523, 玩家数据[真实id].道具:索要法宝1(真实id, self.回合数))
		elseif 序号 == 5519 then
			local 真实id = 内容.真实id or 内容.玩家id
			local 编号 = self:取参战编号(真实id, "角色")
			self.参战单位[编号].道具类型 = "灵宝"
			if self.参战单位[编号].法术状态.相思寒针 then
				常规提示(玩家id, "当前处于#R相思寒针#Y状态无法使用灵宝")
				return
			end
			发送数据(玩家数据[玩家id].连接id, 5519, {灵元 = self.参战单位[编号].灵元, 灵宝佩戴 = 玩家数据[真实id].道具:索要灵宝佩戴(真实id)})
		elseif 序号 == 5599 then
			local 获取数据 = {}
			local 取编号 = self:取参战编号(玩家id, "角色")
			if 内容.玩家 ~= nil then
				内容.玩家 = tonumber(内容.玩家)
				取编号 = 内容.玩家
			end
			获取数据.玩家id = self.参战单位[取编号].玩家id
			获取数据.道具 = 玩家数据[self.参战单位[取编号].玩家id].道具:索要道具2(self.参战单位[取编号].玩家id)
			发送数据(玩家数据[玩家id].连接id, 5509, 获取数据)
			self.参战单位[取编号].道具类型 = "道具"
		end
	elseif self.回合进程 == "执行回合" then
		if 序号 == 5503 then
			local 认证字段 = 内容.战斗id..self.回合数
			local 被认证字段 = self.战斗id..self.回合数
			if 内容.战斗id ~= self.战斗id then
				发送公告("#S《外挂检测》#W名称：#R"..玩家数据[玩家id].角色.名称.."#W；ID：#R"..玩家id.."#W涉嫌使用外挂脚本，请大家相互监督，举报有奖！")
				广播消息({内容="#S《外挂检测》#W名称：#R"..玩家数据[玩家id].角色.名称.."#W；ID：#R"..玩家id.."#W涉嫌使用外挂脚本，请大家相互监督，举报有奖！",频道="gm"})
				print(内容.战斗id, self.战斗id)
				self:强制结束战斗()
				return
			end

			self.加载数量 = self.加载数量 - 1
			self.执行等待 = os.time() + 10
			local 断线数量 = 0
			for n = 1, #self.参战玩家 do
				if self.参战玩家[n].断线等待 then
					断线数量 = 断线数量 + 1
				end
			end
			if self.加载数量 - self.助战数量 <= 断线数量 and self.回合进程 ~= "结束回合" then
				self.回合进程 = "结束回合"
				self:回合结束处理()
			end
		elseif 序号 == 5507 then
			local 编号 = 内容.编号
			local 真实id = 玩家id
			if self.参战单位[编号] and self.参战单位[编号].类型 == "角色" then
				self:更改自动(self.参战单位[编号].玩家id, 真实id)
			end
		end
	end
end
-- function 战斗处理类:数据处理(玩家id, 序号, 内容, 参数)
-- 	-- print(序号,内容,参数,self.回合进程)
-- 	-- if  序号==5503 and self.回合进程~="执行回合"  then
-- 	    -- print(玩家id.."疑似使用快速战斗挂，已踢出战斗！")
-- 	    -- self:比武强制结束战斗()
-- 	    -- 发送数据(玩家数据[玩家id].连接id,998,"请不要使用外挂，多次使用外挂会永久封禁账号！")
-- 	    -- return
-- 	-- end
-- 	if 序号 == 5506 then
-- 		self:逃跑事件处理(玩家id)
-- 		return
-- 	end
-- 	if 序号==5511 then
-- 		self:抓取自动数据(玩家id)
-- 	elseif 序号==5513 then --设置智能施法
-- 	    local 编号 = 内容.编号
-- 	    if self.参战单位[编号] and self.参战单位[编号].类型=="角色" then
-- 			local id = self.参战单位[编号].玩家id
-- 			if 玩家数据[id].角色.智能施法 then
-- 				self.参战单位[编号].智能施法=false
-- 				玩家数据[id].角色.智能施法=false
-- 				常规提示(玩家id,"#Y/你取消了"..玩家数据[id].角色.名称.."的智能施法")
-- 				if not self.参战单位[编号].助战 then
-- 					发送数据(玩家数据[玩家id].连接id,5513.7,{开关=false})
-- 				end
-- 				发送数据(玩家数据[玩家id].连接id,5513.8,{false,编号=编号})
-- 			else
-- 				self.参战单位[编号].智能施法=true
-- 				玩家数据[id].角色.智能施法=true
-- 				常规提示(玩家id,"#Y/你开启了"..玩家数据[id].角色.名称.."的智能施法")
-- 				if not self.参战单位[编号].助战 then
-- 					发送数据(玩家数据[玩家id].连接id,5513.7,{开关=true})
-- 				end
-- 				发送数据(玩家数据[玩家id].连接id,5513.8,{true,编号=编号})
-- 			end
-- 	    end
-- 	end
-- 	if 序号==5512 then
-- 		local 编号 = 内容.目标
-- 		local 参数 = 内容.参数
-- 		local 重复
-- 		local 修改 = {}
-- 		if self.参战单位[编号] then
-- 			for i=1,#self.参战单位 do
-- 				if self.参战单位[i].标记 == 参数 and self.参战单位[i].队伍 == self.参战单位[编号].队伍 then
-- 					self.参战单位[i].标记 = nil
-- 					self.参战单位[编号].标记 = 参数
-- 					修改[#修改+1] = {编号=i,标记=nil}
-- 					修改[#修改+1] = {编号=编号,标记=参数}
-- 					重复=true
-- 				end
-- 			end
-- 			if not 重复 then
-- 				self.参战单位[编号].标记 = 参数
-- 				修改[#修改+1] = {编号=编号,标记=参数}
-- 			end
-- 		end
-- 		for n = 1, #self.参战玩家 do
-- 	    		if not self.参战玩家[n].助战  then
-- 				发送数据(玩家数据[self.参战玩家[n].id].连接id,5520,修改)
-- 			end
-- 		end
-- 	end
-- 	if 序号 == 5520 then
-- 		for n = 1, #self.观战玩家 do
-- 			if self.观战玩家[n].id == 玩家id then
-- 				发送数据(self.观战玩家[n].连接id, 5505)
-- 				玩家数据[self.观战玩家[n].id].zhandou = 0
-- 				玩家数据[self.观战玩家[n].id].guanzhan = 0
-- 				玩家数据[self.观战玩家[n].id].角色.战斗开关 = false
-- 				地图处理类:设置战斗开关(self.观战玩家[n].id, false)
-- 				观战记录 = nil

-- 				table.remove(self.观战玩家, n)
-- 				return
-- 			end
-- 		end
-- 	-- elseif 序号 == 5521 then
-- 	--  for n = 1, #self.参战玩家 do
-- 	--      if self.参战玩家[n].id == 玩家id and self.参战玩家[n].队伍 == 玩家id  then
-- 	--          if 队伍数据[self.参战玩家[n].队伍] then
-- 	--              local fhz = true
-- 	--              队伍数据[self.参战玩家[n].队伍].队长控制 = true
-- 	--              if self.参战玩家[n].队长控制 then
-- 	--                  fhz = nil
-- 	--                  队伍数据[self.参战玩家[n].队伍].队长控制 = false
-- 	--              end
-- 	--              for i=1,#self.参战玩家 do
-- 	--                  if self.参战玩家[n].队伍 == self.参战玩家[i].队伍 then
-- 	--                      self.参战玩家[i].队长控制 = fhz
-- 	--                      self:更改自动(self.参战玩家[i].id,true)
-- 	--                  end
-- 	--              end
-- 	--              local 编号 = self:取参战编号(玩家id, "角色")
-- 	--              发送数据(玩家数据[玩家id].连接id, 5521, {开关=fhz,id=编号})
-- 	--          end
-- 	--      end
-- 	--  end
-- 	elseif 序号 == 5522 then
-- 		local 更改内容 = {}
-- 		local 指令内容 = {}
-- 		for n = 1, #self.参战单位 do
-- 			if self.参战单位[n].玩家id == 玩家id then
-- 				更改内容[#更改内容 + 1] = {id = n, 自动 = self.参战单位[n].自动战斗}
-- 				指令内容[#指令内容 + 1] = {id = n, 自动 = self.参战单位[n].自动指令}
-- 			end
-- 		end
-- 		发送数据(玩家数据[玩家id].连接id, 5513, 指令内容)
-- 		发送数据(玩家数据[玩家id].连接id, 5514, 更改内容)
-- 		-- if 队伍数据[玩家数据[玩家id].队伍] then
-- 		--  发送数据(玩家数据[玩家id].连接id, 5521, {开关=队伍数据[玩家数据[玩家id].队伍].队长控制})
-- 		-- end
-- 		发送数据(玩家数据[玩家id].连接id, 5522)
-- 	end
-- 	if self.回合进程 == "加载回合" then
-- 		if 序号 == 5501 then
-- 			self.加载数量 = self.加载数量 - 1
-- 			if self.战斗流程 ~= nil and #self.战斗流程 == 0 then
-- 				self:设置命令回合()
-- 			else
-- 				self:发送加载流程()
-- 			end
-- 		end
-- 	elseif self.回合进程 == "命令回合" then--角色命令发送 服务端接收 --这里才是命令的内容
-- 		-- if 序号 == 5502 then----------原
-- 		-- 	local 临时id
-- 		-- 	if #内容 > 0 then
-- 		-- 		for i,v in ipairs(内容) do
-- 		-- 			if v.id then
-- 		-- 				临时id = v.id
-- 		-- 			end
-- 		-- 		end
-- 		-- 	end
-- 		-- 	--table.print(内容)
-- 		-- 	local 编号 = self:取参战编号(临时id or 玩家id, "角色")

-- 		-- 	if self.参战单位[编号] == nil or self.参战单位[编号].指令到达 == self.回合数 then
-- 		-- 		 -- table.print(内容)
-- 		-- 		 print("数据异常，关注："..临时id.." or "..玩家id)
-- 		-- 	    return
-- 		-- 	end

-- 		-- 	编号 = self:取参战编号(玩家id, "角色")

-- 		-- 	for n,v in pairs(内容.mb) do

-- 		-- 		if self.参战单位[内容.mb[n]] and not self.参战单位[内容.mb[n]].自动战斗 and (self.参战单位[内容.mb[n]].指令 == nil or not self.参战单位[内容.mb[n]].指令.下达) then
-- 		-- 			self.参战单位[编号].指令到达 = self.回合数
-- 		-- 			self.参战单位[内容.mb[n]].指令 = 内容[n] or self.参战单位[内容.mb[n]].指令 or {}

-- 		-- 			if 内容[n] and 内容[n].再次操作~=nil then
-- 		-- 				self.参战单位[内容.mb[n]].超级敏捷.执行=true
-- 		-- 				self.参战单位[内容.mb[n]].超级敏捷.指令 = 内容[n].再次操作
-- 		-- 			end


-- 		-- 			self.参战单位[内容.mb[n]].指令.下达 = true
-- 		-- 			if self.参战单位[内容.mb[n]].类型=="角色" then
-- 		-- 				self.加载数量=self.加载数量-1
-- 		-- 			end
-- 		-- 			if self.参战单位[内容.mb[n]].指令.类型 == "法术" and self.参战单位[内容.mb[n]].门派 == "花果山" and not self:取是否有技能(内容.mb[n], 内容[n].参数) then
-- 	 --              		self.参战单位[内容.mb[n]].指令.类型 = "攻击"
-- 	 --              	end
-- 		-- 			if self.参战单位[内容.mb[n]].指令.类型=="攻击" and self.参战单位[内容.mb[n]].指令.目标==0 then
-- 	 --              		self.参战单位[内容.mb[n]].指令.目标= self:取单个敌方目标(n,"物理")
-- 	 --              	elseif self.参战单位[内容.mb[n]].指令.类型 == "法术" and self.参战单位[内容.mb[n]].指令.目标 == 0 then
-- 	 --              		self.参战单位[内容.mb[n]].指令.目标 = self:取单个敌方目标(n,"法术")
-- 	 --              		if type(内容[n].参数)=="table" then
-- 	 --              			内容[n].参数=内容[n].参数[1][1]
-- 	 --              		end
-- 		--               	if not self:取角色所有技能是否有(内容.mb[n], 内容[n].参数) then
-- 		--               		self.参战单位[内容.mb[n]].指令.类型 = "攻击"
-- 		--               	end
-- 	 --              	end
-- 		-- 		elseif self.参战单位[内容.mb[n]] == nil then
-- 		--             print("目标错误，目标为"..内容.mb[n].."编号为"..n)
-- 		-- 		end
-- 		-- 	end
-- 		-- 	local 断线数量=0
-- 		-- 	for n=1,#self.参战玩家 do
-- 	 --          	if self.参战玩家[n].断线 then
-- 	 --            	断线数量=断线数量+1
-- 	 --          	end
-- 		-- 	end
-- 		-- if self.加载数量<=0 or self.加载数量 < 断线数量  then
-- 		--             self.回合进程="计算回合"
-- 		--           	self:设置执行回合()
-- 		-- end
-- 		if 序号 == 5502 then--------C改
-- 		        local 临时id, 目标玩家id = nil, 玩家id
-- 		        if #内容 > 0 then
-- 		            for i, v in ipairs(内容) do
-- 		                if v.id then
-- 		                    临时id = v.id
-- 		                    break  -- 取第一个有效id即可
-- 		                end
-- 		            end
-- 		        end
-- 		        local 原始id信息 = string.format("临时id=%s, 玩家id=%s", tostring(临时id), tostring(目标玩家id))
-- 		        local 编号 = self:取参战编号(临时id or 目标玩家id, "角色")
-- 		        if not 编号 or not self.参战单位[编号] then
-- 		            print(string.format("[错误] 找不到参战单位，%s，编号=%s", 原始id信息, tostring(编号)))
-- 		            return
-- 		        end
-- 		        local 目标单位 = self.参战单位[编号]
-- 		        if 目标单位.指令到达 == self.回合数 then
-- 		            print(string.format("[警告] 单位重复处理指令，%s，单位编号=%d，当前回合=%d", 原始id信息, 编号, self.回合数))
-- 		            return
-- 		        end
-- 		        for n, v in pairs(内容.mb or {}) do
-- 		            local 单位编号 = 内容.mb[n]
-- 		            local 当前单位 = self.参战单位[单位编号]
-- 		            -- 跳过无效单位
-- 		            if not 当前单位 then
-- 		                print(string.format("[错误] 指令目标单位无效，mb[%d]=%d，%s", n, 单位编号, 原始id信息))
-- 		                goto continue  -- 跳过当前循环，处理下一个
-- 		            end
-- 		            if 当前单位.自动战斗 or (当前单位.指令 and 当前单位.指令.下达) then
-- 		                goto continue
-- 		            end
-- 		            当前单位.指令到达 = self.回合数
-- 		            当前单位.指令 = 内容[n] or 当前单位.指令 or {}
-- 		            if 内容[n] and 内容[n].再次操作 then
-- 		                当前单位.超级敏捷 = 当前单位.超级敏捷 or {}
-- 		                当前单位.超级敏捷.执行 = true
-- 		                当前单位.超级敏捷.指令 = 内容[n].再次操作
-- 		            end
-- 		            当前单位.指令.下达 = true  -- 标记指令已下达
-- 		            if 当前单位.类型 == "角色" then
-- 		                self.加载数量 = self.加载数量 - 1
-- 		            end
-- 		            -- 花果山特殊处理：法术不存在时转为攻击
-- 		            if 当前单位.指令.类型 == "法术"and 当前单位.门派 == "花果山"and not self:取是否有技能(单位编号, 当前单位.指令.参数) then
-- 		                当前单位.指令.类型 = "攻击"
-- 		            end

-- 		            -- 自动补全目标（目标为0时）
-- 		            if 当前单位.指令.目标 == 0 then
-- 		                if 当前单位.指令.类型 == "攻击" then
-- 		                    当前单位.指令.目标 = self:取单个敌方目标(n, "物理")
-- 		                elseif 当前单位.指令.类型 == "法术" then
-- 		                    当前单位.指令.目标 = self:取单个敌方目标(n, "法术")
-- 		                    -- 处理九黎城多段法术的参数格式
-- 		                    if type(当前单位.指令.参数) == "table" then
-- 		                        当前单位.指令.参数 = 当前单位.指令.参数[1][1]  -- 取第一段法术
-- 		                    end
-- 		                    -- 法术不存在时转为攻击
-- 		                    if not self:取角色所有技能是否有(单位编号, 当前单位.指令.参数) then
-- 		                        当前单位.指令.类型 = "攻击"
-- 		                    end
-- 		                end
-- 		            end
-- 		            ::continue::  -- 循环跳过标记
-- 		        end
-- 		        -- 5. 检查是否所有单位指令处理完成，进入计算回合
-- 		        local 断线数量 = 0
-- 		        for n = 1, #self.参战玩家 do
-- 		            if self.参战玩家[n].断线 then
-- 		                断线数量 = 断线数量 + 1
-- 		            end
-- 		        end
-- 		        -- 所有有效单位指令处理完成（加载数量 <= 断线数量，说明非断线单位已处理完）
-- 		        if self.加载数量 <= 0 or self.加载数量 <= 断线数量 then
-- 		            self.回合进程 = "计算回合"
-- 		            self:设置执行回合()
-- 		        end
-- 		elseif 序号 == 5555 then
-- 			local 发送内容 = {}
-- 			local 编号 = self:取参战编号(玩家id, "角色")
-- 			local bh = 内容.位置
-- 			if 内容.类型~="法术" then
-- 				if 内容.类型=="道具" then
-- 					local djbh = 内容.参数
-- 					local 名称 = "道具"
-- 					if self.参战单位[编号].道具类型=="道具" then
-- 						local 道具1 = 玩家数据[玩家id].角色.道具[djbh]
-- 						if 道具1 and 玩家数据[玩家id].道具.数据[道具1] then
-- 							local 道具数据 = table.loadstring(table.tostring(玩家数据[玩家id].道具.数据[道具1]))
-- 							名称 = 道具数据.名称
-- 						end
-- 					elseif self.参战单位[编号].道具类型=="法宝" then
-- 						local 道具1 = 玩家数据[玩家id].角色.法宝[djbh]
-- 						名称 = 玩家数据[玩家id].道具.数据[道具1].名称
-- 					end
-- 					发送内容[bh]=名称
-- 				else
-- 					发送内容[bh]=内容.类型
-- 				end
-- 			else
-- 				发送内容[bh]=内容.参数
-- 			end

-- 			for i=1,#self.参战玩家 do
-- 				if self.参战玩家[i].队伍==self.参战单位[编号].队伍 and not self.参战玩家[i].助战  then
-- 					发送数据(self.参战玩家[i].连接id,5555,发送内容)  --技能展示
-- 				end
-- 			end
-- 		elseif 序号 == 5504 then
-- 			local 真实id = 内容.真实id or 内容.玩家id
-- 			local 编号 = self:取参战编号(真实id, "角色")
-- 			self.参战单位[编号].道具类型 = "道具"
-- 			发送数据(玩家数据[玩家id].连接id, 5509, 玩家数据[真实id].道具:索要道具2(真实id))
-- 		elseif 序号 == 5508 then
-- 			local 真实id = 内容.真实id or 内容.玩家id
-- 			local 编号 = self:取参战编号(真实id, "角色")
-- 			self.参战单位[编号].道具类型 = "法宝"
-- 			发送数据(玩家数据[玩家id].连接id, 5523, 玩家数据[真实id].道具:索要法宝1(真实id, self.回合数))
-- 		elseif 序号 == 5505 then --取召唤数据
-- 			local 编号 = 0
-- 			local 真实id = 内容.真实id or 内容.玩家id
-- 			for n = 1, #self.参战单位 do
-- 				if self.参战单位[n].类型 == "角色" and self.参战单位[n].玩家id == 真实id then
-- 					编号 = n
-- 					break
-- 				end
-- 			end
-- 			if 编号 == 0 then
-- 				return
-- 			end
-- 			if #self.参战单位[编号].召唤数量 > 1 then
-- 				发送数据(玩家数据[玩家id].连接id, 5510, {玩家数据[真实id].召唤兽.数据, self.参战单位[编号].召唤数量})
-- 			else
-- 				发送数据(玩家数据[玩家id].连接id, 5510, {玩家数据[真实id].召唤兽.数据, self.参战单位[编号].召唤数量})
-- 			end

-- 		elseif 序号 == 5507 then --设置自动战斗
-- 	    	local 编号 = 内容.编号
-- 	    	local 真实id = 玩家id
-- 	    	if self.参战单位[编号] and self.参战单位[编号].类型=="角色" then
-- 	    		self:更改自动(self.参战单位[编号].玩家id,真实id)
-- 		    end
-- 		elseif 序号 == 5519 then
-- 			真实id = 内容.真实id or 内容.玩家id
-- 			local 编号 = self:取参战编号(真实id, "角色")
-- 			self.参战单位[编号].道具类型 = "灵宝"
-- 			if self.参战单位[编号].法术状态.相思寒针 then
-- 				常规提示(玩家id, "当前处于#R相思寒针#Y状态无法使用灵宝")
-- 				return
-- 			end
-- 			发送数据(玩家数据[玩家id].连接id, 5519, {灵元=self.参战单位[编号].灵元,灵宝佩戴=玩家数据[真实id].道具:索要灵宝佩戴(真实id)})
-- 		end
-- 	elseif self.回合进程 == "执行回合" then
-- 		if 序号 == 5503 then
-- 			-- print(内容.战斗id, self.战斗id)
-- 			-- table.print(内容)
-- 			local 认证字段 = 内容.战斗id..self.回合数
-- 			local 被认证字段 = self.战斗id..self.回合数
-- 			if 内容.战斗id ~= self.战斗id then
-- 				发送公告("#S《外挂检测》#W名称：#R"..玩家数据[玩家id].角色.名称.."#W；ID：#R"..玩家id.."#W涉嫌使用外挂脚本，请大家相互监督，举报有奖！")
-- 				广播消息({内容="#S《外挂检测》#W名称：#R"..玩家数据[玩家id].角色.名称.."#W；ID：#R"..玩家id.."#W涉嫌使用外挂脚本，请大家相互监督，举报有奖！",频道="gm"})
-- 				print(内容.战斗id,self.战斗id)
-- 			  	self:强制结束战斗()
-- 			  	return
-- 			end
-- 			self.加载数量 = self.加载数量 - 1
-- 			self.执行等待 = os.time() + 10
-- 			local 断线数量 = 0
-- 			for n = 1, #self.参战玩家 do
-- 				if self.参战玩家[n].断线等待 then
-- 					断线数量 = 断线数量 + 1
-- 				end
-- 			end
-- 			if self.加载数量 - self.助战数量 <= 断线数量 and self.回合进程 ~= "结束回合" then
-- 				self.回合进程 = "结束回合"
-- 				self:回合结束处理()
-- 			end
-- 		elseif 序号 == 5507 then --设置自动战斗
-- 			local 编号 = 内容.编号
-- 			local 真实id =玩家id
-- 			if self.参战单位[编号] and self.参战单位[编号].类型=="角色" then
-- 				self:更改自动(self.参战单位[编号].玩家id,真实id)
-- 			end
-- 		end
-- 	end
-- end

function 战斗处理类:浮云神马加成(编号)
	local num = 0
	local bb = self:取玩家召唤兽(编号)
	if bb~=0 then
		if self.参战单位[bb].浮云神马~=nil then
			if self.参战单位[bb].浮云神马.主人==编号  then
				num = self.参战单位[bb].浮云神马.主人速度
			end
		end
	end
	return num
end
function 战斗处理类:取是否五行相克(五行,五行1)
	if self:取五行相克(五行) == 五行1 then
	  return true
	end
end
function 战斗处理类:取五行相克(五行)
  local 相克="木"
  if 五行=="金" then
	 相克="木"
  elseif 五行=="木" then
	 相克="土"
  elseif 五行=="土" then
	 相克="水"
  elseif 五行=="水" then
	 相克="火"
  elseif 五行=="火" then
	 相克="金"
  end
  return 相克
end

function 战斗处理类:设置执行回合()
	local 临时速度 = {}
	self.执行对象 = {}
	for n = 1, #self.参战单位 do
		local num = 0
		self.参战单位[n].九黎法术列表 = nil--九黎
		if self.参战单位[n].队伍~=0 then
			if self.参战单位[n].洞察 and 取随机数() <= self.参战单位[n].洞察 and self.参战单位[n].主人序号 ~= nil and self.参战单位[self.参战单位[n].主人序号]~=nil then
				local 临时敌人 = self:取单个敌方目标(n)
				local 关键字 = "气血"
				if 取随机数(1,2) == 1 then
					关键字 = "魔法"
				end
				常规提示(self.参战单位[n].玩家id,"#Y/你的召唤兽发现#G/"..self.参战单位[临时敌人].名称.."#Y/当前#G/"..关键字.."#Y/剩余#G/"..self.参战单位[临时敌人][关键字].."点")
			end
			if self.参战单位[n].浮云神马~=nil and self.参战单位[n].气血>0 then
				if self.参战单位[n].类型=="bb" then
					num=self.参战单位[n].浮云神马.bb速度
				else
					num = self:浮云神马加成(n)
				end
			end
			if self.参战单位[n].类型=="角色" then
				if self:取经脉(n, "阴曹地府", "夜行") and 时辰信息.昼夜 == 1 then
					num = num + 40
				end
				if self.参战单位[n].法术状态 and self.参战单位[n].法术状态.其疾如风~=nil and self.参战单位[n].法术状态.其疾如风.回合==1 then
					num = num + 50
				end
			end
		end
		-- local 乱敏 = qz(self.参战单位[n].速度*取随机数(95,105)/100)
		-- 临时速度[n] = {速度 = 乱敏 + num, 编号 = n}
		临时速度[n] = {速度 = self.参战单位[n].速度 + num, 编号 = n}
		if self.参战单位[n].指令 == nil then
			self.参战单位[n].指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}
		end
		if self.参战单位[n].指令.下达 == false then
			self.参战单位[n].指令.下达 = true
			self.参战单位[n].指令.类型 = "攻击"
			self.参战单位[n].指令.目标 = self:取单个敌方目标(n)
		end

---------------------------

        if self.参战单位[n].门派=="九黎城" and 玩家数据[self.参战单位[n].玩家id] and 玩家数据[self.参战单位[n].玩家id].角色.自动战斗 then
			--if self.参战单位[n].指令.参数 == "" then
              --self.参战单位[n].指令.参数 = "三荒尽灭"
            -- end
            		-------------九黎城自动不防御的问题
            self.参战单位[n].指令.目标 = self:取单个敌方目标(n,"法术")
             self.参战单位[n].指令.类型 = "法术"
             if self.参战单位[n].自动指令 and self.参战单位[n].自动指令.类型=="防御" then
             	self.参战单位[n].指令.下达 = true
                 self.参战单位[n].指令.类型 = "防御"
             end
             		-------------九黎城自动不防御的问题
             -- table.print(self.参战单位[n].自动指令)
end

----------------------------
-- if self.参战单位 and self.参战单位[n] and type(self.参战单位[n]) == "table"
--    and self.参战单位[n].门派 == "九黎城" then

--     local 单位 = self.参战单位[n]
--     local 玩家 = 玩家数据[单位.玩家id or 0]

--     -- 检查玩家数据有效性
--     if 玩家 and 玩家.角色 and 玩家.角色.自动战斗 then
--         -- 确保指令表存在（不覆盖原有数据）
--         单位.指令 = 单位.指令 or {}
--         单位.自动指令 = 单位.自动指令 or {}

--         -- 保留原逻辑：仅当参数为空时设置默认技能
--         if not 单位.指令.参数 or tostring(单位.指令.参数) == "" then
--             单位.指令.参数 = "三荒尽灭"
--         end

--         -- 保留原逻辑：设置目标（增加nil保护）
--         local 敌方目标 = self:取单个敌方目标(n, "法术")
--         单位.指令.目标 = 敌方目标 or (单位.指令.目标 or 0)  -- 如果新目标无效则保留旧目标

--         -- 保留原逻辑：设置指令类型
--         单位.指令.类型 = "法术"

--         -- 保留原逻辑：处理防御指令
--         if 单位.自动指令.类型 == "防御" then
--             单位.指令.下达 = true
--             单位.指令.类型 = "防御"
--         end
--     end
-- end
----------





		if self.参战单位[n].门派 == "九黎城" and self.参战单位[n].指令.类型 == "法术" and self.参战单位[n].黎魂 then
		    	临时速度[n] = { 速度 = self.参战单位[n].速度 + num, 编号 = n, 九黎次数 = self.参战单位[n].黎魂 - 1 }
		    	self.参战单位[n].九黎法术列表 = {}
		    	if 玩家数据[self.参战单位[n].玩家id].角色.自动战斗 and self.参战单位[n].指令.类型 == "法术" then---------------------大魔王8.27新
				if self.参战单位[n].黎魂 == 2 then
					 if self.参战单位[n].指令.参数=="三荒尽灭" then
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="三荒尽灭"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="力辟苍穹"}
					 elseif self.参战单位[n].指令.参数=="枫影二刃" then
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="枫影二刃"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="枫影二刃"}
					 elseif self.参战单位[n].指令.参数=="一斧开天" then
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="一斧开天"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="铁血生风"}
					 end
				elseif self.参战单位[n].黎魂 == 3 then
					 if self.参战单位[n].指令.参数=="三荒尽灭" then
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="三荒尽灭"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="三荒尽灭"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="力辟苍穹"}
					 elseif self.参战单位[n].指令.参数=="枫影二刃" then
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="枫影二刃"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="枫影二刃"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="枫影二刃"}
					 elseif self.参战单位[n].指令.参数=="一斧开天" then
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="一斧开天"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="铁血生风"}
					 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] ={[1]="铁血生风"}
					 end
				end
		            elseif type(self.参战单位[n].指令.参数) == "table" then
				for w = 1, math.max(#self.参战单位[n].指令.参数, self.参战单位[n].黎魂) do
					if w <= self.参战单位[n].黎魂 then
						if self.参战单位[n].指令.参数[w] ~= nil then
							self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] = DeepCopy(self.参战单位[n].指令.参数[w])
						-- else
						-- 	self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] = DeepCopy(self.参战单位[n].指令.参数[#self.参战单位[n].指令.参数])
						end
					else
						break
					end
				end
			elseif 九黎城攻击技能[self.参战单位[n].指令.参数] ~= nil then
				for w = 1, self.参战单位[n].黎魂 do
					self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 + 1] = {
						self.参战单位[n].指令.参数,
						self.参战单位[n].指令.目标
					}
				end
			else
				临时速度[n].九黎次数 = nil
			end

			if self:取经脉(n, '九黎城', "飞扬") then
				self.参战单位[n].飞扬生效 = nil
				local aa = {}
				local aa1 = { "力辟苍穹", "三荒尽灭", "三荒尽灭" }

				if #self.参战单位[n].九黎法术列表 >= 3 then
					for w = 1, #self.参战单位[n].九黎法术列表 do
						if self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 - w + 1] == "力辟苍穹" then
							aa = { "力辟苍穹" }
						elseif self.参战单位[n].九黎法术列表[#self.参战单位[n].九黎法术列表 - w + 1] == "三荒尽灭" and #aa > 0 then
							aa[#aa + 1] = "三荒尽灭"
						end
						if #aa == 3 then
							for r = 1, 3 do
								if aa[r] ~= aa1[r] then
									aa = {}
									break
								elseif r == 3 then
									self.参战单位[n].飞扬生效 = 1
								end
							end
						end
						if self.参战单位[n].飞扬生效 ~= nil then
						break
						end
					end
				end
			end
		else
			临时速度[n] = {速度 = self.参战单位[n].速度 + num, 编号 = n}
		end

		-------------九黎城自动不防御的问题

	        if self.参战单位[n].门派=="九黎城" and 玩家数据[self.参战单位[n].玩家id] and 玩家数据[self.参战单位[n].玩家id].角色.自动战斗 then
	             if self.参战单位[n].自动指令 and self.参战单位[n].自动指令.类型=="防御" then
	             	self.参战单位[n].指令.下达 = true
	                 self.参战单位[n].指令.类型 = "防御"
	             end
	end
		-------------九黎城自动不防御的问题
             -- table.print(self.参战单位[n].自动指令)

end
		table.sort(临时速度, function(a, b) return a.速度 > b.速度 end)
	for n = 1, #临时速度 do
	    -- 仅跳过被捕捉或逃跑的单位，死亡单位保留在列表中（执行时再实时判断）
	    if not self.参战单位[临时速度[n].编号].捕捉 and not self.参战单位[临时速度[n].编号].逃跑 then
	        self.执行对象[#self.执行对象 + 1] = 临时速度[n].编号--九黎
	        if 临时速度[n].九黎次数 ~= nil then
	            for w = 1, 临时速度[n].九黎次数 do
	                self.执行对象[#self.执行对象 + 1] = 临时速度[n].编号
	            end
	        end--九黎
	    end
	end
	self.战斗流程 = {}
	self.执行等待 = 0
	self.计算等待 = os.time() + 6000
	战斗执行类:执行计算(self)--全部单位执行完后
	self:结尾动画附加() --我再附加一个动画流程
	self.执行等待 = self.执行等待 + os.time()
	for i = 1, #self.参战玩家 do
		if not self.参战玩家[i].助战  then
			发送数据(self.参战玩家[i].连接id, 5504, self.战斗流程)
			-- 发送数据(self.参战玩家[i].连接id,38,{内容=os.time(),频道="dq"})--延迟测试
		end
	end
	for i = 1, #self.观战玩家 do
		发送数据(self.观战玩家[i].连接id, 5504, self.战斗流程)
	end
	self.加载数量 = #self.参战玩家
	self.执行等待 = os.time() + 10 + #self.战斗流程 * 15
	self.回合进程 = "执行回合"
end

function 战斗处理类:结尾动画附加()
	-- for n=1,#self.执行对象 do
	--  local 编号=self.执行对象[n]
	local 临时异常 = {}
	local 临时增益 = {}
	local 鸣雷诀,鸣雷诀1 = nil,nil
	local 目标1,目标2=nil,nil
	for n = 1, #self.参战单位 do
		if self.参战单位[n] then
			if self.参战单位[n].致命~=nil and self.参战单位[n].气血>0  then
				if self.PK战斗 then
					if self.参战单位[n].气血<self.参战单位[n].最大气血*0.08 then
						local sh = self.参战单位[n].气血+1
						local sw = self:减少气血(n,sh,n,"致命")
						战斗计算:添加掉血(self,n,sh,n)
					end
				else
					if self.参战单位[n].气血<self.参战单位[n].等级*8 then
						local sh = self.参战单位[n].气血+1
						local sw = self:减少气血(n,sh,n,"致命")
						战斗计算:添加掉血(self,n,sh,n)
					end
				end
			end
			if self.参战单位[n].披坚执锐~=nil and #self.参战单位[n].披坚执锐>2 and self.参战单位[n].魔法>=100 and self.参战单位[n].气血>0 then
				if self.回合数/8==qz(self.回合数/8) then --取八的倍数(self.回合数)
					if self.参战单位[n].披坚执锐.昂扬 then
						self:减少魔法(n,100)

						local sjb = self.参战单位[n].披坚执锐
						local 随机1=取随机数(1,#sjb)
						local 随机2=取随机数(1,#sjb)
						for i=1,5 do
							if 随机1==随机2 then
								随机2=取随机数(1,#sjb)
							else
								break
							end
						end
						if self:取经脉(n, "大唐官府", "潜心") then
							self.参战单位[n].潜心={回合=4}
						end
						self.参战单位[n].披坚执锐.可用编号=随机1
						self.参战单位[n].披坚执锐.可选编号=随机2
						发送数据(self.参战单位[n].连接id, 5524, {id=n, 追加法术=self.参战单位[n].披坚执锐})
						self.战斗流程[#self.战斗流程+1]={流程=802,攻击方=n,挨打方=n,技能=self.参战单位[n].披坚执锐[随机1].名称}
					end
				else
					--下面是随机一个 可选的
					local sjb = self.参战单位[n].披坚执锐
					local 随机1=取随机数(1,#sjb)
					for i=1,5 do
						if 随机1==self.参战单位[n].披坚执锐.可用编号 then--随机出来的和可用的一样，继续随机
							随机1=取随机数(1,#sjb)
						else
							break
						end
					end
					self.参战单位[n].披坚执锐.可选编号=随机1
					发送数据(self.参战单位[n].连接id, 5524, {id=n, 追加法术=self.参战单位[n].披坚执锐})
						-- self.战斗流程[#self.战斗流程+1]={流程=802,攻击方=n,挨打方=n,技能=self.参战单位[n].披坚执锐[随机1].名称}
				end
			end
			if self.参战单位[n].无间地狱~=nil then
				self.执行等待 = self.执行等待 + 5
				self.参战单位[n].无间地狱=nil
				self:添加状态("死亡召唤",self.参战单位[n],self.参战单位[n], 11)
				self.参战单位[n].法术状态.死亡召唤.回合 = 3
				self.战斗流程[#self.战斗流程].无间地狱=true
			end
			if self:取全场状态("媚眼如丝") ~= false then
				self.执行等待 = self.执行等待 + 5
				self.战斗流程[#self.战斗流程].媚眼如丝=true
				if self:取目标状态(n,n,1) then
					local 魔法 = self:减少魔法(n,self.参战单位[n].等级)
					local 气血 = qz(魔法*2)
					if 气血 > 0 then
						self:动画加血流程(n,气血)
					end
				end
			end
			if self:取全场状态("清静菩提") ~= false then
				self.执行等待 = self.执行等待 + 5
				local xx = self:取全场状态("清静菩提")
				if 目标1==nil and self.全场状态[xx].队伍==self.参战单位[n].队伍 then

					目标1 = self:取单个敌方目标(n)
				elseif 目标2==nil and self.全场状态[xx].队伍~=self.参战单位[n].队伍 then

					目标2 = self:取单个敌方目标(n)
				end
			end
			if self.参战单位[n].法术状态.鸣雷诀 and 鸣雷诀==nil then
				鸣雷诀 = self:取单个敌方气血最低(n)
				鸣雷诀1 = n
			end
			if self.参战单位[n].法术状态.八戒上身 and self.参战单位[n].法术状态.八戒上身.回合==1 then
				self:取消状态("八戒上身",self.参战单位[n])
				self:还原单位造型(n)
			elseif self.参战单位[n].法术状态.其徐如林 and self.参战单位[n].法术状态.其徐如林.回合==1 then
				self:取消状态("其徐如林",self.参战单位[n])
				if self:NPC_AI取友方被封印数量(n)>=3 then
					for k=1,#self.参战单位 do
						if self.参战单位[k].队伍==self.参战单位[n].队伍 then
							self:解除状态结果(self.参战单位[k], 初始技能计算:取异常状态法术(self.参战单位[k].法术状态))
						end
					end
				end
			end
			if self.参战单位[n].神迹==1 and self.参战单位[n].气血>0 then
				self:解除状态结果(self.参战单位[n], 初始技能计算:取可解除状态(self.参战单位[n].法术状态))
			end
		end
	end
	if self.参战单位[目标1] and self.参战单位[目标2] then
		if 取随机数()<=50 then
			self:解除状态结果(self.参战单位[目标1],初始技能计算:取异常状态法术(self.参战单位[目标1].法术状态))
			self:解除状态结果(self.参战单位[目标2],初始技能计算:取增益状态法术())
		else
			self:解除状态结果(self.参战单位[目标2],初始技能计算:取异常状态法术(self.参战单位[目标2].法术状态))
			self:解除状态结果(self.参战单位[目标1],初始技能计算:取增益状态法术())
		end
		self.执行等待 = self.执行等待 + 3
		self.战斗流程[#self.战斗流程+1]={流程=917,攻击方=目标1,挨打方=目标2}
	end
	if 鸣雷诀~=nil then
		self.执行等待 = self.执行等待 + 3
		local 气血=175*8
		self.战斗流程[#self.战斗流程+1]={流程=919,挨打方=鸣雷诀}
		战斗计算:添加掉血(self,鸣雷诀,气血,鸣雷诀1,"鸣雷诀")
	end

	--天罡星机制
	if self.战斗类型==111127 or self.战斗类型==111130  then
		local go = nil
		for k=1,#self.参战单位 do
			if self.回合数==1 then
			if self.参战单位[k].队伍==0 and self.参战单位[k].气血> 0 then
				if self.参战单位[k].名称=="诡异狂攻" and go~=k then
				self:更改怪物模型(k,k,"进阶狂豹人形",2078,{2,1},nil,nil,变异,"诡异狂攻")
			elseif self.参战单位[k].名称=="诡异诡法" and go~=k then
				self:更改怪物模型(k,k,"进阶混沌兽",2078,{2,1},nil,nil,变异,"诡异诡法")
			elseif self.参战单位[k].名称=="诡异神封" and go~=k then
				self:更改怪物模型(k,k,"进阶雾中仙",2078,{2,1},nil,nil,变异,"诡异神封")
			elseif self.参战单位[k].名称=="诡异长生" and go~=k then
				self:更改怪物模型(k,k,"进阶雨师",2078,{2,1},nil,nil,变异,"诡异长生")
			elseif self.参战单位[k].名称=="诡异铁手" and go~=k then
				self:更改怪物模型(k,k,"进阶猫灵人形",2078,{2,1},nil,nil,变异,"诡异铁手")
			end
				end
			end
		end
			local go = nil
			for k=1,#self.参战单位 do
				if self.回合数/1==qz(self.回合数/1) then
				if self.参战单位[k].队伍==0 and self.参战单位[k].气血>0 then
			if self.参战单位[k].名称=="绝命狂攻" and go~=k then
				self.参战单位[k].伤害=qz(self.参战单位[k].伤害+self.参战单位[k].基础伤害*1.05)
			elseif self.参战单位[k].名称=="绝命诡法" and go~=k then
				self.参战单位[k].法伤=qz(self.参战单位[k].法伤+self.参战单位[k].基础法伤*1.05)
			elseif self.参战单位[k].名称=="绝命铁手" and go~=k then
				self.参战单位[k].伤害=qz(self.参战单位[k].伤害+self.参战单位[k].基础伤害*1.05)
					end
				end
			end
		end
	end

	if self.战斗类型==140000 then --雁塔地宫
		for a=1,#self.参战单位 do
			if self.参战单位[a].队伍==0 then
				if self.参战单位[a].好战的 then
					self.参战单位[a].伤害=qz(self.参战单位[a].伤害+self.参战单位[a].基础伤害*1.05)
					self.参战单位[a].法伤=qz(self.参战单位[a].法伤+self.参战单位[a].基础法伤*1.05)
				end
				if self.参战单位[a].花魁  and self.参战单位[a].气血<=0 then
					for b=1,#self.参战单位 do
						if self.参战单位[a].队伍==self.参战单位[b].队伍 then
							if self.参战单位[b].增伤百分比 == nil then
								self.参战单位[b].增伤百分比 = 0
							end
							self.参战单位[b].增伤百分比=self.参战单位[b].增伤百分比+0.3
						end
					end
					self.参战单位[a].花魁 =nil
				end
				if self.参战单位[a].士卒  and self.参战单位[a].气血>0 then
					for b=1,#self.参战单位 do
						if self.参战单位[a].队伍==self.参战单位[b].队伍 and self.参战单位[b].气血<=0 then
							if self.参战单位[b].增伤百分比 == nil then
								self.参战单位[b].增伤百分比 = 0
							end
							self.参战单位[b].增伤百分比=self.参战单位[b].增伤百分比+0.1
						end
					end
				end
				if self.参战单位[a].酒鬼  and self.参战单位[a].气血>0 then
					self:添加状态("催眠符",self.参战单位[a],self.参战单位[a],11)
				end
			end
		end
	elseif self.战斗类型==180120 or self.战斗类型==180160 then ------------------佬伍修改（增加种族秘境时空之钥）
	if self.回合数 == 2 then
		for k=1,#self.参战单位 do
			if self.参战单位[k].队伍==0 and self.参战单位[k].气血>0 then
				if self.参战单位[k].名称=="观音姐姐"then
					self:更改怪物模型(k,k,"蜃气妖",染色方案,染色组,nil,nil,nil,"观音姐姐")
				    for n = 1, #self.参战玩家 do
						发送数据(self.参战玩家[n].连接id, 5512, {id = k, 文本 = "......准备受死吧。"})
					end
				    self.参战单位[k].伤害=self.参战单位[k].伤害+500
				    self.参战单位[k].法伤=self.参战单位[k].法伤+500
			end
		end
	end
end

elseif self.战斗类型==180121 or self.战斗类型==180161  then --
    local summonedList = {} -- 用于记录已经召唤的单位的索引，以防重复召唤
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.气血<=0 and 单位.鬼魂 ~= nil  and  单位.名称 == "牛魔小妖" and not table.contains(summonedList, 索引) then
            self:流程退场处理({索引}, "召唤战旗")
            if 单位.名称 == "牛魔小妖" then
            self:执行怪物召唤1("牛魔小妖", 10, 0, 1)
            end
            self:取消所有状态(索引)
            table.insert(summonedList, 索引)
        end
    end
-- elseif self.战斗类型 == 180046 or self.战斗类型 == 180161 then
--     local summonedList = {} -- 用于记录已经召唤的单位的索引，以防重复召唤
--     for 索引, 单位 in ipairs(self.参战单位) do
--         if 单位.气血<=15000  and  单位.名称 == "蚩尤魔影" and not table.contains(summonedList, 索引) then
--             self:流程退场处理({索引}, "召唤战旗")
--             if 单位.名称 == "蚩尤魔影"and 单位.气血> 0 then
--             self:执行怪物召唤1("蚩尤魔影", 3, 0, 1)
--             end
--             self:取消所有状态(索引)
--             table.insert(summonedList, 索引)
--         end
--     end
		----------佬伍修改（完善时空之钥）
elseif self.战斗类型 == 180046 or self.战斗类型 == 180161 then
    local summonedList = {} -- 用于记录已经召唤的单位的索引，以防重复召唤
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.名称 == "蚩尤魔影" and 单位.气血 <= 15000 and 单位.气血 > 0 and not summonedList[索引] then
            self:流程退场处理({索引}, "召唤战旗")
            self:执行怪物召唤1("蚩尤魔影", 3, 0, 1)
            self:取消所有状态(索引)
            summonedList[索引] = true -- 使用哈希表代替table.contains更高效
        end
    end
    		----------佬伍修改（完善时空之钥）
elseif self.战斗类型 == 180116 then
        	local 退场单位列表 = {}
        	for 编号, 单位数据 in pairs(self.参战单位) do
            	if (单位数据.名称 == "阴森巢穴" or 单位数据.名称 == "赤血母蛛" or 单位数据.名称 == "蛛卵") and 单位数据.气血<=0 and 单位数据.鬼魂 ~= nil then
                	table.insert(退场单位列表, 编号)
            	end
        	end
        	if #退场单位列表 > 0 then
        		self:取消所有状态(退场单位列表)
            	self:流程多名退场处理(退场单位列表, "召唤战旗")
        		end
        		for a=1,#self.参战单位 do
        		if self.参战单位[a].名称 == "阴森巢穴"then
            	 self:执行怪物召唤(a, 33, 0, 3)
        		elseif self.参战单位[a].名称 == "赤血母蛛"then
            	 self:执行怪物召唤(a, 34, 0, 2)
            	 self:执行怪物召唤(a, 35, 0, 1)
        		elseif self.参战单位[a].名称 == "蛛卵"then
            	 self:执行怪物召唤(a, 35, 0, 1)
                end
               end

elseif self.战斗类型 == 180067 or self.战斗类型 == 180161 then
        if self.回合数 % 2 == 0 then
            for a = 1, #self.参战单位 do
                if self.参战单位[a].名称 == "杨戬" and self:取阵营数量(0) <= 10 then
                    self:执行怪物召唤(a, 40, 0, 1)
                end
            end
        end
elseif self.战斗类型 == 180100 or self.战斗类型 == 180161 then
    for a = 1, #self.参战单位 do
        if self.参战单位[a].名称 == "迷阵宝珠" and self.参战单位[a].气血 <= 0 and self.参战单位[a].鬼魂 ~= nil then
            if self.参战单位[a].名称 == "幻光" or self.参战单位[a].名称 == "幻象" then
                local 防御数值 = self.参战单位[a].防御 - 1500
                if 防御数值 < 0 then
                    防御数值 = 0
                end
                self.参战单位[a].防御 = 防御数值
                local 法防数值 = self.参战单位[a].法防 - 1500
                if 法防数值 < 0 then
                    法防数值 = 0
                end
                self.参战单位[a].法防 = 法防数值
            end
        end
    end
elseif self.战斗类型 == 180111 or self.战斗类型 == 180161 then
	if self.回合数 == 1 then
    for a = 1, #self.参战单位 do
    	    if self.参战单位[a].名称 == "青毛狮子王" or self.参战单位[a].名称 == "兽毛妙法" or self.参战单位[a].名称=="魔猪战将" then
    	    self.参战单位[a].伤害 = self.参战单位[a].伤害 + 1000
            self:添加状态("狂暴（怒）",self.参战单位[a],self.参战单位[a],self.参战单位[a].等级)
        end
    end
	elseif self.回合数 == 5 then
    for a = 1, #self.参战单位 do
    	    if self.参战单位[a].名称 == "青毛狮子王" or self.参战单位[a].名称 == "兽毛妙法" or self.参战单位[a].名称=="魔猪战将" then
    	    self.参战单位[a].伤害 = self.参战单位[a].伤害 - 1000
        end
    end
  end
elseif self.战斗类型 == 180099 or self.战斗类型 == 180160  then
        if self.回合数 == 1 then
            for a = 1, #self.参战单位 do
                if self.参战单位[a].名称 == "女国迷阵师" and self:取阵营数量(0) <= 10 then
                    self:执行怪物召唤(a, 31, 0, 5)
                end
            end
        end
elseif self.战斗类型 == 180089 or self.战斗类型 == 180161 then
        if self.回合数 ==2 then
            for a = 1, #self.参战单位 do
                if self.参战单位[a].名称 == "暗偃天师" and self:取阵营数量(0) <= 10 then
                    self:执行怪物召唤(a, 43, 0, 2)
                end
            end
        elseif self.回合数 > 3  and self.回合数 < 6 then
            for a = 1, #self.参战单位 do
                if self.参战单位[a].名称 == "暗偃天师" and self:取阵营数量(0) <= 10 then
                    self:执行怪物召唤(a, 44, 0, 2)
                end
            end
        end
elseif self.战斗类型 == 180081 then
    	if self.回合数 == 3 then
        	local 退场单位列表 = {}
        	for 编号, 单位数据 in pairs(self.参战单位) do
            	if 单位数据.名称 == "石像傀儡" and 单位数据.气血 > 1 then
                	table.insert(退场单位列表, 编号)
            	end
        	end
        	if #退场单位列表 > 0 then
        		self:取消所有状态(退场单位列表)
            	self:流程多名退场处理(退场单位列表, "召唤战旗")
        		end
        		for a=1,#self.参战单位 do
        		if self.参战单位[a].名称 == "晶石核心" and self:取阵营数量(0) <= 9 then
            	self:执行怪物召唤(a,27,0,7)
                end
               end
    	elseif self.回合数 == 6 then
        	local 退场单位列表 = {}
        	for 编号, 单位数据 in pairs(self.参战单位) do
            	if 单位数据.名称 == "石像傀儡" and 单位数据.气血 > 1 then
                	table.insert(退场单位列表, 编号)
            	end
        	end
        	if #退场单位列表 > 0 then
        		self:取消所有状态(退场单位列表)
            	self:流程多名退场处理(退场单位列表, "召唤战旗")
        		end
        		for a=1,#self.参战单位 do
        		if self.参战单位[a].名称 == "晶石核心" and self:取阵营数量(0) <= 9 then
            	self:执行怪物召唤(a,28,0,7)
                end
               end
           end
elseif self.战斗类型==180132 or self.战斗类型==180161 then
    	for k=1,#self.参战单位 do
       	if self.参战单位[k].名称 == "东海龙王" and self.参战单位[k].气血>0 then
          self.参战单位[k].法伤=self.参战单位[k].法伤+100
      end
  end
elseif self.战斗类型==180140 or self.战斗类型==180160 then
    	for k=1,#self.参战单位 do
       	if self.参战单位[k].名称 == "土地公" and self.参战单位[k].气血>0 and self:取阵营数量(0) == 1 then
          self:执行怪物召唤(k,37,0,1)
      end
  end
elseif self.战斗类型 == 180057 or self.战斗类型 == 180161 then
    	if self.回合数 == 3 then
        	local 退场单位列表 = {}
        	for 编号, 单位数据 in pairs(self.参战单位) do
            	if (单位数据.名称 == "隙中岩浆" or 单位数据.名称 == "炽热地纹") and 单位数据.气血 > 1 then
                	table.insert(退场单位列表, 编号)
            	end
        	end
        	if #退场单位列表 > 0 then
        		self:取消所有状态(退场单位列表)
            	self:流程多名退场处理(退场单位列表, "召唤战旗")
        		end
        		for a=1,#self.参战单位 do
        		if self.参战单位[a].名称 == "地涌夫人" and self:取阵营数量(0) <= 9 then
            	self:执行怪物召唤(a,37,0,4)
            	self:执行怪物召唤(a,38,0,3)
                end
               end
    	elseif self.回合数 == 5 then
        	local 退场单位列表 = {}
        	for 编号, 单位数据 in pairs(self.参战单位) do
            	if (单位数据.名称 == "地涌金莲" or 单位数据.名称 == "混沌精华") and 单位数据.气血 > 1 then
                	table.insert(退场单位列表, 编号)
            	end
        	end
        	if #退场单位列表 > 0 then
        		self:取消所有状态(退场单位列表)
            	self:流程多名退场处理(退场单位列表, "召唤战旗")
        		end
        		for a=1,#self.参战单位 do
        		if self.参战单位[a].名称 == "地涌夫人" and self:取阵营数量(0) <= 9 then
            	self:执行怪物召唤(a,39,0,4)
                end
               end
    		end
elseif self.战斗类型 >= 180086 and self.战斗类型 <= 180087 then
    local summonedList = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.气血<=0 and 单位.鬼魂 ~= nil and 单位.名称 == "偃甲毒蛇" and not table.contains(summonedList, 索引) then
            self:流程退场处理({索引}, "召唤战旗")
            if 单位.名称 == "偃甲毒蛇" then
            self:执行怪物召唤1("偃甲毒蛇", 4, 0, 1)
            end
            self:取消所有状态(索引)
            table.insert(summonedList, 索引)
        end
    end
elseif self.战斗类型 == 180106 then
    local summonedList = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.气血<=0 and 单位.鬼魂 ~= nil and 单位.名称 == "噬天虎" and not table.contains(summonedList, 索引) then
            self:流程退场处理({索引}, "召唤战旗")
            if 单位.名称 == "噬天虎"and 单位.模型 == "进阶噬天虎" then
            self:执行怪物召唤1("噬天虎", 5, 0, 1)
            end
            self:取消所有状态(索引)
            table.insert(summonedList, 索引)
        end
    end
elseif self.战斗类型 >= 180113 and self.战斗类型 <= 180114 then
    local summonedList = {}
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.气血<=0 and 单位.鬼魂 ~= nil and 单位.名称 == "火山巨兽" and not table.contains(summonedList, 索引) then
            self:流程退场处理({索引}, "召唤战旗")
            if 单位.名称 == "火山巨兽" then
            self:执行怪物召唤1("火山巨兽", 6, 0, 1)
            end
            self:取消所有状态(索引)
            table.insert(summonedList, 索引)
        end
    end
elseif self.战斗类型 >= 180013 and self.战斗类型 <= 180034 or self.战斗类型 == 180160 then
    local summonedList = {} -- 用于记录已经召唤的单位的索引，以防重复召唤
    for 索引, 单位 in ipairs(self.参战单位) do
        if 单位.气血<=0 and 单位.鬼魂 ~= nil and  (单位.名称 == "涅槃圣叶"or 单位.名称 == "植命花" ) and not table.contains(summonedList, 索引) then
            self:流程退场处理({索引}, "召唤战旗")
            if 单位.名称 == "涅槃圣叶" then
            self:执行怪物召唤1("涅槃圣叶", 1, 0, 1)
            elseif 单位.名称 == "植命花" then
            self:执行怪物召唤1("植命花", 2, 0, 1)
            end
            self:取消所有状态(索引)
            table.insert(summonedList, 索引) -- 记录已召唤的单位的索引
            --print("涅槃圣叶（索引：", 索引, "）已处理")
       end
    end
    if #summonedList == 0 then
       -- print("没有找到气血小于等于0的涅槃圣叶单位。")-----------------佬伍修改（增加种族秘境时空之钥）
    end
else
    -- print("当前战斗类型不在指定范围内。")
end




end





function 战斗处理类:还原单位造型(目标) --要加一个变身数据，武器啥的，武器染色
	local 临时数据 = {
		模型 = self.参战单位[目标].模型,
		染色方案 = self.参战单位[目标].染色方案,
		染色组 = self.参战单位[目标].染色组,
		炫彩 = self.参战单位[目标].炫彩,
		炫彩组 = self.参战单位[目标].炫彩组,
		锦衣 = {}
	}
	if self.参战单位[目标].类型=="角色" then --判断是否为玩家
		local 玩家id = self.参战单位[目标].玩家id
		if self.参战单位[目标].装备[3] ~= nil then
			local 装备id = 玩家数据[玩家id].角色.装备[3]
			临时数据.武器 = {名称 = 玩家数据[玩家id].道具.数据[装备id].名称, 子类 = 玩家数据[玩家id].道具.数据[装备id].子类, 等级 = 玩家数据[玩家id].道具.数据[装备id].等级}
		end
		for k, v in pairs(玩家数据[玩家id].角色.锦衣) do
			临时数据.锦衣[k] = 玩家数据[玩家id].道具.数据[玩家数据[玩家id].角色.锦衣[k]].名称
		end
	end

	self.执行等待 = self.执行等待 + 3
	self.战斗流程[#self.战斗流程+1]={ 流程=711,攻击方=攻击方,挨打方=目标,类型=self.参战单位[目标].类型,参数=临时数据}
end

function 战斗处理类:发送加载流程()
	for i = 1, #self.参战玩家 do
		local 血量数据 = {}
		for n = 1, #self.参战单位 do
			if self.参战单位[n].玩家id == self.参战玩家[i].id then
				if self.参战单位[n].类型 == "角色" then
					血量数据[1] = {气血 = self.参战单位[n].气血, 气血上限 = self.参战单位[n].气血上限, 最大气血 = self.参战单位[n].最大气血, 魔法 = self.参战单位[n].魔法, 最大魔法 = self.参战单位[n].最大魔法, 愤怒 = self.参战单位[n].愤怒}
				else
					血量数据[2] = {气血 = self.参战单位[n].气血, 气血上限 = self.参战单位[n].气血上限, 最大气血 = self.参战单位[n].最大气血, 魔法 = self.参战单位[n].魔法, 最大魔法 = self.参战单位[n].最大魔法}
				end
			end
		end
		if not self.参战玩家[i].助战  then
			发送数据(self.参战玩家[i].连接id, 5504, self.战斗流程)
			发送数据(self.参战玩家[i].连接id, 5506, 血量数据)
		end
	end
	--[[for n=1,#self.战斗流程 do
	if self.战斗流程[n].流程==1 then
	self.执行等待=self.执行等待+12
	if self.战斗流程[n].挨打方[1].死亡~=nil then
	self.执行等待=self.执行等待+
	end
	end
	end
	--]]
	self.执行等待 = self.执行等待 + os.time()
	self.加载数量 = #self.参战玩家
	self.回合进程 = "执行回合"
end

function 战斗处理类:取伤害最高(编号,类型) --1 敌方 --2我方
  local 目标组={}
  if 类型 == 1 then
    for n=1,#self.参战单位 do
      if  self.参战单位[n].队伍~=self.参战单位[编号].队伍  and self:取目标状态(编号,n,1) then
        目标组[#目标组+1]={编号=n,伤害=self.参战单位[n].伤害}
      end
    end
    if #目标组==0 then
      return self:取单个敌方目标(编号)
    else
      table.sort(目标组,function(a,b) return a.伤害>b.伤害 end)
      return 目标组[1].编号
    end
  else
    for n=1,#self.参战单位 do
      if self.参战单位[n].队伍==self.参战单位[编号].队伍  and self:取目标状态(编号,n,2) then
        目标组[#目标组+1]={编号=n,伤害=self.参战单位[n].伤害}
      end
    end
    if #目标组==0 then
      return self:取单个友方目标1(编号)
    else
      table.sort(目标组,function(a,b) return a.伤害>b.伤害 end)
      return 目标组[1].编号
    end
  end
end
function 战斗处理类:取气血百分比最低(编号,类型) --1 敌方 --2我方
  local 目标组={}
  if 类型 == 1 then
    for n=1,#self.参战单位 do
      if  self.参战单位[n].队伍~=self.参战单位[编号].队伍  and self:取目标状态(编号,n,1) then
        目标组[#目标组+1]={编号=n,气血=self.参战单位[n].气血/self.参战单位[n].最大气血}
      end
    end
    if #目标组==0 then
      return self:取单个敌方目标(编号)
    else
      table.sort(目标组,function(a,b) return a.气血<b.气血 end)
      return 目标组[1].编号
    end
  else
    for n=1,#self.参战单位 do
      if self.参战单位[n].队伍==self.参战单位[编号].队伍  and self:取目标状态(编号,n,2) then
        目标组[#目标组+1]={编号=n,气血=self.参战单位[n].气血/self.参战单位[n].最大气血}
      end
    end
    if #目标组==0 then
      return self:取单个友方目标1(编号)
    else
      table.sort(目标组,function(a,b) return a.气血<b.气血 end)
      return 目标组[1].编号
    end
  end
end

function 战斗处理类:取速度最高(编号,类型,状态) --1 敌方 --2我方
  local 目标组={}
  if 类型 == 1 then
    for n=1,#self.参战单位 do
      if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and (状态==nil or not self.参战单位[n].法术状态[状态])  and self:取目标状态(编号,n,1) then
        目标组[#目标组+1]={编号=n,速度=self.参战单位[n].速度}
      end
    end
    if #目标组==0 then
      return self:取单个敌方目标(编号)
    else
      table.sort(目标组,function(a,b) return a.速度>b.速度 end)
      return 目标组[1].编号
    end
  else
    for n=1,#self.参战单位 do
      if self.参战单位[n].队伍==self.参战单位[编号].队伍  and self:取目标状态(编号,n,2) then
        目标组[#目标组+1]={编号=n,速度=self.参战单位[n].速度}
      end
    end
    if #目标组==0 then
      return self:取单个友方目标1(编号)
    else
      table.sort(目标组,function(a,b) return a.速度>b.速度 end)
      return 目标组[1].编号
    end
  end
end

function 战斗处理类:取单个友方目标1(编号)
  local 目标组={}
  for n=1,#self.参战单位 do
    if self.参战单位[n].队伍==self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
      目标组[#目标组+1]=n
    end
  end
  if #目标组==0 then
    return 0
  else
    return 目标组[取随机数(1,#目标组)]
  end
end

function 战斗处理类:显示(x, y)end
return 战斗处理类