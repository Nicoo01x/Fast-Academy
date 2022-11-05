ESX                           = nil
local ESXLoaded = false
local Players = 0
Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    ESXLoaded = true
end)

RegisterNetEvent("UpdatePlayersDiscord")
AddEventHandler("UpdatePlayersDiscord",function(players)
    Players = players
end)

local dimensionCliente = 0
RegisterNetEvent("comprobardimension")
AddEventHandler("comprobardimension", function(dimension)
    dimensionCliente = dimension
end)


Citizen.CreateThread(function()
    while not ESXLoaded do Wait(100) end
	while true do
        -- This is the Application ID (Replace this with you own)
		SetDiscordAppId(1038186341143433266)

        -- Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('fastacademygrande')
        
        -- (11-11-2018) New Natives:


        SetDiscordRichPresenceAssetText('Servidor Academy | Fast Academy')
       

        SetDiscordRichPresenceAssetSmall('fastacademychico')


        SetDiscordRichPresenceAssetSmallText('Servidor Academy | Fast Academy')

        -- (26-02-2021) New Native:
        -- local coords = GetEntityCoords(PlayerPedId())
        -- local sn, cr = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        -- if cr == 0 then
        --     SetRichPresence( GetPlayerName(PlayerId()).. " en la calle " .. GetStreetNameFromHashKey(sn)) 
        -- else
        --     SetRichPresence( GetPlayerName(PlayerId()).. " en la calle " .. GetStreetNameFromHashKey(sn) .. " & " .. GetStreetNameFromHashKey(cr)) 
        -- end



        SetRichPresence(Players .. "/64 | "..GetPlayerName(PlayerId())) 

       SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/qYPYN2fPyq")
       SetDiscordRichPresenceAction(1, "Conectar", "fivem://connect/")

		Citizen.Wait(60000)
	end
end)