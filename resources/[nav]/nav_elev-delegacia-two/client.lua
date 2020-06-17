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
	local ped = GetPlayerPed(-1)
	if data == "segundo-andar" then
		DoScreenFadeOut(1000)
		menuactive = false
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		SetTimeout(1400,function()
			SetEntityCoords(PlayerPedId(),-1066.26,-833.51,27.04-0.50)
			SetEntityHeading(ped,28.27)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			Citizen.Wait(750)
			DoScreenFadeIn(1000)
		end)
		

	elseif data == "terreo" then
		DoScreenFadeOut(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		SetTimeout(1400,function()
			SetEntityCoords(PlayerPedId(),-1065.93,-833.71,19.04-0.50)
			SetEntityHeading(ped,28.27)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			Citizen.Wait(750)
			DoScreenFadeIn(1000)
		end)

	elseif data == "menos-um" then
		DoScreenFadeOut(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		SetTimeout(1400,function()
			SetEntityCoords(PlayerPedId(),-1065.93,-833.71,14.89-0.50)
			SetEntityHeading(ped,28.27)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			Citizen.Wait(750)
			DoScreenFadeIn(1000)
		end)

	elseif data == "menos-dois" then
		DoScreenFadeOut(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		SetTimeout(1400,function()
			SetEntityCoords(PlayerPedId(),-1065.97,-833.91,11.04-0.50)
			SetEntityHeading(ped,28.27)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			Citizen.Wait(750)
			DoScreenFadeIn(1000)
		end)

	elseif data == "menos-tres" then
		DoScreenFadeOut(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		SetTimeout(1400,function()
			SetEntityCoords(PlayerPedId(),-1065.89,-833.87,5.48-0.50)
			SetEntityHeading(ped,28.27)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			Citizen.Wait(750)
			DoScreenFadeIn(1000)
		end)

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local elevador = {
	{ ['x'] = -1066.26, ['y'] = -833.51, ['z'] = 27.04 }, -- 2º Andar;
	{ ['x'] = -1065.93, ['y'] = -833.71, ['z'] = 19.04 }, -- Térreo;
	{ ['x'] = -1065.93, ['y'] = -833.71, ['z'] = 14.89 }, -- -1;
	{ ['x'] = -1065.97, ['y'] = -833.91, ['z'] = 11.04 }, -- -2;
	{ ['x'] = -1065.89, ['y'] = -833.87, ['z'] = 5.48 }, -- -3;
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)

		for k,v in pairs(elevador) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local elev = elevador[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), elev.x, elev.y, elev.z, true ) <= 2 then
				DrawText3D(elev.x, elev.y, elev.z, "[~g~E~w~] Para acessar o elevador")
			end
			
			if distance <= 10 then
				DrawMarker(23,elev.x,elev.y,elev.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
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