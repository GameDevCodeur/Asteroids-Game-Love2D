
require ("mod.Modules")

-- Charge les valeurs
function love.load()
	--
	love.mouse.setVisible(false)
	--
	Game:load()
	--
	min_dt = 1/60
    next_time = LT.getTime()
	
end

-- Logique du jeu
function love.update(dt)
	--
	next_time = next_time + min_dt
	--
	Game:update(dt)
	
end

-- Affichage des élements du jeux
function love.draw()
	--
	Game:draw()
	--
	local cur_time = LT.getTime()
	if next_time <= cur_time then
      next_time = cur_time
      return
	end
	--
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
