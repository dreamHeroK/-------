-- @Author: baidwwy
-- @Date:   2023-10-25 19:03:14
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-12-30 13:55:50
function 取id组(id)
	local id组={}
	if 玩家数据[id].队伍==0 then
		id组[1]=id
	else
		local 队伍id=玩家数据[id].队伍
		for n=1,#队伍数据[队伍id].成员数据 do
		 id组[n]=队伍数据[队伍id].成员数据[n]
		end
	end
	return id组
end

function 取队伍人数(id)
	if 玩家数据[id].队伍==0 then
		return 1
	else
		return #队伍数据[玩家数据[id].队伍].成员数据
	end
end

function GetTaskGroups(id)
  local team = 队伍数据[id].成员数据
  local Tasks = 0

  -- // 循环检测 来获取到 角色所拥有并且符合的任务编号
  for k,v in next , {
        1550,1560,1570,1580,1590,1600,1610,1620,
        1630,1640,1650,1660,1670,1680,1620,1630,
        1640,1650,1660,1670,1680,670,120,580
        } do
    local task = 玩家数据[id].角色:取任务(v)
    if task and task ~= 0  then
      Tasks = v
    end
    end


    if Tasks > 0 then
      local PlayNum = 0
      local Pts = 玩家数据[id].角色:取任务(Tasks)
      -- \\ 开始循环 并且计算 队员拥有的任务一致并且记录符合跟队长任务一样的人员数量
      for k,v in next , team do
        local teamPts = 玩家数据[v].角色:取任务(Tasks)
        if 玩家id ~= v and Pts ==  teamPts then
          PlayNum = PlayNum + 1
        end
      end
      -- \\ 检查拥有同样任务人员的数量是否符合当前队伍的人员人数
      if PlayNum ~= #team then
        -- print('当前任务一致玩家数量:',PlayNum,'当前队伍成员数量:',#team)
      添加最后对话(id,"队员任务不一致")
      return
    end
    --  \\  检查 在初始赋予 任务的时候， 是否有成员并没有接收到这样的任务
    if not 任务数据[Pts].PlayerGroup then
      添加最后对话(id,"你的队员和你的任务不同哦")
      return
    end
    local PGroup  = 任务数据[Pts].PlayerGroup
    local GroupNum = 0
    local Temptteam = table.copy(PGroup)

    -- \\ 开始循环检查 任务数据之中记录的成员 和当前的 人员 是否 符合，用的排除法，remove
    for k,v in next , PGroup do
      for kk,vv in next , Temptteam do
        if vv == v then
          table.remove(Temptteam,kk)
        end
      end
    end
    -- \\ 检查 排除之后的 成员名单表 是否 已经被排除赶紧,如果有遗留 说明不对应

    if table.maxn(Temptteam) ~= 0 then
      添加最后对话(id,"请维持原队友在一起进去吧")
      return
    end
    -- \\ 将所需的结果 输出
    local Value = Tasks/10
    local Tempt = {
      [670] = 8,
      [120] = 1,

    }
    if Tempt[Tasks] then
      Value = Tempt[Tasks]
    end
    return Value
  end
  return false
end


function 移动文件1(购买,目标,id,目标id)
  local 临时 = 取文件夹内所有文件名 (程序目录..[[\data\]]..目标..[[\]]..目标id)
  lfs.mkdir([[data/]]..购买..[[/]]..目标id)
  lfs.mkdir([[data/]]..购买..[[/]]..目标id..[[/]]..[[日志记录]])
  for i=1,#临时 do
       copyfile(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\]]..临时[i],程序目录..[[\data\]]..购买..[[\]]..目标id..[[\]]..临时[i])
       os.remove(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\]]..临时[i])
  end
  local 临时 = 取文件夹内所有文件名 (程序目录..[[\data\]]..目标..[[\]]..目标id..[[\日志记录]])
  for i=1,#临时 do
       copyfile(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\日志记录\]]..临时[i],程序目录..[[\data\]]..购买..[[\]]..目标id..[[\日志记录\]]..临时[i])
       os.remove(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\日志记录\]]..临时[i])
  end
  os.execute("rd "..[[data\]]..目标..[[\]]..目标id..[[\日志记录]])
  os.execute("rd "..[[data\]]..目标..[[\]]..目标id)
end

function copyfile(source,destination)
    local sourcefile = io.open(source, "r")
    local destinationfile = io.open(destination, "w")
    destinationfile:write(sourcefile:read("*all"))
    sourcefile:close()
    destinationfile:close()
end
function 取文件夹内所有文件名 (path)
  local z={}
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      local f = path..'/'..file
      local attr = lfs.attributes (f)
      assert (type(attr) == "table")
      if attr.mode == "file" then
         z[#z+1]=file
      end
    end
  end
  return z
end

function 取队员任务一致(id,类型)
  local 队伍id = 玩家数据[id].队伍
  local 任务id = 玩家数据[id].角色:取任务(类型)
  if 队伍数据[队伍id]==nil then
    添加最后对话(id,"该任务需要组队完成！")
    return false
  end
  for n=1,#队伍数据[队伍id].成员数据 do
--    if not 队伍处理类:取是否仙友(队伍id,n) then
      local lsid = 队伍数据[队伍id].成员数据[n]
      if 玩家数据[lsid].角色:取任务(类型) ~= 任务id then
        添加最后对话(id,玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称.."与你的任务不一致！")
        return false
      end
    end
  --end
  return true
end


function 取队长权限(id)
	if 玩家数据[id].队伍==0 then
		return true
	elseif 玩家数据[id].队长 then
		return true
	end
	return false
end

function 取唯一任务(类型,id)
	随机序列=随机序列+1
	if id~=nil and 玩家数据[id] then
		local bm = id.."_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	  if 玩家数据[id].队伍==0 then
			return bm,{id}
		else
			local fh={}
			for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
				if 队伍数据[玩家数据[id].队伍].成员数据[i]~=nil then
					fh[#fh+1]=队伍数据[玩家数据[id].队伍].成员数据[i]
				end
			end
			return bm,fh
		end
	end
	return "_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
end

function 取个人唯一任务(类型,id)
	随机序列=随机序列+1
	if id~=nil then
		local bm = id.."_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	    return bm,{id}
	end
	return "_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
end

function 取队伍所有玩家名称(id)
	if id==nil then
		print("取队伍所有玩家名称时，有id为空值")
		return
	end
	if 玩家数据[id].队伍==0 then
		return 玩家数据[id].角色.名称
	else
		local 队伍id=玩家数据[id].队伍
		local fh=玩家数据[id].角色.名称
		for n=2,#队伍数据[队伍id].成员数据 do
			local cyid = 队伍数据[队伍id].成员数据[n]
			fh=fh.."、"..玩家数据[cyid].角色.名称
		end
		return fh
	end
end

function 队伍活动击杀判定(id,任务id)
	local id组 = 取id组(id)
	for i=1,#id组 do
		if 任务数据[任务id].参与组[id组[i]] ~= nil then
			return  false
		end
	end
	return true
end

local function deepCompare(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return false
    end

    if #t1 ~= #t2 then
        return false
    end

    for k, v in pairs(t1) do
        if type(v) == "table" then
            if not deepCompare(v, t2[k]) then
                return false
            end
        else
            if v ~= t2[k] then
                return false
            end
        end
    end

    return true
end

function 取队伍组(id)
	local fh={}
  local 队伍id = 玩家数据[id].队伍
	if 队伍数据[队伍id] then
		for i=1,#队伍数据[队伍id].成员数据 do
      local 队员id = 队伍数据[队伍id].成员数据[i]
      if not deepCompare(玩家数据[队员id].角色.剧情,玩家数据[id].角色.剧情) then
        常规提示(id,string.format("#Y/请注意%s剧情进度与你不一致，无法同步完成剧情任务！",玩家数据[队员id].角色.名称))
      else
			  fh[#fh+1] = 队员id
      end
		end
	else
		fh[#fh+1]=id
	end
	return fh
end

function 刷新剧情追踪(数字id)
  if 玩家数据[数字id] and not 玩家数据[数字id].助战 then
    发送数据(玩家数据[数字id].连接id,227,{剧情=玩家数据[数字id].角色.剧情})
  end
end


function 取等级要求(id,等级)
	local id组={}
	if 玩家数据[id].队伍==0 then
		id组[1]=id
	else
		local 队伍id=玩家数据[id].队伍
		for n=1,#队伍数据[队伍id].成员数据 do
		 id组[n]=队伍数据[队伍id].成员数据[n]
		end
	end
	for n=1,#id组 do
		if 玩家数据[id组[n]].角色.等级<等级 then
			return false
		end
	end
	return true
end



function 取任务符合id(id,任务id)
	if 任务数据[任务id]==nil then return false end
	for n=1,#任务数据[任务id].队伍组 do
		if 任务数据[任务id].队伍组[n]==id then
			return true
		end
	end
	return false
end

function 广播队伍消息(队伍id,文本)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]] then
			发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,38,{内容=文本,频道="dw"})
		end
	end
	return false
end
function 广播队伍链接(队伍id,文本)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]] then
			发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,113,文本)
		end
	end
	return false
end

-- function 广播自恋链接(队伍id,文本)
-- 	for n=1,#队伍数据[队伍id].成员数据 do
-- 		if 玩家数据[队伍数据[队伍id].成员数据[n]] then
-- 			发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,114,文本)
-- 		end
-- 	end
-- end


function 取门派示威对象(门派)
 local 示威对象={}
	for n, v in pairs(玩家数据) do
		if 玩家数据[n].角色.门派~="无" and 玩家数据[n].角色.门派~=门派 then
			示威对象[#示威对象+1]=n
		end
	end
	if #示威对象==0 then
		return
	else
		local 临时序列=取随机数(1,#示威对象)
		local id=示威对象[临时序列]
		return 玩家数据[id].角色:取地图数据()
	end
end

function 添加对话(id,名称,头像,对话,选项)
	发送数据(玩家数据[id].连接id,1501,{名称=名称,模型=头像,对话=对话,选项=选项})--,寄存数据
end

function 添加最后对话(id,对话,选项)--,寄存数据
	local mc=""
	local mx=""
	if 玩家数据[id].最后对话 and 玩家数据[id].最后对话.名称 then
	    mc=玩家数据[id].最后对话.名称
	    mx=玩家数据[id].最后对话.模型
	end
	发送数据(玩家数据[id].连接id,1501,{名称=mc,模型=mx,对话=对话,选项=选项})--,寄存=寄存数据
end

function 取队伍最低等级(队伍id,等级)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级<等级 then
			return true
		end
	end
	return false
end

function 取队伍最高等级(队伍id,等级)
	if 队伍数据[队伍id] == nil then return  false end
	for n=1,#队伍数据[队伍id].成员数据 do
		-- if 玩家数据[队伍数据[队伍id].成员数据[n]] then
		-- 	return false
		-- end
		if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级>等级 then
			return true
		end
	end
	return false
end

function 取队伍平均等级(队伍id,id)
	if 队伍数据[队伍id]==nil then
		return 玩家数据[id].角色.等级
	end
	local 等级=0
	for n=1,#队伍数据[队伍id].成员数据 do
		等级=等级+玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级
	end
	等级=math.floor(等级/#队伍数据[队伍id].成员数据)
	return 等级
end
function 取队伍最高等级数(队伍id,id)
	local t = {}
	if 队伍数据[队伍id]==nil then
		return 玩家数据[id].角色.等级
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		t[n]=玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级
	end
	table.sort(t)
	if t[#队伍数据[队伍id].成员数据]<10 then
		t[#队伍数据[队伍id].成员数据]=10
	end
	return t[#队伍数据[队伍id].成员数据]
end
function 取队伍任务(队伍id,rw)
	-- if 玩家数据[数字id].队伍==0 then
	--     if 玩家数据[队伍数据[队伍id].成员数据[n]].角色:取任务(rw)~=0 then
	-- 		return true
	-- 	end
	-- end
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]] and 玩家数据[队伍数据[队伍id].成员数据[n]].角色:取任务(rw)~=0 then
			return true
		end
	end
	return false
end

function 取任务次数限制(数字id,类型)
  if 全局次数限制[类型] == nil then return false end
  local 队伍组 =  {数字id}
  if 玩家数据[数字id] and 玩家数据[数字id].队伍 ~= 0 then
    local 队伍id = 玩家数据[数字id].队伍
    for n=2,#队伍数据[队伍id].成员数据 do
      队伍组[n] = 队伍数据[队伍id].成员数据[n]
    end
  end
  for n=1,#队伍组 do
    local id = 队伍组[n]
    if 全局次数限制[类型][id] and  全局次数限制[类型][id] >= 全局次数限制[类型].限制 then
      常规提示(数字id,"#Y/"..玩家数据[id].角色.名称.."今日完成该活动的次数已经达到了上限")
      return true
    end
  end
  return false
end

function 设置任务次数限制(id,类型)
  if 全局次数限制[类型] == nil then return false end
  全局次数限制[类型][id] = (全局次数限制[类型][id] or 0) + 1
end

function 取队伍活动(队伍id,类型)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 类型 == "国庆" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]] and 玩家数据[队伍数据[队伍id].成员数据[n]].角色.国庆活动~=0 then
				return true
			end
		elseif 类型 == "中秋" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]] and 玩家数据[队伍数据[队伍id].成员数据[n]].角色.中秋活动~=0 then
				return true
			end
		end
	end
	return false
end

function 队伍活动变更(队伍id,类型,进度)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 类型 == "国庆" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.国庆活动 <进度 then
				玩家数据[队伍数据[队伍id].成员数据[n]].角色.国庆活动=进度
				发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,234,{类型=1,进度=进度})
			end
		elseif 类型 == "中秋" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.中秋活动 <进度 then
				玩家数据[队伍数据[队伍id].成员数据[n]].角色.中秋活动=进度
				发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,234,{类型=2,进度=进度})
			end
		end
	end
end
function 取地宫挑战模型1(层数)
  if 层数 <= 2 then
    return {"树怪"}
  elseif 层数 == 3 then
    return {"赌徒"}
  elseif 层数 == 4 then
    return {"强盗"}
  elseif 层数 == 5 then
    return {"骷髅怪"}
  elseif 层数 == 6 then
    return {"羊头怪"}
  elseif 层数 == 7 then
    return {"黑熊"}
  elseif 层数 == 8 then
    return {"老虎"}
  elseif 层数 == 9 then
    return {"野鬼"}
  elseif 层数 == 10 then
    return {"僵尸"}
  elseif 层数 == 11 then
    return {"牛头"}
  elseif 层数 == 12 then
    return {"马面"}
  elseif 层数 == 13 then
    return {"古代瑞兽"}
  elseif 层数 == 14 then
    return {"雷鸟人"}
  elseif 层数 == 15 then
    return {"蝴蝶仙子"}
  elseif 层数 == 16 then
    return {"白熊"}
  elseif 层数 == 17 then
    return {"黑山老妖"}
  elseif 层数 == 18 then
    return {"天兵"}
  elseif 层数 == 19 then
    return {"天将"}
  elseif 层数 == 20 then
    return {"地狱战神"}
  elseif 层数 == 21 then
    return {"风伯"}
  elseif 层数 == 22 then
    return {"凤凰"}
  elseif 层数 == 23 then
    return {"碧水夜叉"}
  elseif 层数 == 24 then
    return {"蚌精"}
  elseif 层数 == 25 then
    return {"鲛人"}
  elseif 层数 == 26 then
    return {"蛟龙"}
  elseif 层数 == 27 then
    return {"巡游天神"}
  elseif 层数 == 28 then
    return {"芙蓉仙子"}
  elseif 层数 == 29 then
    return {"星灵仙子"}
  elseif 层数 == 30 then
    return {"如意仙子"}
  elseif 层数 == 31 then
    return {"锦毛貂精"}
  elseif 层数 == 32 then
    return {"千年蛇魅"}
  elseif 层数 == 33 then
    return {"百足将军"}
  elseif 层数 == 34 then
    return {"犀牛将军人形"}
  elseif 层数 == 35 then
    return {"犀牛将军兽形"}
  elseif 层数 == 36 then
    return {"野猪精"}
  elseif 层数 == 37 then
    return {"鼠先锋"}
  elseif 层数 == 38 then
    return {"泪妖"}
  elseif 层数 == 39 then
    return {"镜妖"}
  elseif 层数 == 40 then
    return {"阴阳伞"}
  elseif 层数 == 41 then
    return {"律法女娲"}
  elseif 层数 == 42 then
    return {"炎魔神"}
  elseif 层数 == 43 then
    return {"画魂"}
  elseif 层数 == 44 then
    return {"灵符女娲"}
  elseif 层数 == 45 then
    return {"吸血鬼"}
  elseif 层数 == 46 then
    return {"巴蛇"}
  elseif 层数 == 47 then
    return {"净瓶女娲"}
  elseif 层数 == 48 then
    return {"踏云兽"}
  elseif 层数 == 49 then
    return {"龙龟"}
  elseif 层数 == 40 then
    return {"红萼仙子"}
  elseif 层数 == 41 then
    return {"噬天虎"}
  elseif 层数 == 42 then
    return {"灵鹤"}
  elseif 层数 == 43 then
    return {"大力金刚"}
  elseif 层数 == 44 then
    return {"机关鸟"}
  elseif 层数 == 45 then
    return {"鬼将"}
  elseif 层数 == 46 then
    return {"葫芦宝贝"}
  elseif 层数 == 47 then
    return {"机关人人形"}
  elseif 层数 == 48 then
    return {"幽灵"}
  elseif 层数 == 49 then
    return {"幽萤娃娃"}
  elseif 层数 == 50 then
    return {"雾中仙"}
  elseif 层数 == 51 then
    return {"夜罗刹"}
  elseif 层数 == 52 then
    return {"连弩车"}
  elseif 层数 == 53 then
    return {"琴仙"}
  elseif 层数 == 54 then
    return {"机关兽"}
  elseif 层数 == 55 then
    return {"金饶僧"}
  elseif 层数 == 56 then
    return {"混沌兽"}
  elseif 层数 == 57 then
    return {"猫灵人形"}
  elseif 层数 == 58 then
    return {"猫灵兽形"}
  elseif 层数 == 59 then
    return {"狂豹人形"}
  elseif 层数 == 60 then
    return {"狂豹兽形"}
  elseif 层数 == 61 then
    return {"蝎子精"}
 elseif 层数 == 62 then
    return {"进阶凤凰"}
  elseif 层数 == 63 then
    return {"进阶碧水夜叉"}
  elseif 层数 == 64 then
    return {"进阶蚌精"}
  elseif 层数 == 65 then
    return {"进阶鲛人"}
  elseif 层数 == 66 then
    return {"进阶蛟龙"}
  elseif 层数 == 67 then
    return {"进阶巡游天神"}
  elseif 层数 == 68 then
    return {"进阶芙蓉仙子"}
  elseif 层数 == 69 then
    return {"进阶星灵仙子"}
  elseif 层数 == 70 then
    return {"进阶如意仙子"}
  elseif 层数 == 71 then
    return {"进阶锦毛貂精"}
  elseif 层数 == 72 then
    return {"进阶千年蛇魅"}
  elseif 层数 == 73 then
    return {"进阶百足将军"}
  elseif 层数 == 74 then
    return {"进阶犀牛将军人形"}
  elseif 层数 == 75 then
    return {"进阶犀牛将军兽形"}
  elseif 层数 == 76 then
    return {"进阶野猪精"}
  elseif 层数 == 77 then
    return {"进阶鼠先锋"}
  elseif 层数 == 78 then
    return {"进阶泪妖"}
  elseif 层数 == 79 then
    return {"进阶镜妖"}
  elseif 层数 == 80 then
    return {"进阶阴阳伞"}
  elseif 层数 == 81 then
    return {"进阶律法女娲"}
  elseif 层数 == 82 then
    return {"进阶炎魔神"}
  elseif 层数 == 83 then
    return {"进阶画魂"}
  elseif 层数 == 84 then
    return {"进阶灵符女娲"}
  elseif 层数 == 85 then
    return {"进阶吸血鬼"}
  elseif 层数 == 86 then
    return {"进阶巴蛇"}
  elseif 层数 == 87 then
    return {"进阶净瓶女娲"}
  elseif 层数 == 88 then
    return {"进阶踏云兽"}
  elseif 层数 == 89 then
    return {"进阶龙龟"}
  elseif 层数 == 90 then
    return {"进阶红萼仙子"}
  elseif 层数 == 91 then
    return {"进阶噬天虎"}
  elseif 层数 == 92 then
    return {"进阶灵鹤"}
  elseif 层数 == 93 then
    return {"进阶大力金刚"}
  elseif 层数 == 94 then
    return {"进阶机关鸟"}
  elseif 层数 == 95 then
    return {"进阶鬼将"}
  elseif 层数 == 96 then
    return {"进阶葫芦宝贝"}
  elseif 层数 == 97 then
    return {"进阶机关人人形"}
  elseif 层数 == 98 then
    return {"进阶幽灵"}
  elseif 层数 == 99 then
    return {"进阶幽萤娃娃"}
  elseif 层数 == 100 then
    return {"进阶雾中仙"}
  elseif 层数 == 101 then
    return {"进阶夜罗刹"}
  elseif 层数 == 102 then
    return {"进阶连弩车"}
  elseif 层数 == 103 then
    return {"进阶琴仙"}
  elseif 层数 == 104 then
    return {"进阶机关兽"}
  elseif 层数 == 105 then
    return {"进阶金饶僧"}
  elseif 层数 == 106 then
    return {"进阶混沌兽"}
  elseif 层数 == 107 then
    return {"进阶猫灵人形"}
  elseif 层数 == 108 then
    return {"进阶猫灵兽形"}
  elseif 层数 == 109 then
    return {"进阶狂豹人形"}
  elseif 层数 == 110 then
    return {"进阶狂豹兽形"}
  elseif 层数 == 111 then
    return {"进阶蝎子精"}
  else
    return {"炎魔神","大力金刚","毗舍童子","噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","曼珠沙华","巨力神猿","长眉灵猴","金身罗汉","修罗傀儡鬼","修罗傀儡妖","蝎子精","蜃气妖"}
  end
end