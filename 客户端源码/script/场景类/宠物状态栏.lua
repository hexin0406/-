--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2020-06-04 15:39:08
--============================,==========================================--
local 场景类_宠物状态栏 = class()

local qmx = 引擎.取模型
local zts,zts1,tp
local insert = table.insert

function 场景类_宠物状态栏:初始化(根)
	self.ID = 14
	self.x = 345
	self.y = 120
	self.xx = 0
	self.yy = 0
	self.注释 = "宠物状态栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
end

function 场景类_宠物状态栏:打开()
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		return
	else
		insert(tp.窗口_,self)
		self:加载数据()
		if tp.宠物.模型 ~= nil then
			local n = qmx(tp.宠物.模型)
			self.资源组[6] = tp.资源:载入(n[3],"网易WDF动画",n[1])
			self.资源组[6]:置方向(4)
		end
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_宠物状态栏:加载数据()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,319,191,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"召唤兽"),
		[4] = 按钮.创建(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"炼妖"),
		[5] = 按钮.创建(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"仓库"),
		[7] = 自适应.创建(2,1,97,97,3,9),
		[8] = 自适应.创建(1,1,281,18,1,3,nil,18),
		[9] = 自适应.创建(3,1,120,19,1,3),
	}
	for n=2,5 do
	    self.资源组[n]:绑定窗口_(14)
	end
	self.资源组[3]:置偏移(-1,0)
end

function 场景类_宠物状态栏:显示(dt,x,y)
	local cw = tp.宠物
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,cw.模型 ~= nil)
	self.资源组[4]:更新(x,y,cw.模型 ~= nil)
	self.资源组[5]:更新(x,y,cw.模型 ~= nil)
	if cw.模型 ~= nil then
		self.资源组[6]:更新(dt)
	end
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
		--tp.窗口.召唤兽属性栏:打开()

		发送数据(5001)
	elseif self.资源组[4]:事件判断() then
		--tp.窗口.宠物炼妖栏:打开()
		发送数据(5007)
	elseif self.资源组[5]:事件判断() then
		--tp.窗口.召唤兽仓库:打开()
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[8]:显示(self.x+6,self.y+3)
	tp.窗口标题背景_:置区域(0,0,75,16)
	tp.窗口标题背景_:显示(self.x+115,self.y+3)
	zts1:置字间距(3)
	zts1:显示(self.x+136,self.y+3,"宠物")
	self.资源组[2]:显示(self.x + 293,self.y + 6)
	self.资源组[3]:显示(self.x + 30,self.y + 155,true)
	self.资源组[4]:显示(self.x + 131,self.y + 155,true)
	self.资源组[5]:显示(self.x + 232,self.y + 155,true)
	zts1:置字间距(3)
	zts1:显示(self.x + 134,self.y + 44,"名称")
	zts1:显示(self.x + 134,self.y + 70,"等级")
	zts1:显示(self.x + 134,self.y + 94,"耐力")
	zts1:显示(self.x + 134,self.y + 120,"经验")
	for i=0,3 do
		self.资源组[9]:显示(self.x+170,self.y+43+i*25)
	end
	zts1:置字间距(0)
	self.资源组[7]:显示(self.x + 30,self.y + 42)
	if cw.模型 ~= nil then
		if self.资源组[6] == nil and self.资源组[7] == nil then
			local n = qmx(cw.模型)
			self.资源组[6] = tp.资源:载入(n.资源,"网易WDF动画",n.静立)
			self.资源组[6]:置方向(4)
		end
		tp.影子:显示(self.x + 78,self.y + 113)
		self.资源组[6]:显示(self.x + 78,self.y + 113)
		zts:置颜色(-16777216)
		zts:显示(self.x + 178,self.y + 47,cw.名称)
		zts:显示(self.x + 178,self.y + 72,cw.等级)
		zts:显示(self.x + 178,self.y + 98,cw.耐力.."/"..cw.最大耐力)
		zts:显示(self.x + 178,self.y + 122,cw.经验.."/"..cw.最大经验)
	end
end

function 场景类_宠物状态栏:检查点(x,y)
	if self.可视 and  self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_宠物状态栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_宠物状态栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_宠物状态栏