local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_lixeiro-despejar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not processo then
			local ped = PlayerPedId()
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),-329.45,-1566.93,25.23)
			local vehicle = GetPlayersLastVehicle()

			if distancia <= 3 and GetEntityModel(vehicle) == -1255698084 then
				DrawMarker(21,-329.45,-1566.93,25.23-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,247,217,99,100,0,0,0,1)
				idle = 5
				if distancia <= 1.5 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA DESPEJAR O LIXO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPayment() then
							TriggerEvent('cancelando',true)
							vRP._CarregarObjeto("anim@heists@narcotics@trash","throw_ranged_a","prop_cs_rub_binbag_01",50,28422)
							processo = true
							segundos = 3
							SetTimeout(2000,function()
								vRP._DeletarObjeto()
								vRP._stopAnim(false)
								TriggerServerEvent("trydeleteobj",ObjToNet("prop_cs_rub_binbag_01"))
							end)
						end
					end
				end
			end
		end
		if processo then
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR O DESPEJO DO LIXO",4,0.5,0.93,0.50,255,255,255,180)
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if processo then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					processo = false
					TriggerEvent('cancelando',false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end