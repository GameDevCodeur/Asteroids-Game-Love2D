
local Bullet = {
	--
	weapon = {
				ox = 0, 
				oy = 0, 
				bullets = {},				
			 },
	reloadTime = .25,
	ready = 0,

}

function Bullet:load()
	--
	self.weapon.ox = Game.assetManager:getImage("bullet"):getWidth()  / 2
	self.weapon.oy = Game.assetManager:getImage("bullet"):getHeight() / 2	
	
end

function Bullet:CreateBullet()
	--
	Game.assetManager:getSound("shooter"):play()
	--
	return {
		velocite = {x = 0, y = 0, acceleration = 300},
		transform = newObjTransform(0, 0, 0, 0, 0, 4, 4),
		timeLive = 90 / 60, -- environs 1.5 sec 
	}
	
end

function Bullet:update(dt)	
	--
	if self.ready > 0 then
		--
		self.ready = self.ready - dt	
		
	end
	
	if LK.isDown("space") then
		--
		if self.ready <= 0 then
			-- Temps pour Shoot suivant
			self.ready = self.reloadTime			
			-- Creer nouveau Bullet
			table.insert(self.weapon.bullets, self.CreateBullet())
			--
			self.weapon.bullets[#self.weapon.bullets].transform.translate.x = Game.assetManager:getObject("plane").transform.translate.x + math.sin(Game.assetManager:getObject("plane").transform.rotate.x) * 35
			self.weapon.bullets[#self.weapon.bullets].transform.translate.y = Game.assetManager:getObject("plane").transform.translate.y - math.cos(Game.assetManager:getObject("plane").transform.rotate.x) * 35
			self.weapon.bullets[#self.weapon.bullets].velocite.x =  math.sin(Game.assetManager:getObject("plane").transform.rotate.x) * self.weapon.bullets[#self.weapon.bullets].velocite.acceleration
			self.weapon.bullets[#self.weapon.bullets].velocite.y = -math.cos(Game.assetManager:getObject("plane").transform.rotate.x) * self.weapon.bullets[#self.weapon.bullets].velocite.acceleration			
						
		end
		
	end	
	
	-- Déplacments des Bullets
	for i = #self.weapon.bullets, 1, -1 do
		-- Calcule la Nouvelle Position
		self.weapon.bullets[i].transform.translate.x = self.weapon.bullets[i].transform.translate.x + (self.weapon.bullets[i].velocite.x * dt)
		self.weapon.bullets[i].transform.translate.y = self.weapon.bullets[i].transform.translate.y + (self.weapon.bullets[i].velocite.y * dt)
		
		-- Calcule la transition gauche-droite de l'écran
		WrapAround(self.weapon.bullets[i])
	
		-- Durée de vie des Bullets
		self.weapon.bullets[i].timeLive = self.weapon.bullets[i].timeLive - 1 * dt
		
		--
		if self.weapon.bullets[i].timeLive < 0 then
			--
			table.remove(self.weapon.bullets,i)
			
		end
	end	
	
end

function Bullet:draw()
	
	for _,v in pairs(self.weapon.bullets) do 
		LG.draw( 	Game.assetManager:getImage("bullet"), 
					v.transform.translate.x,
					v.transform.translate.y,
					v.transform.rotate.x,
					v.transform.scale.x, 
					v.transform.scale.y,
					self.weapon.ox, self.weapon.oy  -- Point à l'origine au centre de l'image
				)
	end	

end

function Bullet:debug()
	--
	if (Game.debug) then 
		--
		LG.print("Nb Billets : "..tostring(#self.weapon.bullets), 9, 50)
		
	end
	
end

return Bullet