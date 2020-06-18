-----------------------------------------------------------------------------------------------------------------------------------------
--[ DISPATCH ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESABILITAR X NA MOTO ]--------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
				DisableControlAction(0,73,true) 
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESABILITAR A CORONHADA ]------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsPedArmed(ped,6) then
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO ]---------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local speed = GetEntitySpeed(vehicle)*2.236936
				if speed >= 40 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESATIVA O CONTROLE DO CARRO ENQUANTO ESTIVER NO AR ]--------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABicycle(model) and not IsThisModelABike(model) and not IsThisModelAQuadbike(model) and IsEntityInAir(veh) then
                DisableControlAction(0,59)
                DisableControlAction(0,60)
                --DisableControlAction(0,73)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ESTOURAR OS PNEUS ]------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local speed = GetEntitySpeed(vehicle)*2.236936
                if speed >= 180 and math.random(100) >= 97 then
                    if GetVehicleTyresCanBurst(vehicle) == false then return end
                    local pneus = GetVehicleNumberOfWheels(vehicle)
                    local pneusEffects
                    if pneus == 2 then
                        pneusEffects = (math.random(2)-1)*4
                    elseif pneus == 4 then
                        pneusEffects = (math.random(4)-1)
                        if pneusEffects > 1 then
                            pneusEffects = pneusEffects + 2
                        end
                    elseif pneus == 6 then
                        pneusEffects = (math.random(6)-1)
                    else
                        pneusEffects = 0
                    end
                    SetVehicleTyreBurst(vehicle,pneusEffects,false,1000.0)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DRIFT ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			local speed = GetEntitySpeed(vehicle)*2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped 
				and (GetEntityModel(vehicle) ~= GetHashKey("coach") 
					and GetEntityModel(vehicle) ~= GetHashKey("bus") 
					and GetEntityModel(vehicle) ~= GetHashKey("youga2") 
					and GetEntityModel(vehicle) ~= GetHashKey("ratloader") 
					and GetEntityModel(vehicle) ~= GetHashKey("taxi") 
					and GetEntityModel(vehicle) ~= GetHashKey("boxville4") 
					and GetEntityModel(vehicle) ~= GetHashKey("trash2") 
					and GetEntityModel(vehicle) ~= GetHashKey("tiptruck") 
					and GetEntityModel(vehicle) ~= GetHashKey("rebel") 
					and GetEntityModel(vehicle) ~= GetHashKey("speedo") 
					and GetEntityModel(vehicle) ~= GetHashKey("phantom") 
					and GetEntityModel(vehicle) ~= GetHashKey("packer") 
					and GetEntityModel(vehicle) ~= GetHashKey("paramedicoambu")) then
					if speed <= 100.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end    
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLIPS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TASERTIME ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			SetPedToRagdoll(ped,10000,10000,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			SetTimeout(5000,function()
				SetTimecycleModifier("hud_def_desat_Trevor")
				SetTimeout(10000,function()
					SetTimecycleModifier("")
					SetTransitionTimecycleModifier("")
					StopGameplayCamShaking()
				end)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLACKOUT ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local isBlackout = false
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
			local currentSpeed = GetEntitySpeed(vehicle)*2.236936
			if currentSpeed ~= oldSpeed then
				if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
					blackout()
				end
				oldSpeed = currentSpeed
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		if isBlackout then
			DisableControlAction(0,63,true)
			DisableControlAction(0,64,true)
			DisableControlAction(0,71,true)
			DisableControlAction(0,72,true)
			DisableControlAction(0,75,true)
		end
	end
end)

function blackout()
	TriggerEvent("vrp_sound:source",'heartbeat',0.5)
	if not isBlackout then
		isBlackout = true
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-200)
		Citizen.CreateThread(function()
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end
			Citizen.Wait(5000)
			DoScreenFadeIn(5000)
			isBlackout = false
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DAMAGE WALK MODE ]-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local hurt = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) then
			if GetEntityHealth(ped) <= 199 then
				setHurt()
			elseif hurt and GetEntityHealth(ped) > 200 then
				setNotHurt()
			end
		end
	end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(),"move_m@injured",true)
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	DisableControlAction(0,21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COOLDOWN BUNNYHOP ]------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyhop = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedJumping(ped) and bunnyhop <= 0 then
            bunnyhop = 5
        end
        if bunnyhop > 0 then
            DisableControlAction(0,22,true)
        end
        Citizen.Wait(5)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FALL WHILE RUNING AND JUMPING
-----------------------------------------------------------------------------------------------------------------------------------------
--[[local ragdoll_chance = 0.99
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			if chance_result < ragdoll_chance then
				Citizen.Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE',0.5)
				SetPedToRagdoll(ped,5000,1,2)
			else
				Citizen.Wait(2000)
			end
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALK SHAKE
-----------------------------------------------------------------------------------------------------------------------------------------
--[[playerMoving = false
Citizen.CreateThread(function()
	while true do 
		Wait(1)
		if not IsPedInAnyVehicle(PlayerPedId(), false) and GetEntitySpeed(PlayerPedId()) >= 0.5 and GetFollowPedCamViewMode() ~= 4 then
			if playerMoving == false then
				ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)
				playerMoving = true
			end
		else
			if playerMoving == true then
				StopGameplayCamShaking(false)
				playerMoving = false
			end
		end
	end
end)]]