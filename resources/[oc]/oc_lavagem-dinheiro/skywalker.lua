local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
oC = {}
Tunnel.bindInterface("oc_lavagem-dinheiro",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.lavagemDinheiro()
    local source = source
    local user_id = vRP.getUserId(source)
    local valor = vRP.prompt(source,"Quanto dinheiro você deseja lavar:","")
    local banco = vRP.getBankMoney(user_id)

    if valor == "" then 
        return TriggerClientEvent("Notify",source,"negado","Você precisa colocar um valor para confirmar sua solicitação.")
    end

    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= parseInt(valor) then

        TriggerClientEvent("progress",source,10000,"LAVANDO DINHEIRO")
        TriggerClientEvent("lavagem-dinheiro:posicao",source)
        vRPclient._playAnim(source,false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
        vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(valor))

        SetTimeout(10000,function()
            vRPclient._stopAnim(source,false)
            vRP.setBankMoney(user_id,banco+valor)
            TriggerClientEvent("Notify",source,"sucesso","Você lavou <b>$"..valor.."</b> dólares.")
        end)
    else
        TriggerClientEvent("Notify",source,"negado","Você não tem <b>dinheiro sujo</b> suficiente na mochila.")
    end
end

function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"odebrecht.permissao") or vRP.hasPermission(user_id,"diretor-odebrecht.permissao") or vRP.hasPermission(user_id,"lider-bratva") or vRP.hasPermission(user_id,"bratva.permissao") then
        return true
    end
end