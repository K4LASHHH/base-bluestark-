GM.Ranks = GM.Ranks or {}
GM.Ranks["list"] = {}
GM.Ranks["players"] = {}
GM.Ranks["rank_user"] = 0

function GM.Ranks:new(id, name, label, players, commands, permissions)
    local newAdminRanks = {}

    setmetatable(newAdminRanks, self)
    self.__index = self

    if (GM.Ranks["list"][id] ~= nil) then return end

    newAdminRanks.id = id

    newAdminRanks.name = name
    newAdminRanks.label = label
    newAdminRanks.players = players
    newAdminRanks.commands = commands
    newAdminRanks.permissions = permissions

    for playerIdentifier, playerValues in pairs(newAdminRanks.players) do
        if (not GM.Ranks["players"][playerIdentifier]) then
            GM.Ranks["players"][playerIdentifier] = {}
        end
        GM.Ranks["players"][playerIdentifier] = {
            rankId = newAdminRanks.id,
            name = newAdminRanks.name,
            label = newAdminRanks.label,
            reports = playerValues.reports,
            staffName = playerValues.name
        }
    end

    if (newAdminRanks.name == "user") then
        GM.Ranks["rank_user"] = newAdminRanks.id
    end

    GM.Ranks["list"][newAdminRanks.id] = newAdminRanks

    return newAdminRanks
end

function GM.Ranks:getFromId(rankId)
    return GM.Ranks["list"][rankId]
end

function GM.Ranks:getFromName(rankName)
    for rankId, rankValues in pairs(GM.Ranks["list"]) do
        if (rankValues.name == rankName) then
            return rankValues
        end
    end
end

function GM.Ranks:canInteract(rankId)
    rankId = tonumber(rankId)

    if (self.name == "founder") then return true end

    if (self.id == rankId) then return false end

    if (self.id < rankId) then 
        return true 
    end

    return false
end

function GM.Ranks:getCommandValue(commandName, playerSrc)
    if (not self.commands[commandName]) then
        if (not GM.Command.List[commandName]) then return end
        self.commands[commandName] = GM.Command.List[commandName]
        MySQL.update('UPDATE user_admin SET commands = ? WHERE id = ?', {
            json.encode(self.commands), 
            self.id
        }, function()
            for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
            end
        end)
    end
    if (self.commands[commandName].value == nil) then
        if (self.name == "founder") then
            self.commands[commandName].value = true
            MySQL.update('UPDATE user_admin SET commands = ? WHERE id = ?', {
                json.encode(self.commands), 
                self.id
            }, function()
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
                end
            end)
        else
            self.commands[commandName].value = false
        end
    end
    if (self.commands[commandName].value == false) then
        if (self.name == "founder") then
            self.commands[commandName].value = true
            MySQL.update('UPDATE user_admin SET commands = ? WHERE id = ?', {
                json.encode(self.commands), 
                self.id
            }, function()
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
                end
            end)
            return true
        end
        if (playerSrc) then
            TriggerClientEvent("esx:showNotification", playerSrc, "~r~Vous n'avez pas la permission d'utiliser la commande /"..commandName..".")
        end
        return false
    end
    return true
end

function GM.Ranks:getPermissionsValue(permissionName, playerSrc)
    if (not self.permissions[permissionName]) then

        if (not GM.Admin.Permissions[permissionName]) then
            if (self.name == "founder") then
                TriggerClientEvent("esx:showNotification", playerSrc, "~r~La permission "..permissionName.." n'existe pas\nValeur true par default.")
                return true
            end
            TriggerClientEvent("esx:showNotification", playerSrc, "~r~La permission "..permissionName.." n'existe pas\nValeur false par default.")
            return false
        end

        self.permissions[permissionName] = GM.Admin.Permissions[permissionName]

        MySQL.update('UPDATE user_admin SET permissions = ? WHERE id = ?', {
            json.encode(self.permissions), 
            self.id
        }, function()
            for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
            end
        end)
    end
    if (self.permissions[permissionName].value == false) then
        if (self.name == "founder") then
            self.permissions[permissionName].value = true
            MySQL.update('UPDATE user_admin SET permissions = ? WHERE id = ?', {
                json.encode(self.permissions), 
                self.id
            }, function()
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
                end
            end)
            return true
        end
        if (playerSrc) then
            TriggerClientEvent("esx:showNotification", playerSrc, self.permissions[permissionName].error)
        end
        return false
    end
    return true
end

function GM.Ranks:actualizeCommands()
    for allCommandName, allCommandValues in pairs(GM.Command.List) do
        if (not self.commands[allCommandName]) then
            self.commands[allCommandName] = allCommandValues
            MySQL.update('UPDATE user_admin SET commands = ? WHERE id = ?', {
                json.encode(self.commands), 
                self.id
            }, function()
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
                end
            end)
        end
    end
    for commandName, _ in pairs(self.commands) do
        if (not GM.Command.List[commandName]) then
            self.commands[commandName] = nil
            MySQL.update('UPDATE user_admin SET commands = ? WHERE id = ?', {
                json.encode(self.commands), 
                self.id
            }, function()
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
                end
            end)
        end
    end
end

function GM.Ranks:actualizePermissions()
    for allPermissionName, allPermissionValues in pairs(GM.Admin.Permissions) do
        if (not self.permissions[allPermissionName]) then
            self.permissions[allPermissionName] = allPermissionValues
            MySQL.update('UPDATE user_admin SET permissions = ? WHERE id = ?', {
                json.encode(self.permissions), 
                self.id
            }, function()
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
                end
            end)
        end
    end
    for permissionName, _ in pairs(self.permissions) do
        if (not GM.Admin.Permissions[permissionName]) then
            self.permissions[permissionName] = nil
            MySQL.update('UPDATE user_admin SET permissions = ? WHERE id = ?', {
                json.encode(self.permissions), 
                self.id
            }, function()
                for adminSrc,_ in pairs(GM.Admin.inAdmin) do
                    TriggerClientEvent("Admin:updateValue", adminSrc, "ranks", self.id, self)
                end
            end)
        end
    end
end