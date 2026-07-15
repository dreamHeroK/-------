





local 天罡星 = class()


function 天罡星:初始化()
	self.进度 = 1
end

function 天罡星:活动定时器()
	if 服务端参数.分钟=="30" and 服务端参数.秒+0==2 then
		--for i=1,2 do
		self:刷新资源()
		--end
	end
end

function 天罡星:刷新资源()
	local 任务id
	local 地图 = 1110
	local xy
	local 战斗名称
	local 名称
	local 武器数据
	local 模型
	local gw = {}
	for k,v in pairs(天罡星系统数据) do
		if v["刷新次序"] == self.进度 or v["刷新次序"] == math.fmod(self.进度,8)+1 then
			gw[#gw+1] = v
			gw[#gw]["名称"] = k
		end
	end
	for i=1,#gw do
		xy = 地图处理类.地图坐标[地图]:取随机点()
		任务id =取唯一任务(748)
		战斗名称 = gw[i]["名称"]
		名称 = gw[i]["名称"]
		武器数据 = gw[i]["武器数据"]
		模型 = gw[i]["造型"]
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3000,
			玩家id=0,
			名称=名称,
			战斗名称=战斗名称,
			模型=模型,
			等级=等级,
			难度= gw[i]["难度"],
			销毁=true,
			x=xy.x,
			y=xy.y,
			锦衣=gw[i]["锦衣数据"],
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=748
		}
		if 武器数据 ~= nil then
			任务数据[任务id]["武器"] = 武器数据["名称"]
			任务数据[任务id]["武器等级"] = 武器数据["等级"]
		end
		if Qu角色属性[模型]~= nil then
			任务数据[任务id]["门派"] = Qu角色属性[模型].门派[取随机数(1,#Qu角色属性[模型].门派)]
		else
			任务数据[任务id]["门派"] = "大唐官府"
		end
		地图处理类:添加单位(任务id)
	end
	广播消息({内容=format("#P(天罡星)#W神秘的#R天罡星#W带着天界宝物降临在了#Y大唐国境#W一带，只有智勇双全的强者才有机缘获得宝物，少侠敢来挑战么？#80",dtmc),频道="xt"})
	self.进度 = math.fmod(math.fmod(self.进度,8)+1,8)+1
end

function 天罡星:怪物对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou==nil then
		对话数据.对话="我乃"..对话数据.名称.."的幻影（"..任务数据[标识].难度.."星），少侠可愿与我一战？"
		对话数据.选项={"战就战，谁怕谁","我先准备一下吧"}
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	----------------
	 if 判断限制次数(id,"天罡星") then----限制刷怪
	 	对话数据.对话="玩家"..判断限制次数(id,"天罡星").."今日已经超过次数了"
	 	对话数据.选项=nil
	 end
	 -----------------------------
	return 对话数据
end

function 天罡星:对话事件处理(id,名称,事件,类型,rwid)
	--local 难度=任务数据[任务id].难度
	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
	if 取队伍人数(id)<5 and 调试模式==false then 常规提示(id,"#Y挑战天罡星最少必须由五人进行") return  end
	if 事件=="战就战，谁怕谁" then
		 if 任务数据[rwid].难度>=6 then
		        	-- if RpbARGB.b == "27.25.152.212" then --天天西游注释
		        	 if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求69级")
		        	 return
		        	 end

		        	-- else
			-- if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求129级")
			-- return
			-- end
		-- end
			战斗准备类:创建战斗(id,111130,rwid)
		elseif 任务数据[rwid].难度>=5 then
		        	-- if RpbARGB.b == "27.25.152.212" then --天天西游注释
		        	 if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求69级")
		        	 return
		        	 end

		        	-- else
			-- if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求129级")
			-- return
			-- end
		-- end
			战斗准备类:创建战斗(id,111127,rwid)
		elseif 任务数据[rwid].难度>=4 then
			-- if RpbARGB.b == "27.25.152.212" then --天天西游注释
		        	 if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求69级") return  end
		        	-- else
		         --      if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求109级") return  end
		          -- end
		              战斗准备类:创建战斗(id,111127,rwid)
		elseif 任务数据[rwid].难度>=3 then
			-- if RpbARGB.b == "27.25.152.212" then --天天西游注释
		        	 if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求69级") return  end
		        	-- else
		         --      if 取等级要求(id,69)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求,最低要求89级") return  end
		         --  end
		              战斗准备类:创建战斗(id,111127,rwid)

else
	战斗准备类:创建战斗(id,111127,rwid)
	任务数据[rwid].zhandou=true
                           end
	end
end
function 天罡星:战斗胜利处理2(id组,战斗类型,任务id)
	local id=id组[1]
	if 任务数据[任务id]==nil then
		return
	end
	local 难度=任务数据[任务id].难度
	local gl = 30
	if 难度==3 or 难度==4 then
	    gl=60
    	elseif 难度==5 then
	    gl=80
    	elseif 难度>=6 then
	    gl=100
	end
	for n=1,#id组 do
	    local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1800,2000)+难度*300000
		local 银子=等级*1000+难度*200000
		local 仙玉 = 取随机数(5,10)*难度+50
		local 积分 = 10*难度
		local 活跃=2*难度
		玩家数据[cyid].角色:添加天罡积分(积分)
                        玩家数据[cyid].角色:添加仙玉(仙玉,"天罡星",1)
		玩家数据[cyid].角色:添加经验(经验*HDPZ["天罡：星级1"].经验,"天罡星",1)
		玩家数据[cyid].角色:添加银子(银子*HDPZ["天罡：星级1"].银子,"天罡星",1)
		添加活跃(cyid,活跃)

	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	玩家数据[id].角色:刷新任务跟踪()

end

function 天罡星:战斗胜利处理(id组,战斗类型,任务id)
	local id=id组[1]
	if 任务数据[任务id]==nil then
		return
	end
	local 难度=任务数据[任务id].难度
	添加完成次数(id,"天罡星")  -----限制刷怪
	local gl = 30
	if 难度==3 or 难度==4 then
	    gl=60
    	elseif 难度==5 then
	    gl=80
    	elseif 难度>=6 then
	    gl=100
	end
	for n=1,#id组 do
	    local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1800,2000)+难度*300000
		local 银子=等级*1000+难度*200000
		local 仙玉 = 取随机数(5,10)*难度
		local 积分 = 10*难度
		local 活跃=2*难度
		-- local 活跃分 = 取随机数(20,30)*难度
		            -- 玩家数据[id].角色:添加活跃积分(活跃分)
		玩家数据[cyid].角色:添加天罡积分(积分)
		玩家数据[cyid].角色:添加仙玉(仙玉,"天罡星",1)
		玩家数据[cyid].角色:添加经验(经验*HDPZ["天罡：星级1"].经验,"天罡星",1)
		玩家数据[cyid].角色:添加银子(银子*HDPZ["天罡：星级1"].银子,"天罡星",1)
		添加活跃(cyid,活跃)

		    if 难度==1 then
            if 取随机数()<=HDPZ["天罡：星级1"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["天罡：星级1"].ITEM),"天罡：星级1")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end

		    elseif 难度==2 then
            if 取随机数()<=HDPZ["天罡：星级2"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["天罡：星级2"].ITEM),"天罡：星级2")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==3 then
            if 取随机数()<=HDPZ["天罡：星级3"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["天罡：星级3"].ITEM),"天罡：星级3")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==4 then
            if 取随机数()<=HDPZ["天罡：星级4"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["天罡：星级4"].ITEM),"天罡：星级4")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==5 then
            if 取随机数()<=HDPZ["天罡：星级5"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["天罡：星级5"].ITEM),"天罡：星级5")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==6 then
            if 取随机数()<=HDPZ["天罡：星级6"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["天罡：星级6"].ITEM),"天罡：星级6")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==7 then
            if 取随机数()<=HDPZ["天罡：星级6"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["天罡：星级6"].ITEM),"天罡：星级6")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    end
		end

	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
end

function 天罡星:三BOSS(id)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<5 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	elseif 玩家数据[id].角色.天罡积分 < 500 then
		常规提示(id,"#Y天罡积分不足500，无法挑战")
	              return
	end
    	local 任务id
	local 地图 = 1110
	local xy
	local 名称范围 ={"天魁星·高衍","天贵星·陈坎","天捷星·邓玉"}
	local 武器名称 ={"天龙破城","星瀚","碧海潮生"}
	local 武器等级 ={150,160,150}
	local 模型范围 ={"神天兵","逍遥生","巫蛮儿"}
	local i=math.random(1,3)
	xy = 地图处理类.地图坐标[地图]:取随机点()
	任务id =取唯一任务(749)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3000,
		玩家id=0,
		名称=名称范围[i],
		战斗名称=名称范围[i],
		武器 =武器名称[i],
		武器等级 =武器等级[i],
		模型=模型范围[i],
		等级=等级,
		难度= 6,
		销毁=true,
		x=xy.x,
		y=xy.y,
		锦衣="青花瓷",
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=749
	}
	地图处理类:添加单位(任务id)
	发送数据(玩家数据[id].连接id,1501,{名称=名称范围[i],模型=模型范围[i],对话="请前往大唐国境(#G"..xy.x..","..xy.y.."#W)挑战我的幻象。"})
	玩家数据[id].角色.天罡积分 = 玩家数据[id].角色.天罡积分 - 500
	常规提示(id,"#Y扣除天罡积分不足500")
	玩家数据[id].角色:添加任务(任务id)
end

function 天罡星:三BOSS对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou==nil then
		对话数据.对话="我乃天罡星座统领"..对话数据.名称.."的幻影#W，少侠可愿与我一战？"
		对话数据.选项={"战就战，谁怕谁","我先准备一下吧"}
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

function 天罡星:三BOSS对话事件处理(id,名称,事件,类型,rwid)
	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
	if 取队伍人数(id)<5 and 调试模式==false then 常规提示(id,"#Y挑战天罡星最少必须由五人进行") return  end
	if 取等级要求(id,109)==false  then 常规提示(id,"#Y/队伍中有成员等级不符合要求，最低要求109级") return  end
	if 事件=="战就战，谁怕谁" then
	战斗准备类:创建战斗(id,111128,rwid)
	任务数据[rwid].zhandou=true
              --副本数据.三BOSS.完成[临时id]=true
	end
end

-- function 天罡星:三BOSS时间(任务id)
-- 	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 then -- 任务时间到期
-- 		if 任务数据[任务id].zhandou==nil  then
-- 			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
-- 			任务数据[任务id]=nil
-- 		end
-- 	end
-- end

function 天罡星:三BOSS任务说明(玩家id,任务id) --前往#Y/%s(%s,%s)#W/#L/处降服#G/%s#R(当前第%s次)
	local 说明 = {}
	说明={"天罡星",format("星座部位首领：去#Y/%s(%s,%s)#W#L处击败#Y/%s#W。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y,任务数据[任务id].名称)}
	return 说明
end

function 天罡星:头领(id,rwid)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<5 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	-- elseif 玩家数据[id].角色.天罡积分 < 1000 then
	-- 	常规提示(id,"#Y天罡积分不足1000，无法挑战")
	--               return
	end

   	local 任务id
	local 地图 = 1110
	local xy
	local 战斗名称
	local 名称
	local 武器数据
	local 模型

		xy = 地图处理类.地图坐标[地图]:取随机点()
		任务id =取唯一任务(750)
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3000,
			玩家id=0,
			名称="黄真·心魔",
			战斗名称="黄真·心魔",
			武器 = "弦月",
			武器等级 = 160,
			模型="羽灵神",
			等级=等级,
			难度= 7,
			销毁=true,
			x=xy.x,
			y=xy.y,
			锦衣="浮生",
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=750
		}
		地图处理类:添加单位(任务id)
		--table.print(xy)
		--print(名称)
	发送数据(玩家数据[id].连接id,1501,{名称="黄真",模型="羽灵神",对话="请前往大唐国境(#G"..xy.x..","..xy.y.."#W)挑战我的心魔。"})
	-- 玩家数据[id].角色.天罡积分 = 玩家数据[id].角色.天罡积分 - 1000
	-- 常规提示(id,"#Y扣除天罡积分不足1000")
	玩家数据[id].角色:添加任务(任务id)
end

-- function 天罡星:头领时间(任务id)
-- 	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 then -- 任务时间到期
-- 		if 任务数据[任务id].zhandou==nil  then
-- 			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
-- 			任务数据[任务id]=nil
-- 		end
-- 	end
-- end
function 天罡星:头领任务说明(玩家id,任务id) --前往#Y/%s(%s,%s)#W/#L/处降服#G/%s#R(当前第%s次)
	local 说明 = {}
	说明={"天罡星",format("黄真：去#Y/%s(%s,%s)#W#L处击败#Y/%s#W。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y,任务数据[任务id].名称)}
	return 说明
end


function 天罡星:头领对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou==nil then
		对话数据.对话="我乃天罡星首领#R黄真的心魔#W，少侠可愿与我一战？"
		对话数据.选项={"战就战，谁怕谁","我先准备一下吧"}
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

function 天罡星:头领对话事件处理(id,名称,事件,类型,rwid)
	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
	if 取队伍人数(id)<5 and 调试模式==false then 常规提示(id,"#Y挑战天罡星最少必须由五人进行") return  end
	if 取等级要求(id,109)==false then 常规提示(id,"#Y/队伍中有成员等级不符合要求，最低要求109级") return  end
	if 事件=="战就战，谁怕谁" then
	    	战斗准备类:创建战斗(id,111129,rwid)
	        任务数据[rwid].zhandou=true
                      --副本数据.天罡头领.完成[临时id]=true
	end
end


return 天罡星