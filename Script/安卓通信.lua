__安卓通信 = require("Script/ggeserver")()
__安卓通信:启动(连接ip,AD端口,"AD") --安卓

function __安卓通信:启动成功()

end

function __安卓通信:连接进入(ID,IP,PORT)
	if IP==连接ip then
		__S服务:输出(string.format('安卓网关进入(%s):%s:%s',ID, IP,PORT))
		__AD客户信息[ID] = {
			IP = IP,
			认证=os.time(),
			PORT = PORT,
			网关=true
		}
	else
		__S服务:输出(string.format('其他客户进入(%s):%s:%s',ID, IP,PORT))
		__AD客户信息[ID] = {
			IP = IP,
			认证=os.time(),
			PORT = PORT,
		}
	end
end

function __安卓通信:连接退出(id,so,ec)
	if __AD客户信息[ID] then
		if __AD客户信息[ID].网关 then
			__S服务:输出(string.format('安卓网关客户退出(%s):%s:%s', ID,__AD客户信息[ID].IP,__AD客户信息[ID].PORT))
		else
		    __S服务:输出(string.format('其他连接退出(%s):%s:%s', ID,__AD客户信息[ID].IP,__AD客户信息[ID].PORT))
		end
	else
		__S服务:输出("连接不存在(连接退出)。")
	end
end

function __安卓通信:数据到达(ID,...)
	local arg = {...}
	if __AD客户信息[ID] then
		if __AD客户信息[ID].网关 then
			if arg[1] == 9527 then
		      	__AD客户信息[ID].类型 = arg[2]
		      	服务端参数[arg[2] .. "网关id"]=ID
		      	__S服务:输出(arg[2] .. "网关已经验证成功,可以正常使用了！")
			else
				if __AD客户信息[ID].类型 == nil then
		          __S服务:输出(string.format('网关客户(%s)尚未验证类型:%s:%s',ID,__AD客户信息[ID].IP,__AD客户信息[ID].PORT))
		          __S服务:断开连接(ID)
		          return
		        end
				网络处理类:数据处理(arg[1],arg[2])
			end
		end
	else
		__S服务:输出("连接不存在(数据到达)。")
	end
end


