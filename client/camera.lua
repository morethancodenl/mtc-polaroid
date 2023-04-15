local QBCore = exports['qb-core']:GetCoreObject()

local prop = nil
local cammode = 0

local function TextInput()
    AddTextEntry("FMMC_KEY_TIP8", "Enter the title of the image")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 100)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        return result
    else
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
    local webhook = GetWebhook()
    local title = TextInput()


    if webhook == nil then
        return
    end

    exports['screenshot-basic']:requestScreenshotUpload(webhook, 'files[]', function(data)
        local image = json.decode(data)
        local url = image.attachments[1].proxy_url
        TriggerServerEvent("mtc-polaroid:server:getimage", url, title)
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