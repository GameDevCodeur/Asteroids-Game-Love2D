
LT = love.timer
LK = love.keyboard

LG = love.graphics

-- Evite le rendu flou du pixelArt.
LG.setDefaultFilter ( "nearest" , "nearest", 1)	

-- Elements du jeu
GameObject = {}

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
	
-- Parametres du jeu
Game = {
	win = { w = LG.getWidth(), h = LG.getHeight()}
}
	
	