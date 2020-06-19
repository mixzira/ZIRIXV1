local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local doors = {}

RegisterNetEvent('vrpdoorsystem:load')
AddEventHandler('vrpdoorsystem:load',function(list)
	doors = list
end)

RegisterNetEvent('vrpdoorsystem:statusSend')
AddEventHandler('vrpdoorsystem:statusSend',function(i,status)
	if i ~= nil and status ~= nil then
		doors[i].lock = status
	end
end)

function searchIdDoor()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	for k,v in pairs(doors) do
		if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 1.5 then
			return k
		end
	end
	return 0
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,38) then
			local id = searchIdDoor()
			if id ~= 0 then
				vRP._playAnim(true,{{"veh@mower@base","start_engine"}},false)
				Citizen.Wait(2200)
				TriggerServerEvent("vrpdoorsystem:open",id)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		for k,v in pairs(doors) do
			if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) < 3 then
				idle = 5
				local door = GetClosestObjectOfType(v.x,v.y,v.z,1.0,v.hash,false,false,false)
				if door ~= 0 then
					SetEntityCanBeDamaged(door,false)
					if v.lock == false then
						if v.text then
							DrawText3Ds(v.x,v.y,v.z+0.2,"[~g~E~w~]  FECHAR")
						end
						NetworkRequestControlOfEntity(door)
						FreezeEntityPosition(door,false)
					else
						local lock,heading = GetStateOfClosestDoorOfType(v.hash,v.x,v.y,v.z,lock,heading)
						if heading > -0.02 and heading < 0.02 then
							if v.text then
								DrawText3Ds(v.x,v.y,v.z+0.2,"[~g~E~w~]  ABRIR")
							end
							NetworkRequestControlOfEntity(door)
							FreezeEntityPosition(door,true)
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
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