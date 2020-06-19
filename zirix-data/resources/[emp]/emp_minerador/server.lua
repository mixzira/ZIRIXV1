local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_minerador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local porcentagem = 0
local itemname = ""
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,2)
	end
end

function emP.checkWeight()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		porcentagem = math.random(100)
		if porcentagem <= 15 then
			itemname = "bronze"
		elseif porcentagem >= 16 and porcentagem <= 30 then
			itemname = "ferro"
		elseif porcentagem >= 31 and porcentagem <= 40 then
			itemname = "ouro"
		elseif porcentagem >= 41 and porcentagem <= 50 then
			itemname = "rubi"
		elseif porcentagem >= 51 and porcentagem <= 60 then
			itemname = "esmeralda"
		elseif porcentagem >= 61 and porcentagem <= 70 then
			itemname = "safira"
		elseif porcentagem >= 71 and porcentagem <= 80 then
			itemname = "diamante"
		elseif porcentagem >= 81 and porcentagem <= 90 then
			itemname = "topazio"
		elseif porcentagem >= 91 then
			itemname = "ametista"
		end
		return vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemname)*quantidade[source] <= vRP.getInventoryMaxWeight(user_id)
	end
end

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,itemname,quantidade[source])
		TriggerClientEvent("Notify",source,"sucesso","Encontrou <b>"..quantidade[source].."x "..vRP.itemNameList(itemname).."</b>.",8000)
		quantidade[source] = nil
	end
end