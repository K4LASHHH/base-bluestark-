GM.Whitelist = GM.Whitelist or {}


GM.Whitelist.Enable = Config.Whitelist or false
GM.Whitelist.List = {}

CreateThread(function()
    MySQL.query("SELECT * FROM user_whitelist", {
    }, function(results)
        for i = 1, #results do
            local selectedResult = results[i]
            
            if (not GM.Whitelist.List[selectedResult.identifier]) then
                GM.Whitelist.List[selectedResult.identifier] = {
                    identifier = selectedResult.identifier,
                    id = selectedResult.id,
                }
            end
        end
    end)
end)

RegisterCommand("whitelist", function(source, args)
    GM.Whitelist.Enable = not GM.Whitelist.Enable
    print("Whitelist is now " .. (GM.Whitelist.Enable and "enabled" or "disabled"))
end)

-- Todo securize this command and add it on the admin menu