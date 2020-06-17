-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- RESOURCE TUNNEL/PROXY
vRPrb = {}
Tunnel.bindInterface("vrp_roubobanco",vRPrb)
Proxy.addInterface("vrp_roubobanco",vRPrb)
RBclient = Tunnel.getInterface("vrp_roubobanco")

local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbankrobbery = ""
--------------------------------------------------------------------------------------------------------------------------------------------
--CHAMADO
--------------------------------------------------------------------------------------------------------------------------------------------
function vRPrb.chamarPoliciais()
    local source = source
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if user_id then
        local soldado = vRP.getUsersByPermission("dpla.permissao")
        for l,w in pairs(soldado) do
            local player = vRP.getUserSource(parseInt(w))
            if player then
                async(function()
                    local id = idgens:gen()
                    blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
                    vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
                    TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Roubo ao Banco Central iniciado, dirija-se até o local e intercepte os assaltantes.")
                    SetTimeout(10000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
                end)
            end
        end
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------
--ATUALIZAR A CIDADE SOBRE A SITUAÇÃO DO BANCO
--------------------------------------------------------------------------------------------------------------------------------------------
function vRPrb.updateCops(message)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerClientEvent('chatMessage', -1, "[ASNEWS BANCO CENTRAL]", {64,64,255}, message)
    end
end


function vRPrb.copsonline()
	local cops = vRP.getUsersByPermission("policia.permissao")
	return #cops 
end

function vRPrb.permissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "policia.permissao")
end

function vRPrb.getBox(bank)
    local money = Config.BankRobbery[bank].Money.Amount
    if money > 0 then
        if money >= Config.BankRobbery[bank].Money.StartMoney/2 then
            Config.BankRobbery[bank].Money.Box = Config.Boxes.Full
        else
            Config.BankRobbery[bank].Money.Box = Config.Boxes.Half
        end
    else
        Config.BankRobbery[bank].Money.Box = Config.Boxes.Empty
    end
    box = Config.BankRobbery[bank].Money.Box
    return box
end

function vRPrb.getitem(item)
    local source = source
	local user_id = vRP.getUserId(source)
    if vRP.tryGetInventoryItem(user_id,item,1,true) then
		return true
    else
		return false
	end
end

RegisterServerEvent('vrp_roubobanco:deleteDrill')
AddEventHandler('vrp_roubobanco:deleteDrill', function(coords)
    TriggerClientEvent('vrp_roubobanco:deleteDrillCl', -1, coords)
end)

function generateRandomMoney(src, bank)
	local xPlayer = vRP.getUserId(src)
    while true do
        local randommoney = math.random(25000, 40000)
        if Config.BankRobbery[bank].Money.Amount - randommoney >= 0 then
            Config.BankRobbery[bank].Money.Amount = Config.BankRobbery[bank].Money.Amount - randommoney
			vRP.giveInventoryItem(xPlayer,"dinheiro-sujo",randommoney,true)
            break
        end
        Wait(0)
    end
end

RegisterServerEvent('vrp_roubobanco:takeMoney')
AddEventHandler('vrp_roubobanco:takeMoney', function(bank)
    local src = source
	local xPlayer = vRP.getUserId(src)
    if Config.BankRobbery[bank].Money.Amount - 1000 >= 0 then
        generateRandomMoney(src, bank)
    else
        if Config.BankRobbery[bank].Money.Amount > 0 then
			vRP.giveInventoryItem(xPlayer,"dinheiro-sujo",Config.BankRobbery[bank].Money.Amount,true)

            Config.BankRobbery[bank].Money.Amount = 0
        end
    end
    TriggerClientEvent('vrp_roubobanco:updateMoney', -1, bank, Config.BankRobbery[bank].Money.Amount )
end)

RegisterServerEvent('vrp_roubobanco:printFrozenDoors')
AddEventHandler('vrp_roubobanco:printFrozenDoors', function()
    for i = 1, #Config.BankRobbery do 
        for j = 1, #Config.BankRobbery[i].Doors do
            local d = Config.BankRobbery[i].Doors[j]
        end
    end
end)

RegisterServerEvent('vrp_roubobanco:setDoorFreezeStatus')
AddEventHandler('vrp_roubobanco:setDoorFreezeStatus', function(bank, door, status)
    Config.BankRobbery[bank].Doors[door].Frozen = status
    TriggerClientEvent('vrp_roubobanco:setDoorFreezeStatusCl', -1, bank, door, status)
end)

RegisterServerEvent('vrp_roubobanco:getDoorFreezeStatus')
AddEventHandler('vrp_roubobanco:getDoorFreezeStatus', function(bank, door)
    TriggerClientEvent('vrp_roubobanco:setDoorFreezeStatusCl', source, bank, door, Config.BankRobbery[bank].Doors[door].Frozen)
end)

RegisterServerEvent('vrp_roubobanco:toggleSafe')
AddEventHandler('vrp_roubobanco:toggleSafe', function(bank, safe, toggle)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
    TriggerClientEvent('vrp_roubobanco:safeLooted', -1, bank, safe, toggle)
end)

RegisterServerEvent('vrp_roubobanco:lootSafe')
AddEventHandler('vrp_roubobanco:lootSafe', function(bank, safe)
    local src = source
	local xPlayer = vRP.getUserId(src)
    local randommoney = math.random(Config.SafeMinimum, Config.SafeMax)
	vRP.giveInventoryItem(xPlayer,"dinheiro-sujo",randommoney,false)
	vRPclient._notify(src,"Você encontrou ~g~ R$".. randommoney .."!")
    Config.BankRobbery[bank].Safes[safe].Looted = true
    TriggerClientEvent('vrp_roubobanco:safeLooted', -1, bank, safe, true)
end)

RegisterServerEvent('vrp_roubobanco:lootCarrinhos')
AddEventHandler('vrp_roubobanco:lootCarrinhos', function(bank, carrinho)
    local src = source
	local xPlayer = vRP.getUserId(src)
    local randommoney = math.random(Config.SafeMinimumCarrinho, Config.SafeMaxCarrinho)
	vRP.giveInventoryItem(xPlayer,"dinheiro-sujo",randommoney,false)
	vRPclient._notify(src,"Você encontrou ~g~ R$".. randommoney .."!")
    Config.BankRobbery[bank].Carrinhos[carrinho].Looted = true
    TriggerClientEvent('vrp_roubobanco:carrinhoLooted', -1, bank, carrinho, true)
end)

AddEventHandler('playerConnecting', function()
    local src = source
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Doors do
            Wait(0)
            TriggerClientEvent('vrp_roubobanco:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Doors[j].Frozen)
        end
    end
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Safes do
            Wait(0)
            TriggerClientEvent('vrp_roubobanco:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Safes[j].Looted)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Doors do
                Wait(0)
                TriggerClientEvent('vrp_roubobanco:setDoorFreezeStatusCl', -1, i, j, Config.BankRobbery[i].Doors[j].Frozen)
            end
        end
        Wait(30000)
    end
end)