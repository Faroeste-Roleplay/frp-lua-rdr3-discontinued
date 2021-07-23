Config = {}

Config.ShopDatas = {
	{
		name = "Mercado Geral",
		{
			-- {"tobacco", 100, 40, 10},
			-- {"corn", 100, 40, 10},
			-- {"sugarcane", 100, 40, 10}
			{"tobacco", 100, 10},
			{"corn", 100,  10},
			{"sugarcane", 100,  10}
		}
	},
	{
		name = "Acogueiro",
		{
			-- {"meat", 80, 32, 1},
			-- {"feather_1", 100, 40, 5},
			-- {"feather_2", 100, 40, 5}
			{"meat", 78, 1},
			{"meat_poor", 78, 1},
			{"meat_good", 137, 1},
			{"meat_perfect", 356, 1},
			{"feather_1", 100, 5},
			{"feather_2", 100, 5}
		}
	},
	{
		name = "Posto de Troca",
		{
			-- {"raw_coal", 100, 40, 2},
			-- {"raw_iron", 200, 80, 2},
			-- {"raw_copper", 300, 120, 2}
			{"raw_coal", 100, 2},
			{"raw_iron", 200, 2},
			{"raw_copper", 300, 2}
		}
	}
}

Config.ShopLocations = {
	-- ["Mercado Geral"] = {
	-- 	{-883.373, -1421.761, 44.413}
	-- },
	["Posto de Troca"] = {
		{3027.058, 561.334, 44.794}
	}
}
