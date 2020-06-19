----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Perm = {}
Tunnel.bindInterface("nav_parts_guns",Perm)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "corpo-ak47", quantidade = 1, compra = 30000 },
	{ item = "corpo-aks", quantidade = 1, compra = 30000 },
	{ item = "corpo-uzi", quantidade = 1, compra = 15000 },
	{ item = "corpo-glock", quantidade = 1, compra = 8000 },
	{ item = "corpo-magnum", quantidade = 1, compra = 7000 },
	{ item = "gatilho", quantidade = 1, compra = 1000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COMPRAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("departamento-comprar")
AddEventHandler("departamento-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ Perms ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function Perm.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"medellin.permissao") or vRP.hasPermission(user_id,"lider-medellin.permissao") or vRP.hasPermission(user_id,"motoclub.permissao") or vRP.hasPermission(user_id,"lider-motoclub.permissao") then
        return true
    end
end