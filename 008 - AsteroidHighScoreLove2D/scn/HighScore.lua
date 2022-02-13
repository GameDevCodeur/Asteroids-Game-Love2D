
local scnHighScore = {
	--	
	toggle = false,	
	tempo  = 0,
	chars  = {[1] = 65, [2] = 65, [3] = 65},
	indice = 1,
	mainFont = LG.newFont("font/font.ttf", 70),
	mainFontsmall = LG.newFont("font/font.ttf", 30),
}

function scnHighScore:load()
	--
	width, height = Game.video2:getDimensions( )
	--
	scx = Game.win.w / width
	scy = Game.win.h / height
	--
    Game.video2:play()
	--
end
--
function scnHighScore:update(dt)
	--
	self.tempo = self.tempo + dt
	--
	if self.tempo > 0.3 then
		--
		self.tempo = 0
		--
		if self.toggle then
			--
			self.toggle = false
	  
		else
			--
			self.toggle = true		
			
		end
		
	end
	
end
--
function scnHighScore:draw()
	-- Affiche la vidéo
    if Game.video2:isPlaying() then
		LG.draw(Game.video2, 0, -50, 0, scx, scy)
	end
	-- If the video is not playing or left button is clicked
	if not Game.video2:isPlaying() then
		-- Rewind to the start
		Game.video2:seek(0)
		-- And play
		Game.video2:play()
	end
	-- Affiche Score et HighScore
	Game:drawScore()
	--
	if Game.win.fullscreen then
		LG.printf("YOUR SCORE IS ONE OF THE TEN BEST", self.mainFont, 0 , Game.win.h / 2 - 300, Game.win.w, "left")
		LG.printf("PLEASE ENTER THE YOURS INITIALS", self.mainFont, 0, Game.win.h / 2 - 250, Game.win.w, "left")
		LG.printf("PUSH ROTATE TO SELECT LETTER", self.mainFont, 0, Game.win.h / 2 - 200, Game.win.w, "left")
		LG.printf("PUSH HYPERSPACE WHEN LETTER IS CORRECT", self.mainFont, 0, Game.win.h / 2 - 150, Game.win.w, "left")
	else
		LG.printf("YOUR SCORE IS ONE OF THE TEN BEST", self.mainFontsmall, 0 , Game.win.h / 2 - 200, Game.win.w, "left")
		LG.printf("PLEASE ENTER THE YOURS INITIALS", self.mainFontsmall, 0, Game.win.h / 2 - 180, Game.win.w, "left")
		LG.printf("PUSH ROTATE TO SELECT LETTER", self.mainFontsmall, 0, Game.win.h / 2 - 160, Game.win.w, "left")
		LG.printf("PUSH HYPERSPACE WHEN LETTER IS CORRECT", self.mainFontsmall, 0, Game.win.h / 2 - 140, Game.win.w, "left")
	end		
	--indice 1
	if self.indice == 1 then
		--
		if self.toggle then
			LG.printf(	string.char(self.chars[1]), 
						self.mainFont, 
						Game.win.w / 2 - 50, Game.win.h / 2, 
						Game.win.w, "left")
		end
    
		LG.printf(	string.char(self.chars[2]), 
					self.mainFont, 
					Game.win.w / 2 , Game.win.h / 2, 
					Game.win.w, "left")
					
		LG.printf(	string.char(self.chars[3]), 
					self.mainFont, 
					Game.win.w / 2 + 50, Game.win.h / 2, 
					Game.win.w, "left")
	
	elseif self.indice == 2 then
		--
		LG.printf(	string.char(self.chars[1]), 
					self.mainFont, 
					Game.win.w / 2 - 50, Game.win.h / 2, 
					Game.win.w, "left")
		--
		if self.toggle then
			LG.printf(	string.char(self.chars[2]), 
						self.mainFont, 
						Game.win.w / 2, Game.win.h / 2, 
						Game.win.w, "left")
		end
		--
		LG.printf(	string.char(self.chars[3]), 
					self.mainFont, 
					Game.win.w / 2 + 50, Game.win.h / 2, 
					Game.win.w, "left")
					
	elseif self.indice == 3 then
		--
		LG.printf(	string.char(self.chars[1]), 
					self.mainFont, 
					Game.win.w / 2 - 50, Game.win.h / 2, 
					Game.win.w, "left")
		--		
		LG.printf(	string.char(self.chars[2]), 
					self.mainFont, 
					Game.win.w / 2, Game.win.h / 2, 
					Game.win.w, "left")	
		--
		if self.toggle then
			--
			LG.printf(	string.char(self.chars[3]), 
						self.mainFont, 
						Game.win.w / 2 + 50, Game.win.h / 2, 
						Game.win.w, "left")
						
		end
    
	end	
	
end
--
function scnHighScore:reset()
	--
	self.indice = 1
	--
	self.chars[1] = 65  
	self.chars[2] = 65
	self.chars[3] = 65
		
end
--
function scnHighScore:resize(w, h)
	--
	Game.win.w = w
	Game.win.h = h
	
	if w > width then
		--
		scx = Game.win.w / width
		scy = Game.win.h / height
		
	end
	
end
--
function scnHighScore:keypressed(key, scancode, isrepeat)
	--
	if key == "space" then 
		--
		Game:addHighScore()
		--
		self:reset()
		--
		Game:reset()
		--
		Game:menu()
		
	end
	--
	if key == "escape" then
		--
		Game:winReset()
		--
		self:load()

	end
	--	
	if key == "right" then
		--
		self.chars[self.indice] = self.chars[self.indice] + 1
		--
		if self.chars[self.indice] > 90 then
			--
			self.chars[self.indice] = 65
			
		end
	
	elseif key == "left" then
		--
		self.chars[self.indice] = self.chars[self.indice] - 1
		if self.chars[self.indice] < 65 then
			--
			self.chars[self.indice] = 90
			
		end
		
	elseif key == "down" then
		--
		self.indice = self.indice + 1
		--
		if self.indice > 3 then
			--
			self.indice = 1
			
		end

	end
	
end

return scnHighScore