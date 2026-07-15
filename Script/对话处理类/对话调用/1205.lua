-- @Author: baidwwy
-- @Date:   2023-10-25 19:03:15
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-12-25 13:27:01
-- @Author: baidwwy
-- @Date:   2023-10-25 19:03:15
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-10-26 03:53:27
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 12:52:26
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:17
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1205]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
              if 蚩尤次数[数字id]==nil then
               蚩尤次数[数字id]={总计=0}
              end
              wb[1] = "尔等蝼蚁妄图封印我简直事痴心妄想，#G今日剩余挑战次数:#R "..5-蚩尤次数[数字id].总计..""
              local xx = {"开启挑战","我只是来看看"}
              return{"蚩尤","蚩尤元神",wb[取随机数(1,#wb)],xx}
      elseif 编号 == 2 then
              wb[1] = "上仙我可以把你传送到武神坛去挑战历届封印蚩尤的勇士镜像"
              local xx = {"我准备好了请送我们过去","我只是来看看"}
              return{"巫师","武神坛传送",wb[取随机数(1,#wb)],xx}
      elseif 编号 == 3 then
            wb[1] = "少侠来此所为何事？"
            xx = {"奉上上古之符","我来帮战神创造储备箱（组队任务）","相关帮助","随便看看"}
            return{"巫师","巫师",wb[取随机数(1,#wb)],xx}

      end
	return
end

__NPCdh222[1205 ]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
    local 名称=内容[3]
  if 名称=="武神坛传送" then
            if 事件=="我准备好了请送我们过去" then
              地图处理类:跳转地图(数字id,1206,185,45)
            end
  elseif 名称=="巫师" then
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
                     玩家数据[数字id].给予数据={类型=1,id=0,事件="上交灵符"}
                     发送数据(玩家数据[数字id].连接id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称=名称,类型="NPC",等级="无"})
                 else
                     添加最后对话(id,"蚩尤已经降临，蚩尤降临期间无法接取本任务")
                 end
             elseif 事件 == "我来帮战神创造储备箱（组队任务）" then
                 if 祈神值<蚩尤祈福值 then
                     if 玩家数据[数字id].队伍 == 0 then
                         常规提示(数字id,"#Y/请组队再来找我！")
                         return

                     else
                         -- if 取活动限制(数字id,'战神任务组队')>=20 then  --关闭限制
                         --     发送数据(玩家数据[数字id].连接id, 7, "#y/活动已上限！")
                         --     return
                         -- end
                         local 队伍id=玩家数据[数字id].队伍
                         local 通过 = false
                         for n=1,#队伍数据[队伍id].成员数据 do
                             local 临时id=队伍数据[队伍id].成员数据[n]
                             local 队长任务id = 玩家数据[数字id].角色:取任务(8931)
                             if 玩家数据[数字id].队长==false  then
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
                             设置任务8931(数字id)
                             return
                         end
                     end
                 else
                     添加最后对话(数字id,"蚩尤已经降临，蚩尤降临期间无法接取本任务")
                 end
             elseif 事件 == "相关帮助" then
                 添加最后对话(数字id,"#Y上古灵符#W：上交上古灵符增加全服祈神值\n#Y战神储备箱#W：5人组队完成的环任务（#R完成后增加全服祈神值#W）\n\n#G祈神值足够时蚩尤降临挑战开放")
             end

  elseif 名称=="蚩尤元神" then
          if 事件=="开启挑战" then
            if 蚩尤次数[数字id]==nil then
               蚩尤次数[数字id]={总计=0}
           end
          if 蚩尤次数[数字id].总计>=5 then
            常规提示(数字id,"#Y少侠今日蚩尤挑战次数已用完,明日再来挑战吧。")
            return
          end
            战斗准备类:创建战斗(数字id,155551,1)
          end
  end
end
function 胜利MOB_155555(胜利id,战斗数据,id组)
  for n=1,#id组 do
    local id=id组[n]
    if 蚩尤次数[id]==nil then
       蚩尤次数[id]={总计=0}
    end
    蚩尤次数[id].总计=蚩尤次数[id].总计+1

    local 等级 = 取队伍平均等级(玩家数据[id]["队伍"], id)
    local 经验 = qz(等级 * 等级 + 58000)
    local 银子 = 等级 * 80 + 51460
    玩家数据[id]["角色"]:添加经验(经验 * HDPZ["蚩尤元神"]["经验"], "蚩尤元神")
    玩家数据[id]["角色"]:添加银子(银子 * HDPZ["蚩尤元神"]["银子"], "蚩尤元神", 1)
    if 取随机数()<=HDPZ["蚩尤元神"].爆率 then
    local 链接 = {提示=format("#P(蚩尤元神)#Y唐王对玩家#G%s#Y的表现尤为赞赏,特赠送",玩家数据[id].角色.名称),频道="hd",结尾="#Y以资鼓励！"}
    local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["蚩尤元神"].ITEM),"蚩尤元神")
      if 数量== 9999 then --环
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
      else
        玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
      end
    end

  end



end



