--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2022-05-21 20:32:54
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 地图坐标类 = class()

function 地图坐标类:初始化(文件)
	collectgarbage("collect")
	self.dtwj = 文件+0
	self.mapzz = {}
	self.增加 = {x=0,y=0,z=0}
	self.db = {}
	-- __S服务:输出(文件)
	--self.map = require("Script/地图处理类/MAP")([[scene/]]..文件..".map")
	--地图数据存储[self.dtwj]={宽度=self.map.Width,高度=self.map.Height}
	--self.宽度,self.高度,self.行数,self.列数 = self.map.Width,self.map.Height,self.map.MapRowNum,self.map.MapColNum
	self.路径点={}
	self.map ={}
	self.寻路 ={}
end

function 地图坐标类:取随机点()
	local 临时路径点 = {}
	local 返回点 = {}
	临时路径点 = table.loadstring(读入文件([[maplj\]]..self.dtwj..[[.txt]]))
	local 随机点=取随机数(1,#临时路径点)
	返回点 = {x=临时路径点[随机点].x,y=临时路径点[随机点].y}
	return  返回点
end

function 地图坐标类:取附近点(x,y)
	local 临时路径点 = {}
	local 返回点 = {}
	local 临时表 = {}
	临时路径点 = table.loadstring(读入文件([[maplj\]]..self.dtwj..[[.txt]]))
	local 随机点=取随机数(1,#临时路径点)
	for k,v in pairs(临时路径点) do
		local 临时x,临时y = 临时路径点[k].x-x,临时路径点[k].y-y
		if 临时x > -10  and 临时x < 10 and 临时y > -10  and 临时y < 10 then
			临时表[#临时表+1] = {x=临时路径点[k].x,y=临时路径点[k].y}
		end
	end
	local 随机点=取随机数(1,#临时表)
	返回点 = {x=临时表[随机点].x,y=临时表[随机点].y}
	return  返回点
end

function 地图坐标类:更新(dt) end
function 地图坐标类:显示(x,y) end
return 地图坐标类