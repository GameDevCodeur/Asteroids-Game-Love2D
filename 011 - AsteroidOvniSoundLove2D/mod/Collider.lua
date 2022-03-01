
function ColliderAstresBulletsPlane(dt)
	
	ColliderAstresBullets(dt)	-- Collision Bullets - Asteroids		
	ColliderAstresPlane(dt)		-- Collision Plane   - Asteroids
	ColliderAstresOvni(dt)		-- Collision Ovni    - Asteroids
	ColliderBulletsOvni(dt)		-- Collision Ovni    - Bullets
	ColliderPlaneOvni(dt)		-- Collision Ovni    - Plane
	
end

function ColliderPlaneOvni(dt)

	-- Soucoupe pas visible ne rien faire
	if Game.assetManager:getObject("ovni").visible   == false then return end
	
	-- Plane en collision ne rien faire
	if Game.assetManager:getObject("plane").collider == true then return end
		
	-- Détection Collision 
		local minDist = 25 * Game.assetManager:getObject("ovni").transform.scale.x
		if math.dist(Game.assetManager:getObject("plane").transform.translate.x,
					 Game.assetManager:getObject("plane").transform.translate.y,
					 Game.assetManager:getObject("ovni").transform.translate.x,
					 Game.assetManager:getObject("ovni").transform.translate.y) < minDist then
					 
		-- Décrémente une vie
		Game:decLive()
			
		-- Explosion
		Game.assetManager:getObject("explode"):start(	
							Game.assetManager:getObject("plane").transform.translate.x - 80, 
							Game.assetManager:getObject("plane").transform.translate.y - 80, 
							Game.assetManager:getObject("plane").transform.scale.x + 4)
		
		-- Drapeau collider à true
		Game.assetManager:getObject("plane").collider = true	
			
	end
	
end

function ColliderBulletsOvni(dt)

	-- Soucoupe non visible ne rien faire
	if Game.assetManager:getObject("ovni").visible == false then return end
	
	-- Pour chaque bullet
	for oj = #Game.assetManager:getObject("bullet").weapon.bullets, 1, -1 do	-- Bullets
		
		-- Détection Collision 
		local minDist = 25 * Game.assetManager:getObject("ovni").transform.scale.x
		if math.dist(Game.assetManager:getObject("bullet").weapon.bullets[oj].transform.translate.x,
					 Game.assetManager:getObject("bullet").weapon.bullets[oj].transform.translate.y,
					 Game.assetManager:getObject("ovni").transform.translate.x,
					 Game.assetManager:getObject("ovni").transform.translate.y) < minDist then	
					 
			-- Incrémente Score
			Game:addScore(Game.assetManager:getObject("ovni").points)
			
			-- Jouer explosion
			Game.assetManager:getSound("explodeLarge"):play()
			
			-- Drapeau collider à true
			Game.assetManager:getObject("ovni").collider = true			
			
			-- Enleve bullet de la table
			table.remove(Game.assetManager:getObject("bullet").weapon.bullets, oj)		
					
		end
		
	end
	
end

function ColliderAstresOvni(dt)

	-- Soucoupe en collision ne rien faire
	if Game.assetManager:getObject("ovni").collider == true then return end

	for oi = #Game.assetManager:getObject("asteroid").astres, 1, -1 do -- Asteroids
							
		-- Détection Collision 
		local minDist = 25 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x
		if math.dist(Game.assetManager:getObject("asteroid").astres[oi].transform.translate.x,
					 Game.assetManager:getObject("asteroid").astres[oi].transform.translate.y,
					 Game.assetManager:getObject("ovni").transform.translate.x,
					 Game.assetManager:getObject("ovni").transform.translate.y) < minDist then				
			
			--	Drapeau collider à true	
			Game.assetManager:getObject("ovni").collider = true
							
			-- Explosion
			Game.assetManager:getObject("explode"):start(Game.assetManager:getObject("ovni").transform.translate.x - 80,
														 Game.assetManager:getObject("ovni").transform.translate.y - 80, 
														 2)
			
		end
		
	end
	
end

function ColliderAstresPlane(dt)

	-- Plane en collision ne rien faire
	if Game.assetManager:getObject("plane").collider == true then return end

	for oi = #Game.assetManager:getObject("asteroid").astres, 1, -1 do -- Asteroids
				
		-- Détection Collision 
		local minDist = 25 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x
		if math.dist(Game.assetManager:getObject("asteroid").astres[oi].transform.translate.x,
					 Game.assetManager:getObject("asteroid").astres[oi].transform.translate.y,
					 Game.assetManager:getObject("plane").transform.translate.x,
					 Game.assetManager:getObject("plane").transform.translate.y) < minDist then

			-- Décrémente une vie
			Game:decLive()
				
			-- Explosion
			Game.assetManager:getObject("explode"):start(	
							Game.assetManager:getObject("plane").transform.translate.x - 80, 
							Game.assetManager:getObject("plane").transform.translate.y - 80, 
							Game.assetManager:getObject("plane").transform.scale.x + 4)
			
			-- Drapeau collider à true
			Game.assetManager:getObject("plane").collider = true			
			
		end
		
	end
	
end

function ColliderAstresBullets(dt)

	for oi = #Game.assetManager:getObject("asteroid").astres, 1, -1 do 	-- Asteroids
		for oj = #Game.assetManager:getObject("bullet").weapon.bullets, 1, -1 do	-- Bullets
		
			if Game.assetManager:getObject("asteroid").astres[oi] == nil or 
			   Game.assetManager:getObject("bullet").weapon.bullets[oj] == nil then return end

				-- Détection Collision 
				local minDist = 25 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x
				if math.dist(Game.assetManager:getObject("bullet").weapon.bullets[oj].transform.translate.x,
							 Game.assetManager:getObject("bullet").weapon.bullets[oj].transform.translate.y,
							 Game.assetManager:getObject("asteroid").astres[oi].transform.translate.x,
							 Game.assetManager:getObject("asteroid").astres[oi].transform.translate.y) < minDist then
										
				-- remove la bullet
				table.remove(Game.assetManager:getObject("bullet").weapon.bullets, oj)
				
				-- Incrémente Score
				Game:addScore(Game.assetManager:getObject("asteroid").astres[oi].points)				
									
				-- Explosion				
				Game.assetManager:getObject("explode"):start(
								--
								Game.assetManager:getObject("asteroid").astres[oi].transform.translate.x - 10 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x, 
								Game.assetManager:getObject("asteroid").astres[oi].transform.translate.y - 10 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.y, 
								Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x )
								
				-- Change le scale
				Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x = Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x - 1
				Game.assetManager:getObject("asteroid").astres[oi].transform.scale.y = Game.assetManager:getObject("asteroid").astres[oi].transform.scale.y - 1
				
				-- Change le quota points
				if Game.assetManager:getObject("asteroid").astres[oi].points == 20 then
					--
					Game.assetManager:getObject("asteroid").astres[oi].points = 50
					
				elseif Game.assetManager:getObject("asteroid").astres[oi].points == 50 then
					--
					Game.assetManager:getObject("asteroid").astres[oi].points = 100
					
				end
								
				if Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x then
					--
					local newAstre = Game.assetManager:getObject("asteroid"):CreateAsteroid()
					
					newAstre.points = Game.assetManager:getObject("asteroid").astres[oi].points
					
					newAstre.transform.translate.x = Game.assetManager:getObject("asteroid").astres[oi].transform.translate.x + Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x * 20
					newAstre.transform.translate.y = Game.assetManager:getObject("asteroid").astres[oi].transform.translate.y + Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x * 20
									
					newAstre.transform.rotate.x     = Game.assetManager:getObject("asteroid").astres[oi].transform.rotate.x
					newAstre.transform.rotate.y     = Game.assetManager:getObject("asteroid").astres[oi].transform.rotate.y
					newAstre.transform.rotate.speed = Game.assetManager:getObject("asteroid").astres[oi].transform.rotate.speed
					
					newAstre.transform.scale.x = Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x
					newAstre.transform.scale.y = Game.assetManager:getObject("asteroid").astres[oi].transform.scale.y
										
					newAstre.velocite.x = Game.assetManager:getObject("asteroid").astres[oi].velocite.x
					newAstre.velocite.y = Game.assetManager:getObject("asteroid").astres[oi].velocite.y + 5
					
					-- Ditrection
					newAstre.velocite.acceleration = math.random(1,4)
					
					-- Ajoute newAstre
					Game.assetManager:getObject("asteroid"):new(newAstre)
					
				end				
							
			end
		end
	end
	
end
