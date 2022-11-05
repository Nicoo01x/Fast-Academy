ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


client = {}

inMenu = true
local Menu = true

local arsenal = {
	{ 621.4094, -18.68956, 82.77814 }
}



RegisterCommand('arsenal', function(source, args, rawCmd)
	for _,lugares in pairs(arsenal) do
		local x,y,z = table.unpack(lugares)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
		if distance <= 3 then
			 TriggerServerEvent('ruann:permissao')
		else
			exports['okokNotify']:Alert("Arsenal", "No estás cerca de la armeria", 3000, 'info')
			--TriggerClientEvent("esx:showNotification", source, "No estás cerca de la armeria")
		end
	end
	  inMenu = false
	  SetNuiFocus(false)
	  SendNUIMessage({type = 'close'})
end)


Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500

		--if (ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police") then

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, vector3(621.37, -18.74, 82.79), true)

			if dstCheck <= 5.0 then
				sleepThread = 5

				local text = "Armeria"

				if dstCheck <= 0.5 then
					text = "[~g~E~s~] Armeria"

					if IsControlJustPressed(0, 38) then
						ExecuteCommand("arsenal")
					end
				end

				--ESX.Game.Utils.DrawText3D(vector3(621.37, -18.74, 82.79), text, 0.6)
			end
		--end

		Citizen.Wait(sleepThread)
	end
end)


function client.PertoArsenal()
	local posPed = GetEntityCoords(PlayerPedId())
	for _, lugares in pairs(arsenal) do
		local x,y,z = table.unpack(lugares)
		if GetDistanceBetweenCoords(x,y,z, posPed) < 5 then
			return true 
		end
	end
end


RegisterNetEvent('ruann:permissao')
AddEventHandler('ruann:permissao',function()
	--print("si permisos")
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({showMenu = true})
end)


RegisterNUICallback('NUIFocusOff', function()
    SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
  --  SetCursorPosition(0.0,false)
end)

RegisterNUICallback('Glock', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPISTOL"),0)
	RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
	GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),200,0,1)
end)

RegisterNUICallback('Escopeta', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	SetPedAmmo(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),0)
	RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"))
	GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),80,0,1)
end)

RegisterNUICallback('Sigsauer', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPDW"),0)
	RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
	GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),250,0,1)
end)

RegisterNUICallback('Taurus', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	SetPedAmmo(ped,GetHashKey("WEAPON_SMG"),0)
	RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SMG"))
	GiveWeaponToPed(ped,GetHashKey("WEAPON_SMG"),250,0,1)
end)

RegisterNUICallback('AR15', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),0)
	RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"))
	GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),250,0,1)
end)
RegisterNUICallback('MPX', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE"),0)
	RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
	GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),250,0,1)
end)
RegisterNUICallback('KITBASICO', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,1)
	GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,1)
	GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,1)
end)
RegisterNUICallback('Taser', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,1)
end)
RegisterNUICallback('Lanterna', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,1)
end)
RegisterNUICallback('KCT', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,1)
end)
RegisterNUICallback('Pistola', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	GiveWeaponToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),0,0,1)
end)
RegisterNUICallback('Limpar', function()
	local ped = PlayerPedId()
	TriggerServerEvent('ruann:permissao')
	RemoveAllPedWeapons(ped,true)
end)