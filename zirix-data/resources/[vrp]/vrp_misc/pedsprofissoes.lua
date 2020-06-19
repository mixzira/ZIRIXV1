local pedlist = {
	{ ['x'] = 2432.78, ['y'] = 4802.78, ['z'] = 34.82, ['h'] = 128.22, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 2440.98, ['y'] = 4794.38, ['z'] = 34.66, ['h'] = 128.22, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 2449.0, ['y'] = 4786.67, ['z'] = 34.65, ['h'] = 128.22, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 2457.28, ['y'] = 4778.75, ['z'] = 34.52, ['h'] = 128.22, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 2464.67, ['y'] = 4770.23, ['z'] = 34.38, ['h'] = 128.22, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },

	-- venda de celular
	{ ['x'] = -626.09, ['y'] = -277.72, ['z'] = 35.58, ['h']  = 125.05, ['hash'] = 0xA5C787B6, ['hash2'] = "csb_anton" },
	-- venda de coca
	{ ['x'] = 499.6, ['y'] = -523.81, ['z'] = 24.88, ['h'] = 83.23, ['hash'] = 0xE497BBEF, ['hash2'] = "s_m_y_dealer_01" },
	{ ['x'] = -1089.67, ['y'] = -2397.98, ['z'] = 13.95, ['h'] = 150.52, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
 -- Venda de meta
	{ ['x'] = -326.38, ['y'] = -1300.5, ['z'] = 31.35, ['h'] = 95.37, ['hash'] = 0x69F46BF3, ['hash2'] = "S_F_Y_Factory_01" }, -- Venda Éter;
	{ ['x'] = -51.91, ['y'] = -2761.0, ['z'] = 6.09, ['h'] = 1.51, ['hash'] = 0xCAE9E5D5, ['hash2'] = "Csb_Cletus" }, -- outros

-- venda armas
	{ ['x'] = 991.28, ['y'] = -1551.53, ['z'] = 30.85, ['h'] = 277.29, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" }, -- outros
	{ ['x'] = 1123.05, ['y'] = -1304.66, ['z'] = 34.72, ['h'] = 3.25, ['hash'] = 0x0DE9A30A, ['hash2'] = "s_m_m_ammucountry" }, -- outros

	{ ['x'] = 1224.92, ['y'] = -2911.34, ['z'] = 5.93, ['h'] = 101.14, ['hash'] = 0xB3F3EE34, ['hash2'] = "S_M_Y_Blackops_01" } -- Contrabandista;
	
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))

		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(100)
		end

		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)