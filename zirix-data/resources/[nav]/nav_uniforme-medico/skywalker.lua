----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Resg = {}
Tunnel.bindInterface("nav_uniforme-medico",Resg)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUPAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local direcao = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 4,0 },
        [4] = { 10,0 },
        [5] = { -1,0 },
        [6] = { 21,0 },
        [7] = { -1,0 },			
        [8] = { 72,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 31,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 7,0 },
        [4] = { 52,2 },
        [5] = { -1,0 },
        [6] = { 42,2 },
        [7] = { -1,0 },			
        [8] = { 38,1 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 7,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local medico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 77,0 },
        [4] = { 28,8 },
        [5] = { -1,0 },
        [6] = { 21,9 },
        [7] = { 126,0 },			
        [8] = { 34,5 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 31,7 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 92,0 },
        [4] = { 23,0 },
        [5] = { -1,0 },
        [6] = { 7,1 },
        [7] = { 96,0 },			
        [8] = { 38,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 7,1 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local paramedico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 74,0 },
        [4] = { 96,0 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 126,0 },			
        [8] = { 129,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 250,0 },
        ["p0"] = { 122,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 96,0 },
        [4] = { 99,0 },
        [5] = { -1,0 },
        [6] = { 27,0 },
        [7] = { 96,0 },			
        [8] = { 159,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 258,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local socorrista = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 79,0 },
        [4] = { 25,5 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 127,0 },			
        [8] = { 15,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 249,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 92,0 },
        [4] = { 23,0 },
        [5] = { -1,0 },
        [6] = { 27,0 },
        [7] = { 97,0 },			
        [8] = { 104,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 257,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local enfermeiro = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 74,0 },
        [4] = { 96,0 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 127,0 },			
        [8] = { 15,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 146,6 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 96,0 },
        [4] = { 23,0 },
        [5] = { -1,0 },
        [6] = { 1,0 },
        [7] = { 97,0 },			
        [8] = { 78,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 141,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

RegisterServerEvent("direcao")
AddEventHandler("direcao",function()
    local user_id = vRP.getUserId(source)
    local custom = direcao
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

RegisterServerEvent("medico")
AddEventHandler("medico",function()
    local user_id = vRP.getUserId(source)
    local custom = medico
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

RegisterServerEvent("paramedico")
AddEventHandler("paramedico",function()
    local user_id = vRP.getUserId(source)
    local custom = paramedico
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

RegisterServerEvent("socorrista")
AddEventHandler("socorrista",function()
    local user_id = vRP.getUserId(source)
    local custom = socorrista
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

RegisterServerEvent("enfermeiro")
AddEventHandler("enfermeiro",function()
    local user_id = vRP.getUserId(source)
    local custom = enfermeiro
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
    vRP.removeCloak(source)
end)

function Resg.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"dmla.permissao") or vRP.hasPermission(user_id,"paisana-dmla.permissao") then
        return true
	end
end