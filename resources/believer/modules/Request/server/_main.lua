GM.Request = GM.Request or {}

GM.Request = {
    ["player"] = {},
}

function GM.Request:sendMessage(playerSrc, message)

    while (GM.Request["player"][playerSrc] ~= nil) do
        Wait(50)
        print("PLAYER ALREADY GOT REQUEST (WAITING 50ms) TO SEND NEW ONE")
    end
    
    GM.Request["player"][playerSrc] = true

    TriggerClientEvent("Request:sendMessage", playerSrc, message)

    while (GM.Request["player"][playerSrc] == true) do
        Wait(50)
    end

    local response = GM.Request["player"][playerSrc]

    GM.Request["player"][playerSrc] = nil

    return response
end

function GM.Request:sendCallMessage(playerSrc, sender, subject, textureDict, data)

    while (GM.Request["player"][playerSrc] ~= nil) do
        Wait(150)
    end
    
    GM.Request["player"][playerSrc] = true

    TriggerClientEvent("Request:sendCallMessage", playerSrc, sender, subject, textureDict, data)

    while (GM.Request["player"][playerSrc] == true) do
        Wait(50)
    end

    local response = GM.Request["player"][playerSrc]

    GM.Request["player"][playerSrc] = nil

    return response
end

exports("sendRequest", function(playerSrc, message)
    return GM.Request:sendMessage(playerSrc, message)
end)

RegisterServerEvent("Request:sendResponse", function(response)
    local playerSrc = source
    if (not playerSrc) then return end

    if (GM.Request["player"][playerSrc] == nil) then 
        print("PLAYER DIDN'T GET REQUEST")
        return 
    end

    GM.Request["player"][playerSrc] = response
end)