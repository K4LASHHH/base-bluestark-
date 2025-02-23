GM.Admin = GM.Admin or {}

GM.Admin.menu.submenus["preferences"] = RageUI.CreateSubMenu(GM.Admin.menu.main, "", "Préférences")

GM.Admin.menu.submenus["preferences"]:isVisible(function(Items)
    local ADMIN_SHOW_GAMERTAGS = GM.Preferences:loadPreferences("admin_show_gamertags")
    Items:Checkbox("Afficher le nom des joueurs", nil, ADMIN_SHOW_GAMERTAGS, {}, {
        onSelected = function(Checked)
            ADMIN_SHOW_GAMERTAGS = Checked
        end,
        onChecked = function()
            GM.Preferences:Save("admin_show_gamertags", true)
            TriggerServerEvent("Admin:gamerTag", true)
        end,
        onUnChecked = function()
            GM.Preferences:Save("admin_show_gamertags", false)
            TriggerServerEvent("Admin:gamerTag", false)
        end,
    })
    local ADMIN_SHOW_MYSELF = GM.Preferences:loadPreferences("admin_show_myself")
    Items:Checkbox("Afficher mon nom", nil, ADMIN_SHOW_MYSELF, {}, {
        onSelected = function(Checked)
            ADMIN_SHOW_MYSELF = Checked
        end,
        onChecked = function()
            GM.Preferences:Save("admin_show_myself", true)
        end,
        onUnChecked = function()
            GM.Preferences:Save("admin_show_myself", false)
        end,
    })
    local ADMIN_SHOW_BLIPS = GM.Preferences:loadPreferences("admin_show_blips")
    Items:Checkbox("Afficher les blips", nil, ADMIN_SHOW_BLIPS, {}, {
        onSelected = function(Checked)
            ADMIN_SHOW_BLIPS = Checked
        end,
        onChecked = function()
            GM.Preferences:Save("admin_show_blips", true)
            TriggerServerEvent("Admin:blipsManager", true)
        end,
        onUnChecked = function()
            GM.Preferences:Save("admin_show_blips", false)
            TriggerServerEvent("Admin:blipsManager", false)
        end,
    })
    local ADMIN_SHOW_REPORTS = GM.Preferences:loadPreferences("admin_show_reports")
    Items:Checkbox("Afficher le nombre de reports", nil, ADMIN_SHOW_REPORTS, {}, {
        onSelected = function(Checked)
            ADMIN_SHOW_REPORTS = Checked
        end,
        onChecked = function()
            GM.Preferences:Save("admin_show_reports", true)
            TriggerServerEvent("Admin:showReportCount")
        end,
        onUnChecked = function()
            GM.Preferences:Save("admin_show_reports", false)
        end,
    })
    local ADMIN_SOUND_REPORTS = GM.Preferences:loadPreferences("admin_sound_reports")
    Items:Checkbox("Notification sonore lors d'un report", nil, ADMIN_SOUND_REPORTS, {}, {
        onSelected = function(Checked)
            ADMIN_SOUND_REPORTS = Checked
        end,
        onChecked = function()
            GM.Preferences:Save("admin_sound_reports", true)
        end,
        onUnChecked = function()
            GM.Preferences:Save("admin_sound_reports", false)
        end,
    })
    local ADMIN_MASK_LOGS_REPORTS = GM.Preferences:loadPreferences("admin_mask_logs_reports")
    Items:Checkbox("Masquer les logs des reports (chat)", nil, ADMIN_MASK_LOGS_REPORTS, {}, {
        onSelected = function(Checked)
            ADMIN_MASK_LOGS_REPORTS = Checked
        end,
        onChecked = function()
            GM.Preferences:Save("admin_mask_logs_reports", true)
        end,
        onUnChecked = function()
            GM.Preferences:Save("admin_mask_logs_reports", false)
        end,
    })
    local ADMIN_MASK_MSG_STAFF = GM.Preferences:loadPreferences("admin_mask_msg_staff")
    Items:Checkbox("Masquer les messages entre modérateurs (chat)", nil, ADMIN_MASK_MSG_STAFF, {}, {
        onSelected = function(Checked)
            ADMIN_MASK_MSG_STAFF = Checked
        end,
        onChecked = function()
            GM.Preferences:Save("admin_mask_msg_staff", true)
        end,
        onUnChecked = function()
            GM.Preferences:Save("admin_mask_msg_staff", false)
        end,
    })
    Items:Checkbox("Afficher toutes les propriétés", nil, ADMIN_SHOW_PROPERTIES, {}, {
        onSelected = function(Checked)
            ADMIN_SHOW_PROPERTIES = Checked
        end,
        onChecked = function()
        end,
        onUnChecked = function()
        end,
    })
end)

local gamerTags = {}

RegisterNetEvent("Admin:gamerTag", function(BOOLEAN)
    gamerTagActive = BOOLEAN
    if gamerTagActive then
        GM:newThread(function()
            while gamerTagActive do
                local plyPed = PlayerPedId()
                for _,v in pairs(GetActivePlayers()) do
                    if #(GetEntityCoords(plyPed, false) - GetEntityCoords(GetPlayerPed(v), false)) < 5000.0 then
                        if GM.Admin.data["players"][GetPlayerServerId(v)] ~= nil then
                            gamerTags[GetPlayerPed(v)] = CreateFakeMpGamerTag(GetPlayerPed(v), "("..GetPlayerServerId(v)..") - "..GM.Admin.data["players"][GetPlayerServerId(v)].name, false, false, "", 0)
                            SetMpGamerTagAlpha(gamerTags[GetPlayerPed(v)], 0, 255)
                            SetMpGamerTagAlpha(gamerTags[GetPlayerPed(v)], 2, 255)
                            SetMpGamerTagAlpha(gamerTags[GetPlayerPed(v)], 4, 255)
                            SetMpGamerTagVisibility(gamerTags[GetPlayerPed(v)], 0, true)
                            SetMpGamerTagVisibility(gamerTags[GetPlayerPed(v)], 2, true)
                            SetMpGamerTagVisibility(gamerTags[GetPlayerPed(v)], 4, NetworkIsPlayerTalking(v))

                            if GM.Admin.data["players"][GetPlayerServerId(v)].admin == true then
                                SetMpGamerTagVisibility(gamerTags[GetPlayerPed(v)], 14, true)
                                SetMpGamerTagAlpha(gamerTags[GetPlayerPed(v)], 14, 255)
                            else
                                SetMpGamerTagVisibility(gamerTags[GetPlayerPed(v)], 14, false)
                                SetMpGamerTagAlpha(gamerTags[GetPlayerPed(v)], 14, 0)
                            end

                            if GM.Admin.data["players"][GetPlayerServerId(v)].vip == 1 then
                                SetMpGamerTagVisibility(gamerTags[GetPlayerPed(v)], 7, true)
                                SetMpGamerTagAlpha(gamerTags[GetPlayerPed(v)], 7, 255)
                            else
                                SetMpGamerTagVisibility(gamerTags[GetPlayerPed(v)], 7, false)
                                SetMpGamerTagAlpha(gamerTags[GetPlayerPed(v)], 7, 0)
                            end
                        end
                        
                        if GM.Admin.data["players"][GetPlayerServerId(v)] ~= nil then
                            if GM.Admin.data["players"][GetPlayerServerId(v)].invisible == true then
                                RemoveMpGamerTag(gamerTags[GetPlayerPed(v)])
                            end
                        end

                        local ADMIN_SHOW_MYSELF = GM.Preferences:loadPreferences("admin_show_myself")

                        if (ADMIN_SHOW_MYSELF == false) and GetPlayerServerId(v) == GetPlayerServerId(PlayerId()) then
                            RemoveMpGamerTag(gamerTags[GetPlayerPed(v)])
                        end
                        
                        if GM.Admin.data["players"][GetPlayerServerId(v)] ~= nil then
                            if GM.Admin.data["players"][GetPlayerServerId(v)].rank == "Fondateur" then
                                SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 0, 9)
                            elseif GM.Admin.data["players"][GetPlayerServerId(v)].rank == "Manager" then
                                SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 0, 18)
                            elseif GM.Admin.data["players"][GetPlayerServerId(v)].rank == "Gérant Staff" then
                                SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 0, 27)
                            elseif GM.Admin.data["players"][GetPlayerServerId(v)].rank == "Administrateur" then
                                SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 0, 31)
                            elseif GM.Admin.data["players"][GetPlayerServerId(v)].rank == "Modérateur" then
                                SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 0, 4)
                            elseif GM.Admin.data["players"][GetPlayerServerId(v)].rank == "Helpeur" then
                                SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 0, 5)
                            elseif GM.Admin.data["players"][GetPlayerServerId(v)].rank == "Ami" then
                                SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 0, 6)
                            end
                        end
                        if NetworkIsPlayerTalking(v) then
                            SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 4, 0)
                        else
                            SetMpGamerTagColour(gamerTags[GetPlayerPed(v)], 4, 0)
                        end
                    else
                        RemoveMpGamerTag(gamerTags[GetPlayerPed(v)])
                        gamerTags[GetPlayerPed(v)] = nil
                    end
                end
                Citizen.Wait(25)
            end
            for _,v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
            end
            gamerTags = {}
        end)
    end
end)

RegisterNetEvent("Admin:blipsManager", function(BLIPS_DATA)

    if (type(BLIPS_DATA) ~= "table" and BLIPS_DATA == false) then
        for _, blip in pairs(GM.Admin.data["blips_list"]) do
            RemoveBlip(blip)
        end
        return
    end

    for _, blip in pairs(GM.Admin.data["blips_list"]) do
        RemoveBlip(blip)
    end

    for blipId, blipData in pairs(BLIPS_DATA) do
        if (not DoesBlipExist(GM.Admin.data["blips_list"][blipId])) then
            GM.Admin.data["blips_list"][blipId] = AddBlipForCoord(blipData.x, blipData.y, blipData.z)
            SetBlipSprite(GM.Admin.data["blips_list"][blipId], 6)
            SetBlipScale(GM.Admin.data["blips_list"][blipId], 0.70)
            SetBlipColour(GM.Admin.data["blips_list"][blipId], 0)
            SetBlipAsShortRange(GM.Admin.data["blips_list"][blipId], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(blipId.." - "..blipData.name)
            EndTextCommandSetBlipName(GM.Admin.data["blips_list"][blipId])
        end
    end
end)