GM.Admin = GM.Admin or {}
GM.Admin.Reports = {}
GM.Admin.Reports["list"] = {}
GM.Admin.Reports["player"] = {}
GM.Admin.Reports["close_report"] = {}

function GM.Admin.Reports:new(id, source, name, reason)
    local newAdminReports = {}

    setmetatable(newAdminReports, self)
    self.__index = self

    if (GM.Admin.Reports["list"][id] ~= nil) then return end

    if (GM.Admin.Reports["player"][source] ~= nil) then
        -- Todo calculate time between creation report and now and if time > 5min then delete report

        TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà un report actif.") 
        return
    end

    newAdminReports.id = (id or (#GM.Admin.Reports["list"] + 1))

    newAdminReports.source = source
    newAdminReports.name = name
    newAdminReports.creation_date = os.date("%d/%m/%Y, %H:%M")
    newAdminReports.time = os.time()
    newAdminReports.taken = false
    newAdminReports.reason = reason

    GM.Admin.Reports["list"][newAdminReports.id] = newAdminReports
    GM.Admin.Reports["player"][newAdminReports.source] = newAdminReports.id

    TriggerClientEvent("esx:showNotification", newAdminReports.source, "~b~Votre report à bien été envoyé à l'administration.")

    SetTimeout(GM.Admin.ReportCooldown * 60000, function()
        if (GM.Admin.Reports["list"][newAdminReports.id] ~= nil) then
            if (GM.Admin.Reports["list"][newAdminReports.id].taken == true) then return end
            TriggerClientEvent("esx:showNotification", newAdminReports.source, "~g~Votre report n'étant toujours pas pris en charge.\nVous pouvez utiliser la commande /closereport afin de le fermer et d'en refaire un nouveau.")
            GM.Admin.Reports["close_report"][newAdminReports.source] = true
        end
    end)

    return newAdminReports
end

function GM.Admin.Reports:getFromId(reportId)
    return GM.Admin.Reports["list"][reportId]
end

function GM.Admin.Reports:count()
    return #GM.Admin.Reports["list"]
end

RegisterServerEvent("Admin:requestReports", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    TriggerClientEvent("Admin:updateValue", playerSrc, "reports", GM.Admin.Reports["list"])
end)

RegisterServerEvent("Admin:takeReport", function(reportId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    if (playerSelected.getGroup() == "user") then return end

    local reportSelected = GM.Admin.Reports:getFromId(reportId)
    if (not reportSelected) then return end

    if (reportSelected.taken) then return playerSelected.showNotification("~r~Ce report est déjà pris.") end

    local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
    if (not playerRank) then return end

    playerRank.players[playerIdentifier].reports = playerRank.players[playerIdentifier].reports + 1

    MySQL.update('UPDATE user_admin SET players = ? WHERE id = ?', {
        json.encode(playerRank.players), 
        playerRank.id
    }, function()
        reportSelected.taken = true
        reportSelected.taken_name = playerSelected.getNickName()
        TriggerClientEvent("esx:showNotification", reportSelected.source, "~b~Votre report à bien été pris en charge.")
        for adminSrc,_ in pairs(GM.Admin.inAdmin) do
            TriggerClientEvent("Admin:updateValue", adminSrc, "reports", reportId, reportSelected)
            TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", playerSelected.get("rank_id"), playerRank)
            TriggerClientEvent("chat:addMessage", adminSrc, { args = { '^5REPORT PRIS - '..reportSelected.id, reportSelected.taken_name .. ' à pris le report du joueur (' .. reportSelected.name .. ' - '..reportSelected.source..') '}}, true)
        end
        -- TriggerClientEvent("Interface:totalReportCount", playerSrc, playerRank.players[playerIdentifier].reports)
    end)
end)

RegisterServerEvent("Admin:closeReport", function(reportId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.getGroup() == "user") then return end

    local reportSelected = GM.Admin.Reports:getFromId(reportId)
    if (not reportSelected) then return end

    if (not reportSelected.taken) then return playerSelected.showNotification("~r~Ce report n'est pas pris.") end

    TriggerClientEvent("esx:showNotification", reportSelected.source, "~b~Votre report à bien été fermé.")
    
    GM.Admin.Reports["player"][reportSelected.source] = nil
    GM.Admin.Reports["list"][reportSelected.id] = nil

    for adminSrc,_ in pairs(GM.Admin.inAdmin) do
        TriggerClientEvent("Admin:removeValue", adminSrc, "reports", reportId)
        -- TriggerClientEvent("Interface:currentReportCount", adminSrc, tostring(GM.Admin.Reports:count()))
        TriggerClientEvent("chat:addMessage", adminSrc, { args = { '^5REPORT CLOSE - '..reportSelected.id, playerSelected.getNickName() .. ' à close le report ID - (' .. reportId..') '}}, true)
    end
end)

AddEventHandler("playerDropped", function()
    local playerSrc = source
    if (not playerSrc) then return end

    if (GM.Admin.Reports["player"][playerSrc]) then
        GM.Admin.Reports["list"][GM.Admin.Reports["player"][playerSrc]] = nil
        for adminSrc,_ in pairs(GM.Admin.inAdmin) do
            TriggerClientEvent("Admin:removeValue", adminSrc, "reports", GM.Admin.Reports["player"][playerSrc])
        end
        GM.Admin.Reports["player"][playerSrc] = nil
    end
end)