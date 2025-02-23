GM.Admin = GM.Admin or {}

GM.Admin.menu.submenus["around_me"] = RageUI.CreateSubMenu(GM.Admin.menu.main, "", "Autour de moi")

GM.Admin.menu.submenus["around_me"]:isVisible(function(Items)
    Items:Button("Supprimer les véhicules", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Supprimer les véhicules",
                submitLabel = "SUPPRIMER",
                placeHolders = {
                    {label = "RADIUS"},
                }
            })

            TriggerServerEvent("Admin:deleteVehicles", input["0"])
        end
    })
    Items:Button("Supprimer les PNJs", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Supprimer les PNJs",
                submitLabel = "SUPPRIMER",
                placeHolders = {
                    {label = "RADIUS"},
                }
            })

            TriggerServerEvent("Admin:deletePnjs", input["0"])
        end
    })
    Items:Button("Supprimer les props", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Supprimer les props",
                submitLabel = "SUPPRIMER",
                placeHolders = {
                    {label = "RADIUS"},
                }
            })

            TriggerServerEvent("Admin:deleteObjects", input["0"])
        end
    })
    Items:Button("Revive zone", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Revive zone",
                submitLabel = "RÉANIMER",
                placeHolders = {
                    {label = "RADIUS"},
                }
            })

            TriggerServerEvent("Admin:reviveZone", input["0"])
        end
    })
    Items:Button("Heal zone", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Heal zone",
                submitLabel = "HEAL",
                placeHolders = {
                    {label = "RADIUS"},
                }
            })

            TriggerServerEvent("Admin:healZone", input["0"])
        end
    })
    -- Items:Button("Give arme event", nil, {}, GM.Admin.inAdmin, {
    --     onSelected = function()
    --     end
    -- })
    -- Items:Button("Supprimer arme event", nil, {}, GM.Admin.inAdmin, {
    --     onSelected = function()
    --     end
    -- })
end)