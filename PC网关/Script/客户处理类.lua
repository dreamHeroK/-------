
local 客户处理类 = class()
function 客户处理类:初始化() end
function 客户处理类:更新(dt) end
function 客户处理类:连接处理(客户)
  self:发送数据(客户.id,1)
  __服务端通信:更新客户信息(客户.id,"连接进入")
end
function 客户处理类:数据处理(id,内容)
  -- print(内容)
  if __C客户信息[id] then
    __C客户信息[id].sj = os.time()
    __C客户信息[id].卡死已记录 = nil
  end
  内容=jm1(内容)
  if 内容==nil or 内容=="" then
    self:发送数据(id,"999","您的客户端版本过低，请先升级客户端")
    self:断开连接(id)
    return
  end
  self.数据=分割文本(内容,fgf)
  if self.数据==nil or (self.数据~=nil and #self.数据 > 0 and self.数据[1]==nil) then
    self:发送数据(id,"999","您的客户端版本过低，请先升级客户端1")
    self:断开连接(id)
    return
  end
  self.数据[1]=self.数据[1]+0
  if self.数据[1]==1 or self.数据[1]==1.1 then --版本验证
    self.临时数据=分割文本(self.数据[2],fgc)
    if tonumber(self.临时数据[1])~=tonumber(网关参数.版本号) then
      self:发送数据(id,"999","您的客户端版本过低，请先升级客户端")
      self:断开连接(id)
      return
    else
      __C客户信息[id].账号=self.临时数据[2]
      __C客户信息[id].密码=self.临时数据[3]
      __C客户信息[id].硬盘=self.临时数据[4]
      __服务端通信:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=self.临时数据[2],密码=self.临时数据[3],硬盘=self.临时数据[4],推荐码=self.临时数据[5],ip=__C客户信息[id].IP}}))
    end
  elseif self.数据[1]==2 then
    __服务端通信:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号}}))
  elseif self.数据[1]==3 then
    __服务端通信:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号,模型=self.数据[2],名称=self.数据[3],染色ID=self.数据[4],ip=__C客户信息[id].IP}}))
  elseif self.数据[1]==4 then
    __C客户信息[id].数字id=self.数据[2]
    全局信息记录[tonumber(self.数据[2])] = {账号=__C客户信息[id].账号,密码=__C客户信息[id].密码,连接id=id}
    __服务端通信:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号,id=self.数据[2],ip=__C客户信息[id].IP}}))
  elseif self.数据[1]==99996 then --
    if __C客户信息[id].上次 == nil then
      __C客户信息[id].上次 = os.time()
      __C客户信息[id].次数 = 0
    else
      if os.time() - __C客户信息[id].上次 < 29 then
        __C客户信息[id].次数 = __C客户信息[id].次数 + 1
        if __C客户信息[id].次数 >= 2 then --
          print("单分钟内收到多次验证，该玩家疑似使用加速软件",__C客户信息[id].账号,__C客户信息[id].数字id)
          __C客户信息[id].次数 = 0
        end
        __C客户信息[id].上次 = os.time()
      else
        __C客户信息[id].次数 = 0
        __C客户信息[id].上次 = os.time()
      end
    end
  else
     if self.数据[3]==nil then
      self:发送数据(id,"999","您的数据出现非法操作1!")
      self:断开连接(id)
      return
    elseif not tonumber(self.数据[3]) then
      self:发送数据(id,"999","您的数据非法操作2!")
      self:断开连接(id)
      return
    -- elseif os.time()-self.数据[3]>=30 then
    --   self:发送数据(id,"999","您的数据严重延迟,请检查网络是否异常后继续游戏!")
    --   self:断开连接(id)
    --   return
    end
    if type(self.数据[2]) == "string" and string.len(self.数据[2]) > 1000 then
      print("以下为数据超过1000："..self.数据[2])
      print(string.len(self.数据[2]))
    end
    self.临时数据=table.loadstring(self.数据[2])
    if self.临时数据==nil or self.临时数据=="" then return  end
    self.临时数据.ip=__C客户信息[id].IP
    self.临时数据.序号=self.数据[1]
    self.临时数据.数字id=__C客户信息[id].数字id
    __服务端通信:发送数据(id,table.tostring(self.临时数据))
	end
end

function 客户处理类:断开处理(信息)
  网关参数.当前连接数=网关参数.当前连接数-1
  if 信息.数字id~=nil then
    __服务端通信:发送数据(信息.id,table.tostring({内容=信息.数字id,序号=5}))
  end
end

function 客户处理类:断开连接(id)
  网关参数.当前连接数=网关参数.当前连接数-1
  __S服务:断开连接(id)
  __C客户信息[id]=nil
  __服务端通信:更新客户信息(id,"连接退出")
end

function 客户处理类:发送数据(id,序号,内容)
  if 内容==nil then
    内容="14545WOWa啊啊我啊"
  end
  组合内容={序号=序号,内容=内容}
  __S服务:发送(id,jm(table.tostring(组合内容)))
end
function 客户处理类:显示(x,y) end
return 客户处理类