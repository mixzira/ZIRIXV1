local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Resg = Tunnel.getInterface("nav_uniforme-medico")

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
	if data == "direcao" then
		TriggerServerEvent("direcao")
	
	elseif data == "medico" then
		TriggerServerEvent("medico")

	elseif data == "paramedico" then
		TriggerServerEvent("paramedico")

	elseif data == "socorrista" then
		TriggerServerEvent("socorrista")

	elseif data == "enfermeiro" then
		TriggerServerEvent("enfermeiro")

	elseif data == "tirar-uniforme" then
		TriggerServerEvent("tirar-uniforme")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armarios = {
	{ ['x'] = 340.53, ['y'] = -582.47, ['z'] = 28.92 },
	{ ['x'] = 314.33, ['y'] = -603.03, ['z'] = 43.3 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)

		for k,v in pairs(armarios) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local armarios = armarios[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), armarios.x, armarios.y, armarios.z, true ) <= 2 then
				DrawText3D(armarios.x, armarios.y, armarios.z, "[~g~E~w~] Para acessar o ~g~armário de uniformes~w~.")
			end
			
			if distance <= 30 then
				DrawMarker(23,armarios.x,armarios.y,armarios.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and Resg.checkPermissao() then
						ToggleActionMenu()
					end
				end
			end
		end
	end
end)

function DrawText3D(x,y,z, text)
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