
----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
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
		TriggerServerEvent("minerador-vender","bronze")
	elseif data == "ferro" then
		TriggerServerEvent("minerador-vender","ferro")
	elseif data == "ouro" then
		TriggerServerEvent("minerador-vender","ouro")
	elseif data == "rubi" then
		TriggerServerEvent("minerador-vender","rubi")
	elseif data == "esmeralda" then
		TriggerServerEvent("minerador-vender","esmeralda")
	elseif data == "safira" then
		TriggerServerEvent("minerador-vender","safira")
	elseif data == "diamante" then
		TriggerServerEvent("minerador-vender","diamante")
	elseif data == "topazio" then
		TriggerServerEvent("minerador-vender","topazio")
	elseif data == "ametista" then
		TriggerServerEvent("minerador-vender","ametista")


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
		local idle = 1000
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-623.67,-236.63,38.06,true)
		if distance <= 3 then
			DrawMarker(23,-623.67,-236.63,38.06-0.97,0,0,0,0,0,0,1.0,1.0,0.5,247,217,99,100,0,0,0,0)
			idle = 5
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(idle)
	end
end)