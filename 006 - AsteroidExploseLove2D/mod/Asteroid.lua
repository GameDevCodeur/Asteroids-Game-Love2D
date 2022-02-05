
local Asteroid = {	
	img = nil, 
	ox = 0, 
	oy = 0, 
	astres = {},
}

function Asteroid:load()
	self.img = LG.newImage("gfx/asteroid.png")
	self.ox  = self.img:getWidth()  / 2
	self.oy  = self.img:getHeight() / 2	
end

function Asteroid:CreateAsteroid()
	return {
		velocite  = {	x = 0, 
						y = 0, 
						acceleration = 0},
						
		transform = newObjTransform( 0, 0, 0, 0, 0, 2, 2),		
	}
end

function Asteroid:new(x, y, rspeed, sc)

	math.randomseed(os.time())
	
	-- Creer nouveau astre
	table.insert(self.astres, self.CreateAsteroid())
	
	-- Ajuste la position, l'échelle, et la rotation
	self.astres[#self.astres].transform.translate.x = x
	self.astres[#self.astres].transform.translate.y = y
	self.astres[#self.astres].transform.rotate.speed = rspeed or 0
	self.astres[#self.astres].transform.scale.x = sc or 1
	self.astres[#self.astres].transform.scale.y = sc or 1
	self.astres[#self.astres].velocite.x = 3
	self.astres[#self.astres].velocite.y = 3
	self.astres[#self.astres].velocite.acceleration = math.random(1,4)
	
end

function Asteroid:update(dt)

	for _,v in pairs(self.astres) do 
		v.transform.rotate.x = v.transform.rotate.x + (v.transform.rotate.speed * dt)
		
		-- Directions asteroid
		if (v.velocite.acceleration == 1) then
			v.velocite.x = v.velocite.x + (clamp( 1, v.velocite.x, v.velocite.acceleration) * dt) 
			v.velocite.y = v.velocite.y + (clamp( 1, v.velocite.y, v.velocite.acceleration) * dt)
			
		elseif (v.velocite.acceleration == 2) then
			v.velocite.x = v.velocite.x - (clamp( 0.5, v.velocite.x, v.velocite.acceleration) * dt) 
			v.velocite.y = v.velocite.y + (clamp( 0.5, v.velocite.y, v.velocite.acceleration) * dt)
			
		elseif (v.velocite.acceleration == 3) then
			v.velocite.x = v.velocite.x + (clamp( 1.5, v.velocite.x, v.velocite.acceleration) * dt) 
			v.velocite.y = v.velocite.y - (clamp( 1.5, v.velocite.y, v.velocite.acceleration) * dt)
			
		elseif (v.velocite.acceleration == 4) then
			v.velocite.x = v.velocite.x - (clamp( 0.5, v.velocite.x, v.velocite.acceleration) * dt) 
			v.velocite.y = v.velocite.y - (clamp( 0.5, v.velocite.y, v.velocite.acceleration) * dt)
		end
				
		-- Calcule la Nouvelle Position
		v.transform.translate.x = v.transform.translate.x + (v.velocite.x  * dt) 
		v.transform.translate.y = v.transform.translate.y + (v.velocite.y  * dt) 
		
		-- Calcule les transitions Ecran Asteroid
		Transitions(v)

	end

end

function Asteroid:draw()

	for _,v in pairs(self.astres) do 
		LG.draw( 	self.img, 
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

	LG.print("Nb Asteroids : "..tostring(#self.astres), 9, 40)
	
end

return Asteroid