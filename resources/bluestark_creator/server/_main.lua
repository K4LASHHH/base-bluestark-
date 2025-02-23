ESX = exports['believer']:getSharedObject()

RegisterServerEvent("Creator:save", function(firstName, lastName, dateOfBirth, sexe, height)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (playerSelected.get("first_connection") == true) then
        playerSelected.showNotification("~b~Bienvenue sur BlueStark\nSi vous avez la moindre question n'hésitez pas à nous contacter sur notre discord: https://discord.gg/bluestark")
    end

    if (playerSelected.get("creator") == true) then 
        MySQL.update('UPDATE users SET firstname = ?, lastname = ?, dateofbirth = ?, sex = ?, height = ? WHERE identifier = ?', {
            firstName, 
            lastName, 
            dateOfBirth, 
            sexe, 
            height, 
            playerSelected.getIdentifier()
        }, function()
            playerSelected.set("creator", false)
            playerSelected.set("firstname", firstName)
            playerSelected.set("lastname", lastName)
            playerSelected.set("dateofbirth", dateOfBirth)
            playerSelected.set("sex", sexe)
            playerSelected.set("height", height)
            
        end)
    end
end)