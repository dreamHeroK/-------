-- -- @Author: baidwwy
-- -- @Date:   2023-11-28 22:56:30
-- -- @Last Modified by:   baidwwy
-- -- @Last Modified time: 2026-01-03 14:48:55
-- local ffi = require("ffi")
-- local 数据数量 = ffi.new("int[1]")
-- local 线程发送数据 = {}
-- local fenzhong = 654
-- local 定时器 = class()
-- local meige = 6
-- function 定时器:初始化(v,循环文件)
-- 	self.线程 = require("ggethread")(循环文件)
-- 	self.线程.消息返回 = function(self,...)
-- 		if ... == "取数量指针" then
-- 		    return tonumber(ffi.cast("intptr_t",数据数量))
-- 		elseif ... == "取数据" then
-- 			local r = 线程发送数据[1]
-- 			return unpack(r)
-- 		elseif ... == "循环更新" then
-- 			if meige == 0 then ---每分钟01秒
-- 				-- 线下自动抓鬼数据[数字id]={zcs=200,leij=0,on=true,jiangli=0}
-- 				for k,v in pairs(线下自动抓鬼数据) do
-- 					if v.on then
-- 						local id组 = v.id组
-- 						v.zcs=v.zcs-1
-- 						v.leij=v.leij+1
-- 						玩家数据[k].角色.自动抓鬼.次数 = 玩家数据[k].角色.自动抓鬼.次数 - 1
-- 						if 玩家数据[k].角色.自动抓鬼.次数 <= 0 then
-- 							玩家数据[k].角色.自动抓鬼.次数 = 0
-- 						end
-- 						if v.leij < 10 and type(id组) == "table" then
-- 							战斗奖励:奖励事件(id组,nil,110077,nil)
-- 						else
-- 							for i = 1, #id组 do
-- 								战斗奖励:其他奖励(id组[i],"自动抓鬼10次")
-- 							end
-- 						end
-- 						if v.leij == 10 then
-- 							v.leij = 0
-- 						end
-- 						if v.zcs<=0 then
-- 							v.on=false
-- 						end
-- 					end
-- 				end
-- 				meige = 6
-- 			else
-- 				meige = meige - 1
-- 			end
-- 		else
-- 			print("线程返回",...)
-- 		end
-- 	end
-- 	self:启动(v)
-- end



-- function 定时器:启动(v)
-- 	self.线程:启动(v)
-- 	self.线程:置延迟(v)
-- end

-- function 定时器:发送(...)--这里是不定数据,如果是固定的,可以参考客户的多线程 纹理
-- 	数据数量[0] = 数据数量[0]+1
-- 	table.insert(线程发送数据,{...})
-- end

-- return 定时器

local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local fenzhong = 654
local 定时器 = class()
local meige = 6
local format = string.format
local 取随机数 = 取随机数

function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			local r = 线程发送数据[1]
			return unpack(r)
		elseif ... == "循环更新" then
			if meige == 0 then ---每分钟01秒
				-- 线下自动抓鬼数据[数字id]={zcs=200,leij=0,on=true,jiangli=0}
				for k,v in pairs(线下自动抓鬼数据) do
					if v.on then
						local id组 = v.id组
						v.zcs=v.zcs-1
						v.leij=v.leij+1

						-- 获取队长ID
						local 队长id = k
						玩家数据[队长id].角色.自动抓鬼.次数 = 玩家数据[队长id].角色.自动抓鬼.次数 - 1
						if 玩家数据[队长id].角色.自动抓鬼.次数 <= 0 then
							玩家数据[队长id].角色.自动抓鬼.次数 = 0
						end

						if type(id组) == "table" then
							-- 计算队伍平均等级（使用第一个队员的等级作为基准）
							local 等级 = 0
							local 有效队员数 = 0
							for i=1,#id组 do
								if 玩家数据[id组[i]] and 玩家数据[id组[i]].角色 then
									等级 = 等级 + 玩家数据[id组[i]].角色.等级
									有效队员数 = 有效队员数 + 1
								end
							end
							if 有效队员数 > 0 then
								等级 = math.floor(等级 / 有效队员数)
							end

							-- 为每个队员发放奖励
							for i=1,#id组 do
								local id = id组[i]
								if 玩家数据[id] and 玩家数据[id].角色 then
									-- 计算经验和金钱
									local 经验 = 等级 * 165
									local 银子 = 等级 * 120

									-- 添加经验和金钱
									玩家数据[id].角色:添加经验(经验 * HDPZ["自动抓鬼"].经验, "捉鬼")
									local 银子前 = 玩家数据[id].角色.银子
									玩家数据[id].角色:添加银子(银子 * HDPZ["自动抓鬼"].银子, "捉鬼", 1)
									local 实际银子 = 玩家数据[id].角色.银子 - 银子前
									玩家数据[id].角色:添加储备(math.floor(实际银子 * 0.5), "捉鬼", 1)

									-- 每10次有额外奖励
									if v.leij == 10 then
										if 取随机数() <= HDPZ["自动抓鬼"].爆率 then
											local 链接 = {
												提示 = format("#P(轮回幻境)#W玩家#Y%s#W帮助钟馗追击鬼魂有功，钟馗送出一个", 玩家数据[id].角色.名称),
												频道 = "hd",
												结尾 = "#W作为奖励！#80"
											}
											local 名称, 数量, 参数 = 糖果生成产出(糖果产出物品计算(HDPZ["自动抓鬼"].ITEM), "自动抓鬼")
											if 数量 == 9999 then --环
												玩家数据[id].道具:给予道具(id, nil, nil, nil, nil, nil, 名称, nil, nil, nil, 链接)
											else
												玩家数据[id].道具:给予超链接道具(id, 名称, 数量, 参数, 链接)
											end
										end
									end
								end
							end

							if v.leij == 10 then
								v.leij = 0
							end
						end

						-- 检查是否完成所有次数
						if v.zcs <= 0 then
							v.on = false
							线下自动抓鬼数据[k] = nil  -- 清理数据
							-- 这里可以添加完成提示，但玩家不在线，所以暂时不处理
						end
					end
				end
				meige = 6
			else
				meige = meige - 1
			end
		else
			print("线程返回",...)
		end
	end
	self:启动(v)
end

function 定时器:启动(v)
	self.线程:启动(v)
	self.线程:置延迟(v)
end

function 定时器:发送(...)--这里是不定数据,如果是固定的,可以参考客户的多线程 纹理
	数据数量[0] = 数据数量[0]+1
	table.insert(线程发送数据,{...})
end

return 定时器
