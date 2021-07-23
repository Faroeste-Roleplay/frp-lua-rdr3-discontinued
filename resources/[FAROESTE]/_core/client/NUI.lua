local resourceHasFocus

local hasFocus
local hasMouse
local hasKeepInput

-- function cAPI.NUISetFocus(hasFocus, hasMouse, hasKeepInput)
-- end

function cAPI.NUIClearFocus()
end

function cAPI.NUISetResourceHasFocus()
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == resourceHasFocus then
            cAPI.NUIClearFocus()
        end
    end
)

RegisterNetEvent('NUI:ClearResourceFocus')
