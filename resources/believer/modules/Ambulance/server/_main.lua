GM.Ambulance.registeredZones = {}
GM.Ambulance.registeredZones["lockers"] = {}
GM.Ambulance.registeredZones["garages"] = {}
GM.Ambulance.registeredZones["duty"] = {}
GM.Ambulance.registeredZones["wardrobe"] = {}

GM.Ambulance.registeredBlips = {}
GM.Ambulance.registeredBlips["lockers"] = {}
GM.Ambulance.registeredBlips["garages"] = {}
GM.Ambulance.registeredBlips["duty"] = {}
GM.Ambulance.registeredBlips["wardrobe"] = {}
GM.Ambulance.registeredBlips["calls"] = {}

GM.Ambulance.registeredShops = {}
GM.Ambulance.registeredShops["inventory"] = {}

GM.Ambulance.registeredPeds = {}
GM.Ambulance.registeredPeds["garages"] = {}
GM.Ambulance.registeredPeds["duty"] = {}
GM.Ambulance.registeredPeds["wardrobe"] = {}

GM.Ambulance.registeredCalls = {}
GM.Ambulance.registeredCalls["list"] = {}
GM.Ambulance.registeredCalls["accepted"] = {}
GM.Ambulance.registeredCalls["victim"] = {}

-- GM:newThread(function()
--     while (GM.Ambulance.Locker == nil) do
--         Wait(100)
--     end

--     for i = 1, #GM.Ambulance.Locker do
--         local lockerId = "lockers_" .. i
--         local locker = GM.Ambulance.Locker[i]

--         GM.Ambulance.registeredZones["lockers"][lockerId] = GM.Zone.Management:create(GM.Ambulance.Locker[i], 2.0, "pour accéder à votre casier", function(playerSrc)
--             local playerSelected = ESX.GetPlayerFromId(playerSrc)
--             if (not playerSelected) then return end

--             local selectedStash = exports["believer"]:GetInventory("ambulance_locker_"..playerSelected.identifier.."_"..i)
--             if (selectedStash == nil) then
--                 exports["believer"]:RegisterStash({
--                     isPublic = false,
--                     isPermanent = true,
--                     ownerLicense = playerSelected.identifier,
--                     inventoryName = "Casier "..playerSelected.getName(),
--                     maxWeight = 200,
--                     slotsAmount = 30,
--                     uniqueID = "ambulance_locker_"..playerSelected.identifier.."_"..i,
--                 })
--                 exports["believer"]:OpenStash(playerSelected.source, "ambulance_locker_"..playerSelected.identifier.."_"..i)
--             else
--                 exports["believer"]:OpenStash(playerSelected.source, "ambulance_locker_"..playerSelected.identifier.."_"..i)
--             end
--             TriggerClientEvent("Inventory:openInventory", playerSelected.source)
--         end, {
--             private = true,
--             marker = true
--         })

--         GM.Ambulance.registeredBlips["lockers"][lockerId] = GM.Blip:add(locker, {
--             sprite = 1,
--             colour = 3,
--             name = "Ambulance - Casier - "..i,
--             --display = 5,
--         }, {
--             isPrivate = true
--         })
--     end
-- end)

GM:newThread(function()
    while (GM.Ambulance.Garage == nil) do
        Wait(100)
    end
    
    for i = 1, #GM.Ambulance.Garage do
        local garageId = "garages_" .. i
        local garage = GM.Ambulance.Garage[i]

        GM.Ambulance.registeredZones["garages"][garageId] = GM.Zone.Management:create(garage.position, 3.0, garage.helpNotification, function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local playerIsInVehicle = GetVehiclePedIsIn(GetPlayerPed(playerSrc), false)
            if (playerIsInVehicle == 0) then
                TriggerClientEvent("Ambulance:openGarage", playerSelected.source, {
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

        GM.Ambulance.registeredBlips["garages"][garageId] = GM.Blip:add(garage.position, {
            sprite = 1,
            colour = 3,
            name = "Ambulance - Garage - "..i,
            --display = 5,
        }, {
            isPrivate = true
        })

        GM.Ambulance.registeredPeds["garages"][garageId] = GM.Ped:create(9, garage.ped["model"], {
            x = garage.ped["position"].x,
            y = garage.ped["position"].y,
            z = garage.ped["position"].z
        }, garage.ped["heading"])
    end
end)

-- GM:newThread(function()
--     while (GM.Ambulance.Duty == nil) do
--         Wait(100)
--     end
    
--     for i = 1, #GM.Ambulance.Duty do
--         local dutyId = "dutys_" .. i
--         local duty = GM.Ambulance.Duty[i]

--         GM.Ambulance.registeredZones["duty"][dutyId] = GM.Zone.Management:create(duty.position, 2.0, duty.helpNotification, function(playerSrc)
--             local playerSelected = ESX.GetPlayerFromId(playerSrc)
--             if (not playerSelected) then return end

--             TriggerEvent("Service:interact", playerSelected.source)
--         end, {
--             private = true,
--             marker = true
--         })

--         GM.Ambulance.registeredBlips["duty"][dutyId] = GM.Blip:add(duty.position, {
--             sprite = 1,
--             colour = 3,
--             name = "Ambulance - Prise de service - "..i,
--             --display = 5,
--         }, {
--             isPrivate = true
--         })

--         GM.Ambulance.registeredPeds["duty"][dutyId] = GM.Ped:create(9, duty.ped["model"], {
--             x = duty.ped["position"].x,
--             y = duty.ped["position"].y,
--             z = duty.ped["position"].z
--         }, duty.ped["heading"])
--     end
-- end)

-- GM:newThread(function()
--     while (GM.Ambulance.Wardrobe == nil) do
--         Wait(100)
--     end
    
--     for i = 1, #GM.Ambulance.Wardrobe do
--         local wardrobeId = "wardrobes_" .. i
--         local cloakroom = GM.Ambulance.Wardrobe[i]

--         GM.Ambulance.registeredZones["wardrobe"][wardrobeId] = GM.Zone.Management:create(cloakroom.position, 2.0, cloakroom.helpNotification, function(playerSrc)
--             local playerSelected = ESX.GetPlayerFromId(playerSrc)
--             if (not playerSelected) then return end

--             TriggerClientEvent("Ambulance:openWardrobe", playerSelected.source, {
--                 outfits = cloakroom.outfits,
--             })
--         end, {
--             private = true,
--             marker = true
--         })

--         GM.Ambulance.registeredBlips["wardrobe"][wardrobeId] = GM.Blip:add(cloakroom.position, {
--             sprite = 1,
--             colour = 3,
--             name = "Ambulance - Vestiaire - "..i,
--             --display = 5,
--         }, {
--             isPrivate = true
--         })
--     end
-- end)

-- GM:newThread(function()
--     while (GM.Ambulance.Shop == nil) do
--         Wait(100)
--     end
    
--     for i = 1, #GM.Ambulance.Shop do
--         local shopId = "shops_" .. i
--         local shop = GM.Ambulance.Shop[i]

--         GM.Ambulance.registeredShops["inventory"][shopId] = ScriptServer.Classes.Shop.new(shopId, shop)

--         GM.Ambulance.registeredZones["shop"][shopId] = GM.Zone.Management:create(shop.position, 3.0, shop.helpNotification, function(playerSrc)
--             local playerSelected = ESX.GetPlayerFromId(playerSrc)
--             if (not playerSelected) then return end

--             local shop = ScriptServer.Managers.Shops:GetShop(GM.Ambulance.registeredShops["inventory"][shopId].shopId)
--             if not shop then return end

--             shop:openShop(playerSelected.source)

--             TriggerClientEvent("Inventory:openInventory", playerSelected.source)
--         end, {
--             private = true,
--             marker = true
--         })

--         GM.Ambulance.registeredBlips["shop"][shopId] = GM.Blip:add(shop.position, {
--             sprite = 1,
--             colour = 3,
--             name = "Ambulance - Pharmacie - "..i,
--             --display = 5,
--         }, {
--             isPrivate = true
--         })
--     end
-- end)

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name == "ambulance") then

        for i = 1, #GM.Ambulance.Garage do
            local garageId = "garages_" .. i
    
            GM.Ambulance.registeredZones["garages"][garageId]:allowedPlayer(playerSelected.source)
    
            GM.Ambulance.registeredBlips["garages"][garageId]:allowedPlayer(playerSelected.source)
        end

        -- for i = 1, #GM.Ambulance.Locker do
        --     local lockerId = "lockers_" .. i
    
        --     GM.Ambulance.registeredZones["lockers"][lockerId]:allowedPlayer(playerSelected.source)
    
        --     GM.Ambulance.registeredBlips["lockers"][lockerId]:allowedPlayer(playerSelected.source)
        -- end

        -- for i = 1, #GM.Ambulance.Duty do
        --     local dutyId = "dutys_" .. i
    
        --     GM.Ambulance.registeredZones["duty"][dutyId]:allowedPlayer(playerSelected.source)
    
        --     GM.Ambulance.registeredBlips["duty"][dutyId]:allowedPlayer(playerSelected.source)
        -- end

        -- for i = 1, #GM.Ambulance.Wardrobe do
        --     local wardrobeId = "wardrobes_" .. i
    
        --     GM.Ambulance.registeredZones["wardrobe"][wardrobeId]:allowedPlayer(playerSelected.source)
    
        --     GM.Ambulance.registeredBlips["wardrobe"][wardrobeId]:allowedPlayer(playerSelected.source)
        -- end

        -- for i = 1, #GM.Ambulance.Shop do
        --     local shopId = "shops_" .. i

        --     if (GM.Ambulance.registeredZones["shop"][shopId]) then
        --         GM.Ambulance.registeredZones["shop"][shopId]:allowedPlayer(playerSelected.source)
        --     end

        --     if (GM.Ambulance.registeredBlips["shop"][shopId]) then
        --         GM.Ambulance.registeredBlips["shop"][shopId]:allowedPlayer(playerSelected.source)
        --     end
        -- end
    end
end)

RegisterServerEvent("Ambulance:spawnVehicle", function(vehicleName, garagePosition)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "ambulance") then
        playerSelected.showNotification("~r~Vous n'êtes pas médecin.")
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

RegisterServerEvent("Ambulance:menu:backup", function(backupName)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "ambulance") then
        playerSelected.showNotification("~r~Vous n'êtes pas médecin.")
        return
    end

    for i = 1, #GM.Ambulance.Menu.backup do
        local backup = GM.Ambulance.Menu.backup[i]
        if (backup.name == backupName) then

            if (playerSelected.job.grade >= backup.grade) then
                local callId = (#GM.Ambulance.registeredCalls["list"] + 1)
                if (not callId) then return end

                GM.Ambulance.registeredCalls["list"][tonumber(callId)] = {
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

                SetTimeout(GM.Ambulance.callDelete * 60000, function()
                    if (GM.Ambulance.registeredCalls["list"][tonumber(callId)]) then
                        GM.Ambulance.registeredCalls["list"][tonumber(callId)] = nil
                    end
                    if (GM.Ambulance.registeredBlips["calls"][callId]) then
                        GM.Ambulance.registeredBlips["calls"][callId]:delete()
                        GM.Ambulance.registeredBlips["calls"][callId] = nil
                    end

                    for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do
                        TriggerClientEvent("Ambulance:removeValue", playerSrc, "call", callId)
                    end
                end)

                GM.Ambulance.registeredBlips["calls"][callId] = GM.Blip:add(GM.Ambulance.registeredCalls["list"][tonumber(callId)].position, {
                    sprite = 1,
                    colour = 3,
                    name = i.." - "..GM.Ambulance.registeredCalls["list"][tonumber(callId)].label,
                    route = true,
                }, {
                    isPrivate = true
                })

                if (GM.Service["Enterprise_list"]) then
                    if (GM.Service["Enterprise_list"]["ambulance"] == nil) then
                        GM.Service["Enterprise_list"]["ambulance"] = {}
                    end
                    for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do

                        if (playerSrc ~= playerSelected.source) then
                        
                            local request = GM.Request:sendCallMessage(playerSrc, "Centrale", "Appel d'urgence - "..callId, "CALL", {
                                position = GM.Ambulance.registeredCalls["list"][tonumber(callId)].position,
                                callId = callId,
                                message = GM.Ambulance.registeredCalls["list"][tonumber(callId)].message,
                            })
                            if (request == "accept") then
                                local acceptPlayer = ESX.GetPlayerFromId(playerSrc)
                                if (acceptPlayer) then
                                    TriggerClientEvent("esx:showNotification", acceptPlayer.source, "~g~Vous avez accepté l'appel.")

                                    if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken == nil) then
                                        GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken = {}
                                    end
    
                                    if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] == nil) then
                                        GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] = acceptPlayer.getName()
                                    end

                                    if (GM.Ambulance.registeredCalls["accepted"][acceptPlayer.source] ~= nil) then
                                        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] ~= nil) then
                                            GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken[acceptPlayer.source] = nil
                                            -- Todo remove for every ambulance player in service in client value
                                        end
                                        GM.Ambulance.registeredBlips["calls"][GM.Ambulance.registeredCalls["accepted"][acceptPlayer.source]]:allowedPlayer(acceptPlayer.source, false)
                                    end
                                    
                                    GM.Ambulance.registeredBlips["calls"][callId]:allowedPlayer(acceptPlayer.source)
                                    GM.Ambulance.registeredCalls["accepted"][acceptPlayer.source] = callId

                                    TriggerClientEvent("Ambulance:call:onAccept", acceptPlayer.source, {
                                        onActive = true,
                                        callId = callId,
                                        position = GM.Ambulance.registeredCalls["list"][tonumber(callId)].position,
                                    })
                                end

                                for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do
                                    local ambulancePlayer = ESX.GetPlayerFromId(playerSrc)
                                    if (ambulancePlayer) then
                                        if (ambulancePlayer.source ~= acceptPlayer.source) then
                                            TriggerClientEvent("esx:showNotification", ambulancePlayer.source, "L'appel à été pris par ~g~"..acceptPlayer.getName().."~s~.")
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

RegisterServerEvent("Ambulance:sendCall", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Ambulance.registeredCalls["victim"][playerSelected.source] ~= nil) then
        playerSelected.showNotification("~r~Vous avez déjà un appel en cours.")
        return
    end

    playerSelected.showNotification("~g~Votre appel à bien été enregistré.")

    local callId = (#GM.Ambulance.registeredCalls["list"] + 1)
    if (not callId) then return end

    GM.Ambulance.registeredCalls["victim"][playerSelected.source] = callId

    GM.Ambulance.registeredCalls["list"][tonumber(callId)] = {
        source = playerSelected.source,
        id = callId,
        name = "appel_urgence",
        label = "Appel d'urgence",
        message = "Une personne à besoin d'une réanimation",
        position = playerSelected.getCoords(true),
        time = os.date("%H:%M"),
        playerName = playerSelected.getName(),
    }

    SetTimeout(GM.Ambulance.callDelete * 60000, function()
        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)]) then
            GM.Ambulance.registeredCalls["list"][tonumber(callId)] = nil
        end
        if (GM.Ambulance.registeredBlips["calls"][callId]) then
            GM.Ambulance.registeredBlips["calls"][callId]:delete()
            GM.Ambulance.registeredBlips["calls"][callId] = nil
        end
        if (GM.Ambulance.registeredCalls["victim"][playerSelected.source] ~= nil) then
            GM.Ambulance.registeredCalls["victim"][playerSelected.source] = nil
        end

        for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do
            TriggerClientEvent("Ambulance:removeValue", playerSrc, "call", callId)
        end
    end)

    GM.Ambulance.registeredBlips["calls"][callId] = GM.Blip:add(GM.Ambulance.registeredCalls["list"][tonumber(callId)].position, {
        sprite = 1,
        colour = 3,
        name = callId.." - "..GM.Ambulance.registeredCalls["list"][tonumber(callId)].label,
        route = true,
    }, {
        isPrivate = true
    })

    if (GM.Service["Enterprise_list"]) then
        if (GM.Service["Enterprise_list"]["ambulance"] == nil) then
            GM.Service["Enterprise_list"]["ambulance"] = {}
        end
        for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do

            if (playerSrc ~= playerSelected.source) then
            
                local request = GM.Request:sendCallMessage(playerSrc, "Centrale", "Appel d'urgence - "..callId, "CALL", {
                    position = GM.Ambulance.registeredCalls["list"][tonumber(callId)].position,
                    callId = callId,
                    message = GM.Ambulance.registeredCalls["list"][tonumber(callId)].message,
                })
                if (request == "accept") then
                    local acceptPlayer = ESX.GetPlayerFromId(playerSrc)
                    if (acceptPlayer) then
                        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken ~= nil) then
                            TriggerClientEvent("esx:showNotification", acceptPlayer.source, "~r~L'appel à déjà été pris par quelqu'un d'autre.")
                            return
                        end

                        GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken = true

                        TriggerClientEvent("esx:showNotification", acceptPlayer.source, "~g~Vous avez accepté l'appel.")

                        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc == nil) then
                            GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc = acceptPlayer.source
                        end

                        if (GM.Ambulance.registeredCalls["accepted"][acceptPlayer.source] ~= nil) then
                            if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken ~= nil) then
                                GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken = nil
                            end
                            GM.Ambulance.registeredBlips["calls"][GM.Ambulance.registeredCalls["accepted"][acceptPlayer.source]]:allowedPlayer(acceptPlayer.source, false)
                        end
                        
                        GM.Ambulance.registeredBlips["calls"][callId]:allowedPlayer(acceptPlayer.source)
                        GM.Ambulance.registeredCalls["accepted"][acceptPlayer.source] = callId

                        TriggerClientEvent("esx:showNotification", playerSelected.source, "~g~Un médecin à accepté votre appel.")

                        TriggerClientEvent("Ambulance:call:onAccept", acceptPlayer.source, {
                            onActive = true,
                            callId = callId,
                            position = GM.Ambulance.registeredCalls["list"][tonumber(callId)].position,
                        })
                    end

                    for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do
                        local ambulancePlayer = ESX.GetPlayerFromId(playerSrc)
                        if (ambulancePlayer) then
                            if (ambulancePlayer.source ~= acceptPlayer.source) then
                                TriggerClientEvent("esx:showNotification", ambulancePlayer.source, "L'appel à été pris par ~g~"..acceptPlayer.getName().."~s~.")
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterServerEvent("Ambulance:call:finish", function(callId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "ambulance") then
        playerSelected.showNotification("~r~Vous n'êtes pas médecin.")
        return
    end

    if (GM.Ambulance.registeredCalls["list"][tonumber(callId)] ~= nil) then
        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken ~= nil) then
            GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken = nil
        end
        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc ~= nil) then
            GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc = nil
        end
        if (GM.Ambulance.registeredCalls["victim"][GM.Ambulance.registeredCalls["list"][tonumber(callId)].source] ~= nil) then
            GM.Ambulance.registeredCalls["victim"][GM.Ambulance.registeredCalls["list"][tonumber(callId)].source] = nil
        end
        GM.Ambulance.registeredCalls["list"][tonumber(callId)] = nil
    end

    if (GM.Ambulance.registeredCalls["accepted"][playerSelected.source] ~= nil) then
        GM.Ambulance.registeredCalls["accepted"][playerSelected.source] = nil
    end

    if (GM.Ambulance.registeredBlips["calls"][callId] ~= nil) then
        GM.Ambulance.registeredBlips["calls"][callId]:allowedPlayer(playerSelected.source, false)
    end

    for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do
        TriggerClientEvent("Ambulance:removeValue", playerSrc, "call", callId)
    end

    TriggerClientEvent("Ambulance:removeValue", playerSelected.source, "callId")
end)

RegisterServerEvent("Ambulance:menu:requestCalls", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "ambulance") then
        playerSelected.showNotification("~r~Vous n'êtes pas médecin.")
        return
    end

    TriggerClientEvent("Ambulance:updateValue", playerSelected.source, "call", GM.Ambulance.registeredCalls["list"])
end)

RegisterServerEvent("Ambulance:call:accept", function(callId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "ambulance") then
        playerSelected.showNotification("~r~Vous n'êtes pas médecin.")
        return
    end

    if (GM.Ambulance.registeredCalls["list"][tonumber(callId)] ~= nil) then

        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].source == playerSelected.source) then
            playerSelected.showNotification("~r~Vous ne pouvez pas prendre votre propre appel.")
            return
        end

        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken ~= nil) then
            playerSelected.showNotification("~r~L'appel à déjà été pris par quelqu'un d'autre.")
            return
        end

        GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken = true

        if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc == nil) then
            GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc = playerSelected.source
        end

        if (GM.Ambulance.registeredCalls["accepted"][playerSelected.source] ~= nil) then
            if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken ~= nil) then
                GM.Ambulance.registeredCalls["list"][tonumber(callId)].taken = nil
                if (GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc == nil) then
                    GM.Ambulance.registeredCalls["list"][tonumber(callId)].takenSrc = nil
                end
                for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do
                    TriggerClientEvent("Ambulance:updateValue", playerSrc, "call", callId, GM.Ambulance.registeredCalls["list"][tonumber(callId)])
                end
            end
            GM.Ambulance.registeredBlips["calls"][GM.Ambulance.registeredCalls["accepted"][playerSelected.source]]:allowedPlayer(playerSelected.source, false)
        end
        
        GM.Ambulance.registeredBlips["calls"][callId]:allowedPlayer(playerSelected.source)
        GM.Ambulance.registeredCalls["accepted"][playerSelected.source] = callId

        TriggerClientEvent("Ambulance:call:onAccept", playerSelected.source, {
            onActive = true,
            callId = callId,
            position = GM.Ambulance.registeredCalls["list"][tonumber(callId)].position,
        })

        for playerSrc, _ in pairs(GM.Service["Enterprise_list"]["ambulance"]) do
            local ambulancePlayer = ESX.GetPlayerFromId(playerSrc)
            if (ambulancePlayer) then
                if (ambulancePlayer.source ~= playerSelected.source) then
                    TriggerClientEvent("esx:showNotification", ambulancePlayer.source, "L'appel à été pris par ~g~"..playerSelected.getName().."~s~.")
                end
            end
        end
    end
end)

RegisterServerEvent("Ambulance:menu:interaction:amende", function(billReason, billAmount)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getJob().name ~= "ambulance") then
        playerSelected.showNotification("~r~Vous n'êtes pas médecin.")
        return
    end

    -- Todo check this
end)