-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) 
--     ESX = obj 
--     Citizen.Wait(100)
--     RegisterCallbacks(ESX)
-- end)


Citizen.CreateThread(function()
    while true do
        local players = #GetPlayers()
        TriggerClientEvent("UpdatePlayersDiscord", -1, players)
        Citizen.Wait(60000)
    end
end)