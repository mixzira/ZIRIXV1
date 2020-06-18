Config = {}

Config.SafeMinimum = 20000
Config.SafeMax = 30000

Config.SafeMinimumCarrinho = 11000
Config.SafeMaxCarrinho = 18000

Config.marker = { --Markers dos pontos de assalto
	idmarker = 27,
	x1 = 1.501,
	y1 = 1.5001,
	z1 = 0.5001,
	r = 255,
	g = 0,
	b = 0,
	a = 155,
	pula = 0,
	gira = 1  
}

Config.randomValues = {
    1000000,
    800000
}



Config.DrillSpawns = {
    vector3(-568.79, -1695.2, 19.11),
    vector3(-569.32, -1712.5, 22.36),
    vector3(-541.16, -1690.6, 18.96),
    vector3(-521.73, -1680.65, 18.36),
    vector3(-480.52, -1744.46, 17.65)
}

Config.WeldingSpawns = {
    vector3(1073.15, -1985.27, 30.07),
    vector3(1088.59, -1998.64, 30.05),
    vector3(1074.13, -2009.92, 31.2)
}

Config.Camera = {
    [1] = {
        fromX = 1415.88, fromY = 1154.64, fromZ = 132.58,
        fromRx = -125.0, fromRy = 0.0, fromRz = 160.0, fromR = 0,

        toX = 1416.4, toY = 1153.97, toZ = 114.78,
        toRx = 0.0, toRy = 0.0, toRz = 160.0, toR = 0
    },
}

Config.Boxes = {Full = 'prop_cash_crate_01', Half = 'hei_prop_cash_crate_half_full', Empty = 'hei_prop_cash_crate_empty'}

Config.BankRobbery = {
    [1] = {
        Coods = vector3(256.10165405273,215.24116516113,105.28686523438),
        Cops = 0,
        Doors = { 
            {Coords = vector3(257.22, 220.72, 106.28), Object = "hei_v_ilev_bk_gate_pris", Heading = -20.0, WeldPosition = {C = vector3(256.88,219.48,105.41), H = 338.38}, Time = 2, Frozen = true}, 
            {Coords = vector3(261.58, 222.05, 106.28), Object = "hei_v_ilev_bk_gate2_pris", Heading = -110.0, WeldPosition = {C = vector3(260.99, 221.90, 105.4), H = 254.73}, Time = 2, Frozen = true}, 
            {Coords = vector3(252.95, 221.16, 101.68), Object = "hei_v_ilev_bk_safegate_pris", Heading = 160.0, WeldPosition = {C = vector3(253.53,221.00,100.68), H = 158.38}, Time = 2, Frozen = true}, 
            {Coords = vector3(261.36, 215.67, 101.68), Object = "hei_v_ilev_bk_safegate_pris", Heading = -110.0, WeldPosition = {C = vector3(261.25, 216.03, 100.68), H = 254.73}, Time = 2, Frozen = true},
            {Coords = vector3(253.90, 225.23, 101.87), Object = "v_ilev_bk_vaultdoor", Heading = 160.0, OpenHeading = -20.0, Hacking = true, Time = 5, Frozen = true},
        },
        Safes = {  
            {Looted = false, Coords = vector3(259.61, 214.12, 100.8), Heading = 137.47, Cam = {From = {x = 258.16, y = 215.5, z = 102.5, rx = -25.0, ry = 0.0, rz = 200.0, r = 0}, To = {x = 260.92, y = 214.7, z = 102.5, rx = -25.0, ry = 0.0, rz = 123.0, r = 0}}},
            {Looted = false, Coords = vector3(258.3, 214.54, 100.8), Heading = 137.47, Cam = {From = {x = 257.73, y = 215.5, z = 102.5, rx = -25.0, ry = 0.0, rz = 200.0, r = 0}, To = {x = 260.92, y = 214.7, z = 102.5, rx = -25.0, ry = 0.0, rz = 123.0, r = 0}}},
            {Looted = false, Coords = vector3(256.83, 215.12, 100.8), Heading = 137.47, Cam = {From = {x = 256.3, y = 216.4, z = 102.5, rx = -25.0, ry = 0.0, rz = 200.0, r = 0}, To = {x = 260.92, y = 214.7, z = 102.5, rx = -25.0, ry = 0.0, rz = 123.0, r = 0}}},
            {Looted = false, Coords = vector3(260.76, 217.40, 100.8), Heading = 317.47, Cam = {From = {x =257.67, y = 218.18, z = 102.5, rx = -25.0, ry = 0.0, rz = 250.0, r = 0}, To = {x = 260.76, y = 217.4, z = 102.5, rx = 25.0, ry = 0.0, rz = 123.0, r = 0}}},
            {Looted = false, Coords = vector3(258.01, 218.32, 100.8), Heading = 317.47, Cam = {From = {x =256.67, y = 218.07, z = 102.5, rx = -25.0, ry = 0.0, rz = 250.0, r = 0}, To = {x = 260.76, y = 217.4, z = 102.5, rx = 25.0, ry = 0.0, rz = 123.0, r = 0}}},
        }, 
        Money = {
            StartMoney = Config.randomValues[math.random(1, #Config.randomValues)],
            Amount = Config.randomValues[math.random(1, #Config.randomValues)],
            BoxPosition = vector3(264.31, 213.77, 101.54),
            Coords = vector3(263.48522949219,213.74145507813,100.68336486816),
            Heading = 253.62,
            Box = 'prop_cash_crate_01',
            Cam = {Coords = {x = 265.85, y = 213.51, z = 103.0}, Rotation = {rx = -35.0, ry = 0.0, rz = 70.0, r = 0}},
        },
        Hacking = {
            Coords = vector3(253.572,228.28,100.68),
            Heading = 74.73,
        },
        Carrinhos = { 
            {Looted = false, Coords = vector3(263.2243347168,215.8568572998,100.68338775635), Coodsp = vector3(263.29870605469,215.32388305664,100.68338775635), Heading = 0.0},
            {Looted = false, Coords = vector3(262.14376831055,213.36863708496,100.68338775635), Coodsp = vector3(262.12249755859,213.86935424805,100.68338775635), Heading = 180.0}, 
            {Looted = false, Coords = vector3(266.0442199707,214.85108947754,100.68338775635), Coodsp = vector3(265.44003295898,214.77163696289,100.68338775635), Heading = 270.0}, 
         },
        BankName = 'Banco Central'
    }
}