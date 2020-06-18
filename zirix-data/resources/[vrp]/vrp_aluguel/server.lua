local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

acClient = Tunnel.getInterface("vrp_aluguel")

acServer = {}
Tunnel.bindInterface("vrp_aluguel",acServer)

function acServer.checkPaymentOne()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.tryPayment(user_id,800) then
        acClient.spawnCarOne(source)
        TriggerClientEvent("Notify",source,"sucesso","Gastou <b>$800</b> dólares no aluguel do carro.")
    else
        TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
    end
end

function acServer.checkPaymentTwo()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.tryPayment(user_id,550) then
        acClient.spawnCarTwo(source)
        TriggerClientEvent("Notify",source,"sucesso","Gastou <b>$550</b> dólares no aluguel do carro.")
    else
        TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
    end
end

function acServer.checkPaymentTwe()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.tryPayment(user_id,300) then
        acClient.spawnCarTwe(source)
        TriggerClientEvent("Notify",source,"sucesso","Gastou <b>$300</b> dólares no aluguel do carro.")
    else
        TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
    end
end