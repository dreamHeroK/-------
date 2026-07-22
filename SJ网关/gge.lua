-- @Author: 作者QQ381990860
-- @Date:   2023-10-29 16:42:50
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-12-17 12:41:19
__客户端通信 = require("hp/PackServer")('网关')
__客户端通信:置标题('安卓网关')
__客户端通信.发送_ = __客户端通信.发送

function __客户端通信:发送(id,内容)
	id = id .. "95278"
	__服务端通信:发送(id+0,内容)
end

function __客户端通信:启动成功()
end

function __客户端通信:连接进入(id,ip,port)
	print(string.format('玩家连接(%s):%s:%s',id,ip,port))
	__C客户信息[id] = {
	 	IP = ip,
	 	id=id,
		PORT = port,
		sj=os.time(),
	}
	网关参数.当前连接数=网关参数.当前连接数+1
	self:置标题("安卓网关 - 当前在线人数:"..网关参数.当前连接数)
	self:更新客户信息(id,"连接进入","安卓")
end
function __客户端通信:连接退出(id,so,ec)
	print(string.format('玩家退出(%s):%s:%s',id,so,ec))
	__客户端通信:断开处理(__C客户信息[id])
	 __客户端通信:更新客户信息(id,"连接退出","安卓")
	__C客户信息[id] = nil
end

function __客户端通信:更新客户信息(ID,类型,方式)
	self:发送(ID,table.tostring({序号=99997,ID=ID.."95278"+0,原始ID=ID,类型=类型,方式=方式}))
end

function 消息返回(等到数据)


end

__客户端通信:置预投递数量(2000)
__客户端通信:启动(网关参数.启动ip,网关参数.启动端口)--外网
