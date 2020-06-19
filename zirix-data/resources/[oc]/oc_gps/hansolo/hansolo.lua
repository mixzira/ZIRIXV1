----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
----------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÃO ]---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
oC = Tunnel.getInterface("oc_gps")
----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("oc_gps:coords")
AddEventHandler("oc_gps:coords", function(source)
	if oC.motoclub() then
		setBlip(609.82,-3085.98,6.07,643,39,"Fabrica de Armas")
		setBlip(1123.06,-1303.96,34.72,280,39,"Fornecedor")
		setBlip(991.78,-1551.18,30.76,280,39,"Fornecedor")
		setBlip(974.0,-117.91,74.35,661,39,"Base")
		setBlip(1224.34,-2911.45,5.93,586,39,"Contrabandista")

	elseif oC.medellin() then
		setBlip(1405.76,1119.02,114.84,40,5,"Fazenda")
		setBlip(1123.06,-1303.96,34.72,280,5,"Fornecedor")
		setBlip(991.78,-1551.18,30.76,280,5,"Fornecedor")
		setBlip(1224.34,-2911.45,5.93,586,5,"Contrabandista")

	elseif oC.grove() then
		setBlip(102.68,-1938.23,20.81,84,2,"Base")
		setBlip(1224.34,-2911.45,5.93,586,2,"Contrabandista")

	elseif oC.ballas() then
		setBlip(-177.09,-1593.37,34.56,84,27,"Base")
		setBlip(1224.34,-2911.45,5.93,586,27,"Contrabandista")

	elseif  oC.bratva() then
		setBlip(1224.34,-2911.45,5.93,586,49,"Contrabandista")

	elseif oC.odebrecht() then
		setBlip(1224.34,-2911.45,5.93,586,51,"Contrabandista")

    end
end)
----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
function setBlip(x,y,z,id,color,text)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,id)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,color)
	SetBlipScale(blip,0.5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end