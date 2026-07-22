__服务端通信 = require("Script/ggeclient")()

function __服务端通信:连接成功(id)
	self.数据id = id
	__gge.print(false,10,"【成功】！\n")
end

function __服务端通信:数据到达(id,data)  --服务端-网关-客户端
	if data then
		local 数据 = table.loadstring(data)
		if 数据	then
			if 数据.序号==998 then
				if __C客户信息[id] == nil then
					print("连接id不存在",id)
				else
					__C客户信息[id].断开方式='顶号断开'
				end
			elseif 数据.序号==10997 then
		      	__C客户信息[id].数字id = tostring(数据.内容.数字id)
		    end
		end
	end
	__客户端通信:发送_(id,data)
end

function __服务端通信:连接断开(so,ec)
	print("服务端连接已断开！",so,ec)
    尝试重连服务端=true
end

function __服务端通信:连接处理()
  if self:连接(网关参数.连接ip,网关参数.连接端口) then
    __gge.print(true,7,"连接服务端-->")
    __gge.print(false,10,"【成功】！\n")
    self:发送(9527,"安卓")
  else
    print("连接服务端失败！")
  end
end

function __服务端通信:重新连接()
  if self:连接(网关参数.连接ip,网关参数.连接端口) then
    __gge.print(true,7,"重连接服务端-->")
    __gge.print(false,10,"【成功】！\n")
    self:发送(9527,"安卓")
    尝试重连服务端=nil
    for i in pairs(__C客户信息) do
      if __C客户信息[i].账号 ~= nil and __C客户信息[i].密码 ~= nil and __C客户信息[i].IP ~= nil and __C客户信息[i].数字id ~= nil then
        __客户端通信:更新客户信息(i,"连接进入","安卓")
        __客户端通信:发送(i,table.tostring({序号=4,ID=i.. "95278",内容={账号=__C客户信息[i].账号,id=__C客户信息[i].数字id,ip=__C客户信息[i].IP}})) --进入游戏
      	__客户端通信:发送_(i,table.tostring({序号=995}))
      else
        __客户端通信:断开连接(i,"服务器断开,请重新登录")
      end
    end
  else
    print("连接服务端失败！")
  end
end


