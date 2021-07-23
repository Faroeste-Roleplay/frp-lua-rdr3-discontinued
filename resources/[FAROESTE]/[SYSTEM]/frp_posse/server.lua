local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
API_DB = Proxy.getInterface("API_DB")
cAPI = Tunnel.getInterface("API")

RegisterCommand(
    "bando",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        if User:isInAPosse() then
            local data = {}
            local Posse = API.getPosse(User:getPosseId())
            for memberCharId, rank in pairs(Posse:getMembers()) do
                local name = API.getNameById(memberCharId)
                local isOnline = false
                local UserMember = API.getUserFromCharId(memberCharId)
                -- local CharLevel = UserMember:getCharacter():getLevel()
                local CharLevel = 0

                if UserMember ~= nil and UserMember:getCharacter():getId() == tonumber(memberCharId) then
                    isOnline = true
                end

                data[memberCharId] = {
                    UserID = UserMember:getId(),
                    rank = rank,
                    name = name,
                    level = CharLevel,
                    isOnline = isOnline
                }
            end
            TriggerClientEvent("FRP:POSSE:OpenMenu", source, data, Posse:getName())
        else
            -- else
            --     User:notify('Você não tem permissao para criar um Bando')
            -- end
            -- if User:getCharacter():hasGroup('donator01') then
            TriggerClientEvent("FRP:POSSE:OpenCreationMenu", source)
        end
    end,
    false
)

RegisterCommand(
    "convidar",
    function(source, args)
        local arg = args[1]
        TriggerEvent("FRP:POSSE:Invite", source, arg)
    end
)

RegisterNetEvent("FRP:POSSE:checkBando")
AddEventHandler(
    "FRP:POSSE:checkBando",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local level = Character:getLevel()

        if not User:isInAPosse() then
            if level < 10 then
                User:notify("Para criar um bando você precisa ter level maior que 10")
                return
            end
            TriggerEvent("FRP:POSSE:createBando", _source)
        else
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Você já está em um bando, para criar um novo deve sair do atual.", 5000)
        end
    end
)

RegisterNetEvent("FRP:POSSE:createBando")
AddEventHandler(
    "FRP:POSSE:createBando",
    function(source)
        local _source = source
        local PosseName = cAPI.prompt(source, "Nome do seu Bando", "")

        local User = API.getUserFromSource(_source)

        if PosseName == "" then
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Você não digitou um nome válido", 5000)
            return
        end
        API.createPosse(User:getCharacter():getId(), PosseName)
        TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Registro do " .. PosseName .. " efetuado com Sucesso.", 5000)
    end
)

RegisterNetEvent("FRP:POSSE:Invite")
AddEventHandler(
    "FRP:POSSE:Invite",
    function(source, targetUserId)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Posse = API.getPosse(User:getPosseId())

        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local UserTarget = API.getUserFromSource(TargetSource)
        local userRank = Posse:getMemberRank(Character:getId())

        if userRank == 3 then
            User:notify("Somente um membro de cargo superior pode conviar para o bando")
            return
        end

        if UserTarget == nil then
            User:notify("Usuario de id " .. targetUserId .. " não está online")
            return
        end

        if UserTarget:isInAPosse() then
            User:notify("Usuario de id " .. targetUserId .. " já se encontra em um bando!")
            return
        end

        User:notify("Você convidou o ID " .. targetUserId .. " para entrar no bando")

        UserTarget:notify("Você foi convidado a entrar no bando.")

        local yes = cAPI.request(TargetSource, "Convite para o Bando " .. Posse:getName() .. " ?", 30)

        if yes then
            UserTarget:notify("Você entrou no bando " .. Posse:getName())
            Posse:addMember(UserTarget, 3)
        else
            User:notify("User " .. targetUserId .. " recusou o convite")
        end
    end
)

RegisterNetEvent("FRP:POSSE:Promote")
AddEventHandler(
    "FRP:POSSE:Promote",
    function(targetUserId)
        local _source = source
        local User = API.getUserFromSource(_source)

        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local UserT = API.getUserFromSource(TargetSource)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local TCharacter = UserT:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        if not Posse:isAMember(TCharacter:getId()) then
            User:notify(TCharacter:getName() .. " não faz mais parte do bando")
            return
        end

        local targetRank = Posse:getMemberRank(TCharacter:getId())
        if targetRank <= 2 then
            User:notify(TCharacter:getName() .. " já está no rank mais alto")
            return
        end

        local userRank = Posse:getMemberRank(Character:getId())

        if userRank <= 2 then
            if userRank == targetRank then
                User:notify("Somente um membro de cargo superior pode promover este membro")
                return
            end

            Posse:promoteMember(TCharacter:getId())
            Posse:notifyMembers(TCharacter:getName() .. " foi promovido no Bando!")
        end
    end
)

RegisterNetEvent("FRP:POSSE:Demote")
AddEventHandler(
    "FRP:POSSE:Demote",
    function(targetUserId)
        local _source = source
        local User = API.getUserFromSource(_source)

        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local UserT = API.getUserFromSource(TargetSource)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local TCharacter = UserT:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        if not Posse:isAMember(TCharacter:getId()) then
            User:notify(TCharacter:getName() .. " não faz mais parte do bando")
            return
        end

        local targetRank = Posse:getMemberRank(TCharacter:getId())
        if targetRank == 3 then
            User:notify(charName .. " já está no rank mais baixo!")
            return
        end

        local userRank = Posse:getMemberRank(Character:getId())

        if userRank <= 2 then
            if userRank == targetRank then
                User:notify("Somente um membro de cargo superior pode rebaixar este membro")
                return
            end

            Posse:demoteMember(TCharacter:getId())
            Posse:notifyMembers(TCharacter:getName() .. " foi rebaixado no Bando!")
        end
    end
)

RegisterNetEvent("FRP:POSSE:Leave")
AddEventHandler(
    "FRP:POSSE:Leave",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        Posse:removeMember(Character:getId())
        Posse:notifyMembers(Character:getName() .. " saiu do bando!")

        User:notify("Você saiu do bando!")
    end
)

RegisterNetEvent("FRP:POSSE:Kick")
AddEventHandler(
    "FRP:POSSE:Kick",
    function(targetUserId)
        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local User = API.getUserFromSource(TargetSource)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        Posse:removeMember(Character:getId())
        Posse:notifyMembers(Character:getName() .. " foi removido do bando!")

        User:notify("Você foi removido do bando!")
    end
)
