local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local wantedUserIds = {}

RegisterServerEvent("FRP:WANTED:checkJOB")
AddEventHandler(
    "FRP:WANTED:checkJOB",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        if Character:hasGroup("user") then
            return true
        end
    end
)

RegisterServerEvent("FRP:WANTED:gunshotInProgress")
AddEventHandler(
    "FRP:WANTED:gunshotInProgress",
    function(targetCoords, CityName, playerGender, suspectInstead)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if playerGender == -171876066 then
            playerGender = "homem"
        else
            playerGender = "mulher"
        end

        local PoliceON = API.getUsersByGroup("trooper")

        for i = 1, #PoliceON do
            TriggerClientEvent("FRP:WANTED:gunshotInProgress", PoliceON[i].getSource(), targetCoords)

            if suspectInstead then
                TriggerClientEvent("FRP:TOAST:New", PoliceON[i].getSource(), "alert", "Sheriff: Suspeito(a) encontrado em " .. CityName)
            else
                TriggerClientEvent("FRP:TOAST:New", PoliceON[i].getSource(), "alert", "Sheriff: Disparos por " .. playerGender .. " foram relatados em " .. CityName)
            end
        end
    end
)

RegisterServerEvent("FRP:WANTED:RewardNotify")
AddEventHandler(
    "FRP:WANTED:RewardNotify",
    function(id, reward, city)
        local tplayer = API.getUserFromUserId(parseInt(id)):getSource()

        local User = API.getUserFromSource(tplayer)

        local Character = User:getCharacter()
        local pname = Character:getName()
        local charid = Character:getId()
        local wan = Character:getData(charid, "wanted", city)

        local PoliceON = API.getUsersByGroup("trooper")

        for i = 1, #PoliceON do
            if wan ~= nil then
                if wan == "{}" then
                    local wantedvalue = 0
                    TriggerClientEvent("FRP:WANTED:RewardNotify", PoliceON[i].getSource(), reward + wantedvalue, pname, city)
                else
                    local wantedvalue = json.decode(wan)
                    TriggerClientEvent("FRP:WANTED:RewardNotify", PoliceON[i].getSource(), reward + wantedvalue, pname, city)
                end
            else
                TriggerClientEvent("FRP:WANTED:RewardNotify", PoliceON[i].getSource(), reward, pname, city)
            end
        end
    end
)

RegisterServerEvent("FRP:WANTED:RewardSERVER")
AddEventHandler(
    "FRP:WANTED:RewardSERVER",
    function(id, value, city)
        local tplayer = API.getUserFromUserId(parseInt(id)):getSource()
        local User = API.getUserFromSource(tplayer)

        local Character = User:getCharacter()
        local charid = Character:getId()
        local wan = Character:getData(charid, "wanted", city)

        if wan ~= nil then
            local wantedvalue = json.decode(wan)
            local wanted = {
                [city] = value
            }
            Character:setData(charid, "wanted", city, value + wantedvalue)
        else
            local wanted = {
                [city] = value
            }
            Character:setData(charid, "wanted", city, value)
        end

        --   Character:setWanted(charid, json.encode(wanted))
    end
)

RegisterCommand(
    "gwanted2",
    function(source)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local charid = Character:getId()

        local wan = Character:getData(charid, "wanted", nil)
        local wanted = json.decode(wan)
        TriggerClientEvent("FRP:WANTED:GetWanted", _source, wanted)
    end
)

RegisterNetEvent("FRP:WANTED:MarkAsWanted")
AddEventHandler(
    "FRP:WANTED:MarkAsWanted",
    function(asWanted)
        local _source = source

        local v = asWanted == true and true or nil

        local User = API.getUserFromSource(_source)

        if User then
            wantedUserIds[User:getId()] = v

            for _, User in pairs(API.getUsersByGroup("trooper")) do
                local uSource = User:getSource()

                TriggerClientEvent("FRP:WANTED:SyncWantedOrNotPlayer", uSource, v)
            end
        end
    end
)

AddEventHandler(
    "API:OnUserCharacterInitialization",
    function(User, character_id)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("trooper") then
            local r = {}

            for _, uid in pairs(wantedUserIds) do
                local sUser = API.getUserFromUserId(uid)
                local sSource = User:getSource()
                table.insert(r, sSource)
            end

            TriggerClientEvent("FRP:WANTED:SyncWantedPlayers", source, r)
        end
    end
)
