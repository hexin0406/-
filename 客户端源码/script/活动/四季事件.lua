--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2018-11-13 19:47:31
--======================================================================--
local floor = math.floor
local ceil = math.ceil
local random = 引擎.取随机整数
function 引擎.四季事件(名称,编号,模型)
	if 引擎.场景.剧情开关.四季 == false then
		return false
	end
	if 引擎.场景.剧情开关.四季[1] == "知了王" then
		if 引擎.场景.剧情开关.四季[2] == 0 then
			引擎.场景.窗口.对话栏:文本("知了王",名称,"无知的人类啊，居然妄想挑战我！难道不怕死么？",{"唬谁呢，赶紧开打，我虐死你","夏日炎炎正好眠，求放过"},{"四季轮转","知了王",名称})
		elseif 引擎.场景.剧情开关.四季[2] == 1 then
			引擎.场景.窗口.对话栏:文本("知了王",名称,"我要替我的小的们报仇！！！",{"唬谁呢，赶紧开打，我虐死你","夏日炎炎正好眠，求放过"},{"四季轮转","知了王",名称})
		end
	elseif 引擎.场景.剧情开关.四季[1] == "天狗食月" then
		引擎.四季战斗(名称,编号)
	elseif 引擎.场景.剧情开关.四季[1] == "堆雪人" then
		if 模型 == "炎魔神" then
			引擎.四季战斗(名称,编号)
		else
			引擎.场景.窗口.对话栏:文本(nil,nil,"我是梦幻西游世界里可爱的小雪人，你还记得我吗？我可想念你了。",{"我要上交材料","我要领取奖励","我要查看进度"},{"四季轮转","堆雪人",名称})
		end
	end
end

local function 四季奖励()
	if 引擎.场景.剧情开关.四季 == false then
		return false
	end
	local 平均等级 = 0
	local 数量 = 0
	for n=1,#引擎.场景.队伍 do
		数量 = 数量 + 1
	    平均等级 = 平均等级 + 引擎.场景.队伍[n].等级
	end
	平均等级 = floor(平均等级 / 数量)
	local jy = floor(平均等级*551+平均等级*平均等级)
	local jq = floor(平均等级*200+(平均等级+10)*(平均等级-10))
	for i=1,#引擎.场景.队伍 do
		引擎.场景.队伍[i].当前经验 = 引擎.场景.队伍[i].当前经验 + jy
		if 引擎.场景.队伍[i].参战宝宝.名称 ~= nil then
			引擎.场景.队伍[i].参战宝宝.当前经验 = 引擎.场景.队伍[i].参战宝宝.当前经验 + jy
		end
	end
	引擎.场景.金钱 = 引擎.场景.金钱 + jq
	引擎.场景.储备 = 引擎.场景.储备 + jq * 2
	引擎.场景.提示:写入(string.format("#Y/你获得了%d经验，%d金钱，%d储备金",jy,jq,jq*2))
	if 引擎.场景.剧情开关.四季[1] == "知了王" then
		if 引擎.场景.剧情开关.四季[2] == 0 then
			if random(1,10) <= 3 then
				local dz = 引擎.场景:取进制等级(引擎.场景.队伍[1].等级)
				if dz > 160 then
					dz = 160
				end
				dz = floor(dz / 10) + 1
				local zb = random(24,26)
				local dj = require("script/显示类/物品")()
				dj:置对象(引擎.场景.打造物品[zb][dz])
				增加物品(dj)
				引擎.场景.提示:写入(string.format("#Y/你获得了#R/%s",引擎.场景.打造物品[zb][dz]))
			end
		elseif 引擎.场景.剧情开关.四季[2] == 1 then
			if random(1,10) <= 5 then
				local dz = 引擎.场景:取进制等级(引擎.场景.队伍[1].等级)
				if dz > 160 then
					dz = 160
				end
				dz = floor(dz / 10) + 1
				local zb = random(24,26)
				local dj = require("script/显示类/物品")()
				dj:置对象(引擎.场景.打造物品[zb][dz])
				if zb == 24 then
					dj.命中 = floor(dj.命中 + dj.命中*引擎.取随机小数(0.05,0.1))
					dj.伤害 = floor(dj.伤害 + dj.伤害*引擎.取随机小数(0.05,0.1))
				elseif zb == 25 then
					dj.灵力 = floor(dj.灵力 + dj.灵力*引擎.取随机小数(0.05,0.1))
				elseif zb == 26 then
					dj.防御 = floor(dj.防御 + dj.防御*引擎.取随机小数(0.05,0.1))
				end
				local c = {}
				local djs = 0
				if random(1,100) <= 30 then
					local sx = {random(7,11)}
					djs = 1
					c[sx] = random(dz*0.15,dz*0.4)
				end
				if djs == 0 and random(1,100) <= 30 then
					local sxs = {7,8,9,10,11}
					local sx1 = random(sxs[1],sxs[#sxs])
					table.remove(sxs,sx1)
					local sx2 = random(sxs[1],sxs[#sxs])
					c[sx1] = random(dz*(-0.15),dz*0.4+3)
					c[sx2] = random(dz*(-0.15),dz*0.4+3)
				end
				if c[7] ~= nil then
					dj.敏捷 = c[7]
				end
				if c[8] ~= nil then
					dj.体质 = c[8]
				end
				if c[9] ~= nil then
					dj.力量 = c[9]
				end
				if c[10] ~= nil then
					dj.耐力 = c[10]
				end
				if c[11] ~= nil then
					dj.魔力 = c[11]
				end
				增加物品(dj)
				引擎.场景.提示:写入(string.format("#Y/你获得了#R/%s",dj.名称))
			end
		end
	elseif 引擎.场景.剧情开关.四季[1] == "天狗食月" then
		if random(1,100) <= 50 then
			增加物品("月饼")
		end
	elseif 引擎.场景.剧情开关.四季[1] == "堆雪人" then
		local gl = random(1,100)
		if 引擎.场景.剧情开关.四季[4][7] == 0 then
			if gl <= 10 then
				增加物品("点化石")
				引擎.场景.提示:写入("#Y/你获得了#R/点化石#W/")
			end
			引擎.场景.剧情开关.四季[4][7] = 1
		elseif 引擎.场景.剧情开关.四季[4][7] == 1 then
			if gl <= 25 then
				增加物品("点化石")
				引擎.场景.提示:写入("#Y/你获得了#R/点化石#W/")
			end
			引擎.场景.剧情开关.四季[4][7] = 2
		elseif 引擎.场景.剧情开关.四季[4][7] == 2 then
			if gl <= 35 then
				增加物品("点化石")
				引擎.场景.提示:写入("#Y/你获得了#R/点化石#W/")
			end
			引擎.场景.剧情开关.四季[4][7] = 3
		elseif 引擎.场景.剧情开关.四季[4][7] == 3 then
			if gl <= 50 then
				增加物品("点化石")
				引擎.场景.提示:写入("#Y/你获得了#R/点化石#W/")
			end
			引擎.场景.假人库:清空四季()
			引擎.场景.剧情开关.四季 = false
			引擎.场景.窗口.任务栏:删除("四季轮转")
		end
	elseif 引擎.场景.剧情开关.四季[1] == "元宵拜年" then
		if random(1,10) <= 3 then
			增加物品("元宵")
			引擎.场景.提示:写入("#Y/你获得了#R/元宵#W/")
		end
	end
end

引擎.四季奖励 = 四季奖励

function 引擎.四季选项(事件,事件1,名称)
	if 引擎.场景.剧情开关.四季 == false then
		return false
	end
	if 事件1 == "知了王" then
		if 引擎.场景.剧情开关.四季[2] == 0 then
			引擎.四季战斗(名称)
		elseif 引擎.场景.剧情开关.四季[2] == 1 then
			local gls = random(1,3)
			if gls == 1 then
				引擎.场景.窗口.对话栏:文本("知了王",名称,"那个，其实没人做我的数据，所以不用打啦！我直接给你奖励吧")
				引擎.场景.窗口.对话栏:文本(引擎.场景.队伍[1].模型,引擎.场景.队伍[1].名称,"我有一句MMP不知当讲不当讲")
				引擎.场景.窗口.对话栏:文本("知了王",名称,"惊不惊喜，意不意外！")
				引擎.场景.窗口.对话栏:文本(引擎.场景.队伍[1].模型,引擎.场景.队伍[1].名称,"我裤子都脱了你给我玩这个")
				for i,v in pairs(引擎.场景.场景.假人) do
					if v.名称 == 名称 then
						table.remove(引擎.场景.场景.假人,i)
					end
				end
				for i,v in pairs(引擎.场景.场景.场景人物) do
					if v.名称 == 名称 then
						table.remove(引擎.场景.场景.场景人物,i)
					end
				end
				if 引擎.场景.全局Npc[引擎.场景.当前地图] ~= nil then
					for i,v in pairs(引擎.场景.全局Npc[引擎.场景.当前地图]) do
						if v.名称 == 名称 then
							table.remove(引擎.场景.全局Npc[引擎.场景.当前地图],i)
						end
					end
				end
				引擎.四季奖励()
				引擎.场景.窗口.任务栏:删除("四季轮转")
				引擎.场景.剧情开关.四季 = false
			elseif gls == 2 then
				引擎.四季战斗(名称)
				引擎.场景.窗口.对话栏:下一页()
			elseif gls == 3 then
				for n=1,#引擎.场景.队伍 do
					引擎.场景.队伍[n].气血 = 1
					引擎.场景.队伍[n].魔法 = 1
					if 引擎.场景.队伍[n].参战宝宝 ~= nil then
						引擎.场景.队伍[n].参战宝宝.气血 = 1
						引擎.场景.队伍[n].参战宝宝.魔法 = 1
					end
				end
				引擎.场景.提示:写入("#Y/你被知了王诅咒了，全体队员参战召唤兽气血魔法降低为1点")
			end
			引擎.场景.窗口.对话栏:下一页()
		end
	elseif 事件1 == "堆雪人" then
		if 事件 == "我要上交材料" then
			if 引擎.场景.剧情开关.四季[2] ~= 4 then
				引擎.场景.窗口.对话栏:文本(nil,nil,"请选择你要上交的材料（大雪块和小雪块会全部上交，其他材料只上交一次）",{"小雪块","大雪块","雪人的鼻子","雪人的帽子","雪人的眼睛"},{"四季轮转","堆雪人",引擎.场景.窗口.对话栏.名称})
				引擎.场景.窗口.对话栏:下一页()
			else
				引擎.场景.窗口.对话栏:文本(nil,nil,"我已经成长完毕啦，快找我领取奖励吧，领取完成我就自己消失咯")
				引擎.场景.窗口.对话栏:下一页()
			end
		elseif 事件 == "我要查看进度" then
			引擎.场景.窗口.对话栏:文本(nil,nil,string.format("总进度为#R/%d#W/点\n当前进度为#R/%d#W/点\n距离下次成长还差#R/%d#W/点\n剩余领取奖励次数为#R/%d#W/次",引擎.场景.剧情开关.四季[4][2]+引擎.场景.剧情开关.四季[4][1],引擎.场景.剧情开关.四季[4][1],20-引擎.场景.剧情开关.四季[4][1],引擎.场景.剧情开关.四季[4][3]))
			引擎.场景.窗口.对话栏:下一页()
			-- 上交奖励
		elseif 事件 == "小雪块" then
			if 引擎.场景.剧情开关.四季[2] < 3 then
				if 物品判断("小雪块",1) then
					local sl = 物品失去("小雪块")
					引擎.场景.窗口.对话栏:文本(nil,nil,string.format("你成功上交了#R/%d#W/个小雪块，为雪人成长增加了#R/%d#/点进度",sl,sl*2))
					引擎.场景.剧情开关.四季[4][1] = 引擎.场景.剧情开关.四季[4][1] + sl * 2
					引擎.场景.窗口.对话栏:下一页()
				else
					引擎.场景.窗口.对话栏:文本(nil,nil,"你还没有小雪块，打败周边的融雪怪有概率掉落")
					引擎.场景.窗口.对话栏:下一页()
				end
			else
				引擎.场景.窗口.对话栏:文本(nil,nil,"我已经不需要这个小雪块了，请为我收集我的鼻子、眼睛、和帽子吧")
				引擎.场景.窗口.对话栏:下一页()
			end
		elseif 事件 == "大雪块" then
			if 引擎.场景.剧情开关.四季[2] < 3 then
				if 物品判断("大雪块",1) then
					local sl = 物品失去("大雪块")
					引擎.场景.窗口.对话栏:文本(nil,nil,string.format("你成功上交了#R/%d#W/个大雪块，为雪人成长增加了#R/%d#/点进度",sl,sl*4))
					引擎.场景.剧情开关.四季[4][1] = 引擎.场景.剧情开关.四季[4][1] + sl * 4
					------------------------------------------------------------------------------------------------
					引擎.场景.剧情开关.四季[4][2] = 引擎.场景.剧情开关.四季[4][2] + 引擎.场景.剧情开关.四季[4][1]
					引擎.场景.窗口.对话栏:下一页()
				else
					引擎.场景.窗口.对话栏:文本(nil,nil,"你还没有大雪块，打败周边的融雪怪有概率掉落")
					引擎.场景.窗口.对话栏:下一页()
				end
			else
				引擎.场景.窗口.对话栏:文本(nil,nil,"我已经不需要这个大雪块，请为我收集我的鼻子、眼睛、和帽子吧")
				引擎.场景.窗口.对话栏:下一页()
			end
		elseif 事件 == "雪人的鼻子" then
			if 引擎.场景.剧情开关.四季[2] == 3 then
				if not 引擎.场景.剧情开关.四季[4][4] then
					if 物品判断("雪人的鼻子",1) then
						local sl = 物品失去("雪人的鼻子",1)
						引擎.场景.剧情开关.四季[4][4] = true
						引擎.场景.窗口.对话栏:文本(nil,nil,"你上交了雪人的鼻子")
						引擎.场景.窗口.对话栏:下一页()
					else
						引擎.场景.窗口.对话栏:文本(nil,nil,"你还没有雪人的鼻子，打败周边的融雪怪有概率掉落")
						引擎.场景.窗口.对话栏:下一页()
					end
				else
					引擎.场景.窗口.对话栏:文本(nil,nil,"你已经上交了雪人的鼻子")
					引擎.场景.窗口.对话栏:下一页()
				end
			else
				引擎.场景.窗口.对话栏:文本(nil,nil,"我目前暂时还不需要这个东西哦，你先收集雪块让我成长起来吧")
				引擎.场景.窗口.对话栏:下一页()
			end
		elseif 事件 == "雪人的帽子" then
			if 引擎.场景.剧情开关.四季[2] == 3 then
				if not 引擎.场景.剧情开关.四季[4][5] then
					if 物品判断("雪人的帽子",1) then
						local sl = 物品失去("雪人的帽子",1)
						引擎.场景.剧情开关.四季[4][5] = true
						引擎.场景.窗口.对话栏:文本(nil,nil,"你上交了雪人的帽子")
						引擎.场景.窗口.对话栏:下一页()
					else
						引擎.场景.窗口.对话栏:文本(nil,nil,"你还没有雪人的帽子，打败周边的融雪怪有概率掉落")
						引擎.场景.窗口.对话栏:下一页()
					end
				else
					引擎.场景.窗口.对话栏:文本(nil,nil,"你已经上交了雪人的帽子")
					引擎.场景.窗口.对话栏:下一页()
				end
			else
				引擎.场景.窗口.对话栏:文本(nil,nil,"我目前暂时还不需要这个东西哦，你先收集雪块让我成长起来吧")
				引擎.场景.窗口.对话栏:下一页()
			end
		elseif 事件 == "雪人的眼睛" then
			if 引擎.场景.剧情开关.四季[2] == 3 then
				if not 引擎.场景.剧情开关.四季[4][6] then
					if 物品判断("雪人的眼睛",1) then
						local sl = 物品失去("雪人的眼睛",1)
						引擎.场景.剧情开关.四季[4][6] = true
						引擎.场景.窗口.对话栏:文本(nil,nil,"你上交了雪人的眼睛")
						引擎.场景.窗口.对话栏:下一页()
					else
						引擎.场景.窗口.对话栏:文本(nil,nil,"你还没有雪人的眼睛，打败周边的融雪怪有概率掉落")
						引擎.场景.窗口.对话栏:下一页()
					end
				else
					引擎.场景.窗口.对话栏:文本(nil,nil,"你已经上交了雪人的眼睛")
					引擎.场景.窗口.对话栏:下一页()
				end
			else
				引擎.场景.窗口.对话栏:文本(nil,nil,"我目前暂时还不需要这个东西哦，你先收集雪块让我成长起来吧")
				引擎.场景.窗口.对话栏:下一页()
			end
		elseif 事件 == "我要领取奖励" then
			if 引擎.场景.剧情开关.四季[4][3] > 0 then
				引擎.场景.剧情开关.四季[4][3] = 引擎.场景.剧情开关.四季[4][3] - 1
				引擎.场景.窗口.对话栏:文本(nil,nil,string.format("你还剩下#R/%d#W/次领取奖励的机会",引擎.场景.剧情开关.四季[4][3]))
				引擎.场景.窗口.对话栏:下一页()
				四季奖励()
				return false
			else
				引擎.场景.窗口.对话栏:文本(nil,nil,"你没有可以领取奖励的次数，请帮助我成长可以获得领取奖励的次数哦")
				引擎.场景.窗口.对话栏:下一页()
			end
		end
	end
	if 事件1 == "堆雪人" then
		引擎.场景.剧情开关.四季[4][2] = 引擎.场景.剧情开关.四季[4][2] + 引擎.场景.剧情开关.四季[4][1]
		if 引擎.场景.剧情开关.四季[4][1] >= 20 then
			local cs = 引擎.场景.剧情开关.四季[4][1] / 10
			local bj = 取整数(cs)
			引擎.场景.剧情开关.四季[4][1] = 0
			引擎.场景.剧情开关.四季[4][3] = 引擎.场景.剧情开关.四季[4][3] + bj
			if 引擎.场景.剧情开关.四季[4][3] >= 3 then
				引擎.场景.剧情开关.四季[4][3] = 3
			end
			引擎.场景.剧情开关.四季[2] = 引擎.场景.剧情开关.四季[2] + bj
			if 引擎.场景.剧情开关.四季[2] >= 3 then
				引擎.场景.剧情开关.四季[2] = 3
			end
			引擎.场景.假人库:清空四季()
			引擎.场景.假人库:四季活动生成(true)
			引擎.场景.提示:写入("#Y/恭喜你，你的雪人成长啦，你获得了一次领取奖励的机会")
		end
		if 引擎.场景.剧情开关.四季[2] == 3 then
			if 引擎.场景.剧情开关.四季[4][4] and 引擎.场景.剧情开关.四季[4][5] and 引擎.场景.剧情开关.四季[4][6] then
				引擎.场景.窗口.对话栏:文本(nil,nil,"雪人已经成长完毕，快去找他领取奖励吧")
				引擎.场景.窗口.对话栏:下一页()
				引擎.场景.剧情开关.四季[2] = 4
				引擎.场景.剧情开关.四季[4][3] = 引擎.场景.剧情开关.四季[4][3] + 1
				引擎.场景.假人库:清空四季()
				引擎.场景.假人库:四季活动生成(false)
			end
		end
	end
end

function 引擎.四季战斗(名称,编号)
	if 引擎.场景.剧情开关.四季 == false then
		return false
	end
	local 攻击资质;
	local 防御资质;
	local 体力资质;
	local 法力资质;
	local 速度资质;
	local 躲闪资质;
	local 属性表 = {}
	local 平均等级 = 0
	local 数量 = 0
	for n=1,#引擎.场景.队伍 do
		数量 = 数量 + 1
	    平均等级 = 平均等级 + 引擎.场景.队伍[n].等级
	end
	local 最终 = {}
	平均等级 = floor(平均等级 / 数量)
	local 等级 = 平均等级+20
	if 引擎.场景.剧情开关.四季[1] == "知了王" then
		if 引擎.场景.剧情开关.四季[2] == 0 then
			体力资质 = 4000
			防御资质 = 1500
			攻击资质 = 1500
			速度资质 = 1500
			法力资质 = 3500
			属性表[1] = ceil((平均等级*体力资质/100+(平均等级+等级)*2*6)*3)
			属性表[2] = ceil(平均等级*防御资质*(2+1.4)/1143+(平均等级+等级)*2)
			属性表[3] = ceil(平均等级*攻击资质*(2+1.4)/750+(平均等级+等级)*2*1.2)
			属性表[4] = ceil(平均等级+等级)
			属性表[5] = ceil(速度资质*等级/800)
			属性表[6] = ceil(平均等级*(法力资质+1666)/3333+(平均等级+等级*1.6))
			最终[1] = {名称,"知了王",等级-20,2,0,0,0,0,0,0,-1,nil,nil,引擎.场景:取门派主技能(random(1,15)),true,nil,10000,属性表}
			属性表 = {}
			体力资质 = 3500
			防御资质 = 1000
			攻击资质 = 1000
			速度资质 = 1000
			法力资质 = 2500
			属性表[1] = ceil(平均等级*体力资质/100+(平均等级+等级)*2*10)
			属性表[2] = ceil(平均等级*防御资质*(2+1.4)/1143+等级*2)
			属性表[3] = ceil(平均等级*攻击资质*(2+1.4)/750+(平均等级+等级)*2*1.2)
			属性表[4] = ceil(平均等级+等级)
			属性表[5] = ceil(速度资质*等级/800)
			属性表[6] = ceil(平均等级*(法力资质+1666)/3333+(平均等级+等级*1.6))
			for n=2,10 do
				最终[n] = {"小虫子","海毛虫",等级-20,2,0,0,0,0,0,0,-1,nil,nil,{"强力","连击"},true,nil,10000,属性表}
			end
			引擎.场景.场景.战斗:写入({{"知了王",名称,"看招"}})
			引擎.场景.场景.战斗:进入战斗(最终,{[1]="四季轮转",[2]=名称},nil,true)
		elseif 引擎.场景.剧情开关.四季[2] == 1 then
			属性表[1] = 999999999
			属性表[2] = 99999
			属性表[3] = 9999999
			属性表[4] = 9999999
			属性表[5] = 9999999
			属性表[6] = 99999
			引擎.场景.场景.战斗:写入({{"知了王","名称","既然你不怕死，那我就成全你吧"}})
			引擎.场景.场景.战斗:进入战斗({{"知了王","知了王",等级,2,0,0,0,0,0,0,-1,nil,nil,{"BOSS绝杀"},true,nil,10000,属性表}},{[1]="四季轮转",[2]=名称},nil,true)
		end
	elseif 引擎.场景.剧情开关.四季[1] == "天狗食月" then
		if 引擎.场景.剧情开关.四季[2] == 0 then
			local a = 引擎.取敌人信息(-560)
			a[1] = 名称
			a[3] = 等级
			a[5] = 6000
			a[9] = 3000
			a[12] = 68
			a[13] = {1}
			引擎.场景.场景.战斗:进入战斗({a},{[1]="四季轮转",[2]=编号},nil,true)
		elseif 引擎.场景.剧情开关.四季[2] == 1 then
			属性表[1] = 数量*2000
			if 属性表[1] >= 10000 then
				属性表[1] = 10000
			end
			属性表[2] = 999999
			属性表[3] = ceil(平均等级*250*(2+1.4)/750+(平均等级*2+等级))
			属性表[4] = ceil(平均等级*2.5+等级)
			属性表[5] = ceil(1500*等级/1000)
			属性表[6] = 999999
			local 主怪 = {名称,"哮天犬",等级,2,0,0,0,0,0,0,-1,nil,nil,{"高级连击","高级强力"},true,nil,10000,属性表}
			引擎.场景.场景.战斗:进入战斗({主怪},{[1]="四季轮转",[2]=编号},nil,true)
			引擎.场景.场景.战斗:写入({{"哮天犬","噬月天狗","嗷呜~~~#R/（只有打狗棒才会对噬月天狗造成伤害，物理或者法术攻击伤害对其极其微弱）"}})
			引擎.场景.场景.战斗.战斗方式 = 1
		end
	elseif 引擎.场景.剧情开关.四季[1] == "堆雪人" then
		体力资质 = 4000
		防御资质 = 1500
		攻击资质 = 1500
		速度资质 = 1500
		法力资质 = 3500
		属性表[1] = ceil((平均等级*体力资质/100+(平均等级+等级)*2*6)*3)
		属性表[2] = ceil(平均等级*防御资质*(2+1.4)/1143+(平均等级+等级)*2)
		属性表[3] = ceil(平均等级*攻击资质*(2+1.4)/750+(平均等级*2+等级)*2)
		属性表[4] = ceil(平均等级+等级)
		属性表[5] = ceil(速度资质*等级/800)
		属性表[6] = ceil(平均等级*(法力资质+1666)/3333+(平均等级*4+等级*1.6))
		最终[1] =  {名称,"炎魔神",等级,2,0,0,0,0,0,0,-1,105,{1,0},{"地狱烈火","高级法术连击","高级魔之心"},true,nil,10000,属性表}
		属性表 = {}
		体力资质 = 3000
		防御资质 = 1000
		攻击资质 = 1000
		速度资质 = 1500
		法力资质 = 2500
		属性表[1] = ceil(平均等级*体力资质/100+(平均等级+等级)*2*12)
		属性表[2] = ceil(平均等级*防御资质*(2+1.4)/1143+等级*2)
		属性表[3] = ceil(平均等级*攻击资质*(2+1.4)/750+(平均等级*2+等级)*2)
		属性表[4] = ceil(平均等级+等级)
		属性表[5] = ceil(速度资质*等级/800)
		属性表[6] = ceil((平均等级*(法力资质+1666)/3333+平均等级*2+等级*1.6))
		for i=2,5 do
			最终[i] = {"不知火舞","炎魔神",等级,2,0,0,0,0,0,0,-1,nil,nil,{"地狱烈火","高级反震","高级魔之心"},nil,nil,10000,属性表}
		end
		引擎.场景.场景.战斗:进入战斗(最终,{[1]="四季轮转",[2]=编号},nil,true)
	end
end
