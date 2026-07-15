-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:39
-- @Last Modified by:   tangguo
-- @Last Modified time: 2026-01-10 21:23:32
-- @Author: baidwwy
-- @Date:   2023-11-25 01:22:09
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-03-14 10:54:16
local 比武大会 = class()
local 灵饰范围={"手镯","佩饰","戒指","耳饰"}
local 书铁范围 = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
-- 精锐群雄·全服冠军　精锐群雄·全服亚军　精锐群雄·全服季军
-- 勇武群雄·全服冠军　勇武群雄·全服亚军　勇武群雄·全服季军
-- 神威群雄·全服冠军　神威群雄·全服亚军　神威群雄·全服季军
-- 天科群雄·全服冠军　天科群雄·全服亚军　天科群雄·全服季军
-- 天启群雄·全服冠军　天启群雄·全服亚军　天启群雄·全服季军
-- 天元群雄·全服冠军　天元群雄·全服亚军　天元群雄·全服季军
--============================================================
function 比武大会:初始化()
	self.数据={青龙=0,玄武=0,白虎=0,朱雀=0}
	-- self.阵营={}
	self.活动开关=false
	self.结束time=false --初始化固定为false不要动这里
	self.进场开关=false
	--------------------------------------------
	local 进场时间
	if 调试模式 then
		进场时间=20
	else
		进场时间=1800
	end

	self.进场time=os.time()+进场时间 --5分钟 60*5=300
	------------------------------------------
	self.进场倒计时=0
	self.报名开关=true
	self.正式开启time=false --初始化固定为false不要动这里
	self.正式PK=false
	-----------------------------
	self.按级分组=true -- =true 就按69、109、129、>129分 否则=false全部天元组---
	-- self.按级分组=false --测试用
	-----------------------------
	self.战败限制=3 --失败几次踢出比武场
	self.胜利积分=10 --胜利加的积分
	self.战败积分=3  --战败加的积分
	------------------------------
	self.刷出假人={间隔=60,记录=0}
	-- self.刷出假人={间隔=10,记录=0} --测试用
	------------------------------
	self.活动时间=QJHDSJ["比武大会"]
end

--比武大会数据.进程 1开启报名
function 比武大会:活动定时器()
	if not self.活动开关 then
	    if self.活动时间.日期=="每天" then
			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
				self:开启活动()
			end
		elseif self.活动时间.大写日期 == "每月" then
			local currentDate = os.date("*t").day
			if currentDate == 1 then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			end
		elseif self.活动时间.大写日期 == "半月" then
			local currentDate = os.date("*t").day
			if currentDate == 1 or currentDate == 15 then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			end
		else
			local zhouji=tonumber(os.date("%w", os.time()))
			if zhouji == tonumber(self.活动时间.日期) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周135" and (zhouji==1 or zhouji==3 or zhouji==5) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周246" and (zhouji==2 or zhouji==4 or zhouji==6) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周一" and (zhouji==1) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周二" and (zhouji==2) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周三" and (zhouji==3) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周四" and (zhouji==4) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周五" and (zhouji==5) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周六" and (zhouji==6) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周日" and (zhouji==0) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周六日" and (zhouji==6 or zhouji==0) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			end
		end
	else
		if self.活动开关 and self.结束time and tonumber(self.结束time)~=nil and os.time() - self.结束time >= 0 then
			发送公告("#S(比武大会)#Y/比武大会已经结束，请在#R/比武大会主持人#Y/处领取奖励。")
			广播消息({内容="#S(比武大会)#Y/比武大会已经结束，请在#R/比武大会主持人#Y/处领取奖励。".."#"..取随机数(1,110),频道="xt"})

			self.活动开关=false
			self.结束time=false
			self.报名开关=true
			self.正式PK=false
			-- self.结束time=false
			比武大会数据.进程=0
			self:比武结束计算排名()
			for n, v in pairs(地图处理类.地图玩家[1197]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:比武强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].角色.当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                			end
			end
			for n, v in pairs(地图处理类.地图玩家[5136]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:比武强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].角色.当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                			end
			end
			for n, v in pairs(地图处理类.地图玩家[5137]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:比武强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].角色.当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                			end
			end
			for n, v in pairs(地图处理类.地图玩家[5138]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:比武强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].角色.当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                			end
			end
			for n, v in pairs(地图处理类.地图玩家[5139]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:比武强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].角色.当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                			end
			end
			return
		end

	    if self.活动开关 and 比武大会数据.进程 == 1 and tonumber(self.进场time)~=nil and os.time() - self.进场time >= 0 then
	    	比武大会数据.进程=2
	    	self.进场开关=true
	    	-------------------------------
	    	local 正式时间
	    	if 调试模式 then
	    		正式时间=30
	    	else
	    		正式时间=600
	    	end
	    	self.正式开启time=os.time()+正式时间
	    	-------------------------------
	    	发送公告("#Y比武大会已经开启进场，请报名成功的玩家抓紧通过英雄大会主持人进入场地(正式比赛将于10分钟后开启,开启后将无法进入比赛地图)。")
		广播消息({内容="#Y比武大会已经开启进场，请报名成功的玩家抓紧通过英雄大会主持人进入场地(正式比赛将于10分钟后开启,开启后将无法进入比赛地图)。".."#"..取随机数(1,110),频道="xt"})

	    elseif self.活动开关 and 比武大会数据.进程 == 2 and self.正式开启time and tonumber(self.正式开启time)~=nil and os.time() - self.正式开启time >= 0 then
	        比武大会数据.进程=3
	        self.正式PK=true
	        self.报名开关=false
	        self.进场开关=false
	        self.正式开启time=false
	        ------------------------------
	        local 结束时间
	   	if  调试模式 then
	   		结束时间=120
	   	else
	   		结束时间=1200
	   	end
	   	self.结束time=os.time()+结束时间 --正式战斗时间30*60=20分钟
	   	    ------------------------------
	        for n, v in pairs(地图处理类.地图玩家[1197]) do
	        	if 玩家数据[n] and 玩家数据[n].连接id then
	        		常规提示(n,"#Y/开打开打，现在可通过#R/比武传送人#Y/传送至战场")
		        	消息提示(n,"#Y/开打开打，现在可通过#R/比武传送人#Y/传送至战场")
		        end
	        end
	    end
	    if 比武大会数据.进程 < 2 and not self.进场开关 and self.报名开关 then
	    	self.进场倒计时 = self.进场time - os.time()
	    	if self.进场倒计时 <= 0 then self.进场倒计时 = 0 end
	    end
	   if os.time() - self.刷出假人.记录 >= self.刷出假人.间隔 then
	       self.刷出假人.记录	 = os.time()
	       self:比武刷出假人()
	    end
	end
end

function 比武大会:开启活动()
	比武大会数据={进程=0,报名={},玩家表={},精锐组={},神威组={},天科组={},天元组={}} --初始化
   	比武大会数据.进程=1
   	self.活动开关 = true
   	local 进场时间
   	if 调试模式 then
   		进场时间=10
   	else
   		进场时间=600
   	end

   	self.进场time = os.time() + 进场时间--600
   	self.结束time = os.time() + 3600
   	发送公告("#S(比武大会)#Y/开启报名，请想参赛的玩家抓紧通过英雄大会主持人报名。")
	广播消息({内容="#S(比武大会)#Y/开启报名，请想参赛的玩家抓紧通过英雄大会主持人报名。".."#"..取随机数(1,110),频道="xt"})

end

function 比武大会:排行单位初始化() --服务端启动即加载
	local 地图数据={
		[1]={地图=1001,x=109,y=60,方向=0}, --假人地图、坐标、方向
		[2]={地图=1001,x=117,y=56,方向=0},
		[3]={地图=1001,x=116,y=65,方向=0},
		[4]={地图=1001,x=126,y=60,方向=0},
		[5]={地图=1001,x=130,y=66,方向=0},
		[6]={地图=1001,x=123,y=70,方向=0},
		[7]={地图=1001,x=129,y=75,方向=0},
		[8]={地图=1001,x=137,y=71,方向=0},
		[9]={地图=1001,x=135,y=79,方向=0},
		[10]={地图=1001,x=142,y=76,方向=0},
		[11]={地图=1001,x=140,y=85,方向=0},
		[12]={地图=1001,x=148,y=81,方向=0},
		[13]={地图=1001,x=147,y=89,方向=0},
		[14]={地图=1001,x=156,y=83,方向=0},
		[15]={地图=1001,x=120,y=80,方向=0},
		[16]={地图=1001,x=148,y=66,方向=0},
		[17]={地图=1001,x=108,y=69,方向=0},
		[18]={地图=1001,x=135,y=56,方向=0},
		[19]={地图=1001,x=96,y=56,方向=0},
		[20]={地图=1001,x=116,y=46,方向=0},
	}
	local fz={"精锐组","神威组","天科组","天元组"}
	local cw=""
	for n=1,20 do
		-------------------------随机取名
		local xms=取随机数(2,5)
		local xm=""
		for nv=1,xms do
			xm=xm ..Q_取单字[取随机数(1,#Q_取单字)]
		end
		-------------------------
		if n<=5 then
			cw="精锐组冠军"
		elseif n<=10 then
		    cw="神威组冠军"
		elseif n<=15 then
		    cw="天科组冠军"
		else
		    cw="天元组冠军"
		end
		local xy=地图处理类.地图坐标[1339]:取随机点()
		local fjid=3489+n
		local qmp=取随机数(15,15)
		local 模型=Q_随机模型[qmp]
		随机序列=随机序列+1
		local 任务id=取随机数(1999,11111).."_"..fjid.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
		任务数据[任务id]={
	      id=任务id,
	      起始=os.time(),
	      结束=99999999999,
	      名称=xm,
	      模型=模型,
	      称谓=cw,
	      武器=Q_随机武器[模型][7],
	      x=地图数据[n].x,
	      y=地图数据[n].y,
	      方向=地图数据[n].方向,
	      地图编号=地图数据[n].地图,
	      序列=n,
	      类型=3489,
	      标识="比武排行单位",
	    }
	    地图处理类:添加单位(任务id)
	end
end

function 比武大会:排行单位变更()
	local 排行编号={}
	local 排行称谓={}
	for n=1,5 do
		排行称谓[n]="天元组冠军"
		排行称谓[n+5]="天科组冠军"
		排行称谓[n+10]="神威组冠军"
		排行称谓[n+15]="精锐组冠军"
	end
	if self.按级分组 then
		for nv,vv in pairs(比武大会数据.天元组) do
			排行编号[nv]=vv.id
		end
		for nv,vv in pairs(比武大会数据.天科组) do
			排行编号[nv+5]=vv.id
		end
		for nv,vv in pairs(比武大会数据.神威组) do
			排行编号[nv+10]=vv.id
		end
		for nv,vv in pairs(比武大会数据.精锐组) do
			排行编号[nv+15]=vv.id
		end
	else --若不分组、则全匹配天元组
		for nv,vv in pairs(比武大会数据.天元组) do
			排行编号[nv]=vv.id
		end
		for n=1,5 do
			排行称谓[n]="天元组冠军"
			排行称谓[n+5]="天元组亚军"
			排行称谓[n+10]="天元组季军"
			排行称谓[n+15]="天元组第" ..数字转大写[n] .."名"
		end
	end
	for n,v in pairs(任务数据) do
		if 任务数据[n] ~= nil and 任务数据[n].类型 == 3489 and 任务数据[n].标识 ~= nil and 任务数据[n].标识 == "比武排行单位" then
			local 序列=任务数据[n].序列
			if 排行编号[序列] ~= nil and 玩家数据[排行编号[序列]] ~= nil then
				local 临时id=排行编号[序列]
				任务数据[n].名称=玩家数据[临时id].角色.名称
				任务数据[n].模型=玩家数据[临时id].角色.模型
				任务数据[n].称谓=排行称谓[序列]
				if 玩家数据[临时id].角色.装备[3] ~= nil then
					local 武器id=玩家数据[临时id].角色.装备[3]
					if 玩家数据[临时id].道具.数据[武器id] ~= nil then
						任务数据[n].武器=玩家数据[临时id].道具.数据[武器id].名称
					end
					if 玩家数据[临时id].角色.锦衣[1] ~= nil then
						local 锦衣id = 玩家数据[临时id].角色.锦衣[1]
						if 玩家数据[临时id].道具.数据[锦衣id] ~= nil then
							任务数据[n].锦衣=玩家数据[临时id].道具.数据[锦衣id].名称
						end
					end
			    end
			 --    if 排行称谓[序列] ~= nil and not 玩家数据[临时id].角色:检查称谓(排行称谓[序列]) then
				--     玩家数据[临时id].角色:添加称谓(排行称谓[序列])
				-- end
				地图处理类:更换假人模型数据(n)
			end
		end
	end
end


-- function 比武大会:比武刷出假人()
-- 	local 地图组={5136,5137,5138,5139}
-- 	local xy=地图处理类.地图坐标[1197]:取随机点()
-- 	local djz={69,109,129,150} --等级组
-- 	local xlz={5,15,20,25} --修炼组
-- 	local fz={"精锐组大赛成员","神威组大赛成员","天科组大赛成员","天元组大赛成员"} --称谓组
-- 	local 锦衣={"青花瓷","浮生","浮生绡·点黛"}
-- 	for n=1,#地图组 do
-- 		local 任务id=取唯一任务(3488)
-- 		local dtbh=地图组[n]
-- 		-------------------------随机取名
-- 		local xms=取随机数(2,5)
-- 		local xm=""
-- 		for nv=1,xms do
-- 			xm=xm ..Q_取单字[取随机数(1,#Q_取单字)]
-- 		end
-- 		-------------------------
-- 		local qmp=取随机数(10,10)
-- 		local 模型=Q_随机模型[qmp]
-- 		for k=1,5 do
-- 		任务数据[任务id]={
-- 			id=任务id,
-- 			起始=os.time(),
-- 			结束=200,
-- 			玩家id=id,
-- 			称谓=fz[n],
-- 			名称=xm,
-- 			模型=模型,
-- 			锦衣=锦衣[取随机数(1,#锦衣)],
-- 			x=xy.x,
-- 			y=xy.y,
-- 			地图编号=dtbh,
-- 			武器 = Q_随机武器[模型][7],
-- 			序列=qmp,
-- 			角色=true,
-- 			行走开关=true,
-- 			销毁=true,
-- 			等级=djz[n],
-- 			修炼 = {防修=xlz[n],攻修=xlz[n]},
-- 			类型=3488
-- 		}
-- 		地图处理类:添加单位(任务id)
-- 	end
-- 	end
-- end
function 比武大会:比武刷出假人()
	local 地图组={5136,5137,5138,5139}
	local djz={69,109,129,150} --等级组
	local xlz={5,15,20,25} --修炼组
	local fz={"精锐组大赛成员","神威组大赛成员","天科组大赛成员","天元组大赛成员"} --称谓组
	local 锦衣={"青花瓷","浮生","浮生绡·点黛"}

	for n=1,#地图组 do
		local dtbh=地图组[n]

		for k=1,5 do
			-- 每次生成假人都重新获取随机坐标
			local xy=地图处理类.地图坐标[1197]:取随机点()
			-------------------------随机取名
			local xms=取随机数(2,5)
			local xm=""
			for nv=1,xms do
				xm=xm ..Q_取单字[取随机数(1,#Q_取单字)]
			end
			-------------------------

			local qmp=取随机数(10,10)
			local 模型=Q_随机模型[qmp]
			local 任务id=取唯一任务(3488)

			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=200,
				玩家id=id,
				称谓=fz[n],
				名称=xm,
				模型=模型,
				锦衣=锦衣[取随机数(1,#锦衣)],
				x=xy.x,
				y=xy.y,
				地图编号=dtbh,
				武器 = Q_随机武器[模型][7],
				序列=qmp,
				角色=true,
				-- 行走开关=true,
				销毁=true,
				等级=djz[n],
				修炼 = {防修=xlz[n],攻修=xlz[n]},
				类型=3488
			}
			地图处理类:添加单位(任务id)
		end
	end
end
function 比武大会:比武假人对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	对话数据.对话="送积分喽~只有运数高的人和存活越久的人才能有幸看到我。"
	对话数据.选项={"积分积分，我要积分！","简直是作弊啊，拜拜！"}
	return 对话数据
end

function 比武大会:比武假人对话事件处理(id,名称,事件,类型,rwid)
	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
	if 事件 == "积分积分，我要积分！" then
		战斗准备类:创建战斗(id,134872,rwid)
		任务数据[rwid].zhandou=true
	end
end

function 比武大会:对话事件处理(id,名称,事件)
	if 事件=="我要参加天下英雄大会" then
		if not self.活动开关 then
			添加最后对话(id,"还没到报名时间")
		return
		elseif 玩家数据[id].队伍==0 then
			添加最后对话(id,"请组队参与报名")
			return
		elseif 玩家数据[id].角色.等级<50 then
			添加最后对话(id,"报名条件：≥50级、人气≥500")
			return
		elseif 比武大会数据.报名[id] then
				添加最后对话(id,"你已经报过名了，无需再报名。")
				return
		elseif self.报名开关==false then
		        添加最后对话(id,"活动已经开始禁止报名。")
				return
		end
		添加最后对话(id,"以你的等级，报名参加比武大会需要交纳"..(玩家数据[id].角色.等级*10000).."两报名费用，你要交纳吗？",{"交纳报名费用","我再想想"})
	elseif 事件=="交纳报名费用" then
		for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
		     local lsid = 队伍数据[玩家数据[id].队伍].成员数据[i]
			if 玩家数据[lsid].角色:扣除银子(玩家数据[id].角色.等级*10000,0,0,"比武大会") then
		    		比武大会数据.报名[lsid]={积分=0,分组=""}
		    		玩家数据[lsid].角色:删除比武称谓()
		    		添加最后对话(lsid,"报名成功！请于10分钟内来我这里传送至比赛地图。")
			end
		end


	elseif 事件=="打听天下英雄会消息" then
	    添加最后对话(id,"天下英雄会限时开放。活动开启后在我这里报名，等待5分钟后即可入场。入场后有5分钟等待时间，方便玩家组队。正式比赛开始后可通过比武传送人转至战场。\n#R/规则：#W/分组为69以下精锐组、109以下神威组、129以下天科组、130以上天元组，组不组队都行，你可以单挑别人一群，输赢都有积分，比武结束后按积分排名。")
	elseif 事件=="进入比赛会场" then
		if not 比武大会数据.报名[id] then
			添加最后对话(id,"请先报名。")
			return
		end
		if self.进场开关 then
			地图处理类:跳转地图(id,1197,63,41)
		else
			添加最后对话(id,"活动还未正式开始，请耐心等待一下。距离进场还有【" ..self.进场倒计时 .."】",nil,self.进场倒计时)
		end
	elseif 事件=="我前来领取比赛奖励" then
		local pm={排名=0,分组=""}
	    if 比武大会数据.进程 == 0 then
            local fz={"精锐组","神威组","天科组","天元组"}
            for n=1,#fz do
           	   for k,v in pairs(比武大会数据[fz[n]]) do
           	   	  if v.id == id then
           	   	  	  pm.排名 = k
           	   	  	  pm.分组 = fz[n]
           	   	  end
           	   end
            end
	    else
	       添加最后对话(id,"比赛还没结束，无法领取奖励")
	       return
	    end
	    if pm.排名 ~= 0 then
	    	if 比武大会数据.玩家表[id].领取 == false then
	    		比武大会数据.玩家表[id].领取 = true
			    self:领取比赛奖励处理(id,pm.排名,pm.分组)
			else
			    添加最后对话(id,"少侠已领取奖励，无法继续领取#4")   --11.16
			end
		else
		   添加最后对话(id,"只有参赛的玩家才能领取奖励")
		end
	elseif 事件=="查询英雄榜以及积分" then
		local 待发送数据={}
	    local pm={排名=0,分组="",积分=0}
        local fz={"精锐组","神威组","天科组","天元组"}
        for n=1,#fz do
       	   for k,v in pairs(比武大会数据[fz[n]]) do
       	   	  if v.id == id then
       	   	  	  pm.排名 = k
       	   	  	  pm.积分 = v.积分
       	   	  	  pm.分组 = fz[n]
       	   	  end
       	   end
        end
        待发送数据.我的排名=pm
	    待发送数据["精锐组"]=比武大会数据["精锐组"]
	    待发送数据["神威组"]=比武大会数据["神威组"]
	    待发送数据["天科组"]=比武大会数据["天科组"]
	    待发送数据["天元组"]=比武大会数据["天元组"]
	    发送数据(玩家数据[id].连接id,1039,待发送数据)
	end --事件结束end
end

function 比武大会:领取比赛奖励处理(id,pm,fz) --id,排名,分组 这里给排名奖励 11.25改
	if 比武大会数据 == nil then print("比武大会数据为空(领取比赛奖励处理)") return end --防错
    local 百强=false
	if fz == "精锐组" then
		if 比武大会数据.精锐组 and 比武精锐组奖励[pm] ~= nil then
			local 经验=tonumber(比武精锐组奖励[pm].经验) or 1
			local 银子=tonumber(比武精锐组奖励[pm].银子) or 1
		    百强=true
		    玩家数据[id].角色:添加经验(经验,"比武奖励",1)
		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
		    for n=1,5 do
		    	local jlwp="物品" ..n
		    	if 比武精锐组奖励[pm][jlwp] then
		    		local jltable=比武精锐组奖励[pm][jlwp]
		    		if jltable[1] and jltable[2] and tonumber(jltable[2])~=nil then
		    			self:比武给予道具(id,jltable[1],jltable[2]+0)
		    		else
		    	        print("比武大会领奖励:未定义物品" ..jltable[1] )
		    		end
    		    end
		    end
		end
	elseif fz == "神威组" then
		if 比武大会数据.神威组 and 比武神威组奖励[pm] ~= nil then
			local 经验=tonumber(比武神威组奖励[pm].经验) or 1
			local 银子=tonumber(比武神威组奖励[pm].银子) or 1
		    百强=true
		    玩家数据[id].角色:添加经验(经验,"比武奖励",1)
		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
		    for n=1,5 do
		    	local jlwp="物品" ..n
		    	if 比武神威组奖励[pm][jlwp] then
		    		local jltable=比武神威组奖励[pm][jlwp]
		    		if jltable[1] and jltable[2] and tonumber(jltable[2])~=nil then
		    			self:比武给予道具(id,jltable[1],jltable[2]+0)
		    		else
		    	        print("比武大会领奖励:未定义物品" ..jltable[1] )
		    		end
    		    end
		    end
		end
	elseif fz == "天科组" then
		if 比武大会数据.天科组 and 比武天科组奖励[pm] ~= nil then
			local 经验=tonumber(比武天科组奖励[pm].经验) or 1
			local 银子=tonumber(比武天科组奖励[pm].银子) or 1
		    百强=true
		    玩家数据[id].角色:添加经验(经验,"比武奖励",1)
		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
		    for n=1,5 do
		    	local jlwp="物品" ..n
		    	if 比武天科组奖励[pm][jlwp] then
		    		local jltable=比武天科组奖励[pm][jlwp]
		    		if jltable[1] and jltable[2] and tonumber(jltable[2])~=nil then
		    			self:比武给予道具(id,jltable[1],jltable[2]+0)
		    		else
		    	        print("比武大会领奖励:未定义物品" ..jltable[1] )
		    		end
    		    end
		    end
		end
	elseif fz == "天元组" then
		if 比武大会数据.天元组 and 比武天元组奖励[pm] ~= nil then
			local 经验=tonumber(比武天元组奖励[pm].经验) or 1
			local 银子=tonumber(比武天元组奖励[pm].银子) or 1
		    百强=true
		    玩家数据[id].角色:添加经验(经验,"比武奖励",1)
		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
		    for n=1,5 do
		    	local jlwp="物品" ..n
		    	if 比武天元组奖励[pm][jlwp] then
		    		local jltable=比武天元组奖励[pm][jlwp]
		    		if jltable[1] and jltable[2] and tonumber(jltable[2])~=nil then
		    			self:比武给予道具(id,jltable[1],jltable[2]+0)
		    		else
		    	        print("比武大会领奖励:未定义物品" ..jltable[1] )
		    		end
    		    end
		    end
		end
	end
    if 百强 == false then
    	常规提示(id,"只有比武百强才能获得奖励")
    end
end

function 比武大会:比武给予道具(id,名称,数量)
	local 技能=nil
	local 等级=nil
	local 模式=1 --给予方式默认可叠加
	if 名称 == "灵饰指南书" or 名称 == "元灵晶石" then --数量就是它的等级，写世纪等级，例："元灵晶石":140
		if 数量 < 60 then
  	 	    数量={6,6}
  	 	elseif 数量 > 140 then
  	 	    数量={14,14}
  	    end
  	    等级 = 数量
  	    技能=灵饰范围[取随机数(1,#灵饰范围)]
  	    模式=2
  	elseif 名称 == "制造指南书"  then --少许物品有附加参数，你要添加可向我反映
  	    	if 数量 < 20 then
 	  	 	数量={2,2}
 	  	elseif 数量 >= 150 then
 	  	 	数量={15,15}
 	  	end
 	  	等级 = 数量
 	  	模式 = 3
 	elseif 名称 == "百炼精铁" then
 	  	等级 = 数量
 	  	模式 = 3
 	elseif 名称 == "仙玉" then
 		添加仙玉(id, 玩家数据[id].账号,qz(数量), "比武大会")
 		return
 	elseif 名称 == "未激活的符石" then
 		模式 = 2
 	    -- 技能 = 新三级符石[取随机数(1,#新三级符石)]
 	    等级 = 3
 	else
		local 临时道具=物品类(名称)
		临时道具:置对象(名称)
		if not 临时道具.可叠加 then
		  模式 = 2
		end
	end
	if 模式 == 1 then
		玩家数据[id].道具:给予道具(id,名称,数量,技能,nil,"不存共享")
	elseif 模式 == 2 then	--不可叠加
		if tonumber(数量) ~= nil and 数量 > 10 then --不可叠加物品限制发送数量
	 	   数量 = 10
	 	end
	 	for n=1,数量 do
 		    玩家数据[id].道具:给予道具(id,名称,等级,技能,nil,"不存共享")
 		end
	elseif 模式 == 3 then --只给书铁模式
		玩家数据[id].道具:给予道具(id,名称,等级,技能,"不存共享")
	end
end

function 比武大会:比武大会对话入场事件(id) --分组开打
	if 玩家数据[id].队伍~=0 and not 玩家数据[id].队长 then 常规提示(id,"不是队长不配和我说话") return end
	local id组 = {id}
	if 玩家数据[id].队伍~=0 then
	  id组={}
	  for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
	    id组[#id组+1] = 队伍数据[玩家数据[id].队伍].成员数据[i]
	  end
	end
	if not self:检查报名状态(id) then return end
	if self.按级分组 then
		local 分组信息=self:取比武大会入场参数(id)
		for i=1,#id组 do
		    local 队员分组=self:取比武大会入场参数(id组[i])
		    if 分组信息[2] ~= 队员分组[2] then
		      添加最后对话(id,玩家数据[id组[i]].角色.名称 .."等级分组与队长不一致，无法组队进入场地")
		      return false
		    end
		end
		for i=1,#id组 do
		    比武大会数据.玩家表[id组[i]]={积分=0,小组=分组信息[2],战败=0,地图=分组信息[1],领取=false} --11.16改
		    玩家数据[id组[i]].当前称谓="" ..分组信息[2] .."大赛成员"
		    地图处理类:系统更新称谓(id组[i],玩家数据[id组[i]].当前称谓)
	    end
	    local 临时yx=地图处理类.地图坐标[1197]:取随机点()
	    地图处理类:跳转地图(id,分组信息[1],临时yx.x,临时yx.y)
	else --若self.按级分组=false不分什么组就全服进一个地图PK
	    local 分组信息={5139,"天元组"}
	    for i=1,#id组 do
		    比武大会数据.玩家表[id组[i]]={积分=0,小组=分组信息[2],战败=0,地图=分组信息[1],领取=false} --11.16改
		    玩家数据[id组[i]].当前称谓="" ..分组信息[2] .."大赛成员"
		    地图处理类:系统更新称谓(id组[i],玩家数据[id组[i]].当前称谓)
	    end
	    local 临时yx=地图处理类.地图坐标[1197]:取随机点()
	    地图处理类:跳转地图(id,分组信息[1],临时yx.x,临时yx.y)
	end
end

function 比武大会:比武结束计算排名()
	local 精锐组jfsj={}
	local 神威组jfsj={}
	local 天科组jfsj={}
	local 天元组jfsj={}
	for k,v in pairs(比武大会数据.玩家表) do
		if 玩家数据[k] and 玩家数据[k].连接id then
			if v.小组 == "精锐组" then
				精锐组jfsj[#精锐组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			elseif v.小组 == "神威组" then
				神威组jfsj[#神威组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			elseif v.小组 == "天科组" then
				天科组jfsj[#天科组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			elseif v.小组 == "天元组" then
			    天元组jfsj[#天元组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			end
		end
	end
	if #精锐组jfsj > 0 then
		table.sort(精锐组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	if #神威组jfsj > 0 then
		table.sort(神威组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	if #天科组jfsj > 0 then
		table.sort(天科组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	if #天元组jfsj > 0 then
		table.sort(天元组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	for k,v in pairs(精锐组jfsj) do --排名
		比武大会数据.精锐组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	for k,v in pairs(神威组jfsj) do
		比武大会数据.神威组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	for k,v in pairs(天科组jfsj) do
		比武大会数据.天科组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	for k,v in pairs(天元组jfsj) do
		比武大会数据.天元组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	self:集体添加排名称谓()
    self:排行单位变更()
end



-- function 比武大会:集体添加排名称谓()
-- 	local pmcw={"冠军","季军","亚军"}
--     local hdcw=""
--     for k,v in pairs(比武大会数据.精锐组) do
--     	local pmfz="精锐组"
--     	local hdcw=""
--     	if k <= 5 then
--     		hdcw = pmfz ..pmcw[1]
--     	elseif k <= 10 then
--     	    hdcw = pmfz ..pmcw[2]
--     	elseif k <= 15 then
--     	    hdcw = pmfz ..pmcw[3]
--     	end
--     	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
--     		玩家数据[v.id].角色:添加称谓(hdcw)
--     	end
--     end
--     for k,v in pairs(比武大会数据.神威组) do
--     	local pmfz="神威组"
--     	local hdcw=""
--     	if k <= 5 then
--     		hdcw = pmfz ..pmcw[1]
--     	elseif k <= 10 then
--     	    hdcw = pmfz ..pmcw[2]
--     	elseif k <= 15 then
--     	    hdcw = pmfz ..pmcw[3]
--     	end
--     	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
--     		玩家数据[v.id].角色:添加称谓(hdcw)
--     	end
--     end
--     for k,v in pairs(比武大会数据.天科组) do
--     	local pmfz="天科组"
--     	local hdcw=""

--     	if k <= 5 then
--     		hdcw = pmfz ..pmcw[1]
--     	elseif k <= 10 then
--     	    hdcw = pmfz ..pmcw[2]
--     	elseif k <= 15 then
--     	    hdcw = pmfz ..pmcw[3]
--     	end
--     	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
--     		玩家数据[v.id].角色:添加称谓(hdcw)
--     	end
--     end
--     for k,v in pairs(比武大会数据.天元组) do
--     	local pmfz="天元组"
--     	local hdcw=""

--     	if k <= 5 then
--     		hdcw = pmfz ..pmcw[1]
--     	elseif k <= 10 then
--     	    hdcw = pmfz ..pmcw[2]
--     	elseif k <= 15 then
--     	    hdcw = pmfz ..pmcw[3]
--     	end
--     	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
--     		玩家数据[v.id].角色:添加称谓(hdcw)
--     	end
--     end
-- end
function 比武大会:集体添加排名称谓()
    local pmcw={"冠军","季军","亚军"}
    local hdcw=""
    local 过期时间 = os.time() + 7*24*3600
    for k,v in pairs(比武大会数据.精锐组) do
        local pmfz="精锐组"
        local hdcw=""
        if k <= 5 then
            hdcw = pmfz ..pmcw[1]
        elseif k <= 10 then
            hdcw = pmfz ..pmcw[2]
        elseif k <= 15 then
            hdcw = pmfz ..pmcw[3]
        end
        if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id then
            玩家数据[v.id].角色:添加称谓(hdcw, 过期时间)
        end
    end

    for k,v in pairs(比武大会数据.神威组) do
        local pmfz="神威组"
        local hdcw=""
        if k <= 5 then
            hdcw = pmfz ..pmcw[1]
        elseif k <= 10 then
            hdcw = pmfz ..pmcw[2]
        elseif k <= 15 then
            hdcw = pmfz ..pmcw[3]
        end
        if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id then
            玩家数据[v.id].角色:添加称谓(hdcw, 过期时间)
        end
    end

    for k,v in pairs(比武大会数据.天科组) do
        local pmfz="天科组"
        local hdcw=""
        if k <= 5 then
            hdcw = pmfz ..pmcw[1]
        elseif k <= 10 then
            hdcw = pmfz ..pmcw[2]
        elseif k <= 15 then
            hdcw = pmfz ..pmcw[3]
        end
        if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id then
            玩家数据[v.id].角色:添加称谓(hdcw, 过期时间)
        end
    end

    for k,v in pairs(比武大会数据.天元组) do
        local pmfz="天元组"
        local hdcw=""
        if k <= 5 then
            hdcw = pmfz ..pmcw[1]
        elseif k <= 10 then
            hdcw = pmfz ..pmcw[2]
        elseif k <= 15 then
            hdcw = pmfz ..pmcw[3]
        end
        if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id then
            玩家数据[v.id].角色:添加称谓(hdcw, 过期时间)
        end
    end
end

function 比武大会:取比武大会入场参数(id)
	local 等级=玩家数据[id].角色.等级
	  if 等级<=69 then
	    return {5136,"精锐组"}
	  elseif 等级<=109 then
	    return {5137,"神威组"}
	  elseif 等级<=129 then
	    return {5138,"天科组"}
	  elseif 等级>129 then
	    return {5139,"天元组"}
	  end
end

function 比武大会:检查报名状态(id)
	if 玩家数据[id].队伍==0 then
	    if 比武大会数据.报名[id]==nil then
	      添加最后对话(id,"你还没有在此次大会中报名，现在无法进入大会场地")
	      return false
	    end
    else
        for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
          local lsid = 队伍数据[玩家数据[id].队伍].成员数据[i]
          if 比武大会数据.报名[lsid] == nil then
            添加最后对话(id,玩家数据[lsid].角色.名称.."尚未在此次大会中报名,现在无法进入大会场地")
            return false
          end
        end
    end
    return true
end

function 比武大会:发起PK(id,内容)

	if 玩家数据[id].队伍 ~= 0 and 玩家数据[id].队长==false then
		常规提示(id,"#Y/只有队长才能触发战斗！")
		return
	end


	local PK地图=玩家数据[id].角色.地图数据.编号 or 内容.PK地图
	local 对手id=内容.序列
	if 玩家数据[对手id] == nil then return 常规提示(id,"#Y/对方不在线！") end
	local 对手地图=玩家数据[对手id].角色.地图数据.编号
	if 比武大会数据.进程 == 3 and self.正式PK then
	    if (PK地图==1197 or PK地图==5136 or PK地图==5137 or PK地图==5138 or PK地图==5139) and (对手地图==1197 or 对手地图==5136 or 对手地图==5137 or 对手地图==5138 or 对手地图==5139) then
		   战斗准备类:创建玩家战斗(id, 200003, 对手id, PK地图)
		else
		   常规提示(id,"#Y/对方或你不在比武地图中！")
		end
	end
end

function 比武大会:PK胜利处理(胜利组,失败组)
    -- 检查活动是否开启
    if not self.活动开关 then
        return
    end

    -- 安全检查：确保关键数据结构存在
    if not 玩家数据 or not 比武大会数据 or not 比武大会数据.玩家表 then
        print("错误：玩家数据或比武大会数据未初始化")
        return
    end

    -- 检查胜利组和失败组是否有效（允许空组但不允许nil）
    胜利组 = 胜利组 or {}
    失败组 = 失败组 or {}

    -- 处理胜利组玩家
    for i=1,#胜利组 do
        local 胜利id = 胜利组[i]
        -- 检查玩家ID有效性
        if 胜利id and 玩家数据[胜利id] then
            -- 重置战斗状态
            玩家数据[胜利id].zhandou = 0

            -- 更新比武大会数据
            if 比武大会数据.玩家表[胜利id] then
                比武大会数据.玩家表[胜利id].积分 = (比武大会数据.玩家表[胜利id].积分 or 0) + (self.胜利积分 or 0)
                常规提示(胜利id, "#Y/获得本场胜利，积分+" .. (self.胜利积分 or 0))
            else
                print("警告：胜利玩家" .. 胜利id .. "不在比武大会玩家表中")
            end
        else
            print("警告：无效的胜利玩家ID或玩家数据不存在 - ID:" .. tostring(胜利id))
        end
    end

    -- 处理失败组玩家
    for i=1,#失败组 do
        local 失败id = 失败组[i]
        -- 检查玩家ID有效性
        if 失败id and 玩家数据[失败id] then
            -- 重置战斗状态
            玩家数据[失败id].zhandou = 0

            -- 确保玩家在比武大会数据中存在，不存在则初始化
            if not 比武大会数据.玩家表[失败id] then
                比武大会数据.玩家表[失败id] = {
                    积分 = 0,
                    战败 = 0
                }
                print("提示：为失败玩家" .. 失败id .. "初始化比武数据")
            end

            -- 更新战败积分（使用默认值防止nil）
            比武大会数据.玩家表[失败id].积分 = (比武大会数据.玩家表[失败id].积分 or 0) + (self.战败积分 or 0)
            -- 记录战败次数
            比武大会数据.玩家表[失败id].战败 = (比武大会数据.玩家表[失败id].战败 or 0) + 1

            -- 检查是否达到战败限制（但不结束战斗）
            if (比武大会数据.玩家表[失败id].战败 or 0) >= (self.战败限制 or 3) then
                -- 清除称谓
                玩家数据[失败id].当前称谓 = ""
                -- 安全调用地图处理类方法
                if 地图处理类 and 地图处理类.系统更新称谓 then
                    地图处理类:系统更新称谓(失败id, 玩家数据[失败id].当前称谓)
                end

                -- 安全调用队伍处理类方法
                -- if 队伍处理类 and 队伍处理类.退出队伍 then
                --     队伍处理类:退出队伍(失败id)
                -- end

                -- 安全调用地图跳转方法（不结束战斗）
                if 地图处理类 and 地图处理类.跳转地图 then
                    地图处理类:跳转地图(失败id, 1001, 214, 115)
                end

                -- 提示信息
                常规提示(失败id, "#Y/你已战败" .. (self.战败限制 or 3) .. "次，慢走不送！")
            else
                -- 未达限制的提示
                常规提示(失败id, "#Y/你已战败,获得" .. (self.战败积分 or 0) .. "积分")
            end
        else
            print("警告：无效的失败玩家ID或玩家数据不存在 - ID:" .. tostring(失败id))
        end
    end
end

function 比武大会:假人PK胜利处理(任务id,id组,战斗类型)--这里就是掉落了啊 如果我想加物品掉落呢 大概就是这样子了  你测试下恩
	if 任务数据[任务id]==nil then
		return
	end
	local id=id组[1]
	for n=1,#id组 do
		local 胜利id=id组[n]
		玩家数据[胜利id].zhandou = 0
		if 比武大会数据.玩家表[胜利id] then
		   比武大会数据.玩家表[胜利id].积分 = 比武大会数据.玩家表[胜利id].积分 + self.胜利积分
		   常规提示(胜利id,"#Y/获得本场胜利，积分+" ..self.胜利积分)
        end
		战斗奖励:其他奖励(胜利id,"假人PK胜利")
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
end

return 比武大会