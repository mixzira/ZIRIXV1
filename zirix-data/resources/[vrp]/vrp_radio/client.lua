local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emR = Tunnel.getInterface("vrp_radio")
----------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
local emradio = false
local onradio = false
----------------------------------------------------------------------------------------------------
--[ ENTRAR NO CANAL ]-------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_radio:radio')
AddEventHandler('vrp_radio:radio', function()

    if not emradio then
        emradio = true
        if emR.permissaoPolicia() then
            exports["mumble-voip"]:SetRadioChannel(5)
        end
    else
        emradio = false
        exports["mumble-voip"]:SetRadioChannel(0)
    end
end)

RegisterNetEvent('vrp_radio:onradio')
AddEventHandler('vrp_radio:onradio', function()
    onradio = true
    exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
    TriggerEvent("vrp_sound:source",'on',0.5)
end)

RegisterNetEvent('vrp_radio:offradio')
AddEventHandler('vrp_radio:offradio', function()
    onradio = false
    exports["mumble-voip"]:SetMumbleProperty("radioEnabled", false)
    TriggerEvent("vrp_sound:source",'off',0.5)
end)