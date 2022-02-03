
require ("mod.Modules")

-- Charge les valeurs par défaut.
function love.load()	
	plane:load() -- Charge GameObject Plane
	
	bullet = {
		img       = LG.newImage("gfx/bullet.png"),
		velocite  = {x = 0, y = 0, acceleration = 100},			
		transform = newObjTransform(0, 0, 0, 0, 0, 2, 2),	-- Component Transform	
	}
	
	-- Point à l'origine au centre de l'image
	bullet.ox = bullet.img:getWidth()  / 2 -- origine centrer en x
	bullet.oy = bullet.img:getHeight() / 2 -- origine centrer en y
	
	plane.canShoot = true

end

function plane:shooter(obj, dt)

	if LK.isDown("space") and self.canShoot then
		obj.transform.rotate.x = self.transform.rotate.x
		self.canShoot = false
		
	elseif self.canShoot then
		obj.transform.translate.x = self.transform.translate.x
		obj.transform.translate.y = self.transform.translate.y
		
	else	
		velociteUp(obj, dt)
		
	end	
		
	-- Calcule Nouvelle Position
	obj.transform.translate.x = obj.transform.translate.x + (obj.velocite.x * dt)
	obj.transform.translate.y = obj.transform.translate.y + (obj.velocite.y * dt)
	
end

-- Mise à jour de la Logique
function love.update(dt)

	-- Plane
	plane:update(dt)
	plane:shooter(bullet, dt)
	
end

-- Affichage
function love.draw()

	-- Plane
	plane:draw()
	
	-- Bullet
	LG.draw(	bullet.img, 
				bullet.transform.translate.x,
				bullet.transform.translate.y,
				bullet.transform.rotate.x,
				bullet.transform.scale.x, bullet.transform.scale.y,
				bullet.ox, bullet.oy  -- Point à l'origine au centre de l'image
			)	
	
	-- FPS
	LG.print("FPS: "..tostring(LT.getFPS()), 9, 10)
	
	-- Debug
	debug:draw(plane)
end
