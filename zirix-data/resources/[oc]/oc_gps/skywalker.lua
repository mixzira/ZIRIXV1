local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
----------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÃO ]---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
oC = {}
Tunnel.bindInterface("oc_gps",oC)
----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
    local user_id = vRP.getUserId(source)
    
	if user_id then
        TriggerClientEvent("oc_gps:coords", source)
	end
end)

RegisterCommand('ocblips',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    
    TriggerClientEvent("oc_gps:coords", source)
end)
----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
function oC.motoclub()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"motoclub.permissao") then
        return true
    end
end

function oC.medellin()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"medellin.permissao") then
        return true
    end
end

function oC.grove()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"grove.permissao") then
        return true
    end
end

function oC.ballas()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"ballas.permissao") then
        return true
    end
end

function oC.bratva()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"bratva.permissao") then
        return true
    end
end

function oC.odebrecht()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"odebrecht.permissao") then
        return true
    end
end