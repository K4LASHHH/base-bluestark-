GM.Status = GM.Status or {}

local Status, isPaused = {}, false

function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do
		if minimal then
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / GM.Status.StatusMax) * 100
			})
		else
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / GM.Status.StatusMax) * 100
			})
		end
	end

	return status
end

AddEventHandler('esx_status:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, status)
end)

AddEventHandler('esx_status:unregisterStatus', function(name)
	for k,v in ipairs(Status) do
		if v.name == name then
			table.remove(Status, k)
			break
		end
	end
end)

RegisterNetEvent('esx_status:load')
AddEventHandler('esx_status:load', function(status)
	TriggerEvent("esx_status:registerStatus", "hunger", 1000000, "#CFAD0F", function(status)
		return false
	end, function(status)
		status.remove(75)
	end)
	TriggerEvent("esx_status:registerStatus", "thirst", 1000000, "#0C98F1", function(status)
		return false
	end, function(status)
		status.remove(115)
	end)
	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
		while true do
			for i=1, #Status, 1 do
				Status[i].onTick()
			end

			TriggerEvent('esx_customui:updateStatus', GetStatusData(true))
			Citizen.Wait(GM.Status.TickTime)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth
			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 15 then
						health = health - 5
					else
						health = health - 1
					end
				end
				if status.val == 98000 then
					ESX.ShowNotification("~r~Vous avez mal au ventre.")
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 35 then
						health = health - 5
					else
						health = health - 1
					end
				end
				if status.val == 98000 then
					ESX.ShowNotification("~r~Vous avez mal au ventre.")
				end
			end)

			if health ~= prevHealth then
				--Todo fix this issues when disconnected status not loaded
				--SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

RegisterNetEvent('esx_status:set')
AddEventHandler('esx_status:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:remove')
AddEventHandler('esx_status:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(GM.Status.UpdateInterval)

		TriggerServerEvent('esx_status:update', GetStatusData(true))
	end
end)