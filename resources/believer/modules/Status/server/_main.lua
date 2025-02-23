GM.Status = GM.Status or {}

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	local players = ESX.GetPlayers()

	for _,playerId in ipairs(players) do
		local playerSelected = ESX.GetPlayerFromId(playerId)
		if (playerSelected) then

			MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
				['@identifier'] = playerSelected.identifier
			}, function(result)
				local data = {}

				if result[1].status then
					data = json.decode(result[1].status)
				end

				playerSelected.set('status', data)
				TriggerClientEvent('esx_status:load', playerId, data)
			end)
		end
	end
end)

AddEventHandler('esx:playerLoaded', function(playerId, playerSelected)
	MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
		['@identifier'] = playerSelected.identifier
	}, function(result)
		local data = {}

		if result[1].status then
			data = json.decode(result[1].status)
		end

		playerSelected.set('status', data)
		TriggerClientEvent('esx_status:load', playerId, data)
	end)
end)

AddEventHandler('playerDropped', function()
	local playerSrc = source
	if (not playerSrc) then return end

	local playerSelected = ESX.GetPlayerFromId(playerSrc)
	if (not playerSelected) then return end

	local playerIdentifier = playerSelected.getIdentifier()
	if (not playerIdentifier) then return end

	local status = playerSelected.get('status')

	MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
		['@status']     = json.encode(status),
		['@identifier'] = playerIdentifier
	})
end)

AddEventHandler('esx_status:getStatus', function(playerId, statusName, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end
end)

RegisterServerEvent('esx_status:update')
AddEventHandler('esx_status:update', function(status)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.set('status', status)
	end
end)

function SaveData()
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if (xPlayer) then
			local status  = xPlayer.get('status')

			MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
				['@status']     = json.encode(status),
				['@identifier'] = xPlayer.identifier
			})
		end
	end

	SetTimeout(10 * 60 * 1000, SaveData)
end

SaveData()
