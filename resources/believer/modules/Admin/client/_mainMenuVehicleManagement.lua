GM.Admin = GM.Admin or {}

GM.Admin.menu.submenus["vehicles"] = RageUI.CreateSubMenu(GM.Admin.menu.main, "", "Véhicules")

GM.Admin.menu.submenus["vehicles"]:isVisible(function(Items)
    Items:Button("Spawn un véhicule", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Spawn un véhicule",
                submitLabel = "SPAWN",
                placeHolders = {
                    {label = "MODEL"},
                }
            })
            ExecuteCommand("car "..input["0"])
        end
    })
    Items:Button("Réparer le véhicule", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local vehicle = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()), false)
            if (vehicle ~= nil) then
                TriggerServerEvent("Admin:repairVehicle", NetworkGetNetworkIdFromEntity(vehicle))
            end
        end
    })
    Items:Button("Réparer les véhicule (zone)", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Réparer les véhicules",
                submitLabel = "RÉPARER",
                placeHolders = {
                    {label = "Radius"},
                }
            })

            if (input["0"] == nil) then
                ESX.ShowNotification("~r~Merci de renseigner un radius.")
                return
            end

            TriggerServerEvent("Admin:repairVehicleZones", input["0"])
        end
    })
    Items:Button("Essence maximum", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
    Items:Button("Performances maximum", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
    Items:Button("Blindage maximum", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
    Items:Button("Nettoyer le véhicule", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
    Items:Button("Retourner le véhicule", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
    Items:Button("Supprimer les véhicules", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
    Items:Button("Recherche propriétaire véhicule", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
    Items:Button("Supprimer les véhicules proches (5m)", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            -- Todo event this button
        end
    })
end)

RegisterNetEvent("Admin:repairVehicle", function(vehicleId)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleId)
    if (vehicle ~= nil) then
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0.0)
    end
end)