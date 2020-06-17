local menuactive = false
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
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "c-machado" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_BATTLEAXE")
	elseif data == "c-canivete" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_SWITCHBLADE")
	elseif data == "c-paraquedas" then
		TriggerServerEvent("departamento-comprar","wbody|GADGET_PARACHUTE")
	elseif data == "c-faca" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_KNIFE")
	elseif data == "c-lanterna" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_FLASHLIGHT")
	elseif data == "c-adaga" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_DAGGER")
	elseif data == "c-socoingles" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_KNUCKLE")
	elseif data == "c-machete" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_MACHETE")
	elseif data == "c-grifo" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_WRENCH")
	elseif data == "c-golf" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_GOLFCLUB")
	elseif data == "c-crbar" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_CROWBAR")
	elseif data == "c-sinuca" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_GOLFCLUB")
	elseif data == "c-dmachado" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_HATCHET")
	elseif data == "c-taco" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_BAT")
	elseif data == "c-garrafa" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_BOTTLE")
	elseif data == "c-pedra" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_STONE_HATCHET")
	elseif data == "c-flare" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_FLARE")
	elseif data == "c-glock" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_COMBATPISTOL")
	elseif data == "c-mglock" then
		TriggerServerEvent("departamento-comprar","wammo|WEAPON_COMBATPISTOL")
	elseif data == "c-martelo" then
		TriggerServerEvent("departamento-comprar","wbody|WEAPON_HAMMER")
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local lojas = {
	{ ['x'] = 22.65, ['y'] = -1106.97, ['z'] = 29.8 },
	{ ['x'] = 809.56, ['y'] = -2157.66, ['z'] = 29.62 },
	{ ['x'] = 1693.71, ['y'] = 3760.54, ['z'] = 34.71 },
	{ ['x'] = 252.31, ['y'] = -50.68, ['z'] = 69.95 },
	{ ['x'] = 841.75, ['y'] = -1033.94, ['z'] = 28.2},
	{ ['x'] = -330.19, ['y'] = 6084.47, ['z'] = 31.46 },
	{ ['x'] = -661.63, ['y'] = -934.93, ['z'] = 21.83 },
	{ ['x'] = -1305.6, ['y'] = -394.94, ['z'] = 36.7 },
	{ ['x'] = -1117.58, ['y'] = 2699.19, ['z'] = 18.56 },
	{ ['x'] = 2567.29, ['y'] = 293.96, ['z'] = 108.74 },
	{ ['x'] = -3172.03, ['y'] = 1088.45, ['z'] = 20.84 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)

		for k,v in pairs(lojas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lojas.x, lojas.y, lojas.z, true ) <= 2 then
				DrawText3D(lojas.x, lojas.y, lojas.z, "[~b~E~w~] Para acessar ~b~AMMUNATION~w~.")
			end
			
			if distance <= 15 then
				DrawMarker(23, lojas.x, lojas.y, lojas.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 101, 212, 255, 150, 0, 0, 0, 0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
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