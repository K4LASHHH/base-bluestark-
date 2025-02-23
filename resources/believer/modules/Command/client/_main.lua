GM.Command = GM.Command or {}

GM.Command = {
    menu = {
        submenus = {}
    },
    data = {
        list = {},
    },
}

GM.Command.menu.main = RageUI.CreateMenu("", "Liste des commandes", 0, 0, "banner", "bluestark")
GM.Command.menu.main["Closed"] = function()
    -- Todo event when menu closed
end

GM.Command.menu.main:isVisible(function(Items)
	for commandName, command in pairs(GM.Command.data.list) do
		Items:Button(commandName, command.label, {}, true, {})
	end
end)

RegisterNetEvent("Command:openMenu", function(commandData)
	GM.Command.data.list = commandData
    GM.Command.menu.main:toggle()
end)

RegisterNetEvent("Command:keyMapping", function(commandData)
	if (not commandData) then return end

	RegisterCommand(commandData.name, function(source, args)
		TriggerServerEvent("Command:execute", commandData.name, args)
	end)
	RegisterKeyMapping(commandData.name, commandData.description, commandData.keys[1], commandData.keys[2])
end)