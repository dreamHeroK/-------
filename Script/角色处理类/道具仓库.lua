
local 道具仓库类 = class()

function 道具仓库类:初始化(id,数字id)
	self.玩家id=数字id
	self.数据={}
end
function 道具仓库类:数据处理(连接id,序号,数字id,数据)
	if 序号==6701 then --索取仓库信息
		local 最大页数 = #self.数据
		-- if  最大页数 >= 20 then
		-- 	最大页数 = 20
		-- end
		发送数据(连接id,3513,玩家数据[数字id].道具:索要道具2(数字id)) --右侧道具栏
		发送数据(连接id,3523,{道具=self:索要仓库道具(数字id,1),道具仓库总数=#self.数据,召唤兽仓库总数=#宝宝仓库数据[玩家数据[数字id].账号].召唤兽.数据})
	elseif 序号==6702 then
		self:仓库存放事件(连接id,数字id,数据)
	elseif 序号==6703 then
		self:仓库取走事件(连接id,数字id,数据)
	elseif 序号==6704 then
		local 可购仓库数 = 99
    		if #self.数据 >=可购仓库数 then 常规提示(数字id,"最多只能购买"..可购仓库数.."个仓库！") return end
		local yzi = 1000000
		if 玩家数据[数字id].角色:扣除银子(yzi,0,0,"购买仓库",1) then
			self.数据[#self.数据+1]={}
			常规提示(数字id,"购买仓库成功！")
			发送数据(连接id,3533,{道具=self:索要仓库道具(数字id,1),总数=#self.数据})
		else
			常规提示(数字id,"#R少侠你这银子也不够呀")
		end
	elseif 序号==6705 then
		local 最大页数 = #self.数据

		if 数据.序列>最大页数 then
			常规提示(数字id,"#Y/这已经是最后一页了")
			return
		elseif 数据.序列<1 then
			return
		end
		发送数据(连接id,3524,{道具=self:索要仓库道具(数字id,数据.序列),页数=数据.序列})
	elseif 序号==6706 then
		self:仓库整理事件(连接id,数字id,数据)
	elseif 序号 == 6707 then
		self:仓库一键整理(连接id,数字id,数据)
	end
end

function 道具仓库类:加载数据(账号,数字id)
      if f函数.文件是否存在([[data/]]..账号..[[/道具仓库.txt]])==false then
      self.数据={[1]={},[2]={},[3]={}}
      写出文件([[data/]]..账号.."/道具仓库.txt",table.tostring(self.数据))
      else
      self.数据=table.loadstring(读入文件([[data/]]..账号..[[/道具仓库.txt]]))
      end
end

function 道具仓库类:仓库一键整理(连接id, id, 数据)
	if 处理间隔(id) then return end
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	local 临时道具 = {}
	local 最大页数 = #self.数据

	for n=1,最大页数 do
		for i=1,20 do
			local 道具id = self.数据[n][i]
			if 道具id then
				临时道具[#临时道具+1] = {道具id,物品权重(道具id)}
				self.数据[n][i]=nil
			end
		end
	end
	for i=1,#临时道具 do
  	local 道具id = 临时道具[i][1]
  	if 道具id and 道具id.数量 and 道具id.数量 < 999 and 道具id.可叠加 then
     	for n=i+1,#临时道具 do
        local 临时道具id = 临时道具[n][1]
        if 临时道具id and 临时道具id.名称 == 道具id.名称 and 临时道具id.数量 and 临时道具id.数量 < 999 then
        	if 取可否叠加(道具id,临时道具id) then
        	 	if 道具id.数量 + 临时道具id.数量 > 999 then
					    local 多余数量 = 道具id.数量 + 临时道具id.数量 - 999
					    道具id.数量 = 999
					    临时道具id.数量 = 多余数量
					  else
					  	道具id.数量 = 道具id.数量 + 临时道具id.数量
					  	临时道具[n][1] =nil
					  end
          end
        end
      end
 		end
	end
	local n=1
	local y=1
	table.sort(临时道具,function(a,b) return a[2]<b[2] end)
	for n=1,最大页数 do
		self.数据[n] = {}
	end
	for x=1,#临时道具 do
		local 道具id = 临时道具[x][1]
		if 道具id then
		  self.数据[n][y]=道具id
		  y = y + 1
		end
		if y > 20 then
		  n=n+1
			y = 1
		end
	end
	发送数据(玩家数据[id].连接id,3524,{道具=self:索要仓库道具(id,1),页数=1})
	常规提示(id,"#Y/整理成功")
end

-- function 道具仓库类:仓库整理事件(连接id,id, 数据)
--    if 玩家数据[id].整理仓库 ~= nil then
--         if os.time()-玩家数据[id].整理仓库 <= 3 then
--             常规提示(id,"不要频繁点击整理请"..(3-(os.time()-玩家数据[id].整理仓库)).."秒后再尝试！")
--             return
--         end
--     end
--     玩家数据[id].整理仓库=os.time()
--     local 临时道具栏 = {}
--     for n,v in ipairs(self.数据) do
--         for kk,vv in pairs(v) do
--             if vv.数量 then
--             	local found=false
--                 for sn,sv in ipairs(临时道具栏) do
--                     if sv.数量 and sv.名称 == vv.名称 and sv.可叠加  then
--                     	if (sv.名称== "元宵" and vv.名称=="元宵" )and sv.食材 ~= vv.食材 then
--                     	elseif (sv.名称== "钨金" and vv.名称=="钨金" ) and sv.级别限制 ~= vv.级别限制 then
--                     	elseif (sv.名称== "未激活的符石" and vv.名称=="未激活的符石" ) and sv.级别限制 ~= vv.级别限制 then
--                     	elseif sv.灵气~=vv.灵气 then

--                     	 elseif  sv.名称 == "灵犀玉" and vv.名称 == "灵犀玉" then
--                             if sv.特性 ==  vv.名称.特性 and  sv.子类==vv.子类  then
--                                  sv.数量=sv.数量+vv.名称.数量
--                           end
--                         elseif  sv.名称 == "焕彩石" and vv.名称 == "焕彩石" then
--                           if sv.等级 == vv.等级  then
--                              sv.数量=sv.数量+vv.数量
--                             end
--                         elseif  sv.名称 == "九转金丹" and vv.名称 == "九转金丹" then
--                           if sv.阶品 == vv.阶品  then
--                              sv.数量=sv.数量+vv.数量
--                             end
--                     -----------------------------------------------------------------------------------兽决叠加
--                     	elseif  sv.名称 == "高级魔兽要诀" and vv.名称 == "高级魔兽要诀" then
--                           if sv.附带技能 == vv.附带技能  then
--                              sv.数量=sv.数量+vv.数量
--                             end
--                         elseif  sv.名称 == "超级魔兽要诀" and vv.名称 == "超级魔兽要诀" then
--                           if sv.附带技能 == vv.附带技能  then
--                              sv.数量=sv.数量+vv.数量
--                             end
--                         elseif  sv.名称 == "魔兽要诀" and vv.名称 == "魔兽要诀" then
--                           if sv.附带技能 == vv.附带技能  then
--                              sv.数量=sv.数量+vv.数量
--                             end
--                         elseif  sv.名称 == "特殊魔兽要诀" and vv.名称 == "特殊魔兽要诀" then
--                           if sv.附带技能 == vv.附带技能  then
--                              sv.数量=sv.数量+vv.数量
--                             end
--                         elseif  sv.名称 == "高级召唤兽内丹" and vv.名称 == "高级召唤兽内丹" then
--                           if sv.特效 == vv.特效  then
--                              sv.数量=sv.数量+vv.数量
--                             end
--                         elseif  sv.名称 == "召唤兽内丹" and vv.名称 == "召唤兽内丹" then
--                           if sv.特效 == vv.特效  then
--                              sv.数量=sv.数量+vv.数量
--                             end


--                     -----------------------------------------------------------------------------------兽决叠加


--                     	else
-- 	                        sv.数量 = sv.数量 + vv.数量
-- 	                        found = true
-- 	                        break
-- 	                    end
--               	end
--                 end
--                 if not found then
--                     vv.type=道具排序表[vv.名称] or 9999999
--                     table.insert(临时道具栏, vv)
--                 end
--             else
--                 vv.type=道具排序表[vv.名称] or 9999999
--                 table.insert(临时道具栏, vv)
--             end
--             self.数据[n][kk] = nil
--         end
--     end

--     -- 清空原始数据
--     for n,v in ipairs(self.数据) do
--         self.数据[n] = {}
--     end

--     -- 分割道具到仓库中
--     table.sort(临时道具栏, function(a,b) return a.type + 0 < b.type + 0 end)
--     local 计数,指针 = 1, 1
--     for n,v in ipairs(临时道具栏) do
--         self.数据[指针][计数] = v
--         计数 = 计数 + 1
--         if 计数 > 20 then
--             计数, 指针 = 1, 指针 + 1
--         end
--     end
--     发送数据(玩家数据[id].连接id, 3524, {道具=self:索要仓库道具(id, 数据.页数), 页数=数据.页数})
-- end


function 道具仓库类:仓库整理事件(连接id, id, 数据)
    if 玩家数据[id].整理仓库 ~= nil then
        if os.time() - 玩家数据[id].整理仓库 <= 3 then
            常规提示(id, "不要频繁点击整理请" .. (3 - (os.time() - 玩家数据[id].整理仓库)) .. "秒后再尝试！")
            return
        end
    end
    玩家数据[id].整理仓库 = os.time()

    local 临时道具栏 = {}
    for n, v in ipairs(self.数据) do
        for kk, vv in pairs(v) do
            if vv.数量 then
                local found = false
                for sn, sv in ipairs(临时道具栏) do
                    if sv.数量 and sv.名称 == vv.名称 and sv.可叠加 then
                        -- 特殊物品处理
                        if sv.名称 == "元宵" and vv.名称 == "元宵" then
                            if sv.食材 ~= vv.食材 then
                                -- 食材不同不叠加
                            else
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "钨金" and vv.名称 == "钨金" then
                            if sv.等级 ~= vv.等级 then
                                -- 级别不同不叠加
                            else
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "未激活的符石" and vv.名称 == "未激活的符石" then
                            if sv.等级 ~= vv.等级 then
                                -- 级别不同不叠加
                            else
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.灵气 and vv.灵气 and sv.灵气 ~= vv.灵气 then
                            -- 灵气不同不叠加
                        elseif sv.名称 == "灵犀玉" and vv.名称 == "灵犀玉" then
                            -- 修正这里：使用 vv.特性 和 vv.数量
                            if sv.特性 == vv.特性 and sv.子类 == vv.子类 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "焕彩石" and vv.名称 == "焕彩石" then
                            if sv.等级 == vv.等级 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "九转金丹" and vv.名称 == "九转金丹" then
                            if sv.阶品 == vv.阶品 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        -- 兽决叠加
                        elseif sv.名称 == "高级魔兽要诀" and vv.名称 == "高级魔兽要诀" then
                            if sv.附带技能 == vv.附带技能 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "超级魔兽要诀" and vv.名称 == "超级魔兽要诀" then
                            if sv.附带技能 == vv.附带技能 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "魔兽要诀" and vv.名称 == "魔兽要诀" then
                            if sv.附带技能 == vv.附带技能 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "特殊魔兽要诀" and vv.名称 == "特殊魔兽要诀" then
                            if sv.附带技能 == vv.附带技能 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "高级召唤兽内丹" and vv.名称 == "高级召唤兽内丹" then
                            if sv.特效 == vv.特效 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        elseif sv.名称 == "召唤兽内丹" and vv.名称 == "召唤兽内丹" then
                            if sv.特效 == vv.特效 then
                                sv.数量 = sv.数量 + vv.数量
                                found = true
                                break
                            end
                        -- 普通可叠加物品
                        else
                            sv.数量 = sv.数量 + vv.数量
                            found = true
                            break
                        end
                    end
                end

                if not found then
                    vv.type = 道具排序表[vv.名称] or 9999999
                    table.insert(临时道具栏, vv)
                end
            else
                vv.type = 道具排序表[vv.名称] or 9999999
                table.insert(临时道具栏, vv)
            end
            self.数据[n][kk] = nil
        end
    end

    -- 清空原始数据
    for n, v in ipairs(self.数据) do
        self.数据[n] = {}
    end

    -- 分割道具到仓库中
    table.sort(临时道具栏, function(a, b)
        return (a.type or 9999999) < (b.type or 9999999)
    end)

    local 计数, 指针 = 1, 1
    for n, v in ipairs(临时道具栏) do
        self.数据[指针][计数] = v
        计数 = 计数 + 1
        if 计数 > 20 then
            计数, 指针 = 1, 指针 + 1
        end
    end

    发送数据(玩家数据[id].连接id, 3524, {道具 = self:索要仓库道具(id, 数据.页数), 页数 = 数据.页数})
end


function 道具仓库类:仓库存放事件(连接id,id,数据)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	if 收购数据[id]~=nil then
    常规提示(id,"#Y/摆摊中无法操作仓库。")
    return
  end
	local 页数=数据.页数
	local 道具=数据.物品
	local 格子=0
	local 类型=数据.类型
	if 类型 ~= "道具" and 类型 ~= "行囊" then
		return
	end
	for n=1,20 do
		if self.数据[页数][n]==nil and 格子==0 then
			格子=n
			break
		end
	end
	local 道具id = 玩家数据[id].角色[类型][道具]

	if 道具id==nil or 玩家数据[id].道具.数据[道具id]==nil then
		常规提示(id,"#Y/你没有这个物品！")
	    return
	elseif 玩家数据[id].道具.数据[道具id].临时附魔 ~= nil  then
	  	玩家数据[id].道具.数据[道具id].临时附魔 = nil
      常规提示(id,"#Y/存放成功、该装备附魔效果已消失！！！")
	end

	if 格子==0 then
		常规提示(id,"#Y/你这个仓库已经无法存放更多的物品了")
		return
	elseif 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼卡"  or 玩家数据[id].道具.数据[道具id].名称 == "自动抓鬼年卡" then
		常规提示(id,"#Y/自动抓鬼卡无法存入仓库")
		return
	end

	local asdsadw=table.copy(玩家数据[id].道具.数据[道具id])
	玩家数据[id].角色[类型][道具]=nil
	玩家数据[id].道具.数据[道具id] =nil
	self.数据[页数][格子]=asdsadw--玩家数据[id].道具.数据[道具id]
	-- 玩家数据[id].角色[类型][道具]=nil
	-- 玩家数据[id].道具.数据[道具id] =nil

	-- 玩家数据[id].角色.道具仓库[页数][格子]=格子 --同步

	道具刷新(id)
	--发送数据(连接id,3513,玩家数据[id][类型]:索要道具2(id))
	发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})

	if 类型 == "道具" then
		发送数据(连接id,3535,{类型="道具",数据=玩家数据[id].道具:索要道具2(id)})
	elseif 类型 == "行囊" then
		发送数据(连接id,3535,{类型="行囊",数据=玩家数据[id].道具:索要行囊2(id)})
	end

	-- local 道具id = 玩家数据[id].角色.道具[道具]
	-- self.数据[页数][格子]=玩家数据[id].道具.数据[道具id]
	-- -- 玩家数据[id].角色.道具仓库[页数][格子]=格子 --同步
	-- 玩家数据[id].角色.道具[道具]=nil
	-- 玩家数据[id].道具.数据[道具id] =nil
	-- 道具刷新(id)
	-- 发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
	-- 发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})

	-- 发送数据(连接id,3525)
end

function 道具仓库类:仓库取走事件(连接id,id,数据)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	if 收购数据[id]~=nil then
    常规提示(id,"#Y/摆摊中无法操作仓库。")
    return
  end
	local 页数=数据.页数
	local 仓库格子=数据.物品
	local 类型 =数据.类型
	local 格子=玩家数据[id].角色:取道具格子1(类型) --从1-20取空实际上看到的道具 == 玩家数据[id].角色.道具["格子"] 的 "格子"
	if 类型 =="行囊" then
	  格子=玩家数据[id].角色:取行囊格子()
	end
	if 格子==0 then
		常规提示(id,"#Y/你身上没有足够的空间")
		return
	elseif self.数据[页数] == nil or self.数据[页数][仓库格子] == nil then
		常规提示(id,"#Y/没有这件物品")
		return
	end
	local 道具id = 玩家数据[id].道具:取新编号()
	玩家数据[id].道具.数据[道具id] = table.copy((self.数据[页数][仓库格子]))
	玩家数据[id].角色[类型][格子]=道具id
	-- 玩家数据[id].角色.道具仓库[页数][仓库格子]=nil
	self.数据[页数][仓库格子]=nil

	道具刷新(id)
	--发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
	发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})
	if 类型 == "道具" then
		发送数据(连接id,3535,{类型="道具",数据=玩家数据[id].道具:索要道具2(id)})
	elseif 类型 == "行囊" then
		发送数据(连接id,3535,{类型="行囊",数据=玩家数据[id].道具:索要行囊2(id)})
	end
end

function 道具仓库类:索要仓库道具(id,页)
	self.发送数据={道具={}}
	for n=1,20 do
		if self.数据[页] and self.数据[页][n]~=nil then
			if self.数据[页][n].名称~=nil then
				self.发送数据.道具[n]=table.copy((self.数据[页][n]))
			else
			    self.数据[页][n]=nil
			end
		end
	end
	return self.发送数据
end

function 道具仓库类:更新(dt) end

function 道具仓库类:显示(x,y) end

return 道具仓库类