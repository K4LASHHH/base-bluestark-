ScriptServer = {}
ScriptServer.Classes = {}
ScriptServer.Managers = {}
ScriptServer.resourceName = GetCurrentResourceName()
ScriptServer.isLoaded = false

AddEventHandler("onServerResourceStart", function(resourceName)
    if ScriptServer.resourceName ~= resourceName then return end

    ScriptServer.Managers.Dropped:onServerResourceStart()
    ScriptServer.isLoaded = true

    for k, v in pairs(GM.Inventory.FACTION_INVENTORIES) do
        ScriptServer.Classes.FactionInventory.new({
            faction = k,
            inventoryName = v.header,
            maxWeight = v.maxWeight,
            slotsAmount = v.slotsAmount,
            uniqueID = k,
            safeCoords = vector3(v.x, v.y, v.z),
            safeHeading = v.heading
        })
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if ScriptServer.resourceName ~= resourceName then return end

    ScriptServer.Managers.Dropped:onResourceStop()
end)

local function SaveInventoriesInterval()
    ScriptServer.Managers.Inventory:SaveInventories()
    Citizen.SetTimeout(GM.Inventory.SAVE_INVENTORIES_MS, SaveInventoriesInterval)
end

Citizen.SetTimeout(GM.Inventory.SAVE_INVENTORIES_MS, SaveInventoriesInterval)

RegisterNetEvent("Inventory:ITEM_MOVE_TO_SLOT", function(d)
    local source <const> = source
    local fromUniqueID <const> = d.fromUniqueID
    local fromSlot <const> = d.fromSlot
    local toUniqueID <const> = d.toUniqueID
    local toSlot <const> = d.toSlot
    local quantity = d.quantity

    local player <const> = ESX.GetPlayerFromId(source)
    if not player then return end

    local grabbed_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = fromUniqueID })
    local to_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = toUniqueID })
    if not (grabbed_inventory and to_inventory) then return end

    local item <const> = grabbed_inventory:getItemBy({ slot = fromSlot })
    if not item then return end

    if type(quantity) ~= "number" or quantity > item.quantity or quantity < 1 then quantity = item.quantity end
    if not item.data.stackable then quantity = 1 end

    if grabbed_inventory:isSame(to_inventory) then
        -- print(item.data.label)
        -- if (item.meta) then
        --     if (item.meta.customName) then
        --         print(item.meta.customName)
        --     end
        -- end
        local addedResult = grabbed_inventory:addItem({
            name = item.name,
            quantity = quantity,
            meta = item.meta,
            toSlot = toSlot
        }, true)
        if addedResult.success then
            grabbed_inventory:removeItemBy(quantity, { slot = fromSlot })
        end
    else
        local addedResult = nil

        if not item.data.tradable then
            player.showInventoryNotification("info", "L'item n'est pas échangeable !")
            return
        end

        if to_inventory.type == "dropped_grid" then
            local pX <const>, pY <const>, pZ <const> = table.unpack(GetEntityCoords(GetPlayerPed(source)))
            addedResult = to_inventory:addItem({
                name = item.name,
                quantity = quantity,
                meta = item.meta,
                toSlot = toSlot,
                coordX = pX,
                coordY = pY,
                coordZ = pZ
            }, true)
        else
            addedResult = to_inventory:addItem({
                name = item.name,
                quantity = quantity,
                meta = item.meta,
                toSlot = toSlot
            })
            if (item.name == "money") then
                playerSelected.addAccountMoney(item.name, quantity)
                to_inventory:removeItemBy(quantity, {
                    name = "money",
                })
            elseif (item.name == "black_money") then
                playerSelected.addAccountMoney(item.name, quantity)
                to_inventory:removeItemBy(quantity, {
                    name = "black_money",
                })
            end
        end

        if addedResult.success then
            grabbed_inventory:removeItemBy(quantity, { slot = fromSlot })
        end
    end
end)
RegisterNetEvent("Inventory:CLOSE_SECOND_INVENTORY", function(uniqueID)
    local source <const> = source
    local inv <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = uniqueID }) --[[@as unknown]]
    if not inv then return end

    if type(inv.close) == 'function' then
        inv:close(source)
    end
end)
RegisterNetEvent("Inventory:ADD_NOTE_ITEM", function(data)
    local source <const>   = source
    local itemHash <const> = data.itemHash
    local uniqueID <const> = data.uniqueID
    local newNote <const>  = data.newNote

    local player <const>   = ESX.GetPlayerFromId(source)
    if not player then return end

    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = uniqueID })
    if not inventory then return end
    local item <const> = inventory:getItemBy({ itemHash = itemHash })
    if not item then return end

    if item.meta.note == newNote then return end

    if type(newNote) == "string" and string.len(newNote) > 0 then
        item.meta.note = newNote
    else
        item.meta.note = nil
    end

    inventory:OnItemUpdated(item)
    player.showInventoryNotification("success", "Note d'information modifiée avec succès !")
end)
RegisterNetEvent("Inventory:RENAME_ITEM", function(data)
    local source <const>   = source
    local itemHash <const> = data.itemHash
    local uniqueID <const> = data.uniqueID
    local newName <const>  = data.newName

    local player <const>   = ESX.GetPlayerFromId(source)
    if not player then return end

    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = uniqueID })
    if not inventory then return end
    local item <const> = inventory:getItemBy({ itemHash = itemHash })
    if not item then return end

    if item.meta.customName == newName then return end

    if type(newName) == "string" and string.len(newName) > 0 then
        item.meta.customName = newName
    else
        item.meta.customName = nil
    end

    inventory:OnItemUpdated(item)
    player.showInventoryNotification("success", "L'item a été renommé avec succès !")
end)

RegisterNetEvent("Inventory:OPEN_NEAR_TRUNKS", function(vehicleNetIds)
    local playerId = source

    local playerPed = GetPlayerPed(playerId)
    if GetVehiclePedIsIn(playerPed, false) ~= 0 then return end

    for i = 1, #vehicleNetIds do
        local netId = vehicleNetIds[i]
        local veh = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(veh) then
            local plate = GetVehicleNumberPlateText(veh)
            if GM.Inventory.IS_VEHICLE_EXIST(plate) then
                local modelHash = GetEntityModel(veh)
                local uniqueID <const> = 'trunk-' .. plate
                local trunk_inventory = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = uniqueID }) --[[@as TrunkInventory]]
                if not trunk_inventory then
                    trunk_inventory = ScriptServer.Classes.TrunkInventory.new({
                        inventoryName = string.format('COFFRE (%s)', plate),
                        maxWeight = GM.Inventory.VEHICLE_SIZES.getTrunkMaxWeight(modelHash),
                        plate = plate,
                        slotsAmount = GM.Inventory.VEHICLE_SIZES.getTrunkSlots(modelHash),
                        uniqueID = uniqueID
                    })
                end

                trunk_inventory:open(playerId)
            end
        end
    end
end)

RegisterNetEvent("Inventory:OPEN_VEHICLE_GLOVEBOX_INVENTORY", function()
    local playerId = source

    local playerPed = GetPlayerPed(playerId)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if not DoesEntityExist(vehicle) or GetEntityType(vehicle) ~= 2 then return end

    local plate = GetVehicleNumberPlateText(vehicle)
    if not GM.Inventory.IS_VEHICLE_EXIST(plate) then return end

    local modelHash = GetEntityModel(vehicle)

    local uniqueID = 'glovebox-'..plate
    local glovebox_inventory = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = uniqueID }) --[[@as GloveboxInventory]]
    if not glovebox_inventory then
        glovebox_inventory = ScriptServer.Classes.GloveboxInventory.new({
            inventoryName = string.format('BOITE A GANT (%s)', plate),
            maxWeight = GM.Inventory.VEHICLE_SIZES.getGloveboxMaxWeight(modelHash),
            plate = plate,
            slotsAmount = GM.Inventory.VEHICLE_SIZES.getGloveboxSlots(modelHash),
            uniqueID = uniqueID
        })
    end

    glovebox_inventory:open(playerId)
end)

RegisterNetEvent("Inventory:OPEN_NEAR_FACTION_SAFES", function()
    local playerId = source

    local playerPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)

    for k, v in pairs(GM.Inventory.FACTION_INVENTORIES) do
        local safePos = vector3(v.x, v.y, v.z)
        local dist = #(playerCoords - safePos)
        if dist < GM.Inventory.FACTION_SAFE_OPEN_RANGE then
            local safe = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = k }) --[[@as FactionInventory]]
            if safe then
                safe:open(playerId)
            end
        end
    end
end)

RegisterNetEvent("Inventory:onInventoryOpen", function()
    local playerId = source
end)

RegisterNetEvent("Inventory:onInventoryClose", function()
    local playerId = source
end)

RegisterNetEvent("Inventory:BUY_FROM_SHOP", function(data)
    local source <const> = source
    local shopId <const> = data.shopId
    local fromSlot <const> = data.fromSlot
    local toSlot <const> = data.toSlot
    local quantity = data.quantity

    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = source })
    if not inventory then return end

    local shop <const> = ScriptServer.Managers.Shops:GetShop(shopId)
    if not shop then return end

    local shop_item <const> = shop:GetShopItemOnSlot(fromSlot)
    if not shop_item then return end

    if (shop_item.meta.job) then
        if (playerSelected.job.name ~= shop_item.meta.job) then
            playerSelected.showInventoryNotification("error", "Vous n'avez pas le job requis pour acheter cet objet.")
            return
        end
    end

    if (shop_item.meta.grade) then
        if (playerSelected.job.grade < shop_item.meta.grade) then
            playerSelected.showInventoryNotification("error", "Vous n'avez pas le grade requis pour acheter cet objet.")
            return
        end
    end

    local iData <const> = ScriptShared.Items:Get(shop_item.name)
    if not iData then return end

    if type(quantity) ~= "number" or quantity < 1 then quantity = 1 end
    if not iData.stackable then quantity = 1 end

    local player <const> = ESX.GetPlayerFromId(source)
    if not player then return end

    local finalPrice = shop_item.price * quantity

    if player:getMoney() < finalPrice then
        player.showInventoryNotification("warning", "Vous n'avez pas assez d'argent !")
        return
    end

    local addedResult = inventory:addItem({
        name = shop_item.name,
        meta = shop_item.meta,
        quantity = quantity,
        toSlot = toSlot
    })
    if addedResult.success then
        player.removeMoney(finalPrice)
    end
end)

RegisterNetEvent("Inventory:GIVE_ITEM_TO_TARGET", function(data)
    local source <const> = source
    local itemHash <const> = data.itemHash
    local serverId <const> = data.serverId
    local quantity = data.quantity

    if source == serverId then return end

    local player <const> = ESX.GetPlayerFromId(source)
    if not player then return end

    local player_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = source })
    local target_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = serverId })
    if not (player_inventory and target_inventory) then return end

    local item <const> = player_inventory:getItemBy({ itemHash = itemHash })
    if not item then return end

    if not item.data.tradable then
        player.showInventoryNotification("info", "L'item n'est pas échangeable !")
        return
    end

    if type(quantity) ~= "number" or quantity > item.quantity or quantity < 1 then
        quantity = item.quantity
    end

    if not target_inventory:canCarryWeight(item.name, quantity) then
        player.showInventoryNotification("info", "L'inventaire du joueur cible n'a pas assez d'espace !")
        return
    end

    local no_ref <const> = json.decode(json.encode(item))

    local addedResult = target_inventory:addItem({
        meta = no_ref.meta,
        name = no_ref.name,
        quantity = quantity
    })
    if addedResult.success then
        if (GM.Armor["player"][playerSelected.source] ~= nil) then
            if (GM.Armor["player"][playerSelected.source] == itemHash) then
                no_ref.meta.durability = playerSelected.getPedArmor()
    
                exports["believer"]:SetMetaData(playerSelected.source, { itemHash = GM.Armor["player"][playerSelected.source] }, no_ref.meta)
                playerSelected.setPedArmor(0)
                playerSelected.showInventoryNotification("success", "Votre kevlar a été retiré !")
    
                GM.Armor["player"][playerSelected.source] = nil
            end
        end

        player_inventory:removeItemBy(quantity, { itemHash = itemHash })

        if (no_ref.name == "money") then
            playerSelected.removeAccountMoney(no_ref.name, quantity)
            targetSelected.addAccountMoney(no_ref.name, quantity)
        elseif (no_ref.name == "black_money") then
            playerSelected.removeAccountMoney(no_ref.name, quantity)
            targetSelected.addAccountMoney(no_ref.name, quantity)
        end
    end
end)

RegisterNetEvent("Inventory:DROP_ITEM_ON_GROUND", function(data)
    local source <const> = source
    local uniqueID <const> = data.uniqueID
    local itemHash <const> = data.itemHash
    local quantity = data.quantity

    local player <const> = ESX.GetPlayerFromId(source)
    if not player then return end

    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = uniqueID })
    if not inventory then return end

    local item <const> = inventory:getItemBy({ itemHash = itemHash })
    if not item then return end

    if type(quantity) ~= "number" or quantity > item.quantity or quantity < 1 then
        quantity = item.quantity
    end

    if inventory.type == "dropped_grid" then
        player.showInventoryNotification("error", "Où voulez-vous déposer l'objet exactement ?")
        return
    end

    local pX <const>, pY <const>, pZ <const> = table.unpack(GetEntityCoords(GetPlayerPed(source)))

    local close_drop_grid <const> = ScriptServer.Managers.Dropped:createOrGetGrid(pX, pY, pZ)
    if not close_drop_grid then return end

    local no_ref <const> = json.decode(json.encode(item))

    local addedResult <const> = close_drop_grid:addItem({
        name = no_ref.name,
        quantity = quantity,
        meta = no_ref.meta,
        coordX = pX,
        coordY = pY,
        coordZ = pZ
    })

    if addedResult.success then
        close_drop_grid:createObjectIfNotExist(addedResult.item)

        if (GM.Armor["player"][player.source] ~= nil) then
            if (GM.Armor["player"][player.source] == no_ref.itemHash) then
                no_ref.meta.durability = player.getPedArmor()
    
                exports["believer"]:SetMetaData(player.source, { itemHash = GM.Armor["player"][player.source] }, no_ref.meta)
                player.setPedArmor(0)
                player.showInventoryNotification("success", "Votre kevlar a été retiré !")
    
                GM.Armor["player"][player.source] = nil
            end
        end

        inventory:removeItemBy(quantity, { itemHash = no_ref.itemHash })

        if (no_ref.name == "money") then
            player.removeAccountMoney(no_ref.name, quantity)
        elseif (no_ref.name == "black_money") then
            player.removeAccountMoney(no_ref.name, quantity)
        end

        -- Add as observer, if he is not one. (It will openup the dropped grid)
        if not close_drop_grid:hasObserver(source) then
            close_drop_grid:open(source)
        end
    end
end)

RegisterNetEvent("Inventory:OPEN_NEAR_DROPPED_GRID", function()
    local source <const> = source
    local pX <const>, pY <const>, pZ <const> = table.unpack(GetEntityCoords(GetPlayerPed(source)))
    local close_drop_grid <const> = ScriptServer.Managers.Dropped:gridAt(pX, pY, pZ)
    if not close_drop_grid then return end
    close_drop_grid:open(source)
end)

RegisterNetEvent("Inventory:REDUCE_WEAPON_AMMO", function()
    local source <const> = source
    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = source }) --[[@as PlayerInventory]]
    if not inventory then return end

    local usedWeapon = inventory:getItemBy({ itemHash = inventory.usedWeaponItemHash })
    if not usedWeapon then return end

    if GM.Inventory.AMMO_WEAPONS[usedWeapon.data.weaponHash] then
        inventory:removeItemBy(1, { name = GM.Inventory.AMMO_WEAPONS[usedWeapon.data.weaponHash] })
    elseif GM.Inventory.THROWABLE_WEAPONS[usedWeapon.data.weaponHash] then
        inventory:removeItemBy(1, { itemHash = inventory.usedWeaponItemHash })
    elseif GM.Inventory.MISC_WEAPONS[usedWeapon.data.weaponHash] then
        inventory:removeItemBy(math.random(3, 5), { itemHash = inventory.usedWeaponItemHash })
    end
end)

RegisterNetEvent("baseevents:onPlayerDied", function()
    local victim <const> = source
    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = victim })
    if not inventory then return end

    for i = #inventory.items, 1, -1 do
        local v = inventory.items[i]
        if v then
            if v.data.deletable then
                inventory:removeItemBy(v.quantity, { itemHash = v.itemHash })
            end
        end
    end
end)

RegisterNetEvent("Inventory:USE_ITEM", function(data)
    local source <const> = source
    local itemHash <const> = data.itemHash
    local uniqueID <const> = data.uniqueID

    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = uniqueID })
    if not inventory then return end
    local item <const> = inventory:getItemBy({ itemHash = itemHash })
    if not item then return end

    local player_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = source }) --[[@as PlayerInventory]]
    if not player_inventory then return end

    if item.data.weaponHash then
        player_inventory:UseWeaponItem(item)
    end

    if item.data.server and type(item.data.server.export) == "string" then
        local parts <const> = {}
        for part in string.gmatch(item.data.server.export, "[^.]+") do
            table.insert(parts, part)
        end

        local resource <const> = parts[1]
        local func <const> = parts[2]

        exports[resource][func](source, item)
    end

    if (item.data.event and item.data.event.client_event) then
        TriggerClientEvent(item.data.event.client_event, source, item)
    end

    if (item.data.event and item.data.event.server_event) then
        TriggerEvent(item.data.event.server_event, source, item)
    end

    if item.data.event and type(item.data.event.onUseDeleteAmount) == "number" and item.data.event.onUseDeleteAmount > 0 then
        inventory:removeItemBy(item.data.event.onUseDeleteAmount, { itemHash = itemHash })
    end
end)

RegisterNetEvent("Inventory:USE_SLOT", function(slot)
    local source <const> = source
    local inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = source })
    if not inventory then return end
    local item <const> = inventory:getItemBy({ slot = slot })
    if not item then return end

    local player_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = source }) --[[@as PlayerInventory]]
    if not player_inventory then return end

    if item.data.weaponHash then
        player_inventory:UseWeaponItem(item)
    end

    if item.data.server and type(item.data.server.export) == "string" then
        local parts <const> = {}
        for part in string.gmatch(item.data.server.export, "[^.]+") do
            table.insert(parts, part)
        end

        local resource <const> = parts[1]
        local func <const> = parts[2]

        exports[resource][func](source, item)

        if type(item.data.server.onUseDeleteAmount) == "number" and item.data.server.onUseDeleteAmount > 0 then
            inventory:removeItemBy(item.data.server.onUseDeleteAmount, { itemHash = itemHash })
        end
    end
end)

RegisterNetEvent("Inventory:OPEN_STASH", function(uniqueID)
    local source <const> = source
    exports[ScriptServer.resourceName]:OpenStash(source, uniqueID)
end)

RegisterNetEvent("Inventory:ITEM_ADD_ATTACHMENT_WEAPON", function(d)
    local source <const> = source
    local fromUniqueID <const> = d.fromUniqueID
    local toUniqueID <const> = d.toUniqueID
    local draggedItemhash <const> = d.draggedItemhash
    local toItemHash <const> = d.toItemHash

    local player <const> = ESX.GetPlayerFromId(source)
    if not player then return end

    local from_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = fromUniqueID })
    local to_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = toUniqueID })
    if not (from_inventory and to_inventory) then return end

    local draggedItem <const> = from_inventory:getItemBy({ itemHash = draggedItemhash })
    local to_item <const> = to_inventory:getItemBy({ itemHash = toItemHash })
    if not (draggedItem and to_item) then return end

    if to_item.data.weaponHash == nil then
        player.showInventoryNotification("error", "Il ne s'agit pas d'une arme !")
        return
    end

    -- Modify these lines, if you do not want the player to be able to equip a Shotgun attachment on the pistol for example.
    -- (You have to define the allowedAttachments table under the weapon item data.)
    local canAddAttachment = true
    local hasThisAttachment = false

    -- local canAddAttachment = false
    -- local hasThisAttachment = false
    -- -- if type(to_item.data.allowedAttachments) == "table" then
    -- --     for k, v in pairs(to_item.data.allowedAttachments) do
    -- --         if v == draggedItem.name then
    -- --             canAddAttachment = true
    -- --             break
    -- --         end
    -- --     end
    -- -- end

    if not canAddAttachment then
        player.showInventoryNotification("warning", "Vous ne pouvez pas utiliser cet accessoire sur cette arme !")
        return
    end

    if type(to_item.meta.attachments) ~= "table" then
        to_item.meta.attachments = {}
    end

    if #to_item.meta.attachments >= 5 then
        player.showInventoryNotification("info", "Vous ne pouvez pas ajouter plus d'accessoires à cette arme !")
        return
    end

    for k, v in pairs(to_item.meta.attachments) do
        if v == draggedItem.name then
            hasThisAttachment = true
            break
        end
    end

    if hasThisAttachment then
        player.showInventoryNotification("warning", "Vous avez déjà ce type d'attachement sur cette arme !")
        return
    end

    to_item.meta.attachments[#to_item.meta.attachments + 1] = draggedItem.name
    to_inventory:OnItemUpdated(to_item)
    from_inventory:removeItemBy(nil, { itemHash = draggedItemhash })

    if to_inventory.type == "player" then
        TriggerClientEvent("Inventory:UpdateWeaponAttachments", to_inventory.source, to_item)
    end
end)

RegisterNetEvent("Inventory:ITEM_REMOVE_ATTACHMENT_WEAPON", function(d)
    local source <const> = source
    local fromUniqueID <const> = d.fromUniqueID
    local fromItemHash <const> = d.fromItemHash
    local fromAttIndex <const> = d.fromAttIndex
    local toUniqueID <const> = d.toUniqueID
    local toSlot <const> = d.toSlot

    local from_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = fromUniqueID })
    local to_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = toUniqueID })
    if not (from_inventory and to_inventory) then return end

    local from_item <const> = from_inventory:getItemBy({ itemHash = fromItemHash })
    if not from_item then return end

    if type(from_item.meta.attachments) ~= "table" then
        from_item.meta.attachments = {}
    end

    local attachment <const> = from_item.meta.attachments[fromAttIndex]
    if not attachment then return end

    local response = to_inventory:addItem({
        name = attachment,
        toSlot = toSlot
    })
    if response.success then
        table.remove(from_item.meta.attachments, fromAttIndex)
        to_inventory:OnItemUpdated(from_item)

        if to_inventory.type == "player" then
            TriggerClientEvent("Inventory:UpdateWeaponAttachments", to_inventory.source, from_item)
        end
    end
end)
RegisterNetEvent("Inventory:REDUCE_WEAPON_DURABILITY", function()
    local source <const> = source
    local player_inventory <const> = ScriptServer.Managers.Inventory:GetInventory({ source = source }) --[[@as PlayerInventory]]
    if not player_inventory then return end
    player_inventory:ReduceWeaponDurability()
end)

local Module = {}
---@type { [string]: DroppedInventory }
Module.Grids = {}

ScriptServer.Managers.Dropped = Module

function Module:loadGrids()
    local dropped_grids = exports["oxmysql"]:query_async("SELECT * FROM inventory_items WHERE type = @type", {
        ["@type"] = "dropped_grid"
    })

    for i = 1, #dropped_grids, 1 do
        local v = dropped_grids[i]
        ScriptServer.Classes.DroppedInventory.new({
            originX = v.originX,
            originY = v.originY,
            originZ = v.originZ,
            uniqueID = v.uniqueID,
            inventoryName = 'PROXIMITÉ',
            slotsAmount = GM.Inventory.DROPPED_ITEMS.GRID_SLOTS,
            maxWeight = GM.Inventory.DROPPED_ITEMS.GRID_MAX_WEIGHT,
            expires = v.expires
        })
    end
end

function Module:generateUnique()
    return os.time() .. "-" .. math.random(1, 1000000)
end

function Module:createGrid(x, y, z)
    return ScriptServer.Classes.DroppedInventory.new({
        originX = x,
        originY = y,
        originZ = z,
        uniqueID = "dropped_grid-" .. self:generateUnique(),
        inventoryName = 'PROXIMITÉ',
        slotsAmount = GM.Inventory.DROPPED_ITEMS.GRID_SLOTS,
        maxWeight = GM.Inventory.DROPPED_ITEMS.GRID_MAX_WEIGHT,
        expires = os.time() + GM.Inventory.DROPPED_ITEMS.REMAIN_ON_GROUND
    })
end

-- This will not create the grid if not exist.
---@param x number
---@param y number
---@param z number
function Module:gridAt(x, y, z)
    local inRange = GM.Inventory.DROPPED_ITEMS.GRID_RANGE

    for k, v in pairs(self.Grids) do
        local dist = #(vector3(x, y, z) - vector3(v.originX, v.originY, v.originZ))
        if dist < inRange then
            return v
        end
    end
end

function Module:createOrGetGrid(x, y, z)
    ---@type DroppedInventory | nil
    local grid = self:gridAt(x, y, z)

    if not grid then
        grid = self:createGrid(x, y, z)
    end

    return grid
end

function Module:onServerResourceStart()
    self:loadGrids()
end

function Module:onResourceStop()
    local objects = GetAllObjects()
    local count = 0
    for k, v in pairs(objects) do
        if Entity(v).state.dropped_item then
            DeleteEntity(v)
            count = count + 1
        end
    end

    print(string.format("^4Deleted (%d) dropped object(s) on resource stop.", count))
end

function Module:SaveDroppeds()
    for k, v in pairs(self.Grids) do
        v:save()
    end
end

function Module:checkAllExpired()
    for k, v in pairs(self.Grids) do
        v:checkExpired()
    end
end

Citizen.CreateThread(function()
    while true do
        Module:checkAllExpired()
        Citizen.Wait(60000 * 30)
    end
end)

local Module <const> = {}
---@type { [string]: BaseInventory | PlayerInventory }
Module.Inventories = {}

ScriptServer.Managers.Inventory = Module

function Module:SaveInventories()
    for k, v in pairs(self.Inventories) do
        v:save()
    end
end

--- Returns an inventory with the specified uniqueID or source.
---@param data { uniqueID?: string; source?:number; }
---@return PlayerInventory | BaseInventory | StashInventory | GloveboxInventory | TrunkInventory | nil
function Module:GetInventory(data)
    if type(data.uniqueID) == "string" then
        return type(self.Inventories[data.uniqueID]) == "table" and self.Inventories[data.uniqueID] or nil
    end

    if type(data.source) == "number" then
        local player <const> = ESX.GetPlayerFromId(data.source)
        if not player then return end

        local identifier <const> = player:getIdentifier()
        return type(self.Inventories[identifier]) == "table" and self.Inventories[identifier] or nil
    end
end

---@class BaseInventory:BaseInventoryClassCreateInterface
local Module <const> = {}
---@type table<number, boolean>
Module.observers = {}
---@type InventoryItem[]
Module.items = {}
---@type string
Module.inventoryName = ""
---@type InventoryTypes
Module.type = "base"
Module.__index = Module

ScriptServer.Classes.BaseInventory = Module

---@class BaseInventoryClassCreateInterface
---@field slotsAmount number
---@field maxWeight number
---@field uniqueID string
---@field inventoryName string
---@field type InventoryTypes

---@param data BaseInventoryClassCreateInterface
Module.new = function(data)
    local self = setmetatable({}, Module)

    local inv_sql <const> = MySQL.single.await(
        "SELECT * FROM inventory_items WHERE uniqueID = ? AND type = ?",
        {
            data.uniqueID,
            data.type
        }
    ) --[[@as DB_Inventory]]

    ---@type InventoryItem[]
    local format_items <const> = {}

    local sql_items = {}
    if inv_sql and type(inv_sql.items) == "string" then
        sql_items = json.decode(inv_sql.items)
    end

    for i = 1, #sql_items do
        local v <const> = sql_items[i]
        local iData <const> = ScriptShared.Items:Get(v.name)
        if iData then
            format_items[#format_items+1] = {
                name = v.name,
                quantity = v.quantity,
                slot = v.slot,
                itemHash = v.itemHash,
                meta = type(v.meta) == "table" and v.meta or type(iData.defaultMeta) == "table" and iData.defaultMeta or {},
                data = iData,
                coordX = v.coordX,
                coordY = v.coordY,
                coordZ = v.coordZ
            }
        end
    end

    self.uniqueID = data.uniqueID
    self.maxWeight = data.maxWeight
    self.slotsAmount = data.slotsAmount
    self.inventoryName = data.inventoryName
    self.type = data.type
    self.items = format_items
    self.observers = {}

    ScriptServer.Managers.Inventory.Inventories[self.uniqueID] = self

    return self
end

function Module:addObserver(source)
    if self.observers[source] then return end

    self.observers[source] = true

    TriggerEvent("Inventory:onObserverAdded", self.uniqueID, source)
end

function Module:removeObserver(source)
    if not self.observers[source] then return end

    self.observers[source] = nil

    TriggerEvent("Inventory:onObserverRemoved", self.uniqueID, source)
end

function Module:hasObserver(source)
    return type(self.observers[source]) == "boolean" and self.observers[source] or false
end

---@param cb fun(source: number)
function Module:triggerObservers(cb)
    if type(cb) ~= "function" then return end

    for observerSource in pairs(self.observers) do
        cb(observerSource)
    end
end

---@param item InventoryItem
---@param findBy findByOptions
---@private
function Module:findByChecker(item, findBy)
    local check_name <const> = findBy.name == nil or type(findBy.name) == "string" and findBy.name == item.name
    local check_quantity <const> = findBy.quantity == nil or type(findBy.quantity) == "number" and findBy.quantity == item.quantity
    local check_slot <const> = findBy.slot == nil or type(findBy.slot) == "number" and findBy.slot == item.slot
    local check_itemHash <const> = findBy.itemHash == nil or type(findBy.itemHash) == "string" and findBy.itemHash == item.itemHash

    -- By metadata.
    local check_meta = true
    if type(findBy.meta) == "table" and type(item.meta) == "table" then
        for k,v in pairs(findBy.meta) do
            if item.meta[k] ~= v then
                check_meta = false
                break
            end
        end
    end

    return (
        check_name and
        check_meta and
        check_quantity and
        check_slot and
        check_itemHash
    )
end

--- Only returns a single item. (found by the match)
---@param findBy findByOptions
function Module:getItemBy(findBy)
    for i = 1, #self.items, 1 do
        local v = self.items[i]
        if self:findByChecker(v, findBy) then
            return v
        end
    end
end

--- Returns more items. (found by the match)
---@param findBy findByOptions
function Module:getItemsBy(findBy)
    ---@type InventoryItem[]
    local items <const> = {}
    local found = 0

    for i = 1, #self.items, 1 do
        local v = self.items[i]
        if self:findByChecker(v, findBy) then
            items[#items+1] = v
            found += 1
        end
    end

    return items, found
end

--- Returns all of the quantity if the arguments are met.
---@param findBy findByOptions
function Module:getItemQuantityBy(findBy)
    local quantity = 0

    for i = 1, #self.items, 1 do
        local v = self.items[i]
        if self:findByChecker(v, findBy) then
            quantity += v.quantity
        end
    end

    return quantity
end

--- Get the weight of the inventory (current items)
function Module:getWeight()
    local weight = 0.0

    for i = 1, #self.items, 1 do
        local v = self.items[i]
        weight += v.data.stackable and (v.data.weight * v.quantity) or v.data.weight
    end

    return math.floor(weight * 10 ^ 2 + 0.5) / 10 ^ 2
end

function Module:getEmptySlot()
    for i = 1, self.slotsAmount do
        if not self:getItemBy({ slot = i }) then
            return i
        end
    end
end

function Module:generateUniqueItemHash()
    return os.time() .. "-" .. math.random(1, 1000000)
end

-- Generates a serial number for weapon(s).
function Module:generateSerialNumber()
    local serial = ""
    for i = 1, 8 do
        -- Generate a random character from A-Z or 0-9
        local randomChar = string.char(math.random(48, 57), math.random(65, 90))
        serial = serial .. randomChar
    end
    return serial
end

---@param name string
---@param quantity number
function Module:setItemQuantity(name, quantity)
    local items = self:getItemsBy({ name = name })
    if #items < 1 then
        self:addItem({
            name = name,
            quantity = quantity
        })
    elseif #items == 1 then
        local item = items[1]
        item.quantity = quantity
        self:OnItemUpdated(item)
    else
        for i = 1, #items, 1 do
            self:removeItemBy(items[i].quantity, { name = items[i].name }) 
        end

        self:addItem({
            name = name,
            quantity = quantity
        })
    end
end

---@class AddItemInterface
---@field name string
---@field quantity? number
---@field meta? InventoryItemMetaData
---@field toSlot? number

---@param data AddItemInterface
---@param ignoreWeight? boolean
function Module:addItem(data, ignoreWeight)
    local iData <const> = ScriptShared.Items:Get(data.name)
    if not iData then
        return ScriptShared:createRet({ success = false, response = "item_not_registered" })
    end

    if type(data.quantity) ~= "number" or data.quantity < 1 or not iData.stackable then data.quantity = 1 end
    if type(data.meta) ~= "table" then
        data.meta = type(iData.defaultMeta) == "table" and iData.defaultMeta or {}
    else
        if type(iData.defaultMeta) == "table" then
            for k,v in pairs(iData.defaultMeta) do
                if data.meta[k] == nil then
                    data.meta[k] = v
                end
            end
        end
    end

    if not ignoreWeight and not self:canCarryWeight(data.name, data.quantity) then
        return ScriptShared:createRet({ success = false, response = "weight_exceed" })
    end

    -- If its a weapon then generate a serial number.
    if iData.generateSerial and type(data.meta.serial) ~= "string" then
        data.meta.serial = self:generateSerialNumber()
    end

    if type(data.toSlot) == "number" then
        if iData.stackable then
            local onSlotItem <const> = self:getItemBy({ slot = data.toSlot })
            if onSlotItem then
                if onSlotItem.name ~= data.name then
                    return ScriptShared:createRet({ success = false, response = "item_can_not_stack"  })
                end

                onSlotItem.quantity += data.quantity
                self:OnItemUpdated(onSlotItem)
                return ScriptShared:createRet({ success = true, response = "added_item_on_stack", item = onSlotItem })
            else
                self.items[#self.items+1] = {
                    name = data.name,
                    quantity = data.quantity,
                    meta = data.meta,
                    slot = data.toSlot,
                    data = iData,
                    itemHash = self:generateUniqueItemHash()
                }
                self:OnItemAdded(self.items[#self.items])
                return ScriptShared:createRet({ success = true, response = "item_added_on_new_slot", item = self.items[#self.items] })
            end
        else
            local onSlotItem <const> = self:getItemBy({ slot = data.toSlot })
            if onSlotItem then
                return ScriptShared:createRet({ success = false, response = "item_can_not_stack"  })
            end

            self.items[#self.items+1] = {
                name = data.name,
                quantity = data.quantity,
                meta = data.meta,
                slot = data.toSlot,
                data = iData,
                itemHash = self:generateUniqueItemHash()
            }
            self:OnItemAdded(self.items[#self.items])
            return ScriptShared:createRet({ success = true, response = "item_added_on_new_slot", item = self.items[#self.items] })            
        end
    else
        if iData.stackable then
            local existItem <const> = self:getItemBy({ name = data.name })
            if existItem then
                existItem.quantity += data.quantity

                self:OnItemUpdated(existItem)
                return ScriptShared:createRet({ success = true, response = "added_item_on_stack", item = existItem })
            else
                local newEmptySlot = self:getEmptySlot()
                if type(newEmptySlot) ~= "number" then
                    return ScriptShared:createRet({ success = false, response = "no_empty_slot_found" })
                end

                self.items[#self.items+1] = {
                    name = data.name,
                    quantity = data.quantity,
                    meta = data.meta,
                    slot = newEmptySlot,
                    data = iData,
                    itemHash = self:generateUniqueItemHash()
                }

                self:OnItemAdded(self.items[#self.items])
                return ScriptShared:createRet({ success = true, response = "item_added_on_new_slot", item = self.items[#self.items] })
            end
        else
            local newEmptySlot = self:getEmptySlot()
            if type(newEmptySlot) ~= "number" then
                return ScriptShared:createRet({ success = false, response = "no_empty_slot_found" })
            end

            self.items[#self.items+1] = {
                name = data.name,
                quantity = 1,
                meta = data.meta,
                slot = newEmptySlot,
                data = iData,
                itemHash = self:generateUniqueItemHash()
            }
            self:OnItemAdded(self.items[#self.items])
            return ScriptShared:createRet({ success = true, response = "item_added_on_new_slot", item = self.items[#self.items] })
        end
    end
end

--- Remove item(s) with the findBy options.
---@param quantity number | nil
---@param findBy findByOptions
function Module:removeItemBy(quantity, findBy)
    if type(quantity) ~= "number" then quantity = 1 end

    local ret = ScriptShared:createRet({ success = false, response = "failed_to_remove" })

    for i = 1, #self.items, 1 do
        local v = self.items[i]
        local checker <const> = self:findByChecker(v, findBy)
        if checker then
            local no_ref <const> = json.decode(json.encode(v))

            if v.data.stackable then
                if v.quantity >= quantity then
                    v.quantity -= quantity

                    if v.quantity < 1 then
                        table.remove(self.items, i)
                        ret.success = true
                        ret.response = "removed"

                        self:OnItemRemoved(no_ref)

                        break
                    else
                        ret.success = true
                        ret.response = "updated_quantity"

                        self:OnItemUpdated(v)

                        break
                    end
               end
            else
                table.remove(self.items, i)

                ret.success = true
                ret.response = "removed"

                self:OnItemRemoved(no_ref)

                break
            end
        end
    end

    return ScriptShared:createRet(ret)
end

---@param item InventoryItem
function Module:OnItemRemoved(item)
    for observerSource in pairs(self.observers) do
        TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", observerSource, {
            event = "REMOVE_INVENTORY_ITEM",
            uniqueID = self.uniqueID,
            itemHash = item.itemHash
        })
    end
    TriggerEvent("Inventory:onItemRemoved", self.uniqueID, item)
end

---@param item InventoryItem
function Module:OnItemUpdated(item)
    for observerSource in pairs(self.observers) do
        TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", observerSource, {
            event = "UPDATE_INVENTORY_ITEM",
            uniqueID = self.uniqueID,
            itemHash = item.itemHash,
            item = item
        })
    end
end

---@param item InventoryItem
function Module:OnItemAdded(item)
    for observerSource in pairs(self.observers) do
        TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", observerSource, {
            event = "UPDATE_INVENTORY_ITEM",
            uniqueID = self.uniqueID,
            itemHash = item.itemHash,
            item = item
        })
    end
    TriggerEvent("Inventory:onItemAdded", self.uniqueID, item)
end

--- Only checks the inventory weight is okey to add the item or not.
---@param name string
---@param quantity number
function Module:canCarryWeight(name, quantity)
    local iData <const> = ScriptShared.Items:Get(name)
    if not iData then return end

    if type(quantity) ~= "number" or quantity < 1 or not iData.stackable then quantity = 1 end

    if self:getWeight() + (iData.weight * quantity) > self.maxWeight then return end

    return true
end

function Module:canCarryItem(name, quantity)
    if not self:canCarryWeight(name, quantity) then return false end
    
    local slot = self:getEmptySlot()
    if type(slot) == "number" then
        return true
    end

    return false
end

---@param anotherInventory BaseInventory
function Module:isSame(anotherInventory)
    return self.uniqueID == anotherInventory.uniqueID
end

-- Deletes all items from the inventory, even the non deletable items.
function Module:clear()
    for i = #self.items, 1, -1 do
        local v <const> = self.items[i]
        if v then
            self:removeItemBy(v.quantity, { itemHash = v.itemHash })
        end
    end
    return true
end

-- Deletes the inventory from the server cache.
function Module:destroy()
    if ScriptServer.Managers.Inventory.Inventories[self.uniqueID] then
        ScriptServer.Managers.Inventory.Inventories[self.uniqueID] = nil
    end
end

---@async
function Module:save()
    ---@type InventoryItem[]
    local format = {}
    for i = 1, #self.items, 1 do
        local v = self.items[i]
        format[#format+1] = {
            name = v.name,
            quantity = v.quantity,
            slot = v.slot,
            meta = v.meta,
            itemHash = v.itemHash
        }
    end

    MySQL.query.await([[
        INSERT INTO inventory_items (uniqueID, type, items)
        VALUES (@uniqueID, @type, @items)
        ON DUPLICATE KEY UPDATE
        uniqueID = @uniqueID,
        type = @type,
        items = @items
    ]], {
        ["@uniqueID"] = self.uniqueID,
        ["@type"] = self.type,
        ["@items"] = json.encode(format)
    })
end

---@class DroppedInventory:BaseInventory
---@field originX number
---@field originY number
---@field originZ number
---@field objects table<string, number> Stored with itemHash -> ObjectHandle
---@field expires number
local Module <const> = setmetatable({}, { __index = ScriptServer.Classes.BaseInventory })

ScriptServer.Classes.DroppedInventory = Module

---@class DroppedInventoryClassCreateInterface:BaseInventoryClassCreateInterface
---@field originX number
---@field originY number
---@field originZ number
---@field expires number

---@param data DroppedInventoryClassCreateInterface
Module.new = function(data)
    data.type = "dropped_grid"

    local self = setmetatable(
        ScriptServer.Classes.BaseInventory.new(data),
        { __index = Module }
    ) --[[@as DroppedInventory]]

    self.originX = data.originX
    self.originY = data.originY
    self.originZ = data.originZ
    self.objects = {}
    self.expires = data.expires

    local isExpired = self:checkExpired()
    if isExpired then return end

    for i = 1, #self.items do
        local v = self.items[i]
        self:createObjectIfNotExist(v)
    end

    ScriptServer.Managers.Dropped.Grids[self.uniqueID] = self

    return self
end

function Module:checkExpired()
    if os.time() > self.expires then
        self:destroyGrid()
        return true
    end
end

function Module:destroyGrid()
    exports["oxmysql"]:query_async("DELETE FROM inventory_items WHERE uniqueID = ?", {
        self.uniqueID
    })

    self:triggerObservers(function(source)
        self:close(source)
    end)

    ScriptServer.Managers.Dropped.Grids[self.uniqueID] = nil
end

function Module:open(source)
    if self:hasObserver(source) then return end

    self:addObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "ADD_OPENED_INVENTORY",
        uniqueID = self.uniqueID,
        items = self.items,
        maxWeight = self.maxWeight,
        inventoryName = self.inventoryName,
        slotsAmount = self.slotsAmount
    })
end

function Module:close(source)
    if not self:hasObserver(source) then return end

    self:removeObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "REMOVE_OPENED_INVENTORY",
        uniqueID = self.uniqueID
    })
end

---@param item InventoryItem
function Module:OnItemAdded(item)
    self.__index.OnItemAdded(self, item)

    self:createObjectIfNotExist(item)
end

---@param item InventoryItem
function Module:OnItemUpdated(item)
    self.__index.OnItemUpdated(self, item)

    self:createObjectIfNotExist(item)
end

---@param item InventoryItem
function Module:OnItemRemoved(item)
    self.__index.OnItemRemoved(self, item)

    self:removeObjectIfExist(item)

    -- Delete the drop grid if less then one item is in here.
    if #self.items < 1 then
        self:destroyGrid()
    end
end

---@class AddDropInterface:AddItemInterface
---@field coordX number
---@field coordY number
---@field coordZ number

---@param data AddDropInterface
function Module:addItem(data)
    local addedResult = self.__index.addItem(self, data)

    if addedResult.success then
        addedResult.item.coordX = data.coordX
        addedResult.item.coordY = data.coordY
        addedResult.item.coordZ = data.coordZ
        self:OnItemUpdated(addedResult.item)
    end

    return addedResult
end

---@param item InventoryItem
function Module:createObjectIfNotExist(item)
    -- Create object if not exist.
    if not self.objects[item.itemHash] then
        if type(item.coordX) == "number" and type(item.coordY) == "number" and type(item.coordZ) == "number" then
            local iData = ScriptShared.Items:Get(item.name)

            local dropModel = GM.Inventory.DROPPED_ITEMS.DEFAULT_DROPPED_MODEL
            if type(iData.droppedModel) == "number" then
                dropModel = iData.droppedModel
            end

            local obj = CreateObjectNoOffset(
                dropModel,
                item.coordX,
                item.coordY,
                item.coordZ,
                true,
                true,
                true
            )
            while not DoesEntityExist(obj) do
                Citizen.Wait(10)
            end

            Entity(obj).state.dropped_item = true

            self.objects[item.itemHash] = obj
        end
    end
end

---@param item InventoryItem
function Module:removeObjectIfExist(item)
    if self.objects[item.itemHash] and DoesEntityExist(self.objects[item.itemHash]) then
        DeleteEntity(self.objects[item.itemHash])
        self.objects[item.itemHash] = nil
    end
end

---@async
function Module:save()
    if #self.items < 1 then return end

    ---@type InventoryItem[]
    local format = {}
    for i = 1, #self.items, 1 do
        local v = self.items[i]
        format[#format + 1] = {
            name = v.name,
            quantity = v.quantity,
            slot = v.slot,
            meta = v.meta,
            itemHash = v.itemHash,
            coordX = v.coordX,
            coordY = v.coordY,
            coordZ = v.coordZ
        }
    end

    MySQL.query.await([[
        INSERT INTO inventory_items (uniqueID, type, originX, originY, originZ, expires, items)
        VALUES (@uniqueID, @type, @originX, @originY, @originZ, @expires, @items)
        ON DUPLICATE KEY UPDATE
        uniqueID = @uniqueID,
        type = @type,
        originX = @originX,
        originY = @originY,
        originZ = @originZ,
        expires = @expires,
        items = @items
    ]], {
        ["@uniqueID"] = self.uniqueID,
        ["@type"] = self.type,
        ["@originX"] = self.originX,
        ["@originY"] = self.originY,
        ["@originZ"] = self.originZ,
        ["@expires"] = self.expires,
        ["@items"] = json.encode(format)
    })
end

---@class FactionInventory:BaseInventory
---@field faction string
---@field safeCoords vector3
---@field safeHeading number
---@field safeHandle API_Server_ObjectBase | nil
local Module <const> = setmetatable({}, { __index = ScriptServer.Classes.BaseInventory })

ScriptServer.Classes.FactionInventory = Module

---@class FactionInventoryClassCreateInterface:BaseInventoryClassCreateInterface
---@field faction string
---@field safeCoords vector3
---@field safeHeading number

---@param data FactionInventoryClassCreateInterface
Module.new = function(data)
    data.type = "faction"

    local self = setmetatable(
        ScriptServer.Classes.BaseInventory.new(data),
        { __index = Module }
    )

    self.faction = data.faction
    self.safeCoords = data.safeCoords
    self.safeHeading = data.safeHeading

    -- self.safeHandle = createObject({
    --     dimension = 0,
    --     model = GM.Inventory.FACTION_SAFE_OBJECT_MODEL,
    --     rx = 0.0,
    --     ry = 0.0,
    --     rz = self.safeHeading,
    --     x = self.safeCoords.x,
    --     y = self.safeCoords.y,
    --     z = self.safeCoords.z
    -- })

    return self
end

function Module:isFactionMember(source)
    local player <const> = ESX.GetPlayerFromId(source)
    if not player then return end

    return player:getJobName() == self.faction
end

function Module:open(source)
    if self:hasObserver(source) then return end
    if not self:isFactionMember(source) then return end

    self:addObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "ADD_OPENED_INVENTORY",
        uniqueID = self.uniqueID,
        items = self.items,
        maxWeight = self.maxWeight,
        inventoryName = self.inventoryName,
        slotsAmount = self.slotsAmount
    })
end

function Module:close(source)
    if not self:hasObserver(source) then return end

    self:removeObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "REMOVE_OPENED_INVENTORY",
        uniqueID = self.uniqueID
    })
end

---@class GloveboxInventory:BaseInventory
---@field plate string
local Module <const> = setmetatable({}, { __index = ScriptServer.Classes.BaseInventory })

ScriptServer.Classes.GloveboxInventory = Module

---@class GloveboxInventoryClassCreateInterface:BaseInventoryClassCreateInterface
---@field plate string

---@param data GloveboxInventoryClassCreateInterface
Module.new = function(data)
    data.type = "BOITE A GANT"

    local self = setmetatable(
        ScriptServer.Classes.BaseInventory.new(data),
        { __index = Module }
    )

    self.plate = data.plate

    return self --[[@as GloveboxInventory]]
end

function Module:open(source)
    if self:hasObserver(source) then return end

    self:addObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "ADD_OPENED_INVENTORY",
        uniqueID = self.uniqueID,
        items = self.items,
        maxWeight = self.maxWeight,
        inventoryName = self.inventoryName,
        slotsAmount = self.slotsAmount
    })
end

function Module:close(source)
    if not self:hasObserver(source) then return end

    self:removeObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "REMOVE_OPENED_INVENTORY",
        uniqueID = self.uniqueID
    })
end

---@class PlayerInventory:BaseInventory
---@field source number
---@field usedWeaponItemHash string
local Module <const> = setmetatable({}, { __index = ScriptServer.Classes.BaseInventory })

ScriptServer.Classes.PlayerInventory = Module

---@class PlayerInventoryClassCreateInterface:BaseInventoryClassCreateInterface
---@field source number

---@param data PlayerInventoryClassCreateInterface
Module.new = function(data)
    data.type = "player"

    local self = setmetatable(
        ScriptServer.Classes.BaseInventory.new(data),
        { __index = Module }
    ) --[[@as PlayerInventory]]

    self.source = data.source
    self.usedWeaponItemHash = nil

    local player <const> = ESX.GetPlayerFromId(source)
    if player then
        TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", self.source, {
            event = "SET_PLAYER_HEADER",
            playerHeader = string.format("%s (%d)", player:getName(), self.source)
        })
    end

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", self.source, {
        event = "ADD_OPENED_INVENTORY",
        uniqueID = self.uniqueID,
        items = self.items,
        maxWeight = self.maxWeight,
        inventoryName = self.inventoryName,
        slotsAmount = self.slotsAmount,
        isLocal = true
    })

    self:addObserver(self.source)
    TriggerClientEvent("Inventory:setPlayerInventoryItems", self.source, self.items)

    return self
end

---@param item InventoryItem
function Module:OnItemUpdated(item)
    self.__index.OnItemUpdated(self, item)

    TriggerClientEvent("Inventory:onPlayerItemUpdated", self.source, item)

    if self.usedWeaponItemHash == item.itemHash then
        TriggerClientEvent("Inventory:updateCurrentWeapon", self.source, item)
    end
end

---@param item InventoryItem
function Module:OnItemAdded(item)
    self.__index.OnItemAdded(self, item)

    TriggerClientEvent("Inventory:onPlayerItemAdded", self.source, item)
end

---@param item InventoryItem
function Module:OnItemRemoved(item)
    self.__index.OnItemRemoved(self, item)

    TriggerClientEvent("Inventory:onPlayerItemRemoved", self.source, item)

    if self.usedWeaponItemHash == item.itemHash then
        self:DisarmWeapon()
    end
end

-- This is for frisking the inventory.
function Module:open(source)
    if self:hasObserver(source) then return end

    self:addObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "ADD_OPENED_INVENTORY",
        uniqueID = self.uniqueID,
        items = self.items,
        maxWeight = self.maxWeight,
        inventoryName = self.inventoryName,
        slotsAmount = self.slotsAmount,
        isLocal = false
    })
end

-- Closing the frisking.
function Module:close(source)
    if not self:hasObserver(source) then return end

    self:removeObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "REMOVE_OPENED_INVENTORY",
        uniqueID = self.uniqueID
    })
end

---@param item InventoryItem
function Module:UseWeaponItem(item)
    if self.usedWeaponItemHash == item.itemHash then
        self:DisarmWeapon()
    else
        self:EquipWeapon(item)
    end
end

---@param item InventoryItem
function Module:EquipWeapon(item)
    if type(item.meta.durability) == "number" and item.meta.durability < 1 then return end

    self.usedWeaponItemHash = item.itemHash
    TriggerClientEvent("Inventory:equipWeapon", self.source, item)
end

function Module:DisarmWeapon()
    self.usedWeaponItemHash = nil
    TriggerClientEvent("Inventory:disarmWeapon", self.source)
end

function Module:ReduceWeaponDurability()
    if not self.usedWeaponItemHash then return end

    local usedWeapon <const> = self:getItemBy({ itemHash = self.usedWeaponItemHash })
    if not usedWeapon then return end

    if GM.Inventory.AMMO_WEAPONS[usedWeapon.data.weaponHash] or GM.Inventory.MELEE_WEAPONS[usedWeapon.data.weaponHash] then
        local chance <const> = math.random(0, 100)
        if chance < GM.Inventory.REDUCE_WEAPON_DURABILITY_CHANCE then
            local reduceBy <const> = math.random(
                    GM.Inventory.REDUCE_WEAPON_DURABILITY_AMOUNT.MIN,
                    GM.Inventory.REDUCE_WEAPON_DURABILITY_AMOUNT.MAX
                ) / 100

            usedWeapon.meta.durability = (usedWeapon.meta.durability or 100) - reduceBy
        end
    end

    if usedWeapon.meta.durability < 0 then
        usedWeapon.meta.durability = 0
    end

    if usedWeapon.meta.durability <= 0 then
        self:DisarmWeapon()

        if GM.Inventory.DELETE_WEAPON_ON_DURABILITY_ZERO then
            -- Delete weapon if durability reached zero.
            self:removeItemBy(nil, { itemHash = usedWeapon.itemHash })
            return -- Important return here!!
        end
    end

    self:OnItemUpdated(usedWeapon)
end

---@class StashInventory:BaseInventory
---@field isPublic? boolean
---@field ownerLicense? string
---@field groups? { [string]: number }
---@field isPermanent? boolean
local Module <const> = setmetatable({}, { __index = ScriptServer.Classes.BaseInventory })

ScriptServer.Classes.StashInventory = Module

---@class StashInventoryClassCreateInterface:BaseInventoryClassCreateInterface
---@field isPublic? boolean
---@field ownerLicense? string
---@field groups? { [string]: number }
---@field isPermanent? boolean

---@param data StashInventoryClassCreateInterface
Module.new = function(data)
    data.type = "stash"

    local self = setmetatable(
        ScriptServer.Classes.BaseInventory.new(data),
        { __index = Module }
    )

    self.isPublic = data.isPublic
    self.ownerLicense = data.ownerLicense
    self.groups = data.groups
    self.isPermanent = data.isPermanent

    return self --[[@as StashInventory]]
end

function Module:hasPermission(source)
    if self.isPublic then return true end

    local player <const> = ESX.GetPlayerFromId(source)
    if not player then return end

    if type(self.ownerLicense) == "string" then
        return player:getIdentifier() == self.ownerLicense
    end

    if type(self.groups) == "table" and #self.groups > 0 then
        local playerFaction = player:getJobName()
        local playerFactionGrade = player:getJobGrade()

        for k, v in pairs(self.groups) do
            if playerFaction == k and playerFactionGrade >= v then
                return true
            end
        end
    end

    return false
end

function Module:open(source)
    if self:hasObserver(source) then return end
    if not self:hasPermission(source) then return end

    self:addObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "ADD_OPENED_INVENTORY",
        uniqueID = self.uniqueID,
        items = self.items,
        maxWeight = self.maxWeight,
        inventoryName = self.inventoryName,
        slotsAmount = self.slotsAmount
    })
end

function Module:close(source)
    if not self:hasObserver(source) then return end

    self:removeObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "REMOVE_OPENED_INVENTORY",
        uniqueID = self.uniqueID
    })
end

function Module:save()
    if not self.isPermanent then return end

    return self.__index.save(self)
end

---@class TrunkInventory:BaseInventory
---@field plate string
local Module <const> = setmetatable({}, { __index = ScriptServer.Classes.BaseInventory })

ScriptServer.Classes.TrunkInventory = Module

---@class TrunkInventoryClassCreateInterface:BaseInventoryClassCreateInterface
---@field plate string

---@param data TrunkInventoryClassCreateInterface
Module.new = function(data)
    data.type = "COFFRE"

    local self = setmetatable(
        ScriptServer.Classes.BaseInventory.new(data),
        { __index = Module }
    )

    self.plate = data.plate

    return self --[[@as TrunkInventory]]
end

function Module:open(source)
    if self:hasObserver(source) then return end

    self:addObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "ADD_OPENED_INVENTORY",
        uniqueID = self.uniqueID,
        items = self.items,
        maxWeight = self.maxWeight,
        inventoryName = self.inventoryName,
        slotsAmount = self.slotsAmount
    })
end

function Module:close(source)
    if not self:hasObserver(source) then return end

    self:removeObserver(source)

    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "REMOVE_OPENED_INVENTORY",
        uniqueID = self.uniqueID
    })
end

local Module <const> = {}
---@type { [string]: ShopClass }
Module.Shops = {}

ScriptServer.Managers.Shops = Module

function Module:GetShop(shopID)
    return self.Shops[shopID] or nil
end

---@class ShopClass:ShopConstructor
---@field blips API_Server_BlipBase[]
---@field peds API_Server_PedBase[]
local Module <const> = {}
Module.__index = Module

ScriptServer.Classes.Shop = Module

---@class ShopConstructor
---@field shopId string
---@field items ShopItem[]
---@field shopName string

---@param allData ShopStaticData
Module.new = function(id, allData)
    local self = setmetatable({}, Module)

    self.shopName = allData.shopName
    self.shopId = id
    self.items = {}

    for i = 1, #allData.items do
        local v = allData.items[i]
        local iData = ScriptShared.Items:Get(v.name)
        if iData then
            self.items[#self.items + 1] = {
                data = iData,
                meta = type(v.meta) == "table" and v.meta or type(iData.defaultMeta) == "table" and iData.defaultMeta or {},
                name = v.name,
                price = v.price
            }
        end
    end

    ScriptServer.Managers.Shops.Shops[self.shopId] = self

    return self
end

function Module:openShop(source)
    TriggerClientEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", source, {
        event = "OPEN_SHOP",
        items = self.items,
        shopId = self.shopId,
        shopName = self.shopName
    })
end

function Module:GetShopItemOnSlot(slot)
    return self.items[slot] or nil
end

local function Init()

    local function loadEsxPlayerInventory(xPlayer)
        ScriptServer.Classes.PlayerInventory.new({
            inventoryName = "INVENTAIRE",
            maxWeight = GM.Inventory.PLAYER_INVENTORY_DEFAULTS.MAX_WEIGHT,
            slotsAmount = GM.Inventory.PLAYER_INVENTORY_DEFAULTS.SLOTS,
            source = xPlayer.source,
            type = "player",
            uniqueID = xPlayer.getIdentifier()
        })
    end

    RegisterNetEvent("esx:playerLoaded", function(playerId, xPlayer, isNew)
        loadEsxPlayerInventory(xPlayer)

        for k, v in pairs(xPlayer.accounts) do
            if (v.name ~= "bank") then
                local currentMoney = exports["believer"]:GetItemQuantityBy(playerId, {
                  name = v.name,
                })
                if (v.money == 0) then
                    exports["believer"]:RemoveItemBy(playerId, currentMoney, {
                        name = v.name,
                    })
                else
                    exports["believer"]:SetItemQuantity(playerId, v.name, v.money)
                end
            end
        end
    end)
end

Init()


RegisterCommand("frisk", function(source, args)
    local targetID = tonumber(args[1])
    local target_inv <const> = ScriptServer.Managers.Inventory:GetInventory({ source = targetID }) --[[@as PlayerInventory]]
    if not target_inv then return end
    target_inv:open(source)
end)

RegisterCommand("loot_1", function(source)
    local inv = ScriptServer.Managers.Inventory:GetInventory({ uniqueID = "random-loot-1" }) --[[@as StashInventory]]
    if not inv then
        inv = ScriptServer.Classes.StashInventory.new({
            isPublic = true,
            isPermanent = true,
            inventoryName = "Loot Box",
            maxWeight = 100,
            slotsAmount = 15,
            uniqueID = "random-loot-1"
        })
    end
    inv:open(source)
end, false)

local function getInventory(inv)
    if type(inv) == "number" then
        return ScriptServer.Managers.Inventory:GetInventory({ source = inv })
    elseif type(inv) == "string" then
        return ScriptServer.Managers.Inventory:GetInventory({ uniqueID = inv })
    end
end

exports("GetInventoryItems", function(inv)
    local inventory = getInventory(inv)
    if inventory then
        return inventory.items
    end
end)

exports("Clear", function(inv)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:clear()
    end
end)

exports("AddItem", function(inv, itemName, quantity, meta)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:addItem({
            name = itemName,
            quantity = quantity,
            meta = meta
        })
    end
end)

exports("SetItemQuantity", function(inv, itemName, quantity)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:setItemQuantity(itemName, quantity)
    end
end)

exports("GetItemBy", function(inv, findBy)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:getItemBy(findBy)
    end
end)

exports("GetItemsBy", function(inv, findBy)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:getItemsBy(findBy)
    end
end)

exports("GetItemQuantityBy", function(inv, findBy)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:getItemQuantityBy(findBy)
    end
end)

exports("GetWeight", function(inv)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:getWeight()
    end
end)

exports("GetInventory", function(inv)
    return getInventory(inv)
end)


exports("CanCarryItem", function(inv, itemName, quantity)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:canCarryItem(itemName, quantity)
    end
end)

exports("RemoveItemBy", function(inv, quantity, findBy)
    local inventory <const> = getInventory(inv)
    if inventory then
        return inventory:removeItemBy(quantity, findBy)
    end
end)

exports("SetDurability", function(inv, findBy, durability)
    local inventory <const> = getInventory(inv)
    if not inventory then return end
    local item <const> = inventory:getItemBy(findBy)
    if not item then return end

    item.meta.durability = durability
    inventory:OnItemUpdated(item)

    return item
end)

exports("SetMetaData", function(inv, findBy, metaData)
    local inventory <const> = getInventory(inv)
    if not inventory then return end
    local item <const> = inventory:getItemBy(findBy)
    if not item then return end

    item.meta = metaData
    inventory:OnItemUpdated(item)
    return item
end)

exports("Save", function(inv)
    local inventory = getInventory(inv)
    if inventory then
        return inventory:save()
    end
end)

exports("SaveAll", function()
    ScriptServer.Managers.Inventory:SaveInventories()
    ScriptServer.Managers.Dropped:SaveDroppeds()
end)

exports("RegisterStash", function(createData)
    return ScriptServer.Classes.StashInventory.new(createData)
end)

exports("OpenStash", function(source, uniqueID)
    local stash <const> = getInventory(uniqueID) --[[@as StashInventory]]
    if stash then
        stash:open(source)
    end
end)

--- This will not delete the items, only deletes the inventory on the server so it can not be opened if its not created again.
exports("DestroyStash", function(uniqueID)
    local inv <const> = getInventory(uniqueID) --[[@as StashInventory]]
    if inv and inv.type == "dropped_grid" then
        inv:triggerObservers(function(source)
            inv:close(source)
        end)
        ScriptServer.Managers.Inventory.Inventories[uniqueID] = nil
    end
end)

exports("FriskTarget", function(source, targetID)
    local target_inv = ScriptServer.Managers.Inventory:GetInventory({ source = targetID }) --[[@as PlayerInventory]]
    if target_inv then
        target_inv:open(source)
    end
end)

exports("GetRegisteredItem", function(itemName)
    return ScriptShared.Items:Get(itemName)
end)
exports("GetRegisteredItems", function()
    return ScriptShared.Items.Registered
end)

AddEventHandler("playerDropped", function()
    local playerSrc = source
    if (not playerSrc) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Armor["player"][playerSelected.source] ~= nil) then
        local item = exports["believer"]:GetItemBy(playerSelected.source, {itemHash = GM.Armor["player"][playerSelected.source]})
        if (item) then
            item.meta.durability = playerSelected.getPedArmor()

            exports["believer"]:SetMetaData(playerSelected.source, { itemHash = GM.Armor["player"][playerSelected.source] }, item.meta)
            playerSelected.setPedArmor(0)

            GM.Armor["player"][playerSelected.source] = nil

            -- exports["believer"]:Save(playerSelected.source)
        end
    end

    exports["believer"]:Save(playerSelected.source)
end)