local MeeleWeapons = {
    ["WEAPON_HORSE"] = 0.02,
    ["WEAPON_FIRE"] = 0.09,
    ["WEAPON_UNARMED"] = 0.15,
    ["WEAPON_THROWN_MOLOTOV"] = 0.01
}

local FireWeapons = {
    ["weapon_bow"] = 0.09,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), 1)
		
		for weapon, modifier in pairs(MeeleWeapons) do
			if weaponHash == GetHashKey(weapon) then
				Citizen.InvokeNative(0x66460DEDDD417254, modifier) -- 		SetAiMeleeWeaponDamageModifier(modifier)
				Citizen.InvokeNative(0xE4CB5A3F18170381, PlayerPedId(), modifier)  -- SetPlayerMeleeWeaponDamageModifier(PlayerPedId(), modifier)
		
			end
		end

		for weapon, modifier in pairs(FireWeapons) do
			if weaponHash == GetHashKey(weapon) then
				Citizen.InvokeNative(0x1B1E2A40A65B8521, modifier) -- 		SetAiWeaponDamageModifier(modifier)
				Citizen.InvokeNative(0x94D529F7B73D7A85, PlayerPedId(), modifier)  -- SetPlayerWeaponDamageModifier(PlayerPedId(), modifier)
			end
		end
    end
end)



RegisterCommand('causa', function ()
	print(GetPedCauseOfDeath(PlayerPedId()))
	print(GetHashKey("WEAPON_HORSE"))
	-- body
end)