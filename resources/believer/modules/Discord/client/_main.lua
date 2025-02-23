GM.Discord = GM.Discord or {}

GM.Discord["uniqueId"] = 0

GM:newThread(function()
    SetDiscordAppId("1066358559580889219")
    SetDiscordRichPresenceAsset("bluestark_big")
    SetDiscordRichPresenceAssetSmall("discord")
    SetDiscordRichPresenceAssetSmallText("discord.gg/bluestark")
    SetRichPresence(("[%s] %s | %s/%s"):format(GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 2, 2))
    SetDiscordRichPresenceAction(0, "🔔 Discord", "https://discord.gg/bluestark")
    SetDiscordRichPresenceAction(1, "🌸 Se Connecter", "fivem://connect/755brd")

    AddTextEntry("PM_PANE_CFX", "BlueStark")

    while true do
        -- Todo update player count and slots
        AddTextEntry("FE_THDR_GTAO", ("~b~BlueStark RP~s~ | Joueurs : "..(0).."/"..(0).." | ID : ~b~"..GetPlayerServerId(PlayerId()).."~s~ | ID UNIQUE : "..GM.Discord["uniqueId"]))
        Wait(5000)
    end
end)

RegisterNetEvent("Discord:updateUniqueId", function(uniqueId)
    GM.Discord["uniqueId"] = uniqueId
end)