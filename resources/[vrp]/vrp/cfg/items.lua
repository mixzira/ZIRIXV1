local cfg = {}

cfg.items = {
	---------------------------------------------------------
	--[ Ultilitários legais ]--------------------------------
	---------------------------------------------------------
	["mochila"] = { "Mochila",0 },
	["celular"] = { "iFruit XI",0.3 },
	["radio"] = { "WalkTalk",0.3 },
	["mascara"] = { "Mascara",0.3 },
	["oculos"] = { "Óculos",0.1 },
	["identidade"] = { "Identidade",0.1 },
	["portearmas"] = { "Porte de Armas",0.1 },
	["colete"] = { "Colete",2.0 },
	["militec"] = { "Militec",1.0 },
	["repairkit"] = { "Kit de Reparos",1.0 },
	---------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------
	---------------------------------------------------------
	["dinheiro-sujo"] = { "Dinheiro Sujo", 0.0 },
	["algema"] = { "Algema",0.4 },
	["lockpick"] = { "Lockpick",0.2 },
	["capuz"] = { "Capuz",0.1 },
	["placa"] = { "Placa",0.6 },
	["c4"] = { "c4",2.0 },
	["serra"] = { "Serra",1.0 },
	["furadeira"] = { "Furadeira",1.0 },
	---------------------------------------------------------
	--[ Bebidas Não Alcoólicas ]-----------------------------
	---------------------------------------------------------
	["agua"] = { "Água",0.3 },
	["leite"] = { "Leite",1.0 },
	["cafe"] = { "Café",0.2 },
	["cafecleite"] = { "Café com leite",0.3 },
	["cafeexpresso"] = { "Café Expresso",0.3 },
	["capuccino"] = { "Capuccino",0.5 },
	["frappuccino"] = { "Frapuccino",0.5 },
	["cha"] = { "Chá",0.3 },
	["icecha"] = { "Chá Gelado",0.3 },
	["sprunk"] = { "Sprunk",0.3 },
	["cola"] = { "Cola",0.3 },
	["energetico"] = { "Energético",0.6 },
	---------------------------------------------------------
	--[ Bebidas Alcoólicas ]---------------------------------
	---------------------------------------------------------
	["pibwassen"] = { "PibWassen",0.6 },
	["tequilya"] = { "Tequilya",0.6 },
	["patriot"] = { "Patriot",0.6 },
	["blarneys"] = { "Blarneys",0.6 },
	["jakeys"] = { "Jakeys",0.6 },
	["barracho"] = { "Barracho",0.6 },
	["ragga"] = { "Ragga",0.6 },
	["nogo"] = { "Nogo",0.6 },
	["mount"] = { "Mount",0.6 },
	["cherenkov"] = { "Cherenkov",0.6 },
	["bourgeoix"] = { "Bourgeoix",0.6 },
	["bleuterd"] = { "Bleuterd",0.6 },
	---------------------------------------------------------
	--[ Comidas de FastFood ]--------------------------------
	---------------------------------------------------------
	["sanduiche"] = { "Sanduíche",0.3 },
	["rosquinha"] = { "Rosquinha",0.2 },
	["hotdog"] = { "HotDog",0.4 },
	["xburguer"] = { "xBurguer",0.6 },
	["chips"] = { "Batata Chips",0.5 },
	["batataf"] = { "Batata Frita",0.6 },
	["pizza"] = { "Pedaço de Pizza",0.5 },
	["frango"] = { "Frango Frito",0.6 },
	["bcereal"] = { "Barra de Cereal",0.3 },
	["bchocolate"] = { "Barra de Chocolate",0.3 },
	["taco"] = { "Taco",0.5 },
	["yakisoba"] = { "Yakisoba",0.5 },
	---------------------------------------------------------
	--[ Remédios ]-------------------------------------------
	---------------------------------------------------------
	["paracetamil"] = { "Paracetamil",0.2 },
	["voltarom"] = { "Voltarom",0.2 },
	["trandrylux"] = { "Trandrylux",0.2 },
	["dorfrex"] = { "Dorfrex",0.2 },
	["buscopom"] = { "Buscopom",0.2 },
	---------------------------------------------------------
	--[ Receitas ]-------------------------------------------
	---------------------------------------------------------
	["r-paracetamil"] = { "Receituário Paracetamil",0.0 },
	["r-voltarom"] = { "Receituário Voltarom",0.0 },
	["r-trandrylux"] = { "Receituário Trandrylux",0.0 },
	["r-dorfrex"] = { "Receituário Dorfrex",0.0 },
	["r-buscopom"] = { "Receituário Buscopom",0.0 },
	---------------------------------------------------------
	--[ Organização Criminosa de Meta ]----------------------
	---------------------------------------------------------
	["meta-alta"] = { "Metanfetamina HQ",0.1 },
	["meta-media"] = { "Metanfetamina MQ",0.1 },
	["meta-baixa"] = { "Metanfetamina LQ",0.1 },
	--[ Ingredientes ]---------------------------------------
	["composito-alta"] = { "Compósito HQ",1.0 },
	["composito-media"] = { "Compósito MQ",1.0 },
	["composito-baixa"] = { "Compósito LQ",1.0 },
	--[ Ingredientes ]---------------------------------------
	["nitrato-amonia"] = { "Nitrato de Amônia",0.5 },
	["hidroxido-sodio"] = { "Hidróxido de Sódio",0.5 },
	["pseudoefedrina"] = { "Pseudoefedrina",0.5 },
	["eter"] = { "Éter",0.5 },
	---------------------------------------------------------
	--[ Organização Criminosa de Cocaína ]-------------------
	---------------------------------------------------------
	["coca-alta"] = { "Cocaína HQ",0.1 },
	["coca-media"] = { "Cocaína MQ",0.1 },
	["coca-baixa"] = { "Cocaína LQ",0.1 },
	--[ Sub produto ]----------------------------------------
	["pasta-alta"] = { "Pasta Base HQ",1.0 },
	["pasta-media"] = { "Pasta Base MQ",1.0 },
	["pasta-baixa"] = { "Pasta Base LQ",1.0 },
	--[ Ingredientes ]---------------------------------------
	["acido-sulfurico"] = { "Ácido Sulfúrico",0.5 },
	["folhas-coca"] = { "Folhas de Coca",0.5 },
	["calcio-po"] = { "Cálcio em Pó",0.5 },
	["querosene"] = { "Querosene",0.5 },
	---------------------------------------------------------
	--[ Organizações Criminosas de Armas ]-------------------
	---------------------------------------------------------
	["corpo-ak47"] = { "Corpo de AK-47",2.0 },
	["corpo-aks74u"] = { "Corpo de AKS-74U",2.0 },
	["corpo-uzi"] = { "Corpo de Uzi",1.0 },
	["corpo-glock"] = { "Corpo de Glock 19",1.0 },
	["corpo-magnum"] = { "Corpo de Magnum 44",1.0 },
	--[ Ingredientes ]---------------------------------------
	["molas"] = { "Pacote de Molas",0.2 },
	["placa-metal"] = { "Placa de Metal",1.0 },
	["gatilho"] = { "Gatilho",0.1 },
	["capsulas"] = { "Pacote de Capsulas",0.2 },
	["polvora"] = { "Pacote de Pólvora",0.5 },
	---------------------------------------------------------
	--[ Empregos ]-------------------------------------------
	---------------------------------------------------------
	["diamante"] = { "Min. Diamante",0.90 },
	["ouro"] = { "Min. Ouro",0.75 },
	["bronze"] = { "Min. Bronze",0.60 },
	["ferro"] = { "Min. Ferro",0.60 },
	["rubi"] = { "Min. Rubi",0.75 },
	["esmeralda"] = { "Min. Esmeralda",0.90 },
	["safira"] = { "Min. Safira",0.25 },
	["topazio"] = { "Min. Topazio",0.90 },
	["ametista"] = { "Min. Ametista",0.60 },
	["diamante2"] = { "Diamante",0.30 },
	["ouro2"] = { "Ouro",0.25 },
	["bronze2"] = { "Bronze",0.20 },
	["ferro2"] = { "Ferro",0.30 },
	["rubi2"] = { "Rubi",0.25 },
	["esmeralda2"] = { "Esmeralda",0.30 },
	["safira2"] = { "Safira",0.25 },
	["topazio2"] = { "Topazio",0.30 },
	["ametista2"] = { "Ametista",0.20 },
	["sacodelixo"] = { "Saco de lixo",0.20 },
	["garrafadeleite"] = { "Garrafa de leite",0.50 },
	["garrafavazia"] = { "Garrafa vazia",0.25 },
	["encomenda"] = { "Encomenda",0.5 },
	["tora"] = { "Tora",1.0 },
	["nf"] = { "Nota Fisca",0.1 }
}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg