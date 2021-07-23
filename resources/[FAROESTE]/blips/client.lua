local BLIP_COLORS = {
    LIGHT_BLUE = 'BLIP_MODIFIER_MP_COLOR_1',
    DARK_RED = 'BLIP_MODIFIER_MP_COLOR_2',
    PURPLE = 'BLIP_MODIFIER_MP_COLOR_3',
    ORANGE = 'BLIP_MODIFIER_MP_COLOR_4',
    TEAL = 'BLIP_MODIFIER_MP_COLOR_5',
    LIGHT_YELLOW = 'BLIP_MODIFIER_MP_COLOR_6',
    PINK = 'BLIP_MODIFIER_MP_COLOR_7',
    GREEN = 'BLIP_MODIFIER_MP_COLOR_8',
    DARK_TEAL = 'BLIP_MODIFIER_MP_COLOR_9',
    RED = 'BLIP_MODIFIER_MP_COLOR_10',
    LIGHT_GREEN = 'BLIP_MODIFIER_MP_COLOR_11',
    TEAL2 = 'BLIP_MODIFIER_MP_COLOR_12',
    BLUE = 'BLIP_MODIFIER_MP_COLOR_13',
    DARK_PUPLE = 'BLIP_MODIFIER_MP_COLOR_14',
    DARK_PINK = 'BLIP_MODIFIER_MP_COLOR_15',
    DARK_DARK_RED = 'BLIP_MODIFIER_MP_COLOR_16',
    GRAY = 'BLIP_MODIFIER_MP_COLOR_17',
    PINKISH = 'BLIP_MODIFIER_MP_COLOR_18',
    YELLOW_GREEN = 'BLIP_MODIFIER_MP_COLOR_19',
    DARK_GREEN = 'BLIP_MODIFIER_MP_COLOR_20',
    BRIGHT_BLUE = 'BLIP_MODIFIER_MP_COLOR_21',
    BRIGHT_PURPLE = 'BLIP_MODIFIER_MP_COLOR_22',
    YELLOW_ORANGE = 'BLIP_MODIFIER_MP_COLOR_23',
    BLUE2 = 'BLIP_MODIFIER_MP_COLOR_24',
    TEAL3 = 'BLIP_MODIFIER_MP_COLOR_25',
    TAN = 'BLIP_MODIFIER_MP_COLOR_26',
    OFF_WHITE = 'BLIP_MODIFIER_MP_COLOR_27',
    LIGHT_YELLOW2 = 'BLIP_MODIFIER_MP_COLOR_28',
    LIGHT_PINK = 'BLIP_MODIFIER_MP_COLOR_29',
    LIGHT_RED = 'BLIP_MODIFIER_MP_COLOR_30',
    LIGHT_YELLOW3 = 'BLIP_MODIFIER_MP_COLOR_31',
    WHITE = 'BLIP_MODIFIER_MP_COLOR_32'
}


local blips = {
	--SHERIFF
	--{name = "Sheriff (DP)", sprite = 1047294027, x = -3622.86, y = -2605.45, z = 13.34}, --ARMADILLO
	--{name = "Sheriff (DP)", sprite = 1047294027, x = -5527.6, y = -2953.36, z = -0.7}, --TUMBLEWEED
	--{name = "Sheriff (DP)", sprite = 1047294027, x = -759.17, y = -1266.61, z = 44.06}, --BLAKCWATER
	--{name = "Sheriff (DP)", sprite = 1047294027, x = -1808.51, y = -348.13, z = 164.65}, --STRAWBERRY
	--{name = "Sheriff (DP)", sprite = 1047294027, x = -275.95, y = 804.97, z = 119.38}, --VALENTINE
	{name = "Sheriff (DP)", sprite = 1047294027, x = 1359.64, y = -1304.43, z = 77.77, color = BLIP_COLORS.BLUE2}, --RHODES
	{name = "Sheriff (DP)", sprite = 1047294027, x = 2908.20, y = 1311.53, z = 44.94, color = BLIP_COLORS.BLUE2}, -- ANNESBURGS
	{name = "Departamento de Polícia", sprite = 1047294027, x = 2512.04, y = -1308.5, z = 48.95, color = BLIP_COLORS.BLUE2}, --SAINT DENIS

	-- LOJA DE ARMAS
--	{name = "Loja de Armas", sprite = -145868367, x = -281.27, y = 780.74, z = 119.53}, -- valentine
--	{name = "Loja de Armas", sprite = -145868367, x = -5508.14, y = -2964.33, z = -0.628},  -- tumbleweed
	{name = "Loja de Armas", sprite = -145868367, x = 2716.42, y = -1285.42, z = 49.63, color = BLIP_COLORS.YELLOW_GREEN}, -- saint dennis
	{name = "Loja de Armas", sprite = -145868367, x = 1322.67, y = -1323.16, z = 77.88, color = BLIP_COLORS.YELLOW_GREEN}, -- rhodes
--	{name = "Loja de Armas", sprite = -145868367, x = 2946.50, y = 1319.53, z = 44.82}, -- annesburg

	-- ESTABULO
--	{name = "Estábulo", sprite = 1938782895, x = -366.08, y = 787.01, z = 116.17}, -- valentine
--	{name = "Estábulo", sprite = 1938782895, x = -874.02, y = -1364.78, z = 43.53}, -- blackwater
--	{name = "Estábulo", sprite = 1938782895, x = -1777.02, y = -440.15, z = 154.96}, -- strawberry
	{name = "Estábulo", sprite = 1938782895, x = 2502.5, y = -1455.33, z = 46.31, color = BLIP_COLORS.TAN}, -- saint dennis
--	{name = "Estábulo", sprite = 1938782895, x = 2970.73, y = 1427.97, z = 44.71}, -- annesburg

	-- ACOUGUE
--	{name = "Açougue", sprite = -1665418949, x = -1753.07, y = -394.78, z = 156.18}, --Cabana de Açougue de Strawberry
--	{name = "Açougue", sprite = -1665418949, x = -341.08, y = 767.16, z = 116.71}, --Cabana de Açougue de Valentine
	{name = "Açougue", sprite = -1665418949, x = 1296.28, y = -1279.22, z = 75.84, color = BLIP_COLORS.RED}, --Cabana de Açougue de Rhodes
--	{name = "Açougue", sprite = -1665418949, x = -5508.29, y = -2948.16, z = -1.87}, --Cabana de Açougue de Tumbleweed

	-- ALUGUEL DE BARCOS	
--	{name = "Aluguel de Barcos", sprite = 2033397166, x = -686.16, y = -1243.67, z = 43.1},
	{name = "Aluguel de Barcos", sprite = 2033397166, x = 2883.17, y = -1354.51, z = 42.61, color = BLIP_COLORS.LIGHT_BLUE}, -- saint dennis
	{name = "Aluguel de Barcos", sprite = 2033397166, x = 3030.43, y = 553.86, z = 44.71, color = BLIP_COLORS.LIGHT_BLUE}, -- van horn	

	-- PRISÃO FEDERAL	
	{name = "Prisão Federal", sprite = 1047294027, x = 3372.48, y = -667.09, z = 46.41, color = BLIP_COLORS.LIGHT_BLUE},

	-- LOJA DE ROUPAS
	{name = "Loja de Roupas", sprite = 1195729388, x = 2549.83, y = -1160.05, z = 53.73, color = BLIP_COLORS.ORANGE}, -- saint dennis
--	{name = "Loja de Roupas", sprite = 1195729388, x = -762.85, y = -1291.94, z = 270.42}, -- blackwater
--	{name = "Loja de Roupas", sprite = 1195729388, x = -322.25, y = 803.97, z = 116.95}, -- valentine

	--DOCTOR
--	{name = "Doctor", sprite = -1739686743, x = -288.0, y = 804.56, z = 119.39}, -- valentine
	{name = "Doctor", sprite = -1739686743, x = 2725.525, y = -1233.167, z = 50.437, color = BLIP_COLORS.RED}, -- saint denni

	--SALOON
--	{name = "Saloon", sprite = 1879260108, x = -311.67, y = 806.43, z = 118.98}, -- valentine
	--{name = "Saloon", sprite = 1879260108, x = -817.69, y = -1318.75, z = 43.68}, -- blackwater
	{name = "Saloon", sprite = 1879260108, x = 2794.566, y = -1168.784, z = 47.933, color = BLIP_COLORS.TEAL},   -- saint denis  
	{name = "Saloon", sprite = 1879260108, x = 2632.096, y = -1224.096, z = 53.386, color = BLIP_COLORS.TEAL},   -- saint denis
	{name = "Saloon", sprite = 1879260108, x = 1347.172, y = -1374.833, z = 80.494, color = BLIP_COLORS.TEAL},   -- rhodes

	--BANCOS
	--{name = "Banco", sprite = -2128054417, x = -308.52, y = 775.99, z = 118.7}, -- valentine
	--{name = "Banco", sprite = -2128054417, x = -813.09, y = -1277.52, z = 43.64}, -- blackwater
	{name = "Banco", sprite = -2128054417, x = 2642.879, y = -1296.995, z = 52.252, color = BLIP_COLORS.LIGHT_YELLOW2}, -- saint DENIS
	{name = "Banco", sprite = -2128054417, x = 1299.520, y = -1300.899, z = 77.625, color = BLIP_COLORS.LIGHT_YELLOW2}, -- rhodes

	{name = "Teatro", sprite = -417940443, x = 2547.876, y = -1308.547, z = 49.287}, -- Saint Dennis

	-- CORREIOS
--	{name = "Correio", sprite = 1861010125, x = -872.21, y = -1334.13, z = 43.97},
	--{name = "Correio", sprite = 1861010125, x = -178.02, y = 635.27, z = 114.09}, -- valentine
	{name = "Correio", sprite = 1861010125, x = 1233.23, y = -1294.56, z = 76.65}, -- rhodes

	--FORTES
	{name = "Forte", sprite = 1322310532, x = 348.66, y = 1485.12, z = 181.17},
	{name = "Forte2", sprite = 1322310532, x = -1403.27, y = -2317.49, z = 43.62},

	--HOTELES
--	{name = "Motel", sprite = -211556852, x = -325.74, y = 772.92, z = 117.44},

	--Loja de itens
	{name = "Loja de itens", sprite = 249721687, x = 1327.907, y = -1292.865, z = 77.023}, -- rhodes
	--{name = "Loja de itens", sprite = 249721687, x = -785.338, y = -1323.850, z = 43.884}, -- blackwater

	{name = "Posto de Troca", sprite = -242384756, x = 3027.058, y = 561.334, z = 44.794}, -- van horn
--	{name = "Posto de Troca", sprite = -242384756, x = 3050.231, y = 553.261, z = 46.125}, 

	--loja de carroça
--	{name = "Loja de aluguel de Carroça", sprite = 1012165077, x = -396.48, y = 654.25, z = 114.66}, -- valentine
	{name = "Loja de aluguel de Carroça", sprite = 1012165077, x = 1889.65, y = -1343.7, z = 42.51}, -- saint dennis
	--{name = "Loja de aluguel de Carroça", sprite = 1012165077, x = -5514.86, y = -3044.4, z = -2.39},

	--CRIAÇAO DE BANDO
	{name = "Criar Bando", sprite = -428972082, x = -374.009, y = 724.092, z = 116.359},
	{name = "Mineração", sprite = 2107754879, x = 2752.87, y = 1364.09, z = 67.91},

	{name = "Mineração", sprite = 2107754879, x = 2293.26, y = 1070.23, z = 81.43},	

	{name = "Aldeia indígena", sprite = -1944395098, x = 449.36, y = 2234.05, z = 247.65},  

	-- { name = 'Processamento de Cobre', sprite = -2024635066, x = 2942.67, y = 1381.81, z = 56.25 },
	-- { name = 'Processamento de Metal', sprite = -2024635066, x = -6048.58, y = -3260.85, z = -17.98 },
	-- { name = 'Processamento de madeira', sprite = -2024635066, x = 2922.84, y = 1389.69, z = 56.25 },
	-- {name = "Madeira", sprite = 1904459580, x = 2630.26, y = 1800.17, z = 99.63},
	-- {name = "Madeira", sprite = 1904459580, x = 737.7, y = -1078.09, z = 56.39},
	-- {name = "Madeira", sprite = 1904459580, x = -2052.62, y = -1846.97, z = 121.04},
	-- {name = "Mineração", sprite = 2107754879, x = 2294.75, y = 1069.27, z = 81.49},
	-- {name = "Mineração", sprite = 2107754879, x = -2714.03, y = 698.33, z = 71.57},
	-- {name = "Mineração", sprite = 2107754879, x = 2320.37, y = 1442.39, z = 85.2},
	-- {name = "Mineração", sprite = 2107754879, x = -1518.34, y = 733.31, z = 126.37},
	-- {name = "Mineração", sprite = 2107754879, x = 833.26, y = 1925.9, z = 259.33},
	-- {name = "Mineração", sprite = 2107754879, x = 1708.77, y = 2196.46, z = 324.73},
	-- {name = "Mineração", sprite = 2107754879, x = -4396.01, y = -2160.36, z = 48.3},
	-- {name = "Mineração", sprite = 2107754879, x = -5978.16, y = -3164.54, z = -25.31},
	-- {name = "Mineração", sprite = 2107754879, x = -1434.47, y = 1207.79, z = 226.2},
	{name = "Convento Claremonnt", sprite = -695368421, x = 2401.339, y = -1103.892, z = 47.051}
}

local blipsLoaded = {}

Citizen.CreateThread(
	function()
		for _, info in pairs(blips) do
			local blipId = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, info.x, info.y, info.z)

			SetBlipSprite(blipId, info.sprite, 1);
			
			if info.color then
				Citizen.InvokeNative(0x662D364ABF16DE2F, blipId, GetHashKey(info.color));
			else 
				Citizen.InvokeNative(0x662D364ABF16DE2F, blipId, GetHashKey(BLIP_COLORS.WHITE));
			end
			
			local varString = CreateVarString(10, 'LITERAL_STRING', info.name);
			Citizen.InvokeNative(0x9CB1A1623062F402, blipId, varString)
			
			table.insert(blipsLoaded, blipId)
		end
	end
)


AddEventHandler(
	"onResourceStop",
	function(resourceName)
		if resourceName == GetCurrentResourceName() then
			for _, blip in pairs(blipsLoaded) do
				RemoveBlip(blip)
			end
		end
	end
)