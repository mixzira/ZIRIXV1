-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local gates = {}

RegisterNetEvent('vrpgatesystem:load')
AddEventHandler('vrpgatesystem:load',function(list)
	gates = list
end)

RegisterNetEvent('vrpgatesystem:statusSend')
AddEventHandler('vrpgatesystem:statusSend',function(i,status)
	if i ~= nil and status ~= nil then
		gates[i].lock = status
	end
end)

function searchIdgate()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	for k,v in pairs(gates) do
		if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 15 then
			return k
		end
	end
	return 0
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,38) then
			local id = searchIdgate()
			if id ~= 0 then
				vRP._playAnim(true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
				TriggerServerEvent("vrpgatesystem:open",id)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		for k,v in pairs(gates) do
			if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 12 then
				local gate = GetClosestObjectOfType(v.x,v.y,v.z,1.0,v.hash,false,false,false)
				if gate ~= 0 then
					SetEntityCanBeDamaged(gate,false)
					if v.lock == false then
						if v.text then
							DrawText3Ds(v.x,v.y,v.z+0.2,"~g~E ~w~  FECHAR")
						end
						NetworkRequestControlOfEntity(gate)
						FreezeEntityPosition(gate,false)
					else
						local lock,heading = GetStateOfClosestDoorOfType(v.hash,v.x,v.y,v.z,lock,heading)
						if heading > -0.02 and heading < 0.02 then
							if v.text then
								DrawText3Ds(v.x,v.y,v.z+0.2,"~g~E ~w~  ABRIR")
							end
							NetworkRequestControlOfEntity(gate)
							FreezeEntityPosition(gate,true)
						end
					end
				end
			end
		end
	end
end)

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end