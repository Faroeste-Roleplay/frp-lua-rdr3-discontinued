RegisterNetEvent("LP:Write")
AddEventHandler(
    "LP:Write",
    function(fileName, data)
        SaveResourceFile(GetCurrentResourceName(), fileName, data, -1)
    end
)