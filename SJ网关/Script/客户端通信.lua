function __客户端通信:数据到达(id,data)
	if __C客户信息[id] then
		__C客户信息[id].sj = os.time()
		__C客户信息[id].卡死已记录 = nil
	end
	data = 分割文本(data,"*-*")
	if tonumber(data[1]) == 1 or tonumber(data[1]) == 1.1 then
		__C客户信息[id].账号=data[3]
		__C客户信息[id].密码=data[4]
		self:发送(id,table.tostring({序号=data[1],ID=id .. "95278",内容={账号=data[3],id=id,密码=data[4],推荐码=data[5],ip=__C客户信息[id].IP}}))
	elseif tonumber(data[1]) == 2 then
		self:发送(id,table.tostring({序号=data[1],ID=id .. "95278",内容={账号=__C客户信息[id].账号,id=id}}))
	elseif tonumber(data[1]) == 3 then
		self:发送(id,table.tostring({序号=data[1],ID=id .. "95278",内容={账号=__C客户信息[id].账号,id=id,模型=data[2],名称=data[3],染色ID=data[4],ip=__C客户信息[id].IP}}))
	elseif tonumber(data[1]) == 4 then
		data[2] = table.loadstring(data[2])
		__C客户信息[id].数字id = data[2].数字id
		self:发送(id,table.tostring({序号=data[1],ID=id.. "95278",内容={账号=__C客户信息[id].账号,id=__C客户信息[id].数字id,ip=__C客户信息[id].IP}}))
	elseif tonumber(data[1]) == 0 then
		__C客户信息[id].数字id=data[2]
		self:发送(id,table.tostring({序号=data[1],ID=id .. "95278",内容={账号=__C客户信息[id].账号,id=id,编号=data[2],ip=__C客户信息[id].IP}}))
	else
		local 发送数据 = table.loadstring(data[2]) or {}
		发送数据.ip=__C客户信息[id].IP
		发送数据.序号 = tonumber(data[1])
		发送数据.数字id=__C客户信息[id].数字id
		发送数据.ID = id .. "95278"
		发送数据.安卓 = true
	    self:发送(id,table.tostring(发送数据))
	end
end

function __客户端通信:断开处理(信息)
	if 信息.断开方式 == nil and 信息.数字id~=nil then
		self:发送(信息.id,table.tostring({内容=信息.数字id,序号=5}))
	end
	网关参数.当前连接数=网关参数.当前连接数-1
	self:置标题("安卓网关 - 当前在线人数:"..网关参数.当前连接数)
end

function __客户端通信:断开连接(id,断开类型)
	if 断开类型 == nil then
		断开类型 = "普通类型数据非法"
	end
	print("-----以下账号涉嫌非法操作以断开连接----------断开方式："..断开类型)
	table.print(__C客户信息[id])
	print("----------------------------------------------------------分割线")
	__客户端通信:断开连接(id)
end