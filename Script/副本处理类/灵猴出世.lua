local 灵猴出世 = class()

function 灵猴出世:初始化()
	self.任务id=3002
	self.NPC类型=3001
	self.任务标题="灵猴出世"
	地图处理类.地图数据[2057]={npc={},单位={},传送圈={}} --妖怪巢穴
	地图处理类.地图玩家[2057]={}
	地图处理类.地图坐标[2057]=地图处理类.地图坐标[1215]
	地图处理类.地图单位[2057]={}
	地图处理类.单位编号[2057]=1000
	地图处理类.地图数据[2058]={npc={},单位={},传送圈={}} --hgs
	地图处理类.地图玩家[2058]={}
	地图处理类.地图坐标[2058]=地图处理类.地图坐标[1514]
	地图处理类.地图单位[2058]={}
	地图处理类.单位编号[2058]=1000
	地图处理类.地图数据[2059]={npc={},单位={},传送圈={}} --hgs
	地图处理类.地图玩家[2059]={}
	地图处理类.地图坐标[2059]=地图处理类.地图坐标[1249]
	地图处理类.地图单位[2059]={}
	地图处理类.单位编号[2059]=1000
end

function 灵猴出世:开启副本(数字id,事件)
	if 玩家数据[数字id].队伍==0 or 玩家数据[数字id].队长==false  then
		常规提示(数字id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(数字id)<5 and 调试模式==false then
		常规提示(数字id,"#Y此副本要求队伍人数不低于5人")
		return
	elseif  取等级要求(数字id,69)==false then
		常规提示(数字id,"#Y此副本要求角色等级不能低于69级")
		return
	end

	local 队伍id=玩家数据[数字id].队伍
	local 是否有任务=false
	for n=1,#队伍数据[队伍id].成员数据 do
		local id=队伍数据[队伍id].成员数据[n]
		if 副本数据[self.任务标题][id]  then
			if 副本数据[self.任务标题][id].完成  then
				添加最后对话(数字id,玩家数据[id].角色.名称.."今日已经完成了该副本，无法再领取任务！")
				return
			end
			是否有任务=玩家数据[id].角色:取任务(self.任务id)
		end
	end
	if 是否有任务  then
		self:副本传送(队伍id,是否有任务)
		return
	end
	local fbrwid,ZU=取唯一任务(self.任务id,数字id)
	任务数据[fbrwid]={
		领取人id=数字id,
		id=fbrwid,
		fbrwid=fbrwid,
		玩家id=数字id,
		DWZ=ZU,
		进度=1,
		销毁=true,
		起始=os.time(),
		结束=3600,
		天地灵气=15,
		队伍组={},
		类型=self.任务id
	}


	地图处理类:跳转地图(队伍id,2057,53,33)
	for n=1,#队伍数据[队伍id].成员数据 do
		local id=队伍数据[队伍id].成员数据[n]
		副本数据[self.任务标题][id]={完成=false,任务id=fbrwid,任务类型=self.任务标题}
		-- self:更改模型(id,"泡泡")
		if not 调试模式 then
			发送数据(玩家数据[id].连接id,6558,{调用={"灵猴出世",1},黑夜=true})
		end
		-- 添加最后对话(id,"花果山之巅，天地灵气凝于一颗奇石。当石破而出，一只灵猴降生于此世间。他漫游诸境,寻找归宿，拜师修炼。每一步都是成为“齐天大圣”的必经之路。")
		玩家数据[id].角色:添加任务(fbrwid)
	end
	self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	-- if 调试模式 then
	-- 	任务数据[fbrwid].进度=2
	-- 	if 任务数据[fbrwid].进度>=2 and 任务数据[fbrwid].进度<17 then
	-- 		地图处理类:跳转地图(队伍id,2058,20,82)
	-- 	elseif  任务数据[fbrwid].进度>=17 then
	-- 		地图处理类:跳转地图(数字id,2059,40,39)
	-- 	end

	-- 	self:更新副本进度(数字id)
	-- end
end

function 灵猴出世:更新副本进度(数字id)
	if not 取是否队长(数字id) then
		添加最后对话(数字id,"这种重要的事情还是让队长来吧！")
		return
	end
	if not 调试模式 and (玩家数据[数字id].队伍==0 or 取队伍人数(数字id)<5 or 取队伍最低等级(玩家数据[数字id].队伍,69)) then
		添加最后对话(数字id,"副本任务可在长安城副本官员（196，120）处领取，参与条件：≥69级，≥5人")
		return
	end
	local fbrwid=玩家数据[数字id].角色:取任务(self.任务id)
	if 调试模式 then
	    print("更新副本进度",fbrwid)
	end
	local 队伍id=玩家数据[数字id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local id=队伍数据[队伍id].成员数据[n]
		if not 副本数据[self.任务标题][id] or not 任务数据[fbrwid]  then
			添加最后对话(数字id,玩家数据[id].角色.名称.."没有领取副本任务！")
			return
		end
	end
	local 玩家模型 = 玩家数据[数字id].角色.模型
	local 玩家名称 = 玩家数据[数字id].角色.名称
	local 当前进度=任务数据[fbrwid].进度
	if 调试模式 then
	    print("更新副本进度:",当前进度)
	end
	任务数据[fbrwid].起始=os.time()
	if 当前进度==1 then --任务说明-1
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif 当前进度==2 then--任务说明-1  --打完灵石裂缝

		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		任务数据[fbrwid].小猴子们={}
		self:刷新队伍任务(队伍id)
		地图处理类:跳转地图(队伍id,2058,20,82)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
		-- for n=1,#队伍数据[队伍id].成员数据 do
		-- 	local id=队伍数据[队伍id].成员数据[n]
		-- 	self:更改模型(id,"超级六耳猕猴")
		-- end
	elseif 当前进度==3 then --任务说明-1 --打壮壮猴
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif 当前进度==4 then--任务说明-1  --挑衅
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif 当前进度==5 then--任务说明-1  --猴师兄
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif 当前进度==6 then--任务说明-1  --W服不服气。（通过长安
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==7  then --任务说明-1 --打混世魔石
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		任务数据[fbrwid].混世魔使=5
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif  当前进度==8  then --任务说明-1 --打混世魔石
		if 任务数据[fbrwid].混世魔使 then
			任务数据[fbrwid].混世魔使=任务数据[fbrwid].混世魔使-1
			if 任务数据[fbrwid].混世魔使<=0 or 调试模式 then
				任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
				self:添加NPC(任务数据[fbrwid].进度,fbrwid)
			end
			self:刷新队伍任务(队伍id)
		end
	elseif  当前进度==9  then --任务说明-1   混世魔王
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif  当前进度==10  then --任务说明-1   把将军
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif  当前进度==11  then --任务说明-1   特训开始
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==12  then --任务说明-1   特训开始
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==13  then --任务说明-1   特训开始
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==14  then --任务说明-1   拔将军
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==15  then --任务说明-1   拔将军
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==16  then --任务说明-1   添加瀑布
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif  当前进度==17  then --任务说明-1   添加瀑布
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		任务数据[fbrwid].异象之境={{名称="险恶瀑布",x=57,y=39},{名称="乱流浪花",x=80,y=30},{名称="溺水漩涡",x=74,y=72}}
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	elseif  当前进度==18  then --任务说明-1   添加瀑布
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==19  then --任务说明-1   添加瀑布
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
	elseif  当前进度==20  then --任务说明-1   添加瀑布
		任务数据[fbrwid].进度=任务数据[fbrwid].进度+1
		self:刷新队伍任务(队伍id)
		self:添加NPC(任务数据[fbrwid].进度,fbrwid)
	end
end


function 灵猴出世:取NPC对话内容(地图ID,NPC编号,名称,数字id,模型)
	玩家数据[数字id].最后对话={模型=模型 or "",名称=名称 or "",编号=0}
	if not 取是否队长(数字id) then
		添加最后对话(数字id,"这种重要的事情还是让队长来吧！")
		return
	end
	if not 调试模式 and (玩家数据[数字id].队伍==0 or 取队伍人数(数字id)<5 or 取队伍最低等级(玩家数据[数字id].队伍,69)) then
		添加最后对话(数字id,"副本任务可在长安城副本官员（196，120）处领取，参与条件：≥69级，≥5人")
		return
	end
	local fbrwid=玩家数据[数字id].角色:取任务(self.任务id)
	if 调试模式 then
	    print("取NPC对话内容",fbrwid)
	end
	if not 副本数据[self.任务标题][数字id] or not 任务数据[fbrwid]  then
		添加最后对话(数字id,玩家数据[数字id].角色.名称.."没有领取副本任务！")
		return
	end
	local 对话数据={}
	local 玩家模型 = 玩家数据[数字id].角色.模型
	local 玩家名称 = 玩家数据[数字id].角色.名称
	local wb2 = {}

	local 当前进度=任务数据[fbrwid].进度
end

function 灵猴出世:NPC对话事件处理(数字id,名称,事件,地图ID)
	local fbrwid=玩家数据[数字id].角色:取任务(self.任务id)
	if not 副本数据[self.任务标题][数字id] or not 任务数据[fbrwid]  then
		添加最后对话(数字id,"副本任务在长安城传令天兵处领取！")
		return
	end
	local 对话数据={}
	local 玩家模型 = 玩家数据[数字id].角色.模型
	local 玩家名称 = 玩家数据[数字id].角色.名称
	local wb2 = {}
	local 当前进度=任务数据[fbrwid].进度
	if 调试模式 then
		print("NPC对话事件处理",名称,事件)
	end
	if 事件=="出手制服叶飘扬（需战斗）" then
		if 当前进度==14 then
			战斗准备类:创建战斗(数字id,140024,fbrwid)
		end
	elseif 名称=="花丛" then
		if 当前进度>=9 then
			if 事件=="进入" then

			end
		end
	elseif 事件=="撸起袖子动手吧！（需战斗）" then
		if 任务数据[fbrwid].阿盘的指示图坐标 then
			战斗准备类:创建战斗(数字id,140021,fbrwid)
			发送战斗紧急任务(数字id,"灵猴出世_神秘宝物")
		end
	end
end
function 灵猴出世:索取临时NPC对话(数字id,类型,标识,地图)
	if not 取是否队长(数字id) then
		添加最后对话(数字id,"这种重要的事情还是让队长来吧！")
		return
	end
	if not 调试模式 and (玩家数据[数字id].队伍==0 or 取队伍人数(数字id)<5 or 取队伍最低等级(玩家数据[数字id].队伍,69)) then
		添加最后对话(数字id,"副本任务可在长安城副本官员（196，120）处领取，参与条件：≥69级，≥5人")
		return
	end
	local fbrwid=玩家数据[数字id].角色:取任务(self.任务id)
	--print(fbrwid,1)
	if not 副本数据[self.任务标题][数字id] or not 任务数据[fbrwid]  then
		添加最后对话(数字id,玩家数据[数字id].角色.名称.."没有领取副本任务！")
		return
	end
	local 当前进度=任务数据[fbrwid].进度
	local 对话数据={模型=任务数据[标识].模型,名称=任务数据[标识].名称}
	local wb2 = {}
	local 名称 = 任务数据[标识].名称
	local 玩家模型 = 玩家数据[数字id].角色.模型
	local NPC模型 = 任务数据[标识].模型
	local 玩家名称 = 玩家数据[数字id].角色.名称
	玩家数据[数字id].最后对话={模型=任务数据[标识].模型,名称=名称,编号=0}
	--print(名称,当前进度)
	if 名称=="天地灵气" or 名称=="日月精华" then
		if 当前进度==1 then
			任务数据[fbrwid].天地灵气=任务数据[fbrwid].天地灵气-1
			if 调试模式 then
				任务数据[fbrwid].天地灵气=0
			end
			if 任务数据[fbrwid].天地灵气<=0 then
				self:更新副本进度(数字id)
			else
				常规提示(数字id,"收集到一些天地灵气，感觉体内的力量在增长，再汲取一些吧！")
				self:刷新队伍任务(数字id)
			end
			self:添加队伍经验银子(数字id)

		end
		地图处理类:删除单位(任务数据[标识].地图编号,任务数据[标识].单位编号)
		任务数据[标识]=nil
	elseif 名称=="壮猴猴" or 名称=="懒猴猴" or 名称=="猴妹妹" then
		if 当前进度==3 then
			if 任务数据[fbrwid].小猴子们[名称] then
				添加最后对话(数字id,"这就是……桃子吗?吧唧吧唧，好甜!")
				return
			end
			对话数据.对话="我学会了!"
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
			任务数据[fbrwid].小猴子们[名称]=true
			if 任务数据[fbrwid].小猴子们["壮猴猴"]  and 任务数据[fbrwid].小猴子们["懒猴猴"] and 任务数据[fbrwid].小猴子们["猴妹妹"] then
				self:更新副本进度(数字id)
			end
			self:添加队伍经验银子(数字id)
		elseif  名称=="壮猴猴" then
			if 当前进度==4 then
				对话数据.对话="看我的壮壮猴拳!"
				对话数据.选项={"见招拆招！（战斗）","跑为上计。"}
				发送数据(玩家数据[数字id].连接id,1501,对话数据)
			elseif  当前进度==5  then
				self:更新副本进度(数字id)
				对话数据.对话="自从那石头怪出世以来，咱的山泉越来越旱，树上的桃儿也越来越干瘪，咱们是不是快饿死了啊………"
				wb2 = {"进阶长眉灵猴","猴妹妹","放心吧，长老们已经已经出发寻找新家园了，他们一定会带回好消息的!."} --有选项的注意名称
				wb2[5] = {"超级六耳猕猴","壮猴猴","没错，相信长老们!我们要做的就是守卫好家园，不能给妖怪趁虚而入的机会!.…."}
				wb2[5][5] = {玩家模型,"懒猴猴","是呀，那个石头怪成日和豺狼虎豹混在一起，可得打起精神守家呢!"}
				wb2[5][5][5] = {"狼","豺狼","说谁妖怪呢，这是我们猴哥，放尊敬点儿!"}
				wb2[5][5][5][5] = {玩家模型,玩家名称,"你们这样的，来十个我也不怕!"}
				对话数据.下一页=wb2
				发送数据(玩家数据[数字id].连接id,1501,对话数据)
				self:添加队伍经验银子(数字id)
			elseif  当前进度==7  then
				self:更新副本进度(数字id)
				对话数据.对话="怎么样，认输了吧?你们没有一个打得过我，是不是该叫我一声“猴王”啦?"
				wb2 = {"进阶长眉灵猴","猴妹妹","师哥!!."} --有选项的注意名称
				wb2[5] = {"超级六耳猕猴","壮猴猴","我承认你很强，别以为这样就能赢得猴族的尊敬!猴王才不是会打架就行的!"}
				wb2[5][5] = {玩家模型,玩家名称,"哦?那你说说，要怎么样才能当你们的王?"}
				wb2[5][5][5] = {"进阶长眉灵猴","猴妹妹","猴王，是能承担得起猴群未来的伟大的猴儿!!"}
				wb2[5][5][5][5] ={"进阶长眉灵猴","猴妹妹","小妹说得对，比如现在，长老们为了我正寻找新水源而艰难地远征寻找新家园。!"}
				对话数据.下一页=wb2
				发送数据(玩家数据[数字id].连接id,1501,对话数据)
				if 任务数据[标识].关联任务id then
					local  rwid={}
					for i=1,3 do
						rwid[i]=任务数据[标识].关联任务id[i]
					end
					for i=1,3 do
						if 任务数据[rwid[i]] then
							地图处理类:删除单位(任务数据[rwid[i]].地图编号,任务数据[rwid[i]].单位编号)
							任务数据[rwid[i]]=nil
						end
					end
				end
				self:添加队伍经验银子(数字id)

			end
		end
	elseif 名称=="猴师兄"   then
		if 当前进度==6 then
			对话数据.对话="孩儿们不用怕，哥来保护你们!"
			对话数据.选项={"打到你服！（战斗）","不和你计较。"}
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
		end
	elseif 名称=="灵石裂隙" and 当前进度==2  then
		对话数据.对话="这里，似乎可以通向另一个世界？！"
		对话数据.选项={"突破它吧！（战斗）","再看看吧。"}
		发送数据(玩家数据[数字id].连接id,1501,对话数据)
		print("22222")

	elseif 任务数据[标识].任务事件=="混世魔使" and 当前进度==8  then
		-- 对话数据.对话="猴惠子们听好了，我家大王有令:速速献出山头可免一死，顽抗者杀无赦!"
		-- 对话数据.选项={"吃我一招！（战斗）","再看看吧。"}
		-- 发送数据(玩家数据[数字id].连接id,1501,对话数据)
		战斗准备类:创建战斗(数字id,140030,标识)
	elseif 名称=="混世魔王"  then
		if 当前进度==9 then
			对话数据.对话="哎呀，小猴猴，本大王要给你展示展示啥叫真·妖怪的样子了哦!"
			wb2 = {"进阶狂豹人形",名称,"哼，我也还是第一次跟真正的妖怪过招，来得正好，就拿你练练手吧。",{"迎战魔王！（战斗）","跑为上计。"}} --有选项的注意名称
			对话数据.下一页=wb2
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
		end
	elseif 名称=="猴长老"  then
		if 当前进度==10 then
			self:更新副本进度(数字id)
			对话数据.对话="感谢你，年轻的小英雄，因为你，从混世魔王手下守护了猴群。"
			wb2 =  {玩家模型,玩家名称,"我是……英雄吗?没、没啥，这里也是我的家园。"} --有选项的注意名称
			wb2[5] =  {玩家模型,玩家名称,"不过，总觉得不对劲，这儿不是已经差到需要寻找新居所了吗，为什么混世魔王还要来抢地盘呢?"}
			wb2[5][5] =  {"马猴",名称,"这次的勘查之旅，我们已经成功发现了新水源，这花果山中呀还潜藏着一个全新的栖息之所!或许混世魔王探听到了这一消息………"}
			wb2[5][5][5] =  {"马猴",名称,"咳咳，说回正事儿，小灵猴，你可愿与我们猴群同行?开辟新家园的道路，可不容易，你的加入，定能为我们带来无尽的力量。"}
			wb2[5] [5] [5] [5] =  {玩家模型,玩家名称,"我愿意！"}
			对话数据.下一页=wb2
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
			self:添加队伍经验银子(数字id)
		elseif 当前进度==20 then
			self:更新副本进度(数字id)
			对话数据.对话="他回来了!为我们找到新家园新任猴王诞生了!"
			wb2 =  {玩家模型,玩家名称,"长老……你的意思是……"} --有选项的注意名称
			wb2[5] =  {NPC模型,名称,"没错，你已经证明了自己！"}
			wb2[5][5] =  {NPC模型,名称,"愿永远跟随您!猴王大人!"}
			对话数据.下一页=wb2
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
			self:添加队伍经验银子(数字id)
		end
	elseif 名称=="芭将军"  then
		if 当前进度==11 then
			self:更新副本进度(数字id)
			对话数据.对话="我是本次探险队的总教头，负责将你们训练为合格的己士!请依次完成跑步、爬树、游水特训吧!"
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
			self:添加队伍经验银子(数字id)
		elseif 当前进度==15 then
			添加最后对话(数字id,"你的各项能力我已经有了充分的了解，但我们不能做无谓的牺牲，只有最后通过我的综合考验，你才能加入探索小队。",{"准备好了！（战斗）","再准备准备。"})
		end
	elseif 名称=="游水特训"  then
		if 当前进度==12 then
			添加最后对话(数字id,"准备好了，就开始特训吧!",{"准备好了！（战斗）","再准备准备。"})
		end
	elseif 名称=="赛跑特训"  then
		if 当前进度==13 then
			添加最后对话(数字id,"准备好了，就开始特训吧!",{"准备好了！（战斗）","再准备准备。"})
		end
	elseif 名称=="爬树特训"  then
		if 当前进度==14 then
			添加最后对话(数字id,"准备好了，就开始特训吧!",{"准备好了！（战斗）","再准备准备。"})
		end
	elseif 名称=="崩将军"  then
		if 当前进度==16 then
			self:更新副本进度(数字id)
			添加最后对话(数字id,"你就是探险队的新成员吗?这件威风的披风是对勇士的嘉奖，披上它吧，这是荣耀的象征!")
			--self:添加队伍经验银子(数字id)
		end
	elseif 名称=="瀑布"  then
		if 当前进度==17 then
			添加最后对话(数字id,"一种奇异的灵力涌动的感觉，似乎有什么力量在呼唤着我。",{"尝试感应力量！","再准备准备。"})
		end
	elseif 名称=="险恶瀑布"  or 名称=="乱流浪花" or 名称=="溺水漩涡" then
		if 当前进度==18 then
			添加最后对话(数字id,"事已至此，只有冲破这些险象，才能叩开新家园的大门!",{"准备好了！（战斗）","还是跑吧。"})
		end
	elseif 名称=="失衡的水行灵"  then
		if 当前进度==19 then
			对话数据.对话="嘶……嘶嘶……嘶嘶嘶……."
			wb2 =  {玩家模型,玩家名称,"奇怪，这水流声好像在说些什么?"} --有选项的注意名称
			wb2[5] =  {NPC模型,名称,"嘶（你)(终于)………嘶嘶嘶(来了)……嘶（我)……嘶嘶（在等着)……嘶嘶嘶（你)"}
			wb2[5][5] =  {NPC模型,名称,"难道我……出现幻觉了?没有别的办法了，只有战胜它，才能离开这鬼地方!",{"准备好了！（战斗）","还是跑吧。"}}
			对话数据.下一页=wb2
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
		end
	elseif 名称=="神秘长者"  then
		if 当前进度==21 then
			self:任务结束(数字id)
			对话数据.对话="成为猴王的担子可不轻啊，我真的能扛起这份责任吗?要怎样才能变得更强大呢?."
			wb2 =  {NPC模型,名称,"平定了此地水行异象的，就是你吗?"} --有选项的注意名称
			wb2[5] =  {玩家模型,玩家名称,"咦?你是谁?我还是第一次见到没长毛的猴子呢……"}
			wb2[5][5] =  {NPC模型,名称,"呵呵，你想变得更强大吗?"}
			wb2[5][5][5] =  {玩家模型,玩家名称,"你怎么知道我在想什么?!有什么特训的办法让我变得更厉害吗?"}
			wb2[5][5][5] [5]  =  {NPC模型,名称,"若有心学艺，可向西牛贺洲来寻。"}
			对话数据.下一页=wb2
			发送数据(玩家数据[数字id].连接id,1501,对话数据)
			地图处理类:跳转地图(数字id,1040,85,63)
		end

	end
end

function 灵猴出世:怪物对话处理(数字id,名称,事件,类型,rwid)
	if 调试模式 then
		print(名称,事件)
	end
	if not 取是否队长(数字id) then
		添加最后对话(数字id,"这种重要的事情还是让队长来吧！")
		return
	end
	if not 副本数据[self.任务标题][数字id]  then
		return
	end
	local fbrwid=副本数据[self.任务标题][数字id].任务id
	local 当前进度=任务数据[fbrwid].进度
	if 名称=="灵石裂隙" then
		if 当前进度==2  then
			if 事件=="突破它吧！（战斗）" then
				--print(rwid)
				战斗准备类:创建战斗(数字id,140027,rwid) --这里的任务id 要区分，
			end
		end
	elseif  当前进度==4 and  名称=="壮猴猴" and 事件=="见招拆招！（战斗）" then
		战斗准备类:创建战斗(数字id,140028,rwid) --这里的任务id 要区分，
	elseif 名称=="猴师兄"   then
		if 当前进度==6  and 事件=="打到你服！（战斗）" then
			战斗准备类:创建战斗(数字id,140029,rwid) --这里的任务id 要区分，
		end
	elseif 名称=="混世魔王"   then
		if 当前进度==9  and 事件=="迎战魔王！（战斗）" then
			战斗准备类:创建战斗(数字id,140031,rwid) --这里的任务id 要区分，
		end
	elseif 名称=="游水特训"   then
		if 当前进度==12  and 事件=="准备好了！（战斗）" then
			战斗准备类:创建战斗(数字id,140032,rwid) --这里的任务id 要区分，
		end
	elseif 名称=="赛跑特训"  then
		if 当前进度==13  and 事件=="准备好了！（战斗）" then
			战斗准备类:创建战斗(数字id,140033,rwid) --这里的任务id 要区分，
		end
	elseif 名称=="爬树特训"   then
		if 当前进度==14  and 事件=="准备好了！（战斗）" then
			战斗准备类:创建战斗(数字id,140034,rwid) --这里的任务id 要区分，
		end
	elseif 名称=="芭将军"  then
		if 当前进度==15  and 事件=="准备好了！（战斗）" then
			战斗准备类:创建战斗(数字id,140035,rwid) --这里的任务id 要区分，
		end
	elseif 名称=="瀑布"  then
		if 当前进度==17  and 事件=="尝试感应力量！" then
			self:更新副本进度(数字id)
			地图处理类:跳转地图(数字id,2059,40,39)
		end
	elseif 名称=="险恶瀑布"  or 名称=="乱流浪花" or 名称=="溺水漩涡" then
		if 当前进度==18 and 事件=="准备好了！（战斗）" then
			战斗准备类:创建战斗(数字id,140036,rwid)
		end
	elseif 名称=="失衡的水行灵"  then
		if 当前进度==19  and 事件=="准备好了！（战斗）" then
			战斗准备类:创建战斗(数字id,140037,rwid) --这里的任务id 要区分，
		end
	end
end





function 灵猴出世:添加NPC(当前进度,fbrwid)
	local 地图,NPCID,ZU
	if 当前进度==1 then
		地图=2057
		for i=1,16 do
			NPCID,ZU=取唯一任务(self.NPC类型)
			local xy=地图处理类.地图坐标[地图]:取随机点()
			local 模型="天地灵气"
			if 取随机数(1,10)<=3 then
				模型="日月精华"
			end
			任务数据[NPCID]={
				id=NPCID,
				起始=os.time(),
				结束=3600,
				销毁=true,
				副本id=fbrwid,
				名称=模型,
				-- 任务显示=模型,
				模型=模型,
				点击索取对话=function(数字id,序列,标识,地图,类型)
					return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
				end,
				x=xy.x,
				y=xy.y,
				方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=self.NPC类型
			}
			地图处理类:添加单位(NPCID)
		end
	elseif 当前进度==2 then
		地图=2057
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="灵石裂隙",
			-- 任务显示="盘丝弟子",
			模型="灵石裂隙",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=106,
			y=83,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	elseif 当前进度==3 then
		地图=2058
		local NPCID,ZU=取唯一任务(self.NPC类型)
		local NPCID1,ZU=取唯一任务(self.NPC类型)
		local NPCID2,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			关联任务id={NPCID,NPCID1,NPCID2},
			副本id=fbrwid,
			名称="壮猴猴",
			任务显示="盘丝弟子",
			模型="超级六耳猕猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=7,
			y=75,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)

		任务数据[NPCID1]={
			id=NPCID1,
			起始=os.time(),
			关联任务id={NPCID,NPCID1,NPCID2},
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="懒猴猴",
			任务显示="盘丝弟子",
			模型="生肖猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=29,
			y=72,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID1)

		任务数据[NPCID2]={
			id=NPCID2,
			起始=os.time(),
			关联任务id={NPCID,NPCID1,NPCID2},
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="猴妹妹",
			任务显示="盘丝弟子",
			模型="进阶长眉灵猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=46,
			y=73,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID2)
	elseif 当前进度==4 then
		地图=2058
		NPCID,ZU=取唯一任务(self.NPC类型)
		local NPCID1,ZU=取唯一任务(self.NPC类型)
		local NPCID2,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			关联任务id={NPCID,NPCID1,NPCID2},
			副本id=fbrwid,
			名称="壮猴猴",
			-- 任务显示="盘丝弟子",
			模型="超级六耳猕猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=114,
			y=104,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)

		任务数据[NPCID1]={
			id=NPCID1,
			起始=os.time(),
			关联任务id={NPCID,NPCID1,NPCID2},
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="懒猴猴",
			-- 任务显示="盘丝弟子",
			模型="生肖猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=107,
			y=105,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID1)

		任务数据[NPCID2]={
			id=NPCID2,
			起始=os.time(),
			关联任务id={NPCID,NPCID1,NPCID2},
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="猴妹妹",
			-- 任务显示="盘丝弟子",
			模型="进阶长眉灵猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=114,
			y=108,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID2)
	elseif 当前进度==6 then
		地图=2058
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="猴师兄",
			-- 任务显示="盘丝弟子",
			模型="超级六耳猕猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=90,
			y=104,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	elseif  当前进度==8 then
		地图=2058
		for i=1,6 do
			NPCID,ZU=取唯一任务(self.NPC类型)
			local xy=地图处理类.地图坐标[地图]:取随机点()
			local ffsf={"甲","乙","丙","丁"}
			local 名称="混世魔使"..ffsf[取随机数(1,4)]
			任务数据[NPCID]={
				id=NPCID,
				起始=os.time(),
				结束=3600,
				销毁=true,
				副本id=fbrwid,
				名称=名称,
				任务事件="混世魔使",
				战斗显示=1,
				模型="炎魔神",
				点击索取对话=function(数字id,序列,标识,地图,类型)
					return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
				end,
				x=xy.x,
				y=xy.y,
				方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=self.NPC类型
			}
			地图处理类:添加单位(NPCID)
		end
	elseif 当前进度==9 then
		地图=2058
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="混世魔王",
			战斗显示=1,
			模型="进阶狂豹人形",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=20,
			y=79,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	elseif 当前进度==10 then
		地图=2058
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=5600,
			销毁=true,
			副本id=fbrwid,
			名称="猴长老",
			-- 战斗显示=1,
			模型="马猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=38,
			y=18,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	elseif 当前进度==11 then
		地图=2058
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="芭将军", --
			-- 战斗显示=1,
			模型="进阶巨力神猿",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=111,
			y=103,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="游水特训",
			战斗显示=1,
			模型="巴蛇",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=97,
			y=113,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="赛跑特训",
			战斗显示=1,
			模型="机关兽",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=107,
			y=111,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="爬树特训",
			战斗显示=1,
			模型="机关人人形",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=122,
			y=109,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="崩将军",
			-- 战斗显示=1,
			模型="马猴",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=61,
			y=94,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	elseif 当前进度==17 then
		地图=2058
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="瀑布", --
			任务显示=1,
			模型="瀑布",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=46,
			y=93,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	elseif 当前进度==18 then
		地图=2059
		NPCID,ZU=取唯一任务(self.NPC类型)
		local NPCID1,ZU=取唯一任务(self.NPC类型)
		local NPCID2,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			关联任务id={NPCID,NPCID1,NPCID2},
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="险恶瀑布", --
			战斗显示=1,
			模型="雷龙",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=57,
			y=39,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)

		任务数据[NPCID1]={
			id=NPCID1,
			起始=os.time(),
			关联任务id={NPCID,NPCID1,NPCID2},
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="乱流浪花", --
			战斗显示=1,
			模型="蛟龙",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=80,
			y=30,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID1)

		任务数据[NPCID2]={
			id=NPCID2,
			起始=os.time(),
			关联任务id={NPCID,NPCID1,NPCID2},
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="溺水漩涡", --
			战斗显示=1,
			模型="雷龙",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=74,
			y=72,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID2)

		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="失衡的水行灵",
			战斗显示=1,
			模型="进阶蜃气妖",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=65,
			y=120,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	elseif 当前进度==21 then
		地图=2058
		NPCID,ZU=取唯一任务(self.NPC类型)
		任务数据[NPCID]={
			id=NPCID,
			起始=os.time(),
			结束=3600,
			销毁=true,
			副本id=fbrwid,
			名称="神秘长者",
			任务显示="盘丝弟子",
			模型="菩提老祖",
			点击索取对话=function(数字id,序列,标识,地图,类型)
				return self:索取临时NPC对话(数字id,序列,标识,地图,类型)
			end,
			对话选项解析=function(数字id,名称,事件,类型,rwid,门派)
				return self:怪物对话处理(数字id,名称,事件,类型,rwid)
			end,
			x=9,
			y=77,
			方向=0,
                                    地图显示=true,--如果地图要显示这个单位 就加上这个变量
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=self.NPC类型
		}
		地图处理类:添加单位(NPCID)
	end
end






-----------------------------
function 灵猴出世:刷新队伍任务(队伍id,紧急任务)
	if not 队伍数据[队伍id] then
		if 玩家数据[队伍id] then
			玩家数据[队伍id].角色:刷新任务跟踪()
			if 紧急任务 then
				发送数据(玩家数据[队伍id].连接id, 5528,紧急任务)
			end
		end
		return
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		local id=队伍数据[队伍id].成员数据[n]
		玩家数据[id].角色:刷新任务跟踪()
		if 紧急任务 then
			发送数据(玩家数据[id].连接id, 5528,紧急任务)
		end
	end
end
function 灵猴出世:任务失败(队伍id,紧急任务)
	for n=1,#队伍数据[队伍id].成员数据 do
		local id=队伍数据[队伍id].成员数据[n]
		副本数据[self.任务标题][id]=nil
		玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(self.任务id))
		添加最后对话(id,"紧急任务失败，副本任务已取消！")
		if 紧急任务 then
			local 紧急任务表={进度比例=1,失败=true}
			发送数据(玩家数据[id].连接id, 5528,紧急任务表)
		end
	end
end
function 灵猴出世:任务结束(队伍id)
	local fbrwid=玩家数据[队伍id].角色:取任务(self.任务id)
	for n=1,#队伍数据[队伍id].成员数据 do
		local id=队伍数据[队伍id].成员数据[n]
		副本数据[self.任务标题][id]={完成=true}
		玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(self.任务id))
	end
	if  fbrwid then
		for n, v in pairs(任务数据) do
			if 任务数据[n] and 任务数据[n].地图编号 and 任务数据[n].单位编号 and 任务数据[n].fbrwid==fbrwid then
				地图处理类:删除单位(任务数据[n].地图编号,任务数据[n].单位编号)
				任务数据[n]=nil
			end
		end
	end



end


function 灵猴出世:战斗胜利处理(id组,战斗类型,任务id,任务失败)
	local 数字id = id组[1]
	if 任务失败 then
		添加最后对话(数字id,"……")
		return
	end
	if not 副本数据[self.任务标题][数字id] then
		return
	-- elseif 战斗类型 == 140022 or 战斗类型 == 140023  then
	-- 	local fbrwid=副本数据[self.任务标题][数字id].任务id
	-- 	if fbrwid and os.time()-任务数据[fbrwid].倒计时>0 then
	-- 		self:任务失败(数字id,"紧急任务")
	-- 		return
	-- 	end
	-- 	for i=1,#任务数据[fbrwid].蛛丝坐标 do
	-- 		if 任务数据[fbrwid].蛛丝坐标[i].x==任务数据[任务id].x then
	-- 			table.remove(任务数据[fbrwid].蛛丝坐标, i)
	-- 			break
	-- 		end
	-- 	end
	end
	if 任务数据[任务id] then
		任务数据[任务id].zhandou = nil
	end

	if 战斗类型>=140027 and  战斗类型<=140037 then
		self:完成奖励(id组,战斗类型)
		self:更新副本进度(数字id)
		if 调试模式 then
		  print("战斗胜利处理",战斗类型,任务id)
		end
		if 战斗类型 == 140028 then
			if 任务数据[任务id].关联任务id then
				local  rwid={}
				for i=1,3 do
					rwid[i]=任务数据[任务id].关联任务id[i]
				end
				for i=1,3 do
					if 任务数据[rwid[i]] then
						地图处理类:删除单位(任务数据[rwid[i]].地图编号,任务数据[rwid[i]].单位编号)
						任务数据[rwid[i]]=nil
					end
				end
			end
		elseif 战斗类型 ==140030 or 战斗类型 ==140031 then
			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
			任务数据[任务id]=nil
			if 战斗类型 == 140031 then
				添加最后对话(数字id,"长老们回来了，听说了你拯救猴群的义举，邀请你前去一聚呢!")
			end
		elseif 战斗类型 ==140036 then
			if 任务数据[任务id].关联任务id then
				local  rwid={}
				for i=1,3 do
					rwid[i]=任务数据[任务id].关联任务id[i]
				end
				for i=1,3 do
					if 任务数据[rwid[i]] then
						地图处理类:删除单位(任务数据[rwid[i]].地图编号,任务数据[rwid[i]].单位编号)
						任务数据[rwid[i]]=nil
					end
				end
			end
		elseif 战斗类型 ==140037 then
			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
			任务数据[任务id]=nil
			添加最后对话(数字id,"长老我们安全回来了！")
			地图处理类:跳转地图(数字id,2058,69,62)
		end
		-- if 战斗类型 == 140020 or 战斗类型 == 140022 or 战斗类型 == 140023  then
		-- 	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
		-- 	任务数据[任务id]=nil
		-- end
	end
end

function 取是否队长(id)
	if 玩家数据[id].队伍==0 then
		return id
	else
		if 玩家数据[id].队伍==id then
			return id
		end
	end
end

function 灵猴出世:完成奖励(id组,战斗类型)
	local 链接
	if  战斗类型 <= 140036 then
		for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(950,1050)+100000
		local 银子=等级*取随机数(90,120)+30000
			玩家数据[id].角色:添加经验(经验,"灵猴出世_前几关")
			玩家数据[id].角色:添加储备(银子,"灵猴出世_前几关",1)
			玩家数据[id].zhandou=0
			  if 取随机数()<=100 then
            local 链接 = {提示=format("#S(灵猴出世_前几关)#R/%s#Y经过一番激烈的战斗，最终战胜了#R灵猴出世_前几关#Y，#Y因此获得了唐王奖励的#G/",玩家数据[id].角色.名称),频道="xt",结尾="#"..取随机数(1,110)}
          local 奖励参数=取随机数(1,200)
     if 奖励参数<=3 then
          local 名称="神兜兜"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
         elseif 奖励参数<=4 then
          local 名称="和田玉"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<1 then
          local 名称="特效宝珠"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=6 then
          local 名称="陨铁"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=7 then
          local 名称="制造指南书"
        玩家数据[id].道具:给予超链接道具(id,"制造指南书",{12,15},nil,链接)
          elseif 奖励参数<=11 then
          local 名称="120百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",120,nil,链接)
          elseif 奖励参数<=10 then
          local 名称="130百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",130,nil,链接)
         elseif 奖励参数<=9 then
          local 名称="140百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",140,nil,链接)
         elseif 奖励参数<=8 then
          local 名称="150百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",150,nil,链接)
        elseif 奖励参数<=12 then
          local 名称="高级魔兽要诀"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=13 then
          local 名称="修炼果"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=14 then
          local 名称="高级魔兽要诀"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=15 then
          local 名称=取强化石()
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=16 then
          local 名称="九转金丹"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=17 then
          local 名称=取宝石()
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
         elseif 奖励参数<=18 then
        local 名称="灵饰指南书"
        玩家数据[id].道具:给予超链接道具(id,"灵饰指南书",{6,8},nil,链接)
        常规提示(id,"#Y/你获得了"..名称)
      elseif 奖励参数<=19 then
        local 名称="元灵晶石"
        玩家数据[id].道具:给予超链接道具(id,"元灵晶石",{6,8},nil,链接)
			end
		end
		end
	elseif 战斗类型 == 140037 then
			for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(950,1050)+100000
		local 银子=等级*取随机数(90,120)+30000
			玩家数据[id].角色:添加经验(经验,"灵猴出世_结束")
			玩家数据[id].角色:添加储备(银子,"灵猴出世_结束",1)
			        玩家数据[id].角色:添加副本积分(200)
                                    玩家数据[id].角色:添加仙玉(取随机数(1,10),"鱼肚怪",1)
			玩家数据[id].zhandou=0
			  if 取随机数()<=100 then
            local 链接 = {提示=format("#S(灵猴出世_结束)#R/%s#Y经过一番激烈的战斗，最终战胜了#R灵猴出世_结束#Y，#Y因此获得了唐王奖励的#G/",玩家数据[id].角色.名称),频道="xt",结尾="#"..取随机数(1,110)}
          local 奖励参数=取随机数(1,200)
   if 奖励参数<=3 then
          local 名称="神兜兜"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
         elseif 奖励参数<=4 then
          local 名称="和田玉"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<5 then
          local 名称="特效宝珠"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=6 then
          local 名称="陨铁"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=7 then
          local 名称="制造指南书"
        玩家数据[id].道具:给予超链接道具(id,"制造指南书",{12,15},nil,链接)
          elseif 奖励参数<=11 then
          local 名称="120百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",120,nil,链接)
          elseif 奖励参数<=10 then
          local 名称="130百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",130,nil,链接)
         elseif 奖励参数<=9 then
          local 名称="140百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",140,nil,链接)
         elseif 奖励参数<=8 then
          local 名称="150百炼精铁"
          玩家数据[id].道具:给予超链接道具(id,"百炼精铁",150,nil,链接)
        elseif 奖励参数<=12 then
          local 名称="高级魔兽要诀"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=13 then
          local 名称="修炼果"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=14 then
          local 名称="高级魔兽要诀"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=15 then
          local 名称=取强化石()
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=16 then
          local 名称="九转金丹"
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
        elseif 奖励参数<=17 then
          local 名称=取宝石()
          玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
         elseif 奖励参数<=18 then
        local 名称="灵饰指南书"
        玩家数据[id].道具:给予超链接道具(id,"灵饰指南书",{6,8},nil,链接)
        常规提示(id,"#Y/你获得了"..名称)
      elseif 奖励参数<=19 then
        local 名称="元灵晶石"
        玩家数据[id].道具:给予超链接道具(id,"元灵晶石",{6,8},nil,链接)
			end
		end
		end
	end
end

function 灵猴出世:添加队伍经验银子(数字id)
	local 队伍id=玩家数据[数字id].队伍
	if 队伍数据[队伍id] and 队伍数据[队伍id].成员数据 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local id=队伍数据[队伍id].成员数据[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(750,900)
			local 银子=等级*取随机数(80,100)+30000
			玩家数据[id].角色:添加经验(经验,"灵猴出世")
			玩家数据[id].角色:添加储备(银子,"灵猴出世",1)

		end
	end
end
--local 链接 = {提示=format("#S(灵猴出世)#G%s#Y在灵猴出世副本中发现了",玩家数据[id].角色.名称),频道="hd",结尾="#Y淡定地放入自己的口袋。"}

function 灵猴出世:副本传送(队伍id,fbrwid)
	if 任务数据[fbrwid] then
		if 调试模式 then
		    print("副本传送",任务数据[fbrwid].进度)
		end
		if  任务数据[fbrwid].进度<=2 then
			地图处理类:跳转地图(队伍id,2057,53,33)
		elseif 任务数据[fbrwid].进度>2 and 任务数据[fbrwid].进度<17 then
			地图处理类:跳转地图(队伍id,2058,20,82)
		elseif  任务数据[fbrwid].进度>=17 then
			地图处理类:跳转地图(队伍id,2059,40,39)
		end
	end
end
-- 玩家数据[数字id].道具:给予任务道具(数字id,"墨魂灯")
function 灵猴出世:更改模型(数字id,模型)
	玩家数据[数字id].角色.变身数据=模型
	发送数据(玩家数据[数字id].连接id,37,玩家数据[数字id].角色.变身数据)
	设置任务1(数字id,1,玩家数据[数字id].角色.变身数据,1200)
	地图处理类:更改模型(数字id,玩家数据[数字id].角色.变身数据,1)
end
function 灵猴出世:任务说明(玩家id,fbrwid)
	local 说明 = {}
	if not 副本数据[self.任务标题][玩家id] or not 任务数据[fbrwid]  then
		说明={self.任务标题,format("任务追踪丢失。")}
		return 说明
	end
	local 进度=任务数据[fbrwid].进度
	if 进度==1 then
		说明={self.任务标题,format("收集#R天地灵气#W（还需收集#Y%s#W个天地灵气）（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",任务数据[fbrwid].天地灵气,196,120)}
	elseif 进度==2 then
		说明={self.任务标题,format("前往前方的#R/qqq|灵石裂隙*2057*临时npc*%s*%s/灵石裂隙#W，找到出口！（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",106,83,196,120)}
	elseif 进度==3 then
		说明={self.任务标题,format("向#R小猴子们#W学习猴的生存之道。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",196,120)}
	elseif 进度==4 then
		说明={self.任务标题,format("应对#R/qqq|壮猴猴*2058*临时npc*%s*%s/壮猴猴#W的进攻。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",7,75,196,120)}
	elseif 进度==5 then
		说明={self.任务标题,format("挑衅#R/qqq|壮猴猴*2058*临时npc*%s*%s/壮猴猴#W。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",114,104,196,120)}
	elseif 进度==6 then
		说明={self.任务标题,format("挑战猴群，击败#R/qqq|猴师兄*2058*临时npc*%s*%s/猴师兄#W。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",90,104,196,120)}
	elseif 进度==7 then
		说明={self.任务标题,format("问问#R/qqq|壮猴猴*2058*临时npc*%s*%s/壮猴猴#W服不服气。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",114,104,196,120)}
	elseif 进度==8 then
		说明={self.任务标题,format("解救猴群，击败#R%s#W个混世魔使。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",任务数据[fbrwid].混世魔使,196,120)}
	elseif 进度==9 then
		说明={self.任务标题,format("迎战#R/qqq|混世魔王*2058*临时npc*%s*%s/混世魔王#W。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",20,79,196,120)}
	elseif 进度==10 then
		说明={self.任务标题,format("听听#R/qqq|猴长老*2058*临时npc*%s*%s/猴长老#W想说什么。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",38,18,196,120)}
	elseif 进度==11 then
		说明={self.任务标题,format("听听#R/qqq|芭将军*2058*临时npc*%s*%s/芭将军#W想说什么。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",111,103,196,120)}
	elseif 进度==12 then
		说明={self.任务标题,format("接受#R/qqq|游水特训*2058*临时npc*%s*%s/游水特训#W的游水特训。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",97,113,196,120)}
	elseif 进度==13 then
		说明={self.任务标题,format("接受#R/qqq|赛跑特训*2058*临时npc*%s*%s/赛跑特训#W赛跑特训。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",107,111,196,120)}
	elseif 进度==14 then
		说明={self.任务标题,format("接受#R/qqq|爬树特训*2058*临时npc*%s*%s/爬树特训#W爬树特训。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",122,109,196,120)}
	elseif 进度==15 then
		说明={self.任务标题,format("接受#R/qqq|芭将军*2058*临时npc*%s*%s/芭将军#W的考验。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",111,103,196,120)}
	elseif 进度==16 then
		说明={self.任务标题,format("接受#R/qqq|崩将军*2058*临时npc*%s*%s/崩将军#W的封赏。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",61,94,196,120)}
	elseif 进度==17 then
		说明={self.任务标题,format("感应#R/qqq|瀑布*2058*临时npc*%s*%s/瀑布#W。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",46,93,196,120)}
	elseif 进度==18 then
		local hgfd=""
		if 任务数据[fbrwid].异象之境 then
			for i=1,#任务数据[fbrwid].异象之境 do
				hgfd=hgfd..format("#R/qqq|%s*2059*临时npc*%s*%s/%s#W、",任务数据[fbrwid].异象之境[i].名称,任务数据[fbrwid].异象之境[i].x,任务数据[fbrwid].异象之境[i].y,任务数据[fbrwid].异象之境[i].名称)
			end
		end
		说明={self.任务标题,format("探索%s#W。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟",hgfd,196,120)}
	elseif 进度==19 then
		说明={self.任务标题,format("探查#R/qqq|失衡的水行灵*2059*临时npc*%s*%s/失衡的水行灵#W。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",65,120,196,120)}
	elseif 进度==20 then
		说明={self.任务标题,format("#R/qqq|猴长老*2058*临时npc*%s*%s/猴长老#W有话对你说。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",38,18,196,120)}
	elseif 进度==21 then
		说明={self.任务标题,format("#R/qqq|神秘长者*2058*临时npc*%s*%s/神秘长者#W有话对你说。（通过长安#R/qqq|副本官员*1001*临时npc*%s*%s/副本官员#W可进入副本场景）。剩余时间"..取分(任务数据[fbrwid].结束-(os.time()-任务数据[fbrwid].起始)).."分钟。",9,77,196,120)}








	end
	return 说明
end

return 灵猴出世