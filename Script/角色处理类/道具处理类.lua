local 道具处理类 = class()
local 图策范围={"项圈","护腕","铠甲"}
local qz=math.floor
local floor=math.floor
local random = 取随机数
local remove = table.remove

-- local 资质道具={特殊元宵_攻={资质="攻击资质",加成=5,上限=1800},特殊元宵_防={资质="防御资质",加成=5,上限=1800},特殊元宵_速={资质="速度资质",加成=5,上限=1600}
--             ,特殊元宵_躲={资质="躲闪资质",加成=5,上限=1600},特殊元宵_体={资质="体力资质",加成=5,上限=5500},特殊元宵_法={资质="法力资质",加成=5,上限=3500},特殊元宵_成长={资质="成长",加成=2,上限=1.6}}
local 资质道具={特殊元宵_攻={资质="攻击资质",加成=5,上限=1800},特殊元宵_防={资质="防御资质",加成=5,上限=1800},
        特殊元宵_体={资质="体力资质",加成=5,上限=5500},特殊元宵_法={资质="法力资质",加成=5,上限=3500},特殊元宵_成长={资质="成长",加成=2,上限=1.6}}
--加成为随机数的上限  1-上限为每次增加数值
--上限为对应资质最大可使用资质  宝宝资质成长道具

 local 右键合成宝石={
    红玛瑙=1,
    太阳石=1,
    舍利子=1,
    黑宝石=1,
    月亮石=1,
    神秘石=1,
    光芒石=1,
    星辉石=1,
    精魄灵石=1,
    五色灵尘=1,
}
local 右键合成玄灵珠={
    玄灵珠·破军=1,
    玄灵珠·灵法=1,
    玄灵珠·回春=1,
    玄灵珠·神速=1,
}
local 右键合成五宝={
    金刚石=1,
    定魂珠=1,
    避水珠=1,
    夜光珠=1,
    龙鳞=1,
}
local 法技能 = {
    jnz = {"逍遥游","北冥之渊","扶摇万里","高级神佑复生","高级魔之心","高级法术连击","高级法术暴击","高级法术波动","须弥真言","高级感知"},
    zz = {1600,1600,5500,3500,1500,1500,6000},
    cz = 1.3
}
if f函数.文件是否存在([[礼包配置/鲲鹏礼包(法).txt]])==false then
 鲲鹏法=法技能
  写出文件([[礼包配置/鲲鹏礼包(法).txt]],table.tostring(鲲鹏法))
 else
  鲲鹏法=table.loadstring(读入文件([[礼包配置/鲲鹏礼包(法).txt]]))
end
local 攻技能 = {
    jnz = {"北冥之渊","理直气壮","高级必杀","高级偷袭","高级神佑复生","逍遥游","高级夜战","高级吸血","高级防御","苍鸾怒击"},
    zz = {1600,1600,5500,3500,1500,1500,6000},
    cz = 1.3
}
if f函数.文件是否存在([[礼包配置/鲲鹏礼包(物).txt]])==false then
 鲲鹏物=攻技能
  写出文件([[礼包配置/鲲鹏礼包(物).txt]],table.tostring(鲲鹏物))
 else
  鲲鹏物=table.loadstring(读入文件([[礼包配置/鲲鹏礼包(物).txt]]))
end

local 五福攻技能 = {
    jnz = {"逍遥游","理直气壮","苍鸾怒击","高级神佑复生","超级必杀","超级偷袭","超级吸血","超级夜战","高级感知","浮云神马","超级否定信仰","无上正真"},
    zz = {1600,1600,5500,3500,1500,1500,6000},
    cz = 1.3
}
if f函数.文件是否存在([[礼包配置/五福鲲鹏礼包(物).txt]])==false then
 五福鲲鹏物=五福攻技能
  写出文件([[礼包配置/五福鲲鹏礼包(物).txt]],table.tostring(五福鲲鹏物))
 else
  五福鲲鹏物=table.loadstring(读入文件([[礼包配置/五福鲲鹏礼包(物).txt]]))
end

local 五福法技能 = {
    jnz = {"逍遥游","北冥之渊","扶摇万里","高级神佑复生","超级魔之心","超级法术连击","超级法术暴击","超级法术波动","高级感知","浮云神马","超级否定信仰","须弥真言"},
    zz = {1600,1600,5500,3500,1500,1500,6000},
    cz = 1.3
}
if f函数.文件是否存在([[礼包配置/五福鲲鹏礼包(法).txt]])==false then
 五福鲲鹏法=五福法技能
  写出文件([[礼包配置/五福鲲鹏礼包(法).txt]],table.tostring(五福鲲鹏法))
 else
  五福鲲鹏法=table.loadstring(读入文件([[礼包配置/五福鲲鹏礼包(法).txt]]))
end

function 道具处理类:初始化(id,数字id)
    self.玩家id=数字id
    self.数据={}
    self.阵法名称={
        [3]="普通",
        [4]="风扬阵",
        [5]="虎翼阵",
        [6]="天覆阵",
        [7]="云垂阵",
        [8]="鸟翔阵",
        [9]="地载阵",
        [10]="龙飞阵",
        [11]="蛇蟠阵",
        [12]="鹰啸阵",
        [13]="雷绝阵",
    }
    self.飞行传送点={
        [1]={1001,336,217},
        [2]={1001,358,35},
        [3]={1501,65,112},
        [4]={1092,122,54},
        [5]={1070,106,158},
        [6]={1040,108,98},
        [7]={1226,117,48},
        [8]={1208,128,36},
    }
    self.kediejia={}
    self.kediejia["队长礼袋"]=999
    self.kediejia["新三级符石礼包"]=999
    self.kediejia["阵营礼物包"]=999
    self.kediejia["焕彩石"]=999
    self.kediejia["玉刚卯"]=999
    self.kediejia["斩妖帖"]=999
    self.kediejia["扫荡卡"]=999
    self.kediejia["摇钱树苗"]=999
    self.kediejia["九天揽月称谓礼包"]=999
    self.kediejia["神豪称谓礼包"]=999
    self.kediejia["威震天下称谓礼包"]=999
    self.kediejia["傲视群雄唯我独尊称谓礼包"]=999

    self.kediejia["独步西游若等闲称谓礼包"]=999--新增
    self.kediejia["一举成名天下惊称谓礼包"]=999
    self.kediejia["苍茫三界主沉浮称谓礼包"]=999

    self.kediejia["称谓碎片"]=999
    self.kediejia["120无级别礼包"]=999
    self.kediejia["140无级别礼包"]=999
    self.kediejia["150无级别礼包"]=999
    self.kediejia["160无级别礼包"]=999

    self.kediejia["五色灵尘礼包"]=999--新增
    self.kediejia["玄灵珠·噬魂礼包"]=999
    self.kediejia["玄灵珠·空灵礼包"]=999
    self.kediejia["玄灵珠·破军礼包"]=999
    self.kediejia["玄灵珠·回春礼包"]=999
    self.kediejia["打造熟练度礼包"]=999
    self.kediejia["随机160无级别装备"]=999
    self.kediejia["随机150无级别装备"]=999
    self.kediejia["随机140无级别装备"]=999
    self.kediejia["160随机灵饰箱"]=999
    self.kediejia["高级宝石袋"]=999
    self.kediejia["星辉石袋"]=999
    self.kediejia["精魄灵石袋"]=999
    self.kediejia["玉魄积分礼包"]=999
    self.kediejia["双龙积分礼包"]=999
    self.kediejia["嘉年华积分"]=999
    self.kediejia["3级宝石礼包"]=999
    self.kediejia["4级宝石礼包"]=999
    self.kediejia["5级宝石礼包"]=999
    self.kediejia["6级宝石礼包"]=999
    self.kediejia["7级宝石礼包"]=999
    self.kediejia["8级宝石礼包"]=999
    self.kediejia["9级宝石礼包"]=999
    self.kediejia["10级宝石礼包"]=999
    self.kediejia["11级宝石礼包"]=999
    self.kediejia["12级宝石礼包"]=999
    self.kediejia["13级宝石礼包"]=999
    self.kediejia["14级宝石礼包"]=999
    self.kediejia["15级宝石礼包"]=999
    self.kediejia["16级宝石礼包"]=999
    self.kediejia["17级宝石礼包"]=999
    self.kediejia["18级宝石礼包"]=999

    self.kediejia["兽魂技能转换符"]=999
    self.kediejia["青花瓷锦衣·碎片"]=999
    self.kediejia["翻一番"]=9999
    self.kediejia["宝石袋"]=999
    self.kediejia["四神石礼包"]=999
    self.kediejia["自选特殊兽决"]=999
    self.kediejia["自动抓鬼卡礼包"]=999
    self.kediejia["会员周卡礼包"]=999
    self.kediejia["自选钟灵石"]=999
    self.kediejia["附魔宝珠"]=999

    self.kediejia["五彩神石"]=999
    self.kediejia["自选超级兽决"]=999
    self.kediejia["月饼"]=999
    self.kediejia["修炼果"]=999
    self.kediejia["五宝盒"]=999
    self.kediejia["超级净瓶玉露"]=999
    self.kediejia["凤纹灵坠"]=9999
    self.kediejia["净瓶玉露"]=999
    self.kediejia["超级金柳露"]=999
    self.kediejia["金柳露"]=999
    self.kediejia["金钥匙"]=999
    self.kediejia["银钥匙"]=999
    self.kediejia["铜钥匙"]=999
    self.kediejia["特殊兽诀·碎片"]=999
    self.kediejia["上古玉魄·碎片"]=999


    self.kediejia["驱赶烟花"]=999
    self.kediejia["60灵饰礼包"]=99
    self.kediejia["80灵饰礼包"]=99
    self.kediejia["100灵饰礼包"]=99
    self.kediejia["120灵饰礼包"]=99
    self.kediejia["140灵饰礼包"]=99
    self.kediejia["超级技能·碎片"]=999
    self.kediejia["超级兽诀·碎片"]=999
    self.kediejia["地心印记"]=999
    self.kediejia["法宝精华礼包30"]=999
    self.kediejia["法宝精华"]=999
    self.kediejia["奖池抽奖"]=999
    self.kediejia["夺宝令牌"]=999
    self.kediejia["本命法宝礼包"]=999
    self.kediejia["BB装备65级礼包"]=99
    self.kediejia["BB装备75级礼包"]=99
    self.kediejia["BB装备85级礼包"]=99
    self.kediejia["BB装备95级礼包"]=99
    self.kediejia["BB装备105级礼包"]=99
    self.kediejia["BB装备115级礼包"]=99
    self.kediejia["BB装备125级礼包"]=99
    self.kediejia["BB装备135级礼包"]=99
    self.kediejia["BB装备145级礼包"]=99
    self.kediejia["BB装备155级礼包"]=99
    self.kediejia["淬灵石"]=9999
    self.kediejia["装备强化石"]=9999
    self.kediejia["红包碎片"]=9999

    self.kediejia["平安红包"]=999--新增
    self.kediejia["多福红包"]=999
    self.kediejia["进财红包"]=999
    self.kediejia["随机红包"]=999

    self.kediejia["月饼礼包"]=99
    self.kediejia["灵韵精华礼包"]=99
    self.kediejia["灵韵精华"]=99
    self.kediejia["特殊元宵礼包"]=99
    self.kediejia["剧情点礼包"]=99

    self.kediejia["愤怒符"]=999
    self.kediejia["蕴灵晶体"]=999
    self.kediejia["破境·白虎坠"]=999
    self.kediejia["破境·朱雀坠"]=999
    self.kediejia["破境·玄武坠"]=999
    self.kediejia["破境·青龙坠"]=999
    self.kediejia["蕴灵礼包小"]=999
    self.kediejia["蕴灵礼包大"]=999
    self.kediejia["破镜坠礼包"]=999
    self.kediejia["锦红彩笺"]=999
    self.kediejia["称号材料礼包"]=999
    self.kediejia["随机玄灵珠"]=999
    self.kediejia["60自选灵饰礼包"]=999
    self.kediejia["80自选灵饰礼包"]=999
    self.kediejia["100自选灵饰礼包"]=99
    self.kediejia["120自选灵饰礼包"]=99
    self.kediejia["140自选灵饰礼包"]=99
    self.kediejia["160自选灵饰礼包"]=99--新增
    self.kediejia["五宝"]=99
    self.kediejia["特技书"]=99
    self.kediejia["九转金丹礼包"]=99
    self.kediejia["160附魔宝珠礼包"]=99
    self.kediejia["特效宝珠礼包"]=99
    self.kediejia["灵犀玉礼包"]=99
    self.kediejia["灵犀之屑"]=99
    self.kediejia["福禄丹"]=99
    self.kediejia["技能书"]=999
    self.kediejia["易经丹"]=999
    self.kediejia["特效宝珠"]=999
    self.kediejia["特效宝珠碎片"]=999
    self.kediejia["超简易宝珠"]=999
    self.kediejia["符石卷轴"]=999
    self.kediejia["陨铁"]=999
    self.kediejia["仙露小丸子"]=999
    self.kediejia["神兽涎"]=999
    self.kediejia["观照万象碎片"]=999
    self.kediejia["超级否定信仰碎片"]=999--新增
    self.kediejia["仙露丸子"]=9999
    self.kediejia["灵兜兜"]=999
    self.kediejia["金刚石"]=999      -- 新增
    self.kediejia["定魂珠"]=999      -- 新增
    self.kediejia["避水珠"]=999      -- 新增
    self.kediejia["夜光珠"]=999      -- 新增
    self.kediejia["龙鳞"]=999        -- 新增
    self.kediejia["特性宝珠"]=999
    self.kediejia["武器专属石"]=999
    self.kediejia["修炼礼包"]=999
    self.kediejia["至尊强化石"]=999
    self.kediejia["护符"]=999
    self.kediejia["恩典钥匙"]=999
    self.kediejia["暗淡的星辰碎片"]=999
    self.kediejia["微光的星辰碎片"]=999
    self.kediejia["发光的星辰碎片"]=999
    self.kediejia["耀眼的星辰碎片"]=999
    self.kediejia["奇异的星辰碎片"]=999
    self.js=os.time()
    self.jingzhi=0
    self.xiaxian=0
    for k,v in pairs(资质道具) do
        self.kediejia[k]=999
    end
end


function 道具处理类:加载数据(账号,数字id)
    self.数字id = 数字id
    self.数据 = table.loadstring(读入文件([[data/]]..账号..[[/]]..数字id..[[/道具.txt]]))
    if not self.数据 then
        常规提示(数字id,"#Y账号道具异常请与GM联系")
        return --{}
    end
    -- if not 共享道具[账号] then
    -- 共享道具[账号]=table.loadstring(读入文件([[data/]]..账号..[[/]]..[[共享道具.txt]]))
    -- end
    for n, v in pairs(self.数据) do
        if type(self.数据[n]) == "userdata" or self.数据[n].名称==nil then
            self.数据[n]=nil
        end
        if n~=nil and self.数据[n]~=nil and self.数据[n].名称~=nil and self.数据[n].名称=="帮派银票" then
            local 是否存在 = false
            for i=1,20 do
                if 玩家数据[数字id].角色.道具[i] ~= nil and 玩家数据[数字id].角色.道具[i] == n then
                    是否存在 = true
                    break
                end
            end
            if 是否存在 == false then
                self.数据[n] = nil
            end
        end
    end
end

function 道具处理类:数据处理(连接id,序号,数字id,数据)
    if 玩家数据[数字id].摊位数据~=nil or 收购数据[数字id]~=nil then
        if 序号~=3699 and 序号~=3700 and 序号~=3720 and 序号~=3720.1 and 序号~=3720.2 and 序号~=3720.3 and 序号~=3720.4 and 序号~=3720.5 and 序号~=3720.6 and 序号~=3888 and 序号~=3721 and 序号~=3722 and 序号~=3723 and 序号~=3724 and 序号~=3725 then
            常规提示(数字id,"#Y/摆摊状态下禁止此种行为")
            return
        end
    -- elseif 玩家数据[数字id].烤火 then
    --  -- 常规提示(数字id,"当前不能使用道具")
    --  return
    elseif 玩家数据[数字id].角色.体验状态 then
        if 序号==3715 or 序号==3716 or 序号==3717 or 序号==3718 or 序号==3720 or 序号==3722 or 序号==3725 or 序号==3726 then
            常规提示(数字id,"体验状态下无法进行此操作。")
            return
        end
    end
-- if not 共享道具[玩家数据[数字id].账号] then
--     共享道具[玩家数据[数字id].账号]=table.loadstring(读入文件([[data/]]..玩家数据[数字id].账号..[[/]]..[[共享道具.txt]]))
-- end
    if 序号==3699 then
        self:索要道具(连接id,数字id)
    elseif 序号==3700 then
        self:索要行囊(连接id,数字id)
    elseif 序号==3701 then
        self:道具格子互换(连接id,数字id,数据)

    elseif 序号==3702 then
        self:丢弃道具(连接id,数字id,数据)
    elseif 序号==3703 then
        self:佩戴装备(连接id,数字id,数据)
    elseif 序号==3704 then
        self:卸下装备(连接id,数字id,数据)
    elseif 序号==3704.91 then
        self:卸下上古玉魄(连接id,数字id,数据.玉魄)
    elseif 序号==3800.5 then
        local 道具id = 玩家数据[数字id].角色.道具[数据.装备]
        if not self.数据[道具id] then
            常规提示(数字id,"#Y欲镶嵌的装备并不存在！")
            return
        elseif 数据.类型 ~= "道具" and    数据.类型 ~= "行囊" then
            常规提示(数字id,"#Y你这啥背包类型？？？")
            return
        end
        if self.数据[道具id].总类 == "上古玉魄" then
            if 数据.类型=="道具" then
                玩家数据[数字id].玉魄镶嵌=玩家数据[数字id].角色.道具[数据.装备]
            else
                玩家数据[数字id].玉魄镶嵌=玩家数据[数字id].角色.行囊[数据.装备]
            end
            发送数据(玩家数据[数字id].连接id,3550.5,{装备=self.数据[玩家数据[数字id].玉魄镶嵌]})
        else
            常规提示(数字id,"#Y这玩意不能镶嵌" ..self.数据[道具id].名称)
        end

    elseif 序号==3800.6 then
        self:玉魄镶嵌或卸下(数字id,数据)

     elseif 序号==3704.1 then
            self:升级锦衣(连接id,数字id,数据)
    elseif 序号==3818 then
            if 数据.x事件 == "附灵" then
                self:法宝附灵处理(数字id,数据)
            elseif 数据.x事件 == "清除" then
                self:法宝清附灵处理(数字id,数据)
            elseif 数据.x事件 == "升级" then
                self:法宝附灵升级(数字id,数据)
            end

    elseif 序号==3824 then
            if 数据.标识 and 数据.标识.等级 and 数据.标识.格子 and 数据.标识.道具名字 and 数据.标识.特效 and 数据.标识.特技 and 数据.标识.名称 then
                local 临时格子=玩家数据[数字id].角色:取道具格子()
                    if 临时格子==0 then
                        常规提示(数字id,"#Y/请先整理下包裹吧！")
                        return
                    end
                    local 物品id=玩家数据[数字id].角色.道具[数据.标识.格子+0]
                    if not self.数据[物品id] or self.数据[物品id].名称~=数据.标识.道具名字 then
                       常规提示(数字id,"#Y/请不要移动道具！")
                        return
                    end
                    if not 数据.标识.双加1 or not 数据.标识.双加2 then
                            if  self.数据[物品id].名称=="武器自选礼包" or self.数据[物品id].名称=="衣服自选礼包"  then
                              常规提示(数字id,"#Y/请选择双加属性！！")
                                return
                             end
                    end
                    local 等级 = 数据.标识.等级+0
                     local  道具id=self:取新编号()
                    --装备处理类:生成打造装备(id,级别,种类,名称,生产方式,制造者,是否鉴定,专用,无级别,对方id)
                      self.数据[道具id]=table.copy(装备处理类:生成打造装备(数字id,等级,取装备序列(数据.标识.名称),数据.标识.名称,"强化打造","强化打造",true,nil,nil,nil,9999))--最后一个参数是倍率
                      self.数据[道具id].名称=数据.标识.名称
                      self.数据[道具id].特技=数据.标识.特技
                      self.数据[道具id].特效={}
                      self.数据[道具id].特效[1]=数据.标识.特效
                      self.数据[道具id].专用=数字id
                      self.数据[道具id].五维属性={}
                     local 类型1=分割文本(self.数据[物品id].名称,"自选礼包")

                      if  数据.标识.双加1 and 装备处理类.装备数据[类型1[1]] then
                          local 双加=取单双加属性(等级)
                          local 类型=数据.标识.双加1
                           self.数据[道具id][类型]=math.ceil(取随机数(1,双加))
                      end
                      if  数据.标识.双加2 and 类型1[1] and 装备处理类.装备数据[类型1[1]] then
                       local 双加=取单双加属性(等级)
                      local 类型=数据.标识.双加2
                      self.数据[道具id][类型]=math.ceil(取随机数(1,双加))

                     end
                      玩家数据[数字id].角色.道具[临时格子]=道具id
                      if self.数据[物品id].数量 then
                          self.数据[物品id].数量=self.数据[物品id].数量-1
                          if self.数据[物品id].数量<=0 then
                          self.数据[物品id]=nil
                          玩家数据[数字id].角色.道具[数据.标识.格子+0]=nil
                          end
                        else
                         self.数据[物品id]=nil
                          玩家数据[数字id].角色.道具[数据.标识.格子+0]=nil
                      end
                     -- 添加新提示(数字id,self.数据[道具id].名称,self.数据[道具id].数量)
                     常规提示(数字id,"#Y/您获得了"..数据.标识.名称)
                        发送数据(连接id,3699)
              else
                  常规提示(数字id,"#Y/请全部选择后再来！")
                return
            end

    elseif 序号==3705 then
        self:使用道具(连接id,数字id,数据)
    elseif 序号==3706 then
        self:飞行符传送(连接id,数字id,数据)
    elseif 序号==3707 then
        发送数据(连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
    elseif 序号==3707.1 then
        发送数据(连接id,14.1,玩家数据[数字id].道具:索要道具1(数字id))
    elseif 序号==3708 then
        self:佩戴bb装备(连接id,数字id,数据)
    elseif 序号==3709 then
        self:卸下bb装备(连接id,数字id,数据)
    elseif 序号==3710 then
        self:染色处理(连接id,数字id,数据)
    elseif 序号==3711 then
        玩家数据[数字id].角色:学习门派技能(连接id,数字id,数据.序列,数据.次数)
    elseif 序号==3712 then
        玩家数据[数字id].角色:学习生活技能(连接id,数字id,数据.序列)
    elseif 序号 == 3712.1 then
        玩家数据[数字id].角色:学习强化技能(连接id,数字id,数据.序列)
    elseif 序号==3713 then
        self:烹饪处理(连接id,数字id,1)
    elseif 序号==3714 then
        self:炼药处理(连接id,数字id,1)
    elseif 序号==3715 then
        self:给予处理(连接id,数字id,数据)
    elseif 序号==3716 then --请求给予
        玩家数据[数字id].给予数据={类型=2,id=数据.id+0}
        发送数据(连接id,3507,{道具=self:索要道具1(数字id),名称=玩家数据[数据.id+0].角色.名称,类型="玩家",等级=玩家数据[数据.id+0].角色.等级})
    elseif 序号==3717 then
        self:设置交易数据(连接id,数字id,数据)
    elseif 序号==3717.1 then
        self:完成交易(连接id,数字id,数据)
    elseif 序号==3718 then
        self:发起交易处理(连接id,数字id,数据.id)
    elseif 序号==3719 then
        self:取消交易(数字id)
    elseif 序号==3720 then --自己创建、索要摊位
        self:索要摊位数据(连接id,数字id,3515)
    elseif 序号==3720.1 and 收购定制 then --自己创建、索要摊位
        self:索要收购摊位数据(连接id,数字id,3538.1)
    elseif 序号==3720.2 then --自己创建、索要摊位
        self:添加收购道具(连接id,数字id,数据)
    elseif 序号==3720.3 then --自己创建、索要摊位
      self:删除收购道具(连接id,数字id,数据)
    elseif 序号==3720.4 then --自己创建、索要摊位
      self:更改收购招牌(连接id,数字id,数据.名称)
    elseif 序号==3720.5 then --自己创建、索要摊位
      self:收购收摊处理(连接id,数字id)
    elseif 序号==3720.6 then --索取其他玩家摊位
        self:发送玩家收购摊位(连接id,数字id,数据.id,3521)
    elseif 序号==3720.7 then --自己创建、索要摊位
        self:出售收购道具(连接id,数字id,数据.id,数据)
    elseif 序号==3721 then --更改招牌
        self:更改摊位招牌(连接id,数字id,数据.名称)
    elseif 序号==3722 then --上架
        self:摊位上架商品(连接id,数字id,数据)
    elseif 序号==3723 then --下架
        self:摊位下架商品(连接id,数字id,数据)
    elseif 序号==3724 then --收摊
        self:收摊处理(连接id,数字id)
    elseif 序号==3725 then --索取其他玩家摊位
        self:索要其他玩家摊位(连接id,数字id,数据.id,3521)
    elseif 序号==3726 then --购买摊位商品
        self:购买摊位商品(连接id,数字id,数据)
    elseif 序号==3726.1 then
       self:购买摊位制造商品(连接id,数字id,数据)
    elseif 序号==3727 then
        self:快捷加血(连接id,数字id,数据.类型)
    elseif 序号==3728 then
        self:快捷加蓝(连接id,数字id,数据.类型)
    elseif 序号==3732 then
        self:索要法宝(连接id,数字id)
    elseif 序号==3732.1 then
        self:索要锦衣(连接id,数字id)

    elseif 序号==3733 then
        self:修炼法宝(连接id,数字id,数据.序列)
    elseif 序号==3734 then
        self:卸下法宝(连接id,数字id,数据.序列,数据.神器)
    elseif 序号==3735 then
        self:替换法宝(连接id,数字id,数据.序列,数据.序列1)
    elseif 序号==3736 then
        self:使用法宝(连接id,数字id,数据.序列)
    elseif 序号==3737 then
        self:使用合成旗(连接id,数字id,数据.序列)
    elseif 序号==3738 then
        self:符纸使用(连接id,数字id,数据)
    elseif 序号==3738.1 then
        self:一键打符(数字id)

    elseif 序号==3739 then
        self:开运(连接id,数字id,数据.格子)
    elseif 序号==3739.1 then
        self:锦衣进阶(连接id,数字id,数据.格子)
    elseif 序号==3739.2 then
        self:锦衣继承(连接id,数字id,数据.格子1,数据.格子2)
    elseif 序号==3739.3 then
        self:技能继承(连接id,数字id,数据.格子1,数据.格子2)

    elseif 序号==3740 then
        self:超级合成旗传送(连接id,数字id,数据)

    elseif 序号==3740.1 then
        self:新春飞行符传送(连接id,数字id,数据)

    elseif 序号 == 3741 then
        发送数据(连接id,101,玩家数据[数字id].道具:索要道具1(数字id))
        玩家数据[数字id].打造方式=1
    elseif 序号 == 3742 then
        self:法宝补充灵气(连接id,数字id,数据.序列)
    elseif 序号 == 3743.1 then
        self:御兽术处理(连接id,数字id,数据)

    elseif 序号==3746 then
        self:道具转移(连接id,数字id,数据)
    elseif 序号==3747 then
        self:坐骑装饰卸下(连接id,数字id,数据)
    elseif 序号==3748 then --请求给予
        玩家数据[数字id].给予数据={类型=1,地图=数据.地图,编号=数据.编号,序号=数据.序号,标识=数据.标识,名称=数据.名称,模型=数据.模型}
        发送数据(连接id,3530,{道具=self:索要道具1(数字id),名称=数据.名称,类型="NPC"})
        self:索要任务1(连接id,数字id)
    elseif 序号==3749 then
        self:临时背包处理(连接id,数字id,数据)
    elseif 序号==3750 then
        self:索要任务(连接id,数字id)
    elseif 序号==3751 then
        self:索要道具更新(数字id,数据.类型)
    elseif 序号==3752 then
        self:修炼灵宝(连接id,数字id,数据.序列)
    elseif 序号==3753 then
        self:卸下灵宝(连接id,数字id,数据.序列)
    elseif 序号==3754 then
        self:替换灵宝(连接id,数字id,数据.序列,数据.序列1)
    elseif 序号==3755 then
        self:使用灵宝(连接id,数字id,数据.序列)
     elseif 序号==3757 then
        self:玉魄自选(连接id,数字id,数据)
    elseif 序号==3758 then
        self:鉴定专用装备(连接id,数字id,数据)
    elseif 序号==3759 then
        self:吸附兽诀(连接id,数字id,数据)
    elseif 序号==3760 then
        降妖伏魔:铃铛抽奖(连接id,数字id,数据)
    elseif 序号==3761 then
        降妖伏魔:铃铛处理(连接id,数字id,数据)
    elseif 序号==3762 then
        self:宝宝进阶(连接id,数字id,数据)
    elseif 序号==3763 then
        self:装备点化套装(连接id,数字id,数据)
    elseif 序号==3770 then
        self:装备开启星位(连接id,数字id,数据)
    elseif 序号==3780 then --新增
        if 数据.道具类型 == "道具" then
            发送数据(玩家数据[数字id].连接id,3535,{类型="道具",数据=self:索要道具2(数字id)})
        elseif 数据.道具类型 == "行囊" then
            发送数据(玩家数据[数字id].连接id,3535,{类型="行囊",数据=self:索要行囊2(数字id)})
        end
    elseif 序号==3781 then --新增 光武拓印
        self:获取光武拓印(连接id,数字id,数据)
    elseif 序号==3782 then --新增 光武拓印
        发送数据(连接id,233,{nil,nil,"光武拓印"})
    elseif 序号==3783 then --新增 光武拓印
        self:光武拓印转化(连接id,数字id,数据)
    elseif 序号==3784 then
        self:宝宝坐骑喂养(连接id,数字id,数据)
    elseif 序号==3785 then
        self:一键回收(连接id,数字id)


    elseif 序号==3785.1 then
        self:一键回收仓库(连接id,数字id)

    elseif 序号==3786 then
        -- if 消费是否满足(数字id, 50, "仙玉") then
        --  玩家数据[数字id].道具:给予道具(数字id,"自动抓鬼卡",1)
        --  消费扣除(数字id, 50, "仙玉", "自动抓鬼卡")
        -- else
        --     常规提示(数字id,"您的仙玉不足！")
        -- end
     elseif 序号==3787 then
     self:清空包裹(连接id,数字id)
     elseif 序号==3789 then
        self:自选道具(连接id,数字id,数据)
    elseif 序号==3800 then
        if 数据.类型=="道具" then
            玩家数据[数字id].符石镶嵌=玩家数据[数字id].角色.道具[数据.装备]
        else
            玩家数据[数字id].符石镶嵌=玩家数据[数字id].角色.行囊[数据.装备]
        end
        发送数据(玩家数据[数字id].连接id,3550,{装备=self.数据[玩家数据[数字id].符石镶嵌]})
    elseif 序号==3801 then
        self:装备镶嵌符石(数字id,数据.内容)
    elseif 序号==3802 then
        self:翻转星石对话(数字id)
    elseif 序号==3803 then
        self:合成符石(连接id,数字id,数据)
    elseif 序号==3811 then
        self:灵犀之屑合成(连接id,数字id,数据)
    elseif 序号==3813 then
        self:镶嵌灵犀玉(数字id,数据)
    elseif 序号==3814 then
        self:激活天赋符(连接id,数字id,数据)



    elseif 序号==3823 then --
        self:一键学阵法(连接id,数字id,数据)

    elseif 序号==3815 then
        if 处理间隔(数字id) then
            return
        end
        self:整理背包(连接id,数字id)
    elseif 序号==3816 then
        self:武器染色(连接id,数字id,数据)
    elseif 序号==3816.2 then
        self:副武器染色(连接id,数字id,数据)
    elseif 序号==3817 then
        local 神器类=require("Script/角色处理类/神器类")()
        神器类:切换神器(数字id)
    elseif 序号==3818 then
        self:索要新道具1(连接id,数字id)
    elseif 序号==3817 then
        self:索要新道具2(连接id,数字id)
    elseif 序号==3818 then
        self:索要新道具3(连接id,数字id)

    ----归墟
    elseif 序号==3820 then
        归墟副本:归墟开启(连接id,数字id,数据)

        -------------
    elseif 序号==3888 then --灵宝丢弃
        self:丢弃灵宝(连接id,数字id,数据)
        -------------神器
    elseif 序号==3810.5 then
    self:武器转乾坤(连接id,数字id,数据)
  elseif 序号==3810.9 then
    self:乾坤双斧还原(连接id,数字id,数据)

    elseif 序号==3801.4 then
    self:进化宝宝(连接id,数字id,数据)
    elseif 序号==3801.5 then--采矿兑换栏
    self:兑换宝宝(连接id,数字id,数据)
  elseif 序号==3819 then
    self:灵饰自选(连接id,数字id,数据)

  elseif 序号 == 3900 then
        self:制作仙露丸子(连接id,数字id,数据.材料1,数据.材料2)
    elseif 序号 == 3901 then
    发送数据(连接id,16,玩家数据[数字id].召唤兽.数据)
    发送数据(玩家数据[数字id].连接id,352,{道具=玩家数据[数字id].道具:索要道具1(数字id),丸子赐福={进程=1,技能={},认证码=0}})
    elseif 序号 == 3902 then
      self:丸子赐福处理(连接id,数字id,数据.材料,数据.bb,数据.认证码,数据.锁定)
    elseif 序号 == 3903 then
      玩家数据[数字id].召唤兽:保存赐福技能(连接id,数字id,数据.bb,数据.认证码,数据.锁定,数据.技能)
    end
    数据=nil
end




function 道具处理类:制作仙露丸子(连接id,id,材料1,材料2)
    local 神兽涎=玩家数据[id].角色.道具[材料1]
    local 小丸子=玩家数据[id].角色.道具[材料2]
    if self.数据[神兽涎]==nil or self.数据[小丸子]==nil or self.数据[神兽涎].名称~="神兽涎" or self.数据[小丸子].名称~="仙露小丸子" then 常规提示(id,"道具数据有误,请忽移动背包道具") return end
    if self.数据[小丸子].数量 < 10 then 常规提示(id,"你的仙露小丸子不够10个哦") return end
    if 玩家数据[id].角色.体力 < 100 then 常规提示(id,"你没有那么多的体力！") return end
    玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-100
    self.数据[神兽涎].数量 = self.数据[神兽涎].数量 - 1
    self.数据[小丸子].数量 = self.数据[小丸子].数量 - 10
    if self.数据[神兽涎].数量 <= 0 then
        self.数据[神兽涎]=nil
        玩家数据[id].角色.道具[材料1]=nil
    end
    if self.数据[小丸子].数量 <= 0 then
        self.数据[小丸子]=nil
        玩家数据[id].角色.道具[材料2]=nil
    end
    self:给予道具(id,"仙露丸子",取随机数(2,6))
    发送数据(玩家数据[id].连接id,15,{体力=玩家数据[id].角色.体力,活力=玩家数据[id].角色.活力})
    发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
    发送数据(玩家数据[id].连接id,351,玩家数据[id].道具:索要道具1(id))
end

function 道具处理类:丸子赐福处理(连接id,id,材料,bbbh,认证码,锁定)
    local qsdcd=0
    local xhsx={[1]=1,[2]=5,[3]=25}
    for k,v in pairs(锁定) do
        qsdcd=qsdcd+1
    end
    if qsdcd > 2 then return end --防错，最多锁定2个技能
    local xiaohao = qsdcd + 1
    local 丸子=玩家数据[id].角色.道具[材料]
    if 玩家数据[id].召唤兽.数据[bbbh] == nil or  玩家数据[id].召唤兽.数据[bbbh].认证码~=认证码 then 常规提示(id,"召唤兽数据有误,请重新打开界面") return end
    if #玩家数据[id].召唤兽.数据[bbbh].技能 <= 3 then 常规提示(id,"垃圾召唤兽4技能都没有不配赐福") return end
    if self.数据[丸子]==nil or self.数据[丸子].名称~="仙露丸子" then 常规提示(id,"道具数据有误,请忽移动背包道具") return end
    if self.数据[丸子].数量 < xhsx[xiaohao] then 常规提示(id,"仙露丸子不足，本次赐福需要#R/" ..xhsx[xiaohao] .."#Y/个仙露丸子") return end
    self.数据[丸子].数量 = self.数据[丸子].数量 - xhsx[xiaohao]
    if self.数据[丸子].数量 <= 0 then
        self.数据[丸子]=nil
        玩家数据[id].角色.道具[材料]=nil
    end
    local wzcfjna=table.copy(丸子赐福技能)
    local q4jn={}
    -- for kv,nv in pairs(wzcfjna) do --删除wzcfjna里的锁定技能避免重复
    --     for nvb=1,4 do
    --         if 锁定[nvb]~=nil and (锁定[nvb]==nv or 锁定[nvb].名称==nv) then
    --             table.remove(wzcfjna,kv)
    --         end
    --     end
    -- end
    for kv = #wzcfjna, 1, -1 do
    local nv = wzcfjna[kv]
    for nvb = 1, 4 do
        if 锁定[nvb] ~= nil then
            -- 判断技能是否匹配（考虑锁定技能可能是字符串或带name的表）
            local 锁定技能名 = 锁定[nvb].名称 or 锁定[nvb]
            if nv == 锁定技能名 then
                table.remove(wzcfjna, kv) -- 从后往前删，不会影响前面的索引
                break -- 找到匹配的锁定技能，跳出内层循环
            end
        end
    end
end

    for nv=1,4 do
        if 锁定[nv] == nil then
            local sjq = 取随机数(1,#wzcfjna)
            q4jn[nv] = wzcfjna[sjq]
            table.remove(wzcfjna,sjq)
        else
              if 锁定[nv].名称 ~= nil then
                q4jn[nv] = 锁定[nv].名称
              else
                q4jn[nv] = 锁定[nv]
              end
        end
    end
    if 取随机数(1,1000) <= xhsx[xiaohao] then
        local hdcjjn=取赐福超级要诀()
        self:给予道具(id,"超级魔兽要诀",1,hdcjjn,"不存共享")
      发送数据(连接id,354,hdcjjn)
      发送公告("#G"..玩家数据[id].角色.名称.."#Y在仙露丸子赐福时，意外获得了超级神柚赠送的超级魔兽要诀#G【"..hdcjjn.."】#Y一本，鸿运当头，羡煞旁人！！")
    end
    if 取随机数(1,100) <= xhsx[xiaohao] then
        self:给予道具(id,"仙露小丸子",取随机数(8,12),nil,"不存共享")
    end
    if 取随机数(1,100) <= xhsx[xiaohao] then
        self:给予道具(id,"神兽涎",1,nil,"不存共享")
    end
    local jnz = {}
    for i,v in ipairs(q4jn) do
      if string.find(v,"高级") then
            v = 分割文本(v,"高级")
            v = v[2]
        end
        jnz[#jnz+1] = v
    end

    玩家数据[id].召唤兽.数据[bbbh].临时赐福 = jnz
    发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
    发送数据(玩家数据[id].连接id,353,{道具=玩家数据[id].道具:索要道具1(id),丸子赐福={进程=3,技能=q4jn,认证码=认证码}})
end

function 道具处理类:法宝附灵升级(id,s内容)
    local pid = s内容.s选中
    local 道具id = 玩家数据[id].角色.法宝[pid]
    if not 道具id or not self.数据[道具id] or self.数据[道具id].总类 ~= 1000 then
        添加最后对话(id,"只有法宝才可以哟，你这个是什么玩意？")
        return
    elseif not self.数据[道具id].附灵 then
        添加最后对话(id,"你这破法宝没有附灵哟")
        return
    end
    local 道具名 = self.数据[道具id].名称
    if not self.数据[道具id].附灵等级 then
        self.数据[道具id].附灵等级 = 1
    end
    if self.数据[道具id].附灵等级 >= 5 then
        添加最后对话(id,"最高5级")
        return
    end
    if 玩家数据[id].角色:扣除经验(取附灵需扣经验(self.数据[道具id].附灵等级)) then
        local 概率组 = {50,40,30,20,10} --1级、2级、3级...
        if 概率组[self.数据[道具id].附灵等级] >= 取随机数(1,100) then
            self.数据[道具id].附灵等级 = self.数据[道具id].附灵等级 + 1
            常规提示(id,"#Y" ..道具名 .."#W升级附灵成功")
            道具刷新(id)
            发送数据(玩家数据[id].连接id,3530.2,玩家数据[id].道具:索要法宝2(id,0))
        else
            常规提示(id,"#Y踩狗屎了吧你！附灵失败了")
        end
    else
        添加最后对话(id,"你的经验不足#R" ..取附灵需扣经验(self.数据[道具id].附灵等级))
    end
end

function 道具处理类:法宝清附灵处理(id,s内容)
    local pid = s内容.s选中
    local 道具id = 玩家数据[id].角色.法宝[pid]
    if not 道具id or not self.数据[道具id] or self.数据[道具id].总类 ~= 1000 then
        添加最后对话(id,"只有法宝才可以清除附灵哟，你这个是什么玩意？")
        return
    elseif not self.数据[道具id].附灵 then
        添加最后对话(id,"你这破法宝没有附灵哟")
        return
    end
    local 道具名 = self.数据[道具id].名称
    self.数据[道具id].附灵 = nil
    self.数据[道具id].附灵等级 = nil
    常规提示(id,"#Y" ..道具名 .."#W清除附灵成功")
    道具刷新(id)
    发送数据(玩家数据[id].连接id,3530.2,玩家数据[id].道具:索要法宝2(id,0))
end

function 道具处理类:法宝附灵处理(id,s内容)
    local pid = s内容.s选中
    local 道具id = 玩家数据[id].角色.法宝[pid]
    if not 道具id or not self.数据[道具id] or self.数据[道具id].总类 ~= 1000 then
        添加最后对话(id,"只有法宝才可以附灵哟，你这个是什么玩意？")
        return
    elseif self.数据[道具id].附灵 then
        添加最后对话(id,"请先清除附灵哟")
        return
    elseif not self.数据[道具id].气血 or self.数据[道具id].气血 < 18 then
        添加最后对话(id,"18级法宝才可以附灵哟")
        return
    end
        local xxx = ""
        local 道具名 = self.数据[道具id].名称
        local gogo = false
        local data = {"蟠龙玉璧","凌波仙符","落星飞鸿","重明战鼓","流影云笛","归元圣印","千斗金樽","梦云幻甲","河图洛书","太虚玉液","宿幕星河","琉璃云罩","北冥巨鳞"}
        local 附灵data = {
            蟠龙玉璧 = true,
            凌波仙符 = true,
          落星飞鸿 = true,
          重明战鼓 = true,
          流影云笛 = true,
          归元圣印 = true,
          千斗金樽 = true,
          梦云幻甲 = true,
          河图洛书 = true,
          太虚玉液 = true,
          宿幕星河 = true,
          琉璃云罩 = true,
          北冥巨鳞 = true,
        }
        for kk,vv in ipairs(data) do
            if vv == 道具名 then
                gogo = true
                break
            end
        end
        -- print(道具名,gogo,附灵data[道具名],"==========87989")
        xxx = table.concat(data,"、")
        if not gogo or not 附灵data[道具名] then
            添加最后对话(id,"只有以下法宝才可附灵\n" ..xxx)
            return
        end
        if not self.数据[道具id].附灵等级 then
            self.数据[道具id].附灵等级 = 1
        end
        local fulinga = {"叶障","泉愈","岚载"}
        self.数据[道具id].附灵 = fulinga[取随机数(1,3)]
        常规提示(id,"#Y" ..道具名 .."#W附灵成功")
        道具刷新(id)
        发送数据(玩家数据[id].连接id,3530.2,玩家数据[id].道具:索要法宝2(id,0))
end

function 道具处理类:出售收购道具(连接id,id,对方id,数据)--(id,ItemNum,BuyNum,数量)
    if 玩家数据[id].摊位id == nil then
        发送数据(玩家数据[id].连接id, 7, "#y/这样的摊位不存在")
        return 0
    else
        local ItemNum=数据.选中
        local BuyNum=数据.编号
        local 数量= tonumber(数据.数量)
        if not 判断是否为数字(数量) then
            常规提示(id,"#Y/数据异常，请不要违规操作，否则封号处理")
            return
        end
        self.摊位id = 玩家数据[id].摊位id
        if 收购数据[self.摊位id] == nil or 收购数据[self.摊位id].状态 == false or 玩家数据[self.摊位id] == nil then
            发送数据(玩家数据[id].连接id, 7, "#y/这样的摊位不存在")
            return 0
        elseif 玩家数据[id].查看摊位 <= 收购数据[self.摊位id].刷新 or 收购数据[self.摊位id].道具[BuyNum] == nil then
            发送数据(玩家数据[id].连接id, 7, "#y/该摊位商品发生了变化，请稍后再试")
            发送数据(玩家数据[id].连接id, 3543, {收购数据=收购数据[self.摊位id].道具})
            玩家数据[id].查看摊位 = os.time()
            return 0
        end
        self.购买数量 = math.floor(tonumber(数量))
        if self.购买数量 <1 or self.购买数量 > 99999 then
            发送数据(玩家数据[id].连接id, 7, "#y/请输入正确的出售数量")
            return 0
        end
        local ItemID = 玩家数据[id].角色.道具[ItemNum]
        local ItemTemp = 玩家数据[id].道具.数据[ItemID]
        local ItemName = ItemTemp.名称
        if not ItemTemp  or not  ItemData[ItemTemp.名称] then
            发送数据(玩家数据[id].连接id, 7, "#y/你没有这样的道具")
            发送数据(玩家数据[id].连接id, 3544, {道具=玩家数据[id].道具:索要道具1(id)})
            return
        else
            local 物品数量 = ItemTemp.数量 or 1
            if 物品数量 < self.购买数量 then
                发送数据(玩家数据[id].连接id, 7, "#y/你没有这么多数量的道具")
                return
            elseif 收购数据[self.摊位id].道具[BuyNum].数量  < self.购买数量 then
                发送数据(玩家数据[id].连接id, 7, "#y/对方收购不了这么多数量的道具")
                return
            end
            local 手续费 = math.ceil(收购数据[self.摊位id].道具[BuyNum].单价*0.05)
            if 手续费 < 5000 then 手续费 = 5000 end
            self.扣除价格 = (收购数据[self.摊位id].道具[BuyNum].单价+手续费)*self.购买数量
            if 玩家数据[self.摊位id].角色.银子<self.扣除价格 then
                发送数据(玩家数据[id].连接id, 7, "#y/对方没有那么多的银子收购物品")
                return 0
            end
            local 临时格子=玩家数据[self.摊位id].角色:取道具格子()
            if 临时格子 == 0 then
                发送数据(玩家数据[id].连接id, 7, "#y/对方的包裹空间不足")
                return 0
            end
            local 名称=玩家数据[self.摊位id].角色.名称
            local 名称1=玩家数据[id].角色.名称
            local 账号=玩家数据[self.摊位id].账号
            local 账号1=玩家数据[id].账号
            local 新道具=玩家数据[self.摊位id].道具:取新编号()
            local 道具名称=ItemTemp.名称
            local 道具识别码=ItemTemp.识别码
            玩家数据[self.摊位id].角色:扣除银子(self.扣除价格,0,0,"摊位购买",1)
            玩家数据[self.摊位id].角色:日志记录(format("[收购系统-收购]花费" .. self.扣除价格 .. "两银子购买"..收购数据[self.摊位id].道具[BuyNum].名称.."，出售者=" .. 玩家数据[id].账号))
            玩家数据[id].角色:日志记录(format("[收购系统-出售]获得" .. 收购数据[self.摊位id].道具[BuyNum].单价*self.购买数量 .. "两银子，出售了" .. 收购数据[self.摊位id].道具[BuyNum].名称 .. "，收购者=" .. 玩家数据[self.摊位id].账号))
            玩家数据[id].角色:添加银子(收购数据[self.摊位id].道具[BuyNum].单价*self.购买数量,"摊位出售",1)
            玩家数据[self.摊位id].道具.数据[新道具]=table.loadstring(table.tostring(ItemTemp))
            玩家数据[self.摊位id].道具.数据[新道具].数量=self.购买数量
            玩家数据[self.摊位id].角色.道具[临时格子]=新道具
            if ItemTemp.数量 ~= nil and ItemTemp.数量 >= 1 then
                ItemTemp.数量 = ItemTemp.数量 - self.购买数量
                if ItemTemp.数量 < 1 then
                    玩家数据[id].角色.道具[ItemNum] = nil
                    玩家数据[id].道具.数据[ItemID] = nil
                end
            else
                玩家数据[id].角色.道具[ItemNum] = nil
                玩家数据[id].道具.数据[ItemID] = nil
            end
            收购数据[self.摊位id].道具[BuyNum].数量 = 收购数据[self.摊位id].道具[BuyNum].数量 - self.购买数量
            if 收购数据[self.摊位id].道具[BuyNum].数量 < 1 then
                table.remove(收购数据[self.摊位id].道具, BuyNum)
            end
            常规提示(id,"#w/出售#g/" .. ItemName .. "*" .. self.购买数量 .. "#w/获得#r/" .. self.扣除价格 .. "#w/两银子")
            发送数据(玩家数据[self.摊位id].连接id, 7, "#g/您花费了#r/" .. self.扣除价格 .. "#w/两银子购买了#g/" .. ItemName .. "*" .. self.购买数量)
            收购数据[self.摊位id].记录 = 收购数据[self.摊位id].记录 .. os.date("[%Y年%m月%d日%X]") .. "#h/收购#g/" .. ItemName .. "*" .. self.购买数量 .. "#h/获得#r/" .. self.扣除价格 .. "#w/两银子" .. "\n"
            发送数据(玩家数据[id].连接id, 3543.1, {收购数据=收购数据[self.摊位id].道具})
            发送数据(玩家数据[self.摊位id].连接id, 3539.1, {道具数据=收购数据[self.摊位id].道具})
            发送数据(玩家数据[id].连接id, 3544.1, {道具=玩家数据[id].道具:索要道具1(id)})
            收购数据[self.摊位id].刷新 = os.time()
            玩家数据[id].查看摊位 = os.time() + 1
            道具刷新(id)
            道具刷新(self.摊位id)
        end
    end
end

function 道具处理类:发送玩家收购摊位(连接id,id,玩家编号)
    if 玩家数据[玩家编号] == nil then
       常规提示(id,"#Y/这个摊位并不存在")
        return
    elseif 收购数据[玩家编号] == nil or 收购数据[玩家编号].状态 == false then
        常规提示(id,"#Y/这个摊位并不存在")
        return
    end
    收购数据[玩家编号].次数 = 收购数据[玩家编号].次数 + 1
    发送数据(玩家数据[id].连接id, 3542, {
        id = 玩家编号,
        名称 = 收购数据[玩家编号].名称,
        银子 = 玩家数据[id].角色.银子,
        角色 = 玩家数据[玩家编号].角色.名称
    })
    发送数据(玩家数据[id].连接id, 3543.1, {收购数据=收购数据[玩家编号].道具})
    发送数据(玩家数据[id].连接id, 3544.1, {道具=self:索要道具1(id)})
    玩家数据[id].查看摊位 = os.time()
    玩家数据[id].摊位id = 玩家编号
end

function 道具处理类:收购收摊处理(连接id,id)
    收购数据[id]=nil
    玩家数据[id].离线摆摊=nil
    常规提示(id,"#Y/收摊回家玩老婆去咯！")
    发送数据(连接id,3541)
    地图处理类:取消收购摊位(id)
end

function 道具处理类:更改收购招牌(连接id,id,名称)
    if 收购数据[id]==nil then return end
    if os.time()-收购数据[id].更新<=1 then
        常规提示(id,"#Y/请不要频繁更换招牌")
        return
    end
    常规提示(id,"#Y/更新招牌成功")
    收购数据[id].更新=os.time()
    收购数据[id].名称 = 名称--敏感文本替换(名称)
    收购数据[id].摆摊 = id
    发送数据(连接id,3540,收购数据[id].名称)
    地图处理类:设置收购摊位(id,收购数据[id].名称)
end

function 道具处理类:删除收购道具(连接id,id,内容)
    table.remove(收购数据[id].道具, 内容.名称)
    发送数据(玩家数据[id].连接id, 3539.1, {道具数据=收购数据[id].道具})
end

function 道具处理类:添加收购道具(连接id,id,内容)
    local 单价 = 内容.单价
    local 数量 = 内容.数量
    if not 判断是否为数字(单价) or not 判断是否为数字(数量) then
        常规提示(id,"#Y/数据异常，请不要违规操作，否则封号处理")
        return
    end
    local 临时表 = {名称=内容.名称,数量=数量,单价=单价}
    if 内容.重点 ~= nil or 内容.重点 ~= "" then
        临时表.重点 = 内容.重点
    end
    table.insert(收购数据[id].道具, 临时表)
    发送数据(玩家数据[id].连接id, 3539.1, {道具数据=收购数据[id].道具})
end

function 道具处理类:索要收购摊位数据(连接id,id,序号)
      if 玩家数据[id].摊位数据~=nil then
        常规提示(id,"#Y/摆摊状态下无法收购")
        return
    elseif 玩家数据[id].队伍~=0 then
         常规提示(id,"#Y/组队状态下无法摆摊")
        return
    elseif 玩家数据[id].角色.飞行中 then
         常规提示(id,"#Y/飞行状态下无法摆摊")
        return
    else
        local 地图=玩家数据[id].角色.地图数据.编号
        if 地图~=1001 and 地图~=1501 and 地图~=1070 and 地图~=1092 and 地图~=1208 and 地图~=1226 and 地图~=1040 then
            常规提示(id,"#Y/该场景无法摆摊")
            return
        elseif 玩家数据[id].角色.等级<30 then
            常规提示(id,"#Y/只有等级达到30级的玩家才可使用摆摊功能")
            return
        end
    end
   if 收购数据[id] == nil then
        收购数据[id] = {
            状态 = true,
            记录 = "",
            名称 = "收购摊位",
            次数 = 0,
            道具 = {},
            更新 = os.time(),
            刷新 = os.time()
        }
    end
    收购数据[id].状态 = true
    地图处理类:设置收购摊位(id,"收购摊位")
    发送数据(玩家数据[id].连接id, 3540, 收购数据[id].名称)
    发送数据(连接id,序号,{收购数据=收购数据[id],银子=玩家数据[id].角色.银子})
end

local function 灵饰处理(id,道具id,等级,强化,类型)
  玩家数据[id].道具.数据[道具id].耐久=500
  玩家数据[id].道具.数据[道具id].部位类型=类型
  玩家数据[id].道具.数据[道具id].幻化属性={附加={}}
  玩家数据[id].道具.数据[道具id].制造者=玩家数据[id].角色.名称
  玩家数据[id].道具.数据[道具id].识别码=id.."_"..os.time().."_"..取随机数(1,999).."_"..随机序列
  local 临时属性=灵饰属性[类型].主属性[取随机数(1,#灵饰属性[类型].主属性)]
  local 临时数值=灵饰主属性[临时属性][等级].b
  local 临时下限=灵饰主属性[临时属性][等级].a
  -- local 临时数值=取随机数(临时下限,临时数值)
  local 上限数量=3
  if 强化 then
    玩家数据[id].道具.数据[道具id].制造者=玩家数据[id].角色.名称.."强化打造"
    上限数量=4
  end
  玩家数据[id].道具.数据[道具id].幻化属性.基础={类型=临时属性,数值=临时数值,强化=0}
  for n=1,取随机数(1,上限数量) do
    临时属性=灵饰属性[类型].副属性[取随机数(1,#灵饰属性[类型].副属性)]
    临时数值=灵饰副属性[临时属性][等级].b
    临时下限=灵饰副属性[临时属性][等级].a
    -- 临时数值=取随机数(临时下限,临时数值)
    玩家数据[id].道具.数据[道具id].幻化属性.附加[n]={类型=临时属性,数值=临时数值,强化=0}
  end
  玩家数据[id].道具.数据[道具id].灵饰=true
  玩家数据[id].道具.数据[道具id].鉴定=true
  玩家数据[id].道具.数据[道具id].特效="无级别限制"
end
function 道具处理类:自选灵饰处理(id,名称,等级,类型,副属性)

    local 临时道具 =物品类()
    临时道具:置对象(名称)
    临时道具.级别限制 = 等级
    临时道具.幻化等级=0
    临时道具.部位类型=类型
    临时道具.灵饰=true
    临时道具.耐久=500
    临时道具.鉴定=false
    临时道具.幻化属性={附加={},}
    临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    随机序列=随机序列+1
    self.临时属性=灵饰属性[类型].主属性[取随机数(1,#灵饰属性[类型].主属性)]
    self.临时数值=灵饰主属性[self.临时属性][等级].b
    self.临时下限=灵饰主属性[self.临时属性][等级].a
    self.临时数值=取随机数(self.临时下限,self.临时数值)
    临时道具.幻化属性.基础={类型=self.临时属性,数值=self.临时数值,强化=0}
    for n=1,3 do
        self.临时属性=副属性
        if n>1 and RpbARGB.序列==3 and 取随机数()<=30 then
               self.临时属性=临时道具.幻化属性.附加[1].类型
        end
        self.临时数值=灵饰副属性[self.临时属性][等级].b
        self.临时下限=灵饰副属性[self.临时属性][等级].a
        self.临时数值=取随机数(self.临时下限,self.临时数值)
        for i=1,#临时道具.幻化属性.附加 do
            if 临时道具.幻化属性.附加[i].类型==self.临时属性 then
                self.临时数值=临时道具.幻化属性.附加[i].数值
            end
        end
        临时道具.幻化属性.附加[n]={类型=self.临时属性,数值=self.临时数值,强化=0}
    end
    -- if RpbARGB.序列~=5 then
    --    临时道具.专用=id
    -- end

    --临时道具.特效="超级简易"
    return 临时道具
end

function 道具处理类:灵饰自选(连接id,id,数据)
  local 临时格子=玩家数据[id].角色:取道具格子()
  if 临时格子 == 0 then 常规提示(id,"#Y你身上没有足够的空间") return  end
  if 玩家数据[id].道具操作==nil or 玩家数据[id].最后操作 == nil then 常规提示(id,"#Y生成异常请重新生成") return  end
  local 编号=玩家数据[id].道具操作.编号
  local 道具id=玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]
  if 道具id==nil or self.数据[道具id]==nil or 玩家数据[id].最后操作 ~= "灵饰自选" then
    常规提示(id,"#Y你没有这样的道具或者请勿移动道具")
    return
  end
  local itemm = self.数据[道具id].名称
  local itemc
  local itemd
  local itemb
  local 词条数量 = 4
  if  itemm=="悦碧水" then
    itemc = "悦碧水"
    itemd = 120
    itemb = "戒指"
  elseif itemm=="九曜光华" then
    itemc = "九曜光华"
    itemd = 140
    itemb = "戒指"
  elseif itemm=="太虚渺云" then
    itemc = "太虚渺云"
    itemd = 160
    itemb = "戒指"

  elseif itemm=="花映月" then
    itemc = "花映月"
    itemd = 120
    itemb = "手镯"
  elseif itemm=="金水菩提" then
    itemc = "金水菩提"
    itemd = 140
    itemb = "手镯"
  elseif itemm=="浮雪幻音" then
    itemc = "浮雪幻音"
    itemd = 160
    itemb = "手镯"

  elseif itemm=="相思染" then
    itemc = "相思染"
    itemd = 120
    itemb = "佩饰"
  elseif itemm=="玄龙苍珀" then
    itemc = "玄龙苍珀"
    itemd = 140
    itemb = "佩饰"
  elseif itemm=="碧海青天" then
    itemc = "碧海青天"
    itemd = 160
    itemb = "佩饰"

  elseif itemm=="点星芒" then
    itemc = "点星芒"
    itemd = 120
    itemb = "耳饰"
  elseif itemm=="凤羽流苏" then
    itemc = "凤羽流苏"
    itemd = 140
    itemb = "耳饰"
  elseif itemm=="焰云霞珠" then
    itemc = "焰云霞珠"
    itemd = 160
    itemb = "耳饰"
  elseif  itemm=="金麟绕" then
    itemc = "金麟绕"
    itemd = 100
    itemb = "戒指"
  elseif itemm=="芙蓉戒" then
    itemc = "芙蓉戒"
    itemd = 80
    itemb = "戒指"
  elseif itemm=="墨影扣" then
    itemc = "墨影扣"
    itemd = 100
    itemb = "手镯"
  elseif itemm=="翡玉镯" then
    itemc = "翡玉镯"
    itemd = 80
    itemb = "手镯"
  elseif itemm=="莲音玦" then
    itemc = "莲音玦"
    itemd = 100
    itemb = "佩饰"
  elseif itemm=="逸云佩" then
    itemc = "逸云佩"
    itemd = 80
    itemb = "佩饰"
  elseif itemm=="玉蝶翩" then
    itemc = "玉蝶翩"
    itemd = 100
    itemb = "耳饰"
  elseif itemm=="明月珰" then
    itemc = "明月珰"
    itemd = 80
    itemb = "耳饰"
  elseif itemm=="枫华戒" then
    itemc = "枫华戒"
    itemd = 60
    itemb = "戒指"
  elseif itemm=="翠叶环" then
    itemc = "翠叶环"
    itemd = 60
    itemb = "耳饰"
  elseif itemm=="香木镯" then
    itemc = "香木镯"
    itemd = 60
    itemb = "手镯"
  elseif itemm=="芝兰佩" then
    itemc = "芝兰佩"
    itemd = 60
    itemb = "佩饰"
  end
  self.数据[道具id] = nil
  local 道具 = 物品类()
  --道具.专用=id
  --道具.不可交易=true
  道具:置对象(itemc)
  道具.级别限制 = itemd
  道具.幻化等级=0
  self.数据[道具id]=道具
  self.数据[道具id].部位类型=itemb
  灵饰处理(id,道具id,itemd,nil,itemb)
  self.数据[道具id].制造者 = "自选"
  if 数据.幻化属性.基础  and 灵饰主属性[数据.幻化属性.基础.类型] and 灵饰主属性[数据.幻化属性.基础.类型][itemd] then
    local 数值 = 灵饰主属性[数据.幻化属性.基础.类型][itemd].b
    self.数据[道具id].幻化属性.基础.类型 = 数据.幻化属性.基础.类型
    self.数据[道具id].幻化属性.基础.数值 = 数值
  end
  self.数据[道具id].幻化属性.附加={}
  for i=1,词条数量 do
    if 数据.幻化属性.附加[i] and 灵饰副属性[数据.幻化属性.附加[i].类型] and 灵饰副属性[数据.幻化属性.附加[i].类型][itemd] then
      local 数值 = 灵饰副属性[数据.幻化属性.附加[i].类型][itemd].b
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加+1]={}
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加].类型 = 数据.幻化属性.附加[i].类型
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加].数值 = 数值
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加].强化 = 0
    end
  end
  常规提示(id,"#Y/你得到了#R/"..self.数据[道具id].名称)
  道具刷新(id)
end

--消耗背包道具
function 道具处理类:兑换宝宝(连接id,id,数据)
    local 参数=数据.参数
    local 名称=玩家数据[id].角色.名称
    if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
        常规提示(id, "#Y/召唤兽已满，需保留一个召唤兽格子")
        return
    end
    if 参数== 1 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",20) then
            礼包奖励类:挖矿宝宝(id,"小毛头","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐20个地心印记，在采矿大使兑换了#G小毛头#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“20个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 2 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",20) then
            礼包奖励类:挖矿宝宝(id,"小丫丫","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐20个地心印记，在采矿大使兑换了#G小丫丫#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“20个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 3 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",20) then
            礼包奖励类:挖矿宝宝(id,"小仙灵","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐20个地心印记，在采矿大使兑换了#G小仙灵#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“20个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 4 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",20) then
            礼包奖励类:挖矿宝宝(id,"小仙女","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐20个地心印记，在采矿大使兑换了#G小仙女#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“20个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 5 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",20) then
            礼包奖励类:挖矿宝宝(id,"小精灵","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐20个地心印记，在采矿大使兑换了#G小精灵#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“20个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 6 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",20) then
            礼包奖励类:挖矿宝宝(id,"小魔头","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐20个地心印记，在采矿大使兑换了#G小魔头#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“20个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 7 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",50) then
            礼包奖励类:挖矿宝宝1(id,"进阶小毛头","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐50个地心印记，在采矿大使兑换了#G进阶小毛头#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“50个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 8 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",50) then
            礼包奖励类:挖矿宝宝1(id,"进阶小丫丫","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐50个地心印记，在采矿大使兑换了#G进阶小丫丫#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“50个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 9 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",50) then
            礼包奖励类:挖矿宝宝1(id,"进阶小仙灵","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐50个地心印记，在采矿大使兑换了#G进阶小仙灵#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“50个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 10 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",50) then
            礼包奖励类:挖矿宝宝1(id,"进阶小仙女","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐50个地心印记，在采矿大使兑换了#G进阶小仙女#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“50个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 11 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",50) then
            礼包奖励类:挖矿宝宝1(id,"进阶小精灵","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐50个地心印记，在采矿大使兑换了#G进阶小精灵#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“50个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    elseif 参数== 12 then
        if self:消耗背包道具(玩家数据[id].连接id,id,"地心印记",50) then
            礼包奖励类:挖矿宝宝1(id,"进阶小魔头","宝宝",0)
            发送公告("#Y恭喜少侠#G“"..名称.."”#Y集齐50个地心印记，在采矿大使兑换了#G进阶小魔头#Y！")
        else
            常规提示(id,"#Y/少侠还没有集齐“50个地心印记”，不能兑换哦！")
        end
        道具刷新(id)
    end
end

function 道具处理类:武器转乾坤(连接id,数字id,数据)
    if 数据.乾坤==nil or 数据.编号==nil then 常规提示(数字id,"数据错误请关闭界面重来") end
    local 道具编号 = 玩家数据[数字id].角色.道具[数据.编号+0]
    if self.数据[道具编号]==nil or self.数据[道具编号].识别码~=数据.识别码 then
        常规提示(数字id,"道具数据错误，请乎移动道具位置")
        return
    elseif string.find(self.数据[道具编号].名称,"(乾)")~=nil or string.find(self.数据[道具编号].名称,"(坤)")~=nil then
      常规提示(数字id,"双斧禁止乾坤互换，需要还原才能铸造！")
        return
    elseif self.数据[道具编号].总类~=2 or self.数据[道具编号].分类~=3 then
        常规提示(数字id,"只有武器可以转换")
        return
    elseif not self.数据[道具编号].鉴定 then
      常规提示(数字id,"未鉴定武器不可转换")
        return
    elseif self.数据[道具编号].等级 < 10 then
      常规提示(数字id,"10级以上武器才可转换")
        return
    -- elseif 玩家数据[数字id].角色.体力 < 200 or 玩家数据[数字id].角色.活力 < 200 then
    --     常规提示(数字id, "体活不足，需要各200！")
    --     return
    end
    -- 玩家数据[数字id].角色:扣除体力(200)
    -- 玩家数据[数字id].角色:扣除活力(200)
    local 临时名称
    local zhfl
    local abc = 绑定等级物品()
    if 数据.乾坤==1 then
        local qwqsj = math.floor(self.数据[道具编号].等级/10)+1
        临时名称 = abc[27][qwqsj]
        zhfl = 3
    elseif 数据.乾坤==2 then
        local qwqsj = math.floor(self.数据[道具编号].等级/10)+1
        临时名称 = abc[28][qwqsj]
        zhfl = 4
        if self.数据[道具编号].临时附魔 ~= nil  then
          for k,v in pairs(self.数据[道具编号].临时附魔) do
                if v.数值  then
                            玩家数据[self.玩家id].角色:清除装备附魔属性(self.数据[道具编号],self.数据[道具编号].分类,k,v.数值)
                            self.数据[道具编号].临时附魔[k] = nil
                            常规提示(self.玩家id,"#Y你装备上的附魔特效消失了！")
                end
             end
        end
         if self.数据[道具编号].武器专属 ~= nil then
            self.数据[道具编号].武器专属 = nil
        end
    end
    local 临时武器数据 = 取物品数据(临时名称)
    self.数据[道具编号].乾坤记录=self.数据[道具编号].名称
    self.数据[道具编号].名称 = 临时名称
    self.数据[道具编号].分类 = zhfl
    self.数据[道具编号].子类 = 临时武器数据[4]
    if 数据.乾坤==1 then
        self.数据[道具编号].性别限制=0
    else
        self.数据[道具编号].性别限制="女"
    end
    self.数据[道具编号].角色限制 = 临时武器数据[7]

    if self.数据[道具编号].套装效果 ~= nil  then
            self.数据[道具编号].套装效果 = nil
            常规提示(self.玩家id,"#Y你装备上的套装效果消失了！")
    end
    if self.数据[道具编号].光武拓印 then
            self.数据[道具编号].原始光武拓印 = self.数据[道具编号].光武拓印
            self.数据[道具编号].光武拓印 = nil
    end


    添加最后对话(数字id,"你的武器已转换为#R" ..临时名称)
    道具刷新(数字id)
    发送数据(连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
end

function 道具处理类:乾坤双斧还原(连接id,数字id,数据)
    if 数据.编号==nil then 常规提示(数字id,"数据错误请关闭界面重来") end
    local 道具编号 = 玩家数据[数字id].角色.道具[数据.编号+0]
    if self.数据[道具编号]==nil or self.数据[道具编号].识别码~=数据.识别码 then
        常规提示(数字id,"道具数据错误，请乎移动道具位置")
        return
    elseif string.find(self.数据[道具编号].名称,"(乾)")==nil and string.find(self.数据[道具编号].名称,"(坤)")==nil then
      常规提示(数字id,"只有双斧可以还原")
        return
    elseif self.数据[道具编号].总类~=2 or (self.数据[道具编号].分类~=3 and self.数据[道具编号].分类~=4) then
        常规提示(数字id,"只有武器可以还原")
        return
    elseif not self.数据[道具编号].鉴定 then
      常规提示(数字id,"未鉴定武器不可还原")
        return
    elseif self.数据[道具编号].等级 < 10 then
      常规提示(数字id,"10级以上武器才可转换")
        return
    -- elseif 玩家数据[数字id].角色.体力 < 200 or 玩家数据[数字id].角色.活力 < 200 then
    --     常规提示(数字id, "体活不足，需要各200！")
    --     return
    end
    if self.数据[道具编号].套装效果 ~= nil  then
            self.数据[道具编号].套装效果 = nil
            常规提示(数字id,"#Y你装备上的套装效果消失了！")
   end
   if self.数据[道具编号].临时附魔 ~= nil  then
      for k,v in pairs(self.数据[道具编号].临时附魔) do
            if v.数值  then
                        玩家数据[self.玩家id].角色:清除装备附魔属性(self.数据[道具编号],self.数据[道具编号].分类,k,v.数值)
                        self.数据[道具编号].临时附魔[k] = nil
                        常规提示(self.玩家id,"#Y你装备上的附魔特效消失了！")
            end
         end
    end
                -------------------------------C改
    if self.数据[道具编号].光武拓印 then
            self.数据[道具编号].原始光武拓印 = self.数据[道具编号].光武拓印
            self.数据[道具编号].光武拓印 = nil
    end
    -- 玩家数据[数字id].角色:扣除体力(200)
    -- 玩家数据[数字id].角色:扣除活力(200)
    local 临时名称
    if self.数据[道具编号].乾坤记录~=nil then
        临时名称 = self.数据[道具编号].乾坤记录
        local 临时武器数据 = 取物品数据(临时名称)
        self.数据[道具编号].名称 = 临时名称
        self.数据[道具编号].分类 = 3
        self.数据[道具编号].子类 = 临时武器数据[4]
        self.数据[道具编号].角色限制 = 临时武器数据[7]
    else
        local abc = 绑定等级物品()
      local qwqsj = math.floor(self.数据[道具编号].等级/10)+1
      local sjwq = 取随机数(1,18)
        临时名称 = abc[sjwq][qwqsj]
        local 临时武器数据 = 取物品数据(临时名称)
        self.数据[道具编号].名称 = 临时名称
        self.数据[道具编号].分类 = 3
        self.数据[道具编号].子类 = 临时武器数据[4]
        self.数据[道具编号].性别限制=0
        self.数据[道具编号].角色限制 = 临时武器数据[7]
    end

    self.数据[道具编号].乾坤记录=nil
    添加最后对话(数字id,"你的武器已转换为#R" ..临时名称)
    道具刷新(数字id)
    发送数据(连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
end

function 道具处理类:进化宝宝(连接id,id,数据)
  local 操作类型=数据.操作
  local 操作编号=数据.序列
  if 玩家数据[id].召唤兽.数据[操作编号]==nil  then
    return
  end
  if 玩家数据[id].召唤兽.数据[操作编号].种类~="神兽"  then
  常规提示(id,"#Y/神兽才可以进化！")
    return
  end

if 操作类型=="进化宝宝" then
if 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数>=5 then
  常规提示(id,"#Y/少侠召唤兽已进化5次,无法继续进化！")
  return
end
if 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==0 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",10) then
 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
          常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第一次进化需要10个五彩神石！")
 end
elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==1 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",20) then
 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
  玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G50,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
          常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第二次进化需要20个五彩神石！")
 end
elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==2 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",30) then
 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
  玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G50,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
          常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第三次进化需要30个五彩神石！")
 end
elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==3 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",40) then
 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
  玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G50,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
          常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第四次进化需要40个五彩神石！")
 end
elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==4 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",50) then
 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
  玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
 if  玩家数据[id].召唤兽.数据[操作编号].种类=="神兽" then
 玩家数据[id].召唤兽.数据[操作编号].种类="特殊神兽"
常规提示(id,"恭喜你的召唤兽已进化为#R特殊神兽")
else
 玩家数据[id].召唤兽.数据[操作编号].种类="神兽"
常规提示(id,"恭喜你的召唤兽已进化为#R神兽")
end
常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G50,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
          常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第五次进化需要50个五彩神石！")
end
elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==5 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",60) then
 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
  玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")


玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
          常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第六次进化需要60个五彩神石！")
end
elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==6 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",70) then
 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
  玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
常规提示(id,"恭喜你的召唤兽#R 200,#R体力资质#W + #G100,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
         常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第七次进化需要70个五彩神石！")
end
elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==7 then
 if self:消耗背包道具(玩家数据[id].连接id,id,"五彩神石",80) then
玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
  玩家数据[id].召唤兽.数据[操作编号].成长 = 玩家数据[id].召唤兽.数据[操作编号].成长  + 0.05
 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
常规提示(id,"恭喜你的召唤兽 #G200,#R体力资质#W + #G100,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
发送数据(连接id,16,玩家数据[id].召唤兽.数据)
else
          常规提示(id,"#Y/少侠还没有集齐“五彩神石”，第八次进化需要80个五彩神石！")
end
end
end
end
-- function 道具处理类:进化宝宝(连接id,id,数据)
--     local 操作类型=数据.操作
--     local 操作编号=数据.序列
--     if 玩家数据[id].召唤兽.数据[操作编号]==nil  then
--         常规提示(id,"#Y/你没有这个召唤兽")
--         return
--     end
--      -- if 操作类型=="进化宝宝" then
--         -- if 玩家数据[id].召唤兽.数据[操作编号].成长< 1.29 then
--             -- 常规提示(id,"#Y/少侠召唤兽成长低于1.29无法进化！")
--             -- return
--         -- elseif 玩家数据[id].召唤兽.数据[操作编号].种类~="宝宝" then
--             -- 常规提示(id,"#Y/少侠只有是宝宝的召唤兽才可以进化为#R神兽！")
--             -- return
--         -- end
--           -- if not 玩家数据[id].角色:扣除仙玉( 5000, 操作类型) then--消耗的仙玉--你删掉这个了
--                 -- return false
--             -- end
--             -- 玩家数据[id].召唤兽.数据[操作编号].种类="神兽"
--             -- 常规提示(id,"恭喜你的召唤兽已进化为#R神兽")
--             -- 玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
--             -- 发送数据(连接id,16,玩家数据[id].召唤兽.数据)
--         if 操作类型=="进阶宝宝" then
--             if 玩家数据[id].召唤兽.数据[操作编号].种类~="神兽" then
--                 常规提示(id,"#Y/少侠只有是神兽的召唤兽才可以进化为#R特殊神兽！")
--                 return
--             end
--             if not 玩家数据[id].角色:扣除仙玉( 8888, 操作类型) then--消耗的仙玉
--                 return false
--             end
--                 玩家数据[id].召唤兽.数据[操作编号].种类="特殊神兽"
--                 常规提示(id,"恭喜你的召唤兽已进化为#R特殊神兽")
--                 玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
--                 发送数据(连接id,16,玩家数据[id].召唤兽.数据)
--     end
-- end


function 道具处理类:武器染色(连接id,id,内容)
    if 玩家数据[id].角色.装备[3] ==nil then
        return
    end
    local 武器id=玩家数据[id].角色.装备[3]
    self.数据[武器id].炫彩 = nil
    if 玩家数据[id].角色:扣除银子(30000000,0,0,"购买银两",1) then
        if self.数据[武器id].染色方案==nil then
            self.数据[武器id].染色方案=0
        end
        if self.数据[武器id].染色组==nil then
            self.数据[武器id].染色组={}
        end
        self.数据[武器id].染色方案 = 内容.染色id
        self.数据[武器id].染色组[1] = 内容.炫彩[1]
        self.数据[武器id].染色组[2] = 内容.炫彩[2]
        添加最后对话(id,"染色成功！换个颜色换个心情#3")
        发送数据(连接id,30.1, {武器 = self.数据[武器id]})
        地图处理类:更新武器(id)
    end
end
function 道具处理类:副武器染色(连接id,id,内容)
    if 玩家数据[id].角色.装备[4] ==nil then
        return
    end
    local 武器id=玩家数据[id].角色.装备[4]

    self.数据[武器id].炫彩 = nil
    if 玩家数据[id].角色:扣除银子(30000000,0,0,"购买银两",1) then
        if self.数据[武器id].染色方案==nil then
            self.数据[武器id].染色方案=0
        end
        if self.数据[武器id].染色组==nil then
            self.数据[武器id].染色组={}
        end
        self.数据[武器id].染色方案 = 内容.染色id
        self.数据[武器id].染色组[1] = 内容.炫彩[1]
        self.数据[武器id].染色组[2] = 内容.炫彩[2]
        添加最后对话(id,"染色成功！换个颜色换个心情#3")
        发送数据(连接id,30.2, {副武器 = self.数据[武器id]})
        地图处理类:更新武器(id)
    end
end


function 道具处理类:激活天赋符(连接id,id,数据)
    local 包裹类型=数据.类型
    local 道具格子=数据.编号
    local 属性=数据.事件
    if 包裹类型~="道具" then
        常规提示(id,"只有道具栏的物品才可以使用")
        return
    elseif 道具格子==nil then
        return
    end
    local 道具id=玩家数据[id].角色[包裹类型][道具格子]
    if 道具id==nil or self.数据[道具id]==nil then
        发送数据(连接id,3699)
        return
    end
    if self.数据[道具id].属性 then
        常规提示(id,"这个物品已被激活过了。")
        return
    end
    if 属性 and 属性~="我再想想" then
        self.数据[道具id].属性=属性
        常规提示(id,"激活成功。")
        发送数据(连接id,3699)
    end
end

function 道具处理类:镶嵌灵犀玉(数字id,数据) --保存镶嵌结果
    local id = 数字id + 0
    local 镶嵌部件 = 数据.部件
    local 灵犀玉数据=数据.灵犀玉
    local 客户端属性=数据.客户端属性
    local sqsj = 玩家数据[id].神器.数据.神器解锁[镶嵌部件]
    for i=1,20 do
        local 道具id=玩家数据[id].角色.道具[i]
        if 道具id~=nil and 玩家数据[id].道具.数据[道具id]~=nil and self.数据[道具id].名称 == "灵犀玉" then --判断物品是否存在
            for n=1,4 do --循环镶嵌的部位
                if 灵犀玉数据[n]~=nil and self.数据[道具id].识别码==灵犀玉数据[n].识别码 then --判断物品是否相同，并删除该物品
                    sqsj.镶嵌灵犀玉[n].子类 = self.数据[道具id].子类
                    sqsj.镶嵌灵犀玉[n].特性 = self.数据[道具id].特性
                    if self.数据[道具id].数量 and self.数据[道具id].数量 > 1 then
                        self.数据[道具id].数量 = self.数据[道具id].数量 - 1
                    else
                        self.数据[道具id] = nil
                        玩家数据[id].角色.道具[i]=nil
                    end
                    break
                end
            end
        end
    end
    local 灵犀玉 = 玩家数据[id].道具:索要灵犀玉(id)
    道具刷新(id)
    玩家数据[id].神器:计算灵犀玉属性(玩家数据[id].连接id,id,镶嵌部件,灵犀玉)
    -- 发送数据(玩家数据[id].连接id,180,{神器=玩家数据[id].神器.数据,灵犀玉=物品})
end

function 道具处理类:灵犀之屑合成(连接id,id,内容)
    local 数量=内容.数量
    if 数量>self:取灵犀之屑数量(id) then
        常规提示(id,"#Y/灵犀之屑数量不足！")
        return
    end
    --接下来要写扣除灵犀玉
    if 玩家数据[id].道具:消耗背包道具(连接id,id,"灵犀之屑",数量) then--self:扣除灵犀之屑(id,数量) then
        local go = self:取灵犀之屑成功率(数量)
        if go then
            玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
        end
        发送数据(连接id,6219,{是否成功=go,剩余灵犀玉=self:取灵犀之屑数量(id)})
    end
    道具刷新(id)
end

function 道具处理类:取灵犀之屑数量(id)
  local shuliang = 0
  for i=1,20 do
    local 道具id=玩家数据[id].角色.道具[i]
    if 道具id~=nil and 玩家数据[id].道具.数据[道具id]~=nil then
      if self.数据[道具id].名称 == "灵犀之屑" then
        shuliang = shuliang + self.数据[道具id].数量
      end
    end
  end
  return shuliang
end

function 道具处理类:取灵犀之屑成功率(数量)
    数量 = 数量 + 0
    local 成功率 =  数量*10
    local go = false
    if 取随机数(1,100) <= 成功率 then
        go = true
    end
    return go
end

function 道具处理类:取新编号()
    for n = 1,1200 do
        if self.数据[n]==nil then
            return n
        end
    end
    return #self.数据+1
end

function 道具处理类:宝宝坐骑喂养(连接id,id,数据)
    local 道具格子=数据.道具格子
    local 道具id=玩家数据[id].角色["道具"][道具格子]
    if self.数据[道具id] == nil then
        常规提示(id,"#Y/你没有这个道具")
        return
    end
    if self.数据[道具id].总类~=2 then
        常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
        return
    elseif self.数据[道具id].灵饰 then
        常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
        return
    end
    local lv=self.数据[道具id].等级
    local 认证码 = 数据.rzm
    local 类型=数据.类型
    if self.数据[道具id].召唤兽装备 then
        if lv>125 then
            常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
            return
        end
    else
        if lv>80 or lv<60 then
            常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
            return
        end
    end
    if 类型=="宝宝忠诚" then
        local 编号=玩家数据[id].角色:取参战宝宝编号()
        if 编号~=0 and 玩家数据[id].召唤兽.数据[编号] and 玩家数据[id].角色.参战信息~=nil then
            if 玩家数据[id].召唤兽.数据[编号].种类=="神兽" then
                添加最后对话(id,"神兽无需进行此操作。")
                return
            end
            if 玩家数据[id].召唤兽.数据[编号].忠诚>=1000 then
                添加最后对话(id,"忠诚最高只能提升到1000")
                return
            end
            self.数据[道具id]=nil
            玩家数据[id].角色["道具"][道具格子]=nil
            lv=qz(lv/5)
            玩家数据[id].召唤兽.数据[编号].忠诚=玩家数据[id].召唤兽.数据[编号].忠诚+lv
            常规提示(id,"你的召唤兽 "..玩家数据[id].召唤兽.数据[编号].名称.." 的忠诚提升了#G"..lv.."#Y点。")
            if 玩家数据[id].召唤兽.数据[编号].忠诚>1000 then
                玩家数据[id].召唤兽.数据[编号].忠诚=1000
            end
            发送数据(连接id,6568,{zc=玩家数据[id].召唤兽.数据[编号].忠诚,rzm=玩家数据[id].召唤兽.数据[编号].认证码})
            发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
        end
    elseif 类型=="修炼" then
        local 坐骑编号=玩家数据[id].角色:取坐骑编号(认证码)
        if 坐骑编号~=0 then
            if 玩家数据[id].角色.坐骑列表[坐骑编号].好感度>=200 then
                添加最后对话(id,"好感度最高只能提升到200")
                return
            end
            self.数据[道具id]=nil
            玩家数据[id].角色["道具"][道具格子]=nil
            lv=qz(lv/10)
            玩家数据[id].角色.坐骑列表[坐骑编号].好感度 = 玩家数据[id].角色.坐骑列表[坐骑编号].好感度+lv
            常规提示(id,"你的坐骑 "..玩家数据[id].角色.坐骑列表[坐骑编号].名称.." 的好感度提升了#G"..lv.."#Y点。")
            if 玩家数据[id].角色.坐骑列表[坐骑编号].好感度>200 then
                玩家数据[id].角色.坐骑列表[坐骑编号].好感度=200
            end
            发送数据(连接id,6569,{hgd=玩家数据[id].角色.坐骑列表[坐骑编号].好感度,rzm= 玩家数据[id].角色.坐骑列表[坐骑编号].认证码})
            发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
        end
    end
end

function 道具处理类:获取光武拓印(连接id,id,数据)
    local 道具格子=数据.道具格子
    local 道具id=玩家数据[id].角色["道具"][道具格子]
    if self.数据[道具id] == nil then
        常规提示(id,"#Y/数据异常！")
        return
    end
    if (self.数据[道具id].总类~=2 or self.数据[道具id].分类 ~= 3) and (self.数据[道具id].总类~=2 or self.数据[道具id].子类 ~= 911) then
        常规提示(id,"#Y/选择武器有误！")
        return
    end
    if not self.数据[道具id].鉴定 then
        常规提示(id,"#Y/请鉴定后再来！")
        return
    end
    -- if self.数据[道具id].等级 < 120 then
    --  常规提示(id,"#Y/该武器不能使用此功能！")
    --  return
    -- end
    if self.数据[道具id].专用 and self.数据[道具id].专用 ~= id then
        常规提示(id,"#Y/无法对该武器进行操作！")
        return
    end
    发送数据(连接id,308,{道具格子})
end

function 道具处理类:光武拓印转化(连接id,id,数据)
    local 道具格子=数据.道具格子
    local 道具id=玩家数据[id].角色["道具"][道具格子]
    if self.数据[道具id] == nil or 数据.新造型 == nil then
        常规提示(id,"#Y/数据异常！")
        return
    end
    local 新造型 = 数据.新造型
    -- if self.数据[道具id].总类~=2 or self.数据[道具id].分类 ~= 3  then
    if (self.数据[道具id].总类~=2 or self.数据[道具id].分类 ~= 3) and (self.数据[道具id].总类~=2 or self.数据[道具id].子类 ~= 911) then
        常规提示(id,"#Y/选择武器有误！")
        return
    end
    if not self.数据[道具id].鉴定 then
        常规提示(id,"#Y/请鉴定后再来！")
        return
    end
    -- if self.数据[道具id].等级 < 120 then
    --  常规提示(id,"#Y/该武器不能使用此功能！")
    --  return
    -- end
    if self.数据[道具id].专用 and self.数据[道具id].专用 ~= id then
        常规提示(id,"#Y/无法对该武器进行操作！")
        return
    end

    local 临时武器数据 = 取物品数据(新造型)

    if 临时武器数据 == nil then
        常规提示(id,"#Y/数据异常，请重试！")
        return
    end
    if self.数据[道具id].子类 ~= 临时武器数据[4]  then
        常规提示(id,"#Y/数据异常，请重试！")
        return
    end
    local 原造型=self.数据[道具id].名称
    if 玩家数据[id].角色:扣除银子(25000000,0,0,"光武拓印",1) then
        if self.数据[道具id].光武拓印 == nil then
            self.数据[道具id].光武拓印 = {
                原名称 = self.数据[道具id].名称,
                id  = id
            }
        end
        self.数据[道具id].名称 = 新造型
        发送数据(连接id,3513,玩家数据[id].道具:索要道具1(id))
        发送数据(连接id,308,{})
        添加最后对话(id,"一阵金光闪过，你手中的#Y"..原造型.."#W变成了#Y"..新造型.."#W的造型#80。")
    end

end

function 道具处理类:装备点化套装(连接id,id,sjj)
    local 强化石 = {"青龙石","朱雀石","玄武石","白虎石"}
    local 套装类型 = sjj.套装
    local 宝珠id = sjj.宝珠数据
    local 装备编号 = 玩家数据[id].角色.道具[sjj.装备]
    local 装备等级 = tonumber(self.数据[装备编号].等级)
    local 消耗石头 = self.数据[装备编号].分类
    local 强化石数据 = {青龙石=0,朱雀石=0,玄武石=0,白虎石=0}
    if 消耗石头 == 5 or 消耗石头 == 6 then
        消耗石头 = 3
    end
    if 装备等级 == nil then 常规提示(id,"道具数据异常，请重新打开界面进行操作。") return end
    强化石数据[强化石[消耗石头]] = math.floor(装备等级/10)
    for k,v in pairs(强化石数据) do
        if v>0 then
            强化石数据={k,v}
            break
        end
    end
    if sjj.装备 == nil or sjj.套装==0 or sjj.套装==nil then
        常规提示(id,"道具数据异常，请重新打开界面进行操作。")
        return
    end
    if 宝珠id==nil or self.数据[宝珠id] == nil or self.数据[宝珠id].名称~="附魔宝珠" then
        常规提示(id,"道具数据异常，请重新打开界面进行操作。")
        return
    end

    if tonumber(self.数据[宝珠id].等级)  < 装备等级 then
        常规提示(id,"宝珠等级小于装备等级，无法进行点化。")
        return
    end
    if 玩家数据[id].角色.当前经验 < 装备等级*3000 then --改经脉
        常规提示(id,"您的经验不足，无法进行点化。")
        return
    end
    if 玩家数据[id].角色.银子 < 装备等级*5000 then
        常规提示(id,"您的银子不足，无法进行点化。")
        return
    end

    if 玩家数据[id].道具:判定背包道具(id,强化石数据[1],强化石数据[2])==false then
        常规提示(id,"您的"..强化石[消耗石头].."不足，无法进行点化。")
        return
    end

    if self.数据[装备编号].祈福值==nil or self.数据[装备编号].祈福值==0 or self.数据[装备编号].祈福值 < 30 then
        if 玩家数据[id].道具:消耗背包道具(连接id,id,强化石数据[1],强化石数据[2]) then
            玩家数据[id].道具:消耗背包道具(连接id,id,self.数据[宝珠id].名称,1)
            发送数据(连接id,3718)
            if 套装类型 == 1 then
                local 随机动物套 = 取所有动物套[取随机数(1,#取所有动物套)]
                self.数据[装备编号].套装效果={"变身术之",随机动物套}
            elseif 套装类型 == 2 then
                local 套装类型="追加法术"
                local 套装效果={追加法术={"知己知彼","满天花雨","唧唧歪歪","龙卷雨击","尘土刃","荆棘舞","冰川怒","夺命咒","夺魄令","浪涌","裂石","落叶萧萧","龙腾","龙吟","五雷咒","飞砂走石","三昧真火","姐妹同心","阎罗令","判官令","紧箍咒","日光华","靛沧海","巨岩破","苍茫树","地裂火","尸腐毒","勾魂","摄魄","百万神兵","魔音摄魂","镇妖","含情脉脉","似玉生香","后发制人","横扫千军","日月乾坤","威慑","催眠符","失心符","落魄符","定身符","神针撼海","当头一棒","雷击","落岩","水攻","烈火","奔雷咒","泰山压顶","水漫金山","地狱烈火",}}
                self.数据[装备编号].套装效果={套装类型,套装效果[套装类型][取随机数(1,#套装效果[套装类型])]}

            elseif 套装类型 == 4 then
                local 套装类型="附加状态"
                local 套装效果={附加状态={"金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身","极度疯狂","盘丝阵","逆鳞","魔王回首","幽冥鬼眼","楚楚可怜","修罗隐身","杀气诀","一苇渡江"}}
                self.数据[装备编号].套装效果={套装类型,套装效果[套装类型][取随机数(1,#套装效果[套装类型])]}
            end
            if self.数据[装备编号].祈福值 == nil then
                self.数据[装备编号].祈福值 = 0
            end
            self.数据[装备编号].祈福值 = self.数据[装备编号].祈福值 + 2
            --常规提示(id,"点化成功")
            常规提示(id,"点化成功，"..self.数据[装备编号].套装效果[1].."-"..self.数据[装备编号].套装效果[2])
            玩家数据[id].角色.当前经验=qz(玩家数据[id].角色.当前经验-装备等级*3000)
            玩家数据[id].角色:扣除银子(装备等级*5000,0,0,"点化套装",1)
            道具刷新(id)
        end
    else
        local 套装类型名称 = "变身术"
        local 选项 = {}
        if 套装类型 == 1 then
            for n=1,#取所有动物套 do
                table.insert(选项,取所有动物套[n])
            end
        elseif 套装类型 == 2 then
            套装类型名称 = "追加法术"
            local 追加法术={"知己知彼","满天花雨","唧唧歪歪","龙卷雨击","尘土刃","荆棘舞","冰川怒","夺命咒","夺魄令","浪涌","裂石","落叶萧萧","龙腾","龙吟","五雷咒","飞砂走石","三昧真火","姐妹同心","阎罗令","判官令","紧箍咒","日光华","靛沧海","巨岩破","苍茫树","地裂火","尸腐毒","勾魂","摄魄","百万神兵","魔音摄魂","镇妖","含情脉脉","似玉生香","后发制人","横扫千军","日月乾坤","威慑","催眠符","失心符","落魄符","定身符","神针撼海","当头一棒","雷击","落岩","水攻","烈火","奔雷咒","泰山压顶","水漫金山","地狱烈火",}
            for n=1,#追加法术 do
                table.insert(选项,追加法术[n])
            end
        elseif 套装类型 == 4 then
            套装类型名称 = "附加状态"
            local 附加状态={"金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身","极度疯狂","盘丝阵","逆鳞","魔王回首","幽冥鬼眼","楚楚可怜","修罗隐身","杀气诀","一苇渡江"}
            for n=1,#附加状态 do
                table.insert(选项,附加状态[n])
            end
        end
        table.insert(选项,"我暂时先不点化了")
        local 对话="装备祈福值已满，您可以选择一个自己想要的套装效果进行祈福：(正在点化：#Z"..套装类型名称.."#W)"
        玩家数据[id].点化套装数据 = sjj
        发送数据(连接id,1501,{名称="点化装备套装",模型=玩家数据[id].角色.模型,对话=对话,选项=选项})
    end
end

function 道具处理类:判断强化石(数据)
  local 青龙石数量 = 0
  local 白虎石数量 = 0
  local 朱雀石数量 = 0
  local 玄武石数量 = 0
  local 判断 = nil
  if 数据.青龙石 ~= 0 then
    for n, v in pairs(self.数据) do
      if self.数据[n].名称 == "青龙石" then
        青龙石数量 = 青龙石数量 + self.数据[n].数量
      end
    end
    if 青龙石数量 < 数据.青龙石 then
      判断 = false
    else
      判断 = true
    end
  end

  if 数据.白虎石 ~= 0 then
    for n, v in pairs(self.数据) do
      if self.数据[n].名称 == "白虎石" then
        白虎石数量 = 白虎石数量 + self.数据[n].数量
      end
    end
    if 白虎石数量 < 数据.白虎石 then
      判断 = false
    else
      判断 = true
    end
  end

  if 数据.朱雀石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "朱雀石" then
        朱雀石数量 = 朱雀石数量 + self.数据[n].数量
      end
    end
    if 朱雀石数量 < 数据.朱雀石 then
      判断 = false
    else
      判断 = true
    end
  end

  if 数据.玄武石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "玄武石" then
        玄武石数量 = 玄武石数量 + self.数据[n].数量
      end
    end
    if 玄武石数量 < 数据.玄武石 then
      判断 = false
    else
      判断 = true
    end
  end

  return 判断
end
function 道具处理类:判断道具数量(id,名称)
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]].可叠加 and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]].数量 and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]].名称==名称 then
            return 玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]].数量
        end
    end
    return 0
end
function 道具处理类:吸附兽诀(连接id,id,内容)
    local gz=内容.兽诀格子
    local 删除数量=1
    local 道具id=玩家数据[id].角色["道具"][gz]
    if self.数据[道具id] == nil then
        常规提示(id,"#Y/该物品不存在")
        return
    elseif self.数据[道具id].名称~="魔兽要诀" and self.数据[道具id].名称~="高级魔兽要诀"  and self.数据[道具id].名称~="特殊魔兽要诀" then
        常规提示(id,"#Y/该物品不存在")
        return
    end
    if self.数据[道具id].附带技能 then
        local 吸附名称=self.数据[道具id].附带技能
       if 吸附名称=="须弥真言" or 吸附名称=="观照万象" or 吸附名称=="津津有味" or 吸附名称=="净台妙谛" or 吸附名称=="叱咤风云"
             or 吸附名称=="风起龙游" or 吸附名称=="神来气旺" or 吸附名称=="出其不意" or 吸附名称=="灵能激发" or 吸附名称=="无上正真"
             or 吸附名称=="浮云神马" or 吸附名称=="千钧一怒" or 吸附名称=="势如破竹" or 吸附名称=="乘胜追击" or 吸附名称=="凭风借力"
             or 吸附名称=="顾盼生姿" or 吸附名称=="拘魂索命" or 吸附名称=="溜之大吉" or 吸附名称=="神出鬼没" or 吸附名称=="昼伏夜出"
             or 吸附名称=="凝光炼彩" or 吸附名称=="灵山禅语" or 吸附名称=="无畏布施" or 吸附名称=="怒号" or 吸附名称=="腾云跨风"
             or 吸附名称=="天魔咒术" or 吸附名称=="仙力激发" or 吸附名称=="魔劲激发" or 吸附名称=="大天师" or 吸附名称 == "欣欣向荣"
             or 吸附名称=="茁壮" or 吸附名称=="克敌五行" or 吸附名称=="力大无穷（金）" or 吸附名称=="力大无穷（木）" or 吸附名称 == "力大无穷（水）"
             or 吸附名称=="力大无穷（火）" or 吸附名称=="力大无穷（土）" or 吸附名称=="万物之灵（金）" or 吸附名称=="万物之灵（木）" or 吸附名称 == "万物之灵（水）"
             or 吸附名称=="万物之灵（火）" or 吸附名称=="万物之灵（土）" or 吸附名称=="风之沙盾" or 吸附名称=="超级神柚复生" or 吸附名称 == "雨露之泽"
             or 吸附名称=="花好月圆" or 吸附名称=="洞察" or 吸附名称=="清风之华" or 吸附名称=="映雪棱镜" or 吸附名称=="无赦魔诀" or 吸附名称=="天狐之舞"
             then
            常规提示(id,"#Y/我不认识这个技能哦")
            return
        end
        if 玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"吸附石",1) then
            玩家数据[id].道具:给予道具(id,"点化石",1,吸附名称,"不存共享")
            self:删除道具(连接id,id,"道具",道具id,gz,删除数量)
            常规提示(id,"#Y/吸附成功！获得了#G/"..吸附名称.."#Y/点化石")
            发送数据(连接id,3699)
        end
    end
end

function 道具处理类:开运(连接id,id,gz)
    local lsgz = gz
    gz=玩家数据[id].角色["道具"][gz]
    if self.数据[gz] and self.数据[gz].开运孔数 and self.数据[gz].开运孔数.当前 < self.数据[gz].开运孔数.上限 then
        if 玩家数据[id].角色.银子 < (self.数据[gz].开运孔数.当前+1) * 200000 then self:更新道具1(连接id,id,gz,lsgz) return  end
        if 玩家数据[id].角色:扣除银子((self.数据[gz].开运孔数.当前+1) * 200000,0,0) then
            if 取随机数() < 60 - (self.数据[gz].开运孔数.当前 * 10) then
                self.数据[gz].开运孔数.当前 = self.数据[gz].开运孔数.当前 + 1
                self:更新道具1(连接id,id,gz,lsgz)
                常规提示(id,"#Y开运#G成功#Y扣除了#R"..((self.数据[gz].开运孔数.当前+1) * 200000).."#Y银两")
            else
                self:更新道具1(连接id,id,gz,lsgz,"装备开运")
                常规提示(id,"#Y开运#R失败#Y失去了#R"..((self.数据[gz].开运孔数.当前+1) * 200000).."#Y银两")
            end
        end
    else
        self:更新道具1(连接id,id,gz,lsgz,"装备开运")
        常规提示(id,"#Y开运孔数到达上限!")
    end
end

function 道具处理类:更新道具(连接id,id,gz,lx)
    道具刷新(id)
end
function 道具处理类:更新道具1(连接id,id,gz,lx)
    发送数据(连接id,201,{self.数据[gz],lx})
    道具刷新(id)
end
function 道具处理类:更新道具2(连接id,id,gz)
    发送数据(连接id,202,self.数据[gz])
end

function 道具处理类:一键出售环装(连接id,数字id)
    local ts=""
    for n=1,80 do
        if 玩家数据[数字id].角色.道具[n] and self.数据[玩家数据[数字id].角色.道具[n]] then
            local 道具id=玩家数据[数字id].角色.道具[n]
            if self.数据[道具id] and self.数据[道具id].总类==2 and self.数据[道具id].等级 and self.数据[道具id].等级>=50 and self.数据[道具id].等级<=80 then
                local 名称=self.数据[道具id].名称
                local sbm=self.数据[道具id].识别码
                if not self.数据[道具id].专用 and not self.数据[道具id].灵饰 and not self.数据[道具id].召唤兽装备 then
                    local 价格=self:取装备价格(道具id)
                    self.数据[道具id]=nil
                    玩家数据[数字id].角色.道具[n]=nil
                    玩家数据[数字id].角色:添加银子(价格,"出售环装"..名称..sbm,1)
                    ts=ts.."#G"..名称.."="..价格.."#Y，"
                end
            end
        end
    end
    if ts~="" then
        常规提示(数字id,"出售#G"..ts.."成功！")
        道具刷新(数字id)
    end
end
function 道具处理类:一键回收仓库(连接id, 数字id)
    local ts = ""
    -- 获取玩家账号仓库实例
    local 玩家账号 = 玩家数据[数字id].角色.账号
    local 仓库实例 = 账号仓库数据[玩家账号]
    if not 仓库实例 then
        常规提示(数字id, "#Y未找到账号仓库数据！")
        return
    end

    -- 遍历账号仓库所有种类（与仓库类定义的类型对应）
    local 仓库类型列表 = {"宝石", "内丹", "书铁", "兽决", "装备", "炼妖", "其他", "卡片"}
    for _, 仓库类型 in ipairs(仓库类型列表) do
        -- 检查该类型仓库是否存在
        if 仓库实例.数据[仓库类型] then
            local 仓库 = 仓库实例.数据[仓库类型]
            -- 遍历仓库第1页（按原逻辑仓库主要用第1页，如需多页可扩展循环）
            local 页数 = 1
            if 仓库[页数] then
                -- 按仓库总格数遍历每个格子
                for 格子 = 1, 仓库.总数 do
                    local 道具 = 仓库[页数][格子]
                    if 道具 then  -- 存在道具时处理
                        local wp = 道具.名称
                        local sbm = 道具.识别码 or 0

                        -- 1. 处理50级以上非专用装备（总类=2为装备，含140/150级装备与召唤兽装备）
                        if 道具.总类 == 2 and 道具.等级 and 道具.等级 >= 50 then
                            if not 道具.专用 and not 道具.灵饰 then
                                local 总价 = self:取回收环价格By道具(道具)  -- 适配仓库道具的环价计算
                                -- 移除仓库道具
                                仓库[页数][格子] = nil
                                -- 增加银子
                                玩家数据[数字id].角色:添加银子(总价, "仓库回收环装"..wp..sbm, 1)
                                ts = ts .. "#G"..wp.."="..总价.."#Y，"
                            end
                        -- 2. 处理150级书铁
                        elseif (wp == "制造指南书" or wp == "百炼精铁") and 道具.子类 and 道具.子类 == 150 then
                            local 价格 = (wp == "制造指南书") and 1500000 or 1000000
                            if 价格 ~= 0 then
                                仓库[页数][格子] = nil  -- 移除仓库道具
                                玩家数据[数字id].角色:添加银子(价格, "仓库回收书铁"..wp..sbm, 1)
                                ts = ts .. "#G"..wp.."="..价格.."#Y，"
                            end
                        -- 3. 处理配置文件中定义回收价的物品
                        else
                            local 单价 = f函数.读配置([[回收设置/服务端回收.txt]], "出售单价", wp)
                            if 单价 ~= "空" then
                                local 数量 = 道具.数量 or 1
                                local 总价 = 单价 * 数量
                                仓库[页数][格子] = nil  -- 移除仓库道具
                                玩家数据[数字id].角色:添加银子(总价, "仓库物品回收"..wp..sbm, 1)
                                ts = ts .. "#G"..wp.."*"..数量.."="..总价.."#Y，"
                            end
                        end
                    end
                end
                -- 回收后整理仓库格子（复用仓库类的整理方法）
                -- 仓库实例:内部仓库整理(页数)
            end
        end
    end

    -- 保存仓库数据
    仓库实例:账号仓库存档()
    -- 刷新道具和仓库显示
    道具刷新(数字id)
    发送数据(连接id, 3513, 玩家数据[数字id].道具:索要道具2(数字id))
    -- 通知所有仓库类型的刷新
    for _, 仓库类型 in ipairs(仓库类型列表) do
        if 仓库实例.数据[仓库类型] then
            发送数据(连接id, 413, {
                类型 = 仓库类型,
                道具 = 仓库实例:索要仓库道具(数字id, 1, 仓库类型),
                页数 = 1,
                道具仓库总数 = 仓库实例.数据[仓库类型].总数 / 56
            })
        end
    end

    -- 提示结果（保持原提示风格）
    if ts ~= "" then
        常规提示(数字id, "仓库回收#G"..ts.."成功！")
    else
        常规提示(数字id, "账号仓库中没有可回收的物品！请勿频繁操作。")
    end
end

-- 适配仓库道具的环价计算（与原取回收环价格逻辑一致，参数改为道具对象）
function 道具处理类:取回收环价格By道具(道具)
    return self:取回收环价格核心(道具)
end

function 道具处理类:一键回收(连接id,数字id)
    local ts=""
    for n=1,80 do
        if 玩家数据[数字id].角色.道具[n] and self.数据[玩家数据[数字id].角色.道具[n]] then
            local 道具id=玩家数据[数字id].角色.道具[n]
            if self.数据[道具id] then
                local wp  = self.数据[道具id].名称
                local sbm = self.数据[道具id].识别码 or 0
                if  self.数据[道具id].总类==2 and self.数据[道具id].等级 and self.数据[道具id].等级>=50 then
                    if not self.数据[道具id].专用 and not self.数据[道具id].灵饰 then
                        local 总价=self:取回收环价格(道具id)
                        self.数据[道具id]=nil
                        玩家数据[数字id].角色.道具[n]=nil
                        玩家数据[数字id].角色:添加银子(总价,"出售环装"..wp..sbm,1)
                        ts=ts.."#G"..wp.."="..总价.."#Y，"
                    end
                elseif (wp=="制造指南书" or wp=="百炼精铁") and self.数据[道具id].子类 and self.数据[道具id].子类==150 then
                        local 价格=0
                        if wp=="制造指南书" then
                            价格=1500000
                        else
                            价格=1000000
                        end
                        if 价格~=0 then
                        self.数据[道具id]=nil
                        玩家数据[数字id].角色.道具[n]=nil
                        玩家数据[数字id].角色:添加银子(价格,"出售书铁"..wp..sbm,1)
                        ts=ts.."#G"..wp.."="..价格.."#Y，"
                        end
                else
                    local 单价= f函数.读配置([[回收设置/服务端回收.txt]], "出售单价",wp)
                    if 单价~="空"then
                        local 数量=self.数据[道具id].数量 or 1
                        local 总价=单价*数量
                        self.数据[道具id]=nil
                        玩家数据[数字id].角色.道具[n]=nil
                        ts=ts.."#G"..wp.."*"..数量.."="..总价.."#Y，"
                        玩家数据[数字id].角色:添加银子(总价,"物品回收"..wp..sbm,1)
                    end
                end
            end
        end
    end

    if ts~="" then
        常规提示(数字id,"出售#G"..ts.."成功！")
        道具刷新(数字id)
    else
        常规提示(数字id,"你没有可以出售的物品！请勿频繁操作。")
    end
end


function 道具处理类:一键合宝石(id,dj1,lv,名称1)
    local 限制等级 = 15
    if 名称1=="星辉石" and lv >= 限制等级 then
        常规提示(id,"星辉石最高只能合到"..限制等级.."级！")
        return
    elseif 名称1 == "精魄灵石" and lv >= 10 then
        常规提示(id,"精魄灵石最高只能合到10级！")
        return
    -- ★新增：五色灵尘等级上限检查
    elseif 名称1 == "五色灵尘" and lv >= 限制等级 then
        常规提示(id,"五色灵尘最高只能合到"..限制等级.."级！")
        return
    end
    if lv>0 and dj1 then
        local 星辉石候选列表 = {}
        local 五色灵尘候选列表 = {}  -- ★新增
        for n=1,80 do
            local dj2 = 玩家数据[id].角色.道具[n]
            if 名称1 == "星辉石" then
                if dj2 and self.数据[dj2] and dj1~=dj2 and 名称1==self.数据[dj2].名称 then
                    local 名称2=self.数据[dj2].名称
                    if 右键合成宝石[名称2] and self.数据[dj2].等级==lv then
                        table.insert(星辉石候选列表, dj2)
                    end
                end
            -- ★新增：五色灵尘候选收集
            elseif 名称1 == "五色灵尘" then
                if dj2 and self.数据[dj2] and dj1~=dj2 and self.数据[dj2].总类=="五色灵尘" then
                    if 右键合成宝石["五色灵尘"] and self.数据[dj2].等级==lv then
                        table.insert(五色灵尘候选列表, dj2)
                    end
                end
            elseif 名称1 == "精魄灵石" then
                if dj2 and self.数据[dj2] and dj1~=dj2 and 名称1==self.数据[dj2].名称 then
                    local 名称2=self.数据[dj2].名称
                    if 右键合成宝石[名称2] and self.数据[dj2].等级==lv and self.数据[dj2].总类 == 105 and self.数据[dj2].子类 == self.数据[dj1].子类 then
                        if 装备处理类:取宝石合成几率(id,lv) then
                            玩家数据[id].角色.道具[n] = nil
                            self.数据[dj2] = nil
                            self.数据[dj1].等级 = self.数据[dj1].等级 +1
                            道具刷新(id)
                            常规提示(id,"#Y/你合成了一个更高级的宝石")
                            return
                        else
                            玩家数据[id].角色.道具[n] = nil
                            self.数据[dj2] = nil
                            道具刷新(id)
                            常规提示(id,"#Y/你合成失败你损失了一颗宝石")
                            return
                        end
                    end
                end
            else
                if dj2 and self.数据[dj2] and dj1~=dj2 and 名称1==self.数据[dj2].名称 then
                    local 名称2=self.数据[dj2].名称
                    if 右键合成宝石[名称2] and self.数据[dj2].等级==lv then
                        if 装备处理类:取宝石合成几率(id,lv) then
                            玩家数据[id].角色.道具[n] = nil
                            self.数据[dj2] = nil
                            self.数据[dj1].等级 = self.数据[dj1].等级 +1
                            道具刷新(id)
                            常规提示(id,"#Y/你合成了一个更高级的宝石")
                            return
                        else
                            玩家数据[id].角色.道具[n] = nil
                            self.数据[dj2] = nil
                            道具刷新(id)
                            常规提示(id,"#Y/你合成失败你损失了一颗宝石")
                            return
                        end
                    end
                end
            end
        end
        -- 星辉石单独处理（3个合成）
        if 名称1 == "星辉石" and #星辉石候选列表 >= 2 then
            local dj2 = 星辉石候选列表[1]
            local dj3 = 星辉石候选列表[2]
            if 装备处理类:取宝石合成几率(id,lv) then
                for _, dj in ipairs({dj2, dj3}) do
                    for n=1,80 do
                        if 玩家数据[id].角色.道具[n] == dj then
                            玩家数据[id].角色.道具[n] = nil
                            break
                        end
                    end
                    self.数据[dj] = nil
                end
                self.数据[dj1].等级 = self.数据[dj1].等级 +1
                道具刷新(id)
                常规提示(id,"#Y/你合成了一个更高级的宝石")
                return
            else
                for n=1,80 do
                    if 玩家数据[id].角色.道具[n] == dj2 then
                        玩家数据[id].角色.道具[n] = nil
                        break
                    end
                end
                self.数据[dj2] = nil
                道具刷新(id)
                常规提示(id,"#Y/你合成失败你损失了一颗宝石")
                return
            end
        end
        -- ★新增：五色灵尘单独处理（3个合成）
        if 名称1 == "五色灵尘" and #五色灵尘候选列表 >= 2 then
            local dj2 = 五色灵尘候选列表[1]
            local dj3 = 五色灵尘候选列表[2]
            if 装备处理类:取宝石合成几率(id,lv) then
                for _, dj in ipairs({dj2, dj3}) do
                    for n=1,80 do
                        if 玩家数据[id].角色.道具[n] == dj then
                            玩家数据[id].角色.道具[n] = nil
                            break
                        end
                    end
                    self.数据[dj] = nil
                end
                self.数据[dj1].等级 = self.数据[dj1].等级 +1
                道具刷新(id)
                常规提示(id,"#Y/你合成了一个更高级的五色灵尘")
                return
            else
                for n=1,80 do
                    if 玩家数据[id].角色.道具[n] == dj2 then
                        玩家数据[id].角色.道具[n] = nil
                        break
                    end
                end
                self.数据[dj2] = nil
                道具刷新(id)
                常规提示(id,"#Y/你合成失败你损失了一颗五色灵尘")
                return
            end
        end
    end
    常规提示(id,"#Y/没有找到可以合成的宝石")
end
function 道具处理类:一键合五宝(id)
    local sadwe={金刚石=0,定魂珠=0,夜光珠=0,避水珠=0,龙鳞=0}
    local shanchu={}
    local 满足=0
    for n=1,80 do
        local dj = 玩家数据[id].角色.道具[n]
        if dj and self.数据[dj] then
            local 名称=self.数据[dj].名称
            if 右键合成五宝[名称] and sadwe[名称]==0 then
                sadwe[名称]=123
                shanchu[名称]={道具id=dj,角色寄存=n}
                满足=满足+1
                if 满足>=5 then
                    break
                end
            end
        end
    end
    if 满足>=5 then
        for k,v in pairs(shanchu) do
            if v.道具id~=0 and self.数据[v.道具id] and 右键合成五宝[self.数据[v.道具id].名称] then
                -- 支持可叠加：只扣除1个，不是直接删除整组
                if self.数据[v.道具id].数量~=nil and self.数据[v.道具id].数量>1 then
                    self.数据[v.道具id].数量=self.数据[v.道具id].数量-1
                else
                    玩家数据[id].角色.道具[v.角色寄存] = nil
                    self.数据[v.道具id] = nil
                end
            end
        end
        玩家数据[id].道具:给予道具(id,"特赦令牌")
    else
        常规提示(id,"不满足合成五宝条件")
    end
end------助战操作开始
function 道具处理类:助战使用道具(连接id,id,主人id,内容)
    local 道具格子=内容.编号
    local 删除数量=1
    local 加血对象=0
    local 道具提示 = true
    local 重要事件=false
    local 道具id=玩家数据[id].角色["道具"][道具格子]
    local 助战编号=内容.助战编号
    if 道具id==nil or self.数据[道具id]==nil then
        玩家数据[id].道具[道具格子]=nil
        玩家数据[id].道具:助战索要道具(连接id,id,助战编号)
        return
    end
    local 名称=self.数据[道具id].名称
    local 道具使用=false
    if 玩家数据[id].坐牢中 or 玩家数据[id].烤火 then
        常规提示(id,"当前不能使用道具")
        return
    end
    if self:取加血道具(名称) then
        道具使用=true
        local 加血数值=self:取加血道具1(名称,道具id)
        local 加魔数值=self:取加魔道具1(名称,道具id)
        local 伤势数值=self:取加血道具2(名称,道具id)
        if 名称=="翡翠豆腐" then
            self:加血处理(连接id,id,加血数值,加血对象)
            self:加魔处理(连接id,id,加魔数值,加血对象)
        else
            self:加血处理(连接id,id,加血数值,加血对象,nil,伤势数值)
        end
    elseif self:取加魔道具(名称) then
        道具使用=true
        local 加血数值=self:取加血道具1(名称,道具id)
        local 加魔数值=self:取加魔道具1(名称,道具id)
        if 名称=="翡翠豆腐" then
            self:加血处理(连接id,id,加血数值,加血对象)
            self:加魔处理(连接id,id,加魔数值,加血对象)
        else
            self:加魔处理(连接id,id,加魔数值,加血对象)
        end
    elseif self:取寿命道具(名称) then
        if 加血对象==0 then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].种类 =="神兽" then
            常规提示(id,"神兽无法使用此物品")
            return
        else
            local 加血数值=self:取寿命道具1(名称,道具id)
            玩家数据[id].召唤兽:加寿命处理(加血对象,加血数值.数值,加血数值.中毒,连接id,id)
            道具使用=true
        end
    elseif 右键合成宝石[名称] then
        self:一键合宝石(id,道具id,self.数据[道具id].等级,self.数据[道具id].名称)
        return
    elseif 右键合成五宝[名称] then
        self:一键合五宝(id)
        return
    elseif 名称=="五宝盒" then
        玩家数据[id].道具:给予道具(id,取五宝(),1,nil,"不存共享")
        道具使用=true
    elseif 名称=="坐骑礼包" or 名称=="种族坐骑" then
        玩家数据[id].角色:增加种族坐骑(id)
        道具使用=true
    elseif 名称=="灵犀玉礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<10 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        for i=1,10 do
            玩家数据[id].道具:给予道具(id,"灵犀玉",nil,true,"不存共享")
        end
        道具使用=true
    elseif 名称=="九转金丹礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<10 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"九转金丹",10,300,"不存共享")
        道具使用=true
    elseif 名称=="修炼礼包" then
        self:给予道具(id,"修炼果",99,nil,"不存共享")
        self:给予道具(id, "九转金丹礼包", 10,nil,"不存共享")
        道具使用=true
    ----------------================商城lib==================--------------
    elseif 名称=="90无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,90,"无级别限制",id,商城产出)
        道具使用=true
  elseif 名称=="100无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,100,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="110无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,110,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="120无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,120,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="130无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,130,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="140无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,140,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="150无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,150,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="160无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,160,"无级别限制",id,商城产出)
        道具使用=true

    elseif 名称=="60灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"枫华戒",60,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翠叶环",60,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"香木镯",60,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芝兰佩",60,"佩饰"))
        道具使用=true
    elseif 名称=="80灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芙蓉戒",80,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"明月珰",80,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翡玉镯",80,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"逸云佩",80,"佩饰"))
        道具使用=true
    elseif 名称=="100灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"金麟绕",100,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"玉蝶翩",100,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"墨影扣",100,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"莲音玦",100,"佩饰"))
        道具使用=true
    elseif 名称=="120灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"悦碧水",120,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"点星芒",120,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"花映月",120,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"相思染",120,"佩饰"))
        道具使用=true
    elseif 名称=="140灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"九曜光华",140,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"凤羽流苏",140,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"金水菩提",140,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"玄龙苍珀",140,"佩饰"))
        道具使用=true
    elseif 名称=="160随机灵饰箱" then
        if 取随机数()<25 then
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"太虚渺云",160,"戒指"))
        elseif 取随机数()<50 then
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"焰云霞珠",160,"耳饰"))
        elseif 取随机数()<75 then
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"浮雪幻音",160,"手镯"))
        else
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"碧海青天",160,"佩饰"))
        end
        道具使用=true

    elseif 名称=="鬼谷子" then
        if 玩家数据[id].角色.阵法[self.数据[道具id].子类]==nil then
            玩家数据[id].角色.阵法[self.数据[道具id].子类]=1
            常规提示(id,"恭喜你学会了如何使用#R/"..self.数据[道具id].子类)
            道具使用=true
        else
            常规提示(id,"你已经学过如何使用这个阵型了，请勿重复学习")
            return
        end
    elseif 名称=="怪物卡片" then
        local 剧情等级=玩家数据[id].角色:取剧情技能等级("变化之术")
        if 剧情等级<6 and self.数据[道具id].等级>剧情等级 then
            常规提示(id,"#Y/你的变化之术等级太低了")
            return
        end
        if 玩家数据[id].角色:取任务(1)~=0 then
            任务数据[玩家数据[id].角色:取任务(1)]=nil
            玩家数据[id].角色:取消任务(1)
        end
        玩家数据[id].角色.变身数据=self.数据[道具id].造型
        道具使用=true
        玩家数据[id].角色:刷新信息()
        发送数据(连接id,37,玩家数据[id].角色.变身数据)
        常规提示(id,"你使用了怪物卡片")
        发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
        发送数据(玩家数据[id].连接id,12)
        设置任务1(id,剧情等级,玩家数据[id].角色.变身数据)
        地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
    elseif 名称=="小象炫卡" or 名称=="腾蛇炫卡" or 名称=="龙马炫卡" or 名称=="雪人炫卡" then
        if 玩家数据[id].角色:取任务(1)~=0 then
            任务数据[玩家数据[id].角色:取任务(1)]=nil
            玩家数据[id].角色:取消任务(1)
        end
        玩家数据[id].角色.变身数据=self.数据[道具id].造型
        道具使用=true
        玩家数据[id].角色:刷新信息()
        发送数据(连接id,37,玩家数据[id].角色.变身数据)
        常规提示(id,"你使用了怪物卡片")
        发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
        发送数据(玩家数据[id].连接id,12)
        -- 设置任务1(id,剧情等级,玩家数据[id].角色.变身数据)
        设置任务1a(id,剧情等级,玩家数据[id].角色.变身数据)
        地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
    elseif 名称=="摄妖香" then  --
        if 玩家数据[id].角色:取任务(9)~=0 then
            玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
        end
        设置任务9(id)
        常规提示(id,"#Y/你使用了摄妖香")
        道具使用=true
    elseif 名称=="未鉴定的灵犀玉" then
        玩家数据[id].道具:给予道具(id,"灵犀玉",1,nil,"不存共享")
        道具使用=true

    elseif 名称=="秘制红罗羹" then
        if 玩家数据[id].角色:取任务(10)~=0 then
            --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
            local 任务id=玩家数据[id].角色:取任务(10)
            if 任务数据[任务id].气血 == nil then
                任务数据[任务id].气血 = 0
            end
            任务数据[任务id].气血=任务数据[任务id].气血+90000000
            常规提示(id,"#Y/你使用了秘制红罗羹")
            道具使用=true
            玩家数据[id].角色:刷新任务跟踪()
        else
            设置任务10(id,200000,0,0)
            常规提示(id,"#Y/你使用了秘制红罗羹")
            道具使用=true
        end
    elseif 名称=="秘制绿芦羹" then  --
        if 玩家数据[id].角色:取任务(10)~=0 then
            --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
            local 任务id=玩家数据[id].角色:取任务(10)
            if 任务数据[任务id].魔法 == nil then
                任务数据[任务id].魔法 = 0
            end
            任务数据[任务id].魔法=任务数据[任务id].魔法+90000000
            常规提示(id,"#Y/你使用了秘制绿罗羹")
            道具使用=true
            玩家数据[id].角色:刷新任务跟踪()
        else
            设置任务10(id,0,65000,0)
            常规提示(id,"#Y/你使用了秘制绿罗羹")
            道具使用=true
        end
    elseif 名称=="百岁香" then
        if 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大活力 then 常规提示(id,"使用后活力超过了最大数值无法使用") return end
        if 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大体力 then 常规提示(id,"使用后体力超过了最大数值无法使用") return end
        玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150)
        玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150)
        道具使用=true
    elseif 名称=="九转金丹" then
        if  玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][1] >= 玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
        玩家数据[id].角色:添加人物修炼经验(id,math.floor((self.数据[道具id].阶品 or 1)*0.5))
        道具使用=true
    elseif 名称=="修炼果" then
        if  玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][1]>= 玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
        玩家数据[id].角色:添加bb修炼经验(id,150)
        道具使用=true

    elseif 名称=="回梦丹" then
        if 玩家数据[id].角色:取任务(15)~=0 then
            常规提示(id,"#Y/当前已经使用回梦丹了，无法再使用该物品")
            return
        end
        设置队伍回梦丹(id)
        道具使用=true

    elseif 名称=="海马" then
        玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+150
        玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+150
        if 玩家数据[id].角色.活力 > 玩家数据[id].角色.最大活力 then
            玩家数据[id].角色.活力=玩家数据[id].角色.最大活力
        end
        if 玩家数据[id].角色.体力 > 玩家数据[id].角色.最大体力 then
            玩家数据[id].角色.体力=玩家数据[id].角色.最大体力
        end
        体活刷新(id)
        道具使用=true
    elseif self.数据[道具id].总类 == 144 then --冒泡框
        玩家数据[id].角色.发言特效 = self.数据[道具id].分类
        道具使用=true
        常规提示(id,"使用成功！")
    elseif 名称=="炫彩ID" then
        玩家数据[id].角色.id特效 = self.数据[道具id].特效
        道具使用=true
        常规提示(id,"使用成功！")
    elseif 名称 == "队标特效" then
        local tx = {"桃心","风车","彩虹","扇子","小猪","音符","火苗","草莓","兔子","蝴蝶","海星","葫芦","螃蟹","狮王","绿叶","红伞","猫头"}
        玩家数据[id].角色.队标特效 = tx[取随机数(1,#tx)]
        常规提示(id,"你获得#G"..玩家数据[id].角色.队标特效.."#Y队标……")
        地图处理类:更改队伍样式(id,玩家数据[id].角色.队标特效)
        道具使用=true
    elseif self.数据[道具id].名称 == "九霄清心丸" then
        设置任务241(id)
        道具使用=true
    elseif self.数据[道具id].名称 == "天机培元丹" then
        if not 初始活动.昆仑仙境[id] then
            初始活动.昆仑仙境[id]={次数=0,最大次数=60,时间=os.time() + 180}
        end
        初始活动.昆仑仙境[id].最大次数=初始活动.昆仑仙境[id].最大次数+20
        常规提示(id,"你的昆仑仙境今日修行次数增加了20次，当前剩余"..初始活动.昆仑仙境[id].最大次数.."次")
        道具使用=true
    end
    if 道具使用 then
        self:删除道具(连接id,id,"道具",道具id,道具格子,删除数量)
        if 重要事件 then
            重要事件()
        end
        玩家数据[id].道具:助战索要道具(连接id,id,助战编号)
        常规提示(id,"#G使用成功")
    else
        if 道具提示 then
            常规提示(主人id,"无法使用这样的道具")
        end
    end
end
function 道具处理类:助战卸下装备(连接id,id,主人id,数据)
    -- local 道具格子=玩家数据[id].角色:取道具格子(数据.类型)
    数据.类型="道具"
    local 道具格子=玩家数据[id].角色:取道具格子(数据.类型)
    if 道具格子==0 then
        常规提示(主人id,"该助战道具栏物品已经满啦")
        return 0
    end
    if 数据.灵饰 then
        self:卸下助战灵饰(连接id,id,道具id,道具格子,数据)
        return
    end
    if 数据.锦衣 then
        self:卸下助战锦衣(连接id,id,道具id,道具格子,数据)
        return
    end
    -- table.print(数据)
    local 道具id=玩家数据[id].角色.装备[数据.道具]
    玩家数据[id].角色:卸下装备(self.数据[道具id],self.数据[道具id].分类)
    玩家数据[id].角色.装备[数据.道具]=nil
    玩家数据[id].角色[数据.类型][道具格子]=道具id
    玩家数据[id].角色:刷新信息()
    self:助战索要道具(连接id,id,数据.助战编号)
    发送数据(连接id, 2007, 玩家数据[id].角色:取总数据1())

    -- 发送数据(连接id,2009,玩家数据[id].角色:取装备数据())
    if 数据.道具==3 then
        地图处理类:更新武器(id)
    end
end
function 道具处理类:佩戴助战灵饰(连接id,id,主人id,道具id,数据)
    if 玩家数据[id].角色.等级<60 then
        常规提示(主人id,"#Y小于60级无法佩戴灵饰")
        return
    end
    local 物品=取物品数据(self.数据[道具id].名称)
    local 级别=物品[5]

    -- if 级别>玩家数据[id].角色.等级 then
    --  if self.数据[道具id].特效 =="无级别限制" then
    --  elseif  self.数据[道具id].特效 =="无级别限制" and 级别<=玩家数据[id].角色.等级+999 then
    --  else
    --      常规提示(主人id,"#Y助战当前的等级不足以佩戴这样的灵饰")
    --      return
    --  end
    -- end



    if 级别>玩家数据[id].角色.等级 then
        -- if self.数据[道具id].特效 =="超级简易" and 级别<=玩家数据[id].角色.等级+15 then
        if (self.数据[道具id].特效 =="超级简易" and 级别<=玩家数据[id].角色.等级+15) or (self.数据[道具id].特效 =="无级别限制" and 级别<=玩家数据[id].角色.等级+999) then

        else
            常规提示(id,"#Y你当前的等级不足以佩戴这样的灵饰")
            return
        end
    end

    if not self.数据[道具id].鉴定 then
        常规提示(主人id,"#Y没有鉴定的灵饰无法佩戴")
        return
    end
    if self.数据[道具id].专用 and  self.数据[道具id].专用~=id then
        常规提示(主人id,"#Y这个灵饰id与助战不匹配无法穿戴")
        return
    end
    if 玩家数据[id].角色.灵饰[self.数据[道具id].子类]==nil then
        玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
        玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
        玩家数据[id].角色[数据.类型][数据.道具]=nil
    else
        local 道具id1=玩家数据[id].角色.灵饰[self.数据[道具id].子类]
        玩家数据[id].角色:卸下灵饰(self.数据[道具id1])
        玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
        玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
        玩家数据[id].角色[数据.类型][数据.道具]=道具id1
    end
    self:助战索要道具(连接id,id,数据.助战编号)
end
function 道具处理类:卸下助战灵饰(连接id,id,道具id,道具格子,数据)
    玩家数据[id].角色:卸下灵饰(self.数据[玩家数据[id].角色.灵饰[数据.道具]])
    玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.灵饰[数据.道具]
    玩家数据[id].角色.灵饰[数据.道具]=nil
    self:助战索要道具(连接id,id,数据.助战编号)
    -- 发送数据(连接id,2010,玩家数据[id].角色:取灵饰数据())
end
function 道具处理类:卸下助战锦衣(连接id,id,道具id,道具格子,数据)
    玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.锦衣[数据.道具]
    玩家数据[id].角色.锦衣[数据.道具]=nil
    self:助战索要道具(连接id,id,数据.助战编号)
    -- 发送数据(连接id,2011,玩家数据[id].角色:取锦衣数据())
    地图处理类:更新锦衣(id,nil,数据.道具)
end
function 道具处理类:佩戴助战锦衣(连接id,id,主人id,道具id,数据)
     local 物品=取物品数据(self.数据[道具id].名称)
     if 玩家数据[id].角色.锦衣[self.数据[道具id].子类]==nil then
        玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
        玩家数据[id].角色[数据.类型][数据.道具]=nil
     else
        local 道具id1=玩家数据[id].角色.锦衣[self.数据[道具id].子类]
        玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
        玩家数据[id].角色[数据.类型][数据.道具]=道具id1
     end
     self:助战索要道具(连接id,id,数据.助战编号)
     地图处理类:更新锦衣(id,玩家数据[id].道具.数据[玩家数据[id].角色.锦衣[self.数据[道具id].子类 ]].名称,self.数据[道具id].子类 )
end
function 道具处理类:助战穿戴装备(连接id,id,主人id,数据)
    数据.类型="道具"
    local 道具id=玩家数据[id].角色[数据.类型][数据.道具]
    if self.数据[道具id] == nil then
        return
    end
    if self.数据[道具id].总类 == 2 and self.数据[道具id].灵饰~=nil then
        self:佩戴助战灵饰(连接id,id,主人id,道具id,数据)
        return
    end
    if self.数据[道具id].总类 == 2 and self.数据[道具id].分类 >=14 and self.数据[道具id].分类 <=19 then
        self:佩戴助战锦衣(连接id,id,主人id,道具id,数据)
        return
    end
    local 装备条件=self:可装备(self.数据[道具id],self.数据[道具id].分类,数据.角色,id)
    if 装备条件~=true and 装备条件~=false then
        发送数据(连接id,7,装备条件)
        return 0
    else
        if 玩家数据[id].角色.装备[self.数据[道具id].分类]~=nil then --检查是否有装备已经佩戴
            local 道具id1=玩家数据[id].角色.装备[self.数据[道具id].分类]
            -- print(道具id1)
            玩家数据[id].角色:卸下装备(self.数据[道具id1],self.数据[道具id1].分类)
            玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
            玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)
            玩家数据[id].角色[数据.类型][数据.道具]=道具id1
        else
            玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
            玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)
            玩家数据[id].角色[数据.类型][数据.道具]=nil
        end
        玩家数据[id].角色:检查临时属性()
    end
    self:助战索要道具(连接id,id,数据.助战编号)
    -- 发送数据(连接id,2009,玩家数据[id].角色:取装备数据())
    发送数据(连接id, 2007, 玩家数据[id].角色:取总数据1())
    if self.数据[道具id].分类==3 then
        地图处理类:更新武器(id,self.数据[玩家数据[id].角色.装备[3]])
    end
end
function 道具处理类:助战索要道具(连接id,id,助战编号)
    self.发送数据={道具={}}
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            if self.数据[玩家数据[id].角色.道具[n]]==nil then
                玩家数据[id].角色.道具[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
            end
        end
    end
    self.发送数据.助战信息={助战编号=助战编号,id=id,模型=玩家数据[id].角色.模型,门派=玩家数据[id].角色.门派}
    self.发送数据.装备 = 玩家数据[id].角色:取装备数据()
    self.发送数据.灵饰 = 玩家数据[id].角色:取灵饰数据()
    self.发送数据.锦衣 = 玩家数据[id].角色:取锦衣数据()
    self.发送数据.总格=玩家数据[id].角色.总格
    发送数据(连接id,2012,self.发送数据)
end
function 道具处理类:索要空道具4(连接id,id)
    self.发送数据={道具={}}
    self.发送数据.银子=玩家数据[id].角色.银子
    self.发送数据.储备=玩家数据[id].角色.储备
    self.发送数据.存银=玩家数据[id].角色.存银
    self.发送数据.仙玉=玩家数据[id].角色.仙玉
    self.发送数据.总格=玩家数据[id].角色.总格
    发送数据(连接id,200,self.发送数据)
end
--------------------------助战操作结束

function 道具处理类:更新上古玉魄显示(id)
    local data = {}
    if 玩家数据[id].角色["上古玉魄·阳"] then
        local 道具id = 玩家数据[id].角色["上古玉魄·阳"]
        if self.数据[道具id] and string.find(self.数据[道具id].名称,"上古玉魄") then
            data[1] = table.copy(self.数据[道具id])
        end
    end
    if 玩家数据[id].角色["上古玉魄·阴"] then
        local 道具id = 玩家数据[id].角色["上古玉魄·阴"]
        if self.数据[道具id] and string.find(self.数据[道具id].名称,"上古玉魄") then
            data[2] = table.copy(self.数据[道具id])
        end
    end
    发送数据(玩家数据[id].连接id,561,data)
end

-- function 道具处理类:上古玉魄佩戴(id,道具id)
--     if not self.数据[道具id] or not string.find(self.数据[道具id].名称,"上古玉魄") then return end
--     local x名称 = self.数据[道具id].名称
--     if 玩家数据[id].角色[x名称] then --有佩戴
--         常规提示(id,"#Y你已佩戴有#R" ..x名称 .."#Y了")
--         return
--     else
--             if self.数据[道具id]    then
--                 local xxx = self:道具id取编号(id,道具id)
--                 if xxx ~= 0 then
--                     玩家数据[id].角色.道具[xxx] = nil
--                     玩家数据[id].角色[x名称] = 道具id
--                 end
--             end
--     end
--     玩家数据[id].角色:刷新信息()
--     发送数据(玩家数据[id].连接id,12)
--     道具刷新(id)
--     self:更新上古玉魄显示(id)
--     常规提示(id,"#Y佩戴#R" ..x名称 .."#Y成功！")
-- end
function 道具处理类:上古玉魄佩戴(id,道具id)
    if not self.数据[道具id] or not string.find(self.数据[道具id].名称,"上古玉魄") then return end
    local x名称 = self.数据[道具id].名称

    -- 先检查是否已佩戴
    if 玩家数据[id].角色[x名称] then --有佩戴
        -- 获取背包中当前道具的位置
        local xxx = self:道具id取编号(id,道具id)
        if xxx == 0 then return end -- 道具不存在

        -- 获取当前佩戴的道具ID
        local 原道具id = 玩家数据[id].角色[x名称]

        -- 实现位置互换
        -- 1. 先将背包中的道具佩戴到身上
        玩家数据[id].角色.道具[xxx] = 原道具id  -- 背包格子放入原佩戴的道具
        玩家数据[id].角色[x名称] = 道具id     -- 身上佩戴新道具

        -- 注意：这里不需要再设置背包中原道具为nil，因为已经用原道具id替换了

        常规提示(id,"#Y更换佩戴#R" ..x名称 .."#Y成功！")
    else
        -- 如果未佩戴，直接佩戴
        if self.数据[道具id] then
            local xxx = self:道具id取编号(id,道具id)
            if xxx ~= 0 then
                玩家数据[id].角色.道具[xxx] = nil
                玩家数据[id].角色[x名称] = 道具id
            end
        end
        常规提示(id,"#Y佩戴#R" ..x名称 .."#Y成功！")
    end

    玩家数据[id].角色:刷新信息()
    发送数据(玩家数据[id].连接id,12)
    道具刷新(id)
    self:更新上古玉魄显示(id)
end

function 道具处理类:卸下上古玉魄(连接id,id,x阴阳)
    local 道具格子=玩家数据[id].角色:取道具格子()
    if 道具格子~=0 then
        local 道具id = 玩家数据[id].角色[x阴阳]
        if 道具id and self.数据[道具id] and string.find(self.数据[道具id].名称,"上古玉魄") then
            玩家数据[id].角色[x阴阳] = nil
            玩家数据[id].角色.道具[道具格子] = 道具id
            玩家数据[id].角色:刷新信息()
            发送数据(玩家数据[id].连接id,12)
            道具刷新(id)
            self:更新上古玉魄显示(id)
        else
                常规提示(id,"数据错误，道具不存在")
        end
    else
            常规提示(id,"你的背包已满")
    end
end

function 道具处理类:道具id取编号(id,道具id)
    for an=1,80 do
        if 玩家数据[id].角色.道具[an]~=nil and self.数据[玩家数据[id].角色.道具[an]] and
            self.数据[玩家数据[id].角色.道具[an]].名称 == self.数据[道具id].名称 and self.数据[玩家数据[id].角色.道具[an]].识别码==self.数据[道具id].识别码 then
            return an
        end
    end
    return 0
end

function 道具处理类:使用道具(连接id,id,内容)
    if 玩家数据[id].坐牢中 or 玩家数据[id].烤火 then
        常规提示(id,"当前不能使用道具")
        return
    end
    local 包裹类型=内容.类型
    local 道具格子=内容.编号
    local 删除数量=1
    local 加血对象=0
    local 商城产出 = nil
    local 道具提示 = true
    if 内容.窗口=="召唤兽" then
        if 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        else
            加血对象=内容.序列
        end
    elseif 内容.窗口=="坐骑" then
        local yxz=true
        local 道具id=玩家数据[id].角色[包裹类型][道具格子]
        if self.数据[道具id]~=nil and (self.数据[道具id].名称=="玄灵珠·回春" or self.数据[道具id].名称=="玄灵珠·破军" or self.数据[道具id].名称=="玄灵珠·空灵" or self.数据[道具id].名称=="玄灵珠·噬魂") then
            yxz=false
        end
        if 玩家数据[id].角色.坐骑列表[内容.序列]==nil then
            常规提示(id,"请选择一只坐骑")
            return
        else
            加血对象=内容.序列
        end
    end
    if 包裹类型~="道具" then
        -- if 包裹类型=="法宝" then
        --   self:佩戴法宝(连接id,id,包裹类型,道具格子)
        --   return
        -- end
        常规提示(id,"只有道具栏的物品才可以使用")
        return
    elseif 道具格子==nil then
        return
    end

    local 道具id=玩家数据[id].角色[包裹类型][道具格子]
    if 道具id==nil or self.数据[道具id]==nil then
        玩家数据[id].道具[道具格子]=nil
        发送数据(连接id,3699)
        return
    end
    local 名称=self.数据[道具id].名称
    local 道具使用=false
    if self:取加血道具(名称) then
        道具使用=true
        local 加血数值=self:取加血道具1(名称,道具id)
        local 加魔数值=self:取加魔道具1(名称,道具id)
        local 伤势数值=self:取加血道具2(名称,道具id)
        if 名称=="翡翠豆腐" then
            self:加血处理(连接id,id,加血数值,加血对象)
            self:加魔处理(连接id,id,加魔数值,加血对象)
        else
            self:加血处理(连接id,id,加血数值,加血对象,nil,伤势数值)
        end
    elseif self:取加魔道具(名称) then
        道具使用=true
        local 加血数值=self:取加血道具1(名称,道具id)
        local 加魔数值=self:取加魔道具1(名称,道具id)
        if 名称=="翡翠豆腐" then
            self:加血处理(连接id,id,加血数值,加血对象)
            self:加魔处理(连接id,id,加魔数值,加血对象)
        else
            self:加魔处理(连接id,id,加魔数值,加血对象)
        end
    elseif self:取寿命道具(名称) then
        if 加血对象==0 then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].种类 =="神兽" then
            常规提示(id,"神兽无法使用此物品")
            return
        else
            local 加血数值=self:取寿命道具1(名称,道具id)
            玩家数据[id].召唤兽:加寿命处理(加血对象,加血数值.数值,加血数值.中毒,连接id,id)
            道具使用=true
        end
    elseif 右键合成宝石[名称] then
        self:一键合宝石(id,道具id,self.数据[道具id].等级,self.数据[道具id].名称)
        return
     -- elseif 右键合成玄灵珠[名称] then
     --    self:一键合玄灵珠(id,道具id,self.数据[道具id].等级,self.数据[道具id].名称)
     --    return
     elseif 名称 == "上古玉魄·阳" or 名称 == "上古玉魄·阴" then
        self:上古玉魄佩戴(id,道具id)
        return

    elseif 右键合成五宝[名称] then
        self:一键合五宝(id)
        return
        ----------召唤兽----------
        elseif 名称=="蕴灵礼包小" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"蕴灵晶体",5,nil,"不存共享")
        道具使用=true
        elseif 名称=="3级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),3,nil,"不存共享")
        道具使用=true
        elseif 名称=="4级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),4,nil,"不存共享")
        道具使用=true
        elseif 名称=="5级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),5,nil,"不存共享")
        道具使用=true
        elseif 名称=="6级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),6,nil,"不存共享")
        道具使用=true
        elseif 名称=="7级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),7,nil,"不存共享")
        道具使用=true
        elseif 名称=="8级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),8,nil,"不存共享")
        道具使用=true
        elseif 名称=="9级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),9,nil,"不存共享")
        道具使用=true

        elseif 名称=="10级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),10,nil,"不存共享")
        道具使用=true

        elseif 名称=="11级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),11,nil,"不存共享")
        道具使用=true

        elseif 名称=="12级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),12,nil,"不存共享")
        道具使用=true

        elseif 名称=="13级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),13,nil,"不存共享")
        道具使用=true

        elseif 名称=="14级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),14,nil,"不存共享")
        道具使用=true

        elseif 名称=="15级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),15,nil,"不存共享")
        道具使用=true

        elseif 名称=="16级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),16,nil,"不存共享")
        道具使用=true

        elseif 名称=="17级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),17,nil,"不存共享")
        道具使用=true

        elseif 名称=="18级宝石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,取宝石(),18,nil,"不存共享")
        道具使用=true

        elseif 名称=="翻一番" then
            玩家数据[id].角色:添加翻一番次数(1)
            道具使用=true
        elseif 名称=="宝石袋" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        local a=取随机数(1,200)
        if  a<20 then
        玩家数据[id].道具:给予道具(id,取宝石(),取随机数(5,10),nil,"不存共享")
        elseif  a<100 then
        玩家数据[id].道具:给予道具(id,取宝石(),取随机数(3,8),nil,"不存共享")
        elseif  a<150 then
        玩家数据[id].道具:给予道具(id,取宝石(),取随机数(2,6),nil,"不存共享")
        else
        玩家数据[id].道具:给予道具(id,取宝石(),取随机数(1,5),nil,"不存共享")
        end
        道具使用=true
        -----
        elseif 名称=="高级宝石袋" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        local a=取随机数(1,200)
        if  a<20 then
        玩家数据[id].道具:给予道具(id,取宝石2(),取随机数(15,20),nil,"不存共享")
        elseif  a<100 then
        玩家数据[id].道具:给予道具(id,取宝石2(),取随机数(13,18),nil,"不存共享")
        elseif  a<150 then
        玩家数据[id].道具:给予道具(id,取宝石2(),取随机数(12,16),nil,"不存共享")
        else
        玩家数据[id].道具:给予道具(id,取宝石2(),取随机数(10,15),nil,"不存共享")
        end
        道具使用=true
        -----
        elseif 名称=="星辉石袋" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        local a=取随机数(1,200)
        if  a<20 then
        玩家数据[id].道具:给予道具(id,取宝石3(),取随机数(10,15),nil,"不存共享")
        elseif  a<100 then
        玩家数据[id].道具:给予道具(id,取宝石3(),取随机数(8,13),nil,"不存共享")
        elseif  a<150 then
        玩家数据[id].道具:给予道具(id,取宝石3(),取随机数(7,11),nil,"不存共享")
        else
        玩家数据[id].道具:给予道具(id,取宝石3(),取随机数(6,10),nil,"不存共享")
        end
        道具使用=true
        -----
        elseif 名称=="精魄灵石袋" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        local a=取随机数(1,200)
        if  a<20 then
        玩家数据[id].道具:给予道具(id,取宝石4(),取随机数(6,10),nil,"不存共享")
        elseif  a<100 then
        玩家数据[id].道具:给予道具(id,取宝石4(),取随机数(5,8),nil,"不存共享")
        elseif  a<150 then
        玩家数据[id].道具:给予道具(id,取宝石4(),取随机数(4,6),nil,"不存共享")
        else
        玩家数据[id].道具:给予道具(id,取宝石4(),取随机数(3,5),nil,"不存共享")
        end
        道具使用=true
        -----
        elseif 名称 == "玄灵珠·回春礼包" then
    local 道具格子 = 玩家数据[id].角色:取道具格子2()
    if 道具格子 < 10 then
        常规提示(id, "背包不足，开启此物品至少需要10个格子")
        return 0
    end
    for i=1,10 do
        玩家数据[id].道具:给予道具(id, "玄灵珠·回春", i) -- 第3个参数是等级
    end
    道具使用 = true

elseif 名称 == "玄灵珠·破军礼包" then
    local 道具格子 = 玩家数据[id].角色:取道具格子2()
    if 道具格子 < 10 then
        常规提示(id, "背包不足，开启此物品至少需要10个格子")
        return 0
    end
    for i=1,10 do
        玩家数据[id].道具:给予道具(id, "玄灵珠·破军", i)
    end
    道具使用 = true

elseif 名称 == "玄灵珠·空灵礼包" then
    local 道具格子 = 玩家数据[id].角色:取道具格子2()
    if 道具格子 < 10 then
        常规提示(id, "背包不足，开启此物品至少需要10个格子")
        return 0
    end
    for i=1,10 do
        玩家数据[id].道具:给予道具(id, "玄灵珠·空灵", i)
    end
    道具使用 = true

elseif 名称 == "玄灵珠·噬魂礼包" then
    local 道具格子 = 玩家数据[id].角色:取道具格子2()
    if 道具格子 < 10 then
        常规提示(id, "背包不足，开启此物品至少需要10个格子")
        return 0
    end
    for i=1,10 do
        玩家数据[id].道具:给予道具(id, "玄灵珠·噬魂", i)
    end
    道具使用 = true

elseif 名称 == "五色灵尘礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<10 then
            常规提示(id,"背包不足，开启此物品至少需要10个格子")
            return 0
        end
        for i=1,10 do
    玩家数据[id].道具:给予道具(id,"五色灵尘",i)
        end
        道具使用=true

        elseif 名称=="五色灵尘袋" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"五色灵尘",1,nil,"不存共享")
        道具使用=true
        -- -----
        elseif 名称=="嘉年华积分" then
        玩家数据[id].角色.嘉年华积分=玩家数据[id].角色.嘉年华积分+10000
        道具使用=true

        elseif 名称=="坐骑礼包" or 名称=="种族坐骑" then
        玩家数据[id].角色:增加种族坐骑(id)
        道具使用=true
        -- elseif 名称=="神柚礼包"then
        --  local 获得名字=self.数据[道具id].类型
        --      if not 玩家数据[id].角色:取新增宝宝数量() then
        --      发送数据(玩家数据[id].连接id, 7, "#y/您当前无法携带更多的召唤兽了")
        --      return false
        --  end
        elseif 名称=="超级小白龙(物)" or 名称=="超级小白龙(法)" or 名称=="神柚礼包" or 名称=="红孩儿礼包" or 名称=="进阶雷龙" or 名称=="五福鲲鹏礼包(法)" or 名称=="五福鲲鹏礼包(物)" or 名称=="飞廉礼包" or 名称=="鲲鹏礼包(法)" or 名称=="鲲鹏礼包(物)" or 名称=="恶魔泡泡礼包"  or 名称=="五福鲲鹏礼包(血)" then
            if not 玩家数据[id].角色:取新增宝宝数量() then
                发送数据(玩家数据[id].连接id, 7, "#y/您当前无法携带更多的召唤兽了")
                return false
            end
            local  等级=0
            local 类型="神兽"
            if 名称=="红孩儿礼包" then
                local 随机法术技能 = {"地狱烈火","泰山压顶","水漫金山","奔雷咒"}
                随机法 = 随机法术技能[取随机数(1,#随机法术技能)]
                local jnz = {"高级神佑复生","高级魔之心","圣婴大王","高级精神集中","高级法术连击","超级三昧真火","高级法术暴击","桀骜自恃","高级法术波动","高级感知",随机法}--给什么技能  你可以自己设置
                local zz={1400,1600,5500,3600,1400,1400,6000}--资质攻,防,体,法,速,躲
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级红孩儿", "超级红孩儿", 类型, nil, 0 , nil , jnz,zz,cz,等级)

            -- elseif 名称=="鲲鹏礼包(物)" then
            --     local jnz =鲲鹏物.jnz
            --     local zz=鲲鹏物.zz
            --     local cz=鲲鹏物.cz
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            -- elseif 名称=="鲲鹏礼包(法)" then
            --     local jnz = 鲲鹏法.jnz
            --     local zz = 鲲鹏法.zz
            --     local cz = 鲲鹏法.cz
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            -- elseif 名称=="五福鲲鹏礼包(法)" then
            --     local jnz = 五福鲲鹏法.jnz
            --     local zz = 五福鲲鹏法.zz
            --     local cz = 五福鲲鹏法.cz
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)

            -- elseif 名称=="五福鲲鹏礼包(物)" then
            --     local jnz = 五福鲲鹏物.jnz
            --     local zz = 五福鲲鹏物.zz
            --     local cz = 五福鲲鹏物.cz
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            elseif 名称=="鲲鹏礼包(物)" then
                local jnz = {"北冥之渊","理直气壮","高级必杀","高级偷袭","高级神佑复生","逍遥游","高级夜战","高级吸血","高级防御","苍鸾怒击"}
                local zz={1600,1600,5500,3500,1500,1500,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            elseif 名称=="鲲鹏礼包(法)" then
                local jnz = {"逍遥游","北冥之渊","扶摇万里","高级神佑复生","高级魔之心","高级法术连击","高级法术暴击","高级法术波动","须弥真言","高级感知"}
                local zz={1600,1600,5500,3500,1500,1500,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            elseif 名称=="五福鲲鹏礼包(法)" then
                local jnz = {"逍遥游","北冥之渊","扶摇万里","高级神佑复生","超级魔之心","超级法术连击","超级法术暴击","超级法术波动","高级感知","浮云神马","超级否定信仰","须弥真言","高级法术波动","高级魔之心","高级法术暴击","高级法术连击","风起龙游","柳暗花明","义薄云天","净台妙谛"}--给什么技能  你可以自己设置
                local zz={1600,1600,5500,3500,1500,1500,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            elseif 名称=="五福鲲鹏礼包(物)" then
                local jnz = {"逍遥游","理直气壮","苍鸾怒击","高级神佑复生","超级必杀","超级偷袭","超级吸血","超级夜战","高级感知","浮云神马","超级否定信仰","无上正真","昼伏夜出","高级偷袭","高级吸血","高级必杀","风起龙游","乘胜追击","嗜血追击","净台妙谛"}--给什么技能  你可以自己设置
                local zz={1600,1600,5500,3500,1500,1500,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)

--适合超否不吸收其他超技
            -- elseif 名称=="鲲鹏礼包(物)" then
            --     local jnz = {"北冥之渊","理直气壮","高级必杀","高级偷袭","高级神佑复生","逍遥游","高级夜战","高级吸血","高级防御","苍鸾怒击"}
            --     local zz={1600,1600,5500,3500,1500,1500,6000}--资质
            --     local cz=1.3--成长
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            -- elseif 名称=="鲲鹏礼包(法)" then
            --     local jnz = {"逍遥游","北冥之渊","扶摇万里","高级神佑复生","高级魔之心","高级法术连击","高级法术暴击","高级法术波动","须弥真言","高级感知"}
            --     local zz={1600,1600,5500,3500,1500,1500,6000}--资质
            --     local cz=1.3--成长
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            -- elseif 名称=="五福鲲鹏礼包(法)" then
            --     local jnz = {"逍遥游","扶摇万里","高级神佑复生","超级魔之心","超级法术连击","超级法术暴击","超级法术波动","高级感知","与生俱来","浮云神马","超级否定信仰","须弥真言","龙魂","风起龙游","柳暗花明","义薄云天","万物之灵（火）","高级招架","高级幸运","高级敏捷"}--,"出奇制胜","好梦连连","圣婴大王","拘魂索命"
            --     local zz={1600,1600,5500,3500,1500,1500,6000}--资质
            --     local cz=1.3--成长
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            -- elseif 名称=="五福鲲鹏礼包(物)" then
            --     local jnz = {"逍遥游","理直气壮","苍鸾怒击","高级神佑复生","超级必杀","超级偷袭","超级合纵","超级夜战","高级感知","浮云神马","超级否定信仰","无上正真","凭风借力","风起龙游","力大无穷（金）","嗜血追击","诸天正法","高级吸血","高级幸运","高级敏捷"}--,"虎虎生风","狂莽一击","大快朵颐","津津有味"
            --     local zz={1600,1600,5500,3500,1500,1500,6000}--资质
            --     local cz=1.3--成长
            --     玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)

            elseif 名称=="五福鲲鹏礼包(血)" then
                local jnz = {"北冥之渊","净台妙谛","灵山禅语","溜之大吉","浮云神马","逍遥游","与生俱来","高级反震","高级防御","超级幸运","超级敏捷","高级土属性吸收","高级火属性吸收","高级水属性吸收","高级雷属性吸收","高级神佑复生","超级法术抵抗","超级招架","超级神迹","凝光炼彩"}
                local zz={1600,1600,5500,3500,1500,1500,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级鲲鹏", "超级鲲鹏", 类型, nil, 0 , nil , jnz,zz,cz,等级)

            elseif 名称=="超级小白龙(物)" then
                local jnz =首冲配置.召唤兽.攻宠.技能
                local zz= 首冲配置.召唤兽.攻宠.资质
                local cz=首冲配置.召唤兽.攻宠.成长
                local 模型=首冲配置.召唤兽.攻宠.模型
                玩家数据[id].召唤兽:添加召唤兽2(模型, 模型, 类型, nil, 0 , nil , jnz,zz,cz,等级)
            elseif 名称=="超级小白龙(法)" then
                local jnz =首冲配置.召唤兽.法宠.技能
                local zz= 首冲配置.召唤兽.法宠.资质
                local cz=首冲配置.召唤兽.法宠.成长
                local 模型=首冲配置.召唤兽.法宠.模型
                玩家数据[id].召唤兽:添加召唤兽2(模型, 模型, 类型, nil, 0 , nil , jnz,zz,cz,等级)

            -- elseif 名称=="超级小白龙(法)" then
            --         local jnz = {}
            --         for i, v in ipairs(首冲配置.召唤兽.法宠.技能) do
            --             jnz[i] = v
            --         end
            --         local zz = {}
            --         for i, v in ipairs(首冲配置.召唤兽.法宠.资质) do
            --             zz[i] = v
            --         end
            --         local cz = 首冲配置.召唤兽.法宠.成长
            --         local 模型 = 首冲配置.召唤兽.法宠.模型
            --         玩家数据[id].召唤兽:添加召唤兽2(模型, 模型, 类型, nil, 0 , nil , jnz,zz,cz,等级)


            elseif 名称=="恶魔泡泡礼包" then
                local jnz = {"高级独行","高级连击","高级偷袭","高级神佑复生","理直气壮","高级必杀","高级感知"}--给什么技能  你可以自己设置
                local zz={1500,1500,4800,1200,1200,1200,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("恶魔泡泡", "恶魔泡泡",类型, nil, 0 , nil , jnz,zz,cz,等级)
            elseif 名称=="飞廉礼包" then
                local jnz = {"高级必杀","高级精神集中","高级连击","高级偷袭","迅风出击","高级吸血","高级感知","高级敏捷","高级永恒"}--给什么技能  你可以自己设置
                local zz={1600,1600,5500,2500,1400,1400,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级飞廉", "超级飞廉", 类型, nil, 0 , nil , jnz,zz,cz,等级)
            elseif 名称=="神柚礼包"then
                local jnz = {"高级永恒","高级精神集中","高级敏捷","高级防御","超级神柚复生","高级感知","高级强力","净台妙谛","高级连击"}--给什么技能  你可以自己设置
                local zz={1400,1800,6000,2500,1400,1400,6000}--资质
                local cz=1.3--成长
                玩家数据[id].召唤兽:添加召唤兽2("超级神柚", "超级神柚",类型, nil, 0 , nil , jnz,zz,cz,等级)

            elseif 名称=="进阶雷龙"then
                local jnz = {"高级法术波动","魔之心","高级法术连击","奔雷咒","感知","高级幸运","高级强力","偷袭","连击","法术暴击"}--给什么技能 1 你可以自己设置
                local zz={1400,1400,4000,2800,1100,1100,6000}--资质
                local cz=1.15--成长
                玩家数据[id].召唤兽:添加召唤兽2("进阶雷龙", "进阶雷龙","新手", nil, 0 , nil , jnz,zz,cz,等级)
            end
         道具使用=true
    elseif 名称 == "随机强化丹" then
          local 强化技能 = {"命中修炼","伤害修炼","防御修炼","速度修炼","法伤修炼","法防修炼","固伤修炼"}
          if self:升级强化技能(id,强化技能[取随机数(1,#强化技能)]) then
             道具使用=true
          end
    elseif 名称=="幸运币" then
        if 玩家数据[id].角色.幸运币==nil then
            玩家数据[id].角色.幸运币=0
        end
            玩家数据[id].角色.幸运币=玩家数据[id].角色.幸运币+1
              常规提示(id,"你获得了乐乐赠送的一枚幸运币")
            道具使用=true

    elseif 名称=="金砖" then
            local jz=10000000
            玩家数据[id].角色:添加银子(jz,"金砖",1)
            常规提示(id,"你获得了"..jz.."两银子")
            道具使用=true
    elseif 名称=="大金砖" then
            local djz=100000000
            玩家数据[id].角色:添加银子(djz,"大金砖",1)
            常规提示(id,"你获得了"..djz.."两银子")
            道具使用=true
    elseif 名称=="阵营礼物包" then
            self:添加阵营礼物(id,取随机数(1,5),取随机数(1,3))
            道具使用=true
    elseif 名称=="师徒积分礼包" then
        玩家数据[id].角色:添加师徒积分(20000)
        道具使用=true
    elseif 名称=="九天揽月称谓礼包" then
        for n=1,#玩家数据[id].角色.称谓 do
            if 玩家数据[id].角色.称谓[n]=="九天揽月" then
                常规提示(id,"已拥有此称谓，无法使用。")
                return
            end
        end
        玩家数据[id].角色:添加称谓("九天揽月")
        道具使用=true

    elseif 名称=="神豪称谓礼包" then
        for n=1,#玩家数据[id].角色.称谓 do
            if 玩家数据[id].角色.称谓[n]=="神豪" then
                常规提示(id,"已拥有此称谓，无法使用。")
                return
            end
        end
        玩家数据[id].角色:添加称谓("神豪")
        道具使用=true
    elseif 名称=="威震天下称谓礼包" then
        for n=1,#玩家数据[id].角色.称谓 do
            if 玩家数据[id].角色.称谓[n]=="威震天下" then
                常规提示(id,"已拥有此称谓，无法使用。")
                return
            end
        end
        玩家数据[id].角色:添加称谓("威震天下",os.time()+86400*7)
        道具使用=true
    elseif 名称=="傲视群雄唯我独尊称谓礼包" then
        for n=1,#玩家数据[id].角色.称谓 do
            if 玩家数据[id].角色.称谓[n]=="傲视群雄唯我独尊" then
                常规提示(id,"已拥有此称谓，无法使用。")
                return
            end
        end
        玩家数据[id].角色:添加称谓("傲视群雄唯我独尊")
        道具使用=true

        elseif 名称=="独步西游若等闲称谓礼包" then
        for n=1,#玩家数据[id].角色.称谓 do
            if 玩家数据[id].角色.称谓[n]=="独步西游若等闲" then
                常规提示(id,"已拥有此称谓，无法使用。")
                return
            end
        end
        玩家数据[id].角色:添加称谓("独步西游若等闲")
        道具使用=true

     elseif 名称=="一举成名天下惊称谓礼包" then
        for n=1,#玩家数据[id].角色.称谓 do
            if 玩家数据[id].角色.称谓[n]=="一举成名天下惊" then
                常规提示(id,"已拥有此称谓，无法使用。")
                return
            end
        end
        玩家数据[id].角色:添加称谓("一举成名天下惊")
        道具使用=true

      elseif 名称=="苍茫三界主沉浮称谓礼包" then
        for n=1,#玩家数据[id].角色.称谓 do
            if 玩家数据[id].角色.称谓[n]=="苍茫三界主沉浮" then
                常规提示(id,"已拥有此称谓，无法使用。")
                return
            end
        end
        玩家数据[id].角色:添加称谓("苍茫三界主沉浮")
        道具使用=true


    elseif 名称=="精锐组冠军" then
        玩家数据[id].角色:添加称谓("精锐组冠军")
        玩家数据[id].角色:添加称谓("精锐组亚军")
        玩家数据[id].角色:添加称谓("精锐组季军")

        玩家数据[id].角色:添加称谓("神威组冠军")
        玩家数据[id].角色:添加称谓("神威组亚军")
        玩家数据[id].角色:添加称谓("神威组季军")

        玩家数据[id].角色:添加称谓("天科组冠军")
        玩家数据[id].角色:添加称谓("天科组亚军")
        玩家数据[id].角色:添加称谓("天科组季军")

        玩家数据[id].角色:添加称谓("天元组冠军")
        玩家数据[id].角色:添加称谓("天元组亚军")
        玩家数据[id].角色:添加称谓("天元组季军")

        道具使用=true

    elseif 名称=="月饼礼包" then
        玩家数据[id].道具:给予道具(id,"月饼",10,nil)
        道具使用=true
    elseif 名称=="灵韵精华礼包" then
        玩家数据[id].道具:给予道具(id,"灵韵精华",1,nil)
        道具使用=true


    elseif 名称=="1亿银票" then
        玩家数据[id].角色:添加银子(100000000,"金砖",1)
        道具使用=true

    elseif 名称=="蕴灵礼包大" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"蕴灵晶体",10,nil,"不存共享")
        道具使用=true

    elseif 名称=="破镜坠礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        if 取随机数(1,100) < 60 then
        玩家数据[id].道具:给予道具(id,"破境·白虎坠",1,nil,"不存共享")
        elseif 取随机数(1,100) < 80 then
        玩家数据[id].道具:给予道具(id,"破境·朱雀坠",1,nil,"不存共享")
        elseif 取随机数(1,100) < 95 then
        玩家数据[id].道具:给予道具(id,"破境·玄武坠",1,nil,"不存共享")
        elseif 取随机数(1,100) < 100 then
        玩家数据[id].道具:给予道具(id,"破境·青龙坠",1,nil,"不存共享")
        end
        道具使用=true




    elseif 名称=="剧情点礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].角色:增加剧情点(1)
        道具使用=true
    -- elseif 名称=="神器积分令" then
    --     if 限制神器次数[id] ==nil then
    --         限制神器次数[id]={次数=0}
    --     end
    --     限制神器次数[id].次数=限制神器次数[id].次数+1
    --     常规提示(id,"您的神器次数增加1次.当前可获得奖励:"..限制神器次数[id].次数.."次")
    --     道具使用=true
    elseif 名称=="随机玄灵珠" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        if 取随机数(1,100) < 25 then
        玩家数据[id].道具:给予道具(id,"玄灵珠·破军",1,nil,"不存共享")
        elseif 取随机数(1,100) < 50 then
        玩家数据[id].道具:给予道具(id,"玄灵珠·灵法",1,nil,"不存共享")
        elseif 取随机数(1,100) < 75 then
        玩家数据[id].道具:给予道具(id,"玄灵珠·回春",1,nil,"不存共享")
        elseif 取随机数(1,100) < 100 then
        玩家数据[id].道具:给予道具(id,"玄灵珠·神速",1,nil,"不存共享")
        end
        道具使用=true
        elseif 名称=="驱赶烟花" then
        地图处理类:跳转地图(id,1001,220,100)
        道具使用=true

        elseif 名称=="随机红包" then--新增
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        if 取随机数(1,100) < 50 then--50%
        玩家数据[id].道具:给予道具(id,"平安红包",1,nil,"不存共享")
        elseif 取随机数(1,100) < 85 then--35%
        玩家数据[id].道具:给予道具(id,"多福红包",1,nil,"不存共享")
        elseif 取随机数(1,100) < 100 then--15%
        玩家数据[id].道具:给予道具(id,"进财红包",1,nil,"不存共享")
        end
        道具使用=true

        elseif 名称=="平安红包" then--小
         local 累充=取随机数(1,10)
         添加累充(id,累充,"平安红包",1)
         玩家数据[id].角色:添加仙玉(累充*100,"平安红包",1)
         道具使用=true

    elseif 名称=="多福红包" then--中
         local 累充=取随机数(18,28)
         添加累充(id,累充,"进财红包",1)
         玩家数据[id].角色:添加仙玉(累充*100,"多福红包",1)
         道具使用=true
    elseif 名称=="进财红包" then--大
         local 累充=取随机数(18,68)
         添加累充(id,累充,"进财红包",1)
         玩家数据[id].角色:添加仙玉(累充*100,"进财红包",1)
         道具使用=true
    elseif 名称=="上古玉魄阳自选" or 名称=="上古玉魄阴自选" then
            发送数据(玩家数据[id].连接id,3539.1,{类型=名称})
            玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
            玩家数据[id].最后操作=名称
            return
    elseif 名称=="兽魂技能转换符" then
            local 对话1="请选择当前需要转换的兽魂技能的角色"
             local 助战id = {}
             助战id[#助战id+1]=id
    -- for i = 1, 4 do
    --  if 玩家数据[id].角色.分角色[i] and 玩家数据[id].角色.分角色[i]~=0 then
    --      助战id[#助战id+1]=玩家数据[id].角色.分角色[i]
    --  end
    -- end
            玩家数据[id].最后对话={}
            玩家数据[id].最后对话.名称="兽魂技能转换"
            玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
            发送数据(玩家数据[id].连接id,1501,{名称="兽魂技能转换",模型=玩家数据[id].角色.模型,对话=对话1,选项=助战id})
            return


        elseif 名称=="本命法宝礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<2 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"法宝精华",99,nil,"不存共享")
        玩家数据[id].道具:给予道具(id,"本命法宝门派秘籍",1,nil,"不存共享")
        道具使用=true
        elseif 名称=="法宝精华礼包5" then
                        local 道具格子=玩家数据[id].角色:取道具格子2()
                                if 道具格子<1 then
                                    常规提示(id,"您的道具栏物品已经满啦")
                                    return 0
                                end
                        玩家数据[id].道具:给予道具(id,"法宝精华",5,nil,"不存共享")
                        道具使用=true
    elseif 名称=="法宝精华礼包10" then
            local 道具格子=玩家数据[id].角色:取道具格子2()
                        if 道具格子<1 then
                                  常规提示(id,"您的道具栏物品已经满啦")
                                    return 0
                        end
                        玩家数据[id].道具:给予道具(id,"法宝精华",10,nil,"不存共享")
                        道具使用=true
    elseif 名称=="法宝精华礼包20" then
            local 道具格子=玩家数据[id].角色:取道具格子2()
                        if 道具格子<1 then
                                  常规提示(id,"您的道具栏物品已经满啦")
                                return 0
                        end
                        玩家数据[id].道具:给予道具(id,"法宝精华",20,nil,"不存共享")
                        道具使用=true
        elseif 名称=="法宝精华礼包30" then
                        local 道具格子=玩家数据[id].角色:取道具格子2()
                               if 道具格子<1 then
                                  常规提示(id,"您的道具栏物品已经满啦")
                                return 0
                                end
                                玩家数据[id].道具:给予道具(id,"法宝精华",30,nil,"不存共享")
                                道具使用=true

        elseif 名称=="法宝精华" then
                        玩家数据[id].角色.本命法宝.精华=玩家数据[id].角色.本命法宝.精华+self.数据[道具id].数量
                        发送数据(连接id, 7, "#Y/当前新增加了#R/"..self.数据[道具id].数量.."点#Y/法宝精华")
                        self:删除道具(连接id,id,包裹类型,道具id,道具格子,self.数据[道具id].数量)
                        发送数据(连接id,3699)
                        return
        elseif 名称=="奖池抽奖" then
                         if 玩家数据[id].角色.奖池抽奖 == nil then
                                    玩家数据[id].角色.奖池抽奖 ={次数=0,累计次数=0,是否大奖=false,历史次数=0}
                         end
                         玩家数据[id].角色.奖池抽奖.次数=玩家数据[id].角色.奖池抽奖.次数+self.数据[道具id].数量
                        发送数据(连接id, 7, "#Y/当前新增加了#R/"..self.数据[道具id].数量.."次#Y/奖池抽奖机会")
                        self:删除道具(连接id,id,包裹类型,道具id,道具格子,self.数据[道具id].数量)
                         发送数据(连接id,3699)

                        local 玩家抽奖数据 = 玩家数据[id].角色.奖池抽奖
                         发送数据(玩家数据[id].连接id, 440009.1, {道具 = 当前抽奖数据,剩余次数 = 玩家抽奖数据})

                        return

        elseif 名称=="指定门派秘籍" then
                        local 对话="请选择所需要的门派秘籍"
                        local 门派={"方寸山","女儿村","神木林","化生寺","大唐官府"
                            ,"盘丝洞","阴曹地府","无底洞","魔王寨","狮驼岭"
                            ,"天宫","普陀山","凌波城","五庄观","龙宫","九黎城"}
                        local xx={}
                        for i = 1,#门派 do
                            xx[#xx+1]=门派[i]
                        end
                        玩家数据[id].最后对话={}
                        玩家数据[id].最后对话.名称="指定门派秘籍"
                        玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
                        发送数据(玩家数据[id].连接id,1501,{名称="指定门派秘籍",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
                        return

    elseif 名称=="星源之石" or 名称=="强化宝石" or 名称=="空间宝石" or 名称=="天命宝石" or  名称=="光芒石" or 名称=="月亮石" or 名称=="太阳石" or 名称=="舍利子" or 名称=="红玛瑙"  or 名称=="黑宝石"  or 名称=="神秘石" or 名称=="头盔强化卡" or 名称=="衣服强化卡"  or 名称=="装备强化石"  or 名称=="项链强化卡"  or 名称=="腰带强化卡"  or 名称=="鞋子强化卡" then
                              道具使用类:窗口道具使用(id,self.数据[道具id],道具id,道具格子)
                            return

    elseif 名称=="本命法宝门派秘籍" then
            if self.数据[道具id].技能 then
                    发送数据(连接id, 7, "#y/此秘籍已经鉴定过了")
                    return
            end
            local 临时属性={"法术伤害" ,"法术防御" ,"治疗能力" ,"气血回复效果" ,"固定伤害" ,"法术伤害结果" ,"格挡值" ,"狂暴等级" ,"穿刺等级" ,"抗物理暴击等级" ,"法术暴击等级" ,"封印命中等级" ,"物理暴击等级" ,"抗法术暴击等级" ,"抵抗封印等级","命中","气血","法防","灵力","魔法","速度","防御","伤害"}
            local 具体数值=取随机数(1,50)
            if 取随机数(1,100)<20 then
                具体数值=取随机数(1,100)
            end
            self.数据[道具id].数值=具体数值
            self.数据[道具id].技能=  临时属性[math.random(1,#临时属性)]
            self.数据[道具id].专用 = id
            发送数据(连接id, 7, "#y/鉴定成功，当前效果为：#R/"..self.数据[道具id].技能)
            发送数据(连接id,3699)--刷新道具

          return


    elseif 名称=="称号材料礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<4 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"蕴灵晶体",20,nil,"不存共享")
        if 取随机数(1,100) < 30 then
        玩家数据[id].道具:给予道具(id,"破境·白虎坠",1,nil,"不存共享")
        elseif 取随机数(1,100) < 60 then
        玩家数据[id].道具:给予道具(id,"破境·朱雀坠",1,nil,"不存共享")
        elseif 取随机数(1,100) < 80 then
        玩家数据[id].道具:给予道具(id,"破境·玄武坠",1,nil,"不存共享")
        elseif 取随机数(1,100) < 100 then
        玩家数据[id].道具:给予道具(id,"破境·青龙坠",1,nil,"不存共享")
        end
        道具使用=true
    elseif 名称 == "水晶糕" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
            常规提示(id,"神兽无法使用此物品")
            return
        end
        if 玩家数据[id].召唤兽.数据[加血对象].元宵.水晶糕<=0 then
            常规提示(id,"#Y你的"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y可食用的水晶糕已达上限。")
            return
        end
        玩家数据[id].召唤兽.数据[加血对象].元宵.水晶糕=玩家数据[id].召唤兽.数据[加血对象].元宵.水晶糕-1
        玩家数据[id].召唤兽.数据[加血对象].元宵.可用=玩家数据[id].召唤兽.数据[加血对象].元宵.可用+1
        常规提示(id,"#Y你的#G"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y的本周可食用元宵数量增加到了#G"..玩家数据[id].召唤兽.数据[加血对象].元宵.可用.."#Y个。")
        道具使用=true
    elseif 名称 == "炼兽真经" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
            常规提示(id,"神兽无法使用此物品")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].成长>=1.3 then
            常规提示(id,"当成长≥1.3时，不可以使用炼兽珍经")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经<=0 then
            if 玩家数据[id].召唤兽.数据[加血对象].元宵.真经时间>os.time() then
                常规提示(id,"这个召唤兽已经吃了太多炼兽真经了，留着"..时间转换(玩家数据[id].召唤兽.数据[加血对象].元宵.真经时间).."给它吃吧。")
                return
            else
                玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经=10
            end
        end
        local sx = 1
        local xx = 1
        if 玩家数据[id].召唤兽.数据[加血对象].成长<1.2 then
            sx = 7
            xx = 5
        elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.23 then
            sx = 6
            xx = 4
        elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.25 then
            sx = 6
            xx = 3
        elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.27 then
            sx = 5
            xx = 2
        elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.29 then
            sx = 4
            xx = 1
        else
            sx = 3
            xx = 1
        end
        local num = 取随机数(sx,xx)*0.001
        玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经=玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经-1
        玩家数据[id].召唤兽.数据[加血对象].成长 = 玩家数据[id].召唤兽.数据[加血对象].成长 + num
        玩家数据[id].召唤兽.数据[加血对象].元宵.真经时间=os.time()+604800
        常规提示(id,"#Y经过一番学习，您的#G"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y成长提升了#G"..num.."#Y。")
        玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
        发送数据(连接id,115,{宝宝数据=玩家数据[id].召唤兽.数据,认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,成长=玩家数据[id].召唤兽.数据[加血对象].成长})
        道具使用=true
    elseif 名称 == "内丹开孔丸" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        end
        if 玩家数据[id].召唤兽.数据[加血对象].内丹 == nil then
            玩家数据[id].召唤兽.数据[加血对象].内丹 = {内丹上限=1,可用内丹=1}
        end
        if 玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 >= 6 then
            常规提示(id,"该召唤兽的内丹上限已达最大，无法继续添加")
            return
        end
        local 成功几率 = 50
        if 正式 then 成功几率 = 100 end
        if 成功几率 >= 取随机数() then
            玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 = 玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 + 1
            玩家数据[id].召唤兽.数据[加血对象].内丹.可用内丹 = 玩家数据[id].召唤兽.数据[加血对象].内丹.可用内丹 + 1
            常规提示(id,"恭喜，内丹开孔成功！")
        else
            常规提示(id,"很遗憾，内丹开孔失败，请继续努力")
        end
        道具使用 = true
    elseif 名称 == "芝麻沁香元宵" or 名称 == "桂花酒酿元宵" or 名称 == "细磨豆沙元宵" or 名称 == "蜜糖腰果元宵" or 名称 == "山楂拔丝元宵" or 名称 == "滑玉莲蓉元宵" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
            常规提示(id,"神兽无法使用此物品")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].元宵.可用<=0 then
            if 玩家数据[id].召唤兽.数据[加血对象].元宵.元宵时间>os.time() then
                常规提示(id,"这个召唤兽已经吃了太多元宵了，留着"..时间转换(玩家数据[id].召唤兽.数据[加血对象].元宵.元宵时间).."给它吃吧。")
                return
            else
                玩家数据[id].召唤兽.数据[加血对象].元宵.可用=10
            end
        end
        local zz = "攻击资质"
        if 名称 == "桂花酒酿元宵" then
            zz = "防御资质"
        elseif 名称 == "细磨豆沙元宵" then
            zz = "速度资质"
        elseif 名称 == "蜜糖腰果元宵" then
            zz = "躲闪资质"
        elseif 名称 == "山楂拔丝元宵" then
            zz = "体力资质"
        elseif 名称 == "滑玉莲蓉元宵" then
            zz = "法力资质"
        end
        local shangxian = {攻击资质=1550,防御资质=1550,体力资质=5500,法力资质=3050,速度资质=1550,躲闪资质=1800}
        if 玩家数据[id].召唤兽.数据[加血对象].参战等级>=155 then
            shangxian = {攻击资质=1650,防御资质=1650,体力资质=7000,法力资质=3600,速度资质=1650,躲闪资质=2000}
        end
        if 玩家数据[id].召唤兽.数据[加血对象][zz]>=shangxian[zz] then
            常规提示(id,"通过元宵提升的"..zz.."最高为"..shangxian[zz])
            return
        end
        local sx = 30
        local xx = 10
        if zz=="攻击资质" or zz=="攻击资质" or zz=="速度资质" or zz=="躲闪资质" then
            if 玩家数据[id].召唤兽.数据[加血对象][zz]<1300 then
                sx = 20
                xx = 10
            elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<1400 then
                sx = 15
                xx = 8
            else
                sx = 10
                xx = 5
            end
        elseif  zz=="法力资质" then
            if 玩家数据[id].召唤兽.数据[加血对象][zz]<1500 then
                sx = 40
                xx = 20
            elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<1700 then
                sx = 30
                xx = 15
            elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<2000 then
                sx = 25
                xx = 10
            else
                sx = 20
                xx = 10
            end
        else
            if 玩家数据[id].召唤兽.数据[加血对象][zz]<3000 then
                sx = 50
                xx = 30
            elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<4000 then
                sx = 40
                xx = 25
            elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<5000 then
                sx = 25
                xx = 10
            else
                sx = 20
                xx = 10
            end
        end
        local num = 取随机数(sx,xx)
        玩家数据[id].召唤兽.数据[加血对象].元宵.可用 = 玩家数据[id].召唤兽.数据[加血对象].元宵.可用-1
        玩家数据[id].召唤兽.数据[加血对象][zz]=玩家数据[id].召唤兽.数据[加血对象][zz]+num
        玩家数据[id].召唤兽.数据[加血对象].元宵.元宵时间=os.time()+604800
        常规提示(id,"#Y恭喜！你的#G"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y的#G"..zz.."#Y增加了#G"..num.."#Y。")
        玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
        发送数据(连接id,114,{宝宝数据=玩家数据[id].召唤兽.数据,认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,资质=zz,资质数额=玩家数据[id].召唤兽.数据[加血对象][zz]})
        道具使用=true
    elseif 名称 == "易经丹" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].等级<30 then
            常规提示(id,"需等级≥30级才能进阶！")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].参战等级<45 and 玩家数据[id].召唤兽.数据[加血对象].等级<60 and 玩家数据[id].召唤兽.数据[加血对象].种类~="神兽" then
            常规提示(id,"参战等级<45级召唤兽,需等级≥60级才能进阶！")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].内丹.格子==nil then
            常规提示(id,"要求：内丹已满，所有低内丹1层，高内丹至少1层")
            return
        end
        if 玩家数据[id].召唤兽.数据[加血对象].进阶 == nil then
            local go = false
            local 高级内丹 ={ "神机步","腾挪劲","玄武躯","龙胄铠","玉砥柱","碎甲刃","阴阳护","凛冽气","舍身击","电魂闪","通灵法","双星爆","催心浪","隐匿击","生死决","血债偿"}
            for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 do
                if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[i] == nil then
                    常规提示(id,"要求：内丹已满，所有低内丹1层，高内丹至少1层")
                    return
                end
                if i==1 then --第一个格子，高内丹只需打一层
                    for k,v in pairs(高级内丹) do
                        if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[1].技能==v then
                            go = true
                        end
                    end
                end
            end
            if go then
                for i=2,玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 do
                    if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[i].等级<1 then
                        常规提示(id,"要求：内丹已满，所有低内丹1层，高内丹至少1层")
                        return
                    end
                end
            else
                for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 do
                    if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[i].等级<1 then
                        常规提示(id,"要求：内丹已满，所有低内丹5层，高内丹至少1层")
                        return
                    end
                end
            end
            玩家数据[id].召唤兽.数据[加血对象].进阶 ={清灵仙露=0,灵性=0,特性="无",特性属性={},开启=false} --所有条件都通过以后才给他赋予这个进阶的值
        end
        if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 <50 then
            玩家数据[id].召唤兽.数据[加血对象].进阶.灵性= 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性+10
            玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力 + 20
            常规提示(id,玩家数据[id].召唤兽.数据[加血对象].名称.."服用了一个易经丹后，神清气爽，仙气缭绕，灵性增加了#R10#Y点")
            if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性==50 then
                if 玩家数据[id].召唤兽.数据[加血对象].参战等级<45 then
                    常规提示(id,"#G你的召唤兽已经达到了进阶的条件了")
                else
                    常规提示(id,"#G你的召唤兽已经达到了进阶的条件,可以进阶改变造型了")
                end
            end
            玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
            发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
        elseif 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 >= 80 then
            local 特调账号 = 满值白名单账号[玩家数据[id].账号] --ponytail: 白名单账号享受去除无用特性+保底最优词条，别的账号别碰
            local txb={"复仇","自恋","灵刃","灵法","巧劲","预知","灵动","瞬击","瞬法","抗法","抗物","阳护","识物","护佑","洞察","弑神","御风","顺势","怒吼","逆境","乖巧","力破","识药","吮魔","争锋","灵断"}
            if 特调账号 then
                txb={"复仇","灵刃","灵法","巧劲","瞬击","瞬法","抗法","抗物","阳护","识物","护佑","洞察","弑神","御风","顺势","怒吼","逆境","力破","识药","吮魔","争锋","灵断"}
            end
            -- ,"暗劲","天道" ,"易怒","狠毒"闪现
            local a =txb[取随机数(1,#txb)] --"逆境"--
            玩家数据[id].召唤兽.数据[加血对象].进阶.特性 = a
            玩家数据[id].召唤兽.数据[加血对象].进阶.特性属性 = {宝宝特性属性(玩家数据[id].召唤兽.数据[加血对象].等级,a,特调账号)}
            玩家数据[id].召唤兽.数据[加血对象].进阶.开启=true
            常规提示(id,"#Y"..玩家数据[id].召唤兽.数据[加血对象].名称.."充分吸收了易经丹中的灵气，特性变得和原来不同了！")
            玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
            发送数据(连接id,16,玩家数据[id].召唤兽.数据)
            发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
        else
            常规提示(id,"你的召唤兽目前无法使用该道具")
            return
        end
        道具使用=true


    elseif 名称=="灵韵精华" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        end
        if 玩家数据[id].召唤兽.数据[加血对象].精华==nil then
            玩家数据[id].召唤兽.数据[加血对象].精华=0
        end
        if 玩家数据[id].召唤兽.数据[加血对象].精华 and 玩家数据[id].召唤兽.数据[加血对象].精华 >=20 then
            常规提示(id,"#Y/该召唤兽使用次数已经达到上限只能吃20次")
            return
        else
            玩家数据[id].召唤兽.数据[加血对象].精华 = (玩家数据[id].召唤兽.数据[加血对象].精华 or 0) + 1
            玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力 + 10
            常规提示(id,"#Y/你的召唤兽增加了10点潜能点")
            道具使用 = true
        end

    elseif 名称 == "玉葫灵髓" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        end
        if 玩家数据[id].召唤兽.数据[加血对象].进阶 ~= nil and 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性>50 then
            local dj = 玩家数据[id].召唤兽.数据[加血对象].等级
            if 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
                玩家数据[id].召唤兽.数据[加血对象].体质=dj+20
                玩家数据[id].召唤兽.数据[加血对象].魔力=dj+20
                玩家数据[id].召唤兽.数据[加血对象].力量=dj+20
                玩家数据[id].召唤兽.数据[加血对象].耐力=dj+20
                玩家数据[id].召唤兽.数据[加血对象].敏捷=dj+20
                玩家数据[id].召唤兽.数据[加血对象].潜力=dj*5
            elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="变异" then
                玩家数据[id].召唤兽.数据[加血对象].体质=dj+15
                玩家数据[id].召唤兽.数据[加血对象].魔力=dj+15
                玩家数据[id].召唤兽.数据[加血对象].力量=dj+15
                玩家数据[id].召唤兽.数据[加血对象].耐力=dj+15
                玩家数据[id].召唤兽.数据[加血对象].敏捷=dj+15
                玩家数据[id].召唤兽.数据[加血对象].潜力=dj*5
            else--if 玩家数据[id].召唤兽.数据[加血对象].种类=="宝宝" then
                玩家数据[id].召唤兽.数据[加血对象].体质=dj+10
                玩家数据[id].召唤兽.数据[加血对象].魔力=dj+10
                玩家数据[id].召唤兽.数据[加血对象].力量=dj+10
                玩家数据[id].召唤兽.数据[加血对象].耐力=dj+10
                玩家数据[id].召唤兽.数据[加血对象].敏捷=dj+10
                玩家数据[id].召唤兽.数据[加血对象].潜力=dj*5
            end
            玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力+100+玩家数据[id].召唤兽.数据[加血对象].精华
            --玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力+100--50灵性加成
            玩家数据[id].召唤兽.数据[加血对象].进阶 = {清灵仙露=0,灵性=50,特性="无",特性属性={},开启=false}
            常规提示(id,"你的召唤兽#R/"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y/服用一个玉葫灵髓后,灵性已回归原始！")
            玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
            发送数据(连接id,16,玩家数据[id].召唤兽.数据)
            发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
        else
            常规提示(id,"召唤兽的灵性必须大于50才能使用玉葫灵髓")
            return
        end

        道具使用=true
    elseif 名称 == "初级清灵仙露" or 名称 == "中级清灵仙露" or 名称 == "高级清灵仙露" or 名称=="特殊清灵仙露" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].进阶 == nil then
            常规提示(id,"召唤兽灵性未达到50！")
            return
        end
        if self:清灵仙露处理(连接id,id,加血对象,道具id) then
            道具使用=true
        else
            return
        end
    elseif 名称 == "蒲扇" then
        local rwid = 玩家数据[id].角色:取任务(81)
        if rwid ~= 0 then
            if 玩家数据[id].角色.地图数据.编号 ~= 6018 then
                常规提示(id,"#Y/该地图无法使用该物品！")
                return
            elseif math.abs(任务数据[rwid].x-玩家数据[id].角色.地图数据.x/20)>3 and math.abs(任务数据[rwid].y-玩家数据[id].角色.地图数据.y/20)>3 then
                常规提示(id,"#Y/并不是要在这里打扫哟！")
                return
            else
                副本_黑风山:完成黑风山任务({id},rwid,81)
            end
        else
            常规提示(id,"#Y/你没有这样的任务！")
            return
        end
        道具使用=true
    elseif 名称 == "拘魂镜"  then
        local rwid = 玩家数据[id].角色:取任务(966)
        if rwid ~= 0 then
        if 玩家数据[id].角色.地图数据.编号 ~= 6054 then
        常规提示(id,"#Y/该地图无法使用该物品！")
        return
        elseif math.abs(任务数据[rwid].x-玩家数据[id].角色.地图数据.x/20)>3 and math.abs(任务数据[rwid].y-玩家数据[id].角色.地图数据.y/20)>3 then
        常规提示(id,"#Y/坐标不对！")
        return
        else
        完成天火之殇上任务({id},rwid,966)
        常规提示(id,"#Y/很可惜，没能阻拦住这些鬼魂~#108")
        end
        else
        常规提示(id,"#Y/你没有这样的任务！")
        return
        end
        道具使用=true
  elseif 名称 == "大闹小铲子"  then
      local rwid = 玩家数据[id].角色:取任务(71)
      if rwid ~= 0 then
        if 玩家数据[id].角色.地图数据.编号 ~= 6033 then
          常规提示(id,"#Y/该地图无法使用该物品！")
          return
        elseif math.abs(任务数据[rwid].x-玩家数据[id].角色.地图数据.x/20)>3 and math.abs(任务数据[rwid].y-玩家数据[id].角色.地图数据.y/20)>3 then
          常规提示(id,"#Y/大圣并不是要在这里除草哟！")
          return
        else
          local 对话="蟠桃园锄树清草，可得讲究力道,增之一分则太多,减之一分则太少。请选择你要使用的力道"
          local 选项={"一分力道","二分力道","我还是在考虑考虑"}
          玩家数据[id].大闹锄树=选项[取随机数(1,2)]
          发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,对话=对话,选项=选项})
        end
      else
        常规提示(id,"#Y/你没有这样的任务！")
        return
      end
        道具使用=true
    elseif 名称 == "玉灵果" then
        -- 重要事件=function()
            if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
                常规提示(id,"请选择一只召唤兽")
                return
            end
            local dsw={"攻击资质","防御资质","体力资质","法力资质","速度资质","躲闪资质"}
            local ffsr=dsw[取随机数(1,#dsw)]
            local nunm=qz(玩家数据[id].召唤兽.数据[加血对象][ffsr]*0.05)+取随机数(1,30)
            for i=1,#dsw do
                玩家数据[id].召唤兽.数据[加血对象].临时资质[dsw[i]]=0
            end
            玩家数据[id].召唤兽.数据[加血对象].临时资质[ffsr]=nunm
            玩家数据[id].召唤兽.数据[加血对象].临时资质["时间"]=os.time()+604800
            玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
            发送数据(玩家数据[id].连接id,16,玩家数据[id].召唤兽.数据)
            常规提示(id,"#Y你的#G"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y食用后"..ffsr.."#Y增加了"..nunm.."点，于7日后自动清空！")

        道具使用=true

    elseif 名称 == "召唤兽通用饰品"  then
        if 加血对象==0 then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].饰品~=nil then
            常规提示(id,"这只召唤兽已经有饰品了")
            return
        end
        玩家数据[id].召唤兽.数据[加血对象].饰品 = 名称
        玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
        发送数据(玩家数据[id].连接id,6556,玩家数据[id].召唤兽.数据[加血对象])
        常规提示(id,"佩戴召唤兽饰品成功！")
        道具使用=true
    elseif 名称 == "双龙积分"  then
            --玩家数据[id].双龙之战.数据.活动积分=玩家数据[id].双龙之战.数据.活动积分+999999
            玩家数据[id].双龙之战.数据.活动积分=玩家数据[id].双龙之战.数据.活动积分+9999
            玩家数据[id].双龙之战.数据.贡献值=玩家数据[id].双龙之战.数据.贡献值+1000
            道具使用=true
    elseif 名称 == "玉魄积分"  then
            --玩家数据[id].角色:添加玉魄积分(999999999,"测试礼包",1)
            玩家数据[id].角色:添加玉魄积分(9999,"测试礼包",1)
            道具使用=true
    elseif 名称 == "测试礼包"  then
            玩家数据[id].角色:添加银子(9999999999,"测试礼包",1)
            玩家数据[id].角色:添加经验(9999999999,"测试礼包",1)
            玩家数据[id].道具:给予道具(id,"160无级别礼包",1,nil,"不存共享")
            玩家数据[id].角色:添加仙玉(999999,"测试礼包",1)
            玩家数据[id].道具:给予道具(id,"上古玉魄阳自选",1,nil,"不存共享")
            玩家数据[id].道具:给予道具(id,"上古玉魄阴自选",1,nil,"不存共享")
             道具使用=true
    elseif 名称 == "双龙之战会员"  then
            玩家数据[id].双龙之战.数据.历史贡献与签到.会员=true
            道具使用=true
            常规提示(id, "#P/【尊敬的用户】#Y您已成功开启：双龙之战会员特权")
    elseif 名称=="会员周卡" or 名称=="会员月卡" or 名称=="会员年卡" then
            local 天数 = 0
            if 名称=="会员周卡" then
                天数 = 7
            elseif 名称=="会员月卡" then
                天数 = 30
            elseif 名称=="会员年卡" then
                天数 = 365
            end
            if 玩家数据[id].角色.月卡 == nil then
                玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+60*60*24*天数}
            elseif os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 then
                玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+60*60*24*天数}
            else
                玩家数据[id].角色.月卡 = {生效=true,到期时间=玩家数据[id].角色.月卡.到期时间+60*60*24*天数}
            end
            local 经验=30000000
            local 银子=50000000
            玩家数据[id].角色:添加经验(经验,"月卡",1)
            玩家数据[id].角色:添加银子(银子,"月卡",1)
            玩家数据[id].道具:给予道具(id,"奖池抽奖",5,nil,"不存共享")
            玩家数据[id].道具:给予道具(id,"修炼果",20,nil,"不存共享")
            玩家数据[id].道具:给予道具(id,"神兜兜",20,nil,"不存共享")
            玩家数据[id].道具:给予道具(id,"扫荡卡",30,nil,"不存共享")
            玩家数据[id].道具:给予道具(id,"九转金丹礼包",5,nil,"不存共享")
            常规提示(id,"#Y激活会员"..(天数==7 and "周" or 天数==30 and "月" or "年").."卡成功,会员到期日前,每日可领取奖励物品！")
            发送数据(玩家数据[id].连接id,6573.1,{月卡=玩家数据[id].角色.月卡})
            道具使用=true

    elseif 名称 == "一级法宝礼包" or 名称 == "二级法宝礼包" or 名称 == "三级法宝礼包" then
        local 法宝表 = {"碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇"}
        if 名称 == "二级法宝礼包" then
            法宝表 = {"发瘟匣","断线木偶","五彩娃娃","七杀","金刚杵","兽王令","摄魂"}
        elseif 名称 == "三级法宝礼包" then
            法宝表 = {"失心钹","五火神焰印","九幽","普渡","鬼泣","斩魔","奇门五行令","神木宝鼎","金箍棒","混元伞","无魂傀儡","苍白纸人","乾坤玄火塔","无尘扇","无字经","干将莫邪","慈悲","救命毫毛","伏魔天书","镇海珠"}
        end
        self:给予法宝(id,法宝表[取随机数(1,#法宝表)])
        道具使用=true
    elseif self.数据[道具id].总类==149 then --召唤兽饰品
        if 加血对象==0 then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[加血对象].饰品~=nil then
            常规提示(id,"这只召唤兽已经有饰品了")
            return
        end
        if 玩家数据[id].召唤兽.数据[加血对象].模型.."饰品"==self.数据[道具id].名称 then
            玩家数据[id].召唤兽.数据[加血对象].饰品 = 1
            常规提示(id,"佩戴召唤兽饰品成功！")
            发送数据(玩家数据[id].连接id,6556,玩家数据[id].召唤兽.数据[加血对象])
        else
            常规提示(id,"该饰品不符合这个召唤兽")
            return
        end
        道具刷新(id)
        道具使用=true
    elseif 名称 == "如意丹"  then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        elseif self.数据[道具id].灵气==nil then
            -- 常规提示(id,"请选择一只召唤兽")
            return
        end
        local 五行=self.数据[道具id].灵气
        local sx=""
        if 五行=="金" then
            sx="力量"
        elseif 五行=="水" then
            sx="敏捷"
        elseif 五行=="木" then
            sx="体质"
        elseif 五行=="火" then
            sx="魔力"
        elseif 五行=="土" then
            sx="耐力"
        end
        if 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
            if 玩家数据[id].召唤兽.数据[加血对象][sx]<玩家数据[id].召唤兽.数据[加血对象].等级+20 then
                 常规提示(id,"神兽的属性点最低只能调整到等级+20")
                return
            end
        else
            if 玩家数据[id].召唤兽.数据[加血对象][sx]<玩家数据[id].召唤兽.数据[加血对象].等级+10 then
                常规提示(id,"该宝宝属性点最低只能调整到等级+10")
                return
            end
        end
        玩家数据[id].召唤兽.数据[加血对象]:如意丹洗点(sx)
        发送数据(连接id,16,玩家数据[id].召唤兽.数据)
        常规提示(id,"你的召唤兽#R/"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y/服用一个如意丹后，"..sx.."减少了1点，潜力点增加了1点")
        道具使用=true
    elseif 名称 == "天赋符" then
        if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
            常规提示(id,"请选择一只召唤兽")
            return
        end
        if self.数据[道具id].属性 then
            local sx=0
            local b0bo=玩家数据[id].召唤兽.数据[加血对象]
            local leixing=self.数据[道具id].属性
            local fwd=leixing
            local weizhi=1
            if leixing=="攻击" then
                fwd="伤害"
                weizhi=3
                sx=玩家数据[id].召唤兽.数据[加血对象]:伤害公式()
            elseif leixing=="气血" then
                fwd="最大气血"
                weizhi=1
                sx=玩家数据[id].召唤兽.数据[加血对象]:气血公式()
            elseif leixing=="防御" then
                weizhi=4
                sx=玩家数据[id].召唤兽.数据[加血对象]:防御公式()
            elseif leixing=="速度" then
                weizhi=5
                sx=玩家数据[id].召唤兽.数据[加血对象]:速度公式()
            elseif leixing=="灵力" then
                weizhi=6
                sx=玩家数据[id].召唤兽.数据[加血对象]:灵力公式()
            elseif leixing=="躲闪" then
                fwd="躲避"
                sx=玩家数据[id].召唤兽.数据[加血对象]:躲避公式()
            end
            玩家数据[id].召唤兽.数据[加血对象].天赋符={lx=fwd,khdwz=weizhi,zhi=sx,sj=os.time()+5}
            玩家数据[id].召唤兽.数据[加血对象]:刷新信息("1")
            发送数据(连接id,20,玩家数据[id].召唤兽.数据[加血对象])
            道具使用=true
            常规提示(id,"使用天赋符成功。这个天赋符将在24小时后消失。")
        end

    elseif 名称 == "善恶棋盘" then
        if 慈心渡鬼["活动开关"] then
            local 队伍id = 玩家数据[id]["队伍"]
            if 队伍id ~= 0 then
                道具提示 = false

                设置任务8930(id)
            else
                常规提示(id, "这个活动必须组队参与！")
                return
            end
        else
            道具使用 = true
            道具提示 = false
            添加最后对话(id, "现在不是活动时间")
        end

    -- elseif 名称 == "圣兽丹" then
    --  if 加血对象==0 then
    --      常规提示(id,"请选择一只召唤兽")
    --      return
    --  end
    --  if 取饰品表(玩家数据[id].召唤兽.数据[加血对象].模型) then
    --      道具使用=true
    --      玩家数据[id].召唤兽.数据[加血对象].饰品 = 1
    --      -- local ysb = {0xFFFF0000,0xFF0000FF,0xFFFCFF00,0xFF24FF00,0xFFDE00FF,0xFF00FFD3}
    --      -- 玩家数据[id].召唤兽.数据[加血对象].饰品颜色 = ysb[取随机数(1,#ysb)]
    --  else
    --      常规提示(id,"你的召唤兽无法使用圣兽丹")
    --      return
    --  end
    elseif 名称=="技能突破符" then
        if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请先选中一只召唤兽")
            return
        elseif #玩家数据[id].召唤兽.数据[内容.序列].技能>=20 then
            常规提示(id,"该召唤兽技能数量已达到上限！")
            return
        end
        local ms = {"反震","吸血","反击","连击","飞行","驱鬼","隐身","感知","再生","冥思","慧根","必杀","幸运","神迹","招架","永恒","敏捷","强力","防御","偷袭","毒","鬼魂术","魔之心","神佑复生","精神集中","否定信仰","雷击","落岩","水攻","烈火","法术连击","法术暴击","法术波动","雷属性吸收","土属性吸收","火属性吸收","水属性吸收","迟钝"}
     for i,d in ipairs(ms) do
        for k,v in ipairs(玩家数据[id].召唤兽.数据[内容.序列].技能) do
                 if d==v then
                    table.remove(ms, i)
                 end
            end
     end
            if #ms<=0 then
                常规提示(id,"无可添加技能")
            return
            end
            local 添加=ms[取随机数(1, #ms)]
            玩家数据[id].召唤兽.数据[内容.序列].技能[#玩家数据[id].召唤兽.数据[内容.序列].技能+1]=添加
            常规提示(id,"您的召唤兽获得了新技能"..添加)
            道具使用=true
    elseif 资质道具[名称] then
            if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请先选中一只召唤兽")
            return
            end
            local 召唤兽=玩家数据[id].召唤兽.数据[内容.序列]
            if 召唤兽.种类~="特殊神兽" then
                常规提示(id,"只有特殊神兽才可以使用此道具!")
               return
            elseif not 召唤兽[资质道具[名称].资质] then
            常规提示(id,"召唤兽资质异常")
               return
            elseif 召唤兽[资质道具[名称].资质] and 召唤兽[资质道具[名称].资质]>=资质道具[名称].上限 then
            常规提示(id,"您的召唤兽可使用资质已达上限!")
              return
            end
            local 增加=取随机数(1, 资质道具[名称].加成)
            local 资质=资质道具[名称].资质
            if 资质=="成长"then
                增加=增加/500
            end
            召唤兽[资质道具[名称].资质]=召唤兽[资质道具[名称].资质]+增加
            if  召唤兽[资质道具[名称].资质]>资质道具[名称].上限 then
                召唤兽[资质道具[名称].资质]=资质道具[名称].上限
            end
            常规提示(id,"您的召唤兽"..资质.."增加了"..增加)
            玩家数据[id].召唤兽.数据[内容.序列]:刷新信息("1")
            发送数据(连接id,20,玩家数据[id].召唤兽.数据[内容.序列])
            道具使用=true
    elseif 名称=="特殊元宵礼包" then
            local 道具={}
            for k,v in pairs(资质道具) do
                table.insert(道具, k)
            end
            local 名称=道具[取随机数(1,#道具)]
            self:给予道具(id, 名称, 1)
            道具使用=true
    elseif 名称=="月华露" then
        if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请先选中一只召唤兽")
            return
        elseif 玩家数据[id].召唤兽.数据[内容.序列].等级>=180 then
            常规提示(id,"该召唤兽等级已达到上限！")
            return
        elseif 玩家数据[id].召唤兽.数据[内容.序列].等级 >= 玩家数据[id].角色.等级 + 10 then
            常规提示(id,"该召唤兽已超过人物等级10级，无法使用该道具")
            return
        else
            local 临时等级=玩家数据[id].召唤兽.数据[内容.序列].等级
            if 临时等级==0 then
                临时等级=1
            end
            -- if self.数据[道具id].数量~= nil then
            --  self.数据[道具id].数量 = 1
            -- end
            玩家数据[id].召唤兽:添加经验(连接id,id,内容.序列,self.数据[道具id].阶品*2*临时等级)
            道具使用=true
        end


        ----------召唤兽----------
    elseif 内容.窗口 =="坐骑" and self.数据[道具id].总类 == 112 then
        self:坐骑装饰佩戴(id,加血对象,道具格子,包裹类型)
        return
    elseif 名称=="玄灵珠·回春" then
         if 加血对象==0 then
            常规提示(id,"请选择一只坐骑")
            return
        end
    elseif 名称=="玄灵珠·回春" then
             if 加血对象==0 then
                常规提示(id,"请选择一只坐骑")
                return
            end
        if 玩家数据[id].角色.玄灵珠==nil then
            玩家数据[id].角色.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
        end
        local 玄灵珠等级 = tonumber(self.数据[道具id].等级) or 0
        if 玩家数据[id].角色.玄灵珠.回春>=10 then
            常规提示(id,"玄灵珠·回春已满级")
                return
        elseif 玄灵珠等级 ~= 玩家数据[id].角色.玄灵珠.回春 + 1 then
            常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.回春+1 .."的玄灵珠·回春")
                  return
        end
            玩家数据[id].角色.玄灵珠.回春 = 玩家数据[id].角色.玄灵珠.回春 + 1
            发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
            常规提示(id,"使用成功，当前玄灵珠·回春等级" ..玩家数据[id].角色.玄灵珠.回春)
            道具使用=true

      elseif 名称=="玄灵珠·破军" then
         if 加血对象==0 then
                常规提示(id,"请选择一只坐骑")
                return
            end
        if 玩家数据[id].角色.玄灵珠==nil then
            玩家数据[id].角色.玄灵珠={类型="破军",破军=0,回春=0,空灵=0,噬魂=0}
        end
        local 玄灵珠等级 = tonumber(self.数据[道具id].等级) or 0
        if 玩家数据[id].角色.玄灵珠.破军>=10 then
            常规提示(id,"玄灵珠·破军已满级")
                return
        elseif 玄灵珠等级 ~= 玩家数据[id].角色.玄灵珠.破军 + 1 then
            常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.破军+1 .."的玄灵珠·破军")
                  return
        end
            玩家数据[id].角色.玄灵珠.破军 = 玩家数据[id].角色.玄灵珠.破军 + 1
            发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
            常规提示(id,"使用成功，当前玄灵珠·破军等级" ..玩家数据[id].角色.玄灵珠.破军)
            道具使用=true
        elseif 名称=="玄灵珠·空灵" then
             if 加血对象==0 then
                常规提示(id,"请选择一只坐骑")
                return
            end
        if 玩家数据[id].角色.玄灵珠==nil then
            玩家数据[id].角色.玄灵珠={类型="空灵",破军=0,回春=0,空灵=0,噬魂=0}
        end
        local 玄灵珠等级 = tonumber(self.数据[道具id].等级) or 0
        if 玩家数据[id].角色.玄灵珠.空灵>=10 then
            常规提示(id,"玄灵珠·空灵已满级")
                return
        elseif 玄灵珠等级 ~= 玩家数据[id].角色.玄灵珠.空灵 + 1 then
            常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.空灵+1 .."的玄灵珠·空灵")
                  return
        end
            玩家数据[id].角色.玄灵珠.空灵 = 玩家数据[id].角色.玄灵珠.空灵 + 1
            发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
              常规提示(id,"使用成功，当前玄灵珠·空灵等级" ..玩家数据[id].角色.玄灵珠.空灵)
              道具使用=true
        elseif 名称=="玄灵珠·噬魂" then
             if 加血对象==0 then
                常规提示(id,"请选择一只坐骑")
                return
            end
          if 玩家数据[id].角色.玄灵珠==nil then
            玩家数据[id].角色.玄灵珠={类型="噬魂",破军=0,回春=0,空灵=0,噬魂=0}
        end
          local 玄灵珠等级 = tonumber(self.数据[道具id].等级) or 0
          if 玩家数据[id].角色.玄灵珠.噬魂>=10 then
            常规提示(id,"玄灵珠·噬魂已满级")
                return
        elseif 玄灵珠等级 ~= 玩家数据[id].角色.玄灵珠.噬魂 + 1 then
          常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.噬魂+1 .."的玄灵珠·噬魂")
                 return
        end
              玩家数据[id].角色.玄灵珠.噬魂 = 玩家数据[id].角色.玄灵珠.噬魂 + 1
              发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
              常规提示(id,"使用成功，当前玄灵珠·噬魂等级" ..玩家数据[id].角色.玄灵珠.噬魂)
              道具使用=true

    elseif 名称 == "福禄丹" then
        if 加血对象==0 then
            常规提示(id,"请选择一只坐骑")
            return
        end
        if 内容.窗口 =="坐骑" and 玩家数据[id].角色.坐骑列表[加血对象] then
            if 玩家数据[id].角色.坐骑列表[加血对象].初始成长>=1.3433 then
                常规提示(id,"这只坐骑的初始成长已达先天的成长上限，无法继续服用。")
                return
            end
            玩家数据[id].角色.坐骑列表[加血对象].初始成长=玩家数据[id].角色.坐骑列表[加血对象].初始成长+0.05
            if 玩家数据[id].角色.坐骑列表[加血对象].初始成长>1.3433 then
                玩家数据[id].角色.坐骑列表[加血对象].初始成长=1.3433
            end
            常规提示(id,玩家数据[id].角色.坐骑列表[加血对象].名称.."服用了一个福禄丹后，神清气爽，仙气缭绕，初始成长增加了#R0.05#Y点！")
            发送数据(玩家数据[id].连接id,69,玩家数据[id].角色.坐骑列表[加血对象])
            玩家数据[id].角色:刷新信息("1")
            道具使用=true
        end
    elseif 名称 == "高级摄灵珠" or 名称 == "摄灵珠" then
        if 加血对象==0 then
            常规提示(id,"请选择一只坐骑")
            return
        end
        if 内容.窗口 =="坐骑" and 玩家数据[id].角色.坐骑列表[加血对象] then
            local zuoqi=玩家数据[id].角色.坐骑列表[加血对象]
            if zuoqi.额外成长>=0.9 then
                常规提示(id,"这只坐骑的额外成长最高不能超过1。")
                return
            end
            local lq=self.数据[道具id].灵气
            if 取随机数()<=10 then
                lq=lq*2
            end
            if zuoqi.SLZ==nil then
                zuoqi.SLZ={次数=100,灵气=0,时间=os.time()+86400,成长次数=1}
            else
                if os.time()-zuoqi.SLZ.时间>0 then
                    zuoqi.SLZ.次数=100
                    zuoqi.SLZ.时间=os.time()+86400
                elseif zuoqi.SLZ.次数<=0 then
                    常规提示(id,"#Y/这只坐骑今日剩喂食次数不足，"..时间转换(zuoqi.SLZ.时间).."后才能继续喂食！")
                    return
                end
            end
            zuoqi.SLZ.灵气=zuoqi.SLZ.灵气+self.数据[道具id].灵气
            zuoqi.SLZ.次数=zuoqi.SLZ.次数-1
            zuoqi.SLZ.时间=os.time()+86400
            local gs = {80,200,320,520,820,1240,1820,2640,3760,6480}
            if zuoqi.SLZ.灵气>=gs[zuoqi.SLZ.成长次数] then
                zuoqi.SLZ.成长次数=zuoqi.SLZ.成长次数+1
                zuoqi.额外成长=zuoqi.额外成长+0.1
                常规提示(id,"#G"..zuoqi.名称.."服用了一个摄灵珠后，额外成长增加了0.1。")
                if zuoqi.额外成长>=0.9 then
                    zuoqi.SLZ=nil
                end
            else
                常规提示(id,zuoqi.名称.."服用了一个摄灵珠后，灵气增加了#R"..lq.."#Y点，当前灵气#R"..zuoqi.SLZ.灵气.."#Y点，今日还可以喂食#R"..zuoqi.SLZ.次数.."#Y次。")
            end
            发送数据(玩家数据[id].连接id,69,zuoqi)
            玩家数据[id].角色:刷新信息("1")
            道具使用=true
        end
    elseif 名称=="红包碎片" then
        if self.数据[道具id].数量<66 then
            常规提示(id,"还是先凑齐66个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,66)
        发送数据(连接id,3699)
        local 链接 = {提示=format("#G/%s#P集齐了66个红包碎片，打开一看发现了一个",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
        local a=取随机数()
        if a<95 then
        玩家数据[id].道具:给予超链接道具(id,"平安红包",1,nil,链接,"不存共享")
        elseif a>95 and a<98 then
        玩家数据[id].道具:给予超链接道具(id,"多福红包",1,nil,链接,"不存共享")
        else
        玩家数据[id].道具:给予超链接道具(id,"进财红包",1,nil,链接,"不存共享")
        end
        return

    elseif 名称=="青花瓷锦衣·碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)--刷新道具
        玩家数据[id].道具:给予道具(id,"青花瓷锦衣",1,nil,"不存共享")
        return

    -- elseif 名称=="彩果" then
    --     local 消耗=99
    --      if self.数据[道具id].数量<消耗 then
    --         常规提示(id,"还是先凑齐"..消耗.."个再使用吧。")
    --         return
    --     end
    --     if not 玩家数据[id].角色.锦衣次数 then
    --         玩家数据[id].角色.锦衣次数=1
    --     else
    --         玩家数据[id].角色.锦衣次数=玩家数据[id].角色.锦衣次数+1
    --     end
    --     self:删除道具(连接id,id,包裹类型,道具id,道具格子,消耗)
    --     发送数据(连接id,3699)
    --     常规提示(id,"使用成功，你获得1次商城免费购买锦衣的资格，当前剩余：#G"..玩家数据[id].角色.锦衣次数)
    --     return
    elseif 名称=="上古玉魄·碎片" then
        if self.数据[道具id].数量<30 then
            常规提示(id,"还是先凑齐30个再打开看看吧。")
            return
        end
        local A={"上古玉魄·阴","上古玉魄·阳"}
        local 奖励=A[取随机数(1,#A)]
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,30)
        发送数据(连接id,3699)
        local 链接 = {提示=format("#G/%s#P集齐了30个上古玉魄·碎片，打开一看发现了一个",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
        玩家数据[id].道具:给予超链接道具(id,奖励,1,nil,链接,"不存共享")
        return

    elseif 名称=="特殊兽诀·碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50本再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        local 链接 = {提示=format("#G/%s#P集齐了50本特殊兽诀·碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
        玩家数据[id].道具:给予超链接道具(id,"特殊魔兽要诀",nil,取碎片特殊要诀(),链接,"不存共享")
        return

    elseif 名称=="观照万象碎片" then
        if self.数据[道具id].数量<30 then
            常规提示(id,"还是先凑齐30本再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,30)
        发送数据(连接id,3699)
        local 链接 = {提示=format("#G/%s#P集齐了30个观照万象碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
        玩家数据[id].道具:给予超链接道具(id,"特殊魔兽要诀",nil,"观照万象",链接,"不存共享")
        return
--新增
        elseif 名称=="圣婴大王碎片" then
        if self.数据[道具id].数量<30 then
            常规提示(id,"还是先凑齐30本再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,30)
        发送数据(连接id,3699)
        local 链接 = {提示=format("#G/%s#P集齐了30个观照万象碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
        玩家数据[id].道具:给予超链接道具(id,"特殊魔兽要诀",nil,"圣婴大王",链接,"不存共享")
        return

    elseif 名称=="超级否定信仰碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50本再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        local 链接 = {提示=format("#G/%s#P集齐了50个超级否定信仰碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
        玩家数据[id].道具:给予超链接道具(id,"超级魔兽要诀",nil,"超级否定信仰",链接,"不存共享")
        return
    elseif 名称=="特效宝珠碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"特效宝珠",nil,nil,nil,"不存共享")
        return
    elseif 名称=="装备属性石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"装备属性石",nil,nil,nil,"不存共享")
        return
    elseif 名称=="数值洗练石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"数值洗练石",nil,nil,nil,"不存共享")
        return
    elseif 名称=="属性洗练石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"属性洗练石",nil,nil,nil,"不存共享")
        return
    elseif 名称=="灵饰洗练石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"灵饰洗练石",nil,nil,nil,"不存共享")
        return
    elseif 名称=="灵饰属性石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"灵饰属性石",nil,nil,nil,"不存共享")
        return
    elseif 名称=="装备词条石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"装备词条石",nil,nil,nil,"不存共享")
        return
    elseif 名称=="词条洗练石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"词条洗练石",nil,nil,nil,"不存共享")
        return
    elseif 名称=="词条属性石碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50个再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        玩家数据[id].道具:给予超链接道具(id,"词条属性石",nil,nil,nil,"不存共享")
        return

    elseif 名称 == "法宝任务书" then
        发送数据(连接id,3720)
        return
    elseif 名称=="五宝盒" then
        玩家数据[id].道具:给予道具(id,取五宝())
        道具使用=true

    -- elseif 名称=="单次奖池抽奖" then
    --         if 玩家数据[id].角色.奖池抽奖 == nil then
    --             玩家数据[id].角色.奖池抽奖 ={次数=0,累计次数=0,是否大奖=false,历史次数=0}
    --         end
    --         玩家数据[id].角色.奖池抽奖.次数=玩家数据[id].角色.奖池抽奖.次数+1
    --         常规提示(id,"#Y/你获得了一次奖池抽奖机会")
    --         道具使用=true
    -- elseif 名称=="十次奖池抽奖" then
    --         local 次数=10
    --         if 玩家数据[id].角色.奖池抽奖 == nil then
    --             玩家数据[id].角色.奖池抽奖 ={次数=0,累计次数=0,是否大奖=false,历史次数=0}
    --         end
    --     玩家数据[id].角色.奖池抽奖.次数=玩家数据[id].角色.奖池抽奖.次数+次数
    --         常规提示(id,"#Y/你获得了"..次数.."次奖池抽奖机会")
    --     道具使用=true
    --  elseif 名称=="测试抽奖" then
    --         local 次数=9999
    --         if 玩家数据[id].角色.奖池抽奖 == nil then
    --             玩家数据[id].角色.奖池抽奖 ={次数=0,累计次数=0,是否大奖=false,历史次数=0}
    --         end
    --     玩家数据[id].角色.奖池抽奖.次数=玩家数据[id].角色.奖池抽奖.次数+次数
    --         常规提示(id,"#Y/你获得了"..次数.."次奖池抽奖机会")
    --     道具使用=true

    elseif 名称=="青花瓷锦衣" then
            if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
                常规提示(id,"请选择一只召唤兽")
                return
            elseif 玩家数据[id].召唤兽.数据[加血对象].种类==nil then
                -- 常规提示(id,"请选择一只召唤兽")
                return
            elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="子女" then
                 常规提示(id,"不可对子女使用")
                return
            elseif 玩家数据[id].召唤兽.数据[加血对象].锦衣编号==1 then
                 常规提示(id,"该召唤兽已使用过了无法再次使用")
                return
            end
            local go=false
          local mx="锦衣"..玩家数据[id].召唤兽.数据[加血对象].模型
            if 糖果专用系统:取召唤兽锦衣(mx) then
            go=true
        end
        if 玩家数据[id].召唤兽.数据[加血对象].锦衣编号==nil then
            玩家数据[id].召唤兽.数据[加血对象].锦衣编号=0
        end
        if go then
            玩家数据[id].召唤兽.数据[加血对象].锦衣编号=1
            发送数据(连接id,16,玩家数据[id].召唤兽.数据)
              常规提示(id,"你的召唤兽#R/"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y/已开启#R"..名称.."#Y/锦衣功能#50")
              道具使用=true
            else
                常规提示(id,"#17少侠，该进阶召唤兽造型未开放")
                return
          end
    elseif 名称=="未激活的符石" or 名称=="未激活的星石" then
        self:激活符石对话(id,道具id)
        return
    elseif 名称=="招魂帖" then
        if self:取队长权限(id)==false then
            常规提示(id,"#Y/你不是队长，无法使用此道具！")
            return
        elseif self.数据[道具id].地图编号~=玩家数据[id].角色.地图数据.编号 then
            常规提示(id,"#Y/地图不对哟！")
            return
        elseif math.abs(self.数据[道具id].x-玩家数据[id].角色.地图数据.x/20)>2 and math.abs(self.数据[道具id].y-玩家数据[id].角色.地图数据.y/20)>2 then
            常规提示(id,"#Y/坐标不对哟！")
            return
        end
        道具使用=true
        降妖伏魔:使用招魂帖(id,self.数据[道具id].地图编号,self.数据[道具id].x,self.数据[道具id].y)
    elseif 名称=="逐妖蛊虫" then
        if self:取队长权限(id)==false then
            常规提示(id,"#Y/你不是队长，无法使用此道具！")
            return
        elseif self.数据[道具id].地图编号~=玩家数据[id].角色.地图数据.编号 then
            常规提示(id,"#Y/地图不对哟！")
            return
        elseif math.abs(self.数据[道具id].x-玩家数据[id].角色.地图数据.x/20)>2 and math.abs(self.数据[道具id].y-玩家数据[id].角色.地图数据.y/20)>2 then
            常规提示(id,"#Y/坐标不对哟！")
            return
        end
        道具使用=true
        降妖伏魔:使用逐妖蛊虫(id)

        elseif 名称 == "十级玄灵珠礼包" then
       local aa名称={"玄灵珠·回春","玄灵珠·破军","玄灵珠·空灵","玄灵珠·噬魂"}
         local abc = aa名称[取随机数(1,#aa名称)]
            玩家数据[id].道具:给予道具(id,abc,10,nil,nil,nil)
            道具使用=true

    elseif 名称=="良师册" then
        if 玩家数据[id].角色.成长礼包==nil then
            常规提示(id,"你已经领完所有奖励了")
            print("良师册！！！！！")
            return
        end
        -- 发送数据(连接id,3715,{是否领取=玩家数据[id].角色.成长礼包,成长礼包 = 全局礼包数据.成长礼包})
        发送数据(连接id,3715,{是否领取=玩家数据[id].角色.成长礼包})
        return
    elseif 名称=="专属大礼包" then
        local 领取物品 = {}
        for n = 1, 10 do
            if 全局礼包数据.邀请码礼包[1]["物品"..n] ~= nil then
                领取物品[#领取物品 + 1] = table.copy(全局礼包数据.邀请码礼包[1]["物品"..n])
            end
        end
        礼包奖励类:领取定义礼包(id, 领取物品)
        道具使用=true
    elseif 名称 == "160随机装备" then
        礼包奖励类:单件随机装备(id,160)
        道具使用=true
    elseif 名称 == "随机140无级别装备" then
        礼包奖励类:单件随机装备(id,140,true)
        道具使用=true
    elseif 名称 == "随机150无级别装备" then
        礼包奖励类:单件随机装备(id,150,true)
        道具使用=true
    elseif 名称 == "随机160无级别装备" then
        礼包奖励类:单件随机装备(id,160,true)
        道具使用=true

    elseif 名称 == "天罡积分礼包" then
            玩家数据[id].角色:添加天罡积分(1000)
        道具使用=true

    elseif 名称=="灵犀玉礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<10 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        for i=1,10 do
            玩家数据[id].道具:给予道具(id,"灵犀玉",nil,true,"不存共享")
        end
        道具使用=true
---新增
  elseif 名称=="星石礼包" then
        玩家数据[id].道具:给予道具(id,"未激活的星石")
    道具使用=true

    elseif 名称=="新三级符石礼包" then
         local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        local 获取符石 = 新三级符石[取随机数(1,#新三级符石)]
        玩家数据[id].道具:给予道具(id,"未激活的符石",3,获取符石,"不存共享")
        道具使用=true

    elseif 名称=="一级符石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"未激活的符石",1,nil,"不存共享")
        道具使用=true
    elseif 名称=="二级符石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"未激活的符石",2,nil,"不存共享")
        道具使用=true
    elseif 名称=="三级符石礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<1 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"未激活的符石",3,nil,"不存共享")
        道具使用=true
    elseif 名称=="九转金丹礼包" then
        local 道具格子=玩家数据[id].角色:取道具格子2()
        if 道具格子<10 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
        end
        玩家数据[id].道具:给予道具(id,"九转金丹",10,300,"不存共享")
        道具使用=true

    elseif self.数据[道具id].总类=="__自选" then
        local 附加={}
        if 名称=="自选特殊兽决" then
            附加 =  {"惊心一剑","龙魂","八凶法阵","欣欣向荣","出其不意","流沙轻音","食指大动","从天而降","大快朵颐","苍鸾怒击","浮云神马","千钧一怒","势如破竹","乘胜追击","凭风借力",
              "顾盼生姿","拘魂索命","溜之大吉","神出鬼没","昼伏夜出","凝光炼彩","净台妙谛","津津有味","灵山禅语","力劈华山","善恶有报","法术防御","月光","死亡召唤","移花接木",
              "灵能激发","夜舞倾城","上古灵符","天降灵葫","无上正真","理直气壮","虎虎生风","叱咤风云","神来气旺","风起龙游","柳暗花明","风之沙盾","清风之华","雨露之泽","映雪棱镜","克敌五行",
              "气贯长虹","义薄云天","无畏布施","剑荡四方","壁垒击破","与生俱来","须弥真言","万物之灵（火）","万物之灵（木）","万物之灵（金）","万物之灵（土）","力大无穷（金）","力大无穷（木）","力大无穷（水）","力大无穷（火）","力大无穷（土）"}

    elseif 名称=="自选超级兽决" then
             附加 ={"超级必杀","超级毒","超级盾气","超级法术暴击","超级法术波动","超级法术抵抗","超级法术连击","超级反击","超级反震","超级防御","超级飞行",
    "超级感知","超级合纵","超级慧根","超级火属性吸收","超级进击必杀","超级进击法暴","超级精神集中","超级雷属性吸收","超级连击","超级敏捷",
    "超级冥思","超级魔之心","超级强力","超级驱鬼","超级神迹","超级水属性吸收","超级偷袭","超级土属性吸收","超级吸血","超级幸运","超级夜战","超级遗志",
    "超级隐身","超级永恒","超级再生","超级招架","超级奔雷咒","超级壁垒击破","超级地狱烈火","超级水漫金山","超级泰山压顶"}

     elseif 名称=="自选钟灵石" then
              附加 ={"163","心源","自我陶醉","健步如飞","血气方刚","回春之术","锐不可当"}

     elseif 名称=="高级宝石礼包" then
         附加 = {"红玛瑙","太阳石","舍利子","黑宝石","月亮石","光芒石"}

    elseif 名称=="珍兽元" then
            if not 玩家数据[id].角色:取新增宝宝数量() then
                常规提示(id, "#Y您当前无法携带更多的召唤兽了")
                return false
            end
            附加={"大力金刚","广目巡守","龙鲤","律法女娲","涂山雪","持国巡守","曼珠沙华","龙龟","增长巡守","般若天女","自在心猿","雷龙","毗舍童子","执音","幽灵","狂豹人形","妙华天女"}
        end
        发送数据(玩家数据[id].连接id,6306,{名称=self.数据[道具id].名称,附加=附加})
        return


    elseif 名称=="特效宝珠礼包" then
        玩家数据[id].道具:给予道具(id,"特效宝珠",10,nil,"不存共享")
        道具使用=true
        -- 常规提示(id,"#Y/获得了九转金丹")
    elseif 名称=="160附魔宝珠礼包" then
        玩家数据[id].道具:给予道具(id,"附魔宝珠",10,160,"不存共享")
        道具使用=true
        -- 常规提示(id,"#Y/获得了附魔宝珠")
  elseif 名称=="90无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,90,"无级别限制",id,商城产出)
        道具使用=true
  elseif 名称=="100无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,100,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="110无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,110,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="120无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,120,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="130无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,130,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="140无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,140,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="150无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,150,"无级别限制",id,商城产出)
        道具使用=true
    elseif 名称=="160无级别礼包" then
        if self.数据[道具id].商城类型 then 商城产出 = true end
        礼包奖励类:全套专用装备(id,160,"无级别限制",id,商城产出)
        道具使用=true
    elseif string.find(名称,"BB装备") and string.find(名称,"级礼包") then
        local 道具格子=玩家数据[id].角色:取道具格子()
        if 道具格子==0 then
            常规提示(id,"#Y/你的背包已满无法继续获得道具")
            return
        end
        self:生成随机BB装备(id,名称,道具格子)
        道具使用=true
    elseif 名称=="60灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"枫华戒",60,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翠叶环",60,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"香木镯",60,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芝兰佩",60,"佩饰"))
        道具使用=true
    elseif 名称=="80灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芙蓉戒",80,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"明月珰",80,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翡玉镯",80,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"逸云佩",80,"佩饰"))
        道具使用=true
    elseif 名称=="100灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"金麟绕",100,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"玉蝶翩",100,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"墨影扣",100,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"莲音玦",100,"佩饰"))
        道具使用=true
    elseif 名称=="120灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"悦碧水",120,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"点星芒",120,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"花映月",120,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"相思染",120,"佩饰"))
        道具使用=true
    elseif 名称=="140灵饰礼包" then
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"九曜光华",140,"戒指"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"凤羽流苏",140,"耳饰"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"金水菩提",140,"手镯"))
        玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"玄龙苍珀",140,"佩饰"))
        道具使用=true
    elseif 名称=="160随机灵饰箱" then
        if 取随机数()<25 then
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"太虚渺云",160,"戒指"))
        elseif 取随机数()<50 then
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"焰云霞珠",160,"耳饰"))
        elseif 取随机数()<75 then
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"浮雪幻音",160,"手镯"))
        else
            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"碧海青天",160,"佩饰"))
        end
        道具使用=true
    elseif string.find(名称, "首充礼包") then
        local 礼包类型映射 = {
            ["首充礼包1"] = "首充礼包",
            ["首充礼包2"] = "中级首充礼包",
            ["首充礼包3"] = "高级首充礼包"
        }
        local 礼包奖励 = {}
        for i = 1, #全局礼包数据.首充礼包 do
            if 礼包类型映射[全局礼包数据.首充礼包[i].礼包类型] == 名称 then
                for n = 1, 10 do
                    if 全局礼包数据.首充礼包[i]["物品"..n] ~= nil then
                        礼包奖励[#礼包奖励 + 1] = table.copy(全局礼包数据.首充礼包[i]["物品"..n])
                    end
                end
                break
            end
        end
        礼包奖励类:领取定义礼包(id, 礼包奖励)
        道具使用=true
    elseif string.find(名称, "优惠礼包") then
        local 礼包奖励 = {}
        for i = 1, #全局礼包数据.优惠礼包 do
            if 全局礼包数据.优惠礼包[i].礼包类型 == 名称 then
                for n = 1, 10 do
                    if 全局礼包数据.优惠礼包[i]["物品"..n] ~= nil then
                        礼包奖励[#礼包奖励 + 1] = table.copy(全局礼包数据.优惠礼包[i]["物品"..n])
                    end
                end
                break
            end
        end
        礼包奖励类:领取定义礼包(id, 礼包奖励)
        道具使用=true
    -- elseif 名称=="80灵饰自选" then
    --         local 配置1={名称="芙蓉戒",灵饰=1, 等级=80, 部位类型="戒指", 自选=1}
    --         local 配置2={名称="翡玉镯",灵饰=1, 等级=80, 部位类型="手镯", 自选=1}
    --         local 配置3={名称="逸云佩",灵饰=1, 等级=80, 部位类型="佩饰", 自选=1}
    --         local 配置4={名称="明月珰",灵饰=1, 等级=80, 部位类型="耳饰", 自选=1}
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    --         道具使用=true
    -- elseif 名称=="100灵饰自选" then
    --         local 配置1={名称="金麟绕",灵饰=1, 等级=100, 部位类型="戒指", 自选=1}
    --         local 配置2={名称="墨影扣",灵饰=1, 等级=100, 部位类型="手镯", 自选=1}
    --         local 配置3={名称="莲音玦",灵饰=1, 等级=100, 部位类型="佩饰", 自选=1}
    --         local 配置4={名称="玉蝶翩",灵饰=1, 等级=100, 部位类型="耳饰", 自选=1}
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    --         道具使用=true
    -- elseif 名称=="120灵饰自选" then
    --         local 配置1={名称="悦碧水",灵饰=1, 等级=120, 部位类型="戒指", 自选=1}
    --         local 配置2={名称="花映月",灵饰=1, 等级=120, 部位类型="手镯", 自选=1}
    --         local 配置3={名称="相思染",灵饰=1, 等级=120, 部位类型="佩饰", 自选=1}
    --         local 配置4={名称="点星芒",灵饰=1, 等级=120, 部位类型="耳饰", 自选=1}
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    --         道具使用=true
    -- elseif 名称=="140灵饰自选" then
    --         local 配置1={名称="九曜光华",灵饰=1, 等级=140, 部位类型="戒指", 自选=1}
    --         local 配置2={名称="金水菩提",灵饰=1, 等级=140, 部位类型="手镯", 自选=1}
    --         local 配置3={名称="玄龙苍珀",灵饰=1, 等级=140, 部位类型="佩饰", 自选=1}
    --         local 配置4={名称="凤羽流苏",灵饰=1, 等级=140, 部位类型="耳饰", 自选=1}
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    --         玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    --         道具使用=true

    elseif 名称 == "80灵饰自选礼包" then
    local 配置1 = {名称="芙蓉戒",灵饰=1,等级=80,部位类型="戒指",自选=1}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    local 配置2 = {名称="翡玉镯",灵饰=1,等级=80,部位类型="手镯",自选=1}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    local 配置3 = {名称="逸云佩",灵饰=1,等级=80,部位类型="佩饰",自选=1}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    local 配置4 = {名称="明月珰",灵饰=1,等级=80,部位类型="耳饰",自选=1}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    道具使用=true

    elseif 名称 == "100灵饰自选礼包" then
    local 配置1 = {名称="金麟绕",灵饰=1,等级=100,自选=1,部位类型="戒指"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    local 配置2 = {名称="墨影扣",灵饰=1,等级=100,自选=1,部位类型="手镯"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    local 配置3 = {名称="莲音玦",灵饰=1,等级=100,自选=1,部位类型="佩饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    local 配置4 = {名称="玉蝶翩",灵饰=1,等级=100,自选=1,部位类型="耳饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    道具使用=true

elseif 名称 == "120灵饰自选礼包" then
    local 配置1 = {名称="悦碧水",灵饰=1,等级=120,自选=1,部位类型="戒指"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    local 配置2 = {名称="花映月",灵饰=1,等级=120,自选=1,部位类型="手镯"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    local 配置3 = {名称="相思染",灵饰=1,等级=120,自选=1,部位类型="佩饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    local 配置4 = {名称="点星芒",灵饰=1,等级=120,自选=1,部位类型="耳饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    道具使用=true

elseif 名称 == "140灵饰自选礼包" then
    local 配置1 = {名称="九曜光华",灵饰=1,等级=140,自选=1,部位类型="戒指"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    local 配置2 = {名称="金水菩提",灵饰=1,等级=140,自选=1,部位类型="手镯"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    local 配置3 = {名称="玄龙苍珀",灵饰=1,等级=140,自选=1,部位类型="佩饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    local 配置4 = {名称="凤羽流苏",灵饰=1,等级=140,自选=1,部位类型="耳饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    道具使用=true

    elseif 名称 == "160灵饰自选礼包" then
    local 配置1 = {名称="太虚渺云",灵饰=1,等级=160,自选=1,部位类型="戒指"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置1)
    local 配置2 = {名称="浮雪幻音",灵饰=1,等级=160,自选=1,部位类型="手镯"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置2)
    local 配置3 = {名称="碧海青天",灵饰=1,等级=160,自选=1,部位类型="佩饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置3)
    local 配置4 = {名称="焰云霞珠",灵饰=1,等级=160,自选=1,部位类型="耳饰"}
    玩家数据[id].道具:给予道具(id, nil, 1, nil, "不存共享", nil,配置4)
    道具使用=true



    elseif 名称 == "抽奖盲盒" and 盲盒抽奖定制 then
        local 盲盒道具 = {}
        if 抽奖数据.盲盒抽奖 then
            local 中奖概率 = 抽奖数据.盲盒抽奖.奖励概率
            local 中奖 = 取随机数(1, 中奖概率)
            local 是否中奖 = {中奖 = false, 物品 = {}}
            for i = 1, 40 do
                if 抽奖数据.盲盒抽奖["物品"..i] then
                    盲盒道具[#盲盒道具 + 1] = table.copy(抽奖数据.盲盒抽奖["物品"..i])
                else
                    break
                end
            end
            for n = 1, #盲盒道具 do
                if n == 1 then
                    if 盲盒道具[n].权重 >= 中奖 then
                        是否中奖.中奖 = true
                        是否中奖.物品[#是否中奖.物品 + 1] = table.copy(盲盒道具[n])
                    end
                else
                    if 中奖 > 盲盒道具[n - 1].权重 and 中奖 <= 盲盒道具[n].权重 then
                        是否中奖.中奖 = true
                        是否中奖.物品[#是否中奖.物品 + 1] = table.copy(盲盒道具[n])
                    end
                end
            end
            礼包奖励类:领取定义礼包(id, 是否中奖.物品)
            -- 广播消息({内容="#S(盲盒抽奖)#Y玩家#R"..玩家数据[id].角色.名称.."#Y在盲盒抽奖中获得了物品#R"..是否中奖.物品[1].名称.."#Y，大家快来围观！！！",频道="xt"})
            发送公告("#S《盲盒抽奖》#Y玩家：#R"..玩家数据[id].角色.名称.."#Y在盲盒抽奖中获得了物品#R"..是否中奖.物品[1].名称.."#Y，大家快来围观大佬！")
            道具使用=true
        else
            常规提示(id,"盲盒数据异常，请联系管理员")
            return
        end

    -- elseif 名称 == "打造熟练度礼包" then
    --     for k,v in pairs(玩家数据[id].角色.辅助技能) do
    --         if v.名称 == "打造技巧" then
    --             -- v.等级 = 160
    --              if v.熟练度 == nil then v.熟练度 = 0 end
    --             v.熟练度 = v.熟练度 + 999999
    --         -- elseif v.名称 == "裁缝技巧" then
    --         --     v.等级 = 160
    --         --      if v.熟练度 == nil then v.熟练度 = 0 end
    --         --     v.熟练度 = v.熟练度 + 2560
    --         -- elseif v.名称 == "炼金术" then
    --         --     v.等级 = 160
    --         --      if v.熟练度 == nil then v.熟练度 = 0 end
    --         --     v.熟练度 = v.熟练度 + 2560
    --         end
    --     end
    --     常规提示(id,"打造技巧、裁缝技巧、炼金术升至160级")
    --     道具使用 = true

--新增
    elseif 名称 == "打造熟练度礼包" then
        for k,v in pairs(玩家数据[id].角色.辅助技能) do
            if v.名称 == "打造技巧" then
                 if v.熟练度 == nil then v.熟练度 = 0 end
                v.熟练度 = v.熟练度 + 9999
             elseif v.名称 == "裁缝技巧" then
                  if v.熟练度 == nil then v.熟练度 = 0 end
                 v.熟练度 = v.熟练度 + 9999
             elseif v.名称 == "炼金术" then
                  if v.熟练度 == nil then v.熟练度 = 0 end
                 v.熟练度 = v.熟练度 + 9999
            elseif v.名称 == "淬灵之术" then
                  if v.熟练度 == nil then v.熟练度 = 0 end
                 v.熟练度 = v.熟练度 + 9999
            end
        end
        常规提示(id,"打造、裁缝、炼金、淬灵熟练度增加9999")
        道具使用 = true


    elseif 名称 == "三打礼包" then
        for k,v in pairs(玩家数据[id].角色.辅助技能) do
            if v.名称 == "打造技巧" then
                v.等级 = 160
                 if v.熟练度 == nil then v.熟练度 = 0 end
                v.熟练度 = v.熟练度 + 2560
            elseif v.名称 == "裁缝技巧" then
                v.等级 = 160
                 if v.熟练度 == nil then v.熟练度 = 0 end
                v.熟练度 = v.熟练度 + 2560
            elseif v.名称 == "炼金术" then
                v.等级 = 160
                 if v.熟练度 == nil then v.熟练度 = 0 end
                v.熟练度 = v.熟练度 + 2560
            end
        end
        常规提示(id,"打造技巧、裁缝技巧、炼金术升至160级")
        道具使用 = true
        玩家数据[id].角色:刷新信息()

    elseif 名称 == "四辅助满" then
        for k,v in pairs(玩家数据[id].角色.辅助技能) do
            if v.名称 == "打造技巧" then
                v.等级 = 160
                if v.熟练度 == nil then v.熟练度 = 0 end
                v.熟练度 = v.熟练度 + 2560
            elseif v.名称 == "裁缝技巧" then
                v.等级 = 160
                if v.熟练度 == nil then v.熟练度 = 0 end
                v.熟练度 = v.熟练度 + 2560
            elseif v.名称 == "炼金术" then
                v.等级 = 160
                if v.熟练度 == nil then v.熟练度 = 0 end
                v.熟练度 = v.熟练度 + 2560
            elseif v.名称 == "健身术" then
                v.等级 = 160
            end
        end
        道具使用 = true
        玩家数据[id].角色:刷新信息()

        elseif 名称=="超级兽诀·碎片" then
        if self.数据[道具id].数量<50 then
            常规提示(id,"还是先凑齐50本再打开看看吧。")
            return
        end
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
        发送数据(连接id,3699)
        local 链接 = {提示=format("#Y/%s#W集齐了50本超级兽诀·碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
        local hdcjjn=取碎片超级要诀()
        玩家数据[id].道具:给予超链接道具(id,"超级魔兽要诀",1,hdcjjn,链接,"不存共享")
        发送数据(连接id,354,hdcjjn)
        return


    elseif 名称 == "神兜兜礼包" then
        self:给予道具(id, "神兜兜", 99,nil,"不存共享")
        道具使用 = true
    elseif 名称 == "神兜兜礼包22" then
        self:给予道具(id, "神兜兜", 99,nil,"不存共享","专用")
        道具使用 = true
    elseif 名称 == "活跃度礼包" then
        添加活跃(id,20)
        道具使用 = true
     elseif 名称 == "时空积分礼包" then
        玩家数据[id].角色:添加人族时空积分(99999)
        玩家数据[id].角色:添加魔族时空积分(99999)
        玩家数据[id].角色:添加仙族时空积分(99999)

        道具使用 = true
    elseif 名称=="暗淡的星辰碎片" then
        玩家数据[id].角色:添加天罡积分(10)
        玩家数据[id].道具:给予道具(id,取暗淡掉落(),1,nil,"不存共享")
                  道具使用=true
    elseif 名称=="微光的星辰碎片" then
        玩家数据[id].角色:添加天罡积分(20)
        玩家数据[id].道具:给予道具(id,取微光掉落(),1,nil,"不存共享")
                  道具使用=true
    elseif 名称=="发光的星辰碎片" then
        玩家数据[id].角色:添加天罡积分(30)
        玩家数据[id].道具:给予道具(id,取发光掉落(),1,nil,"不存共享")
                  道具使用=true
    elseif 名称=="耀眼的星辰碎片" then
        玩家数据[id].角色:添加天罡积分(40)
        玩家数据[id].道具:给予道具(id,取耀眼掉落(),1,nil,"不存共享")
                  道具使用=true
    elseif 名称=="奇异的星辰碎片" then
        玩家数据[id].角色:添加天罡积分(50)
        玩家数据[id].道具:给予道具(id,取奇异掉落(),1,nil,"不存共享")
                  道具使用=true
    elseif 名称=="四神石礼包" then
            local 名称=取强化石()
            玩家数据[id].道具:给予道具(id,名称,5,nil,"不存共享")
            道具使用=true
-------------------------------即时战斗-宝石怪-----------------
  elseif 名称=="沸涌炎海的信标" then
      地图处理类:跳转地图(id,5001,112,27)
      自写活动:沸涌炎海的信标(id)
      道具使用=true
  elseif 名称=="钢铁炼境的信标" then
      地图处理类:跳转地图(id,1241,99,78)
      自写活动:钢铁炼境的信标(id)
      道具使用=true
  elseif 名称=="雷鸣废土的信标" then
      地图处理类:跳转地图(id,1885,47,32)
      自写活动:雷鸣废土的信标(id)
      道具使用=true
  elseif 名称=="幽夜暗域的信标" then
      地图处理类:跳转地图(id,1223,66,46)
      自写活动:幽夜暗域的信标(id)
      道具使用=true
  elseif 名称=="混乱终末的信标" then
      地图处理类:跳转地图(id,1041,68,60)
      自写活动:混乱终末的信标(id)
      道具使用=true
  elseif 名称=="伟大虚空的信标" then
      地图处理类:跳转地图(id,1212,81,58)
      自写活动:伟大虚空的信标(id)
      道具使用=true
  elseif 名称=="巅峰领域的信标" then
      地图处理类:跳转地图(id,5006,143,88)
      自写活动:巅峰领域的信标(id)
      道具使用=true
-------------------------------------------------------------------------------------

    elseif 名称 == "小白龙礼包" then
                local xx ={"物理","法术"}
                local 对话 ="#W/请选择你需要的物理还是法术的#G超级小白龙"
                玩家数据[id].最后操作 = "小白龙物法自选"
                玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
                发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,选项=xx,对话=对话})
                return
    elseif 名称 == "鲲鹏礼包" then
                local xx ={"物理","法术"}
                local 对话 ="#W/请选择你需要的物理还是法术的超级鲲鹏"
                玩家数据[id].最后操作 = "鲲鹏物法自选"
                玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
                发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,选项=xx,对话=对话})
                return

    elseif 名称 == "五福鲲鹏礼包" then
                local xx ={"物理","法术"}
                local 对话 ="#W/请选择你需要的物理还是法术的超级鲲鹏"
                玩家数据[id].最后操作 = "五福鲲鹏物法自选"
                玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
                发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,选项=xx,对话=对话})

                return

    elseif 名称 == "特殊兽诀自选" then
        local 自选技能选择 = table.copy(取自选技能)
        table.insert(自选技能选择, "我再想想")
        玩家数据[id].最后操作 = "特殊兽诀自选"
        玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
        发送数据(玩家数据[id].连接id,1501,{选项=自选技能选择,对话=format("请确认需要选择的特殊技能")})
        return
    elseif 名称 == "160钨金礼包" then
        self:给予道具(id,"钨金",99,nil,"不存共享")
        道具使用 = true
    elseif 名称 == "修炼礼包" then
        self:给予道具(id,"修炼果",99,nil,"不存共享")
        self:给予道具(id, "九转金丹礼包", 10,nil,"不存共享")
        道具使用=true
    elseif 名称=="低级矿石" then
        local 奖励参数=取随机数(1,100)
        if 奖励参数<=30 then
            local 名称="摇钱树苗"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=40 then
            local 名称="召唤兽内丹"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=50 then
            local 名称="五宝盒"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=55 then
            local 名称="金银锦盒"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=60 then
            local 名称="九转金丹"
            玩家数据[id].道具:给予道具(id,名称,1,100,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=65 then
            local 名称="修炼果"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=70 then
          local 名称=取宝石()
          玩家数据[id].道具:给予道具(id,名称,取随机数(1,2),nil,"不存共享")
          常规提示(id,"#Y/你获得了"..名称)
          广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=75 then
          local 名称=取强化石()
          玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
          常规提示(id,"#Y/你获得了"..名称)
          广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        else
            local 名称="5W银子"
            玩家数据[id].角色:添加银子(50000,"低级矿石",1)
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,"5W银子"),频道="xt"})
        end
        道具使用=true
    elseif 名称=="中级矿石" then
        local 奖励参数=取随机数(1,100)
        if 奖励参数<=30 then
            local 名称="摇钱树苗"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=40 then
            local 名称="召唤兽内丹"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=50 then
            local 名称="五宝盒"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=55 then
            local 名称="金银锦盒"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=60 then
          local 名称="九转金丹"
          玩家数据[id].道具:给予道具(id,名称,1,100,nil,"不存共享")
          常规提示(id,"#Y/你获得了"..名称)
          广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=65 then
          local 名称="修炼果"
          玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
          常规提示(id,"#Y/你获得了"..名称)
          广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=70 then
          local 名称=取宝石()
          玩家数据[id].道具:给予道具(id,名称,取随机数(2,3),nil,"不存共享")
          常规提示(id,"#Y/你获得了"..名称)
          广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=75 then
          local 名称=取强化石()
          玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
          常规提示(id,"#Y/你获得了"..名称)
          广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
          else
            local 名称="10W银子"
            玩家数据[id].角色:添加银子(100000,"中级矿石",1)
            常规提示(id,"#Y/你获得了"..名称)
        广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,"10W银子"),频道="xt"})
        end
        道具使用=true
    elseif 名称=="高级矿石" then
        local 奖励参数=取随机数(1,100)
        if 奖励参数<=30 then
            local 名称="摇钱树苗"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=40 then
            local 名称="召唤兽内丹"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=50 then
            local 名称="五宝盒"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        elseif 奖励参数<=55 then
            local 名称="金银锦盒"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
        elseif 奖励参数<=60 then
            local 名称="九转金丹"
            玩家数据[id].道具:给予道具(id,名称,1,200,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
        elseif 奖励参数<=65 then
            local 名称="修炼果"
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
        elseif 奖励参数<=70 then
            local 名称=取宝石()
            玩家数据[id].道具:给予道具(id,名称,取随机数(3,4),nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
        elseif 奖励参数<=75 then
            local 名称=取强化石()
            玩家数据[id].道具:给予道具(id,名称,1,nil,"不存共享")
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
        else
            local 名称="15W银子"
            玩家数据[id].角色:添加银子(150000,"高级矿石",1)
            常规提示(id,"#Y/你获得了"..名称)
            广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,"15W银子"),频道="xt"})
        end
    elseif 名称=="机缘宝箱" then
        抽奖处理:设置钥匙神秘宝箱(id,连接id)
        道具使用=true
    elseif 名称=="秘宝宝箱" then
        抽奖处理:转盘抽奖(id)
        道具使用=true
    elseif 名称=="祈愿宝箱" then
        帮派迷宫:开祈愿宝箱(id)
        self.数据[道具id].次数=self.数据[道具id].次数-1
        if self.数据[道具id].次数<=0 then
            道具使用=true
        else
            return
        end
    elseif 名称=="符纸" then
        if 玩家数据[id].角色:取任务(1163)~=0 and 任务数据[玩家数据[id].角色:取任务(1163)].分类==7 and 任务数据[玩家数据[id].角色:取任务(1163)].子类==2 then
            if 任务数据[玩家数据[id].角色:取任务(1163)].SZDT=="大雁塔一层" and 玩家数据[id].角色.地图数据.编号==1004 then
                文韵墨香:大雁塔烧纸(id)
                道具使用=true
            elseif 任务数据[玩家数据[id].角色:取任务(1163)].SZDT=="大雁塔二层" and 玩家数据[id].角色.地图数据.编号==1005 then
                文韵墨香:大雁塔烧纸(id)
                道具使用=true
            else
                常规提示(id,"请到指定地点焚烧！")
                return
            end
        else
            常规提示(id,"请到指定地点焚烧！")
            return
        end
    elseif 名称=="鬼谷子" then  --
        if 玩家数据[id].角色.阵法[self.数据[道具id].子类]==nil then
            玩家数据[id].角色.阵法[self.数据[道具id].子类]=1
            常规提示(id,"恭喜你学会了如何使用#R/"..self.数据[道具id].子类)
            道具使用=true
        else
            常规提示(id,"你已经学过如何使用这个阵型了，请勿重复学习")
            return
        end
    elseif self.数据[道具id].总类==11 and self.数据[道具id].分类==2 then  --合成旗
        发送数据(玩家数据[id].连接id,3529,{地图=self.数据[道具id].地图,xy=self.数据[道具id].xy})
        玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
        玩家数据[id].最后操作="合成旗"
        return
    elseif 名称=="怪物卡片" then
        local 剧情等级=玩家数据[id].角色:取剧情技能等级("变化之术")
        if 剧情等级<6 and self.数据[道具id].等级>剧情等级 then
            常规提示(id,"#Y/你的变化之术等级太低了")
            return
        end
        if 玩家数据[id].角色:取任务(1)~=0 then
            任务数据[玩家数据[id].角色:取任务(1)]=nil
            玩家数据[id].角色:取消任务(1)
        end
        玩家数据[id].角色.变身数据=self.数据[道具id].造型
        道具使用=true
        玩家数据[id].角色:刷新信息()
        发送数据(连接id,37,玩家数据[id].角色.变身数据)
        常规提示(id,"你使用了怪物卡片")
        发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
        发送数据(玩家数据[id].连接id,12)
        设置任务1(id,剧情等级,玩家数据[id].角色.变身数据)
        地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
    elseif 名称=="小象炫卡" or 名称=="腾蛇炫卡" or 名称=="龙马炫卡" or 名称=="雪人炫卡" then
        if 玩家数据[id].角色:取任务(1)~=0 then
            任务数据[玩家数据[id].角色:取任务(1)]=nil
            玩家数据[id].角色:取消任务(1)
        end
        玩家数据[id].角色.变身数据=self.数据[道具id].造型
        道具使用=true
        玩家数据[id].角色:刷新信息()
        发送数据(连接id,37,玩家数据[id].角色.变身数据)
        常规提示(id,"你使用了怪物卡片")
        发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
        发送数据(玩家数据[id].连接id,12)
        -- 设置任务1(id,剧情等级,玩家数据[id].角色.变身数据)
        设置任务1a(id,剧情等级,玩家数据[id].角色.变身数据)
        地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
    elseif 名称=="摄妖香" then  --
        if 玩家数据[id].角色:取任务(9)~=0 then
            玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
        end
        设置任务9(id)
        常规提示(id,"#Y/你使用了摄妖香")
        道具使用=true
    elseif 名称=="未鉴定的灵犀玉" then
        玩家数据[id].道具:给予道具(id,"灵犀玉",1,nil,"不存共享")
        道具使用=true
    elseif 名称=="自动抓鬼卡礼包" then
        玩家数据[id].道具:给予道具(id,"自动抓鬼卡",1,nil,"不存共享")
        道具使用=true
    elseif 名称=="会员周卡礼包" then
        玩家数据[id].道具:给予道具(id,"会员周卡",1,nil,"不存共享")
        道具使用=true

    elseif 名称=="自动回收卡" then
        if 玩家数据[id].角色.自动回收卡 then
            常规提示(id,"#Y/你已经开启过该功能了！")
            return
        end
        玩家数据[id].角色.自动回收卡 = true
        常规提示(id,"#Y/你开启了自动回收")
        道具使用=true
    elseif 名称=="自动抓鬼卡" or 名称=="自动抓鬼年卡"  then
        local 可使用 = true
        if self.数据[道具id].限时时间 and os.time() >= self.数据[道具id].限时时间 then
            常规提示(id,"#Y/该鬼卡已到期")
            道具使用=true
            可使用 = false
        end
        if 可使用 then
            if 自动抓鬼全队限制 or 调试模式 then
                if 玩家数据[id].队伍 and 玩家数据[id].队伍 ~= 0 then
                    local 抓鬼次数 = __Zdzgcs
                    local 存在 = 1
                    local 队伍id = 玩家数据[id].队伍
                    for n=1,#队伍数据[队伍id].成员数据 do
                        if 队伍数据[队伍id].成员数据[n] and 玩家数据[队伍数据[队伍id].成员数据[n]] and 队伍数据[队伍id].成员数据[n] ~= id and (玩家数据[队伍数据[队伍id].成员数据[n]].道具:判断道具是否有(队伍数据[队伍id].成员数据[n], "自动抓鬼卡") or 玩家数据[队伍数据[队伍id].成员数据[n]].道具:判断道具是否有(队伍数据[队伍id].成员数据[n], "自动抓鬼年卡")) then
                            存在 = 存在 + 1
                        end
                        if id ~= 队伍数据[队伍id].成员数据[n] and 玩家数据[队伍数据[队伍id].成员数据[n]].角色.自动抓鬼.领取日期 == tonumber(os.date("%Y%m%d")) then
                            存在 = 存在 - 1
                        end
                    end
                    抓鬼次数 = __Zdzgcs * 存在
                    if 玩家数据[id].角色.自动抓鬼 and 玩家数据[id].角色.自动抓鬼.领取日期 == tonumber(os.date("%Y%m%d")) then
                        抓鬼次数 = 玩家数据[id].角色.自动抓鬼.次数
                    end
                    发送数据(玩家数据[id].连接id,1501,{名称="钟馗",模型="男人_钟馗",选项={"确认领取自动抓鬼次数","我再想想"},对话=format("当前可领取自动抓鬼次数为#G/%s#W/次，有#R/%s#W/位队员提供了次数，请确定是否领取自动抓鬼次数？#R/（注：领取后，若队伍新增有自动抓鬼卡的队员或者领取新的自动抓鬼卡，当日均不会再新增自动抓鬼次数，请谨慎领取）",抓鬼次数,存在)})
                    return
                else
                  常规提示(id,"#Y/请组队后再来领取自动抓鬼次数！")
                  return
                end
            else
                玩家数据[id].角色:判断抓鬼卡日期(id)
            end
        end
    elseif 名称 == "清灵净瓶" then
        local 随机瓶子={"高级清灵仙露","中级清灵仙露","初级清灵仙露"}
        local a =随机瓶子[取随机数(1,#随机瓶子)]
        self:给予道具(id,a)
        -- 常规提示(id,"#Y/清灵净瓶")
        道具使用=true
    elseif 名称=="洞冥草" then  --
        if 玩家数据[id].角色:取任务(9)~=0 then
            玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
            常规提示(id,"#Y/你解除了摄妖香的效果")
            道具使用=true
        end
    elseif 名称=="无常勾魂索" then
        -- if 玩家数据[id].勾魂数据==nil then
        --     玩家数据[id].勾魂数据={}
        -- end
        -- if #玩家数据[id].勾魂数据>10 then --大于10个就删除
        --     table.remove(玩家数据[id].勾魂数据,1)
        -- end
        -- 发送数据(玩家数据[id].连接id,3706,玩家数据[id].勾魂数据)
        发送数据(玩家数据[id].连接id,3706)
        return
    elseif 名称=="三界悬赏令" then
        if 玩家数据[id].角色:取任务(209)~=0 then
            常规提示(id,"#Y/你已经有个悬赏任务在进行了")
        else
            设置任务209(id)
            常规提示(id,"#Y/你获得了三界悬赏任务")
            道具使用=true
        end
    elseif 名称=="树苗" then
        --if 玩家数据[id].角色:取任务(136)~=0 then
            设置任务505(id)
            常规提示(id,"#Y/你种下了树苗")
            道具使用=true
        --end
    elseif 名称=="秘制红罗羹" then
        if 玩家数据[id].角色:取任务(10)~=0 then
            --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
            local 任务id=玩家数据[id].角色:取任务(10)
            if 任务数据[任务id].气血 == nil then
                任务数据[任务id].气血 = 0
            end
            任务数据[任务id].气血=任务数据[任务id].气血+8000000
            常规提示(id,"#Y/你使用了秘制红罗羹")
            道具使用=true
            玩家数据[id].角色:刷新任务跟踪()
        else
            设置任务10(id,8000000,0,0)
            常规提示(id,"#Y/你使用了秘制红罗羹")
            道具使用=true
        end
    elseif 名称=="秘制绿芦羹" then  --
        if 玩家数据[id].角色:取任务(10)~=0 then
            --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
            local 任务id=玩家数据[id].角色:取任务(10)
            if 任务数据[任务id].魔法 == nil then
                任务数据[任务id].魔法 = 0
            end
            任务数据[任务id].魔法=任务数据[任务id].魔法+8000000
            常规提示(id,"#Y/你使用了秘制绿罗羹")
            道具使用=true
            玩家数据[id].角色:刷新任务跟踪()
        else
            设置任务10(id,0,8000000,0)
            常规提示(id,"#Y/你使用了秘制绿罗羹")
            道具使用=true
        end
    elseif 名称=="秘制回梦饮" then  --
        if 玩家数据[id].角色.储备灵气 then
            玩家数据[id].角色.储备灵气 = 玩家数据[id].角色.储备灵气 + 200
        else
            玩家数据[id].角色.储备灵气 = 200
        end
        常规提示(id,"#Y/你获得了#R/160#Y/点神仙饮灵气，现有神仙饮灵气#R"..玩家数据[id].角色.储备灵气.."#Y/点")
        道具使用=true
    elseif 名称=="神仙饮" then  --
        if 玩家数据[id].角色.神仙饮灵气 then
            玩家数据[id].角色.神仙饮灵气 = 玩家数据[id].角色.神仙饮灵气 + 200
        else
            玩家数据[id].角色.神仙饮灵气 = 200
        end
        常规提示(id,"#Y/你获得了#R/200#Y/点神仙饮灵气，现有神仙饮灵气#R"..玩家数据[id].角色.神仙饮灵气.."#Y/点")
        道具使用=true
    elseif 名称=="百岁香" then
        if 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大活力 then 常规提示(id,"使用后活力超过了最大数值无法使用") return end
        if 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大体力 then 常规提示(id,"使用后体力超过了最大数值无法使用") return end
        玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150)
        玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150)
        道具使用=true
    elseif 名称=="白色导标旗" or 名称=="黄色导标旗" or 名称=="蓝色导标旗" or 名称=="绿色导标旗" or 名称=="红色导标旗"  then
        if self.数据[道具id].地图==nil then --定标
            local 地图=玩家数据[id].角色.地图数据.编号
            if 地图~=1001 and 地图~=1070 and 地图~=1208 and 地图~=1092 and 地图~=1122 then
                常规提示(id,"只有长安城、长寿村、傲来国、朱紫国、地府、这四个城市才可以定标哟！")
                return
            end
            local 等级=玩家数据[id].角色:取剧情技能等级("奇门遁甲")
            if 地图==1070 and 等级<1 then
              常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到1级")
              return
            elseif 地图==1092 and 等级<2 then
              常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到2级")
              return
            elseif 地图==1001 and 等级<1 then
              常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到3级")
              return
            elseif 地图==1208 and 等级<2 then
              常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到4级")
              return
            end
            self.数据[道具id].地图=玩家数据[id].角色.地图数据.编号
            self.数据[道具id].x=math.floor(玩家数据[id].角色.地图数据.x/20)
            self.数据[道具id].y=math.floor(玩家数据[id].角色.地图数据.y/20)
            self.数据[道具id].次数=20
            发送数据(玩家数据[id].连接id,3699)
            常规提示(id,"定标成功！")
            return
        else
            --名称=self.数据[道具id].名称,模型="男人_驿站老板",
            发送数据(玩家数据[id].连接id,1501,{选项={"请送我过去","我再想想"},对话=format("请确认是否要传送至#G/%s(%s,%s)#W/处",取地图名称(self.数据[道具id].地图),self.数据[道具id].x,self.数据[道具id].y)})
            玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
            玩家数据[id].最后操作="导标旗"
            return
        end
    elseif 名称=="飞行符" then
        if self:取飞行限制(id)==false then
            玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
            玩家数据[id].最后操作="飞行符"
            发送数据(连接id,13)
            return
        end
    elseif 名称=="超级合成旗" then
        if self:取飞行限制(id)==false then
            玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
            玩家数据[id].最后操作="超级合成旗"
            发送数据(连接id,26)
            return
        end

    elseif 名称=="新春飞行符" then
        if self:取飞行限制(id)==false then
            玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
            玩家数据[id].最后操作="新春飞行符"
            发送数据(连接id,26.1)
            return
        end


    elseif 名称=="归墟共生" then
            if self:取飞行限制(id)==false then
                玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
                玩家数据[id].最后操作="归墟共生"
                local teamid = 玩家数据[id].队伍
                if teamid==0 then
                    常规提示(id,"请组队挑战")
                    return
                end
                local team = 队伍数据[teamid].成员数据
                local 队伍人数 = 0
                for _,_ in pairs(team) do
                    队伍人数 = 队伍人数 + 1
                end
                if 队伍人数 < 5 then
                    常规提示(id,"队伍人数不足5人，无法开启")
                    return
                end
                local datas = {
                    head = {},
                    read = {},
                    副本类型 = "共生"
                }
                for k, v in pairs(team) do
                    table.insert(datas.head, 玩家数据[v].角色.造型)
                end
                for k, v in pairs(team) do
                    local uid = 玩家数据[v].连接id
                    发送数据(uid, 402, datas)          -- 发送打开窗口消息
                end
                return
            end

    elseif 名称=="归墟激战" then
            if self:取飞行限制(id)==false then
                玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
                玩家数据[id].最后操作="归墟激战"
                local teamid = 玩家数据[id].队伍
                if teamid==0 then
                    常规提示(id,"请组队挑战")
                    return
                end

                local team = 队伍数据[teamid].成员数据
                local 队伍人数 = 0
                for _,_ in pairs(team) do
                    队伍人数 = 队伍人数 + 1
                end
                if 队伍人数 < 5 then
                    常规提示(id,"队伍人数不足5人，无法开启")
                    return
                end
                local datas = {
                    head = {},
                    read = {},
                    副本类型 = "激战"
                }
                for k, v in pairs(team) do
                    table.insert(datas.head, 玩家数据[v].角色.造型)
                end
                for k, v in pairs(team) do
                    local uid = 玩家数据[v].连接id
                    发送数据(uid, 402, datas)          -- 发送打开窗口消息
                end
                return
            end
    elseif 名称=="归墟悟空" then
                if self:取飞行限制(id)==false then
                    玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
                    玩家数据[id].最后操作="归墟悟空"
                    local teamid = 玩家数据[id].队伍
                    if teamid==0 then
                        常规提示(id,"请组队挑战")
                        return
                    end
                    local team = 队伍数据[teamid].成员数据
                    local 队伍人数 = 0
                    for _,_ in pairs(team) do
                        队伍人数 = 队伍人数 + 1
                    end
                    if 队伍人数 < 5 then
                        常规提示(id,"队伍人数不足5人，无法开启")
                        return
                    end
                    local datas = {
                        head = {},
                        read = {},
                        副本类型 = "悟空"
                    }
                    for k, v in pairs(team) do
                        table.insert(datas.head, 玩家数据[v].角色.造型)
                    end
                    for k, v in pairs(team) do
                        local uid = 玩家数据[v].连接id
                        发送数据(uid, 402, datas)          -- 发送打开窗口消息
                    end
                    return
                end
    elseif 名称=="归墟应变" then
            if self:取飞行限制(id)==false then
                玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
                玩家数据[id].最后操作="归墟应变"
                local teamid = 玩家数据[id].队伍
                if teamid==0 then
                    常规提示(id,"请组队挑战")
                    return
                end
                local team = 队伍数据[teamid].成员数据
                local 队伍人数 = 0
                for _,_ in pairs(team) do
                    队伍人数 = 队伍人数 + 1
                end
                if 队伍人数 < 5 then
                    常规提示(id,"队伍人数不足5人，无法开启")
                    return
                end
                local datas = {head = {},read = {},副本类型 = "应变"}
                for k, v in pairs(team) do
                    table.insert(datas.head,玩家数据[v].角色.造型)
                end
                for k, v in pairs(team) do
                    local uid = 玩家数据[v].连接id
                    发送数据(uid, 402, datas)
                end
                return
            end


    elseif 名称=="天眼通符" then
        if 玩家数据[id].角色:取任务(8)~=0 then
            任务数据[玩家数据[id].角色:取任务(8)].显示x= 任务数据[玩家数据[id].角色:取任务(8)].x
            任务数据[玩家数据[id].角色:取任务(8)].显示y= 任务数据[玩家数据[id].角色:取任务(8)].y
            道具使用=true
            常规提示(id,"#Y/你使用了天眼通符")
            玩家数据[id].角色:刷新任务跟踪()
            地图处理类:跳转地图(id,任务数据[玩家数据[id].角色:取任务(8)].地图编号,任务数据[玩家数据[id].角色:取任务(8)].x,任务数据[玩家数据[id].角色:取任务(8)].y)
        elseif 玩家数据[id].角色:取任务(14)~=0 then
            任务数据[玩家数据[id].角色:取任务(14)].显示x= 任务数据[玩家数据[id].角色:取任务(14)].x
            任务数据[玩家数据[id].角色:取任务(14)].显示y= 任务数据[玩家数据[id].角色:取任务(14)].y
            道具使用=true
            常规提示(id,"#Y/你使用了天眼通符")
            玩家数据[id].角色:刷新任务跟踪()
            if 调试模式 then
                地图处理类:跳转地图(id,任务数据[玩家数据[id].角色:取任务(14)].地图编号,任务数据[玩家数据[id].角色:取任务(14)].x,任务数据[玩家数据[id].角色:取任务(14)].y)
            end
        end

    elseif 名称=="藏宝图" or 名称=="高级藏宝图" or 名称=="玲珑宝图" then
        if self:取队长权限(id)==false then
            常规提示(id,"#Y/你不是队长，无法使用此道具！")
            return
        elseif self.数据[道具id].地图编号~=玩家数据[id].角色.地图数据.编号 then
            地图处理类:跳转地图(id ,self.数据[道具id].地图编号 ,self.数据[道具id].x, self.数据[道具id].y)
        --  常规提示(id,"#Y/这里没有宝藏哟！")
        --  return
        -- elseif math.abs(self.数据[道具id].x-玩家数据[id].角色.地图数据.x/20)>2 and math.abs(self.数据[道具id].y-玩家数据[id].角色.地图数据.y/20)>2 then
        --  常规提示(id,"#Y/这里没有宝藏哟！")
        --  return
        end
        道具使用=true
        if 名称=="高级藏宝图" then
            self:高级藏宝图处理(id)
        elseif 名称=="玲珑宝图" then
            self:玲珑宝图处理(id)
        else
            self:低级藏宝图处理(id)
        end
    elseif 名称=="九转金丹" then
        if  玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][1] >= 玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
        玩家数据[id].角色:添加人物修炼经验(id,math.floor((self.数据[道具id].阶品 or 1)*0.5))
        道具使用=true
    elseif 名称=="修炼果" then
        if  玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][1]>= 玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
        玩家数据[id].角色:添加bb修炼经验(id,150)
        道具使用=true
    elseif 名称=="如意符" then
        if 判断室内主人(玩家数据[id].角色.地图数据.编号,id) then
            发送数据(玩家数据[id].连接id,1025)
            道具使用=true
        else
            常规提示(id,"这不是你的房子或者不是室内")
            return
        end
    elseif 名称=="吸附石" then
        发送数据(玩家数据[id].连接id,245)
        return


    elseif 名称=="高级宝石礼包" then
        local 随机宝石 = {"红玛瑙","太阳石","舍利子","黑宝石","月亮石","光芒石"}
        local  随机宝石1=随机宝石[取随机数(1,#随机宝石)]
        玩家数据[id].道具:给予道具(id,随机宝石1,取随机数(20,25),nil,"不存共享")
        道具使用=true
    elseif 名称=="储灵袋" then
        for n = 1,4 do
            local 已佩戴=玩家数据[id].角色.法宝佩戴[n]
            if 已佩戴 and self.数据[已佩戴] and self.数据[已佩戴].魔法 then
                local 上限=取灵气上限(self.数据[已佩戴].分类)
                self.数据[已佩戴].魔法=self.数据[已佩戴].魔法+1500
                if self.数据[已佩戴].魔法>上限 then
                    self.数据[已佩戴].魔法=上限
                end
                消息提示(id, "你的法宝"..self.数据[已佩戴].名称.."灵气增加了1500点")
            end
        end
        道具使用=true

    elseif 名称=="回梦丹" then
        local 任务id = 玩家数据[id].角色:取任务(15)
        if 任务id ~= 0 and 任务数据[任务id] and 任务数据[任务id].结束 and 任务数据[任务id].结束 >= 216000000 then--21600
            常规提示(id,"#Y/当前已经使用回梦丹并且达到了最大时间，无法再使用该物品")
            return
        end
        延长队伍回梦丹(id)
        道具使用=true

    elseif 名称=="海马" then
        玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+150
        玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+150
        if 玩家数据[id].角色.活力 > 玩家数据[id].角色.最大活力 then
            玩家数据[id].角色.活力=玩家数据[id].角色.最大活力
        end
        if 玩家数据[id].角色.体力 > 玩家数据[id].角色.最大体力 then
            玩家数据[id].角色.体力=玩家数据[id].角色.最大体力
        end
        体活刷新(id)
        道具使用=true

    elseif 名称=="月饼" then
        if 玩家数据[id].角色.月饼 and 玩家数据[id].角色.月饼 >=1000 then
        常规提示(id,"#Y/该道具使用次数已经达到上限")
        else
        玩家数据[id].角色.月饼 = (玩家数据[id].角色.月饼 or 0) + 1
        玩家数据[id].角色.潜力 = 玩家数据[id].角色.潜力 + 1
        local 剩余月饼次数 = 1000 - 玩家数据[id].角色.月饼
        常规提示(id,"#Y/你增加了1点潜能点，还可以继续使用#R/"..剩余月饼次数.."#Y/个月饼")
        发送数据(玩家数据[id].连接id, 10.1, 玩家数据[id].角色:取总数据1())

        道具使用 = true
        end

    -- elseif self.数据[道具id].总类 == 200 then
    --  if 判断室内主人(玩家数据[id].角色.地图数据.编号,id) then
    --      local tx = {x=62,y=64,名称=名称,方向=1}
    --      for i=1,#房屋数据 do
    --          if 房屋数据[i].ID == id then
    --              table.insert(房屋数据[i].室内装饰,tx)
    --              发送数据(玩家数据[id].连接id,1024,{tx})
    --          end
    --      end
    --      道具使用=true
    --  else
    --      常规提示(id,"这不是你的房子或者不是室内")
    --      return
    --  end
    -- elseif self.数据[道具id].总类 == 202 then
    --  if 判断庭院主人(玩家数据[id].角色.地图数据.编号,id) then
    --      local tx = {x=62,y=64,名称=名称,方向=1}
    --      for i=1,#房屋数据 do
    --          if 房屋数据[i].ID == id then
    --          table.insert(房屋数据[i].庭院装饰,tx)
    --          发送数据(玩家数据[id].连接id,1024,{tx})
    --          end
    --      end
    --      道具使用=true
    --  else
    --      常规提示(id,"这不是你的房子或者不是庭院")
    --      return
    --  end
    elseif self.数据[道具id].名称 == "不磨符" or  self.数据[道具id].名称 == "凤纹灵坠"    or self.数据[道具id].名称 == "灵箓" or self.数据[道具id].名称 == "淬灵石" or self.数据[道具id].名称 == "钟灵石" or self.数据[道具id].名称 == "强化符" or self.数据[道具id].名称 == "神兵图鉴" or self.数据[道具id].名称 == "灵宝图鉴" or self.数据[道具id].名称 == "灵饰图鉴" or self.数据[道具id].名称 == "特技书" or self.数据[道具id].名称 == "特效宝珠" or self.数据[道具id].名称 == "超简易宝珠" or self.数据[道具id].名称 == "愤怒符" then
        发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id],"鉴定"})
        return
    elseif 词条定制 and self.数据[道具id].名称 == "装备词条石" or self.数据[道具id].名称 == "词条属性石" or self.数据[道具id].名称 == "词条洗练石" then
        发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id],"词条"})
        return
    elseif 词条定制 and self.数据[道具id].名称 == "装备属性石" or self.数据[道具id].名称 == "数值洗练石" or self.数据[道具id].名称 == "属性洗练石" then
        发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id],"属性洗练"})
        return
    elseif self.数据[道具id].名称 == "灵饰洗练石" or self.数据[道具id].名称 == "灵饰属性石" then
        发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id],"灵饰洗练"})
        return
    elseif self.数据[道具id].名称 == "焕彩石" then
        发送数据(玩家数据[id].连接id, 233, {道具格子,self.数据[道具id],"焕彩石"})
        return
    elseif self.数据[道具id].名称 == "武器专属石" then
        发送数据(玩家数据[id].连接id, 233, {道具格子,self.数据[道具id],"武器专属"})
        return
    elseif self.数据[道具id].名称 == "特性宝珠" then
        发送数据(玩家数据[id].连接id, 233, {道具格子,self.数据[道具id],"特性宝珠"})
        return
    elseif 名称=="附魔宝珠" then
        发送数据(连接id,3717,{道具=self:索要道具1(id),宝珠数据 = 道具id})
        return
    elseif self.数据[道具id].总类 == 144 then --冒泡框
        local 名称表= {"灿烂葵花","冰清玉洁","甜蜜葡萄","觅缘","喜结连理","甜甜蜜蜜","泡泡相约","秋意浓","踏雪寻梅","竹下饮",
        "午夜惊魂","暖暖线球","云中传音","夏日西瓜","鸿雁传情","中国结","冰雪天地","星月童话","绯色蔷薇","荷塘虹影",
        "如梦似幻","四叶草","海洋乐园","木纹回忆","悦动之心","飞翔之翼","花之浪漫","龙虎斗","吉祥如意","糖果"}
        for i=1,#名称表 do
            if self.数据[道具id].名称 == 名称表[i] then
                玩家数据[id].角色.发言特效 = i
                break
            end
        end

        道具使用=true
    elseif 名称=="炫彩ID" then
        玩家数据[id].角色.id特效 = self.数据[道具id].特效
        道具使用=true
        常规提示(id,"使用成功！")

    elseif 名称 == "队标特效" then
        local tx = {"桃心","风车","彩虹","扇子","小猪","音符","火苗","草莓","兔子","蝴蝶","海星","葫芦","螃蟹","狮王","绿叶","红伞","猫头"}
        玩家数据[id].角色.队标特效 = tx[取随机数(1,#tx)]
        常规提示(id,"你获得#G"..玩家数据[id].角色.队标特效.."#Y队标……")
        地图处理类:更改队伍样式(id,玩家数据[id].角色.队标特效)
        道具使用=true
    elseif self.数据[道具id].名称 == "神秘宝箱" then
        if self:消耗背包道具(连接id,id,"神秘钥匙",1) then
            道具使用=true
            商店处理类:设置神秘宝箱(id)
            发送数据(连接id,235,{道具=神秘宝箱[id],类型="神秘宝箱"})
        else
            常规提示(id,"你没有神秘钥匙无法打开神秘宝箱")
        end
    elseif self.数据[道具id].名称 == "陨铁" then
        发送数据(连接id,239)
        道具提示 = false
    elseif self.数据[道具id].名称 == "秘制食谱" then
        local lssj = 秘制食谱子类()[self.数据[道具id].子类]
        if 玩家数据[id].角色.秘制食谱.食谱[lssj] == nil then
            玩家数据[id].角色.秘制食谱.食谱[lssj] = {次数=秘制食谱消耗()[lssj].次数}
        else
            玩家数据[id].角色.秘制食谱.食谱[lssj].次数 =  玩家数据[id].角色.秘制食谱.食谱[lssj].次数+秘制食谱消耗()[lssj].次数
        end
        道具使用=true
    elseif self.数据[道具id].名称 == "长安战报" then
        长安保卫战:获取玩家数据(id)
        道具提示 = false
    elseif self.数据[道具id].名称 == "九霄清心丸" then
        设置任务241(id)
        道具使用=true
    elseif self.数据[道具id].名称 == "天机培元丹" then
        if not 初始活动.昆仑仙境[id] then
            初始活动.昆仑仙境[id]={次数=0,最大次数=60,时间=os.time() + 180}
        end
        初始活动.昆仑仙境[id].最大次数=初始活动.昆仑仙境[id].最大次数+20
        常规提示(id,"你的昆仑仙境今日修行次数增加了20次，当前剩余"..初始活动.昆仑仙境[id].最大次数.."次")
        道具使用=true
    elseif self.数据[道具id].名称 == "摇钱树苗" then
        if 玩家数据[id].角色:取任务(505)~=0 then
            常规提示(id,"#Y/你之前已经种下一棵摇钱树苗了")
            return
        elseif 地图处理类.遇怪地图[玩家数据[id].角色.地图数据.编号]==nil then
            常规提示(id,"#Y/本场景无法种植树苗")
            return
        elseif 玩家数据[id].队伍~=0 then
            常规提示(id,"队伍中无法进行此任务。")
            return
        else
            设置任务505(id)
            常规提示(id,"#Y/你种下了一颗摇钱树")
            道具使用=true
        end
    -- elseif self.数据[道具id].名称 == "三千年蟠桃" then
    --  活动掉落(id,1047)
    --  道具使用=true
    -- elseif self.数据[道具id].名称 == "六千年蟠桃" then
    --  活动掉落(id,1048)
    --  道具使用=true
    -- elseif self.数据[道具id].名称 == "九千年蟠桃" then
    --  活动掉落(id,1049)
    --  道具使用=true
    end
    if 道具使用 then
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
        发送数据(连接id,3699)
    else
        if 道具提示 then
            常规提示(id,"您无法使用这样的道具")
        end
    end

end

function 道具处理类:生成随机BB装备(id,名称,编号)
    local 附加概率 = 40--20
    local 类型序列 = 取随机数(24,26)
    local 等级 = 65
    if 名称 == "BB装备75级礼包" then
        等级 = 75
    elseif 名称 == "BB装备85级礼包" then
        等级 = 85
    elseif 名称 == "BB装备95级礼包" then
        等级 = 95
    elseif 名称 == "BB装备105级礼包" then
        等级 = 105
    elseif 名称 == "BB装备115级礼包" then
        等级 = 115
    elseif 名称 == "BB装备125级礼包" then
        等级 = 125
    elseif 名称 == "BB装备135级礼包" then
        等级 = 135
    elseif 名称 == "BB装备145级礼包" then
        等级 = 145
    elseif 名称 == "BB装备155级礼包" then
        等级 = 155
    end
    local 临时序列=math.floor(等级/10)
    local 临时名称=装备处理类.打造物品[类型序列][临时序列]
    local 道具 = 物品类()
    道具:置对象(临时名称) --以后置对象都要注意
    道具.等级 = 等级
    道具.召唤兽装备 = true
    local 灵气=取随机数(1,100)*0.15
    local 等级=等级
    local 等差序列 = math.floor(等级/10)
    if 类型序列==24 then
        道具.命中=math.floor(取随机数(5,等级*0.1+10))
    elseif 类型序列==25 then
        道具.速度=math.floor(取随机数(等差序列,等差序列*3+灵气))
    else
        道具.防御=math.floor(取随机数(等差序列*5,等差序列*9+灵气))
    end
    local 附加范围={"伤害","灵力","敏捷","耐力","体质","力量","魔力","气血","魔法"}
    for n=1,3 do
        if 取随机数()<=附加概率 then
            local 类型=附加范围[取随机数(1,#附加范围)]
            if 道具[类型]==nil then
                if 类型=="伤害" then
                    道具[类型]=math.floor(取随机数(等差序列,等差序列*5+灵气))
                    if 取随机数()<=10 then
                        道具[类型]=-取随机数(1,15)
                    end
                elseif 类型=="气血" then
                    道具[类型]=math.floor(取随机数(等差序列*4,等差序列*8+灵气))
                    if 取随机数()<=10 then
                        道具[类型]=-取随机数(1,100)
                    end
                elseif 类型=="魔法" then
                    道具[类型]=math.floor(取随机数(等差序列*7,等差序列*12+灵气))
                    if 取随机数()<=10 then
                        道具[类型]=-取随机数(1,100)
                    end
                elseif 类型=="力量" then
                    道具[类型]=math.floor(取随机数(等差序列,等差序列*3))
                    if 取随机数()<=10 then
                        道具[类型]=-取随机数(1,15)
                    end
                elseif 类型=="敏捷" or 类型=="体质" or 类型=="耐力" or 类型=="魔力" or 类型=="灵力" then
                    道具[类型]=math.floor(取随机数(等差序列,等差序列*2))
                    if 取随机数()<=10 then
                        道具[类型]=-取随机数(1,15)
                    end
                end
            end
        end
    end
    local 道具格子 = self:取新编号()
    玩家数据[id].角色.道具[编号] = 道具格子
    玩家数据[id].道具.数据[道具格子]=道具

    道具刷新(id)
end

function 道具处理类:自选道具(连接id,id,内容) --__自选
    local 道具名称=内容.道具名称
    local 选中名称=内容.名称

    if 道具名称=="150书铁礼包" then
        local zilei=0
        for i=1,#书铁范围 do
            if 选中名称==书铁范围[i] then
                zilei=i
                break
            end
        end
        if  zilei~=0 then
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
                玩家数据[id].道具:给予道具(id,"制造指南书",150,zilei,nil,专用)
                玩家数据[id].道具:给予道具(id,"百炼精铁",150,zilei,nil,专用)
            end
        end
    elseif 道具名称=="160自选礼包" then
        local 类型="武器"
        local 男女="男"
        if 内容.选中>18 and  内容.选中<=20  then
            类型="头盔"
            if 内容.选中==20 then
                男女="女"
            end
        elseif  内容.选中>20 and  内容.选中<=21  then
            类型="项链"
        elseif  内容.选中>21 and  内容.选中<=23  then
            if 内容.选中==22 then
                男女="女"
            end
            类型="衣服"
        elseif  内容.选中>23 and  内容.选中<=24  then
            类型="腰带"
        elseif  内容.选中>24 and  内容.选中<=25  then
            类型="鞋子"
        end
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
        礼包奖励类:顶级属性装备(id,160,"无级别限制",类型,选中名称,内容.选中,男女)
            end
    elseif 道具名称=="自选特殊兽决" then
        local ms  ={"惊心一剑","龙魂","八凶法阵","欣欣向荣","出其不意","流沙轻音","食指大动","从天而降","大快朵颐","苍鸾怒击","浮云神马","千钧一怒","势如破竹","乘胜追击","凭风借力",
              "顾盼生姿","拘魂索命","溜之大吉","神出鬼没","昼伏夜出","凝光炼彩","净台妙谛","津津有味","灵山禅语","力劈华山","善恶有报","法术防御","月光","死亡召唤","移花接木",
              "灵能激发","夜舞倾城","上古灵符","天降灵葫","无上正真","理直气壮","虎虎生风","叱咤风云","神来气旺","风起龙游","柳暗花明","风之沙盾","清风之华","雨露之泽","映雪棱镜","克敌五行",
              "气贯长虹","义薄云天","无畏布施","剑荡四方","壁垒击破","与生俱来","须弥真言","万物之灵（火）","万物之灵（木）","万物之灵（金）","万物之灵（土）","力大无穷（金）","力大无穷（木）","力大无穷（水）","力大无穷（火）","力大无穷（土）"}
        local jn=0
        for i=1,#ms do
            if 选中名称==ms[i] then
                jn=i
                break
            end
        end
        if  zilei~=0 then
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
                玩家数据[id].道具:给予道具(id,"特殊魔兽要诀",nil,选中名称,"不存共享")
            end
        end

    elseif 道具名称=="自选超级兽决" then
          local ms = {"超级必杀","超级毒","超级盾气","超级法术暴击","超级法术波动","超级法术抵抗","超级法术连击","超级反击","超级反震","超级防御","超级飞行",
    "超级感知","超级合纵","超级慧根","超级火属性吸收","超级进击必杀","超级进击法暴","超级精神集中","超级雷属性吸收","超级连击","超级敏捷",
    "超级冥思","超级魔之心","超级强力","超级驱鬼","超级神迹","超级水属性吸收","超级偷袭","超级土属性吸收","超级吸血","超级幸运","超级夜战","超级遗志",
    "超级隐身","超级永恒","超级再生","超级招架","超级奔雷咒","超级壁垒击破","超级地狱烈火","超级水漫金山","超级泰山压顶"}
        local jn=0
        for i=1,#ms do
            if 选中名称==ms[i] then
                jn=i
                break
            end
        end
        if  zilei~=0 then
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
                玩家数据[id].道具:给予道具(id,"超级魔兽要诀",nil,选中名称,"不存共享")
            end
        end

         elseif 道具名称=="自选钟灵石" then
         local ms = {"163","心源","自我陶醉","健步如飞","血气方刚","回春之术","锐不可当"}
        local jn=0
        for i=1,#ms do
            if 选中名称==ms[i] then
                jn=i
                break
            end
        end
        if  zilei~=0 then
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
                玩家数据[id].道具:给予道具(id,"钟灵石",10,选中名称,"不存共享")
            end
        end

             elseif 道具名称=="特殊超级技能" then
        local ms = {"超级力劈华山","超级善恶有报"}
        local jn=0
        for i=1,#ms do
            if 选中名称==ms[i] then
                jn=i
                break
            end
        end
        if  zilei~=0 then
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
                玩家数据[id].道具:给予道具(id,"高级魔兽要诀",nil,选中名称,"不存共享")
            end
        end







    elseif 道具名称=="高级宝石礼包" then
        local 宝石 = {"红玛瑙","太阳石","舍利子","黑宝石","月亮石","光芒石"}
        local oodf=false
        for i=1,#宝石 do
            if 宝石[i]==选中名称 then
                oodf=true
                break
            end
        end
        if  oodf then
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
                for i=10,15 do
                    玩家数据[id].道具:给予道具(id,选中名称,i,nil,"不存共享")
                end
            end
        end
    elseif 道具名称=="珍兽元" then
        if not 玩家数据[id].角色:取新增宝宝数量() then
            常规提示(id, "#Y您当前无法携带更多的召唤兽了")
            return false
        end
        local 附加={"大力金刚","广目巡守","龙鲤","律法女娲","涂山雪","持国巡守","曼珠沙华","龙龟","增长巡守","般若天女","自在心猿","雷龙","毗舍童子","执音","幽灵","狂豹人形","妙华天女"}
        local jn=0
        for i=1,#附加 do
            if 选中名称==附加[i] then
                jn=i
                break
            end
        end
        if  jn~=0 then
            if 玩家数据[id].道具:消耗背包道具(连接id,id,道具名称,1) then
                local  mx=选中名称
                玩家数据[id].召唤兽:添加召唤兽(mx, mx, "宝宝", 属性, 0, 染色方案, 技能, 资质组, 成长, 0, 属性表)
                常规提示(id, "#Y你获得了一只"..mx)
            end
        end
    end

end

function 道具处理类:升级强化技能(id,技能)
  if 玩家数据[id].角色.强化技能 ==nil then
    return false
  end
  local 技能编号 = 0
  for i=1,#玩家数据[id].角色.强化技能 do
    if 玩家数据[id].角色.强化技能[i].名称 == 技能 then
       技能编号 = i
    end
  end

  if 技能编号~= 0 then
     if 玩家数据[id].角色.强化技能[技能编号].等级>=玩家数据[id].角色.等级 then
        玩家数据[id].角色.强化技能[技能编号].等级=玩家数据[id].角色.等级
        常规提示(id,"技能已达到上限")
        return false
    end
    玩家数据[id].角色.强化技能[技能编号].等级= 玩家数据[id].角色.强化技能[技能编号].等级+1
    -- 发送数据(玩家数据[id].连接id,34.1,{序列=技能编号,等级=玩家数据[id].角色.强化技能[技能编号].等级})
    玩家数据[id].角色:刷新信息()
    发送数据(玩家数据[id].连接id,31,玩家数据[id].角色:取总数据())
     常规提示(id,"#Y/你的#R/"..玩家数据[id].角色.强化技能[技能编号].名称.."#Y/提升了一级")
    return true
  else
      常规提示(id,"你没有这样的技能")
      return false
  end
end

function 道具处理类:清灵仙露处理(连接id,id,加血对象,道具id)
    if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 > 100 then
        常规提示(id,"该召唤兽已无法再使用清灵仙露")
        return false
    elseif 玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露 >= 7 then
        常规提示(id,"该召唤兽已使用7瓶清灵仙露！无法再继续服用了")
        return false
    elseif self.数据[道具id].名称 ~= "特殊清灵仙露" and self.数据[道具id].灵气 == nil then
        常规提示(id,"道具灵气异常，请联系管理员")
        return false
    elseif 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 < 50 then
        常规提示(id,"召唤兽灵性必须达到50以上才能使用清灵仙露！")
        return false
    end
    local 临时灵性 =1
    if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 >= 50 and self.数据[道具id].名称 ~= "特殊清灵仙露" then
        if self.数据[道具id].灵气 == 8 then
            if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 >=100 then
                临时灵性 = 取随机数(9,10)
            else
                临时灵性 = 取随机数(8,10)
            end
        else
            local jil = 25
            if self.数据[道具id].名称 == "中级清灵仙露" then
                jil = 45
            elseif self.数据[道具id].名称 == "高级清灵仙露" then
                jil = 60
            end
            if 取随机数()<jil then
                临时灵性 = 取随机数(self.数据[道具id].灵气+1,self.数据[道具id].灵气+2)
            else
                临时灵性 = self.数据[道具id].灵气
            end
        end
    end
    if self.数据[道具id].名称=="特殊清灵仙露" then
        玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力 + (110-玩家数据[id].召唤兽.数据[加血对象].进阶.灵性)*2
        玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 = 110
    else
        玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力 + 临时灵性*2
        玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 = 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 + 临时灵性
        玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露 = 玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露 + 1
        常规提示(id,玩家数据[id].召唤兽.数据[加血对象].名称.."服用了一个清灵仙露后，神清气爽，仙气缭绕，灵性增加了#R"..临时灵性.."#Y点！（还可以食用#R"..(7-玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露).."#Y个清灵仙露）") --
    end
    if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 == 110 then
        玩家数据[id].召唤兽.数据[加血对象].临时进阶 = {
            力量 = 0,
            敏捷 = 0,
            耐力 = 0,
            魔力 = 0,
            体质 = 0,
        }
        发送数据(连接id,105,{头像="进阶",标题="灵兽现世",说明="获得一只灵性为110的召唤兽！"})
        常规提示(id,"你的召唤兽#R"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y发生了一些变化，快去找御兽仙（仙缘洞天,151,59）问看看吧？")
    end
    玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
    发送数据(连接id,16,玩家数据[id].召唤兽.数据)
    发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
    return true
end

function 道具处理类:宝宝进阶(连接id,id,内容)
    if 玩家数据[id].角色.参战信息==nil then
        常规提示(id,"#Y/请将需要进阶的宝宝参战！")
        return
    end
    local 最低灵气 = {}
    if 玩家数据[id].角色.参战宝宝.进阶 and 玩家数据[id].角色.参战宝宝.进阶.灵性==110 then
        local gz = 内容.位置
        -- local go = true
        for i=1,5 do
            if gz[i]==nil then
                常规提示(id,"#Y/物品数据异常！")
                return
            end
            local 道具id=玩家数据[id].角色["道具"][gz[i]]
            if self.数据[道具id] == nil then
                常规提示(id,"#Y/物品数据异常！")
                return
            elseif self.数据[道具id].名称~="初级清灵仙露" and self.数据[道具id].名称~="中级清灵仙露" and self.数据[道具id].名称~="高级清灵仙露" and self.数据[道具id].名称~="特殊清灵仙露" then
                常规提示(id,"#Y/物品数据异常！")
                return
            end
            最低灵气[i]=self.数据[道具id].灵气
            if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
                self.数据[道具id].数量 = self.数据[道具id].数量 -1
            else
                self.数据[道具id]=nil
                玩家数据[id].角色["道具"][gz[i]]=nil
            end
        end
        table.sort(最低灵气, function(a, b) return a < b end)
        local bbbh=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)
        if 满值白名单账号[玩家数据[id].账号] then --ponytail: 白名单账号取满值，别的账号别碰
            local 满值 = 最低灵气[5]*3
            玩家数据[id].召唤兽.数据[bbbh].临时进阶 = {
                力量 = 满值,
                敏捷 = 满值,
                耐力 = 满值,
                魔力 = 满值,
                体质 = 满值,
            }
        else
            玩家数据[id].召唤兽.数据[bbbh].临时进阶 = {
                力量 = 取随机数(最低灵气[1],最低灵气[5]*3),
                敏捷 = 取随机数(最低灵气[1],最低灵气[5]*3),
                耐力 = 取随机数(最低灵气[1],最低灵气[5]*3),
                魔力 = 取随机数(最低灵气[1],最低灵气[5]*3),
                体质 = 取随机数(最低灵气[1],最低灵气[5]*3),
            }
        end
        常规提示(id,"#Y/清灵仙露的灵气已经环绕在召唤兽周围，请选择希望#R保留哪个属性#Y。")
        玩家数据[id].召唤兽.数据[bbbh]:刷新信息()
        发送数据(连接id,3699)
        发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
        发送数据(连接id,110,{宝宝=玩家数据[id].召唤兽.数据[bbbh]})

    else
        常规提示(id,"#Y/提升召唤兽能力需灵性达到110")
        return
    end
end

function 道具处理类:使用合成旗(连接id,id,序列)
    --     玩家数据[id].最后操作="合成旗"
    if 玩家数据[id].道具操作==nil then return  end
    local 编号=玩家数据[id].道具操作.编号
    local 道具id=玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].总类~=11 or self.数据[道具id].分类~=2 then
        常规提示(id,"#Y你没有这样的道具")
        return
    end
    if self.数据[道具id].xy[序列]==nil then
        常规提示(id,"#Y错误的坐标选择点")
        return
    end
    if self.数据[道具id].xy[序列].x==nil then
        常规提示(id,"#Y错误的坐标选择点")
        return
    end
    if self.数据[道具id].xy[序列].y==nil then
        常规提示(id,"#Y错误的坐标选择点")
        return
    end
    if self:取飞行限制(id) then
        return
    end
    self.数据[道具id].次数=self.数据[道具id].次数-1
    地图处理类:跳转地图(id,self.数据[道具id].地图,self.数据[道具id].xy[序列].x,self.数据[道具id].xy[序列].y)
    if self.数据[道具id].次数<=0 then
        玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]=nil
        self.数据[道具id]=nil
    else
        常规提示(id,format("#Y你的%s还可以使用%s次",self.数据[道具id].名称,self.数据[道具id].次数))
    end
    玩家数据[id].道具操作=nil
    道具刷新(id)
end

function 道具处理类:窗口道具使用处理(id,内容)
  local 道具格子=内容.格子
  local 选中编号=内容.编号
  local 道具id=玩家数据[id].角色.道具[道具格子]

 -- table.print(内容)
  local 是否使用=false
  local 删除数量=1
     if 道具id==0 or 道具格子==0 then
           常规提示(id,"#Y/请选中一个道具")
        return
     end
     if 选中编号==nil or 选中编号==0 then
      return
     end
     if self.数据[玩家数据[id].角色.道具[选中编号]]==nil then
      return
     end
     local 名称=self.数据[道具id].名称
     local 取可使用=function(zb,bs)
        if (zb == 1 or zb == 2 or zb == 3 or zb == 4 or zb == 5 or zb == 6)  and bs =="装备强化石" then
          return true
        -- elseif zb == 2 and bs == "项链强化卡" then
        --   return true
        -- elseif zb == 3 and bs == "装备强化石" then
        --   return true
        -- elseif zb == 4 and bs =="衣服强化卡" then
        --   return true
        -- elseif zb == 5 and bs == "腰带强化卡" then
        --   return true
        -- elseif zb == 6 and bs =="鞋子强化卡" then
        --   return true
        -- else
        --   return false
        end
     end
     if  名称=="装备强化石"   then
        if 取可使用(self.数据[玩家数据[id].角色.道具[选中编号]].分类,名称) then
           local 装备编号=玩家数据[id].角色.道具[选中编号]
          if self.数据[装备编号].强化次数==nil then
             self.数据[装备编号].强化次数=0
          end
   --         if self.数据[装备编号].级别限制 < 160 then
   --           常规提示(id, "#R/小于160级的装备不能强化哦")
      --     return 0
      -- end
          --   if self.数据[装备编号].阶数>= 10  then
          --    常规提示(id, "#R/小于10阶的装备不能强化哦")
          --   return
          -- end
          if self.数据[装备编号].强化次数>=20 then
            常规提示(id,"#Y/已经无法升级!")
            return
          end
            删除数量=(self.数据[装备编号].强化次数+1)*3
           if self.数据[道具id].数量==nil or self.数据[道具id].数量<删除数量 then
            常规提示(id,"#Y/本次强化需要消耗 #G/"..删除数量.." #Y/装备强化石!")
            return
          end
          if self.数据[装备编号].原始==nil then
             self.数据[装备编号].原始={}
          end
          local 属性 = {"命中","伤害","灵力","魔法","躲避","防御","气血","速度","体质","魔力","力量","耐力","敏捷"}
          local 公告列表={物品=self.数据[装备编号],加成={}}
          for k,v in pairs(属性) do
              if self.数据[装备编号][v]~=nil then
                if self.数据[装备编号].原始[v]==nil then
                  self.数据[装备编号].原始[v]=math.ceil(self.数据[装备编号][v]/20)
                end
                self.数据[装备编号][v]=self.数据[装备编号][v]+self.数据[装备编号].原始[v]
                公告列表.加成[#公告列表.加成+1]={类型=v,数值=self.数据[装备编号].原始[v]}
                常规提示(id,"#Y/强化提升了"..v.."+"..self.数据[装备编号].原始[v])
              end
          end
          self.数据[装备编号].强化次数=self.数据[装备编号].强化次数+1
          if self.数据[装备编号].强化次数==10 or self.数据[装备编号].强化次数==20 or self.数据[装备编号].强化次数==30 or self.数据[装备编号].强化次数==50 or self.数据[装备编号].强化次数==80 or self.数据[装备编号].强化次数==100 then
            -- self.数据[装备编号].完美度=self.数据[装备编号].完美度+500
            公告列表.加成[#公告列表.加成+1]={类型="评分",数值=500}
          else
              -- self.数据[装备编号].完美度=self.数据[装备编号].完美度+50
              公告列表.加成[#公告列表.加成+1]={类型="评分",数值=50}
          end
          公告列表.加成[#公告列表.加成+1]={类型="强化",数值=self.数据[装备编号].强化次数}
          --弹窗提示(id,公告列表)
          是否使用=true

        else
           常规提示(id,"#Y/该强化石无法强化这种类型的装备!")
        end
     elseif 名称=="红玛瑙" or 名称=="太阳石" or 名称=="舍利子" or 名称=="黑宝石" or 名称=="月亮石" or 名称=="光芒石" or 名称=="神秘石" then
            local keyixiangqian=function(zb,bs)
              if zb == 1 and (bs == "月亮石" or bs == "太阳石" or bs=="红玛瑙") then
                return true
              elseif zb == 2 and bs == "舍利子" then
                return true
              elseif zb == 3 and (bs == "太阳石" or bs == "红玛瑙" or bs == "神秘石") then
                return true
              elseif zb == 4 and (bs == "光芒石" or bs == "月亮石" or bs == "舍利子") then
                return true
              elseif zb == 5 and (bs == "光芒石" or bs == "黑宝石" or bs == "神秘石") then
                return true
              elseif zb == 6 and (bs == "黑宝石" or bs == "神秘石") then
                return true
              end
              return false
            end
            local 装备编号=玩家数据[id].角色.道具[选中编号]
     if keyixiangqian(self.数据[装备编号].分类,self.数据[道具id].名称) then
        local 锻造级别=0
        if self.数据[装备编号].锻炼等级~=nil then
          锻造级别=self.数据[装备编号].锻炼等级
        end
        锻造级别=锻造级别+1


        if 锻造级别>=100 then
          常规提示(id,"宝石最高镶嵌为100级")
          return
        end
        if self.数据[装备编号].镶嵌宝石==nil then
           self.数据[装备编号].镶嵌宝石={}
           self.数据[装备编号].镶嵌类型={}
           self.数据[装备编号].宝石属性={}
        end
        删除数量=((锻造级别-1)^3)
        if 删除数量<=0 then  删除数量=1  end
       -- print(删除数量)
        if self.数据[道具id].数量==nil or self.数据[道具id].数量<删除数量 then
            常规提示(id,"#Y/本次镶嵌需要消耗 #G/"..删除数量.." #Y/宝石!")
            return
         end
      if self.数据[装备编号].镶嵌宝石[1]==nil then
        self.数据[装备编号].镶嵌宝石[1]=self.数据[道具id].名称
      elseif self.数据[装备编号].镶嵌宝石[2]==nil and self.数据[装备编号].镶嵌宝石[1]~=self.数据[道具id].名称  then
        self.数据[装备编号].镶嵌宝石[2]=self.数据[道具id].名称
      elseif self.数据[装备编号].镶嵌宝石[1]~=self.数据[道具id].名称  and self.数据[装备编号].镶嵌宝石[2]~=self.数据[道具id].名称 then
        常规提示(id,"装备最多只能镶嵌两种不同类型的宝石")
        return
      end
      local 公告列表={物品=self.数据[装备编号],加成={}}
       self.数据[装备编号].锻炼等级=锻造级别
       self.数据[装备编号].镶嵌类型[锻造级别]=self.数据[道具id].名称
      if self.数据[道具id].名称 == "光芒石" then
        self.数据[装备编号].宝石属性.气血 = (self.数据[装备编号].宝石属性.气血 or 0) - floor(40*(锻造级别-1))
        self.数据[装备编号].宝石属性.气血 = (self.数据[装备编号].宝石属性.气血 or 0) + floor(40*锻造级别)
        公告列表.加成[#公告列表.加成+1]={类型="气血",数值=40}
      elseif self.数据[道具id].名称 == "月亮石" then
        self.数据[装备编号].宝石属性.防御 = (self.数据[装备编号].宝石属性.防御 or 0) - floor(12*(锻造级别-1))
        self.数据[装备编号].宝石属性.防御 = (self.数据[装备编号].宝石属性.防御 or 0) + floor(12*锻造级别)
        公告列表.加成[#公告列表.加成+1]={类型="防御",数值=12}
      elseif self.数据[道具id].名称 == "太阳石" then
        self.数据[装备编号].宝石属性.伤害 = (self.数据[装备编号].宝石属性.伤害 or 0) - floor(8*(锻造级别-1))
        self.数据[装备编号].宝石属性.伤害 = (self.数据[装备编号].宝石属性.伤害 or 0) + floor(8*锻造级别)
        公告列表.加成[#公告列表.加成+1]={类型="伤害",数值=8}
      elseif self.数据[道具id].名称 == "舍利子" then
        self.数据[装备编号].宝石属性.灵力 = (self.数据[装备编号].宝石属性.灵力 or 0) - floor(6*(锻造级别-1))
        self.数据[装备编号].宝石属性.灵力 = (self.数据[装备编号].宝石属性.灵力 or 0) + floor(6*锻造级别)
        公告列表.加成[#公告列表.加成+1]={类型="灵力",数值=6}
      elseif self.数据[道具id].名称 == "红玛瑙" then
        self.数据[装备编号].宝石属性.命中 = (self.数据[装备编号].宝石属性.命中 or 0) - floor(25*(锻造级别-1))
        self.数据[装备编号].宝石属性.命中 = (self.数据[装备编号].宝石属性.命中 or 0) + floor(25*锻造级别)
        公告列表.加成[#公告列表.加成+1]={类型="命中",数值=25}
      elseif self.数据[道具id].名称 == "黑宝石" then
        self.数据[装备编号].宝石属性.速度 = (self.数据[装备编号].宝石属性.速度 or 0) - floor(8*(锻造级别-1))
        self.数据[装备编号].宝石属性.速度 = (self.数据[装备编号].宝石属性.速度 or 0) + floor(8*锻造级别)
        公告列表.加成[#公告列表.加成+1]={类型="速度",数值=8}
      elseif self.数据[道具id].名称 == "神秘石" then
        self.数据[装备编号].宝石属性.躲避 = (self.数据[装备编号].宝石属性.躲避 or 0) - floor(20*(锻造级别-1))
        self.数据[装备编号].宝石属性.躲避 = (self.数据[装备编号].宝石属性.躲避 or 0) + floor(20*锻造级别)
        公告列表.加成[#公告列表.加成+1]={类型="躲避",数值=20}
      end
      公告列表.加成[#公告列表.加成+1]={类型="评分",数值=10}
      公告列表.加成[#公告列表.加成+1]={类型="锻造",数值=锻造级别}
      self.数据[装备编号].完美度=self.数据[装备编号].完美度+10
      --弹窗提示(id,公告列表)
      是否使用=true
     -- 常规提示(id,"镶嵌装备成功")
      道具刷新(id)
    end
     elseif 名称=="星源之石"  then
       local 装备编号=玩家数据[id].角色.道具[选中编号]
        if (self.数据[装备编号].分类~=nil and self.数据[装备编号].分类>=1 and self.数据[装备编号].分类<=6) or self.数据[装备编号].灵饰 then
            if self.数据[装备编号].卡槽==nil then
               self.数据[装备编号].卡槽={数量=0,总数量=0,属性={}}
            end
             if self.数据[装备编号].级别限制 < 160 then
        常规提示(id, "#R/小于160的装备不能用哦")
      return 0
  end
             删除数量=(self.数据[装备编号].卡槽.总数量+1)*self.数据[装备编号].级别限制*1
            local 总数量=math.floor(self.数据[装备编号].级别限制/40)
            if self.数据[装备编号].卡槽.总数量>=总数量 then
              常规提示(id,"当前等级的装备只能开启"..总数量)
              return
            end
            if 删除数量<=0 then  删除数量=1  end
            if self.数据[道具id].数量==nil or self.数据[道具id].数量<删除数量 then
                常规提示(id,"#Y/本次需要消耗 "..删除数量.." 个星源之石!")
                return
             end
             local 公告列表={物品=self.数据[装备编号],加成={}}
             公告列表.加成[#公告列表.加成+1]={类型="卡槽",数值=1}
             公告列表.加成[#公告列表.加成+1]={类型="剩余",数值=总数量-self.数据[装备编号].卡槽.总数量-1}
             self.数据[装备编号].卡槽.总数量=self.数据[装备编号].卡槽.总数量+1
             --弹窗提示(id,公告列表)
            是否使用=true
            常规提示(id,"开启成功")
            道具刷新(id)
      end
    elseif 名称=="天命宝石"  then
      local 装备编号=玩家数据[id].角色.道具[选中编号]
      local 属性={"伤害","气血"}
        if (self.数据[装备编号].分类~=nil and self.数据[装备编号].分类>=1 and self.数据[装备编号].分类<=6) or self.数据[装备编号].灵饰 then
            if self.数据[装备编号].卡槽==nil then
                常规提示(id,"该装备没有多余星盘,需要使用星源之石开启星盘。")
               return
            end
            if self.数据[装备编号].卡槽.数量>=self.数据[装备编号].卡槽.总数量 then
              常规提示(id,"当前等级的装备只能开启"..self.数据[装备编号].卡槽.总数量)
              return
            end
            -- local 新编号=#self.数据[装备编号].卡槽.属性+1
            -- self.数据[装备编号].卡槽.属性[新编号]={}
            -- self.数据[装备编号].卡槽.属性[新编号].类型=self.数据[道具id].属性.类型
            -- self.数据[装备编号].卡槽.属性[新编号].数值=self.数据[道具id].属性.数值
            -- self.数据[装备编号].卡槽.数量=新编号
            -- local 公告列表={物品=self.数据[装备编号],加成={}}
            -- 公告列表.加成[#公告列表.加成+1]={类型=self.数据[道具id].属性.类型,数值=self.数据[道具id].属性.数值.."%"}
            是否使用=true
            道具刷新(id)
        end
     end
     if 是否使用 then
        if self.数据[道具id].数量==nil then
           self.数据[道具id]=nil
           玩家数据[id].角色.道具[道具格子]=nil
        else
          self.数据[道具id].数量=self.数据[道具id].数量-删除数量
          if self.数据[道具id].数量<=0 then
            self.数据[道具id]=nil
            玩家数据[id].角色.道具[道具格子]=nil
          end
        end
      else
        常规提示(id,"无法这样操作")
     end
     道具刷新(id)
end

function 道具处理类:检查指定道具是否存在(id, 名称, 数量)
    for n = 1, 20 do
        if 玩家数据[id]["角色"]["道具"][n] ~= nil and self["数据"][玩家数据[id]["角色"]["道具"][n]] ~= nil and self["数据"][玩家数据[id]["角色"]["道具"][n]]["名称"] == 名称 then
            if self["数据"][玩家数据[id]["角色"]["道具"][n]]["数量"] ~= nil then
                if 数量 <= self["数据"][玩家数据[id]["角色"]["道具"][n]]["数量"] then
                    return true
                end
            else
                return true
            end
        end
    end

    return false
end


function 道具处理类:使用法宝(连接id,id,编号)
    local 道具id=玩家数据[id].角色.法宝[编号]
    if 道具id==nil or self.数据[道具id]==nil then
        常规提示(id,"#Y你没有这件法宝")
        self:索要法宝(连接id,id)
        return
    end
    local 名称=self.数据[道具id].名称
    if 名称=="五色旗盒" then
        if self.数据[道具id].魔法<=0 then
            常规提示(id,"#Y你的法宝灵气不足")
            return
        elseif 玩家数据[id].角色.等级<60 then
            常规提示(id,"#Y你的等级不足以使用此法宝")
            return
        end
        local aa ="请选择你要进行的操作："
        local xx={"合成导标旗","补充合成旗"}
        发送数据(连接id,1501,{名称="五色旗盒",对话=aa,选项=xx})
        玩家数据[id].最后操作="合成旗1"
        玩家数据[id].法宝id=编号
        return
    elseif 名称=="月光宝盒" then --
        if self.数据[道具id].魔法<5 then
            常规提示(id,"#Y你的法宝灵气不足")
            return
        elseif 玩家数据[id].角色.等级<100 then --测试
            常规提示(id,"#Y你的等级不足以使用此法宝")
            return
        end
        local aa ="请选择你要进行的操作："
        local xx={"送我过去","在这里定标"}
        发送数据(连接id,1501,{名称="月光宝盒",对话=aa,选项=xx})
        玩家数据[id].最后操作="月光宝盒"
        玩家数据[id].法宝id=编号
        return
    elseif 名称=="影蛊" then
        if self.数据[道具id].魔法<5 then
            常规提示(id,"#Y你的法宝灵气不足")
            return
        elseif 玩家数据[id].角色.等级<100 then --测试
            常规提示(id,"#Y你的等级不足以使用此法宝")
            return
        end
        发送数据(连接id,63,{名称="影蛊"})
        玩家数据[id].最后操作="影蛊"
        玩家数据[id].法宝id=编号
        return
    end
    常规提示(id,"#Y鼠标左键抓取，方可替换或使用此法宝")
    return
end

function 道具处理类:替换法宝(连接id,id,编号,位置)
    if 编号=="神器" then
        if 玩家数据[id].角色.法宝佩戴[位置] and self.数据[玩家数据[id].角色.法宝佩戴[位置]] then
            if not self:卸下法宝(连接id,id,位置) then
                return
            end
        end
        玩家数据[id].神器:佩戴神器(连接id,id,位置)
        return
    else
        if 玩家数据[id].神器.数据.是否佩戴神器 and 玩家数据[id].神器.数据.格子==位置 then
            玩家数据[id].神器:卸下神器(连接id,id)
        end
    end
    local 道具id=玩家数据[id].角色.法宝[编号]
    if 道具id==nil or self.数据[道具id]==nil then
        常规提示(id,"#Y你没有这件法宝")
        self:索要法宝(连接id,id)
        return
    end
    if 玩家数据[id].角色.等级 < tonumber(self.数据[道具id].特技) then
        常规提示(id,"#Y你当前的等级无法佩戴此类型的法宝")
        return
    end
    if 取法宝门派(self.数据[道具id].名称) ~= "无门派" and 玩家数据[id].角色.门派 ~= 取法宝门派(self.数据[道具id].名称) then --测试
        常规提示(id,"#Y你无法佩戴这个门派的法宝")
        self:索要法宝(连接id,id)
        return
    end
    if 位置 and 位置==4 and  玩家数据[id].角色.等级 <120 then
        常规提示(id,"#Y120级才可以佩戴第4个法宝")
        return
    end
    if self.数据[道具id].分类 == 4 and  玩家数据[id].角色.等级 <120 then return 常规提示(id,"#Y120级才可以佩戴第4个法宝") end
    -- 使用 = 道具[5] --需要佩戴才可在战斗中发挥效用
    -- 特技 = 道具[6] --【等级限制】：
    local 类型判定 = 0
    local 佩戴判定 = 0
    local 同类型=0
    for n = 1,4 do
        local 已佩戴=玩家数据[id].角色.法宝佩戴[n]
        if 玩家数据[id].角色.法宝佩戴[n] and self.数据[已佩戴] then
            if self.数据[已佩戴].子类 == self.数据[道具id].子类 then
                同类型=同类型+1
                if 同类型>=2 then
                    常规提示(id,"#Y相同类型的法宝佩戴不能超过2个")
                    self:索要法宝(连接id,id)
                    return
                end
            end
            if self.数据[已佩戴].分类==4 then --4级法宝
                佩戴判定 = 佩戴判定 +1
            end
        end
    end
    if self.数据[道具id].分类 == 4 then
        if 佩戴判定 == 1 then
            if 玩家数据[id].角色.历劫.化圣 == false then
                if 玩家数据[id].角色.法宝佩戴[位置] == nil then
                    self:索要法宝(连接id,id)
                    return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
                elseif 玩家数据[id].角色.法宝佩戴[位置] ~= nil and self.数据[玩家数据[id].角色.法宝佩戴[位置]].分类~=4  then
                    self:索要法宝(连接id,id)
                    return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
                end
            elseif 玩家数据[id].角色.历劫.化圣 and 玩家数据[id].角色.历劫.化圣境界 ~= nil and 玩家数据[id].角色.历劫.化圣境界 < 3 then
                if 玩家数据[id].角色.法宝佩戴[位置] == nil then
                    self:索要法宝(连接id,id)
                    return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
                elseif 玩家数据[id].角色.法宝佩戴[位置] ~= nil and self.数据[玩家数据[id].角色.法宝佩戴[位置]].分类~=4  then
                    self:索要法宝(连接id,id)
                    return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
                end
            end
        elseif 佩戴判定 == 2 then
            if 玩家数据[id].角色.历劫.化圣 and 玩家数据[id].角色.历劫.化圣境界 ~= nil and 玩家数据[id].角色.历劫.化圣境界 < 3 then
                self:索要法宝(连接id,id)
                return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
            elseif 玩家数据[id].角色.历劫.化圣 and 玩家数据[id].角色.历劫.化圣境界 ~= nil and 玩家数据[id].角色.历劫.化圣境界 >= 3 then
                if 玩家数据[id].角色.法宝佩戴[位置] == nil then
                    self:索要法宝(连接id,id)
                    return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
                elseif 玩家数据[id].角色.法宝佩戴[位置] ~= nil and self.数据[玩家数据[id].角色.法宝佩戴[位置]].分类~=4  then
                    self:索要法宝(连接id,id)
                    return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
                end
            end
        end
    end
    if 玩家数据[id].角色.法宝佩戴[位置]==nil then
        玩家数据[id].角色.法宝佩戴[位置]=玩家数据[id].角色.法宝[编号]
        玩家数据[id].角色.法宝[编号]=nil
    else
        local 临时编号=玩家数据[id].角色.法宝[编号]
        玩家数据[id].角色.法宝[编号]=玩家数据[id].角色.法宝佩戴[位置]
        玩家数据[id].角色.法宝佩戴[位置]=临时编号
    end
    self:索要法宝(连接id,id)
    玩家数据[id].角色:刷新信息()
end

function 道具处理类:卸下法宝(连接id,id,编号,神器)
    if 神器 then
        玩家数据[id].神器:卸下神器(连接id,id)
        return false
    end
    local 格子=玩家数据[id].角色:取法宝格子()
    if 格子==0 then
        常规提示(id,"#Y你的法宝栏已经满了")
        return false
    end
    玩家数据[id].角色.法宝[格子]=玩家数据[id].角色.法宝佩戴[编号]
    玩家数据[id].角色.法宝佩戴[编号]=nil
    self:索要法宝(连接id,id)
    玩家数据[id].角色:刷新信息()
    return true
end

function 道具处理类:法宝补充灵气(连接id, id, 编号)
    local 道具id = 玩家数据[id].角色.法宝[编号]
    if 道具id == nil or self.数据[道具id] == nil then
        常规提示(id,"#Y你没有这件法宝")
        self:索要法宝(连接id,id)
        return
    end
    local 价格=2000000
    if self.数据[道具id].分类==2 then
        价格=3500000
    elseif self.数据[道具id].分类==3 then
        价格=6000000
    end
    if 玩家数据[id].角色.银子 < 价格 then
        常规提示(id,"本次补充法宝灵气需要消耗"..价格.."两银子，你身上没有那么多的现金哟。")
        return
    end
    玩家数据[id].角色:扣除银子(价格,0,0,"补充法宝扣除，法宝名称为"..self.数据[道具id].名称,1)
    self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
    常规提示(id,"补充法宝灵气成功！")
end

function 道具处理类:修炼法宝(连接id,id,编号)
    local 道具id=玩家数据[id].角色.法宝[编号]
    if 道具id==nil or self.数据[道具id]==nil then
        常规提示(id,"#Y你没有这件法宝")
        self:索要法宝(连接id,id)
        return
    end
    local 上限=9
    if self.数据[道具id].分类==2 then
        上限=12
    elseif self.数据[道具id].分类==3 then
        上限=15
    elseif self.数据[道具id].分类==4 then
        上限=18
    end
    if self.数据[道具id].气血==上限 then
        常规提示(id,"#Y你的这件法宝已经满层了，无法再进行修炼")
        return
    end
    local 消耗经验=math.floor(self.数据[道具id].升级经验*0.5)
    if 消耗经验>10000000 then
        消耗经验=10000000
    end
    if 玩家数据[id].角色.当前经验<消耗经验 then
        常规提示(id,"#Y本次修炼需要消耗#R"..消耗经验.."#Y点人物经验，您似乎没有那么多的经验哟")
        return
    end
    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-消耗经验
    常规提示(id,"#Y修炼成功,你消耗了#R"..消耗经验.."#Y了点人物经验")
    self.数据[道具id].当前经验=self.数据[道具id].当前经验+消耗经验
    if self.数据[道具id].当前经验>=self.数据[道具id].升级经验 then
        self.数据[道具id].气血=self.数据[道具id].气血+1
        self.数据[道具id].当前经验=self.数据[道具id].当前经验-self.数据[道具id].升级经验
        self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
        if self.数据[道具id].气血<上限 then
            self.数据[道具id].升级经验=法宝经验[self.数据[道具id].分类][self.数据[道具id].气血+1]
        end
        常规提示(id,"#Y你的法宝#R"..self.数据[道具id].名称.."#Y境界提升了")
    end
    发送数据(连接id,226,{当前经验=玩家数据[id].角色.当前经验,最大经验=玩家数据[id].角色.最大经验})
    发送数据(连接id,3528,{id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
end

function 道具处理类:替换灵宝(连接id,id,编号,编号1)
    local 道具id=玩家数据[id].角色.灵宝[编号]
    if 道具id==nil or self.数据[道具id]==nil then
        常规提示(id,"#Y你没有这件法宝")
        self:索要法宝(连接id,id)
        return
    end
     if  玩家数据[id].角色.等级 <109 then
     常规提示(id,"#Y你的等级不够109级无法使用灵宝")
     return
 end

    if self.数据[道具id].特技 ~= "通用灵宝" then
     if self.数据[道具id].特技 ~= 玩家数据[id].角色.门派 then
         self:索要法宝(连接id,id)
         return 常规提示(id,"#Y你的门派无法佩戴此灵宝")
     end
    end
    if 玩家数据[id].角色.灵宝佩戴[编号1]==nil then
        玩家数据[id].角色.灵宝佩戴[编号1]=玩家数据[id].角色.灵宝[编号]
        玩家数据[id].角色.灵宝[编号]=nil
    else
        local 临时编号=玩家数据[id].角色.灵宝[编号]
        玩家数据[id].角色.灵宝[编号]=玩家数据[id].角色.灵宝佩戴[编号1]
        玩家数据[id].角色.灵宝佩戴[编号1]=临时编号
    end
    self:索要法宝(连接id,id)
end

function 道具处理类:卸下灵宝(连接id,id,编号)
    local 格子=玩家数据[id].角色:取灵宝格子()
    if 格子==0 then
        常规提示(id,"#Y你的灵宝栏已经满了")
        return
    end
    玩家数据[id].角色.灵宝[格子]=玩家数据[id].角色.灵宝佩戴[编号]
    玩家数据[id].角色.灵宝佩戴[编号]=nil
    self:索要法宝(连接id,id)
end

function 道具处理类:修炼灵宝(连接id,id,编号)
    local 道具id=玩家数据[id].角色.灵宝[编号]
    if 道具id==nil or self.数据[道具id]==nil then
        常规提示(id,"#Y你没有这件灵宝")
        self:索要法宝(连接id,id)
        return
    end
    local 上限=5
    if self.数据[道具id].气血==上限 then
        常规提示(id,"#Y你的这件灵宝已经满层了，无法再进行修炼")
        return
    end
    local 消耗经验=math.floor(self.数据[道具id].升级经验*0.5)
    if 消耗经验>10000000 then
        消耗经验=10000000
    end
    if 玩家数据[id].角色.当前经验<消耗经验 then
        常规提示(id,"#Y本次修炼需要消耗#R"..消耗经验.."#Y点人物经验，您似乎没有那么多的经验哟")
        return
    end
    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-消耗经验
    常规提示(id,"#Y修炼成功,你消耗了#R"..消耗经验.."#Y了点人物经验")
    self.数据[道具id].当前经验=self.数据[道具id].当前经验+消耗经验
    if self.数据[道具id].当前经验>=self.数据[道具id].升级经验 then
        self.数据[道具id].气血=self.数据[道具id].气血+1
        self.数据[道具id].当前经验=self.数据[道具id].当前经验-self.数据[道具id].升级经验
        self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
        if self.数据[道具id].气血<上限 then
            self.数据[道具id].升级经验=灵宝经验[self.数据[道具id].分类][self.数据[道具id].气血+1]
        end
        常规提示(id,"#Y你的灵宝#R"..self.数据[道具id].名称.."#Y境界提升了")
    end
    发送数据(连接id,226,{当前经验=玩家数据[id].角色.当前经验,最大经验=玩家数据[id].角色.最大经验})
    发送数据(连接id,3528,{id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
end

function 道具处理类:快捷加血(连接id,id,类型)
    if 玩家数据[id].zhandou~=0 then return  end
    local 数值=0
    local 编号=0
    编号=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)
    if 编号 == nil then return end
    if 类型==1 then
        数值=玩家数据[id].角色.最大气血-玩家数据[id].角色.气血
    else
        数值=玩家数据[id].召唤兽.数据[编号].最大气血-玩家数据[id].召唤兽.数据[编号].气血
    end
    if 数值==0 then
        return
    end
    local 恢复=self:快捷加血1(id,数值)
    if 恢复==0 then
        return
    end
    self:加血处理(连接id,id,恢复,编号)
    道具刷新(id)
end

function 道具处理类:快捷加血1(id,数值)
    local 道具={"包子","四叶花","八角莲叶","人参"}
    local 恢复=0
    local 道具删除={}
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            local 道具id=玩家数据[id].角色.道具[n]
            local 符合=false
            for i=1,#道具 do
                if self.数据[道具id].名称==道具[i] then
                    符合=true
                end
            end
            if 符合 then
                if 恢复<数值 and self:取加血道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量>=数值 then --
                    local 扣除数量=0
                    for i=1,self.数据[道具id].数量 do
                        if 恢复<数值 then
                            恢复=恢复+self:取加血道具1(self.数据[道具id].名称,道具id)
                            扣除数量=扣除数量+1
                        end
                    end
                    道具删除[#道具删除+1]={格子=n,id=道具id,数量=扣除数量}
                elseif 恢复<数值 then
                    恢复= self:取加血道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量
                    道具删除[#道具删除+1]={格子=n,id=道具id,数量=self.数据[道具id].数量}
                end
            end
        end
    end
    if 恢复~=0 then
        for n=1,#道具删除 do
            self.数据[道具删除[n].id].数量=self.数据[道具删除[n].id].数量-道具删除[n].数量
            if self.数据[道具删除[n].id].数量<=0 then
                玩家数据[id].角色.道具[道具删除[n].格子]=nil
                self.数据[道具删除[n].id]=nil
            end
        end
    end
    if 恢复>数值 then 恢复=数值 end
    return 恢复
end

function 道具处理类:快捷加蓝(连接id,id,类型)
    if 玩家数据[id].zhandou~=0 then return  end
    local 数值=0
    local 编号=0
    if 类型==1 then
        数值=玩家数据[id].角色.最大魔法-玩家数据[id].角色.魔法
    else
        编号=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)
        数值=玩家数据[id].召唤兽.数据[编号].最大魔法-玩家数据[id].召唤兽.数据[编号].魔法
    end
    if 数值==0 then
        return
    end
    local 恢复=self:快捷加蓝1(id,数值)
    if 恢复==0 then
        return
    end
    self:加魔处理(连接id,id,恢复,编号)
    道具刷新(id)
end

function 道具处理类:快捷加蓝1(id,数值)
 local 道具={"鬼切草","佛手","紫丹罗"}
 local 恢复=0
 local 道具删除={}
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            local 道具id=玩家数据[id].角色.道具[n]
            local 符合=false
            for i=1,#道具 do
                if self.数据[道具id].名称==道具[i] then
                    符合=true
                end
            end
            if 符合 then
                if 恢复<数值 and self:取加魔道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量>=数值 then --
                    local 扣除数量=0
                    for i=1,self.数据[道具id].数量 do
                        if 恢复<数值 then
                            恢复=恢复+self:取加魔道具1(self.数据[道具id].名称,道具id)
                            扣除数量=扣除数量+1
                        end
                    end
                    道具删除[#道具删除+1]={格子=n,id=道具id,数量=扣除数量}
                elseif 恢复<数值 then
                    恢复= self:取加魔道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量
                    道具删除[#道具删除+1]={格子=n,id=道具id,数量=self.数据[道具id].数量}
                end
            end
        end
    end
    if 恢复~=0 then
        for n=1,#道具删除 do
            self.数据[道具删除[n].id].数量=self.数据[道具删除[n].id].数量-道具删除[n].数量
            if self.数据[道具删除[n].id].数量<=0 then
                玩家数据[id].角色.道具[道具删除[n].格子]=nil
                self.数据[道具删除[n].id]=nil
            end
        end
    end
    if 恢复>数值 then 恢复=数值 end
    return 恢复
end

function 道具处理类:摊位上架商品(连接id,id,数据)
  if 玩家数据[id].摊位数据==nil then return end
  if 数据.价格=="" or 数据.价格==nil or 数据.价格+0<=0 then
    数据.价格=1
  end
  local 价格=数据.价格+0
  if 数据.bb==nil and 数据.制造 == nil then --上架道具
    local 编号=玩家数据[id].角色.道具[数据.道具+0]
    if self.数据[编号] == nil then return 常规提示(id, "#Y/道具异常") end
    if self.数据[编号].不可交易 or self.数据[编号].专用  then
      常规提示(id,"#Y/该物品不可转移给他人")
      return
    end
    玩家数据[id].摊位数据.道具[数据.道具+0]=table.loadstring(table.tostring(self.数据[编号]))
    玩家数据[id].摊位数据.道具[数据.道具+0].价格=价格
    常规提示(id,"#Y/上架物品成功！")
  elseif 数据.bb and 数据.道具==nil and 数据.制造 == nil then
    local 编号=数据.bb+0
    if 玩家数据[id].召唤兽.数据[编号].不可交易 or 玩家数据[id].召唤兽.数据[编号].专用 then
      常规提示(id,"#Y/该召唤兽不可转移给他人")
      return
    elseif 玩家数据[id].召唤兽.数据[编号].统御 ~= nil then
      常规提示(id,"#Y/已被坐骑统御的召唤兽无法转移给他人")
      return
    elseif 玩家数据[id].角色.参战信息~=nil and 玩家数据[id].角色.参战宝宝 then
        if 玩家数据[id].角色.参战宝宝.认证码==玩家数据[id].召唤兽.数据[编号].认证码 then
            常规提示(id,"#Y/参战中的召唤兽无法转移给他人")
            return
        end
    end
    玩家数据[id].摊位数据.bb[编号]=table.loadstring(table.tostring(玩家数据[id].召唤兽.数据[编号]))
    玩家数据[id].摊位数据.bb[编号].价格=价格
    玩家数据[id].摊位数据.bb[编号].id=编号
    常规提示(id,"#Y/上架召唤兽成功！")
  elseif 数据.bb==nil and 数据.道具 == nil then
      local 编号1=数据.制造[1]
      local 编号2=数据.制造[2]
      for k, v in pairs(玩家数据[id].摊位数据.制造) do
        if v~=nil and k==编号1 and v[编号2]~=nil then
          常规提示(id,"#Y/该制造技能等级已经上架了")
          return
        end
      end
      if 玩家数据[id].摊位数据.制造[编号1]==nil then
        玩家数据[id].摊位数据.制造[编号1]={}
      end
      玩家数据[id].摊位数据.制造[编号1][编号2]={价格=价格,序号=tonumber(编号1..编号2)}
      玩家数据[id].摊位数据.制造.制造组=数据.制造组
      常规提示(id,"#Y/上架成功！")
  end
  玩家数据[id].摊位数据.更新=os.time()
  self:索要摊位数据(连接id,id,3517)
end

function 道具处理类:摊位下架商品(连接id,id,数据)

    if 玩家数据[id].摊位数据==nil then return end
    if 数据.道具~=nil then --下架道具
        玩家数据[id].摊位数据.道具[数据.道具+0]=nil
        常规提示(id,"#Y/下架物品成功！")
    elseif 数据.bb~=nil then
        local 编号=数据.bb+0
        玩家数据[id].摊位数据.bb[编号]=nil
        常规提示(id,"#Y/下架召唤兽成功！")
    -- elseif 数据.制造类~=nil then
    --  for i=1,#玩家数据[id].摊位数据.制造类 do
    --      if 玩家数据[id].摊位数据.制造类[i].数据.名称 == 数据.制造类 then
    --          table.remove(玩家数据[id].摊位数据.制造类,i)
    --      end
    --  end
    --  常规提示(id,"#Y/下架制造类成功！")
    end
    玩家数据[id].摊位数据.更新=os.time()
    self:索要摊位数据(连接id,id,3517)
end

function 道具处理类:收摊处理(连接id,id)
    玩家数据[id].摊位数据=nil
    玩家数据[id].离线摆摊=nil
    常规提示(id,"#Y/收摊回家玩老婆去咯！")
    发送数据(连接id,3518)
    地图处理类:取消玩家摊位(id)
end

function 道具处理类:更改摊位招牌(连接id,id,名称)
    if 玩家数据[id].摊位数据==nil then return end
    if os.time()-玩家数据[id].摊位数据.更新<=5 then
        常规提示(id,"#Y/请不要频繁更换招牌")
        return
    end
    常规提示(id,"#Y/更新招牌成功")
    玩家数据[id].摊位数据.更新=os.time()
    玩家数据[id].摊位数据.名称=名称
    发送数据(连接id,3516,名称)
    地图处理类:设置玩家摊位(id,名称)
end

function 道具处理类:购买摊位商品(连接id,id,数据)
    local 对方id=玩家数据[id].摊位id
    if 对方id==nil or 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
        常规提示(id,"#Y/这个摊位并不存在")
        return
    end
    if 玩家数据[id].摊位查看<玩家数据[对方id].摊位数据.更新 then
        常规提示(id,"#Y/这个摊位的数据已经发生了变化，请重新打开该摊位")
        return
    end
    if 玩家数据[对方id].角色:检测交易是否正常(对方id) or 玩家数据[id].角色:检测交易是否正常(id) then
        return
    end
    --数据转移
    local 名称=玩家数据[对方id].角色.名称
    local 名称1=玩家数据[id].角色.名称
    local 账号=玩家数据[对方id].账号
    local 账号1=玩家数据[id].账号
    if 数据.道具~=nil then --购买道具
        local 购买数量 = 数据.数量+0
        if 玩家数据[对方id].摊位数据.道具[数据.道具]==nil then
            常规提示(id,"#Y/这个商品并不存在")
            return
        end
        if 购买数量<1 then
            常规提示(id,"#R数据异常！")
            __S服务:断开连接(玩家数据[id].连接id)
            return
        end
        购买数量=math.floor(购买数量)
        local 剩余数量=玩家数据[对方id].摊位数据.道具[数据.道具].数量 or 1
        if 购买数量>剩余数量 then
            购买数量=math.floor(剩余数量)
        end
        local 价格=玩家数据[对方id].摊位数据.道具[数据.道具].价格*购买数量
        价格=math.floor(价格)
        if 玩家数据[id].角色.银子<价格 then
            常规提示(id,"#Y/你没有那么多的银子")
            return
        elseif 价格<0 then
            常规提示(id,"#R数据异常！")
            __S服务:断开连接(玩家数据[id].连接id)
            return
        end
        local 临时格子=玩家数据[id].角色:取道具格子()
        if 临时格子==0 then
            常规提示(id,"#Y/请先整理下包裹吧！")
            return
        end
        local jiuid=玩家数据[对方id].角色.道具[数据.道具]
        if (jiuid==nil or 玩家数据[对方id].道具.数据[jiuid]==nil) and not 玩家数据[对方id].角色.假人 then
            print("摊位购买道具为空！")
            return
        end


        local 新道具=self:取新编号()
        local 道具名称=玩家数据[对方id].摊位数据.道具[数据.道具].名称
        local 道具识别码=玩家数据[对方id].摊位数据.道具[数据.道具].识别码
        if 玩家数据[对方id].道具:检查道具是否存在(对方id,道具识别码,购买数量)==false and not 玩家数据[对方id].角色.假人 then
            -- 常规提示(id,"#Y/检测到异常数据！")
            return
        end
        玩家数据[id].角色:扣除银子(价格,0,0,"摊位购买",1)
        玩家数据[id].角色:日志记录(format("[摊位系统-购买]购买道具[%s][%s]，花费%s两银子,出售者信息：[%s][%s][%s]",道具名称,道具识别码,价格,账号,对方id,名称), "摊位系统-购买")
        玩家数据[对方id].角色:日志记录(format("[摊位系统-出售]出售道具[%s][%s]，花费%s两银子,购买者信息：[%s][%s][%s]",道具名称,道具识别码,价格,账号1,id,名称1), "摊位系统-出售")
        -- 更改道具归属(道具识别码,账号,对方id,名称)
        常规提示(对方id,"#W/出售#R/"..道具名称.."#W/成功！")
        常规提示(id,"#W/购买#R/"..道具名称.."#W/成功！")
        self.数据[新道具]=table.loadstring(table.tostring(玩家数据[对方id].摊位数据.道具[数据.道具]))
        -- 玩家数据[id].角色.道具[临时格子]=新道具
      if not 玩家数据[对方id].角色.假人 then
            if  not 玩家数据[对方id].摊位数据.道具[数据.道具].可叠加 or 玩家数据[对方id].摊位数据.道具[数据.道具].数量 == nil then
                玩家数据[对方id].道具.数据[jiuid]=nil
                玩家数据[对方id].角色.道具[数据.道具]=nil
                玩家数据[对方id].摊位数据.道具[数据.道具]=nil
            else
                self.数据[新道具].数量=购买数量
                玩家数据[对方id].摊位数据.道具[数据.道具].数量=玩家数据[对方id].摊位数据.道具[数据.道具].数量-购买数量
                if 玩家数据[对方id].摊位数据.道具[数据.道具].数量<=0 then
                    玩家数据[对方id].道具.数据[jiuid]=nil --这里等会儿着重整改
                    玩家数据[对方id].角色.道具[数据.道具]=nil
                    玩家数据[对方id].摊位数据.道具[数据.道具]=nil
                else
                    玩家数据[对方id].道具.数据[jiuid].数量=玩家数据[对方id].道具.数据[jiuid].数量-购买数量
                end
            end
        else
            if  not 玩家数据[对方id].摊位数据.道具[数据.道具].可叠加 or 玩家数据[对方id].摊位数据.道具[数据.道具].数量 == nil then
                玩家数据[对方id].摊位数据.道具[数据.道具]=nil
            else
                self.数据[新道具].数量=购买数量
                玩家数据[对方id].摊位数据.道具[数据.道具].数量=玩家数据[对方id].摊位数据.道具[数据.道具].数量-购买数量
                if 玩家数据[对方id].摊位数据.道具[数据.道具].数量<=0 then
                    玩家数据[对方id].摊位数据.道具[数据.道具]=nil
                end
            end
      end
        玩家数据[id].角色.道具[临时格子]=新道具
        玩家数据[对方id].角色:添加银子(价格,"摊位出售",1)
        道具刷新(id)
        道具刷新(对方id)

    elseif 数据.bb~=nil then
        if 玩家数据[对方id].摊位数据.bb[数据.bb]==nil then
            常规提示(id,"#Y/这只召唤兽不存在")
            return
        elseif  not 玩家数据[id].角色:取新增宝宝数量()then
            常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
            return
        end
        local 价格=玩家数据[对方id].摊位数据.bb[数据.bb].价格
        价格=math.floor(价格)
        if 玩家数据[id].角色.银子<价格 then
            常规提示(id,"#Y/你没有那么多的银子")
            return
        end
        local 道具名称=玩家数据[对方id].摊位数据.bb[数据.bb].名称
        local 道具等级=玩家数据[对方id].摊位数据.bb[数据.bb].等级
        local 道具模型=玩家数据[对方id].摊位数据.bb[数据.bb].模型
        local 道具技能=#玩家数据[对方id].摊位数据.bb[数据.bb].技能
        local 道具识别码=玩家数据[对方id].摊位数据.bb[数据.bb].认证码
        local 临时宝宝 = table.loadstring(table.tostring(玩家数据[对方id].摊位数据.bb[数据.bb]))


        玩家数据[对方id].摊位数据.bb[数据.bb]=nil
        玩家数据[对方id].召唤兽.数据[数据.bb] = nil--测试模式
        玩家数据[id].角色:扣除银子(价格,0,0,"摊位购买",1)
        玩家数据[对方id].角色:添加银子(价格,"摊位出售",1)
        玩家数据[id].角色:日志记录(format("[摊位系统-购买]购买召唤兽[%s][%s][%s][%s][%s]，花费%s两银子,出售者信息：[%s][%s][%s]",道具名称,道具模型,道具等级,道具技能,道具识别码,价格,账号,对方id,名称), "摊位系统-购买")
        玩家数据[对方id].角色:日志记录(format("[摊位系统-出售]出售召唤兽[%s][%s][%s][%s][%s]，花费%s两银子,购买者信息：[%s][%s][%s]",道具名称,道具模型,道具等级,道具技能,道具识别码,价格,账号1,id,名称1), "摊位系统-出售")
        常规提示(对方id,"#W/出售#R/"..道具名称.."#W/成功！")
        常规提示(id,"#W/购买#R/"..道具名称.."#W/成功！")
        local 宝宝=宝宝类.创建()
        宝宝:加载数据(临时宝宝)
        玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据+1]=宝宝
        玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].认证码 = id.."_"..os.time().."_"..取随机数(111111111111,999999999999)
        玩家数据[id].召唤兽:刷新信息(玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].认证码)

        local 现有数据 = {}
        local 临时摆摊数据 = {}
        for n = 1 , 玩家数据[对方id].角色.召唤兽携带上限 do
            if 玩家数据[对方id].召唤兽.数据[n] ~= nil and 玩家数据[对方id].召唤兽.数据[n] ~= 0 and 玩家数据[对方id].召唤兽.数据[n].认证码 ~= 道具识别码 then
                现有数据[#现有数据 + 1] = {
                bb = 玩家数据[对方id].召唤兽.数据[n],
                编号 = n --原本位置
                }
            end
        end

        玩家数据[对方id].召唤兽.数据 = {}
        for n = 1, #现有数据 do
            玩家数据[对方id].召唤兽.数据[n] = 现有数据[n].bb
            for i = 1, 玩家数据[对方id].角色.召唤兽携带上限 do
                if 玩家数据[对方id].摊位数据.bb[i] ~= nil and 玩家数据[对方id].摊位数据.bb[i].id == 现有数据[n].编号 then
                    临时摆摊数据[n] = {
                    id = n,
                    bb = 玩家数据[对方id].摊位数据.bb[i],
                    价格 = 玩家数据[对方id].摊位数据.bb[i].价格
                    }
                end
            end
        end
        玩家数据[对方id].摊位数据.bb = {}
        for n = 1, 7 do
            if 临时摆摊数据[n] ~= nil then
                玩家数据[对方id].摊位数据.bb[n] = 临时摆摊数据[n].bb
                玩家数据[对方id].摊位数据.bb[n].价格 = 临时摆摊数据[n].价格
                玩家数据[对方id].摊位数据.bb[n].id = 临时摆摊数据[n].id
            end
        end

        if 玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].参战信息~=nil then
            玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].参战信息=nil
            玩家数据[对方id].角色.参战信息=nil
            玩家数据[对方id].角色.参战宝宝={}
            发送数据(玩家数据[对方id].连接id,18,玩家数据[对方id].角色.参战宝宝)
        end
        发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
        发送数据(玩家数据[对方id].连接id,3512,玩家数据[对方id].召唤兽.数据)
    end

    玩家数据[对方id].角色:存档()
    玩家数据[id].角色:存档()
    玩家数据[对方id].摊位数据.更新=os.time()
    玩家数据[id].摊位查看=os.time()
    self:索要其他玩家摊位(连接id,id,对方id,3522)
    self:索要摊位数据(玩家数据[对方id].连接id,对方id,3517)
end


function 道具处理类:购买摊位制造商品(连接id,id,数据)
    local 对方id=玩家数据[id].摊位id
    if 玩家数据[id].摊位数据~=nil then
        常规提示(id,"#Y/摆摊中无法此操作。")
        return
    end
    if 对方id==nil or 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
        常规提示(id,"#Y/这个摊位并不存在")
        return
    end
    if 玩家数据[id].摊位查看<玩家数据[对方id].摊位数据.更新 then
        常规提示(id,"#Y/摊主正忙，请稍等片刻，或重新打开")
        return
    end
    local 价格 = 0
    local 查找标识 = false
    for k,v in pairs(玩家数据[对方id].摊位数据.制造) do
        for i,v in pairs(v) do
            if 查找标识 then  --双for循环跳出用
                break
            end
            if v.序号 == 数据.选中序号 then
                价格 = v.价格
                查找标识 = true
                break
            end
        end
    end
    if 价格 < 1  then
        常规提示(id,"#Y/数据异常！")
        return
    end
    价格=math.floor(价格)
    if 数据.制造类别 == "其他类" then
        if 玩家数据[id].角色.银子<价格 then
            常规提示(id,"#Y/你没有那么多的银子")
            return
        end
        if 数据.技能名称 == "嗜血" or 数据.技能名称 == "轻如鸿毛" or 数据.技能名称 == "拈花妙指" or 数据.技能名称 == "穿云破空"
            or 数据.技能名称 == "盘丝舞" or 数据.技能名称 == "一气化三清" or 数据.技能名称 == "浩然正气" or 数据.技能名称 == "龙附"
            or 数据.技能名称 == "神兵护法" or 数据.技能名称 == "魔王护持" or 数据.技能名称 == "莲华妙法" or 数据.技能名称 == "神力无穷"
            or 数据.技能名称 == "尸气漫天" or 数据.技能名称 == "元阳护体" or 数据.技能名称 == "担山赶月" or 数据.技能名称 == "神木呓语" then

            local 等级 = 玩家数据[对方id].角色:取师门技能等级(数据.技能名称)
            if 玩家数据[对方id].角色:扣除活力(tonumber(等级)) then
                -- if 数据.技能名称 ~= "兵器谱" and 数据.技能名称 ~= "堪察令" then
                玩家数据[对方id].角色:摊位符制造(数据.技能名称,id)
                -- else
                -- 玩家数据[对方id].角色:临时鉴定符(数据.技能名称,id)
                -- end
            else
                常规提示(id, "#Y/摊主的活力不足无法制造!")
                return
            end
            玩家数据[id].角色:扣除银子(价格,0,0,"购买强化符",1)
            玩家数据[对方id].角色:添加银子(价格,"摊位购买强化符",1)
            玩家数据[对方id].角色.活力 = 玩家数据[对方id].角色.活力 - qz(数据.等级)
            体活刷新(对方id)
        end
    else
        if 数据.技能名称 == "打造" or 数据.技能名称 == "裁缝" or 数据.技能名称 == "炼金" then
            玩家数据[id].给予数据 = {事件="购买玩家打造",制造数据={名称=数据.技能名称,等级=数据.等级,价格=数据.价格,是否强化=数据.打造模式},对方id=对方id,类型=1}
            发送数据(玩家数据[id].连接id,3507,{道具=玩家数据[id].道具:索要道具1(id),名称="打铁炉",类型="NPC",等级=数据.等级})
        end
    end
end

function 道具处理类:索要其他玩家摊位(连接id,id,对方id,序号)
    if 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
        常规提示(id,"#Y/这个摊位并不存在")
        return
    end
    玩家数据[id].摊位查看=os.time()
    玩家数据[id].摊位id=对方id
    发送数据(玩家数据[id].连接id,3520,{银子=玩家数据[id].角色.银子, 仙玉=取仙玉(id)})
    发送数据(玩家数据[id].连接id,序号,{bb=玩家数据[对方id].摊位数据.bb,物品=玩家数据[对方id].摊位数据.道具,制造=玩家数据[对方id].摊位数据.制造,id=对方id,摊主名称=玩家数据[对方id].角色.名称,名称=玩家数据[对方id].摊位数据.名称})
end

function 道具处理类:索要摊位数据(连接id,id,序号)
    if 玩家数据[id].摊位数据==nil then --新建摊位
        if 玩家数据[id].队伍~=0 then
            常规提示(id,"#Y/组队状态下无法摆摊")
            return
        elseif 收购数据[id]~=nil then
            常规提示(id,"#Y/收购状态下无法摆摊")
            return
        elseif 玩家数据[id].角色.飞行中 then
            常规提示(id,"#Y/飞行状态下无法摆摊")
            return
        else
            local 地图=玩家数据[id].角色.地图数据.编号
            if 地图~=1001 and 地图~=1501 and 地图~=1070 and 地图~=1092 and 地图~=1208 and 地图~=1226 and 地图~=1040 then
                常规提示(id,"#Y/该场景无法摆摊")
                return
            elseif 玩家数据[id].角色.等级<30 and 连接id ~="假人"then
                常规提示(id,"#Y/只有等级达到30级的玩家才可使用摆摊功能")
                return
            end
        end
        玩家数据[id].摊位数据={道具={},bb={},制造={},id=id,名称="杂货摊位",摊主=玩家数据[id].角色.名称,更新=os.time()}
        地图处理类:设置玩家摊位(id,"杂货摊位")
    end
    发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
    发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
     发送数据(玩家数据[id].连接id,3706.1)
    --道具刷新(id)
    -- local bb={}
    -- for n=1,11 do
    --  if 玩家数据[id].摊位数据.bb[n]~=nil then
    --      bb[n]=玩家数据[id].摊位数据.bb[n].价格
    --  end
    -- end
    -- local 道具={}
    -- for n=1,20 do
    --  if 玩家数据[id].摊位数据.道具[n]~=nil then
    --      道具[n]=玩家数据[id].摊位数据.道具[n].价格
    --  end
    -- end
    -- local 制造类={}
    -- for n=1,#玩家数据[id].摊位数据.制造类 do
    --  if 玩家数据[id].摊位数据.制造类[n]~=nil then
    --      制造类[n] = {}
    --      制造类[n].价格=玩家数据[id].摊位数据.制造类[n].价格
    --      制造类[n].名称=玩家数据[id].摊位数据.制造类[n].数据.名称
    --  end
    -- end
    -- 发送数据(连接id,序号,{bb=bb,物品=道具,制造类=制造类,id=id,摊主名称=玩家数据[id].角色.名称,名称=玩家数据[id].摊位数据.名称})
    local bb={}
    for k, v in pairs(玩家数据[id].摊位数据.bb) do
        if v~=nil then
            bb[k]={v.价格,v.认证码,v.模型,v.名称}
        end
    end
    local 道具={}
    for n=1,20 do
        if 玩家数据[id].摊位数据.道具[n]~=nil then
            道具[n]=玩家数据[id].摊位数据.道具[n]
        end
    end
    发送数据(连接id,序号,{bb=bb,物品=道具,制造=玩家数据[id].摊位数据.制造,id=id,摊主名称=玩家数据[id].角色.名称,名称=玩家数据[id].摊位数据.名称})
end

function 道具处理类:取消交易(id)
    if 玩家数据[id].交易信息~=nil then
        if 玩家数据[玩家数据[id].交易信息.id]~=nil then
            发送数据(玩家数据[玩家数据[id].交易信息.id].连接id,3511)
            常规提示(玩家数据[id].交易信息.id,"#Y/对方取消了交易")
            玩家数据[玩家数据[id].交易信息.id].交易信息=nil
        end
        交易数据[玩家数据[id].交易信息.编号]=nil
        玩家数据[id].交易信息=nil
    end
end

function 道具处理类:取指定道具(编号)
    return table.loadstring(table.tostring(self.数据[编号]))
end

function 道具处理类:检查道具是否存在(id,识别码,数量)
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].识别码==识别码 then
            if self.数据[玩家数据[id].角色.道具[n]].数量~=nil then
                if self.数据[玩家数据[id].角色.道具[n]].数量>=数量 then
                    return true
                end
            else
                return true
            end
        end
    end
    return false
end


function 道具处理类:发起交易处理(连接id,id,id1)
    if 玩家数据[id1]==nil then
        常规提示(id,"#Y/对方并不在线")
        return
    elseif 地图处理类:比较距离(id,id1,500)==false then
        常规提示(id,"#Y/你们的距离太远了")
        return
    elseif 玩家数据[id1].交易信息~=nil or 玩家数据[id1].摊位数据~=nil then
        常规提示(id,"#Y/对方正忙，请稍后再试")
        return
    elseif 收购数据[id1]~=nil then
        常规提示(id,"#Y/对方正忙，请稍后再试")
        return
    elseif 玩家数据[id].交易信息~=nil then
        常规提示(id,"#Y/你上次的交易还没有结束哟~")
        return
    elseif 玩家数据[id1].禁止交易 then
        常规提示(id,"#Y/对方没有打开交易开关")
        return
    elseif 玩家数据[id1].角色:检测交易是否正常(id1) or 玩家数据[id].角色:检测交易是否正常(id) then
        return
    end
    交易数据[id]={[id]={},[id1]={}}
    常规提示(id,"你正在和"..玩家数据[id1].角色.名称.."进行交易")
    常规提示(id1,"你正在和"..玩家数据[id].角色.名称.."进行交易")
    发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
    发送数据(玩家数据[id1].连接id,3512,玩家数据[id1].召唤兽.数据)
    发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
    发送数据(玩家数据[id1].连接id,3513,玩家数据[id1].道具:索要道具2(id1))
    发送数据(玩家数据[id].连接id,3514,{名称=玩家数据[id1].角色.名称,等级=玩家数据[id1].角色.等级})
    发送数据(玩家数据[id1].连接id,3514,{名称=玩家数据[id].角色.名称,等级=玩家数据[id].角色.等级})
    玩家数据[id1].交易信息={编号=id,id=id}
    玩家数据[id].交易信息={编号=id,id=id1}
end

function 道具处理类:完成交易处理(交易id,id,id1)
    if 玩家数据[id1].角色:检测交易是否正常(id1) or 玩家数据[id].角色:检测交易是否正常(id) then
        return
    end
    if 玩家数据[id].zhandou~=0 or 玩家数据[id1].zhandou~=0 then
        常规提示(id,"#Y/战斗中无法使用此功能")
        常规提示(id1,"#Y/战斗中无法使用此功能")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    elseif 玩家数据[id1].摊位数据~=nil or 玩家数据[id].摊位数据~=nil then
        常规提示(id,"#Y/摆摊状态下无法使用此功能")
        常规提示(id1,"#Y/摆摊状态下无法使用此功能")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    elseif 收购数据[id1]~=nil then
        常规提示(id,"#Y/摆摊状态下无法使用此功能")
        常规提示(id1,"#Y/摆摊状态下无法使用此功能")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    elseif 地图处理类:比较距离(id,id1,500)==false then
        常规提示(id,"#Y/你们的距离太远了")
        常规提示(id1,"#Y/你们的距离太远了")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    end
    local 银子=交易数据[交易id][id].银子+0
    local 银子1=交易数据[交易id][id1].银子+0
    if not 判断是否为数字(交易数据[交易id][id].银子) or not 判断是否为数字(交易数据[交易id][id1].银子) then
        常规提示(id,"#Y/数据异常，请检查")
        常规提示(id1,"#Y/数据异常，请检查")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    elseif 玩家数据[id].角色.银子<银子 then
        常规提示(id,"#Y/你没有那么多的银子")
        常规提示(id1,"#Y/对方没有那么多的银子")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    elseif 玩家数据[id1].角色.银子<银子1 then
        常规提示(id1,"#Y/你没有那么多的银子")
        常规提示(id,"#Y/对方没有那么多的银子")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        交易数据[交易id]=nil
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        return
    end
    --检查道具是否存在

    local 操作id=id
    local 对象id=id1
    for n=1,#交易数据[交易id][操作id].道具 do
        local 道具id=交易数据[交易id][操作id].道具[n].编号
        local 道具id1=玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]
        if 道具id~=道具id1 or 玩家数据[操作id].道具.数据[道具id]==nil or 玩家数据[操作id].道具.数据[道具id1]==nil or 玩家数据[操作id].道具.数据[道具id1].识别码~=交易数据[交易id][操作id].道具[n].认证码 then
            常规提示(操作id,"#Y/你此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        elseif 玩家数据[操作id].道具.数据[道具id1].不可交易 or 玩家数据[操作id].道具.数据[道具id1].专用 then
            常规提示(操作id,"#Y/该道具不可交易给他人，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易存在无法交易的道具，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        end
    end
    local 操作id=id1
    local 对象id=id
    for n=1,#交易数据[交易id][操作id].道具 do
        local 道具id=交易数据[交易id][操作id].道具[n].编号
        local 道具id1=玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]
        if 道具id~=道具id1 or 玩家数据[操作id].道具.数据[道具id]==nil or 玩家数据[操作id].道具.数据[道具id1]==nil or 玩家数据[操作id].道具.数据[道具id1].识别码~=交易数据[交易id][操作id].道具[n].认证码 then
            常规提示(操作id,"#Y/你此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        elseif 玩家数据[操作id].道具.数据[道具id1].不可交易 or 玩家数据[操作id].道具.数据[道具id1].专用 then
            常规提示(操作id,"#Y/该道具不可交易给他人，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易存在无法交易的道具，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        end
    end
    local 操作id=id
    local 对象id=id1
    for n=1,#交易数据[交易id][操作id].bb do
        local bb编号= 交易数据[交易id][操作id].bb[n].编号
        local 认证码=玩家数据[操作id].召唤兽.数据[bb编号].认证码
        if 认证码~=交易数据[交易id][操作id].bb[n].认证码 then
            常规提示(操作id,"#Y/你此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        elseif 玩家数据[操作id].召唤兽.数据[bb编号].不可交易 or 玩家数据[操作id].召唤兽.数据[bb编号].专用 then
            常规提示(操作id,"#Y/该召唤兽不可交易给他人，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易存在无法交易的召唤兽，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            交易数据[交易id]=nil
            return
        -- elseif 玩家数据[操作id].角色.参战信息~=nil then
        --  常规提示(操作id,"#Y/请先取消所有召唤兽参战状态，本次交易取消")
        --  常规提示(对象id,"#Y/对方尚未取消召唤兽参战状态，本次交易取消")
        --  发送数据(玩家数据[操作id].连接id,3511)
        --  发送数据(玩家数据[对象id].连接id,3511)
        --  玩家数据[id1].交易信息=nil
        --  玩家数据[id].交易信息=nil
        --  交易数据[交易id]=nil
        --  return
        elseif 玩家数据[操作id].召唤兽.数据[bb编号].统御~=nil then
            常规提示(操作id,"#Y/该召唤兽处于统御状态，请解除统御后再进行此操作")
            常规提示(对象id,"#Y/对方召唤兽处于统御状态，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        end
    end
    local 操作id=id1
    local 对象id=id
    for n=1,#交易数据[交易id][操作id].bb do
        local bb编号= 交易数据[交易id][操作id].bb[n].编号
        local 认证码=玩家数据[操作id].召唤兽.数据[bb编号].认证码
        if 认证码~=交易数据[交易id][操作id].bb[n].认证码 then
            常规提示(操作id,"#Y/你此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        elseif 玩家数据[操作id].召唤兽.数据[bb编号].不可交易 or 玩家数据[操作id].召唤兽.数据[bb编号].专用 then
            常规提示(操作id,"#Y/该召唤兽不可交易给他人，本次交易取消")
            常规提示(对象id,"#Y/对方此次交易存在无法交易的召唤兽，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        -- elseif 玩家数据[操作id].角色.参战信息~=nil then
        --  常规提示(操作id,"#Y/请先取消所有召唤兽参战状态，本次交易取消")
        --  常规提示(对象id,"#Y/对方尚未取消召唤兽参战状态，本次交易取消")
        --  发送数据(玩家数据[操作id].连接id,3511)
        --  发送数据(玩家数据[对象id].连接id,3511)
        --  玩家数据[id1].交易信息=nil
        --  玩家数据[id].交易信息=nil
        --  交易数据[交易id]=nil
        --  return
        elseif 玩家数据[操作id].召唤兽.数据[bb编号].统御~=nil then
            常规提示(操作id,"#Y/该召唤兽处于统御状态，请解除统御后再进行此操作")
            常规提示(对象id,"#Y/对方召唤兽处于统御状态，本次交易取消")
            发送数据(玩家数据[操作id].连接id,3511)
            发送数据(玩家数据[对象id].连接id,3511)
            玩家数据[id1].交易信息=nil
            玩家数据[id].交易信息=nil
            交易数据[交易id]=nil
            return
        end
    end
    local 道具数量=玩家数据[id].角色:取道具格子2()
    local 道具数量1=玩家数据[id1].角色:取道具格子2()
    if 道具数量<#交易数据[交易id][id1].道具 then
        常规提示(id,"#Y/你身上的空间不够")
        常规提示(id1,"#Y/对方身上的空间不够")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    elseif 道具数量1<#交易数据[交易id][id].道具 then
        常规提示(id1,"#Y/你身上的空间不够")
        常规提示(id,"#Y/对方身上的空间不够")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    end
    if #玩家数据[id].召唤兽.数据+#交易数据[交易id][id1].bb>玩家数据[id].角色.召唤兽携带上限 then
        常规提示(id,"#Y/你可携带的召唤兽数量已达上限")
        常规提示(id1,"#Y/对方可携带的召唤兽数量已达上限")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    elseif #玩家数据[id1].召唤兽.数据+#交易数据[交易id][id].bb>玩家数据[id].角色.召唤兽携带上限 then
        常规提示(id1,"#Y/你可携带的召唤兽数量已达上限")
        常规提示(id,"#Y/对方可携带的召唤兽数量已达上限")
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    end



    --数据转移起始
    local 操作id=id
    local 对象id=id1
    local 账号=玩家数据[操作id].账号
    local 账号1=玩家数据[对象id].账号
    local 名称=玩家数据[操作id].角色.名称
    local 名称1=玩家数据[对象id].角色.名称
    if 交易数据[交易id][操作id].银子>1 then
        local 之前银子=玩家数据[操作id].角色.银子
        玩家数据[操作id].角色.银子 =玩家数据[操作id].角色.银子 -  交易数据[交易id][操作id].银子
        玩家数据[操作id].角色:日志记录(format("[交易系统-扣除银子]给了[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号1,对象id,名称1,交易数据[交易id][操作id].银子,之前银子,玩家数据[操作id].角色.银子), "交易系统-扣除银子")
        local 之前银子=玩家数据[对象id].角色.银子
        玩家数据[对象id].角色.银子 =玩家数据[对象id].角色.银子 +  交易数据[交易id][操作id].银子
        玩家数据[操作id].角色:日志记录(format("[交易系统-获得银子]获得[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号,操作id,名称,交易数据[交易id][操作id].银子,之前银子,玩家数据[对象id].角色.银子), "交易系统-获得银子")
        常规提示(对象id,format("#Y/%s给了你%s两银子",名称,交易数据[交易id][操作id].银子))
        常规提示(操作id,format("#Y/你给了%s%s两银子",名称1,交易数据[交易id][操作id].银子))
    end

    for n=1,#交易数据[交易id][操作id].道具 do
        local 道具id=交易数据[交易id][操作id].道具[n].编号
        local 数量 = 交易数据[交易id][操作id].道具[n].数量
        数量=math.floor(数量)
        if 数量 < 1 then
            return
        end
        --local 道具id1=玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]
        local 新格子=玩家数据[对象id].角色:取道具格子()
        local 新id=玩家数据[对象id].道具:取新编号()
        -- 玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
        -- 玩家数据[对象id].角色.道具[新格子]=新id
        -- 玩家数据[操作id].道具.数据[道具id]=nil
        -- 玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil

        if 数量==1 and (玩家数据[操作id].道具.数据[道具id].可叠加==nil or 玩家数据[操作id].道具.数据[道具id].可叠加==false) then
            玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
            玩家数据[对象id].角色.道具[新格子]=新id
            玩家数据[操作id].道具.数据[道具id]=nil
            玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
        elseif 玩家数据[操作id].道具.数据[道具id].可叠加~=nil and 玩家数据[操作id].道具.数据[道具id].数量~=nil then
            if 数量<玩家数据[操作id].道具.数据[道具id].数量 then
                玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
                玩家数据[对象id].道具.数据[新id].数量 = 数量
                玩家数据[对象id].角色.道具[新格子]=新id
                玩家数据[操作id].道具.数据[道具id].数量 = 玩家数据[操作id].道具.数据[道具id].数量 - 数量
            elseif 数量==玩家数据[操作id].道具.数据[道具id].数量 then
                玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
                玩家数据[对象id].角色.道具[新格子]=新id
                玩家数据[操作id].道具.数据[道具id]=nil
                玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
            end
        elseif 玩家数据[操作id].道具.数据[道具id].数量 == nil then
            玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
            玩家数据[对象id].角色.道具[新格子]=新id
            玩家数据[操作id].道具.数据[道具id]=nil
            玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
        end

        local 道具识别码=玩家数据[对象id].道具.数据[新id].识别码
        local 道具名称=玩家数据[对象id].道具.数据[新id].名称
        -- 更改道具归属(道具识别码,账号1,对象id,道具名称)
        玩家数据[操作id].角色:日志记录(format("[交易系统-扣除物品]给了[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号1,对象id,名称1,道具名称,道具识别码), "交易系统-扣除物品")
        玩家数据[对象id].角色:日志记录(format("[交易系统-获得物品]获得[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号,操作id,名称,道具名称,道具识别码), "交易系统-获得物品")
        常规提示(对象id,format("#Y/%s给了你%s",名称,道具名称))
        常规提示(操作id,format("#Y/你给了%s%s",名称1,道具名称))
    end



    local 操作=false
    for n=1,#交易数据[交易id][操作id].bb do
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]))
        local 宝宝=宝宝类.创建()
        宝宝:加载数据(玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据])
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据]=宝宝
        玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]=nil
        local bb名称=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].名称
        local bb模型=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].模型
        local bb种类=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].种类
        local bb等级=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].等级
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码=对象id.."_"..os.time().."_"..取随机数(111111111111,999999999999)
        local bb认证码=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码
         玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据]:刷新信息("1")----C改御兽术
        local bb技能=""
    --  for i=1,#玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].技能 do
            --bb技能=bb技能..玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].技能[i].."、"
    --  end
        玩家数据[操作id].角色:日志记录(format("[交易系统-扣除bb]给了[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号1,对象id,名称1,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码), "交易系统-扣除bb")
        玩家数据[对象id].角色:日志记录(format("[交易系统-获得bb]获得[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号,操作id,名称,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码), "交易系统-获得bb")
        操作=true
        常规提示(对象id,format("#Y/%s给了你%s",名称,bb名称))
        常规提示(操作id,format("#Y/你给了%s%s",名称1,bb名称))
    end
    local 临时bb={}
    if 操作 then
        for n=1,7 do
            if 玩家数据[操作id].召唤兽.数据[n]~=nil then
                临时bb[#临时bb+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[n]))
            end
        end
        玩家数据[操作id].召唤兽.数据={}
        for n=1,#临时bb do
            玩家数据[操作id].召唤兽.数据[n]=table.loadstring(table.tostring(临时bb[n]))
            local 宝宝=宝宝类.创建()
            宝宝:加载数据(玩家数据[操作id].召唤兽.数据[n])
            玩家数据[操作id].召唤兽.数据[n]=宝宝
        end
        发送数据(玩家数据[操作id].连接id,3512,玩家数据[操作id].召唤兽.数据)
        发送数据(玩家数据[对象id].连接id,3512,玩家数据[操作id].召唤兽.数据)
        玩家数据[操作id].召唤兽:重置参战信息(操作id)
    end
    --交换数据终止
    local 操作id=id1
    local 对象id=id
    local 账号=玩家数据[操作id].账号
    local 账号1=玩家数据[对象id].账号
    local 名称=玩家数据[操作id].角色.名称
    local 名称1=玩家数据[对象id].角色.名称
    if 交易数据[交易id][操作id].银子>0 then
        local 之前银子=玩家数据[操作id].角色.银子
        玩家数据[操作id].角色.银子 =玩家数据[操作id].角色.银子 -  交易数据[交易id][操作id].银子
        玩家数据[操作id].角色:日志记录(format("[交易系统-扣除银子]给了[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号1,对象id,名称1,交易数据[交易id][操作id].银子,之前银子,玩家数据[操作id].角色.银子), "交易系统-扣除银子")
        local 之前银子=玩家数据[对象id].角色.银子
        玩家数据[对象id].角色.银子 =玩家数据[对象id].角色.银子 +  交易数据[交易id][操作id].银子
        玩家数据[操作id].角色:日志记录(format("[交易系统-获得银子]获得[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号,操作id,名称,交易数据[交易id][操作id].银子,之前银子,玩家数据[对象id].角色.银子), "交易系统-获得银子")
        常规提示(对象id,format("#Y/%s给了你%s两银子",名称,交易数据[交易id][操作id].银子))
        常规提示(操作id,format("#Y/你给了%s%s两银子",名称1,交易数据[交易id][操作id].银子))
    end

    玩家数据[操作id].角色:存档()
    玩家数据[对象id].角色:存档()
    for n=1,#交易数据[交易id][操作id].道具 do
        local 道具id=交易数据[交易id][操作id].道具[n].编号
        local 数量 = 交易数据[交易id][操作id].道具[n].数量
        数量=math.floor(数量)
        if 数量 < 1 then
            return
        end
        --local 道具id1=玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]
        local 新格子=玩家数据[对象id].角色:取道具格子()
        local 新id=玩家数据[对象id].道具:取新编号()
        -- 玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
        -- 玩家数据[对象id].角色.道具[新格子]=新id
        -- 玩家数据[操作id].道具.数据[道具id]=nil
        -- 玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil

        if 数量==1 and (玩家数据[操作id].道具.数据[道具id].可叠加==nil or 玩家数据[操作id].道具.数据[道具id].可叠加==false) then
            玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
            玩家数据[对象id].角色.道具[新格子]=新id
            玩家数据[操作id].道具.数据[道具id]=nil
            玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
        elseif 玩家数据[操作id].道具.数据[道具id].可叠加~=nil and 玩家数据[操作id].道具.数据[道具id].数量~=nil then
            if 数量<玩家数据[操作id].道具.数据[道具id].数量 then
                玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
                玩家数据[对象id].道具.数据[新id].数量 = 数量
                玩家数据[对象id].角色.道具[新格子]=新id
                玩家数据[操作id].道具.数据[道具id].数量 = 玩家数据[操作id].道具.数据[道具id].数量 - 数量
            elseif 数量==玩家数据[操作id].道具.数据[道具id].数量 then
                玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
                玩家数据[对象id].角色.道具[新格子]=新id
                玩家数据[操作id].道具.数据[道具id]=nil
                玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
            end
        elseif 玩家数据[操作id].道具.数据[道具id].数量 == nil then
            玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
            玩家数据[对象id].角色.道具[新格子]=新id
            玩家数据[操作id].道具.数据[道具id]=nil
            玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
        end

        local 道具识别码=玩家数据[对象id].道具.数据[新id].识别码
        local 道具名称=玩家数据[对象id].道具.数据[新id].名称
        -- 更改道具归属(道具识别码,账号1,对象id,道具名称)
        玩家数据[操作id].角色:日志记录(format("[交易系统-扣除物品]给了[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号1,对象id,名称1,道具名称,道具识别码), "交易系统-扣除物品")
        玩家数据[对象id].角色:日志记录(format("[交易系统-获得物品]获得[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号,操作id,名称,道具名称,道具识别码), "交易系统-获得物品")
        常规提示(对象id,format("#Y/%s给了你%s",名称,道具名称))
        常规提示(操作id,format("#Y/你给了%s%s",名称1,道具名称))
    end
    local 操作=false
    for n=1,#交易数据[交易id][操作id].bb do
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]))
        local 宝宝=宝宝类.创建()
        宝宝:加载数据(玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据])
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据]=宝宝
        玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]=nil
        local bb名称=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].名称
        local bb模型=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].模型
        local bb种类=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].种类
        local bb等级=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].等级
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码 = 对象id.."_"..os.time().."_"..取随机数(111111111111,999999999999)
        local bb认证码=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码
        local bb技能=""
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据]:刷新信息("1")----C改御兽术
    --  for i=1,#玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].技能 do
            --bb技能=bb技能..玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].技能[i].."、"
    --  end
        玩家数据[操作id].角色:日志记录(format("[交易系统-扣除bb]给了[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号1,对象id,名称1,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码), "交易系统-扣除bb")
        玩家数据[对象id].角色:日志记录(format("[交易系统-获得bb]获得[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号,操作id,名称,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码), "交易系统-获得bb")
        操作=true
        常规提示(对象id,format("#Y/%s给了你%s",名称,bb名称))
        常规提示(操作id,format("#Y/你给了%s%s",名称1,bb名称))
    end
    local 临时bb={}
    if 操作 then
        for n=1,7 do
            if 玩家数据[操作id].召唤兽.数据[n]~=nil then
                临时bb[#临时bb+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[n]))
            end
        end
        玩家数据[操作id].召唤兽.数据={}
        for n=1,#临时bb do
            玩家数据[操作id].召唤兽.数据[n]=table.loadstring(table.tostring(临时bb[n]))
            local 宝宝=宝宝类.创建()
            宝宝:加载数据(玩家数据[操作id].召唤兽.数据[n])
            玩家数据[操作id].召唤兽.数据[n]=宝宝
        end
        发送数据(玩家数据[操作id].连接id,3512,玩家数据[操作id].召唤兽.数据)
        发送数据(玩家数据[对象id].连接id,3512,玩家数据[对象id].召唤兽.数据)
        玩家数据[操作id].召唤兽:重置参战信息(操作id)
    end
    发送数据(玩家数据[id].连接id,3511,玩家数据[id].召唤兽.数据)
    发送数据(玩家数据[id1].连接id,3511,玩家数据[id1].召唤兽.数据)
    道具刷新(id)
    道具刷新(id1)
    玩家数据[id].角色:存档()
    玩家数据[id1].角色:存档()
    交易数据[交易id]=nil
    玩家数据[id].交易信息=nil
    玩家数据[id1].交易信息=nil
end

function 道具处理类:完成交易(连接id,id,数据)
    if type(玩家数据[id].交易信息)~= "table" then return end
    local 交易id=玩家数据[id].交易信息.编号
    local 对方id=玩家数据[id].交易信息.id
    if 交易数据[交易id][id].锁定 == nil then
        常规提示(id,"#Y/请先锁定交易再点击确定")
        return
    elseif 交易数据[交易id][id].锁定 and 交易数据[交易id][对方id].锁定==nil then
        常规提示(id,"#Y/请耐心等待对方锁定交易状态")
        return
    elseif 交易数据[交易id][id].确定 and 交易数据[交易id][对方id].确定==nil then
        常规提示(id,"#Y/请耐心等待对方确定交易")
        return
    elseif 交易数据[交易id][对方id].确定 then
        self:完成交易处理(交易id,id,对方id)
        return
    end
    交易数据[交易id][id].确定=true
    常规提示(对方id,"#Y/对方已经确定了交易，点击交易即可完成交易")
    常规提示(id,"#Y/你确定了交易，对方点击确定即可完成交易")
end

function 道具处理类:设置交易数据(连接id,id,数据)
    if type(玩家数据[id].交易信息)~= "table" then return end
    local 交易id=玩家数据[id].交易信息.编号
    local 对方id=玩家数据[id].交易信息.id
    if 交易数据[交易id][id].锁定 and 交易数据[交易id][对方id].锁定==nil then
        常规提示(id,"#Y/请耐心等待对方锁定交易状态")
        return
    end
    local 道具数据={}
    local bb数据={}
    local 银子数据=数据.银子
    if type(银子数据) ~= "number" then
        银子数据 = 0
    end
    交易数据[交易id][id].道具={}
    交易数据[交易id][id].bb={}
    交易数据[交易id][id].银子=银子数据+0
    交易数据[交易id][id].锁定=true
    for n=1,3 do
        local 道具格子=数据.道具[n]
        if 道具格子~=nil then
            if 数据.数量 == nil or 数据.数量[n] == nil or (数据.数量[n]~=nil and (数据.数量[n]<1 or 数据.数量[n]>99)) then
                return
            end
            local 道具id=玩家数据[id].角色.道具[道具格子]
            道具数据[#道具数据+1]=self:取指定道具(道具id)
            交易数据[交易id][id].道具[#交易数据[交易id][id].道具+1]={认证码=道具数据[#道具数据].识别码,格子=道具格子,编号=道具id,数量=数据.数量[n]}
        end
    end
    for n=1,3 do
        local bb编号=数据.bb[n]
        if bb编号~=nil then
            bb数据[#bb数据+1]=table.loadstring(table.tostring(玩家数据[id].召唤兽.数据[bb编号]))
            交易数据[交易id][id].bb[#交易数据[交易id][id].bb+1]={认证码=bb数据[#bb数据].认证码,编号=bb编号}
        end
    end
    发送数据(连接id,3508)
    常规提示(id,"#Y/你已经锁定了交易状态，对方锁定交易状态后点击确定即可完成交易")
    常规提示(对方id,"#Y/对方已经锁定了交易状态，等你锁定交易状态后点击确定即可完成交易")
    发送数据(玩家数据[对方id].连接id,3510,{bb=bb数据,道具=道具数据,银子=银子数据,数量=数据.数量})
end

function 道具处理类:出售装备(连接id,id)
    if 玩家数据[id].出售装备==nil or 玩家数据[id].角色.道具[玩家数据[id].出售装备]==nil then
        添加最后对话(id,"该装备不存在！")
        return
    end
    local 道具id=玩家数据[id].角色.道具[玩家数据[id].出售装备]
    if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
        添加最后对话(id,"该物品无法被我收购")
        return
    end
    local 银子=self:取装备价格(道具id)
    玩家数据[id].角色:添加银子(银子,format("出售装备:%s,%s",self.数据[道具id].名称,self.数据[道具id].识别码),1)
    self.数据[道具id]=nil
    玩家数据[id].角色.道具[玩家数据[id].出售装备]=nil
    玩家数据[id].出售装备=nil
    添加最后对话(id,"出售装备成功，你获得了"..银子.."两银子")
    道具刷新(id)
    return
end

function 道具处理类:取回收环价格核心(道具)
    local 等级=道具.等级
    if not 等级 then
        return 1
    end
    local 价格=150
    if 等级==10 then
        价格=30*等级
    elseif  等级==20 then
        价格=50*等级
    elseif 等级==30 then
        价格=100*等级
    elseif 等级==40 then
        价格=150*等级
    elseif 等级==50 then
        if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","50环")~="空" then
            价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","50环")+0
        else
            价格=200*等级
        end
    elseif 等级==60 then
        if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","60环")~="空" then
            价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","60环")+0
        else
            价格=300*等级
        end
    elseif 等级==70 then
        if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","70环")~="空" then
            价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","70环")+0
        else
            价格=500*等级
        end
    elseif 等级==80 then
        if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","80环")~="空" then
            价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","80环")+0
        else
            价格=700*等级
        end
    elseif 等级==140 then
        if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","140环")~="空" then
            价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","140环")+0
        else
            价格=900*等级
        end
    elseif 等级==150 then
        if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","150环")~="空" then
            价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","150环")+0
        else
            价格=1000*等级
        end
    else
        价格=1000
    end
    if 道具.专用~=nil or 道具.不可交易~=nil then
        价格=1
    end
    return 价格
end

function 道具处理类:取回收环价格(道具id)
    return self:取回收环价格核心(self.数据[道具id])
end

function 道具处理类:取装备价格(道具id)
    local 等级=self.数据[道具id].等级
    if not 等级 then
        return
    end
    local 价格=150
    if 等级==10 then
        价格=30
    elseif  等级==20 then
        价格=50
    elseif 等级==30 then
        价格=100
    elseif 等级==40 then
        价格=150
    elseif 等级==50 then
        价格=200
    elseif 等级==60 then
        价格=300
    elseif 等级==70 then
        价格=500
    elseif 等级==80 then
        价格=700
    else
        价格=1000
    end
    if self.数据[道具id].专用~=nil then
        价格=1
        等级=1
    end
    return 价格*等级
end

function 道具处理类:生成合成旗(连接id,id,名称)
    if 玩家数据[id].合成旗序列==nil or #玩家数据[id].合成旗序列<=0 then
        常规提示(id,"#Y未找到已提交的导标旗，请重新使用法宝进行合成")
        玩家数据[id].合成旗序列=nil
        return
    end
    local 编号=玩家数据[id].法宝id
    if 玩家数据[id].角色.法宝[编号]==nil or self.数据[玩家数据[id].角色.法宝[编号]]==nil or self.数据[玩家数据[id].角色.法宝[编号]].名称~="五色旗盒" then
        常规提示(id,"#Y你没有这样的法宝")
        return
    elseif self.数据[玩家数据[id].角色.法宝[编号]].魔法<=0 then
        常规提示(id,"#Y你的法宝灵气不足")
        return
    end
    self.数据[玩家数据[id].角色.法宝[编号]].魔法=self.数据[玩家数据[id].角色.法宝[编号]].魔法-1
    local 次数=0
    for n=1,#玩家数据[id].合成旗序列 do
        local 临时id=玩家数据[id].角色.道具[玩家数据[id].合成旗序列[n]]
        if 临时id==nil or self.数据[临时id]==nil or self.数据[临时id].总类~=11 or self.数据[临时id].分类~=1 or self.数据[临时id].地图~=玩家数据[id].合成旗序列.地图 then
            常规提示(id,"#Y您的物品数据已经发生变化，请重新使用法宝进行合成")
            玩家数据[id].合成旗序列=nil
            return
        end
        if self.数据[临时id].次数==nil then
            self.数据[临时id].次数=1
        end
        次数=次数+self.数据[临时id].次数
    end
    local 临时id=玩家数据[id].角色.道具[玩家数据[id].合成旗序列[1]]
    self.数据[临时id].名称=名称
    self.数据[临时id].分类=2
    self.数据[临时id].次数=次数
    self.数据[临时id].xy={}
    for n=1,#玩家数据[id].合成旗序列 do
        local 临时id1=玩家数据[id].角色.道具[玩家数据[id].合成旗序列[n]]
        self.数据[临时id].xy[n]={x=self.数据[临时id1].x,y=self.数据[临时id1].y}
        if n~=1 then
            玩家数据[id].角色.道具[玩家数据[id].合成旗序列[n]]=nil
            self.数据[临时id1]=nil
        end
    end
    玩家数据[id].合成旗序列=nil
    玩家数据[id].法宝id=nil
    玩家数据[id].最后操作=nil
    发送数据(连接id,38,{内容="你的法宝#R/五色旗盒#W/灵气减少了1点"})
    常规提示(id,"#Y您获得了#R"..名称)
    道具刷新(id)
end

function 道具处理类:系统购买道具(id,名称,数量,价格,道具数据,消费方式,购买渠道)
    local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
    随机序列=随机序列+1
    local 临时道具
    local 道具id
    local 重置id=0
    local 提醒 = true
    for n=1,80 do
        if 重置id==0 and 玩家数据[id].角色.道具[n] and 数量~=nil and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称==道具数据.名称 and self.数据[玩家数据[id].角色.道具[n]].数量 then
            if self.数据[玩家数据[id].角色.道具[n]].数量+数量<=999 then
                self.数据[玩家数据[id].角色.道具[n]].数量= self.数据[玩家数据[id].角色.道具[n]].数量 + 数量
                重置id=1
            end
        end
    end
    if 重置id==0 then
        local 道具格子=玩家数据[id].角色:取道具格子()
        if 道具格子==0 then --道具格子满的情况
            local 道具格子 =玩家数据[id].角色:取临时格子() --给到临时格子里面
            if 道具格子~=0 then --临时格子没满
                道具id=self:取新编号()
                if 道具数据 == nil then
                    print("tbcopy3")
                end
                self.数据[道具id] = table.copy(道具数据)
                self.数据[道具id].识别码=识别码
                if 数量 ~= nil and self.数据[道具id].可叠加 then
                    self.数据[道具id].数量 = 数量
                end
                玩家数据[id].角色.临时包裹[道具格子]=道具id
            else
                提醒=false
                常规提示(id,"#Y/你无法再继续获得道具")
            end
            local fhz = self:临时背包索取()
            if fhz[2] then
                发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",true})
            end
        else
            道具id=self:取新编号()
            if 道具数据 == nil then
                print("tbcopy4")
            end
            self.数据[道具id]= table.copy(道具数据)
            self.数据[道具id].识别码=识别码
            if 数量 ~= nil and self.数据[道具id].可叠加 then
                self.数据[道具id].数量 = 数量
            end
            玩家数据[id].角色.道具[道具格子]=道具id
        end
        临时道具 = 取物品数据(名称)
        if self.数据[道具id] then
            if not self.数据[道具id].总类 then
                self.数据[道具id].总类 = 临时道具[2]
            end
            if not self.数据[道具id].分类 then
                self.数据[道具id].分类 = 临时道具[3]
            end
            if not self.数据[道具id].子类 then
                self.数据[道具id].子类 = 临时道具[4]
            end
        end
        if self.数据[道具id] and (self.数据[道具id].名称 == "自动抓鬼卡" or self.数据[道具id].名称 == "自动抓鬼年卡")  then
            self.数据[道具id].不可交易 = true
            self.数据[道具id].可叠加 = false
        end
        if self.数据[道具id] and (self.数据[道具id].名称 == "天眼珠" or self.数据[道具id].名称 == "三眼天珠" or self.数据[道具id].名称 == "九眼天珠") then
            self.数据[道具id].灵气 = self.数据[道具id].阶品 or 取随机数(10,100)
            self.数据[道具id].等级 = self.数据[道具id].等级 or 75
        end

        -- if self.数据[道具id].商城类型 then
        --     if self.数据[道具id].商城类型 == "战锦商品" then
        --         self.数据[道具id].总类=2
        --         self.数据[道具id].子类=1
        --         self.数据[道具id].分类=15
        --     elseif self.数据[道具id].商城类型 == "锦衣套装" then
        --         self.数据[道具id].总类=2
        --         self.数据[道具id].子类=1
        --         self.数据[道具id].分类=15
        --     end
        -- end
    end
    if 提醒 then
        常规提示(id,"#Y/你得到了#G"..(数量 or 1).."#Y个#G"..名称)
    end
    发送数据(玩家数据[id].连接id,3699)
end
-- (cyid,名称,数量,参数,链接)
function 道具处理类:给予超链接道具(id,名称,数量,参数,超链接,附加)
    self:给予道具(id,名称,数量,参数,附加,专用,数据,消费,消费方式,消费内容,超链接)
end

function 道具处理类:给予道具(id,名称,数量,参数,附加,专用,数据,消费,消费方式,消费内容,超链接,限时,附加2,参数2)
    if id ==nil then return end
    if 名称 == "怪物卡片" then
        local 非掉落来源 = 附加 == "商店" or 附加 == "商城购买" or 附加 == "翻一翻" or 附加 == "bwjf" or 附加 == "嘉年华转盘抽奖" or 附加 == "活跃度奖励" or 附加 == "赞助" or 附加 == "GM工具发送" or 附加2 == "GM工具发送"
        if not 非掉落来源 then
            local 卡片等级 = nil
            if type(数量) == "number" then
                卡片等级 = 数量
            elseif type(数量) == "string" and 变身卡数据 and 变身卡数据[数量] then
                卡片等级 = 变身卡数据[数量].等级
            end
            if 卡片等级 and 卡片等级 < 7 then
                local 折算银子 = 卡片等级 * 100000
                玩家数据[id].角色:添加银子(折算银子,"低阶变身卡折算",1)
                常规提示(id,"#Y/低阶变身卡已自动折算为#R"..折算银子.."#Y/两银子")
                return true
            elseif 卡片等级 and 卡片等级 > 9 then
                数量 = 取随机数(7,9)
            end
        end
    end
    if 名称=="上古玉魄·阴" or 名称=="上古玉魄·阳" or (type(数据)=="table" and (数据.名称=="上古玉魄·阴" or 数据.名称=="上古玉魄·阳")) then
        local x名称
        if 名称 and string.find(名称,"上古玉魄") then
            x名称 = 名称
        elseif type(数据)=="table" and (数据.名称=="上古玉魄·阴" or 数据.名称=="上古玉魄·阳") then
            x名称 = 数据.名称
        end
        if x名称 then
            self:生成上古玉魄(id,x名称,超链接)
        end
        return
    end

    local 自动了 =false
    local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
    随机序列=随机序列+1
    local 临时道具
    local 道具id
    local 原始数量 = 数量
    if 原始数量 == nil then
        原始数量 = 1
    end
    if 数据 == nil then
        if 消费方式 ~= nil then
            if 消费<1 then
                print("玩家id  "..id.."   商城购买物品存在作弊行为！")
                return false
            end
            消费=qz(消费)
            if 消费方式 == "银子" then
                if not 玩家数据[id].角色:扣除银子(qz(消费*原始数量),0,0,消费内容,1) then
                    常规提示(id,"你没有那么多的银子")
                    return false
                end
            elseif 消费方式 == "仙玉" then
                if not 玩家数据[id].角色:扣除仙玉( 消费, 消费内容) then
                    return false
                end
            elseif 消费方式 == "仙玉积分" then
                if not 玩家数据[id].角色:扣除积分(消费, 消费内容, id) then
                    return false
                end
            else
                常规提示(id,"你没有那么多的积分")
                return
            end
        end
        if 数量 == nil or (not tonumber(数量) and 名称 ~= "怪物卡片" and type(数量)~="table") then
            数量 = 1
        end

        local 重置id=0
        local 假道具 = self:生成假道具(id,名称,数量,参数,附加,专用,数据,识别码, 限时,参数2)
        if  附加 ~="商店" and 附加 ~="商城购买" and 系统处理类:获得自动回收(id,假道具) then
            return
        end

        for n=1,80 do
            if 重置id==0 and 玩家数据[id].角色.道具[n] and 数量~=nil and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称==名称 and 取可否叠加(self.数据[玩家数据[id].角色.道具[n]],假道具) then
                if self.数据[玩家数据[id].角色.道具[n]].数量+数量<=999 then
                    数量=self.数据[玩家数据[id].角色.道具[n]].数量+数量
                    self.数据[玩家数据[id].角色.道具[n]].数量=数量
                    道具id=玩家数据[id].角色.道具[n]
                    识别码=self.数据[玩家数据[id].角色.道具[n]].识别码 or 识别码
                    重置id=1
                end
            end
            if 重置id == 0 and 玩家数据[id].角色.道具[n] and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称 == 名称 and 名称 == "超级合成旗" and self.数据[玩家数据[id].角色.道具[n]].限时时间 then
                self.数据[玩家数据[id].角色.道具[n]].限时时间 = self.数据[玩家数据[id].角色.道具[n]].限时时间 + 2592000
                重置id=1
            end
        end
        if 重置id==0 then
            local 道具格子=玩家数据[id].角色:取道具格子()
            if 道具格子==0 then
                local 临时格子 =玩家数据[id].角色:取临时格子()
                if 临时格子~=0 then
                    道具id=self:取新编号()
                    self.数据[道具id]=假道具
                    玩家数据[id].角色.临时包裹[临时格子]=道具id
                else
                    常规提示(id,"#Y/你的临时背包已满无法继续获得道具")
                end
                local fhz = self:临时背包索取()
                if fhz[2] then
                    发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",true})
                end
            else
                道具id=self:取新编号()
                self.数据[道具id]=假道具
                玩家数据[id].角色.道具[道具格子]=道具id
            -- if 超链接 and self.数据[道具id] then
            --             local 文本 = 超链接.提示.."#G/qqq|"..self.数据[道具id].名称.."*"..self.数据[道具id].识别码.."*道具".."/["..self.数据[道具id].名称.."]#W"..超链接.结尾
            --             local 返回信息 = {}
            --             返回信息[#返回信息+1] = self.数据[道具id]
            --             返回信息[#返回信息].索引类型 = "道具"
            --             广播消息({内容=文本,频道=超链接.频道,方式=1,超链接=返回信息})
            -- end
            if 超链接 and self.数据[道具id] then
                local 提示文本 = 超链接.提示 or ""
                local 结尾文本 = 超链接.结尾 or ""
                local 频道文本 = 超链接.频道 or "xt"  -- 默认使用系统频道
                local 文本 = 提示文本.."#G/qqq|"..self.数据[道具id].名称.."*"..self.数据[道具id].识别码.."*道具".."/["..self.数据[道具id].名称.."]#W"..结尾文本
                local 返回信息 = {}
                返回信息[#返回信息+1] = self.数据[道具id]
                返回信息[#返回信息].索引类型 = "道具"
                广播消息({内容=文本,频道=频道文本,方式=1,超链接=返回信息})
            end

            if 附加 ~="商店" and 附加 ~="商城购买" and 附加~="翻一翻" and 附加~="新号创建" and 附加~="人族时空积分" and 附加~="仙族时空积分" and 附加~="魔族时空积分"  and 附加~="赞助"
                and 附加 ~="不存共享" and 附加2 ~="不存共享" and 附加 ~="bwjf" and 附加 ~="嘉年华转盘抽奖" and 附加 ~="活跃度奖励" and 附加~="网关发送" and 附加~="GM工具发送" and 附加2~="GM工具发送" and 假道具.名称~="符纸" and 假道具.名称~="密信"
                and 假道具.名称~="自动抓鬼卡" and 假道具.名称~="自动抓鬼年卡"  then--不存共享
                     账号仓库数据[玩家数据[id].角色.账号]:自动存仓(玩家数据[id].连接id, id, {类型="道具",页数=1,物品=道具格子})
                     自动了=true
                end
            end
        end



        if 假道具 and 假道具.名称 then
            if 假道具.可叠加 then
                if 数量 == nil then --测试？
                    发送数据(玩家数据[id].连接id,38,{内容="#Y/你获得了"..假道具.名称,频道="xt"})
                    -- 常规提示(id,"#Y/你获得了"..假道具.名称)
                else
                    发送数据(玩家数据[id].连接id,38,{内容="#Y/你获得了"..原始数量.."个"..假道具.名称,频道="xt"})
                    -- 常规提示(id,"#Y/你获得了"..原始数量.."个"..假道具.名称)
                end
            else
                发送数据(玩家数据[id].连接id,38,{内容="#Y/你获得了"..假道具.名称,频道="xt"})
                -- 常规提示(id,"#Y/你获得了"..假道具.名称)

            end
        end
    else
        if 消费方式 ~= nil then
            if 消费<1 then
                print("玩家id  "..id.."   商城购买物品存在作弊行为！")
                return false
            end
            消费=qz(消费)
            if 消费方式 == "银子" then
                if not 玩家数据[id].角色:扣除银子(消费*原始数量,0,0,消费内容,1) then
                    常规提示(id,"你没有那么多的银子")
                    return false
                end
            end
        end
        local 重置id=0
        for n=1,80 do
            if 重置id==0 and 玩家数据[id].角色.道具[n] and 数量~=nil and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称==名称 and self.数据[玩家数据[id].角色.道具[n]].数量 and 取可否叠加(self.数据[玩家数据[id].角色.道具[n]],数据) then
                if self.数据[玩家数据[id].角色.道具[n]].数量+数量<=999 then
                    self.数据[玩家数据[id].角色.道具[n]].数量= self.数据[玩家数据[id].角色.道具[n]].数量 +数量
                    重置id=1
                end
            end
        end
        if 重置id==0 then
            local 道具格子=玩家数据[id].角色:取道具格子()
            if 道具格子==0 then
                local 道具格子 =玩家数据[id].角色:取临时格子()
                if 道具格子~=0 then
                    道具id=self:取新编号()
                    self.数据[道具id]= 数据
                    self.数据[道具id].识别码=识别码
                    if self.数据[道具id].名称 then
                        if 数量 ~= nil then
                            self.数据[道具id].数量 = 数量
                            常规提示(id,"#Y/你获得了"..原始数量.."#Y个"..self.数据[道具id].名称)
                        else
                            常规提示(id,"#Y/你获得了"..self.数据[道具id].名称)
                        end
                    end
                    玩家数据[id].角色.临时包裹[道具格子]=道具id
                    常规提示(id,"#Y/道具栏已满，物品被放入临时物品栏，请及时处理")
                else
                    常规提示(id,"#Y/你的临时背包已满无法继续获得道具")
                end
                local fhz = self:临时背包索取()
                if fhz[2] then
                    发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",true})
                end
            else
                道具id=self:取新编号()
                self.数据[道具id]= 数据
                self.数据[道具id].识别码=识别码
                if self.数据[道具id].名称 then
                    if 数量 ~= nil then
                        self.数据[道具id].数量 = 数量
                        常规提示(id,"#Y/你获得了"..原始数量.."#Y个"..self.数据[道具id].名称)
                    else
                        常规提示(id,"#Y/你获得了"..self.数据[道具id].名称)
                    end
                end
                玩家数据[id].角色.道具[道具格子]=道具id
            end
        end
    end
    if 道具id == nil then return end
    if   not 自动了 and self.数据[道具id].识别码 == nil then self.数据[道具id].识别码 = 识别码 end
    发送数据(玩家数据[id].连接id,3699)
    return true
end


function 道具处理类:给予锦衣道具(id,名称,价格,类别)
    if id == nil then return end
    local 识别码 = id .. "_" .. os.time() .. "_" .. 取随机数(1000, 9999) .. "_" .. 随机序列
    随机序列 = 随机序列 + 1
    local 道具id
    local 假道具 = self:生成假道具(id, 名称, 1, nil, nil, nil, nil, 识别码)
    local 锦衣格子 = nil
    for n = 1, 100 do
        if 玩家数据[id].角色.锦衣背包[n] == nil then
            锦衣格子 = n
            break
        end
    end
    if 锦衣格子 == nil then
        常规提示(id, "#Y/你的锦衣背包已满")
        return false
    end
    道具id = self:取新编号()
    self.数据[道具id] = 假道具
    玩家数据[id].角色.锦衣背包[锦衣格子] = 道具id
    local 临时道具 = 取物品数据(名称)
    if self.数据[道具id] then
        if not self.数据[道具id].总类 then
            self.数据[道具id].总类 = 临时道具[2]
        end
        if not self.数据[道具id].分类 then
            self.数据[道具id].分类 = 临时道具[3]
        end
        if not self.数据[道具id].子类 then
            self.数据[道具id].子类 = 临时道具[4]
        end
    end
    if 假道具 and 假道具.名称 then
        常规提示(id, "#Y/你获得了" .. 假道具.名称)
    end
    if 价格 and 类别 then
        消费扣除(id, 价格, 类别, "商城购买")
    end

    if 道具id == nil then return false end
    return true
end

function 道具处理类:整理背包(连接id,id,数据)---------------兽决叠加
    local data = {}
    local 计数 = 0
    local function 简易排序(a,b)
    return 排序整理(a.序号)<排序整理(b.序号)
    end
    for k,v in  pairs (玩家数据[id].角色.道具) do  --判断背包道具--
        data[#data+1]={内容=v,序号=self.数据[v].名称}
        if self.数据[v].数量~=nil and self.数据[v].数量+0<99999999 and self.数据[v].可叠加 then
            for i,n in pairs(玩家数据[id].角色.道具) do --二次判断背包道具--
                    if k~=i and  self.数据[n] ~= nil and self.数据[v] ~= nil and  self.数据[n].名称==self.数据[v].名称 and self.数据[n].数量~=nil  and self.数据[v].数量+self.数据[n].数量<99999999  then
                    if (self.数据[n].名称== "初级清灵仙露"  and self.数据[v].名称 =="初级清灵仙露") or (self.数据[n].名称== "中级清灵仙露"  and self.数据[v].名称 =="中级清灵仙露") or (self.数据[n].名称== "高级清灵仙露"  and self.数据[v].名称 =="高级清灵仙露") or (self.数据[n].名称== "高级摄灵珠"  and self.数据[v].名称 =="高级摄灵珠") then
                        if self.数据[v].灵气 == self.数据[n].灵气 then
                                     self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                                     self.数据[n]=nil
                                     玩家数据[id].角色.道具[i]=nil
                                end
                        elseif  self.数据[v].名称 == "九转金丹" and self.数据[n].名称 == "九转金丹" then
                          if self.数据[v].阶品 ==  self.数据[n].阶品  then
                            self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                            self.数据[n]=nil
                            玩家数据[id].角色.道具[i]=nil
                          end

                        elseif  self.数据[v].名称 == "灵犀玉" and self.数据[n].名称 == "灵犀玉" then
                            if self.数据[v].特性 ==  self.数据[n].特性 and  self.数据[v].子类==self.数据[n].子类  then
                                 self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                            self.数据[n]=nil
                            玩家数据[id].角色.道具[i]=nil
                          end
                        elseif  self.数据[v].名称 == "魔兽要诀" and self.数据[n].名称 == "魔兽要诀" then
                if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "高级魔兽要诀" and self.数据[n].名称 == "高级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
            elseif  self.数据[v].名称 == "焕彩石" and self.数据[n].名称 == "焕彩石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end

          elseif  self.数据[v].名称 == "特殊魔兽要诀" and self.数据[n].名称 == "特殊魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "超级魔兽要诀" and self.数据[n].名称 == "超级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "召唤兽内丹" and self.数据[n].名称 == "召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "高级召唤兽内丹" and self.数据[n].名称 == "高级召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
                    else
                            self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                            self.数据[n]=nil
                            玩家数据[id].角色.道具[i]=nil
                    end
                end
            end
        end
    end
    table.sort(data,简易排序)
    local tabdata={}
    for k,v in pairs(data) do
    tabdata[#tabdata+1]=v.内容
    end
    玩家数据[id].角色.道具 = tabdata
    道具刷新(id)
end


function 道具处理类:生成假道具(id,名称,数量,参数,附加,专用,数据,识别码, 限时,参数2)
    local 灵性
    --local 参数=tonumber(参数)
    if 名称=="初级清灵仙露" then
        灵性 = 取随机数(1,4)
    elseif 名称=="中级清灵仙露" then
        灵性 = 取随机数(2,6)
    elseif 名称=="高级清灵仙露" then
        灵性 = 取随机数(4,8)
    elseif 名称=="高级摄灵珠" then
        if 参数 then
            灵性=参数
        else
            灵性 = 4
        end
    elseif 名称=="如意丹" then
        灵性=取五行()
    end
    local 假道具 = 物品类()
    假道具:置对象(名称)
    local 临时道具 = 取物品数据(名称)
    临时道具.总类=临时道具[2]
    临时道具.子类=临时道具[4]
    临时道具.分类=临时道具[3]
    if 临时道具[22] then
        假道具.共享=临时道具[22]
    end
    if self.kediejia[名称] then
        if 数量==nil then
            数量=1
        end
        假道具.可叠加 = true
    end
    if 名称=="鬼谷子" then
        local go=false
        if 参数 then
            for i=4,13 do
                if self.阵法名称[i]==参数 then
                    假道具.子类=参数
                    go=true
                    break
                end
            end
        end
        if not go then
          假道具.子类 = self.阵法名称[取随机数(4,13)]
        end
    elseif 名称=="战魄" then
        假道具.等级 = 160
    elseif 名称=="本命法宝门派秘籍" then
            local 随机门派= {"方寸山", "女儿村", "神木林", "化生寺", "大唐官府", "盘丝洞", "阴曹地府", "无底洞", "魔王寨", "狮驼岭", "天宫", "普陀山", "凌波城", "五庄观", "龙宫", "花果山","九黎城"}

            假道具.门派= 参数2 or 随机门派[取随机数(1,#随机门派)]
            if 参数~=nil then
                假道具.数值=参数
            end

    elseif 名称=="钟灵石" then
        假道具.等级 = 数量 or 1
        假道具.特性 = 参数  or 灵饰随机特性[取随机数(1,#灵饰随机特性)]
    elseif 名称=="焕彩石" then
            假道具.等级=参数 or 1

    elseif 名称=="女娲灵契" then
        假道具.可叠加 = false
        local tj ={"琴音三叠","弱点击破","破血狂攻","心疗术","破碎无双","诅咒之伤","太极护法","罗汉金钟","慈航普度","放下屠刀","笑里藏刀","碎甲术","金刚怒目","命归术","心如明镜","气归术","凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","气归术","凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","凝滞术","吸血特技","金刚不坏","菩提心佑","起死回生","回魂咒","气疗术","野兽之力","魔兽之印","修罗咒","身似菩提","光辉之甲","圣灵之甲","四海升平","水清诀","玉清诀","冰清诀","晶清诀"}
        local x特技
        if 参数 and type(参数)=="string" then
            for _k,tjm in ipairs(tj) do
                if tjm == 参数 then
                    x特技 = tjm
                    break
                end
            end
        end
        假道具.特技 = x特技 or tj[取随机数(1,#tj)]
    elseif 名称=="女娲祝符" then
        假道具.可叠加 = false
        local rwyp={"金创药","金香玉","小还丹","千年保心丹","风水混元丹","金创药","定神香","金创药","蛇蝎美人","金创药","九转回魂丹","金创药","佛光舍利子","金创药","十香返生丸","金创药","五龙丹","百炼金乌丸"}
        local x三药
        if 参数 and type(参数)=="string" then
            for _k,tjm in ipairs(rwyp) do
                if tjm == 参数 then
                    x三药 = tjm
                    break
                end
            end
        end
        假道具.三药 = x三药 or rwyp[取随机数(1,#rwyp)]
    elseif 名称=="五色灵尘" then
        假道具.可叠加 = false
        假道具.等级 = tonumber(数量) or 1
        if 假道具.等级 > 15 then 假道具.等级 = 15 end

    --------------CC修改（增加种族秘境时空之钥）
    elseif 名称=="人族时空之钥" then
            local a={"青丘秘辛","九曲神林","车迟斗法","暗偃禁地","女国迷阵"}
            local 随机秘境 = a[取随机数(1,#a)]
            假道具.类型="人族"
            假道具.秘境类型=随机秘境
            假道具.境界=时空之钥[id].境界 or 1
            假道具.不可交易=true
    elseif 名称=="魔族时空之钥" then
            local a={"狮驼洞穴","火焰山之子","九黎魔影","阴府勾魂","陷空妖洞"}
            local 随机秘境 = a[取随机数(1,#a)]
            假道具.类型="魔族"
            假道具.秘境类型=随机秘境
            假道具.境界=时空之钥[id].境界 or 1
            假道具.不可交易=true
     elseif 名称=="仙族时空之钥" then
            local a={"沧海狂龙","万雷神殿","金甲天门","龙王秘宝","大闹天宫"}
            local 随机秘境 = a[取随机数(1,#a)]
            假道具.类型="仙族"
            假道具.秘境类型=随机秘境
            假道具.境界=时空之钥[id].境界 or 1
            假道具.不可交易=true
     --------------CC修改（增加种族秘境时空之钥）
     elseif 名称=="炫彩ID" then
            local sdsd={"绿色ID","蓝色ID","紫色ID","黄金ID","趣味ID"}
            if  参数 and type(参数)~= "number" then
                 假道具.特效=参数
            else
                 假道具.特效=sdsd[取随机数(1,#sdsd)]
            end

    elseif 名称=="灵箓" then
        假道具.可叠加 = true
    elseif 名称=="玄灵珠·破军"  then
            假道具.等级=数量 or 1
        elseif 名称=="玄灵珠·空灵"  then
            假道具.等级=数量 or 1
        elseif 名称=="玄灵珠·噬魂"  then
            假道具.等级=数量 or 1
        elseif 名称=="玄灵珠·回春"  then
            假道具.等级=数量 or 1
    elseif 名称=="初级清灵仙露" or 名称=="中级清灵仙露" or 名称=="高级清灵仙露" or 名称=="高级摄灵珠" then
        假道具.灵气=灵性
        假道具.可叠加 = true
    elseif 名称=="特殊清灵仙露" then
        假道具.灵气=110
        假道具.可叠加 = false
    elseif 名称=="灵兜兜" then
        假道具.可叠加 = true
    elseif 名称=="镇妖拘魂铃" then
        假道具.可叠加 = true
        假道具.不可交易 = true
    elseif  名称=="良师册" or 名称=="专属大礼包" or 名称=="秘宝宝箱" or 名称=="机缘宝箱" or 名称=="月卡"  then
        假道具.可叠加 = false
        假道具.不可交易 = true
    elseif 名称=="会员周卡礼包" or 名称=="会员周卡" then
        假道具.不可交易 = true
    elseif 名称=="超级合成旗" or 名称=="新春飞行符" then
        假道具.可叠加 = false
        if 数量 and 数量 ~= 999 then
            假道具.次数=数量
        end
    elseif 名称=="自动抓鬼卡" then
        假道具.可叠加 = false
        假道具.不可交易 = true
        local 天数=30
            if 参数 then
                天数=参数+0
            end
        假道具.限时时间 = os.time()+86400*天数

     elseif 名称=="自动抓鬼年卡" then
        假道具.可叠加 = false
        假道具.不可交易 = true
        local 天数=365
            if 参数 then
                天数=参数+0
            end
        假道具.限时时间 = os.time()+86400*天数

    elseif 名称=="未激活的符石" then
        local 级别 = 数量 or 1
        假道具.子类 = 级别
        if 参数 == nil then
            if 级别 == 1 then
                假道具.符石名称 = 一级符石[取随机数(1,#一级符石)]
            elseif 级别==2 then
                假道具.符石名称 = 二级符石[取随机数(1,#二级符石)]
            elseif 级别==3 then
                假道具.符石名称 = 三级符石[取随机数(1,#三级符石)]
            else
                假道具.子类 = 1
                假道具.符石名称 = 一级符石[取随机数(1,#一级符石)]
            end
        else
            假道具.符石名称 = 参数
        end
        local lssj = 取物品数据(假道具.符石名称)
        假道具.符石属性 = lssj[21]
        假道具.颜色 = lssj[20]
    elseif 名称=="未激活的星石" then
        if 参数==nil then
            假道具.子类 = 取随机数(1,6)
        else
            if 参数 == "头盔" then
                假道具.子类 = 1
            elseif 参数 == "饰物" then
                假道具.子类 = 2
            elseif 参数 == "武器" then
                假道具.子类 = 3
            elseif 参数 == "衣甲" then
                假道具.子类 = 4
            elseif 参数 == "腰带" then
                假道具.子类 = 5
            elseif 参数 == "靴子" then
                假道具.子类 = 6
            else
                假道具.子类 = 取随机数(1,6)
            end
        end
    elseif 名称=="灵犀玉" then
        if 参数==nil then
            if 取随机数() <=80 then
                假道具.子类 = 取随机数(1,2)
            else
                假道具.子类 = 取随机数(2,3)
            end
            假道具.特性 = 取灵犀玉特性()
        else
            假道具.子类 = 3
            假道具.特性 = 取礼包灵犀玉特性()
        end

    elseif 名称=="神兵图鉴" or 名称=="灵宝图鉴" or 名称=="灵饰图鉴" then
        -- 假道具.子类 = 数量
        假道具.等级 = 数量
    elseif 名称=="阎罗免死牌" then
        假道具.次数 = 3
        假道具.限时 = os.time()+86400
    elseif 名称=="制造指南书" then
        if 参数==nil and type(数量) == "table" then
            假道具.子类=数量[取随机数(1,#数量)]*10
            假道具.特效=取随机数(1,#书铁范围)
            if 取随机数()<=40 then
                假道具.特效=取随机数(19,#书铁范围)
            end
        else
            假道具.子类=数量
            假道具.特效=参数
        end
    elseif 名称=="灵饰指南书" then
        -- 假道具.子类=数量[取随机数(1,#数量)]*10
        if 数量 and type(数量) == "table" then
            假道具.子类=数量[取随机数(1,#数量)]*10
        else
            local lv = 玩家数据[id].角色.等级
            local fanwei={6,8}
            if lv>=80 and lv<100 then
                fanwei={8,10}
            elseif lv>=100 and lv<120 then
                fanwei={10,12}
            elseif lv>=120 then
                fanwei={10,12,14}
            end
            假道具.子类=fanwei[取随机数(1,#fanwei)]*10
        end
        if 参数 then
            假道具.特效=参数
        else
            假道具.特效=随机灵饰[取随机数(1,#随机灵饰)]
        end
    elseif 名称=="元灵晶石" then
        if 数量 and type(数量) == "table" then
            假道具.子类=数量[取随机数(1,#数量)]*10
        else
            local lv = 玩家数据[id].角色.等级
            local fanwei={6,8}
            if lv>=80 and lv<100 then
                fanwei={8,10}
            elseif lv>=100 and lv<120 then
                fanwei={10,12}
            elseif lv>=120 then
                fanwei={10,12,14}
            end
            假道具.子类=fanwei[取随机数(1,#fanwei)]*10
        end
        -- 假道具.子类=数量[取随机数(1,#数量)]*10
    elseif 名称=="百炼精铁" then
        假道具.子类=数量
    elseif 名称=="精魄灵石" then
        local sj = 取随机数(1,6)
        local 类型={"速度","躲避","伤害","灵力","防御","气血"}
        假道具.子类=sj --红黄蓝
        假道具.等级=数量 or 1
        假道具.特效=参数 or 类型[sj]
        假道具.可叠加=false
    elseif 名称=="钨金" then
        if 数量==nil then
            数量=1
        end
        假道具.可叠加=true
        if 参数~=nil then
            假道具.等级=参数
        else
            假道具.等级=160
        end
    elseif 名称=="附魔宝珠"  then
        -- 假道具.可叠加=true
        -- if 假道具.等级 then
        --     假道具.等级 = 假道具.等级
        -- else
            假道具.等级 = tonumber(参数)  or 160
        -- end
        -- if 数量 == nil or 数量 > 99 then 数量 = 1 end
        假道具.数量 = 数量 or 1
        elseif 名称=="珍珠"  then
        假道具.可叠加=false
            假道具.等级 = 假道具.数量

    elseif 名称=="召唤兽内丹" then
        假道具.特效=参数 or 取内丹("低级")
        假道具.可叠加=true

    elseif 名称=="高级召唤兽内丹" then
        假道具.特效=参数 or 取内丹("高级")
        假道具.可叠加=true

    elseif 名称=="魔兽要诀" then
        if 参数==nil then
            假道具.附带技能=取低级要诀()
        elseif 数量==nil then
             假道具.数量=1
        else
            假道具.附带技能=参数
        end
        假道具.可叠加=true
    elseif 名称=="高级魔兽要诀" then
        if 参数==nil then
            假道具.附带技能=取高级要诀()
        elseif 数量==nil then
             假道具.数量=1
        else
            假道具.附带技能=参数
        end
        假道具.可叠加=true
    elseif 名称=="特殊兽诀" or 名称 == "特殊魔兽要诀"  then
        if 参数==nil then
            假道具.附带技能=取碎片特殊要诀()
        elseif 数量==nil then
             假道具.数量=1
        else
            假道具.附带技能=参数
        end
        假道具.可叠加=true
         假道具.名称="特殊魔兽要诀"
    elseif 名称 == "超级魔兽要诀" then
        if 参数==nil then
            假道具.附带技能=取超级要诀()
            elseif 数量==nil then
             假道具.数量=1
        else
            假道具.附带技能=参数
        end
        假道具.可叠加=true
    elseif 名称=="招魂帖" then
        local 随机地图={1208,1040,1501,1070,1040,1226,1092}
        local 临时地图=随机地图[取随机数(1,#随机地图)]
        假道具.地图名称=取地图名称(临时地图)
        假道具.地图编号=临时地图
        local xy=地图处理类.地图坐标[临时地图]:取随机点()
        假道具.x=xy.x
        假道具.y=xy.y
        降妖伏魔:招魂帖(id,假道具.地图编号,假道具.x,假道具.y)
    elseif 名称=="逐妖蛊虫" then
        local 随机地图={1208,1040,1501,1070,1040,1226,1092}
        local 临时地图=随机地图[取随机数(1,#随机地图)]
        假道具.地图名称=取地图名称(临时地图)
        假道具.地图编号=临时地图
        local xy=地图处理类.地图坐标[临时地图]:取随机点()
        假道具.x=xy.x
        假道具.y=xy.y
        降妖伏魔:逐妖蛊虫(id,假道具.地图编号,假道具.x,假道具.y)
    elseif 名称=="点化石" then
        假道具.附带技能 = 假道具.技能 or 参数 or "感知"
    elseif  名称=="九转金丹" then
        假道具.阶品 = 参数 or 100 or 200 or 300
        假道具.可叠加 = true
    elseif 名称=="月华露" then
        假道具.阶品=  7000
        if 神话 then 假道具.阶品 = 3000 end
        假道具.可叠加 = true
    -- elseif 名称=="五味露" then
    --  假道具.阶品=数量 or 500
    --  假道具.可叠加 = false
    elseif 名称=="藏宝图" or 名称=="高级藏宝图" or 名称=="玲珑宝图" then
        local 随机地图={1501,1506,1092,1091,1110,1142,1514,1174,1173,1146,1208}
        local 临时地图=随机地图[取随机数(1,#随机地图)]
        假道具.地图名称=取地图名称(临时地图)
        假道具.地图编号=临时地图
        local xy=地图处理类.地图坐标[临时地图]:取随机点()
        假道具.x=xy.x
        假道具.y=xy.y
    elseif 名称=="上古锻造图策" then
        if 数量 and type(数量) == "table" then
            假道具.等级=数量[取随机数(1,#数量)]*10-5
        else
            local 等级=玩家数据[id].角色.等级
            local lv = math.min(qz(等级/10),15)
            local nm={lv+1,lv+2}
            假道具.等级=nm[取随机数(1,#nm)]*10-5
        end
        -- 假道具.等级=数量[取随机数(1,#数量)]*10-5
        假道具.种类=图策范围[取随机数(1,#图策范围)]
    elseif 名称=="炼妖石" then
        if 数量 and type(数量) == "table" then
            假道具.等级=数量[取随机数(1,#数量)]*10-5
        else
            local 等级=玩家数据[id].角色.等级
            local lv = math.min(qz(等级/10),13)
            local nm={lv+1,lv+2}
            假道具.等级=nm[取随机数(1,#nm)]*10-5
        end
        -- 假道具.等级=数量[取随机数(1,#数量)]*10-5
        假道具.分类=3
    elseif 名称=="怪物卡片" then
        if 变身卡数据[数量]==nil then
            if 数量 >= 9 then 数量 = 9 end
            假道具.等级=数量
            假道具.造型=变身卡范围[数量][取随机数(1,#变身卡范围[数量])]
        else
            假道具.等级=变身卡数据[数量].等级
            假道具.造型=数量
        end
        假道具.类型=变身卡数据[假道具.造型].类型
        假道具.单独=变身卡数据[假道具.造型].单独
        假道具.正负=变身卡数据[假道具.造型].正负
        假道具.技能=变身卡数据[假道具.造型].技能
        假道具.属性=变身卡数据[假道具.造型].属性
        假道具.次数=假道具.等级
    elseif 名称=="如意丹" then
        假道具.灵气 = 灵性
        假道具.可叠加 = true
    elseif 名称=="龙之筋" then
        假道具.五行 = 取五行()
    elseif 名称=="天蚕丝" then
        假道具.五行 = "金"
    elseif 名称=="阴沉木" then
        假道具.五行 = "木"
    elseif 名称=="玄龟板" then
        假道具.五行 = 取五行()
    elseif 名称=="麒麟血" then
        假道具.五行 = 取五行()
    elseif 名称=="补天石" then
        假道具.五行 = 取五行()
    elseif 名称=="金凤羽" then
        假道具.五行 =取五行()
    elseif 名称=="内丹" then
        假道具.五行 =取五行()
    elseif 名称 == "秘制食谱" then
        假道具.子类 =参数
    elseif 名称 == "祈愿宝箱" then
        假道具.次数 =数量
    elseif 临时道具.总类==3 and  临时道具.分类==11 then  --{"天眼珠","三眼天珠","九眼天珠"}
        假道具.灵气=取随机数(10,100)
        假道具.等级 = 数量
    elseif 临时道具.总类==5 and  临时道具.分类==4 then
        if 数量 == nil then
            假道具.等级=1
        else
            假道具.等级=数量+0
        end
    elseif 临时道具.总类==5 and  临时道具.分类==6 then --宝石
        if 数量 == nil then
            假道具.等级=1
        else
            假道具.等级=数量+0
        end
    elseif 临时道具.总类==1 and 临时道具.子类==1 and 临时道具.分类==4 then
        假道具.阶品=参数
    elseif 名称=="金创药" or 名称=="红雪散" or 名称=="小还丹"  or 名称=="千年保心丹" or 名称=="金香玉" or 名称=="风水混元丹" or 名称=="蛇蝎美人" or 名称=="定神香" or 名称=="佛光舍利子" or 名称=="九转回魂丹" or 名称=="五龙丹" or 名称=="十香返生丸"  then
        假道具.阶品=参数 or 取随机数(30,50)
    elseif 名称=="醉仙果" or 名称=="七珍丸" or 名称=="凝气丸"  or 名称=="舒筋活络丸" or 名称=="固本培元丹" or 名称=="九转续命丹" or 名称=="十全大补丸"  then
        假道具.阶品=参数 or 取随机数(25,35)
    end
    if 假道具 and 假道具.名称 then
        if 假道具.可叠加 then
            if 数量 == nil then --测试？
                假道具.数量=1
            else
                假道具.数量=数量 or 1
            end
        end
    end
    if  假道具.名称=="心魔宝珠" then
        假道具.不可交易=true
    end
    if 专用~=nil then
        假道具.专用=id
        假道具.不可交易=true
    end
    if 限时 then
        local expiration_timestamp = 限时时间设置(限时)
        假道具.限时时间 = expiration_timestamp
    end
    假道具.识别码=识别码
    return 假道具
end

function 道具处理类:系统给予处理(连接id,id,数据)
    local 事件=玩家数据[id].给予数据.事件
    local 临时NPC=玩家数据[id].给予数据.临时NPC
    local 任务编号=玩家数据[id].给予数据.任务编号
    local 类型 = 数据.类型
    if 事件 ~= nil and 事件~="法宝补充灵气" and  (数据.格子[1]==nil or 玩家数据[id].角色[类型][数据.格子[1]]==nil or self.数据[玩家数据[id].角色[类型][数据.格子[1]]]==nil) then
        常规提示(id,"#Y/你没有这样的道具")
        return
    end
    if 类型 ~= "行囊" and 类型 ~= "道具" and 类型 ~= "任务包裹" and 类型 ~= "法宝" then
        return
    end

    if 事件=="打造角色装备" then
        local 任务id=玩家数据[id].角色:取任务(5)
        if 任务id==0 then
            常规提示(id,"#Y/你没有这样的任务")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称~=任务数据[任务id].石头 then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        end
        if 任务数据[任务id].数量>1 and self.数据[道具id].数量<任务数据[任务id].数量 then
            常规提示(id,"#Y/该物品的数量无法达到要求")
            return
        end
        if 任务数据[任务id].数量>1 then
            self.数据[道具id].数量=self.数据[道具id].数量-任务数据[任务id].数量
        end
        if self.数据[道具id].数量==nil or self.数据[道具id].数量<=0 then
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        if 任务数据[任务id].打造类型=="装备" then
            装备处理类:添加强化打造装备(id,任务id)
        elseif 任务数据[任务id].打造类型=="神兵苏醒" then
            装备处理类:打造160神兵(id,任务id)
        elseif 任务数据[任务id].打造类型=="灵饰" then
            local 临时道具 = self:灵饰处理(id,任务数据[任务id].名称,任务数据[任务id].级别,1,任务数据[任务id].部位)
            临时道具.制造者 = 任务数据[任务id].制造者
            if self:给予道具(id,nil,nil,nil,nil,nil,临时道具) then
                玩家数据[id].角色:取消任务(任务id)
                任务数据[任务id]=nil
            end
        end
        return
    elseif 事件=="购买玩家打造" then
        if 数据.格子[1] == nil or 数据.格子[2] == nil then
            常规提示(id,"#Y/请放入你要打造的书和铁")
            return
        elseif 玩家数据[id].给予数据 == nil or 玩家数据[id].给予数据.制造数据 == nil then
            常规提示(id,"#Y/数据错误请重新购买操作")
            return
        end
        装备处理类:摊位打造装备(id,数据)
        return
    elseif 临时NPC~=nil then
        -- 玩家数据[玩家id].给予数据={类型=1,临时NPC="竹罗汉",物品="包子",任务id=任务id}
        if 任务数据[玩家数据[id].给予数据.任务id]==nil then
            return
        end
        local 任务id=玩家数据[id].给予数据.任务id
        local 物品名称=玩家数据[id].给予数据.物品
        local NPC名称=任务数据[任务id].名称
        if 临时NPC==NPC名称 then
            local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
            if self.数据[道具id].名称==物品名称 then
                if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
                    self.数据[道具id].数量 = self.数据[道具id].数量 -1
                else
                    self.数据[道具id]=nil
                    玩家数据[id].角色[类型][数据.格子[1]]=nil
                end
                if 临时NPC=="竹罗汉" and 事件 == "副本五更寒给予签文" then
                    local 副本id = 任务处理类:取副本id(id,670)
                    if 副本id == 0 or 副本id ~= id  then
                        return
                    end
                    副本数据.如梦奇谭之五更寒.进行[id].阶段=1
                    刷新任务670(id)
                end
            else
                添加最后对话(id,"你要给我什么？")
            end
            return
        end

    elseif 事件=="五行年兽上交物品" then
            local 任务id=玩家数据[id].角色:取任务(58)
            if 任务id==0 or 任务数据[任务id]==nil then
              常规提示(id,"#Y/你没有这样的任务")
              return
            end
            local 队伍组 = 任务数据[任务id].队伍组
            if 玩家数据[id].队伍 == 0 then
              常规提示(id,"#Y/该任务为组队任务，请组齐你的队员再来吧")
              return
            end
            local 队伍id = 玩家数据[id].队伍
            for i=1,#队伍组 do
              local 找到 = false
              for n=1,#队伍数据[队伍id].成员数据 do
                if 队伍数据[队伍id].成员数据[n] == 队伍组[i] then
                  找到=true
                  break
                end
              end
              if 找到 == false then
                常规提示(id,"#Y/该任务为组队任务，请组齐你领取任务时的队员再来吧")
                return
              end
            end
            local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
            if self.数据[道具id].名称~=任务数据[任务id].物品 then
              常规提示(id,"#Y/对方需要的不是这种物品")
              return
            elseif 任务数据[任务id].等级 and  self.数据[道具id].子类 ~= 任务数据[任务id].等级 and self.数据[道具id].级别限制 ~= 任务数据[任务id].等级 then
              常规提示(id,"#Y/对方需要的不是这种等级的物品")
              return
            elseif self.数据[道具id].名称 ~= "制造指南书" and 任务数据[任务id].参数 and self.数据[道具id].子类 ~= 任务数据[任务id].参数 and self.数据[道具id].特效 ~= 任务数据[任务id].参数 and self.数据[道具id].附带技能 ~= 任务数据[任务id].参数 then
              常规提示(id,"#Y/对方需要的不是这种类型的物品")
              return
            elseif self.数据[道具id].名称 == "制造指南书" and 制造指南书数据[self.数据[道具id].特效] ~= 任务数据[任务id].参数 then
              常规提示(id,"#Y/对方需要的不是这种类型的制造指南书")
              return
            end
            if self.数据[道具id].数量 then
              self.数据[道具id].数量 = self.数据[道具id].数量 - 1
              if self.数据[道具id].数量 <= 0 then
                self.数据[道具id]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
              end
            else
              self.数据[道具id]=nil
              玩家数据[id].角色[类型][数据.格子[1]]=nil
            end
            for n=1,#队伍数据[队伍id].成员数据 do
              玩家数据[队伍数据[队伍id].成员数据[n]].角色.嘉年华积分 = 玩家数据[队伍数据[队伍id].成员数据[n]].角色.嘉年华积分 + 1
              常规提示(队伍数据[队伍id].成员数据[n],"#Y/你完成了本环任务，获得了1点嘉年华积分")
            end
            五行年兽:完成五行年兽任务(id,任务id)
            self:索要道具更新(id,类型)





    elseif 事件=="本命法宝一孔镶嵌" then
        if 数据.格子[1] == nil then
            常规提示(id,"#Y/请放入你要给予的本命法宝秘籍")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if  self.数据[道具id].名称~="本命法宝门派秘籍"  then
            常规提示(id,"#Y/只有本命法宝门派秘籍才可使用")
            return
        end
        if not  self.数据[道具id].技能 then
            常规提示(id,"#Y/当前秘籍未鉴定属性，请右键鉴定后再进行镶嵌")
                 return
        end
        if  self.数据[道具id].门派~= 玩家数据[id].角色.门派 then
            常规提示(id,"#Y/当前门派秘籍不对应，无法进行镶嵌")
                 return
        end
            玩家数据[id].角色.本命法宝.额外格子[1]={属性=self.数据[道具id].技能,数值=self.数据[道具id].数值}
            常规提示(id,"#Y/镶嵌#G"..self.数据[道具id].技能.."："..self.数据[道具id].数值.."#Y成功")
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
            发送数据(连接id,3699)--刷新道具

    elseif 事件=="本命法宝二孔镶嵌" then
        if 数据.格子[1] == nil then
            常规提示(id,"#Y/请放入你要给予的本命法宝秘籍")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if  self.数据[道具id].名称~="本命法宝门派秘籍"  then
            常规提示(id,"#Y/只有本命法宝门派秘籍才可使用")
            return
        end
        if not  self.数据[道具id].技能 then
            常规提示(id,"#Y/当前秘籍未鉴定属性，请右键鉴定后再进行镶嵌")
                 return
        end
        if  self.数据[道具id].门派~= 玩家数据[id].角色.门派 then
            常规提示(id,"#Y/当前门派秘籍不对应，无法进行镶嵌")
                 return
        end
            玩家数据[id].角色.本命法宝.额外格子[2]={属性=self.数据[道具id].技能,数值=self.数据[道具id].数值}
            常规提示(id,"#Y/镶嵌#G"..self.数据[道具id].技能.."："..self.数据[道具id].数值.."#Y成功")

            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
            发送数据(连接id,3699)--刷新道具

    elseif 事件=="本命法宝三孔镶嵌" then
        if 数据.格子[1] == nil then
            常规提示(id,"#Y/请放入你要给予的本命法宝秘籍")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if  self.数据[道具id].名称~="本命法宝门派秘籍"  then
            常规提示(id,"#Y/只有本命法宝门派秘籍才可使用")
            return
        end
        if not  self.数据[道具id].技能 then
            常规提示(id,"#Y/当前秘籍未鉴定属性，请右键鉴定后再进行镶嵌")
                 return
        end
        if  self.数据[道具id].门派~= 玩家数据[id].角色.门派 then
            常规提示(id,"#Y/当前门派秘籍不对应，无法进行镶嵌")
                 return
        end
            玩家数据[id].角色.本命法宝.额外格子[3]={属性=self.数据[道具id].技能,数值=具体数值,数值=self.数据[道具id].数值}
            常规提示(id,"#Y/镶嵌#G"..self.数据[道具id].技能.."："..self.数据[道具id].数值.."#Y成功")
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
            发送数据(连接id,3699)--刷新道具
    elseif 事件 == "上交灵符" then
                local 道具id = 玩家数据[id].角色[类型][数据.格子[1]]
                if self.数据[道具id].名称~="上古灵符"  then
                    添加最后对话(id,"我只要上古灵符")
                    return
                elseif self.数据[道具id].总类~=151  and self.数据[道具id].分类~=12  then
                    添加最后对话(id,"这是什么东西，我不需要")
                    return
                end
                local 数量=数据.数量[1]+0
                local 灵符进度=数量*1
                if 数量>1 and self.数据[道具id].数量<数量 then
                    常规提示(id,"#Y/该物品的数量无法达到要求")
                    return
                end
                if 武神山数据[id]==nil then
                    武神山数据[id]={祈神值=0}
                end
                武神山数据.全服祈神值=武神山数据.全服祈神值+灵符进度
                写出文件([[sql/武神山数据.txt]],table.tostring(武神山数据))
                local 等级=玩家数据[id].角色.等级
                local 经验=qz((等级*等级*10)*数量)
                local 银子=qz((等级*等级*5)*数量)
                玩家数据[id].角色:添加经验(经验*HDPZ["战神任务单人"].经验,"战神任务单人")
                玩家数据[id].角色:添加银子(银子*HDPZ["战神任务单人"].银子,"战神任务单人",1)
                常规提示(id,"#Y你上交了#R"..数量.."#Y个"..self.数据[道具id].名称.."，增加了#R"..灵符进度.."#Y点祈神值。")
                if 数量>=1 then
                    self.数据[道具id].数量=self.数据[道具id].数量-数量
                end
                if self.数据[道具id].数量==nil or self.数据[道具id].数量<=0 then
                    self.数据[道具id]=nil
                    玩家数据[id].角色[类型][数据.格子[1]]=nil
                end
                for i=1,数量 do
                    local 奖励参数=取随机数()
                    if 取随机数()<=HDPZ["战神任务单人"].爆率 then
                        local 链接 = {提示=format("#S(战神任务单人)#Y祝贺#G/%s#Y上交上古灵符！喜获",玩家数据[id].角色.名称),频道="hd",结尾="#W！#80"}
                                        local 名称,数量,参数=糖果生成产出(糖果产出物品计算(HDPZ["战神任务单人"].ITEM),"战神任务单人")
                                        if 数量== 9999 then --环
                                            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
                                        elseif 数量== 8888 then
                            数量=nil
                            玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接,名称)
                                        else
                                                    玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
                                        end
                    end
                end
                if 武神山数据~=nil then
                    if 武神山数据.全服祈神值~=nil then
                        if 武神山数据.全服祈神值>=蚩尤祈福值 then
                            广播消息({内容=format("#Y/全服祈神值已满，蚩尤降临挑战现在开放，请各路英雄前往朱紫国皇宫挑战#46"),频道="xt"})
                            发送公告("#Y/全服祈神值已满，蚩尤降临挑战现在开放，请各路英雄前往朱紫国皇宫挑战")
                        end
                    end
                end
                道具刷新(id)
    elseif 事件=="上交心魔宝珠" then
        if 玩家数据[id].角色.等级>=100 then
            常规提示(id,"#Y/你已经脱离了新手阶段，无法获得此种奖励")
            return
        elseif 玩家数据[id].角色.等级<15 then
            常规提示(id,"#Y/只有等级达到15级的玩家才可获得此种奖励")
            return
        elseif 心魔宝珠[id]~=nil and 心魔宝珠[id]>=20 then
            常规提示(id,"#Y/请明天再来上交心魔宝珠")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称="心魔宝珠"
        local 数量=20
        if self.数据[道具id].名称~=名称 then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        end
        if 数量>1 and self.数据[道具id].数量<数量 then
            常规提示(id,"#Y/该物品的数量无法达到要求")
            return
        end
        if 数量>1 then
            self.数据[道具id].数量=self.数据[道具id].数量-数量
        end
        if self.数据[道具id].数量==nil or self.数据[道具id].数量<=0 then
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        local 等级=取等级(id)
        local 经验=等级*等级+3000
        local 储备=等级*1000
        玩家数据[id].角色:添加经验(经验,"心魔宝珠奖励")
        玩家数据[id].角色:添加银子(储备,"心魔宝珠奖励",1)
        if 心魔宝珠[id]==nil then
            心魔宝珠[id]=1
        else
            心魔宝珠[id]=心魔宝珠[id]+1
        end
        常规提示(id,format("#Y/你本日还可领取#R/%s#Y/次奖励",(20-心魔宝珠[id])))
        self:索要道具更新(id,类型)
    elseif 事件=="降妖伏魔给予包子" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称=="包子" then
            if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
                self.数据[道具id].数量 = self.数据[道具id].数量 -1
            else
                self.数据[道具id]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
            end
            降妖伏魔:完成饿鬼(id,玩家数据[id].给予数据.任务id)
        else
            添加最后对话(id,"你给我什么玩意儿，忽悠鬼呢？")
        end
        return
    elseif 事件=="转换武器造型" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].总类==2 and self.数据[道具id].分类 == 3  then
            if 武器转换临时数据[id]~= nil then
                local 消耗 = 全局基础数据.装备转换消耗
                if not 玩家数据[id].角色:扣除银子(消耗,0,0,"转换武器造型",1) then
                    return 添加最后对话(id,"需要支付"..消耗.."两银子才可以转换此类道具")
                end
                local 序列 = 1
                local 等级 = self.数据[道具id].等级
                if 等级 <= 80 then
                    序列 = 等级/10 + 1
                elseif 等级<= 110 then
                    序列 = 取随机数(10,12)
                elseif 等级<= 140 then
                    序列 = 取随机数(13,15)
                elseif 等级<= 150 then
                    序列 = 16
                else
                    序列 = 17
                end
                self.数据[道具id].名称 = 武器表[武器转换临时数据[id]][序列]
                local 临时武器数据 = 取物品数据(self.数据[道具id].名称)
                self.数据[道具id].子类 = 临时武器数据[4]
                self.数据[道具id].角色限制 = 临时武器数据[7]
                道具刷新(id)
                添加最后对话(id,"转换成功！")
            else
                添加最后对话(id,"转换失败，请重试！")
            end
        else
            添加最后对话(id,"你给我什么玩意儿？")
        end
        return
    elseif 事件=="解除专用" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].总类==2 then
            local 消耗 = 全局基础数据.装备解绑消耗
            if not 玩家数据[id].角色:扣除仙玉(消耗, "解除专用")  then
                return 添加最后对话(id,"需要支付"..消耗.."仙玉才可以解除专用")
            end
            self.数据[道具id].专用 = nil
            道具刷新(id)
            添加最后对话(id,"解除成功！")
        else
            添加最后对话(id,"你给我什么玩意儿？")
        end
        return
    elseif 事件=="转换装备" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].总类==2 and self.数据[道具id].子类~=911 then
            local 子类=self:取武器类型(玩家数据[id].给予数据.转换造型)
            玩家数据[id].角色:转换装备操作(id,self.数据[道具id],子类)
        else
            添加最后对话(id,"请给我正确的装备")
        end
        return
    elseif 事件=="降妖伏魔给予酒" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称=="女儿红" or self.数据[道具id].名称=="虎骨酒" or self.数据[道具id].名称=="珍露酒"
              or self.数据[道具id].名称=="梅花酒" or self.数据[道具id].名称=="百味酒" or self.数据[道具id].名称=="蛇胆酒" or self.数据[道具id].名称=="醉生梦死" then

            if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
                self.数据[道具id].数量 = self.数据[道具id].数量 -1
            else
                self.数据[道具id]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
            end
            降妖伏魔:完成酒鬼(id,玩家数据[id].给予数据.任务id)
        else
            添加最后对话(id,"你给我什么玩意儿，忽悠鬼呢？")
        end
        return
    elseif 事件=="兑换锦衣" then
         local 道具id
         if  玩家数据[id].角色[类型][数据.格子[1]]~=nil then
                道具id=玩家数据[id].角色[类型][数据.格子[1]]
            end
            if 玩家数据[id].角色[类型][数据.格子[2]]~=nil then
                道具id=玩家数据[id].角色[类型][数据.格子[2]]
            end
            if 玩家数据[id].角色[类型][数据.格子[3]]~=nil then
                道具id=玩家数据[id].角色[类型][数据.格子[3]]
        end
        if self.数据[道具id].名称 ~= "彩果"  or  self.数据[道具id]==nil  or self.数据[道具id].数量 <99 then
            常规提示(id,"#Y/请放入彩果")
            return
        end
        -- local 数量 = 99
        local 给与名称 ={"青花瓷月黑","青花瓷月白","齐天大圣月黑","齐天大圣月白","灼灼韶华","黑麒麟","胖胖龙","锦鲤","青花瓷","浮生","萌龙咆哮","龙行雨泽"}
        local 获得名称=给与名称[取随机数(1,#给与名称)]

        -- if self.数据[道具id].数量~= 99 then
        --     数量 = self.数据[道具id].数量
        -- end
        if self.数据[道具id].数量 and self.数据[道具id].数量 >=99 then
            self.数据[道具id].数量 = self.数据[道具id].数量-99
        else

        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        玩家数据[id].道具:给予道具(id,获得名称,1,nil,"不存共享")
        self:索要道具更新(id,类型)

    elseif 事件=="上交暑假道具" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称 ~= "知了" and self.数据[道具id].名称 ~= "蟋蟀" and self.数据[道具id].名称 ~= "小螃蟹"  then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        end
        local 数量 = 1
        if self.数据[道具id].数量~= nil then 数量 = self.数据[道具id].数量 end
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        local 储备=20000*数量
        玩家数据[id].角色:添加银子(储备,"上交暑假道具",1)
        self:索要道具更新(id,类型)
    elseif 事件=="更换指南造型" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称 ~= "制造指南书" or self.数据[道具id].特效 > 18 then
            常规提示(id,"#Y/只有武器类的指南书才可以更换")
            return
        end
        if 玩家数据[id].角色.银子 < self.数据[道具id].子类 *10000 then
            常规提示(id,"#Y/你的银两不足")
            return
        end
        if 玩家数据[id].角色:扣除银子(self.数据[道具id].子类 *10000,0,0,"更换指南造型",1) and 玩家数据[id].角色:扣除仙玉(100, "更换指南造型") then
            self.数据[道具id].特效=取随机数(1,18)
            self:索要道具更新(id,类型)
        end
    elseif 事件=="指南2换1" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 道具id2=玩家数据[id].角色[类型][数据.格子[2]]
        if 数据.格子[1]==nil or 数据.格子[2]==nil then
            常规提示(id,"#Y/物品数据错误请重新放置")
            return
        end
        if self.数据[道具id].子类 ~= self.数据[道具id2].子类 then
            常规提示(id,"两本书的等级不一样无法更换")
            return
        end
        if self.数据[道具id].名称 ~= "制造指南书" or self.数据[道具id2].名称 ~= "制造指南书" then
            常规提示(id,"#Y/只有制造指南书才能换")
            return
        end
        self.数据[道具id].特效=取随机数(1,25)
        self.数据[道具id2]=nil
        玩家数据[id].角色[类型][数据.格子[2]]=nil
        self:索要道具更新(id,类型)
        常规提示(id,"#Y/您的指南更换成功请查看背包")
    elseif 事件=="裁缝/炼金熟练度" or 事件=="打造/淬灵熟练度" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称 ~= "制造指南书" then
            if self.数据[道具id].名称 ~= "百炼精铁" then
                常规提示(id,"#Y/我不需要这个东西")
                return
            end
        end
        if 事件=="裁缝/炼金熟练度"  then
            玩家数据[id].角色:增加生活技能熟练("裁缝技巧",self.数据[道具id].子类/10)
            消息提示(id,"#Y/你上交了#R/"..self.数据[道具id].名称.."#Y/熟练度增加了#R"..self.数据[道具id].子类/10)
        else
            玩家数据[id].角色:增加生活技能熟练("打造技巧",self.数据[道具id].子类/10)
            消息提示(id,"#Y/你上交了#R/"..self.数据[道具id].名称.."#Y/熟练度增加了#R/"..self.数据[道具id].子类/10)
        end
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        self:索要道具更新(id,类型)
    elseif 事件=="我来归还勾魂索。" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称 ~= "无常勾魂索" then
            常规提示(id,"#Y/你给我的是什么玩意儿？")
            return
        end
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        玩家数据[id].已扣除勾魂索=nil --购买后上交，会清空一次这个东西 不然出问题很麻烦
        玩家数据[id].勾魂索中=nil --购买后上交，会清空一次这个东西 不然出问题很麻烦
        self:索要道具更新(id,类型)
        玩家数据[id].角色:添加银子(5000000,"归还勾魂索",1)
    elseif 事件=="官职任务上交物品" then
        local 任务id=玩家数据[id].角色:取任务(110)
        if 任务id==0 or 任务数据[任务id]==nil then
            常规提示(id,"#Y/你没有这样的任务")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称="？？？"
        if 任务数据[任务id].分类==3 then
            名称="情报"
        elseif 任务数据[任务id].分类==4 then
            名称=任务数据[任务id].物品
        end
        if self.数据[道具id].名称~=名称 then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        end
        if self.数据[道具id].数量 and self.数据[道具id].数量 >=2 then
            self.数据[道具id].数量 = self.数据[道具id].数量-1
        else
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        完成任务_110(id,任务数据[任务id].分类)
        self:索要道具更新(id,类型)
    elseif 事件=="法宝上交物品1" then
        local 任务id=玩家数据[id].角色:取任务(39)
        if 任务id==0 or 任务数据[任务id]==nil then
          常规提示(id,"#Y/你没有这样的任务")
          return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称=任务数据[任务id].物品
        if self.数据[道具id].名称~=名称 then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        end
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        法宝任务:完成法宝任务(id,任务id)
        self:索要道具更新(id,类型)
    elseif 事件=="法宝上交物品2" then
        local 任务id=玩家数据[id].角色:取任务(40)
        if 任务id==0 or 任务数据[任务id]==nil then
            常规提示(id,"#Y/你没有这样的任务")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称=任务数据[任务id].物品
        if self.数据[道具id].名称~=名称 then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        end
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        法宝任务:完成法宝任务(id,任务id)
        self:索要道具更新(id,类型)
    elseif 事件=="门派任务上交物品" then
        local 任务id=玩家数据[id].角色:取任务(111)
        if 任务id==0 or 任务数据[任务id]==nil then
            常规提示(id,"#Y/你没有这样的任务")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称=任务数据[任务id].物品
        if self.数据[道具id].名称~=名称 then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        end
        local 双倍
        if 任务数据[任务id].品质~=nil and self.数据[道具id].阶品>=任务数据[任务id].品质 then
            双倍=1
        end
        if  self.数据[道具id].数量~=nil and self.数据[道具id].数量 >=2 then
            self.数据[道具id].数量 = self.数据[道具id].数量-1
        else
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        完成任务_111(id,4,双倍)
        self:索要道具更新(id,类型)
    elseif 事件=="门派任务上交乾坤袋" then
        local 任务id=玩家数据[id].角色:取任务(111)
        if 任务id==0 or 任务数据[任务id]==nil then
            常规提示(id,"#Y/你没有这样的任务")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称="乾坤袋"
        if self.数据[道具id].名称~=名称 then
            常规提示(id,"#Y/对方需要的不是这种物品")
            return
        elseif 任务数据[任务id].乾坤袋==nil then
            常规提示(id,"#Y/你似乎还没有完成这个任务哟~")
            return
        end
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        完成任务_111(id,7,双倍)
        self:索要道具更新(id,类型)
  elseif 事件 == '铸斧(乾)' or 事件 == '铸斧(坤)' then
                   local 道具id = 玩家数据[id].角色.道具[数据.格子[1]]
        if self.数据[道具id].总类 ~= 2 or self.数据[道具id].分类 ~= 3 then
            添加最后对话(id, "#Y/你交给我的是什么鬼东西？！")
            return
        else
            if 玩家数据[id].角色.门派 ~= "九黎城" then
                if not 玩家数据[id].角色:扣除银子(1000000, 0, 0, "转换九黎副武器", 1) then
                    return
                end
            end

            local aa = {"顽石双斧", "镔铁双斧", "黑曜双斧", "枭首双斧", "破军双斧", "隳城双戚", "飞头蛮", "竹叶青", "鲛煞", "啖月", "义战", "恶来", "烬世野火", "九州海沸", "八狱末劫", "罗喉计都", "非天"}
            local 武器名称 = aa[self.数据[道具id].等级 / 10 + 1]
            self.数据[道具id].原始造型 = self.数据[道具id].名称
            if 事件 == "铸斧(乾)" then
                武器名称 = 武器名称 .. "(乾)"
                添加最后对话(id, "我已将这把 (" .. self.数据[道具id].原始造型 .. ") 重铸成 (" .. 武器名称 .. ") 、怎么样，我的铸兵术厉害吧！")
                 if self.数据[道具id].套装效果 ~= nil  then
                        self.数据[道具id].套装效果 = nil
                        常规提示(self.玩家id,"#Y你装备上的套装效果消失了！")
                    end
            else
                -------------------------------C改
                 if self.数据[道具id].临时附魔 ~= nil  then
                for k,v in pairs(self.数据[道具id].临时附魔) do
                    if v.数值  then
                        玩家数据[self.玩家id].角色:清除装备附魔属性(self.数据[道具id],self.数据[道具id].分类,k,v.数值)
                        self.数据[道具id].临时附魔[k] = nil
                        常规提示(self.玩家id,"#Y你装备上的附魔特效消失了！")
                    end
                    end
                end
                -------------------------------C改
                武器名称 = 武器名称 .. "(坤)"
                添加最后对话(id, "我已将这把 (" .. self.数据[道具id].原始造型 .. ") 重铸成 (" .. 武器名称 .. ") 、怎么样，我的铸兵术厉害吧！")
            end
            self.数据[道具id].名称 = 武器名称
            if self.数据[道具id].光武拓印 then
                self.数据[道具id].原始光武拓印 = self.数据[道具id].光武拓印
                self.数据[道具id].光武拓印 = nil
            end


            local sj = 取物品数据(self.数据[道具id].名称)
            self.数据[道具id].分类 = sj[3]
            self.数据[道具id].子类 = sj[4]
            self.数据[道具id].角色限制 = sj[7]
            self.数据[道具id].防御=nil
            --self.数据[道具id].右手武器 = true  ----右手武器
            常规提示(id, "#Y/你获得了#P" .. 武器名称)
            self:索要道具更新(id,类型,分页)
        end
    elseif 事件 == '还原武器' then
      local 道具id = 玩家数据[id].角色.道具[数据.格子[1]]
        if not self.数据[道具id] or self.数据[道具id].总类 ~= 2 or  self.数据[道具id].原始造型 == nil  then
            添加最后对话(id, "#Y/你交给我的是什么鬼东西？！")
            return
        else
            -- if 玩家数据[id].角色.门派 ~= "九黎城" then
            --     添加最后对话(id, "#Y/你不是本门弟子哦！")
            -- return
            -- end
            if not 玩家数据[id].角色:扣除银子(1000000, 0, 0, "九黎副武器还原", 1) then
                return
            end
             if self.数据[道具id].套装效果 ~= nil  then
                        self.数据[道具id].套装效果 = nil
                        常规提示(self.玩家id,"#Y你装备上的套装效果消失了！")
             end
            添加最后对话(id, "我已将这把 (" .. self.数据[道具id].名称 .. ") 重铸成 (" .. self.数据[道具id].原始造型 .. ") 、怎么样，我的铸兵术厉害吧！")
            self.数据[道具id].名称 = self.数据[道具id].原始造型 .. ""
            self.数据[道具id].光武拓印 = self.数据[道具id].原始光武拓印
            self.数据[道具id].原始造型 = nil
            self.数据[道具id].分类 = 3
            local sj = 取物品数据(self.数据[道具id].名称)
            self.数据[道具id].子类 = sj[4] + 0
            self.数据[道具id].角色限制 = sj[7]
            常规提示(id, "#Y/你获得了#P" .. self.数据[道具id].名称)
            self:索要道具更新(id,类型,分页)
        end
    elseif 事件=="偷偷怪上交物品" then

                添加最后对话(id,"#G 吊毛，自己背包右键合成就好了")

    elseif 事件=="低内丹二换一" then
        local dj={}
        local num=0
        for i=1,2 do
            if 数据.格子[i]~=nil then
                dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
                if self.数据[dj[i]]==nil then
                    添加最后对话(id,"#45#45#45")
                    return
                end
                if self.数据[dj[i]].名称~="召唤兽内丹" then
                    添加最后对话(id,"一次性给两颗你想兑换的#Y“召唤兽内丹”#W即可兑换一颗新的召唤兽内丹")
                    return
                end
                num=num+1
            else
                添加最后对话(id,"一次性给两颗你想兑换的#Y“召唤兽内丹”#W即可兑换一颗新的召唤兽内丹")
                return
            end
        end
        if num==2 then
            for i=1,2 do
                self.数据[dj[i]]=nil
                玩家数据[id].角色[类型][数据.格子[i]]=nil
            end
            self:给予道具(id,"召唤兽内丹",1,nil,"不存共享")
            添加最后对话(id,"嗯嗯~不错不错~待我施展法力…@………~&，变#113#Y1颗召唤兽内丹#W已经放进你的兜兜里啦~#109")
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)
    elseif 事件=="高内丹三换一" then
        local dj={}
        local num=0
        for i=1,3 do
            if 数据.格子[i]~=nil then
                dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
                if self.数据[dj[i]]==nil then
                    添加最后对话(id,"#45#45#45")
                    return
                end
                if self.数据[dj[i]].名称~="高级召唤兽内丹" then
                    添加最后对话(id,"一次性给三颗你想兑换的#Y“高级召唤兽内丹”#W即可兑换一颗新的高级召唤兽内丹")
                    return
                end
                num=num+1
            else
                添加最后对话(id,"一次性给三颗你想兑换的#Y“高级召唤兽内丹”#W即可兑换一颗新的高级召唤兽内丹")
                return
            end
        end
        if num==3 then
            for i=1,3 do
                self.数据[dj[i]]=nil
                玩家数据[id].角色[类型][数据.格子[i]]=nil
            end
            self:给予道具(id,"高级召唤兽内丹",1,nil,"不存共享")
            添加最后对话(id,"嗯嗯~不错不错~待我施展法力…@………~&，变#113#Y1颗高级召唤兽内丹#W已经放进你的兜兜里啦~#109")
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)
    elseif 事件=="高兽决三换一" then
        local dj={}
        local num=0
        for i=1,3 do
            if 数据.格子[i]~=nil then
                dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
                if self.数据[dj[i]]==nil then
                    添加最后对话(id,"#45#45#45")
                    return
                end
                if self.数据[dj[i]].名称~="高级魔兽要诀" then
                    添加最后对话(id,"一次性给三本你想兑换的#Y“高级魔兽要诀”#W即可兑换一本新的高级魔兽要诀")
                    return
                end
                num=num+1
            else
                添加最后对话(id,"一次性给三本你想兑换的#Y“高级魔兽要诀”#W即可兑换一本新的高级魔兽要诀")
                return
            end
        end
        if num==3 then
            for i=1,3 do
                self.数据[dj[i]]=nil
                玩家数据[id].角色[类型][数据.格子[i]]=nil
            end
            self:给予道具(id,"高级魔兽要诀",1,nil,"不存共享")
            添加最后对话(id,"嗯嗯~不错不错~待我施展法力…@………~&，变#113#Y1本高级魔兽要诀#W已经放进你的兜兜里啦~#109")
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)
    elseif 事件 == "特殊兽诀三换一" then
        local dj={}
        local num=0
        for i=1,3 do
            if 数据.格子[i]~=nil then
                dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
                if self.数据[dj[i]]==nil then
                    添加最后对话(id,"#45#45#45")
                    return
                end
                local 存在 = false
                for n = 1, #取自选技能 do
                    if 取自选技能[n] == self.数据[dj[i]].附带技能 then
                        存在 = true
                        break
                    end
                end
                if not 存在 then
                    添加最后对话(id,"一次性给三本你想兑换的#Y“特殊兽诀”#W即可兑换一本新的特殊兽诀")
                    return
                end
                num=num+1
            else
                添加最后对话(id,"一次性给三本你想兑换的#Y“特殊兽诀”#W即可兑换一本新的特殊兽诀")
                return
            end
        end
        if num==3 then
            for i=1,3 do
                self.数据[dj[i]]=nil
                玩家数据[id].角色[类型][数据.格子[i]]=nil
            end
            self:给予道具(id,"特殊兽诀", 取碎片特殊要诀(),nil,"不存共享")
            添加最后对话(id,"嗯嗯~不错不错~待我施展法力…@………~&，变#113#Y1本特殊魔兽要诀#W已经放进你的兜兜里啦~#109")
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)
    elseif 事件 == "超级兽诀三换一" then
        local dj={}
        local num=0
        for i=1,3 do
            if 数据.格子[i]~=nil then
                dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
                if self.数据[dj[i]]==nil then
                    添加最后对话(id,"#45#45#45")
                    return
                end
                local 存在 = false
                if 取是否为超级要诀(self.数据[dj[i]].附带技能) then
                    存在 = true
                end
                if not 存在 then
                    添加最后对话(id,"一次性给三本你想兑换的#Y“超级要诀”#W即可兑换一本新的超级兽诀")
                    return
                end
                num=num+1
            else
                添加最后对话(id,"一次性给三本你想兑换的#Y“超级要诀”#W即可兑换一本新的超级兽诀")
                return
            end
        end
        if num==3 then
            for i=1,3 do
                self.数据[dj[i]]=nil
                玩家数据[id].角色[类型][数据.格子[i]]=nil
            end
            self:给予道具(id,"超级魔兽要诀",1,nil,"不存共享")
            添加最后对话(id,"嗯嗯~不错不错~待我施展法力…@………~&，变#113#Y1本超级魔兽要诀#W已经放进你的兜兜里啦~#109")
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)

    elseif 事件=="飞升剧情_太上老君_找药" then
        local go1=false
        if 数据.格子[1]==nil or 数据.格子[2]==nil  then
            添加最后对话(id,"我需要的药引子都找到了吗？")
            return
        end
        if (self.数据[玩家数据[id].角色[类型][数据.格子[1]]].名称=="餐风饮露" and self.数据[玩家数据[id].角色[类型][数据.格子[2]]].名称=="风水混元丹") or (self.数据[玩家数据[id].角色[类型][数据.格子[1]]].名称=="风水混元丹" and self.数据[玩家数据[id].角色[类型][数据.格子[2]]].名称=="餐风饮露")  then
            go1=true
            for i=1,2 do
                self.数据[玩家数据[id].角色[类型][数据.格子[i]]]=nil
                玩家数据[id].角色[类型][数据.格子[i]]=nil
            end
            剧情_飞升:更新任务进程(id,"太上老君")
        else
            添加最后对话(id,"这不是我需要的药引子啊？")
            return
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)
    elseif 事件=="飞升剧情_镇元子_找药" then
        local go1=false
        if 数据.格子[1]==nil or 数据.格子[2]==nil  then
            添加最后对话(id,"我需要的药引子都找到了吗？")
            return
        end
        if (self.数据[玩家数据[id].角色[类型][数据.格子[1]]].名称=="金香玉" and self.数据[玩家数据[id].角色[类型][数据.格子[2]]].名称=="定神香") or (self.数据[玩家数据[id].角色[类型][数据.格子[1]]].名称=="定神香" and self.数据[玩家数据[id].角色[类型][数据.格子[2]]].名称=="金香玉")  then
            go1=true
            for i=1,2 do
                self.数据[玩家数据[id].角色[类型][数据.格子[i]]]=nil
                玩家数据[id].角色[类型][数据.格子[i]]=nil
            end
            剧情_飞升:更新任务进程(id,"镇元子")
        else
            添加最后对话(id,"这不是我需要的药引子啊？")
            return
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)
    elseif 事件=="飞升剧情_玉皇大帝_6法器" then
        local 任务id=玩家数据[id].角色:取任务(9209) --飞升本体
        local 试点单位21={}
        试点单位21["避火诀"]=1
        试点单位21["修篁斧"]=1
        试点单位21["炼金鼎"]=1
        试点单位21["镇海针"]=1
        试点单位21["紫金冠"]=1
        试点单位21["开山钺"]=1

        if 任务id~=0 and 任务数据[任务id].分类=="玉皇大帝找东西" then
            for i=1,3 do
                if 数据.格子[i]~=nil then
                    if self.数据[玩家数据[id].角色[类型][数据.格子[i]]]==nil then
                        添加最后对话(id,"这是我需要的东西吗？")
                        return
                    end
                    -- if self.数据[玩家数据[id].角色[类型][数据.格子[i]]].分类~="飞升物品" then
                    if  试点单位21[ self.数据[玩家数据[id].角色[类型][数据.格子[i]]].名称] then
                    else
                        添加最后对话(id,"这是我需要的东西吗？")
                        return
                    end
                end
            end
            添加最后对话(id,"不错不错，其他的呢？")
            for i=1,3 do
                if 数据.格子[i]~=nil then
                    local 名称=self.数据[玩家数据[id].角色[类型][数据.格子[i]]].名称
                    self.数据[玩家数据[id].角色[类型][数据.格子[i]]]=nil
                    玩家数据[id].角色[类型][数据.格子[i]]=nil
                    剧情_飞升:上交6法器(id,名称)
                    任务数据[任务id].法器数量=任务数据[任务id].法器数量+1
                end
            end
            玩家数据[id].给予数据=nil
            self:索要道具更新(id,类型)
        else
            常规提示(id,"#Y/飞升剧情_玉皇大帝有误！")
            玩家数据[id].给予数据=nil
            self:索要道具更新(id,类型)
            return
        end
    elseif 事件=="飞升剧情_东海龙王_霹雳" then
        if 数据.格子[1]==nil  then
            添加最后对话(id,"我需要的玉龙找到了吗？")
            return
        end
        local 任务id=玩家数据[id].角色:取任务(9214)
        if 任务id~=0 and 任务数据[任务id].子类进程==2 then
            local 名称=self.数据[玩家数据[id].角色[类型][数据.格子[1]]].名称
            if 调试模式 then
                名称="玉龙"
            end
            if 名称=="玉龙" then
                self.数据[玩家数据[id].角色[类型][数据.格子[1]]]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
                剧情_飞升:给予飞升6法器(id,"镇海针")
                任务数据[任务id].子类进程=3
                玩家数据[id].角色:刷新任务跟踪()
                添加最后对话(id,"不错不错！")
            else
                添加最后对话(id,"我需要的霹雳找到了吗？")
                return
            end
        else
            常规提示(id,"#Y/飞升剧情_东海龙王有误！")
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)
    elseif 事件=="飞升剧情_春十三娘_兽决" then
        if 数据.格子[1]==nil  then
            添加最后对话(id,"我需要的兽决找到了吗？")
            return
        end
        local 任务id=玩家数据[id].角色:取任务(9222)
        if 任务id~=0 and 任务数据[任务id].子类进程==2 then
            local 名称=self.数据[玩家数据[id].角色[类型][数据.格子[1]]].名称
            if 名称=="高级魔兽要诀" then
                self.数据[玩家数据[id].角色[类型][数据.格子[1]]]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
                任务数据[任务id].子类进程=3
                玩家数据[id].角色:刷新任务跟踪()
                剧情_飞升:判断魔族任务进度(id)
                添加最后对话(id,"恩，东西不错。我没什么意见了，反正不死壤我也没兴趣。")
            else
                添加最后对话(id,"我需要的兽决找到了吗？")
                return
            end
        else
            常规提示(id,"#Y/飞升剧情_春十三娘有误！")
        end
        玩家数据[id].给予数据=nil
        self:索要道具更新(id,类型)

    elseif 事件=="我要还原装备拓印" then
        local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具1]==nil then
            玩家数据[id].给予数据=nil
            return
        end
        -- if self.数据[道具1].总类~=2 or self.数据[道具1].分类 ~= 3  then
    if (self.数据[道具1].总类~=2 or self.数据[道具1].分类 ~= 3) and (self.数据[道具1].总类~=2 or self.数据[道具1].子类 ~= 911) then
            常规提示(id,"#Y/选择武器有误！")
            return
        end
        if self.数据[道具1].光武拓印 == nil then
            常规提示(id,"#Y/这把武器没有光武拓印啊？")
            return
        end
        local 原造型=self.数据[道具1].光武拓印.原名称
        self.数据[道具1].名称 = 原造型
        self.数据[道具1].光武拓印=nil
        玩家数据[id].给予数据=nil
        添加最后对话(id,"一阵金光闪过，你手中的这把武器变成了#Y"..原造型.."#W的造型#80。")
        self:索要道具更新(id,类型)
    elseif 事件=="增加神兽技能格子" then
        local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
        local 道具2=玩家数据[id].角色[类型][数据.格子[2]]
        if self.数据[道具1]==nil or self.数据[道具2]==nil then
            玩家数据[id].给予数据=nil
            添加最后对话(id,"请将“神兜兜”需要附加技能的“兽决”一起给我吧#24")
            return
        end
        local 名称1=self.数据[道具1].名称
        local 名称2=self.数据[道具2].名称
        local 兽决,兜兜
        local sjgz=1
        if 名称1=="魔兽要诀" or 名称1=="高级魔兽要诀" or 名称1=="特殊魔兽要诀" or 名称1=="超级魔兽要诀" then
            兽决=道具1
        elseif 名称2=="魔兽要诀" or 名称2=="高级魔兽要诀" or 名称2=="特殊魔兽要诀" or 名称2=="超级魔兽要诀" then
            兽决=道具2
            sjgz=2
        end
        if 名称1=="神兜兜" then
            兜兜=道具1
        elseif 名称2=="神兜兜" then
            兜兜=道具2
        end
            if 兽决 ~= nil then
                    local yccjjn=1
                    --local cjjndsxz={[1]=3,[2]=5,[3]=7,[4]=11,[5]=15,[6]=19,[7]=999} --超级技能 打书限制 有0超技要求4技能以上
                    local cjjndsxz={[1]=4,[2]=6,[3]=8,[4]=12,[5]=16,[6]=20,[7]=999}
                    local bh=玩家数据[id].角色:取参战宝宝编号()
                    local 技能数量 = #玩家数据[id].召唤兽.数据[bh].技能
                    for i=1,技能数量 do
                        if string.find(玩家数据[id].召唤兽.数据[bh].技能[i],"超级")~=nil   then
                                yccjjn=yccjjn+1
                            end
                    end
                    if (名称1 == "超级魔兽要诀" or 名称2 == "超级魔兽要诀") and jn ~= "超级神柚复生" then
                            if 技能数量 < cjjndsxz[yccjjn] then --超级技能
                                添加最后对话(id,"需要总技能#R"..cjjndsxz[yccjjn].."#W以上才能学习第#R"..yccjjn.."#W个超级技能（当前"..技能数量.."个技能）")
                                return
                            end
                    end
            end


        if 兽决~=nil and 兜兜~=nil and 兽决~=兜兜 then
            local jn=self.数据[兽决].附带技能
            if jn then
                local bh=玩家数据[id].角色:取参战宝宝编号()
                for i=1,#玩家数据[id].召唤兽.数据[bh].技能 do
                    if 玩家数据[id].召唤兽.数据[bh].技能[i]==jn then
                        常规提示(id,"这只宝宝已经学会了这个技能了。")
                        return
                    end
                end
                local xianzhi=12
                if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" and RpbARGB.序列==2 then
                    xianzhi=12
                elseif 玩家数据[id].召唤兽.数据[bh].种类=="特殊神兽" then
                    xianzhi=16

                end
                if #玩家数据[id].召唤兽.数据[bh].技能<xianzhi then
                    if 玩家数据[id].召唤兽.数据[bh].打书次数==nil then
                        玩家数据[id].召唤兽.数据[bh].打书次数=0
                    end
                    local num=(玩家数据[id].召唤兽.数据[bh].打书次数+1)*10
                    if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" then
                        num=(玩家数据[id].召唤兽.数据[bh].打书次数+1)*20
                    end
                    if 神话 then
                        num = (玩家数据[id].召唤兽.数据[bh].打书次数+1)*50
                        if num >= 250 then num = 250 end
                    end


                    if 玩家数据[id].道具:消耗背包道具(连接id,id,"神兜兜",num) then
                        self.数据[兽决].数量=self.数据[兽决].数量-1
                        if  self.数据[兽决].数量==0 then
                            -- self.数据[兽决]=nil
                            玩家数据[id].角色[类型][数据.格子[sjgz]]=nil
                        end
                        -- 玩家数据[id].角色[类型][数据.格子[sjgz]]=nil
                        玩家数据[id].召唤兽.数据[bh].技能[#玩家数据[id].召唤兽.数据[bh].技能+1]=jn
                        玩家数据[id].召唤兽.数据[bh].打书次数=玩家数据[id].召唤兽.数据[bh].打书次数+1
                        玩家数据[id].召唤兽.数据[bh]:刷新信息("1")
                        常规提示(id,"#G恭喜，您心爱的宝宝领悟了新技能！#Y"..jn.."#G。")
                        道具刷新(id)
                    else
                        添加最后对话(id,"需要"..num.."个“神兜兜”才行哦。")
                    end
                else
                    添加最后对话(id,"只能对小于等于.."..xianzhi.."..技能的宝宝使用。")
                end
            end
        else
            添加最后对话(id,"请将“神兜兜”和需要附加技能的“兽决”一起给我吧#24")
        end
        玩家数据[id].给予数据=nil
        return
    elseif 事件=="技能书增加神兽技能格子" then
        local 道具1 = 玩家数据[id].角色[类型][数据.格子[1]]
        local 道具2 = 玩家数据[id].角色[类型][数据.格子[2]]
        local 道具3 = 玩家数据[id].角色[类型][数据.格子[3]]
        if self.数据[道具1]==nil or self.数据[道具2]==nil or self.数据[道具3]==nil then
            玩家数据[id].给予数据=nil
            添加最后对话(id,"请将“神兜兜”需要附加技能的“兽决”，还有技能书一起给我吧#24")
            return
        end
        local 名称1 = self.数据[道具1].名称
        local 名称2 = self.数据[道具2].名称
        local 名称3 = self.数据[道具3].名称
        local 兽决,兜兜,技能书
        local sjgz=1
        if 名称1=="魔兽要诀" or 名称1=="高级魔兽要诀"or 名称1=="特殊魔兽要诀"or 名称1=="超级魔兽要诀" then
            兽决=道具1
        elseif 名称2=="魔兽要诀" or 名称2=="高级魔兽要诀" or 名称2=="特殊魔兽要诀"or 名称2=="超级魔兽要诀" then
            兽决=道具2
            sjgz=2
        elseif 名称3 == "魔兽要诀" or 名称3 == "高级魔兽要诀" or 名称3=="特殊魔兽要诀"or 名称3=="超级魔兽要诀" then
            兽决=道具3
            sjgz=3
        end
        if 名称1 == "神兜兜" then
            兜兜 = 道具1
        elseif 名称2 == "神兜兜" then
            兜兜 = 道具2
        elseif 名称3 == "神兜兜" then
            兜兜 = 道具3
        end
        if 名称1 == "技能书" then
            技能书 = 道具1
        elseif 名称2 == "技能书" then
            技能书 = 道具2
        elseif 名称3 == "技能书" then
            技能书 = 道具3
        end
        local jn = nil
        if 兽决 ~= nil then
            jn = self.数据[兽决].附带技能
        end

        if 兽决 ~= nil then
            local yccjjn=0
            --local cjjndsxz={[1]=3,[2]=5,[3]=7,[4]=11,[5]=15,[6]=19,[7]=999} --超级技能 打书限制 有0超技要求4技能以上
            local cjjndsxz={[1]=4,[2]=6,[3]=8,[4]=12,[5]=16,[6]=20,[7]=999}
            local bh=玩家数据[id].角色:取参战宝宝编号()
            local 技能数量 = #玩家数据[id].召唤兽.数据[bh].技能
            for i=1,技能数量 do
                if string.find(玩家数据[id].召唤兽.数据[bh].技能[i],"超级")~=nil then
                    yccjjn=yccjjn+1
                end
            end
            if (名称1 == "超级魔兽要诀" or 名称2 == "超级魔兽要诀" or 名称3 == "超级魔兽要诀") then
                if jn ~= "超级神柚复生" and 技能数量 < cjjndsxz[yccjjn] then --超级技能
                    添加最后对话(id,"需要总技能#R"..cjjndsxz[yccjjn].."#W以上才能学习第#R"..yccjjn.."#W个超级技能（当前"..技能数量.."个技能）")
                    return
                end
            end
        end

        if 兽决~=nil and 兜兜~=nil and 技能书 ~= nil and 兽决~=兜兜 and 兽决 ~= 技能书 and 兜兜 ~= 技能书 then
            if jn then
                local bh=玩家数据[id].角色:取参战宝宝编号()
                for i=1,#玩家数据[id].召唤兽.数据[bh].技能 do
                    if 玩家数据[id].召唤兽.数据[bh].技能[i]==jn then
                        常规提示(id,"这只宝宝已经学会了这个技能了。")
                        return
                    end
                end
                local xianzhi=12
                local 最大限制 = 16
                if 玩家数据[id].召唤兽.数据[bh].种类=="特殊神兽" then
                    最大限制 = 24
                end
                if #玩家数据[id].召唤兽.数据[bh].技能 >= xianzhi and #玩家数据[id].召唤兽.数据[bh].技能 < 最大限制 then
                    if 玩家数据[id].召唤兽.数据[bh].打书次数==nil then
                        玩家数据[id].召唤兽.数据[bh].打书次数=0
                    end
                    local num=(玩家数据[id].召唤兽.数据[bh].打书次数+1)*10
                    if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" then
                        num=(玩家数据[id].召唤兽.数据[bh].打书次数+1)*20
                    end
                    if 神话 then
                        num = (玩家数据[id].召唤兽.数据[bh].打书次数+1)*50
                        if num >= 250 then num = 250 end
                    end
                    if 玩家数据[id].道具:消耗背包道具(连接id,id,"神兜兜",num) and 玩家数据[id].道具:消耗背包道具(连接id,id,"技能书",1) then
                        -- self.数据[兽决]=nil
                        self.数据[兽决].数量=self.数据[兽决].数量-1
                        if  self.数据[兽决].数量==0 then
                        玩家数据[id].角色[类型][数据.格子[sjgz]]=nil
                        end
                        玩家数据[id].召唤兽.数据[bh].技能[#玩家数据[id].召唤兽.数据[bh].技能+1]=jn
                        玩家数据[id].召唤兽.数据[bh].打书次数=玩家数据[id].召唤兽.数据[bh].打书次数+1
                        玩家数据[id].召唤兽.数据[bh]:刷新信息("1")
                        常规提示(id,"#G恭喜，您心爱的宝宝领悟了新技能！#Y"..jn.."#G。")
                        道具刷新(id)
                    else
                        添加最后对话(id,"需要"..num.."个“神兜兜”和一个技能书才行哦。")
                    end
                else
                    添加最后对话(id,"只能对大于等于.."..xianzhi.."..技能的宝宝使用。")
                end
            end
        else
            添加最后对话(id,"请将“神兜兜”和需要附加技能的“兽决”跟技能书一起给我吧#24")
        end
        玩家数据[id].给予数据=nil
        return
    elseif 事件=="超级魔兽要诀兑换碎片" then
            local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
            local 道具2=玩家数据[id].角色[类型][数据.格子[2]]
            local 道具3=玩家数据[id].角色[类型][数据.格子[3]]
            local 数量1=数据.数量[1]
            local 数量2=数据.数量[2]
            local 数量3=数据.数量[3]
                if   (self.数据[道具1]~=nil and self.数据[道具1].名称~="超级魔兽要诀")  or (self.数据[道具2]~=nil and self.数据[道具2].名称~="超级魔兽要诀") or (self.数据[道具3]~=nil and self.数据[道具3].名称~="超级魔兽要诀")  then
                    玩家数据[id].给予数据=nil
                    添加最后对话(id,"请将需要兑换的超级魔兽要诀放在格子上给我吧#24")
                    return
                end


                            if self.数据[道具1]~=nil and self.数据[道具2]==nil and self.数据[道具3]==nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                            elseif self.数据[道具1]==nil and self.数据[道具2]~=nil and self.数据[道具3]==nil then
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                            elseif self.数据[道具1]==nil and self.数据[道具2]==nil and self.数据[道具3]~=nil then
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil and self.数据[道具3]==nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                            elseif self.数据[道具1]==nil and self.数据[道具2]~=nil and self.数据[道具3]~=nil then
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            elseif self.数据[道具1]~=nil and self.数据[道具2]==nil and self.数据[道具3]~=nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil and self.数据[道具3]~=nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            end

                                if   self.数据[道具1]~=nil  and self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                elseif  self.数据[道具2]~=nil and self.数据[道具2].数量<=0   then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                elseif  self.数据[道具3]~=nil  and self.数据[道具3].数量<=0 then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end


                    if self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]==nil  then
                                if  self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                end
                                if  self.数据[道具2].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                end

                    elseif self.数据[道具1]~=nil and self.数据[道具2]==nil  and self.数据[道具3]~=nil  then
                                if  self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                end
                                if  self.数据[道具3].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end
                    elseif self.数据[道具1]==nil and self.数据[道具2]~=nil  and self.数据[道具3]~=nil  then
                                if  self.数据[道具2].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                end
                                if  self.数据[道具3].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end
                    elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]~=nil  then
                                if  self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                end
                                if  self.数据[道具2].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                end
                                if  self.数据[道具3].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end
                    end
                    if self.数据[道具1]~=nil and self.数据[道具2]==nil  and self.数据[道具3]==nil  then
                            self:给予道具(id,"超级兽诀·碎片",10*数量1,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1.."本超级魔兽要诀，成功兑换"..10*数量1.."个超级兽决·碎片，请拿好！")
                    elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]==nil  then
                            self:给予道具(id,"超级兽诀·碎片",10*数量1+10*数量2,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1+数量2.."本超级魔兽要诀，成功兑换"..10*数量1+10*数量2.."个超级兽决·碎片，请拿好！")
                    elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]~=nil  then
                            self:给予道具(id,"超级兽诀·碎片",10*数量1+10*数量2+10*数量3,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1+数量2+数量3.."本超级魔兽要诀，成功兑换"..10*数量1+10*数量2+10*数量3.."个超级兽决·碎片，请拿好！")
                    elseif self.数据[道具1]~=nil and self.数据[道具2]==nil  and self.数据[道具3]~=nil  then
                            self:给予道具(id,"超级兽诀·碎片",10*数量1+10*数量3,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1+数量3.."本超级魔兽要诀，成功兑换"..10*数量1+10*数量3.."个超级兽决·碎片，请拿好！")

                    end
                    道具刷新(id)
                    玩家数据[id].给予数据=nil
    elseif 事件=="特殊魔兽要诀兑换碎片" then
            local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
            local 道具2=玩家数据[id].角色[类型][数据.格子[2]]
            local 道具3=玩家数据[id].角色[类型][数据.格子[3]]
            local 数量1=数据.数量[1]
            local 数量2=数据.数量[2]
            local 数量3=数据.数量[3]
                if   (self.数据[道具1]~=nil and self.数据[道具1].名称~="特殊魔兽要诀")  or (self.数据[道具2]~=nil and self.数据[道具2].名称~="特殊魔兽要诀") or (self.数据[道具3]~=nil and self.数据[道具3].名称~="特殊魔兽要诀")  then
                    玩家数据[id].给予数据=nil
                    添加最后对话(id,"请将需要兑换的特殊魔兽要诀放在格子上给我吧#24")
                    return
                end


                            if self.数据[道具1]~=nil and self.数据[道具2]==nil and self.数据[道具3]==nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                            elseif self.数据[道具1]==nil and self.数据[道具2]~=nil and self.数据[道具3]==nil then
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                            elseif self.数据[道具1]==nil and self.数据[道具2]==nil and self.数据[道具3]~=nil then
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil and self.数据[道具3]==nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                            elseif self.数据[道具1]==nil and self.数据[道具2]~=nil and self.数据[道具3]~=nil then
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            elseif self.数据[道具1]~=nil and self.数据[道具2]==nil and self.数据[道具3]~=nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil and self.数据[道具3]~=nil then
                                self.数据[道具1].数量=self.数据[道具1].数量-数量1
                                self.数据[道具2].数量=self.数据[道具2].数量-数量2
                                self.数据[道具3].数量=self.数据[道具3].数量-数量3
                            end

                                if   self.数据[道具1]~=nil  and self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                elseif  self.数据[道具2]~=nil and self.数据[道具2].数量<=0   then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                elseif  self.数据[道具3]~=nil  and self.数据[道具3].数量<=0 then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end


                    if self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]==nil  then
                                if  self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                end
                                if  self.数据[道具2].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                end

                    elseif self.数据[道具1]~=nil and self.数据[道具2]==nil  and self.数据[道具3]~=nil  then
                                if  self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                end
                                if  self.数据[道具3].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end
                    elseif self.数据[道具1]==nil and self.数据[道具2]~=nil  and self.数据[道具3]~=nil  then
                                if  self.数据[道具2].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                end
                                if  self.数据[道具3].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end
                    elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]~=nil  then
                                if  self.数据[道具1].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[1]]=nil
                                end
                                if  self.数据[道具2].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[2]]=nil
                                end
                                if  self.数据[道具3].数量<=0  then
                                            玩家数据[id].角色[类型][数据.格子[3]]=nil
                                end
                    end
                    if self.数据[道具1]~=nil and self.数据[道具2]==nil  and self.数据[道具3]==nil  then
                            self:给予道具(id,"特殊兽诀·碎片",5*数量1,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1.."本特殊魔兽要诀，成功兑换"..5*数量1.."个特殊兽诀·碎片，请拿好！")
                    elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]==nil  then
                            self:给予道具(id,"特殊兽诀·碎片",5*数量1+5*数量2,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1+数量2.."本特殊魔兽要诀，成功兑换"..5*数量1+5*数量2.."个特殊兽诀·碎片，请拿好！")
                    elseif self.数据[道具1]~=nil and self.数据[道具2]~=nil  and self.数据[道具3]~=nil  then
                            self:给予道具(id,"特殊兽诀·碎片",5*数量1+5*数量2+5*数量3,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1+数量2+数量3.."本特殊魔兽要诀，成功兑换"..5*数量1+5*数量2+5*数量3.."个特殊兽诀·碎片，请拿好！")
                    elseif self.数据[道具1]~=nil and self.数据[道具2]==nil  and self.数据[道具3]~=nil  then
                            self:给予道具(id,"特殊兽诀·碎片",5*数量1+5*数量3,nil,"不存共享")
                            添加最后对话(id,"本次消耗了"..数量1+数量3.."本特殊魔兽要诀，成功兑换"..5*数量1+5*数量3.."个特殊兽诀·碎片，请拿好！")

                    end
                    道具刷新(id)
                    玩家数据[id].给予数据=nil
    elseif 事件=="替换神兽技能" then
        local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
        local 道具2=玩家数据[id].角色[类型][数据.格子[2]]
        if self.数据[道具1]==nil or self.数据[道具2]==nil then
            玩家数据[id].给予数据=nil
            添加最后对话(id,"请将“神兜兜”需要附加技能的“兽决”一起给我吧#24")
            return
        end
        local 名称1=self.数据[道具1].名称
        local 名称2=self.数据[道具2].名称
        local 兽决,兜兜
        local sjgz=1
        if 名称1=="魔兽要诀" or 名称1=="高级魔兽要诀"  or 名称1=="特殊魔兽要诀"  or 名称1=="超级魔兽要诀" then
            兽决=道具1
        elseif 名称2=="魔兽要诀" or 名称2=="高级魔兽要诀"  or 名称2=="特殊魔兽要诀"  or 名称2=="超级魔兽要诀" then
            兽决=道具2
            sjgz=2
        end
        if 名称1=="神兜兜" then
            兜兜=道具1
        elseif 名称2=="神兜兜" then
            兜兜=道具2
        end

        if 兽决~=nil and 兜兜~=nil and 兽决~=兜兜 then
            local zd=玩家数据[id].给予数据.替换技能
            local jn=self.数据[兽决].附带技能
            if jn then
                local bh=玩家数据[id].角色:取参战宝宝编号()
                local jngz=0
                local yccjjn=0
                --local cjjndsxz={[1]=3,[2]=5,[3]=7,[4]=11,[5]=15,[6]=19,[7]=999} --超级技能 打书限制 有0超技要求4技能以上
                local cjjndsxz={[1]=4,[2]=6,[3]=8,[4]=12,[5]=16,[6]=999,[7]=999}
                local bh=玩家数据[id].角色:取参战宝宝编号()
                local 技能数量 = #玩家数据[id].召唤兽.数据[bh].技能

                for i=1,#玩家数据[id].召唤兽.数据[bh].技能 do
                    if 玩家数据[id].召唤兽.数据[bh].技能[i]==jn then
                        常规提示(id,"这只宝宝已经学会了这个技能了。")
                        return
                    end

                    if string.find(玩家数据[id].召唤兽.数据[bh].技能[i],"超级")~=nil and string.find(zd,"超级") ==nil  then
                            yccjjn=yccjjn+1
                    else
                            yccjjn=yccjjn
                    end
                    if 玩家数据[id].召唤兽.数据[bh].技能[i]==zd then
                        jngz=i
                    end
                end
                 if (名称1 == "超级魔兽要诀" or 名称2 == "超级魔兽要诀") and jn ~= "超级神柚复生" then
                    if 技能数量 < cjjndsxz[yccjjn] then --超级技能
                        添加最后对话(id,"需要总技能#R"..cjjndsxz[yccjjn].."#W以上才能替换第#R"..yccjjn.."#W个超级技能（当前"..技能数量.."个技能）")
                        return
                    end
                end
                if jngz~=0 then
                    if 玩家数据[id].召唤兽.数据[bh].打书次数==nil then
                        玩家数据[id].召唤兽.数据[bh].打书次数=0
                    end
                    local num=(玩家数据[id].召唤兽.数据[bh].打书次数+1)*10
                    if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" then
                        num=(玩家数据[id].召唤兽.数据[bh].打书次数+1)*20
                    end
                    if 玩家数据[id].道具:消耗背包道具(连接id,id,"神兜兜",num) then
                        -- self.数据[兽决]=nil
                        self.数据[兽决].数量=self.数据[兽决].数量-1
                        if self.数据[兽决].数量==0 then
                        玩家数据[id].角色[类型][数据.格子[sjgz]]=nil
                        end
                        玩家数据[id].召唤兽.数据[bh].技能[jngz]=jn
                        玩家数据[id].召唤兽.数据[bh].打书次数=玩家数据[id].召唤兽.数据[bh].打书次数+1
                        玩家数据[id].召唤兽.数据[bh]:刷新信息("1")
                        常规提示(id,"#G恭喜，您心爱的宝宝学会了新技能！")
                        道具刷新(id)
                    else
                        添加最后对话(id,"需要"..num.."个“神兜兜”才行哦。")
                    end
                end
            end
        else
            添加最后对话(id,"请将“神兜兜”和需要附加技能的“兽决”一起给我吧#24")
        end
        玩家数据[id].给予数据=nil
        return
    elseif 事件=="无名野鬼上交物品" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称="特赦令牌"
        if self.数据[道具id].名称~=名称 then
            添加最后对话(id,"我需要的是特赦令牌，你给我的这个能当饭吃吗？")
            return
        end
        if self.数据[道具id].数量  and self.数据[道具id].数量 > 1 then
            self.数据[道具id].数量 = self.数据[道具id].数量 - 1
        else
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
self:给予道具(id,"高级藏宝图")
        添加最后对话(id,"您可真是大好人啊，这块特赦令牌终于让我能离开这地狱了。我这里有一张高级藏宝图你拿去吧，就当你做好事的回报。")
                self:索要道具更新(id,类型)

    elseif 事件=="我帮你带来了驱邪扇芝" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称~="驱邪扇芝" then
            添加最后对话(id,"少侠别拿我开玩笑了……")
            return
        end
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        self:索要道具更新(id,类型)
        完成任务_19(id)
    elseif 事件=="文墨门派送信" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称~="密信" then
            添加最后对话(id,"这不是我要的东西#55")
            return
        else
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
            self:索要道具更新(id,类型)
            战斗准备类:创建战斗(id,130040,玩家数据[id].角色:取任务(1163))
        end
        return
    elseif 事件=="上交锦盒" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 名称="金银锦盒"
        if self.数据[道具id].名称~=名称 then
            添加最后对话(id,"我需要的是金银锦盒，你给我的这个能当饭吃吗？")
            return
        end
        if 帮派数据[玩家数据[id].角色.BPBH] == nil then
            添加最后对话(id,"你没有帮派无法上交金银锦盒")
            return
        end
        local 数量 = qz(self.数据[道具id].数量 or 1)
        self.数据[道具id]=nil
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        local 增加帮贡=数量*5
        local 增加帮派资金=数量*50000
        帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前 = 帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前+增加帮派资金
        帮派处理:增加当前内政(玩家数据[id].角色.BPBH,数量*2)
        if 帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前> 50000000 then--帮派数据[玩家数据[id].角色.BPBH].帮派资金.上限 then
            帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前=50000000--帮派数据[玩家数据[id].角色.BPBH].帮派资金.上限
        end
        添加帮贡(id,增加帮贡,"上限")
        广播帮派消息({内容="[金库总管]#G/"..玩家数据[id].角色.名称.."#Y/上交金银锦盒为帮派增加了帮派资金#R/"..增加帮派资金.."#Y/两银子。#93",频道="bp"},玩家数据[id].角色.BPBH)
        self:索要道具更新(id,类型)

    elseif 事件=="锦衣进阶索要" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local 通过=false
        if self.数据[道具id].总类 == 2 and self.数据[道具id].分类 ==17 then
            通过=true
        end
        if self.数据[道具id].总类 == 2 and self.数据[道具id].分类 ==18 then
            通过=true
        end
        if self.数据[道具id].总类 == 2 and self.数据[道具id].分类 ==15 then
            通过=true
        end
        if 通过==false then
            添加最后对话(id,"少侠你给我这样的物品是为何？")
            return
        end
         if self.数据[道具id].锦衣升级== nil then
            self.数据[道具id].锦衣升级=0
         end
        -- if self.数据[道具id].锦衣升级< 30 then
        --     添加最后对话(id,"少侠你的锦衣焕彩还未达到30级")
        --     return
        -- end
        self:锦衣进阶(id,道具id)
    elseif 事件 == "洗练玉魄索要" then
            local 道具id = 玩家数据[id].角色[类型][数据.格子[1]]
            if self.数据[道具id].总类 ~= "上古玉魄" then
                添加最后对话(id, "少侠你给我这样的物品是为何？")
                return
            end
            self:玉魄洗练(id,道具id)

    elseif 事件=="点化装备" then
        -- local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        -- if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].召唤兽装备 then
        --  添加最后对话(id,"我这里目前只能点化人物装备，其它的我可没那么大的能耐。",{"继续点化","告辞"})
        --  return
        -- elseif self.数据[道具id].等级>80 then
        --  添加最后对话(id,"只能点化80级以下的人物装备。")
        --  return
        -- end
        -- local 银子=self.数据[道具id].等级*5000
        -- if 玩家数据[id].角色.银子<银子 then
        --  添加最后对话(id,format("本次点化需要消耗#Y%s#W两银子，你似乎手头有点紧哟？",银子))
        --  return
        -- end
        -- 玩家数据[id].角色:扣除银子(银子,0,0,"点化装备",1)
        -- local 套装类型={"附加状态","追加法术"}
        -- 套装类型=套装类型[取随机数(1,#套装类型)]
        -- local 套装效果={
        --  附加状态={"逆鳞","金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身"},
        --  -- 追加法术={"横扫千军"}
        --  追加法术={"横扫千军","满天花雨","浪涌","唧唧歪歪","五雷咒","神针撼海","日月乾坤","地狱烈火","催眠符","当头一棒","龙卷雨击","落叶萧萧"}
        -- }
        -- 添加最后对话(id,format("点化装备成功,您本次点化后的套装效果为#Y%s：%s",self.数据[道具id].套装效果[1],self.数据[道具id].套装效果[2]),{"继续点化","告辞"})
        return
    elseif 事件=="合成旗4" then --补充
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].总类~=11 or  self.数据[道具id].分类~=2 then
            常规提示(id,"#Y我只可以为合成旗补充次数哟。")
            return
        elseif self.数据[道具id].次数>=140 then
            常规提示(id,"#Y你的这个合成旗次数已经满了")
            return
        end
        local 编号=玩家数据[id].法宝id
        if 玩家数据[id].角色.法宝[编号]==nil or self.数据[玩家数据[id].角色.法宝[编号]]==nil or self.数据[玩家数据[id].角色.法宝[编号]].名称~="五色旗盒" then
            常规提示(id,"#Y你没有这样的法宝")
            return
        end
        local 灵气=140-self.数据[道具id].次数
        灵气=math.floor(灵气/5)
        if 灵气<1 then 灵气=1 end
        if 灵气>self.数据[玩家数据[id].角色.法宝[编号]].魔法 then
            常规提示(id,"#Y本次补充需要消耗#R"..灵气.."#Y点法宝灵气，你的法宝没有那么多的灵气")
            return
        end
        self.数据[玩家数据[id].角色.法宝[编号]].魔法=self.数据[玩家数据[id].角色.法宝[编号]].魔法-灵气
        self.数据[道具id].次数=140
        发送数据(连接id,38,{内容="你的法宝#R/五色旗盒#W/灵气减少了"..灵气.."点"})
        常规提示(id,"#Y补充成功！你的这个合成旗可使用次数已经恢复到140次了")
        self:索要道具更新(id,类型)
    elseif 事件=="合成旗" then
        local 道具id={}
        for n=1,#数据.格子 do
            if 数据.格子[n]~=nil  then
                道具id[n]=数据.格子[n]
                local 临时id=玩家数据[id].角色[类型][数据.格子[n]]
                if self.数据[临时id].总类~=11 and self.数据[临时id].分类~=1 then
                    常规提示(id,"#Y只有导标旗才可以合成哟")
                    return
                end
            end
        end
        if 玩家数据[id].合成旗序列==nil then
            玩家数据[id].合成旗序列={}
            for n=1,#道具id do
                local 临时id=玩家数据[id].角色[类型][道具id[n]]
                for i=1,#道具id do
                    local 临时id1=玩家数据[id].角色[类型][道具id[i]]
                    if i~=n and 临时id1==临时id then
                        常规提示(id,"#Y合成的导标旗中存在重复导标旗")
                        return
                    elseif i~=n and self.数据[临时id].地图~=self.数据[临时id1].地图 then
                        常规提示(id,"#Y合成的导标旗定标场景必须为同一个")
                        return
                    end
                end
            end
        else
            for n=1,#道具id do
                local 临时id=玩家数据[id].角色[类型][道具id[n]]
                if 玩家数据[id].合成旗序列.地图~=nil and 玩家数据[id].合成旗序列.地图~=self.数据[临时id].地图 then
                    常规提示(id,"#Y只有#R"..取地图名称(玩家数据[id].合成旗序列.地图).."#Y的导标旗才可合成")
                    return
                end
                for i=1,#道具id do
                    local 临时id1=玩家数据[id].角色[类型][道具id[i]]
                    if i~=n and 临时id1==临时id then
                        常规提示(id,"#Y合成的导标旗中存在重复导标旗")
                        return
                    end
                end
                for i=1,#玩家数据[id].合成旗序列 do
                    local 临时id1=玩家数据[id].角色[类型][玩家数据[id].合成旗序列[i]]
                    if  临时id1==临时id then
                        常规提示(id,"#Y合成的导标旗中存在重复导标旗")
                        return
                    end
                end
            end
        end
        local 编号=玩家数据[id].法宝id
        if 玩家数据[id].角色.法宝[编号]==nil or self.数据[玩家数据[id].角色.法宝[编号]]==nil or self.数据[玩家数据[id].角色.法宝[编号]].名称~="五色旗盒" then
            常规提示(id,"#Y你没有这样的法宝")
            return
        end
        local 上限=7
        if self.数据[玩家数据[id].角色.法宝[编号]].气血<=0 then
            上限=3
        elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=2 then
            上限=4
        elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=5 then
            上限=5
        elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=8 then
            上限=6
        elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=9 then
            上限=7
        end
        for n=1,#道具id do
            if #玩家数据[id].合成旗序列<上限 then
                if 玩家数据[id].合成旗序列.地图==nil then
                    玩家数据[id].合成旗序列.地图=self.数据[玩家数据[id].角色[类型][道具id[n]]].地图
                end
                玩家数据[id].合成旗序列[#玩家数据[id].合成旗序列+1]=道具id[n]
            end
        end
        if #玩家数据[id].合成旗序列==上限 then
            local aa ="请选择超级合成旗的颜色："
            local xx={"绿色合成旗","蓝色合成旗","红色合成旗","白色合成旗","黄色合成旗",}
            发送数据(连接id,1501,{名称="五色旗盒",对话=aa,选项=xx})
            玩家数据[id].最后操作="合成旗3"
        else
            玩家数据[id].给予数据={类型=1,id=0,事件="合成旗"}
            发送数据(连接id,3530,{道具=玩家数据[id].道具:索要道具1(id),名称="五色旗盒",类型="法宝",等级="无"})
            玩家数据[id].最后操作="合成旗2"
            常规提示(id,format("#Y你已提交%s个导标旗，还需要提交%s个导标旗",#玩家数据[id].合成旗序列,上限-#玩家数据[id].合成旗序列))
        end
    elseif 事件=="装备出售" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
            添加最后对话(id,"我这里只收购人物装备哟，其它的破铜烂铁我可是不收滴哟。")
            return
        end
        玩家数据[id].出售装备=数据.格子[1]
        玩家数据[id].最后操作="出售装备"
        添加最后对话(id,format("你的这件#Y%s#W我将以#R%s#W两银子进行收购，请确认是否出售该装备？",self.数据[道具id].名称,self:取装备价格(道具id)),{"确认出售","我不卖了"})
    elseif 事件=="转换召唤兽饰品" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id] == nil then
            添加最后对话(id,"#24")
            return
        end
        if self.数据[道具id].总类==149 then
            if string.find(self.数据[道具id].名称,"进阶")~=nil then
                local mc=string.gsub(self.数据[道具id].名称,"进阶","")
                if 取饰品表1(mc) then
                    self.数据[道具id].名称=mc
                    发送数据(连接id,3699)
                    常规提示(id,"转换成功！")
                else
                    添加最后对话(id,"#17少侠，你给我的似乎不是召唤兽饰品哦？（或对应进阶召唤兽还未开放饰品）")
                end
            else
                local mc="进阶"..self.数据[道具id].名称
                if 取饰品表1(mc) then
                    self.数据[道具id].名称=mc
                    发送数据(连接id,3699)
                    常规提示(id,"转换成功！")
                else
                    添加最后对话(id,"#17少侠，你给我的似乎不是召唤兽饰品哦？（或对应进阶召唤兽还未开放饰品）")
                end
            end
        end
    elseif 事件=="法宝补充灵气" then
        local 道具id=玩家数据[id].角色.法宝[数据.格子[1]]
        if self.数据[道具id] == nil then
            添加最后对话(id,"只有法宝才可以补充灵气哟，你这个是什么玩意？")
            return
        end
        if self.数据[道具id].总类~=1000 then
            添加最后对话(id,"只有法宝才可以补充灵气哟，你这个是什么玩意？")
            return
        end
        local 价格=2000000
        if self.数据[道具id].分类==2 then
            价格=3500000
        elseif self.数据[道具id].分类==3 then
            价格=6000000
        end
        if 玩家数据[id].角色.银子<价格 then
            添加最后对话(id,"本次补充法宝灵气需要消耗"..价格.."两银子，你身上没有那么多的现金哟。")
            return
        end
        玩家数据[id].角色:扣除银子(价格,0,0,"补充法宝扣除，法宝名称为"..self.数据[道具id].名称,1)
        self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
        添加最后对话(id,"补充法宝灵气成功！")
    elseif 事件 == "青龙任务" then
        local 任务id=玩家数据[id].角色:取任务(301)
        if 任务id==0 then
            添加最后对话(id,"你没有这个任务！")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称~=任务数据[任务id].物品  then
            添加最后对话(id,"我拿这个玩意用来干啥？")
            return
        end
        if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
            self.数据[道具id].数量=self.数据[道具id].数量-1
            if self.数据[道具id].数量<=0 then
                self.数据[道具id]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
            end
        else
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        self:索要道具更新(id,类型)
        帮派青龙玄武:完成青龙任务(任务id,id,任务数据[任务id].分类)
    elseif 事件 == "玄武任务" then
        local 任务id=玩家数据[id].角色:取任务(302)
        if 任务id==0 then
            添加最后对话(id,"你没有这个任务！")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称~=任务数据[任务id].物品  then
            添加最后对话(id,"我拿这个玩意用来干啥？")
            return
        end
        if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
            self.数据[道具id].数量=self.数据[道具id].数量-1
            if self.数据[道具id].数量<=0 then
                self.数据[道具id]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
            end
        else
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        self:索要道具更新(id,类型)
        帮派青龙玄武:完成玄武任务(任务id,id,任务数据[任务id].分类)
    elseif 事件=="上交任务物品" then
        local 任务id=玩家数据[id].角色:取任务(任务编号)
        if 任务id==0 then
            添加最后对话(id,"你没有这个任务！")
            return
        end
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].名称~=任务数据[任务id].物品  then
            添加最后对话(id,"我拿这个玩意用来干啥？")
            return
        end
        if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
            self.数据[道具id].数量=self.数据[道具id].数量-1
            if self.数据[道具id].数量<=0 then
                self.数据[道具id]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
            end
        else
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
        end
        self:索要道具更新(id,类型)
        local fun = _G["完成任务_"..tostring(任务编号)]
        if fun ~= nil  then
            return fun(id,任务id)
        else
            return
        end
    elseif 事件=="坐骑任务给予烹饪" then
        local 任务id=玩家数据[id].角色:取任务(307)
        if 任务id==0 or 任务数据[任务id]==nil then
          常规提示(id,"#Y/你没有这样的任务")
          return
        end
        local 道具id=玩家数据[id].角色.道具[数据.格子[1]]
        local 名称=任务数据[任务id].烹饪
        if 道具id==nil or self.数据[道具id]==nil or  self.数据[道具id].名称~=名称 then
          常规提示(id,"#Y/对方需要的不是这种物品")
          return
        end
        if  self.数据[道具id].数量 and self.数据[道具id].数量 >1 then
            self.数据[道具id].数量 = self.数据[道具id].数量 - 1
            任务数据[任务id].分类=3
            发送数据(玩家数据[id].连接id,1501,{名称="太白金星",模型="太白金星",对话=format("天宫的千里眼能眼观天下，他也许知道天马的消息！"),选项={"我这就去"}})
            道具刷新(id)
            玩家数据[id].角色:刷新任务跟踪()
        else
            self.数据[道具id]=nil
            玩家数据[id].角色.道具[数据.格子[1]]=nil
            任务数据[任务id].分类=3
            发送数据(玩家数据[id].连接id,1501,{名称="太白金星",模型="太白金星",对话=format("天宫的千里眼能眼观天下，他也许知道天马的消息！"),选项={"我这就去"}})
            道具刷新(id)
            玩家数据[id].角色:刷新任务跟踪()
        end
    elseif 事件=="坐骑任务给予药品" then
        local 任务id=玩家数据[id].角色:取任务(307)
        if 任务id==0 or 任务数据[任务id]==nil then
          常规提示(id,"#Y/你没有这样的任务")
          return
        end
        local 道具id=玩家数据[id].角色.道具[数据.格子[1]]
        local 名称=任务数据[任务id].药品
        if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称~=名称 then
          常规提示(id,"#Y/对方需要的不是这种物品")
          return
        end
        if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
            self.数据[道具id].数量 = self.数据[道具id].数量 - 1
            任务数据[任务id].分类=12
            发送数据(玩家数据[id].连接id,1501,{名称="大大王",模型="大大王",对话=format("听说马儿跑了到建业一带，少侠可以去那里找找"),选项={"我这就去建业看看"}})
            道具刷新(id)
            玩家数据[id].角色:刷新任务跟踪()
        else
            self.数据[道具id]=nil
            玩家数据[id].角色.道具[数据.格子[1]]=nil
            任务数据[任务id].分类=12
            发送数据(玩家数据[id].连接id,1501,{名称="大大王",模型="大大王",对话=format("听说马儿跑了到建业一带，少侠可以去那里找找"),选项={"我这就去建业看看"}})
            道具刷新(id)
            玩家数据[id].角色:刷新任务跟踪()
        end
    elseif 事件=="上交副本物品" then
        local 副本id = 任务处理类:取副本id(数字id,数据.副本编号)
        local 需求编号 = 0
        for i=1,#副本数据.车迟斗法.进行[副本id].任务需求 do
            if self.数据[道具id].名称 == 副本数据.车迟斗法.进行[副本id].任务需求[i].物品 then
                需求编号 = i
            end
        end
        if 需求编号 ~= 0 then
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][数据.格子[1]]=nil
            副本数据.车迟斗法.进行[数字id][副本数据.车迟斗法.进行[副本id].任务需求[需求编号].回执]=副本数据.车迟斗法.进行[数字id][副本数据.车迟斗法.进行[副本id].任务需求[需求编号].回执]+副本数据.车迟斗法.进行[副本id].任务需求[需求编号].奖励
        else
            添加最后对话(id,"我拿这个玩意用来干啥？")
        end
        self:索要道具更新(id,类型)
        local fun = _G[""..数据.脚本]
        if fun ~= nil  then
            return fun(id)
        else
            return
        end
    elseif 事件=="法宝锻造" then
        if 玩家数据[id].角色:取任务(38) ~= 0 and 任务数据[玩家数据[id].角色:取任务(38)] then
            self:法宝合成(玩家数据[id].连接id,id,数据.格子,类型)
        else
            local 内丹,材料1,材料2,法宝,天珠
            if 数据.格子[1] ~= nil then
                local 道具id = 玩家数据[id].角色[类型][数据.格子[1]]
                if  self.数据[道具id].名称 == "内丹" then
                    内丹=self.数据[道具id].名称..self.数据[道具id].五行
                end
            end
            if 数据.格子[2] ~= nil then
                local 道具id = 玩家数据[id].角色[类型][数据.格子[2]]
                if self.数据[道具id].总类 == 1003 and self.数据[道具id].分类 ~= 5 then
                    材料1=self.数据[道具id].名称..self.数据[道具id].五行
                end
            end
            if 数据.格子[3] ~= nil then
                local 道具id = 玩家数据[id].角色[类型][数据.格子[3]]
                 if self.数据[道具id].总类 == 1003 and self.数据[道具id].分类 ~= 5 then
                    材料2=self.数据[道具id].名称..self.数据[道具id].五行
                end
            end
            if 数据.格子[4] ~= nil then
                local 道具id = 玩家数据[id].角色[类型][数据.格子[4]]
                if self.数据[道具id].总类 == 1000 then
                    法宝=self.数据[道具id].名称..self.数据[道具id].五行
                end
            end
            if 数据.格子[5] ~= nil then
                local 道具id = 玩家数据[id].角色[类型][数据.格子[5]]
                天珠=self.数据[道具id].名称..self.数据[道具id].五行
            end
            local lsb = 法宝公式(内丹,材料1,材料2,法宝,天珠)
            if #lsb == 0 then
                常规提示(id,"#Y/合成失败无法合成法宝")
                return
            elseif #lsb > 1 then
                if lsb[时辰信息.当前] ~= nil then
                    self.数据[玩家数据[id].角色[类型][数据.格子[1]]] = nil
                    玩家数据[id].角色[类型][数据.格子[1]] = nil
                    常规提示(id,"#Y/合成失败无法损失了内丹")
                    return
                else
                    self:给予法宝(id,lsb[时辰信息.当前])
                    self.数据[玩家数据[id].角色[类型][数据.格子[1]]] = nil
                    玩家数据[id].角色[类型][数据.格子[1]] = nil
                    self.数据[玩家数据[id].角色[类型][数据.格子[2]]] = nil
                    玩家数据[id].角色[类型][数据.格子[2]] = nil
                    self.数据[玩家数据[id].角色[类型][数据.格子[3]]] = nil
                    玩家数据[id].角色[类型][数据.格子[3]] = nil
                    if 数据.格子[4] ~= nil then
                        self.数据[玩家数据[id].角色[类型][数据.格子[4]]] = nil
                        玩家数据[id].角色[类型][数据.格子[4]] = nil
                    end
                    if 数据.格子[5] ~= nil then
                        self.数据[玩家数据[id].角色[类型][数据.格子[5]]] = nil
                        玩家数据[id].角色[类型][数据.格子[5]] = nil
                    end
                    self:索要道具更新(id,类型)
                end
            else
                self:给予法宝(id,lsb[1])
                self.数据[玩家数据[id].角色[类型][数据.格子[1]]] = nil
                玩家数据[id].角色[类型][数据.格子[1]] = nil
                self.数据[玩家数据[id].角色[类型][数据.格子[2]]] = nil
                玩家数据[id].角色[类型][数据.格子[2]] = nil
                self.数据[玩家数据[id].角色[类型][数据.格子[3]]] = nil
                玩家数据[id].角色[类型][数据.格子[3]] = nil
                if 数据.格子[4] ~= nil then
                    self.数据[玩家数据[id].角色[类型][数据.格子[4]]] = nil
                    玩家数据[id].角色[类型][数据.格子[4]] = nil
                end
                if 数据.格子[5] ~= nil then
                    self.数据[玩家数据[id].角色[类型][数据.格子[5]]] = nil
                    玩家数据[id].角色[类型][数据.格子[5]] = nil
                end
                self:索要道具更新(id,类型)
            end
        end
    elseif 事件=="更改法宝五行" then
        local 道具id=玩家数据[id].角色.法宝[数据.格子[1]]
        if self.数据[道具id] == nil then
            添加最后对话(id,"只有法宝才可以更换五行哟，你这个是什么玩意？")
            return
        end
        if self.数据[道具id].总类~=1000 then
            添加最后对话(id,"只有法宝才可以更换五行哟，你这个是什么玩意？")
            return
        end
        local 价格=300000
        if 玩家数据[id].角色.银子<价格 then
            添加最后对话(id,"本次更换五行需要消耗"..价格.."两银子，你身上没有那么多的现金哟。")
            return
        end
        玩家数据[id].角色:扣除银子(价格,0,0,"法宝更换五行，法宝名称为"..self.数据[道具id].名称,1)
        self.数据[道具id].五行=取五行()
        添加最后对话(id,"更换五行成功！")
    elseif 事件=="更改法宝材料五行" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].总类~=1003 then
            添加最后对话(id,"我这里目前只能更换法宝材料五行，其它的我可没那么大的能耐。")
            return
        end
        local 银子=30000
        if 玩家数据[id].角色.银子<银子 then
            添加最后对话(id,format("本次更换五行需要消耗#Y%s#W两银子，你似乎手头有点紧哟？",银子))
            return
        end
        玩家数据[id].角色:扣除银子(银子,0,0,"点化装备",1)
        self.数据[道具id].五行=取五行()
    elseif 事件=="更改装备五行" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 then
            添加最后对话(id,"我这里目前只能更换装备五行，其它的我可没那么大的能耐。")
            return
        end
        local 银子=300000
        if 玩家数据[id].角色.银子<银子 then
            添加最后对话(id,format("本次更换五行需要消耗#Y%s#W两银子，你似乎手头有点紧哟？",银子))
            return
        end
        玩家数据[id].角色:扣除银子(银子,0,0,"点化装备",1)
        self.数据[道具id].五行=取五行()
    elseif 事件=="炼制灵犀之屑" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        if self.数据[道具id] == nil then
            添加最后对话(id,"炼制灵犀之屑需要，150级-160级的“人物装备”，#W即可兑换到对应数量的灵犀之屑")
            return
        elseif self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].召唤兽装备 then
            添加最后对话(id,"我这里只接受人物装备兑换！")
            return
        elseif self.数据[道具id].等级<150 then
            添加最后对话(id,"装备"..self.数据[道具id].名称.."等级过低！")
            return
        end
        if self.数据[道具id].等级==150 then
            玩家数据[id].道具:给予道具(id,"灵犀之屑",20)
        elseif self.数据[道具id].等级==160 then
            玩家数据[id].道具:给予道具(id,"灵犀之屑",30)
        end
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        self.数据[道具id]=nil
        self:索要道具更新(id,类型)
    elseif 事件 == "上交道具" then
        local 参与ID ={}
        -- 获取道具在背包格子第几格  id
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        -- 获取上交数量
        local 上交数量 =数据.数量[1]
        --判断上交道具名称
        if self.数据[道具id].名称 == "恩典钥匙" then
            --将参加的数据进行分析
            for i = 1, tonumber(上交数量) do
                --用上交数量当做ID参加次数写入参加ID表中
                table.insert(参与ID, id)
            end
            --记录长度 防止最后一个加;
            -- local n = #参与ID
            --打开服务器文件output
            local file = io.open(程序目录..[[sql\]].."报名信息.txt", "a")
            if file then
                -- 写入每个参与者ID到文件
                for _, id in ipairs(参与ID) do
                    -- if _ < n then
                        file:write(id .. ";")
                    -- else
                 --     file:write(id)
                    -- end
                end
            end
            --关闭文本
            file:close()
            发送公告("神豪玩家#G"..玩家数据[id].角色.名称.."#上交了#R"..上交数量.."#把#R恩典钥匙#。大家快来围观，期待神豪玩家单车变摩托~~~~~~")
            --判断背包道具数量
            if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
                self.数据[道具id].数量=self.数据[道具id].数量-上交数量
                if self.数据[道具id].数量<=0 then
                    self.数据[道具id]=nil
                    玩家数据[id].角色[类型][数据.格子[1]]=nil
                end
            else
                self.数据[道具id]=nil
                玩家数据[id].角色[类型][数据.格子[1]]=nil
            end
        end
    elseif 事件=="上交烹饪换取材料" then
        local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
        local lsb = {女儿红=10,臭豆腐=20,烤肉=20,豆斋果=60,翡翠豆腐=40,佛跳墙=20,桂花丸=50,长寿面=80,珍露酒=10,蛇胆酒=70,梅花酒=40,百味酒=40,醉生梦死=80}
        if 数据.格子[1]==nil then
            添加最后对话(id,format("你什么都没有还不快滚",fhz2,玩家数据[id].角色.秘制食谱.材料),{"继续上交烹饪换取材料","告辞"})
            return
        end
        if lsb[self.数据[道具id].名称] == nil or self.数据[道具id].阶品 == nil then
            添加最后对话(id,format("这个物品无法无法兑换成材料",fhz2,玩家数据[id].角色.秘制食谱.材料),{"继续上交烹饪换取材料","告辞"})
            return
        end
        local fhz = qz(self.数据[道具id].阶品/20)
        local fhz2
        if fhz >= 4 then
            fhz2 = lsb[self.数据[道具id].名称]/10*(fhz-4)+lsb[self.数据[道具id].名称]
        else
            fhz2 = lsb[self.数据[道具id].名称]-(lsb[self.数据[道具id].名称]/10*(fhz+2-4))
        end
        玩家数据[id].角色[类型][数据.格子[1]]=nil
        self.数据[道具id]=nil
        self:索要道具更新(id,类型)
        玩家数据[id].角色.秘制食谱.材料 = 玩家数据[id].角色.秘制食谱.材料 + fhz2
        添加最后对话(id,format("上交成功,您本次上交兑换了#Y%s#W现有材料#Y%s",fhz2,玩家数据[id].角色.秘制食谱.材料),{"继续上交烹饪换取材料","告辞"})
    elseif 事件 == nil and 玩家数据[id].角色.剧情.附加.物品~= nil then
        if 玩家数据[id].角色.剧情.地图 == 玩家数据[id].给予数据.地图 and 玩家数据[id].角色.剧情.编号 == 玩家数据[id].给予数据.编号 then
            local 名称=玩家数据[id].角色.剧情.附加.物品
            local 数量=玩家数据[id].角色.剧情.附加.数量 or 1
            local 队伍组 = 取队伍组(id)
            local 成功 = true
            for i,v in ipairs(队伍组) do
                local id = v

                if not 玩家数据[id].道具:判断指定道具栏是否有(id,名称,类型,数量) then
                    成功 = false
                    常规提示(队伍组[1],string.format("#Y/请关注%s没有这件物品，该角色剧情进度将无法同步！",玩家数据[id].角色.名称))
                    return
                end
            end
            if 成功 then
                for i,v in ipairs(队伍组) do
                    local id = v
                    玩家数据[id].道具:消耗指定背包道具(玩家数据[id].连接id,id,名称,数量,类型)
                    玩家数据[id].角色.剧情.给予=true
                end
                对话处理类:数据处理(玩家数据[id].连接id,1501,id,玩家数据[id].给予数据)
            else
                常规提示(id,"#Y/你给予的物品不正确")
            end
        end
    elseif 事件 == nil and 玩家数据[id].角色.剧情.附加.银子~= nil then
        if 玩家数据[id].角色.剧情.地图 == 玩家数据[id].给予数据.地图 and 玩家数据[id].角色.剧情.编号 == 玩家数据[id].给予数据.编号 then
            -- if 玩家数据[id].角色.剧情.附加.银子 >  数据.银子+0 then
            --  常规提示(id,"#Y/你给予的银两未达到任务要求")
            --  return
            -- end
            local 队伍组 = 取队伍组(id)
            for i,v in ipairs(队伍组) do
                local id = v
                if 玩家数据[id].角色.银子 < 玩家数据[id].角色.剧情.附加.银子 then
                    常规提示(队伍组[1],string.format("#Y/%s银子不够！",玩家数据[id].角色.名称))
                    return
                end
            end
            for i,v in ipairs(队伍组) do
                local id = v
                玩家数据[id].角色:扣除银子(玩家数据[id].角色.剧情.附加.银子,0,0,"剧情任务",1)
                玩家数据[id].角色.剧情.给予=true
                if i==1 then
                    对话处理类:数据处理(玩家数据[id].连接id,1501,id,玩家数据[id].给予数据)
                end
            end
        end
    end
end
function 道具处理类:锦衣继承(连接id,id,gz,gz2)
             local gz=玩家数据[id].角色["道具"][gz]
             local gz2=玩家数据[id].角色["道具"][gz2]
             local 通过=false
             local 消耗=10000000
            if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==17 then
                    通过=true
            elseif self.数据[gz2].总类 == 2 and self.数据[gz2].分类 ==17 then
                    通过=true
            end
            if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==18 then
                    通过=true
            elseif self.数据[gz2].总类 == 2 and self.数据[gz2].分类 ==18 then
                    通过=true
            end
            if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==15 then
                    通过=true
            elseif self.数据[gz2].总类 == 2 and self.数据[gz2].分类 ==15 then
                    通过=true
            end
                if 通过==false then
                    常规提示(id,"少侠，只有锦衣才可以继承。")
                    return
                end

             if gz==nil and gz2==nil  then
                return
             end
             if 玩家数据[id].角色.银子 <消耗 then
                常规提示(id,"您的银子不足1000W无法进行继承。")
                return
            end
             if self.数据[gz].锦衣升级== nil then
                self.数据[gz].锦衣升级=0
             elseif self.数据[gz2].锦衣升级== nil then
                self.数据[gz2].锦衣升级=0
             end
            if self.数据[gz].锦衣升级>0  then
                    self.数据[gz2].锦衣升级= self.数据[gz].锦衣升级
                    self.数据[gz].锦衣升级=nil
                    玩家数据[id].角色:扣除银子(消耗,0,0,"焕彩继承",1)
                    常规提示(id,"恭喜少侠，继承成功！当前#G"..self.数据[gz2].名称.."#Y/焕彩为"..self.数据[gz2].锦衣升级.."级")
            else
                    常规提示(id,"把拥有焕彩等级的锦衣放到第一个格子！")
                    return
            end
            发送数据(连接id,67.4,玩家数据[id].道具:索要道具2(id))
end
function 道具处理类:技能继承(连接id,id,gz,gz2)
             local gz=玩家数据[id].角色["道具"][gz]
             local gz2=玩家数据[id].角色["道具"][gz2]
             local 通过=false
             local 消耗=10000000
            if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==17 then
                    通过=true
            elseif self.数据[gz2].总类 == 2 and self.数据[gz2].分类 ==17 then
                    通过=true
            end
            if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==18 then
                    通过=true
            elseif self.数据[gz2].总类 == 2 and self.数据[gz2].分类 ==18 then
                    通过=true
            end
            if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==15 then
                    通过=true
            elseif self.数据[gz2].总类 == 2 and self.数据[gz2].分类 ==15 then
                    通过=true
            end
                if 通过==false then
                    常规提示(id,"少侠，只有锦衣才可以继承。")
                    return
                end
             if gz==nil and gz2==nil  then
                return
            end
             if 玩家数据[id].角色.银子 <消耗 then
                常规提示(id,"您的银子不足1000W无法进行继承。")
                return
            end

             if self.数据[gz].锦衣进阶==nil then
                 self.数据[gz].锦衣进阶={技能="无"}
             elseif self.数据[gz2].锦衣进阶==nil then
                 self.数据[gz2].锦衣进阶={技能="无"}
            end
            if self.数据[gz].锦衣进阶.技能~="无" then
                    self.数据[gz2].锦衣进阶.技能=self.数据[gz].锦衣进阶.技能
                    self.数据[gz].锦衣进阶=nil
                    玩家数据[id].角色:扣除银子(消耗,0,0,"技能继承",1)
                    常规提示(id,"恭喜少侠，继承成功！当前#G"..self.数据[gz2].名称.."#Y/技能为#G"..self.数据[gz2].锦衣进阶.技能)
             else
                    常规提示(id,"把拥有技能的锦衣放到第一个格子！")
                    return
            end
            发送数据(连接id,67.5,玩家数据[id].道具:索要道具2(id))
end
-- function 道具处理类:锦衣进阶(连接id,id,gz)
--     local gz=玩家数据[id].角色["道具"][gz]
--     local 需求=1
--     local 随机技能= 锦衣技能[取随机数(1,#锦衣技能)]
--     local 限制=玩家数据[id].角色.道具[gz]
--     local lsgz = gz

--      local 通过=false
--         if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==17 then
--             通过=true
--         end
--         if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==18 then
--             通过=true
--         end
--         if self.数据[gz].总类 == 2 and self.数据[gz].分类 ==15 then
--             通过=true
--         end
--         if 通过==false then
--             常规提示(id,"少侠，只有锦衣才可以洗练。")
--             return
--         end
--          if gz==nil then
--             return
--         end
--         if self.数据[gz].锦衣升级== nil then
--             self.数据[gz].锦衣升级=0
--          end
--         if self.数据[gz].锦衣升级< 30 then
--             添加最后对话(id,"少侠你的锦衣焕彩还未达到30级")
--             return
--         end

--           if not 玩家数据[id].道具:判定背包道具(id,"玉刚卯",需求) then
--                 常规提示(id,"#Y/玉刚卯不足"..需求.."个")
--                     return
--                  end
--                 玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"玉刚卯",需求)
--              if self.数据[gz].锦衣进阶==nil then
--                  self.数据[gz].锦衣进阶={技能="无"}
--                  end
--                 self.数据[gz].锦衣进阶.技能=随机技能
--                 玩家数据[id].锦衣进阶=gz
--                 常规提示(id,"#Y当前锦衣附带技能为#G"..随机技能)
--                 发送数据(连接id,67.2,玩家数据[id].道具:索要道具2(id))
--                 发送数据(连接id,67.3,{锦衣进阶=随机技能})
-- end
function 道具处理类:玉魄洗练(id,道具id)
            local 当前道具 = self.数据[道具id]
            if not 当前道具.特殊属性 or not 当前道具.特殊属性值 then
                添加最后对话(id, "这件上古玉魄没有特殊属性，无法洗练！")
                return
            end
            local 限制次数=20
            if 玉魄洗练次数[id]==nil  then
                        玉魄洗练次数[id]=0
            end
            if 玉魄洗练次数[id]>=限制次数 then
                添加最后对话(id, "今天的次数已经消耗完了,明天再来吧！")
                return
            end
            local 基础经验=10000000
            local 递增经验=玉魄洗练次数[id]*1000000
            local 需要经验=基础经验+递增经验
            if 玩家数据[id].角色.当前经验 < 需要经验 then
                添加最后对话(id,"#Y/当前经验不足，无法洗练")
                return
            end
            玩家数据[id].角色:扣除经验(需要经验)
            local 特殊属性列表={}
            local 特殊属性值范围={}
            if self.数据[道具id].名称 =="上古玉魄·阳" then
                特殊属性列表 = {"伤害","速度","法术伤害","治疗能力","狂暴等级","物理暴击等级","法术暴击等级","封印命中等级","法术伤害结果","固伤暴击等级"}
                特殊属性值范围 = {
                伤害 = {3,20},
                速度 = {3,20},
                法术伤害 = {3,20},
                治疗能力 = {3,20},
                狂暴等级 = {3,20},
                物理暴击等级 = {3,20},
                法术暴击等级 = {3,20},
                封印命中等级 = {3,20},
                法术伤害结果 = {3,20},
                固伤暴击等级 = {3,20},
            }
            elseif self.数据[道具id].名称 =="上古玉魄·阴" then
                特殊属性列表 ={"气血","防御","法术防御","抗物理暴击等级","抗法术暴击等级","抵抗封印等级","格挡值","气血回复效果","固伤暴击等级"}
                特殊属性值范围 = {
                气血 = {5,25},
                防御 = {3,20},
                法术防御 = {3,20},
                抗物理暴击等级 = {3,20},
                抗法术暴击等级 = {3,20},
                抵抗封印等级 = {3,20},
                格挡值 = {5,25},
                气血回复效果 = {3,20},
                固伤暴击等级 = {3,20},

                }
            end
            玩家数据[id].玉魄洗练道具 = 道具id
            玉魄洗练次数[id]=玉魄洗练次数[id]+1
            local 新特殊属性 = 特殊属性列表[取随机数(1, #特殊属性列表)]
            local 范围 = 特殊属性值范围[新特殊属性]
            local 新特殊属性值 = 取随机数(范围[1], 范围[2])
            local 旧属性 = 当前道具.特殊属性
            local 旧值 = 当前道具.特殊属性值
            当前道具.特殊属性 = 新特殊属性
            当前道具.特殊属性值 = 新特殊属性值
            道具刷新(id)
            常规提示(id,"今天还可洗练"..(限制次数-玉魄洗练次数[id]).."次")
            玩家数据[id].最后对话={}
            玩家数据[id].最后对话.名称="女娲神使"
            玩家数据[id].最后对话.模型="进阶灵符女娲"
            发送数据(玩家数据[id].连接id,1501,{名称="女娲神使",模型="进阶灵符女娲",对话=string.format("#G洗练成功！\n#Y原特殊属性: %s +%d%% \n#G新特殊属性: %s +%d%%",旧属性, 旧值,新特殊属性, 新特殊属性值),选项={"继续洗练","取消洗练"}})
end


function 道具处理类:锦衣进阶(id,道具id)
    local 寻找道具=""
         for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            if  玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]].名称=="玉刚卯" then
                寻找道具=""..玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]].名称
                self.数据[玩家数据[id].角色.道具[n]].数量=self.数据[玩家数据[id].角色.道具[n]].数量-1
                         if self.数据[玩家数据[id].角色.道具[n]].数量<1 then
                             self.数据[玩家数据[id].角色.道具[n]]=nil
                             玩家数据[id].角色.道具[n]=nil
                         end
            break
            end
         end
         end
         if 寻找道具=="" then
            常规提示(id,"#Y没有寻找到背包内含有玉刚卯")
            return
         end
         if self.数据[道具id].锦衣进阶==nil then
         self.数据[道具id].锦衣进阶={技能="无"}
         end

         local 随机技能= 锦衣技能[取随机数(1,#锦衣技能)]
         self.数据[道具id].锦衣进阶.技能=随机技能
             玩家数据[id].锦衣进阶=道具id
         道具刷新(id)
    玩家数据[id].最后对话={}
    玩家数据[id].最后对话.名称="锦衣进阶"
    玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
    发送数据(玩家数据[id].连接id,1501,{名称="锦衣洗练",模型=玩家数据[id].角色.模型,对话="当前锦衣附带技能为："..随机技能.."，请问是否继续洗练",选项={"继续锦衣洗练","取消洗练"}})
end

function 道具处理类:法宝合成(连接id,id,内容,类型)
    local 任务id = 玩家数据[id].角色:取任务(38)
    if 任务id == 0 or 任务数据[任务id]==nil then
        常规提示(id,"#Y/你没有法宝任务，无法合成！")
        return
    elseif 玩家数据[id].角色:取法宝格子() == 0 then
        常规提示(id,"#Y/法宝栏已满,你无法锻造新得法宝！")
        return
    end
    local 所需材料 = {"内丹"}
    for i=1,#任务数据[任务id].法宝材料 do
        所需材料[#所需材料+1] = 任务数据[任务id].法宝材料[i]
    end
    if 任务数据[任务id].额外物品 then
        for i=1,#任务数据[任务id].额外物品 do
            所需材料[#所需材料+1] = 任务数据[任务id].额外物品[i]
        end
    end
    for i=1,#所需材料 do
        local 找到 = false
        for n=1,5 do
            if 内容[n] then
                local 道具id = 玩家数据[id].角色[类型][内容[n]]
                if 道具id ~= 0 and 玩家数据[id].道具.数据[道具id] and 玩家数据[id].道具.数据[道具id].名称 == 所需材料[i] then
                  找到 = true
                  break
                end
            end
        end
        if 找到 == false then
            常规提示(id,"#Y/法宝锻造还缺少"..所需材料[i]..",请找齐材料后再来吧！")
            return
        end
    end
    for n=1,5 do
        if 内容[n] then
            local 道具id = 玩家数据[id].角色[类型][内容[n]]
            self.数据[道具id] = nil
            玩家数据[id].角色[类型][内容[n]]=nil
        end
    end
    self:给予法宝(id,任务数据[任务id].法宝名称)
    玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(38))
    玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(39))
    玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(40))
    玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(41))
    self:索要道具更新(id,类型)
    常规提示(id,"#Y/你获得了1个新的法宝！")
end

function 道具处理类:给予处理(连接id,id,数据)
    if 玩家数据[id].给予数据==nil then
        return
    elseif 玩家数据[id].给予数据.类型==1 then --npc给予
        self:系统给予处理(连接id,id,数据)
        return
    end
    local 对方id=玩家数据[id].给予数据.id
    if 玩家数据[对方id]==nil then
        常规提示(id,"#Y/对方并不在线")
        return
    end
    if 地图处理类:比较距离(id,对方id,500)==false then
        常规提示(id,"#Y/你们的距离太远了")
        return
    end
    -- 给予银子
    local 金额=0
    local 银子来源=数据.银子
    local 名称=玩家数据[id].角色.名称
    local 名称1=玩家数据[对方id].角色.名称
    if 银子来源=="" or 银子来源==nil then
        金额=0
    else
        金额=数据.银子+0
    end
    if 金额<0 then
        return
    end
    if 玩家数据[id].角色.银子<金额 then
        常规提示(id,"#Y/你没有那么多的银子")
        return
    end
    if 金额>0 then
        金额=qz(金额)
        local 之前银子=玩家数据[id].角色.银子
        玩家数据[id].角色.银子=玩家数据[id].角色.银子-金额
        玩家数据[id].角色:日志记录(format("[给予系统-发起]接受账号为[%s][%s][%s]角色%s两银子，初始银子为%s，余额为%s两银子",玩家数据[对方id].账号,对方id,玩家数据[对方id].角色.名称,金额,之前银子,玩家数据[id].角色.银子), "给予系统-发起银子")
        local 之前银子=玩家数据[对方id].角色.银子
        玩家数据[对方id].角色.银子=玩家数据[对方id].角色.银子+金额
        玩家数据[对方id].角色:日志记录(format("[给予系统-接受]发起账号为[%s][%s][%s]角色%s两银子，初始银子为%s，余额为%s两银子",玩家数据[id].账号,id,玩家数据[id].角色.名称,金额,之前银子,玩家数据[对方id].角色.银子), "给予系统-接受银子")
        常规提示(id,format("#Y/你给了%s%s两银子",名称1,金额))
        发送数据(玩家数据[id].连接id,38,{内容="#Y/你给了#R"..名称1.."#G"..金额.."#Y两银子",频道="xt"})

        常规提示(对方id,format("#Y/%s给了你%s两银子",名称,金额))
        发送数据(玩家数据[对方id].连接id,38,{内容="#R/"..名称.."#Y/给了你#G"..金额.."#Y两银子",频道="xt"})

    end
    for n=1,3 do
        local 格子=数据.格子[n]
        if 格子~=nil then
            local 数量 = 数据.数量[n] +0 --给予数量
            local go=true
            if 数量<1 then 数量 = 1 end
            if 数量>99 then --or 数量>99
                __S服务:输出("玩家"..id.." 存在作弊行为！！！给予处理")
                __S服务:断开连接(玩家数据[id].连接id)
                go=false
            end
            if go then
                数量=math.floor(数量)
                local 道具id=玩家数据[id].角色.道具[格子]
                if 道具id~=nil and 玩家数据[id].道具.数据[道具id]~=nil then
                    if 玩家数据[id].道具.数据[道具id].绑定 or 玩家数据[id].道具.数据[道具id].不可交易 or 玩家数据[id].道具.数据[道具id].专用 then
                        常规提示(id,"#Y/该物品无法交易或给予给他人")
                    else
                        local 对方格子=玩家数据[对方id].角色:取道具格子()
                        if 对方格子==0 then
                            常规提示(id,"#Y/对方身上没有足够的空间")
                        else
                            local 对方道具=玩家数据[对方id].道具:取新编号()
                            local 道具名称=玩家数据[id].道具.数据[道具id].名称
                            local 道具识别码=玩家数据[id].道具.数据[道具id].识别码
                            if 玩家数据[id].道具:检查道具是否存在(id,道具识别码,数量) then
                                玩家数据[对方id].道具.数据[对方道具]=table.loadstring(table.tostring(玩家数据[id].道具.数据[道具id]))
                                玩家数据[对方id].角色.道具[对方格子]=对方道具
                                if 玩家数据[id].道具.数据[道具id].可叠加 and   玩家数据[id].道具.数据[道具id].数量 ~= nil and   玩家数据[id].道具.数据[道具id].数量 ~= "假" then
                                    if 玩家数据[id].道具.数据[道具id].数量 - 数量 > 0 then
                                        玩家数据[对方id].道具.数据[对方道具].数量 = 数量
                                        玩家数据[id].道具.数据[道具id].数量 = 玩家数据[id].道具.数据[道具id].数量 - 数量
                                    else
                                        玩家数据[id].道具.数据[道具id]=nil
                                        玩家数据[id].角色.道具[格子]=nil
                                    end
                                else
                                    玩家数据[id].道具.数据[道具id]=nil
                                    玩家数据[id].角色.道具[格子]=nil
                                end
                                -- 常规提示(id,"#Y/你给了"..名称1..玩家数据[对方id].道具.数据[对方道具].名称)
                                -- 常规提示(对方id,"#Y/"..名称.."给了你"..玩家数据[对方id].道具.数据[对方道具].名称)

                                 local  给予宝石 = 玩家数据[对方id].道具.数据[对方道具].等级
                                 local  给予兽决 = 玩家数据[对方id].道具.数据[对方道具].附带技能
                                 if 道具名称=="太阳石" or 道具名称=="黑宝石" or 道具名称=="舍利子" or 道具名称=="星辉石"  or 道具名称=="红玛瑙" or 道具名称=="月亮石" then
                                    发送数据(玩家数据[id].连接id,38,{内容="#Y/你给了#R"..名称1.."#Y"..给予宝石.."级#G"..道具名称,频道="xt"})

                                    发送数据(玩家数据[对方id].连接id,38,{内容="#R/"..名称.."#Y/给了你"..给予宝石.."级#G"..道具名称,频道="xt"})

                                    常规提示(id,"#Y/你给了"..名称1.."#Y"..给予宝石.."级#G"..道具名称)
                                    常规提示(对方id,"#Y/"..名称.."给了你#Y"..给予宝石.."级#G"..道具名称)
                                elseif 道具名称=="魔兽要诀" or 道具名称=="高级魔兽要诀" or 道具名称=="特殊魔兽要诀" or 道具名称=="特殊兽诀" or 道具名称=="超级魔兽要诀" then
                                    发送数据(玩家数据[id].连接id,38,{内容="#Y/你给了#R"..名称1.."#G"..道具名称.." #Y附带技能:#G"..给予兽决,频道="xt"})

                                    发送数据(玩家数据[对方id].连接id,38,{内容="#R/"..名称.."#Y/给了你"..道具名称.."附带技能:#G"..给予兽决,频道="xt"})
                                    常规提示(对方id,"#Y/"..名称.."给了你"..道具名称.."附带技能:#G"..给予兽决)

                                    常规提示(id,"#Y/你给了"..名称1.."#G"..道具名称.." #Y附带技能:#G"..给予兽决)
                                    else
                                    常规提示(id,"#Y/你给了"..名称1.."#G"..道具名称)
                                    常规提示(对方id,"#Y/"..名称.."给了你"..道具名称)

                                    发送数据(玩家数据[id].连接id,38,{内容="#Y/你给了#R"..名称1.."#G"..道具名称,频道="xt"})
                                    发送数据(玩家数据[对方id].连接id,38,{内容="#R/"..名称.."#Y/给了你"..道具名称,频道="xt"})

                                  end


                                玩家数据[id].角色:日志记录(format("[给予系统-发起]物品名称%s、识别码%s,对方信息[%s][%s][%s]",道具名称,道具识别码,玩家数据[对方id].账号,对方id,名称1), "给予系统-发起物品")
                                玩家数据[对方id].角色:日志记录(format("[给予系统-接受]物品名称%s、识别码%s,对方信息[%s][%s][%s]",道具名称,道具识别码,玩家数据[id].账号,id,名称), "给予系统-接受物品")
                                -- 更改道具归属(道具识别码,玩家数据[对方id].账号,对方id,名称1)
                            end
                        end
                    end
                end
            end
        end
    end

    道具刷新(id)
    道具刷新(对方id)
    玩家数据[id].角色:存档()--给予存档
    玩家数据[对方id].角色:存档()--给予存档
    玩家数据[id].给予数据=nil
end

function 道具处理类:取武器类型(子类)
  local n = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
  for i=1,#n do
    if n[i]==子类 then
        return i
    end
  end
end

function 道具处理类:迷宫奖励(id)
    if 迷宫数据[id]~=nil  then
        添加最后对话(id,"你不是已经领取过奖励了吗？")
        return
    end
    迷宫数据[id]=true
    local 等级=玩家数据[id].角色.等级
    local 经验=等级*等级+30000
    local 银子=等级*等级+20000
    -- 玩家数据[id].角色:添加经验(经验,"幻域迷宫")
    -- 玩家数据[id].角色:添加银子(银子,"幻域迷宫",1)
    local 奖励参数=取随机数(1,500)
    if 奖励参数<=100 then
         local 名称=取宝石()
         玩家数据[id].道具:给予道具(id,名称,取随机数(1,1))
         广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
    elseif 奖励参数<=110 then
         local 名称="高级魔兽要诀"
         玩家数据[id].道具:给予道具(id,名称)
         广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
     elseif 奖励参数<=250 then
         local 名称="修炼果"
         玩家数据[id].道具:给予道具(id,名称)
         广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
     elseif 奖励参数<=300 then
         local 名称="九转金丹"
         玩家数据[id].道具:给予道具(id,名称,1,500)
         广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
    else
         local 名称="星辉石"
         玩家数据[id].道具:给予道具(id,名称,1)
         广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
    end
    if 迷宫数据.奖励<5 then
        迷宫数据.奖励=迷宫数据.奖励+1
        if 取随机数()<=50 then
            self:给予道具(id,"灵饰指南书",{6,8,10})
            广播消息({内容=format("#S(幻域迷宫)#R/%s#Y以惊人的速度率先通过了所有迷宫，获得了迷宫守卫额外奖励的#G/%s#Y",玩家数据[id].角色.名称,"灵饰指南书"),频道="xt"})
        else
            self:给予道具(id,"元灵晶石",{6,8,10,12,14})
            广播消息({内容=format("#S(幻域迷宫)#R/%s#Y以惊人的速度率先通过了所有迷宫，获得了迷宫守卫额外奖励的#G/%s#Y",玩家数据[id].角色.名称,"元灵晶石"),频道="xt"})
        end
    end
    道具刷新(id)
end


function 道具处理类:高级藏宝图处理(id)
    local 奖励参数=取随机数(1,110)
    local 链接 = {提示=format("#Y天降福缘！#G/%s#Y拿着获得的高级藏宝图，在野外挖宝惊喜的获得了",玩家数据[id].角色.名称),频道="xt",结尾="#24#Y。"}
    if 奖励参数<=5 then
        --玩家数据[id].道具:给予超链接书铁(id,{12,14},nil,链接)
        --常规提示(id,"#Y你获得了一个宝贝")
        玩家数据[id].角色:添加银子(取随机数(3000000,8000000),"挖宝",1)
    elseif 奖励参数<=10 then
        设置任务205(id)--妖王
        常规提示(id,"#Y#14你放出了千年老妖，等死吧你")
    elseif 奖励参数<=20 then
        local 名称="宝石袋"
        玩家数据[id].道具:给予超链接道具(id,"宝石袋",1,nil,链接)
        常规提示(id,"#Y恭喜，你好像得到了点什么")
    elseif 奖励参数<=40 then
        常规提示(id,"#Y/恭喜，你得到了一本妖怪遗留的书籍")
        玩家数据[id].道具:给予超链接道具(id,"高级魔兽要诀",nil,nil,链接)
    elseif 奖励参数<=60 then
        local 名称="高级召唤兽内丹"
        玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
        --常规提示(id,"#Y你获得了一个宝贝")
    elseif 奖励参数<=65 then
        玩家数据[id].道具:给予超链接道具(id,"神兜兜",1,nil,链接)
        --常规提示(id,"#Y你获得了一个宝贝")
    elseif 奖励参数<=75 then
        玩家数据[id].道具:给予超链接书铁(id,{15,15},nil,链接)
    elseif 奖励参数<=85 then
        玩家数据[id].道具:给予超链接道具(id,"彩果",1,nil,链接)
        --常规提示(id,"#Y你获得了一个宝贝")
    elseif 奖励参数<=95 then
        local 名称="星辉石"
        玩家数据[id].道具:给予超链接道具(id,名称,取随机数(1,3),nil,链接)
    elseif 奖励参数<=102 then
        玩家数据[id].角色:添加银子(取随机数(300000,800000),"挖宝",1)
        --常规提示(id,"#Y恭喜！你得到了一件妖怪遗留的宝贝。")
    else
        玩家数据[id].道具:给予超链接道具(id,"未激活的符石",取随机数(1,3),nil,链接)
        --常规提示(id,"#Y你获得了一个宝贝")
        --设置任务102(id) --宝宝窝
    end
--  1、获得某种物品(60-80级装备、花豆、高级魔兽要诀、书铁等)；
-- 　　2、放出妖王
end



-- function 道具处理类:高级藏宝图处理(id)
--     local 奖励参数=取随机数(1,105)
--     local 链接 = {提示=format("#Y天降福缘！#G/%s#Y拿着获得的高级藏宝图，在野外挖宝惊喜的获得了",玩家数据[id].角色.名称),频道="xt",结尾="#24#Y。"}
--     if 奖励参数<=4 then
--         玩家数据[id].道具:给予超链接书铁(id,{15,15},nil,链接)
--         常规提示(id,"#Y你获得了一个宝贝")
--     elseif 奖励参数<=7 then
--         设置任务205(id)
--     elseif 奖励参数<=10 then
--         local 名称="召唤兽内丹"
--         玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
--         常规提示(id,"#Y你获得了一个宝贝")
--     elseif 奖励参数<=14 then
--         常规提示(id,"#Y/你获得了一本妖怪遗留下来的秘籍")
--         玩家数据[id].道具:给予超链接道具(id,"高级魔兽要诀",nil,nil,链接)
--     elseif 奖励参数<=50 then
--         self:取随机装备(id,取随机数(5,7))
--         常规提示(id,"#Y你获得了一个宝贝")
--     elseif 奖励参数<=55 then
--         local 名称="高级召唤兽内丹"
--         玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
--         常规提示(id,"#Y你获得了一个宝贝")
--     elseif 奖励参数<=56 then
--         玩家数据[id].道具:给予超链接道具(id,"神兜兜",1,nil,链接)
--         常规提示(id,"#Y你获得了一个宝贝")
--     elseif 奖励参数<=60 then
--         设置任务205(id) --妖王
--     elseif 奖励参数<=70 then
--         玩家数据[id].道具:给予超链接道具(id,"彩果",1,nil,链接)
--         常规提示(id,"#Y你获得了一个宝贝")
--     elseif 奖励参数<=77 then
--         玩家数据[id].道具:给予超链接道具(id,"分解符",1,nil,链接)
--         常规提示(id,"#Y你获得了一个宝贝")
--     elseif 奖励参数<=82 then
--         设置任务101(id)
--     elseif 奖励参数<=90 then
--         设置任务205(id)
--     else
--         玩家数据[id].道具:给予超链接道具(id,"未激活的符石",1,nil,链接)
--         常规提示(id,"#Y你获得了一个宝贝")
--         --设置任务102(id) --宝宝窝
--     end
-- --  1、获得某种物品(60-80级装备、花豆、高级魔兽要诀等)；
-- -- 　　2、放出妖王
-- -- 　　3、放出宝宝幼儿园
-- end

function 道具处理类:低级藏宝图处理(id)
    local 奖励参数=取随机数(1,170)
    if 奖励参数<=15 then
        玩家数据[id].角色:添加银子(取随机数(3000,8000),"挖宝",1)
    elseif 奖励参数<=18 then
        self:取随机装备(id,取随机数(6,8))
        常规提示(id,"#Y/你得到了妖怪遗留下来的宝物")
    elseif 奖励参数<=20 then --设置
        local 名称=self:取五宝()
        self:给予道具(id,名称)
    elseif 奖励参数<=30 then
        设置任务205(id)
    elseif 奖励参数<=80 then
        self:给予道具(id,"魔兽要诀")
    elseif 奖励参数<=90 then
        常规提示(id,"#Y/你一锄头挖下去挖出了一团瘴气，等你醒来的时候已经身受重伤了")
        玩家数据[id].角色.气血=math.floor(玩家数据[id].角色.气血*0.5)
        玩家数据[id].角色.气血上限=math.floor(玩家数据[id].角色.气血上限*0.5)
        发送数据(玩家数据[id].连接id,47,{玩家数据[id].角色:取气血数据()})
    elseif 奖励参数<=110 then
        战斗准备类:创建战斗(id+0,100003)
        常规提示(id,"#Y/你一锄头挖下去，似乎触碰到了一个奇形怪状的物体")
    elseif 奖励参数<=160 then
        self:给予道具(id,"彩果",1)
    else
        设置任务101(id)
    end
end

function 道具处理类:玲珑宝图处理(id)
    local 奖励参数=取随机数(1,100)
    --奖励参数=100
    local lv = 玩家数据[id].角色.等级
    local fanwei={6,8}
    if lv>=80 and lv<100 then
        fanwei={8,10}
    elseif lv>=100 and lv<120 then
        fanwei={10,12}
    elseif lv>=120 then
        fanwei={10,12,14}
    end
    local 链接
    local 名称
    if 奖励参数<=10 then
        名称=玩家数据[id].角色.等级*1000
        玩家数据[id].角色:添加经验(qz(玩家数据[id].角色.等级*1000),"玲珑宝图")
        添加最后对话(id,"你的修为又增加了，获得了"..名称.."点经验")
    elseif 奖励参数<=45 then
        名称="灵饰指南书"
        链接 = {提示=format("#Y天降大运！#G/%s#Y拿着玲珑宝图，在野外挖宝意外获得了神仙遗留的",玩家数据[id].角色.名称),频道="xt",结尾="#Y。"}
        玩家数据[id].道具:给予超链接道具(id,名称,fanwei,nil,链接,"不存共享")
        添加最后对话(id,"天降大运，你意外获得了神仙遗留的1个"..名称)
    elseif 奖励参数<=80 then
        名称="元灵晶石"
        链接 = {提示=format("#Y天降大运！#G/%s#Y拿着玲珑宝图，在野外挖宝意外获得了神仙遗留的",玩家数据[id].角色.名称),频道="xt",结尾="#Y。"}
        玩家数据[id].道具:给予超链接道具(id,名称,fanwei,nil,链接,"不存共享")
        添加最后对话(id,"天降大运，你意外获得了神仙遗留的1个"..名称)
    elseif 奖励参数<=92 then
        名称="符石卷轴"
        链接 = {提示=format("#Y天降大运！#G/%s#Y拿着玲珑宝图，在野外挖宝意外获得了神仙遗留的",玩家数据[id].角色.名称),频道="xt",结尾="#Y。"}
        玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接,"不存共享")
        添加最后对话(id,"天降大运，你意外获得了神仙遗留的1个"..名称)
    elseif 奖励参数<=95 then
        设置任务101(id)
    else
        设置任务205(id)
    end
end

function 道具处理类:完成宝图遇怪(id)
    local 奖励参数=取随机数()
    if 奖励参数<=100 then
        local 名称=取宝石()
        self:给予道具(id,名称,取随机数(1,1))
        发送数据(玩家数据[id].连接id,38,{内容="你得到了#R/"..名称})
    elseif 奖励参数<=40 then
        self:取随机装备(id,取随机数(2,7))
    end
    local 临时经验=取等级(id)*50+1000
    玩家数据[id].角色:添加经验(临时经验,"挖图遇怪",1)
end

function 道具处理类:取五宝()
    return 五宝名称[取随机数(1,5)]
end

function 道具处理类:取战斗奇袭数据(id)
    local data = {}
    data.物伤化劲 = 0
    data.法伤化劲 = 0
  data.固伤化劲 = 0
  data.坚如磐石 = 0
    local s奇袭法术 = 0
    local 特效概率 = 0
    if 玩家数据[id].角色["上古玉魄·阳"] then
        local 道具id = 玩家数据[id].角色["上古玉魄·阳"]
        if self.数据[道具id] and string.find(self.数据[道具id].名称,"上古玉魄") then
            s奇袭法术 = s奇袭法术 + self.数据[道具id].等级
            if #self.数据[道具id].特技 > 0 then
                data.特技 = table.copy(self.数据[道具id].特技)
            end
            if self.数据[道具id].特效 == "奇袭法术" then
                特效概率 = 特效概率 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "物伤化劲" then
                data.物伤化劲 = data.物伤化劲 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "法伤化劲" then
                data.法伤化劲 = data.法伤化劲 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "固伤化劲" then
                data.固伤化劲 = data.固伤化劲 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "坚如磐石" then
                data.坚如磐石 = data.坚如磐石 + self.数据[道具id].特效值
            end
        end
    end
    if 玩家数据[id].角色["上古玉魄·阴"] then
        local 道具id = 玩家数据[id].角色["上古玉魄·阴"]
        if self.数据[道具id] and string.find(self.数据[道具id].名称,"上古玉魄") then
            s奇袭法术 = s奇袭法术 + self.数据[道具id].等级
            if #self.数据[道具id].三药 > 0 then
                data.三药 = table.copy(self.数据[道具id].三药)
            end
            if self.数据[道具id].特效 == "奇袭法术" then
                特效概率 = 特效概率 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "物伤化劲" then
                data.物伤化劲 = data.物伤化劲 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "法伤化劲" then
                data.法伤化劲 = data.法伤化劲 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "固伤化劲" then
                data.固伤化劲 = data.固伤化劲 + self.数据[道具id].特效值
            elseif self.数据[道具id].特效 == "坚如磐石" then
                data.坚如磐石 = data.坚如磐石 + self.数据[道具id].特效值
            end
        end
    end
    local 调试加概率 = 0
    if 调试模式 then
        if s奇袭法术 ~= 0 then
            调试加概率 = 40
        end
    end
    data.奇袭法术 = s奇袭法术 + 调试加概率 + 特效概率
    -- table.print(data)
    if data.特技 or data.三药 or data.奇袭法术 then
        return data
    else
        return false
    end
end
function 道具处理类:生成上古玉魄(id,名称,超链接)
    local 道具格子=玩家数据[id].角色:取道具格子()
    local 临时格子 =玩家数据[id].角色:取临时格子()
    if 道具格子 == 0 and 临时格子 == 0 then
        常规提示(id,"#Y你的背包和临时背包满了！无法获得上古玉魄")
        return
    end
    -------------------
    local 临时道具 =物品类()
    临时道具:置对象(名称)
    临时道具.等级 = 0
    临时道具.宝石 = {}
    临时道具.耐久 = 500
    临时道具.特技 = {}
    临时道具.三药 = {}
    临时道具.女娲符 = {}
    local data主属性 = 灵饰属性[名称].主属性
    local x主属性 = data主属性[取随机数(1,#data主属性)]
    local data副属性 = table.copy(灵饰属性[名称].副属性)
    table.insert(data副属性,"固伤暴击等级")
    local s灵饰副属性 = table.copy(灵饰副属性)
    s灵饰副属性.固伤暴击等级={[160]={a=128,b=142},[140]={a=10,b=15},[120]={a=9,b=13},[100]={a=8,b=12},[80]={a=8,b=10},[60]={a=6,b=9}} --玉魄专有
    -----------
    local x副属性 = {}
    for n=1,2 do
        local sss = 取随机数(1,#data副属性)
        x副属性[n] = data副属性[sss]
        table.remove(data副属性,sss)
    end
    if not 灵饰主属性[x主属性] then
        print("不要乱写主属性",x主属性)
    end
    if not x副属性[1] or not s灵饰副属性[x副属性[1]] then
        print("不要乱写副属性",x副属性[1] )
    end
    if not x副属性[2] or not s灵饰副属性[x副属性[2]] then
        print("不要乱写副属性",x副属性[2] )
    end
    local 主属性范围 = 灵饰主属性[x主属性][160]
    local 副属性范围1 = s灵饰副属性[x副属性[1]][160]
    local 副属性范围2 = s灵饰副属性[x副属性[2]][160]
    临时道具[1] = {类型=x主属性,数值=取随机数(主属性范围.a,主属性范围.b)} --主属性
    临时道具[2] = {类型=x副属性[1],数值=取随机数(副属性范围1.a,副属性范围1.b)} --副属性1
    临时道具[3] = {类型=x副属性[2],数值=取随机数(副属性范围2.a,副属性范围2.b)} --副属性2
    临时道具[4] = {类型=x副属性[2],数值=取随机数(副属性范围2.a,副属性范围2.b)} --副属性2

    临时道具.宝石[1] = self:上古玉魄宝石计算(临时道具.等级,临时道具[2].类型)
    临时道具.宝石[2] = self:上古玉魄宝石计算(临时道具.等级,临时道具[3].类型)

    -- 生成特效（原有）
    if 取随机数(1,100) <= 10 then
        local texiao = {"奇袭法术","物伤化劲","法伤化劲","固伤化劲","坚固无痕","坚如磐石"}
        local s百分比范围 = {
            奇袭法术 = {3,20}, --奇袭法术几率 --完成
            物伤化劲 = {3,20},--概率多少就减少多少物理伤害
            法伤化劲 = {3,20},--概率多少就减少多少法术伤害
            固伤化劲 = {3,20},--概率多少就减少多少固伤伤害
            坚固无痕 = {3,20},--耐久消耗百分比
            坚如磐石 = {3,20}--增加护盾值百分百
        }
        临时道具.特效 = texiao[取随机数(1,#texiao)]
        临时道具.特效值 = 取随机数(s百分比范围[临时道具.特效][1],s百分比范围[临时道具.特效][2])
    end
    -- 生成特殊属性（新增）
    if 取随机数(1,100) <= 10 then  -- 5%概率获得特殊属性
        local 特殊属性列表 = {}
        local 特殊属性值范围 = {}
        if string.find(名称, "阳") then
            特殊属性列表 = {"伤害","速度","法术伤害","治疗能力","狂暴等级","物理暴击等级","法术暴击等级","封印命中等级","法术伤害结果","固伤暴击等级"}
            特殊属性值范围 = {
                伤害 = {3,20},
                速度 = {3,20},
                法术伤害 = {3,20},
                治疗能力 = {3,20},
                狂暴等级 = {3,20},
                物理暴击等级 = {3,20},
                法术暴击等级 = {3,20},
                封印命中等级 = {3,20},
                法术伤害结果 = {3,20},
                固伤暴击等级 = {3,20},
            }
        elseif string.find(名称, "阴") then
            特殊属性列表 ={"气血","防御","法术防御","抗物理暴击等级","抗法术暴击等级","抵抗封印等级","格挡值","气血回复效果","固伤暴击等级"}
            特殊属性值范围 = {
                气血 = {5,25},
                防御 = {3,20},
                法术防御 = {3,20},
                抗物理暴击等级 = {3,20},
                抗法术暴击等级 = {3,20},
                抵抗封印等级 = {3,20},
                格挡值 = {5,25},
                气血回复效果 = {3,20},
            }
        end
        临时道具.特殊属性 = 特殊属性列表[取随机数(1,#特殊属性列表)]
        临时道具.特殊属性值 = 取随机数(特殊属性值范围[临时道具.特殊属性][1],特殊属性值范围[临时道具.特殊属性][2])
    end

    临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    随机序列=随机序列+1
    local 道具id=self:取新编号()
    self.数据[道具id] = table.copy(临时道具)
    if 道具格子 ~= 0 then
        玩家数据[id].角色.道具[道具格子]=道具id
    else
        玩家数据[id].角色.临时包裹[临时格子]=道具id
    end
    if 超链接 and self.数据[道具id] then
        local 文本 = 超链接.提示.."#G/qqq|"..self.数据[道具id].名称.."*"..self.数据[道具id].识别码.."*道具".."/["..self.数据[道具id].名称.."]#W"..超链接.结尾
        local 返回信息 = {}
        返回信息[#返回信息+1] = self.数据[道具id]
        返回信息[#返回信息].索引类型 = "道具"
        广播消息({内容=文本,频道=超链接.频道,方式=1,超链接=返回信息})
    end
    道具刷新(id)
    常规提示(id,"#Y恭喜获得#R/" ..名称)
end
-- function 道具处理类:生成上古玉魄(id,名称)
--     local 道具格子=玩家数据[id].角色:取道具格子()
--     local 临时格子 =玩家数据[id].角色:取临时格子()
--     if 道具格子 == 0 and 临时格子 == 0 then
--         常规提示(id,"#Y你的背包和临时背包满了！无法获得上古玉魄")
--         return
--     end
--     -------------------
--     local 临时道具 =物品类()
--     临时道具:置对象(名称)
--     临时道具.等级 = 0
--     临时道具.宝石 = {}
--     临时道具.耐久 = 500
--     临时道具.特技 = {}
--     临时道具.三药 = {}
--     临时道具.女娲符 = {}
--     local data主属性 = 灵饰属性[名称].主属性
--     local x主属性 = data主属性[取随机数(1,#data主属性)]
--     local data副属性 = table.copy(灵饰属性[名称].副属性)
--     table.insert(data副属性,"固伤暴击等级")
--     local s灵饰副属性 = table.copy(灵饰副属性)
--     s灵饰副属性.固伤暴击等级={[160]={a=128,b=142},[140]={a=10,b=15},[120]={a=9,b=13},[100]={a=8,b=12},[80]={a=8,b=10},[60]={a=6,b=9}} --玉魄专有
--     -----------
--     local x副属性 = {}
--     for n=1,2 do
--         local sss = 取随机数(1,#data副属性)
--         x副属性[n] = data副属性[sss]
--         table.remove(data副属性,sss)
--     end
--     if not 灵饰主属性[x主属性] then
--         print("不要乱写主属性",x主属性)
--     end
--     if not x副属性[1] or not s灵饰副属性[x副属性[1]] then
--         print("不要乱写副属性",x副属性[1] )
--     end
--     if not x副属性[2] or not s灵饰副属性[x副属性[2]] then
--         print("不要乱写副属性",x副属性[2] )
--     end
--     local 主属性范围 = 灵饰主属性[x主属性][160]
--     local 副属性范围1 = s灵饰副属性[x副属性[1]][160]
--     local 副属性范围2 = s灵饰副属性[x副属性[2]][160]
--     临时道具[1] = {类型=x主属性,数值=取随机数(主属性范围.a,主属性范围.b)} --主属性
--     临时道具[2] = {类型=x副属性[1],数值=取随机数(副属性范围1.a,副属性范围1.b)} --副属性1
--     临时道具[3] = {类型=x副属性[2],数值=取随机数(副属性范围2.a,副属性范围2.b)} --副属性2
--     临时道具.宝石[1] = self:上古玉魄宝石计算(临时道具.等级,临时道具[2].类型)
--     临时道具.宝石[2] = self:上古玉魄宝石计算(临时道具.等级,临时道具[3].类型)
--     if 取随机数(1,100) <= 10 then
--         local texiao = {"奇袭法术","物伤化劲","法伤化劲","固伤化劲","坚固无痕","坚如磐石"}
--         local s百分比范围 = {
--             奇袭法术 = {3,20}, --奇袭法术几率 --完成
--             物伤化劲 = {3,35},--概率多少就减少多少物理伤害
--             法伤化劲 = {3,35},--概率多少就减少多少法术伤害
--             固伤化劲 = {3,35},--概率多少就减少多少固伤伤害
--             坚固无痕 = {3,35},--耐久消耗百分比
--             坚如磐石 = {3,35}--增加护盾值百分百
--         }
--         临时道具.特效 = texiao[取随机数(1,#texiao)]
--         临时道具.特效值 = 取随机数(s百分比范围[临时道具.特效][1],s百分比范围[临时道具.特效][2])
--     end

--     临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
--     随机序列=随机序列+1
--     local 道具id=self:取新编号()
--     self.数据[道具id] = table.copy(临时道具)
--     if 道具格子 ~= 0 then
--         玩家数据[id].角色.道具[道具格子]=道具id
--     else
--         玩家数据[id].角色.临时包裹[临时格子]=道具id
--     end
--     道具刷新(id)
--     常规提示(id,"#Y恭喜获得#R/" ..名称)
-- end

function 道具处理类:上古玉魄宝石计算(x等级,x属性)
    local 星辉石属性={
        气血回复效果=8,
        气血=28,
        抗封印等级=8,
        抗法术暴击等级=8,
        抗物理暴击等级=8,
        防御=8,
        格挡值=8,
        法术防御=8,
        固定伤害=4,
        法术伤害=4,
        伤害=4,
        封印命中等级=4,
        法术暴击等级=4,
        物理暴击等级=4,
        狂暴等级=3,
        穿刺等级=4,
        法术伤害结果=3,
        治疗能力=3,
        速度=3,
        固伤暴击等级=8
    }
    local sss = 0
    if 星辉石属性[x属性] then
        sss = x等级 * 星辉石属性[x属性]
    end
    return sss
end

function 道具处理类:刷新上古玉魄属性(数字id,道具id)
    if not self.数据[道具id] or self.数据[道具id].总类 ~= "上古玉魄" then return end
    self.数据[道具id].宝石[1] = self:上古玉魄宝石计算(self.数据[道具id].等级,self.数据[道具id][2].类型)
    self.数据[道具id].宝石[2] = self:上古玉魄宝石计算(self.数据[道具id].等级,self.数据[道具id][3].类型)
end

function 道具处理类:玉魄镶嵌或卸下(数字id,s数据)
    -- table.print(s数据,"========768768756")
    local x操作 = s数据.x操作
    local 镶嵌孔 = s数据.镶嵌孔 or 3
    local 背包类型 = s数据.背包类型
    local 物品id = tonumber(s数据.物品id)
    local 装备道具=self.数据[玩家数据[数字id].玉魄镶嵌]
    if 装备道具==nil then
        常规提示(数字id,"你没有这样的装备！")
        return
    elseif 装备道具.总类~="上古玉魄" then
        常规提示(数字id,"我这里目前只能点化上古玉魄，其它的我可没那么大的能耐。")
        return
    elseif not 镶嵌孔 or 镶嵌孔 > 3 then
        return
    end
    local s等级 = 装备道具.等级
    local 要求等级 = 镶嵌孔*5
    if 调试模式 then
        要求等级=0
    end
    if self.数据[玩家数据[数字id].玉魄镶嵌].女娲符 == nil then
        self.数据[玩家数据[数字id].玉魄镶嵌].女娲符 = {}
    end
    if x操作 == "镶嵌" then
        if s等级 < 要求等级 then
            常规提示(数字id,"#Y第" ..镶嵌孔 .."个孔要求灵尘等级" ..要求等级)
            return
        end
        if self.数据[玩家数据[数字id].玉魄镶嵌].女娲符[镶嵌孔] then
            常规提示(数字id,"该孔已经镶嵌了！")
            return
        end
        local 女娲id = 物品id and 玩家数据[数字id].角色[背包类型] and 玩家数据[数字id].角色[背包类型][物品id]
        local 女娲符 = 女娲id and self.数据[女娲id]
        if not 女娲符 or 女娲符.总类~="玉魄镶嵌" then
            常规提示(数字id,"你没有女娲符！")
            return
        end
        if 装备道具.名称 == "上古玉魄·阴" then
            local x三药 = self.数据[女娲id].三药 or "金创药"
            self.数据[玩家数据[数字id].玉魄镶嵌].女娲符[镶嵌孔] = {名称=self.数据[女娲id].名称,三药=x三药}
            self.数据[玩家数据[数字id].玉魄镶嵌].三药[镶嵌孔] = x三药
        else
            local x特技 = self.数据[女娲id].特技 or "野兽之力"
            self.数据[玩家数据[数字id].玉魄镶嵌].女娲符[镶嵌孔] = {名称=self.数据[女娲id].名称,特技=x特技}
            self.数据[玩家数据[数字id].玉魄镶嵌].特技[镶嵌孔] = x特技
        end
        玩家数据[数字id].角色[背包类型][物品id] = nil
        self.数据[女娲id] = nil
        常规提示(数字id,"镶嵌成功！")
    elseif x操作 == "卸下" then
        local 给予名称 = "女娲灵契"
        local 给予附加 = self.数据[玩家数据[数字id].玉魄镶嵌].女娲符[镶嵌孔].特技 or "野兽之力"
        if 装备道具.名称 == "上古玉魄·阴" then
            给予名称 = "女娲祝符"
            给予附加 = self.数据[玩家数据[数字id].玉魄镶嵌].女娲符[镶嵌孔].三药 or "金创药"
            self.数据[玩家数据[数字id].玉魄镶嵌].女娲符[镶嵌孔] = nil
            self.数据[玩家数据[数字id].玉魄镶嵌].三药[镶嵌孔] = nil
        else
            self.数据[玩家数据[数字id].玉魄镶嵌].女娲符[镶嵌孔] = nil
            self.数据[玩家数据[数字id].玉魄镶嵌].特技[镶嵌孔] = nil
        end
        玩家数据[数字id].道具:给予道具(数字id,给予名称,nil,给予附加,"不存共享")
        常规提示(数字id,"卸下成功！")
    end
    道具刷新(数字id)
    发送数据(玩家数据[数字id].连接id,3550.5,{装备=self.数据[玩家数据[数字id].玉魄镶嵌]})
end

function 道具处理类:灵饰处理(id,名称,等级,强化,类型)
    local 临时道具 =物品类()
    临时道具:置对象(名称)
    临时道具.等级 = 等级
    临时道具.幻化等级=0
    临时道具.部位类型=类型
    临时道具.灵饰=true
    临时道具.耐久=500
    临时道具.鉴定=false
    临时道具.幻化属性={附加={},}
    临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    随机序列=随机序列+1
    self.临时属性=灵饰属性[类型].主属性[取随机数(1,#灵饰属性[类型].主属性)]
    self.临时数值=灵饰主属性[self.临时属性][等级].b
    self.临时下限=灵饰主属性[self.临时属性][等级].a
    self.临时数值=取随机数(self.临时下限,self.临时数值)
    -- if 强化==1 then
    --  self.临时数值=math.floor(self.临时数值*1.5)
    -- end
    临时道具.幻化属性.基础={类型=self.临时属性,数值=self.临时数值,强化=0}
    for n=1,取随机数(1,3) do
        self.临时属性=灵饰属性[类型].副属性[取随机数(1,#灵饰属性[类型].副属性)]
        self.临时数值=灵饰副属性[self.临时属性][等级].b
        self.临时下限=灵饰副属性[self.临时属性][等级].a
        self.临时数值=取随机数(self.临时下限,self.临时数值)
        for i=1,#临时道具.幻化属性.附加 do
            if 临时道具.幻化属性.附加[i].类型==self.临时属性 then
                self.临时数值=临时道具.幻化属性.附加[i].数值
            end
        end
        临时道具.幻化属性.附加[n]={类型=self.临时属性,数值=self.临时数值,强化=0}
    end
    return 临时道具
end

function 道具处理类:dz灵饰处理(id,名称,等级,类型)
    local 临时道具 =物品类()
    临时道具:置对象(名称)
    临时道具.等级 = 等级
    临时道具.幻化等级=0
    临时道具.部位类型=类型
    临时道具.灵饰=true
    临时道具.耐久=500
    临时道具.鉴定=false
    临时道具.幻化属性={附加={},}
    临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    随机序列=随机序列+1
    self.临时属性=灵饰属性[类型].主属性[取随机数(1,#灵饰属性[类型].主属性)]
    self.临时数值=灵饰主属性[self.临时属性][等级].b
    self.临时下限=灵饰主属性[self.临时属性][等级].a
    self.临时数值=取随机数(self.临时下限,self.临时数值)
    临时道具.幻化属性.基础={类型=self.临时属性,数值=self.临时数值,强化=0}
    for n=1,3 do
        self.临时属性=灵饰属性[类型].副属性[取随机数(1,#灵饰属性[类型].副属性)]
        if n>1 and RpbARGB.序列==3 and 取随机数()<=30 then
               self.临时属性=临时道具.幻化属性.附加[1].类型
        end
        self.临时数值=灵饰副属性[self.临时属性][等级].b
        self.临时下限=灵饰副属性[self.临时属性][等级].a
        self.临时数值=取随机数(self.临时下限,self.临时数值)
        for i=1,#临时道具.幻化属性.附加 do
            if 临时道具.幻化属性.附加[i].类型==self.临时属性 then
                self.临时数值=临时道具.幻化属性.附加[i].数值
            end
        end
        临时道具.幻化属性.附加[n]={类型=self.临时属性,数值=self.临时数值,强化=0}
    end
    -- 临时道具.特效="无级别限制"
    -- if not 正式 then 临时道具.专用 = id end
    if 等级==160 then
        临时道具.特效="无级别限制"
    end
    return 临时道具
end



function 道具处理类:烹饪处理(连接id,数字id,数据)
    local 临时等级=玩家数据[数字id].角色:取生活技能等级("烹饪技巧")
    local 临时消耗=20
    if 玩家数据[数字id].角色.活力<临时消耗 then
        常规提示(数字id,"本次操作需要消耗"..临时消耗.."点活力")
        return
    end
    local 物品表={}
    玩家数据[数字id].角色.活力= 玩家数据[数字id].角色.活力-临时消耗
    体活刷新(数字id)
    if 临时等级<=4 then
     物品表={"包子"}
    elseif 临时等级<=9 then
     物品表={"包子","包子","佛跳墙","包子"}
    elseif 临时等级<=14 then
     物品表={"包子","包子","佛跳墙","包子","烤鸭"}
    elseif 临时等级<=19 then
     物品表={"包子","珍露酒","佛跳墙","烤鸭","佛跳墙","佛跳墙","包子","烤鸭"}
    elseif 临时等级<=24 then
     物品表={"包子","珍露酒","佛跳墙","佛跳墙","醉生梦死","烤鸭","包子","烤鸭","虎骨酒","佛跳墙","佛跳墙","包子","女儿红"}
    elseif 临时等级<=29 then
     物品表={"包子","珍露酒","豆斋果","佛跳墙","烤鸭","包子","佛跳墙","醉生梦死","烤鸭","虎骨酒","烤鸭","包子","女儿红"}
 elseif 临时等级<=34 then
     物品表={"包子","佛跳墙","佛跳墙","醉生梦死","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
    elseif 临时等级<=39 then
     物品表={"烤肉","桂花丸","佛跳墙","佛跳墙","醉生梦死","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
    elseif 临时等级<=44 then
     物品表={"烤肉","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
    elseif 临时等级<=49 then
     物品表={"烤肉","长寿面","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
    elseif 临时等级<=54 then
     物品表={"烤肉","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
    elseif 临时等级<=59 then
     物品表={"烤肉","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","醉生梦死","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
    elseif 临时等级<=64 then
     物品表={"烤肉","蛇胆酒","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
    else
     物品表={"烤肉","醉生梦死","蛇胆酒","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","珍露酒","豆斋果","臭豆腐","佛跳墙","烤鸭","虎骨酒","女儿红"}
    end
    local 临时物品=物品表[取随机数(1,#物品表)]
    local 临时品质=0
    if 临时物品~="包子" then
        临时品质=qz(取随机数(math.floor(临时等级*0.5),临时等级)*数据)
    end
    常规提示(数字id,"#W/经过一阵忙碌，你烹制出了#R/"..临时物品)
    self:给予道具(数字id,临时物品,1,临时品质)
    发送数据(连接id,3699)
end

function 道具处理类:炼药处理(连接id,数字id,数据)
    local 临时等级=玩家数据[数字id].角色:取生活技能等级("中药医理")--+140--测试
    local 临时消耗=20
    if 玩家数据[数字id].角色.活力<临时消耗 then
     常规提示(数字id,"本次操作需要消耗"..临时消耗.."点活力")
     return
    elseif 临时等级<10 then
     常规提示(数字id,"您的中药医理技能尚未达到10级，无法进行炼药操作")
     return
    elseif 玩家数据[数字id].角色.银子<5000 then
        常规提示(数字id,"炼药需要消耗5000两银子")
        return
    end
    玩家数据[数字id].角色:扣除银子(5000,0,0,"炼药消耗",1)
    玩家数据[数字id].角色.活力= 玩家数据[数字id].角色.活力-临时消耗
    体活刷新(数字id)
    local 物品表={}
    物品表={"金创药","金香玉","金创药","金创药","小还丹","千年保心丹","金创药","金创药","风水混元丹","金创药","金创药","定神香","金创药","蛇蝎美人","金创药","金创药","九转回魂丹","金创药","佛光舍利子","金创药","十香返生丸","金创药","五龙丹"}
    local 临时物品=物品表[取随机数(1,#物品表)]
    local 临时品质=0
    临时品质=qz(取随机数(math.floor(临时等级*0.5),临时等级*1.1))
    -- 常规提示(数字id,"#W/恭喜你成功炼制出了#R/"..临时物品)
    self:给予道具(数字id,临时物品,1,临时品质)
    发送数据(连接id,3699)
end

function 道具处理类:消耗背包道具(连接id,id,名称,数量)
    local 扣除数量 = 数量
    local 扣除数据={}
    local 已扣除=0
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 and 已扣除<扣除数量 then
            if self.数据[玩家数据[id].角色.道具[n]].数量 == nil then
                已扣除=已扣除+1
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=1}
            else
                if self.数据[玩家数据[id].角色.道具[n]].数量>=扣除数量-已扣除 then
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=扣除数量-已扣除}
                    已扣除=已扣除+(扣除数量-已扣除)
                else
                    已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
                end
            end
        end
    end

    if 已扣除<扣除数量 then
        if 玩家数据[id].zhandou==0 then
            常规提示(id,"你没有那么多的"..名称)
        else
            发送数据(连接id, 38, {内容 = "你没有那么多的"..名称})
        end
        return false
    else
        for n=1,#扣除数据 do
            玩家数据[id].道具:删除道具(连接id,id,"道具",扣除数据[n].id,扣除数据[n].格子,扣除数据[n].数量)
        end
        发送数据(连接id,3699)
        return true
    end
    return false
end

function 道具处理类:消耗指定背包道具(连接id,id,名称,数量,类型)
    local 扣除数量 = 数量
    local 扣除数据={}
    local 已扣除=0
    for n=1,80 do
        if 玩家数据[id].角色[类型][n]~=nil and self.数据[玩家数据[id].角色[类型][n]]~=nil and self.数据[玩家数据[id].角色[类型][n]].名称==名称 and 已扣除<扣除数量 then
            if self.数据[玩家数据[id].角色[类型][n]].数量 == nil then
                已扣除=已扣除+1
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色[类型][n],数量=1}
            else
                if self.数据[玩家数据[id].角色[类型][n]].数量>=扣除数量-已扣除 then
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色[类型][n],数量=扣除数量-已扣除}
                    已扣除=已扣除+(扣除数量-已扣除)
                else
                    已扣除=已扣除+self.数据[玩家数据[id].角色[类型][n]].数量
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色[类型][n],数量=self.数据[玩家数据[id].角色[类型][n]].数量}
                end
            end
        end
    end
    if 已扣除<扣除数量 then
        if 玩家数据[id].zhandou==0 then
            常规提示(id,"你没有那么多的"..名称)
        else
            发送数据(连接id, 38, {内容 = "你没有那么多的"..名称})
        end
        return false
    else
        for n=1,#扣除数据 do
            玩家数据[id].道具:删除道具(连接id,id,类型,扣除数据[n].id,扣除数据[n].格子,扣除数据[n].数量)
        end
        发送数据(连接id,3699)
        return true
    end
    return false
end

function 道具处理类:消耗任务道具(连接id,id,名称,数量)
    local 扣除数量 = 数量
    local 扣除数据={}
    local 已扣除=0
    for n=1,20 do
        if 玩家数据[id].角色.任务包裹[n]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]].名称==名称 and 已扣除<扣除数量 then
            if self.数据[玩家数据[id].角色.任务包裹[n]].数量 == nil then
                已扣除=已扣除+1
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=1}
            else
                if self.数据[玩家数据[id].角色.任务包裹[n]].数量>=扣除数量-已扣除 then
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=扣除数量-已扣除}
                    已扣除=已扣除+(扣除数量-已扣除)
                else
                    已扣除=已扣除+self.数据[玩家数据[id].角色.任务包裹[n]].数量
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=self.数据[玩家数据[id].角色.任务包裹[n]].数量}
                end
            end
        end
    end
    if 已扣除<扣除数量 then
        常规提示(id,"你没有那么多的"..名称)
        return false
    else
        for n=1,#扣除数据 do
            玩家数据[id].道具:删除道具(连接id,id,"任务包裹",扣除数据[n].id,扣除数据[n].格子,扣除数据[n].数量)
        end
        发送数据(连接id,3699)
        return true
    end
end

function 道具处理类:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
    -- if self.数据[道具id].名称=="怪物卡片" then self.数据[道具id].次数=self.数据[道具id].次数-1 end
    if self.数据[道具id]==nil then
        玩家数据[id].角色[包裹类型][道具格子]=nil
        return
    end
    if 包裹类型 ~= "行囊" and 包裹类型 ~= "道具" and 包裹类型 ~= "任务包裹" and 包裹类型 ~= "法宝" then
        return
    end
    if 删除数量==nil then 删除数量=1 end
    if self.数据[道具id].数量==nil and self.数据[道具id].名称~="怪物卡片" and self.数据[道具id].名称~="小象炫卡" and self.数据[道具id].名称~="腾蛇炫卡"  and self.数据[道具id].名称~="龙马炫卡"  and self.数据[道具id].名称~="雪人炫卡" then
        self.数据[道具id]=nil
        玩家数据[id].角色[包裹类型][道具格子]=nil
    elseif self.数据[道具id].名称=="怪物卡片" or self.数据[道具id].名称=="小象炫卡" or self.数据[道具id].名称=="腾蛇炫卡"  or self.数据[道具id].名称=="龙马炫卡"  or self.数据[道具id].名称=="雪人炫卡"  then
        self.数据[道具id].次数=self.数据[道具id].次数-1
        if  self.数据[道具id].次数<=0 then
            self.数据[道具id]=nil
            玩家数据[id].角色[包裹类型][道具格子]=nil
        end
    else
        if type(self.数据[道具id].数量 ) ~= "number" then
            self.数据[道具id]=nil
            玩家数据[id].角色[包裹类型][道具格子]=nil
        else
            self.数据[道具id].数量=self.数据[道具id].数量-删除数量
            if self.数据[道具id].数量<=0  then
                self.数据[道具id]=nil
                玩家数据[id].角色[包裹类型][道具格子]=nil
            end
        end

    end
end

function 道具处理类:判断道具是否有(id,名称)
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 then
            if self.数据[玩家数据[id].角色.道具[n]].限时时间 and os.time() >= self.数据[玩家数据[id].角色.道具[n]].限时时间 then
                return false
            end
            return true
        elseif 玩家数据[id].角色.行囊[n] ~= nil and self.数据[玩家数据[id].角色.行囊[n]]~=nil and self.数据[玩家数据[id].角色.行囊[n]].名称==名称 then
            if self.数据[玩家数据[id].角色.行囊[n]].限时时间 and os.time() >= self.数据[玩家数据[id].角色.行囊[n]].限时时间 then
                return false
            end
            return true
        end
    end
    return false
end

function 道具处理类:判断指定道具栏是否有(id,名称,类型,数量)
    for n=1,80 do
        if 玩家数据[id].角色[类型][n]~=nil and self.数据[玩家数据[id].角色[类型][n]]~=nil and self.数据[玩家数据[id].角色[类型][n]] and self.数据[玩家数据[id].角色[类型][n]].名称==名称 and (数量==nil or self.数据[玩家数据[id].角色[类型][n]].数量 == nil or (self.数据[玩家数据[id].角色[类型][n]].数量 and self.数据[玩家数据[id].角色[类型][n]].数量>=数量)) then
            return true
        end
    end
    return false
end

function 道具处理类:取对方道具(id,名称)
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 then
            return self.数据[玩家数据[id].角色.道具[n]],玩家数据[id].角色.道具[n]
        end
    end
    return 0
end


function 道具处理类:随机删除道具(连接id,id)
    local t={}
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil then
            t[#t+1]=n
        end
    end
    if #t>0 then
        local bh = t[取随机数(1,#t)]
        local 名称 = self.数据[玩家数据[id].角色.道具[bh]].名称
        self.数据[玩家数据[id].角色.道具[bh]]=nil
        玩家数据[id].角色.道具[bh]=nil
        发送数据(连接id,3699)
        return 名称
    end
end

function 道具处理类:判定背包道具(id,名称,数量)
    local 扣除数量 = 数量+0
    local 扣除数据={}
    local 已扣除=0
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 and 已扣除<扣除数量 then
            if self.数据[玩家数据[id].角色.道具[n]].数量 ~= nil then
                if self.数据[玩家数据[id].角色.道具[n]].数量>=扣除数量-已扣除 then
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=扣除数量-已扣除}
                    已扣除=已扣除+(扣除数量-已扣除)
                else
                    已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
                end
            else
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=1}
                已扣除 = 已扣除 +1
            end
        end
    end
    if 已扣除<扣除数量 then
        return false
    else
        return true
    end
end

function 道具处理类:判定任务道具(连接id,id,名称,数量)
    local 扣除数量 = 数量
    local 扣除数据={}
    local 已扣除=0
    for n=1,20 do
        if 玩家数据[id].角色.任务包裹[n]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]].名称==名称 and 已扣除<扣除数量 then
            if self.数据[玩家数据[id].角色.任务包裹[n]].数量 ~= nil then
                if self.数据[玩家数据[id].角色.任务包裹[n]].数量>=扣除数量-已扣除 then
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=扣除数量-已扣除}
                    已扣除=已扣除+(扣除数量-已扣除)
                else
                    已扣除=已扣除+self.数据[玩家数据[id].角色.任务包裹[n]].数量
                    扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=self.数据[玩家数据[id].角色.任务包裹[n]].数量}
                end
            else
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=1}
                    已扣除 = 已扣除 +1
            end
        end
    end
    if 已扣除<扣除数量 then
        return false
    else
        return true
    end
end

function 道具处理类:一键学阵法(连接id,id,内容)
    local 升级经验={
        [0]=0,
        [1]=100,
        [2]=2000,
        [3]=3000,
        [4]=4000,
        [5]=5000,
        [6]=9999999999,
    }
    local 升级成功=false
    for i=1,80 do
        local 道具id=玩家数据[id].角色.道具[i]
        if 道具id~=nil and self.数据[道具id]~=nil and self.数据[道具id].名称 == "鬼谷子" and  self.数据[道具id].子类 then --判断物品是否存在
            if 玩家数据[id].角色.阵法[self.数据[道具id].子类]==nil then
                玩家数据[id].角色.阵法[self.数据[道具id].子类]=0
                常规提示(id,"恭喜你学会了如何使用#R/"..self.数据[道具id].子类)
                升级成功=true
                self.数据[道具id]=nil
                --删除
            elseif 玩家数据[id].角色.阵法[self.数据[道具id].子类]<5 then
                if not 玩家数据[id].角色.阵法经验[self.数据[道具id].子类] then
                    玩家数据[id].角色.阵法经验[self.数据[道具id].子类]=0
                end
                玩家数据[id].角色.阵法经验[self.数据[道具id].子类]=玩家数据[id].角色.阵法经验[self.数据[道具id].子类]+100
                if 玩家数据[id].角色.阵法经验[self.数据[道具id].子类]>=升级经验[玩家数据[id].角色.阵法[self.数据[道具id].子类]] then
                    玩家数据[id].角色.阵法[self.数据[道具id].子类]=玩家数据[id].角色.阵法[self.数据[道具id].子类]+1
                    玩家数据[id].角色.阵法经验[self.数据[道具id].子类]=0
                    常规提示(id,"恭喜你的#G/"..self.数据[道具id].子类.."#Y阵法升级到"..玩家数据[id].角色.阵法[self.数据[道具id].子类])
                    升级成功=true
                else
                    常规提示(id,"你的#G/"..self.数据[道具id].子类.."#Y阵法经验提升了100点")
                    升级成功=true
                end
                self.数据[道具id]=nil
            end
        end
        if not 升级成功 then
            常规提示(id,"#Y少侠,你的背包无可用阵法!")
        end
    end
    道具刷新(id)
    local fssj={}
    fssj.阵法经验=玩家数据[id].角色.阵法经验
    fssj.学会阵法=玩家数据[id].角色.阵法
    fssj.加成=全局基础数据.阵法系统加成
    发送数据(连接id,6590,fssj)
end

function 道具处理类:扣除装备耐久(类型) --耐久弄成记次数，然后结束战斗再扣除
--  【装备掉耐久】
-- 　　1、武器：物理攻击每8下掉1点耐久(横扫千军算3下攻击)；施法每20下掉1点耐久(包括封印、治疗、其他辅助技能等)
-- 　　2、防具（除武器外的部位）：受到一定次数的物理攻击才会掉。具体为每被物理攻击10下掉1点耐久（被法术攻击不掉耐久）
-- 　　减少耐久消耗相关内容：
-- 　　大唐特色：装备耐久消耗速度减半
-- 　　地府经脉：百炼，武器耐久消耗降低50%
-- 　　五庄经脉：锤炼，武器耐久损失速度降低40%
-- 　　☆以上数据来源官网论坛版主测试结论哦。更详细的装备掉耐久、修理耐久、符石耐久等可查看原文详细介绍
    local 玩家id = self.玩家id
    if  类型 == "攻击" or 类型 == "施法" then
        local 道具id = 玩家数据[玩家id].角色.装备[3]
        if self.数据[道具id] ~= nil and self.数据[道具id].特效 ~= "永不磨损" then
            if self.数据[道具id].耐久 == nil then
                self.数据[道具id].耐久 = 0
            end
            if 类型 == "攻击" then
                if 玩家数据[玩家id].角色.门派=="狮驼岭" then
                    self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.07
                elseif 玩家数据[玩家id].角色.门派=="大唐官府" then
                    self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.05
                elseif 玩家数据[玩家id].角色.门派=="五庄观" and 玩家数据[玩家id].角色.奇经八脉.锤炼==1 then
                    self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.05
                else
                    self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.1
                end
            else
                self.数据[道具id].耐久 =  self.数据[道具id].耐久- 0.05
            end
            if  self.数据[道具id].耐久 < 0 then
                self.数据[道具id].耐久 = 0
            end
        end
    end
    if  类型 == "挨打" then
        for w, v in pairs(玩家数据[玩家id].角色.装备) do
            if w ~= 3 then
                local 道具id = 玩家数据[玩家id].角色.装备[w]
                if self.数据[道具id] ~= nil  then
                    if self.数据[道具id].耐久 == nil then
                        self.数据[道具id].耐久 = 0
                    end
                    if self.数据[道具id] ~= nil and self.数据[道具id].特效 ~= "永不磨损" then
                        self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.1
                    end
                    if  self.数据[道具id].耐久 < 0 then
                        self.数据[道具id].耐久 = 0
                    end
                end
            end
        end
        -- for w, v in pairs(玩家数据[玩家id].角色.灵饰) do
        --  local 道具id = 玩家数据[玩家id].角色.灵饰[w]
        --  if self.数据[道具id] ~= nil  then
        --      if self.数据[道具id].耐久 == nil then
        --          self.数据[道具id].耐久 = 0
        --      end
        --      if self.数据[道具id] ~= nil then
        --          self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.1
        --      end
        --      if  self.数据[道具id].耐久 < 0 then
        --          self.数据[道具id].耐久 = 0
        --      end
        --  end
        -- end
    end
end

function 道具处理类:染色处理(连接id,id,数据)
    -- 新增：校验数据格式（避免非法数据报错）
    if type(数据) ~= "table" or type(数据.染色组) ~= "table" then
        常规提示(id,"染色数据格式错误")
        return
    end

    -- 修正：循环染色数组计算彩果数量
    local 彩果数量=0
    local 染色数组 = 数据.染色组
    for n=1,#染色数组 do
        彩果数量=彩果数量 + (染色数组[n] or 0)  -- 容错：数值为空按0算
    end

    local 扣除数据={}
    local 已扣除=0
    -- 遍历道具格子（1-80）找彩果，逻辑不变
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil
            and self.数据[玩家数据[id].角色.道具[n]]~=nil
            and self.数据[玩家数据[id].角色.道具[n]].名称=="彩果"
            and 已扣除<彩果数量 then

            if self.数据[玩家数据[id].角色.道具[n]].数量>=彩果数量-已扣除 then
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=彩果数量-已扣除}
                已扣除=彩果数量  -- 直接拉满，无需累加
            else
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
                已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
            end
        end
    end

    if 已扣除<彩果数量 then
        常规提示(id,"你没有那么多的彩果")
        return
    else
        -- 扣除彩果，逻辑不变
        for n=1,#扣除数据 do
            self.数据[扣除数据[n].id].数量=self.数据[扣除数据[n].id].数量-扣除数据[n].数量
            if self.数据[扣除数据[n].id].数量<=0 then
                self.数据[扣除数据[n].id]=nil
                玩家数据[id].角色.道具[扣除数据[n].格子]=nil
            end
        end
        常规提示(id,"染色成功！")
        玩家数据[id].角色.染色组=数据.染色组
        发送数据(连接id,30,数据.染色组)
        发送数据(连接id,3699)
        地图处理类:更改染色(id,数据.染色组,玩家数据[id].角色.染色方案)
    end
end
function 道具处理类:卸下bb装备(连接id,id,数据)
    local 角色=数据.角色
    local 类型="道具"--数据.类型
    local 道具=数据.道具
    -- if 数据.类型 == "任务包裹" or 数据.类型 == "法宝" or 数据.类型 == "行囊" then return 常规提示(id,"#Y这件物品不能移动到任务栏") end
    --local 道具id=玩家数据[id].角色[类型][道具]
    local bb=数据.编号
    local 道具格子=玩家数据[id].角色:取道具格子1(类型)
    if 道具格子==0 then
        常规提示(id,"您的道具栏物品已经满啦")
        return
    else
        local 临时id=self:取新编号()
        self.数据[临时id]=玩家数据[id].召唤兽.数据[bb].装备[道具]
        玩家数据[id].召唤兽.数据[bb]:卸下装备(玩家数据[id].召唤兽.数据[bb].装备[道具],道具)
        玩家数据[id].角色.道具[道具格子]=临时id
        玩家数据[id].召唤兽.数据[bb].装备[道具]=nil
        self:刷新道具行囊(id,类型)
        发送数据(连接id,20,玩家数据[id].召唤兽.数据[bb]:取存档数据())
        发送数据(连接id,28)
    end
end

function 道具处理类:佩戴bb装备(连接id,id,数据)
    local 角色=数据.角色
    local 类型=数据.类型
    local 道具=数据.道具
    local 道具id=玩家数据[id].角色[类型][道具]
    local bb=数据.编号
    if self.数据[道具id].分类>6 and self:召唤兽可装备(self.数据[道具id],self.数据[道具id].分类-6,玩家数据[id].召唤兽.数据[bb].等级,id) then
        local 装备格子=self.数据[道具id].分类 - 6
        if 玩家数据[id].召唤兽.数据[bb].装备[装备格子] ~= nil then
            local 临时道具=玩家数据[id].召唤兽.数据[bb].装备[装备格子]
            玩家数据[id].召唤兽.数据[bb]:卸下装备(玩家数据[id].召唤兽.数据[bb].装备[装备格子],装备格子)
            玩家数据[id].召唤兽.数据[bb].装备[装备格子] =nil
            玩家数据[id].召唤兽.数据[bb]:穿戴装备(self.数据[道具id],装备格子)
            self.数据[道具id]=临时道具
        else
            玩家数据[id].召唤兽.数据[bb]:穿戴装备(self.数据[道具id],装备格子)
            self.数据[道具id]=nil
            玩家数据[id].角色[类型][道具]=nil
        end
        self:刷新道具行囊(id,数据.类型)
        发送数据(连接id,20,玩家数据[id].召唤兽.数据[bb]:取存档数据())
        发送数据(连接id,28)
    end
end

function 道具处理类:召唤兽可装备(i1,i2,等级,id)
    if i1 ~= nil and i1.分类 - 6 == i2 then
        if (i1.等级 == 0 or i1.特效 == "无级别限制" or 等级 >= i1.等级) then
            return true
        else
            if i1.等级 > 等级 then
                常规提示(id,"#Y/你的召唤兽等级不足哦")
            end
        end
    end
    return false
end

function 道具处理类:取随机装备(id,等级,返回)
    local 临时等级=等级
    local 临时参数=取随机数(1,#书铁范围)
    if 取随机数()<=40 then
        临时参数=取随机数(19,#书铁范围)
    end
    local 临时序列=临时参数
    if 临时序列==25 then
        临时序列=23
    elseif 临时序列==24 then
        临时序列=22
    elseif 临时序列==23 or 临时序列==22 then
        临时序列=21
    elseif 临时序列==21 then
        临时序列=20
    elseif 临时序列==20 or 临时序列==19 then
        临时序列=19
    end
    -- local 临时等级=玩家数据[id].道具.数据[制造格子].子类/10
    -- 计算武器值
    if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
        临时等级=取随机数(10,12)
    else
        if 临时等级>=12 then
            临时等级=10
        end
    end
    local 临时类型=装备处理类.打造物品[临时序列][临时等级+1]
    if type(临时类型)=="table" then
        if 临时参数 ==23 then
         临时类型=临时类型[2]
        elseif 临时参数 ==22 then
         临时类型=临时类型[1]
        elseif 临时参数 ==20 then
         临时类型=临时类型[2]
        elseif 临时参数 ==19 then
         临时类型=临时类型[1]
        else
            临时类型=临时类型[取随机数(1,2)]
        end
    end
    装备处理类:生成打造装备(id,临时等级*10,临时序列,临时类型,"系统产出") --所有系统产出的都给他未鉴定，让他自己鉴定去
    if 返回 then
        return 临时类型
    end
end

function 道具处理类:取随机装备1(id,等级,名称)
    -- 装备处理类:生成装备(id,等级*10,取装备序列(名称),名称,nil,true,"系统产出")
    装备处理类:生成打造装备(id,等级*10,取装备序列(名称),名称,"系统产出")
end

function 道具处理类:给予超链接书铁(id,等级,类型,链接)
    if 类型==nil then  --随机获取
        self.临时随机=取随机数()
        if self.临时随机<=50 then
            self.书铁名称="制造指南书"
        else
            self.书铁名称="百炼精铁"
        end
        local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
        local 书铁种类=取随机数(1,#书铁范围)
        if 取随机数()<=40 then
            书铁种类=取随机数(19,#书铁范围)
        end
        书铁等级=math.floor(书铁等级/10)*10
        self:给予超链接道具(id,self.书铁名称,书铁等级,书铁种类,链接)
        return {self.书铁名称,书铁等级,书铁种类}
    else
        if 类型=="书" then
            self.临时随机=取随机数()
            self.书铁名称="制造指南书"
            local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
            local 书铁种类=取随机数(1,#书铁范围)
            if 取随机数()<=40 then
                书铁种类=取随机数(19,#书铁范围)
            end
            书铁等级=math.floor(书铁等级/10)*10
            self:给予超链接道具(id,self.书铁名称,书铁等级,书铁种类,链接)
            return {self.书铁名称,书铁等级,书铁种类}
        else
            self.临时随机=取随机数()
            self.书铁名称="百炼精铁"
            local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
            书铁等级=math.floor(书铁等级/10)*10
            self:给予超链接道具(id,self.书铁名称,书铁等级,书铁种类,链接)
            -- self:给予超链接道具(id,self.书铁名称,书铁等级,链接,"成功")
            return {self.书铁名称,书铁等级}
        end
    end
end

function 道具处理类:给予书铁(id,等级,类型)
    if 类型==nil then  --随机获取
        self.临时随机=取随机数()
        if self.临时随机<=50 then
            self.书铁名称="制造指南书"
        else
            self.书铁名称="百炼精铁"
        end
        local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
        local 书铁种类=取随机数(1,#书铁范围)
        if 取随机数()<=40 then
            书铁种类=取随机数(19,#书铁范围)
        end
        书铁等级=math.floor(书铁等级/10)*10
        self:给予道具(id,self.书铁名称,书铁等级,书铁种类)
        return {self.书铁名称,书铁等级,书铁种类}
    else
        if 类型=="书" then
            self.临时随机=取随机数()
            self.书铁名称="制造指南书"
            local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
            local 书铁种类=取随机数(1,#书铁范围)
            if 取随机数()<=40 then
                书铁种类=取随机数(19,#书铁范围)
            end
            书铁等级=math.floor(书铁等级/10)*10
            self:给予道具(id,self.书铁名称,书铁等级,书铁种类)
            return {self.书铁名称,书铁等级,书铁种类}
        else
            self.临时随机=取随机数()
            self.书铁名称="百炼精铁"
            local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
            书铁等级=math.floor(书铁等级/10)*10
            self:给予道具(id,self.书铁名称,书铁等级)
            return {self.书铁名称,书铁等级}
        end
    end
end


function 道具处理类:一键合玄灵珠(id,dj1,lv,名称1)
    if lv>0 and dj1 then
        for n=1,100 do
            local dj2 = 玩家数据[id].角色.道具[n]
            if dj2 and self.数据[dj2] and dj1~=dj2 and 名称1==self.数据[dj2].名称 then
                local 名称2=self.数据[dj2].名称
                if 右键合成玄灵珠[名称2] and self.数据[dj2].等级==lv then
                        玩家数据[id].角色.道具[n] = nil
                        self.数据[dj2] = nil
                        self.数据[dj1].等级 = self.数据[dj1].等级 +1
                        道具刷新(id)
                        常规提示(id,"#Y/你合成了一个更高级的玄灵珠")
                        return
                end
            end
        end
    end
    常规提示(id,"#Y/没有找到可以合成的宝石")
end


function 道具处理类:飞行符传送(连接id,id,内容)
    local 传送序列=内容.序列
    if 玩家数据[id].道具操作 == nil then print("玩家："..id.."操作导致道具操作异常") return end
    if self:取飞行限制(id)==false then
        local 包裹类型 = 玩家数据[id].道具操作.类型
        local 道具格子 = 玩家数据[id].道具操作.编号
        local 道具id=玩家数据[id].角色[包裹类型][道具格子]
        地图处理类:跳转地图(id,self.飞行传送点[传送序列][1],self.飞行传送点[传送序列][2],self.飞行传送点[传送序列][3])
        self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
        发送数据(连接id,3699)
    end
end

function 道具处理类:超级合成旗传送(连接id,id,内容)
    if 玩家数据[id].最后操作=="超级合成旗" then
        if self:取飞行限制(id)==false then
            local 地图id=内容.地图
            local 坐标=内容.zb
            local 包裹类型=玩家数据[id].道具操作.类型
            local 道具格子=玩家数据[id].道具操作.编号
            local 道具id=玩家数据[id].角色[包裹类型][道具格子]
            if self.数据[道具id] and self.数据[道具id].名称=="超级合成旗" then
                if self.数据[道具id].限时时间 and os.time() - self.数据[道具id].限时时间 >= 0 then
                    self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
                    return
                end
                if self.数据[道具id].次数 then
                    self.数据[道具id].次数 =self.数据[道具id].次数-1
                    if self.数据[道具id].次数<=0 then
                        self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
                    end
                end
                地图处理类:跳转地图(id+0,地图id,坐标.x,坐标.y)
                道具刷新(id)
            end
        end
        玩家数据[id].最后操作=nil
    end
end


function 道具处理类:新春飞行符传送(连接id,id,内容)
    if 玩家数据[id].最后操作=="新春飞行符" then
        if self:取飞行限制(id)==false then
            local 地图id=内容.地图
            local 坐标=内容.zb
            local 包裹类型=玩家数据[id].道具操作.类型
            local 道具格子=玩家数据[id].道具操作.编号
            local 道具id=玩家数据[id].角色[包裹类型][道具格子]
            if self.数据[道具id].名称=="新春飞行符" then
                        if self.数据[道具id].次数 then
                    self.数据[道具id].次数 =self.数据[道具id].次数-1
                    if self.数据[道具id].次数<=0 then
                         self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
                    end
                end
                地图处理类:跳转地图(id+0,地图id,坐标.x,坐标.y)
                道具刷新(id)

            end
        end
         玩家数据[id].最后操作=nil
    end
end


function 道具处理类:取加血道具(名称)
    local 临时名称={"包子","草果","山药","九香虫","八角莲叶","人参","烤鸭","翡翠豆腐","烤肉","臭豆腐","金创药","小还丹","千年保心丹","金香玉","天不老","紫石英","血色茶花","熊胆","鹿茸","六道轮回","凤凰尾","硫磺草","龙之心屑","火凤之睛","四叶花","天青地白","七叶莲"}
    for n=1,#临时名称 do
        if 临时名称[n]==名称 then
            return true
        end
    end
    return false
end

function 道具处理类:取寿命道具(名称)
    local 临时名称={"桂花丸","长寿面","豆斋果"}
    for n=1,#临时名称 do
        if 临时名称[n]==名称 then
            return true
        end
    end
    return false
end

function 道具处理类:取寿命道具1(名称,道具id)
    local 品质=self.数据[道具id].阶品
    local 数值=0
    local 中毒=0
    if 名称=="桂花丸" then
        数值=品质*0.5
    elseif 名称=="豆斋果" then
        数值=品质*3
        中毒=3
    elseif 名称=="长寿面" then
        数值=品质*2+50
        中毒=3
    end
    return {数值=qz(数值),中毒=中毒}
end

function 道具处理类:取加魔道具(名称)
    local 临时名称={"翡翠豆腐","佛跳墙","蛇蝎美人","风水混元丹","定神香","十香返生丸","丁香水","月星子","仙狐涎","地狱灵芝","麝香","血珊瑚","餐风饮露","白露为霜","天龙水","孔雀红","紫丹罗","佛手","旋复花","龙须草","百色花","香叶","白玉骨头","鬼切草","灵脂","曼陀罗花"}
    for n=1,#临时名称 do
        if 临时名称[n]==名称 then
            return true
        end
    end
    return false
end

function 道具处理类:取加血道具1(名称,道具id)
    local 品质=self.数据[道具id].阶品
    if 品质 == nil then
        品质 = 1
    end
    local 数值=0
    if 名称=="包子" then
     数值=100
    elseif 名称=="烤鸭" then
     数值=品质*10+100
    elseif 名称=="烤肉" then
     数值=品质*10
    elseif 名称=="臭豆腐" then
     数值=品质*20+200
    elseif 名称=="翡翠豆腐" then
     数值=品质*15+150
    elseif 名称=="草果" then
     数值=0
    elseif 名称=="山药" then
     数值=40
    elseif 名称=="九香虫" then
     数值=0
    elseif 名称=="八角莲叶" then
     数值=60
    elseif 名称=="人参" then
     数值=80
    elseif 名称=="金创药" then
     数值=400
    elseif 名称=="小还丹" then --恢复气血=品质×8+100,疗伤=品质+80
     数值=品质*8+100
    elseif 名称=="金香玉" or 名称=="固本培元丹" then --恢复气血=品质×12+150
     数值=品质*12+150
    elseif 名称=="千年保心丹" or 名称=="十全大补丸" then --恢复血气=品质×4+200,疗伤=品质×4+100
     数值=品质*4+200
    elseif 名称=="五龙丹" or 名称=="舒筋活络丸" then --解除封类异常状态,恢复气血=品质×3。  解封成功率=(五龙品质+100-人物等级+60)%，最低几率为40%
     数值=品质*3
    elseif 名称=="佛光舍利子" then --复活并回复气血=品质×3,临时气血上限=品质×7+100
     数值=品质*3
    elseif 名称=="九转回魂丹" or 名称=="九转续命丹" then --复活人物并恢复气血=品质×5+100
     数值=品质*5+100
    elseif 名称=="天不老" or 名称=="紫石英" then
     数值=100
    elseif 名称=="血色茶花" or 名称=="鹿茸" then
     数值= 150
    elseif 名称=="六道轮回" or 名称=="熊胆" then
     数值= 200
    elseif 名称=="凤凰尾" or 名称=="硫磺草" then
     数值= 250
    elseif 名称=="龙之心屑" or 名称=="火凤之睛" then
     数值= 300
    elseif 名称=="四叶花" then
     数值= 40
    elseif 名称=="天青地白" then
     数值= 80
    elseif 名称=="七叶莲" then
     数值= 60
    end
    return qz(数值)
end

function 道具处理类:取加血道具2(名称,道具id)
    local 品质=self.数据[道具id].阶品
    local 数值=0
    if 名称=="包子" then
     数值=0
    elseif 名称=="烤鸭" then
     数值=品质*5
    elseif 名称=="烤肉" then
     数值=品质*10+10
    elseif 名称=="臭豆腐" then
     数值=0
    elseif 名称=="翡翠豆腐" then
     数值=0
    elseif 名称=="草果" then
     数值=10
    elseif 名称=="山药" then
     数值=10
    elseif 名称=="九香虫" then
     数值=15
    elseif 名称=="八角莲叶" then
     数值=15
    elseif 名称=="人参" then
     数值=20
    elseif 名称=="金创药" then
     数值=400
    elseif 名称=="小还丹" then
     数值=品质+80
    elseif 名称=="金香玉" then
     数值=0
    elseif 名称=="千年保心丹" then
     数值=品质*4+100
    elseif 名称=="五龙丹" then
     数值=0
    elseif 名称=="佛光舍利子" then
     数值=0
    elseif 名称=="九转回魂丹" then
     数值=0
    elseif 名称=="天不老" or 名称=="紫石英" then
     数值=0
    elseif 名称=="血色茶花" or 名称=="鹿茸" then
     数值= 0
    elseif 名称=="六道轮回" or 名称=="熊胆" then
     数值= 0
    elseif 名称=="凤凰尾" or 名称=="硫磺草" then
     数值= 0
    elseif 名称=="龙之心屑" or 名称=="火凤之睛" then
     数值= 0
    elseif 名称=="四叶花" then
     数值= 0
    elseif 名称=="天青地白" then
     数值= 0
    elseif 名称=="七叶莲" then
     数值= 0
    end
    return qz(数值)
end

function 道具处理类:取加魔道具1(名称,道具id)
    local 品质=self.数据[道具id].阶品 or 1
    local 数值=0
    if 名称=="佛跳墙" or 名称=="翡翠豆腐" then
     数值=品质*10+100
    elseif 名称=="定神香"  then
     数值=品质*5+50
    elseif 名称=="风水混元丹"  then
     数值=品质*3+50
    elseif 名称=="蛇蝎美人"or 名称=="凝气丸"then
     数值=品质*5+100
    elseif 名称=="十香返生丸" or 名称=="七珍丸"  then
     数值=品质*3+50
    elseif 名称=="女儿红" or 名称=="虎骨酒"  then
     数值=20
    elseif 名称=="珍露酒"  then
     数值=品质*0.4+10
    elseif 名称=="梅花酒"  then
     数值=品质*0.6
    elseif 名称=="百味酒"  then
     数值=品质*0.7
    elseif 名称=="蛇胆酒" or 名称=="醉生梦死"  or 名称=="醉仙果" then
     数值=品质*1
    elseif 名称=="丁香水" or 名称=="月星子"  then
     数值=75
    elseif 名称=="仙狐涎" or 名称=="地狱灵芝" or 名称=="麝香" or 名称=="血珊瑚" or 名称=="餐风饮露" or 名称=="白露为霜"  then
     数值=100
    elseif 名称=="天龙水" or 名称=="孔雀红"  then
     数值=150
    elseif 名称=="紫丹罗" or 名称=="佛手" or 名称=="旋复花" then
     数值=20
    elseif 名称=="龙须草" or 名称=="百色花" or 名称=="香叶"  then
     数值=30
    elseif 名称=="白玉骨头" or 名称=="鬼切草" or 名称=="灵脂"  then
     数值=40
    elseif 名称=="曼陀罗花"  then
     数值=50
    end
    return qz(数值)
end

function 道具处理类:清空包裹(连接id,id)
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil  then
            self.数据[玩家数据[id].角色.道具[n]]=nil
            玩家数据[id].角色.道具[n]=nil
        end
    end
    发送数据(连接id,3699)
    常规提示(id,"清理成功")
end

function 道具处理类:取是否有相同内丹(id,加血对象,技能)
    local wz = 0
    for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹[1] do
            if 玩家数据[id].召唤兽.数据[加血对象].内丹.技能[i]~= nil and 玩家数据[id].召唤兽.数据[加血对象].内丹.技能[i].技能 == 技能 then
                wz = i
            end
    end
    return wz
end
function 道具处理类:取是内丹空格子(id,加血对象)
    local wz = 0
    for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹[1] do
        if 玩家数据[id].召唤兽.数据[加血对象].内丹.技能[i] == nil then
            wz = i
            return wz
        end
    end
end

function 道具处理类:一键打符(id)
    if 玩家数据[id]==nil then return end
----------------------------------------装备临时符这里改。不同部位必须填对应技能，参考下面
    -- 1头盔: "尸气漫天" 或 "神兵护法"
    -- 2项链："嗜血" 、 "莲华妙法" 、 "担山赶月"
    -- 3武器："轻如鸿毛" 、 "盘丝舞" 、 "魔王护持" 、 "龙附" 、 "元阳护体"
    -- 4衣服："浩然正气" 、 "一气化三清"
    -- 5腰带："神力无穷" 、 "穿云破空"
    -- 6鞋子："拈花妙指" 、 "神木呓语"
        local jn = {
        大唐官府= {[1]={"神兵护法"},
                            [2]={"担山赶月"},
                            [3]={"轻如鸿毛","盘丝舞","龙附","魔王护持"},
                            [4]={"浩然正气"},
                            [5]={"神力无穷","穿云破空"},
                            [6]={"拈花妙指","神木呓语"}},
    化生寺= {[1]={"尸气漫天"},
                    [2]={"嗜血"},
                    [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                    [4]={"浩然正气"},
                    [5]={"神力无穷"},
                    [6]={"拈花妙指"}},

        方寸山= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"拈花妙指","神木呓语"}},

    女儿村= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"拈花妙指","神木呓语"}},

    神木林= {[1]={"尸气漫天"},
                 [2]={"莲华妙法"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"一气化三清"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

        盘丝洞= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"拈花妙指","神木呓语"}},

        魔王寨= {[1]={"尸气漫天"},
                 [2]={"莲华妙法"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"一气化三清"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

      狮驼岭= {[1]={"神兵护法"},
                 [2]={"担山赶月"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"一气化三清"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"拈花妙指","神木呓语"}},

     阴曹地府= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

        无底洞= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

        天宫= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷"},
                 [6]={"神木呓语","拈花妙指"}},

        普陀山= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

        凌波城= {[1]={"神兵护法"},
                 [2]={"担山赶月"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

        五庄观= {[1]={"尸气漫天"},
                 [2]={"嗜血"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

        龙宫= {[1]={"尸气漫天"},
                 [2]={"莲华妙法"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"一气化三清"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},

        九黎城= {[1]={"神兵护法"},
                 [2]={"担山赶月"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},


        花果山= {[1]={"神兵护法"},
                 [2]={"担山赶月"},
                 [3]={"轻如鸿毛","盘丝舞","龙附" ,"魔王护持"},
                 [4]={"浩然正气"},
                 [5]={"神力无穷","穿云破空"},
                 [6]={"神木呓语","拈花妙指"}},
    }
    ----------------------------------------
    local 消耗=50000000
    if 空白授权 then
        消耗=5000000
    end
    if 取银子(id)<消耗 then
            常规提示(id,"银子不足"..消耗)
            return
    end

    local 附魔成功 = {}
    local 门派 = 玩家数据[id].角色.门派
    local 附魔时间=86400*7
    if jn[门派]==nil then return end --无门派禁打符
           for n=1,6 do
            附魔成功[n] = false
            if 玩家数据[id].角色.装备[n] ~= nil then
                local 装备 = 玩家数据[id].角色.装备[n]
                for bbb = 1,#jn[门派][n] do
                    local xxx = jn[门派][n][bbb]
                    local 强化效果 = 取强化符效果满(xxx,186,self.数据[装备].分类)
                    if 强化效果.类型 ~= nil and 强化效果.类型 ~= "无" then
                        if self.数据[装备].分类==1 or self.数据[装备].分类==2 or self.数据[装备].分类==4 then --项链，铠甲，头盔 不能同时存在多个
                            -- 先移除旧的附魔效果
                            if self.数据[装备].临时附魔 ~= nil then
                                for k,v in pairs(self.数据[装备].临时附魔) do
                                    if 玩家数据[id].角色.装备属性[k] ~= nil and v.数值 ~=nil then
                                        玩家数据[id].角色.装备属性[k] = 玩家数据[id].角色.装备属性[k] - v.数值
                                    end
                                end
                            end
                            self.数据[装备].临时附魔 = {}
                            self.数据[装备].临时附魔[强化效果.类型] = {}
                            self.数据[装备].临时附魔[强化效果.类型].数值 = 强化效果.数值
                            self.数据[装备].临时附魔[强化效果.类型].时间 = os.time()+附魔时间 --2小时
                            if 玩家数据[id].角色.装备属性[强化效果.类型] ~= nil then
                                玩家数据[id].角色.装备属性[强化效果.类型] = 玩家数据[id].角色.装备属性[强化效果.类型] + 强化效果.数值
                            end
                            附魔成功[n] = true
                            break -- 头盔、项链、衣服只打一个符
                        else
                            if self.数据[装备].临时附魔 == nil then
                                self.数据[装备].临时附魔 = {}
                            end
                            -- 如果已经有同类型的附魔，先移除
                            if self.数据[装备].临时附魔[强化效果.类型] ~= nil then
                                local 旧数值 = self.数据[装备].临时附魔[强化效果.类型].数值
                                if 玩家数据[id].角色.装备属性[强化效果.类型] ~= nil and 旧数值 ~= nil then
                                    玩家数据[id].角色.装备属性[强化效果.类型] = 玩家数据[id].角色.装备属性[强化效果.类型] - 旧数值
                                end
                            end

                            -- 设置新的附魔
                            self.数据[装备].临时附魔[强化效果.类型] = {}
                            self.数据[装备].临时附魔[强化效果.类型].数值 = 强化效果.数值
                            self.数据[装备].临时附魔[强化效果.类型].时间 = os.time()+附魔时间 --2小时

                            -- 添加新附魔的效果到角色属性
                            if 玩家数据[id].角色.装备属性[强化效果.类型] ~= nil then
                                玩家数据[id].角色.装备属性[强化效果.类型] = 玩家数据[id].角色.装备属性[强化效果.类型] + 强化效果.数值
                            end

                            附魔成功[n] = true
                            -- 注意：这里不要break，让循环继续尝试其他技能
                        end
                    end
                end
            end
        end

        local xxx = 0
        for an=1,6 do
            if 附魔成功[an] then
                xxx = xxx + 1
            end
        end
        if xxx~=0 then
            玩家数据[id].角色:刷新信息("33")
            发送数据(玩家数据[id].连接id,12)
            玩家数据[id].角色:扣除银子(消耗,0,0,"一键打符",1)
            常规提示(id,"#Y/装备附魔成功" ..xxx .."件")
        else
            常规提示(id,"#Y/附魔失败，请检查装备是否穿戴")
        end
end

function 道具处理类:符纸使用(连接id,id,内容)
    local 包裹类型=内容.类型
    local 道具格子=内容.道具格子
    local 符纸格子 =内容.符纸格子
    local 删除数量=1
    local 道具id=玩家数据[id].角色["道具"][符纸格子]
    local 装备=玩家数据[id].角色["道具"][道具格子]
    if self.数据[道具id] == nil or self.数据[装备] == nil then


        常规提示(id,"#Y/数据异常！")
        return
    end

    if 包裹类型=="强化符" then
        local 强化效果  = {}
        强化效果 = 取强化符效果(self.数据[道具id].技能,self.数据[道具id].等级,self.数据[装备].分类)
        if 强化效果.类型 == "无" then return 常规提示(id,"#Y/附魔部位不正确") end
        if self.数据[装备].分类==1 or self.数据[装备].分类==2 or self.数据[装备].分类==4 then --项链，铠甲，头盔 不能同时存在多个
            self.数据[装备].临时附魔 = {}
        else
            if self.数据[装备].临时附魔 == nil then
                self.数据[装备].临时附魔 = {}
            end
        end
        self.数据[装备].临时附魔[强化效果.类型] = {}
        self.数据[装备].临时附魔[强化效果.类型].数值 = 强化效果.数值
        self.数据[装备].临时附魔[强化效果.类型].时间 = os.time()+6048000--86400

        常规提示(id,"#Y/装备附魔成功！")
        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        发送数据(连接id,3699)
        return
    elseif 包裹类型=="装备鉴定" then
        if not self.数据[装备].鉴定 then
            if self.数据[道具id].等级 >= self.数据[装备].等级 then
                self.数据[装备].鉴定 = true
                self.数据[装备].专用提示=nil --直接删除该项
                常规提示(id,"#Y/物品鉴定成功！")
                常规提示(id,"#Y/可以通过梦幻精灵网页版查询装备的属性范围，你有兴趣的话可以去瞧瞧。")
                    道具刷新(id)
                self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
                装备处理类:装备鉴定处理(连接id,id,self.数据[装备])

                发送数据(连接id,3699)
            else
                常规提示(id,"#Y/此图鉴的等级过低无法鉴定该装备")
                return
            end
        else
            常规提示(id,"#Y/这件装备已经鉴定过了请不要重复鉴定")
            return
        end

    elseif 包裹类型=="凤纹灵坠" then
        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if not self.数据[装备].灵饰 then
            常规提示(id,"该物品只能对灵饰使用")
            return
        end
        local 临时属性=灵饰属性[self.数据[装备].部位类型].副属性[取随机数(1,#灵饰属性[self.数据[装备].部位类型].副属性)]
        local 临时数值
        if 取随机数(1,100) < 20 then
             临时数值=取随机数(1,6)
        elseif  取随机数(1,100) < 40 then
             临时数值=取随机数(1,10)
        elseif  取随机数(1,100) < 60 then
             临时数值=取随机数(1,15)
        elseif  取随机数(1,100) < 90 then
             临时数值=取随机数(1,20)
        else
             临时数值=取随机数(1,25)
        end
        self.数据[装备].新特性={属性=临时属性,数值=临时数值}

        常规提示(id,"#Y/本次点化效果为：#R/"..临时属性.."#Y/额外增加#R/"..临时数值.."%")

        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)

        发送数据(连接id,3699)

    elseif 包裹类型 == "装备词条" then
        local name = nil
        if self.数据[装备].词条 == nil then
            self.数据[装备].词条 = {}
        end
        if #self.数据[装备].词条 < 1 and (self.数据[道具id].名称 == "词条属性石" or self.数据[道具id].名称 == "词条洗练石") then
            常规提示(id,"#Y/这件装备并没有词条，无法更改词条")
            return
        end
        if #self.数据[装备].词条 >= 3 and self.数据[道具id].名称 == "装备词条石" then
            常规提示(id,"#Y/这件装备词条已达上限")
            return
        end
        local 词条, 属性, 数值 = 获取词条(name,self.数据[装备].分类)
        if self.数据[道具id].名称 == "装备词条石" then
            self.数据[装备].词条[#self.数据[装备].词条+1] = {类型=词条,属性=属性,数值=数值}
            self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
            -- 常规提示(id,"#Y/该装备生成了新的词条#R"..词条)
            常规提示(id,"#Y/该装备生成了新的词条#G"..词条.."("..属性.."+"..数值..")")
            发送数据(连接id,3699)
            return
        elseif self.数据[道具id].名称 == "词条洗练石" or self.数据[道具id].名称 == "词条属性石" then
            local 类型 = 1
            if self.数据[道具id].名称 == "词条属性石" then 类型 = 2 end
            local name = nil
            local 词条 = table.copy(self.数据[装备].词条)
            self.数据[装备].词条 = {}
            local 提示信息 = "#G词条洗练成功，新词条为："
            for i = 1, #词条 do
                if 类型 == 2 then name = 词条[i].类型 end
                local 名称,属性,数值 = 获取词条(name, self.数据[装备].分类)
                if self.数据[装备].词条[i] == nil then
                    self.数据[装备].词条[i] = {}
                end
                self.数据[装备].词条[i].类型 = 名称
                self.数据[装备].词条[i].属性 = 属性
                self.数据[装备].词条[i].数值 = 数值
                提示信息 = 提示信息 .. "#G"..名称.."("..属性.."+"..数值..")"
                if i < #词条 then
                    提示信息 = 提示信息 .. "、"
                end
            end
            self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
            常规提示(id,提示信息)
            发送数据(玩家数据[id].连接id,3699)
            发送数据(连接id,3699)
            return
        end
    elseif 包裹类型 == "属性洗练" then
        local 属性 = {"力量","敏捷","体质","耐力","魔力"}
        local 存在 = {}
        local 属性值 = {}
        for i = 1, #属性 do
            if self.数据[装备][属性[i]] then
                存在[#存在+1] = 属性[i]
                属性值[#属性值+1] = self.数据[装备][属性[i]]
            end
        end
        if self.数据[装备].分类 < 3 or self.数据[装备].分类 > 4 then
            常规提示(id,"#Y/只有武器和衣服才可以进行属性洗练")
            return
        elseif self.数据[道具id].名称 == "装备属性石" and #存在 >= 2 then
            常规提示(id,"#Y/这件装备已经是双属性了，无法使用该道具")
            return
        elseif self.数据[道具id].名称 == "属性洗练石" and self.数据[道具id].熔炼效果 ~= nil then
            常规提示(id,"#Y/这件装备已经熔炼，无法使用属性洗练石")
            return
        elseif #存在 < 1 and (self.数据[道具id].名称 == "数值洗练石" or self.数据[道具id].名称 == "属性洗练石") then
            常规提示(id,"#Y/该装备并没有单双加，无法进行操作")
            return
        end
        local 成功几率 = 70
        if 正式 then 成功几率 = 100 end
        local 单加,双加 = 取单双加属性(self.数据[装备].等级)
        if 成功几率 >= 取随机数() then
            if self.数据[道具id].名称 == "装备属性石" then
                if #存在 >= 1 then self.数据[装备][存在[1]] = nil end
                if 取随机数()<= 80 then
                    local fhz = 取随机数(1,#属性)
                    local sx1 = 属性[fhz]
                    table.remove(属性,fhz)
                    fhz = 取随机数(1,#属性)
                    local sx2 = 属性[fhz]
                    self.数据[装备][sx1] = math.ceil(取随机数(-8,双加)/2)
                    self.数据[装备][sx2] = math.ceil(取随机数(-8,双加)/2)
                else
                    local fhz = 取随机数(1,#属性)
                    local sx1 = 属性[fhz]
                    self.数据[装备][sx1] = 取随机数(1,单加)
                end
            elseif self.数据[道具id].名称 == "数值洗练石" then
                if #存在 == 1 then
                    self.数据[装备][存在[1]] = 取随机数(1,单加)
                else
                  self.数据[装备][存在[1]] = math.ceil(取随机数(-8,双加)/2)
                    self.数据[装备][存在[2]] = math.ceil(取随机数(-8,双加)/2)
                end
            elseif self.数据[道具id].名称 == "属性洗练石" then
                if #存在 == 1 then
                    self.数据[装备][存在[1]] = nil
                    local fhz = 取随机数(1,#属性)
                    local sx1 = 属性[fhz]
                    self.数据[装备][sx1] = 属性值[1]
                else
                    self.数据[装备][存在[1]] = nil
                    self.数据[装备][存在[2]] = nil
                   local fhz = 取随机数(1,#属性)
                    local sx1 = 属性[fhz]
                    table.remove(属性,fhz)
                    fhz = 取随机数(1,#属性)
                    local sx2 = 属性[fhz]
                    self.数据[装备][sx1] = 属性值[1]
                    self.数据[装备][sx2] = 属性值[2]
                end
            end
        else
            self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
            常规提示(id,"#Y/很遗憾，此次操作并未成功！你好像失去了点什么东西！")
            发送数据(连接id,3699)
            return
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
        常规提示(id,"#Y/操作成功，该装备似乎发生了某种变化！")
        发送数据(连接id,3699)
        return
    elseif 包裹类型 == "灵饰洗练" then
        local 成功几率 = 70
        -- if 正式 then 成功几率 = 100 end
        if self.数据[装备].分类 < 10 or self.数据[装备].分类 > 13 then
            常规提示(id,"#Y/只有灵饰才可以进行灵饰洗练")
            return
        elseif self.数据[装备].幻化属性 == nil or self.数据[装备].幻化属性.附加 == nil or #self.数据[装备].幻化属性.附加 < 1 then
            常规提示(id,"#Y/该灵饰没有附加属性，无法进行洗练")
            return
        elseif self.数据[装备].等级 >= 160 then
            常规提示(id, "#Y/160级灵饰无法使用此类道具")
            return
        end
        if 成功几率 >= 取随机数() then
            if self.数据[道具id].名称 == "灵饰洗练石" then
                for i = 1, #self.数据[装备].幻化属性.附加 do
                    if self.数据[装备].幻化属性.附加[i].强化 and self.数据[装备].幻化属性.附加[i].强化 > 0 then
                        常规提示(id,"#Y/该灵饰已强化，无法进行洗练")
                        return
                    end
                    local 临时属性 = self.数据[装备].幻化属性.附加[i].类型
                    local 等级 = self.数据[装备].等级
                    local 数值 = 取随机数(灵饰副属性[临时属性][等级].a, 灵饰副属性[临时属性][等级].b)
                    self.数据[装备].幻化属性.附加[i].数值 = 数值
                end
            elseif self.数据[道具id].名称 == "灵饰属性石" then
                for i = 1, #self.数据[装备].幻化属性.附加 do
                    if self.数据[装备].幻化属性.附加[i].强化 and self.数据[装备].幻化属性.附加[i].强化 > 0 then
                        常规提示(id,"#Y/该灵饰已强化，无法进行洗练")
                        return
                    end
                end
                local 类型个数 = 取随机数(1,2)
                if 取随机数() >= 50 then
                    类型个数 = 3
                end
                if #self.数据[装备].幻化属性.附加 == 3 then 类型个数 = 3 end
                self.数据[装备].幻化属性.附加 = {}
                for i = 1, 类型个数 do
                    local 临时属性 = 灵饰属性[self.数据[装备].部位类型].副属性[取随机数(1,#灵饰属性[self.数据[装备].部位类型].副属性)]
                    local 等级 = self.数据[装备].等级
                    local 数值 = 取随机数(灵饰副属性[临时属性][等级].a, 灵饰副属性[临时属性][等级].b)
                    self.数据[装备].幻化属性.附加[i] = {类型 = 临时属性, 数值 = 数值, 强化 = 0}
                end
            end
        else
            self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
            常规提示(id,"#Y/很遗憾，此次操作并未成功！你好像失去了点什么东西！")
            发送数据(连接id,3699)
            return
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
        常规提示(id,"#Y/操作成功，该装备似乎发生了某种变化！")
        发送数据(连接id,3699)
        return
    elseif 包裹类型 == "特性宝珠" then
        if self.数据[装备].分类 > 6 then
            常规提示(id, "#Y/特性宝珠只能针对装备使用")
            return
        elseif self.数据[装备].等级 ~= 160 then
            常规提示(id, "#Y/只能针对160的武器使用特性宝珠")
            return
        end
        local 新特效 = {"物理暴击几率","法术暴击几率","物理暴击伤害","法术暴击伤害","治疗能力","封印命中率","抵抗封印命中率","穿刺效果","格挡物理伤害","法术伤害减免","魔法回复效果"}
        self.数据[装备].新特效 = 新特效[random(1,#新特效)]
        if self.数据[装备].新特效 == "魔法回复效果" then
            self.数据[装备].新特效数值 = random(6,20)
        elseif self.数据[装备].新特效 == "格挡物理伤害" then
            self.数据[装备].新特效数值 = random(20,40)
        elseif self.数据[装备].新特效 == "治疗能力" then
            self.数据[装备].新特效数值 = random(6,20)
        else
            self.数据[装备].新特效数值 = string.format("%.2f",random(80,300)/100)
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
        发送数据(连接id,3699)
        常规提示(id,"#Y/附加特性成功！")



        -- elseif 包裹类型 == "武器专属" then
        --     if self.数据[装备].分类 ~= 3 then
        --         常规提示(id, "#Y/只有武器才可以使用武器专属")
        --         return
        --     elseif self.数据[装备].等级 ~= 160 then
        --         常规提示(id, "#Y/只能针对160的武器使用武器专属石")
        --         return
        --     end
        --     local 门派 = Q_门派编号1[取随机数(1,#Q_门派编号1)]
        --     local 数值 = 1
        --     local 随机数 = 取随机数()
        --     local 类型 = 取门派专属(门派)

            -- if 随机数 <= 5 then  -- 5%概率
            --     数值 = 10
            -- elseif 随机数 <= 10 then  -- 5%概率
            --     数值 = 取随机数(8, 9)
            -- elseif 随机数 <= 35 then  -- 25%概率
            --     数值 = 取随机数(5, 7)
            -- else  -- 65%概率
            --     数值 = 取随机数(1, 4)
            -- end
            -- if 类型 == "治疗能力" then
            --     数值 = 数值 * 10
            -- end
        --     if self.数据[装备].武器专属 == nil then
        --         self.数据[装备].武器专属 = {门派 = 门派, 数值 = 数值, 类型 = 类型}
        --     else
        --         self.数据[装备].武器专属 = {门派 = 门派, 数值 = 数值, 类型 = 类型}
        --     end
        --     self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
        --     local 保底=WQZSS
        --     if self.数据[装备].专属次数==nil then
        --                 self.数据[装备].专属次数=0
        --             end
        --             self.数据[装备].专属次数=self.数据[装备].专属次数+1
        --         if self.数据[装备].专属次数>=保底 then
        --                 self.数据[装备].专属次数=nil
        --                 self.数据[装备].武器专属 = {门派 = 玩家数据[id].角色.门派, 数值 = 数值, 类型 = 取门派专属(玩家数据[id].角色.门派)}
        --             添加最后对话(id,"#Y/触发保底，你的#R/"..self.数据[装备].名称.."#Y/获得了对#G/"..玩家数据[id].角色.门派.."#Y/"..取门派专属(玩家数据[id].角色.门派).."加成#R/"..数值.."%")
        --             end
        --     if 类型 == "治疗能力" then
        --         常规提示(id,"#Y/操作成功，你的#R/"..self.数据[装备].名称.."#Y/获得了#Y/"..类型.."加成#R/"..数值)
        --     else
        --          常规提示(id,"#Y/操作成功，你的#R/"..self.数据[装备].名称.."#Y/获得了对#G/"..门派.."#Y/"..类型.."加成#R/"..数值.."%")
        --     end
        --     发送数据(连接id,3699)
        --     return
    elseif 包裹类型 == "武器专属" then
            if self.数据[装备].分类 ~= 3 then
                常规提示(id, "#Y/只有武器才可以使用武器专属")
                return
            elseif self.数据[装备].等级 ~= 160 then
                常规提示(id, "#Y/只能针对160的武器使用武器专属石")
                return
            end
            self:删除道具(连接id, id, "道具", 道具id, 符纸格子, 1)
            if self.数据[装备].专属次数 == nil then
                self.数据[装备].专属次数 = 0
            end
            self.数据[装备].专属次数 = self.数据[装备].专属次数 + 1
            local 门派, 数值, 类型
            if self.数据[装备].专属次数 >= WQZSS then
                self.数据[装备].专属次数 = nil
                门派 = 玩家数据[id].角色.门派
                类型 = 取门派专属(门派)
                local 随机数 = 取随机数()
                if 随机数 <= 5 then  -- 5%概率
                    数值 = 10
                elseif 随机数 <= 15 then  -- 10%概率
                    数值 = 取随机数(8, 9)
                elseif 随机数 <= 40 then  -- 25%概率
                    数值 = 取随机数(5, 7)
                else  -- 60%概率
                    数值 = 取随机数(1, 4)
                end
                if 类型 == "治疗能力" then
                    数值 = 数值 * 10
                end
                self.数据[装备].武器专属 = {门派 = 门派, 数值 = 数值, 类型 = 类型}
                if 类型 == "治疗能力" then
                    添加最后对话(id, "#Y/触发保底，你的#R/"..self.数据[装备].名称.."#Y/获得了#Y/"..类型.."加成#R/"..数值)
                else
                    添加最后对话(id, "#Y/触发保底，你的#R/"..self.数据[装备].名称.."#Y/获得了对#G/"..门派.."#Y/"..类型.."加成#R/"..数值.."%")
                end
            else
                门派 = Q_门派编号1[取随机数(1,#Q_门派编号1)]
                类型 = 取门派专属(门派)
                local 随机数 = 取随机数()
                if 随机数 <= 5 then  -- 5%概率
                    数值 = 10
                elseif 随机数 <= 15 then  -- 10%概率
                    数值 = 取随机数(8, 9)
                elseif 随机数 <= 40 then  -- 25%概率
                    数值 = 取随机数(5, 7)
                else  -- 60%概率
                    数值 = 取随机数(1, 4)
                end
                if 类型 == "治疗能力" then
                    数值 = 数值 * 10
                end
                self.数据[装备].武器专属 = {门派 = 门派, 数值 = 数值, 类型 = 类型}
                if 类型 == "治疗能力" then
                    常规提示(id, "#Y/操作成功，你的#R/"..self.数据[装备].名称.."#Y/获得了#Y/"..类型.."加成#R/"..数值)
                else
                    常规提示(id, "#Y/操作成功，你的#R/"..self.数据[装备].名称.."#Y/获得了对#G/"..门派.."#Y/"..类型.."加成#R/"..数值.."%")
                end
            end

            发送数据(连接id, 3699)
            return
    elseif 包裹类型=="灵饰鉴定" then
        if not self.数据[装备].鉴定 then
            local 物品=取物品数据(self.数据[装备].名称)
            local 级别 = tonumber(物品[5])
            if tonumber(self.数据[道具id].等级) >= 级别 then
                self.数据[装备].鉴定 = true
                常规提示(id,"#Y/物品鉴定成功")
                self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
                if self.数据[装备].幻化属性.附加 then
                    local go = self.数据[装备].幻化属性.附加[1].类型
                    for i=1,#self.数据[装备].幻化属性.附加 do
                        if go~=self.数据[装备].幻化属性.附加[i].类型 then
                            go=false
                            break
                        end
                    end
                    if go~=false and #self.数据[装备].幻化属性.附加==3 then
                        local xt1 = "一样的加成之耳饰"
                        local xt2 = "鉴定出一个三种随机属性皆一样的耳饰"
                        if self.数据[装备].子类==2 then
                            xt1 = "一样的加成之佩饰"
                            xt2 = "鉴定出一个三种随机属性皆一样的佩饰"
                        elseif self.数据[装备].子类==3 then
                            xt1 = "一样的加成之戒指"
                            xt2 = "鉴定出一个三种随机属性皆一样的戒指"
                        elseif self.数据[装备].子类==4 then
                            xt1 = "一样的加成之手镯"
                            xt2 = "鉴定出一个三种随机属性皆一样的手镯"
                        end
                        发送数据(连接id,105,{头像=xt1,标题=xt1,说明=xt2})
                    end
                end
                if 取随机数(1,1000)<=15 then
                    self.数据[装备].特效="超级简易"
                end
                发送数据(连接id,3699)
            else
                常规提示(id,"#Y/此图鉴的等级过低无法鉴定该装备")
                return
            end
        else
            常规提示(id,"#Y/这件装备已经鉴定过了请不要重复鉴定")
            return
        end
    elseif 包裹类型=="特技书" then
        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特技")
            return
        end
        if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
            常规提示(id,"该物品只能对人物装备使用")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
        local tj ={"琴音三叠","弱点击破","破血狂攻","心疗术","破碎无双","诅咒之伤","太极护法","罗汉金钟","慈航普度","放下屠刀","笑里藏刀","碎甲术","金刚怒目","命归术","心如明镜","气归术","凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","气归术","凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","凝滞术","吸血特技","金刚不坏","菩提心佑","起死回生","回魂咒","气疗术","野兽之力","魔兽之印","修罗咒","身似菩提","光辉之甲","圣灵之甲","四海升平","水清诀","玉清诀","冰清诀","晶清诀"}
        if self.数据[装备].特技~=nil then
            for k,v in pairs(tj) do
                if v==self.数据[装备].特技 then
                    table.remove(tj,k)
                    break
                end
            end
        end
        self.数据[装备].特技=tj[取随机数(1,#tj)]
        常规提示(id,"#G添加装备特技成功！")
        发送数据(连接id,3699)

    elseif 包裹类型=="不磨符" then
        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if self.数据[装备].总类~=2 or self.数据[装备].召唤兽装备 then
            常规提示(id,"该物品只能对人物装备使用")
            return
        end
        if self.数据[装备].灵饰 then
            常规提示(id,"该物品只能对人物装备使用")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        if self.数据[装备].特效~=nil and self.数据[装备].特效[1] then
            for i=1,#self.数据[装备].特效 do
                if self.数据[装备].特效[i] == "永不磨损" then
                   常规提示(id,"该装备已经拥有特效永不磨损，本次附加特效失败")
                   return
                end
            end
            self.数据[装备].特效[#self.数据[装备].特效+1]="永不磨损"
        else
            self.数据[装备].特效={}
            self.数据[装备].特效[1]="永不磨损"
        end
        常规提示(id,"#G添加装备特效永不磨损成功！")
        发送数据(连接id,3699)

    elseif 包裹类型=="特效宝珠" then
        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
            常规提示(id,"该物品只能对人物装备使用")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        local tx = {}
        local 保底=TXBD
               if self.数据[装备].分类 == 1 then --头盔
            tx = {"珍宝","简易","坚固","精致","永不磨损","易修理","珍宝","简易","坚固","精致","永不磨损","易修理"}
        elseif self.数据[装备].分类 == 2 then --项链
            tx = {"珍宝","简易","神农","专注","坚固","精致","永不磨损","珍宝","简易","神农","专注","坚固","精致","永不磨损"} --14
        elseif self.数据[装备].分类 == 3 then --武器
            tx = {"简易","神佑","必中","绝杀","精致","永不磨损","简易","神佑","必中","绝杀","精致","永不磨损"} --14
        elseif self.数据[装备].分类 == 4 then --衣服
            tx = {"珍宝","坚固","珍宝","简易","坚固","精致","永不磨损","珍宝","坚固","珍宝","简易","坚固","精致","永不磨损"}
        elseif self.数据[装备].分类 == 5 then --腰带
            tx = {"坚固","简易","坚固","精致","永不磨损","坚固","简易","坚固","精致","永不磨损"}
        elseif self.数据[装备].分类 == 6 then --鞋子
            tx = {"简易","坚固","精致","狩猎","迷踪","永不磨损","简易","坚固","精致","狩猎","迷踪","永不磨损"}
        end
        local wjbGl = TXBZGL
        if 取随机数()<=wjbGl then
            table.insert(tx,"无级别限制")
        end
        if self.数据[装备].特效~=nil and self.数据[装备].特效[1] then
            local 是否有无级别=false
            for n=1,#tx do
                for i=1,#self.数据[装备].特效 do
                    if self.数据[装备].特效[i]=="无级别限制" then
                        是否有无级别=i
                    end
                    if tx[n]==self.数据[装备].特效[i] then
                        table.remove(tx,n)
                    end
                end
            end
            if 是否有无级别 then
                local sj = 取随机数(1,#tx)
                self.数据[装备].特效[1]="无级别限制"
                self.数据[装备].特效[2]=tx[sj]
            else
                local sj = 取随机数(1,#tx)
                local num = 取随机数(1,#self.数据[装备].特效)
                self.数据[装备].特效[num]=tx[sj]
                if tx[sj]~="无级别限制" then
                    if self.数据[装备].附魔次数==nil then
                        self.数据[装备].附魔次数=0
                    end
                    self.数据[装备].附魔次数=self.数据[装备].附魔次数+1
                    if self.数据[装备].附魔次数>=保底 then
                        self.数据[装备].附魔次数=nil
                        self.数据[装备].特效[num]="无级别限制"
                    end
                end
            end

        else
            self.数据[装备].特效={}
            local dwq=tx[取随机数(1,#tx)]
            self.数据[装备].特效[1]=dwq
            if dwq~="无级别限制" then
                if self.数据[装备].附魔次数==nil then
                    self.数据[装备].附魔次数=0
                end
                self.数据[装备].附魔次数=self.数据[装备].附魔次数+1

                if self.数据[装备].附魔次数>=保底 then--
                    self.数据[装备].附魔次数=nil
                    self.数据[装备].特效[1]="无级别限制"
                    -- print(11)
                end
            end
        end
        if self.数据[装备].特效[1]~="无级别限制" then
            常规提示(id,"#G添加装备特效成功！当前装备附魔次数："..self.数据[装备].附魔次数)
        else
            常规提示(id,"#G添加装备特效成功！")
        end
        发送数据(连接id,3699)

    elseif 包裹类型=="超简易宝珠" then
        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if not self.数据[装备].灵饰 then
            常规提示(id,"该物品只能对灵饰使用")
            return
        end
        if self.数据[装备].特效 == "超级简易" then
            常规提示(id,"该装备已经拥有该特效了，不要浪费哦。")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        local num=21
        if 取随机数()<=num then
            self.数据[装备].特效="超级简易"
            常规提示(id,"#G添加装备特效成功！")
        else
            常规提示(id,"#R很遗憾，附魔失败！")
        end
        发送数据(连接id,3699)

    elseif 包裹类型=="灵箓" then
        local 数值=取随机数(1,200)
        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if self.数据[装备].总类~=2 or self.数据[装备].灵饰 ==false then
            常规提示(id,"该物品只能对灵饰使用")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        if  self.数据[装备].特性==nil then
             self.数据[装备].特性={}
        self.数据[装备].特性.技能=灵饰随机特性[取随机数(1,#灵饰随机特性)]

        if 0<数值 and 数值< 100  then
        self.数据[装备].特性.等级=1
        elseif  0<数值 and 数值< 120  then
        self.数据[装备].特性.等级=2
        elseif 0<数值 and 数值< 140  then
        self.数据[装备].特性.等级=3
        elseif 0<数值 and 数值< 160  then
        self.数据[装备].特性.等级=4
        elseif 0<数值 and 数值< 180  then
        self.数据[装备].特性.等级=5
        elseif 0<数值 and 数值<= 200  then
        self.数据[装备].特性.等级=6
    end
         else
         self.数据[装备].特性.技能=灵饰随机特性[取随机数(1,#灵饰随机特性)]
         if 0<数值 and 数值< 100  then
        self.数据[装备].特性.等级=1
        elseif  0<数值 and 数值< 120  then
        self.数据[装备].特性.等级=2
        elseif 0<数值 and 数值< 140  then
        self.数据[装备].特性.等级=3
        elseif 0<数值 and 数值< 160  then
        self.数据[装备].特性.等级=4
        elseif 0<数值 and 数值< 180  then
        self.数据[装备].特性.等级=5
        elseif 0<数值 and 数值<= 200  then
        self.数据[装备].特性.等级=6
    end
end

        常规提示(id,"#Y/本次灵饰吸取获得了"..self.数据[装备].特性.等级.."级"..self.数据[装备].特性.技能.."特性")
        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        发送数据(连接id,3699)


    elseif 包裹类型=="淬灵石" then

        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if self.数据[装备].总类~=2 or self.数据[装备].灵饰 ==false then
            常规提示(id,"该物品只能对灵饰使用")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        if  self.数据[装备].特性==nil then
            常规提示(id,"没有钟灵石特性的道具无法淬灵")
            return
        end
        local 已有效果=self.数据[装备].特性
        self:给予道具(id,"钟灵石",已有效果.等级,已有效果.技能)
        self.数据[装备].特性=nil
        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        发送数据(连接id,3699)

    elseif 包裹类型=="钟灵石" then

        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if self.数据[装备].总类~=2 or self.数据[装备].灵饰 ==false then
            常规提示(id,"该物品只能对灵饰使用")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        if  self.数据[装备].特性==nil then
             self.数据[装备].特性={}
        end
        self.数据[装备].特性.技能=self.数据[道具id].特性
        self.数据[装备].特性.等级=self.数据[道具id].等级
        常规提示(id,"#Y/本次灵饰添加了"..self.数据[道具id].特性.."特性")



        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        发送数据(连接id,3699)
    elseif 包裹类型=="焕彩石" then
        if self.数据[装备].总类~=2  then
            常规提示(id,"该物品只能对锦衣足迹光环使用")
            return
        end
        if self.数据[装备].分类~=15 and  self.数据[装备].分类~=17   and  self.数据[装备].分类~=18 and  self.数据[装备].分类~=19   then
            常规提示(id,"该物品只能对锦衣足迹光环使用")
            return
        end
         if self.数据[装备].锦衣升级== nil then
            self.数据[装备].锦衣升级=0
         end
        if self.数据[装备].锦衣升级> 玩家数据[id].角色.等级 then
            常规提示(id,"以你目前的能力只能升至"..玩家数据[id].角色.等级.."级")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        if self.数据[道具id].等级 == nil then
            self.数据[道具id].等级 = 1
        end
         self.数据[装备].锦衣升级=self.数据[装备].锦衣升级+self.数据[道具id].等级
        if self.数据[装备].锦衣升级>= 175 then
            self.数据[装备].锦衣升级=175
        end
        self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
        常规提示(id,"你的锦衣等级提升成功")
        发送数据(连接id,3699)

    elseif 商品名称=="八级变身卡" then
                local lv=8
                玩家数据[id].道具:给予道具(id,"怪物卡片",lv,nil,"")
                道具使用=true

    elseif 商品名称=="九级变身卡" then
                local lv=9
                玩家数据[id].道具:给予道具(id,"怪物卡片",lv,nil,"")
                道具使用=true

    elseif 包裹类型=="愤怒符" then
        if not self.数据[装备].鉴定 then
            常规提示(id,"#Y/这个装备未鉴定无法附加特效")
            return
        end
        if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 or self.数据[装备].分类~=5   then
            常规提示(id,"该物品只能腰带使用")
            return
        end
        if self.数据[道具id].名称~=包裹类型 then
            return
        end
        if self.数据[装备].特效~=nil and self.数据[装备].特效[1] then
            local go
            for i=1,#self.数据[装备].特效 do
                if self.数据[装备].特效[i]=="愤怒" then
                    常规提示(id,"#Y/该装备已经拥有愤怒特效了，不要浪费哦。")
                    return
                end
                if self.数据[装备].特效[i]=="无级别限制" then
                    go=i
                end
            end
            if go~=nil then
                self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
                if #self.数据[装备].特效==1 then
                    self.数据[装备].特效[#self.数据[装备].特效+1]="愤怒"
                else
                    for i=1,100 do
                        local sjs = 取随机数(1,#self.数据[装备].特效)
                        if sjs~=go then
                            self.数据[装备].特效[sjs]="愤怒"
                            break
                        end
                    end
                end
            else
                常规提示(id,"#Y/不能附魔没有无级别限制的腰带。")
                return
            end
        else
            常规提示(id,"#Y/不能附魔没有无级别限制的腰带。")
            return
        end
        常规提示(id,"#G添加装备特效愤怒成功！")
        发送数据(连接id,3699)
    end
end

function 道具处理类:装备词条洗练(id,事件)
    local 装备 = 玩家数据[id].角色.词条洗练.装备
    local 道具id = 玩家数据[id].角色.词条洗练.道具id
    local 符纸格子 = 玩家数据[id].角色.词条洗练.符纸格子
    local 类型 = 玩家数据[id].角色.词条洗练.类型
    local name = nil
    for i = 1, #self.数据[装备].词条 do
        if i..": "..self.数据[装备].词条[i].类型 == 事件 then
            if 类型 == 2 then name = self.数据[装备].词条[i].类型 end
            local 名称,属性,数值 = 词条类型(name, self.数据[装备].分类)
            self.数据[装备].词条[i].类型 = 名称
            self.数据[装备].词条[i].属性 = 属性
            self.数据[装备].词条[i].数值 = 数值
            self:删除道具(玩家数据[id].连接id,id,"道具",道具id,符纸格子,1)
        end
    end
    玩家数据[id].角色.词条洗练 = nil
    常规提示(id,"#G词条洗练成功")
    发送数据(玩家数据[id].连接id,3699)
end
function 道具处理类:玉魄自选(连接id,id,数据)
    local 临时格子=玩家数据[id].角色:取道具格子()
    if 临时格子 == 0 then
        常规提示(id,"#Y你身上没有足够的空间")
        return
    end

    if 玩家数据[id].道具操作==nil or 玩家数据[id].最后操作 == nil then
        常规提示(id,"#Y生成异常请重新生成")
        return
    end

    local 编号=玩家数据[id].道具操作.编号
    local 道具id=玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称~=玩家数据[id].最后操作 then
        常规提示(id,"#Y你没有这样的道具或者请勿移动道具")
        return
    end

    local itemm = self.数据[道具id].名称
    local itemc
    local 玉魄类型

    -- 确定玉魄类型和名称
    if itemm=="上古玉魄阳自选" then
        itemc = "上古玉魄·阳"
        玉魄类型 = "阳"
    elseif itemm=="上古玉魄阴自选" then
        itemc = "上古玉魄·阴"
        玉魄类型 = "阴"
    else
        常规提示(id,"#Y无效的玉魄礼包类型")
        return
    end

    -- 验证属性数据
    if not 数据.幻化属性 then
        常规提示(id,"#Y属性数据错误")
        return
    end

    if not 数据.幻化属性.基础 or not 数据.幻化属性.基础.类型 then
        常规提示(id,"#Y请选择玉魄基础属性")
        return
    end

    if not 数据.幻化属性.附加 or #数据.幻化属性.附加 < 2 then
        常规提示(id,"#Y请选择2个玉魄附加属性")
        return
    end

    if not 数据.幻化属性.额外 or not 数据.幻化属性.额外.类型 then
        常规提示(id,"#Y请选择玉魄额外属性")
        return
    end

    if not 数据.幻化属性.特殊 or not 数据.幻化属性.特殊.类型 then
        常规提示(id,"#Y请选择玉魄特殊属性")
        return
    end

    -- 删除礼包道具
    self.数据[道具id] = nil

    -- 创建玉魄道具
    local 道具 = 物品类()
    道具:置对象(itemc)
    道具.等级 = 0
    道具.耐久 = 500
    道具.宝石 = {}
    道具.特技 = {}
    道具.三药 = {}
    道具.女娲符 = {}
    self.数据[道具id] = 道具

    -- 根据玉魄类型和属性类型设置基础属性（主属性）
    local 基础类型 = 数据.幻化属性.基础.类型
    local 基础数值 = 0

    if 玉魄类型 == "阳" then
        if 基础类型 == "伤害"  or 基础类型 == "法术伤害" or 基础类型 == "狂暴等级" or 基础类型 == "物理暴击等级" or 基础类型 == "法术暴击等级"
           or 基础类型 == "封印命中等级" or 基础类型 == "法术伤害结果" then
            基础数值 = 48
        elseif 基础类型 == "速度" or 基础类型 == "治疗能力" then
            基础数值 = 33
        elseif 基础类型 == "固伤暴击等级" then
            基础数值 = 142
        end
    elseif 玉魄类型 == "阴" then
        if 基础类型 == "气血" then
            基础数值 = 168
        elseif 基础类型 == "固伤暴击等级" then
            基础数值 = 142
        elseif 基础类型 == "防御" or 基础类型 == "法术防御" or 基础类型 == "抗物理暴击等级"
               or 基础类型 == "抗法术暴击等级" or 基础类型 == "抵抗封印等级"
               or 基础类型 == "格挡值" or 基础类型 == "气血回复效果" then
            基础数值 = 48
        end
    end

    -- 设置主属性（基础属性）到道具[1]
    self.数据[道具id][1] = {
        类型 = 基础类型,
        数值 = 基础数值
    }

    -- 设置附加属性（副属性）到道具[2]和道具[3]
    self.数据[道具id][2] = nil
    self.数据[道具id][3] = nil

    for i=1,2 do  -- 玉魄只有2个附加属性
        if 数据.幻化属性.附加[i] and 数据.幻化属性.附加[i].类型 then
            local 附加类型 = 数据.幻化属性.附加[i].类型
            local 附加数值 = 0
            if 玉魄类型 == "阳" then
                if 附加类型 == "伤害"  or 附加类型 == "法术伤害" or 附加类型 == "狂暴等级" or 附加类型 == "物理暴击等级" or 附加类型 == "法术暴击等级"
                    or 附加类型 == "封印命中等级" or 附加类型 == "法术伤害结果" then
                    附加数值 = 48
                elseif 附加类型 == "固伤暴击等级" then
                    附加数值 = 142
                elseif 附加类型 == "速度" or 附加类型 == "治疗能力" then
                    附加数值 = 33
                end
            elseif 玉魄类型 == "阴" then
                if 附加类型 == "气血" then
                    附加数值 = 168
                elseif 附加类型 == "固伤暴击等级" then
                    附加数值 = 142
                elseif 附加类型 == "防御" or 附加类型 == "法术防御" or 附加类型 == "抗物理暴击等级"
                        or 附加类型 == "抗法术暴击等级" or 附加类型 == "抵抗封印等级"
                        or 附加类型 == "格挡值" or 附加类型 == "气血回复效果" then
                    附加数值 = 48
                end
            end
            self.数据[道具id][i+1] = {
                类型 = 附加类型,
                数值 = 附加数值
            }
        end
    end

    -- 设置宝石属性（如果需要）
    -- for i=1,2 do
    --     if self.数据[道具id][i+1] then
    --         self.数据[道具id].宝石[i] = self:上古玉魄宝石计算(0, self.数据[道具id][i+1].类型)
    --     end
    -- end

    -- 设置额外属性（特效）
    local 额外类型 = 数据.幻化属性.额外.类型
    local 额外数值 = 0

    -- 根据额外属性类型设置数值
    if 额外类型 == "奇袭法术" then
        额外数值 = 20
    elseif 额外类型 == "物伤化劲" then
        额外数值 = 20
    elseif 额外类型 == "法伤化劲" then
        额外数值 = 20
    elseif 额外类型 == "固伤化劲" then
        额外数值 = 20
    elseif 额外类型 == "坚如磐石" then
        额外数值 = 20
    end

    -- 设置特效
    self.数据[道具id].特效 = 额外类型
    self.数据[道具id].特效值 = 额外数值

    -- 设置特殊属性
    local 特殊类型 = 数据.幻化属性.特殊.类型
    local 特殊数值 = 30
    -- 设置特殊属性
    self.数据[道具id].特殊属性 = 特殊类型
    self.数据[道具id].特殊属性值 = 特殊数值

    -- 生成识别码
    self.数据[道具id].识别码 = id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    随机序列 = 随机序列 + 1

    常规提示(id,"#Y/你得到了#R/"..self.数据[道具id].名称)
    道具刷新(id)
end

function 道具处理类:鉴定专用装备(连接id,id,内容)
    local 包裹类型=内容.类型
    local 道具格子=内容.道具格子
    local 符纸格子 =内容.符纸格子
    local 删除数量=1
    local 道具id=玩家数据[id].角色["道具"][符纸格子]
    local 装备=玩家数据[id].角色["道具"][道具格子]
    if self.数据[道具id] == nil or self.数据[装备] == nil or self.数据[装备].专用提示==nil then
        常规提示(id,"#Y/数据错误请重新鉴定")
    end
    if 包裹类型=="装备鉴定" then
        if not self.数据[装备].鉴定 then
            if self.数据[道具id].等级 >= self.数据[装备].等级 then
                self.数据[装备].鉴定 = true
                self.数据[装备].专用提示=nil
                常规提示(id,"#Y/物品鉴定成功！")
                常规提示(id,"#Y/可以通过梦幻精灵网页版查询装备的属性范围，你有兴趣的话可以去瞧瞧。")
                self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
                装备处理类:装备鉴定处理(连接id,id,self.数据[装备],true)
                发送数据(连接id,3699)
            else
                常规提示(id,"#Y/此图鉴的等级过低无法鉴定该装备")
                return
            end
        else
            常规提示(id,"#Y/这件装备已经鉴定过了请不要重复鉴定")
            return
        end
    end
end

function 道具处理类:取队长权限(id)
    if 玩家数据[id].队伍==0 then
        return true
    elseif 玩家数据[id].队伍~=0 and 玩家数据[id].队长 then
        return true
    else
        return false
    end
end

function 道具处理类:加血处理(连接id,id,加血数值,加血对象,动画,伤势数值)
    if 动画==nil then
        动画="加血"
    end
    if 加血对象==0 then
        玩家数据[id].角色.气血=玩家数据[id].角色.气血+加血数值
        if 伤势数值 ~= nil then
            玩家数据[id].角色.气血上限=玩家数据[id].角色.气血上限+伤势数值
            if 玩家数据[id].角色.气血上限>玩家数据[id].角色.最大气血 then
                玩家数据[id].角色.气血上限=玩家数据[id].角色.最大气血
            end
        end
        if 玩家数据[id].角色.气血>玩家数据[id].角色.气血上限 then
            玩家数据[id].角色.气血=玩家数据[id].角色.气血上限
        end
        发送数据(连接id,36,{动画=动画})
        发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
        地图处理类:加入动画(id,玩家数据[id].角色.地图数据.编号,玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y,动画)
    else
        玩家数据[id].召唤兽:加血处理(加血对象,加血数值,连接id,id)
    end
end

function 道具处理类:加魔处理(连接id,id,加血数值,加血对象)
    if 加血对象==0 then
        玩家数据[id].角色.魔法=玩家数据[id].角色.魔法+加血数值
        if 玩家数据[id].角色.魔法>玩家数据[id].角色.最大魔法 then
            玩家数据[id].角色.魔法=玩家数据[id].角色.最大魔法
        end
        发送数据(连接id,36,{动画="加蓝"})
        发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
        地图处理类:加入动画(id,玩家数据[id].角色.地图数据.编号,玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y,"加蓝")
    else
        玩家数据[id].召唤兽:加蓝处理(加血对象,加血数值,连接id,id)
    end
end

function 道具处理类:取飞行限制(id)
    if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
        常规提示(id,"只有队长才可以使用飞行道具")
        return true
    elseif self:取禁止飞行(id) then
        常规提示(id,"#Y/您当前无法使用飞行道具")
        return true
    elseif 玩家数据[id].角色.等级<10 then
        常规提示(id,"#Y/您当前等级太低了无法使用飞行道具")
        return true
    elseif 玩家数据[id].队伍~=0 and 玩家数据[id].队长 then
        local 队伍id=玩家数据[id].队伍
        for n=1,#队伍数据[队伍id].成员数据 do
            if self:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
                常规提示(id,format("#G/%s当前不能使用飞行道具",玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称))
                return true
            end
        end
    end
    return false
end

function 道具处理类:取禁止飞行(id)
    if 玩家数据[id] and 玩家数据[id].摊位数据~=nil then return true end
    if not 玩家数据[id] or not 玩家数据[id].角色 then return true end
    if 收购数据[id]~=nil then return true end
    local 任务id=玩家数据[id].角色:取任务(110)
    if 任务id~=0 and 任务数据[任务id].分类==2 then return true  end
    if 玩家数据[id].角色:取任务(208)~=0 or 玩家数据[id].角色:取任务(300)~=0 or 玩家数据[id].勾魂索中 or 玩家数据[id].坐牢中 or 玩家数据[id].烤火 then return true end
    if 玩家数据[id].角色.剧情.附加.禁止飞行 then return true end
    if feixingdaoju[玩家数据[id].角色.地图数据.编号] then
        return true
    end
    return false
end

function 道具处理类:神兽兑换(id,事件,名称)
    if 名称 == "超级鲲鹏" and (not 玩家数据[id].角色.神兽兑换 or 玩家数据[id].角色.神兽兑换 ~= "超级鲲鹏") then
        常规提示(id,"#Y/少侠还不满足领取我的要求")
        return
    end
    local 神兜兜数量 = 99
  local 灵兜兜数量 = 1
    if 名称 == "超级鲲鹏" and 玩家数据[id].角色.神兽兑换 and 玩家数据[id].角色.神兽兑换 == "超级鲲鹏" then
        神兜兜数量 = 2999
    灵兜兜数量 = 10
    end
    if 玩家数据[id].道具:判定背包道具(id,"神兜兜",神兜兜数量) and 玩家数据[id].道具:判定背包道具(id,"灵兜兜",灵兜兜数量) then
        玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",神兜兜数量)
        玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"灵兜兜",灵兜兜数量)
        if 名称 == "超级鲲鹏" then 玩家数据[id].角色.神兽兑换 = nil end
        local 链接 = {提示=format("#R%s#W成功集齐了"..神兜兜数量.."个神兜兜和"..灵兜兜数量.."个灵兜兜在#R%s#W处换取了一只",玩家数据[id].角色.名称,名称),频道="xt",结尾="#117"}
        玩家数据[id].召唤兽:添加神兽(名称,事件,nil,链接)
    else
        常规提示(id,"#Y/大侠还没有集齐“神兜兜”或是“灵兜兜”，无法兑换神兽")
    end
end

-- function 道具处理类:给予暗器(id,等级)
--  local 名称="飞刀"
--  if 等级==1 then
--      名称="飞刀"
--  elseif 等级==2 then
--      名称="飞蝗石"
--  elseif 等级==3 then
--      名称="铁蒺黎"
--  elseif 等级==4 then
--      名称="无影神针"
--  elseif 等级==5 then
--      名称="孔雀翎"
--  elseif 等级==6 then
--      名称="含沙射影"
--  elseif 等级==7 then
--      名称="回龙摄魂标"
--  elseif 等级==8 then
--      名称="寸阴若梦"
--  elseif 等级==9 then
--      名称="魔睛子"
--  elseif 等级==10 then
--      名称="顺逆神针"
--  end
--  -- 常规提示(id,"#Y你获得了#R"..名称)
--  self:给予道具(id,名称)
-- end

function 道具处理类:给予随机法宝(id)
    local 参数=取随机数()
    local 名称=""
    local 等级=0
    if 参数<=30 then
     名称={"碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇"}
     等级=1
    elseif 参数<=65 then
     名称={"发瘟匣","断线木偶","五彩娃娃","七杀","金刚杵","兽王令","摄魂"}
     等级=2
    else
     名称={"失心钹","五火神焰印","九幽","普渡","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经","干将莫邪","慈悲","救命毫毛","伏魔天书","镇海珠","奇门五行令"}
     等级=3
    end
    名称=名称[取随机数(1,#名称)]
    self:给予法宝(id,名称)
end

function 道具处理类:给予法宝(id,名称,消费,消费方式,消费内容)
    if 消费方式 ~= nil then
        if 消费方式 == "银子" then
            if not 玩家数据[id].角色:扣除银子(消费,0,0,消费内容,1) then
                常规提示(id,"你没有那么多的银子")
                return false
            end
        elseif 消费方式 == "仙玉" then
            if not 玩家数据[id].角色:扣除仙玉( 消费, 消费内容) then
                return false
            end
        elseif 消费方式 == "仙玉积分" then
            if not 玩家数据[id].角色:扣除积分(消费, 消费内容, id) then
                return false
            end
        end
    end
    local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    随机序列=随机序列+1
    local 道具格子=玩家数据[id].角色:取法宝格子()
    if 道具格子==0 then
        常规提示(id,"您的法宝栏已经满啦")
        return
    end
    local 道具id=self:取新编号()
    self.数据[道具id]=物品类()
    self.数据[道具id]:置对象(名称)
    玩家数据[id].角色.法宝[道具格子]=道具id
    self.数据[道具id].识别码=识别码
    local 道具 = 取物品数据(名称)
    self.数据[道具id].总类 = 1000
    self.数据[道具id].分类 = 道具[3]
    self.数据[道具id].使用 = 道具[5]
    self.数据[道具id].特技 = 道具[6]
    self.数据[道具id].气血 = 0
    self.数据[道具id].魔法 = 取灵气上限(道具[3])
    local 临时=道具[7]
    if 道具[7] and type(道具[7])=="table" then
        临时=道具[7][1]
        end
    self.数据[道具id].角色限制 = 临时 or 0
    self.数据[道具id].五行 = 取五行()
    self.数据[道具id].伤害 = 道具[8] or 0
    self.数据[道具id].当前经验=0
    self.数据[道具id].升级经验=法宝经验[道具[3]][1]
    玩家数据[id].角色:日志记录(format("获得新法宝：名称%s,识别码%s",名称,识别码), "获取法宝")
    常规提示(id,"#Y你获得了新的法宝#R"..名称)
    return true
end

function 道具处理类:给予灵宝(id,名称,消费,消费方式,消费内容)
    if 消费方式 ~= nil then
        if 消费方式 == "银子" then
            if not 玩家数据[id].角色:扣除银子(消费,0,0,消费内容,1) then
                常规提示(id,"你没有那么多的银子")
                return false
            end
        elseif 消费方式 == "仙玉" then
            if not 玩家数据[id].角色:扣除仙玉( 消费, 消费内容) then
                return false
            end
        elseif 消费方式 == "仙玉积分" then
            if not 玩家数据[id].角色:扣除积分(消费, 消费内容, id) then
                return false
            end
        end
    end
    if 名称 == nil then
        名称 = 取随机灵宝()
    end
    local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    随机序列=随机序列+1
    local 道具格子=玩家数据[id].角色:取灵宝格子()
    if 道具格子==0 then
        常规提示(id,"您的灵宝栏已经满啦")
        return
    end
    local 道具id=self:取新编号()
    self.数据[道具id]=物品类()
    self.数据[道具id]:置对象(名称)
    玩家数据[id].角色.灵宝[道具格子]=道具id
    self.数据[道具id].识别码=识别码
    local 道具 = 取物品数据(名称)
    self.数据[道具id].总类=1002
    self.数据[道具id].分类=道具[3]
    self.数据[道具id].使用 = 道具[5]
    self.数据[道具id].特技 = 道具[6]
    self.数据[道具id].气血 = 0
    self.数据[道具id].魔法 = 取灵气上限(道具[3])
    self.数据[道具id].当前经验=0
    self.数据[道具id].升级经验=灵宝经验[self.数据[道具id].分类][1]
    玩家数据[id].角色:日志记录(format("获得新法宝：名称%s,识别码%s",名称,识别码),"获取灵宝")
    常规提示(id,"#Y你获得了新的灵宝#R"..名称)
    return true
end

function 道具处理类:给予任务道具(id,名称,数量,参数,附加)
    local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
    local 道具id
    随机序列=随机序列+1
    local 道具格子=玩家数据[id].角色:取任务格子()
    if 道具格子==0 then
        常规提示(id,"您的任务栏物品已经满啦")
        return false
    else
            local 重置id=0
        for n=1,20 do
            if 重置id==0 and 玩家数据[id].角色.任务包裹[n]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]].名称==名称 and self.数据[玩家数据[id].角色.任务包裹[n]].数量~=nil then
                if 数量 == nil then 数量 =1 end
                if self.数据[玩家数据[id].角色.任务包裹[n]].数量+数量<=999 then
                    数量=self.数据[玩家数据[id].角色.任务包裹[n]].数量+数量
                    道具id=玩家数据[id].角色.任务包裹[n]
                    识别码=self.数据[玩家数据[id].角色.任务包裹[n]].识别码
                    重置id=1
                end
            end
        end
        if 重置id==0 then
            道具id=self:取新编号()
            self.数据[道具id]=物品类()
            self.数据[道具id]:置对象(名称)
            玩家数据[id].角色.任务包裹[道具格子]=道具id
        end
        临时道具 = 取物品数据(名称)
        临时道具.总类=临时道具[2]
        临时道具.子类=临时道具[4]
        临时道具.分类=临时道具[3]
        if self.数据[道具id].可叠加 then
            if 数量 == nil then
                self.数据[道具id].数量=1
                常规提示(id,"#Y/你得到了#R1#Y个#R"..self.数据[道具id].名称.."#Y已存入任务栏")
            else
                self.数据[道具id].数量=数量
                常规提示(id,"#Y/你得到了#R"..数量.."#Y个#R"..self.数据[道具id].名称.."#Y已存入任务栏")
            end
        else
            常规提示(id,"#Y/你得到了#R1#Y个#R"..self.数据[道具id].名称.."#Y已存入任务栏")
        end
    end
end

function 道具处理类:临时背包索取()
    local fhz ={道具={}}
    local fhz2 = false
    for k,v in pairs(玩家数据[self.玩家id].角色.临时包裹) do
        if self.数据[玩家数据[self.玩家id].角色.临时包裹[k]]==nil then
            玩家数据[self.玩家id].角色.临时包裹[k]=nil
        else
            fhz.道具[k]=table.copy(self.数据[玩家数据[self.玩家id].角色.临时包裹[k]])
            fhz2 = true
        end
    end
    return {fhz,fhz2}
end

function 道具处理类:临时背包处理(连接id,id,sj)
    if sj.方式  == "获取" then
        local 格子=玩家数据[id].角色:取道具格子()
        if 格子==0 then
            常规提示(id,"#Y/你身上的包裹没有足够的空间")
            return
        end
        if 玩家数据[id].角色.临时包裹[sj.选中] ~= nil and self.数据[玩家数据[id].角色.临时包裹[sj.选中]]  ~= nil then
            self:给予道具(id,nil,nil,nil,nil,nil,table.copy(self.数据[玩家数据[id].角色.临时包裹[sj.选中]]))
        else
            常规提示(id,"#Y/临时背包没有这个道具")
            return
        end
        玩家数据[id].角色.临时包裹[sj.选中] = nil
        local fhz = self:临时背包索取()
        if fhz[2] then
            发送数据(玩家数据[id].连接id,301,{"临时背包",fhz[1]})
        else
            发送数据(玩家数据[id].连接id,302,{"临时背包"})
            发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",false})
        end
    elseif sj.方式  == "清空" then
        for k,v in pairs(玩家数据[id].角色.临时包裹) do
            self.数据[玩家数据[id].角色.临时包裹[k]] = nil
        end
        玩家数据[id].角色.临时包裹 = {}
        发送数据(玩家数据[id].连接id,302,{"临时背包"})
        发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",false})
    elseif sj.方式  == "索取" then
        发送数据(玩家数据[id].连接id,300,{"临时背包",self:临时背包索取()[1]})
    end
end




function 道具处理类:御兽术处理(连接id,数字id,数据)--御兽术修改
    if 数据.学习项目 == nil then
      常规提示(数字id,"#Y/请选择你要学习的项目")
      return
    end
    if 玩家数据[数字id].角色.御兽术 ==nil then
    玩家数据[数字id].角色.御兽术={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0}
    end
     local 需要仙玉=300*(玩家数据[数字id].角色.御兽术[数据.学习项目]+1)
     local 需要经验=30000000*(玩家数据[数字id].角色.御兽术[数据.学习项目]+1)
     local 需要副本积分=200*(玩家数据[数字id].角色.御兽术[数据.学习项目]+1)
     local 上限
            if 玩家数据[数字id].角色.等级>=60 and 玩家数据[数字id].角色.等级<100 then
                        上限=12
            elseif 玩家数据[数字id].角色.等级>=100 and 玩家数据[数字id].角色.等级<120 then
                        上限=17
            elseif 玩家数据[数字id].角色.等级>=120 and 玩家数据[数字id].角色.等级<155 then
                        上限=22
            elseif 玩家数据[数字id].角色.等级>=155 and 玩家数据[数字id].角色.等级<170 then
                        上限=27
            elseif 玩家数据[数字id].角色.等级>=170 then
                        上限=35
            else
                        上限=9
            end
    if 玩家数据[数字id].角色.御兽术[数据.学习项目]>=上限 then
      常规提示(数字id,"#Y/你的此项学习已经达上限")
      return
    end
    if 取仙玉(数字id)<需要仙玉 then
        常规提示(数字id,"#Y/你的当前的银子不够学习哦")
        return
    end
    if 玩家数据[数字id].角色.当前经验 < 需要经验 then
        常规提示(数字id,"#Y/当前经验不足，无法学习")
        return
    end

    if 玩家数据[数字id].角色.副本积分 < 需要副本积分 then
        常规提示(数字id,"#Y/当前副本积分不足，无法学习")
        return
    end
    玩家数据[数字id].角色:扣除经验(需要经验)
    玩家数据[数字id].角色:扣除仙玉(需要仙玉,0,0,"御兽术",1)
    玩家数据[数字id].角色:扣除副本积分(需要副本积分)
    玩家数据[数字id].角色.御兽术[数据.学习项目]=玩家数据[数字id].角色.御兽术[数据.学习项目]+1
    玩家数据[数字id].角色:刷新信息()
    for n,v in ipairs(玩家数据[数字id].召唤兽.数据) do
        玩家数据[数字id].召唤兽:刷新信息(v.认证码)
    end
    发送数据(连接id,16,玩家数据[数字id].召唤兽.数据)
    发送数据(连接id,74.2,{御兽术=玩家数据[数字id].角色.御兽术,限制=上限})

    常规提示(数字id,"#G/学习成功")
end

function 道具处理类:升级锦衣(连接id,id,数据)
    if 数据.锦衣 then
                if 数据.类型 ~= "行囊" and 数据.类型 ~= "道具" and 数据.类型 ~= "任务包裹" and 数据.类型 ~= "法宝" then
                 常规提示(id,"数据异常重新操作")
                return
              end
                if 玩家数据[id].角色.锦衣[数据.道具] and self.数据[玩家数据[id].角色.锦衣[数据.道具]] then
                     if self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级==nil then
                        self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级=0
                        elseif self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级>=175 then
                        常规提示(id,"最高175级!")
                        return false
                     end
                     local 消耗=0+self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级*10
                      if not 玩家数据[id].角色:扣除仙玉( 消耗, "升级锦衣") then--消耗的仙玉
                                return false
                            end
                            --local 几率=100--  100-self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级*10 --需要几率就删掉100
                            local 几率=100-self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级*5
                            if 取随机数()<=几率 then
                            self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级=self.数据[玩家数据[id].角色.锦衣[数据.道具]].等级+1
                            常规提示(id,"升级成功")
                            self:刷新道具行囊(id,数据.类型)
                            发送数据(玩家数据[id].连接id,3703,玩家数据[id].角色:取锦衣数据())
                            发送数据(玩家数据[id].连接id,3704)
                            发送数据(玩家数据[id].连接id,12)
                            玩家数据[id].角色:刷新信息()
                            else
                                常规提示(id,"很遗憾失败了!")
                            end
                else
                    常规提示(id,"这个道具不存在哈!")
                end
        else
            常规提示(id,"请正确选择锦衣类!")
    end
end

function 道具处理类:佩戴锦衣(连接id,id,道具id,数据)
     local 物品=取物品数据(self.数据[道具id].名称)
    -- if 玩家数据[id].角色.性别 ~= 物品[6] and 物品[4] == 1 then
    --  常规提示(id,"#Y你无法穿戴这个性别的锦衣套装")
    --  return
    -- end
    if 数据.类型~="锦衣背包" then
        常规提示(id,"#Y请将物品放进锦衣背包进行穿戴!")
        return
    end
    if self.数据[道具id].角色限制~=nil then
    if 玩家数据[id].角色.造型 ~= self.数据[道具id].角色限制 then
        常规提示(id,"#Y你无法穿戴这个造型的锦衣套装")
        return
    end
    end
    local 佩戴要求=true
    if self.数据[道具id].名称=="凤羽吉光" and 玩家数据[id].角色.模型~="剑侠客" then
            佩戴要求=false
    elseif self.数据[道具id].名称=="恶魔棘刺" and (玩家数据[id].角色.模型=="杀破狼" or 玩家数据[id].角色.模型=="桃夭夭" )  then
            佩戴要求=false
    end
    if  佩戴要求==false then
        常规提示(id,"#Y这个造型无此武器装扮")
        return
    end
    if 玩家数据[id].角色.锦衣[self.数据[道具id].子类]==nil then
        玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
        玩家数据[id].角色[数据.类型][数据.道具]=nil
        if self.数据[道具id].锦衣进阶~=nil then
            if 玩家数据[id].角色.锦衣进阶.技能== self.数据[道具id].锦衣进阶.技能  then
                玩家数据[id].角色.锦衣进阶.数量=玩家数据[id].角色.锦衣进阶.数量+1
                if self.数据[道具id].锦衣升级 then
                玩家数据[id].角色.锦衣进阶.等级=玩家数据[id].角色.锦衣进阶.等级+self.数据[道具id].锦衣升级
                end
                if 玩家数据[id].角色.锦衣进阶.数量>3 then
                玩家数据[id].角色.锦衣进阶.数量=3
                end
                if 玩家数据[id].角色.锦衣进阶.数量==3 then
                常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件，#G效果已激活")
                    玩家数据[id].角色.锦衣进阶.开启=true
                else
                常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件")
                end
            end
            if  玩家数据[id].角色.锦衣进阶.技能=="无" or  玩家数据[id].角色.锦衣进阶.数量==0  then
              玩家数据[id].角色.锦衣进阶.技能=self.数据[道具id].锦衣进阶.技能
               玩家数据[id].角色.锦衣进阶.数量=1
                常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件")
            end
        end
    else
        local 道具id1=玩家数据[id].角色.锦衣[self.数据[道具id].子类]
        玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
        玩家数据[id].角色[数据.类型][数据.道具]=道具id1

        if  self.数据[道具id1].锦衣进阶~=nil then
            if 玩家数据[id].角色.锦衣进阶.技能==self.数据[道具id1].锦衣进阶.技能 then
                if self.数据[道具id1].锦衣升级 then
                玩家数据[id].角色.锦衣进阶.等级=玩家数据[id].角色.锦衣进阶.等级-self.数据[道具id1].锦衣升级
                if 玩家数据[id].角色.锦衣进阶.等级<0 then
                    玩家数据[id].角色.锦衣进阶.等级=0
                end
                end
                玩家数据[id].角色.锦衣进阶.数量=玩家数据[id].角色.锦衣进阶.数量-1
                常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id1].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件，#G效果已消失")
                玩家数据[id].角色.锦衣进阶.开启=false
                if 玩家数据[id].角色.锦衣进阶.数量<0 then
                    玩家数据[id].角色.锦衣进阶.数量=0
                end
            end
        end
        if self.数据[道具id].锦衣进阶~=nil then
            if 玩家数据[id].角色.锦衣进阶.技能== self.数据[道具id].锦衣进阶.技能  then
                玩家数据[id].角色.锦衣进阶.数量=玩家数据[id].角色.锦衣进阶.数量+1
                if self.数据[道具id].锦衣升级 then
                玩家数据[id].角色.锦衣进阶.等级=玩家数据[id].角色.锦衣进阶.等级+self.数据[道具id].锦衣升级
                end
                if 玩家数据[id].角色.锦衣进阶.数量>3 then
                玩家数据[id].角色.锦衣进阶.数量=3
                end
                if 玩家数据[id].角色.锦衣进阶.数量==3 then
                玩家数据[id].角色.锦衣进阶.开启=true
                常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件，#G效果已激活")
                else
                常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件")
                end
            end
            if  玩家数据[id].角色.锦衣进阶.技能=="无" or  玩家数据[id].角色.锦衣进阶.数量==0 then
              玩家数据[id].角色.锦衣进阶.技能=self.数据[道具id].锦衣进阶.技能
               玩家数据[id].角色.锦衣进阶.数量=1
                常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件")
            end
        end
    end
    -- self:刷新道具行囊(id,数据.类型)
    发送数据(玩家数据[id].连接id,3703,玩家数据[id].角色:取锦衣数据())
    self:索要锦衣(玩家数据[id].连接id,id)
    发送数据(玩家数据[id].连接id,3704)
    地图处理类:更新锦衣(id,玩家数据[id].道具.数据[玩家数据[id].角色.锦衣[self.数据[道具id].子类 ]].名称,self.数据[道具id].子类 )
    发送数据(玩家数据[id].连接id,12)
    玩家数据[id].角色:刷新信息()
end

-- function 道具处理类:卸下锦衣(连接id,id,道具id,道具格子,数据)
--     if 数据.类型 ~= "行囊" and 数据.类型 ~= "道具" and 数据.类型 ~= "任务包裹" and 数据.类型 ~= "法宝" then
--         return
--     end
--     local 道具id1=玩家数据[id].角色.锦衣[数据.道具]
--     if  self.数据[道具id1].锦衣进阶~=nil then
--         if 玩家数据[id].角色.锦衣进阶.技能==self.数据[道具id1].锦衣进阶.技能 then
--             if self.数据[道具id1].锦衣升级 then
--                 玩家数据[id].角色.锦衣进阶.等级=玩家数据[id].角色.锦衣进阶.等级-self.数据[道具id1].锦衣升级
--                 if 玩家数据[id].角色.锦衣进阶.等级<0 then
--                     玩家数据[id].角色.锦衣进阶.等级=0
--                 end
--             end
--             玩家数据[id].角色.锦衣进阶.数量=玩家数据[id].角色.锦衣进阶.数量-1
--             常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id1].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件，#G效果已消失")
--             玩家数据[id].角色.锦衣进阶.开启=false
--             if 玩家数据[id].角色.锦衣进阶.数量<0 then
--                 玩家数据[id].角色.锦衣进阶.数量=0
--             end
--         else
--                        玩家数据[id].角色.锦衣进阶.数量=0
--                        玩家数据[id].角色.锦衣进阶.等级=0
--                        玩家数据[id].角色.锦衣进阶.技能="无"
--                        玩家数据[id].角色.锦衣进阶.开启=false
--                       常规提示(id,"#Y/锦衣套装已失效")
--         end
--     end
--     玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.锦衣[数据.道具]
--     玩家数据[id].角色.锦衣[数据.道具]=nil
--     self:刷新道具行囊(id,数据.类型)
--     发送数据(玩家数据[id].连接id,3703,玩家数据[id].角色:取锦衣数据())
--     发送数据(玩家数据[id].连接id,3704)
--     地图处理类:更新锦衣(id,nil,数据.道具)
--     发送数据(玩家数据[id].连接id,12)
--     玩家数据[id].角色:刷新信息()
-- end
function 道具处理类:卸下锦衣(连接id,id,数据)
    local 道具id1=玩家数据[id].角色.锦衣[数据.道具]

    if 道具id1 == nil then
        常规提示(id,"#Y你没有穿戴这个位置的锦衣")
        return
    end

    if self.数据[道具id1] == nil then
        常规提示(id,"#Y锦衣数据异常")
        return
    end

    -- 获取锦衣背包格子
    local 锦衣背包格子 = 玩家数据[id].角色:取锦衣格子()
    if 锦衣背包格子 == 0 then
        常规提示(id,"#Y锦衣背包已满，无法卸下")
        return
    end

    -- 处理锦衣进阶效果
    if self.数据[道具id1].锦衣进阶~=nil then
        if 玩家数据[id].角色.锦衣进阶.技能==self.数据[道具id1].锦衣进阶.技能 then
            if self.数据[道具id1].锦衣升级 then
                玩家数据[id].角色.锦衣进阶.等级=玩家数据[id].角色.锦衣进阶.等级-self.数据[道具id1].锦衣升级
                if 玩家数据[id].角色.锦衣进阶.等级<0 then
                    玩家数据[id].角色.锦衣进阶.等级=0
                end
            end
            玩家数据[id].角色.锦衣进阶.数量=玩家数据[id].角色.锦衣进阶.数量-1
            常规提示(id,"#Y当前锦衣套装#R"..self.数据[道具id1].锦衣进阶.技能.."#Y已佩戴#P"..玩家数据[id].角色.锦衣进阶.数量.."件，#G效果已消失")
            玩家数据[id].角色.锦衣进阶.开启=false
            if 玩家数据[id].角色.锦衣进阶.数量<0 then
                玩家数据[id].角色.锦衣进阶.数量=0
            end
        else
            玩家数据[id].角色.锦衣进阶.数量=0
            玩家数据[id].角色.锦衣进阶.等级=0
            玩家数据[id].角色.锦衣进阶.技能="无"
            玩家数据[id].角色.锦衣进阶.开启=false
            常规提示(id,"#Y锦衣套装已失效")
        end
    end
    玩家数据[id].角色.锦衣背包[锦衣背包格子] = 道具id1
    玩家数据[id].角色.锦衣[数据.道具] = nil
    self:索要锦衣(连接id,id)
    发送数据(玩家数据[id].连接id,3703,玩家数据[id].角色:取锦衣数据())
    发送数据(玩家数据[id].连接id,3704)

    地图处理类:更新锦衣(id,nil,数据.道具)
    发送数据(玩家数据[id].连接id,12)
    玩家数据[id].角色:刷新信息()

end

function 道具处理类:卸下装备(连接id,id,数据)
    -- local 道具格子=玩家数据[id].角色:取道具格子(数据.类型)
    if 数据.类型 == "任务包裹" then return 常规提示(id,"#Y这件物品不能移动到任务栏") end
    local 道具格子=玩家数据[id].角色:取道具格子1(数据.类型)
    if 道具格子==0 then
        常规提示(id,"您的道具栏物品已经满啦")
        return 0
    end
    if 数据.灵饰 then
        self:卸下灵饰(连接id,id,道具id,道具格子,数据)
        return
    end
    -- if 数据.锦衣 then
    --  self:卸下锦衣(连接id,id,道具id,道具格子,数据)
    --  return
    -- end
            if 数据.锦衣 then
                self:卸下锦衣(连接id,id,数据)
        return
    end

    -- table.print(数据)
    local 道具id=玩家数据[id].角色.装备[数据.道具]
    玩家数据[id].角色:卸下装备(self.数据[道具id],self.数据[道具id].分类)
    玩家数据[id].角色.装备[数据.道具]=nil
    玩家数据[id].角色[数据.类型][道具格子]=道具id
    玩家数据[id].角色:刷新信息()
    self:刷新道具行囊(id,数据.类型)
    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
    if 数据.道具==3 then
        发送数据(玩家数据[id].连接id,3505)
        地图处理类:更新武器(id)
    elseif 数据.道具 == 4 and 玩家数据[id].角色.模型 == "影精灵" and self.数据[道具id].子类 == 911 then
               发送数据(玩家数据[id].连接id, 3505)
    end
    发送数据(玩家数据[id].连接id,12)
end


function 道具处理类:佩戴灵饰(连接id,id,道具id,数据)
    local 物品=取物品数据(self.数据[道具id].名称)
    local 级别 = tonumber(物品[5])
    if 级别 > 玩家数据[id].角色.等级 then
        if self.数据[道具id].特效 == "无级别限制" or (self.数据[道具id].特效 =="超级简易" and 级别 <= 玩家数据[id].角色.等级+15)  then
        else
            常规提示(id,"#Y你当前的等级不足以佩戴这样的灵饰")
            return
        end
    end
    if not self.数据[道具id].鉴定 then
        常规提示(id,"#Y没有鉴定的灵饰无法佩戴")
        return
    end
    if self.数据[道具id].专用 and self.数据[道具id].专用~=id then
        常规提示(id,"#Y这个灵饰id与你不匹配无法穿戴")
        return
    end
    if 玩家数据[id].角色.灵饰[self.数据[道具id].子类]==nil then
        玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
        玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
        玩家数据[id].角色[数据.类型][数据.道具]=nil
        玩家数据[id].角色:检测钟灵石(id)

    else
        local 道具id1=玩家数据[id].角色.灵饰[self.数据[道具id].子类]
        玩家数据[id].角色:卸下灵饰(self.数据[道具id1])
        玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
        玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
        玩家数据[id].角色[数据.类型][数据.道具]=道具id1
        玩家数据[id].角色:检测钟灵石(id)

    end
    self:刷新道具行囊(id,数据.类型)
    玩家数据[id].角色:刷新信息("33")
    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
    发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
    发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
    发送数据(玩家数据[id].连接id,12)
end

function 道具处理类:卸下灵饰(连接id,id,道具id,道具格子,数据)
    if self.数据[玩家数据[id].角色.灵饰[数据.道具]] == nil then
        常规提示(id,"你没有这样的灵饰")
        self:刷新道具行囊(id,数据.类型)
        发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
        发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
        return
    end
    玩家数据[id].角色:卸下灵饰(self.数据[玩家数据[id].角色.灵饰[数据.道具]])
    玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.灵饰[数据.道具]
    玩家数据[id].角色.灵饰[数据.道具]=nil
    self:刷新道具行囊(id,数据.类型)
    玩家数据[id].角色:刷新信息("33")
    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
    发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
    发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
    发送数据(玩家数据[id].连接id,12)
end



function 道具处理类:佩戴装备(连接id,id,数据)
    local 道具id=玩家数据[id].角色[数据.类型][数据.道具]
    if self.数据[道具id] == nil then
        return
    end
            if self.数据[道具id].自选 then
                发送数据(连接id,3539,{灵饰 = self.数据[道具id]})
                玩家数据[id].道具操作={类型=数据.类型,编号=数据.道具,id=道具id}
                玩家数据[id].最后操作="灵饰自选"
                return 0
            end

    if self.数据[道具id].总类 == 2 and self.数据[道具id].灵饰~=nil then
        self:佩戴灵饰(连接id,id,道具id,数据)
        return
    end
    if self.数据[道具id].总类 == 2 and self.数据[道具id].分类 >=14 and self.数据[道具id].分类 <=19 then
        self:佩戴锦衣(连接id,id,道具id,数据)
        return
    end
    local 装备条件=self:可装备(self.数据[道具id],self.数据[道具id].分类,数据.角色,id)
    if 装备条件~=true then
        发送数据(连接id,7,装备条件)
        return 0
    else
        if 玩家数据[id].角色.装备[self.数据[道具id].分类]~=nil then --检查是否有装备已经佩戴
            local 道具id1=玩家数据[id].角色.装备[self.数据[道具id].分类]
            玩家数据[id].角色:卸下装备(self.数据[道具id1],self.数据[道具id1].分类)
            玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
            玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)
            玩家数据[id].角色[数据.类型][数据.道具]=道具id1
            --发送数据(id,5,玩家数据[id].角色:取总数据())
        else
            玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
            玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)
            玩家数据[id].角色[数据.类型][数据.道具]=nil
            --发送数据(id,5,玩家数据[id].角色:取总数据())
        end
        玩家数据[id].角色:检查临时属性()
    end
    self:刷新道具行囊(id,数据.类型)
    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
    if self.数据[道具id].分类==3 then
        发送数据(玩家数据[id].连接id,3504)
        地图处理类:更新武器(id,self.数据[玩家数据[id].角色.装备[3]])
    elseif self.数据[道具id].分类 == 4 and 玩家数据[id].角色.装备[4] ~= nil and self.数据[道具id].子类 == 911 and 玩家数据[id].角色.模型 == "影精灵" then
        发送数据(玩家数据[id].连接id, 3504)
        地图处理类:更新武器(id,self.数据[玩家数据[id].角色.装备[3]],self.数据[玩家数据[id].角色.装备[4]])
    end
    发送数据(玩家数据[id].连接id,12   )
            发送数据(玩家数据[id].连接id,12.1)

end

function 道具处理类:坐骑装饰佩戴(id,加血对象,道具格子,包裹类型)
    local 道具id=玩家数据[id].角色[包裹类型][道具格子]
    if 玩家数据[id].角色.坐骑列表[加血对象].模型 ~= self.数据[道具id].装备坐骑 then
        return 常规提示(id,"#Y这个坐骑无法装备这个装饰")
    end
    if 玩家数据[id].角色.坐骑列表[加血对象].饰品 == nil then
        玩家数据[id].角色.坐骑列表[加血对象].饰品 = self.数据[道具id]
        self.数据[道具id] = nil
    else
        local 临时道具 = 玩家数据[id].角色.坐骑列表[加血对象].饰品
        玩家数据[id].角色.坐骑列表[加血对象].饰品 = self.数据[道具id]
        self.数据[道具id] = 临时道具
    end
    发送数据(玩家数据[id].连接id,62,{编号=加血对象,坐骑数据=玩家数据[id].角色.坐骑列表[加血对象]})
    self:刷新道具行囊(id,包裹类型)
    发送数据(玩家数据[id].连接id,28)
    玩家数据[id].角色.坐骑=table.loadstring(table.tostring(玩家数据[id].角色.坐骑列表[加血对象]))
    发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.坐骑)
    地图处理类:更新坐骑(id,玩家数据[id].角色.坐骑)
end

function 道具处理类:坐骑装饰卸下(连接id,id,数据)
    local 角色=数据.角色
    local 类型=数据.类型
    local 道具=数据.道具
    --local 道具id=玩家数据[id].角色[类型][道具]
    local bb=数据.编号
    local 道具格子=玩家数据[id].角色:取道具格子()
    if 玩家数据[id].角色.坐骑列表[bb] == nil or 玩家数据[id].角色.坐骑列表[bb].饰品 == nil then
        return
    end
    if 道具格子==0 then
        常规提示(id,"您的道具栏物品已经满啦")
        return
    else
        local 临时id=self:取新编号()
        self.数据[临时id]=玩家数据[id].角色.坐骑列表[bb].饰品
        玩家数据[id].角色.道具[道具格子]=临时id
        玩家数据[id].角色.坐骑列表[bb].饰品 = nil
        发送数据(玩家数据[id].连接id,62,{编号=bb,坐骑数据=玩家数据[id].角色.坐骑列表[bb]})
        self:刷新道具行囊(id,数据.类型)
        发送数据(连接id,28)
        玩家数据[id].角色.坐骑=table.loadstring(table.tostring(玩家数据[id].角色.坐骑列表[bb]))
        发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.坐骑)
        地图处理类:更新坐骑(id,玩家数据[id].角色.坐骑)
    end
end
function 道具处理类:可装备(i1,i2,类型,id)
    if i2 > 6 and 类型 == "主角" then
        return "#Y/该装备与你的种族不符"
    elseif i2 < 6 and 类型 == "召唤兽" then
        return "#Y/召唤兽不能穿戴该装备"
    end

    if i1.总类 ~= 2 then
        return "#Y/这个物品不可以装备"
    end

    if not i1.鉴定 then
        return "#Y/该装备未鉴定，无法佩戴"
    end

    if i1.专用~=nil and i1.专用~=id then
        return "#Y/你无法佩戴他人的专用装备"
    end

    if type( i1.等级) ~= "number" then
        return "#Y/该装备的等级数据错误请联系管理员"
    end

    if i1.耐久~=nil and i1.耐久<=0 then
        return 常规提示(id,"#Y/该装备耐久不足，无法穿戴")
    end

    if i1.修理失败~=nil and i1.修理失败==3 and i1.耐久<=0 then
        return 常规提示(id,"#Y/该装备因修理失败过度，而无法使用！")
    end

    if i1 ~= nil and i1.分类 == i2 then
        if i2 == 1 or i2 == 4 then -- 头盔 衣服
            if i2 == 4 then -- 衣服
                -- 九黎城专属副武器（子类911）检查
                if i1.子类 == 911 then
                    if 玩家数据[id].角色.门派 ~= "九黎城" or 玩家数据[id].角色.模型 ~= "影精灵" then
                        return "#Y/影精灵专属装备,其他角色不可使用。"
                    end
                    -- 如果已经有主武器，则检查是否为910
                    if 玩家数据[id].角色.装备[3] ~= nil then
                        local 主武器 = 玩家数据[id].道具.数据[玩家数据[id].角色.装备[3]]
                        if 主武器.子类 ~= 910 then
                            return "#Y/九黎城副武器只能与主武器910共同装备。"
                        end
                    end
                    -- 如果没有主武器，允许穿戴
                else
                    -- 普通衣服，检查性别限制
                    if i1.性别限制 ~= 0 and i1.性别限制 ~= 玩家数据[id].角色.性别 then
                        return "#Y/该装备您无法使用呀"
                    end
                end

                return self:检查装备等级(i1, 玩家数据[id].角色.等级)

            else -- 头盔
                if i1.性别限制 ~= 0 and i1.性别限制 ~= 玩家数据[id].角色.性别 then
                    return "#Y/该装备您无法使用呀"
                end
                return self:检查装备等级(i1, 玩家数据[id].角色.等级)
            end

        elseif i2 == 2 or i2 == 5 or i2 == 6 then -- 项链，腰带，鞋子
            return self:检查装备等级(i1, 玩家数据[id].角色.等级)

        elseif i2 == 3 then -- 武器
            local 是九黎城影精灵 = (玩家数据[id].角色.门派 == "九黎城" and 玩家数据[id].角色.模型 == "影精灵")

            if i1.子类 == 910 then
                -- 九黎城主武器
                if not 是九黎城影精灵 then
                    return "#Y/影精灵专属装备,其他角色不可使用。"
                end
                -- 如果已经有副武器，则检查是否为911
                if 玩家数据[id].角色.装备[4] ~= nil then
                    local 副武器 = 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]]
                    if 副武器.子类 == 911 then
                        -- 副武器是911，允许穿戴主武器910
                        -- 不添加限制
                    end
                end
                -- 如果没有副武器，也允许穿戴

                return self:检查装备等级(i1, 玩家数据[id].角色.等级)
            else
                -- 非九黎城主武器
                if 是九黎城影精灵 then
                    -- 九黎城影精灵装备非910武器
                    -- 检查当前衣服是否为911
                    if 玩家数据[id].角色.装备[4] ~= nil then
                        local 衣服 = 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]]
                        -- 如果当前衣服是911，就不能佩戴除子类910以外的武器
                        if 衣服.子类 == 911 then
                            return "#Y/当前已穿戴九黎城副武器，只能装备九黎城主武器(子类910)"
                        end
                    end
                    -- 如果衣服不是911，可以穿戴任何武器
                end

                -- 角色限制检查（适用于所有角色）
                if i1.角色限制 ~= 0 then
                    local 可装备 = false
                    for _, 角色模型 in ipairs(i1.角色限制) do
                        if 角色模型 == 玩家数据[id].角色.模型 then
                            可装备 = true
                            break
                        end
                    end
                    if not 可装备 then
                        return "#Y/该装备您无法使用呀"
                    end
                end

                return self:检查装备等级(i1, 玩家数据[id].角色.等级)
            end
        end
    end

    return false
end
function 道具处理类:检查装备等级(装备, 玩家等级)
    if 装备.等级 == 0 or 玩家等级 >= 装备.等级 then
        return true
    end

    if 装备.特效 then
        for i=1,#装备.特效 do
            if 装备.特效[i] == "无级别限制" then
                return true
            elseif 装备.特效[i] == "简易" and 玩家等级+5 >= 装备.等级 then
                return true
            end
        end
    end

    return "#Y/你的等级不够呀"
end
-- function 道具处理类:可装备(i1,i2,类型,id)
--     if i2 > 6 and 类型 == "主角" then
--         return "#Y/该装备与你的种族不符"
--     elseif i2 < 6 and 类型 == "召唤兽" then
--         return "#Y/召唤兽不能穿戴该装备"
--     end
--     if i1.总类 ~= 2 then
--         return "#Y/这个物品不可以装备"
--     end
--     if not i1.鉴定 then
--         return "#Y/该装备未鉴定，无法佩戴"
--     end
--     if i1.专用~=nil and i1.专用~=id then
--         return "#Y/你无法佩戴他人的专用装备"
--     end
--     -- if i1.限时 ~= nil and i1.限时 < os.time() then
--     --  return "#Y/该装备的使用时限到了无法在使用了"
--     -- end
--     if type( i1.等级) ~=  "number"  then
--         return "#Y/该装备的等级数据错误请联系管理员"
--     end
--     if i1.耐久~=nil and i1.耐久<=0  then
--         return 常规提示(id,"#Y/该装备耐久不足，无法穿戴")
--     end
--     if i1.修理失败~=nil and i1.修理失败==3 and i1.耐久<=0 then
--         return 常规提示(id,"#Y/该装备因修理失败过度，而无法使用！")
--     end
--     if i1 ~= nil and i1.分类 == i2 then
--         if i2 == 1 or i2 == 4 then --头盔 衣服
--             if i2 == 4 then
--             if i1.子类 == 911 then
--                  if 玩家数据[id].角色.门派 == "九黎城"  and 玩家数据[id].角色.模型 =="影精灵" then
--                     if 玩家数据[id].角色.装备[3] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[3]].子类 ~= 910 then
--                           return "#Y/该武器无法与当前携带的副武器共同装备。"
--                         end
--                 ---------------------------------------------------------------------------------C改
--                 if i1.等级 == 0 or 玩家数据[id].角色.等级 >= i1.等级 then
--                     return true
--                 end
--                 if i1.特效 then
--                     for i=1,#i1.特效 do
--                         if i1.特效[i]=="无级别限制" then
--                             return true
--                         elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.等级 then
--                             return true
--                         end
--                     end
--                 end
--                 return "#Y/你的等级不够呀"
-- ---------------------------------------------------------------------------------C改
--                     -- return true
--                   else
--                     return "#Y/影精灵专属装备,其他角色不可使用。"

--                   end
--                 else
--                     -- if 玩家数据[id].角色.装备[3] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[3]].子类 == 910 then
--                     --   return "#Y/当前装备与当前武器冲突,请装备副武器。"
--                     -- end
--                 end
--             end
--             if i1.性别限制 ~= 0 and i1.性别限制 == 玩家数据[id].角色.性别 then
--                 if i1.等级 == 0 or 玩家数据[id].角色.等级 >= i1.等级 then
--                     return true
--                 end
--                 if i1.特效 then
--                     for i=1,#i1.特效 do
--                         if i1.特效[i]=="无级别限制" then
--                             return true
--                         elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.等级 then
--                             return true
--                         end
--                     end
--                 end
--                 return "#Y/你的等级不够呀"
--             else
--                 return "#Y/该装备您无法使用呀"
--             end
--         elseif i2 == 2 or i2 == 5 or i2 == 6 then --项链，腰带，鞋子
--             if i1.等级 == 0 or 玩家数据[id].角色.等级 >= i1.等级 then
--                 return true
--             end
--             if i1.特效 then
--                 for i=1,#i1.特效 do
--                     if i1.特效[i]=="无级别限制" then
--                         return true
--                     elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.等级 then
--                         return true
--                     end
--                 end
--             end
--             return "#Y/你的等级不够呀"
--         elseif i2 == 3 then --武器
--             if i1.子类 == 910 then
--               if 玩家数据[id].角色.门派 == "九黎城" and  玩家数据[id].角色.模型 == '影精灵' then
--                 -- if 玩家数据[id].角色.装备[4] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]].子类 ~= 911 then
--                 --   return "#Y/请先脱下当前穿戴防具。"
--                 -- end

--                     ---------------------------------------------------------------------------------C改
--                 if i1.等级 == 0 or 玩家数据[id].角色.等级 >= i1.等级 then
--                     return true
--                 end
--                 if i1.特效 then
--                     for i=1,#i1.特效 do
--                         if i1.特效[i]=="无级别限制" then
--                             return true
--                         elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.等级 then
--                             return true
--                         end
--                     end
--                 end
--                 return "#Y/你的等级不够呀"
-- ---------------------------------------------------------------------------------C改
--               end
--             end
--             if i1.子类 ~= 910 then
--               if 玩家数据[id].角色.装备[4] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]].子类 == 911 then
--                 return "#Y/该武器无法与当前携带的主武器共同装备。"
--               end
--             end
--             if i1.角色限制 ~= 0 and (i1.角色限制[1] == 玩家数据[id].角色.模型 or i1.角色限制[2] == 玩家数据[id].角色.模型 or i1.角色限制[3] == 玩家数据[id].角色.模型 or i1.角色限制[4] == 玩家数据[id].角色.模型) then
--                 if i1.等级 == 0 or 玩家数据[id].角色.等级 >= i1.等级 then
--                     return true
--                 end
--                 if i1.特效 then
--                     for i=1,#i1.特效 do
--                         if i1.特效[i]=="无级别限制" then
--                             return true
--                         elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.等级 then
--                             return true
--                         end
--                     end
--                 end
--                 return "#Y/你的等级不够呀"
--             else
--                 return "#Y/该装备您无法使用呀"
--             end
--         end
--     end
--     return false
-- end


function 道具处理类:添加阵营道具(id,类型,数量)
    local 物品1={"海妖的贡品","海妖精气","海妖精魄","海妖灵兵","海妖王的灵元"}
    if 玩家数据[id].角色.主人id then
        local 主人id =    玩家数据[id].角色.主人id
        if 玩家数据[主人id].双龙之战 and 玩家数据[主人id].双龙之战.数据 and 玩家数据[主人id].双龙之战.数据.活动物品  and 玩家数据[主人id].双龙之战.数据.活动物品.物品 and 玩家数据[主人id].双龙之战.数据.活动物品.物品[类型] then
            玩家数据[主人id].双龙之战.数据.活动物品.物品[类型]=玩家数据[主人id].双龙之战.数据.活动物品.物品[类型]+数量
            常规提示(主人id,"#P/《双龙之战》#Y/你获得了"..数量.."个#R/"..物品1[类型].."#Y/已存入阵营背包")
        end
    else
        if 玩家数据[id].双龙之战 and 玩家数据[id].双龙之战.数据 and 玩家数据[id].双龙之战.数据.活动物品  and 玩家数据[id].双龙之战.数据.活动物品.物品 and 玩家数据[id].双龙之战.数据.活动物品.物品[类型] then
            玩家数据[id].双龙之战.数据.活动物品.物品[类型]=玩家数据[id].双龙之战.数据.活动物品.物品[类型]+数量
            常规提示(id,"#P/《双龙之战》#Y/你获得了"..数量.."个#R/"..物品1[类型].."#Y/已存入阵营背包")
        end
    end
end

function 道具处理类:添加阵营礼物(id,类型,数量)
    local 礼物1={"牡丹花","桃运花","紫兰花","百合花","玫瑰花"}
    if 玩家数据[id].角色.主人id then
        local 主人id =    玩家数据[id].角色.主人id
        if 玩家数据[主人id].双龙之战 and 玩家数据[主人id].双龙之战.数据 and 玩家数据[主人id].双龙之战.数据.活动物品  and 玩家数据[主人id].双龙之战.数据.活动物品.礼物 and 玩家数据[主人id].双龙之战.数据.活动物品.礼物[类型] then
            玩家数据[主人id].双龙之战.数据.活动物品.礼物[类型]=玩家数据[主人id].双龙之战.数据.活动物品.礼物[类型]+数量
            常规提示(主人id,"#P/《双龙之战》#Y/你获得了"..数量.."个#R/"..礼物1[类型].."#Y/已存入阵营背包")
        end
    else
        if 玩家数据[id].双龙之战 and 玩家数据[id].双龙之战.数据 and 玩家数据[id].双龙之战.数据.活动物品  and 玩家数据[id].双龙之战.数据.活动物品.礼物 and 玩家数据[id].双龙之战.数据.活动物品.礼物[类型] then
            玩家数据[id].双龙之战.数据.活动物品.礼物[类型]=玩家数据[id].双龙之战.数据.活动物品.礼物[类型]+数量
            常规提示(id,"#P/《双龙之战》#Y/你获得了"..数量.."个#R/"..礼物1[类型].."#Y/已存入阵营背包")
        end
    end
end


function 道具处理类:取可叠加道具(mc,sl)
    for n, v in pairs(self.数据) do
        -- if self.数据[n].名称==mc and self.数据[n].数量1 and self.数据[n].数量 + tonumber(sl) <= 取物品叠加上限(mc) then
        if self.数据[n].名称==mc and self.数据[n].可叠加 and self.数据[n].数量 + tonumber(sl) <= 99 then
            return n
        end
    end
    return 0
end

function 道具处理类:判定装备条件()
    for n, v in pairs(玩家数据[self.玩家id].角色.装备) do
        local 格子 = 玩家数据[self.玩家id].角色.装备[n]
        if self.数据[格子] ~= nil then
            local 装备条件=self:可装备(self.数据[格子],self.数据[格子].分类,"主角",self.玩家id)
            if 装备条件 ~= true then
                常规提示(self.玩家id,"#Y你的等级不够，不能装备"..self.数据[格子].名称)
                --玩家数据[self.玩家id].角色:清除装备属性(self.数据[格子],self.数据[格子].分类,"0")
            end
        end
    end
end

function 道具处理类:更新()
    -- if 玩家数据[self.玩家id].连接id == "假人" then  return  end
    --if 玩家数据[self.玩家id].连接id ~= nil  then  return  end
    local 更新属性 = false
    for n, v in pairs(玩家数据[self.玩家id].角色.装备) do --这个是穿戴的装备
        local 格子 = 玩家数据[self.玩家id].角色.装备[n]
        if self.数据 and self.数据[格子] ~= nil then
            if self.数据[格子].临时附魔 ~= nil  then
                for k,v in pairs(self.数据[格子].临时附魔) do
                    if v.数值 and v.时间 < os.time() then
                        玩家数据[self.玩家id].角色:清除装备附魔属性(self.数据[格子],self.数据[格子].分类,k,v.数值)
                        self.数据[格子].临时附魔[k] = nil
                        常规提示(self.玩家id,"#Y你装备上的附魔特效消失了！")
                    end
                end
            end
        end
    end
    if 更新属性 then
        发送数据(玩家数据[self.玩家id].连接id,3503,玩家数据[self.玩家id].角色:取装备数据())
        发送数据(玩家数据[self.玩家id].连接id,31,玩家数据[self.玩家id].角色:取总数据1())
    end
end

function 道具处理类:丢弃道具(连接id,id,数据)
    local 类型=数据.类型
    local wpid=数据.物品
    if not 类型 or not wpid then
        return
    end
    if 类型 ~= "行囊" and 类型 ~= "道具" then
        return
    end
    local 名称 = self.数据[玩家数据[id].角色[类型][wpid]].名称
    if not 玩家数据[id].角色[类型][wpid] or 名称==nil then
        玩家数据[id].角色[类型][wpid]=nil
        return
    end
    ---------------佬伍修改（增加种族秘境时空之钥）
        if self.数据[玩家数据[id].角色[类型][wpid]].名称=="人族时空之钥" or self.数据[玩家数据[id].角色[类型][wpid]].名称=="魔族时空之钥" or self.数据[玩家数据[id].角色[类型][wpid]].名称=="仙族时空之钥" then
      常规提示(id,"#Y该物品无法丢弃")
      self:刷新道具行囊(id,类型)
      return
    end
        ---------------佬伍修改（增加种族秘境时空之钥）
    玩家数据[id].角色:日志记录("丢弃道具["..self.数据[玩家数据[id].角色[类型][wpid]].名称.."],道具识别码为"..(self.数据[玩家数据[id].角色[类型][wpid]].识别码 or id), "丢弃道具")
    self.数据[玩家数据[id].角色[类型][wpid]]=nil
    玩家数据[id].角色[数据.类型][wpid]=nil
    self:刷新道具行囊(id,类型)
end

function 道具处理类:丢弃灵宝(连接id,id,数据)
    local 类型="灵宝"
    local wpid=数据.物品
    if not 类型 or not wpid then
        return
    end
    local 名称 = self.数据[玩家数据[id].角色[类型][wpid]].名称
    if not 玩家数据[id].角色[类型][wpid] or 名称==nil then
        玩家数据[id].角色[类型][wpid]=nil
        return
    end
    -- if self.数据[玩家数据[id].角色[类型][wpid]].识别码==nil then
    --  self.数据[玩家数据[id].角色[类型][wpid]].识别码="无法识别"
    -- end
    玩家数据[id].角色:日志记录("丢弃道具["..self.数据[玩家数据[id].角色[类型][wpid]].名称.."],道具识别码为"..(self.数据[玩家数据[id].角色[类型][wpid]].识别码 or id), "丢弃道具")
    self.数据[玩家数据[id].角色[类型][wpid]]=nil
    玩家数据[id].角色[类型][wpid]=nil
    self:刷新道具行囊(id,类型)
end
function 道具处理类:道具转移(连接id,id,数据)
    local 临时格子= 0
    local 允许放置=true
    if not self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]] then
        错误日志[#错误日志+1]={记录="玩家id"..id.."。错误方式：道具转移。错误数据："..table.tostring(数据),时间=os.time()}
        return
    end
    local 道具名称 = self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].名称
    -- if 数据.抓取类型 ~= "行囊" and 数据.抓取类型 ~= "道具" and 数据.抓取类型 ~= "任务包裹" and 数据.抓取类型 ~= "法宝"  then
    --     return
    -- end
    if 数据.放置类型 == "道具" then
        临时格子=玩家数据[id].角色:取道具格子()
        if 临时格子 == 0 then  常规提示(id,"#Y道具背包已满") end
    elseif 数据.放置类型 == "法宝" then
        临时格子=玩家数据[id].角色:取法宝格子()
        if 临时格子 == 0 then  常规提示(id,"#Y法宝背包已满") end
        --if self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].总类==1000 and self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].分类~=1 then return  常规提示(id,"#Y只有一级法宝才可以放入法宝栏") end
    elseif 数据.放置类型 == "行囊" then
        临时格子=玩家数据[id].角色:取行囊格子()
        if 临时格子 == 0 then  常规提示(id,"#Y行囊背包已满") end
        if  self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].总类 == 150 then
            允许放置 = false
            常规提示(id,"#Y任务物品不能移动到这里")
        end
    elseif 数据.放置类型 == "锦衣背包" then
        临时格子=玩家数据[id].角色:取锦衣格子()
        if 临时格子 == 0 then  常规提示(id,"#Y锦衣背包已满") end
        if  self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].分类 >= 14 and self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].分类 <= 19 and self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].总类~=2 then
            允许放置 = false
            常规提示(id,"#Y这件物品不能移动到锦衣背包")
        end

    elseif 数据.放置类型 == "任务包裹" then
        临时格子=玩家数据[id].角色:取任务格子()
        if 临时格子 == 0 then  常规提示(id,"#Y任务背包已满") end
        if  self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].总类 ~= 150 then
            允许放置 = false
            常规提示(id,"#Y这件物品不能移动到任务栏")
        end
    end
    if 临时格子 ~= 0 and 允许放置 then
        玩家数据[id].角色[数据.放置类型][临时格子] = 玩家数据[id].角色[数据.抓取类型][数据.序列]
        玩家数据[id].角色[数据.抓取类型][数据.序列]=nil
        if 数据.放置类型 == "锦衣背包" then
            常规提示(id,"#Y你将#G"..道具名称.."#Y放进了锦衣包裹")
        end
    end
    发送数据(连接id,3699)
    -- if 数据.抓取类型 == "锦衣背包" or 数据.放置类型 == "锦衣背包" then
    --      self:索要锦衣(连接id,id)
    -- end
    if 数据.抓取类型 == "锦衣背包" or 数据.放置类型 == "背包" then
         self:索要锦衣(连接id,id)
    end
end

-- function 道具处理类:道具格子互换(连接id,id,数据)
--     local 道具id = 玩家数据[id].角色[数据.抓取类型][数据.抓取id]
--     if not self.数据[道具id] then
--         常规提示(id,数据.抓取类型 .."格子并无道具！")
--         return
--     end
--     if 数据.放置类型==数据.抓取类型 and 数据.放置id==数据.抓取id and 数据.放置类型~="锦衣背包" then
--         发送数据(连接id,3699)
--         return
--     elseif 数据.放置类型=="锦衣背包" and 数据.抓取类型=="锦衣背包" and 数据.放置类型==数据.抓取类型 and 数据.放置id==数据.抓取id then
--         self:索要锦衣(连接id,id)
--         return
--     end
--     if 数据.放置类型 ~= "行囊" and 数据.放置类型 ~= "道具" and 数据.放置类型 ~= "任务包裹" and 数据.放置类型 ~= "法宝" then
--         return
--     end
--     if 数据.抓取类型 ~= "行囊" and 数据.抓取类型 ~= "道具" and 数据.抓取类型 ~= "任务包裹" and 数据.抓取类型 ~= "法宝" then
--         return
--     end
--     if 数据.放置类型~=数据.抓取类型 and self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].总类==1000 then
--         if self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].分类~=1 then
--             常规提示(id,"#Y只有一级法宝才可以移动")
--             return
--         end
--     end
--     if 数据.放置类型=="法宝" and self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].总类~=1000 then
--         常规提示(id,"#Y法宝栏只可以放入法宝哟")
--         return
--     end
--     if 玩家数据[id].角色[数据.放置类型][数据.放置id]==nil then --没有道具
--         玩家数据[id].角色[数据.放置类型][数据.放置id]=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
--         玩家数据[id].角色[数据.抓取类型][数据.抓取id]=nil
--     else
--         local 放置id=玩家数据[id].角色[数据.放置类型][数据.放置id]
--         self.允许互换=true
--         local 放置id=玩家数据[id].角色[数据.放置类型][数据.放置id]
--         local 抓取id=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
--         if self.数据[放置id].名称==self.数据[抓取id].名称 and 取可否叠加(self.数据[放置id],self.数据[抓取id],true) and self.数据[抓取id].数量~=nil and self.数据[放置id].数量~=nil then
--             if self.数据[抓取id] and self.数据[放置id] and self.数据[抓取id].数量<99 and self.数据[放置id].数量<99 then
--                 if self.数据[抓取id].阶品~= nil and self.数据[放置id].阶品~=nil and self.数据[抓取id].阶品~=self.数据[放置id].阶品 then
--                     常规提示(id,"#Y不同阶品的物品，无法叠加")
--                     发送数据(连接id,3699)
--                     道具刷新(id)
--                     return
--                 elseif self.数据[抓取id].灵气~= nil and self.数据[放置id].灵气~=nil and self.数据[抓取id].灵气~=self.数据[放置id].灵气 then --如意丹等
--                     常规提示(id,"#Y不同灵气的物品，无法叠加")
--                     发送数据(连接id,3699)
--                     道具刷新(id)
--                     return
--                 elseif self.数据[抓取id].等级~= nil and self.数据[放置id].等级~=nil and self.数据[抓取id].等级~=self.数据[放置id].等级 and self.数据[抓取id].名称=="钨金" and self.数据[放置id].名称=="钨金" then
--                     常规提示(id,"#Y不同等级的物品，无法叠加")
--                     发送数据(连接id,3699)
--                     道具刷新(id)
--                     return
--                 end
--                 if self.数据[抓取id].数量+self.数据[放置id].数量<=999 then
--                     self.数据[放置id].数量=self.数据[放置id].数量+self.数据[抓取id].数量
--                     self.数据[抓取id]=nil
--                     玩家数据[id].角色[数据.抓取类型][数据.抓取id]=nil
--                     self.允许互换=false
--                 else
--                     local 临时数量=self.数据[抓取id].数量+self.数据[放置id].数量
--                     local 临时数量1=临时数量-99
--                     self.数据[放置id].数量=99
--                     self.数据[抓取id].数量=临时数量1
--                     self.允许互换=false
--                 end
--             end
--         end
--         if self.允许互换 then
--             玩家数据[id].角色[数据.放置类型][数据.放置id]=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
--             玩家数据[id].角色[数据.抓取类型][数据.抓取id]=放置id
--         end
--     end
--     if 数据.放置类型=="锦衣背包" and 数据.抓取类型=="锦衣背包" then
--         self:索要锦衣(连接id,id)
--         end

--     --发送数据(连接id,3699)
--     self:刷新道具行囊(id,数据.放置类型)
-- end
function 道具处理类:道具格子互换(连接id,id,数据)
    local 道具id = 玩家数据[id].角色[数据.抓取类型][数据.抓取id]
    if not self.数据[道具id] then
        常规提示(id,数据.抓取类型 .."格子并无道具！")
        return
    end
    if 数据.放置类型 ~= "行囊" and 数据.放置类型 ~= "道具" and 数据.放置类型 ~= "任务包裹" and 数据.放置类型 ~= "法宝" and 数据.放置类型 ~= "锦衣背包" then
        return
    end
    if 数据.抓取类型 ~= "行囊" and 数据.抓取类型 ~= "道具" and 数据.抓取类型 ~= "任务包裹" and 数据.抓取类型 ~= "法宝" and 数据.抓取类型 ~= "锦衣背包" then
        return
    end
    if 数据.放置类型==数据.抓取类型 and 数据.放置id==数据.抓取id and 数据.放置类型~="锦衣背包" then
        发送数据(连接id,3699)
        return
    elseif 数据.放置类型=="锦衣背包" and 数据.抓取类型=="锦衣背包" and 数据.放置id==数据.抓取id then
        self:索要锦衣(连接id,id)
        return
    end

    if 数据.放置类型~=数据.抓取类型 and self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].总类==1000 then
        if self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].分类~=1 then
            常规提示(id,"#Y只有一级法宝才可以移动")
            return
        end
    end

    if 数据.放置类型=="法宝" and self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].总类~=1000 then
        常规提示(id,"#Y法宝栏只可以放入法宝哟")
        return
    end

    if 玩家数据[id].角色[数据.放置类型][数据.放置id]==nil then --没有道具
        玩家数据[id].角色[数据.放置类型][数据.放置id]=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
        玩家数据[id].角色[数据.抓取类型][数据.抓取id]=nil
    else
        local 放置id=玩家数据[id].角色[数据.放置类型][数据.放置id]
        self.允许互换=true
        local 放置id=玩家数据[id].角色[数据.放置类型][数据.放置id]
        local 抓取id=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
        if self.数据[放置id].名称==self.数据[抓取id].名称 and 取可否叠加(self.数据[放置id],self.数据[抓取id],true) and self.数据[抓取id].数量~=nil and self.数据[放置id].数量~=nil then
            if self.数据[抓取id] and self.数据[放置id] and self.数据[抓取id].数量<99 and self.数据[放置id].数量<99 then
                if self.数据[抓取id].阶品~= nil and self.数据[放置id].阶品~=nil and self.数据[抓取id].阶品~=self.数据[放置id].阶品 then
                    常规提示(id,"#Y不同阶品的物品，无法叠加")
                    发送数据(连接id,3699)
                    道具刷新(id)
                    return
                elseif self.数据[抓取id].灵气~= nil and self.数据[放置id].灵气~=nil and self.数据[抓取id].灵气~=self.数据[放置id].灵气 then --如意丹等
                    常规提示(id,"#Y不同灵气的物品，无法叠加")
                    发送数据(连接id,3699)
                    道具刷新(id)
                    return
                elseif self.数据[抓取id].等级~= nil and self.数据[放置id].等级~=nil and self.数据[抓取id].等级~=self.数据[放置id].等级 and self.数据[抓取id].名称=="钨金" and self.数据[放置id].名称=="钨金" then
                    常规提示(id,"#Y不同等级的物品，无法叠加")
                    发送数据(连接id,3699)
                    道具刷新(id)
                    return
                end
                if self.数据[抓取id].数量+self.数据[放置id].数量<=999 then
                    self.数据[放置id].数量=self.数据[放置id].数量+self.数据[抓取id].数量
                    self.数据[抓取id]=nil
                    玩家数据[id].角色[数据.抓取类型][数据.抓取id]=nil
                    self.允许互换=false
                else
                    local 临时数量=self.数据[抓取id].数量+self.数据[放置id].数量
                    local 临时数量1=临时数量-99
                    self.数据[放置id].数量=99
                    self.数据[抓取id].数量=临时数量1
                    self.允许互换=false
                end
            end
        end
        if self.允许互换 then
            玩家数据[id].角色[数据.放置类型][数据.放置id]=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
            玩家数据[id].角色[数据.抓取类型][数据.抓取id]=放置id
        end
    end
    if 数据.放置类型=="锦衣背包" and 数据.抓取类型=="锦衣背包" then
        self:索要锦衣(连接id,id)
    else
        发送数据(连接id,3699)
        self:刷新道具行囊(id,数据.放置类型)
    end
end



function 道具处理类:刷新道具行囊(id,类型)
    if 类型=="道具" then
        self:索要道具(玩家数据[id].连接id,id)
    elseif 类型=="法宝" then
        self:索要法宝(玩家数据[id].连接id,id)
    elseif 类型=="任务包裹" then
        self:索要任务(玩家数据[id].连接id,id)
    else
        self:索要行囊(玩家数据[id].连接id,id)
    end
end

function 道具处理类:索要灵犀玉(id)
    self.发送数据={道具={}}
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            if self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称=="灵犀玉" then
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
            end
        end
    end
    return self.发送数据
end

function 道具处理类:索要锦衣(连接id,id)
     self.发送数据={锦衣={}}
    for n=1,100 do
        if 玩家数据[id].角色.锦衣背包[n]~=nil then
            if self.数据[玩家数据[id].角色.锦衣背包[n]]==nil then
                玩家数据[id].角色.锦衣背包[n]=nil
            else
                self.发送数据.锦衣[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.锦衣背包[n]]))
            end
        end
    end
        发送数据(连接id,3527.1,self.发送数据)
end
function 道具处理类:索要锦衣1(连接id,id)
     self.发送数据={锦衣={}}
    for n=1,100 do
        if 玩家数据[id].角色.锦衣背包[n]~=nil then
            if self.数据[玩家数据[id].角色.锦衣背包[n]]==nil then
                玩家数据[id].角色.锦衣背包[n]=nil
            else
                self.发送数据.锦衣[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.锦衣背包[n]]))
            end
        end
    end
        -- 发送数据(连接id,3527.1,self.发送数据)
end
function 道具处理类:索要法宝(连接id,id)
    self.发送数据={法宝={},佩戴={},灵宝={},灵宝佩戴={},神器={}}
    for n=1,180 do
        if 玩家数据[id].角色.法宝[n]~=nil then
            if self.数据[玩家数据[id].角色.法宝[n]]==nil then
                玩家数据[id].角色.法宝[n]=nil
            else
                self.发送数据.法宝[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝[n]]))
            end
        end
    end
    for n=1,4 do
        if 玩家数据[id].角色.法宝佩戴[n]~=nil then
            self.发送数据.佩戴[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝佩戴[n]]))
        end
    end
    for n=1,20 do
        if 玩家数据[id].角色.灵宝[n]~=nil then
            if self.数据[玩家数据[id].角色.灵宝[n]]==nil then
                玩家数据[id].角色.灵宝[n]=nil
            else
                self.发送数据.灵宝[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.灵宝[n]]))
            end
        end
    end
    for n=1,2 do
        if 玩家数据[id].角色.灵宝佩戴[n]~=nil then
            self.发送数据.灵宝佩戴[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.灵宝佩戴[n]]))
        end
    end
    if 玩家数据[id].神器.数据.是否有 and 玩家数据[id].角色.门派~="无门派" then--and not 判断是否为空表(玩家数据[id].神器.数据) then
        self.发送数据.是否有神器=true
        self.发送数据.是否佩戴神器=玩家数据[id].神器.数据.是否佩戴神器
        self.发送数据.神器格子=玩家数据[id].神器.数据.格子
    end
    发送数据(连接id,3527,self.发送数据)
end

function 道具处理类:索要灵宝佩戴(id)
    self.发送数据={}
    for n=1,2 do
        if 玩家数据[id].角色.灵宝佩戴[n]~=nil then
            self.发送数据[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.灵宝佩戴[n]]))
        end
    end
    return self.发送数据
end

function 道具处理类:索要任务(连接id,id)
    self.发送数据={道具={}}
    for n=1,20 do
        if 玩家数据[id].角色.任务包裹[n]~=nil then
            if self.数据[玩家数据[id].角色.任务包裹[n]]==nil then
                玩家数据[id].角色.任务包裹[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.任务包裹[n]]))
            end
        end
    end
    发送数据(连接id,3531,self.发送数据)
end

function 道具处理类:索要任务1(连接id,id)
    self.发送数据={道具={}}
    for n=1,20 do
        if 玩家数据[id].角色.任务包裹[n]~=nil then
            if self.数据[玩家数据[id].角色.任务包裹[n]]==nil then
                玩家数据[id].角色.任务包裹[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.任务包裹[n]]))
            end
        end
    end
    发送数据(连接id,3531.1,self.发送数据)
end


function 道具处理类:索要道具(连接id,id)---开服测试
    self.发送数据={道具={}}
  if 采矿活动[id]==nil then
    采矿活动[id]={总计=0}
  end
  if  玩家数据[id].角色.采矿数据 == nil then
      玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
  end
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            if self.数据[玩家数据[id].角色.道具[n]]==nil then
                玩家数据[id].角色.道具[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
            end
        end
    end
    self.发送数据.银子=玩家数据[id].角色.银子
    self.发送数据.储备=玩家数据[id].角色.储备
    self.发送数据.存银=玩家数据[id].角色.存银
    self.发送数据.装备 = 玩家数据[id].角色:取装备数据()
    self.发送数据.灵饰 = 玩家数据[id].角色:取灵饰数据()
    self.发送数据.熟练度1=玩家数据[id].角色.采矿数据.熟练度
    self.发送数据.矿业声望=玩家数据[id].角色.采矿数据.矿业声望
    self.发送数据.次数1=采矿活动[id].总计
    发送数据(连接id,3501,self.发送数据)
end

function 道具处理类:索要道具1(id)
    self.发送数据={道具={}}
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            if self.数据[玩家数据[id].角色.道具[n]]==nil then
                玩家数据[id].角色.道具[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
            end
        end
    end
    self.发送数据.银子=玩家数据[id].角色.银子
    self.发送数据.储备=玩家数据[id].角色.储备
    self.发送数据.存银=玩家数据[id].角色.存银
    return self.发送数据
end

function 道具处理类:索要道具2(id)
    self.发送数据={道具={}}
    for n=1,80  do
        if 玩家数据[id].角色.道具[n]~=nil then
            if self.数据[玩家数据[id].角色.道具[n]]==nil then
                玩家数据[id].角色.道具[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
            end
        end
    end
    return self.发送数据
end

function 道具处理类:索要行囊2(id) --新增
    self.发送数据={道具={}}
    for n=1,80 do
        if 玩家数据[id].角色.行囊[n]~=nil then
            if self.数据[玩家数据[id].角色.行囊[n]]==nil then
                玩家数据[id].角色.行囊[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.行囊[n]]))
            end
        end
    end
    return self.发送数据
end

function 道具处理类:索要道具3(连接id,id)
    self.发送数据={道具={}}
    for n=1,80 do
        if 玩家数据[id].角色.道具[n]~=nil then
            if self.数据[玩家数据[id].角色.道具[n]]==nil then
                玩家数据[id].角色.道具[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
            end
        end
    end
    self.发送数据.银子=玩家数据[id].角色.银子
    self.发送数据.储备=玩家数据[id].角色.储备
    self.发送数据.存银=玩家数据[id].角色.存银
    发送数据(连接id,200,self.发送数据)
end

function 道具处理类:索要道具更新(id,类型)
    self.发送数据={道具={},类型=类型}
    for n=1,80 do
        if 玩家数据[id].角色[类型][n]~=nil then
            if self.数据[玩家数据[id].角色[类型][n]]==nil then
                玩家数据[id].角色[类型][n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色[类型][n]]))
            end
        end
    end
    self.发送数据.银子=玩家数据[id].角色.银子
    self.发送数据.储备=玩家数据[id].角色.储备
    self.发送数据.存银=玩家数据[id].角色.存银
    发送数据(玩家数据[id].连接id,3532,self.发送数据)
end

function 道具处理类:重置法宝回合(id)
    for n=1,20 do
        if 玩家数据[id].角色.法宝[n]~=nil then
            if self.数据[玩家数据[id].角色.法宝[n]]==nil then
                玩家数据[id].角色.法宝[n]=nil
            else
                self.数据[玩家数据[id].角色.法宝[n]].回合=nil
            end
        end
    end
end

function 道具处理类:索要法宝2(id,回合)
    self.发送数据={道具={}}
    for n=1,20 do
        if 玩家数据[id].角色.法宝[n]~=nil then
            if self.数据[玩家数据[id].角色.法宝[n]]==nil then
                玩家数据[id].角色.法宝[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝[n]]))
                if self.发送数据.道具[n].回合~=nil then
                    if self.发送数据.道具[n].回合<=回合 then
                        self.发送数据.道具[n].回合=nil
                    else
                        self.发送数据.道具[n].回合=self.发送数据.道具[n].回合-回合
                    end
                end
            end
        end
    end
    self.发送数据.银子=玩家数据[id].角色.银子
    self.发送数据.储备=玩家数据[id].角色.储备
    self.发送数据.存银=玩家数据[id].角色.存银
    return self.发送数据
end

function 道具处理类:索要法宝1(id,回合)
    self.发送数据={道具={}}
    for n=1,20 do
        if 玩家数据[id].角色.法宝[n]~=nil then
            if self.数据[玩家数据[id].角色.法宝[n]]==nil then
                玩家数据[id].角色.法宝[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝[n]]))
                if self.发送数据.道具[n].回合~=nil then
                    if self.发送数据.道具[n].回合<=回合 then
                        self.发送数据.道具[n].回合=nil
                    else
                        self.发送数据.道具[n].回合=self.发送数据.道具[n].回合-回合
                    end
                end
            end
        end
    end
    return self.发送数据
end

function 道具处理类:索要行囊(连接id,id)
    self.发送数据={道具={}}
    for n=1,20 do
        if 玩家数据[id].角色.行囊[n]~=nil then
            if self.数据[玩家数据[id].角色.行囊[n]]==nil then
                玩家数据[id].角色.行囊[n]=nil
            else
                self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.行囊[n]]))
            end
        end
    end
    self.发送数据.银子=玩家数据[id].角色.银子
    self.发送数据.储备=玩家数据[id].角色.储备
    self.发送数据.存银=玩家数据[id].角色.存银
    发送数据(连接id,3502,self.发送数据)
end


function 道具处理类:激活符石对话(id,道具id)
    if self.数据[道具id]~=nil and self.数据[道具id].名称=="未激活的符石" then
        玩家数据[id].激活符石 = 道具id
        local 消耗数据 = 激活符石消耗(self.数据[道具id].子类)
        local 对话="#W/需要消耗"..消耗数据.体力.."点体力"..消耗数据.经验.."点经验来激活这块符石么。#Y/(激活后为专用，无法转移给他人)"
        local xx={"确定","取消"}
        玩家数据[id].最后对话={}
        玩家数据[id].最后对话.名称="激活符石"
        玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
        发送数据(玩家数据[id].连接id,1501,{名称="激活符石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
    elseif self.数据[道具id]~=nil and self.数据[道具id].名称=="未激活的星石" then
        玩家数据[id].激活符石 = 道具id
        local 消耗数据 = 激活符石消耗(4)
        local 对话="#W/需要消耗"..消耗数据.体力.."点体力"..消耗数据.经验.."点经验来激活这块符石么。#Y/(激活后为专用，无法转移给他人)"
        local xx={"确定","取消"}
        玩家数据[id].最后对话={}
        玩家数据[id].最后对话.名称="激活符石"
        玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
        发送数据(玩家数据[id].连接id,1501,{名称="激活符石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
    end
end

function 道具处理类:激活符石(id) --改经脉
    local 道具id = 玩家数据[id].激活符石
    if self.数据[道具id]~=nil  and self.数据[道具id].名称=="未激活的符石" then
        local 消耗数据 = 激活符石消耗(self.数据[道具id].子类)
        if 玩家数据[id].角色.体力 < 消耗数据.体力 then
            常规提示(id,"体力不足，无法激活符石。")
            return
        end
        if 玩家数据[id].角色.当前经验<消耗数据.经验 then
            常规提示(id,"经验不足，无法激活符石。")
            return
        end
        玩家数据[id].角色.当前经验 = 玩家数据[id].角色.当前经验 - 消耗数据.经验
        玩家数据[id].角色.体力 = 玩家数据[id].角色.体力 - 消耗数据.体力
        self.数据[道具id].名称 = self.数据[道具id].符石名称
        self.数据[道具id].分类 = 88
        self.数据[道具id].不可交易 = true
        添加最后对话(id,"你消耗了"..消耗数据.体力.."体力"..消耗数据.经验.."经验,将"..self.数据[道具id].名称.."成功激活.这块符石可以镶嵌在已经开运过的装备上#50。")
        道具刷新(id)
        return
    elseif self.数据[道具id]~=nil and  self.数据[道具id].名称=="未激活的星石" then
        local 消耗数据 = 激活符石消耗(4)
        if 玩家数据[id].角色.体力 < 消耗数据.体力 then
            常规提示(id,"体力不足，无法激活符石。")
            return
        end
        if 玩家数据[id].角色.当前经验<消耗数据.经验 then
            常规提示(id,"经验不足，无法激活符石。")
            return
        end
        玩家数据[id].角色.当前经验 = 玩家数据[id].角色.当前经验 - 消耗数据.经验
        玩家数据[id].角色.体力 = 玩家数据[id].角色.体力 - 消耗数据.体力
        self.数据[道具id].分类 = 91
        self.数据[道具id].不可交易 = true
        if self.数据[道具id].子类 == 1 then
          self.数据[道具id].名称 = "云荒"
        elseif self.数据[道具id].子类 == 2 then
          self.数据[道具id].名称 = "暮霭"
        elseif self.数据[道具id].子类 == 3 then
          self.数据[道具id].名称 = "落日"
        elseif self.数据[道具id].子类 == 4 then
          self.数据[道具id].名称 = "晓天"
        elseif self.数据[道具id].子类 == 5 then
          self.数据[道具id].名称 = "林海"
        elseif self.数据[道具id].子类 == 6 then
          self.数据[道具id].名称 = "流霞"
        else
          self.数据[道具id].名称 = "云荒"
        end
        添加最后对话(id,"你消耗了"..消耗数据.体力.."体力"..消耗数据.经验.."经验,将"..self.数据[道具id].名称.."成功激活.这块符石可以镶嵌在已经开运过的装备上#50。")
        道具刷新(id)
        return
    end
end

function 道具处理类:装备镶嵌符石(数字id,sj)
    local id = 数字id + 0
    local 装备道具=self.数据[玩家数据[id].符石镶嵌]
    local 符石操作序列 = sj
    local 星石操作 = nil
    --判断装备是否可以镶嵌
    if 装备道具==nil then
        常规提示(id,"你没有这样的装备！")
        return
    elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.召唤兽装备 then
        常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
        return
    end
    --
    if not 判断是否为空表(符石操作序列) then
        local 重复 = false
        for k,v in pairs(符石操作序列) do
            if 重复 then
                break
            end
            if v.方式=="镶嵌" then
                local lssj =玩家数据[数字id].角色.道具[v.物品id]
                if v.背包类型=="道具" then
                    lssj=玩家数据[数字id].角色.道具[v.物品id]
                else
                    lssj=玩家数据[数字id].角色.行囊[v.物品id]
                end
                if self.数据[lssj]==nil then
                    常规提示(id,"道具数据异常，请重新打开界面进行操作1。")
                    return
                end
                if k<=5 and (self.数据[lssj].总类~=889 or self.数据[lssj].分类~=88) then
                    常规提示(id,"镶嵌需要符石，请给予我符石道具。")
                    return
                elseif k==6 and (self.数据[lssj].总类~=889 or self.数据[lssj].分类~=91) then
                    常规提示(id,"镶嵌需要星石，请给予我星石道具。")
                    return
                end
                for n,i in pairs(符石操作序列) do
                    if k~=n and i.方式=="镶嵌" and v.背包类型==i.背包类型 and v.物品id==i.物品id then
                        重复=true
                        break
                    end
                end
            end
        end
        if not 重复 then
            -- if 装备道具.孔数==nil then
            --  装备道具.孔数=0
            -- end
            if 装备道具.星位==nil then
                装备道具.星位={组合="",部位="无",门派="无"}
            end
            for k,v in pairs(符石操作序列) do
                if v.方式=="扣除" then
                    装备道具.星位[k]=nil
                elseif v.方式=="镶嵌" then
                    local lssj =玩家数据[数字id].角色.道具[v.物品id]
                    if v.背包类型=="道具" then
                        lssj=玩家数据[数字id].角色.道具[v.物品id]
                    else
                        lssj=玩家数据[数字id].角色.行囊[v.物品id]
                    end
                    if k==6 then --星石
                        装备道具.星位[k] = {}
                        装备道具.星位[k].名称 = self.数据[lssj].名称
                        装备道具.星位[k].颜色 = 取星位颜色(self.数据[lssj].子类)[2]
                        装备道具.星位[k].阴阳 = 2
                        local 临时属性 = 取星位属性(self.数据[lssj].子类)
                        装备道具.星位[k].符石属性={}
                        装备道具.星位[k].符石属性[临时属性.名称]=临时属性.属性值
                    else
                        装备道具.星位[k]={颜色=self.数据[lssj].颜色,名称=self.数据[lssj].名称,符石属性=self.数据[lssj].符石属性,符石等级=self.数据[lssj].子类}
                    end
                    self.数据[lssj]=nil
                end
            end
            if 装备道具.星位组 and 装备道具.星位~=nil and 装备道具.星位[6]~=nil then
                装备道具.星位[6].相互 = nil
                local 等级计算 = 0
                for n=1,5 do
                    if  装备道具.星位~=nil and 装备道具.星位[n]~=nil then
                        等级计算 = 等级计算 + (装备道具.星位[n].符石等级 or 0)
                    end
                end
                if 等级计算~=0 then
                    if 等级计算%2==0 then
                        --偶数 反面
                        if 装备道具.星位[6].阴阳==2 then
                            装备道具.星位[6].相互={}
                            装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
                        end
                    else
                        if 装备道具.星位[6].阴阳==1 then
                            装备道具.星位[6].相互={}
                            装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
                        end
                    end
                end
            end
            常规提示(id,"镶嵌成功。")
            local 星位数据=取星位组合(装备道具.星位)
            if 星位数据 ~=nil then
                装备道具.星位.组合=星位数据.组合
                装备道具.星位.部位=星位数据.部位
                装备道具.星位.门派=星位数据.门派
                装备道具.星位.组合等级=星位数据.等级
                常规提示(id,"#Y你的这件装备似乎开启了神秘的力量")
            else
                装备道具.星位.组合=nil
                装备道具.星位.部位=nil
                装备道具.星位.门派=nil
                装备道具.星位.组合等级=nil
            end
            if 符石操作序列[6]~=nil then
                星石操作=true
            end
            道具刷新(id)
            -- 玩家数据[id].角色:刷新信息()
            -- 发送数据(玩家数据[id].连接id,777,玩家数据[id].角色:取套装数据())
            -- 发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
            发送数据(玩家数据[id].连接id,3550,{装备=装备道具,星石操作=星石操作})
        else
            常规提示(id,"道具数据异常，请重新打开界面进行操作2。")
            return
        end
    else
        常规提示(id,"道具数据异常，请重新打开界面进行操作3。")
        return
    end
end

function 道具处理类:装备开启星位(连接id,数字id,数据)
  local 装备编号 = 玩家数据[数字id].角色.道具[数据.装备]
  local id = 数字id
  if self.数据[装备编号].总类~=2 or self.数据[装备编号].灵饰 or self.数据[装备编号].分类>6 then
    常规提示(id,"少侠，只有人物装备才可以开启星位。")
    return
  elseif self.数据[装备编号].等级==nil or self.数据[装备编号].等级<60 then
    常规提示(id,"少侠，需要装备等级达到60级才可以开启星位。")
    return
  elseif self.数据[装备编号].开运孔数==nil or self.数据[装备编号].开运孔数.当前<self.数据[装备编号].开运孔数.上限 then
    常规提示(id,"少侠，你的装备孔数没满，不能开启星位。")
    return
  elseif self.数据[装备编号].星位组~=nil then
    常规提示(id,"少侠，你这件装备已经开启过星位了别闹了（&……*&")
    return
  end
  local 临时消耗 = 取开启星位消耗(self.数据[装备编号].等级)
  if 玩家数据[id].角色.银子<临时消耗.金钱 then
    常规提示(id,format("开启星位需要消耗#Z/%s#Y/两银子，你似乎手头有点紧哟？",临时消耗.金钱))
    return
  elseif 玩家数据[id].角色.当前经验<临时消耗.经验 then
    常规提示(id,format("开启星位需要消耗#Z/%s#Y/点经验，你似乎没有那么多的经验？",临时消耗.经验))
    return
  end
  玩家数据[id].角色:扣除银子(临时消耗.金钱,0,0,"开启星位",1)
  -- 玩家数据[id].角色:扣除经验(临时消耗.经验,0,1)
  玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-临时消耗.经验
  self.数据[装备编号].星位组 = true
  常规提示(id,"#Z/恭喜你开启星位成功！")
  道具刷新(id)
end

function 道具处理类:装备翻转星石(数字id)
    local id = 数字id + 0
    local 装备道具 = self.数据[玩家数据[id].符石镶嵌]
    if 装备道具==nil then
    常规提示(id,"你没有这样的装备！")
    return
  elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.分类==9 or 装备道具.分类==8 or 装备道具.分类==7 then
    常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
    return
  elseif not 装备道具.星位组 or 装备道具.星位==nil or 装备道具.星位[6]==nil then
    常规提示(id,"装备数据错误，请重新打开界面！")
    return
  end
  if 玩家数据[id].角色.体力 >= 100 then
    if 装备道具.星位组 and 装备道具.星位~=nil and 装备道具.星位[6]~=nil then
      if 装备道具.星位[6].阴阳 ==1 then
        装备道具.星位[6].阴阳 = 2
        装备道具.星位[6].颜色 = 取星位颜色(装备道具.分类)[2]
      else
        装备道具.星位[6].阴阳 = 1
        装备道具.星位[6].颜色 = 取星位颜色(装备道具.分类)[1]
      end
      装备道具.星位[6].相互 = nil
      local 等级计算 = 0
      for n=1,5 do
        if  装备道具.星位~=nil and 装备道具.星位[n]~=nil then
          等级计算 = 等级计算 + 装备道具.星位[n].符石等级
        end
      end
      if 等级计算~=0 then
        if 等级计算%2==0 then
          --偶数 反面
          if 装备道具.星位[6].阴阳==2 then
            装备道具.星位[6].相互={}
            装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
          end
        else
          if 装备道具.星位[6].阴阳==1 then
            装备道具.星位[6].相互={}
            装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
          end
        end
      end
    end
    玩家数据[id].角色.体力=玩家数据[id].角色.体力-100
    常规提示(id,"翻转星位成功。")
    道具刷新(id)
    玩家数据[id].角色:刷新信息()
    -- 发送数据(玩家数据[id].连接id,777,玩家数据[id].角色:取套装数据())
    -- 发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
    发送数据(玩家数据[id].连接id,3550,{装备=装备道具})
  else
    常规提示(id,"体力不足，无法翻转")
  end
end

function 道具处理类:翻转星石对话(id,道具id)
  local 装备道具 = self.数据[玩家数据[id].符石镶嵌]
    if 装备道具==nil then
    常规提示(id,"你没有这样的装备！")
    return
  elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.分类==9 or 装备道具.分类==8 or 装备道具.分类==7 then
    常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
    return
  elseif not 装备道具.星位组 or 装备道具.星位==nil or 装备道具.星位[6]==nil then
    常规提示(id,"装备数据错误，请重新打开界面！")
    return
  end
  local 对话="#W/确定要将星石翻转吗？翻转星石不会引起星石自身属性变化，请放心操作。"
  local xx={"消耗100体力进行翻转","取消"}
  玩家数据[id].最后对话={}
  玩家数据[id].最后对话.名称="翻转星石"
  玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
  发送数据(玩家数据[id].连接id,1501,{名称="翻转星石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
end

function 道具处理类:合成符石(连接id,数字id,数据)
    local id = 数字id
    local 物品 = 数据.材料
    local 卷轴 = 0
    local 卷轴道具 = 0
    local 符石 = {}
    local 符石道具 = {}
    local f1,f2,f3=0,0,0
    local 玩家道具栏 = 玩家数据[id].角色.道具
    local 道具格子 = 玩家数据[id].角色:取道具格子()
    if 道具格子 == 0 then
        常规提示(id,"你的道具栏已经满了,保留至少一格以上的位置进行合成哦")
        return
    end
    if 玩家数据[id].角色.体力<40 then
        常规提示(id,"合成符石至少需要40点体力哦。")
        return
    end
    for k,v in pairs(物品) do
        if self.数据[玩家道具栏[v]]~=nil and self.数据[玩家道具栏[v]].总类 == 889 and self.数据[玩家道具栏[v]].分类 == 89 then
            if self.数据[玩家道具栏[v]].子类==6 then
                卷轴 = 玩家道具栏[v]
                卷轴道具 = v
            else
                符石[#符石+1] = 玩家道具栏[v]
                符石道具[#符石道具+1] = v
                if self.数据[符石[#符石]].子类==1 then
                    f1=f1+1
                elseif self.数据[符石[#符石]].子类==2 then
                    f2=f2+1
                elseif self.数据[符石[#符石]].子类==3 then
                    f3=f3+1
                end
            end
        else
            常规提示(id,"少侠，给的物品不对哦。")
            return
        end
    end
    local 是否合成 = false

    if f1>=1 and f1+f2==3 and f3==0 and 卷轴==0 then -- 合成二级符石
        是否合成 = 1
    elseif f2>=1 and f2+f3==2 and 卷轴~=0 and f1==0 then -- 合成三级符石
        是否合成 = 2
    elseif f3>=2 and f3 < 3 and 卷轴~=0 and f2==0 and f1==0 then  --合成新三符石
        是否合成 = 3
    elseif f3>=1 and f1+f2+f3==3 and 卷轴~=0 then --合成4级符石
        是否合成 = 4
    else
        常规提示(id,"请仔细查看放入的材料是否正确。")
        return
    end
    玩家数据[id].角色:扣除体力(40)
    local 概率范围 = 取随机数(1,1000)
    if 是否合成 == 1 then
        local 成功率 = 800
            if 概率范围 <= 成功率 then
                for i=1,#符石 do
                    self.数据[符石[i]] = nil
                    玩家道具栏[符石道具[i]] = nil
                end
                玩家数据[id].道具:给予道具(id,"未激活的符石",2)
                常规提示(id,"合成成功")
            else
                for i=1,#符石 do
                    if 50 <= 取随机数(1,100) then
                        self.数据[符石[i]] = nil
                        玩家道具栏[符石道具[i]] = nil
                        break
                    elseif i==#符石 then
                        self.数据[符石[i]] = nil
                        玩家道具栏[符石道具[i]] = nil
                        break
                    end
                end
                道具刷新(id)
                常规提示(id,"合成失败，你因此随机损失了一个符石")
            end
    elseif 是否合成 == 2 then
            local 成功率 = 600
            if  概率范围 <= 成功率 then
                for i=1,#符石 do
                    self.数据[符石[i]]=nil
                    玩家道具栏[符石道具[i]] = nil
                end
                if self.数据[卷轴].数量 and self.数据[卷轴].数量 > 1 then
                    self.数据[卷轴].数量 = self.数据[卷轴].数量 - 1
                else
                    self.数据[卷轴] = nil
                    玩家道具栏[卷轴道具] = nil
                end
                玩家数据[id].道具:给予道具(id,"未激活的符石",3)
                常规提示(id,"合成成功")
            else
                if self.数据[卷轴].数量 and self.数据[卷轴].数量 > 1 then
                    self.数据[卷轴].数量 = self.数据[卷轴].数量 - 1
                else
                    self.数据[卷轴] = nil
                    玩家道具栏[卷轴道具] = nil
                end
                道具刷新(id)
                常规提示(id,"合成失败，你因此损失了一个符石卷轴")
            end
    elseif 是否合成 == 3 then
            local 成功率 = 300
            if 概率范围 <= 成功率 then
                for i=1,#符石 do
                    self.数据[符石[i]]=nil
                    玩家道具栏[符石道具[i]] = nil
                end
                if self.数据[卷轴].数量 and self.数据[卷轴].数量 > 1 then
                    self.数据[卷轴].数量 = self.数据[卷轴].数量 - 1
                else
                    self.数据[卷轴] = nil
                    玩家道具栏[卷轴道具] = nil
                end
                local 获取符石 = 新三级符石[取随机数(1,#新三级符石)]
                玩家数据[id].道具:给予道具(id,"未激活的符石",3,获取符石)
                常规提示(id,"合成成功")
            else
                if self.数据[卷轴].数量 and self.数据[卷轴].数量 > 1 then
                    self.数据[卷轴].数量 = self.数据[卷轴].数量 - 1
                else
                    self.数据[卷轴] = nil
                    玩家道具栏[卷轴道具] = nil
                end
                for i=1,#符石 do
                    if 50 <= 取随机数(1,100) then
                        self.数据[符石[i]] = nil
                        玩家道具栏[符石道具[i]] = nil
                        break
                    else
                        self.数据[符石[i]] = nil
                        玩家道具栏[符石道具[i]] = nil
                        break
                    end
                end
                道具刷新(id)
                常规提示(id,"合成失败，你因此损失了一个符石卷轴及一颗符石")
            end
    elseif 是否合成 == 4 then
            local 成功率 = 400
            if 概率范围 <= 成功率 then
                for i=1,#符石 do
                    self.数据[符石[i]]=nil
                    玩家道具栏[符石道具[i]] = nil
                end
                if self.数据[卷轴].数量 and self.数据[卷轴].数量 > 1 then
                    self.数据[卷轴].数量 = self.数据[卷轴].数量 - 1
                else
                    self.数据[卷轴] = nil
                    玩家道具栏[卷轴道具] = nil
                end
                玩家数据[id].道具:给予道具(id,"未激活的星石")
                常规提示(id,"合成成功")
            else
                if self.数据[卷轴].数量 and self.数据[卷轴].数量 > 1 then
                    self.数据[卷轴].数量 = self.数据[卷轴].数量 - 1
                else
                    self.数据[卷轴] = nil
                    玩家道具栏[卷轴道具] = nil
                end
                道具刷新(id)
                常规提示(id,"合成失败，你因此损失了一个符石卷轴")
            end
    end
end

function 道具处理类:月卡奖励(id)
    if 玩家数据[id].角色.月卡 == nil  then
        玩家数据[id].角色.月卡 = {生效=false,到期时间=0}
    end
    if os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 or 玩家数据[id].角色.月卡.生效 == false then
        玩家数据[id].角色.月卡.生效=false
        常规提示(id,"#Y该会员已到期！")
        return
    end
    if 玩家数据[id].角色.月卡.使用日期 == nil then
        玩家数据[id].角色.月卡.使用日期 = os.date("%d", os.time())
        玩家数据[id].角色.月卡.使用月份 = os.date("%m", os.time())
    elseif os.date("%d", os.time()) == 玩家数据[id].角色.月卡.使用日期 and os.date("%m", os.time()) == 玩家数据[id].角色.月卡.使用月份 then
        常规提示(id,"#Y今日已经领取过该奖励了,请明日再来吧。")
        return 0
    else
        玩家数据[id].角色.月卡.使用日期 = os.date("%d", os.time())
        玩家数据[id].角色.月卡.使用月份 = os.date("%m", os.time())
    end
  local 领取物品 = {}
    for n = 1, 10 do
        if 全局礼包数据.月卡每日[1]["物品"..n] ~= nil then
            领取物品[#领取物品 + 1] = table.copy(全局礼包数据.月卡每日[1]["物品"..n])
        end
    end
    礼包奖励类:领取定义礼包(id, 领取物品)
    道具刷新(id)
end

function 道具处理类:开启铜矿(id,任务id)
  if 采矿活动[id]==nil then
    采矿活动[id]={总计=0}
  end
    if  玩家数据[id].角色.采矿数据 == nil then
    玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
    end
  if 采矿活动[id].总计>=20 then
    常规提示(id,"#Y少侠今日已开采矿石20次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  local 队伍id = 玩家数据[id].队伍
  local 成员列表 = {id}
  if 队伍id ~= 0 then
    成员列表 = {}
    for k,v in pairs(队伍数据[队伍id].成员数据) do
      成员列表[#成员列表+1] = v
    end
  end
  for _,成员id in ipairs(成员列表) do
    if 玩家数据[成员id].角色.采矿数据 == nil then
      玩家数据[成员id].角色.采矿数据= {熟练度=0,矿业声望=0}
    end
    玩家数据[成员id].角色.采矿数据.熟练度=玩家数据[成员id].角色.采矿数据.熟练度+1
    玩家数据[成员id].角色.采矿数据.矿业声望=玩家数据[成员id].角色.采矿数据.矿业声望+1
    常规提示(成员id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G1#Y点！")
    local 银子=取随机数(30000,50000)
    玩家数据[成员id].角色:添加银子(银子,"铜矿",1)
    local 奖励参数=取随机数(1,200)
    if 取随机数()<=50 then
      local 获得物品={}
      for i=1,#自定义数据.铜铁矿 do
        if 取随机数()<=自定义数据.铜铁矿[i].概率 then
          获得物品[#获得物品+1]=自定义数据.铜铁矿[i]
        end
      end
      获得物品=删除重复(获得物品)
      if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
          玩家数据[成员id].道具:自定义给予道具(成员id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
          if 成员id == id then
            广播消息({内容=format("#S(铜铁矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
          end
        end
      end
    else
      local 等级=玩家数据[成员id].角色.等级
      local 经验=(等级*300*2)
      玩家数据[成员id].角色:添加经验(经验,"宝藏山大箱子",1)
    end
  end
end
function 道具处理类:开启银矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
    if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
    end
  if 采矿活动[id].总计>=20 then
    常规提示(id,"#Y少侠今日已开采矿石20次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 25 then
    常规提示(id,"#Y少侠采矿熟练度不足,无法继续开采白银矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  local 队伍id = 玩家数据[id].队伍
  local 成员列表 = {id}
  if 队伍id ~= 0 then
    成员列表 = {}
    for k,v in pairs(队伍数据[队伍id].成员数据) do
      成员列表[#成员列表+1] = v
    end
  end
  for _,成员id in ipairs(成员列表) do
    if 玩家数据[成员id].角色.采矿数据 == nil then
      玩家数据[成员id].角色.采矿数据= {熟练度=0,矿业声望=0}
    end
    玩家数据[成员id].角色.采矿数据.熟练度=玩家数据[成员id].角色.采矿数据.熟练度+2
    玩家数据[成员id].角色.采矿数据.矿业声望=玩家数据[成员id].角色.采矿数据.矿业声望+2
    常规提示(成员id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G2#Y点！")
    local 银子=取随机数(40000,60000)
    玩家数据[成员id].角色:添加银子(银子,"银矿",1)
    local 奖励参数=取随机数(1,200)
    if 取随机数()<=50 then
      local 获得物品={}
      for i=1,#自定义数据.白银矿 do
        if 取随机数()<=自定义数据.白银矿[i].概率 then
          获得物品[#获得物品+1]=自定义数据.白银矿[i]
        end
      end
      获得物品=删除重复(获得物品)
      if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
          玩家数据[成员id].道具:自定义给予道具(成员id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
          if 成员id == id then
            广播消息({内容=format("#S(白银矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
          end
        end
      end
    else
      local 等级=玩家数据[成员id].角色.等级
      local 经验=(等级*300*2)
      玩家数据[成员id].角色:添加经验(经验,"银矿",1)
    end
  end
end
function 道具处理类:开启翡翠矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
      if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=20 then
    常规提示(id,"#Y少侠今日已开采矿石20次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 100 then
    常规提示(id,"#Y少侠采矿熟练度不足100,无法继续开采翡翠矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  local 队伍id = 玩家数据[id].队伍
  local 成员列表 = {id}
  if 队伍id ~= 0 then
    成员列表 = {}
    for k,v in pairs(队伍数据[队伍id].成员数据) do
      成员列表[#成员列表+1] = v
    end
  end
  for _,成员id in ipairs(成员列表) do
    if 玩家数据[成员id].角色.采矿数据 == nil then
      玩家数据[成员id].角色.采矿数据= {熟练度=0,矿业声望=0}
    end
    玩家数据[成员id].角色.采矿数据.熟练度=玩家数据[成员id].角色.采矿数据.熟练度+2
    玩家数据[成员id].角色.采矿数据.矿业声望=玩家数据[成员id].角色.采矿数据.矿业声望+2
    常规提示(成员id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G2#Y点！")
    local 银子=取随机数(50000,80000)
    玩家数据[成员id].角色:添加银子(银子,"银矿",1)
    local 奖励参数=取随机数(1,200)
    if 取随机数()<=50 then
      local 获得物品={}
      for i=1,#自定义数据.翡翠矿 do
        if 取随机数()<=自定义数据.翡翠矿[i].概率 then
          获得物品[#获得物品+1]=自定义数据.翡翠矿[i]
        end
      end
      获得物品=删除重复(获得物品)
      if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
          玩家数据[成员id].道具:自定义给予道具(成员id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
          if 成员id == id then
            广播消息({内容=format("#S(翡翠矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
          end
        end
      end
    else
      local 等级=玩家数据[成员id].角色.等级
      local 经验=(等级*300*2)
      玩家数据[成员id].角色:添加经验(经验,"银矿",1)
    end
  end
end
function 道具处理类:开启黄金矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
        if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=20 then
    常规提示(id,"#Y少侠今日已开采矿石20次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 300 then
    常规提示(id,"#Y少侠采矿熟练度不足300,无法继续开采黄金矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  local 队伍id = 玩家数据[id].队伍
  local 成员列表 = {id}
  if 队伍id ~= 0 then
    成员列表 = {}
    for k,v in pairs(队伍数据[队伍id].成员数据) do
      成员列表[#成员列表+1] = v
    end
  end
  for _,成员id in ipairs(成员列表) do
    if 玩家数据[成员id].角色.采矿数据 == nil then
      玩家数据[成员id].角色.采矿数据= {熟练度=0,矿业声望=0}
    end
    玩家数据[成员id].角色.采矿数据.熟练度=玩家数据[成员id].角色.采矿数据.熟练度+3
    玩家数据[成员id].角色.采矿数据.矿业声望=玩家数据[成员id].角色.采矿数据.矿业声望+3
    常规提示(成员id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G2#Y点！")
    local 银子=取随机数(50000,80000)
    玩家数据[成员id].角色:添加银子(银子,"黄金矿",1)
    local 奖励参数=取随机数(1,200)
    if 取随机数()<=50 then
      local 获得物品={}
      for i=1,#自定义数据.黄金矿 do
        if 取随机数()<=自定义数据.黄金矿[i].概率 then
          获得物品[#获得物品+1]=自定义数据.黄金矿[i]
        end
      end
      获得物品=删除重复(获得物品)
      if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
          玩家数据[成员id].道具:自定义给予道具(成员id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
          if 成员id == id then
            广播消息({内容=format("#S(黄金矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
          end
        end
      end
    else
      local 等级=玩家数据[成员id].角色.等级
      local 经验=(等级*300*2)
      玩家数据[成员id].角色:添加经验(经验,"黄金矿",1)
    end
  end
end
function 道具处理类:开启紫金矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
        if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=20 then
    常规提示(id,"#Y少侠今日已开采矿石20次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 500 then
    常规提示(id,"#Y少侠采矿熟练度不足500,无法继续开采紫金矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  local 队伍id = 玩家数据[id].队伍
  local 成员列表 = {id}
  if 队伍id ~= 0 then
    成员列表 = {}
    for k,v in pairs(队伍数据[队伍id].成员数据) do
      成员列表[#成员列表+1] = v
    end
  end
  for _,成员id in ipairs(成员列表) do
    if 玩家数据[成员id].角色.采矿数据 == nil then
      玩家数据[成员id].角色.采矿数据= {熟练度=0,矿业声望=0}
    end
    玩家数据[成员id].角色.采矿数据.熟练度=玩家数据[成员id].角色.采矿数据.熟练度+5
    玩家数据[成员id].角色.采矿数据.矿业声望=玩家数据[成员id].角色.采矿数据.矿业声望+5
    常规提示(成员id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G5#Y点！")
    local 银子=取随机数(100000,120000)
    玩家数据[成员id].角色:添加银子(银子,"紫金矿",1)
    local 奖励参数=取随机数(1,200)
    if 取随机数()<=50 then
      local 获得物品={}
      for i=1,#自定义数据.紫金矿 do
        if 取随机数()<=自定义数据.紫金矿[i].概率 then
          获得物品[#获得物品+1]=自定义数据.紫金矿[i]
        end
      end
      获得物品=删除重复(获得物品)
      if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
          玩家数据[成员id].道具:自定义给予道具(成员id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
          if 成员id == id then
            广播消息({内容=format("#S(紫金矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
          end
        end
      end
    else
      local 等级=玩家数据[成员id].角色.等级
      local 经验=(等级*300*2)
      玩家数据[成员id].角色:添加经验(经验,"紫金矿",1)
    end
  end
end

function 道具处理类:自定义给予道具(id,名称,数量,参数)
    if 名称=="钨金" or 名称=="附魔宝珠" or 名称=="炼妖石" or 名称=="天眼珠" or 名称=="上古锻造图策" then
        self:给予道具(id,名称,数量,参数)
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
        end
    elseif  名称=="珍珠" or 名称=="战魄" then
        local 给予等级 = 数量[取随机数(1,#数量)]
        self:给予道具(id,名称,给予等级,参数)
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予等级,名称),频道="xt"})
        end
    elseif 名称=="制造指南书" or 名称=="百炼精铁" then
        local 给予等级 = 取随机数(数量[1],数量[#数量])*10
        if 参数==nil then
            if 取随机数()<=50 then
                参数= 取随机数(1,18)
            else
                参数= 取随机数(19,#书铁范围)
            end
        end
        self:给予道具(id,名称,给予等级,参数)
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予等级,名称),频道="xt"})
        end
    elseif 名称=="150随机书铁"then
        local 给予等级 = 取随机数(数量[1],数量[#数量])*10
        if 参数==nil then
            if 取随机数()<=50 then
                参数= 取随机数(1,18)
            else
                参数= 取随机数(19,#书铁范围)
            end
        end
        self:给予道具(id,"制造指南书",给予等级,参数)
        self:给予道具(id,"百炼精铁",给予等级,参数)
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/随机书铁一套#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予等级),频道="xt"})
        end
    elseif 名称=="140灵饰书铁" then
        if 参数==nil then
            local 临时范围 = {"手镯","佩饰","戒指","耳饰"}
            参数= 临时范围[取随机数(1,4)]
        end
        self:给予道具(id,"灵饰指南书",数量,参数)
        self:给予道具(id,"元灵晶石",数量,参数)
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了制作#G/%s#Y/的#G/随机灵饰书铁一套#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数),频道="xt"})
        end
    elseif 名称=="灵饰指南书" or 名称=="元灵晶石" then
        if 参数==nil then
            local 临时范围 = {"手镯","佩饰","戒指","耳饰"}
            参数= 临时范围[取随机数(1,4)]
        end
        self:给予道具(id,名称,数量,参数)
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了制作#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数,名称),频道="xt"})
        end
    elseif 名称=="魔兽要诀" or 名称=="高级魔兽要诀" or 名称=="特殊魔兽要诀" or 名称=="召唤兽内丹" or 名称=="高级召唤兽内丹" or 名称=="点化石" then
        if 参数 ==nil then
            if 名称=="召唤兽内丹" then
                参数=取内丹()
            elseif 名称=="高级召唤兽内丹" then
                参数=取内丹("高级")
            elseif 名称=="魔兽要诀" then
                参数=取低级要诀()
            elseif 名称=="高级魔兽要诀" then
                参数=取高级要诀()
            elseif 名称=="特殊魔兽要诀" then
                参数=取特殊要诀()
            elseif 名称=="点化石" then
                local 生成几率 = 取随机数()
                if 生成几率<= 5 then
                    参数=取特殊要诀()
                elseif 生成几率<= 35 and 生成几率>=6 then
                    参数=取高级要诀()
                else
                    参数=取低级要诀()
                end
            end
        end
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        for i=1,给予数量 do
            self:给予道具(id,名称,1,参数)
        end
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了携带技能为#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数,名称),频道="xt"})
        end
    elseif 名称=="鬼谷子"  then
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        for i=1,给予数量 do
            self:给予道具(id,名称,1,参数)
        end
        if 玩家数据[id].抽中编号~=nil then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数),频道="xt"})
        end
    elseif 名称=="初级清灵仙露"  or 名称=="中级清灵仙露"  or 名称=="高级清灵仙露" then
       local 给予数量 = 取随机数(数量[1],数量[#数量])
       for i=1,给予数量 do
          self:给予道具(id,名称,1,参数)
       end
    elseif 名称=="宝石" then
        local 宝石名称 = {"红玛瑙","太阳石","舍利子","黑宝石","月亮石","光芒石","星辉石"}
        local 给予名称 = 宝石名称[取随机数(1,#宝石名称)]
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="五宝" then
        local 给予名称 = self:取五宝()
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="强化石" then
        local 给予名称 = 取强化石()
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="九转金丹" then
        local 给予名称 = "九转金丹"
        self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="12技能法宠" then
        local 给予名称 = "12技能法宠"
        self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="12技能攻宠" then
        local 给予名称 = "12技能攻宠"
        self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="24技能攻宠" then
        local 给予名称 = "24技能攻宠"
        self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="150无级别礼包" then
        local 给予名称 = "150无级别礼包"
        self:给予道具(id,给予名称,给予数量,参数)
    else
        local 是否广播 =true
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        self:给予道具(id,名称,给予数量,参数)
        if 名称 =="红玛瑙" or  名称 =="太阳石" or  名称 =="舍利子" or  名称 =="黑宝石" or  名称 =="月亮石" or  名称 =="光芒石" or  名称 =="星辉石" then
           if 玩家数据[id].抽中编号~=nil then
             广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予数量,名称),频道="xt"})
             是否广播 =false
          end
        end
        if 玩家数据[id].抽中编号~=nil and 是否广播 then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/个#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予数量,名称),频道="xt"})
        end
    end
  常规提示(id,"#Y你获得了#R"..名称)
end

function 道具处理类:物品查找(id,名称,数量)----------佬伍修改（增加种族秘境时空之钥）
  local 满足要求 = false
  local 总数量 = 0
   for n=1, 80 do
     if 玩家数据[id].角色.道具[n] ~= nil then
        local 临时道具 = self.数据[玩家数据[id].角色.道具[n]]
        if 临时道具.名称 == 名称 then
          if 临时道具.数量 == nil then
            错误追溯()
            return false
          end
          总数量 = 总数量 + (临时道具.数量 or 1)
        end
     end
   end
    if type(数量) == "string" then
      print("物品查找为字符串",名称)
      错误追溯()
      return false
    end
   if 总数量 >= 数量 then
      满足要求 = true
   end
   return 满足要求
end
function 道具处理类:时空之钥物品查找(id, 名称, 临时道具类型)----------佬伍修改（增加种族秘境时空之钥）
    local 满足要求 = false
    for n = 1, 80 do
        if 玩家数据[id].角色.道具[n] ~= nil then
            local 临时道具 = self.数据[玩家数据[id].角色.道具[n]]
            if 临时道具.名称 == 名称 and 临时道具.类型 == 临时道具类型 then
                满足要求 = true
                break
            end
        end
    end
    return 满足要求
end
function 道具处理类:更改时空之钥(id)--------------佬伍修改（增加种族秘境时空之钥）
    for n = 1, 80 do
        if 玩家数据[id].角色.道具[n] ~= nil then
            local 临时道具 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[n]]
            if 临时道具.名称 == "人族时空之钥" or 临时道具.名称 == "魔族时空之钥" or 临时道具.名称 == "仙族时空之钥" then
                -- 根据原始名称设置初始类型和秘境类型
                local 道具类型 = {
                    ["人族时空之钥"] = "人族",
                    ["魔族时空之钥"] = "魔族",
                    ["仙族时空之钥"] = "仙族"
                }
                临时道具.类型 = 道具类型[临时道具.名称]
                local 道具秘境类型
                if 临时道具.名称 == "人族时空之钥" then
                    local a = {"青丘秘辛", "九曲神林", "车迟斗法", "暗偃禁地", "女国迷阵"}
                    道具秘境类型 = a[取随机数(1, #a)]
                elseif 临时道具.名称 == "魔族时空之钥" then
                    local a = {"狮驼洞穴", "火焰山之子", "九黎魔影", "阴府勾魂", "陷空妖洞"}
                    道具秘境类型 = a[取随机数(1, #a)]
                elseif 临时道具.名称 == "仙族时空之钥" then
                    local a = {"沧海狂龙", "万雷神殿", "金甲天门", "龙王秘宝", "大闹天宫"}
                    道具秘境类型 = a[取随机数(1, #a)]
                end
                临时道具.秘境类型 = 道具秘境类型
                -- 随机生成新的道具类型
                local 随机道具类型 = {"人族时空之钥","魔族时空之钥","仙族时空之钥"}
                local 随机类型 = 随机道具类型[取随机数(1, #随机道具类型)]
                临时道具.名称 = 随机类型
                -- 根据新的名称更新类型和秘境类型
                临时道具.类型 = 道具类型[临时道具.名称]
                if 临时道具.名称 == "人族时空之钥" then
                    local a = {"青丘秘辛", "九曲神林", "车迟斗法", "暗偃禁地", "女国迷阵"}
                    道具秘境类型 = a[取随机数(1, #a)]
                elseif 临时道具.名称 == "魔族时空之钥" then
                    local a = {"狮驼洞穴", "火焰山之子", "九黎魔影", "阴府勾魂", "陷空妖洞"}
                    道具秘境类型 = a[取随机数(1, #a)]
                elseif 临时道具.名称 == "仙族时空之钥" then
                    local a = {"沧海狂龙", "万雷神殿", "金甲天门", "龙王秘宝", "大闹天宫"}
                    道具秘境类型 = a[取随机数(1, #a)]
                end
                临时道具.秘境类型 = 道具秘境类型
                --临时道具.境界 = 时空之钥[id].境界
                临时道具.境界 = (时空之钥[id] and 时空之钥[id].境界) or 0--修复
                道具刷新(id)
                return 临时道具
            end
        end
    end
    return nil
end
function 道具处理类:扣除道具数量(id,道具名,数量,参数一名称,参数一,参数二名称,参数二)
  local 扣除数据={}
  local 已扣除=0
  for n=1,80 do
    if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==道具名 then
      if 参数一名称 ~=nil and 参数一~=nil then
        if self.数据[玩家数据[id].角色.道具[n]][参数一名称] ~= nil and self.数据[玩家数据[id].角色.道具[n]][参数一名称]==参数一 then

          if 参数二名称 ~=nil and 参数二~=nil then
            if self.数据[玩家数据[id].角色.道具[n]][参数二名称] ~= nil and self.数据[玩家数据[id].角色.道具[n]][参数二名称]==参数二 then
              if self.数据[玩家数据[id].角色.道具[n]].数量 == nil then
                self.数据[玩家数据[id].角色.道具[n]].数量 = 1
              end
              if self.数据[玩家数据[id].角色.道具[n]].数量>=数量-已扣除 then
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=数量-已扣除}
                已扣除=已扣除+(数量-已扣除)
              else
                已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
                扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
              end
            end
          else

            if self.数据[玩家数据[id].角色.道具[n]].数量 == nil then
              self.数据[玩家数据[id].角色.道具[n]].数量 = 1
            end
            if self.数据[玩家数据[id].角色.道具[n]].数量>=数量-已扣除 then
              扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=数量-已扣除}
              已扣除=已扣除+(数量-已扣除)
            else
              已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
              扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
            end
          end
        end
      else
        if self.数据[玩家数据[id].角色.道具[n]].数量 == nil then
          self.数据[玩家数据[id].角色.道具[n]].数量 = 1
        end
        if self.数据[玩家数据[id].角色.道具[n]].数量>=数量-已扣除 then
          扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=数量-已扣除}
          已扣除=已扣除+(数量-已扣除)
        else
          已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
          扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
        end
      end
    end
  end
  if 已扣除<数量 then
        if 参数一名称 ~=nil and 参数一名称=="附带技能" and 参数一~=nil then
            常规提示(id,"你没有那么多的#R"..道具名.."#Y【"..参数一.."】，请检查包裹。")
         elseif 参数二名称 ~=nil and 参数二名称 =="特效"  and 参数二~=nil then
            常规提示(id,"你没有那么多的#R"..道具名.."#Y【"..参数二.."】，请检查包裹。")
        else
            常规提示(id,"你没有那么多的#R"..道具名.."#Y，请检查包裹。")
        end
    return false
  else
    for n=1,#扣除数据 do
      self.数据[扣除数据[n].id].数量=self.数据[扣除数据[n].id].数量-扣除数据[n].数量
      if self.数据[扣除数据[n].id].数量<=0 then
        self.数据[扣除数据[n].id]=nil
        玩家数据[id].角色.道具[扣除数据[n].格子]=nil
      end
    end
    return true
  end
end

return 道具处理类
