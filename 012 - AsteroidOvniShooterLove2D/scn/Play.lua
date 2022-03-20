local ScenePlay = {}

function ScenePlay:load()

	-- Syoper la vidéo d'intro
	Game.assetManager:getVideo("menu"):getSource():stop()
	
	-- Jouer la musique en boucle
	Game.assetManager:getMusic("music"):play()	
	
	-- Charger objets du jeu
	for i, v in ipairs(Game.assetManager:getObjects()) do v:load() end

	-- Vider la table astres (les astéroides)
	Game.assetManager:getObject("asteroid").astres = {}
	
end

-- Update
function ScenePlay:update(dt)

	-- Objets du jeu
	for i, v in ipairs(Game.assetManager:getObjects()) do v:update(dt) end
	
	-- Collisions 
	ColliderAstresBulletsPlane(dt)
	
	--  Next Level
	Game:nextLevel()
	
end

-- Afficher
function ScenePlay:draw()

	-- Objets du jeu
	for i, v in ipairs(Game.assetManager:getObjects()) do v:draw() end	
	
	-- Scores
	Game:drawScore()
	
	-- Lives
	Game:drawLives()
	
	-- FPS
	LG.print("FPS: "..tostring(LT.getFPS()), Game.win.w - 140, 20)
	
	-- Information de débogage
	for i, v in ipairs(Game.assetManager:getObjects()) do v:debug()  end
	
end
--
function ScenePlay:resize(w, h)
	--
	Game.win.w = w
	Game.win.h = h	
	--
	Game.assetManager:getObject("background"):Scale()
	Game.assetManager:getObject("plane"):CenterScreen()
	
end
--
function ScenePlay:keypressed(key, scancode, isrepeat)

	Game.assetManager:getObject("plane"):keypressed(key, scancode, isrepeat)
	Game.assetManager:getObject("ovni"):keypressed(key, scancode, isrepeat)
	--
	if key == "escape" then	Game:winReset()	end
	--
	
	
end

return ScenePlay