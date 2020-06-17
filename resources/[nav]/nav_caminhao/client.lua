-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
emP = Tunnel.getInterface("nav_caminhao")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "gas-01" then
		spawnVehicle("tanker2",1270.60,-3186.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada.")
	elseif data == "gas-02" then
		spawnVehicle("tanker2",1270.40,-3194.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada.")
	elseif data == "gas-03" then
		spawnVehicle("tanker2",1270.20,-3202.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada.")

	elseif data == "diesel-01" then
		spawnVehicle("armytanker",1270.60,-3186.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Diesel</b> liberada.")
	elseif data == "diesel-02" then
		spawnVehicle("armytanker",1270.40,-3194.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Diesel</b> liberada.")
	elseif data == "diesel-03" then
		spawnVehicle("armytanker",1270.20,-3202.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Diesel</b> liberada.")

	elseif data == "show-01" then
		spawnVehicle("tvtrailer",1270.60,-3186.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Shows</b> liberada.")
	elseif data == "show-02" then
		spawnVehicle("tvtrailer",1270.40,-3194.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Shows</b> liberada.")
	elseif data == "show-03" then
		spawnVehicle("tvtrailer",1270.20,-3202.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Shows</b> liberada.")

	elseif data == "woods-01" then
		spawnVehicle("trailerlogs",1270.60,-3186.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada.")
	elseif data == "woods-02" then
		spawnVehicle("trailerlogs",1270.40,-3194.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada.")
	elseif data == "woods-03" then
		spawnVehicle("trailerlogs",1270.20,-3202.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada.")

	elseif data == "cars-01" then
		spawnVehicle("tr4",1270.60,-3186.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículos</b> liberada.")
	elseif data == "cars-02" then
		spawnVehicle("tr4",1270.40,-3194.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículos</b> liberada.")
	elseif data == "cars-03" then
		spawnVehicle("tr4",1270.20,-3202.40,5.90)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículos</b> liberada.")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

function spawnVehicle(name,x,y,z)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local nveh = CreateVehicle(mhash,x,y,z+0.5,85.31,true,false)
		local netveh = VehToNet(nveh)
		local id = NetworkGetNetworkIdFromEntity(nveh)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		if NetworkDoesNetworkIdExist(netveh) then
			SetEntitySomething(nveh,true)
			if NetworkGetEntityIsNetworked(nveh) then
				SetNetworkIdExistsOnAllMachines(netveh,true)
			end
		end

		SetNetworkIdCanMigrate(id,true)
		SetVehicleNumberPlateText(NetToVeh(netveh),"CAMINHAO")
		Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
		SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
		SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
		SetModelAsNoLongerNeeded(mhash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1242.76,-3196.84,6.02,true)
		if distance <= 3 then
			DrawMarker(21,1242.76,-3196.84,6.02-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,126,255,50,0,0,0,1)
			if IsControlJustPressed(0,38) then
				ToggleActionMenu()
			end
		end
	end
end)