
LT = love.timer
LK = love.keyboard
LM = love.math
LG = love.graphics
LW = love.window
LF = love.filesystem

-- Module Jeu
require("mod.Game")						-- Game

-- Charge Modules Utiles 
require("mod.Transform")				-- Transform
require("mod.Collider")					-- Collider
require("mod.Outils")					-- Outils
require("mod.HighScore")				-- HighScore

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

intro 		= require("scn.Intro")
menu  		= require("scn.Menu")	
play  		= require("scn.Play")
highScore 	= require("scn.HighScore")
