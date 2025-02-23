GM.Skin = GM.Skin or {}

GM.Skin.BackpackWeight = {
	[40] = 16, 
	[41] = 20, 
	[44] = 25, 
	[45] = 23
}

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local playerSrc = source
	if (not playerSrc) then return end

	local playerSelected = ESX.GetPlayerFromId(playerSrc)
	if (not playerSelected) then return end

	local playerIdentifier = playerSelected.getIdentifier()
	if (not playerIdentifier) then return end

	local defaultMaxWeight = ESX.GetConfig().MaxWeight
	local backpackModifier = GM.Skin.BackpackWeight[skin.bags_1]

	if backpackModifier then
		playerSelected.setMaxWeight(defaultMaxWeight + backpackModifier)
	else
		playerSelected.setMaxWeight(defaultMaxWeight)
	end

	MySQL.update('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = playerIdentifier
	}, function()
		--playerSelected.showNotification("~g~Sauvegarde de votre personnage effectué ✅.")
	end)
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local playerSrc = source
	if (not playerSrc) then return end

	local playerSelected = ESX.GetPlayerFromId(playerSrc)
	if (not playerSelected) then return end

	local playerIdentifier = playerSelected.getIdentifier()
	if (not playerIdentifier) then return end

	MySQL.query('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = playerIdentifier
	}, function(users)
		local user, skin = users[1]

		if user.skin then
			skin = json.decode(user.skin)
		end
		
		cb(skin)
	end)
end)

RegisterServerEvent('esx_skin:setWeight')
AddEventHandler('esx_skin:setWeight', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not ESX.GetConfig().OxInventory then
        local defaultMaxWeight = ESX.GetConfig().MaxWeight
        local backpackModifier = GM.Skin.BackpackWeight[skin.bags_1]

        if backpackModifier then
            xPlayer.setMaxWeight(defaultMaxWeight + backpackModifier)
        else
            xPlayer.setMaxWeight(defaultMaxWeight)
        end
    end
end)

RegisterServerEvent('esx_skin:responseSaveSkin')
AddEventHandler('esx_skin:responseSaveSkin', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == 'admin' then
		local file = io.open('resources/[esx]/esx_skin/skins.txt', "a")

		file:write(json.encode(skin) .. "\n\n")
		file:flush()
		file:close()
	else
		print(('[^2INFO^7] ^5%s^7 attempted saving skin to file'):format(xPlayer.getIdentifier()))
	end
end)