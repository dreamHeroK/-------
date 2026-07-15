-- @Author: baidwwy
-- @Date:   2023-11-28 22:56:30
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-04-23 10:19:33
local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local dssj = os.time()
local 定时器 = class()

function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			return unpack(r)
		elseif ... == "循环更新" then
			if os.time()-dssj>=1 then
				dssj = os.time()
				XSHDXH()
				-- 开奖系统:开奖()

			end

		else
			print("线程返回",...)
		end
	end
	self:启动(v)
end

function XSHDXH() --限时活动定时器
	-- 剑会活动定时器()---原剑会定时器

	剑会:活动定时器()
	-- 自写活动:活动定时器()----C改
	--十八妖王:活动定时器()
	慈心渡鬼:定时器()
	寻梦追忆:活动定时器()

	黑神话:活动定时器()
	灭世魔帝:活动定时器()
	群雄逐鹿:活动定时器()
	善恶如来:活动定时器()
	千机策:活动定时器()
	云仙谣:活动定时器()


	简单_决战大雁塔:活动定时器()
	公共世界BOOS:定时器()
	降妖伏魔:活动定时器()
	彩虹争霸:活动定时器()
	天降辰星:活动定时器()
	帮派迷宫:活动定时器()
	文韵墨香:活动定时器()
	门派闯关:活动定时器()
	游泳活动:活动定时器()
	-- 投放怪:活动定时器()
	帮派PK:活动定时器()
	地煞星:活动定时器()
	二八星宿:活动定时器()
	长安保卫战:活动定时器()
	天罡星:活动定时器()
	比武大会:活动定时器()
	local fz = 服务端参数.分钟 + 0
	local ms = 服务端参数.秒 + 0
	if ms==1 and (fz==0 or fz==10 or fz==20 or fz==30 or fz==40 or fz==50) then
		重置赐福材料价格()
	end
	辅助内挂类:挂机定时器()
end

function 定时器:启动(v)
	self.线程:启动(v)
	self.线程:置延迟(v)
end

function 定时器:发送(...)--这里是不定数据,如果是固定的,可以参考客户的多线程 纹理
	数据数量[0] = 数据数量[0]+1
	table.insert(线程发送数据,{...})
end

return 定时器