GM.Preferences = GM.Preferences or {}

function GM.Preferences:loadPreferences(name) -- use this function to load the preferences
    local preferences = GetResourceKvpString("believer_"..name)

    -- Convert string to boolean

    if (preferences == "true") then
        preferences = true
    elseif (preferences == "false") then
        preferences = false
    end

    if (preferences) then
        return preferences
    else
        return false
    end
end

exports("loadPrerefences", function(name)
    return GM.Preferences:loadPreferences(name)
end)

function GM.Preferences:Save(name, value)
    SetResourceKvp("believer_"..name, tostring(value))
    ESX.ShowNotification("~b~Vous avez mis à jour vos préférences ("..name..").")
end

exports("savePreferences", function(name, value)
    GM.Preferences:Save(name, value)
end)