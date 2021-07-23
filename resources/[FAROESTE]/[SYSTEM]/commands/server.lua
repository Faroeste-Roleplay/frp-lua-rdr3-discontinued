local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterCommand(
    "o",
    function(source, args, raw)
        local listingType = args[1]

        local types = {
            ["medico"] = {group = "medic", displayName = "Medicos"},
            ["policia"] = {group = "trooper", displayName = "Policiais"}
        }

        local User = API.getUserFromSource(source)

        if args[1] then
            local d = types[args[1]]

            if d then
                local group = d.group
                local displayName = d.displayName

                local users = API.getUsersByGroup(group)

                User:notify("alert", #users .. " " .. displayName .. " online!")
            else
                local s = "["

                for type, _ in pairs(types) do
                    s = s .. type .. ", "
                end

                s = s .. "]"

                User:notify("error", "/o " .. s)
            end
        else
            local s = "["

            for type, _ in pairs(types) do
                s = s .. type .. ", "
            end

            s = s .. "]"

            User:notify("error", "/o " .. s)
        end
    end,
    false
)
