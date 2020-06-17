Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPedJumping(PlayerPedId()) and IsControlJustReleased(0,51) then
			if not IsPedInAnyVehicle(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				local Tackled = {}

				SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-50)
				SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

				while IsPedRagdoll(PlayerPedId()) do
					Citizen.Wait(1)
					for Key,Value in ipairs(GetTouchedPlayers()) do
						if not Tackled[Value] then
							Tackled[Value] = true
							TriggerServerEvent('Tackle:Server:TacklePlayer',GetPlayerServerId(Value),ForwardVector.x,ForwardVector.y,ForwardVector.z,GetPlayerName(PlayerId()))
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer',function(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	SetPedToRagdollWithFall(PlayerPedId(),1500,1500,0,ForwardVectorX,ForwardVectorY,ForwardVectorZ,10.0,0.0,0.0,0.0,0.0,0.0,0.0)
end)

function GetPlayers()
    local Players = {}
    for i = 0,256 do
        if NetworkIsPlayerActive(i) then
            table.insert(Players,i)
        end
    end
    return Players
end

function GetTouchedPlayers()
    local TouchedPlayer = {}
    for Key,Value in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(),GetPlayerPed(Value)) then
			table.insert(TouchedPlayer,Value)
		end
    end
    return TouchedPlayer
end