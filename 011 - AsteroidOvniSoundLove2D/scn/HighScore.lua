
local scnHighScore = {
	--	
	toggle = false,	
	tempo  = 0,
	chars  = {[1] = 65, [2] = 65, [3] = 65},
	indice = 1,

}

function scnHighScore:load()	
	--
	width, height = Game.assetManager:getVideo("highScore"):getDimensions( )
	--
	scx = Game.win.w / width
	scy = Game.win.h / height
	--
    Game.assetManager:getVideo("highScore"):play()
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
		self.toggle = not self.toggle 
		
	end
	
end
--
function scnHighScore:draw()
	-- Affiche la vidéo
    if Game.assetManager:getVideo("highScore"):isPlaying() then
		--
		LG.draw(Game.assetManager:getVideo("highScore"), 0, -50, 0, scx, scy)
	end
	
	-- If the video is not playing or left button is clicked
	if not Game.assetManager:getVideo("highScore"):isPlaying() then
		-- Rewind to the start
		Game.assetManager:getVideo("highScore"):seek(0)
		-- And play
		Game.assetManager:getVideo("highScore"):play()
	end
	
	-- Affiche Score et HighScore
	Game:drawScore()
	--
	local font = (( Game.win.fullscreen) and 
					Game.assetManager:getFont("font70") or 
					Game.assetManager:getFont("font30") )
	--				
	local h    = (( Game.win.fullscreen) and 250 or 200 )
	local offh = (( Game.win.fullscreen) and 50 or 20 )
	
	LG.printf(	"YOUR SCORE IS ONE OF THE TEN BEST", 
				font, 0, Game.win.h / 2 - (h), Game.win.w, "left")
				
	LG.printf(	"PLEASE ENTER THE YOURS INITIALS", 
				font, 0, Game.win.h / 2 - (h-offh), Game.win.w, "left")
					
	LG.printf(	"PUSH ROTATE TO SELECT LETTER", 
				font, 0, Game.win.h / 2 - (h-2*offh), Game.win.w, "left")
				
	LG.printf(	"PUSH HYPERSPACE WHEN LETTER IS CORRECT", 
				font, 0, Game.win.h / 2 - (h-3*offh), Game.win.w, "left")
	
	--indice 1
	if self.indice == 1 then
		--
		if self.toggle then
			LG.printf(	string.char(self.chars[1]), 
						Game.assetManager:getFont("font70"), 
						Game.win.w / 2 - 50, Game.win.h / 2, 
						Game.win.w, "left")
		end
    
		LG.printf(	string.char(self.chars[2]), 
					Game.assetManager:getFont("font70"), 
					Game.win.w / 2 , Game.win.h / 2, 
					Game.win.w, "left")
					
		LG.printf(	string.char(self.chars[3]), 
					Game.assetManager:getFont("font70"), 
					Game.win.w / 2 + 50, Game.win.h / 2, 
					Game.win.w, "left")
	
	elseif self.indice == 2 then
		--
		LG.printf(	string.char(self.chars[1]), 
					Game.assetManager:getFont("font70"), 
					Game.win.w / 2 - 50, Game.win.h / 2, 
					Game.win.w, "left")
		--
		if self.toggle then
			LG.printf(	string.char(self.chars[2]), 
						Game.assetManager:getFont("font70"), 
						Game.win.w / 2, Game.win.h / 2, 
						Game.win.w, "left")
		end
		--
		LG.printf(	string.char(self.chars[3]), 
					Game.assetManager:getFont("font70"), 
					Game.win.w / 2 + 50, Game.win.h / 2, 
					Game.win.w, "left")
					
	elseif self.indice == 3 then
		--
		LG.printf(	string.char(self.chars[1]), 
					Game.assetManager:getFont("font70"), 
					Game.win.w / 2 - 50, Game.win.h / 2, 
					Game.win.w, "left")
		--		
		LG.printf(	string.char(self.chars[2]), 
					Game.assetManager:getFont("font70"), 
					Game.win.w / 2, Game.win.h / 2, 
					Game.win.w, "left")	
		--
		if self.toggle then
			--
			LG.printf(	string.char(self.chars[3]), 
						Game.assetManager:getFont("font70"), 
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
function scnHighScore:addHighScore()
	--
	local lname = string.char(self.chars[1])..string.char(self.chars[2])..string.char(self.chars[3])
	HighScore:add({sc = Game.score.points, na = lname})
	HighScore:save()

end
--
function scnHighScore:keypressed(key, scancode, isrepeat)
	--
	if key == "space" then 
		--
		self:addHighScore()
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
		Game.assetManager:getSound("select"):play()
		--
		self.chars[self.indice] = self.chars[self.indice] + 1
		--
		if self.chars[self.indice] > 90 then
			--
			self.chars[self.indice] = 65
			
		end
	
	elseif key == "left" then
		--
		Game.assetManager:getSound("select"):play()
		--
		self.chars[self.indice] = self.chars[self.indice] - 1
		if self.chars[self.indice] < 65 then
			--
			self.chars[self.indice] = 90
			
		end
		
	elseif key == "down" then
		--
		Game.assetManager:getSound("select"):play()
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