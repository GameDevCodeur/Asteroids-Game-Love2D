
-- The Transform component determines the Position, Rotation, and Scale of each object in the scene. 
-- Every GameObject has a Transform.
function newObjTransform(tx, ty, rx, ry, rspeed, sx, sy) 
	return {
		translate = {x = tx or 0, y = ty or 0},    						-- position
		rotate    = {x = rx or 0, y = ry or 0, speed = rspeed or 0},	-- rotation
		scale     = {x = sx or 1, y = sy or 1}							-- échelle
	}
end

-- Utilisez cette fonction pour vous assurer que la valeur ne dépasse pas la valeur maximale donnée 
-- et n'est pas inférieure à la valeur minimale.
function clamp(min, val, max)
    return math.max(min, math.min(val, max));
end

function rotateLeft(obj, dt)
	obj.transform.rotate.x = obj.transform.rotate.x - (obj.transform.rotate.speed * dt)
end

function rotateRight(obj, dt)
	obj.transform.rotate.x = obj.transform.rotate.x + (obj.transform.rotate.speed * dt)
end

function velociteUp(obj, dt)
	obj.velocite.x = obj.velocite.x + math.sin(obj.transform.rotate.x) * (clamp(50, obj.velocite.acceleration, 90)* dt)
	obj.velocite.y = obj.velocite.y + math.cos(obj.transform.rotate.x) * (clamp(-50, -obj.velocite.acceleration, -90)* dt)	
end