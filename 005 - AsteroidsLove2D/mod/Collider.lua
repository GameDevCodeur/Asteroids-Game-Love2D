
function Collider(obj1, obj2, minDistance)
	-- CALCUL de la distance avec le Théorème de Pythagore entre deux objects
	-- D = SquareRoot(Square(X2 - X1) + Square(Y2 - Y1))
	local distance = math.sqrt((obj1.transform.translate.x - obj2.transform.translate.x)^2 + 
	                     (obj1.transform.translate.y - obj2.transform.translate.y)^2)
	
	return distance <= minDistance
end
