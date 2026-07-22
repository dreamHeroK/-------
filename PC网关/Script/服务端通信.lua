__服务端通信 = require("Script/ggeclient")()
function __服务端通信:连接成功(id)
	self.数据id = id
	__gge.print(false,10,"【成功】！\n")
end

function __服务端通信:连接断开(so,ec)
	print("服务端连接已断开！",so,ec)
  尝试重连服务端=true
end

function __服务端通信:连接处理()
  if self:连接(网关参数.连接ip,网关参数.连接端口) then
    __gge.print(true,7,"连接服务端-->")
    __gge.print(false,10,"【成功】！\n")
    self:发送(9527,"PC")
    __S服务:置标题("单机网关("..网关参数.版本号..")")
  else
    print("连接服务端失败！")
  end
end

function __服务端通信:重新连接()
  if self:连接(网关参数.连接ip,网关参数.连接端口) then
    __gge.print(true,7,"重连接服务端-->")
    __gge.print(false,10,"【成功】！\n")
    self:发送(9527,"PC")
    尝试重连服务端=nil
    for i in pairs(__C客户信息) do
      if __C客户信息[i].账号 ~= nil and __C客户信息[i].密码 ~= nil and __C客户信息[i].IP ~= nil and __C客户信息[i].数字id ~= nil then
        self:更新客户信息(i,"连接进入")
        self:发送数据(i,table.tostring({序号=4,内容={账号=__C客户信息[i].账号,id=__C客户信息[i].数字id,ip=__C客户信息[i].IP}})) --进入游戏
      	处理类:发送数据(i,995)
      else
        __S服务:断开连接(i,"服务器断开,请重新登录")
      end
    end
  else
    print("连接服务端失败！")
  end
end

function __服务端通信:数据到达(id,data)  --服务端-网关-客户端
  if id == nil then
    return
  end
  if data then
    local 数据 = table.loadstring(data)
    if 数据 == nil or id == nil then
      return
    end
    if 数据.序号==998 then
      处理类:断开连接(id)
    elseif 数据.序号==10997 then
      __C客户信息[id].数字id = tostring(数据.内容.数字id)
    end
  end
  __S服务:发送(id,jm(data))
end

function __服务端通信:发送数据(id,内容)
  self:发送(id,内容)
end

function __服务端通信:更新客户信息(ID,类型)
  self:发送(ID,table.tostring({序号=99997,ID=ID,原始ID=ID,类型=类型,方式="PC"}))
end