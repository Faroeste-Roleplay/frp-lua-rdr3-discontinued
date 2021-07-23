RegisterNetEvent("FRP:PROGBAR:client:progress")
AddEventHandler("FRP:PROGBAR:client:progress", function(action, finish)
	Process(action, nil, nil, finish)
end)

RegisterNetEvent("FRP:PROGBAR:client:ProgressWithStartEvent")
AddEventHandler("FRP:PROGBAR:client:ProgressWithStartEvent", function(action, start, finish)
	Process(action, start, nil, finish)
end)

RegisterNetEvent("FRP:PROGBAR:client:ProgressWithTickEvent")
AddEventHandler("FRP:PROGBAR:client:ProgressWithTickEvent", function(action, tick, finish)
	Process(action, nil, tick, finish)
end)

RegisterNetEvent("FRP:PROGBAR:client:ProgressWithStartAndTick")
AddEventHandler("FRP:PROGBAR:client:ProgressWithStartAndTick", function(action, start, tick, finish)
	Process(action, start, tick, finish)
end)

RegisterNetEvent("FRP:PROGBAR:client:cancel")
AddEventHandler("FRP:PROGBAR:client:cancel", function()
	Cancel()
end)

RegisterNUICallback('actionFinish', function(data, cb)
	Finish()
end)