local 战斗胜利 = class()
local jhf = string.format
local random = math.random
local qz=math.floor
local sj = 取随机数
--local 战斗奖励=require("Script/战斗处理类/战斗计算/战斗奖励")()

function 战斗胜利:初始化()

end

function 战斗胜利:胜利处理(胜利id,战斗数据,玩家PK,失败id)
    local RWID=战斗数据.任务id
    if RWID == nil then 常规提示(胜利id,"任务异常或副本数据已刷新") return end

    -- 新增：豁免快速战斗检测的战斗类型列表
    local 豁免快速检测类型 = {   --------不想实现快速战斗限制
        [200002] = true, -- 帮战
        [200003] = true, -- 比武大会
        [200004] = true, -- 剑会
        [200005] = true, -- 勾魂索
        [200006] = true, -- 勾魂索
        [154000] = true, -- 系统PK
        [154001] = true, -- 系统PK
        [410001] = true, -- 剑会天下单人
        [410003] = true, -- 剑会天下三人
        [410005] = true, -- 剑会天下五人
        -- 可以继续添加其他需要豁免的类型
    }
    -- 检测战斗是否过快结束（豁免类型不检测）
    if not 豁免快速检测类型[战斗数据.战斗类型] then
        local 战斗持续时间 = os.time() - 战斗数据.战斗计时
        if 战斗持续时间 < 战斗数据.快速战斗限制 then
            常规提示(胜利id,"战斗结束过快，无法获得奖励")


-- 仅修改日志内容部分
local 日志文件 = io.open("其他表/快速战斗监控.txt", "a")
if 日志文件 then
    local 记录内容 = string.format(
        "[%s] 人物ID:[%s] 账号:[%s] 触发快速战斗 类型:[%s] 持续时间:%d秒(限制:%d秒)\n",
        os.date("%Y-%m-%d %H:%M:%S"),
        tostring(胜利id),
        玩家数据[胜利id] and 玩家数据[胜利id].账号 or "未知",
        tostring(战斗数据.战斗类型),
        tonumber(战斗持续时间),
        tonumber(战斗数据.快速战斗限制)
    )
    日志文件:write(记录内容)
    日志文件:close()
end

self:怪物检测(RWID)
return
    end
end


    		local id组={}
    		if 玩家PK then
		local 胜利组={}
		local 失败组={}
		for n=1,#战斗数据.参战玩家 do
			local wjid=战斗数据.参战玩家[n].id
			-- 玩家数据[wjid].zhandou=0--C改
			if wjid and 玩家数据[wjid]~=nil and 玩家数据[wjid].角色 then
				if 战斗数据.参战玩家[n].队伍==胜利id then
					胜利组[#胜利组+1]=wjid
				elseif 战斗数据.参战玩家[n].队伍==失败id then
					失败组[#失败组+1]=wjid
				end
				local 编号=战斗数据:取参战编号(wjid,"角色")
				战斗数据:还原单位属性(编号)
			end
		end
		for n=1,#战斗数据.参战单位 do --还原BB属性
			if 战斗数据.参战单位[n].玩家id and 战斗数据.参战单位[n].类型=="bb" and 玩家数据[战斗数据.参战单位[n].玩家id]~=nil then
				战斗数据:还原单位属性(n)
			end
		end
		if 战斗数据.战斗类型==200002 then--帮战
			帮派PK:PK胜利处理(胜利组,失败组)
			return
		elseif 战斗数据.战斗类型==200003 then
			比武大会:PK胜利处理(胜利组,失败组)
			return





		elseif 战斗数据.战斗类型==200004 then--剑会
			剑会:PK胜利处理(胜利组,失败组)
			return
		elseif 战斗数据.战斗类型==200005 then--勾魂索
			self:胜利MOB_200005(胜利组)

		elseif 战斗数据.战斗类型==154000  then
			简单_决战大雁塔:系统胜利处理(胜利组)
			return
		elseif 战斗数据.战斗类型==200007 then
			简单_决战大雁塔:PK胜利处理(胜利组,失败组)
			return
		elseif 战斗数据.战斗类型==410001 then
      		任务处理类.剑会天下结算处理单人(胜利id,失败id)
      		elseif 战斗数据.战斗类型==410003 then
      		任务处理类.剑会天下结算处理三人(胜利id,失败id)
		elseif 战斗数据.战斗类型==410005 then
      		任务处理类.剑会天下结算处理五人(胜利id,失败id)
		end
		return
	else
		for n=1,#战斗数据.参战玩家 do
			if 战斗数据.参战玩家[n].队伍==胜利id and 玩家数据[战斗数据.参战玩家[n].id]~=nil then
				id组[#id组+1]=战斗数据.参战玩家[n].id
				local 编号=战斗数据:取参战编号(战斗数据.参战玩家[n].id,"角色")
				战斗数据:还原单位属性(编号)
			end
		end
		for n=1,#战斗数据.参战单位 do --还原BB属性
			if 战斗数据.参战单位[n].队伍==胜利id and 战斗数据.参战单位[n].类型=="bb" and 战斗数据.参战单位[n].玩家id and 玩家数据[战斗数据.参战单位[n].玩家id]~=nil then
				战斗数据:还原单位属性(n)
			end
		end
	end

	if 胜利id~=0 then
		战斗数据.玩家胜利=true
		战斗数据.战斗胜利=true
		local zhsda=tonumber(战斗数据.战斗类型)
		if zhsda ~= 120024  then
		战斗奖励:奖励事件(id组,RWID,战斗数据.战斗类型,战斗数据)
	    end

		if 战斗数据.战斗类型 == 134872 then --菜梦比武
			比武大会:假人PK胜利处理(RWID,id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==111001 then

      		任务处理类.剑会天下结算处理假人(胜利id,失败id)
      		elseif 战斗数据.战斗类型==100136 then

		elseif (战斗数据.战斗类型>=120043 and 战斗数据.战斗类型<=120067) or 战斗数据.战斗类型==120069 then
			local fun = _G["胜利MOB_"..tostring(战斗数据.战斗类型)]
			if fun ~= nil then
				fun(胜利id,战斗数据)
			end
			return

		elseif 战斗数据.战斗类型>=130002 and  战斗数据.战斗类型<=130029 then
			彩虹争霸:战斗胜利处理(RWID,id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		-- elseif 战斗数据.战斗类型~=120024 and  战斗数据.战斗类型>=120010 and  战斗数据.战斗类型<=120045 then
		-- 	天罡星:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
		-- 	self:怪物检测(RWID)
		-- 	return
		elseif 战斗数据.战斗类型>=130030 and  战斗数据.战斗类型<=130035 then
			初识地宫:战斗胜利处理(id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130036 and  战斗数据.战斗类型<=130040 then
			文韵墨香:战斗胜利处理(id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130041 and  战斗数据.战斗类型<=130052 then
			天降辰星:战斗胜利处理(id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=103000 and 战斗数据.战斗类型<=103009 then
			副本_归墟共生:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=103010 and 战斗数据.战斗类型<=103019 then
			副本_归墟激战:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=103020 and 战斗数据.战斗类型<=103029 then
			副本_归墟悟空:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=103030 and 战斗数据.战斗类型<=103039 then
			副本_归墟应变:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100062 then
			中秋任务:战斗胜利处理(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=130053 and  战斗数据.战斗类型<=130063 then
			帮派迷宫:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100011 then
			门派闯关:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=111125 and  战斗数据.战斗类型<=111126 then
			地煞星:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105000  and 战斗数据.战斗类型<=105009  then
			副本_天命乌鸡:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105010  and 战斗数据.战斗类型<=105019  then
			副本_天命石猴:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105020 and 战斗数据.战斗类型<=105039 then
			副本_天命通天:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			if 战斗数据.战斗类型 == 105023 or 战斗数据.战斗类型 == 105024 or 战斗数据.战斗类型 == 105025 or 战斗数据.战斗类型 == 105026 then
				战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			end --连续战斗
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105040  and 战斗数据.战斗类型<=105049  then
			副本_天命大闹:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105050  and 战斗数据.战斗类型<=105065  then
			副本_天命金兜洞:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105070  and 战斗数据.战斗类型<=105089  then
			副本_天命水陆:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105090  and 战斗数据.战斗类型<=105105  then
			副本_天命红孩儿:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			if 战斗数据.战斗类型 == 105094 or 战斗数据.战斗类型 == 105095 or 战斗数据.战斗类型 == 105096 or 战斗数据.战斗类型 == 105097 or 战斗数据.战斗类型 == 105098 then
				战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			end --连续战斗
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=105110  and 战斗数据.战斗类型<=105129  then
			副本_天命秘境:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=102000 and 战斗数据.战斗类型<=102019 then
			副本_新手副本:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=102020 and 战斗数据.战斗类型<=102039 then
			副本_青丘迷雾:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=102040 and 战斗数据.战斗类型<=102049 then
			副本_五行斗法:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=150072 and  战斗数据.战斗类型<=150075 then
			五行年兽:完成五行年兽战斗任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==150175  then
			五行年兽:完成五行年兽战斗任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==150275 then
			五行年兽:完成五行年兽战斗任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据["战斗类型"] >= 160041 and 战斗数据["战斗类型"] <= 160049 then
			寻梦追忆:战斗胜利处理(id组, 战斗数据["战斗类型"])
			self:怪物检测(RWID)

			return

		elseif  战斗数据.战斗类型==160055 then
			黑神话:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==160056 then
			灭世魔帝:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==160057 then
			群雄逐鹿:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==160058 then
			善恶如来:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==160059 then
			千机策:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==160060 then
			云仙谣:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=121028 and  战斗数据.战斗类型<=121031 then
			简单_本命法宝:本命法宝完成检测(id组[1],战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100012 then
			游泳活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100224 then
			完成十八路妖王(RWID,id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=190201 and 战斗数据.战斗类型<=190216 then
			self:怪物检测(RWID)
			副本_通天河:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			if 战斗数据.战斗类型 == 190204 or 战斗数据.战斗类型 == 190205 or 战斗数据.战斗类型 == 190206 or 战斗数据.战斗类型 == 190207 then
				战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			end
			return
		elseif 战斗数据.战斗类型 == 155551 or 战斗数据.战斗类型 == 155552 or 战斗数据.战斗类型 == 155553 or 战斗数据.战斗类型 == 155554 then  --飞升
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型 >= 155565 and 战斗数据.战斗类型 <= 155569 then
			self:怪物检测(RWID)
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			return
		elseif 战斗数据.战斗类型>=155066  and 战斗数据.战斗类型<=155074 then
			副本_黑风山:完成黑风山任务(id组, RWID, 战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155576  and 战斗数据.战斗类型<=155585 then
			完成大闹天宫任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型 >= 155590  and 战斗数据.战斗类型 <= 155598 then
			完成齐天大圣任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型 >= 155599   and  战斗数据.战斗类型 <= 155607 then
			完成天火之殇上任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型 >= 155609  and 战斗数据.战斗类型 <= 155618 then
			完成无底洞任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型 >= 155619  and 战斗数据.战斗类型 <= 155630 then
			副本_秘境降妖:完成秘境降妖任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=190101 and 战斗数据.战斗类型<=190106 then
			self:怪物检测(RWID)
			副本_一斛珠:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			return
		elseif 战斗数据.战斗类型>=190301 and 战斗数据.战斗类型<=190316 then
			self:怪物检测(RWID)
			副本_双城记:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			return
		elseif 战斗数据.战斗类型==100009 then
			二八星宿:战斗胜利处理(id组,战斗数据.额外数据,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130066 and  战斗数据.战斗类型<=130082 then
			投放怪:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		-- elseif 战斗数据.战斗类型>=120046 and  战斗数据.战斗类型<=120047 then
		-- 	自写活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
		-- 	self:怪物检测(RWID)
		-- 	return
		-------------------------



		elseif 战斗数据.战斗类型==120068 or 战斗数据.战斗类型==150100 then
			自写活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=155559  and  战斗数据.战斗类型<=155566  then
			自写活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型>=160001  and  战斗数据.战斗类型<=160040 then--160026
			自写活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型>=160050  and  战斗数据.战斗类型<=160099 then
			自写活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130083 and  战斗数据.战斗类型<=130086 then
			帮派PK:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130087 and  战斗数据.战斗类型<=130096 then
			长安保卫战:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=100034 and  战斗数据.战斗类型<=100039 then
			地煞星:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100135 then
			梦魇夜叉:战斗胜利处理(id组,战斗数据.额外数据,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==140000 then
			雁塔地宫:战斗胜利处理(id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=140001 and  战斗数据.战斗类型<=140011 then
			剧情_飞升:战斗胜利处理(id组,战斗数据.战斗类型)
			if 战斗数据.战斗类型 == 140006 or 战斗数据.战斗类型 == 140007 or 战斗数据.战斗类型 == 140008 or 战斗数据.战斗类型 == 140009 then
				战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			end
			return

			--神器
		elseif 战斗数据.战斗类型>=170000  and 战斗数据.战斗类型<=170009  then
			副本_清泽谱之惠:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170010  and 战斗数据.战斗类型<=170019  then
			副本_华光玉之伤:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170020  and 战斗数据.战斗类型<=170029  then
			副本_星斗盘之约:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170030  and 战斗数据.战斗类型<=170039  then
			副本_天罡印之谋:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170040  and 战斗数据.战斗类型<=170049  then
			副本_四神鼎之怨:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			if 战斗数据.战斗类型 == 170042 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
		end
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170050  and 战斗数据.战斗类型<=170059  then
			副本_噬魂齿之争:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型==121001  then
			十二生肖:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==160071  then
			武神坛服战:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return

		---------------------佬伍修改（增加种族秘境时空之钥）---------------------------
		elseif 战斗数据.战斗类型==180003  then
			人族_车迟国:完成人族_车迟国任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180004  then
			人族_车迟国:完成人族_车迟国任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180007  then
			人族_车迟国:完成人族_车迟国任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180010  then
			人族_车迟国:完成人族_车迟国任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180011  then
			人族_车迟国:完成人族_车迟国任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180012  then
			人族_车迟国:完成人族_车迟国任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180015  then
			人族_九曲神林:完成人族_九曲神林任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180016  then
			人族_九曲神林:完成人族_九曲神林任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180019  then
			人族_九曲神林:完成人族_九曲神林任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180022 and 战斗数据.战斗类型<=180024 then
			人族_九曲神林:完成人族_九曲神林任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180027 then
			魔族_阴府勾魂:完成魔族_阴府勾魂任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180028 then
			魔族_阴府勾魂:完成魔族_阴府勾魂任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180030 then
			魔族_阴府勾魂:完成魔族_阴府勾魂任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180036 then
			魔族_九黎魔影:完成魔族_九黎魔影任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180037 then
			魔族_九黎魔影:完成魔族_九黎魔影任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180040 then
			魔族_九黎魔影:完成魔族_九黎魔影任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180043 then
			魔族_九黎魔影:完成魔族_九黎魔影任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180045 and 战斗数据.战斗类型<=180046 then
			魔族_九黎魔影:完成魔族_九黎魔影任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180033 and 战斗数据.战斗类型<=180035 then
			魔族_阴府勾魂:完成魔族_阴府勾魂任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180055 and 战斗数据.战斗类型<=180057 then
			魔族_陷空妖洞:完成魔族_陷空妖洞任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180049 and 战斗数据.战斗类型<=180050 then
			魔族_陷空妖洞:完成魔族_陷空妖洞任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180053 then
			魔族_陷空妖洞:完成魔族_陷空妖洞任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180050 then
			魔族_陷空妖洞:完成魔族_陷空妖洞任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=180065 and 战斗数据.战斗类型<=180067 then
			仙族_金甲天门:完成仙族_金甲天门任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180059 then
			仙族_金甲天门:完成仙族_金甲天门任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180060 then
			仙族_金甲天门:完成仙族_金甲天门任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180063 then
			仙族_金甲天门:完成仙族_金甲天门任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=180075 and 战斗数据.战斗类型<=180077 then
			仙族_万雷神殿:完成仙族_万雷神殿任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180070 then
			仙族_万雷神殿:完成仙族_万雷神殿任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180071 then
			仙族_万雷神殿:完成仙族_万雷神殿任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180073 then
			仙族_万雷神殿:完成仙族_万雷神殿任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型==180080 then
			人族_暗偃禁地:完成人族_暗偃禁地任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180081 then
			人族_暗偃禁地:完成人族_暗偃禁地任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180084 then
			人族_暗偃禁地:完成人族_暗偃禁地任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180087 and 战斗数据.战斗类型<=180089 then
			人族_暗偃禁地:完成人族_暗偃禁地任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return


		elseif 战斗数据.战斗类型>=180098 and 战斗数据.战斗类型<=180100 then
			人族_女国迷阵:完成人族_女国迷阵任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180096 then
			人族_女国迷阵:完成人族_女国迷阵任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180092 and 战斗数据.战斗类型<=180093 then
			人族_女国迷阵:完成人族_女国迷阵任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=180102 and 战斗数据.战斗类型<=180103 then
			魔族_狮驼洞穴:完成魔族_狮驼洞穴任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180106 then
			魔族_狮驼洞穴:完成魔族_狮驼洞穴任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180109 and 战斗数据.战斗类型<=180111 then
			魔族_狮驼洞穴:完成魔族_狮驼洞穴任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型>=180119 and 战斗数据.战斗类型<=180121 then
			魔族_火焰山之子:完成魔族_火焰山之子任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180116 then
			魔族_火焰山之子:完成魔族_火焰山之子任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180113 and 战斗数据.战斗类型<=180114 then
			魔族_火焰山之子:完成魔族_火焰山之子任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180123 and 战斗数据.战斗类型<=180124 then
			仙族_龙王秘宝:完成仙族_龙王秘宝任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180127 then
			仙族_龙王秘宝:完成仙族_龙王秘宝任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180130 and 战斗数据.战斗类型<=180132 then
			仙族_龙王秘宝:完成仙族_龙王秘宝任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180137 then
			仙族_大闹天宫:完成仙族_大闹天宫任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180134 and 战斗数据.战斗类型<=180135 then
			仙族_大闹天宫:完成仙族_大闹天宫任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180139 and 战斗数据.战斗类型<=180141 then
			仙族_大闹天宫:完成仙族_大闹天宫任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180146 then
			人族_青丘秘辛:完成人族_青丘秘辛任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180143 and 战斗数据.战斗类型<=180144 then
			人族_青丘秘辛:完成人族_青丘秘辛任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180148 and 战斗数据.战斗类型<=180150 then
			人族_青丘秘辛:完成人族_青丘秘辛任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return


		elseif 战斗数据.战斗类型==180155 then
			仙族_沧海狂龙:完成仙族_沧海狂龙任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180152 and 战斗数据.战斗类型<=180153 then
			仙族_沧海狂龙:完成仙族_沧海狂龙任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=180157 and 战斗数据.战斗类型<=180159 then
			仙族_沧海狂龙:完成仙族_沧海狂龙任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return

		elseif  战斗数据.战斗类型==180151  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180154  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180156  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180142  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180145  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180147  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180133  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180136  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180138  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180122  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180125 or 战斗数据.战斗类型==180126 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180128 or 战斗数据.战斗类型==180129 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180117 or 战斗数据.战斗类型==180118 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180112  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180115  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180090 or 战斗数据.战斗类型==180091 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180094 or 战斗数据.战斗类型==180095 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180101  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180104 or 战斗数据.战斗类型==180105 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		-- elseif  战斗数据.战斗类型==180107 or 战斗数据.战斗类型==180108 then
		-- 	战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
		-- 	self:怪物检测(RWID)
		-- 	return
		elseif  战斗数据.战斗类型==180107  then ----------佬伍修改（修复魔族狮驼副本战斗卡住）
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 2
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180097 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180078 or 战斗数据.战斗类型==180079 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180082 or 战斗数据.战斗类型==180083 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180085 or 战斗数据.战斗类型==180086 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180072 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180068 or 战斗数据.战斗类型==180069 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180074  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180058 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180061 or 战斗数据.战斗类型==180062 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180064  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180047 or 战斗数据.战斗类型==180048 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180051 or 战斗数据.战斗类型==180052 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180054  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180038 or 战斗数据.战斗类型==180039 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180041 or 战斗数据.战斗类型==180042 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180025 or 战斗数据.战斗类型==180026 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180029  then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif  战斗数据.战斗类型==180031 or 战斗数据.战斗类型==180032 then
			战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180020 or 战斗数据.战斗类型==180021	then
			    战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180017 or 战斗数据.战斗类型==180018	then
			    战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==180013 or 战斗数据.战斗类型==180014	then
			    战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
       		elseif 战斗数据.战斗类型==180001 or 战斗数据.战斗类型==180002	then
			    战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
        		elseif 战斗数据.战斗类型 == 180005 or 战斗数据.战斗类型 == 180006   then
                		战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
        		elseif 战斗数据.战斗类型 == 180008 or 战斗数据.战斗类型 == 180009   then
                		战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
-------------------------------佬伍修改（增加种族秘境时空之钥）---------------------------

		elseif 战斗数据.战斗类型>=170060  and 战斗数据.战斗类型<=170069  then
			副本_昆仑镜之忆:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170070  and 战斗数据.战斗类型<=170079  then
			副本_泪痕碗之念:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170080  and 战斗数据.战斗类型<=170089  then
			副本_轩辕剑之陨:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170090  and 战斗数据.战斗类型<=170099  then
			副本_玲珑结之愿:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170100  and 战斗数据.战斗类型<=170109  then
			副本_墨魂笔之踪:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170110  and 战斗数据.战斗类型<=170119  then
			副本_月光草之逝:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170120  and 战斗数据.战斗类型<=170129  then
			副本_鸿蒙石之鉴:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=170130  and 战斗数据.战斗类型<=170139  then
			副本_千机锁之梏:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return



		elseif 战斗数据.战斗类型==100015 or 战斗数据.战斗类型==150055 or 战斗数据.战斗类型==100016 or 战斗数据.战斗类型==100018 or 战斗数据.战斗类型==100017 or 战斗数据.战斗类型==130064
			or 战斗数据.战斗类型==100028 or 战斗数据.战斗类型==100029 or 战斗数据.战斗类型==100030 or 战斗数据.战斗类型==100031   --乌鸡国
			or (战斗数据.战斗类型>=190001 and 战斗数据.战斗类型<=190007)  then  --五更寒

			local fun = _G["胜利MOB_"..tostring(战斗数据.战斗类型)]
			if fun ~= nil then
				fun(id组,战斗数据.战斗类型,RWID,战斗数据.同门死亡)
			end
			self:怪物检测(RWID)
			return
		end
		local fun = _G["胜利MOB_"..tostring(战斗数据.战斗类型)]
		if fun ~= nil then
			fun(胜利id,战斗数据,id组)
		end
		self:怪物检测(RWID)
	end
end

function 战斗胜利:胜利MOB_200005(id组)
	for n=1,#id组 do
		local 队员id=id组[n]
		if 玩家数据[队员id].已扣除勾魂索 then  --主动勾魂一方就算胜利也会扣人气
			-- 玩家数据[队员id].道具:给予道具(队员id,"无常勾魂索")
			玩家数据[队员id].已扣除勾魂索=nil
			玩家数据[队员id].角色:扣除人气(100)
		end
	end
end


function 战斗胜利:怪物检测(RWID)
	if RWID==nil or 任务数据[RWID]==nil then return  end
	任务数据[RWID].zhandou=nil
 --    if 任务数据[RWID].地图编号 and 任务数据[RWID].单位编号 then
	-- 	地图处理类:删除单位(任务数据[RWID].地图编号,任务数据[RWID].单位编号)
	-- 	任务数据[RWID]=nil
	-- end
end

return 战斗胜利