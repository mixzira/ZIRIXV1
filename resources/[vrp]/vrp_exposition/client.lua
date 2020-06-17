-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_exposition",src)
src = Tunnel.getInterface("vrp_exposition")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local props = {}
local prop = "vw_prop_vw_casino_podium_01a"
local vehicleModel = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("color1",function(source,args)
	if src.checkPermission() then
		local vehiclecolor = vRP.getNearestVehicle(10)
		SetVehicleCustomPrimaryColour(vehiclecolor,tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
	end
end)

RegisterCommand("color2",function(source,args)
	if src.checkPermission() then
		local vehiclecolor = vRP.getNearestVehicle(10)
		SetVehicleCustomSecondaryColour(vehiclecolor,tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
	end
end)

RegisterCommand("expocar",function(source,args)
	local ped = PlayerPedId()
	if src.checkPermission() then
		if not IsPedInAnyVehicle(ped) and args[1] ~= 0 then
			local vehicleModel = GetHashKey(args[1])
			SpawnCar(vehicleModel)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCAR
-----------------------------------------------------------------------------------------------------------------------------------------
CarCreated = false
local NewRot = 1.0

SpawnCar = function(vehicleModel)
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Citizen.Wait(1)
	end
	
	currentCar = CreateVehicle(vehicleModel,-1153.87,-1704.02,12.39, 5.96, true, false)
	SetEntityAsMissionEntity(currentCar,true,true)
	PlaceObjectOnGroundProperly(currentCar)
	
    local id = NetworkGetNetworkIdFromEntity(currentCar)
    SetNetworkIdCanMigrate(id, true)                                                                                                                     
    Wait(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATIONPROP
-----------------------------------------------------------------------------------------------------------------------------------------
local NewRot = 1.0
local NewZ = 0.71
Citizen.CreateThread(function()
    while true do
    	local currentProp = GetClosestObjectOfType(-1153.921,-1703.777,11.1348,0.9,GetHashKey(prop),false,false,false)
		if currentProp ~= nil then
            SetEntityRotation(currentProp, 0.0, 0.0, NewRot,false, true)
			NewRot = NewRot-0.2
        end    
		
		local dist = GetDistanceBetweenCoords(-1153.921,-1703.777,11.1348, GetEntityCoords(PlayerPedId()), true)
		if dist <= 15.0 then
			if IsControlPressed(0, 96) and src.checkPermission() then
				NewZ = NewZ+0.01
			end
			if IsControlPressed(0, 97) and src.checkPermission() then
				NewZ = NewZ-0.01
			end
		end
		AttachEntityToEntity(currentCar,currentProp,0.0,0,0.0,NewZ,0,0,0,1,1,0,1,0,1)
		Citizen.Wait(10)
	end
end)