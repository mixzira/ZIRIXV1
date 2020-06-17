local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local idgens = Tools.newIDGenerator()

src = {}
Tunnel.bindInterface("vrp_player",src)

vDIAGNOSTIC = Tunnel.getInterface("vrp_diagnostic")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookItem = "https://discordapp.com/api/webhooks/709950228492582925/JTgjkdAcsbIOXyMJaBivKWhC97VKU5gNZs3OPgCGD0XXdw7xp74fX5l0CZnDLC2Lf6Vb"
local webhookDesEquipar = "https://discordapp.com/api/webhooks/709949988154900582/SW_x4rWBl8SGaukgaN4vT69vgKHeCy6LmQSver7PmgS4dD3eNxvq5SdhytsyQDCB_GfA"
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CHECK ROUPAS ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkMascara()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"mascara") >= 1 then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui uma <b>mascara</b> em sua mochila.") 
			return false
		end
	end
end

function src.checkOculos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"oculos") >= 1 then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui uma <b>óculos</b> em sua mochila.") 
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ITEMLIST ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários legais ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["mochila"] = { index = "mochila", nome = "Mochila" },
	["celular"] = { index = "celular", nome = "iFruit XI" },
	["radio"] = { index = "radio", nome = "WalkTalk" },
	["mascara"] = { index = "mascara", nome = "Mascara" },
	["oculos"] = { index = "oculos", nome = "Óculos" },
	["identidade"] = { index = "identidade", nome = "Identidade" },
	["colete"] = { index = "colete", nome = "Colete Balístico" },
	["militec"] = { index = "militec", nome = "Militec" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["dinheiro-sujo"] = { index = "dinheiro-sujo", nome = "Dinheiro Sujo" },
	["algema"] = { index = "algema", nome = "Algema" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	["placa"] = { index = "placa", nome = "Placa" },
	["c4"] = { index = "c4", nome = "C4" },
	["serra"] = { index = "serra", nome = "Serra" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas Não Alcoólicas ]-----------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["agua"] = { index = "agua", nome = "Água" },
	["leite"] = { index = "leite", nome = "Leite" },
	["cafe"] = { index = "cafe", nome = "Café" },
	["cafecleite"] = { index = "cafecleite", nome = "Café com leite" },
	["cafeexpresso"] = { index = "cafeexpresso", nome = "Café Expresso" },
	["capuccino"] = { index = "capuccino", nome = "Capuccino" },
	["frappuccino"] = { index = "frappuccino", nome = "Frapuccino" },
	["cha"] = { index = "cha", nome = "Chá" },
	["icecha"] = { index = "icecha", nome = "Chá Gelado" },
	["sprunk"] = { index = "sprunk", nome = "Sprunk" },
	["cola"] = { index = "cola", nome = "Cola" },
	["energetico"] = { index = "energetico", nome = "Energético" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas Alcoólicas ]---------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["pibwassen"] = { index = "pibwassen", nome = "PibWassen" },
	["tequilya"] = { index = "tequilya", nome = "Tequilya" },
	["patriot"] = { index = "patriot", nome = "Patriot" },
	["blarneys"] = { index = "blarneys", nome = "Blarneys" },
	["jakeys"] = { index = "jakeys", nome = "Jakeys" },
	["barracho"] = { index = "barracho", nome = "Barracho" },
	["ragga"] = { index = "ragga", nome = "Ragga" },
	["nogo"] = { index = "nogo", nome = "Nogo" },
	["mount"] = { index = "mount", nome = "Mount" },
	["cherenkov"] = { index = "cherenkov", nome = "Cherenkov" },
	["bourgeoix"] = { index = "bourgeoix", nome = "Bourgeoix" },
	["bleuterd"] = { index = "bleuterd", nome = "Bleuterd" },
	---------------------------------------------------------------------------------------------------
	--[ Comidas de FastFood ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["sanduiche"] = { index = "sanduiche", nome = "Sanduíche" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha" },
	["hotdog"] = { index = "hotdog", nome = "HotDog" },
	["xburguer"] = { index = "xburguer", nome = "xBurguer" },
	["chips"] = { index = "chips", nome = "Batata Chips" },
	["batataf"] = { index = "batataf", nome = "Batata Frita" },
	["pizza"] = { index = "pizza", nome = "Pedaço de Pizza" },
	["frango"] = { index = "frango", nome = "Frango Frito" },
	["bcereal"] = { index = "bcereal", nome = "Barra de Cereal" },
	["bchocolate"] = { index = "bchocolate", nome = "Barra de Chocolate" },
	["taco"] = { index = "taco", nome = "Taco" },
	["yakisoba"] = { index = "yakisoba", nome = "Yakisoba" },
	---------------------------------------------------------------------------------------------------
	--[ Remédios ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["paracetamil"] = { index = "paracetamil", nome = "Paracetamil" },
	["voltarom"] = { index = "voltarom", nome = "Voltarom" },
	["trandrylux"] = { index = "trandrylux", nome = "Trandrylux" },
	["dorfrex"] = { index = "dorfrex", nome = "Dorfrex" },
	["buscopom"] = { index = "buscopom", nome = "Buscopom" },
	---------------------------------------------------------------------------------------------------
	--[ Receitas ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["r-paracetamil"] = { index = "r-paracetamil", nome = "Receituário Paracetamil" },
	["r-voltarom"] = { index = "r-voltarom", nome = "Receituário Voltarom" },
	["r-trandrylux"] = { index = "r-trandrylux", nome = "Receituário Trandrylux" },
	["r-dorfrex"] = { index = "r-dorfrex", nome = "Receituário Dorfrex" },
	["r-buscopom"] = { index = "r-buscopom", nome = "Receituário Buscopom" },
	--------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 01 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["meta-alta"] = { index = "meta-alta", nome = "Metanfetamina HQ" },
	["meta-media"] = { index = "meta-media", nome = "Metanfetamina MQ" },
	["meta-baixa"] = { index = "meta-baixa", nome = "Metanfetamina LQ" },
	--[ Sub produto ]----------------------------------------------------------------------------------
	["composito-alta"] = { index = "composito-alta", nome = "Compósito HQ" },
	["composito-media"] = { index = "composito-media", nome = "Compósito MQ" },
	["composito-baixa"] = { index = "composito-baixa", nome = "Compósito LQ" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["nitrato-amonia"] = { index = "nitrato-amonia", nome = "Nitrato de Amônia" },
	["hidroxido-sodio"] = { index = "hidroxido-sodio", nome = "Hidróxido de Sódio" },
	["pseudoefedrina"] = { index = "pseudoefedrina", nome = "Pseudoefedrina" },
	["eter"] = { index = "eter", nome = "Éter" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 02 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["coca-alta"] = { index = "coca-alta", nome = "Cocaína HQ" },
	["coca-media"] = { index = "coca-media", nome = "Cocaína MQ" },
	["coca-baixa"] = { index = "coca-baixa", nome = "Cocaína LQ" },
	--[ Sub produto ]----------------------------------------------------------------------------------
	["pasta-alta"] = { index = "pasta-alta", nome = "Pasta Base HQ" },
	["pasta-media"] = { index = "pasta-media", nome = "Pasta Base MQ" },
	["pasta-baixa"] = { index = "pasta-baixa", nome = "Pasta Base LQ" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["acido-sulfurico"] = { index = "acido-sulfurico", nome = "Ácido Sulfúrico" },
	["folhas-coca"] = { index = "folhas-coca", nome = "Folhas de Coca" },
	["calcio-po"] = { index = "calcio-po", nome = "Cálcio em Pó" },
	["querosene"] = { index = "querosene", nome = "Querosene" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Maconha ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["maconha-alta"] = { index = "maconha-alta", nome = "Maconha HQ" },
	["maconha-media"] = { index = "maconha-media", nome = "Maconha MQ" },
	["maconha-baixa"] = { index = "maconha-baixa", nome = "Prensado LQ" },
	--[ Sub produto ]----------------------------------------
	["canabis-alta"] = { index = "canabis-alta", nome = "Cannabis sativa HQ" },
	["canabis-media"] = { index = "canabis-media", nome = "Cannabis sativa MQ" },
	["canabis-baixa"] = { index = "canabis-baixa", nome = "Cannabis sativa LQ" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 02 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["corpo-ak47"] = { index = "corpo-ak47", nome = "Corpo de AK-47" },
	["corpo-aks74u"] = { index = "corpo-aks74u", nome = "Corpo de AKS-74U" },
	["corpo-uzi"] = { index = "corpo-uzi", nome = "Corpo de Uzi" },
	["corpo-glock"] = { index = "corpo-glock", nome = "Corpo de Glock 19" },
	["corpo-magnum"] = { index = "corpo-magnum", nome = "Corpo de Magnum 44" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["molas"] = { index = "molas", nome = "Molas" },
	["placa-metal"] = { index = "placa-metal", nome = "Placa de Metal" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho", type = "usar" },
	["capsulas"] = { index = "capsulas", nome = "Capsulas" },
	["polvora"] = { index = "polvora", nome = "Polvora" },
	---------------------------------------------------------------------------------------------------
	--[ Empregos ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["diamante"] = { index = "diamante", nome = "Min. Diamante" },
	["ouro"] = { index = "ouro", nome = "Min. Ouro" },
	["bronze"] = { index = "bronze", nome = "Min. Bronze" },
	["ferro"] = { index = "ferro", nome = "Min. Ferro" },
	["rubi"] = { index = "rubi", nome = "Min. Rubi" },
	["esmeralda"] = { index = "esmeralda", nome = "Min. Esmeralda" },
	["safira"] = { index = "safira", nome = "Min. Safira" },
	["topazio"] = { index = "topazio", nome = "Min. Topazio" },
	["ametista"] = { index = "ametista", nome = "Min. Ametista" },
	["diamante2"] = { index = "diamante2", nome = "Diamante" },
	["ouro2"] = { index = "ouro2", nome = "Ouro" },
	["bronze2"] = { index = "bronze2", nome = "Bronze" },
	["ferro2"] = { index = "ferro2", nome = "Ferro" },
	["rubi2"] = { index = "rubi2", nome = "Rubi" },
	["esmeralda2"] = { index = "esmeralda2", nome = "Esmeralda" },
	["safira2"] = { index = "safira2", nome = "Safira" },
	["topazio2"] = { index = "topazio2", nome = "Topazio" },
	["ametista2"] = { index = "ametista2", nome = "Ametista" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de lixo" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de leite" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa vazia" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda" },
	["tora"] = { index = "tora", nome = "Tora" },
	["nf"] = { index = "nf", nome = "Nota Fisca" },
	["portearmas"] = { index = "porte", nome = "Porte de Armas" },
	---------------------------------------------------------------------------------------------------
	--[ ARMAS / OUTROS ]-------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	---------------------------------------------------------------------------------------------------
	--[ CORPO A CORPO ]--------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
	---------------------------------------------------------------------------------------------------
	--[ PISTOLA ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum44", nome = "Magnum 44" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven" },
	["wbody|WEAPON_PISTOL50"] = { index = "deserteagle", nome = "Desert Eagle" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser" },
	---------------------------------------------------------------------------------------------------
	--[ FUZIL ]----------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4A1" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak47", nome = "AK-47" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS-74U" },
	---------------------------------------------------------------------------------------------------
	--[ SMG ]------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi" },
	---------------------------------------------------------------------------------------------------
	--[ SHOTGUN ]--------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870" },
	---------------------------------------------------------------------------------------------------
	--[ RIFLES ]---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
	---------------------------------------------------------------------------------------------------
	--[ MUNIÇÕES ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock 19" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "M.Magnum 357" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M.FN Five Seven" },
	["wammo|WEAPON_PISTOL50"] = { index = "m-deserteagle", nome = "M.Desert Eagle" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "M.M4A1" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak47", nome = "M.AK-47" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS-74U" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "M.MP5" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.Uzi" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "M.Remington 870" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ITEM ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args[1] and args[2] and itemlist[args[1]] ~= nil then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))

			local nomeItem = args[1]
			local quantItem = parseInt(args[2])
			

			PerformHttpRequest(webhookItem, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE ITEMS:\n⠀⠀",
						thumbnail = {
						url = "https://i.imgur.com/F3MD9hY.png"
						}, 
						fields = {
							{ 
								name = "**QUME DEU O COMANDO:**", 
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"
							},
							{
								name = "**ITEM GERADO**",
								value = "[ **Item: "..nomeItem.."** ][ **Quantidade: "..quantItem.."** ]\n⠀⠀"
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

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ USER VEHS [ADMIN]]-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"administrador.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESKIN ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reskin',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
	vRPclient._setCustomization(vRPclient.getCustomization(source))		
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ INVASAO ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local guetos = {}
RegisterCommand('invasao',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) > 100 then
		if vRP.hasPermission(user_id,"ballas.permissao") or vRP.hasPermission(user_id,"marabunta.permissao") or vRP.hasPermission(user_id,"families.permissao") or vRP.hasPermission(user_id,"vagos.permissao") then	
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player and player ~= uplayer then
					async(function()
						local id = idgens:gen()
						if vRP.hasPermission(user_id,"ballas.permissao") then
							guetos[id] = vRPclient.addBlip(player,x,y,z,437,27,"Localização da invasão",0.8,false)
							TriggerClientEvent("Notify",player,"negado","Localização da invasão entre gangues recebida de <b>Ballas</b>.")
						elseif vRP.hasPermission(user_id,"vagos.permissao") then
							guetos[id] = vRPclient.addBlip(player,x,y,z,437,46,"Localização da invasão",0.8,false)
							TriggerClientEvent("Notify",player,"negado","Localização da invasão entre gangues recebida de <b>Vagos</b>.")
						elseif vRP.hasPermission(user_id,"families.permissao") then
							guetos[id] = vRPclient.addBlip(player,x,y,z,437,25,"Localização da invasão",0.8,false)
							TriggerClientEvent("Notify",player,"negado","Localização da invasão entre gangues recebida de <b>Families</b>.")
						elseif vRP.hasPermission(user_id,"marabunta.permissao") then
							guetos[id] = vRPclient.addBlip(player,x,y,z,437,38,"Localização da invasão",0.8,false)
							TriggerClientEvent("Notify",player,"negado","Localização da invasão entre gangues recebida de <b>Marabunta</b>.")
						end
						vRPclient._playSound(player,"5s_To_Event_Start_Countdown","GTAO_FM_Events_Soundset")
						vRPclient._playSound(source,"5s_To_Event_Start_Countdown","GTAO_FM_Events_Soundset")
						SetTimeout(60000,function() vRPclient.removeBlip(player,guetos[id]) idgens:free(id) end)
					end)
				end
			end
			TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ID ]---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,rawCommand)	
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(nuser_id)
		vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #d1257d; }","<div class=\"local\"><b>Passaporte:</b> ( "..vRP.format(identity.user_id).." )</div>")
		vRP.request(source,"Você deseja fechar o registro geral?",1000)
		vRPclient.removeDiv(source,"completerg")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REVISTAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent('cancelando',nplayer,true)
		TriggerClientEvent('carregar',nplayer,source)
		--vRPclient._playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
		vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
		TriggerClientEvent("progress",source,5000,"revistando")
		SetTimeout(5000,function()

			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end

			--vRPclient._stopAnim(source,false)
			vRPclient._stopAnim(nplayer,false)
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent('cancelando',nplayer,false)
			TriggerClientEvent('carregar',nplayer,source)
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		end)
		TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
		--TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.",8000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SALÁRIO ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	{ ['permissao'] = "juiz.permissao", ['nome'] = "Juiz(a)", ['payment'] = 10000 },
	{ ['permissao'] = "procurador.permissao", ['nome'] = "Procurador(a)", ['payment'] = 7000 },
	{ ['permissao'] = "promotor.permissao", ['nome'] = "Promotor(a)", ['payment'] = 7000 },
	{ ['permissao'] = "defensor.permissao", ['nome'] = "Defensor(a) Público(a)", ['payment'] = 4900 },

	{ ['permissao'] = "chefe-policia.permissao", ['nome'] = "Chefe de Polícia", ['payment'] = 8500 },
	{ ['permissao'] = "sub-chefe-policia.permissao", ['nome'] = "Sub Chefe de Polícia", ['payment'] = 7225 },
	{ ['permissao'] = "inspetor.permissao", ['nome'] = "Inspetor de Polícia", ['payment'] = 6140 },
	{ ['permissao'] = "capitao.permissao", ['nome'] = "Capitão", ['payment'] = 5220 },
	{ ['permissao'] = "tenente.permissao", ['nome'] = "Tenente", ['payment'] = 4430 },
	{ ['permissao'] = "sub-tenente.permissao", ['nome'] = "Sub Tenente", ['payment'] = 3100 },
	{ ['permissao'] = "um-sargento.permissao", ['nome'] = "1º Sargento", ['payment'] = 2480 },
	{ ['permissao'] = "dois-sargento.permissao", ['nome'] = "2º Sargento", ['payment'] = 2100 },
	{ ['permissao'] = "agente-policia.permissao", ['nome'] = "Agente de Polícia", ['payment'] = 1785 },
	{ ['permissao'] = "recruta-policia.permissao", ['nome'] = "Recruta", ['payment'] = 900 },

	{ ['permissao'] = "diretor-geral.permissao", ['nome'] = "Diretor Geral", ['payment'] = 8500 },
	{ ['permissao'] = "diretor-auxiliar.permissao", ['nome'] = "Diretor Auxiliar", ['payment'] = 7225 },
	{ ['permissao'] = "medico-chefe.permissao", ['nome'] = "Médico Chefe", ['payment'] = 6140 },
	{ ['permissao'] = "medico-cirurgiao.permissao", ['nome'] = "Médico Cirurgião", ['payment'] = 5220 },
	{ ['permissao'] = "medico-aulixiar.permissao", ['nome'] = "Médico Auxiliar", ['payment'] = 4430 },
	{ ['permissao'] = "medico.permissao", ['nome'] = "Médico", ['payment'] = 3100 },
	{ ['permissao'] = "paramedico.permissao", ['nome'] = "Paramédico", ['payment'] = 2480 },
	{ ['permissao'] = "enfermeiro.permissao", ['nome'] = "Enfermeiro", ['payment'] = 2100 },
	{ ['permissao'] = "socorrista.permissao", ['nome'] = "Socorrista", ['payment'] = 1785 },
	{ ['permissao'] = "estagiario.permissao", ['nome'] = "Estágiario", ['payment'] = 900 }
}

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id,v.permissao) then
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.")
				vRP.giveBankMoney(user_id,parseInt(v.payment))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ NOCARJACK ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ AFKSYSTEM ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"administrador.permissao") then
        DropPlayer(source,"Voce foi desconectado por ficar ausente.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SEQUESTRO ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ENVIAR ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	  local identitynu = vRP.getUserIdentity(nuser_id)
	  
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			SendWebhookMessage(webhookenviardinheiro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: $"..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.",8000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GARMAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local rtime = math.random(3,8)

	TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Suas armas estão sendo desequipadas.",9500)
	TriggerClientEvent("progress",source,10000,"guardando")

	SetTimeout(1000*rtime,function()
		if user_id then
			local weapons = vRPclient.replaceWeapons(source,{})
			for k,v in pairs(weapons) do
				vRP.giveInventoryItem(user_id,"wbody|"..k,1)
				if v.ammo > 0 then
					vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
				end
			end
			TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
		end
	end)
	SetTimeout(10000,function()
		TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUBAR ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("dpla.permissao")
		if #policia > 0 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"sucesso","Roubo concluido com sucesso.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SAQUEAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("dpla.permissao")
			local itens_saque = {}
			if #policia >= 0 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
				TriggerClientEvent("progress",source,20000,"saqueando")
				SetTimeout(20000,function()
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
										table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTIDADE]: "..1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
					SendWebhookMessage(webhooksaquear,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SAQUEOU]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRYTOW ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRUNK ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WINS ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ HOOD ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DOORS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CALL ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	vida = vRPclient.getHealth(source)
	vRPclient._CarregarObjeto(source,"cellphone@","cellphone_call_to_text","prop_amb_phone",50,28422)
	if user_id then
		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			vRPclient._stopAnim(source,false)
			vRPclient._DeletarObjeto(source)
			return
		end

		local x,y,z = vRPclient.getPosition(source)
		local players = {}
		vRPclient._stopAnim(source,false)
		vRPclient._DeletarObjeto(source)
		local especialidade = false
		if args[1] == "911" then
			players = vRP.getUsersByPermission("dpla.permissao")
			especialidade = "agentes do <b>departamento de policia</b>"

		elseif args[1] == "112" then
			players = vRP.getUsersByPermission("dmla.permissao")
			especialidade = "colaboradores do <b>departamento médico</b>"

		elseif args[1] == "mec" then
			players = vRP.getUsersByPermission("mecanico.permissao")
			especialidade = "mecânicos"

		elseif args[1] == "taxi" then
			players = vRP.getUsersByPermission("taxista.permissao")
			especialidade = "taxistas"

		elseif args[1] == "adv" then
			players = vRP.getUsersByPermission("advogado.permissao")
			especialidade = "advogados"

		elseif args[1] == "adm" then
			players = vRP.getUsersByPermission("administrador.permissao")	
			especialidade = "Administradores"

		end

		local adm = ""

		if especialidade == "Administradores" then
			adm = "[ADM] "
		end
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		
		if #players == 0  and especialidade ~= "policiais" then
			TriggerClientEvent("Notify",source,"importante","Não há "..especialidade.." em serviço.")
		else
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player and player ~= uplayer then
					async(function()
						vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
						TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
						local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
						if ok then
							if not answered then
								answered = true
								local identity = vRP.getUserIdentity(nuser_id)
								TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								vRPclient._setGPS(player,x,y)
							else
								TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
								vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
						local id = idgens:gen()
						blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
						SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MEC ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,"Central Mecânica",{255,128,0},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MR ]---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "mecanico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local mec = vRP.getUsersByPermission(permission)
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,191,128},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CARTAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROLL ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('ChatRoll')
AddEventHandler('ChatRoll',function(text)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent('DisplayRoll',-1,text,source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CARD ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MASCARA ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmascara",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ OCULOS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setoculos",source,args[1],args[2])
				end
			end
		end
	end
end)
