
LA = love.audio
LT = love.timer
LK = love.keyboard
LM = love.math
LG = love.graphics
LW = love.window
LF = love.filesystem

-- Load Game
require("mod.Game")		 -- Game

-- Load Modules 
require("mod.Transform") -- Transform
require("mod.Collider")	 -- Collider
require("mod.Outils")	 -- Outils
require("mod.HighScore") -- HighScore

-- Add Objects
Game.assetManager:addObject("background", require("obj.Background")) -- Background
Game.assetManager:addObject("plane", 	  require("obj.Plane"))		 -- Plane
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
Game.assetManager:loadImage("explode", 	 "gfx/explode.png")
Game.assetManager:loadImage("bullet",  	 "gfx/bullet.png")
Game.assetManager:loadImage("asteroid",  "gfx/asteroid.png")
Game.assetManager:loadImage("plane",   	 "gfx/plane.png")
Game.assetManager:loadImage("boost",   	 "gfx/boost.png")

-- Load Sounds
Game.assetManager:loadSound("newLive", 	 "sfx/newlive.ogg")
Game.assetManager:loadSound("boost",   	 "sfx/boost.wav")
Game.assetManager:loadSound("explode", 	 "sfx/explode.wav")
Game.assetManager:loadSound("shooter",   "sfx/shoot.ogg")
Game.assetManager:loadSound("select",    "sfx/select.mp3")

-- load Musics
Game.assetManager:loadMusic("music",     "sfx/music.mp3")

-- Load Videos
Game.assetManager:loadVideo("intro", 	 "video/intro.ogv")
Game.assetManager:loadVideo("menu", 	 "video/menu.ogv")
Game.assetManager:loadVideo("highScore", "video/highScore.ogv")

