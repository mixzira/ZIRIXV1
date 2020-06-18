local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
src = Tunnel.getInterface("gcphone",src)

local KeyToucheCloseEvent = {
	{ code = 172, event = 'ArrowUp' },
	{ code = 173, event = 'ArrowDown' },
	{ code = 174, event = 'ArrowLeft' },
	{ code = 175, event = 'ArrowRight' },
	{ code = 176, event = 'Enter' },
	{ code = 177, event = 'Backspace' }
}

local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local USE_RTC = false
local useMouse = false
local ignoreFocus = false
local lastFrameIsOpen = false
local PhoneInCall = {}
local currentPlaySound = false

function hasPhone(cb)
	cb(true)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(1,311) and src.checkItemPhone() then
			hasPhone(function(hasPhone)
				if hasPhone == true then
					TooglePhone()
				end
			end)
		end
		if menuIsOpen == true then
			for _,value in ipairs(KeyToucheCloseEvent) do
				if IsControlJustPressed(1,value.code) then
					SendNUIMessage({ keyUp = value.event })
				end
			end
			local nuiFocus = useMouse and not ignoreFocus
			SetNuiFocus(nuiFocus,nuiFocus)
			lastFrameIsOpen = true
		else
			if lastFrameIsOpen == true then
				SetNuiFocus(false,false)
				lastFrameIsOpen = false
			end
		end
	end
end)

RegisterNetEvent('gcPhone:setEnableApp')
AddEventHandler('gcPhone:setEnableApp',function(appName,enable)
	SendNUIMessage({ event = 'setEnableApp', appName = appName, enable = enable })
end)

function TakeAppel(infoCall)
	TriggerEvent('gcphone:autoAcceptCall',infoCall)
end

RegisterNetEvent("gcPhone:forceOpenPhone")
AddEventHandler("gcPhone:forceOpenPhone",function(_myPhoneNumber)
	if menuIsOpen == false then
		TooglePhone()
	end
end)

RegisterNetEvent("gcPhone:myPhoneNumber")
AddEventHandler("gcPhone:myPhoneNumber",function(_myPhoneNumber)
	myPhoneNumber = _myPhoneNumber
	SendNUIMessage({ event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber })
end)

RegisterNetEvent("gcPhone:contactList")
AddEventHandler("gcPhone:contactList",function(_contacts)
	SendNUIMessage({ event = 'updateContacts', contacts = _contacts })
	contacts = _contacts
end)

RegisterNetEvent("gcPhone:allMessage")
AddEventHandler("gcPhone:allMessage",function(allmessages)
	SendNUIMessage({ event = 'updateMessages', messages = allmessages })
	messages = allmessages
end)

RegisterNetEvent("gcPhone:receiveMessage")
AddEventHandler("gcPhone:receiveMessage",function(message)
	SendNUIMessage({ event = 'newMessage', message = message })
	if message.owner == 0 then
		PlaySoundFrontend(-1,"Menu_Accept","Phone_SoundSet_Default",false)
		Citizen.Wait(300)
		PlaySoundFrontend(-1,"Menu_Accept","Phone_SoundSet_Default",false)
		Citizen.Wait(300)
		PlaySoundFrontend(-1,"Menu_Accept","Phone_SoundSet_Default",false)
	end
end)

function addContact(display,num)
	TriggerServerEvent('gcPhone:addContact',display,num)
end

function deleteContact(num)
	TriggerServerEvent('gcPhone:deleteContact',num)
end

function sendMessage(num,message)
	TriggerServerEvent('gcPhone:sendMessage',num,message)
end

function deleteMessage(msgId)
	TriggerServerEvent('gcPhone:deleteMessage',msgId)
	for k, v in ipairs(messages) do 
		if v.id == msgId then
			table.remove(messages,k)
			SendNUIMessage({ event = 'updateMessages', messages = messages })
			return
		end
	end
end

function deleteMessageContact(num)
	TriggerServerEvent('gcPhone:deleteMessageNumber',num)
end

function deleteAllMessage()
	TriggerServerEvent('gcPhone:deleteAllMessage')
end

function setReadMessageNumber(num)
	TriggerServerEvent('gcPhone:setReadMessageNumber',num)
	for k, v in ipairs(messages) do 
		if v.transmitter == num then
			v.isRead = 1
		end
	end
end

function requestAllMessages()
	TriggerServerEvent('gcPhone:requestAllMessages')
end

function requestAllContact()
	TriggerServerEvent('gcPhone:requestAllContact')
end

local aminCall = false
local inCall = false

RegisterNetEvent("gcPhone:waitingCall")
AddEventHandler("gcPhone:waitingCall",function(infoCall,initiator)
	SendNUIMessage({ event = 'waitingCall', infoCall = infoCall, initiator = initiator })
	if initiator == true then
		PhonePlayCall()
		if menuIsOpen == false then
			TooglePhone()
		end
	end
end)

RegisterNetEvent("gcPhone:acceptCall")
AddEventHandler("gcPhone:acceptCall",function(infoCall,initiator)
	if inCall == false and USE_RTC == false then
		inCall = true
		NetworkSetVoiceChannel(infoCall.id+1)
		NetworkSetTalkerProximity(0.0)
	end
	if menuIsOpen == false then 
		TooglePhone()
	end
	PhonePlayCall()
	SendNUIMessage({ event = 'acceptCall', infoCall = infoCall, initiator = initiator })
end)

RegisterNetEvent("gcPhone:rejectCall")
AddEventHandler("gcPhone:rejectCall",function(infoCall)
	if inCall == true then
		inCall = false
		Citizen.InvokeNative(0xE036A705F989E049)
		NetworkSetTalkerProximity(2.5)
	end
	PhonePlayText()
	SendNUIMessage({ event = 'rejectCall', infoCall = infoCall })
end)


RegisterNetEvent("gcPhone:historiqueCall")
AddEventHandler("gcPhone:historiqueCall",function(historique)
	SendNUIMessage({ event = 'historiqueCall', historique = historique })
end)


function startCall(phone_number,rtcOffer,extraData)
	TriggerServerEvent('gcPhone:startCall',phone_number,rtcOffer,extraData)
end

function acceptCall (infoCall,rtcAnswer)
	TriggerServerEvent('gcPhone:acceptCall',infoCall,rtcAnswer)
end

function rejectCall(infoCall)
	TriggerServerEvent('gcPhone:rejectCall',infoCall)
end

function ignoreCall(infoCall)
	TriggerServerEvent('gcPhone:ignoreCall',infoCall)
end

function requestHistoriqueCall() 
	TriggerServerEvent('gcPhone:getHistoriqueCall')
end

function appelsDeleteHistorique(num)
	TriggerServerEvent('gcPhone:appelsDeleteHistorique',num)
end

function appelsDeleteAllHistorique()
	TriggerServerEvent('gcPhone:appelsDeleteAllHistorique')
end

RegisterNUICallback('startCall',function(data,cb)
	startCall(data.numero,data.rtcOffer,data.extraData)
	cb()
end)

RegisterNUICallback('acceptCall',function(data,cb)
	acceptCall(data.infoCall,data.rtcAnswer)
	cb()
end)

RegisterNUICallback('rejectCall',function(data,cb)
	rejectCall(data.infoCall)
	cb()
end)

RegisterNUICallback('ignoreCall',function(data,cb)
	ignoreCall(data.infoCall)
	cb()
end)

RegisterNUICallback('notififyUseRTC',function(use,cb)
	USE_RTC = use
	if USE_RTC == true and inCall == true then
		inCall = false
		Citizen.InvokeNative(0xE036A705F989E049)
		NetworkSetTalkerProximity(2.5)
	end
	cb()
end)

RegisterNUICallback('onCandidates',function(data,cb)
	TriggerServerEvent('gcPhone:candidates',data.id,data.candidates)
	cb()
end)

RegisterNetEvent("gcPhone:candidates")
AddEventHandler("gcPhone:candidates",function(candidates)
	SendNUIMessage({ event = 'candidatesAvailable', candidates = candidates })
end)

RegisterNetEvent('gcphone:autoCall')
AddEventHandler('gcphone:autoCall',function(number,extraData)
	if number ~= nil then
		SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData })
	end
end)

RegisterNetEvent('gcphone:autoCallNumber')
AddEventHandler('gcphone:autoCallNumber',function(data)
	TriggerEvent('gcphone:autoCall',data.number)
end)

RegisterNetEvent('gcphone:autoAcceptCall')
AddEventHandler('gcphone:autoAcceptCall',function(infoCall)
	SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall })
end)

RegisterNUICallback('log',function(data,cb)
	cb()
end)

RegisterNUICallback('focus',function(data,cb)
	cb()
end)

RegisterNUICallback('blur',function(data,cb)
	cb()
end)

RegisterNUICallback('reponseText',function(data,cb)
	local limit = data.limit or 255
	local text = data.text or ''
  
	DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","",text,"","","",limit)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0)
		Citizen.Wait(1)
	end
	if (GetOnscreenKeyboardResult()) then
		text = GetOnscreenKeyboardResult()
	end
	cb(json.encode({ text = text }))
end)

RegisterNUICallback('getMessages',function(data,cb)
	cb(json.encode(messages))
end)

RegisterNUICallback('sendMessage',function(data,cb)
	if data.message == '%pos%' then
		local myPos = GetEntityCoords(PlayerPedId())
		data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
	end
	TriggerServerEvent('gcPhone:sendMessage', data.phoneNumber, data.message)
end)

RegisterNUICallback('deleteMessage',function(data,cb)
	deleteMessage(data.id)
	cb()
end)

RegisterNUICallback('deleteMessageNumber',function(data,cb)
	deleteMessageContact(data.number)
	cb()
end)

RegisterNUICallback('deleteAllMessage',function(data,cb)
	deleteAllMessage()
	cb()
end)

RegisterNUICallback('setReadMessageNumber',function(data,cb)
	setReadMessageNumber(data.number)
	cb()
end)

RegisterNUICallback('addContact',function(data,cb) 
	TriggerServerEvent('gcPhone:addContact',data.display,data.phoneNumber)
end)

RegisterNUICallback('updateContact',function(data,cb)
	TriggerServerEvent('gcPhone:updateContact',data.id,data.display,data.phoneNumber)
end)

RegisterNUICallback('deleteContact',function(data,cb)
	TriggerServerEvent('gcPhone:deleteContact',data.id)
end)

RegisterNUICallback('getContacts',function(data,cb)
	cb(json.encode(contacts))
end)

RegisterNUICallback('setGPS',function(data,cb)
	SetNewWaypoint(tonumber(data.x),tonumber(data.y))
	cb()
end)

RegisterNUICallback('callEvent',function(data,cb)
	local eventName = data.eventName or ''
	if string.match(eventName, 'gcphone') then
		if data.data ~= nil then 
			TriggerEvent(data.eventName, data.data)
		else
			TriggerEvent(data.eventName)
		end
	end
	cb()
end)

RegisterNUICallback('useMouse',function(um,cb)
	useMouse = um
end)

RegisterNUICallback('deleteALL',function(data,cb)
	TriggerServerEvent('gcPhone:deleteALL')
	cb()
end)

function TooglePhone() 
	menuIsOpen = not menuIsOpen
	SendNUIMessage({ show = menuIsOpen })
	if menuIsOpen == true then 
		PhonePlayIn()
	else
		PhonePlayOut()
	end
end

RegisterNUICallback('closePhone',function(data,cb)
	menuIsOpen = false
	SendNUIMessage({ show = false })
	PhonePlayOut()
	cb()
end)

RegisterNUICallback('appelsDeleteHistorique',function(data,cb)
	appelsDeleteHistorique(data.numero)
	cb()
end)

RegisterNUICallback('appelsDeleteAllHistorique',function(data,cb)
	appelsDeleteAllHistorique(data.infoCall)
	cb()
end)

AddEventHandler('onClientResourceStart',function(res)
	DoScreenFadeIn(300)
	if res == "gcphone" then
		TriggerServerEvent('gcPhone:allUpdate')
	end
end)

RegisterNUICallback('setIgnoreFocus',function(data,cb)
	ignoreFocus = data.ignoreFocus
	cb()
end)