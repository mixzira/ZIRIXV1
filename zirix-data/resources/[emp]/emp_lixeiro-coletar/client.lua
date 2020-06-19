local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_lixeiro-coletar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = -358.07
local CoordenadaY = -1561.77
local CoordenadaZ = 25.2
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -364.39, ['y'] = -1864.58, ['z'] = 20.24 },
	[2] = { ['x'] = 119.92, ['y'] = -2049.79, ['z'] = 18.00 },
	[3] = { ['x'] = 140.51, ['y'] = -1876.13, ['z'] = 23.52 },
	[4] = { ['x'] = 159.26, ['y'] = -1814.52, ['z'] = 28.13 },
	[5] = { ['x'] = 241.46, ['y'] = -1944.45, ['z'] = 23.12 },
	[6] = { ['x'] = 447.58, ['y'] = -1936.93, ['z'] = 24.31 },
	[7] = { ['x'] = 487.06, ['y'] = -1515.02, ['z'] = 29.00 },
	[8] = { ['x'] = 419.46, ['y'] = -1526.35, ['z'] = 28.99 },
	[9] = { ['x'] = 266.11, ['y'] = -1493.93, ['z'] = 28.92 },
	[10] = { ['x'] = 120.39, ['y'] = -1545.78, ['z'] = 28.95 },
	[11] = { ['x'] = 136.37, ['y'] = -1369.56, ['z'] = 28.95 },
	[12] = { ['x'] = -13.08, ['y'] = -1388.95, ['z'] = 29.10 },
	[13] = { ['x'] = 482.05, ['y'] = -1279.73, ['z'] = 29.25 },
	[14] = { ['x'] = 430.18, ['y'] = -1066.45, ['z'] = 28.92 },
	[15] = { ['x'] = 305.60, ['y'] = -1038.61, ['z'] = 28.89 },
	[16] = { ['x'] = 241.49, ['y'] = -831.53, ['z'] = 29.62 },
	[17] = { ['x'] = 18.98, ['y'] = -544.66, ['z'] = 36.34 },
	[18] = { ['x'] = 7.39, ['y'] = -366.43, ['z'] = 40.23 },
	[19] = { ['x'] = 303.37, ['y'] = -259.79, ['z'] = 53.67 },
	[20] = { ['x'] = 973.44, ['y'] = -158.95, ['z'] = 73.09 },
	[21] = { ['x'] = 921.25, ['y'] = 47.69, ['z'] = 80.48 },
	[22] = { ['x'] = 916.12, ['y'] = -194.66, ['z'] = 72.63 },
	[23] = { ['x'] = 587.96, ['y'] = 67.51, ['z'] = 93.18 },
	[24] = { ['x'] = 312.00, ['y'] = 329.08, ['z'] = 105.16 },
	[25] = { ['x'] = -381.52, ['y'] = 289.96, ['z'] = 84.55 },
	[26] = { ['x'] = -601.73, ['y'] = 270.61, ['z'] = 81.69 },
	[27] = { ['x'] = -1239.73, ['y'] = 405.86, ['z'] = 75.35 },
	[28] = { ['x'] = -1772.09, ['y'] = -478.61, ['z'] = 39.42 },
	[29] = { ['x'] = -1977.30, ['y'] = -488.59, ['z'] = 11.45 },
	[30] = { ['x'] = -1320.02, ['y'] = -1216.42, ['z'] = 4.49 },
	[31] = { ['x'] = -1208.72, ['y'] = -1411.40, ['z'] = 3.89 },
	[32] = { ['x'] = -1111.55, ['y'] = -1549.99, ['z'] = 4.08 },
	[33] = { ['x'] = -574.54, ['y'] = -857.53, ['z'] = 25.97 },
	[34] = { ['x'] = -352.88, ['y'] = -959.45, ['z'] = 30.79 },
	[35] = { ['x'] = 49.47, ['y'] = -1240.88, ['z'] = 28.94 },
	[36] = { ['x'] = -148.22, ['y'] = -1296.49, ['z'] = 30.78 },
	[37] = { ['x'] = -333.68, ['y'] = -1366.33, ['z'] = 31.01 },
	[38] = { ['x'] = -303.08, ['y'] = -1538.89, ['z'] = 26.32 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 15 and IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("trash2")) then
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,247,217,99,100,0,0,0,0)
				if distance <= 9 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA INICIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,247,217,99,100,1,0,0,1)
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA COLETAR OS SACOS DE LIXO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("trash")) or IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("trash2")) then
							if emP.checkPayment() then
								RemoveBlip(blips)
								if selecionado == #locs then
									selecionado = 1
								else
									selecionado = selecionado + 1
								end
								CriandoBlip(locs,selecionado)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
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
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Lixo")
	EndTextCommandSetBlipName(blips)
end