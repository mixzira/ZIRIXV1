local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emR = {}
Tunnel.bindInterface("vrp_radio",emR)
----------------------------------------------------------------------------------------------------
--[ PERMISSÃO ]-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
function emR.permissaoPolicia()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"dpla.permissao")
end
----------------------------------------------------------------------------------------------------
--[ COMANDOS ]--------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
RegisterCommand('radio',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
		if args[1] == "on" then
			TriggerClientEvent("vrp_radio:onradio", source)
		elseif args[1] == "off" then
			TriggerClientEvent("vrp_radio:offradio", source)
		elseif args [1] == nil then
			TriggerClientEvent("vrp_radio:radio", source)
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não possui um <bd>rádio</b> em sua mochila.")
	end
end)