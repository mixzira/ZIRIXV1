local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local discordDMLA = ""
local discordDPLAe = ""
local discordDPLAa = ""
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CHEST ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	["aDPLA"] = { 15000, ['permissao'] = "dpla.permissao" },
	["eDPLA"] = { 30000, ['permissao'] = "dpla.permissao" },
	["sDMLA"] = { 5000, ['permissao'] = "dmla.permissao" },

	["motoclub"] = { 5000, ['permissao'] = "motoclub.permissao" },
	["medellin"] = { 5000, ['permissao'] = "medellin.permissao" },

	["grove"] = { 5000, ['permissao'] = "grove.permissao" },
	["ballas"] = { 5000, ['permissao'] = "ballas.permissao" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ACTIVEDOWNTIME ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CHECKINTPERMISSIONS ]----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)

	if nuser_id then
		TriggerClientEvent("Notify",source,"negado","Você não consegue pegar os itens com pessoas por perto.")
	else
		if user_id then
			if not vRP.searchReturn(source,user_id) then
				if vRP.hasPermission(user_id,chest[chestName]['permissao']) then
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!",8000)
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ OPENCHEST ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ STOREITEM ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(chest[tostring(chestName)][1]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then

							if chestName == "aDPLA" then
								PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "eDPLA" then
								PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "sDMLA" then
								PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
							end

							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Baú</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(chest[tostring(chestName)][1]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then

									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end

									if chestName == "aDPLA" then
										PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "eDPLA" then
										PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "sDMLA" then
										PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									end

									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TAKEITEM ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)

		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "aDPLA" then
								PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou do Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "eDPLA" then
								PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou do Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "sDMLA" then
								PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou do Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)

							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "aDPLA" then
								PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou do Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "eDPLA" then
								PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou do Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "sDMLA" then
								PerformHttpRequest(discordDPLAe, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou do Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							end
							
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
								
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
			end
		end
	end
	return false
end