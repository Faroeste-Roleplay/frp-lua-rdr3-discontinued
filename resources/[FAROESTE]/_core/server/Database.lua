API_Database = {}
local API = exports["GHMattiMySQL"]

---------------------------------------------
---------------DATABASE SYSTEM---------------
---------------------------------------------
DBConnect = {
	driver = "ghmattimysql",
	host = "localhost",
	database = "faroeste",
	user = "root",
	password = ""
}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local prepared_queries = {}
local db_initialized = false

function API_Database.registerDBDriver(name, on_init, on_prepare, on_query)
	if not db_drivers[name] then
		db_drivers[name] = {on_init, on_prepare, on_query}

		if name == DBConnect.driver then
			db_driver = db_drivers[name]

			local ok = on_init(DBConnect)
			if ok then
				db_initialized = true
				for _, prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare, 1, table.maxn(prepare)))
				end

				for _, query in pairs(cached_queries) do
					async(
						function()
							query[2](on_query(table.unpack(query[1], 1, table.maxn(query[1]))))
						end
					)
				end

				cached_prepares = nil
				cached_queries = nil
			else
				error("Conexão com o banco de dados perdida.")
			end
		end
	else
		error("Banco de dados registrado.")
	end
end

function API_Database.format(n)
	local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)$")
	return left .. (num:reverse():gsub("(%d%d%d)", "%1."):reverse()) .. right
end

function API_Database.prepare(name, query)
	prepared_queries[name] = true

	if db_initialized then
		db_driver[2](name, query)
	else
		table.insert(cached_prepares, {name, query})
	end
end

function API_Database.query(name, params, mode)
	if not prepared_queries[name] then
		error("query " .. name .. " doesn't exist.")
	end

	if not mode then
		mode = "query"
	end

	if db_initialized then
		return db_driver[3](name, params or {}, mode)
	else
		local r = async()
		table.insert(cached_queries, {{name, params or {}, mode}, r})
		return r:wait()
	end
end

function API_Database.execute(name, params)
	return API_Database.query(name, params, "execute")
end

---------------------------------------------
---------------EXECUTE  SYSTEM---------------
---------------------------------------------
local queries = {}

local function on_init(cfg)
	return API ~= nil
end

local function on_prepare(name, query)
	queries[name] = query
end

local function on_query(name, params, mode)
	local query = queries[name]
	local _params = {}
	_params._ = true

	for k, v in pairs(params) do
		_params["@" .. k] = v
	end

	local r = async()

	if mode == "execute" then
		API:QueryAsync(
			query,
			_params,
			function(affected)
				r(affected or 0)
			end
		)
	elseif mode == "scalar" then
		API:QueryScalarAsync(
			query,
			_params,
			function(scalar)
				r(scalar)
			end
		)
	else
		API:QueryResultAsync(
			query,
			_params,
			function(rows)
				r(rows, #rows)
			end
		)
	end
	return r:wait()
end

Citizen.CreateThread(
	function()
		API:Query("SELECT 1")
		API_Database.registerDBDriver("ghmattimysql", on_init, on_prepare, on_query)
	end
)

----------	USER QUERIES -------------
API_Database.prepare("FCRP/CreateUser", "INSERT INTO users(identifier, name, createdAt, banned) VALUES(@identifier, @name, @createdAt, 0); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/SelectUser", "SELECT * from users WHERE identifier = @identifier")
API_Database.prepare("FCRP/BannedUser", "SELECT banned from users WHERE user_id = @user_id")
API_Database.prepare("FCRP/SetBanned", "UPDATE users SET banned = 1, reason = @reason WHERE user_id = @user_id")
API_Database.prepare("FCRP/UnBan", 'UPDATE users SET banned = 0, reason = "" WHERE user_id = @user_id')
API_Database.prepare("FCRP/Whitelisted", "SELECT whitelist from users WHERE identifier = @identifier")
API_Database.prepare("AddIdentifierWhitelist", "UPDATE users SET whitelist = 1 where user_id = @user_id")
API_Database.prepare("RemoveIdentifierWhitelist", "UPDATE users SET whitelist = 0 where user_id = @user_id")

-------- CHARACTER QUERIES -----------
API_Database.prepare("FCRP/CreateCharacter", "INSERT INTO characters(user_id, characterName, groups, age) VALUES (@user_id, @charName, 0,@charAge); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/CharacterAppearence", "INSERT INTO characters_appearence (charid, isMale, model, enabledComponents, faceFeatures, overlays, clothes, pedHeight) VALUES (@charId, @isMale, @model, '{}', '{}', '{}', '{}', 1.0)")
API_Database.prepare("FCRP/GetCharacters", "SELECT * from characters WHERE user_id = @user_id")
API_Database.prepare("FCRP/GetCharacter", "SELECT * from characters WHERE charid = @charid")
API_Database.prepare("FCRP/GetCharacterAppearence", "SELECT * from characters_appearence WHERE charid = @charid")
API_Database.prepare("FCRP/DeleteCharacter", "DELETE FROM characters WHERE charid = @charid")
API_Database.prepare("FCRP/GetUserIdByCharId", "SELECT user_id from characters WHERE charid = @charid")
API_Database.prepare("FCRP/GetCharNameByCharId", "SELECT characterName from characters WHERE charid = @charid")
API_Database.prepare("FCRP/UpdateLevel", "UPDATE characters SET level = @level WHERE charid = @charid")
API_Database.prepare("FCRP/UpdateXP", "UPDATE characters SET xp = @xp WHERE charid = @charid")
API_Database.prepare("UPDATE:character_data_role", "UPDATE characters SET groups = @role WHERE charid = @charid")
API_Database.prepare("UPDATE:character_data_clothing", "UPDATE characters SET clothes = @clothing WHERE charid = @charid")
-------- CHARACTER DATATABLE QUERIES --------
API_Database.prepare("FCRP/SetCData", "CALL setData(@target, @key, @value, @charid)")
API_Database.prepare("FCRP/GetCData", "CALL getData(@target, @charid, @key)")
API_Database.prepare("FCRP/RemCData", "CALL remData(@target, @key, @charid)")

API_Database.prepare("FCRP/SetComponentsPed", "UPDATE characters_appearence SET enabledComponents = @value WHERE charid = @charid")
API_Database.prepare("FCRP/SetfaceFeaturePeds", "UPDATE characters_appearence SET faceFeatures = @value WHERE charid = @charid")
API_Database.prepare("FCRP/SetPlayerPedModel", "UPDATE characters_appearence SET model = @model AND isMale = @isMale WHERE charid = @charid")
API_Database.prepare("FCRP/SetPedHeight", "UPDATE characters_appearence SET pedHeight = @value WHERE charid = @charid")
API_Database.prepare("FCRP/SetPedWeight", "UPDATE characters_appearence SET pedWeight = @value WHERE charid = @charid")

API_Database.prepare("FCRP/GetCharModel", "SELECT model from characters_appearence WHERE charid = @charid")

API_Database.prepare("FCRP/SetCWeaponData", "UPDATE characters SET weapons = @weapons WHERE charid = @charid")
API_Database.prepare("FCRP/SetPlayerDeath", "UPDATE characters SET is_dead = @is_dead WHERE charid = @charid")

API_Database.prepare("FCRP/GetPlayerDeath", "SELECT is_dead from characters WHERE charid = @charid")

-------- FORT DATATABLE QUERIES --------
API_Database.prepare("FCRP/SetCFort", "UPDATE fort SET bando = @bando WHERE id = @id")
API_Database.prepare("FCRP/GetCFort", "SELECT bando from fort WHERE id = @id")

-------- JAIL DATATABLE QUERIES --------
API_Database.prepare("FCRP/SetCJail", "INSERT INTO jail(charid, jail_time) VALUES (@charid, @jail_time); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/UpdCJail", "UPDATE jail SET jail_time = @jail_time WHERE charid = @charid")
API_Database.prepare("FCRP/GetCJail", "SELECT * from jail WHERE charid = @charid")
API_Database.prepare("FCRP/RemCJail", "DELETE FROM jail WHERE charid = @charid")

-------- QUEST DATATABLE QUERIES --------
API_Database.prepare("FCRP/SetQuest", "INSERT INTO quest(questId, charid, questSteps) VALUES (@questId, @charid, @questSteps); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/UpdQuest", "UPDATE quest SET questSteps = @questSteps WHERE questId = @questId")
API_Database.prepare("FCRP/GetQuest", "SELECT * from quest WHERE charid = @charid")
API_Database.prepare("FCRP/RemQuest", "DELETE FROM quest WHERE questId = @questId")

-------- TENTS DATATABLE QUERIES --------
API_Database.prepare("FCRP/AddTents", "INSERT INTO tents(charid, model, position) VALUES (@charid, @model, @position); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/GetTents", "SELECT * from tents WHERE charid = @charid")
API_Database.prepare("FCRP/GetAllTents", "SELECT * from tents")
API_Database.prepare("FCRP/RemoveTents", "DELETE FROM tents WHERE id = @id")

-------- WANTED DATATABLE QUERIES --------
API_Database.prepare("FCRP/SetCWanted", "INSERT INTO characters(wanted) VALUES (@wanted); SELECT LAST_INSERT_ID() AS user_id")
API_Database.prepare("FCRP/GetCWanted", "SELECT wanted from characters WHERE charid = @charid")
API_Database.prepare("FCRP/UpdCWanted", "UPDATE wanted SET wanted = @wanted WHERE charid = @charid")

-------- JOINAPP DATATABLE QUERIES --------
API_Database.prepare("FCRP/JoinAppS", "SELECT steam from playerjoin WHERE steam = @identifier")
API_Database.prepare("FCRP/JoinAppD", "DELETE FROM jail WHERE charid = @charid")

-------- INVENTORY QUERIES -----------
API_Database.prepare("FCRP/Inventory", "CALL procInventory(@id, @charid, @capacity, @slot, @itemId, @itemAmount, @procType);")
API_Database.prepare("UPDATE:inv_update_slot", "CALL inv_update_slot(@inv_id, @slot_id, @slot_value)")
API_Database.prepare("UPDATE:inv_remove_slot", "CALL inv_remove_slot(@inv_id, @slot_id);")
API_Database.prepare("SELECT:inv_select_slots_and_capacity", "SELECT inv_slots, inv_capacity FROM inventories WHERE id = @inv_id")
API_Database.prepare("UPDATE:inv_clear", "UPDATE inventories SET inv_slot = `{}` WHERE inv_id = @inv_id")

---------- HORSE QUERIES -------------
API_Database.prepare("FCRP/CreateHorse", "INSERT INTO horses(charid, model, name) VALUES (@charid, @model, @name); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/GetHorses", "SELECT * from horses WHERE charid = @charid")
API_Database.prepare("FCRP/GetHorse", "SELECT * from horses WHERE id = @id")
API_Database.prepare("FCRP/DeleteHorse", "DELETE FROM horses WHERE id = @id")

API_Database.prepare("UpdateHorseComponents", "UPDATE horses SET components = @components WHERE id = @id")
API_Database.prepare("SelectHorseComponents", "SELECT components FROM horses WHERE id = @id")

API_Database.prepare("UpdateHorseMetaData", "UPDATE horses SET metaData = @metadata WHERE id = @id")
API_Database.prepare("SelectHorseMetaData", "SELECT metaData FROM horses WHERE id = @id")

---------- POSSE QUERIES -------------
API_Database.prepare("FCRP/CreatePosse", "INSERT INTO posses(charid, members, name) VALUES (@charid, @members, @name); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/GetPosseById", "SELECT * from posses WHERE id = @id")

---------- CHEST QUERIES -------------
API_Database.prepare("FCRP/GetChests", "SELECT * from chests")
API_Database.prepare("FCRP/CreateChest", "INSERT INTO chests(charid, position, type, capacity) VALUES (@charid, @position, @type, @capacity); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("FCRP/CreateStaticChest", "INSERT INTO chests(position, type, capacity) VALUES (@position, @type, @capacity); SELECT LAST_INSERT_ID() AS id")

------------ CROP QUERIES --------------------
API_Database.prepare("UPDATE:crop_update_slot", "UPDATE farms SET crop_percent_grown = @crop_percent_grown, crop_min_time_water = @crop_min_time_water WHERE crop_id = @crop_id AND slot_id = @slot_id")
API_Database.prepare("UPDATE:crop_remove_slot", "DELETE FROM farms WHERE crop_id = @crop_id AND slot_id = @slot_id")
API_Database.prepare("INSERT:crop_insert_slot", "INSERT INTO farms(crop_id, slot_id, crop_percent_grown, crop_min_time_water) VALUES (@crop_id, @slot_id, 0, @crop_min_time_water)")
API_Database.prepare("SELECT:get_crop_slots", "SELECT slot_id, crop_percent_grown, crop_min_time_water FROM farms WHERE crop_id = @crop_id")

------------ HOUSE RENT QUERIES --------------
API_Database.prepare("INSERT:house_rent", "INSERT INTO house_rent(house_id, house_next_payment) VALUES (@house_id, @house_next_payment)")
API_Database.prepare("SELECT:house_rent", "SELECT house_next_payment from house_rent WHERE house_id = @house_id")
API_Database.prepare("DELETE:house_rent", "DELETE FROM house_rent WHERE house_id = @house_id")

API_Database.prepare("UPDATE:character_remove_role", "UPDATE characters SET groups = groups & ~@role")

-- API_Database.prepare("SELECT:house_rent_with_group", "SELECT charid FROM characters WHERE groups & @role = @role")

API_Database.prepare("queue:set", "INSERT INTO queue_priority(id, priority, start, end) VALUES (@user_id, @priority, @start, @end)")
API_Database.prepare("queue:get", "SELECT priority, start, end from queue_priority WHERE id = @user_id")
API_Database.prepare("queue:remove", "DELETE FROM queue_priority WHERE id = @user_id")

------------ ORGANIZATIONS --------------------
API_Database.prepare("orgs:insert", "INSERT INTO organizations(name, type) VALUES (@name, @type); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare("orgs:delete", "DELETE FROM organizations WHERE id = @org_id")
API_Database.prepare("orgs:getMemberOrgs", "SELECT o.id, o.name, o.type, m.rank FROM organizations o, org_members m  WHERE o.id = m.org_id AND m.member_id = @member_id")
API_Database.prepare("orgs:getMemberOrgByType", "SELECT o.id, o.name, o.type, m.rank FROM organizations o, org_members m  WHERE o.id = m.org_id AND m.member_id = @member_id AND o.type = @org_type")
API_Database.prepare("orgs:getOrgType", "SELECT type FROM organizations WHERE id = @org_id")

------------ ORGANIZATIONS MEMBERS --------------------
API_Database.prepare("orgs:insertMember", "INSERT INTO org_members(org_id, member_id, rank, joined_at) VALUES (@org_id, @member_id, @rank, @joined_at)")
API_Database.prepare("orgs:removeMember", "DELETE FROM org_members WHERE org_id = @org_id AND member_id = @member_id")
API_Database.prepare("orgs:getMembersByOrg", "SELECT m.*, c.characterName name, o.type FROM org_members m, characters c, organizations o WHERE m.org_id = @org_id AND c.charid = m.member_id AND m.org_id = o.id ORDER by m.org_id,m.rank,m.joined_at")
API_Database.prepare("orgs:getMemberRank", "SELECT rank FROM org_members WHERE org_id = @org_id AND member_id = @member_id")
API_Database.prepare("orgs:setMemberRank", "UPDATE org_members set rank = @rank WHERE org_id = @org_id AND member_id = @member_id")

------------ OUTPOSTS --------------------
API_Database.prepare("outposts:getall", "SELECT * from outposts")

------------ UNLOCKS --------------------
API_Database.prepare("outpost_unlocs:getbyid", "SELECT * FROM unlocks WHERE unlock_id = @unlock_id")

do
	-- ["placeholder"] = "placeholder",

	local queries = {
		user = {
			["FCRP/CreateUser"] = "INSERT INTO users(identifier, name, banned) VALUES(@identifier, @name, 0); SELECT LAST_INSERT_ID() AS id",
			["FCRP/SelectUser"] = "SELECT * from users WHERE identifier = @identifier",
			["FCRP/BannedUser"] = "SELECT banned from users WHERE user_id = @user_id",
			["FCRP/SetBanned"] = "UPDATE users SET banned = 1, reason = @reason WHERE user_id = @user_id",
			["FCRP/UnBan"] = 'UPDATE users SET banned = 0, reason = "" WHERE user_id = @user_id',
			["FCRP/Whitelisted"] = "SELECT * from whitelist WHERE identifier = @identifier",
			["AddIdentifierWhitelist"] = "INSERT INTO whitelist(identifier) VALUES(@identifier)",
			["RemoveIdentifierWhitelist"] = "DELETE FROM whitelist WHERE identifier = @identifier"
		},
		character = {
			["FCRP/CreateCharacter"] = "INSERT INTO characters(user_id, characterName, groups, age) VALUES (@user_id, @charName, 0,@charAge); SELECT LAST_INSERT_ID() AS id",
			["FCRP/CharacterAppearence"] = "INSERT INTO characters_appearence (charid, isMale, model, enabledComponents, faceFeatures, overlays, clothes, pedHeight) VALUES (@charId, @isMale, 'mp_male', '{}', '{}', '{}', '{}', 1.0)",
			["FCRP/GetCharacters"] = "SELECT * from characters WHERE user_id = @user_id",
			["FCRP/GetCharacter"] = "SELECT * from characters WHERE charid = @charid",
			["FCRP/DeleteCharacter"] = "DELETE FROM characters WHERE charid = @charid",
			["FCRP/GetUserIdByCharId"] = "SELECT user_id from characters WHERE charid = @charid",
			["FCRP/GetCharNameByCharId"] = "SELECT characterName from characters WHERE charid = @charid",
			["FCRP/UpdateLevel"] = "UPDATE characters SET level = @level WHERE charid = @charid",
			["FCRP/UpdateXP"] = "UPDATE characters SET xp = @xp WHERE charid = @charid",
			["UPDATE:character_data_role"] = "UPDATE characters SET groups = @role WHERE charid = @charid",
			["UPDATE:character_data_clothing"] = "UPDATE characters SET clothes = @clothing WHERE charid = @charid",
			["FCRP/SetCData"] = "CALL setData(@target, @key, @value, @charid)",
			["FCRP/GetCData"] = "CALL getData(@target, @charid, @key)",
			["FCRP/RemCData"] = "CALL remData(@target, @key, @charid)",
			["FCRP/SetSkinData"] = "UPDATE characters SET SkinMdf = @value WHERE charid = @charid",
			["FCRP/SetCWeaponData"] = "UPDATE characters SET weapons = @weapons WHERE charid = @charid",
			["FCRP/SetPlayerDeath"] = "UPDATE characters SET is_dead = @is_dead WHERE charid = @charid",
			["FCRP/GetPlayerDeath"] = "SELECT is_dead from characters WHERE charid = @charid",
			["UPDATE:character_remove_role"] = "UPDATE characters SET groups = groups & ~@role",
			jail = {
				["FCRP/SetCJail"] = "INSERT INTO jail(charid, jail_time) VALUES (@charid, @jail_time); SELECT LAST_INSERT_ID() AS id",
				["FCRP/UpdCJail"] = "UPDATE jail SET jail_time = @jail_time WHERE charid = @charid",
				["FCRP/GetCJail"] = "SELECT * from jail WHERE charid = @charid",
				["FCRP/RemCJail"] = "DELETE FROM jail WHERE charid = @charid"
			},
			wanted = {
				["FCRP/SetCWanted"] = "INSERT INTO characters(wanted) VALUES (@wanted); SELECT LAST_INSERT_ID() AS user_id",
				["FCRP/GetCWanted"] = "SELECT wanted from characters WHERE charid = @charid",
				["FCRP/UpdCWanted"] = "UPDATE wanted SET wanted = @wanted WHERE charid = @charid"
			}
		},
		fort = {
			["FCRP/SetCFort"] = "UPDATE fort SET bando = @bando WHERE id = @id",
			["FCRP/GetCFort"] = "SELECT bando from fort WHERE id = @id"
		},
		tents = {
			["FCRP/AddTents"] = "INSERT INTO tents(charid, model, position) VALUES (@charid, @model, @position); SELECT LAST_INSERT_ID() AS id",
			["FCRP/GetTents"] = "SELECT * from tents WHERE charid = @charid",
			["FCRP/GetAllTents"] = "SELECT * from tents",
			["FCRP/RemoveTents"] = "DELETE FROM tents WHERE id = @id"
		},
		inventory = {
			["FCRP/Inventory"] = "CALL procInventory(@id, @charid, @capacity, @slot, @itemId, @itemAmount, @procType);",
			["UPDATE:inv_update_slot"] = "CALL inv_update_slot(@inv_id, @slot_id, @slot_value)",
			["UPDATE:inv_remove_slot"] = "CALL inv_remove_slot(@inv_id, @slot_id);",
			["SELECT:inv_select_slots_and_capacity"] = "SELECT inv_slots, inv_capacity FROM inventories WHERE id = @inv_id",
			["UPDATE:inv_clear"] = "UPDATE inventories SET inv_slot = `{}` WHERE inv_id = @inv_id"
		},
		horse = {
			["FCRP/CreateHorse"] = "INSERT INTO horses(charid, model, name) VALUES (@charid, @model, @name); SELECT LAST_INSERT_ID() AS id",
			["FCRP/GetHorses"] = "SELECT * from horses WHERE charid = @charid",
			["FCRP/GetHorse"] = "SELECT * from horses WHERE id = @id",
			["FCRP/DeleteHorse"] = "DELETE FROM horses WHERE id = @id",
			["UpdateHorseComponents"] = "UPDATE horses SET components = @components WHERE id = @id",
			["SelectHorseComponents"] = "SELECT components FROM horses WHERE id = @id",
			["SelectHorseMetaData"] = "SELECT metaData FROM horses WHERE id = @id",
			["UpdateHorseMetaData"] = "UPDATE horses SET metaData = @metadata WHERE id = @id",

		},
		posse = {
			["FCRP/CreatePosse"] = "INSERT INTO posses(charid, members, name) VALUES (@charid, @members, @name); SELECT LAST_INSERT_ID() AS id",
			["FCRP/GetPosseById"] = "SELECT * from posses WHERE id = @id"
		},
		chest = {
			["FCRP/GetChests"] = "SELECT * from chests",
			["FCRP/CreateChest"] = "INSERT INTO chests(charid, position, type, capacity) VALUES (@charid, @position, @type, @capacity); SELECT LAST_INSERT_ID() AS id",
			["FCRP/CreateStaticChest"] = "INSERT INTO chests(position, type, capacity) VALUES (@position, @type, @capacity); SELECT LAST_INSERT_ID() AS id"
		},
		farming = {
			["UPDATE:crop_update_slot"] = "UPDATE farms SET crop_percent_grown = @crop_percent_grn, crop_min_time_water = @crop_min_time_water WHERE crop_id = @crop_id AND slot_id = @slot_id",
			["UPDATE:crop_remove_slot"] = "DELETE FROM farms WHERE crop_id = @crop_id AND slot_id = @slot_id",
			["INSERT:crop_insert_slot"] = "INSERT INTO farms(crop_id, slot_id, crop_percent_grown, crop_min_time_water) VALUES (@crop_id, @slot_id, 0, @crop_min_time_water)",
			["SELECT:get_crop_slots"] = "SELECT slot_id, crop_percent_grown, crop_min_time_water FROM farms WHERE crop_id = @crop_id"
		},
		house = {
			-- ["SELECT:house_rent_with_group"] = "SELECT charid FROM characters WHERE groups & @role = @role",
			["INSERT:house_rent"] = "INSERT INTO house_rent(house_id, house_next_payment) VALUES (@house_id, @house_next_payment)",
			["SELECT:house_rent"] = "SELECT house_next_payment from house_rent WHERE house_id = @house_id",
			["DELETE:house_rent"] = "DELETE FROM house_rent WHERE house_id = @house_id"
		},
		queue = {
			["queue:set"] = "INSERT INTO queue_priority(id, priority, start, end) VALUES (@user_id, @priority, @start, @end)",
			["queue:get"] = "SELECT priority, start, end from queue_priority WHERE id = @user_id",
			["queue:remove"] = "DELETE FROM queue_priority WHERE id = @user_id"
		}
		-- ["FCRP/JoinAppS"] = "SELECT steam from playerjoin WHERE steam = @identifier",
		-- ["FCRP/JoinAppD"] = "DELETE FROM jail WHERE charid = @charid",
	}

	--[[
	local prefix = ""

	for querytype, queriesoftype in pairs(queries) do
		for query_name, query_spec in pairs(queriesoftype) do
			API_Database.prepare(prefix .. query_name, query_spec)
		end
	end
	]]
end
