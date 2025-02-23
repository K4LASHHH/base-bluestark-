GM.Service = GM.Service or {}

GM.Service["Enterprise_list"] = {}
GM.Service["Player_list"] = {}
GM.Service["Crash_list"] = {}

RegisterServerEvent("Service:interact")
AddEventHandler("Service:interact", function(source)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerJob = playerSelected.job.name

    if (playerJob == "unemployed") then
        playerSelected.showNotification("~r~Vous n'avez pas de métier.")
        return
    end

    if (GM.Service["Enterprise_list"][playerJob] == nil) then
        GM.Service["Enterprise_list"][playerJob] = {}
    end

    if (GM.Service["Player_list"][playerSrc] == nil) then
        GM.Service["Player_list"][playerSrc] = true
        GM.Service["Enterprise_list"][playerJob][playerSrc] = true
        playerSelected.showNotification("~g~Vous avez pris votre service.")
    else
        GM.Service["Player_list"][playerSrc] = nil
        GM.Service["Enterprise_list"][playerJob][playerSrc] = nil
        playerSelected.showNotification("~r~Vous avez pris votre fin de service.")
    end

    if (GM.Service["Player_list"][playerSrc] == nil) then
        TriggerClientEvent("Service:sendActivity", playerSrc, false)
    else
        TriggerClientEvent("Service:sendActivity", playerSrc, true)
    end
end)

function GM.Service:getPeopleService(jobName)
    if (GM.Service["Enterprise_list"][jobName] == nil) then
        return {}
    end

    return GM.Service["Enterprise_list"][jobName]
end

AddEventHandler("playerDropped", function(reason)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end
    
    if (GM.Service["Player_list"][playerSrc]) then
        if (reason == "Disconnected." or reason == "Exiting") then
            GM.Service["Player_list"][playerSrc] = nil
        else
            if (GM.Service["Crash_list"][playerSelected.getIdentifier()] == nil) then
                GM.Service["Crash_list"][playerSelected.getIdentifier()] = {}
            end
        end
    end
end)

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerJob = playerSelected.job.name

    if (GM.Service["Enterprise_list"][playerJob] == nil) then
        GM.Service["Enterprise_list"][playerJob] = {}
    end

    GM.Service["Player_list"][playerSelected.source] = true
    GM.Service["Enterprise_list"][playerJob][playerSelected.source] = true
    playerSelected.showNotification("~g~Vous avez pris votre service.")

    if (GM.Service["Crash_list"][playerSelected.getIdentifier()]) then
        playerSelected.showNotification("~b~Vous avez été déconnecté en service (crash client), vous êtes donc toujours en service.")
        GM.Service["Player_list"][playerSrc] = true
        GM.Service["Enterprise_list"][playerJob][playerSrc] = true
        GM.Service["Crash_list"][playerSelected.getIdentifier()] = nil
    end
end)