
-- Charge les valeurs par défaut.
function love.load()
	debug = true
	
	-- Evite le rendu flou du pixelArt.
	love.graphics.setDefaultFilter ( "nearest" , "nearest", 1)
	
	-- The Transform component determines the Position, Rotation, and Scale of each object in the scene. 
	-- Every GameObject has a Transform.
	function newObjTransform(tx, ty, rx, ry, rspeed, sx, sy) 
		return {
			translate = {x = tx or 0, y = ty or 0},    						-- position
			rotate    = {x = rx or 0, y = ry or 0, speed = rspeed or 0},	-- rotation
			scale     = {x = sx or 1, y = sy or 1}							-- échelle
		}
	end
	
	-- Plane GameObject
	plane = {
		img       = love.graphics.newImage("plane.png"),
		velocite  = {x = 0, y = 0, acceleration = 250},			
		transform = newObjTransform(400, 300, 0, 0, 4.5, 4, 4)				-- Component Transform
	}
	
end

-- Logique
function love.update(dt)

	if love.keyboard.isDown("left")  then rotateLeft(plane, dt) end
	if love.keyboard.isDown("right") then rotateRight(plane, dt) end	
	if love.keyboard.isDown("up") 	 then moveUp(plane, dt)	end
	
	-- Move plane
	plane.transform.translate.x = plane.transform.translate.x + (plane.velocite.x * dt)
	plane.transform.translate.y = plane.transform.translate.y + (plane.velocite.y * dt)	
	
end

-- Dessine.
function love.draw()

	love.graphics.draw(plane.img, 
						plane.transform.translate.x,
						plane.transform.translate.y,
						plane.transform.rotate.x,
						plane.transform.scale.x, plane.transform.scale.y,
						plane.img:getWidth()/2,  plane.img:getHeight()/2 -- Point à l'origine au centre de l'image
					   )
						
	if debug then
		fps = tostring(love.timer.getFPS())
		love.graphics.print("FPS: "..fps, 9, 10)
		love.graphics.print("Plane velocite X: "..plane.velocite.x, 9, 20)
		love.graphics.print("Plane velocite Y: "..plane.velocite.y, 9, 30)
	end

end

-- fonctios
function rotateLeft(obj, dt)
	obj.transform.rotate.x = obj.transform.rotate.x - (obj.transform.rotate.speed * dt)
end

function rotateRight(obj, dt)
	obj.transform.rotate.x = obj.transform.rotate.x + (obj.transform.rotate.speed * dt)
end

function moveUp(obj, dt)
	obj.velocite.x = obj.velocite.x + math.sin(obj.transform.rotate.x) * (obj.velocite.acceleration * dt)
	obj.velocite.y = obj.velocite.y + math.cos(obj.transform.rotate.x) * (-obj.velocite.acceleration * dt)	
end
