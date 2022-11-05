ESX = exports["es_extended"]:getSharedObject()

local toghud = true
local tokovoipstate = 1
local isTalking = false

RegisterCommand('togglehud', function(source, args, rawCommand)
    if toghud then 
        toghud = false
    else
        toghud = true
    end
end)

RegisterNetEvent('jsx_modules:framework:hud:toggleui')
AddEventHandler('jsx_modules:framework:hud:toggleui', function(show)
    if show == true then
        toghud = true
    else
        toghud = false
    end
end)

RegisterNetEvent('jsx_modules:framework:toggleTokoVOIP')
AddEventHandler('jsx_modules:framework:toggleTokoVOIP', function(state)
    tokovoipstate = state
end)

RegisterNetEvent('jsx_modules:framework:setTalkingState')
AddEventHandler('jsx_modules:framework:setTalkingState', function(state)
    isTalking = state
end)


CreateThread(function()
    while true do
        if toghud == true then
            if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end 
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                TriggerEvent('esx_status:getStatus','stress',function(stress)

                    local myhunger = hunger.getPercent()
                    local mythirst = thirst.getPercent()
                    local mystress = stress.getPercent()

                    SendNUIMessage({
                        action = "updateStatusHud",
                        show = toghud,
                        thirst = mythirst,
                        state = tokovoipstate,
                        talking = isTalking,
                    })
                end)
            end)
        end)
        Wait(5000)
    end
end)

CreateThread(function()
    while true do

        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 2.5
        local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())

        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
            armour = armor,
            oxygen = oxy,
            stamina = stamina,
            state = tokovoipstate,
            talking = isTalking,
        })
        Wait(1000)
    end
end)