----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Perm = {}
Tunnel.bindInterface("oc_refinar-meta",Perm)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("refinar-mQMeta")
AddEventHandler("refinar-mQMeta", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("composito-media") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"nitrato-amonia",1) then
            if vRP.tryGetInventoryItem(user_id,"hidroxido-sodio",1) then
                if vRP.tryGetInventoryItem(user_id,"pseudoefedrina",1) then

                    TriggerClientEvent("progress",source,10000,"Refinando")
                    TriggerClientEvent("refin_metaa:posicao",source)
                    TriggerClientEvent("emotes",source,"atm")

                    SetTimeout(10000,function()
                        vRPclient._stopAnim(source,false)
                        vRP.giveInventoryItem(user_id,"composito-media",1)
                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>1x Compósito de Média Qualidade</b>.")
                    end)
            
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pseudoefedrina</b> na mochila.")
                    vRP.giveInventoryItem(user_id,"nitrato-amonia",1)
                    vRP.giveInventoryItem(user_id,"hidroxido-sodio",1)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Você não tem <b>Hidróxido de Sódio</b> na mochila.")
                vRP.giveInventoryItem(user_id,"nitrato-amonia",1)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Nitrato de Amônia</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("refinar-hQMeta")
AddEventHandler("refinar-hQMeta", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("composito-alta") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"nitrato-amonia",1) then
            if vRP.tryGetInventoryItem(user_id,"hidroxido-sodio",2) then
                if vRP.tryGetInventoryItem(user_id,"pseudoefedrina",1) then

                    TriggerClientEvent("progress",source,10000,"Refinando")
                    TriggerClientEvent("refin_metaa:posicao",source)
                    TriggerClientEvent("emotes",source,"atm")

                    SetTimeout(10000,function()
                        vRPclient._stopAnim(source,false)
                        vRP.giveInventoryItem(user_id,"composito-alta",1)
                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>1x Compósito de Alta Qualidade</b>.")
                    end)
            
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pseudoefedrina</b> na mochila.")
                    vRP.giveInventoryItem(user_id,"nitrato-amonia",1)
                    vRP.giveInventoryItem(user_id,"hidroxido-sodio",1)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Você não tem <b>Hidróxido de Sódio</b> na mochila.")
                vRP.giveInventoryItem(user_id,"nitrato-amonia",1)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Nitrato de Amônia</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function Perm.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"grove.permissao") or vRP.hasPermission(user_id,"lider-grove.permissao") then
        return true
    end
end