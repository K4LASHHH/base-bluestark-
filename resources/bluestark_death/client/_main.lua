local display = false
local time = exports["believer"]:getDeathTime() or 5 * 60

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool,
        time = time
    })
end

RegisterNUICallback('respawn', function ()
    TriggerServerEvent("Ambulance:revivePlayerToHospital")
end)

RegisterNUICallback('sendDispatch', function()
    TriggerServerEvent("Ambulance:sendCall")
end)

RegisterNetEvent("Dead:openUI")
AddEventHandler("Dead:openUI", function(bool)
    SetDisplay(bool)
end)

RegisterNetEvent("Dead:resetUI")
AddEventHandler("Dead:resetUI", function()
    SendNUIMessage({
        type = "reset",
    })
end)