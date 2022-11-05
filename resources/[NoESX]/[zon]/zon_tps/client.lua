
ESX = nil
local DISTANCIA = 2
local DISTANCIA_INTERACCION = 2.0
local MARKER_SIZE = 1.0
local E_KEY = 38

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(50)
        principal()
    end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

texto = false


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function abrirMenu()
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
                for k,v in pairs(gangData.points) do
                    if v.type == "Save Vehicles" then
                        --print(vector3(v.coords.x, v.coords.y, v.coords.z))
                        SetEntityCoords(PlayerPedId(), vector3(v.coords.x, v.coords.y, v.coords.z))
                    end
                end
                print("Banda: "..gangName)
            else
                --exports['okokNotify']:Alert("Zon Development", "No estás en ningúna banda", 4000, 'info')
                ESX.ShowNotification("No estás en ningúna banda")
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para abrir el Menu de TPS", vector3(127.6848, -1055.1492, 29.1924))
            end
        end)  
    end
end

-- ESX.UI.Menu.CloseAll()

-- ESX.UI.Menu.Open(
--     'default', GetCurrentResourceName(), 'tpmenu',
--     {
--         title    = 'Menu de teletransporte',
--         align    = 'bottom-right',
--         elements = elements
--     },
--     function(data, menu)
--         if data.current.label == "Volver" or data.current.label == "-----------------------------" or data.current.label == "s" then
--             menu.close()
--         else
--             local coordenadas = { x = data.current.x,  y = data.current.y, z = data.current.z}
--             ESX.Game.Teleport(PlayerPedId(), coordenadas)
--             ESX.ShowNotification("Fuiste teletransportado con exito a " .. data.current.label)
--         end
--         menu.close()
--       end,
--       function(data, menu)
--         menu.close()
--       end
--     )


--- MARKER Y NPC

Config = {}

-- CONFIG BLIP

local blips = {
        --{title="Teletransportes", colour=5, id=36, x = 103.1468, y = -1057.489, z = 29.32272},
        --{title="Tienda de ROPA", colour=5, id=73, x = -155.587, y=  1591.163, z= 7.174175},
        {title="Comisaria", colour=3, id=60, x=641.7626, y=-2.30769, z=82.77808},
        --{title="OTRO", colour=5, id=36, x = 130.12, y= -1055.3, z= 29.19},
}

-- CONFIG PEDS

Config.Peds = {
    {
        
        name = '1',
        id = 133,
        pos = vector3(127.6848, -1055.1492, 28.1924),
        h =  243.8865,
        color = 2,
        scale = 0.8,
        model = 's_m_m_highsec_02',
        animation = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
        

    }
   -- {
     --   name = '2',
     --   id = 204,
   --     pos = vector3(-441.2578, 1595.3043, 358.4680),
   --     h = 236.2204,
  --      color = 2,
    --    scale = 0.8,
    --    model = 's_m_y_prismuscl_01',
    --    animation = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
    --}
    --[[ PARA CREAR OTRO,

        name = '1',
        id = 133,
        pos = vector3(130.12, -1055.3, 29.19),
        h = 237.05,
        color = 2,
        scale = 0.8,
        model = 'a_m_y_acult_02',
        animation = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
    --]]
}


-- MAIN CODE

local cur_distance = nil

function principal()
    for _, ped in pairs(Config.Peds) do
        if ped.model ~= nil then
            local modelHash = GetHashKey(ped.model)
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(1)
            end
            local SpawnedPed = CreatePed(2, modelHash, ped.pos, ped.h, false, true)
            TaskSetBlockingOfNonTemporaryEvents(SpawnedPed, true)
            Citizen.Wait(1)
            if ped.animation ~= nil then
               -- TaskStartScenarioInPlace(SpawnedPed, ped.animation, 0, false)
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

    function spawnMarker(ped, coords)
        
        local cur_distance = GetDistanceBetweenCoords(coords, ped.pos, true)
        if cur_distance < DISTANCIA then
            ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para abrir el Menu de ~b~TPS", vector3(127.6848, -1055.1492, 29.1924))
            --DrawMarker(1, ped.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, MARKER_SIZE, MARKER_SIZE, 0.4, 102, 0, 204, 50, false, false, 2, false, false, false, false)
            
             texto = true
            if cur_distance < DISTANCIA_INTERACCION then
                if not HasAlreadyEnteredMarker then
                    currentZone = ped.name
                    HasAlreadyEnteredMarker = true
                end
                if HasAlreadyEnteredMarker then
                    PlayerData = ESX.GetPlayerData()
                    
                    if IsControlPressed(0, E_KEY) then
                        texto = false
                        abrirMenu()
                        --print("s")
                        --exports['okokNotify']:Alert("Zon Development", "No estás en ningúna banda", 4000, 'info')
                        
                    end
                end
            elseif ped.onExit ~= nil and HasAlreadyEnteredMarker and ped.name == currentZone then
                HasAlreadyEnteredMarker = false
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para abrir el Menu de TPS", vector3(127.6848, -1055.1492, 29.1924))
                menu.close()
            end
        end
    end
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            local coords = GetEntityCoords(PlayerPedId())
            for _, ped in pairs(Config.Peds) do 
                spawnMarker(ped, coords)      
            end
        end
    end)

end

-- BLIPS CODES

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.8)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)



function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY, r,g,b)
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