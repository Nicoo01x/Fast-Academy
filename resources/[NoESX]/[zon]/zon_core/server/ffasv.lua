ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local moiner = {}


RegisterServerEvent('zon_ffa:save')
AddEventHandler('zon_ffa:save', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    --ESX.SavePlayer(xPlayer)

    xPlayer.removeWeapon('WEAPON_PISTOL_MK2')
    xPlayer.removeWeapon('WEAPON_CARBINERIFLE_MK2')
    xPlayer.removeWeapon('WEAPON_ASSAULTRIFLE_MK2')
    xPlayer.removeWeapon('WEAPON_SMGMK2')
    
    ESX.SavePlayers()

end)

AddEventHandler("playerDropped", function()
    if moiner[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeWeapon('WEAPON_PISTOL_MK2')
        xPlayer.removeWeapon('WEAPON_CARBINERIFLE_MK2')
        xPlayer.removeWeapon('WEAPON_ASSAULTRIFLE_MK2')
        xPlayer.removeWeapon('WEAPON_SMGMK2')
        for i=1, #xPlayer.inventory, 1 do
            if xPlayer.inventory[i].count > 0 then
                xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
            end
        end
    end
end)

RegisterNetEvent("removein")
AddEventHandler("removein", function (source)
    if moiner[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeWeapon('WEAPON_PISTOL_MK2')
        xPlayer.removeWeapon('WEAPON_CARBINERIFLE_MK2')
        xPlayer.removeWeapon('WEAPON_ASSAULTRIFLE_MK2')
        xPlayer.removeWeapon('WEAPON_SMGMK2')
        for i=1, #xPlayer.inventory, 1 do
            if xPlayer.inventory[i].count > 0 then
                xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
            end
        end
    end
end)


RegisterServerEvent('zon_ffa:setDimension')
AddEventHandler('zon_ffa:setDimension', function(dimension)
    --print(source, dimension)
    SetPlayerRoutingBucket(source, dimension)
    if dimension > 0 then
        moiner[source] = true
    else
        moiner[source] = false
    end
end)

RegisterServerEvent('killed')
AddEventHandler('killed', function (killer)
    xSource = ESX.GetPlayerFromId(source)
    
    if killer ~= nil then
        xPlayer = ESX.GetPlayerFromId(killer)    
        TriggerClientEvent('heal', killer)   
    end

    xSource.triggerEvent('zon_ffa:addDeath')  
    
end)

ESX.RegisterServerCallback('getpindi', function(source, cb)

    local heiner = {
        eins = 0,
        zwei = 0,
        drei = 0,
        vier = 0,
    }

    local players = ESX.GetPlayers()
    for i=1, #players do
        if GetPlayerRoutingBucket(players[i]) == 30 then
            heiner.eins = heiner.eins + 1
        elseif GetPlayerRoutingBucket(players[i]) == 31 then
            heiner.zwei = heiner.zwei + 1
        elseif GetPlayerRoutingBucket(players[i]) == 32 then
            heiner.drei = heiner.drei + 1    
        elseif GetPlayerRoutingBucket(players[i]) == 33 then
            heiner.vier = heiner.vier + 1    
        
        end


    end


cb(heiner)

end)

