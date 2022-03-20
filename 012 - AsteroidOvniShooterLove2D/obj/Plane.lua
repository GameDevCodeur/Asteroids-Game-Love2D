
-- Plane GameObject
local Plane = {

	velocite  = {},			
	transform = {},
	
	-- Shoot
	reloadTime 	= .25,
	ready 		= 0,

}

function Plane:load()
	
	--
	self.velocite = {x = 0, y = 0, acceleration = 350}
	
	--
	self.transform = newObjTransform(	
										Game.win.w / 2, Game.win.h /2, 	-- position
										0, 0, 4.5, 						-- rotation
										1, 1							-- échelle										
									)
	
	--
	self.ox = Game.assetManager:getImage("plane"):getWidth()  / 2
	self.oy = Game.assetManager:getImage("plane"):getHeight() / 2
	
	--
	self.boost = false
	
	-- Clignotement si touché
	self.toggle = true
	self.timer = 0
	self.timerMax = 0
	self.collider = false
	self.boosttimer = 0
	
end

function Plane:CenterScreen()

	--
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
		self.toggle = not self.toggle
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

function Plane:shoot(dt)

	if self.ready > 0 then
		--
		self.ready = self.ready - dt	
		
	end
	
	-- Tir ready
	if self.ready <= 0 then
			
		-- Creer nouveau Bullet
		table.insert(Game.assetManager:getObject("bullet").weapon.bullets, 
					 Game.assetManager:getObject("bullet").CreateBullet())
		
		local nbBullet  = #Game.assetManager:getObject("bullet").weapon.bullets
		local newBullet = Game.assetManager:getObject("bullet").weapon.bullets[nbBullet]
		local objPlane  = Game.assetManager:getObject("plane")
		
		newBullet.id = "bulletPlan"
		
		-- Decalage Bullet pointe du Vaisseau
		local offRotate	= 35 
		
		-- Temps tir suivant
		self.ready = self.reloadTime		
				
		-- Calcule Positions				
		newBullet.transform.translate.x = 
							objPlane.transform.translate.x +
							math.sin(objPlane.transform.rotate.x) * offRotate
											
		newBullet.transform.translate.y = 
							objPlane.transform.translate.y - 
							math.cos(objPlane.transform.rotate.x) * offRotate
			
		-- Calcule Velocité						
		newBullet.velocite.x =   math.sin(objPlane.transform.rotate.x) * newBullet.velocite.acceleration											
		newBullet.velocite.y = 	-math.cos(objPlane.transform.rotate.x) * newBullet.velocite.acceleration
						
	end
end

function Plane:update(dt)

	-- Clignote & invulnérable 
	self:clignote(dt)

	-- arret réacteur
	self.boost = false

	-- Evenements
	if LK.isDown("left")  then self:rotateLeft (dt) end
	if LK.isDown("right") then self:rotateRight(dt) end	
	if LK.isDown("up")    then self:thrust(dt)      end
	if LK.isDown("space") then self:shoot(dt)		end
		
	-- Calcule la nouvelle position
	self.transform.translate.x = self.transform.translate.x + (self.velocite.x * dt)
	self.transform.translate.y = self.transform.translate.y + (self.velocite.y * dt)
	
	-- Calcule si transition écran
	WrapAround(self)	
	
end

function Plane:draw()

	--
	if self.toggle then
		--
		LG.draw( 	
					Game.assetManager:getImage("plane"),
					self.transform.translate.x,
					self.transform.translate.y,
					self.transform.rotate.x,
					self.transform.scale.x, self.transform.scale.y,
					self.ox, self.oy -- Point à l'origine au centre de l'image
				)
	
		--	
		if self.boost then
			--
			LG.draw( 	
						Game.assetManager:getImage("boost"),
						self.transform.translate.x , self.transform.translate.y,		 
						self.transform.rotate.x,
						self.transform.scale.x, self.transform.scale.y,
						self.ox, self.oy -- Point à l'origine au centre de l'image
					)
		end
	--
	end
			
end
--
function Plane:thrust(dt)
	-- Son réacteur
	Game.assetManager:getSound("boost"):play()
	-- 
	self.velocite.x = self.velocite.x + math.sin(self.transform.rotate.x) * (math.clamp( 150,  self.velocite.x,  190) * dt)
	self.velocite.y = self.velocite.y - math.cos(self.transform.rotate.x) * (math.clamp( 150,  self.velocite.y,  190) * dt)
	-- 
	self.boost = true
	
end

function Plane:rotateLeft(dt)
	--
	self.transform.rotate.x = self.transform.rotate.x - (self.transform.rotate.speed * dt)
	
end

function Plane:rotateRight(dt)
	--
	self.transform.rotate.x = self.transform.rotate.x + (self.transform.rotate.speed * dt)

end

function Plane:shields()
	--
	self.transform.translate.x = math.random(0 + 32, Game.win.w)
	self.transform.translate.y = math.random(0 + 32, Game.win.h)
	
end

function Plane:debug()
	--
	if (Game.debug) then
		--
		LG.print("Plane velocite X: "..self.velocite.x, 9, 20)
		LG.print("Plane velocite Y: "..self.velocite.y, 9, 30)
		
	end	
end

function Plane:keypressed(key, scancode, isrepeat)
	--
	if key == "down" then self:shields() end	
	
end

return Plane