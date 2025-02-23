GM.Instance = GM.Instance or {}
GM.Instance.List = {}

function GM.Instance:new(enablePopulation, lockdownMode)
    local newInstance = {}

    setmetatable(newInstance, self)
    self.__index = self

    newInstance.id = (#GM.Instance.List + 1)
    GM.Instance.List[newInstance.id] = true
    
    newInstance.players = {}
    newInstance.entities = {}

    newInstance:enablePopulation(enablePopulation)
    newInstance:lockdownMode(lockdownMode)

    GM.Instance.List[newInstance.id] = newInstance
    return newInstance
end

function GM.Instance:enablePopulation(state)
    SetRoutingBucketPopulationEnabled(self.id, state or true)
end

function GM.Instance:lockdownMode(mode) 
    SetRoutingBucketEntityLockdownMode(self.id, mode or "inactive")
end

function GM.Instance:enterPlayer(playerSrc)
    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (self.players[playerSrc] ~= true) then
        SetPlayerRoutingBucket(playerSelected.source, self.id)
        self.players[playerSrc] = true
    else
        SetPlayerRoutingBucket(playerSelected.source, 0)
        self.players[playerSrc] = nil 
    end
end

function GM.Instance:enterEntity(currentEntity)
    if (not DoesEntityExist(currentEntity)) then return end
    if (self.entities[currentEntity] ~= true) then
        SetEntityRoutingBucket(currentEntity, self.id)
        self.entities[currentEntity] = true
    else
        SetEntityRoutingBucket(currentEntity, 0)
        self.entities[currentEntity] = nil 
    end
end