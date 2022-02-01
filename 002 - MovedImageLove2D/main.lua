
-- Evite le rendu flou du pixelArt.
love.graphics.setDefaultFilter ( "nearest" , "nearest", 1)

-- Charge des valeurs par défaut.
function love.load()
	plane = love.graphics.newImage("plane.png")
	plane_y = 300
end

function love.update(dt)
	plane_y = plane_y - 1
end

-- Dessine.
function love.draw()
	love.graphics.draw(plane, 400, plane_y, 0, 4, 4)
end
