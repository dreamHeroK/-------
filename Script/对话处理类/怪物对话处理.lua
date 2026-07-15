--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2026-03-05 10:54:47
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 场景类_GW活动对话 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 五行_ = {"金","木","水","火","土"}
sdfetewtew={}
sdfetewtew[1132]=1
sdfetewtew[1133]=1
sdfetewtew[1134]=1
sdfetewtew[1135]=1
sdfetewtew[1136]=1
sdfetewtew[1137]=1
sdfetewtew[1138]=1
sdfetewtew[1139]=1
sdfetewtew[1140]=1
sdfetewtew[1141]=1
sdfetewtew[1142]=1
sdfetewtew[1143]=1
sdfetewtew[1144]=1
sdfetewtew[1145]=1
sdfetewtew[1146]=1
sdfetewtew[1147]=1
sdfetewtew[1148]=1
sdfetewtew[1149]=1
sdfetewtew[1150]=1

sdfetewtew[1176]=1
sdfetewtew[1177]=1
sdfetewtew[1178]=1
sdfetewtew[1179]=1
sdfetewtew[1180]=1
sdfetewtew[1181]=1
sdfetewtew[1182]=1
sdfetewtew[1183]=1
sdfetewtew[1184]=1
sdfetewtew[1185]=1
sdfetewtew[1186]=1
sdfetewtew[1187]=1
sdfetewtew[1188]=1
sdfetewtew[1189]=1
sdfetewtew[1190]=1
sdfetewtew[1191]=1

sdfetewtew[1187.0]=1--宝石怪
sdfetewtew[1187.1]=1
sdfetewtew[1187.2]=1
sdfetewtew[1187.3]=1
sdfetewtew[1187.4]=1
sdfetewtew[1187.5]=1
sdfetewtew[1187.6]=1
sdfetewtew[1187.7]=1

sdfetewtew[1192]=1
sdfetewtew[1193]=1
sdfetewtew[1194]=1
sdfetewtew[1195]=1
sdfetewtew[1196]=1
sdfetewtew[1197]=1
sdfetewtew[1198]=1
sdfetewtew[1198]=1
sdfetewtew[1199]=1
sdfetewtew[1200]=1
sdfetewtew[1201]=1
sdfetewtew[1202]=1
sdfetewtew[1203]=1
sdfetewtew[1204]=1
sdfetewtew[1205]=1
sdfetewtew[1206]=1
sdfetewtew[1207]=1
sdfetewtew[1208]=1
sdfetewtew[1209]=1




sdfetewtew[748]=1
sdfetewtew[749]=1
sdfetewtew[750]=1
sdfetewtew[206]=1
sdfetewtew[7481]=1
sdfetewtew[7491]=1
sdfetewtew[7501]=1

sdfetewtew[1301]=1
sdfetewtew[1302]=1
sdfetewtew[1303]=1
sdfetewtew[1304]=1
sdfetewtew[1305]=1
sdfetewtew[1306]=1
sdfetewtew[1307]=1
sdfetewtew[1308]=1
sdfetewtew[1309]=1
sdfetewtew[1310]=1
sdfetewtew[1311]=1

sdfetewtew[1171]=1
sdfetewtew[1172]=1
sdfetewtew[1173]=1
sdfetewtew[1174]=1
sdfetewtew[1175]=1

sdfetewtew[108]=1
sdfetewtew[1202]=1
sdfetewtew[1203]=1
sdfetewtew[1204]=1
sdfetewtew[1205]=1
sdfetewtew[1206]=1
sdfetewtew[1207]=1
sdfetewtew[1208]=1
sdfetewtew[1209]=1
sdfetewtew[1210]=1

sdfetewtew[691]=1
sdfetewtew[692]=1
sdfetewtew[693]=1
sdfetewtew[694]=1
sdfetewtew[695]=1
sdfetewtew[696]=1
sdfetewtew[697]=1
sdfetewtew[698]=1
sdfetewtew[699]=1
sdfetewtew[700]=1
sdfetewtew[104]=1

sdfetewtew[1313]=1
sdfetewtew[1314]=1
sdfetewtew[1315]=1
sdfetewtew[1316]=1
sdfetewtew[1317]=1
sdfetewtew[1318]=1
sdfetewtew[1319]=1
sdfetewtew[1320]=1
sdfetewtew[1321]=1

sdfetewtew[710]=1
sdfetewtew[711]=1
sdfetewtew[712]=1
sdfetewtew[713]=1
sdfetewtew[714]=1
sdfetewtew[715]=1
sdfetewtew[716]=1
sdfetewtew[717]=1
sdfetewtew[718]=1
sdfetewtew[719]=1

sdfetewtew[800]=1
sdfetewtew[801]=1
sdfetewtew[802]=1
sdfetewtew[803]=1
sdfetewtew[804]=1
sdfetewtew[805]=1
sdfetewtew[806]=1
sdfetewtew[807]=1
sdfetewtew[808]=1
sdfetewtew[809]=1
sdfetewtew[810]=1
sdfetewtew[811]=1
sdfetewtew[812]=1
sdfetewtew[813]=1
sdfetewtew[814]=1
sdfetewtew[815]=1
sdfetewtew[816]=1
sdfetewtew[817]=1
sdfetewtew[818]=1
sdfetewtew[819]=1
sdfetewtew[820]=1
sdfetewtew[3488]=1


sdfetewtew[1350]=1
sdfetewtew[1351]=1
sdfetewtew[1352]=1
sdfetewtew[1353]=1
sdfetewtew[1354]=1
sdfetewtew[1355]=1


sdfetewtew[1500]=1
sdfetewtew[1501]=1
sdfetewtew[1502]=1
sdfetewtew[1503]=1
sdfetewtew[1504]=1
sdfetewtew[1505]=1
sdfetewtew[1506]=1
sdfetewtew[1507]=1
sdfetewtew[1508]=1
sdfetewtew[1509]=1
sdfetewtew[1510]=1
sdfetewtew[56]=1
sdfetewtew[8931]=1

sdfetewtew[1511]=1
sdfetewtew[1512]=1
sdfetewtew[1513]=1
sdfetewtew[1514]=1
sdfetewtew[1515]=1
sdfetewtew[1516]=1
sdfetewtew[1517]=1
sdfetewtew[1518]=1
sdfetewtew[1519]=1
sdfetewtew[1520]=1
sdfetewtew[1521]=1
sdfetewtew[1522]=1
sdfetewtew[1523]=1
sdfetewtew[1524]=1

sdfetewtew[1525]=1
sdfetewtew[1526]=1
sdfetewtew[1527]=1
sdfetewtew[1528]=1
sdfetewtew[1529]=1
sdfetewtew[1530]=1

sdfetewtew[1531]=1
sdfetewtew[1532]=1
sdfetewtew[1533]=1
sdfetewtew[1534]=1
sdfetewtew[1535]=1

sdfetewtew[1536]=1
sdfetewtew[1537]=1
sdfetewtew[1538]=1
sdfetewtew[1539]=1
sdfetewtew[1540]=1
sdfetewtew[1541]=1
sdfetewtew[1542]=1
sdfetewtew[1543]=1
sdfetewtew[1544]=1
sdfetewtew[1545]=1

sdfetewtew[5555]=1 --黑神话
sdfetewtew[5556]=1 --灭世魔帝
sdfetewtew[5557]=1 --群雄逐鹿
sdfetewtew[5558]=1 --善恶如来
sdfetewtew[5559]=1 --千机策
sdfetewtew[5560]=1 --云仙谣

for q = 530,570 do --所有归墟对话
sdfetewtew[q]=1
end

for x = 3010,3200 do --所有天命对话
sdfetewtew[x]=1
end

for a = 1550,1760 do --所有神器对话
sdfetewtew[a]=1
end

for n = 400,449 do --新手副本 --青丘迷雾 --五行斗法
sdfetewtew[n]=1
end

-- sdfetewtew[6505]=1
function 场景类_GW活动对话:初始化() end

function 场景类_GW活动对话:活动选项解析(连接id,数字id,序号,内容)
	if 任务数据[玩家数据[数字id].地图单位.标识] == nil then
		常规提示(数字id,"#Y/这只是个虚影")
		return
	end
	local 对话数据
	local rwid=玩家数据[数字id].地图单位.标识
 	local 类型=任务数据[rwid].类型
 	local 事件=内容[1]
 	local 名称=内容[3]
 	if 取队长权限(数字id)==false then return  end
 	if sdfetewtew[类型] then
 	      self:活动对话CL(数字id,名称,事件,类型,rwid)
	else
	 -- 	local fun = _G["怪物对话解析"..tostring(类型)]
		-- if 类型 >= 507 and 类型<= 522 then
		-- 	fun = _G["怪物对话解析"..tostring(508)]
		-- end
		-- if fun ~= nil  then
		-- 	对话数据 = fun(连接id,数字id,序号,内容)
		-- end
		local num=类型
		if 类型 >= 507 and 类型<= 522 then
			num=508
		end
		if __GWdh222[num] then
			对话数据 =  __GWdh222[num](连接id,数字id,序号,内容)
		end
	end
	if 对话数据 ~= nil then
		发送数据(连接id,1501,对话数据)
	end
end
function 场景类_GW活动对话:活动对话CL(数字id,名称,事件,类型,rwid)
	if 类型 >= 1132 and 类型<= 1150 then
		降妖伏魔:对话事件处理(数字id,名称,事件,类型,rwid)

	elseif 类型==56 then
		中秋任务:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 == 8931 then
	    	战神山任务:怪物对话处理(数字id,名称,事件,类型,rwid)

	elseif 类型>=3010 and 类型<= 3019 then
		副本_天命石猴:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=3020 and 类型<= 3029 then
		副本_天命通天:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=3030 and 类型<= 3043 then
		副本_天命金兜洞:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=3044 and 类型<= 3052 then
		副本_天命大闹:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=3053 and 类型<= 3069 then
		副本_天命水陆:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=3070 and 类型<= 3079 then
		副本_天命乌鸡:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=3080 and 类型<= 3089 then
		副本_天命红孩儿:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=3090 and 类型<= 3110 then
		副本_天命秘境:对话事件处理(数字id,名称,事件,类型)


	elseif 类型>=530 and 类型<= 539 then
		副本_归墟共生:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=540 and 类型<= 549 then
		副本_归墟激战:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=550 and 类型<= 559 then
		副本_归墟悟空:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=560 and 类型<= 569 then
		副本_归墟应变:对话事件处理(数字id,名称,事件,类型)

	elseif 类型>=400 and 类型<= 415 then
		副本_新手副本:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=420 and 类型<= 439 then
		副本_青丘迷雾:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=440 and 类型<= 449 then
		副本_五行斗法:对话事件处理(数字id,名称,事件,类型)

	elseif 类型>=1550 and 类型<= 1559 then
		副本_清泽谱之惠:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1560 and 类型<= 1569 then
		副本_华光玉之伤:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1570 and 类型<= 1579 then
		副本_星斗盘之约:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1580 and 类型<= 1589 then
		副本_天罡印之谋:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1590 and 类型<= 1599 then
		副本_四神鼎之怨:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1600 and 类型<= 1609 then
		副本_噬魂齿之争:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1610 and 类型<= 1619 then
		副本_昆仑镜之忆:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1620 and 类型<= 1629 then
		副本_泪痕碗之念:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1630 and 类型<= 1639 then
		副本_轩辕剑之陨:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1640 and 类型<= 1649 then
		副本_玲珑结之愿:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1650 and 类型<= 1659 then
		副本_墨魂笔之踪:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1660 and 类型<= 1669 then
		副本_月光草之逝:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1670 and 类型<= 1679 then
		副本_鸿蒙石之鉴:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1680 and 类型<= 1689 then
		副本_千机锁之梏:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1690 and 类型<= 1699 then
		副本_黄金甲之谜:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1700 and 类型<= 1709 then
		副本_莫愁铃之恩:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1710 and 类型<= 1719 then
		副本_独玄琴之思:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1720 and 类型<= 1729 then
		副本_明火珠之影:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1730 and 类型<= 1739 then
		副本_重铸黄金甲:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1740 and 类型<= 1749 then
		副本_魂印星斗盘:对话事件处理(数字id,名称,事件,类型)
		elseif 类型>=1750 and 类型<= 1759 then
		副本_神归昆仑镜:对话事件处理(数字id,名称,事件,类型)


	elseif 类型 == 206 then
		地煞星:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 748 then
		天罡星:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 749 then
		天罡星:三BOSS对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 750 then
		天罡星:头领对话事件处理(数字id,名称,事件,类型,rwid)

	-- elseif 类型 == 7481 then
	-- 	天罡星:对话事件处理(数字id,名称,事件,类型,rwid)
	-- elseif 类型 == 7491 then
	-- 	天罡星:三BOSS对话事件处理(数字id,名称,事件,类型,rwid)
	-- elseif 类型 == 7501 then
	-- 	天罡星:头领对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 >= 1301 and 类型<= 1311 then
		帮派迷宫:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 >= 1171 and 类型<= 1175 then
		投放怪:对话事件处理(数字id,名称,事件,类型)
	elseif (类型 >= 1176 and 类型 <= 1200) or (类型 >= 1500 and 类型 <= 1550) then  ---夏日炎炎 自写活动
		自写活动:对话事件处理(数字id,名称,事件,类型)

	elseif 类型 == 5555 then
		黑神话:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 5556 then
		灭世魔帝:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 5557 then
		群雄逐鹿:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 5558 then
		善恶如来:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 5559 then
		千机策:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 5560 then
		云仙谣:对话事件处理(数字id,名称,事件,类型,rwid)

	elseif 类型==108 then
		游泳活动:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 >= 1202 and 类型<= 1210 then
		帮派PK:怪物对话处理(数字id,名称,事件,类型,rwid)
	elseif 类型>=691 and 类型<= 700 then
		副本_一斛珠:对话事件处理(数字id,名称,事件,类型)
	elseif 类型==104 then
		二八星宿:怪物对话处理(数字id,名称,事件,类型,rwid)
	elseif 类型 >= 1350 and 类型<= 1399 then
		简单_决战大雁塔:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 >= 1313 and 类型<= 1321 then
		长安保卫战:怪物对话处理(数字id,名称,事件,类型,rwid)
	elseif 类型>=710 and 类型<= 719 then
		副本_通天河:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=800 and 类型<= 820 then
		副本_双城记:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 == 3488 then
	    比武大会:比武假人对话事件处理(数字id,名称,事件,类型,rwid)
	end
end
return 场景类_GW活动对话