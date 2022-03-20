
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
	
	if sc == 3 then
		--
		Game.assetManager:getSound("explodeLarge"):stop()
		Game.assetManager:getSound("explodeLarge"):play()
		
	elseif sc == 2 then
		--
		Game.assetManager:getSound("explodeMedium"):stop()
		Game.assetManager:getSound("explodeMedium"):play()
		
	else
		--
		Game.assetManager:getSound("explodeSmall"):stop()
		Game.assetManager:getSound("explodeSmall"):play()
		
	end
	
end

function Explode:load()
	--
	local frame_width  = 32
	local frame_height = 32

	for i = 0, self.nbframes - 1 do
	--
		table.insert(	self.frames, 
						LG.newQuad(	i * frame_width, 
									0, 
									frame_width, frame_height, 
									Game.assetManager:getImage("explode"):getDimensions())
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
	--
	LG.draw(Game.assetManager:getImage("explode"), 
			self.frames[self.currentFrame], 
			self.x, self.y, 0, self.sc, self.sc)
	
end

function Explode:debug()
end

return Explode

