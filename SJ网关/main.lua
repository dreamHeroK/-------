function 读入文件(fileName)
    local f = assert(io.open(fileName,'r'))
    local content = f:read('*all')
    f:close()
    if content=="" then content="无文本" end
    return content
end

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

临时函数=loadstring(读入文件("配置文件.txt"))
临时函数()
__C客户信息  = {}
require("GGE")--引用头
require("script/公共方法")
require("Script/服务端通信")
require("Script/客户端通信")
__服务端通信:连接处理()
local client_hang_timeout = 20

local function append_hang_log(text)
  local f = io.open("draw_log.txt", "a+")
  if f then
    f:write(os.date("%Y-%m-%d %H:%M:%S"), " ", text, "\r\n")
    f:close()
  end
end

function 循环函数()
    if 尝试重连服务端 then
        __服务端通信:重新连接()
    end
  local now_time = os.time()
  for id, v in pairs(__C客户信息) do
    if v and v.sj and now_time - v.sj >= client_hang_timeout and not v.卡死已记录 then
      v.卡死已记录 = true
      append_hang_log(string.format("客户端疑似卡死 id=%s ip=%s 账号=%s 数字id=%s 最后数据距今=%ss",tostring(id),tostring(v.IP or ""),tostring(v.账号 or ""),tostring(v.数字id or ""),tostring(now_time-v.sj)))
    end
  end
end

function 输入函数(t)
  if t=="@gxdm" then
    代码函数=loadstring(读入文件([[代码.txt]]))
    代码函数()
    __S服务:输出("更新代码成功")
  end
end

function 退出函数()
end