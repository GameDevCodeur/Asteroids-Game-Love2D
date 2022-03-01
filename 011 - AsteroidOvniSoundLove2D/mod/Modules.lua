
LA = love.audio
LT = love.timer
LK = love.keyboard
LM = love.math
LG = love.graphics
LW = love.window
LF = love.filesystem

-- Lib Extension
require("lib.mathEx")	 -- Extension math lua

-- Load Game
require("mod.Game")		 -- Game

-- Load Modules 
require("mod.Utils")	 -- Outils
require("mod.Transform") -- Transform
require("mod.Collider")	 -- Collider
require("mod.HighScore") -- HighScore

-- Add Objects
Game.assetManager:addObject("background", require("obj.Background")) -- Background
Game.assetManager:addObject("plane", 	  require("obj.Plane"))		 -- Plane
Game.assetManager:addObject("ovni", 	  require("obj.Ovni"))	 	 -- Ovni
Game.assetManager:addObject("bullet", 	  require("obj.Bullet"))	 -- Bullet
Game.assetManager:addObject("asteroid",   require("obj.Asteroid"))	 -- Asteroid
Game.assetManager:addObject("explode", 	  require("obj.Explode"))	 -- Explode

-- Scenes du jeu
intro 		= require("scn.Intro")
menu  		= require("scn.Menu")
play  		= require("scn.Play")
highScore 	= require("scn.HighScore")

-- Load Fonts
Game.assetManager:loadFont("font24",  	 "font/font.ttf", 24)
Game.assetManager:loadFont("font30",  	 "font/font.ttf", 30)
Game.assetManager:loadFont("font40",  	 "font/font.ttf", 40)
Game.assetManager:loadFont("font70",  	 "font/font.ttf", 70)

-- Load Images
Game.assetManager:loadImage("background","gfx/background.png")
Game.assetManager:loadImage("bullet",  	 "gfx/bullet.png")
Game.assetManager:loadImage("asteroid",  "gfx/asteroid.png")
Game.assetManager:loadImage("plane",   	 "gfx/plane.png")
Game.assetManager:loadImage("boost",   	 "gfx/boost.png")
Game.assetManager:loadImage("ovni",   	 "gfx/ovni.png")
Game.assetManager:loadImage("explode", 	 "gfx/explode.png")

-- Load Sounds
Game.assetManager:loadSound("newLive", 	 	 "sfx/newlive.ogg")
Game.assetManager:loadSound("boost",   	 	 "sfx/thrust.wav")
Game.assetManager:loadSound("explodeLarge",  "sfx/bangLarge.wav")
Game.assetManager:loadSound("explodeMedium", "sfx/bangMedium.wav")
Game.assetManager:loadSound("explodeSmall",  "sfx/bangSmall.wav")
Game.assetManager:loadSound("shooter",   	 "sfx/fire.wav")
Game.assetManager:loadSound("select",    	 "sfx/select.mp3")
Game.assetManager:loadSound("ovniBig",     	 "sfx/saucerBig.wav")
Game.assetManager:loadSound("ovniSmall",     "sfx/saucerSmall.wav")

-- load Musics
Game.assetManager:loadMusic("music",     "sfx/music.mp3")

-- Load Videos
Game.assetManager:loadVideo("intro", 	 "video/intro.ogv")
Game.assetManager:loadVideo("menu", 	 "video/menu.ogv")
Game.assetManager:loadVideo("highScore", "video/highScore.ogv")

