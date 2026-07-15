-- @Author: baidwwy
-- @Date:   2023-11-28 22:56:30
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-06-11 14:22:13
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-11-18 17:50:32
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 对话处理类 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 五行_ = {"金","木","水","火","土"}
local 对话内容 = require("Script/对话处理类/NPC对话内容")()
local 对话处理 = require("Script/对话处理类/NPC对话处理")()
local NPC商业栏 = require("Script/对话处理类/商业对话")()
function 对话处理类:初始化()end

function 对话处理类:数据处理(id,序号,数字id,内容)
	数字id=数字id+0
	--id=id+0
	if 玩家数据[数字id].摊位数据~=nil then
		添加最后对话(数字id,"少侠还摆着摊呢，为了保证您的财物安全，少侠还是低调行事为上。")
		return
	elseif 收购数据[数字id]~=nil then
		添加最后对话(数字id,"少侠还摆着摊呢，为了保证您的财物安全，少侠还是低调行事为上。")
		return
	end



	if 序号==1501 then
		对话内容:索取对话内容(id,数字id,序号,内容)
	elseif 序号==1502 then
		if 内容[5] then
			发送公告("#S《外挂检测》#W名称：#R"..玩家数据[数字id].角色.名称.."#W；ID：#R"..数字id.."#W涉嫌使用外挂脚本，请大家相互监督，举报有奖！")
			广播消息({内容="#S《外挂检测》#W名称：#R"..玩家数据[数字id].角色.名称.."#W；ID：#R"..数字id.."#W涉嫌使用外挂脚本，请大家相互监督，举报有奖！",频道="gm"})
			return
		end

		对话处理:选项解析(id,数字id,序号,内容)
	elseif 序号==1503 then --
		NPC商业栏:购买商品(id,数字id,序号,内容)
	elseif 序号==1503.5 then --声望商店
		NPC商业栏:购买商品(id,数字id,序号,内容)
	elseif 序号 >= 1511 and 序号 <= 1519 then
	    处理生死劫NPC进入(数字id, 序号 - 1510)
	end
end
function 对话处理类:获取任务对话(x,y)end
function 对话处理类:更新(dt)end
function 对话处理类:显示(x,y)end
return 对话处理类
	-- elseif 序号==1504 then
		-- for i=1,#房屋数据 do
		-- 	--__S服务:输出(内容.房屋ID)
		-- 	if 房屋数据[i].ID == tonumber(内容.房屋ID) then
		-- 		发送数据(玩家数据[数字id].连接id,1023,{房屋数据[i]}) --
		-- 		地图处理类:跳转地图(数字id,房屋数据[i].庭院ID,14,49)
		-- 		return
		-- 	end
		-- end
		-- 常规提示(数字id,"#Y您查找的ID还没有房子！")
	-- elseif 序号==1505 then
		--self:仙玉充值(id,数字id,序号,内容)
-- 	elseif 序号==1511 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return  常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			玩家数据[数字id].角色.历劫.生死劫 ={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false}
-- 			战斗准备类:创建战斗(数字id+0,100066)
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[1]==false then
-- 				战斗准备类:创建战斗(数字id+0,100066)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫！")
-- 			end
-- 		end
-- 	elseif 序号==1512 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[1]==true and 玩家数据[数字id].角色.历劫.生死劫[2] == false then
-- 				战斗准备类:创建战斗(数字id+0,100067)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	elseif 序号==1513 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[2]==true and 玩家数据[数字id].角色.历劫.生死劫[3] == false then
-- 				战斗准备类:创建战斗(数字id+0,100068)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	elseif 序号==1514 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[3]==true and 玩家数据[数字id].角色.历劫.生死劫[4] == false then
-- 				战斗准备类:创建战斗(数字id+0,100069)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	elseif 序号==1515 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[4]==true and 玩家数据[数字id].角色.历劫.生死劫[5] == false then
-- 				战斗准备类:创建战斗(数字id+0,100070)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	elseif 序号==1516 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[5]==true and 玩家数据[数字id].角色.历劫.生死劫[6] == false then
-- 				战斗准备类:创建战斗(数字id+0,100071)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	elseif 序号==1517 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[6]==true and 玩家数据[数字id].角色.历劫.生死劫[7] == false then
-- 				战斗准备类:创建战斗(数字id+0,100072)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	elseif 序号==1518 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[7]==true and 玩家数据[数字id].角色.历劫.生死劫[8] == false then
-- 				战斗准备类:创建战斗(数字id+0,100073)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	elseif 序号==1519 then
-- 		if 玩家数据[数字id].角色.等级<120 or 玩家数据[数字id].角色.历劫.飞升==false then return 常规提示(数字id,"#Y您的等级不到120或没有飞升") end
-- 		if 玩家数据[数字id].角色.历劫.生死劫 == nil then
-- 			常规提示(数字id,"#Y请先渡上一劫！")
-- 		else
-- 			if 玩家数据[数字id].角色.历劫.生死劫[8]==true and 玩家数据[数字id].角色.历劫.生死劫[9] == false then
-- 				战斗准备类:创建战斗(数字id+0,100074)
-- 			else
-- 				常规提示(数字id,"#Y您已经渡过了此劫或上一劫没有渡过！")
-- 			end
-- 		end
-- 	end
-- end