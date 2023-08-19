local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("mtc-polaroid:server:getimage", function(url, name)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player.Functions.RemoveItem("polaroid_paper", 1) then
        TriggerClientEvent('QBCore:Notify', src, "You don't have any polaroid paper", "error")
        return
    end

    Player.Functions.AddItem("polaroid", 1, false, {url = url, name = name, date = os.date("%d-%m-%Y")})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["polaroid"], "add")
end)

QBCore.Functions.CreateCallback('mtc-polaroid:server:webhook', function(source, cb, args)
    cb(Config.Webhook)
end)

QBCore.Functions.CreateUseableItem('polaroid_camera', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("mtc-polaroid:client:camera", src)
    end
end)

QBCore.Functions.CreateUseableItem('polaroid', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local metadata = Config.Inventory == "ox" and "metadata" or "info"

    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("mtc-polaroid:client:showImage", src, item[metadata].url, item[metadata].name, item[metadata].date)
    end
end)
