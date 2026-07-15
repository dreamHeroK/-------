-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:39
-- @Last Modified by:   tangguo
-- @Last Modified time: 2026-05-26 21:58:04
-- @Author: baidwwy
-- @Date:   2025-04-08 18:32:39
-- @Last Modified by:   tangguo
-- @Last Modified time: 2025-04-12 21:52:35

local ffi = require("ffi")
  ffi.cdef[[
  const char* Jckh(const char *qq,const char *qq);
  const char* Jcsql();
  const char* Ydwj(const char *qq,const char *qq);
  const char* Scwj(const char *qq);
  const char* 唯一机器码();
  ]]
 随机对话={
[1]="风中吟唱，心随梦远。每当夜深人静，思绪便如潮水涌来。",
[2]="月下独酌，酒入愁肠。举杯邀月，问君何所念？",
[3]="山水有相逢，何必问归期。人生如梦，何苦执着于过往？",
[4]="一曲离殇，泪洒青衫。往事如烟，愿随风而去。",
[5]="梦回千载，缘聚缘散。岁月如歌，愿携手共赏花开。",
[6]="问君何所思，何必问归路。心中所念，皆是无形之物。",
[7]="风来云去，心随意动。浮云游子，何处是归途？",
[8]="白云苍狗，浮生若梦。且行且珍惜，莫负良辰美景。",
[9]="花间一壶酒，独酌无相亲。月明点滴，愿与君共醉。",
[10]="月明点滴，我心向明月。抬头望天，愿有明月常伴。",
[11]="不问世事，只求一醉。浮生若梦，愿随意而行。",
[12]="人生若只如初见，何必秋水共长天。回首往昔，唯愿珍惜当下。",
[13]="剑起云间，风云再起。江湖路远，愿与你共闯天涯。",
[14]="雪落无声，心事难言。每一片雪花，都是我对你的思念。",
[15]="行走天涯，何妨醉笑。笑对人生，何必在意得失。",
[16]="只愿君心似我心，定不负相思意。愿你我携手，共度这段旅程。",
[17]="千里共婵娟，月照悠悠。愿在这月光下，共叙前缘。",
[18]="归来仍是少年，笑问浮云。岁月无声，愿与你共度每一刻。",
[19]="桃花流水，春去秋来。每一季的变迁，都是生命的轮回。",
[20]="一笔画江山，风月无边。愿为你描绘这幅美丽的画卷。",
[21]="相思无尽，唯有梦中见。梦里有你，便是我心之所向。",
[22]="月下长歌，声声入耳。愿与你共唱这首动人的旋律。",
[23]="烟雨江南，情意绵绵。每一滴雨水，都承载着我的思念。",
[24]="白衣胜雪，剑指苍穹。愿在这片星空下，与你共舞。",
[25]="人生如梦，何必太认真。且行且珍惜，笑对人生。",
[26]="长风破浪，直挂云帆。人生路漫漫，愿与你同行。",
[27]="浮云游子，何处是归途。心中所念，皆是那片温暖。",
[28]="花落无声，唯有泪痕。每一滴泪水，都是我对你的思念。",
[29]="天涯海角，唯有你我。无论身在何方，心中永远有你。",
[30]="问君何所念，何必问前缘。心中有爱，便是归处。",
[31]="江湖夜雨，十年灯火。岁月如歌，愿与你共谱。",
[32]="梦里水乡，水墨丹青。愿在这幅画卷中，与你相遇。",
[33]="青山不老，绿水长存。愿与你共守这片宁静。",
[34]="一壶浊酒，千古事。每一杯酒，都是我对往事的追忆。",
[35]="月色如银，照亮归途。愿在这皎洁的月光下，与你共赏。",
[36]="浮生若梦，何必太真。且行且珍惜，愿随心而行。",
[37]="醉卧云端，笑看风云。无论风云变幻，我心永不变。",
[38]="秋水共长天，天涯共此时。愿与你共度这段美好时光。",
[39]="一生一世，唯有你我。愿与你携手，走过每一程。",
[40]="行云流水，心随意动。心中有梦，便是远方。",
[41]="天上人间，何必问归期。愿在这片星空下，与你共舞。",
[42]="月下独行，影随我舞。愿在这夜色中，与你相伴。",
[43]="千古风流，何必问英雄。愿为你守护这份温暖。",
[44]="红尘一笑，千年相伴。愿与你共叙这段细水长流。",
[45]="浮云一别，何必问归期。心中有你，便是归处。",
[46]="梦回千年，情意绵绵。愿与你共度这段美好时光。",
[47]="青山不改，绿水常流。愿与你共守这片宁静。",
[48]="月明点滴，心随梦远。每一颗星星，都是我的思念。",
[49]="白衣苍狗，浮生如梦。愿在这梦中，与你相遇。",
[50]="问君何所思，心随梦远。愿与你共赏这片星空。",
[51]="醉笑江湖，何必问归路。无论何时何地，心中永有你。",
[52]="月影摇曳，梦入千帆。愿在这梦境中，与你相伴。",
[53]="桃花流水，春去秋来。每一季的变迁，都是生命的轮回。",
[54]="一曲高歌，千古情长。愿在这旋律中，与你共舞。",
[55]="千秋大业，何必问浮云。愿与你共守这份温暖。",
[56]="天涯共此时，月照人间。愿在这片月光下，与你共叙。",
[57]="浮生若梦，何必太认真。且行且珍惜，愿随心而行。",
[58]="一壶浊酒，千古事。每一杯酒，都是我对往事的追忆。",
[59]="月下独酌，酒入愁肠。愿在这月光下，与君共饮。",
[60]="问君何所念，何必问前缘。心中有爱，便是归处。",
[61]="江湖夜雨，十年灯火。愿在这灯下，与你共叙。",
[62]="梦里水乡，水墨丹青。愿在这幅画卷中，与你相遇。",
[63]="青山不老，绿水长存。岁月如歌，愿与你共守。",
[64]="白衣胜雪，剑指苍穹。愿在这片星空下，与你共舞。",
[65]="人生如梦，何必太认真。且行且珍惜，愿随心而行。",
[66]="长风破浪，直挂云帆。人生路漫漫，愿与你同行。",
[67]="浮云游子，何处是归途。心中所念，皆是那片温暖。",
[68]="花落无声，唯有泪痕。每一滴泪水，都是我对你的思念。",
[69]="天涯海角，唯有你我。无论身在何方，心中永远有你。",
[70]="问君何所念，何必问前缘。心中有爱，便是归处。",
[71]="江湖夜雨，十年灯火。岁月如歌，愿与你共谱。",
[72]="梦里水乡，水墨丹青。愿在这幅画卷中，与你相遇。",
[73]="青山不老，绿水长存。愿与你共守这片宁静。",
[74]="一壶浊酒，千古事。每一杯酒，都是我对往事的追忆。",
[75]="月色如银，照亮归途。愿在这皎洁的月光下，与你共赏。",
[76]="浮生若梦，何必太真。且行且珍惜，愿随心而行。",
[77]="醉卧云端，笑看风云。无论风云变幻，我心永不变。",
[78]="秋水共长天，天涯共此时。愿与你共度这段美好时光。",
[79]="一生一世，唯有你我。愿与你携手，走过每一程。",
[80]="行云流水，心随意动。心中有梦，便是远方。",
[81]="天上人间，何必问归期。愿在这片星空下，与你共舞。",
[82]="月下独行，影随我舞。愿在这夜色中，与你相伴。",
[83]="千古风流，何必问英雄。愿为你守护这份温暖。",
[84]="红尘一笑，千年相伴。愿与你共叙这段细水长流。",
[85]="浮云一别，何必问归期。心中有你，便是归处。",
[86]="梦回千年，情意绵绵。愿与你共度这段美好时光。",
[87]="青山不改，绿水常流。愿与你共守这片宁静。",
[88]="月明点滴，心随梦远。每一颗星星，都是我的思念。",
[89]="白衣苍狗，浮生如梦。愿在这梦中，与你相遇。",
[90]="问君何所思，心随梦远。愿与你共赏这片星空。",
[91]="醉笑江湖，何必问归路。无论何时何地，心中永有你。",
[92]="月影摇曳，梦入千帆。愿在这梦境中，与你相伴。",
[93]="桃花流水，春去秋来。每一季的变迁，都是生命的轮回。",
[94]="一曲高歌，千古情长。愿在这旋律中，与你共舞。",
[95]="千秋大业，何必问浮云。愿与你共守这份温暖。",
[96]="天涯共此时，月照人间。愿在这片月光下，与你共叙。",
[97]="浮生若梦，何必太认真。且行且珍惜，愿随心而行。",
[98]="一壶浊酒，千古事。每一杯酒，都是我对往事的追忆。",
[99]="月下独酌，酒入愁肠。愿在这月光下，与君共饮。",
[100]="问君何所念，何必问前缘。心中有爱，便是归处。",
}
function 重置双龙挑战()
      f函数.写配置(程序目录.."特殊活动配置.ini","双龙之战","挑战难度",1)
      f函数.写配置(程序目录.."特殊活动配置.ini","双龙之战","挑战者id",0)
      f函数.写配置(程序目录.."特殊活动配置.ini","双龙之战","挑战者名称","无")
      f函数.写配置(程序目录.."特殊活动配置.ini","双龙之战","挑战阵营","无")
end
function 初始化充值()
  if 充值dll == nil then
    充值dll = ffi.load("Money.dll")
  end
 -- print(ffi.string(充值dll.Jcsql()))
  local Web = 充值dll.Jcsql()
  return ffi.string(Web)
end

function 处理充值(qq,ww)
  if 充值dll == nil then
    充值dll = ffi.load("Money.dll")
  end
  local Web = 充值dll.Jckh(qq,ww)
  return ffi.string(Web)
end

feixingdaoju={}--飞行道具
feixingdaoju[1511]=1
feixingdaoju[2010]=1
feixingdaoju[2011]=1
feixingdaoju[2012]=1
-- feixingdaoju[10041]=1
-- feixingdaoju[10051]=1
-- feixingdaoju[10061]=1
-- feixingdaoju[10071]=1
-- feixingdaoju[10081]=1
-- feixingdaoju[10901]=1
-- feixingdaoju[10091]=1
-- feixingdaoju[5005]=1
jingzhifeixing={} --禁止飞行
jingzhifeixing[10000]=1
jingzhifeixing[10001]=1
jingzhifeixing[10002]=1
jingzhifeixing[10012]=1
jingzhifeixing[10003]=1
jingzhifeixing[10013]=1
jingzhifeixing[10004]=1
jingzhifeixing[10014]=1
jingzhifeixing[10005]=1
jingzhifeixing[10015]=1
jingzhifeixing[10006]=1
jingzhifeixing[10016]=1
jingzhifeixing[10007]=1
jingzhifeixing[10017]=1
jingzhifeixing[10008]=1
jingzhifeixing[10018]=1
jingzhifeixing[1511]=1
jingzhifeixing[2010]=1
jingzhifeixing[2011]=1
jingzhifeixing[2012]=1

jingzhifeixing[10041]=1
jingzhifeixing[10051]=1
jingzhifeixing[10061]=1
jingzhifeixing[10071]=1
jingzhifeixing[10081]=1
jingzhifeixing[10901]=1
jingzhifeixing[10091]=1


for i=3000,3150 do
	jingzhifeixing[i]=1
end
anquanqu={}
anquanqu[1001]=1
anquanqu[1070]=1
anquanqu[1092]=1
anquanqu[1040]=1
anquanqu[1197]=1
anquanqu[1125]=1
anquanqu[5958]=1
anquanqu[5959]=1
anquanqu[5960]=1

每日天罡 = {}
红包文件 = {}
--整理自动排序表={红色合成旗=1,黄色合成旗=2,蓝色合成旗=3,白色合成旗=4,绿色合成旗=5,飞行符=6}
整理自动排序表={红色合成旗=1,黄色合成旗=2,蓝色合成旗=3,白色合成旗=4,绿色合成旗=5,超级合成旗=6,新春飞行符=7,摄妖香=8,洞冥草=9,飞行符=10}
商城灵宝={"断穹巨剑","静心禅珠","宁心道符","相思寒针","风舞心经","锢魂命谱","青狮獠牙","冥火炼炉","缚仙蛛丝","煞魂冥灯","九霄龙锥","化怨清莲","真阳令旗",
	"天雷音鼓","寒霜盾戟","乾坤金卷","乾坤木卷","乾坤水卷","乾坤火卷","乾坤土卷","定神仙琴","赤炎战笛","护体灵盾","惊兽云尺","战神宝典"}
钟灵石技能={"健步如飞","血气方刚","回春之术","锐不可当","心源"}

Q_中秋逐月数据 = {
   {1001,430,226,"1号月兔",1}
  ,{1193,3,74,"2号月兔",3}
  ,{1193,149,105,"3号月兔",1}
  ,{1501,270,65,"4号月兔",1}
  ,{1506,84,63,"5号月兔",1}
  ,{1092,118,87,"6号月兔",1}
  ,{1092,203,47,"7号月兔",2}
  ,{1514,142,17,"8号月兔",0}
  ,{1514,46,41,"9号月兔",2}
  ,{1174,190,90,"10号月兔",0}
  ,{1070,55,168,"11号考官月兔",1}
  ,{1091,171,61,"12号月兔",1}
  ,{1091,20,32,"13号月兔",0}
  ,{1111,62,94,"14号月兔",1}
  ,{1111,79,69,"15号月兔",0}
  ,{1111,195,57,"16号月兔",4}
  ,{1111,159,5,"17号月兔",0}
  ,{1114,115,68,"18号月兔",1}
  ,{1114,18,22,"19号月兔",0}
  ,{1114,76,21,"20号月兔",1}
  }

function 保存玩家刷怪次数数据()
    写出文件(玩家刷怪数据文件, table.tostring(玩家刷怪次数))
end

function 重置每日玩家刷怪次数()
    print("开始重置每日玩家刷怪次数...")
    玩家刷怪次数 = {}
    保存玩家刷怪次数数据()
    print("每日玩家刷怪次数重置完成")
end


-- function 重置限制次数()
--   for n,v in pairs(刷怪限制) do
--     if type(v)~="number" then
--       刷怪限制[n]={}
--     end
--   end
-- end
function 添加完成次数(数字id,活动)
        local id组={数字id}
    local 通过
    if 玩家数据[数字id].队伍~=0 then
      id组=队伍数据[玩家数据[数字id].队伍].成员数据
    end
    if not 玩家刷怪次数[活动] then
        玩家刷怪次数[活动] = {}
    end

      for n=1,#id组  do
      local id=id组[n]
      local 最大次数=刷怪限制[活动.."次数"]
      local 当前次数 = 玩家刷怪次数[活动][id] or 0
      -- local 剩余次数=最大次数-刷怪限制[活动][id]-1
      local 剩余次数 = 最大次数 - 当前次数 - 1
      if  刷怪限制[活动] then
          -- 刷怪限制[活动][id]= (刷怪限制[活动][id]  or  0)+1
          玩家刷怪次数[活动][id] = 当前次数 + 1
          常规提示(id,"#Y你今日已完成"..活动.."#Y挑战[#R"..玩家刷怪次数[活动][id].."#Y]次,#Y还可挑战[#G"..剩余次数.."#Y]次")
          -- 发送数据(玩家数据[id].连接id,38,{内容="#Y你今日已完成"..活动.."#Y挑战[#R"..刷怪限制[活动][id].."#Y]次,#Y还可挑战[#G"..剩余次数.."#Y]次",频道="xt"})
      end
    end
end
function 判断限制次数(数字id,活动)
  local id组={数字id}
  local 通过
  if 玩家数据[数字id].队伍~=0 then
    id组=队伍数据[玩家数据[数字id].队伍].成员数据
  end
   for n=1,#id组  do
      local id=id组[n]
      if not 玩家刷怪次数[活动] then
            玩家刷怪次数[活动] = {}
        end
        local 当前次数 = 玩家刷怪次数[活动][id] or 0
        local 最大次数 = 刷怪限制[活动.."次数"] or 10

    if  刷怪限制[活动] then
        刷怪限制[活动][id]= 刷怪限制[活动][id]  or  0
              -- if  刷怪限制[活动][id]>=刷怪限制[活动.."次数"]  then
              if 当前次数 >= 最大次数 then
          通过=玩家数据[id].角色.名称
          break
     end
    end
  end

  return 通过
end

function 验证数字(数字)
  if 数字 == nil or tonumber(数字) == nil or  math.floor(数字) ~= tonumber(数字) or  tonumber(数字) < 0 then
    return false
  end
  return true
end

function 取随机玄灵珠()
  local abc={"玄灵珠·回春","玄灵珠·破军","玄灵珠·空灵","玄灵珠·噬魂"}
  local fhmc = abc[取随机数(1,4)]
  return fhmc
end

function 开通十八路妖王(id,目标)
  local 门票 = 0
   if 目标 == "黄风怪" then
    门票 = 2
  elseif 目标 == "白骨精" then
    门票 = 4
  elseif 目标 == "狮猁怪" then
    门票 = 6
  elseif 目标 == "眼魔君" then
    门票 = 8
  elseif 目标 == "蝎子精" then
    门票 = 10
  elseif 目标 == "红孩儿" then
    门票 = 12
  elseif 目标 == "六耳猕猴" then
    门票 = 14
  elseif 目标 == "玉兔精" then
    门票 = 16
  elseif 目标 == "独角兕大王" then
    门票 = 18
  elseif 目标 == "混世魔王" then
    门票 = 20
  elseif 目标 == "黑风怪" then
    门票 = 22
  elseif 目标 == "九尾狐狸" then
    门票 = 30
  elseif 目标 == "妖王之主" then
    门票 = 50
  end
   --if 门票==0 then
   --   return
   --end
   if not  玩家数据[id].道具:消耗背包道具(连接id,id,"斩妖帖",门票) then
          常规提示(id,"#Y/开通位面需要"..门票.."斩妖帖!")
   else
          玩家数据[id].角色.十八路妖王[目标]=1
          地图处理类:跳转地图(id, 取十二地图(目标), 43, 20)
          常规提示(id,"#Y/活动通道已打开!")
          玩家数据[id].角色:刷新信息("1")
   end
end
function 取十二地图(id)
  if id == "黄风怪" then
    return 5145
  elseif id == "白骨精"then
    return 5146
  elseif id == "狮猁怪" then
    return 5147
  elseif id == "眼魔君" then
    return 5148
  elseif id == "蝎子精" then
    return 5149
  elseif id == "红孩儿" then
    return 5150
  elseif id == "六耳猕猴" then
    return 5151
  elseif id == "玉兔精" then
    return 5152
  elseif id == "独角兕大王" then
    return 5153
  elseif id == "混世魔王" then
    return 5154
  elseif id == "黑风怪" then
    return 5155
  elseif id == "九尾狐狸" then
    return 5156
  elseif id == "妖王之主" then
    return 5157
  end
end
function 刷新妖王排行(id,类型,数额)
  local 原数据={}
  local 原编号
  if 十八路妖王[类型]==nil then 十八路妖王[类型]={} end
  for i=1,#十八路妖王[类型] do
    if 十八路妖王[类型][i].ID==id then
      十八路妖王[类型][i].积分=十八路妖王[类型][i].积分+数额
      原编号=0
      if i~=1 then
        原数据=DeepCopy(十八路妖王[类型][i])
        原编号=i
        table.remove(十八路妖王[类型],i)
      end
      break
    end
  end
  if 原编号 and 原编号 ~= 0 then
    for i=原编号-1,1,-1 do
      if 原数据.积分 < 十八路妖王[类型][i].积分 then
        table.insert(十八路妖王[类型],i+1,原数据)
        break
      elseif i==1 then
        table.insert(十八路妖王[类型],i,原数据)
        break
      end
    end
  elseif 原编号==nil then
    十八路妖王[类型][#十八路妖王[类型]+1]={积分=数额,名称=玩家数据[id].角色.名称,ID=id,等级=玩家数据[id].角色.等级,门派=玩家数据[id].角色.门派,模型=玩家数据[id].角色.模型}
  end
end

function 取附灵需扣经验(sss) --改这客户端也要改
  local data = {50000000,500000000,700000000,800000000,1000000000,1000000000}
  if not data[sss] then
    return 9999999999999
  end
  return data[sss]
end

function formatTable(t, indent)
    indent = indent or 1
    local arrayIndent = string.rep("    ", indent - 1)
    local result = "{"

    local array = {}
    local hash = {}
    local maxIndex = 0
    for k, v in pairs(t) do
        if type(k) == "number" and k == math.floor(k) and k > 0 then
            array[k] = v
            maxIndex = math.max(maxIndex, k)
        else
            table.insert(hash, {k = k, v = v})
        end
    end

    local hasElements = false
    local arrayElements = {}
    -- 处理30个连续索引的道具，避免索引断裂
    for i = 1, maxIndex do
        local v = array[i]
        if v ~= nil then
            hasElements = true
            local elemStr = arrayIndent .. "[" .. i .. "] = {"
            -- 拼接子表键值对（紧凑一行）
            local hashStr = ""
            for _, pair in ipairs(hash) do
                local k, v = pair.k, pair.v
                if type(k) == "string" then
                    hashStr = hashStr .. k .. " = "
                else
                    hashStr = hashStr .. "[" .. tostring(k) .. "] = "
                end
                if type(v) == "string" then
                    hashStr = hashStr .. '"' .. v .. '"'
                else
                    hashStr = hashStr .. tostring(v)
                end
                hashStr = hashStr .. ", "
            end
            -- 拼接道具自身的键值对
            for k, v in pairs(v) do
                if type(k) == "string" then
                    elemStr = elemStr .. k .. " = "
                else
                    elemStr = elemStr .. "[" .. tostring(k) .. "] = "
                end
                if type(v) == "string" then
                    elemStr = elemStr .. '"' .. v .. '"'
                else
                    elemStr = elemStr .. tostring(v)
                end
                elemStr = elemStr .. ", "
            end
            -- 去掉末尾多余的", "，添加闭合}
            elemStr = elemStr:sub(1, -3) .. "}"
            table.insert(arrayElements, elemStr)
        end
    end

    -- 拼接所有道具，避免多余逗号
    if #arrayElements > 0 then
        result = result .. "\n" .. table.concat(arrayElements, ",\n")
    end

    -- 闭合最外层表
    result = result .. "\n" .. arrayIndent .. "}"
    return result
end

-- function formatTable(t, indent)
--     indent = indent or 1
--     -- 数组元素的缩进（如[1] = ... 所在行的缩进）
--     local arrayIndent = string.rep("    ", indent - 1)
--     local result = "{"  -- 表开始

--     -- 分离数组部分（整数键）和哈希部分（字符串键）
--     local array = {}
--     local hash = {}
--     local maxIndex = 0

--     for k, v in pairs(t) do
--         if type(k) == "number" and k == math.floor(k) and k > 0 then
--             array[k] = v
--             maxIndex = math.max(maxIndex, k)
--         else
--             table.insert(hash, {k = k, v = v})
--         end
--     end

--     local hasElements = false  -- 标记是否有元素

--     -- 处理数组部分（每个[1]、[2]等单独占一行）
--     for i = 1, maxIndex do
--         local v = array[i]
--         if v ~= nil then
--             hasElements = true
--             -- 数组元素行开头：缩进 + [n] =
--             result = result .. "\n" .. arrayIndent .. "[" .. i .. "] = "
--             if type(v) == "table" then
--                 -- 递归处理子表（道具详情），子表内部不换行
--                 result = result .. formatTable(v, indent + 1)
--             else
--                 result = result .. tostring(v)
--             end
--             result = result .. ","  -- 每个道具行结尾加逗号（最后会处理多余的）
--         end
--     end

--     -- 处理哈希部分（子表内的键值对，紧凑拼接不换行）
--     local hashStr = ""
--     for _, pair in ipairs(hash) do
--         local k, v = pair.k, pair.v
--         hasElements = true
--         -- 键处理
--         if type(k) == "string" then
--             hashStr = hashStr .. k .. " = "
--         else
--             hashStr = hashStr .. "[" .. tostring(k) .. "] = "
--         end
--         -- 值处理
--         if type(v) == "table" then
--             hashStr = hashStr .. formatTable(v, indent + 1)
--         else
--             if type(v) == "string" then
--                 hashStr = hashStr .. '"' .. v .. '"'
--             else
--                 hashStr = hashStr .. tostring(v)
--             end
--         end
--         hashStr = hashStr .. ", "  -- 键值对之间用逗号+空格分隔
--     end
--     -- 去掉末尾多余的", "
--     if hashStr ~= "" then
--         hashStr = hashStr:sub(1, -3)
--     end
--     result = result .. hashStr  -- 拼接子表内容

--     -- 处理表结束符：去掉换行，直接拼接"}"
--     result = result .. "}"  -- 关键修改：子表的"}"直接跟在内容后，不换行

--     -- 去掉数组部分最后一个多余的逗号（如果有）
--     if hasElements and #array > 0 then
--         -- 找到最后一个逗号的位置并删除
--         local lastComma = result:find(",[^,]*$")  -- 匹配末尾的逗号
--         if lastComma then
--             result = result:sub(1, lastComma - 1) .. result:sub(lastComma + 1)
--         end
--     end

--     -- 最外层表的结束符（与开头的"{"对齐）
--     if indent == 1 then  -- 只有最外层表需要在结束时换行对齐
--         result = result .. "\n" .. arrayIndent .. "}"
--     end

--     return result
-- end


function 排序整理(名称)
    local 排序 = 100
    if 整理自动排序表[名称] then
        排序 = 整理自动排序表[名称]
    else
        排序 = string.byte(string.sub(名称, 1, 2))
        if string.len(名称) >= 4 then
            排序 = 排序 + string.byte(string.sub(名称, 3, 4))
        end
        排序 = 排序 + string.len(名称)
        排序 = 排序 + 0
    end
    return 排序
end
function table.contains(t, value)----------佬伍修改（增加种族秘境时空之钥）
    for _, v in ipairs(t) do
        if v == value then
            return true
        end
    end
    return false
end
function table.fillNum(m,n)
    local j,k
    if n then
       j=m
       k=n
    else
        j=1
        k=m
    end
    local t={}
    for i=j,k do
        table.insert(t,i)
    end
    return t

end

-- function 取可否叠加(道具,道具1,手动)
--   	if 道具==nil or 道具1==nil then
--       	return false
--   	elseif type(道具) ~= "table" or type(道具1) ~= "table" then
--       	return false
--   	elseif 道具.名称 ~= 道具1.名称 then
--       	return false
--   	elseif 道具.数量 == nil or 道具1.数量 == nil then
--       	return false
--     elseif (道具.不可交易 and not 道具1.不可交易) or (not 道具.不可交易 and 道具1.不可交易)  then
--     	return false
--     elseif (道具.专用 or 道具1.专用) and 手动 and 道具.数量 and 道具1.数量 then
--     	道具.专用=true
--     	道具1.专用=true
--     	return true
--     elseif 道具.专用 and 道具1.专用 and 道具.数量 and 道具1.数量 then
--     	return true
--     elseif (道具.专用 and not 道具1.专用) or (not 道具.专用 and 道具1.专用)  then
--     	return false
--   	end
--   	for i,v in pairs(道具) do
--       	if i ~= "识别码" and i ~= "数量" and v ~= nil  and 道具1[i] ~= nil and  i ~= "不可交易" and type(v) ~= "table" and v ~= 道具1[i] then
--         	return false
--       	end
--   	end
--   	for i,v in pairs(道具1) do
--       	if i ~= "识别码" and i ~= "数量" and v ~= nil  and 道具[i] ~= nil and  i ~= "不可交易" and type(v) ~= "table" and v ~= 道具[i] then
--         	return false
--       	end
--   	end
--   	return true
-- end
function 取可否叠加(道具,道具1,手动)
    if 道具==nil or 道具1==nil then
        return false
    elseif type(道具) ~= "table" or type(道具1) ~= "table" then
        return false
    elseif 道具.名称 ~= 道具1.名称 then
        return false
    elseif 道具.数量 == nil or 道具1.数量 == nil then
        return false
    elseif (道具.不可交易 and not 道具1.不可交易) or (not 道具.不可交易 and 道具1.不可交易)  then
      return false
    end

    -- 特殊处理：九转金丹的阶品相同才可叠加
    if 道具.名称 == "九转金丹" and 道具1.名称 == "九转金丹" then
        -- 获取阶品信息
        local 阶品1 = 道具.参数 and 道具.参数.阶品 or 道具.阶品
        local 阶品2 = 道具1.参数 and 道具1.参数.阶品 or 道具1.阶品

        -- 如果没有阶品信息，默认可以叠加（兼容旧数据）
        if 阶品1 == nil or 阶品2 == nil then
            -- 可以返回true让它们叠加，或者返回false阻止叠加
            -- 根据你的需求选择
            -- 这里假设没有阶品信息的九转金丹可以互相叠加
        elseif 阶品1 ~= 阶品2 then
            return false
        end
    end

    -- 专用判断
    if (道具.专用 or 道具1.专用) and 手动 and 道具.数量 and 道具1.数量 then
        道具.专用=true
        道具1.专用=true
        return true
    elseif 道具.专用 and 道具1.专用 and 道具.数量 and 道具1.数量 then
        return true
    elseif (道具.专用 and not 道具1.专用) or (not 道具.专用 and 道具1.专用)  then
        return false
    end

    for i,v in pairs(道具) do
        if i ~= "识别码" and i ~= "数量" and v ~= nil  and 道具1[i] ~= nil and  i ~= "不可交易" and type(v) ~= "table" and v ~= 道具1[i] then
          return false
        end
    end
    for i,v in pairs(道具1) do
        if i ~= "识别码" and i ~= "数量" and v ~= nil  and 道具[i] ~= nil and  i ~= "不可交易" and type(v) ~= "table" and v ~= 道具[i] then
          return false
        end
    end
    return true
end






function 处理间隔(id)
	if 玩家数据[id].间隔 and os.time() < 玩家数据[id].间隔 then
		常规提示(id,"#Y/请不要频繁进行此操作")
		return true
	end
	玩家数据[id].间隔 = os.time() + 2
	return false
end



function math.randomEx(m,n,cnt) --方法2
    local tmp=table.fillNum(m,n)
    if cnt>n-m+1 then
        return tmp
    end
    local x=0
    local t={}
    math.randomseed(os.time())
    while  cnt>0 do
       x=math.random(1,n-m+1)
       table.insert(t,tmp[x])
       table.remove(tmp,x)
       cnt=cnt-1
       m=m+1

    end
    return t
end

function ReadFile(fileName)
  fileName = 程序目录 .. fileName
  local f = assert(io.open(fileName, 'r'))
  local content = f:read("*all")
  f:close()
  return content
end

function WriteFile(fileName, content)
  fileName = 程序目录 .. fileName
  local f = assert(io.open(fileName, 'w'))
  f:write(content)
  f:close()
end

function 取飞行坐骑限制(id)
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
    常规提示(id,"只有队长才可以使用飞行功能")
    return false
  end
  local map=玩家数据[id].角色.地图数据.编号
  if jingzhifeixing[map] then
    常规提示(id,"#Y/此场景无法使用飞行功能") --测试模式
    return false
  end
  return true
end

function 取安全区(id)
	local map=玩家数据[id].角色.地图数据.编号
	if jingzhifeixing[map] or anquanqu[map] then
		return true
	end
	return false
end

function 首席初始化()
	local sxsj = {
		[1] = {模型="飞燕女",名称 ="女儿村大弟子",称谓 ="首席弟子",地图编号=1142,x=19.8,y=24,方向=0,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="女儿村"},
		[2] = {模型="英女侠",名称 ="神木林大弟子",称谓 ="首席弟子",地图编号=1138,x=49.5,y=105.5,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="神木林"},
		[3] = {模型="巫蛮儿",名称 ="大唐官府大弟子",称谓 ="首席弟子",地图编号=1198,x=90,y=62,方向=0,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="大唐官府"},
		[4] = {模型="逍遥生",名称 ="化生寺大弟子",称谓 ="首席弟子",地图编号=1002,x=49,y=65,方向=1,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="化生寺"},
		[5] = {模型="剑侠客",名称 ="方寸山大弟子",称谓 ="首席弟子",地图编号=1135,x=67,y=66,方向=1,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="方寸山"},
		[6] = {模型="狐美人",名称 ="盘丝洞大弟子",称谓 ="首席弟子",地图编号=1513,x=179,y=30,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="盘丝洞"},
		[7] = {模型="骨精灵",名称 ="无底洞大弟子",称谓 ="首席弟子",地图编号=1139,x=60,y=124,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="无底洞"},
		[8] = {模型="杀破狼",名称 ="狮驼岭大弟子",称谓 ="首席弟子",地图编号=1131,x=119,y=77,方向=1,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="狮驼岭"},
		[9] = {模型="巨魔王",名称 ="魔王寨大弟子",称谓 ="首席弟子",地图编号=1512,x=99,y=23,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="魔王寨"},
		[10] = {模型="虎头怪",名称 ="阴曹地府大弟子",称谓 ="首席弟子",地图编号=1122,x=41.2,y=63,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="阴曹地府"},
		[11] = {模型="舞天姬",名称 ="普陀山大弟子",称谓 ="首席弟子",地图编号=1140,x=8,y=9,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="普陀山"},
		[12] = {模型="玄彩娥",名称 ="天宫大弟子",称谓 ="首席弟子",地图编号=1111,x=160,y=112,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="天宫"},
		[13] = {模型="羽灵神",名称 ="凌波城大弟子",称谓 ="首席弟子",地图编号=1150,x=33.5,y=68,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="凌波城"},
		[14] = {模型="神天兵",名称 ="五庄观大弟子",称谓 ="首席弟子",地图编号=1146,x=35.6,y=49.4,方向=4,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="五庄观"},
		[15] = {模型="龙太子",名称 ="龙宫大弟子",称谓 ="首席弟子",地图编号=1116,x=94,y=68,方向=1,染色方案=nil,染色组={},炫彩=nil,炫彩组={},武器=nil,门派="龙宫"}
	}
	__S服务:输出("首席初始化完毕")
end



function 广播帮派消息(消息,帮派编号)
	for n, v in pairs(玩家数据) do
		if 玩家数据[n].管理 == nil and 玩家数据[n].角色.BPBH==帮派编号 then
			发送数据(玩家数据[n].连接id,38,消息)
		end
	end
end

function 广播所有帮派消息(消息)
  for n, v in pairs(玩家数据) do
    if 玩家数据[n].管理 == nil and 玩家数据[n].角色.BPBH~=nil then
        发送数据(玩家数据[n].连接id,38,消息)
    end
  end
end

function 取文件的所有名 (path)
  local z={}
  for file in lfs.dir(path) do
    local x = 分割文本(file, ".")
     if x[2]=="txt" then
         z[#z+1]=x[1]
        end
  end
  return z
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
function 加载内充数据()
    内充组={}
    local z=取文件夹的所有名 (程序目录..[[\自动充值]])
    for i=1,#z do
        内充组[z[i]]=true
    end
end
function 刷新自定义数据()--
  加载自定义爆率数据()
  --商店处理类:更新商店价格数据()
  if 验证数据 then
    __S服务:输出("所有数据检测完毕请输入@kqsjyz关闭自检命令")
  end
end

function 加载自定义爆率数据()
  local 自定义文件名 = 取文件的所有名 (程序目录..[[\物品爆率\]])
   for n=1,#自定义文件名 do
    local 数据正常= true
    if 验证数据 then
        __S服务:输出("自定义数据("..自定义文件名[n]..")加载中")
     end
     local 代码函数=loadstring(读入文件([[物品爆率\]]..自定义文件名[n]..".txt"))
     if 代码函数~=nil then
      代码函数()
       if 验证数据 then
         if 自定义文件名[n]=="铜矿" or 自定义文件名[n]=="银矿" or 自定义文件名[n]=="翡翠矿" or 自定义文件名[n]=="黄金矿" or 自定义文件名[n]=="紫金矿"   then
            for i=1,#自定义数据[自定义文件名[n]] do
                for k=1,#自定义数据[自定义文件名[n]][i] do
                   if 自定义数据[自定义文件名[n]][i][k].名称==nil  then
                       数据正常 =false
                    else
                       if type(自定义数据[自定义文件名[n]][i][k].名称)~="string" then
                         数据正常 =false
                       end
                    end
                    if 自定义数据[自定义文件名[n]][i][k].数量==nil  then
                       数据正常 =false
                    else
                       if type(自定义数据[自定义文件名[n]][i][k].数量)~="table" then
                         数据正常 =false
                       end
                    end
                    if 自定义数据[自定义文件名[n]][i][k].概率==nil  then
                       数据正常 =false
                    else
                       if type(自定义数据[自定义文件名[n]][i][k].概率)~="number" then
                         数据正常 =false
                       end
                    end
                end
            end
       else
            for i=1,#自定义数据[自定义文件名[n]] do
               if 自定义数据[自定义文件名[n]][i].名称==nil  then
                   数据正常 =false
                else
                   if type(自定义数据[自定义文件名[n]][i].名称)~="string" then
                      数据正常 =false
                    end
                end
                if 自定义数据[自定义文件名[n]][i].数量==nil  then
                    数据正常 =false
                 else
                    if type(自定义数据[自定义文件名[n]][i].数量)~="table" then
                       数据正常 =false
                    end
                 end
                 if 自定义数据[自定义文件名[n]][i].概率==nil  then
                     数据正常 =false
                 else
                     if type(自定义数据[自定义文件名[n]][i].概率)~="number" then
                        数据正常 =false
                    end
                 end
            end
          end
          if 数据正常 then
             __S服务:输出("自定义数据("..自定义文件名[n]..")加载完成")
           end
       end
     end
   end
end
-- function 广播祝福(消息,祝福)
-- 	for n, v in pairs(玩家数据) do
-- 		if 玩家数据[n].连接id ~= "假人" then
-- 			 玩家数据[n].角色:添加经验(100000,"广播祝福")
-- 			发送数据(玩家数据[n].连接id,230,{地址=点歌地址[消息],祝福=祝福})
-- 		end
-- 	end
-- end
-- function 取房屋编号(数字id)
-- 	if 玩家数据[数字id].角色.姻缘.婚姻 then
-- 		数字id = 玩家数据[数字id].角色.姻缘.房屋所属ID
-- 	end
-- 	for i=1,#房屋数据 do
-- 		if not 房屋数据[i].注销 and 房屋数据[i].ID == 数字id then
-- 			return i
-- 		end
-- 	end
-- 	return 0
-- end

-- function 取地图ID房屋编号(地图ID)
-- 	for i=1,#房屋数据 do
-- 		if not 房屋数据[i].注销 and (房屋数据[i].庭院ID == 地图ID or  房屋数据[i].房屋ID == 地图ID or  房屋数据[i].阁楼ID == 地图ID or  房屋数据[i].牧场ID == 地图ID ) then
-- 			return i
-- 		end
-- 	end
-- 	return 0
-- end

function 修炼等级(dj,id)
	if dj <= 80 then
		return 9
	elseif dj >= 80 and dj <= 100 then
		 return 13
	elseif dj >= 100 and dj <= 110 then
		return 17
	elseif dj >= 120 and dj <= 144 then
		if  玩家数据[id].角色.历劫.飞升 then
			return 21
		else
		  	return 20
		end
	elseif dj >= 145 then
		return 25
	end
	return 20
end

function 取任务id(id)
	local 任务id=0
	for n, v in pairs(任务数据) do
		if 任务数据[n]~=nil and 任务数据[n].类型==id then
			任务id=n
		end
	end
	return 任务id
end

function 取任务id表(id)
	local 任务id={}
	for n, v in pairs(任务数据) do
		if 任务数据[n]~=nil and 任务数据[n].类型==id then
			任务id[#任务id+1]=n
		end
	end
	return 任务id
end

function 重置梦幻指引()
	local 临时表 = {}
    for i,v in pairs(梦幻指引) do
		if 临时表[梦幻指引[i].类型] == nil then
			临时表[梦幻指引[i].类型] = {}
		end
		if 梦幻指引[i].星期 == "全天" then
			临时表[梦幻指引[i].类型][梦幻指引[i].名称]={名称=梦幻指引[i].名称,星级=梦幻指引[i].星级,活跃=梦幻指引[i].活跃,最大次数=梦幻指引[i].最大次数,素材=梦幻指引[i].资源,地址=tonumber(梦幻指引[i].地址)}
		else
	    	if os.date("%a",os.time()) == 梦幻指引[i].星期 then
	    		临时表[梦幻指引[i].类型][梦幻指引[i].名称]={名称=梦幻指引[i].名称,星级=梦幻指引[i].星级,活跃=梦幻指引[i].活跃,最大次数=梦幻指引[i].最大次数,素材=梦幻指引[i].资源,地址=tonumber(梦幻指引[i].地址)}
	    	end
		end
	end
	梦幻指引=临时表
end

-- 更新玩家每日(id,"日常任务","黑无常抓鬼")
function 更新玩家每日(数字id,分类,子类)
	if 每日任务[数字id]==nil then
	    每日任务[数字id]={日常任务={},副本任务={},活跃度={当前=0,总活跃=0},签到数据={}}
	end
	if 每日任务[数字id][分类][子类] == nil then
		每日任务[数字id][分类][子类] = 1
	else
		if 每日任务[数字id][分类][子类] < 梦幻指引[分类][子类].最大次数 then
			每日任务[数字id][分类][子类] = 每日任务[数字id][分类][子类] +1
			if 每日任务[数字id][分类][子类]==梦幻指引[分类][子类].最大次数 then --刚好等于多少次给活跃时增加活跃度
				local hy=梦幻指引[分类][子类].活跃
				每日任务[数字id].活跃度.当前=每日任务[数字id].活跃度.当前+hy
			    每日任务[数字id].活跃度.总活跃=每日任务[数字id].活跃度.总活跃+hy
			    -- 发送数据(玩家数据[数字id].连接id,38,{内容="#Y你获得了#R"..hy.."#Y点活跃度",频道="xt"})
			end
		end
	end
end

-- 更新玩家每日(id,"日常任务","黑无常抓鬼")
function 更新玩家每日1(数字id,分类,子类)
  if 每日任务[数字id]==nil then
      每日任务[数字id]={日常任务={},副本任务={},活跃度={当前=0,总活跃=0},签到数据={}}
  end
  if 每日任务[数字id][分类][子类] == nil then
    每日任务[数字id][分类][子类] = 1
    -- 修复：首次也要加活跃度
    每日任务[数字id].活跃度.当前 = 每日任务[数字id].活跃度.当前 + 1
    每日任务[数字id].活跃度.总活跃 = 每日任务[数字id].活跃度.总活跃 + 1
  else
    if 每日任务[数字id][分类][子类] < 200 then
      每日任务[数字id][分类][子类] = 每日任务[数字id][分类][子类] + 1
      每日任务[数字id].活跃度.当前 = 每日任务[数字id].活跃度.当前 + 1
      每日任务[数字id].活跃度.总活跃 = 每日任务[数字id].活跃度.总活跃 + 1
    end
  end
end



function 取每日限制(数字id,子类)
	for k,v in pairs(梦幻指引) do
		for i,o in pairs(梦幻指引[k]) do
			if i == 子类 then
				if 每日任务[数字id][k][i] and 每日任务[数字id][k][i] >= 梦幻指引[k][i].最大次数 then
					return  false
				end
			end
		end
	end
	return  true
end

function 取每日是否重置(数字id,子类)
	for k,v in pairs(梦幻指引) do
		for i,o in pairs(梦幻指引[k]) do
			if i == 子类 and (每日任务[数字id][k]==nil or 每日任务[数字id][k][i]==nil)then
				return  true
			end
		end
	end
	return  false
end

function 随机珍珠等级()
	local fhz = {100,110,120}
	return fhz[取随机数(1,#fhz)]
end

function 随机珍珠等级2()
	local fhz = {130,140,150}
	return fhz[取随机数(1,#fhz)]
end

-- function 取物品叠加上限(名称)
-- 	-- if 名称 == "神兜兜" then
-- 	-- 	return 9999
-- 	-- elseif 名称 == "圣珠之青龙" then
--  --    	return 999
-- 	-- end
-- 	return 99
-- end

function 判断房屋主人(编号,数字id)
	-- for i=1,#房屋数据 do
	-- 	if not 房屋数据[i].注销 then
	-- 		if 房屋数据[i].房屋ID == 编号 or 房屋数据[i].庭院ID == 编号 then
	-- 			if 房屋数据[i].ID == 数字id then
	-- 				return true
	-- 			else
	-- 				if 玩家数据[n].角色.姻缘.配偶 ~= nil and 玩家数据[n].角色.姻缘.配偶 == 数字id then
	-- 					return true
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end
	return  false
end

function 判断庭院主人(编号,数字id)
	-- for i=1,#房屋数据 do
	-- 	if  not 房屋数据[i].注销 and 房屋数据[i].庭院ID == 编号 then
	-- 		if 房屋数据[i].ID == 数字id then
	-- 			return true
	-- 		else
	-- 			if 玩家数据[n].角色.姻缘.配偶 ~= nil and 玩家数据[n].角色.姻缘.配偶 == 数字id then
	-- 				return true
	-- 			end
	-- 		end
	-- 	end
	-- end
	return  false
end

function 判断室内主人(编号,数字id)
	for i=1,#房屋数据 do
		if  not 房屋数据[i].注销 and 房屋数据[i].房屋ID == 编号 then
			if 房屋数据[i].ID == 数字id then
				return true
			else
				if 玩家数据[n].角色.姻缘.配偶 ~= nil and 玩家数据[n].角色.姻缘.配偶 == 数字id then
					return true
				end
			end
		end
	end
	return  false
end

function 发送公告(消息)
	for n, v in pairs(玩家数据) do
		发送数据(玩家数据[n].连接id,59,消息)
	end
end

function 发送传音(消息)
	for n, v in pairs(玩家数据) do
		发送数据(玩家数据[n].连接id,77,消息)
	end
end

function 闪烁消息(id,内容)
	if 消息数据[id]==nil then
		消息数据[id]={}
	end
	消息数据[id][#消息数据[id]+1]={名称="系统提示",类型=3,模型="系统",内容=内容,id=4000501,时间=时间转换1(os.time()),等级=999,好友度=10000}
 	好友消息类:更新消息通知(id)
 end

function 广播系统消息(内容)
	__协程:回调事件("协程广播系统消息",nil,内容)
end

function 常规提示(id,内容)
	if 玩家数据[id] == nil then
	else
		发送数据(玩家数据[id].连接id,7,"#Y/"..内容)
	end
end


function 消息提示(id,消息)
	if 玩家数据[id] == nil then
	else
		发送数据(玩家数据[id].连接id,38,{内容=消息,频道="xx"})
	end
end

function 链接消息提示(id,消息,超链接)
	if 玩家数据[id] == nil then
	else
		发送数据(玩家数据[id].连接id,38,{内容=消息,方式=1,频道="xx",超链接=超链接})
	end
end

function 广播消息(消息)
	for n, v in pairs(玩家数据) do
		发送数据(玩家数据[n].连接id,38,消息)
	end
end

function 时辰函数()
	-- 时辰信息={当前=1,刷新=120,起始=os.time(),昼夜=1} 111111
	if os.time()-时辰信息.起始>=时辰信息.刷新 then
		时辰信息.起始=os.time()
		时辰信息.当前=时辰信息.当前+1
		if 时辰信息.当前==13 then
			时辰信息.当前=1
		end
		if 时辰信息.当前 > 3 and 时辰信息.当前 <= 9 then
			时辰信息.昼夜=2
		else
		    时辰信息.昼夜=1
		end
		if 时辰信息.当前 == 1 then
		   时辰信息.天气 = math.random(0,3)
		   	for n, v in pairs(玩家数据) do--发送时辰更换
				if 玩家数据[n] and not 玩家数据[n].离线摆摊 and 玩家数据[n].连接id then
				    发送数据(玩家数据[n].连接id,433,时辰信息.天气)
				    发送数据(玩家数据[n].连接id,11,时辰信息.当前)
				    发送数据(玩家数据[n].连接id,43,时辰信息.昼夜)
				end
			end
		elseif 时辰信息.当前 == 4 then
			for n, v in pairs(玩家数据) do--发送时辰更换
				if 玩家数据[n] and not 玩家数据[n].离线摆摊 and 玩家数据[n].连接id then
				    发送数据(玩家数据[n].连接id,433,时辰信息.天气)
				    发送数据(玩家数据[n].连接id,11,时辰信息.当前)
				    发送数据(玩家数据[n].连接id,43,时辰信息.昼夜)
				end
			end
       	elseif 时辰信息.当前 == 8 then
	   	  	时辰信息.天气 = math.random(0,3)
			for n, v in pairs(玩家数据) do--发送时辰更换
				if 玩家数据[n] and not 玩家数据[n].离线摆摊 and 玩家数据[n].连接id then
				    发送数据(玩家数据[n].连接id,433,时辰信息.天气)
				    发送数据(玩家数据[n].连接id,11,时辰信息.当前)
				    发送数据(玩家数据[n].连接id,43,时辰信息.昼夜)
				end
			end
       	elseif 时辰信息.当前 == 12 then
	   	  	时辰信息.天气 = math.random(0,3)
			for n, v in pairs(玩家数据) do--发送时辰更换
				if 玩家数据[n] and not 玩家数据[n].离线摆摊 and 玩家数据[n].连接id then
				    发送数据(玩家数据[n].连接id,433,时辰信息.天气)
				    发送数据(玩家数据[n].连接id,11,时辰信息.当前)
				    发送数据(玩家数据[n].连接id,43,时辰信息.昼夜)
				end
			end
		else
			for n, v in pairs(玩家数据) do--发送时辰更换
				if 玩家数据[n] and not 玩家数据[n].离线摆摊 and 玩家数据[n].连接id then
				    发送数据(玩家数据[n].连接id,433,时辰信息.天气)
				    发送数据(玩家数据[n].连接id,11,时辰信息.当前)
				    发送数据(玩家数据[n].连接id,43,时辰信息.昼夜)
				end
			end
			return
		end
		if 时辰信息.天气==0 then
		   广播消息({内容="现在开始天晴了".."#"..取随机数(1,110),频道="xt"})
		   -- 发送公告("#R(天气系统)".."#Y/天朗气清，惠风和畅（天晴了)")
	    elseif 时辰信息.天气==1 then
	        广播消息({内容="现在开始起风了".."#"..取随机数(1,110),频道="xt"})
		    -- 发送公告("#R(天气系统)".."#Y/凤鸣两岸叶，月照一孤舟（起风了）")
	    elseif 时辰信息.天气==2 then
	        广播消息({内容="现在开始下雨了".."#"..取随机数(1,110),频道="xt"})
		    -- 发送公告("#R(天气系统)".."#Y/夜阑卧听风吹雨，铁马冰河入梦来（下雨了）")
	    elseif 时辰信息.天气==3 then
	        广播消息({内容="现在开始下雪了".."#"..取随机数(1,110),频道="xt"})
		    -- 发送公告("#R(天气系统)".."#Y/忽如一夜春风来，千树万树梨花开（下雪了）")
	    end
	end
end

function 发送数据(id,序号,内容,封装)
	local fssj={}
	if id==nil or id == "小伙伴" or id =="zhuzhan" then return  end
	if id==888888 or id=="假人" or id=="zhuzhan"  then return  end
	if 内容==nil then 内容="1" end
	if 封装==nil then
		if not 总控客户信息[id+0] then
			return
		end
		fssj={序号=序号,内容=内容}
		if 总控客户信息[id+0].类别 == "PC" then
			__S服务:发送(服务端参数.PC网关id,总控客户信息[id+0].ID,table.tostring(fssj))
		else
			__安卓通信:发送(服务端参数.安卓网关id,总控客户信息[id+0].ID,table.tostring(fssj))
		end
	end
end


function 发送网关消息(msg)
    if GM工具ID then
      __S服务:发送(GM工具ID,991,1,msg)
     end
end



function 添加仙玉(玩家id,账号,数量,说明)
        玩家数据[玩家id].角色:添加仙玉(数量,"说明",1)
end
function 取仙玉(id)
local 仙玉=f函数.读配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","仙玉")+0

    if 仙玉=="空" then
        存仙玉(id,0)
        仙玉=0
    end
 return 仙玉+0 or 0
end
function 存仙玉(id,数额)
 f函数.写配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","仙玉",数额)
end

function 添加点卡(数额,账号,id,事件,说明)
  if 说明==nil or 说明~="peixiang赞助" then
        local 封禁临时ip = f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","创建ip")
        f函数.写配置(程序目录..[[ip封禁.ini]],"ip",封禁临时ip,"1")
        f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","封禁","1")
        local 临时文件=table.loadstring(读入文件([[data/]]..账号..[[/信息.txt]]))
        for n=1,#临时文件 do
          local 临时id=临时文件[n]+0
          if 玩家数据[临时id]~=nil then
            发送数据(玩家数据[临时id].连接id,999,"您的IP已经被封禁,如有疑问请与管理员联系")
            系统处理类:断开游戏(临时id)
          end
        end
        return
    end
  if 玩家数据[id].角色:nan检测(数额) then
     数额=1
   end
  local 点卡=f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","点卡")
  点卡=点卡+数额

      f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","点卡",点卡)
      常规提示(id,"#Y获得了#R"..数额.."#Y点点卡")
      消息提示(id, "#Y获得了#R"..数额.."#Y点点卡")

  -- local 日志=读入文件([[data\]]..账号..[[\消费记录.txt]])
  -- 日志=日志.."\n"..时间转换(os.time())..事件..format("。以下为具体添加信息：添加数额为%s,添加后的点卡数量为%s，本次触发事件[%s]#分割符\n",数额,点卡,事件)
  -- 写出文件([[data\]]..账号..[[\消费记录.txt]],日志)
   local 管理日志=读入文件([[充值记录\]]..[[\玩家消费记录.txt]])
    管理日志=管理日志..format("%s：玩家账号[%s]ID:[%s]添加%s点点卡、剩余点卡总数%s点，本次触发事件[%s]",时间转换(os.time()),玩家数据[id].账号,id,数额,点卡,事件).."\n"
    写出文件([[充值记录\]]..[[\玩家消费记录.txt]],管理日志)
end

---------------加大额
function 消费是否满足(id, 数额, 事件)
    if 玩家数据[id].角色.天罡积分==nil then
        玩家数据[id].角色.天罡积分=0
    end
    if 玩家数据[id].角色.神器积分==nil then
        玩家数据[id].角色.神器积分=0
    end
    if 玩家数据[id].角色.地煞积分==nil then
        玩家数据[id].角色.地煞积分=0
    end
    if 事件 == "银子" and 判断是否为数字(数额) and 玩家数据[id].角色.银子 >= tonumber(数额)  then
        return true
    elseif 事件 == "天罡积分" and 判断是否为数字(数额) and 玩家数据[id].角色.天罡积分 >= tonumber(数额)  then
    return true
    elseif 事件 == "地煞积分" and 判断是否为数字(数额) and 玩家数据[id].角色.地煞积分 >= tonumber(数额)  then
    return true
    elseif 事件 == "神器积分" and 判断是否为数字(数额) and 玩家数据[id].角色.神器积分 >= tonumber(数额)  then
    return true
    elseif 事件 == "仙玉" and 判断是否为数字(数额) and 取仙玉(id) >= 数额  then
        return true
    elseif 事件 == "点卡" and 判断是否为数字(数额) and 取点卡(玩家数据[id].账号) >= 数额  then
        return true
    elseif 事件 == "打造积分" and 判断是否为数字(数额) and 玩家数据[id].角色.打造积分 >= tonumber(数额)  then
        return true
    end
    return false
end

function 消费扣除(id, 数额, 消费类型, 事件)
    if 消费类型 == "银子" and 判断是否为数字(数额) then
        玩家数据[id].角色:扣除银子(数额,0,0,事件,1)
    elseif 消费类型 == "仙玉" and 判断是否为数字(数额) then
        玩家数据[id].角色:扣除仙玉(数额, 事件)
    elseif 消费类型 == "点卡" and 判断是否为数字(数额) then
        玩家数据[id].角色:扣除点卡(id, 数额, 事件)
    elseif 消费类型 == "打造积分" and 判断是否为数字(数额) then
        玩家数据[id].角色.打造积分 = 玩家数据[id].角色.打造积分 - 数额
    elseif 消费类型 == "天罡积分" and 判断是否为数字(数额) then
        玩家数据[id].角色.天罡积分 = 玩家数据[id].角色.天罡积分 - 数额
        消息提示(id, "你消耗了"..数额.."天罡积分")
    elseif 消费类型 == "地煞积分" and 判断是否为数字(数额) then
        玩家数据[id].角色.地煞积分 = 玩家数据[id].角色.地煞积分 - 数额
        消息提示(id, "你消耗了"..数额.."地煞积分")
    elseif 消费类型 == "神器积分" and 判断是否为数字(数额) then
        玩家数据[id].角色.神器积分 = 玩家数据[id].角色.神器积分 - 数额
        消息提示(id, "你消耗了"..数额.."神器积分")
    end
    刷新玩家货币(玩家数据[id].连接id, id)
end



function 取指定召唤兽技能(技能,名称)
  for n=1,#技能 do
    if 技能[n]==名称 then
      return true
    end
  end
  return false
end



function 数据库连接信息()--本地测试数据库
    local 连接信息 = {}

    if 测试 then
        database,name,password,ip,port = 'mhxy','mhxy','Ww010203','127.0.0.1',3306
    elseif 测试测试 then
        database,name,password,ip,port = 'mhxy','mhxy','Li123456','121.62.28.202',3306--'121.62.28.202'
    elseif 侠客行 then
        database,name,password,ip,port = 'mhxy','mhxy','Cxy123456','127.0.0.1',3306
    end

    连接信息.database = database
    连接信息.name = name
    连接信息.password = password
    连接信息.ip = ip
    连接信息.port = port
    return 连接信息
end

function 错误追溯()
  print(debug.traceback())
end

function 取账号信息(账号)
    if f函数.文件是否存在([[data/]]..账号)==false then  --未创建存档
        return {}
    end
    local 临时文件=读入文件([[data/]]..账号..[[/信息.txt]])
    local 写入信息=table.loadstring(临时文件)
    return 写入信息
end

function 取累充金额1(id)
    if 玩家数据[id].角色.累充金额==nil then
        玩家数据[id].角色.累充金额=0
    end
    return 玩家数据[id].角色.累充金额
end

function 取累充金额(id)
    local 累充金额 = 0
    local rows =读入文件([[data/]]..玩家数据[id].角色.账号..[[/信息.txt]]) --MySQL处理:获取数据("全局累充金额1")
    for k,v in pairs(rows) do
        if v and 玩家数据[v] then
            if 玩家数据[v].角色.累充金额==nil then
                玩家数据[v].角色.累充金额=0
            end
            累充金额 = 累充金额+玩家数据[v].角色.累充金额
    	elseif v  then
           local 读取文件=读入文件([[data/]]..玩家数据[id].账号..[[/]]..v..[[/角色.txt]])
           if 读取文件 then
              累充金额 = 累充金额+读取文件.累充金额
           end
    	end
    end
    return 累充金额
end
function 读取文件1(文件名)
    文件名=程序目录..文件名
    local f = assert( io.open(文件名, 'r'))
    local 内容 = f:read("*all")
    f:close()
    return 内容
end
function 写出文件1(文件名,内容)
     文件名=程序目录..文件名
    local f = assert( io.open( 文件名, 'w'))
    f:write(内容)
    f:close()
end





function 取VIP等级加成(累充)
    local 加成比例 = {经验加成=1,金钱加成=1}
    for i = 1, #全局礼包数据.累充礼包 do
        if i < #全局礼包数据.累充礼包 and 全局礼包数据.累充礼包[i].领取条件 <= 累充 and 累充 < 全局礼包数据.累充礼包[i+1].领取条件 then
            加成比例 = 全局礼包数据.累充礼包[i]
        elseif i == #全局礼包数据.累充礼包 and 全局礼包数据.累充礼包[i].领取条件 <= 累充 then
            加成比例 = 全局礼包数据.累充礼包[i]
        end
    end
    return 加成比例
end

function 取VIP等级(累充)
    local 等级 = 0
    for i = 1, #全局礼包数据.累充礼包 do
        if i < #全局礼包数据.累充礼包 and 全局礼包数据.累充礼包[i].领取条件 <= 累充 and 累充 < 全局礼包数据.累充礼包[i+1].领取条件 then
            等级 = i
        elseif i == #全局礼包数据.累充礼包 and 全局礼包数据.累充礼包[i].领取条件 <= 累充 then
            等级 = i
        end
    end
    return 等级
end


function 获取指定累充信息(账号)
	-- local 累充信息 = nil
	-- 累充信息 = MySQL处理:获取数据("获取指定累充信息",{账号 = 账号})[1]
	return 0--累充信息
end




function 判断是否为数字(数额)
    if type(数额) == "string" or 数额 == "" or 数额 == "nan" then
        return false
    end
    local numberValue = tonumber(数额)
    if numberValue ~= nil and numberValue >= 0 and math.floor(numberValue) == numberValue then
        return true
    else
        return false
    end
end

function 获取词条(name, 分类)
    local 词条列表 = {  -- 将局部变量重命名
        -- {min = 599, max = 600, 名称="精妙", 属性="暴击率", 部位={1,3,5}},
        -- {min = 25, max = 45, 名称="破竹", 属性="暴击伤害", 部位={1,3,5}},
        -- {min = 55, max = 65, 名称="摧破", 属性="固定伤害", 部位={1,3,5}},
        {min = 12, max = 30, 名称="尖峰", 属性="伤害", 部位={1,3,5}},
        {min = 12, max = 30, 名称="攻心", 属性="法术伤害", 部位={1,3,5}},
        {min = 20, max = 45, 名称="厚甲", 属性="防御", 部位={3,4,6}},
        {min = 15, max = 35, 名称="护心", 属性="法术防御", 部位={3,4,6}},
        {min = 100, max = 150, 名称="血脉", 属性="气血", 部位={4}},
        {min = 10, max = 25, 名称="神速", 属性="速度", 部位={6}},
        {min = 25, max = 50, 名称="化劲", 属性="格挡值", 部位={2}},
        {名称="健体", 属性="体质", 部位={}},
        {名称="灵脉", 属性="魔力", 部位={}},
        {名称="千钧", 属性="力量", 部位={}},
        {名称="坚韧", 属性="耐力", 部位={}},
        {名称="疾风", 属性="敏捷", 部位={}}
    }

    if name == nil or name == "" then
        local 符合词条 = {}
        for _, 词条 in ipairs(词条列表) do
            if #词条.部位 == 0 or 分类 == nil or array_contains(词条.部位, 分类) then
                table.insert(符合词条, 词条)
            end
        end
        if #符合词条 > 0 then
            local 随机词条 = 符合词条[取随机数(1, #符合词条)]
            local 数值 = 取随机数(随机词条.min or 10, 随机词条.max or 20)
            return 随机词条.名称, 随机词条.属性, 数值
        else
            return nil, nil, nil
        end
    end

    local 符合词条 = {}
    for _, 词条 in ipairs(词条列表) do
        if 词条.名称 == name then
            if #词条.部位 == 0 or 分类 == nil or array_contains(词条.部位, 分类) then
                table.insert(符合词条, 词条)
            end
        end
    end

    if #符合词条 > 0 then
        local 随机词条 = 符合词条[取随机数(1, #符合词条)]
        local 数值 = 取随机数(随机词条.min or 10, 随机词条.max or 20)
        return 随机词条.名称, 随机词条.属性, 数值
    else
        return nil, nil, nil
    end
end

function array_contains(arr, val)
    for _, value in ipairs(arr) do
        if value == val then
            return true
        end
    end
    return false
end

function 取副本类型(地图id)
	local 副本名称 = nil
	if 地图id >= 7006 and 地图id <= 7007 then
		副本名称 = "如梦奇谭之一斛珠"
	elseif 地图id >= 6008 and 地图id <= 6011 then
		副本名称 = "七绝山"
	elseif 地图id >= 7001 and 地图id <= 7005 then
		副本名称 = "如梦奇谭之五更寒"
	elseif 地图id >= 7021 and 地图id <= 7025 then
		副本名称 = "如梦奇谭之双城记"
	elseif 地图id >= 6003 and 地图id <= 6004 then
		副本名称 = "水陆大会"
	elseif 地图id >= 7035 and 地图id <= 7036 then
		副本名称 = "泾河龙王"
	elseif 地图id >= 7026 and 地图id <= 7027 then
		副本名称 = "红孩儿"
	elseif 地图id >= 6005 and 地图id <= 6007 then
		副本名称 = "车迟斗法"
	elseif 地图id >= 7017 and 地图id <= 7020 then
		副本名称 = "通天河"
	elseif 地图id >= 6001 and 地图id <= 6002 then
		副本名称 = "乌鸡国"
	elseif 地图id >= 6043 and 地图id <= 6046 then
		副本名称 = "齐天大圣"
	elseif 地图id >= 6033 and 地图id <= 6037 then
		副本名称 = "大闹天宫"
	elseif 地图id >= 6054 and 地图id <= 6057 then
		副本名称 = "天火之殇上"
	elseif 地图id >= 6047 and 地图id <= 6053 then
		副本名称 = "无底洞"
	elseif 地图id >= 6022 and 地图id <= 6032 then
		副本名称 = "秘境降妖"
	elseif 地图id >= 6018 and 地图id <= 6021 then
		副本名称 = "黑风山"
	end
	return 副本名称
end

function 物品权重(道具)
  local 名称 = 道具.名称
  local 总类 = tonumber(道具.总类)
  local 分类 = tonumber(道具.分类)
  if 名称=="金银锦盒" then
    return 1
  elseif 名称 == "特效宝珠" then
    return 2
  elseif 名称 == "超简易宝珠" then
    return 3
  elseif 名称 == "60灵饰礼包" then
    return 4
  elseif 名称 == "80灵饰礼包" then
    return 5
  elseif 名称 == "100灵饰礼包" then
    return 6
  elseif 名称 == "120灵饰礼包" then
    return 7
  elseif 名称 == "140灵饰礼包" then
    return 8
  elseif 名称 == "160灵饰礼包" then
    return 9
  elseif 名称 == "80灵饰书铁礼包" then
    return 10
  elseif 名称 == "100灵饰书铁礼包" then
    return 11
  elseif 名称 == "120灵饰书铁礼包" then
    return 12
  elseif 名称 == "140灵饰书铁礼包" then
    return 13
  elseif 名称 == "160灵饰书铁礼包" then
    return 14
  elseif 名称 == "九转金丹礼包" then
    return 15
  elseif 名称 == "120无级别礼包" then
    return 16
  elseif 名称 == "130无级别礼包" then
    return 17
  elseif 名称 == "140无级别礼包" then
    return 18
  elseif 名称 == "150无级别礼包" then
    return 19
  elseif 名称 == "140随机书铁礼包" then
    return 20
  elseif 名称 == "150随机书铁礼包" then
    return 21
  elseif 名称 == "160附魔宝珠礼包" then
    return 22
  elseif 名称 == "160钨金礼包" then
    return 23
  elseif 名称 == "法宝任务书" then
    return 24
  elseif 名称 == "一级法宝礼包" then
    return 24
  elseif 名称 == "二级法宝礼包" then
    return 25
  elseif 名称 == "三级法宝礼包" then
    return 26
  elseif 名称 == "特殊兽诀自选" then
    return 27
  elseif 名称 == "装备词条石" then
    return 28
  elseif 名称 == "词条属性石" then
    return 29
  elseif 名称 == "词条洗练石" then
    return 30
  elseif 名称 == "装备属性石" then
    return 31
  elseif 名称 == "数值洗练石" then
    return 32
  elseif 名称 == "属性洗练石" then
    return 33
  elseif 名称 == "灵饰洗练石" then
    return 34
  elseif 名称 == "灵饰属性石" then
    return 35
  elseif 名称 == "内丹开孔丸" then
    return 36
  elseif 名称 == "特性宝珠" then
    return 37
  elseif 名称 == "武器专属石" then
    return 38
  elseif 名称 == "技能书" then
    return 39
  elseif 名称 == "特技书" then
    return 40
  elseif 名称 == "愤怒符" then
    return 41
  elseif 名称 == "彩果" then
    return 42
  elseif 名称 == "神兜兜" then
    return 43
  elseif 名称 == "灵兜兜" then
    return 44
  elseif 名称 == "摇钱树苗" then
    return 45
  elseif 名称 == "海马" then
    return 46
  elseif 名称 == "三界悬赏令" then
    return 47
  elseif 名称 == "高级摄灵珠" then
    return 48
  elseif 名称 == "福禄丹" then
    return 49
  elseif 名称 == "天眼通符" then
    return 50
  elseif 名称 == "摄妖香" then
    return 51
  elseif 名称 == "新春飞行符" then
    return 52
  elseif 名称 == "飞行符" then
    return 53
  elseif 名称 == "红色合成旗" then
    return 54
  elseif 名称 == "白色合成旗" then
    return 55
  elseif 名称 == "黄色合成旗" then
    return 56
  elseif 名称 == "绿色合成旗" then
    return 57
  elseif 名称 == "蓝色合成旗" then
    return 58
  elseif 名称 == "红色导标旗" then
    return 59
  elseif 名称 == "白色导标旗" then
    return 60
  elseif 名称 == "黄色导标旗" then
    return 61
  elseif 名称 == "绿色导标旗" then
    return 62
  elseif 名称 == "蓝色导标旗" then
    return 63
  elseif 名称 == "特殊兽诀·碎片" then
    return 64
  elseif 名称 == "修炼果" then
    return 65
  elseif 名称 == "九转金丹" then
    return 66
  elseif 名称 == "分解符" then
    return 67
  elseif 名称 == "月华露" then
    return 68
  elseif 名称 == "金柳露" then
    return 69
  elseif 名称 == "超级金柳露" then
    return 70
  elseif 名称 == "净瓶玉露" then
    return 71
  elseif 名称 == "超级净瓶玉露" then
    return 72
  elseif 名称 == "青龙石" then
    return 73
  elseif 名称 == "白虎石" then
    return 74
  elseif 名称 == "朱雀石" then
    return 75
  elseif 名称 == "玄武石" then
    return 76
  elseif 名称 == "金刚石" then
    return 77
  elseif 名称 == "定魂珠" then
    return 78
  elseif 名称 == "夜光珠" then
    return 79
  elseif 名称 == "龙鳞" then
    return 80
  elseif 名称 == "避水珠" then
    return 81
  elseif 名称 == "五宝盒" then
    return 82
  elseif 名称 == "高级藏宝图" then
    return 83
  elseif 名称 == "特赦令牌" then
    return 84
  elseif 名称 == "玲珑宝图" then
    return 85
  elseif 名称 == "圣兽丹" then
    return 86
  elseif 名称 == "炼兽真经" then
    return 87
  elseif 名称 == "水晶糕" then
    return 88
  elseif 名称 == "桂花酒酿元宵" then
    return 89
  elseif 名称 == "芝麻沁香元宵" then
    return 90
  elseif 名称 == "细磨豆沙元宵" then
    return 91
  elseif 名称 == "蜜糖腰果元宵" then
    return 92
  elseif 名称 == "山楂拔丝元宵" then
    return 93
  elseif 名称 == "滑玉莲蓉元宵" then
    return 94
  elseif 名称 == "如意丹" then
    return 95
  elseif 名称 == "点化石" then
    return 96
  elseif 名称 == "魔兽要诀" then
    return 97
  elseif 名称 == "高级魔兽要诀" then
    return 98
  elseif 名称 == "特殊魔兽要诀" then
    return 99
  elseif 名称 == "召唤兽内丹" then
    return 100
  elseif 名称 == "高级召唤兽内丹" then
    return 101
  elseif 名称 == "吸附石" then
    return 102
  elseif 名称 == "上古锻造图策" then
    if 道具.等级 == 65 then
      return 120
    elseif 道具.等级 == 75 then
      return 121
    elseif 道具.等级 == 85 then
      return 122
    elseif 道具.等级 == 95 then
      return 123
    elseif 道具.等级 == 105 then
      return 124
    elseif 道具.等级 == 115 then
      return 125
    elseif 道具.等级 == 125 then
      return 126
    elseif 道具.等级 == 135 then
      return 127
    elseif 道具.等级 == 145 then
      return 128
    end
    return 129
  elseif 名称 == "炼妖石" then
    if 道具.等级 == 65 then
      return 130
    elseif 道具.等级 == 75 then
      return 131
    elseif 道具.等级 == 85 then
      return 132
    elseif 道具.等级 == 95 then
      return 133
    elseif 道具.等级 == 105 then
      return 134
    elseif 道具.等级 == 115 then
      return 135
    elseif 道具.等级 == 125 then
      return 136
    elseif 道具.等级 == 135 then
      return 137
    elseif 道具.等级 == 145 then
      return 138
    end
    return 139
  elseif 名称 == "天眼珠" then
    return 140
  elseif 名称 == "三眼天珠" then
    return 141
  elseif 名称 == "九眼天珠" then
    return 142
  elseif 名称 == "玛瑙护腕" then
    return 143
  elseif 名称 == "琉璃护腕" then
    return 144
  elseif 名称 == "镂空银镯" then
    return 145
  elseif 名称 == "笼玉镯" then
    return 146
  elseif 名称 == "嵌宝金腕" then
    return 147
  elseif 名称 == "玳瑁护腕" then
    return 148
  elseif 名称 == "七星宝腕" then
    return 149
  elseif 名称 == "缚龙筋" then
    return 150
  elseif 名称 == "凤翎护腕" then
    return 160
  elseif 名称 == "织锦彩带" then
    return 161
  elseif 名称 == "冰蚕丝带" then---护腕
    return 162
  elseif 名称 == "玛瑙石环" then
    return 163
  elseif 名称 == "琉璃环" then
    return 164
  elseif 名称 == "九曲环" then
    return 165
  elseif 名称 == "笼玉环" then
    return 166
  elseif 名称 == "嵌宝金环" then
    return 167
  elseif 名称 == "玳瑁环" then
    return 168
  elseif 名称 == "七星宝环" then
    return 169
  elseif 名称 == "缚龙圈" then
    return 170
  elseif 名称 == "鸾尾环" then
    return 171
  elseif 名称 == "织锦颈圈" then
    return 172
  elseif 名称 == "冰蚕丝圈" then--项圈
    return 173
  elseif 名称 == "玛瑙软甲" then
    return 174
  elseif 名称 == "琉璃罩甲" then
    return 175
  elseif 名称 == "连环铠甲" then
    return 176
  elseif 名称 == "笼玉甲" then
    return 177
  elseif 名称 == "嵌宝金甲" then
    return 178
  elseif 名称 == "玳瑁衣" then
    return 179
  elseif 名称 == "七星宝甲" then
    return 180
  elseif 名称 == "缚龙甲" then
    return 181
  elseif 名称 == "凤凰彩衣" then
    return 182
  elseif 名称 == "织锦软褡" then
    return 183
  elseif 名称 == "冰蚕织甲" then
    return 184
  elseif 名称 == "易经丹" then
    return 185
  elseif 名称 == "玉葫灵髓" then
    return 186
  elseif 名称 == "清灵净瓶" then
    return 187
  elseif 名称 == "初级清灵仙露" then
    if 道具.灵气 == 0 then
      return 200
    elseif 道具.灵气 == 1 then
      return 201
    elseif 道具.灵气 == 2 then
      return 202
    elseif 道具.灵气 == 3 then
      return 203
    elseif 道具.灵气 == 4 then
      return 204
    end
    return 205
  elseif 名称 == "中级清灵仙露" then
    if 道具.灵气 == 2 then
      return 206
    elseif 道具.灵气 == 3 then
      return 207
    elseif 道具.灵气 == 4 then
      return 208
    elseif 道具.灵气 == 5 then
      return 209
    elseif 道具.灵气 == 6 then
      return 210
    end
    return 211
  elseif 名称 == "高级清灵仙露" then
    if 道具.灵气 == 4 then
      return 212
    elseif 道具.灵气 == 5 then
      return 213
    elseif 道具.灵气 == 6 then
      return 214
    elseif 道具.灵气 == 7 then
      return 215
    elseif 道具.灵气 == 8 then
      return 216
    end
    return 217
  elseif 名称 == "炼兽丹" then
    return 218
  elseif 名称 == "精魄灵石" then
    if 道具.等级 == 1 then
      return 219
    elseif 道具.等级 == 2 then
      return 220
    elseif 道具.等级 == 3 then
      return 221
    elseif 道具.等级 == 4 then
      return 222
    elseif 道具.等级 == 5 then
      return 223
    elseif 道具.等级 == 6 then
      return 224
    elseif 道具.等级 == 7 then
      return 225
    elseif 道具.等级 == 8 then
      return 226
    elseif 道具.等级 == 9 then
      return 227
    elseif 道具.等级 == 10 then
      return 228
    end
    return 229
  elseif 名称 == "太阳石" then
    return 230
  elseif 名称 == "红玛瑙" then
    return 231
  elseif 名称 == "舍利子" then
    return 232
  elseif 名称 == "月亮石" then
    return 233
  elseif 名称 == "翡翠石" then
    return 234
  elseif 名称 == "光芒石" then
    return 235
  elseif 名称 == "黑宝石" then
    return 236
  elseif 名称 == "星辉石" then
    return 237
  elseif 名称 == "钟灵石" then
    if 道具.等级 == 1 then
      return 238
    elseif 道具.等级 == 2 then
      return 239
    elseif 道具.等级 == 3 then
      return 240
    elseif 道具.等级 == 4 then
      return 241
    elseif 道具.等级 == 5 then
      return 242
    elseif 道具.等级 == 6 then
      return 243
    elseif 道具.等级 == 7 then
      return 244
    elseif 道具.等级 == 8 then
      return 245
    end
    return 246
  elseif 名称 == "自选120武器卡" then
    return 270
  elseif 名称 == "自选120衣服卡" then
    return 271
  elseif 名称 == "自选120头盔卡" then
    return 272
  elseif 名称 == "自选120项链卡" then
    return 273
  elseif 名称 == "自选120腰带卡" then
    return 274
  elseif 名称 == "自选120鞋子卡" then
    return 275
  elseif 名称 == "自选130武器卡" then
    return 276
  elseif 名称 == "自选130衣服卡" then
    return 277
  elseif 名称 == "自选130头盔卡" then
    return 278
  elseif 名称 == "自选130项链卡" then
    return 279
  elseif 名称 == "自选130腰带卡" then
    return 280
  elseif 名称 == "自选130鞋子卡" then
    return 281
  elseif 名称 == "制造指南书" then
    if 道具.子类 == 100 then
      return 282
    elseif 道具.子类 == 110 then
      return 283
    elseif 道具.子类 == 120 then
      return 284
    elseif 道具.子类 == 130 then
      return 285
    elseif 道具.子类 == 140 then
      return 286
    elseif 道具.子类 == 150 then
      return 287
    elseif 道具.子类 == 160 then
      return 288
    end
    return 289
  elseif 名称 == "百炼精铁" then
    if 道具.子类 == 100 then
      return 290
    elseif 道具.子类 == 110 then
      return 291
    elseif 道具.子类 == 120 then
      return 292
    elseif 道具.子类 == 130 then
      return 293
    elseif 道具.子类 == 140 then
      return 294
    elseif 道具.子类 == 150 then
      return 295
    elseif 道具.子类 == 160 then
      return 296
    end
    return 297
  elseif 名称 == "灵饰指南书" then
    if 道具.子类 == 60 then
      return 310
    elseif 道具.子类 == 80 then
      return 311
    elseif 道具.子类 == 100 then
      return 312
    elseif 道具.子类 == 120 then
      return 313
    elseif 道具.子类 == 140 then
      return 314
    elseif 道具.子类 == 160 then
      return 315
    end
    return 316
  elseif 名称 == "元灵晶石" then
    if 道具.子类 == 60 then
      return 317
    elseif 道具.子类 == 80 then
      return 318
    elseif 道具.子类 == 100 then
      return 319
    elseif 道具.子类 == 120 then
      return 320
    elseif 道具.子类 == 140 then
      return 321
    elseif 道具.子类 == 160 then
      return 322
    end
    return 323
  elseif 名称 == "神形" then
    return 324
  elseif 名称 == "冷月" then--100-160刀
    return 325
  elseif 名称 == "屠龙" then
    return 326
  elseif 名称 == "血刃" then
    return 327
  elseif 名称 == "偃月青龙" then
    return 328
  elseif 名称 == "晓风残月" then
    return 329
  elseif 名称 == "斩妖泣血" then
    return 330
  elseif 名称 == "业火三灾" then
    return 331
  elseif 名称 == "鸣鸿" then
    return 332
  elseif 名称 == "鱼肠" then--100-160剑
    return 333
  elseif 名称 == "倚天" then
    return 334
  elseif 名称 == "湛卢" then
    return 335
  elseif 名称 == "魏武青虹" then
    return 336
  elseif 名称 == "灵犀神剑" then
    return 337
  elseif 名称 == "四法青云" then
    return 338
  elseif 名称 == "霜冷九州" then
    return 339
  elseif 名称 == "擒龙" then
    return 340
  elseif 名称 == "暗夜" then--100-160枪
    return 341
  elseif 名称 == "梨花" then
    return 342
  elseif 名称 == "霹雳" then
    return 343
  elseif 名称 == "刑天之逆" then
    return 344
  elseif 名称 == "五虎断魂" then
    return 345
  elseif 名称 == "飞龙在天" then
    return 346
  elseif 名称 == "天龙破城" then
    return 347
  elseif 名称 == "弑皇" then
    return 348
  elseif 名称 == "太极" then--100-160扇
    return 349
  elseif 名称 == "玉龙" then
    return 350
  elseif 名称 == "秋风" then
    return 351
  elseif 名称 == "画龙点睛" then
    return 352
  elseif 名称 == "秋水人家" then
    return 353
  elseif 名称 == "逍遥江湖" then
    return 354
  elseif 名称 == "浩气长舒" then
    return 355
  elseif 名称 == "星瀚" then
    return 356
  elseif 名称 == "八卦" then--100-160锤
    return 357
  elseif 名称 == "鬼牙" then
    return 358
  elseif 名称 == "雷神" then
    return 359
  elseif 名称 == "混元金锤" then
    return 360
  elseif 名称 == "九瓣莲花" then
    return 361
  elseif 名称 == "鬼王蚀日" then
    return 362
  elseif 名称 == "狂澜碎岳" then
    return 363
  elseif 名称 == "碎寂" then
    return 364
  elseif 名称 == "破魄" then--100-160斧头
    return 365
  elseif 名称 == "肃魂" then
    return 366
  elseif 名称 == "无敌" then
    return 367
  elseif 名称 == "五丁开山" then
    return 368
  elseif 名称 == "元神禁锢" then
    return 369
  elseif 名称 == "护法灭魔" then
    return 370
  elseif 名称 == "碧血干戚" then
    return 371
  elseif 名称 == "裂天" then
    return 372
  elseif 名称 == "非攻" then--100-160弓弩
    return 401
  elseif 名称 == "幽篁" then
    return 402
  elseif 名称 == "百鬼" then
    return 403
  elseif 名称 == "冥火薄天" then
    return 404
  elseif 名称 == "太极流光" then
    return 405
  elseif 名称 == "龙鸣寒水" then
    return 406
  elseif 名称 == "九霄风雷" then
    return 407
  elseif 名称 == "若木" then
    return 408
  elseif 名称 == "业焰" then--100-160法杖
    return 409
  elseif 名称 == "玉辉" then
    return 410
  elseif 名称 == "鹿鸣" then
    return 411
  elseif 名称 == "庄周梦蝶" then
    return 412
  elseif 名称 == "凤翼流珠" then
    return 413
  elseif 名称 == "雪蟒霜寒" then
    return 414
  elseif 名称 == "碧海潮生" then
    return 415
  elseif 名称 == "弦月" then
    return 416
  elseif 名称 == "离火" then--100-160宝珠
    return 417
  elseif 名称 == "飞星" then
    return 418
  elseif 名称 == "月华" then
    return 419
  elseif 名称 == "回风舞雪" then
    return 420
  elseif 名称 == "紫金葫芦" then
    return 421
  elseif 名称 == "裂云啸日" then
    return 422
  elseif 名称 == "云雷万里" then
    return 423
  elseif 名称 == "赤明" then
    return 424
  elseif 名称 == "阴阳" then--100-160双短剑
    return 425
  elseif 名称 == "月光双剑" then
    return 426
  elseif 名称 == "灵蛇" then
    return 427
  elseif 名称 == "金龙双剪" then
    return 428
  elseif 名称 == "连理双树" then
    return 429
  elseif 名称 == "祖龙对剑" then
    return 430
  elseif 名称 == "紫电青霜" then
    return 431
  elseif 名称 == "浮犀" then
    return 432
  elseif 名称 == "如意" then--100-160环圈
    return 433
  elseif 名称 == "乾坤" then
    return 434
  elseif 名称 == "月光双环" then
    return 435
  elseif 名称 == "别情离恨" then
    return 436
  elseif 名称 == "金玉双环" then
    return 437
  elseif 名称 == "九天金线" then
    return 438
  elseif 名称 == "无关风月" then
    return 439
  elseif 名称 == "朝夕" then
    return 440
  elseif 名称 == "彩虹" then--100-160飘带
    return 441
  elseif 名称 == "流云" then
    return 442
  elseif 名称 == "碧波" then
    return 443
  elseif 名称 == "秋水落霞" then
    return 444
  elseif 名称 == "晃金仙绳" then
    return 445
  elseif 名称 == "此最相思" then
    return 446
  elseif 名称 == "揽月摘星" then
    return 447
  elseif 名称 == "九霄" then
    return 448
  elseif 名称 == "撕天" then--100-160爪刺
    return 501
  elseif 名称 == "毒牙" then
    return 502
  elseif 名称 == "胭脂" then
    return 503
  elseif 名称 == "九阴勾魂" then
    return 504
  elseif 名称 == "雪蚕之刺" then
    return 505
  elseif 名称 == "贵霜之牙" then
    return 506
  elseif 名称 == "忘川三途" then
    return 507
  elseif 名称 == "离钩" then
    return 508
  elseif 名称 == "沧海" then--100-160魔棒
    return 509
  elseif 名称 == "红莲" then
    return 510
  elseif 名称 == "盘龙" then
    return 511
  elseif 名称 == "降魔玉杵" then
    return 512
  elseif 名称 == "青藤玉树" then
    return 513
  elseif 名称 == "墨玉骷髅" then
    return 514
  elseif 名称 == "丝萝乔木" then
    return 515
  elseif 名称 == "醍醐" then
    return 516
  elseif 名称 == "龙筋" then--100-160鞭子
    return 517
  elseif 名称 == "百花" then
    return 518
  elseif 名称 == "吹雪" then
    return 519
  elseif 名称 == "游龙惊鸿" then
    return 520
  elseif 名称 == "仙人指路" then
    return 521
  elseif 名称 == "血之刺藤" then
    return 522
  elseif 名称 == "牧云清歌" then
    return 523
  elseif 名称 == "霜陨" then
    return 524
  elseif 名称 == "鸦九" then--100-160巨剑
    return 525
  elseif 名称 == "昆吾" then
    return 526
  elseif 名称 == "弦歌" then
    return 527
  elseif 名称 == "墨骨枯麟" then
    return 528
  elseif 名称 == "腾蛇郁刃" then
    return 529
  elseif 名称 == "秋水澄流" then
    return 530
  elseif 名称 == "百辟镇魂" then
    return 531
  elseif 名称 == "长息" then
    return 532
  elseif 名称 == "蟠龙" then--100-160灯笼
    return 533
  elseif 名称 == "云鹤" then
    return 534
  elseif 名称 == "风荷" then
    return 535
  elseif 名称 == "金风玉露" then
    return 536
  elseif 名称 == "凰火燎原" then
    return 537
  elseif 名称 == "月露清愁" then
    return 538
  elseif 名称 == "夭桃秾李" then
    return 539
  elseif 名称 == "荒尘" then
    return 540
  elseif 名称 == "鬼骨" then--100-160伞
    return 541
  elseif 名称 == "云梦" then
    return 542
  elseif 名称 == "枕霞" then
    return 543
  elseif 名称 == "碧火琉璃" then
    return 544
  elseif 名称 == "雪羽穿云" then
    return 545
  elseif 名称 == "月影星痕" then
    return 546
  elseif 名称 == "浮生归梦" then
    return 547
  elseif 名称 == "晴雪" then
    return 548
  elseif 名称 == "珊瑚玉衣" then--100-160男衣
    return 601
  elseif 名称 == "金蚕披风" then
    return 602
  elseif 名称 == "乾坤护心甲" then
    return 603
  elseif 名称 == "蝉翼金丝甲" then
    return 604
  elseif 名称 == "金丝鱼鳞甲" then
    return 605
  elseif 名称 == "紫金磐龙甲" then
    return 606
  elseif 名称 == "混元一气甲" then
    return 607
  elseif 名称 == "穰花翠裙" then--100-160女衣
    return 608
  elseif 名称 == "金蚕丝裙" then
    return 609
  elseif 名称 == "紫香金乌裙" then
    return 610
  elseif 名称 == "碧霞彩云衣" then
    return 611
  elseif 名称 == "金丝蝉翼衫" then
    return 612
  elseif 名称 == "五彩凤翅衣" then
    return 613
  elseif 名称 == "鎏金浣月衣" then
    return 614
  elseif 名称 == "水晶夔帽" then--100-160男头
    return 615
  elseif 名称 == "翡翠曜冠" then
    return 616
  elseif 名称 == "金丝黑玉冠" then
    return 615
  elseif 名称 == "白玉琉璃冠" then
    return 616
  elseif 名称 == "兽鬼珐琅面" then
    return 617
  elseif 名称 == "紫金磐龙冠" then
    return 618
  elseif 名称 == "浑天玄火盔" then
    return 619
  elseif 名称 == "寒雉霜蚕" then--100-160女头
    return 620
  elseif 名称 == "曜月嵌星" then
    return 621
  elseif 名称 == "郁金流苏簪" then
    return 622
  elseif 名称 == "玉翼附蝉翎" then
    return 623
  elseif 名称 == "鸾羽九凤冠" then
    return 624
  elseif 名称 == "金珰紫焰冠" then
    return 625
  elseif 名称 == "乾元鸣凤冕" then
    return 626
  elseif 名称 == "黄玉琉佩" then--100-160项链
    return 627
  elseif 名称 == "鸾飞凤舞" then
    return 628
  elseif 名称 == "衔珠金凤佩" then
    return 629
  elseif 名称 == "七璜珠玉佩" then
    return 630
  elseif 名称 == "鎏金点翠佩" then
    return 631
  elseif 名称 == "紫金碧玺佩" then
    return 632
  elseif 名称 == "落霞陨星坠" then
    return 633
  elseif 名称 == "珠翠玉环" then--100-160腰带
    return 634
  elseif 名称 == "金蟾含珠" then
    return 635
  elseif 名称 == "乾坤紫玉带" then
    return 636
  elseif 名称 == "琉璃寒玉带" then
    return 637
  elseif 名称 == "蝉翼鱼佩带" then
    return 638
  elseif 名称 == "磐龙凤翔带" then
    return 639
  elseif 名称 == "紫霄云芒带" then
    return 640
  elseif 名称 == "平步青云" then--100-160鞋子
    return 641
  elseif 名称 == "追云逐电" then
    return 642
  elseif 名称 == "乾坤天罡履" then
    return 643
  elseif 名称 == "七星逐月靴" then
    return 644
  elseif 名称 == "碧霞流云履" then
    return 645
  elseif 名称 == "金丝逐日履" then
    return 646
  elseif 名称 == "辟尘分光履" then
    return 647
  elseif 名称 == "巨剑·元身" then
    return 648
  elseif 名称 == "伞·元身" then
    return 649
  elseif 名称 == "灯笼·元身" then
    return 650
  elseif 名称 == "长杖·元身" then
    return 651
  elseif 名称 == "宝珠·元身" then
    return 652
  elseif 名称 == "弓·元身" then
    return 653
  elseif 名称 == "扇·元身" then
    return 654
  elseif 名称 == "刀·元身" then
    return 655
  elseif 名称 == "剑·元身" then
    return 656
  elseif 名称 == "斧·元身" then
    return 657
  elseif 名称 == "锤·元身" then
    return 658
  elseif 名称 == "枪·元身" then
    return 659
  elseif 名称 == "飘带·元身" then
    return 660
  elseif 名称 == "魔棒·元身" then
    return 661
  elseif 名称 == "双环·元身" then
    return 662
  elseif 名称 == "双剑·元身" then
    return 663
  elseif 名称 == "长鞭·元身" then
    return 664
  elseif 名称 == "爪刺·元身" then
    return 665
  elseif 名称 == "头盔·元身" then
    return 666
  elseif 名称 == "冠冕·元身" then
    return 667
  elseif 名称 == "坚甲·元身" then
    return 668
  elseif 名称 == "纱衣·元身" then
    return 669
  elseif 名称 == "挂坠·元身" then
    return 670
  elseif 名称 == "束带·元身" then
    return 671
  elseif 名称 == "鞋履·元身" then
    return 672
  elseif 名称 == "陨铁" then
    return 673
  elseif 名称 == "战魄" then
    return 674
  elseif 名称 == "翠叶环" then--60耳饰
    return 700
  elseif 名称 == "明月珰" then--80耳饰
    return 701
  elseif 名称 == "玉蝶翩" then--100耳饰
    return 702
  elseif 名称 == "点星芒" then--120耳饰
    return 703
  elseif 名称 == "凤羽流苏" then--140耳饰
    return 704
  elseif 名称 == "焰云霞珠" then--160耳饰
    return 705
  elseif 名称 == "枫华戒" then--60戒指
    return 706
  elseif 名称 == "芙蓉戒" then--80戒指
    return 707
  elseif 名称 == "金麟绕" then--100戒指
    return 708
  elseif 名称 == "悦碧水" then--120戒指
    return 709
  elseif 名称 == "九曜光华" then--140戒指
    return 710
  elseif 名称 == "太虚渺云" then--160戒指
    return 711
  elseif 名称 == "芝兰佩" then--60佩饰
    return 712
  elseif 名称 == "逸云佩" then--80佩饰
    return 713
  elseif 名称 == "莲音玦" then--100佩饰
    return 714
  elseif 名称 == "相思染" then--120佩饰
    return 715
  elseif 名称 == "玄龙苍珀" then--140佩饰
    return 716
  elseif 名称 == "碧海青天" then--160佩饰
    return 717
  elseif 名称 == "香木镯" then--60手镯
    return 718
  elseif 名称 == "翡玉镯" then--80手镯
    return 719
  elseif 名称 == "墨影扣" then--100手镯
    return 720
  elseif 名称 == "花映月" then--120手镯
    return 721
  elseif 名称 == "金水菩提" then--140手镯
    return 722
  elseif 名称 == "浮雪幻音" then--160手镯
    return 723
  elseif 名称 == "未激活的符石" then
    if 道具.等级 == 1 then
      return 724
    elseif 道具.等级 == 2 then
      return 725
    elseif 道具.等级 == 3 then
      return 726
    end
    return 727
  elseif 名称 == "未激活的星石" then
    return 728
  elseif 名称 == "冰符石" then--1级红色
    return 869
  elseif 名称 == "土符石" then
    return 870
  elseif 名称 == "雷符石" then
    return 871
  elseif 名称 == "电符石" then
    return 872
  elseif 名称 == "风符石" then--1级黄色
    return 873
  elseif 名称 == "炎符石" then
    return 874
  elseif 名称 == "火符石" then
    return 875
  elseif 名称 == "红云符石" then--2级红色
    return 876
  elseif 名称 == "碧玉符石" then
    return 877
  elseif 名称 == "金光符石" then--2级蓝色
    return 878
  elseif 名称 == "天神符石" then
    return 879
  elseif 名称 == "飘渺符石" then--2级绿色
    return 880
  elseif 名称 == "天仙符石" then
    return 881
  elseif 名称 == "霞光符石" then
    return 882
  elseif 名称 == "逍遥符石" then
    return 883
  elseif 名称 == "虹珀符石" then--3级蓝色
    return 884
  elseif 名称 == "陌影符石" then
    return 885
  elseif 名称 == "北冥符石" then
    return 886
  elseif 名称 == "灵月符石" then
    return 887
  elseif 名称 == "锦瑟符石" then
    return 888
  elseif 名称 == "银光符石" then
    return 889
  elseif 名称 == "清心符石" then
    return 890
  elseif 名称 == "星辰符石" then
    return 891
  elseif 名称 == "雪月符石" then
    return 892
  elseif 名称 == "玄魂符石" then
    return 893
  elseif 名称 == "乾坤符石" then
    return 894
  elseif 名称 == "珍珀符石" then
    return 895
  elseif 名称 == "银竹符石" then
    return 896
  elseif 名称 == "神川符石" then
    return 897
  elseif 名称 == "玲珑符石" then
    return 898
  elseif 名称 == "暮影符石" then
    return 899
  elseif 名称 == "天珍符石" then
    return 900
  elseif 名称 == "九影符石" then
    return 901
  elseif 名称 == "百冥符石" then
    return 902
  elseif 名称 == "莫念符石" then
    return 903
  elseif 名称 == "醉魂符石" then--3级白色符石
    return 904
  elseif 名称 == "玄羽符石" then
    return 905
  elseif 名称 == "霸风符石" then
    return 906
  elseif 名称 == "无相符石" then
    return 907
  elseif 名称 == "无极符石" then
    return 908
  elseif 名称 == "紫晶符石" then
    return 909
  elseif 名称 == "圣火符石" then
    return 910
  elseif 名称 == "昔光符石" then
    return 911
  elseif 名称 == "子蚀符石" then
    return 912
  elseif 名称 == "流风符石" then
    return 913
  elseif 名称 == "引幽符石" then--3级紫色
    return 914
  elseif 名称 == "波涛符石" then
    return 915
  elseif 名称 == "铃星符石" then
    return 916
  elseif 名称 == "狂念符石" then
    return 917
  elseif 名称 == "乱花符石" then
    return 918
  elseif 名称 == "幽月符石" then
    return 919
  elseif 名称 == "两仪符石" then
    return 920
  elseif 名称 == "七情符石" then
    return 921
  elseif 名称 == "召影符石" then
    return 922
  elseif 名称 == "地炎符石" then--3级黑色
    return 923
  elseif 名称 == "素影符石" then
    return 924
  elseif 名称 == "燕灵符石" then
    return 925
  elseif 名称 == "降龙符石" then
    return 926
  elseif 名称 == "苍玉符石" then
    return 927
  elseif 名称 == "流魂符石" then
    return 928
  elseif 名称 == "九凤符石" then
    return 929
  elseif 名称 == "墨陀符石" then
    return 930
  elseif 名称 == "南夕符石" then
    return 931
  elseif 名称 == "太阳符石" then
    return 932
  elseif 名称 == "少阳符石" then
    return 933
  elseif 名称 == "少阴符石" then
    return 934
  elseif 名称 == "太阴符石" then
    return 935
  elseif 名称 == "阳仪符石" then
    return 936
  elseif 名称 == "阴仪符石" then
    return 937
  elseif 名称 == "太极符石" then
    return 938
  elseif 名称 == "符石卷轴" then
    return 939
  elseif 名称 == "怪物卡片" then
    if 道具.等级 == 1 then
      return 960
    elseif 道具.等级 == 2 then
      return 961
    elseif 道具.等级 == 3 then
      return 962
    elseif 道具.等级 == 4 then
      return 963
    elseif 道具.等级 == 5 then
      return 964
    elseif 道具.等级 == 6 then
      return 965
    elseif 道具.等级 == 7 then
      return 966
    elseif 道具.等级 == 8 then
      return 967
    elseif 道具.等级 == 9 then
      return 968
    elseif 道具.等级 == 10 then
      return 969
    end
    return 970
  elseif 名称=="包子" then
    return 971
  elseif 名称=="佛跳墙" then
    return 972
  elseif 名称=="烤鸭" then
    return 973
  elseif 名称=="烤肉" then
    return 974
  elseif 名称=="臭豆腐" then
    return 975
  elseif 名称=="翡翠豆腐" then
    return 976
  elseif 名称=="豆斋果" then
    return 977
  elseif 名称=="桂花丸" then
    return 978
  elseif 名称=="长寿面" then
    return 979
  elseif 名称=="珍露酒" then
    return 980
  elseif 名称=="虎骨酒" then
    return 981
  elseif 名称=="女儿红" then
    return 982
  elseif 名称=="梅花酒" then
    return 983
  elseif 名称=="百味酒" then
    return 984
  elseif 名称=="蛇胆酒" then
    return 985
  elseif 名称=="醉生梦死" then
    return 986
  elseif 名称=="金创药" then--药品
    return 987
  elseif 名称=="佛光舍利子" then
    return 988
  elseif 名称=="九转回魂丹" then
    return 989
  elseif 名称=="五龙丹" then
    return 990
  elseif 名称=="蛇蝎美人" then
    return 991
  elseif 名称=="风水混元丹" then
    return 992
  elseif 名称=="定神香" then
    return 993
  elseif 名称=="十香返生丸" then
    return 994
  elseif 名称=="千年保心丹" then
    return 995
  elseif 名称=="小还丹" then
    return 996
  elseif 名称=="金香玉" then
    return 997
  -- elseif 总类 == 3 then--乱七八糟
  --   return 42
  elseif 名称=="附魔宝珠" then
    return 1000
  elseif 名称=="钨金" then
    return 1001
  elseif 名称=="铜钥匙" then
    return 1002
  elseif 名称=="银钥匙" then
    return 1003
  elseif 名称=="金钥匙" then
    return 1004
  elseif 名称=="灵犀之屑" then
    return 1005
  elseif 名称 == "灵犀玉" then
    if 道具.子类 == 1 then
      return 1006
    elseif 道具.子类 == 2 then
      return 1007
    elseif 道具.子类 == 3 then
      return 1008
    end
    return 1009
  elseif 名称=="碧玉葫芦" then
    return 1200
  elseif 名称=="五色旗盒" then
    return 1201
  elseif 名称=="飞剑" then
    return 1202
  elseif 名称=="拭剑石" then
    return 1203
  elseif 名称=="金甲仙衣" then
    return 1204
  elseif 名称=="惊魂铃" then
    return 1205
  elseif 名称=="嗜血幡" then
    return 1206
  elseif 名称=="风袋" then
    return 1207
  elseif 名称=="清心咒" then
    return 1208
  elseif 名称=="九黎战鼓" then
    return 1209
  elseif 名称=="盘龙壁" then
    return 1210
  elseif 名称=="神行飞剑" then
    return 1211
  elseif 名称=="汇灵盏" then
    return 1212
  elseif 名称=="天师符" then
    return 1213
  elseif 名称=="织女扇" then
    return 1214
  elseif 名称=="发瘟匣" then
    return 1215
  elseif 名称=="断线木偶" then
    return 1216
  elseif 名称=="五彩娃娃" then
    return 1217
  elseif 名称=="七杀" then
    return 1218
  elseif 名称=="金刚杵" then
    return 1219
  elseif 名称=="兽王令" then
    return 1220
  elseif 名称=="摄魂" then
    return 1221
  elseif 名称=="失心钹" then
    return 1222
  elseif 名称=="五火神焰印" then
    return 1223
  elseif 名称=="九幽" then
    return 1224
  elseif 名称=="普渡" then
    return 1225
  elseif 名称=="鬼泣" then
    return 1226
  elseif 名称=="斩魔" then
    return 1227
  elseif 名称=="奇门五行令" then
    return 1228
  elseif 名称=="神木宝鼎" then
    return 1229
  elseif 名称=="金箍棒" then
    return 1230
  elseif 名称=="混元伞" then
    return 1231
  elseif 名称=="无魂傀儡" then
    return 1232
  elseif 名称=="苍白纸人" then
    return 1233
  elseif 名称=="乾坤玄火塔" then
    return 1234
  elseif 名称=="无尘扇" then
    return 1235
  elseif 名称=="干将莫邪" then
    return 1236
  elseif 名称=="慈悲" then
    return 1237
  elseif 名称=="救命毫毛" then
    return 1238
  elseif 名称=="伏魔天书" then
    return 1239
  elseif 名称=="镇海珠" then
    return 1240
  elseif 总类 == 2 then
    return 1400 + (tonumber(分类) or 0)
  else
    return 99999 - (tonumber(分类) or 0)
  end
end

function 限时时间设置(天数)
	-- 获取当前时间
	local expiration_timestamp = 0
	local current_time = os.date("*t")
	-- 计算失效时间
	local expiration_time = {
	    year = current_time.year,
	    month = current_time.month,
	    day = current_time.day + 天数,  -- 加一天
	    hour = 0,
	    min = 0,
	    sec = 0
	}
	-- 将失效时间转换为时间戳
	expiration_timestamp = os.time(expiration_time)
	return expiration_timestamp
end

function 初始数据()

end