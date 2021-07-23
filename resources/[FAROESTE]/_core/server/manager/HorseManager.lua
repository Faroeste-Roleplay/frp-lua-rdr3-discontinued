RegisterNetEvent('FRP:HORSE:OpenInventory')
AddEventHandler('FRP:HORSE:OpenInventory', function()
    local _source = source
    local User = API.getUserFromSource(_source)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if Character == nil then
        return
    end

    local Horse, components = Character:getHorse()

    if Horse ~= nil then
        User:viewInventory()

        local HorseInventory = Horse:getInventory()

        User:viewInventoryAsSecondary(HorseInventory)
    end
end)