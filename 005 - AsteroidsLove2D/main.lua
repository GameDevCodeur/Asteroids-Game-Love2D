
require ("mod.Modules")

-- Charge les valeurs par défaut.
function love.load()
	
	background = LG.newImage("gfx/background.png")
	
	-- créé un astéroid
	asteroid:new(300, 200, 1, 4)
	
	-- Charger les éléments du jeux
	for _,v in pairs(GameObject) do v:load() end

end

-- La Logique du jeu
function love.update(dt)	
	
	-- Updater les éléments du jeux
	for _,v in pairs(GameObject) do v:update(dt) end
	
	-- Colision Bullets Asteroids
	for oi = #asteroid.astres, 1, -1 do 	-- Asteroids
		for oj = #bullet.weapon.bullets, 1, -1 do	-- Bullets
			if #asteroid.astres > 0 and #bullet.weapon.bullets > 0 then
				if Collider(asteroid.astres[oi], bullet.weapon.bullets[oj], 25 * asteroid.astres[oi].transform.scale.x ) then				
					table.remove(bullet.weapon.bullets, oj)				
					if(asteroid.astres[oi].transform.scale.x > 1) then
						asteroid:new(300, 200, 1, asteroid.astres[oi].transform.scale.x - 1)
					end
					table.remove(asteroid.astres, oi)
				end
			end
		end
	end
	
end

-- Affichage des élements du jeux
function love.draw()

	-- BackGround
	LG.draw(background,0,0,0,2,2)

	-- Draw les éléments du jeux
	for _,v in pairs(GameObject) do v:draw() end
		
	-- FPS
	LG.print("FPS: "..tostring(LT.getFPS()), 9, 10)
	
	-- Debug
	for _,v in pairs(GameObject) do v:debug() end
			
end
