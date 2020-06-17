local pedInSameVehicleLast = false
local vehicle
local lastVehicle
local vehicleClass

local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0

local function isPedDrivingAVehicle()
	local ped = PlayerPedId()
	vehicle = GetVehiclePedIsIn(ped)
	if IsPedInAnyVehicle(ped) then
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local class = GetVehicleClass(vehicle)
			if class ~= 13 and class ~= 15 and class ~= 16 and class ~= 21 then
				return true
			end
		end
	end
	return false
end

local function fscale(inputValue,originalMin,originalMax,newBegin,newEnd,curve)
	local OriginalRange = 0.0
	local NewRange = 0.0
	local zeroRefCurVal = 0.0
	local normalizedCurVal = 0.0
	local rangedValue = 0.0
	local invFlag = 0

	if curve > 10.0 then
		curve = 10.0
	end

	if curve < -10.0 then
		curve = -10.0
	end

	curve = (curve * -.1)
	curve = 10.0 ^ curve

	if inputValue < originalMin then
		inputValue = originalMin
	end

	if inputValue > originalMax then
		inputValue = originalMax
	end

	OriginalRange = originalMax - originalMin

	if newEnd > newBegin then
		NewRange = newEnd - newBegin
	else
		NewRange = newBegin - newEnd
		invFlag = 1
	end

	zeroRefCurVal = inputValue - originalMin
	normalizedCurVal = zeroRefCurVal / OriginalRange

	if originalMin > originalMax then
		return 0
	end

	if invFlag == 0 then
		rangedValue = ((normalizedCurVal ^ curve) * NewRange) + newBegin
	else
		rangedValue = newBegin - ((normalizedCurVal ^ curve) * NewRange)
	end

	return rangedValue
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if pedInSameVehicleLast then
			local factor = 1.0
			if healthEngineNew < 900 then
				factor = (healthEngineNew+200.0) / 1100
			end
			SetVehicleEngineTorqueMultiplier(vehicle,factor)
		end

		local roll = GetEntityRoll(vehicle)
		if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
			DisableControlAction(2,59,true)
			DisableControlAction(2,60,true)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		local ped = PlayerPedId()
		if isPedDrivingAVehicle() then
			vehicle = GetVehiclePedIsIn(ped)
			vehicleClass = GetVehicleClass(vehicle)
			healthEngineCurrent = GetVehicleEngineHealth(vehicle)

			if healthEngineCurrent == 1000 then
				healthEngineLast = 1000.0
			end

			healthEngineNew = healthEngineCurrent
			healthEngineDelta = healthEngineLast - healthEngineCurrent
			healthEngineDeltaScaled = healthEngineDelta * 1.1 * cfg.classDamageMultiplier[vehicleClass]
			healthBodyCurrent = GetVehicleBodyHealth(vehicle)

			if healthBodyCurrent == 1000 then
				healthBodyLast = 1000.0
			end

			healthBodyNew = healthBodyCurrent
			healthBodyDelta = healthBodyLast - healthBodyCurrent
			healthBodyDeltaScaled = healthBodyDelta * 1.1 * cfg.classDamageMultiplier[vehicleClass]
			healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)

			if healthPetrolTankCurrent == 1000 then
				healthPetrolTankLast = 1000.0
			end

			healthPetrolTankNew = healthPetrolTankCurrent
			healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
			healthPetrolTankDeltaScaled = healthPetrolTankDelta * 61.0 * cfg.classDamageMultiplier[vehicleClass]

			if healthEngineCurrent > 101.0 then
				SetVehicleUndriveable(vehicle,false)
			end

			if healthEngineCurrent <= 101.0 then
				SetVehicleUndriveable(vehicle,true)
			end

			if vehicle ~= lastVehicle then
				pedInSameVehicleLast = false
			end

			if pedInSameVehicleLast == true then
				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then
					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled,healthBodyDeltaScaled,healthPetrolTankDeltaScaled)
					if healthEngineCombinedDelta > (healthEngineCurrent - 100.0) then
						healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
					end

					if healthEngineCombinedDelta > healthEngineCurrent then
						healthEngineCombinedDelta = healthEngineCurrent - (210.0 / 5)
					end
					healthEngineNew = healthEngineLast - healthEngineCombinedDelta

					if healthEngineNew > (210.0 + 5) and healthEngineNew < 477.0 then
						healthEngineNew = healthEngineNew-(0.038 * 3.2)
					end

					if healthEngineNew < 210.0 then
						healthEngineNew = healthEngineNew-(0.1 * 0.9)
					end

					if healthEngineNew < 100.0 then
						healthEngineNew = 100.0
					end

					if healthBodyNew < 0 then
						healthBodyNew = 0.0
					end
				end
			else
				if healthBodyCurrent < 210.0 then
					healthBodyNew = 210.0
				end
				pedInSameVehicleLast = true
			end

			if healthEngineNew ~= healthEngineCurrent then
				SetVehicleEngineHealth(vehicle,healthEngineNew)
			end

			if healthBodyNew ~= healthBodyCurrent then
				SetVehicleBodyHealth(vehicle,healthBodyNew)
			end

			if healthPetrolTankNew ~= healthPetrolTankCurrent then
				SetVehiclePetrolTankHealth(vehicle,healthPetrolTankNew)
			end

			healthEngineLast = healthEngineNew
			healthBodyLast = healthBodyNew
			healthPetrolTankLast = healthPetrolTankNew
			lastVehicle = vehicle
		else
			pedInSameVehicleLast = false
		end
	end
end)