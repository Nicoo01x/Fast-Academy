local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local trunkData = nil
local isInInventory = false
ESX = nil
local fastWeapons = {
    [1] = nil,
    [2] = nil,
    [3] = nil
}

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(10)
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
            if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                TriggerScreenblurFadeIn(0)
                Citizen.Wait(50)
                openInventory()
            end
        end
    end
)
function openInventory()
    loadPlayerInventory()
    isInInventory = true
    
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end

function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true
    
    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )
    SetNuiFocus(true, true)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(0)
    ClearPedSecondaryTask(PlayerPedId())
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
        Citizen.Wait(50)
        TriggerScreenblurFadeOut(0)
    end
)
RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayers = false
        local elements = {}
        
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true
                
                table.insert(
                    elements,
                    {
                        label = GetPlayerName(players[i]),
                        player = GetPlayerServerId(players[i])
                    }
            )
            end
        end
        
        if not foundPlayers then
            --[[exports.pNotify:SendNotification(
            {
            text = _U("players_nearby"),
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "inventoryhud"
            }
            )--]]
            --Uncomment This to Use pNotify
            ESX.ShowNotification(_U("players_nearby"))
        else
            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
        )
        end
        
        cb("ok")
    end
)
RegisterNUICallback(
    "PutIntoTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            
            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end
            
            TriggerServerEvent("esx_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)
        end
        
        Wait(500)
        loadPlayerInventory()
        
        cb("ok")
    end
)
RegisterNUICallback(
    "TakeFromTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx_trunk:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh)
        end
        
        Wait(500)
        loadPlayerInventory()
        
        cb("ok")
    end
)
RegisterNUICallback(
    "UseItem",
    function(data, cb)
        TriggerServerEvent("esx:useItem", data.item.name)
        Citizen.Wait(500)
        loadPlayerInventory()
        
        cb("ok")
    end
)
RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
        end
        
        Wait(500)
        loadPlayerInventory()
        
        cb("ok")
    end
)
RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end
        
        if foundPlayer then
            local count = tonumber(data.number)
            
            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end
            
            TriggerServerEvent("esx:giveInvenspaintoryItem", data.player, data.item.type, data.item.name, count)
            Wait(500)
            loadPlayerInventory()
        else
            ESX.ShowNotification(_U("player_nearby"))
        end
        cb("ok")
    end
)
function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end
    
    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end
    
    return false
end

function getItemWeight(item)
    local weight = 0
    local itemWeight = 0
    if item ~= nil then
        itemWeight = ESX.GetItemWeight(item)
    end
    return itemWeight
end

function getInventoryWeight(inventory)
    local weight = 0
    local itemWeight = 0
    if inventory ~= nil then
        for i = 1, #inventory, 1 do
            if inventory[i] ~= nil then
                itemWeight = ESX.GetItemWeight(inventory[i].name)
                weight = weight + (itemWeight * (inventory[i].count or 1))
            end
        end
    end
    return weight
end

function loadPlayerInventory()
    ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory",
        function(data)
            items = {}
            fastItems = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons
            weight = data.weight
            maxWeight = data.maxweight
            
            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"
                        
                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                limit = -1,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
            
            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
                        local found = false
                        for slot, weapon in pairs(fastWeapons) do
                            if weapon == weapons[key].name then
                                local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                                table.insert(
                                    fastItems,
                                    {
                                        label = weapons[key].label,
                                        count = ammo,
                                        limit = -1,
                                        type = "item_weapon",
                                        name = weapons[key].name,
                                        usable = false,
                                        rare = false,
                                        canRemove = true,
                                        slot = slot
                                    }
                                )
                                found = true
                                break
                            end
                        end
                        if found == false then
                            local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                            table.insert(
                                items,
                                {
                                    label = weapons[key].label,
                                    count = ammo,
                                    limit = -1,
                                    type = "item_weapon",
                                    name = weapons[key].name,
                                    usable = false,
                                    rare = false,
                                    canRemove = true
                                }
                        )
                        end
                    end
                end
            end
            
            
            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        table.insert(items, inventory[key])
                    --widgetTotal = getInventoryWeight(items)
                    end
                end
            end
            
            local texts = _U("player_info", GetPlayerName(PlayerId()), (weight), (maxWeight))
            
            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items,
                    fastItems = fastItems,
                    text = texts
                }
        )
        end,
        GetPlayerServerId(PlayerId()))
end

function setHurt()
    FreezeEntityPosition(PlayerPedId(), true)
end

function setNotHurt()
    FreezeEntityPosition(PlayerPedId(), false)
end

RegisterNetEvent("esx_inventoryhud:openTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:openTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
        openTrunkInventory()
    end
)
RegisterNetEvent("esx_inventoryhud:refreshTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:refreshTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
    end
)
function setTrunkInventoryData(data, blackMoney, inventory, weapons)
    trunkData = data
    
    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )
    items = {}
    
    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    
    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].rare = false
                inventory[key].limit = -1
                inventory[key].canRemove = false
                table.insert(items, inventory[key])
            end
        end
    end
    
    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
            )
            end
        end
    end
    
    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
)
end

function openTrunkInventory()
    TriggerScreenblurFadeIn(0)
    loadPlayerInventory()
    isInInventory = true
    local playerPed = PlayerPedId()
    if not IsEntityPlayingAnim(playerPed, 'mini@repair', 'fixing_a_player', 3) then
        ESX.Streaming.RequestAnimDict('mini@repair', function()
            TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end)
    end
    
    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )
    SetNuiFocus(true, true)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 1, true)-- Disable pan
                DisableControlAction(0, 2, true)-- Disable tilt
                DisableControlAction(0, 24, true)-- Attack
                DisableControlAction(0, 257, true)-- Attack 2
                DisableControlAction(0, 25, true)-- Aim
                DisableControlAction(0, 263, true)-- Melee Attack 1
                DisableControlAction(0, Keys["W"], true)-- W
                DisableControlAction(0, Keys["A"], true)-- A
                DisableControlAction(0, 31, true)-- S (fault in Keys table!)
                DisableControlAction(0, 30, true)-- D (fault in Keys table!)
                
                DisableControlAction(0, Keys["R"], true)-- Reload
                DisableControlAction(0, Keys["SPACE"], true)-- Jump
                DisableControlAction(0, Keys["Q"], true)-- Cover
                DisableControlAction(0, Keys["TAB"], true)-- Select Weapon
                DisableControlAction(0, Keys["F"], true)-- Also 'enter'?
                
                DisableControlAction(0, Keys["F1"], true)-- Disable phone
                DisableControlAction(0, Keys["F2"], true)-- Inventory
                DisableControlAction(0, Keys["F3"], true)-- Animations
                DisableControlAction(0, Keys["F6"], true)-- Job
                
                DisableControlAction(0, Keys["V"], true)-- Disable changing view
                DisableControlAction(0, Keys["C"], true)-- Disable looking behind
                DisableControlAction(0, Keys["X"], true)-- Disable clearing animation
                DisableControlAction(2, Keys["P"], true)-- Disable pause screen
                
                DisableControlAction(0, 59, true)-- Disable steering in vehicle
                DisableControlAction(0, 71, true)-- Disable driving forward in vehicle
                DisableControlAction(0, 72, true)-- Disable reversing in vehicle
                
                DisableControlAction(2, Keys["LEFTCTRL"], true)-- Disable going stealth
                
                DisableControlAction(0, 47, true)-- Disable weapon
                DisableControlAction(0, 264, true)-- Disable melee
                DisableControlAction(0, 257, true)-- Disable melee
                DisableControlAction(0, 140, true)-- Disable melee
                DisableControlAction(0, 141, true)-- Disable melee
                DisableControlAction(0, 142, true)-- Disable melee
                DisableControlAction(0, 143, true)-- Disable melee
                DisableControlAction(0, 75, true)-- Disable exit vehicle
                DisableControlAction(27, 75, true)-- Disable exit vehicle
            end
        end
    end
)
-- HIDE WEAPON WHEEL
--Citizen.CreateThread(function()
    --Citizen.Wait(2000)
    --while true do
        --Citizen.Wait(0)
        --HideHudComponentThisFrame(19)
        --HideHudComponentThisFrame(20)
        --BlockWeaponWheelThisFrame()
        --DisableControlAction(0, Keys["TAB"], true)
    --end
--end)

--FAST ITEMS
RegisterNUICallback(
    "PutIntoFast",
    function(data, cb)
        if data.item.slot ~= nil then
            fastWeapons[data.item.slot] = nil
        end
        fastWeapons[data.slot] = data.item.name
        TriggerServerEvent("esx_inventoryhud:changeFastItem", data.slot, data.item.name)
        loadPlayerInventory()
        cb("ok")
    end
)
RegisterNUICallback(
    "TakeFromFast",
    function(data, cb)
        fastWeapons[data.item.slot] = nil
        TriggerServerEvent("esx_inventoryhud:changeFastItem", 0, data.item.name)
        loadPlayerInventory()
        cb("ok")
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if IsDisabledControlJustReleased(1, Keys["1"]) then
                if fastWeapons[1] ~= nil then
                    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[1]) then
                        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                    else
                        SetCurrentPedWeapon(PlayerPedId(), fastWeapons[1], true)
                    end
                end
            end
            if IsDisabledControlJustReleased(1, Keys["2"]) then
                if fastWeapons[2] ~= nil then
                    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[2]) then
                        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                    else
                        SetCurrentPedWeapon(PlayerPedId(), fastWeapons[2], true)
                    end
                end
            end
            if IsDisabledControlJustReleased(1, Keys["3"]) then
                if fastWeapons[3] ~= nil then
                    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[3]) then
                        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                    else
                        SetCurrentPedWeapon(PlayerPedId(), fastWeapons[3], true)
                    end
                end
            end
            if IsDisabledControlJustReleased(1, Keys["4"]) then
                if fastWeapons[4] ~= nil then
                    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[4]) then
                        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                    else
                        SetCurrentPedWeapon(PlayerPedId(), fastWeapons[4], true)
                    end
                end
            end
            if IsDisabledControlJustReleased(1, Keys["5"]) then
                if fastWeapons[5] ~= nil then
                    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[5]) then
                        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                    else
                        SetCurrentPedWeapon(PlayerPedId(), fastWeapons[5], true)
                    end
                end
            end
        end
    end
)
--Add Items--
RegisterNetEvent('esx_inventoryhud:client:addItem')
AddEventHandler('esx_inventoryhud:client:addItem', function(itemname, itemlabel)
    local data = {name = itemname, label = itemlabel}
    SendNUIMessage({type = "addInventoryItem", addItemData = data})
end)

--Ammo clips--
local weapons = {}

RegisterNetEvent('yisus_cargador:clipLoad')
AddEventHandler('yisus_cargador:clipLoad', function()
    weapons = ESX.GetWeaponList()
    local ped = PlayerPedId()
    local actualWeapon
    if IsPedArmed(ped, 4) then
        hash = GetSelectedPedWeapon(ped)
        if hash ~= nil then
            actualWeapon = GetWeaponFromHash(hash)
            TriggerServerEvent('yisus_cargador:onClipUse', actualWeapon)
            ESX.ShowNotification("Has utilizado un cargador")
        else
            ESX.ShowNotification("No tienes ninguna arma en la mano")
        end
    else
        ESX.ShowNotification("No tienes el arma en la mano")
    end
end)

function GetWeaponFromHash(hash)
    for name, item in pairs(weapons) do
        if hash == GetHashKey(item.name) then
            return item.name
        end
    end
end
