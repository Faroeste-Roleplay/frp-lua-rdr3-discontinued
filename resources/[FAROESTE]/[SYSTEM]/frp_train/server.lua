-- local PlayerCount = 0
-- local list = {}

-- RegisterServerEvent("train:playerActivated")

-- function ActivateTrain()
--   if (PlayerCount) == 1 then
--     TriggerClientEvent("Trainroute", GetHostId())
--   else
--     SetTimeout(15000, ActivateTrain)
--   end
-- end

-- AddEventHandler(
--   "train:playerActivated",
--   function()
--     if not list[source] then
--       PlayerCount = PlayerCount + 1
--       list[source] = true
--       if (PlayerCount) == 1 then
--         SetTimeout(15000, ActivateTrain)
--       end
--     end
--   end
-- )

-- AddEventHandler(
--   "playerDropped",
--   function()
--     if list[source] then
--       PlayerCount = PlayerCount - 1
--       list[source] = nil
--     end
--   end
-- )

RegisterCommand(
  "calltrain",
  function()
    TriggerClientEvent("VP:TRAIN:Bondroute", GetHostId())
  end
)


-- RegisterNetEvent("VP:GHOSTRAIN:calltrain")
-- AddEventHandler(
--   "VP:GHOSTRAIN:calltrain",
--   function()
--     TriggerClientEvent("VP:GHOST:Trainroute", GetHostId())
--   end
-- )
