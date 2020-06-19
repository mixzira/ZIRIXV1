local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("emp_lenhador-entregas")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local quantidade = 0
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local CoordenadaX = -577.1
local CoordenadaY = 5250.92
local CoordenadaZ = 70.55
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local toralocs = {
    [1] = { ['x'] = 1304.67, ['y'] = -735.31, ['z'] = 64.84 },
    [2] = { ['x'] = -1129.48, ['y'] = -953.32, ['z'] = 6.63 },
    [3] = { ['x'] = 1561.41, ['y'] = -1693.56, ['z'] = 89.21 },
    [4] = { ['x'] = 557.64, ['y'] = -2328.00, ['z'] = 5.82 },
    [5] = { ['x'] = -1097.71, ['y'] = -1649.72, ['z'] = 4.39 },
    [6] = { ['x'] = -2016.37, ['y'] = 559.32, ['z'] = 108.30 },
    [7] = { ['x'] = -663.58, ['y'] = 222.33, ['z'] = 81.95 },
    [8] = { ['x'] = 141.28, ['y'] = -379.58, ['z'] = 43.25 },
    [9] = { ['x'] = 23.99, ['y'] = -619.81, ['z'] = 35.34 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 70 and IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("pounder")) then
				DrawMarker(39,CoordenadaX,CoordenadaY,CoordenadaZ-0.20,0,0,0,0,0.0,130.0,2.0,2.0,2.0,247,217,99,100,1,0,0,1)
				idle = 5
				if distance <= 9 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA INICIAR AS ENTREGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = 1
						CriandoBlip(toralocs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ENTREGAS ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(toralocs[selecionado].x,toralocs[selecionado].y,toralocs[selecionado].z)
			local distance = GetDistanceBetweenCoords(toralocs[selecionado].x,toralocs[selecionado].y,cdz,x,y,z,true)
			local vehicle = GetPlayersLastVehicle()

			if distance <= 30 and GetEntityModel(vehicle) == GetHashKey("pounder") and not IsPedInAnyVehicle(ped) then
				DrawMarker(21,toralocs[selecionado].x,toralocs[selecionado].y,toralocs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,247,217,99,100,1,0,0,1)
				idle = 5
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA ENTREGAR AS TORAS",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if func.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(9)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Toras</b>.")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CANCELAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servico then
			idle = 5
			if IsControlJustPressed(0,121) then
				TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Toras</b>.")
			elseif IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ STATUS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("quantidade-tora")
AddEventHandler("quantidade-tora",function(status)
    quantidade = status
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

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(toralocs[selecionado].x,toralocs[selecionado].y,toralocs[selecionado].z)
	SetBlipSprite(blips,85)
	SetBlipColour(blips,31)
	SetBlipScale(blips,0.9)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Toras")
	EndTextCommandSetBlipName(blips)
end