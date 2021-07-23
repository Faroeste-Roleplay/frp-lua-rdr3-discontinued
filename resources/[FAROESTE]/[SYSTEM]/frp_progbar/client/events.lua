RegisterNetEvent("VP:PROGBAR:client:progress")
AddEventHandler("VP:PROGBAR:client:progress", function(action, finish)
	Process(action, nil, nil, finish)
end)

RegisterNetEvent("VP:PROGBAR:client:ProgressWithStartEvent")
AddEventHandler("VP:PROGBAR:client:ProgressWithStartEvent", function(action, start, finish)
	Process(action, start, nil, finish)
end)

RegisterNetEvent("VP:PROGBAR:client:ProgressWithTickEvent")
AddEventHandler("VP:PROGBAR:client:ProgressWithTickEvent", function(action, tick, finish)
	Process(action, nil, tick, finish)
end)

RegisterNetEvent("VP:PROGBAR:client:ProgressWithStartAndTick")
AddEventHandler("VP:PROGBAR:client:ProgressWithStartAndTick", function(action, start, tick, finish)
	Process(action, start, tick, finish)
end)

RegisterNetEvent("VP:PROGBAR:client:cancel")
AddEventHandler("VP:PROGBAR:client:cancel", function()
	Cancel()
end)

RegisterNUICallback('actionFinish', function(data, cb)
	Finish()
end)