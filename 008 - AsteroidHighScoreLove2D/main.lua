
require ("mod.Modules")

-- Charge les valeurs
function love.load()
	--
	Game:load()
	--
	min_dt = 1/60
    next_time = love.timer.getTime()
	
end

-- Logique du jeu
function love.update(dt)
	--
	next_time = next_time + min_dt
	--
	if     Game.StatCurrent == "Intro" 	   then intro:update(dt) 
	elseif Game.StatCurrent == "Menu"  	   then menu:update(dt)  
	elseif Game.StatCurrent == "Play"  	   then play:update(dt)
	elseif Game.StatCurrent == "HighScore" then highScore:update(dt) end
	
end

-- Affichage des élements du jeux
function love.draw()
	--
	if     Game.StatCurrent == "Intro" 	   then intro:draw() 	
	elseif Game.StatCurrent == "Menu"  	   then menu:draw()  
	elseif Game.StatCurrent == "Play"  	   then play:draw()  
	elseif Game.StatCurrent == "HighScore" then highScore:draw() end
	--
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
      next_time = cur_time
      return
	end
	love.timer.sleep(next_time - cur_time)
	
end

function love.resize(w, h)
	--
	if     Game.StatCurrent == "Intro" 		then  intro:resize(w, h) 
	elseif Game.StatCurrent == "Menu"  		then  menu:resize(w, h)
	elseif Game.StatCurrent == "HighScore" 	then  highScore:resize(w, h)
	elseif Game.StatCurrent == "Play"  		then  play:resize(w, h)  end
	
end

function love.keypressed(key, scancode, isrepeat)
	--
	if     Game.StatCurrent == "Intro"     then intro:keypressed	 (key, scancode, isrepeat) 
	elseif Game.StatCurrent == "Menu"      then menu:keypressed 	 (key, scancode, isrepeat) 
	elseif Game.StatCurrent == "Play"      then play:keypressed 	 (key, scancode, isrepeat)	
	elseif Game.StatCurrent == "HighScore" then highScore:keypressed (key, scancode, isrepeat) end
	--
	if key == "f" then
		--
		Game.win.fullscreen = LW.setFullscreen( true )
		
	end
	--
	if key == "d" then
		--
		Game.debug = not Game.debug
		
	end
	--
	if key == "q" then
		--
		love.event.quit()
	  
	end
	
end
