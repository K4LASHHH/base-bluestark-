GM.Maintenance = GM.Maintenance or {}

GM.Maintenance.Enable = Config.Maintenance or false

RegisterCommand("maintenance", function(source, args)
    GM.Maintenance.Enable = not GM.Maintenance.Enable
    print("Maintenance is now " .. (GM.Maintenance.Enable and "enabled" or "disabled"))
end)

-- Todo securize this command and add it on the admin menu