-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:40
-- @Last Modified by:   tangguo
-- @Last Modified time: 2026-06-06 11:44:27
local 辅助内挂类 = class()
-- 东海秘境挂机坐标（对应地图11261的25个关卡假人，需与 Script/对话处理类/对话调用/11261.lua 的 关卡坐标 保持一致）
local 东海秘境坐标 = {
    {x=84,y=79},{x=98,y=77},{x=110,y=81},{x=117,y=70},{x=86,y=56},
    {x=101,y=55},{x=128,y=57},{x=157,y=56},{x=151,y=67},{x=178,y=79},
    {x=173,y=49},{x=182,y=22},{x=157,y=34},{x=122,y=35},{x=122,y=16},
    {x=103,y=29},{x=100,y=14},{x=83,y=14},{x=36,y=13},{x=20,y=14},
    {x=11,y=26},{x=8,y=40},{x=20,y=49},{x=45,y=37},{x=29,y=30},
}

local 游泳坐标={
        {z=1092,x=208,y=19,f=1}
        ,{z=1514,x=43,y=16,f=1}
        ,{z=1514,x=101,y=103,f=0}
        ,{z=1118,x=53,y=38,f=1}
        ,{z=1119,x=52,y=22,f=1}
        ,{z=1119,x=5,y=21,f=0}
        ,{z=1532,x=58,y=37,f=1}
        ,{z=1532,x=8,y=30,f=0}
        ,{z=1121,x=8,y=7,f=0}
        ,{z=1121,x=34,y=39,f=0}
        ,{z=1120,x=8,y=32,f=0}
        ,{z=1120,x=53,y=29,f=1}
        ,{z=1118,x=26,y=39,f=0}
        ,{z=1116,x=88,y=15,f=0}
        ,{z=1116,x=206,y=61,f=1}
        ,{z=1116,x=78,y=101,f=1}
        ,{z=1506,x=113,y=6,f=0}
        ,{z=1506,x=104,y=63,f=0}
        ,{z=1092,x=132,y=142,f=0}
        ,{z=1092,x=201,y=45,f=1}
    }

-- ================== 新增：神器任务配置 ==================
-- 神器任务类型列表（用于查找进行中的神器任务）
local 神器任务类型组 = {1550,1560,1570,1580,1590,1600,1610,1620,1630,1640,1650,1660,1670,1680,1690,1700}

-- 难度名称映射
local 神器难度名称 = {
    [1] = "★",
    [2] = "★★",
    [3] = "★★★",
    [4] = "★★★★",
    [5] = "★★★★★",
}

-- 根据种族和星期获取今日神器任务名称和开启函数
local function 获取今日神器任务信息(数字id)
    local 种族 = 玩家数据[数字id].角色.种族
    local zhouji = tonumber(os.date("%w", os.time()))
    local 任务名称 = ""
    local 开启函数 = nil

    if 种族 == "仙" then
        if zhouji == 1 then 任务名称 = "清泽谱之惠" 开启函数 = function(id,nandu) 副本_清泽谱之惠:开启副本(id,nandu or 1) end
        elseif zhouji == 2 then 任务名称 = "华光玉之伤" 开启函数 = function(id,nandu) 副本_华光玉之伤:开启副本(id,nandu or 1) end
        elseif zhouji == 3 then 任务名称 = "星斗盘之约" 开启函数 = function(id,nandu) 副本_星斗盘之约:开启副本(id,nandu or 1) end
        elseif zhouji == 4 then 任务名称 = "天罡印之谋" 开启函数 = function(id,nandu) 副本_天罡印之谋:开启副本(id,nandu or 1) end
        elseif zhouji == 5 then 任务名称 = "四神鼎之怨" 开启函数 = function(id,nandu) 副本_四神鼎之怨:开启副本(id,nandu or 1) end
        elseif zhouji == 6 then 任务名称 = "噬魂齿之争" 开启函数 = function(id,nandu) 副本_噬魂齿之争:开启副本(id,nandu or 1) end
        elseif zhouji == 0 then 任务名称 = "昆仑镜之忆" 开启函数 = function(id,nandu) 副本_昆仑镜之忆:开启副本(id,nandu or 1) end
        end
    elseif 种族 == "魔" then
        if zhouji == 1 then 任务名称 = "泪痕碗之念" 开启函数 = function(id,nandu) 副本_泪痕碗之念:开启副本(id,nandu or 1) end
        elseif zhouji == 2 then 任务名称 = "轩辕剑之陨" 开启函数 = function(id,nandu) 副本_轩辕剑之陨:开启副本(id,nandu or 1) end
        elseif zhouji == 3 then 任务名称 = "玲珑结之愿" 开启函数 = function(id,nandu) 副本_玲珑结之愿:开启副本(id,nandu or 1) end
        elseif zhouji == 4 then 任务名称 = "墨魂笔之踪" 开启函数 = function(id,nandu) 副本_墨魂笔之踪:开启副本(id,nandu or 1) end
        elseif zhouji == 5 then 任务名称 = "月光草之逝" 开启函数 = function(id,nandu) 副本_月光草之逝:开启副本(id,nandu or 1) end
        elseif zhouji == 6 then 任务名称 = "鸿蒙石之鉴" 开启函数 = function(id,nandu) 副本_鸿蒙石之鉴:开启副本(id,nandu or 1) end
        elseif zhouji == 0 then 任务名称 = "千机锁之梏" 开启函数 = function(id,nandu) 副本_千机锁之梏:开启副本(id,nandu or 1) end
        end
    elseif 种族 == "人" then
        if zhouji == 1 then 任务名称 = "泪痕碗之念" 开启函数 = function(id,nandu) 副本_泪痕碗之念:开启副本(id,nandu or 1) end
        elseif zhouji == 2 then 任务名称 = "轩辕剑之陨" 开启函数 = function(id,nandu) 副本_轩辕剑之陨:开启副本(id,nandu or 1) end
        elseif zhouji == 3 then 任务名称 = "玲珑结之愿" 开启函数 = function(id,nandu) 副本_玲珑结之愿:开启副本(id,nandu or 1) end
        elseif zhouji == 4 then 任务名称 = "墨魂笔之踪" 开启函数 = function(id,nandu) 副本_墨魂笔之踪:开启副本(id,nandu or 1) end
        elseif zhouji == 5 then 任务名称 = "月光草之逝" 开启函数 = function(id,nandu) 副本_月光草之逝:开启副本(id,nandu or 1) end
        elseif zhouji == 6 then 任务名称 = "鸿蒙石之鉴" 开启函数 = function(id,nandu) 副本_鸿蒙石之鉴:开启副本(id,nandu or 1) end
        elseif zhouji == 0 then 任务名称 = "千机锁之梏" 开启函数 = function(id,nandu) 副本_千机锁之梏:开启副本(id,nandu or 1) end
        end
    end

    return 任务名称, 开启函数
end

function 辅助内挂类:初始化()
    self.对话单位= require("Script/对话处理类/怪物对话内容")()
    self.活动NPC对话 = require("Script/对话处理类/怪物对话处理")()
    self.time明雷 = {} --缩短间隔提高效率
    self.time明雷["2"]=true
    self.time明雷["5"]=true
    self.time明雷["8"]=true
    self.time明雷["11"]=true
    self.time明雷["14"]=true
    self.time明雷["17"]=true
    self.time明雷["20"]=true
    self.time明雷["23"]=true
    self.time明雷["26"]=true
    self.time明雷["29"]=true
    self.time明雷["32"]=true
    self.time明雷["35"]=true
    self.time明雷["38"]=true
    self.time明雷["41"]=true
    self.time明雷["44"]=true
    self.time明雷["47"]=true
    self.time明雷["50"]=true
    self.time明雷["53"]=true
    self.time明雷["56"]=true
    self.time明雷["59"]=true

    self.time活动 = {}
    self.time活动["1"]=true
    self.time活动["4"]=true
    self.time活动["7"]=true
    self.time活动["10"]=true
    self.time活动["13"]=true
    self.time活动["16"]=true
    self.time活动["19"]=true
    self.time活动["22"]=true
    self.time活动["25"]=true
    self.time活动["28"]=true
    self.time活动["31"]=true
    self.time活动["34"]=true
    self.time活动["37"]=true
    self.time活动["40"]=true
    self.time活动["43"]=true
    self.time活动["46"]=true
    self.time活动["49"]=true
    self.time活动["52"]=true
    self.time活动["55"]=true
    self.time活动["58"]=true

        self.time抓鬼 = {}
    self.time抓鬼["3"]=true
    self.time抓鬼["6"]=true
    self.time抓鬼["9"]=true
    self.time抓鬼["12"]=true
    self.time抓鬼["15"]=true
    self.time抓鬼["18"]=true
    self.time抓鬼["21"]=true
    self.time抓鬼["24"]=true
    self.time抓鬼["27"]=true
    self.time抓鬼["30"]=true
    self.time抓鬼["33"]=true
    self.time抓鬼["36"]=true
    self.time抓鬼["39"]=true
    self.time抓鬼["42"]=true
    self.time抓鬼["45"]=true
    self.time抓鬼["48"]=true
    self.time抓鬼["51"]=true
    self.time抓鬼["54"]=true
    self.time抓鬼["57"]=true
    self.time抓鬼["00"]=true

    self.明雷表={}
    self.活动表={}
    self.抓鬼表={}
    self.挂明雷={}
    self.挂活动={}
    self.挂抓鬼={}
    self:初始化明雷表()
    self:初始化活动表()
    self:初始化抓鬼表()

    -- 新增门派闯关次数记录表
    self.门派闯关次数 = {}
end

function 辅助内挂类:初始化明雷表() --最多47个（增加了2个细分项）
    self.明雷表={
        [1]={名称="下凡的灵猴",类型组={1176}},
        [2]={名称="三界财神爷",类型组={1177}},
        [3]={名称="夏日炎炎",类型组={1184}},
        [4]={名称="仙气十足",类型组={1504}},
        [5]={名称="琴声悠悠",类型组={1500}},
        [6]={名称="新春快乐",类型组={1501}},
        [7]={名称="龙神",类型组={1503}},

        [8]={名称="捣乱年兽",类型组={1515}},--2
        [9]={名称="知了先锋",类型组={1187}},--2
        [10]={名称="贺新年",类型组={1516}},--3
        [11]={名称="万象福",类型组={1517}},--3
        [12]={名称="巡山小妖",类型组={1528}},--3

        [13]={名称="魂殿使者",类型组={1185}},
        [14]={名称="魂殿殿主",类型组={1186}},--中等

        [15]={名称="白骨精",类型组={1529}},--4
        [16]={名称="狮驼国",类型组={1530}},--4
        [17]={名称="美猴王",类型组={1531}},--4
        [18]={名称="知了统领",类型组={1190}},

        [19]={名称="知了王",类型组={1527}},--5
        [20]={名称="糖果派对",类型组={1518}},--5
        [21]={名称="六欲心魔",类型组={1521}},--5
        [22]={名称="恭喜发财",类型组={1520}},--5

        [23]={名称="十二生肖",类型组={1178}},--1~5
        [24]={名称="魔化师傅",类型组={1522}},--6
        [25]={名称="四圣青龙",类型组={1523}},--6
        [26]={名称="四圣白虎",类型组={1524}},--6
        [27]={名称="四圣朱雀",类型组={1525}},--6
        [28]={名称="四圣玄武",类型组={1526}},--6

        [29]={名称="仙魔灵墟",类型组={1534}},--7
        [30]={名称="云生梦泽",类型组={1535}},--7
        [31]={名称="醉凡尘",类型组={1533}},--7

        [32]={名称="千机策",类型组={5559}},--8
        [33]={名称="云仙谣",类型组={5560}},--8
        [34]={名称="善恶如来",类型组={5558}},--8

        [35]={名称="灭世魔帝",类型组={5556}},--9
        [36]={名称="群雄逐鹿",类型组={5557}},--9
        [37]={名称="黑神话",类型组={5555}},--9

        [38]={名称="武神坛服战",类型组={1532}},

        -- ================== 核心修改区 ==================
        -- 天罡星拆分
        [39]={名称="天罡星(1-2星)", 类型组={748}, 难度范围={1,2}},
        [40]={名称="天罡星(3星+)",  类型组={748}, 难度范围={3,4,5,6,7}},

        -- 地煞星拆分
        [41]={名称="地煞星(1-2星)", 类型组={206}, 难度范围={1,2}},
        [42]={名称="地煞星(3星+)",  类型组={206}, 难度范围={3,4,5,6,7}},
        -- ================================================

        [43]={名称="客服小二",类型组={1510}},
        [44]={名称="斥候海妖",类型组={1199}},
        [45]={名称="长安保卫战",类型组={1313}},
        [46]={名称="盘龙岛小怪",类型组={1200}},
        [47]={名称="秽气源头",类型组={1307}},
        [48]={名称="东海秘境",类型组={0}, 特殊流程=true},
    }
end

-- ================== 修改：活动表增加神器任务难度勾选框 ==================
function 辅助内挂类:初始化活动表()
    -- 活动表现在包含：
    -- [1] 门派闯关
    -- [2] 游泳比赛
    -- [3] 神器任务(★)
    -- [4] 神器任务(★★)
    -- [5] 神器任务(★★★)
    -- [6] 神器任务(★★★★)
    -- [7] 神器任务(★★★★★)
    -- [8] 中秋逐月
    self.活动表={
        [1]={名称="门派闯关",类型组={0}},
        [2]={名称="游泳比赛",类型组={0}},
        [3]={名称="神器任务(★)",   类型组={0}, 神器难度=1},
        [4]={名称="神器任务(★★)", 类型组={0}, 神器难度=2},
        [5]={名称="神器任务(★★★)",类型组={0}, 神器难度=3},
        [6]={名称="神器任务(★★★★)",类型组={0}, 神器难度=4},
        [7]={名称="神器任务(★★★★★)",类型组={0}, 神器难度=5},
        [8]={名称="中秋逐月",类型组={0}},
    }
end

function 辅助内挂类:初始化抓鬼表()
    self.抓鬼表={
        [1]={名称="自动抓鬼",类型组={0}},
        [2]={名称="自动鬼王",类型组={0}},
    }
end

function 辅助内挂类:数据处理(序号, 内容)
    local 数字id = 内容.数字id + 0

    if 玩家数据[数字id].角色.月卡 == nil then
        玩家数据[数字id].角色.月卡 = {生效=false,到期时间=0}
    end

    if 玩家数据[数字id]==nil then return end
    if 序号 == 550 then
        self:置角色内挂数据(数字id)
        local ngvip = 玩家数据[数字id].角色.月卡.生效
        local data = table.copy(玩家数据[数字id].角色.内挂)
        发送数据(玩家数据[数字id].连接id, 550, {vip=ngvip, mlb=self.明雷表, hdb=self.活动表, zgb=self.抓鬼表,data=data})
    elseif 序号 == 551 then --保存配置
        self:置角色内挂数据(数字id)
        玩家数据[数字id].角色.内挂.明雷 = 内容.明雷
        玩家数据[数字id].角色.内挂.活动 = 内容.活动
        玩家数据[数字id].角色.内挂.抓鬼 = 内容.抓鬼
        local data = table.copy(玩家数据[数字id].角色.内挂)
        发送数据(玩家数据[数字id].连接id, 552, data)
    elseif 序号 == 552 then --开始、结束、挂机
        self:变更挂机(数字id,内容.界面,内容.变更)
    elseif 序号 == 553 then --关闭界面自动停止挂机
        if self.挂明雷[数字id]~=nil or self.挂活动[数字id]~=nil or self.挂抓鬼[数字id]~=nil then
            常规提示(数字id,"#Y/关闭界面自动#R/停止挂机")
        end
        self:关闭所有挂机(数字id)
    end
end


function 辅助内挂类:变更挂机(数字id,jm,bg)
    self:关闭其它挂机(数字id,jm)
    local abc = {"挂明雷","挂活动","挂抓鬼"}
    local wjb = {"明雷","活动","抓鬼"}
    for n=1,3 do
        if n==jm then
            if bg then
                if 玩家数据[数字id].角色.月卡.生效 then
                    if 玩家数据[数字id].队长 then
                        local go = false
                        local 队伍id = 玩家数据[数字id].队伍

                        -- ====================
                        -- 修复 BUG1：内层循环变量 n 改成 i，避免冲突！
                        -- ====================
                        for i=1,#队伍数据[队伍id].成员数据 do
                            local 成员ID = 队伍数据[队伍id].成员数据[i]
                            if 玩家数据[成员ID] and 玩家数据[成员ID].道具:取禁止飞行(成员ID) then
                                发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                                常规提示(数字id,format("#Y/%s#R/当前不能传送,禁止挂机",玩家数据[成员ID].角色.名称))
                                return
                            end
                        end

                        -- ====================
                        -- 修复 BUG2：内挂表安全获取，防止 nil 报错
                        -- ====================
                        local 角色 = 玩家数据[数字id].角色
                        local 内挂 = 角色.内挂 or {}
                        local 当前挂机配置 = 内挂[wjb[n]] or {}

                        for an=1,#当前挂机配置 do
                            if 当前挂机配置[an] then
                                go = true
                            end
                        end

                        if wjb[n] == "活动" then
                            local 提示 = ""
                            local 安全内挂活动 = 内挂.活动 or {}
                            for wjbk,wjbv in pairs(self.活动表) do
                                if 安全内挂活动[wjbk] then
                                    提示 = self:活动可进行(数字id,wjbv.名称,wjbv.神器难度)
                                    if 提示~=true then
                                        self.挂活动[数字id] = nil
                                        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                                        发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
                                        return
                                    end
                                end
                            end
                        elseif wjb[n] == "抓鬼" then
                            local 提示 = ""
                            local 安全内挂抓鬼 = 内挂.抓鬼 or {}
                            for wjbk,wjbv in pairs(self.抓鬼表) do
                                if 安全内挂抓鬼[wjbk] then
                                    提示 = self:抓鬼可进行(数字id,wjbv.名称)
                                    if 提示~=true then
                                        self.挂抓鬼[数字id] = nil
                                        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                                        发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
                                        return
                                    end
                                end
                            end
                        end

                        if go then
                            self[abc[n]][数字id] = {}
                            常规提示(数字id,"#G/已开始挂机。")
                        else
                            发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                            常规提示(数字id,"#Y/至少有一个选项才可挂机。")
                        end
                    else
                        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                        常规提示(数字id,"#Y/只有队长才可挂机。")
                    end
                else
                    self:关闭所有挂机(数字id)
                    发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                    常规提示(数字id,"#Y/你不是会员禁止挂机。")
                end
            else
                if self.挂明雷[数字id]~=nil or self.挂活动[数字id]~=nil or self.挂抓鬼[数字id]~=nil then
                    常规提示(数字id,"#Y/你已#R/停止挂机")
                end
                self:关闭所有挂机(数字id)

                发送数据(玩家数据[数字id].连接id, 551, {变更=false})
            end
            break
        end
    end
end

function 辅助内挂类:挂机定时器()
    if self.time明雷[服务端参数.秒] then
        for k,v in pairs(self.挂明雷) do
            if 玩家数据[k]==nil or 玩家数据[k].角色==nil or not 玩家数据[k].队长 or not 玩家数据[k].角色.月卡.生效 then
                self.挂明雷[k] = nil
                if 玩家数据[k]~=nil and 玩家数据[k].角色~=nil then
                    发送数据(玩家数据[k].连接id, 551, {变更=false})
                    常规提示(k,"#R/场景挂机已被强制停止")
                end
            else
                self:明雷寻怪(k)
            end
        end
    elseif self.time活动[服务端参数.秒] then
        for k,v in pairs(self.挂活动) do
            if 玩家数据[k]==nil or 玩家数据[k].角色==nil or not 玩家数据[k].队长 or not 玩家数据[k].角色.月卡.生效 then
                self.挂活动[k] = nil
                if 玩家数据[k]~=nil and 玩家数据[k].角色~=nil then
                    发送数据(玩家数据[k].连接id, 551, {变更=false})
                    常规提示(k,"#R/活动挂机已被强制停止")
                end
            else
                self:活动流程(k)
            end
        end
    elseif self.time抓鬼[服务端参数.秒] then
        for k,v in pairs(self.挂抓鬼) do
            if 玩家数据[k]==nil or 玩家数据[k].角色==nil or not 玩家数据[k].队长 or not 玩家数据[k].角色.月卡.生效 then
                self.挂抓鬼[k] = nil
                if 玩家数据[k]~=nil and 玩家数据[k].角色~=nil then
                    发送数据(玩家数据[k].连接id, 551, {变更=false})
                    常规提示(k,"#R/抓鬼挂机已被强制停止")
                end
            else
                self:抓鬼流程(k)
            end
        end
    end
end

function 辅助内挂类:明雷寻怪(数字id)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local data = 玩家数据[数字id].角色.内挂.明雷
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}

    if self:有人不可飞行(数字id) then
        return
    end

    local 找到目标 = false
    for k,v in pairs(self.明雷表) do
        -- 第一层：检查是否勾选
        if data[k] then

            -- 东海秘境不走通用的“任务数据找怪”流程，走独立的关卡推进逻辑
            if v.特殊流程 then
                找到目标 = self:东海秘境进程(数字id, k)
                break
            end

            -- =========================================================
            -- 逻辑块 A：次数检查（最高优先级）
            -- =========================================================
            local 次数已满 = false
            -- 修复：天罡星/地煞星拆分后名称与次数记录key不一致，需要映射回原始key
            local 次数查询名称 = v.名称
            if v.难度范围 ~= nil then
                if v.类型组[1] == 748 then
                    次数查询名称 = "天罡星"
                elseif v.类型组[1] == 206 then
                    次数查询名称 = "地煞星"
                end
            end
            if 判断限制次数(数字id, 次数查询名称) then
                玩家数据[数字id].角色.内挂.明雷[k] = false  -- 取消勾选
                local syncData = table.copy(玩家数据[数字id].角色.内挂)
                发送数据(玩家数据[数字id].连接id, 552, syncData) -- 同步界面
                次数已满 = true
            end

            -- 如果次数没满，才继续执行后续的找怪逻辑
            if not 次数已满 then

                -- 遍历任务数据，寻找该类型的怪物
                for kn,vn in pairs(任务数据) do
                    if not vn.zhandou then  -- 排除正在战斗的怪物
                        for cn=1,#v.类型组 do
                            if vn.类型 == v.类型组[cn] then

                                -- =========================================================
                                -- 逻辑块 B：难度过滤（如果配置了难度范围）
                                -- =========================================================
                                local 符合难度 = true
                                if v.难度范围 ~= nil then
                                    符合难度 = false -- 默认不符合
                                    for _, nd in pairs(v.难度范围) do
                                        if vn.难度 == nd then
                                            符合难度 = true
                                            break
                                        end
                                    end
                                end

                                -- 如果不符合难度（比如勾选1-2星，怪是3星），跳过这个怪
                                if not 符合难度 then
                                    break -- 跳出类型组循环，继续检查任务表里的下一个怪
                                end
                                -- =========================================================

                                -- 只有通过了上面的检查，才执行寻路/对话
                                if wj地图~= vn.地图编号 then
                                    地图处理类:跳转地图(数字id,vn.地图编号,vn.x,vn.y)
                                else
                                    if v.模式=="__GWdh" then
                                        local 对话内容 = __GWdh111[vn.类型](玩家数据[数字id].连接id,数字id,vn.序列,vn.id,vn.地图编号)
                                        if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                                            玩家数据[数字id].地图单位={地图=vn.地图编号,标识=vn.id,编号=vn.编号}
                                            __GWdh222[vn.类型](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                                        end
                                    else
                                        local 对话内容 = self.对话单位:活动对话NR(数字id,vn.单位编号,vn.id,vn.地图编号,vn.类型)
                                        if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                                            玩家数据[数字id].地图单位={地图=vn.地图编号,标识=vn.id,编号=vn.单位编号}
                                            self.活动NPC对话:活动对话CL(数字id,对话内容.名称,对话内容.选项[1],vn.类型,kn)
                                        end
                                    end
                                end
                                找到目标 = true
                                break -- 跳出类型组循环
                            end
                        end
                    end
                    if 找到目标 then break end
                end
            end
            -- =========================================================
        end
        if 找到目标 then break end
    end

    -- =========================================
    -- 自动停止挂机逻辑（原版逻辑保留）
    -- =========================================
    if not 找到目标 then
        local 是否全部完成 = true
        for k, v in pairs(玩家数据[数字id].角色.内挂.明雷) do
            if v == true then
                是否全部完成 = false
                break
            end
        end
        if 是否全部完成 then
            常规提示(数字id, "#Y所有明雷任务已完成，自动停止挂机")
            self.挂明雷[数字id] = nil
            发送数据(玩家数据[数字id].连接id, 551, {变更=false})
        end
    end
end

function 辅助内挂类:战斗失败记录(数字id,rwid)
    if 任务数据[rwid]==nil or 玩家数据[数字id]==nil or 玩家数据[数字id].角色.内挂==nil then return end
    if self.挂明雷[数字id]~=nil then
        for k,v in pairs(self.明雷表) do
            for an=1,#v.类型组 do
                if v.类型组[an]==任务数据[rwid].类型 then
                    local xbh = 任务数据[rwid].类型
                    if self.挂明雷[数字id][xbh]==nil then
                        self.挂明雷[数字id][xbh] = 0
                    end
                    self.挂明雷[数字id][xbh] = self.挂明雷[数字id][xbh] + 1
                    if self.挂明雷[数字id][xbh] >= 3 then
                        玩家数据[数字id].角色.内挂.明雷[k] = false
                        local data = table.copy(玩家数据[数字id].角色.内挂)
                        发送数据(玩家数据[数字id].连接id, 552, data)
                        常规提示(数字id,"#Y/与#R/" ..v.名称 .."#Y/的战斗死亡过多，自动剔除。")
                    end
                    return
                end
            end
        end
    end
end

-- ================== 修改：活动流程函数 ==================
function 辅助内挂类:活动流程(数字id) --单人处理
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local data = 玩家数据[数字id].角色.内挂.活动
    local 提示 = ""
    for k,v in pairs(self.活动表) do
        if data[k] then
            -- 神器任务需要传递难度参数
            local 难度参数 = v.神器难度
            提示 = self:活动可进行(数字id,v.名称,难度参数)
            if 提示 == true then
                if v.名称=="门派闯关" and 玩家数据[数字id].角色:取任务(107)~=0 then
                    self:门派闯关进程(数字id)
                elseif v.名称=="游泳比赛" and 玩家数据[数字id].角色:取任务(109)~=0 then
                    self:游泳活动进程(数字id)
                elseif v.名称=="中秋逐月" and 玩家数据[数字id].角色:取任务(56)~=0 then
                    self:中秋逐月进程(数字id)
                elseif v.名称 and v.名称:find("神器任务") then
                    self:神器任务进程(数字id, 难度参数)
                else
                    self:接活动任务(数字id,v.名称,难度参数)
                end
            else
                -- ==============================================
                -- 所有活动条件不满足时：取消勾选 + 停止挂机
                -- ==============================================
                玩家数据[数字id].角色.内挂.活动[k] = false
                local 同步数据 = table.copy(玩家数据[数字id].角色.内挂)
                发送数据(玩家数据[数字id].连接id, 552, 同步数据)
                self.挂活动[数字id] = nil
                发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
            end
            break
        end
    end
end

-- ================== 修改：接活动任务 ==================
function 辅助内挂类:接活动任务(数字id,hdmc,难度参数)
    local 队伍id = 玩家数据[数字id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
        if 玩家数据[队伍数据[队伍id].成员数据[n]].道具:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
            for k,v in pairs(self.活动表) do
                玩家数据[数字id].角色.内挂.活动[k]=nil
                self.活动表[数字id] = nil
            end
            发送数据(玩家数据[数字id].连接id, 551, {变更=false})
            常规提示(数字id,format("#Y/%s#R/当前不能传送,禁止挂机",玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称))
            return
        end
    end

    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    if hdmc=="门派闯关" then
        if wj地图 ~= 1001 then
            地图处理类:跳转地图(数字id,1001,132,91)
        else
            门派闯关:添加闯关任务(数字id)
        end
    elseif hdmc=="游泳比赛" then
        if wj地图 ~= 1092 then
            地图处理类:跳转地图(数字id,1092,141,60)
        else
            游泳活动:添加任务(数字id)
        end
    elseif hdmc=="中秋逐月" then
        if wj地图 ~= 1001 then
            地图处理类:跳转地图(数字id,1001,229,158)
        else
            中秋任务:设置中秋逐月任务(数字id)
        end
    elseif hdmc and hdmc:find("神器任务") then
        -- 神器任务接任务：传送到长安城传令天兵处
        if wj地图 ~= 1001 then
            地图处理类:跳转地图(数字id,1001,245,109)
        else
            self:接神器任务(数字id, 难度参数)
        end
    end
end

-- ================== 新增：接神器任务（修复BUG版） ==================
-- 修复：不再通过NPC对话接任务，而是直接调用开启副本函数
function 辅助内挂类:接神器任务(数字id, 难度)
    local 难度 = 难度 or 1
    local 任务名称, 开启函数 = 获取今日神器任务信息(数字id)

    if 任务名称 == "" or 开启函数 == nil then
        常规提示(数字id, "#Y/无法获取今日神器任务信息")
        return
    end

    -- 直接调用开启副本函数，不再通过NPC对话
    -- 开启副本函数内部会检查队伍条件
    开启函数(数字id, 难度)

    常规提示(数字id, "#G/已尝试接取神器任务：" .. 任务名称 .. "（难度：" .. 神器难度名称[难度] .. "）")
end

-- ================== 新增：神器任务进程（参考游泳比赛写法） ==================
function 辅助内挂类:神器任务进程(数字id, 难度)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end

    local 难度 = 难度 or 1

    -- 查找进行中的神器任务
    local 神器任务id = 0
    local 神器类型 = 0
    for _,类型 in ipairs(神器任务类型组) do
        local 任务id = 玩家数据[数字id].角色:取任务(类型)
        if 任务id ~= 0 and 任务id ~= nil then
            神器任务id = 任务id
            神器类型 = 类型
            break
        end
    end

    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}

    if 神器任务id ~= 0 and 任务数据[神器任务id] ~= nil then
        -- 有进行中的神器任务，执行流程
        self:执行神器任务流程(数字id, 神器任务id, 神器类型)
    else
        -- 没有神器任务，去传令天兵处接任务
        if wj地图 ~= 1001 then
            地图处理类:跳转地图(数字id,1001,245,109)
        else
            self:接神器任务(数字id, 难度)
        end
    end
end

-- ================== 新增：执行神器任务流程 ==================
function 辅助内挂类:执行神器任务流程(数字id, 任务id, 任务类型)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号

    -- 神器任务通常需要与特定NPC对话或进入战斗
    -- 根据任务数据中的信息，查找当前需要交互的NPC

    -- 优先查找与任务相关的NPC（通过任务类型匹配）
    local 目标NPC = nil

    -- 遍历当前地图的单位，寻找与神器任务相关的NPC
    if 地图处理类.地图单位[wj地图] then
        for k,v in pairs(地图处理类.地图单位[wj地图]) do
            if 任务数据[v.id] ~= nil then
                -- 检查是否是当前神器任务相关的NPC
                local npc类型 = 任务数据[v.id].类型
                -- 神器任务相关类型范围：1550-1700+
                if npc类型 and npc类型 >= 1550 and npc类型 <= 1750 then
                    -- 检查是否是当前任务需要的NPC
                    if self:是神器任务目标NPC(数字id, v.id, 任务id) then
                        目标NPC = v
                        break
                    end
                end
            end
        end
    end

    if 目标NPC then
        -- 与目标NPC对话
        local 对话内容 = self.对话单位:活动对话NR(数字id,任务数据[目标NPC.id].单位编号,目标NPC.id,任务数据[目标NPC.id].地图编号,任务数据[目标NPC.id].类型)
        if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
            玩家数据[数字id].地图单位={地图=任务数据[目标NPC.id].地图编号,标识=目标NPC.id,编号=任务数据[目标NPC.id].单位编号}
            self.活动NPC对话:活动对话CL(数字id,对话内容.名称,对话内容.选项[1],任务数据[目标NPC.id].类型,目标NPC.id)
        end
    else
        -- 没有找到目标NPC，可能需要传送到其他地图
        -- 根据任务进程判断下一步去哪里
        self:神器任务寻路(数字id, 任务id, 任务类型)
    end
end

-- ================== 新增：判断是否是神器任务目标NPC ==================
function 辅助内挂类:是神器任务目标NPC(数字id, npcid, 任务id)
    if 任务数据[npcid] == nil then return false end

    local npc数据 = 任务数据[npcid]

    -- 检查NPC是否属于当前玩家的神器任务
    -- 通过副本id或队伍组来判断
    if npc数据.副本id and npc数据.副本id == 数字id then
        return true
    end

    -- 检查NPC类型是否与任务相关
    if npc数据.类型 and npc数据.类型 >= 1550 and npc数据.类型 <= 1750 then
        return true
    end

    -- 检查是否是任务相关的特殊NPC（如战斗NPC）
    if npc数据.名称 and (npc数据.名称:find("形迹可疑") or npc数据.名称:find("神器") or npc数据.名称:find("副本")) then
        return true
    end

    return false
end

-- ================== 新增：神器任务寻路 ==================
function 辅助内挂类:神器任务寻路(数字id, 任务id, 任务类型)
    -- 根据神器任务类型和进程，决定传送到哪个地图
    -- 这里使用简化的逻辑：传送到任务数据指定的地图

    if 任务数据[任务id] == nil then return end

    local 任务数据副本 = 任务数据[任务id]

    -- 如果有指定地图，传送到那里
    if 任务数据副本.地图编号 then
        local 目标地图 = 任务数据副本.地图编号
        local 目标x = 任务数据副本.x or 50
        local 目标y = 任务数据副本.y or 50

        local wj地图 = 玩家数据[数字id].角色.地图数据.编号
        if wj地图 ~= 目标地图 then
            地图处理类:跳转地图(数字id, 目标地图, 目标x, 目标y)
        end
    else
        -- 默认传送到长安城
        local wj地图 = 玩家数据[数字id].角色.地图数据.编号
        if wj地图 ~= 1001 then
            地图处理类:跳转地图(数字id, 1001, 245, 109)
        end
    end
end

-- ================== 修改：活动可进行函数 ==================
-- 新增：支持神器任务难度参数
function 辅助内挂类:活动可进行(数字id,hdmc,难度参数)
    if hdmc=="门派闯关" then
        local 活动开关 = 门派闯关:取活动开关()
        if 活动开关 and 玩家数据[数字id].角色:取任务(107)~=0 then
            local 队长任务=玩家数据[数字id].角色:取任务(107)
            if 队长任务~=0 then
                local 当前=任务数据[队长任务].当前序列
                local 队伍id=玩家数据[数字id].队伍
                for n=1,#队伍数据[队伍id].成员数据 do
                    local cyid=队伍数据[队伍id].成员数据[n]
                    local 队员任务=玩家数据[cyid].角色:取任务(107)
                    if 队员任务~=0 then
                        if 当前~= 任务数据[队员任务].当前序列 then
                            return "队友。"..玩家数据[cyid].角色.名称.."任务NPC与队长不一致"
                        end
                    else
                        return "队友。"..玩家数据[cyid].角色.名称.."没有领取任务"
                    end
                end
            end
            return true
        elseif 活动开关 then --无任务
            if 玩家数据[数字id].队伍==0 then
                return "少侠别拿我开玩笑了……你连队伍都没有？"
            elseif 玩家数据[数字id].队伍==0 or 取队伍人数(数字id)<3 or 取队伍最低等级(玩家数据[数字id].队伍,40) then
                return "门派闯关参与条件：≥40级，≥3人"
            elseif 玩家数据[数字id].队长==false then
                return "这种重要的事情还是让队长来吧！"
            else
                local 队伍id=玩家数据[数字id].队伍
                for n=1,#队伍数据[队伍id].成员数据 do
                    local cyid=队伍数据[队伍id].成员数据[n]
                    if 门派闯关.数据[cyid] then
                        if  门派闯关.数据[cyid].取消~=nil and 门派闯关.数据[cyid].取消 > os.time() then
                            return 玩家数据[cyid].角色.名称.."在五分钟内取消过任务，需等待五分钟后才可以继续任务哦。"
                        elseif 门派闯关.数据[cyid].次数>=2 then
                            return 玩家数据[cyid].角色.名称.."今日已经完成了两轮，无法再继续领取今日门派闯关任务了！"
                        end
                    end
                    if 玩家数据[cyid].角色:取任务(107)~=0 then
                        return 玩家数据[cyid].角色.名称.."已经领取过任务了"
                    end
                end
            end
            return true
        else
            return "门派闯关未开启"
        end
    elseif hdmc=="游泳比赛" then
        local 活动开关 = 游泳活动:取活动开关()
        if 活动开关 and 玩家数据[数字id].角色:取任务(109)~=0 then
            return true
        elseif 活动开关 then --无任务
            if 玩家数据[数字id].队伍==0 then
                return "此活动最少需要三人组队参加。"
            elseif 取队伍人数(数字id) < 3 then
                return "此活动最少需要三人组队参加。"
            elseif 取等级要求(数字id,30)==false then
                return "游泳比赛活动要求最低等级不能小于30级，队伍中有成员等级未达到此要求。"
            else
                local 队伍id=玩家数据[数字id].队伍
                for n=1,#队伍数据[队伍id].成员数据 do
                    local 队员id = 队伍数据[队伍id].成员数据[n]
                    if 玩家数据[队员id].角色:取任务(109)~=0 then
                        return "#Y/" ..玩家数据[队员id].角色.名称 .."已经领取过任务了"
                    elseif 游泳活动.数据[队员id]~=nil and 游泳活动.数据[队员id]>=3 then
                        return "#Y/"..玩家数据[队员id].角色.名称.."本日已完成了3轮无法参加游泳比赛了"
                    end
                end
                return true
            end
        else
            return "游泳比赛未开启"
        end
    elseif hdmc=="中秋逐月" then
        if 玩家数据[数字id].角色:取任务(56)~=0 then
            return true
        elseif 玩家数据[数字id].队伍==0 then
            return "此活动可以组队完成,请最少5人组队参加"
        elseif 取等级要求(数字id,50)==false then
            return "参与此任务需要全队等级达到50级"
        else
            local 队伍id=玩家数据[数字id].队伍
            for n=1,#队伍数据[队伍id].成员数据 do
                local 队员id = 队伍数据[队伍id].成员数据[n]
                if 玩家数据[队员id].角色:取任务(56)~=0 then
                    return "#Y/" ..玩家数据[队员id].角色.名称 .."已经领取过任务了"
                elseif (活动次数数据.中秋任务.完成[队员id] or 0)>=1 then
                    return "#Y/"..玩家数据[队员id].角色.名称.."本日中秋次数已达上限"
                end
            end
            return true
        end
    elseif hdmc and hdmc:find("神器任务") then
        -- 获取今日神器任务信息
        local 任务名称, 开启函数 = 获取今日神器任务信息(数字id)

        if 任务名称 == "" then
            return "#Y/无法获取今日神器任务信息"
        end

        -- 检查是否已完成今日神器任务
        if 副本数据.神器任务 and 副本数据.神器任务.完成 and 副本数据.神器任务.完成[数字id] then
            return "#Y/今日已完成神器任务（" .. 任务名称 .. "）"
        end

        -- 检查是否已有进行中的神器任务
        local 已有任务 = false
        for _,类型 in ipairs(神器任务类型组) do
            if 玩家数据[数字id].角色:取任务(类型) ~= 0 then
                已有任务 = true
                break
            end
        end

        if 已有任务 then
            return true
        end

        -- 检查队伍条件
        if 玩家数据[数字id].队伍==0 then
            return "#Y/该任务必须组队完成且由队长领取"
        elseif 玩家数据[数字id].队长==false then
            return "#Y/只有队长才能领取神器任务"
        elseif 取队伍人数(数字id) < 5 then
            return "#Y/神器任务需要5人队伍"
        elseif 取等级要求(数字id,69)==false then
            return "#Y/神器任务要求等级不低于69级"
        else
            -- 检查队友是否已完成或已有任务
            local 队伍id = 玩家数据[数字id].队伍
            for n=1,#队伍数据[队伍id].成员数据 do
                local 临时id = 队伍数据[队伍id].成员数据[n]
                if 副本数据.神器任务 and 副本数据.神器任务.完成 and 副本数据.神器任务.完成[临时id] then
                    return "#Y/"..玩家数据[临时id].角色.名称.."本日已经完成过神器任务了"
                end
                for _,类型 in ipairs(神器任务类型组) do
                    if 玩家数据[临时id].角色:取任务(类型) ~= 0 then
                        return "#Y/"..玩家数据[临时id].角色.名称.."正在进行神器任务"
                    end
                end
            end
            return true
        end
    end
    return "活动未开启"
end

function 辅助内挂类:游泳活动进程(数字id)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local 任务id = 玩家数据[数字id].角色:取任务(109)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local jr地图 = 游泳坐标[任务数据[任务id].序列]
    if 任务数据[任务id]~=nil then
        if wj地图 ~= 游泳坐标[任务数据[任务id].序列].z or 取两点距离(比较xy,jr地图) > 20 then
            地图处理类:跳转地图(数字id,jr地图.z,jr地图.x,jr地图.y)
        else
            local jrmc = 任务数据[任务id].序列 .."号裁判"
            for k,v in pairs(地图处理类.地图单位[wj地图]) do
                if 任务数据[v.id]~=nil and 任务数据[v.id].名称 == jrmc and 任务数据[v.id].序列 == 任务数据[任务id].序列 then
                    local 对话内容 = self.对话单位:活动对话NR(数字id,任务数据[v.id].单位编号,任务数据[v.id].id,任务数据[v.id].地图编号,任务数据[v.id].类型)
                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                        玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].序列}
                        self.活动NPC对话:活动对话CL(数字id,对话内容.名称,对话内容.选项[1],任务数据[v.id].类型,任务数据[v.id].id)
                    end
                    break
                end
            end
        end
    end
end

function 辅助内挂类:中秋逐月进程(数字id)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local 任务id = 玩家数据[数字id].角色:取任务(56)
    if 任务id==0 or 任务数据[任务id]==nil then return end
    local 进程 = 任务数据[任务id].进程
    if Q_中秋逐月数据[进程]==nil then return end
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local jr地图 = {z=Q_中秋逐月数据[进程][1],x=Q_中秋逐月数据[进程][2],y=Q_中秋逐月数据[进程][3]}
    if wj地图 ~= jr地图.z or 取两点距离(比较xy,jr地图) > 20 then
        地图处理类:跳转地图(数字id,jr地图.z,jr地图.x,jr地图.y)
    else
        for k,v in pairs(地图处理类.地图单位[wj地图]) do
            if 任务数据[v.id]~=nil and 任务数据[v.id].类型==56 and 任务数据[v.id].序号 == 进程 then
                local 对话内容 = self.对话单位:活动对话NR(数字id,任务数据[v.id].单位编号,任务数据[v.id].id,任务数据[v.id].地图编号,任务数据[v.id].类型)
                if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                    玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].序号}
                    self.活动NPC对话:活动对话CL(数字id,对话内容.名称,对话内容.选项[1],任务数据[v.id].类型,任务数据[v.id].id)
                end
                break
            end
        end
    end
end

function 辅助内挂类:门派闯关进程(数字id)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local 任务id = 玩家数据[数字id].角色:取任务(107)

    -- 每次进入进程都增加次数计数
    -- if self.门派闯关次数[数字id] == nil then
    --     self.门派闯关次数[数字id] = 0
    -- end
    -- self.门派闯关次数[数字id] = self.门派闯关次数[数字id] + 1

    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local 提示 = self:活动可进行(数字id,"门派闯关")
    if 提示~=true then
        self.挂活动[数字id] = nil
        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
        发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
        return
    end
    if 任务数据[任务id]~=nil then
        local n = 任务数据[任务id].当前序列
        local data = Q_闯关数据[Q_门派编号[n]]
        local qmpdt = 取门派地图(Q_门派编号[n])
        local jr地图 = {z=qmpdt[1],x=data.x,y=data.y}
        if data then
            if wj地图 ~= jr地图.z or 取两点距离(比较xy,jr地图) > 20 then
                地图处理类:跳转地图(数字id,jr地图.z,jr地图.x,jr地图.y)
            else
                for k,v in pairs(地图处理类.地图单位[wj地图]) do
                    local npcmc = Q_门派编号[n] .."护法"
                    if v.名称 == npcmc then
                        local 对话内容 = self.对话单位:活动对话NR(数字id,任务数据[v.id].单位编号,任务数据[v.id].id,任务数据[v.id].地图编号,任务数据[v.id].类型)
                        if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                            玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].序列}
                            __GWdh222[106](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                        end
                        break
                    end
                end
            end
        end
    end
end

-- 东海秘境挂机：场景挂机(明雷)的特殊流程，按当前关卡自动前往对应假人坐标，依次挑战第1~25关
-- 返回 true 表示本次已处理（占用本轮挂机行为），供 明雷寻怪 的“找到目标”判定使用
function 辅助内挂类:东海秘境进程(数字id, k)
    local function 取消挂机(提示)
        常规提示(数字id,提示)
        玩家数据[数字id].角色.内挂.明雷[k] = false
        local syncData = table.copy(玩家数据[数字id].角色.内挂)
        发送数据(玩家数据[数字id].连接id, 552, syncData)
        return true
    end

    if self:有人不可飞行(数字id) then return true end
    if 玩家数据[数字id].队伍==0 then
        return 取消挂机("#Y/东海秘境需要组队才能挂机")
    end

    local 队伍id = 玩家数据[数字id].队伍
    local 今日日期 = tonumber(os.date("%Y%m%d"))
    local 秘境 = 玩家数据[数字id].角色.暑期活动.秘境
    local 当前关卡 = (秘境.日期==今日日期) and 秘境.关卡 or 0

    if 当前关卡 >= 25 then
        return 取消挂机("#Y/今日东海秘境挑战已全部完成，自动停止挂机")
    end

    -- 队伍进度需与队长一致，避免打乱队友已有进度
    for n=1,#队伍数据[队伍id].成员数据 do
        local cyid = 队伍数据[队伍id].成员数据[n]
        local cy秘境 = 玩家数据[cyid].角色.暑期活动.秘境
        local cy关卡 = (cy秘境.日期==今日日期) and cy秘境.关卡 or 0
        if cy关卡 ~= 当前关卡 then
            return 取消挂机(format("#Y/队友%s的东海秘境进度与队长不一致，已停止挂机",玩家数据[cyid].角色.名称))
        end
    end

    local 目标关卡 = 当前关卡 + 1
    local 坐标 = 东海秘境坐标[目标关卡]
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}

    if wj地图 ~= 11261 or 取两点距离(比较xy,坐标) > 20 then
        地图处理类:跳转地图(数字id,11261,坐标.x,坐标.y)
    else
        for n=1,#队伍数据[队伍id].成员数据 do
            local cyid = 队伍数据[队伍id].成员数据[n]
            local cy秘境 = 玩家数据[cyid].角色.暑期活动.秘境
            if cy秘境.日期 ~= 今日日期 then
                cy秘境.关卡 = 0
                cy秘境.日期 = 今日日期
                cy秘境.效果 = "无"
                cy秘境.技能 = {[1]="无",[2]="无",[3]="无",[4]="无"}
            end
        end
        战斗准备类:创建战斗(数字id,120042+目标关卡)
    end
    return true
end

function 辅助内挂类:抓鬼流程(数字id)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    if self:有人不可飞行(数字id) then
        return
    end
    local data = 玩家数据[数字id].角色.内挂.抓鬼
    for k,v in pairs(self.抓鬼表) do
        if data[k] then
            -- ======================
            -- 次数满了 → 取消勾选 + 同步客户端 + 停止挂机
            -- ======================
 -- 【修改后】
                if v.名称 == "自动抓鬼" then
                    -- 如果身上还有进行中的抓鬼任务，先打完再检查次数
                    local 当前任务id = 玩家数据[数字id].角色:取任务(8)
                    if 当前任务id == 0 then
                        -- 没有任务时才检查次数限制
                        if 取任务次数限制(数字id, "抓鬼记录") then
                            玩家数据[数字id].角色.内挂.抓鬼[k] = false
                            local 同步数据 = table.copy(玩家数据[数字id].角色.内挂)
                            发送数据(玩家数据[数字id].连接id, 552, 同步数据)
                            self.挂抓鬼[数字id] = nil
                            发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                            常规提示(数字id, "#Y/抓鬼次数已满，已自动停止挂机")
                            return
                        end
                    end
                    self:普通抓鬼流程(数字id)

                    elseif v.名称 == "自动鬼王" then
                        local 当前任务id = 玩家数据[数字id].角色:取任务(14)
                        if 当前任务id == 0 then
                            if 判断限制次数(数字id,"自动鬼王") then
                                玩家数据[数字id].角色.内挂.抓鬼[k] = false
                                local 同步数据 = table.copy(玩家数据[数字id].角色.内挂)
                                发送数据(玩家数据[数字id].连接id, 552, 同步数据)
                                self.挂抓鬼[数字id] = nil
                                发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                                常规提示(数字id, "#Y/鬼王次数已满，已自动停止挂机")
                                return
                            end
                        end
                        self:自动鬼王流程(数字id)
            end
            break
        end
    end
end

function 辅助内挂类:普通抓鬼流程(数字id)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local 任务id = 玩家数据[数字id].角色:取任务(8)
    local 钟馗xy=取假人表(1122,1)
    local jr地图= {z=1122,x=钟馗xy.X,y=钟馗xy.Y}
    if 任务id==0 then
        if wj地图 ~= 1122 or 取两点距离(比较xy,jr地图) > 20 then
            地图处理类:跳转地图(数字id,jr地图.z,jr地图.x,jr地图.y)
        else
            设置任务8(数字id)
        end
    else
        local jg地图 = {z=任务数据[任务id].地图编号,x=任务数据[任务id].x,y=任务数据[任务id].y}
        if wj地图 ~= jg地图.z or 取两点距离(比较xy,jg地图) > 20 then
            地图处理类:跳转地图(数字id,jg地图.z,jg地图.x,jg地图.y)
        else
            for k,v in pairs(地图处理类.地图单位[jg地图.z]) do
                if v.id == 任务id then
                    local 对话内容 = __GWdh111[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,任务数据[v.id].序列,任务数据[v.id].id,jg地图.z)
                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                        玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].编号}
                        __GWdh222[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                    end
                    break
                end
            end
        end
    end
end

function 辅助内挂类:自动鬼王流程(数字id)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local 任务id=玩家数据[数字id].角色:取任务(14)
    if 任务id==0 then
        if wj地图 ~= 1125 then
            地图处理类:跳转地图(数字id,1125,35,27)
        else
            设置任务14(数字id)
        end
    else
        local jg地图 = {z=任务数据[任务id].地图编号,x=任务数据[任务id].x,y=任务数据[任务id].y}
        if wj地图 ~= jg地图.z or 取两点距离(比较xy,jg地图) > 20 then
            地图处理类:跳转地图(数字id,jg地图.z,jg地图.x,jg地图.y)
        else
            for k,v in pairs(地图处理类.地图单位[jg地图.z]) do
                if v.id == 任务id then
                    local 对话内容 = __GWdh111[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,任务数据[v.id].序列,任务数据[v.id].id,jg地图.z)
                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                        玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].编号}
                        __GWdh222[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                    end
                    break
                end
            end
        end
    end
end

function 辅助内挂类:抓鬼可进行(数字id,mc)
    if mc == "自动抓鬼" then
        if 玩家数据[数字id].队伍==0 or 玩家数据[数字id].队长==false  then
            return "#Y/该任务必须组队完成且由队长领取"
        elseif 取队伍最低等级(玩家数据[数字id].队伍,20) then
            return "#Y/等级小于20级的玩家无法领取此任务"
        elseif 取队伍任务(玩家数据[数字id].队伍,8) then
            return "#Y/队伍中已有队员领取过此任务了"
        end
        -- 次数检查（使用全局次数限制）
        if 取任务次数限制(数字id, "抓鬼记录") then
            return "#Y/今日抓鬼次数已达上限，无法继续挂机"
        end
    elseif mc == "自动鬼王" then
        if 玩家数据[数字id].队伍==0 or 玩家数据[数字id].队长==false  then
            return "#Y/该任务必须组队完成且由队长领取"
        elseif 取队伍最低等级(玩家数据[数字id].队伍,100) then
            return "#Y/等级小于100级的玩家无法领取此任务"
        elseif 取队伍任务(玩家数据[数字id].队伍,14) then
            return "#Y/队伍中已有队员领取过此任务了"
        end
        -- 次数检查
        if 判断限制次数(数字id,"自动鬼王")  then
            return "#Y/今日鬼王次数已达上限，无法继续挂机"
        end
    end
    return true
end

function 辅助内挂类:有人不可飞行(数字id)
    if not 玩家数据[数字id].队长 then
        常规提示(数字id,"你不是队长")
        return true
    end
    local 队伍id = 玩家数据[数字id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
        if 玩家数据[队伍数据[队伍id].成员数据[n]].道具:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
            常规提示(数字id,format("#Y/%s#R/当前不能传送,禁止挂机",玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称))
            return true
        end
    end
    return false
end

function 辅助内挂类:是否明雷挂机中(数字id)
    if self.挂明雷[数字id]~=nil then
        return true
    end
    return false
end

function 辅助内挂类:是否挂机中(数字id)
    if self.挂明雷[数字id]~=nil or self.挂活动[数字id]~=nil or self.挂抓鬼[数字id]~=nil then
        return true
    end
    return false
end

function 辅助内挂类:关闭其它挂机(数字id,jm)
    local abc = {"挂明雷","挂活动","挂抓鬼"}
    for n=1,3 do
        if n~=jm and self[abc[n]][数字id]~=nil then
            self[abc[n]][数字id] = nil
        end
    end
end

function 辅助内挂类:关闭所有挂机(数字id)
    if self.挂明雷[数字id]~=nil then
        self.挂明雷[数字id] = nil
    end
    if self.挂活动[数字id]~=nil then
        self.挂活动[数字id] = nil
    end
    if self.挂抓鬼[数字id]~=nil then
        self.挂抓鬼[数字id] = nil
    end
end

function 辅助内挂类:置角色内挂数据(数字id)
    if 玩家数据[数字id].角色.内挂==nil then
        玩家数据[数字id].角色.内挂={}
    end
    if 玩家数据[数字id].角色.内挂.明雷==nil then
        玩家数据[数字id].角色.内挂.明雷={}
    end
    if 玩家数据[数字id].角色.内挂.活动==nil then
        玩家数据[数字id].角色.内挂.活动={}
    end
    if 玩家数据[数字id].角色.内挂.抓鬼==nil then
        玩家数据[数字id].角色.内挂.抓鬼={}
    end
    for n=1,50 do
        if self.明雷表[n]~=nil then
            if 玩家数据[数字id].角色.内挂.明雷[n]==nil then
                玩家数据[数字id].角色.内挂.明雷[n] = false
            end
        else
            玩家数据[数字id].角色.内挂.明雷[n] = nil
        end
        if self.活动表[n]~=nil then
            if 玩家数据[数字id].角色.内挂.活动[n]==nil then
                玩家数据[数字id].角色.内挂.活动[n] = false
            end
        else
            玩家数据[数字id].角色.内挂.活动[n] = nil
        end
        if self.抓鬼表[n]~=nil then
            if 玩家数据[数字id].角色.内挂.抓鬼[n]==nil then
                玩家数据[数字id].角色.内挂.抓鬼[n] = false
            end
        else
            玩家数据[数字id].角色.内挂.抓鬼[n] = nil
        end
    end
end

return 辅助内挂类
