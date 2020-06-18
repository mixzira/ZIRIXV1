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
	if data == "terreo" then
		DoScreenFadeOut(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		SetTimeout(1400,function()
			SetEntityCoords(PlayerPedId(),335.78,-580.24,28.91-0.50)
			SetEntityHeading(ped,345.62)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			Citizen.Wait(750)
			DoScreenFadeIn(1000)
		end)

	elseif data == "primeiro-andar" then
		DoScreenFadeOut(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		SetTimeout(1400,function()
			SetEntityCoords(PlayerPedId(),331.27,-592.8,43.29-0.50)
			SetEntityHeading(ped,345.62)
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
local elevadores = {
	{ ['x'] = 331.27, ['y'] = -592.8, ['z'] = 43.29 },
	{ ['x'] = 335.78, ['y'] = -580.24, ['z'] = 28.91 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)

		for k,v in pairs(elevadores) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local elev = elevadores[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), elev.x, elev.y, elev.z, true ) <= 2 then
				DrawText3D(elev.x, elev.y, elev.z, "[~g~E~w~] Para acessar o elevador")
			end
			
			if distance <= 30 then
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