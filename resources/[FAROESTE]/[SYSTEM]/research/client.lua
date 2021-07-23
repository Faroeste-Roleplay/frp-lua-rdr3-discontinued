local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

-- // 0x255A5EF65EDA9167
-- BOOL NETWORK_IS_PLAYER_IN_MY_SESSION(int player) // NETWORK_IS_PLAYER_ID_FREE // NETWORK_IS_PLAYER_ID_VALID

-- // 0x5A91BCEF74944E93
-- void NETWORK_ADD_PLAYER_TO_MY_SESSION?

-- PEDSHOT
-- 0x27B1AE4D8C652F08
-- 0xE59F4924BD3A718D

-- 0x8FB7C254CFCBF78E
-- NETWORK_SESSION_SETMATCHMAKING_GROUP?

-- 0xE72E5C1289BD1F40
-- NETWORK_SET_SESSION_PLAYERS? // MATCHMAKING

-- 0xA4484173759749B1
-- NETWORK_CL // NETWORK_FOLLOW_INVITE?

-- 0xA4484173759749B1
-- NETWORK_CLEAR_MY_SESSION?

-- 0x39A8EF7AF29A192C
-- NETWORK_SESSION_OPEN? // NETWORK_SESSION_SETMATCHMAKING

-- // 0xE47001B7CB8B98AE
-- NetworkSendTransitionGamerInstruction

-- RegisterCommand(
-- 	"dig",
-- 	function(source, args, rawCommand)
-- 		local chestModelHash = GetHashKey("P_TRUNK02X")
-- 		chestModelHash = GetHashKey("P_STRONGBOX_MUDDY_01X")
-- 		local lootModelHash = GetHashKey("p_cs_ropehandssplit_sml_2")
-- 		local dressingModelHash = GetHashKey("MP005_P_DRESSINGLBMHAY04X")
-- 		local moundModelHash = GetHashKey("MP005_P_DIRTPILE_BIG01_BURIED")

-- 		RequestModel(chestModelHash)
-- 		RequestModel(lootModelHash)
-- 		RequestModel(dressingModelHash)
-- 		RequestModel(moundModelHash)

-- 		while not HasModelLoaded(dressingModelHash) or not HasModelLoaded(lootModelHash) or not HasModelLoaded(chestModelHash) or not HasModelLoaded(moundModelHash) do
-- 			Wait(0)
-- 		end

-- 		local ped = PlayerPedId()

-- 		local pedPosition = GetOffsetFromEntityInWorldCoords(ped, 2.0, 0.0, 0.0)

-- 		local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(pedPosition.x, pedPosition.y, pedPosition.z)
-- 		pedPosition = vec3(pedPosition.xy, groundZ - 0.05)

-- 		local chest = CreateObjectNoOffset(chestModelHash, pedPosition + vec3(0.0, 0.0, -1.5), true, true, false, true) -- + vec3(-10.0, 0.0, 0.0)
-- 		local loot = CreateObjectNoOffset(lootModelHash, pedPosition, false, true, false, true) -- + vec3(-15.0, 0.0, 0.0)
-- 		local dressing = CreateObjectNoOffset(dressingModelHash, pedPosition, true, true, false, true) -- + vec3(-20.0, 0.0, 0.0)
-- 		local mound = CreateObjectNoOffset(moundModelHash, pedPosition, true, true, false, true) -- + vec3(-10.0, 0.0, 0.0)

-- 		local animscene = CreateAnimScene("script@mech@treasure_hunting@chest", 64, "PBL_CHEST_01", true, true)

-- 		LoadAnimScene(animscene)

-- 		SetAnimSceneOrigin(animscene, pedPosition, 0.0, 0.0, 0.0, 2)
-- 		SetAnimSceneEntity(animscene, "player", ped, 0)
-- 		SetAnimSceneEntity(animscene, "CHEST", chest, 0)
-- 		SetAnimSceneEntity(animscene, "LOOT", loot, 0)
-- 		SetAnimSceneEntity(animscene, "DRESSING", dressing, 0)
-- 		SetAnimSceneEntity(animscene, "MOUND", mound, 0)
-- 		StartAnimScene(animscene)

-- 		Wait(2000)

-- 		Citizen.InvokeNative(0x8245C1F3262F4AC2, animscene)

-- 		TaskEnterAnimScene(ped, animscene, "player", "PBL_CHEST_01", 1069379748, 1, 128, 20000, -1082130432)

-- 		Citizen.CreateThread(function()
-- 			while true do
-- 				Citizen.Wait(0)
-- 				-- local AnimTime = Citizen.InvokeNative(0x61BE7D6186260002, animscene, Citizen.ResultAsFloat())
-- 				-- local hasEnded = Citizen.InvokeNative(0xD8254CB2C586412B, animscene, 0)

-- 				-- if AnimTime >= 5 then
-- 				-- 	ClearPedTasks(ped)
-- 				-- 	ClearPedSecondaryTask(ped)
-- 				-- 	SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
-- 				--	Citizen.InvokeNative(0xD6824B7D24DC0CE0 , animscene, 1)
-- 				-- end

-- 				print("abc", Citizen.InvokeNative(0xE5822422197BBBA3, animscene, "player", 1))

-- 				-- if hasEnded == 1 then
-- 				-- 	Citizen.InvokeNative(0x188F8071F244B9B8, chest, 1) -- SET_RANSACK_AS_OPEN

-- 				-- 	SetEntityAsNoLongerNeeded(chest)
-- 				-- 	SetEntityAsNoLongerNeeded(dressing)
-- 				-- 	SetEntityAsNoLongerNeeded(mound)

-- 				-- 	DeleteEntity(loot)

-- 				-- 	cAPI.notify("item", "gold", 20)

-- 				-- 	break
-- 				-- end
-- 			end
-- 		end)
-- 	end
-- )

RegisterCommand(
	"teste",
	function(source, args, rawCommand)
		-- SetPedConfigFlag(PlayerPedId(), 336, true)
		-- Citizen.InvokeNative(0xC116E6DF68DCE667, 5, 4)
		-- TaskKnockedOut(PlayerPedId(), -1.0, 1)
		-- while true do
		-- 	Wait(0)
		-- 	Citizen.InvokeNative(0x069EDDF1FD4DEB0A, GetMount(PlayerPedId()), 0.1)
		-- 	Citizen.InvokeNative(0x069EDDF1FD4DEB0A, PlayerPedId(), 0.1)
		-- end
		-- Citizen.InvokeNative(0x5240864E847C691C, PlayerPedId(), true)
		-- Citizen.InvokeNative(0xD67B6F3BCF81BA47, PlayerPedId(), 16383)
		-- Citizen.InvokeNative(0x39ED303390DDEAC7, PlayerPedId(), 1, -1, -1, 75)
		-- ON_HORSE_SPEED_RESTRICTION_WALK
		-- Global_1140484->f_2001
		-- local e = 2901841
		-- SetPedConfigFlag(e, 169, true); -- // GRAPPLE_IMMUNITY_FROM_PLAYERS
		-- SetPedConfigFlag(e, 170, true); -- // GRAPPLE_IMMUNITY_FROM_AI
		-- SetPedConfigFlag(ped, 547, true); // CANNOT_LOCK_ON_PLAYERS
		-- SetPedConfigFlag(ped, 339, true); // FATAL_MELEE_IMMUNITY
		-- SetPedConfigFlag(ped, 340, true); // FATAL_MELEE_IMMUNITY
		-- SetPedConfigFlag(ped, 265, true); // DISABLE_DROWNING
		-- SetPedConfigFlag(e, 263, true); -- HEADSHOT_IMMUNITY
		-- SetPedConfigFlag(e, 556, true); -- FULL_LOCKON_IMMUNITY
		-- PLAYER::_0x7146CF430965927C(1, true); // HAT_BLOCKS_HEADSHOT
		-- PLAYER::_0x7146CF430965927C(26, true); // NO_CRITICAL_DAMAGE_AGAINST_PLAYERS
		-- // 0xFC79DCC94D0A5897
		-- void _SET_PLAYER_WEAPON_GROUP_DAMAGE_MODIFIER
		-- local propHash = GetHashKey("S_CAMPLEDGER01X")
		-- s_burdock01x
		-- P_MONEYSTACK01X
		-- if not HasModelLoaded(propHash) then
		-- 	RequestModel(propHash)
		-- 	while not HasModelLoaded(propHash) do
		-- 		Citizen.Wait(0)
		-- 	end
		-- end
		-- local playerPed = PlayerPedId()
		
		-- func_744
		-- 2687.582, -1362.665, 55.639
		-- local z = GetNamedRendertargetRenderId(nameRender)
		-- SetTextRenderId(z)
		-- print(z)
		-- local a = Citizen.InvokeNative(0x6F3068258A499E52, propHash, GetEntityCoords(playerPed), 7)
		-- print(a)
		-- while not Citizen.InvokeNative(0x1FF441D7954F8709, a) do
		-- 	Citizen.Wait(0)
		-- end
		-- local b = Citizen.InvokeNative(0x4735E2A4BB83D9DA, a)
		-- print(b)
		-- Citizen.InvokeNative(0xF49574E2332A8F06, b, 0.0)
		-- Citizen.InvokeNative(0x04D1D4E411CE52D0, b, z)
		-- 

		-- Wait(5000)
		-- local animDict = "mech_pickup@plant@burdock"
		-- animDict = "script_common@handover@generic@player_handover@money"
		-- animDict = "mech_loco_f@generic@emotion@unarmed@intimidated@on_ass@offering@normal_items"
		-- RequestAnimDict(animDict)
		-- while not HasAnimDictLoaded(animDict) do
		-- 	Citizen.Wait(0)
		-- end
		-- SetAnimScenePlaybackList(animScene, "PBL_FLIP_L1", true)
		-- TaskPlayAnim(PlayerPedId(), animDict, "throw_object_left_pocket", 8.0, -8.0, -1, 31, 0.0, false, 0, false, 0, false)
		-- PlayEntityAnim(prop, "stn_pick_long_pick_root_1", animDict, 1000.0, false, true, false, 0.0, 0)
		-- TaskPlayAnim(prop, animDict, , 8.0, -8.0, -1, 0, 0.0, false, 0, false, 0, false)
		-- TaskPlayAnim(playerPed, animDict, "stn_pick_long_pick", 8.0, -8.0, -1, 66048, 0.0, false, 0, false, 0, false)
		--"mech_pickup@loot_body@face_up@loot@base"
		-- -- mini_games@fishing@shore@hooked_med@struggle
		-- -- struggle_pullup
		-- -- struggle_a
		-- -- script_re@treasure_hunter
		-- -- breakout
		-- ClearPedTasks(playerPed, 0, 1)
		-- -- TaskPlayAnim(8597250, animDict, "pick_lh_ped", 8.0, -8.0, -1, 32, 0.0, false, 0, false, 0, false)
		-- local t = 6841916
		-- ResurrectPed(t)
		-- Wait(100)
		-- local c, r = GetEntityCoords(t), GetEntityRotation(t)
		-- TaskPlayAnimAdvanced(playerPed, animDict, "pick_lh", c, r, 8.0, -8.0, -1, 32, 0.0, false, 0, false, 0, false)
		-- TaskPlayAnimAdvanced(t, animDict, "pick_lh_ped", c, r, 8.0, -8.0, -1, 34, 0.0, false, 0, false, 0, false)
		-- Wait(2000)
		-- SetEntityHealth(t, 0)
		-- RequestModel(GetHashKey("A_C_DEER_01"))
		-- -- Wait(1000)
		-- local h = Citizen.InvokeNative(0xF97C34C33487D569, GetHashKey("A_C_DEER_01"), 1)
		-- print(h)
		-- Wait(2000)
		-- local v = Citizen.InvokeNative(0x43E4DA469541A9C9, h)
		-- print(v)
		-- local r = Citizen.InvokeNative(0xC0940AC858C1E126, h)
		-- print(r)
		-- local a = Citizen.InvokeNative(0x0BCD4091C8EABA42, h, GetEntityCoords(PlayerPedId()), 290.0415, 0, 0, 0, 1, true)
		-- print(a)
		-- Citizen.InvokeNative(0x1902C4CFCC5BE57C, a, GetHashKey("META_OUTFIT_COLD_WEATHER"))
		-- print(Citizen.InvokeNative(0x3972F78A78B5D9DF, h))
		-- 		// 0xF97C34C33487D569
		-- Request
		-- // 0x43E4DA469541A9C9
		-- IsValid
		-- // 0xC0940AC858C1E126
		-- IsReady
		-- // 0x3972F78A78B5D9DF
		-- Release
		-- Citizen.InvokeNative(0x644CCB76A76CFBD6, 0, 0, 0, 0, 0, 0)
		-- Citizen.InvokeNative(0x83B8D50EB9446BBA, PlayerPedId(), 1)
		-- print(Citizen.InvokeNative(0xE80E50BEE276A54A, 1412640604, -2047978619))
		-- // 0xE3A46370F70F3607
		-- INVENTORY_HIDE_INVENTORY_INDEX(int index, Any p1)
		-- /*
		-- When index is 1 it hides the weapon wheel completly
		-- */
		-- -- Citizen.InvokeNative(0xE3A46370F70F3607, 1, 0)
		-- // 0xD5D72F1624F3BA7C
		-- INVENTORY_SHOW_INVENTORY_INDEX(int index)
		-- // 0xF49F14462F0AE27C
		-- Ped _GET_MO*(Player player)
		-- // 0xE6D4E435B56D5BD0
		-- void _SET_PLAYER_MO*(Player player, Ped mount)
		-- /*
		-- Enables horse's equipment prompt when near it
		-- */
		-- Citizen.InvokeNative(0xD5D72F1624F3BA7C, 1)
		-- Citizen.InvokeNative(0xBA8818212633500A, 6528527, 6, 0)
		-- Citizen.InvokeNative(0xBA8818212633500A, 6528527, 3, 0)
		-- print(Citizen.InvokeNative(0xF49F14462F0AE27C, PlayerId()))
		-- Citizen.InvokeNative(0xE6D4E435B56D5BD0, PlayerId(), 392223)
		-- INVENTORY::_0x2BAE4880DCDD560B(iVar0, 0))
		-- exports["research"]:N_0x04019AE4956D4393()
		-- SetObjectTextureVariation(5765379, 5)
		-- Citizen.InvokeNative(0xB35370D5353995CB,PlayerPedId(), GetHashKey("MP_MOONSHINE_DRINKING_SOBER_TABLE_LH_HOLD"), 1048576000)
		-- local comp = GetHashKey("COMPOSITE_LOOTABLE_VULTURE_EGG_DEF")
		-- Citizen.InvokeNative(0x73F0D0327BFA0812, comp)
		-- while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, comp) do
		-- 	Citizen.Wait(10)
		-- end
		-- Citizen.InvokeNative(0x7563CBCA99253D1A, PlayerId(), GetHashKey("BLIP_MP_ROLE_COLLECTOR_ILO"))
		-- Citizen.InvokeNative(0x62ED71E133B6C9F1, PlayerId(), 255, 255, 0)
		-- exports['research']:DataViewNetowrk(comp)
		-- local w = Citizen.InvokeNative(0x5B4BBE80AD5972DC, comp, GetEntityCoords(PlayerPedId()), 0.0, 0, 0, -1)
		-- print(w)
		-- Citizen.InvokeNative(0xE72E5C1289BD1F40, 1, 0)
		-- Citizen.InvokeNative(0x309BBEBEA8A3986C, 1, 0)
		-- NETWORK::_0x : l128
		-- local networkHandle = NetworkHandleFromPlayer(PlayerPedId())
		-- print(networkHandle)
		-- local isPlayerIdValid = Citizen.InvokeNative(0x255A5EF65EDA9167, 31)
		-- print(PlayerId(), isPlayerIdValid)
		-- Citizen.InvokeNative(0xFD4272A137703449)
		-- print(NetworkGetPlayerIndex(player))
		-- Citizen.InvokeNative(0x5A91BCEF74944E93, PlayerId(), 30.0)
		-- Citizen.InvokeNative(0x51951DE06C0D1C40, PlayerId(), 1)
		-- Citizen.InvokeNative(0xA4484173759749B1)
		-- print(NetworkIsSessionActive())
		--
		-- 	Global_1572887->f_342.f_4 = 4;
		-- Global_1572887->f_342.f_21 = iParam0; // 1,
		-- Global_1572887->f_342.f_5 = 18;                   -- IS_PRIVATE
		-- Global_1572887->f_342.f_6 = 0;
		-- Global_1572887->f_342.f_25 = 0;
		-- Global_1572887->f_342.f_26 = 0;
	end
)

RegisterNetEvent("FRP:EVENTS:PedFinishedGatheringEntity")
RegisterNetEvent("FRP:EVENTS:PedWhistle")
RegisterNetEvent("FRP:EVENTS:PedInteractionRansackScenario")

-- RegisterCommand(
-- 	"ye",
-- 	function()
-- 		print(Citizen.InvokeNative(0x13D234A2A3F66E63, PlayerPedId()))
-- 	end,
-- 	false
-- )

Citizen.CreateThread(
	function()
		-- print("PLAYERPED: " .. PlayerPedId())

		-- print(" ")

		-- local obj = CreateObject("p_cs_woodPile01x", GetEntityCoords(PlayerPedId()), 1, 1, 1)

		-- Citizen.InvokeNative(0xF0B4F759F35CC7F5, obj, GetHashKey("FIREWOOD"), 0, 0, 0)
		-- Citizen.InvokeNative(0x18FF3110CF47115D, obj, 2, true)
		-- Citizen.InvokeNative(0x18FF3110CF47115D, obj, 4, true)

		-- INDEX 1: WEAPON_WEEL

		-- ! INVENTORY::_0x

		-- // 0x6A564540FAC12211
		-- * void _INVENTORY_ENABLE_ITEM_FOR_INVENTORY_INDEX(int index, Hash item)
		-- ? Indices:
		-- ? 1: Weapon Wheel

		-- // 0x766315A564594401
		-- * void _INVENTORY_DISABLE_ITEM_FOR_INVENTORY_INDEX(int index, Hash item, BOOL p2)

		-- for i = 0, 5 do
		-- Citizen.InvokeNative(0x6A564540FAC12211, i, GetHashKey("WEAPON_PISTOL_VOLCANIC")) -- ENABLE_WEAPON
		-- Citizen.InvokeNative(0x766315A564594401, i, GetHashKey("WEAPON_PISTOL_VOLCANIC"), 0) -- DISABLE_WEAPON
		-- print(Citizen.InvokeNative(0xE787F05DFC977BDE, i, GetHashKey("UPGRADE_OFFHAND_HOLSTER"), 0))
		-- end

		-- GiveWeaponToPed_2(PlayerPedId(), GetHashKey("WEAPON_REVOLVER_CATTLEMAN_DUALWIELD"), 100, false, true, GetWeapontypeGroup(GetHashKey("WEAPON_REVOLVER_CATTLEMAN_DUALWIELD")), true, 0.5, 1.0, 0, true, 0, 0)
		-- Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey("WEAPON_REVOLVER_CATTLEMAN_DUALWIELD"), 0, false, true)
		-- Citizen.InvokeNative(0x5FD1E1F011E76D7E, PlayerPedId(), GetPedAmmoTypeFromWeapon(PlayerPedId(), GetHashKey("WEAPON_REVOLVER_CATTLEMAN_DUALWIELD")), 100)

		-- print(Citizen.InvokeNative(0x13D234A2A3F66E63, PlayerPedId())) -- Return current inventory index?

		-- CONSUMABLE_MEDICINE

		-- ! func_916 : cash_balance
		-- ! func_516 : get_item_fillout_info

		-- * _ITEM_DATABASE_FILLOUT_ITEM_INFO
		-- ? f_1: slot_id
		-- ? f_2: item_type [CLOTHING, HORSE, WEAPON_MOD, WEAPON, WEAPON_DECORATION, ...]
		-- ? f_4: world_model

		-- 0xE9BD19F8121ADE3E

		-- local lastMount = Citizen.InvokeNative(0x4C8B59171957BCF7, PlayerPedId()) -- lastmount
		-- SetEntityHealth(lastMount, 0)

		-- print(Citizen.InvokeNative(0x13D234A2A3F66E63, lastMount)) -- GET_INVENTORY_ID_FOR_ENTITY?

		while true do
			Citizen.Wait(0)

			-- DrawText("VOZ : Faliteando", 0.5, 0.5, 0.25, 0.25, false, 252, 240, 192, 145, 0, 7)

			local size = GetNumberOfEvents(0)

			-- print(Citizen.InvokeNative(0x13D234A2A3F66E63, PlayerPedId()))

			if size > 0 then
				for i = 0, size - 1 do
					local eventAtIndex = GetEventAtIndex(0, i)

					-- if eventAtIndex ~= 1626561060 and eventAtIndex ~= 735942751 then
					-- print(eventAtIndex)
					-- end

					if eventAtIndex == 1327216456 then
						-- [bit 0] = Ped who is whistling
						-- print("EVENT_PED_WHISTLE", PlayerPedId(), i)
						-- exports["frp_admin"]:js_teste_native(0, i, 2)

						local view = exports["research"]:DataViewNativeGetEventData(0, i, 2)
						TriggerEvent("FRP:EVENTS:PedWhistle", view["0"], view["2"])
					elseif eventAtIndex == GetHashKey("EVENT_PLAYER_PROMPT_TRIGGERED") then
						local view = exports["research"]:DataViewNativeGetEventData(0, i, 10)

						local promptType = view["0"]
						local interactedEntity = view["4"]

						if promptType == 33 then -- Horse Flee (Mandar Fugir)
							TaskAnimalFlee(interactedEntity, PlayerPedId(), -1)
						end
					elseif eventAtIndex == -1246119244 then
						-- [bit 0] Ped -- Mostly the animal being interacted
						-- [bit 2] Ped -- Mostly the one who is interacting
						-- [bit 4] Interaction
						-- print(GetHashKey("INTERACTION_POSITIVELONG"), GetHashKey("INTERACTION_POSITIVESHORT"), GetHashKey("INTERACTION_CANCEL"), GetHashKey("INTERACTION_COMPLETE"))
						-- print("EVENT_PED_ANIMAL_INTERACTION", PlayerPedId(), i)
						-- exports["frp_admin"]:js_teste_native(0, i, 3)
						-- exports["research"]:DataViewNativeGetEventData(0, i, 3)
					elseif eventAtIndex == -2091944374 then
						-- 24 Player
						-- 25 Lotter
						-- print("EVENT_PLAYER_LOOT_PED")
						-- exports["frp_admin"]:js_teste_native(0, i, 26)
						-- exports["research"]:DataViewNativeGetEventData(0, i, 26)
					elseif eventAtIndex == -1511724297 then
						-- exports["frp_admin"]:js_teste_native(0, i, 36)
						-- print("EVENT_PLAYER_LOOT_?")
					elseif eventAtIndex == 1352063587 then
						local view = exports["research"]:DataViewNativeGetEventData(0, i, 4)
						local pedInteracting = view["0"]
						local containerEntity = view["2"]
						local containerScenario = view["4"]
						local isClosing = view["6"]
						TriggerEvent("FRP:EVENTS:PedInteractionRansackScenario", pedInteracting, containerEntity, containerScenario, isClosing)
					elseif eventAtIndex == 1208357138 then
						-- local carriableEntity = view["0"]
						-- local pedCarrier
						-- print("EVENT | Carriable state change / Carriable carrier changes?")
						-- exports["research"]:DataViewNativeGetEventData(0, i, 5)
					elseif eventAtIndex == -687266558 then
						-- index\bitIndex
						-- 1\0: Entity
						-- 3\3: Entity
						-- print("EVENT | PED_STARTS_CARRYING")
						-- exports["research"]:DataViewNativeGetEventData(0, i, 4)
					elseif eventAtIndex == 1376140891 then
						-- 1\0: Entity/Ped/Player Ped
						-- 2\2: Entity/Ped carriable
						-- 3\3: BOOL, used to determine theft?
						--[[

						]]
						-- print("EVENT | PED_FINISHED_GATHERING_PED *totally not real name*")
						local view = exports["research"]:DataViewNativeGetEventData(0, i, 3)
						local ped = view["0"]
						local entity = view["2"]
						local bool_unk = view["4"]

						-- print(ped, entity, bool_unk, IsEntityAPed(entity))
						-- print(GetEntityModel(entity))

						TriggerEvent("FRP:EVENTS:PedFinishedGatheringEntity", ped, entity, bool_unk)
					elseif eventAtIndex == 218595333 then
					-- print("Horse broken")
					end

					-- if eventAtIndex == 2099179610 then
					-- 	print("EVENT | Has looteable nearby?")
					-- 	exports["research"]:DataViewNativeGetEventData(0, i, 2)
					-- end
				end
			end

			-- size = GetNumberOfEvents(2)

			-- if size > 0 then
			-- 	for i = 0, size - 1 do
			-- 		local eventAtIndex = GetEventAtIndex(2, i)
			-- 		-- if eventAtIndex == -45008988 then
			-- 		-- 	print("enter")
			-- 		-- end
			-- 		if eventAtIndex == -456923784 then
			-- 			print("openchest / left scenario")
			-- 			-- bit 1 scenarioid/type
			-- 			-- bit2 ped
			-- 			SetEventFlagForDeletion(2, i, 1)
			-- 		-- exports["frp_admin"]:js_teste_native(2, i, 2)
			-- 		end
			-- 		if eventAtIndex == -843555838 then
			-- 			print("wha")
			-- 		end
			-- 	end
			-- end
		end
	end
)

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end
	Citizen.InvokeNative(0xADA9255D, font)
	DisplayText(CreateVarString(8, 220200945, GetLabelTextByHash(GetHashKey("CONSUMABLE_AGED_PIRATE_RUM"))), x, y)
end

function drawcircle()
	local center = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 15.0, 0.0)

	local r = 10.0

	local Cx = center.x
	local Cy = center.y
	local z = center.z

	X_deg0 = Cx + (r * math.cos(0))
	Y_deg0 = Cy + (r * math.sin(0))

	-- Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF,GetEntityCoords(PlayerPedId()), center, 255, 0, 0, 255)

	for i = 0, 360, 45 do
		i = math.rad(i)
		local X_deg0 = Cx + (r * math.cos(i))
		local Y_deg0 = Cy + (r * math.sin(i))

		local Vec = vec3(X_deg0, Y_deg0, z)

		-- local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(camVec.x, camVec.y, camVec.z)

		-- if math.abs(z - groundZ) < minHeightAboveGround then
		-- 	Vec = vec3(Vec)
		-- end

		Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, center, Vec, 255, 0, 0, 255)
	end
end

function HasAnimStartedPlaying(animDict, animName, timeout)
	local ped = PlayerPedId()
	timeout = timeout * 1000

	while not IsEntityPlayingAnim(ped, animDict, animName, 1) do
		Citizen.Wait(0)
		timeout = timeout - 1

		if timeout <= 0 then
			return false
		end
	end

	return true
end

function HasAnimStoppedPlaying(animDict, anim)
	local ped = PlayerPedId()

	while IsEntityPlayingAnim(ped, animDict, animName, 1) do
		Citizen.Wait(0)
	end

	return true
end

-- 0x14169FA823679E41

-- ? // 0xD04241BBF6D03A5E
-- ? Scenario _GET_SCENARIO_POINT_*

-- ? // _0x345EC3B7EBDE1CB5
-- ? int _GET_SCENARIO_POINT_CLOSE_TO_COORDS(float posX, float posY, float posZ, float ?radius, int p4)

-- // 0xDF7993356F52359A
-- int _GET_SCENARIO_POINT_PED_IS_USING(Ped ped, BOOL prompt_grip)

-- ? // 0x6718F40313A2B5A6
-- ? float _GET_SCENARIO_POINT_PHASE(int scenario)

-- // 0xA92450B5AE687AAF
-- Hash GET_SCENARIO_POINT_TYPE(int scenario)

-- // 0x2D0571BB55879DA2
-- int _GET_SCENARIO_POINT_TYPE_PED_IS_USING(Ped)

-- // 0x19A6BE7D9C6884D3
-- BOOL _REQUEST_SCENARIO_TYPE(Hash scenarioType)

-- // 0x9427C94D2E4094A4
-- BOOL _HAS_SCENARIO_TYPE_LOADED(Hash scenarioType)

-- 0xCE285A4413B00B7F
-- UNLOCK::_UNLOCK_SET_UNLOCKED(joaat("SP_WEAPON_DUALWIELD"), true);
-- UNLOCK::_UNLOCK_SET_VISIBLE(joaat("SP_WEAPON_DUALWIELD"), true);

-- // 0x6BCF5F3D8FFE988D
-- void _SET_IS_LOOTED(Entity, BOOL)
-- SET_ENTITY_GATHERED

-- // 0x8DE41E9902E85756
-- BOOL _GET_IS_LOOTED(Entity)
-- _IS_ENTITY_GATHERED

-- // 0xDACE03C65C6666DB
-- void _SET_0x6CFC373008A1EDAF -- related
-- void _SET_PED_CORPSE_*
-- ROTTEN?

-- // 0x90403E8107B60E81
-- int  GET_NUM_COMPONENTS_IN_ENTITY
-- // 0x77BA37622E22023B
-- Hash GET_PED_COMPONENT_AT_INDEX

-- SKINNING_DAMAGE_POOR_QUALITY_LEGENDARY

-- ["mini_games@fishing@shore"] = {
-- 	"caught_fish_no_reel_lt",
-- 	"caught_fish_sml_resist_lt",
-- 	"caught_fish_sml_resist",
-- 	"base_reel_2_reel_in_fast",
-- 	"caught_fish_med_no_reel_lt",
-- 	"caught_fish_med_no_reel_rt",
-- 	"caught_fish_sml_no_reel_rt",
-- 	"caught_fish_sml_no_reel_lt",
-- 	"caught_fish_med_resist",
-- 	"player_idle_2_base_2h",
-- 	"caught_fish_med_resist_lt",
-- 	"caught_fish_no_reel_rt",
-- 	"caught_fish_sml_no_reel",
-- 	"reel_in_fast_2_base_2h",
-- 	"caught_fish_lrg_no_reel",
-- 	"caught_fish_lrg_no_reel_lt",
-- 	"caught_fish_med_resist_rt",
-- 	"caught_fish_lrg_no_reel_rt",
-- 	"caught_fish_lrg_resist",
-- 	"caught_fish_lrg_resist_lt",
-- 	"caught_fish_lrg_resist_rt",
-- 	"unhook_fish_med_enter",
-- 	"unhook_fish_med_enter_fish",
-- 	"unhook_fish_med_hold_dead",
-- 	"caught_fish_sml_resist_rt",
-- 	"unhook_fish_med_hold_dead_fish",
-- 	"unhook_fish_med_hold_fish",
-- 	"base_2h_2_player_idle",
-- 	"unhook_fish_med_keep_fish",
-- 	"unhook_fish_med_release",
-- 	"unhook_fish_med_release_fish",
-- 	"caught_fish_med_no_reel",
-- 	"caught_fish_sml",
-- 	"rh_hold",
-- 	"caught_fish_sml_lt",
-- 	"idle_turn_r_0",
-- 	"uh_cast_action_short",
-- 	"caught_fish_sml_pole",
-- 	"uh_cast_exit",
-- 	"idle_turn_r_90",
-- 	"caught_fish_sml_rt",
-- 	"uh_cast_idle",
-- 	"line_snapped",
-- 	"caught_line_a",
-- 	"caught_line_b",
-- 	"uh_cast_intro",
-- 	"equip_clps",
-- 	"unequip_clps",
-- 	"bait_hook",
-- 	"bait_hook_alt",
-- 	"base_2h",
-- 	"base_2h_idle_a",
-- 	"line_snapped_lt",
-- 	"base_2h_idle_b",
-- 	"base_2h_idle_c",
-- 	"base_2h_idle_d",
-- 	"base_2h_idle_e",
-- 	"base_2h_idle_f",
-- 	"base_2h_idle_g",
-- 	"base_2h_idle_h",
-- 	"base_2h_idle_i",
-- 	"base_reel",
-- 	"unhook_fish",
-- 	"base_reel_flick",
-- 	"line_snapped_rt",
-- 	"base_reel_flick_lt",
-- 	"base_reel_flick_rt",
-- 	"base_reel_idle_a",
-- 	"base_reel_idle_b",
-- 	"base_reel_idle_c",
-- 	"base_reel_idle_d",
-- 	"base_reel_idle_e",
-- 	"base_reel_idle_f",
-- 	"lt_hold",
-- 	"hooked_fish_lrg",
-- 	"base_reel_idle_g",
-- 	"unhook_fish_bobber",
-- 	"base_reel_idle_h",
-- 	"missed_bite",
-- 	"unhook_fish_cam",
-- 	"base_reel_idle_i",
-- 	"unhook_fish_fish",
-- 	"base_reel_lt",
-- 	"base_reel_rt",
-- 	"hooked_fish_lrg_lt",
-- 	"cast_action",
-- 	"cast_action_short",
-- 	"missed_strike",
-- 	"cast_exit",
-- 	"hooked_fish_lrg_rt",
-- 	"cast_idle",
-- 	"no_hook_fish",
-- 	"cast_idle_turn_l_0",
-- 	"cast_idle_turn_r_0",
-- 	"hooked_fish_med",
-- 	"cast_intro",
-- 	"cast_pole",
-- 	"unhook_fish_med_hold",
-- 	"caught_fish_lrg",
-- 	"hooked_fish_med_lt",
-- 	"caught_fish_lrg_lt",
-- 	"reel_in",
-- 	"reel_in_fast",
-- 	"hooked_fish_med_rt",
-- 	"caught_fish_lrg_rt",
-- 	"hooked_fish_sml",
-- 	"caught_fish_med",
-- 	"unhook_fish_med_keep",
-- 	"caught_fish_med_lt",
-- 	"hooked_fish_sml_lt",
-- 	"hooked_fish_sml_rt",
-- 	"reel_in_lt",
-- 	"caught_fish_med_pole",
-- 	"idle_turn_l_-90",
-- 	"reel_in_rt",
-- 	"caught_fish_med_rt",
-- 	"caught_fish_no_reel",
-- 	"idle_turn_l_0",
-- 	"reel_in_up",
-- 	"cast",
-- },
