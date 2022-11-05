local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local ESX = nil
smontando = false

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[function ApriMenuSmonta()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weapon_menu', {
        title = 'Smonta Armi',
        align = 'top-left',
        elements = {{label = 'Smonta Armi', value = 'azioni'}}
    }, function(data, menu)
        local val = data.current.value
        if val == 'azioni' then ApriMenuSmontaArmiSubMenu() end
    end, function(data, menu) menu.close() end)
end

function ApriMenuSmontaArmiSubMenu()
    -- lista armi per il menu
    local elements = {}

    for k, v in pairs(Config.Weapons) do
        if HasPedGotWeapon(PlayerPedId(), GetHashKey(k), false) then
            table.insert(elements, {label = 'Smonta ' .. v.label, value = k})
        end
    end

    -- Gestione armature
    --[[if (GetPedArmour(GetPlayerPed(-1)) <= 25 and GetPedArmour(GetPlayerPed(-1)) >
        0) then
        table.insert(elements, {label = 'Smonta Armatura Leggera', value = 'SmallArmor'})
    end

    if (GetPedArmour(GetPlayerPed(-1)) <= 50 and GetPedArmour(GetPlayerPed(-1)) >
        25) then
        table.insert(elements, {label = 'Smonta Armatura Media', value = 'MedArmor'})
    end

    if (GetPedArmour(GetPlayerPed(-1)) <= 75 and GetPedArmour(GetPlayerPed(-1)) >
        50) then
        table.insert(elements, { label = 'Smonta Armatura Pesante', value = 'HeavyArmor' })
    end--]]

    --[[ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'id_card_menu', {
        title = 'Smonta Armi',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        menu.close()

        local playerPed = PlayerPedId()

        if data.current.value == 'SmallArmor' or data.current.value == 'MedArmor' or data.current.value == 'HeavyArmor' then
            -- Smonta armatura
            SetPedArmour(GetPlayerPed(-1), 0)
            TriggerServerEvent('frazzsmontaarmi:smonta_armatura', data.current.value)
        else
            -- Smonta arma
            menu.close()
            ESX.UI.Menu.CloseAll()
            smontando = true
            disabilitatasti = true
            local rounds = GetAmmoInPedWeapon(playerPed, GetHashKey(data.current.value))
           --exports['progressBars']:startUI(3500, "Indossando i tuoi vestiti")
            --ESX.ShowNotification('Smontando ' .. data.item.label .. '')

                if data.current.value == 'WEAPON_PISTOL' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_VINTAGEPISTOL' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola Vintage', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_PISTOL_MK2' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola MK2', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_COMBATPISTOL' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola da Combattimento', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_PISTOL50' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola Cal. 50', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_APPISTOL' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola AP', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_STUNGUN' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Storditore', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_SNSPISTOL' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola SNS', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_HEAVYPISTOL' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Pistola Pesante', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_REVOLVER' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Revolver', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_DOUBLEACTION' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Revolver a Doppia Azione', source)
                elseif data.current.value == 'WEAPON_MICROSMG' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Micro SMG', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_SMG' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando SMG', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_SMG_MK2' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando SMG MK2', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_ASSAULTSMG' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando P90', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_COMBATPDW' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando PDW da Combattimento', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_MACHINEPISTOL' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Machine Pistol', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_MINISMG' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Mini SMG', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_PUMPSHOTGUN' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Fucile a Pompa', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_SAWNOFFSHOTGUN' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Sawn Off', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_DBSHOTGUN' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Fucile a Canne Mozze', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_ASSAULTRIFLE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando AK-47', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_CARBINERIFLE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Carabina', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_CARBINERIFLE_MK2' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Carabina MK2', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_ADVANCEDRIFLE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Fucile Avanzato', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_SPECIALCARBINE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Scar-H', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_BULLPUPRIFLE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Famas', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_COMPACTRIFLE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Fucile Compatto', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_GUSENBERG' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Thompson', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_SNIPERRIFLE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Fucile da Cecchino', source)
                    animSmonta()
                elseif data.current.value == 'WEAPON_MARKSMANRIFLE' then
                    TriggerServerEvent('3dme:shareDisplay', 'Smontando Fucile da Cecchino Pesante', source)
                    animSmonta()
                end

            Citizen.Wait(2000)
            
            if data.current.value == 'WEAPON_PISTOL' then
                if HasPedGotWeapon(PlayerPedId(), 0x1B06D571, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_AT_PI_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_AT_PI_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('component_at_pi_supp_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('component_at_pi_supp_02'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_COMBATPISTOL' then
                if HasPedGotWeapon(PlayerPedId(), 0x5EF9FEC4, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_SUPP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02'))
                    end
                end 
            elseif data.current.value == 'WEAPON_PISTOL50' then
                if HasPedGotWeapon(PlayerPedId(), 0x99AEEB3B, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_PI_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_PI_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_VINTAGEPISTOL' then
                if HasPedGotWeapon(PlayerPedId(), 0x83839C4, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x83839C4, GetHashKey('COMPONENT_AT_PI_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x83839C4, GetHashKey('COMPONENT_AT_PI_SUPP'))
                    end
                end
            elseif data.current.value == 'WEAPON_APPISTOL' then
                if HasPedGotWeapon(PlayerPedId(), 0x22D8FE39, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_SUPP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_SNSPISTOL' then
                if HasPedGotWeapon(PlayerPedId(), 0xBFD21232, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_HEAVYPISTOL' then
                if HasPedGotWeapon(PlayerPedId(), 0xD205520E, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_SUPP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_MICROSMG' then
                if HasPedGotWeapon(PlayerPedId(), 0x13532244, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_PI_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_PI_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_SMG' then
                if HasPedGotWeapon(PlayerPedId(), 0x2BE6766B, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_PI_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_PI_SUPP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_ASSAULTSMG' then
                if HasPedGotWeapon(PlayerPedId(), 0xEFE7E2DF, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_COMBATPDW' then
                if HasPedGotWeapon(PlayerPedId(), 0x0A3D4D34, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_COMBATPDW_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_COMBATPDW_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_PUMPSHOTGUN' then
                if HasPedGotWeapon(PlayerPedId(), 0x1D073A89, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x1D073A89, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x1D073A89, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                end
            elseif data.current.value == 'WEAPON_ASSAULTRIFLE' then
                if HasPedGotWeapon(PlayerPedId(), 0xBFEFFF6D, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'mirino')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_CARBINERIFLE' then
                if HasPedGotWeapon(PlayerPedId(), 0x83BF0278, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_SUPP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_ADVANCEDRIFLE' then
                if HasPedGotWeapon(PlayerPedId(), 0xAF113F99, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_SUPP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'skin')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_SPECIALCARBINE' then
                if HasPedGotWeapon(PlayerPedId(), 0xC0A3098D, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
                    end 
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'mirino')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02'))
                    end
                end
            elseif data.current.value == 'WEAPON_BULLPUPRIFLE' then
                if HasPedGotWeapon(PlayerPedId(), 0x7F229F94, false) then
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_FLSH')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_FLSH'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_SUPP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_SUPP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
                    end
                    if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02')) then
                        --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
                        RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02'))
                    end
                end
            end
            
            if HasPedGotWeapon(PlayerPedId(), GetHashKey(data.current.value), false) and smontando then
                TriggerServerEvent('frazzsmontaarmi:smonta', data.current.value, rounds)
            else
                --ESX.ShowNotification('L\'arma che stavi smontando non è più nel tuo inventario, per cui non riceverai l\'item!')
                TriggerEvent('Notify', 'negado',"Errore","L\'arma che stavi smontando non è più nel tuo inventario, per cui non riceverai l\'item!")

            end
            
            Citizen.Wait(500)
            smontando = false
            disabilitatasti = false
        end

    end, function(data, menu) menu.close() end)
end--]]

CreateThread(function()
	while true do
        local s = 1000
		if disabilitatasti then
            s = 0
            DisableControlAction(1, Keys['F2'], true) 
            DisableControlAction(1, Keys['F3'], true) 
            DisableControlAction(1, Keys['TAB'], true) 
		end
        Wait(s)
	end
end)
--------------------------------------------------------------------------------
-- EVENTI BELLI
--------------------------------------------------------------------------------

-- Smonta tutte le armi
-- RegisterNetEvent('frazzsmontaarmi:disarm')
-- AddEventHandler('frazzsmontaarmi:disarm', function()
--     local playerPed = PlayerPedId()

--     for k, v in pairs(Config.Weapons) do
--         local weaponHash = GetHashKey(k)
--         if HasPedGotWeapon(playerPed, weaponHash, false) then
--             local rounds = GetAmmoInPedWeapon(playerPed, weaponHash)
--             TriggerServerEvent('frazzsmontaarmi:smonta', k, rounds)
--             RemoveWeaponFromPed(playerPed, weaponHash)
--         end
--     end

-- end)

RegisterNetEvent('frazzsmontaarmi:disarm')
AddEventHandler('frazzsmontaarmi:disarm', function()
    local playerPed = PlayerPedId()

        if HasPedGotWeapon(playerPed, "WEAPON_PISTOL_MK2", false) and not HasPedGotWeapon(playerPed, "WEAPON_COMBATPISTOL", false) and not HasPedGotWeapon(playerPed, "WEAPON_PISTOL", false) then
            local rounds = GetAmmoInPedWeapon(playerPed, "WEAPON_PISTOL_MK2") -- HA MK2, NON HA PISTOLA, NON HA COMBAT
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_PISTOL_MK2", rounds)
            RemoveWeaponFromPed(playerPed, "WEAPON_PISTOL_MK2")

        elseif HasPedGotWeapon(playerPed, "WEAPON_COMBATPISTOL", false) and not HasPedGotWeapon(playerPed, "WEAPON_PISTOL_MK2", false) and not HasPedGotWeapon(playerPed, "WEAPON_PISTOL", false) then
            local rounds = GetAmmoInPedWeapon(playerPed, "WEAPON_COMBATPISTOL") -- HA COMBAT, NON HA PISTOLA, NON HA MK2
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_COMBATPISTOL", rounds)
            RemoveWeaponFromPed(playerPed, "WEAPON_COMBATPISTOL")

        elseif HasPedGotWeapon(playerPed, "WEAPON_PISTOL", false) and not HasPedGotWeapon(playerPed, "WEAPON_PISTOL_MK2", false) and not HasPedGotWeapon(playerPed, "WEAPON_COMBATPISTOL", false) then
            local rounds = GetAmmoInPedWeapon(playerPed, "WEAPON_PISTOL") -- HA PISTOLA, NON HA MK2, NON HA COMBAT
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_PISTOL", rounds)
            RemoveWeaponFromPed(playerPed, "WEAPON_PISTOL")
            
        elseif HasPedGotWeapon(playerPed, "WEAPON_PISTOL_MK2", false) and HasPedGotWeapon(playerPed, "WEAPON_COMBATPISTOL", false) and not HasPedGotWeapon(playerPed, "WEAPON_PISTOL", false) then
            local rounds = GetAmmoInPedWeapon(playerPed, "WEAPON_COMBATPISTOL") -- HA MK2, HA COMBAT, NON HA PISTOLA
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_PISTOL_MK2", 0)
            RemoveWeaponFromPed(playerPed, "WEAPON_PISTOL_MK2")
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_COMBATPISTOL", rounds)
            RemoveWeaponFromPed(playerPed, "WEAPON_COMBATPISTOL")

        elseif HasPedGotWeapon(playerPed, "WEAPON_PISTOL_MK2", false) and HasPedGotWeapon(playerPed, "WEAPON_PISTOL", false) and not HasPedGotWeapon(playerPed, "WEAPON_COMBATPISTOL", false) then
            local rounds = GetAmmoInPedWeapon(playerPed, "WEAPON_PISTOL_MK2") -- HA MK2, HA PISTOLA, NON HA COMBAT
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_PISTOL_MK2", rounds)
            RemoveWeaponFromPed(playerPed, "WEAPON_PISTOL_MK2")
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_PISTOL", 0)
            RemoveWeaponFromPed(playerPed, "WEAPON_PISTOL")
        elseif HasPedGotWeapon(playerPed, "WEAPON_ASSAULTRIFLE_MK2", false) then
            local rounds = GetAmmoInPedWeapon(playerPed, "WEAPON_ASSAULTRIFLE_MK2") -- HA MK2, HA PISTOLA, NON HA COMBAT
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_ASSAULTRIFLE_MK2", rounds)
            RemoveWeaponFromPed(playerPed, "WEAPON_ASSAULTRIFLE_MK2")
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_ASSAULTRIFLE_MK2", 0)
            RemoveWeaponFromPed(playerPed, "WEAPON_ASSAULTRIFLE_MK2")


        elseif not HasPedGotWeapon(playerPed, "WEAPON_PISTOL_MK2", false) and HasPedGotWeapon(playerPed, "WEAPON_PISTOL", false) and HasPedGotWeapon(playerPed, "WEAPON_COMBATPISTOL", false) then
            local rounds = GetAmmoInPedWeapon(playerPed, "WEAPON_COMBATPISTOL") -- NON HA MK2, HA PISTOLA, HA COMBAT
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_COMBATPISTOL", rounds)
            RemoveWeaponFromPed(playerPed, "WEAPON_COMBATPISTOL")
            TriggerServerEvent('frazzsmontaarmi:smonta', "WEAPON_PISTOL", 0)
            RemoveWeaponFromPed(playerPed, "WEAPON_PISTOL")
        end

end)

--------------------------------------------------------------------------------
-- REGISTER NET EVENT PER SMONTARE LE ARMI
--------------------------------------------------------------------------------

RegisterNetEvent('montaammopistola')
AddEventHandler('montaammopistola', function(munizioni, maxy)

	local playerPed  = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash) 

	local somma = math.floor(pedAmmo + munizioni)
    
    if weaponHash == GetHashKey("WEAPON_PISTOL") or weaponHash == GetHashKey("WEAPON_PISTOL") or weaponHash == GetHashKey("WEAPON_PISTOL50") or weaponHash == GetHashKey("WEAPON_COMBATPISTOL") or weaponHash == GetHashKey("WEAPON_APPISTOL") or weaponHash == GetHashKey("WEAPON_SNSPISTOL") or weaponHash == GetHashKey("WEAPON_HEAVYPISTOL") or weaponHash == GetHashKey("WEAPON_REVOLVER") or weaponHash == GetHashKey("WEAPON_DOUBLEACTION") or weaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") or weaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
    
        if (HasPedGotWeapon(PlayerPedId(), 0x1B06D571, false) and GetCurrentPedWeapon(PlayerPedId(), 0x1B06D571)) --[[PISTOLA]]
        or (HasPedGotWeapon(PlayerPedId(), 0x99AEEB3B, false) and GetCurrentPedWeapon(PlayerPedId(), 0x99AEEB3B)) --[[PISTOLA CAL.50]]
        or (HasPedGotWeapon(PlayerPedId(), 0x5EF9FEC4, false) and GetCurrentPedWeapon(PlayerPedId(), 0x5EF9FEC4)) --[[PISTOLA DA COMBATT]]
        or (HasPedGotWeapon(PlayerPedId(), 0x22D8FE39, false) and GetCurrentPedWeapon(PlayerPedId(), 0x22D8FE39)) --[[PISTOLA AP]]
        or (HasPedGotWeapon(PlayerPedId(), 0xBFD21232, false) and GetCurrentPedWeapon(PlayerPedId(), 0xBFD21232)) --[[SNS PISTOL]]
        or (HasPedGotWeapon(PlayerPedId(), 0xD205520E, false) and GetCurrentPedWeapon(PlayerPedId(), 0xD205520E)) --[[HEAVY PISTOL]]
        or (HasPedGotWeapon(PlayerPedId(), 0xC1B3C3D1, false) and GetCurrentPedWeapon(PlayerPedId(), 0xC1B3C3D1)) --[[REVOLVER]]
        or (HasPedGotWeapon(PlayerPedId(), 0x97EA20B8, false) and GetCurrentPedWeapon(PlayerPedId(), 0x97EA20B8)) --[[ROPPIA AZIONE]]
        or (HasPedGotWeapon(PlayerPedId(), 0x83839C4, false) and GetCurrentPedWeapon(PlayerPedId(), 0x83839C4)) --[[PISTOLA VINTAGE]]
        or (HasPedGotWeapon(PlayerPedId(), 0xBFE256D4, false) and GetCurrentPedWeapon(PlayerPedId(), 0xBFE256D4)) --[[PISTOLA MK2]]		then 
            if somma <= 252 then
                if weaponHash == GetHashKey("WEAPON_PISTOL") then
                SetPedAmmo(playerPed, 0x1B06D571, somma)
                elseif weaponHash == GetHashKey("WEAPON_PISTOL50") then
                SetPedAmmo(playerPed, 0x99AEEB3B, somma)
                elseif weaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
                SetPedAmmo(playerPed, 0x5EF9FEC4, somma)
                elseif weaponHash == GetHashKey("WEAPON_APPISTOL") then
                SetPedAmmo(playerPed, 0x22D8FE39, somma)
                elseif weaponHash == GetHashKey("WEAPON_SNSPISTOL") then
                SetPedAmmo(playerPed, 0xBFD21232, somma)
                elseif weaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
                SetPedAmmo(playerPed, 0xD205520E, somma)
                elseif weaponHash == GetHashKey("WEAPON_REVOLVER") then
                SetPedAmmo(playerPed, 0xC1B3C3D1, somma)
                elseif weaponHash == GetHashKey("WEAPON_DOUBLEACTION") then
                SetPedAmmo(playerPed, 0x97EA20B8, somma)
				elseif weaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
                SetPedAmmo(playerPed, 0x83839C4, somma)
                elseif weaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
                SetPedAmmo(playerPed, 0xBFE256D4, somma)
                end
            else
                local differenza = math.floor(somma - maxy) 
                if weaponHash == GetHashKey("WEAPON_PISTOL") then
                SetPedAmmo(playerPed, 0x1B06D571, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                elseif weaponHash == GetHashKey("WEAPON_PISTOL50") then
                SetPedAmmo(playerPed, 0x99AEEB3B, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                elseif weaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
                SetPedAmmo(playerPed, 0x5EF9FEC4, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                elseif weaponHash == GetHashKey("WEAPON_APPISTOL") then
                SetPedAmmo(playerPed, 0x22D8FE39, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)                
                elseif weaponHash == GetHashKey("WEAPON_SNSPISTOL") then
                SetPedAmmo(playerPed, 0xBFD21232, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                elseif weaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
                SetPedAmmo(playerPed, 0xD205520E, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                elseif weaponHash == GetHashKey("WEAPON_REVOLVER") then
                SetPedAmmo(playerPed, 0xC1B3C3D1, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                elseif weaponHash == GetHashKey("WEAPON_DOUBLEACTION") then
                SetPedAmmo(playerPed, 0x97EA20B8, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
				elseif weaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
                SetPedAmmo(playerPed, 0x83839C4, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                elseif weaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
                SetPedAmmo(playerPed, 0xBFE256D4, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
                end
            end
        else
            --ESX.ShowNotification('Devi avere una pistola in mano per poterla ricaricare!')
            TriggerEvent('Notify', 'aviso',"Avviso","Devi avere una pistola in mano per poterla ricaricare!")
            TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
        end
    else
        --ESX.ShowNotification('Queste munizioni non sono adatte a quest\'arma')
        TriggerEvent('Notify', 'negado',"Errore","Queste munizioni non sono adatte a quest\'arma")
        TriggerServerEvent('smontaarmi:munizionifix', 'mun_pistola', 1)
    end
	
end)

RegisterNetEvent('montaammoleggere')
AddEventHandler('montaammoleggere', function(munizioni, maxy)

	local playerPed  = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash) 

	local somma = math.floor(pedAmmo + munizioni)
    
    if weaponHash == GetHashKey("WEAPON_MICROSMG") or weaponHash == GetHashKey("WEAPON_SMG") or weaponHash == GetHashKey("WEAPON_SMG_MK2") or weaponHash == GetHashKey("WEAPON_ASSAULTSMG") or weaponHash == GetHashKey("WEAPON_COMBATPDW") or weaponHash == GetHashKey("WEAPON_MACHINEPISTOL") or weaponHash == GetHashKey("WEAPON_MINISMG") then
    
        if (HasPedGotWeapon(PlayerPedId(), 0x13532244, false) and GetCurrentPedWeapon(PlayerPedId(), 0x13532244)) --[[MICRO SMG]]
        or (HasPedGotWeapon(PlayerPedId(), 0x2BE6766B, false) and GetCurrentPedWeapon(PlayerPedId(), 0x2BE6766B)) --[[SMG]]
        or (HasPedGotWeapon(PlayerPedId(), 0x78A97CD0, false) and GetCurrentPedWeapon(PlayerPedId(), 0x78A97CD0)) --[[SMGMK2]]
        or (HasPedGotWeapon(PlayerPedId(), 0xEFE7E2DF, false) and GetCurrentPedWeapon(PlayerPedId(), 0xEFE7E2DF)) --[[SMG DI ASSALTO]]
        or (HasPedGotWeapon(PlayerPedId(), 0x0A3D4D34, false) and GetCurrentPedWeapon(PlayerPedId(), 0x0A3D4D34)) --[[PDW DA COMBATTIMENTO]]
        or (HasPedGotWeapon(PlayerPedId(), 0xDB1AA450, false) and GetCurrentPedWeapon(PlayerPedId(), 0xDB1AA450)) --[[MACHINE PISTOL]]
        or (HasPedGotWeapon(PlayerPedId(), 0xBD248B55, false) and GetCurrentPedWeapon(PlayerPedId(), 0xBD248B55)) --[[MINI SMG]] then 
            if somma <= 252 then
                if weaponHash == GetHashKey("WEAPON_MICROSMG") then
                SetPedAmmo(playerPed, 0x13532244, somma)
                elseif weaponHash == GetHashKey("WEAPON_SMG") then
                SetPedAmmo(playerPed, 0x2BE6766B, somma)
                elseif weaponHash == GetHashKey("WEAPON_SMG_MK2") then
                SetPedAmmo(playerPed, 0x78A97CD0, somma)
                elseif weaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
                SetPedAmmo(playerPed, 0xEFE7E2DF, somma)
                elseif weaponHash == GetHashKey("WEAPON_COMBATPDW") then
                SetPedAmmo(playerPed, 0x0A3D4D34, somma)
                elseif weaponHash == GetHashKey("WEAPON_MACHINEPISTOL") then
                SetPedAmmo(playerPed, 0xDB1AA450, somma)
                elseif weaponHash == GetHashKey("WEAPON_MINISMG") then
                SetPedAmmo(playerPed, 0xBD248B55, somma)
                end
            else
                local differenza = math.floor(somma - maxy) 
                if weaponHash == GetHashKey("WEAPON_MICROSMG") then
                SetPedAmmo(playerPed, 0x13532244, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)
                elseif weaponHash == GetHashKey("WEAPON_SMG") then
                SetPedAmmo(playerPed, 0x2BE6766B, maxy)
                elseif weaponHash == GetHashKey("WEAPON_SMG_MK2") then
                SetPedAmmo(playerPed, 0x78A97CD0, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)
                elseif weaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
                SetPedAmmo(playerPed, 0xEFE7E2DF, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)
                elseif weaponHash == GetHashKey("WEAPON_COMBATPDW") then
                SetPedAmmo(playerPed, 0x0A3D4D34, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)                
                elseif weaponHash == GetHashKey("WEAPON_MACHINEPISTOL") then
                SetPedAmmo(playerPed, 0xDB1AA450, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)
                elseif weaponHash == GetHashKey("WEAPON_MINISMG") then
                SetPedAmmo(playerPed, 0xBD248B55, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)
                end
            end
        else
            --ESX.ShowNotification('Devi avere un\'arma automatica leggera in mano per poterla ricaricare!')
            TriggerEvent('Notify', 'aviso',"Avviso","Devi avere un\'arma automatica leggera in mano per poterla ricaricare!")
            TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)
        end
    else
       -- ESX.ShowNotification('Queste munizioni non sono adatte a quest\'arma')
        TriggerEvent('Notify', 'negado',"Errore","Queste munizioni non sono adatte a quest\'arma")
        TriggerServerEvent('smontaarmi:munizionifix', 'mun_smg', 1)
    end
	
end)

RegisterNetEvent('montaammopompa')
AddEventHandler('montaammopompa', function(munizioni, maxy)

	local playerPed  = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash) 

	local somma = math.floor(pedAmmo + munizioni)
    
    if weaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") or weaponHash == GetHashKey("WEAPON_SAWNOFFSHOTGUN") or weaponHash == GetHashKey("WEAPON_DBSHOTGUN") then
    
        if (HasPedGotWeapon(PlayerPedId(), 0x1D073A89, false) and GetCurrentPedWeapon(PlayerPedId(), 0x1D073A89)) --[[FUCILE A POMPA]]
        or (HasPedGotWeapon(PlayerPedId(), 0x7846A318, false) and GetCurrentPedWeapon(PlayerPedId(), 0x7846A318)) --[[SAWN OFF]]
        or (HasPedGotWeapon(PlayerPedId(), 0xEF951FBB, false) and GetCurrentPedWeapon(PlayerPedId(), 0xEF951FBB)) --[[FUCILE A CANNE MOZZE]] then 
            if somma <= 252 then
                if weaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
                SetPedAmmo(playerPed, 0x1D073A89, somma)
                elseif weaponHash == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
                SetPedAmmo(playerPed, 0x7846A318, somma)
                elseif weaponHash == GetHashKey("WEAPON_DBSHOTGUN") then
                SetPedAmmo(playerPed, 0xEF951FBB, somma)
                end
            else
                local differenza = math.floor(somma - maxy) 
                if weaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
                SetPedAmmo(playerPed, 0x1D073A89, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pompa', 1)
                elseif weaponHash == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
                SetPedAmmo(playerPed, 0x7846A318, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pompa', 1)
                elseif weaponHash == GetHashKey("WEAPON_DBSHOTGUN") then
                SetPedAmmo(playerPed, 0xEF951FBB, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_pompa', 1)
                end
            end
        else
            --ESX.ShowNotification('Devi avere un fucile a pompa in mano per poterla ricaricare!')
            TriggerEvent('Notify', 'aviso',"Avviso","Devi avere un fucile a pompa in mano per poterlo ricaricare!")
            TriggerServerEvent('smontaarmi:munizionifix', 'mun_pompa', 1)
        end
    else
        --ESX.ShowNotification('Queste munizioni non sono adatte a quest\'arma')
        TriggerEvent('Notify', 'negado',"Errore","Queste munizioni non sono adatte a quest\'arma")
        TriggerServerEvent('smontaarmi:munizionifix', 'mun_pompa', 1)
    end
	
end)

RegisterNetEvent('montaammoassalto')
AddEventHandler('montaammoassalto', function(munizioni, maxy)

	local playerPed  = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash) 

	local somma = math.floor(pedAmmo + munizioni)
    
    if weaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") or weaponHash == GetHashKey("WEAPON_CARBINERIFLE") or weaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") or weaponHash == GetHashKey("WEAPON_SPECIALCARBINE") or weaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") or weaponHash == GetHashKey("WEAPON_COMPACTRIFLE") or weaponHash == GetHashKey("WEAPON_GUSENBERG") or weaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
    
        if (HasPedGotWeapon(PlayerPedId(), 0xBFEFFF6D, false) and GetCurrentPedWeapon(PlayerPedId(), 0xBFEFFF6D)) --[[ASSAULT RIFLE]]
        or (HasPedGotWeapon(PlayerPedId(), 0x83BF0278, false) and GetCurrentPedWeapon(PlayerPedId(), 0x83BF0278)) --[[CARABINA]]
        or (HasPedGotWeapon(PlayerPedId(), 0xAF113F99, false) and GetCurrentPedWeapon(PlayerPedId(), 0xAF113F99)) --[[FUCILE AVANZATO]]
        or (HasPedGotWeapon(PlayerPedId(), 0xC0A3098D, false) and GetCurrentPedWeapon(PlayerPedId(), 0xC0A3098D)) --[[CARABINA SPECIALE]] 
        or (HasPedGotWeapon(PlayerPedId(), 0x7F229F94, false) and GetCurrentPedWeapon(PlayerPedId(), 0x7F229F94)) --[[FUCILE BULLPUP]]
        or (HasPedGotWeapon(PlayerPedId(), 0x624FE830, false) and GetCurrentPedWeapon(PlayerPedId(), 0x624FE830)) --[[FUCILE COMPATTO]]
        or (HasPedGotWeapon(PlayerPedId(), 0x61012683, false) and GetCurrentPedWeapon(PlayerPedId(), 0x61012683)) --[[THOMPSON]]
        or (HasPedGotWeapon(PlayerPedId(), 0xFAD1F1C9, false) and GetCurrentPedWeapon(PlayerPedId(), 0xFAD1F1C9)) --[[CARABINA MK2]] then 
            if somma <= 252 then
                if weaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
                SetPedAmmo(playerPed, 0xBFEFFF6D, somma)
                elseif weaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
                SetPedAmmo(playerPed, 0x83BF0278, somma)
                elseif weaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
                SetPedAmmo(playerPed, 0xFAD1F1C9, somma)
                elseif weaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
                SetPedAmmo(playerPed, 0xAF113F99, somma)
                elseif weaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
                SetPedAmmo(playerPed, 0xC0A3098D, somma)
                elseif weaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
                SetPedAmmo(playerPed, 0x7F229F94, somma)
                elseif weaponHash == GetHashKey("WEAPON_COMPACTRIFLE") then
                SetPedAmmo(playerPed, 0x624FE830, somma)
                elseif weaponHash == GetHashKey("WEAPON_GUSENBERG") then
                SetPedAmmo(playerPed, 0x61012683, somma)
                end
            else
                local differenza = math.floor(somma - maxy) 
                if weaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
                SetPedAmmo(playerPed, 0xBFEFFF6D, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', differenza)
                elseif weaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
                SetPedAmmo(playerPed, 0x83BF0278, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
                elseif weaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
                SetPedAmmo(playerPed, 0xFAD1F1C9, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
                elseif weaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
                SetPedAmmo(playerPed, 0xAF113F99, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
                elseif weaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
                SetPedAmmo(playerPed, 0xC0A3098D, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
                elseif weaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
                SetPedAmmo(playerPed, 0x7F229F94, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
                elseif weaponHash == GetHashKey("WEAPON_COMPACTRIFLE") then
                SetPedAmmo(playerPed, 0x624FE830, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
                elseif weaponHash == GetHashKey("WEAPON_GUSENBERG") then
                SetPedAmmo(playerPed, 0x61012683, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
                end
            end
        else
            --ESX.ShowNotification('Devi avere un fucile d\'assalto in mano per poterlo ricaricare!')
            TriggerEvent('Notify', 'aviso',"Avviso","Devi avere un fucile d\'assalto in mano per poterlo ricaricare!")
            TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
            end
        else
            --ESX.ShowNotification('Queste munizioni non sono adatte a quest\'arma')
            TriggerEvent('Notify', 'negado',"Errore","Queste munizioni non sono adatte a quest\'arma")
            TriggerServerEvent('smontaarmi:munizionifix', 'mun_fucili', 1)
        end
        
end)

RegisterNetEvent('montaammocecchino')
AddEventHandler('montaammocecchino', function(munizioni, maxy)

	local playerPed  = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash) 

	local somma = math.floor(pedAmmo + munizioni)
    
    if weaponHash == GetHashKey("WEAPON_SNIPERRIFLE") or weaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
    
        if (HasPedGotWeapon(PlayerPedId(), 0x05FC3C11, false) and GetCurrentPedWeapon(PlayerPedId(), 0x05FC3C11)) --[[CECCHINO LEGGERO]]
        or (HasPedGotWeapon(PlayerPedId(), 0xC734385, false) and GetCurrentPedWeapon(PlayerPedId(), 0xC734385)) --[[CECCHINO PESANTE]] then 
            if somma <= 252 then
                if weaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
                SetPedAmmo(playerPed, 0x05FC3C11, somma)
                elseif weaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
                SetPedAmmo(playerPed, 0xC734385, somma)
                end
            else
                local differenza = math.floor(somma - maxy) 
                if weaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
                SetPedAmmo(playerPed, 0x05FC3C11, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'cecAmmo', 1)
                elseif weaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
                SetPedAmmo(playerPed, 0xC734385, maxy)
                TriggerServerEvent('smontaarmi:munizionifix', 'cecAmmo', 1)
                end
            end
        else
            --ESX.ShowNotification('Devi avere un cecchino in mano per poterla ricaricare!')
            TriggerEvent('Notify', 'aviso',"Avviso","Devi avere un cecchino in mano per poterlo ricaricare!")
            
            TriggerServerEvent('smontaarmi:munizionifix', 'cecAmmo', 1)
            end
        else
            --ESX.ShowNotification('Queste munizioni non sono adatte a quest\'arma')
            TriggerEvent('Notify', 'negado',"Errore","Queste munizioni non sono adatte a quest\'arma")
            TriggerServerEvent('smontaarmi:munizionifix', 'cecAmmo', 1)
        end
        
end)

--------------------------------------------------------------------------------
-- TASTO PER APRIRE IL MENU
--------------------------------------------------------------------------------

RegisterNetEvent('frazzsmontaarmi:aprimenu')
AddEventHandler('frazzsmontaarmi:aprimenu', function()

    if not smontando then 
        ApriMenuSmonta()
    else
        --ESX.ShowNotification('Non puoi aprire il menu se stai smontando un arma!')
        TriggerEvent('Notify', 'importante',"Importante","Non puoi aprire il menu se stai smontando un arma!")
    end

end)

RegisterNetEvent('frazz:componenti')
AddEventHandler('frazz:componenti', function()

    if HasPedGotWeapon(PlayerPedId(), 0x1B06D571, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_AT_PI_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_AT_PI_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('component_at_pi_supp_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('component_at_pi_supp_02'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x1B06D571, GetHashKey('COMPONENT_PISTOL_CLIP_02'))
        end
    end 

    if HasPedGotWeapon(PlayerPedId(), 0x83839C4, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x83839C4, GetHashKey('COMPONENT_AT_PI_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x83839C4, GetHashKey('COMPONENT_AT_PI_SUPP'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x5EF9FEC4, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_AT_PI_SUPP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x5EF9FEC4, GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x99AEEB3B, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_PI_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_PI_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x99AEEB3B, GetHashKey('COMPONENT_PISTOL50_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x22D8FE39, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_AT_PI_SUPP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x22D8FE39, GetHashKey('COMPONENT_APPISTOL_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0xBFD21232, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFD21232, GetHashKey('COMPONENT_SNSPISTOL_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0xD205520E, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_AT_PI_SUPP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xD205520E, GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x13532244, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_PI_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_PI_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x13532244, GetHashKey('COMPONENT_MICROSMG_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x2BE6766B, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_PI_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_AT_PI_SUPP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x2BE6766B, GetHashKey('COMPONENT_SMG_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0xEFE7E2DF, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xEFE7E2DF, GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x0A3D4D34, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_COMBATPDW_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x0A3D4D34, GetHashKey('COMPONENT_COMBATPDW_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x1D073A89, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x1D073A89, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x1D073A89, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0xBFEFFF6D, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')) then
            --TriggerServerEvent('smontaggio:rimborso', 'mirino')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xBFEFFF6D, GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0x83BF0278, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_SUPP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')) then
            --TriggerServerEvent('smontaggio:rimborso', 'mirino')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x83BF0278, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0xAF113F99, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_AT_AR_SUPP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE')) then
            --TriggerServerEvent('smontaggio:rimborso', 'skin')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xAF113F99, GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02'))
        end
    end

    if HasPedGotWeapon(PlayerPedId(), 0xC0A3098D, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
        end 
        if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')) then
            --TriggerServerEvent('smontaggio:rimborso', 'mirino')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0xC0A3098D, GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02'))
        end
    end
    
    if HasPedGotWeapon(PlayerPedId(), 0x7F229F94, false) then
        if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_FLSH')) then
            --TriggerServerEvent('smontaggio:rimborso', 'torciaarma')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_FLSH'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_SUPP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'silenziatore')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_SUPP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_AFGRIP')) then
            --TriggerServerEvent('smontaggio:rimborso', 'impugnatura')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
        end
        if HasPedGotWeaponComponent(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02')) then
            --TriggerServerEvent('smontaggio:rimborso', 'caricatoreesteso')
            RemoveWeaponComponentFromPed(PlayerPedId(), 0x7F229F94, GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02'))
        end
    end

end)

-- Smonta tutte le armi alla morte

local dimensionCliente = 0
RegisterNetEvent("comprobardimension")
AddEventHandler("comprobardimension", function(dimension)
    dimensionCliente = dimension
end)

AddEventHandler('esx:onPlayerDeath', function(data, componente)
    if dimensionCliente == 2000 then
        TriggerEvent('frazz:componenti')
        TriggerEvent('frazzsmontaarmi:disarm')
    end

end)

-- RegisterKeyMapping('abrirmenudesmontar', 'Abrir menu DESMONTAR ARMAS', 'keyboard', 'F9')

-- RegisterCommand("abrirmenudesmontar", function ()
--     if not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'smontaarmi') then
--         ApriMenuSmonta()
--     end
-- end, false)

-- ANIMAZIONE ZIOMARK NEGRO --
function animSmonta()
    local playerPed = PlayerPedId()

    ESX.Streaming.RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@', function()
    TaskPlayAnim(playerPed, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1.0, -1.0, 2000, 51, 1, false, false, false)
    Citizen.Wait(2000)
    ClearPedSecondaryTask(playerPed)
    end)
end

RegisterNetEvent('Ve_SmontaArmi:animazione')
AddEventHandler('Ve_SmontaArmi:animazione', function()
    animSmonta()
end)