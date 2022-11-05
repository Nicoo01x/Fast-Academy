Citizen.CreateThread(function()
    while ESX == nil do
        Wait(1)
    end

    ESX.RegisterServerCallback('guille_gangs:server:getPlyInv', function(source,cb) 
        local _src = source
        local xPlayer  = ESX.GetPlayerFromId(_src)
        local weapons  = xPlayer.getLoadout()
        local accounts = xPlayer.getAccounts()
        local items    = xPlayer.getInventory()
        cb(accounts, items, weapons)
    end)

    ESX.RegisterServerCallback('guille_gangs:server:getGangInv', function(source, cb, gang) 
        local _src = source
        local inv = gangs[gang].gangInfo().getInv()
        cb(inv)
    end)

end)

RegisterServerEvent("guille_gangs:server:addItemToInv")
AddEventHandler("guille_gangs:server:addItemToInv", function(type, name, count, label, gang)
    local _src = source
    local actgang = gangs[gang].gangActions()
    local xPlayer = ESX.GetPlayerFromId(_src)
    if type == "account" then
        local date = os.date('*t')
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

        sendToDisc(gang.." El jugador con nombre " .. GetPlayerName(_src) .. " ha depositado ."..name.. "Cantidad: "..count, 
        'Fecha ' .. date.day .. '/' .. date.month .. '/' .. date.year .. ' | ' .. date.hour .. ':' .. date.min ..  ' minutos con ' .. date.sec .. " segundos",  webHook, 16711680)

        xPlayer.removeAccountMoney(name, count)
    elseif type == "item" then
        local date = os.date('*t')
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

        sendToDisc(gang.." El jugador con nombre " .. GetPlayerName(_src) .. " ha depositado . "..name.. " Cantidad: "..count, 
        'Fecha ' .. date.day .. '/' .. date.month .. '/' .. date.year .. ' | ' .. date.hour .. ':' .. date.min ..  ' minutos con ' .. date.sec .. " segundos",  webHook, 16711680)
        xPlayer.removeInventoryItem(name, count)
    elseif type == "weapon" then
        local date = os.date('*t')
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

        sendToDisc(gang.." El jugador con nombre ".. GetPlayerName(_src) .. " ha depositado . "..name, 
        'Fecha ' .. date.day .. '/' .. date.month .. '/' .. date.year .. ' | ' .. date.hour .. ':' .. date.min ..  ' minutos con ' .. date.sec .. " segundos",  webHook, 16711680)
        xPlayer.removeWeapon(name)
    end
    actgang.addItemToInv(type, name, count, label, function(result)
        if result then
            log("Success putting item")
        end
    end)
end)

RegisterServerEvent("guille_gangs:server:removeItemInv")
AddEventHandler("guille_gangs:server:removeItemInv", function(type, name, count, gang)
    local _src = source
    local actgang = gangs[gang].gangActions()
    local xPlayer = ESX.GetPlayerFromId(_src)
    if type == "account" then
        local date = os.date('*t')
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

        sendToDisc(gang.." El jugador con nombre " .. GetPlayerName(_src) .. " ha sacado . "..name.. " Cantidad: "..count, 
        'Fecha ' .. date.day .. '/' .. date.month .. '/' .. date.year .. ' | ' .. date.hour .. ':' .. date.min ..  ' minutos con ' .. date.sec .. " segundos",  webHook, 16711680)
        xPlayer.addAccountMoney(name, count)
    elseif type == "item" then
        local date = os.date('*t')
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

        sendToDisc(gang.." El jugador con nombre " .. GetPlayerName(_src) .. " ha sacado . "..name.. " Cantidad: "..count, 
        'Fecha ' .. date.day .. '/' .. date.month .. '/' .. date.year .. ' | ' .. date.hour .. ':' .. date.min ..  ' minutos con ' .. date.sec .. " segundos",  webHook, 16711680)
        xPlayer.addInventoryItem(name, count)
    elseif type == "weapon" then
        local date = os.date('*t')
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

        sendToDisc(gang.." El jugador con nombre " .. GetPlayerName(_src) .. " ha sacado . "..name.. " Cantidad: "..count, 
        'Fecha ' .. date.day .. '/' .. date.month .. '/' .. date.year .. ' | ' .. date.hour .. ':' .. date.min ..  ' minutos con ' .. date.sec .. " segundos",  webHook, 16711680)
        xPlayer.addWeapon(name, count)
    end
    actgang.removeItemOfInv(type, name, count, function(res)
        if res then
            log("Success getting item")
        end
    end)
end)

ESX.RegisterServerCallback('guille_gangs:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
            identifier   = xPlayer.identifier,
			weapons = xPlayer.getLoadout()
		}
        data.dob = xPlayer.get('dateofbirth')
        data.height = xPlayer.get('height')

        if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end

            TriggerEvent('esx_license:getLicenses', target, function(licenses)
                data.licenses = licenses
                
            end)
		end)
        cb(data)
	end
end)

RegisterNetEvent('guille_gangs:server:confiscatePlayerItem')
AddEventHandler('guille_gangs:server:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if targetItem.count > 0 and targetItem.count <= amount then
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem(itemName, amount)
				sourceXPlayer.showNotification("You robbed x" ..amount.. " of " ..sourceItem.label .. " - " ..sourceXPlayer.name)
				targetXPlayer.showNotification("You have been robbed x" ..amount.. " of " ..sourceItem.label .. " - " ..sourceXPlayer.name)
			else
				sourceXPlayer.showNotification("No puedes llevar más unidades de este item")
			end
		else
			sourceXPlayer.showNotification("Invalid quantity")
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney(itemName, amount)

		sourceXPlayer.showNotification("You robbed " .. amount .. " of " .. itemName .. " to " ..targetXPlayer.name)
		targetXPlayer.showNotification("You have been robbed " .. amount .. " of " .. itemName .. " to " ..targetXPlayer.name)

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon(itemName, amount)

		sourceXPlayer.showNotification("You robbed the weapon " .. ESX.GetWeaponLabel(itemName) .. " - " .. targetXPlayer.name.. " in quantity of x" ..amount)
		targetXPlayer.showNotification("You have been robbed the weapon " .. ESX.GetWeaponLabel(itemName) .. " - " .. targetXPlayer.name.. " in quantity of x" ..amount)
	end
end)

function sendToDisc(title, message, footer, webhookURL, color)
	local embed = {}
	embed = {
		{
			["color"] = 16711680, -- GREEN = 65280 --- RED = 16711680
			["title"] = "**".. title .."**",
      ["description"] = "** " .. message ..  " **",
			["footer"] = {
				["text"] = footer,
      },
		}
	}
	-- Start
	-- TODO Input Webhook
	PerformHttpRequest("https://discord.com/api/webhooks/908169097739636736/o_tyaGXBxbv6u9-zT1hRlQqmE6wWPiqlJS3ncjQWCXfX9Lzk4C_pzIz1KJc07jV2dPxv", 
	function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  -- END
end
