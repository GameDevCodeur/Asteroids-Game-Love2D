
-- Calcul d'angle
function math.angle(x1,y1, x2,y2)
	--
    return math.atan2(y2-y1, x2-x1)
	
end

-- Calcul de distance
function math.dist(x1,y1, x2,y2)
	--
	return ((x2 - x1)^2+(y2 - y1)^2)^0.5
	
end

-- Utilisez cette fonction pour vous assurer que la valeur ne dépasse pas la valeur maximale donnée 
-- et n'est pas inférieure à la valeur minimale.
function math.clamp(min, val, max)
	--
    return math.max(min, math.min(val, max))
	
end