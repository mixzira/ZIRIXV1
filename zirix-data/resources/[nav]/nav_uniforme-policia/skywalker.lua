----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Policia = {}
Tunnel.bindInterface("nav_uniforme-policia",Policia)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUPAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local agentep = {
    [1885233650] = {
        [1] = { 121,0 }, -- Mascara
        [3] = { 27,0 }, -- Maos
        [4] = { 25,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 6,0 }, -- Acessorios			
        [8] = { 56,0 }, -- Camisa
        [9] = { 0,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 26,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { 121,0 }, -- Mascara
        [3] = { 31,0 }, -- Maos
        [4] = { 31,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 6,0 },	-- Acessorios		
        [8] = { 27,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 25,0 }, -- Jaqueta		
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 3,1 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local instrutor = {
    [1885233650] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 19,0 }, -- Maos
        [4] = { 25,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 6,0 }, -- Acessorios			
        [8] = { 15,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 93,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { 121,0 }, -- Mascara
        [3] = { 31,0 }, -- Maos
        [4] = { 31,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 6,0 },	-- Acessorios		
        [8] = { 21,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 84,0 }, -- Jaqueta		
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 3,1 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local treinamento = {
    [1885233650] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 0,0 }, -- Maos
        [4] = { 25,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 5,0 }, -- Acessorios			
        [8] = { 15,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 93,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { 121,0 }, -- Mascara
        [3] = { 14,0 }, -- Maos
        [4] = { 31,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 2,0 },	-- Acessorios		
        [8] = { 21,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 84,0 }, -- Jaqueta		
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 3,1 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local investigador = {
    [1885233650] = {
        [1] = { 121,0 }, -- Mascara
        [3] = { 1,0 }, -- Maos
        [4] = { 28,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 10,0 }, -- Sapato
        [7] = { 8,0 }, -- Acessorios			
        [8] = { 32,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 29,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { 121,0 }, -- Mascara
        [3] = { 7,0 }, -- Maos
        [4] = { 52,2 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 42,2 }, -- Sapato
        [7] = { 8,0 },	-- Acessorios		
        [8] = { 38,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 7,0 }, -- Jaqueta		
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local tatico = {
    [1885233650] = {
        [1] = { 35,0 }, -- Mascara
        [3] = { 20,0 }, -- Maos
        [4] = { 33,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 1,0 }, -- Acessorios			
        [8] = { 54,0 }, -- Camisa
        [9] = { 7,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 53,0 }, -- Jaqueta
        ["p0"] = { 117,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { 35,0 }, -- Mascara
        [3] = { 31,0 }, -- Maos
        [4] = { 30,2 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 1,0 },	-- Acessorios		
        [8] = { 108,0 }, -- Camisa
        [9] = { 7,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 46,0 }, -- Jaqueta		
        ["p0"] = { 116,0 }, -- Chapeu
        ["p1"] = { 27,4 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

RegisterServerEvent("agentep")
AddEventHandler("agentep",function()
    local user_id = vRP.getUserId(source)
    local custom = agentep
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("instrutor")
AddEventHandler("instrutor",function()
    local user_id = vRP.getUserId(source)
    local custom = instrutor
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("treinamento")
AddEventHandler("treinamento",function()
    local user_id = vRP.getUserId(source)
    local custom = treinamento
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("investigador")
AddEventHandler("investigador",function()
    local user_id = vRP.getUserId(source)
    local custom = investigador
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("tatico")
AddEventHandler("tatico",function()
    local user_id = vRP.getUserId(source)
    local custom = tatico
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("tirar-uniforme")
AddEventHandler("tirar-uniforme",function()
    local user_id = vRP.getUserId(source)
    vRP.removeCloak(source)
end)

function Policia.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"dpla.permissao") or vRP.hasPermission(user_id,"paisana-dpla.permissao") then
        return true
	end
end