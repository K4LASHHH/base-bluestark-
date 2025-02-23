GM.Police.data = {}

GM.Police.garage = {
    menu = {
        submenus = {}
    },
    data = {
        call = {},
    },
}

GM.Police.garage.menu.main = RageUI.CreateMenu("", "Garage Police", 0, 0, "banner", "bluestark")
GM.Police.garage.menu.main["Closed"] = function()
end

GM.Police.garage.menu.submenus["players_vehicles"] = RageUI.CreateSubMenu(GM.Police.garage.menu.main, "", "Véhicules personnels")

GM.Police.garage.menu.submenus["unmark_vehicles"] = RageUI.CreateSubMenu(GM.Police.garage.menu.main, "", "Véhicules banalisées")

GM.Police.garage.menu.main:isVisible(function(Items)
    Items:Button("Véhicules personnels", nil, {}, true,{
        onSelected = function()
            -- Todo event for request player vehicle like garage
        end
    }, GM.Police.garage.menu.submenus["players_vehicles"])
    Items:Button("Banalisées", nil, {}, true, {}, GM.Police.garage.menu.submenus["unmark_vehicles"])
    if (GM.Police.data["garageVehicle"] ~= nil and GM.Police.data["garageVehicle"]["all"]) then
        for i = 1, #GM.Police.data["garageVehicle"]["all"] do
            Items:Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(GM.Police.data["garageVehicle"]["all"][i]))), nil, {}, true, {
                onSelected = function()
                    local vehicleName = GM.Police.data["garageVehicle"]["all"][i]
                    if (vehicleName ~= nil) then
                        if (GM.Police.data["garagePosition"] ~= nil) then
                            local foundPosition = false
                            for i = 1, #GM.Police.data["garagePosition"] do
                                if (not foundPosition) then
                                    if (ESX.Game.IsSpawnPointClear(GM.Police.data["garagePosition"][i], 3.0)) then
                                        foundPosition = true
                                        TriggerServerEvent("Police:spawnVehicle", vehicleName, GM.Police.data["garagePosition"][i])
                                        GM.Police.garage.menu.main:close()
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

GM.Police.garage.menu.submenus["players_vehicles"]:isVisible(function(Items)
    if (GM.Police.data["playerVehicles"] ~= nil) then
    end
end)

GM.Police.garage.menu.submenus["unmark_vehicles"]:isVisible(function(Items)
    if (GM.Police.data["garageVehicle"] ~= nil and GM.Police.data["garageVehicle"]["unmarked"]) then
        for i = 1, #GM.Police.data["garageVehicle"]["unmarked"] do
            Items:Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(GM.Police.data["garageVehicle"]["unmarked"][i]))), nil, {}, true, {
                onSelected = function()
                    local vehicleName = GM.Police.data["garageVehicle"]["unmarked"][i]
                    if (vehicleName ~= nil) then
                        if (GM.Police.data["garagePosition"] ~= nil) then
                            local foundPosition = false
                            for i = 1, #GM.Police.data["garagePosition"] do
                                if (not foundPosition) then
                                    if (ESX.Game.IsSpawnPointClear(GM.Police.data["garagePosition"][i], 3.0)) then
                                        foundPosition = true
                                        TriggerServerEvent("Police:spawnVehicle", vehicleName, GM.Police.data["garagePosition"][i])
                                        GM.Police.garage.menu.main:close()
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

RegisterNetEvent("Police:openGarage", function(garageData)
    GM.Police.data["garageId"] = garageData.garageId

    GM.Police.data["garageVehicle"] = garageData.garageVehicle

    GM.Police.data["garagePosition"] = garageData.garagePosition

    GM.Police.garage.menu.main:toggle()
end)

GM.Police.wardrobe = {
    menu = {
        submenus = {}
    },
}

GM.Police.wardrobe.menu.main = RageUI.CreateMenu("", "Vestiaire police", 0, 0, "banner", "bluestark")
GM.Police.wardrobe.menu.main["Closed"] = function()
end

GM.Police.wardrobe.menu.main:isVisible(function(Items)
    Items:Button("Retirer ma tenue de service", nil, {}, true,{
        onSelected = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerServerEvent("Service:interact")
            end)
        end
    })
    if (GM.Police.data["outfits"] ~= nil) then
        for i = 1, #GM.Police.data["outfits"] do
            if (ESX.PlayerData.job.grade >= GM.Police.data["outfits"][i].grade) then
                Items:Button(GM.Police.data["outfits"][i].name, nil, {}, true, {
                    onSelected = function()
                        local forEquip
    
                        if (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01")) then
                            forEquip = GM.Police.data["outfits"][i].male
                        elseif (GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")) then
                            forEquip = GM.Police.data["outfits"][i].female
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

RegisterNetEvent("Police:openWardrobe", function(wardrobeData)
    GM.Police.data["outfits"] = wardrobeData.outfits

    GM.Police.wardrobe.menu.main:toggle()
end)

GM.Police.armory = {
    menu = {
        submenus = {}
    },
}

GM.Police.armory.menu.main = RageUI.CreateMenu("", "Armurerie police", 0, 0, "banner", "bluestark")
GM.Police.armory.menu.main["Closed"] = function()
end

GM.Police.armory.menu.main:isVisible(function(Items)
    Items:Button("~r~Rendre mon équipement", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Police:armory:giveBackItems")
        end
    })
    Items:Button("~r~Rendre mes munitions", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Police:armory:giveBackMunitions")
        end
    })
    if (GM.Police.data["items"] ~= nil) then
        for i = 1, #GM.Police.data["items"] do
            if (ESX.PlayerData.job.grade >= GM.Police.data["items"][i].grade) then
                Items:Button(GM.Police.data["items"][i].label, nil, {RightLabel = GM.Police.data["items"][i].price or ""}, true, {
                    onSelected = function()
                        TriggerServerEvent("Police:armory:takeItem", GM.Police.data["armoryId"], GM.Police.data["items"][i].name)
                    end
                })
            end
        end
    end
end)

RegisterNetEvent("Police:openArmory", function(armoryData)
    GM.Police.data["armoryId"] = armoryData.armoryId
    GM.Police.data["items"] = armoryData.items
    

    GM.Police.armory.menu.main:toggle()
end)

GM.Police.job = {
    menu = {
        submenus = {}
    },
}

GM.Police.job.menu.main = RageUI.CreateMenu("", "Menu métier", 0, 0, "banner", "bluestark")
GM.Police.job.menu.main["Closed"] = function()
end

GM.Police.job.menu.submenus["call"] = RageUI.CreateSubMenu(GM.Police.job.menu.main, "", "Historique des appels")

GM.Police.job.menu.submenus["status"] = RageUI.CreateSubMenu(GM.Police.job.menu.main, "", "Status")

GM.Police.job.menu.submenus["backup"] = RageUI.CreateSubMenu(GM.Police.job.menu.main, "", "Renforts")

GM.Police.job.menu.submenus["interaction"] = RageUI.CreateSubMenu(GM.Police.job.menu.main, "", "Interaction")

GM.Police.job.menu.main:isVisible(function(Items)
    Items:Button("Historique des appels", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Police:menu:requestCalls")
        end
    }, GM.Police.job.menu.submenus["call"])
    Items:Button("Status agent", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Police:menu:requestCalls")
        end
    }, GM.Police.job.menu.submenus["status"])
    Items:Button("Objets", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Police:menu:requestCalls")
        end
    })
    Items:Button("Recherche plaque", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Police:menu:requestCalls")
        end
    })
    Items:Button("Interaction citoyen", nil, {}, true,{
        onSelected = function()
            TriggerServerEvent("Police:menu:requestCalls")
        end
    }, GM.Police.job.menu.submenus["interaction"])
    Items:Button("~r~Démissionner", nil, {}, true,{
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Démissionner",
                submitLabel = "VALIDER",
                placeHolders = {
                    {label = "CONFIRMER OUI / NON"},
                }
            })
            if (input["0"] == "oui" or input["0"] == "OUI") then
                TriggerServerEvent("Police:menu:quitJob")
            end
        end
    })
    Items:Button("Renforts", nil, {}, true,{}, GM.Police.job.menu.submenus["backup"])
end)

GM.Police.job.menu.submenus["status"]:isVisible(function(Items)
    if (GM.Police.Menu.status ~= nil) then
        for i = 1, #GM.Police.Menu.status do
            if (ESX.PlayerData.job.grade >= GM.Police.Menu.status[i].grade) then
                Items:Button(GM.Police.Menu.status[i].label, nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("Police:menu:status", GM.Police.Menu.status[i].name)
                    end
                })
            end
        end
    end
end)

GM.Police.job.menu.submenus["interaction"]:isVisible(function(Items)
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
                TriggerServerEvent("Police:menu:interaction:amende", input["0"], input["1"])
            end
        end
    })
end)

GM.Police.job.menu.submenus["backup"]:isVisible(function(Items)
    if (GM.Police.Menu.backup ~= nil) then
        for i = 1, #GM.Police.Menu.backup do
            if (ESX.PlayerData.job.grade >= GM.Police.Menu.backup[i].grade) then
                Items:Button(GM.Police.Menu.backup[i].label, nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("Police:menu:backup", GM.Police.Menu.backup[i].name)
                    end
                })
            end
        end
    end
end)

GM.Police.job.menu.submenus["call"]:isVisible(function(Items)
    Items:Button("Supprimer le point GPS", nil, {}, true, {
        onSelected = function()
            if (GM.Police.call.data["callId"] == nil) then
                ESX.ShowNotification("~r~Vous n'avez pas d'appel d'urgence en cours.")
                return
            end
            TriggerServerEvent("Police:menu:cancelCall")
        end
    })
    if (GM.Police.data["call"] ~= nil) then
        for i = 1, #GM.Police.data["call"] do
            local dist = math.floor(#(GetEntityCoords(PlayerPedId()) - GM.Police.data["call"][i].position))
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(GM.Police.data["call"][i].position.x, GM.Police.data["call"][i].position.y, GM.Police.data["call"][i].position.z)).." ("..math.ceil(dist).."m)"
        
            Items:Button("Appel d'urgence - "..GM.Police.data["call"][i].id, GM.Police.data["call"][i].message.."\nLocalisation : "..streetName, {RightLabel = GM.Police.data["call"][i].time}, true, {
                onSelected = function()
                    TriggerServerEvent("Police:call:accept", GM.Police.data["call"][i].id)
                end
            })
        end
    end
end)

RegisterNetEvent("Police:openMenu", function()
    GM.Police.job.menu.main:toggle()
end)

GM.Police.call = {
    data = {}
}

RegisterNetEvent("Police:call:onAccept", function(callData)
    if (callData == nil) then return end

    GM.Police.call.data = callData

    while GM.Police.call.data["onActive"] do
        local dist = #(GetEntityCoords(PlayerPedId()) - GM.Police.call.data["position"])
        local size = IsPedSittingInAnyVehicle(PlayerPedId()) and 50.0 or 25.0

        ESX.ShowDrawNotification("~b~Vous êtes à ("..math.ceil(dist).."m) de l'appel.", 1000)

        if dist < size then
            ESX.ShowNotification("~g~Vous êtes arrivé à destination.")
            TriggerServerEvent("Police:call:finish", GM.Police.call.data["callId"])
            break
        end
        Wait(50)
    end
end)

RegisterNetEvent("Police:updateValue", function(POLICE_DATA, POLICE_KEY, POLICE_VALUE)
    if (not POLICE_VALUE) then
        GM.Police.data[POLICE_DATA] = POLICE_KEY
    else
        GM.Police.data[POLICE_DATA][POLICE_KEY] = POLICE_VALUE
    end
end)

RegisterNetEvent("Police:removeValue", function(POLICE_DATA, POLICE_KEY)
    if (not POLICE_KEY) then
        GM.Police.data[POLICE_DATA] = nil
    else
        GM.Police.data[POLICE_DATA][POLICE_KEY] = nil
    end
end)

RegisterNetEvent("Police:item:handcuffs", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer(GetEntityCoords(PlayerPedId()))
    if (closestPlayer == -1 or closestDistance > 3.0) then
        return ESX.ShowNotification("~r~Aucune personne à proximité.")
    else
        TriggerServerEvent("Police:item:handcuffs", GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent("Police:item:handcuffs:onUse", function()
    RequestAnimDict('mp_arresting')
    while (not HasAnimDictLoaded('mp_arresting')) do
        Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

    SetEnableHandcuffs(PlayerPedId(), true)
    DisablePlayerFiring(PlayerPedId(), true)
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
    SetPedCanPlayGestureAnims(PlayerPedId(), false)

    local plyCoords = GetEntityCoords(PlayerPedId(), false)
    HandCuffObj = CreateObject(GetHashKey("p_cs_cuffs_02_s"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
    AttachEntityToEntity(HandCuffObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.04, 0.06, 0.02, -90.0, -25.0, 80.0, 1, 0, 0, 0, 0, 1)

    while GM.Police.data["handcuffs"] do
        DisableControlAction(0, 69, true)
        DisableControlAction(0, 92, true)
        DisableControlAction(0, 114, true)
        DisableControlAction(0, 140, true)
        DisableControlAction(0, 141, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(0, 263, true)
        DisableControlAction(0, 264, true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 25, true)
        DisableControlAction(0, 21, true)
        DisableControlAction(0, 22, true)
        DisableControlAction(0, 288, true)
        DisableControlAction(0, 289, true)
        DisableControlAction(0, 170, true)
        DisableControlAction(0, 166, true)
        DisableControlAction(0, 167, true)
        DisableControlAction(0, 168, true)
        DisableControlAction(0, 57, true)
        DisableControlAction(0, 37, true)
        DisableControlAction(0, 0, true)
        DisableControlAction(0, 26, true)
        if (not IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3)) then
            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end
        Wait(5)
    end
end)

RegisterNetEvent("Police:item:handcuffs:unUsed", function()
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(HandCuffObj, 1, 1)
    DeleteObject(HandCuffObj)
    SetEnableHandcuffs(PlayerPedId(), false)
    DisablePlayerFiring(PlayerPedId(), false)
    SetPedCanPlayGestureAnims(PlayerPedId(), true)
end)

RegisterNetEvent("Police:item:handcuffs:animationUse", function()
    RequestAnimDict('mp_arrest_paired') 
    while (not HasAnimDictLoaded('mp_arrest_paired')) do 
        Wait(50)
    end
    TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750, 2, 0, 0, 0, 0)
end)

RegisterNetEvent("Police:item:handcuffs:animationUnused", function()
    RequestAnimDict('mp_arresting') 
    while (not HasAnimDictLoaded('mp_arresting')) do 
        Wait(50)
    end
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8, 3750, 2, 0, 0, 0, 0)
    Wait(GetAnimDuration("mp_arresting", "a_uncuff") * 400)
    ClearPedTasks(PlayerPedId())
    SetPedCanRagdollFromPlayerImpact(PlayerPedId(), false)
    SetPedKeepTask(PlayerPedId(), false)
    SetBlockingOfNonTemporaryEvents(PlayerPedId(), false)
end)