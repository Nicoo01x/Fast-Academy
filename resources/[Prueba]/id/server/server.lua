-- MADE BY LEFOS
-- NO CONFIG.LUA FOR PREVENTING DUMPING AND SPAMMING TO THE SPECIFIC WEBHOOKS. IF YOU DIDN'T KNOW, A SERVERSIDE SCRIPT CAN'T BE DUMPED!
-- CONFIG, CHANGE THINGS
local webhook1 = "https://discord.com/api/webhooks/995490024638390282/56OgPomgRLGh2hlE1jor-LO-or3fjegru-rqkRLNoaOCo1_P2rSbXmc2f8uK6beqgRSf" -- Create a webhook and put it here
local webhook2 = "https://discord.com/api/webhooks/995490126551593011/pWnCP4IHmfmlVr92hGfwV5mrVfu96u_3uqYzhMwY83xx7LlePsIVBq9BzyGMGlfM4gZh" -- Create a webhook and put it here
local username = "Rolas Academy" -- Put your server name or anything else you want the author of the message to be


-- DO NOT TOUCH ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING!
-- MAIN PART OF THE LOGGING
AddEventHandler('playerConnecting', function() -- Get the moment when a player connects
local name = GetPlayerName(source)
local steam = GetPlayerIdentifier(source)
local ip = GetPlayerEndpoint(source)
local identifiers = ExtractIdentifiers(source)
local license = identifiers.license
local discord ="<@" ..identifiers.discord:gsub("discord:", "")..">" 
local connect = {
        {
            ["color"] = "1048320", -- Color in decimal
            ["title"] = "Usuario Conectandose!", -- Title of the embed message
            ["description"] = "Name: **"..name.."**\nSteam ID : **"..steam.."**\nIP: **" .. ip .. "**\nGTA License: **" .. license .. "**\nDiscord Tag: **" .. discord .. "**", -- Main Body of embed with the info about the person who joined
        }
    }

PerformHttpRequest(webhook1, function(err, text, headers) end, 'POST', json.encode({username = username, embeds = connect, tts = TTS}), { ['Content-Type'] = 'application/json' }) -- Perform the request to the discord webhook and send the specified message
end)

AddEventHandler('playerDropped', function(reason) -- Get the moment when a player leaves and the reason
local name = GetPlayerName(source)
local steam = GetPlayerIdentifier(source)
local ip = GetPlayerEndpoint(source)
local identifiers = ExtractIdentifiers(source)
local license = identifiers.license
local discord ="<@" ..identifiers.discord:gsub("discord:", "")..">" 
local disconnect = {
        {
            ["color"] = "16711680", -- Color in decimal
            ["title"] = "Usuario Saliendo!", -- Title of the embed message
            ["description"] = "Name: **"..name.."**\nSteam ID: **"..steam.."**\nIP: **" .. ip .."**\nGTA License: **" .. license .. "**\nDiscord Tag: **" .. discord .. "**\nReason: **"..reason.."**", -- Main Body of embed with the info about the person who left
        }
    }

    PerformHttpRequest(webhook2, function(err, text, headers) end, 'POST', json.encode({username = username, embeds = disconnect, tts = TTS}), { ['Content-Type'] = 'application/json' }) -- Perform the request to the discord webhook and send the specified message
end)



-- FUNCTIONS TO GET EXTRA IDENTIFIERS
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

-- END OF THE CODE. MADE BY LEFOS...