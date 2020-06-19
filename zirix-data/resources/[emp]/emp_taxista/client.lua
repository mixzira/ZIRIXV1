local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

emP = Tunnel.getInterface("emp_taxista")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = nil
local selecionado = 0
local emservico = false
local passageiro = nil
local lastpassageiro = nil
local checkped = true
local timers = 0
local payment = 10
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local CoordenadaX = 895.44
local CoordenadaY = -169.07
local CoordenadaZ = 74.17
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS DO TAXÍMETRO ]-------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local TaxiGuiAtivo = true -- Ativa o GUIzin (Default: true)
local Custobandeira = 3.0 --(1.00 = R$60 por minuto) Custo por minuto
local custoporKm = 50.0 -- Custo por Km
local CustoBase = 10.0 -- Custo Inicial

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
--[ LOCALIDADES ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 151.30, ['y'] = -1028.63, ['z'] = 28.84, ['xp'] = 152.45, ['yp'] = -1041.24, ['zp'] = 29.37, ['h'] = 252.0 },
	[2] = { ['x'] = 423.84, ['y'] = -959.30, ['z'] = 28.81, ['xp'] = 437.37, ['yp'] = -979.03, ['zp'] = 30.68, ['h'] = 271.0 },
	[3] = { ['x'] = 1.03, ['y'] = -1510.86, ['z'] = 29.40, ['xp'] = 20.67, ['yp'] = -1505.62, ['zp'] = 31.85, ['h'] = 319.0 },
	[4] = { ['x'] = -188.07, ['y'] = -1612.28, ['z'] = 33.39, ['xp'] = -189.55, ['yp'] = -1585.80, ['zp'] = 34.76, ['h'] = 178.0 },
	[5] = { ['x'] = 98.88, ['y'] = -1927.16, ['z'] = 20.25, ['xp'] = 101.02, ['yp'] = -1912.35, ['zp'] = 21.40, ['h'] = 70.0 },
	[6] = { ['x'] = 320.98, ['y'] = -2022.02, ['z'] = 20.40, ['xp'] = 335.73, ['yp'] = -2010.77, ['zp'] = 22.31, ['h'] = 321.0 },
	[7] = { ['x'] = 755.53, ['y'] = -2486.26, ['z'] = 19.54, ['xp'] = 774.34, ['yp'] = -2475.07, ['zp'] = 20.14, ['h'] = 356.0 },
	[8] = { ['x'] = 1057.66, ['y'] = -2124.80, ['z'] = 32.20, ['xp'] = 1040.09, ['yp'] = -2115.65, ['zp'] = 32.84, ['h'] = 175.0 },
	[9] = { ['x'] = 1377.08, ['y'] = -1530.01, ['z'] = 56.07, ['xp'] = 1379.33, ['yp'] = -1514.99, ['zp'] = 58.43, ['h'] = 119.0 },
	[10] = { ['x'] = 1260.24, ['y'] = -588.15, ['z'] = 68.53, ['xp'] = 1240.60, ['yp'] = -601.63, ['zp'] = 69.78, ['h'] = 193.0 },
	[11] = { ['x'] = 899.58, ['y'] = -590.58, ['z'] = 56.85, ['xp'] = 886.76, ['yp'] = -608.20, ['zp'] = 58.44, ['h'] = 238.0 },
	[12] = { ['x'] = 945.18, ['y'] = -140.04, ['z'] = 74.07, ['xp'] = 959.34, ['yp'] = -121.23, ['zp'] = 74.96, ['h'] = 60.0 },
	[13] = { ['x'] = 84.44, ['y'] = 476.19, ['z'] = 146.91, ['xp'] = 80.10, ['yp'] = 486.12, ['zp'] = 148.20, ['h'] = 118.0 },
	[14] = { ['x'] = -720.03, ['y'] = 482.23, ['z'] = 107.10, ['xp'] = -721.10, ['yp'] = 489.75, ['zp'] = 109.38, ['h'] = 110.0 },
	[15] = { ['x'] = -1244.39, ['y'] = 497.98, ['z'] = 93.86, ['xp'] = -1229.15, ['yp'] = 515.72, ['zp'] = 95.42, ['h'] = 359.0 },
	[16] = { ['x'] = -1514.99, ['y'] = 442.97, ['z'] = 109.70, ['xp'] = -1495.97, ['yp'] = 437.10, ['zp'] = 112.49, ['h'] = 296.0 },
	[17] = { ['x'] = -1684.14, ['y'] = -308.47, ['z'] = 51.41, ['xp'] = -1684.87, ['yp'] = -291.66, ['zp'] = 51.89, ['h'] = 234.0 },
	[18] = { ['x'] = -1413.14, ['y'] = -531.91, ['z'] = 30.98, ['xp'] = -1447.29, ['yp'] = -537.71, ['zp'] = 34.74, ['h'] = 215.0 },
	[19] = { ['x'] = -1036.80, ['y'] = -492.27, ['z'] = 36.15, ['xp'] = -1007.32, ['yp'] = -486.80, ['zp'] = 39.97, ['h'] = 27.0 },
	[20] = { ['x'] = -551.46, ['y'] = -648.64, ['z'] = 32.73, ['xp'] = -533.39, ['yp'] = -622.87, ['zp'] = 34.67, ['h'] = 92.0 },
	[21] = { ['x'] = -616.30, ['y'] = -920.80, ['z'] = 22.98, ['xp'] = -598.49, ['yp'] = -929.96, ['zp'] = 23.86, ['h'] = 291.0 },
	[22] = { ['x'] = -752.13, ['y'] = -1041.29, ['z'] = 12.25, ['xp'] = -759.21, ['yp'] = -1047.16, ['zp'] = 13.50, ['h'] = 117.0 },
	[23] = { ['x'] = -1155.20, ['y'] = -1413.48, ['z'] = 4.46, ['xp'] = -1150.56, ['yp'] = -1426.38, ['zp'] = 4.95, ['h'] = 247.0 },
	[24] = { ['x'] = -997.88, ['y'] = -1599.65, ['z'] = 4.59, ['xp'] = -989.04, ['yp'] = -1575.82, ['zp'] = 5.17, ['h'] = 271.0 },
	[25] = { ['x'] = -829.38, ['y'] = -1218.09, ['z'] = 6.54, ['xp'] = -822.50, ['yp'] = -1223.35, ['zp'] = 7.36, ['h'] = 319.0 },
	[26] = { ['x'] = -334.47, ['y'] = -1418.13, ['z'] = 29.71, ['xp'] = -320.10, ['yp'] = -1389.73, ['zp'] = 36.50, ['h'] = 91.0 },
	[27] = { ['x'] = 135.28, ['y'] = -1306.46, ['z'] = 28.65, ['xp'] = 132.91, ['yp'] = -1293.90, ['zp'] = 29.26, ['h'] = 119.0 },
	[28] = { ['x'] = -34.00, ['y'] = -1079.86, ['z'] = 26.26, ['xp'] = -39.02, ['yp'] = -1082.46, ['zp'] = 26.42, ['h'] = 69.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PEDLIST ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {
	[1] = { ['model'] = "ig_abigail", ['hash'] = 0x400AEC41 },
	[2] = { ['model'] = "a_m_o_acult_02", ['hash'] = 0x4BA14CCA },
	[3] = { ['model'] = "a_m_m_afriamer_01", ['hash'] = 0xD172497E },
	[4] = { ['model'] = "ig_mp_agent14", ['hash'] = 0xFBF98469 },
	[5] = { ['model'] = "u_m_m_aldinapoli", ['hash'] = 0xF0EC56E2 },
	[6] = { ['model'] = "ig_amandatownley", ['hash'] = 0x6D1E15F7 },
	[7] = { ['model'] = "ig_andreas", ['hash'] = 0x47E4EEA0 },
	[8] = { ['model'] = "csb_anita", ['hash'] = 0x0703F106 },
	[9] = { ['model'] = "u_m_y_antonb", ['hash'] = 0xCF623A2C },
	[10] = { ['model'] = "g_m_y_armgoon_02", ['hash'] = 0xC54E878A },
	[11] = { ['model'] = "ig_ashley", ['hash'] = 0x7EF440DB },
	[12] = { ['model'] = "s_m_m_autoshop_01", ['hash'] = 0x040EABE3 },
	[13] = { ['model'] = "g_m_y_ballaeast_01", ['hash'] = 0xF42EE883 },
	[14] = { ['model'] = "g_m_y_ballaorig_01", ['hash'] = 0x231AF63F },
	[15] = { ['model'] = "s_m_y_barman_01", ['hash'] = 0xE5A11106 },
	[16] = { ['model'] = "u_m_y_baygor", ['hash'] = 0x5244247D },
	[17] = { ['model'] = "a_m_o_beach_01", ['hash'] = 0x8427D398 },
	[18] = { ['model'] = "a_m_y_beachvesp_01", ['hash'] = 0x7E0961B8 },
	[19] = { ['model'] = "ig_bestmen", ['hash'] = 0x5746CD96 },
	[20] = { ['model'] = "a_f_y_bevhills_01", ['hash'] = 0x445AC854 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not emservico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 10 then
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,247,217,99,100,0,0,0,0)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA INICIAR O EXPEDIENTE",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(0,38) then
						emP.addGroup()
						emservico = true
						selecionado = math.random(#locs)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PASSAGEIRO ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if emservico then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehiclespeed = GetEntitySpeed(vehicle)*2.236936
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 50.0 and IsVehicleModel(vehicle,GetHashKey("taxi")) then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,247,217,99,100,1,0,0,1)
				if distance <= 2.5 then
					if IsControlJustPressed(0,38) and emP.checkPermission() and (GetEntityHeading(ped) >= locs[selecionado].h-20.0 and GetEntityHeading(ped) <= locs[selecionado].h+20.0) then
						RemoveBlip(blips)
						FreezeEntityPosition(vehicle,true)
						if DoesEntityExist(passageiro) then
							emP.checkPayment(payment)
							Citizen.Wait(3000)
							TaskLeaveVehicle(passageiro,vehicle,262144)
							TaskWanderStandard(passageiro,10.0,10)
							Citizen.Wait(1100)
							SetVehicleDoorShut(vehicle,3,0)
							Citizen.Wait(1000)
						end

						if checkped then
							local pmodel = math.random(#pedlist)
							modelRequest(pedlist[pmodel].model)

							passageiro = CreatePed(4,pedlist[pmodel].hash,locs[selecionado].xp,locs[selecionado].yp,locs[selecionado].zp,3374176,true,false)
							SetEntityInvincible(passageiro,true)
							TaskEnterVehicle(passageiro,vehicle,-1,2,1.0,1,0)
							checkped = false
							payment = 10
							lastpassageiro = passageiro
						else
							passageiro = nil
							checkped = true
							FreezeEntityPosition(vehicle,false)
						end

						lselecionado = selecionado
						while true do
							if lselecionado == selecionado then
								selecionado = math.random(#locs)
							else
								break
							end
							Citizen.Wait(1)
						end

						CriandoBlip(locs,selecionado)

						if DoesEntityExist(passageiro) then
							while true do
								Citizen.Wait(1)
								local x2,y2,z2 = table.unpack(GetEntityCoords(passageiro))
								if not IsPedSittingInVehicle(passageiro,vehicle) then
									DrawMarker(21,x2,y2,z2+1.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,75,0,130,50,1,0,0,1)
								end
								if IsPedSittingInVehicle(passageiro,vehicle) then
									FreezeEntityPosition(vehicle,false)
									break
								end
							end
						end
					end
				end
			end

			if IsEntityAVehicle(vehicle) and DoesEntityExist(passageiro) then
				if math.ceil(vehiclespeed) >= 71 and timers <= 0 and payment > 0 then
					timers = 5
					payment = payment - 1
				end
			end

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TIMERS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emservico then
			if timers > 0 then
				timers = timers - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REMOVER NPCS ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function removePeds()
	SetTimeout(20000,function()
		if emservico and lastpassageiro and passageiro == nil then
			TriggerServerEvent("trydeleteped",PedToNet(lastpassageiro))
			TriggerEvent("Notify","sucesso","TEST")
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CANCELAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if emservico then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if IsControlJustPressed(0,168) then
				RemoveBlip(blips)
				if DoesEntityExist(passageiro) then
					TaskLeaveVehicle(passageiro,vehicle,262144)
					TaskWanderStandard(passageiro,10.0,10)
					Citizen.Wait(1100)
					SetVehicleDoorShut(vehicle,3,0)
					FreezeEntityPosition(vehicle,false)					
				end
				blips = nil
				selecionado = 0
				passageiro = nil
				checkped = true
				emservico = false
				emP.removeGroup()
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TAXíMETRO ]--------------------------------------------------------------------------------------------------------------------------
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
        DecorSetFloat(veh, "bandeiras", _bandeira + Custobandeira)
      end
      DecorSetFloat(veh, "kilometros", _kilometros + round(GetEntitySpeed(veh) * 0.000621371, 5))
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
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(10)
	end
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Corrida de Taxista")
	EndTextCommandSetBlipName(blips)
end