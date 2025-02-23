GM.Armor["player"] = {}

AddEventHandler("Armor:item:use", function(source, item)
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Armor["player"][playerSelected.source] == nil) then
        GM.Armor["player"][playerSelected.source] = item.itemHash
        playerSelected.showInventoryNotification("success", "Vous avez équipé un kevlar !")
        playerSelected.setPedArmor(item.meta.durability)

        item.meta.durability = 0

        exports["believer"]:SetMetaData(playerSelected.source, { itemHash = item.itemHash }, item.meta)

        TriggerClientEvent("Armor:setActive", playerSelected.source, true)
    else
        if (GM.Armor["player"][playerSelected.source] == item.itemHash) then
            item.meta.durability = playerSelected.getPedArmor()

            exports["believer"]:SetMetaData(playerSelected.source, { itemHash = GM.Armor["player"][playerSelected.source] }, item.meta)
            playerSelected.setPedArmor(0)
            playerSelected.showInventoryNotification("success", "Vous avez retiré votre kevlar !")

            GM.Armor["player"][playerSelected.source] = nil

            TriggerClientEvent("Armor:setActive", playerSelected.source, false)
        else
            playerSelected.showInventoryNotification("warning", "Vous avez déjà un kevlar équipé !  Retirez le avant d'en équiper un autre !")
            return
        end
    end
end)

RegisterServerEvent("Armor:removeItem", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Armor["player"][playerSelected.source] ~= nil) then
        local item = exports["believer"]:GetItemBy(playerSelected.source, {itemHash = GM.Armor["player"][playerSelected.source]})
        if (item) then

            exports["believer"]:RemoveItemBy(playerSelected.source, 1, {
                itemHash = GM.Armor["player"][playerSelected.source]
            })

            playerSelected.showInventoryNotification("success", "Votre kevlar s'est brisé !")

            GM.Armor["player"][playerSelected.source] = nil
        end
    end
end)