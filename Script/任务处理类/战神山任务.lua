-- @Author: baidwwy
-- @Date:   2024-11-06 18:06:42
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-12-18 18:00:36
local 战神山任务 = class()
function 战神山任务:初始化()
end

function 战神山任务:取对话内容(地图,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 4 then
		wb[1] = "少侠来此所为何事？"
		xx = {"奉上上古之符","我来帮战神创造储备箱（组队任务）","相关帮助","随便看看"}
		return{"巫师","巫师",wb[取随机数(1,#wb)],xx}
	end
	return
end

function 战神山任务:对话事件处理(id,名称,事件,地图)
	if 名称=="巫师" then
		if 武神山数据==nil then
			武神山数据={}
			写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
		end
		if 武神山数据.全服祈神值==nil then
			武神山数据.全服祈神值=0
			写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
		end
		local 祈神值 = 武神山数据.全服祈神值+0
		if 事件 == "奉上上古之符" then
			if 祈神值<蚩尤祈福值 then
				玩家数据[id].给予数据={类型=1,id=0,事件="上交灵符"}
				发送数据(玩家数据[id].连接id,3530,{道具=玩家数据[id].道具:索要道具1(id),名称=名称,类型="NPC",等级="无"})
			else
				添加最后对话(id,"蚩尤已经降临，蚩尤降临期间无法接取本任务")
			end
		elseif 事件 == "我来帮战神创造储备箱（组队任务）" then
			if 祈神值<蚩尤祈福值 then
				if 玩家数据[id].队伍 == 0 then
					常规提示(id,"#Y/请组队再来找我！")
					return
				else
					-- if 取活动限制(id,'战神任务组队')>=20 then  --关闭限制
					-- 	发送数据(玩家数据[id].连接id, 7, "#y/活动已上限！")
					-- 	return
					-- end
					local 队伍id=玩家数据[id].队伍
					local 通过 = false
					for n=1,#队伍数据[队伍id].成员数据 do
						local 临时id=队伍数据[队伍id].成员数据[n]
						local 队长任务id = 玩家数据[id].角色:取任务(8931)
						if 玩家数据[id].队长==false  then
							常规提示(id,"#Y/该任务必须由队长领取")
							return
						end
						if 玩家数据[临时id].角色:取任务(8931)~=0 then
							local 队员任务id = 玩家数据[临时id].角色:取任务(8931)
							if 队员任务id~=队长任务id then
								通过 = false
								常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."已经接取过此类任务")
								return
							else
								通过 = true
							end
						else
							通过 = true
						end
					end
					if 通过 then
						设置任务8931(id)
						return
					end
				end
			else
				添加最后对话(id,"蚩尤已经降临，蚩尤降临期间无法接取本任务")
			end
		elseif 事件 == "相关帮助" then
			添加最后对话(id,"#Y上古灵符#W：上交上古灵符增加全服祈神值\n#Y战神储备箱#W：5人组队完成的环任务（#R完成后增加全服祈神值#W）\n\n#G祈神值足够时蚩尤降临挑战开放")
		end
	end
end

function 战神山任务:怪物对话内容(id,类型,标识,地图)
	local 名称 = 任务数据[标识].名称
	local id组 =任务数据[标识].队伍组
	if 取任务符合id(id,标识)==false then 添加最后对话(id,"你是谁啊，我不认识你") return  end
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	对话数据.对话="什么人，竟敢骚扰本大爷！"
	对话数据.选项={"我是来消灭你的","路过"}
	return 对话数据
end

function 战神山任务:怪物对话处理(id,名称,事件,类型,rwid)
	local id组 =任务数据[rwid].队伍组
	if 取等级要求(id,40)==false and 调试模式==false then 常规提示(id,"#Y/需要等级40级或以上") return  end
	if 玩家数据[id].队伍 == 0 then 常规提示(id,"必须组队") return end
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local cyid=队伍数据[队伍id].成员数据[n]
		if 玩家数据[cyid] and 玩家数据[cyid].角色:取任务(8931) == 0 then
			常规提示(id,"#Y任务不一致或者某人未领取任务,无法进入战斗")
			return
		end
	end
	if 事件=="我是来消灭你的" then
		战斗准备类:创建战斗(id,155719,玩家数据[id].地图单位.标识)
	end
end

function 设置任务8931(id)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		添加最后对话(id,"#Y/该任务必须组队完成且由队长领取")
		return
	-- elseif 取活动限制(id,'战神任务组队')>=20 then  --关闭限制
	-- 	发送数据(玩家数据[id].连接id, 7, "#y/活动已上限！")
	-- 	return
	elseif 取队伍最低等级(玩家数据[id].队伍,40) then
		添加最后对话(id,"#Y/等级小于40级的玩家无法领取此任务")
		return
	elseif 取队伍任务(玩家数据[id].队伍,8931) then
		添加最后对话(id,"#Y/队伍中已有队员领取过此任务了")
		return
	elseif 玩家数据[id].角色:取任务(8931)~=0 then
		添加最后对话(id,"#Y/你已经有个邪灵暗影任务在进行了")
		return
	elseif not 服务端参数.单开模式 and 取队伍人数(id)<5 and 调试模式==false and not 玩家数据[id].角色.糖果VIP开关 then
		常规提示(id,"#Y此任务要求队伍人数不低于5人")
		return
	end
	local 任务id=id.."_8931_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	local 地图范围={1501,1092,1208,1226,1040,1070}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local 随机参数=取随机数()
	local 模型="夜罗刹"
	if 随机参数<=10 then
		模型="炎魔神"
	elseif 随机参数<=20 then
		模型="噬天虎"
	elseif 随机参数<=30 then
		模型="吸血鬼"
	elseif 随机参数<=40 then
		模型="龙龟"
	elseif 随机参数<=50 then
		模型="踏云兽"
	elseif 随机参数<=60 then
		模型="灵鹤"
	elseif 随机参数<=70 then
		模型="雾中仙"
	elseif 随机参数<=80 then
		模型="大力金刚"
	elseif 随机参数<=90 then
		模型="踏云兽"
	elseif 随机参数<=90 then
		模型="鬼将"
	end
	local 名称库 = {"邪魅","怨灵","凶恶","魔影"}
	local 种类库 = {"之鬼","之魂","之灵"}
	local 名称 = 名称库[取随机数(1,#名称库)]..模型..种类库[取随机数(1,#种类库)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	local x临时人物队伍={}
	if 玩家数据[id].队伍~=nil and 玩家数据[id].队伍~=0 then
		for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			if 队伍数据[玩家数据[id].队伍].成员数据[i]~=nil then
				x临时人物队伍[#x临时人物队伍+1]=队伍数据[玩家数据[id].队伍].成员数据[i]
			end
		end
	end
	任务数据[任务id]={
		领取人id=x临时人物队伍,
		id=任务id,
		起始=os.time(),
		结束=3600,
		玩家id=0,
		-- 销毁=true,
		队伍组=table.loadstring(table.tostring(队伍数据[玩家数据[id].队伍].成员数据)),
		名称=名称,
		模型=模型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=8931
	}
	地图处理类:添加单位(任务id)
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="巫师",模型="巫师",对话=format("邪灵暗影出现了，少侠需去寻找#Y/%s#W/消灭之，他就在#G/%s(%s,%s)",任务数据[任务id].名称,任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)})
	end
	return {坐标=xy,地图编号=地图}
end

function 胜利MOB_155719(胜利id,战斗数据,id组)
	if 武神山数据==nil then
                      武神山数据={}
                      写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
           end
           if 武神山数据.全服祈神值==nil then
                      武神山数据.全服祈神值=0
                      写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
           end
	for i=1,#id组 do
		local id=id组[i]
		local 等级=取队伍平均等级(玩家数据[id].队伍,id)
		local 经验=qz((等级*等级*40))
		local 银子=qz((等级*等级*10))
		玩家数据[id].角色:添加经验(经验*HDPZ["战神任务组队"].经验,"战神任务组队")
		玩家数据[id].角色:添加银子(银子*HDPZ["战神任务组队"].银子,"战神任务组队",1)
		武神山数据.全服祈神值=武神山数据.全服祈神值+1
		玩家数据[id].角色:取消任务(战斗数据.任务id)
		local 奖励参数=取随机数()
		if 取随机数()<=HDPZ["战神任务组队"].爆率 then
			local 链接 = {提示=format("#S(战神任务组队)#Y祝贺#G/%s#Y完成任务！喜获",玩家数据[id].角色.名称),频道="hd",结尾="#Y成功全服祈神度+1！#80"}
	                    	local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["战神任务组队"].ITEM),"战神任务组队")
	                    	if 数量== 9999 then --环
	                    		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
	                    	elseif 数量== 8888 then
				数量=nil
				玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接,名称)
	                    	else
	                    	            玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
	                    	end
		end
	end
            发送数据(玩家数据[id组[1]].连接id,1501,{名称="",模型="巫师",对话="需要我帮你传送回朱紫国皇宫吗?",选项={"送我回皇宫","取消"}})
	地图处理类:删除单位(任务数据[战斗数据.任务id].地图编号,任务数据[战斗数据.任务id].单位编号)
	任务数据[战斗数据.任务id]=nil
	if 武神山数据~=nil then
		if 武神山数据.全服祈神值~=nil then
			if 武神山数据.全服祈神值>=蚩尤祈福值 then--祈神值修改
				广播消息({内容=format("#Y/全服祈神值已满，蚩尤降临挑战现在开放，请各路英雄前往战神山挑战#46"),频道="xt"})
				发送公告("#Y/全服祈神值已满，蚩尤降临挑战现在开放，请各路英雄前往朱紫国皇宫挑战")
			end
		end
	end
	写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
end

function 胜利MOB_155720(胜利id,战斗数据,id组)
	local 玩家祈神值=0
	if 武神山数据==nil then
                      武神山数据={}
                      写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
           end
           if 武神山数据.全服祈神值==nil then
                      武神山数据.全服祈神值=0
                      写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
           end
           if 武神山数据[id组[1]]~=nil then
                      if 武神山数据[id组[1]].祈神值~=nil then
			玩家祈神值=玩家祈神值+ (武神山数据[id组[1]].祈神值 +0)
                      end
           end
           local 祈神值 = 玩家祈神值+(武神山数据.全服祈神值+0)
           local 通过 = false
	for i=1,#id组 do
		local id=id组[i]
		if  祈神值 >=蚩尤祈福值 then
			local 等级=取队伍平均等级(玩家数据[id].队伍,id)
			local 经验=qz((等级*等级*80))
			local 银子=qz((等级*等级*20))
			玩家数据[id].角色:添加经验(经验*HDPZ["战神封印蚩尤"].经验,"战神封印蚩尤")
			玩家数据[id].角色:添加银子(银子*HDPZ["战神封印蚩尤"].银子,"战神封印蚩尤",1)
			local 奖励参数=取随机数()
			if 取随机数()<=HDPZ["战神封印蚩尤"].爆率 then
				local 链接 = {提示=format("#P(战神封印蚩尤)#W玩家#Y%s#W完成全服挑战的蚩尤，蚩尤大喜特赠",玩家数据[id].角色.名称),频道="hd",结尾="#W！#80"}
		                    	local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["战神封印蚩尤"].ITEM),"战神封印蚩尤")
		                    	if 数量== 9999 then --环
		                    		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
		                    	elseif 数量== 8888 then
					数量=nil
					玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接,名称)
		                    	else
		                    	            玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
		                    	end
			end
			通过 = true
		else
			常规提示(id,"蚩尤降临已经被击败了，你还是慢了点！下次再接再厉")
		end
	end
	if 通过 then
		武神山数据.全服BUFF=1
		武神山数据.全服祈神值=0
		广播消息({内容=format("#P(蚩尤降临)#Y/%s#W/带领队伍经过一轮苦战，战胜了全服BOSS蚩尤，蚩尤为表嘉奖特此施展禁术，为全服玩家增加经验#R/%s倍#W持续时间一天#46",玩家数据[id组[1]].角色.名称,武神山数据.全服BUFF),频道="xt"})
		发送公告("#P(蚩尤降临)#Y"..玩家数据[id组[1]].角色.名称.."#W带领队伍经过一轮苦战，战胜了全服BOSS蚩尤，蚩尤为表嘉奖特此施展禁术，为全服玩家增加经验#R"..武神山数据.全服BUFF.."倍#W持续时间一天")
		写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
	end
end

function rwgx8931(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 then -- 任务时间到期
		if 任务数据[任务id].zhandou==nil  then
			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
			任务数据[任务id]=nil
		end
	end
end

function 任务说明8931(玩家id,任务id)
	local 说明 = {}
	说明={"邪灵暗影",format("去#G/%s#W/的#Y/(%s,%s) #W/找到#R/%s#W/并接受其挑战！剩下时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y,任务数据[任务id].名称)}
	return 说明
end

return 战神山任务