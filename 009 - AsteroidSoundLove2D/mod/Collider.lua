
function Collider(obj1, obj2, minDistance)

	-- CALCUL de la distance avec le Théorème de Pythagore entre deux objects
	-- D = SquareRoot(Square(X2 - X1) + Square(Y2 - Y1))
	local distance = math.sqrt((obj1.transform.translate.x - obj2.transform.translate.x)^2 + 
							   (obj1.transform.translate.y - obj2.transform.translate.y)^2)
	
	return distance <= minDistance
	
end

function ColliderAstresBulletsPlane(dt)
	
	ColliderAstresBullets(dt)	-- Collision Bullets - Asteroids		
	ColliderAstresPlane(dt)		-- Collision Plane - Asteroids
	
end

function ColliderAstresPlane(dt)

	for oi = #Game.assetManager:getObject("asteroid").astres, 1, -1 do -- Asteroids
		--
		if 	Collider(	Game.assetManager:getObject("asteroid").astres[oi], 
						Game.assetManager:getObject("plane"), 
						25 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x) and 
						Game.assetManager:getObject("plane").collider == false then	

			-- Décrémente une vie
			Game:decLive()
				
			-- Explosion
			Game.assetManager:getObject("explode"):start(	
							Game.assetManager:getObject("plane").transform.translate.x - 80, 
							Game.assetManager:getObject("plane").transform.translate.y - 80, 
							Game.assetManager:getObject("plane").transform.scale.x + 4)
			--
			Game.assetManager:getObject("plane").collider = true			
			
		end
		
	end
	
end

function ColliderAstresBullets(dt)

	for oi = #Game.assetManager:getObject("asteroid").astres, 1, -1 do 	-- Asteroids
		for oj = #Game.assetManager:getObject("bullet").weapon.bullets, 1, -1 do	-- Bullets
		
			if Game.assetManager:getObject("asteroid").astres[oi] == nil or 
			   Game.assetManager:getObject("bullet").weapon.bullets[oj] == nil then return end
				
			if Collider(Game.assetManager:getObject("asteroid").astres[oi], 
						Game.assetManager:getObject("bullet").weapon.bullets[oj], 
						25 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x) then				
				
				-- remove la bullet
				table.remove(Game.assetManager:getObject("bullet").weapon.bullets, oj)
				
				-- Incrémente Score
				Game:addScore(Game.assetManager:getObject("asteroid").astres[oi].points)				
									
				-- Explosion				
				Game.assetManager:getObject("explode"):start(
								Game.assetManager:getObject("asteroid").astres[oi].transform.translate.x - 10 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x, 
								Game.assetManager:getObject("asteroid").astres[oi].transform.translate.y - 10 * Game.assetManager:getObject("asteroid").astres[oi].transform.scale.y, 
								Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x )
								
				-- Change le scale
				Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x = Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x - 1
				Game.assetManager:getObject("asteroid").astres[oi].transform.scale.y = Game.assetManager:getObject("asteroid").astres[oi].transform.scale.y - 1
				
				-- Change le quota points
				if Game.assetManager:getObject("asteroid").astres[oi].points == 20 then
					Game.assetManager:getObject("asteroid").astres[oi].points = 50
				elseif Game.assetManager:getObject("asteroid").astres[oi].points == 50 then
					Game.assetManager:getObject("asteroid").astres[oi].points = 100
				end
								
				if Game.assetManager:getObject("asteroid").astres[oi].transform.scale.x then
				
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
