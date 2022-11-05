ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--obtenemos discord id y cositas para entrar al academy (dcwhitelist)


notWhitelistedMessage = "Tu no estas en la WhiteList del Zon Development, entra a nuestro Discord https://discord.gg/pzdZPWWnyP." -- Message displayed when they are not whitelist with the role

whitelistRoles = { -- Role IDs needed to pass the whitelist
    "962128487920062535",
}

local wait = {}

-- RegisterCommand("academy", function(source, name, setCallback)
--     local src = source
--     local passAuth = false
--     if not wait[src] then
--         for k, v in ipairs(GetPlayerIdentifiers(src)) do
--             if string.sub(v, 1, string.len("discord:")) == "discord:" then
--                 identifierDiscord = v
--             end
--         end
    
--         if identifierDiscord then
--             usersRoles = exports.discord_perms:GetRoles(src)
--             print(usersRoles)
--             local function has_value(table, val)
--                 if table then
--                     for index, value in ipairs(table) do
--                         if value == val then
--                             print(value, val)
--                             return true
--                         end
--                     end
--                 end
--                 return false
--             end
--             for index, valueReq in ipairs(whitelistRoles) do 
--                 if has_value(usersRoles, valueReq) then
--                     passAuth = true
--                 end
--                 if next(whitelistRoles,index) == nil then
--                     if passAuth == true then
--                         SetPlayerRoutingBucket(source, 2000) -- DIMENSION
--                         -- SetEntityCoords(source, 136.0615, -1057.807, 29.178, true, true, true, false)
--                         local dimension = GetPlayerRoutingBucket(source)
--                         TriggerClientEvent("llevoABanda", source)
--                     else 
--                         wait[src] = true
--                         Citizen.SetTimeout(4000,function()
--                             wait[src] = false
--                         end)
                        
--                     end
--                 end
--             end
--         end
--     end
-- end)

RegisterNetEvent("setdimension", function(soure) 
    local source = source
    SetPlayerRoutingBucket(source, 2000)
end)

RegisterNetEvent('zon_tp:confirmBool')
AddEventHandler('zon_tp:confirmBool', function (id, bool, coords)
    if bool then
        TriggerClientEvent('zon_tp:tpToCoords', id, coords)
        local a = GetPlayerRoutingBucket(source)
        SetPlayerRoutingBucket(id, a)
        TriggerClientEvent("esx:showNotification", id, "La id (" .. source .. ") ha aceptado la solicitud de teletransporte!")
        TriggerClientEvent("esx:showNotification", source, "Has aceptado la solicitud!")
        --TriggerClientEvent('chatMessage', id, "[Spain PvP]", {255, 0, 0}, "La id (" .. source .. ") ha aceptado la solicitud de teletransporte!")
        --TriggerClientEvent('chatMessage', source, "[Spain PvP]", {255, 0, 0}, "Has aceptado la solicitud!")
    else
        TriggerClientEvent("esx:showNotification", id, "La id (" .. source .. ") ha rechazado la solicitud de teletransporte!")
        TriggerClientEvent("esx:showNotification", source, "Has denegado la solicitud de tp a la id (" .. id .. ")")
        -- TriggerClientEvent('chatMessage', id, "[Spain PvP]", {255, 0, 0}, "La id (" .. source .. ") ha rechazado la solicitud de teletransporte!")
        -- TriggerClientEvent('chatMessage', source, "[Spain PvP]", {255, 0, 0}, "Has denegado la solicitud de tp a la id (" .. id .. ")")
    end
end)

ESX.RegisterServerCallback("stats:GetEstatsPersonales", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM ev_leaderboard WHERE license = @id', { ['@id'] = xPlayer.getIdentifier() }, function(result)
        for k, v in pairs(result) do
            cb(result)
        end
    end)
end)

RegisterNetEvent('zon_tp:sendNoti')
AddEventHandler('zon_tp:sendNoti', function (source, id)
    TriggerClientEvent('zon_tp:showNoti', id, source)
end)

RegisterCommand('tpto', function (source, args)
    if GetPlayerRoutingBucket(source) == 2000 then
    else
        TriggerEvent('chat:addSuggestion', '/tpto', 'Teletransportarse a una id')

        if args ~= nil then
            local otherid = tostring(args[1])
            if GetPlayerName(otherid) then
                TriggerEvent('zon_tp:sendNoti', source, otherid)
                TriggerClientEvent("esx:showNotification", source, "Tp enviado, esperando confirmacion")
                --TriggerClientEvent('chatMessage', source, "[Spain PvP]", {255, 0, 0}, "Tp enviado, esperando confirmacion!")
            else
                TriggerClientEvent("esx:showNotification", source, "Id incorrecta")
                --TriggerClientEvent('chatMessage', source, "[Spain PvP]", {255, 0, 0}, "Id incorrecta")
            end
        else
            TriggerClientEvent("esx:showNotification", source, "Tienes que introducir una ID")
            --TriggerClientEvent('chatMessage', source, "[Spain PvP]", {255, 0, 0}, "Tienes que introducir una ID!")
        end
    end
    
end, false)


-- comandos debug y jugamos con dimensiones uwu

RegisterCommand("mundo", function(source, args, rawCommand)
    if not args[1] then
        TriggerClientEvent("esx:showNotification", source, "Estás en la dimension: "..GetPlayerRoutingBucket(source))
    else
        if GetPlayerRoutingBucket(source) < 2000 then
            SetPlayerRoutingBucket(source, tonumber(args[1]))
        else
            TriggerClientEvent("esx:showNotification", source, "No puedes usar este comando en el academy")
            return
        end
        
        
        if tonumber(args[1]) < 200 or tonumber(args[1]) > 1000 then
            TriggerClientEvent("esx:showNotification", source, "Este mundo es para VIPS, puedes teletransportarte entre el 200 y el 1000")
        else
            SetPlayerRoutingBucket(source, tonumber(args[1]))
        end
    end
end)

RegisterCommand("hub", function(source)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local PlayerPed = GetPlayerPed(source)
    if GetPlayerRoutingBucket(source) == 500 then
        TriggerClientEvent("esx:showNotification", source, "Serás teletransportado al hub en 5 segundos.")
        
        FreezeEntityPosition(source, true)
        
        TriggerClientEvent("progresuwu2", source)
        Citizen.Wait(5000)
        TriggerClientEvent('frazz:componenti', source)
        TriggerClientEvent('frazzsmontaarmi:disarm', source)
        FreezeEntityPosition(source, false)
        TriggerClientEvent('esx_ambulancejob:revive', source)		
        random = math.random(0, 2)
        SetPlayerRoutingBucket(source, random)
        SetEntityCoords(source, -881.7504, -430.8505, 39.59983, true, true, true, false)
        
        TriggerClientEvent("esx:showNotification", source, "Te has conectado al Lobby #"..random)
        ExecuteCommand("salirffa")
        ESX.RemoveAllPedWeapons(PlayerPed) -- clearloadout
    else
        TriggerClientEvent("progresuwu1", source)
        Wait(5000)
        TriggerClientEvent('esx_ambulancejob:revive', source)		
        random = math.random(0, 2)
        SetPlayerRoutingBucket(source, random)
        SetEntityCoords(source, -881.7504, -430.8505, 39.59983, true, true, true, false)
        RemoveAllPedWeapons(PlayerPed)
        TriggerClientEvent("esx:showNotification", source, "Te has conectado al Lobby #"..random)
        TriggerClientEvent('frazz:componenti', source)
        TriggerClientEvent('frazzsmontaarmi:disarm', source)
        ExecuteCommand("salirffa")
        
    end
end)


RegisterCommand("+aleatorio", function (source)
    SetPlayerRoutingBucket(source, math.random(200, 600))
    TriggerClientEvent("esx:showNotification", source, "Has sido teletransportado al tejado y te has cambiado al mundo: "..GetPlayerRoutingBucket(source))
end)

RegisterNetEvent("comprobardimension")
AddEventHandler("comprobardimension", function()
    local source = source
    local bucket = GetPlayerRoutingBucket(source)
    TriggerClientEvent("comprobardimension", source, bucket)
end)

-- RegisterCommand("drift", function(source)
--     if GetPlayerRoutingBucket(source) == 2000 then
        
--     else
--         SetPlayerRoutingBucket(source, 4000)
--         SetEntityCoords(source, 166.6405, -990.1373, 30.09191)
--         Citizen.Wait(1000)
--         TriggerClientEvent("esx:showNotification", source, "¡Bienvenido/a al Drift Mode de Glaw!")
--     end
-- end)

RegisterCommand("ver", function(source)
    TriggerClientEvent("esx:showNotification", source, GetPlayerRoutingBucket(-1))
end)