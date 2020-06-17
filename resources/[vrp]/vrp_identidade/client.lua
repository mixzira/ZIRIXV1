local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_identidade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local css = [[
	@import url('https://fonts.googleapis.com/css?family=Muli:300,400,700');

	.clear {
		clear: both;
	}

	#DocumentSection {
		background-color: rgba(15,15,15,0.8);
		width: 300px;
		min-height: 250px;
		border-radius: 5px;
		box-shadow: 0px 0px 3px rgba(0, 0, 0, 0.08);
		text-align: center;
		position: absolute;
		right: 0.5%;
		bottom: 15%;
		font-family: 'Muli';
		color: #999;
		padding-bottom: 15px;
		z-index: 1;
		overflow: hidden;
	}

	#DocumentSection:before,
	#DocumentSection:after {
		content: ' ';
		position: absolute;
		width: 200%;
		height: 200%;
	}

	#DocumentSection:before {
		background-color: #06632e;
		top: -193%;
		left: -100%;
		transform: rotate(-5deg);
		z-index: 1;
	}

	#DocumentSection:after {
		background-color: #2eb37b;
		top: -191%;
		left: -100%;
		transform: rotate(-6deg);
		z-index: 0;
	}

	#DocumentSection .avatar-img {
		width: 100px;
		height:100px;
		margin: 50px auto 0 auto;
		overflow:hidden;
		border-radius: 50px;
	}

	#DocumentSection .avatar-img img {
		width: 100%;
	}

	#DocumentSection .each-info {
		display: block;
		margin: 0;
		width: 70%;
		margin: 0 auto;
	}

	#DocumentSection .each-info.person-name {
		font-size: 20px;
	}

	#DocumentSection .each-info.person-age {
		font-size: 15px;
	}

	#DocumentSection .each-info.person-job {
		border-top: 1px solid rgba(0,128,0, 0.8);
		border-bottom: 1px solid rgba(0,128,0, 0.8);
		margin: 25px auto;
		padding: 10px 0;
		color: #0f9950;
		font-size: 18px;
	}

	#DocumentSection .secondary-info {
		margin-top: 15px;
	}

	#DocumentSection .secondary-info .clear {
		margin-bottom: 3px;
		display: block;
	}

	#DocumentSection .secondary-info .each-info strong {
		float: left;
		font-weight: 300;
	}

	#DocumentSection .secondary-info .each-info span {
		float: right;
		font-weight: bold;
		color: #0f9950;
	}
]]

--[[RegisterNetEvent("fell:animenter")
AddEventHandler("fell:animenter", function()
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local identitymodel = "p_ld_id_card_01"
	local anim1 = "amb@world_human_stand_mobile@female@text@enter"
	local anim2 = "amb@world_human_stand_mobile@female@text@base"
	RequestAnimDict(anim1)
	RequestAnimDict(anim2)
	RequestModel(GetHashKey(identitymodel))
	SetEntityAsMissionEntity(identitymodel, true, true)
	AttachEntityToEntity(CreateObject(GetHashKey(identitymodel), plyCoords.x, plyCoords.y, plyCoords.z, 0.2,-0.3,0.9),GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
	TaskPlayAnim(GetPlayerPed(-1), anim1, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
	Citizen.Wait(2000)
	TaskPlayAnim(GetPlayerPed(-1), anim2, "base", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
end)

RegisterNetEvent("fell:animexit")
AddEventHandler("fell:animexit", function()
	local identitymodel = "p_ld_id_card_01"
	local anim3 = "amb@world_human_stand_mobile@female@text@exit"
	RequestAnimDict(anim3)
	TaskPlayAnim(GetPlayerPed(-1), anim3, "exit", 8.0, 1.0, -1, 50, 0, 0, 0, 0)

	SetTimeout(2000,function()
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DeleteEntity(identitymodel)
		TaskClearLookAt(GetPlayerPed(-1))
		vRP._DeletarObjeto(identitymodel)
	end)
end)]]

local identity = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local tablet = "p_ld_id_card_01"
		if IsControlJustPressed(0,344) then
			
			if identity then
				vRP._removeDiv("rg")
				identity = false
				vRP._DeletarObjeto(tablet)
				TaskClearLookAt(GetPlayerPed(-1))
			else
				local anim1 = "amb@world_human_stand_mobile@female@text@enter"
				RequestAnimDict(anim1)
				TaskPlayAnim(GetPlayerPed(-1), anim1, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
				Citizen.Wait(2000)
				vRP._CarregarObjeto("amb@world_human_stand_mobile@female@text@base","base",tablet,49,28422)
				local foto, name, firstname,user_id,registration,age,phone, carteira, banco, multas,paypal,groupname = vRPNserver.Identidade()
				if foto == nil or foto == "" then
					foto  = "https://www.moxtra.com/service/themes/images/default/avatar-single-360.png"
				end
				local html = string.format("<div id='DocumentSection'><div class='avatar-img'><img src='%s'></div> <div class='infos'><div class='main-info'>"..
					"<h1 class='each-info person-name'>%s %s</h1>"..
					"<h2 class='each-info person-age'>%s anos</h2>"..
					"<h2 class='each-info person-job'>%s</h2>"..
					"</div>"..
					"<div class='secondary-info'>"..
					"<div class='each-info'><strong>Passaporte:</strong><span class='person-id'>%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Registro: </strong><span class='person-passport'>%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Telefone:</strong><span class='person-phone'>%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Carteira:</strong><span class='person-phone'>$%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Banco:</strong><span class='person-phone'>$%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Multas:</strong><span class='person-phone'>$%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Paypal:</strong><span class='person-phone'>$%s</span></div>"..
					"<div class='clear'></div>"..
					"</div>"..
					"</div>"..
					"</div>", foto, name, firstname, age, groupname, user_id, registration, phone, carteira, banco, multas, paypal)
				vRP._setDiv("rg", css, html)
				identity = true
			end
		end
	end
end)