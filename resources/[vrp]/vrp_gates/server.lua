local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local cfg = module("vrp_gates","config")

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		TriggerClientEvent('vrpgatesystem:load',source,cfg.list)
	end
end)

RegisterServerEvent('vrpgatesystem:open')
AddEventHandler('vrpgatesystem:open',function(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,cfg.list[id].perm) or vRP.hasPermission(user_id,cfg.list[id].perm2) or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		cfg.list[id].lock = not cfg.list[id].lock
		TriggerClientEvent('vrpgatesystem:statusSend',-1,id,cfg.list[id].lock)
		if cfg.list[id].other ~= nil then
			local idsecond = cfg.list[id].other
			cfg.list[idsecond].lock = cfg.list[id].lock
			TriggerClientEvent('vrpgatesystem:statusSend',-1,idsecond,cfg.list[id].lock)
		end
	end
end)