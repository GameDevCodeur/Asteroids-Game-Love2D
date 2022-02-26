local Ovni =	{
					velocite  = {},			
					transform = {},
				}


function Ovni:load()
	--
	self.velocite = {x = 90, y = 90, acceleration = 0}
	self.transform = newObjTransform(0, 0, 0, 0, 4.5, 0.5, 0.5)
	--
	self.h  = Game.assetManager:getImage("ovni"):getHeight()
	self.w  = Game.assetManager:getImage("ovni"):getWidth()
	--
	self.ox = self.w / 2
	self.oy = self.h / 2
	--
	self.collider 	= false
	self.visible  	= false
	--
	self.tempo      = 1
	--
	self.points 	= 1000
	--
	self.state      = "CheckCollider"

end

function Ovni:AI(dt)
	
	if self.tempo <= 7 and self.visible  then
		--
		self.state = "newDirection"
		self.tempo = 0
				
	end

	--
	if 	self.state == "CheckCollider" and 
		self.visible  then
		
		if self.tempo - Game.level <= 5 then return end
		
		-- CheckCollider avec asteroid
		for i, v in ipairs(Game.assetManager:getObject("asteroid").astres) do
			--
			if Collider(v, self, 50) then			
				-- 			
				self.state = "Hyperspace"
				
			end
			
		end
		
	end
	
	if self.state == "newDirection" and self.visible then
		-- Nouvelle Direction
		local _rn = math.random(3)
		if _rn == 1 then 
			self.velocite.x = - self.velocite.x 
		elseif _rn == 2 then 
			self.velocite.y = - self.velocite.y
		else
			self.velocite.x = - self.velocite.x 
			self.velocite.y = - self.velocite.y
		end
	
		self.state = "CheckCollider"
		
	end	
	
	if self.state == "Hyperspace" and self.visible then		
		--
		local _rn = math.random(2)
		
		if _rn == 1 and self.tempo >= 10 then			
			-- hyperspace		
			self.transform.translate.x = math.random(0 + 32, Game.win.w)
			self.transform.translate.y = math.random(0 + 32, Game.win.h)
			
			self.tempo = 9
		
		end
		
	end	

end

function Ovni:new()

	self.visible = true
	self.collider = false
	--
	local _rn = math.random(2)
	local sc  = math.random(2)

	--
	if _rn == 1 then 
		--
		self.transform.translate.y = math.random( Game.win.h )
		self.transform.translate.x = 0	
		
	else
		--
		self.transform.translate.x = 0	
		self.velocite.x = - self.velocite.x
			
	end	
			
	if sc == 1 then
		self.transform.scale.x = 1
		self.transform.scale.y = 1
		self.velocite.x = 90
		self.velocite.y = 90
		self.points = 200
				
	else
		self.transform.scale.x = 0.5
		self.transform.scale.y = 0.5
		self.velocite.x = 130
		self.velocite.y = 130
		self.points = 1000
			
	end
		
end
--
function Ovni:update(dt)

	--
	if self.tempo > 0 then
		--
		self.tempo = self.tempo - dt
		
	end
	
	if self.visible then		
	
		if self.collider == true then
			--
			self.visible  = false
	
		end
		
		-- Applique IA
		self:AI(dt)
		
		-- Calcule la nouvelle position
		self.transform.translate.x = self.transform.translate.x + (self.velocite.x * dt) 
		self.transform.translate.y = self.transform.translate.y + (self.velocite.y * dt)
							
		-- Applique Transitions
		WrapAround(self)
	
	end
	
	if self.tempo <= 0 then
		--
		self.tempo = math.random(10, 15)
		--			
		if	(#Game.assetManager:getObject("asteroid").astres < (5 + ((Game.level -1) * Game.lives)) ) and			
			self.visible == false then
			--
			self:new()
							
		end
		
	end
	
end

function Ovni:draw()
	--
	if self.visible then
		LG.draw( 	
				Game.assetManager:getImage("ovni"),
				self.transform.translate.x,
				self.transform.translate.y,
				self.transform.rotate.x,
				self.transform.scale.x, self.transform.scale.y,
				self.ox, self.oy -- Point à l'origine au centre de l'image
				)
	end
	
end

function Ovni:keypressed(key, scancode, isrepeat)	

end

function Ovni:debug()

	if (Game.debug) then 
		--
		LG.print("Visible Ovni: "..tostring(self.visible), 9, 80)
		
	end
	
end

return Ovni