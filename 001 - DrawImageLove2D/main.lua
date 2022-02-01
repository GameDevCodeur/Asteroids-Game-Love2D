
-- Evite le rendu flou du pixelArt.
love.graphics.setDefaultFilter ( "nearest" , "nearest", 1)

-- Charge des valeurs par défaut.
function love.load()
	plane = love.graphics.newImage("plane.png")
end

-- Dessine.
function love.draw()
	love.graphics.draw(plane, 400, 300, 0, 4, 4)
end
