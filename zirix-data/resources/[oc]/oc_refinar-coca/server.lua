local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

farM = {}
Tunnel.bindInterface("oc_refinar-coca",farM)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("refinar-mQCoca")
AddEventHandler("refinar-mQCoca", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pasta-media") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"acido-sulfurico",1) then
            if vRP.tryGetInventoryItem(user_id,"folhas-coca",5) then
                if vRP.tryGetInventoryItem(user_id,"calcio-po",1) then

                    TriggerClientEvent("progress",source,10000,"Refinando")
                    TriggerClientEvent("refin_coca:posicao",source)
                    TriggerClientEvent("emotes",source,"mexer")

                    SetTimeout(10000,function()
                        vRPclient._stopAnim(source,false)
                        vRP.giveInventoryItem(user_id,"pasta-media",1)
                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>1x Compósito de Média Qualidade</b>.")
                    end)
            
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>Cálcio em Pó</b> na mochila.")
                    vRP.giveInventoryItem(user_id,"folhas-coca",5)
                    vRP.giveInventoryItem(user_id,"acido-sulfurico",1)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Você não tem <b>Folhas de Coca</b> na mochila.")
                vRP.giveInventoryItem(user_id,"acido-sulfurico",1)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Ácido Sulfúrico</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)
RegisterServerEvent("refinar-hQCoca")
AddEventHandler("refinar-hQCoca", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pasta-alta") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"acido-sulfurico",1) then
            if vRP.tryGetInventoryItem(user_id,"folhas-coca",10) then
                if vRP.tryGetInventoryItem(user_id,"calcio-po",1) then

                    TriggerClientEvent("progress",source,10000,"Refinando")
                    TriggerClientEvent("refin_coca:posicao",source)
                    TriggerClientEvent("emotes",source,"mexer")

                    SetTimeout(10000,function()
                        vRPclient._stopAnim(source,false)
                        vRP.giveInventoryItem(user_id,"pasta-alta",1)
                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>1x Compósito de Alta Qualidade</b>.")
                    end)
            
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>Cálcio em Pó</b> na mochila.")
                    vRP.giveInventoryItem(user_id,"folhas-coca",10)
                    vRP.giveInventoryItem(user_id,"acido-sulfurico",1)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Você não tem <b>Folhas de Coca</b> na mochila.")
                vRP.giveInventoryItem(user_id,"acido-sulfurico",1)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Ácido Sulfúrico</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function farM.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ballas.permissao") or vRP.hasPermission(user_id,"lider-ballas.permissao") then
        return true
    end
end