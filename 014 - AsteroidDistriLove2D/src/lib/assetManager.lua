
local AssetManager = {
	--
	images  = {},
	sounds  = {},
	musics  = {},
	fonts   = {},
	videos  = {},
	objects = {},
	gameObj = {}
	
}
--
function AssetManager:addObject(id, newobj)
	--
	self.objects[id] = newobj
	table.insert(self.gameObj, newobj)
	
end
--
function AssetManager:getObject(id)
	--
	return self.objects[id]
	
end
--
function AssetManager:getObjects()
	--
	return self.gameObj
	
end
--
function AssetManager:loadImage(id, path)
	--
	self.images[id] = LG.newImage(path)
	
end
--
function AssetManager:getImage(id)
	--
	return self.images[id]
	
end
--
function AssetManager:loadSound(id, path)
	--
	self.sounds[id] = LA.newSource(path, "static")
	
end
--
function AssetManager:getSound(id)
	--
	return self.sounds[id]
	
end
--
function AssetManager:loadMusic(id, path)
	--
	self.musics[id] = LA.newSource(path, "stream")
	
end
--
function AssetManager:getMusic(id)
	--
	return self.musics[id]
	
end
--
function AssetManager:loadFont(id, path, size)
	--
	self.fonts[id] = LG.newFont(path, size or 12)
	
end
--
function AssetManager:getFont(id)
	--
	return self.fonts[id]
	
end
--
function AssetManager:loadVideo(id, path)
	--
	self.videos[id] = LG.newVideo(path)
	
end
--
function AssetManager:getVideo(id)
	--
	return self.videos[id]
	
end
--
return AssetManager
