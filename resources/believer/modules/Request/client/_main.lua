GM.Request = GM.Request or {}

RegisterNetEvent("Request:sendMessage", function(message)
    if (message == nil) then return end

    ESX.ShowNotification(message.."\n"..GM.Request.Controls["accept"].icon.." : ~g~Accepter~s~ "..GM.Request.Controls["decline"].icon.." : ~r~Refuser~s~")

    local delay = 0
    while true do
        if IsControlJustReleased(0, GM.Request.Controls["accept"].key) then
            TriggerServerEvent("Request:sendResponse", "accept")
            break
        elseif IsControlJustReleased(0, GM.Request.Controls["decline"].key) then
            TriggerServerEvent("Request:sendResponse", "decline")
            break
        end

        if delay == 700 then
            TriggerServerEvent("Request:sendResponse", "delay")
            break
        end

        delay = delay + 1

        Wait(1)
    end
end)

RegisterNetEvent("Request:sendCallMessage", function(sender, subject, textureDict, data)
    if (sender == nil or subject == nil or textureDict == nil) then return end

    

    local dist = math.floor(#(GetEntityCoords(PlayerPedId()) - data["position"]))
    local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(data["position"].x, data["position"].y, data["position"].z)).." ("..math.ceil(dist).."m)"

    msg = "~b~Localisation : ~s~"..streetName.."\n~b~Infos : ~s~"..data["message"].."\n\nAppuyez sur ~b~"..GM.Request.Controls["accept"].icon.."~s~ pour ~b~prendre l'appel~s~."

    -- Todo mettre un son pour l'appel et pouvoir le désactiver dans le menu préférences

    ESX.ShowAdvancedNotification(sender, subject, msg, textureDict, options)

    local delay = 0
    while true do
        if IsControlJustReleased(0, GM.Request.Controls["accept"].key) then
            TriggerServerEvent("Request:sendResponse", "accept")
            break
        elseif IsControlJustReleased(0, GM.Request.Controls["decline"].key) then
            TriggerServerEvent("Request:sendResponse", "decline")
            break
        end

        if delay == 700 then
            TriggerServerEvent("Request:sendResponse", "delay")
            break
        end

        delay = delay + 1

        Wait(1)
    end
end)