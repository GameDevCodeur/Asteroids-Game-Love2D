
local Background = {
	--
	transform = newObjTransform( 
									0, 0, 
									0, 0, 
									0, 
									2, 2
								)
}

function Background:load()
	--
	self.w = Game.assetManager:getImage("background"):getWidth()
	self.h = Game.assetManager:getImage("background"):getHeight()
	--	
	self:Scale()	
	
end

function Background:Scale()
	--
	self.transform.scale.x = ( (Game.win.w > self.w) and (Game.win.w / self.w) or (self.w / Game.win.w) )
	self.transform.scale.y = ( (Game.win.h > self.h) and (Game.win.h / self.h) or (self.h / Game.win.h) )
	
end

function Background:SetScale(x, y)
	--
	self.transform.scale.x = x
	self.transform.scale.y = y
	
end

function Background:update(dt)
	
end

function Background:draw()

	LG.draw(Game.assetManager:getImage("background"), 
			self.transform.translate.x,
			self.transform.translate.y,
			0,
			self.transform.scale.x,
			self.transform.scale.y)
end


function Background:debug()
end

return Background