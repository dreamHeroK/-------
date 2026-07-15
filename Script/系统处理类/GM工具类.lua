-- @Author: baidwwy
-- @Date:   2024-08-09 00:58:11
-- @Last Modified by:   tangguo
-- @Last Modified time: 2025-12-08 02:47:18

local 管理工具 = class()
function 管理工具:初始化()end

local function 星期转数字(xq)
  if xq=="周一" then
    return 1
  elseif xq=="周二" then
    return 2
  elseif xq=="周三" then
    return 3
  elseif xq=="周四" then
    return 4
  elseif xq=="周五" then
    return 5
  elseif xq=="周六" then
    return 6
  elseif xq=="周日" then
    return 0
  end
  return xq
end

function 管理工具:验证管理员身份(管理id)
  if f函数.读配置(程序目录..[[data\]]..玩家数据[管理id].账号..[[\账号信息.txt]],"账号配置","管理") == "2024" then
    return true
  end
  return false
end

function 管理工具:数据处理(连接id,序号,内容)--

  local 管理id = 内容.数字id+0
  if  序号 ==6901   then
      self:更改活动时间(连接id,管理id,内容)
  end
  if  序号 ==6904   then
      发送数据(连接id, 6565, HDPZ)
  end
  if  序号 ==6903   then
      self:修改爆率(连接id,管理id,内容)
  end
  if self:验证管理员身份(管理id) then
    if 序号 ==6901 then
      self:更改活动时间(连接id,管理id,内容)
    elseif 序号 ==6903 then
      self:修改爆率(连接id,管理id,内容)
    elseif 序号 ==6904 then
      发送数据(连接id, 6565, HDPZ)
    end
  end
end

function 管理工具:修改爆率(连接id,管理id,内容)
  local sdwer={}
  sdwer[1]="难度"
  sdwer[2]="经验"
  sdwer[3]="银子"
  sdwer[4]="爆率"
  sdwer[5]="书铁"
  sdwer[6]="宝珠钨金珍珠"
  sdwer[7]="宝石"
  sdwer[8]="金丹"
  sdwer[9]="怪物卡片"
  local hd=内容.活动
  local fzsfewr={}
  fzsfewr[hd]=table.copy(HDPZ[hd])
  fzsfewr[hd].ITEM={}
  for k,v in pairs(内容.爆率文本) do
    if v~="" then
      local wp = 分割文本(v,"=")
      fzsfewr[hd].ITEM[wp[1]]=wp[2]+0
    end
  end
  for k,v in pairs(内容.其他) do
    if k<=4 then
      fzsfewr[hd][sdwer[k]]=v+0
    else
      local fw=分割文本(v,"，")
      fzsfewr[hd][sdwer[k]]={fw[1],fw[2]}
    end
  end
  HDPZ[hd]=table.copy(fzsfewr[hd])
  添加最后对话(管理id,""..hd.."  活动爆率设置成功。" )
  写出文件([[全局bl.txt]],table.tostring(HDPZ))
  fzsfewr=nil
end

function 管理工具:更改活动时间(连接id,管理id,内容)
  -- .TIME [0，0，0]
  -- .时间 [1671457619]
  -- .RQ [天罡星]
  -- .类型 [定时刷怪]
  local Time=分割文本(内容.TIME,"，")
  if Time[1] and Time[2] and Time[3] then
    local SHI=Time[1]+0
    local FEN=Time[2]+0
    local MIAO=Time[3]+0
    local 更改类型=内容.类型
    local 日期=内容.RQ
    --table.print(内容)

    if 更改类型=="游泳比赛" then
      if 游泳活动.活动开关 then
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。") --设置是成功了，但是活动结束后得重新设置一次才行
        return
      end
    elseif 更改类型=="文韵墨香" then
      if 文韵墨香.活动开关 then
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
        return
      end
    elseif 更改类型=="彩虹争霸" then
      if 彩虹争霸.活动开关 then
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
        return
      end
    elseif 更改类型=="降妖伏魔" then
      if 降妖伏魔.活动开关 then
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
        return
      end
    elseif 更改类型=="帮派迷宫" then
      if 帮派迷宫.活动开关 then
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
        return
      end
    elseif 更改类型=="天降辰星" then
      if 天降辰星.活动开关 then
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
        return
      end
    elseif 更改类型=="保卫长安" then
      if 长安保卫战.活动开关 then
        长安保卫战.活动开关=false
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
        return
      end
    elseif 更改类型=="帮战" then
      if 帮派PK.活动开关 then
        帮派PK.活动开关=false
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
        return
      end
    elseif 更改类型=="比武大会" then
      --常规提示(管理id,"设置失败，"..更改类型.."活动正在完善中")
      --return
       if 比武大会.活动开关 then
              比武大会.活动开关=false
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
          return
       end
     --    if 比武大会.活动开关 then
     --         比武大会.活动开关=false
      --  常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
      --     return
      -- end
    elseif 更改类型=="剑会" then
       if 剑会.活动开关 then
        剑会.活动开关=false
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
        return
      end
    elseif 更改类型=="慈心渡鬼" then
       if 慈心渡鬼.活动开关 then
        慈心渡鬼.活动开关=false
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
        return
      end
    elseif 更改类型=="世界boss" then
       if 公共世界BOOS.活动开关 then
        公共世界BOOS.活动开关=false
        常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
        return
      end
    end
    if 更改类型=="定时刷怪" then
      if 日期=="天罡星" or 日期=="地煞星" or 日期=="封妖" or 日期=="妖王" then
        常规提示(管理id,"该活动暂时无法更改")
        return
      end
      QJHDSJ[更改类型][日期].时=SHI
      QJHDSJ[更改类型][日期].分=FEN
      QJHDSJ[更改类型][日期].秒=MIAO
      投放怪.活动时间=QJHDSJ[更改类型]
      -- table.print(投放怪.活动时间)
      写出文件([[活动时间.txt]],table.tostring(QJHDSJ))
      -- table.print(QJHDSJ)
      print("写入新的活动时间成功！")
      -- 添加最后对话(管理id,更改类型.."#Y已更改成功，更改如下   日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO)
      添加最后对话(管理id,"#G"..更改类型.."#W已更改成功，更改如下 #G日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO)
      return
    end
    if QJHDSJ[更改类型] then
      QJHDSJ[更改类型].日期=星期转数字(日期)
      QJHDSJ[更改类型].大写日期=日期
      QJHDSJ[更改类型].时=SHI
      QJHDSJ[更改类型].分=FEN
      QJHDSJ[更改类型].秒=MIAO
      -- table.print(QJHDSJ[更改类型])
      -- print("===========")
      if 更改类型=="游泳比赛" then
        游泳活动.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="门派闯关" then
        门派闯关.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="文韵墨香" then
        文韵墨香.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="彩虹争霸" then
        彩虹争霸.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="降妖伏魔" then
        降妖伏魔.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="帮派迷宫" then
        帮派迷宫.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="天降辰星" then
        天降辰星.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="保卫长安" then
        长安保卫战.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="帮战" then
        帮派PK.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="比武大会" then
        比武大会.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="剑会" then
        剑会.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="慈心渡鬼" then
        慈心渡鬼.活动时间=QJHDSJ[更改类型]
      elseif 更改类型=="世界boss" then
        公共世界BOOS.活动时间=QJHDSJ[更改类型]
      end
      写出文件([[活动时间.txt]],table.tostring(QJHDSJ))
      -- table.print(QJHDSJ)
      print("写入新的活动时间成功！")
      添加最后对话(管理id,"#G"..更改类型.."#W已更改成功，更改如下 #G日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO.."\n#R（“如果时超过24或分秒超过60”该活动就会处于关闭状态！）")
      -- 添加最后对话(管理id,"["..更改类型.."] 已更改成功，更改如下  日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO.."\n#R（“如果时超过24或分秒超过60”该活动就会处于关闭状态！）")
    end
  else
    常规提示(管理id,"#R设置失败，请注意大小写")
  end
end

return 管理工具
