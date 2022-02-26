local SceneIntro = {}

function SceneIntro:load()
	--
	width, height = Game.assetManager:getVideo("intro"):getDimensions( )
	--
	scx = Game.win.w / width
	scy = Game.win.h / height
	--
    Game.assetManager:getVideo("intro"):play()
	
end
--
function SceneIntro:update(dt)
	--
	if Game.assetManager:getVideo("intro"):isPlaying( ) == false then
		--
		self:keypressed("space", nill, nill)
		
	end

end
--
function SceneIntro:draw()
	--
	if Game.assetManager:getVideo("intro"):isPlaying() then
		--
		LG.draw(Game.assetManager:getVideo("intro"), 0, -50, 0, scx, scy)
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