local SceneMenu = {}
--
function SceneMenu:load()
	--
	Game.assetManager:getMusic("music"):stop()
	--
	Game.assetManager:getVideo("intro"):getSource():stop()
	--
	width, height = Game.assetManager:getVideo("menu"):getDimensions( )
	--
	scx = Game.win.w / width
	scy = Game.win.h / height
	--
    Game.assetManager:getVideo("menu"):play()
	--
	timertoggle = 0
	
end
--
function SceneMenu:update(dt)
	--
	timertoggle = timertoggle + dt
	--
	if timertoggle > 0.3 then
		--		
		timertoggle = 0
		--
		toggle = not toggle
	--
	end
	
end
--
function SceneMenu:draw()	
	-- Affiche la vidéo
    if Game.assetManager:getVideo("menu"):isPlaying() then
		--
		LG.draw(Game.assetManager:getVideo("menu"), 0, -50, 0, scx, scy)
		
	end
	
	-- If the video is not playing or left button is clicked
	if not Game.assetManager:getVideo("menu"):isPlaying() then
		-- Rewind to the start
		Game.assetManager:getVideo("menu"):seek(0)
		-- And play
		Game.assetManager:getVideo("menu"):play()
		
	end
	
	-- Affiche Score & HighScore
	Game:drawScore()
	
	-- Clignote
	if toggle then
		-- Affiche PUSH START
		LG.printf(	"PUSH START", 
					Game.assetManager:getFont("font70"), 
					0, 50, 
					Game.win.w, "center")
					
	end
	
	-- Affiche table des HighScores
	HighScore:draw()
	-- Affiche Copyright		
	LG.printf(	"(c) 2021 GAMEDEVCODEUR INC", 
				Game.assetManager:getFont("font30"), 
				0, 
				Game.win.h - 50, 
				Game.win.w, "center")
	
end
--
function SceneMenu:resize(w, h)

	Game.win.w = w
	Game.win.h = h
	
	if w > width then
		scx = Game.win.w / width
		scy = Game.win.h / height
	end
	
end
--
function SceneMenu:keypressed(key, scancode, isrepeat)
	--
	if key == "space" then 
		--
		Game:reset()
		Game:play()
		
	end
	--
	if key == "escape" then
		--
		Game:winReset()
		self.load()
		
	end
	
end

return SceneMenu