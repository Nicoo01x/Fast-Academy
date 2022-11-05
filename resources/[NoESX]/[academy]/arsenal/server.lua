ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local armas = {
}

RegisterServerEvent('ruann:permissao')
AddEventHandler('ruann:permissao', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == 'police' then
		TriggerClientEvent('ruann:permissao', src)
	end
end)
