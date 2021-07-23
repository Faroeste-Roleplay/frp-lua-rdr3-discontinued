local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local data = {
    -- [1] = {
    --     staticName = "Banco de BlackWater",
    --     staticReward = 35000,
    --     staticSecondsToReward = 10 * 60,
    --     staticMaxParticipants = 3
    -- },
    [2] = {
        staticName = "Banco de Saint Dennis",
        staticReward = 50000,
        staticSecondsToReward = 10 * 60,
        staticMaxParticipants = 3
    },
    [3] = {
        staticName = "Banco Rhodes",
        staticReward = 35000,
        staticSecondsToReward = 10 * 60,
        staticMaxParticipants = 3
    },
    [4] = {
        staticName = "Banco Valentine",
        staticReward = 50000,
        staticSecondsToReward = 10 * 60,
        staticMaxParticipants = 3
    }
}

local cCooldown = 30
local cooldownEndsAtTimeStamp = 0

local indexBeingRobbed = nil
local indexBeingRobbed_seconds = nil
local indexBeingRobbed_participants = {}
local indexBeingRobbed_playerSourceWhoStarted = nil

local robberyBeingEnded = false

RegisterNetEvent("FRP:ROBBERY:TryToStartRobbery")
AddEventHandler(
    "FRP:ROBBERY:TryToStartRobbery",
    function(index, participants)
        local _source = source
        local User = API.getUserFromSource(_source)

        if interiorIndexBeingRobbed ~= nil then
            -- print("Interior já está sendo roubado")
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Esse local já está sendo roubado")
            return
        end

        if cooldownEndsAtTimeStamp > os.time() then
            -- print("Fomos assaltados a pouco tempo, não temos dinheiro")
            print("FRP_ROBBERY", cooldownEndsAtTimeStamp, cooldownEndsAtTimeStamp - os.time())
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Fomos assaltados a pouco tempo, não temos dinheiro")
            return
        else
            cooldownEndsAtTimeStamp = 0
        end

        local numTroopers = #API.getUsersByGroup("trooper")

        if 6 < 5 then
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Este banco não pode ser roubado, polícia insuficiente.")
            return
        end

        indexBeingRobbed = index
        indexBeingRobbed_playerSourceWhoStarted = _source

        local numParticipants = 0
        local maxParticipants = data[index].staticMaxParticipants
        local numParticipantsToCheck = #participants

        countdownRobberyTime()

        for _, playerSource in pairs(GetPlayers()) do
            playerSource = tonumber(playerSource)
            local isParticipant = false
            if numParticipantsToCheck > 0 then
                for _, participantSource in pairs(participants) do
                    if playerSource == participantSource then
                        numParticipantsToCheck = numParticipantsToCheck - 1
                        isParticipant = true
                        -- if numParticipants < maxParticipants then
                        numParticipants = numParticipants + 1
                        TriggerClientEvent("FRP:ROBBERY:StartRobbery", participantSource, index, true, indexBeingRobbed_seconds)
                        participants[participantSource] = true
                    --      API.logs("./savedata/roubobanco.txt","[USUARIOID]: "..Character:getId().. "Iniciou o roubo")
                    -- else
                    --     TriggerClientEvent("FRP:ROBBERY:StartRobberyAsBlocked", participantSource, index)
                    -- end
                    end
                end
            end

            if isParticipant == false then
                TriggerClientEvent("FRP:ROBBERY:StartRobbery", playerSource, index, false, nil)
            end

            isParticipant = nil
        end

        API.NotifyUsersWithGroup("trooper", "Um assalto começou no banco " .. data[index].staticName)
    end
)

function countdownRobberyTime()
    indexBeingRobbed_seconds = data[indexBeingRobbed].staticSecondsToReward

    Citizen.CreateThread(
        function()
            while indexBeingRobbed ~= nil do
                Citizen.Wait(1000)
                if indexBeingRobbed ~= nil then
                    indexBeingRobbed_seconds = indexBeingRobbed_seconds - 1

                    if indexBeingRobbed_seconds == 0 then
                        -- for _, participantSource in pairs(indexBeingRobbed_participants) do
                        --     TriggerClientEvent('FRP:TOAST:New', participantSource, 'alert', indexBeingRobbed .. ' secs')
                        -- end

                        endRobberyGiveReward()
                    end
                end
            end
        end
    )
end

function endRobberyGiveReward()
    local _source = nil

    if indexBeingRobbed == nil then
        return
    end

    robberyBeingEnded = true

    local User

    if indexBeingRobbed_playerSourceWhoStarted ~= nil then
        User = API.getUserFromSource(indexBeingRobbed_playerSourceWhoStarted)
        _source = indexBeingRobbed_playerSourceWhoStarted
        TriggerClientEvent("FRP:ROBBERY:Bolsa", _source)
    end

    for participantSource, _ in pairs(indexBeingRobbed_participants) do
        local p_User = API.getUserFromSource(participantSource)

        local user_id = p_User:getId()

        TriggerEvent("FRP:COMBATLOG:AddUserCombatReason", user_id, 300, "Roubo a Banco")

        if User == nil then
            _source = participantSource
            User = p_User
        end
    end

    if User ~= nil then
        TriggerClientEvent("FRP:ROBBERY:Bolsa", _source)

        local Character = User:getCharacter()

        if Character ~= nil then
            local reward = math.random(20000, data[indexBeingRobbed].staticReward)
            Character:getInventory():addItem("money", reward)
            -- User:notify("success", "Você recebeu R$ " .. reward .. " pelo assalto")
            User:notify("item", "money", reward / 100)
        end
    end

    cooldownEndsAtTimeStamp = os.time() + (cCooldown * 60 * 1000)

    indexBeingRobbed = nil
    indexBeingRobbed_seconds = 0
    indexBeingRobbed_participants = {}
    robberyBeingEnded = false

    TriggerClientEvent("FRP:TOAST:New", -1, "alert", "O assalto acabou!")
    TriggerClientEvent("FRP:ROBBERY:EndRobbery", -1)
end

RegisterNetEvent("FRP:ROBBERY:PlayerAbandonedRobbery")
AddEventHandler(
    "FRP:ROBBERY:PlayerAbandonedRobbery",
    function()
        if indexBeingRobbed == nil then
            return
        end

        local _source = source

        if indexBeingRobbed_playerSourceWhoStarted == _source then
            indexBeingRobbed_playerSourceWhoStarted = nil
        end

        indexBeingRobbed_participants[_source] = nil

        if #indexBeingRobbed_participants <= 0 and not robberyBeingEnded then
            cooldownEndsAtTimeStamp = os.time() + (cCooldown * 60 * 1000)

            indexBeingRobbed = nil
            indexBeingRobbed_seconds = 0
            indexBeingRobbed_participants = {}
            robberyBeingEnded = false

            TriggerClientEvent("FRP:ROBBERY:EndRobbery", -1)
        end

        API.NotifyUsersWithGroup("trooper", "-1 Assaltante")

        -- print("Player " .. _source .. " left the robbery")
        -- TriggerClientEvent('FRP:Notify', _source, "O " .. _source .. " left the robbery")
    end
)

AddEventHandler(
    "playerDropped",
    function(source, reason)
        if indexBeingRobbed_participants[source] ~= nil then
            TriggerEvent("FRP:ROBBERY:PlayerAbandonedRobbery", source)
            API.NotifyUsersWithGroup("trooper", "-1 Assaltante")
        end
    end
)
