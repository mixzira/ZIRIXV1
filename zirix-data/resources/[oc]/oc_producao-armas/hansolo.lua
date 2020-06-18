local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-armas")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 1405.96, ['y'] = 1137.89, ['z'] = 109.75 },
	{ ['x'] = 613.4, ['y'] = -3092.7, ['z'] = 6.07 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-ak47" then
		TriggerServerEvent("produzir-arma","ak47")

	elseif data == "produzir-ak74u" then
		TriggerServerEvent("produzir-arma","ak74u")

	elseif data == "produzir-uzi" then
		TriggerServerEvent("produzir-arma","uzi")

	elseif data == "produzir-magnum44" then
		TriggerServerEvent("produzir-arma","magnum44")

	elseif data == "produzir-glock" then
		TriggerServerEvent("produzir-arma","glock")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)


RegisterNetEvent("fechar-nui")
AddEventHandler("fechar-nui", function()
	ToggleActionMenu()
	onmenu = false

	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(613.46, -3092.73, 6.07)
	local distance = GetDistanceBetweenCoords(613.46, -3092.73, cdz, x, y, z, true)

	if distance < 3.2 then
		TriggerEvent("armas:posicao1")	
	else
		TriggerEvent("armas:posicao2")
	end
end)

RegisterNetEvent("armas:posicao1")
AddEventHandler("armas:posicao1", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 273.79)
	SetEntityCoords(ped, 613.46, -3092.73, 6.07-0.95, false, false, false, false)
end)

RegisterNetEvent("armas:posicao2")
AddEventHandler("armas:posicao2", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 277.23)
	SetEntityCoords(ped, 1405.92, 1137.83, 109.75-0.95, false, false, false, false)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]
			local idBancada = prodMachine[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) <= 1 and not onmenu then
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~BANCADA DE ARMAS~w~.")
			end
			if distance <= 15 then
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
						ToggleActionMenu()
						onmenu = true
					end
				end
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end