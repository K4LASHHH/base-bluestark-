Config.Notify = function(textx, type)
    KIBRA.Natives.Notify(type, textx)
end

Config.ServerNotify = function(src, textx)
    if KIBRA.Natives.GetFramework == "ESX" then
        TriggerClientEvent('esx:showNotification', src, textx)
    else
        TriggerClientEvent('QBCore:Notify', src, 'success', textx)
    end
end

Config.HideHud = function()
    TriggerEvent("tgiann-modernHud:ui", false)
end

Config.OpenHud = function()
    TriggerEvent("tgiann-modernHud:ui", true)
end

Config.Show = function(button, text)
    KIBRA.Natives.UI.Show(button, text)
end

Config.Hide = function()
    KIBRA.Natives.UI.Hide()
end

Config.VehicleKeysEvent = "vehiclekeys:client:SetOwner"

Config.VehicleAddKeyEvent = "qb-vehiclekeys:client:AddKeys"

