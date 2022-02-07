
GameObject = {}

Game = {

	win    = { w = LG.getWidth(), h = LG.getHeight(), fullscreen = false},
	levelFont = LG.newFont("font/font.ttf", 24),
	StatCurrent = "Intro",
	level = 0,
	lives = 3,
	score = {points = 0, timepoints = 10000, counter = 0 },
	debug = false
	
}

function Game:winReset()

	self.win.w = 800
	self.win.h = 600
	self.win.fullscreen = false
	
end

function Game:addLive(points)

	self.score.counter = self.score.counter + points
				
	if self.score.counter >=  self.score.timepoints then
		self.lives =  self.lives + 1
		self.score.counter = 0
	end
		
end

function Game:decLive()

	self.lives =  self.lives - 1
	
end

function Game:addScore(points)

	self.score.points  = self.score.points  + points
	
end

function Game:drawScore()

	LG.printf(tostring(self.score.points), self.levelFont, 8, 8, 210, "center")
	
end

function Game:drawLives()
	
	if Game.lives < 6 then
		for i = 1, Game.lives do
			LG.draw( plane.img, (i - 1) * 32 + 3, 40, 0, 2, 2)
		end
	else
		for i = 1, 5 do
			LG.draw( plane.img, (i - 1) * 32 + 3, 40, 0, 2, 2)
		end
		
		local resteLives = Game.lives - 5
		LG.printf("(+"..tostring(resteLives)..")", self.levelFont, 5 * 32 + 3, 40, 100, "center")
		
	end
	
end
