
require ("mod.Modules")

-- Charge les valeurs par défaut.
function love.load()
	
	level = 0
	debug = false
	
	math.randomseed(os.time())
					  
	-- Charger les éléments du jeux
	for _,v in pairs(GameObject) do v:load() end

end

-- La Logique du jeu
function love.update(dt)	
	
	-- Updater les éléments du jeux
	for _,v in pairs(GameObject) do v:update(dt) end
	
	-- Collisions 
	ColliderAstresBulletsPlane()
	
	--  Next Level
	if #asteroid.astres == 0 then
		level = level + 1
		for i = 1, clamp(1, level, 15) do 
			asteroid:new( love.math.random(-Game.win.w, Game.win.w), love.math.random(-Game.win.h, Game.win.h), 1, 4)
		end		
	end

end

-- Affichage des élements du jeux
function love.draw()	

	-- Draw éléments du jeux
	for _,v in pairs(GameObject) do v:draw() end
		
	-- FPS
	LG.print("FPS: "..tostring(LT.getFPS()), 9, 10)
	
	-- Debug
	if (debug) then 
		for _,v in pairs(GameObject) do v:debug() end
	end
			
end

function love.resize(w, h)

	Game.win.w = w
	Game.win.h = h
	
	if w > background.w then
		background.transform.scale.x =  w / background.w 
		background.transform.scale.y =  h / background.h		
	else
		background.transform.scale.x =  background.w / w
		background.transform.scale.y =  background.h / h
	end
	
	plane.transform.translate.x = w / 2
	plane.transform.translate.y = h / 2
	
end

function love.keypressed(key, scancode, isrepeat)

	if key == "f" then
	
		love.window.setFullscreen( true )
		
	end
	
	if key == "d" then
	
		debug = not debug
		
	end
	
	if key == "escape" then
	
		Game.win.w, Game.win.h = 800, 600
		love.window.setFullscreen( false )
		background.transform.scale.x =  2
		background.transform.scale.y =  2
		plane.transform.translate.x = Game.win.w / 2
		plane.transform.translate.y = Game.win.h / 2
		
	end
	
	if key == "q" then
	
      love.event.quit()
	  
	end
	
end
