local SceneMenu = {
	--
	mainFont  = LG.newFont("font/font.ttf", 70)
	
}
--
function SceneMenu:load()
	--
	width, height = Game.video:getDimensions( )
	--
	scx = Game.win.w / width
	scy = Game.win.h / height
	--
    Game.video:play()
	--
	timertoggle = 0
	
end
--
function SceneMenu:update(dt)
	--
	timertoggle = timertoggle + dt

	if timertoggle > 0.3 then
		--		
		timertoggle = 0
		--
		if toggle then
			--
			toggle = false
		else
			--
			toggle = true
		end
	--
	end
	
end
--
function SceneMenu:draw()	
	-- Affiche la vidéo
    if Game.video:isPlaying() then
		--
		LG.draw(Game.video, 0, -50, 0, scx, scy)
		
	end
	-- If the video is not playing or left button is clicked
	if not Game.video:isPlaying() then
		-- Rewind to the start
		Game.video:seek(0)
		-- And play
		Game.video:play()
	end
	-- Affiche Score & HighScore
	Game:drawScore()
	-- Clignote
	if toggle then
		-- Affiche PUSH START
		LG.printf("PUSH START", self.mainFont, 0, 50, Game.win.w, "center")		
	end		
	-- Affiche table des HighScores
	HighScore:draw()
	-- Affiche Copyright		
	LG.printf("(c) 2021 GAMEDEVCODEUR INC", 
			   LG.newFont("font/font.ttf", Game.FontSize), 
			   0, 
			   Game.win.h - 50, 
			   Game.win.w, 
			   "center")
	
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