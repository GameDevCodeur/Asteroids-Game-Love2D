
function Collider(obj1, obj2, minDistance)

	-- CALCUL de la distance avec le Théorème de Pythagore entre deux objects
	-- D = SquareRoot(Square(X2 - X1) + Square(Y2 - Y1))
	local distance = math.sqrt((obj1.transform.translate.x - obj2.transform.translate.x)^2 + 
	                     (obj1.transform.translate.y - obj2.transform.translate.y)^2)
	
	return distance <= minDistance
	
end

function ColliderAstresBulletsPlane()
	
	ColliderAstresBullets()	-- Collision Bullets - Asteroids		
	ColliderAstresPlane()	-- Collision Plane - Asteroids
	
end

function ColliderAstresPlane()

	for oi = #asteroid.astres, 1, -1 do -- Asteroids
		if Collider(asteroid.astres[oi], plane, 25 * asteroid.astres[oi].transform.scale.x) then
			
			if(asteroid.astres[oi].transform.scale.x > 1) then
					
				asteroid:new( asteroid.astres[oi].transform.translate.x + math.random(-60,60), 
				   		      asteroid.astres[oi].transform.translate.y - math.random(-60,60),  							
							  1, 
							  asteroid.astres[oi].transform.scale.x - 1)
				
				asteroid:new( asteroid.astres[oi].transform.translate.x + math.random(-60,60), 
				   		      asteroid.astres[oi].transform.translate.y - math.random(-60,60), 						
							  1, 
							  asteroid.astres[oi].transform.scale.x - 1)
								 
				explode:start(	asteroid.astres[oi].transform.translate.x, 
								asteroid.astres[oi].transform.translate.y, 
								asteroid.astres[oi].transform.scale.x - 1 )
			end
										
			table.remove(asteroid.astres, oi)
			
		end
	end
	
end

function ColliderAstresBullets()

	for oi = #asteroid.astres, 1, -1 do 	-- Asteroids
		for oj = #bullet.weapon.bullets, 1, -1 do	-- Bullets
			if asteroid.astres[oi] == nil or bullet.weapon.bullets[oj] == nil then return end
				
				if Collider(asteroid.astres[oi], bullet.weapon.bullets[oj], 25 * asteroid.astres[oi].transform.scale.x) then				
				table.remove(bullet.weapon.bullets, oj)
														
				if(asteroid.astres[oi].transform.scale.x > 1) then
					
					asteroid:new( asteroid.astres[oi].transform.translate.x + math.random(-60,60),
					   		      asteroid.astres[oi].transform.translate.y - math.random(-60,60), 							
								  1, 
								  asteroid.astres[oi].transform.scale.x - 1)
								  
					asteroid.astres[#asteroid.astres].velocite.x = clamp(10, asteroid.astres[#asteroid.astres].velocite.x * level, 100)
					asteroid.astres[#asteroid.astres].velocite.y = clamp(10, asteroid.astres[#asteroid.astres].velocite.y * level, 100)
					
					asteroid:new( asteroid.astres[oi].transform.translate.x + math.random(-60,60),
					   		      asteroid.astres[oi].transform.translate.y - math.random(-60,60), 							
								  1, 
								  asteroid.astres[oi].transform.scale.x - 1)
								  
					asteroid.astres[#asteroid.astres].velocite.x = clamp(10, asteroid.astres[#asteroid.astres].velocite.x * level, 100)
					asteroid.astres[#asteroid.astres].velocite.y = clamp(10, asteroid.astres[#asteroid.astres].velocite.y * level, 100)
									 
					explode:start(	asteroid.astres[oi].transform.translate.x, 
									asteroid.astres[oi].transform.translate.y, 
									asteroid.astres[oi].transform.scale.x - 1 )
				end
				
				table.remove(asteroid.astres, oi)				
			end
		end
	end
	
end
