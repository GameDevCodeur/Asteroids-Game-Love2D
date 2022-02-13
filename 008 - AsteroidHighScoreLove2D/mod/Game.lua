
GameObject = {}

Game = {
	--
	win          = { w = 800, h = 600, fullscreen = false},
	Font    	 = LG.newFont("font/font.ttf", 24),
	FontSize 	 = 30,
	introvideo   = LG.newVideo("video/intro.ogv", {true}),
	video	 	 = LG.newVideo("video/gameover.ogv", {true}),
	video2		 = LG.newVideo("video/menu.ogv", {true}),	
	StatCurrent  = "Intro", -- GameOver, HighScore, Intro
	level        = 0,
	lives        = 3,
	score        = { points = 0, timepoints = 10000, counter = 0 },
	debug        = false
	
}
--
function Game:load()
	--
	math.randomseed(os.time())
	--
	LG.setDefaultFilter("linear", "linear", 8)
	--
	LW.setFullscreen( self.win.fullscreen )
	--
	HighScore:load()
	--
	if self.StatCurrent == "Intro" then
		--
		self:intro()
		
	end
	
end
--
function Game:intro()
	--
	self:stopvideo()
	self.StatCurrent = "Intro"	
	intro:load()
	
end
--
function Game:menu()
	--
	self:stopvideo()	
	self.StatCurrent = "Menu"	
	menu:load()
	
end
--
function Game:play()
	--
	self:stopvideo()		
	self.StatCurrent = "Play" 
	play:load()
	
end
--
function Game:reset()
	--
	self.level  = 0
	self.lives  = 3	
	self.score.points = 0
		
end
--
function Game:winReset()
	--
	self.win.w = 800
	self.win.h = 600 
	
	background:SetScale(2, 2)
	
	self.win.fullscreen = false
	LW.setFullscreen( false )
	
end
--
function Game:stopvideo()
	--
	self.introvideo:getSource():stop()
	self.video2:getSource():stop()
	self.video:getSource():stop()
	
end
--
function Game:highScore()
	--
	self:stopvideo()	
	self.StatCurrent = "HighScore"	
	-- highScore:load()
	
end
--
function Game:addHighScore()
	--
	local lname = string.char(highScore.chars[1])..string.char(highScore.chars[2])..string.char(highScore.chars[3])
	HighScore:add({sc = self.score.points, na = lname})
	HighScore:save()
	
	self:reset()
	
end
--
function Game:addLive(points)
	--
	self.score.counter = self.score.counter + points
	--		
	if tonumber(self.score.counter) >=  tonumber(self.score.timepoints) then
		--
		self.lives =  self.lives + 1
		self.score.counter = 0
		
	end
		
end
--
function Game:decLive()
	--
	self.lives = self.lives - 1
	-- 
	if tonumber(self.lives) <= 0 then
			
		-- GameOver
			self:menu()
	
		-- HighScore
		if tonumber(self.score.points) > tonumber(HighScore.highScore) then
			--
			self:highScore()
			
		else
			-- Score top 10
			table.foreach(HighScore.scores, 
				function (k,v)
					--
					if tonumber(self.score.points) > tonumber(v.sc) then
						--
						self:highScore()
				
					end
				end
			)		
			
		end
		
	end
	
end
--
function Game:addScore(points)
	--
	self.score.points  = self.score.points + points
	
end
--
function Game:drawScore()
	--
	if tonumber(self.score.points) == 0 then
		--
		LG.printf("00", LG.newFont("font/font.ttf", self.FontSize), 8, 8, 210, "center")
		
	else
		--
		LG.printf(tostring(self.score.points), LG.newFont("font/font.ttf", self.FontSize), 0, 8, 210, "center")
		
	end
	--
	if tonumber(HighScore.highScore) == 0 then
		--
		LG.printf(	"00", 
					LG.newFont("font/font.ttf", self.FontSize - 5), 
					self.win.w / 2, 10, 400, "left")
		
	else
		--
		LG.printf(
					tostring(HighScore.highScore), 
					LG.newFont("font/font.ttf", self.FontSize - 5), 
					self.win.w / 2, 10, 400, "left")
		
	end
	
end
--
function Game:drawLives()
	--
	if tonumber(self.lives) < 6 then
		--
		for i = 1, self.lives do
			--
			LG.draw( plane.img, (i - 1) * 32 + 5, 40, 0, 0.5, 0.5 )
			
		end
	--
	else
		--
		for i = 1, 5 do
			--
			LG.draw( plane.img, (i - 1) * 32 + 5, 40, 0, 0.5, 0.5)
		end
		--
		local resteLives = self.lives - 5
		LG.printf("(+"..tostring(resteLives)..")", self.Font, 5 * 32 + 5, 40, 100, "center")
		
	end
	
end
