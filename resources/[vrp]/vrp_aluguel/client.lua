local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

acServer = Tunnel.getInterface("vrp_aluguel")

acClient = {}
Tunnel.bindInterface("vrp_aluguel",acClient)
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
-- MENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "asterope" then
		acServer.checkPaymentOne()
		ToggleActionMenu()

	elseif data == "serrano" then
		acServer.checkPaymentTwo()
		ToggleActionMenu()

	elseif data == "futo" then
		acServer.checkPaymentTwe()
		ToggleActionMenu()
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

RegisterNetEvent('vrp_aluguel:menu')
AddEventHandler('vrp_aluguel:menu',function()
	ToggleActionMenu()
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    DrawMarker(23, -1059.03, -2719.47, 13.75-0.97,0,0,0,0,0,0,1.0,1.0,0.5,34,126,255,50,0,0,0,0)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1059.03, -2719.47, 13.75, true ) < 1 then
      if(IsControlJustPressed(1,38)) then
        TriggerEvent('vrp_aluguel:menu')
      end
    end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--SPAWN CARROS
-----------------------------------------------------------------------------------------------------------------------------------------

local locais = {
  [1] = { ['x'] = -1051.69, ['y'] = -2712.97, ['z'] = 13.66, ['heading'] = 241.51 },
  [2] = { ['x'] = -1046.43, ['y'] = -2715.97, ['z'] = 13.66, ['heading'] = 241.51 },
  [3] = { ['x'] = -1041.30, ['y'] = -2718.92, ['z'] = 13.66, ['heading'] = 241.51 },
  [4] = { ['x'] = -1023.99, ['y'] = -2728.90, ['z'] = 13.66, ['heading'] = 241.51 },
  [5] = { ['x'] = -1018.83, ['y'] = -2731.97, ['z'] = 13.66, ['heading'] = 241.51 },
  [6] = { ['x'] = -1013.48, ['y'] = -2734.96, ['z'] = 13.65, ['heading'] = 241.51 }
}

function acClient.spawnCarOne(x,y,z,heading)
  local mhash = GetHashKey('asterope')
  
  while not HasModelLoaded(mhash) do
    RequestModel(mhash)
    Citizen.Wait(1)
  end

  if HasModelLoaded(mhash) then
    local spawnCoords = locais[math.random(1,#locais)]
    local nveh = CreateVehicle(mhash, spawnCoords.x, spawnCoords.y, spawnCoords.z+0.5, spawnCoords.heading, true, false)
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
    SetVehicleNumberPlateText(NetToVeh(netveh),vRP.getRegistrationNumber())
    Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
    SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
    SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
    SetModelAsNoLongerNeeded(mhash)
    SetVehRadioStation(NetToVeh(netveh),"OFF")
  end
end

function acClient.spawnCarTwo(x,y,z,heading)
  local mhash = GetHashKey('serrano')
  
  while not HasModelLoaded(mhash) do
    RequestModel(mhash)
    Citizen.Wait(1)
  end

  if HasModelLoaded(mhash) then
    local spawnCoords = locais[math.random(6,#locais)]
    local nveh = CreateVehicle(mhash, spawnCoords.x, spawnCoords.y, spawnCoords.z+0.5, spawnCoords.heading, true, false)
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
    SetVehicleNumberPlateText(NetToVeh(netveh),vRP.getRegistrationNumber())
    Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
    SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
    SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
    SetModelAsNoLongerNeeded(mhash)
    SetVehRadioStation(NetToVeh(netveh),"OFF")
  end
end

function acClient.spawnCarTwe(x,y,z,heading)
    local mhash = GetHashKey('futo')
    
    while not HasModelLoaded(mhash) do
      RequestModel(mhash)
      Citizen.Wait(1)
    end

    if HasModelLoaded(mhash) then
      local spawnCoords = locais[math.random(6,#locais)]
      local nveh = CreateVehicle(mhash, spawnCoords.x, spawnCoords.y, spawnCoords.z+0.5, spawnCoords.heading, true, false)
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
      SetVehicleNumberPlateText(NetToVeh(netveh),vRP.getRegistrationNumber())
      Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
      SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
      SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
      SetModelAsNoLongerNeeded(mhash)
      SetVehRadioStation(NetToVeh(netveh),"OFF")
    end
end