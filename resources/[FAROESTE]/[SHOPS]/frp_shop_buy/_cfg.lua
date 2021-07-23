Config = {}

Config.ShopDatas = {
	-- level, dollar, gold
	-- {
	-- 	name = "Armeiro",
	-- 	{
	-- 		{"revolver_lemat", 0, 317, 13},
	-- 		{"revolver_cattleman", 0, 50, 2},
	-- 		{"revolver_navy", 0, 257, 11},
	-- 		{"pistol_volcanic", 0, 300, 14},
	-- 		{"shotgun_sawedoff", 0, 65, 15},
	-- 		{"repeater_carbine", 0, 90, 4},
	-- 		{"repeater_henry", 0, 234, 10},
	-- 		{"sniperrifle_rollingblock", 0, 500, 20},
	-- 		{"rifle_varmint", 0, 72, 3}
	-- 	}
	-- },
	{
		name = "Arsenal",
		{
			{"revolver_doubleaction", 0, 0, 0},
			{"rifle_springfield", 0, 0, 0},
			{"repeater_evans", 0, 0, 0},
			{"ammo_revolver", 0, 0, 0},
			{"ammo_rifle", 0, 0, 0},
			{"ammo_repeater", 0, 0, 0},
			{"melee_lantern_electric", 0, 0, 0},
			{"melee_torch", 0, 0, 0},
			{"lasso", 0, 0, 0},
			{"melee_knife", 0, 0, 0},
			{"eagleeye", 1, 200, 80},
		}
	},
	{
		name = "Mercado Geral",
		{
			{"tobacco_seed", 1, 10, 4},
			{"corn_seed", 1, 10, 4},
			{"sugarcane_seed", 1, 10, 4},
			{"flask", 1, 10 , 2},
			-- {"pickaxe", 1, 100, 40},
			{"lasso", 1, 3000, 1200},
			{"melee_knife", 1, 2000, 800},
			{"melee_lantern_electric", 1, 200, 80},
			{"melee_torch", 1, 200, 80},
			{"bow", 1, 7000, 2800},
			{"ammo_arrow", 1, 100, 40},
			{"notepad", 1, 10, 4}
		}
	},
	{
		name = "Mercado Clandestino",
		{
			{"medicine_poor", 1, 1000, 100},
			{"stimulant_poor", 1, 1000, 100},
			{"pigeonpost", 1, 500, 30},
			{"flask", 1, 10, 2},
			-- {"acamp_tents_small", 1, 3000, 200},
			-- {"acamp_tents_med_closed", 1, 5000, 350},
			-- {"acamp_bedroll", 1, 500, 40},
			-- {"acamp_firesmall", 1, 500, 40},
			-- {"acamp_firesmal_pan", 1, 800, 60}
		}
	}
}

Config.ShopLocations = {
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
		{1361.610,-1302.085,77.773} -- Rhodes
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
	-- ["PlanetaSemente"] = {
	-- 	{1296.121, -1279.396, 75.834}
	-- },

	["Mercado Clandestino"] = {
		{2859.706,-1200.646,49.590}
	},


	["Mercado Geral"] = {
		{1327.907, -1292.865, 77.023},
		{-785.338, -1323.850, 43.884}
	}
}
