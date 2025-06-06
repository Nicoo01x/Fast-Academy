if Config.UseOldEsx then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

ESX.RegisterServerCallback("zon_menu:havePermissions", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == 'admin' then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('zon_menu:getInformation', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    local info = {
        money = xPlayer.getMoney(),
        bankmoney = xPlayer.getAccount('bank').money,
        blackmoney = xPlayer.getAccount('black_money').money
    }
    cb(info)
end)
