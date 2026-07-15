-- @Author: ASUS
-- @Date:   2020-11-26 19:23:42
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-12-22 13:45:38
战斗准备类 = require("Script/战斗处理类/创建战斗")()
怪物属性 = require("Script/战斗处理类/怪物属性")()


AI战斗 = require("Script/战斗处理类/AI战斗")()
战斗处理类 = require("Script/战斗处理类/战斗处理")
战斗胜利 = require("Script/战斗处理类/战斗计算/战斗胜利")()
战斗奖励 = require("Script/战斗处理类/战斗计算/战斗奖励")()
战斗失败 = require("Script/战斗处理类/战斗计算/战斗失败")()
战斗执行类 = require("Script/战斗处理类/战斗计算/战斗执行类")()
战斗法术计算 = require("Script/战斗处理类/战斗计算/战斗法术计算")()
战斗固伤计算 = require("Script/战斗处理类/战斗计算/战斗固伤计算")()
物理技能计算 = require("Script/战斗处理类/战斗计算/物理技能计算")()
普攻计算 = require("Script/战斗处理类/战斗计算/普攻计算")()
战斗灵宝计算 = require("Script/战斗处理类/战斗计算/战斗灵宝计算")()
-- 神器计算 = require("Script/战斗处理类/战斗计算/神器计算")()
战斗计算 = require("Script/战斗处理类/战斗计算/战斗计算")()
战斗技能 = require("Script/战斗处理类/战斗计算/战斗技能")()
初始技能计算 = require("Script/战斗处理类/战斗计算/初始技能计算")()
状态处理 = require("Script/战斗处理类/战斗计算/状态处理")()
天罡星AI = require("Script/战斗处理类/天罡星AI")()
天罡星属性 = require("Script/战斗处理类/天罡星属性")()
-- 测试专用 = require("Script/战斗处理类/战斗计算/测试专用")()
require("Script/战斗处理类/智能施法")
RequireFile("Script/战斗处理类/怪物调用/结算处理")
