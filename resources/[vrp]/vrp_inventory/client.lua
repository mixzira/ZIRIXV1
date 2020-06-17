local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ INVCLOSE ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ABRIR INVENTARIO ]-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        if IsControlJustPressed(0,243) then
            if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
                if not invOpen then
                	StartScreenEffect("MenuMGSelectionIn", 0, true)
                    invOpen = true
                    SetNuiFocus(true,true)
                    SendNUIMessage({ action = "showMenu" })
                else
                	StopScreenEffect("MenuMGSelectionIn")
                    SetNuiFocus(false,false)
                    SendNUIMessage({ action = "hideMenu" })
                    invOpen = false
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CLONEPLATES ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local clonada = GetVehicleNumberPlateText(vehicle)
    if IsEntityAVehicle(vehicle) then
        PlateIndex = GetVehicleNumberPlateText(vehicle)
        SetVehicleNumberPlateText(vehicle,"CLONADA")
        FreezeEntityPosition(vehicle,false)
        if clonada == CLONADA then 
            SetVehicleNumberPlateText(vehicle,PlateIndex)
            PlateIndex = nil
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VEHICLEANCHOR ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vehicleanchor')
AddEventHandler('vehicleanchor',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehicle,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DROPITEM ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	vRPNserver.dropItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SENDITEM ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	vRPNserver.sendItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ USEITEM ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	vRPNserver.useItem(data.item,data.type,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MOCHILA ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:Update")
AddEventHandler("Creative:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ USO REMÉDIO ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local usandoRemedios = false
RegisterNetEvent("remedios")
AddEventHandler("remedios",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
    SetPedArmour(ped,armour)
    
    if GetEntityHealth(ped) <= 239 then
        TriggerEvent("Notify","negado","<b>O remédio não fara feito, pois você precisa de tratamento</b>.",8000)
    else
        if usandoRemedios then
            return
        end

        usandoRemedios = true

        if usandoRemedios then
            repeat
                Citizen.Wait(600)
                if GetEntityHealth(ped) > 239 then
                    SetEntityHealth(ped,GetEntityHealth(ped)+1)
                end
            until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 240
                TriggerEvent("Notify","sucesso","O medicamento acabou de fazer efeito.",8000)
                usandoRemedios = false
        end
    end
end)