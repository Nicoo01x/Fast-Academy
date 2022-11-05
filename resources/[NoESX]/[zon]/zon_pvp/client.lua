ESX = nil
local DISTANCIA = 2
local DISTANCIA_INTERACCION = 2.0
local DISTANCIA2 = 2
local DISTANCIA2_INTERACCION = 2.0
local MARKER_SIZE = 1.0
local E_KEY = 38
local victorias = 0
local derrotas = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		principal()
		--principal2()
	end
end)


counter = 0 
contador = false
ronda = 0

-- MENSAJES
RegisterNetEvent("zon_pvp:msg")
AddEventHandler("zon_pvp:msg", function(numero)
	--notify("Estás en la arena: ~b~#"..numero) 
    ESX.ShowNotification("Estás en la arena: #"..numero)
	SetGameplayCamRelativeHeading(0)
	FreezeEntityPosition(PlayerPedId(), true)
	FreezeEntityPosition(PlayerId(), true)
	contador = true
	Wait(3000)
	FreezeEntityPosition(PlayerPedId(), false)
end)


RegisterNetEvent("zon_pvp:msgWon")
AddEventHandler("zon_pvp:msgWon", function()
    --exports['okokNotify']:Alert("Zon Development", "Has Ganado!", 3500, 'success')
    ESX.ShowNotification("Has ganado!")
    local id = GetPlayerServerId(PlayerPedId())
    TriggerServerEvent('zon_pvp:killed2', id)
	SetGameplayCamRelativeHeading(0)
    counter = 0
end)

RegisterNetEvent("zon_pvp:msgLost")
AddEventHandler("zon_pvp:msgLost", function()
    --exports['okokNotify']:Alert("Zon Development", "Has Perdido!", 3500, 'error')
    ESX.ShowNotification("Has perdido!")
    SetGameplayCamRelativeHeading(0)
    counter = 0
end)

RegisterNetEvent("zon_pvp:msgQuit")
AddEventHandler("zon_pvp:msgQuit", function()
    exports['okokNotify']:Alert("Zon Development", "El contrincante se ha desconectado, por lo que has ganado!", 3500, 'success')
	--notify("El contrincante se ha desconectado, por lo que has ganado ^^")
	SetGameplayCamRelativeHeading(0)
end)

-- Player a cola
RegisterNetEvent("zon_pvp:pvpqueue")
AddEventHandler("zon_pvp:pvpqueue", function(ident)
    if (ident==0) then
        ----print("si o no")
		counter = -1
        --exports['okokNotify']:Alert("Zon Development", "Has abandonado la cola", 3500, 'success')
		ESX.ShowNotification("Has abandonado la cola")
		counter = -1
        TriggerServerEvent("zon_pvp:counter1v1", source)
        ESX.UI.Menu.CloseAll()
        ----print(counter)
	end
	if (ident==1) then
		if (counter == 0) then
            --exports['okokNotify']:Alert("Zon Development", "Entraste en cola de (1v1)", 3500, 'success')
            ESX.ShowNotification("Entraste en cola de (1v1)")
			TriggerServerEvent("zon_pvp:counter1v1", source)
			counter = 1
		else 
            --exports['okokNotify']:Alert("Zon Development", "Ya estas en la cola", 3500, 'success')
			ESX.ShowNotification("Ya estas en la cola")
		end
	end
    if (ident== 2) then
		if (counter == 0) then
            --exports['okokNotify']:Alert("Zon Development", "Entraste en cola de (2v2)", 3500, 'success')
            ESX.ShowNotification("Entraste en cola de (2v2)")
			TriggerServerEvent("zon_pvp:counter2v2", source)
			counter = 1
		else 
            --exports['okokNotify']:Alert("Zon Development", "Ya estas en la cola", 3500, 'success')
           ESX.ShowNotification("Ya estas en la cola")
		end
	end
    if (ident== 3) then
        if (counter == 0) then
            --exports['okokNotify']:Alert("Zon Development", "Entraste en cola de 1v1 Ranked", 3500, 'success')
            ESX.ShowNotification("Entraste en cola de 1v1 Ranked")
			TriggerServerEvent("zon_pvp:counter1v1r", source)
            --print("hola")
			counter = 1
		else 
            --exports['okokNotify']:Alert("Zon Development", "Ya estas en la cola", 3500, 'success')
           ESX.ShowNotification("Ya estas en la cola")
		end
    end
end)

RegisterNetEvent("attachs", function (source)
    ExecuteCommand("attachs")
end)

-- NOTIFICACIONES
function notify(str)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandThefeedPostTicker(true, false)
end

-- REVIVE Y FUNCIONES


RegisterNetEvent('uptime:revive')
AddEventHandler('uptime:revive', function()
	----print("ola")
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		
		local formattedCoords = vector3(-881.7543, -430.7855, 39.5998)
		counter = 0
	--	ESX.SetPlayerData('lastPosition', formattedCoords)

		--TriggerServerEvent('esx:updateLastPosition', formattedCoords)
        TriggerServerEvent('zon_pvp:saveInfo', victorias, derrotas)
		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')

	end)
end)

function RespawnPed(ped, formattedCoords, heading)
	SetEntityCoordsNoOffset(ped, formattedCoords.x, formattedCoords.y, formattedCoords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(formattedCoords.x, formattedCoords.y, formattedCoords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
    TriggerServerEvent('esx:onPlayerSpawn')
    TriggerEvent('esx:onPlayerSpawn')
    TriggerEvent('playerSpawned')

	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent("uptime:heal")
AddEventHandler("uptime:heal", function()
    local playerPed = PlayerPedId()    
    local maxHealth = GetEntityMaxHealth(playerPed)
    SetEntityHealth(playerPed, maxHealth)
end)


-- funciones y draws

function Draw3DText(x, y, z, text)
    -- Checkea si las coordenadas son visibles y coge coordenadas en 2D
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calcula la escala del texto a usar
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8*(1/dist)*(1/GetGameplayCamFov())*100

        -- Draw texto en pantalla
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

-- Draw texto 2D en pantalla
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


RegisterCommand("menu1VS1", function ()

    TriggerServerEvent('zon_pvp:createElo')
    ESX.TriggerServerCallback('zon_pvp:getElo', function(info)
        elo = info[1].elo 
        
        ESX.UI.Menu.Close()
        ESX.UI.Menu.Open('default',GetCurrentResourceName(),'more_info',
        { 
            title = "Menu 1v1 " .. " | ".. "Elo: "..math.floor(elo), 
            align = 'bottom-right', 
            elements = {
                {label = "1V1 Ranked", value = '1v1r'},
                {label = "1V1 Unranked", value = '1v1'},
                {label = "2V2 Unranked", value = '2v2'},
                {label = "Abandonar Cola", value = 'quit'},
            },
            }, function(data, menu)

            local player, distance = ESX.Game.GetClosestPlayer()

            if data.current.value == '1v1' then
                ExecuteCommand("1v1")
                ESX.UI.Menu.CloseAll()
            elseif data.current.value == '2v2' then
                ExecuteCommand("2v2")
                ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'quit' then
                TriggerServerEvent("zon_pvp:salirColas", source)
                counter = 0
                ESX.UI.Menu.CloseAll()
            elseif data.current.value == '1v1r' then
                ExecuteCommand("1v1r")
                ESX.UI.Menu.CloseAll()
            end
        end, function(data, menu) 
            menu.close() 
        end)
    end)
end)


RegisterCommand("salirCola", function (source)
    local source = source
    TriggerServerEvent("zon_pvp:salirColas", source)
end)

dimensionCliente = 0
RegisterNetEvent("comprobardimension")
AddEventHandler("comprobardimension", function(dimension)
   -- --print("Llego a la dimension de cliente "..tostring(dimension))
    dimensionCliente = dimension
end)

