ESX = exports['believer']:getSharedObject()



Citizen.CreateThread(function()
    while true do
        TriggerClientEvent('hud:updateplayers', -1, GetNumPlayerIndices(), GetConvarInt('sv_maxclients', 32))
        Citizen.Wait(30000)
    end
end)