local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local commands = {}

commands.print = function(source, args)
    if source == 0 then
        print("^4CONSOLE | ^0" .. args)
    else
    end
end

commands.commands = function(source, args)
    -- commands.print(source, "Commandos")
    for command, _ in pairs(commands) do
        commands.print(source, command)
    end
    -- commands.print(source, " ")
end

commands.addwhitelist = function(source, args)
    local userId = args[1]

    if userId then
        if API.setAsWhitelisted(userId, true) then
            commands.print(source, name .. " [" .. userId .. "] Adicionado a whitelist!")
        else
            commands.print(source, name .. " [" .. userId .. "] Já possui whitelist")
        end
    else
        commands.print(source, "Syntax: addwhitelist <userId>")
    end
end

commands.removewhitelist = function(source, args)
    local userId = args[1]

    if userId then
        if API.setAsWhitelisted(userId, false) then
            commands.print(source, name .. " [" .. userId .. "] Removido da whitelist!")
        else
            commands.print(source, name .. " [" .. userId .. "] Não possui whitelist")
        end
    else
        commands.print(source, "Syntax: removewhitelist <userId>")
    end
end

commands.players = function(source, args)
    local users = API.getUsers()

    commands.print(source, "Conectados " .. #users .. "/32")

    listusers(source, users)
end

commands.playersbygroup = function(source, args)
    local group = args[1]

    if group then
        local users = API.getUsersByGroup(group)

        commands.print(source, "Conectados " .. #users .. "/32 GRUPO: " .. group)

        listusers(source, users)
    end
end

commands.setpriority = function(source, args)
    local user_id = tonumber(args[1])
    local priority = tonumber(args[2])

    if user_id and priority then
        commands.print(source, "Prioridade para o usuário " .. user_id .. " agora é " .. priority)

        if priority > 0 then
            dbAPI.execute("queue:set", {user_id = user_id, priority = priority, start = 0, ["end"] = 0})
        else
            dbAPI.execute("queue:remove", {user_id = user_id})
        end
    end
end

function listusers(source, users)
    local colors = {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
    }

    local ci = 1

    for user_id, User in pairs(users) do
        Wait(0)

        local d = {}

        d.src = User:getSource()
        d.steam_id = User:getIdentifiers()[1]
        d.ip_address = User:getIpAddress()
        d.char_id = "X"

        local Character = User:getCharacter()

        if Character then
            d.char_id = Character:getId()
            d.char_name = Character:getName()
            d.char_age = Character:getAge()
            d.char_exp = Character:getExp()
            d.char_level = Character:getLevel()
            d.char_role = Character.role

            local Horse = Character:getHorse()

            if Horse then
                d.horse_id = Horse:getId()
            end
        end

        local s = "^" .. colors[ci] .. "USER: " .. User:getId()

        for k, v in pairs(d) do
            s = s .. " |" .. k .. ": " .. v
        end

        commands.print(source, s)

        ci = ci + 1

        if ci > #colors then
            ci = 1
        end
    end
end

-- steam:110000109766c18

RegisterCommand(
    "console",
    function(source, args, raw)
        if #args <= 0 then
            return
        end

        local hasPermission = false

        if source == 0 then
            hasPermission = true
        else
            local User = API.getUserFromSource(source)
            local Character = User:getCharacter()
            if Character and Character:hasGroupOrInheritance("superadmin") then
                hasPermission = true
            end
        end

        if hasPermission then
            local command = args[1]

            if commands[command] then
                table.remove(args, 1)

                commands[command](source, args)
            end
        end
    end,
    false
)
