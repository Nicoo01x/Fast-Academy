

local deadPlayer = false
local deadTimers = 5

local dimensionCliente = 0
RegisterNetEvent("comprobardimension")
AddEventHandler("comprobardimension", function(dimension)
    dimensionCliente = dimension
end)


AddEventHandler('esx:onPlayerDeath', function(data)
    jule = true
end)

jule = false
ragdoll = false


Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		Citizen.Wait(100)
	end
end)


draw = function(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x,y)
end

isInComa = function()
	return deadPlayer
end

killGod = function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,102)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end

RegisterNetEvent('core:killGod')
AddEventHandler('core:killGod',function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,102)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end)

local spawn01 = 1
local spawn02 = 1

RegisterNetEvent('respawnPlayer')
AddEventHandler('respawnPlayer',function()
	local ped = PlayerPedId()

	deadTimers = 0
	deadPlayer = false

	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,399)
	ClearPedTasksImmediately(ped)
    Wait(400)
	TriggerEvent("esx_ambulancejob:revive")
end)