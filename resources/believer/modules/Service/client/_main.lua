GM.Service = GM.Service or {}

GM.Service.onService = false

RegisterNetEvent("Service:sendActivity", function(bool)
    GM.Service.onService = bool
end)

function IsPlayerInService()
    return GM.Service.onService
end

exports("IsPlayerInService", IsPlayerInService)