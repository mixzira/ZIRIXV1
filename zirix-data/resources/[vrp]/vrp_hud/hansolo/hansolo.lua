----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local started = true
local displayValue = false
local hudcmd = false
local sBuffer = {}
local vBuffer = {}
local gasolina = 0
local CintoSeguranca = false
local thirst, hunger = 0, 0
-----------------------------------------------------------------------------------------------------------------------------------------
--[ HUD ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local menu_celular = false
RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	menu_celular = status
end)

RegisterNetEvent("vrp_hud:update")
AddEventHandler("vrp_hud:update", function(rHunger, rThirst)
  hunger, thirst = rHunger, rThirst
end)

Citizen.CreateThread(function()
	while true do
    local idle = 1000
		health = (GetEntityHealth(PlayerPedId())-100)/300*100
    armor = GetPedArmour(PlayerPedId())

    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),false))

		if IsPedInAnyVehicle(PlayerPedId()) then
      PedCar = GetVehiclePedIsIn(PlayerPedId())
      speed = math.ceil(GetEntitySpeed(PedCar)*3.605936)
      inCar  = true
      gasolina = GetVehicleFuelLevel(PedCar)
      idle = 100
      
      if menu_celular then
			  DisplayRadar(false)
      else
        DisplayRadar(true)
      end

    else
      
			DisplayRadar(false)
			inCar  = false
			PedCar = nil
      speed = nil

    end
    
		SendNUIMessage({
			show = show,
			incar = inCar,
      speed = speed,
			heal = health,
      armor = armor,
      thirst = thirst,
      hunger = hunger,
      gas = gasolina,
      cinto = CintoSeguranca,
		 	display = displayValue
    });

    Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CINTO DE SEGURANÇA ]-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
  local vc = GetVehicleClass(veh)
  return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end

Fwv = function (entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then
    hr = 360.0 + hr
  end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

local segundos = 0

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)

    if inCar then
      local ped = PlayerPedId()
      local car = GetVehiclePedIsIn(ped)

      if car ~= 0 and (ExNoCarro or IsCar(car)) then
        ExNoCarro = true

        if CintoSeguranca then
          DisableControlAction(0,75)
        end

        sBuffer[2] = sBuffer[1]
        sBuffer[1] = GetEntitySpeed(car)

        if sBuffer[2] ~= nil and not CintoSeguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
          local co = GetEntityCoords(ped)
          local fw = Fwv(ped)
          SetEntityHealth(ped,GetEntityHealth(ped)-150)
          SetEntityCoords(ped,co.x+fw.x,co.y+fw.y,co.z-0.47,true,true,true)
          SetEntityVelocity(ped,vBuffer[2].x,vBuffer[2].y,vBuffer[2].z)
          segundos = 20
        end

        vBuffer[2] = vBuffer[1]
        vBuffer[1] = GetEntityVelocity(car)

        if IsControlJustReleased(1,47) then
          TriggerEvent("cancelando",true)
          if CintoSeguranca then
            TriggerEvent("vrp_sound:source",'unbelt',0.5)
            SetTimeout(2000,function()
              CintoSeguranca = false
              TriggerEvent("cancelando",false)
            end)
          else
            TriggerEvent("vrp_sound:source",'belt',0.5)
              SetTimeout(3000,function()
                CintoSeguranca = true
                TriggerEvent("cancelando",false)
              end)
            end

          end
      elseif ExNoCarro then
        ExNoCarro = false
        CintoSeguranca = false
        sBuffer[1],sBuffer[2] = 0.0,0.0
      end
    end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ OCULTA A HUD QUANDO PAUSA ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hud',function(source, args, rawCommand)
  if started then
    if not menu_celular then
      menu_celular = true
    else
      menu_celular = false
    end
  end
end)

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(100)
    if started then 
      if IsPauseMenuActive() or menu_celular then
        displayValue = false
      else
        displayValue = true
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if disabled then
      DisableControlAction(1,243,true)
      DisableControlAction(1,213,true)
      DisableControlAction(0,21,true) 
      DisableControlAction(0,24,true)
      DisableControlAction(0,25,true) 
      DisableControlAction(0,47,true) 
      DisableControlAction(0,49,true)
      DisableControlAction(0,44,true) 
      DisableControlAction(0,303,true) 
      DisableControlAction(0,246,true) 
      DisableControlAction(0,311,true) 
      DisableControlAction(0,58,true) 
      DisableControlAction(0,263,true) 
      DisableControlAction(0,264,true) 
      DisableControlAction(0,257,true) 
      DisableControlAction(0,140,true) 
      DisableControlAction(0,141,true) 
      DisableControlAction(0,142,true)
      DisableControlAction(0,143,true) 
      DisableControlAction(0,75,true) 
      DisableControlAction(27,75,true) 
    end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CONTAGEM ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if segundos > 0 then
      segundos = segundos - 1
    end
  end
end)