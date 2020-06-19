----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-municoes",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local municoes = {
	{ item = "m-ak47" },
	{ item = "m-ak74u" },
	{ item = "m-uzi" },
	{ item = "m-magnum44" },
	{ item = "m-glock" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-municao")
AddEventHandler("produzir-municao",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(municoes) do
			if item == v.item then
				if item == "m-ak47" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",30) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE AK47")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE_MK2",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições AK47</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-ak74u" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_COMPACTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE AKS74U")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_COMPACTRIFLE",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições AKS74U</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-uzi" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 15 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",15) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE UZI")
                                    TriggerClientEvent("bancada-municoes:posicao",source)
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_MICROSMG",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Uzi</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-magnum44" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_REVOLVER_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 6 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 6 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",6) and vRP.tryGetInventoryItem(user_id,"polvora",6) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE MAGNUM 44")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_REVOLVER_MK2",6)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Magnum 44</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-glock" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_COMBATPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 12 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 6 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",12) and vRP.tryGetInventoryItem(user_id,"polvora",6) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE GLOCK")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_COMBATPISTOL",12)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Glock</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>12x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"medellin.permissao") or vRP.hasPermission(user_id,"lider-medellin.permissao") or vRP.hasPermission(user_id,"motoclub.permissao") or vRP.hasPermission(user_id,"lider-motoclub.permissao") then
        return true
    end
end