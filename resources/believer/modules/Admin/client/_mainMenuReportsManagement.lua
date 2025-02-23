GM.Admin = GM.Admin or {}

GM.Admin.menu.submenus["report"] = RageUI.CreateSubMenu(GM.Admin.menu.main, "", "Reports")
GM.Admin.menu.submenus["report_management"] = RageUI.CreateSubMenu(GM.Admin.menu.submenus["report"], "", "Détails du report")

GM.Admin.menu.submenus["report"]:isVisible(function(Items)
    for reportId, reportValues in pairs(GM.Admin.data["reports"]) do
        if (reportValues.taken == false) then
            Items:Button("("..reportValues.source..") "..reportValues.name, reportValues.reason, {RightLabel = reportValues.creation_date}, true,{
                onSelected = function()
                    GM.Admin.data["selectedReport"] = reportId
                end
            }, GM.Admin.menu.submenus["report_management"])
        else
            Items:Button("~y~("..reportValues.source..") "..reportValues.name, reportValues.reason.."\nPris par : "..reportValues.taken_name, {RightLabel = reportValues.creation_date}, true,{
                onSelected = function()
                    GM.Admin.data["selectedReport"] = reportId
                end
            }, GM.Admin.menu.submenus["report_management"])
        end
    end
end)

GM.Admin.menu.submenus["report_management"]:isVisible(function(Items)
    if (GM.Admin.data["selectedReport"] ~= nil and GM.Admin.data["reports"][GM.Admin.data["selectedReport"]] ~= nil) then
        Items:Button("S'occuper de ce report", nil, {}, not GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                TriggerServerEvent("Admin:takeReport", GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].id)
            end
        })
        Items:Button("Goto", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Bring", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Bring back", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Revive", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Heal", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Envoyer un message au joueur", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Spectate", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Informations", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Liste des véhicules", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Voir véhicules du joueur", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Inventaire", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Screenshot", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Tuer la personne", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                -- Todo event this
            end
        })
        Items:Button("Supprimer ce report", nil, {}, GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].taken,{
            onSelected = function()
                TriggerServerEvent("Admin:closeReport", GM.Admin.data["reports"][GM.Admin.data["selectedReport"]].id)
            end
        })
    end
end)