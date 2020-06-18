local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_identidade",vRPN)
Proxy.addInterface("vrp_identidade",vRPN)

local cfg = module("vrp","cfg/groups")
local groups = cfg.groups

local identidade = false
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local multas = vRP.getUData(user_id,"vRP:multas")
		local mymultas = json.decode(multas) or 0
		local paypal = vRP.getUData(user_id,"vRP:paypal")
		local mypaypal = json.decode(paypal) or 0
		local groupv = vRPN.getUserGroupByType(user_id,"job")
		local cargo = vRPN.getUserGroupByType(user_id,"hie")
		if cargo ~= "" then
			groupv = cargo
		end
		if identity then
			return identity.foto,identity.name,identity.firstname,identity.user_id,identity.registration,identity.age,identity.phone,vRP.format(parseInt(cash)),vRP.format(parseInt(banco)),vRP.format(parseInt(mymultas)),vRP.format(parseInt(mypaypal)),groupv
		end
	end
end

function vRPN.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end