local SceneIntro = {}

function SceneIntro:load()
	--
	width, height = Game.introvideo:getDimensions( )
	--
	scx = Game.win.w / width
	scy = Game.win.h / height
	--
    Game.introvideo:play()
	
end
--
function SceneIntro:update(dt)
	--
	if Game.introvideo:isPlaying( ) == false then
		--
		self:keypressed("space", nill, nill)
		
	end

end
--
function SceneIntro:draw()
	--
	if Game.introvideo:isPlaying() then
		--
		LG.draw(Game.introvideo, 0, -50, 0, scx, scy)
	end
	
end
--
function SceneIntro:resize(w, h)
	--
	Game.win.w = w
	Game.win.h = h
	--
	if w > width then
		--
		scx = Game.win.w / width
		scy = Game.win.h / height
		
	end
	
end
--
function SceneIntro:keypressed(key, scancode, isrepeat)
	--
	if key == "space" then Game:menu() end
	--
	if key == "escape" then
		Game:winReset()
		self.load()

	end	
	
end

return SceneIntro