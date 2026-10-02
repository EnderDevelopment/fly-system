local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('fly_system:checkPermission', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb(xPlayer.getGroup() == Config.FlyPermission)
    else
        cb(false)
    end
end)

-- Load fly status from database
MySQL.Async.fetchAll('SELECT fly_enabled FROM fly_system WHERE identifier = @identifier', {
    ['@identifier'] = GetPlayerIdentifier(source, 0)
}, function(result)
    if result[1] then
        isFlying = result[1].fly_enabled
    end
end)

-- Save fly status to database
RegisterServerEvent('fly_system:saveFlyStatus')
AddEventHandler('fly_system:saveFlyStatus', function(isFlying)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.execute('INSERT INTO fly_system (identifier, fly_enabled) VALUES (@identifier, @fly_enabled) ON DUPLICATE KEY UPDATE fly_enabled = @fly_enabled', {
            ['@identifier'] = GetPlayerIdentifier(source, 0),
            ['@fly_enabled'] = isFlying
        })
    end
end)