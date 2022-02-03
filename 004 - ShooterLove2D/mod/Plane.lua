
-- Plane GameObject
local Plane = {
	img       = nil,
	velocite  = {},			
	transform = {}	-- Component Transform	
}

function Plane:load()
	self.img = LG.newImage("gfx/plane.png")
	self.velocite = {x = 0, y = 0, acceleration = 250}
	self.transform = newObjTransform(400, 300, 0, 0, 4.5, 4, 4)
	self.ox = self.img:getWidth()  / 2
	self.oy = self.img:getHeight() / 2
end
	
function Plane:update(dt)
	-- Evenements Clavier
	if LK.isDown("left")  then rotateLeft (plane, dt) end
	if LK.isDown("right") then rotateRight(plane, dt) end	
	if LK.isDown("up") 	  then velociteUp (plane, dt) end
	
	-- Calcule Nouvelle Position
	self.transform.translate.x = self.transform.translate.x + (self.velocite.x * dt)
	self.transform.translate.y = self.transform.translate.y + (self.velocite.y * dt)	
end

function Plane:draw()	
	LG.draw(	self.img, 
				self.transform.translate.x,
				self.transform.translate.y,
				self.transform.rotate.x,
				self.transform.scale.x, self.transform.scale.y,
				self.ox, self.oy  -- Point à l'origine au centre de l'image
			)	
end

function Plane:debug()
	LG.print("Plane velocite X: "..self.velocite.x, 9, 20)
	LG.print("Plane velocite Y: "..self.velocite.y, 9, 30)
end

return Plane