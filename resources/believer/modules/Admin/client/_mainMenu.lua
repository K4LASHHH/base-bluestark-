GM.Admin = {
    menu = {
        submenus = {}
    },
    data = {
        reports = {},
        players = {},
        blips = {},
        blips_list = {},
        informations = {},
        sanctions = {},
        vehicles = {}
    },
    inAdmin = false
}

GM.Admin.menu.main = RageUI.CreateMenu("", "Administration", 0, 0, "banner", "bluestark")

GM.Admin.menu.main:isVisible(function(Items)
    if (GM.Admin.inAdmin == true) then
        GM.Admin.CheckboxActivate = "Désactiver le mode admin"
    else
        GM.Admin.CheckboxActivate = "Activer le mode admin"
    end

    Items:Checkbox(GM.Admin.CheckboxActivate, nil, adminCheckbox, {}, {
        onSelected = function(Checked)
            adminCheckbox = Checked
        end,
        onChecked = function()
            GM.Admin.inAdmin = true
            TriggerServerEvent("Admin:updatePlayerStaff", true)
            if (GM.Preferences:loadPreferences("admin_show_gamertags") == true) then
                TriggerServerEvent("Admin:gamerTag", true)
            end
            if (GM.Preferences:loadPreferences("admin_show_blips") == true) then
                TriggerServerEvent("Admin:blipsManager", true)
            end
        end,
        onUnChecked = function()
            GM.Admin.inAdmin = false
            TriggerServerEvent("Admin:updatePlayerStaff", false)
            if (GM.Preferences:loadPreferences("admin_show_gamertags") == true) then
                TriggerServerEvent("Admin:gamerTag", false)
            end
            if (GM.Preferences:loadPreferences("admin_show_blips") == true) then
                TriggerServerEvent("Admin:blipsManager", false)
            end
        end,
    })

    if (GM.Admin.inAdmin == true) then
        Items:Button("Mon joueur", nil, {}, GM.Admin.inAdmin, {}, GM.Admin.menu.submenus["my_player"])
        Items:Button("Autour de moi", nil, {}, GM.Admin.inAdmin, {}, GM.Admin.menu.submenus["around_me"])
        Items:Button("Véhicules", nil, {}, GM.Admin.inAdmin, {}, GM.Admin.menu.submenus["vehicles"])
        Items:Button("Listes des joueurs", nil, {}, GM.Admin.inAdmin, {
            onSelected = function()
                TriggerServerEvent("Admin:requestPlayers")
            end
        }, GM.Admin.menu.submenus["players"])
        Items:Button("Reports", nil, {}, GM.Admin.inAdmin, {
            onSelected = function()
                TriggerServerEvent("Admin:requestReports")
            end
        }, GM.Admin.menu.submenus["report"])
        Items:Button("Préférences", nil, {}, GM.Admin.inAdmin, {}, GM.Admin.menu.submenus["preferences"])
        Items:Button("Ouvrir le wiki", nil, {}, GM.Admin.inAdmin, {
            onSelected = function()
                SEND_NUI_MESSAGE({
                    event = "BROWSER_OPEN",
                    url = "https://wiki.bluestark.fr/"
                })
            end
        })
    end
end)

RegisterNetEvent("Admin:openMenu", function()
    GM.Admin.menu.main:toggle()
end)

RegisterNetEvent("Admin:updateValue", function(ADMIN_DATA, ADMIN_KEY, ADMIN_VALUE)
    if (not ADMIN_VALUE) then
        GM.Admin.data[ADMIN_DATA] = ADMIN_KEY
    else
        GM.Admin.data[ADMIN_DATA][ADMIN_KEY] = ADMIN_VALUE
    end
end)

RegisterNetEvent("Admin:removeValue", function(ADMIN_DATA, ADMIN_KEY)
    if (not ADMIN_KEY) then
        GM.Admin.data[ADMIN_DATA] = nil
    else
        GM.Admin.data[ADMIN_DATA][ADMIN_KEY] = nil
    end
end)

RegisterNetEvent("Admin:playSound", function(SOUND_NAME)
    if (SOUND_NAME == "new_report") then
        if (GM.Preferences:loadPreferences("admin_sound_reports")) then
            PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
        end
    end
end)