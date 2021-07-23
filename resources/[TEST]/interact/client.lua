-- Interactions script by Senglar, enjoy!!

--[[
	### Beginning of config ###
]]--


local interList = {
	-- Sillas cantina Saint Denis
	{ name = 'saloon', text = "Sentarse", x = 2631.76, y = -1225.67, z = 52.88, active = false },
	{ name = 'saloon', text = "Sentarse", x = 2630.75, y = -1225.08, z = 52.88, active = false },
	{ name = 'saloon', text = "Sentarse", x = 2631.75, y = -1226.84, z = 52.88, active = false },
	{ name = 'saloon', text = "Sentarse", x = 2630.73, y = -1227.42, z = 52.88, active = false },
	{ name = 'saloon', text = "Sentarse", x = 2629.72, y = -1226.83, z = 52.88, active = false },
	{ name = 'saloon', text = "Sentarse", x = 2629.73, y = -1225.66, z = 52.88, active = false },
	{ name = 'saloon', text = "Sentarse", x = -304.86, y = 802.28, z = 117.9, active = false },
	{ name = 'barber', text = "Sentarse", x = -306.62, y = 813.56, z = 117.97, active = false },
	{ name = 'piano', text = "Afiar Machado", x = -360.62, y = 801.91, z = 115.24, active = false },

	{ name = 'piano', text = "Afiar Machado", x = 2691.0, y = -1113.49, z = 51.87, active = false },
	{ name = 'piano', text = "Afiar Machado", x = 1304.671, y = -1134.958, z = 81.286, active = false },


	-- Bombas de agua  , , , 
	
	{ name = 'Bomba', text = "Bombear", x = -789.134, y =  -1332.007, z = 43.633, active = false },


}

-- Habilitar/Deshabilitar las barras abajo y arriba de la pantalla cuando interactuas
-- Enable/Disable black bars on the top and bottom when interacting
-- Default : false
local black_bars = false


--[[
	### end of config ###
]]--


local promp_group = GetRandomIntInRange(0, 0xffffff)
local promp_exit_group = GetRandomIntInRange(0, 0xffffff)

local active = false
local prompt, prompt_exit

function prompt()
    Citizen.CreateThread(function()
        local str = 'Interactuar'
        local wait = 0
        prompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(prompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(prompt, str)
        PromptSetEnabled(prompt, true)
        PromptSetVisible(prompt, true)
        PromptSetHoldMode(prompt, true)
        PromptSetGroup(prompt, promp_group)
        PromptRegisterEnd(prompt)
    end)
end

function prompt_exit()
    Citizen.CreateThread(function()
        local str = 'Interactuar'
        local wait = 0
        prompt_exit = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(prompt_exit, 0x156F7119)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(prompt_exit, str)
        PromptSetEnabled(prompt_exit, true)
        PromptSetVisible(prompt_exit, true)
        PromptSetHoldMode(prompt_exit, true)
        PromptSetGroup(prompt_exit, promp_exit_group)
        PromptRegisterEnd(prompt_exit)
    end)
end


Citizen.CreateThread(function()
    prompt()
	prompt_exit()
    while true do
		Wait(0)
		if not active then
			for _, lista in pairs(interList) do
				local pedCoords = GetEntityCoords(PlayerPedId())
				local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, lista.x, lista.y, lista.z)
				if dist < 1.5 and dist > 0.5 and not lista.active then
					local promp_groupText  = CreateVarString(10, 'LITERAL_STRING', lista.text)
					   PromptSetActiveGroupThisFrame(promp_group, promp_groupText) 
					if PromptHasHoldModeCompleted(prompt) then
						lista.active = true
						active = true
						local coords = GetEntityCoords(PlayerPedId(), false)
						Citizen.InvokeNative(0x322BFDEA666E2B0E, PlayerPedId(),  coords.x, coords.y, coords.z, 5.0, -1, 1, 1, 1, 1)
						Wait(1000)
						if black_bars then Citizen.InvokeNative(0x69D65E89FFD72313,true) end
					end
				else
					lista.active = false
				end
			end
		else
			local promp_groupText  = CreateVarString(10, 'LITERAL_STRING', "Cancelar")
			   PromptSetActiveGroupThisFrame(promp_exit_group, promp_groupText) 
			if PromptHasHoldModeCompleted(prompt_exit) then
				active = false
				ClearPedTasks(PlayerPedId())
				ClearPedSecondaryTask(PlayerPedId())
				Wait(1000)
				if black_bars then Citizen.InvokeNative(0x69D65E89FFD72313,false) end
				Wait(4000)
			end
		end
    end
end)


