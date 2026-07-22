
format = string.format
random = math.random
-- 封包加密=require("Script/封包加密")
处理类=require("Script/客户处理类").创建()
f函数=require("ffi函数")
localmp =nil
localmp = require("script/ForYourOwnUse/MessagePack")
require("script/服务端通信")
__S服务 = require("script/ForYourOwnUse/PackServer")('服务','-->外网连接')
__S服务.发送_ = __S服务.发送
全局信息记录={}
function __S服务:发送(id,...)
  self:发送_(id,localmp.pack{...})
end
__S服务:置标题("单机服务端")
__S服务:置工作线程数量(500)
__S服务:置预投递数量(5000)
fgf="*-*"
fgc="@+@"
上次时间=os.time()
local client_hang_timeout = 20

local function clear_log_file(file_name)
  local f = io.open(file_name, "w")
  if f then
    f:write("")
    f:close()
  end
end

clear_log_file("draw_log.txt")
clear_log_file("../draw_log.txt")
clear_log_file("错误日志.txt")
clear_log_file("../错误日志.txt")

local function append_hang_log(text)
  local f = io.open("draw_log.txt", "a+")
  if f then
    f:write(os.date("%Y-%m-%d %H:%M:%S"), " ", text, "\r\n")
    f:close()
  end
end

function 读入文件(fileName)
  local f = assert(io.open(fileName,'r'))
  local content = f:read('*all')
  f:close()
  if content=="" then content="无文本" end
  return content
end

function 取当前目录()
  local ffi = require("ffi")
  local path = ffi.new("char[256]")
  ffi.C.GetCurrentDirectoryA(256,path)
  return ffi.string(path)
end
网关参数={}
代码函数=loadstring(读入文件([[网关文件.txt]]))
代码函数()
重复清理=os.time()
登陆记录={}
__S服务:启动(网关参数.启动ip,网关参数.启动端口)
f函数 = require("ffi函数")
程序目录=取当前目录().."/"
local __N连接数 	= 0
__C客户信息 	= {}
__S服务:置工作线程数量(2000)
__服务端通信:连接处理()
function 取连接数()
  local 数量=0
  for n, v in pairs(__C客户信息) do
    数量=数量+1
  end
  return 数量
end

function __S服务:启动成功()
	return 0
end

function __S服务:连接进入(ID,IP,PORT)
  if f函数.读配置(程序目录 .. "ip封禁.ini", "ip", IP)=="1" or f函数.读配置(程序目录 .. "ip封禁.ini", "ip", IP)==1 then
    __S服务:输出(string.format("封禁ip的客户进入试图进入(%s):%s:%s", ID, IP, PORT))
    处理类:发送数据(ID,7,"您的已被禁止登陆!")
    return 0
  end
	if 网关参数.当前连接数 < 网关参数.最大连接数 then
		__S服务:输出(string.format('客户进入(%s):%s:%s',ID, IP,PORT))
		网关参数.当前连接数=网关参数.当前连接数+1
    __S服务:置标题("西游网关["..网关参数.版本号.."] - 当前在线人数:"..网关参数.当前连接数)
		 __C客户信息[ID] = {
			IP = IP,
			PORT = PORT,
			sj=os.time(),
			id=ID,
      数字id=nil,
			jb=1 --1未登录  2登录成功
		}
		处理类:连接处理(__C客户信息[ID])
	else
		__S服务:断开连接(ID)
    __服务端通信:更新客户信息(ID,"连接退出")
	end
end

function __S服务:连接退出(ID)
	if __C客户信息[ID] then
    print(os.clock()*1000)
	   __S服务:输出(string.format('客户退出(%s):%s:%s', ID,__C客户信息[ID].IP,__C客户信息[ID].PORT))
    处理类:断开处理(__C客户信息[ID])
    -- 网关参数.当前连接数=网关参数.当前连接数-1
    __S服务:置标题("西游网关["..网关参数.版本号.."] - 当前在线人数:"..网关参数.当前连接数)
    __C客户信息[ID]=nil
    __服务端通信:更新客户信息(ID,"连接退出")
	else
		__S服务:输出("连接不存在(连接退出)。")
	end
  collectgarbage("collect")
end

function 错误追溯()
  print(debug.traceback())
end

function __S服务:数据到达(ID,...)
  local arg = localmp.unpack(...)
  if __C客户信息[ID] then
    __C客户信息[ID].sj = os.time()
    __C客户信息[ID].卡死已记录 = nil
    --__S服务:输出(string.format('客户消息(%s):%s:%s,%s', ID,__C客户信息[ID].IP,__C客户信息[ID].PORT,table.concat( arg, "|")))
    处理类:数据处理(ID,arg[1])
  else
    --  __S服务:输出("连接不存在(数据到达)。")
  end
end

function __S服务:错误事件(ID,EO,IE)
	if __C客户信息[ID] then
	    __S服务:输出(string.format('错误事件(%s):%s,%s:%s', ID,__错误[EO] or EO,__C客户信息[ID].IP,__C客户信息[ID].PORT))
	else
		__S服务:输出("连接不存在(错误事件)。")
	end
end

function 循环函数()---=================屏蔽向客户端发送时间
  if 尝试重连服务端 then
    __服务端通信:重新连接()
  end
  local 时间=os.time()
  for id, v in pairs(__C客户信息) do
    if v and v.sj and 时间 - v.sj >= client_hang_timeout and not v.卡死已记录 then
      v.卡死已记录 = true
      append_hang_log(string.format("客户端疑似卡死 id=%s ip=%s 账号=%s 数字id=%s 最后数据距今=%ss",tostring(id),tostring(v.IP or ""),tostring(v.账号 or ""),tostring(v.数字id or ""),tostring(时间-v.sj)))
    end
  end
  if 时间-上次时间>=1 then
    for n, v in pairs(__C客户信息) do
      __S服务:发送(n,jm(table.tostring({序号=99,时间=时间})))
    end
    上次时间=os.time()
  end
end

function 输入函数(t)
  if t=="@gxdm" then
    代码函数=loadstring(读入文件([[代码.txt]]))
    代码函数()
    __S服务:输出("更新代码成功")
  end
end

function 退出函数() end

function 分割文本(str,delimiter)
    local dLen = string.len(delimiter)
    local newDeli = ''
    for i=1,dLen,1 do
        newDeli = newDeli .. "["..string.sub(delimiter,i,i).."]"
    end
    local locaStart,locaEnd = string.find(str,newDeli)
    local arr = {}
    local n = 1
    while locaStart ~= nil
    do
      if locaStart>0 then
          arr[n] = string.sub(str,1,locaStart-1)
          n = n + 1
      end
      str = string.sub(str,locaEnd+1,string.len(str))
      locaStart,locaEnd = string.find(str,newDeli)
    end
    if str ~= nil then
        arr[n] = str
    end
    return arr
end

mab = 'ABCDEFGHIJKLMNOabcdefghijklmnoPQRSTUVWXYZpqrstuvwxyz0123456789+/*=.，'
key={["B"]="6b,",["S"]="9W,",["5"]="BZ,",["D"]="wO,",["c"]="wu,",["E"]="cj,",["b"]="vt,",["3"]="Iv,",["s"]="jO,",["N"]="2l,",["d"]="mP,",["6"]="wd,",["7"]="5R,",["e"]="ET,",["t"]="nB,",["8"]="8v,",["4"]="yP,",["W"]="j3,",["9"]="Wa,",["H"]="Dl,",["G"]="Ve,",["g"]="JA,",["I"]="Au,",["X"]="NR,",["m"]="DG,",["w"]="Cx,",["Y"]="Qi,",["V"]="es,",["F"]="pF,",["z"]="CO,",["K"]="XC,",["f"]="aW,",["J"]="DT,",["x"]="S9,",["y"]="xi,",["v"]="My,",["L"]="PW,",["u"]="Aa,",["k"]="Yx,",["M"]="qL,",["j"]="ab,",["r"]="fN,",["q"]="0W,",["T"]="de,",["l"]="P8,",["0"]="q6,",["n"]="Hu,",["O"]="A2,",["1"]="VP,",["i"]="hY,",["h"]="Uc,",["C"]="cK,",["A"]="f4,",["P"]="is,",["U"]="u2,",["o"]="m9,",["Q"]="vd,",["R"]="gZ,",["2"]="Zu,",["Z"]="Pf,",["a"]="Lq,",["p"]="Sw,"}

function jm(数据)
  local jg=""
  for n=1,#数据 do
    local z=string.sub(数据,n,n)
    if z~="" then
      if key[z]==nil then
        jg=jg..z
      else
        jg=jg..key[z]
      end
    end
  end
  return jg
end
function jm1(数据)
  local jg=数据
  for n=1,#mab do
    local z=string.sub(mab,n,n)
    if z=="," then print(66) end
    if key[z]~=nil then
      jg=string.gsub(jg,key[z],z)
    end
  end
  return jg
end

更新内容 = 读入文件("更新公告.txt")

