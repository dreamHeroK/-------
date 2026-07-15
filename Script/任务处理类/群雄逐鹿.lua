-- @Author: baidwwy
-- @Date:   2025-03-21 12:37:26
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-03-17 07:52:24

local 群雄逐鹿 = class()

function 群雄逐鹿:初始化()
    self.已刷time = 0
    --self.锦衣 = {"青花瓷", "花间梦", "鹿角弯弯", "从军行", "水云归", "飞天舞", "羽仙歌"}
end

function 群雄逐鹿:活动定时器()
    if 服务端参数.分钟 + 0 == 29 and os.time() - self.已刷time >= 0 then
        self.已刷time = os.time() + 99 --秒防重复刷
        self:刷出怪物()
    end
end

function 群雄逐鹿:刷出怪物()
    local 已刷图 = {}
    local 地图组 = {1142, 1138, 1198, 1002, 1135, 1144, 1139, 1131, 1512, 1122, 1140, 1111, 1150, 1146, 1116, 1251, 1580}
-- 新增：复制地图组为“可用地图”，选过的地图会被移除，避免重复
    local 可用地图 = {}
    for i = 1, #地图组 do
          可用地图[i] = 地图组[i]-----数量再下面框里改
    end
    local 星刷数 = {[1] = 3, [2] = 3, [3] = 2, [4] = 2, [5] = 2, [6] = 2, [7] = 1, [8] = 1, [9] = 1}
    local 名称组 = {"群雄逐鹿·1★", "群雄逐鹿·2★", "群雄逐鹿·3★", "群雄逐鹿·4★", "群雄逐鹿·5★", "群雄逐鹿·6★", "群雄逐鹿·7★", "群雄逐鹿·8★", "群雄逐鹿·9★"} --1到9星名称
    for an = 1, 9 do---这里不是数量，是1-9星读取列表循环
        for bn = 1, 星刷数[an] do
--local 地图 = 地图组[取随机数(1, #地图组)]
-- 替换成：从“可用地图”里选，选完就移除（避免重复）
    local 地图索引 = 取随机数(1, #可用地图) -- 随机选一个“可用地图”的索引
    local 地图 = 可用地图[地图索引] -- 拿到对应的地图
          table.remove(可用地图, 地图索引) -- 把这个地图从“可用地图”里删掉，下次不会再选
    local 地图名称 = 取地图名称(地图)
          已刷图[地图] = 地图名称
    local xy = 地图处理类.地图坐标[地图]:取随机点()

            任务id = 取唯一任务(5557)
            任务数据[任务id] = {
                id = 任务id,
                起始 = os.time(),
                结束 = 3600,
                玩家id = 0,
                显示饰品 = true,
                名称 = 名称组[an],
                模型 = "神武",
                难度 = an,
                销毁 = true,
                行走开关=true,
                x = xy.x,
                y = xy.y,
                地图编号 = 地图,
                地图名称 = 地图名称,
                类型 = 5557
            }
            地图处理类:添加单位(任务id)
        end
    end
    local tsdt = ""
    for k, v in pairs(已刷图) do
        tsdt = tsdt .. v .. "、"
    end
    广播消息({内容 = format("#P(群雄逐鹿)#W威震凌霄的神武大帝率领四天帝#Y/群雄逐鹿#W/又现身于#G/" .. tsdt .. "#W/请本服最强的英雄去与之一战，名动三界！#R(难度9)#W#24", dtmc), 频道 = "xt"})
    --广播消息({内容 = format("#P(群雄逐鹿)#W传闻中灭杀三界的#Y/群雄逐鹿#W/又现身于#G/" .. tsdt .. "#W/请本服最强的英雄去与之一战，名动三界！#24", dtmc), 频道 = "xt"})
end

function 群雄逐鹿:怪物对话内容(id, 序列, 标识, 地图)
    local 对话数据 = {}
    对话数据.模型 = 任务数据[标识].模型
    对话数据.名称 = 任务数据[标识].名称
    对话数据.难度 = 任务数据[标识].难度
    if 任务数据[标识].zhandou == nil then
        对话数据.对话 = "我乃#Y/" .. 对话数据.难度 .. "星#W/群雄逐鹿，杀一是为罪，屠万即为雄，汝可敢一战？"
        对话数据.选项 = {"挑战极限", "我绕着走"}
    else
        对话数据.对话 = "我正在战斗中，请勿打扰。"
    end
    ----------------
     if 判断限制次数(id,"群雄逐鹿") then----限制刷怪
        对话数据.对话="玩家"..判断限制次数(id,"群雄逐鹿").."今日已经超过次数了"
        对话数据.选项=nil
     end
     -----------------------------
    return 对话数据
end

function 群雄逐鹿:对话事件处理(id, 名称, 事件, 类型, rwid)
    if 任务数据[rwid].zhandou ~= nil then 常规提示(id, "#Y/对方正在战斗中") return end
    if 玩家数据[id].队伍 == 0 then 常规提示(id, "#Y/你必须组队才能挑战我！") return end
    if 取队伍人数(id) < 1 and 调试模式 == false then 常规提示(id, "#Y挑战我最少必须由五人进行") return end
    if 取等级要求(id, 60) == false and 调试模式 == false then 常规提示(id, "#Y/队伍中有成员等级不符合要求") return end
    if 事件 == "挑战极限" then
        战斗准备类:创建战斗(id, 160057, rwid)
        任务数据[rwid].zhandou = true
    end
end

function 群雄逐鹿:战斗胜利处理(id组, 战斗类型, 任务id)
    local id = id组[1]
    if 任务数据[任务id] == nil then
        return
    end
    local 难度 = 任务数据[任务id].难度
    添加完成次数(id,"群雄逐鹿")  -----限制刷怪
    for n = 1, #id组 do
        local cyid = id组[n]
        local 等级 = 玩家数据[cyid].角色.等级
        local 经验 = 等级 * 取随机数(2200, 2700) + 难度 * 100000
        local 银子 = 等级 * 1200 + 难度 * 120000
        local 仙玉 = 取随机数(7,12)*难度+50
        local 活跃=2*难度
        玩家数据[id].角色:添加仙玉(仙玉,"群雄逐鹿",1)
        玩家数据[cyid].角色:添加经验(经验 * HDPZ["群雄逐鹿：星级1"].经验, "群雄逐鹿", 1)
        玩家数据[cyid].角色:添加银子(银子 * HDPZ["群雄逐鹿：星级1"].银子, "群雄逐鹿", 1)
        添加活跃(cyid,活跃)
        if 难度 == 1 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级1"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿1星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级1"].ITEM), "群雄逐鹿：星级1")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 2 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级2"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿2星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级2"].ITEM), "群雄逐鹿：星级2")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 3 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级3"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿3星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级3"].ITEM), "群雄逐鹿：星级3")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 4 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级4"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿4星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级4"].ITEM), "群雄逐鹿：星级4")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 5 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级5"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿5星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级5"].ITEM), "群雄逐鹿：星级5")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 6 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级6"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿6星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级6"].ITEM), "群雄逐鹿：星级6")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 7 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级7"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿7星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级7"].ITEM), "群雄逐鹿：星级7")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 8 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级8"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿8星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级8"].ITEM), "群雄逐鹿：星级8")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        elseif 难度 == 9 then
            if 取随机数() <= HDPZ["群雄逐鹿：星级9"].爆率 then
                local 链接 = {提示 = format("#S(群雄逐鹿9星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的", 任务数据[任务id].名称, 玩家数据[cyid].角色.名称), 频道 = "xt", 结尾 = "#Y一个。#24"}
                local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["群雄逐鹿：星级9"].ITEM), "群雄逐鹿：星级9")
                if 数量 == 9999 then --环
                    玩家数据[cyid].道具:给予道具(cyid, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
                else
                    玩家数据[cyid].道具:给予超链接道具(cyid, 名称, 数量, 参数, 链接)
                end
            end
        end
    end
    地图处理类:删除单位(任务数据[任务id].地图编号, 任务数据[任务id].单位编号)
    任务数据[任务id] = nil
end

return 群雄逐鹿