
Game = {
	--
	win          = { w = 800, h = 600, fullscreen = false},
	assetManager = require("lib/assetManager"),
	StatCurrent  = "Intro", -- HighScore, Menu, Play
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
	Game.assetManager:getMusic("music"):setVolume(0.3)
	Game.assetManager:getMusic("music"):setLooping(true)
	--
	self:intro()
	
end

function Game:update(dt)
	--
	if 		self.StatCurrent == "Intro" 	then intro:update(dt)
	elseif 	self.StatCurrent == "Menu" 		then menu:update(dt)		
	elseif 	self.StatCurrent == "Play" 		then play:update(dt)			
	elseif 	self.StatCurrent == "HighScore" then highScore:update(dt) end
		
end

function Game:draw()
	--
	if     Game.StatCurrent == "Intro" 	   then intro:draw() 	
	elseif Game.StatCurrent == "Menu"  	   then menu:draw()  
	elseif Game.StatCurrent == "Play"  	   then play:draw()  
	elseif Game.StatCurrent == "HighScore" then highScore:draw() end
	
end
--
function Game:intro()
	--
	self.StatCurrent = "Intro"	
	intro:load()
	
end
--
function Game:menu()
	--	
	self.StatCurrent = "Menu"	
	menu:load()
	
end
--
function Game:play()
	--
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
	
	Game.assetManager:getObject("background"):SetScale(2, 2)
	
	self.win.fullscreen = false
	LW.setFullscreen( false )
	
end
--
function Game:addScore(points)
	--
	self.score.points  = self.score.points + points
	
	-- Incrémente une vie chaque 10000 points
	self:addLive(points)
	
end
--
function Game:decLive()
	-- Décrémente une vie	
	self.lives = self.lives - 1	
	-- 
	if tonumber(self.lives) <= 0 then			
		-- GameOver
		self:menu()
	
		-- addHighScore		
		table.foreach(HighScore.scores, 
			function (k,v)
				--
				if tonumber(self.score.points) > tonumber(v.sc) then
					--
					self.StatCurrent = "HighScore"
			
				end
				
			end
		)
		
	end
	
end
--
function Game:addLive(pts)
	--
	self.score.counter = self.score.counter + pts
	
	--		
	if tonumber(self.score.counter) >=  tonumber(self.score.timepoints) then
		--
		self.assetManager:getSound("newLive"):play()
		--
		self.lives = self.lives + 1
		self.score.counter = 0
		
	end
		
end
--
function Game:drawScore()
	--
	LG.printf((	tonumber(self.score.points) == 0 and "00" or 
				tostring(self.score.points)),
				self.assetManager:getFont("font30"),
				0, 8, 210, "center")
	--
	LG.printf((	tonumber(HighScore.highScore) == 0 and "00" or 
				tostring(HighScore.highScore)),
				self.assetManager:getFont("font24"),
				self.win.w / 2, 10, 400, "left")
	
end
--
function Game:drawLives()
	--
	for i = 1,( (tonumber(self.lives) < 6) and 
				 tonumber(self.lives) or 5 ) do
		--
		LG.draw( self.assetManager:getImage("plane"), 
				 (i - 1) * 32 + 5,
				 40, 0, 
				 0.5, 0.5 					
				)
			
	end
	--
	if tonumber(self.lives) > 5 then
		--
		LG.printf(  "(+"..tostring(self.lives - 5)..")", 
					self.assetManager:getFont("font24"), 
					5 * 32 + 5, 
					40, 100, "center"
				 )
					
	end	

end
--
function Game:nextLevel()
	-- newLevel
	if #self.assetManager:getObject("asteroid").astres == 0 then
		--
		self.level = self.level + 1 								-- Incrémente level		
		self.assetManager:getObject("bullet").weapon.bullets = {}	-- Reset Bullets		
		self.assetManager:getObject("asteroid"):newAsteroidLevel()	-- Création Astéroides
		
	end
	
end
