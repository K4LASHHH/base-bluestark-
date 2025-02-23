GM.Lift = {
    menu = {},
    data = {},
}

GM.Lift.list = {
    ["AMBULANCE_1"] = {
        {
            name = "Accueil",
            flooor = "3",
            pos = vec3(331.41299438477,-595.45880126953,43.284076690674)
        },
        {
            name = "Ambulance garage",
            floor = "1",
            pos = vec3(342.11361694336,-585.48492431641,28.799180984497),            
        }
    },
    ["POLICE_1"] = {
        {
            name = "Hélipad",
            floor = "6",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Bureaux",
            floor = "5",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Bureaux",
            floor = "4",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Salle de dispatch, vestiaires",
            floor = "3",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Cafétéria",
            floor = "2",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Hall principal, salle de conférence",
            floor = "1",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Armurerie",
            floor = "-3",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Coffre saisies, laboratoires",
            floor = "-2",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
        {
            name = "Cellules, salles d'interrrogatoire, garage",
            floor = "-1",
            pos = vec3(-1095.8507080078,-850.82409667969,4.8841781616211)
        },
    },
}

GM.Lift.menu.main = RageUI.CreateMenu("", "Ascenseur", 0, 0, "banner", "bluestark")
GM.Lift.menu.main["Closed"] = function()
    -- Todo event when menu closed
end

GM.Lift.menu.main:isVisible(function(Items)
    for stairSelected, stair in pairs(GM.Lift["list"][GM.Lift.data["currentLift"]]) do 
        Items:Button(stair.name, nil, {RightLabel = stair.floor}, true, {
            onSelected = function()
                DoScreenFadeOut(200)
                Wait(500)
                SetEntityCoordsNoOffset(PlayerPedId(), stair.pos)
                DoScreenFadeIn(200)
                GM.Lift.menu.main:close()
                if (stair.callback) then
                    stair.callback(stairSelected)
                end
            end
        })
    end
end)

local function getClosestLift(pos)
    local dist, currentName = -1, nil
    while (GM.Lift["list"] == nil) do
        Wait(150)
    end
    for name, _ in pairs(GM.Lift["list"]) do 
        for _, v in pairs(GM.Lift["list"][name]) do 
            calculatedDist = #(pos - v.pos)
            if calculatedDist < dist or dist == -1 then 
                dist, currentName = calculatedDist, name
            end 
        end
    end 
    return dist, currentName
end

GM:newThread(function()
    local waiting = 1250
    while true do 
        local pPos = GetEntityCoords(PlayerPedId())
        local dist, currentName = getClosestLift(pPos)
      
        if dist < 3 and not RageUI.Visible(mainMenu) then 
            waiting = 1
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour prendre ~b~l'ascenseur~s~.")
            if (IsControlJustPressed(0, 51)) then
                GM.Lift.data["currentLift"] = currentName
                GM.Lift.menu.main:open()
            end
        else
            waiting = 1250
        end 
        Wait(waiting)
    end 
end)

-- Todo create stairs with object and interact with zone module and not client side and also make blue the current floor and set the heading