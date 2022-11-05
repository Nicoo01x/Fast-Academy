ESX = nil
local DISTANCIA = 2
local DISTANCIA_INTERACCION = 1.4


local MARKER_SIZE = 1.0
local E_KEY = 38

ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


local dimensionCliente = 0
RegisterNetEvent("comprobardimension")
AddEventHandler("comprobardimension", function(dimension)
    dimensionCliente = dimension
end)


-- MAIN CODE

RegisterNetEvent("cargoloadout")
AddEventHandler("cargoloadout", function(source)
    TriggerEvent('esx:restoreLoadout')
end)

CreateThread(function()
    while true do
        local wait = 1250
        local input = IsUsingKeyboard()
        local ped = PlayerPedId()
        if input ~= 1 then
            wait = 1
            DisablePlayerFiring(ped, true)
        end
        Citizen.Wait(wait)
    end
end)

CreateThread(function()
    for _, ped2 in pairs(Config.Peds) do
        if ped2.model ~= nil then
            local modelHash = GetHashKey(ped2.model)
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(1)
            end
            local SpawnedPed = CreatePed(2, modelHash, ped2.pos, ped2.h, false, true)
            TaskSetBlockingOfNonTemporaryEvents(SpawnedPed, true)
            Citizen.Wait(1)
            if ped2.animation ~= nil then
                --TaskStartScenarioInPlace(SpawnedPed, ped.animation, 0, false)
            end
            SetEntityInvincible(SpawnedPed, true)
            PlaceObjectOnGroundProperly(SpawnedPed)
            SetModelAsNoLongerNeeded(modelHash)
            Citizen.CreateThread(
                function()
                    local _ped = SpawnedPed
                    Citizen.Wait(1000)
                    FreezeEntityPosition(_ped, true)
                end
            )
        end
    end

    function spawnMarker(ped2, coords)
        
        if #(coords - ped2.pos) < DISTANCIA then
           -- DrawMarker(1, ped.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, MARKER_SIZE, MARKER_SIZE, 0.4, 102, 0, 204, 50, false, false, 2, false, false, false, false)
         --  ESX.ShowFloatingHelpNotification("Presiona la tecla E para entrar al FFA", vector3(-2222.057, 5117.024, 12.21094+1.5))
            if #(coords - ped2.pos) < DISTANCIA_INTERACCION then
                if not HasAlreadyEnteredMarker then
                    currentZone = ped2.name
                    HasAlreadyEnteredMarker = true
                end
                if HasAlreadyEnteredMarker then
                    
                    
                    if IsControlPressed(0, E_KEY) then
                        if dimensionCliente == 0 or dimensionCliente == 1 or dimensionCliente == 2 then
                            ExecuteCommand(ped2.comando)
                        end
                        
                    end
                end
            elseif ped2.onExit ~= nil and HasAlreadyEnteredMarker and ped2.name == currentZone then
                HasAlreadyEnteredMarker = false
                menu.close()
            end
        end
    end

    Citizen.CreateThread(function()
        while true do
            local s = 1000
            local coords = GetEntityCoords(PlayerPedId())
            for _, ped2 in pairs(Config.Peds) do 
                s = 2
                spawnMarker(ped2, coords)      
            end
            Citizen.Wait(s)
        end
    end)
end)

CreateThread(function()
    while true do
        local s = 1500
        for k, v in pairs(Config.Peds) do
            if #(GetEntityCoords(PlayerPedId()) - vector3(v.pos['x'], v.pos['y'], v.pos['z'])) < 6 then
                s = 1
                ShowFloatingHelpNotification(v.label, vector3(v.pos['x'], v.pos['y'], v.pos['z']+2))
                -- Draw3DText5( v.pos['x'], v.pos['y'], v.pos['z']+2.7  -1.400, v.label, 4, 0.1, 0.1, 0, 0, 0)
            end
        end
        Wait(s)
    end
end)

function ShowFloatingHelpNotification(message, coords)
    AddTextEntry('float', message)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('float')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

RegisterNetEvent("llevoABanda", function()
    local source = source
    if ESX.PlayerData.job.name == "police" then
        SetEntityCoords(PlayerPedId(), 641.7626, -2.30769, 82.77808 )
    else
        ESX.TriggerServerCallback('guille_gangs:server:getGangsData', function(gang, rank, data, boss, identifier)
            if gang then
                gangName = gang
                rankNum = rank
                gangData = data
                bossRank = boss
                identifierPly = identifier
                for k,vv in pairs(gangData.points) do
                    if vv.type == "Save Vehicles" then
                        --print(vector3(v.coords.x, v.coords.y, v.coords.z))
                        SetEntityCoords(PlayerPedId(), vector3(vv.coords.x, vv.coords.y, vv.coords.z))
                    end
                end
                -- --print("Banda: "..gangName)
            else
               -- exports['okokNotify']:Alert("Zon Development", "No estás en ningúna banda", 5000, 'info')
                ESX.ShowNotification("No estás en ningúna banda")
            end
        end)  
    end
end)

RegisterCommand("academy", function()
   
    TriggerEvent("startProgress", '5', '¡Estás siendo teletransportado al Academy!', 'rgb(12, 183, 234)')
    Citizen.Wait(7000)
    local source = source
    if ESX.PlayerData.job.name == "police" then
        TriggerServerEvent("setdimension")
        SetEntityCoords(PlayerPedId(), 641.7626, -2.30769, 82.77808 )
    else
        ESX.TriggerServerCallback('guille_gangs:server:getGangsData', function(gang, rank, data, boss, identifier)
                if gang then
                gangName = gang
                rankNum = rank
                gangData = data
                bossRank = boss
                identifierPly = identifier
                for k,vv in pairs(gangData.points) do
                    if vv.type == "Save Vehicles" then
                        --print(vector3(v.coords.x, v.coords.y, v.coords.z))
                        TriggerServerEvent("setdimension")
                        SetEntityCoords(PlayerPedId(), vector3(vv.coords.x, vv.coords.y, vv.coords.z))
                    end
                end
                -- --print("Banda: "..gangName)
            else
                --exports['okokNotify']:Alert("Zon Development", "No estás en ningúna banda", 5000, 'info')
                ESX.ShowNotification("No estás en ningúna banda")
            end
        end)  
    end
end)

RegisterCommand("armas", function()
    if dimensionCliente > 200 and dimensionCliente < 1000 then
        local playerPed = PlayerPedId()
        ExecuteCommand("attachs")
        ExecuteCommand("balas")
        GiveWeaponToPed(playerPed,GetHashKey("WEAPON_PISTOL_MK2"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_APPISTOL"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_COMBATPISTOL"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_SNSPISTOL"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_SMG"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_COMBATPDW"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_SMG_MK2"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_MACHINEPISTOL"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_MICROSMG"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_ASSAULTRIFLE"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_CARBINERIFLE"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_CARBINERIFLE_MK2"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),-1,true)
		GiveWeaponToPed(playerPed,GetHashKey("WEAPON_SPECIALCARBINE"),-1,true)
    else
        --exports['okokNotify']:Alert("Zon Developments", "No puedes usar este comando en este mundo.", 5000, 'info')
        ESX.ShowNotification("No puedes usar este comando en este mundo.")
    end
end)

-- RECOIL

local recoils = {
	-- [453432689] = 0.3, -- PISTOL
	-- [3219281620] = 0.0, -- PISTOL MK2
	-- [584646201] = 0.1, -- AP PISTOL
	-- [2578377531] = 0.6, -- PISTOL .50
	-- [324215364] = 0.2, -- MICRO SMG
	-- [4024951519] = 0.1, -- ASSAULT SMG
	-- [3220176749] = 0.2, -- ASSAULT RIFLE
	-- [2937143193] = 0.1, -- ADVANCED RIFLE
	-- [2634544996] = 0.1, -- MG
	-- [2144741730] = 0.1, -- COMBAT MG
	-- [3686625920] = 0.1, -- COMBAT MG MK2
	-- [487013001] = 0.9, -- PUMP SHOTGUN

	-- [961495388] = 0.230, -- ASSAULT RIFLE MK2
	-- [-2084633992] = 0.100, -- CARBINE RIFLE
	-- [-86904375] = 0.150, -- CARBINE RIFLE MK2
	-- [-1768145561] = 0.230, -- SPECIAL CARBINE MK2

	-- [-1075685676] = 0.0, -- PISTOL MK2
	-- [1593441988] = 0.150, -- COMBAT PISTOL
	-- [-1076751822] = 0.180, -- SNS PISTOL
	-- [-771403250] = 0.180, -- HEAVY PISTOL

	-- [1432025498] = 0.9, -- PUMP SHOTGUN MK2
	-- [2017895192] = 0.9, -- SAWNOFF SHOTGUN
	-- [3800352039] = 0.4, -- ASSAULT SHOTGUN
	-- [2640438543] = 0.2, -- BULLPUP SHOTGUN
	-- [911657153] = 0.1, -- STUN GUN
	-- [100416529] = 0.5, -- SNIPER RIFLE
	-- [205991906] = 0.7, -- HEAVY SNIPER
	-- [177293209] = 0.6, -- HEAVY SNIPER MK2
	-- [856002082] = 1.2, -- REMOTE SNIPER
	-- [2726580491] = 1.0, -- GRENADE LAUNCHER
	-- [1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	-- [2982836145] = 0.0, -- RPG
	-- [1752584910] = 0.0, -- STINGER
	-- [1119849093] = 0.01, -- MINIGUN
	-- [3218215474] = 0.2, -- SNS PISTOL
	-- [1627465347] = 0.1, -- GUSENBERG
	-- [3523564046] = 0.5, -- HEAVY PISTOL
	-- [2132975508] = 0.2, -- BULLPUP RIFLE

	-- [-619010992] = 0.0, -- MACHINE PISTOL
	-- [736523883] = 0.0, -- SMG
	-- [2024373456] = 0.0, -- SMG MK2
	-- [171789620] = 0.0, -- COMBAT PDW

	-- [-2066285827] = 0.15, -- BULLPUP RIFLE MK2
	-- [137902532] = 0.4, -- VINTAGE PISTOL
	-- [2828843422] = 0.7, -- MUSKET
	-- [984333226] = 0.2, -- HEAVY SHOTGUN
	-- [3342088282] = 0.3, -- MARKSMAN RIFLE
	-- [1785463520] = 0.25, -- MARKSMAN RIFLE MK2
	-- [1672152130] = 0, -- HOMING LAUNCHER
	-- [1198879012] = 0.9, -- FLARE GUN
	-- [3696079510] = 0.9, -- MARKSMAN PISTOL
	-- [1834241177] = 2.4, -- RAILGUN
	-- [3675956304] = 0.3, -- MACHINE PISTOL
	-- [3249783761] = 0.6, -- REVOLVER
	-- [-879347409] = 0.6, -- REVOLVER MK2
	-- [4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	-- [1649403952] = 0.3, -- COMPACT RIFLE
	-- [317205821] = 0.2, -- AUTO SHOTGUN
	-- [125959754] = 0.5, -- COMPACT LAUNCHER
	-- [3173288789] = 0.1, -- MINI SMG		
}
-- ------------------------------------------------------------------------------
-- -- ARMA DAR DANO POR OSSO
-- ------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) then
			local wep = GetSelectedPedWeapon(PlayerPedId())
			if recoils[wep] and recoils[wep] ~= 0 then
				Wait(0)
				p = GetGameplayCamRelativePitch()
				if not IsPedInAnyHeli(PlayerPedId()) then
					SetGameplayCamRelativePitch(p+recoils[wep], 1.2)
				end
			end
		end
	end
end)

  
--[[---------------------------------]]
-- ENERGETICO

-- local energetico = false
-- RegisterNetEvent('energeticos')
-- AddEventHandler('energeticos',function()
-- 	energetico = true
-- 	SetRunSprintMultiplierForPlayer(PlayerId(),1.2)
-- 	Wait(30000)
-- 	energetico = false
-- 	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
-- end)

-- RegisterKeyMapping('energetico', 'Usar energetico', 'keyboard', 'k')


-- RegisterCommand("energetico", function()
--     if dimensionCliente < 1999 then
--         TriggerEvent('energeticos',source,true)
--     end
-- end)

----------------------------------------------------------------------

---- FUNCIONES SA_TPS ---------

---------------------------------------------------------------------

--RegisterCommand("menusRopa", function()
  --  ESX.UI.Menu.Open(
    --    "default",
      --  GetCurrentResourceName(),
        --"general_menu",
        --{
        --    title = "Menu ROPA",
          --  align = "right",
            --elements = {
              --  {label = "Menu Aspecto", value = "aspecto"},
                --{label = "Menu Tatuajes", value = "tatuajes"},
          --  }
        --},
        --function(data, menu)
            
            
         --   if val == 'aspecto' then
         --       local xPlayer = PlayerPedId()
         --       TriggerEvent('esx_skin:openSaveableMenu', xPlayer)
        --    end

           -- if data.current.value == "tatuajes" then
           --     TriggerEvent("abrirTiendaTatus")
           -- end
        
     --   end,
    --    function(data, menu)
   --         menu.close()
   --     end
  --  )
--end)

-- local contador = 1

-- CreateThread(function()
--     while true do
--         ESX.TriggerServerCallback("getPlayersDimension", function(ke)
--            contador = ke
--         end)
--         Wait(5000)
--     end
-- end)

-- CreateThread(function ()

-- 	while true do
        
-- 		Citizen.Wait(0)			
        
--         local distancia = #(vector3(407.0313, -356.5093, 46.83619) - GetEntityCoords(PlayerPedId()))
--         local distancia2 = #(vector3(407.8069, -350.4452, 46.88153) - GetEntityCoords(PlayerPedId()))
--         local distanciaFFA = #(vector3(-167.3201, 1596.099, 7.171445) - GetEntityCoords(PlayerPedId()))
--         local distanciaFFA2 = #(vector3(407.2557, -357.668, 46.84929) - GetEntityCoords(PlayerPedId()))
--         local distanciaFFAGLOBAL = #(vector3(406.9194, -349.5111, 46.857) - GetEntityCoords(PlayerPedId()))
--         local distanciaFFAGLOBAL2 = #(vector3(397.2846, -345.5125, 46.85262) - GetEntityCoords(PlayerPedId()))
--         local distanciaHologramaDrift5 = #(vector3(407.158, -355.2148, 46.8231) - GetEntityCoords(PlayerPedId()))
--         local distanciaHologramaDrift = #(vector3(167.8213, -997.9844, 29.35124) - GetEntityCoords(PlayerPedId()))
--         local distanciaHologramaDriftMAP1 = #(vector3(12.8573, -7981.193, 161.2755) - GetEntityCoords(PlayerPedId()))
--         local distanciaHologramaDriftMAP2 = #(vector3(-3286.846, -4160.853, 1588.348) - GetEntityCoords(PlayerPedId()))
--         local distanciaHologramaDriftMAP3 = #(vector3(-2579.549, 4349.115, 103.8357) - GetEntityCoords(PlayerPedId()))

-- 		if distancia < 16.0 then
-- 			Draw3DText5( 407.0313, -356.5093, 46.83619+2.7  -1.400, "Menu Aspecto", 4, 0.1, 0.1, 0, 0, 0)
-- 		end
--         if distancia2 < 16.0 then
-- 			Draw3DText5( 407.8069, -350.4452, 46.88153+2.7  -1.400, "Menu Aspecto", 4, 0.1, 0.1, 0, 0, 0)
-- 		end
--         if distanciaFFA < 16.0 then
-- 			Draw3DText5( -167.3201, 1596.099, 7.171445+2.7  -1.400, "Menu TP's", 4, 0.1, 0.1, 0, 0, 0)
-- 		end

--         if distanciaFFA2 < 16.0 then
-- 			Draw3DText5( 407.2557, -357.668, 46.84929+2.7  -1.400, "Menu Practice", 4, 0.1, 0.1, 0, 0, 0)
-- 		end

--         if distanciaFFAGLOBAL < 16.0 then
--             ESX.ShowFloatingHelpNotification("MENU FFA", vector3(406.9194, -349.5111, 46.857+2.7))
-- 			-- Draw3DText5( 406.9194, -349.5111, 46.857+2.7  -1.400, "Menu FFA", 4, 0.1, 0.1, 0, 0, 0)
-- 		end

--         if distanciaFFAGLOBAL2 < 16.0 then
-- 			Draw3DText5( 397.2846, -345.5125, 46.85262+2.7  -1.400, "ACADEMY ", 4, 0.1, 0.1, 0, 0, 0)
-- 		end

--         -- if distanciaHologramaDrift5 < 16.0 then
--         --     Draw3DText5(  407.158, -355.2148, 46.8231+2.7  -1.400, "DRIFT", 4, 0.1, 0.1, 0, 0, 0)
           
--         -- end

--         -- if dimensionCliente == 4000 and distanciaHologramaDrift < 22 then
--         --     ESX.ShowFloatingHelpNotification("~y~Drift Mode Glaw~w~".."\n".."Presiona F6 para abrir el menu de vehiculos".."\n".. "Presiona SHIFT dentro de un coche para activar el modo drift".."\n".. "Presiona F5 para teletransportarte a los mapas.", vector3(167.8213, -997.9844, 29.35124+1))
--         -- end

--         -- if dimensionCliente == 4000 and distanciaHologramaDriftMAP1 < 22 then
--         --     ESX.ShowFloatingHelpNotification("~y~Drift Mapa Happogahara~w~".."\n".."Presiona F6 para abrir el menu de vehiculos".."\n".. "Presiona SHIFT dentro de un coche para activar el modo drift".."\n".. "Presiona F5 para teletransportarte a los mapas.", vector3(12.8573, -7981.193, 161.2755+1))
--         -- end

--         -- if dimensionCliente == 4000 and distanciaHologramaDriftMAP2 < 22 then
--         --     ESX.ShowFloatingHelpNotification("~y~Drift Mapa Transfagarasan~w~".."\n".."Presiona F6 para abrir el menu de vehiculos".."\n".. "Presiona SHIFT dentro de un coche para activar el modo drift".."\n".. "Presiona F5 para teletransportarte a los mapas.", vector3(-3286.846, -4160.853, 1588.348+1))
--         -- end

--         -- if dimensionCliente == 4000 and distanciaHologramaDriftMAP3 < 22 then
--         --     ESX.ShowFloatingHelpNotification("~y~Drift Mapa Okutama ~w~".."\n".."Presiona F6 para abrir el menu de vehiculos".."\n".. "Presiona SHIFT dentro de un coche para activar el modo drift".."\n".. "Presiona F5 para teletransportarte a los mapas.", vector3(-2579.549, 4349.115, 103.8357))
--         -- end

--         -- if distanciaDRIFT < 16.0 then
-- 		-- 	Draw3DText( 397.2846, -345.5125, 46.85262+0.7  -1.400, "ACADEMY", 4, 0.1, 0.1, 0, 0, 0)
-- 		-- end
        
        
-- 	end
-- end)

---------------------------------------------------------

---- FUNCIONES ------

---------------------------------------------------------


function Draw3DText5(x,y,z,textInput,fontId,scaleX,scaleY, r,g,b)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
   -- print(r,g,b)
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(r,g,b, 255)		-- You can change the text color here
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent("comprobardimension")
    end
end)

RegisterNetEvent("progresuwu1", function(source)
    TriggerEvent("startProgress", '5', '¡Estás siendo teletransportado al HUB!', 'rgb(12, 183, 234)')
end)

RegisterNetEvent("progresuwu2", function()
    TriggerEvent("startProgress", '5', '¡Estás siendo teletransportado al HUB!', 'rgb(12, 183, 234)')
end)

--------------------------------------------------------------------------------------------------------------
------------First off, many thanks to @anders for help with the majority of this script. ---------------------
------------Also shout out to @setro for helping understand pNotify better.              ---------------------
--------------------------------------------------------------------------------------------------------------
------------To configure: Add/replace your own coords in the sectiong directly below.    ---------------------
------------        Goto LINE 90 and change "50" to your desired SafeZone Radius.        ---------------------
------------        Goto LINE 130 to edit the Marker( Holographic circle.)               ---------------------
--------------------------------------------------------------------------------------------------------------
-- Place your own coords here!

CreateThread(function()
    while true do
        local s = 1
        if dimensionCliente == 0 or dimensionCliente == 1 or dimensionCliente == 2 then
            SetPedMoveRateOverride(PlayerPedId(), 1.6)
        else
            SetPedMoveRateOverride(PlayerPedId(), 1.0)
        end
        Wait(s)
    end
end)

local zones = {
	{ ['x'] = -856.9035, ['y'] = -422.6969, ['z'] = 36.6401},
}

local notifIn = false
local notifOut = false
local closestZone = 1


-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
----------------   Getting your distance from any one of the locations  --------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
---------   Setting of friendly fire on and off, disabling your weapons, and sending pNoty   -----------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= 50.0 then  ------------------------------------------------------------------------------ Here you can change the RADIUS of the Safe Zone. Remember, whatever you put here will DOUBLE because 
			if not notifIn then																			  -- it is a sphere. So 50 will actually result in a diameter of 100. I assume it is meters. No clue to be honest.
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				
				notifOut = true
				notifIn = false
			end
		end
		if notifIn then
		DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
		DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
      	DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
				
			end
			if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
				
			end
		end
		
	end
end)

local RACE_STATE_NONE = 0
local RACE_STATE_JOINED = 1
local RACE_STATE_RACING = 2
local RACE_STATE_RECORDING = 3
local RACE_CHECKPOINT_TYPE = 45
local RACE_CHECKPOINT_FINISH_TYPE = 9

local races = {}
local raceStatus = {
    state = RACE_STATE_NONE,
    index = 0,
    checkpoint = 0
}

local recordedCheckpoints = {}

RegisterCommand("carreras", function(source, args)
    if dimensionCliente > 3999 then

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'carreras', {
            title   = 'Carreras',
            align   = 'bottom-right',
            elements = {
                {label = ('Grabar carrera'), value = 'record'},
                {label = ('Guardar carrera'), value = 'save'},
                {label = ('Borrar carrera'), value = 'delete'},
                {label = ('Tus carreras'), value = 'list'},
                {label = ('Cargar carrera'), value = 'load'},
                {label = ('Empezar carrera'), value = 'start'},
                {label = ('Cancelar carrera'), value = 'cancel'}
            }
        }, function(data, menu)
            if data.current.value == 'record' then
                SetWaypointOff()
                cleanupRecording()
                raceStatus.state = RACE_STATE_RECORDING
            elseif data.current.value == 'save' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'setname',
                {
                    title = ('Nombre de la carrera'),
                }, function(data, menu)
                    local value = (data.value)
                    if value then
                        if #recordedCheckpoints > 0 then
                            TriggerServerEvent('StreetRaces:saveRace_sv', value, recordedCheckpoints)
                            ESX.ShowNotification('Se ha añadido la carrera: ' .. value)
                        else
                            ESX.ShowNotification('No hay puntos guardados')
                        end
                        menu.close()
                    end
                end, function(data, menu)
                    menu.close()
                end)

            elseif data.current.value == 'delete' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'setname',
                {
                    title = ('Nombre de la carrera'),
                }, function(data, menu)
                    local value = (data.value)
                    if value then
                        TriggerServerEvent('StreetRaces:deleteRace_sv', value)
                        ESX.ShowNotification('Se ha borrado la carrera: ' .. value)
                    else
                        ESX.ShowNotification('Pon un nombre')
                    end
                    menu.close()
                end, function(data, menu)
                    menu.close()
                end)

            elseif data.current.value == 'list' then
                TriggerServerEvent('StreetRaces:listRaces_sv')

            elseif data.current.value == 'load' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'setname',
                {
                    title = ('Nombre de la carrera'),
                }, function(data, menu)
                    local value = (data.value)
                    if value then
                        TriggerServerEvent('StreetRaces:loadRace_sv', value)
                        ESX.ShowNotification('Se ha cargado la carrera: ' .. value)
                    else
                        ESX.ShowNotification('Pon un nombre')
                    end
                    menu.close()
                end, function(data, menu)
                    menu.close()
                end)

            elseif data.current.value == 'start' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'setname',
                {
                    title = ('Dinero'),
                }, function(data, menu)
                    local value = tonumber(data.value)

                    if value then
                        local startCoords = GetEntityCoords(PlayerPedId())

                        if #recordedCheckpoints > 0 then
                            TriggerServerEvent('StreetRaces:createRace_sv', value, config_cl.joinDuration, startCoords, recordedCheckpoints)
                        elseif IsWaypointActive() then
                            local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                            local retval, nodeCoords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
                            table.insert(recordedCheckpoints, {blip = nil, coords = nodeCoords})
                            TriggerServerEvent('StreetRaces:createRace_sv', value, config_cl.joinDuration, startCoords, recordedCheckpoints)
                        end
                        raceStatus.state = RACE_STATE_NONE
                    end
                    menu.close()
                end, function(data, menu)
                    menu.close()
                end)

            elseif data.current.value == 'cancel' then
                TriggerServerEvent('StreetRaces:cancelRace_sv')

            end
        end, function(data, menu)
            menu.close()
        end)
    
    end
end)

RegisterNetEvent("StreetRaces:createRace_cl")
AddEventHandler("StreetRaces:createRace_cl", function(index, amount, startDelay, startCoords, checkpoints)
    local race = {
        amount = amount,
        started = false,
        startTime = GetGameTimer() + startDelay,
        startCoords = startCoords,
        checkpoints = checkpoints
    }
    races[index] = race
end)

RegisterNetEvent("StreetRaces:loadRace_cl")
AddEventHandler("StreetRaces:loadRace_cl", function(checkpoints)
    cleanupRecording()
    recordedCheckpoints = checkpoints
    raceStatus.state = RACE_STATE_RECORDING

    for index, checkpoint in pairs(recordedCheckpoints) do
        checkpoint.blip = AddBlipForCoord(checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z)
        SetBlipColour(checkpoint.blip, config_cl.checkpointBlipColor)
        SetBlipAsShortRange(checkpoint.blip, true)
        ShowNumberOnBlip(checkpoint.blip, index)
    end

    SetWaypointOff()
    SetBlipRoute(checkpoints[1].blip, true)
    SetBlipRouteColour(checkpoints[1].blip, config_cl.checkpointBlipColor)
end)


RegisterNetEvent("StreetRaces:joinedRace_cl")
AddEventHandler("StreetRaces:joinedRace_cl", function(index)
    raceStatus.index = index
    raceStatus.state = RACE_STATE_JOINED

    local race = races[index]
    local checkpoints = race.checkpoints
    for index, checkpoint in pairs(checkpoints) do
        checkpoint.blip = AddBlipForCoord(checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z)
        SetBlipColour(checkpoint.blip, config_cl.checkpointBlipColor)
        SetBlipAsShortRange(checkpoint.blip, true)
        ShowNumberOnBlip(checkpoint.blip, index)
    end
    SetWaypointOff()
    SetBlipRoute(checkpoints[1].blip, true)
    SetBlipRouteColour(checkpoints[1].blip, config_cl.checkpointBlipColor)
end)

RegisterNetEvent("StreetRaces:removeRace_cl")
AddEventHandler("StreetRaces:removeRace_cl", function(index)
    if index == raceStatus.index then
        cleanupRace()

        raceStatus.index = 0
        raceStatus.checkpoint = 0
        raceStatus.state = RACE_STATE_NONE
    elseif index < raceStatus.index then
        raceStatus.index = raceStatus.index - 1
    end

    table.remove(races, index)
end)

Citizen.CreateThread(function()
    local waitcar = 1500
    while true do
        Citizen.Wait(waitcar)
        waitcar = 1500

        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            waitcar = 1000
            local position = GetEntityCoords(player)
            local vehicle = GetVehiclePedIsIn(player, false)

            if raceStatus.state == RACE_STATE_RACING then
                waitcar = 5
                local race = races[raceStatus.index]
                if raceStatus.checkpoint == 0 then
                    raceStatus.checkpoint = 1
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]

                    if config_cl.checkpointRadius > 0 then
                        local checkpointType = raceStatus.checkpoint < #race.checkpoints and RACE_CHECKPOINT_TYPE or RACE_CHECKPOINT_FINISH_TYPE
                        checkpoint.checkpoint = CreateCheckpoint(checkpointType, checkpoint.coords.x,  checkpoint.coords.y, checkpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 255, 255, 0, 127, 0)
                        SetCheckpointCylinderHeight(checkpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
                    end

                    SetBlipRoute(checkpoint.blip, true)
                    SetBlipRouteColour(checkpoint.blip, config_cl.checkpointBlipColor)
                else
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    if GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false) < config_cl.checkpointProximity then
                        RemoveBlip(checkpoint.blip)
                        if config_cl.checkpointRadius > 0 then
                            DeleteCheckpoint(checkpoint.checkpoint)
                        end
                        
                        if raceStatus.checkpoint == #(race.checkpoints) then
                            PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")

                            local currentTime = (GetGameTimer() - race.startTime)
                            TriggerServerEvent('StreetRaces:finishedRace_sv', raceStatus.index, currentTime)
                            
                            raceStatus.index = 0
                            raceStatus.state = RACE_STATE_NONE
                        else
                            PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")

                            raceStatus.checkpoint = raceStatus.checkpoint + 1
                            local nextCheckpoint = race.checkpoints[raceStatus.checkpoint]

                            if config_cl.checkpointRadius > 0 then
                                local checkpointType = raceStatus.checkpoint < #race.checkpoints and RACE_CHECKPOINT_TYPE or RACE_CHECKPOINT_FINISH_TYPE
                                nextCheckpoint.checkpoint = CreateCheckpoint(checkpointType, nextCheckpoint.coords.x,  nextCheckpoint.coords.y, nextCheckpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 255, 255, 0, 127, 0)
                                SetCheckpointCylinderHeight(nextCheckpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
                            end

                            SetBlipRoute(nextCheckpoint.blip, true)
                            SetBlipRouteColour(nextCheckpoint.blip, config_cl.checkpointBlipColor)
                        end
                    end
                end

                if config_cl.hudEnabled then
                    local timeSeconds = (GetGameTimer() - race.startTime)/1000.0
                    local timeMinutes = math.floor(timeSeconds/60.0)
                    timeSeconds = timeSeconds - 60.0*timeMinutes
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y, ("~y~%02d:%06.3f"):format(timeMinutes, timeSeconds), 0.7)
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    local checkpointDist = math.floor(GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false))
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y + 0.04, ("~y~Checkpoint %d/%d (%dm)"):format(raceStatus.checkpoint, #race.checkpoints, checkpointDist), 0.5)
                end

            elseif raceStatus.state == RACE_STATE_JOINED then
                waitcar = 5
                local race = races[raceStatus.index]
                local currentTime = GetGameTimer()
                local count = race.startTime - currentTime
                if count <= 0 then
                    raceStatus.state = RACE_STATE_RACING
                    raceStatus.checkpoint = 0
                    FreezeEntityPosition(vehicle, false)
                elseif count <= config_cl.freezeDuration then
                    Draw2DText(0.5, 0.4, ("~y~%d"):format(math.ceil(count/1000.0)), 3.0)
                    FreezeEntityPosition(vehicle, true)
                else
                    local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 1)
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Carrera por ~g~$%d~w~ empieza en ~y~%d~w~s"):format(race.amount, math.ceil(count/1000.0)))
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "Dentro de la carrera")
                end
            else
                waitcar = 5
                for index, race in pairs(races) do
                    local currentTime = GetGameTimer()
                    local proximity = GetDistanceBetweenCoords(position.x, position.y, position.z, race.startCoords.x, race.startCoords.y, race.startCoords.z, true)

                    if proximity < config_cl.joinProximity and currentTime < race.startTime then
                        local count = math.ceil((race.startTime - currentTime)/1000.0)
                        local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 0)
                        Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Carrera por ~g~$%d~w~ empieza en ~y~%d~w~s"):format(race.amount, count))
                        Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "Presiona [~g~E~w~] para participar")

                        if IsControlJustReleased(1, config_cl.joinKeybind) then
                            TriggerServerEvent('StreetRaces:joinRace_sv', index)
                            break
                        end
                    end
                end
            end  
        end
    end
end)

Citizen.CreateThread(function()
    local waitcheck = 500
    while true do
        Citizen.Wait(waitcheck)
        waitcheck = 500
        
        if raceStatus.state == RACE_STATE_RECORDING then
            waitcheck = 100
            if IsWaypointActive() then
                local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                local retval, coords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
                SetWaypointOff()

                for index, checkpoint in pairs(recordedCheckpoints) do
                    if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z, false) < 1.0 then
                        RemoveBlip(checkpoint.blip)
                        table.remove(recordedCheckpoints, index)
                        coords = nil

                        for i = index, #recordedCheckpoints do
                            ShowNumberOnBlip(recordedCheckpoints[i].blip, i)
                        end
                        break
                    end
                end

                if (coords ~= nil) then
                    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                    SetBlipColour(blip, config_cl.checkpointBlipColor)
                    SetBlipAsShortRange(blip, true)
                    ShowNumberOnBlip(blip, #recordedCheckpoints+1)

                    table.insert(recordedCheckpoints, {blip = blip, coords = coords})
                end
            end
        else
            cleanupRecording()
        end
    end
end)


function cleanupRace()
    if raceStatus.index ~= 0 then

        local race = races[raceStatus.index]
        local checkpoints = race.checkpoints
        for _, checkpoint in pairs(checkpoints) do
            if checkpoint.blip then
                RemoveBlip(checkpoint.blip)
            end
            if checkpoint.checkpoint then
                DeleteCheckpoint(checkpoint.checkpoint)
            end
        end

        if raceStatus.state == RACE_STATE_RACING then
            local lastCheckpoint = checkpoints[#checkpoints]
            SetNewWaypoint(lastCheckpoint.coords.x, lastCheckpoint.coords.y)
        end

        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        FreezeEntityPosition(vehicle, false)
    end
end

function cleanupRecording()
    for _, checkpoint in pairs(recordedCheckpoints) do
        RemoveBlip(checkpoint.blip)
        checkpoint.blip = nil
    end
    recordedCheckpoints = {}
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8*(1/dist)*(1/GetGameplayCamFov())*100

        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function Draw3DText5(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8*(1/dist)*(1/GetGameplayCamFov())*100

        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end


  ---------------------

  return (function(LD,QW,wW,VD,lD,PD,TW,oD,aW,nD,qD,hD,vW,vD,ND,iW,fD,dD,zD,QD,DD,ID,MD,uD,wD,GH,BD,fW,TD,XW,tW,SD,YD,pW,rD,jD,BH,eD,VW,kD,HD,CD,UW,kW,SW,ZW,sH,gW,ED,hH,RD,IW,OD,tD,XD,dH,LW,eW,sD,ZD,GD,pD,JH,AD,iD,mH,aD,WD,mD,NW,bD,cD,qH,UD,KD,gD,RW,FH,FD,KH,JD,yW,YW,xD,yD,...)local WW,rW,bW,oW,DW,cW,EW,zW,jW,MW,HW,AW=4,QW,QW,QW,QW,sH(0,nil,nil,{},AW,15,600.3121538130436,QW,MW,{},jW,QW,bW),QW,QW,QW,sH(0,nil,nil,637.7287559504622,444.84673040856427,{},{},QW,86.68427178763426,EW,cW,83),sH(0,nil,nil,47,148.43896807741777,{},bW,QW,45),(sH(1,nil,nil,HW,41,634.1369649940367,bW,{},QW,rW,cW,AW,{}));repeat if(not(sH(2,WW,4)))then if(not(sH(2,WW,7)))then if(not(sH(2,WW,8)))then if(not(sH(3,WW,9)))then cW=2089763055;WW=9;else EW=291784118;WW=5;end;else do bW=1219031436;end;WW=6;end;else do if(not(sH(2,WW,5)))then do if(WW~=6)then do MW=1723006873;end;do WW=1;end;else oW=254212075;do WW=2;end;end;end;else zW=756192565;do WW=0;end;end;end;end;else if(not(sH(2,WW,1)))then if(WW<=2)then DW=11659964;WW=10;else do if(not(sH(3,WW,3)))then rW=322485329;do WW=8;end;else AW=900418526;WW=11;end;end;end;else do if(WW~=0)then HW=1388205431;WW=3;else do jW=1281228590;end;WW=7;end;end;end;end;until(sH(4,WW,10));local uW,nW=710134175,48783651;WW=3;local CW,OW,PW,xW,lW,sW,KW,qW,JW,mW,GW,FW=sH(5,nil,nil,nW,386.6266868738308,QW,636.519638368435,MW,WW,WW),QW,QW,QW,QW,QW,sH(5,nil,nil,{},759.4377306490433,QW,CW,130.7221884422087,MW),sH(0,nil,nil,WW,45.878594803861446,20,711.7734090268452,QW,FW),sH(6,nil,nil,GW,QW,0,354.10451620624787,EW,91,91),QW,sH(7,nil,nil,348.614420907862,WW,WW,WW,{},oW,787.4317733217767,QW,OW),QW;do while(WW<=11)do if(WW<=5)then if(not(sH(2,WW,2)))then do if(sH(2,WW,3))then CW=770533788;WW=8;else if(not(sH(3,WW,4)))then GW=1950017117;WW=9;else qW=1205422175;WW=0;end;end;end;else if(WW<=0)then do JW=1030844016;end;do WW=2;end;else do if(WW~=1)then mW=213003484;WW=5;else do sW=1783771661;end;do WW=11;end;end;end;end;end;else if(not(sH(2,WW,8)))then if(WW<=9)then FW=841359774;WW=12;else if(WW~=10)then KW=1938578315;WW=4;else do lW=144829035;end;WW=1;end;end;else if(sH(2,WW,6))then do xW=876873419;end;WW=10;else if(sH(3,WW,7))then do PW=1789595831;end;WW=6;else OW=99259567;WW=7;end;end;end;end;end;end;local J=IW;local K=iW[eW];local d,h=wW,(LW);local l=iW[gW];local x,P,O,C,n,u,A,H=sH(0,nil,nil,35,J,PW,WW,iW,{},WW,QW)[vW],iW[XW],tW,pW,kW,aW,NW,VW or ZW[SW];local B=fW;local s=(iW[yW]);local F,G,m=RW,dD,(hD);local z=(YW and sH(8,nil,nil,292.386428894835,NW,WW,{},{},WW,YW,xW,{})()or BD);local E,c={},(1);local D=(QW);WW=6;local o,b,r,W,Q,I,i=sH(5,nil,nil,{},72,QW,fW,83,{}),sH(9,nil,nil,mW,28,D,{},LW,157.0001962918091,29,wW,QW),QW,sH(10,nil,nil,KW,pW,n,QW,IW,955.6771501312044),QW,QW,QW;repeat if(not(WW<=3))then if(not(WW<=5))then do if(not(sH(3,WW,6)))then WW=2;else do WW=1;end;end;end;else do if(not(sH(3,WW,4)))then I=2147483648;WW=4;else do i=sD;end;WW=8;end;end;end;else if(not(WW<=1))then if(not(sH(3,WW,2)))then Q=function()local TH,tH,DH,yH=QW,QW,QW,QW;for nH=0,2 do if(not(nH<=0))then if(nH~=1)then return yH*16777216+DH*KD+tH*256+TH;else c=c+4;end;else TH,tH,DH,yH=K(b,c,c+3);end;end;end;WW=5;else b=sH(8,nil,nil,tW,WW,{},SW,i,{},x,{})(UW(b,5),mD,function(tc)if(K(tc,2)~=72)then local d3=0;local F3=QW;while(d3~=2)do if(d3~=0)then if(not(r))then return F3;else local pt,nt=0,QW;while(FD)do if(not(pt<=0))then if(pt~=1)then do r=QW;end;pt=1;else return nt;end;else do nt=l(F3,r);end;pt=2;end;end;end;d3=2;else F3=s(B(tc,16));d3=1;end;end;else local xq,gq,oq=549883623,554863976,JD;r=B(UW(tc,(pW({},{__div=function(a9,L9)local T9=1;while(FD)do if(not(T9<=1))then if(T9~=2)then xq=xq-779;T9=2;else do return (((L9+oq)+gq)+xq);end;end;else if(T9~=0)then oq=oq-741;do T9=0;end;else gq=gq-412;do T9=3;end;end;end;end;end})/-1793740465),1));return qD;end;end);WW=0;end;else do if(WW~=0)then b=GD;WW=7;else W=function()local xO=(QW);local TO=(2);while(FD)do if(not(TO<=0))then do if(TO==1)then return xO;else do xO=K(b,c,c);end;TO=0;end;end;else c=c+1;TO=1;end;end;end;WW=3;end;end;end;end;until(sH(11,nil,nil,WW,14,486.51384877090214,O,WW,xW)>7);local e=sH(12,2,52);local Y=({[0]=(sH(1,nil,nil,88,15,43,374.43293848596386,uW,pW,K,{},70)({},{[lD]=function(hi,Li)local Xi=(2);repeat if(Xi<=0)then GW=GW-994;Xi=1;else if(Xi==1)then return ((Li+FW)+GW);else FW=FW-198;Xi=0;end;end;until(xD);end})%-2791375698)});do WW=0;end;local w,L,T=QW,sH(0,nil,nil,WW,pW,44,i,QW,RW,88,F,w,504.578091865867),QW;while(FD)do if(not(WW<=1))then if(WW~=2)then L=function()local sf,xf=QW,(QW);local tf=2;repeat if(tf<=0)then do if(not(xf>=I))then else do xf=xf-i;end;end;end;tf=1;else if(tf~=1)then sf,xf=Q(),Q();do tf=0;end;else return xf*i+sf;end;end;until(xD);end;WW=2;else T=function()local R5,v5,X5=1596053463,PD,OD;local Q5=Q();local l5=Q();local k5=5;local d5,i5,Y5,t5=QW,QW,QW,(QW);do while(FD)do if(not(k5<=2))then do if(not(k5<=4))then if(k5==5)then if(Q5==0 and l5==0)then return 0;end;do k5=2;end;else Y5=w(0,20,l5)*i+Q5;do k5=0;end;end;else do if(k5==3)then i5=w(20,11,l5);k5=6;else return d5*((pW({},{__concat=function(fr,Ur)do for HB=0,1 do do if(HB~=0)then do return (Ur-R5);end;else R5=R5+750;end;end;end;end;end})..1596054215)^(i5-1023))*(Y5/e+t5);end;end;end;end;else if(not(k5<=0))then do if(k5==1)then if(i5==0)then if(Y5~=0)then local rf=(0);while(FD)do if(rf~=0)then t5=0;break;else i5=(pW({},{[CD]=function(Tq,Wq)do return Wq;end;end})..1);do rf=1;end;end;end;else return d5*0;end;elseif(i5~=2047)then else if(Y5~=0)then return d5*(1/0);else return d5*(0/0);end;end;k5=4;else d5=(-(pW({},{[nD]=function(wC,EC)local JC=(1);repeat if(not(JC<=0))then do if(JC~=1)then return ((EC+X5)+v5);else do X5=X5-822;end;JC=0;end;end;else v5=v5-142;do JC=2;end;end;until(xD);end})+-2924663263))^w(31,1,l5);k5=3;end;end;else t5=1;k5=1;end;end;end;end;end;break;end;else if(WW~=0)then do w=function(zr,cr,Ur)local vr,wr=QW,(QW);local er=0;while(FD)do do if(er~=0)then do wr=(Ur/Y[zr])%Y[cr];end;break;else vr=107421510;er=1;end;end;end;do wr=wr-wr%(pW({},{__mul=function(tn,Rn)vr=vr-575;return (Rn+vr);end})*-107420934);end;return wr;end;end;WW=3;else do local p7=(4);local h7,i7,Y7,m7=sH(1,nil,nil,56,rW,W,{},VW,QW,mD,Y7),sH(6,nil,nil,WW,QW,5,EW,118.47287192241338,WW,285.5149184836009),QW,QW;do while(sH(6,nil,nil,{},FD,lW,AW,573.6114252756444,MW,WW,18,zW,{}))do if(not(sH(2,p7,1)))then if(not(sH(2,p7,2)))then if(p7~=3)then h7=712350184;p7=2;else Y7=661341214;p7=0;end;else i7=1197990527;p7=3;end;else if(p7~=0)then do for W8=1,(pW({},{__div=function(Fv,Kv)do Y7=Y7-729;end;local sv=1;while(FD)do if(not(sv<=0))then if(sv~=1)then do return (((Kv+Y7)+i7)+h7);end;else i7=i7-665;do sv=0;end;end;else do h7=h7-525;end;sv=2;end;end;end})/-2571679975) do (Y)[W8]=sH(11,nil,nil,m7,dD,WW,WW,{},661.2263770508715,d,RW);do m7=m7*2;end;end;end;break;else do m7=2;end;p7=1;end;end;end;end;end;WW=1;end;end;end;local g=({[0]={[0]=0,1,2,3,4,5,6,7,8,9,10,(pW({},{[nD]=function(Jc,mc)local bc=(2);while(FD)do do if(bc<=0)then mW=mW-860;bc=1;else if(bc~=1)then FW=FW-746;do bc=0;end;else return ((mc+FW)+mW);end;end;end;end;end})+-1054361443),12,13,14,15},{[0]=1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14},{[0]=(sH(12,sH(0,nil,nil,sW,WW,l,{},pW,WW)({},{__pow=function(Rj,Pj)for oE=0,3 do if(not(oE<=1))then if(oE~=2)then return (((Pj+FW)-mW)-JW);else JW=JW+36;end;else if(oE~=0)then mW=mW+977;else FW=FW-502;end;end;end;end}),402489327)),3,(sH(13,sH(10,nil,nil,WW,WW,d,pW,FW,WW,WW,811.7461270345419,Y7,WW)({},{[uD]=function(wI,II)GW=GW+997;return (II-GW);end}),1950017120)),1,(pW({},{__mul=function(kc,yc)for SV=0,1 do if(SV~=0)then return (yc+GW);else GW=GW-738;end;end;end})*-1950016376),(sH(14,sH(5,nil,nil,86,dD,pW,623.9873756770974,858.4199501331085,tW,d)({},{__mul=function(Pu,Hu)qW=qW+153;FW=FW-200;return ((Hu-qW)+FW);end}),364064207)),(pW({},{__add=function(GP,RP)local JP=(2);while(FD)do if(not(JP<=0))then if(JP~=1)then KW=KW+563;JP=0;else do return ((RP-KW)-sW);end;end;else sW=sW+955;do JP=1;end;end;end;end})+3722351498),5,10,11,8,9,(sH(15,sH(11,nil,nil,pW,WW,874.7412321298767,lD,10,678.2403144990735)({},{__mod=function(s4,w4)local m4=(1);while(FD)do if(m4~=0)then GW=GW-250;do m4=0;end;else return (w4+GW);end;end;end}),-1950016118)),15,12,13},{[0]=3,2,1,0,7,6,5,(sH(15,pW({},{[lD]=function(Ek,mk)lW=lW+340;do xW=xW-520;end;local ak=0;while(FD)do if(ak~=0)then return (((mk-lW)+xW)-PW);else do PW=PW+AD;end;ak=1;end;end;end}),1057553281)),11,10,9,8,(sH(13,sH(6,nil,nil,CW,pW,W,257.40675970612267,Q,WW,e,u)({},{[uD]=function(aj,Wj)qW=qW-787;OW=OW-769;do return ((Wj+qW)+OW);end;end}),-1304680324)),14,13,12},{[0]=(sH(14,sH(11,nil,nil,pW,62,{},{},13,974.2546289204547,C,wW,{},{})({},{__mul=function(AU,SU)for vo=0,3 do if(not(vo<=1))then if(vo~=2)then do qW=qW-62;end;else do OW=OW+704;end;end;else if(vo~=0)then CW=CW+658;else GW=GW-786;end;end;end;do return ((((SU+GW)-CW)-OW)+qW);end;end}),-2285642873)),(pW({},{__mul=function(Xy,yy)local Ey=1;do while(FD)do if(not(Ey<=0))then do if(Ey==1)then nW=nW-749;Ey=0;else return ((yy+nW)+GW);end;end;else GW=GW-388;Ey=2;end;end;end;end})*-1998797855),(sH(1,nil,nil,L,37,ZW,856.7086424405192,WW,pW)({},{__concat=function(VC,mC)for Xd=0,2 do if(not(Xd<=0))then if(Xd==1)then KW=KW+465;else return ((mC+nW)-KW);end;else nW=nW-566;end;end;end})..1889797013),7,0,1,2,(sH(14,sH(10,nil,nil,341.6294750520029,sW,84,pW,68,{})({},{[HD]=function(Ip,up)local hp=(0);while(FD)do if(hp~=0)then return (up+mW);else do mW=mW-770;end;do hp=1;end;end;end;end}),-213002828)),12,13,14,15,8,9,10,11},{[0]=5,(sH(6,nil,nil,427.4816333718887,pW,rW,u,D,WW)({},{__pow=function(mE,rE)nW=nW-532;do return (rE+nW);end;end})^-48781800),7,6,1,(pW({},{__mul=function(PH,TH)return TH;end})*0),3,2,13,12,15,14,9,8,11,10},{[0]=6,(sH(0,nil,nil,89,31,W,610.620251238841,pW,900.6275292369525,{},{},C)({},{[MD]=function(BU,DU)return DU;end})^7),4,(sH(14,sH(1,nil,nil,A,L,34,sW,C,pW)({},{[HD]=function(he,Fe)local me=2;while(FD)do if(not(me<=1))then if(not(me<=2))then do if(me==3)then do GW=GW+921;end;me=1;else return ((((Fe-uW)-qW)-GW)+xW);end;end;else uW=uW+587;me=0;end;else if(me~=0)then xW=xW-43;me=4;else qW=qW+jD;me=3;end;end;end;end}),2988700011)),2,(pW({},{__pow=function(XK,aK)do return aK;end;end})^3),0,1,14,15,(pW({},{__mod=function(uS,FS)uW=uW+43;AW=AW+23;local vS=(1);while(FD)do if(vS~=0)then HW=HW+383;vS=0;else return (((FS-uW)-AW)-HW);end;end;end})%2998759180),(sH(16,pW({},{__add=function(Iq,kq)local hq=(0);repeat if(hq<=1)then if(hq~=0)then do return (((kq+mW)-MW)+AW);end;else mW=mW-632;hq=2;end;else if(hq~=2)then AW=AW-zD;hq=1;else MW=MW+521;hq=3;end;end;until(xD);end}),609587219)),(sH(7,nil,nil,GD,s,175.80016381208634,WW,476.1621610377624,WW,KW,pW)({},{__concat=function(Ut,Bt)jW=jW-6;for Hl=0,3 do if(Hl<=1)then if(Hl==0)then do OW=OW-944;end;else zW=zW-772;end;else if(Hl~=2)then return ((((Bt+jW)+OW)+zW)+lW);else lW=lW-38;end;end;end;end})..-2281508262),11,(sH(17,sH(6,nil,nil,HD,pW,nD,344.37138453209917,748.1256457757271,79,K,61,WW,{})({},{__sub=function(Fi,ji)return ji;end}),8)),9},{[(sH(1,nil,nil,9,AW,{},WW,WW,pW,m7,16,WW)({},{__mul=function(t0,h0)do for Ja=0,3 do if(not(Ja<=1))then if(Ja~=2)then return (((h0-EW)-AW)+cW);else do cW=cW-148;end;end;else if(Ja~=0)then do AW=AW+135;end;else EW=EW+ED;end;end;end;end;end})*-897559816)]=7,6,5,4,(sH(13,sH(8,nil,nil,WW,67,{},{},H,WW,pW)({},{[sH(11,nil,nil,uD,W,n,906.5001721078895,{},19,i7,BD,WW)]=function(W7,g7)do return g7;end;end}),3)),2,1,0,15,14,13,(sH(18,pW({},{[CD]=function(Ax,zx)do HW=HW-312;end;OW=OW+424;PW=PW+426;return (((zx+HW)-OW)-PW);end}),500650719)),11,10,9,8},{[(sH(13,sH(10,nil,nil,340.9952724748242,785.7254588167715,{},pW,oW,80.2113110078412,59)({},{__div=function(q4,z4)return z4;end}),0))]=(sH(13,pW({},{[uD]=function(Ua,za)local Za=1;while(FD)do if(Za~=0)then DW=DW-216;Za=0;else return (za+DW);end;end;end}),-11659740)),(pW({},{[cD]=function(Wr,Jr)local sr=(2);while(FD)do if(not(sr<=1))then if(sr~=2)then return (((Jr-JW)+oW)-bW);else JW=JW+oD;sr=0;end;else if(sr~=0)then bW=bW+89;do sr=3;end;else do oW=oW-DD;end;sr=1;end;end;end;end})-1995664795),10,11,12,13,14,15,0,1,2,3,(pW({},{[cD]=function(kP,JP)local XP=1;repeat if(XP~=0)then do sW=sW-bD;end;XP=0;else return (JP+sW);end;until(xD);end})- -1783772328),5,6,7},{[(sH(1,nil,nil,1,325.92729794550394,mW,{},489.92741945173253,pW,89)({},{__concat=function(st,Qt)EW=EW+913;return (Qt-EW);end})..291785880)]=9,8,11,10,13,12,15,14,1,0,3,2,5,4,7,6},{[0]=10,11,8,9,14,15,12,13,(sH(19,nil,nil,295.1679540799128,{},CW,806.3956869734316,99,BD,814.0833556147359,WW,B,pW)({},{[nD]=function(Za,Wa)for bJ=0,1 do if(bJ~=0)then do rW=rW-387;end;else do mW=mW-185;end;end;end;local Ea=(0);while(Ea<2)do if(Ea~=0)then GW=GW-804;Ea=2;else do HW=HW-776;end;Ea=1;end;end;return ((((Wa+mW)+rW)+HW)+GW);end})+-3873706755),(sH(12,pW({},{[MD]=function(my,Cy)mW=mW-884;do oW=oW+999;end;return ((Cy+mW)-oW);end}),41211500)),0,1,6,(sH(18,pW({},{[CD]=function(c5,q5)do lW=lW+168;end;KW=KW+908;cW=cW+256;do return (((q5-lW)-KW)-cW);end;end}),4173172926)),4,(sH(6,nil,nil,8,pW,87,WW,425.347135324039,WW)({},{__mod=function(yq,Uq)for c7=0,2 do if(not(c7<=0))then if(c7~=1)then bW=bW+793;else cW=cW+253;end;else PW=PW-290;end;end;return (((Uq+PW)-cW)-bW);end})%1519198802)},{[0]=11,10,(sH(10,nil,nil,175.46600333422046,{},WW,pW,669.7580413941497,p7,GD,WW,D,304.25884101942296)({},{__mod=function(DF,zF)KW=KW+41;return (zF-KW);end})%1938580301),8,15,14,(sH(13,pW({},{[sH(6,nil,nil,173.6282870161571,uD,{},98,84,165.62448817513413,{},WW)]=function(YG,QG)return QG;end}),13)),12,3,(sH(12,pW({},{__pow=function(kd,Bd)local ld=(0);while(FD)do if(ld~=0)then do return (Bd+mW);end;else do mW=mW-rD;end;ld=1;end;end;end}),-213000135)),1,0,7,6,5,(pW({},{__div=function(j6,s6)return s6;end})/4)},{[0]=12,(sH(14,pW({},{[HD]=function(f9,G9)nW=nW+337;EW=EW-331;FW=FW-153;cW=cW-WD;return ((((G9-nW)+EW)+FW)+cW);end}),-3174124511)),14,15,8,9,(sH(0,nil,nil,WW,T,PW,{},pW,73,445.5838373757232,{})({},{[sH(1,nil,nil,630.3154195600137,IW,{},l,24,nD,884.136830708947,13)]=function(MC,fC)local ZC=(1);while(FD)do if(not(ZC<=0))then if(ZC~=1)then do return ((fC-xW)+DW);end;else xW=xW+458;do ZC=0;end;end;else DW=DW-371;ZC=2;end;end;end})+865213947),11,4,5,6,7,0,1,(sH(15,sH(0,nil,nil,{},9,41,fW,pW,DW,{},45)({},{__mod=function(ir,Ir)KW=KW-779;do return (Ir+KW);end;end}),-1938579511)),3},{[0]=13,12,15,14,(sH(12,pW({},{__pow=function(Go,Qo)local Wo=1;while(FD)do do if(Wo~=0)then HW=HW+454;Wo=0;else do return (Qo-HW);end;end;end;end;end}),1388205189)),8,11,10,5,(sH(17,pW({},{__sub=function(AU,NU)local LU=(3);while(FD)do if(not(LU<=1))then if(LU<=2)then uW=uW+210;LU=0;else if(LU~=3)then return ((((NU-OW)-rW)-uW)+jW);else OW=OW+63;LU=1;end;end;else if(LU~=0)then rW=rW+796;LU=2;else jW=jW-90;LU=4;end;end;end;end}),-149348692)),7,6,1,0,3,(sH(18,pW({},{__concat=function(K9,M9)do return M9;end;end}),2))},{[(sH(1,nil,nil,{},qW,WW,{},{},pW)({},{[sH(11,nil,nil,lD,90,n,703.047986483369,98,H)]=function(Lm,Om)bW=bW-12;return (Om+bW);end})%-1219032306)]=14,15,12,13,10,11,(pW({},{[HD]=function(xK,zK)local aK=1;do while(FD)do if(not(aK<=0))then if(aK~=1)then return ((zK-GW)-bW);else do GW=GW+661;end;aK=0;end;else do bW=bW+QD;end;aK=2;end;end;end;end})*3169048387),9,6,7,(sH(1,nil,nil,WW,622.2286506855557,79,AW,74,pW)({},{[sH(0,nil,nil,8,{},226.3197736513276,754.7915104123824,HD,D,39,{},W8)]=function(CM,XM)cW=cW+753;local tM=(1);while(FD)do if(tM~=0)then do mW=mW-469;end;tM=0;else return ((XM-cW)+mW);end;end;end})*1876764230),5,2,3,0,1},{[0]=15,14,13,12,11,10,(sH(17,pW({},{__sub=function(Ra,Ha)for qx=0,3 do do if(not(qx<=1))then do if(qx~=2)then return (((Ha-qW)-zW)+uW);else uW=uW-516;end;end;else if(qx~=0)then zW=zW+182;else qW=qW+416;end;end;end;end;end}),ID)),8,7,6,5,4,3,2,1,(pW({},{[sH(11,nil,nil,lD,419.13614214916,29,WW,43,74,232.09973426780417,cW)]=function(KM,PM)return PM;end})%0)}});local v=(iD or eD);local X=(v and v[YD]or function(cX,zX)local XX,VX,QX=2,QW,(QW);while(FD)do if(XX<=2)then if(XX<=0)then QX=0;XX=1;else do if(XX==1)then while(cX>0 and zX>0)do local DP,bP=QW,(QW);for tq=0,5 do if(not(tq<=2))then if(tq<=3)then cX=(cX-DP)/16;else if(tq==4)then zX=(zX-bP)/16;else do VX=VX*16;end;end;end;else if(not(tq<=0))then if(tq~=1)then QX=QX+g[DP][bP]*VX;else bP=zX%16;end;else DP=cX%16;end;end;end;end;XX=3;else cX=cX%i;XX=4;end;end;end;else do if(not(XX<=3))then if(XX~=4)then VX=1;do XX=0;end;else zX=zX%i;XX=5;end;else return QX+cX*VX+zX*VX;end;end;end;end;end);local t=v and v[wD]or function(WA,vA)for jH=0,2 do do if(not(jH<=0))then if(jH~=1)then return ((WA+vA)-X(WA,vA))/2;else vA=vA%i;end;else WA=WA%i;end;end;end;end;local p=v and v[LD]or function(v1,X1)local K1=(1);while(FD)do do if(K1<=0)then return i-t(i-v1,i-X1);else if(K1~=1)then X1=X1%i;K1=0;else v1=v1%i;do K1=2;end;end;end;end;end;end;local a=(v and v[TD]);local k=v and v[gD]or function(c0)return i-(c0%i);end;local V=(sH(9,nil,nil,{},50,58,519.4509176648396,30,LW,654.7354681499551,w,QW));local N=(v and v[vD]);for vR=0,2 do if(not(sH(2,vR,0)))then if(vR~=1)then do V=function(W3)local k3,h3,x3,G3,w3,C3,B3,u3=5,QW,QW,QW,QW,QW,QW,(QW);repeat if(not(k3<=3))then if(not(k3<=5))then do if(k3~=6)then B3=X(C3[1],o);do k3=1;end;else do x3=1591462198;end;k3=2;end;end;else if(k3~=4)then h3=1883818806;k3=6;else w3=XD;k3=3;end;end;else if(not(k3<=1))then do if(k3~=2)then do C3={K(b,c,c+3)};end;do k3=0;end;else G3=1103287065;k3=4;end;end;else if(k3~=0)then u3=X(C3[2],o);k3=8;else c=c+4;k3=7;end;end;end;until(k3>=8);local I3=X(C3[(pW({},{__sub=function(zv,xv)w3=w3-407;do G3=G3-3;end;x3=x3-312;do return (((xv+w3)+G3)+x3);end;end})- -3090606693)],o);local d3=(X(C3[4],o));k3=1;while(FD)do if(k3~=0)then o=((pW({},{__concat=function(Ta,Wa)local Ya=1;while(FD)do do if(Ya~=0)then h3=h3-pD;Ya=0;else return (Wa+h3);end;end;end;end})..-1883817964)*o+W3)%256;k3=0;else return d3*16777216+I3*65536+u3*tD+B3;end;end;end;end;else do N=sH(10,nil,nil,{},i,232.10460936581057,N,{},SW,52,{},765.8962823244528,64)or function(Id,Ld)local md=(QW);for yE=0,3 do if(not(yE<=1))then if(yE~=2)then return md-md%1;else md=(Id%i/Y[Ld]);end;else if(yE~=0)then if(not(Ld<0))then else return a(Id,-Ld);end;else if(not(Ld>=32))then else return 0;end;end;end;end;end;end;end;else a=sH(11,nil,nil,a,574.967317551008,H,456.4976459508585,88,IW,QW)or function(qn,un)local xn=(1);while(FD)do if(not(xn<=0))then do if(xn==1)then do if(not(un>=32))then else return 0;end;end;xn=0;else do return (qn*Y[un])%i;end;end;end;else if(not(un<0))then else return N(qn,-un);end;do xn=2;end;end;end;end;end;end;WW=2;local Z,S=QW,(QW);while(sH(20,WW,4))do if(not(sH(2,WW,1)))then do if(WW==2)then Z=function(Uh)local hh=(1004340798);local Vh=Q();local Th=QW;do for LP=0,2 do if(not(LP<=0))then if(LP~=1)then c=c+Vh;else for Y2=(pW({},{__div=function(IR,yR)for BJ=0,1 do if(BJ==0)then hh=hh+764;else do return (yR-hh);end;end;end;end})/1004341563),Vh,7997 do local V2,O2,z2=QW,QW,(QW);local S2=(2);repeat if(S2<=1)then if(S2~=0)then do z2={K(b,c+Y2-(pW({},{__pow=function(kJ,gJ)local yJ=(1);while(FD)do do if(yJ~=0)then V2=V2+35;yJ=0;else return (gJ-V2);end;end;end;end})^1791662078),c+O2-1)};end;S2=3;else O2=Y2+7997-1;S2=4;end;else if(not(S2<=2))then if(S2~=3)then if(not(O2>Vh))then else O2=Vh;end;do S2=1;end;else for cx=1,#z2 do local jx,mx=QW,(QW);local Mx=(3);repeat if(not(Mx<=1))then do if(Mx==2)then z2[cx]=X(z2[cx],D);Mx=1;else jx=170469693;do Mx=0;end;end;end;else if(Mx~=0)then D=(Uh*D+(pW({},{[MD]=function(lH,jH)mx=mx+59;local XH=(1);repeat do if(XH~=0)then jx=jx-812;XH=0;else return ((jH-mx)+jx);end;end;until(xD);end})^1820043414))%256;Mx=4;else do mx=1990511999;end;Mx=2;end;end;until(Mx>=4);end;S2=5;end;else do V2=1791662042;end;S2=0;end;end;until(S2>=5);Th=Th..s(H(z2));end;end;else Th=qD;end;end;end;return Th;end;WW=0;else S={};WW=4;end;end;else if(WW~=0)then do o=sH(8,nil,nil,60,159.74387195168697,hD,42,55,WW,W,505.55012475157315,lD,EW)();end;do WW=3;end;else D=sH(1,nil,nil,58,WW,p7,p7,GW,W,a,94,{})();do WW=1;end;end;end;end;for v1=(pW({},{__mul=function(qS,sS)do return sS;end;end})*1),sH(6,nil,nil,181.94379025277897,W,476.8045803846977,{},585.7513279053094,641.5701910781931)() do local d1={};local j1,R1=1884006040,1042030766;(S)[v1-(pW({},{[cD]=function(wr,Ur)local er=0;while(FD)do if(not(er<=0))then if(er~=1)then j1=j1-278;er=1;else return ((Ur-R1)+j1);end;else R1=R1+679;do er=2;end;end;end;end})- -841974316)]=sH(10,nil,nil,{},KW,h7,d1,O,835.3745952841088);for Lc=1,sH(10,nil,nil,WW,iW,868.1201680420211,W,WW,eW,QW)() do local lc,Bc=sH(5,nil,nil,WW,FD,QW,P,WW,836.320198467761,k,93),(QW);do for Fp=0,3 do if(not(sH(2,Fp,1)))then do if(sH(3,Fp,2))then (d1)[Bc]=w(0,(sH(11,nil,nil,pW,{},{},32,B,65)({},{[sH(11,nil,nil,cD,584.1429995646524,78,30,WW,p7,{},A,l,WW)]=function(Gw,bw)return bw;end})-4),sH(8,nil,nil,39,{},BD,317.3922158263055,51,{},lc,277.71732063358365));else (d1)[Bc+1]=w(4,4,sH(5,nil,nil,986.717405717539,74,lc,{},cD,89,p7,35,tW));end;end;else if(Fp~=0)then Bc=(Lc-1)*2;else lc=sH(0,nil,nil,41.24519483036273,YW,684.1755192137389,844.6880859107428,W,74,p7,KW,87)();end;end;end;end;end;end;do WW=1;end;local U,f,y,R=sH(5,nil,nil,KW,WW,QW,l,{},WW,WW,{},42.26258625860373,MD),QW,sH(0,nil,nil,80,37.51794277433732,10,K,QW,83,18.85174849349906),QW;do repeat if(not(WW<=1))then do if(WW~=2)then f={};WW=0;else R={};break;end;end;else if(not(sH(3,WW,0)))then U=function(...)return h(kD,...),{...};end;WW=3;else do y=1;end;WW=2;end;end;until(xD);end;local dW,hW,BW=sH(0,nil,nil,WW,{},WW,276.190967740787,QW,927.421895989796,o),QW,sH(0,nil,nil,ZW,{},982.1811158299503,i7,QW,709.0615234741109,88,mW);for U3=0,5 do if(not(sH(2,U3,2)))then if(not(U3<=3))then do if(U3~=4)then do return dW(sH(10,nil,nil,WW,71,56,z,WW,HD,{}),sH(0,nil,nil,MD,Bc,{},{},QW,526.6195233891386,X,642.7369033270661,lW),BW)(...);end;else f=QW;end;end;else R[1]=sH(0,nil,nil,78,{},568.9721286647216,pW,f,222.59537000301725,LD,790.1892944521401,50,i);end;else if(sH(2,U3,0))then function dW(ci,wi,Zi)local ai,ii,di,Hi,Pi=QW,QW,QW,QW,QW;local gi=2;repeat if(not(gi<=2))then if(gi<=3)then do Pi=Zi[6];end;gi=6;else if(gi~=4)then ii=Zi[2];gi=1;else ai=Zi[8];gi=5;end;end;else if(not(gi<=0))then do if(gi~=1)then gi=4;else di=Zi[3];gi=0;end;end;else Hi=Zi[7];gi=3;end;end;until(gi>5);local bi=Zi[5];local hi,Li=Zi[4],(Zi[9]);local li=C({},{[aD]=ND});local Fi=(QW);gi=0;while(FD)do if(not(gi<=0))then if(gi~=1)then if(TW)then TW(Fi,ci);end;gi=1;else do return Fi;end;end;else Fi=function(...)local cQ,sQ,qQ,bQ,uQ,FQ,pQ,eQ=0,1,2,QW,QW,QW,QW,QW;while(qQ~=4)do do if(not(qQ<=1))then if(qQ~=2)then FQ=(uQ==z and ci or uQ);qQ=0;else bQ={};qQ=1;end;else if(qQ~=0)then uQ=(YW and YW()or BD);do qQ=3;end;else pQ,eQ=U(...);qQ=4;end;end;end;end;qQ=1;do while(FD)do if(qQ==0)then for fM=0,pQ do if(not(di>fM))then break;else bQ[fM]=eQ[fM+1];end;end;break;else pQ=pQ-1;qQ=0;end;end;end;R[2]=Zi;(R)[3]=bQ;for xz=0,1 do do if(xz~=0)then if(FQ==uQ)then else if(not(TW))then BD=FQ;else TW(Fi,FQ);end;end;else if(not bi)then eQ=QW;elseif(not(hi))then else do bQ[di]={[VD]=pQ>=di and pQ-di+1 or 0,H(eQ,di+1,pQ+1)};end;end;end;end;end;local JQ,zQ,ZQ,vQ=F(function()while(true)do local Xe=(ai[sQ]);local Qe=Xe[9];do sQ=sQ+1;end;do if(not(Qe>=57))then if(not(Qe<28))then if(not(Qe<42))then do if(not(Qe>=49))then if(not(Qe<45))then if(not(Qe<47))then if(Qe~=48)then local f2=(Xe[2]);local Z2=(bQ[f2]);for Au=f2+1,Xe[6] do Z2=Z2..bQ[Au];end;(bQ)[Xe[8]]=Z2;else bQ[Xe[8]]=p(bQ[Xe[2]],Xe[10]);end;else do if(Qe~=46)then cQ=Xe[8];(bQ[cQ])();do cQ=cQ-1;end;else bQ[Xe[8]]=bQ[Xe[2]]==Xe[10];end;end;end;else if(Qe<43)then (bQ)[Xe[8]]=Xe[3]%bQ[Xe[6]];else if(Qe~=44)then do bQ[Xe[8]][Xe[3]]=Xe[10];end;else do for ot=Xe[8],Xe[2] do bQ[ot]=QW;end;end;end;end;end;else if(not(Qe<53))then if(Qe<55)then if(Qe~=54)then if(bQ[Xe[2]]==Xe[10])then else sQ=sQ+1;end;else bQ[Xe[8]]=bQ[Xe[2]]%Xe[10];end;else if(Qe==56)then bQ[Xe[8]]=a(Xe[3],Xe[10]);else (bQ)[Xe[8]]=t(Xe[3],Xe[10]);end;end;else if(Qe>=51)then if(Qe==52)then bQ[Xe[8]]=xD;else do if(not(not(bQ[Xe[2]]<=Xe[10])))then else do sQ=sQ+1;end;end;end;end;else if(Qe~=50)then (bQ)[Xe[8]]=bQ[Xe[2]]-Xe[10];else local uq,rq=ii[Xe[1]],(QW);local Lq=(uq[1]);do if(Lq>0)then rq={};do for wT=0,Lq-1 do local CT=ai[sQ];local pT=(CT[9]);do if(pT~=26)then rq[wT]=wi[CT[2]];else do (rq)[wT]={bQ,CT[2]};end;end;end;do sQ=sQ+1;end;end;end;(O)(li,rq);end;end;do (bQ)[Xe[8]]=dW(FQ,rq,uq);end;end;end;end;end;end;else if(not(Qe>=35))then if(not(Qe<31))then do if(not(Qe>=33))then if(Qe~=32)then sQ=Xe[1];else local Vb=(Xe[8]);do (bQ)[Vb]=bQ[Vb](bQ[Vb+1],bQ[Vb+2]);end;do cQ=Vb;end;end;else if(Qe~=34)then do bQ[Xe[8]]=p(Xe[3],bQ[Xe[6]]);end;else bQ[Xe[8]]=t(bQ[Xe[2]],Xe[10]);end;end;end;else if(not(Qe<29))then do if(Qe~=30)then do bQ[Xe[8]]=bQ[Xe[2]]+Xe[10];end;else bQ[Xe[8]]=Xe[7];end;end;else FQ[Xe[7]]=bQ[Xe[8]];end;end;else do if(not(Qe>=38))then if(not(Qe>=36))then (bQ)[Xe[8]]=bQ[Xe[2]]>=Xe[10];else if(Qe==37)then bQ[Xe[8]]=bQ[Xe[2]]%bQ[Xe[6]];else (bQ)[Xe[8]]=Xe[3]^Xe[10];end;end;else if(not(Qe<40))then if(Qe~=41)then (bQ)[Xe[8]]=t(bQ[Xe[2]],bQ[Xe[6]]);else do bQ[Xe[8]]=Xe[3]>=bQ[Xe[6]];end;end;else if(Qe==39)then local f_=Xe[8];(bQ[f_])(bQ[f_+1],bQ[f_+2]);cQ=f_-1;else local lv=(bQ[Xe[2]]);local wv=(bQ[Xe[6]]);local pv=Xe[8];(bQ)[pv+1]=lv;bQ[pv]=lv[wv];end;end;end;end;end;end;else do if(not(Qe>=14))then do if(not(Qe>=7))then if(not(Qe<3))then if(Qe>=5)then if(Qe==6)then local pf,Zf=Xe[8],(bQ[Xe[2]]);bQ[pf+1]=Zf;do (bQ)[pf]=Zf[Xe[10]];end;else if(Xe[6]~=156)then repeat local V7,l7,A7=li,bQ,(Xe[8]);do if(not(#V7>0))then else local je={};for Qz,Fz in A,V7 do for i0,Q0 in A,Fz do if(not(Q0[1]==l7 and Q0[2]>=A7))then else local YP=(Q0[2]);if(not(not je[YP]))then else je[YP]={l7[YP]};end;Q0[1]=je[YP];(Q0)[2]=1;end;end;end;end;end;until(FD);else sQ=sQ-1;(ai)[sQ]={[9]=85,[2]=(Xe[2]-50)%256,[8]=(Xe[8]-50)%tD};end;end;else if(Qe~=4)then (bQ[Xe[8]])[bQ[Xe[2]]]=Xe[10];else (bQ)[Xe[8]]=bQ[Xe[2]]>=bQ[Xe[6]];end;end;else if(not(Qe<1))then if(Qe~=2)then do bQ[Xe[8]]={};end;else bQ[Xe[8]]=bQ[Xe[2]]-bQ[Xe[6]];end;else do if(Xe[6]==167)then sQ=sQ-1;(ai)[sQ]={[2]=(Xe[2]-83)%256,[9]=87,[8]=(Xe[8]-83)%256};elseif(Xe[6]==45)then sQ=sQ-1;(ai)[sQ]={[8]=(Xe[8]-97)%256,[9]=70,[2]=(Xe[2]-97)%256};elseif(Xe[6]==85)then sQ=sQ-1;ai[sQ]={[8]=(Xe[8]-212)%256,[9]=87,[2]=(Xe[2]-212)%256};else bQ[Xe[8]]=QW;end;end;end;end;else if(not(Qe>=10))then if(not(Qe<8))then if(Qe~=9)then local Q6=Xe[8];local H6=(bQ[Q6+2]);local l6=(bQ[Q6]+H6);(bQ)[Q6]=l6;do if(not(H6>0))then do if(not(l6>=bQ[Q6+1]))then else sQ=Xe[1];(bQ)[Q6+3]=l6;end;end;else if(not(l6<=bQ[Q6+1]))then else sQ=Xe[1];bQ[Q6+3]=l6;end;end;end;else repeat local mO,CO=li,(bQ);if(not(#mO>0))then else local Fg=({});for WG,FG in A,mO do for gB,jB in A,FG do if(not(jB[1]==CO and jB[2]>=0))then else local Bm=(jB[2]);if(not Fg[Bm])then do Fg[Bm]={CO[Bm]};end;end;do jB[1]=Fg[Bm];end;(jB)[2]=1;end;end;end;end;until(FD);return FD,Xe[8],1;end;else bQ[Xe[8]]=FQ[Xe[7]];end;else if(Qe>=12)then if(Qe==13)then if(not(not(Xe[3]<=bQ[Xe[6]])))then else sQ=sQ+1;end;else bQ[Xe[8]]=bQ[Xe[2]][Xe[10]];end;else if(Qe==11)then do bQ[Xe[8]]=R[Xe[2]];end;else bQ[Xe[8]]=bQ[Xe[2]]<bQ[Xe[6]];end;end;end;end;end;else if(Qe>=21)then do if(not(Qe>=24))then if(not(Qe>=22))then do bQ[Xe[8]]=N(Xe[3],Xe[10]);end;else if(Qe==23)then do bQ[Xe[8]]=Xe[3]+bQ[Xe[6]];end;else local JZ=Xe[8];bQ[JZ]=bQ[JZ](bQ[JZ+1]);cQ=JZ;end;end;else do if(not(Qe<26))then if(Qe~=27)then (bQ)[Xe[8]]=bQ[Xe[2]];else bQ[Xe[8]]=Xe[7];end;else if(Qe~=25)then (bQ)[Xe[8]]=bQ[Xe[2]]==bQ[Xe[6]];else do bQ[Xe[8]]=bQ[Xe[2]]~=bQ[Xe[6]];end;end;end;end;end;end;else if(not(Qe<17))then if(Qe>=19)then if(Qe~=20)then bQ[Xe[8]]=#bQ[Xe[2]];else local Tb=(Xe[8]);cQ=Tb+Xe[2]-1;(bQ[Tb])(H(bQ,Tb+1,cQ));do cQ=Tb-1;end;end;else if(Qe==18)then do if(not(not(bQ[Xe[2]]<Xe[10])))then else sQ=sQ+1;end;end;else do bQ[Xe[8]]=p(Xe[3],Xe[10]);end;end;end;else if(not(Qe>=15))then bQ[Xe[8]]=Xe[3]-Xe[10];else if(Qe~=16)then local Di=Xe[8];bQ[Di](H(bQ,Di+1,cQ));do cQ=Di-1;end;else local bE=(Xe[8]);local qE=(Xe[6]-1)*50;for D1=1,Xe[2] do (bQ[bE])[qE+D1]=bQ[bE+D1];end;end;end;end;end;end;end;end;else if(not(Qe<85))then do if(Qe>=99)then do if(not(Qe>=106))then if(Qe<102)then if(not(Qe<100))then if(Qe==101)then bQ[Xe[8]]=bQ[Xe[2]]+bQ[Xe[6]];else local nx=Xe[8];local Sx=nx+2;local gx=nx+1;(bQ)[nx]=d(B(bQ[nx]),ZD);bQ[gx]=d(B(bQ[gx]),SD);bQ[Sx]=d(B(bQ[Sx]),UD);do (bQ)[nx]=bQ[nx]-bQ[Sx];end;do sQ=Xe[1];end;end;else do if(not(not bQ[Xe[8]]))then else do sQ=sQ+1;end;end;end;end;else if(not(Qe<104))then if(Qe~=105)then local Tc=Xe[3]/bQ[Xe[6]];do (bQ)[Xe[8]]=Tc-Tc%1;end;else repeat local UU,JU=li,bQ;if(#UU>0)then local Si={};do for VB,AB in A,UU do do for fZ,VZ in A,AB do if(VZ[1]==JU and VZ[2]>=0)then local WM=VZ[2];if(not Si[WM])then (Si)[WM]={JU[WM]};end;VZ[1]=Si[WM];(VZ)[2]=1;end;end;end;end;end;end;until(FD);return FD,Xe[8],0;end;else if(Qe~=103)then local TA=(Xe[8]);cQ=TA+Xe[2]-1;bQ[TA]=bQ[TA](H(bQ,TA+1,cQ));cQ=TA;else local me=wi[Xe[2]];(bQ)[Xe[8]]=me[1][me[2]];end;end;end;else if(not(Qe>=110))then if(not(Qe<108))then if(Qe~=109)then bQ[Xe[8]]=Xe[3]~=bQ[Xe[6]];else local Ax=(wi[Xe[2]]);(Ax[1])[Ax[2]]=bQ[Xe[8]];end;else if(Qe~=107)then local x1=(Xe[8]);for gG=x1,x1+(Xe[2]-1) do (bQ)[gG]=eQ[di+(gG-x1)+1];end;else (bQ)[Xe[8]]=Xe[3]~=Xe[10];end;end;else if(not(Qe>=112))then if(Qe==111)then if(not(Xe[3]<Xe[10]))then sQ=sQ+1;end;else bQ[Xe[8]]=N(Xe[3],bQ[Xe[6]]);end;else do if(Qe~=113)then bQ[Xe[8]]=bQ[Xe[2]]<Xe[10];else bQ[Xe[8]]=bQ[Xe[2]]/bQ[Xe[6]];end;end;end;end;end;end;else if(not(Qe<92))then if(not(Qe<95))then if(not(Qe>=97))then do if(Qe~=96)then do bQ[Xe[8]]=bQ[Xe[2]]~=Xe[10];end;else (bQ[Xe[8]])[Xe[3]]=bQ[Xe[6]];end;end;else if(Qe==98)then do bQ[Xe[8]]=bQ[Xe[2]]*bQ[Xe[6]];end;else bQ[Xe[8]]={H({},1,Xe[2])};end;end;else if(not(Qe>=93))then if(Xe[6]==63)then do sQ=sQ-1;end;do ai[sQ]={[8]=(Xe[8]-fD)%256,[9]=85,[2]=(Xe[2]-fD)%256};end;elseif(Xe[6]~=120)then repeat local Ip,Bp=li,(bQ);do if(not(#Ip>0))then else local m_={};for Cu,du in A,Ip do do for Br,fr in A,du do if(not(fr[1]==Bp and fr[2]>=0))then else local b7=(fr[2]);if(not(not m_[b7]))then else m_[b7]={Bp[b7]};end;fr[1]=m_[b7];(fr)[2]=1;end;end;end;end;end;end;until(FD);local sh=(Xe[8]);do return xD,sh,sh+Xe[2]-2;end;else sQ=sQ-1;(ai)[sQ]={[2]=(Xe[2]-58)%256,[9]=0,[8]=(Xe[8]-58)%256};end;else do if(Qe~=94)then do bQ[Xe[8]]=bQ[Xe[2]]^bQ[Xe[6]];end;else local UL=Xe[2];(bQ)[Xe[8]]=bQ[UL]..bQ[UL+1];end;end;end;end;else if(not(Qe<88))then do if(not(Qe<90))then if(Qe~=91)then do (bQ[Xe[8]])[bQ[Xe[2]]]=bQ[Xe[6]];end;else if(Xe[6]~=fD)then repeat local oM,zM=li,bQ;if(not(#oM>0))then else local IL={};for go,oo in A,oM do do for Tp,ap in A,oo do do if(not(ap[1]==zM and ap[2]>=0))then else local Tx=(ap[2]);if(not(not IL[Tx]))then else IL[Tx]={zM[Tx]};end;(ap)[1]=IL[Tx];(ap)[2]=1;end;end;end;end;end;end;until(FD);return xD,Xe[8],cQ;else sQ=sQ-1;(ai)[sQ]={[8]=(Xe[8]-130)%256,[2]=(Xe[2]-130)%256,[9]=26};end;end;else if(Qe==89)then local f6=Xe[8];bQ[f6](bQ[f6+1]);cQ=f6-1;else bQ[Xe[8]]=k(bQ[Xe[2]]);end;end;end;else if(not(Qe>=86))then repeat local CO,hO=li,(bQ);do if(not(#CO>0))then else local Am=({});for bu,ou in A,CO do for Qm,Nm in A,ou do if(not(Nm[1]==hO and Nm[2]>=0))then else local GU=(Nm[2]);if(not(not Am[GU]))then else (Am)[GU]={hO[GU]};end;Nm[1]=Am[GU];Nm[2]=1;end;end;end;end;end;until(FD);return;else if(Qe~=87)then do if(Xe[3]==bQ[Xe[6]])then else sQ=sQ+1;end;end;else if(Xe[6]==33)then sQ=sQ-1;(ai)[sQ]={[2]=(Xe[2]-178)%256,[9]=92,[8]=(Xe[8]-178)%256};elseif(Xe[6]==62)then sQ=sQ-1;(ai)[sQ]={[2]=(Xe[2]-36)%256,[9]=5,[8]=(Xe[8]-36)%256};else local i9,O9=Xe[8],(pQ-di);if(O9<0)then do O9=-1;end;end;for kn=i9,i9+O9 do bQ[kn]=eQ[di+(kn-i9)+1];end;do cQ=i9+O9;end;end;end;end;end;end;end;end;else if(not(Qe<71))then if(not(Qe>=78))then if(not(Qe>=74))then if(not(Qe>=72))then (R)[Xe[2]]=bQ[Xe[8]];else if(Qe~=73)then bQ[Xe[8]]=FD;else local rG=(Xe[2]);local aG=Xe[8];do cQ=aG+rG-1;end;repeat local hJ,jJ=li,(bQ);do if(#hJ>0)then local WS=({});for UE,mE in A,hJ do for Xu,Fu in A,mE do do if(Fu[1]==jJ and Fu[2]>=0)then local MH=Fu[2];if(not(not WS[MH]))then else do WS[MH]={jJ[MH]};end;end;Fu[1]=WS[MH];(Fu)[2]=1;end;end;end;end;end;end;until(FD);do return FD,aG,rG;end;end;end;else if(not(Qe>=76))then if(Qe==75)then bQ[Xe[8]]=X(bQ[Xe[2]],bQ[Xe[6]]);else do (bQ)[Xe[8]]=X(Xe[3],Xe[10]);end;end;else if(Qe==77)then bQ[Xe[8]]=Xe[3]<Xe[10];else if(Xe[2]~=121)then local c9=Xe[8];local z9=c9+3;local X9=c9+2;local W9=({bQ[c9](bQ[c9+1],bQ[X9])});for JI=1,Xe[6] do bQ[X9+JI]=W9[JI];end;local h9=bQ[z9];if(h9==QW)then do sQ=sQ+1;end;else (bQ)[X9]=h9;end;else sQ=sQ-1;ai[sQ]={[2]=(Xe[6]-12)%256,[8]=(Xe[8]-12)%256,[9]=19};end;end;end;end;else do if(not(Qe>=81))then if(Qe<79)then (bQ)[Xe[8]]=Xe[3]+Xe[10];else if(Qe==80)then local FB=bQ[Xe[2]];if(not(not FB))then (bQ)[Xe[8]]=FB;else sQ=sQ+1;end;else if(not(not(Xe[3]<bQ[Xe[6]])))then else sQ=sQ+1;end;end;end;else do if(Qe>=83)then do if(Qe==84)then bQ[Xe[8]]=bQ[Xe[2]]<=bQ[Xe[6]];else if(bQ[Xe[2]]~=bQ[Xe[6]])then else sQ=sQ+1;end;end;end;else do if(Qe==82)then if(bQ[Xe[2]]==bQ[Xe[6]])then else sQ=sQ+1;end;else bQ[Xe[8]]=Xe[3]>Xe[10];end;end;end;end;end;end;end;else if(not(Qe<64))then if(not(Qe<67))then if(not(Qe<69))then if(Qe==70)then if(Xe[6]==138)then sQ=sQ-1;(ai)[sQ]={[2]=(Xe[2]-3)%256,[8]=(Xe[8]-3)%256,[9]=64};else (bQ)[Xe[8]]=not bQ[Xe[2]];end;else (bQ)[Xe[8]]=a(Xe[3],bQ[Xe[6]]);end;else do if(Qe~=68)then do (bQ)[Xe[8]]=Xe[3]<bQ[Xe[6]];end;else local Vz=(Xe[8]);do bQ[Vz]=bQ[Vz](H(bQ,Vz+1,cQ));end;cQ=Vz;end;end;end;else do if(Qe<65)then (bQ)[Xe[8]]=-bQ[Xe[2]];else if(Qe~=66)then (bQ)[Xe[8]]=FD;sQ=sQ+1;else if(not(not(bQ[Xe[2]]<=bQ[Xe[6]])))then else sQ=sQ+1;end;end;end;end;end;else if(not(Qe<60))then do if(not(Qe>=62))then if(Qe~=61)then (bQ)[Xe[8]]=Xe[3]-bQ[Xe[6]];else local m8,X8,l8=Xe[8],Xe[2],Xe[6];if(X8==0)then else cQ=m8+X8-1;end;local g8,v8=QW,(QW);if(X8==1)then g8,v8=U(bQ[m8]());else do g8,v8=U(bQ[m8](H(bQ,m8+1,cQ)));end;end;do if(l8==1)then cQ=m8-1;else if(l8==0)then do g8=g8+m8-1;end;cQ=g8;else do g8=m8+l8-2;end;cQ=g8+1;end;local sh=0;for uH=m8,g8 do do sh=sh+1;end;(bQ)[uH]=v8[sh];end;end;end;end;else if(Qe==63)then do bQ[Xe[8]]=bQ[Xe[2]]>Xe[10];end;else if(bQ[Xe[2]]~=Xe[10])then else sQ=sQ+1;end;end;end;end;else if(not(Qe>=58))then bQ[Xe[8]]=X(Xe[3],bQ[Xe[6]]);else do if(Qe==59)then bQ[Xe[8]]=bQ[Xe[2]][bQ[Xe[6]]];else do if(not(bQ[Xe[8]]))then else sQ=sQ+1;end;end;end;end;end;end;end;end;end;end;end;end;end);do if(JQ)then if(zQ)then do if(vQ==1)then return bQ[ZQ]();else do return bQ[ZQ](H(bQ,ZQ+1,cQ));end;end;end;elseif(ZQ)then return H(bQ,ZQ,vQ);end;else do if(G(zQ)~=yD)then J(zQ,0);else local Bb=(0);do repeat do if(Bb~=0)then if(not(P(zQ,hH)))then J(zQ,0);else (J)(BH..(Pi[sQ-1]or FH)..GH..m(zQ),0);end;do Bb=2;end;else if(P(zQ,RD))then do return dH();end;end;Bb=1;end;end;until(Bb>=2);end;end;end;end;end;end;gi=2;end;end;end;else if(U3~=1)then BW=hW();else function hW()local w7=(1);local Y7,L7=2032560450,229296601;local g7,r7,T7=QW,QW,QW;do while(w7<=2)do if(not(w7<=0))then if(w7~=1)then T7=190911087;w7=3;else do g7=mH;end;w7=0;end;else r7=193894892;w7=2;end;end;end;local D7=98209341;local F7=(1041472069);w7=1;local v7,k7,e7,A7=QW,QW,QW,QW;while(w7<=4)do do if(w7<=1)then if(w7==0)then A7={};do w7=5;end;else do v7=JH;end;w7=4;end;else if(not(w7<=2))then if(w7~=3)then do k7=1265420797;end;do w7=2;end;else e7={QW,{},QW,QW,QW,{},QW,{},QW};w7=0;end;else w7=3;end;end;end;end;do w7=0;end;local l7,H7,J7=QW,QW,QW;while(w7~=4)do do if(not(w7<=1))then if(w7~=2)then H7=1;w7=2;else J7=Q();w7=1;end;else if(w7~=0)then do for i3=(pW({},{__add=function(rI,FI)local PI=2;while(FD)do if(not(PI<=1))then do if(PI~=2)then return (((FI-k7)+v7)-F7);else do k7=k7+825;end;do PI=1;end;end;end;else do if(PI~=0)then v7=v7-553;PI=0;else F7=F7+335;do PI=3;end;end;end;end;end;end})+1101072614),J7 do local S3=Q();local L3=(Q());local q3=(Q());do for S8=S3,L3 do (e7[6])[S8]=q3;end;end;end;end;w7=4;else l7={};w7=3;end;end;end;end;(e7)[1]=W();local B7=(Q()-133740);w7=1;local R7=(QW);do while(w7<=3)do do if(not(w7<=1))then do if(w7~=2)then for wg=1,B7 do local hg,xg,Zg,ug,Lg=3,QW,QW,QW,QW;while(hg~=4)do if(not(hg<=1))then if(hg~=2)then xg=769473334;hg=1;else ug=1150775398;hg=0;end;else do if(hg~=0)then Zg=25714602;do hg=2;end;else Lg=qH;hg=4;end;end;end;end;hg=2;local ig,Sg,bg=QW,QW,(QW);do repeat if(not(hg<=0))then do if(hg~=1)then ig=2064232647;hg=0;else do bg={QW,QW,QW,QW,QW,QW,QW,QW,QW,QW};end;do hg=3;end;end;end;else Sg=2050060783;hg=1;end;until(hg>2);end;local kg=(V(R7));do hg=4;end;while(hg~=7)do if(hg<=2)then do if(not(hg<=0))then if(hg~=1)then bg[9]=W();hg=3;else bg[8]=w(6,(pW({},{__mul=function(ol,Il)local Hl=(0);while(FD)do do if(not(Hl<=0))then do if(Hl~=1)then do return ((Il-ig)-Lg);end;else Lg=Lg+314;Hl=2;end;end;else ig=ig+560;Hl=1;end;end;end;end})*2347057872),kg);hg=0;end;else do bg[16]=w((pW({},{[uD]=function(bo,No)do return No;end;end})/29),(pW({},{[CD]=function(Tf,df)ug=ug+823;for Sj=0,2 do if(not(Sj<=0))then if(Sj~=1)then return (((df-ug)-Lg)-Zg);else do Zg=Zg+296;end;end;else Lg=Lg+8;end;end;end})..1459315812),kg);end;hg=5;end;end;else do if(not(hg<=4))then if(hg==5)then bg[1]=w(14,18,kg);do hg=6;end;else (bg)[6]=w(23,(pW({},{[uD]=function(Sz,mz)for MX=0,1 do if(MX~=0)then return (mz-xg);else xg=xg+43;end;end;end})/769473386),kg);hg=2;end;else if(hg==3)then (bg)[12]=w(24,21,kg);do hg=7;end;else bg[(pW({},{[lD]=function(iH,PH)for vk=0,1 do if(vk==0)then do Sg=Sg-326;end;else do return (PH+Sg);end;end;end;end})%-2050060455)]=w(14,9,kg);hg=1;end;end;end;end;end;e7[8][wg]=bg;end;w7=2;else e7[7]=W();do w7=0;end;end;end;else if(w7~=0)then R7=W();w7=3;else (e7)[(pW({},{[CD]=function(PL,EL)do return EL;end;end})..9)]=W();w7=4;end;end;end;end;end;local o7,S7=QW,(QW);for OS=0,3 do if(not(OS<=1))then if(OS~=2)then S7=W();else do o7=Q()-(pW({},{[cD]=function(Jt,nt)local Qt=0;while(FD)do if(Qt~=0)then return (nt+D7);else D7=D7-114;Qt=1;end;end;end})- -98075490);end;end;else if(OS~=0)then do (e7)[14]=Q();end;else e7[19]=Q();end;end;end;local U7=(W()~=(pW({},{__sub=function(B6,V6)local M6=(1);do while(FD)do if(not(M6<=0))then if(M6~=1)then return ((V6+F7)+T7);else F7=F7-825;M6=0;end;else do T7=T7-154;end;do M6=2;end;end;end;end;end})- -1232382512));for gl=1,o7 do local Kl,Ll,El=0,QW,(QW);do while(Kl~=2)do if(Kl~=0)then El=W();Kl=2;else Kl=1;end;end;end;Kl=0;while(FD)do do if(El==98)then Ll=xD;elseif(El==79)then Ll=FD;elseif(El==35)then Ll=UW(Z(S7),5);elseif(El==228)then Ll=UW(Z(S7),5);elseif(El==165)then do Ll=UW(Z(S7),Q());end;elseif(El==89)then Ll=T();elseif(El==231)then do Ll=Q();end;elseif(El==199)then Ll=UW(Z(S7),T()+Q());elseif(El==243)then Ll=L();elseif(El~=107)then else Ll=UW(Z(S7),5);end;end;break;end;A7[gl-1]=H7;local Yl=({Ll,{}});(l7)[H7]=Yl;H7=H7+1;if(not(U7))then else (f)[y]=Yl;do y=y+1;end;end;end;local K7=S[e7[9]];for Qc=1,B7 do local Nc=e7[8][Qc];local Mc=K7[Nc[9]];local Pc=Mc==2;local Tc=1;do while(Tc~=2)do if(Tc~=0)then if(not((Mc==15 or Pc)and Nc[6]>255))then else local K1,z1,r1=2,QW,QW;repeat do if(not(K1<=1))then if(K1==2)then Nc[4]=FD;do K1=0;end;else do if(not(r1))then else local Zn,un=0,(QW);while(Zn~=2)do if(Zn==0)then (Nc)[10]=r1[1];Zn=1;else un=r1[2];Zn=2;end;end;un[#un+1]={Nc,10};end;end;K1=4;end;else if(K1~=0)then r1=l7[z1];K1=3;else z1=A7[Nc[6]-256];K1=1;end;end;end;until(K1>3);end;Tc=0;else do if(not((Mc==0 or Pc)and Nc[2]>255))then else local HV,OV=QW,(QW);for Ce=0,2 do if(not(Ce<=0))then if(Ce~=1)then (Nc)[(pW({},{__concat=function(aF,jF)local DF=1;repeat if(DF~=0)then OV=OV-972;DF=0;else do return (jF+OV);end;end;until(xD);end})..-1521828105)]=FD;else OV=1521829082;end;else HV=142420711;end;end;local DV=A7[Nc[(pW({},{[nD]=function(DJ,hJ)OV=OV-938;do HV=HV-354;end;return ((hJ+OV)+HV);end})+-1664247527)]-256];local pV=1;local jV=(QW);while(FD)do do if(pV~=0)then jV=l7[DV];pV=0;else if(not(jV))then else local wU,CU,bU=0,QW,(QW);do repeat do if(not(wU<=1))then if(wU~=2)then bU=jV[(pW({},{__div=function(cF,uF)CU=CU+491;return (uF-CU);end})/1631893969)];wU=1;else (Nc)[3]=jV[1];wU=3;end;else if(wU~=0)then (bU)[#bU+1]={Nc,3};wU=4;else CU=1631893476;wU=2;end;end;end;until(wU>=4);end;end;break;end;end;end;end;end;Tc=2;end;end;end;Tc=0;repeat if(Tc~=0)then if(Mc~=4)then else Nc[1]=Qc+(Nc[1]-131071)+1;end;Tc=2;else if(Mc~=(pW({},{__sub=function(Zn,yn)return yn;end})-9))then else local kZ,yZ,ZZ=1,QW,(QW);while(kZ~=3)do if(not(kZ<=0))then if(kZ~=1)then ZZ=l7[yZ];kZ=0;else yZ=A7[Nc[1]];do kZ=2;end;end;else if(not(ZZ))then else local wR,MR,bR=3,QW,QW;repeat if(not(wR<=1))then if(wR==2)then bR=ZZ[(pW({},{[uD]=function(Hr,br)local Fr=1;while(FD)do if(Fr==0)then return (br-MR);else do MR=MR+322;end;Fr=0;end;end;end})/807281371)];wR=0;else do MR=807281047;end;wR=1;end;else if(wR==0)then do (bR)[#bR+1]={Nc,7};end;break;else do Nc[(pW({},{[cD]=function(Kw,lw)return lw;end})-7)]=ZZ[1];end;do wR=2;end;end;end;until(xD);end;kZ=3;end;end;end;Tc=1;end;until(Tc==2);end;do (e7)[19]=W();end;w7=1;local s7=QW;do repeat if(w7~=0)then e7[(pW({},{__mul=function(io,Go)local Zo=(2);repeat do if(not(Zo<=1))then if(Zo~=2)then T7=T7-KH;Zo=0;else do r7=r7+97;end;Zo=3;end;else if(Zo~=0)then return (((Go-r7)+T7)-F7);else F7=F7+230;Zo=1;end;end;end;until(xD);end})*1044456299)]=Q();do w7=0;end;else s7=Q();break;end;until(xD);end;for aV=1,s7 do e7[2][aV-1]=hW();end;do e7[3]=W();end;w7=1;local a7=QW;repeat do if(not(w7<=1))then if(w7~=2)then a7=W();do w7=2;end;else do e7[5]=w((pW({},{__add=function(Dc,sc)local zc=(1);while(FD)do do if(zc~=0)then g7=g7+505;zc=0;else return (sc-g7);end;end;end;end})+786496685),1,a7)~=0;end;w7=0;end;else do if(w7~=0)then do (e7)[11]=W();end;w7=3;else e7[4]=w((pW({},{__mod=function(GL,kL)local SL=(0);while(FD)do if(SL~=0)then return (kL-L7);else L7=L7+646;SL=1;end;end;end})%229297249),1,a7)~=0;break;end;end;end;end;until(xD);w7=0;while(FD)do if(w7~=0)then do return e7;end;else do e7[(pW({},{__sub=function(dP,cP)local wP=(0);repeat if(wP~=0)then Y7=Y7-283;wP=2;else g7=g7-338;do wP=1;end;end;until(wP>1);return ((cP+g7)+Y7);end})- -2819056501)]=Q();end;w7=1;end;end;end;end;end;end;end;end)("\98\111\114",nil,assert,"\110","\95\95\109\111\100",1640750450,setfenv,837,rawset,"\95\95\97\100\100","",tostring,"\103\115\117\98","\114\115\104\105\102\116","\118",string,194,type,560,337,447,1251480122,"\95\95\112\111\119","\95\95\100\105\118","\98\97\110\100","\58\32",_ENV,tonumber,"\108\115\104\105\102\116","\109\97\116\99\104",table.insert,"\96\102\111\114\96\32\108\105\109\105\116\32\118\97\108\117\101\32\109\117\115\116\32\98\101\32\97\32\110\117\109\98\101\114","\98\120\111\114",setmetatable,993,742,"\76\117\114\97\112\104\32\83\99\114\105\112\116\58",bit32,unpack,"\35","\95\95\109\117\108","\95\95\99\111\110\99\97\116",string.sub,rawget,"\117\110\112\97\99\107",table,function(D,h,t,...)if(D<=9)then if(not(D<=4))then if(not(D<=6))then do if(D<=7)then return ({...})[8];else if(D==8)then return ({...})[7];else return ({...})[9];end;end;end;else if(D~=5)then do return ({...})[2];end;else return ({...})[3];end;end;else if(D<=1)then if(D~=0)then do return ({...})[6];end;else return ({...})[5];end;else if(not(D<=2))then if(D~=3)then do return h>t;end;else return h==t;end;else do return h<=t;end;end;end;end;else do if(not(D<=14))then if(not(D<=17))then do if(not(D<=18))then do if(D~=19)then return h~=t;else return ({...})[10];end;end;else do return h..t;end;end;end;else if(not(D<=15))then if(D==16)then return h+t;else return h-t;end;else return h%t;end;end;else do if(not(D<=11))then if(D<=12)then do return h^t;end;else if(D~=13)then return h*t;else return h/t;end;end;else if(D~=10)then return ({...})[1];else return ({...})[4];end;end;end;end;end;end;end,"\114\101\112",849,"\94\46\45\58\37\100\43\58\32","\97\116\116\101\109\112\116\32\116\111\32\121\105\101\108\100\32\97\99\114\111\115\115\32\109\101\116\97\109\101\116\104\111\100\47\67\37\45\99\97\108\108\32\98\111\117\110\100\97\114\121",error,1283913778,256,395858155,coroutine.yield,select,"\98\121\116\101",4294967296,"\96\102\111\114\96\32\105\110\105\116\105\97\108\32\118\97\108\117\101\32\109\117\115\116\32\98\101\32\97\32\110\117\109\98\101\114","LPH~325D01395522529F54522F5225522H2522952949252H225F2H225552222H252H22F552225522252H5522252225224H522H252H5224555225522H225H008A0A0200ED5D1D59DD1F2H3A3EBA1F07C704871FC484C5C4324H71070E4E2H0E1B2H9B23EA611898226C610567383C6162507A7B47AFD595725A6CED35D44999FF74431EB61C1ACC71C38A82CE1FC04DDD8808AD843EAE2F0A9178BE6E97EE9104454H1432C18141C12D5E1E2H5E324HEB1C4H68073HD5551F4H32073F3H7F1CBC6928EF004HE93D4H065B0200B133DC64580F9C356A0A0200B587F3C8B1FE5HFFBA9E233A71023H00F33H00013H00083H00013H00093H00093H008FA9445D0A3H000A3H0016EFB9440B3H000B3H00EAA0020B0C3H000C3H00F171B6600D3H000D3H00A0068B610E3H000E3H0041D535290F3H000F3H0030CE1178103H00103H001ACC3961113H00113H003CCCE820123H00153H00013H00163H00193H00303H001A3H001B3H00013H001C3H001E3H00303H001F3H00203H009B3H00213H00233H00373H00243H00263H00623H00273H00283H00993H00293H00293H009B3H002A3H002C3H00993H002D3H002E3H00013H002F3H00303H00993H00313H00333H00903H00343H00363H00013H00373H00373H002C3H00383H00483H00013H00493H00493H007C3H004A3H004D3H00973H004E3H00533H00013H00543H00563H005B3H00573H00583H005E3H00593H005A3H005F3H005B3H005B3H005D3H005C3H00633H00013H00643H00643H00603H00653H00653H00013H00663H00673H00613H00683H00763H00013H00773H00773H005B3H00783H00783H005C3H00793H007A3H00013H007B3H007B3H005C3H007C3H007F3H00013H00803H00813H005E3H00823H00833H00013H00843H00863H00623H00873H00913H00013H00923H00933H005E3H00943H009B3H00013H009C3H009D3H005E3H009E3H009E3H005B3H009F3H00A03H00013H00A13H00A23H005B3H00A33H00A53H005E3H00A63H00A63H00623H00A73H00A83H00693H00A93H00AB3H00013H00AC3H00B03H00693H00B13H00B33H00363H00B43H00B63H006A3H00B73H00B73H00013H00B83H00B83H00313H00B93H00BA3H00013H00BB3H00BC3H007D3H00BD3H00BD3H00013H00BE3H00C03H007E3H00C13H00C73H00013H00C83H00CB3H00633H00CC3H00CD3H00013H00CE3H00D03H00633H00D13H00D33H00643H00D43H00D53H00013H00D63H00D73H00643H00D83H00D93H00013H00DA3H00DC3H00643H00DD3H00E03H00013H00E13H00E13H00663H00E23H00E53H00013H00E63H00E83H00673H00E93H00EF3H00013H00F03H00F13H00623H00F23H00F33H00013H00F43H00F43H003C3H00F53H00F73H00963H00F83H00FD3H00013H00FE4H00012H00983H002H012H0006012H00013H0007012H0009012H00733H000A012H000F012H00013H0010012H0011012H00723H0012012H0012012H00733H0013012H001E012H00013H001F012H001F012H008A3H0020012H0021012H00013H0022012H0022012H008A3H0023012H0023012H00113H0024012H0025012H00013H0026012H0028012H00113H0029012H002A012H00013H002B012H002B012H00113H002C012H002D012H00013H002E012H002F012H00113H0030012H0030012H001D3H0031012H0032012H00013H0033012H0034012H001D3H0035012H0035012H000A3H0036012H0037012H00013H0038012H0038012H000A3H0039012H0039012H00113H003A012H003B012H00013H003C012H003D012H00113H003E012H003F012H00013H0040012H004C012H00113H004D012H004E012H001D3H004F012H0050012H00013H0051012H0051012H001E3H0052012H0053012H00013H0054012H0054012H001E3H0055012H0056012H00013H0057012H0060012H001E3H0061012H0062012H00013H0063012H0065012H002B3H0066012H0067012H000A3H0068012H0069012H00113H006A012H0070012H00013H0071012H0073012H00083H0074012H0075012H00013H0076012H0078012H00093H0079012H007A012H00113H007B012H007C012H00013H007D012H007E012H00113H007F012H007F012H000A3H0080012H0081012H00013H0082012H0083012H000A3H0084012H0085012H00013H0086012H0087012H000A3H0088012H0089012H00013H008A012H008B012H000A3H008C012H008C012H002B3H008D012H008F012H00013H0090012H0090012H002B3H0091012H0092012H00013H0093012H0095012H002B3H0096012H0098012H00013H0099012H009B012H00A93H009C012H00A1012H00013H00A2012H00A2012H003B3H00A3012H00A4012H00013H00A5012H00AA012H003B3H00AB012H00AE012H00013H00AF012H00AF012H006F3H00B0012H00B8012H00013H00B9012H00B9012H003C3H00BA012H00BC012H00013H00BD012H00BF012H00AC3H00C0012H00C1012H00013H00C2012H00C2012H00AC3H00C3012H00C9012H00013H00CA012H00CE012H00A83H00CF012H00CF012H00013H00D0012H00D2012H00A73H00D3012H00D3012H00333H00D4012H00D5012H00013H00D6012H00D7012H00333H00D8012H00D8012H00013H00D9012H00DB012H00333H00DC012H00DE012H00623H00DF012H00DF012H00853H00E0012H00E1012H00013H00E2012H00E2012H00863H00E3012H00E4012H00013H00E5012H00E5012H00873H00E6012H00E7012H00013H00E8012H00E8012H00883H00E9012H00EA012H00013H00EB012H00ED012H00893H00EE012H00F0012H00013H00F1012H00F1012H00AA3H00F2012H00F3012H00013H00F4012H00F6012H00AB3H00F7012H00F7012H00013H00F8012H00F9012H00813H00FA012H0001022H00013H002H022H002H022H002C3H0003022H0004022H009D3H0005022H0006022H00013H0007022H0007022H009C3H0008022H0009022H00013H000A022H000A022H009C3H000B022H000D022H00013H000E022H000E022H009C3H000F022H0010022H00013H0011022H0012022H009C3H0013022H0016022H00013H0017022H001A022H009D3H001B022H001C022H00843H001D022H001E022H00013H001F022H001F022H00843H0020022H0020022H00013H0021022H0023022H00843H0024022H0026022H00013H0027022H0027022H008D3H0028022H002A022H008E3H002B022H002B022H00013H002C022H002C022H002B3H002D022H002E022H00013H002F022H0031022H002B3H0032022H0033022H00013H0034022H0034022H002B3H0035022H0036022H00013H0037022H0039022H00833H003A022H003C022H00013H003D022H003E022H00973H003F022H0040022H00013H0041022H0041022H006B3H0042022H0043022H00013H0044022H0044022H006B3H0045022H0046022H00013H0047022H0048022H006B3H0049022H004B022H006E3H004C022H004D022H00013H004E022H004E022H006E3H004F022H004F022H00313H0050022H0051022H007C3H0052022H0054022H00913H0055022H0055022H00013H0056022H0058022H002E3H0059022H005A022H00013H005B022H005D022H002F3H005E022H0061022H00013H0062022H0062022H002F3H0063022H0064022H00013H0065022H0067022H00813H0068022H0069022H00803H006A022H006B022H00813H006C022H006D022H00803H006E022H006E022H00813H006F022H0071022H00A13H0072022H0072022H00A23H0073022H0077022H00013H0078022H0079022H00A23H007A022H007C022H00713H007D022H0083022H00014H00EF0C0200DD13D34A931F008059801FDD9D845D1FAAEAA9AA3267A76367072H1412141B2HB188C2612H3E044A617BB0C04640E8A9ADB81C45D3B8DE471277317E468F34AD520BBC6AB84C04D9986A6462A6FD4D2F1EA3F61A254350D005D01F2D2A252D073HFA7A1FB770B3B707642H63F20C41C607011A8E4E71F11F0B8C0B0A163H78F81FD5D2BDD52C22252H223A5F1F31DF1F8C4CA90C1F6923D529082HB6EB361FB3F3BBBD53A0E083201F7DBD46FD1F8A4D2H4A3A07C735871F2HB4B0341FD1BA7B305B1E35FABF5B9B51A624648885D6D04C25E5DA5A1FF23871721B2FA52HAF3A5CAD0DE068B912DD985B0646FB791F2H0309823EF0B0C0701FCD8D4A4D1F9A71B0FB5B17D25E425A2H041B841FA1A62HA15B2E6E0CAE1F6BA4A2B457D81E2H1801B5732H753A422773291EFFF8FBFF1B2C2B2H2C3A496AE0F65F16115A561B13542H533A004025FF509D1A141D1B6AED2HEA3A6748AB260394D35D541B31F62HF13AFEF1650E19BBBC7A7B642862E1F05F85CF2HC53A2H1249921F4FCF34CF1FFC3B3E716099599C191F26E161A860232468AD601097529E602H6D6AED1F7AF23D3A1A773FF0F71AA464A3241FC12HC94E712HCEC04E1F0B83CC4418B878B9381F55DD1514203H62E21FDF97EE9F2C4C24E4AD5BE969F9691FB6312HF63273F473F401E0601A9F1F3D5595DC5BCA420D850A470F4F471AB43C73FB5491519B111F9E59DA10601B5C509560888FCE066065A59D1A1FF25A90D35B2HEFE96F1F9C1BD11260B97EF43760468646C61FC3C4804D6030B035B01F8D8AC003602HDAD95A1F1750D7022B2H44B93B1FA188C9805BAE262H6E3D3HEB6B1F98505E582CB5BDB5B4443H02821F3FB74C3F2H2CE42H6C3289098A091F162H1E872593D395131F0087418E605D1DA7221FEA2D2H2A3AE7A700981F941493141F31392H31017E2H96DF5B3BFB3FBB1F282H6FA66085C2CD0B605212AB2D1F0F67A7EE5BBCFC4EC31FD9B0F1B85BA68FCE875B2HE3119C1F101857DF5DAD6D57D21FFA92521B5B3777CC481F2462E5E432810187811A0E492H0E328BCB8A8B1AF838FEF81A5595A52A1FE2EAAAB302DF5F24A01FCCCB0C0D203H29A91FF67143362C33FB34331A2H20CC5F1FBD357AF2654A024DC5622H876BF81F2H3479B41F5146C6ED5C5EDE5FDE1F9B2HD3DB073H48C81FE56DA1A507B2BAFA640C2F860F4E5B1C757A3D5B79F984061F860686061FC38483824C7030AB0F1F4D8D71CD1F9A121A1B4C2HD7B5571F84C464FB1FA12H06405BAEE92HAE09EB030A4A5B18909F981AB57DF5F4164282BD3D1FBF79F86F5AEC24AFA262898141CE65969E5E43365334FBB25B2HC0A3401FDD559A9D1AEAA26D6A1A674E0F465BD41DD3D41AB11859105BFE77FEFF16BB12531A5BA8A12HE83D054DC5450F3H92121F8F07B5CF2C3C94D49D5B197031785B664F0E475BA32HAB325E507938715BEDA4EEED1BBAB32HBA3AF75B25F847E4EC2C365EC188C2C11B4E472H4E3A8BA004591CF85110595B959C1C875EA2EA63E2143H1F9F1F0CC4724C2C29A16E691AB6B1F1665A33BBF47C3BA0A7E7705A7DF5393D1B4A028A0A63076C5B924B347C2H743A2H11C56E1F9E5E71E11F1BDB7E9B1FC8C22H8848A5EF2HE53A32755A2650AF26656F1A9CDC62E31F394909A65C868E46C62D2HC337BC1FF038B6B01A8D4D73F21F1A5D2H5A5B2H171D9D3EC444C5441F6121B51E1FAEA4E4EE002B61EB6B63982BE4983B75DF1F545B82427DFD1FBF7FDF3F1F2HEC667A3E094969891F2H16DC691F53B831725B008001801F5DF7F6BC5BAAEAAA2A1FE7ED66671A1454EA6B1FB1BB2HB13A3EBED4411FBB7BBA3B1F28E321281A85457AFA1F9299D0D21B4F042H0F3AFCC1DE9F6FD9D25F591AE62C2H67662H639F1C1F2H50982F1F2H2DCA521F7AB2FCFA073HB7371FE4AC606407C10709105A8ECE70F11FCB42090B1AF82H52195B95DFD5D401A2282322321F151D4A60CC46CC192B696029A9273HB6361F73BAEBB32C2HA0E0201F3D782H7D010A4F2H4A3A87EEF2533C34B1B5B461911452511BDE982HDE485B5D2H5B3A4816A03F47656329251B32742H723A6F393B69335C9ADDDC32F939FD791FC6C30607203H03831F30F589F02CCDCBCCCD1A9A5A9F1A1F97D557430B3H04841F6163A5A1072E2D282E1B6B69A9AD3B3H18981FB5B7717507C28142FE0BBF7CFBFF1B6C2F2H2C3A8935A5CE50D6955F561B935059531B40044C401B1DDD159D1F6AEF6BEA10E74185C65B54522H5401F1310E8E1F3E787E7F017BFD2HFB32282E2A6560850385502B1292EA6D1F0F494C4F1BFC7A707C1B199F2H993A26BFD27224A365A3A2203H90101F6D2B5E6D2C7AFC3C3A073HF7771FE462A0A407C187404132CE0ECCCE1A4BCB4A4B1A2HB8BBB81A155514151A622261621A2H9F9E9F1ACC8CCACC1A2HE9EFE91A3630767B0B3HF3731F2026E4E0077DBB2HBD3A8A4AAC0A1F47074EC71F74F6FFF4072H9162EE1F5E9A171E1B9B1B981B1F08C80A08073H65E51FB272B6B207AF6FEEEF079C5C171C073H39B91FC6864246073HC3C90C30F0CF4F1FCD4D060D073HDA5A1F2H579397072H8444CB0CE1A0EAE1076E2E6FEE1F6B6FEEEB1B981C2H581B75B12HB53A028E425C4C3FBA373F1B6CAC84131F8988081D0C3H96161F9352979307C0812H8007DDDC515D073H2AAA1F6726E3E707549593940731F33D31073HBE3E1F3BF93F3B07E8EAA9A8070545F37A1F2H527BD21F4FA8ACEE5BBC7C43C31FD9B1FEB85BA661E6E7163HE3631F9057D6D02C2HED2A2E352H7A48FA1F37B72DB71FA42HCF855BC1EBAAE05B2H0E348E1F8B838B8A4CF878EC781F55D5812A1F62E522A6472HDFD35F1F4C5A1A305C29E9D7561FF69C1F575B33B32DB31FA0672620073HFD7D1F4A0DCECA0787C780885334B48F4B1FD191D1511FDE01C14800DB1B26A41F2H484BC81F25CE8FC45BF2320D8D1F6F642D2F1B5C9CA3231FF973F8783D3H86061F0389B2832CB01A5B115B4DC7474D3H1A2B9A1FD7FCF5B65B444E85841A21A1DD5E1F6E2H89CF5B6B6C2H2B09D8921898632HF5ED751F42C2BA3D1FFF357A6D3B2CE52DAC14C989C9491FD6FCF4B75B3HD3531FC08035BF1FDD37BFFC5BEA80430B5B676D25271BD49429AB1FB1767971073HFE7E1FBBBC7F7B07282FEF7E0CC5ED65245B52BAB4F35B4F47C7CF00FCBC0E831FD99E1B191BE6212H263A2H23E45C1F10D0EC6F1FED2HFBD15C3ABD3ABA63379897E60524E3A42427C181C9411F4E49464E07CBCC4C490C78FF3E381A951568EA1F22E562E2632H1FA6601F2H4CDD331FA9616A783B3H76F61FB3BB77730760A9E8683B3H3DBD1F0AC30E0A07870ECFCE3B3H74F41F51D81511071ED7970D0C3H1B9B1F08418C880765EC2HE53A32B23FB21F6FEFA5101F5CF5B4FD5BB97946C61FC66CEFA75B834AC3C2163HB0301FCDC4998D2C1A532H5A3A1797FF681F2HC436BB1F614946005B6EA96EEE2DEB2C2H6B55D8DF2HD80175322H351A82EAA5E35B7F78B8BF002CEB6CEC6389AADA221E16D6BD691F932H34725B00472H00091D16564836AA6A55D51FA7044B065B14D4916B1FB17DB7A93B3H3EBE1FBB77BFBB07E8E323305E054F8E851AD212D0521F0F22236E5B3CF03C3D203H59D91F66EA7B662C636FEF654B5090AC2F1F6D01064C5B7A96DB9B5B771B9ED65B6424991B1FC1CA8A06658ECE74F11FCB80880D6278B886071F155225AA082H22C25D2H1FB5753E5B8C0C940C1F692E57D664F65E92D75BB3BBB0B313E0E8A4A01A7DFD83021F0A1252765C87ED27665B741E9DD55B51DB5150162HDE544E3E5BDBDA241FC848CB481FE54202445B72F57273163HAF2F1FDCDBB4DC2C2HF92H7E3E06C6F5791F034303831F7017D0915BCD4D30B21F9A5A4FE51FD7502H573404C4FB7B1FA1A22HA13A2E6ECB511FABEB52D41F58122H1834B53C7F751A2HC2D3421FFF34F6BA462CACF2531F09A361285B56D654D61F93DA5352163H40C01FDD54741D2CEAA02HEA48A7AD2HA73A54CA3B180B3129E9CD5C7EBE81011F3BF22HFB3A68E863E81FC585C5451F922H38735B4FCFB3301F7C3CA5031F999E2H995BE6613FD9082HA3A7231F90992H903A6D2DC8121F3ABA92451F7770F0F700A46324A4274181BE3E1FCE89C7CE1B4B4CCB4B6338C2A0F51015122H153A2H62851D1F9F5F9F2H1F4C2BEEAD5BE92916961F3691D1975BF3730F8C1FE0208B9F1FFDBABCBD1A8A0A8B0A1F07C7404952F4B4078B1F91D190111F5EB6397F5BDB5C9B9A208842961C4C2H659B1A1F327534390CEFAF11901F1CDCFD631F793339384C46C647C61F2H43A93C1FF07B3B393B0DC1040D1A3HDA5A1F2H9769E81FC48F4F5C5A2HE11E9E1FEE25E5663BEB2B16941F58522H583AB57538CA1F02C2A37D1F2H3FC3401F2C3575505C2H8976F61F967DBFF75B93536DEC1F402AA0E15B5D9DA3221F330010B5991A0AFC050EA00A02006100E40C3H0032DF6CD9523C133968AE3AA6F3037H00E40B3H000E3B483560C053C593425EE40F3H001DEA9724CE81667D71B30B6D1BAA96E40C4H00EDBA67AB3ECDB486B6C33BE4103H00DC4996C3A3D8FE5AA1451FDFD9C71E7AE4083H00AC196693D4F42A62B0E4093H0094014E7BD72A2F8018E40E3H00E93663700275A30BA26A39312B7562E4083H00BF4CB9065D25558EE4053H00A734A1EE1CE44H00E4093H002815E28F43D6A66C67E4093H00FDCA770405DF899480595H00C06F40E40A3H00B25FEC59F98C83ACF62B595H00C06F4062E40A3H00D4418EBBA6C0EF4DD95BE4083H0076A3B09D097FC563F3027H00F3077H00596H002040E40F3H005E8B9885318DED8A2E2CF40C588B11E4093H00E12E5B680A7DBC29ABE4093H001643503D7AC52DDF8AE40A3H002B3825F2ED4DEE817654E4093H000DDA8714DE91967D99E4083H00C26FFC69D49A84B8E4083H00AA57E451C194BDB4E4093H00923FCC39E2D6A2D81DE4073H0027B4216EF5C1F9F3107H00E4083H00620F9C2H09DCFC09F3FF7H0062F3017H00595H00A06E40595H00C05640E4073H004AF784F14C0E0862F300016H00E4103H006532DF6CBE43270D286EA620A06C572DE40A3H003502AF3CDA825159738DE4093H00972491DE544761BB09E4093H000C79C6F35FB2DB0390594H0080842E41F38H00E4093H0061AEDBE8A5C12EB025E40A3H0096C3D0BDF856B3421BDFE40B3H00B8A5721FF3460FFDC4E822E40E3H000794014E24D71B27981587520608E4083H005D2AD7648E41273DE6D61D9427083H00083H00013H00083H00013H00093H00093H002BAC3C1E0A3H000A3H0004132B1A0B3H000B3H0016982B290C3H000C3H00A5E0251C0D3H000D3H00D500CF190E3H000E3H00EEB5DF540F3H00103H00014H007C0A0200932H2A29AA1F9D5D9F1D1F20A022A01FB3F3B2B33256162H560709892H091BCC8C75BC619F1F24EA6102F20F252E3536695B47B89581A31ECBE1E2083D6E8446AD6EA1D3152B3724A4DB5B1F77372H77550200DD3F977685946027690A0200A5005D055E2H525H002C002C3F30321C3H00013H00083H00013H00093H00093H00640D35020A3H000A3H00C052B4480B3H000B3H00E669431A0C3H000C3H00CB688E2E0D3H000D3H009B71667E0E3H000E3H0001405D350F3H000F3H005D1ECD1D103H00173H00013H00183H001B3H00473H001C3H001D3H00013H001E3H001E3H00473H001F3H00223H00013H00233H00233H00463H00243H00273H00013H00283H00293H00473H002A3H002D3H00013H002E3H002E3H00463H002F3H00323H00013H00333H00333H00473H00343H00353H00013H00363H00383H00473H00393H00393H00013H003A3H003B3H00473H003C3H003D3H00013H003E3H003E3H00473H003F3H003F3H00013H00403H00423H00473H0002AE0A0200B1DA1AD35A1F6BEB62EB1FACECA52C1F2H9D9C9D323E7E2H3E078F0F2H8F1B905028E06141017B3761E23F73DE6133EC73863CF4B16FD01E650EDA1861867B6D742CD7131F794198631822462H898F091FEA3H6A3AFB7BF87B1F3H3CBC1F2D6D2H2D554E8E2HCE673H1F9F1FA0602H200711D151D10A322BAB24004383BC3C1F2H840405163H75F51F1656DA962C67E767E71F683HE83A19D9E2661FFA7AFF7A1F8BA6269B570C4CCCCD167DDD9CDC5BDE7E7F3F5BAF6F50D01F30F02HB067A161E161182HC2C0421F533HD3673H94141F85452H0507668706475B2H77F7F616B83H7867A96956D61F8ACB2H8A1A1BDBE0641F2HDC5C5D163H4DCD1F6EAEEDEE2CBF3H3F3A40C0B93F1FF1B1F0711FD2122H5267A363E363542HA42425163H95151F36F6B0B62C87C773F81F88482H0867F939B939182H9A1A1B16AB6B5DD41F0500557D103266A3516E690A02006100D75C90A10C4H00024D0032E2FF5C0B3H00013H00083H00013H00093H00093H005AC211160A3H000A3H00A90129450B3H000B3H009F8B17610C3H000C3H008B7637290D3H000D3H00DA9EA5210E3H000E3H00608993650F3H000F3H00904D9B12103H00103H00BF874E58113H00113H0065535905123H00153H00014H00810A02003FECACE86C1F2H6B6FEB1F3AFA39BA1F2H59585932C8882HC80787072H871B2H96AFE5612HF5CF82612450486837A3105090297208EB4C33D140DF6715806A9B231FFF3D4DE158CE91263A0DED7E6CCB4D5C0D5E006A3HDB5B1F2A66A6E405C91C5D9A00783H385B030017BC7D59A3BEB067690A02006900DF07EFDD175H007403F66AFD6F0B3H00013H00083H00013H00093H00093H00A2CF945E0A3H000A3H00CEFA232E0B3H000B3H0025CACC180C3H000C3H006167CA1C0D3H000D3H00C84AD84D0E3H000E3H0068C2F5450F3H000F3H005921DB6B103H00104H0097AD64113H00113H0048AE1E4B123H00153H00014H00810A020007F7B7F3771F2HCECA4E1F75B576F51F2HECEDEC3233732H33074ACA2H4A1B3171894161E8A8D29E61EF2997ED32869692AA2CAD77A2DA1C642HB8114EEBC8111B49026EFE4D61290B3FC45CE00EA35B0567B4ECCD543HBE3E1F65252H65559CE969F600633H235B0300EE8FE87540573B47690A0200410084251E787D5H00FC037063C3400A3H00013H00083H00013H00093H00093H00D86197680A3H000A3H003152AD5E0B3H000B3H003A463F1A0C3H000C3H003EAD57680D3H000D3H009790EC280E3H000E3H00F2039E730F3H000F3H008F5D3A15103H00103H007F36F93D113H00133H00014H007F0A0200EB2H3A3EBA1F05C506851F60E063E01F4B0B4A4B32C6862HC607D1512HD11B6CAC541F619717ADE061121C5C44045DDCBE115F382BF51607E3BD15E14F1EDF85FF6C294FA23C10C4B6477A386FAFED0A213H6AEA1FB5C5852A5C90106FEF1F02009D3D4528B3D4143D690A0200AD00E270481B165H004600C18EEF2E0B3H00013H00083H00013H00093H00093H006CBA61450A3H000A3H009E6FEF6C0B3H000B3H00544FA64D0C3H000C3H0098FA32150D3H000D3H0015F4AC150E3H000E3H005972806F0F3H000F3H00143A6855103H00103H0057807049113H00113H00D6D41B38123H00123H00014H007E0A02005B7BBB78FB1F66E665E61FE1A1E2611FECACEDEC3287C72H8707B2322HB21B6D2D551F61B83802CE619368F8D7587EADE05F2CF932DEC60B8408FD8A565FA1E4430CCA007548588520F69D2110F20FE311AB068D475C166626895C02002320D64424311043690A0200D900F97B98D9645H007E0075241D3E0D3H00013H00083H00013H00093H00093H00621CEA420A3H000A3H00B7A681370B3H000B3H0050F4A0440C3H000C3H00B574DD480D3H000D3H008E9F946B0E3H000E3H00D91DB7440F3H000F3H002FDBD762103H00103H00013H00113H00113H00423H00123H00143H00413H00153H00163H00013H00173H00173H00423H0001830A02005911D112911F1A9A199A1F531350D31FBC7C2HBC3255152H55071E9E2H1E1B2H17AE66612H40FA3461193D5C050662172E8A075BF4A1FC4144E2722C40DDC75D036966FEDB15179F1A1B47083H48C81F613H215B2H2AAA2A4H63E31F3HCC4C1FE595D57A5C6E3H2E3H672H27090300F8751E79ADDD7820690A0200650051F299763D4H00011E00C32H332A0F3H00013H00083H00013H00093H00093H00BB72AC160A3H000A3H0005B07E250B3H000B3H001F7926280C3H000C3H007E7331470D3H000D3H00F25F4A7D0E3H000E3H00E46BDB480F3H001B3H00013H001C3H001D3H00273H001E3H001F3H00013H00203H00203H00253H00213H00223H00013H00233H00233H00253H00243H00273H00013H00283H002A3H00243H0008960A0200972H5053D01FE727E5671F4ECE4CCE1F2H858485328CCC2H8C0763E32H631B0A4A32796181C13AF46108F479A5655F1A57245C46CB61D564FD192D102A0467F2EC071B94BB266A82C22H82673H79F91F40002H40074HD76D3EFE2H3E6775F52H756D7C3C7D7C673H53D31FFABA2HFA072H7170716D2HB8BB381F4HCF67B67649C91F4H6D3A3HF4741F4BCBB5341FF2BE7E3C05692HE969593H30B01F2HC7E9C72C2EAE2EAE1F65E56465672CAC6D6C672H43BD3C1FEA6AEBEA674H613AA86853D71F2HBF41C01F02004F96E96799EEFB2H690A0200E1006BDF82A4345H002100C92E644D00E902548E8B32103H00013H00083H00013H00093H00093H005A902E2F0A3H000A3H00F0D5A8210B3H000B3H002877516F0C3H000C3H007A56FE3C0D3H000D3H00871F6B470E3H00153H00013H00163H00193H00033H001A3H001B3H00043H001C3H001D3H00013H001E3H001E3H00043H001F3H00203H00013H00213H00213H00043H00223H00223H000B3H00233H00243H00013H00253H00253H000B4H00910A0200EDA666A4261FB333B1331FB0F0B2301F9D1D9C9D327ABA7B7A072H4745471B0484BD7561B1F18AC6614E457049285BB1C7343D58285D823D0571A15F51E2A73BDD70EFE161535C2HAC2CAC639925AFDA0B4HF61C03C32H03072H402H001BAD3HED3A8AED1EF00B972H17975954145554072H412H011B1EDE2H9E322BEBAB2B272HA8A9A8073H15951F72B2737207FF3F2HBF1BBC3HFC3A69F7D6A411C63H46325393D353273H50D01F3DBD493D2C9AD61654050300527EDA37A9EDCE476F0A0200FD36E4073H00451E9334EAD827E4153H00F01D962BDB3A61A2A538684DAB7AB0A941F3F43907E4073H0059E24718810B24E4143H0014B1DA5FCDEED85A4C177A8991AE0B460996B18FE4133H00402D66BBB19AFC4608CBE67DD090F622DA5197E4133H00EB2C69B2D2634762AD92A5338B36DD93B7E259A9380CFA0C023H004D012H00013H00083H00013H00093H00093H00CF4DC17C0A3H000A3H001BC41E150B3H000B3H005B8BFF720C3H000C3H008BFC56750D3H000D3H00899E93180E3H000E3H0053402E270F3H000F3H004D1BAA68103H00103H00013H00113H00153H00253H00163H001D3H00013H001E3H001E3H00123H001F3H00203H00013H00213H00223H00123H00233H00243H00163H00253H00263H00013H00273H00273H00163H00283H00293H00013H002A3H002A3H00163H002B3H002C3H00013H002D3H002D3H00163H002E3H002F3H00013H00303H00303H00173H00313H00323H00013H00333H00333H00173H00343H00343H000F3H00353H00363H00013H00373H00373H00103H00383H00393H00013H003A3H003A3H00103H003B3H003C3H00013H003D3H003E3H00103H003F3H00403H00013H00413H00413H00103H00423H00433H00013H00443H00473H00113H00483H00483H00123H00493H004A3H00013H004B3H004B3H00123H004C3H004D3H00013H004E3H004E3H00133H004F3H00503H00013H00513H00513H00133H00523H00533H00013H00543H00543H00133H00553H00563H00013H00573H00583H00143H00593H005B3H00013H005C3H005D3H000D3H005E3H005F3H00143H00603H00613H00013H00623H00633H00143H00643H00643H000D3H00653H00663H00013H00673H00673H000D3H00683H00693H00013H006A3H006A3H000E3H006B3H006C3H00013H006D3H006D3H000E3H006E3H006F3H00013H00703H00713H000E3H00723H00733H00013H00743H00743H000E3H00753H00763H00013H00773H00773H000F3H00783H00793H00013H007A3H007B3H000F3H007C3H007D3H00123H007E3H007E3H00143H007F3H00803H00013H00813H00813H00153H00823H00833H00013H00843H00843H00153H00853H00863H00013H00873H00883H00153H00893H008E3H00013H008F3H00913H00263H00923H00933H00273H00943H00943H00283H00953H00963H00013H00973H00983H00283H00993H009A3H00013H009B3H009B3H00293H009C3H009D3H00013H009E3H009E3H00293H009F3H00A03H00013H00A13H00A13H00293H00A23H00A33H002A3H00A43H00A53H00013H00A63H00A63H002A3H00A73H00A73H002B3H00A83H00A93H00013H00AA3H00AB3H002B3H00AC3H00AC3H002C3H00AD3H00AE3H00013H00AF3H00B03H002C3H00B13H00B23H00013H00B33H00B53H002D3H00B63H00B73H00013H00B83H00B83H002E3H00B93H00BA3H00013H00BB3H00BC3H002E3H00BD3H00BE3H00013H00BF3H00BF3H002F3H00C03H00C13H00013H00C23H00C33H002F3H00C43H00C53H00013H00C63H00C73H00303H00C83H00C93H00013H00CA3H00CA3H00303H00CB3H00CC3H00013H00CD3H00D03H00313H00D13H00D23H00013H00D33H00D33H00313H00D43H00D53H00323H00D63H00D93H000C3H00DA3H00DF3H00343H00E03H00E13H00493H00E23H00E33H00013H00E43H00E53H004A3H00E63H00E73H00013H00E83H00E83H004A3H00E93H00EA3H00013H00EB3H00EB3H004B3H00EC3H00ED3H00013H00EE3H00EF3H004B3H00F03H00F03H004C3H00F13H00F23H00013H00F33H00F43H004C3H00F53H00F73H004F3H00F83H00F93H00013H00FA3H00FB3H004F3H00FC3H00FC3H004C3H00FD3H00FD3H004D3H00FE3H00FF3H00014H00013H00012H004D3H002H012H0002012H00013H0003012H0003012H004D3H0004012H0005012H00013H0006012H000A012H004E3H000B012H000F012H00013H0010012H0010012H00473H0011012H0011012H00483H0012012H0013012H00013H0014012H0015012H00483H0016012H0017012H00013H0018012H0019012H00493H001A012H001B012H004F3H001C012H001D012H00503H001E012H001E012H00453H001F012H0020012H00013H0021012H0022012H00463H0023012H0023012H00503H0024012H0025012H004F3H0026012H0027012H00473H0028012H0029012H00443H002A012H002C012H00453H002D012H002D012H00463H002E012H002F012H00013H0030012H0030012H00463H0031012H0032012H00013H0033012H0034012H00473H0035012H0035012H00523H0036012H0037012H00013H0038012H003A012H00523H003B012H003C012H003B3H003D012H003D012H003D3H003E012H003F012H00013H0040012H0040012H003D3H0041012H0041012H003E3H0042012H0043012H00013H0044012H0045012H003E3H0046012H0047012H00013H0048012H004A012H003F3H004B012H004C012H00013H004D012H004D012H003F3H004E012H004F012H00013H0050012H0051012H00403H0052012H0053012H00013H0054012H0055012H00403H0056012H0057012H00013H0058012H0058012H00403H0059012H005A012H00013H005B012H005C012H00413H005D012H005D012H00373H005E012H005F012H00013H0060012H0060012H00383H0061012H0062012H00013H0063012H0063012H00383H0064012H0065012H00013H0066012H0067012H00383H0068012H0069012H003D3H006A012H006A012H003B3H006B012H006E012H003C3H006F012H006F012H00353H0070012H0071012H00013H0072012H0072012H00353H0073012H0074012H00013H0075012H0075012H00353H0076012H0077012H00363H0078012H0079012H00013H007A012H007A012H00373H007B012H007C012H00013H007D012H007E012H00373H007F012H0083012H00013H0084012H0084012H00393H0085012H0086012H00013H0087012H0087012H00393H0088012H0089012H00013H008A012H008A012H00393H008B012H008B012H003A3H008C012H008D012H00013H008E012H008E012H003A3H008F012H0090012H00013H0091012H0091012H003A3H0092012H0093012H00013H0094012H0095012H003B3H0096012H0099012H00433H009A012H009A012H005E3H009B012H009C012H00013H009D012H009D012H005E3H009E012H009F012H00013H00A0012H00A0012H005F3H00A1012H00A2012H00013H00A3012H00A3012H005F3H00A4012H00A6012H00563H00A7012H00AB012H00573H00AC012H00AD012H00553H00AE012H00AE012H00583H00AF012H00B0012H00013H00B1012H00B1012H00583H00B2012H00B3012H00013H00B4012H00B4012H00593H00B5012H00B6012H00013H00B7012H00B8012H00593H00B9012H00BA012H00013H00BB012H00BB012H005A3H00BC012H00BD012H00013H00BE012H00BE012H005A3H00BF012H00C0012H00013H00C1012H00C1012H005A3H00C2012H00C2012H005B3H00C3012H00C4012H00013H00C5012H00C5012H005B3H00C6012H00C7012H00013H00C8012H00C8012H005B3H00C9012H00CA012H00013H00CB012H00CE012H005C3H00CF012H00CF012H00543H00D0012H00D1012H00013H00D2012H00D2012H00553H00D3012H00D4012H00013H00D5012H00D6012H00553H00D7012H00DA012H00013H00DB012H00DC012H00533H00DD012H00DD012H005C3H00DE012H00DE012H005D3H00DF012H00E0012H00013H00E1012H00E1012H005D3H00E2012H00E3012H00013H00E4012H00E4012H005D3H00E5012H00E6012H00013H00E7012H00EA012H005E3H00EB012H00EB012H00533H00EC012H00ED012H00013H00EE012H00EE012H00533H00EF012H00F0012H00013H00F1012H00F1012H00543H00F2012H00F3012H00013H00F4012H00F5012H00543H00F6012H00F7012H00583H00F8012H00FB012H00183H00FC012H00FC012H001E3H00FD012H00FE012H00013H00FF013H00022H001E3H0001022H002H022H00013H0003022H0004022H001F3H0005022H0005022H00233H0006022H0007022H00013H0008022H0008022H00233H0009022H0009022H00013H000A022H000B022H00193H000C022H000D022H00013H000E022H000E022H00193H000F022H0010022H00013H0011022H0011022H001A3H0012022H0013022H00013H0014022H0014022H001A3H0015022H0016022H00013H0017022H0017022H001A3H0018022H0019022H00013H001A022H001A022H001A3H001B022H001C022H00013H001D022H001D022H001A3H001E022H001E022H001B3H001F022H0020022H00013H0021022H0023022H001B3H0024022H0026022H001C3H0027022H0028022H00013H0029022H002A022H001C3H002B022H002C022H00013H002D022H002E022H001D3H002F022H0030022H00013H0031022H0031022H001D3H0032022H0032022H001E3H0033022H0034022H00013H0035022H0036022H001E3H0037022H0037022H00213H0038022H0039022H00013H003A022H003A022H00213H003B022H003C022H00013H003D022H003D022H00223H003E022H003F022H00013H0040022H0040022H00223H0041022H0042022H00013H0043022H0045022H00223H0046022H004B022H00013H004C022H004C022H001F3H004D022H004E022H00013H004F022H004F022H001F3H0050022H0051022H00013H0052022H0052022H00203H0053022H0054022H00013H0055022H0055022H00203H0056022H0057022H00013H0058022H0058022H00203H0059022H005A022H00013H005B022H005B022H00203H005C022H005D022H00013H005E022H005E022H00203H005F022H0060022H00013H0061022H0062022H00213H0063022H0064022H00224H00D00C02008DE727D3671F44C470C41F91D1A5111FCE0E2HCE32FBBB2HFB072H1813181B2H251C576122A2185461CF931DBC12ACFFFC4D1AB98F307947365705E5506304C8BC64C0C1941F2C4D6E08CF1A2HCAFB4A1FB7772HB70C94546BEB1FE12H61633E1EDE2F9E1F4BCB57CB1FE8A464260575B474751B72B27DF21FDF1F5A5F073H3CBC1F89492H09072H06C4C61B2H738D0C1F3H9010593H9D1D1F9ADA241A2C07C78287072HE4F2641F3HB13159EE2E6B6E073H9B1B1F38F82HB8072H05C7C51B023HC23AEFD262154A8C4D8D8C1B59582H593AD6FF19B9338302C7C31B20612H603AED296DBC2FEA6AEB6A143HD7571FB47449342C81C179FE1F7EBEB9BE1B2B3HEB3A48AA8FBF5C3H9515593H12921F7F3FC5FF2C5C9CD9DC073HA9291FE6262H66072HD311131BB071B1B01B3D3C2H3D3A7ACAF4CD4667A62F271BC4852H843AD1126217058E0E8F0E142HBB323B0798585F581B6525901A1F62A363621B4F4E2H4F3A2C78077307B938FFF91BF6B72HB63AE38157475080008100143H8D0D1F2H8A7F0A2C2HF77E77073HD4541FA1612H21079E5E595E1B4B3H8B3AA8D01D9C473H35B5592HB2B3321FDF5E2H9F1B3C7D2H7C3AC9B557B1408606870614B3F3B2331FD0105550072H1DDFDD1B9A3H5A3A8748351E0E24E525241B713177F11F2H2EA7AE073HDB5B1F78B82HF807C58500051BC23H023A6F4C95456B3H4CCC593H99191FD65632562C83430603073HA0201FAD6D2H2D072H6AA8AA1B17D616171B74752H743A81225B7835BE7FFDFE1B6B2A2H2B3AC8E0BC3407D555D455143H52D21FBFFF433F2C2H9C151C07E92904961F2H66A4A61B5313A12C1FB071F2F01B3D7C2H7D3ABA928AE646E767E667143HC4441F91112E112C2HCE474E073H7BFB1F18D82H98076525A2A51BA2E244DD1F0F8F8D8F073H6CEC1FB9792H39072H36F3F61B633HA33AC006B119453H4DCD59CA8A4D4A07773HB7343H941459E1216B61071EDE1E9E2D3HCB4B1F6828CEE82C75B5F6F507323HF2341FDF5FDF633C453894073H0989593H46C61F73B3B4F32C10509890073H1D9D1F1ADA2H9A07C7472H07483HE464592H312HB1073HEE6E1F9B5B2H1B07F83H38343HC545593H42C21FAF6F2D2F2C8C0C040C072H19D0D91B3H1696593H43C31F2H60EAE02CED6D646D072H2AE3EA1B973H573AB484C71F0C3H8101592HBE343E072HAB626B1B483H883A55E876B4413H1292593H7FFF1F2HDC5E5C2CA93H29072H26EFE61B533H933A305F15023B3H3DBD593H3ABA1F2767EBA72C2H840004072H9158511B4E3H8E3A3B083B15703H58D8592H65E4E5073HE2621F4F8F2HCF076C3HAC34B979F97963B6FCCFE41C3H63E35900C08580072HCD0F0D1B8ACB8E8A1BF7F62HF73A14D3ADA20BE120A7A11B5EDE5FDE140BCBC4741FA8682HA80C35B535A13E32B275B22H1F9FD0601FFC2H7C723EC989E7491F86C686061FB3732HB30CD0502EAF1F5DDD7ADD1F5ADAD3DA072H874D471B643HA43A314788BF603HAE2E592HDB515B073H78F81F05C52H85072H4288821BAF3H6F3ACC9ADFBA3F3H9919593HD6561F03C3F5832CA03H20072H6DA7AD1B3HAA2A593H97171F2H7499F42C2HC14541077EFE7FFE1F2BEBAEAB07C80837B71F2H15D7D51B123HD23AFF04F9633D9CDD989C1B69A960E91F2HE62C261B3H53D3593H70F01F7DBD87FD2C2HFA7B7A073HE7671FC4042H4407513H91340ECE4ECE637B92905E633H98185925E5DA5A1FA2622A2207CF3H0F34EC6CEF6C1F3979BEB9073H76F61FA3632H230700802HC0484D8D48CD1F0A3HCA343HB737593H94141F61E1FCE12C9E1E161E072H8B484B1BA83H683A755E2AFC4D3HF272595F1FAE201F3HBC3C592H09FF761F46C647C6142H7372F31FD03H10345D9D1D9D635A2CDBC2583H078759E4A4E6641F31718D4E1F2E2H6F6E1B9BDB66E41F2H382HB807C5053CBA1F3H42C2592FEFA5AF070CCC0C8C2DD9195A59072H16EA691F4303CBC3073H60E01F6DAD2HED07AA2A2H6A48173HD73AF428E4F00C3H0181592HBE42C11F6BAB2H6B0C3H08881F95552H1507122H92963EFF3F49801FDC1CFA5C1F29A9A0A9072H666DE61F933H13073HB0301FBD7D2H3D072H7AB3BA1B3HA727593H84041F51D1AAD12C2H8E0A0E072HFB323B1B983H583AA549501D643HE262594F8FB0301F2HAC2D2C073HF9791F36F62HB607A33H6334C000800063CD6C202A223H8A0A59F7377277073HD4541FA1612H21072H9E5C5E1B8BCA8F8B1BA8A92HA83A351FC8C14FF2F3BBB21BDF9E2H9F3AFC76448563C949C849142H06A8791F733HB3349050D050635D435320063HDA5A593HC7471FA4E41A242CF1B17971073HAE2E1F5B9B2HDB0738B82HF84805C503851F3H820259EF6F1B901F2H0CC5CC1B3H1999592HD65C56072HC30A031B2HA05EDF1F3HAD2D593HAA2A1F97D713172CF4B47374073HC1411F7EBE2HFE07EB3H2B343HC84859D5155F55073H52D21FBF7F2H3F079C5C9C1C2D3HE9691F2H26EBA62CD313505307F0B0078F1FFD7D7F7D073HFA7A1FE7272H67072H04C1C41B1191EB6E1F3HCE4E593H7BFB1F1858CD982C2H252HA5073HA2221F0FCF2H8F07AC3H6C343HB939593HF6761F23E3ECA32CC0404840073HCD4D1FCA0A2H4A072H77BEB71BD43H143A610E6E1C183H1E9E592HCB22B41F68A82H680CF575F5793EF232148D1F2HDF03A01FBCFDB8BC1B89882H893A0665F99107B3F2F0F31BD0912H903A5DC09E92221A9A1B9A143H07871FE4245E642CB1F12DCE1F3H6EEE592H9B2H1B07F8782H38483HC54559C2424A42072FEFD0501F2HCC0F0C1BD999CB591F563H96344303BE3C1F60E0E9E0073H6DED1F6AAA2HEA072H9754571B743HB43A8158A2C4633HBE3E593H6BEB1F08C896882C2H159F95072H5291921BBF3H7F3ADCF5CF20183HA929593HE6661F13D3BE932CB03H30073HBD3D1FBA7A2H3A0767E7A1A71B3H8404593H51D11F0ECE978E2C2H3BBFBB073HD8581F65A52HE50722A2E4E21B0F3HCF3AAC3C0C8B623HF9795936F6C9491F2H63E2E30780C083001FCD4D2H0D484A3H8A3AF77AD2BE103HD454593HA1211F5E1ECFDE2C8BCB030B072H28DD571FB535373507F23237321BDF3H1F3AFCA78F631F3H49C95986C685061FF3732H33483H50D0593H5DDD1F5A1AC7DA2CC7074F47073HA4241F71B12HF107EE3H2E349B5BDB5B63F8FADEC4463H05855902C28782072HAF6D6F1B4CCCA7331F99D91E19073HD6561F03C32H8307E0602H20486D3HAD3A6A2042496C3H1797593HF4741F2HC12F412CFE3E7D7E072HAB5DD41F3H48C859D59538AA1F52922H520CBF3FBF373E9CDC19E31F69297BE91F2HE624261B133HD33AB0E897DE5CFD3CFCFD1B3ABB7C7A1BA7E62HE73A04CDDFD7221191109114CE4EDF4E1F7BFB7AFB143H18981FA5E576252C2H22A15D1F4FCE2H0F1B6CEC6DEC142H39B0B9073H76F61FA3632H23070040C5C01B8D3H4D3A8A111F1A0C3HB737593H94141F2H61B8E12C9E5E1B1E073H4BCB1FE8282H68072HB577751BB23H723A9FC96651423CFD3D3C1B09082H093AC69765563033F270731B90109110143H9D1D1F9A1A681A2C2H078E8707E4241B9B1FF13136311B3HEE6E591BDB9E9B072H78BAB81B053HC53A82B013D839AF6EAEAF1BCC0D848C1B19582H593A165A01802243C342C3142HE06960073HED6D1FEA2A2H6A0717D7D0D71B3HB434593H81011F2H3EEEBE2C6BABEEEB072H08F9771F2H951C15073H12921F7FBF2HFF071C5CDBDC1B693HA93AE68567CB1D3H9313593HB0301FBD3D5A3D2C3AFABFBA073H27A71F04C42H84072H11D3D11B0ECF0F0E1B2H3B3CBB1FD8185D58073H65E51FE2222H62072H8F4D4F1B2CED2D2C1B2HF916861F2H36BFB6073H63E31F80402H00074D8D8A8D1BCA3H0A3AB72607A12F3H54D4593H21A11FDE1E0F5E2C0BCB8E8B073HA8281F35F52HB5072H72B0B21B5F3H9F3A7C66594F61498848491B06072H063AB3E203415810D152501B9DDC2HDD3ADA22F6E83147C746C71424E4D05B1F31B075711BAE6E49D11F06004AC06E38017BB371950A0200F1DBE41D3H00A26F6C9990F24B8D5FDEC4F3AF3E08B3C769F60FE6737638E77EB9D886F38HFFE4253H00FB38A54280FA942422BF7AECEB4A83C8F4385C6AB7BFDEE9221656BC47CE17D36B4660ABA6E4263H00ACD936C3727F12B06A53DACA541AABF976C55E4337173ED7ADFC446CC3B3BA02D6F6E90A8429E4213H002A77F4A1AD8AF1482818372F9BDE5301D76883FD0EC1FCC76648776669BAB74886E4093H001794411EF2F31F311EE4173H003C69C653CF26DC877A99E390F48F7C92F9E4BEC1AE215CE40B3H00B734E1BEDC72A0FED49C4CE4183H0066F3B09D642EE73B369686F4CE785F3AE26427FE7122965DE4073H005E6BA8153CA9D1E44F3H00A9069350AB1F8E2BA861D3D88FC0459D271A430B1E2D426BE3A29043CE0DCA376ED30269BF0B8CEFE8F4C387001CC35E7102CDCFD02CC332A7AF42088ADDC3AB750247FEEB5AD166EE69C2CFC0DC0DE40A3H000C399623D99C2F9EC92AE41B3H003E4B88F565EA6100F028E767231EA359BF78D3A6572A448E5B5412E4213H006D8AD754E8B254DC2A87FA9493B2C3204C30BC02DFF2CEADA8911E612F7E88EBBEE43B3H002A77F4A16633365FD0955BC4F7C6475B7DF2DBEA57F5AB4CBFBEE87684F3CA03BB5C7B462276BB4C4A13BB34F7831E8AEBF61B38D507DE717A2150596H0014C0E4063H00B916A3604CA5E40A3H00B734E1BE782A6F5E6F5CE4203H000966F3B0D8B6ABDBD204DFDB08101AC38465B1BBE2808B9635C072FB6C160EBCE41C3H00A90693506C76E3470242B0EB2AFCF7B48762706FBE0CE30748842C25E40B3H00B5521F1C57DE49B6067783E4103H00C4714E5B07D5AE0C24AA2DDE6582890FF348F46HFFE40A3H0014C19EABBCC2ED5A0A7AE4083H0046D3907D0D5231D8596H0024C0E4223H00EEFB38A5B9462D4CC4ECD3A38F027F45CB9CE77637935D820B9E04F7C2D19E47F4CEE43F3H00D845E2AFC0BF426B2CB1A7F8138D9E714C57AA9BD7DA1C2322D55E67BA1BFE8943A4D8375CBFCE27E42239E4000F5A7D86D4631460DF5922B0821667B65C24F330F86HFFE4093H00DB188522E2B2AF4AD8F378EC6HFFE4193H00C0ADCA1759A8F786EF5D8ED4C82FC60734A8BA8D2A252B860FE4273H0025C28F8CB05ABCB452FFD23CFBAAFBD824D8E45AE79EA1033A4FAEBB816A5CFCD65944BCD2972AE41C4H00ED0A5750FA3B8AA1734EEDCA0CB6FA3F4BEE1CABCB7C980766536EE4473H00CCF956E37DBBEE0F48CDE3D49F66063BEE94339A2FF86C2H81C2D452ED6A00160428DDC722FEA78646CB63868D6A8331689BE382FD1FE6DD071F92896B6A83DCA6F79A43AEFF78E4253H0037B4613E10BA4C5CD20F12C49B8A8BA0244852D912D933BA5685E35EE7127B7D12789C7221E4263H00289532FFCC2238FCE6472E5437A25F2050D088A2BB87F251268E62E4BB26ABBBCFF55AAB7AA6E4223H0026B3705D554A71A010687797739EB3997F58439AD28F7AA07FDA2023DEADD23BA08AE4083H0010FD1A67005A0AC3598H004FE4273H00B825C28F5806B4A03AFB5A50C306436CBCFCCC2F1E46759093DE3BEC5CB446EEFBE32A17E25722E4273H004300ED0A14EE80485E7356587FFE57D4D8E4A0BE030C72D8FC56772EB55066758B04C0D8366356596H0008C0E392FAB66B4H00024B007B4F2D770B3H00013H00083H00013H00093H00093H009D0C19010A3H000A3H0046E87E2H0B3H000B3H005F3C3B4F0C3H000C3H00A540521F0D3H000D3H00F6B0C3180E3H000E3H00956FF64F0F3H000F3H00652F9E38103H00103H002C26540A113H00143H00013H00153H00163H00054H00820A02004FDB5BD85B1FBAFAB93A1F2HE9EA691F682869683237F72H37072H5657561B2HC57DB76184C4BFF06193CEABA271327C2B8526E15488595CA04F499141AFED7F45234E09D8E46AFDCAAEC94C7C7D1015084H4B072H6A2H2A1B193H593A986FAFFC1EA72H27A759463676D95C02003CE9ED1185B1525C6B0A0200E9EFE4183H00FE1B806DE44E4FE37646AEAC4E58A7F26234FF76F142FEE5E4143H00563358057A41DBDC1BF824431ACBFE4F6188731EBD4F36720F5H003B00FD51A06300570219BBE163009002E5C02D69",665,1205821966,970,bit,786496179,"\95\95\109\111\100\101",275,"\46\46",next,284,"\95\95\115\117\98",282824343,"\96\102\111\114\96\32\115\116\101\112\32\118\97\108\117\101\32\109\117\115\116\32\98\101\32\97\32\110\117\109\98\101\114",65536,"\98\110\111\116",pcall,"\40\105\110\116\101\114\110\97\108\41",true,422,688994799,"\99\104\97\114",getfenv,false,"\115\116\114\105\110\103",...);