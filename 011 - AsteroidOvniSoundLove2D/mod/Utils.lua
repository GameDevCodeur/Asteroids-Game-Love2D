-- Permet à un objet en mouvement de disparaître du bord de l'écran 
-- et de réapparaître au point correspondant sur le bord opposé
function WrapAround(obj)

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