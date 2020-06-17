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
	if data == "bronze" then
		TriggerServerEvent("minerador-crafting","bronze")
	elseif data == "ferro" then
		TriggerServerEvent("minerador-crafting","ferro")
	elseif data == "ouro" then
		TriggerServerEvent("minerador-crafting","ouro")
	elseif data == "rubi" then
		TriggerServerEvent("minerador-crafting","rubi")
	elseif data == "esmeralda" then
		TriggerServerEvent("minerador-crafting","esmeralda")
	elseif data == "safira" then
		TriggerServerEvent("minerador-crafting","safira")
	elseif data == "diamante" then
		TriggerServerEvent("minerador-crafting","diamante")
	elseif data == "topazio" then
		TriggerServerEvent("minerador-crafting","topazio")
	elseif data == "ametista" then
		TriggerServerEvent("minerador-crafting","ametista")


	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1076.24,-1978.98,31.48,true)
		if distance <= 3 then
			DrawMarker(23,1076.24,-1978.98,31.48-0.98,0,0,0,0,0,0,1.0,1.0,0.5,247,217,99,100,0,0,0,0)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)