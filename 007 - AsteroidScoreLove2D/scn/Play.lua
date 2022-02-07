local ScenePlay = {}

function ScenePlay:load()

	-- Charger les éléments du jeux
	for _,v in pairs(GameObject) do v:load() end
	
end

function ScenePlay:update(dt)

	-- Updater les éléments du jeux
	for _,v in pairs(GameObject) do v:update(dt) end
	
	-- Collisions 
	ColliderAstresBulletsPlane()
	
	--  Next Level
	if #asteroid.astres == 0 then
		-- Incrémente le level
		Game.level = Game.level + 1
		-- Reset les Bullets
		bullet.weapon.bullets = {}
		-- Création de nouveau Astéroides
		for i = 1, clamp(6, Game.level, 30) do			
			asteroid:new2( Game.win.w, Game.win.h, 1, 3)
		end		
	end
	
end

function ScenePlay:draw()

	-- Eléments
	for _,v in pairs(GameObject) do v:draw() end
	
	-- Scores
	Game:drawScore()
	
	-- Lives
	Game:drawLives()
		
	-- FPS
	--LG.print("FPS: "..tostring(LT.getFPS()), Game.win.w - 140, 40)
	
	self:debug()
end

function ScenePlay:debug()
	-- Debug
	if (Game.debug) then 
		for _,v in pairs(GameObject) do v:debug() end
	end
end

function ScenePlay:resize(w, h)

	Game.win.w = w
	Game.win.h = h
	
	if w > background.w then
		background.transform.scale.x =  w / background.w 
		background.transform.scale.y =  h / background.h		
	else
		background.transform.scale.x =  background.w / w
		background.transform.scale.y =  background.h / h
	end
	
	plane.transform.translate.x = w / 2
	plane.transform.translate.y = h / 2
	
end

function ScenePlay:keypressed(key, scancode, isrepeat)

	if key == "escape" then
		LW.setFullscreen( false )
		Game:winReset()		
		background:SetScale(2, 2)				
	end
	
	plane:keypressed(key, scancode, isrepeat)
	
end

return ScenePlay