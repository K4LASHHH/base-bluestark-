GM.Ammunation.registeredZones = {}

GM.Ammunation.registeredShops = {}

GM.Ammunation.registeredBlips = {}

GM.Ammunation.registeredPeds = {}

GM:newThread(function()
    while (GM.Ammunation.List == nil) do
        Wait(100)
    end
    
    for i = 1, #GM.Ammunation.List do
        local ammunationId = "ammunation_" .. i
        local ammunation = GM.Ammunation.List[i]

        GM.Ammunation.registeredShops[ammunationId] = ScriptServer.Classes.Shop.new(ammunationId, ammunation)

        GM.Ammunation.registeredZones[ammunationId] = GM.Zone.Management:create(ammunation.position, 3.0, ammunation.helpNotification, function(playerSrc)
            local playerSelected = ESX.GetPlayerFromId(playerSrc)
            if (not playerSelected) then return end

            print(GM.Ammunation.registeredShops[ammunationId].shopId)

            local shop = ScriptServer.Managers.Shops:GetShop(GM.Ammunation.registeredShops[ammunationId].shopId)
            if not shop then return end

            shop:openShop(playerSelected.source)

            TriggerClientEvent("Inventory:openInventory", playerSelected.source)
        end, {
            private = false,
            marker = true
        })

        GM.Ammunation.registeredBlips[ammunationId] = GM.Blip:add(ammunation.position, {
            sprite = 110,
            colour = 3,
            name = ammunation.shopName.." - "..i,
        }, {
            isPrivate = false
        })

        GM.Ammunation.registeredPeds[ammunationId] = GM.Ped:create(9, ammunation.ped["model"], {
            x = ammunation.ped["position"].x,
            y = ammunation.ped["position"].y,
            z = ammunation.ped["position"].z
        }, ammunation.ped["heading"])
    end
end)