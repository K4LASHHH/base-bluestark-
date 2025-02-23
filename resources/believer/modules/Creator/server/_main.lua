GM.Creator = GM.Creator or {}

RegisterServerEvent("Creator:createIdentity", function(identity)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    if (playerSelected.get("creator") ~= true) then
        print("Player " .. playerIdentifier .. " tried to create an identity but is not a creator.")
        return
    end

    MySQL.update('UPDATE users SET firstname = ?, lastname = ?, dateofbirth = ?, sex = ?, height = ? WHERE identifier = ?', {identity.first_name, identity.last_name, identity.dateofbirth, identity.sex, identity.height, playerIdentifier}, function()
        playerSelected.showNotification("~g~Votre identité a bien été crée !")
        playerSelected.set("creator", false)
        playerSelected.set("firstName", identity.first_name)
        playerSelected.set("lastName", identity.last_name)
        playerSelected.set("dateofbirth", identity.dateofbirth)
        playerSelected.set("sex", identity.sex)
        playerSelected.set("height", identity.height)
        playerSelected.set("playerName", identity.first_name .. " " .. identity.last_name)

        if (GM.Admin.Players["list"][playerSelected.source]) then
            GM.Admin.Players["list"][playerSelected.source].name = identity.first_name .. " " .. identity.last_name
            for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                TriggerClientEvent("Admin:updateValue", adminSrc, "players", playerSelected.source, GM.Admin.Players["list"][playerSelected.source])
            end
        end
    end)
end)

RegisterServerEvent("Creator:modifyIdentity", function(identity)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    local playerIdentifier = playerSelected.getIdentifier()
    if (not playerIdentifier) then return end

    if (playerSelected.get("reset_identity") ~= true) then
        print("Player " .. playerIdentifier .. " tried to modify an identity.")
        return
    end

    MySQL.update('UPDATE users SET firstname = ?, lastname = ?, dateofbirth = ?, sex = ?, height = ? WHERE identifier = ?', {identity.first_name, identity.last_name, identity.dateofbirth, identity.sex, identity.height, playerIdentifier}, function()
        playerSelected.showNotification("~g~Votre identité a bien été modifiée !")
        playerSelected.set("reset_identity", false)
        playerSelected.set("firstName", identity.first_name)
        playerSelected.set("lastName", identity.last_name)
        playerSelected.set("dateofbirth", identity.dateofbirth)
        playerSelected.set("sex", identity.sex)
        playerSelected.set("height", identity.height)
        playerSelected.set("playerName", identity.first_name .. " " .. identity.last_name)
        TriggerClientEvent("Creator:closeIdentity", playerSrc)

        if (GM.Admin.Players["list"][playerSelected.source]) then
            GM.Admin.Players["list"][playerSelected.source].name = identity.first_name .. " " .. identity.last_name
            for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                TriggerClientEvent("Admin:updateValue", adminSrc, "players", playerSelected.source, GM.Admin.Players["list"][playerSelected.source])
            end
        end
    end)
end)