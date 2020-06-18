-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_dealership",src)
vCLIENT = Tunnel.getInterface("vrp_dealership")
local inventory = module("vrp","cfg/inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local motos = {}
local carros = {}
local import = {} 
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(vRP.vehicleGlobal()) do
		if v.tipo == "carros" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(carros,{ k = k, nome = v.name, price = v.price, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "motos" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(motos,{ k = k, nome = v.name, price = v.price, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "import" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(import,{ k = k, nome = v.name, price = v.price, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateVehicles(vname,vehtype)
	if vehtype == "carros" then
		for k,v in pairs(carros) do
			if v.k == vname then
				table.remove(carros,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = inventory.chestweight[vname] or 50
					table.insert(carros,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "motos" then
		for k,v in pairs(motos) do
			if v.k == vname then
				table.remove(motos,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = inventory.chestweight[vname] or 50
					table.insert(motos,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "import" then
		for k,v in pairs(import) do
			if v.k == vname then
				table.remove(import,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = inventory.chestweight[vname] or 50
					table.insert(import,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Carros()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carros
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Motos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Import()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return import
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDAS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Possuidos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local veiculos = {}
		local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicle) do
			local bau = inventory.chestweight[v.vehicle] or 50
			table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau) })
		end
		return veiculos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function src.buyDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local maxvehs = vRP.query("creative/con_maxvehs",{ user_id = parseInt(user_id) })
		local maxgars = vRP.query("creative/get_users",{ user_id = parseInt(user_id) })
		if vRP.hasPermission(user_id,"administrador.permissao") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 100 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"vendedor.permissao") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 50 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"ouro.permissao") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 5 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"platina.permissao") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 10 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		else
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 1 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		end

		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
		if vehicle[1] then
			TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(name).."</b> em sua garagem.",10000)
			return
		else
			local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
			if parseInt(rows2[1].quantidade) <= 0 then
				TriggerClientEvent("Notify",source,"aviso","Estoque de <b>"..vRP.vehicleName(name).."</b> indisponivel.",8000)
				return
			end
			if vRP.tryFullPayment(user_id,vRP.vehiclePrice(name)*0.85) then
				vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
				vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })
				TriggerClientEvent("Notify",source,"sucesso","Você comprou um <b>"..vRP.vehicleName(name).."</b> por <b>$ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.85)).." dólares</b>.",10000)
				src.updateVehicles(name,vRP.vehicleType(name))
				if vRP.vehicleType(name) == "carros" then
					TriggerClientEvent('dealership:Update',source,'updateCarros')
				elseif vRP.vehicleType(name) == "motos" then
					TriggerClientEvent('dealership:Update',source,'updateMotos')
				elseif vRP.vehicleType(name) == "import" then
					TriggerClientEvent('dealership:Update',source,'updateImport')
				end
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function src.sellDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
		local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
		if vehicle[1] then
			vRP.execute("creative/rem_vehicle",{ user_id = parseInt(user_id), vehicle = name })
			vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) + 1 })
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado + parseInt(vRP.vehiclePrice(name)*0.85))))
			--vRP.giveMoney(user_id,parseInt(vRP.vehiclePrice(name)*0.85))
			TriggerClientEvent("Notify",source,"sucesso","Você vendeu um <b>"..vRP.vehicleName(name).."</b> por <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.85)).." dólares</b>.",10000)
			src.updateVehicles(name,vRP.vehicleType(name))
			TriggerClientEvent('dealership:Update',source,'updatePossuidos')
		end
	end
end

function src.permissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,"conce.permissao")
end