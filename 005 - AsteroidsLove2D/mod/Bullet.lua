
local Bullet = {
	weapon = {img = nil, 
			  ox = 0, 
			  oy = 0, 
			  bullets = {},			 
			 },
	reloadTime = .25,
	ready = 0
}

function Bullet:load()
	self.weapon.img = LG.newImage("gfx/bullet.png")
	self.weapon.ox = self.weapon.img:getWidth()  / 2
	self.weapon.oy = self.weapon.img:getHeight() / 2	
end

function Bullet:CreateBullet()
	return {
		velocite = {x = 0, y = 0, acceleration = 150},
		transform = newObjTransform(0, 0, 0, 0, 0, 4, 4),
		timeLive = 5,
	}	
end

function Bullet:update(dt)	

	if self.ready > 0 then
		self.ready = self.ready - dt		
	end
	
	if LK.isDown("space") then
		if self.ready <= 0 then
			-- Temps pour Shoot suivant
			self.ready = self.reloadTime			
			-- Creer nouveau Bullet
			table.insert(self.weapon.bullets, self.CreateBullet())	
			self.weapon.bullets[#self.weapon.bullets].transform.translate.x = plane.transform.translate.x + math.sin(plane.transform.rotate.x) * 35
			self.weapon.bullets[#self.weapon.bullets].transform.translate.y = plane.transform.translate.y - math.cos(plane.transform.rotate.x) * 35
			self.weapon.bullets[#self.weapon.bullets].velocite.x =  math.sin(plane.transform.rotate.x) * self.weapon.bullets[#self.weapon.bullets].velocite.acceleration
			self.weapon.bullets[#self.weapon.bullets].velocite.y = -math.cos(plane.transform.rotate.x) * self.weapon.bullets[#self.weapon.bullets].velocite.acceleration
		end
	end	
	
	-- Déplacments des Bullets
	for i = #self.weapon.bullets, 1, -1 do
		-- Calcule la Nouvelle Position
		self.weapon.bullets[i].transform.translate.x = self.weapon.bullets[i].transform.translate.x + (self.weapon.bullets[i].velocite.x * dt)
		self.weapon.bullets[i].transform.translate.y = self.weapon.bullets[i].transform.translate.y + (self.weapon.bullets[i].velocite.y * dt)
		
		-- Calcule la transition droite-gauche de l'écran
		if self.weapon.bullets[i].transform.translate.x > win.w then
			self.weapon.bullets[i].transform.translate.x = 0
		
		-- Calcule la transition gauche-droite de l'écran
		elseif self.weapon.bullets[i].transform.translate.x < 0 then
			self.weapon.bullets[i].transform.translate.x = win.w
		end
		
		-- Calcule la transition bas-haut de l'écran
		if self.weapon.bullets[i].transform.translate.y > win.h then
			self.weapon.bullets[i].transform.translate.y  = 0
			
		-- Calcule la transition haut-bas de l'écran
		elseif self.weapon.bullets[i].transform.translate.y  < 0 then
			self.weapon.bullets[i].transform.translate.y = win.h
		end
		
		-- Durée de vie des Bullets
		self.weapon.bullets[i].timeLive = self.weapon.bullets[i].timeLive - dt
		if self.weapon.bullets[i].timeLive < 0 then
			table.remove(self.weapon.bullets,i)
		end
	end	
	
end

function Bullet:draw()
	
	for _,v in pairs(self.weapon.bullets) do 
		LG.draw( 	self.weapon.img, 
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

	LG.print("Nb Billets : "..tostring(#self.weapon.bullets), 9, 50)
	
end

return Bullet