local 天罡星属性 = class()
function 天罡星属性:初始化()
end

function 天罡星属性:属性纠正(this,编号)
	local 目标 = this.参战单位[编号]
	local 战斗类型 = this.战斗类型
	local 名称 = 目标.名称
	local 门派 = 目标.门派
	if 目标.位置 == 1 and 战斗类型 ~= 120038 then
		目标.速度 = 9999
    end
	if this.战斗类型 == 120010 then
		if 目标.位置 == 2 and 名称 == "长生" then
			目标.门派="化生寺"
		end
		this.法阵能量=100
	elseif this.战斗类型 == 120011 then
		if 目标.名称 == "狂攻" and 门派 == "阴曹地府" then
			目标.伤害 = 目标.伤害*1.5
		end
		this.法阵能量=0
	elseif this.战斗类型 == 120012 then--"#Y
		this.法阵能量=100
	elseif this.战斗类型 == 120013 then--"#Y
		this.法阵能量=0
	elseif this.战斗类型 == 120014 then--"#Y
		if 目标.位置 == 1 then
		  	local sj = {120010,120012,120013}
		  	目标.副战斗类型 = sj[取随机数(1,3)]
		  	if 目标.副战斗类型 ==120010 or 目标.副战斗类型 == 120012 then
				this.法阵能量=100
			elseif 目标.副战斗类型==120013 then
				this.法阵能量=0
			end
		end
	elseif this.战斗类型 == 120015 then--"#Y
		this.法阵能量=0
	elseif this.战斗类型 == 120016 then--"#Y
		this.法阵能量=100
	elseif this.战斗类型 == 120017 then--"#Y
		if 目标.位置 == 1 then
		  	目标.最大气血 = 999999999
		  	目标.气血 = 999999999
		end
		this.法阵能量=0
	elseif this.战斗类型 == 120018 then--"#Y
		if 目标.位置 <= 5 then
		  	目标.速度 = 9999
		  	目标.共生=true
		end
		this.法阵能量=0
	elseif this.战斗类型 == 120019 then--"#Y
		this.法阵能量=100
	elseif this.战斗类型 == 120025 then--"#Y
		if 目标.位置 == 6 then
			目标.速度 = 9999
		end
		this.正反位置 = 取随机数(1,2)
		this.法阵能量=0
	elseif this.战斗类型 == 120026 then
		if 目标.位置 <= 5 then
			目标.共生 = 目标.位置
		else
			目标.共生 = 目标.位置-5
		end
		this.法阵能量=0
	elseif this.战斗类型 == 120028 then
		if 目标.位置 == 1 then
		  	目标.最大气血 = 999999999
		  	目标.气血 = 999999999
		end
		this.法阵能量=0
	elseif this.战斗类型 == 120031 then
		if 目标.位置 <= 5 then
		  	目标.共生 = true
		end
		this.法阵能量=0
	elseif this.战斗类型 == 120032 then
		this.法阵能量=0
	elseif this.战斗类型 == 120034 then
		this.法阵能量=0
	elseif this.战斗类型 == 120041 then
		if 目标.位置 == 4 or 目标.位置 == 7 or 目标.位置 == 9  then
		  	目标.共生 = 1
		elseif 目标.位置 == 5 or 目标.位置 == 8 or 目标.位置 == 10  then
		  	目标.共生 = 1
		end
		this.法阵能量=0
	elseif this.战斗类型 == 120044 then
		目标.共生 = true
		this.法阵能量=0
	elseif this.战斗类型 == 120045 then
		if 目标.位置 ~= 1 and 目标.位置 <= 5 then
		  	目标.最大气血 = 999999999
		  	目标.气血 = 999999999
		end
		this.法阵能量=0
	end
end

function 天罡星属性:更新(dt)
end
function 天罡星属性:显示()
end
return 天罡星属性