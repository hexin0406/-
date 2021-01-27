
local 场景类_组合输入框 = class()

local floor = math.floor
local zts,tp
local insert = table.insert
function 场景类_组合输入框:初始化(根)
	self.ID = 38
	self.x = 250
	self.y = 246
	self.xx = 0
	self.yy = 0
	self.注释 = "组合输入框"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('改名总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("输入",0,0,400,14)
	self.输入框:置可视(false,false)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.窗口时间 = 0
	tp = 根
	zts = 根.字体表.普通字体
end

function 场景类_组合输入框:打开(类型,附加)
	if self.可视 then
		self.回调事件 = nil
		self.类型事件 = nil
		self.输入框:置可视(false,false)
		self.可视 = false
		self.资源组 = nil
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			[1] = 资源:载入('wzife.wdf',"网易WDF动画",0x675760A4),
			[2] = 按钮(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"确定"),
			[3] = 按钮(自适应.创建(12,4,55,22,1,3),0,0,4,true,true,"取消"),
		}
		for i=2,3 do
		    self.资源组[i]:绑定窗口_(38)
		end

		if 类型 == "创建帮派" then
			self.输入框:置限制字数(14)
		elseif 类型 == "帮派宗旨" then
			self.输入框:置限制字数(150)
		end
		self.输入框:置可视(true,true)
		self.回调事件 = 附加
		self.类型事件 = 类型
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end


function 场景类_组合输入框:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	zts:置颜色(self.回调事件[2])
	zts:显示(self.x+36,self.y+38,self.回调事件[1])
	self.控件类:更新(dt,x,y)
	self.控件类:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	if self.资源组[2]:事件判断() then
		if self.类型事件 == "创建帮派" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入您要创建的帮派名称！")
			elseif string.find(self.输入框:取文本(), "#") ~= nil or string.find(self.输入框:取文本(),"/")~= nil
	        	or string.find(self.输入框:取文本(), "@") ~= nil or string.find(self.输入框:取文本(),"*")~= nil
	        	or string.find(self.输入框:取文本(), " ") ~= nil or string.find(self.输入框:取文本(),"~")~= nil
	        	or string.find(self.输入框:取文本(), "GM") ~= nil or string.find(self.输入框:取文本(),"gm")~= nil
	        	or string.find(self.输入框:取文本(), "	") ~= nil or string.find(self.输入框:取文本(),"充值")~= nil
	        	or string.find(self.输入框:取文本(), "游戏管理员") ~= nil or string.find(self.输入框:取文本(),"·")~= nil
	        	or self.输入框:取文本() == "" then
                tp.提示:写入("#Y/名字不能含有敏感字符")
			elseif string.len(self.输入框:取文本()) < 6  then
				tp.提示:写入("#Y/最低帮派名称不能少于3个汉字！")
			elseif string.len(self.输入框:取文本()) > 14  then
				tp.提示:写入("#Y/名称最多不能超过7个汉字")
			else
				发送数据(6101,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "帮派宗旨" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入您要修改的帮派宗旨！")
			elseif string.len(self.输入框:取文本()) <= 2  then
				tp.提示:写入("#Y/最低帮派名称不能少于1个字符！")
			else
				发送数据(6105,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "改名" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入您要修改的名字！")
			elseif string.len(self.输入框:取文本()) < 2  then
				tp.提示:写入("#Y/最低名称不能少于1个汉字！")
			elseif string.len(self.输入框:取文本()) > 14  then
				tp.提示:写入("#Y/名称最多不能超过7个汉字")
			else
				发送数据(3752,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "输入安全码" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入您的安全码！")
			else
				发送数据(3760,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "修改密码" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入您的安全码！")
			elseif string.len(self.输入框:取文本()) <= 6  then
				tp.提示:写入("#Y/密码不能小于6位")
			else
				发送数据(3761,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "更改宠物造型" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入召唤兽名字！")
			else
				发送数据(5021,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "元宝技能位置序号" then
			if self.输入框:取文本() == "" or self.输入框:取文本()+0< 1 or self.输入框:取文本()+0 > 24 then
				tp.提示:写入("#Y/请输入正确的数字！")
			else
				发送数据(5022,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "元宝技能名称" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入正确的技能名字！")
			else
				发送数据(5023,{文本=self.输入框:取文本(),技能序号=tp.定制技能序号})
				self:打开()
				return false
			end
		elseif self.类型事件 == "普通技能位置序号" then
			if self.输入框:取文本() == "" or self.输入框:取文本()+0< 1 or self.输入框:取文本()+0 > 24 then
				tp.提示:写入("#Y/请输入正确的数字！")
			else
				发送数据(5024,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "普通技能名称" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入正确的技能名字！")
			else
				发送数据(5025,{文本=self.输入框:取文本(),技能序号=tp.定制技能序号})
				self:打开()
				return false
			end
		elseif self.类型事件 == "帮派竞赛报名" then
			if self.输入框:取文本() == "" then
				tp.提示:写入("#Y/请输入您要报名的费用！")
			elseif string.len(self.输入框:取文本()) <= 5  then
				tp.提示:写入("#Y/最低报名费用不能低于50W")
			elseif self.输入框:取文本()<"500000" then
				tp.提示:写入("#Y/最低报名费用不能低于50W")
			else
				发送数据(42,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		end
	elseif self.资源组[3]:事件判断() then
		self:打开()
		return false
	end
	self.资源组[2]:显示(self.x+355,self.y+97)
	self.资源组[3]:显示(self.x+425,self.y+97)
	self.输入框:置坐标(self.x + 47,self.y + 71)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
end

function 场景类_组合输入框:检查点(x,y)
	if self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_组合输入框:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_组合输入框:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_组合输入框