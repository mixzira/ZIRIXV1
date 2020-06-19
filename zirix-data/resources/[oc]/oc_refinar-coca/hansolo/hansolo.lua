----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

farM = Tunnel.getInterface("oc_refinar-coca")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local refinMachine = {
    { ['x'] = -1104.51, ['y'] = 4945.47, ['z'] = 218.65 }
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
	if data == "refinar-hQCoca" then
		TriggerServerEvent("refinar-hQCoca")
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "refinar-mQCoca" then
		TriggerServerEvent("refinar-mQCoca")
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

RegisterNetEvent("refin_coca:posicao")
AddEventHandler("refin_coca:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 252.3)
	SetEntityCoords(ped, -1104.45, 4945.45, 218.65-1,false,false,false,false)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000

		for k,v in pairs(refinMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local refinMachine = refinMachine[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), refinMachine.x, refinMachine.y, refinMachine.z, true ) < 1.2 then
				DrawText3D(refinMachine.x, refinMachine.y, refinMachine.z, "Pressione [~r~E~w~] para acessar a ~g~Refinaria~w~.")
			end
			
			if distance <= 1.2 then
				idle = 5
				if IsControlJustPressed(0,38) and farM.checkPermissao() then
					ToggleActionMenu()	
				end
			end
		end
		Citizen.Wait(idle)
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