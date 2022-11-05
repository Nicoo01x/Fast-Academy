ESX = nil 
Citizen.CreateThread(function() 
    while ESX == nil do 

        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0) 
    end 
end)

local kills = 0
local deaths = 0

local isDead = false
local istInDimension = false

local display = false
local isMenuOpen = false
local notify = false
local hasRun = false
local isDead = false


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(24)
  
        if (not isDead and NetworkIsPlayerActive(PlayerId()) and IsPedFatallyInjured(PlayerPedId())) then
            isDead = true
            DisableControlAction(   46, true)
        elseif (isDead and NetworkIsPlayerActive(PlayerId()) and not IsPedFatallyInjured(PlayerPedId())) then
            isDead = false
            EnableControlAction(   46, true)
        end
    end
  end)

  RegisterCommand("salirffa", function ()
    if istInDimension and not isDead then
    Citizen.CreateThread(function (dimension)
    local dimension = Config.Teleports.standart.dimension
    SetEntityCoords(PlayerPedId(), Config.marker, false, false, false, false)
    TriggerServerEvent('zon_ffa:setDimension', dimension)
    TriggerServerEvent('zon_ffa:saveInfo', kills, deaths)
    TriggerEvent('removeloadout')
    TriggerServerEvent('removein', source)
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
    drinnen = false
    end)
end
end, false)


RegisterNetEvent("zon_ffa:addKill")
AddEventHandler("zon_ffa:addKill", function()
  kills = kills + 1
end)

RegisterNetEvent("zon_ffa:addDeath")
AddEventHandler("zon_ffa:addDeath", function()
deaths = deaths + 1
end)

RegisterNetEvent("squit")
AddEventHandler("squit", function(source)
    ExecuteCommand("salirffa")
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if istInDimension then     
            DisableControlAction(0, 47, true) -- G
            DisableControlAction(0, 29, true) -- B
        end
    end
end)


RegisterCommand("ffarifles", function ()
    local coords = Config.Teleports.pr.spawnpoints[math.random(#Config.Teleports.pr.spawnpoints)]  
    local dimension = Config.Teleports.pr.dimension 
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
    TriggerServerEvent('zon_ffa:setDimension', dimension)
    TriggerEvent('loadoutRifles')
    TriggerServerEvent('insertin')
    DisplayPoints()
end)

RegisterCommand("ffapistola", function ()
    local coords = Config.Teleports.wp.spawnpoints[math.random(#Config.Teleports.wp.spawnpoints)]
    local dimension = Config.Teleports.wp.dimension 
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
    TriggerServerEvent('zon_ffa:setDimension', dimension)
    TriggerEvent('loadoutPistola')
    DisplayPoints()
end)

function TeleportSP(coords, dimension) -- SKATEPARK
    local coords = Config.Teleports.pr.spawnpoints[math.random(#Config.Teleports.pr.spawnpoints)]  
    local dimension = Config.Teleports.pr.dimension 
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
    TriggerServerEvent('zon_ffa:setDimension', dimension)
    TriggerEvent('loadoutRifles')
end

function TeleportWP(coords, dimension) -- WUERFELPARK
    local coords = Config.Teleports.wp.spawnpoints[math.random(#Config.Teleports.wp.spawnpoints)]
    local dimension = Config.Teleports.wp.dimension 
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
    TriggerServerEvent('zon_ffa:setDimension', dimension)
    TriggerEvent('loadoutPistola')
end


function TeleportFR(coords, dimension) -- FLUEGZEUGHAFEN
    local coords = Config.Teleports.fr.spawnpoints[math.random(#Config.Teleports.fr.spawnpoints)]
    local dimension = Config.Teleports.fr.dimension 
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
    TriggerServerEvent('zon_ffa:setDimension', dimension)
    TriggerEvent('loadoutRifles')
end


RegisterCommand("menuFFA", function ()

    ESX.TriggerServerCallback('getpindi', function(count)
        local eins = count.eins
        local zwei = count.zwei
        local drei = count.drei
        local vier = count.vier
        
         
  
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
        title = "FFA",
        align = "right",
        elements = {
            {label = "FFA Pistola | Jugadores: " .. zwei .. "/70", value='teleport_wuerfelpark'},
           -- {label = "FFA Rifles | Jugadores: " .. drei .. "/70", value='teleport_skatepark'},
        }
    }, function (data, menu)
        ESX.UI.Menu.CloseAll()
            RemoveAllPedWeapons(PlayerPedId(), true)
            if data.current.value == 'teleport_wuerfelpark' then

                    if count.zwei < 70 then
                        TriggerServerEvent('insertin')
                        TeleportWP() --wuerfelpark
                        DisplayPoints()
                    elseif count.zwei >= 70 then
                        --TriggerClientEvent('okokNotify:Alert', source, "Zon Development", "Ya hay 70 personas en esta lobby", 5000, 'info')
                        TriggerEvent('esx:showNotification', source 'Ya hay 70 personas en esta lobby')
                    end
                
                
                
            end
            if data.current.value == 'teleport_skatepark' then
                
               
                    if count.drei < 70 then
                        TriggerServerEvent('insertin')
                        TeleportSP() --skatepark
                        DisplayPoints()
                    elseif count.drei >= 70 then
                        --TriggerClientEvent('okokNotify:Alert', source, "Zon Development", "Ya hay 70 personas en esta lobby", 5000, 'info')
                        TriggerEvent('esx:showNotification', source 'Ya hay 70 personas en esta lobby')
                    end
               
            
            end
            if data.current.value == 'teleport_fluegzeug' then
                
               
                if count.vier < 70 then
                    TriggerServerEvent('insertin')
                    TeleportFR() --flugzeug
                    DisplayPoints()
                elseif count.vier >= 70 then
                    --TriggerClientEvent('okokNotify:Alert', source, "Zon Development", "Ya hay 20 personas en esta lobby", 5000, 'info')
                    TriggerEvent('esx:showNotification', source 'Ya hay 20 personas en esta lobby')
                end
           
        
        end
            
        
        
        
    end, 
    function (data, menu) 
        menu.close()
        
    end)

end)
end)

local dimensionCliente = 0
RegisterNetEvent("comprobardimension")
AddEventHandler("comprobardimension", function(dimension)
    dimensionCliente = dimension
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    if istInDimension then
        TriggerServerEvent('killed', data.killerServerId)
        --print("hola")
        --if dimensionCliente == 31 or dimensionCliente == 32 or dimensionCliente == 33 then
         --   print("hola2")
            
            for k, f in pairs(Config.Teleports) do
                if GetDistanceBetweenCoords(f.spawnpoints[1], GetEntityCoords(PlayerPedId()), true) <= 500.0  then
                    local coords = f.spawnpoints[math.random(#f.spawnpoints)]
                    SetEntityCoords(PlayerPedId(), coords, false, false, false, false) 
                end
            end
            Wait(600)
            TriggerEvent('esx_ambulancejob:revive')
            Citizen.Wait(1000)
            TriggerEvent('weapontrigger')
            TriggerEvent('weapontrigger2')
            TriggerEvent('weapontrigger3')
            AddArmourToPed(PlayerPedId(), 200)
            SetEntityHealth(PlayerPedId(), 200)
            SetPedArmour(PlayerPedId(), 200)
            NetworkSetFriendlyFireOption(false)
            SetCanAttackFriendly(PlayerPedId(), false, false)
            --SetEntityInvincible(PlayerPedId(), true)
            
            NetworkSetFriendlyFireOption(true)
            SetCanAttackFriendly(PlayerPedId(), true, true)
            AddAmmoToPed(PlayerPedId(), 0x61012683, 700)
            AddAmmoToPed(PlayerPedId(), 0xAF113F99, 700)
            AddAmmoToPed(PlayerPedId(), 0x83BF0278, 700)
            AddAmmoToPed(PlayerPedId(), 0x22D8FE39, 700)
            AddAmmoToPed(PlayerPedId(), 0xD205520E, 700)
            EnableControlAction(0, 21, true)
            RemoveAllPedWeapons(PlayerPedId(), false)
			GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_pistol_mk2"), 200, true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_pistol_mk2"), true)
            --SetEntityInvincible(PlayerPedId(), false)
        --end
    end
end)


-- LOBBY


--local blips = {
  --  {title="FFA", scale=1.0, colour=0, id=433, x = 599.4, y = 2744.37, z = 42.06}
 --}

Citizen.CreateThread(function(name)
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

local firstspawn = true
AddEventHandler('playerSpawned', function(spawn)
if not firstspawn then
    firstspawn = true
    while GetEntityModel(PlayerPedId()) ~= 1885233650 do
    Citizen.Wait(200)
      
    end
    RemoveAllPedWeapons(PlayerPedId(), false)
end
end)
-- WICHTIG !! ZONE

local function insidePolygon( point)
    local oddNodes = false
    for i = 1, #Config.Zones do
        local Zone = Config.Zones[i]
        local j = #Zone
        for i = 1, #Zone do
            if (Zone[i][2] < point.y and Zone[j][2] >= point.y or Zone[j][2] < point.y and Zone[i][2] >= point.y) then
                if (Zone[i][1] + ( point[2] - Zone[i][2] ) / (Zone[j][2] - Zone[i][2]) * (Zone[j][1] - Zone[i][1]) < point.x) then
                    oddNodes = not oddNodes;
                end
            end
            j = i;
        end
    end
    return oddNodes 
end

RegisterNetEvent('heal')
AddEventHandler('heal', function ()
    TriggerEvent('weapontrigger2')
    TriggerEvent('weapontrigger3')
    SetPedArmour(PlayerPedId(), 200)
    SetEntityHealth(PlayerPedId(), 200)
end)


-- Citizen.CreateThread(function()
--     while true do
--         local iPed = PlayerPedId()
--         Citizen.Wait(0)
--         point = GetEntityCoords(iPed,true)
--         local inZone = insidePolygon(point)
--         if Config.ShowBorder then
--             drawPoly(inZone)
--         end
--         if inZone then
--             for _, players in ipairs(GetActivePlayers()) do
--                 if IsPedInAnyVehicle(GetPlayerPed(players), true) then
--                     veh = GetVehiclePedIsUsing(GetPlayerPed(players))
--                     SetEntityNoCollisionEntity(iPed, veh, true)
--                 end
--             end
--             hasRun = false
--         else
--             if not hasRun and istInDimension then
--                 hasRun = true
--              Citizen.Wait(44)
--              SetEntityHealth(PlayerPedId(-1), 0)
--              TriggerEvent('notify', '4', 'FFA', 'Has muerto por salir a la zona roja.')
--                 end
--             end
--         end
-- end)

function DisplayHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringKeyboardDisplay(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end


function drawPoly(isEntityZone)
    local iPed = PlayerPedId()
    for i = 1, #Config.Zones do
        local Zone = Config.Zones[i]
        local j = #Zone
        for i = 1, #Zone do
                
            local zone = Zone[i]
            if i < #Zone then
                local p2 = Zone[i+1]
                _drawWall(zone, p2)
            end
        end
    
        if #Zone > 2 then
            local firstPoint = Zone[1]
            local lastPoint = Zone[#Zone]
            _drawWall(firstPoint, lastPoint)
        end
    end
end

  function _drawWall(p1, p2)
    if istInDimension then
        
    local bottomLeft = vector3(p1[1], p1[2], p1[3] - 1.5)
    local topLeft = vector3(p1[1], p1[2],  p1[3] + Config.BorderHight)
    local bottomRight = vector3(p2[1], p2[2], p2[3] - 1.5)
    local topRight = vector3(p2[1], p2[2], p2[3] + Config.BorderHight)
    
    DrawPoly(bottomLeft,topLeft,bottomRight,255,0,0,15)
    DrawPoly(topLeft,topRight,bottomRight,255,0,0,15)
    DrawPoly(bottomRight,topRight,topLeft,255,0,0,15)
    DrawPoly(bottomRight,topLeft,bottomLeft,255,0,0,15)
end
  end

  RegisterNetEvent('loadoutPistola')
  AddEventHandler('loadoutPistola', function ()
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger2')
      TriggerEvent('weapontrigger3')
      SetEntityHealth(PlayerPedId(-1), 200)
      SetPedArmour(PlayerPedId(-1), 200)
      GiveWeaponToPed(PlayerPedId(-1), 0xBFE256D4, 700, 0, 0)
      --exports['okokNotify']:Alert("Zon Development", "Has entrado en el FFA, recuerda que puedes usar /salirffa para volver al lobby", 5000                             , 'info')
      ESX.ShowNotification("Has entrado en el FFA, recuerda que puedes usar /salirffa para volver al lobby")
      
      istInDimension = true
  end)

  RegisterNetEvent('loadoutRifles')
  AddEventHandler('loadoutRifles', function ()
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger2')
      TriggerEvent('weapontrigger3')
      SetEntityHealth(PlayerPedId(-1), 200)
      SetPedArmour(PlayerPedId(-1), 200)
      GiveWeaponToPed(PlayerPedId(-1), 0x78A97CD0, 700, 0, 0)
      GiveWeaponToPed(PlayerPedId(-1), 0x394F415C, 700, 0, 0)
      GiveWeaponToPed(PlayerPedId(-1), 0xFAD1F1C9, 700, 0, 0)

     -- TriggerClientEvent('okokNotify:Alert', source, "Zon Development", "Has entrado en el FFA, recuerda que puedes usar /salirffa para volver al lobby", 5000, 'info')
      ESX.ShowNotification("Has entrado en el FFA, recuerda que puedes usar /salirffa para volver al lobby")
      
      
      istInDimension = true
  end)
  
  RegisterNetEvent('removeloadout')
  AddEventHandler('removeloadout', function ()
    TriggerEvent('weapontrigger2')
    TriggerEvent('weapontrigger3')
      SetEntityHealth(PlayerPedId(-1), 200)
      SetPedArmour(PlayerPedId(-1), 0)
      RemoveWeaponFromPed(PlayerPedId(-1), 0xBFE256D4)
      RemoveWeaponFromPed(PlayerPedId(-1), 0x78A97CD0)
      RemoveWeaponFromPed(PlayerPedId(-1), 0x394F415C)
      RemoveWeaponFromPed(PlayerPedId(-1), 0xFAD1F1C9)
     -- TriggerClientEvent('okokNotify:Alert', source, "Zon Development", "Has Abandonado el FFA", 5000, 'info')
      ESX.ShowNotification("Has abandonado el FFA")
      TriggerEvent('ffahud:off', true)
      istInDimension = false
  end)

function DisplayPoints()
    drinnen = true
while true do
Citizen.Wait(350)
if drinnen then
    DisableControlAction(0, 29, true)
    DisableControlAction(0, 47, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 38, true)
    DisableControlAction(0, 46, true)
    DisableControlAction(0, 51, true)
    DisableControlAction(0, 54, true)
    DisableControlAction(0, 86, true)
    DisableControlAction(0, 103, true)
    DisableControlAction(0, 119, true)
    DisableControlAction(0, 153, true)
    DisableControlAction(0, 184, true)
    DisableControlAction(0, 206, true)
    DisableControlAction(0, 350, true)
    DisableControlAction(0, 351, true)
    DisableControlAction(0, 355, true)
    DisableControlAction(0, 356, true)
    
end
end
end



  