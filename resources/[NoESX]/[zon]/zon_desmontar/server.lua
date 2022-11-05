local ESX = nil
smontando = false

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Smonta arma / munizioni
RegisterServerEvent('frazzsmontaarmi:smonta')
AddEventHandler('frazzsmontaarmi:smonta', function(weapon, ammo)
    if GetPlayerRoutingBucket(source) == 2000 then
        local weaponConfig = Config.Weapons[weapon]
        local rpc = 36
        local rpcdarkricchionedioporcosucchiacazzi = 60

        if weaponConfig ~= nil and not smontando then
            local xPlayer = ESX.GetPlayerFromId(source)

            smontando = true

            xPlayer.removeWeapon(weapon, ammo)
            xPlayer.addInventoryItem(weaponConfig.item, 1)

            if weaponConfig.clip_item ~= nil then
                local munizionismontarmibohciao = weaponConfig.clip_item
                if munizionismontarmibohciao == 'mun_fucili' then
                    xPlayer.addInventoryItem(weaponConfig.clip_item, math.floor(ammo / rpcdarkricchionedioporcosucchiacazzi))
                else
                    xPlayer.addInventoryItem(weaponConfig.clip_item, math.floor(ammo / rpc))
                end
            end

            smontando = false
        end
    end
end)

RegisterServerEvent('frazzsmontaarmi:toglirpg')
AddEventHandler('frazzsmontaarmi:toglirpg', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon("WEAPON_RPG", 0)
end)

-- Smonta armatura
RegisterServerEvent('frazzsmontaarmi:smonta_armatura')
AddEventHandler('frazzsmontaarmi:smonta_armatura', function(armor)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(armor, 1)
end)

RegisterServerEvent('frazz:quitta')
AddEventHandler('frazz:quitta', function()
    DropPlayer(source, 'Sei uscito dal server!')
end)

--------------------------------------------------------------------------------
-- Registra oggetti armi
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
    -- Armi
    for k, v in pairs(Config.Weapons) do
        ESX.RegisterUsableItem(v.item, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.removeInventoryItem(v.item, 1)

            --local rounds = 1
            --if v.rpc ~= nil then rounds = 0 end
            --if k == 'WEAPON_PETROLCAN' then rounds = 250 end

            TriggerClientEvent('esx:showNotification', source, 'Montando ' .. v.label .. '...')
            TriggerClientEvent('3dme:triggerDisplay', -1, 'Montando ' .. v.label, source)
            TriggerClientEvent('Ve_SmontaArmi:animazione', source)
            Citizen.Wait(2000)
            xPlayer.addWeapon(k, 0)
            TriggerClientEvent('esx:showNotification', source, 'Has montado ' .. v.label)
            ExecuteCommand('balas')
            ExecuteCommand('attachs')
        end)
    end

    -- Paracadute (va registrato a parte, NON SMONTABILE)
    ESX.RegisterUsableItem('paracadute', function(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeInventoryItem('paracadute', 1)
        xPlayer.addWeapon('GADGET_PARACHUTE', 0)

        TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato un ~g~Paracadute')
    end)

end)

----------- MUNIZIONI

RegisterServerEvent('smontaarmi:munizionifix')
AddEventHandler('smontaarmi:munizionifix', function(item, numero)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item, numero)
end)

ESX.RegisterUsableItem('mun_pistola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mun_pistola', 1)
	TriggerClientEvent('montaammopistola', source, 36, 252)
end)

ESX.RegisterUsableItem('mun_fucili', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mun_fucili', 1)
	TriggerClientEvent('montaammoassalto', source, 60, 252)
end)

ESX.RegisterUsableItem('cecAmmo', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cecAmmo', 1)
	TriggerClientEvent('montaammocecchino', source, 36, 252)
end)

ESX.RegisterUsableItem('mun_smg', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mun_smg', 1)
	TriggerClientEvent('montaammoleggere', source, 36, 252)
end)

ESX.RegisterUsableItem('mun_pompa', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mun_pompa', 1)
	TriggerClientEvent('montaammopompa', source, 36, 252)
end)

-- SMONTA COMPONENTI

--[[RegisterServerEvent('smontaggio:rimborso')
AddEventHandler('smontaggio:rimborso', function(item)
	local player = source
	local xPlayer = ESX.GetPlayerFromId(player)
	xPlayer.addInventoryItem(item, 1)
end)]]