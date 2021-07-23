local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- local Locations = {
--     [1] = {vector3(-4219.9692382813, -3460.451171875, 37.817359924316), 46},
--     [2] = {vector3(347.75500488281, 1484.5426025391, 179.63270568848), 26}-- VALENTINE
-- }

local s_ledgerIndex

local balance = {
    primary = 0.0,
    secondary = 0.0
}

local isBalanceShowing = false

Citizen.CreateThread(
    function()
        local request_delay = 2000
        local next_request_at = GetGameTimer()

        local sleep = 1000

        -- ledger_ct

        Citizen.InvokeNative(0x83B8D50EB9446BBA, PlayerPedId(), 1)

        -- CatalogAnimScene()

        while true do
            Citizen.Wait(sleep)

            local playerPed = PlayerPedId()
            local playerPosition = GetEntityCoords(playerPed)

            s_ledgerIndex = nil

            for i, data in pairs(Config.LEDGERS) do
                local position = data.position

                if #(playerPosition - position) <= 10.0 then
                    -- local balance = data.balance

                    -- SetNuiBalance(balance)

                    s_ledgerIndex = i
                    break
                end
            end

            if s_ledgerIndex then
                sleep = 0

                if IsControlJustPressed(0, 0x05CA7C52) then -- DOWNN_ARROW
                    -- if GetGameTimer() >= next_request_at then
                    -- TriggerServerEvent("FRP:FORT:RequestUnlocks")
                    TriggerEvent("FRP:FORT:RespondToUnlocksRequest", {})

                    next_request_at = GetGameTimer() + request_delay
                -- else
                --     print("Wait " .. ((next_request_at - GetGameTimer()) / 1000) .. " till next request")
                -- end
                end

                if not isBalanceShowing then
                    isBalanceShowing = true

                    SendNUIMessage(
                        {
                            type = "show",
                            data = "info"
                        }
                    )
                end
            else
                if isBalanceShowing then
                    isBalanceShowing = false

                    SendNUIMessage(
                        {
                            type = "hide",
                            data = "info"
                        }
                    )
                end
            end
        end
    end
)

function UpdateBalance(primary, secondary)
    balance = {
        primary = primary,
        secondary = secondary
    }

    SendNUIMessage(
        {
            type = "data",
            balance_primary = primary,
            balance_secondary = secondary
        }
    )
end

RegisterNetEvent("FRP:FORT:RespondToUnlocksRequest")
AddEventHandler(
    "FRP:FORT:RespondToUnlocksRequest",
    function(response)
        print("Got response")

        local unlocks = deepcopy(Config.UNLOCKS)

        for _, unlock_id in pairs(response) do
            for index, u_data in pairs(Config.UNLOCKS) do
                local u_id = u_data.id

                if u_id == unlock_id then
                    unlocks[index].unlocked = true
                end
            end
        end

        SendNUIMessage(
            {
                type = "show",
                data = "unlocks"
            }
        )

        SendNUIMessage(
            {
                type = "data",
                unlocks = unlocks
            }
        )
    end
)

RegisterNetEvent("FRP:FORT:SetPlayerBalance")
AddEventHandler(
    "FRP:FORT:SetPlayerBalance",
    function(primary, secondary)
        balance = {
            primary = primary,
            secondary = secondary
        }

        if isBalanceShowing then
            SendNUIMessage(
                {
                    type = "data",
                    balance = balance
                }
            )
        end
    end
)

function CatalogAnimScene()
    local playerPed = PlayerPedId()
    local propHash = GetHashKey("s_campledger01x")
    propHash = -805634630

    if not HasModelLoaded(propHash) then
        RequestModel(propHash)
        while not HasModelLoaded(propHash) do
            Citizen.Wait(0)
        end
    end

    local nameRender = "ledger_ct"
    if IsNamedRendertargetRegistered(nameRender) == 0 then
        RegisterNamedRendertarget(nameRender, false)
        LinkNamedRendertarget(propHash)
        if IsNamedRendertargetLinked(propHash) then
            print("Render target linked to propHahs")
        else
            if IsNamedRendertargetRegistered(nameRender) then
                ReleaseNamedRendertarget(nameRender)
                print("Render target released")
            end

            print("Returning")
            return
        end
    end

    print(GetLabelText("MCCLELLAN_01_IMPROVED_SADDLE_CATALOGUEDESC"))

    local renderId = GetNamedRendertargetRenderId(nameRender)
    SetTextRenderId(renderId)
    SetScriptGfxDrawOrder(4)

    print(nameRender, renderId)

    SetTextColor(255, 0, 0, 255)

    -- Citizen.InvokeNative(0x9D37EB5003E0F2CF, renderId, 1);

    local prop = CreateObject(propHash, GetEntityCoords(playerPed), false, false, false)

    DrawRect(0.5, 0.5, 2.0, 2.0, 0, 0, 0, 255, false, true)

    DisplayText(CreateVarString(10, "LITERAL_STRING", "Toma"))

    SetTextRenderId(1)
    local released = ReleaseNamedRendertarget(nameRender)

    print("Released", released)

    PlaceObjectOnGroundProperly(prop)

    local animScene = CreateAnimScene("script@ambient@shop@CATALOG_PLAYER", 0, "PBL_ENTER", false, true)

    LoadAnimScene(animScene)
    SetAnimSceneEntity(animScene, "player", playerPed, 0)
    SetAnimSceneEntity(animScene, "CATALOG", prop, 0)
    SetAnimSceneOrigin(animScene, GetEntityCoords(playerPed) - vec3(0, 0, 0.97), 0.0, 2)

    Citizen.InvokeNative(0xDF7B5144E25CD3FE, animScene, "PBL_ENTER")
    SetAnimScenePlaybackList(animScene, "PBL_ENTER", true)

    Wait(2000)

    TaskEnterAnimScene(playerPed, animScene, "player", "PBL_ENTER", 1069379748, true, 128, 20000, -1082130432)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SendNUIMessage(
                {
                    type = "hide",
                    data = "all"
                }
            )
        end
    end
)
