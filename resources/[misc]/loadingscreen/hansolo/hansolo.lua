----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Ran = false

AddEventHandler("playerSpawned", function ()
	if not Ran then
		ShutdownLoadingScreenNui()
		Ran = true
		TriggerEvent("status:hud",true)
	end
end)