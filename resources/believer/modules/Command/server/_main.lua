GM.Command = GM.Command or {}

GM.Command.List = {}

GM.Command.Callback = {}

function GM.Command:register(commandData, func)
    if (not func or type(func) ~= "function") then return end
    
    if (not GM.Command.List[commandData.name]) then
        GM.Command.List[commandData.name] = {
            name = commandData.name,
            label = commandData.label,
            description = commandData.description,
            permissions = commandData.permissions or true,
            keys = commandData.keys or nil,
        }
        GM.Command.Callback[commandData.name] = func
        TriggerClientEvent("chat:addSuggestion", -1, "/"..commandData.name, commandData.description, {})
    end

    RegisterCommand(commandData.name, function(source, args)
        if (source ~= 0) then
            local playerSelected = ESX.GetPlayerFromId(source)
            if (not playerSelected) then return end

            if (commandData.permissions) then

                local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
                if (not playerRank) then return end

                if (not playerRank:getCommandValue(commandData.name, source)) then return end

            end
        end
        func(source, args)
    end)
end

function GM.Command:getCommandsKeys()
    local commandsKeys = {}
    for commandName, commandValues in pairs(GM.Command.List) do
        if (commandValues.keys) then
            commandsKeys[commandName] = commandValues
        end
    end
    return commandsKeys
end

RegisterNetEvent("Command:execute", function(commandName, commandArgs)
    local playerSrc = source
    if (not playerSrc) then return end

    if (not commandName or not GM.Command.List[commandName]) then return end

    local playerSelected = ESX.GetPlayerFromId(playerSrc)
    if (not playerSelected) then return end

    if (GM.Command.List[commandName].permissions == true) then

        local playerRank = GM.Ranks:getFromId(playerSelected.get("rank_id"))
        if (not playerRank) then return end

        if (not playerRank:getCommandValue(commandName, playerSrc)) then return end
        
    end

    GM.Command.Callback[commandName](playerSrc, table.unpack(commandArgs or {}))
end)

AddEventHandler("esx:playerLoaded", function(playerSrc)
    if (not playerSrc) then return end

    local keysCommands = GM.Command:getCommandsKeys()
    if (not keysCommands) then return end

    for commandName, commandValues in pairs(keysCommands) do
        TriggerClientEvent("Command:keyMapping", playerSrc, commandValues)
    end
end)