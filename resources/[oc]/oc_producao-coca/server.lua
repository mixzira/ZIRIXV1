local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

farM = {}
Tunnel.bindInterface("oc_producao-coca",farM)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("proc-lQCoca")
AddEventHandler("proc-lQCoca", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("coca-baixa") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"pasta-baixa",1) then

            TriggerClientEvent("progress",source,10000,"Processando")
            TriggerClientEvent("proc_coca:posicao",source)
            TriggerClientEvent("emotes",source,"coca")

            SetTimeout(10000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"coca-baixa",10)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Cocaína de baixa qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pasta de baixa qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-mQCoca")
AddEventHandler("proc-mQCoca", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("coca-media") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"pasta-media",1) then
            
            TriggerClientEvent("progress",source,10000,"Processando")
            TriggerClientEvent("proc_coca:posicao",source)
            TriggerClientEvent("emotes",source,"coca")

            SetTimeout(10000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"coca-media",10)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Cocaína de média qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pasta de média qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-hQCoca")
AddEventHandler("proc-hQCoca", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("coca-alta") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"pasta-alta",1) then
            if vRP.tryGetInventoryItem(user_id,"querosene",1) then  
                TriggerClientEvent("progress",source,10000,"Processando")
                TriggerClientEvent("proc_coca:posicao",source)
                TriggerClientEvent("emotes",source,"coca")

                SetTimeout(10000,function()
                    vRPclient._stopAnim(source,false)
                    vRP.giveInventoryItem(user_id,"coca-alta",10)
                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Cocaína de alta qualidade</b>.")
                end)
            else
                vRP.giveInventoryItem(user_id,"pasta-alta",1)
                TriggerClientEvent("Notify",source,"negado","Você não tem <b>Querosene</b> na mochila.")
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pasta de alta qualidade</b> na mochila.")
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