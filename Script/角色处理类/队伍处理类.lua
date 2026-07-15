-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2024-01-12 19:28:11
-- @Last Modified time  : 2024-01-14 17:12:24

-- @Author: baidwwy
-- @Date:   2023-12-01 23:00:25
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-06-05 13:33:10
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-05-27 19:20:45
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 队伍处理类 = class()

function 队伍处理类:初始化()end
function 队伍处理类:数据处理(连接id,序号,id,内容)
  if 玩家数据[id].摊位数据~=nil or 玩家数据[id].坐牢中 or 玩家数据[id].已扣除勾魂索 then
  	常规提示(id,"当前状态禁止此类操作")
  	return
  end
  if 收购数据[id]~=nil or 玩家数据[id].坐牢中 or 玩家数据[id].已扣除勾魂索 then
  	常规提示(id,"当前状态禁止此类操作")
  	return
  end
	if 玩家数据[id].角色.体验状态 then
		常规提示(id,"体验状态下无法进行此操作。")
		return
	end
  if 序号==4001 then
		if 玩家数据[id].队伍==0 then
		  发送数据(连接id,4001)
		else
		  self:索取队伍信息(id,4002)
		end
 elseif 序号==4001.1 then--##
	self:索取队伍信息(id,4004.1)

  elseif 序号==4002 then --创建、加入队伍
  	-- table.print(内容)
		self:创建队伍(id,内容)
  elseif 序号==4003 then
		if 玩家数据[id].队长 then
			self:索取申请信息(连接id,id)
		else
			常规提示(id,"只有队长才可进行此操作")
		end
  elseif 序号==4004 then --同意加入队伍
		if 玩家数据[id].队长 then
		  self:同意入队(id,内容)
		else
		  常规提示(id,"只有队长才可进行此操作")
		end
	elseif 序号==4004.1 then
    if 玩家数据[id].队长 then
      self:快速入队(id,内容)
    else
      常规提示(id,"只有队长才可进行此操作")
    end
  elseif 序号==4005 and 玩家数据[id].队长 then --删除申请列表
		--self:创建队伍(id,内容)
		if 玩家数据[队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id]~=nil then
		  常规提示(队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id,取名称(id).."拒绝了你的入队申请")
		end
		table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
		发送数据(玩家数据[id].连接id,4011,队伍数据[玩家数据[id].队伍].申请数据)
  elseif 序号==4006 then --同意加入队伍
		self:退出队伍(id)
  elseif 序号==4007  then
		if 玩家数据[id].队长 then
		  	local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
		  	if id==临时id then
				常规提示(id,"您不能将自己请离队伍")
				return
		  	else
				常规提示(临时id,"你被队长请离了队伍")
				self:退出队伍(临时id)
		 	 end
		else
			常规提示(id,"只有队长才可进行此操作")
		end
  elseif 序号==4008  then
		if 玩家数据[id].队长 then
		  发送数据(连接id,4013,玩家数据[id].角色.阵法)
		else
		  常规提示(id,"只有队长才可进行此操作")
		end
  elseif 序号==4009 then
		if 玩家数据[id].队长==false then
		  常规提示(id,"只有队长才可进行此操作")
		  return
		elseif 玩家数据[id].角色.阵法[内容.名称]==nil then
		  常规提示(id,"您尚未学会如何使用该阵法")
		  return
		else
		  local 队伍id=玩家数据[id].队伍
		  队伍数据[队伍id].阵型=内容.名称
		  for n=1,#队伍数据[队伍id].成员数据 do
			self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
		  end
		  常规提示(id,"更改阵型成功！")
		end
  elseif 序号==4010  then
		if 玩家数据[id].队长 then
		  	local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
		  	if id == 临时id then
					常规提示(id,"您不能将自己提升为队长")
					return
				elseif 玩家数据[临时id] == nil then
					return
		  	else
		  		if 玩家数据[临时id] and 玩家数据[临时id].助战 and 玩家数据[临时id].连接id==0 then
		  			if 玩家数据[临时id].账号 ~= 玩家数据[id].账号 then
		  				常规提示(id,"这不是你的助战，你无法直接提升他为队长！")
		  				return
		  			end
		  			self:更换队长(id,内容.序列)
		  		else
		  			for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
					  	if 玩家数据[队伍数据[玩家数据[id].队伍].成员数据[n]]~=nil then
								if 玩家数据[队伍数据[玩家数据[id].队伍].成员数据[n]].助战 then
									常规提示(id,"队伍内有助战参加战斗，你无法提升他为队长！")
		  						return
								end
							end
						end
						队伍数据[玩家数据[id].队伍].新队长.开关=true
						队伍数据[玩家数据[id].队伍].新队长.id=临时id
						self.发送数据={}
						self.发送数据.模型=玩家数据[id].角色.模型
						self.发送数据.名称=玩家数据[id].角色.名称
						self.发送数据.对话=玩家数据[id].角色.名称.."要把你提升为队长,你是否答应期要求?#94"
						self.发送数据.选项={"我同意当队长","我果断拒绝！"}
						发送数据(玩家数据[临时id].连接id,1501,self.发送数据)
					end
		  	end
		else
		  	常规提示(id,"只有队长才可进行此操作")
		end
  elseif 序号==4011  then
		local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
		if id==临时id then
			常规提示(id,"您不能查看自己!")
			return
		else
			local 查找数据=self:查找角色("",临时id)
			if 查找数据~=nil then
				发送数据(玩家数据[id].连接id,4015,查找数据)
				return
			else
				常规提示(id,"#Y这个角色并不存在或当前没有在线")
			end
		end
  elseif 序号==4012 then --同意加入队伍
		if 玩家数据[id].队长 then
	  		if 内容.序列==nil or #内容.序列~=2 then
				常规提示(id,"错误数据!")
				return
	  		elseif 内容.序列[1]+0>内容.序列[2]+0 then
				常规提示(id,"最低等级不能比最高等级低噢!")
				return
	 		end
	 		if 内容.序列[2]+0>175 then
				内容.序列[2]=175
	  		end
	  		队伍数据[玩家数据[id].队伍].限制等级[1]=内容.序列[1]+0
	  		队伍数据[玩家数据[id].队伍].限制等级[2]=内容.序列[2]+0
	  		常规提示(id,"设置成功!")
		else
	  		常规提示(id,"只有队长才可进行此操作")
		end
	elseif 序号==4013 then
		if 玩家数据[id].队长 then
			self:调换位置(id,内容)
		else
	  		常规提示(id,"只有队长才可进行此操作")
		end
	elseif 序号==4014 then --对方没队伍的情况
		local 对方id = 内容.id+0
		if 玩家数据[id].队伍==0 then
		    队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
			玩家数据[id].队长=true
			玩家数据[id].队伍=id
			self:索取队伍信息(id,4004)
			发送数据(玩家数据[id].连接id,4006)
			地图处理类:更改队伍图标(id,true)
			常规提示(id,"组队成功，你现在是队长了。")
			常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
			发送数据(玩家数据[对方id].连接id,4018,{队长id=id,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
		else
			if not 队伍数据[id] then
			    return
			end
			if 玩家数据[对方id].队伍~=0 then--自己和对方都有队伍
				常规提示(id,"对方已经有了一个队伍了")
			    return
			end
			for n=1,#队伍数据[id].成员数据 do
				if 队伍数据[id].成员数据[n]==对方id then
					return
				end
			end
			常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
			发送数据(玩家数据[对方id].连接id,4018,{队长id=玩家数据[id].队伍,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
		end
	elseif 序号==4015 then --直接进组
		if 内容.队伍id == nil then return end
		local 队伍id = 内容.队伍id+0
		local 邀请id = 内容.邀请id+0
		if 玩家数据[id].队伍~=0 then
			常规提示(id,"#Y/你已经有了一个队伍了")
			return
		end
		if 玩家数据[队伍id] then
			if 玩家数据[队伍id].队伍~=0 then
				for n=1,#队伍数据[队伍id].成员数据 do
					if 队伍数据[队伍id].成员数据[n]==id then
						return
					end
				end
				if 玩家数据[队伍id].zhandou~=0 then
					常规提示(id,"#Y/对方正在战斗中")
					return
				elseif 玩家数据[队伍id].摊位数据~=nil then
					常规提示(id,"#Y/对方目前无法加入队伍")
					return
				elseif 收购数据[队伍id]~=nil then
					常规提示(id,"#Y/对方目前无法加入队伍")
					return
				end
				local 角色xy={x=x,y=y}
				local 对方xy={x=0,y=0}
				对方xy.x,对方xy.y=玩家数据[队伍id].角色.地图数据.x,玩家数据[队伍id].角色.地图数据.y
				角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y
				if 取两点距离(对方xy,角色xy)>=500 then
					常规提示(id,"对方离你太远了~")
					return
				elseif #队伍数据[队伍id].成员数据>=5 then
					常规提示(id,"队伍人数已满！")
					return
				end
				发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
				发送数据(玩家数据[id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20)})
				local 地图编号=玩家数据[id].角色.地图数据.编号
				for i, v in pairs(地图处理类.地图玩家[地图编号]) do
					if i~=id and 玩家数据[i] then
						发送数据(玩家数据[i].连接id,1008,{数字id=id,路径={数字id=id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20)}})
					end
				end
				队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=id
				玩家数据[id].队伍=队伍id
				-- 地图处理类:刷新玩家队伍(id,队伍id) --刷新的队伍，好进行选取
				玩家数据[id].队长=false
				if 玩家数据[邀请id] and 玩家数据[邀请id].队伍==队伍id then
				    常规提示(邀请id,"#R"..玩家数据[id].角色.名称.."#Y同意了你的邀请")
				end
				for n=1,#队伍数据[队伍id].成员数据 do
					self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
				end
				self:同步飞行坐骑(队伍id,id)
				常规提示(id,"你已经被同意加入队伍")
			else
				常规提示(id,"该队伍已经解散了")
			end
		end
	elseif 序号==4016 then--"凌云渡
    self:索取可用信息(连接id,id)
  elseif 序号==4017 then
    self:加入助战(id,内容)
  elseif 序号==4017.1 then
    	内容={}
    	内容.id=id+0
    	self:创建队伍(id,内容)
  		临时文件=table.loadstring(读入文件([[data/]]..玩家数据[id].账号..[[/信息.txt]]))
	  	for k,v in pairs(临时文件) do
	        v=tonumber(v)
	        if v~=id and k<=5 then
	        	self:一键加入助战(id,v)
	        end
	    end

  end
end

function 队伍处理类:更换队长(id,序列)
	local 队伍id=玩家数据[id].队伍
	if 玩家数据[id].队长==false then
		常规提示(id,"#Y/你不是队长，无法使用此功能")
		return
	elseif 序列==1 then
		常规提示(id,"#Y/您不能将自己提升为队长")
		return
	elseif 队伍数据[队伍id] == nil then
		常规提示(id,"#Y/没有这样的队伍！")
		return
	end
 	-- ================ 新增：阵营一致 ================
	local 新队长id = 队伍数据[队伍id].成员数据[序列]
	local 当前队长阵营 = nil
	local 新队长阵营 = nil
	if 玩家数据[id] and 玩家数据[id].双龙之战 and 玩家数据[id].双龙之战.数据 then
		当前队长阵营 = 玩家数据[id].双龙之战.数据.阵营
	end
	if 玩家数据[新队长id] and 玩家数据[新队长id].双龙之战 and 玩家数据[新队长id].双龙之战.数据 then
		新队长阵营 = 玩家数据[新队长id].双龙之战.数据.阵营
	end
	if 当前队长阵营 and 新队长阵营 and 当前队长阵营 ~= 新队长阵营 and (玩家数据[新队长id].角色.地图数据.编号==1573 or 玩家数据[新队长id].角色.地图数据.编号==1574) then
		常规提示(id,"#Y/你与"..(玩家数据[新队长id].角色 and 玩家数据[新队长id].角色.名称 or 新队长id).."阵营不同，无法更换队长！")
		return
	end

	-- ===============================================================

	local 队伍id=玩家数据[id].队伍

	序列=队伍数据[队伍id].成员数据[序列]
	local 队员id={[1]=序列}
	for n=1,#队伍数据[队伍id].成员数据 do
		if 队伍数据[队伍id].成员数据[n]~=序列 then
			队员id[#队员id+1]=队伍数据[队伍id].成员数据[n]
		end
	end


	if 玩家数据[id].角色.阵法["天覆阵"]~=nil then
		队伍数据[序列]={成员数据={[1]=序列},申请数据={},阵型="天覆阵",限制等级={0,175},新队长={开关=false,id=0}}
		  常规提示(id,"已自动切换为#G/[天覆阵]！")
	else
		队伍数据[序列]={成员数据={[1]=序列},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
	end

	for n=2,#队员id do
		队伍数据[序列].成员数据[n]=队员id[n]
		玩家数据[队员id[n]].队伍=序列
	end
	玩家数据[序列].队长=true
	玩家数据[序列].队伍=序列
	玩家数据[id].队长=false

	if 玩家数据[id] and 玩家数据[id].双龙之战 then
		self:保存玩家双龙数据(id)
	end

	-- 保存新队长的双龙之战数据
	if 玩家数据[序列] and 玩家数据[序列].双龙之战 then
		self:保存玩家双龙数据(序列)
	end


	发送数据(玩家数据[序列].连接id,4006)
	发送数据(玩家数据[id].连接id,4008)
	地图处理类:更改队伍图标(id,false)
	地图处理类:更改队伍图标(序列,true)
	常规提示(id,"提升队长成功！")
	for n=1,#队伍数据[序列].成员数据 do
		self:索取队伍信息(队伍数据[序列].成员数据[n],4004)
	end
	队伍数据[id]=nil
	常规提示(序列,"#Y你已经被任命为新的队长")
	if 玩家数据[序列].助战 then--"凌云渡
		self:切换主角(序列,id)
		发送数据(玩家数据[序列].连接id,996,{数字id=序列})
		发送数据(玩家数据[序列].连接id,10997,{数字id=序列})
	end
end

function 队伍处理类:保存玩家双龙数据(玩家id)
	if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
		return false
	end
	local 角色 = 玩家数据[玩家id].角色
	if not 角色.账号 or not 角色.数字id then
		return false
	end
	local 双龙数据 = 玩家数据[玩家id].双龙之战
	if not 双龙数据 or not 双龙数据.数据 then
		return false
	end
	local 文件路径 = "data/" .. 角色.账号 .. "/" .. 角色.数字id .. "/双龙之战.txt"
	local 目录路径 = "data/" .. 角色.账号 .. "/" .. 角色.数字id
	if not os.execute("mkdir \"" .. 目录路径 .. "\" 2>nul") then
	end
	local 成功, 错误信息 = pcall(function()
		写出文件(文件路径, table.tostring(双龙数据.数据))
	end)
	if not 成功 then
		print("保存双龙之战数据失败 (玩家ID:" .. 玩家id .. "): " .. tostring(错误信息))
		return false
	end
	return true
end


function 队伍处理类:发起助战组队邀请(id,对方id,助战编号)
	if 玩家数据[id].队伍==0 then
		队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
		玩家数据[id].队长=true
		玩家数据[id].队伍=id
		self:索取队伍信息(id,4004)
		发送数据(玩家数据[id].连接id,4006)
		地图处理类:更改队伍图标(id,true)
		常规提示(id,"组队成功，你现在是队长了。")
		常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
		发送数据(玩家数据[对方id].连接id,4018,{队长id=id,助战编号=助战编号,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
	else
		if not 队伍数据[id] or 玩家数据[id].队伍~=id then
			常规提示(id,"只有队长才能进行此操作！")
			return
		end
		if 玩家数据[对方id].队伍~=0 then--自己和对方都有队伍
			常规提示(id,"对方已经有了一个队伍了")
			return
		end
		for n=1,#队伍数据[id].成员数据 do
			if 队伍数据[id].成员数据[n]==对方id then
				return
			end
		end
		常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
		发送数据(玩家数据[对方id].连接id,4018,{队长id=玩家数据[id].队伍,助战编号=助战编号,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
	end
end

function 队伍处理类:助战进组(主号id,助战id)
	if 玩家数据[主号id].队伍==0 then
		队伍数据[主号id]={成员数据={[1]=主号id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}

		玩家数据[主号id].队长=true
		玩家数据[主号id].队伍=主号id
		self:索取队伍信息(主号id,4004)
		发送数据(玩家数据[主号id].连接id,4006)
		地图处理类:更改队伍图标(主号id,true)
		常规提示(主号id,"组队成功,你现在是队长了。")
	elseif not 玩家数据[主号id].队长 then
		常规提示(主号id,"#Y/只有队长才以这种方式邀请小号进队！")
		return
	end
	local 队伍id = 玩家数据[主号id].队伍
	if #队伍数据[队伍id].成员数据>=5 then
		常规提示(主号id,"队伍人数已满！")
		return
	end
	队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=助战id
	玩家数据[助战id].队伍=队伍id
	常规提示(主号id,"#G"..玩家数据[助战id].角色.名称.."#Y加入了队伍")
	广播队伍消息(队伍id,玩家数据[助战id].角色.名称.."加入了队伍")
	for n=1,#队伍数据[主号id].成员数据 do
		local dyid=队伍数据[主号id].成员数据[n]
		if not 玩家数据[dyid].zhuzhan then
			self:索取队伍信息(dyid,4004)
		end
	end
	self:同步飞行坐骑(队伍id,主号id)
end

function 队伍处理类:调换位置(id,内容)
	if 队伍数据[玩家数据[id].队伍].成员数据 then
		if 队伍数据[玩家数据[id].队伍].成员数据[内容.序列] and 队伍数据[玩家数据[id].队伍].成员数据[内容.序列2] then
			local 临时数据 = 队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
			local 临时数据2 = 队伍数据[玩家数据[id].队伍].成员数据[内容.序列2]
			队伍数据[玩家数据[id].队伍].成员数据[内容.序列] = 临时数据2
			队伍数据[玩家数据[id].队伍].成员数据[内容.序列2] = 临时数据
			for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			  	self:索取队伍信息(队伍数据[玩家数据[id].队伍].成员数据[n],4004)
			end
		end
	end
end

function 队伍处理类:查找角色(名称,id)
  	local 数据组={}
	if id~="" then id=id+0 end
		for i, v in pairs(玩家数据) do
			if 玩家数据[i].角色.名称==名称 or i==id then
			  	数据组.名称=玩家数据[i].角色.名称
			  	数据组.等级=玩家数据[i].角色.等级
			  	数据组.门派=玩家数据[i].角色.门派
			  	数据组.称谓=玩家数据[i].角色.当前称谓
			  	数据组.模型=玩家数据[i].角色.模型
			  	数据组.帮派=玩家数据[i].角色.BPMC
			end
		end
	return 数据组
end

function 队伍处理类:退出队伍(id,重组)
	if 玩家数据[id] and 玩家数据[id].zhandou~=0 and not 调试模式 then
		return
	end
	local 队伍id=	玩家数据[id].队伍
	if 队伍id==0 or 队伍数据[队伍id]==nil then
		玩家数据[id].队伍=0
		return
	end
  	if 玩家数据[id].队长 then
			if 重组==nil or (重组~=nil and 重组~="关闭") then
			  	广播队伍消息(队伍id,"本队伍已经被队长解散")
			end
			for n=1,#队伍数据[队伍id].成员数据 do
		  	if 玩家数据[队伍数据[队伍id].成员数据[n]]~=nil then
					玩家数据[队伍数据[队伍id].成员数据[n]].队伍=0
					发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,4012)
					if 玩家数据[队伍数据[队伍id].成员数据[n]].助战 and 玩家数据[队伍数据[队伍id].成员数据[n]].连接id == 0 then
					  系统处理类:断开游戏(队伍数据[队伍id].成员数据[n])
					end
		  	end
			end
			玩家数据[id].队长=false
			地图处理类:更改队伍图标(id,false)
			发送数据(玩家数据[id].连接id,4008)
			助战处理类:所有助战下线(id)
			队伍数据[id]=nil

  	else
			local 队员序列=0
			for n=1,#队伍数据[队伍id].成员数据 do
				if id==队伍数据[队伍id].成员数据[n] then
					队员序列=n
				end
			end
			广播队伍消息(队伍id,取名称(id).."离开了队伍")
			table.remove(队伍数据[玩家数据[id].队伍].成员数据,队员序列)
			玩家数据[id].队伍=0
			发送数据(玩家数据[id].连接id,4012)
			if 玩家数据[id].zhuzhan then
			助战处理类:单个助战下线(id)
			else
				发送数据(玩家数据[id].连接id,4012)
			end

			for n=1,#队伍数据[队伍id].成员数据 do
			  	self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
			end
			if 玩家数据[id].助战 and 玩家数据[id].连接id == 0 then
			  系统处理类:断开游戏(id)
			end
  	end
end

function 队伍处理类:同意入队(id,内容,重组)
	if not 队伍数据[玩家数据[id].队伍].申请数据[内容.序列] then
		return
	end
	local 对方id=队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id
	local 是否清除=false
	local 队伍id=	玩家数据[id].队伍
	local 副本类型 = 取副本类型(玩家数据[id].角色.地图数据.编号)
	if 玩家数据[对方id]==nil then
		常规提示(id,"#Y/这个玩家当前不在线")
		是否清除=true
	elseif 玩家数据[对方id].队伍~=0 then
		常规提示(id,"#Y/对方已经加入了其它队伍")
		是否清除=true
	elseif 玩家数据[对方id].zhandou~=0 then
		常规提示(id,"#Y/对方正在战斗中")
		return
	elseif 玩家数据[对方id].摊位数据~=nil then
		常规提示(id,"#Y/对方目前无法加入队伍")
		是否清除=true
	elseif 收购数据[对方id]~=nil then
		常规提示(id,"#Y/对方目前无法加入队伍")
		是否清除=true
	elseif 玩家数据[对方id].角色:取任务(300)~=0 then
		添加最后对话(id,"对方正在押镖无法加入队伍")
		return
	elseif 玩家数据[对方id].角色.地图数据.编号 >= 3000 and 玩家数据[对方id].角色.地图数据.编号 <= 3150 then
		常规提示(id,"#Y/对方目前正在雁塔地宫中，无法加入队伍")
    return
  elseif 玩家数据[对方id].角色.地图数据.编号 >= 10002 and 玩家数据[对方id].角色.地图数据.编号 <= 10018 then
		常规提示(id,"#Y/对方目前正在彩虹争霸活动中，无法加入队伍")
    return
  elseif 副本类型 and 副本数据[副本类型] and 副本数据[副本类型].完成 and 副本数据[副本类型].完成[对方id] then
  	常规提示(id,"#Y/对方已经完成"..副本类型.."，无法加入队伍")
    return
  elseif 副本类型 and (副本数据[副本类型].进行[对方id] == nil or 副本数据[副本类型].进行[对方id].进程 ~= 副本数据[副本类型].进行[id].进程) then
  	常规提示(id,"#Y/对方并没有副本"..副本类型.."任务或进程不一致，无法加入队伍")
    return
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		if 队伍数据[队伍id].成员数据[n]==对方id then
			常规提示(id,"#Y/对方已经在队伍中了")
			是否清除=true
		end
	end
	if 是否清除 then
		table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
		发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
		return
	end
	local 角色xy={x=x,y=y}
	local 对方xy={x=0,y=0}
	对方xy.x,对方xy.y=玩家数据[对方id].角色.地图数据.x,玩家数据[对方id].角色.地图数据.y
	角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y
	if 取两点距离(对方xy,角色xy)>=500 then
		常规提示(id,"对方离你太远了~")
		return
	elseif #队伍数据[队伍id].成员数据>=5 then
		常规提示(id,"队伍人数已满！")
		return
	end
	table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
	发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
	发送数据(玩家数据[对方id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),})
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for i, v in pairs(地图处理类.地图玩家[地图编号]) do
		if i~=对方id and 玩家数据[i] then
			发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
		end
	end
	队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
	玩家数据[对方id].队伍=队伍id
	-- 地图处理类:刷新玩家队伍(对方id,队伍id) --刷新的队伍，好进行选取
	玩家数据[对方id].队长=false
	if 重组==nil or (重组~=nil and 重组~="关闭") then
		广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
	end
	常规提示(id,"你已经被同意加入队伍")
	self:同步飞行坐骑(队伍id,id)
end

function 队伍处理类:快速入队(id,内容,重组)
  local 对方id=内容.目标id
  local 是否清除=false
  local 队伍id= 玩家数据[id].队伍
  local 副本类型 = 取副本类型(玩家数据[id].角色.地图数据.编号)
  if 队伍数据[队伍id] == nil then
    常规提示(id,"#Y/你还没有创建队伍")
     return
  elseif 玩家数据[对方id]==nil then
    常规提示(id,"#Y/这个玩家当前不在线")
    return
  elseif 玩家数据[对方id].队伍~=0 then
    常规提示(id,"#Y/对方已经加入了其它队伍")
    return
  elseif 玩家数据[对方id].zhandou~=0 then
    常规提示(id,"#Y/对方正在战斗中")
    return
  elseif 玩家数据[对方id].摊位数据~=nil then
    常规提示(id,"#Y/对方目前无法加入队伍")
    return
  elseif 玩家数据[对方id].角色:取任务(300)~=0 then
		添加最后对话(id,"对方正在押镖无法加入队伍")
		return
	elseif 玩家数据[对方id].角色.地图数据.编号 >= 3000 and 玩家数据[对方id].角色.地图数据.编号 <= 3150 then
		常规提示(id,"#Y/对方目前正在雁塔地宫中，无法加入队伍")
    return
  elseif 玩家数据[对方id].角色.地图数据.编号 >= 10002 and 玩家数据[对方id].角色.地图数据.编号 <= 10018 then
		常规提示(id,"#Y/对方目前正在彩虹争霸活动中，无法加入队伍")
    return
  elseif 副本类型 and 副本数据[副本类型].完成 and 副本数据[副本类型].完成[对方id] then
  	常规提示(id,"#Y/对方已经完成"..副本类型.."，无法加入队伍")
    return
  elseif 副本类型 and (副本数据[副本类型].进行[对方id] == nil or 副本数据[副本类型].进行[对方id].进程 ~= 副本数据[副本类型].进行[id].进程) then
  	常规提示(id,"#Y/对方并没有副本"..副本类型.."任务或进程不一致，无法加入队伍")
    return
  end
  for n=1,#队伍数据[队伍id].成员数据 do
    if 队伍数据[队伍id].成员数据[n]==对方id then
      常规提示(id,"#Y/对方已经在队伍中了")
      return
    end
  end
  if #队伍数据[队伍id].成员数据>=5 then
    常规提示(id,"队伍人数已满！")
    return
  end
  local 地图=玩家数据[id].角色.地图数据.编号
  if 玩家数据[id].账号 ~= 玩家数据[对方id].账号 then
    return
  end
  if 玩家数据[对方id].角色.地图数据.编号 ~= 玩家数据[id].角色.地图数据.编号 then
    地图处理类:跳转地图(对方id,地图,玩家数据[id].角色.地图数据.x/20,玩家数据[id].角色.地图数据.y/20)
  end


  local 角色xy={x=0,y=0}
  local 对方xy={x=0,y=0}
  对方xy.x,对方xy.y=玩家数据[对方id].角色.地图数据.x,玩家数据[对方id].角色.地图数据.y
  角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y
  if 取两点距离(对方xy,角色xy)>=500 then
    地图处理类:跳转地图(对方id,地图,玩家数据[id].角色.地图数据.x/20,玩家数据[id].角色.地图数据.y/20)
  end
  发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
  发送数据(玩家数据[对方id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),})
  local 地图编号=玩家数据[id].角色.地图数据.编号
  for i, v in pairs(地图处理类.地图玩家[地图编号]) do
    if i~=对方id and 玩家数据[i] then
      发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
    end
  end
  队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
  玩家数据[对方id].队伍=队伍id
  玩家数据[对方id].队长=false
  if 重组==nil or (重组~=nil and 重组~="关闭") then
    广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
  end
  for n=1,#队伍数据[队伍id].成员数据 do
    self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
  end
end


function 队伍处理类:同步飞行坐骑(队伍id,id)
	local 同步队长=玩家数据[队伍id].角色.飞行中
	local 是否有坐骑 = true
	for i=1,#队伍数据[队伍id].成员数据 do
    	if 同步队长 and 玩家数据[队伍数据[队伍id].成员数据[i]].角色.坐骑==nil then --队员没坐骑的情况
    		是否有坐骑=false
    		break
    	end
	end
	if 同步队长 then --队长是否飞行的情况
	    if 是否有坐骑==false then --但是某队友没坐骑
	        for i=1,#队伍数据[队伍id].成员数据 do
	        	if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
			    	玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
			    end
			    地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],false)
	        end
	    else
	    	for i=1,#队伍数据[队伍id].成员数据 do
	    		if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中==nil then
			    	玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=true
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你飞了起来...")
			    end
			    地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],true)
	    	end
	    end
	else --队长没飞的情况
		for i=1,#队伍数据[队伍id].成员数据 do
			if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
		    	玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
				常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
		    end
		    地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],false)
		end
	end

end


function 队伍处理类:取队伍飞行(队伍id,id)
	-- local 通过=false
	if 队伍数据[队伍id]==nil then
		return
	end
	--下面如果检测到队友没有飞行坐骑的时候,且队伍在飞行中,应该取消飞行状态
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.坐骑==nil then
			常规提示(id,"#Y起飞失败，队伍中#R"..玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称.."#Y没有骑乘坐骑...")
			return
		end
	end
	-- if 通过 and 取飞行坐骑限制(id) then
	local 队长飞行=玩家数据[id].角色.飞行中
	if 取飞行坐骑限制(id) then
		for i=1,#队伍数据[队伍id].成员数据 do
			if 队长飞行 then --队长飞行的时候降落
			    if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
			    	玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
			    end
			else --队长没飞的时候起飞
				玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=true
				常规提示(队伍数据[队伍id].成员数据[i],"#Y/你飞了起来...")
			end

			地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中)
		end
	end
end

function 队伍处理类:索取申请信息(连接id,id)
	if 玩家数据[id].队长~=true then
		常规提示(id,"只有队长才可以查看申请列表哟~")
		return 0
	else
		local 队伍id=玩家数据[id].队伍
		发送数据(玩家数据[id].连接id,4010,队伍数据[队伍id].申请数据)
	end
end

function 队伍处理类:新任队长(原来id,玩家id)
	if 玩家数据[原来id].队长==false then
		常规提示(原来id,"#Y/你不是队长，无法使用此功能")
		return
	elseif 原来id == 玩家id then
		常规提示(原来id,"#Y/您不能将自己提升为队长")
		return
	elseif 玩家数据[玩家id].助战 then
	  常规提示(原来id,"#Y/您不能将助战提升为队长")
		return
	end
  local xl临时队伍成员id = {}
  for n=1,#队伍数据[原来id].成员数据 do
		if 队伍数据[原来id].成员数据[n]~=nil then
		  if 原来id == 队伍数据[原来id].成员数据[n] then
				xl临时队伍成员id[n] = 玩家id
		  elseif 玩家id == 队伍数据[原来id].成员数据[n] then
				xl临时队伍成员id[n] = 原来id
		  else
				xl临时队伍成员id[n] = 队伍数据[原来id].成员数据[n]
		  end
		end
  end
  self:退出队伍(原来id,"关闭")--清除原来队伍
  玩家数据[原来id].队长=false
  玩家数据[原来id].队伍=0
  地图处理类:更改队伍图标(原来id,false)
  --==========
  local x内容 = {id=玩家id}--创建队伍
  self:创建队伍(玩家id,x内容,"关闭")
  for i=1,#xl临时队伍成员id do
		if xl临时队伍成员id[i]~=玩家id then
		  x内容 = {id=玩家id}--原队人申请队伍
		  self:创建队伍(xl临时队伍成员id[i],x内容,"关闭")
		  --==============
		  x内容 = {序列=1}--同意进队
		  self:同意入队(玩家id,x内容,"关闭")
		end
  end
  if 玩家数据[玩家id].助战 then--"凌云渡
    self:切换主角(玩家id,id)
    发送数据(玩家数据[玩家id].连接id,10997,{数字id=玩家id})
  end
  xl临时队伍成员id = {}
end

function 队伍处理类:创建队伍(id,内容,重组)
	if 内容.id == nil then return end
	local 创建id=内容.id+0
	if id==创建id then -- 自己创建队伍
		if 玩家数据[id].角色:取任务(300)~=0 then
			常规提示(id,"正在押镖无法组队")
			return
		end
		if 玩家数据[id].队伍==0 then
			队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
			玩家数据[id].队长=true
			玩家数据[id].队伍=id
			self:索取队伍信息(id,4004)
			发送数据(玩家数据[id].连接id,4006)
			地图处理类:更改队伍图标(id,true)
			if 重组==nil or (重组~=nil and 重组~="关闭") then
				常规提示(id,"组队成功,你现在是队长了。")
			end
		else
			常规提示(id,"你已经有一个队伍了")
			return 0
		end
	else
		if 玩家数据[创建id].队伍==0 or 队伍数据[玩家数据[创建id].队伍] == nil then
			常规提示(id,"对方不在队伍中！")
			return 0
		else
			local 申请id= 玩家数据[创建id].队伍
			if (队伍数据[申请id].限制等级[1] and 玩家数据[id].角色.等级<队伍数据[申请id].限制等级[1]) or (队伍数据[申请id].限制等级[2] and 玩家数据[id].角色.等级>队伍数据[申请id].限制等级[2]) then
				常规提示(id,"你的等级不满对方的要求！")
				return 0
			elseif 玩家数据[id].角色:取任务(300)~=0 then
				常规提示(id,"正在押镖无法组队")
				return
			end
			if #队伍数据[申请id].成员数据>=5 then
				常规提示(id,"对方队伍已满员！")
				return 0
			elseif #队伍数据[申请id].申请数据>=5 then
				常规提示(id,"对方申请名单已经满了~请过一会儿再试")
				return 0
			else
				--self.重复申请=false
				for n=1,#队伍数据[申请id].申请数据 do
					if 队伍数据[申请id].申请数据[n]~=nil and 队伍数据[申请id].申请数据[n].id~=nil and 队伍数据[申请id].申请数据[n].id ==id   then
						常规提示(id,"你已经在对方的申请名单中了，请勿重复申请")
						return 0
					end
				end
				local 申请位置s = #队伍数据[申请id].申请数据+1
				队伍数据[申请id].申请数据[申请位置s]=table.loadstring(table.tostring(玩家数据[id].角色:取队伍信息(id)))
				队伍数据[申请id].申请数据[申请位置s].id =id
				if 重组==nil or (重组~=nil and 重组~="关闭") then
					常规提示(id,"入队申请提交成功，请耐心等候~")
					常规提示(申请id,玩家数据[id].角色.名称.."申请加入你的队伍，请尽快处理！")
				end
				发送数据(玩家数据[申请id].连接id,4011,队伍数据[申请id].申请数据)
			end
		end
	end
end

function 队伍处理类:索取队伍信息(id,序号)
	if not 玩家数据[id] then
	    return
	end
	local 队伍id=玩家数据[id].队伍
	local 发送信息={}
	if 队伍数据[队伍id]== nil then return  end
	-- for n=1,#队伍数据[队伍id].成员数据 do
	-- 	if 队伍数据[队伍id].成员数据[n] and 玩家数据[队伍数据[队伍id].成员数据[n]] then
	-- 		发送信息[#发送信息+1]=玩家数据[队伍数据[队伍id].成员数据[n]].角色:取队伍信息()
	-- 	end
	-- end

	for n=1,#队伍数据[队伍id].成员数据 do
		local cyid=队伍数据[队伍id].成员数据[n]
		if  玩家数据[cyid] then
			发送信息[#发送信息+1]=玩家数据[cyid].角色:取队伍信息()
		end
	end

	发送信息.阵型=队伍数据[队伍id].阵型
	发送信息.限制等级=队伍数据[队伍id].限制等级
	发送数据(玩家数据[id].连接id,序号,发送信息)
end
function 队伍处理类:取队伍成员(id)
	local 队伍id=玩家数据[id].队伍
	local 发送信息={}
	if 队伍数据[队伍id]== nil then return false  end
	for n=1,#队伍数据[队伍id].成员数据 do
		发送信息[队伍数据[队伍id].成员数据[n]]=true
	end
	return 发送信息
end

function 队伍处理类:扣除队伍成员银子(id,数额)
	local 队伍id=玩家数据[id].队伍
	if 队伍数据[队伍id]== nil then return false  end
	local 允许执行 = true
	for n=1,#队伍数据[队伍id].成员数据 do
		local 数字id = 队伍数据[队伍id].成员数据[n]
		if 玩家数据[数字id].角色.银子 <  数额 then
			允许执行= false
		end
	end
	if 允许执行 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local 数字id = 队伍数据[队伍id].成员数据[n]
			玩家数据[数字id].角色:扣除银子(数额, 0, 0, "五级镖银")
		end
	end
	return  允许执行
end

function 队伍处理类:扣除队伍成员道具(id,名称,数量)
	local 队伍id=玩家数据[id].队伍
	if 队伍数据[队伍id]== nil then return false  end
	local 允许执行 = true
	for n=1,#队伍数据[队伍id].成员数据 do
		local 数字id = 队伍数据[队伍id].成员数据[n]
		if not 玩家数据[数字id].道具:判定背包道具(数字id,名称,数量) then
			允许执行= false
		end
	end
	if 允许执行 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local 数字id = 队伍数据[队伍id].成员数据[n]
			玩家数据[数字id].道具:消耗背包道具(玩家数据[数字id].连接id,数字id,名称,数量)
		end
	end
	return  允许执行
end

function 队伍处理类:删除队伍成员道具(id,名称)
	local 队伍id=玩家数据[id].队伍
	if 队伍数据[队伍id]== nil then return false  end
	local 允许执行 = true
	for n=1,#队伍数据[队伍id].成员数据 do
		local 数字id = 队伍数据[队伍id].成员数据[n]
		if not 玩家数据[数字id].道具:判定背包道具(数字id,名称,数量) then
			允许执行= false
		end
	end
	if 允许执行 then

	end
	return  允许执行
end

function 队伍处理类:索取可用信息(连接id,id,序号)
  local 队伍id=玩家数据[id].队伍
  if 队伍数据[队伍id]== nil then 常规提示(id,"#Y/你没有这样的队伍") return end
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
    常规提示(id,"只有队长才可使用此项功能！")
    return
  end
  local 发送信息={}
  local 查询信息 = 取账号信息(玩家数据[id].角色.账号)
  local 写入信息 = 查询信息
  local a=0
  for n=1,#写入信息 do
    if tonumber(写入信息[n]) ~= id and 玩家数据[tonumber(写入信息[n])]==nil then
      a=a+1
      local 武器数据={名称="",等级=0,子类=0}
      local 锦衣 = {}
      local 还原数据 =table.loadstring(读入文件([[data/]]..玩家数据[id].角色.账号..[[/]]..tonumber(写入信息[n])..[[/角色.txt]]))
      发送信息[a]={
        名称=还原数据.名称,
        等级=还原数据.等级,
        染色方案=还原数据.染色方案,
        染色组=还原数据.染色组,
        模型=还原数据.模型,
        门派=还原数据.门派,
        id=还原数据.数字id,
        装备={},
        锦衣=还原数据.锦衣,
        坐骑=还原数据.坐骑,
      }
      if 还原数据.装备[3]~=nil then
        local 临时道具 = table.loadstring(读入文件([[data/]]..玩家数据[id].角色.账号..[[/]]..tonumber(写入信息[n])..[[/道具.txt]]))
        武器数据=临时道具[还原数据.装备[3]]
        if 武器数据 and 武器数据.总类 == 2 and 武器数据.子类 < 18 then--"凌云渡
          发送信息[a].装备=武器数据
        end
        if 还原数据.锦衣 ~= nil and 临时道具 then
					for i=1,#还原数据.锦衣 do
						锦衣[i] = 临时道具[还原数据.锦衣[i]]
					end
				end
				发送信息[a].锦衣 = 锦衣
      end
    end
  end
  发送数据(玩家数据[id].连接id,序号 or 4021,发送信息)
  还原数据=nil
  临时文件=nil
  写入信息=nil
  武器数据=nil
end

function 队伍处理类:检测账号(账号,数字id)
	local 临时数据 = {}
	local 查询信息 = 取账号信息(账号)
	if 查询信息 then
		临时数据 = 查询信息
	  for i=1,#临时数据 do
	    if 临时数据[i] == tonumber(数字id) then
	      return true
	    end
	  end
	end
  return false
end
function 队伍处理类:一键加入助战(id,内容)
  local 队伍id=玩家数据[id].队伍
  local 副本类型 = 取副本类型(玩家数据[id].角色.地图数据.编号)
  if 队伍数据[队伍id]== nil then 常规提示(id,"#Y/你没有这样的队伍") return end
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
    常规提示(id,"只有队长才可使用此项功能！")
    return
  end
  local 对方id = tonumber(内容)
  if not self:检测账号(玩家数据[id].账号,对方id) then
    return
  end
  if 玩家数据[对方id] then
    常规提示(id,"该角色已经在游戏中，请自行申请入队或下线后再进行此操作！")
    return
  elseif 玩家数据[id] and 玩家数据[id].角色 and 玩家数据[id].角色.地图数据.编号 >= 3000 and 玩家数据[id].角色.地图数据.编号 <= 3150 then
		常规提示(id,"#Y/目前正在雁塔地宫中，无法加入队伍")
    return
  elseif 玩家数据[id] and 玩家数据[id].角色 and 玩家数据[id].角色.地图数据.编号 >= 10002 and 玩家数据[id].角色.地图数据.编号 <= 10018 then
		常规提示(id,"#Y/目前正在彩虹争霸活动中，无法加入队伍")
    return
  elseif 副本类型 and 副本数据[副本类型] and 副本数据[副本类型].完成 and 副本数据[副本类型].完成[对方id] then
  	常规提示(id,"#Y/对方已经完成"..副本类型.."，无法加入队伍")
    return
  elseif 副本类型 and (副本数据[副本类型].进行[对方id] == nil or (副本数据[副本类型].进行[对方id] and 副本数据[副本类型].进行[对方id].进程 ~= 副本数据[副本类型].进行[id].进程)) then
  	常规提示(id,"#Y/对方并没有副本"..副本类型.."任务或进程不一致，无法加入队伍")
    return
  end
  if #队伍数据[队伍id].成员数据>=5 then
    常规提示(id,"队伍人数已满！")
    return
  end
  local 角色信息 =table.loadstring(读入文件([[data/]]..玩家数据[id].账号..[[/]]..对方id..[[/角色.txt]]))
 	for i,v in pairs(角色信息.任务) do
 		if 任务数据[v] and 任务数据[v].类型 == 300 then
 			常规提示(id,"对方身上有押镖任务无法直接加入！")
 			return
 		end
 	end

  self:加入助战玩家(玩家数据[id].账号,对方id,id)
  local 地图编号=玩家数据[id].角色.地图数据.编号
  local 角色xy={x=x,y=y}
  local 对方xy={x=0,y=0}
  对方xy.x,对方xy.y=玩家数据[对方id].角色.地图数据.x,玩家数据[对方id].角色.地图数据.y
  角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y
  for i, v in pairs(地图处理类.地图玩家[地图编号]) do
    if i~=对方id and 玩家数据[i] then
      发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
    end
  end

  	if 玩家数据[id].角色.阵法["天覆阵"]~=nil then
		队伍数据[队伍id].阵型="天覆阵"
		常规提示(id,"已自动切换为#G/[天覆阵]！")
	end

  队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
  玩家数据[对方id].队伍=队伍id
  玩家数据[对方id].队长=false
  广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
  for n=1,#队伍数据[队伍id].成员数据 do
    self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
  end
  self:索取可用信息(玩家数据[id].连接id,id,4022)
  self:同步飞行坐骑(队伍id,id)

end
function 队伍处理类:加入助战(id,内容)
  local 队伍id=玩家数据[id].队伍
  local 副本类型 = 取副本类型(玩家数据[id].角色.地图数据.编号)
  if 队伍数据[队伍id]== nil then 常规提示(id,"#Y/你没有这样的队伍") return end
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
    常规提示(id,"只有队长才可使用此项功能！")
    return
  end
  local 对方id = tonumber(内容.id)
  if not self:检测账号(玩家数据[id].账号,对方id) then
    return
  end

  if 玩家数据[对方id] then
    常规提示(id,"该角色已经在游戏中，请自行申请入队或下线后再进行此操作！")
    return
  elseif 玩家数据[id] and 玩家数据[id].角色 and 玩家数据[id].角色.地图数据.编号 >= 3000 and 玩家数据[id].角色.地图数据.编号 <= 3150 then
		常规提示(id,"#Y/目前正在雁塔地宫中，无法加入队伍")
    return
  elseif 玩家数据[id] and 玩家数据[id].角色 and 玩家数据[id].角色.地图数据.编号 >= 10002 and 玩家数据[id].角色.地图数据.编号 <= 10018 then
		常规提示(id,"#Y/目前正在彩虹争霸活动中，无法加入队伍")
    return
  elseif 副本类型 and 副本数据[副本类型] and 副本数据[副本类型].完成 and 副本数据[副本类型].完成[对方id] then
  	常规提示(id,"#Y/对方已经完成"..副本类型.."，无法加入队伍")
    return
  elseif 副本类型 and (副本数据[副本类型].进行[对方id] == nil or (副本数据[副本类型].进行[对方id] and 副本数据[副本类型].进行[对方id].进程 ~= 副本数据[副本类型].进行[id].进程)) then
  	常规提示(id,"#Y/对方并没有副本"..副本类型.."任务或进程不一致，无法加入队伍")
    return
  end

  if #队伍数据[队伍id].成员数据>=5 then
    常规提示(id,"队伍人数已满！")
    return
  end
  local 角色信息 =table.loadstring(读入文件([[data/]]..玩家数据[id].账号..[[/]]..对方id..[[/角色.txt]]))
 	for i,v in pairs(角色信息.任务) do
 		if 任务数据[v] and 任务数据[v].类型 == 300 then
 			常规提示(id,"对方身上有押镖任务无法直接加入！")
 			return
 		end
 	end
  self:加入助战玩家(玩家数据[id].账号,对方id,id)

  local 地图编号=玩家数据[id].角色.地图数据.编号
  local 角色xy={x=x,y=y}
  local 对方xy={x=0,y=0}
  对方xy.x,对方xy.y=玩家数据[对方id].角色.地图数据.x,玩家数据[对方id].角色.地图数据.y
  角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y
  for i, v in pairs(地图处理类.地图玩家[地图编号]) do
    if i~=对方id and 玩家数据[i] then
      发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
    end
  end
  队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
  玩家数据[对方id].队伍=队伍id
  玩家数据[对方id].队长=false
  广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
  for n=1,#队伍数据[队伍id].成员数据 do
    self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
  end
  self:索取可用信息(玩家数据[id].连接id,id,4022)
	-- 发送数据(连接id,2002)
	self:同步飞行坐骑(队伍id,id)

end



function 队伍处理类:切换角色(id,内容)
  local 队伍id=玩家数据[id].队伍
  if 队伍数据[队伍id]== nil then 常规提示(id,"#Y/你没有这样的队伍") return end
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
    常规提示(id,"只有队长才可使用此项功能！")
    return
  end
  local 对方id = tonumber(内容.id)
  if not self:检测账号(玩家数据[id].账号,对方id) then
    return
  end
  if 玩家数据[对方id] == nil then
    常规提示(id,"该角色尚未进入游戏！")
    return
  elseif 玩家数据[对方id].助战 == nil then
    常规提示(id,"该角色已经在游戏中，请自行切换至该角色进行操作！")
    return
  end
  self:切换主角(对方id,id)
  发送数据(玩家数据[对方id].连接id,10997,{数字id=对方id})
end

function 队伍处理类:切换主角(数字id,对方id)
  local id = 玩家数据[对方id].连接id
  玩家数据[数字id].连接id = 玩家数据[对方id].连接id
  玩家数据[数字id].助战=nil
  玩家数据[对方id].助战=true
  玩家数据[对方id].连接id = 0
	玩家数据[数字id].角色.连接id=id
  玩家数据[数字id].角色:刷新信息("1")
  发送数据(id,5,玩家数据[数字id].角色:取总数据())
	玩家数据[数字id].道具:索要道具3(id,数字id)
	发送数据(id,16,玩家数据[数字id].召唤兽.数据)
	发送数据(id,25,宝宝队伍图)
	发送数据(id,997,{id=数字id,用户="正式用户",名称=玩家数据[数字id].角色.名称,账号=玩家数据[数字id].账号})
	发送数据(id,43,时辰信息.昼夜)
	发送数据(id,433,时辰信息.天气)
	发送数据(id,11,时辰信息.当前)
	发送数据(id,16.2,玩家数据[数字id].角色.首冲奖励)

	发送数据(id, 42, 玩家数据[数字id].角色.快捷技能)
	加载账号仓库数据(玩家数据[数字id].账号,数字id)
	玩家数据[数字id].双龙之战 = 简单_双龙之战:创建(数字id)
        	玩家数据[数字id].双龙之战:加载数据(玩家数据[数字id].账号, 数字id)
        	玩家数据[数字id].道具:更新上古玉魄显示(数字id)
        	系统处理类:进入游戏数据表处理(数字id)
	-- 商城处理类:取商品组数据(数字id, 18)
	玩家数据[数字id].角色:刷新任务跟踪()
	地图处理类:重连加入(数字id,玩家数据[数字id].角色.地图数据.编号,玩家数据[数字id].角色.地图数据.x,玩家数据[数字id].角色.地图数据.y)
		---------------------------C改
	if 玩家数据[数字id].角色.新号创建==1 then
		玩家数据[数字id].角色.新号创建=nil
		--玩家数据[数字id].角色:添加仙玉(20000,"新号创建",1)
		添加累充(数字id,68,"路费",1)
		玩家数据[数字id].道具:给予道具(数字id,"良师册",1,nil,"新号创建","专用")
		玩家数据[数字id].道具:给予道具(数字id,"会员年卡",1,nil,"新号创建","专用")
		玩家数据[数字id].道具:给予道具(数字id,"九天揽月称谓礼包",1,nil,"新号创建","专用")
		--玩家数据[数字id].道具:给予道具(数字id,"高级首充礼包",1,nil,"新号创建","专用")
		玩家数据[数字id].道具:给予道具(数字id,"小白龙礼包",1,nil,"新号创建","专用")
		--玩家数据[数字id].道具:给予道具(数字id,"双龙之战会员",1,nil,"新号创建","专用")
		玩家数据[数字id].道具:给予道具(数字id,"自动抓鬼年卡",1,nil,"新号创建","专用")
		--玩家数据[数字id].道具:给予道具(数字id,"测试礼包",1,nil,"新号创建","专用")

		玩家数据[数字id].角色:添加经验(16492)
		发送数据(数字id,105,{头像="双蓝字",标题="缘起东海湾！",说明="首次登陆游戏，快去完成新手剧情吧"})
	end
		---------------------------C改

	if 线下自动抓鬼数据[数字id] then
		线下自动抓鬼数据[数字id]=nil
	end

	self.找到节日=false
		for n=1,52 do
		        self.当前时间=os.date("%m月%d日")
		        self.节日时间=f函数.读配置(程序目录.."Shopping.ini","节日时间","节日时间"..n)
		        self.节日名称=f函数.读配置(程序目录.."Shopping.ini","节日名称","节日名称"..n)
		        -- if self.当前时间==self.节日时间  then
		        if self.当前时间==self.节日时间  and (玩家数据[数字id].角色.节日礼物==nil or 玩家数据[数字id].角色.节日礼物~=os.date("%m月%d日")) then
		        常规提示(数字id,"今天是#R/"..self.节日名称.."#W/，请前往长安节日礼物使者#Y/（208，152）#W/处领取节日礼物，祝您天天有个好心情！#77")
		        闪烁消息(数字id,"今天是#R/"..self.节日名称.."#W/，请前往长安节日礼物使者#Y/（208，152）#W/处领取节日礼物，祝您天天有个好心情！#77")
		          self.找到节日=true
		          节日开关=true
		          break
		        end
		      end

	self:索取队伍信息(数字id,4004)
 	if 玩家数据[数字id].队长 then
  	发送数据(玩家数据[数字id].连接id,4006)
 	end
 	if 玩家数据[数字id].交易信息 then
		发送数据(玩家数据[数字id].连接id,3512,玩家数据[数字id].召唤兽.数据)
		发送数据(玩家数据[数字id].连接id,3513,玩家数据[数字id].道具:索要道具2(数字id))
		发送数据(玩家数据[数字id].连接id,3514.1,{名称=玩家数据[数字id].角色.名称,等级=玩家数据[数字id].角色.等级})
		local 交易id=玩家数据[数字id].交易信息.编号
		local 对方id=玩家数据[数字id].交易信息.id
		if 交易数据[交易id][对方id].锁定 then
			local 道具数据 = {}
			local 数量数据 = {}
			for n=1,3 do
				if 交易数据[交易id][对方id].道具[n]~=nil then
					local 道具id=交易数据[交易id][对方id].道具[n].编号
					道具数据[#道具数据+1]=玩家数据[对方id].道具:取指定道具(道具id)
					数量数据[#数量数据+1] = 交易数据[交易id][对方id].道具[n].数量
				end
			end
			local bb数据 ={}
			for n=1,3 do
				if 交易数据[交易id][对方id].bb[n]~=nil then
					bb数据[#bb数据+1]=table.loadstring(table.tostring(玩家数据[对方id].召唤兽.数据[交易数据[交易id][对方id].bb[n].编号]))
				end
			end
			local 银子数据 = 交易数据[交易id][对方id].银子 or 0
			发送数据(玩家数据[数字id].连接id,3510,{bb=bb数据,道具=道具数据,数量=数量数据,银子=银子数据})
		end
		if 交易数据[交易id][数字id].锁定 then
			local 道具数据 = {}
			local 数量数据 = {}
			for n=1,3 do
				if 交易数据[交易id][数字id].道具[n]~=nil then
					道具数据[#道具数据+1]=交易数据[交易id][数字id].道具[n].格子
					数量数据[#数量数据+1] =交易数据[交易id][数字id].道具[n].数量
				end
			end
			local bb数据 ={}
			for n=1,3 do
				if 交易数据[交易id][数字id].bb[n]~=nil then
					bb数据[#bb数据+1]=交易数据[交易id][数字id].bb[n].编号
				end
			end
			local 银子数据 = 交易数据[交易id][数字id].银子 or 0
			发送数据(玩家数据[数字id].连接id,3510.1,{bb=bb数据,道具=道具数据,数量=数量数据,银子=银子数据})
		end
	end
end

function 队伍处理类:加入助战玩家(账号,数字id,id)
	玩家数据[数字id]={连接id=0}
	玩家数据[数字id].角色=角色处理类:创建(0)
	玩家数据[数字id].道具=道具处理类:创建(数字id)
	玩家数据[数字id].召唤兽=召唤兽处理类:创建(数字id)
	玩家数据[数字id].道具:加载数据(账号,数字id)
	玩家数据[数字id].角色:加载数据(账号,数字id)
	if 玩家数据[数字id].角色.藏宝阁出售 ~= nil then
    		常规提示(数字id,"#Y该角色已经被上架藏宝阁,无法进入游戏,可以使用任意角色在XX处使用ID和取回密码取回账号")
    		return
 	end
	玩家数据[数字id].召唤兽:加载数据(账号,数字id)
	玩家数据[数字id].神器=神器类:创建(数字id,数字id)
	玩家数据[数字id].神器:加载数据(账号,数字id)
		            -- 加载账号仓库数据(账号,数字id)
	玩家数据[数字id].双龙之战 = 简单_双龙之战:创建(数字id)
        	玩家数据[数字id].双龙之战:加载数据(账号, 数字id)
	---
	玩家数据[数字id].账号=账号
	玩家数据[数字id].角色.账号=账号
	玩家数据[数字id].结束等待=os.time()
	玩家数据[数字id].当前频道=os.time()
	玩家数据[数字id].世界频道=os.time()
	玩家数据[数字id].传闻频道=os.time()
	玩家数据[数字id].遇怪时间=os.time()+取随机数(10,20)
	玩家数据[数字id].队伍=0
	玩家数据[数字id].zhandou=0
	玩家数据[数字id].guanzhan=0
	玩家数据[数字id].角色.战斗开关 = false
	玩家数据[数字id].商品列表=0
  玩家数据[数字id].角色.地图数据.编号 = 玩家数据[id].角色.地图数据.编号
  玩家数据[数字id].角色.地图数据.x=玩家数据[id].角色.地图数据.x
  玩家数据[数字id].角色.地图数据.y=玩家数据[id].角色.地图数据.y
  玩家数据[数字id].角色:刷新信息("1")
  地图处理类:加入玩家(数字id,玩家数据[数字id].角色.地图数据.编号,玩家数据[数字id].角色.地图数据.x,玩家数据[数字id].角色.地图数据.y)
  if 每日任务[数字id]==nil then
		每日任务[数字id]={日常任务={},副本任务={},活跃度={当前=0,总活跃=0},签到数据={}}--{节日活动={},日常任务={},挑战竞技={},副本任务={},总活跃=0,领取活跃={}}
	end
	  if 玩家数据[数字id].角色.月卡 == nil then
	    玩家数据[数字id].角色.月卡 = {生效=false,到期时间=0}
	  end
	if 玩家数据[数字id].角色.月卡 ~= nil and 玩家数据[数字id].角色.月卡.生效 then
	    -- 判断今天是否已领取过
	    local 今天日期 = os.date("%d", os.time())
	    local 今天月份 = os.date("%m", os.time())
	    local 已领取 = (玩家数据[数字id].角色.月卡.使用日期 == 今天日期 and
	                   玩家数据[数字id].角色.月卡.使用月份 == 今天月份)
	    if not 已领取 then
	        玩家数据[数字id].道具:月卡奖励(数字id)
	        广播消息({内容=format("#G/[%s]#W自动领取月卡奖励",玩家数据[数字id].角色.名称),频道="cw"})
	    end
	end


	    if  玩家数据[数字id].角色.采矿数据 == nil then
	    玩家数据[数字id].角色.采矿数据= {熟练度=0,矿业声望=0}
	  end
	if 玩家数据[数字id].角色.变身数据 ~= nil and 玩家数据[数字id].角色:取任务(1) == 0 then
		玩家数据[数字id].角色:取消任务(玩家数据[数字id].角色:取任务(1))
		玩家数据[数字id].角色.变身数据 = nil
	end
	if 玩家数据[数字id]~=nil and 玩家数据[数字id].摊位数据~=nil then --可取消
		玩家数据[数字id].道具:收摊处理(玩家数据[数字id].连接id,数字id)
	end
	if 玩家数据[数字id].角色.通天塔数量==nil then
		玩家数据[数字id].角色.通天塔数量=0
	end

	玩家数据[数字id].角色.ip=玩家数据[id].角色.ip
	玩家数据[数字id].角色:更新任务()
	玩家数据[数字id].角色:刷新任务跟踪()
	玩家数据[数字id].角色:取快捷技能(数字id)
	玩家数据[数字id].助战=true
  if 玩家数据[数字id]~=nil then
    系统处理类:进入事件(数字id,0)
  end
  if 玩家数据[数字id].角色.BPMC ~= "无帮派" then
		local bh = 玩家数据[数字id].角色.BPBH
		if 取所有帮派[bh] and 取所有帮派[bh].已解散 and 帮派数据[bh]==nil then
			玩家数据[数字id].角色.BG = 0
			玩家数据[数字id].角色.BPBH = 0
			玩家数据[数字id].角色.BPMC = "无帮派"
		elseif 帮派数据[bh] and 帮派数据[bh].成员数据[数字id] then
			帮派数据[bh].成员数据[数字id].在线 = true
			帮派数据[bh].成员数据[数字id].离线时间 = os.time()
			帮派数据[bh].成员数据[数字id].名称 = 玩家数据[数字id].角色.名称
			帮派数据[bh].成员数据[数字id].门派 = 玩家数据[数字id].角色.门派
			帮派数据[bh].成员数据[数字id].等级 = 玩家数据[数字id].角色.等级
		else
			if 帮派数据[bh] and 帮派数据[bh].成员数据[数字id]==nil then
				玩家数据[数字id].角色.BG = 0
				玩家数据[数字id].角色.BPMC = "无帮派"
				玩家数据[数字id].角色.BPBH = 0
			end
		end
	end
	if 线下自动抓鬼数据[数字id]  then
		线下自动抓鬼数据[数字id]=nil
	end
	-- 广播消息({内容=format("#G/[%s]#W进入游戏".."#"..取随机数(1,110),玩家数据[数字id].角色.名称),频道="cw"})
	if 玩家数据[数字id].角色.id特效 then
		广播消息({内容=format("#G/[%s]#W%s进入游戏，游戏里请文明用语，使用外挂封号！".."#"..取随机数(1,110),玩家数据[数字id].角色.名称,添加ID特效1(数字id)),频道="cw"})
	else
		广播消息({内容=format("#G/[%s]#W进入游戏，游戏里请文明用语，使用外挂封号！".."#"..取随机数(1,110),玩家数据[数字id].角色.名称),频道="cw"})
	end

	服务端参数.在线人数=服务端参数.在线人数+1
	local rs=服务端参数.在线人数
	__S服务:置标题(_QJBT.."--当前在线人数"..rs)
	刷新排行榜(数字id)
	系统处理类:清除进入数据(数字id)
	助战处理类:加载助战列表(数字id)
	if 玩家数据[数字id].角色.存银+玩家数据[数字id].角色.银子>=500000000 then
		银子jilu[数字id]={yz=玩家数据[数字id].角色.存银+玩家数据[数字id].角色.银子,zh=账号}
	end
	道具刷新(数字id)
end

function 取队员任务存在(队伍id,类型)
  if 队伍数据[队伍id]==nil then return false end
  for n=1,#队伍数据[队伍id].成员数据 do
    if 玩家数据[队伍数据[队伍id].成员数据[n]].角色:取任务(类型)~=0 then
      return true
    end
  end
  return false
end

function 取消队伍任务(任务id,类型)
  if 任务数据[任务id]  and 任务数据[任务id].队伍组  then
    for i=1,#任务数据[任务id].队伍组 do
      local id = 任务数据[任务id].队伍组[i]
      if 玩家数据[id] ~= nil then
        玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(类型))
      end
    end
  end
end


function 队伍处理类:更新(dt)end
function 队伍处理类:显示(x,y)end

return 队伍处理类