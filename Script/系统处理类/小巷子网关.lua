-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:41
-- @Last Modified by:   tangguo
-- @Last Modified time: 2026-02-24 17:23:57
-- @Author: 作者QQ874270345
-- @Date:   2023-06-24 19:47:10
-- @Last Modified by:   作者QQ874270345
-- @Last Modified time: 2025-03-25 20:31:08

local 小巷子网关= class()
local 人民币比例 = 10
function 小巷子网关:数据处理(num,arg)
print("网关发送成功")
  if not arg or not arg.小巷子 or arg.小巷子~="19900524" then   --19900524
        print("请注意：网关数据来源异常！！！")
       return
    end
  local neir = ""
  for k,v in pairs(arg) do
  	if k~="序号" and k~="小巷子" then
  	   neir=neir..v
  	end
  end
  管理日志=读取文件1("管理日志.txt")
  管理日志 =管理日志.."\n"..os.date("[%Y年%m月%d日%X]:")..neir
  写出文件1("管理日志.txt", 管理日志)
  if num==6900 then
        self:GM网关开关(arg.内容,arg.文本 )
  elseif num == 6901 then
      self:GM玩家管理(arg)
  elseif num == 6902 then
      self:GM修改参数(arg)
  elseif num == 6903 then
      self:GM赠送称谓(arg)
  elseif num == 6904 then
      self:GM充值系统(arg)
  elseif num == 6905 then
      self:GM定制装备(arg)
  elseif num == 6906 then
      self:GM定制灵饰(arg)
  elseif num == 6907 then
      self:GM定制召唤兽(arg)
  elseif num == 6908 then
      self:GM地图系统(arg)
  elseif num == 6909 then
    self:GM自定义刷新怪(arg)
  elseif num == 6910 then
      self:GM自定义物品(arg)
  elseif num == 6911 then --转发消息
    self:GM转发消息(arg)
    elseif num == 6912 then --转发消息
   self:CDK兑换(arg)
    elseif num == 6913 then
      self:GM定制召唤兽装备(arg)
      -- elseif num == 6914 then
      -- 	发送公告(arg.内容)
      -- elseif num == 6915 then
      -- 	广播系统消息(arg.内容)
  end
end

function 小巷子网关:是否升级VIP(id)
    local sheng=false
  if 玩家数据[id].角色.VIP.VIP值>=每日累积[20].vip值 then
     玩家数据[id].角色.VIP.VIP=10
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[19].vip值  then
     玩家数据[id].角色.VIP.VIP=9
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[18].vip值  then
     玩家数据[id].角色.VIP.VIP=8
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[17].vip值  then
     玩家数据[id].角色.VIP.VIP=7
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[16].vip值  then
     玩家数据[id].角色.VIP.VIP=6
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[15].vip值  then
     玩家数据[id].角色.VIP.VIP=5
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[14].vip值 then
     玩家数据[id].角色.VIP.VIP=4
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[13].vip值  then
     玩家数据[id].角色.VIP.VIP=3
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[12].vip值  then
     玩家数据[id].角色.VIP.VIP=2
     sheng=true
  elseif 玩家数据[id].角色.VIP.VIP值>=每日累积[11].vip值 then
     玩家数据[id].角色.VIP.VIP=1
     sheng=true
  end
  if sheng then
  发送数据(玩家数据[id].连接id,5,角色处理类:获取角色数据(玩家数据[id]))
  end
end

function 小巷子网关:CDK兑换(data)



end


function 小巷子网关:GM转发消息(data)
local id=tonumber(data.数字id)
  if  玩家数据[id] == nil then
         发送网关消息(string.format("%d角色不存在或未上线",data[1]))
  else
       发送数据(玩家数据[id].连接id,7,"#Y/"..data[1])
  end
end
function 小巷子网关:GM自定义物品(data)
  if   data[1] == "全服" then
     for k,v in pairs(玩家数据) do
      if 玩家数据[k] and not 玩家数据[k].假人 then
           for i=3,6 do
            if data[i] =="" then
               data[i] =nil
            elseif i == 3 or i==5 or i==6 then
               data[i] =tonumber(data[i])
            end
          end
          if  v.角色.等级 >=50 then
          玩家数据[k].道具:给予道具(k,data[2],data[5],data[4],"网关发送")
          end
          广播消息({内容=format("#xt/#g/ " .. v.角色.名称 .. "#y/获得了游戏管理员赠送的红包，打开一看竟是#r/" .. data[2] .. "。#S/玩家热情不断,GM福利嗨翻天".."#"..math.random(110)),频道="cw"})
      end
   end
    发送网关消息(string.format("全服69级以上玩家发送%s成功",data[2]))
  else
    if  玩家数据[data[1]] == nil then
           发送网关消息(string.format("%d角色不存在或未上线",data[1]))
    elseif ItemData[data[2]] then
         for i=3,6 do
            if data[i] =="" then
               data[i] =nil
            elseif i==5 or i==6 then
               data[i] =tonumber(data[i])
            end
          end
          -- table.print(data)
          玩家数据[data[1]].道具:给予道具(data[1],data[2],data[5],data[4],data[3])
          发送网关消息(string.format("发送%s成功",data[2]))
    else
      发送网关消息(string.format("数据表未定义%s物品",data[2]))
    end
  end
end
function 小巷子网关:GM自定义刷新怪(data)
  local 怪名=data.内容
  --  if 怪物刷新数据[怪名] then
  --   任务处理类:加载刷新怪物(怪物刷新数据[怪名],怪名)
  --    print(string.format("%s刷新成功",怪名))
  -- else
     print(string.format("%s数据表不存在无法执行刷新",怪名))
  -- end
end
function 小巷子网关:GM修改参数(...)

    local num,类型=unpack(...)
    if 类型 =="调整经验" then
        服务端参数.经验获得率= tonumber(num)
        发送网关消息("当前服务端的经验获得率改为"..num)
         广播消息({内容="当前服务器的经验倍率为："..服务端参数.经验获得率,频道="xt"})
         发送公告("当前服务器的经验倍率为："..服务端参数.经验获得率)
      f函数.写配置(程序目录.."配置文件.ini","主要配置","经验",服务端参数.经验获得率)
    elseif 类型 =="限制等级" then
      QJDJSX= tonumber(num)
          发送网关消息("当前服务端的限制等级改为"..num)
          f函数.写配置(程序目录.."配置文件.ini","主要配置","等级上限",QJDJSX)
         广播消息({内容="当前服务器的限制等级为："..QJDJSX,频道="xt"})
         发送公告("当前服务器的限制等级为："..QJDJSX)
      else
        发送网关消息("功能未添加请自行添加！或者联系874270345添加")
    end
end
function 小巷子网关:GM地图系统(...)
      发送网关消息("功能未添加请自行添加！或者联系874270345添加")
  local arg=...
  local MapNumber = tonumber(arg[2])
    if  arg[1] == "更新数据" then

    elseif arg[1] == "清除摆摊" then
      if 地图处理类.地图玩家[MapNumber] then
        for n, v in pairs(地图处理类.地图玩家[MapNumber]) do
             if 玩家数据[n] and 摊位数据[n] then
                  玩家数据[n].道具:收摊处理(玩家数据[n].连接id,n)
             end
         end
      end
            print("清理完成")
    elseif arg[1] == "清除假人" then
         -- collectgarbage("collect")
    elseif arg[1] == "清除怪物" then
      -- if 地图处理类.地图单位[MapNumber] then
      --    地图处理类:删除所有单位(MapNumber)
      --    发送网关消息("清理怪物完成")
      --     print("清理怪物完成")
      --   else
      --     print("地图序号异常")
      -- end
       -- collectgarbage("collect")
    elseif arg[1] == "清除玩家" then
      --  if 地图处理类.地图玩家[MapNumber] then
      --    地图处理类:清除活动地图玩家(MapNumber,"您已被GM请出当前地图!")
      --    发送网关消息("清理玩家完成")
      --     print("清理玩家完成")
      --   else
      --     print("地图序号异常")
      -- end
      -- collectgarbage("collect")
    elseif arg[1] == "添加假人" then
      -- if not 地图处理类.地图数据[MapNumber].坐标 then
      --   print("这个地图不支持刷出假人,请尝试在主城刷新，如果有特别要求请联系作者")
      --    return
      -- end
        -- local 玩家账号 =取目录下名称(程序目录.."玩家信息")
        -- if arg[3] > #玩家账号 then
        --   arg[3]=#玩家账号
        -- end

    end

     print(string.format("地图%s成功",arg[1]))
end

function 小巷子网关:GM充值系统(...)
  local arg=...
    if  玩家数据[arg[1]] == nil then
         发送网关消息(string.format("%d角色不存在或未上线",arg[1]))
         return
    elseif arg[2]=="充值银子" then
    	   玩家数据[arg[1]].角色:添加银子(arg[3],"GM充值",1)
         发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点银子已经到账")
    elseif arg[2]=="充值储备" then
                    --角色处理类:添加储备(玩家数据[arg[1]],arg[3],"GM充值")
                     玩家数据[arg[1]].角色:添加储备(arg[3],"GM充值",1)
                    发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点储备已经到账")
    elseif arg[2]=="充值门贡" then
                    玩家数据[arg[1]].角色.门贡=玩家数据[arg[1]].角色.门贡+arg[3]
                    发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点门贡已经到账")

                elseif arg[2]=="充值天罡积分" then
                   玩家数据[arg[1]].角色:添加天罡积分(arg[3],"GM充值",1)
                    发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点天罡积分已经到账")
                          elseif arg[2]=="充值地煞积分" then
                    玩家数据[arg[1]].角色:添加地煞积分(arg[3],"GM充值",1)
                    发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点地煞积分已经到账")
                          elseif arg[2]=="充值神器积分" then
                   玩家数据[arg[1]].角色:添加神器积分(arg[3],"GM充值",1)
                    发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点神器积分已经到账")
                          elseif arg[2]=="充值副本积分" then
                  玩家数据[arg[1]].角色:添加副本积分(arg[3],"GM充值",1)
                    发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点副本积分已经到账")
                          elseif arg[2]=="充值声望积分" then
                   玩家数据[arg[1]].角色:添加声望积分(arg[3],"GM充值",1)
                    发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点声望积分已经到账")

    elseif arg[2]=="充值帮贡" then
    	        发送网关消息("无效")
             发送网关消息("功能未添加请自行添加！或者联系874270345添加")
    elseif arg[2]=="充值经验" then
                   玩家数据[arg[1]].角色:添加经验(arg[3],"GM充值",1)
                发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/点经验已经到账")
  elseif arg[2]=="充值仙玉" then
                添加仙玉(arg[1], 玩家数据[arg[1]].账号,arg[3],"GM充值")
                发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. (arg[3]*10 ).. "#y/点仙玉已经到账")
   elseif arg[2]=="打造熟练度" or arg[2]=="裁缝熟练度" or arg[2]=="炼金熟练度"or arg[2]=="淬灵熟练度"then
                local LX = ""
             if arg[2]=="打造熟练度"  then
                LX = "打造技巧"
              elseif arg[2]=="裁缝熟练度" then
                LX = "裁缝技巧"
              elseif arg[2]=="炼金熟练度"  then
                LX = "炼金术"
               elseif  arg[2]=="淬灵熟练度"then
                LX = "淬灵之术"
              end
               if LX ~= "" then
                玩家数据[arg[1]].角色:增加生活技能熟练(LX,arg[3],"GM充值")
                发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. (arg[3]*10 ).. "#y/点"..arg[2].."已经到账")
                end
  elseif arg[2]=="扣除人民币" then

          elseif arg[2]=="充值累计" then
               --添加点卡(arg[1],玩家数据[arg[1]].账号, arg[3],"GM充值")
               添加累充(arg[1],arg[3],"GM充值",1)

                 发送数据(玩家数据[arg[1]].连接id, 7, "#y/您充值的#r/" .. arg[3] .. "#y/累计额度已经到账")
   else

   发送网关消息("暂未添加此功能!")
   return
   end
    发送网关消息(string.format("角色%d%s%s",arg[1],arg[2],arg[3]))
end
function 小巷子网关:GM赠送称谓(...)
  local arg=...
     if  玩家数据[arg[1]] == nil then
         发送网关消息(string.format("%d角色不存在或未上线",arg[1]))
       elseif  arg[2]==""then
        发送网关消息("请输入称谓")
    elseif 玩家数据[arg[1]].角色:检查称谓(arg[2]) then
      发送网关消息(玩家数据[arg[1]].角色.名称.."已有称谓无法添加")
    else
      玩家数据[arg[1]].角色:添加称谓(arg[2])
      发送数据(玩家数据[arg[1]].连接id, 7, "#y/你获得GM赠送的"..arg[2].."称谓")
      发送网关消息(玩家数据[arg[1]].角色.名称.."赠送"..arg[2].."称谓成功")
    end
end
function 小巷子网关:GM定制装备(...)
  local arg=...
     if  玩家数据[arg[1]] == nil then
        发送网关消息(string.format("%d角色不存在或未上线",arg[1]))
    else
        local 装备数据1=分割文本(arg[2],"*-*")
        self:生成装备(arg[1],tonumber(装备数据1[1]) ,装备数据1)
        发送网关消息(string.format("%d发送装备成功",arg[1]))
    end
end
function 小巷子网关:生成装备(id,等级,装备数据1)
  if 等级>=100 then
    等级=等级/10
    等级=math.floor(等级)
  else
    等级=等级/10
    等级=math.floor(等级)
  end
  等级=math.floor(等级)
  local 总序列={}
  local 总名称={}
  local 模型=玩家数据[id].角色.模型
  local 使用序列 = 1
  local 使用名称 = ""

  if 装备数据1[2]=="武器" then
      使用序列=角色武器类型[模型][取随机数(1,#角色武器类型[模型])]
      使用名称=取随机装备名称(等级*10,使用序列)--取装备名称(等级*10,使用序列)
    elseif 装备数据1[2]=="衣服" then
       local 使用序列=23
        if 玩家数据[id].角色.性别=="女" then
          使用序列=22
        end
        使用名称=取随机装备名称(等级*10,使用序列)
      elseif 装备数据1[2]=="头盔" then
      local 使用序列=19
      if 玩家数据[id].角色.性别=="女" then
        使用序列=20
      end
      使用名称= 取随机装备名称(等级*10,使用序列)
    elseif 装备数据1[2]=="项链" then
     使用序列=21
     使用名称=取随机装备名称(等级*10,使用序列)
elseif 装备数据1[2]=="腰带" then
  使用序列=24
  使用名称=取随机装备名称(等级*10,使用序列)
elseif 装备数据1[2]=="鞋子" then
  使用序列=25
  使用名称= 取随机装备名称(等级*10,使用序列)
  end
if 使用名称=="" then
   发送网关消息("输入信息不对！")
return
end
--function 装备处理类:生成打造装备(id,级别,种类,名称,生产方式,制造者,是否鉴定,专用,无级别,对方id,倍率,属性组)
if 装备数据1[3]~="" then
   倍率=tonumber(装备数据1[3])
end
local 属性组={}
if 装备数据1[4]~="" then
   属性组.特效=装备数据1[4]
end
if 装备数据1[5]~="" then
   属性组.特技=装备数据1[5]
end
if 装备数据1[6]~="" then
  -- for k,v in pairs(装备资质数据.武器.名称) do
  --    if v==装备数据1[6] then
  --         属性组.资质=k
  --    end
  -- end
end
if 装备数据1[7]~="" and 装备数据1[8]~="" then
  属性组.套装={}
  if 装备数据1[7]==1 or 装备数据1[7]=="1" then
     属性组.套装.类型="追加法术"
     elseif 装备数据1[7]==2 or 装备数据1[7]=="2" then
     属性组.套装.类型="追加状态"
     elseif 装备数据1[7]==3 or 装备数据1[7]=="3" then
     属性组.套装.类型="变身术"
  end
  属性组.套装.名称=装备数据1[8]
end
if 装备数据1[9] and 装备数据1[9]~="=@="  then
  local 属性=分割文本(装备数据1[9],"@")
  属性组.双加=属性
end
  self:生成装备数据(id,等级*10,使用序列,使用名称,"系统产出",nil,true,id,nil,nil,倍率,属性组)
end

function 小巷子网关:生成装备数据(id,级别,种类,名称,生产方式,制造者,是否鉴定,专用,无级别,对方id,倍率,属性组) --真正的强化打造公式
  -- (id,等级*10,武器序列,武器名称,"系统产出",nil,true,id,无级别)
  local 属性组=属性组 or {}
  local 倍率1 = 1
  if 倍率 then
  倍率1 = 倍率
   end
  local dz = 装备处理类:装备万能公式(级别,种类,生产方式,专用,对方id)
  local 道具 = 物品类()
  道具:置对象(名称,nil,nil,级别)
  道具.等级 = 级别
  if 种类 ~= nil then
    道具.子类= 种类+0
  end
  if dz[1] ~= nil then
    道具.命中 = dz[1]*倍率1
  end
  if dz[2] ~= nil then
    道具.伤害 = dz[2]*倍率1
  end
  if dz[3] ~= nil then
    道具.防御 = dz[3]*倍率1
  end
  if dz[4] ~= nil then
    道具.魔法 = dz[4]*倍率1
  end
  if dz[5] ~= nil then
    道具.灵力 = dz[5]*倍率1
  end
  if dz[6] ~= nil then
    道具.气血 = dz[6]*倍率1
  end
  if 种类==6 and  dz[7] ~= nil and dz[7]~=0 then
     道具.敏捷 = dz[7]*倍率1
  -- elseif dz[7] ~= nil and dz[7]~=0 then
  --   道具.敏捷=math.floor(dz[7])
  end
  -- if dz[8] ~= nil and dz[8]~=0 then
  -- 道具.体质=math.floor(dz[8])
  -- end
  -- if dz[9] ~= nil and dz[9]~=0 then
  -- 道具.力量=math.floor(dz[9])
  -- end
  -- if dz[10] ~= nil and dz[10]~=0 then
  --  -- 道具.耐力 = dz[10]*倍率1
  -- 道具.耐力=math.floor(dz[10])
  -- end01
  -- if dz[11] ~= nil and dz[11]~=0 then
  --   -- 道具.魔力 = dz[11]*倍率1
  -- 道具.魔力=math.floor(dz[11])
  -- end

  if 属性组.特效 then
    道具.特效={}
    道具.特效[#道具.特效+1] =属性组.特效
  elseif dz[12] ~= nil then
    道具.特效={}
    道具.特效[1] =dz[12]
  end
  if 属性组.特技 then
    道具.特技 =属性组.特技
  elseif dz[13] ~= nil then
    道具.特技 = dz[13]
  end
  if 属性组.资质 then
    道具.资质 =属性组.资质+0
  end
  if dz[14] ~= nil then
    道具.五行 = dz[14]
  end
  if dz[15] ~= nil then
    道具.耐久 = dz[15]
  end
  if dz[16] ~= nil then
    道具.鉴定 = dz[16]
  end
  if 是否鉴定 then
    道具.鉴定 = true
  end
  if 无级别 ~= nil then
    if 道具.特效~=nil then
      if #道具.特效<3 then
        道具.特效[#道具.特效+1]="无级别限制"
      else
        道具.特效[3]="无级别限制"
      end
    else
      道具.特效={}
      道具.特效[1]="无级别限制"
    end
  end
  if 属性组.双加 then
               for k,v in pairs(属性组.双加) do
                if v then
                    local 属性=分割文本(v,"=")
                    if 道具[属性[1]] then
                       道具[属性[1]]=nil
                    end
                     道具[属性[1]]=math.floor(属性[2])
                end
               end
  end
  if 属性组.套装 and 属性组.套装.类型 then
                           if 属性组.套装.类型 ==  "变身术" then
        道具.套装效果={"变身术之",属性组.套装.名称}
      elseif 属性组.套装.类型 == "追加法术" then
        local 套装类型="追加法术"
        道具.套装效果={套装类型,属性组.套装.名称}
      elseif 属性组.套装.类型 == "追加状态" then
        local 套装类型="附加状态"
        道具.套装效果={套装类型,属性组.套装.名称}
      end
             end
  道具.类型= dz.类型
  if 专用 ~= nil then
    道具.专用 = 专用
  else
    if 鉴定==nil and 取随机数()<=5 and 道具.级别限制/10>=qz(玩家数据[id].角色.等级/10) then --and 道具.级别限制>=100
      道具.专用提示=true
    end
  end
  道具.生产方式 = 生产方式
  if 生产方式 == "普通打造" then
    道具.制造者 = 制造者
  elseif 生产方式 == "强化打造" then
    道具.制造者 = 制造者
  end
    玩家数据[id].道具:给予道具(id,nil,nil,nil,"网关发送",nil,道具)
end
function 小巷子网关:GM定制召唤兽装备(...)
   local arg=...
     if 玩家数据[arg[1]] == nil then
    发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
  else

    local 数据 = 分割文本(arg[2], "*-*")
  --  --  1-等级  2-装备类型  3-主属性类型  4-主属性数值  5-副属性类型  6-副属性数值  78-副2  910-副3
    local 等级 =数据[1]+0
    local 类型 =数据[2]
    local 类型序列
    local 双加 = 分割文本(数据[7], "@")
    if 类型 =="护腕" then
      类型序列=24
    elseif 类型 =="项圈" then
      类型序列=25
    elseif 类型 =="铠甲" then
      类型序列=26
    end
  local 临时序列=math.floor(等级/10)
  local 临时名称=装备处理类.打造物品[类型序列][临时序列]
  local 道具 = 物品类()
  道具:置对象(临时名称)
  道具.级别限制 = 等级
  道具.召唤兽装备 = true
  table.print(数据)

  if 数据[3]~="" and 数据[4]~="" then
    道具[数据[3]]=数据[4]+0
  end
  if 数据[5]~="" and 数据[6]~="" then
    道具[数据[5]]=数据[6]+0
  end
  if 数据[7]~="" and 数据[8]~="" then

    道具[数据[7]]=数据[8]+0
  end
  if 数据[9]~="" and 数据[10]~="" then
    道具[数据[9]]=数据[10]+0
  end
  道具.制造者 = "网关专属定制"
  玩家数据[arg[1]].道具:给予道具(arg[1],nil,nil,nil,"网关发送",nil,道具)
  发送网关消息(string.format("[%d]发送BB装备(%s)成功", arg[1],临时名称))
  end
end


function 小巷子网关:GM定制召唤兽(...)
  local arg=...
     if  玩家数据[arg[1]] == nil then
        发送网关消息(string.format("%d角色不存在或未上线",arg[1]))
    else
        local 数据=分割文本(arg[2],"*-*")
        if Qubaobao[数据[2]] ==nil then
            发送网关消息(string.format("召唤兽数据表未定义%s召唤兽",数据[2]))
            return
        end
      --添加召唤兽  (数据[2],数据[2],数据[3],属性,数据[1],nil,数据[14],资质组,数据[12],nil,属性表,内丹数量,数据,消费,消费方式,消费内容)
        玩家数据[arg[1]].召唤兽:定制召唤兽(数据)
        发送网关消息(string.format("%d召唤兽发送成功",arg[1]))
        发送数据(玩家数据[arg[1]].连接id, 7, "#y/你获得GM赠送的神级召唤兽")
    end
end
function 小巷子网关:GM定制灵饰(...)
  local arg=...
     if  玩家数据[arg[1]] == nil then
        发送网关消息(string.format("%d角色不存在或未上线",arg[1]))
    else
        local 装备数据1=分割文本(arg[2],"*-*")
       local  等级=tonumber(装备数据1[1])
        local 类型=装备数据1[2]
       local  名称=制造装备[类型][等级]
        玩家数据[arg[1]].道具:给予道具(arg[1],nil,nil,nil,"网关发送",nil,self:生成定制灵饰(arg[1],名称,等级,类型,装备数据1))
        发送网关消息(string.format("%d发送装备成功",arg[1]))
    end
end
function 小巷子网关:生成定制灵饰(id,名称,等级,类型,装备数据1)
  local 临时道具 =物品类()
  临时道具:置对象(名称)
  local 主属性=装备数据1[3]
  local 主数值=tonumber(装备数据1[4])
  临时道具.级别限制 = 等级
  临时道具.幻化等级=0
  临时道具.部位类型=类型
  临时道具.灵饰=true
  临时道具.耐久=500
  临时道具.鉴定=false
  临时道具.幻化属性={附加={},}
  临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
  随机序列=随机序列+1
  临时道具.幻化属性.基础={类型=主属性,数值=主数值,强化=0}
local 附加属性 = 分割文本(装备数据1[6],"@")
for i,v in ipairs(附加属性) do
  if v and v~="" then
      local 附加数据 = 分割文本(v,"=")
      if 附加数据[1]~="" and 附加数据[2]~=""  then
          临时道具.幻化属性.附加[#临时道具.幻化属性.附加+1]={类型=附加数据[1],数值=tonumber(附加数据[2]),强化=0}
      end
  end
end
     临时道具.专用=id
     临时道具.鉴定=true
 if 装备数据1[5]~="" then
     临时道具.特效="超级简易"
 end
  return 临时道具
end
function 小巷子网关:GM玩家管理(...)
  --发送网关消息("功能未添加请自行添加！或者联系874270345添加")
   local arg=...
     if arg[2]=="解封(账号)" then
        if f函数.文件是否存在([[data/]]..arg[1]) == false then
            发送网关消息(string.format("%s账号不存在",arg[1]))
        else
            f函数.写配置(程序目录.."[[data/]]" .. arg[1] .. "/账号.txt", "账号信息", "封禁", 0)
            发送网关消息(string.format("%s账号解封成功",arg[1]))
        end
      return
     end
if arg[2]=="清除连接限制" then

  return
end
     arg[1] =arg[1]+0
     local 玩家id=arg[1]
     if  玩家数据[arg[1]] == nil then
         发送网关消息(string.format("%d角色不存在或未上线",arg[1]))
    elseif arg[2]=="清空任务" then
     for n, v in pairs(玩家数据[arg[1]].角色.任务) do
      玩家数据[arg[1]].角色:取消任务(v)
     end
     发送网关消息(string.format("%d任务全部清理完毕",arg[1]))
     elseif arg[2]=="重置所有副本" then
      for k,v in pairs(副本数据) do
          if v and v.进行 then
              v.进行[玩家id]=nil
          end
          if v and v.完成 then
              v.完成[玩家id]=nil
          end
      end
       发送网关消息(string.format("重置副本%d成功",arg[1]))
    elseif arg[2]=="强制下线" then
      if 玩家数据[arg[1]] then
       玩家数据[arg[1]].角色:存档()
       发送数据(玩家数据[arg[1]].连接id,999,"你已经被管理员强制下线!")
       系统处理类:断开游戏(arg[1] )-- 网络处理类:退出处理(arg[1])
       发送网关消息(string.format("%d退出了游戏",arg[1]))
      end
    elseif arg[2]=="退出战斗" then
            if 玩家数据[arg[1]].zhandou == 0 then
                 发送网关消息(string.format("%d未处于战斗中",arg[1]))
            else
                战斗准备类.战斗盒子[玩家数据[arg[1]].zhandou]:强制结束战斗()
                战斗准备类.战斗盒子[玩家数据[arg[1]].zhandou] = nil
                发送网关消息(string.format("%d退出了战斗",arg[1]))
            end
    elseif arg[2]=="封禁账号" then
        -- 封禁账号(arg[1],"GM封禁")
        -- 发送网关消息(string.format("%d封禁成功",arg[1]))
    elseif arg[2]=="网关封禁账号" then
        -- 封禁账号(arg[1],"系统封禁")
        -- 发送网关消息(string.format("%d因拦截封包封禁成功",arg[1]))
    elseif arg[2]=="清除摆摊" then
      --  摆摊处理类:数据处理(arg[1], 12)
    elseif arg[2]=="清空背包" then
       玩家数据[arg[1]].道具:清空包裹(玩家数据[arg[1]].连接id,arg[1],80)--:清空包裹(连接id,id,数量)
        发送网关消息(string.format("%d清除背包成功",arg[1]))
    elseif arg[2]=="限制喊话" then
        玩家数据[arg[1]].角色.限制喊话=true
        发送网关消息(string.format("%d限制了喊话功能",arg[1]))
    elseif arg[2]=="解除限制喊话" then
        玩家数据[arg[1]].角色.限制喊话=false
        发送网关消息(string.format("%d解除了限制了喊话功能",arg[1]))
    elseif arg[2]=="删除角色" then
      --角色处理类:删除角色(玩家数据[arg[1]].角色,arg[1])
     --  print(string.format("%d角色删除成功",arg[1]))
    end
end
function 小巷子网关:GM网关开关(data,文本)
  print(data)


   if data and data=="发送广播" and 文本 then
        广播消息({内容=文本,频道="gm"})

  elseif data and data=="发送公告" and 文本 then

for n = 1, #敏感词数据 do
    if string.find(文本, 敏感词数据[n]) ~= nil then

      return false

    end

 end

         发送公告(文本)

    --      for n = 1, #敏感词数据 do
    -- if string.find(文本, 敏感词数据[n]) ~= nil then
    --   写配置("./发言记录.txt", "违规发言", 玩家数据[id].账号, "ID为 "..id.."，违规发言内容："..文本.."，时间："..时间转换(os.time()))
    --                                    常规提示(id,"你想搞鸡毛#24。")

  elseif data and data=="维护通知" then
          维护通知()
   elseif data =="当前监听关闭" then
    当前监听=false
    发送网关消息(data)
  elseif data =="队伍监听关闭" then
    队伍监听=false
    发送网关消息(data)
  elseif data =="世界监听关闭" then
    世界监听=false
    发送网关消息(data)
  elseif data =="帮派监听关闭" then
    帮派监听=false
    发送网关消息(data)
  elseif data =="门派监听关闭" then
    门派监听=false
    发送网关消息(data)
  elseif data =="传闻监听关闭" then
    传闻监听=false
    发送网关消息(data)
  elseif data =="当前监听开启" then
    当前监听=true
    发送网关消息(data)
  elseif data =="队伍监听开启" then
    队伍监听=true
    发送网关消息(data)
  elseif data =="世界监听开启" then
    世界监听=true
    发送网关消息(data)
  elseif data =="帮派监听开启" then
    帮派监听=true
    发送网关消息(data)
  elseif data =="门派监听开启" then
    门派监听=true
    发送网关消息(data)
  elseif data =="传闻监听开启" then
    传闻监听=true
    发送网关消息(data)
   elseif data =="门派闯关开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
   elseif data == "谁与争锋开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
    elseif data == "昆仑仙境开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
 elseif data =="清除全服刷新怪" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
  elseif data =="清除全服单位" then
  for n, v in pairs(任务数据) do
    if 任务数据[n]~=nil then
             if 任务数据[n].地图编号 and 任务数据[n].单位编号 then
              地图处理类:删除单位(任务数据[n].地图编号,任务数据[n].单位编号)
            end
            任务数据[n]=nil
    end
  end
 elseif data =="验证多开开关" then
    if 多开开关 then
  多开开关=false
  发送网关消息("验证多开已关闭~！")
else
  多开限制={}
  多开开关=true
  发送网关消息("验证多开已开启~！")
  end
 elseif data =="验证外挂开关" then
 if WPE开关 then
  WPE开关=false
  发送网关消息("验证外挂已关闭~！")
else
  WPE开关=true
  发送网关消息("验证外挂已开启~！")
  end
 elseif data =="比武大会开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
   elseif data =="全局存档" then
    保存系统数据(2)
    发送网关消息(data.."成功")
  elseif data =="清空排行数据" then
            排行榜数据={玩家伤害排行={}, 玩家速度排行={},玩家气血排行={},玩家财富排行={},玩家等级排行={},玩家仙玉排行={},玩家防御排行={},玩家灵力排行={},玩家仙玉排行={}}
              发送网关消息(string.format("%s成功",data))

elseif data =="更新所有数据" then
        保存系统数据(2)
        发送网关消息("成功")
        获取__商城数据()
        商城处理类:加载商品()
        发送网关消息("成功")
        获取__怪物属性系数()
        发送网关消息("成功")
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
        获取__商店数据()
        发送网关消息("成功")
        获取__技能消耗()
        发送网关消息("成功")
        获取__物品数据()
        获取__礼包配置数据()
        获取__抽奖数据()
        更新全局基础数据()
        获取__活动时间配置()
        获取__梦幻指引()
        获取__技能消耗()
发送网关消息("更新所有数据成功")
 elseif data =="更新怪物掉落配置" then
获取__物品奖励数据()
刷新自定义数据()
发送网关消息("更新怪物掉落物品奖励数据成功")
 elseif data =="更新所有商店" then
获取__商店数据()
发送网关消息("更新商店数据成功")
elseif data =="更新所有奖励" then
获取__礼包配置数据()
获取__抽奖数据()
发送网关消息("更新礼包配置、抽奖数据成功")
elseif data =="更新功能数据" then
更新全局基础数据()
发送网关消息("更新全局配置文件数据成功")
  elseif data =="更新所有消耗数据" then
获取__技能消耗()
发送网关消息("更新所有消耗数据成功")
elseif data =="更新梦幻指引数" then
获取__梦幻指引()
发送网关消息("更新梦幻指引数成功")
elseif data =="更新刷新怪数据" then
怪物数据= 取csv数据("其他表/怪物数据.csv")
发送网关消息("更新怪物数据成功")
elseif data =="更新灵饰类数据" then
-- PropertyData = ReadExcel("灵饰特性数据","小神授权")
发送网关消息("更新灵饰数据成功")
elseif data =="更新活动时间" then
获取__活动时间配置()
活动数据= 取csv数据("其他表/活动数据.csv")
发送网关消息("更新活动时间、活动数据成功")
elseif data =="更新怪物数据" then
获取__怪物属性系数()
怪物数据= 取csv数据("其他表/怪物数据.csv")
发送网关消息("更新怪物属性数据成功")
   elseif data =="更新装备类数据" then
发送网关消息("暂时未添加")
  elseif data =="更新宠物类数据" then
发送网关消息("暂时未添加")
elseif data =="更新技能数据" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
  elseif data =="更新商城数据" then
       获取__商城数据()
       商城处理类:加载商品()
       发送网关消息(string.format("%s成功",data))
发送网关消息("更新商城数据成功")
elseif data =="更新物品数据" then
获取__物品数据()
发送网关消息(data.."成功")
elseif data =="更新模型数据" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
  --发送网关消息("所有装扮数据成功")
elseif data =="更新神兵数据" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="更新称谓数据" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="门派闯关开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="重置副本数据" then
    重置数据()
   发送网关消息(data.."成功")
elseif data =="重置每日数据" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="更新打造数据" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
    elseif data =="更新地图数据" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="更新消耗数据" then
获取__技能消耗()
发送网关消息(data.."成功")
  elseif data =="魔化钟馗" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")

elseif data =="剑会开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="刷出星宿" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="文韵墨香开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="保卫战开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="刷出真地煞星" then
   发送网关消息("功能未添加请自行添加！或者联系874270345添加")
    -- 真地煞星刷新资源()
    -- 发送网关消息(data.."成功")
elseif data =="彩虹争霸开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="帮派迷宫开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="天降辰星开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="雁塔地宫清零" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
   elseif data =="降妖伏魔开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")

   elseif data =="游泳活动开关" then
 发送网关消息("功能未添加请自行添加！或者联系874270345添加")
elseif data =="帮派PK开关" then

else
	发送网关消息(string.format("暂无添加功能%s",data))
  发送网关消息("功能未添加请自行添加！或者联系874270345添加11")
  end
end

return 小巷子网关
