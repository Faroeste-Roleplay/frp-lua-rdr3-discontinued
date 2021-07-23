local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- local combatlogged = {}
local oncombat = {}

os.setlocale("pt_BR")

AddEventHandler(
    "FRP:UserDropped",
    function(source, user_id, character_id, reason)
        if oncombat[user_id] then
            local reasons = {}

            for _, v in pairs(oncombat[user_id]) do
                local end_at = v.end_at

                if os.time() >= end_at then
                    -- print("COMBATLOG expired reason: ", v.reason)
                    oncombat[user_id][_] = nil
                else
                    local reason_display = v.reason
                    -- local duration = v.duration

                    local start_at = v.start_at

                    local diff_start_end = end_at - start_at
                    local diff_start_current = os.time() - start_at

                    -- local percent = string.format("%.2f", (diff_start_current / diff_start_end) * 100)

                    -- reason_display = reason_display .. " (" .. percent .. "%" .. ")"

                    reason_display = reason_display .. " (" .. diff_start_current .. " secs/" .. diff_start_end .. " secs" .. ")"

                    table.insert(reasons, reason_display)
                end
            end

            if #reasons > 0 then
                local date = os.date("%c", os.time())
                local drop_reason = reason
                local combat_reasons = table.concat(reasons, "\n")

                -- table.insert(
                --     combatlogged,
                --     {
                --         date = date,
                --         user_id = user_id,
                --         drop_reason = drop_reason,
                --         combat_reasons = combat_reasons
                --     }
                -- )

                local message = "**" .. GetPlayerName(source) .. " (" .. user_id .. ")**\n\n" .. "**Desconectado por**\n" .. drop_reason .. "\n\n" .. "**Possíveis combat-logs**\n" .. combat_reasons .. "\n"

                discordHttpRequest(10798571, "***_vp__internal_COMBATLOG***", message, date)
            end

            oncombat[user_id] = nil
        end
    end
)

RegisterNetEvent("FRP:COMBATLOG:AddUserCombatReason")
AddEventHandler(
    "FRP:COMBATLOG:AddUserCombatReason",
    function(user_id, duration, reason)
        local l = {
            reason = reason,
            start_at = os.time(),
            end_at = os.time() + duration
        }

        if not oncombat[user_id] then
            oncombat[user_id] = {}
        end

        print("^9_vp__internal_COMBATLOG  ^7| (" .. user_id .. ") ^1" .. reason .. "^7")

        table.insert(oncombat[user_id], l)
    end
)

-- RegisterCommand(
--     "fakedrop",
--     function(source, args, raw)
--         local User = API.getUserFromSource(source)
--         local user_id = User:getId()
--         local character_id = User:getCharacter() and User:getCharacter():getId() or 0
--         local reason = "Disconnected."

--         TriggerEvent("FRP:UserDropped", source, user_id, character_id, reason)
--     end,
--     false
-- )

-- RegisterCommand(
--     "reason",
--     function(source, args, raw)
--         local User = API.getUserFromSource(source)
--         local user_id = User:getId()

--         TriggerEvent("FRP:COMBATLOG:AddUserCombatReason", user_id, 300, "Roubo a Loja")
--     end,
--     false
-- )

local DISCORD_WEBHOOK = "https://discordapp.com/api/webhooks/733148246049816616/dhm40WccPu5CBd5XvcXH7ePqJa-EZl9zKwlA41mie08VXWQprpWuQBQo1T9sq33oHCrJ"
local DISCORD_NAME = "_vp__internal"
-- local STEAM_KEY = ""
local DISCORD_IMAGE = "" -- default is FiveM logo

function discordHttpRequest(color, title, description, footer)
    local connect = {
        {
            ["color"] = color,
            -- ["title"] = title,
            -- thumbnail = {
            --     height = 4,
            --     width = 4,
            --     url = "https://lh5.googleusercontent.com/-R4mdckCExWA/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuckInzLv1R8s79vzkcqVzkGnQyFeTg/s88-c-k-c0x00ffffff-no-rj-mo/photo.jpg",
            -- },
            ["description"] = description,
            ["footer"] = {
                ["text"] = footer
            }
        }
    }
    PerformHttpRequest(
        DISCORD_WEBHOOK,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}),
        {["Content-Type"] = "application/json"}
    )
end
