--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2020-09-16 22:22:04
--======================================================================--
local bw = require("gge包围盒")(0,0,100,22)
local bw1= require("gge包围盒")(0,0,100,17)
local box = 引擎.画矩形
local floor = math.floor
local tp
local format = string.format
local mousea = 引擎.鼠标弹起
local qtxs = 引擎.取头像
local qzdmx = 引擎.取战斗模型
local xys = 生成XY
local insert = table.insert
local type = type
local min = math.min
local qjq = 引擎.取金钱颜色
local zqj = 引擎.坐骑库
local 场景类_道具行囊 = class()


function 场景类_道具行囊:初始化(根)
	self.ID = 9
	self.x = 0
	self.y = 85
	self.xx = 0
	self.yy = 0
	self.注释 = "道具行囊"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口 = "主人公"
	self.召唤兽 = 0
	tp = 根
	self.装备坐标 = {x={195,249,195,249,195,249},y={24,24,79,79,133,133},xx={10,63,115},yy={144,144,144}}
	self.人物装备窗口=1
	self.选中召唤兽 = 0
	self.加入 = 0
	self.结束 = 20
	self.窗口时间 = 0
	self.提示文字 = "点击鼠标左键抓取物品，鼠标右键使用物品"
	self.当前银行 = "现金"
	self.记录_ = 0
	tp._物品格子(0,0,i,"兼容",底图):置根(tp)
	zts = tp.字体表.普通字体
end

function 场景类_道具行囊:打开()
	if self.可视 then
		self.可视 = false
		self.选中召唤兽 = nil
		self.加入 = nil
		self.当前银行 = nil
		self.窗口 = nil
		-- for s=1,3 do
		-- 	self.召唤兽装备[s]:置物品(nil)
		-- end
		-- for i=1,6 do
		-- 	self.人物装备[i]:置物品(nil)
		-- end
		self.人物装备2 = nil
		self.人物装备3 = nil
		self.召唤兽装备 = nil
		self.穿戴饰品=nil
		self.物品 = nil
		self.法宝佩戴=nil
		self.资源组=nil
		self.法宝按钮=nil
		self.开始 = nil
		self.结束 = nil
		if tp.窗口.灵饰.可视 then
			tp.窗口.灵饰:打开()
		end
		if tp.窗口.锦衣.可视 then
			tp.窗口.锦衣:打开()
		end
		return
	else
		insert(tp.窗口_,self)
		self.选中召唤兽 = 0
		self.加入 = 0
		self.当前银行 = "现金"
		self.窗口 = "主人公"
		self:加载资源()
		for s=1,3 do
			self.召唤兽装备[s]:置物品(nil)
		end
		local n = qtxs(tp.队伍[1].模型)
		self.资源组[4] = tp.资源:载入(n[7],"网易WDF动画",n[3])
		for i=1,6 do
			self.人物装备[i]:置物品(tp.队伍[1].装备[i])
		end
		self.开始 = 1
		self.结束 = 20
		for q=self.开始,self.结束 do
			self.物品[q]:置物品(tp.道具列表[q])
		end
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.点击类型="道具"
	    self.选择类型="道具"
	    self.法宝选中=0
	end
end

function 场景类_道具行囊:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 资源:载入('wzife.wdf',"网易WDF动画",0x83084DEB),
		[2] = 资源:载入('wzife.wdf',"网易WDF动画",0x4B2AFA64),
		[3] = 资源:载入('wzife.wdf',"网易WDF动画",0x9B1DB10D),
		[5] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0xF11233BB),0,0,4,true,true),
		[6] = 按钮.创建(自适应.创建(10,4,37,20,1,3),0,0,4,true,true,"人物"),
		[7] = 按钮.创建(自适应.创建(10,4,37,20,1,3),0,0,4,true,true,"召唤"),
		[8] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"现金"),
		[9] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),
		[10] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),
		[11] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x63CC8A23),0,0,4,true,true),
		[12] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x00D13BBF),0,0,4,true,true),
		[13] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x18C30C41),0,0,4,true,true),
		[14] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x5F339316),0,0,4,true,true),
		[15] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x0AA7176D),0,0,4,true,true),
		[16] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x8773AFEA),0,0,4,true,true),
		[17] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x612D9651),0,0,4,true,true),
		[18] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x27031D21),0,0,4,true,true),
		[30] = 按钮.创建(自适应.创建(10,4,37,20,1,3),0,0,4,true,true,"坐骑"),
		[31] = 按钮.创建(自适应.创建(10,4,37,20,1,3),0,0,4,true,true,"子女"),
		[34] = 资源:载入('wzife.wdf',"网易WDF动画",0xA7CE2F61),
		[35] = 资源:载入('wzife.wd2',"网易WDF动画",0x115E9954),
		[36] = 按钮.创建(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"查看"),
		[37] = 按钮.创建(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"抛弃"),
		[38] = 按钮.创建(自适应.创建(10,4,24,20,1,3),0,0,4,true,true,"1"),
		[39] = 按钮.创建(自适应.创建(10,4,24,20,1,3),0,0,4,true,true,"2"),
		[40] = 按钮.创建(自适应.创建(10,4,24,20,1,3),0,0,4,true,true,"锦"),
		[41] = 按钮.创建(自适应.创建(10,4,24,20,1,3),0,0,4,true,true,"饰"),
		[42] = 按钮.创建(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"骑乘"),
		[43] = 按钮.创建(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"下骑"),
		[44] = 按钮.创建(资源:载入('wzife.wdf',"网易WDF动画",0x00D13BBF),0,0,4,true,true,"法宝"),
		[45] = 资源:载入('wzife.wdf',"网易WDF动画",0X419DCF2A),
		[46] = 资源:载入('wzife.wdf',"网易WDF动画",0X300C54D8),
		[47] = 资源:载入('wzife.wdf',"网易WDF动画",0xCF39217A),
		[48] = 资源:载入('wzife.wdf',"网易WDF动画",0xFE7DE843),
		[49] = 资源:载入('wzife.wdf',"网易WDF动画",0xC0520208),
		[50] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"使用"),
        [51] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"修炼"),
        [52] = 资源:载入('wzife.wdf',"网易WDF动画",0xA393A808),
        [53] = 按钮.创建(自适应.创建(10,4,24,20,1,3),0,0,4,true,true,"3"),
        [54] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"出售"),
        [55] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"仓库"),
        [56] = 按钮.创建(自适应.创建(10,4,37,20,1,3),0,0,4,true,true,"助战"),
        [57] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"清包"),
        [58] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"过滤"),
	}
	for n=5,33 do
		if self.资源组[n] ~= nil and n ~= 19 then
			self.资源组[n]:绑定窗口_(9)
		end
	end
	for n=36,42 do
		self.资源组[n]:绑定窗口_(9)
	end
	self.资源组[53]:绑定窗口_(9)
	self.资源组[57]:绑定窗口_(9)
	self.资源组[58]:绑定窗口_(9)
	for n=50,51 do
		self.资源组[n]:绑定窗口_(9)
	end
	self.法宝按钮=按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"法宝")
	self.法宝按钮:绑定窗口_(9)
	self.资源组[38]:置偏移(0,-1)
	self.资源组[39]:置偏移(0,-1)
	self.资源组[40]:置偏移(-2,-1)
	self.资源组[41]:置偏移(-2,-1)
	local 格子 = tp._物品格子
	local 底图 = tp.资源:载入('wzife.wdf',"网易WDF动画",0xA393A808)
	self.人物装备 = {}
	self.人物装备2 = {}
	self.人物装备3 = {}
	for i=1,6 do
		self.人物装备[i] = 格子(0,0,i,"道具行囊_人物装备",底图)
		self.人物装备2[i] = 格子(0,0,i,"道具行囊_人物装备",底图)
		self.人物装备3[i] = 格子(0,0,i,"道具行囊_人物装备",底图)
	end
	self.召唤兽装备 = {}
	for i=1,3 do
		self.召唤兽装备[i] = 格子(0,0,i,"道具行囊_召唤兽装备",底图)
	end

	self.穿戴饰品={}
	self.穿戴饰品[1]=格子(0,0,1,"道具行囊_召唤兽装备",底图)

	self.物品 = {}
	for i=1,100 do
		self.物品[i] = 格子.创建(0,0,i,"道具行囊_物品")
	end

    self.法宝佩戴={}
    for i=1,3 do
		self.法宝佩戴[i] = 格子.创建(0,0,i,"道具行囊_法宝")
	end

end
function 场景类_道具行囊:刷新装备()
 	for i=1,6 do
 	   self.人物装备[i]:置物品(nil)
	   self.人物装备[i]:置物品(tp.队伍[1].装备[i])
	end
end

function 场景类_道具行囊:刷新坐骑饰品()
	if tp.坐骑列表[self.选中召唤兽].饰品物件~=nil then
	    self.穿戴饰品[1]:置物品(tp.坐骑列表[self.选中召唤兽].饰品物件)
	else
		self.穿戴饰品[1]:置物品(nil)
	end
end


function 场景类_道具行囊:置形象()
	self.资源组[99] = nil
	self.资源组[98] = nil
	if self.窗口 == "召唤兽" then
		if self.选中召唤兽 ~= 0 and tp.队伍[1].宝宝列表[self.选中召唤兽]  ~= nil then
			local n = qzdmx(tp.队伍[1].宝宝列表[self.选中召唤兽].模型)
			self.资源组[4] = tp.资源:载入(n[10],"网易WDF动画",n[6])
			if qzdmx(tp.队伍[1].宝宝列表[self.选中召唤兽].模型.."_饰品") ~= nil and #qzdmx(tp.队伍[1].宝宝列表[self.选中召唤兽].模型.."_饰品") ~= 0 then
				n = qzdmx(tp.队伍[1].宝宝列表[self.选中召唤兽].模型.."_饰品")
				self.资源组[98] = tp.资源:载入(n[10],"网易WDF动画",n[6])
				self.资源组[98]:置方向(0)
			end
			if tp.队伍[1].宝宝列表[self.选中召唤兽].染色方案 ~= nil then
				self.资源组[4]:置染色(tp.队伍[1].宝宝列表[self.选中召唤兽].染色方案,tp.队伍[1].宝宝列表[self.选中召唤兽].染色组[1],tp.队伍[1].宝宝列表[self.选中召唤兽].染色组[2],tp.队伍[1].宝宝列表[self.选中召唤兽].染色组[3])
				self.资源组[4]:置方向(0)
			end
			for i=1,3 do
				self.召唤兽装备[i]:置物品(tp.队伍[1].宝宝列表[self.选中召唤兽].装备[i])
			end
		end
	elseif self.窗口 == "子女" then
		if self.选中召唤兽 ~= 0 and tp.队伍[1].子女列表[self.选中召唤兽]  ~= nil then
			local n = qzdmx(tp.队伍[1].子女列表[self.选中召唤兽].模型)
			self.资源组[4] = tp.资源:载入(n[10],"网易WDF动画",n[6])
			if tp.队伍[1].子女列表[self.选中召唤兽].染色方案 ~= nil then
				self.资源组[4]:置染色(tp.队伍[1].子女列表[self.选中召唤兽].染色方案,tp.队伍[1].子女列表[self.选中召唤兽].染色组[1],tp.队伍[1].子女列表[self.选中召唤兽].染色组[2],tp.队伍[1].子女列表[self.选中召唤兽].染色组[3])
				self.资源组[4]:置方向(0)
			end
			for i=1,3 do
				self.召唤兽装备[i]:置物品(tp.队伍[1].子女列表[self.选中召唤兽].装备[i])
			end
		end
	elseif self.窗口 == "坐骑" then
		if self.选中召唤兽 ~= 0 and tp.坐骑列表[self.选中召唤兽]  ~= nil then
			local n = zqj(tp.队伍[1].模型,tp.坐骑列表[self.选中召唤兽].模型,tp.坐骑列表[self.选中召唤兽].饰品 or "空")
			self.资源组[4] = tp.资源:载入(n.坐骑资源,"网易WDF动画",n.坐骑站立)
			if tp.坐骑列表[self.选中召唤兽].饰品  ~= nil then
				self.穿戴饰品[1]:置物品(tp.坐骑列表[self.选中召唤兽].饰品物件)
				self.资源组[99] = tp.资源:载入(n.坐骑饰品资源,"网易WDF动画",n.坐骑饰品站立)
				if tp.坐骑列表[self.选中召唤兽].饰品物件~=nil and tp.坐骑列表[self.选中召唤兽].饰品物件.染色方案 ~= nil then
					self.资源组[99]:置染色(tp.坐骑列表[self.选中召唤兽].饰品物件.染色方案,tp.坐骑列表[self.选中召唤兽].饰品物件.染色组[1],tp.坐骑列表[self.选中召唤兽].饰品物件.染色组[2],tp.坐骑列表[self.选中召唤兽].饰品物件.染色组[3])
				end
			end
			if tp.坐骑列表[self.选中召唤兽].染色方案 ~= nil then
				self.资源组[4]:置染色(tp.坐骑列表[self.选中召唤兽].染色方案,tp.坐骑列表[self.选中召唤兽].染色组[1],tp.坐骑列表[self.选中召唤兽].染色组[2],tp.坐骑列表[self.选中召唤兽].染色组[3])
			end
		end
	end
end

function 场景类_道具行囊:刷新道具资源()
   self.开始 = 1
   self.结束 = 20
	for q=self.开始,self.结束 do
	  self.物品[q]:置物品(tp.道具列表[q])
	end
end

function 场景类_道具行囊:更新法宝经验(数据)
 if self.物品[数据.id]~=nil and self.物品[数据.id].物品~=nil then

     self.物品[数据.id].物品.当前经验=数据.当前经验
     self.物品[数据.id].物品.升级经验=数据.升级经验
     self.物品[数据.id].物品.气血=数据.境界
     self.物品[数据.id].物品.魔法=数据.灵气
 	 end

 end

function 场景类_道具行囊:刷新法宝资源()
   	self.开始 = 1
   	self.结束 = 20
	for q=self.开始,self.结束 do
	  self.物品[q]:置物品(tp.法宝列表[q])
	end
  	self.法宝选中=0
  	for i=1,3 do
		self.法宝佩戴[i]:置物品(tp.法宝佩戴[i])
	end
end

function 场景类_道具行囊:显示(dt,x,y)
	右键弹起=false
	self.焦点 = false
	if (self.窗口 == "召唤兽" or self.窗口 == "子女") and self.资源组[4] ~= nil then
		self.资源组[4]:更新(dt)
	end
	self.资源组[5]:更新(x,y)
	self.资源组[8]:更新(x,y,self.窗口 == "主人公")
	self.资源组[9]:更新(x,y,self.加入 > 0)
	self.资源组[10]:更新(x,y,(self.窗口 == "召唤兽" and self.加入 <  #tp.队伍[1].宝宝列表 - 4) or (self.窗口 == "子女" and self.加入 <  #tp.队伍[1].子女列表 - 4) or (self.窗口 == "坐骑" and self.加入 <  #tp.队伍[1].坐骑列表 - 4))
	self.资源组[11]:更新(x,y, not (self.点击类型=="道具"),2)
	self.资源组[12]:更新(x,y, not (self.点击类型=="行囊"),2)
	self.法宝按钮:更新(x,y, not (self.点击类型=="法宝"),2)
	self.资源组[54]:更新(x,y)
	self.资源组[57]:更新(x,y)
	self.资源组[58]:更新(x,y)
	self.资源组[55]:更新(x,y)
	self.资源组[50]:更新(x,y, not(self.法宝选中==0),2)
    self.资源组[51]:更新(x,y, not( self.法宝选中==0),2)
	local 字体 = tp.字体表.普通字体
	if self.鼠标 then
		if self.资源组[5]:事件判断() then
			self:打开()
			return false
		elseif self.资源组[8]:事件判断() then
			if self.当前银行 == "现金" then
				self.当前银行 = "储备"
			elseif self.当前银行 == "储备" then
				self.当前银行 = "现金"
			end
		elseif self.资源组[9]:事件判断() then
			self.加入 = self.加入 - 1
		elseif self.资源组[10]:事件判断() then
			self.加入 = self.加入 + 1
		elseif self.资源组[11]:事件判断() then
			if tp.场景.抓取物品ID==nil then
				self.开始 = 1
				self.结束 = 20
			  	发送数据(3699)
			  	self.点击类型="道具"
			  	if self.窗口=="法宝" then
	             	self.窗口="主人公"
			  	end
			else
			    发送数据(3701.1,{抓取id=tp.场景.抓取物品ID,放置类型="道具",抓取类型=self.抓取类型})
			    if tp.场景.抓取物品注释 == "道具行囊_物品" then
					self.物品[tp.场景.抓取物品ID].确定 = false
				elseif tp.场景.抓取物品注释 == "道具行囊_灵饰" then
					tp.窗口.灵饰.物品[tp.场景.抓取物品ID].确定 = false
				elseif tp.场景.抓取物品注释 == "道具行囊_锦衣" then
					tp.窗口.锦衣.物品[tp.场景.抓取物品ID].确定 = false
				end
				tp.场景.抓取物品 = nil
				tp.场景.抓取物品ID = nil
				tp.场景.抓取物品注释 = nil
			end
		elseif self.资源组[12]:事件判断() then
			if tp.场景.抓取物品ID==nil then
				self.开始 = 21
				self.结束 = 40
	            tp.法宝列表={}
			    发送数据(3700)
			  	self.点击类型="行囊"
			  	if self.窗口=="法宝" then
	            	self.窗口="主人公"
			  	end
			else
			    发送数据(3701.1,{抓取id=tp.场景.抓取物品ID,放置类型="行囊",抓取类型=self.抓取类型})
			    if tp.场景.抓取物品注释 == "道具行囊_物品" then
					self.物品[tp.场景.抓取物品ID].确定 = false
				elseif tp.场景.抓取物品注释 == "道具行囊_灵饰" then
					tp.窗口.灵饰.物品[tp.场景.抓取物品ID].确定 = false
				elseif tp.场景.抓取物品注释 == "道具行囊_锦衣" then
					tp.窗口.锦衣.物品[tp.场景.抓取物品ID].确定 = false
				end
				tp.场景.抓取物品 = nil
				tp.场景.抓取物品ID = nil
				tp.场景.抓取物品注释 = nil
			end
		elseif self.资源组[13]:事件判断() then
			self.开始 = 41
			self.结束 = 60
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.道具列表[q])
			end
		elseif self.资源组[14]:事件判断() then
			self.开始 = 61
			self.结束 = 80
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.道具列表[q])
			end
		elseif self.资源组[15]:事件判断() then
			self.开始 = 81
			self.结束 = 100
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.道具列表[q])
			end
		elseif self.资源组[16]:事件判断() then
			self.开始 = 101
			self.结束 = 120
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.道具列表[q])
			end
		elseif self.资源组[17]:事件判断() then
			self.开始 = 121
			self.结束 = 140
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.道具列表[q])
			end
		elseif self.资源组[18]:事件判断() then
			self.开始 = 141
			self.结束 = 160
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.道具列表[q])
			end
     	elseif self.资源组[50]:事件判断() then
	  	 	if self.法宝选中==0 then
             	tp.提示:写入("#Y/请先选中要使用的法宝")
             	return
         	elseif self.物品[self.法宝选中]~=nil and self.物品[self.法宝选中].物品~=nil then
		      	发送数据(3736,{序列=self.法宝选中})
		    end
	  	elseif self.资源组[51]:事件判断() then
	  	 	if self.法宝选中==0 then
	            tp.提示:写入("#Y/请先选中要修炼的法宝")
	            return
            elseif self.物品[self.法宝选中]~=nil and self.物品[self.法宝选中].物品~=nil and self.物品[self.法宝选中].物品.当前经验~=nil then
		      	发送数据(3733,{序列=self.法宝选中})
		-- end
	--tp.窗口.文本栏:载入("你确定要修炼#Y/"..self.物品[self.法宝选中].物品.名称.."#W/这件法宝吗?",nil,true,事件)
	      	else
	          	tp.提示:写入("#Y/你没有这样的法宝")
	  	 	end
      	elseif self.法宝按钮:事件判断() then
      		if tp.场景.抓取物品ID==nil then
	        	if self.窗口=="法宝" then
	             	self.窗口="主人公"
	             	self.点击类型="道具"
	             	发送数据(3699)
	            else
	             	self.窗口="法宝"
	             	self.点击类型="法宝"
	             	发送数据(3732)
	         	end
			else
			    发送数据(3701.1,{抓取id=tp.场景.抓取物品ID,放置类型="法宝",抓取类型=self.抓取类型})
			    if tp.场景.抓取物品注释 == "道具行囊_物品" then
					self.物品[tp.场景.抓取物品ID].确定 = false
				elseif tp.场景.抓取物品注释 == "道具行囊_灵饰" then
					tp.窗口.灵饰.物品[tp.场景.抓取物品ID].确定 = false
				elseif tp.场景.抓取物品注释 == "道具行囊_锦衣" then
					tp.窗口.锦衣.物品[tp.场景.抓取物品ID].确定 = false
				end
				tp.场景.抓取物品 = nil
				tp.场景.抓取物品ID = nil
				tp.场景.抓取物品注释 = nil
			end
		elseif self.资源组[38]:事件判断() then
			self.人物装备窗口=1
			if tp.窗口.锦衣.可视 then
				tp.窗口.锦衣.可视 = false
			end
			if tp.窗口.灵饰.可视 then
				tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[39]:事件判断() then
			self.人物装备窗口=2
			if tp.窗口.锦衣.可视 then
				tp.窗口.锦衣.可视 = false
			end
			if tp.窗口.灵饰.可视 then
				tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[53]:事件判断() then
			self.人物装备窗口=3
			if tp.窗口.锦衣.可视 then
				tp.窗口.锦衣.可视 = false
			end
			if tp.窗口.灵饰.可视 then
				tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[55]:事件判断() then
			发送数据(3756)
		elseif self.资源组[57]:事件判断() then
			发送数据(3800)
		elseif self.资源组[58]:事件判断() then
			发送数据(3801)
		end
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[11]:显示(self.x + 18,self.y + 410,true,nil,nil,self.点击类型=="道具",2)
	self.资源组[12]:显示(self.x + 63,self.y + 410,true,nil,nil,self.点击类型=="行囊",2)
	self.法宝按钮:显示(self.x + 243,self.y + 410,true,nil,nil,self.点击类型=="法宝",2)
	--self.资源组[54]:显示(self.x + 153,self.y + 410)
	self.资源组[55]:显示(self.x + 198,self.y + 410)
	self.资源组[57]:显示(self.x + 108,self.y + 410)
	self.资源组[58]:显示(self.x + 153,self.y + 410)
	if self.窗口 == "法宝" then
	     self.资源组[45]:显示(self.x,self.y + 20)
		 self.资源组[46]:显示(self.x + 10,self.y + 25)
		 self.资源组[47]:显示(self.x + 193,self.y + 25)
		 self.资源组[48]:显示(self.x + 253,self.y + 25)
		 self.资源组[49]:显示(self.x + 193,self.y + 80)
		 self.资源组[50]:显示(self.x + 251,self.y + 146)
	     self.资源组[51]:显示(self.x + 251,self.y + 172)
     	if self.法宝选中~=0 then
          	if self.物品[self.法宝选中]~=nil and self.物品[self.法宝选中].物品~=nil and self.物品[self.法宝选中].物品.当前经验~=nil then
               zts:置颜色(-16777216)
               zts:显示(self.x+90,self.y+150,self.物品[self.法宝选中].物品.升级经验)
               zts:显示(self.x+92,self.y+173,self.物品[self.法宝选中].物品.当前经验)
          	end
     	end
      local 佩戴坐标={{x=self.x+195,y=self.y+25},{x=self.x+255,y=self.y+25},{x=self.x+195,y=self.y+80}}
      for n=1,3 do
          if self.法宝佩戴[n].物品~=nil then
            self.资源组[52]:显示(佩戴坐标[n].x+2.5,佩戴坐标[n].y+3)
             self.法宝佩戴[n]:置坐标(佩戴坐标[n].x,佩戴坐标[n].y)
             self.法宝佩戴[n]:显示(dt,x,y,true)
             if self.法宝佩戴[n].焦点 and not tp.消息栏焦点 then
                  if self.法宝佩戴[n].物品 ~= nil then
					  tp.提示:道具行囊(x,y,self.法宝佩戴[n].物品)
					end

				  if 引擎.鼠标弹起(右键) then
				      发送数据(3734,{序列=n})
				  end
             	 end

          	 end

      	 end
      	for n=47,49 do
         	if tp.场景.抓取物品ID~=nil and self.资源组[n]:是否选中(x,y) and 引擎.鼠标弹起(左键) then
            	发送数据(3735,{序列=tp.场景.抓取物品ID,序列1=n-46})
             	tp.场景.抓取物品 = nil
		     	tp.场景.抓取物品ID = nil
		     	tp.场景.抓取物品注释 = nil
		     	self.物品[self.法宝选中].确定=false
		     	self.物品[self.法宝选中]:置物品(tp.法宝列表[self.法宝选中])
         	end
      	end
	elseif self.窗口 == "主人公" then
		self.资源组[2]:显示(self.x-1,self.y + 22)
		self.资源组[4]:显示(self.x + 38,self.y + 21)
		self.资源组[8]:置文字(self.当前银行)
		self.资源组[8]:显示(self.x + 5,self.y + 147,nil,true)
		self.资源组[40]:更新(x,y,not tp.窗口.锦衣.可视)
		self.资源组[41]:更新(x,y,not tp.窗口.灵饰.可视)
		self.资源组[53]:更新(x,y)
		self.资源组[38]:更新(x,y)
		self.资源组[39]:更新(x,y)


		if self.资源组[40]:事件判断() then
			tp.窗口.锦衣:打开(self.x+312,self.y+1)
			if tp.窗口.灵饰.可视 then
			    tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[41]:事件判断() then
			tp.窗口.灵饰:打开(self.x+312,self.y+1)
			if tp.窗口.锦衣.可视 then
			    tp.窗口.锦衣.可视 = false
			end
		end
		for s=1,2 do
			self.资源组[37+s]:更新(x,y)
			self.资源组[37+s]:显示(self.x + 170,floor(self.y + s * 25.5),nil,true)
		end
		self.资源组[40]:显示(self.x + 170,floor(self.y + 4 * 25.5),nil,true,nil,tp.窗口.锦衣.可视,2)--锦衣
		self.资源组[41]:显示(self.x + 170,floor(self.y + 5 * 25.5),nil,true,nil,tp.窗口.灵饰.可视,2)--灵饰
		self.资源组[38]:显示(self.x + 170,floor(self.y + 1 * 25.5),nil,true,nil,self.人物装备窗口==1,2)--装备1
		self.资源组[39]:显示(self.x + 170,floor(self.y + 2 * 25.5),nil,true,nil,self.人物装备窗口==2,2)--装备2
		self.资源组[53]:显示(self.x + 170,floor(self.y + 3 * 25.5),nil,true,nil,self.人物装备窗口==3,2)--装备3
		for i=1,6 do
			local 补差高度=3
			if i==1 or i == 2 then
			    补差高度=1
			elseif i==5 or i == 6 then
			    补差高度=2
			end
			if self.人物装备窗口 == 2 then
				self.人物装备2[i]:置坐标(self.x+self.装备坐标.x[i]+2,self.y+self.装备坐标.y[i]-补差高度,nil,nil,4,-1)
				self.人物装备2[i]:显示(dt,x,y,self.鼠标,nil,2)
			elseif self.人物装备窗口 == 3 then
				self.人物装备3[i]:置坐标(self.x+self.装备坐标.x[i]+2,self.y+self.装备坐标.y[i]-补差高度,nil,nil,4,-1)
				self.人物装备3[i]:显示(dt,x,y,self.鼠标,nil,3)
			else
				self.人物装备[i]:置坐标(self.x+self.装备坐标.x[i]+2,self.y+self.装备坐标.y[i]-补差高度,nil,nil,4,-1)
				self.人物装备[i]:显示(dt,x,y,self.鼠标,nil,1)
			end
			if self.人物装备[i].物品 ~= nil and self.人物装备[i].焦点 then
				tp.提示:道具行囊(x,y,self.人物装备[i].物品)
			end
			if self.人物装备[i].焦点 then
				self.焦点 = true
			end
			if not tp.消息栏焦点 then
			if tp.场景.抓取物品 == nil and self.人物装备[i].物品 ~= nil and self.人物装备[i].焦点   then
				if mousea(1) then
			    	发送数据(3704,{类型=self.点击类型,角色="主角",道具=i})
				end
			end
			-- 事件开始
			if self.人物装备[i].事件 then
				if tp.场景.抓取物品 ~= nil  and self.人物装备[i].焦点 then --and self.人物装备[i].物品 == nil
					发送数据(3703,{类型=self.点击类型,角色="主角",道具=tp.场景.抓取物品ID})
					tp.场景.抓取物品 = nil
				    tp.场景.抓取物品ID = nil
				    tp.场景.抓取物品注释 = nil
				elseif self.人物装备[i].焦点 and tp.场景.抓取物品 == nil and self.人物装备[i].物品 ~= nil then
					发送数据(3704,{类型=self.点击类型,角色="主角",道具=i})
				end
			end
			-- 事件结束
		end
	end
		local jq
		if self.当前银行 == "现金" then
			jq = tp.金钱
		elseif self.当前银行 == "储备" then
			jq = tp.储备
		elseif self.当前银行 == "积分" then
			jq = tp.积分
		end
	   	字体:置颜色(qjq(jq))
	   	字体:显示(self.x + 65,self.y + 153,jq)
	   	字体:置颜色(qjq(tp.存银))
	    字体:显示(self.x + 65,self.y + 174,tp.存银)
	elseif self.窗口 == "召唤兽" or self.窗口 == "子女" then
		if self.窗口 == "召唤兽" then
			self.资源组[3]:显示(self.x,self.y+22)
		elseif self.窗口 == "子女" then
			self.资源组[35]:显示(self.x,self.y+22)
			self.资源组[36]:更新(x,y,tp.队伍[1].子女列表[self.选中召唤兽] ~= nil)
			self.资源组[37]:更新(x,y,tp.队伍[1].子女列表[self.选中召唤兽] ~= nil)
			self.资源组[36]:显示(self.x+180,self.y+145)
			self.资源组[37]:显示(self.x+240,self.y+145)
			if self.资源组[36]:事件判断() then
				tp.窗口.召唤兽查看栏:打开(tp.队伍[1].子女列表[self.选中召唤兽])
			end
		end
	    --do
		self.资源组[9]:显示(self.x + 289,self.y + 23,true)
		self.资源组[10]:显示(self.x + 285,self.y + 115,true)
		local 列表 = 0
		字体:置颜色(-16777216)
		local dxs = nil
		if self.窗口 == "召唤兽" then
			dxs = tp.队伍[1].宝宝列表
		else
			dxs = tp.队伍[1].子女列表
		end
		for m=1,4 do
			if dxs[m + self.加入] ~= nil then
				bw:置坐标(self.x + 182,self.y + 24 + m * 23)
				if self.选中召唤兽 ~= m + self.加入 then
					if bw:检查点(x,y) then
						box(self.x + 179,self.y + 24 + m * 22,self.x + 283,self.y + 24 + m * 22 + 22,-3551379)
						if mousea(0) and self.鼠标 then
							self.选中召唤兽 = m + self.加入
							self:置形象()
						end
						self.焦点 = true
					end
				else
					local ys = -10790181
					if bw:检查点(x,y) then
						ys = -9670988
						self.焦点 = true
					end
					box(self.x + 179,self.y + 24 + m * 22,self.x + 283,self.y + 24 + m * 22 + 22,ys)
				end
				字体:显示(self.x + 182,self.y + 27 + m * 23,dxs[m + self.加入].名称)
			end
		end
		if self.窗口 == "召唤兽" and dxs[self.选中召唤兽] ~= nil then
			字体:显示(self.x + 209,self.y + 152 ,format("%s/%s",tp.队伍[1].宝宝列表[self.选中召唤兽].气血,tp.队伍[1].宝宝列表[self.选中召唤兽].最大气血))
			字体:显示(self.x + 209,self.y + 172 ,format("%s/%s",tp.队伍[1].宝宝列表[self.选中召唤兽].魔法,tp.队伍[1].宝宝列表[self.选中召唤兽].最大魔法))
		end
		if self.资源组[4] ~= nil then
			tp.影子:显示(self.x + 98,self.y + 115)
			self.资源组[4]:显示(self.x + 98,self.y + 115)
		end
		if self.资源组[98] ~= nil then
			self.资源组[98]:更新(dt)
			self.资源组[98]:显示(self.x + 98,self.y + 115)
		end
		for i=1,3 do
			self.召唤兽装备[i]:置坐标(self.x+self.装备坐标.xx[i]+3,self.y+self.装备坐标.yy[i]-2)
			self.召唤兽装备[i]:显示(dt,x,y,self.鼠标)
			if not tp.消息栏焦点 then
				if self.召唤兽装备[i].物品 ~= nil and self.召唤兽装备[i].焦点 then
					tp.提示:道具行囊(x,y,self.召唤兽装备[i].物品)
				end
				if tp.队伍[1].宝宝列表[self.选中召唤兽] ~= nil then
					if tp.场景.抓取物品 == nil and self.召唤兽装备[i].物品 ~= nil and self.召唤兽装备[i].焦点  then
						if mousea(1) then
							发送数据(3709,{类型=self.点击类型,角色="bb",道具=i,编号=self.选中召唤兽})
						end
					end
					if self.召唤兽装备[i].事件 then

					end
				end
				if self.召唤兽装备[i].焦点 then
					self.焦点 = true
				end
			end
		end
	elseif self.窗口 == "坐骑" then
		self.资源组[34]:显示(self.x,self.y + 25)
		self.资源组[42]:更新(x,y,self.选中召唤兽 ~= 0 and (tp.坐骑 == nil or tp.坐骑.认证码 == nil or tp.坐骑.认证码~=tp.坐骑列表[self.选中召唤兽].认证码) )
		self.资源组[43]:更新(x,y,self.选中召唤兽 ~= 0 and tp.坐骑 ~= nil and tp.坐骑.认证码 ~= nil and tp.坐骑.认证码==tp.坐骑列表[self.选中召唤兽].认证码)
		self.资源组[9]:显示(self.x + 289,self.y + 23,true)
		self.资源组[10]:显示(self.x + 285,self.y + 115,true)
		if self.资源组[42]:事件判断() then
           发送数据(26,{序列=self.选中召唤兽})
		elseif self.资源组[43]:事件判断() then
			发送数据(27,{序列=0})
		end
		self.资源组[42]:显示(self.x+240,self.y+131)
		self.资源组[43]:显示(self.x+240,self.y+161)
		for m=1,4 do
			if tp.坐骑列表[m + self.加入] ~= nil then
				bw1:置坐标(self.x + 184,self.y + 37 + m * 18)
				if self.选中召唤兽 ~= m + self.加入 then
					if bw1:检查点(x,y) then
						box(self.x + 184,self.y + 37 + m * 18,self.x + 285,self.y + 37 + m * 18 + 17,-3551379)
						if mousea(0) and self.鼠标 then
							self.选中召唤兽 = m + self.加入
							self:置形象()
						end
						self.焦点 = true
					end
				else
					local ys = -10790181
					if bw1:检查点(x,y) then
						ys = -9670988
						self.焦点 = true
					end
					box(self.x + 184,self.y + 37 + m * 18,self.x + 285,self.y + 37 + m * 18 + 17,ys)
				end
				if tp.队伍[1].坐骑 ~= nil and  tp.队伍[1].坐骑[1] ~= nil and tp.队伍[1].坐骑[1].模型 == tp.坐骑列表[m + self.加入].模型 then
					字体:置颜色(-256)
				else
					字体:置颜色(-16777216)
				end
				字体:显示(self.x + 189,self.y + 38 + m * 18,tp.坐骑列表[m + self.加入].模型)
			end
		end
		if self.资源组[4] ~= nil then
			tp.影子:显示(self.x + 112,self.y + 158)
			self.资源组[4]:更新(dt)
			self.资源组[4]:显示(self.x + 112,self.y + 158)
			if self.资源组[99] ~= nil then
				self.资源组[99]:更新(dt)
				self.资源组[99]:显示(self.x + 112,self.y + 158)

			end
		end
		if self.穿戴饰品[1].物品~=nil and not tp.消息栏焦点 and self.选中召唤兽~=0 and tp.坐骑列表[self.选中召唤兽] ~= nil and tp.坐骑列表[self.选中召唤兽].饰品物件~=nil and self.穿戴饰品[1].焦点 then
		    tp.提示:道具行囊(x,y,self.穿戴饰品[1].物品)
		end
		if  self.穿戴饰品[1].物品~=nil and not tp.消息栏焦点 and self.选中召唤兽~=0 and tp.坐骑列表[self.选中召唤兽] ~= nil and  tp.坐骑列表[self.选中召唤兽].饰品物件~=nil then
			self.穿戴饰品[1]:置坐标(self.x+185,self.y+130)
			self.穿戴饰品[1]:显示(dt,x,y,self.鼠标)
		end
		if self.穿戴饰品[1].焦点 then
		    self.焦点 = true
	    	if mousea(1) then
				发送数据(3753,{类型=1,角色=1,道具=1,编号=self.选中召唤兽})
			end
		end
	end
    if self.窗口~="法宝" then
		 self.资源组[6]:更新(x,y,self.窗口 ~= "主人公")
		 self.资源组[7]:更新(x,y,self.窗口 ~= "召唤兽")
		 self.资源组[30]:更新(x,y,self.窗口 ~= "坐骑")
		 self.资源组[31]:更新(x,y,self.窗口 ~= "子女")
		 self.资源组[56]:更新(x,y,self.窗口 ~= "助战")
	 end
	if self.鼠标 then
		if self.资源组[6]:事件判断() then
			local n = qtxs(tp.队伍[1].模型)
			self.资源组[4] = tp.资源:载入(n[7],"网易WDF动画",n[3])
			for s=1,3 do
				self.召唤兽装备[s]:置物品(nil)
			end
			for n=1,6 do
				self.人物装备[n]:置物品(tp.队伍[1].装备[n])
			end
			self.当前银行 = "现金"
			self.窗口 = "主人公"
			self.选中召唤兽 = 0
			self.加入 = 0
		elseif self.资源组[7]:事件判断() then
			self.资源组[4] = nil
			for s=1,3 do
				self.召唤兽装备[s]:置物品(nil)
			end
			self.当前银行 = "现金"
			self.窗口 = "召唤兽"
			self.选中召唤兽 = 0
			self.加入 = 0
		elseif self.资源组[30]:事件判断() then
			self.资源组[4] = nil
			self.窗口 = "坐骑"
		elseif self.资源组[31]:事件判断() then
			self.资源组[4] = nil
			for s=1,3 do
				self.召唤兽装备[s]:置物品(nil)
			end
			self.选中召唤兽 = 0
			self.加入 = 0
			self.资源组[4] = nil
			self.窗口 = "子女"
		elseif self.资源组[56]:事件判断() then
			if tp.窗口.助战界面.可视 then
				tp.窗口.助战界面.可视 =false
			else
				发送数据(88)
			end
			self.可视 = false
		end
	end
	  if self.窗口~="法宝" then
	     self.资源组[6]:显示(self.x+2,self.y + 25,true,nil,nil,self.窗口 == "主人公",2)
	     self.资源组[7]:显示(self.x+2,self.y + 49,true,nil,nil,self.窗口 == "召唤兽",2)
	     self.资源组[30]:显示(self.x+2,self.y + 73,true,nil,nil,self.窗口 == "坐骑",2)
	     self.资源组[31]:显示(self.x+2,self.y + 97,true,nil,nil,self.窗口 == "子女",2)
	     self.资源组[56]:显示(self.x+2,self.y + 121,true,nil,nil,self.窗口 == "助战",2)
	 end
	self.资源组[5]:显示(self.x + 291,self.y + 6,true)
	local o = self.开始 - 1
	for h=1,4 do
		for l=1,5 do
			o = o + 1
			self.物品[o]:置坐标(l * 51 - 26 + self.x+4,h * 51 + 146 + self.y)
			self.物品[o]:显示(dt,x,y,self.鼠标)
			if self.物品[o].焦点 and not tp.消息栏焦点 then
				if self.物品[o].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[o].物品)
				end
				self.焦点 = true
			end
			if  tp.场景.地图.抓取物品 == nil and self.物品[o]~=nil and self.物品[o].焦点 and self.物品[o].物品 ~= nil and not tp.消息栏焦点 and self.物品[o].物品.分类 <=12 and self.物品[o].物品.总类~=2 and self.物品[o].物品.总类~="坐骑饰品" then
				if 引擎.鼠标弹起(0x01) and 右键弹起==false then --self.物品[o].右键
                   右键弹起=true
                   发送数据(3705,{类型=self.点击类型,编号=o,窗口=self.窗口,序列=self.选中召唤兽})
                   return
				end
			end
			if tp.场景.地图.抓取物品 == nil and self.物品[o].焦点 and self.物品[o].物品 ~= nil  then
				if mousea(1) then
					if self.物品[o].物品.总类 == 2 then
						if self.物品[o].物品.鉴定  then
						    if self.窗口 == "主人公" and self.物品[o].物品.分类 < 10 then
						    	if (引擎.按键按住(KEY.SHIFT) and 引擎.鼠标弹起(右键)) then
									if self.物品[o].物品.开运孔数.当前 ~=0 then
						    	    	tp.窗口.符石镶嵌:打开({道具=self.物品,ID=o})
									else
										tp.提示:写入("#Y/该装备未开孔")
							    	end
								else
									发送数据(3703,{类型=self.点击类型,角色="主角",道具=o})
								end
							elseif self.窗口 == "召唤兽" and self.选中召唤兽 ~= 0 then
								发送数据(3708,{类型=self.点击类型,角色="bb",道具=o,编号=self.选中召唤兽})
							end
							if self.物品[o].物品 ~= nil and self.物品[o].物品.分类 >= 10 and self.物品[o].物品.分类 <=14 then
								if tp.窗口.灵饰.可视 ~= true then
									tp.窗口.灵饰:打开(self.x+312,self.y+1)
								end
								发送数据(3703,{类型=self.点击类型,角色="主角",道具=o})
							elseif self.物品[o].物品 ~= nil and self.物品[o].物品.分类 >= 15  then
								if self.物品[o].物品.分类 == 15 then
									if tp.队伍[1].锦衣[1] == nil then
									    tp.队伍[1].锦衣[1] = {}
									end
									tp.队伍[1].锦衣[1].名称 = self.物品[o].物品.名称
									tp.场景.人物:置模型()
								elseif self.物品[o].物品.分类 == 16 then
									if tp.队伍[1].锦衣[2] == nil then
									    tp.队伍[1].锦衣[2] = {}
									end
									tp.队伍[1].锦衣[2].名称 = self.物品[o].物品.名称
								    tp.场景.人物:穿戴光环()
								elseif self.物品[o].物品.分类 == 17 then
									if tp.队伍[1].锦衣[3] == nil then
									    tp.队伍[1].锦衣[3] = {}
									end
									tp.队伍[1].锦衣[3].名称 = self.物品[o].物品.名称
								    tp.场景.人物:穿戴足迹()
								end
								if tp.窗口.锦衣.可视 ~= true then
									tp.窗口.锦衣:打开(self.x+312,self.y+1)
								end
								发送数据(3703,{类型=self.点击类型,角色="主角",道具=o})
							end
						else
							tp.提示:写入("#Y/未鉴定的装备无法穿戴")
						end

					elseif self.物品[o].物品.总类 == "坐骑饰品" then
						if self.窗口=="坐骑" and self.选中召唤兽 ~=0 then
						    发送数据(3750,{类型=self.点击类型,角色="坐骑",道具=o,编号=self.选中召唤兽})
						else
							tp.提示:写入("#Y/坐骑饰品只能给坐骑使用哦")
						end
					end
				end
			end
			-- 点击物品逻辑
			if tp.场景.抓取物品 ~= nil  and (tp.场景.抓取物品注释 == "道具行囊_物品") and self.资源组[54]:是否选中(x,y) then
				if mousea(0) then
					self.物品[tp.场景.抓取物品ID].确定 = false
					发送数据(3739,{物品=tp.场景.抓取物品ID,类型=self.点击类型})
					tp.场景.抓取物品 = nil
					tp.场景.抓取物品ID = nil
					tp.场景.抓取物品注释 = nil
				end
			end
			if self.物品[o].事件 then
				if tp.场景.抓取物品 == nil and self.物品[o].物品 ~= nil and 引擎.鼠标弹起(0x00)  then
                 	local 允许拿起=true
                  	if self.窗口=="法宝" then
                  	 	if self.物品[self.法宝选中]~=nil then
                          	self.物品[self.法宝选中].选中=nil
                  	 	end
                     	if self.法宝选中~=o then
                         	self.法宝选中=o
                         	self.物品[o].选中=true
                         	允许拿起=false
                     	end
                  	end
                 	if 允许拿起 then
					  	tp.场景.抓取物品 = self.物品[o].物品
					 	tp.场景.抓取物品ID = o
					 	tp.场景.抓取物品注释 = self.物品[o].注释
					 	self.物品[tp.场景.抓取物品ID].确定 = true
					 	self.物品[o]:置物品(nil)
					 	self.抓取类型=self.点击类型
					end
				elseif tp.场景.抓取物品 ~= nil and self.物品[o].物品 == nil and (tp.场景.抓取物品注释 == "道具行囊_物品" or tp.场景.抓取物品注释 == "道具行囊_灵饰" or tp.场景.抓取物品注释 == "道具行囊_锦衣")  then
					发送数据(3701,{抓取id=tp.场景.抓取物品ID,放置id=o,放置类型=self.点击类型,抓取类型=self.抓取类型})
					if tp.场景.抓取物品注释 == "道具行囊_物品" then
						self.物品[tp.场景.抓取物品ID].确定 = false
					elseif tp.场景.抓取物品注释 == "道具行囊_灵饰" then
						tp.窗口.灵饰.物品[tp.场景.抓取物品ID].确定 = false
					elseif tp.场景.抓取物品注释 == "道具行囊_锦衣" then
						tp.窗口.锦衣.物品[tp.场景.抓取物品ID].确定 = false
					end
					tp.场景.抓取物品 = nil
					tp.场景.抓取物品ID = nil
					tp.场景.抓取物品注释 = nil
				elseif tp.场景.抓取物品 ~= nil and self.物品[o].物品 ~= nil and tp.场景.抓取物品注释 == "道具行囊_物品"  then
					local jy = self.物品[o].物品
					local jy1 = tp.场景.抓取物品
					local jy2 = tp.场景.抓取物品ID
					发送数据(3701,{抓取id=tp.场景.抓取物品ID,放置id=o,放置类型=self.点击类型,抓取类型=self.抓取类型})
					self.物品[tp.场景.抓取物品ID].确定 = false
					tp.场景.抓取物品 = nil
					tp.场景.抓取物品ID = nil
					tp.场景.抓取物品注释 = nil
				end
			end
			-- 事件完毕开始刷新
			if self.物品[o].物品 ~= nil and self.物品[o].物品.数量 ~= nil and self.物品[o].物品.数量 <= 0 then
				-- self.物品[o]:置物品(nil)
			end
			-- 刷新道具逻辑(self.物品[o].物品,o,true)
		end
	end
	字体:置颜色(-256)
	字体:显示(self.x + 20,self.y + 435,self.提示文字)
	if tp.窗口.锦衣.可视 == false and tp.窗口.锦衣.鼠标 then
		tp.窗口.锦衣.鼠标 = false
	end
	if tp.窗口.灵饰.可视 == false and tp.窗口.灵饰.鼠标 then
		tp.窗口.灵饰.鼠标 = false
	end
	if not self.鼠标 and not tp.窗口.灵饰.鼠标 and not tp.窗口.锦衣.鼠标 then
		if mousea(0)  then
			if tp.场景.抓取物品 ~= nil and not tp.窗口.文本栏.可视 and not tp.窗口.符石镶嵌.可视 then
				tp.窗口.文本栏:载入("真的要#Y/摧毁#R/"..tp.场景.抓取物品.名称.."#W/吗?","丢弃物品",true)
			end
		end
	end
end

function 场景类_道具行囊:刷新()
	if self.窗口 == "主人公" then
		local n = qtxs(tp.队伍[1].模型)
		self.资源组[4] = tp.资源:载入(n[7],"网易WDF动画",n[3])
		for n=1,6 do
			self.人物装备[n]:置物品(tp.队伍[1].装备[n])
		end
	elseif self.窗口 == "召唤兽" then
		self.选中召唤兽 = 0
		self.加入 = 0
		for n=1,3 do
			self.召唤兽装备[n]:置物品(nil)
		end
	end
end

function 场景类_道具行囊:可装备(i1,i2)
	if i2 > 6 and self.窗口 == "主人公" then
		tp.提示:写入("#Y/该装备与你的种族不符")
		return false
	elseif i2 < 6 and self.窗口 == "召唤兽" then
		tp.提示:写入("#Y/召唤兽不能穿戴该装备")
		return false
	end
	if i1.总类 ~= 2 then
		tp.提示:写入("#Y/这个物品不可以装备")
		return false
	end
	if i1 ~= nil and i1.分类 == i2 then
		if i2 == 1 or i2 == 4 then
			if i1.性别限制 ~= 0 and i1.性别限制 == tp.队伍[1].性别 then
					if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or tp.队伍[1].等级 >= i1.级别限制) then
						return true
					else
					if tp.队伍[1].等级 < i1.级别限制 then
						tp.提示:写入("#Y/你的等级不够呀")
					end
				end
			else
				tp.提示:写入("#Y/该装备您无法使用呀")
			end
		elseif i2 == 2 or i2 == 5 or i2 == 6 then
			if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or tp.队伍[1].等级 >= i1.级别限制) then
				return true
			else
				if i1.级别限制 > tonumber(tp.队伍[1].等级) then
					tp.提示:写入("#Y/你的等级不够呀")
				end
			end
		elseif i2 == 3 then
			if i1.角色限制 ~= 0 and (i1.角色限制[1] == tp.队伍[1].模型 or i1.角色限制[2] == tp.队伍[1].模型) then
					if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or tp.队伍[1].等级 >= i1.级别限制) then
						return true
					else
					if tp.队伍[1].等级 < i1.级别限制 then
						tp.提示:写入("#Y/你的等级不够呀")
					end
				end
			else
				tp.提示:写入("#Y/该装备您无法使用呀")
			end
		end
	end
	return false
end

function 场景类_道具行囊:召唤兽可装备(i1,i2)
	if i1 ~= nil and i1.分类 - 6 == i2 then
		if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or tp.队伍[1].宝宝列表[self.选中召唤兽].等级 >= i1.级别限制) then
			return true
		else
			if i1.级别限制 > tp.队伍[1].宝宝列表[self.选中召唤兽].等级 then
				tp.提示:写入("#Y/你的召唤兽等级不足哦")
			end
		end
	end
	return false
end

function 场景类_道具行囊:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 场景类_道具行囊:初始移动(x,y)
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

function 场景类_道具行囊:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

function 物品判断(道具,数量,失去)
	local a = false
	for n=1,160 do
		if tp.道具列表[n] ~= nil and tp.道具列表[n].名称 == 道具 and tp.道具列表[n].数量 >= (数量 or 1) then
			if 失去 ~= nil then
				if not tp.道具列表[n].可叠加 then
					tp.道具列表[n] = nil
				else
					tp.道具列表[n].数量 = tp.道具列表[n].数量 - 数量
					if tp.道具列表[n].数量 <= 0 then
						tp.道具列表[n] = nil
					end
				end
				if tp.窗口.道具行囊.可视 then
				    tp.窗口.道具行囊.物品[n]:置物品(tp.道具列表[n])
				end
				刷新道具逻辑(tp.道具列表[n],n,true)
			end
			a = true
			break
		end
	end
	return a
end

function 物品失去(道具,数量)
	local sq = 0
	for n=1,160 do
		if tp.道具列表[n] ~= nil and tp.道具列表[n].名称 == 道具 then
			if 数量 == nil then -- nil为全部失去
				sq = tp.道具列表[n].数量
				if sq == nil or sq <= 0 then
					sq = 1
				end
				tp.道具列表[n] = nil
			else
				sq = 数量
				if tp.道具列表[n].数量 == nil or tp.道具列表[n].数量 <= 0 then
					tp.道具列表[n].数量 = 1
				end
				if sq >= tp.道具列表[n].数量 then
					sq = tp.道具列表[n].数量
				end
				tp.道具列表[n].数量 = tp.道具列表[n].数量 - sq
				if tp.道具列表[n].数量 <= 0 then
					tp.道具列表[n] = nil
				end
			end
			if tp.窗口.道具行囊.可视 then
			   tp.窗口.道具行囊.物品[n]:置物品(tp.道具列表[n])
			end
			刷新道具逻辑(tp.道具列表[n],n,true)
			break
		end
	end
	return sq
end

function 取指定物品数量(道具)
	local sq = 0
	for n=1,160 do
		if tp.道具列表[n] ~= nil and tp.道具列表[n].名称 == 道具 then
			sq = tp.道具列表[n].数量 or 1
			if sq <= 0 then
				sq = 1
			end
			break
		end
	end
	return sq
end

function 取物品数量()
	local sl = 0
	for i=1,160 do
		if tp.道具列表[i] ~= nil then
			sl = sl + 1
		end
	end
	return sl
end


function 增加物品(名称,打造,数量)
	if 名称 == "" or 名称 == nil then
		return false
	end
	if 数量 == nil then
		数量= 1
	end
	if 取物品数量() == 160 then
		tp.提示:写入("#Y/少侠您的包裹已满，请及时清理")
	else
		local 物品 = nil
		if type(名称) == "table" then
			物品 = 名称
		else
			local item = tp._物品.创建()
			item:置对象(名称,打造,数量)
			物品 = item
		end
		if 物品.数量 == nil then
			物品.数量 = 1
		end
		if 物品.数量 <= 0 then
			物品.数量 = 1
		end
		-- 判断是否为数组
		local sx = 0
		local xt = false
		if 物品.可叠加 ~= nil and 物品.可叠加 ~= false then
			物品.数量 = 数量
			for s=1,160 do
				if tp.道具列表[s] ~= nil and tp.道具列表[s].名称 == 物品.名称 then
					sx = s
					xt = true
					break
				end
			end
		end
		if xt == false then
			for n=1,160 do
				if tp.道具列表[n] == nil then
					tp.道具列表[n] = 物品
					sx = n
					if tp.窗口.道具行囊.可视 then
					    tp.窗口.道具行囊.物品[sx]:置物品(物品)
					end
					break
				end
			end
		else
			if tp.道具列表[sx].数量 < 10000 then
				物品 = nil
				tp.道具列表[sx].数量 = tp.道具列表[sx].数量 + 数量
			else
				tp.提示:写入("#Y/超出物品上限无法获得")
			end
		end
		刷新道具逻辑(tp.道具列表[sx],sx)
	end
	return true
end

function 复制物品(物品)
	local 道具数据 = tp._物品()
	道具数据:置对象(物品.名称)
	道具数据.总类 = 物品.总类
	道具数据.分类 = 物品.分类
	道具数据.子类 = 物品.子类
	if 物品.伤害 ~= nil then
		道具数据.伤害 = 物品.伤害
	end
	if 物品.气血 ~= nil then
		道具数据.气血 = 物品.气血
	end
	if 物品.魔法 ~= nil then
		道具数据.魔法 = 物品.魔法
	end
	if 物品.愤怒 ~= nil then
		道具数据.愤怒 = 物品.愤怒
	end
	if 物品.体力 ~= nil then
		道具数据.体力 = 物品.体力
	end
	if 物品.活力 ~= nil then
		道具数据.活力 = 物品.活力
	end
	if 物品.命中 ~= nil then
		道具数据.命中 = 物品.命中
	end
	if 物品.伤害 ~= nil then
		道具数据.伤害 = 物品.伤害
	end
	if 物品.防御 ~= nil then
		道具数据.防御 = 物品.防御
	end
	if 物品.速度 ~= nil then
		道具数据.速度 = 物品.速度
	end
	if 物品.躲避 ~= nil then
		道具数据.躲避 = 物品.躲避
	end
	if 物品.灵力 ~= nil then
		道具数据.灵力 = 物品.灵力
	end
	if 物品.体质 ~= nil then
		道具数据.体质 = 物品.体质
	end
	if 物品.魔力 ~= nil then
		道具数据.魔力 = 物品.魔力
	end
	if 物品.力量 ~= nil then
		道具数据.力量 = 物品.力量
	end
	if 物品.耐力 ~= nil then
		道具数据.耐力 = 物品.耐力
	end
	if 物品.敏捷 ~= nil then
		道具数据.敏捷 = 物品.敏捷
	end
	if 物品.品质 ~= nil then
		道具数据.品质 = 物品.品质
	end
	if 物品.附带技能 ~= nil then
		道具数据.附带技能 = 物品.附带技能
	end
	if 物品.镶嵌四相 ~= nil then
		道具数据.镶嵌四相 = 物品.镶嵌四相
	end
	if 物品.锻炼等级 ~= nil then
		道具数据.锻炼等级 = 物品.锻炼等级
	end
	if 物品.镶嵌宝石 ~= nil then
		道具数据.镶嵌宝石 = 物品.镶嵌宝石
	end
	if 物品.级别限制 ~= nil then
		道具数据.级别限制 = 物品.级别限制
	end
	if 物品.特效 ~= nil then
		道具数据.特效 = 物品.特效
	end
	if 物品.特技 ~= nil then
		道具数据.特技 = 物品.特技
	end
	if 物品.价格 ~= nil then
		道具数据.价格 = 物品.价格
	end
	if 物品.五行 ~= nil then
		道具数据.五行 = 物品.五行
	end
	if 物品.数量 ~= nil and 物品.可叠加 then
		道具数据.数量 = 物品.数量
	end
	if 物品.制造者 ~= nil then
		道具数据.制造者 = 物品.制造者
	end
	return 道具数据
end

return 场景类_道具行囊