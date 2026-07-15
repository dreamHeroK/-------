-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:41
-- @Last Modified by:   tangguo
-- @Last Modified time: 2025-04-12 21:52:36

local ffi = require("ffi")

function 加载内充数据()
    内充组={}
    local z=取文件夹的所有名 (程序目录..[[\自动充值]])
    for i=1,#z do
        内充组[z[i]]=true
    end
end
function 取文件夹的所有名 (path)
  local z={}
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      local f = path..'/'..file
      local attr = lfs.attributes (f)
      assert (type(attr) == "table")
      if attr.mode == "directory" then
         z[#z+1]=file
      end
    end
  end
  return z
end
加载内充数据()
function 内充系统类_CDK兑换(id,内容)
  local 人民币比例=100
  local a =nil

  for n, v in pairs(内充组) do
      local c = os.remove(程序目录..[[\自动充值\]]..n..[[\]]..内容..[[.txt]])
      if c then
          local x = 分割文本(n, "-")
        if x[1]=="累充" then
          添加累充(id,x[2],"cdk充值",1)

        elseif x[1]=="抽奖令牌" then
           玩家数据[id].道具:给予道具(id,"抽奖令牌",x[2])
           添加累充(id,x[2],"cdk充值",1)

        elseif x[1]=="仙玉" then

         添加仙玉(id,玩家数据[id].账号,x[2]*人民币比例,"cdk充值",1)
         添加累充(id,x[2],"cdk充值",1)

        elseif x[1]=="月卡" then
          if  玩家数据[id].角色.月卡 == nil then
                玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+2592000}
            elseif os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 then
                玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+2592000}
          else
                玩家数据[id].角色.月卡 = {生效=true,到期时间=玩家数据[id].角色.月卡.到期时间+2592000}
          end

          添加累充(id,100,"cdk充值",1)


          常规提示(id,"#Y激活月卡成功,月卡到期日前,每日可领取奖励物品！")
      end
         发送数据(玩家数据[id].连接id,7,"#G/充值成功！")
        return 0
      end
  end
  if a==nil then
    发送数据(玩家数据[id].连接id,7,"#G/CDK无效或已经被兑换")
  end
end



