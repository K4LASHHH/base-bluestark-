GM.Ped = GM.Ped or {}
GM.Ped.List = {}

function GM.Ped:getPedFromNetId(netId)
    if (GM.Ped.List[netId] ~= nil) then
        local entity = NetworkGetEntityFromNetworkId(netId)
        if (entity ~= nil and DoesEntityExist(entity)) then
            return GM.Ped.List[netId]
        end
    end
end

function GM.Ped:create(pedType, modelName, position, heading)
    local newPed = {}
    
    setmetatable(newPed, self)
    self.__index = self

    if (not IsDuplicityVersion()) then
        newPed.isNetwork = false
        RequestModel(modelName)
        while not HasModelLoaded(modelName) do 
            Wait(0) 
        end
    else
        newPed.isNetwork = true
    end

    local createdPed

    createdPed = CreatePed(pedType, modelName, position["x"], position["y"], position["z"], heading, newPed.isNetwork, false)

    while not createdPed or not DoesEntityExist(createdPed) do
        Wait(0)
    end

    if (newPed.isNetwork) then
        newPed.networkId = NetworkGetNetworkIdFromEntity(createdPed)
    else
        newPed.entity = createdPed
    end
    
    self:setBucket(0)

    GM.Ped.List[(newPed.networkId or newPed.entity)] = newPed
    return newPed
end

function GM.Ped:getEntity()
    return self.entity or NetworkGetEntityFromNetworkId(self.networkId)
end

function GM.Ped:getBucket()
    return GetEntityRoutingBucket(self:getEntity())
end

function GM.Ped:setBucket(bucket)
    SetEntityRoutingBucket(self:getEntity(), bucket)
end

function GM.Ped:setPosition(newPos)
    SetEntityCoords(self:getEntity(), newPos)
end

function GM.Ped:setHeading(newHeading)
    SetEntityHeading(self:getEntity(), newHeading)
end

function GM.Ped:freeze(freezeState)
    FreezeEntityPosition(self:getEntity(), freezeState)
end

function GM.Ped:delete()
    if (DoesEntityExist(self:getEntity())) then
        DeleteEntity(self:getEntity())
        GM.Ped.List[self.networkId or self.entity] = nil
    end
end

AddEventHandler("onResourceStop", function(rscName)
    if (rscName ~= GetCurrentResourceName()) then return end

    for _, ped in pairs(GM.Ped.List) do
        ped:delete()
    end
end)