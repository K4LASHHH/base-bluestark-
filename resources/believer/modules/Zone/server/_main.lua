GM.Zone = GM.Zone or {}
GM.Zone.List = {}

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSrc = playerSrc
    if (not playerSrc) then return end

    TriggerClientEvent("Zone:init", playerSrc, GM.Zone:getPublic())
end)

RegisterNetEvent("Zone:interact", function(zoneId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (playerSelected == nil) then return end

    local zoneSelected = GM.Zone:get(zoneId)
    if (zoneSelected == nil) then return end

    if (not playerSelected.onPosition(zoneSelected.position, zoneSelected.radius)) then
        return
    end
    
    if (zoneSelected.onUsable ~= nil and type(zoneSelected.onUsable) == "function") then
        zoneSelected.onUsable(playerSrc)
    end
end)