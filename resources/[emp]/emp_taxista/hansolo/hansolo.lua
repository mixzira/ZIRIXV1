local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
emP = Tunnel.getInterface("emp_taxista")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS DO TAXIMETRO ]-------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local TaxiGuiAtivo = true -- Ativa o GUIzin (Default: true)
local Custobandeira = 0.0 --(1.00 = R$60 por minuto) Custo por minuto
local custoporKm = 50.0 -- Custo por Km
local CustoBase = 0.0 -- Custo Inicial

DecorRegister("bandeiras", 1)
DecorRegister("kilometros", 1)
DecorRegister("meteractive", 2)
DecorRegister("CustoBase", 1)
DecorRegister("custoporKm", 1)
DecorRegister("Custobandeira", 1)

local inTaxi = false
local meterOpen = false
local meterActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TAXIMETRO ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function openGui()
  SendNUIMessage({openMeter = true})
end

function closeGui()
  SendNUIMessage({openMeter = false})
  meterOpen = false
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if NoTaxi() and GetPedInVehicleSeat(veh, -1) ~= ped then
      local ped = PlayerPedId()
      local veh = GetVehiclePedIsIn(ped, false)
      TriggerEvent('taxi:updatebandeira', veh)
      openGui()
      meterOpen = true
    end
    if meterActive and GetPedInVehicleSeat(veh, -1) == ped then
      local _bandeira = DecorGetFloat(veh, "bandeiras")
      local _kilometros = DecorGetFloat(veh, "kilometros")
      local _Custobandeira = DecorGetFloat(veh, "Custobandeira")

      if _Custobandeira ~= 0 then
        DecorSetFloat(veh, "bandeiras", _bandeira + _Custobandeira)
      else
        DecorSetFloat(veh, "bandeiras", _bandeira + Custobandeira) -- 3.605936
      end -- 0.000621371
      DecorSetFloat(veh, "kilometros", _kilometros + round(GetEntitySpeed(veh) * 0.000912371, 5))
      TriggerEvent('taxi:updatebandeira', veh)
    end
    if NoTaxi() and not GetPedInVehicleSeat(veh, -1) == ped then
      TriggerEvent('taxi:updatebandeira', veh)
    end
  end
end)

if TaxiGuiAtivo then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(5)
      if(NoTaxi()) then
        inTaxi = true
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
          if IsControlJustReleased(0,170) and emP.checkPermission() then -- F3
            TriggerEvent('taxi:toggleDisplay')
            Citizen.Wait(100)
          end
          if IsControlJustReleased(0,288) and emP.checkPermission() then -- F1
            TriggerEvent('taxi:toggleHire')
            Citizen.Wait(100)
          end
          if IsControlJustReleased(0,289) and emP.checkPermission() then -- F2
            TriggerEvent('taxi:resetMeter')
            Citizen.Wait(100)
          end
        end
      else
        if(meterOpen) then
          closeGui()
        end
        meterOpen = false
      end
    end
  end)
end

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

--Métodos de retorno de chamada NUI
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNetEvent('taxi:toggleDisplay')
AddEventHandler('taxi:toggleDisplay', function()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterOpen then
      closeGui()
      meterOpen = false
    else
      local _bandeira = DecorGetFloat(veh, "bandeiras")
      if _bandeira < CustoBase then
        DecorSetFloat(veh, "bandeiras", CustoBase)
      end
      TriggerEvent('taxi:updatebandeira', veh)
      openGui()
      meterOpen = true
    end
  end
end)

RegisterNetEvent('taxi:toggleHire')
AddEventHandler('taxi:toggleHire', function()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterActive then
      SendNUIMessage({meterActive = false})
      meterActive = false
      DecorSetBool(veh, "meteractive", false)
    else
      SendNUIMessage({meterActive = true})
      meterActive = true
      DecorSetBool(veh, "meteractive", true)
    end
  end
end)

RegisterNetEvent('taxi:resetMeter')
AddEventHandler('taxi:resetMeter', function()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    local _bandeira = DecorGetFloat(veh, "bandeiras")
    local _kilometros = DecorGetFloat(veh, "kilometros")
    DecorSetFloat(veh, "CustoBase", CustoBase)
    DecorSetFloat(veh, "custoporKm", custoporKm)
    DecorSetFloat(veh, "Custobandeira", Custobandeira)
    DecorSetFloat(veh, "bandeiras", DecorGetFloat(veh, "CustoBase"))
    DecorSetFloat(veh, "kilometros", 0.0)
    TriggerEvent('taxi:updatebandeira', veh)
  end
end)

function IsInVehicle()
  local ply = PlayerPedId()
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function NoTaxi()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  local model = GetEntityModel(veh)
  local displaytext = GetDisplayNameFromVehicleModel(model)
  local name = GetLabelText(displaytext)
  if (name == "Táxi") then
    return true
  else
    return false
  end
end

function ReturnVehicle()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  local model = GetEntityModel(veh)
  local displaytext = GetDisplayNameFromVehicleModel(model)
  local name = GetLabelText(displaytext)
end

function IsNearPlayer(player)
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
  if(distance <= 5) then
    return true
  end
end

RegisterNetEvent('taxi:updatebandeira')
AddEventHandler('taxi:updatebandeira', function(veh)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
  local _bandeira = DecorGetFloat(veh, "bandeiras")
  local _kilometros = DecorGetFloat(veh, "kilometros")
  local Custobandeira = _bandeira + (_kilometros * DecorGetFloat(veh, "custoporKm"))


  SendNUIMessage({
    updateBalance = true,
    balance = string.format("%.2f", Custobandeira),
    player = string.format("%.2f", _kilometros),
    meterActive = DecorGetBool(veh, "meteractive")
  })
end)