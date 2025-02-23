GM.Ranks = GM.Ranks or {}

GM:newThread(function()
    loadAllRanks = false
    MySQL.query("SELECT * FROM user_admin", {}, function(results)
        if (results[1]) then
            for _, rankValues in pairs(results) do
                GM.Ranks:new(rankValues.id, rankValues.name, rankValues.label, json.decode(rankValues.players), json.decode(rankValues.commands), json.decode(rankValues.permissions))
            end
            loadAllRanks = true
        end
    end)
end)

GM:newThread(function()
    while (not loadAllRanks) do
        Wait(50)
    end
    for rankId, _ in pairs(GM.Ranks["list"]) do
        local selectedRank = GM.Ranks:getFromId(rankId)
        selectedRank:actualizeCommands()
        selectedRank:actualizePermissions()
    end
end)

RegisterServerEvent("Ranks:requestRanks", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    TriggerClientEvent("Ranks:updateValue", playerSrc, "ranks", GM.Ranks["list"])
end)

RegisterServerEvent("Ranks:createRank", function(rankName, rankLabel)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local selectedRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not selectedRank) then return end

    if (not selectedRank:getPermissionsValue("CREATE_RANK", playerSelected.source)) then return end

    if (GM.Ranks:getFromName(rankName) ~= nil) then
        TriggerClientEvent("esx:showNotification", playerSrc, "~r~Un rank existe déjà avec ce nom.")
        return
    end

    if (rankName == nil or rankName == "") then
        TriggerClientEvent("esx:showNotification", playerSrc, "~r~Vous devez entrer un nom de rank valide.")
        return
    end

    if (rankLabel == nil or rankLabel == "") then
        TriggerClientEvent("esx:showNotification", playerSrc, "~r~Vous devez entrer un label de rank valide.")
        return
    end

    for commandName, commandValues in pairs(GM.Command.List) do
        GM.Command.List[commandName].value = false
    end

    MySQL.insert('INSERT INTO user_admin (name, label, players, commands, permissions) VALUES (?, ?, ?, ?, ?)', {
        rankName,
        rankLabel,
        json.encode({}),
        json.encode(GM.Command.List),
        json.encode(GM.Admin.Permissions)
    }, function(rankId)
        local newRank = GM.Ranks:new(rankId, rankName, rankLabel, {}, GM.Command.List, {})
        for adminSrc,_ in pairs(GM.Admin.inAdmin) do
            TriggerClientEvent("Ranks:updateValue", adminSrc, "ranks", rankId, newRank)
        end
    end)
end)

RegisterServerEvent("Ranks:deleteRank", function(rankId, input)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() ~= "founder") then return playerSelected.showNotification("~r~Vous n'avez pas la permission de supprimer un rank.") end

    if (input ~= "oui" and input ~= "OUI") then return playerSelected.showNotification("~r~Vous n'avez pas correctement rempli la demande de suppression.") end

    local selectedRank = GM.Ranks:getFromId(rankId)
    if (not selectedRank) then return end

    if (selectedRank.name == "user") then return playerSelected.showNotification("~r~Vous ne pouvez pas supprimer le rank user.") end

    MySQL.Async.execute("DELETE FROM user_admin WHERE id = ?", {
        rankId
    }, function()
        for playerIdentifier, _ in pairs(selectedRank.players) do
            local player = ESX.GetPlayerFromIdentifier(playerIdentifier)
            if (player) then
                player.setGroup("user")
                player.set("rank_id", GM.Ranks["rank_user"])
                player.showNotification("~r~Votre rank a été supprimé, vous avez donc été rétrogradé au rank user.")
                TriggerClientEvent("Chat:removeMode", player.source, "STAFF")
            end
        end
        GM.Ranks["list"][rankId] = nil
        for adminSrc,_ in pairs(GM.Admin.inAdmin) do
            TriggerClientEvent("Ranks:updateValue", adminSrc, "ranks", GM.Ranks["list"])
        end
    end)
end)

RegisterServerEvent("Ranks:recruitPlayerRank", function(rankId, input)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local selectedRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not selectedRank) then return end

    if (not selectedRank:getPermissionsValue("RECRUIT_PLAYER_RANK", playerSelected.source)) then return end

    if (not selectedRank:canInteract(rankId)) then return playerSelected.showNotification("~r~Vous ne pouvez pas recruter un joueur dans un rank plus haut que vous.") end

    local selectedRank = GM.Ranks:getFromId(rankId)
    if (not selectedRank) then return end

    local targetSelected = ESX.GetPlayerFromId(tonumber(input))
    if (not targetSelected) then return end

    local targetIdentifier = targetSelected.getIdentifier()
    if (not targetIdentifier) then return end

    if (GM.Ranks["players"][targetIdentifier]) then return playerSelected.showNotification("~r~Ce joueur est déjà présent dans un rank") end

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
            TriggerClientEvent("Ranks:updateValue", adminSrc, "ranks", rankId, selectedRank)
        end
    end)
end)

RegisterServerEvent("Ranks:updateRankCommands", function(rankId, commandName, commandValue)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local selectedRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not selectedRank) then return end

    if (not selectedRank:getPermissionsValue("MANAGE_RANK_COMMANDS", playerSelected.source)) then return end

    if (not selectedRank:canInteract(rankId)) then return playerSelected.showNotification("~r~Vous ne pouvez pas changer les commandes d'un rank au dessus de vous.") end

    local selectedRank = GM.Ranks:getFromId(rankId)
    if (not selectedRank) then return end

    selectedRank.commands[commandName].value = commandValue

    MySQL.update('UPDATE user_admin SET commands = ? WHERE id = ?', {
        json.encode(selectedRank.commands), 
        selectedRank.id
    }, function()
        playerSelected.showNotification("~b~Vous avez mis à jour la permission pour la commande /"..commandName.." pour le grade "..selectedRank.name)
        for adminSrc,_ in pairs(GM.Admin.inAdmin) do
            TriggerClientEvent("Ranks:updateValue", adminSrc, "ranks", rankId, selectedRank)
        end
    end)
end)

RegisterServerEvent("Ranks:updateRankPermissions", function(rankId, permissionName, permissionValue)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local selectedRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not selectedRank) then return end

    if (not selectedRank:getPermissionsValue("MANAGE_RANK_PERMISSIONS", playerSelected.source)) then return end

    if (not selectedRank:canInteract(rankId)) then return playerSelected.showNotification("~r~Vous ne pouvez pas changer les permissions d'un rank au dessus de vous.") end

    local selectedRank = GM.Ranks:getFromId(rankId)
    if (not selectedRank) then return end

    selectedRank.permissions[permissionName].value = permissionValue

    MySQL.update('UPDATE user_admin SET permissions = ? WHERE id = ?', {
        json.encode(selectedRank.permissions), 
        selectedRank.id
    }, function()
        TriggerClientEvent("esx:showNotification", playerSrc, "~b~Vous avez mis à jour les permissions du grade "..permissionName..".")

        for adminSrc,_ in pairs(GM.Admin.inAdmin) do
            TriggerClientEvent("Ranks:updateValue", adminSrc, "ranks", rankId, selectedRank)
        end
    end)
end)

RegisterServerEvent("Ranks:kickPlayerRank", function(rankId, playerIdentifier)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local selectedRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not selectedRank) then return end

    if (not selectedRank:getPermissionsValue("KICK_PLAYER_RANK", playerSelected.source)) then return end

    if (not selectedRank:canInteract(rankId)) then return playerSelected.showNotification("~r~Vous ne pouvez pas kick un staff plus haut que vous.") end

    local selectedRank = GM.Ranks:getFromId(rankId)
    if (not selectedRank) then return end

    local selectedPlayer = ESX.GetPlayerFromIdentifier(playerIdentifier)

    if (not selectedRank.players[playerIdentifier]) then return end

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
            TriggerClientEvent("Ranks:updateValue", adminSrc, "ranks", rankId, selectedRank)
        end
    end)
end)