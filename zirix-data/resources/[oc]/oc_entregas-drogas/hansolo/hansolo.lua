----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
oC = Tunnel.getInterface("oc_entregas-drogas")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local emprocesso = false
local segundos = 0
local selecionado = 0
local quantidade = 0
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local CoordenadaX = 2332.63
local CoordenadaY = 4856.33
local CoordenadaZ = 41.81
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
    [1] = { ['x'] = -14.09, ['y'] = -1442.08, ['z'] = 31.11 },
    [2] = { ['x'] = 152.58, ['y'] = -1823.7, ['z'] = 27.87 }, 
    [3] = { ['x'] = 282.63, ['y'] = -1899.0, ['z'] = 27.27 },
    [4] = { ['x'] = 399.46, ['y'] = -1864.94, ['z'] = 26.72 }, 
    [5] = { ['x'] = 443.45, ['y'] = -1707.33, ['z'] = 29.71 },
    [6] = { ['x'] = 269.6, ['y'] = -1712.98, ['z'] = 29.67 }, 
    [7] = { ['x'] = 216.41, ['y'] = -1717.29, ['z'] = 29.68 }, 
    [8] = { ['x'] = 1295.05, ['y'] = -1739.69, ['z'] = 54.28 }, 
    [9] = { ['x'] = 1220.23, ['y'] = -1658.77, ['z'] = 48.65 }, 
    [10] = { ['x'] = 970.78, ['y'] = -701.16, ['z'] = 58.49 }, 
    [11] = { ['x'] = 1388.93, ['y'] = -569.47, ['z'] = 74.5 }, 
    [12] = { ['x'] = 1328.36, ['y'] = -536.0, ['z'] = 72.45 }, 
    [13] = { ['x'] = 1264.84, ['y'] = -702.83, ['z'] = 64.91 }, 
    [14] = { ['x'] = 965.3, ['y'] = -542.01, ['z'] = 59.73 }, 
    [15] = { ['x'] = 1028.86, ['y'] = -408.42, ['z'] = 66.35 }, 
    [16] = { ['x'] = 880.28, ['y'] = -205.45, ['z'] = 71.98 }, 
    [17] = { ['x'] = -106.84, ['y'] = -8.49, ['z'] = 70.53 }, 
    [18] = { ['x'] = -667.14, ['y'] = 471.54, ['z'] = 114.14 }, 
    [19] = { ['x'] = -1107.62, ['y'] = 594.52, ['z'] = 104.46 }, 
    [20] = { ['x'] = -1174.8, ['y'] = 440.15, ['z'] = 86.85 }, 
    [21] = { ['x'] = -1753.23, ['y'] = -724.21, ['z'] = 10.41 }, 
    [22] = { ['x'] = -1967.67, ['y'] = -531.77, ['z'] = 12.18 }, 
    [23] = { ['x'] = -1093.6, ['y'] = -1608.24, ['z'] = 8.46 }, 
    [24] = { ['x'] = -1995.67, ['y'] = 591.13, ['z'] = 117.91 }, 
    [25] = { ['x'] = -597.12, ['y'] = 851.67, ['z'] = 211.45 }, 
    [26] = { ['x'] = -1100.54, ['y'] = 2722.43, ['z'] = 18.81 }, 
    [27] = { ['x'] = 634.94, ['y'] = 2774.95, ['z'] = 42.02 }, 
    [28] = { ['x'] = 1142.33, ['y'] = 2654.7, ['z'] = 38.16 }, 
    [29] = { ['x'] = 106.23, ['y'] = -1280.82, ['z'] = 29.26 }, 
    [30] = { ['x'] = -833.35, ['y'] = -1071.59, ['z'] = 11.66 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tc",function(source,args)
	if not servico then
		if not emprocesso then
			emprocesso = true
			servico = true
			segundos = 900
			selecionado = math.random(30)
			CriandoBlip(locs,selecionado)
			oC.Quantidade()
			TriggerEvent("Notify","sucesso","Você entrou em serviço.")
			TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Drogas</b>.")
		else
			TriggerEvent("Notify","importante","Aguarde <b>"..segundos.." segundos</b> até acharmos outras entregas.")
		end
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
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 10 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,247,217,99,100,1,0,0,1)
				idle = 5
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA ENTREGAR AS DROGAS",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if oC.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(30)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Drogas</b>.")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emprocesso then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					emprocesso = false
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CANCELAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servico then
			local idle = 100
			if IsControlJustPressed(0,121) then
				TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Drogas</b>.")
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
RegisterNetEvent("quantidade-drogas")
AddEventHandler("quantidade-drogas",function(status)
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
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,207)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Drogas")
	EndTextCommandSetBlipName(blips)
end