local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_leiteiro-coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("garrafadeleite")*3 <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.getInventoryItemAmount(user_id,"garrafavazia") >= 3 then
				return true
			else
				TriggerClientEvent("Notify",source,"negado","<b>Garrafas</b> vazias insuficientes.") 
				return false
			end
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.") 
			return false
		end
	end
end

function emP.checkAddItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id,"garrafavazia",3) then
		vRP.giveInventoryItem(user_id,"garrafadeleite",3)
		TriggerClientEvent("Notify",source,"sucesso","Você ordenhou <b>3x garrafas de leite</b>.") 
	end
end