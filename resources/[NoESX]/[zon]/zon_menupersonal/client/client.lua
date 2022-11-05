if Config.UseOldEsx then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

zon_noclip = false

RegisterCommand('menu', function()
    PersonalMenu(source)
end)

PersonalMenu = function()
    local elements = {}
    local id = GetPlayerServerId(PlayerId()) 

    ESX.TriggerServerCallback('zon_menu:havePermissions', function(cb)
        if cb then
            table.insert(elements, {label = 'Información', value = 'info'})
            table.insert(elements, {label = 'Extras', value = 'otros'})
			--table.insert(elements, {label = 'Fps Menu', value = 'fps'})
			--table.insert(elements, {label = 'Inversor', value = 'inversor'})
            if IsPedInAnyVehicle(PlayerPedId()) then 
            table.insert(elements, {label = 'Acciones de vehículo', value = 'veh'})
            end
            table.insert(elements, {label = 'Administracion', value = 'admin'})
        else
            table.insert(elements, {label = 'Información', value = 'info'})
            table.insert(elements, {label = 'Extras', value = 'otros'})
            if IsPedInAnyVehicle(PlayerPedId()) then 
                table.insert(elements, {label = 'Acciones de vehículo', value = 'veh'})
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'zon_menu', {
            title = 'Menu Personal - [ <span style = color:lime; span>'..id..'</span> ]', 
            align = Config.Align,
            elements = elements

        }, function(data, menu)
            local val = data.current.value
            if val == 'info' then
                InfoMenu()
            elseif val == 'admin' then
                AdministracionMenu()
            elseif val == 'otros' then
                OtrosMenu()
		--	elseif val == 'fps' then
         --       OpenFPSMenu()
			elseif val == 'inversor' then
				OpenInversor()
            elseif val == 'veh' then
                VehMenu()
            end
        end, function(data, menu)
            menu.close()
        end)
    end)
	RegisterKeyMapping('menu', 'Personal', 'keyboard', 'F10')
end

InfoMenu = function()
    ESX.TriggerServerCallback('zon_menu:getInformation', function(info)
        local name = GetPlayerName(PlayerId())
        local Data = ESX.GetPlayerData()
        local job = Data.job.label
        local jobgrade = Data.job.grade_label
        local money = info.money
        local bank = info.bankmoney
        local blackmoney = info.blackmoney
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'info', {
            title = 'Informacion de <span style = color:lime; span>'..name..'</span>',
            align = Config.Align,
            elements = {
                {label = 'Trabajo: <span style = color:yellow; span>'..job.. ' - ' ..jobgrade..'</span>', value = nil},
                {label = 'Dinero: <span style = color:lime; span>'..money..'$</span>', value = nil},
                {label = 'Banco: <span style = color:lime; span>'..bank..'$</span>', value = nil},
                {label = 'Dinero negro: <span style = color:lime; span>'..blackmoney..'$</span>', value = nil},
                {label = '<span style = color:red; span>Cerrar</span>', value = 'cerrar'}
            }}, function(data, menu)
                local data = data.current.value 
                if data == 'cerrar' then
                    menu.close()
                end
            end, function(data, menu)
                menu.close()
        end)
    end)
end

local function OnChangeLevel( shadows, flashlight, rope, sirens, tracker )
    RopeDrawShadowEnabled( rope or false );

    CascadeShadowsClearShadowSampleType();
    CascadeShadowsSetAircraftMode( false );
    CascadeShadowsEnableEntityTracker( true );
    CascadeShadowsSetDynamicDepthMode( false );
    CascadeShadowsSetEntityTrackerScale( tracker or shadows );
    CascadeShadowsSetDynamicDepthValue( shadows );
    CascadeShadowsSetCascadeBoundsScale( shadows );

    SetFlashLightFadeDistance( flashlight );
    SetLightsCutoffDistanceTweak( flashlight );
    DistantCopCarSirens( sirens or false );
end


RegisterNetEvent('inversor:openinversor')
AddEventHandler('inversor:openinversor', function()
	OpenInversor()
end)

RegisterCommand('Inversor', function()
	OpenInversor(source)
end)

--function OpenInversor() 

 --   local elements = {
 --    {label = 'Noclip ', value = 'noclip'},	 
--	 {label = 'God ', value = 'god'},		 
--	 {label = 'Tiempo ', value = 'tiempo'},	
--	 {label = 'Reset ', value = 'reset'},	
--	 {label = '--------[Vehiculos]--------', value = ''}, 
--     {label = 'Reparar Vehiculo', value = 'fix2'},	   	       
--     {label = 'Spawnear Vehiculo', value = 'fps5'},               
  --   {label = 'Basico', value = 'fps2'},									          
--}

--ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'zon_menu', {
--	title = 'Menu Personal - [ <span style = color:lime; span>'..id..'</span> ]', 
--	align = Config.Align,
--	elements = elements

--}, function(data, menu)
--	local val = data.current.value
--	if val == 'noclip' then
--		TriggerEvent('zon_noclip')
--	elseif val == 'god' then
--		AdministracionMenu()
--	elseif val == 'otros' then
--		TriggerEvent('esx_ambulancejob:revive')
--	elseif val == 'fps' then
 --       OpenFPSMenu()
--	elseif val == 'inversor' then
--		OpenInversor()
--	elseif val == 'veh' then
--		VehMenu()
--	end
--end, function(data, menu)
--	menu.close()
--end)
--end



RegisterNetEvent('fps:openfps') 
AddEventHandler('fps:openfps', function()
    OpenFPSMenu()
end)

RegisterCommand('fpsmenu', function()
  OpenFPSMenu(source)
end)

function OpenFPSMenu() 

    local elements = {
	 {label = '--------[Niveles]--------', value = ''},
     {label = 'Bajo ', value = 'low'},	 
	 {label = 'Medio ', value = 'medium'},		 
	 {label = 'Alto ', value = 'ultra_low'},	
	 {label = 'Reset ', value = 'reset'},	
	 {label = '--------[Avanzado]--------', value = ''}, 
     {label = 'Fog', value = 'fps'},	   	       
     {label = 'Vision y luces mejoradas', value = 'fps5'},               
     {label = 'Basico', value = 'fps2'},									          
}
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'FPS Menu',
        align = 'bottom-right',
        elements = elements},
  
            function(data2, menu2)
  
			
              if data2.current.value == 'fps' then
                SetWeatherTypePersist("CLEAR")
				SetWeatherTypeNowPersist("CLEAR")
				SetWeatherTypeNow("CLEAR")
				SetOverrideWeather("CLEAR")
				SetTimecycleModifier('CS1_railwayB_tunnel')
				ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")

             elseif data2.current.value == 'fps2' then
                SetTimecycleModifier()
                ClearTimecycleModifier()
                ClearExtraTimecycleModifier()
				ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
              elseif data2.current.value == 'fps5' then
                SetTimecycleModifier('tunnel') 
				ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
              elseif data2.current.value == 'fps6' then
                ExecuteCommand('cinema')  
				ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
			  elseif data2.current.value == 'reset' then 
				SetTimecycleModifier()
        		ClearTimecycleModifier()
       			ClearExtraTimecycleModifier()
        		OnChangeLevel( 5.0, 10.0, true, true );
				ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
			elseif data2.current.value == 'low' then 
				OnChangeLevel( 0.0, 5.0, false, false );
				lodScale = 0.6;
				SetTimecycleModifier('NO_weather')
				SetWeatherTypePersist("CLEAR")
				SetWeatherTypeNowPersist("CLEAR")
				SetWeatherTypeNow("CLEAR")
				SetOverrideWeather("CLEAR")
				ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
			elseif data2.current.value == 'medium' then 
				SetTimecycleModifier("cinema")
        		OnChangeLevel( 3.0, 3.0, true, false, 5.0 );
				ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
			elseif data2.current.value == 'ultra_low' then 
				SetTimecycleModifier('yell_tunnel_nodirect')
      			OnChangeLevel( 0.0, 0.0, false, false );
				  ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
              elseif data2.current.value == 'fps7' then
                  SetTimecycleModifier('MP_Powerplay_blend')
                  SetExtraTimecycleModifier('reflection_correct_ambient')    
                elseif data2.current.value == 'fps8' then    
                  DisplayRadar(false)
				  ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
                elseif data2.current.value == 'fps9' then      
                  DisplayRadar(true)
				  ESX.ShowNotification("Modo de <span style='color:#0CB8EA'>Fps Seleccionado</span>!")
              else
              end
            end,
      function(data2, menu2)
        menu2.close()
      end)
	end


OtrosMenu = function()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'otros', {
        title = 'Opciones variadas',
        align = Config.Align,
        elements = {
            {label = 'Activar/Desactivar gráficos', value = 'fps34'},
            {label = 'Resetear voz', value = 'voz'},
            {label = 'Resetear pj', value = 'pj'}, 
			{label = 'Borrar Chat', value = 'chat'},
		--	{label = 'GPS', value = 'gps'}, 
            {label = '<span style = color:red; span>Cerrar</span>', value = 'cerrar'}
        }}, function(data, menu)
            local action = data.current.value 
            if action == 'voz' then
                ExecuteCommand('rvoz')
			elseif action == 'fps34' then
                ExecuteCommand('fpsmenu')
            elseif action == 'pj' then
                ExecuteCommand('fixpj')
			elseif action == 'chat' then
				ExecuteCommand('clear')
           -- elseif action == 'gps' then
           --     GPS()
            elseif action == 'cerrar' then
                menu.close()
            end
        end, function(data, menu)
            menu.close()
    end)
end

VehMenu = function()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'veh', {
            title = 'Acciones de vehiculo', 
            align = Config.Align,
            elements = {
                {label = 'Encender/Apagar motor', value = 'motor'},
                {label = 'Abrir/Cerrar ventanas', value = 'ventanas'},
                {label = 'Abrir/Cerrar puertas', value = 'puertas'},
                {label = 'Asientos', value = 'asientos'}, 
                {label = '<span = style = color:red; span>Cerrar</span>', value = 'cerrar'}
            }}, function(data, menu)
            local val = data.current.value 
            if val == 'motor' then
                if motor then
                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(),false), false, false, false)
                    motor = false
                elseif not motor then
                    motor = true
                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(),false), true, false, false)
                end
                while (motor == false) do
                    SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId(),false),true)
                    Citizen.Wait(0)
                end
            elseif val == 'ventanas' then
                Ventanas()
            elseif val == 'puertas' then
                Puertas()
            elseif val == 'asientos' then
                CambiarAsiento()
            elseif val == 'cerrar' then
                menu.close()
            end
        end, function(data, menu)
            menu.close()
    end)
end

AdministracionMenu = function()
    local godmode = true
    local invisible = true

    local elements = {
        {label = 'Noclip', value = 'noclip'},
        --{label = 'GodMode', value = 'godmode'},
        {label = 'Invisible', value = 'invisible'},
        {label = 'Abrir vehículo', value = 'abrirveh'},
        {label = 'Cerrar vehículo', value = 'cerrarveh'},
        {label = 'Reparar vehiculo', value = 'fix'},
        {label = 'Poner Ped', value = 'ped'},
        {label = 'Mostrar cordenadas', value = 'coordss'},
        {label = '<span style = color:red; span>Cerrar</span>', value = 'cerrar'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'zon_admin', {
        title = 'Menu de administración', 
        align = Config.Align,
        elements = elements
    }, function(data, menu)
        local adm = data.current.value
            if adm  == 'noclip' then
                TriggerEvent('zon_noclip')
            elseif adm  == 'godmode' then
                if godmode then
                    SetEntityInvincible(PlayerPedId(), true)
                    ESX.ShowNotification('Has activado el ~g~Godmode.')
                    godmode = false
                else
                    SetEntityInvincible(PlayerPedId(), false)
                    ESX.ShowNotification('Has desactivado el ~r~Godmode.')
                    godmode = true
                end
            elseif adm == 'invisible' then
                if invisible then
                    SetEntityVisible(PlayerPedId(), false)
                    ESX.ShowNotification('Has activado el ~g~Invisible.')
                    invisible = false
                else
                    SetEntityVisible(PlayerPedId(), true)
                    ESX.ShowNotification('Has desactivado el ~r~Invisible.')
                    invisible = true
                end
            elseif adm == 'abrirveh' then
                local coords = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 8.0, 0, 71)
                if coords < 1 then
                    ESX.ShowNotification('No estas cerca de un vehiculo.')
                else
                    SetVehicleDoorsLocked(coords, 1)
                    ESX.ShowNotification('Vehiculo ~g~desbloqueado.')
                end
            elseif adm == 'cerrarveh' then
                local coords = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 8.0, 0, 71)
                if coords < 1 then
                    ESX.ShowNotification('No estas cerca de un vehiculo.')
                else
                    SetVehicleDoorsLocked(coords, 2)
                    ESX.ShowNotification('Vehiculo ~r~bloqueado.')
                end
            elseif adm == 'fix' then
                TriggerEvent('zon_fix')
            elseif adm == 'ped' then
                ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'ped_menu', {
                    title = 'Menú de Peds',
                }, function(menuData, menuHandle)
                    local pedModel = menuData.value
                                
                    if not type(pedModel) == "number" then pedModel = 'pedModel' end
                    if IsModelInCdimage(pedModel) then
                        while not HasModelLoaded(pedModel) do
                            Citizen.Wait(15)
                            RequestModel(pedModel)
                        end
                        SetPlayerModel(PlayerId(), pedModel)
                        menuHandle.close()
                    else
                        ESX.ShowNotification('~r~Ped no encontrado')
                    end
                end, function(menuData, menuHandle)
                    menuHandle.close()
                end)
            elseif adm == 'coordss' then
                TriggerEvent('zon_coords')
            elseif adm == 'cerrar' then
                menu.close()
            end
        end, function(data, menu)
            menu.close()
    end)
end
if esp then
	for i=1,128 do
	  if  ((NetworkIsPlayerActive( i )) and GetPlayerPed( i ) ~= GetPlayerPed( -1 )) then
		local ra = RGB(1.0)
		local pPed = GetPlayerPed(i)
		local cx, cy, cz = table.unpack(GetEntityCoords(PlayerPedId(-1)))
		local x, y, z = table.unpack(GetEntityCoords(pPed))
		local disPlayerNames = 130
		local disPlayerNamesz = 999999
		  if nameabove then
			distance = math.floor(GetDistanceBetweenCoords(cx,  cy,  cz,  x,  y,  z,  true))
			  if ((distance < disPlayerNames)) then
				if NetworkIsPlayerTalking( i ) then
				  DrawText3D(x, y, z+1.2, GetPlayerServerId(i).."  |  "..GetPlayerName(i), ra.r,ra.g,ra.b)
				else
				  DrawText3D(x, y, z+1.2, GetPlayerServerId(i).."  |  "..GetPlayerName(i), 255,255,255)
				end
			  end
		  end
		local message =
		"Name: " ..
		GetPlayerName(i) ..
		"\nServer ID: " ..
		GetPlayerServerId(i) ..
		"\nPlayer ID: " .. i .. "\nDist: " .. math.round(GetDistanceBetweenCoords(cx, cy, cz, x, y, z, true), 1)
		if IsPedInAnyVehicle(pPed, true) then
				 local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pPed))))
		  message = message .. "\nVeh: " .. VehName
		end
		if ((distance < disPlayerNamesz)) then
		if espinfo and esp then
		  DrawText3D(x, y, z - 1.0, message, ra.r, ra.g, ra.b)
		end
		if espbox and esp then
		  LineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
		  LineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
		  LineTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
		  LineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
		  LineThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
		  LineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, -0.9)
		  LineFourBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)

		  TLineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
		  TLineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
		  TLineTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
		  TLineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
		  TLineThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
		  TLineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, 0.8)
		  TLineFourBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)

		  ConnectorOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, 0.8)
		  ConnectorOneEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, -0.9)
		  ConnectorTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
		  ConnectorTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
		  ConnectorThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
		  ConnectorThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
		  ConnectorFourBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
		  ConnectorFourEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)

		  DrawLine(
		  LineOneBegin.x,
		  LineOneBegin.y,
		  LineOneBegin.z,
		  LineOneEnd.x,
		  LineOneEnd.y,
		  LineOneEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  LineTwoBegin.x,
		  LineTwoBegin.y,
		  LineTwoBegin.z,
		  LineTwoEnd.x,
		  LineTwoEnd.y,
		  LineTwoEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  LineThreeBegin.x,
		  LineThreeBegin.y,
		  LineThreeBegin.z,
		  LineThreeEnd.x,
		  LineThreeEnd.y,
		  LineThreeEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  LineThreeEnd.x,
		  LineThreeEnd.y,
		  LineThreeEnd.z,
		  LineFourBegin.x,
		  LineFourBegin.y,
		  LineFourBegin.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  TLineOneBegin.x,
		  TLineOneBegin.y,
		  TLineOneBegin.z,
		  TLineOneEnd.x,
		  TLineOneEnd.y,
		  TLineOneEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  TLineTwoBegin.x,
		  TLineTwoBegin.y,
		  TLineTwoBegin.z,
		  TLineTwoEnd.x,
		  TLineTwoEnd.y,
		  TLineTwoEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  TLineThreeBegin.x,
		  TLineThreeBegin.y,
		  TLineThreeBegin.z,
		  TLineThreeEnd.x,
		  TLineThreeEnd.y,
		  TLineThreeEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  TLineThreeEnd.x,
		  TLineThreeEnd.y,
		  TLineThreeEnd.z,
		  TLineFourBegin.x,
		  TLineFourBegin.y,
		  TLineFourBegin.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  ConnectorOneBegin.x,
		  ConnectorOneBegin.y,
		  ConnectorOneBegin.z,
		  ConnectorOneEnd.x,
		  ConnectorOneEnd.y,
		  ConnectorOneEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  ConnectorTwoBegin.x,
		  ConnectorTwoBegin.y,
		  ConnectorTwoBegin.z,
		  ConnectorTwoEnd.x,
		  ConnectorTwoEnd.y,
		  ConnectorTwoEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  ConnectorThreeBegin.x,
		  ConnectorThreeBegin.y,
		  ConnectorThreeBegin.z,
		  ConnectorThreeEnd.x,
		  ConnectorThreeEnd.y,
		  ConnectorThreeEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		  DrawLine(
		  ConnectorFourBegin.x,
		  ConnectorFourBegin.y,
		  ConnectorFourBegin.z,
		  ConnectorFourEnd.x,
		  ConnectorFourEnd.y,
		  ConnectorFourEnd.z,
		  ra.r,
		  ra.g,
		  ra.b,
		  255
		  )
		end
		if esplines and esp then
		  DrawLine(cx, cy, cz, x, y, z, ra.r, ra.g, ra.b, 255)
		end
	  end
	end
  end
  end

-- PLUS FUNCTION --

CreateThread(function()
    while true do 
        local zon = 1000
        if zon_noclip then
            zon = 0
            local x,y,z = Posicion()
            local dx,dy,dz = Direccion()
            local speed = 2.0

            SetEntityVelocity(PlayerPedId(), 0.05,  0.05,  0.05)

            if IsControlPressed(0, 32) then
                zon = 0
                x = x + speed * dx
                y = y + speed * dy
                z = z + speed * dz
            end

            if IsControlPressed(0, 269) then
                zon = 0
                x = x - speed * dx
                y = y - speed * dy
                z = z - speed * dz
            end

            SetEntityCoordsNoOffset(PlayerPedId(),x,y,z,true,true,true)
        end
        Citizen.Wait(zon)
    end
end)

-- EVENTS --

RegisterNetEvent('zon_noclip')
AddEventHandler('zon_noclip',function()
	zon_noclip = not zon_noclip

    if zon_noclip then
    	SetEntityInvincible(PlayerPedId(), true)
    	SetEntityVisible(PlayerPedId(), false, false)
    else
    	SetEntityInvincible(PlayerPedId(), false)
    	SetEntityVisible(PlayerPedId(), true, false)
    end

    if zon_noclip == true then 
        ESX.ShowNotification('Has activado el ~g~noclip.')
    else
        ESX.ShowNotification('Has desactivado el ~r~noclip.')
    end
end)

RegisterNetEvent('zon_fix')
AddEventHandler('zon_fix', function()
    if IsPedInAnyVehicle(PlayerPedId()) then 
        SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
        SetVehicleDeformationFixed(GetVehiclePedIsIn(PlayerPedId()))
        SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), false)
        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), true, true)
        ESX.ShowNotification('~g~Coche reparado')
    else
        ESX.ShowNotification('~r~Debes de estar dentro de un vehículo')
    end
end)

RegisterNetEvent('zon_coords')
AddEventHandler('zon_coords', function()
    coordsVisible = not coordsVisible
	  while true do
		local zon = 250
		
		if coordsVisible then
			zon = 5

			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId()))
			local playerH = GetEntityHeading(PlayerPedId())

			TxT(("~r~X~w~: %s ~r~Y~w~: %s ~r~Z~w~: %s ~r~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end

		Citizen.Wait(zon)
	end
end)

-- COMMANDS --

RegisterCommand('rvoz', function()
    NetworkClearVoiceChannel()
    NetworkSessionVoiceLeave()
    Wait(50)
    NetworkSetVoiceActive(false)
    MumbleClearVoiceTarget(2)
    Wait(1000)
    MumbleSetVoiceTarget(2)
    NetworkSetVoiceActive(true)
    ESX.ShowNotification("<span style='color:#0CB8EA'>Chat</span> de voz reiniciado.")
  end)

RegisterCommand('fixpj', function()
    local hp = GetEntityHealth(PlayerPedId())
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0
        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
                TriggerEvent('dpc:ApplyClothing')
                SetEntityHealth(PlayerPedId(), hp)
				ESX.ShowNotification("<span style='color:#0CB8EA'>PJ</span> reiniciado.")
            end)
        end)
    end)
end, false)

-- FUNCTIONS --

TxT = function(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(6)
	SetTextScale(0.4, 0.4)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.85, 0.020)
end

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

Posicion = function()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  	return x,y,z
end

Direccion = function()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
  
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
  
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
	  x = x/len
	  y = y/len
	  z = z/len
	end
  
	return x,y,z
end

GPS = function()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gps',{
        title = 'GPS Rápido',
		    align = Config.Align,
		    elements = {
			  {label = 'Garage Cental', value = 'garaje'},
			  {label = 'Comisaria', value = 'comisaria'}, 
			  {label = 'Hospital', value = 'hospital'}, 
			  {label = 'Concesionario', value = 'conce'},
			  {label = 'Mecánico', value = 'mecanico'},
			  {label = 'Badulake Central', value = 'badu'},	
		 }
  },
	function(data, menu)
		local fastgps = data.current.value
		
		if fastgps == 'garaje' then
			SetNewWaypoint(215.12, -815.74)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'comisaria' then 
			SetNewWaypoint(411.28, -978.73)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'hospital' then 
			SetNewWaypoint(291.37, -581.63)
            ESX.UI.Menu.CloseAll()
        elseif fastgps == 'conce' then
			SetNewWaypoint(-33.78, -1102.12)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'mecanico' then
			SetNewWaypoint(-359.59, -133.44)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'badu' then
			SetNewWaypoint(-708.01, -913.8)
            ESX.UI.Menu.CloseAll()
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

CambiarAsiento = function()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'asientos', {
		title = 'Selección de asientos',
		align = Config.Align,
		elements = {
            {label = 'Asiento 1', value = 'asiento1'},
            {label = 'Asiento 2', value = 'asiento2'},
            {label = 'Asiento 3', value = 'asiento3'},
            {label = 'Asiento 4', value = 'asiento4'},   
        }}, function(data, menu)
        local asientos = data.current.value 
		if asientos == 'asiento1' then 
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), -1)
		elseif asientos == 'asiento2' then
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
		elseif asientos == 'asiento3' then 
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 1)
		elseif asientos == 'asiento4' then 
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 2)
		end
	end, function(data, menu)
		menu.close()
	end)
end

Ventanas = function()
    local izquierdafrontal = true
    local derechafrontal = true
    local izquierdaatras = true
    local derechaatras = true
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'zon_ventanas', {
			title    = 'Ventanas',
			align    = Config.Align,
			elements = {
                {label = 'Ventanilla delantera izquierda', value = 'izquierdafrontal'},
                {label = 'Ventanilla delantera derecha', value = 'derechafrontal'},
                {label = 'Ventanilla trasera izquierda', value = 'izquierdaatras'},
                {label = 'Ventanilla trasera derecha', value = 'derechaatras'},
                {label = 'Bajar todas las ventanillas', value = 'bajartodas'},
                {label = 'Subir todas las ventanillas', value = 'subirtodas'}
            }}, function(data, menu)
                local vent = data.current.value 
			if vent == 'izquierdafrontal' then
				if not izquierdafrontal then
					izquierdafrontal = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				elseif izquierdafrontal then
					izquierdafrontal = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				end
			elseif vent == 'derechafrontal' then
				if not derechafrontal then
					derechafrontal = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				elseif derechafrontal then
					derechafrontal = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				end
			elseif vent == 'izquierdaatras' then
				if not izquierdaatras then
					izquierdaatras = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				elseif izquierdaatras then
					izquierdaatras = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				end
			elseif vent == 'derechaatras' then
				if not derechaatras then
					derechaatras = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				elseif derechaatras then
					derechaatras = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				end
			elseif vent == 'bajartodas' then
				izquierdafrontal = true
				derechafrontal = true
				izquierdaatras = true
				derechaatras = true
				RollDownWindows(GetVehiclePedIsIn(PlayerPedId(), false))
			elseif vent == 'subirtodas' then
				izquierdafrontal = false
				derechafrontal = false
				izquierdaatras = false
				derechaatras = false
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
			end
		end, function(data, menu)
            menu.close()
	end)
end

local izquierdafrontal = false
local derechafrontal = false
local izquierdaatras = false
local backrightdoors = false
Puertas = function()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_controls_doors', {
			title    = 'Puertas',
			align    = Config.Align,
			elements = {
                {label = 'Puerta delantera izquierda', value = 'izquierdafrontal'},
                {label = 'Puerta delantera derecha', value = 'derechafrontal'},
                {label = 'Puerta trasera izquierda', value = 'izquierdaatras'},
                {label = 'Puerta trasera derecha', value = 'derechaatras'},
                {label = 'Abrir todas las puertas', value = 'abrirtodas'},
                {label = 'Cerrar todas las puertas', value = 'cerrartodas'}
            }}, function(data, menu)
                local puert = data.current.value
			if puert == 'izquierdafrontal' then
				if not izquierdafrontal then
					izquierdafrontal = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				elseif izquierdafrontal then
					izquierdafrontal = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				end
			elseif puert == 'derechafrontal' then
				if not derechafrontal then
					derechafrontal = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				elseif derechafrontal then
					derechafrontal = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				end
			elseif puert == 'izquierdaatras' then
				if not izquierdaatras then
					izquierdaatras = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				elseif izquierdaatras then
					izquierdaatras = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				end
			elseif puert== 'derechaatras' then
				if not derechaatras then
					derechaatras = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				elseif derechaatras then
					derechaatras = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				end
			elseif puert == 'abrirtodas' then
				izquierdafrontal = true
				derechafrontal = true
				izquierdaatras = true
				derechaatras = true
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 4, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 5, false)
			elseif puert == 'cerrartodas' then
				izquierdafrontal = false
				derechafrontal = false
				izquierdaatras = false
				derechaatras = false
				SetVehicleDoorsShut(GetVehiclePedIsIn(PlayerPedId(),false))															
			end
		end, function(data, menu)
            menu.close()
	end)
end