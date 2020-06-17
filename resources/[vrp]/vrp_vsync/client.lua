local hora = 2
local minuto = 50
local currentweather = "EXRTASUNNY"
local lastWeather = currentweather
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEWEATHER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_vsync:updateWeather")
AddEventHandler("vrp_vsync:updateWeather",function(NewWeather)
	currentweather = NewWeather
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONWEATHER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if lastWeather ~= currentweather then
			lastWeather = currentweather
			SetWeatherTypeOverTime(currentweather,15.0)
			Citizen.Wait(15000)
		end
		ClearOverrideWeather()
		ClearWeatherTypePersist()
		SetWeatherTypePersist(lastWeather)
		SetWeatherTypeNow(lastWeather)
		SetWeatherTypeNowPersist(lastWeather)
		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWNED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerSpawned",function()
	TriggerServerEvent("vrp_vsync:requestSync")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_vsync:syncTimers")
AddEventHandler("vrp_vsync:syncTimers",function(timer)
	hora = timer[2]
	minuto = timer[1]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKCLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		NetworkOverrideClockTime(hora,minuto,00)
	end
end)