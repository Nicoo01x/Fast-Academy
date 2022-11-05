ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('unknown_command', command_args[1]) } })
end)

RegisterCommand('ooc', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetPlayerName(source) end
	--DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('ooc_prefix', ''..source..' '..name), args, { 255, 153, 153, 0 })
	exports.JD_logs:discord("OOC | " .. GetPlayerName(source)..": "..rawCommand:gsub("OOC ", ""), 0, 0, '#F1F1F1', 'chat')

	
end, false)

RegisterCommand('civil', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetRealPlayerName(source) end
	--DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('civil_prefix', ''..source..' '), args, { 255, 255, 153, 0 })
	
end, false)

RegisterCommand('ayuda', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('ayuda_prefix', '['..source..'] '..name), args }, color = { 255, 100, 0 } })
	exports.JD_logs:discord("Ayuda | " .. GetPlayerName(source)..": "..rawCommand:gsub("Ayuda ", ""), 0, 0, '#F1F1F1', 'chat')

end, false)

RegisterCommand('id', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetRealPlayerName(source) end
	--DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('id_prefix', ''..source..' '), args }, color = { 255, 0, 255 } })
	
end, false)

RegisterCommand('msg', function(source, args, user)

	if GetPlayerName(tonumber(args[1])) then
		local player = tonumber(args[1])
		table.remove(args, 1)
		
		TriggerClientEvent('chat:addMessage', player, {args = {"^5[MSG] "..GetPlayerName(source).. " [" .. source .. "] : ^7" ..table.concat(args, " ")}, color = {255, 255, 255}})
		TriggerClientEvent('chat:addMessage', source, {args = {"^1Has Enviado un MSG a  ^4"..GetPlayerName(player).. "^6 [" .. player .. "] ^3[con el mensaje]: ^0" ..table.concat(args, " ")}, color = {255, 153, 0}})

	else
		TriggerClientEvent('chatMessage', source, "SISTEMA", {255, 0, 0}, "ID de jugador incorrecta!")
	end

end,false)


RegisterCommand('meca', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "mechanic" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('meca_prefix', name), args }, color = { 102, 255, 153 } })
		exports.JD_logs:discord("Mecanico | " .. GetPlayerName(source)..": "..rawCommand:gsub("meca ", ""), 0, 0, '#F1F1F1', 'chat')

	end
end, false)


RegisterCommand('pol', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "police" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('pol_prefix', name), args }, color = { 94, 161, 224 } })
		exports.JD_logs:discord("PFA | " .. GetPlayerName(source)..": "..rawCommand:gsub("Pol ", ""), 0, 0, '#F1F1F1', 'chat')

	end
end, false)

RegisterCommand('t', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "taxi" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('taxi_prefix', name), args }, color = { 30, 120, 6 } })
		exports.JD_logs:discord("Taxis | " .. GetPlayerName(source)..": "..rawCommand:gsub("Taxis ", ""), 0, 0, '#F1F1F1', 'chat')

	end
end, false)

RegisterCommand('cas', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "casino" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('cas_prefix', name), args }, color = { 102, 0, 102 } })
		exports.JD_logs:discord("Casino | " .. GetPlayerName(source)..": "..rawCommand:gsub("Casino ", ""), 0, 0, '#F1F1F1', 'chat')

	end
end, false)

RegisterCommand('same', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "ambulance" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('ems_prefix', name), args }, color = { 255, 51, 51 } })
		exports.JD_logs:discord("SAME | " .. GetPlayerName(source)..": "..rawCommand:gsub("same ", ""), 0, 0, '#F1F1F1', 'chat')

	end
end, false)


RegisterCommand('twt', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetRealPlayerName(source)
	if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('twt_prefix', name), args }, color = { 151, 19, 19} })
	exports.JD_logs:discord("Tweet | " .. GetPlayerName(source)..": "..rawCommand:gsub("tweet ", ""), 0, 0, '#F1F1F1', 'chat')

end, false)

RegisterCommand('add', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetRealPlayerName(source)
	if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('add_prefix', name), args }, color = { 151, 19, 19} })
	exports.JD_logs:discord("Publicidad | " .. GetPlayerName(source)..": "..rawCommand:gsub("add ", ""), 0, 0, '#F1F1F1', 'chat')

end, false)


RegisterCommand('anon', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('anon_prefix', '['..source..'] '), args }, color = { 0, 153, 204 } })
	exports.JD_logs:discord("Anon | " .. GetPlayerName(source)..": "..rawCommand:gsub("anon ", ""), 0, 0, '#F1F1F1', 'chat')

end, false)

RegisterCommand('local', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetPlayerName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('oop_prefix', '['..source..'] '..name), args, { 85, 85, 85 })
	exports.JD_logs:discord("local | " .. GetPlayerName(source)..": "..rawCommand:gsub("local ", ""), 0, 0, '#F1F1F1', 'chat')
end, false)

RegisterCommand('change', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetRealPlayerName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('change_prefix', '['..source..'] '), args }, color = { 146, 40, 191 } })
	--print(('%s: %s'):format(name, args))
end, false)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if Config.EnableESXIdentity then
			if Config.OnlyFirstname then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end
local logEnabled = true

function DrawOnHead(playerid, text, color)
	TriggerClientEvent('esx_rpchat:drawOnHead', -1, text, color, playerid)
end
