GM.Blip = GM.Blip or {}
GM.Blip["Registered"] = GM.Blip["Registered"] or {}

function GM.Blip:loadForPlayer(playerSrc)
    for i = 1, #GM.Blip["Registered"] do
        local selectedBlip = GM.Blip["Registered"][i]
        if (not selectedBlip.metadata["isPrivate"]) then
            TriggerClientEvent("Blip:add", playerSrc, selectedBlip)
        end
    end
end

AddEventHandler("esx:playerLoaded", function(playerSrc)
    if (not playerSrc) then return end

    GM.Blip:loadForPlayer(playerSrc)
end)