
local Bullet = {
	--
	weapon 	=	{
					bullets = {	},
				},
}

function Bullet:load()
	
end

function Bullet:CreateBullet(idBullet)
	--
	Game.assetManager:getSound("shooter"):stop()
	Game.assetManager:getSound("shooter"):play()
	--
	return {
		velocite = {x = 1, y = 1, acceleration = 300},
		transform = newObjTransform(0, 0, 0, 0, 0, 4, 4),
		timeLive = 1.5, -- environs 1.5 sec 		
	}
	
end

function Bullet:update(dt)	
	
	-- Déplacments des Bullets
	for i = #self.weapon.bullets, 1, -1 do
	
		-- Calcule la Nouvelle Position
		self.weapon.bullets[i].transform.translate.x = 	self.weapon.bullets[i].transform.translate.x + 
														(self.weapon.bullets[i].velocite.x * dt)
														
		self.weapon.bullets[i].transform.translate.y = 	self.weapon.bullets[i].transform.translate.y + 
														(self.weapon.bullets[i].velocite.y * dt)
		
		-- Calcule la transition gauche-droite de l'écran
		WrapAround(self.weapon.bullets[i])
	
		-- Durée de vie des Bullets
		self.weapon.bullets[i].timeLive = self.weapon.bullets[i].timeLive - 1 * dt
		
		-- Remove Bullet
		if self.weapon.bullets[i].timeLive < 0 then
			--
			table.remove(self.weapon.bullets,i)
			
		end
	end	
	
end

function Bullet:draw()
	
	for _,v in pairs(self.weapon.bullets) do 
		--
		local img = Game.assetManager:getImage(v.id)
		
		LG.draw( 	img, 
					v.transform.translate.x,
					v.transform.translate.y,
					v.transform.rotate.x,
					v.transform.scale.x, 
					v.transform.scale.y,					
					img:getWidth()  / 2, -- Origine au centre de l'image
					img:getHeight() / 2 
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