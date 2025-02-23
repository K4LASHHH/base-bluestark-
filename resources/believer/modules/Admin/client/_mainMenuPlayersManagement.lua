GM.Admin = GM.Admin or {}

GM.Admin.menu.submenus["players"] = RageUI.CreateSubMenu(GM.Admin.menu.main, "", "Liste des joueurs")

GM.Admin.menu.submenus["players_management"] = RageUI.CreateSubMenu(GM.Admin.menu.submenus["players"], "", "Détails du joueur")

GM.Admin.menu.submenus["players_management_informations"] = RageUI.CreateSubMenu(GM.Admin.menu.submenus["players_management"], "", "Informations du joueur")

GM.Admin.menu.submenus["players_management_sanctions"] = RageUI.CreateSubMenu(GM.Admin.menu.submenus["players_management"], "", "Historique des sanctions")

GM.Admin.menu.submenus["players_management_vehicles"] = RageUI.CreateSubMenu(GM.Admin.menu.submenus["players_management"], "", "Véhicules du joueur")

GM.Admin.menu.submenus["players"]:isVisible(function(Items)
    Items:Button("Filtre", nil, {RightLabel = GM.Admin.data["filterValue"] or "Aucun"}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Rechercher",
                submitLabel = "CONFIRMER",
                placeHolders = {
                    {label = "ID / UNIQUE ID / NOM / RANK"},
                }
            })
            if (not input["0"]) then
                GM.Admin.data["filterValue"] = "Aucun"
            end
            GM.Admin.data["filterValue"] = input["0"]
        end
    })
    for playerSrc, playersValues in pairs(GM.Admin.data["players"]) do
        if (playersValues.invisible == false) then
            if GM.Admin.data["filterValue"] == nil or GM.Admin.data["filterValue"] == "Aucun" or string.find(playersValues.id, GM.Admin.data["filterValue"]) or string.find(playersValues.name, GM.Admin.data["filterValue"]) or string.find(playersValues.rank, GM.Admin.data["filterValue"]) or string.find(playersValues.uniqueId, GM.Admin.data["filterValue"]) then
                Items:Button(playersValues.name, nil, { RightLabel = playersValues.id}, GM.Admin.inAdmin, {
                    onSelected = function()
                        GM.Admin.data["selectedPlayer"] = playersValues.id
                    end
                }, GM.Admin.menu.submenus["players_management"])
            end
        end
    end
end)

GM.Admin.menu.submenus["players_management"]:isVisible(function(Items)
    Items:Button("Spectate", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            TriggerServerEvent("Admin:spectatePlayer", GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("Goto", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("goto "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("Bring", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("bring "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("Bring back", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("bringBack "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("Message", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Message",
                submitLabel = "ENVOYER",
                placeHolders = {
                    {label = "Message"},
                }
            })
            if (not input["0"]) then return end
            ExecuteCommand("msg "..GM.Admin.data["selectedPlayer"].." "..input["0"])
        end
    })
    Items:Button("Informations", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            TriggerServerEvent("Admin:getInformationsPlayer", GM.Admin.data["selectedPlayer"])
        end
    }, GM.Admin.menu.submenus["players_management_informations"])
    Items:Button("Liste des véhicules", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            TriggerServerEvent("Admin:getVehiclesPlayer", GM.Admin.data["selectedPlayer"])
        end
    }, GM.Admin.menu.submenus["players_management_vehicles"])
    Items:Button("Inventaire", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
        end
    })
    Items:Button("~y~Kick", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Kick",
                submitLabel = "KICK",
                placeHolders = {
                    {label = "Raison"},
                }
            })
            if (not input["0"]) then return end
            ExecuteCommand("kick "..GM.Admin.data["selectedPlayer"].." "..input["0"])
        end
    })
    Items:Button("~y~Envoyer dans l'instance trolleurs", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Envoyer dans l'instance trolleurs",
                submitLabel = "ENVOYER",
                placeHolders = {
                    {label = "Temps (minutes)"},
                    {label = "Raison"}
                }
            })
            if (not input["0"] and not input["1"]) then return end
            ExecuteCommand("jail "..GM.Admin.data["selectedPlayer"].." "..input["0"].." "..input["1"])
        end
    })
    Items:Button("~y~Retirer de l'instance trolleurs", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("unjail "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("~y~Avertissement", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Avertissement",
                submitLabel = "ENVOYER",
                placeHolders = {
                    {label = "Raison"},
                }
            })
            if (not input["0"]) then return end

            TriggerServerEvent("Admin:setWarningPlayer", GM.Admin.data["selectedPlayer"], input["0"])
        end
    })
    Items:Button("~r~Ban", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Ban",
                submitLabel = "CONFIRMER",
                placeHolders = {
                    {label = "Temps (0 pour perm)"},
                    {label = "Raison"},
                }
            })
            if (not input["0"]) then return end
            ExecuteCommand("ban "..GM.Admin.data["selectedPlayer"].." "..tonumber(input["0"]).." "..input["1"])
        end
    })
    Items:Button("Historique des sanctions", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            TriggerServerEvent("Admin:requestSanctionsPlayer", GM.Admin.data["selectedPlayer"])
        end
    }, GM.Admin.menu.submenus["players_management_sanctions"])
    Items:Button("Freeze", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("freeze "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("Unfreeze", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("unfreeze "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("Heal", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
        end
    })
    Items:Button("Revive", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("revive "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("Screenshot", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            ExecuteCommand("screenshot "..GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("~r~Reset identité", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            TriggerServerEvent("Admin:resetIdentityPlayer", GM.Admin.data["selectedPlayer"])
        end
    })
    Items:Button("~r~Wipe", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
        end
    })
    Items:Button("Tuer la personne", nil, {}, GM.Admin.inAdmin, {
        onSelected = function()
            TriggerServerEvent("Admin:killPlayer", GM.Admin.data["selectedPlayer"])
        end
    })
end)

GM.Admin.menu.submenus["players_management_informations"]:isVisible(function(Items)
    if (GM.Admin.data["informations"] ~= nil and json.encode(GM.Admin.data["informations"]) ~= "[]") then
        Items:Button("Nom", nil, {RightLabel = GM.Admin.data["informations"].name}, GM.Admin.inAdmin, {})
        Items:Button("Id unique", nil, {RightLabel = GM.Admin.data["informations"].uniqueId}, GM.Admin.inAdmin, {})
        Items:Button("Job", nil, {RightLabel = GM.Admin.data["informations"].job}, GM.Admin.inAdmin, {})
        Items:Button("Argent", nil, {RightLabel = "~g~"..GM.Admin.data["informations"].money.." $"}, GM.Admin.inAdmin, {})
        Items:Button("Banque", nil, {RightLabel = "~g~"..GM.Admin.data["informations"].bank.." $"}, GM.Admin.inAdmin, {})
        Items:Button("Sale", nil, {RightLabel = "~g~"..GM.Admin.data["informations"].dirty.." $"}, GM.Admin.inAdmin, {})
        Items:Button("Première connexion", nil, {RightLabel = GM.Admin.data["informations"].first_connection}, GM.Admin.inAdmin, {})
        Items:Button("Temps de jeu", nil, {RightLabel = GM.Admin.data["informations"].time_play}, GM.Admin.inAdmin, {})
    end
end)

GM.Admin.menu.submenus["players_management_sanctions"]:isVisible(function(Items)
    if (GM.Admin.data["sanctions"] ~= nil and json.encode(GM.Admin.data["sanctions"]) ~= "[]") then 
        for k, v in pairs(GM.Admin.data["sanctions"]) do
            Items:Button(v.type.." : "..v.data["reason"], v.data["date"].." | "..v.data["reason"], {RightLabel = v.data["admin"]}, true, {})
        end
    end
end)

GM.Admin.menu.submenus["players_management_vehicles"]:isVisible(function(Items)
    if (GM.Admin.data["vehicles"] ~= nil and json.encode(GM.Admin.data["vehicles"]) ~= "[]") then 
        for k, v in pairs(GM.Admin.data["vehicles"]) do
            if (v.stored == 0) then
                vehicleStored = "Sortie"
            elseif (v.stored == 1) then
                vehicleStored = "Garage"
            end
            Items:Button(GetDisplayNameFromVehicleModel((v.model)).." - "..v.plate, "Appuyez sur ~b~entrée~s~ pour mettre le véhicule en fourrière", {RightLabel = vehicleStored}, true, {
                onSelected = function()
                    if (v.stored == 0) then
                        TriggerServerEvent("Admin:impoundVehicle", v.plate)
                    end
                end
            })
        end
    end
end)

RegisterNetEvent("Admin:killPlayer", function()
    SetEntityHealth(PlayerPedId(), 0)
end)