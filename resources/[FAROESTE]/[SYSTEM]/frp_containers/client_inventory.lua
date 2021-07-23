-- InventoryItemPool = {}

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             if IsControlJustPressed(0, 0xC1989F95) then
--                 if #InventoryItemPool <= 0 then
--                     InventoryItemPool = {
--                         [10] = {
--                             joaat("w_shotgun_doublebarrel"),
--                             0,
--                             0
--                         },
--                         [7] = {
--                             joaat("a_shotgun"),
--                             20
--                         },
--                         [1] = {
--                             joaat("w_lasso")
--                         }
--                     }
--                 end

--                 SendNUIMessage(
--                     {
--                         messageType = "drawContainer",
--                         message = "inventory",
--                         message2 = InventoryItemPool
--                     }
--                 )

                
--                 SendNUIMessage(
--                     {
--                         messageType = "drawContainer",
--                         message = "hotbar",
--                         message2 = {}
--                     }
--                 )
                
--                 SetNuiFocus(true, true)
--             end
--         end
--     end
-- )

-- RegisterNUICallback(
--     "container_inventory_switch",
--     function(cb)
--         print(json.encode(InventoryItemPool))

--         local slotId_from = tonumber(cb.slotId_from)
--         local slotId_to = tonumber(cb.slotId_to)

--         print(slotId_from, slotId_to)

--         local temp_2 = InventoryItemPool[slotId_to]

--         InventoryItemPool[slotId_to] = InventoryItemPool[slotId_from]
--         InventoryItemPool[slotId_from] = temp_2

--         print(json.encode(InventoryItemPool))
--     end
-- )

