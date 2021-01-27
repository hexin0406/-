--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2021-01-26 11:00:11
--======================================================================--
local 系统类_鼠标 = class()

local 当前,记忆当前
local 指针 = {}
local tp

function 系统类_鼠标:初始化(根)
	local 资源 = 根.资源
	指针["普通"] = 资源:载入('common/general.wdf',"网易WDF动画",0x81DD40DC)
	指针["攻击"] = 资源:载入('wzife.wdf',"网易WDF动画",0x1FBC5273)
	指针["道具"] = 资源:载入('wzife.wdf',"网易WDF动画",0xB48A9B3D)
	指针["捕捉"] = 资源:载入('wzife.wdf',"网易WDF动画",0xC5750B15)
	指针["保护"] = 资源:载入('wzife.wdf',"网易WDF动画",0xB352AE45)
	指针["禁止"] = 资源:载入('wzife.wdf',"网易WDF动画",0x1733E33B)
	指针["输入"] = 资源:载入('wzife.wdf',"网易WDF动画",0xC0247799)
	指针["事件"] = 资源:载入('wzife.wd4',"网易WDF动画",0xB3662702)
	指针["组队"] = 资源:载入('wzife.wdf',"网易WDF动画",0x183DC759)
	指针["给予"] = 资源:载入('wzife.wdf',"网易WDF动画",0xCF1D211E)
	指针["交易"] = 资源:载入('wzife.wdf',"网易WDF动画",0xB87E0F0C)
	指针["平时攻击"] = 资源:载入('wzife.wdf',"网易WDF动画",0x1FBC5273)
	当前 = "普通"
	记忆当前 = 当前
	tp = 根
end

function 系统类_鼠标.置鼠标(v)
	if 当前 == v or 当前=="组队" or 当前=="给予" or 当前=="交易"  or 当前=="平时攻击" then
		return false
	end
	if v == "给予" or v == "交易" or v == "组队" or v == "普通" or v == "输入" or v == "事件" or v == "平时攻击"  or (tp.场景 ~= nil and tp.战斗中 and v == "攻击") then
		tp.隐藏UI = false
	else
		tp.隐藏UI = true
	end
	if 记忆当前 ~= 当前 then
		记忆当前 = 当前
	end
	当前 = v
end

function 系统类_鼠标.取当前()
	return 当前
end

function 系统类_鼠标.还原鼠标()
	当前 = "普通"
end

function 系统类_鼠标:更新(dt,x,y)
	if 引擎.鼠标弹起(右键) then
		if 当前=="组队" or 当前=="给予" or 当前=="交易"  or 当前=="平时攻击" then
			当前 = "普通"
		end
	end
	指针[当前]:更新(dt)
end

function 系统类_鼠标:显示(dt,x,y)
	指针[当前]:显示(x,y)
end

return 系统类_鼠标