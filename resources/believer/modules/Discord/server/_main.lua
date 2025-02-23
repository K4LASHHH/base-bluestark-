GM.Discord = GM.Discord or {}

AddEventHandler("esx:playerLoaded", function(playerSrc)
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    TriggerClientEvent("Discord:updateUniqueId", playerSrc, playerSelected.getUniqueId())
end)