

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local health
local multi
local pulse = 70
local area = "Unknown"
local lastHit
local blood = 100
local bleeding = 0
local dead = false
local timer = 0

local cPulse = -1
local cBlood = -1
local cNameF = ""
local cNameL = ""
local cArea = ""
local cBleeding = "NONE"

RegisterCommand('getpulse', function(source, args)
	local health = GetEntityHealth(GetPlayerPed(-1))
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	
	print(pulse)
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	print(bone)
	
end, false)

AddEventHandler('esx:onPlayerDeath', function(data)

	multi = 2.0
	blood = 100
	health = GetEntityHealth(GetPlayerPed(-1))
	area = "LEGS/ARMS"
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	bleeding = 1
	if (bone == 31086) then
		multi = 0.0
		print('HEADSHOT')
		TriggerEvent('chatMessage', "MedSystem", {255, 0, 0}, "You have been shot/damaged in HEAD area")
		bleeding = 5
		area = "HEAD"
	end
	if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		multi = 1.0
		print('BODYSHOT')
		TriggerEvent('chatMessage', "MedSystem", {255, 0, 0}, "You have been shot/damaged in BODY area")
		bleeding = 2
		area = "BODY"
	end
	
	pulse = ((health / 4 + 20) * multi) + math.random(0, 4)
	dead = true
end)

Citizen.CreateThread( function()
while true do
	Wait(5000)
	local hp = GetEntityHealth(GetPlayerPed(-1))
	if hp >= 1 and dead then
		dead = false
		bleeding = 0
		blood = 100
	end
	if dead and blood > 0 then
	blood = blood - bleeding
	end
end
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,100)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

RegisterNetEvent('medSystem:near')
AddEventHandler('medSystem:near', function(x,y,z, pulse, blood, nameF, nameL, area, bldn)
		
	
	local a,b,c = GetEntityCoords(GetPlayerPed(-1))
	
	if GetDistanceBetweenCoords(x,y,z,a,b,c,false) < 10 then
		timer = 10
		TriggerEvent('chatMessage', "MedSystem", {255,0 , 0}, "^1 [0-5] DEAD ^6[5-15] Needs hospital ^5[15-38] EMS Can help ^4[38-55] Police can help ^2[55+] Healthy")
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
		
		if bldn == 1 then
		cBleeding = "SLOW"
		elseif bldn == 2 then
		cBleeding "MEDIUM"
		elseif bldn == 5 then
		cBleeding = "FAST"
		elseif bldn == 0 then
		cBleeding = "NONE"
		end
		
	else
		timer = 0
		cBlood = -1
		cPulse = -1
		cNameF = ""
		cNameL = ""
		cArea = ""
		cBleeding = "SLOW"
	end
	

end)

Citizen.CreateThread( function()
	while true do
		Wait(1)
			while timer >= 1 do
				Wait(1)
				if cPulse ~= -1 and cBlood ~= -1 then
					DrawAdvancedText(0.7, 0.7, 0.005, 0.0028, 0.9, cNameF .. " " .. cNameL .. "\n~r~Pulse: ~w~" .. cPulse .. "BPM\n~r~Blood: ~w~" .. cBlood .. "%~r~\nHurt area: ~w~" .. cArea .. "\n~r~Bleeding: ~w~" .. cBleeding, 255, 255, 255, 255, 4, 1)
					
				end
			end
	end
end)

Citizen.CreateThread( function()
	while true do
		Wait(1000)
		if timer >= 1 then
			timer = timer - 1
		end	
	end
end)

RegisterNetEvent('medSystem:send')
AddEventHandler('medSystem:send', function(req)
		
	print('1')
	local health = GetEntityHealth(GetPlayerPed())
	print('2')
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	print('3')
	local a, b, c = table.unpack(GetEntityCoords(GetPlayerPed()))
	print('4')

	print(a)
	TriggerServerEvent('medSystem:print', req, math.floor(pulse * (blood / 90)), area, blood, a, b, c, bleeding)
	print(bleeding)
	print(a)
	print(b)
	print(c)
	print(area)

end)