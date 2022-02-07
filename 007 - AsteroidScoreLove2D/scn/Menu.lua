local SceneMenu = {}

function SceneMenu:load()

	mainFont = LG.newFont("font/font.ttf", 70)
	
    video  = LG.newVideo("video/menu.ogv")
	video2   = LG.newVideo("video/menu2.ogv")
	
	width, height = video:getDimensions( )
	
	scx = Game.win.w / width
	scy = Game.win.h / height
	
    video:play()
	
end

function SceneMenu:update(dt)
	if video:isPlaying() then return end
end

function SceneMenu:draw()

	LG.setFont(mainFont)

    LG.draw(video, 0, -50, 0, scx, scy)

	--LG.print("PRESS SPACE",  Game.win.w / 2 - 250, Game.win.h / 2 - 70)
	LG.print("PUSH START",     Game.win.w / 2 - 250, Game.win.h / 2 - 250)
	
end

function SceneMenu:resize(w, h)

	Game.win.w = w
	Game.win.h = h
	
	if w > width then
		scx = Game.win.w / width
		scy = Game.win.h / height
	end
	
end

function SceneMenu:keypressed(key, scancode, isrepeat)

	if key == "space" then 
		video:release( )
		Game.StatCurrent = "Play" 
		love.load()
		if Game.win.fullscreen then
			love.resize(Game.win.w, Game.win.h)
		end
	end

	if key == "escape" then
	
		Game.win.w, Game.win.h = 800, 600
		scx = Game.win.w / width
		scy = Game.win.h / height
		love.window.setFullscreen( false )
		
		-- mainFont:release( )

	end
	
end

return SceneMenu