local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_itemdrop")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁEIS ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local markers_ids = Tools.newIDGenerator()
local items = {}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookPegaritem = "https://discordapp.com/api/webhooks/709950067834093579/XwJPPGMVmrlHUagp4RTw1-arrI_85vuoY_LtaZqPYigBgz_vI28hup2MYS9oFWhOooLF"
-----------------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('DropSystem:create',function(item,count,px,py,pz,tempo)
	local id = markers_ids:gen()
	if id then
		items[id] = { item = item, count = count, x = px, y = py, z = pz, name = vRP.itemNameList(item), tempo = tempo }
		TriggerClientEvent('DropSystem:createForAll',-1,id,items[id])
	end
end)

RegisterServerEvent('DropSystem:drop')
AddEventHandler('DropSystem:drop',function(item,count)
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,item,count)
		TriggerClientEvent('DropSystem:createForAll',-1)
	end
end)

RegisterServerEvent('DropSystem:take')
AddEventHandler('DropSystem:take',function(id)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)

	if nuser_id then
		TriggerClientEvent("Notify",source,"negado","Você não consegue pegar os itens com pessoas por perto.")
	else
		if user_id then
			if items[id] ~= nil then
				local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(items[id].item)*items[id].count
				if new_weight <= vRP.getInventoryMaxWeight(user_id) then
					if items[id] == nil then
						return
					end
					vRP.giveInventoryItem(user_id,items[id].item,items[id].count)
					vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
					local identity = vRP.getUserIdentity(user_id)
					
					PerformHttpRequest(webhookPegaritem, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "REGISTRO DE INVENTÁRIO:\n⠀⠀",
								thumbnail = {
									url = "https://i.imgur.com/F3MD9hY.png"
								},
								fields = {
									{ 
										name = "**IDENTIFICAÇÃO:**",
										value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"
									},
									{ 
										name = "**ITEM PEGADO DO CHÃO:**",
										value = "[ **Item: "..items[id].name.."** ][ **Quantidade: "..items[id].count.."** ]\n⠀⠀"
									}
								},
								footer = { 
									text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
									icon_url = "https://i.imgur.com/F3MD9hY.png"
								},
								color = 16431885
							}
						}
					}), { ['Content-Type'] = 'application/json' })
					
					TriggerClientEvent("itensNotify",source,"sucesso","Pegou",""..items[id].item.."",""..parseInt(items[id].count).."",""..vRP.getItemWeight(items[id].item)*parseInt(items[id].count).."")
					items[id] = nil
					markers_ids:free(id)
					TriggerClientEvent('DropSystem:remove',-1,id)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TEMPO ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(items) do
			if items[k].tempo > 0 then
				items[k].tempo = items[k].tempo - 1
				if items[k].tempo <= 0 then
					items[k] = nil
					markers_ids:free(k)
					TriggerClientEvent('DropSystem:remove',-1,k)
				end
			end
		end
	end
end)