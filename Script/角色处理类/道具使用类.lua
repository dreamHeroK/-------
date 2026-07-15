
local 道具使用类 = class()


function 道具使用类:初始化()

end

function 道具使用类:窗口道具使用(id,Item,道具id,道具格子)
     if 道具id==0 or 道具格子==0 then
           常规提示(id,"#Y/请选中一个道具")
        return
     elseif  玩家数据[id].道具.数据[道具id]==nil  or 玩家数据[id].角色.道具[道具格子]==nil then
         常规提示(id,"#y/这件物品貌似不存在")
         return
     end
     发送数据(玩家数据[id].连接id,138.2,{格子=道具格子,道具=玩家数据[id].道具:索要道具2(id)})
 end
return 道具使用类