local ScenePlay = {}

function ScenePlay:load()
	-- Charger les éléments du jeux
	table.foreach( GameObject, function (k,v) v:load() end )
	--
	asteroid.astres = {}
	
end
--
function ScenePlay:update(dt)
	-- Updater les éléments du jeux
	table.foreach( GameObject, function (k,v) v:update(dt) end )
	-- Collisions 
	ColliderAstresBulletsPlane(dt)
	--  Next Level
	if #asteroid.astres == 0 then
		-- Incrémente level
		Game.level = Game.level + 1
		-- Reset Bullets
		bullet.weapon.bullets = {}
		-- Création Astéroides
		for i = 1, clamp(6, Game.level, 15) do
			--
			asteroid:new2( Game.win.w, Game.win.h, 1, 3)
			
		end	
		
	end
	
end
--
function ScenePlay:draw()
	-- Eléments
	table.foreach( GameObject, function (k,v) v:draw() end )	
	-- Scores
	Game:drawScore()
	-- Lives
	Game:drawLives()
	-- FPS
	LG.print("FPS: "..tostring(LT.getFPS()), Game.win.w - 140, 40)
	--
	self:debug()
	
end
--
function ScenePlay:debug()
	-- Debug
	if (Game.debug) then 
		--
		for _,v in pairs(GameObject) do v:debug() end
		
	end
	
end
--
function ScenePlay:resize(w, h)
	--
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
--
function ScenePlay:keypressed(key, scancode, isrepeat)
	--
	if key == "escape" then	Game:winReset()	end
	--
	plane:keypressed(key, scancode, isrepeat)
	
end

return ScenePlay