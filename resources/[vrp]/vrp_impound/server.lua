-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient  = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_impound",src)
vCLIENT = Tunnel.getInterface("vrp_impound")
vGARAGE = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local impoundVehs = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkImpound()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"mecanico.permissao") then
            local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
            if vehicle then
                if impoundVehs[vname.."-"..placa] then
                    randmoney = math.random(1800,2500)
                    vRP.giveMoney(user_id,parseInt(randmoney))
       
                    vGARAGE.deleteVehicle(source,vehicle)
                    TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
                    TriggerClientEvent("Notify",source,"sucesso","O veículo <b>"..vRP.vehicleName(vname).."</b> foi enviado ao <b>DMV</b> e você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
                    return true
                end
            end
        end
        return false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DMV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dmv",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"policia.permissao") then
            local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
             if vehicle then
                impoundVehs[vname.."-"..placa] = true
                TriggerClientEvent("Notify",source,"sucesso","O veículo <b>"..vRP.vehicleName(vname).."</b> foi cadastrado na lista do <b>DMV</b>.")
             end
        end
    end
end)
