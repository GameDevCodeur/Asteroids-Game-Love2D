HighScore = { 	
				highScore = 0, 
				scores = {},
				nbScores = 0,
				nbScoresMax = 10				
			}
--
local font = LG.newFont("font/font.ttf", 30)

function HighScore:load()	
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
				font, 
				0, 150, 
				Game.win.w, "center" )
	--
	
	table.foreach(	self.scores, 
					function (k,v)
						-- Affiche le nbScoresMax de Scores
						if k > self.nbScoresMax then return end
						--
						LG.printf(	tostring(k),
									font, 
									Game.win.w / 2 - 250, 200 + (20 * k), 
									50, "center" )							
					
						LG.printf(	tostring(v.sc),
									font, 
									Game.win.w / 2 - 200, 200 + (20 * k), 
									300, "right" )
					
						LG.printf(	v.na,
									font,  
									Game.win.w / 2 + 140, 200 + (20 * k), 
									80, "center" )
		
					end
				  )
	
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
	if #self.scores < self.nbScoresMax then
		--
		self.nbScores = #self.scores
		
	else
		--
		self.nbScores = self.nbScoresMax
		
	end
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


