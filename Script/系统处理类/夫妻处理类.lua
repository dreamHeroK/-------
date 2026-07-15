-- @Author: baidwwy
-- @Date:   2023-11-28 22:56:30
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-12-26 22:23:26
local 夫妻处理类 = class()
function 夫妻处理类:初始化() end

function 夫妻处理类:数据处理(连接id,序号,内容) --序号>6500 and 序号<=6600
    local 数字id = 内容.数字id+0
    if 序号==6550 then
		帮派PK:帮战报名处理(数字id,内容)
	elseif 序号==6551 then
		帮派PK:获取对战信息(连接id)
	elseif 序号==6552 then
		帮派PK:发起PK(数字id,内容)
	elseif 序号==6553 then
		帮派PK:铁锤点击(数字id,内容)
	elseif 序号==6558 then
		if not 决战大雁塔开始 then return 常规提示(数字id,"活动尚未开始") end
		简单_决战大雁塔:发起PK(数字id,内容)


	elseif 序号==6561 then--PK台PK
		local 自己id = 数字id
		local 对手id = 内容.序列
		if 玩家数据[自己id].队伍~=0 and 玩家数据[自己id].队长==false  then
			常规提示(自己id,"只有队长才可以进行切磋")
		    return
		end
		战斗准备类:创建玩家战斗(自己id, 200001, 对手id, 1001)
	elseif 序号==6562 then--PK台PK 单挑模式
		local 自己id = 数字id
		local 对手id = 内容.序列
		if 玩家数据[自己id].队伍~=0 then
			常规提示(自己id,"先解散队伍再单挑吧")
		    return
		elseif 玩家数据[对手id].队伍~=0  then
			常规提示(自己id,"对方先解散队伍再单挑吧")
		    return
		end
		战斗准备类:创建玩家战斗(自己id, 200001, 对手id, 1001, "单挑")
	elseif 序号==6565 then--观战
		local 自己id = 数字id
    		local 观战对象 = 内容.序列
    		if 玩家数据[观战对象]~=nil and 玩家数据[观战对象].角色.战斗开关 and  玩家数据[观战对象].zhandou ~= 0 then
			if 玩家数据[自己id].队伍 == 0 then
				玩家数据[自己id].zhandou = 玩家数据[观战对象].zhandou
				玩家数据[自己id].角色.战斗开关 = true
				地图处理类:设置战斗开关(自己id,true)
				战斗准备类.战斗盒子[玩家数据[自己id].zhandou]:进入观战(自己id,观战对象)
				观战记录 = true

				常规提示(自己id,"#Y/你进入了观战")
			else
				常规提示(自己id,"#Y/组队时不能观战")
			end
			return
		end
	elseif 序号==6566 then--比武场PK
		比武大会:发起PK(数字id,内容)
		-- local 对方id=内容.序列
		-- if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长==false  then
		-- 	常规提示(数字id,"只有队长才可以进行切磋")
		--     return
		-- end
		-- if 比武大会数据.阶段 == 3 then
		-- 	if 比武大会数据.玩家[对方id] ~= nil and 比武大会数据.玩家[对方id].间隔 + 40 < os.time() then
		-- 		战斗准备类:创建玩家战斗(数字id, 200003, 对方id, 1197)
		-- 	else
		-- 		常规提示(内容.数字id,"对方处于保护时间无法PK")
		-- 	end
		-- end
	elseif 序号==6566.1 then--比武场PK
		local 对方id=内容.序列
		if 玩家数据[数字id].队伍==0 or 玩家数据[对方id].队长==0  then
			常规提示(数字id,"只有队长才可以进行切磋")
		    return
		end

		if  比武大会.开启时间~=0 and  比武大会.开启时间<os.time()  then
			local id组=队伍数据[数字id].成员数据
			local id组1=队伍数据[对方id].成员数据
			--table.print(比武大会)
			if    比武大会.阵营[比武大会.数据[数字id].阵营]  <比武大会.人数限制  then
				常规提示(数字id,"本组赛事报名玩家不足")
		    	                return
			end
			for  n=1,#id组 do
			   local 临时id=id组[n]
			    if  not 比武大会.数据[临时id]	or  比武大会.数据[临时id].积分<=0 then
			    	常规提示(数字id,"玩家"..玩家数据[临时id].角色.名称.."比武次数不足或未报名")
		    	                return
			    end
			end

			for  n=1,#id组1 do
			   local 临时id=id组[n]
			    if  not 比武大会.数据[临时id]	or  比武大会.数据[临时id].积分<=0 then
			    	常规提示(数字id,"玩家"..玩家数据[临时id].角色.名称.."比武次数不足或未报名")
		    	                return
			    end
			end
			战斗准备类:创建玩家战斗(数字id, 200003, 对方id, 1197)
		else
		     if   比武大会.开启时间~=0  then
		          常规提示(数字id,"剩余准备时间:"..(比武大会.开启时间-os.time()).."秒")
		      else
		       常规提示(数字id,"比赛尚未开始")
		   end
		end
	elseif 序号==6567 then
		local 目标id=tonumber(内容.文本)+0
		local 自己id = 数字id
		if 玩家数据[目标id]==nil then
		    常规提示(自己id,"该玩家不在线无法查找！")
		    return
	    elseif 目标id==自己id then
	    	return
	    elseif 玩家数据[自己id].zhandou~=0 or 玩家数据[目标id].zhandou~=0 then
			常规提示(自己id,"对方正在战斗中")
			return
		elseif 玩家数据[自己id].角色.地图数据.编号~=玩家数据[目标id].角色.地图数据.编号 then
			常规提示(自己id,"对方离你太远了。")
			return
		elseif 玩家数据[自己id].角色.人气 <500 then
			常规提示(自己id,"少侠人气低于500，无法使用勾魂索功能")
			return
		end
		if 取安全区(目标id) then
			常规提示(自己id,"目标不在线或在安全区内")
		    return
		end

		local 对话="对方没有打开PK开关，你身上有阎罗勾魂索，PK失败将不损失装备，进入PK后双方将有300秒时间准备，确定发起PK么？"
		local xx={"确定","取消"}
		if 玩家数据[目标id].角色.PK开关==nil then
		    对话="你身上有阎罗勾魂索，PK失败将不损失装备，进入PK后双方将有300秒时间准备，确定发起PK么？"
		end
		玩家数据[自己id].勾魂索目标=目标id
		发送数据(玩家数据[自己id].连接id,1501,{名称="勾魂索PK",模型="",对话=对话,选项=xx})
	elseif 序号==6563 then--勾魂索PK
    	for k,v in pairs(勾魂索名单) do
    		if v.倒计时开始 then
    		    if v.主动==数字id or v.被动==数字id  then
    		        v.战斗开始 = true
    		        break
    		    end
    		end
    	end
	elseif 序号==6564 then--勾魂索10秒倒计时
		for k,v in pairs(勾魂索名单) do
    		if v.倒计时开始 then
    		    if v.主动==数字id then
    		        v.主动方确认 = true
		        elseif v.被动==数字id then
    		        v.被动方确认 = true
    		    end
    		    if v.被动方确认 and  v.主动方确认 then --勾魂索10秒倒计时
    		    	发送数据(玩家数据[v.主动].连接id,3708)
    		        发送数据(玩家数据[v.被动].连接id,3708)
    		        break
    		    end
    		end
    	end

    	elseif 序号==6569 then
        		local 目标id=tonumber(内容.文本)+0
		local 自己id = 数字id
		if 玩家数据[目标id]==nil then
		    	常规提示(自己id,"该玩家不在线无法查找！")
		    	return
	    	elseif 目标id==自己id then
	    		return
	    	elseif 玩家数据[自己id].zhandou~=0 or 玩家数据[目标id].zhandou~=0 then
			常规提示(自己id,"对方正在战斗中")
			return
		end
         		生死数据[目标id]={自己=目标id,对方=数字id}
         		添加最后对话(自己id,"战书已下达，等对方迎战！")
          		闪烁消息(目标id,"#K"..玩家数据[数字id].角色.名称.."#W对你发起生死战斗，请组织队伍做好迎战准备！")
            	发送公告(format("#Y 玩家#G [%s]#Y 对#G [%s]#Y发起生死战斗,大家快去皇宫门口观看!",玩家数据[数字id].角色.名称,玩家数据[目标id].角色.名称))
          		广播消息({内容=format("#Y/玩家:#G [%s]#Y对 #G/[%s]#Y/发起了生死挑战,大家快去皇宫门口观看！".."#"..取随机数(1,110),玩家数据[数字id].角色.名称,玩家数据[目标id].角色.名称),频道="xt"})

	elseif 序号==6580 then
		剑会:发起匹配请求(数字id,内容)
	elseif 序号==6581 then
		剑会:取消匹配(数字id,内容)
	elseif 序号==6582 then
		剑会:重新匹配(数字id,内容)
	elseif 序号==6583 then
		剑会:领取称谓(数字id)
	elseif 序号==6584 then
		剑会:剑会排行榜(数字id)
	elseif 序号==6584 then

	elseif 序号==6589 then
		local fssj={}
		fssj.阵法经验=玩家数据[数字id].角色.阵法经验
		fssj.学会阵法=玩家数据[数字id].角色.阵法
		fssj.加成=0.02
		发送数据(连接id,6590,fssj)
	end
end

function 夫妻处理类:判定双方房屋(id,id2)
	-- return {取房屋编号(id),取房屋编号(id2)}
end

function 夫妻处理类:判定结婚状态(id,id2)
	-- if 玩家数据[id].角色.姻缘.婚姻 == false and 玩家数据[id].角色.姻缘.配偶 == nil and 玩家数据[id2].角色.姻缘.婚姻 == false and 玩家数据[id2].角色.姻缘.配偶 == nil then
	-- 	return true
	-- else
	--    常规提示(id,"#Y请求失败数据错误")
	--    常规提示(id2,"#Y请求失败数据错误")
	--    return false
	-- end
end

function 夫妻处理类:发送求婚请求(id,id2)
	-- if self:判定结婚状态(id,id2) then
	-- 	local fhsj = self:判定双方房屋(id,id2)
	-- 	if fhsj[1] ~= 0 or fhsj[2] ~= 0 then
	-- 		self.发送数据={}
	-- 	    self.发送数据.模型="月老"
	-- 	    self.发送数据.名称="月老"
	-- 	    self.发送数据.对话=玩家数据[id].角色.名称.."向你发起结婚请求?#94"
	-- 	    self.发送数据.选项={"我同意求婚","我拒绝求婚!"}
	-- 	    发送数据(玩家数据[id2].连接id,1501,self.发送数据)
	-- 	else
	-- 		self.发送数据={}
	-- 	    self.发送数据.模型="月老"
	-- 	    self.发送数据.名称="月老"
	-- 	    self.发送数据.对话=玩家数据[id].角色.名称.."结婚双方必须有一方拥有房屋?#94"
	-- 	    发送数据(玩家数据[id].连接id,1501,self.发送数据)
	-- 	end
	-- end
end

function 夫妻处理类:拒绝求婚请求(id,id2)
	-- self.发送数据={}
 --    self.发送数据.模型="月老"
 --    self.发送数据.名称="月老"
 --    self.发送数据.对话=玩家数据[id].角色.名称.."拒绝了你的结婚请求?#94"
 --    发送数据(玩家数据[id2].连接id,1501,self.发送数据)
end

function 夫妻处理类:同意求婚请求(id,id2)
	-- if self:判定结婚状态(id,id2) then
	-- 	local fhsj = self:判定双方房屋(id,id2)
	-- 	if fhsj[1] ~= 0 or fhsj[2] ~= 0 then
	-- 		玩家数据[id].角色.姻缘.婚姻 = true
	-- 		玩家数据[id].角色.姻缘.配偶 = id2
	-- 		玩家数据[id].角色:添加称谓(玩家数据[id2].角色.名称.."的夫君")
	-- 		玩家数据[id2].角色.姻缘.婚姻 = true
	-- 		玩家数据[id2].角色.姻缘.配偶 = id
	-- 		玩家数据[id2].角色:添加称谓(玩家数据[id].角色.名称.."的娘子")
	-- 		if  fhsj[1] ~= 0 and fhsj[2] ~= 0 then
	-- 			房屋数据[fhsj[2]].注销 = true
	-- 			玩家数据[id].角色.姻缘.房屋所属ID = id
	-- 			玩家数据[id2].角色.姻缘.房屋所属ID = id
	-- 		else
	-- 			if fhsj[1] ~= 0 then
	-- 				玩家数据[id].角色.姻缘.房屋所属ID = id
	-- 				玩家数据[id2].角色.姻缘.房屋所属ID = id
	-- 			elseif fhsj[2] ~= 0  then
	-- 				玩家数据[id].角色.姻缘.房屋所属ID = id2
	-- 				玩家数据[id2].角色.姻缘.房屋所属ID = id2
	-- 			end
	-- 		end
	-- 		广播消息({内容=format("#S(大唐新闻快报)#Y玩家#R/%s#Y和#R/%s#Y在月老的公证下喜结连理，请大家祝福他们",玩家数据[id].角色.名称,玩家数据[id2].角色.名称),频道="xt"})
	-- 		--发送公告(format("#S(大唐新闻快报)#Y玩家#R/%s#Y和#R/%s#Y在月老的公证下喜结连理，请大家祝福他们",玩家数据[id].角色.名称,玩家数据[id2].角色.名称))
	-- 	else
	-- 		self.发送数据={}
	-- 	    self.发送数据.模型="月老"
	-- 	    self.发送数据.名称="月老"
	-- 	    self.发送数据.对话=玩家数据[id].角色.名称.."结婚双方必须有一方拥有房屋?#94"
	-- 	    发送数据(玩家数据[id].连接id,1501,self.发送数据)
	-- 	end
	-- end
end

function 夫妻处理类:同意求婚离婚(id,id2)
	-- 玩家数据[id].角色.姻缘.婚姻 = false
	-- 玩家数据[id].角色.姻缘.配偶 = nil
	-- 玩家数据[id].角色.姻缘.房屋所属ID = nil
	-- 玩家数据[id].角色:删除称谓(玩家数据[id2].角色.名称.."的夫君")
	-- 玩家数据[id2].角色.姻缘.婚姻 = false
	-- 玩家数据[id2].角色.姻缘.配偶 = nil
	-- 玩家数据[id2].角色.姻缘.房屋所属ID = nil
	-- 玩家数据[id2].角色:删除称谓(玩家数据[id].角色.名称.."的娘子")
	-- for i=1,#房屋数据 do
	--     if 房屋数据[i].注销 and (房屋数据[i].ID == id or 房屋数据[i].ID == id2) then
	--       房屋数据[i].注销 = false
	--     end
	-- end
	-- 广播消息({内容=format("#S(大唐新闻快报)#Y玩家#R/%s#Y和#R/%s#Y各奔东西，祝他们好聚好散",玩家数据[id].角色.名称,玩家数据[id2].角色.名称),频道="xt"})
end

return 夫妻处理类