GM.Blip = GM.Blip or {}
GM.Blip["List"] = {}

function GM.Blip:getFromId(blipId)
    local blips = GM.Blip["List"]
    for i = 1, #blips do
        local selectedBlip = blips[i]
        if (selectedBlip ~= nil and selectedBlip.uniqueId == blipId) then
            return i
        end
    end
end

RegisterNetEvent("Blip:add", function(newBlip)
    if (not newBlip or GM.Blip:getFromId(newBlip.uniqueId) ~= nil) then
        return
    end
    
    local createdBlip = AddBlipForCoord(newBlip.position)
    SetBlipScale(createdBlip, newBlip["blipData"].scale or 0.8)
    SetBlipSprite(createdBlip, newBlip["blipData"].sprite)
    SetBlipColour(createdBlip, newBlip["blipData"].colour)
    SetBlipDisplay(createdBlip, newBlip["blipData"].display or 2)
    SetBlipAlpha(createdBlip, newBlip["blipData"].alpha or 255)

    if (newBlip["blipData"].route and newBlip["blipData"].route == true) then
        SetBlipRoute(createdBlip, newBlip["blipData"].route)
        SetBlipRouteColour(createdBlip, newBlip["blipData"].routeColour or 1)
    end

    AddTextEntry(("BLIP_NAME_"..newBlip.uniqueId), newBlip["blipData"].name)
    BeginTextCommandSetBlipName(("BLIP_NAME_"..newBlip.uniqueId))
    SetBlipCategory(createdBlip, newBlip["blipData"].category or 1)
    SetBlipAsShortRange(createdBlip, newBlip["blipData"].shortRange or true)
    EndTextCommandSetBlipName(createdBlip)

    table.insert(GM.Blip["List"], {
        uniqueId = newBlip.uniqueId,
        createdBlip = createdBlip
    })
end)

RegisterNetEvent("Blip:remove", function(blipId)
    local index = GM.Blip:getFromId(blipId)
    if (not GM.Blip["List"][index]) then
        return
    end
    
    if (DoesBlipExist(GM.Blip["List"][index].createdBlip)) then
        RemoveBlip(GM.Blip["List"][index].createdBlip)
    end

    GM.Blip["List"][index] = nil
end)