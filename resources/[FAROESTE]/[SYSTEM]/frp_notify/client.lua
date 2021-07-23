RegisterNetEvent("FRP:NOTIFY:Toast")
AddEventHandler("FRP:NOTIFY:Toast",function(icon,title,mensagem)
	--SendNUIMessage({ css = css, mensagem = mensagem })	
	if icon == "alert" then
		exports['frp_notify']:DisplayLeftNotification(title,
		mensagem,
		'HUD_TOASTS',
		'toast_mp_status_change',
		10000)	
	end

	if icon == "verify" then
		exports['frp_notify']:DisplayLeftNotification(title,
		mensagem,
		'generic_textures',
		'tick',
		10000)	
	end

	if icon == "locked" then
		exports['frp_notify']:DisplayLeftNotification(title,
		mensagem,
		'menu_textures',
		'stamp_locked_rank',
		10000)	
	end

	if icon == "star" then
		exports['frp_notify']:DisplayLeftNotification(title,
		mensagem,
		'generic_textures',
		'star',
		10000)	
	end	
	
	if icon == "horse" then
		exports['frp_notify']:DisplayLeftNotification(title,
		mensagem,
		'HUD_TOASTS',
		'toast_horse_bond',
		10000)	
	end
end)

RegisterNetEvent("FRP:NOTIFY:Simple")
AddEventHandler("FRP:NOTIFY:Simple",function(mensagem, time)
	SendNUIMessage({ css = 'sucesso', mensagem = mensagem, time =  time })
--	exports['frp_notify']:DisplayLocationNotification(text,locale,10000)	
end)



RegisterNetEvent('blipALERTRED')
AddEventHandler('blipALERTRED', function(targetCoords)
	--if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 160.0)

		SetBlipHighDetail(gunshotBlip, true)
		SetBlipSprite (gunshotBlip, 10)
		SetBlipColour (gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(50 * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)
			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	--end
end)