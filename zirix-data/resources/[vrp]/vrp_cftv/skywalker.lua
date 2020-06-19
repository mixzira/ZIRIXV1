----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

siS = {}
Tunnel.bindInterface("vrp_cftv",siS)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function siS.Permissao()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,"dpla.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
		return true
	else

	end
end
