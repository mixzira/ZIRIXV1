mhackingCallback = {}
showHelp = false
helpTimer = 0
helpCycle = 4000

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if showHelp then
			if helpTimer > GetGameTimer() then
				drawTxt("NAVEGUE COM ~y~W, A, S, D~s~ E CONFIRME COM ~y~ESPAÇO~s~ PARA O BLOCO DE CÓDIGO DA ESQUERDA",4,0.5,0.90,0.50,255,255,255,180)
				--showHelpText("Navegue com ~y~ W, A, S, D ~s~ e confirme com ~y~ ESPAÇO ~s~ para o bloco de código da esquerdo.")
			elseif helpTimer > GetGameTimer()-helpCycle then
				drawTxt("NAVEGUE COM AS ~y~SETAS~s~ E CONFIRME COM ~y~ENTER~s~ PARA O BLOCO DE CÓDIGO DA DIREITA",4,0.5,0.90,0.50,255,255,255,180)
			else
				helpTimer = GetGameTimer()+helpCycle
			end
			if IsEntityDead(PlayerPedId()) then
				nuiMsg = {}
				nuiMsg.fail = true
				SendNUIMessage(nuiMsg)
			end
		end
	end
end)

--[[function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end]]

AddEventHandler('mhacking:show', function()
    nuiMsg = {}
	nuiMsg.show = true
	SendNUIMessage(nuiMsg)
	SetNuiFocus(true, false)
end)

AddEventHandler('mhacking:hide', function()
    nuiMsg = {}
	nuiMsg.show = false
	SendNUIMessage(nuiMsg)
	SetNuiFocus(false, false)
	showHelp = false
end)

AddEventHandler('mhacking:start', function(solutionlength, duration, callback)
    mhackingCallback = callback
	nuiMsg = {}
	nuiMsg.s = solutionlength
	nuiMsg.d = duration
	nuiMsg.start = true
	SendNUIMessage(nuiMsg)
	showHelp = true
end)

AddEventHandler('mhacking:setmessage', function(msg)
    nuiMsg = {}
	nuiMsg.displayMsg = msg
	SendNUIMessage(nuiMsg)
end)

RegisterNUICallback('callback', function(data, cb)
	mhackingCallback(data.success, data.remainingtime)
    cb('ok')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end