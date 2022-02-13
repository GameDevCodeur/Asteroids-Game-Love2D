
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

	for oi = #asteroid.astres, 1, -1 do -- Asteroids
		--
		if 	Collider(asteroid.astres[oi], plane, 25 * asteroid.astres[oi].transform.scale.x) 
			and plane.collider == false then						
			-- Décrémente une vie
			Game:decLive()						
			-- Explosion
			explode:start(	plane.transform.translate.x - 80, 
							plane.transform.translate.y - 80, 
							plane.transform.scale.x + 4)
			--
			plane.collider = true			
			
		end
		
	end
	
end

function ColliderAstresBullets(dt)

	for oi = #asteroid.astres, 1, -1 do 	-- Asteroids
		for oj = #bullet.weapon.bullets, 1, -1 do	-- Bullets
		
			if asteroid.astres[oi] == nil or bullet.weapon.bullets[oj] == nil then return end
				
			if Collider(asteroid.astres[oi], bullet.weapon.bullets[oj], 25 * asteroid.astres[oi].transform.scale.x) then
				
				-- remove la bullet
				table.remove(bullet.weapon.bullets, oj)	
				
				-- Incrémente Score
				Game:addScore(asteroid.astres[oi].points)
				
				-- Incrémente une vie chaque 10000 points
				Game:addLive(asteroid.astres[oi].points)
											
				-- Explosion
				
				explode:start(	asteroid.astres[oi].transform.translate.x - 10 * asteroid.astres[oi].transform.scale.x, 
								asteroid.astres[oi].transform.translate.y - 10 * asteroid.astres[oi].transform.scale.y, 
								asteroid.astres[oi].transform.scale.x )
				
				-- Change le scale
				asteroid.astres[oi].transform.scale.x = asteroid.astres[oi].transform.scale.x - 1
				asteroid.astres[oi].transform.scale.y = asteroid.astres[oi].transform.scale.y - 1
				
				-- Change le quota points
				if asteroid.astres[oi].points == 20 then
					asteroid.astres[oi].points = 50
				elseif asteroid.astres[oi].points == 50 then
					asteroid.astres[oi].points = 100
				end
								
				if asteroid.astres[oi].transform.scale.x then
				
					local newAstre = asteroid:CreateAsteroid()
					
					newAstre.points = asteroid.astres[oi].points
					
					newAstre.transform.translate.x = asteroid.astres[oi].transform.translate.x + asteroid.astres[oi].transform.scale.x * 20
					newAstre.transform.translate.y = asteroid.astres[oi].transform.translate.y + asteroid.astres[oi].transform.scale.x * 20
									
					newAstre.transform.rotate.x     = asteroid.astres[oi].transform.rotate.x
					newAstre.transform.rotate.y     = asteroid.astres[oi].transform.rotate.y
					newAstre.transform.rotate.speed = asteroid.astres[oi].transform.rotate.speed
					
					newAstre.transform.scale.x = asteroid.astres[oi].transform.scale.x
					newAstre.transform.scale.y = asteroid.astres[oi].transform.scale.y
										
					newAstre.velocite.x = asteroid.astres[oi].velocite.x
					newAstre.velocite.y = asteroid.astres[oi].velocite.y + 5
					
					-- Ditrection
					newAstre.velocite.acceleration = math.random(1,4)
					
					-- Ajoute newAstre
					asteroid:new(newAstre)
					
				end				
							
			end
		end
	end
	
end
