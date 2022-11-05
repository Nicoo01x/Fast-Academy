ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esfer_rskin:recargararmas')
AddEventHandler('esfer_rskin:recargararmas', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    for k,v in ipairs(xPlayer.getLoadout()) do
        xPlayer.removeWeapon(v.name)
        xPlayer.addWeapon(v.name, v.ammo)
    end
end)

----------------------------------------------------------------------
---------- ZONA SEGURA
----------------------------------------------------------------------

RegisterServerEvent("SafeZones:isAllowed")
AddEventHandler("SafeZones:isAllowed", function()
    if IsPlayerAceAllowed(source, "safezones.bypass") then
        TriggerClientEvent("SafeZones.returnIsAllowed", source, true)
    else
        TriggerClientEvent("SafeZones.returnIsAllowed", source, false)
    end
end)

----------------------------------------------------------------------
---------- ELIMINADOR DE VEHICULOS
----------------------------------------------------------------------

Citizen.CreateThread(function()
    local time = 0
    while true do
       Citizen.Wait(1000)
       local xPlayers = ESX.GetPlayers()
       if time == 540 then
          TriggerClientEvent('chat:addMessage', -1, { args = { "[Fast Academy]", "En 1 minuto se borrarán todos los vehiculos." }, color = { 255, 0, 0 } })
       end
       if time == 570 then
          TriggerClientEvent('chat:addMessage', -1, { args = { "[Fast Academy]", "En 30 segundos se borrarán todos los vehiculos." }, color = { 255, 0, 0 } })
       end
       if time == 600 then
          for k,v in pairs(GetAllVehicles()) do
             if not (GetPedInVehicleSeat(v,-1) > 0) then
                   DeleteEntity(v)
             end
          end
          time = 0
          TriggerClientEvent('chat:addMessage', -1, { args = { "[Fast Academy]", "Se han borrado todos los vehiculos." }, color = { 255, 0, 0 } })
       else
          time = time + 1
       end
    end
 end)


----------------------------------------------------------------------
---------- ELIMINADOR DE VEHICULOS
---------------------------------------------------------------------- 