GM.Police.registeredZones = {}
GM.Police.registeredZones["lockers"] = {}
GM.Police.registeredZones["garages"] = {}
GM.Police.registeredZones["duty"] = {}
GM.Police.registeredZones["wardrobe"] = {}
GM.Police.registeredZones["armory"] = {}

GM.Police.registeredBlips = {}
GM.Police.registeredBlips["lockers"] = {}
GM.Police.registeredBlips["garages"] = {}
GM.Police.registeredBlips["duty"] = {}
GM.Police.registeredBlips["wardrobe"] = {}
GM.Police.registeredBlips["armory"] = {}
GM.Police.registeredBlips["calls"] = {}

GM.Police.registeredPeds = {}
GM.Police.registeredPeds["garages"] = {}
GM.Police.registeredPeds["duty"] = {}
GM.Police.registeredPeds["wardrobe"] = {}

GM.Police.registeredCalls = {}
GM.Police.registeredCalls["list"] = {}
GM.Police.registeredCalls["accepted"] = {}

GM.Police.handcuffs = {}
GM.Police.handcuffs["list"] = {}

GM:newThread(function()
    while (GM.Police.Locker == nil) do
        Wait(100)
    end

    for i = 1, #GM.Police.Locker do
        local lockerId = "lockers_" .. i
        local locker = GM.Police.Locker[i]

        GM.Police.registeredZones["lockers"][lockerId] = GM.Zone.Management:create(GM.Police.Locker[i], 2.0, "pour accéder à votre casier", function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local selectedStash = exports["believer"]:GetInventory("police_locker_"..playerSelected.identifier.."_"..i)
            if (selectedStash == nil) then
                exports["believer"]:RegisterStash({
                    isPublic = false,
                    isPermanent = true,
                    ownerLicense = playerSelected.identifier,
                    inventoryName = "Casier "..playerSelected.getName(),
                    maxWeight = 200,
                    slotsAmount = 30,
                    uniqueID = "police_locker_"..playerSelected.identifier.."_"..i,
                })
                exports["believer"]:OpenStash(playerSelected.source, "police_locker_"..playerSelected.identifier.."_"..i)
            else
                exports["believer"]:OpenStash(playerSelected.source, "police_locker_"..playerSelected.identifier.."_"..i)
            end
            TriggerClientEvent("Inventory:openInventory", playerSelected.source)
        end, {
            private = true,
            marker = true
        })

        GM.Police.registeredBlips["lockers"][lockerId] = GM.Blip:add(locker, {
            sprite = 1,
            colour = 3,
            name = "Police - Casier - "..i,
            --display = 5,
        }, {
            isPrivate = true
        })
    end
end)

GM:newThread(function()
    while (GM.Police.Garage == nil) do
        Wait(100)
    end
    
    for i = 1, #GM.Police.Garage do
        local garageId = "garages_" .. i
        local garage = GM.Police.Garage[i]

        GM.Police.registeredZones["garages"][garageId] = GM.Zone.Management:create(garage.position, 3.0, garage.helpNotification, function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local playerIsInVehicle = GetVehiclePedIsIn(GetPlayerPed(playerSrc), false)
            if (playerIsInVehicle == 0) then
                TriggerClientEvent("Police:openGarage", playerSelected.source, {
                    garageId = garageId,
                    garageVehicle = garage.vehicles.list,
                    garagePosition = garage.vehicles.position
                })
            else
                -- Todo check if vehicle is registered in databse and stored it and ownn it
                DeleteEntity(playerIsInVehicle)
            end
        end, {
            private = true,
            marker = true
        })

        GM.Police.registeredBlips["garages"][garageId] = GM.Blip:add(garage.position, {
            sprite = 1,
            colour = 3,
            name = "Police - Garage - "..i,
            --display = 5,
        }, {
            isPrivate = true
        })

        GM.Police.registeredPeds["garages"][garageId] = GM.Ped:create(9, garage.ped["model"], {
            x = garage.ped["position"].x,
            y = garage.ped["position"].y,
            z = garage.ped["position"].z
        }, garage.ped["heading"])

        -- Todo check for freeze and set attributes
    end
end)

GM:newThread(function()
    while (GM.Police.Duty == nil) do
        Wait(100)
    end
    
    for i = 1, #GM.Police.Duty do
        local dutyId = "dutys_" .. i
        local duty = GM.Police.Duty[i]

        GM.Police.registeredZones["duty"][dutyId] = GM.Zone.Management:create(duty.position, 2.0, duty.helpNotification, function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            TriggerEvent("Service:interact", playerSelected.source)
        end, {
            private = true,
            marker = true
        })

        GM.Police.registeredBlips["duty"][dutyId] = GM.Blip:add(duty.position, {
            sprite = 1,
            colour = 3,
            name = "Police - Prise de service - "..i,
            --display = 5,
        }, {
            isPrivate = true
        })

        GM.Police.registeredPeds["duty"][dutyId] = GM.Ped:create(9, duty.ped["model"], {
            x = duty.ped["position"].x,
            y = duty.ped["position"].y,
            z = duty.ped["position"].z
        }, duty.ped["heading"])

        -- Todo check for freeze and set attributes
    end
end)

GM:newThread(function()
    while (GM.Police.Wardrobe == nil) do
        Wait(100)
    end
    
    for i = 1, #GM.Police.Wardrobe do
        local wardrobeId = "wardrobes_" .. i
        local cloakroom = GM.Police.Wardrobe[i]

        GM.Police.registeredZones["wardrobe"][wardrobeId] = GM.Zone.Management:create(cloakroom.position, 2.0, cloakroom.helpNotification, function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            TriggerClientEvent("Police:openWardrobe", playerSelected.source, {
                outfits = cloakroom.outfits,
            })
        end, {
            private = true,
            marker = true
        })

        GM.Police.registeredBlips["wardrobe"][wardrobeId] = GM.Blip:add(cloakroom.position, {
            sprite = 1,
            colour = 3,
            name = "Police - Vestiaire - "..i,
            --display = 5,
        }, {
            isPrivate = true
        })
    end
end)

GM:newThread(function()
    while (GM.Police.Armory == nil) do
        Wait(100)
    end
    
    for i = 1, #GM.Police.Armory do
        local armoryId = "armorys_" .. i
        local armory = GM.Police.Armory[i]

        GM.Police.registeredZones["armory"][armoryId] = GM.Zone.Management:create(armory.position, 3.0, armory.helpNotification, function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            TriggerClientEvent("Police:openArmory", playerSelected.source, {
                armoryId = i,
                items = armory.items,
            })
        end, {
            private = true,
            marker = true
        })

        GM.Police.registeredBlips["armory"][armoryId] = GM.Blip:add(armory.position, {
            sprite = 1,
            colour = 3,
            name = "Police - Armurerie - "..i,
            --display = 5,
        }, {
            isPrivate = true
        })
    end
end)

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name == "police") then
        for i = 1, #GM.Police.Garage do
            local garageId = "garages_" .. i
    
            GM.Police.registeredZones["garages"][garageId]:allowedPlayer(playerSelected.source)
    
            GM.Police.registeredBlips["garages"][garageId]:allowedPlayer(playerSelected.source)
        end

        for i = 1, #GM.Police.Locker do
            local lockerId = "lockers_" .. i
    
            GM.Police.registeredZones["lockers"][lockerId]:allowedPlayer(playerSelected.source)
    
            GM.Police.registeredBlips["lockers"][lockerId]:allowedPlayer(playerSelected.source)
        end

        for i = 1, #GM.Police.Duty do
            local dutyId = "dutys_" .. i
    
            GM.Police.registeredZones["duty"][dutyId]:allowedPlayer(playerSelected.source)
    
            GM.Police.registeredBlips["duty"][dutyId]:allowedPlayer(playerSelected.source)
        end

        for i = 1, #GM.Police.Wardrobe do
            local wardrobeId = "wardrobes_" .. i
    
            GM.Police.registeredZones["wardrobe"][wardrobeId]:allowedPlayer(playerSelected.source)
    
            GM.Police.registeredBlips["wardrobe"][wardrobeId]:allowedPlayer(playerSelected.source)
        end

        for i = 1, #GM.Police.Armory do
            local armoryId = "armorys_" .. i
    
            GM.Police.registeredZones["armory"][armoryId]:allowedPlayer(playerSelected.source)
    
            GM.Police.registeredBlips["armory"][armoryId]:allowedPlayer(playerSelected.source)
        end
    end
end)

RegisterServerEvent("Police:spawnVehicle", function(vehicleName, garagePosition)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    local upgrades = {
        modEngine = 4,
        modBrakes = 4,
        modTransmission = 4,
        modSuspension = 4,
        modArmor = false,
    }

    local playerPed = playerSelected.getPed()
    if (not playerPed) then return end

    ESX.OneSync.SpawnVehicle(vehicleName, vector3(garagePosition.x, garagePosition.y, garagePosition.z), garagePosition.w, {}, function(networkId)
        if networkId then
            local vehicle = NetworkGetEntityFromNetworkId(networkId)
            for i = 1, 20 do
                Wait(0)
                SetPedIntoVehicle(playerPed, vehicle, -1)
        
                if GetVehiclePedIsIn(playerPed, false) == vehicle then
                    break
                end
            end
        end
    end)
end)

RegisterServerEvent("Police:armory:giveBackItems", function()
    -- Todo remove every equipement from police player
end)

RegisterServerEvent("Police:armory:giveBackMunitions", function()
    -- Todo remove every equipement from police player
end)

RegisterServerEvent("Police:armory:takeItem", function(armoryId, itemName)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    -- Todo check position of player

    if (not GM.Police.Armory[armoryId]) then
        playerSelected.showNotification("~r~L'armurerie n'existe pas.")
        return
    end

    for i = 1, #GM.Police.Armory[armoryId].items do
        local item = GM.Police.Armory[armoryId].items[i]
        if (item.name == itemName) then
            if (item.price) then
                if (playerSelected.getMoney() >= item.price) then
                    playerSelected.removeMoney(item.price)
                else
                    playerSelected.showNotification("~r~Vous n'avez pas assez d'argent.")
                    return
                end
            end
            if (playerSelected.canCarryItem(item.name, 1)) then
                playerSelected.addInventoryItem(item.name, 1)
                playerSelected.showNotification("~g~Vous avez pris un(e) "..item.label..".")
            else
                playerSelected.showNotification("~r~Vous ne pouvez pas prendre cet item.")
            end
        end
    end
end)

RegisterServerEvent("Police:menu:backup", function(backupName)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    for i = 1, #GM.Police.Menu.backup do
        local backup = GM.Police.Menu.backup[i]
        if (backup.name == backupName) then

            if (playerSelected.job.grade >= backup.grade) then
                local callId = (#GM.Police.registeredCalls["list"] + 1)
                if (not callId) then return end

                GM.Police.registeredCalls["list"][tonumber(callId)] = {
                    source = playerSelected.source,
                    id = callId,
                    name = backup.name,
                    label = backup.label,
                    message = backup.message,
                    position = playerSelected.getCoords(true),
                    time = os.date("%H:%M"),
                    playerName = playerSelected.getName(),
                    taken = {},
                }

                SetTimeout(GM.Police.callDelete * 60000, function()
                    if (GM.Police.registeredCalls["list"][tonumber(callId)]) then
                        GM.Police.registeredCalls["list"][tonumber(callId)] = nil
                    end
                    if (GM.Police.registeredBlips["calls"][callId]) then
                        GM.Police.registeredBlips["calls"][callId]:delete()
                        GM.Police.registeredBlips["calls"][callId] = nil
                    end

                    for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["police"]) do
                        TriggerClientEvent("Police:removeValue", playerSrc, "call", callId)
                    end
                end)

                GM.Police.registeredBlips["calls"][callId] = GM.Blip:add(GM.Police.registeredCalls["list"][tonumber(callId)].position, {
                    sprite = 1,
                    colour = 3,
                    name = i.." - "..GM.Police.registeredCalls["list"][tonumber(callId)].label,
                    route = true,
                }, {
                    isPrivate = true
                })

                if (GM.Service["Enterprise_list"]) then
                    if (GM.Service["Enterprise_list"]["police"] == nil) then
                        GM.Service["Enterprise_list"]["police"] = {}
                    end
                    for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["police"]) do

                        if (playerSrc ~= playerSelected.source) then
                        
                            local request = GM.Request:sendCallMessage(playerSrc, "Centrale", "Appel d'urgence - "..callId, "CALL", {
                                position = GM.Police.registeredCalls["list"][tonumber(callId)].position,
                                callId = callId,
                                message = GM.Police.registeredCalls["list"][tonumber(callId)].message,
                            })
                            if (request == "accept") then
                                local acceptPlayer = ESX.GetPlayerFromId(playerSrc)
                                if (acceptPlayer) then
                                    TriggerClientEvent("esx:showNotification", acceptPlayer.source, "~g~Vous avez accepté l'appel.")

                                    if (GM.Police.registeredCalls["list"][tonumber(callId)].taken == nil) then
                                        GM.Police.registeredCalls["list"][tonumber(callId)].taken = {}
                                    end
    
                                    if (GM.Police.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] == nil) then
                                        GM.Police.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] = acceptPlayer.getName()
                                    end

                                    if (GM.Police.registeredCalls["accepted"][acceptPlayer.source] ~= nil) then
                                        if (GM.Police.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] ~= nil) then
                                            GM.Police.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] = nil
                                            -- Todo remove for every police player in service in client value
                                        end
                                        GM.Police.registeredBlips["calls"][GM.Police.registeredCalls["accepted"][acceptPlayer.source]]:allowedPlayer(acceptPlayer.source, false)
                                    end
                                    
                                    GM.Police.registeredBlips["calls"][callId]:allowedPlayer(acceptPlayer.source)
                                    GM.Police.registeredCalls["accepted"][acceptPlayer.source] = callId

                                    TriggerClientEvent("Police:call:onAccept", acceptPlayer.source, {
                                        onActive = true,
                                        callId = callId,
                                        position = GM.Police.registeredCalls["list"][tonumber(callId)].position,
                                    })
                                end

                                for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["police"]) do
                                    local policePlayer = ESX.GetPlayerFromId(playerSrc)
                                    if (policePlayer) then
                                        if (policePlayer.source ~= acceptPlayer.source) then
                                            TriggerClientEvent("esx:showNotification", policePlayer.source, "L'appel à été pris par ~g~"..acceptPlayer.getName().."~s~.")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                playerSelected.showNotification("~r~Vous n'avez pas le grade requis.")
                return
            end
        end
    end
end)

RegisterServerEvent("Police:call:finish", function(callId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    if (GM.Police.registeredCalls["list"][tonumber(callId)] ~= nil) then
        if (GM.Police.registeredCalls["list"][tonumber(callId)].taken ~= nil) then
            if (GM.Police.registeredCalls["list"][tonumber(callId)].taken[playerSelected.source] ~= nil) then
                GM.Police.registeredCalls["list"][tonumber(callId)].taken[playerSelected.source] = nil
            end
        end
    end

    if (GM.Police.registeredCalls["accepted"][playerSelected.source] ~= nil) then
        GM.Police.registeredCalls["accepted"][playerSelected.source] = nil
    end

    if (GM.Police.registeredBlips["calls"][callId] ~= nil) then
        GM.Police.registeredBlips["calls"][callId]:allowedPlayer(playerSelected.source, false)
    end

    TriggerClientEvent("Police:removeValue", playerSelected.source, "callId")
end)

RegisterServerEvent("Police:menu:quitJob", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    local canQuit = true

    for i = 1, #GM.Police.QuitJob do
        local item = GM.Police.QuitJob[i]
        local itemQuantity = exports["believer"]:GetItemQuantityBy(playerSelected.source, {
            name = item.name,
        })
        if (itemQuantity > 0) then
            playerSelected.showNotification("~r~Vous ne pouvez pas quitter votre emploi car vous avez ("..itemQuantity..") "..item.label..".")
            canQuit = false
        end
    end

    if (canQuit == false) then return end 

    playerSelected.setJob("unemployed", 0)
    playerSelected.showNotification("~g~Vous avez quitté votre emploi.")
end)

RegisterServerEvent("Police:menu:requestCalls", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    TriggerClientEvent("Police:updateValue", playerSelected.source, "call", GM.Police.registeredCalls["list"])
end)

RegisterServerEvent("Police:call:accept", function(callId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    if (GM.Police.registeredCalls["list"][tonumber(callId)] ~= nil) then

        if (GM.Police.registeredCalls["list"][tonumber(callId)].source == playerSelected.source) then
            playerSelected.showNotification("~r~Vous ne pouvez pas prendre votre propre appel.")
            return
        end

        if (GM.Police.registeredCalls["list"][tonumber(callId)].taken == nil) then
            GM.Police.registeredCalls["list"][tonumber(callId)].taken = {}
        end

        if (GM.Police.registeredCalls["list"][tonumber(callId)].taken[playerSelected.source] == nil) then
            table.insert(GM.Police.registeredCalls["list"][tonumber(callId)].taken, {
                source = playerSelected.source,
                name = playerSelected.getName(),
            })
        end

        if (GM.Police.registeredCalls["accepted"][playerSelected.source] ~= nil) then
            if (GM.Police.registeredCalls["list"][tonumber(callId)].taken[playerSelected.source] ~= nil) then
                GM.Police.registeredCalls["list"][tonumber(callId)].taken[playerSelected.source] = nil
                for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["police"]) do
                    TriggerClientEvent("Police:updateValue", playerSrc, "call", callId, GM.Police.registeredCalls["list"][tonumber(callId)])
                end
            end
            GM.Police.registeredBlips["calls"][GM.Police.registeredCalls["accepted"][playerSelected.source]]:allowedPlayer(playerSelected.source, false)
        end
        
        GM.Police.registeredBlips["calls"][callId]:allowedPlayer(playerSelected.source)
        GM.Police.registeredCalls["accepted"][playerSelected.source] = callId

        TriggerClientEvent("Police:call:onAccept", playerSelected.source, {
            onActive = true,
            callId = callId,
            position = GM.Police.registeredCalls["list"][tonumber(callId)].position,
        })

        for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["police"]) do
            local policePlayer = ESX.GetPlayerFromId(playerSrc)
            if (policePlayer) then
                if (policePlayer.source ~= playerSelected.source) then
                    TriggerClientEvent("esx:showNotification", policePlayer.source, "L'appel à été pris par ~g~"..playerSelected.getName().."~s~.")
                end
            end
        end
    end
end)

RegisterServerEvent("Police:menu:status", function(statusName)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    for i = 1, #GM.Police.Menu.status do
        local status = GM.Police.Menu.status[i]
        if (status.name == statusName) then
            for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["police"]) do
                local policePlayer = ESX.GetPlayerFromId(playerSrc)
                if (policePlayer) then
                    if (policePlayer.source ~= playerSelected.source) then
                        TriggerClientEvent("esx:showNotification", policePlayer.source, "~b~POLICE~s~\n"..playerSelected.getName().." : "..status.label)
                    end
                end
            end
        end
    end
end)

RegisterServerEvent("Police:menu:interaction:amende", function(billReason, billAmount)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    -- Todo check this
end)

RegisterServerEvent("Police:item:handcuffs", function(targetId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerPosition = playerSelected.getCoords(true)

    if (playerSelected.getJob().name ~= "police") then
        playerSelected.showNotification("~r~Vous n'êtes pas policier.")
        return
    end

    local targetSelected = ESX.GetPlayerFromId(targetId)
    if (not targetSelected) then return end

    local targetPosition = targetSelected.getCoords(true)

    if (#(playerPosition - targetPosition) > 3.0) then
        playerSelected.showNotification("~r~Vous êtes trop loin de la personne.")
        return
    end

    local itemQuantity = exports["believer"]:GetItemQuantityBy(playerSelected.source, {
        name = "handcuffs",
    })

    if (itemQuantity <= 0) then
        playerSelected.showNotification("~r~Vous n'avez pas de menottes.")
        return
    end

    if (GM.Police.handcuffs["list"][targetSelected.source] ~= nil) then
        targetSelected.showNotification("~b~Vous avez été libéré des menottes.")
        playerSelected.showNotification("~b~Vous avez libéré la personne.")
        TriggerClientEvent("Police:item:handcuffs:animationUnused", playerSelected.source)
        TriggerClientEvent("Police:removeValue", targetSelected.source, "handcuffs")
        TriggerClientEvent("Police:item:handcuffs:unUsed", targetSelected.source)
        GM.Police.handcuffs["list"][targetSelected.source] = nil
        return
    end

    GM.Police.handcuffs["list"][targetSelected.source] = true

    targetSelected.showNotification("~b~Vous avez été menotté.")
    playerSelected.showNotification("~b~Vous avez menotté la personne.")

    TriggerClientEvent("Police:item:handcuffs:animationUse", playerSelected.source)
    TriggerClientEvent("Police:updateValue", targetSelected.source, "handcuffs", true)
    TriggerClientEvent("Police:item:handcuffs:onUse", targetSelected.source)
end)