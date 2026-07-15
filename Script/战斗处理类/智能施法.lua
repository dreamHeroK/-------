-- @Author: baidwwy
-- @Date:   2023-12-22 13:44:38
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-04-26 08:25:27
local 智能门派施法 = {}
local 封系 = {方寸山=true,女儿村=true,盘丝洞=true,无底洞=true,阴曹地府=true,天宫=true,五庄观=true}
local 法系 = {神木林=true,魔王寨=true,龙宫=true}
local 物理 = {大唐官府=true,狮驼岭=true,凌波城=true,花果山=true}
local 治疗 = {化生寺=true,普陀山=true}
function 智能施法(self,n)
	local 门派 = self.参战单位[n].门派
	local 通过 = false
	if 门派 and 智能门派施法[门派] then
		通过 = 智能门派施法[门派](self,n)
	end
	if not 通过 then
	  self.参战单位[n].指令=table.loadstring(table.tostring(self.参战单位[n].自动指令))
    if self.参战单位[n].指令.类型=="法术" then
      if self.参战单位[n].指令.参数=="" then
        self.参战单位[n].指令.类型="攻击"
        self.参战单位[n].指令.目标=self:取单个敌方目标(n,"物理")
      else
        local 临时技能=取法术技能(self.参战单位[n].指令.参数)
        if 临时技能[3]==4 then
          self.参战单位[n].指令.目标=self:取单个敌方目标(n,"法术")
        else
          self.参战单位[n].指令.目标=self:取单个友方目标(n)
        end
      end
    else
    	self.参战单位[n].指令.类型="攻击"
      self.参战单位[n].指令.目标=self:取单个敌方目标(n,"物理")
    end
    if self.参战单位[self.参战单位[n].指令.目标]==nil and self.参战单位[n].指令.类型~="防御" and self.参战单位[n].指令.类型~="道具" then
      self.参战单位[n].指令.类型="攻击"
      self.参战单位[n].指令.目标=self:取单个敌方目标(n,"物理")
    end
	end
end

local function 取死亡目标(self,编号) --1 敌方 --2我方
  local 目标组={}
	for n=1,#self.参战单位 do
	  if n ~= 编号 and self.参战单位[n].队伍==self.参战单位[编号].队伍 and self.参战单位[n].类型=="角色" and not self:取目标状态(编号,n,2) then
	    目标组[#目标组+1]={编号=n}
	  end
	end
	if #目标组==0 then
	  return
	else
	  return 目标组[取随机数(1,#目标组)].编号
	end
end

local function 取技能等级(目标,名称)
  if 目标.队伍==0 then
    return 目标.等级+10
  end
  for n=1,#目标.主动技能 do
    if 目标.主动技能[n].名称==名称 then
      return 目标.主动技能[n].等级
    end
  end
  if 目标.附加状态~=nil then
    for n=1,#目标.附加状态 do
      if 目标.附加状态[n].名称==名称 then
        return 目标.附加状态[n].等级
      end
    end
  end
  if 目标.追加法术~=nil then
    for n=1,#目标.追加法术 do
      if 目标.追加法术[n].名称==名称 then
        return 目标.追加法术[n].等级
      end
    end
  end
  if 目标.门派技能~=nil then
    for n=1,#目标.门派技能 do
      if 目标.门派技能[n].名称==名称 then
        return 目标.门派技能[n].等级
      end
    end
  end
  if 名称 == "牛刀小试" then return 10 end
  return 0
end

智能门派施法["化生寺"] = function (self,n)
	local 目标 = 取死亡目标(self,n)  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"我佛慈悲") ~= 0 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="我佛慈悲",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取气血百分比最低(n,2)  --再找气血比例最低
		if 目标 and 目标 ~= 0 and self.参战单位[目标].气血<self.参战单位[目标].最大气血 * 0.8 and 取技能等级(self.参战单位[n],"推气过宫") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="推气过宫",附加=""}
			通过 = true
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"金刚护法") ~= 0  then
			local 目标 = self:取单个友方目标1(n)  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="金刚护法",附加=""}
			通过 = true
		elseif 取技能等级(self.参战单位[n],"金刚护体") ~= 0  then
			local 目标 = self:取单个友方目标1(n)  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="金刚护体",附加=""}
			通过 = true
		elseif 取技能等级(self.参战单位[n],"韦陀护法") ~= 0  then
			local 目标 = self:取单个友方目标1(n)  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="韦陀护法",附加=""}
			通过 = true
		elseif 取技能等级(self.参战单位[n],"一苇渡江") ~= 0  then
			local 目标 = self:取单个友方目标1(n)  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="一苇渡江",附加=""}
			通过 = true
		end
	end
	return 通过
end

智能门派施法["普陀山"] = function (self,n)
	local 目标 = 取死亡目标(self,n)  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"杨柳甘露") ~= 0 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="杨柳甘露",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取气血百分比最低(n,2)  --再找气血比例最低
		if  目标 and 目标 ~= 0 and  self.参战单位[目标].气血<self.参战单位[目标].最大气血 * 0.8 and 取技能等级(self.参战单位[n],"普渡众生") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="普渡众生",附加=""}
			通过 = true
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"灵动九天") ~= 0  then
			local 目标 = self:取单个友方目标1(n)  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="灵动九天",附加=""}
			通过 = true
		elseif 取技能等级(self.参战单位[n],"日光华") ~= 0  then
			local 目标 = self:取单个敌方目标(n,"法术")  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="日光华",附加=""}
			通过 = true
		end
	end
	return 通过
end

local function 目标封系门派(self,编号,状态) --1 敌方 --2我方
  local 目标组={}
  for n=1,#self.参战单位 do
    if n ~= 编号 and self.参战单位[n].队伍~=self.参战单位[编号].队伍 and (状态==nil or not self.参战单位[n].法术状态[状态]) and self.参战单位[n].门派 and 封系[self.参战单位[n].门派] and not 初始技能计算:取是否被封印(self,n) and self:取目标状态(编号,n,2) then
      目标组[#目标组+1]={编号=n,速度=self.参战单位[n].速度}
    end
  end
  if #目标组==0 then
    return
  else
    table.sort(目标组,function(a,b) return a.速度>b.速度 end)
    return 目标组[1].编号
  end
end

智能门派施法["方寸山"] = function (self,n)
	local 目标 = 目标封系门派(self,n,"失心符")  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"失心符") ~= 0 and self.参战单位[目标] and self.参战单位[目标].法术状态 and not self.参战单位[目标].法术状态.失心符 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="失心符",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取速度最高(n,1,"失心符")  --再找气血比例最低
		if self.参战单位[n] == nil then print("没有找到自身") end
		if self.参战单位[目标] == nil then print("没有找到目标") end
		if 目标 and 取技能等级(self.参战单位[n],"失心符") ~= 0 and self.参战单位[目标] and self.参战单位[目标].法术状态 and not self.参战单位[目标].法术状态.失心符 then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="失心符",附加=""}
			通过 = true
		end
		if not 通过 then
			if 取技能等级(self.参战单位[n],"定身符") ~= 0 and self.参战单位[目标] and self.参战单位[目标].法术状态 and not self.参战单位[目标].法术状态.定身符 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="定身符",附加=""}
				通过 = true
			end
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"落雷符") ~= 0  then
			local 目标 = self:取单个敌方目标(n,"法术")  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="落雷符",附加=""}
			通过 = true
		end
	end
	return 通过
end

智能门派施法["女儿村"] = function (self,n)
	local 目标 = 目标封系门派(self,n,"似玉生香")  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"似玉生香") ~= 0  then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="似玉生香",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取速度最高(n,1,"似玉生香")  --再找气血比例最低
		if 取技能等级(self.参战单位[n],"似玉生香") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="似玉生香",附加=""}
			通过 = true
		end
		if not 通过 then
			if 取技能等级(self.参战单位[n],"如花解语") ~= 0  then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="如花解语",附加=""}
				通过 = true
			end
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"雨落寒沙") ~= 0  then
			local 目标 = self:取单个敌方目标(n,"法术")  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="雨落寒沙",附加=""}
			通过 = true
		end
	end
	return 通过
end

智能门派施法["盘丝洞"] = function (self,n)
	local 目标 = 目标封系门派(self,n,"含情脉脉")  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"含情脉脉") ~= 0 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="含情脉脉",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取速度最高(n,1,"含情脉脉")  --再找气血比例最低
		if 取技能等级(self.参战单位[n],"含情脉脉") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="含情脉脉",附加=""}
			通过 = true
		end
		if not 通过 then
			if 取技能等级(self.参战单位[n],"魔音摄魂") ~= 0  then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="魔音摄魂",附加=""}
				通过 = true
			end
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"天罗地网") ~= 0  then
			local 目标 = self:取单个敌方目标(n,"法术")  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="天罗地网",附加=""}
			通过 = true
		end
	end
	return 通过
end

智能门派施法["无底洞"] = function (self,n)
	local 目标 = 目标封系门派(self,n,"夺魄令")  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"夺魄令") ~= 0 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="夺魄令",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取速度最高(n,1,"夺魄令")  --再找气血比例最低
		if 取技能等级(self.参战单位[n],"夺魄令") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="夺魄令",附加=""}
			通过 = true
		end
		if not 通过 then
			if 取技能等级(self.参战单位[n],"煞气诀") ~= 0  then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="煞气诀",附加=""}
				通过 = true
			end
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"地涌金莲") ~= 0  then
			local 目标 = self:取气血百分比最低(n,2)  --随机释放状态技能
			if  目标 and 目标 ~= 0 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="地涌金莲",附加=""}
				通过 = true
			end
		end
	end
	return 通过
end

智能门派施法["五庄观"] = function (self,n)
	local 目标 = 目标封系门派(self,n,"日月乾坤")  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"日月乾坤") ~= 0 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="日月乾坤",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取速度最高(n,1,"日月乾坤")  --再找气血比例最低
		if 取技能等级(self.参战单位[n],"日月乾坤") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="日月乾坤",附加=""}
			通过 = true
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"生命之泉") ~= 0  then
			local 目标 = self:取气血百分比最低(n,2)  --随机释放状态技能
			if  目标 and 目标 ~= 0 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="生命之泉",附加=""}
				通过 = true
			end
		end
	end
	return 通过
end

智能门派施法["天宫"] = function (self,n)
	local 目标 = 目标封系门派(self,n,"错乱")  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"错乱") ~= 0 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="错乱",附加=""}
		通过 = true
	end
	if not 通过 then
		local 目标 = self:取速度最高(n,1,"错乱")  --再找气血比例最低
		if 取技能等级(self.参战单位[n],"错乱") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="错乱",附加=""}
			通过 = true
		end
		if not 通过 then
			if 取技能等级(self.参战单位[n],"镇妖") ~= 0  then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="镇妖",附加=""}
				通过 = true
			end
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"天雷斩") ~= 0  then
			local 目标 = self:取单个敌方目标(n,"物理")  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="天雷斩",附加=""}
			通过 = true
		end
	end
	return 通过
end

local function 目标封系门派地府(self,编号) --1 敌方 --2我方
  local 目标组={}
  for n=1,#self.参战单位 do
    if n ~= 编号 and self.参战单位[n].队伍~=self.参战单位[编号].队伍 and not self.参战单位[n].法术状态.锢魂术 and self.参战单位[n].门派 and 封系[self.参战单位[n].门派] and self:取目标状态(编号,n,2) then
      目标组[#目标组+1]={编号=n,速度=self.参战单位[n].速度}
    end
  end
  if #目标组==0 then
    return
  else
    table.sort(目标组,function(a,b) return a.速度>b.速度 end)
    return 目标组[1].编号
  end
end

local function 目标门派地府(self,编号) --1 敌方 --2我方
  local 目标组={}
  for n=1,#self.参战单位 do
    if n ~= 编号 and self.参战单位[n].队伍~=self.参战单位[编号].队伍 and not self.参战单位[n].法术状态.锢魂术 and self.参战单位[n].门派 and self:取目标状态(编号,n,2) then
      目标组[#目标组+1]={编号=n,速度=self.参战单位[n].速度}
    end
  end
  if #目标组==0 then
    return
  else
    table.sort(目标组,function(a,b) return a.速度>b.速度 end)
    return 目标组[1].编号
  end
end

智能门派施法["阴曹地府"] = function (self,n)
	local 目标 = 目标封系门派地府(self,n)  --先找死亡队员
	local 通过 = false
	if 目标 and 取技能等级(self.参战单位[n],"锢魂术") ~= 0 then
		self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="锢魂术",附加=""}
		通过 = true
	end
	if not 目标 then
		目标 = 目标门派地府(self,n)  --先找死亡队员
		if 目标 and 取技能等级(self.参战单位[n],"锢魂术") ~= 0 then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="锢魂术",附加=""}
			通过 = true
		end
	end
	if not 通过 then
		local 目标 = self:取速度最高(n,1)  --再找气血比例最低
		if 取技能等级(self.参战单位[n],"尸腐毒") ~= 0  then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="尸腐毒",附加=""}
			通过 = true
		end
	end
	if not 通过 then
		if 取技能等级(self.参战单位[n],"阎罗令") ~= 0  then
			local 目标 = self:取单个敌方目标(n,"法术")  --随机释放状态技能
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="阎罗令",附加=""}
			通过 = true
		end
	end
	return 通过
end

local function 取法术集火目标(self,编号)
  local 目标组={}
  for n=1,#self.参战单位 do
    if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
     	if self.参战单位[n].标记=="法术" then
        return n
      elseif self.参战单位[n].标记=="集火" then
        return n
      end
   	end
  end
  return
end

local function 取目标存活数(self,编号)
  local 目标 = 0
  for n=1,#self.参战单位 do
    if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
      	目标 = 目标 + 1
    end
  end
  return 目标
end

智能门派施法["龙宫"] = function (self,n)
	local 目标 = 取法术集火目标(self,n)  --先找死亡队员
	local 目标数 = 取目标存活数(self,n)
	local 通过 = false
	if 目标 then
		if 目标数 <=1 and 取技能等级(self.参战单位[n],"龙腾") ~= 0 then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="龙腾",附加=""}
			通过 = true
		elseif 取技能等级(self.参战单位[n],"龙卷雨击") ~= 0 then
		  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="龙卷雨击",附加=""}
		  通过 = true
		end
	end
	if not 目标 then
		目标 = self:取伤害最高(n,1)
		if 目标 then
			if 目标数 <=1 and 取技能等级(self.参战单位[n],"龙腾") ~= 0 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="龙腾",附加=""}
				通过 = true
			elseif 取技能等级(self.参战单位[n],"龙卷雨击") ~= 0 then
			  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="龙卷雨击",附加=""}
			  通过 = true
			end
		end
	end
	return 通过
end

智能门派施法["魔王寨"] = function (self,n)
	local 目标 = 取法术集火目标(self,n)  --先找死亡队员
	local 目标数 = 取目标存活数(self,n)
	local 通过 = false
	if 目标 then
		if 目标数 <=1 and 取技能等级(self.参战单位[n],"三昧真火") ~= 0 then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="三昧真火",附加=""}
			通过 = true
		elseif 取技能等级(self.参战单位[n],"飞砂走石") ~= 0 then
		  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="飞砂走石",附加=""}
		  通过 = true
		end
	end
	if not 目标 then
		目标 = self:取伤害最高(n,1)
		if 目标 then
			if 目标数 <=1 and 取技能等级(self.参战单位[n],"三昧真火") ~= 0 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="三昧真火",附加=""}
				通过 = true
			elseif 取技能等级(self.参战单位[n],"飞砂走石") ~= 0 then
			  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="飞砂走石",附加=""}
			  通过 = true
			end
		end
	end
	return 通过
end

智能门派施法["神木林"] = function (self,n)
	local 目标 = 取法术集火目标(self,n)  --先找死亡队员
	local 目标数 = 取目标存活数(self,n)
	local 通过 = false
	if 目标 then
		if 目标数 <=1 and 取技能等级(self.参战单位[n],"荆棘舞") ~= 0 then
			self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="荆棘舞",附加=""}
			通过 = true
		elseif 取技能等级(self.参战单位[n],"落叶萧萧") ~= 0 then
		  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="落叶萧萧",附加=""}
		  通过 = true
		end
	end
	if not 目标 then
		目标 = self:取伤害最高(n,1)
		if 目标 then
			if 目标数 <=1 and 取技能等级(self.参战单位[n],"荆棘舞") ~= 0 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="荆棘舞",附加=""}
				通过 = true
			elseif 取技能等级(self.参战单位[n],"落叶萧萧") ~= 0 then
			  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="落叶萧萧",附加=""}
			  通过 = true
			end
		end
	end
	return 通过
end

local function 取物理集火目标(self,编号)
  local 目标组={}
  for n=1,#self.参战单位 do
    if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
     	if self.参战单位[n].标记=="物理" then
        return n
      elseif self.参战单位[n].标记=="集火" then
        return n
      end
   	end
  end
  return
end

智能门派施法["大唐官府"] = function (self,n)
	local 目标 = 取物理集火目标(self,n)  --先找死亡队员
	local 目标数 = 取目标存活数(self,n)
	local 通过 = false

	if 目标 then
		if 取技能等级(self.参战单位[n],"横扫千军") ~= 0 then
		  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="横扫千军",附加=""}
		  通过 = true
		end
	end
	if not 目标 then
		目标 = self:取伤害最高(n,1)
		if 目标 then
			if 取技能等级(self.参战单位[n],"横扫千军") ~= 0 then
			  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="横扫千军",附加=""}
			  通过 = true
			end
		end
	end
	return 通过
end

智能门派施法["花果山"] = function (self,n)
	local 目标 = 取物理集火目标(self,n)  --先找死亡队员
	local 目标数 = 取目标存活数(self,n)
	local 通过 = false
	local jn = {}
	for i,v in ipairs(self.参战单位[n].如意神通) do
		if 取技能等级(self.参战单位[n],v) ~= 0 then
			jn[#jn+1] = v
		end
	end
	if 目标 then
	  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数=jn[取随机数(1,#jn)] or "小试牛刀",附加=""}
	  通过 = true
	end
	if not 目标 then
		目标 = self:取伤害最高(n,1)
		if 目标 then
		  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数=jn[取随机数(1,#jn)] or "小试牛刀",附加=""}
		  通过 = true
		end
	end
	return 通过
end

智能门派施法["凌波城"] = function (self,n)
	local 目标 = 取物理集火目标(self,n)  --先找死亡队员
	local 目标数 = 取目标存活数(self,n)
	local 通过 = false
	if 目标 then
		if 目标数 >= 3 then
			if self.参战单位[n].战意  then
				if self.参战单位[n].战意 >= 3 and 取技能等级(self.参战单位[n],"翻江搅海") ~= 0 then
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="翻江搅海",附加=""}
				  通过 = true
				elseif self.参战单位[n].战意 >= 2 and 取技能等级(self.参战单位[n],"浪涌") ~= 0 then--惊涛怒
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="浪涌",附加=""}
				  通过 = true
				elseif 取技能等级(self.参战单位[n],"浪涌") ~= 0 then
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="浪涌",附加=""}
				  通过 = true
				end
			end
		else
			if self.参战单位[n].战意  then
				if self.参战单位[n].战意 >= 3 and 取技能等级(self.参战单位[n],"天崩地裂") ~= 0 then
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="天崩地裂",附加=""}
				  通过 = true
				elseif self.参战单位[n].战意 >= 2 and 取技能等级(self.参战单位[n],"断岳势") ~= 0 then
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="断岳势",附加=""}
				  通过 = true
				elseif 取技能等级(self.参战单位[n],"浪涌") ~= 0 then
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="浪涌",附加=""}--裂石
				  通过 = true
				end
			end
		end
	end
	if not 目标 then
		目标 = self:取伤害最高(n,1)
		if 目标 then
			if 目标数 >= 3 then
				if self.参战单位[n].战意  then
					if self.参战单位[n].战意 >= 3 and 取技能等级(self.参战单位[n],"翻江搅海") ~= 0 then
					  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="翻江搅海",附加=""}
					  通过 = true
					elseif self.参战单位[n].战意 >= 2 and 取技能等级(self.参战单位[n],"浪涌") ~= 0 then
					  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="浪涌",附加=""}
					  通过 = true
					elseif 取技能等级(self.参战单位[n],"浪涌") ~= 0 then
					  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="浪涌",附加=""}
					  通过 = true
					end
				end
			else
				if self.参战单位[n].战意  then
					if self.参战单位[n].战意 >= 3 and 取技能等级(self.参战单位[n],"天崩地裂") ~= 0 then
					  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="天崩地裂",附加=""}
					  通过 = true
					elseif self.参战单位[n].战意 >= 2 and 取技能等级(self.参战单位[n],"断岳势") ~= 0 then
					  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="断岳势",附加=""}
					  通过 = true
					elseif 取技能等级(self.参战单位[n],"浪涌") ~= 0 then
					  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="浪涌",附加=""}--裂石
					  通过 = true
					end
				end
			end
		end
	end
	return 通过
end


智能门派施法["狮驼岭"] = function (self,n)
	local 目标 = 取物理集火目标(self,n)  --先找死亡队员
	local 目标数 = 取目标存活数(self,n)
	local 通过 = false
	if 目标 then
		if not self.参战单位[n].法术状态.变身 then
			self.参战单位[n].指令={下达=false,类型="法术",目标=n,敌我=0,参数="变身",附加=""}
			通过 = true
		else
			if 目标数 <=2 and 取技能等级(self.参战单位[n],"连环击") ~= 0 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="连环击",附加=""}
				通过 = true
			elseif 目标数 <=2 and 取技能等级(self.参战单位[n],"狮搏") ~= 0 then
			  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="狮搏",附加=""}
			  通过 = true
			elseif  取技能等级(self.参战单位[n],"鹰击") ~= 0 then
			  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="鹰击",附加=""}
			  通过 = true
			end
		end
	end
	if not 目标 then
		目标 = self:取伤害最高(n,1)
		if 目标 then
			if not self.参战单位[n].法术状态.变身 then
				self.参战单位[n].指令={下达=false,类型="法术",目标=n,敌我=0,参数="变身",附加=""}
				通过 = true
			else
				if 目标数 <=2 and 取技能等级(self.参战单位[n],"连环击") ~= 0 then
					self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="连环击",附加=""}
					通过 = true
				elseif 目标数 <=2 and 取技能等级(self.参战单位[n],"狮搏") ~= 0 then
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="狮搏",附加=""}
				  通过 = true
				elseif  取技能等级(self.参战单位[n],"鹰击") ~= 0 then
				  self.参战单位[n].指令={下达=false,类型="法术",目标=目标,敌我=0,参数="鹰击",附加=""}
				  通过 = true
				end
			end
		end
	end
	return 通过
end