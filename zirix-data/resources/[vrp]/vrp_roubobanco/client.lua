local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPrb = {}
Tunnel.bindInterface("vrp_roubobanco",vRPrb)
Proxy.addInterface("vrp_roubobanco",vRPrb)
RBserver = Tunnel.getInterface("vrp_roubobanco")

local PalavrasSenha = {
    "PASSWORD",
    "PROTECAO",
    "TRANCADO",
    "DINAMITE"
}

local blockKeys = false
local scaleform = nil
local chanceshack = 5
local ClickReturn
local SorF = false
local Hacking = false
local UsandoComputador = false
local hackingBank = nil
local contador = 7200
local RouboIniciado = false

function ScaleformLabel(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

Citizen.CreateThread(function()
	while true do
		for k, v in ipairs(Config.BankRobbery) do
			local x,y,z = table.unpack(v.Coods)
			local Coordenadas = GetEntityCoords(PlayerPedId())
			local Distancia = GetDistanceBetweenCoords(Coordenadas.x, Coordenadas.y, Coordenadas.z, x,y,z, true)
			if Distancia < 6.0 then
				Opacidade = math.floor(255 - (Distancia * 40))
				TextoMarker(x,y,z+1.0, "APERTE ~r~[ F ]~w~ PARA INICIAR O ROUBO", Opacidade, 0.54, 0.54)
					DrawMarker(Config.marker.idmarker, x,y,z, 0, 0, 0, 0, 0, 0, Config.marker.x1,Config.marker.y1,Config.marker.z1,Config.marker.r,Config.marker.g,Config.marker.b,Config.marker.a, Config.marker.pula, 0, 0, Config.marker.gira)
				--if contador == 0 then
					TextoMarker(x,y,z+0.7, '~r~UNIDADE: '..v.BankName..'!', Opacidade, 0.54, 0.54)
					if (IsControlJustPressed(1,49)) then
                        --if RBserver.copsonline() >= v.Cops then
                            --local message = 'Assalto ao '..v.BankName..'! Todas as unidades dirijam-se para o local indicado.'
                            --TriggerServerEvent('vrp_roubobanco:ChamadoPolicial', message, {x, y, z})
                            RBserver.chamarPoliciais()
                            SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                            PlaySoundFromCoord(-1, "scanner_alarm_os", x,y,z, "dlc_xm_iaa_player_facility_sounds", 1, 100, 0)
                            RouboIniciado = true
							contador = 7200
						--else
                            --TriggerEvent('vrp_roubobanco:helpTimed', 'Não há policiais suficientes em serviço.', 50)
                            --RouboIniciado = false
						--end
					end
				--else
					--TextoMarker(x,y,z+0.8, "AGUARDE ~r~".. contador .. " ~w~SEGUNDOS PARA ROUBAR NOVAMENTE", Opacidade, 0.54, 0.54)
				--end
			end
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if contador > 0 then
			contador = contador - 1
        end
	end
end)

Citizen.CreateThread(function()
    function Initialize(scaleform)
        local scaleform = RequestScaleformMovieInteractive(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        
        local CAT = 'hack'
        local CurrentSlot = 0
        while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
            Citizen.Wait(0)
            CurrentSlot = CurrentSlot + 1
        end
        
        if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
            ClearAdditionalText(CurrentSlot, true)
            RequestAdditionalText(CAT, CurrentSlot)
            while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                Citizen.Wait(0)
            end
        end

        PushScaleformMovieFunction(scaleform, "SET_LABELS")
        ScaleformLabel("H_ICON_1")
        ScaleformLabel("H_ICON_2")
        ScaleformLabel("H_ICON_3")
        ScaleformLabel("H_ICON_4")
        ScaleformLabel("H_ICON_5")
        ScaleformLabel("H_ICON_6")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
        PushScaleformMovieFunctionParameterInt(1) -- 5-Merryweather | 4-PC | 3-City os LS | 2-Humane Labdavizin | 1-Pacific Standart
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("Meu Computador")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("Meu Computador")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterString("Deconectar")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(chanceshack)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(chanceshack)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(1)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(4)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(5)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(6)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(7)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()
        

        return scaleform
    end
    scaleform = Initialize("HACKING_PC")
    while true do
        Citizen.Wait(0)
        if UsandoComputador then
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, "SET_CURSOR")
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()
            if IsDisabledControlJustPressed(0,24) and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_BACK")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if HasScaleformMovieLoaded(scaleform) and UsandoComputador then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)
                --print("ProgramID: "..ProgramID)
                if ProgramID == 83 and not Hacking then
                    chanceshack = 5
                    
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(chanceshack)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()

                    PushScaleformMovieFunction(scaleform, "OPEN_APP")
                    PushScaleformMovieFunctionParameterFloat(1.0)
                    PopScaleformMovieFunctionVoid()
                    
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                    PushScaleformMovieFunctionParameterString(PalavrasSenha[math.random(#PalavrasSenha)])
                    PopScaleformMovieFunctionVoid()

                    Hacking = true
                elseif ProgramID == 82 and not Hacking then
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 87 then
                    chanceshack = chanceshack - 1
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(chanceshack)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 92 then
                    PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                elseif Hacking and ProgramID == 86 then
                    SorF = true
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                    PushScaleformMovieFunctionParameterBool(true)
                    ScaleformLabel("WINBRUTE")
                    PopScaleformMovieFunctionVoid()
                    Wait(0)
                    PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    Hacking = false
                    SorF = false    
                    local v = Config.BankRobbery[hackingBank]
                    TriggerServerEvent('vrp_roubobanco:setDoorFreezeStatus', hackingBank, #v.Doors, false)
                    PlaySoundFromCoord(-1, "scanner_alarm_os", v.Doors[#v.Doors].Coords.x, v.Doors[#v.Doors].Coords.y, v.Doors[#v.Doors].Coords.z, "dlc_xm_iaa_player_facility_sounds", 1, 100, 0)
                    mHacking = false
					local message = 'Uma violação de dados ocorreu em '.. v.BankName ..' e o cofre do banco foi aberto!'
					--TriggerServerEvent('vrp_roubobanco:ChamadoPolicial', message, {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})
                    RBserver.updateCops(message)
                    DeleteEntity(cardentity)
                    DeleteEntity(lapentity)
                    DeleteEntity(bagProp1)
                    ClearPedTasks(PlayerPedId())
                    SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                elseif ProgramID == 6 then
                    UsandoComputador = false
                    SetScaleformMovieAsNoLongerNeeded(scaleform)
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                end
                
                if Hacking then
                    PushScaleformMovieFunction(scaleform, "SHOW_LIVES")
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunctionVoid()
                    if chanceshack <= 0 then
                        SorF = true
                        PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(false)
                        ScaleformLabel("LOSEBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(5000)
                        ClearPedTasks(PlayerPedId())
                        local v = Config.BankRobbery[hackingBank]
                        local message = 'Uma pessoa anônima tentou infringir o sistema do '..v.BankName ..''
						--TriggerServerEvent('vrp_roubobanco:ChamadoPolicial', message, {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})
                        RBserver.updateCops(message)
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        Hacking = false
                        SorF = false
                        mHacking = false
                        DeleteEntity(cardentity)
                        DeleteEntity(lapentity)
                        DeleteEntity(bagProp1)
                        SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                    end
                end
            end
        else
            Wait(250)
        end
    end
end)

local mHacking = false

function USBSuccess(success, timeremaining)
    if success then
        blockKeys = false
        TriggerEvent('mhacking:hide')
        scaleform = Initialize("HACKING_PC")
        UsandoComputador = true
    else
        TriggerEvent('mhacking:hide')
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
        local v = Config.BankRobbery[hackingBank]
		local message = 'Uma pessoa tentou infringir o sistema do '..v.BankName ..''
		--TriggerServerEvent('vrp_roubobanco:ChamadoPolicial', message, {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})
        RBserver.updateCops(message)
        blockKeys = false
        mHacking = false
        DeleteEntity(cardentity)
        DeleteEntity(lapentity)
        DeleteEntity(bagProp1)
        SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
    end
end

local bagIndex = GetPedBoneIndex(PlayerPedId(), 57005)

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Hacking.Coords, true) <= 2.0 and v.Doors[#v.Doors].Frozen and not mHacking then
                local allowed = false
                if #v.Doors > 1 then
                    if not v.Doors[#v.Doors - 3].Frozen then
                        allowed = true
                    end
                else
                    allowed = true
                end
                if allowed then
                    TriggerEvent('vrp_roubobanco:helpTimed', 'Pressione ~INPUT_CONTEXT~ para Hackear', 25)
                    if IsControlPressed(0, 38) then
					local police = RBserver.copsonline()
                        while police == nil do
                            Wait(5)
                        end
                        if police >= v.Cops then
                            mHacking = true
                            blockKeys = true
                            TriggerEvent('mhacking:hide')
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(player)
                            SetEntityCoords(player, v.Hacking.Coords)
                            SetEntityHeading(player, v.Hacking.Heading)
                            local card_hash = GetHashKey("prop_cs_credit_card")
                            local lap_hash = GetHashKey("prop_laptop_lester")
                            local bagHash1 = GetHashKey('p_ld_heist_bag_s_pro_o')
                            loadModel(card_hash)
                            --loadModel(bagHash1)
                            --loadModel(lap_hash)
                            cardentity = CreateObject(card_hash, coords+20, false, false)
                            lapentity = CreateObject(lap_hash, coords+20, false, false)
                            bagProp1 = CreateObject(bagHash1, coords+20, true, false)
                            SetEntityAsMissionEntity(card, true, true)
                            SetEntityAsMissionEntity(bagProp1, true, true)
                            local boneIndexf3 = GetPedBoneIndex(PlayerPedId(), 0x49D9)
                            local bagIndex3 = GetPedBoneIndex(PlayerPedId(), 57005)
                            Wait(500)
                            SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
                            AttachEntityToEntity(bagProp1, PlayerPedId(), bagIndex3, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
                            AttachEntityToEntity(cardentity, PlayerPedId(), boneIndexf3, 0.20, 0.02, 0.0, 0, 180.0, 10, 1, 1, 1, 1, 1, 1)
                            RequestAnimDict('anim@heists@ornate_bank@hack')
                            while not HasAnimDictLoaded('anim@heists@ornate_bank@hack') do
                                Wait(10)
                            end
                            --TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                            vRP._playAnim(false,{{'anim@heists@ornate_bank@hack','hack_enter'}},false)
                            Wait(3000)
                            DetachEntity(cardentity,1,1)
                            FreezeEntityPosition(cardentity,1)
                            Wait(4500)
                            DetachEntity(bagProp1,1,1)
                            PlaceObjectOnGroundProperly(bagProp1)
                            SetEntityRotation(bagProp1, 0, 0, 230, 1)
                            FreezeEntityPosition(bagProp1, true)
                            SetEntityAsMissionEntity(bagProp1, true, true)
                            --TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 8.0, 8.0, -1, 1, 0, 0, 0, 0)
                            vRP._playAnim(false,{{'anim@heists@ornate_bank@hack','hack_loop'}},true)
                            Wait(700)
                            AttachEntityToEntity(lapentity, PlayerPedId(), boneIndexf3, 0.20, 0.00, 0.05, 0.0, 180.0, 120.0, 1, 1, 1, 1, 1, 1)
                            Wait(500)
                            DetachEntity(lapentity,1,1)
                            FreezeEntityPosition(lapentity,1)
                            hackingBank = k
                            TriggerEvent("mhacking:show")
                            TriggerEvent("mhacking:start", 3, 60, USBSuccess)
                        else
							vRP.notify("Não há policiais suficientes online!")
                        end
                    end
                end
                Wait(10)
            end
        end
        Wait(100)
    end
end)

local soundid = nil

RegisterNetEvent('vrp_roubobanco:updateMoney')
AddEventHandler('vrp_roubobanco:updateMoney', function(bank, money)
    Config.BankRobbery[bank].Money.Amount = money
end)

local moneyPile = {}
local Carrinholocal = {}

local TimeCarrinho = true
local cashPile2 = nil
local CarrinhoMoney = nil
local acabouspawn = true

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    while acabouspawn do
        rememberMoneyTable = moneyPile
        moneyPile = {}
        Carrinholocal = {}
        for k, v in pairs(Config.BankRobbery) do
        for j = 1, #Config.BankRobbery[k].Carrinhos do
            local s = Config.BankRobbery[k].Carrinhos[j]
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            local Moneycaixa = nil 
			local Moneycaixa = RBserver.getBox(k)
            while Moneycaixa == nil do 
                Wait(0)
            end
            v.Money.Box = Moneycaixa
            local model = GetHashKey(v.Money.Box)
            loadModel(model)
            local object = CreateObject(model, v.Money.BoxPosition, false, false)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            table.insert(moneyPile, {Object = object})
            for i = 1, #rememberMoneyTable do
                DeleteEntity(rememberMoneyTable[i].Object)
            end
            local Carrinhohash = GetHashKey('hei_prop_hei_cash_trolly_01')
            loadModel(Carrinhohash)
            CarrinhoMoney = CreateObject(Carrinhohash, s.Coords, true, true, true)
            table.insert(Carrinholocal, CarrinhoMoney)
            PlaceObjectOnGroundProperly(CarrinhoMoney)
            SetEntityRotation(CarrinhoMoney, 0, 0, s.Heading, 2)
            FreezeEntityPosition(CarrinhoMoney, true)
            SetEntityAsMissionEntity(CarrinhoMoney, true, true)
            acabouspawn = false
        end
        end
        Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    local fakeTimer = 500
    local bag = false
    while true do
        fakeTimer = fakeTimer + 1
        if fakeTimer >= 500 then
            bag = true
            fakeTimer = 0
        end
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            for j = 1, #Config.BankRobbery[k].Carrinhos do
            for b, u in pairs(Carrinholocal) do 
            local s = Config.BankRobbery[k].Carrinhos[j]
            if not s.Looted then
            if GetDistanceBetweenCoords(coords, s.Coords, true) <= 1.5 and not v.Doors[#v.Doors].Frozen then
                if v.Money.Amount > 0 then
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName('Pressione ~INPUT_CONTEXT~ para pegar o Dinheiro')
                    EndTextCommandDisplayHelp(0, false, true, -1)
                    if IsControlPressed(0, 38) then
                        b = j
						local police = RBserver.copsonline()
                        while police == nil do
                            Wait(5)
                        end
                        if police >= v.Cops then
                            SetEntityCoords(player, s.Coodsp) 
                            SetEntityHeading(player, s.Heading)

                            local cash_hash = GetHashKey("hei_prop_heist_cash_pile")
                            loadModel(cash_hash)

                            RequestAnimDict('anim@heists@ornate_bank@grab_cash')
                            while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash') do
                                Wait(10)
                            end
                            vRP._playAnim(false,{{'anim@heists@ornate_bank@grab_cash','intro'}},true)
                            --TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash", "intro", 8.0, -8.0, -1, 1, 0, false, false, false)

                            Wait(1000)

                            local bagHash2 = GetHashKey('p_ld_heist_bag_s_pro_o')
                            loadModel(bagHash2)
                            local bagProp2 = CreateObject(bagHash2, coords, true, false)
                            local bagIndex2 = GetPedBoneIndex(PlayerPedId(), 57005)
                            SetEntityAsMissionEntity(bagProp2, true, true)
                            SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
                            AttachEntityToEntity(bagProp2, PlayerPedId(), bagIndex2, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)

                            PlayEntityAnim(Carrinholocal[b], "cart_cash_dissapear", "anim@heists@ornate_bank@grab_cash", 1.0, false, false, false, 0, 0)
                            --vRP.CarregarObjeto('cart_cash_dissapear','anim@heists@ornate_bank@grab_cash',Carrinholocal[b],false,false)

                            TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
                            cashPile2 = CreateObject(cash_hash, 0, 0, 0, true, false)
                            SetEntityAsMissionEntity(cashPile2, true, true)
                            TimeCarrinho = true
                            Wait(48800)
                            TimeCarrinho = false
                            DeleteEntity(cashPile2)
                            DeleteEntity(bagProp2)
                            DeleteEntity(Carrinholocal[b])
                            local Carrinhohash2 = GetHashKey('hei_prop_hei_cash_trolly_03')
                            loadModel(Carrinhohash2)
                            CarrinhoMoney2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_03"), s.Coords, true, true, true)
                            PlaceObjectOnGroundProperly(CarrinhoMoney2)
                            SetEntityRotation(CarrinhoMoney2, 0, 0, s.Heading, 2)
                            FreezeEntityPosition(CarrinhoMoney2, true)
                            SetEntityAsMissionEntity(CarrinhoMoney2, true, true)
                            SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                            ClearPedTasks(player)
                            TriggerServerEvent('vrp_roubobanco:lootCarrinhos', k, j)
                        else
							vRP.notify("Não há policiais suficientes em serviço.")
                        end
                    end
                end
            end
          end
          end
          end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while TimeCarrinho do
        Wait(500)
        local boneIndex = GetPedBoneIndex(PlayerPedId(), 18905)
        AttachEntityToEntity(cashPile2, PlayerPedId(), boneIndex, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
        Wait(500)
        DetachEntity(cashPile2, false, false)
        SetEntityCoords(cashPile2, 0, 0, 0)
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    local fakeTimer = 500
    local bag = false
    while true do
        fakeTimer = fakeTimer + 1
        if fakeTimer >= 500 then
            bag = true
            fakeTimer = 0
        end
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Money.BoxPosition, true) <= 1.5 and not v.Doors[#v.Doors].Frozen then
                if v.Money.Amount > 0 then
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName('Pressione ~INPUT_CONTEXT~ para pegar o Dinheiro')
                    EndTextCommandDisplayHelp(0, false, true, -1)
                    if IsControlPressed(0, 38) then
						local police = RBserver.copsonline()
                        while police == nil do
                            Wait(5)
                        end
                        if police >= v.Cops then
                            TaskClearLookAt(player)
                            TaskLookAtCoord(player, v.Money.BoxPosition, 1000, 0, 2)
                            Wait(500)
                            local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                            SetCamCoord(cam, v.Money.Cam.Coords.x, v.Money.Cam.Coords.y, v.Money.Cam.Coords.z)
                            SetCamRot(cam, v.Money.Cam.Rotation.rx, v.Money.Cam.Rotation.ry, v.Money.Cam.Rotation.rz, v.Money.Cam.Rotation.r)
                            RenderScriptCams(1, 0, 0, 1, 1)
                            SetCamActive(cam, true)

                            SetEntityCoords(player, v.Money.Coords)
                            SetEntityHeading(player, v.Money.Heading)

                            blockKeys = true
                            local cash_hash2 = GetHashKey("hei_prop_heist_cash_pile")
                            loadModel(cash_hash2)

                            RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
                            while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
                                Wait(10)
                            end

                            TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "intro", 8.0, -8.0, -1, 1, 0, false, false, false)

                            Wait(1000)

                            local bagHash3 = GetHashKey('p_ld_heist_bag_s_pro_o')
                            loadModel(bagHash3)

                            local bagProp3 = CreateObject(bagHash3, coords, true, false)
                            local bagIndex3 = GetPedBoneIndex(PlayerPedId(), 57005)
                            SetEntityAsMissionEntity(bagProp3, true, true)
                            SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
                            AttachEntityToEntity(bagProp3, PlayerPedId(), bagIndex3, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
                            local cashPile = CreateObject(cash_hash2, 0, 0, 0, true, false)
                            SetEntityAsMissionEntity(cashPile, true, true)
                            local boneIndex = GetPedBoneIndex(PlayerPedId(), 18905)
                            while v.Money.Amount > 0 do
                                Wait(150)
                                TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
                                TriggerEvent('vrp_roubobanco:helpTimed', 'Segure ~INPUT_JUMP~ para parar de roubar o Dinheiro', 100)
                                Wait(350)
                                TriggerServerEvent('vrp_roubobanco:takeMoney', k)
                                AttachEntityToEntity(cashPile, PlayerPedId(), boneIndex, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
                                Wait(500)
                                DetachEntity(cashPile, false, false)
                                SetEntityCoords(cashPile, 0, 0, 0)
                                if IsDisabledControlPressed(0, 22) then
                                    break
                                end
                            end
                            RenderScriptCams(false, false, 0, true, false)
                            DestroyCam(cam, false)
                            TaskClearLookAt(player)
                            DeleteEntity(cashPile)
                            DeleteEntity(bagProp3)
                            SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                            ClearPedTasks(player)
                            blockKeys = false
                            for i = 1, #rememberMoneyTable do
                                DeleteEntity(rememberMoneyTable[i].Object)
                            end
                        else
							vRP.notify("Não há policiais suficientes online!")
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Money.BoxPosition, true) <= 2.0 then
                local position = v.Money.BoxPosition
                TextoMarker(position.x, position.y, position.z + 0.5 , '~g~R$'.. v.Money.Amount .. '', 200, 0.8, 0.8)
            else
                Wait(250)
            end
        end
        Wait(0)
    end
end)

local state = 0
local inMission = false
local ped = {}
local currentDrillAnim = 'drill_straight_idle'

RegisterNetEvent('vrp_roubobanco:getTimeCl')
AddEventHandler('vrp_roubobanco:getTimeCl', function(x)
    if x then
        state = 1
    else
        state = 0
    end
end)

local weldedDoors = {}

RegisterNetEvent('vrp_roubobanco:setDoorFreezeStatusCl')
AddEventHandler('vrp_roubobanco:setDoorFreezeStatusCl', function(bank, door, status)
    Config.BankRobbery[bank].Doors[door].Frozen = status
end)

RegisterNetEvent('vrp_roubobanco:safeLooted')
AddEventHandler('vrp_roubobanco:safeLooted', function(bank, safe, toggle)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
end)

RegisterNetEvent('vrp_roubobanco:carrinhoLooted')
AddEventHandler('vrp_roubobanco:carrinhoLooted', function(bank, safe, toggle)
    Config.BankRobbery[bank].Carrinhos[safe].Looted = toggle
end)

RegisterNetEvent('vrp_roubobanco:helpTimed')
AddEventHandler('vrp_roubobanco:helpTimed', function(text, time)
    local faketimer = time
    while faketimer >= 0 do
        faketimer = faketimer - 1
        Wait(0)
        BeginTextCommandDisplayHelp('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end)

local quebrandotudo = false
local termitacolocando = false
local furadeiraentity = nil
local thermalentity = nil
local cardentity = nil
local lapentity = nil
local bagProp1 = nil

Citizen.CreateThread(function()
    while true do
        Wait(250)
        for i = 1, #Config.BankRobbery do
            local v = Config.BankRobbery[i]
            for j = 1, #v.Doors do
                local d = v.Doors[j]
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                if GetDistanceBetweenCoords(coords, d.Coords, true) <= 2.5 and d.Frozen and RouboIniciado then
                    if true then
                        while GetDistanceBetweenCoords(GetEntityCoords(player), d.Coords, true) <= 2.5 and d.Frozen and not d.Hacking do
                            local allowed = false
                            if j == 1 then
                                allowed = true
                            else
                                if j ~= #v.Doors then
                                    if not v.Doors[j-1].Frozen then
                                        allowed = true
                                    else
                                        allowed = false
                                    end
                                else
                                    allowed = true
                                end
                            end
                            Wait(50)
                            if allowed then
                                TriggerEvent('vrp_roubobanco:helpTimed', 'Aperte ~INPUT_CONTEXT~ para Destruir a Grade', 50)
                                if IsControlPressed(0, 38) then
									local police = RBserver.copsonline()
                                    while police == nil do
                                        Wait(5)
                                    end
                                    if police >= v.Cops then
                                    if j == 1 or j == 2 then
                                        if RBserver.getitem("c4") then
                                        ClearPedTasks(player)
                                        SetEntityCoords(player, d.WeldPosition.C)
                                        SetEntityHeading(player, d.WeldPosition.H)
                                        local thermal_hash = GetHashKey("hei_prop_heist_thermite_flash")
                                        local bagHash4 = GetHashKey('p_ld_heist_bag_s_pro_o')
                                        
                                        loadModel(thermal_hash)
                                        Wait(10)
                                        --loadModel(bagHash4)
                                        --Wait(10)
                                        thermalentity = CreateObject(thermal_hash, d.WeldPosition.C-20, false, true)
                                        local bagProp4 = CreateObject(bagHash4, coords-20, true, false)
                                        SetEntityAsMissionEntity(thermal, true, true)
                                        SetEntityAsMissionEntity(bagProp4, true, true)
                                        local boneIndexf1 = GetPedBoneIndex(PlayerPedId(), 28422)
                                        local bagIndex1 = GetPedBoneIndex(PlayerPedId(), 57005)
                                        termitacolocando = true
                                        Wait(500)
                                        SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
                                        AttachEntityToEntity(thermalentity, PlayerPedId(), boneIndexf1, 0.0, 0.0, 0.0, 180.0, 180.0, 0, 1, 1, 0, 1, 1, 1)
                                        AttachEntityToEntity(bagProp4, PlayerPedId(), bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
                                        RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
                                        while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') do
                                            Wait(10)
                                        end

                                        vRP._playAnim(false,{{'anim@heists@ornate_bank@thermal_charge','thermal_charge'}},false)
                                        --TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 8.0, 8.0, -1, 1, 0, false, false, false)
                                        Wait(2500)
                                        DetachEntity(bagProp4, 1, 1)
                                        FreezeEntityPosition(bagProp4, true)
                                        Wait(2500)
                                        FreezeEntityPosition(bagProp4, false)
                                        --vRP.CarregarObjeto("","",emote.prop,emote.flag,emote.hand,emote.pos1,emote.pos2,emote.pos3,emote.pos4,emote.pos5,emote.pos6)

                                        AttachEntityToEntity(bagProp4, PlayerPedId(), bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
                                        Wait(1000)
                                        DeleteEntity(bagProp4)
                                        SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                                        Wait(1000)
                                        DeleteEntity(thermalentity)
                                        blockKeys = true
                                        local explodicao = true
                                        ClearPedTasks(player) 
                                        blockKeys = false
                                        if explodicao then
                                            Wait(4000)
                                            TriggerServerEvent('vrp_roubobanco:setDoorFreezeStatus', i, j, false)
                                        end
                                        thermalentity = nil
                                        termitacolocando = false
                                        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 0.5)
                                        Wait(50)
                                    else
                                        vRP.notify("Você não possui uma C4!")  
                                    end
                                    else
                                    if RBserver.getitem("serra") then
                                        ClearPedTasks(player)
                                        SetEntityCoords(player, d.WeldPosition.C)
                                        SetEntityHeading(player, d.WeldPosition.H)
                                        local furadeira_hash = GetHashKey("prop_tool_consaw")
                                        loadModel(furadeira_hash)
                                        
                                        furadeiraentity = CreateObject(furadeira_hash, d.WeldPosition.C+30, true, false)
                                        SetEntityAsMissionEntity(furadeira, true, true)
                                        local boneIndexf4 = GetPedBoneIndex(PlayerPedId(), 28422)
                                        Wait(500)
                                        AttachEntityToEntity(furadeiraentity, PlayerPedId(), boneIndexf4, 0.095, 0.0, 0.0, 270.0, 170.0, 0.0, 1, 1, 0, 1, 0, 1)
                                        quebrandotudo = true
                                        blockKeys = true
                                        local welded = true
                                        for i = 1, 700 do --LOOP
                                            local xp,yp,zp = table.unpack(d.Coords)
                                            Textinho3D(xp,yp,zp,'Dano ~r~' .. string.format("%0.1f", i/7) .. '% \n\n~w~[~b~ESPAÇO~w~] ~r~Parar de Serrar', d.Time)
                                            if IsDisabledControlPressed(0, 22) then
                                                ClearPedTasks(player)
                                                blockKeys = false
                                                welded = false
                                                quebrandotudo = false
                                                DeleteEntity(furadeiraentity)
                                                furadeiraentity = nil
                                                break
                                            end
                                        end
                                        ClearPedTasks(player)
                                        blockKeys = false
                                        if welded then
                                            TriggerServerEvent('vrp_roubobanco:setDoorFreezeStatus', i, j, false)
                                        end
                                        DeleteEntity(furadeiraentity)
                                        furadeiraentity = nil
                                        quebrandotudo = false
                                        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 0.5)
                                        Wait(50)
                                    else
                                        vRP.notify("Você não possui uma serra!")
                                    end
                                    end
                                    else
										vRP.notify("Não há policiais suficientes online!")
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(0)
    end
    Wait(250)
    for i = 1, #Config.BankRobbery do
        for j = 1, #Config.BankRobbery[i].Doors do
            TriggerServerEvent('vrp_roubobanco:getDoorFreezeStatus', i, j)
        end
    end
    while true do
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        for i = 1, #Config.BankRobbery do
            Wait(0)
            local v = Config.BankRobbery[i]
            for j = 1, #v.Doors do
                Wait(0)
                local d = v.Doors[j]
                local door = GetClosestObjectOfType(d.Coords, 2.0, GetHashKey(d.Object), false, 0, 0)
                if door ~= nil then
                    if not d.Frozen then
                        if d.OpenHeading ~= nil then
                            SetEntityHeading(door, d.OpenHeading)
                        end
                    end
                    FreezeEntityPosition(door, d.Frozen)
                    if d.Frozen then
                        SetEntityHeading(door, d.Heading)
                    end
                end
            end
        end
        Wait(250)
    end
end)

local drilling = false
local finishedDrilling = false
local speed = 0.0
local temperature = 0.0
local depth = 0.1
local position = 0.0
local drillEntity = {}
local playSound = true

RegisterNetEvent('vrp_roubobanco:deleteDrillCl')
AddEventHandler('vrp_roubobanco:deleteDrillCl', function(coords)
    local jackham = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_tool_jackham"), false, false, false)
    SetEntityAsMissionEntity(jackham, true, true)
    DeleteEntity(jackham)
end)

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Safes do
                Wait(0)
                local s = Config.BankRobbery[i].Safes[j]
                if not s.Looted then
                        if GetDistanceBetweenCoords(coords, s.Coords, true) <= 1.0 and not Config.BankRobbery[i].Doors[#Config.BankRobbery[i].Doors].Frozen then
                            TriggerEvent('vrp_roubobanco:helpTimed', 'Pressione ~INPUT_CONTEXT~ para Perfurar o Cofre', 5)
                            if IsControlPressed(0, 38) then
								local police = RBserver.copsonline()
                                while police == nil do
                                    Wait(5)
                                end
                                if police >= Config.BankRobbery[i].Cops then
                                if RBserver.getitem("furadeira") then
                                    TriggerServerEvent('vrp_roubobanco:toggleSafe', i, j, true)
                                    FreezeEntityPosition(player, true)
                                    SetPedCurrentWeaponVisible(player, false, true, 0, 0)
                                    SetEntityCoords(player, s.Coords)
                                    SetEntityHeading(player, s.Heading)
                                    drilling = true
                                    speed = 0.0
                                    temperature = 0.0
                                    depth = 0.1
                                    position = 0.0

                                    local drill_hash = GetHashKey("hei_prop_heist_drill")
                                    loadModel(drill_hash)
                                   
                                    drillEntity = CreateObject(drill_hash, Config.DrillSpawns[#Config.DrillSpawns] +20, true, false)
                                    SetEntityAsMissionEntity(drill, true, true)
                                    local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                                    Wait(500)
                                    AttachEntityToEntity(drillEntity, PlayerPedId(), boneIndex, 0.125, 0.0, -0.05, 100.0, 300.0, 135.0, true, true, false, true, 1, true)

                                    if soundid ~= nil then
                                        StopSound(soundid)
                                        ReleaseSoundId(soundid)
                                    end
                                                
                                    soundid = GetSoundId()
                                    LoadStream("HEIST_FLEECA_DRILL", "DRILL")
                                    RequestScriptAudioBank("HEIST_FLEECA_DRILL_2", 1)
                                    PlaySoundFromEntity(soundid, "Drill", drillEntity, "DLC_HEIST_FLEECA_SOUNDSET", 0, 0)

                                    local ped_hash = -39239064
                                    loadModel(ped_hash)
                                  
                                    local soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.8, 0.0, true, false)
                                    FreezeEntityPosition(soundPed, true)
                                    SetEntityVisible(soundPed, false)
                                    TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)  
                                    SetEntityInvincible(soundPed, true)
                                    SetEntityAsMissionEntity(soundPed, true, true)
                                    SetPedHearingRange(soundPed, 0.0)
                                    SetPedSeeingRange(soundPed, 0.0)
                                    SetPedAlertness(soundPed, 0.0)
                                    SetPedFleeAttributes(soundPed, 0, 0)
                                    SetBlockingOfNonTemporaryEvents(soundPed, true)
                                    SetPedCombatAttributes(soundPed, 46, true)
                                    SetPedFleeAttributes(soundPed, 0, 0)
                                    blockKeys = true
                                    local camFrom = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                                    local camFromInfo = s.Cam.From
                                    local camToInfo = s.Cam.To
                                    SetCamCoord(camFrom, camFromInfo.x, camFromInfo.y, camFromInfo.z)
                                    SetCamRot(camFrom, camFromInfo.rx, camFromInfo.ry, camFromInfo.rz, camFromInfo.r)
                                    RenderScriptCams(1, 0, 0, 1, 1)
                                    local camTo = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                                    SetCamCoord(camTo, camToInfo.x, camToInfo.y, camToInfo.z)
                                    SetCamRot(camTo, camToInfo.rx, camToInfo.ry, camToInfo.rz, camToInfo.r)
                                    RenderScriptCams(1, 0, 0, 1, 1)
                                    local firstcam = 'camTo'
                                    local active = SetCamActive(camFrom, true) 

                                    while drilling do
                                        Wait(100)
                                        if not playSound or speed <= 0.1 then
                                            DeleteEntity(soundPed)
                                            TriggerServerEvent('vrp_roubobanco:deleteDrill', coords)
                                        else
                                            if not DoesEntityExist(soundPed) then
                                                loadModel(ped_hash)
                                                
                                                soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.5, 0.0, true, false)
                                                FreezeEntityPosition(soundPed, true)
                                                SetEntityVisible(soundPed, false)
                                                TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)  
                                                SetEntityInvincible(soundPed, true)
                                                SetEntityAsMissionEntity(soundPed, true, true)
                                                SetPedHearingRange(soundPed, 0.0)
                                                SetPedSeeingRange(soundPed, 0.0)
                                                SetPedAlertness(soundPed, 0.0)
                                                SetPedFleeAttributes(soundPed, 0, 0)
                                                SetBlockingOfNonTemporaryEvents(soundPed, true)
                                                SetPedCombatAttributes(soundPed, 46, true)
                                                SetPedFleeAttributes(soundPed, 0, 0)

                                            end
                                        end
                                        if IsDisabledControlPressed(0, 22) then
                                            drilling = false
                                            Wait(250)
                                            ClearPedTasks(player)
                                            break
                                        end
                                    end
                                    if finishedDrilling then
                                        TriggerServerEvent('vrp_roubobanco:lootSafe', i, j)
                                    else
                                        TriggerServerEvent('vrp_roubobanco:toggleSafe', i, j, false)
                                    end
                                    blockKeys = false
                                    ClearPedTasks(player)
                                    RenderScriptCams(false, false, 0, true, false)
                                    DestroyCam(active, false)

                                    Wait(100)

                                    drilling = false
                                    finishedDrilling = false
                                    speed = 0.0
                                    temperature = 0.0
                                    depth = 0.1
                                    position = 0.0

                                    Wait(100)

                                    DeleteEntity(drillEntity)
                                    FreezeEntityPosition(player, false)

                                    Wait(100)

                                    DeleteEntity(soundPed)
                                    local jackham = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_tool_jackham"), false, false, false)
                                    SetEntityAsMissionEntity(jackham, true, true)
                                    DeleteEntity(jackham)
                                    drillEntity = {}
                                else
                                    vRP.notify("Você não possui uma furadeira!")
                                end    
                                else
									vRP.notify("Não há policiais suficientes online!")
                                end
                            end
                        end
                end
            end
        end
        Wait(0)
    end
end)

local scaleform = {}

function drillScaleform()
    scaleform = RequestScaleformMovie("DRILLING")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end

Citizen.CreateThread(function()
    while true do
        while drilling do
            local text = '~INPUT_CELLPHONE_UP~ Perfurar o Cofre \n~INPUT_CELLPHONE_DOWN~ Retirar a Broca\n~INPUT_JUMP~ Parar de Perfurar'
			AddTextEntry("vrp_roubobanco_drill_info_text", text)
			DisplayHelpTextThisFrame("vrp_roubobanco_drill_info_text", false)

            drillScaleform()
            Wait(0)
            BeginScaleformMovieMethod(scaleform, "SET_SPEED")
            PushScaleformMovieMethodParameterFloat(speed)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_HOLE_DEPTH")
            PushScaleformMovieMethodParameterFloat(depth)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_DRILL_POSITION")
            PushScaleformMovieMethodParameterFloat(position)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_TEMPERATURE")
            PushScaleformMovieMethodParameterFloat(temperature)
            EndScaleformMovieMethod()
        end
        Wait(250)
    end
end)

local particleLooped = nil

Citizen.CreateThread(function()
    while true do
        if drilling then
            if depth-position >= 0 then
                currentDrillAnim = 'drill_straight_idle'
            end
            RequestAnimDict('anim@heists@fleeca_bank@drilling')
            while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                Wait(10)
            end

            if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 3) then
                TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 8.0, 8.0, -1, 17, 1, false, false, false)
            end
        end
        Wait(250)
    end
end)

Citizen.CreateThread(function()
    local user_id = vRP.getUserId(source)
    while true do
        if quebrandotudo then
            RequestAnimDict('weapons@heavy@minigun')
            while not HasAnimDictLoaded('weapons@heavy@minigun') do
                Wait(10)
            end
            if not IsEntityPlayingAnim(PlayerPedId(), 'weapons@heavy@minigun', "idle_2_aim_right_med", 3) then
                vRP._playAnim(false,{{'weapons@heavy@minigun','idle_2_aim_right_med'}},false)
                --TaskPlayAnim(PlayerPedId(), 'weapons@heavy@minigun', "idle_2_aim_right_med", 1.0, -1, -1, 50, 0, 0, 0, 0)
                local cdr = GetEntityCoords(furadeiraentity)

                RequestNamedPtfxAsset("des_fib_floor")
                while not HasNamedPtfxAssetLoaded("des_fib_floor") do
                    Wait(10)
                end
                Wait(1000)
                TriggerEvent("vrp_sound:distance",source, 8, "saw", 0.8) 
                while quebrandotudo do
                UseParticleFxAssetNextCall("des_fib_floor")
                local pp1 = StartNetworkedParticleFxNonLoopedAtCoord("ent_ray_fbi5a_ramp_metal_imp", cdr, 0.0, 0.0, 0.0, 3.0, false, false, true, 0)
                UseParticleFxAssetNextCall("des_fib_floor")
                local pp1 = StartNetworkedParticleFxNonLoopedAtCoord("ent_ray_fbi5a_ramp_fragment", cdr, 0.0, 0.0, 0.0, 1.1, false, false, true, 0)
                Citizen.Wait(500)
                end
            end
        end
        Wait(250)
    end
end)

Citizen.CreateThread(function()
    while true do
        if termitacolocando then
            Wait(5000)
            local cdr1 = GetEntityCoords(thermalentity)
            local xt,yt,zt = table.unpack(cdr1)
            if not HasNamedPtfxAssetLoaded("scr_ornate_heist") then
                RequestNamedPtfxAsset("scr_ornate_heist")
                while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
                    Wait(1)
                end
            end
            Wait(1000)
            while termitacolocando do
                UseParticleFxAssetNextCall("scr_ornate_heist")
                local pp1 = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", xt,yt+0.99,zt+0.01, 0.0, 0.0, 0.0, 1.0, false, false, true, 0)
                Citizen.Wait(2000)
                StopParticleFxLooped(pp1)
            end
        end
        Wait(1000)
    end
end)

RegisterNetEvent('vrp_roubobanco:particleTimer')
AddEventHandler('vrp_roubobanco:particleTimer', function(time)
    Wait(time)
    StopParticleFxLooped(particleLooped)
    particleLooped = nil
end)

Citizen.CreateThread(function()
    while true do
        Wait(750)
        if drilling then
            while drilling do
                Wait(0)
                if IsDisabledControlPressed(0, 172) and not finishedDrilling then
                    if temperature < 1.0 then
                        RequestAnimDict('anim@heists@fleeca_bank@drilling')
                        while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                            Wait(10)
                        end

                        TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_start', 8.0, 8.0, -1, 17, 1, false, false, false)
                        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)
                        while IsDisabledControlPressed(0, 172) and temperature < 1.0 do
                            drilling = true
                            if speed < 0.7 then
                                speed = speed + (math.random(1, 5)/100)
                            end
                            if depth-position >= 0 then
                                position = position + ((math.random(1, 5)/1000)+(speed/10))
                                currentDrillAnim = 'drill_straight_idle'
                                playSound = false
                            else
                                local randomDepth = math.random(1, 5)/1000
                                depth = depth + randomDepth
                                position = position + randomDepth
                                temperature = temperature + 0.02
                                playSound = true

                                currentDrillAnim = 'drill_straight_start'

                                local c = GetEntityCoords(drillEntity)
                            end
                            if depth >= 0.9 then
                                drilling = false
                                finishedDrilling = true
                                break
                            end
                            Wait(100)
                        end
                        if temperature >= 1.0 then
                            playSound = false
                            local c = GetEntityCoords(drillEntity)
                            RequestNamedPtfxAsset("core")
                            while not HasNamedPtfxAssetLoaded("core") do
                                Wait(0)
                            end
                            UseParticleFxAssetNextCall("core")
                            particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                            SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)

                            for i = 1, 100 do
                                if speed > 0 then
                                    speed = speed - 0.01
                                end
                                if temperature > 0 then
                                    temperature = temperature - 0.01
                                end
                                if position > 0 then
                                    position = position - 0.01
                                end
                                if temperature <= 0.2 then
                                    break   
                                end
                                Wait(250)
                            end
                            playSound = true
                            TriggerEvent('vrp_roubobanco:particleTimer', 750)
                        end
                    else
                        playSound = false
                        local c = GetEntityCoords(drillEntity)
                        RequestNamedPtfxAsset("core")
                        while not HasNamedPtfxAssetLoaded("core") do
                            Wait(0)
                        end
                        UseParticleFxAssetNextCall("core")
                        particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                        SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)
                        for i = 1, 100 do
                            if speed > 0 then
                                speed = speed - 0.01
                            end
                            if temperature > 0 then
                                temperature = temperature - 0.01
                            end
                            if position > 0 then
                                position = position - 0.005
                            end
                            if temperature <= 0.2 then
                                break   
                            end
                            Wait(250)
                        end
                        playSound = true
                        TriggerEvent('vrp_roubobanco:particleTimer', 750)
                    end
                elseif IsDisabledControlPressed(0, 173) then
                    playSound = false
                    position = position - 0.015
                    temperature = temperature - 0.015
                    speed = speed - 0.015
                    Wait(50)
                else
                    if speed > 0.0 then
                        speed = speed - 0.01
                        Wait(50)
                    end
                    if temperature > 0.0 then
                        temperature = temperature - 0.01
                        Wait(50)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if blockKeys then
            for i = 0, 256 do
            DisableAllControlActions(i)
            Wait(0)
            end
        else
            Wait(250)
        end
    end
end)

function Textinho3D(x,y,z,text,time)
	local timesdone = 0
    while timesdone <= time/10 do
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 155)
        SetTextEdge(1, 0, 0, 0, 250)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 41, 41, 68)
		Wait(0)
		timesdone = timesdone + 1
	end
end

function TextoMarker(x,y,z, text, Opacidade, s1, s2)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then 
        SetTextScale(s1, s2)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, Opacidade)
        SetTextDropshadow(0, 0, 0, 0, Opacidade)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function loadAnimDict(dict)
    Citizen.CreateThread(function()
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            
            Citizen.Wait(1)
        end
    end)
end

function loadModel(model)
    Citizen.CreateThread(function()
        while not HasModelLoaded(model) do
            RequestModel(model)
          Citizen.Wait(1)
        end
    end)
end