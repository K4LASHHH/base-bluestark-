GM.Admin = GM.Admin or {}

RegisterServerEvent("Admin:deleteVehicles", function(radius)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    if (not playerRank:getPermissionsValue("AROUND_ME_VEHICLES", playerSelected.source)) then return end

    local vehicles = GetAllVehicles()
    if (not vehicles) then return end

    local playerCoords = GetEntityCoords(GetPlayerPed(playerSrc))
    if (not playerCoords) then return end

    if (radius == nil or radius == "") then radius = 10.0 end

    radius = tonumber(radius)

    if (radius >= 100.0) then
        playerSelected.showNotification("~r~Vous ne pouvez pas supprimer les véhicules à plus de 100m.\nRadius appliqué à 100m automatiquement.")
        radius = 100.0
    end

    for _, vehicle in pairs(vehicles) do
        local vehicleCoords = GetEntityCoords(vehicle)
        if (not vehicleCoords) then return end

        local distance = #(playerCoords - vehicleCoords)
        if (distance <= radius) then
            DeleteEntity(vehicle)
        end
    end
    playerSelected.showNotification("~b~Les véhicules ont bien été supprimés.")
end)

RegisterServerEvent("Admin:deletePnjs", function(radius)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    if (not playerRank:getPermissionsValue("AROUND_ME_PNJS", playerSelected.source)) then return end

    local peds = GetAllPeds()
    if (not peds) then return end

    local playerCoords = GetEntityCoords(GetPlayerPed(playerSrc))
    if (not playerCoords) then return end

    if (radius == nil or radius == "") then 
        radius = 10.0 
    end

    radius = tonumber(radius)

    if (radius >= 100.0) then
        playerSelected.showNotification("~r~Vous ne pouvez pas supprimer les PNJs à plus de 100m.\nRadius appliqué à 100m automatiquement.")
        radius = 100.0
    end

    for _, ped in pairs(peds) do
        local pedCoords = GetEntityCoords(ped)
        if (not pedCoords) then return end

        local distance = #(playerCoords - pedCoords)
        if (distance <= radius) then
            DeleteEntity(ped)
        end
    end
    playerSelected.showNotification("~b~Les PNJs ont bien été supprimés.")
end)

RegisterServerEvent("Admin:deleteObjects", function(radius)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    if (not playerRank:getPermissionsValue("AROUND_ME_OBJECTS", playerSelected.source)) then return end

    local objects = GetAllObjects()
    if (not objects) then return end

    local playerCoords = GetEntityCoords(GetPlayerPed(playerSrc))
    if (not playerCoords) then return end

    if (radius == nil or radius == "") then 
        radius = 10.0 
    end

    radius = tonumber(radius)

    if (radius >= 100.0) then
        playerSelected.showNotification("~r~Vous ne pouvez pas supprimer les objects à plus de 100m.\nRadius appliqué à 100m automatiquement.")
        radius = 100.0
    end

    for _, object in pairs(objects) do
        local objectCoords = GetEntityCoords(object)
        if (not objectCoords) then return end

        local distance = #(playerCoords - objectCoords)
        if (distance <= radius) then
            DeleteEntity(object)
        end
    end
    playerSelected.showNotification("~b~Les objects ont bien été supprimés.")
end)

RegisterServerEvent("Admin:reviveZone", function(radius)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    if (not playerRank:getPermissionsValue("AROUND_ME_REVIVE", playerSelected.source)) then return end

    local players = GetPlayers()
    if (not players) then return end

    local myCoords = GetEntityCoords(GetPlayerPed(playerSrc))
    if (not myCoords) then return end

    if (radius == nil or radius == "") then 
        radius = 10.0 
    end

    radius = tonumber(radius)

    if (radius >= 100.0) then
        playerSelected.showNotification("~r~Vous ne pouvez pas réanimer les joueurs à plus de 100m.\nRadius appliqué à 100m automatiquement.")
        radius = 100.0
    end

    for _, targetSrc in pairs(GetPlayers()) do
        targetSrc = tonumber(targetSrc)
        if (GetPlayerPed(targetSrc) ~= 0) then
            local playerCoords = GetEntityCoords(GetPlayerPed(targetSrc))
            if (playerCoords) then
                local distance = #(myCoords - playerCoords)
                if (distance <= radius) then
                    local targetSelected = ESX.GetPlayerFromId(targetSrc)
                    if (targetSelected) then
                        if (GM.Death["dead_list"][targetSelected.source] ~= nil) then
                            if (GM.Ambulance["calls_list"][targetSelected.source] ~= nil) then
                                if (GM.Ambulance["calls_list"][targetSelected.source].taken_src) then
                                    TriggerClientEvent("esx:showNotification", GM.Ambulance["calls_list"][targetSelected.source].taken_src, "~r~L'appel en cours à été annulé le patient à été réanimer par un staff.")
                                end
                                GM.Ambulance["calls_list"][targetSelected.source] = nil
                        
                                local ambulanceList = GM.Service:getPeopleService("ambulance")
                            
                                for ambulanceSrc, _ in pairs(ambulanceList) do
                                    TriggerClientEvent("Ambulance:removeValue", ambulanceSrc, "calls", targetSelected.source)
                                end
                            end
                        
                            if (GM.Death["dead_list"][targetSelected.source] ~= nil) then
                                GM.Death["dead_list"][targetSelected.source] = nil
                            end
                        
                            targetSelected.setDead(false)
                            targetSelected.showNotification("~b~Vous avez été réanimer par un staff.")  
                            playerSelected.showNotification("~b~Vous avez réanimer "..targetSelected.getNickName()..".")
                        
                            TriggerClientEvent("Ambulance:revivePlayer", targetSelected.source)
                        end
                    end
                end
            end
        end
    end

    playerSelected.showNotification("~b~Les joueurs ont bien été réanimés.")
end)

RegisterServerEvent("Admin:healZone", function(radius)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    if (not playerRank:getPermissionsValue("AROUND_ME_HEAL", playerSelected.source)) then return end

    local players = GetPlayers()
    if (not players) then return end

    local myCoords = GetEntityCoords(GetPlayerPed(playerSrc))
    if (not myCoords) then return end

    if (radius == nil or radius == "") then 
        radius = 10.0 
    end

    radius = tonumber(radius)

    if (radius >= 100.0) then
        playerSelected.showNotification("~r~Vous ne pouvez pas heal les joueurs à plus de 100m.\nRadius appliqué à 100m automatiquement.")
        radius = 100.0
    end

    for _, targetSrc in pairs(GetPlayers()) do
        targetSrc = tonumber(targetSrc)
        if (GetPlayerPed(targetSrc) ~= 0) then
            local playerCoords = GetEntityCoords(GetPlayerPed(targetSrc))
            if (playerCoords) then
                local distance = #(myCoords - playerCoords)
                if (distance <= radius) then
                    local targetSelected = ESX.GetPlayerFromId(targetSrc)
                    if (targetSelected) then
                        targetSelected.showNotification("~b~Vous avez été heal par un staff.")
                        TriggerClientEvent("Ambulance:healPlayer", targetSelected.source)
                    end
                end
            end
        end
    end

    playerSelected.showNotification("~b~Les joueurs ont bien été heal.")
end)