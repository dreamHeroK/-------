-- @Author: baidwwy
-- @Date:   2024-03-13 09:27:18
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2026-05-22 09:51:06

local 账号仓库类 = class()

-- 初始化函数
function 账号仓库类:初始化(账号)
    self.账号 = 账号
    self.数据 = {}
    self.数据.道具 = {[1] = {}, 总数 = 56} -- 页
    self.数据.召唤兽 = {[1] = {}}
    self.仓库类型 = "其他"
    self.数据.一键存放过滤列表 = {}
    self.仓库序列 = 1----C改
end

-- 数据处理主函数
function 账号仓库类:数据处理(连接id, 序号, 数字id, 数据)
    -- local 数据 = 数据.内容
    if not 数字id or not 玩家数据[数字id] then
        return
    end
    -- 处理仓库类型设置
    if 数据.仓库类型 ~= nil then
        if self.数据[数据.仓库类型] == nil then
            self.数据[数据.仓库类型] = {[1] = {}, 总数 = 56} -- 页
        end
        self.仓库类型 = 数据.仓库类型

        if self.数据[数据.仓库类型].总数 == nil then
            self.数据[数据.仓库类型].总数 = 56
        end
    end

    -- 确保当前仓库类型有总数设置
    if self.数据[self.仓库类型].总数 == nil then
        self.数据[self.仓库类型].总数 = 56
    end
    -- self.仓库序列 = 1----C改
    -- 根据序号处理不同操作
    -- if 序号 == 8000 then
    --     -- 打开仓库
    --     self.仓库序列 = 1
    --     发送数据(连接id, 3513, 玩家数据[数字id].道具:索要道具2(数字id))
    --     发送数据(连接id, 412, {
    --         界面 = "道具",
    --         仓库类型 = "其他",
    --         仓库总数 = self.数据.其他.总数,
    --         仓库页数 = 1,
    --         背包页数 = 1,
    --         道具 = self:索要仓库道具(数字id, 1, "其他"),
    --         道具仓库总数 = self.数据[self.仓库类型].总数 / 56,
    --         召唤兽仓库总数 = #self.数据.召唤兽
    --     })
        if 序号 == 8000 then
            -- 打开仓库：初始化仓库类型为"其他"，避免旧值残留
            self.仓库序列 = 1
            self.仓库类型 = "其他" -- ✅ 新增：显式初始化仓库类型
            发送数据(连接id, 3513, 玩家数据[数字id].道具:索要道具2(数字id))
            发送数据(连接id, 412, {
                界面 = "道具",
                仓库类型 = "其他",
                仓库总数 = self.数据.其他.总数,
                仓库页数 = 1,
                背包页数 = 1,
                -- 明确传"其他"类型，避免依赖self.仓库类型
                道具 = self:索要仓库道具(数字id, 1, "其他"),
                -- ✅ 直接用"其他"算总数，不要用self.仓库类型
                道具仓库总数 = self.数据["其他"].总数 / 56,
                召唤兽仓库总数 = #self.数据.召唤兽
            })

    elseif 序号 == 8002 then
        -- 存放道具
        self:仓库存放事件_道具(连接id, 数字id, 数据)
    elseif 序号 == 8003 then
        -- 取出道具
        self:仓库取走事件_道具(连接id, 数字id, 数据)

    elseif 序号 == 8003.1 then
        self:账号仓库一键存放(连接id, 数字id, 数据)

    elseif 序号 == 8003.2 then
        self:处理一键存放过滤设置(连接id, 数字id, 数据)
    elseif 序号 == 8003.3 then
        self:处理移除过滤(连接id, 数字id, 数据) -- 调用新的移除函数
    elseif 序号 == 8003.4 then -- 假设客户端打开过滤窗口用此序号（可根据实际调整）
        -- 1. 读取服务端保存的过滤列表（原有哈希表：{[道具名]=true}）
        local 现有过滤 = self.数据.一键存放过滤列表 or {}
        -- 2. 转换为逗号分隔的字符串（适配客户端显示格式）
        local 过滤列表文本 = ""
        local 过滤项 = {}
        for 道具名, _ in pairs(现有过滤) do
            table.insert(过滤项, 道具名)
        end

        过滤列表文本 = table.concat(过滤项, ",") -- 例："钟灵石,强化符,九转金丹"
        -- 3. 发送给客户端（包含过滤列表，客户端打开窗口时接收）
        发送数据(连接id, 413.1, { -- 复用原有同步协议号413
            类型 = "一键存放过滤",
            过滤列表 = 过滤列表文本, -- 客户端用此值初始化 self.当前过滤列表
            界面 = "过滤窗口"
        })



    elseif 序号 == 8004 then
        -- 购买仓库
        self:处理购买仓库(连接id, 数字id)
    elseif 序号 == 8005 then
        -- 仓库序列切换
        self:处理仓库序列切换(数字id, 数据)
    elseif 序号 == 8006 then
        -- 仓库整理
        self:仓库整理事件(连接id, 数字id, 数据)
    elseif 序号 == 8009 then
        -- 购买召唤兽仓库
        self:处理购买召唤兽仓库(连接id, 数字id)
    elseif 序号 == 8010 then
        -- 获取道具或行囊数据
        self:处理获取道具数据(数字id, 数据)
    elseif 序号 == 8011 then
        -- 获取召唤兽仓库数据
        发送数据(连接id, 416, {
            召唤兽仓库总数 = #self.数据.召唤兽,
            召唤兽仓库数据 = self.数据.召唤兽[1]
        })
        发送数据(连接id, 3534, {宝宝列表 = 玩家数据[数字id].召唤兽.数据})
    elseif 序号 == 8012 then
        -- 切换召唤兽仓库页
        self:处理切换召唤兽仓库页(数字id, 数据)
    elseif 序号 == 8013 then
        -- 存放/取出召唤兽
        self:仓库存放事件_召唤兽(连接id, 数字id, 数据)
    end
end

-- 加载数据
function 账号仓库类:加载数据(账号, 数字id)
    self.账号 = 玩家数据[数字id].账号

    -- 加载账号ID组
    if type(self.账号) == "string" then
        local zhxx = 读入文件(程序目录..[[data/]]..self.账号..[[/信息.txt]])
        self.帐号id组 = table.loadstring(zhxx)
    end

    -- 初始化或加载仓库数据
    if not f函数.文件是否存在(程序目录..[[data/]]..账号..[[/超级仓库.txt]]) then
        self.数据 = {
            内丹 = {[1] = {}, 总数 = 56},
            书铁 = {[1] = {}, 总数 = 56},
            宝石 = {[1] = {}, 总数 = 56},
            兽决 = {[1] = {}, 总数 = 56},
            装备 = {[1] = {}, 总数 = 56},
            炼妖 = {[1] = {}, 总数 = 56},
            卡片 = {[1] = {}, 总数 = 56}, -- 新增“卡片”仓库
            其他 = {[1] = {}, 总数 = 56},
            召唤兽 = {[1] = {}, 总数 = 17},
             一键存放过滤列表 = {}
        }
        写出文件([[data/]]..账号.."/超级仓库.txt", table.tostring(self.数据))
    else
        self.数据 = table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/超级仓库.txt]]))
        if not self.数据.一键存放过滤列表 then
            self.数据.一键存放过滤列表 = {}
        end

        -- 【补充代码开始】
        -- 检查所有仓库类型的`总数`是否存在，不存在则初始化
        for 仓库类型, 仓库数据 in pairs(self.数据) do
            -- 排除非仓库类型的特殊字段（如召唤兽、过滤列表）
            if 仓库类型 ~= "召唤兽" and 仓库类型 ~= "一键存放过滤列表" then
                -- 确保仓库数据是表结构，且`总数`存在（默认56）
                if type(仓库数据) == "table" and 仓库数据.总数 == nil then
                    仓库数据.总数 = 56
                end
            end
        end
    end

    if self.仓库序列 == nil or type(self.仓库序列) ~= "number" then
        self.仓库序列 = 1----C改
    end

end



-- function 账号仓库类:仓库整理事件(连接id, id, 数据)----C改原整理
--     -- 防止频繁整理
--     if 玩家数据[id].整理背包 ~= nil then
--         if os.time() - 玩家数据[id].整理背包 <= 3 then--5
--             常规提示(id, "不要频繁点击整理请"..(3 - (os.time() - 玩家数据[id].整理背包)).."秒后再尝试！")--5
--             return
--         end
--     end
--     玩家数据[id].整理背包 = os.time()

--     -- 检查摆摊状态
--     if 玩家数据[id].摊位数据 ~= nil then
--         常规提示(id, "#Y/摆摊中无法操作仓库。")
--         return
--     end

--     -- 定义排序函数
--     local function 简易排序(a, b)
--         return 排序整理(a.序号) < 排序整理(b.序号)
--     end

--     -- 整理各类仓库
--     for _, 仓库类型 in pairs({"宝石", "炼妖", "装备", "书铁", "兽决", "其他", "内丹", "卡片"}) do
--         local 页数 = 1
--         local data = {}
--         local 计数 = 0

--         -- 处理每个物品
--         for k, v in pairs(self.数据[仓库类型][页数]) do
--             data[#data + 1] = {内容 = v, 序号 = v.名称}

--             -- 处理可叠加物品
--             if v.数量 ~= nil and v.数量 + 0 < 9999 and v.可叠加 then
--                 for i, n in pairs(self.数据[仓库类型][页数]) do
--                     if k ~= i and n ~= nil and v ~= nil and n.可叠加 and n.名称 == v.名称 and n.数量 ~= nil and v.数量 + n.数量 < 9999 then
--                         -- 特殊物品处理
--                         if (n.名称 == "初级清灵仙露" and v.名称 == "初级清灵仙露") or
--                            (n.名称 == "中级清灵仙露" and v.名称 == "中级清灵仙露") or
--                            (n.名称 == "高级清灵仙露" and v.名称 == "高级清灵仙露") or
--                            (n.名称 == "高级摄灵珠" and v.名称 == "高级摄灵珠") then
--                             if v.灵气 == n.灵气 then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         elseif (n.名称 == "九转金丹" and v.名称 == "九转金丹") or
--                                (n.名称 == "修炼果" and v.名称 == "修炼果") or
--                                (v.名称 == "月华露" and n.名称 == "月华露") then
--                             if v.阶品 == n.阶品 then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         elseif (n.名称 == "强化符" and v.名称 == "强化符") then
--                             if v.级别限制 == n.级别限制 or v.技能 == n.技能 then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                          elseif (n.名称 == "灵犀玉" and v.名称 == "灵犀玉") then
--                             if v.子类 == n.子类  and v.特性==n.特性 then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                          elseif (n.名称 == "焕彩石" and v.名称 == "焕彩石") then
--                             if v.等级 == n.等级  then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         -----------------------------------------------------------------------------------兽决叠加
--                         elseif (n.名称 == "高级魔兽要诀" and v.名称 == "高级魔兽要诀") then
--                             if v.附带技能 == n.附带技能  then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         elseif (n.名称 == "魔兽要诀" and v.名称 == "魔兽要诀") then
--                             if v.附带技能 == n.附带技能  then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         elseif (n.名称 == "特殊魔兽要诀" and v.名称 == "特殊魔兽要诀") then
--                             if v.附带技能 == n.附带技能  then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         elseif (n.名称 == "超级魔兽要诀" and v.名称 == "超级魔兽要诀") then
--                             if v.附带技能 == n.附带技能  then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         elseif (n.名称 == "召唤兽内丹" and v.名称 == "召唤兽内丹") then
--                             if v.特效 == n.特效  then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         elseif (n.名称 == "高级召唤兽内丹" and v.名称 == "高级召唤兽内丹") then
--                             if v.特效 == n.特效  then
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                                 self.数据[n] = nil
--                             end
--                         -----------------------------------------------------------------------------------兽决叠加
--                         elseif (n.名称 == "钨金" and v.名称 == "钨金") or
--                                (n.名称 == "珍珠" and v.名称 == "珍珠") or
--                                (n.名称 == "附魔宝珠" and v.名称 == "附魔宝珠") then
--                             if v.等级 == n.等级 then
--                                 self.数据[n] = nil
--                                 self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                                 self.数据[仓库类型][页数][i] = nil
--                             end
--                         else
--                             self.数据[n] = nil
--                             self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
--                             self.数据[仓库类型][页数][i] = nil
--                         end
--                     end
--                 end
--             end
--         end

--         -- 排序并更新数据
--         table.sort(data, 简易排序)
--         local tabdata = {}
--         for _, v in pairs(data) do
--             tabdata[#tabdata + 1] = v.内容
--         end
--         self.数据[仓库类型][页数] = tabdata

--         -- 刷新道具
--         道具刷新(id)
--         发送数据(连接id, 3513, 玩家数据[id].道具:索要道具2(id))

--         -- 通知所有账号成员
--         if type(self.帐号id组) == "table" then
--             for n = 1, #self.帐号id组 do
--                 if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
--                     发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
--                         类型 = self.仓库类型,
--                         道具 = self:索要仓库道具(id, 页数, self.仓库类型),
--                         页数 = 页数,
--                         界面 = 数据.界面,
--                         道具仓库总数 = self.数据[仓库类型].总数 / 56
--                     })
--                     --------------------------------------------------C改
--                      local 临时账号 = 玩家数据[id].角色.账号
--                         if 账号仓库数据[临时账号] ~= nil then
--                             账号仓库数据[临时账号]:账号仓库存档()
--                         end
--                     --------------------------------------------------C改

--                 end
--             end
--         end
--     end

--     -- 发送道具或行囊数据
--     if 数据.类型 == "道具" then
--         发送数据(连接id, 414, {类型 = "道具", 数据 = 玩家数据[id].道具:索要道具2(id)})
--     elseif 数据.类型 == "行囊" then
--         发送数据(连接id, 414, {类型 = "行囊", 数据 = 玩家数据[id].道具:索要行囊2(id)})
--     end

--     常规提示(id, "#G/共享仓库整理成功")
-- end

function 账号仓库类:仓库整理事件(连接id, id, 数据)----C改原整理
    -- 防止频繁整理
    if 玩家数据[id].整理背包 ~= nil then
        if os.time() - 玩家数据[id].整理背包 <= 3 then--5
            常规提示(id, "不要频繁点击整理请"..(3 - (os.time() - 玩家数据[id].整理背包)).."秒后再尝试！")--5
            return
        end
    end
    玩家数据[id].整理背包 = os.time()

    -- 检查摆摊状态
    if 玩家数据[id].摊位数据 ~= nil then
        常规提示(id, "#Y/摆摊中无法操作仓库。")
        return
    end

    -- 定义排序函数
    local function 简易排序(a, b)
        return 排序整理(a.序号) < 排序整理(b.序号)
    end

    -- 整理各类仓库
    for _, 仓库类型 in pairs({"宝石", "炼妖", "装备", "书铁", "兽决", "其他", "内丹", "卡片"}) do
        local 页数 = 1
        local data = {}
        local 计数 = 0

        -- 处理每个物品
        for k, v in pairs(self.数据[仓库类型][页数]) do
            data[#data + 1] = {内容 = v, 序号 = v.名称}

            -- 处理可叠加物品
            if v.数量 ~= nil and v.数量 + 0 < 9999 and v.可叠加 then
                for i, n in pairs(self.数据[仓库类型][页数]) do
                    if k ~= i and n ~= nil and v ~= nil and n.可叠加 and n.名称 == v.名称 and n.数量 ~= nil and v.数量 + n.数量 < 9999 then
                        -- 特殊物品处理
                        if (n.名称 == "初级清灵仙露" and v.名称 == "初级清灵仙露") or
                           (n.名称 == "中级清灵仙露" and v.名称 == "中级清灵仙露") or
                           (n.名称 == "高级清灵仙露" and v.名称 == "高级清灵仙露") or
                           (n.名称 == "高级摄灵珠" and v.名称 == "高级摄灵珠") then
                            if v.灵气 == n.灵气 then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        elseif (n.名称 == "九转金丹" and v.名称 == "九转金丹") or
                               (n.名称 == "修炼果" and v.名称 == "修炼果") or
                               (v.名称 == "月华露" and n.名称 == "月华露") then
                            if v.阶品 == n.阶品 then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        elseif (n.名称 == "强化符" and v.名称 == "强化符") then
                            if v.级别限制 == n.级别限制 or v.技能 == n.技能 then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                         elseif (n.名称 == "灵犀玉" and v.名称 == "灵犀玉") then
                            if v.子类 == n.子类  and v.特性==n.特性 then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                         elseif (n.名称 == "焕彩石" and v.名称 == "焕彩石") then
                            if v.等级 == n.等级  then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        -----------------------------------------------------------------------------------兽决叠加
                        elseif (n.名称 == "高级魔兽要诀" and v.名称 == "高级魔兽要诀") then
                            if v.附带技能 == n.附带技能  then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        elseif (n.名称 == "魔兽要诀" and v.名称 == "魔兽要诀") then
                            if v.附带技能 == n.附带技能  then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        elseif (n.名称 == "特殊魔兽要诀" and v.名称 == "特殊魔兽要诀") then
                            if v.附带技能 == n.附带技能  then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        elseif (n.名称 == "超级魔兽要诀" and v.名称 == "超级魔兽要诀") then
                            if v.附带技能 == n.附带技能  then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        elseif (n.名称 == "召唤兽内丹" and v.名称 == "召唤兽内丹") then
                            if v.特效 == n.特效  then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        elseif (n.名称 == "高级召唤兽内丹" and v.名称 == "高级召唤兽内丹") then
                            if v.特效 == n.特效  then
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                                self.数据[n] = nil
                            end
                        -----------------------------------------------------------------------------------兽决叠加
                        elseif (n.名称 == "钨金" and v.名称 == "钨金") or
                               (n.名称 == "珍珠" and v.名称 == "珍珠") or
                               (n.名称 == "附魔宝珠" and v.名称 == "附魔宝珠") then
                            if v.等级 == n.等级 then
                                self.数据[n] = nil
                                self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                                self.数据[仓库类型][页数][i] = nil
                            end
                        else
                            self.数据[n] = nil
                            self.数据[仓库类型][页数][k].数量 = self.数据[仓库类型][页数][k].数量 + self.数据[仓库类型][页数][i].数量
                            self.数据[仓库类型][页数][i] = nil
                        end
                    end
                end
            end
        end

        -- 排序并更新数据
        table.sort(data, 简易排序)
        local tabdata = {}
        for _, v in pairs(data) do
            tabdata[#tabdata + 1] = v.内容
        end
        self.数据[仓库类型][页数] = tabdata
    end
--========================================================
-- 【修改1】循环结束后统一发送消息（原来每个仓库都发送，很卡）
    -- 循环结束后，统一刷新和发送消息
    道具刷新(id)
    发送数据(连接id, 3513, 玩家数据[id].道具:索要道具2(id))

    -- 通知所有账号成员
    if type(self.帐号id组) == "table" then
        for n = 1, #self.帐号id组 do
            if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
                    类型 = self.仓库类型,
                    道具 = self:索要仓库道具(id, 1, self.仓库类型),
                    页数 = 1,
                    界面 = 数据.界面,
                    道具仓库总数 = self.数据[self.仓库类型].总数 / 56
                })
            end
        end
    end

    -- 存档
    local 临时账号 = 玩家数据[id].角色.账号
    if 账号仓库数据[临时账号] ~= nil then
        账号仓库数据[临时账号]:账号仓库存档()
    end
--========================================================
    -- 发送道具或行囊数据
    if 数据.类型 == "道具" then
        发送数据(连接id, 414, {类型 = "道具", 数据 = 玩家数据[id].道具:索要道具2(id)})
    elseif 数据.类型 == "行囊" then
        发送数据(连接id, 414, {类型 = "行囊", 数据 = 玩家数据[id].道具:索要行囊2(id)})
    end

    常规提示(id, "#G/共享仓库整理成功")
end

-- 内部仓库整理
function 账号仓库类:内部仓库整理(页数)
    if 页数 == nil or self.数据.道具[页数] == nil then return end

    local data = {}
    local function 简易排序(a, b)
        return 排序整理(a.序号) < 排序整理(b.序号)
    end

    for k, v in pairs(self.数据.道具[页数]) do
        data[#data + 1] = {内容 = v, 序号 = v.名称}

        -- 处理可叠加物品
        if v.数量 ~= nil and v.数量 < 999 and v.可叠加 then
            for i, n in pairs(self.数据.道具[页数]) do
                if k ~= i and n ~= nil and v ~= nil and n.可叠加 and n.名称 == v.名称 and n.数量 ~= nil and v.数量 + n.数量 < 999 then
                    if (n.名称 == "初级清灵仙露" and v.名称 == "初级清灵仙露") or
                       (n.名称 == "中级清灵仙露" and v.名称 == "中级清灵仙露") or
                       (n.名称 == "高级清灵仙露" and v.名称 == "高级清灵仙露") or
                       (n.名称 == "高级摄灵珠" and v.名称 == "高级摄灵珠") then
                        if v.灵气 == n.灵气 then
                            self.数据.道具[页数][k].数量 = self.数据.道具[页数][k].数量 + self.数据.道具[页数][i].数量
                            self.数据.道具[页数][i] = nil
                        end
                    elseif n.名称 == "钨金" and v.名称 == "钨金" then
                        if v.级别限制 == n.级别限制 then
                            self.数据.道具[页数][k].数量 = self.数据.道具[页数][k].数量 + self.数据.道具[页数][i].数量
                            self.数据.道具[页数][i] = nil
                        end
                    else
                        self.数据.道具[页数][k].数量 = self.数据.道具[页数][k].数量 + self.数据.道具[页数][i].数量
                        self.数据.道具[页数][i] = nil
                    end
                end
            end
        end
    end

    -- 排序并更新数据
    table.sort(data, 简易排序)
    local tabdata = {}
    for _, v in pairs(data) do
        tabdata[#tabdata + 1] = v.内容
    end
    self.数据.道具[页数] = tabdata
end

-- 获取道具空格子
function 账号仓库类:取道具空格子()
    if self.数据.道具[1] ~= nil then
        for nv = 1, self.数据[self.仓库类型].总数 do
            if self.数据.道具[1][nv] == nil then
                return {页数 = 1, 格子 = nv}
            end
        end
    end
    return 0
end

-- 存放给予道具
function 账号仓库类:存放事件_给予道具(id, 共享格子, 道具)
    if 共享格子 == nil or 共享格子.页数 == nil then
        共享格子 = self:取道具空格子()
    end

    if 共享格子 ~= 0 and self.数据.道具[共享格子.页数] ~= nil and
       self.数据.道具[共享格子.页数][共享格子.格子] == nil and type(道具) == "table" then
        self.数据.道具[共享格子.页数][共享格子.格子] = table.copy(道具)
        self:内部仓库整理(共享格子.页数)
    else
        常规提示(id, "#Y/共享仓库存放错误！请联系管理员")
    end
end

-- 获取道具类型
function 账号仓库类:取道具类型(道具)
    if 道具 == nil then
        常规提示(id, "#Y/物品数据错误！请联系管理员")
        return
    end

    -- 宝石类
    if 道具.名称 == "太阳石" or 道具.名称 == "黑宝石" or 道具.名称 == "月亮石" or 道具.名称 == "五色灵尘"
       or 道具.名称 == "舍利子" or 道具.名称 == "红玛瑙" or 道具.名称 == "光芒石" or 道具.名称 == "神秘石"
       or 道具.名称 == "精魄灵石" or 道具.名称 == "星辉石" or 道具.名称 == "1级宝石礼包"
       or 道具.名称 == "2级宝石礼包" or 道具.名称 == "3级宝石礼包"or 道具.名称 == "4级宝石礼包"
       or 道具.名称 == "5级宝石礼包" or 道具.名称 == "6级宝石礼包" or 道具.名称 == "7级宝石礼包"
       or 道具.名称 == "8级宝石礼包" or 道具.名称 == "9级宝石礼包" or 道具.名称 == "10级宝石礼包" or 道具.名称 == "钟灵石"
       or 道具.名称 == "3级精魄灵石礼包"  or 道具.名称 == "4级精魄灵石礼包"  or 道具.名称 == "5级精魄灵石礼包"
        or 道具.名称 == "6级精魄灵石礼包"  or 道具.名称 == "7级精魄灵石礼包"   or 道具.名称 == "8级精魄灵石礼包"
        or 道具.名称 == "高级宝石袋"   or 道具.名称 == "精魄灵石袋"   or 道具.名称 == "星辉石袋"  or 道具.名称 == "宝石袋"   then
        return "宝石"
    -- 内丹类
    elseif 道具.名称 == "召唤兽内丹" or 道具.名称 == "高级召唤兽内丹" or 道具.名称 == "高级内丹礼盒" or 道具.名称 == "低级内丹礼盒" then
        return "内丹"
    -- 变身卡
    elseif 道具.名称 == "怪物卡片"  then
        return "卡片"
    -- 兽决类
    elseif 道具.名称 == "魔兽要诀" or 道具.名称 == "高级魔兽要诀" or 道具.名称 == "高级兽决礼包" or 道具.名称 == "低级兽决礼包"
        or 道具.名称 == "特殊魔兽要诀" or 道具.名称 == "超级魔兽要诀" or 道具.名称 == "特殊技能" or 道具.名称 == "自选超级兽决"
        or 道具.名称 == "自选特殊兽决" then
        return "兽决"
    -- 炼妖类
    elseif (道具.总类 == 3 and 道具.分类 == 11) or 道具.名称 == "上古锻造图策" or
          道具.名称 == "炼妖石" or 道具.名称 == "超级金柳露" or 道具.名称 == "金柳露" or
          道具.名称 == "月华露" or 道具.名称 == "净瓶玉露" or 道具.名称 == "超级净瓶玉露" or
          道具.名称 == "元宵礼盒" or (道具.总类 == 1 and 道具.分类 == 10)  or 道具.名称 == "炼兽真经" or 道具.名称 == "神兜兜"or 道具.名称 == "水晶糕"
           or 道具.名称 == "技能书"  or 道具.名称 == "神兽涎"   or 道具.名称 == "仙露小丸子"   or 道具.名称 == "仙露丸子"  then
        return "炼妖"
    -- 书铁类
    elseif 道具.名称 == "制造指南书" or 道具.名称 == "灵饰指南书" or 道具.名称 == "元灵晶石" or
          道具.名称 == "百炼精铁" or 道具.名称 == "陨铁" or 道具.名称 == "战魄" or
          道具.名称 == "青龙石" or 道具.名称 == "白虎石" or 道具.名称 == "玄武石" or
          道具.名称 == "朱雀石" or 道具.名称 == "附魔宝珠" or 道具.名称 == "钨金"
          or 道具.名称 == "150书铁礼包" or 道具.名称 == "珍珠"  or 道具.名称 == "女娲祝符"    or 道具.名称 == "女娲灵契" then
        return "书铁"
    -- 装备类
    elseif (道具.总类 == 2 and 道具.分类 <= 13) or 道具.名称 == "未激活的符石" or
        道具.名称 == "新三级符石礼包" or 道具.名称 == "星石礼包" or 道具.名称 == "一级符石礼包" or
        道具.名称 == "二级符石礼包" or 道具.名称 == "三级符石礼包" or 道具.名称 == "未激活的星石"
         or 道具.名称 == "点化石"  then
        return "装备"
    end

    -- 默认其他类
    return "其他"
end

-- 自动存放道具到仓库
function 账号仓库类:自动存仓(连接id, id,数据)
    if 玩家数据[id].摊位数据 ~= nil then
        常规提示(id, "#Y/摆摊中无法操作仓库。")
        return
    end
    -- table.print(数据)
    local 页数 = 数据.页数
    local 道具 = 数据.物品
    local 格子 = 0
    local 类型 = 数据.类型

    -- 获取道具ID和仓库类型
    local 道具id = 玩家数据[id].角色[类型][道具]
    local 当前道具 = 玩家数据[id].道具.数据[道具id]
    local 仓库类型 = self:取道具类型(当前道具)
    -- print(仓库类型)
    -- 初始化仓库类型
    if self.数据[仓库类型] == nil then
        if 仓库类型 == nil then
            常规提示(id, "#Y/此道具数据错误，共享仓库510,截图发给群主")
            return
        end
        self.数据[仓库类型] = {[1] = {}, 总数 = 56} -- 页
    end

    -- 确保仓库有总数设置
    if self.数据[仓库类型].总数 == nil then
        self.数据[仓库类型].总数 = 56
    end

    -- 【新增：尝试叠加到仓库现有可叠加道具】
    local 已叠加 = false
    if 当前道具.可叠加 then
        for 仓库格子 = 1, self.数据[仓库类型].总数 do
            local 仓库道具 = self.数据[仓库类型][1][仓库格子]
            if 仓库道具 and 仓库道具.名称 == 当前道具.名称 and 仓库道具.可叠加 then
                -- 特殊道具叠加条件（复用仓库整理规则）
                local 可以叠加 = true
                if (仓库道具.名称 == "初级清灵仙露" or 仓库道具.名称 == "中级清灵仙露" or
                    仓库道具.名称 == "高级清灵仙露" or 仓库道具.名称 == "高级摄灵珠") then
                    if 仓库道具.灵气 ~= 当前道具.灵气 then
                        可以叠加 = false
                    end
                elseif (仓库道具.名称 == "九转金丹" or 仓库道具.名称 == "修炼果" or 仓库道具.名称 == "月华露") then
                    if 仓库道具.阶品 ~= 当前道具.阶品 then
                        可以叠加 = false
                    end
                elseif 仓库道具.名称 == "强化符" then
                    if 仓库道具.级别限制 ~= 当前道具.级别限制 or 仓库道具.技能 ~= 当前道具.技能 then
                        可以叠加 = false
                    end
                elseif 仓库道具.名称 == "灵犀玉" then
                    if 仓库道具.子类 ~= 当前道具.子类 or 仓库道具.特性 ~= 当前道具.特性 then
                        可以叠加 = false
                    end
                elseif (仓库道具.名称 == "高级魔兽要诀" or 仓库道具.名称 == "魔兽要诀" or
                        仓库道具.名称 == "特殊魔兽要诀" or 仓库道具.名称 == "超级魔兽要诀") then
                    if 仓库道具.附带技能 ~= 当前道具.附带技能 then
                        可以叠加 = false
                    end
                elseif (仓库道具.名称 == "召唤兽内丹" or 仓库道具.名称 == "高级召唤兽内丹") then
                    if 仓库道具.特效 ~= 当前道具.特效 then
                        可以叠加 = false
                    end
                elseif (仓库道具.名称 == "钨金" or 仓库道具.名称 == "珍珠" or 仓库道具.名称 == "附魔宝珠") then
                    if 仓库道具.等级 ~= 当前道具.等级 then
                        可以叠加 = false
                    end
                end

                -- 数量上限判断（与仓库整理一致，上限9999）
                local 叠加后数量 = (仓库道具.数量 or 1) + (当前道具.数量 or 1)
                if 可以叠加 and 叠加后数量 <= 9999 then
                    self.数据[仓库类型][1][仓库格子].数量 = 叠加后数量
                    已叠加 = true
                    break
                end
            end
        end
    end

    -- 叠加成功：直接删除背包道具，无需占用新格子
    if 已叠加 then
        玩家数据[id].角色[类型][道具] = nil
        玩家数据[id].道具.数据[道具id] = nil
    else
        -- 原有逻辑：查找空格子存放
        for n = 1, self.数据[仓库类型].总数 do
            if self.数据[仓库类型][1][n] == nil and 格子 == 0 then
                格子 = n
                break
            end
        end

        if 格子 == 0 then
            常规提示(id, "#Y/你的仓库已经无法存放更多的物品了")
            return
        end

        -- 检查道具是否存在
        if 道具id == nil or 玩家数据[id].道具.数据[道具id] == nil then
            常规提示(id, "#Y/你没有这个物品！")
            return
        end

        -- 检查特殊道具
        if 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼卡" or 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼年卡" or 玩家数据[id].道具.数据[道具id].名称 == "良师册"
                or 玩家数据[id].道具.数据[道具id].名称 == "人族时空之钥" or 玩家数据[id].道具.数据[道具id].名称 == "魔族时空之钥"
                or 玩家数据[id].道具.数据[道具id].名称 == "仙族时空之钥" or 玩家数据[id].道具.数据[道具id].名称 == "新春飞行符"
                or 玩家数据[id].道具.数据[道具id].名称 == "超级合成旗" then
            常规提示(id, "#Y/该物品不能放进共享仓库！")
            return
        end

        -- 存放道具
        local asdsadw = table.copy(玩家数据[id].道具.数据[道具id])
        玩家数据[id].角色[类型][道具] = nil
        玩家数据[id].道具.数据[道具id] = nil
        self.数据[仓库类型][1][格子] = asdsadw
    end

    -- 刷新并通知
    道具刷新(id)
    发送数据(连接id, 3513, 玩家数据[id].道具:索要道具2(id))
    -- 发送道具或行囊数据
    if 类型 == "道具" then
        发送数据(连接id, 414, {类型 = "道具", 数据 = 玩家数据[id].道具:索要道具2(id)})
    elseif 类型 == "行囊" then
        发送数据(连接id, 414, {类型 = "行囊", 数据 = 玩家数据[id].道具:索要行囊2(id)})
    end

    -- 存档
    local 临时账号 = 玩家数据[id].角色.账号
    if 账号仓库数据[临时账号] ~= nil then
        账号仓库数据[临时账号]:账号仓库存档()
    end
end

function 账号仓库类:仓库存放事件_道具(连接id, id, 数据,自动)
    if 玩家数据[id].摊位数据 ~= nil then
        常规提示(id, "#Y/摆摊中无法操作仓库。")
        return
    end
    -- table.print(数据)
    local 页数 = 数据.页数
    local 道具 = 数据.物品
    local 格子 = 0
    local 类型 = 数据.类型

    -- 获取道具ID和仓库类型
    local 道具id = 玩家数据[id].角色[类型][道具]
    local 仓库类型 = self:取道具类型(玩家数据[id].道具.数据[道具id])
    -- print(仓库类型)
    -- 初始化仓库类型
    if self.数据[仓库类型] == nil then
        if 仓库类型 == nil then
            常规提示(id, "#Y/此道具数据错误，共享仓库510,截图发给群主")
            return
        end
        self.数据[仓库类型] = {[1] = {}, 总数 = 56} -- 页
    end

    -- 确保仓库有总数设置
    if self.数据[仓库类型].总数 == nil then
        self.数据[仓库类型].总数 = 56
    end

    -- 查找空格子
    for n = 1, self.数据[仓库类型].总数 do
        if self.数据[仓库类型][1][n] == nil and 格子 == 0 then
            格子 = n
            break
        end
    end

    if 格子 == 0 then
        常规提示(id, "#Y/你这个仓库已经无法存放更多的物品了")
        return
    end

    -- 检查道具是否存在
    if 道具id == nil or 玩家数据[id].道具.数据[道具id] == nil then
        常规提示(id, "#Y/你没有这个物品！")
        return
    end

    -- 检查特殊道具
    if 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼卡" or 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼卡600次" or 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼卡800次" or 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼卡400次" or 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼卡1000次" then
        常规提示(id, "#Y/该物品不能放进共享仓库！")
        return
    end

    -- 存放道具
    local asdsadw = table.copy(玩家数据[id].道具.数据[道具id])
    玩家数据[id].角色[类型][道具] = nil
    玩家数据[id].道具.数据[道具id] = nil
    self.数据[仓库类型][1][格子] = asdsadw

    -- 刷新并通知
    道具刷新(id)
    发送数据(连接id, 3513, 玩家数据[id].道具:索要道具2(id))

    -- 通知所有账号成员
    if type(self.帐号id组) == "table" then
        for n = 1, #self.帐号id组 do
            if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
                    道具 = self:索要仓库道具(数字id, 1, 数据.仓库类型),
                    类型 = 数据.仓库类型,
                    页数 = 数据.页数,
                    界面 = 数据.界面,
                    道具仓库总数 = self.数据[self.仓库类型].总数 / 56
                })
            end
        end
    end

    -- 发送道具或行囊数据
    if 类型 == "道具" then
        发送数据(连接id, 414, {类型 = "道具", 数据 = 玩家数据[id].道具:索要道具2(id)})
    elseif 类型 == "行囊" then
        发送数据(连接id, 414, {类型 = "行囊", 数据 = 玩家数据[id].道具:索要行囊2(id)})
    end

    -- 存档
    local 临时账号 = 玩家数据[id].角色.账号
    if 账号仓库数据[临时账号] ~= nil then
        账号仓库数据[临时账号]:账号仓库存档()
    end

end

-- 仓库存放召唤兽事件
function 账号仓库类:仓库存放事件_召唤兽(连接id, 数字id, 内容)
    if 玩家数据[数字id].摊位数据 ~= nil then
        常规提示(数字id, "#Y/摆摊中无法操作仓库。")
        return
    end

    local 类型 = 内容.类型
    local 页数 = 内容.页数
    local 认证码 = 内容.认证码

    -- 检查页数有效性
    if #self.数据.召唤兽 < 页数 or 页数 < 1 then
        常规提示(数字id, "#Y/数据异常，请重新打开仓库。")
        return
    end

    -- 存放召唤兽
    if 类型 == "存" then
        -- 检查是否参战宝宝
        if 玩家数据[数字id].角色.参战宝宝.认证码 == 认证码 then
            常规提示(数字id, "参战召唤兽无法存入仓库")
            return
        end

        -- 检查仓库容量
        if self.数据.召唤兽[页数] ~= nil and #self.数据.召唤兽[页数] >= 17 then
            常规提示(数字id, "#Y/一个仓库只能存放17只召唤兽。")
            return
        end

        -- 查找召唤兽
        local 是否存在 = false
        local bianh = nil
        for k, v in pairs(玩家数据[数字id].召唤兽.数据) do
            if 认证码 == v.认证码 then
                是否存在 = true
                bianh = k
            end
        end

        -- 存放处理
        if 是否存在 and bianh ~= nil then
            local bb = table.copy(玩家数据[数字id].召唤兽.数据[bianh])
            table.insert(self.数据.召唤兽[页数], bb)
            玩家数据[数字id].角色:日志记录(format("[召唤兽系统-仓库存取]存入角色ID[%s]召唤兽认证码[%s]", 数字id, bb.认证码))
            table.remove(玩家数据[数字id].召唤兽.数据, bianh)

            -- 通知客户端
            发送数据(连接id, 3534, {宝宝列表 = table.copy(玩家数据[数字id].召唤兽.数据)})

            -- 通知所有账号成员
            if type(self.帐号id组) == "table" then
                for n = 1, #self.帐号id组 do
                    if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                        发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
                            召唤兽仓库数据 = table.copy(self.数据.召唤兽[页数]),
                            页数 = 页数,
                            界面 = 内容.界面
                        })
                    end
                end
            end
        end
    -- 取出召唤兽
    elseif 类型 == "取" then
        if 玩家数据[数字id].角色:取新增宝宝数量() then
            local 是否存在 = false
            local bianh = nil

            -- 查找仓库中的召唤兽
            for k, v in pairs(self.数据.召唤兽[页数]) do
                if 认证码 == v.认证码 then
                    是否存在 = true
                    bianh = k
                end
            end

            -- 取出处理
            if 是否存在 and bianh ~= nil then
                local 宝宝 = 宝宝类.创建()
                宝宝:加载数据(self.数据.召唤兽[页数][bianh])
                table.insert(玩家数据[数字id].召唤兽.数据, 宝宝)

                -- 通知客户端
                发送数据(连接id, 3534, {宝宝列表 = table.copy(玩家数据[数字id].召唤兽.数据)})
                玩家数据[数字id].角色:日志记录(format("[召唤兽系统-仓库存取]取出角色ID[%s]召唤兽认证码[%s]", 数字id, self.数据.召唤兽[页数][bianh].认证码))
                table.remove(self.数据.召唤兽[页数], bianh)

                -- 通知所有账号成员
                if type(self.帐号id组) == "table" then
                    for n = 1, #self.帐号id组 do
                        if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                            发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
                                召唤兽仓库数据 = table.copy(self.数据.召唤兽[页数]),
                                页数 = 页数,
                                界面 = 内容.界面
                            })
                        end
                    end
                end
            end
        else
            常规提示(数字id, "携带召唤兽数量达到上限")
        end
    end

    -- 存档
    local 临时账号 = 玩家数据[数字id].角色.账号
    if 账号仓库数据[临时账号] ~= nil then
        账号仓库数据[临时账号]:账号仓库存档()
    end
end

-- 仓库取出道具事件
function 账号仓库类:仓库取走事件_道具(连接id, id, 数据)
    if 玩家数据[id].摊位数据 ~= nil then
        常规提示(id, "#Y/摆摊中无法操作仓库。")
        return
    end

    local 页数 = 1
    local 仓库格子 = 数据.物品
    local 类型 = 数据.类型

    -- 获取道具格子
    local 格子 = 玩家数据[id].角色:取道具格子1(类型)
    if 格子 == 0 then
        常规提示(id, "#Y/你身上没有足够的空间")
        return
    end

    -- 检查仓库道具是否存在
    local 道具id = 玩家数据[id].道具:取新编号()
    if self.数据[数据.仓库类型][页数] == nil or self.数据[数据.仓库类型][页数][仓库格子] == nil then
        常规提示(id, "#Y/整理仓库后,请重新选择分类")
        return
    end

    -- 取出道具
    玩家数据[id].道具.数据[道具id] = table.copy(self.数据[数据.仓库类型][页数][仓库格子])
    玩家数据[id].角色[类型][格子] = 道具id
    self.数据[数据.仓库类型][页数][仓库格子] = nil

    -- 刷新并通知
    道具刷新(id)
    发送数据(连接id, 3513, 玩家数据[id].道具:索要道具2(id))

    -- 通知所有账号成员
    if type(self.帐号id组) == "table" then
        for n = 1, #self.帐号id组 do
            if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
                    类型 = self.仓库类型,
                    道具 = self:索要仓库道具(数字id, 页数, 数据.仓库类型),
                    页数 = 数据.页数,
                    界面 = 数据.界面,
                    道具仓库总数 = self.数据[self.仓库类型].总数 / 56
                })
            end
        end
    end

    -- 发送道具或行囊数据
    if 类型 == "道具" then
        发送数据(连接id, 414, {类型 = "道具", 数据 = 玩家数据[id].道具:索要道具2(id)})
    elseif 类型 == "行囊" then
        发送数据(连接id, 414, {类型 = "行囊", 数据 = 玩家数据[id].道具:索要行囊2(id)})
    end

    -- 存档
    local 临时账号 = 玩家数据[id].角色.账号
    if 账号仓库数据[临时账号] ~= nil then
        账号仓库数据[临时账号]:账号仓库存档()
    end
end

-- 获取仓库道具数据
function 账号仓库类:索要仓库道具(id, 页, 类型)
    -- print(类型)
    self.发送数据 = {道具 = {}}
    self.发送数据[类型] = {}
    ----------------------------------C改
    self.仓库序列 = tonumber(self.仓库序列) or 1
    local 最大序列 = math.ceil(self.数据[类型].总数 / 56)
    self.仓库序列 = math.max(1, math.min(self.仓库序列, 最大序列))
    ----------------------------------C改

    -- 遍历仓库道具
    for n = 1 + (1 - self.仓库序列) * 56, 56 * self.仓库序列 do
        if self.数据[类型][1] and self.数据[类型][1][n] ~= nil then
            if self.数据[类型][1][n].名称 ~= nil then
                self.发送数据[类型][n] = table.copy(self.数据[类型][1][n])
            else
                -- 清理无效数据
                self.数据[类型][1][n] = nil
            end
        end
    end

    return self.发送数据
end

-- 账号仓库存档
function 账号仓库类:账号仓库存档()
    if not self or not self.账号 or type(self.账号) ~= "string" then
        return
    end

    -- 特殊账号不存档
    if self.账号 == "jiaren" then
        return
    end

    -- 写入文件
    写出文件([[data/]]..self.账号.."/超级仓库.txt", table.tostring(self.数据))

    -- 检查在线角色
    local 在线角色 = 0
    if type(self.帐号id组) == "table" then
        for n = 1, #self.帐号id组 do
            if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                在线角色 = 在线角色 + 1
            end
        end
    end

    -- 如果没有在线角色，清理数据
    if 在线角色 == 0 then
        账号仓库数据[self.账号] = nil
    end
end

-- 处理购买仓库
function 账号仓库类:处理购买仓库(连接id, 数字id)
    if self.数据[self.仓库类型].总数 >= 896 then--280
        常规提示(数字id, "最多只能购买16个仓库！")--5
        return
    end

    local 扣除费用
    local 扣除类型

    if self.数据[self.仓库类型].总数 <= 90000 then
        扣除费用 = 2000000
        扣除类型 = "银子"
    else
        扣除费用 = 500
        扣除类型 = "仙玉"
    end

    if 扣除费用 > 0 then
        if 扣除类型 == "银子" then
            if 玩家数据[数字id].角色:扣除银子(扣除费用, 0, 0, "购买仓库", 1) then
                self.数据[self.仓库类型].总数 = self.数据[self.仓库类型].总数 + 56
                常规提示(数字id, "购买共享仓库成功！")
                发送数据(连接id, 415, {
                    道具 = self:索要仓库道具(数字id, 1, self.仓库类型),
                    类型 = self.仓库类型,
                    总数 = self.数据[self.仓库类型].总数 / 56
                })
            else
                常规提示(数字id, "#R少侠你这银子也不够呀")
            end
        elseif 扣除类型 == "仙玉" then
            if 扣除仙玉(数字id, 扣除费用, "购买仓库") then
                self.数据[self.仓库类型].总数 = self.数据[self.仓库类型].总数 + 56
                常规提示(数字id, "购买共享仓库成功！")
                发送数据(连接id, 415, {
                    道具 = self:索要仓库道具(数字id, 1, self.仓库类型),
                    类型 = self.仓库类型,
                    总数 = self.数据[self.仓库类型].总数 / 56
                })
            else
                常规提示(数字id, "#R少侠你这仙玉也不够呀")
            end

        end
    end
               --------------------------------------------------C改
                     local 临时账号 = 玩家数据[数字id].角色.账号
    if 账号仓库数据[临时账号] ~= nil then
        账号仓库数据[临时账号]:账号仓库存档()
    end
                    --------------------------------------------------C改
end

-- 处理仓库序列切换
function 账号仓库类:处理仓库序列切换(数字id, 数据)
    self.仓库序列 = 数据.序列
    if type(self.帐号id组) == "table" then
        for n = 1, #self.帐号id组 do
            if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
                    道具 = self:索要仓库道具(数字id, 1, self.仓库类型),
                    类型 = self.仓库类型,
                    页数 = 数据.序列,
                    界面 = 数据.界面,
                    道具仓库总数 = qz(self.数据[self.仓库类型].总数 / 56)
                })
            end
        end
    end
end

-- 处理购买召唤兽仓库
function 账号仓库类:处理购买召唤兽仓库(连接id, 数字id)
    if #self.数据.召唤兽 >= 5 then
        常规提示(数字id, "最多只能购买5个召唤兽仓库！")
        return
    end

    local yzi = (#self.数据.召唤兽 - 1) * 1000000 + 1000000
    if 玩家数据[数字id].角色:扣除银子(yzi, 0, 0, "购买宝宝仓库", 1) then
        self.数据.召唤兽[#self.数据.召唤兽 + 1] = {}
        常规提示(数字id, "购买召唤兽仓库成功！")
        发送数据(连接id, 416, {
            召唤兽仓库总数 = #self.数据.召唤兽,
            召唤兽仓库数据 = self.数据.召唤兽[1]
        })
    else
        常规提示(数字id, "#R少侠你这银子也不够呀")
    end
end

-- 处理获取道具数据
function 账号仓库类:处理获取道具数据(数字id, 数据)
    if 数据.道具类型 == "道具" then
        发送数据(玩家数据[数字id].连接id, 414, {
            类型 = "道具",
            数据 = 玩家数据[数字id].道具:索要道具2(数字id)
        })
    elseif 数据.道具类型 == "行囊" then
        发送数据(玩家数据[数字id].连接id, 414, {
            类型 = "行囊",
            数据 = 玩家数据[数字id].道具:索要行囊2(数字id)
        })
    end
end

-- 处理切换召唤兽仓库页
function 账号仓库类:处理切换召唤兽仓库页(数字id, 数据)
    if 数据.序列 > #self.数据.召唤兽 then
        常规提示(数字id, "#Y/这已经是最后一页了")
        return
    elseif 数据.序列 < 1 then
        return
    end

    if type(self.帐号id组) == "table" then
        for n = 1, #self.帐号id组 do
            if 玩家数据[self.帐号id组[n]] ~= nil and 玩家数据[self.帐号id组[n]].连接id ~= nil then
                发送数据(玩家数据[self.帐号id组[n]].连接id, 413, {
                    召唤兽仓库数据 = self.数据.召唤兽[数据.序列],
                    页数 = 数据.序列,
                    宝宝列表 = 玩家数据[数字id].召唤兽.数据,
                    界面 = 数据.界面
                })
            end
        end
    end
end

function 账号仓库类:处理移除过滤(连接id, 数字id, 数据)
    local 移除文本 = 数据.移除列表 or ""
    local 要移除列表 = {}
    -- 分割要移除的道具（保持原逻辑）
    for 道具名 in string.gmatch(移除文本, "[^,]+") do
        道具名 = string.gsub(道具名, "^%s+", ""):gsub("%s+$", "") -- 去空格
        if 道具名 ~= "" then table.insert(要移除列表, 道具名) end
    end
    -- 从现有过滤列表中移除目标道具（原逻辑正确，过滤能生效）
    local 现有过滤 = self.数据.一键存放过滤列表 or {} -- 假设是 {[道具名]=true} 结构
    local 移除数量 = 0
    for _, 道具名 in ipairs(要移除列表) do
        if 现有过滤[道具名] then
            现有过滤[道具名] = nil -- 移除过滤，这步正确所以能取消
            移除数量 = 移除数量 + 1
        end
    end
    local 最新过滤文本 = ""
    local 最新过滤项 = {}
    for 道具名, _ in pairs(现有过滤) do
        table.insert(最新过滤项, 道具名)
    end
    最新过滤文本 = table.concat(最新过滤项, ",")
    -- 发送给客户端，更新显示
    发送数据(连接id, 413.2, {
        类型 = "一键存放过滤",
        最新过滤列表 = 最新过滤文本, -- 客户端接收后更新 self.当前过滤列表
        提示 = string.format("#G已移除%d个过滤项！", 移除数量)
    })

    -- 关键修正：用标准遍历获取表的所有键（替代 table.keys）
    local 所有过滤键 = {} -- 存放现有过滤的所有道具名
    for 道具名, _ in pairs(现有过滤) do -- 遍历哈希表的键
        table.insert(所有过滤键, 道具名)
    end
    -- 拼接最新过滤文本（按插入顺序，不影响功能）
    local 最新过滤文本 = table.concat(所有过滤键, ",")

    -- 同步给客户端（客户端下次打开时显示最新列表）
    发送数据(连接id, 413, {最新过滤列表=最新过滤文本})
    常规提示(数字id, string.format("#G/移除成功！共移除%d个过滤项", 移除数量))
end

function 账号仓库类:处理一键存放过滤设置(连接id, 数字id, 数据)
    local 过滤文本 = 数据.过滤列表 or ""
    local 过滤集合 = self.数据.一键存放过滤列表 or {}  -- 从已有数据读取，无则初始化为空表
    if 过滤文本 == "" then
        常规提示(数字id, "#Y未输入要添加的过滤道具，保留原有过滤设置！")
        return
    end
    local 当前数量 = 0
    for _ in pairs(过滤集合) do
        当前数量 = 当前数量 + 1
    end
    local 新道具列表 = {}
    for 道具名 in string.gmatch(过滤文本, "[^,]+") do
        道具名 = string.gsub(道具名, "^%s+", "")
        道具名 = string.gsub(道具名, "%s+$", "")
        if 道具名 ~= "" and not 过滤集合[道具名] then
            table.insert(新道具列表, 道具名)
        end
    end
    local 新增数量 = #新道具列表
    local 上限=54
    if 当前数量 + 新增数量 > 上限 then
        local 最多可新增 = 上限 - 当前数量
        常规提示(数字id, string.format(
            "#R过滤列表最多只能添加"..上限.."个道具！当前已有%d个，本次最多可再添加%d个，无法全部添加！",
            当前数量, 最多可新增
        ))
        local 当前有效过滤项 = {}
        for 道具名, _ in pairs(过滤集合) do
            table.insert(当前有效过滤项, 道具名)
        end
        local 当前有效过滤文本 = table.concat(当前有效过滤项, ",")
        发送数据(连接id, 413.2, {
            类型 = "一键存放过滤",
            最新过滤列表 = 当前有效过滤文本,  -- 客户端刷新为实际保存的10个
            提示 = "#R过滤数量已达上限，未添加新道具！"
        })
        return  -- 终止流程，不执行后续添加操作
    end
    for _, 道具名 in ipairs(新道具列表) do
        过滤集合[道具名] = true
    end
    self.数据.一键存放过滤列表 = 过滤集合
    self:账号仓库存档()
    local 最新过滤项 = {}
    for 道具名, _ in pairs(过滤集合) do
        table.insert(最新过滤项, 道具名)
    end
    local 最新过滤文本 = table.concat(最新过滤项, ",")
    发送数据(连接id, 413.2, {
        类型 = "一键存放过滤",
        最新过滤列表 = 最新过滤文本,
        提示 = "#G一键存放过滤列表已更新！"
    })
    local 总过滤数量 = #最新过滤项
    常规提示(数字id, string.format("#G一键存放过滤列表已更新！当前共过滤%d个道具（上限"..上限.."个）", 总过滤数量))
end

function 账号仓库类:账号仓库一键存放(连接id, 数字id, 数据)
    -- 原有代码：基础状态检查
    if 玩家数据[数字id].摊位数据 ~= nil then
        常规提示(数字id, "#Y/摆摊中无法操作仓库。")
        return
    end
    -- 初始化变量（新增仓库满列表，记录仓库类型及对应道具）
    local 成功存放数量 = 0
    local 不可存放列表 = {} -- 其他原因（过滤、特殊道具等）
    local 仓库满列表 = {} -- 新增：{仓库类型 = {道具名1, 道具名2, ...}}
    local 背包类型 = "道具"
    local 过滤列表 = self.数据.一键存放过滤列表 or {}
    local 背包总格子 = 80
    -- 遍历背包格子（仅修改仓库满的记录逻辑）
    for 背包格子 = 1, 背包总格子 do
        local 道具id = 玩家数据[数字id].角色[背包类型][背包格子]
        if 道具id == nil or 玩家数据[数字id].道具.数据[道具id] == nil then
            goto 下一个格子
        end

        local 当前道具 = 玩家数据[数字id].道具.数据[道具id]
        local 道具名 = 当前道具.名称

        -- 过滤的道具记录（不变）
        if 过滤列表[道具名] == true then
            table.insert(不可存放列表, 道具名.."（已过滤）")
            goto 下一个格子
        end

        -- 特殊道具记录（不变）
        if 道具名 == "自动抓鬼卡" or
           道具名 == "自动抓鬼年卡" or
           道具名 == "人族时空之钥" or
           道具名 == "魔族时空之钥" or
           道具名 == "仙族时空之钥" or
           道具名 == "超级合成旗" or
           道具名 == "新春飞行符" or
           道具名 == "良师册" then
            table.insert(不可存放列表, 道具名)
            goto 下一个格子
        end

        -- 仓库类型判断（不变）
        local 目标仓库类型 = self:取道具类型(当前道具)
        if 目标仓库类型 == nil then
            table.insert(不可存放列表, 道具名.."（数据错误）")
            goto 下一个格子
        end

        -- 仓库初始化（不变）
        if self.数据[目标仓库类型] == nil then
            self.数据[目标仓库类型] = {[1] = {}, 总数 = 56}
        end
        if self.数据[目标仓库类型].总数 == nil then
            self.数据[目标仓库类型].总数 = 56
        end

        -- 查找仓库空格（不变）
        local 仓库空格 = 0
        for 仓库格子 = 1, self.数据[目标仓库类型].总数 do
            if self.数据[目标仓库类型][1][仓库格子] == nil then
                仓库空格 = 仓库格子
                break
            end
        end

        -- 仓库满记录（修改：记录到仓库满列表，而非不可存放列表）
        if 仓库空格 == 0 then
            -- 初始化该仓库类型的列表
            if not 仓库满列表[目标仓库类型] then
                仓库满列表[目标仓库类型] = {}
            end
            table.insert(仓库满列表[目标仓库类型], 道具名) -- 记录到对应仓库类型
            goto 下一个格子
        end

        -- 执行存放操作（不变）
        local 复制道具 = table.copy(当前道具)
        玩家数据[数字id].角色[背包类型][背包格子] = nil
        玩家数据[数字id].道具.数据[道具id] = nil
        self.数据[目标仓库类型][1][仓库空格] = 复制道具
        成功存放数量 = 成功存放数量 + 1

        ::下一个格子::
    end

    -- 成功存放提示（不变）
    if 成功存放数量 > 0 then
        常规提示(数字id, "#G/一键存放完成！共成功存放"..成功存放数量.."个道具")
    end

    -- 核心修改：生成包含“仓库类型满”的提示
    local 提示内容 = {} -- 收集所有提示片段

    -- 1. 处理仓库满的情况
    for 仓库类型, 道具列表 in pairs(仓库满列表) do
        local 道具文本 = table.concat(道具列表, "、")
        table.insert(提示内容, "#G/"..仓库类型.."#Y/仓库已满，无法存放："..道具文本)
    end

    -- 2. 处理其他不可存放的情况（过滤、特殊道具等）
    if #不可存放列表 > 0 then
        local 其他文本 = table.concat(不可存放列表, "、")
        table.insert(提示内容, "#Y/无法存放的道具："..其他文本)
    end

    -- 3. 无任何不可存放且未成功存放时的提示
    if #提示内容 == 0 and 成功存放数量 == 0 then
        常规提示(数字id, "#Y/无符合条件的道具可存放")
    else
        -- 拼接所有提示并发送
        for _, 文本 in ipairs(提示内容) do
            常规提示(数字id, 文本)
        end
    end

    -- 刷新与存档（完全不变）
    if 成功存放数量 > 0 then
        道具刷新(数字id)
        发送数据(连接id, 3513, 玩家数据[数字id].道具:索要道具2(数字id))

        if type(self.帐号id组) == "table" then
            for n = 1, #self.帐号id组 do
                local 成员id = self.帐号id组[n]
                if 玩家数据[成员id] ~= nil and 玩家数据[成员id].连接id ~= nil then
                    local 当前仓库类型 = self.仓库类型
                    if 当前仓库类型 ~= "召唤兽" and 当前仓库类型 ~= "一键存放过滤列表" then
                        发送数据(玩家数据[成员id].连接id, 413, {
                            类型 = 当前仓库类型,
                            道具 = self:索要仓库道具(数字id, 1, 当前仓库类型),
                            页数 = 1,
                            界面 = "道具",
                            道具仓库总数 = self.数据[当前仓库类型].总数 / 56
                        })
                    end
                end
            end
        end

        if 背包类型 == "道具" then
            发送数据(连接id, 414, {类型 = "道具", 数据 = 玩家数据[数字id].道具:索要道具2(数字id)})
        elseif 背包类型 == "行囊" then
            发送数据(连接id, 414, {类型 = "行囊", 数据 = 玩家数据[数字id].道具:索要行囊2(数字id)})
        end
    end

    local 临时账号 = 玩家数据[数字id].角色.账号
    if 账号仓库数据[临时账号] ~= nil then
        账号仓库数据[临时账号]:账号仓库存档()
    end

end

return 账号仓库类