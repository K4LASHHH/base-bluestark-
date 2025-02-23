GM.Ranks = GM.Ranks or {}

GM.Ranks = {
    menu = {
        submenus = {}
    },
    data = {
        ranks = {},
    },
}

GM.Ranks.menu.main = RageUI.CreateMenu("", "Ranks", 0, 0, "banner", "bluestark")
GM.Ranks.menu.main["Closed"] = function()
    -- Todo event when menu closed
end

GM.Ranks.menu.submenus["server_ranks"] = RageUI.CreateSubMenu(GM.Ranks.menu.main, "", "Ranks")
GM.Ranks.menu.submenus["server_ranks_management"] = RageUI.CreateSubMenu(GM.Ranks.menu.submenus["server_ranks"], "", "Ranks management")
GM.Ranks.menu.submenus["server_ranks_management_commands"] = RageUI.CreateSubMenu(GM.Ranks.menu.submenus["server_ranks_management"], "", "Ranks management - Commandes")
GM.Ranks.menu.submenus["server_ranks_management_permissions"] = RageUI.CreateSubMenu(GM.Ranks.menu.submenus["server_ranks_management"], "", "Ranks management - Permissions")
GM.Ranks.menu.submenus["server_ranks_management_players"] = RageUI.CreateSubMenu(GM.Ranks.menu.submenus["server_ranks_management"], "", "Ranks management - Players")
GM.Ranks.menu.submenus["server_ranks_management_players_management"] = RageUI.CreateSubMenu(GM.Ranks.menu.submenus["server_ranks_management_players"], "", "Ranks management - Players - Management")

GM.Ranks.menu.main:isVisible(function(Items)
    Items:Button("Créer un rank", nil, {}, true,{
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Créer un rank",
                submitLabel = "Créer un rank",
                placeHolders = {
                    {label = "NOM"},
                    {label = "LABEL"},
                }
            })
            TriggerServerEvent("Ranks:createRank", input["0"], input["1"])
        end
    })
    Items:Button("Gérer les ranks", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Ranks:requestRanks")
        end
    }, GM.Ranks.menu.submenus["server_ranks"])
end)

GM.Ranks.menu.submenus["server_ranks"]:isVisible(function(Items)
    for rankId,rankValues in pairs(GM.Ranks.data["ranks"]) do
        Items:Button(rankValues.label.." - "..rankValues.name, "ID - "..rankValues.id, {}, true,{
            onSelected = function()
                GM.Ranks.data["selectedRank"] = rankValues.id
            end
        }, GM.Ranks.menu.submenus["server_ranks_management"])
    end
end)

GM.Ranks.menu.submenus["server_ranks_management"]:isVisible(function(Items)
    if (GM.Ranks.data["selectedRank"] ~= nil and GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]] ~= nil) then
        Items:Button("~b~"..GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].name.." - ID : "..GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].id, nil, {}, true,{})
        Items:Button("Gérer les joueurs", nil, {}, (GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].name ~= "user"),{}, GM.Ranks.menu.submenus["server_ranks_management_players"])
        Items:Button("Gérer les commandes", nil, {}, GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].name ~= "founder",{}, GM.Ranks.menu.submenus["server_ranks_management_commands"])
        Items:Button("Gérer les permissions", nil, {}, GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].name ~= "founder",{}, GM.Ranks.menu.submenus["server_ranks_management_permissions"])
        Items:Button("~r~Supprimer le rank", nil, {}, GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].name ~= "user" and GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].name ~= "founder",{
            onSelected = function()
                local input = exports["input"]:openInput({
                    label = "Supprimer un rank",
                    submitLabel = "SUPPRIMER",
                    placeHolders = {
                        {label = "CONFIRMER OUI / NON"},
                    }
                })
                if (input["0"] == "oui" or input["0"] == "OUI") then
                    TriggerServerEvent("Ranks:deleteRank", GM.Ranks.data["selectedRank"], input["0"])
                end
            end
        })
    end
end)

GM.Ranks.menu.submenus["server_ranks_management_players"]:isVisible(function(Items)
    Items:Button("Recruter un joueur", nil, {}, true,{
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Recruter un joueur",
                submitLabel = "CONFIRMER",
                placeHolders = {
                    {label = "ID / LICENSE"},
                }
            })
            TriggerServerEvent("Ranks:recruitPlayerRank", GM.Ranks.data["selectedRank"], input["0"])
        end
    })
    if (GM.Ranks.data["selectedRank"] ~= nil and GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]] ~= nil) then
        for playerIdentifier, playerValues in pairs(GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]]["players"]) do
            Items:Button(playerValues.name, "Reports - "..playerValues.reports.."\nDate d'arrivée - "..playerValues.arrival_date, {}, true,{
                onSelected = function()
                    GM.Ranks.data["selectedPlayer"] = playerIdentifier
                end
            }, GM.Ranks.menu.submenus["server_ranks_management_players_management"])
        end
    end
end)

GM.Ranks.menu.submenus["server_ranks_management_commands"]:isVisible(function(Items)
    if (GM.Ranks.data["selectedRank"] ~= nil and GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]] ~= nil) then
        for commandName, commandValues in pairs(GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]]["commands"]) do
            Items:Checkbox(commandValues.label, commandValues.description, commandValues.value, {}, {
                onSelected = function(Checked)
                    commandValues.value = Checked
                end,
                onChecked = function()
                    TriggerServerEvent("Ranks:updateRankCommands", GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].id, commandName, true)
                end,
                onUnChecked = function()
                    TriggerServerEvent("Ranks:updateRankCommands", GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].id, commandName, false)
                end,
            })
        end
    end
end)

GM.Ranks.menu.submenus["server_ranks_management_permissions"]:isVisible(function(Items)
    if (GM.Ranks.data["selectedRank"] ~= nil and GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]] ~= nil) then
        for permissionName, permissionValues in pairs(GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]]["permissions"]) do
            Items:Checkbox(permissionValues.label, permissionValues.description, permissionValues.value, {}, {
                onSelected = function(Checked)
                    permissionValues.value = Checked
                end,
                onChecked = function()
                    TriggerServerEvent("Ranks:updateRankPermissions", GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].id, permissionName, true)
                end,
                onUnChecked = function()
                    TriggerServerEvent("Ranks:updateRankPermissions", GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].id, permissionName, false)
                end,
            })
        end
    end
end)

GM.Ranks.menu.submenus["server_ranks_management_players_management"]:isVisible(function(Items)
    if (GM.Ranks.data["selectedRank"] ~= nil and GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]] ~= nil and GM.Ranks.data["selectedPlayer"] ~= nil and GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]]["players"][GM.Ranks.data["selectedPlayer"]] ~= nil) then
        Items:Button("~b~"..GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]]["players"][GM.Ranks.data["selectedPlayer"]].name, nil, {}, true,{})
        Items:Button("~r~Kick le joueur", nil, {}, true,{
            onSelected = function()
                TriggerServerEvent("Ranks:kickPlayerRank", GM.Ranks.data["ranks"][GM.Ranks.data["selectedRank"]].id, GM.Ranks.data["selectedPlayer"])
            end
        })
    end
end)

RegisterNetEvent("Ranks:updateValue", function(RANKS_DATA, RANKS_KEY, RANKS_VALUE)
    if (not RANKS_VALUE) then
        GM.Ranks.data[RANKS_DATA] = RANKS_KEY
    else
        GM.Ranks.data[RANKS_DATA][RANKS_KEY] = RANKS_VALUE
    end
end)

RegisterNetEvent("Ranks:removeValue", function(RANKS_DATA, RANKS_KEY)
    if (not RANKS_KEY) then
        GM.Ranks.data[RANKS_DATA] = nil
    else
        GM.Ranks.data[RANKS_DATA][RANKS_KEY] = nil
    end
end)

RegisterNetEvent("Ranks:openMenu", function()
    GM.Ranks.menu.main:toggle()
end)