local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Perm = Tunnel.getInterface("oc_refinar-meta")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local refinMachine = {
    { ['x'] = 1499.19, ['y'] = 6392.57, ['z'] = 20.79 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "refinar-hQMeta" then
		TriggerServerEvent("refinar-hQMeta")
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "refinar-mQMeta" then
		TriggerServerEvent("refinar-mQMeta")
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

RegisterNetEvent("refin_metaa:posicao")
AddEventHandler("refin_metaa:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 167.7)
	SetEntityCoords(ped, 1499.19,6392.57,20.78,false,false,false,false)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		for k,v in pairs(refinMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local refinMachine = refinMachine[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), refinMachine.x, refinMachine.y, refinMachine.z, true ) <= 2 then
				DrawText3D(refinMachine.x, refinMachine.y, refinMachine.z, "[~r~E~w~] Para acessar a ~g~Refinaria~w~.")
			end
			
			if distance <= 15 then
				DrawMarker(23, refinMachine.x, refinMachine.y, refinMachine.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and Perm.checkPermissao() then
						ToggleActionMenu()
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