GM.Ped = GM.Ped or {}

function GM.Ped:getPedFromNetId(netId)
    if (GM.Ped.List[netId] ~= nil) then
        local entity = NetworkGetEntityFromNetworkId(netId)
        if (entity ~= nil and DoesEntityExist(entity)) then
            return GM.Ped.List[netId]
        end
    end
end

function GM.Ped:getPedsInArea(position, radius)
    local peds = {}
    for _, ped in pairs(GetAllPeds()) do
        local entityCoords = GetEntityCoords(ped)
        if entityCoords ~= nil then
            if #(position-entityCoords) < radius then
                table.insert(peds, ped)
            end
        end
    end
    return peds
end