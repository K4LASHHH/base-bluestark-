ScriptClient = {}
ScriptClient.Enabled = true -- This is for our test server.
ScriptClient.resourceName = GetCurrentResourceName()
ScriptClient.resourceStarted = false
ScriptClient.playerReady = false
ScriptClient.cefLoaded = false
ScriptClient.Player = {}
ScriptClient.Player.State = LocalPlayer.state
ScriptClient.Player.State.inventoryOpened = false
ScriptClient.Player.State.shortkeys = true

RegisterNetEvent("Inventory:SEND_NOTIFICATION")
AddEventHandler("Inventory:SEND_NOTIFICATION", function(jsonContent)
    SEND_NUI_MESSAGE(jsonContent)
end)

SetNuiFocusKeepInput(true)

AddEventHandler("onClientResourceStart", function(resourceName)
    if ScriptClient.resourceName ~= resourceName then return end

    ScriptClient.resourceStarted = true
end)

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end

    ScriptClient.playerReady = true

    while not (ScriptClient.playerReady and ScriptClient.resourceStarted and ScriptClient.cefLoaded) do
        Citizen.Wait(100)
    end

    Citizen.Wait(4000)

    TriggerServerEvent("Inventory:CLIENT_LOADED")
end)

function SEND_NUI_MESSAGE(d)
    while not ScriptClient.cefLoaded do
        Citizen.Wait(100)
    end

    SendNUIMessage(d)
end

RegisterNetEvent("Inventory:PLAYER_SEND_NUI_MESSAGE", SEND_NUI_MESSAGE)

RegisterNUICallback("CEF_LOADED", function(_, cb)
    ScriptClient.cefLoaded = true
    cb({})
end)

---@type number | nil
local inventoryOpenedThreadId = nil

RegisterNUICallback("CLIENT_SET_INTERFACE_STATE", function(d, cb)
    local state = d.state

    ScriptClient.Player.State.inventoryOpened = state
    SetNuiFocus(state, state)

    if state then
        TriggerEvent("Inventory:onInventoryOpen")
        TriggerServerEvent("Inventory:onInventoryOpen")
        TriggerServerEvent("Inventory:OPEN_NEAR_DROPPED_GRID")

        if inventoryOpenedThreadId == nil then
            Citizen.CreateThreadNow(function(id)
                inventoryOpenedThreadId = id

                while inventoryOpenedThreadId ~= nil do
                    DisableAllControlActions(0)
                    EnableControlAction(0, 30, true)
                    EnableControlAction(0, 31, true)
                    Citizen.Wait(0)
                end
            end)
        end
    else
        TriggerEvent("Inventory:onInventoryClose")
        TriggerServerEvent("Inventory:onInventoryClose")

        if inventoryOpenedThreadId ~= nil then
            inventoryOpenedThreadId = nil
        end
    end

    cb({})
end)

RegisterNetEvent("Inventory:openInventory", function()
    if not ScriptClient.Enabled then return end

    SEND_NUI_MESSAGE({
        event = "SET_INTERFACE_OPEN",
        state = not ScriptClient.Player.State.inventoryOpened
    })
end)

RegisterCommand('OPEN_INVENTORY', function()
    if not ScriptClient.Enabled then return end

    SEND_NUI_MESSAGE({
        event = "SET_INTERFACE_OPEN",
        state = not ScriptClient.Player.State.inventoryOpened
    })
end, false)
RegisterKeyMapping('OPEN_INVENTORY', 'Open Inventory', 'keyboard', 'f2')

local shortkeysOpened = false
RegisterCommand("+SHOW_HIDE_SHORTKEY_ITEMS", function()
    if not ScriptClient.Enabled then return end

    shortkeysOpened = true

    Citizen.CreateThreadNow(function(id)
        while shortkeysOpened do
            DisableControlAction(0, 37, true)
            Citizen.Wait(1)
        end
    end)

    SEND_NUI_MESSAGE({
        event = "SHORTKEYS_STATE",
        state = true
    })
end, false)
RegisterCommand("-SHOW_HIDE_SHORTKEY_ITEMS", function()
    if not ScriptClient.Enabled then return end

    shortkeysOpened = false

    SEND_NUI_MESSAGE({
        event = "SHORTKEYS_STATE",
        state = false
    })
end, false)
RegisterKeyMapping('+SHOW_HIDE_SHORTKEY_ITEMS', 'Show/Hide Shortkey Items', 'keyboard', "tab")

RegisterNUICallback("ITEM_MOVE_TO_SLOT", function(d, cb)
    TriggerServerEvent("Inventory:ITEM_MOVE_TO_SLOT", d)
    cb({})
end)
RegisterNUICallback("ADD_NOTE_ITEM", function(d, cb)
    TriggerServerEvent("Inventory:ADD_NOTE_ITEM", d)
    cb({})
end)
RegisterNUICallback("RENAME_ITEM", function(d, cb)
    TriggerServerEvent("Inventory:RENAME_ITEM", d)
    cb({})
end)
RegisterNUICallback("USE_ITEM", function(d, cb)
    TriggerServerEvent("Inventory:USE_ITEM", d)
    cb({})
end)
RegisterNUICallback("BUY_FROM_SHOP", function(d, cb)
    TriggerServerEvent("Inventory:BUY_FROM_SHOP", d)
    cb({})
end)
RegisterNUICallback("ITEM_ADD_ATTACHMENT_WEAPON", function(d, cb)
    TriggerServerEvent("Inventory:ITEM_ADD_ATTACHMENT_WEAPON", d)
    cb({})
end)
RegisterNUICallback("ITEM_REMOVE_ATTACHMENT_WEAPON", function(d, cb)
    TriggerServerEvent("Inventory:ITEM_REMOVE_ATTACHMENT_WEAPON", d)
    cb({})
end)
RegisterNUICallback("CLOSE_SECOND_INVENTORY", function(d, cb)
    local uniqueID = d.uniqueID
    TriggerServerEvent("Inventory:CLOSE_SECOND_INVENTORY", uniqueID)
    cb({})
end)
RegisterNUICallback("NEARBY_GET_PLAYERS", function(_, cb)
    local localPlayer = PlayerPedId()
    local playerPos = GetEntityCoords(localPlayer)
    local players = GetActivePlayers()

    local nearPlayers = {}

    for k, v in pairs(players) do
        local ped = GetPlayerPed(v)
        if ped ~= localPlayer then
            local dist = #(playerPos - GetEntityCoords(ped))
            if dist < GM.Inventory.NEARBY_PLAYER_RANGE then
                local name = nil
                if GM.Inventory.NEARBY_PLAYERS_SHOW_NAMES then
                    name = GetPlayerName(v)
                end

                nearPlayers[#nearPlayers + 1] = {
                    serverId = GetPlayerServerId(v),
                    name = name
                }
            end
        end
    end

    if #nearPlayers < 1 then
        TriggerEvent("Inventory:SEND_NOTIFICATION", {
			event = "SEND_NOTIFICATION",
			type = "info",
			message = "Aucun joueur à proximité !"
		})
    end

    cb(nearPlayers)
end)
RegisterNUICallback("GIVE_ITEM_TO_TARGET", function(d, cb)
    TriggerServerEvent("Inventory:GIVE_ITEM_TO_TARGET", d)
    cb({})
end)
RegisterNUICallback("DROP_ITEM_ON_GROUND", function(d, cb)
    TriggerServerEvent("Inventory:DROP_ITEM_ON_GROUND", d)
    cb({})
end)

local Vehicles = {}

function Vehicles:openNearTrunks()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closeVehicleNetIds = {}

    if GetVehiclePedIsIn(playerPed, false) ~= 0 then return end

    local vehiclePool = GetGamePool('CVehicle')
    for i = 1, #vehiclePool do
        local veh = vehiclePool[i]
        local vehCoords = GetEntityCoords(veh)
        local dist = #(playerCoords - vehCoords)
        if dist < 5.0 and GetVehicleDoorLockStatus(veh) == 1 then
            closeVehicleNetIds[#closeVehicleNetIds + 1] = NetworkGetNetworkIdFromEntity(veh)
        end
    end

    if #closeVehicleNetIds > 0 then
        TriggerServerEvent("Inventory:OPEN_NEAR_TRUNKS", closeVehicleNetIds)
    end
end

function Vehicles:openGlovebox()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if DoesEntityExist(vehicle) then
            TriggerServerEvent("Inventory:OPEN_VEHICLE_GLOVEBOX_INVENTORY")
        end
    end
end

AddEventHandler("Inventory:onInventoryOpen", function()
    Vehicles:openGlovebox()
    Vehicles:openNearTrunks()
end)

local Factions = {}

function Factions:openNearSafes()
    local localPlayer = PlayerPedId()
    local playerCoords = GetEntityCoords(localPlayer)

    local closeToAny = false

    for k, v in pairs(GM.Inventory.FACTION_INVENTORIES) do
        local safeCoords = vector3(v.x, v.y, v.z)

        local dist = #(playerCoords - safeCoords)
        if dist < GM.Inventory.FACTION_SAFE_OPEN_RANGE then
            closeToAny = true
            break
        end
    end

    if closeToAny then
        TriggerServerEvent("Inventory:OPEN_NEAR_FACTION_SAFES")
    end
end

AddEventHandler("Inventory:onInventoryOpen", function()
    Factions:openNearSafes()
end)

AddEventHandler("Inventory:onInventoryClose", function()

end)

---@param tbl table
---@param one number
---@param two number
---@param single? boolean
local function addVariation(tbl, one, two, single)
    if not single then
        tbl[one] = two
        tbl[two] = one
    else
        tbl[one] = two
    end
end

Variations = {
    Bag = {
        male = {},
        female = {}
    },
    Top = {
        male = {},
        female = {}
    },
    Visor = {
        male = {},
        female = {}
    },
    Hair = {
        male = {},
        female = {}
    },
    Gloves = {
        male = {},
        female = {}
    }
}

-- [[ BAGS (5) ]] --
-- MALE
addVariation(Variations.Bag.male, 45, 44)
addVariation(Variations.Bag.male, 41, 40)
-- FEMALE
addVariation(Variations.Bag.female, 45, 44)
addVariation(Variations.Bag.female, 41, 40)
-- [[ Top (11) ]] --
-- MALE
addVariation(Variations.Top.male, 29, 30)
addVariation(Variations.Top.male, 31, 32)
addVariation(Variations.Top.male, 42, 43)
addVariation(Variations.Top.male, 68, 69)
addVariation(Variations.Top.male, 74, 75)
addVariation(Variations.Top.male, 87, 88)
addVariation(Variations.Top.male, 99, 100)
addVariation(Variations.Top.male, 101, 102)
addVariation(Variations.Top.male, 103, 104)
addVariation(Variations.Top.male, 126, 127)
addVariation(Variations.Top.male, 129, 130)
addVariation(Variations.Top.male, 184, 185)
addVariation(Variations.Top.male, 188, 189)
addVariation(Variations.Top.male, 194, 195)
addVariation(Variations.Top.male, 196, 197)
addVariation(Variations.Top.male, 198, 199)
addVariation(Variations.Top.male, 200, 203)
addVariation(Variations.Top.male, 202, 205)
addVariation(Variations.Top.male, 206, 207)
addVariation(Variations.Top.male, 210, 211)
addVariation(Variations.Top.male, 217, 218)
addVariation(Variations.Top.male, 229, 230)
addVariation(Variations.Top.male, 232, 233)
addVariation(Variations.Top.male, 251, 253)
addVariation(Variations.Top.male, 256, 261)
addVariation(Variations.Top.male, 262, 263)
addVariation(Variations.Top.male, 265, 266)
addVariation(Variations.Top.male, 267, 268)
addVariation(Variations.Top.male, 279, 280)
addVariation(Variations.Top.male, 301, 302)
-- FEMALE
addVariation(Variations.Top.female, 53, 52)
addVariation(Variations.Top.female, 57, 58)
addVariation(Variations.Top.female, 62, 63)
addVariation(Variations.Top.female, 90, 91)
addVariation(Variations.Top.female, 92, 93)
addVariation(Variations.Top.female, 94, 95)
addVariation(Variations.Top.female, 187, 186)
addVariation(Variations.Top.female, 190, 191)
addVariation(Variations.Top.female, 196, 197)
addVariation(Variations.Top.female, 198, 199)
addVariation(Variations.Top.female, 200, 201)
addVariation(Variations.Top.female, 202, 205)
addVariation(Variations.Top.female, 204, 207)
addVariation(Variations.Top.female, 210, 211)
addVariation(Variations.Top.female, 214, 215)
addVariation(Variations.Top.female, 227, 228)
addVariation(Variations.Top.female, 239, 240)
addVariation(Variations.Top.female, 242, 243)
addVariation(Variations.Top.female, 259, 261)
addVariation(Variations.Top.female, 265, 270)
addVariation(Variations.Top.female, 271, 272)
addVariation(Variations.Top.female, 274, 275)
addVariation(Variations.Top.female, 276, 277)
addVariation(Variations.Top.female, 292, 293)
-- [[ Visor ]] --
-- MALE
addVariation(Variations.Visor.male, 9, 10)
addVariation(Variations.Visor.male, 18, 67)
addVariation(Variations.Visor.male, 82, 67)
addVariation(Variations.Visor.male, 44, 45)
addVariation(Variations.Visor.male, 50, 68)
addVariation(Variations.Visor.male, 51, 69)
addVariation(Variations.Visor.male, 52, 70)
addVariation(Variations.Visor.male, 53, 71)
addVariation(Variations.Visor.male, 62, 72)
addVariation(Variations.Visor.male, 65, 66)
addVariation(Variations.Visor.male, 73, 74)
addVariation(Variations.Visor.male, 76, 77)
addVariation(Variations.Visor.male, 79, 78)
addVariation(Variations.Visor.male, 80, 81)
addVariation(Variations.Visor.male, 91, 92)
addVariation(Variations.Visor.male, 104, 105)
addVariation(Variations.Visor.male, 109, 110)
addVariation(Variations.Visor.male, 116, 117)
addVariation(Variations.Visor.male, 118, 119)
addVariation(Variations.Visor.male, 123, 124)
addVariation(Variations.Visor.male, 125, 126)
addVariation(Variations.Visor.male, 127, 128)
addVariation(Variations.Visor.male, 130, 131)
-- FEMALE
addVariation(Variations.Visor.female, 43, 44)
addVariation(Variations.Visor.female, 49, 67)
addVariation(Variations.Visor.female, 64, 65)
addVariation(Variations.Visor.female, 65, 64)
addVariation(Variations.Visor.female, 51, 69)
addVariation(Variations.Visor.female, 50, 68)
addVariation(Variations.Visor.female, 52, 70)
addVariation(Variations.Visor.female, 62, 71)
addVariation(Variations.Visor.female, 72, 73)
addVariation(Variations.Visor.female, 75, 76)
addVariation(Variations.Visor.female, 78, 77)
addVariation(Variations.Visor.female, 79, 80)
addVariation(Variations.Visor.female, 18, 66)
addVariation(Variations.Visor.female, 66, 81)
addVariation(Variations.Visor.female, 81, 66)
addVariation(Variations.Visor.female, 86, 84)
addVariation(Variations.Visor.female, 90, 91)
addVariation(Variations.Visor.female, 103, 104)
addVariation(Variations.Visor.female, 108, 109)
addVariation(Variations.Visor.female, 115, 116)
addVariation(Variations.Visor.female, 117, 118)
addVariation(Variations.Visor.female, 122, 123)
addVariation(Variations.Visor.female, 124, 125)
addVariation(Variations.Visor.female, 126, 127)
addVariation(Variations.Visor.female, 129, 130)
-- [[ Hair ]] --
-- MALE
addVariation(Variations.Hair.male, 7, 15, true)
addVariation(Variations.Hair.male, 43, 15, true)
addVariation(Variations.Hair.male, 9, 43, true)
addVariation(Variations.Hair.male, 11, 43, true)
addVariation(Variations.Hair.male, 15, 43, true)
addVariation(Variations.Hair.male, 16, 43, true)
addVariation(Variations.Hair.male, 17, 43, true)
addVariation(Variations.Hair.male, 20, 43, true)
addVariation(Variations.Hair.male, 22, 43, true)
addVariation(Variations.Hair.male, 45, 43, true)
addVariation(Variations.Hair.male, 47, 43, true)
addVariation(Variations.Hair.male, 49, 43, true)
addVariation(Variations.Hair.male, 51, 43, true)
addVariation(Variations.Hair.male, 52, 43, true)
addVariation(Variations.Hair.male, 53, 43, true)
addVariation(Variations.Hair.male, 56, 43, true)
addVariation(Variations.Hair.male, 58, 43, true)
-- FEMALE
addVariation(Variations.Hair.female, 1, 49, true)
addVariation(Variations.Hair.female, 2, 49, true)
addVariation(Variations.Hair.female, 7, 49, true)
addVariation(Variations.Hair.female, 9, 49, true)
addVariation(Variations.Hair.female, 10, 49, true)
addVariation(Variations.Hair.female, 11, 48, true)
addVariation(Variations.Hair.female, 14, 53, true)
addVariation(Variations.Hair.female, 15, 42, true)
addVariation(Variations.Hair.female, 21, 42, true)
addVariation(Variations.Hair.female, 23, 42, true)
addVariation(Variations.Hair.female, 31, 53, true)
addVariation(Variations.Hair.female, 39, 49, true)
addVariation(Variations.Hair.female, 40, 49, true)
addVariation(Variations.Hair.female, 42, 53, true)
addVariation(Variations.Hair.female, 45, 49, true)
addVariation(Variations.Hair.female, 48, 49, true)
addVariation(Variations.Hair.female, 49, 48, true)
addVariation(Variations.Hair.female, 52, 53, true)
addVariation(Variations.Hair.female, 53, 42, true)
addVariation(Variations.Hair.female, 54, 55, true)
addVariation(Variations.Hair.female, 59, 42, true)
addVariation(Variations.Hair.female, 59, 54, true)
addVariation(Variations.Hair.female, 68, 53, true)
addVariation(Variations.Hair.female, 76, 48, true)
-- [[ Gloves ]] --
-- MALE
addVariation(Variations.Gloves.male, 16, 4, true)
addVariation(Variations.Gloves.male, 17, 4, true)
addVariation(Variations.Gloves.male, 18, 4, true)
addVariation(Variations.Gloves.male, 19, 0, true)
addVariation(Variations.Gloves.male, 20, 1, true)
addVariation(Variations.Gloves.male, 21, 2, true)
addVariation(Variations.Gloves.male, 22, 4, true)
addVariation(Variations.Gloves.male, 23, 5, true)
addVariation(Variations.Gloves.male, 24, 6, true)
addVariation(Variations.Gloves.male, 25, 8, true)
addVariation(Variations.Gloves.male, 26, 11, true)
addVariation(Variations.Gloves.male, 27, 12, true)
addVariation(Variations.Gloves.male, 28, 14, true)
addVariation(Variations.Gloves.male, 29, 15, true)
addVariation(Variations.Gloves.male, 30, 0, true)
addVariation(Variations.Gloves.male, 31, 1, true)
addVariation(Variations.Gloves.male, 32, 2, true)
addVariation(Variations.Gloves.male, 33, 4, true)
addVariation(Variations.Gloves.male, 34, 5, true)
addVariation(Variations.Gloves.male, 35, 6, true)
addVariation(Variations.Gloves.male, 36, 8, true)
addVariation(Variations.Gloves.male, 37, 11, true)
addVariation(Variations.Gloves.male, 38, 12, true)
addVariation(Variations.Gloves.male, 39, 14, true)
addVariation(Variations.Gloves.male, 40, 15, true)
addVariation(Variations.Gloves.male, 41, 0, true)
addVariation(Variations.Gloves.male, 42, 1, true)
addVariation(Variations.Gloves.male, 43, 2, true)
addVariation(Variations.Gloves.male, 44, 4, true)
addVariation(Variations.Gloves.male, 45, 5, true)
addVariation(Variations.Gloves.male, 46, 6, true)
addVariation(Variations.Gloves.male, 47, 8, true)
addVariation(Variations.Gloves.male, 48, 11, true)
addVariation(Variations.Gloves.male, 49, 12, true)
addVariation(Variations.Gloves.male, 50, 14, true)
addVariation(Variations.Gloves.male, 51, 15, true)
addVariation(Variations.Gloves.male, 52, 0, true)
addVariation(Variations.Gloves.male, 53, 1, true)
addVariation(Variations.Gloves.male, 54, 2, true)
addVariation(Variations.Gloves.male, 55, 4, true)
addVariation(Variations.Gloves.male, 56, 5, true)
addVariation(Variations.Gloves.male, 57, 6, true)
addVariation(Variations.Gloves.male, 58, 8, true)
addVariation(Variations.Gloves.male, 59, 11, true)
addVariation(Variations.Gloves.male, 60, 12, true)
addVariation(Variations.Gloves.male, 61, 14, true)
addVariation(Variations.Gloves.male, 62, 15, true)
addVariation(Variations.Gloves.male, 63, 0, true)
addVariation(Variations.Gloves.male, 64, 1, true)
addVariation(Variations.Gloves.male, 65, 2, true)
addVariation(Variations.Gloves.male, 66, 4, true)
addVariation(Variations.Gloves.male, 67, 5, true)
addVariation(Variations.Gloves.male, 68, 6, true)
addVariation(Variations.Gloves.male, 69, 8, true)
addVariation(Variations.Gloves.male, 70, 11, true)
addVariation(Variations.Gloves.male, 71, 12, true)
addVariation(Variations.Gloves.male, 72, 14, true)
addVariation(Variations.Gloves.male, 73, 15, true)
addVariation(Variations.Gloves.male, 74, 0, true)
addVariation(Variations.Gloves.male, 75, 1, true)
addVariation(Variations.Gloves.male, 76, 2, true)
addVariation(Variations.Gloves.male, 77, 4, true)
addVariation(Variations.Gloves.male, 78, 5, true)
addVariation(Variations.Gloves.male, 79, 6, true)
addVariation(Variations.Gloves.male, 80, 8, true)
addVariation(Variations.Gloves.male, 81, 11, true)
addVariation(Variations.Gloves.male, 82, 12, true)
addVariation(Variations.Gloves.male, 83, 14, true)
addVariation(Variations.Gloves.male, 84, 15, true)
addVariation(Variations.Gloves.male, 85, 0, true)
addVariation(Variations.Gloves.male, 86, 1, true)
addVariation(Variations.Gloves.male, 87, 2, true)
addVariation(Variations.Gloves.male, 88, 4, true)
addVariation(Variations.Gloves.male, 89, 5, true)
addVariation(Variations.Gloves.male, 90, 6, true)
addVariation(Variations.Gloves.male, 91, 8, true)
addVariation(Variations.Gloves.male, 92, 11, true)
addVariation(Variations.Gloves.male, 93, 12, true)
addVariation(Variations.Gloves.male, 94, 14, true)
addVariation(Variations.Gloves.male, 95, 15, true)
addVariation(Variations.Gloves.male, 96, 4, true)
addVariation(Variations.Gloves.male, 97, 4, true)
addVariation(Variations.Gloves.male, 98, 4, true)
addVariation(Variations.Gloves.male, 99, 0, true)
addVariation(Variations.Gloves.male, 100, 1, true)
addVariation(Variations.Gloves.male, 101, 2, true)
addVariation(Variations.Gloves.male, 102, 4, true)
addVariation(Variations.Gloves.male, 103, 5, true)
addVariation(Variations.Gloves.male, 104, 6, true)
addVariation(Variations.Gloves.male, 105, 8, true)
addVariation(Variations.Gloves.male, 106, 11, true)
addVariation(Variations.Gloves.male, 107, 12, true)
addVariation(Variations.Gloves.male, 108, 14, true)
addVariation(Variations.Gloves.male, 109, 15, true)
addVariation(Variations.Gloves.male, 110, 4, true)
addVariation(Variations.Gloves.male, 111, 4, true)
addVariation(Variations.Gloves.male, 115, 112, true)
addVariation(Variations.Gloves.male, 116, 112, true)
addVariation(Variations.Gloves.male, 117, 112, true)
addVariation(Variations.Gloves.male, 118, 112, true)
addVariation(Variations.Gloves.male, 119, 112, true)
addVariation(Variations.Gloves.male, 120, 112, true)
addVariation(Variations.Gloves.male, 121, 112, true)
addVariation(Variations.Gloves.male, 122, 113, true)
addVariation(Variations.Gloves.male, 123, 113, true)
addVariation(Variations.Gloves.male, 124, 113, true)
addVariation(Variations.Gloves.male, 125, 113, true)
addVariation(Variations.Gloves.male, 126, 113, true)
addVariation(Variations.Gloves.male, 127, 113, true)
addVariation(Variations.Gloves.male, 128, 113, true)
addVariation(Variations.Gloves.male, 129, 114, true)
addVariation(Variations.Gloves.male, 130, 114, true)
addVariation(Variations.Gloves.male, 131, 114, true)
addVariation(Variations.Gloves.male, 132, 114, true)
addVariation(Variations.Gloves.male, 133, 114, true)
addVariation(Variations.Gloves.male, 134, 114, true)
addVariation(Variations.Gloves.male, 135, 114, true)
addVariation(Variations.Gloves.male, 136, 15, true)
addVariation(Variations.Gloves.male, 137, 15, true)
addVariation(Variations.Gloves.male, 138, 0, true)
addVariation(Variations.Gloves.male, 139, 1, true)
addVariation(Variations.Gloves.male, 140, 2, true)
addVariation(Variations.Gloves.male, 141, 4, true)
addVariation(Variations.Gloves.male, 142, 5, true)
addVariation(Variations.Gloves.male, 143, 6, true)
addVariation(Variations.Gloves.male, 144, 8, true)
addVariation(Variations.Gloves.male, 145, 11, true)
addVariation(Variations.Gloves.male, 146, 12, true)
addVariation(Variations.Gloves.male, 147, 14, true)
addVariation(Variations.Gloves.male, 148, 112, true)
addVariation(Variations.Gloves.male, 149, 113, true)
addVariation(Variations.Gloves.male, 150, 114, true)
addVariation(Variations.Gloves.male, 151, 0, true)
addVariation(Variations.Gloves.male, 152, 1, true)
addVariation(Variations.Gloves.male, 153, 2, true)
addVariation(Variations.Gloves.male, 154, 4, true)
addVariation(Variations.Gloves.male, 155, 5, true)
addVariation(Variations.Gloves.male, 156, 6, true)
addVariation(Variations.Gloves.male, 157, 8, true)
addVariation(Variations.Gloves.male, 158, 11, true)
addVariation(Variations.Gloves.male, 159, 12, true)
addVariation(Variations.Gloves.male, 160, 14, true)
addVariation(Variations.Gloves.male, 161, 112, true)
addVariation(Variations.Gloves.male, 162, 113, true)
addVariation(Variations.Gloves.male, 163, 114, true)
addVariation(Variations.Gloves.male, 165, 4, true)
addVariation(Variations.Gloves.male, 166, 4, true)
addVariation(Variations.Gloves.male, 167, 4, true)
-- FEMALE
addVariation(Variations.Gloves.female, 16, 11, true)
addVariation(Variations.Gloves.female, 17, 3, true)
addVariation(Variations.Gloves.female, 18, 3, true)
addVariation(Variations.Gloves.female, 19, 3, true)
addVariation(Variations.Gloves.female, 20, 0, true)
addVariation(Variations.Gloves.female, 21, 1, true)
addVariation(Variations.Gloves.female, 22, 2, true)
addVariation(Variations.Gloves.female, 23, 3, true)
addVariation(Variations.Gloves.female, 24, 4, true)
addVariation(Variations.Gloves.female, 25, 5, true)
addVariation(Variations.Gloves.female, 26, 6, true)
addVariation(Variations.Gloves.female, 27, 7, true)
addVariation(Variations.Gloves.female, 28, 9, true)
addVariation(Variations.Gloves.female, 29, 11, true)
addVariation(Variations.Gloves.female, 30, 12, true)
addVariation(Variations.Gloves.female, 31, 14, true)
addVariation(Variations.Gloves.female, 32, 15, true)
addVariation(Variations.Gloves.female, 33, 0, true)
addVariation(Variations.Gloves.female, 34, 1, true)
addVariation(Variations.Gloves.female, 35, 2, true)
addVariation(Variations.Gloves.female, 36, 3, true)
addVariation(Variations.Gloves.female, 37, 4, true)
addVariation(Variations.Gloves.female, 38, 5, true)
addVariation(Variations.Gloves.female, 39, 6, true)
addVariation(Variations.Gloves.female, 40, 7, true)
addVariation(Variations.Gloves.female, 41, 9, true)
addVariation(Variations.Gloves.female, 42, 11, true)
addVariation(Variations.Gloves.female, 43, 12, true)
addVariation(Variations.Gloves.female, 44, 14, true)
addVariation(Variations.Gloves.female, 45, 15, true)
addVariation(Variations.Gloves.female, 46, 0, true)
addVariation(Variations.Gloves.female, 47, 1, true)
addVariation(Variations.Gloves.female, 48, 2, true)
addVariation(Variations.Gloves.female, 49, 3, true)
addVariation(Variations.Gloves.female, 50, 4, true)
addVariation(Variations.Gloves.female, 51, 5, true)
addVariation(Variations.Gloves.female, 52, 6, true)
addVariation(Variations.Gloves.female, 53, 7, true)
addVariation(Variations.Gloves.female, 54, 9, true)
addVariation(Variations.Gloves.female, 55, 11, true)
addVariation(Variations.Gloves.female, 56, 12, true)
addVariation(Variations.Gloves.female, 57, 14, true)
addVariation(Variations.Gloves.female, 58, 15, true)
addVariation(Variations.Gloves.female, 59, 0, true)
addVariation(Variations.Gloves.female, 60, 1, true)
addVariation(Variations.Gloves.female, 61, 2, true)
addVariation(Variations.Gloves.female, 62, 3, true)
addVariation(Variations.Gloves.female, 63, 4, true)
addVariation(Variations.Gloves.female, 64, 5, true)
addVariation(Variations.Gloves.female, 65, 6, true)
addVariation(Variations.Gloves.female, 66, 7, true)
addVariation(Variations.Gloves.female, 67, 9, true)
addVariation(Variations.Gloves.female, 68, 11, true)
addVariation(Variations.Gloves.female, 69, 12, true)
addVariation(Variations.Gloves.female, 70, 14, true)
addVariation(Variations.Gloves.female, 71, 15, true)
addVariation(Variations.Gloves.female, 72, 0, true)
addVariation(Variations.Gloves.female, 73, 1, true)
addVariation(Variations.Gloves.female, 74, 2, true)
addVariation(Variations.Gloves.female, 75, 3, true)
addVariation(Variations.Gloves.female, 76, 4, true)
addVariation(Variations.Gloves.female, 77, 5, true)
addVariation(Variations.Gloves.female, 78, 6, true)
addVariation(Variations.Gloves.female, 79, 7, true)
addVariation(Variations.Gloves.female, 80, 9, true)
addVariation(Variations.Gloves.female, 81, 11, true)
addVariation(Variations.Gloves.female, 82, 12, true)
addVariation(Variations.Gloves.female, 83, 14, true)
addVariation(Variations.Gloves.female, 84, 15, true)
addVariation(Variations.Gloves.female, 85, 0, true)
addVariation(Variations.Gloves.female, 86, 1, true)
addVariation(Variations.Gloves.female, 87, 2, true)
addVariation(Variations.Gloves.female, 88, 3, true)
addVariation(Variations.Gloves.female, 89, 4, true)
addVariation(Variations.Gloves.female, 90, 5, true)
addVariation(Variations.Gloves.female, 91, 6, true)
addVariation(Variations.Gloves.female, 92, 7, true)
addVariation(Variations.Gloves.female, 93, 9, true)
addVariation(Variations.Gloves.female, 94, 11, true)
addVariation(Variations.Gloves.female, 95, 12, true)
addVariation(Variations.Gloves.female, 96, 14, true)
addVariation(Variations.Gloves.female, 97, 15, true)
addVariation(Variations.Gloves.female, 98, 0, true)
addVariation(Variations.Gloves.female, 99, 1, true)
addVariation(Variations.Gloves.female, 100, 2, true)
addVariation(Variations.Gloves.female, 101, 3, true)
addVariation(Variations.Gloves.female, 102, 4, true)
addVariation(Variations.Gloves.female, 103, 5, true)
addVariation(Variations.Gloves.female, 104, 6, true)
addVariation(Variations.Gloves.female, 105, 7, true)
addVariation(Variations.Gloves.female, 106, 9, true)
addVariation(Variations.Gloves.female, 107, 11, true)
addVariation(Variations.Gloves.female, 108, 12, true)
addVariation(Variations.Gloves.female, 109, 14, true)
addVariation(Variations.Gloves.female, 110, 15, true)
addVariation(Variations.Gloves.female, 111, 3, true)
addVariation(Variations.Gloves.female, 112, 3, true)
addVariation(Variations.Gloves.female, 113, 3, true)
addVariation(Variations.Gloves.female, 114, 0, true)
addVariation(Variations.Gloves.female, 115, 1, true)
addVariation(Variations.Gloves.female, 116, 2, true)
addVariation(Variations.Gloves.female, 117, 3, true)
addVariation(Variations.Gloves.female, 118, 4, true)
addVariation(Variations.Gloves.female, 119, 5, true)
addVariation(Variations.Gloves.female, 120, 6, true)
addVariation(Variations.Gloves.female, 121, 7, true)
addVariation(Variations.Gloves.female, 122, 9, true)
addVariation(Variations.Gloves.female, 123, 11, true)
addVariation(Variations.Gloves.female, 124, 12, true)
addVariation(Variations.Gloves.female, 125, 14, true)
addVariation(Variations.Gloves.female, 126, 15, true)
addVariation(Variations.Gloves.female, 127, 3, true)
addVariation(Variations.Gloves.female, 128, 3, true)
addVariation(Variations.Gloves.female, 132, 129, true)
addVariation(Variations.Gloves.female, 133, 129, true)
addVariation(Variations.Gloves.female, 134, 129, true)
addVariation(Variations.Gloves.female, 135, 129, true)
addVariation(Variations.Gloves.female, 136, 129, true)
addVariation(Variations.Gloves.female, 137, 129, true)
addVariation(Variations.Gloves.female, 138, 129, true)
addVariation(Variations.Gloves.female, 139, 130, true)
addVariation(Variations.Gloves.female, 140, 130, true)
addVariation(Variations.Gloves.female, 141, 130, true)
addVariation(Variations.Gloves.female, 142, 130, true)
addVariation(Variations.Gloves.female, 143, 130, true)
addVariation(Variations.Gloves.female, 144, 130, true)
addVariation(Variations.Gloves.female, 145, 130, true)
addVariation(Variations.Gloves.female, 146, 131, true)
addVariation(Variations.Gloves.female, 147, 131, true)
addVariation(Variations.Gloves.female, 148, 131, true)
addVariation(Variations.Gloves.female, 149, 131, true)
addVariation(Variations.Gloves.female, 150, 131, true)
addVariation(Variations.Gloves.female, 151, 131, true)
addVariation(Variations.Gloves.female, 152, 131, true)
addVariation(Variations.Gloves.female, 154, 153, true)
addVariation(Variations.Gloves.female, 155, 153, true)
addVariation(Variations.Gloves.female, 156, 153, true)
addVariation(Variations.Gloves.female, 157, 153, true)
addVariation(Variations.Gloves.female, 158, 153, true)
addVariation(Variations.Gloves.female, 159, 153, true)
addVariation(Variations.Gloves.female, 160, 153, true)
addVariation(Variations.Gloves.female, 162, 161, true)
addVariation(Variations.Gloves.female, 163, 161, true)
addVariation(Variations.Gloves.female, 164, 161, true)
addVariation(Variations.Gloves.female, 165, 161, true)
addVariation(Variations.Gloves.female, 166, 161, true)
addVariation(Variations.Gloves.female, 167, 161, true)
addVariation(Variations.Gloves.female, 168, 161, true)
addVariation(Variations.Gloves.female, 169, 15, true)
addVariation(Variations.Gloves.female, 170, 15, true)
addVariation(Variations.Gloves.female, 171, 0, true)
addVariation(Variations.Gloves.female, 172, 1, true)
addVariation(Variations.Gloves.female, 173, 2, true)
addVariation(Variations.Gloves.female, 174, 3, true)
addVariation(Variations.Gloves.female, 175, 4, true)
addVariation(Variations.Gloves.female, 176, 5, true)
addVariation(Variations.Gloves.female, 177, 6, true)
addVariation(Variations.Gloves.female, 178, 7, true)
addVariation(Variations.Gloves.female, 179, 9, true)
addVariation(Variations.Gloves.female, 180, 11, true)
addVariation(Variations.Gloves.female, 181, 12, true)
addVariation(Variations.Gloves.female, 182, 14, true)
addVariation(Variations.Gloves.female, 183, 129, true)
addVariation(Variations.Gloves.female, 184, 130, true)
addVariation(Variations.Gloves.female, 185, 131, true)
addVariation(Variations.Gloves.female, 186, 153, true)
addVariation(Variations.Gloves.female, 187, 0, true)
addVariation(Variations.Gloves.female, 188, 1, true)
addVariation(Variations.Gloves.female, 189, 2, true)
addVariation(Variations.Gloves.female, 190, 3, true)
addVariation(Variations.Gloves.female, 191, 4, true)
addVariation(Variations.Gloves.female, 192, 5, true)
addVariation(Variations.Gloves.female, 193, 6, true)
addVariation(Variations.Gloves.female, 194, 7, true)
addVariation(Variations.Gloves.female, 195, 9, true)
addVariation(Variations.Gloves.female, 196, 11, true)
addVariation(Variations.Gloves.female, 197, 12, true)
addVariation(Variations.Gloves.female, 198, 14, true)
addVariation(Variations.Gloves.female, 199, 129, true)
addVariation(Variations.Gloves.female, 200, 130, true)
addVariation(Variations.Gloves.female, 201, 131, true)
addVariation(Variations.Gloves.female, 202, 153, true)
addVariation(Variations.Gloves.female, 203, 161, true)
addVariation(Variations.Gloves.female, 204, 161, true)
addVariation(Variations.Gloves.female, 206, 3, true)
addVariation(Variations.Gloves.female, 207, 3, true)
addVariation(Variations.Gloves.female, 208, 3, true)

local Module = {}
Module.cooldown = false

ScriptClient.Clothes = Module

function Module:GetSex()
    local localPed = PlayerPedId()
    if GetEntityModel(localPed) == `mp_m_freemode_01` then
        return "male"
    elseif GetEntityModel(localPed) == `mp_f_freemode_01` then
        return "female"
    end
end

---@param dict string
---@param anim string
---@param flag number
---@param time number
---@param cb function
function Module:PlayEmote(dict, anim, flag, time, cb)
    local localPlayer = PlayerPedId()

    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end

    if IsPedInAnyVehicle(localPlayer) then
        flag = 51
    end

    TaskPlayAnim(localPlayer, dict, anim, 3.0, 3.0, time, flag, 0, false, false, false)

    local waitMS = time - 500

    if waitMS < 500 then
        waitMS = 500
    end

    self.cooldown = true

    Citizen.SetTimeout(waitMS, function()
        self.cooldown = false
    end)

    Citizen.Wait(waitMS)

    cb()
end

---@class C_Variation
---@field id number
---@field last { drawable:number; texture:number; } | nil
---@field emote EmoteTable
---@field variations { [number]: number }
---@field prop boolean
---@field rememberLast boolean
local CVariation = {}
CVariation.__index = CVariation

---@param data { id: number; prop:boolean; rememberLast:boolean; emote: EmoteTable; variations: { [number]: number } }
CVariation.new = function(data)
    local self = setmetatable({}, CVariation)

    self.id = data.id
    self.emote = data.emote
    self.rememberLast = data.rememberLast
    self.prop = data.prop
    self.last = nil
    self.variations = data.variations

    return self
end

---@return { drawable: number; texture: number; }
function CVariation:GetCurrentDrawableAndTexture()
    local localPed = PlayerPedId()

    if self.prop then
        return {
            drawable = GetPedPropIndex(localPed, self.id),
            texture = GetPedPropTextureIndex(localPed, self.id)
        }
    else
        return {
            drawable = GetPedDrawableVariation(localPed, self.id),
            texture = GetPedTextureVariation(localPed, self.id)
        }
    end
end

function CVariation:IsVariationAvailable()
    local current = self:GetCurrentDrawableAndTexture()
    local sex = ScriptClient.Clothes:GetSex()

    if not sex then return end

    if self.last then
        return true
    end

    local selectedVariations = self.variations?[sex]
    if not selectedVariations then return end

    for k, v in pairs(selectedVariations) do
        if k == current.drawable then
            return true
        end
    end
end

function CVariation:ChangeVariation()
    if ScriptClient.Clothes.cooldown then return end
    local localPed = PlayerPedId()
    local current = self:GetCurrentDrawableAndTexture()

    local sex = ScriptClient.Clothes:GetSex()
    if not sex then return end

    local selectedVariations = self.variations?[sex]
    if not selectedVariations then return end

    if not self.rememberLast then
        for k, v in pairs(selectedVariations) do
            if k == current.drawable then
                ScriptClient.Clothes:PlayEmote(
                    self.emote.dict,
                    self.emote.anim,
                    self.emote.flag,
                    self.emote.time,
                    function ()
                        if self.prop then
                            if DoesEntityExist(ScriptClient.PedScreen.ped) then
                                SetPedPropIndex(ScriptClient.PedScreen.ped, self.id, v, current.texture, 1)
                            end
                            SetPedPropIndex(localPed, self.id, v, current.texture, 1)
                        else
                            if DoesEntityExist(ScriptClient.PedScreen.ped) then
                                SetPedComponentVariation(ScriptClient.PedScreen.ped, self.id, v, current.texture, 0)
                            end
                            SetPedComponentVariation(localPed, self.id, v, current.texture, 0)
                        end
                    end
                )
                break
            end
        end
    else
        if not self.last then
            for k, v in pairs(selectedVariations) do
                if k == current.drawable then
                    ScriptClient.Clothes:PlayEmote(
                        self.emote.dict,
                        self.emote.anim,
                        self.emote.flag,
                        self.emote.time,
                        function ()
                            if self.prop then
                                if DoesEntityExist(ScriptClient.PedScreen.ped) then
                                    SetPedPropIndex(ScriptClient.PedScreen.ped, self.id, v, current.texture, 1)
                                end
                                SetPedPropIndex(localPed, self.id, v, current.texture, 1)
                            else
                                if DoesEntityExist(ScriptClient.PedScreen.ped) then
                                    SetPedComponentVariation(ScriptClient.PedScreen.ped, self.id, v, current.texture, 0)
                                end
                                SetPedComponentVariation(localPed, self.id, v, current.texture, 0)
                            end

                            self.last = current
                        end
                    )
                    break
                end
            end
        else
            ScriptClient.Clothes:PlayEmote(
                self.emote.dict,
                self.emote.anim,
                self.emote.flag,
                self.emote.time,
                function ()
                    if self.prop then
                        if DoesEntityExist(ScriptClient.PedScreen.ped) then
                            SetPedPropIndex(ScriptClient.PedScreen.ped, self.id, self.last.drawable, self.last.texture, 1)
                        end
                        SetPedPropIndex(localPed, self.id, self.last.drawable, self.last.texture, 1)
                    else
                        if DoesEntityExist(ScriptClient.PedScreen.ped) then
                            SetPedComponentVariation(ScriptClient.PedScreen.ped, self.id, self.last.drawable, self.last.texture, 0)
                        end
                        SetPedComponentVariation(localPed, self.id, self.last.drawable, self.last.texture, 0)
                    end

                    self.last = nil
                end
            )
        end
    end
end

RegisterNUICallback("CHANGE_VARIATION", function(data, cb)
    local id = data.id
    local prop = data.prop

    for k, v in pairs(ScriptClient.Clothes.Variations) do
        if v.id == id and v.prop == prop then
            v:ChangeVariation()
            break
        end
    end
    cb({})
end)

ScriptClient.Clothes.Variations = {
    Visor = CVariation.new({
        prop = true,
        id = 0,
        emote = {
            dict = "mp_masks@standard_car@ds@",
            anim = "put_on_mask",
            flag = 51,
            time = 600
        },
        variations = Variations.Visor
    }),
    Hair = CVariation.new({
        id = 2,
        emote = {
            dict = "clothingtie",
            anim = "check_out_a",
            flag = 51,
            time = 2000
        },
        variations = Variations.Hair,
        rememberLast = true
    }),
    Gloves = CVariation.new({
        id = 3,
        emote = {
            dict = "nmt_3_rcm-10",
            anim = "cs_nigel_dual-10",
            flag = 51,
            time = 1200
        },
        variations = Variations.Gloves,
        rememberLast = true
    }),
    Bag = CVariation.new({
        id = 5,
        emote = {
            dict = "anim@heists@ornate_bank@grab_cash",
            anim = "intro",
            flag = 51,
            time = 1600
        },
        variations = Variations.Bag
    }),
    Top = CVariation.new({
        id = 11,
        emote = {
            dict = "missmic4",
            anim = "michael_tux_fidget",
            flag = 51,
            time = 1500
        },
        variations = Variations.Top
    })
}

---@class C_Clothes
---@field id number
---@field last { id:number; drawable:number; texture:number; }[] | nil
---@field emoteOn EmoteTable
---@field emoteOff EmoteTable
---@field prop boolean
---@field empty { male:number; female:number; }
---@field extra? { id: number; drawable: number; texture:number; }[]
local CTakeoff = {}
CTakeoff.__index = CTakeoff

local function ResyncNUI()
    local tbl = {}
    for k, v in pairs(ScriptClient.Clothes.Takeoffable) do
        tbl[#tbl + 1] = {
            id = v.id,
            prop = v.prop,
            isWeared = v:IsWeared()
        }
    end

    local varis = {}
    for k, v in pairs(ScriptClient.Clothes.Variations) do
        varis[#varis + 1] = {
            id = v.id,
            prop = v.prop,
            isAvailable = v:IsVariationAvailable()
        }
    end

    SEND_NUI_MESSAGE({
        event = "SET_VARIATIONS",
        table = varis
    })

    SEND_NUI_MESSAGE({
        event = "SET_TAKEOFFABLE",
        table = tbl
    })
end

---@param data { id:number; emoteOn: EmoteTable; empty: { male:number; female: number; }; emoteOff: EmoteTable; prop: boolean; extra?: { id:number; drawable:number; texture:number; }[] }
CTakeoff.new = function(data)
    local self = setmetatable({}, CTakeoff)

    self.id = data.id
    self.emoteOn = data.emoteOn
    self.emoteOff = data.emoteOff
    self.prop = data.prop
    self.last = nil
    self.extra = data.extra
    self.empty = data.empty

    return self
end

---@return { drawable: number; texture: number; }
function CTakeoff:GetCurrentDrawableAndTexture()
    local localPed = PlayerPedId()

    if self.prop then
        return {
            drawable = GetPedPropIndex(localPed, self.id),
            texture = GetPedPropTextureIndex(localPed, self.id)
        }
    else
        return {
            drawable = GetPedDrawableVariation(localPed, self.id),
            texture = GetPedTextureVariation(localPed, self.id)
        }
    end
end

function CTakeoff:IsWeared()
    local sex = ScriptClient.Clothes:GetSex()
    if not sex then return end

    local drawable = self.empty[sex]
    if type(drawable) ~= "number" then return end

    local current = self:GetCurrentDrawableAndTexture()

    if current.drawable ~= drawable then
        return true
    end
end

function CTakeoff:Wear()
    if ScriptClient.Clothes.cooldown then return end
    if not self.last then return end

    local localPed = PlayerPedId()

    ScriptClient.Clothes:PlayEmote(
        self.emoteOn.dict,
        self.emoteOn.anim,
        self.emoteOn.flag,
        self.emoteOn.time,
        function()
            if self.prop then
                for k, v in pairs(self.last) do
                    if DoesEntityExist(ScriptClient.PedScreen.ped) then
                        SetPedPropIndex(ScriptClient.PedScreen.ped, v.id, v.drawable, v.texture, 1)
                    end
                    SetPedPropIndex(localPed, v.id, v.drawable, v.texture, 1)
                end
            else
                for k, v in pairs(self.last) do
                    if DoesEntityExist(ScriptClient.PedScreen.ped) then
                        SetPedComponentVariation(ScriptClient.PedScreen.ped, v.id, v.drawable, v.texture, 0)
                    end
                    SetPedComponentVariation(localPed, v.id, v.drawable, v.texture, 0)
                end
            end

            ResyncNUI()
            self.last = nil
        end
    )
end

function CTakeoff:TakeOff()
    if ScriptClient.Clothes.cooldown then return end
    if self.last then return end
    local localPed = PlayerPedId()

    local sex = ScriptClient.Clothes:GetSex()
    if not sex then return end

    local drawable = self.empty[sex]
    if type(drawable) ~= "number" then return end

    local current = self:GetCurrentDrawableAndTexture()

    if drawable ~= current.drawable then
        ScriptClient.Clothes:PlayEmote(
            self.emoteOff.dict,
            self.emoteOff.anim,
            self.emoteOff.flag,
            self.emoteOff.time,
            function()
                local saveLasts = {
                    { id = self.id, drawable = current.drawable, texture = current.texture }
                }

                if self.prop then
                    if DoesEntityExist(ScriptClient.PedScreen.ped) then
                        ClearPedProp(ScriptClient.PedScreen.ped, self.id)
                    end
                    ClearPedProp(localPed, self.id)
                else
                    if DoesEntityExist(ScriptClient.PedScreen.ped) then
                        SetPedComponentVariation(ScriptClient.PedScreen.ped, self.id, drawable, 0, 0)
                    end
                    SetPedComponentVariation(localPed, self.id, drawable, 0, 0)
                end

                if self.extra then
                    for k, v in pairs(self.extra) do
                        if self.prop then
                            saveLasts[#saveLasts + 1] = {
                                id = v.id,
                                drawable = GetPedPropIndex(localPed, v.id),
                                texture = GetPedPropTextureIndex(localPed, v.id)
                            }
                            if DoesEntityExist(ScriptClient.PedScreen.ped) then
                                ClearPedProp(localPed, self.id)
                            end
                            ClearPedProp(localPed, self.id)
                        else
                            saveLasts[#saveLasts + 1] = {
                                id = v.id,
                                drawable = GetPedDrawableVariation(localPed, v.id),
                                texture = GetPedTextureVariation(localPed, v.id)
                            }
                            if DoesEntityExist(ScriptClient.PedScreen.ped) then
                                SetPedComponentVariation(ScriptClient.PedScreen.ped, v.id, v.drawable, v.texture, 0)
                            end
                            SetPedComponentVariation(localPed, v.id, v.drawable, v.texture, 0)
                        end
                    end
                end

                ResyncNUI()
                self.last = saveLasts
            end
        )
    end
end

ScriptClient.Clothes.Takeoffable = {
    Mask = CTakeoff.new({
        id = 1,
        empty = {
            male = 0,
            female = 0,
        },
        emoteOn = {
            dict = "mp_masks@standard_car@ds@",
            anim = "put_on_mask",
            flag = 51,
            time = 800
        },
        emoteOff = {
            dict = "mp_masks@standard_car@ds@",
            anim = "put_on_mask",
            flag = 51,
            time = 800
        }
    }),
    Pants = CTakeoff.new({
        id = 4,
        empty = {
            male = 61,
            female = 14
        },
        emoteOn = {
            dict = "re@construction",
            anim = "out_of_breath",
            flag = 51,
            time = 1300
        },
        emoteOff = {
            dict = "re@construction",
            anim = "out_of_breath",
            flag = 51,
            time = 1300
        }
    }),
    Bag = CTakeoff.new({
        id = 5,
        empty = {
            male = 0,
            female = 0
        },
        emoteOn = {
            dict = "anim@heists@ornate_bank@grab_cash",
            anim = "intro",
            flag = 51,
            time = 1600
        },
        emoteOff = {
            dict = "anim@heists@ornate_bank@grab_cash",
            anim = "intro",
            flag = 51,
            time = 1600
        }
    }),
    Shoes = CTakeoff.new({
        id = 6,
        empty = {
            male = 34,
            female = 35
        },
        emoteOn = {
            dict = "random@domestic",
            anim = "pickup_low",
            flag = 0,
            time = 1200
        },
        emoteOff = {
            dict = "random@domestic",
            anim = "pickup_low",
            flag = 0,
            time = 1200
        }
    }),
    Accessories = CTakeoff.new({
        id = 7,
        empty = {
            male = 0,
            female = 0
        },
        emoteOn = {
            dict = "clothingtie",
            anim = "try_tie_positive_a",
            flag = 51,
            time = 2100
        },
        emoteOff = {
            dict = "clothingtie",
            anim = "try_tie_positive_a",
            flag = 51,
            time = 2100
        }
    }),
    Armour = CTakeoff.new({
        id = 9,
        empty = {
            male = 0,
            female = 0
        },
        emoteOn = {
            dict = "clothingtie",
            anim = "try_tie_negative_a",
            flag = 51,
            time = 1200
        },
        emoteOff = {
            dict = "clothingtie",
            anim = "try_tie_negative_a",
            flag = 51,
            time = 1200
        }
    }),
    Decals = CTakeoff.new({
        id = 10,
        empty = {
            male = 0,
            female = 0
        },
        emoteOn = {
            dict = "clothingtie",
            anim = "try_tie_negative_a",
            flag = 51,
            time = 1200
        },
        emoteOff = {
            dict = "clothingtie",
            anim = "try_tie_negative_a",
            flag = 51,
            time = 1200
        }
    }),
    Top = CTakeoff.new({
        id = 11,
        empty = {
            male = 252,
            female = 74
        },
        emoteOn = {
            dict = "clothingtie",
            anim = "try_tie_negative_a",
            flag = 51,
            time = 1200
        },
        emoteOff = {
            dict = "clothingtie",
            anim = "try_tie_negative_a",
            flag = 51,
            time = 1200
        },
        extra = {
            { id = 8,  drawable = 15, texture = 0 },
            { id = 3,  drawable = 15, texture = 0 },
            { id = 10, drawable = 0,  texture = 0 }
        }
    }),
    Hat = CTakeoff.new({
        prop = true,
        id = 0,
        empty = {
            male = -1,
            female = -1
        },
        emoteOn = {
            dict = "mp_masks@standard_car@ds@",
            anim = "put_on_mask",
            flag = 51,
            time = 600
        },
        emoteOff = {
            dict = "missheist_agency2ahelmet",
            anim = "take_off_helmet_stand",
            flag = 51,
            time = 1200
        }
    }),
    Glasses = CTakeoff.new({
        prop = true,
        id = 1,
        empty = {
            male = -1,
            female = -1
        },
        emoteOn = {
            dict = "clothingspecs",
            anim = "take_off",
            flag = 51,
            time = 1400
        },
        emoteOff = {
            dict = "clothingspecs",
            anim = "take_off",
            flag = 51,
            time = 1400
        }
    }),
    Earrings = CTakeoff.new({
        prop = true,
        id = 2,
        empty = {
            male = -1,
            female = -1
        },
        emoteOn = {
            dict = "mp_cp_stolen_tut",
            anim = "b_think",
            flag = 51,
            time = 900
        },
        emoteOff = {
            dict = "mp_cp_stolen_tut",
            anim = "b_think",
            flag = 51,
            time = 900
        }
    }),
    Watch = CTakeoff.new({
        prop = true,
        id = 6,
        empty = {
            male = -1,
            female = -1
        },
        emoteOn = {
            dict = "nmt_3_rcm-10",
            anim = "cs_nigel_dual-10",
            flag = 51,
            time = 1200
        },
        emoteOff = {
            dict = "nmt_3_rcm-10",
            anim = "cs_nigel_dual-10",
            flag = 51,
            time = 1200
        }
    }),
    Bracelet = CTakeoff.new({
        prop = true,
        id = 7,
        empty = {
            male = -1,
            female = -1
        },
        emoteOn = {
            dict = "nmt_3_rcm-10",
            anim = "cs_nigel_dual-10",
            flag = 51,
            time = 1200
        },
        emoteOff = {
            dict = "nmt_3_rcm-10",
            anim = "cs_nigel_dual-10",
            flag = 51,
            time = 1200
        }
    })
}

RegisterNUICallback("WEAR_DRESS", function(data, cb)
    local id = data.id
    local prop = data.prop
    for k, v in pairs(ScriptClient.Clothes.Takeoffable) do
        if v.id == id and v.prop == prop then
            v:Wear()
            break
        end
    end
    cb({})
end)
RegisterNUICallback("TAKE_OFF_DRESS", function(data, cb)
    local id = data.id
    local prop = data.prop
    for k, v in pairs(ScriptClient.Clothes.Takeoffable) do
        if v.id == id and v.prop == prop then
            v:TakeOff()
            break
        end
    end
    cb({})
end)

AddEventHandler("Inventory:onInventoryOpen", function()
    ResyncNUI()
end)

local PedScreen = {}
---@type number
PedScreen.ped = nil

ScriptClient.PedScreen = PedScreen

function PedScreen:Create()
    if DoesEntityExist(self.ped) then return end

    local playerPed = PlayerPedId()

    SetFrontendActive(true)
    ActivateFrontendMenu(`FE_MENU_VERSION_EMPTY_NO_BACKGROUND`, true, -1)

    while not IsFrontendReadyForControl() do
        Citizen.Wait(10)
    end

    Citizen.Wait(100)

    SetMouseCursorVisibleInMenus(false)

    ReplaceHudColourWithRgba(117, 0, 0, 0, 0)

    local PlayerPedPreview = ClonePed(playerPed, false, false, false)
    SetEntityVisible(PlayerPedPreview, false, false)
    GivePedToPauseMenu(PlayerPedPreview, 1)
    SetPauseMenuPedLighting(true)
    SetPauseMenuPedSleepState(true)
    SetEntityCollision(PlayerPedPreview, false, true)

    self.ped = PlayerPedPreview
end

function PedScreen:Delete()
    SetFrontendActive(false)
    ReplaceHudColourWithRgba(117, 0, 0, 0, 186)
    Citizen.Wait(100)
    SetMouseCursorVisibleInMenus(true)

    if DoesEntityExist(self.ped) then
        DeleteEntity(self.ped)
    end
end

local Settings = {}
Settings.blurEnabled = false
Settings.screenFX = false
Settings.radarEnabled = false
Settings.characterEnabled = false

ScriptClient.Settings = Settings

---@param state boolean
function Settings:SetBlurState(state)
    self.blurEnabled = state

    if ScriptClient.Player.State.inventoryOpened then
        if self.blurEnabled then
            TransitionToBlurred(0)
        else
            TransitionFromBlurred(0)
        end
    else
        TransitionFromBlurred(0)
    end
end

---@param state boolean
function Settings:SetScreenFxState(state)
    self.screenFX = state

    if ScriptClient.Player.State.inventoryOpened then
        if self.screenFX then
            StartScreenEffect("SwitchHUDIn", 0, true)
        else
            StopScreenEffect("SwitchHUDIn")
        end
    else
        StopScreenEffect("SwitchHUDIn")
    end
end

---@param state boolean
function Settings:SetRadarState(state)
    self.radarEnabled = state

    if ScriptClient.Player.State.inventoryOpened then
        if self.radarEnabled then
            DisplayRadar(true)
        else
            DisplayRadar(false)
        end
    else
        DisplayRadar(true)
    end
end

---@param state boolean
function Settings:SetCharacterState(state)
    self.characterEnabled = state

    if ScriptClient.Player.State.inventoryOpened then
        if self.characterEnabled then
            -- Todo reactivate this
            --ScriptClient.PedScreen:Create()
        else
            ScriptClient.PedScreen:Delete()
        end
    else
        ScriptClient.PedScreen:Delete()
    end
end

AddEventHandler("Inventory:onInventoryOpen", function()
    Settings:SetBlurState(Settings.blurEnabled)
    Settings:SetRadarState(Settings.radarEnabled)
    Settings:SetScreenFxState(Settings.screenFX)
    Settings:SetCharacterState(Settings.characterEnabled)
end)

AddEventHandler("Inventory:onInventoryClose", function()
    Settings:SetBlurState(Settings.blurEnabled)
    Settings:SetRadarState(Settings.radarEnabled)
    Settings:SetScreenFxState(Settings.screenFX)
    Settings:SetCharacterState(Settings.characterEnabled)
end)

RegisterNUICallback("SETTINGS_BLUR_ENABLED", function(state, cb)
    Settings:SetBlurState(state)
    cb({})
end)
RegisterNUICallback("SETTINGS_SCREENFX_ENABLED", function(state, cb)
    Settings:SetScreenFxState(state)
    cb({})
end)
RegisterNUICallback("SETTINGS_RADAR_ENABLED", function(state, cb)
    Settings:SetRadarState(state)
    cb({})
end)
RegisterNUICallback("SETTINGS_CHARACTER_ENABLED", function(state, cb)
    Settings:SetCharacterState(state)
    cb({})
end)

RegisterCommand('SLOT_1', function()
    if not ScriptClient.Player.State.shortkeys then return end

    if ScriptClient.Player.Inventory:GetItemBy({ slot = 1 }) then
        TriggerServerEvent("Inventory:USE_SLOT", 1)
    end
end, false)
RegisterCommand('SLOT_2', function()
    if not ScriptClient.Player.State.shortkeys then return end

    if ScriptClient.Player.Inventory:GetItemBy({ slot = 2 }) then
        TriggerServerEvent("Inventory:USE_SLOT", 2)
    end
end, false)
RegisterCommand('SLOT_3', function()
    if not ScriptClient.Player.State.shortkeys then return end

    if ScriptClient.Player.Inventory:GetItemBy({ slot = 3 }) then
        TriggerServerEvent("Inventory:USE_SLOT", 3)
    end
end, false)
RegisterCommand('SLOT_4', function()
    if not ScriptClient.Player.State.shortkeys then return end

    if ScriptClient.Player.Inventory:GetItemBy({ slot = 4 }) then
        TriggerServerEvent("Inventory:USE_SLOT", 4)
    end
end, false)
RegisterCommand('SLOT_5', function()
    if not ScriptClient.Player.State.shortkeys then return end

    if ScriptClient.Player.Inventory:GetItemBy({ slot = 5 }) then
        TriggerServerEvent("Inventory:USE_SLOT", 5)
    end
end, false)

RegisterKeyMapping('SLOT_1', 'Inventory Slot (1)', 'keyboard', "1")
RegisterKeyMapping('SLOT_2', 'Inventory Slot (2)', 'keyboard', "2")
RegisterKeyMapping('SLOT_3', 'Inventory Slot (3)', 'keyboard', "3")
RegisterKeyMapping('SLOT_4', 'Inventory Slot (4)', 'keyboard', "4")
RegisterKeyMapping('SLOT_5', 'Inventory Slot (5)', 'keyboard', "5")

ScriptClient.Player.Inventory = {}
---@type InventoryItem[]
ScriptClient.Player.Inventory.Items = {}

function ScriptClient.Player.Inventory:GetWeight()
    local weight = 0.0

    for i = 1, #self.Items, 1 do
        local v = self.Items[i]
        weight += v.data.stackable and (v.data.weight * v.quantity) or v.data.weight
    end

    return math.floor(weight * 10 ^ 2 + 0.5) / 10 ^ 2
end

---@param item InventoryItem
---@param findBy findByOptions
local function FindByChecker(item, findBy)
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
function ScriptClient.Player.Inventory:GetItemBy(findBy)
    for i = 1, #self.Items, 1 do
        local v = self.Items[i]
        if FindByChecker(v, findBy) then
            return v
        end
    end
end

--- Returns all of the quantity if the arguments are met.
---@param findBy findByOptions
function ScriptClient.Player.Inventory:GetItemQuantityBy(findBy)
    local quantity = 0

    for i = 1, #self.Items, 1 do
        local v = self.Items[i]
        if FindByChecker(v, findBy) then
            quantity += v.quantity
        end
    end

    return quantity
end

---@param items InventoryItem[]
RegisterNetEvent("Inventory:setPlayerInventoryItems", function(items)
    ScriptClient.Player.Inventory.Items = items
end)
---@param item InventoryItem
RegisterNetEvent("Inventory:onPlayerItemUpdated", function(item)
    local found = false
    for i = 1, #ScriptClient.Player.Inventory.Items do
        local v = ScriptClient.Player.Inventory.Items[i]
        if v.itemHash == item.itemHash then
            ScriptClient.Player.Inventory.Items[i] = item
            found = true
            break
        end
    end

    if not found then
        ScriptClient.Player.Inventory.Items[#ScriptClient.Player.Inventory.Items+1] = item
    end
end)
---@param item InventoryItem
RegisterNetEvent("Inventory:onPlayerItemAdded", function(item)
    ScriptClient.Player.Inventory.Items[#ScriptClient.Player.Inventory.Items+1] = item
end)
---@param item InventoryItem
RegisterNetEvent("Inventory:onPlayerItemRemoved", function(item)
    for i = 1, #ScriptClient.Player.Inventory.Items do
        local v = ScriptClient.Player.Inventory.Items[i]
        if v.itemHash == item.itemHash then
            table.remove(ScriptClient.Player.Inventory.Items, i)
            break
        end
    end
end)

local Weapons <const> = {}
---@type boolean
Weapons.armed = false
---@type string
Weapons.usedWeaponItemHash = nil
---@type number | nil
Weapons.floodProtect = GetGameTimer()

SetWeaponsNoAutoswap(GM.Inventory.NO_AUTOSWAP_ON_EMPTY)
SetWeaponsNoAutoreload(GM.Inventory.NO_AUTO_RELOAD)

Citizen.CreateThread(function()
    while true do
        HudWeaponWheelIgnoreSelection()
        Citizen.Wait(0)
    end
end)

local function findAmmoType(weaponHash)
    for k, v in pairs(GM.Inventory.AMMO_WEAPONS) do
        if k == weaponHash then
            return v
        end
    end
end

---@param item InventoryItem
function Weapons:Equip(item)
    local playerPed = PlayerPedId()

    local dict, anim = 'reaction@intimidation@1h', 'intro'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end

    RequestWeaponAsset(item.data.weaponHash, 31, 0)
    while not HasWeaponAssetLoaded(item.data.weaponHash) do
        Citizen.Wait(10)
    end

    TaskPlayAnim(playerPed, dict, anim, 1.0, -1.0, -1, 49, 0, false, false, false)

    self.usedWeaponItemHash = item.itemHash

    Citizen.Wait(1000)

    self:RecreateWeaponObject(item)
    self:SetArmedState(true)
    self:UpdateWeapon(item)
    self:UpdateAmmoCountInWearedWeapon()

    ClearPedTasks(playerPed)
end

local ammoThreadId = nil

---@param state boolean
function Weapons:SetArmedState(state)
    if self.armed == state then return end

    self.armed = state

    if self.armed then
        if ammoThreadId == nil then
            Citizen.CreateThreadNow(function(id)
                ammoThreadId = id

                while ammoThreadId ~= nil do
                    local playerPed = PlayerPedId()
                    local currentWeapon = GetSelectedPedWeapon(playerPed)

                    if IsPedShooting(playerPed) then
                        if GM.Inventory.MISC_WEAPONS[currentWeapon] and self.floodProtect < GetGameTimer() then
                            TriggerServerEvent("Inventory:REDUCE_WEAPON_AMMO")
                            self.floodProtect = GetGameTimer() + 200
                        elseif GM.Inventory.AMMO_WEAPONS[currentWeapon] then
                            TriggerServerEvent("Inventory:REDUCE_WEAPON_DURABILITY")
                            TriggerServerEvent('Inventory:REDUCE_WEAPON_AMMO')
                        elseif GM.Inventory.THROWABLE_WEAPONS[currentWeapon] then
                            TriggerServerEvent('Inventory:REDUCE_WEAPON_AMMO')
                        end
                    elseif IsControlJustReleased(0, 24) and IsPedPerformingMeleeAction(playerPed) and GM.Inventory.MELEE_WEAPONS[currentWeapon] and self.floodProtect < GetGameTimer() then
                        TriggerServerEvent("Inventory:REDUCE_WEAPON_DURABILITY")
                        self.floodProtect = GetGameTimer() + 200
                    end

                    if not self.armed and self.thread then
                        self.thread.stop()
                        self.thread = nil
                    end

                    Citizen.Wait(0)
                end
            end)
        end
    else
        if ammoThreadId ~= nil then
            ammoThreadId = nil
        end
    end
end

function Weapons:UpdateAmmoCountInWearedWeapon()
    if not self.armed then return end

    local playerPed = PlayerPedId()
    local currentWeapon = GetSelectedPedWeapon(playerPed)

    local ammoCount = nil

    if GM.Inventory.AMMO_WEAPONS[currentWeapon] then
        local ammoType = findAmmoType(currentWeapon)
        if ammoType then
            ammoCount = ScriptClient.Player.Inventory:GetItemQuantityBy({ name = ammoType })
        end
    end

    if type(ammoCount) == "number" then
        SetPedAmmo(playerPed, currentWeapon, ammoCount)
    end
end

---@param item InventoryItem
function Weapons:UpdateWeapon(item)
    local playerPed = PlayerPedId()

    self.usedWeaponItemHash = item.itemHash

    local currentWeapon = GetSelectedPedWeapon(playerPed)
    if not currentWeapon then return end

    if GM.Inventory.MISC_WEAPONS[currentWeapon] then
        local weaponItem = ScriptClient.Player.Inventory:GetItemBy({ itemHash = self.usedWeaponItemHash })
        if weaponItem then
            SetPedInfiniteAmmo(playerPed, weaponItem.quantity > 0, currentWeapon)
        end
    elseif GM.Inventory.THROWABLE_WEAPONS[currentWeapon] then
        local weaponItem = ScriptClient.Player.Inventory:GetItemBy({ itemHash = self.usedWeaponItemHash })
        if weaponItem then
            SetPedAmmo(playerPed, currentWeapon, weaponItem.quantity)
        end
    end
end

---@param item InventoryItem
function Weapons:RecreateWeaponObject(item)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local weaponObject = CreateWeaponObject(item.data.weaponHash, 0, coords.x, coords.y, coords.z, true, 0.0, 0)

    if type(item.meta.attachments) == "table" then
        for i = 1, #item.meta.attachments do
            local attItemName = item.meta.attachments[i]
            local rockstarAtts = GM.Inventory.WEAPON_COMPONENTS[attItemName]
            if type(rockstarAtts) == "table" then
                for j = 1, #rockstarAtts do
                    local componentName = rockstarAtts[j]
                    if DoesWeaponTakeWeaponComponent(item.data.weaponHash, componentName) then
                        if not HasWeaponGotWeaponComponent(weaponObject, componentName) then
                            GiveWeaponComponentToWeaponObject(weaponObject, componentName)
                        end
                    end
                end
            end
        end
    end

    RemoveAllPedWeapons(playerPed, false)
    GiveWeaponObjectToPed(weaponObject, playerPed)
    RemoveWeaponAsset(item.data.weaponHash)
end

function Weapons:Disarm()
    local playerPed = PlayerPedId()

    local dict, anim = 'reaction@intimidation@1h', 'intro'

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end

    TaskPlayAnim(playerPed, dict, anim, 1.0, -1.0, -1, 49, 0, false, false, false)

    self.usedWeaponItemHash = nil

    Citizen.Wait(1000)
    ClearPedTasks(playerPed)
    RemoveAllPedWeapons(playerPed, false)
    self:SetArmedState(false)
end

---@param item InventoryItem
RegisterNetEvent("Inventory:equipWeapon", function(item)
    Weapons:Equip(item)
end)
RegisterNetEvent("Inventory:disarmWeapon", function()
    Weapons:Disarm()
end)
---@param item InventoryItem
RegisterNetEvent("Inventory:updateCurrentWeapon", function(item)
    Weapons:UpdateWeapon(item)
end)
RegisterNetEvent("Inventory:onPlayerItemUpdated", function(item)
    Weapons:UpdateAmmoCountInWearedWeapon()
end)
RegisterNetEvent("Inventory:onPlayerItemRemoved", function(item)
    Weapons:UpdateAmmoCountInWearedWeapon()
end)
RegisterNetEvent("Inventory:onPlayerItemAdded", function(item)
    Weapons:UpdateAmmoCountInWearedWeapon()
end)
---@param item InventoryItem
RegisterNetEvent("Inventory:UpdateWeaponAttachments", function(item)
    Weapons:RecreateWeaponObject(item)
end)

RegisterNetEvent("baseevents:onPlayerDied", function()
    Weapons:Disarm()
end)

RegisterCommand("model", function()
    local freemode_model = GetHashKey("mp_m_freemode_01")

    if IsModelInCdimage(freemode_model) and IsModelValid(freemode_model) then
        RequestModel(freemode_model)
        while not HasModelLoaded(freemode_model) do
            Wait(50)
        end

        SetPlayerModel(PlayerId(), freemode_model)
        local player_ped = PlayerPedId()
        SetPedComponentVariation(player_ped, 0, 0, 0, 2)
        SetPedComponentVariation(player_ped, 2, 9, 4, 2)
        SetPedComponentVariation(player_ped, 4, 1, 5, 2)
        SetPedComponentVariation(player_ped, 5, 44, 0, 2)
        SetPedComponentVariation(player_ped, 6, 1, 0, 2)
        SetPedComponentVariation(player_ped, 3, 29, 0, 2)
        SetPedComponentVariation(player_ped, 11, 301, 2, 2)
        SetPedComponentVariation(player_ped, 8, 15, 2, 2)
        -- SetPedPropIndex(player_ped, 0, 18, 2, 1)
        SetPedPropIndex(player_ped, 0, 65, 0, 1)
    end
end)

exports("GetWeight", function()
    return ScriptClient.Player.Inventory:GetWeight()
end)
exports("GetItemBy", function(findBy)
    return ScriptClient.Player.Inventory:GetItemBy(findBy)
end)
exports("GetInventoryItems", function()
    return ScriptClient.Player.Inventory.Items
end)
exports("GetItemQuantityBy", function(findBy)
    return ScriptClient.Player.Inventory:GetItemQuantityBy(findBy)
end)
exports("OpenStash", function(uniqueID)
    TriggerServerEvent("Inventory:OPEN_STASH", uniqueID)
end)
exports("GetRegisteredItems", function()
    return ScriptShared.Items.Registered
end)
exports("GetRegisteredItem", function(itemName)
    return ScriptShared.Items:Get(itemName)
end)