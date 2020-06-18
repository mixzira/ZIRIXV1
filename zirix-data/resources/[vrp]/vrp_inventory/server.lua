local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_inventory",vRPN)
Proxy.addInterface("vrp_inventory",vRPN)

local idgens = Tools.newIDGenerator()

vGARAGE = Tunnel.getInterface("vrp_garages")
vDIAGNOSTIC = Tunnel.getInterface("vrp_diagnostic")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local logDropar = ""
local logEnviar = ""
local logEquipar = ""
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MOCHILA ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local inventario = {}
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if vRP.itemBodyList(k) then
				table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
			end
		end
		return inventario,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SEND ITEM ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.sendItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		if nuser_id and vRP.itemIndexList(itemName) and item ~= vRP.itemIndexList("identidade") then
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
						vRP.giveInventoryItem(nuser_id,itemName,amount)
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						
						local quantidaItem = vRP.format(parseInt(amount))
						PerformHttpRequest(logEnviar, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "REGISTRO DE ITEM ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
									thumbnail = {
									url = "https://i.imgur.com/jSXFScq.png"
									}, 
									fields = {
										{ 
											name = "**Quem enviou:**", 
											value = "` "..identity.name.." "..identity.firstname.." ` "
										},
										{ 
											name = "**Nº de Passaporte:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**Item enviado:**", 
											value = "` "..vRP.itemNameList(itemName).." ` "
										},
										{ 
											name = "**Quantidade:**", 
											value = "` "..quantidaItem.." `\n⠀"
										},
										{ 
											name = "**Quem recebeu:**", 
											value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀"
										},
										{ 
											name = "**Nº passaporte destinatário:**", 
											value = "` "..nuser_id.." `\n⠀"
										}
									}, 
									footer = { 
										text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
										icon_url = "https://i.imgur.com/jSXFScq.png" 
									},
									color = 15914080 
								}
							}
						}), { ['Content-Type'] = 'application/json' })
						
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
						return true
					end
				end
			else
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
					if itemName == k then
						if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * parseInt(v.amount) <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
								vRP.giveInventoryItem(nuser_id,itemName,parseInt(v.amount))
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								
								local quantidaItem = vRP.format(parseInt(amount))
								PerformHttpRequest(logEnviar, function(err, text, headers) end, 'POST', json.encode({
									embeds = {
										{ 
											title = "REGISTRO DE ITEM ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
											thumbnail = {
											url = "https://i.imgur.com/jSXFScq.png"
											}, 
											fields = {
												{ 
													name = "**Quem enviou:**", 
													value = "` "..identity.name.." "..identity.firstname.." ` "
												},
												{ 
													name = "**Nº de Passaporte:**", 
													value = "` "..user_id.." ` "
												},
												{ 
													name = "**Item enviado:**", 
													value = "` "..vRP.itemNameList(itemName).." ` "
												},
												{ 
													name = "**Quantidade:**", 
													value = "` "..quantidaItem.." `\n⠀"
												},
												{ 
													name = "**Quem recebeu:**", 
													value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀"
												},
												{ 
													name = "**Nº passaporte destinatário:**", 
													value = "` "..nuser_id.." `\n⠀"
												}
											}, 
											footer = { 
												text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
												icon_url = "https://i.imgur.com/jSXFScq.png" 
											},
											color = 15914080 
										}
									}
								}), { ['Content-Type'] = 'application/json' })
								
								TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DROP ITEM ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.dropItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) then
			TriggerEvent("DropSystem:create",itemName,amount,x,y,z,3600)
			vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
			local quantidaItem = vRP.format(parseInt(amount))

			PerformHttpRequest(logDropar, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE ITEM DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://i.imgur.com/jSXFScq.png"
						}, 
						fields = {
							{ 
								name = "**Quem dropou:**", 
								value = "` "..identity.name.." "..identity.firstname.." ` "
							},
							{ 
								name = "**Nº de Passaporte:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**Item:**", 
								value = "` "..vRP.itemNameList(itemName).." ` "
							},
							{ 
								name = "**Quantidade:**", 
								value = "` "..quantidaItem.." `\n⠀"
							}
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://i.imgur.com/jSXFScq.png" 
						},
						color = 15914080 
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			
			TriggerClientEvent('Creative:Update',source,'updateMochila')
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						TriggerEvent("DropSystem:create",itemName,parseInt(v.amount),x,y,z,3600)
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						local quantidaItem = vRP.format(parseInt(amount))

						PerformHttpRequest(logDropar, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "REGISTRO DE ITEM DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
									thumbnail = {
									url = "https://i.imgur.com/jSXFScq.png"
									}, 
									fields = {
										{ 
											name = "**Quem dropou:**", 
											value = "` "..identity.name.." "..identity.firstname.." ` "
										},
										{ 
											name = "**Nº de Passaporte:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**Item:**", 
											value = "` "..vRP.itemNameList(itemName).." ` "
										},
										{ 
											name = "**Quantidade:**", 
											value = "` "..quantidaItem.." `\n⠀"
										}
									}, 
									footer = { 
										text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
										icon_url = "https://i.imgur.com/jSXFScq.png" 
									},
									color = 15914080 
								}
							}
						}), { ['Content-Type'] = 'application/json' })

						TriggerClientEvent('Creative:Update',source,'updateMochila')
						return true
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BANDAGEM ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ USE ITEM ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local pick = {}
local blips = {}
function vRPN.useItem(itemName,type,ramount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
		if type == "usar" then
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ ULTILITÁRIOS ]--------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------
			if itemName == "mochila" then
				if vRP.getInventoryMaxWeight(user_id) >= 90 then
					TriggerClientEvent("Notify",source,"negado","Você não pode equipar mais mochilas.",8000)
				else
					if vRP.tryGetInventoryItem(user_id,"mochila",1) then
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRP.varyExp(user_id,"physical","strength",650)
						TriggerClientEvent("Notify",source,"sucesso","Mochila equipada.",8000)
					end
				end
			elseif itemName == "identidade" then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if nplayer then
					local identity = vRP.getUserIdentity(user_id)
					if identity then
						TriggerClientEvent("Identity2",nplayer,identity.name,identity.firstname,identity.user_id,identity.registration)
					end
				end
			elseif itemName == "colete" then
				if vRP.tryGetInventoryItem(user_id,"colete",1) then
					vRPclient.setArmour(source,100)
					TriggerClientEvent('Creative:Update',source,'updateMochila')
				end	
			elseif itemName == "militec" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,30000,"reparando motor")
							SetTimeout(30000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('repararmotor',source,vehicle)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"militec",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando motor")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararmotor',source,vehicle)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end
			elseif itemName == "repairkit" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,30000,"reparando veículo")
							SetTimeout(30000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('reparar',source)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando veículo")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('reparar',source)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ ULTILITÁRIOS ILEGAIS ]------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------
			elseif itemName == "lockpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				local policia = vRP.getUsersByPermission("dpla.permissao")

				if #policia < 0 then
					TriggerClientEvent("Notify",source,"aviso","Policiais insuficientes em serviço.")
					return true
				end

				if vRP.hasPermission(user_id,"dpla.permissao") then
					TriggerEvent("setPlateEveryone",placa)
					vGARAGE.vehicleClientLock(-1,vnetid,lock)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
					return
				end

				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) and vehicle then
					actived[user_id] = true

					if vRP.hasPermission(user_id,"mec.permissao") then
						actived[user_id] = nil
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						return
					end

					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",source,15000,"roubando")

					SetTimeout(15000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)

						if math.random(100) >= 50 then
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						else
							TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.",8000)
							local policia = vRP.getUsersByPermission("dpla.permissao")
							local x,y,z = vRPclient.getPosition(source)
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
										pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
										SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
						end
					end)
				end
			elseif itemName == "capuz" then
				if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						vRPclient.setCapuz(nplayer)
						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.",8000)
					end
				end
			elseif itemName == "placa" then
                if vRPclient.GetVehicleSeat(source) then
                    if vRP.tryGetInventoryItem(user_id,"placa",1) then
                        local placa = vRP.generatePlate()
                        TriggerClientEvent('Creative:Update',source,'updateMochila')
                        TriggerClientEvent('cancelando',source,true)
                        TriggerClientEvent("vehicleanchor",source)
                        TriggerClientEvent("progress",source,59500,"clonando")
                        SetTimeout(60000,function()
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent("cloneplates",source,placa)
                            --TriggerEvent("setPlateEveryone",placa)
                            TriggerClientEvent("Notify",source,"sucesso","Placa clonada com sucesso.",8000)
                        end)
                    end
                end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ BEBIDAS ]-------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "agua" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"agua",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Água</b>.")
					end)

				end
			elseif itemName == "leite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"leite",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Leite</b>.")
					end)

				end
			elseif itemName == "cafe" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafe",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Café</b>.")
					end)

				end
			elseif itemName == "cafecleite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafecleite",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Cafe com Leite</b>.")
					end)

				end
			elseif itemName == "cafeexpresso" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafeexpresso",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Cafe Expresso</b>.")
					end)

				end
			elseif itemName == "capuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"capuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-55)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Capuccino</b>.")
					end)

				end
			elseif itemName == "frappuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frappuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-65)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Frappuccino</b>.")
					end)

				end
			elseif itemName == "cha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Chá</b>.")
					end)

				end
			elseif itemName == "icecha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"icecha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Chá Gelado</b>.")
					end)

				end
			elseif itemName == "sprunk" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sprunk",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01b",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-65)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Sprunk</b>.")
					end)

				end
			elseif itemName == "cola" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cola",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01a",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-70)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Cola</b>.")
					end)

				end
			elseif itemName == "energetico" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"energetico",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-100)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Energético</b>.")
					end)

				end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ COMIDAS ]-------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "sanduiche" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sanduiche",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer")
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Sanduíche</b>.")
					end)

				end
			elseif itemName == "rosquinha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"rosquinha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer3")
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Rosquinha</b>.")
					end)

				end
			elseif itemName == "hotdog" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"hotdog",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer2")
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>HotDog</b>.")
					end)

				end
			elseif itemName == "xburguer" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"xburguer",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer")
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>xBurguer</b>.")
					end)

				end
			elseif itemName == "chips" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"chips",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","ng_proc_food_chips01b",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Batata Chips</b>.")
					end)

				end
			elseif itemName == "batataf" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"batataf",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_bs_chips",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Batata Frita</b>.")
					end)

				end
			elseif itemName == "pizza" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"pizza",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_res_tt_pizzaplate",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Pizza</b>.")
					end)

				end
			elseif itemName == "frango" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frango",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_cb_nugets",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Frango Frito</b>.")
					end)

				end
			elseif itemName == "bcereal" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bcereal",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_pq",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Barra de Cereal</b>.")
					end)

				end
			elseif itemName == "bchocolate" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bchocolate",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_meto",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Barra de Chocolate</b>.")
					end)

				end
			elseif itemName == "taco" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"taco",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_taco_01",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Taco</b>.")
					end)

				end
			elseif itemName == "yakisoba" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"yakisoba",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_plate_01",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Yakisoba</b>.")
					end)

				end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ REMÉDIOS ]------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "paracetamil" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"paracetamil",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Paracetamil</b>.")
					end)
				end
			elseif itemName == "voltarom" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"voltarom",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Voltarom</b>.")
					end)
				end
			elseif itemName == "trandrylux" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"trandrylux",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Trandrylux</b>.")
					end)
				end
			elseif itemName == "dorfrex" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"dorfrex",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Dorfrex</b>.")
					end)
				end
			elseif itemName == "buscopom" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"buscopom",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Buscopom</b>.")
					end)
				end
			end
		elseif type == "equipar" then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				local identity = vRP.getUserIdentity(user_id)
				weapons[string.gsub(itemName,"wbody|","")] = { ammo = 0 }
				vRPclient._giveWeapons(source,weapons)

				PerformHttpRequest(logDropar, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{
							title = "REGISTRO DE ITEM EQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
							thumbnail = {
							url = "https://i.imgur.com/jSXFScq.png"
							}, 
							fields = {
								{ 
									name = "**Quem equipou:**", 
									value = "` "..identity.name.." "..identity.firstname.."  ["..user_id.."] `"
								},
								{ 
									name = "**Item equipado:**", 
									value = "` "..vRP.itemNameList(itemName).." ` "
								}
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://i.imgur.com/jSXFScq.png" 
							},
							color = 15914080 
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				TriggerClientEvent('Creative:Update',source,'updateMochila')
			end
		elseif type == "recarregar" then
			local uweapons = vRPclient.getWeapons(source)
      		local weaponuse = string.gsub(itemName,"wammo|","")
      		local weaponusename = "wammo|"..weaponuse
			local identity = vRP.getUserIdentity(user_id)
      		if uweapons[weaponuse] then
        		local itemAmount = 0
        		local data = vRP.getUserDataTable(user_id)
        		for k,v in pairs(data.inventory) do
          			if weaponusename == k then
            			if v.amount > 250 then
              				v.amount = 250
            			end

            			itemAmount = v.amount

						if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
							local weapons = {}
							weapons[weaponuse] = { ammo = v.amount }
							itemAmount = v.amount
							vRPclient._giveWeapons(source,weapons,false)
							
							local quantidaItem = vRP.format(parseInt(amount))
							PerformHttpRequest(logDropar, function(err, text, headers) end, 'POST', json.encode({
								embeds = {
									{
										title = "REGISTRO RECARREGAMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
										thumbnail = {
										url = "https://i.imgur.com/jSXFScq.png"
										}, 
										fields = {
											{ 
												name = "**Quem recarregou:**", 
												value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `"
											},
											{ 
												name = "**Munição:**", 
												value = "` [ "..vRP.itemNameList(itemName).." ][ "..quantidaItem.." ] `"
											}
										}, 
										footer = { 
											text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
											icon_url = "https://i.imgur.com/jSXFScq.png" 
										},
										color = 15914080 
									}
								}
							}), { ['Content-Type'] = 'application/json' })
							
							TriggerClientEvent('Creative:Update',source,'updateMochila')
						end
          			end
        		end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PLAYERLEAVE ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GCOLETE ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRPclient.getArmour(source) <= 99 then
		TriggerClientEvent("Notify",source,"negado","Você não pode desequipar um <b>colete danificado</b>.")
	else
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"colete",1)
			vRPclient.setArmour(source,0)
		else
			TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GMOCHILA ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gmochila',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.getExp(user_id,"physical","strength") == 1900 then -- 90Kg
			if vRP.getInventoryMaxWeight(user_id)-vRP.getInventoryWeight(user_id) >= 15 then
				TriggerClientEvent("Notify",source,"sucesso","Você desequipou uma de suas mochilas.")
				vRP.varyExp(user_id,"physical","strength",-580)
				vRP.giveInventoryItem(user_id,"mochila",1)
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa esvaziar a mochila antes de fazer isso.")
			end
		elseif vRP.getExp(user_id,"physical","strength") == 1320 then -- 75Kg
			if vRP.getInventoryMaxWeight(user_id)-vRP.getInventoryWeight(user_id) >= 24 then
				TriggerClientEvent("Notify",source,"sucesso","Você desequipou uma de suas mochilas.")
				vRP.varyExp(user_id,"physical","strength",-650)
				vRP.giveInventoryItem(user_id,"mochila",1)
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa esvaziar a mochila antes de fazer isso.")
			end
		elseif vRP.getExp(user_id,"physical","strength") == 670 then -- 51Kg
			if vRP.getInventoryMaxWeight(user_id)-vRP.getInventoryWeight(user_id) >= 45 then
				TriggerClientEvent("Notify",source,"sucesso","Você desequipou sua mochila.")
				vRP.varyExp(user_id,"physical","strength",-650)
				vRP.giveInventoryItem(user_id,"mochila",1)
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa esvaziar a mochila antes de fazer isso.")
			end
		elseif vRP.getExp(user_id,"physical","strength") == 20 then -- 6Kg
			TriggerClientEvent("Notify",source,"negado","Você não tem mochilas equipadas.")
		end
	end
end)