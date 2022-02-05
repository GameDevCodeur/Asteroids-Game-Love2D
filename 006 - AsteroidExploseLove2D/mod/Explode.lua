
local Explode = {

	img = nil,
	run = false
	
}

function Explode:start(x, y, sc)
	
	currentFrame = 1	
	self.run 	 = true
	self.x 		 = x
	self.y 		 = y
	self.sc 	 = sc
	
end

function Explode:load()

  self.img    = love.graphics.newImage("gfx/explode.png")
  self.width  = self.img:getWidth()
  self.height = self.img:getHeight()

  frames = {}

  local frame_width  = 32
  local frame_height = 32

  for i = 0, 3 do
  
    table.insert(	frames, 
					love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, self.width, self.height))
					
  end

  currentFrame = 1
  
end

function Explode:update(dt)
  
	if currentFrame < 4 and self.run then
		currentFrame = currentFrame + 10 * dt
	else
		self.run = false
	end
  
end

function Explode:draw()

	if self.run then
		love.graphics.draw(self.img, frames[math.floor(currentFrame)], self.x, self.y, 0, self.sc, self.sc)
	end
	
end

function Explode:debug()
end

return Explode

