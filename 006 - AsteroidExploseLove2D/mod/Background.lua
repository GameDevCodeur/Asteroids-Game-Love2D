
local Background = {
	img = nil
}

function Background:load()
	self.img = LG.newImage("gfx/background.png")
	self.transform = newObjTransform( 0, 0, 0, 0, 0, 2, 2)
	self.w = self.img:getWidth()
	self.h = self.img:getHeight()
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