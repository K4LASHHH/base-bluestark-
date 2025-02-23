GM.Zone = GM.Zone or {}
GM.Zone.List = {}
GM.Zone.inZone = nil

function GM.Zone:getFromId(zoneId)
    local zones = GM.Zone.List
    for i = 1, #zones do
        local selectedZone = zones[i]
        if (selectedZone ~= nil and selectedZone.uniqueId == zoneId) then
            return selectedZone, i
        end
    end
end

function GM.Zone:onEntered(zoneId)
    if (GM.Zone.inZone ~= nil) then
        return
    end
    
    local selectedZone = self:getFromId(zoneId)
    if (not selectedZone) then
        return
    end

    GM.Zone.inZone = selectedZone
    TriggerEvent("Zone:onEntered", selectedZone)
end

function GM.Zone:onExited()
    local selectedZone = GM.Zone.inZone
    if (selectedZone == nil) then
        return
    end

    TriggerEvent("Zone:onExited", selectedZone)
    GM.Zone.inZone = nil
end

RegisterNetEvent("Zone:init", function(zoneList)
    GM.Zone.List = zoneList
    while true do
        local loopInterval = 1500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i = 1, #GM.Zone.List do
            local thisZone = GM.Zone.List[i]
            if (thisZone ~= nil) then
                if (#(thisZone.position-playerCoords) < thisZone.radius) then
                    loopInterval = 0

                    if (RageUI.CurrentMenu == nil and thisZone.helpText ~= nil) then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~"..thisZone.helpText.."~s~.") 
                    end
                    
                    if (IsControlJustReleased(1, 51)) then
                        TriggerServerEvent("Zone:interact", thisZone.uniqueId)
                    end

                    if (GM.Zone.inZone == nil) then
                        GM.Zone:onEntered(thisZone.uniqueId)
                    end
                elseif (GM.Zone.inZone ~= nil and GM.Zone.inZone["uniqueId"] == thisZone.uniqueId and #(thisZone.position-playerCoords) > thisZone.radius) then
                    loopInterval = 0
                    GM.Zone:onExited(thisZone.uniqueId)
                elseif (thisZone.marker ~= false and (#(thisZone.position-playerCoords) < (thisZone.radius + 10.0))) then
                    loopInterval = 0
                    DrawMarker(25, thisZone.position.x, thisZone.position.y, thisZone.position.z-0.98, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.7, 0.7, 0.7, 46, 134, 193, 178, false, false, false, false)    
                end
            end
        end
        
        Wait(loopInterval)
    end
end)

AddEventHandler("Zone:onEntered", function(enteredZone)
    if (not enteredZone) then
        return
    end
    TriggerServerEvent("Zone:onEntered", enteredZone.uniqueId)
end)

AddEventHandler("Zone:onExited", function(exitedZone)
    if (not exitedZone) then
        return
    end
    TriggerServerEvent("Zone:onExited", exitedZone.uniqueId)
end)

RegisterNetEvent("Zone:add", function(zoneData)
    if (GM.Zone:getFromId(zoneData.uniqueId) ~= nil) then
        return
    end

    table.insert(GM.Zone.List, zoneData)
end)

RegisterNetEvent("Zone:updateValue", function(zoneId, type, value)
    local selectedZone, index = GM.Zone:getFromId(zoneId)
    if (not selectedZone) then
        return
    end
    GM.Zone.List[index][type] = value
end)

RegisterNetEvent("Zone:remove", function(zoneId)
    local selectedZone, index = GM.Zone:getFromId(zoneId)
    if (not selectedZone) then
        return
    end
    GM.Zone.List[index] = nil
end)