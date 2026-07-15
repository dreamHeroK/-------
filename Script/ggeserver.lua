
local __hpserver = require("__ggehpserver__")
local ggesvr = class()
function ggesvr:初始化(a,b)
	self._cb = b and a
	self._hp = __hpserver(__gge.cs,__gge.state)
	self._hp:Create(false,self)
	self._sendbuf 	=require("Script/ggebuf")()-- require("ggebuf")()--require("Script/gebuf")()--require("ggebuf")()
	self._recbuf 	= require("Script/ggebuf")()--require("ggebuf")()--require("Script/ggebuf")()--require("ggebuf")()
end
function ggesvr:置接收BUF(v)
	self._recbuf = v
	return self
end
function ggesvr:置发送BUF(v)
	self._sendbuf = v
	return self
end
function ggesvr:置收发BUF(a,b)
	self._sendbuf = b
	self._recbuf = a
	return self
end
function ggesvr:输出(str)
	__gge.print(true,11,str.."\n")
end
function ggesvr:置标题(str)
	local ffi = require("ffi")
	ffi.C.SetConsoleTitleA(str)
	return self
end
function ggesvr:启动(ip,port)
	__gge.print(true,6,string.format('服务端启动ip为："%s:%s"	-->', ip,port))
	self._client 	= {}
	if self._hp:Start(ip,port) == 0 then
		__gge.print(false,12,"失败！\n")
	end
end
function ggesvr:停止()
	self._hp:Stop()
end
function ggesvr:发送(dwConnID,...)
	--print(dwConnID)
	self._sendbuf:添加数据(...)
	self._hp:Send(dwConnID,self._sendbuf:取指针(),self._sendbuf:取长度(),0)
end
function ggesvr:发送_指针(dwConnID,pBuffer,iLength,iOffset)
	self._hp:Send(dwConnID,pBuffer,iLength,iOffset or 0)
end
function ggesvr:发送_文本(dwConnID,pBuffer)
	self._hp:SendStr(dwConnID,pBuffer)
end
function ggesvr:OnPrepareListen(soListen)--启动成功
	--self:置工作线程数量(24)
	self:置预投递数量(600*2)
	self:置缓冲区大小(10240*2)
	self:置Socket缓存池大小(450*2)
	self:置内存块缓存池大小(900*2)
	self:置Socket缓存池回收阀值(1800*2)
	self:置内存块缓存池回收阀值(3600*2)
	__gge.print(false,10,"成功！\n")
	if self.启动成功 then
	    return __gge.safecall(self.启动成功,self)
	elseif self._cb and self._cb.启动成功 then
	    return __gge.safecall(self._cb.启动成功)
	end
	return 0
end
function ggesvr:OnAccept(dwConnID,soClient)--连接进入
	--dwConnID=1
	--print(dwConnID,soClient)
	local ip,port = unpack(self._hp:GetRemoteAddress(dwConnID))
	self._client[dwConnID] = {
		ishead 	= true,
		len 	= self._recbuf:取头长(),
		ip 		= ip,
		port 	= port,
		error 	= false
	}

	if self.连接进入 then
	    return __gge.safecall(self.连接进入,self,dwConnID,ip,port)
	elseif self._cb and self._cb.连接进入 then
	    return __gge.safecall(self._cb.连接进入,dwConnID,ip,port)
	end
	return 0
end
function ggesvr:OnSend(dwConnID,pData,iLength)--发送事件
	return 0
end
function ggesvr:OnReceive(dwConnID,iLength)--数据到达
	if type(dwConnID) ~= "number"  then
     return 0
    elseif type(iLength) ~= "number" then
      return 0
      end
	if self._client[dwConnID]==nil then

      return 0
	   end

	local required 	= self._client[dwConnID].len
	local remain 	= iLength
	if self._echo then--回射
	    self._hp:Fetch(dwConnID,self._recbuf:取指针(),iLength)
	    self._hp:Send(dwConnID,self._recbuf:取指针(),iLength,0)
	    return 0
	end
	while remain >= required do
		remain = remain -required --剩余数据长度
		local FR_OK = self._hp:Fetch(dwConnID,self._recbuf:取指针(),required)
		if FR_OK == 0 then
			if self._client[dwConnID].ishead then--是否是包头
				required = self._recbuf:校验头() --获取包体长度
				if required == 0 then --非法数据
					self._client[dwConnID].error = true
				    self:断开连接(dwConnID)
				    break
				end
			else
				-- if self.数据到达 then
				--     __gge.safecall(self.数据到达,self,dwConnID,unpack(self._recbuf:取数据()))
				-- elseif self._cb and self._cb.数据到达 then
				--     __gge.safecall(self._cb.数据到达,dwConnID,unpack(self._recbuf:取数据()))
				-- end
				if self.数据到达 then
					local tb = self._recbuf:取数据()
					if #tb>=50 then
					else
						__gge.safecall(self.数据到达,self,dwConnID,unpack(tb))
					end
				elseif self._cb and self._cb.数据到达 then
					local tb = self._recbuf:取数据()
					if #tb>=50 then
					else
						__gge.safecall(self._cb.数据到达,self,dwConnID,unpack(tb))
					end
				end
				required = self._recbuf:取头长()--获取包头长度
			end
			self._client[dwConnID].ishead 	= not self._client[dwConnID].ishead
			self._client[dwConnID].len 		= required
		else
			--error('获取失败')
			break
		end
	end

	return 0
end
function ggesvr:OnClose(dwConnID)--c
	if self.c then
	    return __gge.safecall(self.c,self,dwConnID)
	elseif self._cb and self._cb.c then
	    return __gge.safecall(self._cb.c,dwConnID)
	end
	return 0
end
function ggesvr:OnError(dwConnID,enOperation,iErrorCode)--错误事件
	if self.错误事件 then
	    return __gge.safecall(self.错误事件,self,dwConnID,enOperation,iErrorCode)
	elseif self._cb and self._cb.错误事件 then
	    return __gge.safecall(self._cb.错误事件,dwConnID,enOperation,iErrorCode)
	end
	return 0
end
function ggesvr:OnShutdown()
	return 0
end
function ggesvr:延时(i)
	__gge.sleep(i)
end
--	/* 设置 Accept 预投递数量（根据负载调整设置，Accept 预投递数量越大则支持的并发连接请求越多） */
function ggesvr:置预投递数量(v)
	self._hp:SetAcceptSocketCount(v)
end
--	/* 设置通信数据缓冲区大小（根据平均通信数据包大小调整设置，通常设置为 1024 的倍数） */
function ggesvr:置缓冲区大小(v)
	self._hp:SetSocketBufferSize(v)
end
--	/* 设置监听 Socket 的等候队列大小（根据并发连接数量调整设置） */
function ggesvr:置等候队列大小(v)
	self._hp:SetSocketListenQueue(v)
end
--	/* 设置心跳包间隔（毫秒，0 则不发送心跳包） */
function ggesvr:置心跳检查次数(v)
	self._hp:SetKeepAliveTime(v)
end
--	/* 设置心跳确认包检测间隔（毫秒，0 不发送心跳包，如果超过若干次 [默认：WinXP 5 次, Win7 10 次] 检测不到心跳确认包则认为已断线） */
function ggesvr:置心跳检查间隔(v)
	self._hp:SetKeepAliveInterval(v)
end
--	/* 获取 Accept 预投递数量 */
function ggesvr:取预投递数量()
	return self._hp:GetAcceptSocketCount()
end
--	/* 获取通信数据缓冲区大小 */
function ggesvr:取缓冲区大小()
	return self._hp:GetSocketBufferSize()
end
--	/* 获取监听 Socket 的等候队列大小 */
function ggesvr:取等候队列大小()
	return self._hp:GetSocketListenQueue()
end
--	/* 获取心跳检查次数 */
function ggesvr:取心跳检查次数()
	return self._hp:GetKeepAliveTime()
end
--	/* 获取心跳检查间隔 */
function ggesvr:取心跳检查间隔()
	return self._hp:GetKeepAliveInterval()
end
function ggesvr:断开连接(dwConnID,bForce)
	return self._hp:Disconnect(dwConnID,(bForce==nil or bForce) and 1 or 0) ==1
end
function ggesvr:断开超时连接(dwPeriod,bForce)
	return self._hp:DisconnectLongConnections(dwPeriod,(bForce==nil or bForce) and 1 or 0) ==1
end
function ggesvr:断开静默连接(dwPeriod,bForce)
	return self._hp:DisconnectSilenceConnections(dwPeriod,(bForce==nil or bForce) and 1 or 0) ==1
end
function ggesvr:是否已启动()
	return self._hp:HasStarted() ==1
end
--	/* 查看通信组件当前状态 */
-- enum EnServiceState
-- {
-- 	SS_STARTING	= 0,	// 正在启动
-- 	SS_STARTED	= 1,	// 已经启动
-- 	SS_STOPPING	= 2,	// 正在停止
-- 	SS_STOPPED	= 3,	// 已经停止
-- };
-- elseif num>1.1 and num<1.2 then --1.1
-- 		return {序列=1,b="110.42.3.183"}
-- 	elseif num>1.2 and num<1.3 then --1.2
-- 		return {序列=2,b="122.228.85.240"}
-- 	elseif num>1.3 and num<1.4 then  --1.3
-- 		return {序列=3,b="110.42.2.105"}
-- 	elseif num>1.4 and num<1.5 then  --1.4
-- 		return {序列=4,b="110.42.7.6"}
function ggesvr:取状态()
	return self._hp:GetState()
end
--	/* 获取连接数 */
function ggesvr:取连接数()
	return self._hp:GetConnectionCount()
end
--	/* 获取某个连接时长（毫秒） */
function ggesvr:取连接时长(id)
	return self._hp:GetConnectPeriod(id)
end
--	/* 获取某个连接静默时间（毫秒） */
function ggesvr:取静默时长(id)
	return self._hp:GetSilencePeriod(id)
end
--/* 设置 Socket 缓存池大小（通常设置为平均并发连接数量的 1/3 - 1/2） */
function ggesvr:置Socket缓存池大小(v)
	self._hp:SetFreeSocketObjPool(v)
end
--/* 设置内存块缓存池大小（通常设置为 Socket 缓存池大小的 2 - 3 倍） */
function ggesvr:置内存块缓存池大小(v)
	self._hp:SetFreeBufferObjPool(v)
end
--/* 设置 Socket 缓存池回收阀值（通常设置为 Socket 缓存池大小的 3 倍） */
function ggesvr:置Socket缓存池回收阀值(v)
	self._hp:SetFreeSocketObjHold(v)
end
--/* 设置内存块缓存池回收阀值（通常设置为内存块缓存池大小的 3 倍） */
function ggesvr:置内存块缓存池回收阀值(v)
	self._hp:SetFreeBufferObjHold(v)
end
--/* 设置工作线程数量（通常设置为 2 * CPU + 2） */
function ggesvr:置工作线程数量(v)
	self._hp:SetWorkerThreadCount(v)
end
--/* 获取 Socket 缓存池大小 */
function ggesvr:取Socket缓存池大小()
	return self._hp:GetFreeSocketObjPool()
end
--/* 获取内存块缓存池大小 */
function ggesvr:取内存块缓存池大小()
	return self._hp:GetFreeBufferObjPool()
end
--/* 获取 Socket 缓存池回收阀值 */
function ggesvr:取Socket缓存池回收阀值()
	return self._hp:GetFreeSocketObjHold()
end
--/* 获取内存块缓存池回收阀值 */
function ggesvr:取内存块缓存池回收阀值()
	return self._hp:GetFreeBufferObjHold()
end
--/* 获取工作线程数量 */
function ggesvr:取工作线程数量()
	return self._hp:GetWorkerThreadCount()
end
--	/* 获取最近一次失败操作的错误代码 */
function ggesvr:取错误代码()
	return self._hp:GetLastError()
end
--	/* 获取最近一次失败操作的错误描述 */
function ggesvr:取错误描述()
	return self._hp:GetLastErrorDesc()
end
return ggesvr