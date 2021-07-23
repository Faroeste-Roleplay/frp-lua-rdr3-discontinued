local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local r = {
	["trooper"] = {payment = 3000},
	["sheriff"] = {payment = 4500},
	["medic"] = {payment = 2500, xp = 0.0}
	-- ["vip1"] = {payment = 0, xp = 1.10},
	-- ["vip2"] = {payment = 0, xp = 1.20},
	-- ["vip3"] = {payment = 0, xp = 1.30},
}

-- local withHoldingPaymentToUsers = {}

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000 * 60 * 60)

			local userIdWithExpMultiplier = {}

			for group, d in pairs(r) do
				local payment = d.payment
				local exp = d.exp

				for _, User in pairs(API.getUsersByGroup(group, false)) do
					local user_id = User:getId()

					local Character = User:getCharacter()

					if Character then
						local Inventory = Character:getInventory()

						if Inventory:addItem("money", payment) then
							User:notify("alert", "Você acabou de receber o seu salário. Aproveite!")
						else
							-- if withHoldingPaymentToUsers[user_id] then
							-- 	payment = payment + withHoldingPaymentToUsers[user_id]
							-- end
							-- withHoldingPaymentToUsers[user_id] = payment
						end

						if exp ~= nil then
							userIdWithExpMultiplier[user_id] = exp
						end
					end
				end
			end

			local baseExp = 10.0

			for _, User in pairs(API.getUsers()) do
				local user_id = User:getId()

				local Character = User:getCharacter()

				if Character then
					local exp = baseExp * (userIdWithExpMultiplier[user_id] or 1.0)

					Character:varyExp(exp)
				end
			end
		end
	end
)

-- Citizen.CreateThread(
-- 	function()
-- 		while true do
-- 			Citizen.Wait(1000 * 60 * 1)

-- 			for user_id, totalpayment in pairs(withHoldingPaymentToUsers) do
-- 				local User = API.getUserFromId(user_id)
-- 				if User ~= nil then
-- 					local Character = User:getCharacter()
-- 					if Character ~= nil then
-- 						local Inventory = Character:getInventory()
-- 						if Inventory:addItem("money", totalpayment) then
-- 							User:notify("alert", "Você acabou de receber o seu salário. Aproveite!")
-- 							withHoldingPaymentToUsers[user_id] = nil
-- 						else
-- 							User:notify("error", "Sem espaço na Bolsa para receber salário!")
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- )
