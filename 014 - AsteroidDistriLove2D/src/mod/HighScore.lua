HighScore = { 	
				highScore = 0, 
				scores = {},
				nbScores = 0,
				nbScoresMax = 10				
			}

function HighScore:load()
	--
	if LF.getInfo("GameData.lua") == nil then
		--
		LF.newFile("GameData.lua")
		LF.write("GameData.lua", tostring("5000	GDC"))
		
	end
	--
	local file = LF.newFile("GameData.lua")
	--
	if not LF.getInfo("GameData.lua") or not file:open("r") then return end
	--
	self.scores = {}
	--
	for line in file:lines() do
		--
		local i = line:find('\t', 1, true)
		self.scores[#self.scores + 1] = {sc = line:sub(1, i-1), na = line:sub(i+1)}
	
	end	
	--
	if(#self.scores) then
		--
		self.highScore = self.scores[1].sc
		
	end	
	--
	return file:close()
	
end
--
function HighScore:draw()
	--
	LG.printf(	"HIGH SCORES",
				Game.assetManager:getFont("font40"), 
				0, 150, 
				Game.win.w, "center" )
	--
	for k, v in ipairs(self.scores) do 
		-- 
		if k > self.nbScoresMax then return end
		--
		LG.printf(	tostring(k),
					Game.assetManager:getFont("font30"), 
					Game.win.w / 2 - 250, 180 + (30 * k), 
					50, "center" )							
				
		LG.printf(	tostring(v.sc),
					Game.assetManager:getFont("font30"), 
					Game.win.w / 2 - 200, 180 + (30 * k), 
					300, "right" )
					
		LG.printf(	v.na,
					Game.assetManager:getFont("font30"),  
					Game.win.w / 2 + 140, 180 + (30 * k), 
					80, "center" )
		
	end
	
end
--
function HighScore:add(newscore)
	--
	self.scores[#self.scores + 1] = newscore
	table.sort(self.scores, function (SC1, SC2) return tonumber(SC1.sc) > tonumber(SC2.sc) end)
	
end
--
function HighScore:save()
	--
	local file = LF.newFile("GameData.lua")
	--
	if not file:open("w") then return end
	--
	self.nbScores = ( (#self.scores < self.nbScoresMax) and (#self.scores) or (self.nbScoresMax) )
	--
	for i = 1, self.nbScores do
		--
		file:write(self.scores[i].sc .. "\t" .. self.scores[i].na .. "\n")
		
	end	
	--
	if(#self.scores) then
		--
		self.highScore = self.scores[1].sc
		
	end
	--
	return file:close()
	
end


