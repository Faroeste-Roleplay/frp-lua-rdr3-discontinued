Config = {}

--[[
	? Shops
		* name : type : group
	? Transactions
		* item : amount : dollar : gold : level : override_group
]]
Config.Shops = {
	{
		name = "Arsenal",
		type = "buy",
		group = "trooper",
		transactions = {
			-- {item = "revolver_doubleaction"},
			{item = "revolver_lemat"},
			{item = "ammo_revolver", amount = 20},
			{item = "rifle_boltaction"},
			{item = "ammo_rifle", amount = 20},
			{item = "repeater_evans"},
			{item = "ammo_repeater", amount = 20},
			{item = "melee_lantern_electric"},
			{item = "melee_torch"},
			{item = "lasso"},
			{item = "melee_knife"},
			{item = "eagleeye"}
		}
	},
	{
		name = "Mercado Geral",
		type = "buy",
		transactions = {
			-- {item = "tobacco_seed", dollar = 0.10, gold = 0.04},
			-- {item = "corn_seed", dollar = 0.10, gold = 0.04},
			-- {item = "sugarcane_seed", dollar = 0.10, gold = 0.04},
			-- { item = "pickaxe", 1, 100, 40},
			{item = "lasso", dollar = 30.00, gold = 12.00},
			{item = "melee_knife", dollar = 20.00, gold = 8.00},
			{item = "melee_lantern_electric", dollar = 2.00, gold = 0.80},
			{item = "melee_torch", dollar = 2.00, gold = 0.80},
			{item = "bow", dollar = 70.00, gold = 28.00},
			{item = "ammo_arrow", dollar = 1.00, gold = 0.40}
		}
	},
	{
		name = "Mercado Clandestino",
		type = "buy",
		transactions = {
			{item = "medicine_poor", dollar = 80.0, gold = 32.0},
			{item = "stimulant_poor", dollar = 70.0, gold = 28.0},
			{item = "pigeonpost", dollar = 50.0, gold = 30},
			{item = "acamp_tents_small", dollar = 30.0, gold = 2.0},
			{item = "acamp_tents_med_closed", dollar = 50.0, gold = 3.5},
			{item = "acamp_bedroll", dollar = 5.0, gold = 0.4},
			{item = "acamp_firesmall", dollar = 5.0, gold = 0.4},
			{item = "acamp_firesmal_pan", dollar = 8.0, gold = 0.6}
		}
	},
	{
		name = "Acogueiro",
		type = "sell",
		transactions = {
			{item = "meat_poor", dollar = 0.78},
			{item = "meat_good", dollar = 1.37},
			{item = "meat_perfect", dollar = 3.56},
			{item = "feather_1", amount = 5, dollar = 1.0},
			{item = "feather_2", amount = 5, dollar = 1.0}
		}
	},
	{
		name = "Posto de Troca",
		type = "sell",
		transactions = {
			{item = "raw_coal", amount = 2, dollar = 1.0},
			{item = "raw_iron", amount = 2, dollar = 2.0},
			{item = "raw_copper", amount = 2, dollar = 3.0}
		}
	}
}

Config.Locations = {
	-- x, y, z, heading(optional)
	-- ["Armeiro"] = {
	-- {-281.99, 780.92, 119.52}, -- VALENTINE
	-- {1322.87, -1321.48, 76.89},
	-- 	{2715.91, -1285.65, 48.63},
	-- 	{2946.53, 1319.66, 44.82},
	-- 	{-5508.16, -2964.47, -0.63}
	-- },
	["Arsenal"] = {
		{-764.768, -1272.072, 44.041},
		{-1813.974, -354.651, 164.649},
		{-278.365, 805.207, 119.380},
		{2494.231, -1304.628, 48.954}, -- Saint Denis
		{2494.392, -1312.568, 48.954}, -- Saint Denis
		{2907.258, 1308.845, 44.938}, -- annes
		{1361.610, -1302.085, 77.773} -- Rhodes
	},
	-- ["Mercadinho"] = {
	-- 	{373.875, 325.896, 103.566},
	-- 	{2557.458, 382.282, 107.622},
	-- 	{-3038.939, 585.954, 6.908},
	-- 	{-3241.927, 1001.462, 11.830},
	-- 	{547.431, 2671.710, 41.156},
	-- 	{1961.464, 3740.672, 31.343},
	-- 	{2678.916, 3280.671, 54.241},
	-- 	{-2540.81, 2313.85, 33.41},
	-- 	{161.41, 6640.7, 31.71},
	-- 	{1729.216, 6414.131, 35.037}
	-- },
	["Mercado Clandestino"] = {
		{2859.706, -1200.646, 49.590}
	},
	["Mercado Geral"] = {
		{1327.907, -1292.865, 77.023},
		{-785.338, -1323.850, 43.884}
	},
	["Posto de Troca"] = {
		{3027.058, 561.334, 44.794}
	}
}
