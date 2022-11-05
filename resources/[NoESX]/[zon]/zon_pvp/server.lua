ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


---Fetches the discord api for an user.
---If discord id is not nil, then it returns avatar
---@param discordId number
---@return string
local botToken = "OTA4NDQ3MDQ0NDg0NTk5ODU5.YY13PQ.dyeaitEasUaNFf1BuCxm7Epi4mc" -- Add your discord bot with admin perms token here.

local insert = table.insert
local sort = table.sort

local playersData = {}
local TOKEN = "Bot "  .. botToken --Concatenated token
local DEFAULT_ID= '903150326155182151' -- Just in case the player doesn't have discord open

--#region Functions
---Gets the discord id and cuts it
---@param playerId number
---@return string
---@return boolean
local function getDiscordId(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for i=1, #identifiers do
        if identifiers[i]:match('discord:') then
            return identifiers[i]:gsub('discord:', '')
        end
    end
    return DEFAULT_ID
end

---Gets the license of a player
---@param playerId number
---@return string
---@return boolean
local function getLicense(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for i=1, #identifiers do
        if identifiers[i]:match('license:') then
            return identifiers[i]
        end
    end
    return false
end

---Fetches the discord api for an user.
---If discord id is not nil, then it returns avatar
---@param discordId number
---@return string
local function getPlayerFromDiscord(discordId)
    if not discordId then
        return false
    end
    local p = promise.new()
    PerformHttpRequest(('https://discordapp.com/api/users/%s'):format(discordId), function(err, result, headers)
        p:resolve({data=result, code=err, headers = headers})
    end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = TOKEN})

    local result = Citizen.Await(p)
    if result then
        if result.code ~= 200 then
            return --print('Error: Something went wrong with error code - ' .. result.code)
        end
        local data = json.decode(result.data)
        if data and data.avatar then
            return ('https://cdn.discordapp.com/avatars/%s/%s'):format(discordId, data.avatar)
        end
    end
end
---Fetches the discord api for an user.
---If discord id is not nil, then it returns avatar
---@param discordId number
---@return string
local function getDiscordName(discordId)
    if not discordId then
        return false
    end
    local p = promise.new()
    PerformHttpRequest(('https://discordapp.com/api/users/%s'):format(discordId), function(err, result, headers)
        p:resolve({data=result, code=err, headers = headers})
    end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = TOKEN})

    local result = Citizen.Await(p)
    if result then
        if result.code ~= 200 then
            return --print('Error: Something went wrong with error code - ' .. result.code)
        end
        local data = json.decode(result.data)
        if data and data.username then
            return data.username
        end
    end
end




id = nil
healthlimit = 120

count = 1
queue1v1 = {}
initialdimension1v1 = 1000
dimension1v1 = initialdimension1v1 -- INITIAL DIMENSION 1V1

queue2v2={}
initialdimension2v2 = 1200
dimension2v2 = initialdimension2v2 -- INITIAL DIMENSION 2V2

queue1v1r={}
initialdimension1v1r = 1300
dimension1v1r = initialdimension1v1r -- INITIAL DIMENSION 2V2


for i = (initialdimension1v1+300),initialdimension1v1,-1 do 
   SetRoutingBucketEntityLockdownMode(i, "strict")
end

for i = (initialdimension2v2+300),initialdimension2v2,-1 do 
   SetRoutingBucketEntityLockdownMode(i, "strict")
end

for i = (initialdimension1v1r+300),initialdimension1v1r,-1 do 
	SetRoutingBucketEntityLockdownMode(i, "strict")
end

RegisterServerEvent("zon_pvp:counter1v1")
AddEventHandler("zon_pvp:counter1v1", function()
	table.insert(queue1v1, source)
end)

RegisterServerEvent("zon_pvp:salirColas")
AddEventHandler("zon_pvp:salirColas", function(_source)
	local _source = source
	queue1v1={}
	queue2v2={}
	queue1v1r={}
end)

RegisterServerEvent("zon_pvp:counter1v1r")
AddEventHandler("zon_pvp:counter1v1r", function()
	--print(source)
	table.insert(queue1v1r, source)
end)

RegisterServerEvent("zon_pvp:counter2v2")
AddEventHandler("zon_pvp:counter2v2", function()
	table.insert(queue2v2, source)
end)

-- 1V1
Citizen.CreateThread(function()
	while true do
		local source = source
	    if (#queue1v1>=2) then
		-- PLAYER 1
			
			SetEntityCoords(queue1v1[1], 122.0012, -879.1557, 134.7701, true, true, true, false)
			SetEntityHeading(queue1v1[1], 65.4517)
			
			SetPlayerRoutingBucket(queue1v1[1], dimension1v1) -- DIMENSION
			
			
			--
			RemoveAllPedWeapons(queue1v1[1], false)
			GiveWeaponToPed(queue1v1[1], GetHashKey("weapon_pistol_mk2"), 200, true)
			SetCurrentPedWeapon(queue1v1[1], GetHashKey("weapon_pistol_mk2"), true)
			TriggerClientEvent("attachs", queue1v1[1])
			TriggerClientEvent("zon_pvp:msg", queue1v1[1], 1)

			-- PLAYER 2
			SetEntityCoords(queue1v1[2], 81.9529, -864.4842, 134.7701, true, true, true, false)
			SetEntityHeading(queue1v1[2], 249.6239)
			
			SetPlayerRoutingBucket(queue1v1[2], dimension1v1) -- DIMENSION
			--
			
			TriggerClientEvent("attachs", queue1v1[2])
			RemoveAllPedWeapons(queue1v1[2], false)
			GiveWeaponToPed(queue1v1[2], GetHashKey("weapon_pistol_mk2"), 200, true)
			SetCurrentPedWeapon(queue1v1[2], GetHashKey("weapon_pistol_mk2"), true)

			TriggerClientEvent("zon_pvp:msg", queue1v1[2], 1)

			TriggerEvent("zon_pvp:die1v1", queue1v1[1], queue1v1[2]) -- CHECK IF ANY PLAYER DIE

			dimension1v1 = dimension1v1 + 1 
			table.remove(queue1v1, 2)
			table.remove(queue1v1, 1)
		end
    	Citizen.Wait(1200)
  	end
end)

Citizen.CreateThread(function()
	while true do
		local source = source
	    if (#queue1v1r>=2) then
		-- PLAYER 1
			
		
			SetEntityCoords(queue1v1r[1], 122.0012, -879.1557, 134.7701, true, true, true, false)
		
			SetEntityHeading(queue1v1r[1], 65.4517)
			
			SetPlayerRoutingBucket(queue1v1r[1], dimension1v1r) -- DIMENSION
			
			
			--
			RemoveAllPedWeapons(queue1v1r[1], false)
			GiveWeaponToPed(queue1v1r[1], GetHashKey("weapon_pistol_mk2"), 200, true)
			SetCurrentPedWeapon(queue1v1r[1], GetHashKey("weapon_pistol_mk2"), true)
			TriggerClientEvent("attachs", queue1v1r[1])
			TriggerClientEvent("zon_pvp:msg", queue1v1r[1], 1)

			-- PLAYER 2
			SetEntityCoords(queue1v1r[2], 81.9529, -864.4842, 134.7701, true, true, true, false)
			SetEntityHeading(queue1v1r[2], 249.6239)
			
			SetPlayerRoutingBucket(queue1v1r[2], dimension1v1r) -- DIMENSION
			--
			
			RemoveAllPedWeapons(queue1v1r[2], false)
			GiveWeaponToPed(queue1v1r[2], GetHashKey("weapon_pistol_mk2"), 200, true)
			SetCurrentPedWeapon(queue1v1r[2], GetHashKey("weapon_pistol_mk2"), true)
			TriggerClientEvent("attachs", queue1v1r[2])

			TriggerClientEvent("zon_pvp:msg", queue1v1r[2], 1)

			TriggerEvent("zon_pvp:die1v1r", queue1v1r[1], queue1v1r[2]) -- CHECK IF ANY PLAYER DIE

			dimension1v1r = dimension1v1r + 1 
			table.remove(queue1v1r, 2)
			table.remove(queue1v1r, 1)
		end
    	Citizen.Wait(1200)
  	end
end)


RegisterCommand("1v1", function(source)
	TriggerClientEvent("zon_pvp:pvpqueue", source, 1)
end)

RegisterCommand("1v1r", function(source)
	TriggerClientEvent("zon_pvp:pvpqueue", source, 3)
end)
	
RegisterCommand("2v2", function(source)
	TriggerClientEvent("zon_pvp:pvpqueue", source, 2)
end)

-- local pp1 = (1/(1+10^((e2-e1)/400)))
-- local pp2 = (1/(1+10^((e1-e2)/400)))

-- function Round(num, dp)
--     local mult = 10^(dp or 0)
--     return math.floor(num * mult + 0.5)/mult
-- end

-- local winp1 = false

-- if not winp1 then
--     local newElo1 = e1 + 32 * (0 - pp1)
--     local diff = e1 - newElo1
--     --print("NewElo", Round(newElo1, 2))
--     --print("Diff", Round(diff, 2))
--     local newElo2 = e2 + diff
--     --print("NewElo2", Round(newElo2, 2))
    
-- end

-- --print(Round(pp1, 2))

RegisterServerEvent('zon_pvp:createElo',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	-- exports.mongodb:count({ collection = "pvp", query = { identifier = xPlayer.identifier } }, function (success, count)
	-- 	if not success then
	-- 		--print("Error message: "..tostring(result))
	-- 		return
	-- 	end
		
	-- 	if count < 1 then
	-- 		exports.mongodb:insertOne({ collection = "pvp", document = { identifier = xPlayer.identifier, elo = 1000} })
	-- 	end
	-- end)

	
	local playerId = source
	local license = getLicense(playerId)
	local discordId = getDiscordId(playerId)
	local playerData = playersData[license]
	local name = getDiscordName(discordId)
	local avatar = getPlayerFromDiscord(discordId)
	local nombre = xPlayer.getName()
	MySQL.Async.fetchScalar('SELECT COUNT(1) FROM pvp WHERE identifier=@ident', { ['@ident'] = xPlayer.identifier }, function(result)
		--print(result)
		if result == 0 then
			MySQL.Async.insert('INSERT INTO pvp (identifier, elo, name) VALUES (@identifier, @elo, @name)',
			{ ['identifier'] = xPlayer.getIdentifier(), ['elo'] = 1000, name = nombre },
			function(insertId)
				--print(insertId)
			end
			)
		end
	end)

end)

local a = 0
RegisterServerEvent("zon_pvp:die1v1")
AddEventHandler("zon_pvp:die1v1", function(player1, player2)
	Citizen.CreateThread(function()
		a = a+1
		while true do
			if (GetEntityHealth(GetPlayerPed(player1))<=healthlimit or GetEntityHealth(GetPlayerPed(player2))<=healthlimit or id==player1 or id==player2) then
				local players = {player1, player2}
				local xPlayer = ESX.GetPlayerFromId(player1)
				local xPlayer2 = ESX.GetPlayerFromId(player2)
				

				if (GetEntityHealth(GetPlayerPed(player1))<=healthlimit) then
					
					TriggerClientEvent("zon_pvp:msgLost", player1) -- AUQI PIERDE PLAYER 1
					TriggerClientEvent("zon_pvp:msgWon", player2) -- AQUI GANA PLAYER2
					
				elseif (GetEntityHealth(GetPlayerPed(player2))<=healthlimit) then
					
					TriggerClientEvent("zon_pvp:msgWon", player1) -- AQUI GANA PLAYER1
					TriggerClientEvent("zon_pvp:msgLost", player2) -- AQUI PIERDE PLAYER2
					
					
				elseif (id==player1 or id==player2) then
					TriggerClientEvent("zon_pvp:msgQuit", player1)
				end

				Citizen.Wait(1700)
				
				--print("---------")
				
				for i=2,1,-1 do
					TriggerClientEvent('uptime:revive', players[i])
					SetEntityCoords(GetPlayerPed(players[i]),-881.7504, -430.8505, 39.59983,1,0,0,1)
					SetEntityHeading(players[i], 314.48)
					SetPlayerRoutingBucket(players[i], 0)
					RemoveAllPedWeapons(players[i], false)
					local xPlayer = ESX.GetPlayerFromId(player1)
					local xPlayer2 = ESX.GetPlayerFromId(player2)
					if xPlayer then
						for i=1, #xPlayer.inventory, 1 do
							if xPlayer.inventory[i].count > 0 then
								xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
							end
						end
					end
					if xPlayer2 then
						for i=1, #xPlayer2.inventory, 1 do
							if xPlayer2.inventory[i].count > 0 then
								xPlayer2.setInventoryItem(xPlayer2.inventory[i].name, 0)
							end
						end
					end
				end		
				break
			end
			Citizen.Wait(500)
		end
	end)
end)


ESX.RegisterServerCallback('zon_pvp:getElo', function(source,cb, elo) 
    local xPlayer = ESX.GetPlayerFromId(source)
	local _src = source
    local info = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local p5 = promise.new()
	
	MySQL.Async.fetchAll('SELECT * FROM pvp WHERE identifier = @identifier', { ['@identifier'] =  xPlayer.getIdentifier() }, function(result)
		----print(json.encode(result))
	  

		if result[1] ~= nil then
			if result[1].elo ~= nil then
				table.insert(info, {elo = result[1].elo })

				cb(info)

			end

		end
	end)
   

end)


function ExtractIdentifiers(src)
    local identifiers = {}

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam:") then
            identifiers['steam'] = id
        elseif string.find(id, "ip:") then
            identifiers['ip'] = id
        elseif string.find(id, "discord:") then
            identifiers['discord'] = id
        elseif string.find(id, "license:") then
            identifiers['license'] = id
        elseif string.find(id, "license2:") then
            identifiers['license2'] = id
        elseif string.find(id, "xbl:") then
            identifiers['xbl'] = id
        elseif string.find(id, "live:") then
            identifiers['live'] = id
        elseif string.find(id, "fivem:") then
            identifiers['fivem'] = id
        end
    end

    return identifiers
end


local a = 0
RegisterServerEvent("zon_pvp:die1v1r")
AddEventHandler("zon_pvp:die1v1r", function(player1, player2, source)
	Citizen.CreateThread(function()
		a = a+1
		while true do
			if (GetEntityHealth(GetPlayerPed(player1))<=healthlimit or GetEntityHealth(GetPlayerPed(player2))<=healthlimit or id==player1 or id==player2) then
				
				local players = {player1, player2}
				local xPlayer = ESX.GetPlayerFromId(player1)
				local xPlayer2 = ESX.GetPlayerFromId(player2)
				local p1 = promise.new()
				local p2 = promise.new()
				
				MySQL.Async.fetchAll('SELECT * FROM pvp WHERE identifier = @identifier', { ['@identifier'] =  xPlayer.getIdentifier() }, function(result)
					p1:resolve(result[1].elo)
				end)
				MySQL.Async.fetchAll('SELECT * FROM pvp WHERE identifier = @identifier', { ['@identifier'] =  xPlayer2.getIdentifier() }, function(result)
					p2:resolve(result[1].elo)
				end)

				----print(player1)
				----print(player2)

				eloplayer1 = Citizen.Await(p1)
				eloplayer2 = Citizen.Await(p2)
				
				local probabilidad = (1/(1+10^((eloplayer2-eloplayer1)/400))) --Probabilidad de que gane player 1
				local probabilidad2 = (1/(1+10^((eloplayer1-eloplayer2)/400))) --Probabilidad de que gane player 2
				----print(probabilidad..' calculo')
				----print(probabilidad2..' calculo2')
				if (GetEntityHealth(GetPlayerPed(player1))<=healthlimit) then
					local newElo = eloplayer1 + 32 * (0 - probabilidad)
					TriggerClientEvent("zon_pvp:msgLost", player1) -- AUQI PIERDE PLAYER 1
					TriggerClientEvent("zon_pvp:msgWon", player2) -- AQUI GANA PLAYER2
					----print("Elo nuevo player 1:"..newElo .. " pierde " .. xPlayer.getIdentifier())
					local diff = eloplayer1 - newElo
					
					local nombre = xPlayer.getName()
					local nombre2 = xPlayer2.getName()
					
					MySQL.Async.execute('UPDATE pvp SET elo = @newElo, name = @Discordname WHERE identifier =  @identifier ',{
						['@identifier'] = xPlayer.getIdentifier(),
						['@Discordname'] = xPlayer.getName(),
						['@newElo'] = newElo
					}, function() end)
					MySQL.Async.execute('UPDATE pvp SET elo = @newElo, name = @Discordname2 WHERE identifier =  @identifier ',{
						['@identifier'] = xPlayer2.getIdentifier(),
						['@Discordname2'] = xPlayer2.getName(),
						['@newElo'] = eloplayer2+diff
					}, function() end)
					local src = source
					local ids = ExtractIdentifiers(player2)
					local ids2 = ExtractIdentifiers(player1)
					_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
					_discordID2 ="<@" ..ids2.discord:gsub("discord:", "")..">"
					-- sendToDiscord(GetPlayerName(player1) .. " 🆚 " .. GetPlayerName(player2) .. "", 
                    -- 'Ganador: ' .. _discordID .. '\n' ..
                    -- 'Perdedor: ' .. _discordID2 .. '\n' ..
					-- '\nELO Nuevo perdedor: **' ..math.floor(newElo) .. '**\n' ..
                    -- 'ELO Nuevo ganador: **' .. math.floor(eloplayer2+diff) .. '**\n');
				elseif (GetEntityHealth(GetPlayerPed(player2))<=healthlimit) then
					local newElo = eloplayer2 + 32 * (0 - probabilidad2)
					TriggerClientEvent("zon_pvp:msgWon", player1) -- AQUI GANA PLAYER1
					TriggerClientEvent("zon_pvp:msgLost", player2) -- AQUI PIERDE PLAYER2
					local diff = eloplayer2 - newElo
					
					----print("Elo nuevo player 1 a:"..eloplayer1+diff .. " gana " .. xPlayer.getIdentifier())
					----print("Elo nuevo player 2 a:"..newElo .. " pierde " .. xPlayer2.getIdentifier())
					-- MySQL.Async.execute('UPDATE pvp SET elo = @newElo, name = @Discordname WHERE identifier =  @identifier ',{
					-- 	['@identifier'] = xPlayer.getIdentifier(),
					-- 	['@Discordname'] = xPlayer.getName(),
					-- 	['@newElo'] = eloplayer1+diff
					-- }, function() end)
					-- MySQL.Async.execute('UPDATE pvp SET elo = @newElo, name = @Discordname WHERE identifier =  @identifier ',{
					-- 	['@identifier'] = xPlayer2.getIdentifier(),
					-- 	['@Discordname'] = xPlayer2.getName(),
					-- 	['@newElo'] = newElo
					-- }, function() end)
					MySQL.Async.execute('UPDATE pvp SET elo = @newElo, name = @Discordname WHERE identifier =  @identifier ',{
						['@identifier'] = xPlayer.getIdentifier(),
						['@Discordname'] = xPlayer.getName(),
						['@newElo'] = eloplayer1+diff
					}, function() end)
					MySQL.Async.execute('UPDATE pvp SET elo = @newElo, name = @Discordname WHERE identifier =  @identifier ',{
						['@identifier'] = xPlayer2.getIdentifier(),
						['@Discordname'] = xPlayer2.getName(),
						['@newElo'] = newElo
					}, function() end)
					local src = source
					local ids = ExtractIdentifiers(player2)
					local ids2 = ExtractIdentifiers(player1)
					_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
					_discordID2 ="<@" ..ids2.discord:gsub("discord:", "")..">"
				 --	sendToDiscord(GetPlayerName(player1) .. " 🆚 " .. GetPlayerName(player2) .. "", 
                --     'Ganador: ' .. _discordID2 .. '\n' ..
                --     'Perdedor: ' .. _discordID .. '\n' ..
				-- 	'\nELO Nuevo perdedor: **' ..math.floor(newElo) .. '**\n' ..
                --     'ELO Nuevo ganador: **' ..math.floor(eloplayer1+diff) .. '**\n');
				elseif (id==player1 or id==player2) then
					TriggerClientEvent("zon_pvp:msgQuit", player1)
				end

				Citizen.Wait(1700)
				
				----print("---------")
				
				for i=2,1,-1 do
					TriggerClientEvent('uptime:revive', players[i])
					SetEntityCoords(GetPlayerPed(players[i]),-881.7504, -430.8505, 39.59983,1,0,0,1)
					SetEntityHeading(players[i], 314.48)
					SetPlayerRoutingBucket(players[i], 0)
					RemoveAllPedWeapons(players[i], false)
					local xPlayer = ESX.GetPlayerFromId(player1)
					local xPlayer2 = ESX.GetPlayerFromId(player2)
					
					--sendToDisc(" Resultado 1v1 :\n \n-Ganador "..xPlayer.getName() " \nPerdedor:  "..xPlayer2.getName(), 'Fecha ' .. date.day .. '/' .. date.month .. '/' .. date.year .. ' | ' .. date.hour .. ':' .. date.min ..  ' minutos con ' .. date.sec .. " segundos",  webHook, 16711680)
					if xPlayer then
						for i=1, #xPlayer.inventory, 1 do
							if xPlayer.inventory[i].count > 0 then
								xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
							end
						end
					end
					if xPlayer2 then
						for i=1, #xPlayer2.inventory, 1 do
							if xPlayer2.inventory[i].count > 0 then
								xPlayer2.setInventoryItem(xPlayer2.inventory[i].name, 0)
							end
						end
					end
				end		
				
				break
			end
			Citizen.Wait(500)
		end
	end)
end)


-- 2v2
Citizen.CreateThread(function()
	while true do
	    if (#queue2v2>3) then
			Wait(2000)
	    	SetEntityCoords(queue2v2[1], -1680.897, -875.1296, 8.77, true, true, true, false)
	    	SetEntityCoords(queue2v2[2], -1680.897, -875.1296, 8.77, true, true, true, false)
	    	SetEntityCoords(queue2v2[3], -1623.653, -922.2857, 8.790, true, true, true, false)
	    	SetEntityCoords(queue2v2[4], -1623.653, -922.2857, 8.790, true, true, true, false)

	    	SetEntityHeading(queue2v2[1], 108.94)
	    	SetEntityHeading(queue2v2[2], 108.94)
	    	SetEntityHeading(queue2v2[3], 286.34)
	    	SetEntityHeading(queue2v2[4], 286.34)
			for i=4,1,-1 do
			    SetPlayerRoutingBucket(queue2v2[1], dimension2v2)
				SetPlayerRoutingBucket(queue2v2[2], dimension2v2)
				SetPlayerRoutingBucket(queue2v2[3], dimension2v2)
				SetPlayerRoutingBucket(queue2v2[4], dimension2v2)


			    RemoveAllPedWeapons(queue2v2[i], false)
			    GiveWeaponToPed(queue2v2[i], GetHashKey("weapon_pistol_mk2"), 200, true)
			    SetCurrentPedWeapon(queue2v2[i], GetHashKey("weapon_pistol_mk2"), true)

			    TriggerClientEvent("zon_pvp:msg", queue2v2[i], 2)
			end
			

		    TriggerEvent("zon_pvp:die2v2", queue2v2[1], queue2v2[2], queue2v2[3], queue2v2[4])

		    dimension2v2 = dimension2v2 + 1
			table.remove(queue2v2, 4)
		   	table.remove(queue2v2, 3)
		    table.remove(queue2v2, 2)
		   	table.remove(queue2v2, 1)
			  
		end
    	Citizen.Wait(1200)
  	end
end)

RegisterServerEvent("zon_pvp:die2v2")
AddEventHandler("zon_pvp:die2v2", function(player1, player2, player3, player4) -- TEAM 1 - PLAYER 1 AND 2
	Citizen.CreateThread(function()												   -- TEAM 2 - PLAYER 3 AND 4
		while true do
			
			if (GetEntityHealth(GetPlayerPed(player1))<=healthlimit and GetEntityHealth(GetPlayerPed(player2))<=healthlimit or GetEntityHealth(GetPlayerPed(player3))<=healthlimit and GetEntityHealth(GetPlayerPed(player4))<=healthlimit) then
				if (GetEntityHealth(GetPlayerPed(player1))<=healthlimit and GetEntityHealth(GetPlayerPed(player2))<=healthlimit) then
					TriggerClientEvent("zon_pvp:msgLost", player1)
					TriggerClientEvent("zon_pvp:msgLost", player2)
					TriggerClientEvent("zon_pvp:msgWon", player3)
					TriggerClientEvent("zon_pvp:msgWon", player4)
					
				elseif (GetEntityHealth(GetPlayerPed(player3))<=healthlimit and GetEntityHealth(GetPlayerPed(player4))<=healthlimit) then
					TriggerClientEvent("zon_pvp:msgLost", player4)
					TriggerClientEvent("zon_pvp:msgLost", player3)
					TriggerClientEvent("zon_pvp:msgWon", player2)
					TriggerClientEvent("zon_pvp:msgWon", player1)
					
				end

				Citizen.Wait(1700)
				
				local players = {player1, player2, player3, player4}
				local xPlayer = ESX.GetPlayerFromId(player1)
				local xPlayer2 = ESX.GetPlayerFromId(player2)
				local xPlayer3 = ESX.GetPlayerFromId(player3)
				local xPlayer4 = ESX.GetPlayerFromId(player4)

				for i=4,1,-1 do
					SetEntityCoords(GetPlayerPed(players[i]), -167.3623, 1579.118, 7.125113,1,0,0,1)
					SetEntityHeading(players[i], 314.48)
					SetPlayerRoutingBucket(players[i], 0)
					TriggerClientEvent('uptime:revive', players[i])
					RemoveAllPedWeapons(players[i], false)
					if xPlayer then
						for i=1, #xPlayer.inventory, 1 do
							if xPlayer.inventory[i].count > 0 then
								xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
							end
						end
					end
					if xPlayer2 then
						for i=1, #xPlayer2.inventory, 1 do
							if xPlayer2.inventory[i].count > 0 then
								xPlayer2.setInventoryItem(xPlayer2.inventory[i].name, 0)
							end
						end
					end
					if xPlayer3 then
						for i=1, #xPlayer3.inventory, 1 do
							if xPlayer3.inventory[i].count > 0 then
								xPlayer3.setInventoryItem(xPlayer3.inventory[i].name, 0)
							end
						end
					end
					if xPlayer4 then
						for i=1, #xPlayer4.inventory, 1 do
							if xPlayer4.inventory[i].count > 0 then
								xPlayer4.setInventoryItem(xPlayer3.inventory[i].name, 0)
							end
						end
					end
				end
				break
			end
			Citizen.Wait(1)
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		if (dimension1v1==(initialdimension1v1+301)) then
			dimension1v1=initialdimension2v2
		end
		Citizen.Wait(10)
	end
end)

-- 2V2
Citizen.CreateThread(function()
	while true do
		if (dimension2v2==(initialdimension2v2+301)) then
			dimension2v2=initialdimension2v2
		end
		Citizen.Wait(10)
	end
end)

AddEventHandler('playerDropped', function (reason)
  id = source
end)

-- RegisterServerEvent('zon_pvp:saveInfo')
-- AddEventHandler('zon_pvp:saveInfo', function(_victorias, _derrotas, _elo)
--     local derrotas = _derrotas
--     local victorias = _victorias
-- 	local elo = _elo
-- 	local _src = source
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local result = ESX.mongodb.findSync({ collection = "pvp", query = { identifier = xPlayer.identifier } })
-- 	if GetPlayerRoutingBucket(_src) == 1000 or GetPlayerRoutingBucket(_src) == 0 then
		
-- 		if result[1] ~= nil then
-- 			exports.mongodb:updateOne({ collection="pvp", query = { identifier = xPlayer.identifier }, update = { ["$set"] = { victorias = victorias, derrotas = derrotas, elo = elo } } })
-- 		else
-- 			exports.mongodb:insertOne({ collection="pvp", document = { identifier = xPlayer.identifier, victorias = victorias, derrotas = derrotas, elo = elo }})
-- 		end

-- 	end
-- end)


-- ESX.RegisterServerCallback('zon_pvp:getInfo', function(source,cb) 
--     local xPlayer = ESX.GetPlayerFromId(source)
-- 	local _src = source
--     local info = {}
--     local result = ESX.mongodb.findSync({ collection = "pvp", query = { identifier = xPlayer.identifier } })
   
	
-- 	if result[1] ~= nil then
-- 		if result[1].victorias ~= nil then
-- 			table.insert(info, {victorias = result[1].victorias, derrotas = result[1].derrotas, elo = result[1].elo })

-- 			cb(info)

-- 		end

-- 	end

-- end)


RegisterServerEvent('zon_pvp:killed')
AddEventHandler('zon_pvp:killed', function (killer)
    xSource = ESX.GetPlayerFromId(source)
    
    
    if killer ~= nil then
        xPlayer = ESX.GetPlayerFromId(killer)    
        TriggerClientEvent('heal', killer)
        TriggerClientEvent('zon_pvp:addKill',killer)  
    end

    xSource.triggerEvent('zon_pvp:addDeath')  
    
end)

RegisterServerEvent('zon_pvp:killed2')
AddEventHandler('zon_pvp:killed2', function (id)
    xSource = ESX.GetPlayerFromId(source)

    xSource.triggerEvent('zon_pvp:addKill')  
    
end)

function sendToDiscord(title, message, footer)
local embed = {}
embed = {
	{
		["color"] = 10310399, -- GREEN = 65280 --- RED = 16711680
		["title"] = "" ..title..  "",
		["description"] = "" .. message ..  "",
		["footer"] = {
			["text"] = footer,
		},
	}
}
-- Start
-- TODO Input Webhook
PerformHttpRequest("https://discord.com/api/webhooks/939373769200402432/QAHAIfR7jZyh7vpudQ5TBUJG_-1oRpnYuK_Bo-uXcz3ED_319MeV9XHtDHl8q7yS_JId", 
function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
-- END
end

function sendToDiscord2(title, message, footer)
	local embed = {}
	embed = {
		{
			["color"] = 10310399, -- GREEN = 65280 --- RED = 16711680
			["title"] = "" ..title..  "",
			["description"] = "" .. message ..  "",
			["footer"] = {
				["text"] = footer,
			},
		}
	}
	-- Start
	-- TODO Input Webhook
	PerformHttpRequest("https://discord.com/api/webhooks/939373769200402432/QAHAIfR7jZyh7vpudQ5TBUJG_-1oRpnYuK_Bo-uXcz3ED_319MeV9XHtDHl8q7yS_JId", 
	function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
	-- END
	end

	
-- ACABO Y EMPIEZA SPEED
