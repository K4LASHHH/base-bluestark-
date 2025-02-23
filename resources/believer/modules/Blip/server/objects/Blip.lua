GM.Blip = GM.Blip or {}
GM.Blip["Registered"] = GM.Blip["Registered"] or {}

function GM.Blip:add(position, blipData, metadata)
    if (not position or not blipData) then
        return
    end
    
    local newBlip = {}
    setmetatable(newBlip, self)
    self.__index = self

    newBlip.uniqueId = (#GM.Blip["Registered"] + 1)
    newBlip.position = position
    newBlip.blipData = blipData
    newBlip.metadata = metadata or {}
    
    if (metadata ~= nil and metadata.isPrivate == true) then
        newBlip.allowedPlayers = {}
    else
        TriggerClientEvent("Blip:add", -1, newBlip)
    end

    GM.Blip["Registered"][newBlip.uniqueId] = newBlip
    return newBlip
end

function GM.Blip:getData(dataName)
    return self[dataName] or nil
end

function GM.Blip:setData(dataName, dataValue)
    self[dataName] = dataValue
end

function GM.Blip:allowedPlayer(playerSrc, bool)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (self.allowedPlayers == nil) then
        print("Blip:allowedPlayer - Blip is not private")
        return
    end

    if (bool == nil) then
        if (not self.allowedPlayers[playerSrc]) then
            self.allowedPlayers[playerSrc] = true
            TriggerClientEvent("Blip:add", playerSrc, self)
            return
        else
            TriggerClientEvent("Blip:remove", playerSrc, self.uniqueId)
            self.allowedPlayers[playerSrc] = nil
            return
        end
    end

    if (bool == true) then
        if (not self.allowedPlayers[playerSrc]) then
            self.allowedPlayers[playerSrc] = true
            TriggerClientEvent("Blip:add", playerSrc, self)
            return
        end
    else
        if (self.allowedPlayers[playerSrc]) then
            TriggerClientEvent("Blip:remove", playerSrc, self.uniqueId)
            self.allowedPlayers[playerSrc] = nil
            return
        end
    end
end

function GM.Blip:delete()
    TriggerClientEvent("Blip:remove", -1, self.uniqueId)
    GM.Blip["Registered"][self.uniqueId] = nil
end