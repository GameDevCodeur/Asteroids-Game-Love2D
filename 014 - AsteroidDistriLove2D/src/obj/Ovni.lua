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
	--
	self.visible  	= false
	--
	self.tempo      = 1
	--
	self.points 	= 1000
	--
	self.state      = "CheckCollider"
	
	-- Shoot
	self.reloadTime = 1.5
	self.ready 		= 0

end

function Ovni:AI(dt)
	--
	if self.tempo <= 7 and self.visible  then
		--
		self.state = "newDirection"
		self.tempo = 0
				
	end
	--
	if 	self.state == "CheckCollider" and self.visible  then
		
		-- Tempo < 5 ne rien faire
		if self.tempo + Game.level < 5 then return end
		
		-- Pour chaque asteroide
		for i, v in ipairs(Game.assetManager:getObject("asteroid").astres) do
		
			-- Détection Collision 
			local minDist = 50 * v.transform.scale.x
			if math.dist(v.transform.translate.x, v.transform.translate.y,
						 self.transform.translate.x, self.transform.translate.y) < minDist then
				
				-- 	Etat Hyperspace	
				self.state = "Hyperspace"
				
			end
			
		end
		
	end
	--
	if self.state == "newDirection" and self.visible then
		-- Nouvelle Direction
		local _rn = math.random(3)
		--
		if _rn == 1 then 
			--
			self.velocite.x = - self.velocite.x 
			--
		elseif _rn == 2 then 
			--
			self.velocite.y = - self.velocite.y
			
		else
			--
			self.velocite.x = - self.velocite.x 
			self.velocite.y = - self.velocite.y
			
		end
		
		-- 	Etat CheckCollider
		self.state = "CheckCollider"
		
	end	
	--
	if self.state == "Hyperspace" and self.visible then		
		-- Tirage
		local _rn = math.random(2)
		
		-- Tirage = 1 et tempo > 10
		if _rn == 1 and self.tempo > 10 then
		
			-- Calcule nouvelle position		
			self.transform.translate.x = math.random(0 + 32, Game.win.w)
			self.transform.translate.y = math.random(0 + 32, Game.win.h)
			
			-- Temporisation à 9
			self.tempo = 9
			
			-- 	Etat à CheckCollider
			self.state = "CheckCollider"
		
		end
		
	end	
	
	self:shoot(dt)

end
--
function Ovni:shoot(dt)

	if self.ready > 0 then
		--
		self.ready = self.ready - dt	
		
	end
	
	-- Tir ready
	if self.ready <= 0 then
			
		-- Creer nouveau Bullet
		table.insert(Game.assetManager:getObject("bullet").weapon.bullets, 
					 Game.assetManager:getObject("bullet").CreateBullet())
		
		local nbBullet  = #Game.assetManager:getObject("bullet").weapon.bullets
		local newBullet = Game.assetManager:getObject("bullet").weapon.bullets[nbBullet]
			
		newBullet.id = "bulletOvni"
			
		-- Temps tire suivant
		self.ready = self.reloadTime		
		
		-- Tire aléatoire
		if self.sc == 1 then -- Grande Soucoupe
		
			-- Calcule Direction
			local _rn = math.random(3)
			--
			if _rn == 1 then 
				--
				newBullet.velocite.x = - 1
			
			elseif _rn == 2 then 
				--
				newBullet.velocite.y = - 1
			
			else
				--
				newBullet.velocite.x = - 1
				newBullet.velocite.y = - 1
			
			end
			
			-- Velocité
			newBullet.velocite.x = newBullet.velocite.x * newBullet.velocite.acceleration
			newBullet.velocite.y = newBullet.velocite.y * newBullet.velocite.acceleration
					
		-- Tire Petite Soucoupe
		else
								
			-- Angle vers vaisseau
			local angle = math.angle(
										self.transform.translate.x,
										self.transform.translate.y, 
										Game.assetManager:getObject("plane").transform.translate.x,
										Game.assetManager:getObject("plane").transform.translate.y
									)
			
			-- Velocité			
			if(math.random(3) == 1) then
				--
				newBullet.velocite.x = math.cos(angle) * newBullet.velocite.acceleration	
				newBullet.velocite.y = math.sin(angle) * newBullet.velocite.acceleration
				
			else
				--
				newBullet.velocite.x = math.cos(angle * 2) * newBullet.velocite.acceleration	
				newBullet.velocite.y = math.sin(angle * 2) * newBullet.velocite.acceleration
				
			end			
			
		end
		
		-- Position X, Y
		newBullet.transform.translate.x = self.transform.translate.x
		newBullet.transform.translate.y = self.transform.translate.y
								
	end
end
--
function Ovni:new()

	-- Visible
	self.visible = true
	
	-- Aucun impact
	self.collider = false
	
	-- Petite soucoupe aléatoire à partir de 10000 points
	self.sc  = (Game.score.points < 10000) and 1 or math.random(2)
	
	-- Nouvelle position de la soucoupe
	self.transform.translate.x = 0
	self.transform.translate.y = math.random( Game.win.h )	
	
	-- Change le sens de déplacement en x
	if math.random(2) == 1 then self.velocite.x = - self.velocite.x	end	
	
	-- scale, velocité, points selon tirage
	local _sc = (self.sc == 1) and 1   or 0.5
	local _vl = (self.sc == 1) and 90  or 120
	local _pt = (self.sc == 1) and 200 or 1000
	
	-- Affectatation des valeurs
	self.transform.scale.x 	= _sc
	self.transform.scale.y 	= _sc
	self.velocite.x 		= _vl
	self.velocite.y 		= _vl
	self.points 			= _pt
			
end
--
function Ovni:Sound(dt)

	-- Son selon scale Ovni
	local _snd = (self.sc == 1) and "ovniBig" or "ovniSmall"
	
	-- Jouer le Son
	Game.assetManager:getSound(_snd):play()
	
end
--
function Ovni:update(dt)

	-- décrémente la temporisation
	if self.tempo > 0 then self.tempo = self.tempo - dt end

	-- Visible
	if self.visible then
	
		-- Play Sound
		self:Sound(dt)
		
		-- Invisible si collider true
		if self.collider == true then self.visible = false end
		
		-- Applique IA
		self:AI(dt)
		
		-- Calcule la nouvelle position
		self.transform.translate.x = self.transform.translate.x + (self.velocite.x * dt) 
		self.transform.translate.y = self.transform.translate.y + (self.velocite.y * dt)
							
		-- Applique Transitions
		WrapAround(self)
	
	end
	
	-- Nouvelle Soucoupe
	if self.tempo <= 0 then
	
		-- Tempo aléatoire entre 10 et 15
		self.tempo = math.random(10, 15)
		
		--Nouvelle Soucoupe selon condition
		if	(#Game.assetManager:getObject("asteroid").astres < (5 + ((Game.level -1) * Game.lives)) ) and			
			self.visible == false then
			
			-- Créé et Afficher nouvelle soucoupe
			self:new()
							
		end
		
	end
	
end

function Ovni:draw()
	-- Visible
	if self.visible then
	
		-- Affichage Soucoupe
		LG.draw( 	
				Game.assetManager:getImage("ovni"),
				self.transform.translate.x,	
				self.transform.translate.y,
				self.transform.rotate.x,
				self.transform.scale.x, 
				self.transform.scale.y,
				self.ox, self.oy -- Point à l'origine au centre de l'image
				)
				
	end
	
end

function Ovni:keypressed(key, scancode, isrepeat)	

end

function Ovni:debug()
	--
	if (Game.debug) then 
		--
		LG.print("Visible Ovni: "..tostring(self.visible), 9, 80)
		
	end
	
end

return Ovni