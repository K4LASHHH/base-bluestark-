GM.Billing = {
    ["list"] = {},
    ["priority"] = {
        ["police"] = true,
    },
}

RegisterServerEvent("Billing:requestBills", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Billing.list[playerSelected.source] == nil) then
        GM.Billing.list[playerSelected.source] = {}
        MySQL.query('SELECT * FROM user_billing WHERE identifier = ?', {playerSelected.identifier}, function(result)
            if (result[1]) then
                allBills = json.decode(result[1].data)
                for i = 1, #allBills do
                    local billData = {
                        ["label"] = allBills[i].label or "Facture (non défini)",
                        ["amount"] = allBills[i].amount or 0,
                        ["job"] = allBills[i].job or false,
                        ["priority"] = allBills[i].priority or false,
                    }
                    table.insert(GM.Billing.list[playerSelected.source], billData)
                end
            else
                local id = MySQL.insert.await('INSERT INTO user_billing (identifier, data) VALUES (?, ?)', {playerSelected.identifier, json.encode(GM.Billing.list[playerSelected.source])})
            end
            TriggerClientEvent("Billing:updateValue", playerSelected.source, "list", GM.Billing.list[playerSelected.source])
        end)
    else
        TriggerClientEvent("Billing:updateValue", playerSelected.source, "list", GM.Billing.list[playerSelected.source])
    end
end)

RegisterServerEvent("Billing:send", function(newData)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerPosition = playerSelected.getCoords(true)

    if (playerSelected.job.name == "unemployed") then
        playerSelected.showNotification("~r~Vous ne pouvez pas faire de facture.")
        return
    end

    if (playerSelected.job.name ~= newData.job) then
        playerSelected.showNotification("~r~Vous ne pouvez pas faire de facture à cette personne.")
        return
    end

    local targetSelected = ESX.GetPlayerFromId(newData.target)
    if (not targetSelected) then return end

    local targetPosition = targetSelected.getCoords(true)

    if (#(playerPosition - targetPosition) > 5.0) then
        playerSelected.showNotification("~r~Vous êtes trop loin de cette personne pour pouvoir la facturer.")
        return
    end

    if (GM.Billing.priority[playerSelected.job.name]) then
        newData.priority = true
    end

    if (type(newData.amount) ~= "number") then
        newData.amount = tonumber(newData.amount)
    end

    if (newData.amount <= 0) then
        playerSelected.showNotification("~r~Vous ne pouvez pas faire de facture de 0$.")
        return
    end

    if (newData.label == "" or newData.label == nil) then
        newData.label = "Facture (non défini)"
    end

    local request = GM.Request:sendMessage(targetSelected.source, "Vous avez reçu une facture pour "..newData.label.." d'un montant de ~g~"..newData.amount.."$~s~.")

    if (request == "accept") then
        local playerMoney = targetSelected.getAccount("money").money
        local playerBank = targetSelected.getAccount("bank").money
        if (playerMoney >= newData.amount) then
            targetSelected.removeAccountMoney("money", newData.amount, true)
            -- Todo add amount to society system
        elseif (playerBank >= newData.amount) then
            targetSelected.removeAccountMoney("bank", newData.amount)
            -- Todo add amount to society system
        elseif (newData.priority) then
            targetSelected.removeAccountMoney("bank", newData.amount)
            -- Todo add amount to society system
            targetSelected.showNotification("~r~Vous n'avez pas assez d'argent pour payer une amende de priorité.\nL'argent à été débité de votre compte bancaire automatiquement.")
            playerSelected.showNotification("~g~La personne n'a pas assez d'argent pour payer une amende de priorité.\nL'argent à été débité de son compte bancaire automatiquement.")
            return
        else
            targetSelected.showNotification("~r~Vous n'avez pas assez d'argent (situation critique).")
            playerSelected.showNotification("~r~La personne n'est pas solvable.")
            return
        end
        playerSelected.showNotification("~g~La personne a accepté de payer la facture (+"..newData.amount.."$).")
        targetSelected.showNotification("~g~Vous avez accepté de payer la facture (-"..newData.amount.."$).")
    elseif (request == "decline" or request == "delay") then
        if (newData.priority) then
            local playerMoney = targetSelected.getAccount("money").money
            local playerBank = targetSelected.getAccount("bank").money
            if (playerMoney >= newData.amount) then
                targetSelected.removeAccountMoney("money", newData.amount, true)
                -- Todo add amount to society system
            elseif (playerBank >= newData.amount) then
                targetSelected.removeAccountMoney("bank", newData.amount)
                -- Todo add amount to society system
            elseif (newData.priority) then
                targetSelected.removeAccountMoney("bank", newData.amount)
                -- Todo add amount to society system
                targetSelected.showNotification("~r~Vous n'avez pas assez d'argent pour payer une amende de priorité.\nL'argent à été débité de votre compte bancaire automatiquement.")
                playerSelected.showNotification("~g~La personne n'a pas assez d'argent pour payer une amende de priorité.\nL'argent à été débité de son compte bancaire automatiquement.")
                return
            end
            playerSelected.showNotification("~g~La personne a payer la facture (+"..newData.amount.."$).")
            targetSelected.showNotification("~r~Amende de priorité débité automatiquement (-"..newData.amount.."$).")
        end
    end

    TriggerClientEvent("Billing:updateValue", targetSelected.source, "list", GM.Billing.list[targetSelected.source])
end)

RegisterServerEvent("Billing:pay", function(billId)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Billing.list[playerSelected.source] == nil) then
        playerSelected.showNotification("~r~Vous n'avez aucune facture.")
        return
    end

    for i = 1, #GM.Billing.list[playerSelected.source], 1 do
        if (i == billId) then
            local playerMoney = playerSelected.getAccount("money").money
            local playerBank = playerSelected.getAccount("bank").money
            if (playerMoney >= GM.Billing.list[playerSelected.source][i].amount) then
                playerSelected.removeAccountMoney("money", GM.Billing.list[playerSelected.source][i].amount, true)
                -- Todo add amount to society system
            elseif (playerBank >= GM.Billing.list[playerSelected.source][i].amount) then
                playerSelected.removeAccountMoney("bank", GM.Billing.list[playerSelected.source][i].amount)
                -- Todo add amount to society system
            elseif (GM.Billing.list[playerSelected.source][i].priority) then
                playerSelected.removeAccountMoney("bank", GM.Billing.list[playerSelected.source][i].amount)
                -- Todo add amount to society system
                playerSelected.showNotification("~r~Vous n'avez pas assez d'argent pour payer une amende de priorité.\nL'argent à été débité de votre compte bancaire automatiquement.")
                return
            end
            playerSelected.showNotification("~g~Vous avez payé la facture (-"..GM.Billing.list[playerSelected.source][i].amount.."$).")
            table.remove(GM.Billing.list[playerSelected.source], i)
            MySQL.update('UPDATE user_billing SET data = ? WHERE identifier = ?', {json.encode(GM.Billing.list[playerSelected.source]), playerSelected.identifier}, function()
                TriggerClientEvent("Billing:updateValue", playerSelected.source, "list", GM.Billing.list[playerSelected.source])
            end)
            break
        end
    end
end)
RegisterServerEvent("Billing:addBill")
AddEventHandler("Billing:addBill", function(newData)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    playerSelected.showNotification("~r~Vous avez reçu une facture.")

    if (GM.Billing.list[playerSelected.source] == nil) then
        GM.Billing.list[playerSelected.source] = {}
        MySQL.query('SELECT * FROM user_billing WHERE identifier = ?', {playerSelected.identifier}, function(result)
            if (result[1]) then
                allBills = json.decode(result[1].data)
                for i = 1, #allBills do
                    local billData = {
                        ["label"] = allBills[i].label or "Facture (non défini)",
                        ["amount"] = allBills[i].amount or 0,
                        ["job"] = allBills[i].job or false,
                        ["priority"] = allBills[i].priority or false,
                    }
                    table.insert(GM.Billing.list[playerSelected.source], billData)
                end
                table.insert(GM.Billing.list[playerSelected.source], {
                    ["label"] = newData.label or "Facture (non défini)",
                    ["amount"] = newData.amount or 0,
                    ["job"] = newData.job or false,
                    ["priority"] = newData.priority or false,
                })
                local bill = MySQL.update.await('UPDATE user_billing SET data = ? WHERE identifier = ?', {json.encode(GM.Billing.list[playerSelected.source]), playerSelected.identifier})
            else
                table.insert(GM.Billing.list[playerSelected.source], {
                    ["label"] = newData.label or "Facture (non défini)",
                    ["amount"] = newData.amount or 0,
                    ["job"] = newData.job or false,
                    ["priority"] = newData.priority or false,
                })
                local id = MySQL.insert.await('INSERT INTO user_billing (identifier, data) VALUES (?, ?)', {playerSelected.identifier, json.encode(GM.Billing.list[playerSelected.source])})
            end
            TriggerClientEvent("Billing:updateValue", playerSelected.source, "list", GM.Billing.list[playerSelected.source])
        end)
    else
        table.insert(GM.Billing.list[playerSelected.source], {
            ["label"] = newData.label or "Facture (non défini)",
            ["amount"] = newData.amount or 0,
            ["job"] = newData.job or false,
            ["priority"] = newData.priority or false,
        })
        MySQL.update('UPDATE user_billing SET data = ? WHERE identifier = ?', {json.encode(GM.Billing.list[playerSelected.source]), playerSelected.identifier}, function()
            TriggerClientEvent("Billing:updateValue", playerSelected.source, "list", GM.Billing.list[playerSelected.source])
        end)
    end
end)