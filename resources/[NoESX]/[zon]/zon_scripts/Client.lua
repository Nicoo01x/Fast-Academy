local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



-----------------------------------------------------------------------------------------------------------------------------------------
-- RAGDOLL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local segundos = 0
	while true do
		Citizen.Wait(1)
		if segundos > 0 and GetEntityHealth(PlayerPedId()) > 100 then
			SetPedToRagdoll(PlayerPedId(),1000,1000,0,0,0,0)
		end
	end
end)


---- MAX HEAL---

AddEventHandler('playerSpawned', function()
    local playerPed = PlayerPedId()
    SetPedMaxHealth(playerPed, 200)
    if ((not IsEntityDead(playerPed)) and GetPedMaxHealth(playerPed) ~= 200 and GetEntityHealth(playerPed) > (GetPedMaxHealth(playerPed) / 2)) then
        SetEntityHealth(playerPed, 200)
    end
end)

-- Remove ambient audio --

Citizen.CreateThread(function()
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
end)

-- ANTI VDM--

CreateThread(function()
    while true do
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        for _, veh in pairs(GetGamePool("CVehicle")) do
            if veh ~= vehicle and veh ~= GetVehiclePedIsUsing(PlayerPedId()) then
                SetEntityNoCollisionEntity(vehicle, veh, false)
                SetEntityNoCollisionEntity(veh, vehicle, false)
            end
        end
        Wait(0)
    end
end)

--- librerías ESX --

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(6000)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(6000)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

-- Anti Culatazos --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed( -1 )
        local weapon = GetSelectedPedWeapon(ped)

        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

-- Balas/Attachs --

ESX = nil

RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
		local arma = GetSelectedPedWeapon(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_RAIL"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_FLSH_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_COMP"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
			veWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_MACHINEPISTOL_CLIP_02	"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SMG_MK2_CLIP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_combatpdw") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SR_SUPP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SIGHTS"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_06"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_03"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_BARREL_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_04"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_snspistol_mk2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CLIP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_07"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_04"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_APPISTOL") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_APPISTOL_CLIP_02"))
		end

		ESX.ShowNotification("Has puesto componentes a tu arma")
	end)

	RegisterCommand('balas', function()
		ped = PlayerPedId()
		if IsPedArmed(ped, 4) then
		  hash=GetSelectedPedWeapon(ped)
		  if hash~=nil then
			AddAmmoToPed(PlayerPedId(), hash,500)
			--exports['okokNotify']:Alert("Fast Academy", "Has Recargado las balas", 3000, 'info')
			ESX.ShowNotification("Has utilizado un cargador")
		  else
			--exports['okokNotify']:Alert("Fast Academy", "No tienes un arma en mano", 3000, 'error')
			ESX.ShowNotification("No tienes un arma en mano")
		  end
		else
			--exports['okokNotify']:Alert("Fast Academy", "No tienes un arma en mano", 3000, 'error')
		  ESX.ShowNotification("No tienes arma en mano")
		end
	  end)

-- Silenciador
RegisterCommand("silenciador",function(source,args)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_APPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL50") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_VINTAGEPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_VINTAGEPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CERAMICPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CERAMICPISTOL"),GetHashKey("COMPONENT_CERAMICPISTOL_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_PI_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MACHINEPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_AT_SR_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SR_SUPP_03"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_AT_AR_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSHOTGUN"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMPACTRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMPACTRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
	end
end)

-- Quitar casco --

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(2000)
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if veh ~= 0 then 
            SetPedConfigFlag(PlayerPedId(),35,false) 
        end
    end
end)

-- Cor -- 

RegisterCommand("cor",function(source,args)
    local tinta = tonumber(args[1])
    local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
        if tinta >= 0 then
            SetPedWeaponTintIndex(ped,arma,tinta)
        end
end, false)


-- Hide Hud --

-- Configuration array for all HUD elements
CreateThread(function()-- https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    while true do
          HideHudComponentThisFrame(1) -- 1 : WANTED_STARS
          HideHudComponentThisFrame(3) -- 3 : CASH
          HideHudComponentThisFrame(4) -- 4 : MP_CASH
          HideHudComponentThisFrame(5)            -- 5 : MP_MESSAGE
          HideHudComponentThisFrame(6)            -- 6 : VEHICLE_NAME
          HideHudComponentThisFrame(7) -- 7 : AREA_NAME
          HideHudComponentThisFrame(8)            -- 8 : VEHICLE_CLASS
          HideHudComponentThisFrame(9) -- 9 : STREET_NAME
         -- HideHudComponentThisFrame(10)        -- 10 : HELP_TEXT
          --HideHudComponentThisFrame(11)        -- 11 : FLOATING_HELP_TEXT_1
          --HideHudComponentThisFrame(12)        -- 12 : FLOATING_HELP_TEXT_2
          HideHudComponentThisFrame(13) -- 13 : CASH_CHANGE
          HideHudComponentThisFrame(15)        -- 15 : SUBTITLE_TEXT
          HideHudComponentThisFrame(17) -- 17 : SAVING_GAME
          HideHudComponentThisFrame(18)        -- 18 : GAME_STREAM
          HideHudComponentThisFrame(20) -- 20 : WEAPON_WHEEL_STATS
        HideHudComponentThisFrame(21) -- 21 : HUD_COMPONENTS
        DisplayAmmoThisFrame(false)

        Wait(4)
    end
end)

-- Limpiar --

RegisterCommand('limpiar',function(source,args,rawCommand,text)
    --exports['okokNotify']:Alert("Fast Academy", "Vehiculo limpio", 5000, 'info')
        WashDecalsFromVehicle(GetVehiclePedIsUsing(PlayerPedId()), 0.0)
        SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()))
end)


RegisterCommand('reparar', function()
    if IsPedInAnyVehicle(PlayerPedId()) then 
        SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
        SetVehicleDeformationFixed(GetVehiclePedIsIn(PlayerPedId()))
        SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), false)
        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), true, true)
        ESX.ShowNotification("<span style='color:#0CB8EA'>Coche</span> reparado")
    else
        ESX.ShowNotification("<span style='color:#EA0C0C'>Debes</span> de estar dentro de un vehículo")
    end
end)
-- MiniMapa --

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(2000)

        local playerPed = PlayerPedId()
        local playerVeh = GetVehiclePedIsIn(playerPed, false)

        if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
            DisplayRadar(true)
        else
            DisplayRadar(false)
        end
    end
end)

-- No Q --

Citizen.CreateThread(function()
	while false do
	  s = 1000
	  if not IsPauseMenuActive() then
		s = 5
		DisableControlAction(0,44,true) -- Modify the second value to the key u wish to disable.
	  else
		s = 100
	  end
	  Citizen.Wait(s)
	end
  end)
  
  RegisterCommand('QU',
	function()
	  DisableControlAction(0,44,true)
	end
  )
  
  RegisterKeyMapping('QU','','keyboard','Q')

-- Full Stamina --

Citizen.CreateThread( function()
    while true do
       Citizen.Wait(1)
       RestorePlayerStamina(PlayerId(), 1.0)
       -- it's that simple
   end
end)

-- Tabulador --

Citizen.CreateThread(function()

    ReplaceHudColour(116, 6)

end)

-- Tuning --

RegisterCommand('tuning', function()
	TriggerEvent('tuning');
end)

RegisterNetEvent('tuning')
AddEventHandler('tuning', function()
	local p = PlayerPedId()
	
	if IsPedInAnyVehicle(p, false) then
		local vehicle = GetVehiclePedIsIn(p, false)
		SetVehicleFuelLevel(GetVehiclePedIsUsing(p), 100.0)
		
		ESX.Game.SetVehicleProperties(vehicle, {
			modEngine       = 3,
			modBrakes       = 2,
			modTransmission = 2,
			modSuspension   = 3,
			modTurbo        = true,
            windowTint      = 1,
            modSpoilers     = 7,
            plate           = 12345678,
            modFrontBumper  = 4,
            modRearBumper   = 3,
            modSideSkirt    = 4,
            modExhaust      = 8,
            modFrame        = 8,
            modFender       = 0,
            modRoof         = 0,
            modSmokeEnabled = true,
        })
		SetVehicleDirtLevel(GetVehiclePedIsUsing(p), 0)
		--exports['okokNotify']:Alert("Fast Academy", "Vehículo tuneado.", 5000, 'error')
        if Config.showNotification then
            ESX.ShowNotification("Has Tuneado el Vehiculo.")
        end
	end
	
end)	

-- Blips --

local blips = {

      {title="Zona de Pare", colour=57, id=267, x=134.8944, y=-1074.0541, z=29.1924},
	  {title="Predio", colour=57, id=267, x=102.2830, y=-873.4330, z=137.9539},
    
    } 
  
      Citizen.CreateThread(function()
    
        for _, info in pairs(blips) do
          info.blip = AddBlipForCoord(info.x, info.y, info.z)
          SetBlipSprite(info.blip, info.id)
          SetBlipDisplay(info.blip, 4)
          SetBlipScale(info.blip, 0.6)
          SetBlipColour(info.blip, info.colour)
          SetBlipAsShortRange(info.blip, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(info.title)
          EndTextCommandSetBlipName(info.blip)
        end
    end)

-- Policia Armas givea

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        DisablePlayerVehicleRewards(PlayerId())
    end
end)

-- Pvp
AddEventHandler("playerSpawned", function(spawn)
	SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)
end) 

-- Agacharse

local OPA = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = PlayerPedId()

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true )

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( OPA == true ) then 
                        ResetPedMovementClipset( ped, 0 )
                        OPA = false 
                    elseif ( OPA == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        OPA = true 
                    end 
                end
            end 
        end 
    end
end )

-- Control Day

-----------------------------------------------------------------------------------------------------------------------------------------
-- MINIMAPZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetMapZoomDataLevel(0,0.96,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(1,1.6,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(2,8.6,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(3,12.3,0.9,0.08,0.0,0.0)
	SetMapZoomDataLevel(4,22.3,0.9,0.08,0.0,0.0)
end)

local hour = 12
local minute = 0

local weathers = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "HALLOWEEN"
}

CurrentWeather = "EXTRASUNNY"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------


RegisterCommand('clima', function(source, args)
    if args[1] then
        local weather = tonumber(args[1])
        if weather > 0 then
            if weathers[weather] then
                actualWeather = weathers[weather]
                CurrentWeather = actualWeather
				--exports['okokNotify']:Alert("Fast Academy", "Has cambiado tu clima a "..actualWeather, 5000, 'error')
                ESX.ShowNotification("Has cambiado tu clima a "..actualWeather)
            --    TriggerEvent("esx:showNotification", source, "Has cambiado tu clima a "..actualWeather)
            end
        else
			--exports['okokNotify']:Alert("Fast Academy", "Tienes que especificar un numero del 1 al "..#weathers, 5000, 'error')
            ESX.ShowNotification("Tienes que especificar un numero del 1 al "..#weathers)
            --TriggerEvent("esx:showNotification", source, "Tienes que especificar un numero del 1 al "..#weathers)
        end
    else
		--exports['okokNotify']:Alert("Fast Academy", "Tienes que especificar un numero del 1 al "..#weathers, 5000, 'error')
        ESX.ShowNotification("Tienes que especificar un numero del 1 al "..#weathers)
       --TriggerEvent("esx:showNotification", source, "Tienes que especificar un numero del 1 al "..#weathers)
        
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Wait 0 seconds to prevent crashing.
        SetWeatherTypeOverTime(CurrentWeather, 10.0)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(CurrentWeather)
        SetWeatherTypeNow(CurrentWeather)
        SetWeatherTypeNowPersist(CurrentWeather)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("time",function(source,args)
    if tonumber(args[1]) and tonumber(args[2]) then
        hour = tonumber(args[1])
        minute = tonumber(args[2])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCHE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("noche",function(source,args)
    hour = 22
    minute = 00
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dia",function(source,args)
    hour = 12
    minute = 00
end)

-------------- ZONA ROJA

local zone = nil
local blip = nil

Citizen.CreateThread(function()
	Citizen.Wait(1)
	for _,new_zone in pairs(client.zones) do
		
		zone = AddBlipForRadius(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z, new_zone.zone.radius)
		SetBlipSprite(zone, 9)
		SetBlipAlpha(zone, 100)
		SetBlipColour(zone, new_zone.zone.color)
		
		if (new_zone.blip.draw == true) then
			blip = AddBlipForCoord(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z)
			SetBlipSprite(blip, new_zone.blip.id)
			SetBlipColour(blip, new_zone.blip.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(new_zone.blip.text)
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip, true)
		end
		
	end
end)



------------------------------------------------------------------------------
-- CONFIG

client = {
	
	zones = {
		{
			coords = {x = 952.36,  y = -2306.72,  z = 57.32}, 			
			zone = {radius = 280.0, color = 1}, 
			blip = {draw = true, id = 303, color = 1, text = "Zona roja"}		
		}

	}
	
}

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

local zone = nil
local blip = nil

Citizen.CreateThread(function()
	Citizen.Wait(1)
	for _,new_zone in pairs(client2.zones) do
		
		zone = AddBlipForRadius(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z, new_zone.zone.radius)
		SetBlipSprite(zone, 9)
		SetBlipAlpha(zone, 100)
		SetBlipColour(zone, new_zone.zone.color)
		
		if (new_zone.blip.draw == true) then
			blip = AddBlipForCoord(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z)
			SetBlipSprite(blip, new_zone.blip.id)
			SetBlipColour(blip, new_zone.blip.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(new_zone.blip.text)
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip, true)
		end
		
	end
end)

------------------------------------------------------------------------------
-- CONFIG

client2 = {
	
	zones = {
		{
			coords = {x = -1704.24,  y = -1003.04,  z = 90.52}, 
			zone = {radius = 350.0, color = 1}, 
			blip = {draw = true, id = 303, color = 1, text = "Zona roja"}			
		}

	}
	
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- RSKIN
-----------------------------------------------------------------------------------------------------------------------------------------

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esfer_rskin:rskin')
AddEventHandler('esfer_rskin:rskin', function()
    local uniforms = {
        male = {
	        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	        ['torso_1'] = 260,  ['torso_2'] = 23,
	        ['decals_1'] = 0,   ['decals_2'] = 0,
	        ['arms'] = 11,
	        ['pants_1'] = 26,   ['pants_2'] = 6,
	        ['shoes_1'] = 1,    ['shoes_2'] = 0,
	        ['chain_1'] = 0,    ['chain_2'] = 0
        },

        female = {
	        ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
	        ['torso_1'] = 269,  ['torso_2'] = 23,
	        ['decals_1'] = 0,   ['decals_2'] = 0,
	        ['arms'] = 9,
	        ['pants_1'] = 0,    ['pants_2'] = 8,
	        ['shoes_1'] = 1,    ['shoes_2'] = 1,
	        ['chain_1'] = 0,    ['chain_2'] = 0
        }
    }

    local playerPed = PlayerPedId()
    local lastHealth = GetEntityHealth(playerPed) 
    local defaultModel = GetHashKey('a_m_y_stbla_02')

    SetEntityVisible(PlayerPedId(), false)
    RequestModel(defaultModel)

    while not HasModelLoaded(defaultModel) do
        Citizen.Wait(100)
    end

    SetPlayerModel(PlayerId(), defaultModel)

    SetPedDefaultComponentVariation(PlayerPedId())
    SetPedRandomComponentVariation(PlayerPedId(), true)
    SetModelAsNoLongerNeeded(defaultModel)
    FreezeEntityPosition(PlayerPedId(), false)
 
    Citizen.Wait(300)

    TriggerEvent('skinchanger:getSkin', function(skin)
        skin['sex'] = changeSex(skin['sex'])
        TriggerEvent('skinchanger:loadSkin', skin)
        Citizen.Wait(300)
        skin['sex'] = changeSex(skin['sex'])
        TriggerEvent('skinchanger:loadSkin', skin)
		--exports['okokNotify']:Alert("Fast Academy", "Tu personaje se ha recargado correctamente", 5000, 'info')
        ESX.ShowNotification('Tu personaje se ha recargado correctamente', 'success', 'Reload Skin')
    end)
    Citizen.Wait(1000)
    TriggerEvent('skinchanger:getSkin', function(skin)
  
        if skin.sex == 0 then
            if uniforms.male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, uniforms.male)
            else
				--exports['okokNotify']:Alert("Fast Academy", "Ha ocurrido un error", 5000, 'error')
                ESX.ShowNotification('Ha ocurrido un error', 'error', 'Reload Skin')
            end
        else
            if uniforms.female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, uniforms.female)
            else
				--exports['okokNotify']:Alert("Fast Academy", "Ha ocurrido un error", 5000, 'error')
                ESX.ShowNotification("<span style='color:#EA0C0C'>Ha</span> ocurrido un error", 'error', 'Reload Skin')
            end
        end
    end)
    Citizen.Wait(300)

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)

    SetEntityHealth(PlayerPedId(), lastHealth)
    SetEntityVisible(PlayerPedId(), true)
    ClearPedTasksImmediately(PlayerPedId())

    RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_DAGGER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BAT")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BOTTLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_CROWBAR")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_GOLFCLUB")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HAMMER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HATCHET")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNUCKLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MACHETE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SWITCHBLADE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_NIGHTSTICK")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_WRENCH")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_WRENCH")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BATTLEAXE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_POOLCUE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_STONE_HATCHET")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_APPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_STUNGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL50")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SNSPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SNSPISTOL_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_VINTAGEPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_FLAREGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_RAYPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_CERAMICPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_NAVYREVOLVER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_GADGETPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MICROSMG")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SMG")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SMG_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPDW")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MACHINEPISTOL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINISMG")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_RAYCARBINE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PUMPSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PUMPSHOTGUN_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SAWNOFFSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_DBSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_AUTOSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_COMBATSHOTGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_ADVANCEDRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SPECIALCARBINE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SPECIALCARBINE_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPRIFLE_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_COMPACTRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MILITARYRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MG")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_COMBATMG")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_COMBATMG_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_GUSENBERG")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SNIPERRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSNIPER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSNIPER_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MARKSMANRIFLE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MARKSMANRIFLE_MK2")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_RPG")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_GRENADELAUNCHER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_FIREWORK")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_RAILGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HOMINGLAUNCHER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_COMPACTLAUNCHER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_RAYMINIGUN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_GRENADE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BZGAS")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MOLOTOV")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_STICKYBOMB")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PROXMINE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SNOWBALL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PIPEBOMB")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_BALL")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_SMOKEGRENADE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_FLARE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HAZARDCAN")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_FIREEXTINGUISHER")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("GADGET_PARACHUTE")) RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PETROLCAN"))

    TriggerEvent('esx_tattooshop:cleanPlayer')

    TriggerServerEvent('esfer_rskin:recargararmas', source)
end)

function changeSex(sex)
    if sex == 0 then sex = 1 else sex = 0 end
    return sex
end

RegisterCommand("rskin", function(source, args, raw)
    TriggerEvent("esfer_rskin:rskin")
end, false)

--------------------------------------------------------------------------------------------------------------
---------- Zona Seguras
--------------------------------------------------------------------------------------------------------------

local ESX = exports['es_extended']:getSharedObject()

local SafezoneIn = false
local SafezoneOut = false
local closestZone = 1
local allowedToUse = false
local bypass = false

Citizen.CreateThread(function()
	TriggerServerEvent("SafeZones:isAllowed")
end)

RegisterNetEvent("SafeZones.returnIsAllowed")
AddEventHandler("SafeZones.returnIsAllowed", function(isAllowed)
    allowedToUse = isAllowed
end)

RegisterCommand("sbypass", function(source, args, rawCommand)
	if allowedToUse then
	if not bypass then
	bypass = true
	ShowInfo("~g~SafeZone Bypass Enabled!")
	elseif bypass then
	bypass = false
	ShowInfo("~r~SafeZone Bypass Disabled!")
	end
else
	ShowInfo("~r~Insufficient Permissions.")
end
end)

Citizen.CreateThread(function()
	for i = 1, #Config.zones, 1 do
	local blip = AddBlipForRadius(Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, Config.radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 11)
	SetBlipAlpha (blip, 128)
    local blip1 = AddBlipForCoord(x, y, z)
	SetBlipSprite (blip1, sprite)
	SetBlipDisplay(blip1, true)
	SetBlipScale  (blip1, 0.9)
	SetBlipColour (blip1, 11)
    SetBlipAsShortRange(blip1, true)
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		Citizen.Wait(1)
		for i = 1, #Config.zones, 1 do
			dist = Vdist(Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local player = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(Config.zones[closestZone].x, Config.zones[closestZone].y, Config.zones[closestZone].z, x, y, z)
		local vehicle = GetVehiclePedIsIn(player, false)
		local speed = GetEntitySpeed(vehicle)


		if dist <= Config.radius then
			if not SafezoneIn then
				NetworkSetFriendlyFireOption(false)
				SetEntityCanBeDamaged(vehicle, false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				if Config.showNotification then
				exports['okokNotify']:Alert("Fast Academy", "Has entrado a una zona segura.", 5000, 'error')
					--ESX.ShowNotification("Has entrado a una zona segura.")
				end
				SafezoneIn = true
				SafezoneOut = false
			end
		else
			if not SafezoneOut then
				NetworkSetFriendlyFireOption(true)
				if Config.showNotification then
					exports['okokNotify']:Alert("Fast Academy", "Has salido de una zona segura.", 5000, 'error')
					--ESX.ShowNotification("Has salido de a una zona segura.")
				end
				if Config.speedlimitinSafezone then
				SetVehicleMaxSpeed(vehicle, 1000.00)
				end
				SetEntityCanBeDamaged(vehicle, true)
				SafezoneOut = true
				SafezoneIn = false
			end
			Citizen.Wait(200)
		end
		if SafezoneIn then
		Citizen.Wait(10)
    if not bypass then
		SetEntityHealth(PlayerPedId(), 200)
		DisablePlayerFiring(player, true)
		SetPlayerCanDoDriveBy(player, false)
		DisableControlAction(2, 37, true)
      	DisableControlAction(0, 106, true)
		DisableControlAction(0, 24, true)
		DisableControlAction(0, 69, true)
		DisableControlAction(0, 70, true)
		DisableControlAction(0, 92, true)
		DisableControlAction(0, 114, true)
		DisableControlAction(0, 257, true)
		DisableControlAction(0, 331, true)
		DisableControlAction(0, 68, true)
		DisableControlAction(0, 257, true)
		DisableControlAction(0, 263, true)
		DisableControlAction(0, 264, true)

		if Config.speedlimitinSafezone then
		mphs = 2.237
		maxspeed = Config.speedlimitinSafezone/mphs
		SetVehicleMaxSpeed(vehicle, maxspeed)
		end

			if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			end
			if IsDisabledControlJustPressed(0, 106) then 
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			end
	end
end
end
end)


function ShowInfo(text)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(true, false)
end

--------------------------------------------------------------------------------------------------------
---- ESX_CLOTHESHOP
--------------------------------------------------------------------------------------------------------

ESX = nil 
Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end 
end)

menutp = function()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'interaccions',{
        title = '¿Desea cambiarse de personaje?',
		align = 'center',
		elements = {
            {label = 'Si', value = '1'},
            {label = 'No', value = '2'},
		}
	},
	function(data, menu)
		local val = data.current.value
		
        if val == '1' then
            local xPlayer = PlayerPedId()
            TriggerEvent('esx_skin:openSaveableMenu', xPlayer)
            elseif val == '2' then
                ESX.UI.Menu.CloseAll()
                
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
    SpawnNPC('ig_claypain', vector4(122.9484, -1050.5543, 28.1924, 209.9557))
    while true do
    local _espera = 1000
    local ped = PlayerPedId()
    local _charPos = GetEntityCoords(ped)
    if #(_charPos - vector3(122.9484, -1050.5543, 29.1924)) < 2 then
        _espera = 0
        
        ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para abrir el Menu de ~b~Personaje", vector3(122.9484, -1050.5543, 29.1924))
        if IsControlJustPressed(0, 38) then
            menutp()
        end
    end
        Citizen.Wait(_espera)
end
end)

Citizen.CreateThread(function()
    SpawnNPC('ig_claypain', vector4(-838.4902, -424.4076, 35.6398, 76.4291))
    while true do
    local _espera = 1000
    local ped = PlayerPedId()
    local _charPos = GetEntityCoords(ped)
    if #(_charPos - vector3(-838.4902, -424.4076, 35.6398)) < 2 then
        _espera = 0
        
        ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para abrir el Menu de ~b~Personaje", vector3(122.9484, -1050.5543, 29.1924))
        if IsControlJustPressed(0, 38) then
            menutp()
        end
    end
        Citizen.Wait(_espera)
end
end)

SpawnNPC = function(modelo, x,y,z,h)
    hash = GetHashKey(modelo)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    crearNPC = CreatePed(5, hash, x,y,z,h, false, true)
    FreezeEntityPosition(crearNPC, true)
    SetEntityInvincible(crearNPC, true)
    SetBlockingOfNonTemporaryEvents(crearNPC, true)
    TaskStartScenarioInPlace(crearNPC, "WORLD_HUMAN_GUARD_STAND", 0, false)
end

