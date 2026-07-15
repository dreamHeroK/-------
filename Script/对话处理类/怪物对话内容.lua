-- @Author: baidwwy
-- @Date:   2023-11-28 22:56:30
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-03-05 10:54:47
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-11-22 19:56:22
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 场景类_GW单位对话 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 五行_ = {"金","木","水","火","土"}
trhrtutru={}
trhrtutru[1132]=1
trhrtutru[1133]=1
trhrtutru[1134]=1
trhrtutru[1135]=1
trhrtutru[1136]=1
trhrtutru[1137]=1
trhrtutru[1138]=1
trhrtutru[1139]=1
trhrtutru[1140]=1
trhrtutru[1141]=1
trhrtutru[1142]=1
trhrtutru[1143]=1
trhrtutru[1144]=1
trhrtutru[1145]=1
trhrtutru[1146]=1
trhrtutru[1147]=1
trhrtutru[1148]=1
trhrtutru[1149]=1
trhrtutru[1150]=1
trhrtutru[748]=1
trhrtutru[749]=1
trhrtutru[750]=1

trhrtutru[206]=1
trhrtutru[7481]=1
trhrtutru[7491]=1
trhrtutru[7501]=1

trhrtutru[1176]=1
trhrtutru[1177]=1
trhrtutru[1178]=1
trhrtutru[1179]=1
trhrtutru[1180]=1
trhrtutru[1181]=1
trhrtutru[1182]=1
trhrtutru[1183]=1
trhrtutru[1184]=1
trhrtutru[1185]=1
trhrtutru[1186]=1
trhrtutru[1187]=1
trhrtutru[1188]=1
trhrtutru[1189]=1
trhrtutru[1190]=1
trhrtutru[1191]=1

trhrtutru[1187.0]=1
trhrtutru[1187.1]=1
trhrtutru[1187.2]=1
trhrtutru[1187.3]=1
trhrtutru[1187.4]=1
trhrtutru[1187.5]=1
trhrtutru[1187.6]=1
trhrtutru[1187.7]=1---------宝石怪

trhrtutru[1192]=1
trhrtutru[1193]=1
trhrtutru[1194]=1
trhrtutru[1195]=1
trhrtutru[1196]=1
trhrtutru[1197]=1
trhrtutru[1198]=1

trhrtutru[1199]=1
trhrtutru[1200]=1


trhrtutru[1300]=1
trhrtutru[1301]=1
trhrtutru[1302]=1
trhrtutru[1303]=1
trhrtutru[1304]=1
trhrtutru[1305]=1
trhrtutru[1306]=1
trhrtutru[1307]=1
trhrtutru[1308]=1
trhrtutru[1309]=1
trhrtutru[1300]=1


trhrtutru[1301]=1
trhrtutru[1302]=1
trhrtutru[1303]=1
trhrtutru[1304]=1
trhrtutru[1305]=1
trhrtutru[1306]=1
trhrtutru[1307]=1
trhrtutru[1308]=1
trhrtutru[1309]=1
trhrtutru[1310]=1
trhrtutru[1311]=1

trhrtutru[1171]=1
trhrtutru[1172]=1
trhrtutru[1173]=1
trhrtutru[1174]=1
trhrtutru[1175]=1

trhrtutru[108]=1
trhrtutru[1202]=1
trhrtutru[1203]=1
trhrtutru[1204]=1
trhrtutru[1205]=1
trhrtutru[1206]=1
trhrtutru[1207]=1
trhrtutru[1208]=1
trhrtutru[1209]=1
trhrtutru[1210]=1

trhrtutru[691]=1
trhrtutru[692]=1
trhrtutru[693]=1
trhrtutru[694]=1
trhrtutru[695]=1
trhrtutru[696]=1
trhrtutru[697]=1
trhrtutru[698]=1
trhrtutru[699]=1
trhrtutru[700]=1

trhrtutru[104]=1
trhrtutru[106]=1
trhrtutru[6674]=1
trhrtutru[1159]=1

trhrtutru[1312]=1
trhrtutru[1313]=1
trhrtutru[1314]=1
trhrtutru[1315]=1


trhrtutru[710]=1
trhrtutru[711]=1
trhrtutru[712]=1
trhrtutru[713]=1
trhrtutru[714]=1
trhrtutru[715]=1
trhrtutru[716]=1
trhrtutru[717]=1
trhrtutru[718]=1
trhrtutru[719]=1

trhrtutru[800]=1
trhrtutru[801]=1
trhrtutru[802]=1
trhrtutru[803]=1
trhrtutru[804]=1
trhrtutru[805]=1
trhrtutru[806]=1
trhrtutru[807]=1
trhrtutru[808]=1
trhrtutru[809]=1
trhrtutru[810]=1
trhrtutru[811]=1
trhrtutru[812]=1
trhrtutru[813]=1
trhrtutru[814]=1
trhrtutru[815]=1
trhrtutru[816]=1
trhrtutru[817]=1
trhrtutru[818]=1
trhrtutru[819]=1
trhrtutru[820]=1
trhrtutru[3488]=1

trhrtutru[1350]=1
trhrtutru[1351]=1
trhrtutru[1352]=1
trhrtutru[1353]=1
trhrtutru[1354]=1
trhrtutru[1355]=1

trhrtutru[1500]=1
trhrtutru[1501]=1
trhrtutru[1502]=1
trhrtutru[1503]=1
trhrtutru[1504]=1
trhrtutru[1505]=1
trhrtutru[1506]=1
trhrtutru[1507]=1
trhrtutru[1508]=1
trhrtutru[1509]=1
trhrtutru[1510]=1
trhrtutru[56]=1
trhrtutru[8931]=1

trhrtutru[1511]=1
trhrtutru[1512]=1
trhrtutru[1513]=1
trhrtutru[1514]=1
trhrtutru[1515]=1
trhrtutru[1516]=1
trhrtutru[1517]=1
trhrtutru[1518]=1
trhrtutru[1519]=1
trhrtutru[1520]=1
trhrtutru[1521]=1
trhrtutru[1522]=1
trhrtutru[1523]=1
trhrtutru[1524]=1

trhrtutru[1525]=1
trhrtutru[1526]=1
trhrtutru[1527]=1
trhrtutru[1528]=1
trhrtutru[1529]=1
trhrtutru[1530]=1

trhrtutru[1531]=1
trhrtutru[1532]=1
trhrtutru[1533]=1
trhrtutru[1534]=1
trhrtutru[1535]=1

trhrtutru[1536]=1
trhrtutru[1537]=1
trhrtutru[1538]=1
trhrtutru[1539]=1
trhrtutru[1540]=1
trhrtutru[1541]=1
trhrtutru[1542]=1
trhrtutru[1543]=1
trhrtutru[1544]=1
trhrtutru[1545]=1

trhrtutru[5555]=1 --黑神话
trhrtutru[5556]=1 --灭世魔帝
trhrtutru[5557]=1 --群雄逐鹿
trhrtutru[5558]=1 --善恶如来
trhrtutru[5559]=1 --千机策
trhrtutru[5560]=1 --云仙谣


-- trhrtutru[6505]=1
for n = 530,570 do --归墟所有对话
trhrtutru[n]=1
end

for x = 3010,3200 do --所有天命对话
trhrtutru[x]=1
end

for q = 1550,1760 do --所有神器对话
trhrtutru[q]=1
end

for i = 400,449 do --新手副本 --青丘副本 --五行斗法
trhrtutru[i]=1
end

function 场景类_GW单位对话:初始化()

end

function 场景类_GW单位对话:地图单位对话(连接id,数字id,序列,标识,地图) --怪物对话
	local 类型=任务数据[标识].类型
	if 类型==103 then  return end
	if 玩家数据[数字id].zhandou~=0 then return  end
	玩家数据[数字id].地图单位={地图=地图,标识=标识,编号=序列,清空=true}
	local 对话数据={}

	if trhrtutru[类型] then
 	      对话数据=self:活动对话NR(数字id,序列,标识,地图,类型)
	else
		local num=类型
		if 类型 >= 507 and 类型<= 522 then
			num=508
		end
		if __GWdh111[num] then
			对话数据 =  __GWdh111[num](连接id,数字id,序列,标识,地图)
		else
			对话数据.模型=任务数据[标识].模型
			对话数据.名称=任务数据[标识].名称
		end
	end
	if 对话数据 ~= nil then
		if 玩家数据[数字id].地图单位 ~= nil then
			玩家数据[数字id].地图单位.对话={模型=对话数据.模型,名称=对话数据.名称}
		end
		玩家数据[数字id].最后对话={模型=对话数据.模型,名称=对话数据.名称}
	end
	发送数据(连接id,1501,对话数据)
end
function 场景类_GW单位对话:活动对话NR(数字id,序列,标识,地图,类型)
	local 对话数据={}
	if 类型 >= 1132 and 类型<= 1150 then
	    	对话数据 = 降妖伏魔:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型==8931 then
    		对话数据 = 战神山任务:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 56 then
		对话数据 = 中秋任务:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3010 and 类型<= 3019 then
	    对话数据 = 副本_天命石猴:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3020 and 类型<= 3029 then
	    对话数据 = 副本_天命通天:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3030 and 类型<= 3043 then
	    对话数据 = 副本_天命金兜洞:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3044 and 类型<= 3052 then
	    对话数据 = 副本_天命大闹:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3053 and 类型<= 3069 then
	    对话数据 = 副本_天命水陆:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3070 and 类型<= 3079 then
	    对话数据 = 副本_天命乌鸡:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3080 and 类型<= 3089 then
	    对话数据 = 副本_天命红孩儿:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=3090 and 类型<= 3110 then
	    对话数据 = 副本_天命秘境:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=530 and 类型<= 539 then
	    对话数据 = 副本_归墟共生:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=540 and 类型<= 549 then
	    对话数据 = 副本_归墟激战:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=550 and 类型<= 559 then
	    对话数据 = 副本_归墟悟空:怪物对话内容(数字id,类型,标识,地图)

	elseif 类型>=560 and 类型<= 569 then
	    对话数据 = 副本_归墟应变:怪物对话内容(数字id,类型,标识,地图)

	elseif 类型>=400 and 类型<= 415 then
	    对话数据 = 副本_新手副本:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=420 and 类型<= 439 then
	    对话数据 = 副本_青丘迷雾:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=440 and 类型<= 449 then
	    对话数据 = 副本_五行斗法:怪物对话内容(数字id,类型,标识,地图)

	elseif 类型>=1550 and 类型<= 1559 then
	    对话数据 = 副本_清泽谱之惠:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1560 and 类型<= 1569 then
	    对话数据 = 副本_华光玉之伤:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1570 and 类型<= 1579 then
	    对话数据 = 副本_星斗盘之约:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1580 and 类型<= 1589 then
	    对话数据 = 副本_天罡印之谋:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1590 and 类型<= 1599 then
	    对话数据 = 副本_四神鼎之怨:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1600 and 类型<= 1609 then
	    对话数据 = 副本_噬魂齿之争:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1610 and 类型<= 1619 then
	    对话数据 = 副本_昆仑镜之忆:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1620 and 类型<= 1629 then
	    对话数据 = 副本_泪痕碗之念:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1630 and 类型<= 1639 then
	    对话数据 = 副本_轩辕剑之陨:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1640 and 类型<= 1649 then
	    对话数据 = 副本_玲珑结之愿:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1650 and 类型<= 1659 then
	    对话数据 = 副本_墨魂笔之踪:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1660 and 类型<= 1669 then
	    对话数据 = 副本_月光草之逝:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1670 and 类型<= 1679 then
	    对话数据 = 副本_鸿蒙石之鉴:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1680 and 类型<= 1689 then
	    对话数据 = 副本_千机锁之梏:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1690 and 类型<= 1699 then
	    对话数据 = 副本_黄金甲之谜:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1700 and 类型<= 1709 then
	    对话数据 = 副本_莫愁铃之恩:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1710 and 类型<= 1719 then
	    对话数据 = 副本_独玄琴之思:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1720 and 类型<= 1729 then
	    对话数据 = 副本_明火珠之影:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1730 and 类型<= 1739 then
	    对话数据 = 副本_重铸黄金甲:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1740 and 类型<= 1749 then
	    对话数据 = 副本_魂印星斗盘:怪物对话内容(数字id,类型,标识,地图)
	    elseif 类型>=1750 and 类型<= 1759 then
	    对话数据 = 副本_神归昆仑镜:怪物对话内容(数字id,类型,标识,地图)


	elseif 类型 == 206 then
		对话数据 = 地煞星:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 748 then
		对话数据 = 天罡星:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 749 then
		对话数据 = 天罡星:三BOSS对话内容(数字id,序列,标识,地图)
	elseif 类型 == 750 then
		对话数据 = 天罡星:头领对话内容(数字id,序列,标识,地图)
	-- elseif 类型 == 7481 then
	-- 	对话数据 = 天罡星:怪物对话内容(数字id,序列,标识,地图)
	-- elseif 类型 == 7491 then
	-- 	对话数据 = 天罡星:三BOSS对话内容(数字id,序列,标识,地图)
	-- elseif 类型 == 7501 then
	-- 	对话数据 = 天罡星:头领对话内容(数字id,序列,标识,地图)
	elseif 类型 ==6674 or 类型 ==1159 then
		对话数据 = 彩虹争霸:怪物的对话(数字id,序列,标识,地图)
	elseif 类型 >= 1301 and 类型<= 1311 then
		对话数据 = 帮派迷宫:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 106 then
		对话数据 = 门派闯关:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 108 then
		对话数据 = 游泳活动:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 1171 and 类型<= 1175 then
		对话数据 = 投放怪:怪物对话内容(数字id,类型,标识,地图)
	elseif (类型 >= 1176 and 类型 <= 1200) or (类型 >= 1500 and 类型 <= 1550) then  ---夏日炎炎 自写活动
		对话数据 = 自写活动:怪物对话内容(数字id,类型,标识,地图)

	elseif 类型 == 5555 then
		对话数据 = 黑神话:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 5556 then
		对话数据 = 灭世魔帝:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 5557 then
		对话数据 = 群雄逐鹿:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 5558 then
		对话数据 = 善恶如来:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 5559 then
		对话数据 = 千机策:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 5560 then
		对话数据 = 云仙谣:怪物对话内容(数字id,序列,标识,地图)

	elseif 类型 >= 1202 and 类型<= 1210 then
		对话数据 = 帮派PK:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=691 and 类型<= 700 then
		对话数据 = 副本_一斛珠:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型==104 then
		对话数据 = 二八星宿:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 1350 and 类型<= 1399 then
		对话数据 = 简单_决战大雁塔:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 1312 and 类型<= 1315 then
		对话数据 = 长安保卫战:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=710 and 类型<= 719 then
		对话数据 = 副本_通天河:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=800 and 类型<= 820 then
		对话数据 = 副本_双城记:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 3488 then
        对话数据 = 比武大会:比武假人对话内容(数字id,类型,标识,地图)
	end
	return 对话数据
end
function 场景类_GW单位对话:获取任务对话(x,y)end
return 场景类_GW单位对话