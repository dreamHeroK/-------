-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:39
-- @Last Modified by:   tangguo
-- @Last Modified time: 2026-05-26 18:39:56
-- @Author: ASUS
-- @Date:   2020-11-26 19:12:12
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-07 20:09:11
		Q_门派闯关={}
		Q_文韵墨香={}
		Q_天降辰星={}
function 整秒处理(时间)
	if 服务端参数.秒=="00" and 服务端参数.小时=="00" and 服务端参数.分钟=="00"then
		for n,v in pairs(玩家数据) do
	    		if 玩家数据[n].角色.决战积分~=nil then
				玩家数据[n].角色.决战积分=0
			end
		end
		押镖:重置数据()
		每日天罡 = {}
		for k, v in pairs(每日任务) do

			每日任务[k]={限时任务={},日常任务={},副本任务={},活跃度={当前=0,总活跃=0},签到数据={}}--{节日活动={},日常任务={},挑战竞技={},副本任务={},总活跃=0,领取活跃={}}
		end

		  全局次数限制 = {
   			抓鬼记录 = {限制 =f函数.读配置(程序目录.."配置文件.ini","特殊配置","抓鬼次数") +0 },
    			师门记录 = {限制 =f函数.读配置(程序目录.."配置文件.ini","特殊配置","师门次数") +0 },
    			江湖记录 = {限制 =f函数.读配置(程序目录.."配置文件.ini","特殊配置","初出江湖次数") +0},
  		}
		for k, v in pairs(代理充值) do
			  代理充值[k].充值.今日=0
		end
		for n, v in pairs(玩家数据) do
			刷新排行榜(n)
			-------------------------------------------------------C改
			找到节日=false
			for i=1,52 do
			        当前时间=os.date("%m月%d日")
			        节日时间=f函数.读配置(程序目录.."Shopping.ini","节日时间","节日时间"..i)
			        节日名称=f函数.读配置(程序目录.."Shopping.ini","节日名称","节日名称"..i)
			        if 当前时间==节日时间  and (玩家数据[n].角色.节日礼物==nil or 玩家数据[n].角色.节日礼物~=os.date("%m月%d日")) then
			        常规提示(n,"今天是#R/"..节日名称.."#W/，请前往长安节日礼物使者#Y/（208，152）#W/处领取节日礼物，祝您天天有个好心情！#77")
			        闪烁消息(n,"今天是#R/"..节日名称.."#W/，请前往长安节日礼物使者#Y/（208，152）#W/处领取节日礼物，祝您天天有个好心情！#77")
			          找到节日=true
			          节日开关=true
			          break
			        end
			      end
			-------------------------------------------------------C改

		end
		if 武神山数据~=nil  then
			if 武神山数据.全服BUFF~=nil  then
				武神山数据.全服BUFF=nil
				写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
			end
		end
		五行年兽限制={}
		房都尉答题数据={}
		Q_门派闯关={}
		Q_文韵墨香={}
		Q_天降辰星={}
		Q_跑环限制 = {}
		写出文件([[sql/跑环限制.txt]],table.tostring({}))
    		重置每日玩家刷怪次数()
		重置数据()
		发送公告("#G美好的一天从这一秒开始，游戏对应的活动任务数据已经刷新，合理安排时间，注意休息。")
		广播消息({内容="#G美好的一天从这一秒开始，游戏对应的活动任务数据已经刷新，合理安排时间，注意休息。".."#"..取随机数(1,110),频道="xt"})



		for n, v in pairs(任务数据) do
			if v.副本重置 then
				if 任务数据[n].地图编号 and 任务数据[n].单位编号 then
					地图处理类:删除单位(任务数据[n].地图编号,任务数据[n].单位编号)
				end
				任务数据[n]=nil
			end
		end
		剑会天下={}
    --剑会天下每日清空
    剑会天下单人匹配={}
    剑会天下三人匹配={}
    剑会天下五人匹配={}
    剑会天下次数统计={}
		-- for n, v in pairs(任务数据) do
		-- 	if 任务数据[n].类型==7 then
		-- 		local id=任务数据[n].玩家id
		-- 		if 玩家数据[id]~=nil then
		-- 			玩家数据[id].角色:取消任务(n)
		-- 			常规提示(id,"由于科举数据已经刷新，您本次的活动资格已经被强制取消，请重新参加此活动！")
		-- 		end
		-- 		任务数据[n]=nil
		-- 	end
		-- end



		雁塔地宫:每日下调()

		if tonumber(os.date("%w", os.time()))==1 then
		  	雁塔地宫:每周归零()
		  	-- 系统商城:刷新交易中心数量()
			for n, v in pairs(时空之钥) do--------------CC修改（增加种族秘境时空之钥）
				if 时空之钥[n]~=nil then
	               			时空之钥[n].境界=1
				end
			end
			for n, v in pairs(玩家数据) do
				if 玩家数据[n]~=nil then
	         				玩家数据[n].道具:更改时空之钥(n)
				end
			end-------------CC修改（增加种族秘境时空之钥）
			重置双龙挑战()
			local 路径 = [[其他表/奖池抽奖.txt]]
		      	local 文本内容 = 读入文件(路径)
		      	local 加载函数, 错误信息 = loadstring("return " .. 文本内容)
		      	if not 加载函数 then
		          		常规提示(id, "#R重置失败：奖池文件格式错误！")
		          		print("#R奖池文件语法错误：" .. 错误信息)  -- 控制台输出错误，方便你定位
		      	end
		      	当前抽奖数据 = 加载函数()
		      	for n,v in pairs(玩家数据) do
		     		local 玩家抽奖数据 = 玩家数据[n].角色.奖池抽奖 or {次数 = 0, 累计次数 = 0, 历史次数 = 0}
		      	end
		      	重置抽奖池物品数量(n, 当前抽奖数据, 路径, 玩家抽奖数据)
		      	广播消息({内容 = format("#G/[抽奖奖池]#Y/奖池已经自动进行了更新".."#"..51), 频道 = "xt"})

		elseif tonumber(os.date("%j",os.time())) == 1 then --每年归零
			全局签到数据 = {}
		elseif tonumber(os.date("%d")) == 1 then-----------每月
			print(每个月新的开始)
		end
	end

	if 服务器关闭 ~= nil and 服务器关闭.开关 then
		服务器关闭.计时=服务器关闭.计时-1
		__S服务:输出("服务器关闭倒计时："..服务器关闭.计时)
		广播消息({内容="#R/服务器关闭倒计时："..服务器关闭.计时,频道="xt"})
		if 服务器关闭.计时<=60 and 服务器关闭.计时>0 then
			广播消息({内容="#Y/服务器将在#R/"..服务器关闭.计时.."#Y/秒后关闭,请所有玩家立即下线。",频道="xt"})
		elseif 服务器关闭.计时<=1 then
			自动关闭服务器()
			return
		end
	end
	-- if os.time()-剑会匹配>=5 then---原剑会
	-- 	if 剑会天下开关 then
	-- 		系统处理类:剑会天下单人匹配处理()
	-- 		系统处理类:剑会天下三人匹配处理()
	-- 		系统处理类:剑会天下五人匹配处理()
	-- 	end
	-- 	剑会匹配=os.time()
 --  end


	-- if 迷宫数据.开关 then
	-- 	if os.time()-迷宫数据.事件>=300 then
	-- 		迷宫数据.事件=os.time()
	-- 		GetUpMOB201()
	-- 	end
	-- 	if os.time()-迷宫数据.起始>=3600 then
	-- 		迷宫数据={开关=false,起始=os.time()}
	-- 		广播消息({内容="#G/幻域迷宫活动已经结束，所有处于战斗中的玩家将被强制退出战斗。",频道="xt"})
	-- 		for n, v in pairs(战斗准备类.战斗盒子) do
	-- 			if 战斗准备类.战斗盒子[n].战斗类型==100019 then
	-- 				战斗准备类.战斗盒子[n]:结束战斗(0,0,1)
	-- 			end
	-- 		end
	-- 		for n, v in pairs(玩家数据) do
	-- 			if 玩家数据[n].角色:取任务(202)~=0 then
	-- 				玩家数据[n].角色:取消任务(玩家数据[n].角色:取任务(202))
	-- 				常规提示(n,"#Y你的幻域迷宫任务已经被自动取消")
	-- 			end
	-- 		end
	-- 		完成任务_201()
	-- 	end
	-- end

	if 科举.开关 and tonumber(os.date("%w", os.time())) ==5 and 服务端参数.小时 == "23" and 服务端参数.分钟 == "00"  then
		科举={开关=false,起始=os.time()}
		游戏活动类:科举单位变更()
    		广播消息({内容="#G/科举活动已结束。",频道="xt"})
	end

	if 宝藏山数据.开关 then
			宝藏山数据.间隔=宝藏山数据.间隔-1
		if 宝藏山数据.间隔==180 then
			地图处理类:当前消息广播1(5001,"#Y各位玩家请注意，宝藏山将在#R3#Y分钟后刷出宝箱。")
		elseif 宝藏山数据.间隔==60 then
			地图处理类:当前消息广播1(5001,"#Y各位玩家请注意，宝藏山将在#R1#Y分钟后刷出宝箱。")
		elseif 宝藏山数据.间隔<=0 then
			GetUpMOB203()
			宝藏山数据.间隔=300
		end
		if os.time()-宝藏山数据.起始>=3600 then
			宝藏山数据={开关=false,起始=os.time(),刷新=0,间隔=600}
			广播消息({内容="#G/宝藏山活动已经结束，处于场景内的玩家将被自动传送出场景。",频道="xt"})
			地图处理类:清除地图玩家(5001,1226,115,15)
			完成任务_203()
		end
	end
	if 皇宫飞贼.开关 and os.time()-皇宫飞贼.起始>=3600  then
		皇宫飞贼={开关=false,起始=os.time(),贼王={}}
		广播消息({内容="#G/皇宫飞贼活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。",频道="xt"})
		for n, v in pairs(战斗准备类.战斗盒子) do
		  	if 战斗准备类.战斗盒子[n].战斗类型==100022 or  战斗准备类.战斗盒子[n].战斗类型==100022 then
				战斗准备类.战斗盒子[n]:结束战斗(0,0,1)
		  	end
		end
		for n, v in pairs(玩家数据) do
			if 玩家数据[n].角色:取任务(12)~=0 then
				玩家数据[n].角色:取消任务(玩家数据[n].角色:取任务(12))
				常规提示(n,"#Y你的贼王任务已经被自动取消")
			end
		end
		完成任务_12()
	end


	-- if 军阵威仪.开关 and 服务端参数.小时 == "22"  then
	-- 	军阵威仪={开关=false,起始=os.time()}
	-- 	for n, v in pairs(战斗准备类.战斗盒子) do
	-- 	  	if 战斗准备类.战斗盒子[n].战斗类型==100095 or 战斗准备类.战斗盒子[n].战斗类型==100096 then
	-- 	    		战斗准备类.战斗盒子[n]:结束战斗(0,0,1)
	-- 	  	end
	-- 	end
	-- end
	-- if 月影觅仙踪（奔月）.开关 and 服务端参数.小时 == "22" then
	-- 	月影觅仙踪（奔月）={开关=false,起始=os.time()}
	-- 	for n, v in pairs(战斗准备类.战斗盒子) do
	-- 	  	if 战斗准备类.战斗盒子[n].战斗类型==100078 or 战斗准备类.战斗盒子[n].战斗类型==100079 or 战斗准备类.战斗盒子[n].战斗类型==100080 or 战斗准备类.战斗盒子[n].战斗类型==100081
	-- 	  	or 战斗准备类.战斗盒子[n].战斗类型==100082 or 战斗准备类.战斗盒子[n].战斗类型==100083 or 战斗准备类.战斗盒子[n].战斗类型==100084 or 战斗准备类.战斗盒子[n].战斗类型==100085
	-- 	  	or 战斗准备类.战斗盒子[n].战斗类型==100086 or 战斗准备类.战斗盒子[n].战斗类型==100087 or 战斗准备类.战斗盒子[n].战斗类型==100088 or 战斗准备类.战斗盒子[n].战斗类型==100089
	-- 	  	or 战斗准备类.战斗盒子[n].战斗类型==100090 or 战斗准备类.战斗盒子[n].战斗类型==100091 or 战斗准备类.战斗盒子[n].战斗类型==100092 or 战斗准备类.战斗盒子[n].战斗类型==100093
	-- 	  	or 战斗准备类.战斗盒子[n].战斗类型==100093 then
	-- 	    		战斗准备类.战斗盒子[n]:结束战斗(0,0,1)
	-- 	  	end
	-- 	end
	-- end

	if 服务端参数.秒=="00" and 服务端参数.小时=="00" and 服务端参数.分钟=="00"then
		-- 地煞星:刷新资源()
		设置任务138()
	end
	if 小龟赛跑.次数3 == 3 and 小龟赛跑.开关==true then
		local 结算目标 = nil
		if 小龟赛跑.第一名 == 1 then
			结算目标 = "小龟村一郎"
		elseif 小龟赛跑.第一名 == 2 then
			结算目标 = "小龟蹦二郎"
		elseif 小龟赛跑.第一名 == 3 then
			结算目标 = "小龟驰三郎"
		end
		广播消息({内容="#G/本次小龟赛跑第一名的小龟是#R/"..结算目标.."#G/希望其他小龟不要气馁继续加油",频道="xt"})
		for k,v in pairs(小龟赛跑[结算目标]) do
		 	玩家数据[k].角色:添加银子(20000*小龟赛跑[结算目标][k].下注,"小龟赛跑",1)
		end
		小龟赛跑={开关=false,开始比赛=false,起始=os.time(),次数=0,次数2=0,次数3=0,小龟村一郎={},小龟蹦二郎={},小龟驰三郎={},第一名=0,随机事件={"休息","雷劈"},结束=20}
	end

	-- if 蟠桃盛会.开关 then
	-- 	if os.time()-蟠桃盛会.起始>=7200  then
	-- 		for n, v in pairs(战斗准备类.战斗盒子) do
	-- 		  	if 战斗准备类.战斗盒子[n].战斗类型==100132 or 战斗准备类.战斗盒子[n].战斗类型==100133 or 战斗准备类.战斗盒子[n].战斗类型==100134 then
	-- 	    		战斗准备类.战斗盒子[n]:结束战斗(0,0,1)
	-- 		  	end
	-- 		end
	-- 		任务处理类:删除活动单位(250)
	-- 		任务处理类:删除活动单位(251)
	-- 		任务处理类:删除活动单位(252)
	-- 		任务处理类:删除活动单位(253)
	-- 	else
	-- 		if os.time()-蟠桃盛会.间隔 >= 300 then
	-- 			SetUpdate251()
	-- 		end
	-- 	end
	-- end
	if os.date("%X", os.time())==os.date("%H", os.time())..":00:00" then
	    整点处理(os.date("%H", os.time()))
	end
	if os.date("%X", os.time())==os.date("%H", os.time())..":"..os.date("%M", os.time())..":15" then
	    整分处理(os.date("%M", os.time()))
	end

end

function 整分处理(时刻)
	时刻=时刻+0
	--------------------------------------------------------------
	if 双龙之战.四海龙宫.阵营操作.虾兵 and 双龙之战.四海龙宫.阵营操作.虾兵.时间<os.time() then
	双龙之战.四海龙宫.阵营贡献=双龙之战.四海龙宫.阵营贡献-双龙之战.四海龙宫.阵营操作.虾兵.数量*5
	if 双龙之战.四海龙宫.阵营贡献<0 then 双龙之战.四海龙宫.阵营贡献=0 end
	广播消息({内容=format("#G《四海龙宫》#Y/本轮虾兵没有清除完成，剩余"..双龙之战.四海龙宫.阵营操作.虾兵.数量.."只虾兵，扣除阵营#R/"..(双龙之战.四海龙宫.阵营操作.虾兵.数量*5).."点#Y/周贡献值！！。"),频道="xt"})

	双龙之战.四海龙宫.阵营操作.虾兵=nil
	elseif  双龙之战.覆海帮.阵营操作.虾兵 and 双龙之战.覆海帮.阵营操作.虾兵.时间<os.time() then
	双龙之战.覆海帮.阵营贡献=双龙之战.覆海帮.阵营贡献-双龙之战.覆海帮.阵营操作.虾兵.数量*5
	if 双龙之战.覆海帮.阵营贡献<0 then 双龙之战.覆海帮.阵营贡献=0 end
	广播消息({内容=format("#G《覆海帮》#Y/本轮虾兵没有清除完成，剩余"..双龙之战.覆海帮.阵营操作.虾兵.数量.."只虾兵，扣除阵营#R/"..(双龙之战.覆海帮.阵营操作.虾兵.数量*5).."点#Y/周贡献值！！。"),频道="xt"})

	双龙之战.覆海帮.阵营操作.虾兵=nil
	elseif  双龙之战.四海龙宫.阵营操作.蟹将 and 双龙之战.四海龙宫.阵营操作.蟹将.时间<os.time() then
	双龙之战.四海龙宫.阵营贡献=双龙之战.四海龙宫.阵营贡献-双龙之战.四海龙宫.阵营操作.蟹将.数量*8
	if 双龙之战.四海龙宫.阵营贡献<0 then 双龙之战.四海龙宫.阵营贡献=0 end
	广播消息({内容=format("#G《四海龙宫》#Y/本轮蟹将没有清除完成，剩余"..双龙之战.四海龙宫.阵营操作.蟹将.数量.."只蟹将，扣除阵营#R/"..(双龙之战.四海龙宫.阵营操作.蟹将.数量*8).."点#Y/周贡献值！！。"),频道="xt"})

	双龙之战.四海龙宫.阵营操作.蟹将=nil
	elseif  双龙之战.覆海帮.阵营操作.蟹将 and 双龙之战.覆海帮.阵营操作.蟹将.时间<os.time() then
	双龙之战.覆海帮.阵营贡献=双龙之战.覆海帮.阵营贡献-双龙之战.覆海帮.阵营操作.蟹将.数量*8
	if 双龙之战.覆海帮.阵营贡献<0 then 双龙之战.覆海帮.阵营贡献=0 end
	广播消息({内容=format("#G《覆海帮》#Y/本轮蟹将没有清除完成，剩余"..双龙之战.覆海帮.阵营操作.蟹将.数量.."只蟹将，扣除阵营#R/"..(双龙之战.覆海帮.阵营操作.蟹将.数量*8).."点#Y/周贡献值！！。"),频道="xt"})

	双龙之战.覆海帮.阵营操作.蟹将=nil
	elseif  双龙之战.四海龙宫.阵营操作.赝品宝箱 and 双龙之战.四海龙宫.阵营操作.赝品宝箱.时间<os.time() then
	 双龙之战.四海龙宫.阵营操作.赝品宝箱=nil
	elseif  双龙之战.覆海帮.阵营操作.赝品宝箱 and 双龙之战.覆海帮.阵营操作.赝品宝箱.时间<os.time() then
	 双龙之战.覆海帮.阵营操作.赝品宝箱=nil
	end
	-----------------------------------------------------C改双龙
	if 时刻==01 then
	帮派处理:维护处理()
	保存系统数据()
	保存师徒数据()
	elseif 时刻==02 then
	elseif 时刻==10 then
	elseif 时刻==15 then
	elseif 时刻==30 then
		保存系统数据()
		保存师徒数据()
	elseif 时刻==32 then
	elseif 时刻==40 then
	elseif 时刻==45 then
	elseif 时刻==55 then
	elseif 时刻==58 then
	end
end

function 整点处理(时刻)
	时刻=时刻+0
	帮派处理:维护处理()
	--------------------------------------------C改
	for n, v in pairs(玩家数据) do
	    if 玩家数据[n] and 玩家数据[n].角色 and 玩家数据[n].角色.称谓时间 then
	        local 过期称谓列表 = {}
	        for 称谓, 过期时间 in pairs(玩家数据[n].角色.称谓时间) do
	            local expireTime = tonumber(过期时间)
	            if expireTime and os.time() > expireTime then
	                table.insert(过期称谓列表, 称谓)
	            end
	        end
	        for i=1, #过期称谓列表 do
	            local 称谓名 = 过期称谓列表[i]
	            玩家数据[n].角色:删除称谓(称谓名)
	            常规提示(n, "#Y/你的称谓【"..称谓名.."】已过期")
	        end
	    end
	end
	--------------------------------------------C改

	假人事件类:刷新摊位()
	for n, v in pairs(玩家数据) do
		刷新排行榜(n)
	end
	if tonumber(时刻) >= 11 then
		十八妖王:妖王排行()
	end
		------------------------C改双龙
	if 时刻 == 01 then
		local 目前次数=f函数.读配置(程序目录.."特殊活动配置.ini","双龙之战","系统次数")+0
		if 目前次数< 30 then
			f函数.写配置(程序目录.."特殊活动配置.ini","双龙之战","系统次数",目前次数+1)
		end
		------------------------C改双龙
	elseif 时刻== 19 then
		决战大雁塔三人=true
		决战大雁塔五人=true
		广播消息({内容="#R《决战大雁塔》#G正式开启进场，各位玩家可前往大雁塔门口参与比试，20点将会准时开启活动！！",频道="xt"})
	elseif 时刻== 20 then
		决战大雁塔三人=true
		决战大雁塔五人=true
		广播消息({内容="#R《决战大雁塔》#G正式开启进场，各位玩家可前往大雁塔门口参与比试，20点将会准时开启活动！！",频道="xt"})
		if 决战大雁塔三人 then
		三人大雁塔={}
		大雁塔ip限制={}
		决战大雁塔开始=true
		广播消息({内容="#R《决战大雁塔》#G正式开启比试！！",频道="xt"})
		end
	elseif 时刻== 21 then
		决战大雁塔三人=false
		决战大雁塔五人=false
		决战大雁塔开始=false
		三人大雁塔={}
		大雁塔ip限制={}
		广播消息({内容="#R《决战大雁塔》#G活动已经结束了！！",频道="xt"})
		end
end

function 活动检查()
	for i=1,#活动列表 do
		if 活动列表[i] and 活动列表[i].星期 == "全天" then
			if 活动列表[i].开启方式 == "间隔" then
				if 活动列表[i].刷新 == nil then
					活动列表[i].刷新 = os.time()
					if type(活动列表[i].脚本) == "table" then
						for o=1,#活动列表[i].脚本 do
							local fun = _G[活动列表[i].脚本[o]]
							if fun ~= nil  then
								 fun()
							end
						end
					else
				    	local fun = _G[活动列表[i].脚本]
						if fun ~= nil  then
							fun()
						end
					end
				end
				if os.time() >= 活动列表[i].刷新+活动列表[i].分 then
					if 活动列表[i].名称 == "珍品" then
						商店处理类:刷新珍品()
					else
						if type(活动列表[i].脚本) == "table" then
							for o=1,#活动列表[i].脚本 do
								local fun = _G[活动列表[i].脚本[o]]
								if fun ~= nil  then
									 fun()
								end
							end
						else
						    local fun = _G[活动列表[i].脚本]
							if fun ~= nil  then
								fun()
							end
						end
					end
					活动列表[i].刷新 = os.time()
				end
			elseif 活动列表[i].开启方式 == "分" then
				if 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0 then
					---------------------------------------C改
					if 活动列表[i].名称 == "青铜矿石" then
						设置任务2031()
					elseif 活动列表[i].名称 == "白银矿石" then
						设置任务2032()
					elseif 活动列表[i].名称 == "翡翠矿石" then
						设置任务2033()
					elseif 活动列表[i].名称 == "黄金矿石" then
						设置任务2034()
					elseif 活动列表[i].名称 == "紫金矿石" then
						设置任务2035()
					elseif 活动列表[i].名称 == "下凡的灵猴" then
						自写活动:下凡的灵猴()
					elseif 活动列表[i].名称 == "三界财神爷" then
						自写活动:三界财神爷()
					elseif 活动列表[i].名称 == "十二生肖" then
						自写活动:十二生肖()
					elseif 活动列表[i].名称 == "世界boss" then
						自写活动:世界boss(id)
					elseif 活动列表[i].名称 == "斥候海妖" then
						自写活动:斥候海妖()
					 elseif 活动列表[i].名称 == "知了王" then
					 	自写活动:知了王()
					-- elseif 活动列表[i].名称 == "千年知了王" then
					-- 	自写活动:千年知了王()
					 elseif 活动列表[i].名称 == "知了统领" then
					 	自写活动:知了统领()
					-- elseif 活动列表[i].名称 == "知了大王" then
					-- 	自写活动:知了大王()
					-- elseif 活动列表[i].名称 == "知了小王" then
					-- 	自写活动:知了小王()
					 elseif 活动列表[i].名称 == "知了先锋" then
					 	自写活动:知了先锋()
					elseif 活动列表[i].名称 == "夏日炎炎" then
						自写活动:夏日炎炎()
					elseif 活动列表[i].名称 == "魂殿使者" then
						自写活动:魂殿使者()
					elseif 活动列表[i].名称 == "魂殿殿主" then
						自写活动:魂殿殿主()
					elseif 活动列表[i].名称 == "新春快乐" then
						自写活动:新春快乐()
					elseif 活动列表[i].名称 == "琴声悠悠" then
						自写活动:琴声悠悠()
					elseif 活动列表[i].名称 == "中秋快乐" then
						自写活动:中秋快乐()
					elseif 活动列表[i].名称 == "龙神" then
						自写活动:龙神()
					elseif 活动列表[i].名称 == "仙气十足" then
						自写活动:仙气十足()
					-- elseif 活动列表[i].名称 == "武神坛服战8强" then
					-- 	自写活动:武神坛服战8强()
					-- elseif 活动列表[i].名称 == "武神坛服战4强" then
					-- 	自写活动:武神坛服战4强()
					-- elseif 活动列表[i].名称 == "武神坛服战季军" then
					-- 	自写活动:武神坛服战季军()
					-- elseif 活动列表[i].名称 == "武神坛服战亚军" then
					-- 	自写活动:武神坛服战亚军()
					-- elseif 活动列表[i].名称 == "武神坛服战冠军" then
					-- 	自写活动:武神坛服战冠军()
					elseif 活动列表[i].名称 == "客服小二" then
						自写活动:客服小二()
					elseif 活动列表[i].名称 == "盘龙岛小怪" then
						自写活动:盘龙岛小怪()
					------------------------------------------------
					elseif 活动列表[i].名称 == "捣乱年兽" then
						自写活动:捣乱年兽()
					elseif 活动列表[i].名称 == "贺新年" then
						自写活动:贺新年()
					elseif 活动列表[i].名称 == "万象福" then
						自写活动:万象福()
					elseif 活动列表[i].名称 == "糖果派对" then
						自写活动:糖果派对()
					elseif 活动列表[i].名称 == "六欲心魔" then
						自写活动:六欲心魔()
					elseif 活动列表[i].名称 == "恭喜发财" then
						自写活动:恭喜发财()
					elseif 活动列表[i].名称 == "魔化师傅" then
						自写活动:魔化师傅()
					elseif 活动列表[i].名称 == "四圣青龙" then
						自写活动:四圣青龙()
					elseif 活动列表[i].名称 == "四圣白虎" then
						自写活动:四圣白虎()
					elseif 活动列表[i].名称 == "四圣朱雀" then
						自写活动:四圣朱雀()
					elseif 活动列表[i].名称 == "四圣玄武" then
						自写活动:四圣玄武()
					elseif 活动列表[i].名称 == "巡山小妖" then
						自写活动:巡山小妖()
					elseif 活动列表[i].名称 == "白骨精" then
						自写活动:白骨精()
					elseif 活动列表[i].名称 == "狮驼国" then
						自写活动:狮驼国()
					elseif 活动列表[i].名称 == "美猴王" then
						自写活动:美猴王()
					elseif 活动列表[i].名称 == "武神坛服战" then
						自写活动:武神坛服战()
					elseif 活动列表[i].名称 == "醉凡尘" then
						自写活动:醉凡尘()
					elseif 活动列表[i].名称 == "仙魔灵墟" then
						自写活动:仙魔灵墟()
					elseif 活动列表[i].名称 == "云生梦泽" then
						自写活动:云生梦泽()
					else
						if type(活动列表[i].脚本) == "table" then
							for o=1,#活动列表[i].脚本 do
								local fun = _G[活动列表[i].脚本[o]]
								if fun ~= nil  then
									 fun()
								end
							end
						else
				    	local fun = _G[活动列表[i].脚本]
							if fun ~= nil  then
								 fun()
							end
						end
					end
					---------------------------------------C改

				end
			elseif 活动列表[i].开启方式 == "时" then
				if type(活动列表[i].时) == "table" then
					for o=1,#活动列表[i].时 do
						if 服务端参数.小时+0 == 活动列表[i].时[o] and 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0 then
							if type(活动列表[i].脚本) == "table" then
								for o=1,#活动列表[i].脚本 do
									local fun = _G[活动列表[i].脚本[o]]
									if fun ~= nil  then
										 fun()
									end
								end
							else
							    	local fun = _G[活动列表[i].脚本]
								if fun ~= nil  then
									 fun()
								end
							end
						end
					end
				else
					if 服务端参数.小时+0 == 活动列表[i].时 and 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0 then
						if type(活动列表[i].脚本) == "table" then
							for o=1,#活动列表[i].脚本 do
								local fun = _G[活动列表[i].脚本[o]]
								if fun ~= nil  then
									 fun()
								end
							end
						else
						    	local fun = _G[活动列表[i].脚本]
							if fun ~= nil  then
								 fun()
							end
						end
					end
				end
			end
		else
			if 活动列表[i] and os.date("%a",os.time()) == 活动列表[i].星期 and 服务端参数.小时+0 == 活动列表[i].时 and 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0  then
				if 活动列表[i].名称 == "科举" and not 科举.开关 then
					科举.开关=true
					科举.起始=os.time()
					游戏活动类:刷新科举排行假人()
    					广播消息({内容="#G/科举活动已开启，大家可以前往#Y长安城礼部侍郎(281,94)#G参加答题了！#51",频道="xt"})

				-- elseif 活动列表[i].名称 == "军阵威仪" and not 军阵威仪.开关  then
				-- 	军阵威仪.开关=true
				-- 	军阵威仪.起始=os.time()
				-- 	广播消息({内容="#G军阵威仪活动已经开启，各位玩家可以前往长安城#R/礼部尚书#G/处领取战报。",频道="xt"})
				-- elseif 活动列表[i].名称 == "月影觅仙踪（奔月）" and not 月影觅仙踪（奔月）.开关 then
				-- 	月影觅仙踪（奔月）.开关=true
				-- 	月影觅仙踪（奔月）.起始=os.time()
				-- 	广播消息({内容="#G/月影觅仙踪（奔月）活动已经开启，各位玩家可以前往长安城#R/婵娟#G/处领取战报。",频道="xt"})
				else
					if type(活动列表[i].脚本) == "table" then
						for o=1,#活动列表[i].脚本 do
							local fun = _G[活动列表[i].脚本[o]]
							if fun ~= nil  then
								 fun()
							end
						end
					else
					    	local fun = _G[活动列表[i].脚本]
						if fun ~= nil  then
							 fun()
						end
					end
				end
			end
		end
	end
end

function 自动关闭服务器()
  for n, v in pairs(玩家数据) do
    if 玩家数据[n]~=nil then
      发送数据(玩家数据[n].连接id,999,"服务器已经关闭，你被强制断开连接")
    end
  end
  保存系统数据(2)
  os.exit()
end

function 全部玩家下线()
	for n, v in pairs(玩家数据) do
		if 玩家数据[n]~=nil and 玩家数据[n].连接id then
			发送数据(玩家数据[n].连接id,999,"服务器维护中，你被强制断开连接")
		end
	end
	保存系统数据(2)
	for n, v in pairs(__PC客户信息) do
		if __PC客户信息[n].网关==nil then
			__S服务:断开连接(n)
			__PC客户信息[n]=nil
		end
	end
	for n, v in pairs(__AD客户信息) do
		if __AD客户信息[n].网关==nil then
			__安卓通信:断开连接(n)
			__AD客户信息[n]=nil
		end
	end
	print("全部玩家下线成功！")
end

function 输入函数(t)
	local lssj = 分割文本(t,"*")
	t=lssj[1]
	local t2 = lssj[2]
	if t=="@gxdm" then
		local 临时函数=loadstring(读入文件("热更新/更新初始.txt"))
		临时函数()
		print("热更新代码成功")
	elseif t=="jianhui" then
    --剑会
	elseif t=="@IP限制归零" then
    		多开限制={}
		常规提示(管理id,"#Y清除成功")
	elseif t=="@重置排行" then
		local 起始 = tonumber(os.date("%j"))
		充值7日排行 = {开启=true,起始=起始}
		for i=起始,起始+6 do
			充值7日排行[i] = {}
		end
		print("7日排行重置成功")
	elseif t=="@重置伤害配置" then
		__伤害配置=table.loadstring(读入文件([[sql/伤害配置.txt]]))
	  	for k,v in pairs(__伤害配置) do
	   		__伤害配置[k]=tonumber(v)
	  	end
    		print(t.."成功")
	elseif t == "@gxbwjl" then
		比武精锐组奖励= 取csv数据("sql/比武精锐组奖励.csv") --11.25改
  		比武神威组奖励= 取csv数据("sql/比武神威组奖励.csv")
  		比武天科组奖励= 取csv数据("sql/比武天科组奖励.csv")
  		比武天元组奖励= 取csv数据("sql/比武天元组奖励.csv")

  	elseif t=="@668" then
		整体加强A=f函数.读配置(程序目录.."配置文件.ini","主要配置","怪物血量系数增强")+0
		整体加强B=f函数.读配置(程序目录.."配置文件.ini","主要配置","怪物伤害系数增强")+0
		整体加强C=f函数.读配置(程序目录.."配置文件.ini","主要配置","怪物法伤系数增强")+0
		整体加强D=f函数.读配置(程序目录.."配置文件.ini","主要配置","怪物速度系数增强")+0
		print("更新怪物血量系数增强为"..整体加强A.."倍")
		print("更新怪物伤害系数增强为"..整体加强B.."倍")
		print("更新怪物法伤系数增强为"..整体加强C.."倍")
		print("更新怪物速度系数增强为"..整体加强D.."倍")

	elseif t=="@kqbw" then
		比武大会数据={进程=0,报名={},玩家表={},精锐组={},神威组={},天科组={},天元组={}} --初始化
		比武大会数据.进程=1
		比武大会.活动开关=true
		比武大会.进场time=os.time()+300 --11.23改
		比武大会.结束time=os.time()+1800
		发送公告("#S(比武大会)#Y/开启报名，请想参赛的玩家抓紧通过英雄大会主持人报名。")
	elseif t=="@1" then
		自写活动:一层守护神()
		自写活动:二层守护神()
		自写活动:三层守护神()
		自写活动:四层守护神()
		自写活动:五层守护神()
		自写活动:六层守护神()
		自写活动:七层守护神()
		简单_决战大雁塔:雁塔系统怪物()
		简单_决战大雁塔:给予三人地图奖励()
	    	if 决战大雁塔开始 then
	    	  	决战大雁塔三人=false
	    	  	决战大雁塔五人=false
			决战大雁塔开始=false
	      		常规提示(id,"#Y/活动关闭成功")
	      		广播消息({内容="#R《决战大雁塔》#G活动已经结束了！！",频道="xt"})
	      	elseif 决战大雁塔三人 then
		      	决战大雁塔开始=true
		      	常规提示(id,"#Y/活动开始PK成功，再次点击为关闭")
		      	广播消息({内容="#R《决战大雁塔》#G正式开启比试！！",频道="xt"})
	   	else
	      		常规提示(id,"#Y/活动开始入场成功，再次点击为开启PK")
	   	  	决战大雁塔三人=true
	   	  	决战大雁塔五人=true
	      		广播消息({内容="#R《决战大雁塔》#G正式开启进场，冲冲冲！！",频道="xt"})
	    	end
	elseif t=="@gxxz" then
		IP限制 = table.loadstring(读入文件([[sql/IP限制.txt]]))
		print("加载ip限制成功")
	elseif t=="@czsj" then
		重置数据()
		print("重置每日副本成功!")
	elseif t=="@gxsj" then
		保存系统数据(2)
		发送网关消息("成功")
		获取__商城数据()
		商城处理类:加载商品()
		商店处理类:加载商品()
		发送网关消息("成功")
		获取__怪物属性系数()
		发送网关消息("更新怪物属性数据成功")
		获取__物品数据()
		发送网关消息("成功")
		获取__礼包配置数据()
		获取__抽奖数据()
		发送网关消息("成功")
		更新全局基础数据()
		发送网关消息("成功")
		获取__活动时间配置()
		发送网关消息("成功")
		获取__梦幻指引()
		发送网关消息("成功")
		获取__物品奖励数据()
		刷新自定义数据()
		发送网关消息("成功")
--		获取__商店数据()
		发送网关消息("成功")
		获取__技能消耗()
		发送网关消息("成功")
		加载内充数据()
		HDPZ=table.loadstring(读入文件([[全局bl.txt]]))
		QJHDSJ=table.loadstring(读入文件([[活动时间.txt]]))
  		一体坐骑表=table.loadstring(读入文件([[其他表/祥瑞表.txt]]))
		炼妖配置 = ReadExcel1("炼妖数据","")
		获取奖池数据()
		获取双龙签到道具()
		加载自动回收数据()
		节日奖励 = table.loadstring(读入文件([[其他表/节日礼物道具.txt]]))
		捐赠配置=table.loadstring(读入文件([[其他表/双龙NPC捐赠.txt]]))
		首冲配置 = table.loadstring(读入文件([[其他表/首冲奖励.txt]]))
	elseif t=="@gxsgxz" then
  		刷怪限制 = table.loadstring(读入文件([[刷怪配置/刷怪限制.txt]]))
		print("更新刷怪限制成功")

	elseif t=="@gxlb" then
  		鲲鹏法=table.loadstring(读入文件([[礼包配置/鲲鹏礼包(法).txt]]))
  		鲲鹏物=table.loadstring(读入文件([[礼包配置/鲲鹏礼包(物).txt]]))
  		五福鲲鹏法=table.loadstring(读入文件([[礼包配置/五福鲲鹏礼包(法).txt]]))
  		五福鲲鹏物=table.loadstring(读入文件([[礼包配置/五福鲲鹏礼包(物).txt]]))
		print("更新礼包配置成功")

	elseif t=="@gxpz" then
		HDPZ=table.loadstring(读入文件([[全局bl.txt]]))
		print("更新全局配置数据表成功")


	elseif t=="@gxsh" then
		召唤兽店数据= 取csv数据("其他表/召唤兽店.csv")
		道具店数据= 取csv数据("其他表/道具店.csv")
		环装店数据= 取csv数据("其他表/环装店.csv")
		师门商店类:加载数据()
		print("更新商会成功")

	elseif t=="@czcs" then
		重置每日玩家刷怪次数()
		print("重置限制次数成功!")

              elseif t=="@jzsgcs" then
	 加载玩家刷怪次数数据()
	print("加载玩家刷怪次数数据(成功")
	elseif t=="@gxsk" then
		for n, v in pairs(时空之钥) do--------------佬伍修改（增加种族秘境时空之钥）
			if 时空之钥[n]~=nil then
               			时空之钥[n].境界=1
			end
		end
		for n, v in pairs(玩家数据) do
			if 玩家数据[n]~=nil then
         				玩家数据[n].道具:更改时空之钥(n)
			end
		end-------------佬伍修改（增加种族秘境时空之钥）

	elseif t=="@whbc" then
		    local 成功数量 = 0
		    local 失败数量 = 0
		    local 开始时间 = os.time()
		    __S服务:输出("开始执行维护补偿...")
		    for file in lfs.dir("data") do
		        if file ~= "." and file ~= ".." then
		            local 文件路径 = "data/" .. file
		            local attr = lfs.attributes(文件路径)
		            if attr and attr.mode == "directory" then
		                local isArchive = string.find(file, "%.7z$") or string.find(file, "%.zip$")
		                if not isArchive then
		                    local 账号信息文件路径 = 程序目录..[[data\]]..file..[[\账号信息.txt]]
		                    -- 直接写入配置，不读取信息.txt文件
		                    local 状态, 错误信息 = pcall(function()
		                        f函数.写配置(账号信息文件路径, "账号配置", "维护补偿", "1")
		                    end)

		                    if 状态 then
		                        成功数量 = 成功数量 + 1
		                        -- 每处理10个账号输出一次进度
		                        if 成功数量 % 10 == 0 then
		                            __S服务:输出("已处理 "..成功数量.." 个账号...")
		                        end
		                    else
		                        失败数量 = 失败数量 + 1
		                        __S服务:输出("处理账号 "..file.." 失败: "..tostring(错误信息))
		                    end
		                end
		            end
		        end
		    end
		    local 耗时 = os.time() - 开始时间
		    __S服务:输出("维护补偿执行完成！")
		    __S服务:输出("成功: "..成功数量.." 个，失败: "..失败数量.." 个")
		    __S服务:输出("总耗时: "..耗时.." 秒")


        	elseif t=="@gxhdsj" then
		活动列表= 取csv数据("其他表/活动时间列表.csv")
		print("更新活动时间成功")
	elseif t == "@2" then
		自写活动:夏日炎炎()
		自写活动:仙气十足()
		自写活动:龙神()
		自写活动:中秋快乐()
		自写活动:新春快乐()
		自写活动:琴声悠悠()
		-- 自写活动:武神坛服战8强()
		-- 自写活动:武神坛服战4强()
		-- 自写活动:武神坛服战季军()
		-- 自写活动:武神坛服战亚军()
		-- 自写活动:武神坛服战冠军()
		自写活动:客服小二()
		自写活动:捣乱年兽()
		自写活动:贺新年()
		自写活动:万象福()
		自写活动:糖果派对()
		自写活动:六欲心魔()
		自写活动:恭喜发财()
		自写活动:魔化师傅()
		自写活动:四圣青龙()
		自写活动:四圣白虎()
		自写活动:四圣朱雀()
		自写活动:四圣玄武()
		自写活动:知了王()
		自写活动:巡山小妖()
		自写活动:白骨精()
		自写活动:狮驼国()
		自写活动:美猴王()
		自写活动:武神坛服战()
		自写活动:醉凡尘()
		自写活动:仙魔灵墟()
		自写活动:云生梦泽()
	elseif t == "@xyfm" then
		--降妖伏魔:刷出怪物()
		降妖伏魔:开启活动()
  	elseif t=="@1314" then
		设置任务2031()
		设置任务2032()
		设置任务2033()
		设置任务2034()
		设置任务2035()
	elseif t=="@gxgw" then
		怪物数据= 取csv数据("其他表/怪物数据.csv")
		活动数据= 取csv数据("其他表/活动数据.csv")
		阶段属性= 取csv数据("sql/阶段属性.csv")
		怪物属性:热更怪物属性函数()

		print("更新怪物成功")
	elseif t=="@cq" then
		维护通知()
	elseif t=="@qxcq" then
		服务器关闭=nil
	elseif t=="@zlw" then
	  设置任务210()
	elseif t=="@1111" then
--比武大会:开启活动()
--任务处理类.开启剑会天下(类型)
 任务处理类.开启剑会天下("三人")
 任务处理类.开启剑会天下("单人")
	elseif t=="@czsj" then
		重置数据()
		__S服务:输出("重置数据成功……")

	elseif t=="@bcsj" then
		保存系统数据(2)
	elseif t == "@sd160" then
		local 数字id = tonumber(t2)
		if not 数字id or not 玩家数据[数字id] or not 玩家数据[数字id].角色 then
			print("该玩家不在线！")
			return
		end
		for k,v in pairs(玩家数据[数字id].角色.辅助技能) do
			if v.名称=="打造技巧" then
				v.等级=160
				v.熟练度 = v.熟练度 + 2560
			elseif v.名称=="裁缝技巧" then
				v.等级=160
				v.熟练度 = v.熟练度 + 2560
			elseif v.名称=="炼金术" then
				v.等级=160
				v.熟练度 = v.熟练度 + 2560
			end
		end
		常规提示(数字id,"#Y成功给您发放了三打160")
		print("#给	"..玩家数据[数字id].角色.名称.."	发放三打160成功！")
	elseif t == "@tczd" then
		local 数字id = tomunber(t2)
		if not 数字id or not 玩家数据[数字id] or not 玩家数据[数字id].角色 then
			print("该玩家不在线！")
			return
		end
		local 队伍id=玩家数据[数字id].队伍
		if 队伍id~=0 then
			for n=1,#队伍数据[队伍id].成员数据 do
				local cyid=队伍数据[队伍id].成员数据[n]
				玩家数据[cyid].遇怪时间=os.time()+取随机数(10,20)
				发送数据(玩家数据[cyid].连接id,5505)
				发送数据(玩家数据[cyid].连接id,31,玩家数据[cyid].角色:取总数据1())
				玩家数据[cyid].zhandou=0
				玩家数据[cyid].道具:重置法宝回合(cyid)
				玩家数据[cyid].角色.战斗开关=false
				地图处理类:设置战斗开关(cyid,false)
			end
			if 战斗准备类.战斗盒子[队伍id] then
				战斗准备类.战斗盒子[队伍id]=nil
			end
		else
			玩家数据[数字id].遇怪时间=os.time()+取随机数(10,20)
			发送数据(玩家数据[数字id].连接id,5505)
			发送数据(玩家数据[数字id].连接id,31,玩家数据[数字id].角色:取总数据1())
			玩家数据[数字id].zhandou=0
			玩家数据[数字id].道具:重置法宝回合(数字id)
			玩家数据[数字id].角色.战斗开关=false
			地图处理类:设置战斗开关(数字id,false)
			if 战斗准备类.战斗盒子[数字id] then
				战斗准备类.战斗盒子[数字id]=nil
			end
		end
	elseif t=="@bcwjsj" then
		保存玩家数据()
	elseif t=="@bcqtsj" then
		保存帮派数据()
	elseif t=="@qbxx" then
		全部玩家下线()
	elseif t=="@bcbpsj" then
		for k,v in pairs(取所有帮派) do
			if v.已解散 then
		   	local sdfew="bpsj/帮派数据"..k..".txt"
				写出文件(sdfew,table.tostring({}))
			else
			  local sdfew="bpsj/帮派数据"..k..".txt"
				写出文件(sdfew,table.tostring(帮派数据[k]))
			end
		end
		__S服务:输出("保存帮派数据成功……")
	elseif t=="@bcwj" then
		for n, v in pairs(玩家数据) do
			if 玩家数据[n]~=nil then
				玩家数据[n].角色:存档()
			end
		end
		__S服务:输出("保存玩家数据成功……")
	elseif t=="@bcrw" then
		local llsj={}
		local 数量=0
		for n, v in pairs(任务数据) do --罗庚  回梦丹  打造
			if v.是存档 then
				数量=数量+1
				llsj[数量]=table.loadstring(table.tostring(任务数据[n]))
				llsj[数量].存储id=n
			end
		end
		写出文件([[sql/任务数据.txt]],table.tostring(llsj))
		llsj=nil
		__S服务:输出("保存任务数据成功……")

	elseif t=="@444" then
		服务端参数.经验获得率=f函数.读配置(程序目录.."配置文件.ini","主要配置","经验")+0
		print("经验获得率=="..服务端参数.经验获得率)
	elseif t=="@zx" then
		print(服务端参数.在线人数)
	elseif t=="@bcrz" then
		local 保存语句=""
		for n=1,#错误日志 do
			保存语句=保存语句..时间转换(错误日志[n].时间)..'：#换行符'..错误日志[n].记录..'#换行符'..'#换行符'
		end
		写出文件("错误日志.txt",保存语句)
		错误日志={}
		__S服务:输出("保存错误日志成功")

	elseif t=="@cklb" then
		查看在线列表()
	elseif t=="@qzxx" then
		强制下线()
	-- elseif t=="@结束战斗" then
	-- 	local id =t2+0
	-- 	if 玩家数据[id]~= nil and  玩家数据[id].zhandou~=0 then
	-- 		if  战斗准备类.战斗盒子[玩家数据[id].zhandou]~=nil  then
	-- 			战斗准备类.战斗盒子[玩家数据[id].zhandou]:结束战斗(0,0,1,1)
	-- 		end
	-- 	end
	-- elseif t=="@小龟赛跑开启" then
	-- 	设置任务506()
	-- elseif t=="@统计实力刷新" then
	-- 	系统处理类:统计实力榜更新数据()

	elseif t=="@长安保卫战"  then
		-- 设置任务220()
		长安保卫战:开启活动()
	-- elseif t=="@czfw"  then
	-- 	重置房屋()
	-- elseif t=="@重置首席"  then
	-- 	首席初始化()
	-- elseif t=="@首席竞选开启"  then
	-- 	首席弟子类:开启首席竞选()
	-- elseif t=="@首席竞选结束"  then
	-- 	首席弟子类:结束首席竞选()

	-- elseif t=="@科举开启"  then
	-- 	科举.开关=true
	-- 	科举.起始=os.time()
	-- 	广播消息({内容="#G/科举活动已经开启，各位玩家可以前往长安城#R/礼部侍郎#G/处领取战报。",频道="xt"})
	-- elseif t=="@军阵开启"  then
	-- 	军阵威仪.开关=true
	-- 	军阵威仪.起始=os.time()
	-- 	广播消息({内容="#G军阵威仪活动已经开启，各位玩家可以前往长安城#R/礼部尚书#G/处领取战报。",频道="xt"})
	-- elseif t=="@月影开启"  then
	-- 	月影觅仙踪（奔月）.开关=true
	-- 	月影觅仙踪（奔月）.起始=os.time()
	-- 	广播消息({内容="#G/月影觅仙踪（奔月）活动已经开启，各位玩家可以前往长安城#R/婵娟#G/处领取战报。",频道="xt"})
	-- elseif t=="@战斗监控打印"  then
	-- 	写出文件("/战斗监控.txt", table.tostring(战斗监控))
	-- 	战斗监控={}

	end
end

function 维护通知()
	保存系统数据(2)
	保存帮派数据()
	if 调试模式 then
	  服务器关闭={开关=true,计时=30,起始=os.time()}
	else
		服务器关闭={开关=true,计时=30,起始=os.time()}
		发送公告("#R各位玩家请注意，服务器将在30秒后进行更新,届时服务器将临时关闭，请所有玩家注意提前下线。")
	  广播消息({内容=format("#R各位玩家请注意，服务器将在30秒后进行更新,届时服务器将临时关闭,，请所有玩家提前下线。"),频道="xt"})
	end
end

function 循环函数()
	if 服务端参数 and 服务端参数.启动时间 ~= os.time() and 初始化完毕 then
		时辰函数()
		服务端参数.分钟=os.date("%M", os.time())
		服务端参数.小时=os.date("%H", os.time())
		服务端参数.秒=os.date("%S", os.time())
		服务端参数.启动时间=os.time()
		藏宝阁更新()
		整秒处理()
		-- if os.date("%M", os.time()) == "59" and 充值7日排行.开启 then
  --     重置7日排行()
  --   end
	end
	if 战斗准备类 then
	战斗准备类:更新()
	end
end
function 重置7日排行()
-- local dr = tonumber(os.date("%j"))
--       if 充值7日排行[dr] then
--           local 时间 = 取累充年月日(os.time())
--           local 数据表 = 获取指定时间累充(时间)
--           for i,v in ipairs(数据表) do
--               local data =table.loadstring(读入文件([[data/]]..v.账号..[[/]]..v.数字id..[[/角色.txt]]))
--               if data.名称  and data.模型 then
--                   充值7日排行[dr][v.数字id] = {排名=i,名称=data.名称,模型=data.模型,id=v.数字id,领取=false,金额=v.充值总额}
--               end
--           end
--       end
end
function 退出函数()
	保存系统数据(2)
	os.execute("pause")
end