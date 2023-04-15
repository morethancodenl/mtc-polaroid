local function ShowImage(url, name, date)
    SendNUIMessage({
        type = "image",
        url = url,
        name = name,
        date = date
    })
    SetNuiFocus(true, true)
end

RegisterNuiCallback("hide", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNetEvent("mtc-polaroid:client:showImage", ShowImage)