local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = {}
Tunnel.bindInterface("API", cAPI)
Proxy.addInterface("API", cAPI)

initializedPlayer = false

AddEventHandler(
	"playerSpawned",
	function()
		TriggerServerEvent("pre_playerSpawned")
	end
)

AddEventHandler(
	"onClientMapStart",
	function()
		print("client map initialized")
		-- exports.spawnmanager:setAutoSpawn(true)
		-- exports.spawnmanager:forceRespawn()
	end
)

AddEventHandler(
	"onResourceStart",
	function(resourceName)
		--	SetMinimapHideFow(true) -- remove

		if (GetCurrentResourceName() ~= resourceName) then
			return
		end

		TriggerServerEvent("API:addReconnectPlayer")
	end
)

-- Citizen.CreateThread(
-- 	function()
-- 		Citizen.InvokeNative(0x63E7279D04160477, true)
-- 		Citizen.InvokeNative("0x1E5B70E53DB661E5", 1122662550, 347053089, 0, "Faroeste", "Roleplay", "Bem-vindo!")
-- 	end
-- )

Citizen.CreateThread(
	function()

		-- N_0xa657ec9dbc6cc900(1)
		-- Citizen.InvokeNative(0x74E2261D2A66849A, 1)
		-- Citizen.InvokeNative(0xE8770EE02AEE45C2, 1)

		while true do
			Citizen.Wait(0)
			Citizen.InvokeNative(0xF808475FA571D823, true) --enable friendly fire
			NetworkSetFriendlyFireOption(true)

			SetRelationshipBetweenGroups(5, "PLAYER", "PLAYER")
			SetRelationshipBetweenGroups(5, "PLAYER", "GANG_NIGHT_FOLK" )
			SetRelationshipBetweenGroups(5, "GANG_NIGHT_FOLK", "PLAYER" )
			local ped = PlayerPedId()

			if IsPedOnMount(ped) or IsPedInAnyVehicle(ped, false) then
				SetRelationshipBetweenGroups(1, "PLAYER", "PLAYER")
				Citizen.Wait(2000)
			elseif IsPedGettingIntoAVehicle(ped) or Citizen.InvokeNative(0x95CBC65780DE7EB1, ped, false) then
				SetRelationshipBetweenGroups(1, "PLAYER", "PLAYER")
				Citizen.Wait(3500)
			else
				SetRelationshipBetweenGroups(5, "PLAYER", "PLAYER")
			end

			DisableControlAction(0, 0x580C4473, true) -- hud disable
			DisableControlAction(0, 0xCF8A4ECA, true) -- hud disable

			--	DisableControlAction(0, 0xE2B557A3, true) -- emote wheel
			--	DisableControlAction(0, 0x8B3FA65E, true) -- emote wheel horse

			-- DisableControlAction(0, 0x41AC83D1, true) -- loot
			DisableControlAction(0, 0x399C6619, true) -- loot 2
			-- DisableControlAction(0, 0x27D1C284, false) -- loot 3
			-- DisableControlAction(0, 0x14DB6C5E, true) -- loot vehicle
			-- DisableControlAction(0, 0xC23D7B9E, false) -- loot ammo
			DisableControlAction(0, 0xFF8109D8, true) -- loot Alive
			--   DisableControlAction(0, 0xD2CC4644, true) -- soltar corda
			DisableControlAction(0, 0x6E9734E8, true) -- DESATIVAR DESISTIR
			DisableControlAction(0, 0x295175BF, true) -- DESATIVAR SOLTAR DA CORDA
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(30000)
			if cAPI.IsPlayerInitialized() then
				local playerPed = PlayerPedId()
				if playerPed and playerPed ~= -1 then
					local x, y, z = table.unpack(GetEntityCoords(playerPed))
					x = tonumber(string.format("%.3f", x))
					y = tonumber(string.format("%.3f", y))
					z = tonumber(string.format("%.3f", z))

					local pHealth = GetEntityHealth(playerPed)
					local pStamina = tonumber(string.format("%.2f", Citizen.InvokeNative(0x775A1CA7893AA8B5, playerPed, Citizen.ResultAsFloat())))
					local pHealthCore = Citizen.InvokeNative(0x36731AC041289BB1 , playerPed, 0, Citizen.ResultAsInteger())
					local pStaminaCore = Citizen.InvokeNative(0x36731AC041289BB1 , playerPed, 1, Citizen.ResultAsInteger())

					TriggerServerEvent("FRP:CacheCharacterStats", {x, y, z}, pHealth, pStamina, pHealthCore, pStaminaCore)
				end
			end
		end
	end
)

function cAPI.getPosition()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	return x, y, z
end

-- return vx,vy,vz
function cAPI.getSpeed()
	local vx, vy, vz = table.unpack(GetEntityVelocity(PlayerPedId()))
	return math.sqrt(vx * vx + vy * vy + vz * vz)
end

function cAPI.GetCoordsFromCam(distance)
	local rot = GetGameplayCamRot(2)
	local coord = GetGameplayCamCoord()

	local tZ = rot.z * 0.0174532924
	local tX = rot.x * 0.0174532924
	local num = math.abs(math.cos(tX))

	newCoordX = coord.x + (-math.sin(tZ)) * (num + distance)
	newCoordY = coord.y + (math.cos(tZ)) * (num + distance)
	newCoordZ = coord.z + (math.sin(tX) * 8.0)
	return newCoordX, newCoordY, newCoordZ
end

function cAPI.Target(Distance, Ped)
	local Entity = nil
	local camCoords = GetGameplayCamCoord()
	local farCoordsX, farCoordsY, farCoordsZ = cAPI.GetCoordsFromCam(Distance)
	local RayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, farCoordsX, farCoordsY, farCoordsZ, -1, Ped, 0)
	local A, B, C, D, Entity = GetShapeTestResult(RayHandle)
	return Entity, farCoordsX, farCoordsY, farCoordsZ
end

-- function cAPI.getNearestPlayers(radius)
-- 	local r = {}
-- 	local ped = PlayerPedId()
-- 	local pid = PlayerId()
-- 	local pCoords = GetEntityCoords(ped)

-- 	for _, v in pairs(GetActivePlayers()) do
-- 		local player = GetPlayerFromServerId(v)
-- 		local pPed = GetPlayerPed(player)
-- 		local pPCoords = GetEntityCoords(pPed)
-- 		local distance = #(pCoords - pPCoords)
-- 		if distance <= radius then
-- 			r[GetPlayerServerId(player)] = distance
-- 		end
-- 	end
-- 	return r
-- end

-- function cAPI.getNearestPlayer(radius)
-- 	local p = nil
-- 	local players = cAPI.getNearestPlayers(radius)
-- 	local min = radius + 10.0
-- 	for k, v in pairs(players) do
-- 		if v < min then
-- 			min = v
-- 			p = k
-- 		end
-- 	end
-- 	return p
-- end


-- return map of player id => distance
function cAPI.getNearestPlayers(radius)
	local r = {}
  
	local ped = PlayerPedId()
	local pid = PlayerId()
	local px,py,pz = GetEntityCoords(ped) 
  
	for k in pairs(GetActivePlayers()) do
	  local player = GetPlayerFromServerId(k)
  
	  if player ~= pid and NetworkIsPlayerConnected(player) then
		local oped = GetPlayerPed(player)
		local x,y,z = table.unpack(GetEntityCoords(oped,true))
		local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
		if distance <= radius then
		  r[GetPlayerServerId(player)] = distance
		end
	  end
	end
  
	return r
  end
  
-- return player id or nil
function cAPI.getNearestPlayer(radius)
	local p = nil

	local players = cAPI.getNearestPlayers(radius)
	local min = radius+10.0
	for k,v in pairs(players) do
		if v < min then
		min = v
		p = k
		end
	end
	return p
end

local weaponModels = {
	"weapon_fishingrod",
	"weapon_moonshinejug",
	"weapon_bow",
	"weapon_lasso",
	"weapon_kit_camera",
	"weapon_kit_binoculars",
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

function cAPI.getWeapons()
	local ped = PlayerPedId()

	local ammo_types = {}

	local weapons = {}
	for k, v in pairs(weaponModels) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(ped, hash) then
			local atype = GetPedAmmoTypeFromWeapon(ped, hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapons[v] = GetAmmoInPedWeapon(ped, hash)
			else
				weapons[v] = 0
			end
		end
	end

	return weapons
end

-- function cAPI.removeWeapon(weapon)
-- 	local weapons = cAPI.getWeapons()
-- 	if weapons[weapon] then
-- 		weapons[weapon] = nil
-- 	end
-- 	cAPI.replaceWeapons(weapons)
-- end

function cAPI.replaceWeapons(weapons)
	local old_weapons = cAPI.getWeapons()
	cAPI.giveWeapons(weapons, true)
	return old_weapons
end

function cAPI.giveWeapon(weapon, ammo, clear_before)
	cAPI.giveWeapons(
		{
			weapon = ammo
		},
		clear_before
	)
end

function cAPI.giveWeapons(weapons, clear_before)
	local ped = PlayerPedId()

	if clear_before then
		RemoveAllPedWeapons(ped, true, true)
	end

	for weapon, ammo in pairs(weapons) do
		local hash = GetHashKey(weapon)

		GiveWeaponToPed_2(PlayerPedId(), hash, ammo or 0, false, true, GetWeapontypeGroup(hash), ammo > 0, 0.5, 1.0, 0, true, 0, 0)
		Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), hash, 0, false, true)
		Citizen.InvokeNative(0x5FD1E1F011E76D7E, PlayerPedId(), GetPedAmmoTypeFromWeapon(PlayerPedId(), hash), ammo)
	end
end

function cAPI.setArmour(amount)
	SetPedArmour(PlayerPedId(), amount)
end

function cAPI.getArmour()
	return GetPedArmour(PlayerPedId())
end

function cAPI.setHealth(amount)
	SetEntityHealth(PlayerPedId(), math.floor(amount))
end

function cAPI.getHealth()
	return GetEntityHealth(PlayerPedId())
end

local prompResult = nil

function cAPI.prompt(title, default_text)
	SendNUIMessage({act = "prompt", title = title, text = tostring(default_text)})
	SetNuiFocus(true)
	while prompResult == nil do
		Citizen.Wait(10)
	end
	local _temp = prompResult
	prompResult = nil
	return _temp
end

RegisterNUICallback(
	"prompt",
	function(data, cb)
		if data.act == "close" then
			SetNuiFocus(false)
			prompResult = data.result
		end
	end
)

local requests = {}

function cAPI.request(text, time)
	local id = math.random(999999)
	SendNUIMessage({act = "request", id = id, text = tostring(text), time = time})

	-- !!! OPTIMIZATION
	-- Stop the loop while the time has passed

	while requests[id] == nil do
		Citizen.Wait(10)
	end

	local _temp = requests[id] or false
	requests[id] = nil
	return _temp
end

RegisterNUICallback(
	"request",
	function(data, cb)
		if data.act == "response" then
			requests[data.id] = data.ok
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(3)
			if IsControlJustPressed(0, 0xCEFD9220) then
				SendNUIMessage({act = "event", event = "yes"})
			end
			if IsControlJustPressed(0, 0x4BC9DABB) then
				SendNUIMessage({act = "event", event = "no"})
			end
		end
	end
)


local Invinsible 

function cAPI.toggleInvinsible()
	Invinsible = not Invinsible
	if Invinsible then
		SetEntityInvincible(PlayerPedId(), true)
	else
		SetEntityInvincible(PlayerPedId(), false)
	end
end

local noclip = false
local noclip_speed = 10.0

function cAPI.toggleNoclip()
	noclip = not noclip
	if noclip then
		SetEntityInvincible(PlayerPedId(), true)
		SetEntityVisible(PlayerPedId(), false)
		NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
	else
		SetEntityInvincible(PlayerPedId(), false)
		SetEntityVisible(PlayerPedId(), true)
		NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
	end
end


local function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading * math.pi / 180.0)
	local y = math.cos(heading * math.pi / 180.0)
	local z = math.sin(pitch * math.pi / 180.0)
	local len = math.sqrt(x * x + y * y + z * z)
	if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end
	return x, y, z
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			SetEntityMaxHealth(PlayerPedId(), 150)
			SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
			if noclip then
				local ped = PlayerPedId()
				local x, y, z = cAPI.getPosition()
				local dx, dy, dz = getCamDirection()
				local speed = noclip_speed
				SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

				if IsControlPressed(0, 0x8FD015D8) then
					x = x + speed * dx
					y = y + speed * dy
					z = z + speed * dz
				end

				if IsControlPressed(0, 0xD27782E3) then
					x = x - speed * dx
					y = y - speed * dy
					z = z - speed * dz
				end

				if IsControlPressed(0, 0x8FFC75D6) then -- SHIFT
					noclip_speed = 10.0
				elseif IsControlPressed(0, 0xDB096B85) then -- CTRL
					noclip_speed = 0.2
				else
					noclip_speed = 1.0
				end

				SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
			end
		end
	end
)

function cAPI.playAnim(dict, anim, speed)
	if not IsEntityPlayingAnim(PlayerPedId(), dict, anim) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(100)
		end
		TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
	end
end

function cAPI.isPlayingAnimation(dict, anim)
	local ped = PlayerPedId()
	return IsEntityPlayingAnim(ped, dict, anim, 3)
end

function cAPI.clientConnected(bool)
	if bool then
		ShutdownLoadingScreenNui()
		ShutdownLoadingScreen()
	end
end

function cAPI.LoadModel(hash)
	local waiting = 0

	if IsModelValid(hash) then
		if not HasModelLoaded(hash) then
			RequestModel(hash)
			while not HasModelLoaded(hash) do
				Citizen.Wait(10)
			end

			return true
		end
	end

	return false
end

function cAPI.StartFade(timer)
	DoScreenFadeOut(timer)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function cAPI.EndFade(timer)
	ShutdownLoadingScreen()
	DoScreenFadeIn(timer)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

local serverToUserChanged = false
local serverToUser = {}

RegisterNetEvent('FRP:_CORE:SetServerIdAsUserId')
AddEventHandler('FRP:_CORE:SetServerIdAsUserId', function(serverid, userid)
	serverToUser[serverid] = userid
	serverToUserChanged  = true
end)

RegisterNetEvent('FRP:_CORE:SetServerIdAsUserIdPacked')
AddEventHandler('FRP:_CORE:SetServerIdAsUserIdPacked', function(r)
	serverToUser = r
	serverToUserChanged  = true
end)

function cAPI.GetUserIdFromServerId(serverid)
	return serverToUser[serverid] or 0
end

function cAPI.GetServerIdFromUserId(userid)
	for serverid, _userid in pairs(serverToUser) do
		if _userid == userid then
			return serverid
		end
	end

	return 0
end