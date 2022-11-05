playerPed = nil

Citizen.CreateThread(
    function()
        if Config and Config.NpcsList and type(Config.NpcsList) == "table" and #Config.NpcsList > 0 then
            for i = 1, #Config.NpcsList do
                CreateNpc(Config.NpcsList[i])
            end
        end
    end
)

function CreateNpc(npc)
    if not npc or type(npc) ~= "table" then
        return
    end
    
    local npcModel = npc["model"]
    local animationBase, animationType = table.unpack(npc["animation"])
    local x, y, z, heading = table.unpack(npc["coords"])
    
    if not IsModelInCdimage(npcModel) or not IsModelAPed(npcModel) then
        return
    end
    
    RequestModel(npcModel)
    
    while not HasModelLoaded(npcModel) do
        Wait(500)
    end
    
    local spawnedNpc = CreatePed(4, npcModel, x, y, z, heading, false, false)
    
    SetModelAsNoLongerNeeded(npcModel)
    
    if not DoesEntityExist(spawnedNpc) then
        return
    end
    
    if npc["animated"] then
        RequestAnimDict(animationBase)
        
        if not HasAnimDictLoaded(animationBase) then
            Wait(500)
        end
        
        TaskPlayAnim(spawnedNpc, animationBase, animationType, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
    
    SetEntityInvincible(spawnedNpc, true)
    SetEntityHeading(spawnedNpc, heading)
    FreezeEntityPosition(spawnedNpc, true)
    SetBlockingOfNonTemporaryEvents(spawnedNpc, true)
    
    
    Citizen.CreateThread(
        function()
            while true do
                Wait(500)
                playerPed = PlayerPedId()
                if IsEntityDead(spawnedNpc) then
                    SetTimeout(
                        5000,
                        function()
                            DeletePed(spawnedNpc)
                        end
                    )
                    Wait(5000)
                    break
                    return
                end
                if not DoesEntityExist(spawnedNpc) then
                    break
                    return
                end
            end
        end
    )
end