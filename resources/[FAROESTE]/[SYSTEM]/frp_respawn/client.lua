local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local respawned = false
local firstjoin = true
local pressed = false
local canDisplayRespawnPrompt = false
local up = false

local deathCause = nil
local damageBone = {0}
-- local diedOfFatalCause = false
local TookDamageToVitalOrgan = false
local BodyPartDamage = {
	["cabeça"] = {},
	["pescoço"] = {},
	["coluna"] = {},
	["maoesquerda"] = {},
	["maodireita"] = {},
	["braçodireito"] = {},
	["braçoesquerdo"] = {},
	["pernadireita"] = {},
	["pedireito"] = {},
	["pernaesquerda"] = {},
	["peesquerdo"] = {},
	["genitaria"] = {}
}

local diedOfFatalCauseCauses = {
	"WEAPON_EXPLOSION",
	"WEAPON_FIRE"
}

local DeathCauses = {
	"WEAPON_HORSE",
	"WEAPON_DEER",
	"WEAPON_FIRE",
	"WEAPON_MOONSHINEJUG_MP",
	"WEAPON_EXPLOSION",
	"WEAPON_FALL", -- -842959696
	"WEAPON_POISON",
	"WEAPON_THROWN_POISONBOTTLE",
	"WEAPON_UNARMED",
	"WEAPON_RUN_OVER_BY_CAR",
	"WEAPON_BLEEDING",
	"WEAPON_DROWNING",
	"WEAPON_DROWNING_IN_VEHICLE",
	"WEAPON_MACHINERY",
	"weapon_moonshinejug",
	"weapon_bow",
	"weapon_melee_knife_hunter",
	"weapon_melee_lantern_electric",
	"weapon_melee_torch",
	"weapon_melee_broken_sword",
	"weapon_melee_hatchet",
	"weapon_melee_cleaver",
	"weapon_melee_ancient_hatchet",
	"weapon_melee_hatchet_viking",
	"weapon_melee_hatchet_hewing",
	"weapon_melee_hatchet_double_bit",
	"weapon_melee_hatchet_double_bit_rusted",
	"weapon_melee_hatchet_hunter",
	"weapon_melee_hatchet_hunter_rusted",
	"weapon_melee_knife_john",
	"weapon_melee_knife",
	"weapon_melee_knife_jawbone",
	"weapon_melee_knife_miner",
	"weapon_melee_knife_civil_war",
	"weapon_melee_knife_bear",
	"weapon_melee_knife_vampire",
	"weapon_melee_machete",
	"weapon_pistol_m1899",
	"weapon_pistol_mauser",
	"weapon_pistol_mauser_drunk",
	"weapon_pistol_semiauto",
	"weapon_pistol_volcanic",
	"weapon_revolver_cattleman",
	"weapon_revolver_cattleman_john",
	"weapon_revolver_cattleman_mexican",
	"weapon_revolver_cattleman_pig",
	"weapon_revolver_doubleaction",
	"weapon_revolver_doubleaction_exotic",
	"weapon_revolver_doubleaction_gambler",
	"weapon_revolver_doubleaction_micah",
	"weapon_revolver_lemat",
	"weapon_revolver_schofield",
	"weapon_revolver_schofield_golden",
	"weapon_revolver_schofield_calloway",
	"weapon_repeater_winchester",
	"weapon_repeater_carbine",
	"weapon_repeater_evans",
	"weapon_rifle_boltaction",
	"weapon_rifle_springfield",
	"weapon_rifle_varmint",
	"weapon_sniperrifle_carcano",
	"weapon_sniperrifle_rollingblock",
	"weapon_sniperrifle_rollingblock_exotic",
	"weapon_shotgun_doublebarrel",
	"weapon_shotgun_doublebarrel_exotic",
	"weapon_shotgun_pump",
	"weapon_shotgun_repeating",
	"weapon_shotgun_sawedoff",
	"weapon_shotgun_semiauto",
	"weapon_thrown_throwing_knives",
	"weapon_thrown_dynamite",
	"weapon_thrown_molotov",
	"weapon_thrown_tomahawk",
	"weapon_thrown_tomahawk_ancient"
}

local vitalBones = {
	"cabeça",
	"pescoço",
	"coluna"
}


local allbones = {
	["cabeça"] = {
		21030
	},
	["pescoço"] = {
		14283,
		14284,
		14285
	},
	["coluna"] = {
		14410,
		14411,
		14412,
		14413,
		14414,
		14415,
		14416,
		11569,
		56200
	},
	["maoesquerda"] = {
		41403,
		41404,
		41405,
		41323,
		41324,
		41325,
		41326,
		41307,
		41308,
		41309,
		41310,
		41355,
		41356,
		41357,
		41358,
		41339,
		41340,
		41341,
		41342,
		34606
	},
	["maodireita"] = {
		16827,
		16828,
		16829,
		16747,
		16748,
		16749,
		16750,
		16731,
		16732,
		16733,
		16734,
		16779,
		16780,
		16781,
		16782,
		16763,
		16764,
		16765,
		16766,
		22798
	},
	["braçodireito"] = {
		54187,
		46065
	},
	["braçoesquerdo"] = {
		53675,
		37873
	},
	["pernadireita"] = {
		6884,
		43312,
		54802
	},
	["pedireito"] = {
		33646,
		41273,
		18013,
		18029
	},
	["peesquerdo"] = {
		45454,
		53081,
		11440,
		11456
	},
	["pernaesquerda"] = {
		65478,
		55120,
		30226
	},
	["genitaria"] = {
		10208,
		10209,
		39035
	}
}

local isBadlyInjuried = false
local timesLeftPlayerCanGetUp = 2
local lastDiceChance
local fullDeathAtGameTime

local fakeGameplayCam
local fakeGameplayCamDeg = 0
-- local fakeGameplayCamUD = 0

local tempTable = {}
Citizen.CreateThread(
	function()
		local lastHealth  -- = GetEntityHealth(PlayerPedId())
		while true do	
			Citizen.Wait(100)
			-- if isBadlyInjuried == false then
			if lastHealth == nil or lastHealth ~= GetEntityHealth(PlayerPedId()) then
				local retVal, boneIndex = GetPedLastDamageBone(PlayerPedId())
				
				
				if boneIndex ~= 0 then
					table.insert(damageBone, boneIndex)
					for BodyPartName, v in pairs(allbones) do
						for _, IndexBodyPart in pairs(v) do
							if IndexBodyPart == boneIndex then
								if BodyInsta ~= BodyPartName then
									local weaponDamage 

									for _ ,hashWeapon in pairs(DeathCauses) do
										if Citizen.InvokeNative(0xDCF06D0CDFF68424, PlayerPedId(), GetHashKey(hashWeapon), 1) then
											weaponDamage = hashWeapon
										end
									end									
									if BodyPartDamage[BodyPartName][1] ~= nil then
										local amountDamage = BodyPartDamage[BodyPartName][1] + 1
										BodyPartDamage[BodyPartName][1] = tonumber(amountDamage)
									else
										table.insert(BodyPartDamage[BodyPartName], 1)
									end		

									
									
									for index, value in pairs(BodyPartDamage) do
										value = json.encode(value)
										if value ~= "[]" then
											if tempTable[index] ~= nil then
												local amountDamage = tempTable[index] + 1
												tempTable[index] = tonumber(amountDamage)
											else
												tempTable[index] = 1
											end

											TriggerServerEvent("FRP:RESPAWN:SetPlayerDamage", tempTable)
										end
									end
								end
								for _, bone in pairs(vitalBones) do
									if bone == BodyPartName then
										TookDamageToVitalOrgan = true
									end
								end
							end
						end
					end
				end

				lastHealth = GetEntityHealth(PlayerPedId())

				local diedOfFatalCause = false

				if lastHealth <= 0 then
					for _, key in pairs(DeathCauses) do
						local causeOfDeath = GetPedCauseOfDeath(PlayerPedId())
						if GetHashKey(key) == causeOfDeath then
							deathCause = key

							if causeOfDeath == GetHashKey("WEAPON_EXPLOSION") or causeOfDeath == GetHashKey("WEAPON_THROWN_DYNAMITE") then
								diedOfFatalCause = true
							else
								if causeOfDeath ~= GetHashKey("WEAPON_UNARMED") and causeOfDeath ~= GetHashKey("WEAPON_FALL") then
									if TookDamageToVitalOrgan then
										diedOfFatalCause = true
									end
								else
									diedOfFatalCause = false
								end
							end
						end
					end

					-- print("diedOfFatalCause", diedOfFatalCause)

					if diedOfFatalCause then
						isBadlyInjuried = false
						-- print("Handle as fatal")
						HandleAsInjured(diedOfFatalCause)
					else
						if not isBadlyInjuried then
							-- print("Handle as not fatal")
							HandleAsInjured(false)
						end
					end
				end
			end			
			-- end
		end
	end
)

RegisterCommand(
	"kys",
	function()
		local pl = Citizen.InvokeNative(0x217E9DC48139933D)
		local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
		Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
	end
)



RegisterNetEvent("FRP:RESPAWN:revive")
AddEventHandler(
	"FRP:RESPAWN:revive",
	function()
		NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
		DestroyAllCams(true)
		DestroyDeathRelatedInformation()
	end
)

RegisterNetEvent("FRP:RESPAWN:Treatment")
AddEventHandler(
	"FRP:RESPAWN:Treatment",
	function()
		cAPI.VaryPlayerHealth(5, 5)
		Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)
		DestroyAllCams(true)
		SetEntityHealth(PlayerPedId(), 150)
		DestroyDeathRelatedInformation()
	end
)

RegisterNetEvent("FRP:RESPAWN:PlayerUp")
AddEventHandler(
	"FRP:RESPAWN:PlayerUp",
	function()
		NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
		DestroyAllCams(true)
		SetEntityHealth(PlayerPedId(), 2)
	end
)

RegisterNetEvent("FRP:RESPAWN:PlayerDead")
AddEventHandler(
	"FRP:RESPAWN:PlayerDead",
	function()
		Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
	end
)

local Locations = {
	[1] = vector3(-285.262, 806.542, 119.576), -- VALENTINE
	[2] = vector3(-1806.069, -426.045, 158.973), -- STRAWBERRY
	[3] = vector3(2725.834, -1224.180, 50.367) -- SAINT DENNIS
}

local prompt_getup
local prompt_respawn
local prompt_giveup
local prompt_group

function HandleAsInjured(fatal)
	local ped = PlayerPedId()

	TookDamageToVitalOrgan = false
	ClearPedLastDamageBone(ped)

	CreateFakeCam()

	-- print('Called HandleAsInjured', fatal)

	TriggerServerEvent("FRP:RESPAWN:SetPlayerAsDead", 1)

	if fatal == true then
		-- print("Died of fatal cause", fatal)

		fullDeathAtGameTime = GetGameTimer() + 1000 * 60 * 10
		-- fullDeathAtGameTime = GetGameTimer() + 1000

		InitiateRespawnPrompt()

		while true do
			Citizen.Wait(0)

			local pedHealth = GetEntityHealth(ped)
			if pedHealth <= 0 then
				Citizen.InvokeNative(0xFA08722A5EA82DA7, "CrossLine01")
				Citizen.InvokeNative(0xFDB74C9CC54C3F37, 1.0)

				local fullDeathTimeDiff = fullDeathAtGameTime - GetGameTimer()

				if fullDeathTimeDiff <= 0 then
					DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.20, 0.08, 0.8, 0, 0, 0, 250, 1)
					DrawTxt("~e~INCONSCIENTE", 0.50, 0.07, 0.8, 0.8, true, 255, 255, 255, 255, true)

					if PromptIsEnabled(prompt_respawn) == 0 then
						PromptSetEnabled(prompt_respawn, true)
					end

					if PromptHasHoldModeCompleted(prompt_respawn) then
						-- print("About to respawn...")

						DestroyDeathRelatedInformation()

						local coords = GetEntityCoords(PlayerPedId())

						local closestIndex
						local lowestDist

						for index, vector in pairs(Locations) do
							local dst = #(vector - coords)
							if lowestDist == nil or dst < lowestDist then
								lowestDist = dst
								closestIndex = index
							end
						end

						TriggerServerEvent("FRP:RESPAWN:SetPlayerAsAliveAndClearInventory")

						DoScreenFadeOut(500)

						local vecSpawnAt = Locations[closestIndex]

						NetworkResurrectLocalPlayer(vecSpawnAt, 59.95, true, true, false)
						SetEntityCoords(ped, vecSpawnAt)

						DoScreenFadeIn(500)

						-- TriggerServerEvent("FRP:Respawn:checkgroup", closestIndex)
						break
					end
				else
					DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.20, 0.15, 0.8, 0, 0, 0, 250, 1)
					DrawTxt("~e~INCONSCIENTE", 0.50, 0.04, 0.8, 0.8, true, 255, 255, 255, 255, true)
					DrawTxt(Config.LocaleTimer, 0.50, 0.095, 0.4, 0.4, true, 255, 255, 255, 255, true)
					DrawTxt("" .. string.format("%.0f", math.max(fullDeathTimeDiff / 1000, 0)), 0.50, 0.12, 0.5, 0.5, true, 255, 255, 255, 255, true)
				end
			else
				--[[
							Nosso player foi revivido, então a gente quebra a
							função toda e segue com a vida
						]]
				-- print("Broke")

				TriggerServerEvent("FRP:RESPAWN:SetPlayerAsDead", 0)

				break
			end			
		end
	else
		isBadlyInjuried = true

		-- print("Died of simple cause")

		local timeTillFirstRevive = GetGameTimer() + 1000 * 60 * 1
		-- timeTillFirstRevive = GetGameTimer() + 1000

		local addedToReviveTime = false

		PlayDice()

		InitiateGetUpPrompt()

		PromptSetEnabled(prompt_getup, false)

		while isBadlyInjuried do
			Citizen.Wait(0)

			local pedHealth = GetEntityHealth(ped)
			if pedHealth <= 0 then
				Citizen.InvokeNative(0xFA08722A5EA82DA7, "CrossLine01")
				Citizen.InvokeNative(0xFDB74C9CC54C3F37, 1.0)

				DisplayHud(false)
				DisplayRadar(false)

				DisableAllControlActions(0)
				DisableAllControlActions(1)
				DisableAllControlActions(2)

				EnableControlAction(0, 0x7F8D09B8, true)
				EnableControlAction(0, 0xDFF812F9, true)

				if addedToReviveTime == false then
					addedToReviveTime = true
					-- timeTillFirstRevive = GetGameTimer() + 1000 * 60 * 1
					timeTillFirstRevive = GetGameTimer() + 1000
				end

				if fakeGameplayCam == nil then
					--[[
								A camera por algum motivo não existe enquanto
								nosso player está morto definitivamente, então a gente
								recria a camera
							]]
					CreateFakeCam()
				end

				if PromptIsEnabled(prompt_giveup) == 1 and PromptHasHoldModeCompleted(prompt_giveup) == 1 then
					isBadlyInjuried = false

					TriggerServerEvent("FRP:RESPAWN:SetPlayerAsDead", 1)

					PromptDelete(prompt_getup)
					PromptDelete(prompt_giveup)

					HandleAsInjured(true)
				end

				if PromptIsEnabled(prompt_getup) and NativePromptHasMashModeCompleted(prompt_getup) then
					--[[
								O player tem o prompt de levantar ativo na tela
								e apertou o prompt por completo
								então a gente levanta ele e diminui a quantidade
								de vezes restantes para levantar
							]]
					PromptSetEnabled(prompt_getup, false)
					PromptSetVisible(prompt_getup, false)

					PromptSetEnabled(prompt_giveup, false)
					PromptSetVisible(prompt_giveup, false)

					-- print("Dice decided you should get up", lastDiceChance)
					NetworkResurrectLocalPlayer(GetEntityCoords(ped), true, true, false)
					SetEntityHealth(ped, 2)

					SetAsDrunk(true)

					addedToReviveTime = false

					timesLeftPlayerCanGetUp = timesLeftPlayerCanGetUp - 1
				else
					local timeTillfirstReviveDiff = timeTillFirstRevive - GetGameTimer()

					if timesLeftPlayerCanGetUp > 0 then
						--[[
									O player morreu novamente por razoes externas
									(não foi pelo nosso sistema de desmaiar novamente)
									então se verifica se o prompt tá ativo, caso nao esteja
								]]
						PromptSetVisible(prompt_getup, true)

						PromptSetVisible(prompt_giveup, true)

						if PromptIsEnabled(prompt_getup) == 0 then
							if timeTillfirstReviveDiff <= 0 then
								PromptSetEnabled(prompt_getup, true)
								PromptSetVisible(prompt_getup, true)

								PromptSetMashWithResistanceMode(prompt_getup, 10, 7.0 - (timesLeftPlayerCanGetUp * 0.75), 0)
								-- PromptSetMashWithResistanceMode(prompt_getup, 10, 1.0, 0)

								PromptSetEnabled(prompt_giveup, true)
								PromptSetVisible(prompt_giveup, true)
							end
						end
					else
						-- print("Chamando HandleAsInjured acabou as chances de levantar")

						isBadlyInjuried = false

						TriggerServerEvent("FRP:RESPAWN:SetPlayerAsDead", 1)

						PromptDelete(prompt_getup)
						PromptDelete(prompt_giveup)

						HandleAsInjured(true)

						break
					end
				end

				-- if fullDeathTimeDiff > 0 then
				--[[
									O player ainda tem varios segundos antes de morrer definitivamente
									então a gente mostra quantos segundos faltam
								]]
				DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.20, 0.08, 0.8, 0, 0, 0, 250, 1)
				DrawTxt("~e~DESMAIADO", 0.50, 0.07, 0.8, 0.8, true, 255, 255, 255, 255, true)
			else
				if fakeGameplayCam ~= nil then
					--[[
								A camera por algum motivo não existe enquanto
								nosso player está desmaiado, então a gente
								recria a camera
							]]
					DestroyFakeCam()
				end

				-- 0.1% de chance do player desmaiar de novo
				if lastDiceChance ~= nil and lastDiceChance <= 1 then
					SetEntityHealth(ped, 0)

					if timesLeftPlayerCanGetUp > 0 then
						-- Player tem mais chances de reviver, reativa os prompts

						PromptSetEnabled(prompt_getup, true)
						PromptSetVisible(prompt_getup, true)

						PromptSetMashWithResistanceMode(prompt_getup, 10, 7.0 - (timesLeftPlayerCanGetUp * 0.75), 0)
						-- PromptSetMashWithResistanceMode(prompt_getup, 10, 1.0, 0)

						PromptSetEnabled(prompt_giveup, true)
						PromptSetVisible(prompt_giveup, true)

						RollDice()
					end
				else
					if pedHealth > 2 then
						--[[
									A vida do player foi aumenteda em quando ele estava machucado
									então ele ousou /revive ou algum remédio
									aceitamos então que ele está vivo e bem

									acaba o thread
								]]
						TriggerServerEvent("FRP:RESPAWN:SetPlayerAsDead", 0)

						isBadlyInjuried = false
						break
					end
				end
			end
		end
	end

	-- print("destroydeathrelated")
	DestroyDeathRelatedInformation()
end

function PlayDice()
	Citizen.CreateThread(
		function()
			while isBadlyInjuried do
				Citizen.Wait(1000)
				RollDice()
			end
		end
	)
end

function RollDice()
	lastDiceChance = math.random(1000)
	-- print("Dice selected", lastDiceChance)
end

function SetAsDrunk(bool)
	local ped = PlayerPedId()
	Citizen.InvokeNative(0x406CCF555B04FAD3, ped, 1, bool and 0.95 or 0.0)
	Citizen.InvokeNative(0xCB9401F918CB0F75, ped, "IsDrunk", bool, -1)
	Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "Drunkness", bool and 0.95 or 0.0, -1)
end

function newDestroy()
	timesLeftPlayerCanGetUp = 2

	isBadlyInjuried = false

	lastDiceChance = nil

	DestroyFakeCam()

	fakeGameplayCamDeg = 0

	PromptDelete(prompt_respawn)
	prompt_respawn = nil

	PromptDelete(prompt_getup)
	prompt_getup = nil

	PromptDelete(prompt_giveup)
	prompt_giveup = nil

	ClearTimecycleModifier()

	DisplayHud(true)
	DisplayRadar(true)

	SetAsDrunk(false)
end

function InitiateRespawnPrompt()
	-- Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Você está morto.")

	if prompt_respawn ~= nil then
		PromptDelete(prompt_respawn)
	end

	prompt_respawn = PromptRegisterBegin()
	-- 0xE8342FF2
	PromptSetControlAction(prompt_respawn, 0x7F8D09B8)
	PromptSetText(prompt_respawn, CreateVarString(10, "LITERAL_STRING", "Renascer"))
	PromptSetStandardMode(prompt_respawn, true)
	PromptSetEnabled(prompt_respawn, false)
	PromptSetVisible(prompt_respawn, 1)
	PromptSetHoldMode(prompt_respawn, 1)
	-- N_0x0c718001b77ca468(prompt, 3.0)
	-- PromptSetGroup(prompt, prompt_group)
	PromptRegisterEnd(prompt_respawn)
end

function InitiateGetUpPrompt()
	if prompt_getup ~= nil then
		PromptDelete(prompt_getup)
	end

	if prompt_giveup ~= nil then
		PromptDelete(prompt_giveup)
	end

	prompt_getup = PromptRegisterBegin()
	-- 0xE8342FF2
	PromptSetControlAction(prompt_getup, 0xDFF812F9)
	PromptSetText(prompt_getup, CreateVarString(10, "LITERAL_STRING", "Levantar"))
	PromptSetStandardMode(prompt_getup, true)
	PromptSetEnabled(prompt_getup, 1)
	PromptSetVisible(prompt_getup, 1)
	PromptSetHoldMode(prompt_getup, 1)

	PromptSetMashWithResistanceMode(prompt_getup, 10, 5.5, 0)
	-- PromptSetMashWithResistanceMode(prompt_getup, 10, 1.0, 0)

	PromptRegisterEnd(prompt_getup)

	prompt_giveup = PromptRegisterBegin()
	PromptSetControlAction(prompt_giveup, 0x7F8D09B8)
	PromptSetText(prompt_giveup, CreateVarString(10, "LITERAL_STRING", "Desistir"))
	PromptSetStandardMode(prompt_giveup, true)
	PromptSetEnabled(prompt_giveup, 1)
	PromptSetVisible(prompt_giveup, 1)
	PromptSetHoldMode(prompt_giveup, 1)
	PromptRegisterEnd(prompt_giveup)

	-- PromptSetMashWithResistanceMode(prompt_getup, 10, 5.5, 0)
	-- -- PromptSetMashWithResistanceMode(prompt_getup, 10, 1.0, 0)
end

function CreateFakeCam()
	DestroyFakeCam()

	local center = GetGameplayCamCoord()
	center = GetEntityCoords(PlayerPedId())

	local xDeg0 = center.x + (5.0 * math.cos(math.rad(fakeGameplayCamDeg)))
	local yDeg0 = center.y + (5.0 * math.sin(math.rad(fakeGameplayCamDeg)))

	-- GetGameplayCamFov()
	fakeGameplayCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", vec3(xDeg0, yDeg0, center.z + 0.7), GetGameplayCamRot(0), 40.0, false, 0) -- CAMERA COORDS
	-- PointCamAtCoord(cam, pPosition)
	PointCamAtEntity(fakeGameplayCam, PlayerPedId(), 0.0, 0.0, 0.0, 0.0)
	SetCamActive(fakeGameplayCam, true)
	RenderScriptCams(true, false, 1, true, true)

	Citizen.CreateThread(
		function()
			while fakeGameplayCam ~= nil do
				Citizen.Wait(0)

				local ped = PlayerPedId()

				local mouseLRnormal = GetDisabledControlNormal(0, 0xA987235F)
				local mouseUDnormal = GetDisabledControlNormal(0, 0xD2047988)

				local mouseNormal = (mouseLRnormal + mouseUDnormal) / 2

				if mouseNormal ~= 0 then
					if mouseNormal > 0.0 then
						-- Right
						local new = fakeGameplayCamDeg + 1.0 -- 0.25
						if new > 360 then
							new = new - 360
						end
						fakeGameplayCamDeg = new
					else
						-- Left
						local new = fakeGameplayCamDeg - 1.0 -- 0.25
						if new < 0 then
							new = 360 + new
						end

						fakeGameplayCamDeg = new
					end
				end

				center = GetEntityCoords(ped)

				-- SKEL_Spine_Root
				-- fem = 11569
				-- male = 11569

				local boneCoords = GetPedBoneCoords(ped, 11569, 0.0, 0.0, 0.0)
				local radius = 5.0

				local z = center.z + 0.7

				local xDeg0 = center.x + (radius * math.cos(math.rad(fakeGameplayCamDeg)))
				local yDeg0 = center.y + (radius * math.sin(math.rad(fakeGameplayCamDeg)))

				local camCoords = vec3(xDeg0, yDeg0, z)

				local shapeTest = StartShapeTestRay(boneCoords, camCoords, -1, ped)
				local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)

				if hit ~= 0 and not IsEntityAPed(entityHit) then
					camCoords = endCoords
				end

				SetCamCoord(fakeGameplayCam, camCoords)
				PointCamAtCoord(fakeGameplayCam, boneCoords)
			end
		end
	)
end

function DestroyFakeCam()
	DestroyCam(fakeGameplayCam, true)
	fakeGameplayCam = nil
end

function NativePromptHasMashModeCompleted(prompt)
	return Citizen.InvokeNative(0x845CE958416DC473, prompt)
end

function NativePromptIsControlActionActive(control)
	return Citizen.InvokeNative(0x1BE19185B8AFE299, control)
end

-- RegisterNetEvent("FRP_respawn:respawnvip")
-- AddEventHandler(
-- 	"FRP_respawn:respawnvip",
-- 	function()
-- 		DestroyDeathRelatedInformation()
-- 		SendNUIMessage(
-- 			{
-- 				type = 1,
-- 				showMap = true
-- 			}
-- 		)
-- 		SetNuiFocus(true, true)
-- 		-- remove all items
-- 		TriggerServerEvent("FRP:Respawn:_Dead")
-- 	end
-- )

RegisterNetEvent("FRP:RESPAWN:CheckDeath")
AddEventHandler(
	"FRP:RESPAWN:CheckDeath",
	function()
		local data = {
			deathCause,
			diedOfFatalCause,
			TookDamageToVitalOrgan,
			BodyPartDamage
		}

		local player, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
			TriggerServerEvent("FRP:MEDIC:StatusDeath", GetPlayerServerId(player), data)
		end
	end
)

-- RegisterNetEvent("FRP_respawn:respawn")
-- AddEventHandler(
-- 	"FRP_respawn:respawn",
-- 	function(spawn)
-- 		DestroyDeathRelatedInformation()
-- 		TriggerServerEvent("FRP:Respawn:_Dead")
-- 		DoScreenFadeOut(500)
-- 		-- print(Locations[spawn])
-- 		NetworkResurrectLocalPlayer(Locations[spawn], 59.95, true, true, false)
-- 		SetEntityCoordsNoOffset(ped, Locations[spawn], false, false, false, true)
-- 		SetEntityCoords(ped, Locations[spawn])

-- 		DoScreenFadeIn(500)
-- 	end
-- )

function DestroyDeathRelatedInformation()
	up = false
	diedOfFatalCause = false
	TookDamageToVitalOrgan = false
	deathCause = nil
	damageBone = {0}
	BodyPartDamage = {
		["cabeça"] = {},
		["pescoço"] = {},
		["coluna"] = {},
		["maoesquerda"] = {},
		["maodireita"] = {},
		["braçodireito"] = {},
		["braçoesquerdo"] = {},
		["pernadireita"] = {},
		["pedireito"] = {},
		["pernaesquerda"] = {},
		["peesquerdo"] = {},
		["genitaria"] = {}
	}
	ClearTimecycleModifier()
	DisplayHud(true)
	DisplayRadar(true)

	-- TriggerServerEvent("FRP:RESPAWN:onPlayerDeath")
	newDestroy()
end

-- RegisterNUICallback(
-- 	"select",
-- 	function(spawn, cb)
-- 		local coords = Config[spawn][math.random(#Config[spawn])]
-- 		local ped = PlayerPedId()
-- 		SetEntityCoords(ped, coords.x, coords.y, coords.z)
-- 		SetNuiFocus(false, false)
-- 		SendNUIMessage(
-- 			{
-- 				type = 1,
-- 				showMap = false
-- 			}
-- 		)
-- 		FreezeEntityPosition(ped, false)
-- 		ShutdownLoadingScreen()
-- 		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 59.95, true, true, false)
-- 		local ped = PlayerPedId()
-- 		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
-- 		ClearPedTasksImmediately(ped)
-- 		ClearPlayerWantedLevel(PlayerId())
-- 		FreezeEntityPosition(ped, false)
-- 		SetPlayerInvincible(PlayerId(), false)
-- 		SetEntityVisible(ped, true)
-- 		SetEntityCollision(ped, true)
-- 		TriggerEvent("playerSpawned", spawn)
-- 		Citizen.InvokeNative(0xF808475FA571D823, true)
-- 		NetworkSetFriendlyFireOption(true)
-- 		TriggerEvent("redemrp_respawn:camera", coords)
-- 	end
-- )

-- RegisterNetEvent("redemrp_respawn:camera")
-- AddEventHandler(
-- 	"redemrp_respawn:camera",
-- 	function(cord)
-- 		DoScreenFadeIn(500)
-- 		local coords = cord
-- 		SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, 0)
-- 		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
-- 		PointCamAtCoord(cam, coords.x, coords.y, coords.z + 200)
-- 		SetCamActive(cam, true)
-- 		RenderScriptCams(true, false, 1, true, true)
-- 		DoScreenFadeIn(500)
-- 		Citizen.Wait(500)
-- 		cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
-- 		PointCamAtCoord(cam3, coords.x, coords.y, coords.z + 200)
-- 		SetCamActiveWithInterp(cam3, cam, 3700, true, true)
-- 		Citizen.Wait(3700)

-- 		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
-- 		PointCamAtCoord(cam2, coords.x, coords.y, coords.z + 2)
-- 		SetCamActiveWithInterp(cam2, cam3, 3700, true, true)
-- 		RenderScriptCams(false, true, 500, true, true)
-- 		Citizen.Wait(500)
-- 		SetCamActive(cam, false)
-- 		DestroyCam(cam, true)
-- 		DestroyCam(cam2, true)
-- 		DestroyCam(cam3, true)
-- 		Citizen.Wait(3000)
-- 	end
-- )

--=============================================================-- DRAW TEXT SECTION--=============================================================--
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
	local str = CreateVarString(10, "LITERAL_STRING", str)
	--Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end
	Citizen.InvokeNative(0xADA9255D, 1)
	DisplayText(str, x, y)
end

AddEventHandler(
	"onResourceStop",
	function(resourceName)
		if resourceName == GetCurrentResourceName() then
			-- if prompt_respawn ~= nil then
			-- 	PromptDelete(prompt_respawn)
			-- 	DestroyCam(fakeGameplayCam, true)
			-- end

			DestroyDeathRelatedInformation()
		end
	end
)

function GetPlayers()
	local players = {}

	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)

		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end
	return players
end

function GetClosestPlayer()
	local players, closestDistance, closestPlayer = GetPlayers(), -1, -1

	local coords, usePlayerPed = coords, false
	local playerPed, playerId = PlayerPedId(), PlayerId()

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end
	for i = 1, #players, 1 do
		local target = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance = #(coords - targetCoords)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end
