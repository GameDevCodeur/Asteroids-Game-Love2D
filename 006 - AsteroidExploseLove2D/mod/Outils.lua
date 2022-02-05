
-- Utilisez cette fonction pour vous assurer que la valeur ne dépasse pas la valeur maximale donnée 
-- et n'est pas inférieure à la valeur minimale.
function clamp(min, val, max)
    return math.max(min, math.min(val, max));
end

-- Teabsalte coté de l'écran opposé
function Transitions(obj)

	-- Calcule la transition droite-gauche de l'écran
	if obj.transform.translate.x > Game.win.w then
		obj.transform.translate.x = 0
		
	-- Calcule la transition gauche-droite de l'écran
	elseif obj.transform.translate.x < 0 then
			obj.transform.translate.x = Game.win.w			
	end

	-- Calcule la transition bas-haut de l'écran
	if obj.transform.translate.y > Game.win.h then
		obj.transform.translate.y = 0
		
	-- Calcule la transition haut-bas de l'écran	
	elseif obj.transform.translate.y < 0 then
		obj.transform.translate.y = Game.win.h		
	end
	
end