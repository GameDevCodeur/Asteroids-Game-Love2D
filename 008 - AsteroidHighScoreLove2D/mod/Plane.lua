
-- Plane GameObject
local Plane = {

	img       = LG.newImage("gfx/plane.png"),
	imgboost  = LG.newImage("gfx/planeboost.png"),
	velocite  = {},			
	transform = {},

}

function Plane:load()
	
	--
	self.velocite = {x = 0, y = 0, acceleration = 350}
	self.transform = newObjTransform(Game.win.w / 2, Game.win.h /2, 0, 0, 4.5, 1, 1)
	--
	self.ox = self.img:getWidth()  / 2
	self.oy = self.img:getHeight() / 2
	
	self.boost = false
	-- Clignotement si touché
	self.toggle = true
	self.timer = 0
	self.timerMax = 0
	self.collider = false
	
end

function Plane:CenterScreen()
	self.transform.translate.x = Game.win.w / 2
	self.transform.translate.y = Game.win.h / 2
end

function Plane:clignote(dt)
	--
	self.timer = self.timer + dt

	if self.timer > 0.3 and self.collider then
		--		
		self.timer = 0
		--
		if self.toggle then
			--
			self.toggle = false
		else
			--
			self.toggle = true
		end
		--
		self.timerMax = self.timerMax + 1
		if self.timerMax > 10 then
			--
			self.collider = false
			self.toggle   = true
			self.timerMax = 0
			
		end
	end

end

function Plane:update(dt)

	-- Clignote & invulnérable 
	Plane:clignote(dt)

	-- arret réacteur
	self.boost = false

	-- Evenements
	if LK.isDown("left")  then self:rotateLeft (dt) end
	if LK.isDown("right") then self:rotateRight(dt) end	
	if LK.isDown("up")    then self:thrust(dt)      end
		
	-- Calcule la Nouvelle Position
	self.transform.translate.x = self.transform.translate.x + (self.velocite.x * dt)
	self.transform.translate.y = self.transform.translate.y + (self.velocite.y * dt)
	
	-- Calcule les transitions Ecran Plane
	WrapAround(self)
	
end

function Plane:draw()
	--
	if self.toggle then
		--
		LG.draw( 	self.img,
					self.transform.translate.x,
					self.transform.translate.y,
					self.transform.rotate.x,
					self.transform.scale.x, self.transform.scale.y,
					self.ox, self.oy -- Point à l'origine au centre de l'image
				)
	
		--	
		if self.boost then
			local x = self.transform.translate.x 
			local y = self.transform.translate.y
	
			LG.draw( 		self.imgboost,
						x, y,		 
						self.transform.rotate.x,
						self.transform.scale.x, self.transform.scale.y,
						self.ox, self.oy -- Point à l'origine au centre de l'image
					)
		end
	--
	end
			
end

function Plane:thrust(dt)

	self.velocite.x = self.velocite.x + math.sin(self.transform.rotate.x) * (clamp( 150,  self.velocite.x,  190) * dt)
	self.velocite.y = self.velocite.y - math.cos(self.transform.rotate.x) * (clamp( 150,  self.velocite.y,  190) * dt)
	
	self.boost = true
	
end

function Plane:rotateLeft(dt)

	self.transform.rotate.x = self.transform.rotate.x - (self.transform.rotate.speed * dt)
	
end

function Plane:rotateRight(dt)

	self.transform.rotate.x = self.transform.rotate.x + (self.transform.rotate.speed * dt)

end

function Plane:shields()
	
	self.transform.translate.x = math.random(0 + 32, Game.win.w)
	self.transform.translate.y = math.random(0 + 32, Game.win.h)
	
end

function Plane:debug()

	LG.print("Plane velocite X: "..self.velocite.x, 9, 20)
	LG.print("Plane velocite Y: "..self.velocite.y, 9, 30)
	
end

function Plane:keypressed(key, scancode, isrepeat)

	if key == "escape" then
		self:CenterScreen()
	end
	
	if key == "down" then
		self:shields()
	end	
	
end

return Plane