Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            if IsControlJustPressed(0, 0x7F8D09B8) then
                print('NextCamera')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'NextCamera')
            end
            if IsControlJustPressed(0, 0xA987235F) then
                print('LookLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LookLr')
            end
            if IsControlJustPressed(0, 0xD2047988) then
                print('LookUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LookUd')
            end
            if IsControlJustPressed(0, 0xC0651D40) then
                print('LookUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LookUpOnly')
            end
            if IsControlJustPressed(0, 0x8ED92E16) then
                print('LookDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LookDownOnly')
            end
            if IsControlJustPressed(0, 0x08F8BC6D) then
                print('LookLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LookLeftOnly')
            end
            if IsControlJustPressed(0, 0xA1EB1353) then
                print('LookRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LookRightOnly')
            end
            if IsControlJustPressed(0, 0x7A9093DE) then
                print('CinematicSlowmo')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicSlowmo')
            end
            if IsControlJustPressed(0, 0xBA60039F) then
                print('RadialMenuNavUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RadialMenuNavUd')
            end
            if IsControlJustPressed(0, 0x390948DC) then
                print('RadialMenuNavLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RadialMenuNavLr')
            end
            if IsControlJustPressed(0, 0xE71F89B8) then
                print('RadialMenuSlotNavNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RadialMenuSlotNavNext')
            end
            if IsControlJustPressed(0, 0x93D6723F) then
                print('RadialMenuSlotNavPrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RadialMenuSlotNavPrev')
            end
            if IsControlJustPressed(0, 0x77E56FB3) then
                print('SelectNextWheel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectNextWheel')
            end
            if IsControlJustPressed(0, 0x1F6D95E5) then
                print('SelectItemWheel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectItemWheel')
            end
            if IsControlJustPressed(0, 0xF09866F3) then
                print('QuickSelectInspect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickSelectInspect')
            end
            if IsControlJustPressed(0, 0xD45EC04F) then
                print('QuickSelectSetForSwap')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickSelectSetForSwap')
            end
            if IsControlJustPressed(0, 0x9CC7A1A4) then
                print('QuickShortcutAbilitiesMenu')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickShortcutAbilitiesMenu')
            end
            if IsControlJustPressed(0, 0xF1421CF5) then
                print('QuickSelectSecondaryNavNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickSelectSecondaryNavNext')
            end
            if IsControlJustPressed(0, 0xD9F9F017) then
                print('QuickSelectSecondaryNavPrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickSelectSecondaryNavPrev')
            end
            if IsControlJustPressed(0, 0xFA0B29CD) then
                print('QuickSelectToggleShortcutItem')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickSelectToggleShortcutItem')
            end
            if IsControlJustPressed(0, 0x253FEC09) then
                print('QuickSelectPutAwayRod')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickSelectPutAwayRod')
            end
            if IsControlJustPressed(0, 0xA835261B) then
                print('EmotesFavorite')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmotesFavorite')
            end
            if IsControlJustPressed(0, 0x7E75F4DC) then
                print('EmotesManage')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmotesManage')
            end
            if IsControlJustPressed(0, 0xCBB12F87) then
                print('EmotesSlotNavNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmotesSlotNavNext')
            end
            if IsControlJustPressed(0, 0xD0842EDF) then
                print('SelectNextWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectNextWeapon')
            end
            if IsControlJustPressed(0, 0xF78D7337) then
                print('SelectPrevWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectPrevWeapon')
            end
            if IsControlJustPressed(0, 0xCDC4E4E9) then
                print('SkipCutscene')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SkipCutscene')
            end
            if IsControlJustPressed(0, 0x972F8D1E) then
                print('CharacterWheel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CharacterWheel')
            end
            if IsControlJustPressed(0, 0xE8342FF2) then
                print('MultiplayerInfo')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerInfo')
            end
            if IsControlJustPressed(0, 0x8FFC75D6) then
                print('Sprint')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Sprint')
            end
            if IsControlJustPressed(0, 0xD9D0E1C0) then
                print('Jump')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Jump')
            end
            if IsControlJustPressed(0, 0xCEFD9220) then
                print('Enter')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Enter')
            end
            if IsControlJustPressed(0, 0x07CE1E61) then
                print('Attack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Attack')
            end
            if IsControlJustPressed(0, 0xF84FA74F) then
                print('Aim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Aim')
            end
            if IsControlJustPressed(0, 0x9959A6F0) then
                print('LookBehind')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LookBehind')
            end
            if IsControlJustPressed(0, 0x4CF871D0) then
                print('Phone')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Phone')
            end
            if IsControlJustPressed(0, 0xCEE12B50) then
                print('SpecialAbility')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SpecialAbility')
            end
            if IsControlJustPressed(0, 0x6328239B) then
                print('SpecialAbilitySecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SpecialAbilitySecondary')
            end
            if IsControlJustPressed(0, 0x811F4A1A) then
                print('SecondarySpecialAbilitySecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SecondarySpecialAbilitySecondary')
            end
            if IsControlJustPressed(0, 0x1ECA87D4) then
                print('SpecialAbilityAction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SpecialAbilityAction')
            end
            if IsControlJustPressed(0, 0x4D8FB4C1) then
                print('MoveLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MoveLr')
            end
            if IsControlJustPressed(0, 0xFDA83190) then
                print('MoveUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MoveUd')
            end
            if IsControlJustPressed(0, 0x8FD015D8) then
                print('MoveUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MoveUpOnly')
            end
            if IsControlJustPressed(0, 0xD27782E3) then
                print('MoveDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MoveDownOnly')
            end
            if IsControlJustPressed(0, 0x7065027D) then
                print('MoveLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MoveLeftOnly')
            end
            if IsControlJustPressed(0, 0xB4E465B4) then
                print('MoveRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MoveRightOnly')
            end
            if IsControlJustPressed(0, 0xDB096B85) then
                print('Duck')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Duck')
            end
            if IsControlJustPressed(0, 0x938D4071) then
                print('TwirlPistol')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'TwirlPistol')
            end
            if IsControlJustPressed(0, 0xB238FE0B) then
                print('ToggleHolster')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ToggleHolster')
            end
            if IsControlJustPressed(0, 0xAC4BD4F1) then
                print('OpenWheelMenu')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'OpenWheelMenu')
            end
            if IsControlJustPressed(0, 0x4CC0E2FE) then
                print('OpenSatchelMenu')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'OpenSatchelMenu')
            end
            if IsControlJustPressed(0, 0x5966D52A) then
                print('OpenSatchelHorseMenu')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'OpenSatchelHorseMenu')
            end
            if IsControlJustPressed(0, 0x734C6E39) then
                print('OpenCraftingMenu')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'OpenCraftingMenu')
            end
            if IsControlJustPressed(0, 0xF3830D8E) then
                print('OpenJournal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'OpenJournal')
            end
            if IsControlJustPressed(0, 0xE6360A8E) then
                print('Pickup')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Pickup')
            end
            if IsControlJustPressed(0, 0xC75C27B0) then
                print('Ignite')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Ignite')
            end
            if IsControlJustPressed(0, 0x7ABC6A66) then
                print('SniperZoom')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoom')
            end
            if IsControlJustPressed(0, 0xA5BDCD3C) then
                print('SniperZoomInOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomInOnly')
            end
            if IsControlJustPressed(0, 0x430593AA) then
                print('SniperZoomOutOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomOutOnly')
            end
            if IsControlJustPressed(0, 0x6BE9C207) then
                print('SniperZoomInSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomInSecondary')
            end
            if IsControlJustPressed(0, 0x8A7B8833) then
                print('SniperZoomOutSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomOutSecondary')
            end
            if IsControlJustPressed(0, 0x3076E97C) then
                print('ToggleWeaponScope')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ToggleWeaponScope')
            end
            if IsControlJustPressed(0, 0xDE794E3E) then
                print('Cover')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Cover')
            end
            if IsControlJustPressed(0, 0x750C8010) then
                print('CoverTransition')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CoverTransition')
            end
            if IsControlJustPressed(0, 0xE30CD707) then
                print('Reload')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Reload')
            end
            if IsControlJustPressed(0, 0x7DCA9C75) then
                print('Talk')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Talk')
            end
            if IsControlJustPressed(0, 0x73846677) then
                print('Detonate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Detonate')
            end
            if IsControlJustPressed(0, 0x580C4473) then
                print('HudSpecial')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HudSpecial')
            end
            if IsControlJustPressed(0, 0xA4F1006B) then
                print('Arrest')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Arrest')
            end
            if IsControlJustPressed(0, 0x406ADFAE) then
                print('AccurateAim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'AccurateAim')
            end
            if IsControlJustPressed(0, 0x827E9EE8) then
                print('SwitchShoulder')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SwitchShoulder')
            end
            if IsControlJustPressed(0, 0x841240A9) then
                print('IronSight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'IronSight')
            end
            if IsControlJustPressed(0, 0xD8F73058) then
                print('AimInAir')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'AimInAir')
            end
            if IsControlJustPressed(0, 0xEED15F18) then
                print('SwitchFiringMode')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SwitchFiringMode')
            end
            if IsControlJustPressed(0, 0xB73BCA77) then
                print('Context')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Context')
            end
            if IsControlJustPressed(0, 0xF19BE385) then
                print('ContextSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextSecondary')
            end
            if IsControlJustPressed(0, 0x733901F3) then
                print('WeaponSpecial')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'WeaponSpecial')
            end
            if IsControlJustPressed(0, 0x50BA1A77) then
                print('WeaponSpecialTwo')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'WeaponSpecialTwo')
            end
            if IsControlJustPressed(0, 0x06052D11) then
                print('Dive')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Dive')
            end
            if IsControlJustPressed(0, 0x7DBCD016) then
                print('DropWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DropWeapon')
            end
            if IsControlJustPressed(0, 0x4E42696E) then
                print('DropAmmo')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DropAmmo')
            end
            if IsControlJustPressed(0, 0x0AF99998) then
                print('ThrowGrenade')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ThrowGrenade')
            end
            if IsControlJustPressed(0, 0xE72B43F4) then
                print('FocusCam')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FocusCam')
            end
            if IsControlJustPressed(0, 0xA61DC630) then
                print('Inspect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Inspect')
            end
            if IsControlJustPressed(0, 0x53296B75) then
                print('InspectZoom')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InspectZoom')
            end
            if IsControlJustPressed(0, 0x1788C283) then
                print('InspectLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InspectLr')
            end
            if IsControlJustPressed(0, 0xF9781997) then
                print('InspectUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InspectUd')
            end
            if IsControlJustPressed(0, 0x9B1CA8DA) then
                print('InspectOpenSatchel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InspectOpenSatchel')
            end
            if IsControlJustPressed(0, 0x2EAB0795) then
                print('DynamicScenario')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DynamicScenario')
            end
            if IsControlJustPressed(0, 0x80F28E95) then
                print('PlayerMenu')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PlayerMenu')
            end
            if IsControlJustPressed(0, 0xE2B557A3) then
                print('OpenEmoteWheel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'OpenEmoteWheel')
            end
            if IsControlJustPressed(0, 0x8B3FA65E) then
                print('OpenEmoteWheelHorse')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'OpenEmoteWheelHorse')
            end
            if IsControlJustPressed(0, 0x1C826362) then
                print('EmoteGroupLink')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteGroupLink')
            end
            if IsControlJustPressed(0, 0x4FD1C57B) then
                print('EmoteGroupLinkHorse')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteGroupLinkHorse')
            end
            if IsControlJustPressed(0, 0xCF8A4ECA) then
                print('RevealHud')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RevealHud')
            end
            if IsControlJustPressed(0, 0x0F39B3D4) then
                print('SelectRadarMode')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectRadarMode')
            end
            if IsControlJustPressed(0, 0x5FEF1B6D) then
                print('SimpleRadar')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SimpleRadar')
            end
            if IsControlJustPressed(0, 0xCF0B11DE) then
                print('ExpandRadar')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ExpandRadar')
            end
            if IsControlJustPressed(0, 0x51AA7A35) then
                print('RegularRadar')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RegularRadar')
            end
            if IsControlJustPressed(0, 0x70CBD78D) then
                print('DisableRadar')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DisableRadar')
            end
            if IsControlJustPressed(0, 0xDB8D69B8) then
                print('Surrender')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Surrender')
            end
            if IsControlJustPressed(0, 0x24978A28) then
                print('Whistle')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Whistle')
            end
            if IsControlJustPressed(0, 0xE7EB9185) then
                print('WhistleHorseback')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'WhistleHorseback')
            end
            if IsControlJustPressed(0, 0x7914A3DD) then
                print('StopLeadingAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'StopLeadingAnimal')
            end
            if IsControlJustPressed(0, 0x620A6C5E) then
                print('CinematicCam')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicCam')
            end
            if IsControlJustPressed(0, 0xD7E7B375) then
                print('CinematicCamHold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicCamHold')
            end
            if IsControlJustPressed(0, 0xA6C67243) then
                print('CinematicCamChangeShot')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicCamChangeShot')
            end
            if IsControlJustPressed(0, 0x84574AE8) then
                print('CinematicCamUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicCamUd')
            end
            if IsControlJustPressed(0, 0xEFCFE6B7) then
                print('CinematicCamUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicCamUpOnly')
            end
            if IsControlJustPressed(0, 0x23AE34A2) then
                print('CinematicCamDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicCamDownOnly')
            end
            if IsControlJustPressed(0, 0x6BC904FC) then
                print('CinematicCamLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CinematicCamLr')
            end
            if IsControlJustPressed(0, 0x5181713D) then
                print('ContextA')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextA')
            end
            if IsControlJustPressed(0, 0x3B24C470) then
                print('ContextB')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextB')
            end
            if IsControlJustPressed(0, 0xE3BF959B) then
                print('ContextX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextX')
            end
            if IsControlJustPressed(0, 0xD51B784F) then
                print('ContextY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextY')
            end
            if IsControlJustPressed(0, 0xC13A6564) then
                print('ContextLt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextLt')
            end
            if IsControlJustPressed(0, 0x07B8BEAF) then
                print('ContextRt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextRt')
            end
            if IsControlJustPressed(0, 0xB28318C0) then
                print('ContextAction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ContextAction')
            end
            if IsControlJustPressed(0, 0xF1E2852C) then
                print('VehMoveLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehMoveLr')
            end
            if IsControlJustPressed(0, 0x8A81C00C) then
                print('VehMoveUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehMoveUd')
            end
            if IsControlJustPressed(0, 0xDEBD7EF6) then
                print('VehMoveUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehMoveUpOnly')
            end
            if IsControlJustPressed(0, 0x16D73E1D) then
                print('VehMoveDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehMoveDownOnly')
            end
            if IsControlJustPressed(0, 0x9DF54706) then
                print('VehMoveLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehMoveLeftOnly')
            end
            if IsControlJustPressed(0, 0x97A8FD98) then
                print('VehMoveRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehMoveRightOnly')
            end
            if IsControlJustPressed(0, 0x493919DB) then
                print('VehSpecial')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSpecial')
            end
            if IsControlJustPressed(0, 0xB6F3E4FE) then
                print('VehGunLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehGunLr')
            end
            if IsControlJustPressed(0, 0x482560EE) then
                print('VehGunUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehGunUd')
            end
            if IsControlJustPressed(0, 0xD7CAFCEF) then
                print('VehAim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehAim')
            end
            if IsControlJustPressed(0, 0xF4330038) then
                print('VehAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehAttack')
            end
            if IsControlJustPressed(0, 0xF1C341BA) then
                print('VehAttack2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehAttack2')
            end
            if IsControlJustPressed(0, 0x5B9FD4E2) then
                print('VehAccelerate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehAccelerate')
            end
            if IsControlJustPressed(0, 0x6E1F639B) then
                print('VehBrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBrake')
            end
            if IsControlJustPressed(0, 0x5B3690F2) then
                print('VehDuck')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDuck')
            end
            if IsControlJustPressed(0, 0xF1301666) then
                print('VehHeadlight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehHeadlight')
            end
            if IsControlJustPressed(0, 0xFEFAB9B4) then
                print('VehExit')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehExit')
            end
            if IsControlJustPressed(0, 0x65D24C98) then
                print('VehHandbrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehHandbrake')
            end
            if IsControlJustPressed(0, 0xCAE9B017) then
                print('VehLookBehind')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehLookBehind')
            end
            if IsControlJustPressed(0, 0x22E0F7E7) then
                print('VehNextRadio')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehNextRadio')
            end
            if IsControlJustPressed(0, 0x9785CE13) then
                print('VehPrevRadio')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPrevRadio')
            end
            if IsControlJustPressed(0, 0xF7FA2DDC) then
                print('VehNextRadioTrack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehNextRadioTrack')
            end
            if IsControlJustPressed(0, 0x0A94C4FF) then
                print('VehPrevRadioTrack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPrevRadioTrack')
            end
            if IsControlJustPressed(0, 0x4915AC0A) then
                print('VehRadioWheel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehRadioWheel')
            end
            if IsControlJustPressed(0, 0x63A0D258) then
                print('VehHorn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehHorn')
            end
            if IsControlJustPressed(0, 0x7232BAB3) then
                print('VehFlyThrottleUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyThrottleUp')
            end
            if IsControlJustPressed(0, 0x084DFF95) then
                print('VehFlyThrottleDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyThrottleDown')
            end
            if IsControlJustPressed(0, 0x31589AD1) then
                print('VehFlyYawLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyYawLeft')
            end
            if IsControlJustPressed(0, 0xBD143FC6) then
                print('VehFlyYawRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyYawRight')
            end
            if IsControlJustPressed(0, 0xEE2804D0) then
                print('VehPassengerAim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPassengerAim')
            end
            if IsControlJustPressed(0, 0x27AD4433) then
                print('VehPassengerAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPassengerAttack')
            end
            if IsControlJustPressed(0, 0x5EC33578) then
                print('VehSpecialAbilityFranklin')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSpecialAbilityFranklin')
            end
            if IsControlJustPressed(0, 0x4AA1560E) then
                print('VehStuntUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehStuntUd')
            end
            if IsControlJustPressed(0, 0x889A626F) then
                print('VehSelectNextWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSelectNextWeapon')
            end
            if IsControlJustPressed(0, 0x0C97BAC7) then
                print('VehSelectPrevWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSelectPrevWeapon')
            end
            if IsControlJustPressed(0, 0x3E7CF9A4) then
                print('VehRoof')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehRoof')
            end
            if IsControlJustPressed(0, 0xAA56B926) then
                print('VehJump')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehJump')
            end
            if IsControlJustPressed(0, 0xB985AA5E) then
                print('VehGrapplingHook')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehGrapplingHook')
            end
            if IsControlJustPressed(0, 0xC7083798) then
                print('VehShuffle')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehShuffle')
            end
            if IsControlJustPressed(0, 0x739D6261) then
                print('VehTraversal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehTraversal')
            end
            if IsControlJustPressed(0, 0xC61611E6) then
                print('VehDropProjectile')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDropProjectile')
            end
            if IsControlJustPressed(0, 0x39CCABD5) then
                print('VehMouseControlOverride')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehMouseControlOverride')
            end
            if IsControlJustPressed(0, 0x3C8AB570) then
                print('VehFlyRollLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyRollLr')
            end
            if IsControlJustPressed(0, 0x56F84EA0) then
                print('VehFlyRollLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyRollLeftOnly')
            end
            if IsControlJustPressed(0, 0x876B3361) then
                print('VehFlyRollRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyRollRightOnly')
            end
            if IsControlJustPressed(0, 0xE67E1E57) then
                print('VehFlyPitchUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyPitchUd')
            end
            if IsControlJustPressed(0, 0x6280BA1A) then
                print('VehFlyPitchUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyPitchUpOnly')
            end
            if IsControlJustPressed(0, 0x0F4E369F) then
                print('VehFlyPitchDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyPitchDownOnly')
            end
            if IsControlJustPressed(0, 0xFE0FE518) then
                print('VehFlyUndercarriage')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyUndercarriage')
            end
            if IsControlJustPressed(0, 0x1D71D7AA) then
                print('VehFlyAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyAttack')
            end
            if IsControlJustPressed(0, 0x24E94299) then
                print('VehFlySelectNextWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlySelectNextWeapon')
            end
            if IsControlJustPressed(0, 0xC0D874E5) then
                print('VehFlySelectPrevWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlySelectPrevWeapon')
            end
            if IsControlJustPressed(0, 0x307FC4C1) then
                print('VehFlySelectTargetLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlySelectTargetLeft')
            end
            if IsControlJustPressed(0, 0x52F25C96) then
                print('VehFlySelectTargetRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlySelectTargetRight')
            end
            if IsControlJustPressed(0, 0xE3238029) then
                print('VehFlyVerticalFlightMode')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyVerticalFlightMode')
            end
            if IsControlJustPressed(0, 0x378A10F7) then
                print('VehFlyDuck')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyDuck')
            end
            if IsControlJustPressed(0, 0x2FBA3F0B) then
                print('VehFlyAttackCamera')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyAttackCamera')
            end
            if IsControlJustPressed(0, 0x6C9810A5) then
                print('VehFlyMouseControlOverride')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyMouseControlOverride')
            end
            if IsControlJustPressed(0, 0x2CAF327E) then
                print('VehSubMouseControlOverride')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubMouseControlOverride')
            end
            if IsControlJustPressed(0, 0x627C4619) then
                print('VehSubTurnLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubTurnLr')
            end
            if IsControlJustPressed(0, 0x44E7E093) then
                print('VehSubTurnLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubTurnLeftOnly')
            end
            if IsControlJustPressed(0, 0xE78A5A3C) then
                print('VehSubTurnRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubTurnRightOnly')
            end
            if IsControlJustPressed(0, 0x469CE271) then
                print('VehSubPitchUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubPitchUd')
            end
            if IsControlJustPressed(0, 0xF9EF072A) then
                print('VehSubPitchUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubPitchUpOnly')
            end
            if IsControlJustPressed(0, 0xBA2D22AA) then
                print('VehSubPitchDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubPitchDownOnly')
            end
            if IsControlJustPressed(0, 0xD28C446F) then
                print('VehSubThrottleUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubThrottleUp')
            end
            if IsControlJustPressed(0, 0xF5B2CEFB) then
                print('VehSubThrottleDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubThrottleDown')
            end
            if IsControlJustPressed(0, 0xD7991F74) then
                print('VehSubAscend')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubAscend')
            end
            if IsControlJustPressed(0, 0x7D51DE24) then
                print('VehSubDescend')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubDescend')
            end
            if IsControlJustPressed(0, 0x64214D49) then
                print('VehSubTurnHardLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubTurnHardLeft')
            end
            if IsControlJustPressed(0, 0xA44C0F83) then
                print('VehSubTurnHardRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSubTurnHardRight')
            end
            if IsControlJustPressed(0, 0xFD8D64A7) then
                print('VehPushbikePedal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPushbikePedal')
            end
            if IsControlJustPressed(0, 0xF03EE151) then
                print('VehPushbikeSprint')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPushbikeSprint')
            end
            if IsControlJustPressed(0, 0x585E942D) then
                print('VehPushbikeFrontBrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPushbikeFrontBrake')
            end
            if IsControlJustPressed(0, 0xF8CBAFB5) then
                print('VehPushbikeRearBrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehPushbikeRearBrake')
            end
            if IsControlJustPressed(0, 0x23595CEA) then
                print('VehDraftMoveUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftMoveUd')
            end
            if IsControlJustPressed(0, 0xA7DFAE8A) then
                print('VehDraftTurnLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftTurnLr')
            end
            if IsControlJustPressed(0, 0x29A5E51E) then
                print('VehDraftMoveUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftMoveUpOnly')
            end
            if IsControlJustPressed(0, 0x25493EB3) then
                print('VehDraftMoveDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftMoveDownOnly')
            end
            if IsControlJustPressed(0, 0x198AFC64) then
                print('VehDraftTurnLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftTurnLeftOnly')
            end
            if IsControlJustPressed(0, 0x5E371EA7) then
                print('VehDraftTurnRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftTurnRightOnly')
            end
            if IsControlJustPressed(0, 0xE99D2B05) then
                print('VehDraftAccelerate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftAccelerate')
            end
            if IsControlJustPressed(0, 0xD648E48D) then
                print('VehDraftBrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftBrake')
            end
            if IsControlJustPressed(0, 0xBDD5830D) then
                print('VehDraftAim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftAim')
            end
            if IsControlJustPressed(0, 0xF40AB198) then
                print('VehDraftAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftAttack')
            end
            if IsControlJustPressed(0, 0x886F12DD) then
                print('VehDraftAttack2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftAttack2')
            end
            if IsControlJustPressed(0, 0x70B87844) then
                print('VehDraftSwitchDrivers')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDraftSwitchDrivers')
            end
            if IsControlJustPressed(0, 0xD8DFCAB3) then
                print('VehBoatTurnLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatTurnLr')
            end
            if IsControlJustPressed(0, 0x5BED7C91) then
                print('VehBoatTurnLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatTurnLeftOnly')
            end
            if IsControlJustPressed(0, 0xF9780DFB) then
                print('VehBoatTurnRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatTurnRightOnly')
            end
            if IsControlJustPressed(0, 0xB341E812) then
                print('VehBoatAccelerate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatAccelerate')
            end
            if IsControlJustPressed(0, 0x428D5F39) then
                print('VehBoatBrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatBrake')
            end
            if IsControlJustPressed(0, 0x92F5F01E) then
                print('VehBoatAim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatAim')
            end
            if IsControlJustPressed(0, 0x6866FA3A) then
                print('VehBoatAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatAttack')
            end
            if IsControlJustPressed(0, 0x876096E9) then
                print('VehBoatAttack2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehBoatAttack2')
            end
            if IsControlJustPressed(0, 0x3BD38D43) then
                print('VehCarTurnLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarTurnLr')
            end
            if IsControlJustPressed(0, 0x07D1654C) then
                print('VehCarTurnLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarTurnLeftOnly')
            end
            if IsControlJustPressed(0, 0x6E3C3649) then
                print('VehCarTurnRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarTurnRightOnly')
            end
            if IsControlJustPressed(0, 0xB9F544B0) then
                print('VehCarAccelerate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarAccelerate')
            end
            if IsControlJustPressed(0, 0xD1887B3F) then
                print('VehCarBrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarBrake')
            end
            if IsControlJustPressed(0, 0x6777B840) then
                print('VehCarAim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarAim')
            end
            if IsControlJustPressed(0, 0x5572F386) then
                print('VehCarAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarAttack')
            end
            if IsControlJustPressed(0, 0x5B763AD7) then
                print('VehCarAttack2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehCarAttack2')
            end
            if IsControlJustPressed(0, 0xFF3626FC) then
                print('VehHandcartAccelerate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehHandcartAccelerate')
            end
            if IsControlJustPressed(0, 0x2D79D80A) then
                print('VehHandcartBrake')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehHandcartBrake')
            end
            if IsControlJustPressed(0, 0x126796EB) then
                print('HorseMoveLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseMoveLr')
            end
            if IsControlJustPressed(0, 0x3BBDEFEF) then
                print('HorseMoveUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseMoveUd')
            end
            if IsControlJustPressed(0, 0x699487BB) then
                print('HorseMoveUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseMoveUpOnly')
            end
            if IsControlJustPressed(0, 0x56F82045) then
                print('HorseMoveDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseMoveDownOnly')
            end
            if IsControlJustPressed(0, 0x86D773F6) then
                print('HorseMoveLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseMoveLeftOnly')
            end
            if IsControlJustPressed(0, 0x7E6B8612) then
                print('HorseMoveRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseMoveRightOnly')
            end
            if IsControlJustPressed(0, 0x70089459) then
                print('HorseSpecial')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseSpecial')
            end
            if IsControlJustPressed(0, 0x3D99EEC6) then
                print('HorseGunLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseGunLr')
            end
            if IsControlJustPressed(0, 0xBFF476F9) then
                print('HorseGunUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseGunUd')
            end
            if IsControlJustPressed(0, 0x60C81CDE) then
                print('HorseAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseAttack')
            end
            if IsControlJustPressed(0, 0xC904196D) then
                print('HorseAttack2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseAttack2')
            end
            if IsControlJustPressed(0, 0x5AA007D7) then
                print('HorseSprint')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseSprint')
            end
            if IsControlJustPressed(0, 0xE16B9AAD) then
                print('HorseStop')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseStop')
            end
            if IsControlJustPressed(0, 0xCBDB82A8) then
                print('HorseExit')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseExit')
            end
            if IsControlJustPressed(0, 0x81280569) then
                print('HorseLookBehind')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseLookBehind')
            end
            if IsControlJustPressed(0, 0xE4D2CE1D) then
                print('HorseJump')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseJump')
            end
            if IsControlJustPressed(0, 0x61470051) then
                print('HorseAim')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseAim')
            end
            if IsControlJustPressed(0, 0x7D5B3717) then
                print('HorseCollect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseCollect')
            end
            if IsControlJustPressed(0, 0xA95E1468) then
                print('HitchAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HitchAnimal')
            end
            if IsControlJustPressed(0, 0x4216AF06) then
                print('HorseCommandFlee')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseCommandFlee')
            end
            if IsControlJustPressed(0, 0xAE5DFDED) then
                print('HorseCommandStay')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseCommandStay')
            end
            if IsControlJustPressed(0, 0x763E4D27) then
                print('HorseCommandFollow')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseCommandFollow')
            end
            if IsControlJustPressed(0, 0x1A3EABBB) then
                print('HorseMelee')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseMelee')
            end
            if IsControlJustPressed(0, 0x78ED2132) then
                print('MeleeHorseAttackPrimary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeHorseAttackPrimary')
            end
            if IsControlJustPressed(0, 0x162AFEB8) then
                print('MeleeHorseAttackSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeHorseAttackSecondary')
            end
            if IsControlJustPressed(0, 0x2996DD15) then
                print('HorseCoverTransition')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'HorseCoverTransition')
            end
            if IsControlJustPressed(0, 0xB2F377E8) then
                print('MeleeAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeAttack')
            end
            if IsControlJustPressed(0, 0x1E7D7275) then
                print('MeleeModifier')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeModifier')
            end
            if IsControlJustPressed(0, 0xB5EEEFB7) then
                print('MeleeBlock')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeBlock')
            end
            if IsControlJustPressed(0, 0x2277FAE9) then
                print('MeleeGrapple')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeGrapple')
            end
            if IsControlJustPressed(0, 0xADEAF48C) then
                print('MeleeGrappleAttack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeGrappleAttack')
            end
            if IsControlJustPressed(0, 0x018C47CF) then
                print('MeleeGrappleChoke')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeGrappleChoke')
            end
            if IsControlJustPressed(0, 0x91C9A817) then
                print('MeleeGrappleReversal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeGrappleReversal')
            end
            if IsControlJustPressed(0, 0xD0C1FEFF) then
                print('MeleeGrappleBreakout')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeGrappleBreakout')
            end
            if IsControlJustPressed(0, 0xBE1F4699) then
                print('MeleeGrappleStandSwitch')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeGrappleStandSwitch')
            end
            if IsControlJustPressed(0, 0x67ED272E) then
                print('MeleeGrappleMountSwitch')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MeleeGrappleMountSwitch')
            end
            if IsControlJustPressed(0, 0xEBF53058) then
                print('ParachuteDeploy')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteDeploy')
            end
            if IsControlJustPressed(0, 0xFFBFF139) then
                print('ParachuteDetach')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteDetach')
            end
            if IsControlJustPressed(0, 0x8EC920BF) then
                print('ParachuteTurnLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteTurnLr')
            end
            if IsControlJustPressed(0, 0xC4CF3322) then
                print('ParachuteTurnLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteTurnLeftOnly')
            end
            if IsControlJustPressed(0, 0x2BDBA378) then
                print('ParachuteTurnRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteTurnRightOnly')
            end
            if IsControlJustPressed(0, 0xF0526228) then
                print('ParachutePitchUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachutePitchUd')
            end
            if IsControlJustPressed(0, 0x08BFEA69) then
                print('ParachutePitchUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachutePitchUpOnly')
            end
            if IsControlJustPressed(0, 0x7C3A4352) then
                print('ParachutePitchDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachutePitchDownOnly')
            end
            if IsControlJustPressed(0, 0x272BD8BA) then
                print('ParachuteBrakeLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteBrakeLeft')
            end
            if IsControlJustPressed(0, 0x948B3EA7) then
                print('ParachuteBrakeRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteBrakeRight')
            end
            if IsControlJustPressed(0, 0x2574FAB0) then
                print('ParachuteSmoke')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachuteSmoke')
            end
            if IsControlJustPressed(0, 0xC675B8BD) then
                print('ParachutePrecisionLanding')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ParachutePrecisionLanding')
            end
            if IsControlJustPressed(0, 0xE31C6A41) then
                print('Map')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Map')
            end
            if IsControlJustPressed(0, 0x1F6EEB0F) then
                print('SelectWeaponUnarmed')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponUnarmed')
            end

            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_UNARMED"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_MELEE"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_HANDGUN"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SHOTGUN"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SMG"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_AUTO_RIFLE"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SNIPER"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_HEAVY"), false)
            DisableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SPECIAL"), false)

           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_UNARMED"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_MELEE"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_HANDGUN"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SHOTGUN"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SMG"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_AUTO_RIFLE"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SNIPER"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_HEAVY"), true)
           EnableControlAction(0, GetHashKey("INPUT_SELECT_WEAPON_SPECIAL"), true)



           
            if IsControlJustPressed(0, GetHashKey("INPUT_SELECT_WEAPON_HANDGUN")) then
                print('SelectWeaponHandgun')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponHandgun')
            end
            if IsControlJustPressed(0, 0x109E6852) then       
                print('SelectWeaponMelee')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponMelee')
            end
            if IsControlJustPressed(0, 0x184960E3) then
                print('SelectWeaponHandgun')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponHandgun')
            end
            if IsControlJustPressed(0, 0x76D3EA05) then
                print('SelectWeaponShotgun')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponShotgun')
            end
            if IsControlJustPressed(0, 0xCEF1BB48) then
                print('SelectWeaponSmg')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponSmg')
            end
            if IsControlJustPressed(0, 0x05EEA9D0) then
                print('SelectWeaponAutoRifle')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponAutoRifle')
            end
            if IsControlJustPressed(0, 0x96C61FDF) then
                print('SelectWeaponSniper')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponSniper')
            end
            if IsControlJustPressed(0, 0x3D1675C3) then
                print('SelectWeaponHeavy')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponHeavy')
            end
            if IsControlJustPressed(0, 0xC41ECEF8) then
                print('SelectWeaponSpecial')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectWeaponSpecial')
            end
            if IsControlJustPressed(0, 0xEA9256B8) then
                print('SelectCharacterMichael')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectCharacterMichael')
            end
            if IsControlJustPressed(0, 0x8E8B08CB) then
                print('SelectCharacterFranklin')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectCharacterFranklin')
            end
            if IsControlJustPressed(0, 0xB00CC093) then
                print('SelectCharacterTrevor')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectCharacterTrevor')
            end
            if IsControlJustPressed(0, 0xDFB2B3B8) then
                print('SelectCharacterMultiplayer')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectCharacterMultiplayer')
            end
            if IsControlJustPressed(0, 0x5B3AF9E3) then
                print('SaveReplayClip')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SaveReplayClip')
            end
            if IsControlJustPressed(0, 0x52E60A8B) then
                print('SpecialAbilityPc')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SpecialAbilityPc')
            end
            if IsControlJustPressed(0, 0xE6F612E4) then
                print('SelectQuickselectSidearmsLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectSidearmsLeft')
            end
            if IsControlJustPressed(0, 0x1CE6D9EB) then
                print('SelectQuickselectDualwield')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectDualwield')
            end
            if IsControlJustPressed(0, 0x4F49CC4C) then
                print('SelectQuickselectSidearmsRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectSidearmsRight')
            end
            if IsControlJustPressed(0, 0x8F9F9E58) then
                print('SelectQuickselectUnarmed')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectUnarmed')
            end
            if IsControlJustPressed(0, 0xAB62E997) then
                print('SelectQuickselectMeleeNoUnarmed')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectMeleeNoUnarmed')
            end
            if IsControlJustPressed(0, 0xA1FDE2A6) then
                print('SelectQuickselectSecondaryLongarm')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectSecondaryLongarm')
            end
            if IsControlJustPressed(0, 0xB03A913B) then
                print('SelectQuickselectThrown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectThrown')
            end
            if IsControlJustPressed(0, 0x42385422) then
                print('SelectQuickselectPrimaryLongarm')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SelectQuickselectPrimaryLongarm')
            end
            if IsControlJustPressed(0, 0xD2EE3B1E) then
                print('CellphoneUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneUp')
            end
            if IsControlJustPressed(0, 0x82196002) then
                print('CellphoneDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneDown')
            end
            if IsControlJustPressed(0, 0x3ABBE990) then
                print('CellphoneLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneLeft')
            end
            if IsControlJustPressed(0, 0xD25EFDCD) then
                print('CellphoneRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneRight')
            end
            if IsControlJustPressed(0, 0xDC264018) then
                print('CellphoneSelect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneSelect')
            end
            if IsControlJustPressed(0, 0xDD833287) then
                print('CellphoneCancel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneCancel')
            end
            if IsControlJustPressed(0, 0xD2C28BB4) then
                print('CellphoneOption')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneOption')
            end
            if IsControlJustPressed(0, 0xBE354011) then
                print('CellphoneExtraOption')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneExtraOption')
            end
            if IsControlJustPressed(0, 0xCB4E1798) then
                print('CellphoneScrollForward')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneScrollForward')
            end
            if IsControlJustPressed(0, 0x47CD0F3B) then
                print('CellphoneScrollBackward')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneScrollBackward')
            end
            if IsControlJustPressed(0, 0x5AC1805E) then
                print('CellphoneCameraFocusLock')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneCameraFocusLock')
            end
            if IsControlJustPressed(0, 0xE18CC57A) then
                print('CellphoneCameraGrid')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneCameraGrid')
            end
            if IsControlJustPressed(0, 0x6A440BFE) then
                print('CellphoneCameraSelfie')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneCameraSelfie')
            end
            if IsControlJustPressed(0, 0x593DB489) then
                print('CellphoneCameraDof')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneCameraDof')
            end
            if IsControlJustPressed(0, 0xD7E274E7) then
                print('CellphoneCameraExpression')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CellphoneCameraExpression')
            end
            if IsControlJustPressed(0, 0x05CA7C52) then
                print('FrontendDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendDown')
            end
            if IsControlJustPressed(0, 0x6319DB71) then
                print('FrontendUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendUp')
            end
            if IsControlJustPressed(0, 0xA65EBAB4) then
                print('FrontendLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendLeft')
            end
            if IsControlJustPressed(0, 0xDEB34313) then
                print('FrontendRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRight')
            end
            if IsControlJustPressed(0, 0x5734A944) then
                print('FrontendRdown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRdown')
            end
            if IsControlJustPressed(0, 0xD7DE6B1E) then
                print('FrontendRup')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRup')
            end
            if IsControlJustPressed(0, 0x39336A4F) then
                print('FrontendRleft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRleft')
            end
            if IsControlJustPressed(0, 0x5B48F938) then
                print('FrontendRright')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRright')
            end
            if IsControlJustPressed(0, 0xFB56DD5B) then
                print('FrontendAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendAxisX')
            end
            if IsControlJustPressed(0, 0x091178D0) then
                print('FrontendAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendAxisY')
            end
            if IsControlJustPressed(0, 0x3224BC55) then
                print('FrontendScrollAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendScrollAxisX')
            end
            if IsControlJustPressed(0, 0x21651AD6) then
                print('FrontendScrollAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendScrollAxisY')
            end
            if IsControlJustPressed(0, 0x3D23549A) then
                print('FrontendRightAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRightAxisX')
            end
            if IsControlJustPressed(0, 0xEB4130DF) then
                print('FrontendRightAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRightAxisY')
            end
            if IsControlJustPressed(0, 0xD82E0BD2) then
                print('FrontendPause')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendPause')
            end
            if IsControlJustPressed(0, 0x4A903C11) then
                print('FrontendPauseAlternate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendPauseAlternate')
            end
            if IsControlJustPressed(0, 0xC7B5340A) then
                print('FrontendAccept')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendAccept')
            end
            if IsControlJustPressed(0, 0x156F7119) then
                print('FrontendCancel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendCancel')
            end
            if IsControlJustPressed(0, 0x6DB8C62F) then
                print('FrontendX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendX')
            end
            if IsControlJustPressed(0, 0x7C0162C0) then
                print('FrontendY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendY')
            end
            if IsControlJustPressed(0, 0xE885EF16) then
                print('FrontendLb')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendLb')
            end
            if IsControlJustPressed(0, 0x17BEC168) then
                print('FrontendRb')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRb')
            end
            if IsControlJustPressed(0, 0x51104035) then
                print('FrontendLt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendLt')
            end
            if IsControlJustPressed(0, 0x6FED71BC) then
                print('FrontendRt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRt')
            end
            if IsControlJustPressed(0, 0x43CDA5B0) then
                print('FrontendLs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendLs')
            end
            if IsControlJustPressed(0, 0x7DA48D2A) then
                print('FrontendRs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendRs')
            end
            if IsControlJustPressed(0, 0x9EDC8D65) then
                print('FrontendLeaderboard')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendLeaderboard')
            end
            if IsControlJustPressed(0, 0x064D1698) then
                print('FrontendSocialClub')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendSocialClub')
            end
            if IsControlJustPressed(0, 0xBDB8D6F3) then
                print('FrontendSocialClubSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendSocialClubSecondary')
            end
            if IsControlJustPressed(0, 0x4AF4D473) then
                print('FrontendDelete')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendDelete')
            end
            if IsControlJustPressed(0, 0x3E32FCEE) then
                print('FrontendEndscreenAccept')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendEndscreenAccept')
            end
            if IsControlJustPressed(0, 0xC79BDE9F) then
                print('FrontendEndscreenExpand')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendEndscreenExpand')
            end
            if IsControlJustPressed(0, 0x171910DC) then
                print('FrontendSelect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendSelect')
            end
            if IsControlJustPressed(0, 0x44CD301B) then
                print('FrontendPhotoMode')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendPhotoMode')
            end
            if IsControlJustPressed(0, 0x8CFFE0A1) then
                print('FrontendNavUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendNavUp')
            end
            if IsControlJustPressed(0, 0x78114AB3) then
                print('FrontendNavDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendNavDown')
            end
            if IsControlJustPressed(0, 0x877F1027) then
                print('FrontendNavLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendNavLeft')
            end
            if IsControlJustPressed(0, 0x08BD758C) then
                print('FrontendNavRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendNavRight')
            end
            if IsControlJustPressed(0, 0x125A70E5) then
                print('FrontendMapNavUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendMapNavUp')
            end
            if IsControlJustPressed(0, 0xF8480EED) then
                print('FrontendMapNavDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendMapNavDown')
            end
            if IsControlJustPressed(0, 0xE0D75B00) then
                print('FrontendMapNavLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendMapNavLeft')
            end
            if IsControlJustPressed(0, 0x28725E5D) then
                print('FrontendMapNavRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendMapNavRight')
            end
            if IsControlJustPressed(0, 0x6B359A27) then
                print('FrontendMapZoom')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendMapZoom')
            end
            if IsControlJustPressed(0, 0x43DBF61F) then
                print('GameMenuAccept')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuAccept')
            end
            if IsControlJustPressed(0, 0x308588E6) then
                print('GameMenuCancel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuCancel')
            end
            if IsControlJustPressed(0, 0xFBD7B3E6) then
                print('GameMenuOption')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuOption')
            end
            if IsControlJustPressed(0, 0xD596CFB0) then
                print('GameMenuExtraOption')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuExtraOption')
            end
            if IsControlJustPressed(0, 0x911CB09E) then
                print('GameMenuUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuUp')
            end
            if IsControlJustPressed(0, 0x4403F97F) then
                print('GameMenuDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuDown')
            end
            if IsControlJustPressed(0, 0xAD7FCC5B) then
                print('GameMenuLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuLeft')
            end
            if IsControlJustPressed(0, 0x65F9EC5B) then
                print('GameMenuRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRight')
            end
            if IsControlJustPressed(0, 0xCBD5B26E) then
                print('GameMenuTabLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuTabLeft')
            end
            if IsControlJustPressed(0, 0x110AD1D2) then
                print('GameMenuTabRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuTabRight')
            end
            if IsControlJustPressed(0, 0x26E9DC00) then
                print('GameMenuTabLeftSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuTabLeftSecondary')
            end
            if IsControlJustPressed(0, 0x8CC9CD42) then
                print('GameMenuTabRightSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuTabRightSecondary')
            end
            if IsControlJustPressed(0, 0x81457A1A) then
                print('GameMenuScrollForward')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuScrollForward')
            end
            if IsControlJustPressed(0, 0x9DA42644) then
                print('GameMenuScrollBackward')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuScrollBackward')
            end
            if IsControlJustPressed(0, 0x9CA97399) then
                print('GameMenuStickUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuStickUp')
            end
            if IsControlJustPressed(0, 0x63898D36) then
                print('GameMenuStickDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuStickDown')
            end
            if IsControlJustPressed(0, 0x06C089D4) then
                print('GameMenuStickLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuStickLeft')
            end
            if IsControlJustPressed(0, 0x5BDBE841) then
                print('GameMenuStickRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuStickRight')
            end
            if IsControlJustPressed(0, 0xF0232A03) then
                print('GameMenuRightStickUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRightStickUp')
            end
            if IsControlJustPressed(0, 0xADB78673) then
                print('GameMenuRightStickDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRightStickDown')
            end
            if IsControlJustPressed(0, 0x71E38966) then
                print('GameMenuRightStickLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRightStickLeft')
            end
            if IsControlJustPressed(0, 0xE1CECE4B) then
                print('GameMenuRightStickRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRightStickRight')
            end
            if IsControlJustPressed(0, 0xA8F6DE66) then
                print('GameMenuLs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuLs')
            end
            if IsControlJustPressed(0, 0x89EA3FA5) then
                print('GameMenuRs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRs')
            end
            if IsControlJustPressed(0, 0x4685AA33) then
                print('GameMenuRightAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRightAxisX')
            end
            if IsControlJustPressed(0, 0x60C65EB4) then
                print('GameMenuRightAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuRightAxisY')
            end
            if IsControlJustPressed(0, 0xF431D57A) then
                print('GameMenuLeftAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuLeftAxisX')
            end
            if IsControlJustPressed(0, 0x226EB1EF) then
                print('GameMenuLeftAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'GameMenuLeftAxisY')
            end
            if IsControlJustPressed(0, 0x8E90C7BB) then
                print('Quit')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Quit')
            end
            if IsControlJustPressed(0, 0xC97792B7) then
                print('DocumentPageNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DocumentPageNext')
            end
            if IsControlJustPressed(0, 0x20190AB4) then
                print('DocumentPagePrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DocumentPagePrev')
            end
            if IsControlJustPressed(0, 0xAC70F311) then
                print('DocumentScroll')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DocumentScroll')
            end
            if IsControlJustPressed(0, 0x3D0C19EC) then
                print('DocumentScrollUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DocumentScrollUpOnly')
            end
            if IsControlJustPressed(0, 0xD72F3E29) then
                print('DocumentScrollDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DocumentScrollDownOnly')
            end
            if IsControlJustPressed(0, 0x0283C582) then
                print('Attack2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Attack2')
            end
            if IsControlJustPressed(0, 0xCC1075A7) then
                print('PrevWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PrevWeapon')
            end
            if IsControlJustPressed(0, 0xFD0F0C2C) then
                print('NextWeapon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'NextWeapon')
            end
            if IsControlJustPressed(0, 0xE4568AA1) then
                print('SniperZoomIn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomIn')
            end
            if IsControlJustPressed(0, 0xE40CE39E) then
                print('SniperZoomOut')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomOut')
            end
            if IsControlJustPressed(0, 0x3A9897C1) then
                print('SniperZoomInAlternate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomInAlternate')
            end
            if IsControlJustPressed(0, 0xBC820489) then
                print('SniperZoomOutAlternate')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SniperZoomOutAlternate')
            end
            if IsControlJustPressed(0, 0xDCA6978E) then
                print('ReplayStartStopRecording')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayStartStopRecording')
            end
            if IsControlJustPressed(0, 0x8991A70B) then
                print('ReplayStartStopRecordingSecondary')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayStartStopRecordingSecondary')
            end
            if IsControlJustPressed(0, 0xC7D2C51B) then
                print('ReplayMarkerDelete')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayMarkerDelete')
            end
            if IsControlJustPressed(0, 0xF6734E42) then
                print('ReplayClipDelete')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayClipDelete')
            end
            if IsControlJustPressed(0, 0x083137B2) then
                print('ReplayPause')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayPause')
            end
            if IsControlJustPressed(0, 0xC1339A31) then
                print('ReplayRewind')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayRewind')
            end
            if IsControlJustPressed(0, 0x609A27E8) then
                print('ReplayFfwd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayFfwd')
            end
            if IsControlJustPressed(0, 0xF7C6DA28) then
                print('ReplayNewmarker')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayNewmarker')
            end
            if IsControlJustPressed(0, 0xAD9A9C7C) then
                print('ReplayRecord')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayRecord')
            end
            if IsControlJustPressed(0, 0x567FAF34) then
                print('ReplayScreenshot')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayScreenshot')
            end
            if IsControlJustPressed(0, 0x7E479C7B) then
                print('ReplayHidehud')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayHidehud')
            end
            if IsControlJustPressed(0, 0x5DAFACCF) then
                print('ReplayStartpoint')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayStartpoint')
            end
            if IsControlJustPressed(0, 0x4EF75BBD) then
                print('ReplayEndpoint')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayEndpoint')
            end
            if IsControlJustPressed(0, 0x323AA450) then
                print('ReplayAdvance')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayAdvance')
            end
            if IsControlJustPressed(0, 0x088C7CD4) then
                print('ReplayBack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayBack')
            end
            if IsControlJustPressed(0, 0x561A3387) then
                print('ReplayTools')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayTools')
            end
            if IsControlJustPressed(0, 0x81B8BC9D) then
                print('ReplayRestart')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayRestart')
            end
            if IsControlJustPressed(0, 0xEBA2A41E) then
                print('ReplayShowhotkey')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayShowhotkey')
            end
            if IsControlJustPressed(0, 0x5C220959) then
                print('ReplayCyclemarkerleft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayCyclemarkerleft')
            end
            if IsControlJustPressed(0, 0xC69AE799) then
                print('ReplayCyclemarkerright')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayCyclemarkerright')
            end
            if IsControlJustPressed(0, 0x5925A10D) then
                print('ReplayFovincrease')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayFovincrease')
            end
            if IsControlJustPressed(0, 0x2B88D701) then
                print('ReplayFovdecrease')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayFovdecrease')
            end
            if IsControlJustPressed(0, 0x749EFF0C) then
                print('ReplayCameraup')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayCameraup')
            end
            if IsControlJustPressed(0, 0xA1FE9E2A) then
                print('ReplayCameradown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayCameradown')
            end
            if IsControlJustPressed(0, 0xEBC60685) then
                print('ReplaySave')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplaySave')
            end
            if IsControlJustPressed(0, 0xE3FB91B3) then
                print('ReplayToggletime')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayToggletime')
            end
            if IsControlJustPressed(0, 0xC8A1DE20) then
                print('ReplayToggletips')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayToggletips')
            end
            if IsControlJustPressed(0, 0x58AC1355) then
                print('ReplayPreview')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayPreview')
            end
            if IsControlJustPressed(0, 0xF8629909) then
                print('ReplayToggleTimeline')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayToggleTimeline')
            end
            if IsControlJustPressed(0, 0xD2454F90) then
                print('ReplayTimelinePickupClip')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayTimelinePickupClip')
            end
            if IsControlJustPressed(0, 0x4146A033) then
                print('ReplayTimelineDuplicateClip')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayTimelineDuplicateClip')
            end
            if IsControlJustPressed(0, 0x60726F50) then
                print('ReplayTimelinePlaceClip')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayTimelinePlaceClip')
            end
            if IsControlJustPressed(0, 0xD88B47E7) then
                print('ReplayCtrl')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayCtrl')
            end
            if IsControlJustPressed(0, 0x65D70E9D) then
                print('ReplayTimelineSave')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayTimelineSave')
            end
            if IsControlJustPressed(0, 0x79022218) then
                print('ReplayPreviewAudio')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayPreviewAudio')
            end
            if IsControlJustPressed(0, 0xD9961107) then
                print('ReplayActionReplayStart')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayActionReplayStart')
            end
            if IsControlJustPressed(0, 0x93776CAE) then
                print('ReplayActionReplayCancel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayActionReplayCancel')
            end
            if IsControlJustPressed(0, 0xFD28D0F4) then
                print('ReplayRecordingStart')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayRecordingStart')
            end
            if IsControlJustPressed(0, 0xDB16E702) then
                print('ReplayRecordingStop')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplayRecordingStop')
            end
            if IsControlJustPressed(0, 0xEFEC8FDE) then
                print('ReplaySaveSnapshot')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ReplaySaveSnapshot')
            end
            if IsControlJustPressed(0, 0xA2117C9A) then
                print('VehDriveLook')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDriveLook')
            end
            if IsControlJustPressed(0, 0x55AC04E5) then
                print('VehDriveLook2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehDriveLook2')
            end
            if IsControlJustPressed(0, 0x4D83147C) then
                print('VehFlyAttack2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehFlyAttack2')
            end
            if IsControlJustPressed(0, 0x14C7291D) then
                print('RadioWheelUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RadioWheelUd')
            end
            if IsControlJustPressed(0, 0xF9FA6BC8) then
                print('RadioWheelLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'RadioWheelLr')
            end
            if IsControlJustPressed(0, 0xF1F9CD26) then
                print('VehSlowmoUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSlowmoUd')
            end
            if IsControlJustPressed(0, 0x2B981F4F) then
                print('VehSlowmoUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSlowmoUpOnly')
            end
            if IsControlJustPressed(0, 0x642DE054) then
                print('VehSlowmoDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'VehSlowmoDownOnly')
            end
            if IsControlJustPressed(0, 0x9BEE9213) then
                print('MapPoi')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MapPoi')
            end
            if IsControlJustPressed(0, 0xF8982F00) then
                print('InteractLockon')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockon')
            end
            if IsControlJustPressed(0, 0x26A18F47) then
                print('InteractLockonNeg')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonNeg')
            end
            if IsControlJustPressed(0, 0xF63A17F9) then
                print('InteractLockonPos')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonPos')
            end
            if IsControlJustPressed(0, 0x9FA5AD07) then
                print('InteractLockonRob')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonRob')
            end
            if IsControlJustPressed(0, 0x09A92B8B) then
                print('InteractLockonY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonY')
            end
            if IsControlJustPressed(0, 0xD10A3A36) then
                print('InteractLockonA')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonA')
            end
            if IsControlJustPressed(0, 0x424BD2D2) then
                print('InteractNeg')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractNeg')
            end
            if IsControlJustPressed(0, 0xF6BB7378) then
                print('InteractPos')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractPos')
            end
            if IsControlJustPressed(0, 0x760A9C6F) then
                print('InteractOption1')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractOption1')
            end
            if IsControlJustPressed(0, 0x84543902) then
                print('InteractOption2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractOption2')
            end
            if IsControlJustPressed(0, 0xA1ABB953) then
                print('InteractAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractAnimal')
            end
            if IsControlJustPressed(0, 0x5415BE48) then
                print('InteractLockonAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonAnimal')
            end
            if IsControlJustPressed(0, 0x17D3BFF5) then
                print('InteractLeadAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLeadAnimal')
            end
            if IsControlJustPressed(0, 0xF5C4701B) then
                print('InteractLockonDetachHorse')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonDetachHorse')
            end
            if IsControlJustPressed(0, 0xB0BCE5D6) then
                print('InteractHorseCare')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractHorseCare')
            end
            if IsControlJustPressed(0, 0x71F89BBC) then
                print('InteractLockonCallAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonCallAnimal')
            end
            if IsControlJustPressed(0, 0xE2473BF0) then
                print('InteractLockonTrackAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonTrackAnimal')
            end
            if IsControlJustPressed(0, 0x31219490) then
                print('InteractLockonTargetInfo')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonTargetInfo')
            end
            if IsControlJustPressed(0, 0xB3F388BC) then
                print('InteractLockonStudyBinoculars')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractLockonStudyBinoculars')
            end
            if IsControlJustPressed(0, 0x89F3D2E0) then
                print('InteractWildAnimal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractWildAnimal')
            end
            if IsControlJustPressed(0, 0x0D55A0F0) then
                print('InteractHorseFeed')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractHorseFeed')
            end
            if IsControlJustPressed(0, 0x63A38F2C) then
                print('InteractHorseBrush')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractHorseBrush')
            end
            if IsControlJustPressed(0, 0x13C42BB2) then
                print('EmoteAction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteAction')
            end
            if IsControlJustPressed(0, 0x470DC190) then
                print('EmoteTaunt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteTaunt')
            end
            if IsControlJustPressed(0, 0x72BAD5AA) then
                print('EmoteGreet')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteGreet')
            end
            if IsControlJustPressed(0, 0x661857B3) then
                print('EmoteComm')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteComm')
            end
            if IsControlJustPressed(0, 0xF311100C) then
                print('EmoteDance')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteDance')
            end
            if IsControlJustPressed(0, 0x04FB8191) then
                print('EmoteTwirlGunHold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteTwirlGunHold')
            end
            if IsControlJustPressed(0, 0x6990BDDF) then
                print('EmoteTwirlGunVarA')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteTwirlGunVarA')
            end
            if IsControlJustPressed(0, 0x52D29063) then
                print('EmoteTwirlGunVarB')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteTwirlGunVarB')
            end
            if IsControlJustPressed(0, 0xBC2AE312) then
                print('EmoteTwirlGunVarC')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteTwirlGunVarC')
            end
            if IsControlJustPressed(0, 0xAE69478F) then
                print('EmoteTwirlGunVarD')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EmoteTwirlGunVarD')
            end
            if IsControlJustPressed(0, 0x6070D032) then
                print('QuickEquipItem')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickEquipItem')
            end
            if IsControlJustPressed(0, 0x16B0EEF8) then
                print('MinigameBuildingCameraNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBuildingCameraNext')
            end
            if IsControlJustPressed(0, 0x5F97B231) then
                print('MinigameBuildingCameraPrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBuildingCameraPrev')
            end
            if IsControlJustPressed(0, 0xFA91AECD) then
                print('MinigameBuildingHammer')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBuildingHammer')
            end
            if IsControlJustPressed(0, 0x1C559F2E) then
                print('CursorAcceptDoubleClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorAcceptDoubleClick')
            end
            if IsControlJustPressed(0, 0xE474F150) then
                print('CursorAcceptHold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorAcceptHold')
            end
            if IsControlJustPressed(0, 0x9D2AEA88) then
                print('CursorAccept')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorAccept')
            end
            if IsControlJustPressed(0, 0x27568539) then
                print('CursorCancel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorCancel')
            end
            if IsControlJustPressed(0, 0x9CB4ECCE) then
                print('CursorCancelDoubleClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorCancelDoubleClick')
            end
            if IsControlJustPressed(0, 0xD7F70F36) then
                print('CursorCancelHold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorCancelHold')
            end
            if IsControlJustPressed(0, 0xD6C4ECDC) then
                print('CursorX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorX')
            end
            if IsControlJustPressed(0, 0xE4130778) then
                print('CursorY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorY')
            end
            if IsControlJustPressed(0, 0x62800C92) then
                print('CursorScrollUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorScrollUp')
            end
            if IsControlJustPressed(0, 0x8BDE7443) then
                print('CursorScrollDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorScrollDown')
            end
            if IsControlJustPressed(0, 0x6AA8A71B) then
                print('CursorScrollClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorScrollClick')
            end
            if IsControlJustPressed(0, 0xE1B6ED6D) then
                print('CursorScrollDoubleClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorScrollDoubleClick')
            end
            if IsControlJustPressed(0, 0x5484DBDD) then
                print('CursorScrollHold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorScrollHold')
            end
            if IsControlJustPressed(0, 0x11DBBAB9) then
                print('CursorForwardClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorForwardClick')
            end
            if IsControlJustPressed(0, 0x9805D715) then
                print('CursorForwardDoubleClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorForwardDoubleClick')
            end
            if IsControlJustPressed(0, 0x7630C9A1) then
                print('CursorForwardHold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorForwardHold')
            end
            if IsControlJustPressed(0, 0x9AF38793) then
                print('CursorBackwardClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorBackwardClick')
            end
            if IsControlJustPressed(0, 0xA14BA1FC) then
                print('CursorBackwardDoubleClick')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorBackwardDoubleClick')
            end
            if IsControlJustPressed(0, 0x01AA9FA1) then
                print('CursorBackwardHold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CursorBackwardHold')
            end
            if IsControlJustPressed(0, 0x7BF65AC8) then
                print('EnterCheatCode')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'EnterCheatCode')
            end
            if IsControlJustPressed(0, 0xCC510E59) then
                print('InteractionMenu')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractionMenu')
            end
            if IsControlJustPressed(0, 0x9720FCEE) then
                print('MpTextChatAll')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MpTextChatAll')
            end
            if IsControlJustPressed(0, 0x9098AD9D) then
                print('MpTextChatTeam')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MpTextChatTeam')
            end
            if IsControlJustPressed(0, 0x7098AC73) then
                print('MpTextChatFriends')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MpTextChatFriends')
            end
            if IsControlJustPressed(0, 0x8142FA92) then
                print('MpTextChatCrew')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MpTextChatCrew')
            end
            if IsControlJustPressed(0, 0x4BC9DABB) then
                print('PushToTalk')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PushToTalk')
            end
            if IsControlJustPressed(0, 0x339F3730) then
                print('CreatorLs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorLs')
            end
            if IsControlJustPressed(0, 0xD8CF0C95) then
                print('CreatorRs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorRs')
            end
            if IsControlJustPressed(0, 0x446258B6) then
                print('CreatorLt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorLt')
            end
            if IsControlJustPressed(0, 0x3C3DD371) then
                print('CreatorRt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorRt')
            end
            if IsControlJustPressed(0, 0x85D24405) then
                print('CreatorMenuToggle')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuToggle')
            end
            if IsControlJustPressed(0, 0x2CD5343E) then
                print('CreatorAccept')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorAccept')
            end
            if IsControlJustPressed(0, 0xBCD1444B) then
                print('CreatorMenuUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuUp')
            end
            if IsControlJustPressed(0, 0x97410755) then
                print('CreatorMenuDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuDown')
            end
            if IsControlJustPressed(0, 0xEC6A30AA) then
                print('CreatorMenuLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuLeft')
            end
            if IsControlJustPressed(0, 0x19D8334C) then
                print('CreatorMenuRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuRight')
            end
            if IsControlJustPressed(0, 0xFB9C3231) then
                print('CreatorMenuAccept')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuAccept')
            end
            if IsControlJustPressed(0, 0xBB3FC460) then
                print('CreatorMenuCancel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuCancel')
            end
            if IsControlJustPressed(0, 0x5A03B3F3) then
                print('CreatorMenuFunction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuFunction')
            end
            if IsControlJustPressed(0, 0xE6B8F103) then
                print('CreatorMenuExtraFunction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuExtraFunction')
            end
            if IsControlJustPressed(0, 0x0984E40A) then
                print('CreatorMenuSelect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMenuSelect')
            end
            if IsControlJustPressed(0, 0xD74CACAD) then
                print('CreatorPlace')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorPlace')
            end
            if IsControlJustPressed(0, 0x3F4DC0EF) then
                print('CreatorDelete')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorDelete')
            end
            if IsControlJustPressed(0, 0x414034D5) then
                print('CreatorDrop')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorDrop')
            end
            if IsControlJustPressed(0, 0xB05FDA25) then
                print('CreatorFunction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorFunction')
            end
            if IsControlJustPressed(0, 0x9D75674E) then
                print('CreatorRotateRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorRotateRight')
            end
            if IsControlJustPressed(0, 0xD41E9C2A) then
                print('CreatorRotateLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorRotateLeft')
            end
            if IsControlJustPressed(0, 0x338A0D45) then
                print('CreatorGrab')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorGrab')
            end
            if IsControlJustPressed(0, 0x16CCFEC6) then
                print('CreatorSwitchCam')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorSwitchCam')
            end
            if IsControlJustPressed(0, 0x335D8D76) then
                print('CreatorZoomIn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorZoomIn')
            end
            if IsControlJustPressed(0, 0x24A42F93) then
                print('CreatorZoomOut')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorZoomOut')
            end
            if IsControlJustPressed(0, 0x0D0FB9B1) then
                print('CreatorRaise')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorRaise')
            end
            if IsControlJustPressed(0, 0x1BDE2EB3) then
                print('CreatorLower')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorLower')
            end
            if IsControlJustPressed(0, 0xF55864CD) then
                print('CreatorSearch')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorSearch')
            end
            if IsControlJustPressed(0, 0x82428676) then
                print('CreatorMoveUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMoveUd')
            end
            if IsControlJustPressed(0, 0x59753EDC) then
                print('CreatorMoveLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorMoveLr')
            end
            if IsControlJustPressed(0, 0x55EA24F3) then
                print('CreatorLookUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorLookUd')
            end
            if IsControlJustPressed(0, 0xAEB2A9C7) then
                print('CreatorLookLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CreatorLookLr')
            end
            if IsControlJustPressed(0, 0xD2CC4644) then
                print('CutFree')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CutFree')
            end
            if IsControlJustPressed(0, 0xD2928083) then
                print('Drop')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Drop')
            end
            if IsControlJustPressed(0, 0xEB2AC491) then
                print('PickupCarriable')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PickupCarriable')
            end
            if IsControlJustPressed(0, 0xBE8593AF) then
                print('PickupCarriable2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PickupCarriable2')
            end
            if IsControlJustPressed(0, 0x7D326951) then
                print('PlaceCarriableOntoParent')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PlaceCarriableOntoParent')
            end
            if IsControlJustPressed(0, 0xA1202C7B) then
                print('PickupCarriableFromParent')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PickupCarriableFromParent')
            end
            if IsControlJustPressed(0, 0x956C2A0E) then
                print('MercyKill')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MercyKill')
            end
            if IsControlJustPressed(0, 0x43F2959C) then
                print('Revive')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Revive')
            end
            if IsControlJustPressed(0, 0xD9C50532) then
                print('Hogtie')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Hogtie')
            end
            if IsControlJustPressed(0, 0x6E9734E8) then
                print('CarriableSuicide')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CarriableSuicide')
            end 
            if IsControlJustPressed(0, 0x295175BF) then
                print('CarriableBreakFree')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CarriableBreakFree')
            end
            if IsControlJustPressed(0, 0x0522B243) then
                print('InteractHitCarriable')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InteractHitCarriable')
            end
            if IsControlJustPressed(0, 0x41AC83D1) then
                print('Loot')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Loot')
            end
            if IsControlJustPressed(0, 0x399C6619) then
                print('Loot2')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Loot2')
            end
            if IsControlJustPressed(0, 0x27D1C284) then
                print('Loot3')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Loot3')
            end
            if IsControlJustPressed(0, 0x14DB6C5E) then
                print('LootVehicle')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LootVehicle')
            end
            if IsControlJustPressed(0, 0xC23D7B9E) then
                print('LootAmmo')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LootAmmo')
            end
            if IsControlJustPressed(0, 0x97C71B28) then
                print('BreakVehicleLock')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'BreakVehicleLock')
            end
            if IsControlJustPressed(0, 0xFF8109D8) then
                print('LootAliveComponent')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'LootAliveComponent')
            end
            if IsControlJustPressed(0, 0xA8E3F467) then
                print('FeedInteract')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FeedInteract')
            end
            if IsControlJustPressed(0, 0x73A8FD83) then
                print('SaddleTransfer')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'SaddleTransfer')
            end
            if IsControlJustPressed(0, 0xDFF812F9) then
                print('ShopBuy')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ShopBuy')
            end
            if IsControlJustPressed(0, 0x6D1319BE) then
                print('ShopSell')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ShopSell')
            end
            if IsControlJustPressed(0, 0xEA150E72) then
                print('ShopSpecial')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ShopSpecial')
            end
            if IsControlJustPressed(0, 0xD3ECF82F) then
                print('ShopBounty')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ShopBounty')
            end
            if IsControlJustPressed(0, 0x5E723D8C) then
                print('ShopInspect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ShopInspect')
            end
            if IsControlJustPressed(0, 0x90FA19AB) then
                print('ShopChangeCurrency')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ShopChangeCurrency')
            end
            if IsControlJustPressed(0, 0xC1989F95) then
                print('QuickUseItem')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'QuickUseItem')
            end
            if IsControlJustPressed(0, 0x8CF90A9D) then
                print('PromptPageNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PromptPageNext')
            end
            if IsControlJustPressed(0, 0xE7F89C38) then
                print('FrontendTouchZoomFactor')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchZoomFactor')
            end
            if IsControlJustPressed(0, 0x16661AD0) then
                print('FrontendTouchZoomX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchZoomX')
            end
            if IsControlJustPressed(0, 0x253DB87F) then
                print('FrontendTouchZoomY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchZoomY')
            end
            if IsControlJustPressed(0, 0xEC93548E) then
                print('FrontendTouchDragX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchDragX')
            end
            if IsControlJustPressed(0, 0x9AC130EB) then
                print('FrontendTouchDragY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchDragY')
            end
            if IsControlJustPressed(0, 0xC10E180A) then
                print('FrontendTouchTapX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchTapX')
            end
            if IsControlJustPressed(0, 0xCF4B3484) then
                print('FrontendTouchTapY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchTapY')
            end
            if IsControlJustPressed(0, 0x1661FAB0) then
                print('FrontendTouchDoubleTapX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchDoubleTapX')
            end
            if IsControlJustPressed(0, 0x96E87BBF) then
                print('FrontendTouchDoubleTapY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchDoubleTapY')
            end
            if IsControlJustPressed(0, 0x0FF17F1D) then
                print('FrontendTouchHoldX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchHoldX')
            end
            if IsControlJustPressed(0, 0x398ED257) then
                print('FrontendTouchHoldY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchHoldY')
            end
            if IsControlJustPressed(0, 0x0B71D439) then
                print('FrontendTouchSwipeUpX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeUpX')
            end
            if IsControlJustPressed(0, 0x19CA70EA) then
                print('FrontendTouchSwipeUpY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeUpY')
            end
            if IsControlJustPressed(0, 0xE3B30955) then
                print('FrontendTouchSwipeDownX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeDownX')
            end
            if IsControlJustPressed(0, 0xBDFF3DEA) then
                print('FrontendTouchSwipeDownY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeDownY')
            end
            if IsControlJustPressed(0, 0x2545B0DE) then
                print('FrontendTouchSwipeLeftX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeLeftX')
            end
            if IsControlJustPressed(0, 0xD43D0ECE) then
                print('FrontendTouchSwipeLeftY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeLeftY')
            end
            if IsControlJustPressed(0, 0xEAB68397) then
                print('FrontendTouchSwipeRightX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeRightX')
            end
            if IsControlJustPressed(0, 0x675B7CE3) then
                print('FrontendTouchSwipeRightY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'FrontendTouchSwipeRightY')
            end
            if IsControlJustPressed(0, 0x9C68CE34) then
                print('MultiplayerInfoPlayers')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerInfoPlayers')
            end
            if IsControlJustPressed(0, 0xB4F298BA) then
                print('MultiplayerDeadSwitchRespawn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadSwitchRespawn')
            end
            if IsControlJustPressed(0, 0x6816A38E) then
                print('MultiplayerDeadInformLaw')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadInformLaw')
            end
            if IsControlJustPressed(0, 0x18987353) then
                print('MultiplayerDeadRespawn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadRespawn')
            end
            if IsControlJustPressed(0, 0xF875FC78) then
                print('MultiplayerDeadDuel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadDuel')
            end
            if IsControlJustPressed(0, 0x4D11FE01) then
                print('MultiplayerDeadParley')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadParley')
            end
            if IsControlJustPressed(0, 0xB4A11066) then
                print('MultiplayerDeadFeud')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadFeud')
            end
            if IsControlJustPressed(0, 0xCC18F960) then
                print('MultiplayerDeadLeaderFeud')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadLeaderFeud')
            end
            if IsControlJustPressed(0, 0xE50DCA13) then
                print('MultiplayerDeadPressCharges')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerDeadPressCharges')
            end
            if IsControlJustPressed(0, 0x014CA044) then
                print('MultiplayerRaceRespawn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerRaceRespawn')
            end
            if IsControlJustPressed(0, 0xC5CF41B2) then
                print('MultiplayerPredatorAbility')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerPredatorAbility')
            end
            if IsControlJustPressed(0, 0xBA065692) then
                print('MultiplayerSpectatePlayerNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerSpectatePlayerNext')
            end
            if IsControlJustPressed(0, 0x5092BF47) then
                print('MultiplayerSpectatePlayerPrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerSpectatePlayerPrev')
            end
            if IsControlJustPressed(0, 0x7DBA5D49) then
                print('MultiplayerSpectateHideHud')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerSpectateHideHud')
            end
            if IsControlJustPressed(0, 0x4E074EE6) then
                print('MultiplayerSpectatePlayerOptions')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerSpectatePlayerOptions')
            end
            if IsControlJustPressed(0, 0xA917D24B) then
                print('MultiplayerLeaderboardScrollUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MultiplayerLeaderboardScrollUd')
            end
            if IsControlJustPressed(0, 0xE9094BA0) then
                print('MinigameQuit')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameQuit')
            end
            if IsControlJustPressed(0, 0xC7CB8D5F) then
                print('MinigameIncreaseBet')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameIncreaseBet')
            end
            if IsControlJustPressed(0, 0xD3EBF425) then
                print('MinigameDecreaseBet')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDecreaseBet')
            end
            if IsControlJustPressed(0, 0xBDC733EE) then
                print('MinigameChangeBetAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameChangeBetAxisY')
            end
            if IsControlJustPressed(0, 0x410B0B2E) then
                print('MinigamePlaceBet')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePlaceBet')
            end
            if IsControlJustPressed(0, 0x4A21C66B) then
                print('MinigameClearBet')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameClearBet')
            end
            if IsControlJustPressed(0, 0x9384E0A8) then
                print('MinigameHelp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameHelp')
            end
            if IsControlJustPressed(0, 0xC5F53156) then
                print('MinigameHelpPrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameHelpPrev')
            end
            if IsControlJustPressed(0, 0x83608AC0) then
                print('MinigameHelpNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameHelpNext')
            end
            if IsControlJustPressed(0, 0x985243B7) then
                print('MinigameReplay')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameReplay')
            end
            if IsControlJustPressed(0, 0x5D1788FF) then
                print('MinigameNewGame')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameNewGame')
            end
            if IsControlJustPressed(0, 0x646A7792) then
                print('MinigamePokerSkip')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerSkip')
            end
            if IsControlJustPressed(0, 0xDAB9EE72) then
                print('MinigamePokerCall')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerCall')
            end
            if IsControlJustPressed(0, 0x49B4AD1E) then
                print('MinigamePokerFold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerFold')
            end
            if IsControlJustPressed(0, 0x206B2087) then
                print('MinigamePokerCheck')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerCheck')
            end
            if IsControlJustPressed(0, 0x72A9D1F7) then
                print('MinigamePokerCheckFold')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerCheckFold')
            end
            if IsControlJustPressed(0, 0xA9883369) then
                print('MinigamePokerBet')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerBet')
            end
            if IsControlJustPressed(0, 0xC2B1193A) then
                print('MinigamePokerHoleCards')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerHoleCards')
            end
            if IsControlJustPressed(0, 0x03753498) then
                print('MinigamePokerBoardCards')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerBoardCards')
            end
            if IsControlJustPressed(0, 0xB568BCD0) then
                print('MinigamePokerSkipTutorial')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerSkipTutorial')
            end
            if IsControlJustPressed(0, 0x7765B9D4) then
                print('MinigamePokerShowPossibleHands')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerShowPossibleHands')
            end
            if IsControlJustPressed(0, 0xF923B337) then
                print('MinigamePokerYourCards')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerYourCards')
            end
            if IsControlJustPressed(0, 0xE402B898) then
                print('MinigamePokerCommunityCards')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerCommunityCards')
            end
            if IsControlJustPressed(0, 0x2330F517) then
                print('MinigamePokerCheatLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigamePokerCheatLr')
            end
            if IsControlJustPressed(0, 0xB40A9BDB) then
                print('MinigameFishingResetCast')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingResetCast')
            end
            if IsControlJustPressed(0, 0xF14FD435) then
                print('MinigameFishingReleaseFish')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingReleaseFish')
            end
            if IsControlJustPressed(0, 0x52C5C34A) then
                print('MinigameFishingKeepFish')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingKeepFish')
            end
            if IsControlJustPressed(0, 0xA1CD103A) then
                print('MinigameFishingHook')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingHook')
            end
            if IsControlJustPressed(0, 0x69B10623) then
                print('MinigameFishingLeftAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingLeftAxisX')
            end
            if IsControlJustPressed(0, 0x09BF4645) then
                print('MinigameFishingLeftAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingLeftAxisY')
            end
            if IsControlJustPressed(0, 0x4FD4E558) then
                print('MinigameFishingRightAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingRightAxisX')
            end
            if IsControlJustPressed(0, 0x95F2F193) then
                print('MinigameFishingRightAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingRightAxisY')
            end
            if IsControlJustPressed(0, 0x0D4C3ABA) then
                print('MinigameFishingLeanLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingLeanLeft')
            end
            if IsControlJustPressed(0, 0x05074A9B) then
                print('MinigameFishingLeanRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingLeanRight')
            end
            if IsControlJustPressed(0, 0x25F525CD) then
                print('MinigameFishingQuickEquip')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingQuickEquip')
            end
            if IsControlJustPressed(0, 0x2FA915F5) then
                print('MinigameFishingReelSpeedUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingReelSpeedUp')
            end
            if IsControlJustPressed(0, 0xD7AF56A0) then
                print('MinigameFishingReelSpeedDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingReelSpeedDown')
            end
            if IsControlJustPressed(0, 0x49C73CB2) then
                print('MinigameFishingReelSpeedAxis')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingReelSpeedAxis')
            end
            if IsControlJustPressed(0, 0xA303F462) then
                print('MinigameFishingManualReelIn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingManualReelIn')
            end
            if IsControlJustPressed(0, 0x4556642C) then
                print('MinigameFishingManualReelOutModifier')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFishingManualReelOutModifier')
            end
            if IsControlJustPressed(0, 0x524C3787) then
                print('MinigameCrackpotBoatShowControls')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameCrackpotBoatShowControls')
            end
            if IsControlJustPressed(0, 0x88F8B6B1) then
                print('MinigameDominoesViewDominoes')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesViewDominoes')
            end
            if IsControlJustPressed(0, 0x7733CF2C) then
                print('MinigameDominoesViewMoves')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesViewMoves')
            end
            if IsControlJustPressed(0, 0x95F5BB7C) then
                print('MinigameDominoesPlayTile')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesPlayTile')
            end
            if IsControlJustPressed(0, 0xC5E622D7) then
                print('MinigameDominoesSkipDeal')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesSkipDeal')
            end
            if IsControlJustPressed(0, 0xFDDD89D4) then
                print('MinigameDominoesMoveLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesMoveLeftOnly')
            end
            if IsControlJustPressed(0, 0x7D5187C9) then
                print('MinigameDominoesMoveRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesMoveRightOnly')
            end
            if IsControlJustPressed(0, 0xC6AB8CB3) then
                print('MinigameDominoesMoveUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesMoveUpOnly')
            end
            if IsControlJustPressed(0, 0xFD9FC86D) then
                print('MinigameDominoesMoveDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameDominoesMoveDownOnly')
            end
            if IsControlJustPressed(0, 0x03F1E7CB) then
                print('MinigameBlackjackHandView')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackHandView')
            end
            if IsControlJustPressed(0, 0xADE09435) then
                print('MinigameBlackjackTableView')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackTableView')
            end
            if IsControlJustPressed(0, 0x3D2EA092) then
                print('MinigameBlackjackBetAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackBetAxisY')
            end
            if IsControlJustPressed(0, 0x661D8A31) then
                print('MinigameBlackjackBet')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackBet')
            end
            if IsControlJustPressed(0, 0xCD7DDF9B) then
                print('MinigameBlackjackDecline')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackDecline')
            end
            if IsControlJustPressed(0, 0x31260507) then
                print('MinigameBlackjackStand')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackStand')
            end
            if IsControlJustPressed(0, 0xA8142713) then
                print('MinigameBlackjackHit')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackHit')
            end
            if IsControlJustPressed(0, 0x74486CA4) then
                print('MinigameBlackjackDouble')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackDouble')
            end
            if IsControlJustPressed(0, 0x432B111F) then
                print('MinigameBlackjackSplit')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBlackjackSplit')
            end
            if IsControlJustPressed(0, 0x0E717DC6) then
                print('MinigameFffA')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffA')
            end
            if IsControlJustPressed(0, 0x1BC81873) then
                print('MinigameFffB')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffB')
            end
            if IsControlJustPressed(0, 0x65F0ACDF) then
                print('MinigameFffX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffX')
            end
            if IsControlJustPressed(0, 0x73AD4858) then
                print('MinigameFffY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffY')
            end
            if IsControlJustPressed(0, 0x61E4CACC) then
                print('MinigameFffZoom')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffZoom')
            end
            if IsControlJustPressed(0, 0x3073681B) then
                print('MinigameFffSkipTurn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffSkipTurn')
            end
            if IsControlJustPressed(0, 0x29A3550E) then
                print('MinigameFffCycleSequenceLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffCycleSequenceLeft')
            end
            if IsControlJustPressed(0, 0x7B5B896D) then
                print('MinigameFffCycleSequenceRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffCycleSequenceRight')
            end
            if IsControlJustPressed(0, 0x6FC9DE68) then
                print('MinigameFffFlourishContinue')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffFlourishContinue')
            end
            if IsControlJustPressed(0, 0xF7750B25) then
                print('MinigameFffFlourishEnd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffFlourishEnd')
            end
            if IsControlJustPressed(0, 0xCA379F82) then
                print('MinigameFffPractice')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameFffPractice')
            end
            if IsControlJustPressed(0, 0xFF4B2ADA) then
                print('MinigameMilkingLeftAction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameMilkingLeftAction')
            end
            if IsControlJustPressed(0, 0x30BE7CF2) then
                print('MinigameMilkingRightAction')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameMilkingRightAction')
            end
            if IsControlJustPressed(0, 0x7EC33553) then
                print('MinigameLeftTrigger')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameLeftTrigger')
            end
            if IsControlJustPressed(0, 0xBE78B715) then
                print('MinigameRightTrigger')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameRightTrigger')
            end
            if IsControlJustPressed(0, 0x0A1EFC09) then
                print('MinigameActionLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameActionLeft')
            end
            if IsControlJustPressed(0, 0x16D70379) then
                print('MinigameActionRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameActionRight')
            end
            if IsControlJustPressed(0, 0xF5A13A0D) then
                print('MinigameActionUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameActionUp')
            end
            if IsControlJustPressed(0, 0xF601BCFC) then
                print('MinigameActionDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameActionDown')
            end
            if IsControlJustPressed(0, 0xF4DD4C67) then
                print('StickyFeedAccept')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'StickyFeedAccept')
            end
            if IsControlJustPressed(0, 0x0CFB963F) then
                print('StickyFeedCancel')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'StickyFeedCancel')
            end
            if IsControlJustPressed(0, 0xBD1D94A1) then
                print('StickyFeedX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'StickyFeedX')
            end
            if IsControlJustPressed(0, 0xC85BAB1D) then
                print('StickyFeedY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'StickyFeedY')
            end
            if IsControlJustPressed(0, 0x5FC770EA) then
                print('CameraPutAway')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraPutAway')
            end
            if IsControlJustPressed(0, 0xA4BD74A5) then
                print('CameraBack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraBack')
            end
            if IsControlJustPressed(0, 0x44FA14C2) then
                print('CameraTakePhoto')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraTakePhoto')
            end
            if IsControlJustPressed(0, 0xE8337356) then
                print('CameraContextGallery')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraContextGallery')
            end
            if IsControlJustPressed(0, 0x776F65E9) then
                print('CameraHandheldUse')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraHandheldUse')
            end
            if IsControlJustPressed(0, 0x3003F9DC) then
                print('CameraDof')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraDof')
            end
            if IsControlJustPressed(0, 0xAC5922EA) then
                print('CameraSelfie')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraSelfie')
            end
            if IsControlJustPressed(0, 0x47EC4C22) then
                print('CameraZoom')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraZoom')
            end
            if IsControlJustPressed(0, 0xF810FB35) then
                print('CameraPoseNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraPoseNext')
            end
            if IsControlJustPressed(0, 0x8D5BE9D1) then
                print('CameraPosePrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraPosePrev')
            end
            if IsControlJustPressed(0, 0xCFA703D3) then
                print('CameraExpressionNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraExpressionNext')
            end
            if IsControlJustPressed(0, 0x07B6435D) then
                print('CameraExpressionPrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CameraExpressionPrev')
            end
            if IsControlJustPressed(0, 0x24F37AB5) then
                print('TithingIncreaseAmount')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'TithingIncreaseAmount')
            end
            if IsControlJustPressed(0, 0xCEFF5C13) then
                print('TithingDecreaseAmount')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'TithingDecreaseAmount')
            end
            if IsControlJustPressed(0, 0x77110B0A) then
                print('BreakDoorLock')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'BreakDoorLock')
            end
            if IsControlJustPressed(0, 0xA1AA2D8D) then
                print('InterrogateQuestion')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InterrogateQuestion')
            end
            if IsControlJustPressed(0, 0x6E1E0D62) then
                print('InterrogateBeat')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InterrogateBeat')
            end
            if IsControlJustPressed(0, 0x81B2E311) then
                print('InterrogateKill')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InterrogateKill')
            end
            if IsControlJustPressed(0, 0x3C22EF0E) then
                print('InterrogateRelease')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'InterrogateRelease')
            end
            if IsControlJustPressed(0, 0xC67E13BB) then
                print('CampBedInspect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CampBedInspect')
            end
            if IsControlJustPressed(0, 0x8AAA0AD4) then
                print('PcFreeLook')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PcFreeLook')
            end
            if IsControlJustPressed(0, 0xA13460F5) then
                print('MinigameBartenderRaiseGlass')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBartenderRaiseGlass')
            end
            if IsControlJustPressed(0, 0xF0A25112) then
                print('MinigameBartenderRaiseBottle')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBartenderRaiseBottle')
            end
            if IsControlJustPressed(0, 0xCABC2460) then
                print('MinigameBartenderPour')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBartenderPour')
            end
            if IsControlJustPressed(0, 0xDC03B043) then
                print('MinigameBartenderServe')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameBartenderServe')
            end
            if IsControlJustPressed(0, 0x3C0A40F2) then
                print('PhotoMode')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoMode')
            end
            if IsControlJustPressed(0, 0x35957F6C) then
                print('PhotoModePc')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModePc')
            end
            if IsControlJustPressed(0, 0x9F06B29C) then
                print('PhotoModeChangeCamera')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeChangeCamera')
            end
            if IsControlJustPressed(0, 0x4F136512) then
                print('PhotoModeMoveLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeMoveLr')
            end
            if IsControlJustPressed(0, 0x311353EB) then
                print('PhotoModeMoveLeftOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeMoveLeftOnly')
            end
            if IsControlJustPressed(0, 0x5357A7F5) then
                print('PhotoModeMoveRightOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeMoveRightOnly')
            end
            if IsControlJustPressed(0, 0xEC001315) then
                print('PhotoModeMoveUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeMoveUd')
            end
            if IsControlJustPressed(0, 0x315D57E6) then
                print('PhotoModeMoveUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeMoveUpOnly')
            end
            if IsControlJustPressed(0, 0x4EBCC409) then
                print('PhotoModeMoveDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeMoveDownOnly')
            end
            if IsControlJustPressed(0, 0xA209BD57) then
                print('PhotoModeReset')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeReset')
            end
            if IsControlJustPressed(0, 0xB138D899) then
                print('PhotoModeLenseNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeLenseNext')
            end
            if IsControlJustPressed(0, 0x06A057F8) then
                print('PhotoModeLensePrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeLensePrev')
            end
            if IsControlJustPressed(0, 0x2EEA1D2A) then
                print('PhotoModeRotateLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeRotateLeft')
            end
            if IsControlJustPressed(0, 0x96E70854) then
                print('PhotoModeRotateRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeRotateRight')
            end
            if IsControlJustPressed(0, 0x7F9055F5) then
                print('PhotoModeToggleHud')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeToggleHud')
            end
            if IsControlJustPressed(0, 0xDCE96D67) then
                print('PhotoModeViewPhotos')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeViewPhotos')
            end
            if IsControlJustPressed(0, 0xA190AAC7) then
                print('PhotoModeTakePhoto')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeTakePhoto')
            end
            if IsControlJustPressed(0, 0x2F13EC9A) then
                print('PhotoModeBack')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeBack')
            end
            if IsControlJustPressed(0, 0x8F32E2EB) then
                print('PhotoModeSwitchMode')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeSwitchMode')
            end
            if IsControlJustPressed(0, 0xFE6DD360) then
                print('PhotoModeFilterIntensity')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFilterIntensity')
            end
            if IsControlJustPressed(0, 0x2286D46B) then
                print('PhotoModeFilterIntensityUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFilterIntensityUp')
            end
            if IsControlJustPressed(0, 0xB341F407) then
                print('PhotoModeFilterIntensityDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFilterIntensityDown')
            end
            if IsControlJustPressed(0, 0x886ABA4E) then
                print('PhotoModeFocalLength')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFocalLength')
            end
            if IsControlJustPressed(0, 0xFAFBD66A) then
                print('PhotoModeFocalLengthUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFocalLengthUpOnly')
            end
            if IsControlJustPressed(0, 0x01EBFABD) then
                print('PhotoModeFocalLengthDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFocalLengthDownOnly')
            end
            if IsControlJustPressed(0, 0x699F8D08) then
                print('PhotoModeFilterNext')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFilterNext')
            end
            if IsControlJustPressed(0, 0x4F640885) then
                print('PhotoModeFilterPrev')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeFilterPrev')
            end
            if IsControlJustPressed(0, 0x5B843BC9) then
                print('PhotoModeZoomIn')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeZoomIn')
            end
            if IsControlJustPressed(0, 0x2354D2E6) then
                print('PhotoModeZoomOut')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeZoomOut')
            end
            if IsControlJustPressed(0, 0x26B9AE6A) then
                print('PhotoModeDof')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeDof')
            end
            if IsControlJustPressed(0, 0x87B07940) then
                print('PhotoModeDofUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeDofUpOnly')
            end
            if IsControlJustPressed(0, 0x047099F1) then
                print('PhotoModeDofDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeDofDownOnly')
            end
            if IsControlJustPressed(0, 0xC64E2284) then
                print('PhotoModeExposureUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeExposureUp')
            end
            if IsControlJustPressed(0, 0xAD07A5A5) then
                print('PhotoModeExposureDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeExposureDown')
            end
            if IsControlJustPressed(0, 0x9DE08D71) then
                print('PhotoModeExposureLock')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeExposureLock')
            end
            if IsControlJustPressed(0, 0x483F707F) then
                print('PhotoModeContrast')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeContrast')
            end
            if IsControlJustPressed(0, 0x5D2DD717) then
                print('PhotoModeContrastUpOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeContrastUpOnly')
            end
            if IsControlJustPressed(0, 0x30811620) then
                print('PhotoModeContrastDownOnly')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'PhotoModeContrastDownOnly')
            end
            if IsControlJustPressed(0, 0xB99A9CAD) then
                print('CraftingEat')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CraftingEat')
            end
            if IsControlJustPressed(0, 0x0B1BE2E8) then
                print('CampSetupTent')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'CampSetupTent')
            end
            if IsControlJustPressed(0, 0x1D927DF2) then
                print('MinigameActionX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'MinigameActionX')
            end
            if IsControlJustPressed(0, 0xC1D24F92) then
                print('DeprecatedAbove')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'DeprecatedAbove')
            end
            if IsControlJustPressed(0, 0x1F8EEF84) then
                print('ScriptLeftAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptLeftAxisX')
            end
            if IsControlJustPressed(0, 0x5418D8AB) then
                print('ScriptLeftAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptLeftAxisY')
            end
            if IsControlJustPressed(0, 0xA6B769E9) then
                print('ScriptRightAxisX')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRightAxisX')
            end
            if IsControlJustPressed(0, 0x27A5EBC0) then
                print('ScriptRightAxisY')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRightAxisY')
            end
            if IsControlJustPressed(0, 0x771D6E13) then
                print('ScriptRup')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRup')
            end
            if IsControlJustPressed(0, 0x37933367) then
                print('ScriptRdown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRdown')
            end
            if IsControlJustPressed(0, 0xA4DB0458) then
                print('ScriptRleft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRleft')
            end
            if IsControlJustPressed(0, 0x22A3B800) then
                print('ScriptRright')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRright')
            end
            if IsControlJustPressed(0, 0xE624C062) then
                print('ScriptLb')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptLb')
            end
            if IsControlJustPressed(0, 0x91E9231C) then
                print('ScriptRb')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRb')
            end
            if IsControlJustPressed(0, 0x2B314A1E) then
                print('ScriptLt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptLt')
            end
            if IsControlJustPressed(0, 0x26E9CD17) then
                print('ScriptRt')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRt')
            end
            if IsControlJustPressed(0, 0xAADDC975) then
                print('ScriptLs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptLs')
            end
            if IsControlJustPressed(0, 0xD04E9FE2) then
                print('ScriptRs')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptRs')
            end
            if IsControlJustPressed(0, 0x0DC15ADD) then
                print('ScriptPadUp')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptPadUp')
            end
            if IsControlJustPressed(0, 0xB1DA5574) then
                print('ScriptPadDown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptPadDown')
            end
            if IsControlJustPressed(0, 0x1AF81D9E) then
                print('ScriptPadLeft')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptPadLeft')
            end
            if IsControlJustPressed(0, 0x82A9B758) then
                print('ScriptPadRight')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptPadRight')
            end
            if IsControlJustPressed(0, 0xC8722109) then
                print('ScriptSelect')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptSelect')
            end
            if IsControlJustPressed(0, 0xAEB4B1DE) then
                print('ScriptedFlyUd')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptedFlyUd')
            end
            if IsControlJustPressed(0, 0xF1111E4A) then
                print('ScriptedFlyLr')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptedFlyLr')
            end
            if IsControlJustPressed(0, 0x639B9FC9) then
                print('ScriptedFlyZup')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptedFlyZup')
            end
            if IsControlJustPressed(0, 0x9C5E030C) then
                print('ScriptedFlyZdown')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'ScriptedFlyZdown')
            end
            if IsControlJustPressed(0, 0x8EDFFB30) then
                print('Count')
                TriggerEvent('chatMessage', 'CONTROL', {0, 0, 0}, 'Count')
            end
        end
    end
)
