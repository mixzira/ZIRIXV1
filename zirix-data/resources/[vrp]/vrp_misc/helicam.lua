local fov_max = 80.0
local fov_min = 10.0
local zoomspeed = 2.0
local speed_lr = 3.0
local speed_ud = 3.0
local helicam = false
local fov = (fov_max+fov_min)*0.5

Citizen.CreateThread(function()
	while true do
        local idle = 1000
		if IsPlayerInPolmav() then
			idle = 5
			local heli = GetVehiclePedIsIn(PlayerPedId())
			SetVehicleRadioEnabled(heli,false)
			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0,51) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					helicam = true
				end
				if IsControlJustPressed(0,154) then
					if GetPedInVehicleSeat(heli,1) == PlayerPedId() or GetPedInVehicleSeat(heli,2) == PlayerPedId() then
						PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
						TaskRappelFromHeli(PlayerPedId(),1)
					end
				end
			end
		end

		if helicam then
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end
			local heli = GetVehiclePedIsIn(PlayerPedId())
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,heli,0.0,0.0,-1.5,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam,fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform,"SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0)
			PopScaleformMovieFunctionVoid()
			while helicam and not IsEntityDead(PlayerPedId()) and (GetVehiclePedIsIn(PlayerPedId()) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(0,51) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					helicam = false
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam,zoomvalue)
				HandleZoom(cam)
				HideHUDThisFrame()
				PushScaleformMovieFunction(scaleform,"SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam,2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(10)
			end
			helicam = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false,false,0,1,0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam,false)
			SetNightvision(false)
			SetSeethrough(false)
		end
		Citizen.Wait(idle)
	end
end)

function IsPlayerInPolmav()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	return IsVehicleModel(vehicle,GetHashKey("paramedicoheli")) or IsVehicleModel(vehicle,GetHashKey("policiaheli"))
end

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
end

function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z+rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then
		fov = math.max(fov-zoomspeed,fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov+zoomspeed,fov_max)
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then
		fov = current_fov
	end
	SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0),10,GetVehiclePedIsIn(PlayerPedId()),0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit > 0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num,math.cos(z)*num,math.sin(x))
end

local coords = false

RegisterCommand("coords",function(source,args)
	if coords then
		coords = false
	else
		coords = true
	end
end)

Citizen.CreateThread(function()
    while true do
		local idle = 1000
		
		if coords then
			idle = 5
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			
			roundx = tonumber(string.format("%.2f", x))
			roundy = tonumber(string.format("%.2f", y))
			roundz = tonumber(string.format("%.2f", z))
			
			DrawTxt("~r~X:~s~ "..roundx, 0.551, 0.90)
			DrawTxt("~r~Y:~s~ "..roundy, 0.591, 0.90)
			DrawTxt("~r~Z:~s~ "..roundz, 0.631, 0.90)

			heading = GetEntityHeading(GetPlayerPed(-1))
			roundh = tonumber(string.format("%.2f", heading))
			DrawTxt("~r~H:~s~ "..roundh, 0.52, 0.90)

			local rx,ry,rz = table.unpack(GetEntityRotation(PlayerPedId(), 1))
			--DrawTxt("~r~RX:~s~ "..tonumber(string.format("%.2f", rx)), 0.36, 0.03)
			--DrawTxt("~r~RY:~s~ "..tonumber(string.format("%.2f", ry)), 0.42, 0.03)
			--DrawTxt("~r~RZ:~s~ "..tonumber(string.format("%.2f", rz)), 0.475, 0.03)
		
			speed = GetEntitySpeed(PlayerPedId())
			rounds = tonumber(string.format("%.2f", speed))
			DrawTxt("~r~Player Speed: ~s~"..rounds, 0.40, 0.90)

			health = GetEntityHealth(PlayerPedId())
			DrawTxt("~r~Player Health: ~s~"..health, 0.46, 0.90)

			veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
			vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
			if IsPedInAnyVehicle(PlayerPedId(), 1) then
				vehenground = tonumber(string.format("%.2f", veheng))
				vehbodround = tonumber(string.format("%.2f", vehbody))

				DrawTxt("~r~Engine Health: ~s~"..vehenground, 0.015, 0.90)

				DrawTxt("~r~Body Health: ~s~"..vehbodround, 0.015, 0.90)

				DrawTxt("~r~Vehicle Fuel: ~s~"..tonumber(string.format("%.2f", GetVehicleFuelLevel(GetVehiclePedIsUsing(PlayerPedId())))), 0.015, 0.70)
			end
		end
		Citizen.Wait(idle)
    end
end)

function DrawTxt(text, x, y)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.35, 0.35)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end