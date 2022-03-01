
-- The Transform component determines the Position, Rotation, and Scale of each object in the scene. 
-- Every GameObject has a Transform.
function newObjTransform(tx, ty, rx, ry, rspeed, sx, sy) 
	return {
		translate = {x = tx or 0, y = ty or 0},    						-- position
		rotate    = {x = rx or 0, y = ry or 0, speed = rspeed or 0},	-- rotation
		scale     = {x = sx or 1, y = sy or 1}							-- échelle
	}
end
