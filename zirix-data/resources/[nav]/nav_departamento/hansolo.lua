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
	if data == "comprar-sanduiche" then
		TriggerServerEvent("departamento-comprar","sanduiche")

	elseif data == "comprar-rosquinha" then
		TriggerServerEvent("departamento-comprar","rosquinha")

	elseif data == "comprar-hotdog" then
		TriggerServerEvent("departamento-comprar","hotdog")

	elseif data == "comprar-xburguer" then
		TriggerServerEvent("departamento-comprar","xburguer")

	elseif data == "comprar-chips" then
		TriggerServerEvent("departamento-comprar","chips")

	elseif data == "comprar-batataf" then
		TriggerServerEvent("departamento-comprar","batataf")

	elseif data == "comprar-pizza" then
		TriggerServerEvent("departamento-comprar","pizza")

	elseif data == "comprar-tacos" then
		TriggerServerEvent("departamento-comprar","taco")

	elseif data == "comprar-agua" then
		TriggerServerEvent("departamento-comprar","agua")

	elseif data == "comprar-cola" then
		TriggerServerEvent("departamento-comprar","cola")

	elseif data == "comprar-sprunk" then
		TriggerServerEvent("departamento-comprar","sprunk")

	elseif data == "comprar-energetico" then
		TriggerServerEvent("departamento-comprar","energetico")

	elseif data == "comprar-leite" then
		TriggerServerEvent("departamento-comprar","leite")

	elseif data == "comprar-barracho" then
		TriggerServerEvent("departamento-comprar","barracho")

	elseif data == "comprar-patriot" then
		TriggerServerEvent("departamento-comprar","patriot")

	elseif data == "comprar-pibwassen" then
		TriggerServerEvent("departamento-comprar","pibwassen")
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local lojas = {
	{ ['x'] = 25.75, ['y'] = -1345.5, ['z'] = 29.5 },
	{ ['x'] = -48.42, ['y'] = -1757.87, ['z'] = 29.43 },
	{ ['x'] = -707.42, ['y'] = -914.59, ['z'] = 19.22 },
	{ ['x'] = -1222.27, ['y'] = -906.59, ['z'] = 12.33 },
	{ ['x'] = -1487.7, ['y'] = -378.6, ['z'] = 40.17 },
	{ ['x'] = 1163.61, ['y'] = -323.94, ['z'] = 69.21 },
	{ ['x'] = 374.21, ['y'] = 327.8, ['z'] = 103.57 },
	{ ['x'] = 2555.58, ['y'] = 382.11, ['z'] = 108.63 },
	{ ['x'] = -2967.83, ['y'] = 391.63, ['z'] = 15.05 },
	{ ['x'] = -3041.04, ['y'] = 585.14, ['z'] = 7.91 },
	{ ['x'] = -3243.91, ['y'] = 1001.32, ['z'] = 12.84 },
	{ ['x'] = 548.13, ['y'] = 2669.47, ['z'] = 42.16 },
	{ ['x'] = 1165.35, ['y'] = 2709.39, ['z'] = 38.16 },
	{ ['x'] = 1960.23, ['y'] = 3742.13, ['z'] = 32.35 },
	{ ['x'] = 1697.98, ['y'] = 4924.48, ['z'] = 42.07 },
	{ ['x'] = 2677.09, ['y'] = 3281.33, ['z'] = 55.25 },
	{ ['x'] = 1729.77, ['y'] = 6416.24, ['z'] = 35.04 }
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
				DrawText3D(lojas.x, lojas.y, lojas.z, "[~b~E~w~] Para acessar a ~b~LOJA DE CONVENIÊNCIAS~w~.")
			end
			
			if distance <= 15 then
				DrawMarker(23, lojas.x, lojas.y, lojas.z-0.96, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 101, 212, 255, 150, 0, 0, 0, 0) 
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