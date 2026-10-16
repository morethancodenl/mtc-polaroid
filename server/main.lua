local QBCore = exports['qb-core']:GetCoreObject()

-- Reads your fivemanage key dynamically from the server convar config
local function GetFivemanageKey()
    return GetConvar("fivemanage_key", "") -- Make sure to add: set fivemanage_key "YOUR FIVEMANAGE KEY" into your server.cfg!
end

RegisterNetEvent("mtc-polaroid:server:getimage", function(url, name)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    -- Forces the inventory engine to verify and delete exactly 1 paper item from your slots
    if Player.Functions.RemoveItem("polaroid_paper", 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["polaroid_paper"], "remove")

        -- Compiles the final photo metadata array so it pops up cleanly when used
        local info = {
            url = url,
            name = name,
            date = os.date("%d-%m-%Y")
        }
        
        Player.Functions.AddItem("polaroid", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["polaroid"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any polaroid paper remaining!", "error")
    end
end)

-- Safe callback routing
QBCore.Functions.CreateCallback('mtc-polaroid:server:webhook', function(source, cb, args)
    local key = GetFivemanageKey()
    cb(key)
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
        -- Triggers your UI overlay to pop up the image on your screen
        TriggerClientEvent("mtc-polaroid:client:showImage", src, item[metadata].url, item[metadata].name, item[metadata].date)
    end
end)
