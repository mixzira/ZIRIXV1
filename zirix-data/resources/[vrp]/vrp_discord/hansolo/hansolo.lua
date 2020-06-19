local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emD = Tunnel.getInterface("vrp_discord")
----------------------------------------------------------------------------------------------------
--[ DISCORD ]---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(703232388897177701) -- Adquira o seu AppID em: https://discord.com/developers/applications

	    local players = emD.discord()
		
	    SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetText('Zirix 1.4')
		SetRichPresence("Adquira a sua em: discord.gg/6p3M3Cz")
	    --SetRichPresence("Jogadores conectados: "..players.." de 256")
		Citizen.Wait(10000)
	end
end)