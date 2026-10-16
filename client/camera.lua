local QBCore = exports['qb-core']:GetCoreObject()

local prop = nil
local cammode = 0

local function TextInput()
    if Config.Input == 'ox' then
        local input = lib.inputDialog('Title for your image', {
            { type = 'input', label = 'Image Title', required = true} 
        })

        return input

    elseif Config.Input == 'qb' then
        local input = exports['qb-input']:ShowInput({
            header = "Enter the title of the image",
            submitText = "Submit",
            inputs = {
                {
                    name = "title",
                    text = "Title",
                    type = "text",
                    isRequired = true,
                }
            }
        })

        return input.title
    else
        print('[MTC] Invalid input type')
        return nil
    end
end

local function GetWebhook()
    local promise = promise.new()

    QBCore.Functions.TriggerCallback('mtc-polaroid:server:webhook', function(webhook)
        promise:resolve(webhook)
    end)

    return Citizen.Await(promise)
end

local function StartAnim()
    local ped = PlayerPedId()
    local animDict = "amb@world_human_paparazzi@male@base"
    local animName = "base"
    local animFlag = 49

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, animFlag, 0, false, false, false)
end

local function AddProp()
    local ped = PlayerPedId()
    local propName = "prop_pap_camera_01"
    local propFlag = 49

    RequestModel(propName)
    while not HasModelLoaded(propName) do
        Citizen.Wait(100)
    end

    prop = CreateObject(GetHashKey(propName), 0, 0, 0, true, true, true)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end

local function StopAnim()
    local ped = PlayerPedId()
    ClearPedTasks(ped)

    if prop ~= nil then
        DeleteEntity(prop)
    end
end

local function TakePicture()
    local token = GetWebhook() -- Fetches your server convar token securely
    local title = TextInput()
    if title == nil then return end

    if token == nil then
        QBCore.Functions.Notify("Error: Missing cloud hosting token on server.", "error")
        return
    end

    -- FIXED PAYLOAD: Targets production endpoints and formats parameters cleanly to prevent quiet crashes
    exports['screenshot-basic']:requestScreenshotUpload('https://api.fivemanage.com/api/v2/image', 'image', {
        headers = {
            ['Authorization'] = token
        }
    }, function(data)
        local response = json.decode(data)
        
        -- Extracts the clean link from Fivemanage's standard layout array wrapper
        if response and response.status == "ok" and response.data and response.data.url then
            TriggerServerEvent("mtc-polaroid:server:getimage", response.data.url, title)
        else
            if response and response.url then
                TriggerServerEvent("mtc-polaroid:server:getimage", response.url, title)
            else
                QBCore.Functions.Notify("Cloud image upload failed.", "error")
                print("[MTC-Polaroid] Fivemanage upload failed. Server payload response: " .. tostring(data))
            end
        end
    end)
end

local function CameraLoop()
    CreateThread(function()
        AddProp()
        StartAnim()

        cammode = GetFollowPedCamViewMode()

        while true do
            DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing    
            Wait(0)
            SetFollowPedCamViewMode(4)        
            if IsControlJustPressed(0, 18) then
                StopAnim()
                Wait(1)
                TakePicture()
                Wait(1)
                SetFollowPedCamViewMode(cammode)
                return
            end
        end
    end)
end

RegisterNetEvent("mtc-polaroid:client:camera", CameraLoop)
