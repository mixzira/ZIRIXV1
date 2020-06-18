local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e', function(source,args,rawCommand)
	TriggerClientEvent("emotes",source,args[1])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e2', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent("emotes",nplayer,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PANO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryclean")
AddEventHandler("tryclean",function(nveh)
	TriggerClientEvent("syncclean",-1,nveh)
end)