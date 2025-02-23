GM.Identity = GM.Identity or {}

GM.Identity = {
    menu = {
        submenus = {}
    },
    data = {
        index_sexe = 1,
        sexe = "Homme",
        Indexsexe = 1,
    },
}



GM.Identity.menu.main = RageUI.CreateMenu("", "CREATOR", 0, 0, "banner", "bluestark")
GM.Identity.menu.main["Closable"] = false
GM.Identity.menu.main["Closed"] = function()
end

GM.Identity.menu.main:isVisible(function(Items)
    Items:Button("Prénom", nil, { RightLabel = GM.Identity.data.first_name}, true, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Choisissez votre prénom",
                submitLabel = "VALIDER",
                placeHolders = {
                    {label = "Prénom"},
                }
            })
            GM.Identity.data.first_name = input["0"]
        end
    })
    Items:Button("Nom", nil, { RightLabel = GM.Identity.data.last_name}, true, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Choisissez votre nom",
                submitLabel = "VALIDER",
                placeHolders = {
                    {label = "Nom"},
                }
            })
            GM.Identity.data.last_name = input["0"]
        end
    })
    Items:Button("Date de naissance", nil, { RightLabel = GM.Identity.data.dateofbirth}, true, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Choisissez votre date de naissance",
                submitLabel = "VALIDER",
                placeHolders = {
                    {label = "Date de naissance (DD/MM/YY)"},
                }
            })
            GM.Identity.data.dateofbirth = input["0"]
        end
    })
    Items:Button("Taille", nil, { RightLabel = GM.Identity.data.height}, true, {
        onSelected = function()
            local input = exports["input"]:openInput({
                label = "Choisissez votre taille",
                submitLabel = "VALIDER",
                placeHolders = {
                    {label = "Taille"},
                }
            })
            GM.Identity.data.height = input["0"]
        end
    })
    Items:List("Sexe", {"Homme", "Femme"}, GM.Identity.data.index_sexe, nil, {}, true, {
        onListChange = function(Index, Item)
            GM.Identity.data.index_sexe = Index
            if (GM.Identity.data.index_sexe == 1) then
                GM.Identity.data.sex = "Homme"
            elseif (GM.Identity.data.index_sexe == 2) then
                GM.Identity.data.sex = "Femme"
            end
        end,
        onSelected = function(index)
            if index == 1 then
                TriggerEvent("skinchanger:change", "sex", 0)

            elseif index == 2 then
                TriggerEvent("skinchanger:change", "sex", 1)
            end
        end
    })
    Items:Button("Confirmer votre identité", nil, {}, GM.Identity.data.first_name ~= nil and GM.Identity.data.last_name ~= nil and GM.Identity.data.dateofbirth ~= nil and GM.Identity.data.height ~= nil and GM.Identity.data.sex ~= nil, {
        onSelected = function()
            TriggerServerEvent("Creator:modifyIdentity", {
                first_name = GM.Identity.data.first_name,
                last_name = GM.Identity.data.last_name,
                dateofbirth = GM.Identity.data.dateofbirth,
                height = GM.Identity.data.height,
                sex = GM.Identity.data.sex,
            })
        end
    }, GM.Identity.menu.submenus["appareance"])
end)

RegisterNetEvent("Creator:openIdentity", function(firstName, lastName, dateofbirth, height, sex)
    GM.Identity.data.first_name = firstName
    GM.Identity.data.last_name = lastName
    GM.Identity.data.dateofbirth = dateofbirth
    GM.Identity.data.height = height
    GM.Identity.data.sex = sex

    RageUI.CloseAll()

    GM.Identity.menu.main:toggle()
end)

RegisterNetEvent("Creator:closeIdentity", function()
    GM.Identity.menu.main:close()
end)