local cfg = {}

cfg.list = {
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ DELEGACIA ANTIGA ]---------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[1] = { text = true, hash = -1215222675, ['x'] = 434.58, ['y'] = -981.22, ['z'] = 30.71, lock = true, perm = "administrador.permissao", perm2 = "mindmaster.permissao" }, -- Apenas Admin
	[2] = { text = true, hash = 320433149, ['x'] = 434.67, ['y'] = -982.6, ['z'] = 30.71, lock = true, perm = "administrador.permissao", perm2 = "mindmaster.permissao" }, -- Apenas Admin
	[3] = { text = true, hash = -2023754432, ['x'] = 469.28, ['y'] = -1014.48, ['z'] = 26.39, lock = true, perm = "administrador.permissao", perm2 = "mindmaster.permissao", other = 4 }, -- Apenas Admin
	[4] = { text = true, hash = -2023754432, ['x'] = 467.95, ['y'] = -1014.39, ['z'] = 26.39, lock = true, perm = "administrador.permissao", perm2 = "mindmaster.permissao", other = 3 }, -- Apenas Admin
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ OC METAFETAMINA ]----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[5] = { text = true, hash = -147325430, ['x'] = 1483.95, ['y'] = 6392.03, ['z'] = 23.33, lock = true, perm = "grove.permissao", perm2 = "lider-grove.permissao" },
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ OC COCAINA ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[6] = { text = true, hash = -147325430, ['x'] = -1096.96, ['y'] = 4949.62, ['z'] = 218.65, lock = true, perm = "ballas.permissao", perm2 = "lider-ballas.permissao" },
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ OC COCAINA ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[7] = { text = true, hash = -495720969, ['x'] = 113.77, ['y'] = -1296.72, ['z'] = 29.27, lock = true, perm = "unicorn.permissao", perm2 = "lider-unicorn.permissao" },
	[8] = { text = true, hash = -626684119, ['x'] = 99.56, ['y'] = -1293.27, ['z'] = 29.27, lock = true, perm = "unicorn.permissao", perm2 = "lider-unicorn.permissao" },
	[9] = { text = true, hash = 668467214, ['x'] = 95.51, ['y'] = -1285.27, ['z'] = 29.28, lock = true, perm = "unicorn.permissao", perm2 = "lider-unicorn.permissao" },
	[10] = { text = true, hash = -1116041313, ['x'] = 128.5, ['y'] = -1297.98, ['z'] = 29.27, lock = false, perm = "unicorn.permissao", perm2 = "lider-unicorn.permissao" },
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ MANSÃO MAFIA BLOCK ]-------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[11] = { text = true, hash = -2023754432, ['x'] = 1398.41, ['y'] = 1143.18, ['z'] = 109.75, lock = true, perm = "0.permissao", perm2 = "0.permissao" }, -- Apenas Admin
	[12] = { text = true, hash = -2023754432, ['x'] = 1396.69, ['y'] = 1134.12, ['z'] = 109.75, lock = true, perm = "0.permissao", perm2 = "0.permissao" }, -- Apenas Admin
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ MANSÃO MAFIA ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[13] = { text = true, hash = -52575179, ['x'] = 1390.7, ['y'] = 1132.69, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 14 }, -- Direita
	[14] = { text = true, hash = -1032171637, ['x'] = 1390.64, ['y'] = 1131.76, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 13 }, -- Esquerda
	[15] = { text = true, hash = -52575179, ['x'] = 1399.91, ['y'] = 1128.33, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 16 }, -- Direita
	[16] = { text = true, hash = -1032171637, ['x'] = 1400.93, ['y'] = 1128.33, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 15 }, -- Esquerda
	[17] = { text = true, hash = 1504256620, ['x'] = 1395.96, ['y'] = 1142.26, ['z'] = 114.66, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 18 }, -- Direita
	[18] = { text = true, hash = 262671971, ['x'] = 1395.89, ['y'] = 1141.35, ['z'] = 114.66, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 17 }, -- Esquerda
	[19] = { text = true, hash = -52575179, ['x'] = 1390.39, ['y'] = 1162.77, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 20 }, -- Direita
	[20] = { text = true, hash = -1032171637, ['x'] = 1390.37, ['y'] = 1161.9, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 19 }, -- Esquerda
	[21] = { text = true, hash = -52575179, ['x'] = 1408.16, ['y'] = 1160.53, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 22 }, -- Direita
	[22] = { text = true, hash = -1032171637, ['x'] = 1408.08, ['y'] = 1159.54, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 21 }, -- Esquerda
	[23] = { text = true, hash = -52575179, ['x'] = 1408.09, ['y'] = 1165.13, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 24 }, -- Direita
	[24] = { text = true, hash = -1032171637, ['x'] = 1408.09, ['y'] = 1164.28, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao", other = 23 }, -- Esquerda
	[25] = { text = true, hash = 262671971, ['x'] = 1406.94, ['y'] = 1128.39, ['z'] = 114.34, lock = true, perm = "medellin.permissao", perm2 = "lider-medellin.permissao" },
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ BENNYS ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[26] = { text = true, hash = -427498890, ['x'] = -205.68, ['y'] = -1310.62, ['z'] = 31.3, lock = true, perm = "bennys.permissao", perm2 = "0.permissao" },
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ HOSPITAL ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[80] = { text = true, hash = -770740285, ['x'] = 311.37, ['y'] = -599.51, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao" },
	[81] = { text = true, hash = -1143010057, ['x'] = 313.75, ['y'] = -580.07, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 82 },
	[82] = { text = true, hash = -1143010057, ['x'] = 314.89, ['y'] = -580.48, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 81 },
	[83] = { text = true, hash = -1143010057, ['x'] = 331.88, ['y'] = -573.56, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 84 },
	[84] = { text = true, hash = -1143010057, ['x'] = 332.31, ['y'] = -572.34, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 83 },
	[85] = { text = true, hash = -1143010057, ['x'] = 341.34, ['y'] = -587.6, ['z'] = 43.3, lock = false, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 86 },
	[86] = { text = true, hash = -1143010057, ['x'] = 342.6, ['y'] = -588.2, ['z'] = 43.3, lock = false, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 85 },
	[87] = { text = true, hash = -1143010057, ['x'] = 337.62, ['y'] = -584.79, ['z'] = 43.3, lock = false, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 88 },
	[88] = { text = true, hash = -1143010057, ['x'] = 338.04, ['y'] = -583.52, ['z'] = 43.3, lock = false, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 87 },
	[89] = { text = true, hash = -1143010057, ['x'] = 359.31, ['y'] = -582.11, ['z'] = 43.3, lock = false, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 90 },
	[90] = { text = true, hash = -1143010057, ['x'] = 358.86, ['y'] = -583.47, ['z'] = 43.3, lock = false, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 89 },
	[91] = { text = true, hash = -770740285, ['x'] = 340.07, ['y'] = -596.32, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao" },
	[92] = { text = true, hash = -770740285, ['x'] = 336.39, ['y'] = -592.99, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao" },
	[93] = { text = true, hash = -770740285, ['x'] = 310.25, ['y'] = -603.1, ['z'] = 43.3, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao" },
	[94] = { text = true, hash = -1143010057, ['x'] = 337.66, ['y'] = -584.75, ['z'] = 48.23, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 95 },
	[95] = { text = true, hash = -1143010057, ['x'] = 338.17, ['y'] = -583.55, ['z'] = 48.23, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 94 },
	[96] = { text = true, hash = -1143010057, ['x'] = 332.89, ['y'] = -586.93, ['z'] = 48.23, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 97 },
	[97] = { text = true, hash = -1143010057, ['x'] = 334.17, ['y'] = -587.4, ['z'] = 48.23, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 96 },
	[98] = { text = true, hash = -1143010057, ['x'] = 337.78, ['y'] = -584.87, ['z'] = 74.27, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 99 },
	[99] = { text = true, hash = -1143010057, ['x'] = 338.16, ['y'] = -583.52, ['z'] = 74.27, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 98 },
	[100] = { text = true, hash = -1143010057, ['x'] = 318.92, ['y'] = -570.94, ['z'] = 28.9, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 101 },
	[101] = { text = true, hash = -1143010057, ['x'] = 319.56, ['y'] = -569.76, ['z'] = 28.9, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 100 },
	[102] = { text = true, hash = -1143010057, ['x'] = 328.12, ['y'] = -586.9, ['z'] = 28.9, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 103 },
	[103] = { text = true, hash = -1143010057, ['x'] = 327.64, ['y'] = -588.39, ['z'] = 28.9, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 102 },
	[104] = { text = true, hash = -1143010057, ['x'] = 349.92, ['y'] = -575.13, ['z'] = 28.9, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 105 },
	[105] = { text = true, hash = -1143010057, ['x'] = 348.65, ['y'] = -574.72, ['z'] = 28.9, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao", other = 104 },
	[106] = { text = true, hash = -770740285, ['x'] = 340.57, ['y'] = -586.72, ['z'] = 28.9, lock = true, perm = "dmla.permissao", perm2 = "paisana-dmla.permissao" },
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[ DELEGACIA ]----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	[120] = { text = true, hash = -350181704, ['x'] = -1090.76, ['y'] = -809.1, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 121 },
	[121] = { text = true, hash = -350181704, ['x'] = -1091.81, ['y'] = -809.81, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 120 },
	[122] = { text = true, hash = -350181704, ['x'] = -1093.03, ['y'] = -810.84, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 123 },
	[123] = { text = true, hash = -350181704, ['x'] = -1094.02, ['y'] = -811.7, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 122 },
	[124] = { text = true, hash = -350181704, ['x'] = -1061.24, ['y'] = -828.3, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 125 },
	[125] = { text = true, hash = -350181704, ['x'] = -1062.14, ['y'] = -827.25, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 124 },
	[126] = { text = true, hash = -1255368438, ['x'] = -1098.24, ['y'] = -836.12, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 127 },
	[127] = { text = true, hash = -1255368438, ['x'] = -1098.99, ['y'] = -835.12, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 126 },
	[128] = { text = true, hash = -1255368438, ['x'] = -1091.62, ['y'] = -818.15, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 129 },
	[129] = { text = true, hash = -1255368438, ['x'] = -1092.65, ['y'] = -818.88, ['z'] = 19.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 128 },
	
	[130] = { text = true, hash = -1821777087, ['x'] = -1108.41, ['y'] = -832.95, ['z'] = 34.37, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", other = 131 },
	[131] = { text = true, hash = -1821777087, ['x'] = -1109.52, ['y'] = -833.94, ['z'] = 34.37, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", other = 130 },
	[132] = { text = true, hash = -1821777087, ['x'] = -1108.18, ['y'] = -832.75, ['z'] = 30.76, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", other = 133 },
	[133] = { text = true, hash = -1821777087, ['x'] = -1109.16, ['y'] = -833.56, ['z'] = 30.76, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", other = 132 },

	[134] = { text = true, hash = -1255368438, ['x'] = -1098.8, ['y'] = -838.09, ['z'] = 26.85, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 135 },
	[135] = { text = true, hash = -1255368438, ['x'] = -1099.59, ['y'] = -836.91, ['z'] = 26.85, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 134 },
	[136] = { text = true, hash = -1255368438, ['x'] = -1069.89, ['y'] = -824.29, ['z'] = 26.85, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 137 },
	[137] = { text = true, hash = -1255368438, ['x'] = -1068.67, ['y'] = -824.39, ['z'] = 26.85, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 136 },
	[138] = { text = true, hash = -2023754432, ['x'] = -1074.74, ['y'] = -823.05, ['z'] = 14.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 139 },
	[139] = { text = true, hash = -2023754432, ['x'] = -1075.85, ['y'] = -823.8, ['z'] = 14.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 138 },
	[140] = { text = true, hash = -2023754432, ['x'] = -1085.98, ['y'] = -831.8, ['z'] = 14.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 141 },
	[141] = { text = true, hash = -2023754432, ['x'] = -1086.79, ['y'] = -830.67, ['z'] = 14.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 140 },
	[142] = { text = true, hash = -2023754432, ['x'] = -1094.88, ['y'] = -835.49, ['z'] = 14.29, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 143 },
	[143] = { text = true, hash = -2023754432, ['x'] = -1093.83, ['y'] = -834.63, ['z'] = 14.29, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 142 },
	[144] = { text = true, hash = -2023754432, ['x'] = -1102.41, ['y'] = -847.43, ['z'] = 13.69, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 145 },
	[145] = { text = true, hash = -2023754432, ['x'] = -1101.27, ['y'] = -846.71, ['z'] = 13.69, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 144 },
	[146] = { text = true, hash = -1255368438, ['x'] = -1072.94, ['y'] = -826.95, ['z'] = 11.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 147 },
	[147] = { text = true, hash = -1255368438, ['x'] = -1071.92, ['y'] = -826.11, ['z'] = 11.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 146 },
	[148] = { text = true, hash = -1255368438, ['x'] = -1086.93, ['y'] = -830.99, ['z'] = 11.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 149 },
	[149] = { text = true, hash = -1255368438, ['x'] = -1086.07, ['y'] = -831.95, ['z'] = 11.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 148 },
	[150] = { text = true, hash = -1255368438, ['x'] = -1093.83, ['y'] = -834.55, ['z'] = 10.28, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 151 },
	[151] = { text = true, hash = -1255368438, ['x'] = -1094.91, ['y'] = -835.43, ['z'] = 10.28, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 150 },
	[152] = { text = true, hash = -1255368438, ['x'] = -1079.15, ['y'] = -825.78, ['z'] = 11.16, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 153 },
	[153] = { text = true, hash = -1255368438, ['x'] = -1078.0, ['y'] = -825.04, ['z'] = 11.16, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 152 },
	[154] = { text = true, hash = -147325430, ['x'] = -1090.01, ['y'] = -841.09, ['z'] = 37.71, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[155] = { text = true, hash = -147325430, ['x'] = -1091.16, ['y'] = -841.59, ['z'] = 34.37, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[156] = { text = true, hash = -147325430, ['x'] = -1091.14, ['y'] = -841.45, ['z'] = 30.37, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[157] = { text = true, hash = -147325430, ['x'] = -1091.24, ['y'] = -841.58, ['z'] = 26.49, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[158] = { text = true, hash = -147325430, ['x'] = -1091.13, ['y'] = -841.61, ['z'] = 22.36, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[159] = { text = true, hash = -147325430, ['x'] = -1091.09, ['y'] = -841.49, ['z'] = 18.36, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[160] = { text = true, hash = -147325430, ['x'] = -1091.24, ['y'] = -841.55, ['z'] = 14.29, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[161] = { text = true, hash = -147325430, ['x'] = -1091.05, ['y'] = -841.35, ['z'] = 10.01, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[162] = { text = true, hash = -147325430, ['x'] = -1092.65, ['y'] = -842.73, ['z'] = 4.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[163] = { text = true, hash = -147325430, ['x'] = -1077.26, ['y'] = -830.16, ['z'] = 27.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[164] = { text = true, hash = -147325430, ['x'] = -1077.21, ['y'] = -830.22, ['z'] = 19.05, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[165] = { text = true, hash = -147325430, ['x'] = -1077.18, ['y'] = -830.3, ['z'] = 15.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[166] = { text = true, hash = -147325430, ['x'] = -1077.22, ['y'] = -830.15, ['z'] = 11.04, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[167] = { text = true, hash = -147325430, ['x'] = -1071.24, ['y'] = -833.63, ['z'] = 5.49, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[168] = { text = true, hash = -2023754432, ['x'] = -1089.8, ['y'] = -848.27, ['z'] = 4.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 169 },
	[169] = { text = true, hash = -2023754432, ['x'] = -1090.66, ['y'] = -847.27, ['z'] = 4.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 168 },
	[170] = { text = true, hash = -2023754432, ['x'] = -1097.9, ['y'] = -833.82, ['z'] = 4.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 171 },
	[171] = { text = true, hash = -2023754432, ['x'] = -1098.7, ['y'] = -832.76, ['z'] = 4.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 170 },
	[172] = { text = true, hash = -2023754432, ['x'] = -1101.86, ['y'] = -833.1, ['z'] = 4.89, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[173] = { text = true, hash = -2023754432, ['x'] = -1091.15, ['y'] = -835.62, ['z'] = 5.46, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 174 },
	[174] = { text = true, hash = -2023754432, ['x'] = -1092.01, ['y'] = -834.5, ['z'] = 5.46, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 173 },
	[175] = { text = true, hash = 631614199, ['x'] = -1087.17, ['y'] = -829.52, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[176] = { text = true, hash = 631614199, ['x'] = -1089.17, ['y'] = -829.68, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[177] = { text = true, hash = 631614199, ['x'] = -1086.21, ['y'] = -827.41, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[178] = { text = true, hash = 631614199, ['x'] = -1091.5, ['y'] = -826.45, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[179] = { text = true, hash = 631614199, ['x'] = -1088.61, ['y'] = -824.34, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[180] = { text = true, hash = 631614199, ['x'] = -1093.92, ['y'] = -823.29, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[181] = { text = true, hash = 631614199, ['x'] = -1091.03, ['y'] = -821.16, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[182] = { text = true, hash = 631614199, ['x'] = -1096.32, ['y'] = -820.2, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[183] = { text = true, hash = 631614199, ['x'] = -1073.24, ['y'] = -827.01, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[184] = { text = true, hash = -2023754432, ['x'] = -1085.46, ['y'] = -812.21, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 185 },
	[185] = { text = true, hash = -2023754432, ['x'] = -1086.33, ['y'] = -811.06, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 184 },
	[186] = { text = true, hash = -2023754432, ['x'] = -1090.5, ['y'] = -812.62, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[187] = { text = true, hash = -2023754432, ['x'] = -1078.11, ['y'] = -814.16, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[188] = { text = true, hash = -2023754432, ['x'] = -1081.74, ['y'] = -816.81, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[189] = { text = true, hash = -2023754432, ['x'] = -1074.85, ['y'] = -818.61, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[190] = { text = true, hash = -2023754432, ['x'] = -1078.34, ['y'] = -821.13, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao" },
	[191] = { text = true, hash = -2023754432, ['x'] = -1073.95, ['y'] = -822.04, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 192 },
	[192] = { text = true, hash = -2023754432, ['x'] = -1075.1, ['y'] = -822.75, ['z'] = 5.48, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 191 },
	[193] = { text = true, hash = -2023754432, ['x'] = -1057.25, ['y'] = -839.41, ['z'] = 5.01, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 194 },
	[194] = { text = true, hash = -2023754432, ['x'] = -1058.32, ['y'] = -840.36, ['z'] = 5.01, lock = true, perm = "dpla.permissao", perm2 = "paisana-dpla.permissao", other = 193 }
}

return cfg