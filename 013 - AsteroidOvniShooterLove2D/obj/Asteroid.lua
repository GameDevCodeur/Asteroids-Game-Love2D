
local Asteroid = {}

function Asteroid:load()
	--
	self.astres = {}
	--
	self.ox  = Game.assetManager:getImage("asteroid"):getWidth() / 2
	self.oy  = Game.assetManager:getImage("asteroid"):getHeight() / 2
	
end

function Asteroid:newAsteroidLevel()
	--
	for i = 1, math.clamp(6, Game.level, 15) do
		--
		self:new2( Game.win.w, Game.win.h, 1, 3)
			
	end	
end

function Asteroid:CreateAsteroid()
	--
	return {
		--
		velocite  = {x = 0, y = 0, acceleration = 0},						
		transform = newObjTransform( 0, 0, 0, 0, 0, 2, 2),
		points = 20
		
	}
	
end

function Asteroid:new(newAstre)
	-- Ajouter newAstre
	table.insert(self.astres, newAstre)
	
end

function Asteroid:new2(tx, ty, rspeed, sc)

	local w = math.random(500 - tx, 5000)
	local h = math.random(500 - ty, 5000)
		
	-- Creer nouveau astre
	local newAstre = {velocite  = {x = 0, y = 0, acceleration = math.random(1,4)},			
					  transform = newObjTransform( w, h, 0, 0, rspeed, sc, sc),
					  points = 20}	

	-- Ajouter newAstre
	table.insert(self.astres, newAstre)
	
end

function Asteroid:update(dt)

	for k,v in pairs(self.astres) do 
		v.transform.rotate.x = v.transform.rotate.x + (v.transform.rotate.speed * dt)
		
		if     (v.transform.scale.x > 2) then vspeed = 40 + Game.level * 2
		elseif (v.transform.scale.x > 1) then vspeed = 50 + Game.level * 4
		elseif (v.transform.scale.x > 0) then vspeed = 80 + Game.level * 6 end
						
		--
		v.velocite.x = vspeed
		v.velocite.y = vspeed
		
		-- Calcule la Nouvelle Position

		if (v.velocite.acceleration == 1) then
			v.transform.translate.x = v.transform.translate.x + (v.velocite.x * dt)
			v.transform.translate.y = v.transform.translate.y + (v.velocite.y * dt)
			
		elseif (v.velocite.acceleration == 2) then
			v.transform.translate.x = v.transform.translate.x - (v.velocite.x * dt)
			v.transform.translate.y = v.transform.translate.y + (v.velocite.y * dt)
			
		elseif (v.velocite.acceleration == 3) then
			v.transform.translate.x = v.transform.translate.x + (v.velocite.x * dt)
			v.transform.translate.y = v.transform.translate.y - (v.velocite.y * dt)
			
		elseif (v.velocite.acceleration == 4) then
			v.transform.translate.x = v.transform.translate.x - (v.velocite.x * dt)
			v.transform.translate.y = v.transform.translate.y - (v.velocite.y * dt)
		end
		
		-- Calcule les transitions Ecran Asteroid
		WrapAround(v)
		
		-- Remove Astre
		if v.transform.scale.x < 1 then
			table.remove(self.astres, k)
		end

	end

end

function Asteroid:draw()

	for _,v in pairs(self.astres) do 
		LG.draw( 	Game.assetManager:getImage("asteroid"), 
					v.transform.translate.x,
					v.transform.translate.y,
					v.transform.rotate.x,
					v.transform.scale.x, 
					v.transform.scale.y,
					self.ox, self.oy  -- Point à l'origine au centre de l'image
				)
	end	
	
end

function Asteroid:debug()
	--
	if (Game.debug) then 
		--
		LG.print("Nb Asteroids : "..tostring(#self.astres), 9, 40)
		
	end
	
end

return Asteroid