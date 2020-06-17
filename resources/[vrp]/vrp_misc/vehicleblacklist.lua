blackVehicles = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		for k,v in pairs(blackVehicles) do
			local vehicle = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,999.0,GetHashKey(v),71)
			if IsEntityAVehicle(vehicle) and GetEntityModel(vehicle) == GetHashKey(v) then
				TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
			end
		end
	end
end)