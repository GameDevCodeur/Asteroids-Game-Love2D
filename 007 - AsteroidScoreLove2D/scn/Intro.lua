local SceneIntro = {}

function SceneIntro:load()
	
    video = love.graphics.newVideo("video/intro.ogv")
	width, height = video:getDimensions( )
	scx = Game.win.w / width
	scy = Game.win.h / height
    video:play()
	
end

function SceneIntro:update(dt)

	if video:isPlaying( ) == false then
		SceneIntro:keypressed("space", nill, nill)
	end

end

function SceneIntro:draw()
    love.graphics.draw(video, 0, -50, 0, scx, scy)
end

function SceneIntro:resize(w, h)

	Game.win.w = w
	Game.win.h = h
	
	if w > width then
		scx = Game.win.w / width
		scy = Game.win.h / height
	end
	
end

function SceneIntro:keypressed(key, scancode, isrepeat)

	if key == "escape" then
	
		Game.win.w, Game.win.h = 800, 600
		scx = Game.win.w / width
		scy = Game.win.h / height
		love.window.setFullscreen( false )

	end
	
	if key == "space" then 
		video:release( )
		Game.StatCurrent = "Menu" 
		love.load()
		if Game.win.fullscreen then
			love.resize(Game.win.w, Game.win.h)
		end
	end
	
end

return SceneIntro