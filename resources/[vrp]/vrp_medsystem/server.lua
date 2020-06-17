local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

RegisterServerEvent('medSystem:print')
AddEventHandler('medSystem:print', function(req, pulse, area, blood, x, y, z, bleeding)

	local _source = source
	
	local xPlayer =  vRP.getUserId(_source)
	Wait(100)
	local name = vRP.getUserIdentity(_source)
	
	
	local xPlayers = vRP.getUsers()

	for i=1, #xPlayers, 1 do
		print(xPlayers[i])
		TriggerClientEvent('medSystem:near', xPlayers[i] ,x ,y ,z , pulse, blood, name.name, name.firstname, area, bleeding)
	end
	
end)

RegisterCommand('med', function(source, args)
	local _source = source
	if args[1] ~= nil then
	TriggerClientEvent('medSystem:send', args[1], _source)
	else
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
	
end, false)