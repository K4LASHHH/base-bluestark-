GM.Jail = GM.Jail or {}

GM.Jail.List = {}

GM:newThread(function()
    loadAllJails = false
    MySQL.query("SELECT * FROM user_jail", {}, function(results)
        for _, jail in pairs(results) do
            if (GM.Jail.List[jail.identifier] == nil) then
                GM.Jail.List[jail.identifier] = {
                    time = jail.time,
                }
            end
        end
        loadAllJails = true
    end)
end)

AddEventHandler("esx:playerLoaded", function(playerSrc)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    while (not loadAllJails) do
        Wait(100)
    end

    if (GM.Jail.List[playerIdentifier] ~= nil) then
        GM.Jail.List[playerIdentifier].joinTime = os.time(os.date("!*t"))
        SetEntityCoords(playerSelected.getPed(), 1728.492, 2532.91, 43.58)

        TriggerClientEvent("Jail:sendInJail", playerSelected.source, GM.Jail.List[playerIdentifier].time)
    end
end)

RegisterServerEvent("Jail:isJailFinish", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    if (GM.Jail.List[playerIdentifier] ~= nil) then
        local time = GM.Jail.List[playerIdentifier].time
        local joinTime = GM.Jail.List[playerIdentifier].joinTime
        local currentTime = os.time(os.date("!*t"))
        local timeLeft = time - (currentTime - joinTime)

        if (timeLeft <= 0) then
            MySQL.query('SELECT * FROM user_jail WHERE identifier = ?', {playerIdentifier}, function(result)
                if (result[1] ~= nil) then
                    MySQL.Async.execute("DELETE FROM user_jail WHERE identifier = ?", {
                        playerIdentifier
                    }, function()
                        GM.Jail.List[playerIdentifier] = nil
                    end)
                end
                TriggerClientEvent("Jail:sendOutJail", playerSrc)
                SetEntityCoords(playerSelected.getPed(), 1851.03, 2586.16, 45.67)
                playerSelected.showNotification("~g~Vous avez été libéré de prison !\nMerci de relire le règlement !")
            end)
        end
    end
end)

AddEventHandler("playerDropped", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    if (GM.Jail.List[playerIdentifier] ~= nil) then
        local time = GM.Jail.List[playerIdentifier].time
        local joinTime = GM.Jail.List[playerIdentifier].joinTime
        local currentTime = os.time(os.date("!*t"))
        local timeLeft = time - (currentTime - joinTime)

        if (timeLeft > 0) then
            MySQL.query('SELECT * FROM user_jail WHERE identifier = ?', {playerIdentifier}, function(result)
                if (result[1] == nil) then
                    MySQL.insert('INSERT INTO user_jail (identifier, time) VALUES (@identifier, @time)', {
                        ['@identifier'] = playerIdentifier,
                        ['@time'] = timeLeft
                    }, function()
                        GM.Jail.List[playerIdentifier].time = timeLeft
                    end)
                else
                    MySQL.update('UPDATE user_jail SET time = ? WHERE identifier = ?', {timeLeft, playerIdentifier}, function()
                        GM.Jail.List[playerIdentifier].time = timeLeft
                    end)
                end
            end)
        end
    end
end)