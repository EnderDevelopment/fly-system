local ESX = exports['es_extended']:getSharedObject()

local isFlying = false
local flySpeed = Config.FlySpeed
local flyHeight = Config.FlyHeight

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isFlying then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            
            -- Control flight
            if IsControlPressed(0, 32) then -- W
                SetEntityCoords(playerPed, coords.x + flySpeed * math.sin(math.rad(heading)), coords.y + flySpeed * math.cos(math.rad(heading)), coords.z)
            end
            if IsControlPressed(0, 33) then -- S
                SetEntityCoords(playerPed, coords.x - flySpeed * math.sin(math.rad(heading)), coords.y - flySpeed * math.cos(math.rad(heading)), coords.z)
            end
            if IsControlPressed(0, 34) then -- A
                SetEntityCoords(playerPed, coords.x + flySpeed * math.cos(math.rad(heading)), coords.y - flySpeed * math.sin(math.rad(heading)), coords.z)
            end
            if IsControlPressed(0, 35) then -- D
                SetEntityCoords(playerPed, coords.x - flySpeed * math.cos(math.rad(heading)), coords.y + flySpeed * math.sin(math.rad(heading)), coords.z)
            end
            if IsControlPressed(0, 21) then -- Space
                SetEntityCoords(playerPed, coords.x, coords.y, coords.z + flySpeed)
            end
            if IsControlPressed(0, 36) then -- Left Shift
                SetEntityCoords(playerPed, coords.x, coords.y, coords.z - flySpeed)
            end
            
            -- Keep player at a certain height
            if coords.z > flyHeight then
                SetEntityCoords(playerPed, coords.x, coords.y, flyHeight)
            end
        end
    end
end)

RegisterCommand(Config.FlyCommand, function()
    ESX.TriggerServerCallback('fly_system:checkPermission', function(hasPermission)
        if hasPermission then
            isFlying = not isFlying
            local playerPed = PlayerPedId()
            if isFlying then
                SetPedCanRagdoll(playerPed, false)
                SetEntityInvincible(playerPed, true)
                SetEntityVisible(playerPed, false, false)
                ESX.ShowNotification('Fly mode enabled')
            else
                SetPedCanRagdoll(playerPed, true)
                SetEntityInvincible(playerPed, false)
                SetEntityVisible(playerPed, true, false)
                ESX.ShowNotification('Fly mode disabled')
            end
        else
            ESX.ShowNotification('You do not have permission to use this command')
        end
    end)
end, false)

-- Menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 167) then -- F6
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fly_menu', {
                title = Config.MenuTitle,
                align = 'top-left',
                elements = {{
                    label = 'Toggle Fly',
                    value = 'toggle_fly'
                }}
            }, function(data, menu)
                if data.current.value == 'toggle_fly' then
                    ESX.TriggerServerCallback('fly_system:checkPermission', function(hasPermission)
                        if hasPermission then
                            isFlying = not isFlying
                            local playerPed = PlayerPedId()
                            if isFlying then
                                SetPedCanRagdoll(playerPed, false)
                                SetEntityInvincible(playerPed, true)
                                SetEntityVisible(playerPed, false, false)
                                ESX.ShowNotification('Fly mode enabled')
                            else
                                SetPedCanRagdoll(playerPed, true)
                                SetEntityInvincible(playerPed, false)
                                SetEntityVisible(playerPed, true, false)
                                ESX.ShowNotification('Fly mode disabled')
                            end
                        else
                            ESX.ShowNotification('You do not have permission to use this command')
                        end
                    end)
                end
            end, function(data, menu)
                menu.close()
            end)
        end
    end
end)