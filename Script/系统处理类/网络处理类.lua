-- @Author: 小神QQ190909219
-- @Date:   2023-08-17 23:38:48
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-09-06 14:02:28
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-08-23 14:56:17
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 网络处理类 = class()
__md5yanzgheng={}
__md5cishu={}
function 网络处理类:初始化() end

-- function QUjiamic()
-- 	return f函数.取MD5(os.time())
-- end
-- local sssadw=0
function 网络处理类:数据处理(id,源)
	--print(id)
	--线程:发送(1,id,table.loadstring(源))
	-- print(源)
	self.数据=table.loadstring(源)
	if self.数据 ==nil then  return end
	if self.数据.序号 ==nil then  return end
	-----------------------------C改
	if self.数据.ID then
	id = self.数据.ID
	end
	-----------------------------C改
	local 序号 = tonumber(self.数据.序号)

	if 序号 <= 5 then
		系统处理类:数据处理(id,序号,self.数据.内容)
		return
	elseif 序号<=1000 then
		self.数据.数字id=self.数据.数字id+0
		系统处理类:数据处理(id,序号,self.数据)
		return
	elseif 序号>1000 and 序号<=1500 then --地图事件
		地图处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return
	elseif 序号>1500 and 序号<=2000 then --对话事件
		对话处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return

	elseif 序号>2000 and 序号<=2100 then --助战处理类
                       	local 内容=self.数据
	   	助战处理类:数据处理(id,序号,内容)
		return

	elseif 序号>3500 and 序号<=4000 then --道具事件
		-- print(1)
		if tonumber(self.数据.数字id) == nil or 玩家数据[self.数据.数字id+0] == nil then return end
		-- print(2)
		玩家数据[self.数据.数字id+0].道具:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return
	elseif 序号>4000 and 序号<=4500 then --道具事件
		队伍处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return
	elseif 序号>4500 and 序号<=5000 then --道具事件
		装备处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return
	elseif 序号>5000 and 序号<=5500 then --道具事件
		玩家数据[self.数据.数字id+0].召唤兽:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return
	elseif 序号>5500 and 序号<=6000 then --道具事件
		战斗准备类:数据处理(self.数据.数字id+0,序号,self.数据)
		return
		--玩家数据[self.数据.数字id+0].召唤兽:数据处理(id,序号,self.数据.数字id+0,self.数据)
	elseif 序号>6000 and 序号<=6100 then --道具事件
		聊天处理类:数据处理(self.数据.数字id+0,序号,self.数据)
		return
	elseif 序号>6100 and 序号<=6200 then --道具事件
		商会处理类:数据处理(id,序号,self.数据)
		return
	elseif 序号>6200 and 序号<=6300 then --伙伴事件
	 	玩家数据[self.数据.数字id+0].神器:数据处理(id,序号,self.数据.数字id+0,self.数据)
	 	return
	elseif 序号>6300 and 序号<=6400 then --
		首席弟子类:数据处理(id,序号,self.数据)
		return
	elseif 序号>6400 and 序号<=6500 then
		-- 安卓数据:数据处理(id,序号,self.数据)
		-- return
	elseif 序号>6500 and 序号<=6600 then --夫妻处理类
		夫妻处理类:数据处理(id,序号,self.数据)
		return
	elseif 序号>6600 and 序号<=6620 then
		翻一翻:数据处理(id,self.数据.数字id,序号,self.数据)

	elseif 序号>6700 and 序号<=6800 then
		道具仓库数据[玩家数据[self.数据.数字id+0].账号].道具:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return
	elseif 序号>6800 and 序号<6900 then
		宝宝仓库数据[玩家数据[self.数据.数字id+0].账号].召唤兽:数据处理(id,序号,self.数据.数字id+0,self.数据)
		return
	 elseif 序号>=6900 and 序号<=6950 then
	 	GM工具类:数据处理(id,序号,self.数据)
	 	return
	elseif 序号>6950 and 序号<=6970 then
		  好友消息类:数据处理(id,序号,self.数据)
		return
	elseif 序号>7000 and 序号<=7300 then
		管理工具类:数据处理(self.数据.数字id+0,序号,self.数据)
		return
	elseif 序号 >= 8000 and 序号 <= 8050 then
			local 数字id=self.数据.数字id+0
			      	if 玩家数据[数字id]~=nil and 账号仓库数据[玩家数据[数字id].账号]~=nil then
			        		账号仓库数据[玩家数据[数字id].账号]:数据处理(id,序号,数字id,self.数据)
			     	end

	elseif 序号==88888 then
	elseif 序号==99997 then

		if self.数据.类型 == "连接进入" then
			总控客户信息[self.数据.ID+0] = {
				ID = self.数据.原始ID,
				类别 = self.数据.方式
			}

			if self.数据.方式 == "PC" and tonumber(self.数据.ID) and self.数据.ID >= 160000 then
		        发送数据(self.数据.ID, 998, "错误代码160000，请联系管理员！")
		    end
		elseif self.数据.类型 == "连接退出" then
			总控客户信息[self.数据.ID+0] = nil
		end
	elseif  序号==99998 then
		-- 玩家数据[self.数据.数字id+0].道具:清空包裹(id,self.数据.数字id+0)
	elseif  序号==99999 then

	end
end
function 网络处理类:更新(dt) end
function 网络处理类:显示(x,y) end
return 网络处理类