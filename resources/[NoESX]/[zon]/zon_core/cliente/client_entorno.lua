ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

blip = nil
blips = {}

displayTime = 300 -- Tiempo para que desaparezca el blip (en segundos)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/entorno', 'Envia una llamada de entorno a la policia', {
    { name="Suceso", help="Escribe detalladamente lo que ha sucedido" }
})
end)

RegisterNetEvent('entorno:setBlip')
AddEventHandler('entorno:setBlip', function(name, x, y, z)
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 304)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 26)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Aviso policial')
	EndTextCommandSetBlipName(blip)
	table.insert(blips, blip)
	Wait(displayTime * 1000)
	for i, blip in pairs(blips) do 
		RemoveBlip(blip)
	end
end)

RegisterCommand('entorno', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5Entorno', {255,255,255}, ' ^7Por favor, escribe lo sucedido detalladamente.')
    else
        TriggerServerEvent('comprobarEntorno', msg, x, y, z, name)
    end
end)
