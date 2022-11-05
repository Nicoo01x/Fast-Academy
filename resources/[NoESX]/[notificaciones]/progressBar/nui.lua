-- Commands
RegisterCommand('test1', function()
    TriggerEvent('startProgress', '3', 'CRAFT GUN', 'rgb(250, 50, 50)')
end)

RegisterCommand('test2', function()
    TriggerEvent('startProgress', '10', 'Preparing grilled chicken', 'rgb(250, 50, 200)')
end)

-- Callback
RegisterNUICallback('completedBar', function()
    print("Bar completed")
end)

-- Trigger
RegisterNetEvent("startProgress")
AddEventHandler("startProgress", function(timer, text, color)
	SetDisplay(timer, text, color)
end)

-- Display UI
function SetDisplay(timer, text, color)
	SendNUIMessage({
		timer = timer,
		text = text,
		color = color
	})
end