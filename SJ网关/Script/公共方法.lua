-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2018-10-22 02:15:28
-- @最后修改来自: baidwwy
-- @Last Modified time: 2022-02-19 15:35:12
local 玩家效验 = {}

-- function 分割文本(OriginString, Separator)
--   if OriginString ~= nil then
--     local FindStartIndex = 1
--     local SplitIndex = 1
--     local SplitArray = {}
--     while true do
--       local FindLastIndex = string.find(OriginString, Separator, FindStartIndex)
--       if not FindLastIndex then
--         SplitArray[SplitIndex] = string.sub(OriginString, FindStartIndex, string.len(OriginString))
--         break
--       end
--       SplitArray[SplitIndex] = string.sub(OriginString, FindStartIndex, FindLastIndex - 1)
--       FindStartIndex = FindLastIndex + string.len(Separator)
--       SplitIndex = SplitIndex + 1
--     end
--     return SplitArray
--   else
--     return nil
--   end
-- end

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