-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:39
-- @Last Modified by:   tangguo
-- @Last Modified time: 2025-11-10 12:30:10


local 公共世界BOOS = class()
if f函数.文件是否存在([[sql/世界挑战.txt]])==false then
  世界挑战={开启=false,气血={当前=150000000,上限=150000000}}
  写出文件([[sql/世界挑战.txt]],table.tostring(世界挑战))
else
  世界挑战=table.loadstring(读入文件([[sql/世界挑战.txt]]))
end
if f函数.文件是否存在([[sql/世界排行.txt]])==false then
  世界排行={}
  写出文件([[sql/世界排行.txt]],table.tostring(世界排行))
else
  世界排行=table.loadstring(读入文件([[sql/世界排行.txt]]))
end

-- if f函数.文件是否存在([[活动时间/世界BOOS活动时间.txt]])==false then
--  世界BOOS活动时间={日期="周5",时=21,分=0,秒=0,结束=60*30} -- 设置时间
--   写出文件([[活动时间/世界BOOS活动时间.txt]],table.tostring(世界BOOS活动时间))
--  else
--   世界BOOS活动时间=table.loadstring(读入文件([[活动时间/世界BOOS活动时间.txt]]))
-- end
function 公共世界BOOS:初始化()
  self.活动开关 = false
  self.活动时间 = QJHDSJ["世界boss"]
end
function 公共世界BOOS:定时器()
      if self.活动开关 then
            if self.持续时间 and os.time() > self.持续时间 then
                  self:结束世界挑战()
            end
      else
            local zhouji=tonumber(os.date("%w", os.time()))
                  if zhouji == tonumber(self.活动时间.日期) then
                        if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
                              self:刷新世界挑战()
                        end

      elseif self.活动时间.日期=="每天" then
                        if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
                          self:刷新世界挑战()
                        end

      elseif self.活动时间.日期=="周1" and zhouji==1 then
                        if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
                              self:刷新世界挑战()
                        end
      elseif self.活动时间.日期=="周5" and zhouji==5 then
                        if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
                              self:刷新世界挑战()
                        end

      elseif self.活动时间.日期=="周135" and (zhouji==1 or zhouji==3 or zhouji==5) then
                        if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
                            self:刷新世界挑战()
                        end
      elseif self.活动时间.日期=="周1357" and (zhouji==1 or zhouji==3 or zhouji==5 or zhouji==0 ) then
                        if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
                            self:刷新世界挑战()
                        end
      elseif self.活动时间.日期=="周246" and (zhouji==2 or zhouji==4 or zhouji==6) then
                        if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
                            self:刷新世界挑战()
                        end
      end
    -- elseif self.持续时间 and os.time() > self.持续时间 then
    --   self:结束世界挑战()
    end
end

function 公共世界BOOS:刷新世界挑战()
  世界挑战={开启=true,气血={当前=50000000,上限=50000000}}
  世界排行={}
  -- self.持续时间 =  os.time() + 世界BOOS活动时间.结束   --存在时间
  self.持续时间=os.time()+1800
  self.活动开关 = true

  发送公告("#G/世界BOOS挑战赛已经开启，兄弟们可以点击左上角图标进行挑战了")
  广播消息({内容="#G/世界BOOS挑战赛已经开启，兄弟们可以点击左上角图标进行挑战了。",频道="xt"})
end

function 公共世界BOOS:挑战世界BOOS(id)
  if self.活动开关 then
    if 玩家数据[id].队伍 ==0 then
      常规提示(id,"#Y请先组队")
      return
     elseif #队伍数据[id].成员数据<3 then
       常规提示(id,"#Y最少三人组队")
      return
    elseif 取等级要求(id,69)==false then
      常规提示(id,"#Y挑战世界BOOS需要等级达到69级")
      return
    else
    if self:取世界挑战次数限制(id,3) then return end
      世界挑战[id] = {伤害=0,id=id,名称=玩家数据[id].角色.名称,等级=玩家数据[id].角色.等级,门派=玩家数据[id].角色.门派}
      战斗准备类:创建战斗(id,100136,1)
    end
  else



      if 无酒 then
          常规提示(id,"#Y/世界BOOS挑战赛已经结束，请等待下次开启。\n#Y每天晚上8点开启，持续30分钟。")
      else
          常规提示(id,"#Y/世界BOOS挑战赛已经结束，请等待下次开启。\n#Y每周五晚上9点开启，持续30分钟。")
      end


  end
end

function 公共世界BOOS:取世界挑战次数限制(id,次数)
local 队伍id=玩家数据[id].队伍
  for n=1,#队伍数据[队伍id].成员数据 do
    local 临时id=队伍数据[队伍id].成员数据[n]
    local cyid=队伍数据[队伍id].成员数据[n]
      if 活动次数数据.世界挑战.完成[临时id]== nil then
        活动次数数据.世界挑战.完成[临时id]=0
      end
      if 活动次数数据.世界挑战.完成[临时id]>=次数 then
        常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日世界挑战次数已达上限")
        return true
      else
        活动次数数据.世界挑战.完成[临时id]=活动次数数据.世界挑战.完成[临时id]+1
      end
  end
  return false
  end

function 公共世界BOOS:刷新世界排行(id, 数额)

  local 原数据
  local 原编号
  for i = 1, #世界排行 do
    if 世界排行[i].id == id then
      世界排行[i].伤害 = 世界排行[i].伤害 + 数额
      原编号 = i
      原数据 = DeepCopy(世界排行[i])
      table.remove(世界排行, i)
      break
    end
  end

  if 原编号 then
    for i = 1, 原编号 do
      if not 世界排行[i] or 原数据.伤害 > 世界排行[i].伤害 then
        table.insert(世界排行, i, 原数据)
        break
      end
    end
  else
    世界排行[#世界排行 + 1] = {
      伤害 = 数额,
      名称 = 玩家数据[id].角色.名称,
      id = id,
      等级 = 玩家数据[id].角色.等级,
      门派 = 玩家数据[id].角色.门派
    }
  end
end

function 公共世界BOOS:结束世界挑战(id, 数额)
  self.活动开关 = false
  if id then
    世界排行.最终一击 = {
      伤害 = 数额,
      名称 = 玩家数据[id].角色.名称,
      id = id,
      等级 = 玩家数据[id].角色.等级,
      门派 = 玩家数据[id].角色.门派
    }
  end
  for i in pairs(战斗准备类.战斗盒子) do
    if 战斗准备类.战斗盒子[i].战斗类型==100136 then
      战斗准备类.战斗盒子[i]:强制结束战斗()
    end
  end
  发送公告("#G世界BOOS挑战已经结束,可以点击BOOS页面领取排名奖励了。")
  广播消息({内容="#G/世界BOOS挑战已经结束,可以点击BOOS页面领取排名奖励了。",频道="xt"})
end

function 公共世界BOOS:领取世界BOOS奖励(id)
  if self.活动开关 then
    常规提示(id,"#Y/活动结束才可以领取奖励")
    return
  end
  for i=1,100 do
    if 世界排行[i] ~= nil and 世界排行[i].id == id then
      if 世界排行[i].领取 ~= nil then
        常规提示(id,"#Y你已经领取过该奖励了")
        return
      end
      世界排行[i].领取 = 1
      if i == 1 and 世界排行[i].伤害 >=100000 then
        添加仙玉(id,玩家数据[id].账号, 5000,"世界boos")  --世界BOSS奖励设置
        常规提示(id,"#W你处于排行榜第一名得到5000仙玉")
        return
      elseif i == 2 and 世界排行[i].伤害 >=100000 then
       添加仙玉(id,玩家数据[id].账号, 4000,"世界boos")
        常规提示(id,"#W你处于排行榜第二名得到4000仙玉")
        return
      elseif i == 3 and 世界排行[i].伤害 >=100000 then
       添加仙玉(id,玩家数据[id].账号, 3000,"世界boos")
        常规提示(id,"#W你处于排行榜第三名得到3000仙玉")
        return

      elseif i >= 4 and i <= 10 and 世界排行[i].伤害 >=100000 then
        添加仙玉(id, 玩家数据[id].账号,1500,"世界boos")
        常规提示(id,"#W你处于排行榜第4-10名得到1600仙玉")
        return
      elseif 世界排行[i].伤害 >=100000 then --参与保底奖励伤害设置
         添加仙玉(id, 800,"世界boos")
         常规提示(id,"#W你处于排行榜第10名以后活动参与奖得到800仙玉")
        return
      end
    end
  end
  常规提示(id,"#Y/你没有可以领取的奖励")
end

function 公共世界BOOS:领取世界BOOS最后一击奖励(id)
  if self.活动开关 then
    常规提示(id,"#Y/活动结束才可以领取奖励")
    return
  end
  if 世界排行.最终一击 and 世界排行.最终一击.id == id then
    if 世界排行.最终一击.领取 ~= nil then
      常规提示(id,"#Y你已经领取过该奖励了")
      return
    end
    世界排行.最终一击.领取 = 1
     添加仙玉(id,玩家数据[id].账号, 2000,"世界boos")
    常规提示(id,"#W卧槽！你这么吊竟然拿到了最后一击得到了2000仙玉#24")
    return
  end
  常规提示(id,"#Y/你没有可以领取的奖励")
end


function 失败MOB100136(id组,失败id,是否逃跑,战斗数据)

end


return 公共世界BOOS