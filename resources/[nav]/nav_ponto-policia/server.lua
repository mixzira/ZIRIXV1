local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Policia = {}
Tunnel.bindInterface("nav_ponto-policia",Policia)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local policiaPonto = "https://discordapp.com/api/webhooks/694595467920539688/N68c3QqmKgKSvMdrVqVt7YwbvHZMA0cfI-OFcEFNpU22sgZkwL48Nn1-H0vOeacQezbl"
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PONTO ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("entrar-servico-policia")
AddEventHandler("entrar-servico-policia",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"dpla.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.")
    else
        vRP.addUserGroup(user_id,"dpla")
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
        logEntradaServico()
    end
end)

RegisterServerEvent("sair-servico-policia")
AddEventHandler("sair-servico-policia",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"paisana-dpla.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.")
    else
        vRP.addUserGroup(user_id,"paisana-dpla")
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
        logSaidaServico()
    end
end)

function logEntradaServico()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(policiaPonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." entrou em serviço.", description = "Registro de Ponto do Departamento de Polícia de Los Anjos. Registro de entrada em serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Nome do Agente:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

function logSaidaServico()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(policiaPonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." saiu de serviço.", description = "Registro de Ponto do Departamento de Polícia de Los Anjos. Registro de saída de serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Nome do Agente:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

function Policia.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"dpla.permissao") or vRP.hasPermission(user_id,"paisana-dpla.permissao") then
        return true
	end
end