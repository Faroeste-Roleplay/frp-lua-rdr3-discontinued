local positions = {
    vec3(-1204.810, -1686.396, 75.926)
}

local scenarios = {}
local animScene
local barrow

function PopulateManurePickup()
    local ped = PlayerPedId()
    local pedPosition = GetEntityCoords(ped)

    local scenarioType = "WORLD_PLAYER_CHORES_PITCH_FORK_PICKUP_PUTDOWN"
    local scenarioTypeHash = GetHashKey(scenarioType)

    for _, position in pairs(positions) do
        local hasCollision, groundZ, normal = GetGroundZAndNormalFor_3dCoord(position.x, position.y, position.z)

        if hasCollision then
            position = vec3(position.xy, groundZ)
            if NativeFindClosestActiveScenarioPointOfType(scenarioTypeHash, position, 2.0) == 0 then
                local scenario = NativeCreateScenarioPoint(scenarioTypeHash, position, 180.0)
                table.insert(scenarios, scenario)
            end
        end
    end
end

function GetPopulationManurePickup()
    return scenarios
end

RegisterCommand(
    "manure",
    function()
        local ped = PlayerPedId()
        --         -- Citizen.InvokeNative(0x604E1010E3162E86, ped, "PITCH_FORKS", "PITCH_FORKS")

        --         -- Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, "carry_pitchfork")

        --         -- Citizen.InvokeNative(0x3A50753042B6891B, ped, "PITCH_FORKS")

        --         -- Citizen.InvokeNative(0xDE7B2B4144906CDF, -427938131, ped)
        --         -- InitiatePrompt()

        barrow = CreateObject(GetHashKey("p_wheelbarrow02x"), GetEntityCoords(PlayerPedId()) + vec3(2.0, 0, -0.97), true, true, false)

        --         -- p_wheelbarrow02x
        animScene = CreateAnimScene("script@story@mar5@ig@s1_ig3@s1_ig3_clean_stalls_jack", 0, 0, false, true)
        SetAnimSceneRate(animScene, 1.0)
        Citizen.InvokeNative(0x15598CFB25F3DC7E, animScene, "pl_IG3_POINT_C_TO_POINT_A", true)
        if not Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animScene, 0) then
            SetAnimSceneEntity(animScene, "Jack", PlayerPedId(), 0)
            SetAnimSceneEntity(animScene, "p_wheelbarrow02x", barrow, 0)
            StartAnimScene(animScene)
        end

        -- TaskEnterAnimScene(PlayerPedId(), animScene, "Jack", "pl_IG3_POINT_A_TO_POINT_B", 1.0, false, 1, 20000, -1082130432)
    end,
    false
)

local prompt

function InitiatePrompt()
    Citizen.InvokeNative(0xF66090013DE648D5, "MGCLS")

    Wait(1000)

    -- Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Você está morto.")

    if prompt ~= nil then
        PromptDelete(prompt_respawn)
    end

    prompt = NewPrompt()
    -- 0xE8342FF2
    PromptSetControlAction(prompt, 0x7F8D09B8)
    PromptSetText(prompt, "MGCLS_UC_PICK")
    PromptSetStandardMode(prompt, true)
    PromptSetEnabled(prompt, 1)
    PromptSetVisible(prompt, 1)
    PromptSetHoldMode(prompt, 1)
    -- N_0x0c718001b77ca468(prompt, 3.0)
    -- PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            PromptDelete(prompt)
            Citizen.InvokeNative(0x84EEDB2C6E650000, animScene)
            DeleteEntity(barrow)
        end
    end
)
