
local Debug = {
	debug = false,
}

function Debug:load(etat)
	self.debug = etat
end

function Debug:update(dt)
end

function Debug:draw(obj)
	if self.debug then		
		obj:debug()
	end
end

return Debug