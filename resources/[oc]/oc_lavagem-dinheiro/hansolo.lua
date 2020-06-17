local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
oC = Tunnel.getInterface("oc_lavagem-dinheiro")
-----------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local onmenu = false
local emprocesso = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local maquinas = {
	{ ['x'] = -60.32, ['y'] = -2517.85, ['z'] = 7.41 }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(maquinas) do
            local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
            local maquinas = maquinas[k]
            
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), maquinas.x, maquinas.y, maquinas.z, true) <= 2 then
                DrawText3D(maquinas.x, maquinas.y, maquinas.z, "[~r~E~w~] Para acessar o ~r~SISTEMA~w~.")
            end

            if distance <= 15 then
				DrawMarker(23, maquinas.x, maquinas.y, maquinas.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
                        oC.lavagemDinheiro()
					end
				end
			end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ SEGUNDOS ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emprocesso then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					emprocesso = false
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lavagem-dinheiro:posicao")
AddEventHandler("lavagem-dinheiro:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 326.29)
	SetEntityCoords(ped, -60.32,-2517.85,7.41-1,false,false,false,false)
end)

RegisterNetEvent("lavagem-dinheiro:processo")
AddEventHandler("lavagem-dinheiro:processo", function()
	
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end