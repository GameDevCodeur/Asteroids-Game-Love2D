
require ("mod.Modules")


-- Charge les valeurs
function love.load()

	if     Game.StatCurrent == "Intro" then	intro:load() 
	elseif Game.StatCurrent == "Menu"  then	menu:load()  
	elseif Game.StatCurrent == "Play"  then	play:load()	 end
	
end

-- Logique du jeu
function love.update(dt)

	if     Game.StatCurrent == "Intro" then	intro:update(dt) 
	elseif Game.StatCurrent == "Menu"  then	menu:update(dt)  
	elseif Game.StatCurrent == "Play"  then	play:update(dt)	 end
	
end

-- Affichage des élements du jeux
function love.draw()

	if     Game.StatCurrent == "Intro" then	intro:draw() 	
	elseif Game.StatCurrent == "Menu"  then	menu:draw()  
	elseif Game.StatCurrent == "Play"  then play:draw()  end
				
end

function love.resize(w, h)

	if     Game.StatCurrent == "Intro" then  intro:resize(w, h) 
	elseif Game.StatCurrent == "Menu"  then  menu:resize(w, h)  
	elseif Game.StatCurrent == "Play"  then  play:resize(w, h)  end
	
end

function love.keypressed(key, scancode, isrepeat)

	if     Game.StatCurrent == "Intro" then  intro:keypressed(key, scancode, isrepeat) 
	elseif Game.StatCurrent == "Menu"  then  menu:keypressed(key, scancode, isrepeat)  
	elseif Game.StatCurrent == "Play"  then  play:keypressed(key, scancode, isrepeat)  end
	
	if key == "f" then
	
		Game.win.fullscreen = love.window.setFullscreen( true )
		
	end
	
	if key == "d" then
	
		Game.debug = not Game.debug
		
	end
	
	if key == "q" then
	
      love.event.quit()
	  
	end
	
end
