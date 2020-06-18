local items = {}

local nomes = {
	---------------------------------------------------
	--[ Outros ]---------------------------------------
	---------------------------------------------------
	Gadget_parachute = "Paraquedas",
	Petrolcan = "Galão de Gasolina",
	Flare = "Sinalizador",
	Fireextinguisher = "Extintor",
	---------------------------------------------------
	--[ Corpo a Corpo ]--------------------------------
	---------------------------------------------------
	Knife = "Faca",
	Dagger = "Adaga",
	Knuckle = "Soco-Inglês",
	Machete = "Machete",
	Switchblade = "Canivete",
	Wrench = "Chave de Grifo",
	Hammer = "Martelo",
	Golfclub = "Taco de Golf",
	Crowbar = "Pé de Cabra",
	Hatchet = "Machado",
	Flashlight = "Lanterna",
	Bat = "Taco de Beisebol",
	Bottle = "Garrafa",
	Battleaxe = "Machado de Batalha",
	Poolcue = "Taco de Sinuca",
	Stone_hatchet = "Machado de Pedra",
	Nightstick = "Cacetete",
	---------------------------------------------------
	--[ Pistolas ]-------------------------------------
	---------------------------------------------------
	Combatpistol = "Glock 19",
	Revolver_mk2 = "Magnum 44",
	Pistol_mk2 = "FN Five Seven",
	Pistol50 = "Desert Eagle",
	Stungun = "Taser",
	---------------------------------------------------
	--[ FuziL ]----------------------------------------
	---------------------------------------------------
	Carbinerifle_mk2 = "M4A1",
	Assaultrifle_mk2 = "AK-47",
	Compactrifle = "AKS-74U",
	---------------------------------------------------
	--[ Smg ]------------------------------------------
	---------------------------------------------------
	Smg = "MP5",
	Microsmg = "Uzi",
	---------------------------------------------------
	--[ Shotgun ]--------------------------------------
	---------------------------------------------------
	Pumpshotgun_mk2 = "Remington 870",
	---------------------------------------------------
	--[ Rifles ]---------------------------------------
	---------------------------------------------------
	Musket = "Winchester 22"
}

local get_wname = function(weapon_id)
	local name = string.gsub(weapon_id,"WEAPON_","")
	name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
	return nomes[name]
end

local wammo_name = function(args)
	if args[2] == "WEAPON_PETROLCAN" then
		return "Combustível"
	else
		return "Munição de "..get_wname(args[2])
	end
end

local wbody_name = function(args)
	return get_wname(args[2])
end

items["wbody"] = { wbody_name,5 }
items["wammo"] = { wammo_name,0.03 }

return items