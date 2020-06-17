local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local hours = 2
local minutes = 50
local weather = "EXTRASUNNY"
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {
	[1] = { "EXTRASUNNY" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_vsync:requestSync")
AddEventHandler("vrp_vsync:requestSync",function()
	TriggerClientEvent("vrp_vsync:updateWeather",-1,weather)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		minutes = minutes + 1
		if minutes >= 60 then
			minutes = 0
			hours = hours + 1
			if hours >= 24 then
				hours = 0
			end
		end
		TriggerClientEvent("vrp_vsync:syncTimers",-1,{minutes,hours})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(600000)
		weather = timers[math.random(1)][1]
		TriggerClientEvent("vrp_vsync:updateWeather",-1,weather)
	end
end)

RegisterCommand('clima',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"administrador.permissao") then
		TriggerClientEvent("vrp_vsync:updateWeather",-1,args[1])
		end
	end
end)