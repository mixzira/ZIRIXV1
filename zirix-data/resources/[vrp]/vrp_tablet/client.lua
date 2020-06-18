local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local menuEnabled = false
function ToggleActionMenu()
	menuEnabled = not menuEnabled
	if menuEnabled then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false,false)
		SendNUIMessage({ hidemenu = true })
		vRP._DeletarObjeto()
		vRP._stopAnim(false)
	end
end

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "exit" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,56) then
			ToggleActionMenu()
			vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
		end
	end
end)