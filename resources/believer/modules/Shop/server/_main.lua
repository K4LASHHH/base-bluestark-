GM.Shop.registeredZones = {}

GM.Shop.registeredShops = {}

GM.Shop.registeredBlips = {}

GM.Shop.registeredPeds = {}

GM:newThread(function()
    while (GM.Shop.List == nil) do
        Wait(100)
    end
    
    for i = 1, #GM.Shop.List do
        local shopId = "shop_" .. i
        local shop = GM.Shop.List[i]

        GM.Shop.registeredShops[shopId] = ScriptServer.Classes.Shop.new(shopId, shop)

        GM.Shop.registeredZones[shopId] = GM.Zone.Management:create(shop.position, 3.0, shop.helpNotification, function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            print(GM.Shop.registeredShops[shopId].shopId)

            local shop = ScriptServer.Managers.Shops:GetShop(GM.Shop.registeredShops[shopId].shopId)
            if not shop then return end

            shop:openShop(playerSelected.source)

            TriggerClientEvent("Inventory:openInventory", playerSelected.source)
        end, {
            private = false,
            marker = true
        })

        GM.Shop.registeredBlips[shopId] = GM.Blip:add(shop.position, {
            sprite = 59,
            colour = 4,
            name = shop.shopName.." - "..i,
        }, {
            isPrivate = false
        })

        GM.Shop.registeredPeds[shopId] = GM.Ped:create(9, shop.ped["model"], {
            x = shop.ped["position"].x,
            y = shop.ped["position"].y,
            z = shop.ped["position"].z
        }, shop.ped["heading"])
    end
end)