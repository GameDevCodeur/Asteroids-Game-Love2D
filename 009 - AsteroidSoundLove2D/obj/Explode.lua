
local Explode = {
	--
	run 			= false,
	nbframes 		= 4,
	currentFrame 	= 1,
	sc 				= 1,
	tempo 			= 0,
	tempoMax 		= 0.3,
	frames 			= {}
	
}

function Explode:start(x, y, sc)
	--
	self.currentFrame = 1	
	self.run 	 	  = true
	self.x 		 	  = x
	self.y 		 	  = y
	self.sc 	 	  = sc
	
	Game.assetManager:getSound("explode"):stop()
	Game.assetManager:getSound("explode"):play()
	
end

function Explode:load()
	--
    self.width  = Game.assetManager:getImage("explode"):getWidth()
	self.height = Game.assetManager:getImage("explode"):getHeight()

	local frame_width  = 32
	local frame_height = 32

	for i = 0, self.nbframes - 1 do
	--
		table.insert(	self.frames, 
						love.graphics.newQuad(	i * frame_width, 
												0, 
												frame_width, frame_height, 
												self.width, self.height)
					)
					
	end

	self.currentFrame = 1
  
end

function Explode:update(dt)

	self.tempo = self.tempo + dt

	if self.tempo > self.tempoMax then
		--
		self.tempo = 0
		--
		if self.currentFrame < self.nbframes and self.run then
			--
			self.currentFrame = self.currentFrame + 1
			
		else
			--
			self.run = false
			
		end
		
	end
  
end

function Explode:draw()

	if self.run then
		love.graphics.draw(	Game.assetManager:getImage("explode"), 
							self.currentFrame, 
							self.x, self.y, 
							0, 
							self.sc, self.sc)
	end
	
end

function Explode:debug()
end

return Explode

