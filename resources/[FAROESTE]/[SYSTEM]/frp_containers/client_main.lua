local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

ItemPoolHash = {}

function joaat(t)
    return exports["frp_containers"]:js_joaat(t)
end

Citizen.CreateThread(
    function()
        for itemId, _ in pairs(ItemPool) do
            ItemPoolHash[joaat(itemId)] = itemId
        end

        -- print(json.encode(ItemPoolHash))

        Wait(1000)

        SendNUIMessage(
            {
                messageType = "updateItemPool",
                message = ItemPool,
                message2 = ItemPoolHash
            }
        )

        Wait(1000)
        FakeLoadInventoryItems()
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xC1989F95) then
                if inAShop then
                    draw("shop")
                end
                draw("inventory")
                -- draw('extra')
                -- draw('trade-player')
                -- draw('trade-trader')
                draw("crafting")
            -- draw("shop")

            -- ContainerTryToAddItem("inventory", {"w_lasso"})

            -- Wait(2000)

            -- ContainerTryToRemoveItem("inventory", "w_lasso", 1)
            end
        end
    end
)

Containers = {}

Containers["inventory"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 9 * 3, -- 27
    containerTitle = "Inventory",
    containerIsOpen = false,
    containerHasPages = true,
    -- containerMaxWeight = 20.0
}

Containers["hotbar"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 4
}

Containers["extra"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 9 * 3, --- 27
    containerTitle = "Extra",
    containerIsOpen = false,
    containerHasPages = true
}

Containers["crafting"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = (3 * 3) + 1, -- 10
    containerTitle = "Crafting",
    containerIsOpen = false
    -- containerExtraCraftingGroup = 0,
}

Containers["shop"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 5 * 3, -- 15
    containerTitle = "Shop",
    containerIsOpen = false
}

Containers["trade-player"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 4 * 2, -- 8
    containerTitle = "You",
    containerIsOpen = false
}

Containers["trade-trader"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 4 * 2, -- 8
    containerTitle = "key_value",
    containerIsOpen = false
}

function draw(container)
    Containers[container].containerIsOpen = true

    -- Atualizar as armas da hotbar quando atualizar ela !!
    if container == "hotbar" then
        ContainerHotbarOnDraw()
    else
        if container == "inventory" then
            ContainerSetTitle("inventory", "Inventário " .. ContainerGetWeight(container) .. "/" .. ContainerGetMaxWeight(container))
        end

        if container == "crafting" then
            ContainerCraftingComputeOutput()
        end
    end

    local cData = Containers[container]
    local message = {
        messageType = "drawContainer",
        container = container,
        containerItemPool = cData.containerItemPool,
        containerNumIndexes = cData.containerNumIndices,
        containerActivePage = cData.containerActivePage
    }

    if cData.containerTitle then
        message.containerTitle = cData.containerTitle
    end

    if cData.containerMaxWeight then
        message.containerMaxWeight = cData.containerMaxWeight
    end
    SendNUIMessage(message)

    if container ~= "hotbar" then
        SetNuiFocus(true, true)
    end
end

function drawCraftingOutput(itemHash, itemAmount)
end

function stopdrawing(container)
    Containers[container].containerIsOpen = false

    SendNUIMessage(
        {
            messageType = "hide",
            container = container
        }
    )
end

RegisterNUICallback(
    "container_changepage",
    function(cb)
        local container = cb.container
        local activepage = cb.activepage

        Containers[container].containerActivePage = activepage

        draw(container)
    end
)

RegisterNUICallback(
    "container_dropdraggable",
    function(cb)
        local container_from = cb.container_from
        local container_to = cb.container_to

        local dragType = cb.dragType

        local slot_from = tonumber(cb.slot_from)
        local slot_to = tonumber(cb.slot_to)

        local itemContainerData_from = Containers[container_from].containerItemPool[slot_from]
        local itemContainerData_to = Containers[container_to].containerItemPool[slot_to]

        local itemHash_from = ContainerGetItemHashAtIndex(container_from, slot_from)
        local itemHash_to = ContainerGetItemHashAtIndex(container_to, slot_to)

        if IsThrownInvalidException(itemHash_from) then
            --[[
                O item que a gente tá mexendo é invalido por algum motivo :shrug:
                atualizar o container
            ]]
            draw(container_from)
            return
        end

        -- if  ContainerIsItemValidForIndex(container_to, itemHash_from, slot_to) or not ContainerIsItemValidForIndex(container_from, itemHash_to, slot_from) then
        --     draw(container_from)
        --     return
        -- end

        local itemType_from = ItemGetType(itemHash_from)
        local itemType_to = ItemGetType(itemHash_to)

        -- O item que a gente está tentando mover existe, então
        -- continua a execuçao do codigo
        -- if IsThrownInvalidException(itemHash_from) == false then
        if container_to == "inventory" then
            if container_from == "inventory" then -- Troca de slots do inventario para o inventario
                if not ContainerIsItemValidForIndex(container_to, itemHash_from, slot_to) or not ContainerIsItemValidForIndex(container_from, itemHash_to, slot_from) then
                    draw(container_from)
                    return
                end

                print("invald", IsThrownInvalidException(itemHash_to))

                local amountAtIndex_from = Containers["inventory"].containerItemPool[slot_from][2]

                --[[
                    Verifica se o slot que a gente que mover o item para está desocupado,
                    se estiver, verifica se ele é um item divisivel e com quantidade maior que 1
                    entao faz as funçoes necessarias
                ]]
                if IsThrownInvalidException(itemHash_to) and ItemIsStackable(itemHash_from) and amountAtIndex_from > 1 then
                    print(dragType)
                    if dragType == 17 then -- SINGLE
                        --[[
                            Tira 1 do nosso item e cria um novo item com quantidade 1 no slot desejado
                        ]]
                        Containers["inventory"].containerItemPool[slot_from][2] = amountAtIndex_from - 1
                        local copy = deepcopy(Containers["inventory"].containerItemPool[slot_from])
                        copy[2] = 1
                        Containers["inventory"].containerItemPool[slot_to] = copy
                    elseif dragType == 16 then -- HALF
                        --[[
                            Divide a quantidade do nosso item pela metade, sendo o primeiro numero o maior
                            e o segundo o menor, caso ele seja impar
                        ]]
                        print((amountAtIndex_from / 2), math.ceil((amountAtIndex_from / 2)), math.floor((amountAtIndex_from / 2)))
                        Containers["inventory"].containerItemPool[slot_from][2] = math.ceil(amountAtIndex_from / 2)
                        local copy = deepcopy(Containers["inventory"].containerItemPool[slot_from])
                        copy[2] = math.floor((amountAtIndex_from / 2))
                        Containers["inventory"].containerItemPool[slot_to] = copy
                    else
                        switchContainerSlots({"inventory", slot_to}, {"inventory", slot_from})
                    end
                else
                    --[[
                        Slot que o nosso item foi movido não está vago, então
                        a gente verifica se os items são iguais, se forem a gente adiciona ao valor atual
                        caso não seja, a gente só substitui o item
                    ]]
                    if itemHash_from == itemHash_to then
                        if ItemIsStackable(itemHash_from) then
                            local itemMaxStackSize = ItemGetMaxStackSize(itemHash_from)

                            local itemAmount_from = Containers["inventory"].containerItemPool[slot_from][2]
                            local itemAmount_to = Containers["inventory"].containerItemPool[slot_to][2]

                            if itemAmount_from + itemAmount_to > itemMaxStackSize then
                                switchContainerSlots({"inventory", slot_to}, {"inventory", slot_from})
                            else
                                Containers["inventory"].containerItemPool[slot_from] = nil
                                Containers["inventory"].containerItemPool[slot_to][2] = itemAmount_to + itemAmount_from
                            end
                        else
                            switchContainerSlots({"inventory", slot_to}, {"inventory", slot_from})
                        end
                    else
                        --[[
                            O item não é igual ao outro, então só troca de slot um com o outro
                        ]]
                        switchContainerSlots({"inventory", slot_to}, {"inventory", slot_from})
                    end
                end

            -- TriggerServerEvent("FRP:CONTAINERS:INVENTORY:TryToSwitchSlot", slot_from, slot_to)
            end

            --[[
                    Tirando item da hotbar para enviar para o inventario
                ]]
            if container_from == "hotbar" then
                if not ContainerIsItemValidForIndex(container_to, itemHash_from, slot_to) or not ContainerIsItemValidForIndex(container_from, itemHash_to, slot_from) then
                    draw(container_from)
                    return
                end

                --[[
                    Não há nenhum item no slot onde eu quero colocar o item
                ]]
                switchContainerSlots({"inventory", slot_to}, {"hotbar", slot_from})
            --[[
                    Verificar caso esteja trocando com outra arma, fazer a troca completa
                ]]
            end

            if container_from == "shop" then
                --[[
                    A loja não precisa de verificação de se nosso item está
                    sendo movido para o slot correto ou não, então se o item
                    for devidamente comprado, comprindo os requerimentos de 
                    espaço necessario, ele será adicionado ao inventário
                ]]
                -- TriggerServerEvent "TryToBuyItem"
                -- Containers["inventory"].containerItemPool[slot_to] = Containers["shop"].containerItemPool[slot_from]
                local shopItem = Containers["shop"].containerItemPool[slot_from]
                local shopItemHash = shopItem[1]
                local shopItemAmount = shopItem[2]
                local shopItemPriceDolar = shopItem[3]
                local shopItemPriceGold = shopItem[4]

                if ContainerTryToAddItem(container_to, {shopItemHash, shopItemAmount}) then
                    print("comprou")
                else
                    print("Ocorreu um erro durante a compra!")
                end
            end

            if container_from == "crafting" then
                switchContainerSlots({"crafting", slot_from}, {"inventory", slot_to})
            end
        end

        if container_to == "hotbar" then
            if container_from == "inventory" then
                --[[
                    A gente está movendo nosso item do inventário para a hotbar,
                    se o slot estiver vazio e nosso item for valido para esse
                    slot da hotbar, ele será adicionado
                ]]
                if IsThrownInvalidException(itemHash_to) then
                    --[[
                        O item não é valido para esse slot, retorna
                    ]]
                    if not ContainerIsItemValidForIndex(container_to, itemHash_from, slot_to) or not ContainerIsItemValidForIndex(container_from, itemHash_to, slot_from) then
                        draw(container_from)
                        return
                    end

                    switchContainerSlots({"hotbar", slot_to}, {"inventory", slot_from})
                else
                    --[[
                        O slot target não está vazio, faz as verificaçoes necessarias
                    ]]
                    --[[
                        Nosso item é valido para esse slot, faz a troca
                    ]]
                    if ContainerIsItemValidForIndex("hotbar", itemHash_from, slot_to) then -- Trocou uma arma de lugar com a outra na hotbar para o inventario
                        switchContainerSlots({"hotbar", slot_to}, {"inventory", slot_from})
                    elseif itemType_from == "ammo" then -- Dropou munição em cima de uma arma na hotbar, para recarregar
                        --[[
                            O tipo do nosso item é `ammo` então ele adiciona a munição de uma arma já equipada
                            a gente retira da quantidade do nosso item e adiciona à arma equipada
                            PARAR DE USAR ISSO???
                        ]]
                        if itemType_to == "weapon" then
                            local itemId_from = ItemGetIdFromHash(itemHash_from)
                            local itemId_to = ItemGetIdFromHash(itemHash_to)
                            local weaponModel = itemId_to:gsub("w_", "weapon_")

                            --[[
                                Verifica se a arma no slot target aceita a munição que
                                o nosso item é
                            ]]
                            if doesWeaponAcceptsAmmo(weaponModel, itemId_from) then
                                local weaponHash = GetHashKey(weaponModel)

                                local ammoWeaponToIncrease = Containers["inventory"].containerItemPool[slot_from]
                                local oldWeaponAmmoCount = Containers["hotbar"].containerItemPool[slot_to][3]

                                Containers["inventory"].containerItemPool[slot_from] = nil
                                Containers["hotbar"].containerItemPool[slot_to][3] = oldWeaponAmmoCount + ammoWeaponToIncrease
                            end
                        end
                    end
                end
            end
        end

        if container_to == "crafting" then
            if container_from == "inventory" then
                print("to craft", slot_to)

                if slot_to ~= 10 then
                    --[[
                        Se o slot não for o output, continua
                    ]]
                    switchContainerSlots({"crafting", slot_to}, {"inventory", slot_from})
                end
            end

            if container_from == "crafting" then
                --[[
                    Poder mover do crafting para o crafting
                    mas não pode mover do output para o crafting
                    e vice-versa
                ]]
                if slot_from ~= 10 and slot_from ~= 10 then
                    switchContainerSlots({"crafting", slot_to}, {"crafting", slot_from})
                end
            end
        end

        -- end

        draw(container_from)
        draw(container_to)
    end
)

RegisterNUICallback(
    "focusoff",
    function(cb)
        SetNuiFocus(false, false)

        for container, d in pairs(Containers) do
            -- if container ~= "hotbar" then
            Containers[container].containerIsOpen = false
            -- end
            if container == "crafting" then
                if #ContainerGetItemPool("crafting") > 0 then
                    local requestInventoryUpdate = true
                    Containers["crafting"].containerItemPool = {}
                end
            end
        end
    end
)

function switchContainerSlots(st1, st2)
    local copy1 = Containers[st1[1]].containerItemPool[st1[2]]

    Containers[st1[1]].containerItemPool[st1[2]] = Containers[st2[1]].containerItemPool[st2[2]]
    Containers[st2[1]].containerItemPool[st2[2]] = copy1
end

function doesWeaponAcceptsAmmo(weaponModel, ammoModel)
    return true
end

function FakeLoadInventoryItems()
    Containers["inventory"].containerItemPool = {
        [82] = {
            joaat("w_shotgun_doublebarrel"),
            0,
            1
        },
        [83] = {
            joaat("a_shotgun"),
            20
        },
        [84] = {
            joaat("w_lasso")
        }
    }

    Containers["hotbar"].containerItemPool = {
        [1] = {
            joaat("w_shotgun_doublebarrel"),
            0,
            0
        },
        [3] = {
            joaat("w_molotov")
        },
        [4] = {
            joaat("w_lasso")
        }
    }

    -- draw('inventory')
    draw("hotbar")
end

function IsThrownInvalidException(v)
    if tonumber(v) == nil and v:find("invalid") then
        return true
    end

    return false
end

function ContainerHotbarOnDraw()
    -- cAPI.replaceWeapons({})
    for _, v in pairs(Containers["hotbar"].containerItemPool) do
        local itemId = ItemPoolHash[v[1]]
        local itemAmmoInClip = v[2] or 1
        local itemAmmoInWeapon = v[3] or 1
        local weaponModel = itemId:gsub("w_", "weapon_")
        local weaponHash = GetHashKey(weaponModel)

        -- print("gave weapon", weaponModel)

        GiveWeaponToPed(PlayerPedId(), weaponHash, itemAmmoInWeapon, false, false)
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() or resourceName == "_core" then
            SetNuiFocus(false, false)
            SendNUIMessage(
                {
                    messageType = "hide"
                }
            )
        end
    end
)

function ContainerCraftingComputeOutput()
    local container = "crafting"
    Containers[container].containerItemPool[10] = nil

    local craftingItemPool = ContainerGetItemPool(container)

    local outputItemHash
    local outputItemAmount

    for cid, v in pairs(CraftablePool) do
        local numInputs = 0

        --[[
                        Numero de items no crafting é igual ao necessario
                        para craftar o item nessa iteraçao!
                    ]]
        local drawOutput = true
        for cinput, camount in pairs(v.input) do
            numInputs = numInputs + 1
            print('Getting amount of item', cinput, 'min', camount)
            print('got', ContainerGetAmountOfItem(container, cinput))
            if ContainerGetAmountOfItem(container, cinput) < camount then
                drawOutput = false
                break
            end
        end

        print(drawOutput,#craftingItemPool, numInputs)
        if getTableSize(craftingItemPool) == numInputs and drawOutput then
            --[[
                            Nosso possivel crafting foi achado, break o loop
                            e continua a função na NUI
                        ]]
            outputItemHash = ItemGetHashFromId(v.output[1])
            outputItemAmount = v.output[2]

            print('Output do crafting achado!' , outputItemHash, outputItemAmount)

            Containers[container].containerItemPool[10] = {outputItemHash, outputItemAmount}

            break
        end
    end
end


function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end