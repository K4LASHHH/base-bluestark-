GM.Ambulance.data = {}

GM.Ambulance.garage = {
    menu = {
        submenus = {}
    },
    data = {
        call = {},
    },
}

GM.Ambulance.garage.menu.main = RageUI.CreateMenu("", "Garage Ambulance", 0, 0, "banner", "bluestark")
GM.Ambulance.garage.menu.main["Closed"] = function()
end

GM.Ambulance.garage.menu.submenus["players_vehicles"] = RageUI.CreateSubMenu(GM.Ambulance.garage.menu.main, "", "Véhicules personnels")

GM.Ambulance.garage.menu.submenus["unmark_vehicles"] = RageUI.CreateSubMenu(GM.Ambulance.garage.menu.main, "", "Véhicules banalisées")

GM.Ambulance.garage.menu.main:isVisible(function(Items)
    Items:Button("Véhicules personnels", nil, {}, true,{
        onSelected = function()
            -- Todo event for request player vehicle like garage
        end
    }, GM.Ambulance.garage.menu.submenus["players_vehicles"])
    Items:Button("Banalisées", nil, {}, true, {}, GM.Ambulance.garage.menu.submenus["unmark_vehicles"])
    if (GM.Ambulance.data["garageVehicle"] ~= nil and GM.Ambulance.data["garageVehicle"]["all"]) then
        for i = 1, #GM.Ambulance.data["garageVehicle"]["all"] do
            Items:Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(GM.Ambulance.data["garageVehicle"]["all"][i]))), nil, {}, true, {
                onSelected = function()
                    local vehicleName = GM.Ambulance.data["garageVehicle"]["all"][i]
                    if (vehicleName ~= nil) then
                        if (GM.Ambulance.data["garagePosition"] ~= nil) then
                            local foundPosition = false
                            for i = 1, #GM.Ambulance.data["garagePosition"] do
                                if (not foundPosition) then
                                    if (ESX.Game.IsSpawnPointClear(GM.Ambulance.data["garagePosition"][i], 3.0)) then
                                        foundPosition = true
                                        TriggerServerEvent("Ambulance:spawnVehicle", vehicleName, GM.Ambulance.data["garagePosition"][i])
                                        GM.Ambulance.garage.menu.main:close()
                                    end
                                end
                            end
                            if (not foundPosition) then
                                ESX.ShowNotification("~r~Aucun emplacement disponible pour sortir le véhicule !")
                            end
                        end
                    end
                end
            })
        end
    end
end)

GM.Ambulance.garage.menu.submenus["players_vehicles"]:isVisible(function(Items)
    if (GM.Ambulance.data["playerVehicles"] ~= nil) then
    end
end)

GM.Ambulance.garage.menu.submenus["unmark_vehicles"]:isVisible(function(Items)
    if (GM.Ambulance.data["garageVehicle"] ~= nil and GM.Ambulance.data["garageVehicle"]["unmarked"]) then
        for i = 1, #GM.Ambulance.data["garageVehicle"]["unmarked"] do
            Items:Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(GM.Ambulance.data["garageVehicle"]["unmarked"][i]))), nil, {}, true, {
                onSelected = function()
                    local vehicleName = GM.Ambulance.data["garageVehicle"]["unmarked"][i]
                    if (vehicleName ~= nil) then
                        if (GM.Ambulance.data["garagePosition"] ~= nil) then
                            local foundPosition = false
                            for i = 1, #GM.Ambulance.data["garagePosition"] do
                                if (not foundPosition) then
                                    if (ESX.Game.IsSpawnPointClear(GM.Ambulance.data["garagePosition"][i], 3.0)) then
                                        foundPosition = true
                                        TriggerServerEvent("Ambulance:spawnVehicle", vehicleName, GM.Ambulance.data["garagePosition"][i])
                                        GM.Ambulance.garage.menu.main:close()
                                    end
                                end
                            end
                            if (not foundPosition) then
                                ESX.ShowNotification("~r~Aucun emplacement disponible pour sortir le véhicule !")
                            end
                        end
                    end
                end
            })
        end
    end
end)

RegisterNetEvent("Ambulance:openGarage", function(garageData)
    GM.Ambulance.data["garageId"] = garageData.garageId

    GM.Ambulance.data["garageVehicle"] = garageData.garageVehicle

    GM.Ambulance.data["garagePosition"] = garageData.garagePosition

    GM.Ambulance.garage.menu.main:toggle()
end)

GM.Ambulance.wardrobe = {
    menu = {
        submenus = {}
    },
}

GM.Ambulance.wardrobe.menu.main = RageUI.CreateMenu("", "Vestiaire Ambulance", 0, 0, "banner", "bluestark")
GM.Ambulance.wardrobe.menu.main["Closed"] = function()
end

GM.Ambulance.wardrobe.menu.main:isVisible(function(Items)
    Items:Button("Retirer ma tenue de service", nil, {}, true,{
        onSelected = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerServerEvent("Service:interact")
            end)
        end
    })
    if (GM.Ambulance.data["outfits"] ~= nil) then
        for i = 1, #GM.Ambulance.data["outfits"] do
            if (ESX.PlayerData.job.grade >= GM.Ambulance.data["outfits"][i].grade) then
                Items:Button(GM.Ambulance.data["outfits"][i].name, nil, {}, true, {
                    onSelected = function()
                        local forEquip
    
                        if (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01")) then
                            forEquip = GM.Ambulance.data["outfits"][i].male
                        elseif (GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")) then
                            forEquip = GM.Ambulance.data["outfits"][i].female
                        else
                            return
                        end
    
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerEvent('skinchanger:loadClothes', skin, forEquip)
                        end)
                    end
                })
            end
        end
    end
end)

RegisterNetEvent("Ambulance:openWardrobe", function(wardrobeData)
    GM.Ambulance.data["outfits"] = wardrobeData.outfits

    GM.Ambulance.wardrobe.menu.main:toggle()
end)

GM.Ambulance.job = {
    menu = {
        submenus = {}
    },
}

GM.Ambulance.job.menu.main = RageUI.CreateMenu("", "Menu métier", 0, 0, "banner", "bluestark")
GM.Ambulance.job.menu.main["Closed"] = function()
end

GM.Ambulance.job.menu.submenus["call"] = RageUI.CreateSubMenu(GM.Ambulance.job.menu.main, "", "Historique des appels")

GM.Ambulance.job.menu.submenus["backup"] = RageUI.CreateSubMenu(GM.Ambulance.job.menu.main, "", "Renforts")

GM.Ambulance.job.menu.submenus["interaction"] = RageUI.CreateSubMenu(GM.Ambulance.job.menu.main, "", "Interaction")

GM.Ambulance.job.menu.main:isVisible(function(Items)
    Items:Button("Historique des appels", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Ambulance:menu:requestCalls")
        end
    }, GM.Ambulance.job.menu.submenus["call"])
    Items:Button("Réanimer", nil, {}, true, {
        onSelected = function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer(GetEntityCoords(PlayerPedId()))
            if (closestPlayer == -1 or closestDistance > 3.0) then
                return ESX.ShowNotification("~r~Aucun joueur à proximité.")
            else
                TriggerServerEvent("Ambulance:revivePlayer", GetPlayerServerId(closestPlayer))
            end
        end
    })
    Items:Button("Interaction citoyen", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Ambulance:menu:requestCalls")
        end
    }, GM.Ambulance.job.menu.submenus["interaction"])
    Items:Button("Renforts", nil, {}, true,{}, GM.Ambulance.job.menu.submenus["backup"])
end)

GM.Ambulance.job.menu.submenus["interaction"]:isVisible(function(Items)
    Items:Button("Mettre une amende", nil, {}, true, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Mettre une amende",
                submitLabel = "VALIDER",
                placeHolders = {
                    {label = "RAISON"},
                    {label = "MONTANT"},
                }
            })
            if (input["0"] ~= nil) then
                TriggerServerEvent("Ambulance:menu:interaction:amende", input["0"], input["1"])
            end
        end
    })
end)

GM.Ambulance.job.menu.submenus["backup"]:isVisible(function(Items)
    if (GM.Ambulance.Menu.backup ~= nil) then
        for i = 1, #GM.Ambulance.Menu.backup do
            if (ESX.PlayerData.job.grade >= GM.Ambulance.Menu.backup[i].grade) then
                Items:Button(GM.Ambulance.Menu.backup[i].label, nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("Ambulance:menu:backup", GM.Ambulance.Menu.backup[i].name)
                    end
                })
            end
        end
    end
end)

GM.Ambulance.job.menu.submenus["call"]:isVisible(function(Items)
    Items:Button("Supprimer le point GPS", nil, {}, true, {
        onSelected = function()
            if (GM.Ambulance.call.data["callId"] == nil) then
                ESX.ShowNotification("~r~Vous n'avez pas d'appel d'urgence en cours.")
                return
            end
            TriggerServerEvent("Ambulance:menu:cancelCall")
        end
    })
    if (GM.Ambulance.data["call"] ~= nil) then
        for i = 1, #GM.Ambulance.data["call"] do
            local dist = math.floor(#(GetEntityCoords(PlayerPedId()) - GM.Ambulance.data["call"][i].position))
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(GM.Ambulance.data["call"][i].position.x, GM.Ambulance.data["call"][i].position.y, GM.Ambulance.data["call"][i].position.z)).." ("..math.ceil(dist).."m)"
        
            Items:Button("Appel d'urgence - "..GM.Ambulance.data["call"][i].id, GM.Ambulance.data["call"][i].message.."\nLocalisation : "..streetName, {RightLabel = GM.Ambulance.data["call"][i].time}, true, {
                onSelected = function()
                    TriggerServerEvent("Ambulance:call:accept", GM.Ambulance.data["call"][i].id)
                end
            })
        end
    end
end)

RegisterNetEvent("Ambulance:openMenu", function()
    GM.Ambulance.job.menu.main:toggle()
end)

GM.Ambulance.call = {
    data = {}
}

RegisterNetEvent("Ambulance:call:onAccept", function(callData)
    if (callData == nil) then return end

    GM.Ambulance.call.data = callData

    while GM.Ambulance.call.data["onActive"] do
        local dist = #(GetEntityCoords(PlayerPedId()) - GM.Ambulance.call.data["position"])
        local size = IsPedSittingInAnyVehicle(PlayerPedId()) and 50.0 or 25.0

        ESX.ShowDrawNotification("~b~Vous êtes à ("..math.ceil(dist).."m) de l'appel.", 1000)

        if dist < size then
            ESX.ShowNotification("~g~Vous êtes arrivé à destination.")
            TriggerServerEvent("Ambulance:call:finish", GM.Ambulance.call.data["callId"])
            break
        end
        Wait(50)
    end
end)

RegisterNetEvent("Ambulance:updateValue", function(AMBULANCE_DATA, AMBULANCE_KEY, AMBULANCE_VALUE)
    if (not AMBULANCE_VALUE) then
        GM.Ambulance.data[AMBULANCE_DATA] = AMBULANCE_KEY
    else
        GM.Ambulance.data[AMBULANCE_DATA][AMBULANCE_KEY] = AMBULANCE_VALUE
    end
end)

RegisterNetEvent("Ambulance:removeValue", function(AMBULANCE_DATA, AMBULANCE_KEY)
    if (not AMBULANCE_KEY) then
        GM.Ambulance.data[AMBULANCE_DATA] = nil
    else
        if (GM.Ambulance.data[AMBULANCE_DATA] == nil) then return end

        if (GM.Ambulance.data[AMBULANCE_DATA][AMBULANCE_KEY] == nil) then return end

        GM.Ambulance.data[AMBULANCE_DATA][AMBULANCE_KEY] = nil
    end
end)