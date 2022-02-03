
LT = love.timer
LK = love.keyboard

LG = love.graphics
LG.setDefaultFilter ( "nearest" , "nearest", 1)	-- Evite le rendu flou du pixelArt.

-- Chargement les modules

	-- Charge Module Transform
	require("mod.Transform")		-- Transform
	
	-- Charge Module Plane
	plane = require("mod.Plane")	-- Plane
	
	-- Charge module de Débugage
	debug = require("mod.Debug")	-- Debug
	debug:load(true)