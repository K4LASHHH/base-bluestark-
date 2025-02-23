GM.Zone = GM.Zone or {}
GM.Zone.Management = {}

function GM.Zone:get(zoneId)
    return GM.Zone.List[zoneId] or nil
end

function GM.Zone:getPublic()
    local zones = GM.Zone.List
    local myList = {}
    for i = 1, #zones do
        local selectedZone = zones[i]
        if (selectedZone.isPrivate == false) then
            table.insert(myList, selectedZone)
        end
    end
    return myList
end

function GM.Zone.Management:create(position, radius, helpText, onUsable, metadata)
    local newZone = {}
    setmetatable(newZone, self)
    self.__index = self

    metadata = metadata or {}

    newZone.uniqueId = (#GM.Zone.List + 1)
    GM.Zone.List[tonumber(newZone.uniqueId)] = true

    newZone.position = position
    newZone.radius = radius or 1.5
    newZone.helpText = helpText
    newZone.onUsable = onUsable
    newZone.isPrivate = metadata.private or false
    newZone.marker = metadata.marker

    if (newZone.isPrivate == true) then
        newZone.allowedPlayers = {}
    else
        TriggerClientEvent("Zone:add", -1, newZone)
    end

    GM.Zone.List[tonumber(newZone.uniqueId)] = newZone
    return newZone, newZone.uniqueId
end

function GM.Zone.Management:getData(dataName)
    return self[dataName] or nil
end

function GM.Zone.Management:setData(dataName, dataValue)
    self[dataName] = dataValue

    if (self.isPrivate ~= true) then
        TriggerClientEvent("Zone:updateValue", -1, self.uniqueId, dataName, dataValue)
        return
    end

    for playerSrc, _ in pairs(self.allowedPlayers) do
        TriggerClientEvent("Zone:updateValue", playerSrc, self.uniqueId, dataName, dataValue)
    end
end

function GM.Zone.Management:allowedPlayer(playerSrc, bool)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (self.allowedPlayers == nil) then
        print("Zone:allowedPlayer - Zone is not private")
        return
    end

    if (not bool) then
        if (not self.allowedPlayers[playerSrc]) then
            self.allowedPlayers[playerSrc] = true
            TriggerClientEvent("Zone:add", playerSrc, self)
            return
        else
            TriggerClientEvent("Zone:remove", playerSrc, self.uniqueId)
            self.allowedPlayers[playerSrc] = nil
            return
        end
    end

    if (bool == true) then
        if (not self.allowedPlayers[playerSrc]) then
            self.allowedPlayers[playerSrc] = true
            TriggerClientEvent("Zone:add", playerSrc, self)
            return
        end
    else
        if (self.allowedPlayers[playerSrc]) then
            TriggerClientEvent("Zone:remove", playerSrc, self.uniqueId)
            self.allowedPlayers[playerSrc] = nil
            return
        end
    end
end

function GM.Zone.Management:delete()
    TriggerClientEvent("Zone:remove", -1, self.uniqueId)
    GM.Zone.List[self.uniqueId] = nil
end