--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2018-11-13 19:47:31
--======================================================================--
local tp = 引擎.场景
local floor = math.floor
local format = string.format
local insert = table.insert
local random = 引擎.取随机整数
local remove = table.remove

local function 宝石()
	local ms = {"光芒石","月亮石","太阳石","舍利子","红玛瑙","黑宝石","神秘石"}
	return ms[random(1,#ms)]
end

function tp.窗口.对话栏:师门执行事件(ID,名称,事件,模型,人物位置)
	if 事件 == "拜师" then
		local mp = tp:取坐标师傅(ID,名称)
		local ky = false
		for i,v in pairs(tp.队伍[1].可选门派) do
			if v == mp then
				ky = true
			end
		end
		if ky then
			tp.队伍[1]:置门派(mp)
			tp.提示:写入(format("#Y/角色拜入门派 #R/%s#Y/",mp))
			tp.窗口.对话栏:文本(名称,名称,"师傅领进门，修行靠个人。该怎么样，还是得看你自己。")
		else
			tp.窗口.对话栏:文本(名称,名称,format("你不适合修习%s的法术，请回吧",mp))
		end
	-- 分割
	elseif 事件 == "学习技能" then
		local mp = tp:取坐标师傅(ID,名称)
		if tp.队伍[1].门派 == mp then
			tp.窗口.技能学习:打开()
			tp.窗口.对话栏:打开()
		else
			tp.窗口.对话栏:文本(名称,名称,"暂时没有可以学习的技能")
		end
	-- 分割
	elseif 事件 == "飞升剧情" then
	    if tp.剧情开关.飞升 ~= false and tp.剧情开关.飞升[1] == 4 and  tp.剧情开关.飞升[2][4] ~= nil and tp.剧情开关.飞升[2][4][1] == ID and tp.剧情开关.飞升[2][4][2] == 名称  then
			if 物品判断(tp.剧情开关.飞升[2][4][3],1,true) then
				tp.剧情开关.飞升[2][1] = tp.剧情开关.飞升[2][1] + 1
				insert(tp.剧情开关.飞升[2][2],"定海针")
				local v1 = 开关取内容("◆去#R/玉皇大帝#L/那获得仙界的试炼资格。","",取数组内容(tp.剧情开关.飞升[2][2],"定海针") and 取数组内容(tp.剧情开关.飞升[2][2],"避火诀") and 取数组内容(tp.剧情开关.飞升[2][2],"炼金鼎") and 取数组内容(tp.剧情开关.飞升[2][2],"修篁斧"))
				tp.窗口.任务栏:修改内容("飞升剧情",format("去向#R/东海龙王#L/要定海针%s；\n#L/◆去向#R/李靖#L/要一本避火诀%s；\n#L/◆去向#R/镇元大仙#L/借下炼金鼎%s；\n#L/◆去向#R/观音姐姐#L/借吧修篁斧%s\n#L/%s",开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"定海针")),开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"避火诀")),开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"炼金鼎")),开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"修篁斧")),v1))
				tp.提示:写入("#Y/你获得了定海针")
				增加物品("定海针")
				tp:增加经验(10000,nil,true)
				tp.窗口.对话栏:文本(名称,名称,format("这是镇海针，你要好好的护送它到玉帝那！"))
			else
				tp.窗口.对话栏:文本(名称,名称,format("你需要拿#R/%s（90-120级皆可）#W/来换定海针",tp.剧情开关.飞升[2][4][3]))
			end
		elseif tp.剧情开关.飞升 ~= false and tp.剧情开关.飞升[1] == 4 and  tp.剧情开关.飞升[2][5] ~= nil and tp.剧情开关.飞升[2][5][1] == ID and tp.剧情开关.飞升[2][5][2] == 名称  then
			if 物品判断(tp.剧情开关.飞升[2][5][3]) and 物品判断(tp.剧情开关.飞升[2][5][4]) then
				tp.剧情开关.飞升[2][1] = tp.剧情开关.飞升[2][1] + 1
				insert(tp.剧情开关.飞升[2][2],"炼金鼎")
				local v1 = 开关取内容("◆去#R/玉皇大帝#L/那获得仙界的试炼资格。","",取数组内容(tp.剧情开关.飞升[2][2],"定海针") and 取数组内容(tp.剧情开关.飞升[2][2],"避火诀") and 取数组内容(tp.剧情开关.飞升[2][2],"炼金鼎") and 取数组内容(tp.剧情开关.飞升[2][2],"修篁斧"))
				tp.窗口.任务栏:修改内容("飞升剧情",format("去向#R/东海龙王#L/要定海针%s；\n#L/◆去向#R/李靖#L/要一本避火诀%s；\n#L/◆去向#R/镇元大仙#L/借下炼金鼎%s；\n#L/◆去向#R/观音姐姐#L/借吧修篁斧%s\n#L/%s",开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"定海针")),开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"避火诀")),开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"炼金鼎")),开关取内容("(完成)","",取数组内容(tp.剧情开关.飞升[2][2],"修篁斧")),v1))
				tp.提示:写入("#Y/你获得了炼金鼎")
				物品失去(tp.剧情开关.飞升[2][5][3])
				物品失去(tp.剧情开关.飞升[2][5][4])
				增加物品("炼金鼎")
				tp:增加经验(20000,nil,true)
				tp.窗口.对话栏:文本(名称,名称,format("恩！好！这是你要的炼金鼎"))
			else
				tp.窗口.对话栏:文本(名称,名称,format("我现在正缺缺两味药材%s和%s，你去取来，我自然把炼金鼎给你。",tp.剧情开关.飞升[2][5][3],tp.剧情开关.飞升[2][5][4]))
			end
		end
	elseif 事件 == "押镖任务" then
		if tp.队伍[1].等级 <= 30 then
			金钱,储备 = 100000,60000
		elseif tp.队伍[1].等级 > 30 and tp.队伍[1].等级 <= 50 then
			金钱,储备 = 160000,100000
		elseif tp.队伍[1].等级 > 50 and tp.队伍[1].等级 <= 90 then
			金钱,储备 = 200000,160000
		elseif tp.队伍[1].等级 > 90 then
			金钱,储备 = 400000,320000
		end
		if random(1,10) == 1 then
			增加物品("鬼谷子",random(2,11))
			tp.提示:写入("#Y/你获得了鬼谷子")
		elseif random(1,20) == 1 then
			local wp = {"红木短剑","搜神记","论语","瑶池蟠桃"}
			wp = wp[random(1,#wp)]
			增加物品(wp)
			tp.提示:写入("#Y/你获得了"..wp)
		end
		tp.金钱 = tp.金钱 + 金钱
		tp.储备 = tp.储备 + 储备
		tp.提示:写入(format("#Y/获得了金钱%d，储备金%d",金钱,储备))
		tp.窗口.任务栏:删除("押镖任务")
		tp.剧情开关.押镖 = false
		tp.窗口.对话栏:文本(模型,名称,"谢谢你了，这些是你的奖励")
	elseif 事件 == "四季轮转" then
		local gl = random(1,2)
		if gl == 1 then
			tp.窗口.对话栏:文本(模型,名称,"难得徒儿们这么孝顺，我这儿有一道题，你若答对了，为师定大大奖赏你",{"我准备好了","我还要准备一下"},"师门答题")
		else
			tp.窗口.对话栏:文本(模型,名称,"徒儿还算孝顺，不过想要好处先过了这一关再说，今天我们来划划拳",{"那弟子可是高手","我还要准备一下"},"师门答题")
		end
	elseif 事件 == "我准备好了" then
		tp.窗口.对话栏:下一页()
		local a = 引擎.题库("元宵")
		tp.窗口.答题器:打开({a},"师门答题",{模型,名称})
	elseif 事件 == "那弟子可是高手" then
		tp.窗口.对话栏:文本(模型,名称,"开始吧",{"石头","剪刀","布"},"师门答题")
	elseif 事件 == "石头" or 事件 == "剪刀" or 事件 == "布" then
		local gl = random(1,3)
		if gl == 1 then
			引擎.四季奖励()
			tp.窗口.对话栏:文本(模型,名称,"看来师傅真是老了，连划拳都划不过你了")
			tp.窗口.任务栏:删除("四季轮转")
			tp.剧情开关.四季[3] = tp.剧情开关.四季[3] + 1
			if tp.剧情开关.四季[3] > 5 then
				tp.剧情开关.四季 = false
			else
				remove(tp.剧情开关.四季[4],1)
				tp.窗口.任务栏:添加("四季轮转",format("为师父%s道一身问候吧",tp.剧情开关.四季[4][1][2]))
				tp.提示:写入(format("#Y/为师父%s道一身问候吧",tp.剧情开关.四季[4][1][2]))
			end
		elseif gl == 2 then
			tp.窗口.对话栏:文本(模型,名称,"徒儿，你输了")
			tp.窗口.任务栏:删除("四季轮转")
			tp.剧情开关.四季[3] = tp.剧情开关.四季[3] + 1
			if tp.剧情开关.四季[3] > 5 then
				tp.剧情开关.四季 = false
			else
				remove(tp.剧情开关.四季[4], 1)
				tp.窗口.任务栏:添加("四季轮转",format("为师父%s道一身问候吧",tp.剧情开关.四季[4][1][2]))
				tp.提示:写入(format("#Y/为师父%s道一身问候吧",tp.剧情开关.四季[4][1][2]))
			end
		elseif gl == 3 then
			tp.窗口.对话栏:文本(模型,名称,"徒儿，我们接着来",{"那弟子可是高手","我还要准备一下"},"师门答题")
		end
	-- 分割
	elseif 事件 == "师门任务" then
		local mp = tp:取坐标师傅(ID,名称)
		if tp.队伍[1].门派 ~= mp then
			tp.窗口.对话栏:文本(模型,名称,"你跟本派没有任何关联，请回吧")
			return false
		end
		local 等级 = tp.队伍[1].等级
		if tp.剧情开关.师门 ~= false then
			local v = false
			if tp.剧情开关.师门[1] == "武器" or tp.剧情开关.师门[1] == "药品" then
				local a = 物品判断(tp.剧情开关.师门[2],1,true)
				if a then
					v = true
				end
			elseif tp.剧情开关.师门[1] == "巡逻" then
				if tp.临时野怪 == nil then
					v = true
				end
			elseif tp.剧情开关.师门[1] == "抓宠" then
				tp:获取宝宝(tp.剧情开关.师门[2])
				for i=1,#tp.队伍[1].宝宝列表 do
					if tp.队伍[1].宝宝列表[i].模型 == tp.剧情开关.师门[2] and tp.队伍[1].宝宝列表[i] ~= tp.队伍[1].参战宝宝 then
						remove(tp.队伍[1].宝宝列表,i)
						v = true
						tp.窗口.召唤兽属性栏:刷新()
						break
					end
				end
			end
			if not v then
				tp.窗口.对话栏:文本(模型,名称,"为师交代你的任务还没有完成，你难道想违抗师命吗？")
				return false
			else
				local 平均等级 = 0
				local 数量 = 0
				for n=1,#tp.队伍 do
					数量 = 数量 + 1
				    平均等级 = 平均等级 + tp.队伍[n].等级
				end
				平均等级 = floor(平均等级 / 数量)
				local 经验 = floor(平均等级*tp.剧情进度.师门*203/5)
				local 金钱 = floor(平均等级*tp.剧情进度.师门*80/3)
				for s=1,#tp.队伍 do
					tp.队伍[s].当前经验 = tp.队伍[s].当前经验 + 经验
					if tp.队伍[s].参战宝宝.名称 ~= nil then
						tp.队伍[s].参战宝宝.当前经验 = tp.队伍[s].参战宝宝.当前经验 + 经验
					end
				end
				local dj = tp:取进制等级(tp.队伍[1].等级)
				if dj >= 160 then
					dj = 160
				end
				local gl = random(1,100)
				if gl <= 5 then
					local bao = 宝石()
					增加物品(bao,random(1,3))
					tp.提示:写入("#Y/你获得了一个"..bao)
				elseif gl > 5 and gl <= 8 then
					if random(1,2) == 1 then
						增加物品("制造指南书",dj,random(1,23))
						tp.提示:写入("#Y/你获得了制造指南书")
					else
						增加物品("百炼精铁",dj)
						tp.提示:写入("#Y/你获得了百炼精铁")
					end
				elseif gl > 8 and gl <= 28 then
					if random(1,10) <= 2 then
						local 三药 = {"金创药","金香玉","小还丹","千年保心丹","风水混元丹","定神香","蛇蝎美人","九转回魂丹","佛光舍利子","五龙丹"}
						local b = 三药[random(1,#三药)]
						增加物品(b)
						tp.提示:写入("#Y/你获得了"..b)
					else
						local 二药 = {"天不老","紫石英","鹿茸","血色茶花","六道轮回","熊胆","凤凰尾","硫磺草","龙之心屑","火凤之睛","丁香水","月星子","仙狐涎","地狱灵芝","麝香","血珊瑚","餐风饮露","白露为霜","天龙水","孔雀红"}
						local b = 二药[random(1,#二药)]
						增加物品(b)
						tp.提示:写入("#Y/你获得了"..b)
					end
				elseif gl > 94 then
					增加物品("突厥密令")
					tp.提示:写入("#Y/你获得了突厥密令")
				end
				tp.金钱 = tp.金钱 + 金钱
				tp.提示:写入(format("#Y/你获得了经验%d，金钱%d",经验,金钱))
				tp.窗口.任务栏:删除("师门任务")
				tp.剧情开关.师门 = false
				return false
			end
		end
		local 随机任务 = {"药品","武器","巡逻","抓宠"}
		local 最终任务 = random(1,#随机任务)
		if tp.剧情进度.师门 >= 10 then
			tp.剧情进度.师门 = 0
		end
		tp.剧情进度.师门 = tp.剧情进度.师门 + 1
		local 需求;
		最终任务 = "抓宠"
		if 最终任务 == "药品" then
			local 药品;
			local 强度 = 1
			local 表 = {"麝香","金创药","熊胆","丁香水"}
			药品 = 表[random(1,#表)]
			tp.窗口.任务栏:添加("师门任务","府上缺少药品#R/"..药品.."#L/，你去帮师傅买一个来吧。记得，要快去快回。\n#L/◆当前第"..tp.剧情进度.师门.."环")
			tp.窗口.对话栏:文本(模型,名称,"府上缺少药品#R/"..药品.."#W/，你去帮为师买一个来吧。记得，要快去快回。")
			需求 = {"药品",药品}
		elseif 最终任务 == "武器" then
			local v = tp:取进制等级(tp.队伍[1].等级)-20
			if v <= 0 then
				v = 0
			elseif v >= 40 then
				v = 40
			end
			local 强度 = 1.0 + v/100
			local b = tp:取等级物品(v)
			local 武器 = b[random(1,#b)]
			tp.窗口.任务栏:添加("师门任务","府上缺少武器#R/"..武器.."#L/，你去帮师傅买一个来吧。\n#L/◆当前第"..tp.剧情进度.师门.."环")
			tp.窗口.对话栏:文本(模型,名称,"府上缺少武器#R/"..武器.."#W/，你去帮为师买一个来吧。记得，要快去快回。")
			需求 = {"武器",武器}
		elseif 最终任务 == "巡逻" then
			tp.临时野怪 = {tp:取师门地图(tp.队伍[1].门派),"师门",0}
			tp.窗口.任务栏:添加("师门任务","去门派周围巡逻一下，遇到妖怪一定要赶走\n#L/◆当前第"..tp.剧情进度.师门.."环")
			tp.窗口.对话栏:文本(模型,名称,"替为师去门派周围巡逻一下，遇到妖怪就赶走吧。")
			需求 = {"巡逻"}
		elseif 最终任务 == "抓宠" then
			local cw = {"羊头怪","狐狸精","骷髅怪","大蝙蝠","赌徒","花妖","狐狸精"}
			需求 = {"抓宠",cw[random(1,#cw)]}
			tp.窗口.任务栏:添加("师门任务","替师傅抓回一只#R/"..需求[2].."\n#L/◆当前第"..tp.剧情进度.师门.."环")
			tp.窗口.对话栏:文本(模型,名称,"最近大雁塔太平静，都找不到惹事妖怪刷贡献了，为师很不爽，徒儿随便找个理由去帮我抓1只"..需求[2].."回来")
		end
		tp.剧情开关.师门 = 需求
	end
end