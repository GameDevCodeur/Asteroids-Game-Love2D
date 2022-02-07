
LT = love.timer
LK = love.keyboard
LM = love.math
LG = love.graphics
LW = love.window

-- Evite le rendu flou du pixelArt.
LG.setDefaultFilter ( "nearest" , "nearest", 1)	

math.randomseed(os.time())

-- -- Parametres du jeu
require("mod.Game")						-- Game

-- Charge Modules Utiles 
require("mod.Transform")				-- Transform
require("mod.Collider")					-- Collider
require("mod.Outils")					-- Outils
	
-- Charge Modules obj
background	= require("mod.Background")	-- Background
plane    	= require("mod.Plane")		-- Plane
bullet   	= require("mod.Bullet")		-- Bullet
asteroid 	= require("mod.Asteroid")	-- Asteroid
explode  	= require("mod.Explode")   	-- Explode

-- Insert dans la table des elements
table.insert(GameObject, background)	
table.insert(GameObject, plane)	
table.insert(GameObject, bullet)
table.insert(GameObject, asteroid)
table.insert(GameObject, explode)

-- Charges les Scenes du jeu
intro = require("scn.Intro")   			-- Intro
menu  = require("scn.Menu")   			-- Menu
play  = require("scn.Play")   			-- Play







	