GM.Admin = GM.Admin or {}

RegisterServerEvent("Admin:repairVehicle", function(vehicleId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    if (not playerRank:getPermissionsValue("VEHICLES_REPAIR", playerSelected.source)) then return end

    playerSelected.showNotification("~b~Le véhicule a été correctement réparé.")

    TriggerClientEvent("Admin:repairVehicle", -1, vehicleId)
end)

RegisterServerEvent("Admin:repairVehicleZones", function(radius)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    if (not playerRank:getPermissionsValue("VEHICLES_REPAIR_ZONES", playerSelected.source)) then return end

    local vehicles = GetAllVehicles()
    if (not vehicles) then return end

    local playerCoords = GetEntityCoords(GetPlayerPed(playerSrc))
    if (not playerCoords) then return end

    if (radius == nil or radius == "") then radius = 10.0 end

    radius = tonumber(radius)

    if (radius >= 100.0) then
        playerSelected.showNotification("~r~Vous ne pouvez pas réparés les véhicules à plus de 100m.\nRadius appliqué à 100m automatiquement.")
        radius = 100.0
    end

    for _, vehicle in pairs(vehicles) do
        local vehicleCoords = GetEntityCoords(vehicle)
        if (not vehicleCoords) then return end

        local distance = #(playerCoords - vehicleCoords)
        if (distance <= radius) then
            TriggerClientEvent("Admin:repairVehicle", -1, NetworkGetNetworkIdFromEntity(vehicle))
        end
    end
    playerSelected.showNotification("~b~Les véhicules ont bien été réparés.")
end)