GM.Clothes = {
    menu = {
        submenus = {}
    },
    data = {
        drawable = {},
        textures = {},
        new = {},
    },
}

GM.Clothes.menu.main = RageUI.CreateMenu("", "Vêtements", 0, 0, "banner", "bluestark")
GM.Clothes.menu.main["Closed"] = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

GM.Clothes.menu.submenus["categories"] = RageUI.CreateSubMenu(GM.Clothes.menu.main, "", "Catégorie - ")

GM.Clothes.menu.main:isVisible(function(Items)
    if (GM.Clothes.data["categories"] ~= nil) then
        for i = 1, #GM.Clothes.data["categories"] do
            local category = GM.Clothes.data["categories"][i]

            Items:Button(category.label, nil, {}, true, {
                onSelected = function()
                    GM.Clothes.data["currentCategory"] = category
                    GM.Clothes.menu.submenus["categories"]:SetSubtitle("Catégorie - "..category.label)
                end
            }, GM.Clothes.menu.submenus["categories"])
        end
    end
end)

GM.Clothes.menu.submenus["categories"]:isVisible(function(Items)
    if (GM.Clothes.data["currentCategory"] ~= nil) then
        if (GM.Clothes.data.textures[GM.Clothes.data["currentCategory"].name] == nil) then
            GM.Clothes.data.textures[GM.Clothes.data["currentCategory"].name] = {}

            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), GM.Clothes.data["currentCategory"].drawable) - 1, 1 do
                GM.Clothes.data.textures[GM.Clothes.data["currentCategory"].name][i] = 1
            end
        end

        for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), GM.Clothes.data["currentCategory"].drawable) - 1, 1 do
            GM.Clothes.data.new = {}
            for textures = 1, GetNumberOfPedTextureVariations(PlayerPedId(), GM.Clothes.data["currentCategory"].drawable, i), 1 do
                GM.Clothes.data.new[textures] = textures
            end

            Items:List(GM.Clothes.data["currentCategory"].label.." "..i, GM.Clothes.data.new, GM.Clothes.data.textures[GM.Clothes.data["currentCategory"].name][i], "Prix : 30~g~$", {}, true, {
                onListChange = function(index)
                    GM.Clothes.data.textures[GM.Clothes.data["currentCategory"].name][i] = index
                    --actualIndex = nil
                end,
                onActive = function()
                    --if actualIndex == nil or actualIndex ~= i then
                        TriggerEvent("skinchanger:change", GM.Clothes.data["currentCategory"].name.."_1", i)
                        TriggerEvent("skinchanger:change", GM.Clothes.data["currentCategory"].name.."_2", GM.Clothes.data.textures[GM.Clothes.data["currentCategory"].name][i] - 1)
                        actualIndex = i
                    --end
                end,
                onSelected = function()
                    TriggerEvent("skinchanger:change", GM.Clothes.data["currentCategory"].name.."_1", i)
                    TriggerEvent("skinchanger:change", GM.Clothes.data["currentCategory"].name.."_2", GM.Clothes.data.textures[GM.Clothes.data["currentCategory"].name][i] - 1)
                end
            })
        end
    end
end)

RegisterNetEvent("Clothes:openShop", function(shopData)
    if (GM.Clothes.data["categories"] == nil) then
        GM.Clothes.data["categories"] = shopData["categories"]
    end

    GM.Clothes.data["categories"] = shopData["categories"]

    if (GM.Clothes.data["shopId"] == nil) then
        GM.Clothes.data["shopId"] = shopData["shopId"]
    end

    GM.Clothes.data["shopId"] = shopData["shopId"]

    GM.Clothes.menu.main:toggle()
end)