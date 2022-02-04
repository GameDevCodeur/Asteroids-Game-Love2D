
LT = love.timer
LK = love.keyboard

LG = love.graphics
LG.setDefaultFilter ( "nearest" , "nearest", 1)	-- Evite le rendu flou du pixelArt.

-- Elements du jeu
GameObject = {}

-- Charge Module Transform
require("mod.Transform")			-- Transform
require("mod.Collider")				-- Collider
	
-- Charge Module Plane, Bullet
plane    = require("mod.Plane")		-- Plane
bullet   = require("mod.Bullet")	-- Bullet
asteroid = require("mod.Asteroid")	-- Asteroid

-- Insert dans la table des elements du jeu
table.insert(GameObject, plane)	
table.insert(GameObject, bullet)
table.insert(GameObject, asteroid)
	
-- Taille de la fenêtre
win = {
	w = LG.getWidth(),
	h = LG.getHeight()
}
	
	