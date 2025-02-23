GM:newThread(function()
    while (GM.Command == nil) do
        Wait(50)
    end

    GM.Command:register({
        name = "commands",
        label = "Ouvrir le menu des commandes",
        description = "Permet d'ouvrir le menu des commandes",
    }, function(playerSrc)
        TriggerClientEvent("Command:openMenu", playerSrc, GM.Command.List)
    end)

    GM.Command:register({
        name = "admin",
        label = "Ouvrir le menu d'administration",
        description = "Permet d'ouvrir le menu d'administration",
        keys = {"keyboard", "F10"},
    }, function(playerSrc)
        TriggerClientEvent("Admin:openMenu", playerSrc)
    end)

    GM.Command:register({
        name = "die",
        label = "Se suicider",
        description = "Permet de se suicider",
        permissions = false
    }, function(playerSrc)
        TriggerClientEvent("Ambulance:suicide", playerSrc)
    end)

    GM.Command:register({
        name = "revive",
        label = "Réanimer",
        description = "Réanimer une personne",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            if (GM.Death["dead_list"][targetSelected.source] == nil) then
                print("LE JOUEUR "..targetSelected.getName().." N'EST PAS MORT")
                return
            end

            if (GM.Ambulance.registeredCalls["victim"][targetSelected.source] ~= nil) then
                if (GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])]) then
                    if (GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])].takenSrc) then
                        TriggerClientEvent("esx:showNotification", GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])].takenSrc, "~r~L'appel en cours à été annulé le patient à été réanimer par un staff.")
                        TriggerClientEvent("Ambulance:removeValue", GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])].takenSrc, "callId")
                    end
                end
        
                local ambulanceList = GM.Service:getPeopleService("ambulance")
            
                for ambulanceSrc, _ in pairs(ambulanceList) do
                    TriggerClientEvent("Ambulance:removeValue", ambulanceSrc, "call", GM.Ambulance.registeredCalls["victim"][targetSelected.source])
                end

                GM.Ambulance.registeredCalls["victim"][targetSelected.source] = nil
            end
        
            if (GM.Death["dead_list"][targetSelected.source] ~= nil) then
                GM.Death["dead_list"][targetSelected.source] = nil
            end
        
            targetSelected.setDead(false)
            targetSelected.showNotification("~b~Vous avez été réanimer par un staff.")  

            print("LE JOUEUR A BIEN ÉTÉ REVIVE")
        
            TriggerClientEvent("Ambulance:revivePlayer", targetSelected.source)
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            if (GM.Admin.inAdmin[playerSelected.source] == nil) then
                playerSelected.showNotification("~r~Vous n'êtes pas en mode admin !")
                return
            end

            if (not args[1]) then
                args[1] = playerSrc
            end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            if (GM.Death["dead_list"][targetSelected.source] == nil) then
                playerSelected.showNotification("~r~Le joueur "..targetSelected.getName().." n'est pas mort.")
                return
            end

            if (GM.Ambulance.registeredCalls["victim"][targetSelected.source] ~= nil) then
                if (GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])]) then
                    if (GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])].takenSrc) then
                        TriggerClientEvent("esx:showNotification", GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])].takenSrc, "~r~L'appel en cours à été annulé le patient à été réanimer par un staff.")
                        TriggerClientEvent("Ambulance:removeValue", GM.Ambulance.registeredCalls["list"][tonumber(GM.Ambulance.registeredCalls["victim"][targetSelected.source])].takenSrc, "callId")
                    end
                end
        
                local ambulanceList = GM.Service:getPeopleService("ambulance")
            
                for ambulanceSrc, _ in pairs(ambulanceList) do
                    TriggerClientEvent("Ambulance:removeValue", ambulanceSrc, "call", GM.Ambulance.registeredCalls["victim"][targetSelected.source])
                end

                GM.Ambulance.registeredCalls["victim"][targetSelected.source] = nil
            end
        
            if (GM.Death["dead_list"][targetSelected.source] ~= nil) then
                GM.Death["dead_list"][targetSelected.source] = nil
            end
        
            targetSelected.setDead(false)
            targetSelected.showNotification("~b~Vous avez été réanimer par un staff.")  
            playerSelected.showNotification("~b~Vous avez réanimer "..targetSelected.getName()..".")
        
            TriggerClientEvent("Ambulance:revivePlayer", targetSelected.source)
        end
    end)

    GM.Command:register({
        name = "adminNoclip",
        label = "Noclip",
        description = "Permet de passer en mode noclip",
        keys = {"keyboard", "O"}
    }, function(playerSrc)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        if (GM.Admin.inAdmin[playerSelected.source] == nil) then
            playerSelected.showNotification("~r~Vous n'êtes pas en mode admin.")
            return
        end

        if (playerSelected.get("noclip") == false) then
            playerSelected.set("noclip", true)
            playerSelected.showNotification("~b~Vous avez activé le mode noclip.")
        else
            playerSelected.set("noclip", false)
            playerSelected.showNotification("~b~Vous avez désactivé le mode noclip.")
        end

        TriggerClientEvent("Admin:noClip", playerSelected.source)
    end)

    GM.Command:register({
        name = "ranks",
        label = "Rangs",
        description = "Permet de gérer les rangs",
    }, function(playerSrc)
        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        TriggerClientEvent("Ranks:openMenu", playerSrc)
    end)

    GM.Command:register({
        name = "setCoords",
        label = "Se téléporter à une position",
        description = "Permet de se téléporter à une position",
    }, function(playerSrc, args)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local position = vector3(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
	    if (not position) then return end

        playerSelected.setCoords(position)
    end)

    GM.Command:register({
        name = "bring",
        label = "Téléporter une personne à soi",
        description = "Permet de téléporter une personne à soi",
    }, function(playerSrc, args)
        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local playerPosition = playerSelected.getCoords(true)
        if (not playerPosition) then return end

        local targetSelected = ESX.GetPlayerFromId(args[1])
        if (not targetSelected) then return end

        targetSelected.set("last_position", targetSelected.getCoords(true))

        if (targetSelected.get("noclip") == true) then
            TriggerClientEvent("Admin:setCameraCoords", targetSelected.source, playerPosition)
        else
            targetSelected.setCoords(playerPosition)
        end
    end)

    GM.Command:register({
        name = "bringBack",
        label = "Téléporter une personne à sa dernière position",
        description = "Permet de téléporter une personne à sa dernière position",
    }, function(playerSrc, args)
        local targetSelected = ESX.GetPlayerFromId(args[1])
        if (not targetSelected) then return end

        local lastPosition = targetSelected.get("last_position")

        if (targetSelected.get("noclip") == true) then
            TriggerClientEvent("Admin:setCameraCoords", targetSelected.source, lastPosition)
        else
            targetSelected.setCoords(lastPosition)
        end
    end)

    GM.Command:register({
        name = "goto",
        label = "Se téléporter à une personne",
        description = "Permet de se téléporter à une personne",
    }, function(playerSrc, args)
        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local targetSelected = ESX.GetPlayerFromId(args[1])
        if (not targetSelected) then return end

        local targetPosition = targetSelected.getCoords(true)

        if (playerSelected.get("noclip") == true) then
            TriggerClientEvent("Admin:setCameraCoords", playerSelected.source, targetPosition)
        else
            playerSelected.setCoords(targetPosition)
        end
    end)

    GM.Command:register({
        name = "kick",
        label = "Expulser une personne",
        description = "Permet d'expulser une personne du serveur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local kickReason = table.concat(args, " ", 2)

            targetSelected.kick(kickReason, "Console")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local kickReason = table.concat(args, " ", 2)

            targetSelected.kick(kickReason, playerSelected.getName())
        end
    end)

    GM.Command:register({
        name = "ban",
        label = "Ban un joueur",
        description = "Permet de bannir temporairement ou définitivement une personne.",
    }, function(playerSrc, args)
        if (not args[1] or not args[2] or not args[3]) then
            return
        end

        local targetPlayer = tonumber(args[1]) or args[1]
        local reason = table.concat(args, " ", 3)
        
        local finishTimer
        if (tonumber(args[2]) == 0) then
            finishTimer = -1
        else
            finishTimer = (os.time() + (tonumber(args[2]) * 60)) * 1000
        end
    
        if (type(targetPlayer) == "number") then
            local selectedPlayer = ESX.GetPlayerFromId(targetPlayer)
            if (not selectedPlayer) then
                return
            end
            
            selectedPlayer.ban(reason, finishTimer, GetPlayerName(playerSrc))
        else
            GM.Connecting:ban(targetPlayer, {
                reason = reason,
                expiration = finishTimer or -1,
                author = GetPlayerName(playerSrc)
            })
        end
    end)

    GM.Command:register({
        name = "unban",
        label = "Unban un joueur",
        description = "Permet de débannir une personne.",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            if (not args[1]) then
                return
            end
        
            GM.Connecting:unban(playerSrc, args[1])
        else
            if (not args[1]) then
                return
            end
        
            GM.Connecting:unban(playerSrc, args[1])
        end
    end)

    GM.Command:register({
        name = "car",
        label = "Faire apparaître un véhicule",
        description = "Permet de faire apparaître un véhicule",
    }, function(playerSrc, args)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        if (GM.Admin.inAdmin[playerSelected.source] == nil) then
            playerSelected.showNotification("~r~Vous n'êtes pas en mode admin !")
            return
        end

        local vehicleName = args[1]
        local upgrades = {
            plate = "ADMINCAR", 
            modEngine = 3,
            modBrakes = 2,
            modTransmission = 2,
            modSuspension = 3,
            modArmor = true,
            windowTint = 1,
        }

        local playerPed = playerSelected.getPed()
        if (not playerPed) then return end

        local playerPosition = playerSelected.getCoords(true)
        if (not playerPosition) then return end

        ESX.OneSync.SpawnVehicle(vehicleName, playerPosition - vector3(0,0, 0.9), GetEntityHeading(playerPed), {}, function(networkId)
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

    GM.Command:register({
        name = "dv",
        label = "Supprimer le véhicule",
        description = "Permet de supprimer des véhicules",
    }, function(playerSrc, args)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        if (GM.Admin.inAdmin[playerSelected.source] == nil) then
            playerSelected.showNotification("~r~Vous n'êtes pas en mode admin !")
            return
        end

        local playerPed = playerSelected.getPed()
        if (not playerPed) then return end

        local playerVehicle = GetVehiclePedIsIn(playerPed, false)
        if (playerVehicle) then
            if DoesEntityExist(playerVehicle) then
                if (GM.Garage) then
                    if (GM.Garage["vehicle_out"][playerVehicle] ~= nil) then
        
                        MySQL.update('UPDATE owned_vehicles SET stored = ? WHERE plate = ?', {1, GM.Garage["vehicle_out"][playerVehicle].plate}, function()
                            if (GM.Garage["vehicle_out"][playerVehicle] ~= nil) then
                                GM.Garage["vehicle_out"][playerVehicle].stored = 1
        
                                local targetSrc = GM.Garage["vehicle_out"][playerVehicle].playerSrc
                                if (targetSrc) then
            
                                    local targetSelected = ESX.GetPlayerFromId(targetSrc)
                                    if (targetSelected) then
            
                                        local garageType = GM.Garage["vehicle_out"][playerVehicle].garageType
                                        local vehicleId = GM.Garage["vehicle_out"][playerVehicle].vehicleId
            
                                        GM.Garage["vehicle_list"][targetSrc][garageType][vehicleId].stored = 1
            
                                        GM.Garage["vehicle_out"][playerVehicle] = nil
            
                                        TriggerClientEvent("Garage:UpdateValue", targetSrc, "vehicles", vehicleId, GM.Garage["vehicle_list"][playerSrc][garageType][vehicleId])
                                    end
                                end
                            end
                        end)
                    end
                end
                DeleteEntity(playerVehicle)
            end
        end

        local allVehicles = ESX.OneSync.GetVehiclesInArea(GetEntityCoords(playerPed), tonumber(args[1]) or 5.0)
        for i = 1, #allVehicles do 
            local currentVehicle = NetworkGetEntityFromNetworkId(allVehicles[i])
            if (currentVehicle) then

                if DoesEntityExist(currentVehicle) then
                    if (GM.Garage) then
                        if (GM.Garage["vehicle_out"][currentVehicle] ~= nil) then

                            MySQL.update('UPDATE owned_vehicles SET stored = ? WHERE plate = ?', {1, GM.Garage["vehicle_out"][currentVehicle].plate}, function()
                                if (GM.Garage["vehicle_out"][currentVehicle] ~= nil) then
                                    GM.Garage["vehicle_out"][currentVehicle].stored = 1
                
                                    local targetSrc = GM.Garage["vehicle_out"][currentVehicle].playerSrc
                                    if (targetSrc) then
                
                                        local targetSelected = ESX.GetPlayerFromId(targetSrc)
                                        if (targetSelected) then
                
                                            local garageType = GM.Garage["vehicle_out"][currentVehicle].garageType
                                            local vehicleId = GM.Garage["vehicle_out"][currentVehicle].vehicleId
                
                                            GM.Garage["vehicle_list"][targetSrc][garageType][vehicleId].stored = 1
                
                                            GM.Garage["vehicle_out"][currentVehicle] = nil
                
                                            TriggerClientEvent("Garage:UpdateValue", targetSrc, "vehicles", vehicleId, GM.Garage["vehicle_list"][playerSrc][garageType][vehicleId])
                                        end
                                    end
                                end
                            end)
                        end
                    end
                    
                    DeleteEntity(currentVehicle)
                end
            end
        end
    end)

    GM.Command:register({
        name = "msg",
        label = "Envoyer un message à un joueur",
        description = "Permet d'envoyer un message à un joueur",
    }, function(playerSrc, args)
        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local targetSelected = ESX.GetPlayerFromId(args[1])
        if (not targetSelected) then return end

        local message = table.concat(args, " ", 2)
        targetSelected.showAdvancedNotification("BlueStark Admin", '~b~'..playerSelected.getNickName(), message, "BLUESTARK")
    end)

    GM.Command:register({
        name = "setRank",
        label = "Changer le rank d'un joueur",
        description = "Permet de changer le rank d'un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local selectedRank = GM.Ranks:getFromName(args[2])
            if (not selectedRank) then return end

            local targetPlayer = tonumber(args[1]) or args[1]

            if (type(targetPlayer) == "number") then
                local selectedPlayer = ESX.GetPlayerFromId(targetPlayer)
                if (not selectedPlayer) then
                    return
                end

                local targetIdentifier = selectedPlayer.getIdentifier()
                if (not targetIdentifier) then return end

                if (GM.Ranks["players"][targetIdentifier]) then return end

                GM.Ranks["players"][targetIdentifier] = {
                    rankId = selectedRank.id,
                    name = selectedRank.name,
                    reports = 0,
                    staffName = selectedPlayer.getName()
                }

                selectedRank.players[targetIdentifier] = {
                    name = selectedPlayer.getName(),
                    arrival_date = os.date("%d-%m-%Y %H:%M:%S"),
                    reports = 0
                }

                MySQL.update('UPDATE user_admin SET players = ? WHERE id = ?', {
                    json.encode(selectedRank.players), 
                    selectedRank.id
                }, function()
                    for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                        TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", rankId, selectedRank)
                    end
                    local keysCommands = GM.Command:getCommandsKeys()
                    if (not keysCommands) then return end

                    for commandName, commandValues in pairs(keysCommands) do
                        TriggerClientEvent("Command:keyMapping", selectedPlayer.source, commandValues)
                    end
                end)
            else
                local targetIdentifier = args[1]

                if (GM.Ranks["players"][targetIdentifier]) then return end

                GM.Ranks["players"][targetIdentifier] = {
                    rankId = selectedRank.id,
                    name = selectedRank.name,
                    reports = 0,
                    staffName = targetIdentifier
                }

                selectedRank.players[targetIdentifier] = {
                    name = targetIdentifier,
                    arrival_date = os.date("%d-%m-%Y %H:%M:%S"),
                    reports = 0
                }

                MySQL.update('UPDATE user_admin SET players = ? WHERE id = ?', {
                    json.encode(selectedRank.players), 
                    selectedRank.id
                }, function()
                    for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                        TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", rankId, selectedRank)
                    end
                end)
            end
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            if (playerSelected.getGroup() == "user") then return end

            local selectedRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
            if (not selectedRank) then return end

            if (not selectedRank:getPermissionsValue("RECRUIT_PLAYER_RANKS", playerSelected.source)) then return end

            if (not selectedRank:canInteract(args[2])) then return playerSelected.showNotification("~r~Vous ne pouvez pas recruter un joueur dans un rank plus haut que vous.") end

            local selectedRank = GM.Ranks:getFromName(args[2])
            if (not selectedRank) then return end

            local targetPlayer = tonumber(args[1]) or args[1]

            if (type(targetPlayer) == "number") then
                local selectedPlayer = ESX.GetPlayerFromId(targetPlayer)
                if (not selectedPlayer) then
                    return
                end

                local targetIdentifier = selectedPlayer.getIdentifier()
                if (not targetIdentifier) then return end

                if (GM.Ranks["players"][targetIdentifier]) then return end

                GM.Ranks["players"][targetIdentifier] = {
                    rankId = selectedRank.id,
                    name = selectedRank.name,
                    reports = 0,
                    staffName = selectedPlayer.getName()
                }

                selectedRank.players[targetIdentifier] = {
                    name = targetSelected.getName(),
                    arrival_date = os.date("%d-%m-%Y %H:%M:%S"),
                    reports = 0
                }

                MySQL.update('UPDATE user_admin SET players = ? WHERE id = ?', {
                    json.encode(selectedRank.players), 
                    selectedRank.id
                }, function()
                    for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                        TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", rankId, selectedRank)
                    end
                end)
            else
                local targetIdentifier = args[1]

                if (GM.Ranks["players"][targetIdentifier]) then return end

                GM.Ranks["players"][targetIdentifier] = {
                    rankId = selectedRank.id,
                    name = selectedRank.name,
                    reports = 0,
                    staffName = targetIdentifier
                }

                selectedRank.players[targetIdentifier] = {
                    name = targetIdentifier,
                    arrival_date = os.date("%d-%m-%Y %H:%M:%S"),
                    reports = 0
                }

                MySQL.update('UPDATE user_admin SET players = ? WHERE id = ?', {
                    json.encode(selectedRank.players), 
                    selectedRank.id
                }, function()
                    for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                        TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", rankId, selectedRank)
                    end
                end)
            end
        end
    end)

    GM.Command:register({
        name = "removeRank",
        label = "Retirer le rank d'un joueur",
        description = "Permet de retirer le rank d'un joueur",
    }, function(playerSrc, args)
        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local playerIdentifier = args[1]

        if (GM.Ranks["players"][playerIdentifier] == nil) then return playerSelected.showNotification("~r~Cet identifiant n'est pas un staff.") end

        local selectedRank = GM.Ranks:getFromId(GM.Ranks["players"][playerIdentifier].rankId)
        if (not selectedRank) then return end

        if (not selectedRank.players[playerIdentifier]) then return end

        local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
        if (not playerRank) then return end

        if (not playerRank:getPermissionsValue("KICK_PLAYER_RANKS", playerSelected.source)) then return end

        if (not playerRank:canInteract(GM.Ranks["players"][playerIdentifier].rankId)) then return playerSelected.showNotification("~r~Vous ne pouvez pas kick un staff plus haut que vous.") end

        local selectedPlayer = ESX.GetPlayerFromIdentifier(playerIdentifier)

        selectedRank.players[playerIdentifier] = nil
        GM.Ranks["players"][playerIdentifier] = nil

        MySQL.update('UPDATE user_admin SET players = ? WHERE id = ?', {
            json.encode(selectedRank.players), 
            selectedRank.id
        }, function()
            if (selectedPlayer) then
                selectedPlayer:setMetadata("rank_id", GM.Ranks["rank_user"])
                selectedPlayer:setMetadata("rank", "user")
            end
            for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", rankId, selectedRank)
            end
        end)
    end)

    GM.Command:register({
        name = "report",
        label = "Contacter l'équipe de modération",
        description = "Permet d'envoyer un message à un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local reason = table.concat(args, " ", 1)

        if (reason == "") then return playerSelected.showNotification("~r~Vous devez spécifier une raison.") end

        if (reason == nil) then return playerSelected.showNotification("~r~Vous devez spécifier une raison.") end

        GM.Admin.Reports:new(nil, playerSrc, playerSelected.getName(), reason)
    end)

    GM.Command:register({
        name = "closeReport",
        label = "Fermer son report actuel",
        description = "Permet de fermer son report actuel",
        permissions = false,
    }, function(playerSrc)
        if (playerSrc == 0) then return end

        if (GM.Admin.Reports["player"][playerSrc]) then
            if GM.Admin.Reports["close_report"][playerSrc] then
                TriggerClientEvent("esx:showNotification", playerSrc, "~b~Votre report à bien été fermé.")
                GM.Admin.Reports["list"][GM.Admin.Reports["player"][playerSrc]] = nil
                
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:removeValue", adminSrc, "reports", GM.Admin.Reports["player"][playerSrc])
                end
        
                GM.Admin.Reports["player"][playerSrc] = nil
            else
                TriggerClientEvent("esx:showNotification", playerSrc, "~r~Vous devez attendre 10 minutes avant de pouvoir fermer votre report.")
                return
            end
        else
            TriggerClientEvent("esx:showNotification", playerSrc, "~r~Vous n'avez pas de report en cours.")
            return
        end
    end)

    GM.Command:register({
        name = "heading",
        label = "Afficher sa position",
        description = "Permet d'afficher sa position",
    }, function(playerSrc)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local playerPed = playerSelected.getPed()

        local heading = GetEntityHeading(playerPed)

        playerSelected.showNotification("~b~Heading: ~w~"..heading)
    end)

    GM.Command:register({
        name = "jail",
        label = "Envoyer un joueur dans l'instance trolleur",
        description = "Permet d'envoyer un joueur dans l'instance trolleur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local targetIdentifier = targetSelected.getIdentifier()
            if (not targetIdentifier) then return end

            if (GM.Jail.List[targetIdentifier]) then
                print("Player is already in jail")
                return
            end

            local timeJail

            timeJail = tonumber(args[2]) * 60

            local reason = table.concat(args, " ", 3)

            GM.Jail.List[targetIdentifier] = {
                time = timeJail,
                joinTime = os.time(os.date("!*t")),
                reason = reason
            }

            SetEntityCoords(targetSelected.getPed(), 1728.492, 2532.91, 43.58)

            local jail = {
                reason = reason,
                date = os.date("%d/%m/%Y %H:%M:%S"),
                admin = "Console",
            }
        
            MySQL.insert('INSERT INTO user_sanctions (identifier, type, data) VALUES (?, ?, ?)', {targetIdentifier, "Jail", json.encode(jail)}, function()
                TriggerClientEvent("Jail:sendInJail", targetSelected.source, timeJail)
            end)
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local targetIdentifier = targetSelected.getIdentifier()
            if (not targetIdentifier) then return end

            if (GM.Jail.List[targetIdentifier]) then
                playerSelected.showNotification("~r~Le joueur est déjà en prison.")
                return
            end

            local timeJail

            timeJail = tonumber(args[2]) * 60

            local reason = table.concat(args, " ", 3)

            GM.Jail.List[targetIdentifier] = {
                time = timeJail,
                joinTime = os.time(os.date("!*t")),
                reason = reason
            }

            SetEntityCoords(targetSelected.getPed(), 1728.492, 2532.91, 43.58)

            local jail = {
                reason = reason,
                date = os.date("%d/%m/%Y %H:%M:%S"),
                admin = playerSelected.getName(),
            }
        
            MySQL.insert('INSERT INTO user_sanctions (identifier, type, data) VALUES (?, ?, ?)', {targetIdentifier, "Jail", json.encode(jail)}, function()
                TriggerClientEvent("Jail:sendInJail", targetSelected.source, timeJail)
            end)
        end
    end)

    GM.Command:register({
        name = "unjail",
        label = "Sortir un joueur de l'instance trolleur",
        description = "Permet de sortir un joueur de l'instance trolleur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local targetIdentifier = targetSelected.getIdentifier()
            if (not targetIdentifier) then return end

            if (not GM.Jail.List[targetIdentifier]) then
                print("Player is not in jail")
                return
            end

            GM.Jail.List[targetIdentifier] = nil
            SetEntityCoords(targetSelected.getPed(), 1851.03, 2586.16, 45.67)
            targetSelected.showNotification("~g~Vous avez été libéré de prison par un membre du staff !\nMerci de relire le règlement !")
            TriggerClientEvent("Jail:sendOutJail", targetSelected.source)
            print("Player "..targetSelected.getName().." has been unjailed by the server")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local targetIdentifier = targetSelected.getIdentifier()
            if (not targetIdentifier) then return end

            if (not GM.Jail.List[targetIdentifier]) then
                playerSelected.showNotification("~r~Ce joueur n'est pas en prison.")
                return
            end

            MySQL.query('SELECT * FROM user_jail WHERE identifier = ?', {targetIdentifier}, function(result)
                if (result[1] ~= nil) then
                    MySQL.Async.execute("DELETE FROM user_jail WHERE identifier = ?", {
                        targetIdentifier
                    })
                end
            end)

            GM.Jail.List[targetIdentifier] = nil
            SetEntityCoords(targetSelected.getPed(), 1851.03, 2586.16, 45.67)
            targetSelected.showNotification("~g~Vous avez été libéré de prison par un membre du staff !\nMerci de relire le règlement !")
            TriggerClientEvent("Jail:sendOutJail", targetSelected.source)
            playerSelected.showNotification("~g~Vous avez libéré "..targetSelected.getName().." de prison.")
        end
    end)

    GM.Command:register({
        name = "freeze",
        label = "Freeze un joueur",
        description = "Permet de freeze un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            FreezeEntityPosition(targetSelected.getPed(), true)
            print("Player "..targetSelected.getName().." has been frozen by the server")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            FreezeEntityPosition(targetSelected.getPed(), true)
            playerSelected.showNotification("~g~Vous avez freeze "..targetSelected.getName()..".")
        end
    end)

    GM.Command:register({
        name = "unfreeze",
        label = "UnFreeze un joueur",
        description = "Permet de unfreeze un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            FreezeEntityPosition(targetSelected.getPed(), false)
            print("Player "..targetSelected.getName().." has been defrozen by the server")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            FreezeEntityPosition(targetSelected.getPed(), false)
            playerSelected.showNotification("~g~Vous avez defreeze "..targetSelected.getName()..".")
        end
    end)

    GM.Command:register({
        name = "screenshot",
        label = "Prendre un screen du joueur",
        description = "Permet de prendre un screenshot de l'écran du joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            if GetResourceState("screenshot-basic") == "started" then
                local targetSelected = ESX.GetPlayerFromId(args[1])
                if (not targetSelected) then return end

                local name = ESX.generateVariable(16)
                exports["screenshot-basic"]:requestClientScreenshot(targetSelected.source, {
                    fileName = "cache/" .. name .. ".jpg"
                 }, function(err, fileName)
                    if not err then
                        TriggerEvent("Logs:sendLogsScreenshot", GM.Logs["List"]["screenshot"], "./" .. fileName, {
                            username = "BlueStark",
                            embeds = GM.Logs:ConstructScreenshotEmbed(targetSelected.source, name .. ".jpg")
                        })
                    else
                        print("fatal error occured while taking a screenshot")
                    end
                end)
            else
                print("screenshot-basic is not started")
            end
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            if GetResourceState("screenshot-basic") == "started" then
                local targetSelected = ESX.GetPlayerFromId(args[1])
                if (not targetSelected) then return end

                local name = ESX.generateVariable(16)
                exports["screenshot-basic"]:requestClientScreenshot(targetSelected.source, {
                    fileName = "cache/" .. name .. ".jpg"
                 }, function(err, fileName)
                    if not err then
                        TriggerEvent("Logs:sendLogsScreenshot", GM.Logs["List"]["screenshot"], "./" .. fileName, {
                            username = "BlueStark",
                            embeds = GM.Logs:ConstructScreenshotEmbed(targetSelected.source, name .. ".jpg")
                        })
                        playerSelected.showNotification("~g~Vous avez pris un screenshot de "..targetSelected.getName()..".")
                    else
                        playerSelected.showNotification("~r~Une erreur est survenue lors de la prise du screenshot.")
                    end
                end)
            else
                playerSelected.showNotification("~r~La resource screenshot-basic n'est pas lancé.")
            end
        end
    end)

    GM.Command:register({
        name = "creator",
        label = "Ouvrir le menu de création de personnage",
        description = "Permet d'ouvrir le menu de création de personnage",
    }, function(playerSrc, args)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local targetSelected = ESX.GetPlayerFromId(args[1] or playerSrc)
        if (not targetSelected) then return end

        targetSelected.set("creator", true)

        SetEntityCoords(targetSelected.getPed(), -3.0983, 523.4305, 173.6271)
        SetEntityHeading(targetSelected.getPed(), 81.0245)

        while #(targetSelected.getCoords(true) - vector3(-3.0983, 523.4305, 173.6271)) > 2.0 do
            Wait(50)
        end

        TriggerClientEvent("Creator:openMenu", targetSelected.source)
        playerSelected.showNotification("~g~Vous avez ouvert le menu de création de personnage de "..targetSelected.getName()..".")
    end)

    GM.Command:register({
        name = "tpVehicle",
        label = "Se téléporter à un véhicule",
        description = "Permet de se téléporter à un véhicule",
    }, function(playerSrc, args)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        local plate = string.upper(args[1])
        if (not plate) then
            playerSelected.showNotification("~r~Vous devez spécifier une plaque de véhicule.")
            return
        end

        local vehicles = GetAllVehicles()
        if (not vehicles) then return end

        for _, vehicle in pairs(vehicles) do
            local vehiclePlate = GetVehicleNumberPlateText(vehicle)
            if (vehiclePlate ~= nil) then
                if (vehiclePlate == plate) then
                    local vehicleCoords = GetEntityCoords(vehicle)
                    if (not vehicleCoords) then return end

                    SetEntityCoords(playerSelected.getPed(), vehicleCoords)
                    playerSelected.showNotification("~g~Vous avez été téléporté au véhicule recherché ("..plate..").")
                    return
                end
            end
        end
    end)

    GM.Command:register({
        name = "setArmour",
        label = "Donner de l'armure",
        description = "Permet de donner de l'armure à un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local armour = args[2]
            if (not armour) then return end

            targetSelected.setArmour(armour)
            print("VOUS AVEZ DONNE DE L'ARMURE A "..targetSelected.getName()..".")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local armour = args[2]
            if (not armour) then return end

            targetSelected.setArmour(armour)
            playerSelected.showNotification("~g~Vous avez donné de l'armure à "..targetSelected.getName()..".")
        end
    end)

    GM.Command:register({
        name = "giveItem",
        label = "Donner un item",
        description = "Permet de donner un item à un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local itemName = args[2]
            if (not itemName) then return end

            local itemCount = args[3] or 1
            if (not itemCount) then return end

            targetSelected.addInventoryItem(itemName, itemCount)
            print("VOUS AVEZ DONNE "..itemCount.." "..itemName.." A "..targetSelected.getName()..".")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local itemName = args[2]
            if (not itemName) then return end

            local itemCount = args[3] or 1
            if (not itemCount) then return end

            targetSelected.addInventoryItem(itemName, itemCount)
            playerSelected.showNotification("~g~Vous avez donné "..itemCount.." "..itemName.." à "..targetSelected.getName()..".")
        end
    end)

    GM.Command:register({
        name = "animation",
        label = "Menu animation",
        description = "Permet d'ouvrir le menu d'animation",
        keys = {"keyboard", "K"},
        permissions = false,
    }, function(playerSrc)
        if (playerSrc == 0) then return end

        TriggerClientEvent("Animation:openMenu", playerSrc)
    end)

    GM.Command:register({
        name = "animationCancel",
        label = "Annuler l'animation",
        description = "Permet d'annuler une animation",
        keys = {"keyboard", "X"},
        permissions = false
    }, function(playerSrc)
        if (playerSrc == 0) then return end

        TriggerClientEvent("Animation:cancelAnimation", playerSrc)
    end)

    GM.Command:register({
        name = "setJob",
        label = "Attribuer un métier",
        description = "Permet d'attribuer un métier à un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local jobName = args[2]
            if (not jobName) then return end

            local jobGrade = args[3] or 0
            if (not jobGrade) then return end

            if (ESX.DoesJobExist(jobName, jobGrade)) then
                targetSelected.setJob(jobName, jobGrade)
                print("VOUS AVEZ ATTRIBUE LE METIER "..jobName.." (GRADE : "..jobGrade..") A "..targetSelected.getName()..".")
            else
                print("JOB INVALID")
                return
            end
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local jobName = args[2]
            if (not jobName) then return end

            local jobGrade = args[3] or 0
            if (not jobGrade) then return end

            if (ESX.DoesJobExist(jobName, jobGrade)) then
                targetSelected.setJob(jobName, jobGrade)
                playerSelected.showNotification("~g~Vous avez attribué le métier "..jobName.." (grade : "..jobGrade..") à "..targetSelected.getName()..".")
            else
                playerSelected.showNotification("~r~Ce métier n'existe pas.")
                return
            end
        end
    end)

    GM.Command:register({
        name = "heal",
        label = "Soigner",
        description = "Permet de soigner un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            TriggerClientEvent("esx_status:set", targetSelected.source, "hunger", 1000000)
            TriggerClientEvent("esx_status:set", targetSelected.source, "thirst", 1000000)
            TriggerClientEvent("Ambulance:heal", targetSelected.source)

            print("VOUS AVEZ HEAL "..targetSelected.getName()..".")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            TriggerClientEvent("esx_status:set", targetSelected.source, "hunger", 1000000)
            TriggerClientEvent("esx_status:set", targetSelected.source, "thirst", 1000000)
            TriggerClientEvent("Ambulance:heal", targetSelected.source)

            playerSelected.showNotification("~g~Vous avez heal "..targetSelected.getName()..".")
        end
    end)

    GM.Command:register({
        name = "jobMenu",
        label = "Menu métier",
        description = "Permet d'ouvrir le menu métier",
        keys = {"keyboard", "F6"}
    }, function(playerSrc)
        if (playerSrc == 0) then return end

        local playerSelected = ESX.GetPlayerFromId(playerSrc)
        if (not playerSelected) then return end

        if (playerSelected.job.name == "unemployed") then
            playerSelected.showNotification("~r~Vous n'avez pas de métier.")
            return
        end

        local jobName = playerSelected.job.name
        if (not jobName) then return end

        if (GM.Service["Player_list"][playerSrc] == nil) then
            playerSelected.showNotification("~r~Vous n'êtes pas en service.")
            return
        end

        local jobName = string.upper(string.sub(jobName, 1, 1))..string.sub(jobName, 2, #jobName)

        TriggerClientEvent(jobName..":openMenu", playerSelected.source)
    end)

    GM.Command:register({
        name = "giveMoney",
        label = "Donner de l'argent",
        description = "Permet de donner de l'argent à un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local accountName = args[2]
            if (not accountName) then return end

            local amount = tonumber(args[3])
            if (not amount) then return end

            targetSelected.addAccountMoney(accountName, amount, true)
            print("VOUS AVEZ DONNE "..amount.." "..accountName.." A "..targetSelected.getName()..".")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            local accountName = args[2]
            if (not accountName) then return end

            local amount = tonumber(args[3])
            if (not amount) then return end

            targetSelected.addAccountMoney(accountName, amount, true)
            playerSelected.showNotification("~g~Vous avez donné "..amount.." "..accountName.." à "..targetSelected.getName()..".")
        end
    end)

    GM.Command:register({
        name = "clearInventory",
        label = "Vider l'inventaire",
        description = "Permet de vider l'inventaire d'un joueur",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            exports["believer"]:Clear(targetSelected.source)
            print("VOUS AVEZ CLEAR L'INVENTAIRE DE A "..targetSelected.getName()..".")
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local targetSelected = ESX.GetPlayerFromId(args[1])
            if (not targetSelected) then return end

            exports["believer"]:Clear(targetSelected.source)
            playerSelected.showNotification("~g~Vous avez clear l'inventaire à "..targetSelected.getName()..".")
        end
    end)

    GM.Command:register({
        name = "players",
        label = "Liste des joueurs",
        description = "Permet d'afficher la liste des joueurs",
    }, function(playerSrc, args)
        if (playerSrc == 0) then
            local playerCount = 0
            local players = ESX.GetPlayers()
            for i = 1, #players do
                local player = ESX.GetPlayerFromId(players[i])
                if (player) then
                    playerCount = playerCount + 1
                end
            end
            print("NOMBRE DE JOUEURS : ", playerCount)
        else
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            local playerCount = 0

            local players = ESX.GetPlayers()
            for i = 1, #players do
                local player = ESX.GetPlayerFromId(players[i])
                if (player) then
                    playerCount = playerCount + 1
                end
            end
            playerSelected.showNotification("~b~Nombre de joueurs : "..playerCount..".")
        end
    end)
end)