----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = {}
Tunnel.bindInterface("oc_entregas-drogas",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}

function oC.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(5,8)	
	end

	TriggerClientEvent("quantidade-drogas",source,parseInt(quantidade[source]))
end

function oC.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"coca-alta",quantidade[source]) then
			randmoney = (math.random(30,65)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares em dinheiro sujo</b>.")
			quantidade[source] = nil
			oC.Quantidade()
			return true	
		elseif vRP.tryGetInventoryItem(user_id,"coca-media",quantidade[source]) then
			randmoney = (math.random(15,30)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			oC.Quantidade()
			return true
		elseif vRP.tryGetInventoryItem(user_id,"coca-baixa",quantidade[source]) then
			randmoney = (math.random(5,15)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			oC.Quantidade()
			return true
		elseif vRP.tryGetInventoryItem(user_id,"meta-alta",quantidade[source]) then
			randmoney = (math.random(30,65)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			oC.Quantidade()
			return true
		elseif vRP.tryGetInventoryItem(user_id,"meta-media",quantidade[source]) then
			randmoney = (math.random(15,30)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			oC.Quantidade()
			return true
		elseif vRP.tryGetInventoryItem(user_id,"meta-baixa",quantidade[source]) then
			randmoney = (math.random(5,15)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			oC.Quantidade()
			return true
		 
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..quantidade[source].."x porções da sua droga</b>.")
		end
	end
end