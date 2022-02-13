
local Background = {
	--
	img = LG.newImage("gfx/background.png"),
	transform = newObjTransform( 
									0, 0, 
									0, 0, 
									0, 
									2, 2
								)
}

function Background:load()
	--
	self.w = self.img:getWidth()
	self.h = self.img:getHeight()
	--	
	self:Scale()	
	
end

function Background:Scale()

	if Game.win.w > self.w then
		self.transform.scale.x = Game.win.w / self.w
	else
		self.transform.scale.x = self.w / Game.win.w
	end
	
	if Game.win.h > self.h then
		self.transform.scale.y = Game.win.h / self.h
	else
		self.transform.scale.y = self.h / Game.win.h
	end
	
end

function Background:SetScale(x, y)
	--
	self.transform.scale.x = x
	self.transform.scale.y = y
	
end

function Background:update(dt)
	
end

function Background:draw()

	LG.draw(self.img, 
			self.transform.translate.x,
			self.transform.translate.y,
			0,
			self.transform.scale.x,
			self.transform.scale.y)
end


function Background:debug()
end

return Background