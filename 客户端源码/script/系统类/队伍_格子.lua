--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2020-06-09 15:03:14
--======================================================================--
local 系统类_队伍格子 = class()
local bw = require("gge包围盒")
local zts
local tp;
local qms = 引擎.取模型
local mouseb = 引擎.鼠标弹起
local zqj = 引擎.坐骑库
local qzdjy = 引擎.取锦衣模型
local qzdjys = 取锦衣身体模型
local 临时资源
local 临时资源包
local n,m

function 系统类_队伍格子:初始化(x,y,ID,根)
	self.x = x
	self.y = y+1
	self.ID = ID
	self.物品 = nil
	self.模型 = nil
	self.事件 = false
	self.焦点 = false
	self.禁止 = false
	self.包围盒  = bw(x,y,116,141)
end

function 系统类_队伍格子:置人物(人物)
	self.武器 = nil
	self.坐骑 = nil
	self.模型身体 = nil
	self.坐骑饰品 = nil
	self.光环 = nil
	self.足迹 = nil
	if 人物 ~= nil then
		if tp == nil then
			tp = 引擎.场景
			zts = tp.字体表.普通字体
		end
		if  人物.名称 ~= nil and 人物.名称 ~= 0 then
			self.武器 = nil
			self.坐骑 = nil
			self.坐骑饰品 = nil
			self.临时方向=4
			n = qms(人物.模型)
			if 人物.变身数据~=nil then
              n = qms(人物.变身数据)
              self.临时方向=1
              self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
              if 人物.变异 and 染色信息[人物.变身数据]~=nil then
                self.染色方案2 = 染色信息[人物.变身数据].id
				self.染色组2 = 染色信息[人物.变身数据].方案
		    	self.模型:置染色(self.染色方案2,self.染色组2[1],self.染色组2[2],self.染色组2[3])
              end
              self.模型:置方向(self.临时方向)
            elseif  人物.坐骑 ~= nil and (#人物.坐骑 ~= nil or #人物.坐骑 ~= 0) and 人物.坐骑.模型 ~= nil and 人物.锦衣[1]==nil then
				local 资源组 = zqj(人物.模型,人物.坐骑.模型,人物.坐骑.饰品 or "空")
				self.模型 = tp.资源:载入(资源组.人物资源,"网易WDF动画",资源组.人物站立)
				if 人物.染色方案~=nil then
				    self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
				end
				self.坐骑 = tp.资源:载入(资源组.坐骑资源,"网易WDF动画",资源组.坐骑站立)
				if 人物.坐骑.染色方案~=nil and 人物.坐骑.染色组~=0 and #人物.坐骑.染色组~=0 then
				    self.坐骑:置染色(人物.坐骑.染色方案,人物.坐骑.染色组[1],人物.坐骑.染色组[2],人物.坐骑.染色组[3])
				end
				if 资源组.坐骑饰品站立 ~= nil then
					self.坐骑饰品 = tp.资源:载入(资源组.坐骑饰品资源,"网易WDF动画",资源组.坐骑饰品站立)
					if 人物.坐骑.饰品物件~=nil and 人物.坐骑.饰品物件.染色方案~=nil and 人物.坐骑.饰品物件.染色组~=0 and #人物.坐骑.饰品物件.染色组~=0 then
					    self.坐骑饰品:置染色(人物.坐骑.饰品物件.染色方案,人物.坐骑.饰品物件.染色组[1],人物.坐骑.饰品物件.染色组[2],人物.坐骑.饰品物件.染色组[3])
					end
					self.坐骑饰品:置方向(4)
				end
				self.模型:置方向(4)
				self.坐骑:置方向(4)
            elseif  人物.装备[3] ~= nil then
            	m = tp:取武器子类(人物.装备[3].子类)
				n = qms(人物.模型,m)
				if 人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil and 人物.变身数据 == nil  then
					if 人物.锦衣[1].名称 == "夜影" or 人物.锦衣[1].名称 == "夏日清凉" or 人物.锦衣[1].名称 == "华风汉雅" or 人物.锦衣[1].名称 == "萌萌小厨" then
						临时资源 = qzdjy(人物.模型..m.."_静立_"..人物.锦衣[1].名称)
						临时资源包 = "shape0.npk"
						if 人物.锦衣[1].名称 == "华风汉雅" or 人物.锦衣[1].名称 == "萌萌小厨" then
							临时资源包 = "shape2.npk"
						end
						self.模型 = tp.资源:载入(临时资源包,"网易锦衣动画",临时资源)
						if 人物.锦衣[1].名称 == "夏日清凉" or 人物.锦衣[1].名称 == "华风汉雅" or 人物.锦衣[1].名称 == "萌萌小厨" then
							临时资源 = qzdjys(人物.模型..m.."_静立_"..人物.锦衣[1].名称.."_头")
							self.模型身体 = tp.资源:载入("shape0.npk","网易锦衣动画",临时资源)
							self.模型身体:置方向(4)
						end
					else
						n = qms(人物.锦衣[1].名称.."_"..人物.模型,m)
						self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
					end
				else
					self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
				end
				m = tp:取武器附加名称(人物.装备[3].子类,人物.装备[3].级别限制,人物.装备[3].名称)
				n = qms(m.."_"..人物.模型)
				self.武器 = tp.资源:载入(n[3],"网易WDF动画",n[1])
				if 人物.装备[3].染色方案 ~= nil then
					self.武器:置染色(人物.装备[3].染色方案,人物.装备[3].染色组[1],人物.装备[3].染色组[2],人物.装备[3].染色组[3])
				end
				self.武器:置方向(4)
				if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
				else
					self.武器:置差异(self.武器.帧数-self.模型.帧数)
				end
				if 人物.染色方案 ~= nil then
					if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
					else
						self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
					end
				end
				self.模型:置方向(4)
            else
				if 人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil and 人物.变身数据 == nil  then
					if 人物.锦衣[1].名称 == "夜影" or 人物.锦衣[1].名称 == "夏日清凉" or 人物.锦衣[1].名称 == "华风汉雅" or 人物.锦衣[1].名称 == "萌萌小厨" then
						临时资源 = qzdjy(人物.模型.."_静立_"..人物.锦衣[1].名称)
						临时资源包 = "shape0.npk"
						if 人物.锦衣[1].名称 == "华风汉雅" or 人物.锦衣[1].名称 == "萌萌小厨" then
							临时资源包 = "shape2.npk"
						end
						self.模型 = tp.资源:载入(临时资源包,"网易锦衣动画",临时资源)
						if 人物.锦衣[1].名称 == "夏日清凉" or 人物.锦衣[1].名称 == "华风汉雅" or 人物.锦衣[1].名称 == "萌萌小厨" then
							临时资源 = qzdjys(人物.模型.."_静立_"..人物.锦衣[1].名称.."_头")
							self.模型身体 = tp.资源:载入("shape0.npk","网易锦衣动画",临时资源)
							self.模型身体:置方向(4)
						end
					else
						n = qms(人物.锦衣[1].名称.."_"..人物.模型)
						self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
					end
				else
					self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
					if 人物.染色方案 ~= nil then
						if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
						else
							self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
						end
					end
				end
				self.模型:置方向(4)
			end
			if 人物.锦衣 ~= nil and 人物.锦衣[2] ~= nil then
				n = 引擎.取光环(人物.锦衣[2].名称)
				self.光环=tp.资源:载入(n[4],"网易WDF动画",n[1])
			end
			if 人物.锦衣 ~= nil and 人物.锦衣[3] ~= nil then
				n = 引擎.取足迹(人物.锦衣[3].名称)
				self.足迹=tp.资源:载入(n[4],"网易WDF动画",n[1])
			end
			self.人物 = 人物
		end
	else
	    self.模型 = nil
		self.人物 = nil
	end
end

function 系统类_队伍格子:显示(dt,x,y,条件,数据,x1,y1)
	self.事件 = false
	self.焦点 = false
	self.互换 = false
	if self.模型 == nil then
		self.武器 = nil
		self.坐骑 = nil
		self.模型身体 = nil
		self.坐骑饰品 = nil
	end
	if self.模型 ~= nil and self.人物 ~= nil then
		if self.坐骑 ~= nil then
			self.坐骑:更新(dt)
			if self.坐骑饰品 ~= nil then
				self.坐骑饰品:更新(dt)
			end
		end
		if self.模型身体 ~= nil then
			self.模型身体:更新(dt)
		end
		if self.武器 ~= nil then
			self.武器:更新(dt)
		end
		if self.光环 ~= nil then
			self.光环:更新(dt)
		end
		if self.足迹 ~= nil then
			self.足迹:更新(dt)
		end
		self.模型:更新(dt)
	end
	if 条件 and self.包围盒:检查点(x,y) and not tp.消息栏焦点 then
		tp.按钮焦点 = true
		tp.禁止关闭 = true
		self.焦点 = true
		if self.模型 ~= nil and self.人物 ~= nil then
			if mouseb(0) then
				self.事件 = true
			end
			if mouseb(1) then
				self.互换 = true
			end
		end
		if not self.禁止 then
			tp.队伍格子焦点_:显示(self.x,self.y)
		end
	end
	if self.禁止 then
		tp.队伍格子确定_:显示(self.x,self.y)
	end
	local 人物 = 数据[self.ID]
	if 人物 ~= nil then
		zts:置颜色(-16777216)
		zts:显示(self.x + 18+(x1 or 0),self.y + 152+(y1 or 0),人物.名称)
		zts:显示(self.x + 18+(x1 or 0),self.y + 176+(y1 or 0),人物.门派)
		zts:显示(self.x + 18+(x1 or 0),self.y + 200+(y1 or 0),人物.等级.."级")
	end
	if self.模型 ~= nil and 人物 ~= nil then
		tp.影子:显示(self.x + 54,self.y + 117)
		if self.光环 ~= nil then
			self.光环:显示(self.x + 54,self.y + 117)
		end
		if self.坐骑 ~= nil then
			self.坐骑:显示(self.x + 54,self.y + 117)
			if self.坐骑饰品 ~= nil then
				self.坐骑饰品:显示(self.x + 54,self.y + 117)
			end
		end
		if self.模型身体 ~= nil then
			self.模型身体:显示(self.x + 54,self.y + 117)
		end
		if self.足迹 ~= nil then
			self.足迹:显示(self.x + 54,self.y + 117)
		end
		self.模型:显示(self.x + 54,self.y + 117)
		if self.武器 ~= nil then
			self.武器:显示(self.x + 54,self.y + 117)
		end
	end
end

function 系统类_队伍格子:释放()

end

function 系统类_队伍格子:置坐标(x,y)
	self.x = x
	self.y = y
	self.包围盒:置坐标(x,y)
end

return 系统类_队伍格子